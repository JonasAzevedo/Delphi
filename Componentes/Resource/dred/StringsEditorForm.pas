(*===========================================================================*
 | Delphi Resource Editor V 1.1                                              |
 |                                                                           |
 | unit StringsEditorForm                                                    |
 |                                                                           |
 | Editor form used when string or message resources are displayed           |
 *===========================================================================*)
unit StringsEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, ComCtrls, ResourceModule, StdCtrls, Menus, ActnList;

const
  WM_IDCHANGED = WM_USER + $205;

type
  TfmStringsEditor = class(TfmResourceEditor)
    lvStrings: TListView;
    mmoMessage: TMemo;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    actStringAddString: TAction;
    actStringModifyString: TAction;
    actStringDeleteString: TAction;
    mnuStrings: TMenuItem;
    AddString1: TMenuItem;
    ModifyString1: TMenuItem;
    DeleteString1: TMenuItem;
    PopupMenu1: TPopupMenu;
    AddString2: TMenuItem;
    ModifyString2: TMenuItem;
    DeleteString2: TMenuItem;
    procedure FormResize(Sender: TObject);
    procedure actStringModifyStringExecute(Sender: TObject);
    procedure lvStringsDblClick(Sender: TObject);
    procedure mmoMessageExit(Sender: TObject);
    procedure mmoMessageKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actStringDeleteStringExecute(Sender: TObject);
    procedure actStringAddStringExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvStringsEdited(Sender: TObject; Item: TListItem;
      var S: String);
  private
    fOldOwnerWindowProc : TFNWndProc;
    fObjectInstance : pointer;
    procedure OwnerWindowProc(var msg: TMessage);

    procedure AdjustMessageNos(startIdx, startMessageNo, delta: Integer);
    procedure SaveResource (const undoDescription : string);
    procedure DoListViewScrolled;
    procedure wmIDChanged (var msg : TMessage); message WM_IDCHANGED;
    { Private declarations }
  protected
    procedure UpdateActions; override;
    function GetEditSupport: TEditSupport; override;
  public
    procedure DoResourceChanged; override;
    procedure EditMenuSelected; override;
    function CaptionToInt (const caption : string) : Integer;
    function IntToCaption (i : Integer) : string;
    procedure EditUndo; override;
    procedure EditRedo; override;
    { Public declarations }
  end;

var
  fmStringsEditor: TfmStringsEditor;

implementation

{$R *.DFM}

uses ResourceForm, ResourceMessages, MainForm;

resourcestring
  rstStringChange = 'change string';
  rstIDChange = 'change ID';

{ TfmStringsEditor }

(*----------------------------------------------------------------------------*
 | procedure TfmStringsEditor.DoResourceChanged                               |
 |                                                                            |
 | Called when the user selects a resource.  Initialise the strings editor.   |
 *----------------------------------------------------------------------------*)
procedure TfmStringsEditor.DoResourceChanged;
var
  strings : TStringList;
  i : Integer;
begin
  strings := TStringList.Create;
  try
    with resource as TTextResource do GetStrings (strings);

    lvStrings.Items.BeginUpdate;
    with lvStrings.Items do
    try
      Clear;
      for i := 0 to strings.Count - 1 do
        with Add do
        begin
          caption := IntToCaption (Integer (strings.objects [i]));
          SubItems.Add (strings [i])
        end
    finally
      EndUpdate
    end
  finally
    strings.Free
  end
end;

(*----------------------------------------------------------------------------*
 | procedure TfmStringsEditor.FormResize                                      |
 |                                                                            |
 | Resize the mmo editor too                                                  |
 *----------------------------------------------------------------------------*)
procedure TfmStringsEditor.FormResize(Sender: TObject);
begin
  inherited;
  if mmoMessage.Visible then
    mmoMessage.Width := lvStrings.Width - 2;
end;

