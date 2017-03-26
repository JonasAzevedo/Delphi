{***************************************************************************}
{ TAdvSmoothTabPager component                                              }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2008                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit AdvSmoothTabPager;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Math, Menus,
  Dialogs, Forms, ExtCtrls, AdvSmoothGDIP, GDIPFill, AdvStyleIF
  {$IFNDEF TMSDOTNET}
  , AxCtrls
  {$ENDIF};

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 1; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : First Release
  // v1.0.0.1 : Fixed : issue with incorrect nr. of design time created pages
  // v1.0.0.2 : Fixed : Issue with component initialization during reparenting
  // v1.0.0.3 : Fixed : Issue with Tab line painting when PageMargin > 0
  // v1.0.1.0 : New : Focus indication on active tab
  //          : Fixed : Issue with Tab drawing when TabVisible is false

type
  TAdvSmoothTabPager = class;
  TAdvSmoothTabPage = class;

  TAdvSmoothTabSettings = class(TPersistent)
  private
    FLeftMargin: Integer;
    FRightMargin: Integer;
    FOnChange: TNotifyEvent;
    FHeight: Integer;
    FStartMargin: Integer;
    FEndMargin: Integer;
    FSpacing: Integer;
    FWidth: Integer;
    procedure SetLeftMargin(const Value: Integer);
    procedure SetRightMargin(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetStartMargin(const Value: Integer);
    procedure SetEndMargin(const Value: Integer);
    procedure SetSpacing(const Value: Integer);
    procedure SetWidth(const Value: Integer);
  protected
    procedure Changed;
    property EndMargin: Integer read FEndMargin write SetEndMargin;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property LeftMargin: Integer read FLeftMargin write SetLeftMargin default 4;
    property RightMargin: Integer read FRightMargin write SetRightMargin default 4;
    property StartMargin: Integer read FStartMargin write SetStartMargin default 60;
    property Height: Integer read FHeight write SetHeight default 26;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Width: Integer read FWidth write SetWidth default 0;
  end;

  TDbgList = class(TList)
  private
    function GetItemsEx(Index: Integer): Pointer;
    procedure SetItemsEx(Index: Integer; const Value: Pointer);
  public
    property Items[Index: Integer]: Pointer read GetItemsEx write SetItemsEx; default;
  end;

  TProWinControl = class(TWinControl);

  TAdvSmoothTabAppearance = class;

  TAdvSmoothTabStatus = class(TPersistent)
  private
    FOwner: TAdvSmoothTabAppearance;
    FOffsetTop: integer;
    FOffsetLeft: integer;
    FVisible: Boolean;
    FCaption: String;
    FAppearance: TGDIPStatus;
    FOnChange: TNotifyEvent;
    procedure SetAppearance(const Value: TGDIPStatus);
    procedure SetCaption(const Value: String);
    procedure SetOffsetLeft(const Value: integer);
    procedure SetOffsetTop(const Value: integer);
    procedure SetVisible(const Value: Boolean);
  protected
    procedure Changed;
    procedure AppearanceChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothTabAppearance);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Visible: Boolean read FVisible write SetVisible default false;
    property Caption: String read FCaption write SetCaption;
    property OffsetLeft: integer read FOffsetLeft write SetOffsetLeft default 0;
    property OffsetTop: integer read FOffsetTop write SetOffsetTop default 0;
    property Appearance: TGDIPStatus read FAppearance write SetAppearance;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothTabAppearance = class(TPersistent)
  private
    FOwner: TAdvSmoothTabPage;
    FPicture: TAdvGDIPPicture;
    FBevel: boolean;
    FVerticalSpacing: integer;
    FColor: TColor;
    FAppearance: TGDIPButton;
    FBevelColor: TColor;
    FShadow: boolean;
    FStatus: TAdvSmoothTabStatus;
    FHorizontalSpacing: integer;
    FOnChange: TNotifyEvent;
    FColorSelected: TColor;
    FColorDown: TColor;
    FColorDisabled: TColor;
    FColorHot: TColor;
    procedure SetAppearance(const Value: TGDIPButton);
    procedure SetBevel(const Value: boolean);
    procedure SetBevelColor(const Value: TColor);
    procedure SetStatus(const Value: TAdvSmoothTabStatus);
    procedure SetColor(const Value: TColor);
    procedure SetHorizontalSpacing(const Value: integer);
    procedure SetPicture(const Value: TAdvGDIPPicture);
    procedure SetShadow(const Value: boolean);
    procedure SetVerticalSpacing(const Value: integer);
    procedure SetColorDown(const Value: TColor);
    procedure SetColorSelected(const Value: TColor);
    procedure SetColorDisabled(const Value: TColor);
    procedure SetColorHot(const Value: TColor);
  protected
    procedure Changed;
    procedure PictureChanged(Sender: TObject);
    procedure AppearanceChanged(Sender: TObject);
    procedure StatusChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothTabPage);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Appearance: TGDIPButton read FAppearance write SetAppearance;
    property Status: TAdvSmoothTabStatus read FStatus write SetStatus;
    property Bevel: boolean read FBevel write SetBevel default true;
    property BevelColor: TColor read FBevelColor write SetBevelColor default clGray;
    property Color: TColor read FColor write SetColor default clSilver;
    property ColorDown: TColor read FColorDown write SetColorDown default clGray;
    property ColorSelected: TColor read FColorSelected write SetColorSelected default $AAD9FF;
    property ColorHot: TColor read FColorHot write SetColorHot default clWhite;
    property ColorDisabled: TColor read FColorDisabled write SetColorDisabled  default $545454;
    property Picture: TAdvGDIPPicture read FPicture write SetPicture;
    property Shadow: boolean read FShadow write SetShadow default false;
    property HorizontalSpacing: integer read FHorizontalSpacing write SetHorizontalSpacing default 0;
    property VerticalSpacing: integer read FVerticalSpacing write SetVerticalSpacing default 0;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothTabPage = class(TCustomControl, ITMSStyle)
  private
    FDesignTime: Boolean;
    FPageIndex: integer;  
    FTabVisible: Boolean;
    FAdvSmoothTabPager: TAdvSmoothTabPager;
    FCaption: TCaption;
    FTabEnabled: Boolean;
    FImageIndex: Integer;
    FUpdatingParent: Boolean;
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
    FTabAppearance: TAdvSmoothTabAppearance;
    FPageAppearance: TGDIPFill;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure OnTabAppearanceChanged(Sender: TObject);
    procedure OnPageAppearanceChanged(Sender: TObject);
    procedure SetAdvSmoothTabPager(const Value: TAdvSmoothTabPager);
    procedure SetTabVisible(const Value: Boolean);
    procedure SetCaption(const Value: TCaption);
    procedure SetTabEnabled(const Value: Boolean);
    procedure SetImageIndex(const Value: Integer);
    function GetPageIndex: Integer;
    procedure SetPageIndex(const Value: Integer);
    procedure SetTabAppearance(const Value: TAdvSmoothTabAppearance);
    procedure SetPageAppearance(const Value: TGDIPFill);
  protected
    procedure AlignControls(AControl: TControl; var ARect: TRect); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure Paint; override;
    procedure ReadState(Reader: TReader); override;
    procedure AdjustClientRect(var Rect: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property AdvSmoothTabPager: TAdvSmoothTabPager read FAdvSmoothTabPager write SetAdvSmoothTabPager;
    procedure SetComponentStyle(AStyle: TTMSStyle);
  published
    property Caption: TCaption read FCaption write SetCaption;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property PageAppearance: TGDIPFill read FPageAppearance write SetPageAppearance;
    property TabVisible: Boolean read FTabVisible write SetTabVisible default true;
    property TabEnabled: Boolean read FTabEnabled write SetTabEnabled default true;
    property ShowHint;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored false;
    property TabAppearance: TAdvSmoothTabAppearance read FTabAppearance write SetTabAppearance;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;    
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property PopupMenu;
    property OnContextPopup;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragOver;
    property OnDragDrop;
    property OnEndDrag;
    property OnStartDrag;
    property OnExit;
    property OnEnter;
  end;

  TTabChangingEvent = procedure(Sender: TObject; FromPage, ToPage: Integer; var AllowChange: Boolean) of object;
  TOnClosePage = procedure (Sender:TObject; PageIndex: integer; var Allow: boolean) of object;
  TOnClosedPage = procedure (Sender:TObject; PageIndex: integer) of object;

  TOnPageListClick = procedure (Sender: TObject; X, Y: integer) of object;
  TTabMovedEvent = procedure(Sender: TObject; FromPos: integer; ToPos: Integer)of object;
  TDrawTabEvent = procedure(Sender:TObject; TabIndex: integer; TabRect: TRect) of object;

  TAdvSmoothTabPosition = (tpTopRight, tpTopCenter, tpTopLeft, tpLeftTop, tpLeftBottom, tpLeftCenter, tpRightTop, tpRightBottom, tpRightCenter ,
    tpBottomLeft, tpBottomRight, tpBottomCenter);

  TAdvSmoothTabPager = class(TCustomControl, ITMSStyle)
  private
    Ffocused: Boolean;
    FPageMargin: integer;
    FOffSetY: integer;
    FOffSetX: integer;
    FAdvSmoothTabPages: TDbgList;
    FPropertiesLoaded: Boolean;
    FTabSettings: TAdvSmoothTabSettings;
    FActivePageIndex: Integer;
    FHotPageIndex: Integer;
    FDownPageIndex: Integer;
    FOldHotPageIndex: Integer;
    FOnChange: TNotifyEvent;
    FOnChanging: TTabChangingEvent;
    FTabPosition: TAdvSmoothTabPosition;
    FTabOffSet: Integer;
    FFormWndProc: TWndMethod;
    FTabReorder: Boolean;
    FOnTabMoved: TTabMovedEvent;
    FOnDrawTab: TDrawTabEvent;
    FConstructed, FDesignTime: boolean;    
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure OnTabSettingsChanged(Sender: TObject);
    procedure OnEnterTab(PageIndex: Integer);
    procedure OnExitTab(PageIndex: Integer);
    procedure SetPagePosition(SmoothTab: TAdvSmoothTabPage);
    procedure SetAllPagesPosition;
    function GetAdvSmoothTabPageCount: integer;
    function GetAdvSmoothTabPages(index: integer): TAdvSmoothTabPage;
    function GetPopupMenuEx: TPopupMenu;
    procedure SetPopupMenuEx(const Value: TPopupMenu);
    function GetActivePage: TAdvSmoothTabPage;
    function GetActivePageIndex: Integer;
    procedure SetActivePage(const Value: TAdvSmoothTabPage);
    procedure SetActivePageIndex(const Value: Integer);
    procedure SetTabSettings(const Value: TAdvSmoothTabSettings);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SeTAdvSmoothTabPosition(const Value: TAdvSmoothTabPosition);
    procedure SetPageMargin(const Value: integer);
  protected
    procedure AlignControls(AControl: TControl; var ARect: TRect); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetParent(AParent: TWinControl); override;
    procedure WndProc(var Msg: TMessage); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure DrawTab(PageIndex: Integer);
    procedure DrawAllTabs;
    procedure Paint; override;

    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetSmoothTabBounds(SmoothTab: TAdvSmoothTabPage; var ALeft, ATop, AWidth, AHeight: Integer);

    procedure UpdateMe(PropID: integer);
    procedure ChangeActivePage(PageIndex: Integer);

    function CanShowTab(PageIndex: Integer): Boolean;
    function GetVisibleTabCount: Integer;

    procedure InvalidateTab(PageIndex: Integer);
    procedure DoExit; override;
    procedure DoEnter; override;
    function GetSmoothTabRect: TRect;
    function GetTabsArea: TRect;
    function GetTabsRect: TRect;
    function GetTabRect(StartIndex, PageIndex: Integer; totalsize: integer): TRect;  overload;
    function GetTabRect(PageIndex: Integer): TRect;  overload;
    function GetTabRect(Page: TAdvSmoothTabPage): TRect; overload;
    function PTOnTab(X, Y: Integer): Integer;

    function IsActivePageNeighbour(PageIndex: Integer): Integer; 
    function UseOldDrawing: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    destructor Destroy; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure Init;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    function GetVersionNr: integer;
    function AddAdvSmoothTabPage(SmoothTab: TAdvSmoothTabPage): integer; overload;
    function AddAdvSmoothTabPage(PageCaption: TCaption): integer; overload;
    procedure RemoveAdvSmoothTabPage(SmoothTab: TAdvSmoothTabPage);
    procedure MoveAdvSmoothTabPage(CurIndex, NewIndex: Integer);
    function FindNextPage(CurPage: TAdvSmoothTabPage; GoForward, CheckTabVisible: Boolean): TAdvSmoothTabPage;
    procedure SelectNextPage(GoForward: Boolean);
    function IndexOfPage(SmoothTab: TAdvSmoothTabPage): Integer;
    function IndexOfTabAt(X,Y: Integer): integer;
    property ActivePageIndex: Integer read GetActivePageIndex write SetActivePageIndex;
    property AdvSmoothTabPageCount: integer read GetAdvSmoothTabPageCount;
    property AdvSmoothTabPages[index: integer]: TAdvSmoothTabPage read GetAdvSmoothTabPages;
    procedure SetComponentStyle(AStyle: TTMSStyle);
  published
    property Align;
    property Anchors;
    property ActivePage: TAdvSmoothTabPage read GetActivePage write SetActivePage;
    property Constraints;
    property PageMargin: integer read FPageMargin write SetPageMargin default 1;
    property PopupMenu: TPopupMenu read GetPopupMenuEx write SetPopupMenuEx;
    property ShowHint;
    property TabPosition: TAdvSmoothTabPosition read FTabPosition write SeTAdvSmoothTabPosition default tpTopCenter;
    property TabSettings: TAdvSmoothTabSettings read FTabSettings write SetTabSettings;
    property TabReorder: Boolean read FTabReorder write FTabReorder;
    property Version: string read GetVersion write SetVersion stored false;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TTabChangingEvent read FOnChanging write FOnChanging;
    property OnDrawTab: TDrawTabEvent read FOnDrawTab write FOnDrawTab;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnTabMoved: TTabMovedEvent read FOnTabMoved write FOnTabMoved;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
    property TabOrder;
    property TabStop;
  end;

implementation

procedure GetPath(l, t, w, h, d, radius: Double; RoundingType: TFillRoundingType; var path: TGPGraphicsPath);
begin
  case RoundingType of
    rtNone:
    begin
      path.AddLine(l, t, l + w, t); // top
      path.AddLine(l + w, t, l + w, t + h); // right
      path.AddLine(l + w, t + h, l, t + h); // bottom
      path.AddLine(l, t + h, l, t); // left
    end;
    rtRight:
    begin
      path.AddLine(l, t, l + w - radius, t); // top
      path.AddArc(l + w - d, t, d, d, 270, 90); // topright
      path.AddLine(l + w, t + radius, l + w, t + h - radius); // right
      path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
      path.AddLine(l + w, t + h, l, t + h); // bottom
      path.AddLine(l, t + h - radius, l, t + radius); // left
    end;
    rtLeft:
    begin
      path.AddArc(l, t, d, d, 180, 90); // topleft
      path.AddLine(l + radius, t, l + w - radius, t); // top
      path.AddLine(l + w, t, l + w, t + h); // right
      path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
      path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
      path.AddLine(l, t + h - radius, l, t + radius); // left
    end;
    rtTop:
    begin
      path.AddArc(l, t, d, d, 180, 90); // topleft
      path.AddLine(l + radius, t, l + w - radius, t); // top
      path.AddArc(l + w - d, t, d, d, 270, 90); // topright
      path.AddLine(l + w, t + radius, l + w, t + h); // right
      path.AddLine(l + w, t + h, l, t + h); // bottom
      path.AddLine(l, t + h, l, t + Radius); // left
    end;
    rtBottom:
    begin
      path.AddLine(l, t, l + w, t); // top
      path.AddLine(l + w, t, l + w, t + h - radius); // right
      path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
      path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
      path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
      path.AddLine(l, t + h - Radius, l, t ); // left
    end;
    rtBoth:
    begin
      path.AddArc(l, t, d, d, 180, 90); // topleft
      path.AddLine(l + radius, t, l + w - radius, t); // top
      path.AddArc(l + w - d, t, d, d, 270, 90); // topright
      path.AddLine(l + w, t + radius, l + w, t + h - radius); // right
      path.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
      path.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
      path.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
      path.AddLine(l, t + h - radius, l, t + radius); // left
    end;
  end;
end;

function CreateRoundRectangle(R: TGPRectF; Radius: Integer; RoundingType: TFillRoundingType; Mirror: Boolean): TGPGraphicsPath; overload;
var
  l, t, w, h, d: Double;
begin
  Result := TGPGraphicsPath.Create;
  l := R.X;
  t := R.Y;
  w := R.Width;
  h := R.Height;
  d := Radius shl 1;
  GetPath(l, t, w, h, d, radius, RoundingType, Result);
  Result.CloseFigure();
end;

procedure DrawFocus(g: TGPGraphics; r: TGPRectF; rn: Integer; rt: TFillRoundingType);
var
  pathfocus: TGPGraphicsPath;
  pfocus: TGPPen;
begin
  pathfocus := CreateRoundRectangle(r, rn, rt, false);
  g.SetSmoothingMode(SmoothingModeDefault);
  pfocus := TGPPen.Create(MakeColor(255, clBlack), 1);
  pfocus.SetDashStyle(DashStyleDot);
  g.DrawPath(pfocus, pathfocus);
  pfocus.Free;
  pathfocus.Free;
end;

{ TAdvSmoothTabSettings }

constructor TAdvSmoothTabSettings.Create;
begin
  inherited;
  FLeftMargin := 4;
  FRightMargin := 4;
  FHeight := 26;
  FStartMargin := 4;
  FEndMargin := 0;
  FSpacing := 4;
  FWidth := 0;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabSettings.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothTabSettings) then
  begin
    LeftMargin := (Source as TAdvSmoothTabSettings).LeftMargin;
    RightMargin := (Source as TAdvSmoothTabSettings).RightMargin;
    Height := (Source as TAdvSmoothTabSettings).Height;
    StartMargin := (Source as TAdvSmoothTabSettings).StartMargin;
    EndMargin := (Source as TAdvSmoothTabSettings).EndMargin;
    Width := (Source as TAdvSmoothTabSettings).Width;
  end
  else
    inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabSettings.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabSettings.SetLeftMargin(const Value: Integer);
