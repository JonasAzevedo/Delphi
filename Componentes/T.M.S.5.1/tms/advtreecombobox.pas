{********************************************************************}
{ TAdvTreeComboBox component                                         }
{ for Delphi & C++Builder                                            }
{                                                                    }
{ written by TMS Software                                            }
{            copyright � 2003 - 2008                                 }
{            Email : info@tmssoftware.com                            }
{            Web : http://www.tmssoftware.com                        }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{ The component can be freely used in any application. The source    }
{ code remains property of the author and may not be distributed     }
{ freely as such.                                                    }
{********************************************************************}

{$I TMSDEFS.INC}
unit AdvTreeComboBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Imglist, Menus, ExtCtrls
  {$IFDEF TMSDOTNET}
  , Types, WinUtils, uxTheme
  {$ENDIF}
  {$IFNDEF TMSDOTNET}
  , ATXPVS
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 1; // Release nr.
  BLD_VER = 1; // Build nr.

  // version history
  // 1.1.0.1 : workaround for Delphi 2005 dropdown position issue
  // 1.1.0.2 : fixed design time issue for delete component
  // 1.1.0.3 : improved treeview selection consistency
  // 1.1.0.4 : fixed design time issue during loading of component
  // 1.1.1.0 : exposed Bevel properties
  // 1.1.1.1 : Fixed : issue with use on frames  

type
  TSelectMode = (smSingleClick, smDblClick);

  TDropPosition = (dpAuto, dpDown, dpUp);
  //acceptdrop=true allow tree dropping

  TDropDown = procedure(Sender: TObject; var acceptdrop: boolean) of object;
  //canceled = true ignores SelecteItem and stores Old Edit caption
  //canceled = false on selection and true when Cancel (key=Esc, click outside of tree...)

  TDropUp = procedure(Sender: TObject; canceled: boolean) of object;

  TDropTreeForm = class(TForm)
  private
    FDeActivate: DWORD;
    procedure WMClose(var Msg: TMessage); message WM_CLOSE;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    function GetParentWnd: HWnd;
  published
    property DeActivateTime: DWORD read FDeActivate;
  end;

  TDropTreeButton = class(TSpeedButton)
  private
    FFocusControl: TWinControl;
    FMouseUp: TNotifyEvent;
    FMouseDown: TNotifyEvent;
    FColor: TColor;
    FIsWinXP: Boolean;
    FHover: Boolean;
    FDown: Boolean;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonDown); message WM_LBUTTONUP;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Paint; override;
    property Hover: Boolean read FHover write FHover;
    property Down: Boolean read FDown write FDown;
  public
    procedure Click; override;
    constructor Create(AOwner: TComponent); override;
    property IsWinXP: Boolean read FIsWinXP;
  published
    property Color: TColor read FColor write FColor;
    property FocusControl: TWinControl read FFocusControl write FFocusControl;
    property MouseButtonDown: TNotifyEvent read FMouseDown write FMouseDown;
    property MouseButtonUp: TNotifyEvent read FMouseUp write FMouseUp;
  end;

  TAdvTreeComboBox = class(TCustomEdit)
  private
    { Private declarations }
    FTreeView: TTreeview;
    FDropTreeForm: TDropTreeForm;
    FButton: TDropTreeButton;
    FDropWidth: integer;
    FDropHeight: integer;
    FEditorEnabled: boolean;
    FExpandOnDrop: boolean;
    FCollapseOnDrop: boolean;
    FDropPosition: TDropPosition;
    FOldCaption: string;
    FOndropDown: TdropDown;
    FOndropUP: TdropUP;
    FAutoOpen: boolean;
    FSelectMode: TselectMode;
    FFlat: Boolean;
    FIsWinXP: Boolean;
    function GetMinHeight: Integer;
    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    function GetTreeNodes: TTreeNodes;
    procedure SetTreeNodes(const Value: TTreeNodes);
    procedure SetEditorEnabled(const Value: boolean);
    procedure SetCollapseOnDrop(const Value: boolean);
    procedure SetExpandOnDrop(const Value: boolean);
    procedure SetShowButtons(const Value: Boolean);
    function GetShowButtons: Boolean;
    function GetShowLines: Boolean;
    procedure SetShowLines(const Value: Boolean);
    function GetShowRoot: Boolean;
    procedure SetShowRoot(const Value: Boolean);
    function GetSortType: TSortType;
    procedure SetSortType(const Value: TSortType);
    function GetRightClickSelect: Boolean;
    procedure SetRightClickSelect(const Value: Boolean);
    function GetRowSelect: Boolean;
    procedure SetRowSelect(const Value: Boolean);
    function GetIndent: Integer;
    procedure SetIndent(const Value: Integer);
    function GetImages: TCustomImageList;
    procedure SetImages(const Value: TCustomImageList);
    function GetReadOnlyTree: boolean;
    procedure SetReadOnlyTree(const Value: boolean);
    procedure SetStateImages(const Value: TCustomImageList);
    function GetStateImages: TCustomImageList;
    function GetTreeFont: Tfont;
    procedure SetTreeFont(const Value: Tfont);
    function GetTreeColor: TColor;
    procedure SetTreeColor(const Value: TColor);
    function GetTreeBorder: TBorderStyle;
    procedure SetTreeBorder(const Value: TBorderStyle);
    function GetTreepopupmenu: Tpopupmenu;
    procedure SetTreepopupmenu(const Value: Tpopupmenu);
    function GetSelection: integer;
    procedure SetSelection(const Value: integer);
    procedure SetFlat(const Value: Boolean);
    function GetAbsoluteIndex: Integer;
    function GetVersionEx: string;
    function GetVersionNr: Integer;
    procedure SetVersion(const Value: string);
  protected
    { Protected declarations }
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MouseButtonDown(Sender: TObject);
    procedure FindTextInNode;
    procedure HideTree(canceled: boolean);
    procedure TreeViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewKeyPress(Sender: TObject; var Key: Char);
    procedure TreeViewDblClick(Sender: TObject);
    procedure TreeViewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TreeViewBlockChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeViewExit(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyPress(var Key: Char); override;
    function CreateTreeview(AOwner: TComponent): TTreeView; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowTree;    
    property Button: TDropTreeButton read FButton;
    property AbsoluteIndex: Integer read GetAbsoluteIndex;
    property Treeview: TTreeview read FTreeView;
    { Public declarations }
  published
    { Published declarations }
    property SelectMode: TSelectMode read FSelectMode write FSelectMode default smDblClick;
    property DropWidth: integer read FDropWidth write fDropWidth;
    property DropHeight: integer read FDropHeight write fDropHeight;
    property Items: TTreeNodes read GetTreeNodes write SetTreeNodes;
    property EditorEnabled: boolean read FEditorEnabled write SetEditorEnabled default true;
    property CollapseOnDrop: boolean read FCollapseOnDrop write SetCollapseOnDrop default false;
    property ExpandOnDrop: boolean read FExpandOnDrop write SetExpandOnDrop default false;
    property DropPosition: TDropPosition read FDropPosition write FDropPosition default dpAuto;
    property AutoOpen: boolean read FAutoOpen write FAutoOpen default True;
    property Flat: Boolean read FFlat write SetFlat default False;
     //----- Tree properties
    property ReadOnlyTree: boolean read GetReadOnlyTree write SetReadOnlyTree default true;
    property ShowButtons: Boolean read GetShowButtons write SetShowButtons default True;
    property ShowLines: Boolean read GetShowLines write SetShowLines default True;
    property ShowRoot: Boolean read GetShowRoot write SetShowRoot default True;
    property SortType: TSortType read GetSortType write SetSortType default stNone;
    property RightClickSelect: Boolean read GetRightClickSelect write SetRightClickSelect default False;
    property RowSelect: Boolean read GetRowSelect write SetRowSelect default False;
    property Indent: Integer read GetIndent write SetIndent;
    property Images: TCustomImageList read GetImages write SetImages;
    property StateImages: TCustomImageList read GetStateImages write SetStateImages;
    property TreeFont: Tfont read GetTreeFont write SetTreeFont;
    property TreeColor: TColor read GetTreeColor write SetTreeColor;
    property TreeBorder: TBorderStyle read GetTreeBorder write SetTreeBorder;
    property TreePopupMenu: Tpopupmenu read GetTreepopupmenu write SetTreepopupmenu;
    property Selection: Integer read GetSelection write SetSelection;
    property Version: string read GetVersionEx write SetVersion;
     //--------
    property OnDropDown: TDropDown read FOnDropDown write FOnDropDown;
    property OnDropUp: TDropUP read FOnDropUP write FOnDropUp;

    property Align;
     //------- Edit Properties
{$IFDEF DELPHI4_LVL}
    property Anchors;
    property Constraints;
    property DragKind;
{$ENDIF}
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    {$IFDEF DELPHI7_LVL}
    property BevelKind;
    property BevelInner;
    property BevelOuter;
    property BevelEdges;
    {$ENDIF}
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Height;
    property Width;
    property Text;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
{$IFDEF DELPHI4_LVL}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;


implementation



{$R AdvTreeComboBox.res}

{$IFNDEF TMSDOTNET}
function GetFileVersion(FileName:string): Integer;
var
  FileHandle:dword;
  l: Integer;
  pvs: PVSFixedFileInfo;
  lptr: uint;
  querybuf: array[0..255] of char;
  buf: PChar;
begin
  Result := -1;

  StrPCopy(querybuf,FileName);
  l := GetFileVersionInfoSize(querybuf,FileHandle);
  if (l>0) then
  begin
    GetMem(buf,l);
    GetFileVersionInfo(querybuf,FileHandle,l,buf);
    if VerQueryValue(buf,'\',Pointer(pvs),lptr) then
    begin
      if (pvs^.dwSignature=$FEEF04BD) then
      begin
        Result := pvs^.dwFileVersionMS;
      end;
    end;
    FreeMem(buf);
  end;
end;
{$ENDIF}

{ TAdvTreeComboBox }

constructor TAdvTreeComboBox.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited Create(AOwner);

  // app is linked with COMCTL32 v6 or higher -> xp themes enabled
  i := GetFileVersion('COMCTL32.DLL');
  i := (i shr 16) and $FF;

  FIsWinXP := (i > 5);

  SetBounds(left, top, 200, 25);

  if not (csDesigning in ComponentState) then
  begin
  {$IFDEF DELPHI4_LVL}
    FDropTreeForm := TDropTreeForm.CreateNew(self, 0);
  {$ELSE}
    FDropTreeForm := TDropTreeForm.CreateNew(self);
  {$ENDIF}
    with FDropTreeForm do
    begin
      BorderStyle := bsNone;
      FormStyle := fsStayOnTop;
      Visible := False;
      Width := FDropWidth;
      Height := FDropHeight;
      OnClose := FormClose;
    end;
  end;

  //if not (csDesigning in ComponentState) then
  //  FTreeView := CreateTreeView(FDropTreeForm)
  //else
  //begin
  FTreeView := CreateTreeView(Self);
  //end;

  with FTreeView do
  begin
    if not (csDesigning in ComponentState) then
      Parent := FDropTreeForm
    else
      Parent := Self;

    if not (csDesigning in ComponentState) then
      Align := alClient
    else
      Width := 0;


    ReadOnly := true;
    ShowButtons := True;
    ShowLines := True;
    ShowRoot := True;
    SortType := stNone;
    RightClickSelect := False;
    RowSelect := False;
    if not (csDesigning in ComponentState) then
      Visible := True
    else
      Visible := False;

    OnKeyDown := TreeViewKeyDown;
    OnChange := TreeViewChange;
    OnMouseDown := TreeViewMouseDown;
    OnDblClick := TreeViewDblClick;
    OnKeyPress := TreeViewKeyPress;
  end;

  FButton := TDropTreeButton.Create(Self);
  FButton.Width := 17;
  FButton.Height := 17;
  FButton.Visible := True;
  FButton.Parent := Self;
  FButton.FocusControl := Self;
  FButton.MouseButtonDown := MouseButtonDown;
  FButton.FIsWinXP := FIsWinXP;
  ControlStyle := ControlStyle - [csSetCaption];
  FDropHeight := 100;
  FDropWidth := self.width;
  FEditorEnabled := true;
  ReadOnly := false;
  FCollapseOnDrop := false;
  FExpandOnDrop := false;
  FDropPosition := dpAuto;
  FOldCaption := '';
  FAutoOpen := true;
  FselectMode := smDblClick;
end;

destructor TAdvTreeComboBox.Destroy;
begin
  FButton.Free;
  // this automatically destroys the child treeview
  if not (csDesigning in ComponentState) then
    FDropTreeForm.Free;
//  else
//    FTreeView.Free;
  inherited Destroy;
end;

function TAdvTreeComboBox.CreateTreeview(AOwner: TComponent): TTreeView;
begin
  Result := TTreeView.Create(AOwner);
end;

procedure TAdvTreeComboBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TAdvTreeComboBox.MouseButtonDown(Sender: TObject);
begin
  if csDesigning in ComponentState then
    Exit;
    
  if not FDropTreeForm.Visible and (GetTickCount - FDropTreeForm.DeActivateTime > 250) then
    ShowTree;
end;

procedure TAdvTreeComboBox.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
  Dist: integer;
begin
  inherited;

  if BorderStyle = bsNone then
    Dist := 1
  else
    Dist := 4;

  MinHeight := GetMinHeight;
  { text edit bug: if size to less than minheight, then edit ctrl does
    not display the text }

  if Height < MinHeight then
    Height := MinHeight
  else
    if FButton <> nil then
    begin
      if NewStyleControls and Ctl3D then
        FButton.SetBounds(Width - FButton.Width - Dist , 0, FButton.Width, Height - Dist)
      else
        FButton.SetBounds(Width - FButton.Width, 1, FButton.Width, Height - 3);

      SetEditRect;
    end;
end;

function TAdvTreeComboBox.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  Result := Metrics.tmHeight + I div 4 {+ GetSystemMetrics(SM_CYBORDER) * 4};
end;


procedure TAdvTreeComboBox.SetEditRect;
var
  Loc: TRect;
begin
  {$IFNDEF TMSDOTNET}
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  Perform(EM_GETRECT, 0, Loc);
  {$ENDIF}
  Loc.Bottom := ClientHeight + 1; {+1 is workaround for windows paint bug}
  Loc.Right := ClientWidth - FButton.Width - 3;
  if self.BorderStyle = bsNone then
  begin
    Loc.Top := 2;
    Loc.Left := 2;
  end
  else
  begin
    Loc.Top := 1;
    Loc.Left := 1;
  end;
  {$IFNDEF TMSDOTNET}
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc)); {debug}
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  Perform(EM_SETRECTNP, 0, Loc);
  Perform(EM_GETRECT, 0, Loc); {debug}
  {$ENDIF}