procedure TfmStringsEditor.actStringModifyStringExecute(Sender: TObject);
begin
  inherited;
  if Assigned (lvStrings.Selected) then
  begin
    mmoMessage.Width := lvStrings.Width - 2;
    mmoMessage.Top := lvStrings.Selected.DisplayRect (drLabel).Bottom;
    mmoMessage.Text := lvStrings.Selected.SubItems [0];
    if mmoMessage.Top + mmoMessage.Height > lvStrings.Top + lvStrings.Height then
    begin
      mmoMessage.Top := lvStrings.Selected.DisplayRect (drLabel).Top - mmoMessage.Height;
    end;
    mmoMessage.Visible := True;
    mmoMessage.SetFocus
  end
  else
    actStringAddString.Execute;
end;

procedure TfmStringsEditor.lvStringsDblClick(Sender: TObject);
begin
  inherited;
  if Assigned (lvStrings.Selected) then
    actStringModifyString.Execute
  else
    actStringAddString.Execute
end;

procedure TfmStringsEditor.mmoMessageExit(Sender: TObject);
begin
  inherited;
  mmoMessage.Visible := False;
  with lvStrings do if Assigned (Selected) then
  begin
    if mmoMessage.CanUndo then
    begin
      selected.SubItems [0] := mmoMessage.Text;
      AdjustMessageNos (selected.Index, CaptionToInt (selected.Caption), 1);
      SaveResource (rstStringChange);
      mmoMessage.ClearUndo
    end
  end;
end;

procedure TfmStringsEditor.UpdateActions;
begin
  actStringModifyString.Enabled := lvStrings.Focused and Assigned (lvStrings.Selected) and not mmoMessage.Visible;
  actStringDeleteString.Enabled := lvStrings.Focused and Assigned (lvStrings.Selected) and not mmoMessage.Visible;
  actStringAddString.Enabled := not mmoMessage.Visible
end;

procedure TfmStringsEditor.mmoMessageKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  if Key = VK_ESCAPE then
    GetParentForm (mmoMessage).ActiveControl := lvStrings;
end;

procedure TfmStringsEditor.AdjustMessageNos(startIdx, startMessageNo, delta: Integer);
var
  n : Integer;
begin
  if delta = -1 then
  begin
    Dec (startIdx);
    Dec (startMessageNo, 2);
    if startIdx < 0 then
      exit
  end;

  with lvStrings do
  begin
    while startIdx < Items.Count - 1 do
    begin
      n := CaptionToInt (items [startIdx + 1].Caption);
      if ((delta = 1) and (n = startMessageNo)) or ((delta = -1) and (n = startMessageNo + 2)) then
      begin
        Inc (startIdx);
        Inc (startMessageNo);
        items [startIdx].Caption := IntToCaption (startMessageNo);
      end
      else
        Break;
    end
  end
end;

procedure TfmStringsEditor.actStringDeleteStringExecute(Sender: TObject);
var
  messageNo, idx : Integer;
begin
  inherited;
  if Assigned (lvStrings.Selected) then
  begin
    idx := lvStrings.Selected.Index;
    lvStrings.Selected.Free;
    if idx < lvStrings.Items.Count then
    begin
      lvStrings.Selected := lvStrings.Items [idx];
      messageNo := CaptionToInt (lvStrings.Selected.Caption);
      AdjustMessageNos (idx, messageNo, -1);
    end
    else
    begin
      Dec (idx);
      if idx >= 0 then
        lvStrings.Selected := lvStrings.Items [idx]
    end;
  end
end;

procedure TfmStringsEditor.actStringAddStringExecute(Sender: TObject);
var
  messageNo : Integer;
  itm : TListItem;
begin
  inherited;
  with lvStrings do
  begin
    if Assigned (Selected) then
    begin
      messageNo := CaptionToInt (selected.Caption);
      itm := items.Insert (selected.Index);
      selected := itm;
    end
    else
    begin
      if items.Count > 0 then
        with items, item [count - 1] do
          messageNo := CaptionToInt (caption) + 1
        else
          if resource is TStringsResource then
            messageNo := CaptionToInt (resource.ResourceName)
          else
            messageNo := 0;
      itm := items.Add
    end;

    with itm do
    begin
      caption := IntToCaption (messageNo);
      SubItems.Add ('');
      MakeVisible (False)
    end;

    if not Assigned (selected) then
      with items do
        Selected := item [count - 1];

    actStringModifyStringExecute (sender);
  end