begin
  if (FLeftMargin <> Value) then
  begin
    FLeftMargin := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabSettings.SetRightMargin(const Value: Integer);
begin
  if (FRightMargin <> Value) then
  begin
    FRightMargin := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabSettings.SetHeight(const Value: Integer);
begin
  if (FHeight <> Value) then
  begin
    FHeight := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabSettings.SetStartMargin(const Value: Integer);
begin
  if (FStartMargin <> Value) then
  begin
    FStartMargin := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabSettings.SetEndMargin(const Value: Integer);
begin
  if (FEndMargin <> Value) then
  begin
    FEndMargin := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabSettings.SetSpacing(const Value: Integer);
begin
  if (FSpacing <> Value) then
  begin
    FSpacing := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabSettings.SetWidth(const Value: Integer);
begin
  if (FWidth <> Value) then
  begin
    FWidth := Value;
    changed;
  end;
end;

{ TDbgList }

function TDbgList.GetItemsEx(Index: Integer): Pointer;
begin
  if (Index >= Count) then
  begin
    raise Exception.Create('Index out of bounds in list read access');
  end;

  if Index < Count then
    Result := inherited Items[Index]
  else
    Result := nil;
end;

//------------------------------------------------------------------------------

procedure TDbgList.SetItemsEx(Index: Integer; const Value: Pointer);
begin
  if (Index >= Count) then
  begin
    raise Exception.Create('Index out of bounds in list write access');
  end;
  if Index < Count then
    inherited Items[Index] := value;
end;


{ TAdvSmoothTabPage }

constructor TAdvSmoothTabPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csAcceptsControls] - [csOpaque];
  FCaption := '';
  FTabVisible := True;
  FTabEnabled := True;
  FImageIndex := -1;

  FDesignTime := (csDesigning in ComponentState) and not
      ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  FTabAppearance := TAdvSmoothTabAppearance.Create(Self);
  FTabAppearance.OnChange := OnTabAppearanceChanged;

  FPageAppearance := TGDIPFill.Create;
  FPageAppearance.OnChange := OnPageAppearanceChanged;

  DoubleBuffered := true;

  if FDesignTime then
    SetComponentStyle(tsOffice2007Luna);
end;

//------------------------------------------------------------------------------