end;

function TAdvTreeComboBox.GetTreeNodes: TTreeNodes;
begin
  Result := FTreeView.Items;
end;

procedure TAdvTreeComboBox.SetTreeNodes(const Value: TTreeNodes);
begin
  FTreeView.Items.Assign(Value);
  FTreeView.Update;
end;

procedure TAdvTreeComboBox.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;

  //FTreeview.Name := self.Name + 'tv';
end;

procedure TAdvTreeComboBox.DestroyWnd;
begin
  inherited;
end;

procedure TAdvTreeComboBox.SetEditorEnabled(const Value: boolean);
begin
  FEditorEnabled := Value;
  ReadOnly := not (Value);
end;

procedure TAdvTreeComboBox.SetCollapseOnDrop(const Value: boolean);
begin
  FCollapseOnDrop := Value;
  if value then FExpandOnDrop := false;
end;

procedure TAdvTreeComboBox.SetExpandOnDrop(const Value: boolean);
begin
  FExpandOnDrop := Value;
  if value then FCollapseOnDrop := false;
end;

procedure TAdvTreeComboBox.TreeViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
  VK_ESCAPE, VK_F4:
    begin
      HideTree(true);
      key := 0;
    end;
  VK_RETURN:
    begin
      HideTree(false);
    end;
  end;
