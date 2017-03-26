{@unit RLPreviewForm - Implementação do form padrão de pré-visualização. }
unit RLPreviewForm;

interface

uses
  SysUtils, Math, Contnrs, Classes,
{$ifdef Win32}
  Windows, Controls, Buttons, ExtCtrls, Forms, Dialogs, StdCtrls, Graphics, RLPrinters,
{$else}
  Types, QControls, Qt, QButtons, QExtCtrls, QForms, QDialogs, QStdCtrls, QTypes, QGraphics, RLPrintersCLX,
{$endif}
  RLConsts, RLMetaFile, RLPreview, RLFilters, RLUtils, RLPrintDialog, RLSaveDialog, RLTypes, RLFindDialog;

type

  { TRLPreviewForm }

  TRLPreviewForm = class(TForm)
    TimerRepeat: TTimer;
    PanelContainer: TPanel;
    PanelTools: TPanel;
    SpeedButtonPrint: TSpeedButton;
    SpeedButtonSetup: TSpeedButton;
    SpeedButtonFirst: TSpeedButton;
    SpeedButtonPrior: TSpeedButton;
    SpeedButtonNext: TSpeedButton;
    SpeedButtonLast: TSpeedButton;
    SpeedButtonZoomDown: TSpeedButton;
    SpeedButtonZoomUp: TSpeedButton;
    SpeedButtonClose: TSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    SpeedButtonSave: TSpeedButton;
    SpeedButtonViews: TSpeedButton;
    Bevel5: TBevel;
    PanelPages: TPanel;
    LabelPage: TLabel;
    LabelOf: TLabel;
    EditPageNo: TEdit;
    PanelZoom: TPanel;
    ComboBoxZoom: TComboBox;
    PanelPageCount: TPanel;
    PanelCopyright: TPanel;
    SpeedButtonCopyright: TSpeedButton;
    SpeedButtonEdit: TSpeedButton;
    Bevel6: TBevel;
    SpeedButtonSend: TSpeedButton;
    procedure ComboBoxZoomChange(Sender: TObject);
    procedure SpeedButtonPrintClick(Sender: TObject);
    procedure SpeedButtonFirstClick(Sender: TObject);
    procedure SpeedButtonLastClick(Sender: TObject);
    procedure SpeedButtonSetupClick(Sender: TObject);
    procedure SpeedButtonSaveClick(Sender: TObject);
    procedure SpeedButtonCloseClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rpvDefaultChangeView(Sender: TObject);
    procedure TimerRepeatTimer(Sender: TObject);
    procedure SpeedButtonPriorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButtonPriorMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EditPageNoChange(Sender: TObject);
    procedure SpeedButtonZoomUpClick(Sender: TObject);
    procedure SpeedButtonZoomDownClick(Sender: TObject);
    procedure SpeedButtonViewsClick(Sender: TObject);
    procedure SpeedButtonEditClick(Sender: TObject);
    procedure SpeedButtonSendClick(Sender: TObject);
  private
    { Private declarations }
    fPreviewIndex :integer;
    fPreviewList  :TObjectList;
    fEditingZoom  :boolean;
    fEditingPageNo:boolean;
    fFindDialog   :TfrmRLFindDialog;
    fActivePreview:TRLPreview;
    //
    procedure   Init;
    procedure   NewPreview;
    procedure   ReleasePreview;
    procedure   OrganizePreviews;
    procedure   SetPreview(aPreview:TRLPreview);
    function    GetPreview:TRLPreview;
    procedure   PreviewEnter(Sender: TObject);
    procedure   CreateShortCuts;
    procedure   UpdateComboBoxZoom;
    procedure   UpdateEditPageNo;
    procedure   ShowFindDialog;
    procedure   OnFindHandler(Sender:TObject; const Text:string; Options:TRLFindOptions; var Found:boolean);
  protected
    { Protected declarations }
    procedure   DoClose(var Action:TCloseAction); override;
  public
    { Public declarations }
    constructor Create(aOwner:TComponent); reintroduce;
    destructor  Destroy; override;
    //
    property    Preview:TRLPreview read GetPreview;
  end;

  TRLPreviewFormButtons=(pbPrint,pbSave,pbSend);
  TRLPreviewFormButtonsSet=set of TRLPreviewFormButtons;
  TRLPreviewEditOptions=(eoCanReposition,eoCanResizeItems,eoCanEditText,eoCanDeleteItems,eoCanPointOut);
  TRLPreviewEditOptionsSet=set of TRLPreviewEditOptions;

  {@class TRLPreviewSetup - Opções do pré-visualizador padrão.
   Todos os relatórios que não tiverem suas próprias configurações de previsualização
   seguirão as regras estabelecidas neste componente. }
  TRLPreviewSetup=class(TComponent)
  private
    fBeforePrint   :TNotifyEvent;
    fAfterPrint    :TNotifyEvent;
    fBeforeSave    :TNotifyEvent;
    fAfterSave     :TNotifyEvent;
    fBeforeSend    :TNotifyEvent;
    fOnSend        :TNotifyEvent;
    fAfterSend     :TNotifyEvent;
    fEnabledButtons:TRLPreviewFormButtonsSet;
    fEditOptions   :TRLPreviewEditOptionsSet;
    //
    function    GetBorderIcons: TBorderIcons;
    function    GetCaption: string;
    function    GetFormStyle: TFormStyle;
    function    GetHelpContext: integer;
    function    GetHelpFile: string;
    function    GetPosition: TPosition;
    function    GetSentToPrinter: boolean;
    function    GetShowModal: boolean;
    function    GetWindowBounds: TRect;
    function    GetWindowState: TWindowState;
    function    GetZoomFactor: double;
    procedure   SetBorderIcons(const Value: TBorderIcons);
    procedure   SetCaption(const Value: string);
    procedure   SetFormStyle(const Value: TFormStyle);
    procedure   SetHelpContext(const Value: integer);
    procedure   SetHelpFile(const Value: string);
    procedure   SetPosition(const Value: TPosition);
    procedure   SetSentToPrinter(const Value: boolean);
    procedure   SetShowModal(const Value: boolean);
    procedure   SetWindowBounds(const Value: TRect);
    procedure   SetWindowState(const Value: TWindowState);
    procedure   SetZoomFactor(const Value: double);
    function    IsZoomFactor: Boolean;
    procedure   SetEnabledButtons(const Value: TRLPreviewFormButtonsSet);
    procedure   SetEditOptions(const Value: TRLPreviewEditOptionsSet);
  public
    { Public declarations }
    constructor Create(aOwner:TComponent); override;
    destructor  Destroy; override;

    {@prop SentToPrinter - Indica se o relatório foi impresso ao menos uma vez. :/}
    property    SentToPrinter:boolean read GetSentToPrinter write SetSentToPrinter;

    {@prop WindowBounds - Indica ou determina as dimensões padrões da janela quando ela não está maximizada. :/}
    property    WindowBounds :TRect   read GetWindowBounds  write SetWindowBounds;
  published
    {@prop WindowState - Indica o estado inicial da janela de preview. :/}
    property    WindowState :TWindowState read GetWindowState  write SetWindowState default wsMaximized;

    {@prop FormStyle - Indica o estilo da janela de preview. :/}
    property    FormStyle   :TFormStyle   read GetFormStyle    write SetFormStyle   default fsNormal;

    {@prop ShowModal - Indica se a janela de preview será modal. :/}
    property    ShowModal   :boolean      read GetShowModal    write SetShowModal   default False;

    {@prop Position - Indica a posição da janela de preview. :/}
    property    Position    :TPosition    read GetPosition     write SetPosition    default poScreenCenter;

    {@prop BorderIcons - Seleciona os botões da janela de preview. :/}
    property    BorderIcons :TBorderIcons read GetBorderIcons  write SetBorderIcons default [biSystemMenu,biMinimize,biMaximize];

    {@prop HelpFile - Nome do arquivo de help para a janela preview, se houver. :/}
    property    HelpFile    :string       read GetHelpFile     write SetHelpFile;

    {@prop HelpContext - Contexto de help para a janela preview, se houver. :/}
    property    HelpContext :integer      read GetHelpContext  write SetHelpContext default 0;

    {@prop Caption - Título da janela de preview. :/}
    property    Caption     :string       read GetCaption      write SetCaption;

    {@prop ZoomFactor - Fator de zoom inicial (percentual). :/}
    property    ZoomFactor  :double       read GetZoomFactor   write SetZoomFactor  stored IsZoomFactor;

    {@prop EnabledButtons - Botões habilitados.
                            Através desta prop pode-se mostrar ou esconder botões da barra de ferramentas.
     @links TRLPreviewFormButtonsSet. :/}
    property    EnabledButtons:TRLPreviewFormButtonsSet read fEnabledButtons write SetEnabledButtons default [pbPrint,pbSave,pbSend];

    {@prop EditOptions - Opções de edição (ainda não disponível).
     Determina que operações poderão ser realizadas pelo usuário no conteúdo do relatório
     já preparado.
     @links TRLPreviewEditOptions,TRLPreviewEditOptionsSet. :/}
    property    EditOptions   :TRLPreviewEditOptionsSet read fEditOptions write SetEditOptions default [];

    {@event BeforePrint - Sempre antes de imprimir ou quando o usuário pressiona o botão "Imprimir". :/}
    property    BeforePrint:TNotifyEvent read fBeforePrint write fBeforePrint;

    {@event AfterPrint - Sempre após a impressão ou quando o filtro de impressão termina de processar todas as páginas. :/}
    property    AfterPrint :TNotifyEvent read fAfterPrint  write fAfterPrint;

    {@event BeforeSave - Sempre antes de salvar/exportar ou quando o usuário pressiona o botão "Salvar". :/}
    property    BeforeSave :TNotifyEvent read fBeforeSave  write fBeforeSave;

    {@event AfterSave - Sempre após o salvamento/exportação ou quando o filtro de salvamento termina de processar todas as páginas. :/}
    property    AfterSave  :TNotifyEvent read fAfterSave   write fAfterSave;

    {@event BeforeSend - Sempre antes de enviar o relatório via e-mail ou quando o usuário pressionar o botão "Enviar". :/}
    property    BeforeSend :TNotifyEvent read fBeforeSend  write fBeforeSend;

    {@event OnSend - Sempre ao enviar um relatório via e-mail.
     O programador deve implementar este evento e providenciar o envio do relatório.
     O FortesReport não prove esta rotina, apenas fornece a interface para isso. :/}
    property    OnSend     :TNotifyEvent read fOnSend      write fOnSend;

    {@event AfterSend - Sempre após a conclusão do envio do relatório via e-mail. :/}
    property    AfterSend  :TNotifyEvent read fAfterSend   write fAfterSend;
  end;
  {/@class}

