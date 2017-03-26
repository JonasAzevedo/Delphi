{***************************************************************************}
{ TAdvPageControl component                                                 }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2003 - 2009                                        }
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

unit AdvPageControl;

{$I TMSDEFS.INC}
{$T-}

interface

uses
  Messages, Windows, SysUtils, CommCtrl, Classes, Controls, Forms,
  Graphics, ImgList, ComCtrls, Math, Dialogs
{$IFDEF DELPHI7_LVL}
  , Types
{$ENDIF}
{$IFDEF TMSDOTNET}
  , System.runtime.InteropServices
{$ENDIF}
  ;

const
  CloseButtonWidth = 14;
  CloseButtonHeight = 13;

  MAJ_VER = 1; // Major version nr.
  MIN_VER = 6; // Minor version nr.
  REL_VER = 1; // Release nr.
  BLD_VER = 0; // Build nr.

  // Revision history
  // 1.3.2.0 : Property FreeOnClose added
  // 1.4.0.0 : custom close glyph support
  //         : tabsheet Color, ColorTo properties added
  // 1.4.0.1 : fixed active font display when tab background bitmaps are used
  // 1.4.0.2 : memory leak in imagelist handling fixed
  // 1.4.0.3 : OnChange event triggered after tab is closed to indicate new active tab
  // 1.4.0.4 : tabwidth fix
  // 1.4.5.0 : added support for grayed tabs for disabled tabsheets
  // 1.4.6.0 : reduced flickering during pagecontrol resizing
  // 1.4.7.0 : Fixed issue with component used as DockSite
  // 1.4.7.1 : Fixed issue with bottom border painting for right side tabs
  // 1.4.7.2 : Improved painting for pagecontrol without pages
  // 1.5.0.0 : Added TabStyle tsDelphi to simulate Delphi 2005 tabs
  // 1.5.0.1 : Fixed issue with custom painting through OnDrawTab
  // 1.5.0.2 : Improved image position in tab for left & right mode
  // 1.5.0.3 : Fixed issue with OnCanChange and keyboard tabbing
  // 1.5.0.4 : Improved : small cosmetic painting issue with tab borders
  // 1.5.0.5 : Fixed : painting issue with bottom tabs on Delphi 5
  // 1.5.0.6 : Fixed : issue with accelerator chars
  // 1.5.0.7 : Fixed : issue with OnCanChange for multiline tabs
  // 1.5.0.8 : Fixed : issue with ParentFont property
  // 1.6.0.0 : New : Added ClosePosition property to control left or right side close button
  // 1.6.0.1 : Fixed : tab drawing issue when OnChanging event disallows change of active tab
  // 1.6.1.0 : New : exposed OnDblClick on TAdvTabSheet


type
  TGradientDirection = (gdVertical, gdHorizontal);
  TTabStyle = (tsClassic, tsDotNet, tsDelphi);
  TClosePosition = (cpLeft, cpRight);

  TMarginSize = -MaxInt..MaxInt;

  TMarginChange = procedure(NewValue: TMarginSize; OldValue: TMarginSize; Index: integer) of object;

  TTabMargin = class(TPersistent)
  private
    FLeftMargin: TMarginSize;
    FTopMargin: TMarginSize;
    FRightMargin: TMarginSize;
    FOnMarginChange: TMarginChange;
    procedure SetMargin(Index: integer; Value: TMarginSize);
  protected
    property OnMarginChange: TMarginChange read FOnMarginChange write FOnMarginChange;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property LeftMargin: TMarginSize index 0 read FLeftMargin write SetMargin default 0;
    property TopMargin: TMarginSize index 1 read FTopMargin write SetMargin default 0;
    property RightMargin: TMarginSize index 2 read FRightMargin write SetMargin;
  end;

  TAdvPageControl = class;

{$IFNDEF DELPHI5_LVL}
  TImageIndex = integer;
{$ENDIF}


  TCanCloseEvent = procedure(Sender: TObject; var CanClose: Boolean) of object;

  TCanChangeEvent = procedure(Sender: TObject; FromPage, ToPage: Integer; var AllowChange: Boolean) of object;

  TAdvTabSheet = class(TCustomControl)
  private
    FTabCaption: string;
    FTextColor: TColor;
    FTabColor: TColor;
    FTabColorTo: TColor;
    FShowClose: Boolean;
    FTabGradientDirection: TGradientDirection;
    FHoverGradientDirection: TGradientDirection;
    FImageIndex: TImageIndex;
    FImageIndexDummy: TImageIndex;
    FAdvPageControl: TAdvPageControl;
    FTabVisible: Boolean;
    FTabShowing: Boolean;
    FHighlighted: Boolean;
    FOnHide: TNotifyEvent;
    FOnShow: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FOnCanClose: TCanCloseEvent;
    FTabEnable: boolean;
    FColorTo: TColor;
    function GetCaption: TCaption;
    procedure SetCaption(Value: TCaption);
    function GetPageIndex: Integer;
    function GetTabIndex: Integer;
    procedure SetHighlighted(Value: Boolean);
    function GetImageIndex: TImageIndex;
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetAdvPageControl(AAdvPageControl: TAdvPageControl);
    procedure SetPageIndex(Value: Integer);
    procedure SetTabShowing(Value: Boolean);
    procedure SetTabVisible(Value: Boolean);
    procedure UpdateTabShowing;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CloseButtonClick(Sender: TObject);
    function CanCloseClick(Sender: TObject): Boolean;
    procedure SetShowClose(value: Boolean);
    procedure SetTabGradientDirection(value: TGradientDirection);
    procedure SetHoverGradientDirection(value: TGradientDirection);
    procedure SetTextColor(const Value: TColor);
    procedure SetTabColor(const Value: TColor);
    procedure SetTabColorTo(const Value: TColor);
    procedure SetTabEnable(const Value: boolean);
    procedure SetColorTo(const Value: TColor);
    function GetColor: TColor;
    procedure SetColor(const Value: TColor);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoHide; dynamic;
    procedure DoShow; dynamic;
    procedure ReadState(Reader: TReader); override;
    procedure Paint; override;
    property TabCaption: string read FTabCaption;
    property ImageIndexDummy: TImageIndex read FImageIndexDummy;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AdvPageControl: TAdvPageControl read FAdvPageControl write SetAdvPageControl;
    property TabIndex: Integer read GetTabIndex;
    procedure SelectFirstControl;
  published
    property BorderWidth;
    //property Caption: string read GetRealCaption write SetRealCaption;
    property Caption: TCaption read GetCaption write SetCaption;
    property Color: TColor read GetColor write SetColor;
    property ColorTo: TColor read FColorTo write SetColorTo;
    property DragMode;
    property Enabled;
    property Font;
    property Height stored False;
    property Highlighted: Boolean read FHighlighted write SetHighlighted default False;
    property ImageIndex: TImageIndex read GetImageIndex write SetImageIndex default 0;
    property Left stored False;
    property Constraints;
    property HoverGradientDirection: TGradientDirection read FHoverGradientDirection write SetHoverGradientDirection default gdVertical;
    property TabGradientDirection: TGradientDirection read FTabGradientDirection write SetTabGradientDirection default gdVertical;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property ShowClose: Boolean read FShowClose write SetShowClose default False;
    property TabEnable: boolean read FTabEnable write SetTabEnable default true;
    property TabVisible: Boolean read FTabVisible write SetTabVisible default True;
    property TabColor: TColor read FTabColor write SetTabColor;
    property TabColorTo: TColor read FTabColorTo write SetTabColorTo;
    property TextColor: TColor read FTextColor write SetTextColor default clBlack;
    property Top stored False;
    property Visible stored False;
    property Width stored False;
    property OnCanClose: TCanCloseEvent read FOnCanClose write FOnCanClose;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    {$IFDEF DELPHI5_LVL}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnStartDrag;

  end;

  TTabOverlapSize = 0..15;

  TAdvPageControl = class(TCustomTabControl)
  private
    FPages: TList;
    FActivePage: TAdvTabSheet;
    FNewDockSheet: TAdvTabSheet;
    FUndockingPage: TAdvTabSheet;

    FTabMargin: TTabMargin;
    FClosedTabList: TStringList;
    FOnChange: TNotifyEvent;
    FImages: TCustomImageList;
    FDummyImages: TCustomImageList;
    FDefaultTextColor: TColor;
    FDefaultTabColor: TColor;
    FDefaultTabColorTo: TColor;
    FActiveColor: TColor;
    FActiveColorTo: TColor;
    FTabBorder3D: Boolean;
    FTabBorderColor: TColor;
    FTabHoverColor: TColor;
    FTabHoverColorTo: TColor;
    FTabHoverBorder: TColor;
    FShowFocus: Boolean;
    FHoverClosedButton: Boolean;
    FTabOverlap: TTabOverlapSize;

    FTabSheet3D: Boolean;
    FTabSheetBorderColor: TColor;
    FTabBackGroundColor: TColor;

    FTabSplitLine: Boolean;
    FRoundEdges: Boolean;

    FHoverTab: Integer;
    FTabBackGround: TBitmap;
    FTabBackGroundActive: TBitmap;

    FTabStyle: TTabStyle;
    FLowerActive: integer;

    FPropertiesLoaded: Boolean;
    FFreeOnClose: Boolean;
    FActiveFont: TFont;
    FOnCanChange: TCanChangeEvent;
    FCloseGlyph: TBitmap;
    FFullRefresh: Boolean;
    FOnDrawTab: TDrawTabEvent;
    FUpdateCount: Integer;
    FClosePosition: TClosePosition;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure ActiveFontChangeEvent(Sender: TObject);
    procedure UpdateTabForActiveFont(Page: TAdvTabSheet);
    procedure ChangeActivePage(Page: TAdvTabSheet);
    procedure DeleteTab(Page: TAdvTabSheet; Index: Integer);
    function GetActivePageIndex: Integer;
    function GetDockClientFromMousePos(MousePos: TPoint): TControl;
    function GetPage(Index: Integer): TAdvTabSheet;
    function GetPageCount: Integer;
    procedure InsertPage(Page: TAdvTabSheet);
    procedure InsertTab(Page: TAdvTabSheet);
    procedure MoveTab(CurIndex, NewIndex: Integer);
    procedure RemovePage(Page: TAdvTabSheet);
    procedure SetActivePage(Page: TAdvTabSheet);
    procedure SetActivePageIndex(const Value: Integer);

    procedure SetDefaultTextColor(const Value: TColor);
    procedure SetDefaultTabColor(const Value: TColor);
    procedure SetDefaultTabColorTo(const Value: TColor);
    procedure SetActiveColor(const Value: TColor);
    procedure SetActiveColorTo(const Value: TColor);
    procedure SetTabBorder3D(Value: Boolean);
    procedure SetTabBorderColor(const Value: TColor);
    procedure SetTabBackGround(const Value: TBitmap);
    procedure SetTabBackGroundActive(const Value: TBitmap);
    procedure SetImages(value: TCustomImageList);
    procedure SetTabMargin(Value: TTabMargin);
    procedure SetTabOverlap(Value: TTabOverlapSize);

    procedure SetTabSheet3D(Value: Boolean);
    procedure SetTabSheetBorderColor(Value: TColor);
    procedure SetTabBackGroundColor(Value: TColor);

    procedure SetTabSplitLine(Value: Boolean);
    procedure SetRoundEdges(Value: Boolean);

    procedure SetTabStyle(Value: TTabStyle);
    procedure SetLowerActive(Value: integer);

    function GetTabPosition: TTabPosition;
    procedure SetTabPosition(Value: TTabPosition);

    procedure SetTabMargins;

    procedure DrawCloseGlyph(P: TPoint);
    procedure DrawCloseButton(Rect: TRect; Active: Boolean);
    procedure DrawHoverCloseButton(Rect: TRect);
    procedure DrawDownCloseButton(Rect: TRect);
    function IsOnButton(TabIndex, X, Y: integer): Boolean;
    procedure TabMarginChange(NewValue, OldValue: TMarginSize; Index: integer);

    procedure UpdateTab(Page: TAdvTabSheet);
    procedure UpdateTabHighlights;

    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
{$IFNDEF TMSDOTNET}
    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
{$ENDIF}
    procedure CMDockNotification(var Message: TCMDockNotification); message CM_DOCKNOTIFICATION;
{$IFNDEF TMSDOTNET}
    procedure CMUnDockClient(var Message: TCMUnDockClient); message CM_UNDOCKCLIENT;
{$ENDIF}
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure SetActiveFont(const Value: TFont);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    function GetVersionNr: Integer;
    procedure SetCloseGlyph(const Value: TBitmap);
    procedure SetClosePosition(const Value: TClosePosition);
  protected
{$IFDEF TMSDOTNET}
    function DockClient(DockSource: TDragDockObject; MousePos: TPoint): Integer; override;
    function UndockClient(NewTarget, Client: TControl): Boolean; override;
{$ENDIF}
    function CanShowTab(TabIndex: Integer): Boolean; override;
    procedure Change; override;
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure DoRemoveDockClient(Client: TControl); override;
    function GetImageIndex(TabIndex: Integer): Integer; override;
    function GetPageFromDockClient(Client: TControl): TAdvTabSheet;
    procedure GetSiteInfo(Client: TControl; var InfluenceRect: TRect;
      MousePos: TPoint; var CanDock: Boolean); override;
    procedure Loaded; override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure ShowControl(AControl: TControl); override;
    procedure UpdateActivePage; virtual;

    procedure WndProc(var Message: TMessage); override;
    procedure TabChange(Sender: TObject);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure DrawAllTabs(Canvas: TCanvas);
    function TabRectEx(i: Integer): TRect;
    function IndexOfTabAtEx(X, Y: Integer): Integer;
    function CanChange: Boolean; override;
    procedure BeginUpdate;
    procedure EndUpdate;
  public
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindNextPage(CurPage: TAdvTabSheet; GoForward, CheckTabVisible: Boolean): TAdvTabSheet;
    procedure SelectNextPage(GoForward: Boolean);
    procedure OpenAllClosedTabs;
    function OpenClosedTab(TabName: string): Boolean;
    property ActivePageIndex: Integer read GetActivePageIndex write SetActivePageIndex;
    property PageCount: Integer read GetPageCount;
    property Pages[Index: Integer]: TAdvTabSheet read GetPage;
    property VersionNr: Integer read GetVersionNr;
    property FullRefresh: Boolean read FFullRefresh write FFullRefresh;    
  published
    property ActivePage: TAdvTabSheet read FActivePage write SetActivePage;
    property ActiveFont: TFont read FActiveFont write SetActiveFont;
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property CloseGlyph: TBitmap read FCloseGlyph write SetCloseGlyph;
    property ClosePosition: TClosePosition read FClosePosition write SetClosePosition default cpLeft;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HotTrack;
  //  property Images;
    property Images: TCustomImageList read FImages write SetImages;
    property MultiLine;
    //property OwnerDraw;
    property ParentBiDiMode;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RaggedRight;
    property ScrollOpposite;
    property ShowHint;
    //property Style;
    property FreeOnClose: Boolean read FFreeOnClose write FFreeOnClose default false;
    property ShowFocus: Boolean read FShowFocus write FShowFocus default false;
    property DefaultTextColor: TColor read FDefaultTextColor write SetDefaultTextColor default clBlack;
    property DefaultTabColor: TColor read FDefaultTabColor write SetDefaultTabColor default clBtnFace;
    property DefaultTabColorTo: TColor read FDefaultTabColorTo write SetDefaultTabColorTo default clNone;
    property ActiveColor: TColor read FActiveColor write SetActiveColor default clBtnFace;
    property ActiveColorTo: TColor read FActiveColorTo write SetActiveColorTo default clNone;
    property TabBorder3D: Boolean read FTabBorder3D write SetTabBorder3D default false;
    property TabBorderColor: TColor read FTabBorderColor write SetTabBorderColor default clGray;
    property TabSheet3D: Boolean read FTabSheet3D write SetTabSheet3D default false;
    property TabSheetBorderColor: TColor read FTabSheetBorderColor write SetTabSheetBorderColor default clGray;
    property TabHoverColor: TColor read FTabHoverColor write FTabHoverColor default clNone;
    property TabHoverColorTo: TColor read FTabHoverColorTo write FTabHoverColorTo default clNone;
    property TabHoverBorder: TColor read FTabHoverBorder write FTabHoverBorder default clNone;
    property TabBackGroundColor: TColor read FTabBackGroundColor write SetTabBackGroundColor;
    property TabBackGround: TBitmap read FTabBackGround write SetTabBackGround;
    property TabBackGroundActive: TBitmap read FTabBackGroundActive write SetTabBackGroundActive;
    property TabMargin: TTabMargin read FTabMargin write SetTabMargin;
    property TabOverlap: TTabOverlapSize read FTabOverlap write SetTabOverlap;
    property TabSplitLine: Boolean read FTabSplitLine write SetTabSplitLine default false;
    property RoundEdges: Boolean read FRoundEdges write SetRoundEdges default false;
    property TabStyle: TTabStyle read FTabStyle write SetTabStyle default tsClassic;
    property LowerActive: integer read FLowerActive write SetLowerActive default 2;
    property Version: string read GetVersion write SetVersion;

    property TabHeight;
    property TabOrder;
    //property TabPosition
    property TabPosition read GetTabPosition write SetTabPosition;
    property TabStop;
    property TabWidth;
    property Visible;
    //property OnChange;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging;
    property OnCanChange: TCanChangeEvent read FOnCanChange write FOnCanChange;
    {$IFDEF DELPHI5_LVL}
    property OnContextPopup;
    {$ENDIF}
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    //property OnDrawTab;
    property OnDrawTab: TDrawTabEvent read FOnDrawTab write FOnDrawTab;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;


implementation

uses
  Printers, Consts, ComStrs, ActnList, StdActns;


{
procedure LeftOrRightCaption(X, Y: Integer; AdvTabSheet: TAdvTabSheet);
var
  OldFont: TFont;
  NewFont: THandle;
  LogFont: TLogFont;
  ATextWidth: integer;
  Text: string;
  Position: Integer;

begin
  Text := AdvTabSheet.Caption;
  Position := Pos('&', Text);
  with Canvas do
  begin
    if Position > 0 then
    begin
      Delete(Text, Position, 1);
      OldFont := TFont.Create;
      OldFont.Assign(Font);
      LogFont.lfHeight := Font.Height;
      LogFont.lfWidth := 0;
      LogFont.lfEscapement := 0;
      case TabPosition of
      tpLeft: LogFont.lfEscapement := 900;
      tpright: LogFont.lfEscapement := -900;
      end;

      LogFont.lfOrientation := 0 ;
      LogFont.lfWeight := FW_NORMAL;
      LogFont.lfItalic := 0;
      LogFont.lfStrikeout := 0;
      LogFont.lfCharSet := ANSI_CHARSET;
      LogFont.lfOutPrecision := OUT_TT_ONLY_PRECIS;
      LogFont.lfClipPrecision := CLIP_DEFAULT_PRECIS;
      LogFont.lfQuality := PROOF_QUALITY;
      LogFont.lfPitchAndFamily := Variable_Pitch;
      StrPCopy(LogFont.lfFaceName, 'PoliceInclinee');

      ATextWidth := Y;
      if Position > 1 then
      begin
        LogFont.lfUnderline := 0;
        NewFont := CreateFontIndirect(LogFont);
        Font.Handle := NewFont;
        TextOut(X, ATextWidth, Copy(Text, 1, Position - 1));
        case TabPosition of
        tpLeft: ATextWidth := ATextWidth - TextWidth(Copy(Text, 1, Position - 1));
        tpright: ATextWidth := ATextWidth + TextWidth(Copy(Text, 1, Position - 1));
        end;

        Font.Assign(OldFont);
        DeleteObject(NewFont);
      end;

      LogFont.lfUnderline := 1;
      NewFont := CreateFontIndirect(LogFont);
      Font.Handle := NewFont;
      TextOut(X, ATextWidth, Copy(Text, Position, 1));

      case TabPosition of
      tpLeft: ATextWidth := ATextWidth - TextWidth(Copy(Text, Position, 1));
      tpright: ATextWidth := ATextWidth + TextWidth(Copy(Text, Position, 1));
      end;

      Font.Assign(OldFont);
      DeleteObject(NewFont);

      if Position < length(Text) then
      begin
        LogFont.lfUnderline := 0;
        NewFont := CreateFontIndirect(LogFont);
        Font.Handle := NewFont;
        TextOut(X, ATextWidth, Copy(Text, Position + 1, length(Text)));
        Font.Assign(OldFont);
        DeleteObject(NewFont);
      end;
    end
    else
      TextOut(X, Y, Caption);
  end;
end;
}


