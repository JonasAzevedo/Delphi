{@unit RLSaveDialog - Implementação do diálogo de salvamento e sua classe de setup. }
unit RLSaveDialog;

interface

uses
  Classes, SysUtils,
{$ifndef LINUX}
  Windows,
{$else}
{$endif}
{$ifdef Win32}
  Messages, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons,
{$else}
  QGraphics, QControls, QForms, QDialogs, QStdCtrls, QButtons,
{$endif}
  RLFilters, RLConsts, RLTypes, RLUtils;

type
  {@type TRLSaveDialogOptions - Opções de configuração do diálogo de salvamento.
  Pode ser um conjunto dos seguintes valores:
  rsoDisableSaveInBackground - Desabilitar a opção de salvamento em segundo plano.
  :}
  TRLSaveDialogOption =(rsoDisableSaveInBackground);
  TRLSaveDialogOptions=set of TRLSaveDialogOption;
  {/@type}

  {@type TRLSaveRange - Opções para o modo seleção de páginas.
  Pode ser um dos seguintes valores:
  rsrAllPages - Salvar todas as páginas;
  rsrSelection - Salvar as páginas de números indicados;
  rsrPageNums - Salvar o intervalo de páginas indicado.
  :/}
  TRLSaveRange=(rsrAllPages,rsrSelection,rsrPageNums);

const
  DefaultSaveOptions=[];

type
  TRLSaveDialog = class(TForm)
    GroupBoxPages: TGroupBox;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    RadioButtonPagesAll: TRadioButton;
    RadioButtonPagesInterval: TRadioButton;
    RadioButtonPagesSelect: TRadioButton;
    LabelFromPage: TLabel;
    EditFromPage: TEdit;
    LabelToPage: TLabel;
    EditToPage: TEdit;
    LabelFileName: TLabel;
    EditFileName: TEdit;
    LabelUseFilter: TLabel;
    ComboBoxFilters: TComboBox;
    SpeedButtonLookup: TSpeedButton;
    SaveDialog: TSaveDialog;
    CheckBoxSaveInBackground: TCheckBox;
    procedure EditFromPageChange(Sender: TObject);
    procedure SpeedButtonLookupClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadEditors;
    procedure SaveEditors;
    procedure LoadFilterList;
    procedure Init;
  public
    { Public declarations }
    constructor Create(aOwner:TComponent); override;
    function  Execute:boolean;
  end;

  {@class TRLSaveDialogSetup - Opções do diálogo de salvamento.
   O diálogo de salvamento obedecerá as configurações da instância deste componente. Com ele, é
   possível configurar alguns itens de comportamento do diálogo de salvamento.
   @pub}
  TRLSaveDialogSetup=class(TComponent)
  private
    { Private declarations }
    function  GetOptions: TRLSaveDialogOptions;
    procedure SetOptions(const Value: TRLSaveDialogOptions);
    function  GetSaveInBackground: boolean;
    procedure SetSaveInBackground(const Value: boolean);
    function  GetFilter: TRLCustomSaveFilter;
    procedure SetFilter(const Value: TRLCustomSaveFilter);
  public
    { Public declarations }
  published
    {@prop Options - Opções diversas do diálogo de salvamento. @links TRLSaveDialogOptions. :/}
    property Options:TRLSaveDialogOptions read GetOptions write SetOptions default DefaultSaveOptions;
    {@prop SaveInBackground - Indica o valor inicial para a opção de salvar em segundo plano. :/}
    property SaveInBackground:boolean read GetSaveInBackground write SetSaveInBackground;
    {@prop Filter - Filtro atualmente selecionado. @links TRLCustomSaveFilter:/}
    property Filter:TRLCustomSaveFilter read GetFilter write SetFilter;
  end;
  {/@class}

  {@class TRLSaveParams - Parâmetros de salvamento.}
  TRLSaveParams=class(TComponent)
  private
    { Private declarations }
    fFileName        :string;
    fMaxPage         :integer;
    fToPage          :integer;
    fMinPage         :integer;
    fFromPage        :integer;
    fOptions         :TRLSaveDialogOptions;
    fSaveRange       :TRLSaveRange;
    fSaveInBackground:boolean;
    fFilter          :TRLCustomSaveFilter;
    fHelpContext     :integer;
    //
    procedure SetMaxPage(const Value: integer);
    procedure SetFilter(const Value: TRLCustomSaveFilter);
  protected
    { Protected declarations }
    procedure Notification(Component:TComponent; Operation:TOperation); override;
  public
    { Public declarations }
    constructor Create(aOwner:TComponent); override;
    destructor  Destroy; override;
    {@method Clear - Preenche todas as props com valores default.:/}
    procedure   Clear;
  published
    {@prop Options - Opções diversas do diálogo de salvamento. @links TRLSaveDialogOptions.:/}
    property  Options         :TRLSaveDialogOptions read fOptions          write fOptions default DefaultSaveOptions;
    {@prop FileName - Nome do arquivo a gerar.:/}
    property  FileName        :string               read fFileName         write fFileName;
    {@prop MaxPage - Limite superior para o intervalo de páginas a imprimir.:/}
    property  MaxPage         :integer              read fMaxPage          write SetMaxPage;
    {@prop MinPage - Limite inferior para o intervalo de páginas a imprimir.:/}
    property  MinPage         :integer              read fMinPage          write fMinPage;
    {@prop FromPage - Valor escolhido para a primeira página a imprimir.:/}
    property  FromPage        :integer              read fFromPage         write fFromPage;
    {@prop ToPage - Valor escolhido para a última página a imprimir.:/}
    property  ToPage          :integer              read fToPage           write fToPage;
    {@prop SaveRange - Valor inicial para o modo de seleção de páginas. @links TRLSaveRange.:/}
    property  SaveRange       :TRLSaveRange         read fSaveRange        write fSaveRange;
    {@prop SaveInBackground - Indica o valor inicial para o salvamento em segundo plano.:/}
    property  SaveInBackground:boolean              read fSaveInBackground write fSaveInBackground;
    {@prop Filter - Filtro atualmente selecionado. @links TRLCustomSaveFilter:/}
    property  Filter          :TRLCustomSaveFilter  read fFilter           write SetFilter;
    {@prop HelpContext - Código do tópico de ajuda associado.:/}
    property  HelpContext     :integer              read fHelpContext      write fHelpContext;
  end;
  {/@class}

