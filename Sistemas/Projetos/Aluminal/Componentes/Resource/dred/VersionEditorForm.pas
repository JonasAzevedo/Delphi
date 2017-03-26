(*===========================================================================*
 | unit VersionEditorForm                                                    |
 |                                                                           |
 | Version  Date      By    Description                                      |
 | -------  --------  ----  -------------------------------------------------|
 | 1.0      04/07/00  CPWW  Original                                         |
 *===========================================================================*)

unit VersionEditorForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ResourceEditorForm, StdCtrls, ComCtrls, ExtCtrls, Menus, ActnList;

type
  TModifyType = (mtString, mtStringName);
  TfmVersionEditor = class(TfmResourceEditor)
    pnlVersionHeader: TPanel;
    lvVersionStrings: TListView;
    Label1: TLabel;
    Label2: TLabel;
    edProductVersion: TEdit;
    edFileVersion: TEdit;
    cbDebug: TCheckBox;
    cbInferred: TCheckBox;
    cbPatched: TCheckBox;
    cbPrerelease: TCheckBox;
    cbPrivateBuild: TCheckBox;
    cbSpecialBuild: TCheckBox;
    Splitter1: TSplitter;
    Label3: TLabel;
    cbLocale: TComboBox;
    mmoMessage: TMemo;
    MainMenu1: TMainMenu;
    mnuStrings: TMenuItem;
    AddString1: TMenuItem;
    ModifyString1: TMenuItem;
    DeleteString1: TMenuItem;
    ActionList1: TActionList;
    actStringAddString: TAction;
    actStringModifyString: TAction;
    actStringDeleteString: TAction;
    PopupMenu1: TPopupMenu;
    AddString2: TMenuItem;
    ModifyString2: TMenuItem;
    DeleteString2: TMenuItem;
    actStringModifyStringName: TAction;
    procedure cbDebugClick(Sender: TObject);
    procedure edProductVersionExit(Sender: TObject);
    procedure edFileVersionExit(Sender: TObject);
    procedure cbLocaleChange(Sender: TObject);
    procedure actStringModifyStringExecute(Sender: TObject);
    procedure lvVersionStringsResize(Sender: TObject);
    procedure mmoMessageExit(Sender: TObject);
    procedure lvVersionStringsDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actStringModifyStringNameExecute(Sender: TObject);
    procedure actStringAddStringExecute(Sender: TObject);
    procedure actStringDeleteStringExecute(Sender: TObject);
  private
    fInitializing : boolean;

    fOldOwnerWindowProc : TFNWndProc;
    fObjectInstance : pointer;
    fModifyType : TModifyType;
    fSelectedKey : string;
    procedure OwnerWindowProc(var msg: TMessage);

    procedure SaveFlags;
    function ListViewScrollPos : Integer;
    procedure DoListViewScrolled;
  protected
  public
    procedure DoResourceChanged; override;
  end;

var
  fmVersionEditor: TfmVersionEditor;

implementation

uses ResourceModule, ResourceVersion;

{$R *.DFM}

resourcestring
  rstVersionFormatError = 'Error in version string';

{ TfmVersionEditor }

(*----------------------------------------------------------------------------*
 | function VersionToString ()                                                |
 |                                                                            |
 | Convert a version large integer to a string                                |
 |                                                                            |
 | Parameters:                                                                |
 |   version : TULargeInteger     The version integer to convert              |
 |                                                                            |
 | The function returns string representation of the version no               |
 *----------------------------------------------------------------------------*)
function VersionToString (version : TULargeInteger) : string;
begin
  with version do
    result := Format ('%d.%d.%d.%d', [HiWord (HighPart), LoWord (HighPart), HiWord (LowPart), LoWord (LowPart)]);
end;

(*----------------------------------------------------------------------------*
 | function StringToVersion ()                                                |
 |                                                                            |
 | Convert a version string to a large integer                                |
 |                                                                            |
 | Parameters:                                                                |
 |   version : string       The version string to convert                     |
 |                                                                            |
 | The function returns the integer representation of the version string      |
 *----------------------------------------------------------------------------*)
