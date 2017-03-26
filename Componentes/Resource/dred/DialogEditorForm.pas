unit DialogEditorForm;
                  
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, ExtCtrls, ComCtrls, DialogEditor, cmpRuler, StdCtrls,
  cmpSizingPageControl, ToolWin, Grids, cmpPropertyListBox, ImgList,
  DialogBox;

const WM_SETRULERS = WM_USER + $310;

type
  TfmDialogEditor = class(TfmResourceEditor)
    pnlTopMargin: TPanel;
    pnlLeftMargin: TPanel;
    ScrollBox1: TScrollBox;
    DialogBox1: TDialogEditor;
    Ruler1: TRuler;
    Ruler2: TRuler;
    SizingPageControl1: TSizingPageControl;
    pnlDlgControls: TPanel;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    btnArrow: TToolButton;
    btnPicture: TToolButton;
    btnStatic: TToolButton;
    btnEdit: TToolButton;
    btnGroupBox: TToolButton;
    btnButton: TToolButton;
    btnCheckBox: TToolButton;
    btnRadioButton: TToolButton;
    btnComboBox: TToolButton;
    btnListBox: TToolButton;
    btnHScroll: TToolButton;
    btnVScroll: TToolButton;
    btnUpDown: TToolButton;
    btnProgressBar: TToolButton;
    btnSlider: TToolButton;
    btnHotKey: TToolButton;
    btnListCtrl: TToolButton;
    btnTreeCtrl: TToolButton;
    btnPageCtrl: TToolButton;
    btnAnimate: TToolButton;
    btnRichText: TToolButton;
    btnDateTimePicker: TToolButton;
    btnMonthCal: TToolButton;
    btnIPAddress: TToolButton;
    btnCustom: TToolButton;
    btnExtComboBox: TToolButton;
    pnlControlProperties: TPanel;
    PropertyListBox1: TPropertyListBox;
    procedure DialogBox1Resize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DialogBox1DesignModeSelectedItemChange(Sender: TObject);
    procedure SizingPageControl1UnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure SizingPageControl1DockDrop(Sender: TObject;
      Source: TDragDockObject; X, Y: Integer);
    procedure ListView1Editing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
    procedure PropertyListBox1PropertyChanged(Sender: TObject);
    procedure btnArrowClick(Sender: TObject);
    procedure DialogBox1DesignModeDropControl(sender: TObject; x,
      y: Integer; control: TDropControl);
    procedure DialogBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    fPCWidth : Integer;
    fPanelNames : TStringList;
    fInitializingProperties : boolean;
    procedure WmSetRulers (var message : TMessage); message WM_SETRULERS;
    procedure SaveResource (const undoDescription : string);
  protected
  public
    procedure DoResourceChanged; override;
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
  end;

var
  fmDialogEditor: TfmDialogEditor;

implementation

uses MainForm, ResourceDialogs;

{$R *.DFM}

{ TfmDialogEditor }

procedure TfmDialogEditor.DoResourceChanged;
var
  res : TDialogResource;
begin
  res := Resource as TDialogResource;
  DialogBox1.ResourceTemplate := res.DlgTemplate;
  PostMessage (handle, WM_SETRULERS, 0, 0);
end;

procedure TfmDialogEditor.DialogBox1Resize(Sender: TObject);
begin
  inherited;
  Ruler1.Width := DialogBox1.Width;
  Ruler2.Height := DialogBox1.Height;
end;

procedure TfmDialogEditor.FormShow(Sender: TObject);
begin
  inherited;
  fPCWidth := pnlControlProperties.Width;

  pnlControlProperties.Tag := fPanelNames.Add (pnlControlProperties.Caption);
  pnlDlgControls.Tag := fPanelNames.Add (pnlDlgControls.Caption);
  pnlControlProperties.Caption := '';

  SizingPageControl1.Width := fPCWidth;
  pnlControlProperties.UndockHeight := pnlControlProperties.Height;
  pnlControlProperties.ManualDock (SizingPageControl1, Nil, alNone);

  pnlDlgControls.UndockHeight := pnlDlgControls.Height;
  pnlDlgControls.ManualDock (SizingPageControl1, Nil, alNone);
end;

procedure TfmDialogEditor.WmSetRulers(var message: TMessage);
begin
  Ruler1.DialogBox := DialogBox1.DialogHandle;
  Ruler2.DialogBox := DialogBox1.DialogHandle;
end;

procedure TfmDialogEditor.Button1Click(Sender: TObject);
begin
  inherited;
  DialogBox1.Height := DialogBox1.Height + 5;
end;

procedure TfmDialogEditor.DialogBox1DesignModeSelectedItemChange(
  Sender: TObject);
var
  controlInfo : TControlInfo;
  id : Integer;
  i : Integer;
  nm : string;
  prop : TPropertyListProperty;
  value : variant;

