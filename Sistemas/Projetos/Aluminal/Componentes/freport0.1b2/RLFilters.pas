{@unit RLFilters - Implementação do filtro padrão de impressão e classes abstratas para filtros de gravação e impressão. }
unit RLFilters;

interface

uses
  Classes, SysUtils, Math, 
{$ifndef LINUX}
  Windows,
{$else}
  Types,
{$endif}
{$ifdef Win32}
  Forms, Dialogs, RLPrinters,
{$else}
  QForms, QDialogs, RLPrintersCLX,
{$endif}
  RLMetaFile, RLConsts, RLTypes, RLUtils, RLFeedBack;

type

  TRLCustomFilter=class;
  TRLCustomPrintFilter=class;
  TRLCustomSaveFilter=class;

  TRLFilterClassOption =(foEmulateCopies);
  TRLFilterClassOptions=set of TRLFilterClassOption;

  { TRLCustomFilter }

  {@class TRLCustomFilter - Classe abstrata ancestral de todos os filtro de gravação e impressão.
   @links TRLHTMLFilter, TRLPDFFilter, TRLRichFilter, TRLDraftFilter. }
  TRLCustomFilter=class(TComponent)
  private

    // variables

    fDisplayName   :string;
    fPages         :TRLGraphicStorage;
    fProgress      :TfrmRLFeedBack;
    fShowProgress  :boolean;
    fCanceled      :boolean;
    fClassOptions  :TRLFilterClassOptions;
    fPhysicalCopies:integer;
    fFromPageNo    :integer;
    fToPageNo      :integer;

    // assign methods

    procedure   SetPages(const Value:TRLGraphicStorage);

    // custom methods

    function    IsDisplayName:boolean;
    procedure   ProgressCanceled(Sender:TObject; var CancelIt:boolean);
    procedure   CreateProgress;
    procedure   DestroyProgress;
    procedure   BoundProgress;
    procedure   StepProgress;
    procedure   DoFilterPages(aThread:TThread);

  protected

    // virtual methods

    procedure   InternalBeginDoc; virtual; abstract;
    procedure   InternalEndDoc; virtual; abstract;
    procedure   InternalNewPage; virtual; abstract;
    procedure   InternalDrawPage(aPage:TRLGraphicSurface); virtual; abstract;

    // override methods

    procedure   Notification(aComponent:TComponent; Operation:TOperation); override;

    //

    property    ClassOptions:TRLFilterClassOptions read fClassOptions write fClassOptions;

  public

    // override methods

    constructor Create(aOwner:TComponent); override;
    destructor  Destroy; override;

    // virtual methods

    {@method GetDisplayLabel - Devolve nome do filtro para exibição em caixas de seleção. :/}
    function    GetDisplayLabel:string; virtual;

    // static methods

    {@method GetDisplayName - Devolve nome do filtro para exibição em tempo de design. :/}
    function    GetDisplayName:string;

    {@method BeginDoc - Inicializa o processo de filtragem. :/}
    procedure   BeginDoc;

    {@method EndDoc - Finaliza o processo de filtragem. :/}
    procedure   EndDoc;

    {@method NewPage - Adiciona uma nova página. :/}
    procedure   NewPage;

    {@method DrawPage - Desenha o conteúdo da superfície informada na página corrente. :/}
    procedure   DrawPage(aPage:TRLGraphicSurface);

    {@method FilterPages - Processa as páginas através do filtro.
     A lista de páginas aPages pode ser obtida na prop Pages de um TRLReport após a preparação do relatório, ou de
     modo avulso criando uma instancia do TRLGraphicStorage e carregando um relatório do disco.
     Os parâmetros aFirstPage e aLastPage são opcionais e indicam o intervalo de páginas a processar.
     @links TRLGraphicStorage, TRLCustomReport.Pages. :/}
    procedure   FilterPages(aPages:TRLGraphicStorage; aFirstPage:integer=1; aLastPage:integer=-1; aBackgroundMode:Boolean=False);

    // custom properties

    {@prop DisplayName - Retorna o nome para exibição em caixas de seleção. :/}
    property    DisplayName:string            read GetDisplayName write fDisplayName stored IsDisplayName;

    {@prop Pages - Referência à coleção de páginas a filtrar. :/}
    property    Pages      :TRLGraphicStorage read fPages         write SetPages;

    {@prop Canceled - Indica se o processo foi interrompido pelo usuário. :/}
    property    Canceled:boolean read fCanceled write fCanceled;

    {@prop ShowProgress - Mostra barra de progresso do salvamento ou impressão. :/}
    property    ShowProgress:boolean read fShowProgress write fShowProgress default true;
  end;
  {/@class}
  

  { TRLCustomPrintFilter }

  {@class TRLCustomPrintFilter - Classe base para filtros de impressão.
   @links TRLDraftFilter. }
  TRLCustomPrintFilter=class(TRLCustomFilter)
  protected

    // virtual methods

    {@method GetOptionsLabel - Devolve texto para opções de filtragem.
     Reescreva este método nos descendentes para informar se há opções de filtragem e qual é o texto para o diálogo. :/}
    function  GetOptionsLabel:string; virtual;

    {@method GetOptions - Devolve lista de opções de filtragem.
     Reescreva este método nos descendentes para informar que opções de filtragem devem aparecer no diálogo. :/}
    function  GetOptions:TStrings; virtual;

    {@method GetOptionIndex - Devolve o índice da opção de filtragem atualmente selecionada.
     Reescreva este método nos descendentes para customizar a seleção de opções. :/}
    function  GetOptionIndex:integer; virtual;

    {@method SetOptionIndex - Altera o índice da opção de filtragem.
     Reescreva este método nos descendentes para customizar a seleção de opções. :/}
    procedure SetOptionIndex(const Value:integer); virtual;

  public

    // custom methods

    {@method SetOrientation - Altera a orientação do papel. :/}
    procedure SetOrientation(aOrientation:TRLPageOrientation); virtual;

    // properties

    {@prop OptionsLabel - Texto para opções de filtragem. :/}
    property  OptionsLabel:string   read GetOptionsLabel;

    {@prop Options - Lista de opções de filtragem. :/}
    property  Options     :TStrings read GetOptions;

    {@prop OptionIndex - Opção default ou selecionada pelo diálogo de impressão. :/}
    property  OptionIndex :integer  read GetOptionIndex write SetOptionIndex;
  end;
  {/@class}
  

  { TRLCustomSaveFilter }

  {@class TRLCustomSaveFilter - Classe base para filtros de salvamento.
   @links TRLHTMLFilter, TRLPDFFilter, TRLRichFilter. }
  TRLCustomSaveFilter=class(TRLCustomFilter)
  private

    // variables

    fFileName  :string;
    fDefaultExt:string;
    
  public

    // constructors & destructors

    constructor Create(aOwner:TComponent); override;

    // properties

    {@prop FileName - Nome do arquivo destino para o filtro de salvamento. :/}
    property    FileName  :string read fFileName   write fFileName;

    {@prop DefaultExt - Extensão padrão para o arquivo destino. :/}
    property    DefaultExt:string read fDefaultExt write fDefaultExt;
  end;
  {/@class}
  