function StringToVersion (const version : string) : TULargeInteger;
var
  p : Integer;
  s : string;
  hh, h, l, ll : word;
  ok : boolean;
begin
  hh := 0;
  ll := 0;
  h := 0;
  l := 0;

  s := version;
  p := Pos ('.', s);
  ok := False;
  if p > 0 then
  begin
    hh := StrToInt (Copy (s, 1, p - 1));
    s := Copy (s, p + 1, MaxInt);
    p := Pos ('.', s);
    if p > 0 then
    begin
      h := StrToInt (Copy (s, 1, p - 1));
      s := Copy (s, p + 1, MaxInt);
      p := Pos ('.', s);
      if p > 0 then
      begin
        l := StrToInt (Copy (s, 1, p - 1));
        ll := StrToInt (Copy (s, p + 1, MaxInt));
        ok := True;
      end
    end
  end;

  if not ok then
    raise exception.Create (rstVersionFormatError);

  result.HighPart := 65536 * hh + h;
  result.LowPart := 65536 * l + ll;
end;

(*----------------------------------------------------------------------------*
 | procedure TfmVersionEditor.FormShow ()                                     |
 |                                                                            |
 | OnShow event handler.  Set up handler for list view scroll messages        |
 *----------------------------------------------------------------------------*)
procedure TfmVersionEditor.FormShow(Sender: TObject);
begin
  fObjectInstance := MakeObjectInstance (OwnerWindowProc);
  fOldOwnerWindowProc := TfnWndProc (SetWindowLong (lvVersionStrings.Handle, GWL_WNDPROC, Integer (fObjectInstance)));
end;

(*----------------------------------------------------------------------------*
 | procedure TfmVersionEditor.OwnerWindowProc                                 |
 |                                                                            |
 | Message handler for list view messages only.                               |
 |                                                                            |
 | We need to intercept scroll messages if the memo box is displayed so we    |
 | can move it, too.                                                          |
 *----------------------------------------------------------------------------*)
procedure TfmVersionEditor.OwnerWindowProc(var msg: TMessage);
begin
  if msg.Msg = WM_HSCROLL then
    DoListViewScrolled;

  with Msg do
    result := CallWindowProc (fOldOwnerWindowProc, lvVersionStrings.Handle, msg, wParam, lParam);
end;

(*----------------------------------------------------------------------------*
 | procedure TfmVersionEditor.FormDestroy                                     |
 |                                                                            |
 | ONDestroy handler.  Unhook the list-view messages.                         |
 *----------------------------------------------------------------------------*)
procedure TfmVersionEditor.FormDestroy(Sender: TObject);
begin
  SetWindowLong (lvVersionStrings.Handle, GWL_WNDPROC, Integer (fOldOwnerWindowProc));
  if Assigned (fObjectInstance) then
    FreeObjectInstance (fObjectInstance);
  inherited;
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.DoResourceChanged                         |
 |                                                                      |
 | Called when the resource data is changed.  Initializes the editor.   |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.DoResourceChanged;
var
  fVersion : TULargeInteger;
  pVersion : TULargeInteger;
  flags : TVersionFileFlags;
  i, idx : Integer;
  k : TVersionStringValue;
  sLang : string;
begin
  fInitializing := True;
  with Resource as TVersionInfoResource do
  try
    fVersion := FileVersion;
    pVersion := ProductVersion;
    flags := FileFlags;

    edFileVersion.Text := VersionToString (fVersion);
    edProductVersion.Text := VersionToString (pVersion);

    cbLocale.Text := Languages.NameFromLocaleID [LangID];

    idx := -1;
    for i := 0 to Languages.Count - 1 do
    begin
      sLang := Languages.Name [i];
      cbLocale.Items.Add (sLang);
      if sLang = cbLocale.Text then
        idx := i;
    end;

    cbLocale.ItemIndex := idx;

    cbDebug.Checked := ffDebug in flags;
    cbInferred.Checked := ffInfoInferred in flags;
    cbPatched.Checked := ffPatched in flags;
    cbPrerelease.Checked := ffPrerelease in flags;
    cbPrivateBuild.Checked := ffPrivateBuild in flags;
    cbSpecialBuild.Checked := ffSpecialBuild in flags;

    lvVersionStrings.Items.BeginUpdate;
    with lvVersionStrings.Items do
    try
      Clear;
      for i := 0 to KeyCount - 1 do
        with Add do
        begin
          k := Key [i];
          Caption := k.KeyName;
          SubItems.Add (k.Value);
        end
    finally
      EndUpdate
    end
  finally
    fInitializing := False
  end
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.SaveFlags                                 |
 |                                                                      |
 | Get flags value from checkboxes and save it in the resource.         |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.SaveFlags;
