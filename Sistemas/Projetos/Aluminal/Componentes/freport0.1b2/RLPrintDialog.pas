{@unit RLPrintDialog - Implementação do diálogo de impressão e sua classe de setup. }
unit RLPrintDialog;

interface

uses
  Classes, SysUtils,
{$ifndef LINUX}
  Windows,
{$endif}
{$ifdef Win32}
  Messages, Graphics, Controls, Forms, Dialogs, StdCtrls, RLPrinters,
{$else}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, RLPrintersCLX,
{$endif}
  RLFilters, RLConsts, RLTypes;

type
  {@type TRLPrintDialogOptions - Opções de configuração do diálogo de impressão.
  Pode ser um conjunto dos seguintes valores:
  rpoPrintToFile - Mostrar a opção de impressão em arquivo;
  rpoPageNums - Mostrar a seleção de páginas por intervalo;
  rpoSelection - Mostrar a seleção de páginas por números específicos;
  rpoWarning - Exibir mensagens de advertência;
  rpoHelp - Utilizar ajuda do sistema;
  rpoDisablePrintToFile - Desabilitar opção de impressão em arquivo;
  rpoDisableCopies - Desabilitar a opção de número de cópias;
  rpoDisablePrintInBackground - Desabilitar a opção de impressão em segundo plano.
  :}
  TRLPrintDialogOption =(rpoPrintToFile,rpoPageNums,rpoSelection,rpoWarning,rpoHelp,rpoDisablePrintToFile,rpoDisableCopies,rpoDisablePrintInBackground);
  TRLPrintDialogOptions=set of TRLPrintDialogOption;
  {/@type}

  {@type TRLPrintRange - Opções para o modo seleção de páginas.
  Pode ser um dos seguintes valores:
  rprAllPages - Imprimir todas as páginas;
  rprSelection - Imprimir as páginas de números indicados;
  rprPageNums - Imprimir o intervalo de páginas indicado.
  :/}
  TRLPrintRange=(rprAllPages,rprSelection,rprPageNums);

const
  DefaultPrintOptions=[rpoPrintToFile,rpoPageNums,rpoSelection,rpoWarning,rpoDisablePrintToFile];