end;

procedure TAdvTreeComboBox.ShowTree;
var
  p: TPoint;
  acpt: boolean;
begin
  if csDesigning in ComponentState then
    Exit;

  if FDropTreeForm.Visible then
    Exit;

  FOldCaption := Caption;
  FDropTreeForm.Left := self.Left;
  FDropTreeForm.Top := self.Top;
  FDropTreeForm.Width := FDropWidth;
  FDropTreeForm.Height := FDropHeight;
  P := Point(0, 0);
  P := ClientToScreen(P);
  case FDropPosition of
    dpAuto: begin
        if P.y + fDropHeight >= GetSystemMetrics(SM_CYSCREEN) then
        begin //Up
          FdropTreeForm.Left := P.x;
          FdropTreeForm.Top := p.y - FDropHeight;
        end
        else
        begin //Down
          FdropTreeForm.Left := P.x;
          FdropTreeForm.Top := p.y + Height - 2;
        end;
      end;
    dpDown: begin
        FdropTreeForm.Left := P.x;
        FdropTreeForm.Top := p.y + Height - 2;
      end;
    dpUp: begin
        FdropTreeForm.Left := P.x;
        FdropTreeForm.Top := p.y - FDropHeight;
      end;
  end;

  if FCollapseOnDrop then FTreeView.FullCollapse;
  if FExpandOnDrop then FTreeView.FullExpand;
  acpt := true;

  FtreeView.Items.GetFirstNode; //Force return of correct items count

  FindTextInNode;

  if Assigned(FOnDropDown) then
    FOnDropdown(Self, acpt);
    
  if acpt then
  begin
    //if FtreeView.Selected <> nil then
    //  Text := FtreeView.Selected.Text;
    FDropTreeForm.Show;
    //FTreeView.SetFocus;
  end;
  FTreeView.OnChanging := nil; // Please leave this here, otherwise procedure FindtextinNode must be modified