procedure DrawGradient(Canvas: TCanvas; FromColor, ToColor: TColor; Steps: Integer; R: TRect; Direction: Boolean);
var
  diffr, startr, endr: Integer;
  diffg, startg, endg: Integer;
  diffb, startb, endb: Integer;
  rstepr, rstepg, rstepb, rstepw: Real;
  i, stepw: Word;

begin
  if Steps = 0 then
    Steps := 1;

  FromColor := ColorToRGB(FromColor);
  ToColor := ColorToRGB(ToColor);

  startr := (FromColor and $0000FF);
  startg := (FromColor and $00FF00) shr 8;
  startb := (FromColor and $FF0000) shr 16;
  endr := (ToColor and $0000FF);
  endg := (ToColor and $00FF00) shr 8;
  endb := (ToColor and $FF0000) shr 16;

  diffr := endr - startr;
  diffg := endg - startg;
  diffb := endb - startb;

  rstepr := diffr / steps;
  rstepg := diffg / steps;
  rstepb := diffb / steps;

  if Direction then
    rstepw := (R.Right - R.Left) / Steps
  else
    rstepw := (R.Bottom - R.Top) / Steps;

  with Canvas do
  begin
    for i := 0 to steps - 1 do
    begin
      endr := startr + Round(rstepr * i);
      endg := startg + Round(rstepg * i);
      endb := startb + Round(rstepb * i);
      stepw := Round(i * rstepw);
      Pen.Color := endr + (endg shl 8) + (endb shl 16);
      Brush.Color := Pen.Color;
      if Direction then
        Rectangle(R.Left + stepw, R.Top, R.Left + stepw + Round(rstepw) + 1, R.Bottom)
      else
        Rectangle(R.Left, R.Top + stepw, R.Right, R.Top + stepw + Round(rstepw) + 1);
    end;
  end;
end;

procedure DrawTransparentBitmap(hdc: THandle; hBitmap: THandle; xStart, yStart: Integer;
  width, height, offsx, offsy: Integer; cTransparentColor: TColor);
// The function draws a bitmap with a transparent background.
var
  cColor: TColor;
  bmAndBack, bmAndObject, bmAndMem, bmSave: THandle;
  bmBackOld, bmObjectOld, bmMemOld, bmSaveOld: THandle;
  hdcMem, hdcBack, hdcObject, hdcTemp, hdcSave: THandle;
  ptSize: TPoint;
  {$IFDEF TMSDOTNET}
  ap: array of TPoint;  
  {$ENDIF}
begin
  hdcTemp := CreateCompatibleDC(hdc);
  SelectObject(hdcTemp, hBitmap);

  ptSize.x := width;
  ptSize.y := height;

  {$IFDEF TMSDOTNET}
  SetLength(ap,1);
  ap[0] := ptSize;
  dptolp(hdcTemp,ap,1);
  ptSize := ap[0];
  {$ENDIF}

  {$IFNDEF TMSDOTNET}
  DPtoLP(hdcTemp, ptSize, 1);
  {$ENDIF}

  hdcBack := CreateCompatibleDC(hdc);
  hdcObject := CreateCompatibleDC(hdc);
  hdcMem := CreateCompatibleDC(hdc);
  hdcSave := CreateCompatibleDC(hdc);

  bmAndBack := CreateBitmap(ptSize.x, ptSize.y, 1, 1, nil);
  bmAndObject := CreateBitmap(ptSize.x, ptSize.y, 1, 1, nil);

  bmAndMem := CreateCompatibleBitmap(hdc, ptSize.x, ptSize.y);
  bmSave := CreateCompatibleBitmap(hdc, ptSize.x, ptSize.y);

  bmBackOld := SelectObject(hdcBack, bmAndBack);
  bmObjectOld := SelectObject(hdcObject, bmAndObject);
  bmMemOld := SelectObject(hdcMem, bmAndMem);
  bmSaveOld := SelectObject(hdcSave, bmSave);

  SetMapMode(hdcTemp, GetMapMode(hdc));

  BitBlt(hdcSave, 0, 0, ptSize.x, ptSize.y, hdcTemp, offsx, offsy, SRCCOPY);

  cColor := SetBkColor(hdcTemp, cTransparentColor);

  BitBlt(hdcObject, 0, 0, ptSize.x, ptSize.y, hdcTemp, offsx, offsy, SRCCOPY);

  SetBkColor(hdcTemp, cColor);

  BitBlt(hdcBack, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, NOTSRCCOPY);

  // take copy of existing canvas
  BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdc, xStart, yStart, SRCCOPY);
  // and existing canvas with copy
  BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, SRCAND);

  BitBlt(hdcTemp, offsx, offsy, ptSize.x, ptSize.y, hdcBack, 0, 0, SRCAND);
  BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdcTemp, offsx, offsy, SRCPAINT);
  BitBlt(hdc, xStart, yStart, ptSize.x, ptSize.y, hdcMem, 0, 0, SRCCOPY);
  BitBlt(hdcTemp, 0, 0, ptSize.x, ptSize.y, hdcSave, 0, 0, SRCCOPY);


  DeleteObject(SelectObject(hdcBack, bmBackOld));
  DeleteObject(SelectObject(hdcObject, bmObjectOld));
  DeleteObject(SelectObject(hdcMem, bmMemOld));
  DeleteObject(SelectObject(hdcSave, bmSaveOld));

  DeleteDC(hdcMem);
  DeleteDC(hdcBack);

  DeleteDC(hdcObject);
  DeleteDC(hdcSave);
  DeleteDC(hdcTemp);
end;

procedure StretchTransparentBitmap(hdc: THandle; hBitmap: THandle; xStart, yStart: Integer;
  width, height, offsx, offsy, bmpw, bmph: Integer; cTransparentColor: TColor);
// The function draws a bitmap with a transparent background.
var
  cColor: TColor;
  bmAndBack, bmAndObject, bmAndMem, bmSave: THandle;
  bmBackOld, bmObjectOld, bmMemOld, bmSaveOld: THandle;
  hdcMem, hdcBack, hdcObject, hdcTemp, hdcSave: THandle;
  ptSize: TPoint;
  {$IFDEF TMSDOTNET}
  ap: array of TPoint;
  {$ENDIF}
begin
  hdcTemp := CreateCompatibleDC(hdc);
  SelectObject(hdcTemp, hBitmap);

  ptSize.x := width;
  ptSize.y := height;

  {$IFDEF TMSDOTNET}
  SetLength(ap,1);
  ap[0] := ptSize;
  dptolp(hdcTemp,ap,1);
  ptSize := ap[0];
  {$ENDIF}

  {$IFNDEF TMSDOTNET}
  DPtoLP(hdcTemp, ptSize, 1);
  {$ENDIF}

  hdcBack := CreateCompatibleDC(hdc);
  hdcObject := CreateCompatibleDC(hdc);
  hdcMem := CreateCompatibleDC(hdc);
  hdcSave := CreateCompatibleDC(hdc);

  bmAndBack := CreateBitmap(ptSize.x, ptSize.y, 1, 1, nil);
  bmAndObject := CreateBitmap(ptSize.x, ptSize.y, 1, 1, nil);

  bmAndMem := CreateCompatibleBitmap(hdc, ptSize.x, ptSize.y);
  bmSave := CreateCompatibleBitmap(hdc, ptSize.x, ptSize.y);

  bmBackOld := SelectObject(hdcBack, bmAndBack);
  bmObjectOld := SelectObject(hdcObject, bmAndObject);
  bmMemOld := SelectObject(hdcMem, bmAndMem);
  bmSaveOld := SelectObject(hdcSave, bmSave);

  SetMapMode(hdcTemp, GetMapMode(hdc));

  StretchBlt(hdcSave, 0, 0, ptSize.x, ptSize.y, hdcTemp, offsx, offsy, bmpw, bmph, SRCCOPY);

  cColor := SetBkColor(hdcTemp, cTransparentColor);

  StretchBlt(hdcObject, 0, 0, ptSize.x, ptSize.y, hdcTemp, offsx, offsy, bmpw, bmph, SRCCOPY);

  SetBkColor(hdcTemp, cColor);

  BitBlt(hdcBack, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, NOTSRCCOPY);

  // take copy of existing canvas
  BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdc, xStart, yStart, SRCCOPY);
  // and existing canvas with copy
  BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, SRCAND);
  StretchBlt(hdcTemp, offsx, offsy, bmpw, bmph, hdcback, 0, 0, ptsize.x, ptsize.y, SRCAND);
  StretchBlt(hdcMem, 0, 0, ptSize.X, ptSize.Y, hdctemp, offsx, offsy, bmpw, bmph, SRCPAINT);
  BitBlt(hdc, xStart, yStart, ptSize.x, ptSize.y, hdcMem, 0, 0, SRCCOPY);
  StretchBlt(hdcTemp, offsx, offsy, bmpw, bmph, hdcSave, 0, 0, ptsize.x, ptsize.y, SRCCOPY);

  DeleteObject(SelectObject(hdcBack, bmBackOld));
  DeleteObject(SelectObject(hdcObject, bmObjectOld));
  DeleteObject(SelectObject(hdcMem, bmMemOld));
  DeleteObject(SelectObject(hdcSave, bmSaveOld));

  DeleteDC(hdcMem);
  DeleteDC(hdcBack);

  DeleteDC(hdcObject);
  DeleteDC(hdcSave);
  DeleteDC(hdcTemp);
end;

procedure BitmapStretch(bmp: tbitmap; canvas: tcanvas; x, y, height: integer);
var
  mid: integer;
  fillh: integer;
  c: TColor;
begin
  mid := bmp.height div 2;
  fillh := height - bmp.height;
  c := bmp.Canvas.Pixels[0, bmp.Height - 1];
  DrawTransparentBitmap(canvas.handle, bmp.handle, x, y, bmp.Width, bmp.Height div 2, 0, 0, c);
  StretchTransparentBitmap(canvas.handle, bmp.Handle, x, y + mid, bmp.width, fillh, 0, mid - 1, bmp.Width, 2, c);
  DrawTransparentBitmap(canvas.handle, bmp.handle, x, y + mid + fillh, bmp.width, bmp.Height div 2, 0, mid, c);
end;

procedure BitmapStretchInWidth(bmp: tbitmap; canvas: tcanvas; x, y, width: integer);
var
  mid: integer;
  fillw: integer;
  c: TColor;
  ofs: Integer;
begin
  mid := bmp.Width div 2;
  fillw := width - bmp.Width;
  ofs := 0;
//  if odd(Width) then inc(ofs);

//  if P = 'T' then
//    c := bmp.Canvas.Pixels[bmp.Width - 1, 0]
//  else
  c := bmp.Canvas.Pixels[0, bmp.Height - 1];

  DrawTransparentBitmap(canvas.handle, bmp.handle, x, y, bmp.Width div 2, bmp.Height, 0, 0, c);
  StretchTransparentBitmap(canvas.handle, bmp.Handle, x + mid, y, fillw, bmp.height, mid - 1, 0, 2, bmp.height, c);
  DrawTransparentBitmap(canvas.handle, bmp.handle, x + mid + fillw, y, bmp.width div 2, bmp.Height, mid + ofs, 0, c);
end;

{ TTabMargin}

procedure TTabMargin.Assign(Source: TPersistent);
begin
  if Source is TTabMargin then
  begin
    FLeftMargin := TTabMargin(Source).LeftMargin;
    FTopMargin := TTabMargin(Source).TopMargin;
    FRightMargin := TTabMargin(Source).RightMargin;
    inherited Assign(Source);
  end;
end;

procedure TTabMargin.SetMargin(Index: integer; Value: TMarginSize);
begin
  case Index of
    0:
      if Value <> FLeftMargin then
      begin
        if Assigned(FOnMarginChange) then FOnMarginChange(Value, FLeftMargin, 0);
        FLeftMargin := Value;
      end;
    1:
      if Value <> FTopMargin then
      begin
        if Assigned(FOnMarginChange) then FOnMarginChange(Value, FTopMargin, 1);
        FTopMargin := Value;
      end;
    2:
      if Value <> FRightMargin then
      begin
        if Assigned(FOnMarginChange) then FOnMarginChange(Value, FRightMargin, 2);
        FRightMargin := Value;
      end;
  end;
end;

{ TAdvTabSheet }

constructor TAdvTabSheet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
  Visible := False;
  FTabVisible := True;
  FHighlighted := False;
  FTabEnable := true;

  FShowClose := False;
  FTextColor := clBlack;
  FTabColor := clNone;
  FTabColorTo := clNone;
  FTabGradientDirection := gdVertical;
  FHoverGradientDirection := gdVertical;
  FColorTo:= clNone;
  FImageIndexDummy := 0;
end;

destructor TAdvTabSheet.Destroy;
begin
  if FAdvPageControl <> nil then
  begin
    if FAdvPageControl.FUndockingPage = Self then FAdvPageControl.FUndockingPage := nil;
    FAdvPageControl.RemovePage(Self);
  end;
  inherited Destroy;
end;

procedure TAdvTabSheet.SelectFirstControl;
begin
  SelectFirst;
end;

function TAdvTabSheet.GetCaption: TCaption;
begin
  Result := inherited Caption;
end;

procedure TAdvTabSheet.SetCaption(Value: TCaption);
begin
  if not FShowClose then
    FTabCaption := Copy(Value, 1, length(Value) - 2)
  else
    FTabCaption := Value + ' ';

  inherited Caption := Value;
  
  if AdvPageControl <> nil then
    AdvPageControl.UpdateTab(self);
end;

procedure TAdvTabSheet.SetShowClose(value: Boolean);
begin
  FShowClose := value;
  SetCaption(Caption);
  if AdvPageControl <> nil then
  begin
    AdvPageControl.Invalidate;
  end;
end;

procedure TAdvTabSheet.SetTabGradientDirection(value: TGradientDirection);
begin
  if value <> FTabGradientDirection then
  begin
    FTabGradientDirection := value;
    if AdvPageControl <> nil then
    begin
      AdvPageControl.Invalidate;
    end;
  end;
end;

procedure TAdvTabSheet.SetHoverGradientDirection(value: TGradientDirection);
begin
  if value <> FHoverGradientDirection then
  begin
    FHoverGradientDirection := value;
  end;
end;

procedure TAdvTabSheet.SetTextColor(const Value: TColor);
begin
  FTextColor := Value;
  //Invalidate;
  if AdvPageControl <> nil then
  begin
    AdvPageControl.Invalidate;
  end;
end;

procedure TAdvTabSheet.SetTabColor(const Value: TColor);
begin
  FTabColor := Value;
  Invalidate;
end;

procedure TAdvTabSheet.SetTabColorTo(const Value: TColor);
begin
  FTabColorTo := Value;
  Invalidate;
end;

procedure TAdvTabSheet.DoHide;
begin
  if Assigned(FOnHide) then FOnHide(Self);
end;

procedure TAdvTabSheet.Paint;
var
  r: trect;

begin
  inherited;
  r := clientrect;
  inflaterect(r,-1,-1);
  //DrawGradient(Canvas,$FADAC4,$F5BFA0, 64, clientRect, false);
  if ColorTo <> clNone then
  begin
    DrawGradient(Canvas, Color, ColorTo, 64, clientRect, false);
  end;
end;

procedure TAdvTabSheet.DoShow;
begin
  if Assigned(FOnShow) then FOnShow(Self);
end;

function TAdvTabSheet.GetPageIndex: Integer;
begin
  if FAdvPageControl <> nil then
    Result := FAdvPageControl.FPages.IndexOf(Self) else
    Result := -1;
end;

function TAdvTabSheet.GetTabIndex: Integer;
var
  I: Integer;
begin
  Result := 0;
  if not FTabShowing then Dec(Result) else
    for I := 0 to PageIndex - 1 do
      if TAdvTabSheet(FAdvPageControl.FPages[I]).FTabShowing then
        Inc(Result);
end;

procedure TAdvTabSheet.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    Style := Style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TAdvTabSheet.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TAdvPageControl then
    AdvPageControl := TAdvPageControl(Reader.Parent);
end;

function TAdvTabSheet.GetImageIndex: TImageIndex;
begin
  Result := FImageIndex;
end;

procedure TAdvTabSheet.SetImageIndex(Value: TImageIndex);
begin
  if Value < 0 then
  begin
    FImageIndex := -1;
    FImageIndexDummy := 0;
  end
  else
  begin
    FImageIndex := Value;
    FImageIndexDummy := Value;
  end;
  SetCaption(Caption);
  //if FTabShowing then FAdvPageControl.UpdateTab(Self);
  //if FAdvPageControl <> nil then FAdvPageControl.Invalidate;
end;

procedure TAdvTabSheet.SetAdvPageControl(AAdvPageControl: TAdvPageControl);
begin
  if FAdvPageControl <> AAdvPageControl then
  begin
    if FAdvPageControl <> nil then FAdvPageControl.RemovePage(Self);
    Parent := AAdvPageControl;
    if AAdvPageControl <> nil then
    begin
      AAdvPageControl.InsertPage(Self);

      if FTextColor = clBlack then
        FTextColor := AAdvPageControl.DefaultTextColor;
      if FTabColor = clNone then
        FTabColor := AAdvPageControl.DefaultTabColor;
      if FTabColorTo = clNone then
        FTabColorTo := AAdvPageControl.DefaultTabColorTo;
    end;
  end;
end;

procedure TAdvTabSheet.SetPageIndex(Value: Integer);
var
  I, MaxPageIndex: Integer;
begin
  if FAdvPageControl <> nil then
  begin
    MaxPageIndex := FAdvPageControl.FPages.Count - 1;
{$IFDEF DELPHI5_LVL}
    if Value > MaxPageIndex then
{$IFNDEF TMSDOTNET}
      raise EListError.CreateResFmt(@SPageIndexError, [Value, MaxPageIndex]);
{$ENDIF}
{$IFDEF TMSDOTNET}
    raise EListError.CreateFmt(SPageIndexError, [Value, MaxPageIndex]);
{$ENDIF}
{$ENDIF}
    I := TabIndex;
    FAdvPageControl.FPages.Move(PageIndex, Value);
    if I >= 0 then FAdvPageControl.MoveTab(I, TabIndex);
  end;
end;

procedure TAdvTabSheet.SetTabShowing(Value: Boolean);
var
  Index: Integer;
begin
  if FTabShowing <> Value then
    if Value then
    begin
      FTabShowing := True;
      FAdvPageControl.InsertTab(Self);
    end else
    begin
      Index := TabIndex;
      FTabShowing := False;
      FAdvPageControl.DeleteTab(Self, Index);
    end;
end;

procedure TAdvTabSheet.SetTabVisible(Value: Boolean);
begin
  if FTabVisible <> Value then
  begin
    FTabVisible := Value;
    UpdateTabShowing;

    if AdvPageControl <> nil then
      AdvPageControl.UpdateTab(self);
  end;
end;

procedure TAdvTabSheet.UpdateTabShowing;
begin
  SetTabShowing((FAdvPageControl <> nil) and FTabVisible);
