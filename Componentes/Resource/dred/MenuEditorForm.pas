unit MenuEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, Menus, StdCtrls, cmpMenuDesigner, ExtCtrls,
  ActnList, ResourceMenus;

type
  TfmMenuEditor = class(TfmResourceEditor)
    ScrollBox1: TScrollBox;
    MenuDesigner1: TMenuDesigner;
    alMenuEditor: TActionList;
    actMenuInsertItem: TAction;
    MainMenu1: TMainMenu;
    actMenuDeleteItem: TAction;
    mnuMenu: TMenuItem;
    mnuMenuInsertItem: TMenuItem;
    mnuMenuDeleteItem: TMenuItem;
    N1: TMenuItem;
    actMenuCreateSubMenu: TAction;
    mnuMenUCreateSubMenu: TMenuItem;
    pomMenu: TPopupMenu;
    InsertItem1: TMenuItem;
    DeleteItem1: TMenuItem;
    N2: TMenuItem;
    CreateSubMenu1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edCaption: TEdit;
    cbShortcut: TComboBox;
    edID: TEdit;
    Splitter1: TSplitter;
    actMenuInsertItemAfter: TAction;
    InsertItemAfter1: TMenuItem;
    InsertItemAfter2: TMenuItem;
    cbEnabled: TCheckBox;
    cbChecked: TCheckBox;
    procedure MenuDesigner1SelectedItemChange(Sender: TObject);
    procedure cbShortcutChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actMenuInsertItemExecute(Sender: TObject);
    procedure actMenuDeleteItemExecute(Sender: TObject);
    procedure actMenuCreateSubMenuExecute(Sender: TObject);
    procedure edIDEnter(Sender: TObject);
    procedure edIDExit(Sender: TObject);
    procedure actMenuInsertItemAfterExecute(Sender: TObject);
    procedure edCaptionChange(Sender: TObject);
    procedure edCaptionEnter(Sender: TObject);
    procedure edCaptionExit(Sender: TObject);
    procedure cbEnabledClick(Sender: TObject);
  private
    fIDSave : string;
    fSaveCaption : string;
    fLastRes : TMenuResource;
    fInitializing : boolean;
    function GetShortcutIndex (const s : string) : Integer;
    procedure SaveResource (const undoDescription : string);
  protected
    procedure CreateParams (var params : TCreateParams); override;
  public
    procedure DoResourceChanged; override;
  end;

var
  fmMenuEditor: TfmMenuEditor;

implementation

resourceString
  rstNone = 'None';
  rstShift = 'Shift';
  rstCtrl = 'Ctrl';
  rstCaptionChange = 'change caption';
  rstCreateSubMenu = 'create submenu';
  rstInsertItem = 'insert item';
  rstDeleteItem = 'delete item';
  rstFlagsChange = 'change flags';

{$R *.DFM}

procedure TfmMenuEditor.CreateParams(var params: TCreateParams);
begin
  inherited;
end;

procedure TfmMenuEditor.DoResourceChanged;
var
  res : TMenuResource;
  item : TMenuItem;
begin
  fInitializing := True;
  try
    res := Resource as TMenuResource;
    item := TMenuItem.Create (Nil);
    try
      res.GetItems (item);
      MenuDesigner1.SetItems (item, res = fLastRes);
      fLastRes := res;
    finally
      item.Free
    end
  finally
    fInitializing := False
  end
end;

procedure TfmMenuEditor.MenuDesigner1SelectedItemChange(Sender: TObject);
var
  item : TDesignerMenuItem;
  s : string;
begin
  inherited;
  fInitializing := True;
  try
    item := TDesignerMenuItem (MenuDesigner1.SelectedItem);
    edCaption.Text := ExtractCaption (item.Caption);
    s := ExtractShortcut (item.Caption);

    cbShortcut.ItemIndex := GetShortcutIndex (s);
    cbShortcut.Text := s;

    if Assigned (item) then
      edID.Text := IntToStr (item.ID)
    else
      edID.Text := '';

    cbEnabled.Checked := item.Enabled;
    cbChecked.Checked := item.Checked
  finally
    fInitializing := False
  end
end;

procedure TfmMenuEditor.cbShortcutChange(Sender: TObject);
var
  item : TMenuItem;
  s : string;
