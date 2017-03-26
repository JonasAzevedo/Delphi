unit MAIN;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, StdActns,
  ActnList, ToolWin, ImgList, WinSkinData,CHILDWIN,winskinform;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileCloseItem: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    FileNew1: TAction;
    FileSave1: TAction;
    FileExit1: TAction;
    FileOpen1: TAction;
    FileSaveAs1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2: TMenuItem;
    ImageList1: TImageList;
    Option1: TMenuItem;
    order11: TMenuItem;
    order12: TMenuItem;
    Merge1: TMenuItem;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    SkinData1: TSkinData;
    Panel1: TPanel;
    Memo1: TMemo;
    M11: TMenuItem;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure order11Click(Sender: TObject);
    procedure order12Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure M11Click(Sender: TObject);
  private
    { Private declarations }
    procedure CreateMDIChild(const Name: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  childfm:TMDIChild;

implementation

{$R *.dfm}

uses about;

procedure TMainForm.CreateMDIChild(const Name: string);
var
  Child: TMDIChild;
begin
  { create a new MDI child window }
  Child := TMDIChild.Create(Application);
  Child.Caption := Name;
//  if FileExists(Name) then Child.Memo1.Lines.LoadFromFile(Name);
//  skindata1.UpdateMainMenu(true);
end;

procedure TMainForm.FileNew1Execute(Sender: TObject);
begin
  CreateMDIChild('NONAME' + IntToStr(MDIChildCount + 1));
end;

procedure TMainForm.FileOpen1Execute(Sender: TObject);
begin
  if OpenDialog.Execute then
    CreateMDIChild(OpenDialog.FileName);
end;

procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TMainForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
//  if ChildFm=nil then
//     Application.CreateForm(TMDIChild, ChildFm);
end;

procedure TMainForm.order11Click(Sender: TObject);
begin
     skindata1.active:=true;
end;

procedure TMainForm.order12Click(Sender: TObject);
begin
     menu:=nil;
     skindata1.active:=false;
     menu:=mainmenu1;
end;

procedure TMainForm.ToolButton4Click(Sender: TObject);
begin
    skinaddlog('****************************');
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
   skindata1.DebugList:= memo1.Lines;
end;

procedure TMainForm.M11Click(Sender: TObject);
begin
    skindata1.Active:=not skindata1.Active;
end;

end.