destructor TAdvSmoothTabPage.Destroy;
begin
  if (FAdvSmoothTabPager <> nil) then
  begin
    FAdvSmoothTabPager.RemoveAdvSmoothTabPage(Self);
  end;

  FTabAppearance.Free;
  FPageAppearance.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.AlignControls(AControl: TControl; var ARect: TRect);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Showing then
  begin
    if Assigned(FOnShow) then
      FOnShow(self);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.Loaded;
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.Paint;
var
  R: TRect;
  g: TGPGraphics;
  TabRect: TRect;
  p1, p2: TGPPen;
  bevel: integer;
begin
  R := ClientRect;
  with PageAppearance do
  begin
    g := TGPGraphics.Create(Canvas.Handle);
    g.SetSmoothingMode(SmoothingModeAntiAlias);
    PageAppearance.Fill(g, MakeRect(0, 0, R.Right - R.Left - 1
      , R.Bottom - R.Top - 1));

    if not Assigned(FAdvSmoothTabPager) then
      Exit;
      
    with FAdvSmoothTabPager do
    begin
      if (ActivePageIndex = FPageIndex) and (ActivePageIndex < FAdvSmoothTabPager.FAdvSmoothTabPages.Count)
        and (ActivePageIndex > -1) then
      begin
        TabRect := GetTabRect(ActivePageIndex);
        if (FPageAppearance.GradientType <> gtSolid) and (FPageAppearance.ColorTo <> clNone) then
        begin
          p1 := TGPPen.Create(MakeColor(FPageAppearance.Opacity, FPageAppearance.Color), FPageAppearance.BorderWidth + 1);
          p2 := TGPPen.Create(MakeColor(FPageAppearance.OpacityTo, FPageAppearance.ColorTo), FPageAppearance.BorderWidth + 1);
        end
        else
        begin
          p1 := TGPPen.Create(MakeColor(FPageAppearance.Opacity, FPageAppearance.Color), FPageAppearance.BorderWidth + 1);
          p2 := TGPPen.Create(MakeColor(FPageAppearance.Opacity, FPageAppearance.Color), FPageAppearance.BorderWidth + 1);
        end;

        bevel := 0;
        if TabAppearance.Bevel then
          bevel := 1;
          
        case TabPosition of
          tpTopLeft, tpTopCenter, tpTopRight:
          begin
            if (FPageAppearance.GradientType = gtSolid) or (FPageAppearance.GradientType = gtVertical) or (FPageAppearance.ColorTo = clNone) then
            begin
              g.DrawLine(p1, TabRect.Left - PageMargin + bevel, 0, TabRect.Right  - PageMargin - 3 - bevel, 0);
            end;
          end;
          tpLeftCenter, tpLeftBottom, tpLeftTop:
          begin
            if (FPageAppearance.GradientType = gtSolid) or (FPageAppearance.GradientType = gtHorizontal) or (FPageAppearance.ColorTo = clNone) then
            begin
              g.DrawLine(p1, 0, TabRect.Top + bevel, 0, TabRect.Bottom - 3 - bevel);
            end;
          end;
          tpBottomCenter, tpBottomRight, tpBottomLeft:
          begin
            if (FPageAppearance.GradientType = gtSolid) or (FPageAppearance.GradientType = gtVertical) or (FPageAppearance.ColorTo = clNone) then
            begin
              g.DrawLine(p2, TabRect.Left + bevel - PageMargin, r.Bottom - 1, TabRect.Right - 3 - bevel, r.Bottom - 1);
            end;
          end;
          tpRightCenter, tpRightBottom, tpRightTop:
          begin
            if (FPageAppearance.GradientType = gtSolid) or (FPageAppearance.GradientType = gtHorizontal) or (FPageAppearance.ColorTo = clNone) then
            begin
              g.DrawLine(p2, R.Right - 1, TabRect.Top + bevel, R.Right - 1, TabRect.Bottom - 3 - bevel);
            end;
          end;
        end;
        p1.Free;
        p2.Free;
      end;
    end;
    g.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.SetAdvSmoothTabPager(const Value: TAdvSmoothTabPager);
begin
  if (FAdvSmoothTabPager <> Value) then
  begin
    if FAdvSmoothTabPager <> nil then FAdvSmoothTabPager.RemoveAdvSmoothTabPage(Self);
    Parent := Value;
    if (Value <> nil) then
    begin
      Value.AddAdvSmoothTabPage(Self);
      if not (csLoading in ComponentState) then
      begin
        if Value.AdvSmoothTabPageCount > 1 then
        begin
          TabAppearance.Assign(Value.AdvSmoothTabPages[Value.AdvSmoothTabPageCount - 2].TabAppearance);
          PageAppearance.Assign(Value.AdvSmoothTabPages[Value.AdvSmoothTabPageCount - 2].PageAppearance);
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.SetParent(AParent: TWinControl);
var
  ci, ni: Integer;
  AOfficePager: TAdvSmoothTabPager;
begin
  if ((AParent is TAdvSmoothTabPage) or (AParent is TAdvSmoothTabPager)) and not (FUpdatingParent) then
  begin
    AOfficePager := nil;
    if (AParent is TAdvSmoothTabPage) then
    begin
      AOfficePager := TAdvSmoothTabPage(AParent).FAdvSmoothTabPager;
    end
    else if (AParent is TAdvSmoothTabPager) then
    begin
      AOfficePager := TAdvSmoothTabPager(AParent);
    end;

    if Assigned(FAdvSmoothTabPager) and Assigned(AOfficePager) then
    begin

      if (FAdvSmoothTabPager <> AOfficePager) then
      begin
        FUpdatingParent := True;
        AdvSmoothTabPager := AOfficePager;
        FUpdatingParent := False;
      end;

      if (FAdvSmoothTabPager = AOfficePager) then
      begin
        if (AParent is TAdvSmoothTabPage) then
        begin
          ci := FAdvSmoothTabPager.IndexOfPage(self);
          ni := FAdvSmoothTabPager.IndexOfPage(TAdvSmoothTabPage(AParent));
          AParent := AOfficePager;
          if (ci >= 0) and (ci < FAdvSmoothTabPager.FAdvSmoothTabPages.Count) and
             (ni >= 0) and (ni < FAdvSmoothTabPager.FAdvSmoothTabPages.Count) then
          begin
            FAdvSmoothTabPager.MoveAdvSmoothTabPage(ci, ni);
          end
          else
            raise Exception.Create('Invalid Parent '+inttostr(ci)+':'+inttostr(ni));
        end
        else if (AParent is TAdvSmoothTabPager) then
        begin
          AParent := AOfficePager;
        end;
        
        FAdvSmoothTabPager.Invalidate;
        Invalidate;
      end
      else
        raise Exception.Create('Invalid Parent');
    end;
    //else
      //raise Exception.Create('Invalid Parent3');
  end;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.SetTabVisible(const Value: Boolean);
begin
  if (FTabVisible <> Value) then
  begin
    FTabVisible := Value;
    if Assigned(FAdvSmoothTabPager) then
    begin
      if Assigned(FAdvSmoothTabPager.ActivePage) then
        FAdvSmoothTabPager.ActivePage.Invalidate;
      FAdvSmoothTabPager.Invalidate;
    end;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.WMSize(var Message: TWMSize);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.CMControlChange(var Message: TCMControlChange);
begin
  inherited;
  with Message do
  begin

  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.CMControlListChange(var Message: TCMControlListChange);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.WMEraseBkGnd(var Message: TWMEraseBkGnd);
{var
  DC: HDC;
  i: Integer;
  p: TPoint; }
begin
  if {FTransparent} False then
  begin
    if Assigned(Parent) then
    begin
     { DC := Message.DC;
      i := SaveDC(DC);
      p := ClientOrigin;
      Windows.ScreenToClient(Parent.Handle, p);
      p.x := -p.x;
      p.y := -p.y;
      MoveWindowOrg(DC, p.x, p.y);
      SendMessage(Parent.Handle, WM_ERASEBKGND, DC, 0);
      SendMessage(Parent.Handle, WM_PAINT, DC, 0);
      if (Parent is TWinCtrl) then
        (Parent as TWinCtrl).PaintCtrls(DC, nil);
      RestoreDC(DC, i); }
    end;
  end
  else
  begin
    inherited;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TAdvSmoothTabPager then
    AdvSmoothTabPager := TAdvSmoothTabPager(Reader.Parent);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.SetCaption(const Value: TCaption);
begin
  if (FCaption <> Value) then
  begin
    FCaption := Value;
    Invalidate;
    if Assigned(FAdvSmoothTabPager) then
    begin
      FAdvSmoothTabPager.Invalidate;
    end;
  end;
end;