type
  TRLPrintDialog = class(TForm)
    GroupBoxPrinter: TGroupBox;
    ComboBoxPrinterNames: TComboBox;
    LabelPrinterName: TLabel;
    GroupBoxPages: TGroupBox;
    GroupBoxCopies: TGroupBox;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    RadioButtonPagesAll: TRadioButton;
    RadioButtonPagesInterval: TRadioButton;
    RadioButtonPagesSelect: TRadioButton;
    LabelFromPage: TLabel;
    EditFromPage: TEdit;
    LabelToPage: TLabel;
    EditToPage: TEdit;
    LabelCopies: TLabel;
    EditCopies: TEdit;
    CheckBoxPrintToFile: TCheckBox;
    ComboBoxFilters: TComboBox;
    LabelFilterName: TLabel;
    LabelOptions: TLabel;
    ComboBoxOptions: TComboBox;
    CheckBoxPrintInBackground: TCheckBox;
    procedure EditFromPageChange(Sender: TObject);
    procedure ComboBoxFiltersChange(Sender: TObject);
  private
    { Private declarations }
    procedure LoadEditors;
    procedure SaveEditors;
    procedure LoadPrinterList;
    procedure LoadFilterList;
    procedure Init;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(aOwner:TComponent); override;
    function Execute:boolean;
  end;

  {@class TRLPrintDialogSetup - Opções do diálogo de impressão.
   O diálogo de impressão obedecerá as configurações da instância deste componente. Com ele, é
   possível estabelecer o número de cópias inicial e configurar alguns itens de comportamento do
   diálogo de impressão.
   @pub}
  TRLPrintDialogSetup=class(TComponent)
  private
    { Private declarations }
    function  GetCopies: integer;
    function  GetOptions: TRLPrintDialogOptions;
    function  GetPrintInBackground: boolean;
    procedure SetCopies(const Value: integer);
    procedure SetOptions(const Value: TRLPrintDialogOptions);
    procedure SetPrintInBackground(const Value: boolean);
    function  GetFilter: TRLCustomPrintFilter;
    function  GetPrintToFile: boolean;
    procedure SetFilter(const Value: TRLCustomPrintFilter);
    procedure SetPrintToFile(const Value: boolean);
  public
    { Public declarations }
  published
    {@prop Options - Opções diversas do diálogo de impressão. @links TRLPrintDialogOptions. :/}
    property Options:TRLPrintDialogOptions read GetOptions write SetOptions default DefaultPrintOptions;
    {@prop Copies - Indica o valor inicial para o número de cópias. :/}
    property Copies:integer read GetCopies write SetCopies default 1;
    {@prop PrintInBackground - Indica o valor inicial para a opção de imprimir em segundo plano. :/}
    property PrintInBackground:boolean read GetPrintInBackground write SetPrintInBackground default False;
    {@prop PrintToFile - Indica o estado inicial para a opção de imprimir em arquivo. :/}
    property PrintToFile:boolean read GetPrintToFile write SetPrintToFile default False;
    {@prop Filter - Indica o filtro a oferecer no diálogo. @links TRLCustomPrintFilter:/}
    property Filter:TRLCustomPrintFilter read GetFilter write SetFilter;
  end;
  {/@class}

  {@class TRLPrintParams - Parâmetros de impressão.}
  TRLPrintParams=class(TComponent)
  private
    fMaxPage          :integer;
    fToPage           :integer;
    fMinPage          :integer;
    fFromPage         :integer;
    fOptions          :TRLPrintDialogOptions;
    fPrintRange       :TRLPrintRange;
    fPrintToFile      :boolean;
    fPrintInBackground:boolean;
    fFileName         :string;
    fOrientation      :TRLPageOrientation;
    fFilter           :TRLCustomPrintFilter;
    fHelpContext      :integer;
    fCopies           :integer;
    //
    procedure SetMaxPage(const Value: integer);
    procedure SetFilter(const Value: TRLCustomPrintFilter);
    procedure SetCopies(const Value: integer);
  protected
    { Protected declarations }
    procedure Notification(Component:TComponent; Operation:TOperation); override;
  public
    { Public declarations }
    constructor Create(aOwner:TComponent); override;
    destructor  Destroy; override;
    {@method Clear - Preenche todas as props com valores default.:/}
    procedure Clear;
    {@method Apply - Aplica as configurações ao relatório em andamento.:/}
    procedure Apply;
  published
    {@prop Options - Opções diversas do diálogo de impressão. @links TRLPrintDialogOptions. :/}
    property  Options          :TRLPrintDialogOptions read fOptions           write fOptions default DefaultPrintOptions;
    {@prop MaxPage - Máximo para número de página final. :/}
    property  MaxPage          :integer               read fMaxPage           write SetMaxPage;
    {@prop MinPage - Mínimo para número de página inicial. :/}
    property  MinPage          :integer               read fMinPage           write fMinPage;
    {@prop FromPage - Número selecionado pelo usuário como página inicial. :/}
    property  FromPage         :integer               read fFromPage          write fFromPage;
    {@prop ToPage - Número selecionado pelo usuário como página final. :/}
    property  ToPage           :integer               read fToPage            write fToPage;
    {@prop PrintRange - Modo de seleção de páginas. @links TRLPrintRange:/}
    property  PrintRange       :TRLPrintRange         read fPrintRange        write fPrintRange;
    {@prop Copies - Indica o valor inicial para o número de cópias. :/}
    property  Copies           :integer               read fCopies            write SetCopies default 1;
    {@prop PrintToFile - Imprimir para arquivo.:/}
    property  PrintToFile      :boolean               read fPrintToFile       write fPrintToFile;
    {@prop PrintInBackground - Imprimir em segundo plano.:/}
    property  PrintInBackground:boolean               read fPrintInBackground write fPrintInBackground;
    {@prop FileName - Nome do arquivo a gerar.:/}
    property  FileName         :string                read fFileName          write fFileName;
    {@prop Orientation - Orientação do papel. @links TRLPageOrientation:/}
    property  Orientation      :TRLPageOrientation    read fOrientation       write fOrientation;
    {@prop Filter - Filtro atualmente selecionado. @links TRLCustomPrintFilter:/}
    property  Filter           :TRLCustomPrintFilter  read fFilter            write SetFilter;
    {@prop HelpContext - Contexto de ajuda.:/}
    property  HelpContext      :integer               read fHelpContext       write fHelpContext;
  end;
  {/@class}