begin
  id := DialogBox1.DesignModeSelectedItemID;

  controlInfo := DialogBox1.GetControlInfo (id);

  fInitializingProperties := True;
  PropertyListBox1.Properties.BeginUpdate;
  try
    PropertyListBox1.Properties.Clear;
    for i := 0 to controlInfo.CtrlPropertyCount - 1 do
    begin
      nm := controlInfo.CtrlPropertyName [i];
      prop := TPropertyListProperty.Create (PropertyListBox1.Properties);
      prop.PropertyName := nm;
      value := controlInfo.CtrlProperty [nm];
      case VarType (value) of
        varInteger : prop.PropertyType := ptInteger;
        varBoolean : prop.PropertyType := ptBoolean;
        varString  : prop.PropertyType := ptString;
      end;
      prop.PropertyValue := value;
    end
  finally
    fInitializingProperties := False;
    PropertyListBox1.Properties.EndUpdate
  end
end;

procedure TfmDialogEditor.SizingPageControl1UnDock(Sender: TObject;
  Client: TControl; NewTarget: TWinControl; var Allow: Boolean);
var
  clientPanel : TPanel;
begin
  inherited;
  if SizingPageControl1.PageCount = 1 then
    SizingPageControl1.Width := 0;

  if Client is TPanel then
  begin
    clientPanel := TPanel (Client);
    clientPanel.Caption := fPanelNames [TPanel (Client).Tag];
  end
end;

procedure TfmDialogEditor.SizingPageControl1DockDrop(Sender: TObject;
  Source: TDragDockObject; X, Y: Integer);
var
  i : Integer;
begin
  inherited;
  with SizingPageControl1 do
  begin
    if Source.Control is TPanel then
      TPanel (Source.Control).Caption := '';

    for i := 0 to PageCount - 1 do
      Pages [i].Caption := fPanelNames [Pages [i].Controls [0].Tag];

    Width := fPCWidth + 8;
  end

end;

procedure TfmDialogEditor.ListView1Editing(Sender: TObject;
  Item: TListItem; var AllowEdit: Boolean);
begin
  inherited;
  AllowEdit := True;
end;

constructor TfmDialogEditor.Create(AOwner: TComponent);
begin
  inherited;
  fPanelNames := TStringList.Create;
end;

destructor TfmDialogEditor.Destroy;
begin
  fPanelNames.Free;
  inherited;
end;

procedure TfmDialogEditor.PropertyListBox1PropertyChanged(Sender: TObject);
var
  prop : TPropertyListProperty;
  id : Integer;
  controlInfo : TControlInfo;
begin
  if not fInitializingProperties then
    with PropertyListBox1 do
    begin
      if SelectedPropertyNo >= Properties.Count then Exit;

      prop := Properties [SelectedPropertyNo];

      id := DialogBox1.DesignModeSelectedItemID;

      controlInfo := DialogBox1.GetControlInfo (id);

      controlInfo.CtrlProperty [prop.PropertyName] := prop.PropertyValue;
    end
end;

procedure TfmDialogEditor.SaveResource;
var
  res : TDialogResource;
  controlInfo : TControlInfo;
begin
  inherited;
  res := Resource as TDialogResource;
  controlInfo := DialogBox1.GetControlInfo (0);
  res.Caption := controlInfo.CtrlProperty ['Text'];
end;

procedure TfmDialogEditor.btnArrowClick(Sender: TObject);
begin
  inherited;
  if Sender is TToolButton then
    DialogBox1.DropComponent := TDropControl (TToolButton (sender).Tag);
end;

procedure TfmDialogEditor.DialogBox1DesignModeDropControl(sender: TObject;
  x, y: Integer; control: TDropControl);
var
  ctrl : TDialogResourceControl;
  pt : TPoint;
  infoClass : TControlInfoClass;
begin
  pt := DialogBox1.PointToDialogPoint (POINT (x, y));

  ctrl := TDialogResourceControl.Create (Resource as TDialogResource);
  ctrl.Left := pt.x;
  ctrl.Top := pt.y;
  ctrl.Width := 79;
  ctrl.Height := 13;
  ctrl.ExStyle := 0;

  infoClass := GetControlInfoClass (control);
  if Integer (infoClass.GetClassName) < $10000 then
    ctrl.ClassId := Integer (infoClass.GetClassName)
  else
  begin
    ctrl.ClassId := 0;
    ctrl.ClassNm := infoClass.GetClassName
  end;

  ctrl.Style := infoClass.GetDefaultStyle or WS_CHILD or WS_VISIBLE;

  TDialogResource (resource).AddControl (ctrl);
  DoResourceChanged
end;

procedure TfmDialogEditor.DialogBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ctrlID : Integer;
  i : Integer;
begin
  if Key = VK_DELETE then
  begin
    ctrlID := DialogBox1.DesignModeSelectedItemID;
    with Resource as TDialogResource do
    begin
      for i := 0 to ControlCount - 1 do
        if Control [i].ID = ctrlID then
        begin
          DeleteControl (i);
          break
        end
    end;

    DoResourceChanged

  end
end;

end.