procedure TAdvSmoothTabPage.SetComponentStyle(AStyle: TTMSStyle);
begin
  inherited;
  with TabAppearance do
  begin
    case astyle of
      tsOffice2003Blue:
      begin
        Color := $00E3B28D;
        ColorDown := $AAD9FF;
        ColorDisabled := $00F2F2F2;
      end;
      tsOffice2003Silver:
      begin
        Color := $00927476;
        ColorDown := $AAD9FF;
        ColorDisabled := $947C7C;
      end;
      tsOffice2003Olive:
      begin
        Color := $447A63;
        ColorDown := $AAD9FF;
        ColorDisabled := $947C7C;
      end;
      tsOffice2003Classic:
      begin
        Color := $00C9D1D5;
        ColorDown := $AAD9FF;
        ColorDisabled := $FFD1AD;  
      end;
      tsOffice2007Luna:
      begin
        Color := $00FDEADA;
        ColorDown := $AAD9FF;
        ColorDisabled := $FFD1AD;
      end;
      tsOffice2007Obsidian:
      begin
        Color := $006E6E6D;
        ColorDown := $AAD9FF;
        ColorDisabled := $FFD1AD;
      end;
      tsWindowsXP:
      begin
        Color := $B9D8DC;
        ColorDown := $AAD9FF;
        ColorDisabled := $FFD1AD;
      end;
      tsWhidbey:
      begin
        Color := $00828F92;
        ColorDown := $AAD9FF;
        ColorDisabled := $FFD1AD;
      end;
      tsCustom: ;
      tsOffice2007Silver:
      begin
        Color := $00E7DCD5;
        ColorDown := $AAD9FF;
        ColorDisabled := $FFD1AD;
      end;
    end;

    BevelColor := Color;
    ColorSelected := ColorDown;

    case AStyle of
      tsOffice2003Blue: BevelColor := $962D00;
    end;
  end;

  case AStyle of
    tsOffice2003Blue:
      begin
        PageAppearance.Color := $FCE1CB;
        PageAppearance.ColorTo := $E0A57D;
        PageAppearance.ColorMirror := clNone;
        PageAppearance.ColorMirrorTo := clNone;
        PageAppearance.BorderColor := $962D00;
        PageAppearance.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Silver:
      begin
        TabAppearance.Color := $ECE2E1;
        TabAppearance.BevelColor := $947C7C;
        PageAppearance.Color := $ECE2E1;
        PageAppearance.ColorTo := $B39698;
        PageAppearance.ColorMirror := clNone;
        PageAppearance.ColorMirrorTo := clNone;
        PageAppearance.BorderColor := $947C7C;
        PageAppearance.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Olive:
      begin
        TabAppearance.Color := $CFF0EA;
        TabAppearance.BevelColor := $588060;
        PageAppearance.Color := $CFF0EA;
        PageAppearance.ColorTo := $8CC0B1;
        PageAppearance.ColorMirror := clNone;
        PageAppearance.ColorMirrorTo := clNone;
        PageAppearance.BorderColor := $588060;
        PageAppearance.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Classic:
      begin
        TabAppearance.Color := clWhite;
        TabAppearance.BevelColor := $808080;
        PageAppearance.Color := clWhite;
        PageAppearance.ColorTo := $C9D1D5;
        PageAppearance.ColorMirror := clNone;
        PageAppearance.ColorMirrorTo := clNone;
        PageAppearance.BorderColor := $808080;
        PageAppearance.GradientMirrorType := gtVertical;
      end;
    tsOffice2007Luna:
      begin
        TabAppearance.Color := $FFEFE3;
        TabAppearance.BevelColor := $FFD1AD;
        PageAppearance.Color := $FFEFE3;
        PageAppearance.ColorTo := $FFDDC4;
        PageAppearance.ColorMirror := $FFD1AD;
        PageAppearance.ColorMirrorTo := $FFDBC0;
        PageAppearance.BorderColor := $FFD1AD;
        PageAppearance.GradientMirrorType := gtVertical;
      end;
    tsOffice2007Obsidian:
      begin
        TabAppearance.Color := $F9F8F8;
        TabAppearance.BevelColor := clBlack;
        PageAppearance.Color := $F9F8F8;
        PageAppearance.ColorTo := $E4E2DF;
        PageAppearance.ColorMirror := $D1CBC7;
        PageAppearance.ColorMirrorTo := $E2DEDB;
        PageAppearance.BorderColor := clBlack;//$D1CBC7;
        PageAppearance.GradientMirrorType := gtVertical;
      end;
    tsWindowsXP:
      begin
        TabAppearance.Color := clWhite;
        TabAppearance.BevelColor := clBlack;
        PageAppearance.Color := clWhite;
        PageAppearance.ColorTo := clBtnFace;
        PageAppearance.ColorMirror := clNone;
        PageAppearance.ColorMirrorTo := clNone;
        PageAppearance.BorderColor := clBlack;
        PageAppearance.GradientMirrorType := gtVertical;
      end;
    tsWhidbey:
      begin
        TabAppearance.Color := $F5F9FA;
        TabAppearance.BevelColor := $962D00;
        PageAppearance.Color := $F5F9FA;
        PageAppearance.ColorTo := $A8C0C0;
        PageAppearance.ColorMirror := clNone;
        PageAppearance.ColorMirrorTo := clNone;
        PageAppearance.BorderColor := $962D00;
        PageAppearance.GradientMirrorType := gtVertical;
      end;
    tsCustom: ;
    tsOffice2007Silver:
      begin
        TabAppearance.Color := $FAEEEB;
        TabAppearance.BevelColor := clBlack;
        PageAppearance.Color := $FAEEEB;
        PageAppearance.ColorTo := $E5DBD7;
        PageAppearance.ColorMirror := $E2D8D4;
        PageAppearance.ColorMirrorTo := $D1C7C5;
        PageAppearance.BorderColor := clBlack;//$E2D8D4;
        PageAppearance.GradientMirrorType := gtVertical;
      end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.SetTabEnabled(const Value: Boolean);
begin
  if (FTabEnabled <> Value) then
  begin
    FTabEnabled := Value;
    Invalidate;
    if Assigned(FAdvSmoothTabPager) then
      FAdvSmoothTabPager.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
  if Assigned(FAdvSmoothTabPager) then
    FAdvSmoothTabPager.Invalidate;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPage.GetPageIndex: Integer;
begin
  if Assigned(FAdvSmoothTabPager) then
    Result := FAdvSmoothTabPager.IndexOfPage(Self)
  else
    Result := -1;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.SetPageIndex(const Value: Integer);
begin
  if Assigned(FAdvSmoothTabPager) and (Value >= 0) and (Value < FAdvSmoothTabPager.AdvSmoothTabPageCount) then
  begin
    FAdvSmoothTabPager.MoveAdvSmoothTabPage(FAdvSmoothTabPager.IndexOfPage(Self), Value);
    FAdvSmoothTabPager.Invalidate;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.AdjustClientRect(var Rect: TRect);
begin
  Rect := Classes.Rect(2, 2, Rect.Right-2, Rect.Bottom - 2);
  inherited AdjustClientRect(Rect);
end;

procedure TAdvSmoothTabPage.SetTabAppearance(const Value: TAdvSmoothTabAppearance);
begin
  FTabAppearance.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.OnPageAppearanceChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TAdvSmoothTabPage.OnTabAppearanceChanged(Sender: TObject);
begin
  if Assigned(FAdvSmoothTabPager) then
    FAdvSmoothTabPager.Invalidate;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPage.SetPageAppearance(const Value: TGDIPFill);
begin
  FPageAppearance.Assign(Value);
end;


{ TAdvSmoothTabPager }

constructor TAdvSmoothTabPager.Create(AOwner: TComponent);
begin
  FConstructed := false;
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls] - [csOpaque];

  FOffSetX := 0;
  FOffSetY := 0;

  FTabOffSet := 4;
  FPageMargin := 1;

  FTabPosition := tpTopCenter;

  FAdvSmoothTabPages := TDbgList.Create;

  FTabSettings := TAdvSmoothTabSettings.Create;
  FTabSettings.OnChange := OnTabSettingsChanged;

  FActivePageIndex := -1;
  FHotPageIndex := -1;
  FOldHotPageIndex := -1;
  FDownPageIndex := -1;

  DoubleBuffered := true;
  Height := 250;
  Width := 500;

  FTabReorder := False;

  FDesignTime := (csDesigning in ComponentState) and not
      ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.CreateParams(var Params: TCreateParams);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.CreateWnd;
var
  p: TWinControl;
  t: TAdvSmoothTabPage;
  gotpages: boolean;
  i: integer;

begin
  inherited;

  if FConstructed then
    Exit;  

  gotpages := false;

  if not (csDesigning in ComponentState) then
  begin
    p := self;

    repeat
      p := p.Parent;
    until (p is TForm) {$IFNDEF TMSDOTNET} or (p is TActiveForm) {$ENDIF} or not Assigned(p);

    if Assigned(p) then
    begin
      for i := 0 to p.ComponentCount - 1 do
      begin
        if p.Components[i].Name = Name + '1' then
          gotpages := true;
      end;
    end;

  end;

  if FDesignTime and (Name <> '') and not gotpages then
  begin
    t := TAdvSmoothTabPage.Create(Owner);
    t.AdvSmoothTabPager := self;
    t.Name := Name + '1';
    t.Caption := t.Name;
    t := TAdvSmoothTabPage.Create(Owner);
    t.AdvSmoothTabPager := self;
    t.Name := Name + '2';
    t.Caption := t.Name;
    t := TAdvSmoothTabPage.Create(Owner);
    t.AdvSmoothTabPager := self;
    t.Name := Name + '3';
    t.Caption := t.Name;
    ActivePageIndex := 0;
  end;

  FConstructed := true;
end;

//------------------------------------------------------------------------------

destructor TAdvSmoothTabPager.Destroy;
var
  i: Integer;
begin
  for I := 0 to FAdvSmoothTabPages.Count - 1 do
    TAdvSmoothTabPage(FAdvSmoothTabPages[I]).FAdvSmoothTabPager := nil;

  FAdvSmoothTabPages.Free;
  FTabSettings.Free;
  inherited;
end;

procedure TAdvSmoothTabPager.DoEnter;
begin
  inherited;
  FFocused := true;
  Changed;
end;

procedure TAdvSmoothTabPager.DoExit;
begin
  inherited;
  FFocused := false;
  Changed;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.MoveAdvSmoothTabPage(CurIndex, NewIndex: Integer);
var
  OldActivePage: TAdvSmoothTabPage;
begin
  if (CurIndex >= 0) and (CurIndex < FAdvSmoothTabPages.Count) and
     (NewIndex >= 0) and (NewIndex < FAdvSmoothTabPages.Count) then
  begin
    OldActivePage := ActivePage;
    FAdvSmoothTabPages.Move(CurIndex, NewIndex);
    ActivePage := OldActivePage;

    if Assigned(FOnTabMoved) then
      FOnTabMoved(Self, CurIndex, NewIndex);
  end;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.AddAdvSmoothTabPage(SmoothTab: TAdvSmoothTabPage): integer;
begin
  Result := FAdvSmoothTabPages.IndexOf(SmoothTab);
  if (FAdvSmoothTabPages.IndexOf(SmoothTab) < 0) then
  begin
    FAdvSmoothTabPages.Add(SmoothTab);
    SmoothTab.FPageIndex := FAdvSmoothTabPages.Count - 1;    
    Result := FAdvSmoothTabPages.Count - 1;
  end;

  if (SmoothTab.Parent <> Self) then
    SmoothTab.Parent := Self;
  SmoothTab.FAdvSmoothTabPager := Self;
  SetPagePosition(SmoothTab);
  if (SmoothTab <> ActivePage) then
    SmoothTab.Visible := False;

  InvalidateTab(-1);
  if Assigned(ActivePage) then
  begin
    ActivePage.BringToFront;
    ActivePage.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.AddAdvSmoothTabPage(PageCaption: TCaption): integer;
var
  aPage: TAdvSmoothTabPage;
begin
  aPage := TAdvSmoothTabPage.Create(Self);
  aPage.Caption := PageCaption;
  aPage.FPageIndex := FAdvSmoothTabPages.Count - 1;
  Result := AddAdvSmoothTabPage(aPage);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.AlignControls(AControl: TControl;
  var ARect: TRect);
begin
  inherited;
  {if (AControl <> nil) and (AControl is TAdvSmoothTabPage) then
    SetPagePosition(TAdvSmoothTabPage(AControl))
  else if (AControl is TAdvSmoothTabPage) then}
    SetAllPagesPosition;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.Loaded;
begin
  inherited;
  FPropertiesLoaded := True;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if not (csDestroying in ComponentState) and (Operation = opRemove) then
  begin
    if (AComponent = PopupMenu) then
      PopupMenu := nil;
  end;

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
end;