{@var PrintParams - Parâmetros de impressão atuais. @links TRLPrintParams:/}
var PrintParams:TRLPrintParams=nil;

{/@unit}

implementation

//{$R *.DFM}

// UTILS

function IntToEmptyStr(aInt:integer):string;
begin
  if aInt=0 then
    Result:=''
  else
    Result:=IntToStr(aInt);
end;

function EmptyStrToInt(const aStr:string):integer;
begin
  Result:=StrToIntDef(aStr,0);
end;

{ TRLPrintDialog }

// OVERRIDE

constructor TRLPrintDialog.Create(aOwner:TComponent);
begin
  inherited CreateNew(aOwner);
  //
  Init;
end;

// PUBLIC

function TRLPrintDialog.Execute:boolean;
begin
  LoadPrinterList;
  LoadFilterList;
  LoadEditors;
  ActiveControl:=ComboBoxPrinterNames;
  Result:=(ShowModal=mrOk);
  if Result then
    SaveEditors;
end;

// PRIVATE

procedure TRLPrintDialog.Init;
begin
  Left := 324;
  Top := 372;
{$ifdef Win32}
  BorderStyle := bsDialog;
{$else}
  BorderStyle := fbsDialog;
{$endif};
  Caption := 'Imprimir';
  ClientHeight := 267;
  ClientWidth := 430;
  Color := clBtnFace;
  Font.Charset := DEFAULT_CHARSET;
  Font.Color := clWindowText;
  Font.Height := -11;
  Font.Name := 'MS Sans Serif';
  Font.Style := [];
  Position := poScreenCenter;
  Scaled := False;
  PixelsPerInch := 96;
  GroupBoxPrinter:=TGroupBox.Create(Self);
  with GroupBoxPrinter do
  begin
    Name := 'GroupBoxPrinter';
    Parent := Self;
    Left := 8;
    Top := 4;
    Width := 413;
    Height := 113;
    Caption := ' Impressora ';
    TabOrder := 0;
    LabelPrinterName:=TLabel.Create(Self);
    with LabelPrinterName do
    begin
      Name := 'LabelPrinterName';
      Parent := GroupBoxPrinter;
      Left := 12;
      Top := 24;
      Width := 31;
      Height := 13;
      Caption := '&Nome:';
      FocusControl := ComboBoxPrinterNames;
    end;
    ComboBoxPrinterNames:=TComboBox.Create(Self);
    with ComboBoxPrinterNames do
    begin
      Name := 'ComboBoxPrinterNames';
      Parent := GroupBoxPrinter;
      Left := 68;
      Top := 20;
      Width := 329;
      Height := 21;
      Style := csDropDownList;
      ItemHeight := 13;
      TabOrder := 0;
    end;
    LabelFilterName:=TLabel.Create(Self);
    with LabelFilterName do
    begin
      Name := 'LabelFilterName';
      Parent := GroupBoxPrinter;
      Left := 12;
      Top := 48;
      Width := 47;
      Height := 13;
      Caption := 'Usar &filtro:';
      FocusControl := ComboBoxPrinterNames;
    end;
    ComboBoxFilters:=TComboBox.Create(Self);
    with ComboBoxFilters do
    begin
      Name := 'ComboBoxFilters';
      Parent := GroupBoxPrinter;
      Left := 68;
      Top := 44;
      Width := 177;
      Height := 21;
      Style := csDropDownList;
      TabOrder := 1;
      OnChange := ComboBoxFiltersChange;
    end;
    LabelOptions:=TLabel.Create(Self);
    with LabelOptions do
    begin
      Name := 'LabelOptions';
      Parent := GroupBoxPrinter;
      Left := 264;
      Top := 48;
      Width := 40;
      Height := 13;
      Alignment := taRightJustify;
      Caption := 'Opções:';
      FocusControl := ComboBoxOptions;
    end;
    ComboBoxOptions:=TComboBox.Create(Self);
    with ComboBoxOptions do
    begin
      Name := 'ComboBoxOptions';
      Parent := GroupBoxPrinter;
      Left := 308;
      Top := 44;
      Width := 89;
      Height := 21;
      Style := csDropDownList;
      ItemHeight := 13;
      TabOrder := 2;
    end;
    CheckBoxPrintToFile:=TCheckBox.Create(Self);
    with CheckBoxPrintToFile do
    begin
      Name := 'CheckBoxPrintToFile';
      Parent := GroupBoxPrinter;
      Left := 12;
      Top := 68;
      Width := 325;
      Height := 17;
      Caption := 'Imprimir em arquivo';
      TabOrder := 3;
    end;
    CheckBoxPrintInBackground:=TCheckBox.Create(Self);
    with CheckBoxPrintInBackground do
    begin
      Name := 'CheckBoxPrintInBackground';
      Parent := GroupBoxPrinter;
      Left := 12;
      Top := 88;
      Width := 325;
      Height := 17;
      Caption := 'Imprimir em segundo plano';
      TabOrder := 4;
    end;
  end;
  GroupBoxPages:=TGroupBox.Create(Self);
  with GroupBoxPages do
  begin
    Name := 'GroupBoxPages';
    Parent := Self;
    Left := 8;
    Top := 120;
    Width := 217;
    Height := 101;
    Caption := ' Intervalo de impressão ';
    TabOrder := 1;
    LabelFromPage:=TLabel.Create(Self);
    with LabelFromPage do
    begin
      Name := 'LabelFromPage';
      Parent := GroupBoxPages;
      Left := 72;
      Top := 49;
      Width := 15;
      Height := 13;
      Caption := '&de:';
      FocusControl := EditFromPage;
    end;
    LabelToPage:=TLabel.Create(Self);
    with LabelToPage do
    begin
      Name := 'LabelToPage';
      Parent := GroupBoxPages;
      Left := 140;
      Top := 49;
      Width := 18;
      Height := 13;
      Caption := '&até:';
      FocusControl := EditToPage;
    end;
    RadioButtonPagesAll:=TRadioButton.Create(Self);
    with RadioButtonPagesAll do
    begin
      Name := 'RadioButtonPagesAll';
      Parent := GroupBoxPages;
      Left := 12;
      Top := 24;
      Width := 113;
      Height := 17;
      Caption := '&Tudo';
      Checked := True;
      TabOrder := 0;
      TabStop := True;
    end;
    RadioButtonPagesInterval:=TRadioButton.Create(Self);
    with RadioButtonPagesInterval do
    begin
      Name := 'RadioButtonPagesInterval';
      Parent := GroupBoxPages;
      Left := 12;
      Top := 48;
      Width := 61;
      Height := 17;
      Caption := 'Páginas';
      TabOrder := 1;
    end;
    RadioButtonPagesSelect:=TRadioButton.Create(Self);
    with RadioButtonPagesSelect do
    begin
      Name := 'RadioButtonPagesSelect';
      Parent := GroupBoxPages;
      Left := 12;
      Top := 72;
      Width := 73;
      Height := 17;
      Caption := '&Seleção';
      TabOrder := 2;
    end;
    EditFromPage:=TEdit.Create(Self);
    with EditFromPage do
    begin
      Name := 'EditFromPage';
      Parent := GroupBoxPages;
      Left := 92;
      Top := 44;
      Width := 41;
      Height := 21;
      TabStop := False;
      TabOrder := 3;
      Text := '1';
      OnChange := EditFromPageChange;
    end;
    EditToPage:=TEdit.Create(Self);
    with EditToPage do
    begin
      Name := 'EditToPage';
      Parent := GroupBoxPages;
      Left := 164;
      Top := 44;
      Width := 41;
      Height := 21;
      TabStop := False;
      TabOrder := 4;
      OnChange := EditFromPageChange;
    end;
  end;
  GroupBoxCopies:=TGroupBox.Create(Self);
  with GroupBoxCopies do
  begin
    Name := 'GroupBoxCopies';
    Parent := Self;
    Left := 236;
    Top := 120;
    Width := 185;
    Height := 101;
    Caption := ' Cópias ';
    TabOrder := 2;
    LabelCopies:=TLabel.Create(Self);
    with LabelCopies do
    begin
      Name := 'LabelCopies';
      Parent := GroupBoxCopies;
      Left := 12;
      Top := 24;
      Width := 89;
      Height := 13;
      Caption := 'Número de &cópias:';
    end;
    EditCopies:=TEdit.Create(Self);
    with EditCopies do
    begin
      Name := 'EditCopies';
      Parent := GroupBoxCopies;
      Left := 108;
      Top := 20;
      Width := 49;
      Height := 21;
      TabOrder := 0;
      Text := '1';
    end;
  end;
  ButtonOk:=TButton.Create(Self);
  with ButtonOk do
  begin
    Name := 'ButtonOk';
    Parent := Self;
    Left := 260;
    Top := 232;
    Width := 75;
    Height := 25;
    Caption := 'OK';
    Default := True;
    ModalResult := 1;
    TabOrder := 3;
  end;
  ButtonCancel:=TButton.Create(Self);
  with ButtonCancel do
  begin
    Name := 'ButtonCancel';
    Parent := Self;
    Left := 344;
    Top := 232;
    Width := 75;
    Height := 25;
    Cancel := True;
    Caption := 'Cancelar';
    ModalResult := 2;
    TabOrder := 4;
  end;
  //
  Caption                          :=LS_PrintStr;
  GroupBoxPrinter.Caption          :=' '+LS_PrinterStr+' ';
  LabelPrinterName.Caption         :=LS_NameStr+':';
  LabelFilterName.Caption          :=LS_UseFilterStr+':';
  CheckBoxPrintToFile.Caption      :=LS_PrintToFileStr;
  CheckBoxPrintInBackground.Caption:=LS_PrintInBackgroundStr;
  GroupBoxPages.Caption            :=' '+LS_PageRangeStr+' ';
  LabelFromPage.Caption            :=LS_RangeFromStr+':';
  LabelToPage.Caption              :=LS_RangeToStr+':';
  RadioButtonPagesAll.Caption      :=LS_AllStr;
  RadioButtonPagesInterval.Caption :=LS_PagesStr;
  RadioButtonPagesSelect.Caption   :=LS_SelectionStr;
  GroupBoxCopies.Caption           :=' '+LS_CopiesStr+' ';
  EditCopies.Text                  :='';
  LabelCopies.Caption              :=LS_NumberOfCopiesStr+':';
  ButtonOk.Caption                 :=LS_OkStr;
  ButtonCancel.Caption             :=LS_CancelStr;
  LabelOptions.Visible             :=False;
  ComboBoxOptions.Visible          :=False;