{@var SaveParams - Parâmetros de salvamento atuais. @links TRLSaveParams:/}
var SaveParams:TRLSaveParams=nil;

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

{ TRLSaveDialog }

// OVERRIDE

constructor TRLSaveDialog.Create(aOwner:TComponent);
begin
  inherited CreateNew(aOwner);
  //
  Init;
end;

// PUBLIC

function TRLSaveDialog.Execute:boolean;
begin
  LoadFilterList;
  LoadEditors;
  ActiveControl:=EditFileName;
  Result:=(ShowModal=mrOk);
  if Result then
    SaveEditors;
end;

// PRIVATE

procedure TRLSaveDialog.Init;
begin
  Left := 211;
  Top := 407;
  ActiveControl := EditFileName;
{$ifdef Win32}
  BorderStyle := bsDialog;
{$else}
  BorderStyle := fbsDialog;
{$endif};
  Caption := 'Salvar como';
  ClientHeight := 244;
  ClientWidth := 391;
  Color := clBtnFace;
  Font.Charset := DEFAULT_CHARSET;
  Font.Color := clWindowText;
  Font.Height := 11;
  Font.Name := 'MS Sans Serif';
  Font.Pitch := fpVariable;
  Font.Style := [];
  Position := poScreenCenter;
  //
  LabelFileName:=TLabel.Create(Self);
  with LabelFileName do
  begin 
    Name := 'LabelFileName';
    Parent := Self;
    Left := 12;
    Top := 16;
    Width := 84;
    Height := 13;
    Caption := 'Nome do arquivo:';
  end;
  LabelUseFilter:=TLabel.Create(Self);
  with LabelUseFilter do
  begin
    Name := 'LabelUseFilter';
    Parent := Self;
    Left := 12;
    Top := 44;
    Width := 86;
    Height := 13;
    Caption := 'Salvar no formato:';
  end;
  SpeedButtonLookup:=TSpeedButton.Create(Self);
  with SpeedButtonLookup do
  begin
    Name := 'SpeedButtonLookup';
    Parent := Self;
    Left := 356;
    Top := 12;
    Width := 21;
    Height := 21;
    Caption := '...';
    OnClick := SpeedButtonLookupClick;
  end;
  GroupBoxPages:=TGroupBox.Create(Self);
  with GroupBoxPages do
  begin
    Name := 'GroupBoxPages';
    Parent := Self;
    Left := 12;
    Top := 68;
    Width := 365;
    Height := 101;
    Caption := ' Páginas no intervalo';
    TabOrder := 2;
    LabelFromPage:=TLabel.Create(Self);
    with LabelFromPage do
    begin
      Name := 'LabelFromPage';
      Parent := GroupBoxPages;
      Left := 68;
      Top := 45;
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
      Left := 136;
      Top := 45;
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
      Left := 8;
      Top := 20;
      Width := 113;
      Height := 17;
      Caption := 'Salvar &tudo';
      Checked := True;
      TabOrder := 0;
      TabStop := True;
    end;
    RadioButtonPagesInterval:=TRadioButton.Create(Self);
    with RadioButtonPagesInterval do
    begin
      Name := 'RadioButtonPagesInterval';
      Parent := GroupBoxPages;
      Left := 8;
      Top := 44;
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
      Left := 8;
      Top := 68;
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
      Left := 88;
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
      Left := 160;
      Top := 44;
      Width := 41;
      Height := 21;
      TabStop := False;
      TabOrder := 4;
      OnChange := EditFromPageChange;
    end;
  end;
  CheckBoxSaveInBackground:=TCheckBox.Create(Self);
  with CheckBoxSaveInBackground do
  begin
    Name := 'CheckBoxSaveInBackground';
    Parent := Self;
    Left := 12;
    Top := 172;
    Width := 365;
    Height := 17;
    Caption := 'Salvar em segundo plano';
    TabOrder := 3;
  end;
  ButtonSave:=TButton.Create(Self);
  with ButtonSave do
  begin
    Name := 'ButtonSave';
    Parent := Self;
    Left := 220;
    Top := 204;
    Width := 75;
    Height := 25;
    Caption := 'Salvar';
    Default := True;
    ModalResult := 1;
    TabOrder := 3;
  end;
  ButtonCancel:=TButton.Create(Self);
  with ButtonCancel do
  begin
    Name := 'ButtonCancel';
    Parent := Self;
    Left := 304;
    Top := 204;
    Width := 75;
    Height := 25;
    Cancel := True;
    Caption := 'Cancelar';
    ModalResult := 2;
    TabOrder := 4;
  end;
  EditFileName:=TEdit.Create(Self);
  with EditFileName do
  begin
    Name := 'EditFileName';
    Parent := Self;
    Left := 108;
    Top := 12;
    Width := 249;
    Height := 21;
    TabOrder := 0;
  end;
  ComboBoxFilters:=TComboBox.Create(Self);
  with ComboBoxFilters do
  begin
    Name := 'ComboBoxFilters';
    Parent := Self;
    Left := 108;
    Top := 40;
    Width := 177;
    Height := 21;
    Style := csDropDownList;
    ItemHeight := 13;
    TabOrder := 1;
  end;
  SaveDialog:=TSaveDialog.Create(Self);
  with SaveDialog do
  begin
    Name := 'SaveDialog';
    Left := 340;
    Top := 80;
  end;
  //
  Caption                         :=LS_SaveStr;
  LabelFileName.Caption           :=LS_FileNameStr+':';
  LabelUseFilter.Caption          :=LS_UseFilterStr+':';
  GroupBoxPages.Caption           :=' '+LS_PageRangeStr+' ';
  CheckBoxSaveInBackground.Caption:=LS_SaveInBackground;
  LabelFromPage.Caption           :=LS_RangeFromStr+':';
  LabelToPage.Caption             :=LS_RangeToStr;
  RadioButtonPagesAll.Caption     :=LS_AllStr;
  RadioButtonPagesInterval.Caption:=LS_PagesStr;
  RadioButtonPagesSelect.Caption  :=LS_SelectionStr;
  ButtonSave.Caption              :=LS_SaveStr;
  ButtonCancel.Caption            :=LS_CancelStr;