//------------------------------------------------------------------------------
procedure TAdvSmoothTabPager.DrawTab(PageIndex: Integer);
var
  R: TRect;
  g: TGPGraphics;
  roundingtype: TFillRoundingType;
  vertical: Boolean;
  righttoleft: Boolean;
  x, y, hs, vs: integer;
  c: TColor;
  tf: TFont;
  lf: TLogFont;
  tw, th: integer;
  d: Boolean;
  textr: TRect;
  pt: TPoint;
  textrw, textrh: integer;
  ly: TGDIPButtonLayout;
  
begin
  if (PageIndex < 0) or (PageIndex >= FAdvSmoothTabPages.Count) or (TabSettings.Height <= 0) then
    Exit;

  R := GetTabRect(PageIndex);

  if (R.Left <= -1) and (R.Right <= -1) then
    Exit;

  with AdvSmoothTabPages[PageIndex].TabAppearance do
  begin
    roundingtype := rtTop;
    vertical := false;
    righttoleft := false;
    case TabPosition of
      tpTopLeft, tpTopCenter, tpTopRight:
      begin
        vertical := false;
        righttoleft := false;
        roundingtype := rtTop;
      end;
      tpLeftCenter, tpLeftBottom, tpLeftTop:
      begin
        vertical := true;
        righttoleft := true;
        roundingtype := rtLeft;
      end;
      tpRightCenter, tpRightTop, tpRightBottom:
      begin
        vertical := true;
        righttoleft := false;
        roundingtype := rtRight;
      end;
      tpBottomCenter, tpBottomLeft, tpBottomRight:
      begin
        vertical := false;
        righttoleft := false;
        roundingtype := rtBottom;
      end;
    end;

    hs := 0;
    vs := 0;
    if Status.Visible then
    begin
      hs := HorizontalSpacing;
      vs := VerticalSpacing;
    end;

    d := (FDownPageIndex = PageIndex);
    if AdvSmoothTabPages[PageIndex].TabEnabled then
    begin
      if (FActivePageIndex = PageIndex) then
        c := ColorSelected
      else if (FHotPageIndex = PageIndex) then
        c := ColorHot
      else
        c := Color
    end
    else
    begin
      c := ColorDisabled;
      d := false;
    end;

    th := 0;
    tw := 0;
    textrw := 0;
    textrh := 0;
    if vertical then
    begin
      tf := TFont.Create;
      tf.Assign(FAppearance.Font);
      GetObject(tf.Handle, SizeOf(lf), @lf);
      if RightToLeft then
      begin
        lf.lfEscapement := 900;
        lf.lfOrientation := 900;
      end
      else
      begin
        lf.lfEscapement := -900;
        lf.lfOrientation := -900;
      end;
      
      tf.Handle := CreateFontIndirect(lf);
      Canvas.Font.Assign(tf);
      Canvas.Brush.Style := bsClear;
      tw := Canvas.TextWidth(AdvSmoothTabPages[PageIndex].Caption);
      th := Canvas.TextHeight('gh');

      textr := Rect(R.Left + hs, r.Top + vs, r.Right - hs, r.Bottom - vs);
      textrw := textr.Right - textr.Left;
      textrh := textr.Bottom - textr.Top;
      tf.Free;      
    end;

    g := TGPGraphics.Create(Canvas.Handle);
    g.SetSmoothingMode(SmoothingModeAntiAlias);

    FAppearance.Draw(g, AdvSmoothTabPages[PageIndex].Caption, R.Left - hs, R.Top - vs, R.Right - R.Left + (hs * 2), R.Bottom - R.Top + (vs * 2), hs, vs,
      c, ColorDown, BevelColor, Shadow, d, Bevel, vertical, righttoleft, roundingtype, Picture, th, tw, false);

    g.Free;

    if vertical then
    begin
      pt := Point(textr.Left + (textrw - th) div 2, textr.Top + (textrh - tw) div 2);
      if (Picture <> nil) and not Picture.Empty then
      begin
        ly := FAppearance.Layout;
        Picture.GetImageSizes;
        if TabPosition in [tpRightTop, tpRightBottom, tpRightCenter] then
        begin
          case FAppearance.Layout of
            blPictureLeft: ly := blPictureTop;
            blPictureRight: ly := blPictureBottom;
            blPictureBottom: ly := blPictureRight;
            blPictureTop: ly := blPictureLeft;
          end;
        end
        else
        begin
          case FAppearance.Layout of
            blPictureLeft: ly := blPictureBottom;
            blPictureRight: ly := blPictureTop;
            blPictureBottom: ly := blPictureRight;
            blPictureTop: ly := blPictureLeft;
          end;
        end;

        case ly of
          blPictureLeft:
          begin
            pt := Point(textr.Left + (textrw - th - picture.Width - Appearance.Spacing) div 2,
              textr.Top + (textrh - tw) div 2);
            pt.X := pt.X + Picture.Width + Appearance.Spacing;
          end;
          blPictureRight:
          begin
            pt := Point(textr.Left + (textrw - th - picture.Width - Appearance.Spacing) div 2,
              textr.Top + (textrh - tw) div 2);
          end;
          blPictureBottom:
          begin
            pt := Point(textr.Left + (textrw - th) div 2,
              textr.top + (textrh - tw - Appearance.Spacing - Picture.Height) div 2);
          end;
          blPictureTop:
          begin
            pt := Point(textr.Left + (textrw - th) div 2,
              textr.Top + (textrh - tw - Appearance.Spacing - Picture.Height) div 2);
            pt.Y := pt.Y + Picture.Height + Appearance.Spacing;
          end;
        end;
      end;

      if RightToLeft then
        Canvas.TextOut(pt.X, pt.Y + tw , AdvSmoothTabPages[PageIndex].Caption)
      else
        Canvas.TextOut(pt.X + th, pt.Y , AdvSmoothTabPages[PageIndex].Caption);
    end;

    g := TGPGraphics.Create(Canvas.Handle);
    g.SetSmoothingMode(SmoothingModeAntiAlias);    

    with Status do
    begin
      Appearance.CalculateSize(g, Status.Caption);
      x := R.Right + FStatus.OffsetLeft - FStatus.Appearance.GetWidth;
      y := Status.OffsetTop + R.Top;
      if Status.Visible then
        Appearance.Draw(g, Status.OffsetLeft + x, y, 0, 0, true,Status.Caption);
    end;

    if TabStop and Ffocused and (ActivePageIndex = PageIndex) then
      DrawFocus(g, MakeRect(R.Left - hs, R.Top - vs, R.Right - R.Left + (hs * 2), R.Bottom - R.Top + (vs * 2)), 8, rtBoth);
    

    g.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.DrawAllTabs;
var
  i: Integer;
begin
  for i:= 0 to FAdvSmoothTabPages.Count-1 do
    DrawTab(i);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.Paint;
var
  R: TRect;
  th: integer;
begin
  inherited;

  R := ClientRect;

  DrawAllTabs;

  if (csDesigning in ComponentState) and (FAdvSmoothTabPages.Count = 0) then
  begin
    Canvas.Font.Assign(self.Font);
    Canvas.Brush.Style := bsClear;
    th := Canvas.TextHeight('gh');
    Canvas.TextOut(10, Height div 2, 'Right-click and choose "New Page"');
    Canvas.TextOut(10, (Height div 2) + th,'to insert a new tabsheet');
    Canvas.Font.Style := [fsItalic];
    Canvas.TextOut(10, Height div 2 + 3*th, 'If no such right-click menu option appears');
    Canvas.TextOut(10, Height div 2 + 4*th, 'please install designtime package!');
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.ReMoveAdvSmoothTabPage(SmoothTab: TAdvSmoothTabPage);
var
  i, ni: Integer;
begin
  i := FAdvSmoothTabPages.IndexOf(SmoothTab);
  if (i >= 0) then
  begin
    if i < ActivePageIndex then
      ni := ActivePageIndex - 1
    else
      ni := ActivePageIndex;

    if (ActivePage = SmoothTab) then
      SelectNextPage(True);

    FAdvSmoothTabPages.Delete(i);
    SmoothTab.FAdvSmoothTabPager := nil;

    ActivePageIndex := ni;
    InvalidateTab(-1);
    Invalidate;
    if Assigned(ActivePage) then
      ActivePage.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetParent(AParent: TWinControl);
begin
  if (AParent is TAdvSmoothTabPager) then
    raise Exception.Create('Invalid Parent');

  inherited;

  if (not FPropertiesLoaded) and not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
  begin
    Init;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetAdvSmoothTabPageCount: integer;
begin
  Result := FAdvSmoothTabPages.Count;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetAdvSmoothTabPages(index: integer): TAdvSmoothTabPage;
begin
  Result := TAdvSmoothTabPage(FAdvSmoothTabPages[index]);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetSmoothTabBounds(SmoothTab: TAdvSmoothTabPage;
  var ALeft, ATop, AWidth, AHeight: Integer);
begin
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetChildOrder(Child: TComponent; Order: Integer);
begin
  inherited SetChildOrder(Child, Order);
end;

procedure TAdvSmoothTabPager.SetComponentStyle(AStyle: TTMSStyle);
var
  i: integer;
begin
  inherited;
  for I := 0 to FAdvSmoothTabPages.Count - 1 do
     AdvSmoothTabPages[I].SetComponentStyle(AStyle); 
end;

//------------------------------------------------------------------------------


procedure TAdvSmoothTabPager.WMSize(var Message: TWMSize);
begin
  inherited;
  SetAllPagesPosition;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetPopupMenuEx(const Value: TPopupMenu);
begin
  Inherited PopupMenu := Value;
  (*if Assigned(PopupMenu) and (PopupMenu is TAdvPopupMenu) and Assigned(FCurrentOfficePagerStyler) then
    TAdvPopupMenu(PopupMenu).MenuStyler := FCurrentOfficePagerStyler.CurrentAdvMenuStyler; *)
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.CMShowingChanged(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetPopupMenuEx: TPopupMenu;
begin
  Result := Inherited PopupMenu;
end;

procedure TAdvSmoothTabPager.CMControlChange(var Message: TCMControlChange);
begin
  inherited;

  with Message do
  begin
    if (Control is TAdvSmoothTabPage) then
    begin
      if Inserting then
        //InsertControl(Control)
      else
        //RemoveControl(Control);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.CMControlListChange(
  var Message: TCMControlListChange);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
end;