end;

procedure TAdvTabSheet.CMTextChanged(var Message: TMessage);
begin
  if FTabShowing then FAdvPageControl.UpdateTab(Self);
end;

procedure TAdvTabSheet.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Showing then
  begin
    try
      DoShow
    except
      Application.HandleException(Self);
    end;
  end else if not Showing then
  begin
    try
      DoHide;
    except
      Application.HandleException(Self);
    end;
  end;
end;

procedure TAdvTabSheet.CloseButtonClick(Sender: TObject);
begin
  if Assigned(FOnClose) then FOnClose(Self);
end;

function TAdvTabSheet.CanCloseClick(Sender: TObject): Boolean;
var
  CanClose: Boolean;
begin
  CanClose := True;
  if Assigned(FOnCanClose) then
    FOnCanClose(Self, CanClose);
  Result := CanClose;
end;


procedure TAdvTabSheet.SetHighlighted(Value: Boolean);
begin
  if not (csReading in ComponentState) then
    SendMessage(AdvPageControl.Handle, TCM_HIGHLIGHTITEM, TabIndex,
      MakeLong(Word(Value), 0));
  FHighlighted := Value;
end;


procedure TAdvTabSheet.SetTabEnable(const Value: boolean);
begin
  if FTabEnable <> Value then
  begin
    if AdvPageControl <> nil then
    begin
      if AdvPageControl.ActivePageIndex = TabIndex then
        raise exception.Create('Can not disable active tab.');

      FTabEnable := Value;
      AdvPageControl.Invalidate;
    end;
    FTabEnable := Value;
  end;
end;

procedure TAdvTabSheet.SetColorTo(const Value: TColor);
begin
  FColorTo := Value;
  Invalidate;
  if AdvPageControl <> nil then
  begin
    AdvPageControl.Invalidate;
  end;
end;

function TAdvTabSheet.GetColor: TColor;
begin
  Result:= inherited Color;
end;

procedure TAdvTabSheet.SetColor(const Value: TColor);
begin
  inherited Color:= Value;

  if AdvPageControl <> nil then
  begin
    AdvPageControl.Invalidate;
  end;
end;

procedure TAdvTabSheet.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if AdvPageControl <> nil then
  begin
    AdvPageControl.Invalidate;
  end;
end;

{ TAdvPageControl }

constructor TAdvPageControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := [csDoubleClicks, csOpaque];

  FPages := TList.Create;
  FClosedTabList := TStringList.Create;

  FDummyImages := TCustomImageList.Create(self);
  FDummyImages.Width := 1; //5;
  FDummyImages.Height := 1; //5;

  FDefaultTextColor := clBlack;
  FDefaultTabColor := clBtnFace;
  FDefaultTabColorTo := clnone;
  FActiveColor := clBtnFace;
  FActiveColorTo := clnone;

  FFreeOnClose := False;
  FTabSheet3D := False;
  FTabSplitLine := False;
  FTabBorderColor := clGray;
  FTabHoverColor := clnone;
  FTabHoverColorTo := clnone;
  FTabHoverBorder := clNone;
  FTabBackGround := TBitmap.Create;
  FTabBackGroundActive := TBitmap.Create;

  FHoverTab := -1;
  FShowFocus := false;

  FHoverClosedButton := false;

  FTabOverlap := 0;

  FTabSheetBorderColor := clGray;
  FTabBackGroundColor := clBtnFace;

  FTabBorder3D := False;
  inherited Images := FDummyImages;
  OwnerDraw := not FTabBorder3D;

  FRoundEdges := false;

  FTabStyle := tsClassic;
  FLowerActive := 2;

  FCloseGlyph := TBitmap.Create;
  FClosePosition := cpLeft;

  // make sure to use a Truetype font for vertically oriented tabs
  // Font.Name := 'Tahoma';

  FTabMargin := TTabMargin.Create;
  FTabMargin.LeftMargin := 0;
  FTabMargin.TopMargin := 0;
  FTabMargin.RightMargin := 0; //5;
  FTabMargin.OnMarginChange := TabMarginChange;

  FActiveFont := TFont.Create;
  FActiveFont.Name := 'Tahoma';
  FActiveFont.OnChange:= ActiveFontChangeEvent;
  inherited OnChange := TabChange;

  FFullRefresh := False;
end;

destructor TAdvPageControl.Destroy;
var
  I: Integer;
begin

  FCloseGlyph.Free;
  FTabBackGround.Free;
  FTabBackGroundActive.Free;

  for I := 0 to FPages.Count - 1 do
    TAdvTabSheet(FPages[I]).FAdvPageControl := nil;

  if FDummyImages <> nil then
    FDummyImages.Free;

  if FClosedTabList <> nil then
    FClosedTabList.Free;

  FPages.Free;
  FTabMargin.Free;
  FActiveFont.Free;

  inherited Destroy;
end;

procedure TAdvPageControl.UpdateTabHighlights;
var
  I: Integer;
begin
  for I := 0 to PageCount - 1 do
    Pages[I].SetHighlighted(Pages[I].FHighlighted);
end;

procedure TAdvPageControl.Loaded;
var
  i: integer;
begin
  inherited Loaded;
  UpdateTabHighlights;
  SetTabMargins;
  FPropertiesLoaded := true;

  for i := PageCount - 1 downto 0 do
  begin
    UpdateTab(Pages[I]);
  end;

  if FActivePage <> nil then
    UpdateTabForActiveFont(FActivePage);
end;


function TAdvPageControl.CanShowTab(TabIndex: Integer): Boolean;
begin
  Result := TAdvTabSheet(FPages[TabIndex]).Enabled;
end;

procedure TAdvPageControl.Change;
var
  Form: TCustomForm;
begin
  UpdateActivePage;
  if csDesigning in ComponentState then
  begin
    Form := GetParentForm(Self);
    if (Form <> nil) and (Form.Designer <> nil) then
      Form.Designer.Modified;
  end;
  inherited Change;
end;

function TAdvPageControl.CanChange: Boolean;
var
  pt: TPoint;
  AllowChange: Boolean;
  NewPage: Integer;
begin
  GetCursorPos(pt);
  pt := ScreenToClient(pt);

  NewPage := IndexOfTabAtEx(pt.X,pt.Y);

  if (NewPage = -1) then
  begin
    if GetKeyState(VK_SHIFT) and $8000 = $8000 then
      NewPage := ActivePageIndex - 1
    else
      NewPage := ActivePageIndex + 1;

    if NewPage = Pagecount then
      NewPage := 0;

    if NewPage = -1 then
      NewPage := PageCount - 1;
  end;

  AllowChange := true;

  if Assigned(OnCanChange) then
    OnCanChange(Self, ActivePageIndex, NewPage, AllowChange);

  if not AllowChange then
   begin
     if MultiLine then
       EndUpdate;

    Result := False
  end
  else
  begin
    if MultiLine then
      EndUpdate;
    Result := inherited CanChange;
    if Result and MultiLine then
      BeginUpdate;
  end;
end;


procedure TAdvPageControl.ChangeActivePage(Page: TAdvTabSheet);
var
  ParentForm: TCustomForm;
  OldActivePage: TAdvTabSheet;
begin
  if (FActivePage <> Page) and Assigned(Page) then
  begin
    if Assigned(Page) and not (csDesigning in ComponentState) and (not Page.TabEnable) then
      Exit;

    ParentForm := GetParentForm(Self);
    if (ParentForm <> nil) and (FActivePage <> nil) and
      FActivePage.ContainsControl(ParentForm.ActiveControl) then
    begin
      ParentForm.ActiveControl := FActivePage;
      if ParentForm.ActiveControl <> FActivePage then
      begin
        TabIndex := FActivePage.TabIndex;
        Exit;
      end;
    end;

    if Page <> nil then
    begin
      Page.BringToFront;
      Page.Visible := True;
      if (ParentForm <> nil) and (FActivePage <> nil) and
        (ParentForm.ActiveControl = FActivePage) then
        if Page.CanFocus then
          ParentForm.ActiveControl := Page else
          ParentForm.ActiveControl := Self;
    end;

    OldActivePage := FActivePage;

    if FActivePage <> nil then
      FActivePage.Visible := False;

    FActivePage := Page;

    UpdateTabForActiveFont(OldActivePage);
    UpdateTabForActiveFont(FActivePage);

    if (ParentForm <> nil) and (FActivePage <> nil) and
      (ParentForm.ActiveControl = FActivePage) then
      FActivePage.SelectFirstControl;
  end;
end;

procedure TAdvPageControl.DeleteTab(Page: TAdvTabSheet; Index: Integer);
var
  UpdateIndex: Boolean;
begin
  UpdateIndex := Page = ActivePage;
  Tabs.Delete(Index);
  if UpdateIndex then
  begin
    if Index >= Tabs.Count then
      Index := Tabs.Count - 1;
    TabIndex := Index;
  end;
  UpdateActivePage;
end;

procedure TAdvPageControl.DoAddDockClient(Client: TControl; const ARect: TRect);
begin
  if FNewDockSheet <> nil then Client.Parent := FNewDockSheet;
end;

procedure TAdvPageControl.DockOver(Source: TDragDockObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  Source.DockRect := R;
  DoDockOver(Source, X, Y, State, Accept);
end;

procedure TAdvPageControl.DoRemoveDockClient(Client: TControl);
begin
  if (FUndockingPage <> nil) and not (csDestroying in ComponentState) then
  begin
    SelectNextPage(True);
    FUndockingPage.Free;
    FUndockingPage := nil;
  end;
end;

function TAdvPageControl.FindNextPage(CurPage: TAdvTabSheet;
  GoForward, CheckTabVisible: Boolean): TAdvTabSheet;
var
  I, StartIndex: Integer;
begin
  if FPages.Count <> 0 then
  begin
    StartIndex := FPages.IndexOf(CurPage);
    if StartIndex = -1 then
      if GoForward then StartIndex := FPages.Count - 1 else StartIndex := 0;
    I := StartIndex;
    repeat
      if GoForward then
      begin
        Inc(I);
        if I = FPages.Count then I := 0;
      end else
      begin
        if I = 0 then I := FPages.Count;
        Dec(I);
      end;
{$IFNDEF TMSDOTNET}
      Result := FPages[I];
{$ENDIF}
{$IFDEF TMSDOTNET}
      Result := TAdvTabSheet(FPages[I]);
{$ENDIF}

      if not CheckTabVisible or Result.TabVisible then Exit;
    until I = StartIndex;
  end;
  Result := nil;
end;

procedure TAdvPageControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to FPages.Count - 1 do Proc(TComponent(FPages[I]));
end;

function TAdvPageControl.GetImageIndex(TabIndex: Integer): Integer;
var
  I,
    Visible,
    NotVisible: Integer;
begin
  if Assigned(OnGetImageIndex) then
    Result := inherited GetImageIndex(TabIndex) else
  begin
     { For a AdvPageControl, TabIndex refers to visible tabs only. The control
     doesn't store }
    Visible := 0;
    NotVisible := 0;
    for I := 0 to FPages.Count - 1 do
    begin
      if not GetPage(I).TabVisible then
        Inc(NotVisible)
      else
        Inc(Visible);
      if Visible = TabIndex + 1 then Break;
    end;
    //Result := GetPage(TabIndex + NotVisible).ImageIndex;
    Result := GetPage(TabIndex + NotVisible).ImageIndexDummy;
  end;
end;

function TAdvPageControl.GetPageFromDockClient(Client: TControl): TAdvTabSheet;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to PageCount - 1 do
  begin
    if (Client.Parent = Pages[I]) and (Client.HostDockSite = Self) then
    begin
      Result := Pages[I];
      Exit;
    end;
  end;
end;

function TAdvPageControl.GetPage(Index: Integer): TAdvTabSheet;
begin
{$IFNDEF TMSDOTNET}
  Result := FPages[Index];
{$ENDIF}
{$IFDEF TMSDOTNET}
  Result := TAdvTabSheet(FPages[Index]);
{$ENDIF}

end;

function TAdvPageControl.GetPageCount: Integer;
begin
  Result := FPages.Count;
end;

procedure TAdvPageControl.GetSiteInfo(Client: TControl; var InfluenceRect: TRect;
  MousePos: TPoint; var CanDock: Boolean);
begin
  CanDock := GetPageFromDockClient(Client) = nil;
  inherited GetSiteInfo(Client, InfluenceRect, MousePos, CanDock);
end;

procedure TAdvPageControl.InsertPage(Page: TAdvTabSheet);
begin
  FPages.Add(Page);
  Page.FAdvPageControl := Self;
  Page.UpdateTabShowing;
end;

procedure TAdvPageControl.InsertTab(Page: TAdvTabSheet);
begin
  Tabs.InsertObject(Page.TabIndex, Page.TabCaption {Caption}, Page);
  UpdateActivePage;
end;

procedure TAdvPageControl.MoveTab(CurIndex, NewIndex: Integer);
begin
  Tabs.Move(CurIndex, NewIndex);
end;

procedure TAdvPageControl.RemovePage(Page: TAdvTabSheet);
var
  NextSheet: TAdvTabSheet;
begin
  NextSheet := FindNextPage(Page, True, not (csDesigning in ComponentState));
  if NextSheet = Page then NextSheet := nil;
  Page.SetTabShowing(False);
  Page.FAdvPageControl := nil;
  FPages.Remove(Page);
  if ActivePage = Page then
    SetActivePage(NextSheet);
end;

procedure TAdvPageControl.SelectNextPage(GoForward: Boolean);
var
  Page: TAdvTabSheet;
begin
  Page := FindNextPage(ActivePage, GoForward, True);
  if (Page <> nil) and (Page <> ActivePage) and CanChange then
  begin
    TabIndex := Page.TabIndex;
    Change;
  end;
end;

procedure TAdvPageControl.SetActivePage(Page: TAdvTabSheet);
begin
  if (Page <> nil) and (Page.AdvPageControl <> Self) then Exit;
  ChangeActivePage(Page);
  if Page = nil then
  begin
    TabIndex := -1;
    FActivePage:= nil;
  end
  else if Page = FActivePage then
    TabIndex := Page.TabIndex;
end;

procedure TAdvPageControl.SetChildOrder(Child: TComponent; Order: Integer);
begin
  TAdvTabSheet(Child).PageIndex := Order;
end;

procedure TAdvPageControl.ShowControl(AControl: TControl);
begin
  if (AControl is TAdvTabSheet) and (TAdvTabSheet(AControl).AdvPageControl = Self) then
    SetActivePage(TAdvTabSheet(AControl));
  inherited ShowControl(AControl);
end;

procedure TAdvPageControl.DrawHoverCloseButton(Rect: TRect);
var
  P: TPoint;
begin
  if not FCloseGlyph.Empty then
  begin
    case TabPosition of
      tpLeft:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin + FLowerActive {2} {Active};
          Rect.Bottom := Rect.Bottom - FTabMargin.TopMargin;
          if not FTabBackGroundActive.Empty then
            Rect.Bottom := Rect.Bottom + TabOverlap;
        end
        else
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin + FLowerActive {2} {Active};
          Rect.Bottom := Rect.Top + FTabMargin.RightMargin + CloseButtonHeight;
          if not FTabBackGroundActive.Empty then
            Rect.Bottom := Rect.Bottom + TabOverlap;
        end;
        //Rectangle(Rect.Left + 2, Rect.Bottom - 2, Rect.Left + CloseButtonWidth, Rect.Bottom - CloseButtonHeight);
        P.X:= Rect.Left + 2;
        P.Y:= Rect.Bottom - CloseButtonHeight;
      end;
      tpRight:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin;
        end
        else
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Bottom - FTabMargin.RightMargin - CloseButtonHeight;
        end;
        //Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Left + CloseButtonWidth, Rect.Top + CloseButtonHeight);
        P.X:= Rect.Left + 2;
        P.Y:= Rect.Top + 2;
      end;
      tpTop:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + {2} FLowerActive;
        end
        else
        begin
          Rect.Left := Rect.Right - FTabMargin.RightMargin - CloseButtonWidth;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + {2} FLowerActive;
        end;
        P.X:= Rect.Left + 2;
        P.Y:= Rect.Top + 2;
      end;
      tpBottom:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + {2} FLowerActive;
        end
        else
        begin
          Rect.Left := Rect.Right - FTabMargin.RightMargin - CloseButtonWidth;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + FLowerActive;
        end;
        P.X:= Rect.Left + 2;
        P.Y:= Rect.Top + 2;
      end;
    end;
    DrawCloseGlyph(P);
  end
  else
  begin
    if TabPosition = tpLeft then
    begin
      if (ClosePosition = cpLeft) then
      begin
        Rect.Left := Rect.Left + FTabMargin.LeftMargin + FLowerActive {2} {Active};
        Rect.Bottom := Rect.Bottom - FTabMargin.TopMargin;
        if not FTabBackGroundActive.Empty then
          Rect.Bottom := Rect.Bottom + TabOverlap;
      end
      else
      begin
        Rect.Left := Rect.Left + FTabMargin.LeftMargin + FLowerActive {2} {Active};
        Rect.Bottom := Rect.Top + FTabMargin.RightMargin + CloseButtonHeight;
        if not FTabBackGroundActive.Empty then
          Rect.Bottom := Rect.Bottom + TabOverlap;
      end;

      with Canvas do
      begin
        Brush.Color := clWhite;
        Pen.Color := clBlack; //clGray;
        Rectangle(Rect.Left + 2, Rect.Bottom - 2, Rect.Left + CloseButtonWidth, Rect.Bottom - CloseButtonHeight);
        Pen.Color := clGray; //clBlack;
                      {/}
        MoveTo(Rect.Left + 2 + 3, Rect.Bottom - 2 - 3 - 4 - 1);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Bottom - 2 - 2 - 1); //-1
        MoveTo(Rect.Left + 2 + 4, Rect.Bottom - 2 - 3 - 4 - 1);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Bottom - 2 - 2 - 1);
                      {\}
        MoveTo(Rect.Left + 2 + 3, Rect.Bottom - 2 - 3 - 1);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Bottom - 2 - 3 - 5 - 1);
        MoveTo(Rect.Left + 2 + 4, Rect.Bottom - 2 - 3 - 1);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Bottom - 2 - 3 - 5 - 1);
      end;
    end
    else
    begin
      if TabPosition = tpRight then
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin;
        end
        else
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Bottom - FTabMargin.RightMargin - CloseButtonHeight;
        end;
      end
      else if TabPosition in [tpTop, tpBottom] then
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + {2} FLowerActive;
        end
        else
        begin
          Rect.Left := Rect.Right - FTabMargin.RightMargin - CloseButtonWidth;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + {2} FLowerActive;
        end;
      end;

      with canvas do
      begin
        Brush.Color := clWhite;
        Pen.Color := clBlack; //clGray;
        Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Left + CloseButtonWidth, Rect.Top + CloseButtonHeight);
        Pen.Color := clGray; //clBlack;
                      {/}
        MoveTo(Rect.Left + 2 + 3, Rect.Top + 2 + 3 + 4);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Top + 2 + 2); //-1
        MoveTo(Rect.Left + 2 + 4, Rect.Top + 2 + 3 + 4);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Top + 2 + 2);
                      {\}
        MoveTo(Rect.Left + 2 + 3, Rect.Top + 2 + 3);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Top + 2 + 3 + 5);
        MoveTo(Rect.Left + 2 + 4, Rect.Top + 2 + 3);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Top + 2 + 3 + 5);
      end;
    end;
  end;
end;

procedure TAdvPageControl.DrawDownCloseButton(Rect: TRect);
var
  P: TPoint;