end;

function TfmStringsEditor.CaptionToInt(const caption: string): Integer;
begin
  result := StrToInt (caption)
end;

function TfmStringsEditor.IntToCaption(i: Integer): string;
begin
  result := IntToStr (i)
end;

procedure TfmStringsEditor.SaveResource (const undoDescription : string);
var
  i, id : Integer;
  s : TStringList;
begin
  s := TStringList.Create;
  try
    for i := 0 to lvStrings.Items.Count - 1 do
    begin
      id := StrToInt (lvStrings.Items [i].Caption);
      s.AddObject (lvStrings.Items [i].SubItems [0], TObject (id));
    end;

    resource.AddUndoEntry (undoDescription);
    TTextResource (resource).SetStrings (s);

  finally
    s.Free
  end
end;

procedure TfmStringsEditor.FormShow(Sender: TObject);
begin
  inherited;
  fObjectInstance := MakeObjectInstance (OwnerWindowProc);
  fOldOwnerWindowProc := TfnWndProc (SetWindowLong (lvStrings.Handle, GWL_WNDPROC, Integer (fObjectInstance)));
  lvStrings.ReadOnly := resource is TStringsResource
end;

function TfmStringsEditor.GetEditSupport: TEditSupport;
begin
  result := inherited GetEditSupport;
  if mmoMessage.Visible then
  begin
    if mmoMessage.CanUndo then
      result := result + [esUndo]
  end
end;

procedure TfmStringsEditor.EditMenuSelected;
begin
  with lvStrings do if Assigned (Selected) then
  begin
    if mmoMessage.CanUndo then
    begin
      selected.SubItems [0] := mmoMessage.Text;
      AdjustMessageNos (selected.Index, CaptionToInt (selected.Caption), 1);
      SaveResource (rstStringChange);
      mmoMessage.ClearUndo
    end
  end;
end;

procedure TfmStringsEditor.EditUndo;
begin
  inherited;
  mmoMessage.Visible := False;
end;

procedure TfmStringsEditor.EditRedo;
begin
  inherited;
  mmoMessage.Visible := False;
end;

procedure TfmStringsEditor.FormDestroy(Sender: TObject);
begin
  SetWindowLong (lvStrings.Handle, GWL_WNDPROC, Integer (fOldOwnerWindowProc));
  if Assigned (fObjectInstance) then
    FreeObjectInstance (fObjectInstance);
  inherited;
end;

procedure TfmStringsEditor.OwnerWindowProc(var msg: TMessage);
begin
  if msg.Msg = WM_HSCROLL then
    DoListViewScrolled;

  with Msg do
    result := CallWindowProc (fOldOwnerWindowProc, lvStrings.Handle, msg, wParam, lParam);
end;

procedure TfmStringsEditor.DoListViewScrolled;
var
  r : TRect;
begin
  if mmoMessage.Visible then
  begin
    GetWindowRect (mmoMessage.Handle, r);
    MapWindowPoints (0, Handle, r, 2);

    r.Right := lvStrings.Width - 2;
    r.Bottom := r.Bottom - r.Top;

    SetWindowPos (mmoMessage.Handle, HWND_TOP, r.left, r.top, r.right, r.Bottom, 0 )
  end
end;

procedure TfmStringsEditor.lvStringsEdited(Sender: TObject;
  Item: TListItem; var S: String);
begin
  inherited;
  PostMessage (handle, WM_IDCHANGED, 0, 0);
end;

procedure TfmStringsEditor.wmIDChanged(var msg: TMessage);
begin
  SaveResource (rstIDChange);
end;

end.