{@var ActiveFilters - Lista de filtros ativos.
 Esta lista contém referências a todos os filtros de impressão e salvamento instanciados.
 @links TRLCustomFilter, SelectedFilter. :/}
var ActiveFilters:TList=nil;

{@func FilterPages - Envia páginas para um filtro de impressão ou salvamento.
 A lista de páginas aPages pode ser obtida na prop Pages de um TRLReport após a preparação do relatório, ou de modo
 avulso criando uma instancia do TRLGraphicStorage e carregando um relatório do disco.
 @links TRLCustomFilter, TRLGraphicStorage, TRLCustomReport.Pages. :/}
procedure FilterPages(aPages:TRLGraphicStorage; aFilter:TRLCustomFilter=nil; aFirstPage:integer=1; aLastPage:integer=-1; aBackgroundMode:Boolean=False);

{@func SaveFilterByFileName - Retorna uma referência para um filtro de salvamento instanciado baseado na extensão
 do nome de arquivo informado.
 @links TRLCustomSaveFilter. :/}
function SaveFilterByFileName(const aFileName:string):TRLCustomSaveFilter;

{/@unit}

implementation

uses
  RLSpoolFilter;

function SaveFilterByFileName(const aFileName:string):TRLCustomSaveFilter;
var
  f:TRLCustomSaveFilter;
  e1,e2:string;
  i:integer;