end;

procedure TRLPrintDialog.LoadPrinterList;
var
  i,j:integer;
  n,p:string;
begin
  ComboBoxPrinterNames.Items.Clear;
  j:=0;
  RLPrinter.Refresh;
  for i:=0 to RLPrinter.Printers.Count-1 do
  begin
    n:=RLPrinter.PrinterNames[i];
    if n=RLPrinter.PrinterName then
      j:=i;
    p:=RLPrinter.PrinterPorts[i];
    if (p<>'') and (p<>n) then
      n:=n+' '+LS_AtStr+' '+p;
    ComboBoxPrinterNames.Items.Add(n);
  end;  
  ComboBoxPrinterNames.ItemIndex:=j
end;

procedure TRLPrintDialog.LoadFilterList;
var
  i,j,p:integer;
  n:string;
  f:TRLCustomPrintFilter;
begin
  ComboBoxFilters.Items.Clear;
  ComboBoxFilters.Items.AddObject(LS_DefaultStr,nil);
  //
  j:=0;
  for i:=0 to ActiveFilters.Count-1 do
    if TObject(ActiveFilters[i]) is TRLCustomPrintFilter then
    begin
      f:=TRLCustomPrintFilter(ActiveFilters[i]);
      n:=f.GetDisplayLabel;
      if n<>'' then
      begin
        p:=ComboBoxFilters.Items.AddObject(n,f);
        if Assigned(PrintParams.Filter) and (PrintParams.Filter=f) then
          j:=p;
      end;      
    end;
  //
  ComboBoxFilters.ItemIndex:=j;
  if ComboBoxFilters.Items.Count<=1 then
  begin
    ComboBoxFilters.Enabled:=False;
    ComboBoxFilters.Color  :=Self.Color;
  end;
  ComboBoxFiltersChange(ComboBoxFilters);