end;

procedure TAdvTreeComboBox.WMKeyDown(var Message: TWMKeyDown);
begin
  if csDesigning in ComponentState then
    Exit;
{
  if message.CharCode = VK_RETURN then
  begin
    message.Result := 1;
    Exit;
  end;
}

  inherited;
  case Message.CharCode of
  VK_DOWN: ShowTree;
  VK_F4:
    begin
      if FDropTreeForm.Visible then
        HideTree(False)
      else
        ShowTree;
    end;
  end;
end;

procedure TAdvTreeComboBox.TreeViewChange(Sender: TObject;
  Node: TTreeNode);
begin
  if csDesigning in ComponentState then
    Exit;

  if FDropTreeForm.Visible then
  begin
    if Assigned(Node) then
      Text := Node.Text;
    SelStart := 0;
    SelLength := Length(Text);
  end;

end;

procedure TAdvTreeComboBox.TreeViewDblClick(Sender: TObject);
begin
  if Fselectmode = smDblClick then HideTree(false);
end;

procedure TAdvTreeComboBox.SetShowButtons(const Value: Boolean);
begin
  FtreeView.ShowButtons := value;
end;

function TAdvTreeComboBox.GetShowButtons: Boolean;
begin
  result := FtreeView.ShowButtons;
end;