begin
  Result:=nil;
  e1:=FormatFileExt(ExtractFileExt(aFileName));
  for i:=0 to ActiveFilters.Count-1 do
    if TObject(ActiveFilters[i]) is TRLCustomSaveFilter then
    begin
      f :=TRLCustomSaveFilter(ActiveFilters[i]);
      e2:=FormatFileExt(f.DefaultExt);
      if AnsiSameText(e1,e2) then
      begin
        Result:=f;
        break;
      end;
    end;
end;

procedure FilterPages(aPages:TRLGraphicStorage; aFilter:TRLCustomFilter=nil; aFirstPage:integer=1; aLastPage:integer=-1; aBackgroundMode:Boolean=False);
begin
  if not Assigned(aFilter) then
    aFilter:=SpoolFilter;
  aFilter.FilterPages(aPages,aFirstPage,aLastPage,aBackgroundMode);
end;

{ TFilterThread }

type
  TFilterThread=class(TThread)
  public
    Filter:TRLCustomFilter;
    constructor Create(aFilter:TRLCustomFilter);
    procedure Execute; override;
  end;

constructor TFilterThread.Create(aFilter: TRLCustomFilter);
begin
  FreeOnTerminate:=True;
  Filter         :=aFilter;
  inherited Create(True);
end;

procedure TFilterThread.Execute;
begin
  Filter.DoFilterPages(Self);
end;

{ TRLCustomFilter }

constructor TRLCustomFilter.Create(aOwner: TComponent);
begin
  fDisplayName :='';
  fPages       :=nil;
  fProgress    :=nil;
  fShowProgress:=true;
  fCanceled    :=False;
  fClassOptions:=[];
  //
  inherited;
  //
  ActiveFilters.Add(Self);
end;

destructor TRLCustomFilter.Destroy;
begin
  ActiveFilters.Extract(Self);
  if Assigned(fPages) then
    fPages.Unlink(Self);
  if Assigned(fProgress) then
    fProgress.free;
  //
  inherited;
end;

procedure TRLCustomFilter.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited;
  //
  if Operation=opRemove then
    if aComponent=fPages then
      fPages:=nil;
end;

procedure TRLCustomFilter.BeginDoc;
begin
  InternalBeginDoc;
end;

procedure TRLCustomFilter.EndDoc;
begin
  InternalEndDoc;
  // libera as páginas
  Pages:=nil;
end;

procedure TRLCustomFilter.NewPage;
begin
  InternalNewPage;
end;

procedure TRLCustomFilter.DrawPage(aPage: TRLGraphicSurface);
begin
  InternalDrawPage(aPage);
end;

procedure TRLCustomFilter.DoFilterPages(aThread:TThread);
var
  i,j :integer;
  page:TRLGraphicSurface;
  jump:boolean;
  procedure Call(aMethod:TThreadMethod);
  begin
    if Assigned(aThread) then
      TFilterThread(aThread).Synchronize(aMethod)
    else
      aMethod;
  end;