begin
  if not FCloseGlyph.Empty then
  begin
    case TabPosition of
      tpLeft:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin + {2} FLowerActive {active};
          Rect.Bottom := Rect.Bottom - FTabMargin.TopMargin;
          if not FTabBackGroundActive.Empty then
            Rect.Bottom := Rect.Bottom + TabOverlap;
        end
        else
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin + {2} FLowerActive {active};
          Rect.Bottom := Rect.Top + FTabMargin.RightMargin + CloseButtonHeight;
          if not FTabBackGroundActive.Empty then
            Rect.Bottom := Rect.Bottom + TabOverlap;
        end;

        P.X:= Rect.Left + 2;
        P.y:= Rect.Bottom - CloseButtonHeight;
      end;
      tpRight:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin - FLowerActive + 2;
          Rect.Top := Rect.Top + FTabMargin.TopMargin;
        end
        else
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin - FLowerActive + 2;
          Rect.Top := Rect.Bottom - FTabMargin.RightMargin - CloseButtonHeight;
        end;
        P.X:= Rect.Left + 2;
        P.y:= Rect.Top + 2;
      end;
      tpTop, tpBottom:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + FLowerActive;
        end
        else
        begin
          Rect.Left := Rect.Right - FTabMargin.RightMargin - CloseButtonWidth;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + FLowerActive;
        end;
        P.X:= Rect.Left + 2;
        P.y:= Rect.Top + 2;
      end;
      {tpBottom:
      begin
        Rect.Left := Rect.Left + FTabMargin.LeftMargin;
        Rect.Top := Rect.Top + FTabMargin.TopMargin +  FLowerActive;
        P.X:= Rect.Left + 2;
        P.y:= Rect.Top + 2;
      end;}
    end;
    DrawCloseGlyph(P);
  end
  else
  begin
    if TabPosition = tpLeft then
    begin
      if (ClosePosition = cpLeft) then
      begin
        Rect.Left := Rect.Left + FTabMargin.LeftMargin + {2} FLowerActive {active};
        Rect.Bottom := Rect.Bottom - FTabMargin.TopMargin;
      end
      else
      begin
        Rect.Left := Rect.Left + FTabMargin.LeftMargin + {2} FLowerActive {active};
        Rect.Bottom := Rect.Top + FTabMargin.RightMargin + CloseButtonHeight;
      end;
      if not FTabBackGroundActive.Empty then
        Rect.Bottom := Rect.Bottom + TabOverlap;

      with Canvas do
      begin
        Brush.Color := clSilver; //clWhite;
        Pen.Color := clBlack; //clGray;
        Rectangle(Rect.Left + 2, Rect.Bottom - 2, Rect.Left + CloseButtonWidth, Rect.Bottom - CloseButtonHeight);
        Pen.Color := clBlack;
                      {/}
        MoveTo(Rect.Left + 2 + 3, Rect.Bottom - 2 - 3 - 4 - 1);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Bottom - 2 - 2 - 1); //-1
        MoveTo(Rect.Left + 2 + 4, Rect.Bottom - 2 - 3 - 4 - 1);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Bottom - 2 - 2 - 1);
                      {\}
        MoveTo(Rect.Left + 2 + 3, Rect.Bottom - 2 - 3 - 1);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Bottom - 2 - 3 - 5 - 1);
        MoveTo(Rect.Left + 2 + 4, Rect.Bottom - 2 - 3 - 1);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Bottom - 2 - 3 - 5 - 1);
      end;
    end
    else
    begin
      if TabPosition = tpRight then
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin - FLowerActive + 2;
          Rect.Top := Rect.Top + FTabMargin.TopMargin;
        end
        else
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin - FLowerActive + 2;
          Rect.Top := Rect.Bottom - FTabMargin.RightMargin - CloseButtonHeight;
        end;
      end
      else if TabPosition in [tpTop, tpBottom] then
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + {2} FLowerActive;
        end
        else
        begin
          Rect.Left := Rect.Right - FTabMargin.RightMargin - CloseButtonWidth;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + {2} FLowerActive;
        end;
      end;

      with canvas do
      begin
        Brush.Color := clSilver; //clWhite;
        Pen.Color := clBlack; //clGray;
        Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Left + CloseButtonWidth, Rect.Top + CloseButtonHeight);
        Pen.Color := clBlack;
                      {/}
        MoveTo(Rect.Left + 2 + 3, Rect.Top + 2 + 3 + 4);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Top + 2 + 2); //-1
        MoveTo(Rect.Left + 2 + 4, Rect.Top + 2 + 3 + 4);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Top + 2 + 2);
                      {\}
        MoveTo(Rect.Left + 2 + 3, Rect.Top + 2 + 3);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Top + 2 + 3 + 5);
        MoveTo(Rect.Left + 2 + 4, Rect.Top + 2 + 3);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Top + 2 + 3 + 5);
      end;
    end;
  end;
end;


procedure TAdvPageControl.DrawCloseGlyph(P: TPoint);
var
  GlRgn: HRGN;
begin
  if not CloseGlyph.Empty then
  begin
    GlRgn := CreateRectRgn(P.X, P.Y, P.X + CloseButtonWidth-2, P.Y + CloseButtonHeight - 2);
    SelectClipRgn(Canvas.Handle,GlRgn);
    CloseGlyph.Transparent:= true;
    CloseGlyph.TransparentMode:= tmAuto;
    Canvas.Draw(P.X, P.Y, CloseGlyph);
    
    SelectClipRgn(Canvas.Handle,0);
    DeleteObject(GlRgn);
  end;
end;


procedure TAdvPageControl.DrawCloseButton(Rect: TRect; Active: Boolean);
var
  a: integer;
  P: TPoint;
begin
  if Active then a := {2} FLowerActive
  else a := 0;

  if not FCloseGlyph.Empty then
  begin
    case TabPosition of
      tpLeft:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin + a;
          Rect.Bottom := Rect.Bottom - FTabMargin.TopMargin;
          if not FTabBackGroundActive.Empty then
            Rect.Bottom := Rect.Bottom + TabOverlap;
        end
        else
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin + a;
          Rect.Bottom := Rect.Top + FTabMargin.RightMargin + CloseButtonHeight;
          if not FTabBackGroundActive.Empty then
            Rect.Bottom := Rect.Bottom + TabOverlap;
        end;

        //Rectangle(Rect.Left + 2, Rect.Bottom - 2, Rect.Left + CloseButtonWidth, Rect.Bottom - CloseButtonHeight);
        P.X:= Rect.Left + 2;
        P.Y:= Rect.Bottom - CloseButtonHeight;
      end;
      tpRight:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin + 2 - a;
          Rect.Top := Rect.Top + FTabMargin.TopMargin;
        end
        else
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin + 2 - a;
          Rect.Top := Rect.Bottom - FTabMargin.RightMargin - CloseButtonHeight;
        end;
        //Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Left + CloseButtonWidth, Rect.Top + CloseButtonHeight);
        P.X:= Rect.Left + 2;
        P.Y:= Rect.Top + 2;
      end;
      tpTop:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + a;
        end
        else
        begin
          Rect.Left := Rect.Right - FTabMargin.RightMargin - CloseButtonWidth;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + a;
        end;
        //Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Left + CloseButtonWidth, Rect.Top + CloseButtonHeight);
        P.X:= Rect.Left + 2;
        P.Y:= Rect.Top + 2;
      end;
      tpBottom:
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + a;
        end
        else
        begin
          Rect.Left := Rect.Right - FTabMargin.RightMargin - CloseButtonWidth;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + a;
        end;
        //Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Left + CloseButtonWidth, Rect.Top + CloseButtonHeight);
        P.X:= Rect.Left + 2;
        P.Y:= Rect.Top + 2;
      end;
    end;
    DrawCloseGlyph(P);
  end
  else
  begin
    if TabPosition = tpLeft then
    begin
      if (ClosePosition = cpLeft) then
      begin
        Rect.Left := Rect.Left + FTabMargin.LeftMargin + a;
        Rect.Bottom := Rect.Bottom - FTabMargin.TopMargin;
        if not FTabBackGroundActive.Empty then
          Rect.Bottom := Rect.Bottom + TabOverlap;
      end
      else
      begin
        Rect.Left := Rect.Left + FTabMargin.LeftMargin + a;
        Rect.Bottom := Rect.Top + FTabMargin.RightMargin + CloseButtonHeight;
        if not FTabBackGroundActive.Empty then
          Rect.Bottom := Rect.Bottom + TabOverlap;
      end;

      with canvas do
      begin
        Brush.Color := clWhite;
        Pen.Color := clGray;
        Rectangle(Rect.Left + 2, Rect.Bottom - 2, Rect.Left + CloseButtonWidth, Rect.Bottom - CloseButtonHeight);
        Pen.Color := clBlack;
                      {/}
        MoveTo(Rect.Left + 2 + 3, Rect.Bottom - 2 - 3 - 4 - 1);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Bottom - 2 - 2 - 1); //-1
        MoveTo(Rect.Left + 2 + 4, Rect.Bottom - 2 - 3 - 4 - 1);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Bottom - 2 - 2 - 1);
                      {\}
        MoveTo(Rect.Left + 2 + 3, Rect.Bottom - 2 - 3 - 1);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Bottom - 2 - 3 - 5 - 1);
        MoveTo(Rect.Left + 2 + 4, Rect.Bottom - 2 - 3 - 1);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Bottom - 2 - 3 - 5 - 1);
      end;
    end
    else
    begin
      if TabPosition = tpRight then
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin + 2 - a;
          Rect.Top := Rect.Top + FTabMargin.TopMargin;
        end
        else
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin + 2 - a;
          Rect.Top := Rect.Bottom - FTabMargin.RightMargin - CloseButtonHeight;
        end;
      end
      else if TabPosition = tpTop then
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + a;
        end
        else
        begin
          Rect.Left := Rect.Right - FTabMargin.RightMargin - CloseButtonWidth;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + a;
        end;
      end
      else // Bottom
      begin
        if (ClosePosition = cpLeft) then
        begin
          Rect.Left := Rect.Left + FTabMargin.LeftMargin;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + a;
        end
        else
        begin
          Rect.Left := Rect.Right - FTabMargin.RightMargin - CloseButtonWidth;
          Rect.Top := Rect.Top + FTabMargin.TopMargin + a;
        end;
      end;

      with canvas do
      begin
        Brush.Color := clWhite;
        Pen.Color := clGray;
        Rectangle(Rect.Left + 2, Rect.Top + 2, Rect.Left + CloseButtonWidth, Rect.Top + CloseButtonHeight);
        Pen.Color := clBlack;
                      {/}
        MoveTo(Rect.Left + 2 + 3, Rect.Top + 2 + 3 + 4);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Top + 2 + 2); //-1
        MoveTo(Rect.Left + 2 + 4, Rect.Top + 2 + 3 + 4);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Top + 2 + 2);
                      {\}
        MoveTo(Rect.Left + 2 + 3, Rect.Top + 2 + 3);
        LineTo(Rect.Left + 2 + 3 + 6, Rect.Top + 2 + 3 + 5);
        MoveTo(Rect.Left + 2 + 4, Rect.Top + 2 + 3);
        LineTo(Rect.Left + 2 + 3 + 5, Rect.Top + 2 + 3 + 5);
      end;
    end;
  end;
end;

function TAdvPageControl.IsOnButton(TabIndex, X, Y: integer): Boolean;
var
  r: TRect;
begin
  Result := false;
  r := TabRectEx(TabIndex);
  if TabPosition = tpLeft then
  begin
    if (ClosePosition = cpLeft) then
    begin
      r.Left := r.Left + FTabMargin.LeftMargin {Active};
      r.Bottom := r.Bottom - FTabMargin.TopMargin;
    end
    else
    begin
      r.Left := r.Left + FTabMargin.LeftMargin {Active};
      r.Bottom := r.Top + FTabMargin.RightMargin + CloseButtonHeight;
    end;
    if not FTabBackGroundActive.Empty then
    begin
      r.Left := r.Left + 2;
      r.Bottom := r.Bottom + TabOverlap;
    end;

    r := Rect(r.Left + 2, r.Bottom - CloseButtonHeight, r.Left + CloseButtonWidth, r.Bottom - 2);
    if PtInRect(r, Point(X, Y)) then
    begin
      Result := true;
    end;
  end
  else
  begin
    if (ClosePosition = cpLeft) then
    begin
      r.Left := r.Left + FTabMargin.LeftMargin;
      r.Top := r.Top + FTabMargin.TopMargin;
      r := Rect(r.Left + 2, r.Top + 2, r.Left + CloseButtonWidth, r.Top + CloseButtonHeight);
    end
    else
    begin
      case TabPosition of
        tpTop, tpBottom:
        begin
          r.Left := r.Right - FTabMargin.RightMargin - CloseButtonWidth;
          r.Top := r.Top + FTabMargin.TopMargin;
          r := Rect(r.Left, r.Top, r.Left + CloseButtonWidth, r.Top + CloseButtonHeight);
        end;
        tpRight:
        begin
          r.Left := r.Left + FTabMargin.LeftMargin;
          r.Top := r.Bottom - FTabMargin.RightMargin - CloseButtonHeight;
          r := Rect(r.Left, r.Top, r.Left + CloseButtonWidth, r.Top + CloseButtonHeight);
        end;
      end;
    end;
    if PtInRect(r, Point(X, Y)) then
    begin
      Result := true;
    end;
  end;
end;

procedure TAdvPageControl.UpdateTabForActiveFont(Page: TAdvTabSheet);
var
  aFont: TFont;
  tw, Atw: integer;
  s: String;
begin
  if not TabBorder3D and (Page <> nil) then
  begin
    if (FActivePage = Page) and ((fsBold in ActiveFont.Style) or (fsItalic in ActiveFont.Style)) then
    begin
      aFont:= TFont.Create;
      aFont.Assign(Canvas.Font);
      Canvas.Font.Assign(FActiveFont);
      Atw:= Canvas.TextWidth(Page.TabCaption);

      Canvas.Font.Assign(Font);
      tw:= Canvas.TextWidth(Page.TabCaption);

      Atw:= Atw - tw;
      s:= '';
      while Canvas.TextWidth(s) < Atw  do
        S:= S + ' ';

      if (Page.TabIndex >= 0) and (Page.TabIndex < Tabs.Count) then
        Tabs[Page.TabIndex] := Page.TabCaption + S;

      Canvas.Font.Assign(aFont);
      aFont.Free;
    end
    else
    begin
      if (Page.TabIndex >= 0) and (Page.TabIndex < Tabs.Count) then
        Tabs[Page.TabIndex] := Page.TabCaption;
    end;
  end;
end;

procedure TAdvPageControl.UpdateTab(Page: TAdvTabSheet);
begin
  if Page.TabIndex >= 0 then
  begin
    if TabBorder3D then
      Tabs[Page.TabIndex] := Page.Caption
    else
    begin
      if (FActivePage = Page) and ((fsBold in ActiveFont.Style) or (fsItalic in ActiveFont.Style)) then
        UpdateTabForActiveFont(Page)
      else
        Tabs[Page.TabIndex] := Page.TabCaption;
    end;  
  end;   
end;

procedure TAdvPageControl.UpdateActivePage;
begin
  if TabIndex >= 0 then
    SetActivePage(TAdvTabSheet(Tabs.Objects[TabIndex]))
  else
    SetActivePage(nil);
end;

procedure TAdvPageControl.WndProc(var Message: TMessage);
begin
  inherited;

  if (Message.Msg = WM_PAINT) and (not FTabBorder3D) then
  begin
    //if not DoubleBuffered then
      //DoubleBuffered := true;

    Message.Result := 0;
    DrawAllTabs(Canvas);
  end;
end;

procedure TAdvPageControl.TabChange(Sender: TObject);
begin
  if Assigned(FOnChange) then FOnChange(Sender);
  Invalidate;
end;

procedure TAdvPageControl.TabMarginChange(NewValue, OldValue: TMarginSize; Index: integer);
var
  ImgW, ImgH: integer;
begin
  if FPropertiesLoaded or (csDesigning in ComponentState) then
  begin
    if FImages <> nil then
    begin
      ImgW := FImages.Width;
      ImgH := FImages.Height;
    end
    else
    begin
      ImgW := 0;
      ImgH := 0;
    end;

    case Index of
      0: // Left
        begin
          if TabPosition in [tpTop, tpBottom] then
          begin
            FDummyImages.Width := ImgW + TabMargin.RightMargin + NewValue;
          end;
        end;
      1: // Top
        begin
          if TabPosition in [tpLeft, tpRight] then
          begin
            FDummyImages.Height := ImgH + TabMargin.RightMargin + NewValue;
          end;
        end;
      2: // Right
        begin
          if FPropertiesLoaded or (csDesigning in ComponentState) then
            if TabPosition in [tpLeft, tpRight] then
            begin
              FDummyImages.Height := FDummyImages.Height - OldValue;
              FDummyImages.Height := FDummyImages.Height + NewValue;
            end
            else // tpTop, tpBottom
            begin
              FDummyImages.Width := FDummyImages.Width - OldValue;
              FDummyImages.Width := FDummyImages.Width + NewValue;
            end;
        end;
    end;
  end;
  Invalidate;
end;

procedure TAdvPageControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  tabIndex: Integer;
  aAdvTabSheet: TAdvTabSheet;
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  if FTabBorder3D then
    Exit;

  if (Button = mbLeft) then
  begin
    tabIndex := GetActivePageIndex;
    if (TAdvTabSheet(Pages[TabIndex]).ShowClose) and IsOnButton(tabIndex, X, Y) then
    begin
      aAdvTabSheet := FindNextPage(ActivePage, true, true);

      if TAdvTabSheet(Pages[TabIndex]).CanCloseClick(TAdvTabSheet(Pages[TabIndex])) then
      begin
        TAdvTabSheet(Pages[TabIndex]).CloseButtonClick(TAdvTabSheet(Pages[TabIndex]));
        ActivePage := aAdvTabSheet;
        TabChange(self);
        //FRealActivePageIndex:= ActivePage.PageIndex;

        if FFreeOnClose then
          TAdvTabSheet(Pages[TabIndex]).Free
        else
        begin
          FClosedTabList.AddObject(TAdvTabSheet(Pages[TabIndex]).Name, TAdvTabSheet(Pages[TabIndex]));
          TAdvTabSheet(Pages[TabIndex]).AdvPageControl := nil;
        end;
        Invalidate;
      end;
    end;
  end;
end;

procedure TAdvPageControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  TabIndex: integer;
  aAdvTabSheet: TAdvTabSheet;
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  if FTabBorder3D then
    Exit;

  TabIndex := ActivePageIndex;
  if TAdvTabSheet(Pages[TabIndex]).ShowClose then    
    if IsOnButton(TabIndex, X, Y) then
    begin
      if DockSite then  // As Mouse Up event does not triger when DockSite
      begin
        aAdvTabSheet := FindNextPage(ActivePage, true, true);

        if TAdvTabSheet(Pages[TabIndex]).CanCloseClick(TAdvTabSheet(Pages[TabIndex])) then
        begin
          TAdvTabSheet(Pages[TabIndex]).CloseButtonClick(TAdvTabSheet(Pages[TabIndex]));
          ActivePage := aAdvTabSheet;
          TabChange(self);
          //FRealActivePageIndex:= ActivePage.PageIndex;

          if FFreeOnClose then
            TAdvTabSheet(Pages[TabIndex]).Free
          else
          begin
            FClosedTabList.AddObject(TAdvTabSheet(Pages[TabIndex]).Name, TAdvTabSheet(Pages[TabIndex]));
            TAdvTabSheet(Pages[TabIndex]).AdvPageControl := nil;
          end;
          Invalidate;
        end;
      end
      else // Other wise show down Close Button
        DrawDownCloseButton(TabRectEx(TabIndex));
    end;
end;

