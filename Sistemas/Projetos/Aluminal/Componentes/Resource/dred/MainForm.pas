(*===========================================================================*
 | Delphi Resource Editor V 1.1                                              |
 |                                                                           |
 | unit MainForm                                                             |
 |                                                                           |
 | The main MDI Form                                                         |
 |                                                                           |
 | Version  Date        By    Description                                    |
 | -------  ----------  ----  -----------------------------------------------|
 | 1.0      28/04/2000  CPWW  Original                                       |
 *===========================================================================*)

unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdActns, ActnList, Menus, ImgList, ComCtrls, ToolWin, ExtCtrls,
  AppEvnts, cmpPersistentPosition, Buttons, ResourceForm, StdCtrls,
  cmpHTMLHelp, cmpMRUList, cmpStandardSystemMenu;

const WM_OPENFILE = WM_USER + $200;

type
  TfmMain = class(TForm)
    ActionList1: TActionList;
    mnuMain: TMainMenu;
    mnuWindow: TMenuItem;
    mnuHelp: TMenuItem;
    actWindowArrange: TWindowArrange;
    actWindowCascade: TWindowCascade;
    actWindowClose: TWindowClose;
    actWindowMinimizeAll: TWindowMinimizeAll;
    actWindowTileHorizontal: TWindowTileHorizontal;
    actWindowTileVertical: TWindowTileVertical;
    actFileExit: TAction;
    actFileNew: TAction;
    actFileOpen: TAction;
    actHelpOn: TAction;
    actHelpAbout: TAction;
    mnuWindowTileVertically: TMenuItem;
    mnuWindowTileHorizontally: TMenuItem;
    mnuWindowCascade: TMenuItem;
    mnuWindowArrangeIcons: TMenuItem;
    N2: TMenuItem;
    mnuWindowClose: TMenuItem;
    mnuHelpHelponResourceEditor: TMenuItem;
    N3: TMenuItem;
    AboutResourceEditor1: TMenuItem;
    OpenDialog: TOpenDialog;
    cbMain: TControlBar;
    tbMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ilMain: TImageList;
    sbMain: TStatusBar;
    actViewToolbar: TAction;
    actViewStatusBar: TAction;
    mnuView: TMenuItem;
    mnuViewToolbar: TMenuItem;
    mnuViewStatusbar: TMenuItem;
    poMRU: TPopupMenu;
    SeedItem1: TMenuItem;
    mnuFile: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    actFileSave: TAction;
    actFileSaveAs: TAction;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    SaveDialog: TSaveDialog;
    ToolButton3: TToolButton;
    PersistentPosition1: TPersistentPosition;
    HTMLHelp1: THTMLHelp;
    ApplicationEvents1: TApplicationEvents;
    MRUList: TMRUList;
    StandardSystemMenu1: TStandardSystemMenu;
    procedure actFileExitExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actFileNewExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actViewToolbarExecute(Sender: TObject);
    procedure mnuViewClick(Sender: TObject);
    procedure actViewStatusBarExecute(Sender: TObject);
    procedure poMRUPopup(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure cbMainDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure actFileSaveExecute(Sender: TObject);
    procedure cbMainGetSiteInfo(Sender: TObject; DockClient: TControl;
      var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
    procedure actHelpAboutExecute(Sender: TObject);
    procedure actHelpOnExecute(Sender: TObject);
    function ApplicationEvents1Help(Command: Word; Data: Integer;
      var CallHelp: Boolean): Boolean;
    procedure ApplicationEvents1Hint(Sender: TObject);
  private
    procedure SetCaption;
    procedure WmOpenFile (var msg : TMessage); message WM_OPENFILE;
    procedure OpenFile (fName : string);
    procedure OnPOMClick (sender : TObject);
    function GetActiveResourceForm : TfmResource;
  protected
    procedure UpdateActions; override;

  public
    function SaveCurrentForm : boolean;
    function SaveCurrentFormAs : boolean;

    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.DFM}
{$R messages2.res}
uses FileCtrl, AboutBoxForm, HelpContext;

(*----------------------------------------------------------------------------*
 | procedure TfmMain.FormShow ()                                              |
 |                                                                            |
 | OnShow handler.                                                            |
 *----------------------------------------------------------------------------*)
procedure TfmMain.FormShow(Sender: TObject);
begin
  MRUList.AppName := Application.Title;
  SetCaption;
  PostMessage (handle, WM_OPENFILE, 0, 0);
end;

//============================================================================
// Action event handlers
//============================================================================

(*----------------------------------------------------------------------------*
 | procedure TfmMain.actFileNewExecute                                        |
 |                                                                            |
 | Handle 'File|New' action'                                                  |
 *----------------------------------------------------------------------------*)
procedure TfmMain.actFileNewExecute(Sender: TObject);
begin
  with TfmResource.Create (self) do
    Show
end;

(*----------------------------------------------------------------------------*
 | procedure TfmMain.actFileOpenExecute                                       |
 |                                                                            |
 | Handle 'File|Open' action'                                                 |
 *----------------------------------------------------------------------------*)
procedure TfmMain.actFileOpenExecute(Sender: TObject);
begin
  OpenFile ('');
end;

(*----------------------------------------------------------------------------*
 | procedure TfmMain.actFileSaveExecute                                       |
 |                                                                            |
 | Handle 'File|Save' action'                                                 |
 *----------------------------------------------------------------------------*)
procedure TfmMain.actFileSaveExecute(Sender: TObject);
begin
  SaveCurrentForm
end;

(*----------------------------------------------------------------------------*
 | procedure TfmMain.actFileSaveAsExecute                                     |
 |                                                                            |
 | Handle 'File|Save As' action'                                              |
 *----------------------------------------------------------------------------*)
procedure TfmMain.actFileSaveAsExecute(Sender: TObject);
begin
  SaveCurrentFormAs
end;

(*----------------------------------------------------------------------------*
 | procedure TfmMain.actFileCloseExecute                                      |
 |                                                                            |
 | Handle 'File|Close' action'                                                |
 *----------------------------------------------------------------------------*)
procedure TfmMain.actFileExitExecute(Sender: TObject);
begin
  Close
end;

(*----------------------------------------------------------------------------*
 | procedure TfmMain.actViewToolbarExecute                                    |
 |                                                                            |
 | Handle 'View|Toolbar' action'                                              |
 *----------------------------------------------------------------------------*)
procedure TfmMain.actViewToolbarExecute(Sender: TObject);
begin
  tbMain.Visible := not tbMain.Visible
end;

(*----------------------------------------------------------------------------*
 | procedure TfmMain.actViewStatusbarExecute                                  |
 |                                                                            |
 | Handle 'View|Statusbar' action'                                              |
 *----------------------------------------------------------------------------*)
procedure TfmMain.actViewStatusBarExecute(Sender: TObject);
begin
  sbMain.Visible := not sbMain.Visible
end;

(*----------------------------------------------------------------------------*
 | procedure TfmMain.actHelpOnHelpExecute                                     |
 |                                                                            |
 | Handle 'Window|Close' action'                                              |
 *----------------------------------------------------------------------------*)
procedure TfmMain.actHelpOnExecute(Sender: TObject);
begin
  HTMLHelp1.DisplayTopic ('');
end;

procedure TfmMain.actHelpAboutExecute(Sender: TObject);
begin
  with TfmNTAboutBox.Create (self) do
  try
    ShowModal
  finally
    Free
  end
end;

procedure TfmMain.mnuViewClick(Sender: TObject);
begin
  mnuViewToolbar.Checked := tbMain.Visible;
  mnuViewStatusbar.Checked := sbMain.Visible;
end;

procedure TfmMain.poMRUPopup(Sender: TObject);
var
  itm : TMenuItem;
  i : Integer;
begin
  while poMRU.Items.Count > 1 do
    poMRU.Items.Delete (0);

  for i := 0 to MRUList.Strings.Count - 1 do
  begin
    itm := TMenuItem.Create (poMRU.Owner);
    itm.Caption := MRUList.Strings [i];
    itm.OnClick := OnPOMClick;
    poMRU.Items.Add (itm)
  end;

  if poMRU.Items.Count > 0 then
    poMRU.Items.Delete (0);
end;

procedure TfmMain.OnPOMClick(sender: TObject);
begin
  with sender as TMenuItem do
    OpenFile (Caption);
end;

procedure TfmMain.cbMainDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := source = tbMain
end;

procedure TfmMain.cbMainGetSiteInfo(Sender: TObject; DockClient: TControl;
  var InfluenceRect: TRect; MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := DockClient = tbMain
end;

function TfmMain.ApplicationEvents1Help(Command: Word; Data: Integer;
  var CallHelp: Boolean): Boolean;
var
  topic : string;
begin
  topic := HelpLink (Data);
  HTMLHelp1.DisplayTopic (topic);
  CallHelp := False;
  result := True
end;

procedure TfmMain.ApplicationEvents1Hint(Sender: TObject);
begin
  sbMain.Panels [0].Text := GetLongHint (Application.Hint);
end;

procedure TfmMain.UpdateActions;
begin
  actFileSave.Visible := Assigned (ActiveMDIChild);
  actFileSaveAs.Visible := Assigned (ActiveMDIChild);
end;

procedure TfmMain.OpenFile(fName: string);
var
  bWildcard : boolean;
  ext : string;
  searchInfo : TSearchRec;
begin
  fName := ExpandFileName (fName);
  bWildcard := fName = '';
  if not bWildcard then
  begin
    if LastDelimiter ('?*', fName) >= 1 then
    begin
      bWildcard := True;
      ext := UpperCase (ExtractFileExt (fName));
      if (ext = '.EXE') or (ext = '.DLL') or (ext = '.OCX') then
        OpenDialog.FilterIndex := 1
      else
        if (ext = '.RES') then
          OpenDialog.FilterIndex := 2
        else
        begin
          OpenDialog.FilterIndex := 3;
          OpenDialog.DefaultExt := ext
        end
    end
    else
    begin
      if FindFirst (fName, faAnyFile, searchInfo) = 0 then
      try
        if (searchInfo.Attr and faDirectory) <> 0 then
        begin
          bWildcard := True;
          OpenDialog.InitialDir := fName;
        end
      finally
        FindClose (searchInfo)
      end
      else
        RaiseLastWin32Error;
    end
  end;

  OpenDialog.FileName := fName;
  if (not bWildcard) or OpenDialog.Execute then
    with TfmResource.Create (self) do
    begin
      FileName := OpenDialog.FileName;
      MRUList.AddFile (FileName)
    end
end;

function TfmMain.SaveCurrentForm: boolean;
var
  activeResourceForm : TfmResource;
begin
  result := True;
  activeResourceForm := GetActiveResourceForm;
  if Assigned (activeResourceForm) then
    if activeResourceForm.FileName = '' then
      result := SaveCurrentFormAs
    else
      activeResourceForm.Save
end;

function TfmMain.SaveCurrentFormAs: boolean;
var
  activeResourceForm : TfmResource;
begin
  result := False;
  activeResourceForm := GetActiveResourceForm;
  if Assigned (activeResourceForm) then
    with SaveDialog do
    begin
      FileName := activeResourceForm.FileName;
      if Execute then
      begin
        activeResourceForm.SaveAs (FileName);
        MRUList.AddFile (FileName);
        result := True
      end
    end
end;

function TfmMain.GetActiveResourceForm: TfmResource;
begin
  if Assigned (ActiveMDIChild) and (ActiveMDIChild is TfmResource) then
    result := TfmResource (ActiveMDIChild)
  else
    result := Nil
end;

procedure TfmMain.SetCaption;
begin
  caption := Application.title;
end;

procedure TfmMain.WmOpenFile(var msg: TMessage);
var
  i : Integer;
begin
  Application.ProcessMessages;
  if ParamCount = 0 then
    actFileOpen.Execute
  else
    for i := 1 to ParamCount do
      OpenFile (ParamStr (i))
end;


end.