begin
  if fShowProgress then
    Call(CreateProgress);
  try
    if fShowProgress then
      Call(BoundProgress);
    BeginDoc;
    try
      jump:=False;
      for j:=1 to fPhysicalCopies do
        for i:=fFromPageNo to fToPageNo do
        begin
          if jump then
            NewPage;
          jump:=True;
          page:=Pages[i-1];
          if not Assigned(page) then
            Break;
          DrawPage(page);
          if fShowProgress then
            Call(StepProgress);
          if fCanceled then
            Break;
        end;
    finally
      EndDoc;
    end;
  finally
    if fShowProgress then
      Call(DestroyProgress);
    Pages:=nil;  
  end;
end;

procedure TRLCustomFilter.FilterPages(aPages:TRLGraphicStorage; aFirstPage:integer=1; aLastPage:integer=-1; aBackgroundMode:Boolean=False);
begin
  // configura parâmetros
  fCanceled  :=False;
  fFromPageNo:=Max(1,aFirstPage);
  if aLastPage<>-1 then
    fToPageNo:=Min(aLastPage,aPages.PageCount)
  else
    fToPageNo:=aPages.PageCount;
  if foEmulateCopies in fClassOptions then
    fPhysicalCopies:=RLPrinter.Copies
  else
    fPhysicalCopies:=1;
  //
  Pages:=aPages;
  if aBackgroundMode then
    TFilterThread.Create(Self).Resume
  else
    DoFilterPages(nil);
end;

function TRLCustomFilter.GetDisplayName:string;
begin
  if fDisplayName='' then
    Result:=Name
  else
    Result:=fDisplayName;
end;

function TRLCustomFilter.GetDisplayLabel: string;
begin
  Result:=GetDisplayName;
end;

function TRLCustomFilter.IsDisplayName:boolean;
begin
  Result:=(GetDisplayName<>Name);
end;

procedure TRLCustomFilter.ProgressCanceled(Sender:TObject; var CancelIt:boolean);
begin
  fCanceled:=true;
end;

procedure TRLCustomFilter.CreateProgress;
var
  s:string;
begin
  if Self is TRLCustomPrintFilter then
    s:=LS_PrintingInProgressStr
  else
    s:=LS_FilterInProgressStr;
  fProgress:=TfrmRLFeedBack.Create(s);
  fProgress.Show;
  fProgress.SetFocus;
  fProgress.OnCancel:=ProgressCanceled;
end;

procedure TRLCustomFilter.DestroyProgress;
begin
  FreeObj(fProgress);
end;

procedure TRLCustomFilter.BoundProgress;
begin
  fProgress.Max((fToPageNo-fFromPageNo+1)*fPhysicalCopies);
end;

procedure TRLCustomFilter.StepProgress;
begin
  fProgress.Tick;
end;

procedure TRLCustomFilter.SetPages(const Value:TRLGraphicStorage);
begin
  if Assigned(fPages) then
    fPages.Unlink(Self);
  fPages:=Value;
  if Assigned(fPages) then
    fPages.Link(Self);
end;

{ TRLCustomSaveFilter }

constructor TRLCustomSaveFilter.Create(aOwner: TComponent);
begin
  fFileName  :='';
  fDefaultExt:='';
  //
  inherited;
end;

{ TRLCustomPrintFilter }

function TRLCustomPrintFilter.GetOptionsLabel:string;
begin
  Result:='';
end;

function TRLCustomPrintFilter.GetOptions:TStrings;
begin
  Result:=nil;
end;

function TRLCustomPrintFilter.GetOptionIndex: integer;
begin
  Result:=-1;
end;

procedure TRLCustomPrintFilter.SetOptionIndex(const Value:integer);
begin
end;

procedure TRLCustomPrintFilter.SetOrientation(aOrientation: TRLPageOrientation);
begin
end;

initialization
  // filter instance list
  ActiveFilters:=TList.Create;

finalization
  ActiveFilters.free;

end.