end;

procedure TRLPrintDialog.LoadEditors;
const
  StateColors:array[boolean] of TColor=(clBtnFace,clWindow);
begin
  case PrintParams.PrintRange of
    rprAllPages : RadioButtonPagesAll.Checked     :=True;
    rprSelection: RadioButtonPagesSelect.Checked  :=True;
    rprPageNums : RadioButtonPagesInterval.Checked:=True;
  end;
  EditFromPage.Text                :=IntToEmptyStr(PrintParams.FromPage);
  EditToPage.Text                  :=IntToEmptyStr(PrintParams.ToPage);
  EditCopies.Text                  :=IntToEmptyStr(PrintParams.Copies);
  EditCopies.Enabled               :=not (rpoDisableCopies in PrintParams.Options);
  EditCopies.Color                 :=StateColors[EditCopies.Enabled];
  CheckBoxPrintToFile.Visible      :=(rpoPrintToFile in PrintParams.Options);
  CheckBoxPrintToFile.Enabled      :=not (rpoDisablePrintToFile in PrintParams.Options);
  CheckBoxPrintToFile.Checked      :=PrintParams.PrintToFile;
  CheckBoxPrintInBackground.Enabled:=not (rpoDisablePrintInBackground in PrintParams.Options);
  CheckBoxPrintInBackground.Checked:=PrintParams.PrintInBackground;
  RadioButtonPagesInterval.Enabled :=(rpoPageNums in PrintParams.Options);
  EditFromPage.Enabled             :=(rpoPageNums in PrintParams.Options);
  EditFromPage.Color               :=StateColors[EditFromPage.Enabled];
  EditToPage.Enabled               :=(rpoPageNums in PrintParams.Options);
  EditToPage.Color                 :=StateColors[EditToPage.Enabled];
  RadioButtonPagesSelect.Enabled   :=(rpoSelection in PrintParams.Options);
  if rpoHelp in PrintParams.Options then
    BorderIcons:=BorderIcons+[biHelp]
  else
    BorderIcons:=BorderIcons-[biHelp];
