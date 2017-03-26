{@unit RLPrinters - Implementação do wrapper para o objeto Printer. }
unit RLPrintersCLX;

interface

uses
  Classes, SysUtils, Math,
  QGraphics,
  QPrinters, Types,
  RLConsts, RLTypes, RLUtils;

type
  TRLPrinterWrapper=class
  private
    fPrinters    :TStrings;
    fCustomWidth :double;
    fCustomHeight:double;
    //
    function    GetPrinterIndex:integer;
    procedure   SetPrinterIndex(const Value:integer);
    function    GetCopies:integer;
    procedure   SetCopies(const Value:integer);
    function    GetPrinterName:string;
    procedure   SetPrinterName(const aPrinterName:string);
    function    GetPrinterPort:string;
    procedure   LoadPrintersList(aPrinters:TStrings);
    procedure   PrintersNeeded;
    function    AnyPrinter:boolean;
    function    GetPrinterNames(aIndex:integer):string;
    function    GetPrinterPorts(aIndex:integer):string;
    procedure   SelectSystemPaperSize(aPaperSize:TRLSystemPaperType; aPaperWidthMM,aPaperHeightMM:double; aOrientation:TRLSystemOrientation);
    function    GetCanvas:TCanvas;
  public
    constructor Create;
    destructor  Destroy; override;
    //
    procedure   BeginDoc;
    procedure   EndDoc;
    procedure   AbortDoc;
    //
    procedure   NewPage;
    function    Printers:TStrings;
    procedure   ExecuteSetup;
    function    SetupEnabled:boolean;
    procedure   Refresh;
    //
    procedure   SetPaperSize(aPaperWidthMM,aPaperHeightMM:double; aOrientationLandscape:boolean; aForceEmulation:boolean);
    procedure   LoadMetrics(var aPrinterMetrics:TRLPrinterMetrics);
    //
    property    PrinterIndex:integer     read GetPrinterIndex write SetPrinterIndex;
    property    PrinterName :string      read GetPrinterName  write SetPrinterName;
    property    PrinterPort :string      read GetPrinterPort;
    property    Copies      :integer     read GetCopies       write SetCopies;
    property    Canvas      :TCanvas     read GetCanvas;
    //
    property    PrinterNames[aIndex:integer]:string read GetPrinterNames;
    property    PrinterPorts[aIndex:integer]:string read GetPrinterPorts;
  end;

function RLPrinter:TRLPrinterWrapper;

implementation

var
  WarningDisplayed :boolean;
  RLPrinterInstance:TRLPrinterWrapper;

// UTILS

function RLPrinter:TRLPrinterWrapper;
begin
  if not Assigned(RLPrinterInstance) then
    RLPrinterInstance:=TRLPrinterWrapper.Create;
  Result:=RLPrinterInstance;
end;

function TruePrinterName(const aPrinterName:string):string;
var
  i:integer;
begin
  i:=Pos(' on ',aPrinterName);
  if i>0 then
    Result:=Copy(aPrinterName,1,i-1)
  else
    Result:=aPrinterName;
end;

function TruePrinterPort(const aPrinterName:string):string;
var
  i:integer;
begin
  i:=Pos(' on ',aPrinterName);
  if i>0 then
    Result:=Copy(aPrinterName,i+4,length(aPrinterName))
  else
    Result:=aPrinterName;
end;

{ TPrinterEx }


{ TRLPrinterWrapper }

constructor TRLPrinterWrapper.Create;
begin
  fPrinters:=nil;
  //
  inherited;
end;

destructor TRLPrinterWrapper.Destroy;
begin
  if Assigned(fPrinters) then
    fPrinters.free;
  //
  inherited;
end;

procedure TRLPrinterWrapper.PrintersNeeded;
begin
  if not Assigned(fPrinters) then
  begin
    fPrinters:=TStringList.Create;
    LoadPrintersList(fPrinters);
  end;
end;

procedure TRLPrinterWrapper.BeginDoc;
begin
  Printer.BeginDoc;
  Printer.Canvas.Font.PixelsPerInch:=Printer.YDPI;
end;

procedure TRLPrinterWrapper.EndDoc;
var
  savedprinterindex:integer;
begin
  // Na CLX o método EndDoc destroi o objeto PrinterAdapter.
  // Com isso se perde a referência para o OutputDevice escolhido. Nele se baseia o nosso PrinterIndex.
  // Temos que salvá-lo aqui e restaurar depois do EndDoc.
  savedprinterindex:=PrinterIndex;
  Printer.EndDoc;
  PrinterIndex:=savedprinterindex;
end;