const
  ZoomFactorFullWidth    =-1;
  ZoomFactorFullPage     =-2;
  ZoomFactorMultiplePages=-3;

var
  DefaultWindowState :TWindowState=wsMaximized;
  DefaultWindowBounds:TRect;
  DefaultFormStyle   :TFormStyle=fsNormal;
  DefaultShowModal   :boolean=False;
  DefaultPosition    :TPosition=poScreenCenter;
  DefaultBorderIcons :TBorderIcons=[biSystemMenu,biMinimize,biMaximize];
  DefaultHelpFile    :string='';
  DefaultHelpContext :integer=0;
  DefaultCaption     :string='';
  DefaultZoomFactor  :double=100;
  SentToPrinter      :boolean=False;

{@proc PreviewPagesWithOptions - Exibe o form padrão de pré-visualização com opções. :/}  
procedure PreviewPagesWithOptions(aPages:TRLGraphicStorage; aShowModal:boolean; aFormStyle:TFormStyle; aPosition:TPosition; aWindowState:TWindowState; aBorderIcons:TBorderIcons; const aHelpFile:string; aHelpContext:integer; aCaption:TCaption);
{@proc PreviewPages - Exibe o form padrão de pré-visualização com as opções default. :/}
procedure PreviewPages(aPages:TRLGraphicStorage);
{@proc PreviewFromFile - Carrega o arquivo de relatório e exibe o form padrão de pré-visualização. :/}
procedure PreviewFromFile(const aFileName:string);
{@proc PreviewFromStream - Carrega a stream de relatório e exibe o form padrão de pré-visualização. :/}
procedure PreviewFromStream(aStream:TStream);
{@proc PreviewFromFileDialog - Exibe diálogo para a carga de arquivo de relatório e exibe
 o form padrão de pré-visualização. :/}
procedure PreviewFromFileDialog;

{/@unit}

implementation

//{$R *.dfm}

var
  SetupInstance:TRLPreviewSetup=nil;

procedure PreviewPagesWithOptions(aPages:TRLGraphicStorage; aShowModal:boolean; aFormStyle:TFormStyle; aPosition:TPosition; aWindowState:TWindowState; aBorderIcons:TBorderIcons; const aHelpFile:string; aHelpContext:integer; aCaption:TCaption);
begin
  SentToPrinter:=False;
  with TRLPreviewForm.Create(nil) do
  begin
    Preview.Pages:=aPages;
    if DefaultZoomFactor=ZoomFactorFullWidth then
      Preview.ZoomFullWidth
    else if DefaultZoomFactor=ZoomFactorFullPage then
      Preview.ZoomFullPage
    else if DefaultZoomFactor=ZoomFactorMultiplePages then
      Preview.ZoomMultiplePages
    else if DefaultZoomFactor>0 then
      Preview.ZoomFactor:=DefaultZoomFactor;
    UpdateComboBoxZoom;
    Position          :=aPosition;
    WindowState       :=aWindowState;
    BorderIcons       :=aBorderIcons;
    HelpFile          :=aHelpFile;
    HelpContext       :=aHelpContext;
    if aCaption<>'' then
      Caption:=aCaption;
    FormStyle         :=aFormStyle;
    if aShowModal then
      ShowModal
    else if Visible then
      BringToFront
    else
      Show;
  end;
end;

procedure PreviewPages(aPages:TRLGraphicStorage);
begin
  PreviewPagesWithOptions(aPages,DefaultShowModal,DefaultFormStyle,DefaultPosition,DefaultWindowState,DefaultBorderIcons,DefaultHelpFile,DefaultHelpContext,DefaultCaption);
end;

procedure PreviewFromFile(const aFileName:string);
var
  savecursor:TCursor;
  pages     :TRLGraphicStorage;