var
  flags : TVersionFileFlags;
begin
  if not fInitializing then     // Ignore check box 'OnClick' handlers
                                // when we're being initialized.

    with TVersionInfoResource (Resource) do
    begin
      flags := FileFlags;
      if cbDebug.Checked then flags := flags + [ffDebug] else flags := flags - [ffDebug];
      if cbInferred.Checked then flags := flags + [ffInfoInferred] else flags := flags - [ffInfoInferred];
      if cbPatched.Checked then flags := flags + [ffPatched] else flags := flags - [ffPatched];
      if cbPrerelease.Checked then flags := flags + [ffPreRelease] else flags := flags - [ffPreRelease];
      if cbPrivateBuild.Checked then flags := flags + [ffPrivateBuild] else flags := flags - [ffPrivateBuild];
      if cbSpecialBuild.Checked then flags := flags + [ffSpecialBuild] else flags := flags - [ffSpecialBuild];
      FileFlags := flags;

      ProductVersion := StringToVersion (edProductVersion.Text);
      FileVersion := StringToVersion (edFileVersion.Text);
    end
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.cbDebugClick                              |
 |                                                                      |
 | The same 'Click' handler is used for all the 'flags' checkboxes -    |
 | not just the 'Debug' one.                                            |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.cbDebugClick(Sender: TObject);
begin
  SaveFlags
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.edProductVersionExit                      |
 |                                                                      |
 | Save product version when they exit the Product Version edit box.    |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.edProductVersionExit(Sender: TObject);
begin
  SaveFlags
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.edFileVersionExit                         |
 |                                                                      |
 | Save file version when they exit the File Version edit box.          |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.edFileVersionExit(Sender: TObject);
begin
  SaveFlags
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.cbLocaleChange                            |
 |                                                                      |
 | Save the new locale in the resource.                                 |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.cbLocaleChange(Sender: TObject);
var
  i : Integer;
begin
  if not fInitializing then    // Make sure we're not initializing

    with TVersionInfoResource (Resource) do
    begin
      for i := 0 to Languages.Count -1 do
        if Languages.Name [i] = cbLocale.Text then
        begin
          LangID := Languages.LocaleID [i];
          break
        end
    end
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.actStringModifyStringExecute              |
 |                                                                      |
 | Display the memo box for editing a string value                      |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.actStringModifyStringExecute(Sender: TObject);
begin
  if Assigned (lvVersionStrings.Selected) then
  begin
    fModifyType := mtString;
    fSelectedKey := lvVersionStrings.Selected.Caption;
    mmoMessage.Visible := True;
    mmoMessage.Top := lvVersionStrings.Selected.DisplayRect (drLabel).Bottom;
    mmoMessage.Text := lvVersionStrings.Selected.SubItems [0];
    DoListViewScrolled;
    mmoMessage.SetFocus
  end
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.lvVersionStringsResize                    |
 |                                                                      |
 | OnResize handler for the listbox.  Keep the memo box in sync.        |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.lvVersionStringsResize(Sender: TObject);
begin
  DoListViewScrolled;
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.mmoMessageExit                            |
 |                                                                      |
 | They existed the memo box.  Hide it, and update the 'string name'    |
 | or 'string value' resource.                                          |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.mmoMessageExit(Sender: TObject);