procedure TRLPrinterWrapper.AbortDoc;
begin
  Printer.Abort;
end;

procedure TRLPrinterWrapper.NewPage;
begin
  Printer.NewPage;
end;

function TRLPrinterWrapper.GetCanvas:TCanvas;
begin
  Result:=Printer.Canvas;
end;

procedure TRLPrinterWrapper.SelectSystemPaperSize(aPaperSize:TRLSystemPaperType; aPaperWidthMM,aPaperHeightMM:double; aOrientation:TRLSystemOrientation);
begin
  Printer.PrintAdapter.PageSize:=aPaperSize;
  // adaptação de dimensões para o componente
  if aPaperSize=UserPaperCode then
  begin
    {
    if aPaperWidthMM<>0 then
      Printer.PrintAdapter.PageWidth:=aPaperWidthMM;
    if aPaperHeightMM<>0 then
      Printer.PrintAdapter.PageHeight:=aPaperHeightMM;
    }
  end;
  // orientação do papel
  Printer.Orientation:=aOrientation;
end;

procedure TRLPrinterWrapper.SetPaperSize(aPaperWidthMM,aPaperHeightMM:double;
  aOrientationLandscape:boolean; aForceEmulation:boolean);
var
  ResultPaperSize  :TRLSystemPaperType;
  ResultPaperWidth :double;
  ResultPaperHeight:double;
  ResultOrientation:TRLSystemOrientation;
begin
  DetectPaperSize(aPaperWidthMM,aPaperHeightMM,aOrientationLandscape,aForceEmulation,
    ResultPaperSize,ResultPaperWidth,ResultPaperHeight,ResultOrientation);
  SelectSystemPaperSize(ResultPaperSize,ResultPaperWidth,ResultPaperHeight,ResultOrientation);
  fCustomWidth :=aPaperWidthMM;
  fCustomHeight:=aPaperHeightMM;
end;

procedure TRLPrinterWrapper.LoadMetrics(var aPrinterMetrics:TRLPrinterMetrics);
begin
  try
    if not AnyPrinter then
      raise Exception.Create(LS_PrinterNotFoundStr);
    aPrinterMetrics.PPIX          :=Printer.XDPI;
    aPrinterMetrics.PPIY          :=Printer.YDPI;
    if Printer.PageWidth=0 then
      aPrinterMetrics.PhysicalWidth:=Round(fCustomWidth*aPrinterMetrics.PPIX/InchAsMM)
    else
      aPrinterMetrics.PhysicalWidth:=Printer.PageWidth;
    if Printer.PageHeight=0 then
      aPrinterMetrics.PhysicalHeight:=Round(fCustomHeight*aPrinterMetrics.PPIY/InchAsMM)
    else
      aPrinterMetrics.PhysicalHeight:=Printer.PageHeight;
    aPrinterMetrics.MarginLeft    :=Printer.Margins.CX;
    aPrinterMetrics.MarginTop     :=Printer.Margins.CY;
    aPrinterMetrics.MarginRight   :=aPrinterMetrics.MarginLeft;
    aPrinterMetrics.MarginBottom  :=aPrinterMetrics.MarginTop;
    aPrinterMetrics.ClientWidth   :=aPrinterMetrics.PhysicalWidth -(aPrinterMetrics.MarginLeft+aPrinterMetrics.MarginRight);
    aPrinterMetrics.ClientHeight  :=aPrinterMetrics.PhysicalHeight-(aPrinterMetrics.MarginTop+aPrinterMetrics.MarginBottom);
  except
    on e:Exception do
    begin
      // configuração padrão da "HP LaserJet Plus"
      aPrinterMetrics.PPIX          :=300;
      aPrinterMetrics.PPIY          :=300;
      aPrinterMetrics.PhysicalWidth :=2550;
      aPrinterMetrics.PhysicalHeight:=3300;
      aPrinterMetrics.MarginLeft    :=75;
      aPrinterMetrics.MarginTop     :=75;
      aPrinterMetrics.MarginRight   :=aPrinterMetrics.MarginLeft;
      aPrinterMetrics.MarginBottom  :=aPrinterMetrics.MarginTop;
      aPrinterMetrics.ClientWidth   :=aPrinterMetrics.PhysicalWidth -(aPrinterMetrics.MarginLeft+aPrinterMetrics.MarginRight);
      aPrinterMetrics.ClientHeight  :=aPrinterMetrics.PhysicalHeight-(aPrinterMetrics.MarginTop+aPrinterMetrics.MarginBottom);
      //
      if not WarningDisplayed then
      begin
        //ShowMessage(LS_LoadDefaultConfigStr+#13#13+'Mensagem: '+e.Message);
        WarningDisplayed:=True;
      end;
    end;
  end;