end;

procedure TRLSaveDialog.LoadFilterList;
var
  i,j,p:integer;
  f:TRLCustomSaveFilter;
begin
  ComboBoxFilters.Items.Clear;
  ComboBoxFilters.Items.AddObject(LS_DefaultStr,nil);
  j:=0;
  for i:=0 to ActiveFilters.Count-1 do
    if TObject(ActiveFilters[i]) is TRLCustomSaveFilter then
    begin
      f:=TRLCustomSaveFilter(ActiveFilters[i]);
      p:=ComboBoxFilters.Items.AddObject(f.GetDisplayLabel,f);
      if Assigned(SaveParams.Filter) and (f=SaveParams.Filter) then
        j:=p;
    end;
  ComboBoxFilters.ItemIndex:=j;
end;

procedure TRLSaveDialog.LoadEditors;
const
  StateColors:array[boolean] of TColor=(clBtnFace,clWindow);
begin
  case SaveParams.SaveRange of
    rsrAllPages : RadioButtonPagesAll.Checked     :=true;
    rsrSelection: RadioButtonPagesSelect.Checked  :=true;
    rsrPageNums : RadioButtonPagesInterval.Checked:=true;
  end;
  EditFileName.Text               :=SaveParams.FileName;
  EditFromPage.Text               :=IntToEmptyStr(SaveParams.FromPage);
  EditToPage.Text                 :=IntToEmptyStr(SaveParams.ToPage);
  CheckBoxSaveInBackground.Checked:=SaveParams.SaveInBackground;
  CheckBoxSaveInBackground.Enabled:=not (rsoDisableSaveInBackground in SaveParams.Options);
  RadioButtonPagesInterval.Enabled:=True;
  EditFromPage.Enabled            :=True;
  EditToPage.Enabled              :=True;
  EditFromPage.Color              :=StateColors[EditFromPage.Enabled];
  EditToPage.Color                :=StateColors[EditToPage.Enabled];
  RadioButtonPagesSelect.Enabled  :=False;