function TAdvTreeComboBox.GetShowLines: Boolean;
begin
  result := FtreeView.ShowLines;
end;

procedure TAdvTreeComboBox.SetShowLines(const Value: Boolean);
begin
  FtreeView.ShowLines := value;
end;

function TAdvTreeComboBox.GetShowRoot: Boolean;
begin
  result := FtreeView.ShowRoot;
end;

procedure TAdvTreeComboBox.SetShowRoot(const Value: Boolean);
begin
  FtreeView.ShowRoot := value;
end;

function TAdvTreeComboBox.GetSortType: TSortType;
begin
  Result := FtreeView.SortType;
end;

procedure TAdvTreeComboBox.SetSortType(const Value: TSortType);
begin
  FtreeView.SortType := value;
end;

function TAdvTreeComboBox.GetRightClickSelect: Boolean;
begin
  Result := FtreeView.RightClickSelect;
end;

procedure TAdvTreeComboBox.SetRightClickSelect(const Value: Boolean);
begin
  FtreeView.RightClickSelect := value;
end;

function TAdvTreeComboBox.GetRowSelect: Boolean;
begin
  Result := FtreeView.RowSelect;
end;

procedure TAdvTreeComboBox.SetRowSelect(const Value: Boolean);
begin
  FtreeView.RowSelect := value;