procedure TAdvPageControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  tabIndex: Integer;
  R: TRect;
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  if (TabHoverColor = clNone) then
    Exit;

  if FTabBorder3D then
    Exit;

  if FTabBackGround.Empty then
  begin
    tabIndex := IndexOfTabAtEx(X, Y);
    if (FHoverTab <> tabIndex) and ((FTabHoverColor <> clNone) or (FTabHoverColorTo <> clNone)) then
    begin
      r := TabRectEx(FHoverTab);
      FHoverTab := tabindex;
{$IFNDEF TMSDOTNET}
      InvalidateRect(self.Handle, @r, true);
{$ENDIF}
{$IFDEF TMSDOTNET}
      InvalidateRect(self.Handle, r, true);
{$ENDIF}
      r := TabRectEx(FHoverTab);
      FHoverTab := tabindex;
{$IFNDEF TMSDOTNET}
      InvalidateRect(self.Handle, @r, true);
{$ENDIF}
{$IFDEF TMSDOTNET}
      InvalidateRect(self.Handle, r, true);
{$ENDIF}
    end;
  end;

  TabIndex := ActivePageIndex;
  if TAdvTabSheet(Pages[TabIndex]).ShowClose then
  begin
    if not FHoverClosedButton then
    begin
      if IsOnButton(TabIndex, X, Y) then
      begin
        DrawHoverCloseButton(TabRectEx(TabIndex));
        FHoverClosedButton := True;
      end;
    end
    else
    begin
      if not IsOnButton(TabIndex, X, Y) then
      begin
        DrawCloseButton(TabRectEx(TabIndex), True);
        FHoverClosedButton := false;
      end;
    end;
  end
end;

procedure TAdvPageControl.CMMouseLeave(var Message: TMessage);
var
  r: TRect;
begin

  if FTabBackGround.Empty then
  begin
    if FHoverTab <> -1 then
    begin
      r := TabRectEx(FHoverTab);
{$IFNDEF TMSDOTNET}
      InvalidateRect(Handle, @r, true);
{$ENDIF}
{$IFDEF TMSDOTNET}
      InvalidateRect(Handle, r, true);
{$ENDIF}
    end;
  end;
  FHoverTab := -1;
end;


{$IFNDEF DELPHI5_LVL}
function TabCtrl_GetItemRect(hwnd: HWND; i: Integer; var prc: TRect): BOOL;
begin
  Result := BOOL(SendMessage(hwnd, TCM_GETITEMRECT, i, LPARAM(@prc)));
end;

function TabCtrl_HitTest(hwndTC: HWND; pinfo: PTCHitTestInfo): Integer;
begin
  Result := SendMessage(hwndTC, TCM_HITTEST, 0, LPARAM(pinfo));
end;

function TabCtrl_IndexOfTabAt(Handle: HWND;R: TRect; X, Y: Integer): Integer;
var
  HitTest: TTCHitTestInfo;

begin
  Result := -1;

  if PtInRect(R, Point(X, Y)) then
    with HitTest do
    begin
      pt.X := X;
      pt.Y := Y;
      Result := TabCtrl_HitTest(Handle, @HitTest);
    end;
end;

{$ENDIF}


function TAdvPageControl.IndexOfTabAtEx(X, Y: Integer): Integer;
var
  i, j: Integer;
begin
  {$IFDEF DELPHI5_LVL}
  i := IndexOfTabAt(X, Y);
  {$ELSE}
  i := TabCtrl_IndexOfTabAt(self.Handle,ClientRect, X, Y);
  {$ENDIF}

  for j := 0 to PageCount - 1 do
  begin
    if (j <= i) and not TAdvTabSheet(FPages[j]).TabVisible then
      inc(i);
  end;
  Result := i;
end;

function TAdvPageControl.TabRectEx(i: Integer): TRect;
var
  j, k: Integer;
begin
  k := i;
  for j := 0 to PageCount - 1 do
  begin
    if (j < i) and not TAdvTabSheet(FPages[j]).TabVisible then
      dec(k);
  end;

  {$IFDEF DELPHI5_LVL}
  Result := TabRect(k);
  {$ELSE}
  TabCtrl_GetItemRect(self.Handle, k, Result);
  {$ENDIF}
end;

procedure TAdvPageControl.DrawAllTabs(Canvas: TCanvas);
var
  clr, clrto: TColor;
  tf: TFont;
  lf: TLogFont;
  tbmp: TBitmap;
  TextX, TextY, {df,} i: integer;
  HorizontalGradient: Boolean;
  TabIndex, th: Integer;
  Rect, OrignalRect, TextR: TRect;
  Active: Boolean;
  ActiveTabIndex: integer;
  OverLapActiveRect: TRect;
  ActiveTabX, ActiveTabY: integer;
  r2: TRect;
  ActBottom, MaxTop, MaxLeft, MaxRight, j: integer;
  SplitLineDifference, LX: integer;
  isNextSelected, isLast: Boolean;
  HasTabs: boolean;
  FinalRgn,RgnTop,RgnLeft, RgnRight, RgnBottom: HRGN;
  IsColoredBackGround: Boolean;


  procedure DrawFocusRectangle(aCanvas: TCanvas; aRect: TRect; Active: Boolean; OverLapDiff: integer);
  begin
    //------- Draw Focus
    if not (csDesigning in ComponentState) then
    begin
      with Canvas do
      begin
        if FShowFocus and Active and Focused then
        begin
          Brush.Style := bsClear;
          Pen.Color := clBlack;
          Pen.Style := psDot;
          if ((TabPosition = tpTop) or (TabPosition = tpBottom)) then
            Rectangle(Rect.Left + 5, Rect.Top + 3, Rect.Right - 5 - OverLapDiff, Rect.Bottom - 3)
          else
            Rectangle(Rect.Left + 5, Rect.Top + 3, Rect.Right - 5, Rect.Bottom - 3 - OverLapDiff);
          Pen.Style := pssolid;
        end;
      end;
    end;
  end;