begin
  if not FileExists(aFileName) then
    raise Exception.Create(LS_FileNotFoundStr+' "'+aFileName+'"');
  //
  pages:=TRLGraphicStorage.Create(nil);
  try
    savecursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    try
      pages.LoadFromFile(aFileName);
    finally
      Screen.Cursor:=savecursor;
    end;
    PreviewPages(pages);
  finally
    pages.Unlink;
  end;
end;

procedure PreviewFromStream(aStream:TStream);
var
  savecursor:TCursor;
  pages     :TRLGraphicStorage;
begin
  pages:=TRLGraphicStorage.Create(nil);
  try
    savecursor:=Screen.Cursor;
    Screen.Cursor:=crHourGlass;
    try
      pages.LoadFromStream(aStream);
    finally
      Screen.Cursor:=savecursor;
    end;
    PreviewPages(pages);
  finally
    pages.Unlink;
  end;
end;

procedure PreviewFromFileDialog;
begin
  with TOpenDialog.Create(nil) do
    try
      DefaultExt :=FormatFileExt(RLFILEEXT);
      Filter     :=AddFileFilter('',CS_ProductTitleStr,RLFILEEXT);
      FilterIndex:=1;
      Title      :=LS_LoadReportStr;
      if Execute then
        PreviewFromFile(FileName);
    finally
      Free;
    end;
end;

{$ifdef Win32}
const
  key_escape=vk_escape;
  key_home  =vk_home;
  key_prior =vk_prior;
  key_next  =vk_next;
  key_end   =vk_end;
  key_up    =vk_up;
  key_down  =vk_down;
  key_left  =vk_left;
  key_right =vk_right;
  key_f3    =vk_f3;
{$endif}

constructor TRLPreviewForm.Create(aOwner:TComponent);
begin
  fPreviewList  :=nil;
  fPreviewIndex :=0;
  fEditingZoom  :=False;
  fEditingPageNo:=False;
  fFindDialog   :=nil;
  fActivePreview:=nil;
  //
  inherited CreateNew(aOwner);
  //
  fPreviewList:=TObjectList.Create;
  //
  Init;
  CreateShortCuts;
  //
  NewPreview;
  OrganizePreviews;
end;

destructor TRLPreviewForm.Destroy;
begin
  fPreviewList.Free;
  if Assigned(fFindDialog) then
    fFindDialog.Free;
  //
  inherited;
end;

procedure TRLPreviewForm.CreateShortCuts;
var
  l:TStringList;
  b:TSpeedButton;
  ch:char;
  k,n:string;
  i,j:integer;
function IsValidCaption(const aCaption:string):boolean;
var
  i:integer;
begin
  Result:=False;
  for i:=1 to length(aCaption) do
    if aCaption[i] in ['A'..'Z','a'..'z','0'..'9'] then
    begin
      Result:=True;
      Break;
    end;
end;
begin
  l:=TStringList.Create;
  try
    //
    for i:=0 to ComponentCount-1 do
      if Components[i] is TSpeedButton then
      begin
        b:=TSpeedButton(Components[i]);
        if IsValidCaption(b.Caption) then
          l.AddObject(b.Caption,b);
      end;
    //
    k:='';
    for i:=0 to l.Count-1 do
    begin
      n:=l[i];
      for j:=1 to length(n) do
      begin
        ch:=UpCase(n[j]);
        if (ch in ['A'..'Z','0'..'9']) and (pos(ch,k)=0) then
        begin
          Insert('&',n,j);
          l[i]:=n;
          k:=k+ch;
          Break;
        end;
      end;
    end;
    //
    for i:=0 to l.Count-1 do
      TSpeedButton(l.Objects[i]).Caption:=l[i];
  finally
    l.Free;
  end;
end;

procedure TRLPreviewForm.OrganizePreviews;
var
  i,t,w:integer;
  n:TControl;
  s:TSplitter;
begin
  if fPreviewList.Count>0 then
  begin
    for i:=fPreviewList.Count-1 downto 0 do
    begin
      n:=TControl(TRLPreview(fPreviewList[i]));
      s:=TSplitter(n.Tag);
      s.Align:=alNone;
      n.Align:=alNone;
    end;
    w:=ClientHeight div fPreviewList.Count;
    t:=0;
    for i:=0 to fPreviewList.Count-1 do
    begin
      n:=TControl(TRLPreview(fPreviewList[i]));
      s:=TSplitter(n.Tag);
      n.Height:=w;
      if i=fPreviewList.Count-1 then
      begin
        n.Align:=alClient;
        s.Hide;
      end
      else
      begin
        n.Align  :=alTop;
        n.Height :=w;
        n.Top    :=t;
        Inc(t,n.Height);
        s.Align  :=alTop;
        s.Height :=3;
        s.Visible:=True;
        s.Top    :=t;
        Inc(t,s.Height);
      end;
    end;
  end;
end;

procedure TRLPreviewForm.NewPreview;
var
  n:TRLPreview;
  s:TSplitter;
begin
  n:=TRLPreview.Create(nil);
  with n do
  begin
    Width       :=0;
    OnChangeView:=rpvDefaultChangeView;
    OnEnter     :=PreviewEnter;
  end;
  TControl(n).Parent:=PanelContainer;
  s:=TSplitter.Create(n);
  with s do
  begin
    AutoSnap:=False;
    Width   :=0;
    Parent  :=PanelContainer;
  end;
  n.Tag:=integer(s);
  fPreviewList.Add(n);
  if fPreviewList.Count>1 then
    n.Pages:=TRLPreview(fPreviewList[0]).Pages;
end;

procedure TRLPreviewForm.ReleasePreview;
var
  p:TRLPreview;
begin
  if fPreviewList.Count>1 then
  begin
    p:=TRLPreview(fPreviewList[fPreviewList.Count-1]);
    if fActivePreview=p then
      fActivePreview:=nil;
    fPreviewList.Remove(p);
    if fPreviewIndex>fPreviewList.Count-1 then
      SetPreview(TRLPreview(fPreviewList[fPreviewList.Count-1]));
  end;
end;