end;

procedure TRLPrintDialog.SaveEditors;
begin
  if RadioButtonPagesAll.Checked then
    PrintParams.PrintRange:=rprAllPages
  else if RadioButtonPagesSelect.Checked then
    PrintParams.PrintRange:=rprSelection
  else if RadioButtonPagesInterval.Checked then
    PrintParams.PrintRange:=rprPageNums;
  case PrintParams.PrintRange of
    rprAllPages : begin
                    PrintParams.FromPage:=PrintParams.MinPage;
                    PrintParams.ToPage  :=PrintParams.MaxPage;
                  end;
    rprSelection: begin
                    PrintParams.FromPage:=EmptyStrToInt(EditFromPage.Text);
                    PrintParams.ToPage  :=PrintParams.FromPage;
                  end;
    rprPageNums : begin
                    PrintParams.FromPage:=EmptyStrToInt(EditFromPage.Text);
                    PrintParams.ToPage  :=EmptyStrToInt(EditToPage.Text);
                  end;
  end;
  PrintParams.Copies           :=EmptyStrToInt(EditCopies.Text);
  PrintParams.PrintToFile      :=CheckBoxPrintToFile.Checked;
  PrintParams.PrintInBackground:=CheckBoxPrintInBackground.Checked;
  //
  if ComboBoxPrinterNames.ItemIndex<>-1 then
    RLPrinter.PrinterIndex:=ComboBoxPrinterNames.ItemIndex;
  if ComboBoxFilters.ItemIndex<>-1 then
  begin
    PrintParams.Filter:=TRLCustomPrintFilter(ComboBoxFilters.Items.Objects[ComboBoxFilters.ItemIndex]);
    if Assigned(PrintParams.Filter) then
      PrintParams.Filter.OptionIndex:=ComboBoxOptions.ItemIndex;
  end
  else
    PrintParams.Filter:=nil;
  //  
  RLPrinter.Copies:=PrintParams.Copies;
end;

// EVENTS