begin
  if (FUpdateCount > 0) then
    Exit;

  DoubleBuffered := True;

  if Parent <> nil then
    Canvas.Brush.Color := Parent.Brush.Color
  else
    Canvas.Brush.Color := clBtnFace;

  Canvas.Font.Assign(self.Font);

  ActBottom := 0;
  MaxTop := TabRectEx(0).Top;
  MaxLeft := Width;
  MaxRight := 0;

  SplitLineDifference := 0;

  HasTabs := false;

  for i := PageCount - 1 downto 0 do
  begin
    if TadvTabSheet(Pages[I]).TabVisible then
      HasTabs := true;
  end;

  for i := PageCount - 1 downto 0 do
  begin
    Rect := TabRectEx(i);
    if TadvTabSheet(Pages[I]).TabVisible then
    begin
      if ActBottom < Rect.Bottom then ActBottom := Rect.Bottom;
      if MaxTop > Rect.Top then MaxTop := Rect.Top;
      if MaxLeft > Rect.Left then MaxLeft := Rect.Left;
      if MaxRight < Rect.Right then MaxRight := Rect.Right;

      Rect.Right := Rect.Right + 2;
      case TabPosition of
        tpLeft:
          begin
            Rect.Left := Rect.Left - 2;
            Rect.Bottom := Rect.Bottom + 2;
            Rect.Right := Rect.Right - 2;
            Rect.Top := Rect.Top - 2;
          end;
        tpRight:
          begin
            Rect.Bottom := Rect.Bottom + 2;
            Rect.Top := Rect.Top - 2;
          end;
        tpTop:
          begin
            Rect.Left := Rect.Left - 2;
            Rect.Top := Rect.Top - 2;
          end;
        tpBottom:
          begin
            Rect.Left := Rect.Left - 2;
            Rect.Bottom := Rect.Bottom + 2;
          end;
      end;
      Canvas.FillRect(Rect);
    end;
  end;

  {$IFNDEF NODESIGNHINT}
  if (csDesigning in ComponentState) and not HasTabs then
  begin
    Canvas.Font.Assign(self.Font);
    th := Canvas.TextHeight('gh');
    Canvas.TextOut(10, Height div 2, 'Right-click and choose "New Page"');
    Canvas.TextOut(10, (Height div 2) + th,'to insert a new tabsheet');
    Canvas.Font.Style := [fsItalic];
    Canvas.TextOut(10, Height div 2 + 3*th, 'If no such right-click menu option appears');
    Canvas.TextOut(10, Height div 2 + 4*th, 'please install designtime package!');
  end;
  {$ENDIF}

  if not HasTabs then
    case TabPosition of
      tpTop: ActBottom := 2;
      tpBottom: MaxTop := Height - 2;
      tpRight: MaxLeft := Width - 2;
      tpLeft: MaxRight := 2;
    end;

  r2.Left := Width - 35;
  r2.Right := Width;

  if not MultiLine then
  begin
    if TabPosition = tpTop then
    begin
      r2.Top := 0;
      r2.Bottom := {TabHeight} ActBottom;
      Canvas.Brush.Color := Color;
      Canvas.FillRect(r2);
      Canvas.Pen.Color := clWhite;

      LX := max(r2.Right - 35, MaxRight);
      Canvas.MoveTo(LX {r2.Right-35}, r2.Bottom);
      Canvas.LineTo(r2.Right, r2.Bottom);
    end
    else if TabPosition = tpBottom then
    begin
      r2.Top := MaxTop; //Height - TabHeight-2;
      r2.Bottom := Height;
      Canvas.Brush.Color := Color;
      Canvas.FillRect(r2);
      Canvas.Pen.Color := cl3DDkShadow;

      LX := max(r2.Right - 35, MaxRight);
      Canvas.MoveTo(LX {r2.Right-35}, r2.Top - 1);
      Canvas.LineTo(r2.Right, r2.Top - 1);
    end;
  end;

  Canvas.Brush.Color := FTabBackGroundColor;
  if TabPosition = tpLeft then
  begin
    Rect.Left := 0;
    Rect.Right := MaxRight;
    Rect.Top := 0;
    
    if FullRefresh then         // FF: Bottom BlackLine Issue
      Rect.Bottom := Height -1
    else
      Rect.Bottom := Height;      
    Canvas.FillRect(Rect);
  end
  else if TabPosition = tpRight then
  begin
    Rect.Left := MaxLeft;
    Rect.Right := Width;
    Rect.Top := 0;

    if FullRefresh then         // FF: Bottom BlackLine Issue
      Rect.Bottom := Height -1
    else
      Rect.Bottom := Height;
    Canvas.FillRect(Rect);
  end
  else if TabPosition = tpTop then
  begin
    Rect.Left := 0;
    Rect.Right := width;
    Rect.Top := 0;
    Rect.Bottom := ActBottom;
    Canvas.FillRect(Rect);
  end
  else if TabPosition = tpBottom then
  begin
    Rect.Left := 0;
    Rect.Right := width;
    Rect.Top := MaxTop;
    Rect.Bottom := Height;
    Canvas.FillRect(Rect);
  end;

  IsColoredBackGround:= false;
  j:= 0;
  if ActivePage <> nil then
  begin
    if (ActivePage.ColorTo <> clNone) or (ActivePage.Color <> clNone) {due to Reduce flickering change} then
    begin
      if TabSheet3D then
        j:= 1;

      IsColoredBackGround:= true;

      case TabPosition of
        tpLeft:
          begin
            FinalRgn := CreateRectRgn(1, MaxRight, 1, ActBottom);
            RgnLeft := CreateRectRgn(MaxRight+j, 1, MaxRight+4, Height-1);
            RgnTop := CreateRectRgn(MaxRight+j, 1, Width-1, MaxRight + 4);
            CombineRgn(FinalRgn,RgnLeft, RgnTop,RGN_OR);
            RgnRight := CreateRectRgn(Width-4, 1, Width-1, Height-1);
            CombineRgn(FinalRgn,FinalRgn, RgnRight,RGN_OR);
            RgnBottom := CreateRectRgn(MaxRight+j, Height-4, Width-1, Height-1);
            CombineRgn(FinalRgn,FinalRgn, RgnBottom,RGN_OR);

            SelectClipRgn(Canvas.Handle,FinalRgn);
            if ActivePage.ColorTo <> clNone then
            begin
              DrawGradient(Canvas, ActivePage.Color, ActivePage.ColorTo, 16, clientRect, false);
              Canvas.Brush.Color:= ActivePage.Color;
              Canvas.Pen.Color:= ActivePage.Color;
              //Canvas.Rectangle(MaxRight+j, 1, MaxRight+4, Height -1);
              Canvas.Rectangle(MaxRight+j, 1, Width-1, 4);
            end
            else //if (ActivePage.Color <> Color) then
            begin
              Canvas.Brush.Color:= ActivePage.Color;
              Canvas.Pen.Color:= ActivePage.Color;
              Canvas.Rectangle(ClientRect.Left, ClientRect.Top, ClientRect.Right, ClientRect.Bottom);
            end;

            SelectClipRgn(Canvas.Handle,0);
            DeleteObject(RgnLeft);
            DeleteObject(RgnTop);
            DeleteObject(RgnRight);
            DeleteObject(RgnBottom);
            DeleteObject(FinalRgn);
          end;
        tpRight:
          begin
            FinalRgn := CreateRectRgn(1, MaxLeft, 1, ActBottom);
            RgnLeft := CreateRectRgn(1, 1, 4, Height-2);
            RgnTop := CreateRectRgn(1, 1, MaxLeft-j, 4);
            CombineRgn(FinalRgn,RgnLeft, RgnTop,RGN_OR);
            RgnRight := CreateRectRgn(MaxLeft-4, 1, MaxLeft-j, Height-2);
            CombineRgn(FinalRgn,FinalRgn, RgnRight,RGN_OR);
            RgnBottom := CreateRectRgn(1, Height-4, MaxLeft-j, Height-1);
            CombineRgn(FinalRgn,FinalRgn, RgnBottom,RGN_OR);

            SelectClipRgn(Canvas.Handle,FinalRgn);
            if ActivePage.ColorTo <> clNone then
            begin
              DrawGradient(Canvas, ActivePage.Color, ActivePage.ColorTo, 16, clientRect, false);
              Canvas.Brush.Color:= ActivePage.Color;
              Canvas.Pen.Color:= ActivePage.Color;
              Canvas.Rectangle(1, 1, MaxLeft-j, 4);
            end
            else //if (ActivePage.Color <> Color) then
            begin
              Canvas.Brush.Color:= ActivePage.Color;
              Canvas.Pen.Color:= ActivePage.Color;
              Canvas.Rectangle(ClientRect.Left, ClientRect.Top, ClientRect.Right, ClientRect.Bottom);
            end;

            SelectClipRgn(Canvas.Handle,0);
            DeleteObject(RgnLeft);
            DeleteObject(RgnTop);
            DeleteObject(RgnRight);
            DeleteObject(RgnBottom);
            DeleteObject(FinalRgn);
          end;
        tpTop:
          begin
            FinalRgn := CreateRectRgn(1, ActBottom, 1, ActBottom);
            RgnLeft := CreateRectRgn(1, ActBottom+j, 4, Height-1);
            RgnTop := CreateRectRgn(1, ActBottom+j, Width-1, ActBottom + 4);
            CombineRgn(FinalRgn,RgnLeft, RgnTop,RGN_OR);
            RgnRight := CreateRectRgn(Width-4, ActBottom+j, Width-1, Height-1);
            CombineRgn(FinalRgn,FinalRgn, RgnRight,RGN_OR);
            RgnBottom := CreateRectRgn(1, Height-4, Width-1, Height-1);
            CombineRgn(FinalRgn,FinalRgn, RgnBottom,RGN_OR);

            SelectClipRgn(Canvas.Handle,FinalRgn);
            if ActivePage.ColorTo <> clNone then
            begin
              DrawGradient(Canvas, ActivePage.Color, ActivePage.ColorTo, 16, clientRect, false);
              Canvas.Brush.Color:= ActivePage.Color;
              Canvas.Pen.Color:= ActivePage.Color;
              Canvas.Rectangle(1, ActBottom+1, Width-1, ActBottom + 4);
            end
            else //if (ActivePage.Color <> Color) then
            begin
              Canvas.Brush.Color:= ActivePage.Color;
              Canvas.Pen.Color:= ActivePage.Color;
              Canvas.Rectangle(ClientRect.Left, ClientRect.Top, ClientRect.Right, ClientRect.Bottom);
            end;

            SelectClipRgn(Canvas.Handle,0);
            DeleteObject(RgnLeft);
            DeleteObject(RgnTop);
            DeleteObject(RgnRight);
            DeleteObject(RgnBottom);
            DeleteObject(FinalRgn);
          end;
        tpBottom:
          begin
            FinalRgn := CreateRectRgn(1, MaxTop, 1, MaxTop);
            RgnLeft := CreateRectRgn(1, MaxTop-j, 4, 1);
            RgnTop := CreateRectRgn(1, MaxTop-j, Width-1, MaxTop - 4);
            CombineRgn(FinalRgn,RgnLeft, RgnTop,RGN_OR);
            RgnRight := CreateRectRgn(Width-4, MaxTop-j, Width-1, 1);
            CombineRgn(FinalRgn,FinalRgn, RgnRight,RGN_OR);
            RgnBottom := CreateRectRgn(1, 1, Width-1, 4);
            CombineRgn(FinalRgn,FinalRgn, RgnBottom,RGN_OR);

            SelectClipRgn(Canvas.Handle,FinalRgn);
            if ActivePage.ColorTo <> clNone then
            begin
              DrawGradient(Canvas, ActivePage.Color, ActivePage.ColorTo, 16, clientRect, false);
              Canvas.Brush.Color:= ActivePage.Color;
              Canvas.Pen.Color:= ActivePage.Color;
              Canvas.Rectangle(1, 1, Width-1, 4);
            end
            else //if (ActivePage.Color <> Color) then
            begin
              Canvas.Brush.Color:= ActivePage.Color;
              Canvas.Pen.Color:= ActivePage.Color;
              Canvas.Rectangle(ClientRect.Left, ClientRect.Top, ClientRect.Right, ClientRect.Bottom);
            end;

            SelectClipRgn(Canvas.Handle,0);
            DeleteObject(RgnLeft);
            DeleteObject(RgnTop);
            DeleteObject(RgnRight);
            DeleteObject(RgnBottom);
            DeleteObject(FinalRgn);
          end;
      end;
    end;
  end;

  if not FTabSheet3D then
  begin
    case TabPosition of
      tpLeft:
        begin
          Canvas.Pen.Color := FTabSheetBorderColor;
             // |
          Canvas.MoveTo(MaxRight, 0);
          Canvas.LineTo(MaxRight, Height);
             // _
          Canvas.MoveTo(MaxRight, Height - 2);
          Canvas.LineTo(Width - 2, Height - 2);
             //  |
          Canvas.MoveTo(Width - 2, Height);
          Canvas.LineTo(Width - 2, 0);
             // -
          Canvas.MoveTo(Width - 2, 0);
          Canvas.LineTo(MaxRight, 0);

          Canvas.Pen.Color := Color;
          Canvas.MoveTo(MaxRight, Height - 1);
          Canvas.LineTo(Width - 1, Height - 1);
          Canvas.MoveTo(Width - 1, Height - 1);
          Canvas.LineTo(Width - 1, -1);
        end;
      tpRight:
        begin
          Canvas.Pen.Color := FTabSheetBorderColor;
             // |
          Canvas.MoveTo(0, 0);
          Canvas.LineTo(0, Height);
             // _
          Canvas.MoveTo(0, Height - 2);
          Canvas.LineTo(MaxLeft, Height - 2);
             //  |
          Canvas.MoveTo(MaxLeft - 1, Height);
          Canvas.LineTo(MaxLeft - 1, 0);
             // -
          Canvas.MoveTo(MaxLeft - 1, 0);
          Canvas.LineTo(0, 0);

          Canvas.Pen.Color := Color;
          Canvas.MoveTo(0, Height - 1);
          Canvas.LineTo(MaxLeft, Height - 1);
          if not IsColoredBackGround then
          begin
            Canvas.MoveTo(MaxLeft - 2, Height - 3);
            Canvas.LineTo(MaxLeft - 2, 0);
          end;
        end;
      tpTop:
        begin
          Canvas.Pen.Color := FTabSheetBorderColor;

             // |
          Canvas.MoveTo(0, ActBottom);
          Canvas.LineTo(0, Height);
             // _
          Canvas.MoveTo(0, Height - 1);
          Canvas.LineTo(Width, Height - 1);
             //  |
          Canvas.MoveTo(Width - 1, Height - 2);
          Canvas.LineTo(Width - 1, ActBottom);
             // -
          Canvas.MoveTo(0, ActBottom);
          Canvas.LineTo(Width, ActBottom);

          if not IsColoredBackGround then
          begin
            Canvas.Pen.Color := Color;
            Canvas.MoveTo(1, Height - 2);
            Canvas.LineTo(Width - 1, Height - 2);
            Canvas.MoveTo(Width - 2, Height - 2);
            Canvas.LineTo(Width - 2, ActBottom);
          end;

        end;
      tpBottom:
        begin
          Canvas.Pen.Color := FTabSheetBorderColor;
             // |
          Canvas.MoveTo(0, 0);
          Canvas.LineTo(0, MaxTop);
             // _
          Canvas.MoveTo(0, MaxTop - 1);
          Canvas.LineTo(Width, MaxTop - 1);
             //  |
          Canvas.MoveTo(Width - 1, MaxTop - 1);
          Canvas.LineTo(Width - 1, 0);
             // -
          Canvas.MoveTo(0, 0);
          Canvas.LineTo(Width, 0);

          if not IsColoredBackGround then
          begin
            Canvas.Pen.Color := Color;
            Canvas.MoveTo(1, MaxTop - 2);
            Canvas.LineTo(Width - 1, MaxTop - 2);
            Canvas.MoveTo(Width - 2, MaxTop - 2);
            Canvas.LineTo(Width - 2, 0);
          end;
        end;
    end;


    if FRoundEdges then
    begin
      case TabPosition of
        tpLeft:
          begin
            Canvas.Pen.Color := Color;
               // _|
            Canvas.MoveTo(Width - 2 - 3, Height - 2);
            Canvas.LineTo(Width - 2, Height - 2);
            Canvas.LineTo(Width - 2, Height - 2 - 4);
               // -|
            Canvas.MoveTo(Width - 2, 0 + 3);
            Canvas.LineTo(Width - 2, 0);
            Canvas.LineTo(Width - 2 - 4, 0);

            Canvas.Pen.Color := FTabSheetBorderColor;
               // _)
            Canvas.MoveTo(Width - 2 - 3, Height - 3);
            Canvas.LineTo(Width - 3, Height - 3);
            Canvas.MoveTo(Width - 3, Height - 4);
            Canvas.LineTo(Width - 3, Height - 6);
               // -)
            Canvas.MoveTo(Width - 3, 0 + 3);
            Canvas.LineTo(Width - 3, 0 + 1);
            Canvas.MoveTo(Width - 4, 0 + 1);
            Canvas.LineTo(Width - 6, 0 + 1);
          end;
        tpRight:
          begin
            Canvas.Pen.Color := Color;
               // |-
            Canvas.MoveTo(0, 0 + 3);
            Canvas.LineTo(0, 0);
            Canvas.LineTo(5, 0);
               // |_
            Canvas.MoveTo(0, Height - 2 - 3);
            Canvas.LineTo(0, Height - 2);
            Canvas.LineTo(4, Height - 2);

            Canvas.Pen.Color := FTabSheetBorderColor;
               // (-
            Canvas.MoveTo(1, 0 + 3);
            Canvas.LineTo(1, 0 + 1);
            Canvas.MoveTo(2, 0 + 1);
            Canvas.LineTo(5, 0);
               // (_
            Canvas.MoveTo(1, Height - 2 - 3);
            Canvas.LineTo(1, Height - 3);
            Canvas.MoveTo(2, Height - 3);
            Canvas.LineTo(4, Height - 3);
          end;
        tpTop:
          begin
            Canvas.Pen.Color := Color;
                // |_
            Canvas.MoveTo(0, Height - 1 - 3);
            Canvas.LineTo(0, Height - 1);
            Canvas.LineTo(4, Height - 1);
               // _|
            Canvas.MoveTo(Width - 1 - 3, Height - 1);
            Canvas.LineTo(Width - 1, Height - 1);
            Canvas.LineTo(Width - 1, Height - 1 - 4);
               // -|

            Canvas.Pen.Color := FTabSheetBorderColor;
               // (_
            Canvas.MoveTo(1, Height - 1 - 3);
            Canvas.LineTo(1, Height - 2);
            Canvas.MoveTo(2, Height - 2);
            Canvas.LineTo(4, Height - 2);
               // _)
            Canvas.MoveTo(Width - 1 - 3, Height - 2);
            Canvas.LineTo(Width - 2, Height - 2);
            Canvas.MoveTo(Width - 2, Height - 3);
            Canvas.LineTo(Width - 2, Height - 5);
          end;
        tpBottom:
          begin
            Canvas.Pen.Color := Color;
               // |-
            Canvas.MoveTo(0, 0 + 3);
            Canvas.LineTo(0, 0);
            Canvas.LineTo(5, 0);
               // -|
            Canvas.MoveTo(Width - 1, 0 + 3);
            Canvas.LineTo(Width - 1, 0);
            Canvas.LineTo(Width - 1 - 4, 0);

            Canvas.Pen.Color := FTabSheetBorderColor;
               // (-
            Canvas.MoveTo(1, 0 + 3);
            Canvas.LineTo(1, 0 + 1);
            Canvas.MoveTo(2, 0 + 1);
            Canvas.LineTo(5, 0);
               // -)
            Canvas.MoveTo(Width - 2, 0 + 3);
            Canvas.LineTo(Width - 2, 0 + 1);
            Canvas.MoveTo(Width - 3, 0 + 1);
            Canvas.LineTo(Width - 5, 0 + 1);
          end;
      end;
    end;
                                             // FF: LeftTop corner paint Iss
    if not FTabSplitLine and (PageCount > 0) and HasTabs then
    begin
      SplitLineDifference := 1;

      if IsColoredBackGround then
      begin
        if TabPosition = tpBottom then
        begin
          if ActivePage.ColorTo = clNone then
            Canvas.Pen.Color := ActivePage.Color
          else
            Canvas.Pen.Color := ActivePage.ColorTo;
        end
        else
          Canvas.Pen.Color := ActivePage.Color;
      end
      else
        Canvas.Pen.Color := Color;

      case TabPosition of
        tpLeft:
          begin
            Canvas.MoveTo(MaxRight, 2);
            if TabStyle = tsClassic then
            begin
              if not FTabBackGround.Empty then
                Canvas.LineTo(MaxRight, ActBottom + FTabOverlap + 2)
              else
                Canvas.LineTo(MaxRight, ActBottom + FTabOverlap);
            end
            else
              Canvas.LineTo(MaxRight, ActBottom + FTabOverlap);
          end;
        tpRight:
          begin
            Canvas.MoveTo(MaxLeft - 1, ActBottom - 1 + FTabOverlap);
            Canvas.LineTo(MaxLeft - 1, 2);
          end;
        tpTop:
          begin
            Canvas.MoveTo(3, ActBottom);
            Canvas.LineTo(MaxRight + FTabOverlap, ActBottom);
          end;
        tpBottom:
          begin
            Canvas.MoveTo(2, MaxTop - 1);
            Canvas.LineTo(MaxRight + FTabOverlap, MaxTop - 1);
          end;
      end;
    end;
  end;


  ActiveTabIndex := -1;
  ActiveTabX := -10;
  ActiveTabY := -10;


  tbmp := TBitmap.Create;

  for i := PageCount - 1 downto 0 do
  begin
    if TAdvTabSheet(Pages[i]).TabVisible then
    begin
      TabIndex := i;
      OrignalRect := TabRectEx(i);

      Rect := OrignalRect;
      Active := (i = GetActivePageIndex());

      if Assigned(FOnDrawTab) then
      begin
        FOnDrawTab(Self, TabIndex, OrignalRect, Active);
        //Continue;
      end;

      TextX := 0;
      TextY := 0;

      if not FTabBackGround.Empty then
      begin
        tbmp.Width := FTabBackGround.Width;
        tbmp.Height := FTabBackGround.Height;
      end;

      HorizontalGradient := true;
      //df := 0;
      if Active and (FActiveColor <> clNone) then
      begin
       // df := 3;
        clr := FActiveColor;
        clrto := FActiveColorTo;
        if TAdvTabSheet(FPages[TabIndex]).TabGradientDirection = gdVertical then
          HorizontalGradient := false;
      end
      else
      begin
        if (FHoverTab = TabIndex) and ((TabHoverColorTo <> clNone) or (TabHoverColor <> clNone)) then
        begin
          clr := TabHoverColor;
          clrto := TabHoverColorTo;
          if TAdvTabSheet(FPages[TabIndex]).HoverGradientDirection = gdVertical then
            HorizontalGradient := false;
        end
        else
        begin
          clr := TAdvTabSheet(FPages[TabIndex]).TabColor; //FDefaultTabColor;
          clrto := TAdvTabSheet(FPages[TabIndex]).TabColorTo; //FDefaultTabColorTo;
          if TAdvTabSheet(FPages[TabIndex]).TabGradientDirection = gdVertical then
            HorizontalGradient := false;
        end;
      end;

      with Canvas do
      begin
        Brush.Color := clr;
        if TabPosition = tpLeft then
        begin
          if TAdvTabSheet(FPages[TabIndex]).ShowClose then
          begin
            if (ClosePosition = cpLeft) then
              TextY := Rect.Bottom - 4 - CloseButtonHeight
            else
              TextY := Rect.Bottom - 4;
          end
          else
            TextY := Rect.Bottom - 4;

          if Active then
            TextX := Rect.Left + {3} FLowerActive + 1
          else
            TextX := Rect.Left + 1;

          if not FTabBackGround.Empty then
          begin
            TextX := TextX - 2;
            TextY := TextY - 3;
            if not Assigned(FOnDrawTab) then
            begin
              if Active and not FTabBackGroundActive.Empty then
              begin
                tbmp.Canvas.Draw(0, 0, FTabBackGroundActive);
                ActiveTabIndex := tabIndex;
                OverLapActiveRect := Rect;
              end
              else
              begin
                tbmp.Canvas.Draw(0, 0, FTabBackGround);
                BitmapStretch(tbmp, Canvas, Rect.Left { - 2}, Rect.Top, Rect.Bottom - Rect.Top + 3 + FTabOverlap);
              end;
            end;
          end
          else
          begin
            Rect.Left := Rect.Left - 1;
            if not Assigned(FOnDrawTab) then
            begin
              if clrto = clNone then
                FillRect(Rect)
              else
              begin
                Rect.Right := Rect.Right - 1;
                if not HorizontalGradient then Rect.Bottom := Rect.Bottom - 1;
                DrawGradient(Canvas, clr, clrto, 16, Rect, HorizontalGradient);
                if not HorizontalGradient then Rect.Bottom := Rect.Bottom + 1;
                Rect.Right := Rect.Right + 1;
              end;
            end;
            Brush.Style := bsClear;

            if TabStyle = tsClassic then
            begin
              Pen.Color := FTabBorderColor;
              if Active then
              begin
                MoveTo(Rect.Right - 1, Rect.Top);
                LineTo(Rect.Left, Rect.Top);
                LineTo(Rect.Left, Rect.Bottom);
                LineTo(Rect.Right, Rect.Bottom);
              end
              else
              begin
                if SplitLineDifference > 0 then
                  if Rect.Right < MaxRight then
                    SplitLineDifference := 0;

                if Rect.Bottom > Height - 5 then Rectangle(Rect.Left, Rect.Top, Rect.Right + SplitLineDifference, Rect.Bottom)
                else Rectangle(Rect.Left, Rect.Top, Rect.Right + SplitLineDifference, Rect.Bottom + 1);

                if not FTabSheet3D and not FTabSplitLine then
                  SplitLineDifference := 1;
              end;
            end
            else if TabStyle = tsDelphi then
            begin
              if Active then
              begin
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Right, Rect.Top);
                LineTo(Rect.Left, Rect.Top);
                MoveTo(Rect.Left, Rect.Bottom);
                LineTo(Rect.Right, Rect.Bottom);
              end
              else
              begin
                isLast := Rect.Bottom > ActBottom - 3;
                isNextSelected := FindNextPage(Pages[i], true, true).TabIndex = GetActivePageIndex; //Rect.Right > TabRectEx(GetActivePageIndex).Left-4 ;
                Pen.Color := FTabBorderColor; 
                MoveTo(Rect.Right, Rect.Top);
                LineTo(Rect.Right, Rect.Bottom);

                if not isNextSelected or isLast then
                begin
                  Pen.Color := FTabBorderColor;
                  MoveTo(Rect.Left, Rect.Bottom - 2);
                  LineTo(Rect.Right, Rect.Bottom - 2);
                  //MoveTo(Rect.Left + 2, Rect.Bottom - 3);
                  //LineTo(Rect.Right - 2, Rect.Bottom - 3);
                end;
              end;
            end
            else // TabStyle = tsDotNet
            begin
              if Active then
              begin
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Right, Rect.Top);
                LineTo(Rect.Left, Rect.Top);
                LineTo(Rect.Left, Rect.Bottom);
                LineTo(Rect.Right, Rect.Bottom);
              end
              else
              begin
                isLast := Rect.Bottom > ActBottom - 3;
                isNextSelected := FindNextPage(Pages[i], true, true).TabIndex = GetActivePageIndex; //Rect.Right > TabRectEx(GetActivePageIndex).Left-4 ;
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Right, Rect.Top);
                LineTo(Rect.Right, Rect.Bottom);

                if not isNextSelected or isLast then
                begin
                  Pen.Color := ActiveColor;
                  MoveTo(Rect.Left + 2, Rect.Bottom - 2);
                  LineTo(Rect.Right - 2, Rect.Bottom - 2);
                  MoveTo(Rect.Left + 2, Rect.Bottom - 3);
                  LineTo(Rect.Right - 2, Rect.Bottom - 3);
                end;
              end;
            end; // tsDotNet end
          end;
        end
        else if TabPosition = tpRight then
        begin
          if TAdvTabSheet(FPages[TabIndex]).ShowClose then
          begin
            if (ClosePosition = cpLeft) then
              TextY := Rect.Top + 4 + CloseButtonHeight
            else
              TextY := Rect.Top + 4;
          end
          else
            TextY := Rect.Top + 4;

          if Active then
            TextX := Rect.Right - {3} FLowerActive - 1
          else
            TextX := Rect.Right - 1;

          if not FTabBackGround.Empty then
          begin
            TextX := TextX - TabHeight div 3;

            TextY := TextY - 3;
            if not Assigned(FOnDrawTab) then
            begin
              if Active and not FTabBackGroundActive.Empty then
              begin
                tbmp.Canvas.Draw(0, 0, FTabBackGroundActive);
                ActiveTabIndex := tabIndex;
                OverLapActiveRect := Rect;
              end
              else
              begin
                tbmp.Canvas.Draw(0, 0, FTabBackGround);
                BitmapStretch(tbmp, Canvas, Rect.Left - 1, Rect.Top - 2, Rect.Bottom - Rect.Top + 3 + TabOverlap);
              end;
            end;
          end
          else
          begin
            if not Assigned(FOnDrawTab) then
            begin
              if ClrTo = clNone then
                FillRect(Rect)
              else
              begin
                if Active then
                begin
                  DrawGradient(Canvas, clr, clrto, 16, Rect, HorizontalGradient);
                end
                else
                begin
                  if not HorizontalGradient then Rect.Bottom := Rect.Bottom - 1;
                  DrawGradient(Canvas, clr, clrto, 16, Rect, HorizontalGradient);
                  if not HorizontalGradient then Rect.Bottom := Rect.Bottom + 1;
                end;
              end;
            end;
            Rect.Right := Rect.Right + 1;
            Brush.Style := bsClear;

            if TabStyle = tsClassic then
            begin
              Pen.Color := FTabBorderColor;
              if Active then
              begin
                MoveTo(Rect.Left, Rect.Top);
                LineTo(Rect.Right - 1, Rect.Top);
                LineTo(Rect.Right - 1, Rect.Bottom);
                LineTo(Rect.Left - 1, Rect.Bottom);
              end
              else
              begin
                if SplitLineDifference > 0 then
                  if Rect.Left > MaxLeft then
                    SplitLineDifference := 0;

                if Rect.Bottom > Height - 5 then Rectangle(Rect.Left - SplitLineDifference, Rect.Top, Rect.Right, Rect.Bottom)
                else Rectangle(Rect.Left - SplitLineDifference, Rect.Top, Rect.Right, Rect.Bottom + 1);

                if not FTabSheet3D and not FTabSplitLine then
                  SplitLineDifference := 1;
              end;
            end
            else if TabStyle = tsDelphi then
            begin
              if Active then
              begin
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left - 1, Rect.Top);
                LineTo(Rect.Right - 1, Rect.Top);
                MoveTo(Rect.Right - 1, Rect.Bottom);
                LineTo(Rect.Left - 1, Rect.Bottom);
              end
              else
              begin
                isLast := Rect.Bottom > ActBottom - 3;
                isNextSelected := FindNextPage(Pages[i], true, true).TabIndex = GetActivePageIndex; //Rect.Right > TabRectEx(GetActivePageIndex).Left-4 ;
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left - 1, Rect.Top);
                LineTo(Rect.Left - 1, Rect.Bottom);

                if not isNextSelected or isLast then
                begin
                  Pen.Color := FTabBorderColor;
                  MoveTo(Rect.Left, Rect.Bottom - 2);
                  LineTo(Rect.Right, Rect.Bottom - 2);
                  //MoveTo(Rect.Left + 2, Rect.Bottom - 3);
                  //LineTo(Rect.Right - 2, Rect.Bottom - 3);
                end;
              end;
            end
            else // TabStyle = tsDotNet
            begin
              if Active then
              begin
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left - 1, Rect.Top);
                LineTo(Rect.Right - 1, Rect.Top);
                LineTo(Rect.Right - 1, Rect.Bottom);
                LineTo(Rect.Left - 1, Rect.Bottom);
              end
              else
              begin
                isLast := Rect.Bottom > ActBottom - 3;
                isNextSelected := FindNextPage(Pages[i], true, true).TabIndex = GetActivePageIndex; //Rect.Right > TabRectEx(GetActivePageIndex).Left-4 ;
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left - 1, Rect.Top);
                LineTo(Rect.Left - 1, Rect.Bottom);

                if not isNextSelected or isLast then
                begin
                  Pen.Color := ActiveColor;
                  MoveTo(Rect.Left + 2, Rect.Bottom - 2);
                  LineTo(Rect.Right - 2, Rect.Bottom - 2);
                  MoveTo(Rect.Left + 2, Rect.Bottom - 3);
                  LineTo(Rect.Right - 2, Rect.Bottom - 3);
                end;
              end;
            end; // tsDotNet end
          end;
        end
        else if TabPosition = tpTop then
        begin
          if TAdvTabSheet(FPages[TabIndex]).ShowClose then
          begin
            if (ClosePosition = cpLeft) then
              TextX := Rect.Left + 4 + CloseButtonWidth
            else
              TextX := Rect.Left + 4;
          end
          else
            TextX := Rect.Left + 4;

          if Active then
            TextY := Rect.Top + {df} FLowerActive + 1
          else
            TextY := Rect.Top + 1;

          if not FTabBackGround.Empty then
          begin
            if not Assigned(FOnDrawTab) then
            begin
              if Active and not FTabBackGroundActive.Empty then
              begin
                tbmp.Canvas.Draw(0, 0, FTabBackGroundActive);
                ActiveTabIndex := tabIndex;
                OverLapActiveRect := Rect;
              end
              else
              begin
                tbmp.Canvas.Draw(0, 0, FTabBackGround);
                BitmapStretchInWidth(tbmp, Canvas, Rect.Left - 1, Rect.Top - 2, Rect.Right - Rect.Left + 2 + FTabOverlap);
              end;
            end;
          end
          else
          begin
            Rect.Top := Rect.Top - 1;
            if not Assigned(FOnDrawTab) then
            begin
              if ClrTo = clNone then
                FillRect(Rect)
              else
              begin
                Rect.Bottom := Rect.Bottom - 1;
                if HorizontalGradient then Rect.Right := Rect.Right - 1;
                DrawGradient(Canvas, clr, clrto, 16, Rect, HorizontalGradient);
                if HorizontalGradient then Rect.Right := Rect.Right + 1;
                Rect.Bottom := Rect.Bottom + 1;
              end;
            end;

            Brush.Style := bsClear;

            if TabStyle = tsClassic then
            begin
              Pen.Color := FTabBorderColor;

              if Active then
              begin
                MoveTo(Rect.Left, Rect.Bottom - 1);
                LineTo(Rect.Left, Rect.Top);
                LineTo(Rect.Right, Rect.Top);
                LineTo(Rect.Right, Rect.Bottom);
              end
              else
              begin
                if SplitLineDifference > 0 then
                  if Rect.Bottom < ActBottom then
                    SplitLineDifference := 0;

                if Rect.Right > Width - 5 then Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom + SplitLineDifference)
                else Rectangle(Rect.Left, Rect.Top, Rect.Right + 1, Rect.Bottom + SplitLineDifference);

                if not FTabSheet3D and not FTabSplitLine then
                  SplitLineDifference := 1;
              end;
            end
            else if TabStyle = tsDelphi then
            begin
              if Active then
              begin
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left, Rect.Bottom);
                LineTo(Rect.Left, Rect.Top);
                MoveTo(Rect.Right, Rect.Top);
                LineTo(Rect.Right, Rect.Bottom);
              end
              else
              begin
                isLast := Rect.Right > MaxRight - 3;
                isNextSelected := FindNextPage(Pages[i], true, true).TabIndex = GetActivePageIndex; //Rect.Right > TabRectEx(GetActivePageIndex).Left-4 ;
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left, Rect.Bottom);
                LineTo(Rect.Right, Rect.Bottom);

                if not isNextSelected or isLast then
                begin
                  Pen.Color := FTabBorderColor;
                  MoveTo(Rect.Right - 2, Rect.Bottom);
                  LineTo(Rect.Right - 2, Rect.Top);
                  //MoveTo(Rect.Right - 3, Rect.Bottom - 3);
                  //LineTo(Rect.Right - 3, Rect.Top + 2);
                end;
              end;
            end
            else // TabStyle = tsDotNet
            begin
              if Active then
              begin
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left, Rect.Bottom);
                LineTo(Rect.Left, Rect.Top);
                LineTo(Rect.Right, Rect.Top);
                LineTo(Rect.Right, Rect.Bottom);
              end
              else
              begin
                isLast := Rect.Right > MaxRight - 3;
                isNextSelected := FindNextPage(Pages[i], true, true).TabIndex = GetActivePageIndex; //Rect.Right > TabRectEx(GetActivePageIndex).Left-4 ;
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left, Rect.Bottom);
                LineTo(Rect.Right, Rect.Bottom);

                if not isNextSelected or isLast then
                begin
                  Pen.Color := ActiveColor;
                  MoveTo(Rect.Right - 2, Rect.Bottom - 3);
                  LineTo(Rect.Right - 2, Rect.Top + 2);
                  MoveTo(Rect.Right - 3, Rect.Bottom - 3);
                  LineTo(Rect.Right - 3, Rect.Top + 2);
                end;
              end;
            end; // tsDotNet end
          end;
        end
        else if TabPosition = tpBottom then
        begin
          Rect.Bottom := Rect.Bottom + 1;

          if TAdvTabSheet(FPages[TabIndex]).ShowClose then
          begin
            if (ClosePosition = cpLeft) then
              TextX := Rect.Left + 4 + CloseButtonWidth
            else
              TextX := Rect.Left + 4;
          end
          else
            TextX := Rect.Left + 4;


          if Active then
            TextY := Rect.Top + {3} FLowerActive + 1
          else
            TextY := Rect.Top;

          if not FTabBackGround.Empty then
          begin
            TextY := TextY + 3;

            if not Assigned(FOnDrawTab) then
            begin
              if Active and not FTabBackGroundActive.Empty then
              begin
                tbmp.Canvas.Draw(0, 0, FTabBackGroundActive);
                ActiveTabIndex := tabIndex;
                OverLapActiveRect := Rect;
              end
              else
              begin
                tbmp.Canvas.Draw(0, 0, FTabBackGround);
                BitmapStretchInWidth(tbmp, Canvas, Rect.Left - 2, Rect.Top - 1, Rect.Right - Rect.Left + 2 + FTabOverlap);
              end;
            end;
          end
          else
          begin
            if not Assigned(FOnDrawTab) then
            begin
              if ClrTo = clNone then
                FillRect(Rect)
              else
              begin
                if HorizontalGradient then Rect.Right := Rect.Right - 1 else Rect.Bottom := Rect.Bottom - 1;
                DrawGradient(Canvas, clr, clrto, 16, Rect, HorizontalGradient);
                if HorizontalGradient then Rect.Right := Rect.Right + 1 else Rect.Bottom := Rect.Bottom + 1;
              end;
            end;
            Brush.Style := bsClear;

            if TabStyle = tsClassic then
            begin
              Pen.Color := FTabBorderColor;
              if Active then
              begin
                MoveTo(Rect.Left, Rect.Top);
                LineTo(Rect.Left, Rect.Bottom);
                LineTo(Rect.Right, Rect.Bottom);
                LineTo(Rect.Right, Rect.Top - 1);
              end
              else
              begin
                if SplitLineDifference > 0 then
                  if Rect.Top > MaxTop then
                    SplitLineDifference := 0;

                if Rect.Right > Width - 5 then Rectangle(Rect.Left, Rect.Top - SplitLineDifference, Rect.Right, Rect.Bottom)
                else Rectangle(Rect.Left, Rect.Top - SplitLineDifference, Rect.Right + 1, Rect.Bottom);
                Texty := TextY + 2;

                if not FTabSheet3D and not FTabSplitLine then
                  SplitLineDifference := 1;
              end;
            end
            else if TabStyle = tsDelphi then
            begin
              if Active then
              begin
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left, Rect.Top - 1);
                LineTo(Rect.Left, Rect.Bottom);
                MoveTo(Rect.Right, Rect.Bottom-1);
                LineTo(Rect.Right, Rect.Top - 1);
              end
              else
              begin
                isLast := Rect.Right > MaxRight - 3;
                isNextSelected := FindNextPage(Pages[i], true, true).TabIndex = GetActivePageIndex; //Rect.Right > TabRectEx(GetActivePageIndex).Left-4 ;
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left, Rect.Top - 1);
                LineTo(Rect.Right, Rect.Top - 1);

                if not isNextSelected or isLast then
                begin
                  Pen.Color := FTabBorderColor;
                  MoveTo(Rect.Right - 2, Rect.Bottom-1);
                  LineTo(Rect.Right - 2, Rect.Top-1);
                  //MoveTo(Rect.Right - 3, Rect.Bottom - 3);
                  //LineTo(Rect.Right - 3, Rect.Top + 2);
                end;
              end;
            end
            else // TabStyle = tsDotNet
            begin
              if Active then
              begin
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left, Rect.Top - 1);
                LineTo(Rect.Left, Rect.Bottom);
                LineTo(Rect.Right, Rect.Bottom);
                LineTo(Rect.Right, Rect.Top - 1);
              end
              else
              begin
                isLast := Rect.Right > MaxRight - 3;
                isNextSelected := FindNextPage(Pages[i], true, true).TabIndex = GetActivePageIndex; //Rect.Right > TabRectEx(GetActivePageIndex).Left-4 ;
                Pen.Color := FTabBorderColor; //clBlack;
                MoveTo(Rect.Left, Rect.Top - 1);
                LineTo(Rect.Right, Rect.Top - 1);

                if not isNextSelected or isLast then
                begin
                  Pen.Color := ActiveColor;
                  MoveTo(Rect.Right - 2, Rect.Bottom - 3);
                  LineTo(Rect.Right - 2, Rect.Top + 2);
                  MoveTo(Rect.Right - 3, Rect.Bottom - 3);
                  LineTo(Rect.Right - 3, Rect.Top + 2);
                end;
              end;
            end; // tsDotNet end
          end;
        end;

        //if TAdvTabSheet(FPages[TabIndex]).ShowClose then DrawCloseButton(OrignalRect, Active);

        // Make sure to use a truetype font!
        // Font.Name := 'Tahoma';

        tf := TFont.Create;
        try
          if (TabPosition = tpLeft) or (TabPosition = tpRight) then
          begin
{$IFNDEF TMSDOTNET}
            FillChar(lf, SizeOf(lf), 0);
{$ENDIF}
            if Active then
              tf.Assign(FActiveFont)
            else
              tf.Assign(self.Font);
{$IFNDEF TMSDOTNET}
            GetObject(tf.Handle, SizeOf(Lf), @Lf);
{$ENDIF}
{$IFDEF TMSDOTNET}
            GetObject(tf.Handle, Marshal.SizeOf(TypeOf(Lf)), Lf);
{$ENDIF}

            if TabPosition = tpLeft then lf.lfEscapement := -2700
            else lf.lfEscapement := -900;
            lf.lfOrientation := 30;

            tf.Handle := CreateFontIndirect(Lf);
            Canvas.Font.Assign(tf);
          end;
        finally
          tf.Free;
        end;

        if TabPosition = tpLeft then
        begin
          TextX := TextX + FTabMargin.LeftMargin;
          TextY := TextY - FTabMargin.TopMargin;
          if not FTabBackGroundActive.Empty then TextY := TextY + TabOverlap + 3;
        end
        else
        begin
          TextX := TextX + FTabMargin.LeftMargin;
          TextY := TextY + FTabMargin.TopMargin;
        end;

        if ((ActiveTabIndex >= 0) and (ActiveTabX = -10) and (ActiveTabY = -10)) then
        begin
          ActiveTabX := TextX;
          ActiveTabY := TextY;
        end
        else
        begin
          if TAdvTabSheet(FPages[TabIndex]).ShowClose then
            DrawCloseButton(OrignalRect, Active);

          if (Images <> nil) and (TAdvTabSheet(FPages[TabIndex]).ImageIndex >= 0) and not Assigned(FOnDrawTab) then
          begin
            if (TabPosition = tpLeft) then
              Images.Draw(Canvas, TextX + 1, TextY - 14, TAdvTabSheet(FPages[TabIndex]).ImageIndex)
            else
              if (TabPosition = tpRight) then
                Images.Draw(Canvas, TextX - 18, TextY, TAdvTabSheet(FPages[TabIndex]).ImageIndex)
              else
                Images.Draw(Canvas, TextX - 2, TextY, TAdvTabSheet(FPages[TabIndex]).ImageIndex);

            if (TabPosition = tpLeft) then
              TextY := TextY - Images.Height;
            if (TabPosition = tpRight) then
              TextY := TextY + Images.Height;
            if (TabPosition = tpTop) or (TabPosition = tpBottom) then
              TextX := TextX + Images.width;
          end;


          //------- Displaying text
          if Active {and ((TabPosition = tpTop) or (TabPosition = tpBottom))} then
          begin
            if ((TabPosition = tpTop) or (TabPosition = tpBottom)) then
              Canvas.Font.Assign(FActiveFont)
            else
            begin
              // do nothing Already Assigned while making orientation of the text
            end;
          end
          else
          begin
            if ((TabPosition = tpTop) or (TabPosition = tpBottom)) then
              Canvas.Font.Assign(self.Font);
            Canvas.Font.Color := TAdvTabSheet(FPages[TabIndex]).TextColor;
          end;

          if not TAdvTabSheet(FPages[TabIndex]).TabEnable then
            Canvas.Font.Color := clGray;

          if not TAdvTabSheet(FPages[TabIndex]).Enabled then
            Canvas.Font.Color := clGrayText;

          Brush.Style := bsClear;
          if (TabPosition = tpTop) or (TabPosition = tpBottom) then
          begin
            TextR := OrignalRect;
            TextR.Left := TextX;
            TextR.Top := TextY;
            if not Assigned(FOnDrawTab) then
{$IFNDEF TMSDOTNET}
              DrawText(Canvas.Handle, Pchar(TAdvTabSheet(FPages[TabIndex]).Caption), Length(TAdvTabSheet(FPages[TabIndex]).Caption), TextR, DT_LEFT or DT_SINGLELINE {or DT_END_ELLIPSIS } or DT_NOCLIP);
{$ENDIF}
{$IFDEF TMSDOTNET}
              DrawText(Canvas.Handle, TAdvTabSheet(FPages[TabIndex]).Caption, Length(TAdvTabSheet(FPages[TabIndex]).Caption), TextR, DT_LEFT or DT_SINGLELINE {or DT_END_ELLIPSIS } or DT_NOCLIP);
{$ENDIF}
          end
          else
          begin
            if not Assigned(FOnDrawTab) then
              TextOut(TextX, TextY, TAdvTabSheet(FPages[TabIndex]).Caption);
          end;

          if Active then
            Canvas.Font.Assign(self.Font);

          DrawFocusRectangle(Canvas, Rect, Active, 0);
        end;
      end;
    end;
  end;

  if (ActiveTabIndex >= 0) and not Assigned(FOnDrawTab) then
  begin
    tbmp.Canvas.Draw(0, 0, FTabBackGroundActive);
    Rect := OverLapActiveRect;

    if FLowerActive > 0 then
    begin
      case TabPosition of
        tpLeft: BitmapStretch(tbmp, Canvas, Rect.Left + 1, Rect.Top, Rect.Bottom - Rect.Top + 3 + FTabOverlap);
        tpRight: BitmapStretch(tbmp, Canvas, Rect.Left - 3, Rect.Top - 2, Rect.Bottom - Rect.Top + 3 + FTabOverlap);
        tpTop: BitmapStretchInWidth(tbmp, Canvas, Rect.Left - 2, Rect.Top - 1, Rect.Right - Rect.Left + 2 + FTabOverlap);
        tpBottom: BitmapStretchInWidth(tbmp, Canvas, Rect.Left - 2, Rect.Top - 3, Rect.Right - Rect.Left + 2 + FTabOverlap);
      end;
    end
    else
    begin
      case TabPosition of
        tpLeft: BitmapStretch(tbmp, Canvas, Rect.Left { +1}, Rect.Top, Rect.Bottom - Rect.Top + 3 + FTabOverlap);
        tpRight: BitmapStretch(tbmp, Canvas, Rect.Left - 1 {3}, Rect.Top - 2, Rect.Bottom - Rect.Top + 3 + FTabOverlap);
        tpTop: BitmapStretchInWidth(tbmp, Canvas, Rect.Left - 2, Rect.Top - 2 {1}, Rect.Right - Rect.Left + 2 + FTabOverlap);
        tpBottom: BitmapStretchInWidth(tbmp, Canvas, Rect.Left - 2, Rect.Top - 1 {3}, Rect.Right - Rect.Left + 2 + FTabOverlap);
      end;
    end;

    if TAdvTabSheet(FPages[ActiveTabIndex]).ShowClose then
      DrawCloseButton(OverLapActiveRect, true {Active});

    if (Images <> nil) and (TAdvTabSheet(FPages[ActiveTabIndex]).ImageIndex >= 0) then
    begin
      if (TabPosition = tpLeft) then Images.Draw(Canvas, ActiveTabX, ActiveTabY - 14, TAdvTabSheet(FPages[ActiveTabIndex]).ImageIndex)
      else if (TabPosition = tpRight) then Images.Draw(Canvas, ActiveTabX - 14, ActiveTabY, TAdvTabSheet(FPages[ActiveTabIndex]).ImageIndex)
      else Images.Draw(Canvas, ActiveTabX - 2, ActiveTabY, TAdvTabSheet(FPages[ActiveTabIndex]).ImageIndex);
      if (TabPosition = tpLeft) then ActiveTabY := ActiveTabY - Images.Height;
      if (TabPosition = tpRight) then ActiveTabY := ActiveTabY + Images.Height;
      if (TabPosition = tpTop) or (TabPosition = tpBottom) then ActiveTabX := ActiveTabX + Images.width;
    end;


    //------- Displaying text
    with Canvas do
    begin
      Canvas.Brush.Style := bsClear;

      if {Active and }(TabPosition = tpTop) or (TabPosition = tpBottom) then
      begin
        Canvas.Font.Assign(FActiveFont);
      end
      else
      begin
        //Canvas.Font.Assign(Font);
        //Canvas.Font.Color := TAdvTabSheet(FPages[ActiveTabIndex]).TextColor;

        tf := TFont.Create;
        try
          if (TabPosition = tpLeft) or (TabPosition = tpRight) then
          begin
{$IFNDEF TMSDOTNET}
            FillChar(lf, SizeOf(lf), 0);
{$ENDIF}
            tf.Assign(FActiveFont);
{$IFNDEF TMSDOTNET}
            GetObject(tf.Handle, SizeOf(Lf), @Lf);
{$ENDIF}
{$IFDEF TMSDOTNET}
            GetObject(tf.Handle, Marshal.SizeOf(TypeOf(Lf)), Lf);
{$ENDIF}

            if TabPosition = tpLeft then lf.lfEscapement := -2700
            else lf.lfEscapement := -900;
            lf.lfOrientation := 30;

            tf.Handle := CreateFontIndirect(Lf);
            Canvas.Font.Assign(tf);
          end;
        finally
          tf.Free;
        end;

      end;

      if not TAdvTabSheet(FPages[ActiveTabIndex]).Enabled then
        Canvas.Font.Color:= clGrayText;
        
      if (TabPosition = tpTop) or (TabPosition = tpBottom) then
      begin
        TextR := Rect;
        TextR.Left := ActiveTabX;
        if TabPosition = tpBottom then
          TextR.Top := ActiveTabY - 2
        else
          TextR.Top := ActiveTabY;
{$IFNDEF TMSDOTNET}
        DrawText(Handle, PChar(TAdvTabSheet(FPages[ActiveTabIndex]).Caption), Length(TAdvTabSheet(FPages[ActiveTabIndex]).Caption), TextR, DT_LEFT or DT_SINGLELINE {or DT_END_ELLIPSIS} or DT_NOCLIP);
{$ENDIF}
{$IFDEF TMSDOTNET}
        DrawText(Handle, TAdvTabSheet(FPages[ActiveTabIndex]).Caption, Length(TAdvTabSheet(FPages[ActiveTabIndex]).Caption), TextR, DT_LEFT or DT_SINGLELINE {or DT_END_ELLIPSIS} or DT_NOCLIP);
{$ENDIF}
      end
      else
      begin
        Canvas.TextOut(ActiveTabX, ActiveTabY, TAdvTabSheet(FPages[ActiveTabIndex]).Caption);
      end;

      Canvas.Font.Assign(Font);
    end;

    DrawFocusRectangle(Canvas, Rect, True, TabOverlap);

  end;

  if (FHoverTab >= 0) and (FTabHoverBorder <> clNone) and (FHoverTab <> ActivePageIndex) then
  begin
    Rect := TabRectEx(FHoverTab);
    Canvas.Pen.Color := FTabHoverBorder;
    with Canvas do
    begin
      case TabPosition of
        tpLeft:
          begin
            Rect.Left := Rect.Left - 1;
            Rect.Top := Rect.Top - 2;
            if Rect.Bottom > Height - 5 then Rect.Bottom := Rect.Bottom - 1;

            MoveTo(Rect.Right - 1, Rect.Top + 2);
            LineTo(Rect.Left, Rect.Top + 2);
            LineTo(Rect.Left, Rect.Bottom);
            LineTo(Rect.Right, Rect.Bottom);
          end;
        tpRight:
          begin
            Rect.Left := Rect.Left + 1;
            if Rect.Bottom > Height - 5 then Rect.Bottom := Rect.Bottom - 1;
            MoveTo(Rect.Left, Rect.Top);
            LineTo(Rect.Right, Rect.Top);
            LineTo(Rect.Right, Rect.Bottom);
            LineTo(Rect.Left - 1, Rect.Bottom);
          end;
        tpTop:
          begin
            Rect.Top := Rect.Top - 1;
            if Rect.Right > Width - 5 then Rect.Right := Rect.Right - 1;
            MoveTo(Rect.Left, Rect.Bottom - 2);
            LineTo(Rect.Left, Rect.Top);
            LineTo(Rect.Right, Rect.Top);
            LineTo(Rect.Right, Rect.Bottom - 1);
          end;
        tpBottom:
          begin
            if Rect.Right > Width - 5 then Rect.Right := Rect.Right - 1;
            MoveTo(Rect.Left, Rect.Top + 1);
            LineTo(Rect.Left, Rect.Bottom);
            LineTo(Rect.Right, Rect.Bottom);
            LineTo(Rect.Right, Rect.Top);
          end;
      end;
    end;
  end;

  tbmp.Free;