procedure TRLPreviewForm.Init;
begin
  Left := 195;
  Top := 181;
  Width := 815;
  Height := 375;
  VertScrollBar.Range := 29;
  AutoScroll := False;
  Caption := 'Pré-visualização';
  Color := clBtnFace;
  Font.Charset := DEFAULT_CHARSET;
  Font.Color := clWindowText;
  Font.Height := 11;
  Font.Name := 'MS Sans Serif';
  Font.Pitch := fpVariable;
  Font.Style := [];
  KeyPreview := True;
  WindowState := wsNormal;
  OnKeyDown := FormKeyDown;
  PixelsPerInch := 96;
  PanelContainer:=TPanel.Create(Self);
  with PanelContainer do
  begin
    Name := 'PanelContainer';
    Parent := Self;
    Left := 0;
    Top := 24;
    Width := 807;
    Height := 311;
    Align := alClient;
    BevelOuter := bvLowered;
    Caption := ' ';
    TabOrder := 1;
  end;
  PanelTools:=TPanel.Create(Self);
  with PanelTools do
  begin
    Name := 'PanelTools';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 798;
    Height := 23;
    Align := alTop;
    BevelOuter := bvNone;
    BorderWidth := 1;
    Caption := ' ';
    TabOrder := 2;
    SpeedButtonPrint:=TSpeedButton.Create(Self);
    with SpeedButtonPrint do
    begin
      Name := 'SpeedButtonPrint';
      Parent := PanelTools;
      Left := 1;
      Top := 1;
      Width := 50;
      Height := 22;
      Caption := 'Imprimir';
      Flat := True;
      ShowHint := True;
      Spacing := -1;
      OnClick := SpeedButtonPrintClick;
    end;
    SpeedButtonSetup:=TSpeedButton.Create(Self);
    with SpeedButtonSetup do
    begin
      Name := 'SpeedButtonSetup';
      Parent := PanelTools;
      Left := 162;
      Top := 1;
      Width := 22;
      Height := 22;
      Caption := ' ';
      Flat := True;
      ShowHint := True;
      Glyph := HexToBitmap('4E010000424D4E01000000000000760000002800000011000000120000000100'+
                           '040000000000D8000000C40E0000C40E00001000000000000000000000000000'+
                           '80000080000000808000800000008000800080800000C0C0C000808080000000'+
                           'FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777'+
                           '7777700000007777830388888888700000007700833370077778700000007733'+
                           '037303737F7870000000770F33F33F30F778700000007330F77770337F787000'+
                           '0000737F7383F7F3F77870000000733738F837337F78700000007703F8F8733F'+
                           'F77870000000773F08F8073F7F787000000077338888F33FF778700000007777'+
                           '8FFFFFFF7F787000000077778FFFFFFFFF887000000077778FFFFFFF88887000'+
                           '000077778FFFFFFF87887000000077778FFFFFFF888770000000777788888888'+
                           '887770000000777777777777777770000000');
      Spacing := -1;
      OnClick := SpeedButtonSetupClick;
    end;
    SpeedButtonFirst:=TSpeedButton.Create(Self);
    with SpeedButtonFirst do
    begin
      Name := 'SpeedButtonFirst';
      Parent := PanelTools;
      Left := 195;
      Top := 1;
      Width := 22;
      Height := 22;
      Caption := ' ';
      Flat := True;
      ShowHint := True;
      Glyph := HexToBitmap('D6000000424DD60000000000000076000000280000000E0000000C0000000100'+
                           '04000000000060000000C40E0000C40E00001000000000000000000000000000'+
                           '80000080000000808000800000008000800080800000C0C0C000808080000000'+
                           'FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777'+
                           '7700777770777077770077770077007777007770C070C0777700770CE00CE000'+
                           '070070CEEECEEEEEC70070E7FFE7FFFFC700770EFC0EFCCCC7007770EC70EC77'+
                           '770077770C770C77770077777C777C7777007777777777777700');
      Spacing := -1;
      OnClick := SpeedButtonFirstClick;
    end;
    SpeedButtonPrior:=TSpeedButton.Create(Self);
    with SpeedButtonPrior do
    begin
      Name := 'SpeedButtonPrior';
      Parent := PanelTools;
      Left := 217;
      Top := 1;
      Width := 22;
      Height := 22;
      Caption := ' ';
      Flat := True;
      ShowHint := True;
      Glyph := HexToBitmap('D6000000424DD60000000000000076000000280000000E0000000C0000000100'+
                           '04000000000060000000C40E0000C40E00001000000000000000000000000000'+
                           '80000080000000808000800000008000800080800000C0C0C000808080000000'+
                           'FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777'+
                           '7700777770777777770077770077777777007770C07777777700770CE0000000'+
                           '070070CEEEEEEEEEC70070E7FFFFFFFFC700770EFCCCCCCCC7007770EC777777'+
                           '770077770C777777770077777C77777777007777777777777700');
      Spacing := -1;
      OnMouseDown := SpeedButtonPriorMouseDown;
      OnMouseUp := SpeedButtonPriorMouseUp;
    end;
    SpeedButtonNext:=TSpeedButton.Create(Self);
    with SpeedButtonNext do
    begin
      Name := 'SpeedButtonNext';
      Parent := PanelTools;
      Left := 378;
      Top := 1;
      Width := 22;
      Height := 22;
      Caption := ' ';
      Flat := True;
      ShowHint := True;
      Glyph := HexToBitmap('D6000000424DD60000000000000076000000280000000E0000000C0000000100'+
                           '04000000000060000000C40E0000C40E00001000000000000000000000000000'+
                           '80000080000000808000800000008000800080800000C0C0C000808080000000'+
                           'FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777'+
                           '770077777777077777007777777700777700777777770C077700700000000EC0'+
                           '77007CEEEEEEEEEC07007CFFFFFFFF7E07007CCCCCCCCFE0770077777777CE07'+
                           '770077777777C077770077777777C77777007777777777777700');
      Spacing := -1;
      OnMouseDown := SpeedButtonPriorMouseDown;
      OnMouseUp := SpeedButtonPriorMouseUp;
    end;
    SpeedButtonLast:=TSpeedButton.Create(Self);
    with SpeedButtonLast do
    begin
      Name := 'SpeedButtonLast';
      Parent := PanelTools;
      Left := 400;
      Top := 1;
      Width := 22;
      Height := 22;
      Caption := ' ';
      Flat := True;
      ShowHint := True;
      Glyph := HexToBitmap('D6000000424DD60000000000000076000000280000000E0000000C0000000100'+
                           '04000000000060000000C40E0000C40E00001000000000000000000000000000'+
                           '80000080000000808000800000008000800080800000C0C0C000808080000000'+
                           'FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777'+
                           '77007777077707777700777700770077770077770C070C07770070000EC00EC0'+
                           '77007CEEEEECEEEC07007CFFFF7EFF7E07007CCCCFE0CFE077007777CE07CE07'+
                           '77007777C077C07777007777C777C77777007777777777777700');
      Spacing := -1;
      OnClick := SpeedButtonLastClick;
    end;
    SpeedButtonZoomDown:=TSpeedButton.Create(Self);
    with SpeedButtonZoomDown do
    begin
      Name := 'SpeedButtonZoomDown';
      Parent := PanelTools;
      Left := 433;
      Top := 1;
      Width := 22;
      Height := 22;
      Caption := ' ';
      Flat := True;
      Glyph := HexToBitmap('4E010000424D4E01000000000000760000002800000012000000120000000100'+
                           '040000000000D8000000C40E0000C40E00001000000000000000000000000000'+
                           '80000080000000808000800000008000800080800000C0C0C000808080000000'+
                           'FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777'+
                           '77777700000070000000007777777700000070FFF7F7F07777777700000070F7'+
                           '7777707777000700000070F77777F07776F60700000070F7777770776FE60700'+
                           '000070F7778800067E607700000070F77866666786077700000070F78EEEEE66'+
                           '00777700000070F8777777EE60777700000070F877F777EE6077770000007008'+
                           '7700000E60777700000077787FFFFF7E60777700000077787FFFFF7E60777700'+
                           '0000777787FFFF7E077777000000777778777770777777000000777777880007'+
                           '777777000000777777777777777777000000');
      Spacing := -1;
      OnClick := SpeedButtonZoomDownClick;
    end;
    SpeedButtonZoomUp:=TSpeedButton.Create(Self);
    with SpeedButtonZoomUp do
    begin
      Name := 'SpeedButtonZoomUp';
      Parent := PanelTools;
      Left := 455;
      Top := 1;
      Width := 22;
      Height := 22;
      Caption := ' ';
      Flat := True;
      Glyph := HexToBitmap('4E010000424D4E01000000000000760000002800000012000000120000000100'+
                           '040000000000D8000000C40E0000C40E00001000000000000000000000000000'+
                           '80000080000000808000800000008000800080800000C0C0C000808080000000'+
                           'FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777'+
                           '77777700000070000000007777777700000070FFF7F7F07777777700000070F7'+
                           '7777707777007700000070F77777F07776F60700000070F7777770776FE60700'+
                           '000070F7778800067E600700000070F77866666786077700000070F78EEEEE66'+
                           '00777700000070F8777707EE60777700000070F877F7077E6077770000007008'+
                           '7700000E60777700000077787FF7077E60777700000077787FFF0F7E60777700'+
                           '0000777787FFFF7E077777000000777778777770777777000000777777880007'+
                           '777777000000777777777777777777000000');
      Spacing := -1;
      OnClick := SpeedButtonZoomUpClick;
    end;
    SpeedButtonClose:=TSpeedButton.Create(Self);
    with SpeedButtonClose do
    begin
      Name := 'SpeedButtonClose';
      Parent := PanelTools;
      Left := 695;
      Top := 1;
      Width := 49;
      Height := 22;
      Caption := 'Fechar';
      Flat := True;
      ShowHint := True;
      Spacing := -1;
      OnClick := SpeedButtonCloseClick;
    end;
    Bevel1:=TBevel.Create(Self);
    with Bevel1 do
    begin
      Name := 'Bevel1';
      Parent := PanelTools;
      Left := 156;
      Top := 1;
      Width := 2;
      Height := 21;
    end;
    Bevel2:=TBevel.Create(Self);
    with Bevel2 do
    begin
      Name := 'Bevel2';
      Parent := PanelTools;
      Left := 189;
      Top := 1;
      Width := 2;
      Height := 21;
    end;
    Bevel3:=TBevel.Create(Self);
    with Bevel3 do
    begin
      Name := 'Bevel3';
      Parent := PanelTools;
      Left := 427;
      Top := 1;
      Width := 2;
      Height := 21;
    end;
    Bevel4:=TBevel.Create(Self);
    with Bevel4 do
    begin
      Name := 'Bevel4';
      Parent := PanelTools;
      Left := 626;
      Top := 1;
      Width := 2;
      Height := 21;
    end;
    SpeedButtonSave:=TSpeedButton.Create(Self);
    with SpeedButtonSave do
    begin
      Name := 'SpeedButtonSave';
      Parent := PanelTools;
      Left := 51;
      Top := 1;
      Width := 50;
      Height := 22;
      Caption := 'Salvar';
      Flat := True;
      ShowHint := True;
      Spacing := -1;
      OnClick := SpeedButtonSaveClick;
    end;
    SpeedButtonViews:=TSpeedButton.Create(Self);
    with SpeedButtonViews do
    begin
      Name := 'SpeedButtonViews';
      Parent := PanelTools;
      Left := 632;
      Top := 1;
      Width := 22;
      Height := 22;
      Hint := 'Várias Páginas';
      Flat := True;
      ShowHint := True;
      Glyph := HexToBitmap('EE000000424DEE000000000000007600000028000000100000000F0000000100'+
                           '04000000000078000000C40E0000C40E00001000000000000000000000000000'+
                           '80000080000000808000800000008000800080800000C0C0C000808080000000'+
                           'FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00BBBBBBB00BBB'+
                           'BBBBBBBBBB0000BBBBBBBBBBB0B00B0BBBBBBBBBBBB00BBBBBBBBBBBBBB00BBB'+
                           'BBBB8888888008888888F777777007777778F770000000000778F77777700777'+
                           '7778FFFFFFF00FFFFFF8BBBBBBB00BBBBBBBBBBBBBB00BBBBBBBBBBBB0B00B0B'+
                           'BBBBBBBBBB0000BBBBBBBBBBBBB00BBBBBBB');
      ParentShowHint := False;
      ShowHint := True;
      Spacing := -1;
      OnClick := SpeedButtonViewsClick;
    end;
    Bevel5:=TBevel.Create(Self);
    with Bevel5 do
    begin
      Name := 'Bevel5';
      Parent := PanelTools;
      Left := 658;
      Top := 1;
      Width := 2;
      Height := 21;
    end;
    SpeedButtonEdit:=TSpeedButton.Create(Self);
    with SpeedButtonEdit do
    begin
      Name := 'SpeedButtonEdit';
      Parent := PanelTools;
      Left := 663;
      Top := 1;
      Width := 22;
      Height := 22;
      Hint := 'Editar';
      GroupIndex := 1;
      AllowAllUp := True;
      Flat := True;
      ShowHint := True;
      Glyph := HexToBitmap('EE000000424DEE000000000000007600000028000000100000000F0000000100'+
                           '04000000000078000000C40E0000C40E00001000000000000000000000000000'+
                           '80000080000000808000800000008000800080800000C0C0C000808080000000'+
                           'FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00BBBBBBBBBBBB'+
                           'BBBBBBBBBBBBB00BBBBBBBBBBBBBB00BBBBBBBBBB0BB00BBBBBBBBBBB00000BB'+
                           'BBBBBBBBB00000BBBBBBBBBBB0000000BBBBBBBBB000000BBBBBBBBBB00000BB'+
                           'BBBBBBBBB0000BBBBBBBBBBBB000BBBBBBBBBBBBB00BBBBBBBBBBBBBB0BBBBBB'+
                           'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
      ParentShowHint := False;
      ShowHint := True;
      Spacing := -1;
      OnClick := SpeedButtonEditClick;
    end;
    Bevel6:=TBevel.Create(Self);
    with Bevel6 do
    begin
      Name := 'Bevel6';
      Parent := PanelTools;
      Left := 689;
      Top := 1;
      Width := 2;
      Height := 21;
    end;
    SpeedButtonSend:=TSpeedButton.Create(Self);
    with SpeedButtonSend do
    begin
      Name := 'SpeedButtonSend';
      Parent := PanelTools;
      Left := 101;
      Top := 1;
      Width := 50;
      Height := 22;
      Caption := 'Enviar';
      Flat := True;
      ParentShowHint := False;
      ShowHint := True;
      Spacing := -1;
      OnClick := SpeedButtonSendClick;
    end;
    PanelPages:=TPanel.Create(Self);
    with PanelPages do
    begin
      Name := 'PanelPages';
      Parent := PanelTools;
      Left := 242;
      Top := 1;
      Width := 134;
      Height := 21;
      BevelOuter := bvNone;
      Caption := ' ';
      TabOrder := 0;
      LabelPage:=TLabel.Create(Self);
      with LabelPage do
      begin
        Name := 'LabelPage';
        Parent := PanelPages;
        Left := 0;
        Top := 4;
        Width := 33;
        Height := 13;
        Caption := 'Página';
      end;
      LabelOf:=TLabel.Create(Self);
      with LabelOf do
      begin
        Name := 'LabelOf';
        Parent := PanelPages;
        Left := 80;
        Top := 4;
        Width := 12;
        Height := 13;
        Caption := 'de';
      end;
      PanelPageCount:=TPanel.Create(Self);
      with PanelPageCount do
      begin
        Name := 'PanelPageCount';
        Parent := PanelPages;
        Left := 96;
        Top := 0;
        Width := 37;
        Height := 21;
        Alignment := taLeftJustify;
        BevelOuter := bvLowered;
        Caption := '99999';
      end;
      EditPageNo:=TEdit.Create(Self);
      with EditPageNo do
      begin
        Name := 'EditPageNo';
        Parent := PanelPages;
        Left := 40;
        Top := 0;
        Width := 37;
        Height := 21;
        TabOrder := 0;
        Text := '99999';
        OnChange := EditPageNoChange;
      end;
    end;
    PanelZoom:=TPanel.Create(Self);
    with PanelZoom do
    begin
      Name := 'PanelZoom';
      Parent := PanelTools;
      Left := 478;
      Top := 1;
      Width := 145;
      Height := 21;
      BevelOuter := bvNone;
      Caption := ' ';
      TabOrder := 1;
      ComboBoxZoom:=TComboBox.Create(Self);
      with ComboBoxZoom do
      begin
        Name := 'ComboBoxZoom';
        Parent := PanelZoom;
        Left := 0;
        Top := 0;
        Width := 145;
        Height := 21;
        Style := csDropDown;
        DropDownCount := 11;
        ItemHeight := 13;
        TabOrder := 0;
        OnChange := ComboBoxZoomChange;
        Items.Text := (
          '500%'#13+
          '200%'#13+
          '150%'#13+
          '100%'#13+
          '75%'#13+
          '50%'#13+
          '25%'#13+
          '10%'#13+
          'Largura da página'+#13+
          'Página inteira'+#13+
          'Várias páginas'+#13);
      end;
    end;
    PanelCopyright:=TPanel.Create(Self);
    with PanelCopyright do
    begin
      Name := 'PanelCopyright';
      Parent := PanelTools;
      Left := 775;
      Top := 1;
      Width := 22;
      Height := 21;
      Align := alRight;
      BevelOuter := bvNone;
      Caption := ' ';
      SpeedButtonCopyright:=TSpeedButton.Create(Self);
      with SpeedButtonCopyright do
      begin
        Name := 'SpeedButtonCopyright';
        Parent := PanelCopyright;
        Left := 0;
        Top := 0;
        Width := 22;
        Height := 22;
        Caption := ' ';
        Flat := True;
        ShowHint := True;
        Glyph := HexToBitmap(
          '66010000424D6601000000000000760000002800000014000000140000000100'+
          '040000000000F0000000C40E0000C40E00001000000000000000000000000000'+
          '80000080000000808000800000008000800080800000C0C0C000808080000000'+
          'FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777'+
          '7777777700007777777777797777777700007777777777797777777700007777'+
          '7777779777777777000077777777799777777777000077777777797777777777'+
          '0000777777979977777777770000777997779977777777770000777997799977'+
          '7777777700007999777999777777777700007999777999777777777700007799'+
          '9979997777777777000077799979997777777777000077777999997777777777'+
          '0000777777799997777799770000779977799999999977770000799997779999'+
          '7777777700007999977777999997799700007799777777799999997700007777'+
          '77777777777777770000');
        Spacing := -1;
      end
    end
  end;
  TimerRepeat:=TTimer.Create(Self);
  with TimerRepeat do
  begin
    Name := 'TimerRepeat';
    Interval := 100;
    OnTimer := TimerRepeatTimer;
    Left := 520;
    Top := 220;
  end;
  //
  Caption                  :=LS_PreviewStr;
  SpeedButtonFirst.Hint    :=LS_FirstPageStr;
  SpeedButtonFirst.ShowHint:=True;
  SpeedButtonPrior.Hint    :=LS_PriorPageStr;
  SpeedButtonPrior.ShowHint:=True;
  SpeedButtonNext.Hint     :=LS_NextPageStr;
  SpeedButtonNext.ShowHint:=True;
  SpeedButtonLast.Hint     :=LS_LastPageStr;
  SpeedButtonLast.ShowHint:=True;
  SpeedButtonViews.Hint    :=LS_DivideScreenStr;
  SpeedButtonViews.ShowHint:=True;
  SpeedButtonPrint.Hint    :=LS_PrintStr;
  SpeedButtonPrint.ShowHint:=True;
  SpeedButtonPrint.Caption :=LS_PrintStr;
  SpeedButtonSetup.Hint    :=LS_ConfigPrinterStr;
  SpeedButtonSetup.ShowHint:=True;
  SpeedButtonSetup.Enabled :=RLPrinter.SetupEnabled;
  SpeedButtonSave.Hint     :=LS_SaveToFileStr;
  SpeedButtonSave.ShowHint:=True;
  SpeedButtonSave.Caption  :=LS_SaveStr;
  SpeedButtonEdit.Hint     :=LS_EditStr;
  SpeedButtonEdit.ShowHint:=True;
  SpeedButtonSend.Caption  :=LS_SendStr;
  SpeedButtonSend.Hint     :=LS_SendToStr;
  SpeedButtonSend.ShowHint:=True;
  LabelPage.Caption        :=LS_PageStr;
  LabelOf.Caption          :=LS_OfStr;
  PanelPageCount.Caption   :='0';
  SpeedButtonClose.Hint    :=LS_CloseStr;
  SpeedButtonClose.ShowHint:=True;
  SpeedButtonClose.Caption :=LS_CloseStr;
  SpeedButtonCopyright.Hint:=CS_ProductTitleStr+' '+IntToStr(CommercialVersion)+'.'+IntToStr(ReleaseVersion)+' by Produsys';
  SpeedButtonCopyright.ShowHint:=True;
  ComboBoxZoom.Items[8]    :=LS_EntireWidthStr;
  ComboBoxZoom.Items[9]    :=LS_EntirePageStr;
  ComboBoxZoom.Items[10]   :=LS_MultiplePagesStr;
  //
  if Assigned(SetupInstance) then
  begin
    SpeedButtonPrint.Enabled:=(pbPrint in SetupInstance.EnabledButtons);
    SpeedButtonSave.Enabled :=(pbSave in SetupInstance.EnabledButtons);
    SpeedButtonSend.Enabled :=(pbSend in SetupInstance.EnabledButtons) and Assigned(SetupInstance.OnSend);
    SpeedButtonEdit.Enabled :=(SetupInstance.EditOptions<>[]);
  end
  else
    SpeedButtonSend.Enabled :=False;
end;

procedure TRLPreviewForm.DoClose(var Action:TCloseAction);
begin
  DefaultWindowState :=WindowState;
  DefaultWindowBounds:=BoundsRect;
  //  
  Action:=caFree;
end;

procedure TRLPreviewForm.ComboBoxZoomChange(Sender: TObject);
var
  z:double;
  i,e:integer;
begin
  fEditingZoom:=True;
  try
    i:=ComboBoxZoom.Items.IndexOf(ComboBoxZoom.Text);
    if i<>-1 then
      z:=0
    else
    begin
      Val(StringReplace(StringReplace(ComboBoxZoom.Text,'%','',[]),',','.',[]),z,e);
      if e<>0 then
        z:=0;
      i:=ComboBoxZoom.ItemIndex;
    end;
    if z>=10 then
      Preview.ZoomFactor:=z
    else
      case i of
        0 : Preview.ZoomFactor:=500;
        1 : Preview.ZoomFactor:=200;
        2 : Preview.ZoomFactor:=150;
        3 : Preview.ZoomFactor:=100;
        4 : Preview.ZoomFactor:=75;
        5 : Preview.ZoomFactor:=50;
        6 : Preview.ZoomFactor:=25;
        7 : Preview.ZoomFactor:=10;
        8 : Preview.ZoomFullWidth;
        9 : Preview.ZoomFullPage;
        10: Preview.ZoomMultiplePages;
      end;
  finally
    fEditingZoom:=False;
  end;
end;

procedure TRLPreviewForm.EditPageNoChange(Sender: TObject);
begin
  fEditingPageNo:=True;
  try
    Preview.PageIndex:=StrToIntDef(EditPageNo.Text,Preview.PageIndex)-1;
  finally
    fEditingPageNo:=False;
  end;
end;

procedure TRLPreviewForm.SpeedButtonPrintClick(Sender: TObject);
var
  priorfocus:TWinControl;
begin
  if Assigned(SetupInstance) and Assigned(SetupInstance.BeforePrint) then
    SetupInstance.BeforePrint(Self);
  priorfocus:=Screen.ActiveControl;
  try
    PrintParams.Clear;
    PrintParams.MaxPage:=Preview.Pages.PageCount;
    if Preview.Pages.Orientation=MetaOrientationLandscape then
      PrintParams.Orientation:=poLandscape
    else
      PrintParams.Orientation:=poPortrait;
    with TRLPrintDialog.Create(nil) do
      try
        if not Execute then
          Exit;
      finally
        Free;
      end;
    FilterPages(Preview.Pages,PrintParams.Filter,PrintParams.FromPage,PrintParams.ToPage,PrintParams.PrintInBackground);
    SentToPrinter:=True;
  finally
    // controle de foco para CLX
    if not Assigned(priorfocus) or not ((priorfocus is TCustomEdit) or (priorfocus is TCustomComboBox)) then
      priorfocus:=EditPageNo;
    priorfocus.SetFocus;
  end;
  if Assigned(SetupInstance) and Assigned(SetupInstance.AfterPrint) then
    SetupInstance.AfterPrint(Self);
end;

procedure TRLPreviewForm.SpeedButtonFirstClick(Sender: TObject);
begin
  Preview.FirstPage;
end;

procedure TRLPreviewForm.SpeedButtonLastClick(Sender: TObject);
begin
  Preview.LastPage;
end;

procedure TRLPreviewForm.SpeedButtonSetupClick(Sender: TObject);
begin
  RLPrinter.ExecuteSetup;
end;

function FormatFileName(const aFileName:string):string;
var
  i:integer;
begin
  Result:=Trim(aFileName);
  for i:=Length(Result) downto 1 do
    if Result[i] in [#0..#31,#127,'?','*',':','/','\','>','<','|','"'] then
      Delete(Result,i,1);
end;

procedure TRLPreviewForm.SpeedButtonSaveClick(Sender: TObject);
var
  priorfocus:TWinControl;
begin
  if Assigned(SetupInstance) and Assigned(SetupInstance.BeforeSave) then
    SetupInstance.BeforeSave(Self);
  priorfocus:=Screen.ActiveControl;
  try
    SaveParams.Clear;
    SaveParams.MaxPage :=Preview.Pages.PageCount;
    SaveParams.FileName:=ExpandFileName(FormatFileName(Self.Preview.Pages.Title));
    if SaveParams.FileName='' then
      if Assigned(SaveParams.Filter) then
        SaveParams.FileName:=SaveParams.Filter.FileName;
    with TRLSaveDialog.Create(nil) do
      try
        if not Execute then
          Exit;
      finally
        Free;
      end;
    if Assigned(SaveParams.Filter) then
    begin
      SaveParams.Filter.FileName:=SaveParams.FileName;
      SaveParams.Filter.FilterPages(Preview.Pages,SaveParams.FromPage,SaveParams.ToPage,SaveParams.SaveInBackground);
    end
    else
      Preview.Pages.SaveToFile(SaveParams.FileName);
  finally
    // controle de foco para CLX
    if not Assigned(priorfocus) or not ((priorfocus is TCustomEdit) or (priorfocus is TCustomComboBox)) then
      priorfocus:=EditPageNo;
    priorfocus.SetFocus;
  end;
  if Assigned(SetupInstance) and Assigned(SetupInstance.AfterSave) then
    SetupInstance.AfterSave(Self);
end;

procedure TRLPreviewForm.SpeedButtonSendClick(Sender: TObject);
begin
  if Assigned(SetupInstance) and Assigned(SetupInstance.BeforeSend) then
    SetupInstance.BeforeSend(Self);
  if Assigned(SetupInstance) and Assigned(SetupInstance.OnSend) then
    SetupInstance.OnSend(Self);
  if Assigned(SetupInstance) and Assigned(SetupInstance.AfterSend) then
    SetupInstance.AfterSend(Self);
end;

procedure TRLPreviewForm.SpeedButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TRLPreviewForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    KEY_ESCAPE: SpeedButtonClose.Click;
    KEY_HOME  : if ssCtrl in Shift then
                  Preview.FirstPage
                else
                  Preview.PageLeft;
    KEY_PRIOR : if ssCtrl in Shift then
                  Preview.PageTop
                else
                  Preview.PriorPage;
    KEY_NEXT  : if ssCtrl in Shift then
                  Preview.PageBottom
                else
                  Preview.NextPage;
    KEY_END   : if ssCtrl in Shift then
                  Preview.LastPage
                else
                  Preview.PageRight;
    KEY_UP    : if ssCtrl in Shift then
                  Preview.HalfPageUp
                else
                  Preview.ScrollUp;
    KEY_DOWN  : if ssCtrl in Shift then
                  Preview.HalfPageDown
                else
                  Preview.ScrollDown;
    KEY_LEFT  : if ssCtrl in Shift then
                  Preview.HalfPageLeft
                else
                  Preview.ScrollLeft;
    KEY_RIGHT : if ssCtrl in Shift then
                  Preview.HalfPageRight
                else
                  Preview.ScrollRight;
    Ord('F'),
    KEY_F3    : if ssCtrl in Shift then
                  ShowFindDialog
                else
                  Exit;
  else
    Exit;
  end;
  //
  Key:=0;
end;

procedure TRLPreviewForm.ShowFindDialog;
begin
  if not Assigned(fFindDialog) then
  begin
    fFindDialog:=TfrmRLFindDialog.CreateNew(nil);
    fFindDialog.OnFind:=OnFindHandler;
  end;
  fFindDialog.ActiveControl:=fFindDialog.EditTextToFind;
  fFindDialog.Show;
end;

procedure TRLPreviewForm.OnFindHandler(Sender:TObject; const Text:string; Options:TRLFindOptions; var Found:boolean);
begin
  Found:=Preview.FindText(Text,foWholeWords in Options,foMatchCase in Options,foFindBackward in Options);
end;

procedure TRLPreviewForm.UpdateComboBoxZoom;
var
  savedevent:TNotifyEvent;
begin
  if fEditingZoom then
    Exit;
  savedevent:=ComboBoxZoom.OnChange;
  try
    ComboBoxZoom.ItemIndex:=-1;
    ComboBoxZoom.Text     :=FloatToStr(Preview.ZoomFactor)+'%';
  finally
    ComboBoxZoom.OnChange:=savedevent;
  end;
end;

procedure TRLPreviewForm.UpdateEditPageNo;
var
  savedevent:TNotifyEvent;
begin
  if fEditingPageNo then
    Exit;
  savedevent:=EditPageNo.OnChange;
  try
    EditPageNo.Text:=IntToStr(Preview.PageIndex+1);
  finally
    EditPageNo.OnChange:=savedevent;
  end;
end;

procedure TRLPreviewForm.rpvDefaultChangeView(Sender: TObject);
begin
  PanelPageCount.Caption:=inttostr(Preview.Pages.PageCount);
  UpdateEditPageNo;
  UpdateComboBoxZoom;
end;

procedure TRLPreviewForm.TimerRepeatTimer(Sender: TObject);
begin
  if TimerRepeat.Tag>500 then
    if SpeedButtonPrior.Tag>0 then
      if SpeedButtonNext.Tag>0 then
        Exit
      else
        Preview.PriorPage
    else if SpeedButtonNext.Tag>0 then
      Preview.NextPage
    else
      Exit;
  TimerRepeat.Tag:=TimerRepeat.Tag+integer(TimerRepeat.Interval);
end;

procedure TRLPreviewForm.SpeedButtonPriorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button<>mbLeft then
    Exit;
  TSpeedButton(Sender).Tag:=1;
  TimerRepeat.Tag:=0;
  if Sender=SpeedButtonPrior then
    Preview.PriorPage
  else if Sender=SpeedButtonNext then
    Preview.NextPage;
end;

procedure TRLPreviewForm.SpeedButtonPriorMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button<>mbLeft then
    Exit;
  TSpeedButton(Sender).Tag:=0;
end;

procedure TRLPreviewForm.SpeedButtonZoomUpClick(Sender: TObject);
begin
  Preview.ZoomFactor:=Preview.ZoomFactor+10;
  UpdateComboBoxZoom;
end;

procedure TRLPreviewForm.SpeedButtonZoomDownClick(Sender: TObject);
begin
  Preview.ZoomFactor:=Max(10,Preview.ZoomFactor-10);
  UpdateComboBoxZoom;
end;

procedure TRLPreviewForm.SpeedButtonViewsClick(Sender: TObject);
begin
  if fPreviewList.Count>1 then
    ReleasePreview
  else
    NewPreview;
  OrganizePreviews;
end;

procedure TRLPreviewForm.SpeedButtonEditClick(Sender: TObject);
begin
  Preview.Editing:=not Preview.Editing;
end;

function TRLPreviewForm.GetPreview:TRLPreview;
begin
  Result:=TRLPreview(fPreviewList[fPreviewIndex]);
end;

procedure TRLPreviewForm.PreviewEnter(Sender: TObject);
begin
  SetPreview(TRLPreview(Sender));
end;

procedure TRLPreviewForm.SetPreview(aPreview: TRLPreview);
begin
  if Assigned(fActivePreview) then
    fActivePreview.SetActive(False);
  fActivePreview:=aPreview;
  if Assigned(fActivePreview) then
    fActivePreview.SetActive(True);
  //
  fPreviewIndex:=fPreviewList.IndexOf(aPreview);
  UpdateEditPageNo;
  UpdateComboBoxZoom;
end;

{ TRLPreviewSetup }

constructor TRLPreviewSetup.Create(aOwner: TComponent);
begin
  fBeforePrint   :=nil;
  fAfterPrint    :=nil;
  fBeforeSave    :=nil;
  fAfterSave     :=nil;
  fBeforeSend    :=nil;
  fOnSend        :=nil;
  fAfterSend     :=nil;
  fEnabledButtons:=[pbPrint,pbSave,pbSend];
  fEditOptions   :=[];
  //
  inherited;
  //
  if not (csDesigning in ComponentState) then
  begin
    if Assigned(SetupInstance) then
      raise Exception.Create('Only one instance of '+ClassName+' is allowed.');
    SetupInstance:=Self;
  end;  
end;

destructor TRLPreviewSetup.Destroy;
begin
  if SetupInstance=Self then
    SetupInstance:=nil;
  //
  inherited;
end;

function TRLPreviewSetup.GetBorderIcons: TBorderIcons;
begin
  Result:=DefaultBorderIcons;
end;

function TRLPreviewSetup.GetCaption: string;
begin
  Result:=DefaultCaption;
end;

function TRLPreviewSetup.GetFormStyle: TFormStyle;
begin
  Result:=DefaultFormStyle;
end;

function TRLPreviewSetup.GetHelpContext: integer;
begin
  Result:=DefaultHelpContext;
end;

function TRLPreviewSetup.GetHelpFile: string;
begin
  Result:=DefaultHelpFile;
end;

function TRLPreviewSetup.GetPosition: TPosition;
begin
  Result:=DefaultPosition;
end;

function TRLPreviewSetup.GetSentToPrinter: boolean;
begin
  Result:=RLPreviewForm.SentToPrinter;
end;

function TRLPreviewSetup.GetShowModal: boolean;
begin
  Result:=DefaultShowModal;
end;

function TRLPreviewSetup.GetWindowBounds: TRect;
begin
  Result:=DefaultWindowBounds;
end;

function TRLPreviewSetup.GetWindowState: TWindowState;
begin
  Result:=DefaultWindowState;
end;

function TRLPreviewSetup.GetZoomFactor: double;
begin
  Result:=DefaultZoomFactor;
end;

function TRLPreviewSetup.IsZoomFactor: Boolean;
begin
  Result:=(DefaultZoomFactor<>100);
end;

procedure TRLPreviewSetup.SetBorderIcons(const Value: TBorderIcons);
begin
  DefaultBorderIcons:=Value;
end;

procedure TRLPreviewSetup.SetCaption(const Value: string);
begin
  DefaultCaption:=Value;
end;

procedure TRLPreviewSetup.SetEditOptions(const Value: TRLPreviewEditOptionsSet);
begin
  fEditOptions := Value;
end;

procedure TRLPreviewSetup.SetEnabledButtons(const Value: TRLPreviewFormButtonsSet);
begin
  fEnabledButtons := Value;
end;

procedure TRLPreviewSetup.SetFormStyle(const Value: TFormStyle);
begin
  DefaultFormStyle:=Value;
end;

procedure TRLPreviewSetup.SetHelpContext(const Value: integer);
begin
  DefaultHelpContext:=Value;
end;

procedure TRLPreviewSetup.SetHelpFile(const Value: string);
begin
  DefaultHelpFile:=Value;
end;

procedure TRLPreviewSetup.SetPosition(const Value: TPosition);
begin
  DefaultPosition:=Value;
end;

procedure TRLPreviewSetup.SetSentToPrinter(const Value: boolean);
begin
  RLPreviewForm.SentToPrinter:=Value;
end;

procedure TRLPreviewSetup.SetShowModal(const Value: boolean);
begin
  DefaultShowModal:=Value;
end;

procedure TRLPreviewSetup.SetWindowBounds(const Value: TRect);
begin
  DefaultWindowBounds:=Value;
end;

procedure TRLPreviewSetup.SetWindowState(const Value: TWindowState);
begin
  DefaultWindowState:=Value;
end;

procedure TRLPreviewSetup.SetZoomFactor(const Value: double);
begin
  DefaultZoomFactor:=Value;
end;

end.