procedure TAdvSmoothTabPager.CMMouseLeave(var Msg: TMessage);
var
  P: TPoint;
  R: TRect;
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  // work around to avoid false call
  GetCursorPos(P);
  P := ScreenToClient(P);
  R := GetTabsRect;
  case (TabPosition) of
    tpTopLeft, tpTopRight, tpTopCenter: R.Bottom := R.Bottom - 4;
    tpBottomRight, tpBottomLeft, tpBottomCenter: R.Top := R.Top + 4;
    tpLeftTop, tpLeftBottom, tpLeftCenter: R.Right := R.Right - 4;
    tpRightTop, tpRightBottom, tpRightCenter: R.Left := R.Left + 4;
  end;

  if PtInRect(R, P) then
    Exit;

  if (FHotPageIndex = FActivePageIndex) then
  begin
    FHotPageIndex := -1;
    Invalidate;
  end
  else if (FHotPageIndex >= 0) then
  begin
    FHotPageIndex := -1;
    InvalidateTab(-1);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  Tab: Integer;
begin
  inherited;
  SetFocus;
  P := Point(X, Y);

  FDownPageIndex := -1;

  if PtInRect(GetTabsArea, p) then
  begin
    Tab := PTOnTab(X, Y);
    if (Tab >= 0) then
    begin
      if (Tab <> ActivePageIndex) and AdvSmoothTabPages[Tab].TabEnabled then
      begin
        // Select Tab
        FDownPageIndex := Tab;        
        InvalidateTab(Tab);
        ChangeActivePage(Tab);
        Invalidate;
      end
      else
      begin
        FDownPageIndex := Tab;
        InvalidateTab(FDownPageIndex);
      end;

      if (Button = mbLeft) and AdvSmoothTabPages[Tab].TabEnabled and TabReorder then
      begin
        BeginDrag(false,4);
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  Tab: Integer;
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  P := Point(X, Y);

  if PtInRect(GetTabsArea, p) then
  begin
    Tab := PTOnTab(X, Y);
    if (Tab >= 0) and (Tab <> FHotPageIndex) then
    begin
      if (FDownPageIndex >= 0) then
      begin
        FDownPageIndex := -1;
        InvalidateTab(-1);
      end;

      if (FHotPageIndex >= 0) then
      begin
        OnExitTab(FHotPageIndex);
        begin
          FHotPageIndex := -1;
          InvalidateTab(-1);
        end;
      end;

      OnEnterTab(Tab);
      if AdvSmoothTabPages[Tab].TabEnabled then
      begin
        FHotPageIndex := Tab;
        FOldHotPageIndex := FHotPageIndex;
        Invalidate;
      end;
    end
    else if (Tab < 0) and (FHotPageIndex >= 0) then
    begin
      if (FDownPageIndex >= 0) then
      begin
        FDownPageIndex := -1;
        InvalidateTab(-1);
      end;
      OnExitTab(FHotPageIndex);
      if (FHotPageIndex = FActivePageIndex) and false then
      begin
        FHotPageIndex := -1;
        Invalidate;
      end
      else
      begin
        FHotPageIndex := -1;
        InvalidateTab(-1);
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  inherited;
  P := Point(X, Y);

  if (FDownPageIndex >= 0) then
  begin
    FDownPageIndex := -1;
    InvalidateTab(-1);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.GetChildren(Proc: TGetChildProc;
  Root: TComponent);
var
  I: Integer;
  Control: TControl;
begin
  for I := 0 to FAdvSmoothTabPages.Count - 1 do Proc(TComponent(FAdvSmoothTabPages[I]));

  for I := 0 to ControlCount - 1 do
  begin
    Control := Controls[I];
    if (Control.Owner = Root) and (FAdvSmoothTabPages.IndexOf(Control) < 0) then Proc(Control);
  end;

end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.FindNextPage(CurPage: TAdvSmoothTabPage; GoForward,
  CheckTabVisible: Boolean): TAdvSmoothTabPage;
var
  i, j, CurIndex: Integer;
begin
  Result := nil;
  CurIndex := FAdvSmoothTabPages.IndexOf(CurPage);


  if (CurPage = nil) or (CurIndex < 0) then
  begin

    if FAdvSmoothTabPages.Count > 0 then
    begin
      if GoForward then
        Result := FAdvSmoothTabPages[0]
      else
        Result := FAdvSmoothTabPages[FAdvSmoothTabPages.Count - 1];
    end;
    Exit;
  end;
    
  if GoForward then
  begin
    i := CurIndex;
    j := 0; //1;
    while (j < FAdvSmoothTabPages.Count) do
    begin
      Inc(i);    
      if (i >= FAdvSmoothTabPages.Count) then
        i := 0;
      if (CheckTabVisible and AdvSmoothTabPages[i].TabVisible) or not CheckTabVisible then
      begin
        Result := AdvSmoothTabPages[i];
        Break;
      end;
      Inc(j);
    end;
  end
  else  // BackWard
  begin
    i := CurIndex;
    j := 0; //1;
    while (j < FAdvSmoothTabPages.Count) do
    begin
      dec(i);
      if (i >= FAdvSmoothTabPages.Count) then
        i := 0;
      if (i < 0) then
        i := FAdvSmoothTabPages.Count-1;
      if (CheckTabVisible and AdvSmoothTabPages[i].TabVisible) or not CheckTabVisible then
      begin
        Result := AdvSmoothTabPages[i];
        Break;
      end;
      Inc(j);
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetActivePage: TAdvSmoothTabPage;
begin
  Result := nil;
  if (ActivePageIndex >= 0) and (ActivePageIndex < FAdvSmoothTabPages.Count) then
    Result := AdvSmoothTabPages[FActivePageIndex];
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetActivePageIndex: Integer;
begin
  Result := FActivePageIndex;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SelectNextPage(GoForward: Boolean);
var
  i, j: Integer;
begin
  if (ActivePageIndex < 0) then
    Exit;

  if GoForward then
  begin
    i := ActivePageIndex;
    j := 0; //1;
    while (j < FAdvSmoothTabPages.Count) do
    begin
      Inc(i);
      if (i >= FAdvSmoothTabPages.Count) then
        i := 0;
      if (ActivePage <> AdvSmoothTabPages[i]) and AdvSmoothTabPages[i].TabVisible and AdvSmoothTabPages[i].TabEnabled then
      begin
        ActivePageIndex := i;
        Break;
      end;
      Inc(j);
    end;
  end
  else  // BackWard
  begin
    i := ActivePageIndex;
    j := 0; //1;
    while (j < FAdvSmoothTabPages.Count) do
    begin
      dec(i);
      if (i >= FAdvSmoothTabPages.Count) then
        i := 0;
      if (i < 0) then
        i := FAdvSmoothTabPages.Count-1;
      if (ActivePage <> AdvSmoothTabPages[i]) and AdvSmoothTabPages[i].TabVisible and AdvSmoothTabPages[i].TabEnabled then
      begin
        ActivePageIndex := i;
        Break;
      end;
      Inc(j);
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.IndexOfPage(SmoothTab: TAdvSmoothTabPage): Integer;
begin
  Result := FAdvSmoothTabPages.IndexOf(SmoothTab);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetActivePage(const Value: TAdvSmoothTabPage);