end;

function TAdvTreeComboBox.GetIndent: Integer;
begin
  Result := FtreeView.Indent;
end;

procedure TAdvTreeComboBox.SetIndent(const Value: Integer);
begin
  FtreeView.Indent := value;
end;

function TAdvTreeComboBox.GetImages: TCustomImageList;
begin
  result := FtreeView.Images;
end;

procedure TAdvTreeComboBox.SetImages(const Value: TCustomImageList);
begin
  FtreeView.Images := value;
end;

function TAdvTreeComboBox.GetReadOnlyTree: boolean;
begin
  Result := FtreeView.ReadOnly;
end;

procedure TAdvTreeComboBox.SetReadOnlyTree(const Value: boolean);
begin
  FtreeView.ReadOnly := value;
end;

procedure TAdvTreeComboBox.SetStateImages(const Value: TCustomImageList);
begin
  FtreeView.StateImages := value;
end;

function TAdvTreeComboBox.GetStateImages: TCustomImageList;
begin
  result := FtreeView.StateImages;
end;

function TAdvTreeComboBox.GetTreeFont: Tfont;
begin
  result := FtreeView.Font;
end;

procedure TAdvTreeComboBox.SetTreeFont(const Value: Tfont);
begin
  FtreeView.Font.Assign(value);
end;

function TAdvTreeComboBox.GetTreeColor: TColor;
begin
  Result := FtreeView.Color;
end;

procedure TAdvTreeComboBox.SetTreeColor(const Value: TColor);
begin
  FtreeView.Color := value;
end;

procedure TAdvTreeComboBox.TreeViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key <= #27 then key := #0; // stop beeping
end;

procedure TAdvTreeComboBox.HideTree(canceled: boolean);
begin
  if csDesigning in ComponentState then
    Exit;

  if not FdropTreeForm.Visible then
    Exit;
  FDropTreeForm.Hide;
  Application.CancelHint;
  if Canceled then
  begin
    Text := FOldCaption;
  end else
  begin
    if Assigned(FTreeView.Selected) then
    begin
      Text := FTreeView.Selected.Text;
    end;
  end;
  if Assigned(FOnDropUp) then
    FOnDropUP(self, Canceled);
end;

function TAdvTreeComboBox.GetTreeBorder: TBorderStyle;
begin
  Result := FTreeView.BorderStyle;
end;

procedure TAdvTreeComboBox.SetTreeBorder(const Value: TBorderStyle);
begin
  FtreeView.BorderStyle := value;
end;

function TAdvTreeComboBox.GetTreepopupmenu: Tpopupmenu;
begin
  result := FtreeView.PopupMenu;
end;

procedure TAdvTreeComboBox.SetTreepopupmenu(const Value: Tpopupmenu);
begin
  FtreeView.PopupMenu := value;
end;

procedure TAdvTreeComboBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := 1; // Message.Result and DLGC_WANTALLKEYS;
end;

procedure TAdvTreeComboBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(key);
  if (Key = Char(VK_RETURN)) then Key := #0;
end;