procedure TRLPrintDialog.EditFromPageChange(Sender: TObject);
begin
  if not RadioButtonPagesInterval.Checked then
    RadioButtonPagesInterval.Checked:=True;
end;

procedure TRLPrintDialog.ComboBoxFiltersChange(Sender: TObject);
var
  p:TRLCustomPrintFilter;
begin
  if ComboBoxFilters.ItemIndex=-1 then
    p:=nil
  else
    p:=TRLCustomPrintFilter(ComboBoxFilters.Items.Objects[ComboBoxFilters.ItemIndex]);
  if (p<>nil) and (p.Options<>nil) then
  begin
    p.SetOrientation(PrintParams.Orientation);
    LabelOptions.Caption     :=p.OptionsLabel+':';
    ComboBoxOptions.Items    :=p.Options;
    ComboBoxOptions.ItemIndex:=p.OptionIndex;
    LabelOptions.Show;
    ComboBoxOptions.Show;
  end
  else
  begin
    LabelOptions.Hide;
    ComboBoxOptions.Hide;
  end;
end;

{ TRLPrintDialogSetup }

function TRLPrintDialogSetup.GetCopies: integer;
begin
  Result:=PrintParams.Copies;
end;

function TRLPrintDialogSetup.GetFilter: TRLCustomPrintFilter;
begin
  Result:=PrintParams.Filter;
end;

function TRLPrintDialogSetup.GetOptions: TRLPrintDialogOptions;
begin
  Result:=PrintParams.Options;
end;

function TRLPrintDialogSetup.GetPrintInBackground: boolean;
begin
  Result:=PrintParams.PrintInBackground;
end;

function TRLPrintDialogSetup.GetPrintToFile: boolean;
begin
  Result:=PrintParams.PrintToFile;
end;

procedure TRLPrintDialogSetup.SetCopies(const Value: integer);
begin
  PrintParams.Copies:=Value;
end;

procedure TRLPrintDialogSetup.SetFilter(const Value: TRLCustomPrintFilter);
begin
  PrintParams.Filter:=Value;
end;

procedure TRLPrintDialogSetup.SetOptions(const Value: TRLPrintDialogOptions);
begin
  PrintParams.Options:=Value;
end;

procedure TRLPrintDialogSetup.SetPrintInBackground(const Value: boolean);
begin
  PrintParams.PrintInBackground:=Value;
end;

procedure TRLPrintDialogSetup.SetPrintToFile(const Value: boolean);
begin
  PrintParams.PrintToFile:=Value;
end;

{ TRLPrintParams }

constructor TRLPrintParams.Create(aOwner: TComponent);
begin
  fOptions          :=DefaultPrintOptions;
  fPrintToFile      :=False;
  fPrintInBackground:=False;
  fFilter           :=nil;
  //
  inherited;
end;

destructor TRLPrintParams.Destroy;
begin
  inherited;
end;

procedure TRLPrintParams.Notification(Component: TComponent;
  Operation: TOperation);
begin
  inherited;
  //
  if Operation=opRemove then
    if Component=fFilter then
      fFilter:=nil;
end;

procedure TRLPrintParams.Clear;
begin
  fMinPage    :=1;
  fMaxPage    :=9999;
  fFromPage   :=fMinPage;
  fToPage     :=fMaxPage;
  fPrintRange :=rprAllPages;
  fFileName   :='';
  fHelpContext:=0;
  fCopies     :=RLPrinter.Copies;
end;

procedure TRLPrintParams.SetMaxPage(const Value: integer);
begin
  if fToPage=fMaxPage then
    fToPage:=Value;
  fMaxPage:=Value;
end;

procedure TRLPrintParams.SetFilter(const Value: TRLCustomPrintFilter);
begin
  if Assigned(fFilter) then
    fFilter.RemoveFreeNotification(Self);
  fFilter:=Value;
  if Assigned(fFilter) then
    fFilter.FreeNotification(Self);
end;

procedure TRLPrintParams.SetCopies(const Value: integer);
begin
  fCopies:=Value;
end;

procedure TRLPrintParams.Apply;
begin
  RLPrinter.Copies:=fCopies;
end;

initialization
  PrintParams:=TRLPrintParams.Create(nil);

finalization
  PrintParams.Free;

end.