end;

procedure TAdvPageControl.OpenAllClosedTabs;
var
  i: integer;
begin
  for i := 0 to FClosedTabList.Count - 1 do
  begin
    TAdvTabSheet(FClosedTabList.Objects[i]).AdvPageControl := self;
  end;
end;

function TAdvPageControl.OpenClosedTab(TabName: string): Boolean;
var
  i: integer;
begin
  Result := false;
  i := FClosedTabList.IndexOf(TabName);
  if i >= 0 then
  begin
    TAdvTabSheet(FClosedTabList.Objects[i]).AdvPageControl := self;
    Result := true;
  end;
end;

procedure TAdvPageControl.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  HitIndex: Integer;
  HitTestInfo: TTCHitTestInfo;
begin                           
  HitTestInfo.pt := SmallPointToPoint(Message.Pos);
{$IFNDEF TMSDOTNET}
  HitIndex := SendMessage(Handle, TCM_HITTEST, 0, Longint(@HitTestInfo));
{$ENDIF}
{$IFDEF TMSDOTNET}
  HitIndex := SendStructMessage(Handle, TCM_HITTEST, 0, HitTestInfo);
{$ENDIF}
  if (HitIndex >= 0) and (HitIndex <> TabIndex) then Message.Result := 1;
end;

procedure TAdvPageControl.CMDialogChar(var Message: TCMDialogChar);
var
  I: Integer;
  AllowChange: boolean;