procedure TAdvTreeComboBox.FindtextinNode;
var
  i: integer;
  itm, its: TTreenode;
  sfind, stext: string;
  found: boolean;

  function noopen(Node: TTreenode): boolean;
  begin
    result := true;
    if node = nil then exit;
    while Node.Parent <> nil do
    begin
      node := Node.Parent;
      if not node.Expanded then exit;
    end;
    Result := false;
  end;

begin
  sfind := UpperCase(text);
  itm := nil;
  found := false;

  if FTreeview.Selected<> nil then
  begin
    itm := FTreeview.Selected;
    stext := UpperCase(itm.text);
    if AnsiPos(sfind, stext) = 1 then
      found := true;
  end;

  if not found then
  repeat
    for i := 0 to FTreeView.Items.count - 1 do
    begin
   // Don't search if AutoOpen disabled and the nodes are not open.
      if not AutoOpen then
        if noopen(FTreeView.items[i]) then continue;
      stext := UpperCase(FTreeView.Items[i].text);
      if AnsiPos(sfind, stext) = 1 then
      begin
        itm := FTreeView.items[i];
        Break;
      end;
    end;
    if length(sfind) > 0 then delete(sfind, length(sfind), 1);
  until (itm <> nil) or (sfind = '');



  if itm = nil then
  begin
    FTreeView.OnChanging := TreeViewBlockChanging;
    Exit;
  end;
  its := itm;
  if AutoOpen then
  begin
    while itm.Parent <> nil do
    begin
      itm := itm.Parent;
      itm.Expand(false);
    end;
  end;
  FTreeView.Selected := its;
end;

procedure TAdvTreeComboBox.TreeViewBlockChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  AllowChange := false;
end;

procedure TAdvTreeComboBox.TreeViewExit(Sender: TObject);
begin
  HideTree(False);
end;

procedure TAdvTreeComboBox.TreeViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AnItem: TTreeNode;
  HT: THitTests;
begin
  if Fselectmode = smDblClick then exit;
  if FTreeView.Selected = nil then Exit;
  HT := FTreeView.GetHitTestInfoAt(X, Y);
  AnItem := FTreeView.GetNodeAt(X, Y);
  // We can add htOnLabel,htOnStateIcon,htOnItem,htOnLabel
  if (htOnitem in ht) and (AnItem <> nil) then
  begin
    HideTree(false);
  end;
end;

procedure TAdvTreeComboBox.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  FormDeactivate(self);
end;

function TAdvTreeComboBox.GetSelection: integer;
begin
  try
    if Assigned(FTreeView.Selected) then
      Result := FTreeView.Selected.AbsoluteIndex
    else
      Result := -1;
  except
    on Exception do
      Result := -1;
  end;
end;

procedure TAdvTreeComboBox.SetSelection(const Value: integer);
begin
  if (Value = -1) then
  begin
    FTreeView.Selected := nil;
    Text := '';
    Exit;
  end;

  try
    FTreeView.Selected := FTreeView.Items[Value];
    Text := FTreeView.Selected.Text;
  except
    on Exception do
      FTreeView.Selected := nil;
  end;
end;

procedure TAdvTreeComboBox.SetFlat(const Value: Boolean);
begin
  FFlat := Value;
  FButton.Flat := True;
end;

function TAdvTreeComboBox.GetAbsoluteIndex: Integer;
begin
  Result := -1;
  if Assigned(FTreeView.Selected) then
    Result := FTreeView.Selected.AbsoluteIndex;
end;

function TAdvTreeComboBox.GetVersionEx: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvTreeComboBox.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvTreeComboBox.SetVersion(const Value: string);
begin

end;

{ TDropTreeForm }

function TDropTreeForm.GetParentWnd: HWnd;
var
  Last, P: HWnd;
begin
  P := GetParent((Owner as TWinControl).Handle);
  Last := P;
  while P <> 0 do
  begin
    Last := P;
    P := GetParent(P);
  end;
  Result := Last;
end;

procedure TDropTreeForm.WMActivate(var Message: TWMActivate);
begin
  inherited;
  if Message.Active = integer(False) then
  begin
    if Visible then
    begin
      FDeActivate := GetTickCount;
      Hide;
    end;
  end
  else
  begin
    SendMessage(getParentWnd, WM_NCACTIVATE, 1, 0);
  end;