end;

procedure TRLSaveDialog.SaveEditors;
begin
  SaveParams.FileName:=EditFileName.Text;
  if RadioButtonPagesAll.Checked then
    SaveParams.SaveRange:=rsrAllPages
  else if RadioButtonPagesSelect.Checked then
    SaveParams.SaveRange:=rsrSelection
  else if RadioButtonPagesInterval.Checked then
    SaveParams.SaveRange:=rsrPageNums;
  case SaveParams.SaveRange of
    rsrAllPages : begin
                    SaveParams.FromPage:=SaveParams.MinPage;
                    SaveParams.ToPage  :=SaveParams.MaxPage;
                  end;
    rsrSelection: begin
                    SaveParams.FromPage:=EmptyStrToInt(EditFromPage.Text);
                    SaveParams.ToPage  :=SaveParams.FromPage;
                  end;
    rsrPageNums : begin
                    SaveParams.FromPage:=EmptyStrToInt(EditFromPage.Text);
                    SaveParams.ToPage  :=EmptyStrToInt(EditToPage.Text);
                  end;
  end;
  SaveParams.SaveInBackground:=CheckBoxSaveInBackground.Checked;
  if ComboBoxFilters.ItemIndex<>-1 then
    SaveParams.Filter:=TRLCustomSaveFilter(ComboBoxFilters.Items.Objects[ComboBoxFilters.ItemIndex])
  else
    SaveParams.Filter:=nil;
  // se não foi especificada uma extensão, pega-la-emos do filtro selecionado
  if ExtractFileExt(SaveParams.FileName)='' then
    if Assigned(SaveParams.Filter) then
      SaveParams.FileName:=ChangeFileExt(SaveParams.FileName,SaveParams.Filter.DefaultExt)
    else
      SaveParams.FileName:=ChangeFileExt(SaveParams.FileName,RLFILEEXT)
  else
    SaveParams.Filter:=SaveFilterByFileName(SaveParams.FileName);