begin
  for I := 0 to PageCount - 1 do
    if IsAccel(Message.CharCode, Pages[I].Caption) and CanShowTab(I) and CanFocus then
    begin
      Message.Result := 1;

      AllowChange := true;

      if Assigned(OnCanChange) then
        OnCanChange(Self, ActivePageIndex, I, AllowChange);

      if AllowChange then
      begin
        TabIndex := I;
        Change;
      end;
      Exit;
    end;
  inherited;
end;

procedure TAdvPageControl.CMDialogKey(var Message: TCMDialogKey);
begin
  if (Focused or Windows.IsChild(Handle, Windows.GetFocus)) and
    (Message.CharCode = VK_TAB) and (GetKeyState(VK_CONTROL) < 0) then
  begin
    SelectNextPage(GetKeyState(VK_SHIFT) >= 0);
    Message.Result := 1;
  end else
    inherited;
end;

{$IFNDEF TMSDOTNET}

procedure TAdvPageControl.CMDockClient(var Message: TCMDockClient);
var
  IsVisible: Boolean;
  DockCtl: TControl;
begin
  Message.Result := 0;
  FNewDockSheet := TAdvTabSheet.Create(Self);
  try
    try
      DockCtl := Message.DockSource.Control;
      if DockCtl is TCustomForm then
        FNewDockSheet.Caption := TCustomForm(DockCtl).Caption;
      FNewDockSheet.AdvPageControl := Self;
      DockCtl.Dock(Self, Message.DockSource.DockRect);
    except
      FNewDockSheet.Free;
      raise;
    end;
    IsVisible := DockCtl.Visible;
    FNewDockSheet.TabVisible := IsVisible;
    if IsVisible then ActivePage := FNewDockSheet;
    DockCtl.Align := alClient;
  finally
    FNewDockSheet := nil;
  end;
end;
{$ENDIF}

{$IFDEF TMSDOTNET}

function TAdvPageControl.DockClient(DockSource: TDragDockObject; MousePos: TPoint): Integer;
var
  IsVisible: Boolean;
  DockCtl: TControl;
  I: Integer;
begin
  Result := 0;
  DockCtl := DockSource.Control;
  { First, look and see if the page is already docked. If it is,
    then simply move the page index to the end }
  for I := 0 to PageCount - 1 do
  begin
    if DockCtl.Parent = Pages[I] then
    begin
      { We did find it; just move the page to the end }
      Pages[I].PageIndex := PageCount - 1;
      Exit;
    end;
  end;

  FNewDockSheet := TAdvTabSheet.Create(Self);
  try
    try
      if DockCtl is TCustomForm then
        FNewDockSheet.Caption := TCustomForm(DockCtl).Caption;
      FNewDockSheet.AdvPageControl := Self;
      DockCtl.Dock(Self, DockSource.DockRect);
    except
      FNewDockSheet.Free;
      raise;
    end;
    IsVisible := DockCtl.Visible;
    FNewDockSheet.TabVisible := IsVisible;
    if IsVisible then
      ActivePage := FNewDockSheet;
    DockCtl.Align := alClient;
  finally
    FNewDockSheet := nil;
  end;
end;
{$ENDIF}

procedure TAdvPageControl.CMDockNotification(var Message: TCMDockNotification);
var
  I: Integer;
  S: string;
  Page: TAdvTabSheet;
begin
  Page := GetPageFromDockClient(Message.Client);
  if Page <> nil then
    case Message.NotifyRec.ClientMsg of
      WM_SETTEXT:
        begin
{$IFNDEF TMSDOTNET}
          S := PChar(Message.NotifyRec.MsgLParam);
{$ENDIF}
{$IFDEF TMSDOTNET}
          S := Marshal.PtrToStringAuto(IntPtr(Message.NotifyRec.MsgLParam));
{$ENDIF}
          { Search for first CR/LF and end string there }
          for I := 1 to Length(S) do
            if (S[I] = #13) or (S[I] = #10) then
            begin
              SetLength(S, I - 1);
              Break;
            end;
          Page.Caption := S;
        end;
      CM_VISIBLECHANGED:
        Page.TabVisible := Boolean(Message.NotifyRec.MsgWParam);
    end;
  inherited;
end;

{$IFNDEF TMSDOTNET}

procedure TAdvPageControl.CMUnDockClient(var Message: TCMUnDockClient);
var
  Page: TAdvTabSheet;
begin
  Message.Result := 0;
  Page := GetPageFromDockClient(Message.Client);
  if Page <> nil then
  begin
    FUndockingPage := Page;
    Message.Client.Align := alNone;
  end;
end;
{$ENDIF}

{$IFDEF TMSDOTNET}

function TAdvPageControl.UndockClient(NewTarget, Client: TControl): Boolean;
var
  Page: TAdvTabSheet;
begin
  Result := True;
  Page := GetPageFromDockClient(Client);
  if Page <> nil then
  begin
    FUndockingPage := Page;
    Client.Align := alNone;
  end;
end;
{$ENDIF}

function TAdvPageControl.GetDockClientFromMousePos(MousePos: TPoint): TControl;
var
  i, HitIndex: Integer;
  HitTestInfo: TTCHitTestInfo;
  Page: TAdvTabSheet;
begin
  Result := nil;
  if DockSite then
  begin
    HitTestInfo.pt := MousePos;
{$IFNDEF TMSDOTNET}
    HitIndex := SendMessage(Handle, TCM_HITTEST, 0, Longint(@HitTestInfo));
{$ENDIF}
{$IFDEF TMSDOTNET}
    HitIndex := SendStructMessage(Handle, TCM_HITTEST, 0, HitTestInfo);
{$ENDIF}

    if HitIndex >= 0 then
    begin
      Page := nil;
      for i := 0 to HitIndex do
        Page := FindNextPage(Page, True, True);
      if (Page <> nil) and (Page.ControlCount > 0) then
      begin
        Result := Page.Controls[0];
        if Result.HostDockSite <> Self then Result := nil;
      end;
    end;
  end;
end;

procedure TAdvPageControl.WMLButtonDown(var Message: TWMLButtonDown);
var
  DockCtl: TControl;
begin
  inherited;

  DockCtl := GetDockClientFromMousePos(SmallPointToPoint(Message.Pos));
  if (DockCtl <> nil) and (Style = tsTabs) then DockCtl.BeginDrag(False);
end;

procedure TAdvPageControl.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  DockCtl: TControl;
begin
  inherited;

  DockCtl := GetDockClientFromMousePos(SmallPointToPoint(Message.Pos));
  if DockCtl <> nil then DockCtl.ManualDock(nil, nil, alNone);
end;

function TAdvPageControl.GetActivePageIndex: Integer;
begin
  if ActivePage <> nil then
    Result := ActivePage.GetPageIndex
  else
    Result := -1;
end;

procedure TAdvPageControl.SetActivePageIndex(const Value: Integer);
begin
  if (Value > -1) and (Value < PageCount) then
    ActivePage := Pages[Value]
  else
    ActivePage := nil;
end;

procedure TAdvPageControl.SetDefaultTextColor(const Value: TColor);
var
  i: integer;
begin
  for i := 0 to PageCount - 1 do
  begin
    if TAdvTabSheet(FPages[i]).TextColor = FDefaultTextColor then TAdvTabSheet(FPages[i]).TextColor := Value;
  end;
  FDefaultTextColor := Value;
  Invalidate;
end;

procedure TAdvPageControl.SetDefaultTabColor(const Value: TColor);
var
  i: integer;
begin
  for i := 0 to PageCount - 1 do
  begin
    if TAdvTabSheet(FPages[i]).TabColor = FDefaultTabColor then
      TAdvTabSheet(FPages[i]).TabColor := Value;
  end;
  FDefaultTabColor := Value;
  Invalidate;
end;

procedure TAdvPageControl.SetDefaultTabColorTo(const Value: TColor);
var
  i: integer;
begin
  for i := 0 to PageCount - 1 do
  begin
    if TAdvTabSheet(FPages[i]).TabColorTo = FDefaultTabColorTo then TAdvTabSheet(FPages[i]).TabColorTo := Value;
  end;
  FDefaultTabColorTo := Value;
  Invalidate;
end;

procedure TAdvPageControl.SetActiveColor(const Value: TColor);
begin
  FActiveColor := Value;
  Invalidate;
end;

procedure TAdvPageControl.SetActiveColorTo(const Value: TColor);
begin
  FActiveColorTo := Value;
  Invalidate;
end;

procedure TAdvPageControl.SetTabBorder3D(Value: Boolean);
var
  i: integer;
begin
  if FTabBorder3D <> Value then
  begin
    FTabBorder3D := Value;
    if Value then
    begin
      inherited Images := FImages;
    end
    else
    begin
      inherited Images := FDummyImages;
    end;
    OwnerDraw := not TabBorder3D;

    for i := PageCount - 1 downto 0 do
    begin
      UpdateTab(Pages[I]);
    end;

    if not FTabBorder3D then
      UpdateTabForActiveFont(FActivePage);

    Invalidate;
  end;
end;

procedure TAdvPageControl.SetTabBorderColor(const Value: TColor);
begin
  FTabBorderColor := Value;
  Invalidate;
end;

procedure TAdvPageControl.SetTabSheet3D(Value: Boolean);
begin
  if Value <> FTabSheet3D then
  begin
    FTabSheet3D := Value;
    Invalidate;
  end;
end;

procedure TAdvPageControl.SetTabSheetBorderColor(Value: TColor);
begin
  if Value <> FTabSheetBorderColor then
  begin
    FTabSheetBorderColor := Value;
    Invalidate;
  end;
end;

procedure TAdvPageControl.SetTabBackGroundColor(Value: TColor);
begin
  if Value <> FTabBackGroundColor then
  begin
    FTabBackGroundColor := Value;
    Invalidate;
  end;
end;

procedure TAdvPageControl.SetTabSplitLine(Value: Boolean);
begin
  if Value <> FTabSplitLine then
  begin
    if Value then
      if (TabStyle = tsDotNet) or (TabStyle = tsDelphi) then
        raise exception.Create('TabSplitLine must be false when TabStyle is tsDotNet/tsDelphi');

    FTabSplitLine := Value;
    Invalidate;
  end;
end;

procedure TAdvPageControl.SetRoundEdges(Value: Boolean);
begin
  if Value <> FRoundEdges then
  begin
    FRoundEdges := Value;
    Invalidate;
  end;
end;

procedure TAdvPageControl.SetTabStyle(Value: TTabStyle);
begin
  if Value <> FTabStyle then
  begin
    FTabStyle := Value;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvPageControl.SetLowerActive(Value: integer);
begin
  if Value <> FLowerActive then
  begin
    FLowerActive := Value;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvPageControl.SetTabBackGround(const Value: TBitmap);
begin
  FTabBackGround.Assign(Value);

  if (csDesigning in ComponentState) and Assigned(Value) then
  begin
    if not Value.Empty then
    begin
      if TabPosition in [tpTop, tpBottom] then
        TabHeight := Value.Height - 3
      else
        TabHeight := Value.Width - 3
    end;
  end;
  Invalidate;
end;

procedure TAdvPageControl.SetTabBackGroundActive(const Value: TBitmap);
begin
  FTabBackGroundActive.Assign(Value);
  Invalidate;
end;

procedure TAdvPageControl.SetTabMargins;
var
  ImgW, ImgH: integer;
begin
  if FImages <> nil then
  begin
    ImgW := FImages.Width;
    ImgH := FImages.Height;
  end
  else
  begin
    ImgW := 0;
    ImgH := 0;
  end;

  if TabPosition in [tpLeft, tpRight] then
  begin
    FDummyImages.Height := ImgH + TabMargin.RightMargin + TabMargin.TopMargin;
  end
  else // tpTop, tpBottom
  begin
    FDummyImages.Width := ImgW + TabMargin.RightMargin + TabMargin.LeftMargin;
  end;
end;

function TAdvPageControl.GetTabPosition: TTabPosition;
begin
  Result := inherited TabPosition;
end;

procedure TAdvPageControl.SetTabPosition(Value: TTabPosition);
var
  Img: TCustomImageList;
begin
  Img := nil;
  if FImages <> nil then
  begin
    Img := Fimages;
    Images := nil;
  end;
  inherited TabPosition := Value;
  if Img <> nil then Images := Img;
  SetTabMargins;
end;

procedure TAdvPageControl.SetImages(value: TCustomImageList);
begin
  if FImages <> nil then
  begin
    if TabPosition in [tpTop, tpBottom] then
      FDummyImages.Width := FDummyImages.Width - FImages.Width
    else
      FDummyImages.Height := FDummyImages.Height - FImages.Height;
  end;

  FImages := Value;

  if FImages <> nil then
  begin
    if TabPosition in [tpTop, tpBottom] then
      FDummyImages.Width := FDummyImages.Width + FImages.Width
    else // tpLeft, tpRight
      FDummyImages.Height := FDummyImages.Height + FImages.Height;
  end;

  if FTabBorder3D then
  begin
    inherited Images := FImages;
  end;
  Invalidate;
end;

procedure TAdvPageControl.SetTabMargin(Value: TTabMargin);
begin
  if Assigned(Value) then
    FTabMargin.Assign(Value);
end;

procedure TAdvPageControl.SetTabOverlap(Value: TTabOverlapSize);
begin
  FTabOverlap := Value;
  Invalidate;
end;


procedure TAdvPageControl.SetActiveFont(const Value: TFont);
begin
  FActiveFont.Assign(Value);
  Invalidate;
end;

function TAdvPageControl.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn))) + '.' + IntToStr(Lo(Hiword(vn))) + '.' + IntToStr(Hi(Loword(vn))) + '.' + IntToStr(Lo(Loword(vn)));
end;

procedure TAdvPageControl.SetVersion(const Value: string);
begin
end;

function TAdvPageControl.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER, REL_VER), MakeWord(MIN_VER, MAJ_VER));
end;

procedure TAdvPageControl.ActiveFontChangeEvent(Sender: TObject);
begin
  UpdateTabForActiveFont(FActivePage);
end;

procedure TAdvPageControl.SetCloseGlyph(const Value: TBitmap);
begin
  FCloseGlyph.Assign(Value);
  Invalidate;
end;

procedure TAdvPageControl.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if (csDesigning in ComponentState) or FTabBorder3D or FullRefresh or (Tabs.Count = 0)  or (FUpdateCount > 0) then
    inherited;
end;

procedure TAdvPageControl.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  lCanvas : TCanvas;
begin
  if (csDesigning in ComponentState) or FullRefresh or (Tabs.Count = 0) or (FUpdateCount > 0) then
  begin
    Inherited;
    Exit;
  end;

  if (Message.Msg = WM_PAINT) and (not FTabBorder3D) then
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
//      Perform(WM_ERASEBKGND, MemDC, MemDC);
      Message.DC := MemDC;

      inherited;

      //Create a temporary canvas to draw the tabs on
      lCanvas := TCanvas.Create;
      lCanvas.Handle := MemDC;

      {$IFNDEF DELPHI6_LVL}
      if (TabPosition = tpBottom) then
      begin
        lCanvas.Brush.Color := TAdvTabSheet(Pages[TabIndex]).Color;
        lCanvas.FillRect(ClientRect);
      end;  
      {$ENDIF}

      lCanvas.Font.Assign(Font);

      DrawAllTabs(lCanvas);

      lCanvas.Free;

      Message.DC := 0;
      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end
  else
    inherited;
end;

procedure TAdvPageControl.BeginUpdate;
begin
  if not Visible or (csLoading in ComponentState) then
    Exit;

  Inc(FUpdateCount);
  SendMessage(Handle,WM_SETREDRAW,integer(False),0);
end;

procedure TAdvPageControl.EndUpdate;
begin
  if not Visible then
    Exit;

  if FUpdateCount > 0 then Dec(FUpdateCount);
  if FUpdateCount = 0 then
  begin
    SendMessage(Handle,WM_SETREDRAW,integer(True),0);
    InvalidateRect(Handle, Nil, False);
  end;
end;

procedure TAdvPageControl.CNNotify(var Message: TWMNotify);
begin

  {$IFNDEF TMSDOTNET}
  with Message do
    case NMHdr^.code of
      TCN_SELCHANGE:
        begin
          inherited;
          if MultiLine then
            EndUpdate;
          Exit;
        end;
      TCN_SELCHANGING:
        begin
          if MultiLine then
            BeginUpdate;
          inherited;
          Exit;
        end;
    end;
  {$ENDIF}
  inherited;
end;

procedure TAdvPageControl.CNDrawItem(var Message: TWMDrawItem);
begin

  if (FUpdateCount > 0) then
  begin
    Message.Result := 1;
    Exit;
  end;

  inherited;
end;

procedure TAdvPageControl.SetClosePosition(const Value: TClosePosition);
begin
  if (FClosePosition <> Value) then
  begin
    FClosePosition := Value;
    Invalidate;
  end;
end;


{$IFDEF FREEWARE}
{$I TRIAL.INC}
{$ENDIF}




end.
