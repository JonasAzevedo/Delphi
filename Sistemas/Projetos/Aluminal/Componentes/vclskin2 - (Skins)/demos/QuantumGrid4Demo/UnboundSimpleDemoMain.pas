unit UnboundSimpleDemoMain;

//{$I ..\..\cxDemos.inc}

interface

uses
  Windows, Messages, SysUtils{$IFDEF DELPHI6}, Variants{$ENDIF}, Classes, Controls,
  Forms, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxEdit,
  cxEditRepositoryItems, cxGridTableView,  ActnList, ImgList,
  Menus, cxGridLevel, cxGridCustomTableView, cxClasses, Dialogs,
  cxControls, cxGridCustomView, cxGrid, ComCtrls, StdCtrls, cxDataStorage, ShellAPI,
  WinSkinData,SkinEQGrid, cxLookAndFeelPainters, cxButtons, cxDBEdit,
  cxGroupBox, cxRadioGroup, cxContainer, cxCheckBox, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, cxCalc, cxCalendar, Buttons, ShlObj, cxShellCommon,
  cxDBExtLookupComboBox, cxShellComboBox, cxNavigator, cxLookAndFeels;

type
  TUnboundSimpleDemoMainForm = class(TForm)
    mmMain: TMainMenu;
    miAbout: TMenuItem;
    miHelp: TMenuItem;
    miDeveloperExpressontheweb: TMenuItem;
    miForum: TMenuItem;
    miDownloads: TMenuItem;
    miSeparator4: TMenuItem;
    miGridHelp: TMenuItem;
    miProducts: TMenuItem;
    miSeparator3: TMenuItem;
    ilMain: TImageList;
    sty: TActionList;
    actHelp: TAction;
    actProducts: TAction;
    actDownloads: TAction;
    actForum: TAction;
    actDXOnTheWeb: TAction;
    actAbout: TAction;
    miFile: TMenuItem;
    miOptions: TMenuItem;
    miExit: TMenuItem;
    actExit: TAction;
    sbMain: TStatusBar;
    actShowDemoDescription: TAction;
    miShowDemoDescription: TMenuItem;
    actGridNativeStyle: TAction;
    cxGrid: TcxGrid;
    miGridLookFeel: TMenuItem;
    miKind: TMenuItem;
    miFlat: TMenuItem;
    miStandard: TMenuItem;
    miUltraFlat: TMenuItem;
    miNativeStyle: TMenuItem;
    miSeparator2: TMenuItem;
    lvPlanets: TcxGridLevel;
    tvPlanets: TcxGridTableView;
    lbDescrip: TLabel;
    tvPlanetsNAME: TcxGridColumn;
    tvPlanetsNO: TcxGridColumn;
    tvPlanetsORBITS: TcxGridColumn;
    tvPlanetsDISTANCE: TcxGridColumn;
    tvPlanetsPERIOD: TcxGridColumn;
    tvPlanetsDISCOVERER: TcxGridColumn;
    tvPlanetsDATE: TcxGridColumn;
    tvPlanetsRADIUS: TcxGridColumn;
    cxRadioButton1: TcxRadioButton;
    cxRadioButton2: TcxRadioButton;
    cxCheckBox1: TcxCheckBox;
    cxCheckBox2: TcxCheckBox;
    cxRadioGroup1: TcxRadioGroup;
    cxButton1: TcxButton;
    SkinData1: TSkinData;
    cxLookupComboBox1: TcxLookupComboBox;
    cxCalcEdit1: TcxCalcEdit;
    cxDateEdit2: TcxDateEdit;
    cxShellComboBox1: TcxShellComboBox;
    cxExtLookupComboBox1: TcxExtLookupComboBox;
    cxNavigator1: TcxNavigator;
    cxLookAndFeelController1: TcxLookAndFeelController;
    cxButton2: TcxButton;
    procedure AlwaysEnabled(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actProductsExecute(Sender: TObject);
    procedure actDownloadsExecute(Sender: TObject);
    procedure actForumExecute(Sender: TObject);
    procedure actDXOnTheWebExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actShowDemoDescriptionExecute(Sender: TObject);
    procedure actGridNativeStyleExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miUltraFlatClick(Sender: TObject);
    procedure miStandardClick(Sender: TObject);
    procedure miFlatClick(Sender: TObject);
    procedure SkinData1SkinChanged(Sender: TObject);
    procedure SkinData1SkinControl(Sender: TComponent; SkinData: TSkinData;
      Form, Control: TControl; ControlClass: String;
      var SkinnedControl: TComponent);
    procedure Button1Click(Sender: TObject);
  private
    procedure CustomizeColumns;
    procedure LoadData;
    procedure SetFilter;
  end;

var
  UnboundSimpleDemoMainForm: TUnboundSimpleDemoMainForm;

implementation

uses
  UnboundSimpleDemoAbout;

{$R *.dfm}

procedure TUnboundSimpleDemoMainForm.AlwaysEnabled(Sender: TObject);
begin
  TCustomAction(Sender).Enabled := True;
end;

procedure TUnboundSimpleDemoMainForm.actAboutExecute(Sender: TObject);
begin
  with TUnboundSimpleDemoAboutForm.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TUnboundSimpleDemoMainForm.actProductsExecute(Sender: TObject);
begin
  ShellExecute(Handle, PChar('OPEN'), PChar('http://www.devexpress.com/products/index.asp'), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TUnboundSimpleDemoMainForm.actDownloadsExecute(Sender: TObject);
begin
  ShellExecute(Handle, PChar('OPEN'), PChar('http://www.devexpress.com/downloads/index.asp'), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TUnboundSimpleDemoMainForm.actForumExecute(Sender: TObject);
begin
  ShellExecute(Handle, PChar('OPEN'), PChar('http://24.234.251.34/dxforum/dxforumisapi.dll/'), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TUnboundSimpleDemoMainForm.actDXOnTheWebExecute(
  Sender: TObject);
begin
  ShellExecute(Handle, PChar('OPEN'), PChar('http://www.devexpress.com/index.shtm'), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TUnboundSimpleDemoMainForm.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TUnboundSimpleDemoMainForm.actShowDemoDescriptionExecute(
  Sender: TObject);
begin
  lbDescrip.Visible := not lbDescrip.Visible;
  TCustomAction(Sender).Checked := not TCustomAction(Sender).Checked;
end;

procedure TUnboundSimpleDemoMainForm.actGridNativeStyleExecute(Sender: TObject);
begin
  cxGrid.LookAndFeel.NativeStyle := not cxGrid.LookAndFeel.NativeStyle;
  cxLookAndFeelController1.NativeStyle :=  not cxLookAndFeelController1.NativeStyle;
  TCustomAction(Sender).Checked := cxGrid.LookAndFeel.NativeStyle;
end;

procedure TUnboundSimpleDemoMainForm.FormShow(Sender: TObject);
begin
{ remove/add the closing brace on this line to disable/enable the following code

  ShowMessage('WARNING: tutorial not completed. First, please apply the steps '+
              'shown in the UnboundSimpleDemo.doc file');

}
end;


procedure TUnboundSimpleDemoMainForm.FormCreate(Sender: TObject);
begin
//{ remove/add the closing brace on this line to disable/enable the following code

  CustomizeColumns;
  LoadData;
  SetFilter;
  InitStyle(SkinData1);
  //}
end;


procedure TUnboundSimpleDemoMainForm.CustomizeColumns;
const
  cDistance = 3;
  cPeriod = 4;
  cRadius = 7;
var
  I: Integer;
begin
  DecimalSeparator := '.';
  with tvPlanets do
  for I := 0 to ColumnCount - 1 do
    if I in [cDistance, cRadius] then
      Columns[I].DataBinding.ValueTypeClass := TcxIntegerValueType
    else
      if I in [cPeriod] then
      Columns[I].DataBinding.ValueTypeClass := TcxFloatValueType
      else
       Columns[I].DataBinding.ValueTypeClass := TcxStringValueType;
end;

procedure TUnboundSimpleDemoMainForm.LoadData;
const
  AFileName = 'nineplanets.txt';
  AHeaderLineCount = 2;

var
  ARecords, AValues: TStringList;
  I: Integer;

  procedure InitRecord(const Str: string);
  var
    J: Integer;
    V: Variant;
  begin
    AValues.CommaText := Str;
    for J := 0 to AValues.Count - 1 do
     if AValues.Strings[J] <> '-' then
     begin
      V := AValues.Strings[J];
//      if not VarIsNull(V) then
        tvPlanets.DataController.Values[I, J] := V;
     end;
  end;

begin
  if not FileExists(AFileName) then
    raise Exception.Create('Data file not found');

  ARecords := TStringList.Create;
  AValues := TStringList.Create;

  with ARecords do
  try
    LoadFromFile(AFileName);
    tvPlanets.BeginUpdate;
    tvPlanets.DataController.RecordCount := Count - AHeaderLineCount;
    for I := 0 to Count - (AHeaderLineCount + 1) do
      InitRecord(Strings[I + AHeaderLineCount]);
  finally
    tvPlanets.EndUpdate;
    ARecords.Free;
    AValues.Free;
  end;
end;

procedure TUnboundSimpleDemoMainForm.SetFilter;
begin
//  tvPlanets.DataController.Filter.AddItem(nil, tvPlanetsORBITS, foEqual, 'Sun', 'Sun');
//  tvPlanets.DataController.Filter.Active := false;
end;

procedure TUnboundSimpleDemoMainForm.miUltraFlatClick(Sender: TObject);
begin
  cxGrid.LookAndFeel.Kind := lfUltraFlat;
  cxLookAndFeelController1.Kind := lfUltraFlat;
  TMenuItem(Sender).Checked := True;
end;

procedure TUnboundSimpleDemoMainForm.miStandardClick(Sender: TObject);
begin
  cxGrid.LookAndFeel.Kind := lfStandard;
  cxLookAndFeelController1.Kind := lfStandard;
  TMenuItem(Sender).Checked := True;
end;

procedure TUnboundSimpleDemoMainForm.miFlatClick(Sender: TObject);
begin
  cxGrid.LookAndFeel.Kind := lfFlat;
  cxLookAndFeelController1.Kind := lfFlat;
  TMenuItem(Sender).Checked := True;
end;

procedure TUnboundSimpleDemoMainForm.actHelpExecute(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TUnboundSimpleDemoMainForm.SkinData1SkinChanged(Sender: TObject);
begin
    doskinchanged(sender);
end;

procedure TUnboundSimpleDemoMainForm.SkinData1SkinControl(
  Sender: TComponent; SkinData: TSkinData; Form, Control: TControl;
  ControlClass: String; var SkinnedControl: TComponent);
begin
    doskincontrol(sender,skindata,form,control,controlclass,skinnedcontrol);
end;

procedure TUnboundSimpleDemoMainForm.Button1Click(Sender: TObject);
begin
   skindata1.active:=not skindata1.active;
end;

end.