end;

procedure TDropTreeForm.WMClose(var Msg: TMessage);
begin
  inherited;
end;

{ TDropTreeButton }

procedure TDropTreeButton.Click;
begin
  if (FFocusControl <> nil) and FFocusControl.CanFocus and (GetFocus <> FFocusControl.Handle) then
    FFocusControl.SetFocus;
  inherited Click;
end;

procedure TDropTreeButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FHover := true;
  Invalidate;
end;

procedure TDropTreeButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FHover := false;
  Invalidate;
end;

constructor TDropTreeButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Cursor := crArrow;
  if Glyph.Handle = 0 then
    Glyph.Handle := LoadBitmap(HInstance, 'DROPTREE_ARROW_DOWN');
  FColor := clNone;
end;

procedure TDropTreeButton.Paint;
var
  htheme: THandle;
  ARect: TRect;
begin
  if not (IsWinXP and IsThemeActive) then
  begin
    if not Down then
      FState := bsUp;

    inherited Paint;

    if FColor <> clNone then
    begin
      Canvas.Brush.Color := FColor;
      Canvas.Rectangle(0,0,width,height);

      if Glyph.Handle = 0 then
        Glyph.Handle := LoadBitmap(HInstance, 'DROPTREE_ARROW_DOWN');

      Glyph.TransparentMode := tmAuto;
      Glyph.Transparent := true;
      Canvas.Draw(1,0,Glyph);
    end;

    Canvas.Pen.Color := clBtnFace;
    Canvas.Pen.Width := 1;
    Canvas.MoveTo(Width-2,0);
    Canvas.LineTo(0,0);
    Canvas.LineTo(0,Height - 1);

    Canvas.Pen.Color := clWhite;
    Canvas.Pen.Width := 1;
    Canvas.MoveTo(Width-3,1);
    Canvas.LineTo(1,1);
    Canvas.LineTo(1,Height - 2);
  end
  else
  begin
    htheme := OpenThemeData(Parent.Handle,'combobox');
    ARect := ClientRect;
    InflateRect(ARect,1,1);
    ARect.Left := ARect.Left + 2;
    
    if Down then
      {$IFNDEF TMSDOTNET}
      DrawThemeBackground(htheme,Canvas.Handle,CP_DROPDOWNBUTTON,CBXS_PRESSED,@ARect,nil)
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      DrawThemeBackground(htheme,Canvas.Handle,CP_DROPDOWNBUTTON,CBXS_PRESSED,ARect,nil)
      {$ENDIF}
    else
    begin
      {$IFNDEF TMSDOTNET}
      if Hover then
        DrawThemeBackground(htheme,Canvas.Handle,CP_DROPDOWNBUTTON,CBXS_HOT,@ARect,nil)
      else
        DrawThemeBackground(htheme,Canvas.Handle,CP_DROPDOWNBUTTON,CBXS_NORMAL,@ARect,nil);
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      if Hover then
        DrawThemeBackground(htheme,Canvas.Handle,CP_DROPDOWNBUTTON,CBXS_HOT,ARect,nil)
      else
        DrawThemeBackground(htheme,Canvas.Handle,CP_DROPDOWNBUTTON,CBXS_NORMAL,ARect,nil);
      {$ENDIF}
    end;
    CloseThemeData(htheme);
  end;
end;

procedure TDropTreeButton.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  FDown := true;
  Invalidate;

  if Message.XPos > Left then
  begin
    SetCapture(Parent.Handle);
  end;

  if Assigned(FMouseDown) then
    FMouseDown(self);
end;

procedure TDropTreeButton.WMLButtonUp(var Message: TWMLButtonDown);
begin
  if Message.XPos > 0 then
    Message.Result := 0
  else
    inherited;

  FDown := false;
  if GetCapture = Parent.Handle then
  begin
    ReleaseCapture;
  end;

  FState := bsUp;

  Repaint;
end;

end.