begin
  inherited;
  item := MenuDesigner1.SelectedItem;
  if Assigned (item) then
  begin
    s := cbShortcut.Text;
    if s = '(' + rstNone + ')' then
      s := '';

    item.Caption := MergeCaption (ExtractCaption (item.Caption), s);
  end
end;

procedure TfmMenuEditor.FormShow(Sender: TObject);
var
  ch : char;
begin
  inherited;
  cbShortcut.Items.Add ('(' + rstNone + ')');
  for ch := 'A' to 'Z' do
    cbShortcut.Items.Add (rstCtrl + '+' + ch);

end;

function TfmMenuEditor.GetShortcutIndex(const s: string): Integer;
begin
  if s = '' then
    result := 0
  else
  begin
    for result := 0 to cbShortcut.Items.Count - 1 do
      if CompareText (s, cbShortcut.Items [result]) = 0 then
        break;
    if result = cbShortcut.Items.Count then
      result := -1
  end
end;

procedure TfmMenuEditor.actMenuInsertItemExecute(Sender: TObject);
begin
  if Assigned (menuDesigner1.SelectedItem) then
  begin
    menuDesigner1.InsertItem (menuDesigner1.SelectedItem);
    SaveResource (rstInsertItem)
  end
end;

procedure TfmMenuEditor.actMenuDeleteItemExecute(Sender: TObject);
begin
  if Assigned (menuDesigner1.SelectedItem) then
  begin
    menuDesigner1.DeleteItem (menuDesigner1.SelectedItem);
    SaveResource (rstDeleteItem)
  end
end;

procedure TfmMenuEditor.actMenuCreateSubMenuExecute(Sender: TObject);
begin
  if Assigned (menuDesigner1.SelectedItem) then
  begin
    menuDesigner1.AddChildItem (menuDesigner1.SelectedItem);
    SaveResource (rstCreateSubMenu)
  end
end;

procedure TfmMenuEditor.SaveResource (const UndoDescription : string);
var
  res : TMenuResource;
begin
  inherited;
  res := Resource as TMenuResource;

  MenuDesigner1.RestoreTags;
  res.AddUndoEntry (UndoDescription);
  res.SetItems (menuDesigner1.Items);
end;

procedure TfmMenuEditor.edIDEnter(Sender: TObject);
begin
  inherited;
  fIDSave := edID.Text;
end;

procedure TfmMenuEditor.edIDExit(Sender: TObject);
var
  item : TDesignerMenuItem;
  newID : Integer;
begin
  inherited;

  if fIDSave <> edID.Text then
  begin
    item := TDesignerMenuItem (MenuDesigner1.SelectedItem);
    if Assigned (item) then
    try
      newID := StrToInt (edID.Text);
      item.ID := newID;
    except
    end;
    if MenuDesigner1.Dirty then
      SaveResource (rstCaptionChange);
  end

end;

procedure TfmMenuEditor.actMenuInsertItemAfterExecute(Sender: TObject);
begin
  if Assigned (menuDesigner1.SelectedItem) then
  begin
    menuDesigner1.AppendItem (menuDesigner1.SelectedItem);
    SaveResource (rstInsertItem)
  end
end;

procedure TfmMenuEditor.edCaptionChange(Sender: TObject);
var
  item : TMenuItem;
begin
  item := MenuDesigner1.SelectedItem;
  if Assigned (item) then
    item.Caption := MergeCaption (edCaption.Text, ExtractShortcut (item.Caption));
end;

procedure TfmMenuEditor.edCaptionEnter(Sender: TObject);
begin
  inherited;
  fSaveCaption := edCaption.Text
end;

procedure TfmMenuEditor.edCaptionExit(Sender: TObject);
begin
  inherited;
  if MenuDesigner1.Dirty then
    SaveResource (rstCaptionChange);
end;

procedure TfmMenuEditor.cbEnabledClick(Sender: TObject);
begin
  if (not fInitializing) and Assigned (menuDesigner1.SelectedItem) then
  begin
    menuDesigner1.SelectedItem.Enabled := cbEnabled.Checked;
    menuDesigner1.SelectedItem.Checked := cbChecked.Checked;
    SaveResource (rstFlagsChange);
  end
end;

end.