end;

// EVENTS

procedure TRLSaveDialog.EditFromPageChange(Sender: TObject);
begin
  if not RadioButtonPagesInterval.Checked then
    RadioButtonPagesInterval.Checked:=true;
end;

function FilterStr(const aDescription,aExt:string):string;
begin
  Result:=aDescription+' (*'+FormatFileExt(aExt)+')|*'+FormatFileExt(aExt);
end;

procedure TRLSaveDialog.SpeedButtonLookupClick(Sender: TObject);
var
  s:TRLCustomSaveFilter;
begin
  if ComboBoxFilters.ItemIndex<>-1 then
    s:=TRLCustomSaveFilter(ComboBoxFilters.Items.Objects[ComboBoxFilters.ItemIndex])
  else
    s:=nil;
  if Assigned(s) then
  begin
    SaveDialog.Filter    :=FilterStr(s.GetDisplayLabel,s.DefaultExt);
    SaveDialog.DefaultExt:=s.DefaultExt;
  end
  else
  begin
    SaveDialog.Filter    :=FilterStr(CS_ProductTitleStr,RLFILEEXT);
    SaveDialog.DefaultExt:=RLFILEEXT;
  end;
  SaveDialog.FileName:=EditFileName.Text;
  if SaveDialog.Execute then
    EditFileName.Text:=SaveDialog.FileName;
end;

{ TRLSaveDialogSetup }

function TRLSaveDialogSetup.GetFilter: TRLCustomSaveFilter;
begin
  Result:=SaveParams.Filter;
end;

function TRLSaveDialogSetup.GetOptions: TRLSaveDialogOptions;
begin
  Result:=SaveParams.Options;
end;

function TRLSaveDialogSetup.GetSaveInBackground: boolean;
begin
  Result:=SaveParams.SaveInBackground;
end;

procedure TRLSaveDialogSetup.SetFilter(const Value: TRLCustomSaveFilter);
begin
  SaveParams.Filter:=Value;
end;

procedure TRLSaveDialogSetup.SetOptions(const Value: TRLSaveDialogOptions);
begin
  SaveParams.Options:=Value;
end;

procedure TRLSaveDialogSetup.SetSaveInBackground(const Value: boolean);
begin
  SaveParams.SaveInBackground:=Value;
end;

{ TRLSaveParams }

constructor TRLSaveParams.Create(aOwner: TComponent);
begin
  fSaveInBackground:=False;
  fOptions         :=DefaultSaveOptions;
  fFilter          :=nil;
  //
  inherited;
end;

destructor TRLSaveParams.Destroy;
begin
  inherited;
end;

procedure TRLSaveParams.Notification(Component: TComponent;
  Operation: TOperation);
begin
  inherited;
  //
  if Operation=opRemove then
    if Component=fFilter then
      fFilter:=nil;
end;

procedure TRLSaveParams.Clear;
begin
  fFileName   :='';
  fMinPage    :=1;
  fMaxPage    :=9999;
  fFromPage   :=fMinPage;
  fToPage     :=fMaxPage;
  fSaveRange  :=rsrAllPages;
  fHelpContext:=0;
end;

procedure TRLSaveParams.SetFilter(const Value: TRLCustomSaveFilter);
begin
  if Assigned(fFilter) then
    fFilter.RemoveFreeNotification(Self);
  fFilter:=Value;
  if Assigned(fFilter) then
    fFilter.FreeNotification(Self);
end;

procedure TRLSaveParams.SetMaxPage(const Value: integer);
begin
  if fToPage=fMaxPage then
    fToPage:=Value;
  fMaxPage:=Value;
end;

initialization
  SaveParams:=TRLSaveParams.Create(nil);

finalization
  SaveParams.Free;

end.