begin
  mmoMessage.Visible := False;

  case fModifyType of
    mtString :
        // fSelectedKey can not be ''
      TVersionInfoResource (resource).SetKeyValue (fSelectedKey, mmoMessage.Text);

    mtStringName :
        // fSelectedKey can be ''   (Adding a new string)
      TVersionInfoResource (resource).ChangeKey (fSelectedKey, mmoMessage.Text);
  end
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.lvVersionStringsDblClick                  |
 |                                                                      |
 | They double clicked the list view.  Edit the string value or string  |
 | name, depending on which list-view column they're in.                |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.lvVersionStringsDblClick(Sender: TObject);
var
  pt : TPoint;
begin
  pt := Mouse.CursorPos;
  MapWindowPoints (0, lvVersionStrings.Handle, pt, 1);

  if pt.x < lvVersionStrings.Columns [0].Width then
    actStringModifyStringName.Execute
  else
    if Assigned (lvVersionStrings.Selected) then
      actStringModifyString.Execute
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.DoListViewScrolled                        |
 |                                                                      |
 | Keep the memo box in sync with the list view, when the list view is  |
 | scrolled or resized.                                                 |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.DoListViewScrolled;
var
  r : TRect;
  col0Offset : Integer;
begin
  if mmoMessage.Visible then
  begin
    GetWindowRect (mmoMessage.Handle, r);
    MapWindowPoints (0, Handle, r, 2);

    if fModifyType = mtString then
      col0Offset := lvVersionStrings.Columns [0].Width - ListViewScrollPos
    else
      col0Offset := -ListViewScrollPos;

    if col0Offset < 0 then
      col0Offset := 0;

    r.Left := lvVersionStrings.Left + col0Offset;
    r.Right := lvVersionStrings.Width - col0Offset - 2;
    r.Bottom := r.Bottom - r.Top;

    SetWindowPos (mmoMessage.Handle, HWND_TOP, r.left, r.top, r.right, r.Bottom, 0 )
  end
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.ListViewScrollPos                         |
 |                                                                      |
 | Return the horizontal scroll position for the list view.             |                                                                     |
 *----------------------------------------------------------------------*)
function TfmVersionEditor.ListViewScrollPos: Integer;
var
  si : scrollInfo;
begin
  ZeroMemory (@si, sizeof (si));
  si.cbSize := sizeof (si);
  si.fMask := SIF_TRACKPOS;
  GetScrollInfo (lvVersionStrings.Handle, SB_HORZ, si);
  result := si.nTrackPos;
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.actStringModifyStringNameExecute          |
 |                                                                      |
 | Display the memo box for modifying (or adding) a string name.        |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.actStringModifyStringNameExecute(
  Sender: TObject);
begin
  fModifyType := mtStringName;
  if Assigned (lvVersionStrings.Selected) then

  begin  // Modifying a string name

    fSelectedKey := lvVersionStrings.Selected.Caption;
    mmoMessage.Top := lvVersionStrings.Selected.DisplayRect (drLabel).Bottom
  end
  else

  begin // Adding a string name.

    fSelectedKey := '';
    mmoMessage.Top := lvVersionStrings.Items [lvVersionStrings.Items.Count - 1].DisplayRect (drLabel).Bottom
  end;

  mmoMessage.Visible := True;
  mmoMessage.Text := fSelectedKey;
  DoListViewScrolled;
  mmoMessage.SetFocus
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.actStringAddStringExecute                 |
 |                                                                      |
 | Display the memo box for adding a string name (from the pop-up menu) |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.actStringAddStringExecute(Sender: TObject);
begin
  fModifyType := mtStringName;
  fSelectedKey := '';
  mmoMessage.Top := lvVersionStrings.Items [lvVersionStrings.Items.Count - 1].DisplayRect (drLabel).Bottom;
  mmoMessage.Visible := True;
  mmoMessage.Text := fSelectedKey;
  DoListViewScrolled;
  mmoMessage.SetFocus
end;

(*----------------------------------------------------------------------*
 | procedure TfmVersionEditor.actStringDeleteStringExecute              |
 |                                                                      |
 | Delete the selected version string                                   |
 *----------------------------------------------------------------------*)
procedure TfmVersionEditor.actStringDeleteStringExecute(Sender: TObject);
begin
  if Assigned (lvVersionStrings.Selected) then
    TVersionInfoResource (resource).DeleteKey (lvVersionStrings.Selected.Index);
end;

end.