begin
  if (FAdvSmoothTabPages.IndexOf(Value) >= 0) then
    ActivePageIndex := FAdvSmoothTabPages.IndexOf(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.ChangeActivePage(PageIndex: Integer);
var
  aForm: TCustomForm;
  AllowChange: Boolean;
begin
  if (PageIndex >= 0) and (PageIndex < FAdvSmoothTabPages.Count) and (PageIndex <> ActivePageIndex) then
  begin
    AllowChange := True;
    if Assigned(FOnChanging) and FPropertiesLoaded and not (csDestroying in ComponentState) then
      FOnChanging(Self, ActivePageIndex, PageIndex, AllowChange);

    if not AllowChange then
      Exit;

    if (ActivePageIndex >= 0) and (ActivePageIndex < FAdvSmoothTabPages.Count) then
    begin
      AdvSmoothTabPages[FActivePageIndex].Visible := False;

      if Assigned(AdvSmoothTabPages[FActivePageIndex].FOnHide) then
        AdvSmoothTabPages[FActivePageIndex].FOnHide(AdvSmoothTabPages[FActivePageIndex]);
    end;

    FActivePageIndex := PageIndex;
    AdvSmoothTabPages[FActivePageIndex].Visible := True;
    AdvSmoothTabPages[FActivePageIndex].BringToFront;

    if Assigned(FOnChange) and not (csDestroying in ComponentState)
      and not (csLoading in ComponentState) then
      FOnChange(Self);

    if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    begin
      aForm := GetParentForm(Self);
      if (aForm <> nil) and (aForm.Designer <> nil) then
        aForm.Designer.Modified;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetActivePageIndex(const Value: Integer);
var
  R: TRect;
begin
  ChangeActivePage(Value);
  R := GetTabsArea;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetTabSettings(const Value: TAdvSmoothTabSettings);
begin
  FTabSettings.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetAllPagesPosition;
var
  i: Integer;
begin
  for i:= 0 to FAdvSmoothTabPages.Count-1 do
  begin
    SetPagePosition(TAdvSmoothTabPage(FAdvSmoothTabPages[i]));
  end;
end;

function TAdvSmoothTabPager.GetSmoothTabRect: TRect;
begin
  Result := ClientRect;
  case TabPosition of
    tpTopLeft, tpTopRight, tpTopCenter:
    begin
      Result.Top := Result.Top + TabSettings.Height;
      Result.Left := Result.Left + FPageMargin;
      Result.Right := Result.Right-FPageMargin;
      Result.Bottom := Result.Bottom - FPageMargin-1;
    end;
    tpBottomLeft, tpBottomRight, tpBottomCenter:
    begin
      Result.Top := Result.Top + FPageMargin+1;
      Result.Left := Result.Left + FPageMargin;
      Result.Right := Result.Right-FPageMargin;
      Result.Bottom := Result.Bottom - TabSettings.Height;
    end;
    tpLeftTop, tpLeftBottom, tpLeftCenter:
    begin
      Result.Top := Result.Top + FPageMargin+1;
      Result.Left := Result.Left + TabSettings.Height;
      Result.Right := Result.Right-FPageMargin;
      Result.Bottom := Result.Bottom - FPageMargin-1;
    end;
    tpRightTop, tpRightBottom, tpRightCenter:
    begin
      Result.Top := Result.Top + FPageMargin+1;
      Result.Left := Result.Left + FPageMargin;
      Result.Right := Result.Right- TabSettings.Height;
      Result.Bottom := Result.Bottom - FPageMargin-1;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetPagePosition(SmoothTab: TAdvSmoothTabPage);
var
  R: TRect;
begin
  if (SmoothTab <> nil) and (FAdvSmoothTabPages.IndexOf(SmoothTab) >= 0) then
  begin
    R := GetSmoothTabRect;
    SmoothTab.Left := R.Left;
    SmoothTab.Top := R.Top;
    SmoothTab.Width := R.Right - R.Left;
    SmoothTab.Height := R.Bottom - R.Top;
  end;
end;

function TAdvSmoothTabPager.IndexOfTabAt(X,Y: Integer): integer;
begin
  Result := PtOnTab(x,y);
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.PTOnTab(X, Y: Integer): Integer;
var
  i: Integer;
  P: TPoint;
  TabR: TRect;
begin
  Result := -1;
  P := Point(X, Y);
  for i:= 0 to FAdvSmoothTabPages.Count-1 do
  begin
    TabR := GetTabRect(i);
    if PtInRect(TabR, P) then
    begin
      Result := i;
      Break;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetTabsArea: TRect;
begin
  Result := ClientRect;
  case TabPosition of
    tpTopLeft, tpTopRight, tpTopCenter: Result.Bottom := Result.Top + FTabSettings.Height;
    tpBottomLeft, tpBottomRight, tpBottomCenter: Result.Top := Result.Bottom - FTabSettings.Height;
    tpLeftTop, tpLeftBottom, tpLeftCenter: Result.Right := Result.Left + FTabSettings.Height;
    tpRightTop, tpRightBottom, tpRightCenter: Result.Left := Result.Right - FTabSettings.Height;
  end;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetTabsRect: TRect;
begin
  Result := ClientRect;
  case TabPosition of
    tpTopLeft, tpTopRight, tpTopCenter:
    begin
      Result.Top := Result.Top + FTabOffSet;
      Result.Bottom := Result.Top + FTabSettings.Height;
      Result.Left := Result.Left + FTabSettings.StartMargin + FPageMargin;
      Result.Right := Result.Right - FTabSettings.EndMargin;
    end;
    tpBottomLeft, tpBottomRight, tpBottomCenter:
    begin
      Result.Top := Result.Bottom - FTabSettings.Height - FTabOffSet;
      Result.Bottom := Result.Bottom - FTabOffSet;
      Result.Left := Result.Left + FTabSettings.StartMargin + FPageMargin;
      Result.Right := Result.Right - FTabSettings.EndMargin;
    end;
    tpLeftTop, tpLeftBottom, tpLeftCenter:
    begin
      Result.Top := Result.Top + FTabSettings.StartMargin + FPageMargin;
      Result.Bottom := Result.Bottom - FTabSettings.EndMargin;
      Result.Left := Result.Left + FTabOffSet;
      Result.Right := Result.Left + FTabSettings.Height;
    end;
    tpRightTop, tpRightBottom, tpRightCenter:
    begin
      Result.Top := Result.Top + FTabSettings.StartMargin + FPageMargin;
      Result.Bottom := Result.Bottom - FTabSettings.EndMargin;
      Result.Left := Result.Right - TabSettings.Height - FTabOffSet;
      Result.Right := Result.Right - FTabOffSet;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetTabRect(PageIndex: Integer): TRect;
var
  totals: integer;
  r, rlast: TREct;
  ilast: integer;
  I: Integer;
begin
  r := GetTabRect(0, 0, -1);
  iLast := 0;
  for I := FAdvSmoothTabPages.Count - 1 downto 0 do
  begin
    if AdvSmoothTabPages[I].TabVisible then
    begin
      iLast := I;
      break;
    end;
  end;

  rlast := GetTabRect(0,ilast, -1);
  totals := -1;
  case TabPosition of
    tpBottomCenter, tpTopCenter, tpBottomRight, tpTopRight: totals := (rlast.Right - r.left) + TabSettings.Spacing;
    tpLeftCenter, tpLeftBottom, tpRightCenter, tpRightBottom: totals := (rlast.Bottom - r.Top) + TabSettings.Spacing;
  end;

  Result := GetTabRect(0, PageIndex, totals);
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetTabRect(StartIndex, PageIndex: Integer; totalsize: integer): TRect;
var
  i, TbW, Sp, fdW: Integer;
  R, CR, R2: TRect;
begin
  Result := Rect(-1, -1, -1, -1);
  Sp := FTabSettings.Spacing; //0;
  fdW := 5;

  if (PageIndex >= 0) and (PageIndex < FAdvSmoothTabPages.Count) then
  begin
    if not AdvSmoothTabPages[PageIndex].TabVisible then
      Exit;

    CR := GetTabsRect; // ClientRect;

    if totalsize <> -1 then
    begin
      case TabPosition of
        tpBottomRight, tpTopRight: CR.Left := CR.Right - totalsize;
        tpBottomCenter, tpTopCenter: CR.Left := (CR.Right - totalsize) div 2;
        tpLeftBottom, tpRightBottom: CR.Top := CR.Bottom - totalsize;
        tpLeftCenter, tpRightCenter: CR.Top := (CR.Bottom - totalsize) div 2;
      end;
    end;

    begin
      for i := StartIndex to PageIndex do
      begin
        if not AdvSmoothTabPages[i].TabVisible then
          Continue;

        Canvas.Font.Assign(AdvSmoothTabPages[i].TabAppearance.Appearance.Font);

        if (TabPosition in [tpTopLeft, tpTopRight, tpTopCenter, tpBottomLeft, tpBottomRight, tpBottomCenter]) then
        begin
          if (AdvSmoothTabPages[i].Caption <> '') then
          begin
            R2 := Rect(0,0, 1000, 100);
            DrawText(Canvas.Handle,PChar(AdvSmoothTabPages[i].Caption),Length(AdvSmoothTabPages[i].Caption), R2, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
          end
          else
            R2 := Rect(0, 0, 0, 0);
            TbW := TabSettings.LeftMargin + R2.Right + fdW + TabSettings.RightMargin;

          if (TabSettings.Width > 0) then
            TbW := TabSettings.Width;

          if not AdvSmoothTabPages[i].TabAppearance.Picture.Empty then
          begin
            AdvSmoothTabPages[i].TabAppearance.Picture.GetImageSizes;
            R := Rect(CR.Left, CR.Top, CR.Left + TbW + AdvSmoothTabPages[i].TabAppearance.Picture.Width + AdvSmoothTabPages[i].TabAppearance.Appearance.Spacing, CR.Bottom);
            CR.Left := CR.Left + TbW + Sp + AdvSmoothTabPages[i].TabAppearance.Picture.Width + AdvSmoothTabPages[i].TabAppearance.Appearance.Spacing;
          end
          else
          begin
            R := Rect(CR.Left, CR.Top, CR.Left + TbW, CR.Bottom);
            CR.Left := CR.Left + TbW + Sp;
          end;

          if (i = PageIndex) then
            Result := R;
        end
        else 
        begin
          if (AdvSmoothTabPages[i].Caption <> '') then
          begin
            R2 := Rect(0,0, 1000, 100);
            DrawText(Canvas.Handle,PChar(AdvSmoothTabPages[i].Caption),Length(AdvSmoothTabPages[i].Caption), R2, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
          end
          else
            R2 := Rect(0, 0, 0, 0);
            
          TbW := TabSettings.LeftMargin + R2.Right+ fdW + TabSettings.RightMargin;

          if (TabSettings.Width > 0) then
            TbW := TabSettings.Width;

          if not AdvSmoothTabPages[i].TabAppearance.Picture.Empty then
          begin
            AdvSmoothTabPages[i].TabAppearance.Picture.GetImageSizes;
            R := Rect(CR.Left, CR.Top, CR.Right, CR.Top + TbW + AdvSmoothTabPages[i].TabAppearance.Picture.Height + AdvSmoothTabPages[i].TabAppearance.Appearance.Spacing);
            CR.Top := CR.Top + TbW + Sp + AdvSmoothTabPages[i].TabAppearance.Picture.Height + AdvSmoothTabPages[i].TabAppearance.Appearance.Spacing;
          end
          else
          begin
            R := Rect(CR.Left, CR.Top, CR.Right, CR.Top + TbW);
            CR.Top := CR.Top + TbW + Sp;
          end;

          if (i = PageIndex) then
            Result := R;          
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetTabRect(Page: TAdvSmoothTabPage): TRect;
begin
  Result := GetTabRect(FAdvSmoothTabPages.IndexOf(Page));
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.CMDesignHitTest(var Msg: TCMDesignHitTest);
var
  p: TPoint;
  Tab: Integer;
begin
  Tab := -1;
  if (csDesigning in ComponentState) then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);

    if PtInRect(GetTabsRect, p) and (GetAsyncKeyState(VK_LBUTTON) <> 0) then
    begin
      Tab := PTOnTab(P.X, P.Y);
      if (Tab >= 0) then
      begin
        // Select Tab
        //ActivePageIndex := Tab;
        Msg.Result := 1;
      end;
    end;

  end;

  if (Tab = -1) then
    inherited;
end;

procedure TAdvSmoothTabPager.InvalidateTab(PageIndex: Integer);
var
  R: TRect;
begin
  if (PageIndex >= 0) and (PageIndex < FAdvSmoothTabPages.Count) then
    R := GetTabRect(PageIndex)
  else
    R := GetTabsArea;
  InvalidateRect(Handle, @R, True);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.OnEnterTab(PageIndex: Integer);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.OnExitTab(PageIndex: Integer);
begin

end;

procedure TAdvSmoothTabPager.OnTabSettingsChanged(Sender: TObject);
begin
  SetAllPagesPosition;
  Invalidate;
  if Assigned(ActivePage) then
    ActivePage.Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.UpdateMe(PropID: integer);
begin
  Invalidate;
  if Assigned(ActivePage) then
    ActivePage.Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetVersion(const Value: string);
begin

end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SeTAdvSmoothTabPosition(const Value: TAdvSmoothTabPosition);
begin
  if (FTabPosition <> Value) then
  begin
    FTabPosition := Value;
    SetAllPagesPosition;
    Invalidate;
    if Assigned(ActivePage) then
      ActivePage.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.CMDialogChar(var Message: TCMDialogChar);
var
  I: Integer;
begin
  for I:= 0 to FAdvSmoothTabPages.Count-1 do
    if IsAccel(Message.CharCode, AdvSmoothTabPages[I].Caption) and CanShowTab(I) and CanFocus then
    begin
      Message.Result := 1;
      ActivePageIndex := I;
      Exit;
    end;
  inherited;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.CanShowTab(PageIndex: Integer): Boolean;
begin
  Result := (PageIndex >= 0) and (PageIndex < FAdvSmoothTabPages.Count) and (AdvSmoothTabPages[PageIndex].TabVisible);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.SetPageMargin(const Value: integer);
begin
  if FPageMargin <> Value then
  begin
    FPageMargin := Value;
    Changed;
  end;
end;

function TAdvSmoothTabPager.GetVisibleTabCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FAdvSmoothTabPages.Count-1 do
  begin
    if (AdvSmoothTabPages[I].TabVisible) then
      Result := Result + 1;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.Init;
begin
  FPropertiesLoaded := true;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.WMKeyDown(var Message: TWMKeyDown);
var
  Ctrl: TWinControl;
begin
  case Message.CharCode of
    VK_LEFT, VK_UP:
    begin
      SelectNextPage(False);
    end;
    VK_RIGHT, VK_DOWN:
    begin
      SelectNextPage(True);
    end;
    VK_TAB:
    begin
      if Assigned(Self.Parent) then
      begin
        Ctrl := TProWinControl(Self.Parent).FindNextControl(Self, True, True, True);
        if Assigned(Ctrl) and Ctrl.CanFocus then
        begin
          Ctrl.SetFocus;
        end;
      end;
    end;
  end;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS + DLGC_WANTCHARS{ + DLGC_WANTTAB};
  {using DLGC_WANTTAB, disabled default Tab key functioning}
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.CMDialogKey(var Message: TCMDialogKey);
begin
  (*if TabStop and Assigned(ActivePage) and (Message.CharCode = 18{ALT}) then
  begin
    if not FTabShortCutHintShowing and (CanFocus) then
    begin
      if not Focused then
        Self.SetFocus;
      Message.Result := 1;
      ShowShortCutHintOfAllPages;
      Exit;
    end
    else if FTabShortCutHintShowing then
    begin
      HideShortCutHintOfAllPages;
      Message.Result := 1;
      Exit;
    end;
  end; *)
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.CMFocusChanged(var Message: TCMFocusChanged);
{var
  i: Integer;
  h: HWND;
  Active: Boolean;}
begin
  inherited;
  InvalidateTab(-1);
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.WMKillFocus(var Message: TWMSetFocus);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.WndProc(var Msg: TMessage);
var
  p: TWinControl;
begin
  if (Msg.Msg = WM_DESTROY) then
  begin
    // restore subclassed proc
    if not (csDesigning in ComponentState) and Assigned(FFormWndProc) then
    begin
      p := self;
      repeat
        p := p.Parent;
      until (p is TForm) {$IFNDEF TMSDOTNET} or (p is TActiveForm) {$ENDIF} or not Assigned(p);

      if (p <> nil) then
      begin
        p.WindowProc := FFormWndProc;
        FFormWndProc := nil;
      end;
    end;
  end;

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.DragDrop(Source: TObject; X, Y: Integer);
var
  CurIndex, NewIndex: Integer;
begin
  inherited;
  CurIndex := ActivePageIndex;
  NewIndex := PTOnTab(X, Y);
  if (CurIndex >= 0) and (CurIndex < AdvSmoothTabPageCount) and (NewIndex >= 0) and (NewIndex < AdvSmoothTabPageCount) and (CurIndex <> NewIndex) then
  begin
    MoveAdvSmoothTabPage(CurIndex, NewIndex);
    Invalidate;
    if Assigned(ActivePage) then
      ActivePage.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvSmoothTabPager.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  i: Integer;
begin
  inherited;
  i := PTOnTab(X, Y);
  Accept := (i >= 0) and (i < AdvSmoothTabPageCount) and (Source = Self);
end;

function TAdvSmoothTabPager.UseOldDrawing: Boolean;
begin
  Result := true;
end;

//------------------------------------------------------------------------------

function TAdvSmoothTabPager.IsActivePageNeighbour(
  PageIndex: Integer): Integer;
var
  i: Integer;  
begin
  Result := 0;
  if (PageIndex = ActivePageIndex) or (PageIndex < 0) or (PageIndex >= AdvSmoothTabPageCount) then
    Exit;

  if (PageIndex < ActivePageIndex) then
  begin
    for i:= ActivePageIndex - 1 downto PageIndex do
    begin
      if AdvSmoothTabPages[i].TabVisible then
      begin
        if (i = PageIndex) then
          Result := -1;
        Break;
      end;
    end;
  end
  else // if (PageIndex > ActivePageIndex) then
  begin
    for i:= ActivePageIndex + 1 to PageIndex do
    begin
      if AdvSmoothTabPages[i].TabVisible then
      begin
        if (i = PageIndex) then
          Result := 1;
        Break;
      end;
    end;
  end;
end;

{ TAdvSmoothTabAppearance }

procedure TAdvSmoothTabAppearance.AppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothTabAppearance.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothTabAppearance) then
  begin
    FAppearance.Assign((Source as TAdvSmoothTabAppearance).Appearance);
    FStatus.Assign((Source as TAdvSmoothTabAppearance).Status);
    FBevel := (Source as TAdvSmoothTabAppearance).Bevel;
    FBevelColor := (Source as TAdvSmoothTabAppearance).BevelColor;
    FColor := (Source as TAdvSmoothTabAppearance).Color;
    FPicture.Assign((Source as TAdvSmoothTabAppearance).Picture);
    FShadow := (Source as TAdvSmoothTabAppearance).Shadow;
    FHorizontalSpacing := (Source as TAdvSmoothTabAppearance).HorizontalSpacing;
    FVerticalSpacing := (Source as TAdvSmoothTabAppearance).VerticalSpacing;
    FColorSelected := (Source as TAdvSmoothTabAppearance).ColorSelected;
    FColorDown := (Source as TAdvSmoothTabAppearance).ColorDown;
    FColorDisabled := (Source as TAdvSmoothTabAppearance).ColorDisabled;
    FColorHot := (Source as TAdvSmoothTabAppearance).ColorHot;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TAdvSmoothTabAppearance.Create(AOwner: TAdvSmoothTabPage);
begin
  FOwner := AOwner;
  FAppearance := TGDIPButton.Create;
  FAppearance.OnChange := AppearanceChanged;
  FStatus :=  TAdvSmoothTabStatus.Create(Self);
  FStatus.OnChange := StatusChanged;
  FBevel := true;
  FBevelColor := clGray;
  FColor := clSilver;
  FPicture := TAdvGDIPPicture.Create;
  FPicture.OnChange := PictureChanged;
  FShadow := false;
  FHorizontalSpacing := 0;
  FVerticalSpacing := 0;
  FColorDown := clGray;
  FColorSelected := $AAD9FF;
  FColorDisabled := $545454;
  FColorHot := clWhite;

  if FOwner.FDesigntime then
  begin
    FStatus.FAppearance.Fill.Color := clRed;
    FStatus.FAppearance.Fill.GradientType := gtSolid;
    FStatus.FAppearance.Fill.BorderColor := clGray;
    FStatus.FAppearance.Font.Color := clWhite;
  end;
end;

destructor TAdvSmoothTabAppearance.Destroy;
begin
  FAppearance.Free;
  FStatus.Free;
  FPicture.Free;
  inherited;
end;

procedure TAdvSmoothTabAppearance.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothTabAppearance.SetAppearance(const Value: TGDIPButton);
begin
  if FAppearance <> value then
  begin
    FAppearance := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.SetBevel(const Value: boolean);
begin
  if FBevel <> value then
  begin
    FBevel := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.SetBevelColor(const Value: TColor);
begin
  if FBevelColor <> value then
  begin
    FBevelColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.SetStatus(
  const Value: TAdvSmoothTabStatus);
begin
  if FStatus <> value then
  begin
    FStatus.Assign(Value);
    StatusChanged(Self);
  end;
end;

procedure TAdvSmoothTabAppearance.SetColor(const Value: TColor);
begin
  if FColor <> value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.SetColorDisabled(const Value: TColor);
begin
  if FColorDisabled <> value then
  begin
    FColorDisabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.SetColorDown(const Value: TColor);
begin
  if FColorDown <> value then
  begin
    FColorDown := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.SetColorHot(const Value: TColor);
begin
  if FColorHot <> value then
  begin
    FColorHot := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.SetColorSelected(const Value: TColor);
begin
  if FColorSelected <> value then
  begin
    FColorSelected := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.SetHorizontalSpacing(const Value: integer);
begin
  if FHorizontalSpacing <> value then
  begin
    FHorizontalSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.SetPicture(const Value: TAdvGDIPPicture);
begin
  if FPicture <> value then
  begin
    FPicture.Assign(Value);
    PictureChanged(Self);
  end;
end;

procedure TAdvSmoothTabAppearance.SetShadow(const Value: boolean);
begin
  if FShadow <> value then
  begin
    FShadow := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.SetVerticalSpacing(const Value: integer);
begin
  if FVerticalSpacing <> value then
  begin
    FVerticalSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabAppearance.StatusChanged(Sender: TObject);
begin
  Changed;
end;

{ TAdvSmoothTabStatus }

procedure TAdvSmoothTabStatus.AppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothTabStatus.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothTabStatus) then
  begin
    FAppearance.Assign((Source as TAdvSmoothTabStatus).Appearance);
    FCaption := (Source as TAdvSmoothTabStatus).Caption;
    FOffsetTop := (Source as TAdvSmoothTabStatus).OffsetTop;
    FOffsetLeft := (Source as TAdvSmoothTabStatus).OffsetLeft;
    FVisible := (Source as TAdvSmoothTabStatus).Visible;
  end;
end;

procedure TAdvSmoothTabStatus.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothTabStatus.Create(AOwner: TAdvSmoothTabAppearance);
begin
  FOwner := AOwner;
  FOwner := AOwner;
  FOffsetTop := 0;
  FOffsetLeft := 0;
  FVisible := False;
  FCaption := '0';
  FAppearance := TGDIPStatus.Create;
  FAppearance.OnChange := AppearanceChanged;
end;

destructor TAdvSmoothTabStatus.Destroy;
begin
  FAppearance.Free;
  inherited;
end;

procedure TAdvSmoothTabStatus.SetAppearance(const Value: TGDIPStatus);
begin
  if FAppearance <> value then
  begin
    FAppearance.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTabStatus.SetCaption(const Value: String);
begin
  if FCaption <> value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabStatus.SetOffsetLeft(const Value: integer);
begin
  if FOffsetLeft <> value then
  begin
    FOffsetLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabStatus.SetOffsetTop(const Value: integer);
begin
  if FOffsetTop <> value then
  begin
    FOffsetTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTabStatus.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

end.