end;

function TRLPrinterWrapper.Printers:TStrings;
begin
  PrintersNeeded;
  Result:=fPrinters;
end;

function TRLPrinterWrapper.GetPrinterNames(aIndex:integer):string;
begin
  Result:=Token(Printers[aIndex],1,'|');
end;

function TRLPrinterWrapper.GetPrinterPorts(aIndex:integer):string;
begin
  Result:=Token(Printers[aIndex],2,'|');
end;

procedure TRLPrinterWrapper.LoadPrintersList(aPrinters:TStrings);
var
  i:integer;
  s:string;
begin
  aPrinters.Clear;
  with TStringList.Create do
    try
      LoadFromFile('/etc/printcap');
      for i:=0 to Count-1 do
      begin
        s:=Trim(Strings[i]);
        if (s<>'') and not (s[1] in [':','|','#']) then
          if Pos('|',s)>0 then
            aPrinters.Add(Copy(s,1,Pos('|',s)-1))
          else if Pos(':',s)>0 then
            aPrinters.Add(Copy(s,1,Pos(':',s)-1))
          else
            aPrinters.Add(s);
      end;
    finally
      Free;
    end;
end;

function TRLPrinterWrapper.AnyPrinter:boolean;
begin
  if Printer.PrintAdapter.OutputDevice='' then
    if Printers.Count>0 then
      Printer.SetPrinter(PrinterNames[0]);
  Result:=(Printer.PrintAdapter.OutputDevice<>'');
end;


function GetPrinterDevice(Index:integer):string;
var
  l:TStringList;
  i,p:integer;
  s:string;
begin
  Result:='';
  l:=TStringList.Create;
  try
    l.LoadFromFile('/etc/printcap');
    p:=-1;
    for i:=0 to l.Count-1 do
    begin
      s:=Trim(l[i]);
      if s<>'' then
      begin
        if not (s[1] in [':','|','#']) then
          Inc(p);
        if (Copy(s,1,4)=':sd=') and (p=Index) then
          Result:=Copy(s,5,MaxInt);
      end;
    end;
  finally
    l.Free;
  end;
end;

function TRLPrinterWrapper.GetPrinterPort:string;
begin
  if not AnyPrinter then
    Result:=''
  else if (PrinterIndex<0) or not (PrinterIndex<Printers.Count) then
    Result:=''
  else
    Result:=GetPrinterDevice(PrinterIndex);
end;

function TRLPrinterWrapper.GetPrinterName:string;
begin
  if not AnyPrinter then
    Result:=''
  else if (PrinterIndex<0) or not (PrinterIndex<Printers.Count) then
    Result:=''
  else
    Result:=Token(Printers[PrinterIndex],1,'|');
end;

procedure TRLPrinterWrapper.SetPrinterName(const aPrinterName:string);
var
  n:string;
  i:integer;
begin
  n:=TruePrinterName(Token(aPrinterName,1,'|'));
  for i:=0 to Printers.Count-1 do
    if AnsiSameText(TruePrinterName(Token(Printers[i],1,'|')),n) then
    begin
      SetPrinterIndex(i);
      break;
    end;
end;

function TRLPrinterWrapper.GetPrinterIndex:integer;
var
  i:integer;
begin
  AnyPrinter;
  Result:=-1;
  for i:=0 to Printer.Printers.Count-1 do
    if AnsiSameText(TruePrinterName(PrinterNames[i]),Printer.OutputDevice) then
    begin
      Result:=i;
      break;
    end;
end;

procedure TRLPrinterWrapper.SetPrinterIndex(const Value:integer);
begin
  PrintersNeeded;
  if (Value>=0) and (Value<Printers.Count) then
    Printer.SetPrinter(PrinterNames[Value]);
end;

procedure TRLPrinterWrapper.Refresh;
begin
  if Assigned(fPrinters) then
    fPrinters.free;
  fPrinters:=nil;
end;

function TRLPrinterWrapper.GetCopies:integer;
begin
  Result:=Max(1,Printer.Copies);
end;

procedure TRLPrinterWrapper.SetCopies(const Value:integer);
begin
  Printer.Copies:=Value;
end;

function TRLPrinterWrapper.SetupEnabled:boolean;
begin
  Result:=False;
end;

procedure TRLPrinterWrapper.ExecuteSetup;
begin
  Refresh;
end;

initialization
  WarningDisplayed :=False;
  RLPrinterInstance:=nil;

finalization
  if Assigned(RLPrinterInstance) then
    RLPrinterInstance.free;

end.

