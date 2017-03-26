{*************************************************************************}
{ TAdvPanel component                                                     }
{ for Delphi & C++Builder                                                 }
{                                                                         }
{ written by TMS Software                                                 }
{            copyright � 2000-2009                                        }
{            Email : info@tmssoftware.com                                 }
{            Website : http://www.tmssoftware.com/                        }
{                                                                         }
{ The source code is given as is. The author is not responsible           }
{ for any possible damage done due to the use of this code.               }
{ The component can be freely used in any application. The complete       }
{ source code remains property of the author and may not be distributed,  }
{ published, given or sold in any form as such. No parts of the source    }
{ code can be included in any other component or application without      }
{ written authorization of the author.                                    }
{*************************************************************************}

unit AdvPanel;

{$I TMSDEFS.INC}

{$DEFINE REMOVEDRAW}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, AdvStyleIF, ImgList,
  {$IFNDEF TMSDOTNET}
  AdvImage, APXPVS,
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  uxTheme, System.Runtime.InteropServices, System.Text, Types,
  {$ENDIF}
  Inifiles, Registry, PictureContainer
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 8; // Minor version nr.
  REL_VER = 1; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.5.1.0 : added OnMouseLeave, OnMouseEnter events
  // v1.6.0.0 : New StatusBar capability
  //          : New left side vertical oriented caption
  //          : New styler automatic theme color adaption
  //          : New Hover colors for panel caption close/minmax buttons
  //          : New collaps/expand panel from full caption click
  // v1.6.0.1 : Fix for caption visibility with styler
  // v1.6.0.2 : Fix for design time editing of background
  // v1.6.0.3 : Improved paint during scroll of TAdvPanelGroup
  // v1.6.0.4 : Improved paint issue with controls on TAdvPanel in TAdvPanelGroup
  // v1.6.0.5 : Improved painting during scroll
  // v1.6.1.0 : Added property ScrollSmooth to control painting behaviour during scroll
  // v1.6.1.1 : Fixed issue with TAdvPanelStyler and URL hover colors
  // v1.6.1.2 : Fixed issue with painting with XP Manifest
  // v1.7.0.0 : New Style interface added
  //          : New Office 2007 Luna & Obsidian style added
  // v1.7.0.1 : Fixed issue with Panel.Visible on AdvPanelGroup with ScrollSmooth = true
  // v1.7.0.2 : Fixed issue with PanelCount and design time added panels in TAdvPanelGroup
  // v1.7.5.0 : Added mirror gradients for panel background for Office 2007 Luna & Obsidian colors
  // v1.7.5.1 : Fixed issue with hidden controls on panel in panelgroup
  // v1.7.5.2 : Fixed issue with scrollbar on TAdvPanelGroup on non themed Windows
  // v1.7.5.3 : Fixed issue with horiz. mirror gradient
  // v1.7.6.0 : New : support for Office 2007 silver style added
  // v1.7.6.1 : Improved : painting of controls on TAdvPanelGroup
  // v1.7.7.0 : Improved : property ParentShowHint exposed
  // v1.7.7.1 : Fixed : issue with setting AutoSize at design time
  //          : Fixed : issue with persisting collaps state with Styler assigned
  // v1.7.7.2 : Fixed : issue with Indent,TopIndent with Anchors
  // v1.7.7.3 : Fixed : issue with form inheritance for TAdvPanelStyler
  // v1.7.7.4 : Fixed : issue with BorderShadow & collapsed state
  // v1.7.7.5 : Fixed : issue with BeginUpdate/EndUpdate
  // v1.7.7.6 : Fixed : issue with anchor testing on last line in panel
  // v1.7.7.7 : Improved : painting behaviour for resizing panel
  // v1.7.8.0 : Improved : behaviour with hidden controls and panel collaps
  // v1.7.8.1 : Fixed : issue with client control alignment
  // v1.7.8.2 : Improved : handling of sizing with FixedHeight = true or FixedWidth = true
  // v1.7.9.0 : New : added method SetCursor() to set cursor at runtime
  // v1.7.9.1 : Fixed : Issue with DefaultPanel assignment in TAdvPanelGroup
  // v1.7.9.2 : Improved : Painting of container controls on TAdvPanel on TAdvPanelGrouping
  // v1.8.0.0 : New : method AppendPanel added
  // v1.8.0.1 : Improved : HTML tags are automatically stripped on left positioned caption
  // v1.8.1.0 : Improved : scroll handling of TAdvPanelGroup 

type
  {$IFDEF DELPHI_UNICODE}
  THintInfo = Controls.THintInfo;
  PHintInfo = Controls.PHintInfo;
  {$ENDIF}

  TCustomAdvPanel = class;

  TAdvPanelStyler = class;

  TBackGroundPosition = (bpTopLeft,bpTopRight,bpBottomLeft,bpBottomRight,bpTiled,bpStretched,bpCenter);

  TTextVAlignment = (tvaTop,tvaCenter,tvaBottom);

  TAnchorEvent = procedure (Sender:TObject; Anchor:string) of object;

  TPaintEvent = procedure(Sender: TObject; ACanvas: TCanvas; ARect: TRect) of object;

  TAnchorHintEvent = procedure (Sender:TObject;var Anchor:string) of object;

  TPanelPositionLocation = (clRegistry,clInifile);

  TPanelPosition = class(TPersistent)
  private
    FSave: Boolean;
    FKey : string;
    FSection : string;
    {$IFDEF DELPHI4_LVL}
    FLocation: TPanelPositionLocation;
    {$ENDIF}
    FOwner: TComponent;
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Save: Boolean read FSave write FSave default False;
    property Key:string read FKey write FKey;
    property Section:string read FSection write FSection;
    {$IFDEF DELPHI4_LVL}
    property Location:TPanelPositionLocation read FLocation write FLocation default clRegistry;
    {$ENDIF}
  end;

  TShadeType =(	stNormal, stNoise, stDiagShade, stHShade, stVShade, stHBump, stVBump,
                stSoftBump, stHardBump, stLMetal, stRMetal, stIRadial, stORadial,
                stHShadeInv, stVShadeInv, stXPCaption, stBitmap, stBitmapRStretch, stBitmapLStretch);

  TCaptionShape = (csRectangle,csRounded,csSemiRounded);

  TGradientDirection = (gdVertical, gdHorizontal);

  TCaptionButtonPosition = (cbpRight,cbpLeft);

  TCaptionPosition = (cpTop, cpLeft);

  TPanelCaption = class(TPersistent)
  private
    FHeight: integer;
    FText: string;
    FColor: TColor;
    FFont: TFont;
    FVisible: boolean;
    FCloseButton: boolean;
    FMinMaxButton: boolean;
    FMinMaxButtonColor: TColor;
    FCloseButtonColor: TColor;
    FMinGlyph: TBitmap;
    FCloseMinGlyph: TBitmap;
    FCloseMaxGlyph: TBitmap;
    FMaxGlyph: TBitmap;
    FCloseColor: TColor;
    FShadeLight: Integer;
    FShadeGrain: Byte;
    FShadeType: TShadeType;
    FShape: TCaptionShape;
    FFlat: Boolean;
    FBackground: TBitmap;
    FIndent: Integer;
    FTop: Integer;
    FbuttonPosition: TCaptionButtonPosition;
    FColorTo: TColor;
    FOnChange: TNotifyEvent;
    FOnShadeChange: TNotifyEvent;
    FOnStateChange: TNotifyEvent;
    FPosition: TCaptionPosition;
    FMinMaxCaption: Boolean;
    FCloseButtonHoverColor: TColor;
    FMinMaxButtonHoverColor: TColor;
    FOnPositionChange: TNotifyEvent;
    FGradientDirection: TGradientDirection;
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetHeight(const Value: integer);
    procedure SetText(const Value: string);
    procedure SetVisible(const Value: boolean);
    procedure SetCloseButton(const Value: boolean);
    procedure SetMinMaxButton(const Value: boolean);
    procedure SetCloseButtonColor(const Value: TColor);
    procedure SetMinMaxButtonColor(const Value: TColor);
    procedure FontChanged(Sender: TObject);
    procedure SetCloseColor(const Value: TColor);
    procedure SetMaxGlyph(const Value: TBitmap);
    procedure SetMinGlyph(const Value: TBitmap);
    procedure SetCloseMaxGlyph(const Value: TBitmap);
    procedure SetCloseMinGlyph(const Value: TBitmap);
    procedure SetShadeLight(const Value: Integer);
    procedure SetShadeGrain(const Value: Byte);
    procedure SetShadeType(const Value: TShadeType);
    procedure SetCaptionShape(const Value: TCaptionShape);
    procedure SetFlat(const Value: Boolean);
    procedure SetBackground(const Value: TBitmap);
    procedure SetIndent(const Value: Integer);
    procedure SetTopIndent(const Value: Integer);
    procedure SetColorTo(const Value: TColor);
    procedure Changed;
    procedure StateChanged;
    procedure ShadeChanged;
    procedure SetPosition(const Value: TCaptionPosition);
    procedure SetMinMaxCaption(const Value: Boolean);
    procedure SetGradientDirection(const Value: TGradientDirection);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Background: TBitmap read FBackground write SetBackground;
    property ButtonPosition: TCaptionButtonPosition read FbuttonPosition write FButtonPosition default cbpRight;
    property Color: TColor read FColor write SetColor default clNone;
    property ColorTo: TColor read FColorTo write SetColorTo default clHighLight;
    property CloseColor: TColor read FCloseColor write SetCloseColor default clBtnFace;
    property CloseButton: Boolean read fCloseButton write SetCloseButton default False;
    property CloseButtonColor: TColor read fCloseButtonColor write SetCloseButtonColor default clWhite;
    property CloseButtonHoverColor: TColor read FCloseButtonHoverColor write FCloseButtonHoverColor default clNone;
    property CloseMinGlyph: TBitmap read FCloseMinGlyph write SetCloseMinGlyph;
    property CloseMaxGlyph: TBitmap read FCloseMaxGlyph write SetCloseMaxGlyph;
    property Flat: Boolean read FFlat write SetFlat default False;
    property Font: TFont read FFont write SetFont;
    property GradientDirection: TGradientDirection read FGradientDirection write SetGradientDirection default gdHorizontal;    
    property Height: Integer read FHeight write SetHeight default 20;
    property Indent: Integer read FIndent write SetIndent default 0;
    property MaxGlyph: TBitmap read FMaxGlyph write SetMaxGlyph;
    property MinGlyph: TBitmap read FMinGlyph write SetMinGlyph;
    property MinMaxButton: Boolean read FMinMaxButton write SetMinMaxButton default False;
    property MinMaxButtonColor: TColor read FMinMaxButtonColor write SetMinMaxButtonColor default clWhite;
    property MinMaxButtonHoverColor: TColor read FMinMaxButtonHoverColor write FMinMaxButtonHoverColor default clNone;
    property MinMaxCaption: Boolean read FMinMaxCaption write SetMinMaxCaption default False;
    property Position: TCaptionPosition read FPosition write SetPosition default cpTop;
    property ShadeLight: Integer read FShadeLight write SetShadeLight default 200;
    property ShadeGrain: Byte read FShadeGrain write SetShadeGrain default 32;
    property ShadeType: TShadeType read FShadeType write SetShadeType default stNormal;
    property Shape: TCaptionShape read FShape write SetCaptionShape default csRectangle;
    property Text: string read FText write SetText;
    property TopIndent: Integer read FTop write SetTopIndent default 0;
    property Visible: Boolean read FVisible write SetVisible default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnStateChange: TNotifyEvent read FOnStateChange write FOnStateChange;
    property OnShadeChange: TNotifyEvent read FOnShadeChange write FOnShadeChange;
    property OnPositionChange: TNotifyEvent read FOnPositionChange write FOnPositionChange;
  end;

  TPanelStatusBar = class(TPersistent)
  private
    FImageIndex: integer;
    FText: string;
    FColor: TColor;
    FColorTo: TColor;
    FGradientDirection: TGradientDirection;
    FVisible: Boolean;
    FHeight: Integer;
    FOnChange: TNotifyEvent;
    FBevelInner: Boolean;
    FFont: TFont;
    FBorderStyle: TBorderStyle;
    FBorderColor: TColor;
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientDirection(const Value: TGradientDirection);
    procedure SetImageIndex(const Value: integer);
    procedure SetText(const Value: string);
    procedure SetHeight(const Value: Integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetBevelInner(const Value: Boolean);
    procedure FontChanged(Sender: TObject);
    procedure SetFont(const Value: TFont);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderStyle(const Value: TBorderStyle);
  protected
    procedure Changed;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property BevelInner: Boolean read FBevelInner write SetBevelInner default false;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsNone;
    property ImageIndex: integer read FImageIndex write SetImageIndex default -1;
    property Font: TFont read FFont write SetFont;
    property Text: string read FText write SetText;
    property Color: TColor read FColor write SetColor default clBtnFace;  // background start color
    property ColorTo: TColor read FColorTo write SetColorTo default clNone; // background end color, default clNone = solid color
    property GradientDirection: TGradientDirection read FGradientDirection write SetGradientDirection default gdHorizontal;
    property Height: Integer read FHeight write SetHeight default 18;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

  TAutoSize = class(TPersistent)
  private
    FOwner: TCustomAdvPanel;
    FHeight: Boolean;
    FWidth: Boolean;
    FEnabled: Boolean;
    procedure SetEnabled(const Value: Boolean);
  public
    constructor Create(AOwner: TCustomAdvPanel);
    procedure Assign(Source: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property Height: Boolean read FHeight write FHeight default True;
    property Width: Boolean read FWidth write FWidth default True;
  end;

  TAdvPanelSettings = class(TPersistent)
  private
    FFixedHeight: Boolean;
    FCanMove: Boolean;
    FFixedWidth: Boolean;
    FHover: Boolean;
    FAutoHideChildren: Boolean;
    FAnchorHint: Boolean;
    FFixedLeft: Boolean;
    FCanSize: Boolean;
    FShowHint: Boolean;
    FFixedTop: Boolean;
    FCollaps: Boolean;
    FShowMoveCursor: Boolean;
    FCollapsDelay: Integer;
    FBevelWidth: Integer;
    FCollapsSteps: Integer;
    FHeight: Integer;
    FShadowOffset: Integer;
    FText: string;
    FHint: string;
    FBevelOuter: TBevelCut;
    FBevelInner: TBevelCut;
    FHoverColor: TColor;
    FCollapsColor: TColor;
    FBorderColor: TColor;
    FHoverFontColor: TColor;
    FShadowColor: TColor;
    FColor: TColor;
    FColorTo: TColor;
    FColorMirror: TColor;
    FColorMirrorTo: TColor;
    FURLColor: TColor;
    FFont: TFont;
    FCaption: TPanelCaption;
    FPosition: TPanelPosition;
    FTextVAlign: TTextVAlignment;
    FBorderStyle: TBorderStyle;
    FCursor: TCursor;
    FBorderShadow: Boolean;
    FIndent: Integer;
    FTopIndent: Integer;
    FOnChange: TNotifyEvent;
    FWidth: Integer;
    FUpdateCount: Integer;
    FBorderWidth: Integer;
    FStatusBar: TPanelStatusBar;
    procedure SetBorderColor(const Value: TColor);
    procedure SetCaption(const Value: TPanelCaption);
    procedure SetCollaps(const Value: Boolean);
    procedure SetFont(const Value: TFont);
    procedure SetBorderShadow(const Value: Boolean);
    procedure CaptionChanged(Sender: TObject);
    procedure Changed;
    procedure SetAnchorHint(const Value: Boolean);
    procedure SetAutoHideChildren(const Value: Boolean);
    procedure SetBevelInner(const Value: TBevelCut);
    procedure SetBevelOuter(const Value: TBevelCut);
    procedure SetBevelWidth(const Value: Integer);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetCanMove(const Value: Boolean);
    procedure SetCanSize(const Value: Boolean);
    procedure SetCollapsColor(const Value: TColor);
    procedure SetCollapsDelay(const Value: Integer);
    procedure SetCollapsSteps(const Value: Integer);
    procedure SetColorTo(const Value: TColor);
    procedure SetColorMirror(const Value: TColor);
    procedure SetColorMirrorTo(const Value: TColor);
    procedure SetCursor(const Value: TCursor);
    procedure SetHover(const Value: Boolean);
    procedure SetHoverColor(const Value: TColor);
    procedure SetHoverFontColor(const Value: TColor);
    procedure SetIndent(const Value: Integer);
    procedure SetText(const Value: string);
    procedure SetTextVAlign(const Value: TTextVAlignment);
    procedure SetTopIndent(const Value: Integer);
    procedure SetURLColor(const Value: TColor);
    procedure SetBorderWidth(const Value: Integer);
    procedure SetStatusBar(const Value: TPanelStatusBar);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
  published
    property AnchorHint: Boolean read FAnchorHint write SetAnchorHint;
    property AutoHideChildren: Boolean read FAutoHideChildren write SetAutoHideChildren default true;
    property BevelInner: TBevelCut read FBevelInner write SetBevelInner;
    property BevelOuter: TBevelCut read FBevelOuter write SetBevelOuter;
    property BevelWidth: Integer read FBevelWidth write SetBevelWidth;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property BorderShadow: Boolean read FBorderShadow write SetBorderShadow;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;
    property CanMove: Boolean read FCanMove write SetCanMove;
    property CanSize: Boolean read FCanSize write SetCanSize;
    property Caption:TPanelCaption read FCaption write SetCaption;
    property Collaps: Boolean read FCollaps write SetCollaps;
    property CollapsColor: TColor read FCollapsColor write SetCollapsColor;
    property CollapsDelay: Integer read FCollapsDelay write SetCollapsDelay;
    property CollapsSteps: Integer read FCollapsSteps write SetCollapsSteps;
    property Color: TColor read FColor write FColor;
    property ColorTo: TColor read FColorTo write SetColorTo;
    property ColorMirror: TColor read FColorMirror write SetColorMirror;
    property ColorMirrorTo: TColor read FColorMirrorTo write SetColorMirrorTo;
    property Cursor: TCursor read FCursor write SetCursor;
    property Font: TFont read FFont write SetFont;
    property FixedTop: Boolean read FFixedTop write FFixedTop;
    property FixedLeft: Boolean read FFixedLeft write FFixedLeft;
    property FixedHeight: Boolean read FFixedHeight write FFixedHeight;
    property FixedWidth: Boolean read FFixedWidth write FFixedWidth;
    property Height: Integer read FHeight write FHeight;
    property Hint: string read FHint write FHint;
    property Hover: Boolean read FHover write SetHover;
    property HoverColor: TColor read FHoverColor write SetHoverColor;
    property HoverFontColor: TColor read FHoverFontColor write SetHoverFontColor;
    property Indent: Integer read FIndent write SetIndent;
    property Position: TPanelPosition read FPosition write FPosition;
    property ShadowColor: TColor read FShadowColor write FShadowColor;
    property ShadowOffset: Integer read FShadowOffset write FShadowOffset;
    property ShowHint: Boolean read FShowHint write FShowHint;
    property ShowMoveCursor: Boolean read FShowMoveCursor write FShowMoveCursor;
    property StatusBar: TPanelStatusBar read FStatusBar write SetStatusBar;
    property Text:string read FText write SetText;
    property TextVAlign: TTextVAlignment read FTextVAlign write SetTextVAlign;
    property TopIndent: Integer read FTopIndent write SetTopIndent;
    property URLColor: TColor read FURLColor write SetURLColor;
    property Width: Integer read FWidth write FWidth;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TCustomAdvPanel = class(TCustomPanel)
  private
    FText: string;
    {$IFNDEF TMSDOTNET}
    FImage:TAdvImage;
    {$ENDIF}
    FBackgroundPosition: TBackgroundPosition;
    FCaption: TPanelCaption;
    FImages: TCustomImageList;
    FURLColor: TColor;
    FOldColor: TColor;
    FCollaps: Boolean;
    FFullHeight: Integer;
    FAnchor: string;
    FHoverHyperLink: integer;
    FOldHoverHyperLink: integer;
    FCaptionHoverHyperLink: integer;
    FCurrHoverRect: trect;
    FCaptionCurrHoverRect: trect;
    FAnchorHint: boolean;
    FAnchorExit: TAnchorEvent;
    FAnchorClick: TAnchorEvent;
    FAnchorEnter: TAnchorEvent;
    FHover: boolean;
    FHoverColor: TColor;
    FHoverFontColor: TColor;
    FShadowOffset: Integer;
    FShadowColor: TColor;
    FCanSize: Boolean;
    FCanMove: Boolean;
    FShowSizeMoveGrip : boolean;
    FTextVAlign: TTextVAlignment;
    FOnAnchorHint: TAnchorHintEvent;
    FOnClose: TNotifyEvent;
    FOnMinimize: TNotifyEvent;
    FOnMaximize: TNotifyEvent;
    FPosition: TPanelPosition;
    FOnCaptionClick: TNotifyEvent;
    FFixedHeight: Boolean;
    FFixedLeft: Boolean;
    FFixedWidth: Boolean;
    FFixedTop: Boolean;
    FTopLeft: TPoint;
    FWidthHeight: TPoint;
    FOnEndMoveSize: TNotifyEvent;
    FOldCursor: TCursor;
    FInMove: Boolean;
    FContainer: TPictureContainer;
    FImageCache: THTMLPictureCache;
    FShowMoveCursor: Boolean;
    FShadedHeader: TBitmap;
    FIsWinXP: Boolean;
    FFreeOnClose: Boolean;
    FIsCollapsing: Boolean;
    FOnCaptionDblClick: TNotifyEvent;
    FCollapsDelay: Integer;
    FCollapsSteps: Integer;
    FCollapsColor: TColor;
    FAutoSize: TAutoSize;
    FAutoHideChildren: Boolean;
    FCanUpdate: Boolean;
    FColorTo: TColor;
    FBorderColor: TColor;
    FIndex: Integer;
    FBuffered: Boolean;
    FBorderShadow: Boolean;
    FIndent: Integer;
    FTopIndent: Integer;
    FLineSpacing: Integer;
    FEllipsis: Boolean;
    FStyler: TAdvPanelStyler;
    FOnEndCollapsExpand: TNotifyEvent;
    FOldWidth, FOldHeight: Integer;
    FOnPaint: TPaintEvent;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FGradientDirection: TGradientDirection;
    FHoverCloseBtn: Boolean;
    FHoverMinMaxBtn: Boolean;
    FStatusBar: TPanelStatusBar;
    FColorMirror: TColor;
    FColorMirrorTo: TColor;
    FOptimizePaint: boolean;
    FHideList: TList;
    procedure OnStatusBarChange(Sender: TObject);
    procedure SetText(const Value: string);
    procedure SetBackgroundPosition(const Value: TBackgroundPosition);
    {$IFNDEF TMSDOTNET}
    procedure SetImage(const Value: TAdvImage);
    {$ENDIF}
    procedure BackgroundChanged(sender: TObject);
    procedure SetCaption(const Value: TPanelCaption);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetURLColor(const Value: TColor);
    procedure SetCollaps(const Value: boolean);
    procedure SetGradientDirection(const Value: TGradientDirection);
    function GetHeightEx: integer;
    procedure SetHeightEx(const Value: integer);
    function IsAnchor(x,y:integer;var hoverrect:TRect):string;
    procedure SetHover(const Value: boolean);
    {$IFNDEF TMSDOTNET}
    procedure CMHintShow(Var Msg: TMessage); message CM_HINTSHOW;
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$ENDIF}
    procedure CMMouseLeave(Var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(Var Msg: TMessage); message CM_MOUSEENTER;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    {$IFNDEF TMSDOTNET}
    procedure WMEraseBkGnd(var Message:TMessage); message WM_ERASEBKGND;
    procedure WMSizing(var Msg: TMessage); message WM_SIZING;
    procedure WMSize(var Msg: TMessage); message WM_SIZE;
    procedure WMMoving(var Msg: TMessage); message WM_MOVING;
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    {$ENDIF}
    procedure WMEnterSizeMove(var Msg: TMessage); message WM_ENTERSIZEMOVE;
    procedure WMExitSizeMove(var Msg: TMessage); message WM_EXITSIZEMOVE;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMLDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMPaint(var Msg: TWMPAINT); message WM_PAINT;
    procedure SetShadowColor(const Value: TColor);
    procedure SetShadowOffset(const Value: integer);
    procedure SetCanSize(const Value: boolean);
    procedure SetTextVAlign(const Value: TTextVAlignment);
    procedure ShowHideChildren(Show: Boolean);
    procedure SetAutoSizeEx(const Value: TAutoSize);
    procedure SetColorTo(const Value: TColor);
    procedure SetColorMirror(const Value: TColor);
    procedure SetColorMirrorTo(const Value: TColor);    
    procedure SetEllipsis(const Value: boolean);
    procedure SetBorderColor(const Value: TColor);
    procedure SetIndex(const Value: Integer);
    procedure CaptionChange(Sender: TObject);
    procedure CaptionStateChange(Sender: TObject);
    procedure CaptionShadeChange(Sender: TObject);
    procedure CaptionPositionChange(Sender: TObject);
    procedure SetBorderShadow(const Value: Boolean);
    procedure SetIndent(const Value: Integer);
    procedure SetTopIndent(const Value: Integer);
    procedure SetLineSpacing(const Value: Integer);
    function GetRawText: string;
    function GetVersionComp: string;
    procedure SetVersion(const Value: string);
    function GetVersionNr: Integer;
    procedure SetStatusBar(Value: TPanelStatusBar);
    function GetWidthEx: Integer;
    procedure SetWidthEx(Value: Integer);
    { Private declarations }
  protected
    { Protected declarations }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SetStyler(const Value: TAdvPanelStyler); virtual;
    procedure AssignStyle(Settings: TAdvPanelSettings); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function DoVisualStyles: Boolean;
    procedure Paint; override;
    procedure Resize; override;
    procedure DrawCaptionBkg(Canvas: TCanvas;r: TRect);
    procedure ShadeHeader; virtual;
    procedure WndProc(var Message: TMessage); override;
    procedure CreateWnd; override;
    procedure DefineProperties(Filer: TFiler);override;
    procedure StoreFullHeight(Writer: TWriter);
    procedure LoadFullHeight(Reader: TReader);
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure DoAutoSize;
    procedure StateChange; virtual;
    procedure AssignSettings(Settings: TAdvPanelSettings);

    procedure ChangeScale(M,D: integer); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Assign(Source: TPersistent); override;
    procedure LoadPosition;
    procedure SavePosition;
    procedure Synchronize;
    procedure SetCursor(ACursor: TCursor); 
    
    procedure BeginUpdate;
    procedure EndUpdate;

    property OptimizePaint: boolean read FOptimizePaint write FOptimizePaint;

    property FullHeight: Integer read FFullHeight write FFullHeight;
    property Index: Integer read FIndex write SetIndex;
  // properties to make published
    property AnchorHint: Boolean read FAnchorHint write FAnchorHint default False;
    property AutoSize: TAutoSize read FAutoSize write SetAutoSizeEx;
    property AutoHideChildren: Boolean read FAutoHideChildren write FAutoHideChildren default True;
    {$IFNDEF TMSDOTNET}
    property Background: TAdvImage read FImage write SetImage;
    {$ENDIF}
    property BackgroundPosition: TBackgroundPosition read FBackgroundPosition write SetBackgroundPosition default bpTopLeft;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property BorderShadow: Boolean read FBorderShadow write SetBorderShadow default False;
    property Buffered: Boolean read FBuffered write FBuffered default True;
    property CanMove: Boolean read FCanMove write FCanMove default False;
    property CanSize: Boolean read FCanSize write SetCanSize default False;
    property ShowSizeMoveGrip: Boolean read FShowSizeMoveGrip write FShowSizeMoveGrip default True;
    property Caption:TPanelCaption read fCaption write SetCaption;
    property Collaps: Boolean read FCollaps write SetCollaps default False;
    property CollapsColor: TColor read FCollapsColor write FCollapsColor default clGray;
    property CollapsDelay: Integer read FCollapsDelay write FCollapsDelay default 20;
    property CollapsSteps: Integer read FCollapsSteps write FCollapsSteps default 0;
    property ColorTo: TColor read FColorTo write SetColorTo default clNone;
    property ColorMirror: TColor read FColorMirror write SetColorMirror default clNone;
    property ColorMirrorTo: TColor read FColorMirrorTo write SetColorMirrorTo default clNone;
    property GradientDirection: TGradientDirection read FGradientDirection write SetGradientDirection default gdVertical;
    property Ellipsis: Boolean read FEllipsis write SetEllipsis default False;
    property FixedTop: Boolean read FFixedTop write FFixedTop default False;
    property FixedLeft: Boolean read FFixedLeft write FFixedLeft default False;
    property FixedHeight: Boolean read FFixedHeight write FFixedHeight default False;
    property FixedWidth: Boolean read FFixedWidth write FFixedWidth default False;
    property FreeOnClose: Boolean read FFreeOnClose write FFreeOnClose default False;
    property Height: Integer read GetHeightEx write SetHeightEx;
    property Hover: Boolean read FHover write SetHover default False;
    property HoverColor: TColor read FHoverColor write FHoverColor default clNone;
    property HoverFontColor: TColor read FHoverFontColor write fHoverFontColor default clNone;
    property Images: TCustomImageList read FImages write SetImages;
    property Indent: Integer read FIndent write SetIndent default 0;
    property LineSpacing: Integer read FLineSpacing write SetLineSpacing default 0;
    property PictureContainer: TPictureContainer read FContainer write FContainer;
    property Position: TPanelPosition read FPosition write FPosition;
    property ShadowColor: TColor read FShadowColor write SetShadowColor default clGray;
    property ShadowOffset: Integer read FShadowOffset write SetShadowOffset default 2;
    property ShowMoveCursor: Boolean read FShowMoveCursor write FShowMoveCursor default False;
    property StatusBar: TPanelStatusBar read FStatusBar write SetStatusBar;
    property Styler: TAdvPanelStyler read FStyler write SetStyler;
    property Width: Integer read GetWidthEx write SetWidthEx;
    property RawText: string read GetRawText;
    property Text:string read FText write SetText;
    property TextVAlign: TTextVAlignment read FTextVAlign write SetTextVAlign default tvaTop;
    property TopIndent: Integer read FTopIndent write SetTopIndent default 0;
    property URLColor: TColor read FURLColor write SetURLColor default clBlue;
    property OnCaptionClick: TNotifyEvent read FOnCaptionClick write FOnCaptionClick;
    property OnCaptionDBlClick: TNotifyEvent read FOnCaptionDblClick write FOnCaptionDblClick;
    property OnAnchorClick:TAnchorEvent read FAnchorClick write FAnchorClick;
    property OnAnchorEnter:TAnchorEvent read FAnchorEnter write FAnchorEnter;
    property OnAnchorExit:TAnchorEvent read FAnchorExit write FAnchorExit;
    property OnAnchorHint:TAnchorHintEvent read FOnAnchorHint write FOnAnchorHint;
    property OnClose: TNotifyEvent read fOnClose write fOnClose;
    property OnEndMoveSize: TNotifyEvent read FOnEndMoveSize write FOnEndMoveSize;
    property OnMinimize: TNotifyEvent read FOnMinimize write FOnMinimize;
    property OnMaximize: TNotifyEvent read FOnMaximize write FOnMaximize;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnEndCollapsExpand: TNotifyEvent read FOnEndCollapsExpand write FOnEndCollapsExpand;
  published
     property Align;
    {$IFDEF DELPHI4_LVL}
    property Anchors;
    {$ENDIF}
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderStyle;
    property Color;
    {$IFDEF DELPHI4_LVL}
    property Constraints;
    {$ENDIF}
    property Cursor;
    {$IFDEF DELPHI4_LVL}
    property DockSite;
    {$ENDIF}
    property DragCursor;
    {$IFDEF DELPHI4_LVL}
    property DragKind;
    {$ENDIF}
    property DragMode;
    property Enabled;
    property Font;
    property HelpContext;
    property Hint;
    property Locked;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Tag;
    {$IFDEF DELPHI4_LVL}
    property UseDockManager;
    {$ENDIF}
    property Visible;

    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
//    property OnKeyPress;
//    property OnKeyDown;
//    property OnKeyUp;

    {$IFDEF DELPHI4_LVL}
    property OnConstrainedResize;
    {$ENDIF}
    {$IFDEF DELPHI5_LVL}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    {$IFDEF DELPHI4_LVL}
    property OnDockDrop;
    property OnDockOver;
    {$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    {$IFDEF DELPHI4_LVL}
    property OnEndDock;
    {$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    {$IFDEF DELPHI4_LVL}
    property OnGetSiteInfo;
    {$ENDIF}
    {$IFDEF DELPHI4_LVL}
    property OnCanResize;
    {$ENDIF}
    property OnClick;
    property OnResize;
    {$IFDEF DELPHI4_LVL}
    property OnStartDock;
    {$ENDIF}
    property OnStartDrag;
    {$IFDEF DELPHI4_LVL}
    property OnUnDock;
    {$ENDIF}
    property Version: string read GetVersionComp write SetVersion;
    property OnPaint: TPaintEvent read FOnPaint write FOnPaint;
  end;

  TAdvPanel = class(TCustomAdvPanel)
  published
    property AnchorHint;
    property AutoSize;
    property AutoHideChildren;
    {$IFNDEF TMSDOTNET}
    property Background;
    {$ENDIF}
    property BackgroundPosition;
    property BorderColor;
    property BorderShadow;
    property BorderWidth;
    property Buffered;
    property CanMove;
    property CanSize;
    property Caption;
    property Collaps;
    property CollapsColor;
    property CollapsDelay;
    property CollapsSteps;
    property ColorTo;
    property ColorMirror;
    property ColorMirrorTo;
    property Ellipsis;
    property FixedTop;
    property FixedLeft;
    property FixedHeight;
    property FixedWidth;
    property FreeOnClose;
    property GradientDirection;
    property Height;
    property Hover;
    property HoverColor;
    property HoverFontColor;
    property Images;
    property Indent;
    property LineSpacing;
    property ParentShowHint;
    property PictureContainer;
    property Position;
    property ShadowColor;
    property ShadowOffset;
    property ShowMoveCursor;
    property StatusBar;
    property Styler;
    property Text;
    property TextVAlign;
    property TopIndent;
    property URLColor;
    property Width;    
    property OnCaptionClick;
    property OnCaptionDBlClick;
    property OnAnchorClick;
    property OnAnchorEnter;
    property OnAnchorExit;
    property OnAnchorHint;
    property OnClose;
    property OnEndMoveSize;
    property OnMinimize;
    property OnMaximize;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnEndCollapsExpand;
    property OnPaint;
  end;

  TGroupStyle = (gsVertical, gsHorizontal);

  TAdvPanelGroup = class(TAdvPanel)
  private
    FUpdateCount: Integer;
    FHorzPadding: Integer;
    FVertPadding: Integer;
    FGroupStyle: TGroupStyle;
    FIsArranging: Boolean;
    FScrollBar: TScrollBar;
    FPanels: TList;
    FDefaultPanel: TAdvPanelSettings;
    FColumns: Integer;
    FCode: Boolean;
    FScrollSmooth: Boolean;
    FOldWidth, FOldHeight: integer;
    {$IFNDEF TMSDOTNET}
    procedure WMSize(var Msg: TMessage); message WM_SIZE;
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    {$ENDIF}
    procedure SetHorzPadding(const Value: Integer);
    procedure SetVertPadding(const Value: Integer);
    procedure SetGroupStyle(const Value: TGroupStyle);
    function GetPanel(Index: Integer): TCustomAdvPanel;
    procedure SetPanel(Index: Integer; const Value: TCustomAdvPanel);
    procedure SetDefaultPanel(const Value: TAdvPanelSettings);
    procedure SetColumns(const Value: Integer);
    function GetPanelCount: Integer;
  protected
    procedure ArrangeControlsVert;
    procedure ArrangeControlsHorz;
    procedure ArrangeControls;
    procedure Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    function PanelHeights: Integer;
    function PanelWidths: Integer;
    procedure UpdateScrollbar;
    procedure StateChange; override;
    {$IFDEF DELPHI5_LVL}
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    {$ENDIF}
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure ChildPanelChanged(APanel: TCustomAdvPanel);
    property IsArranging: Boolean read FIsArranging;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure OpenAllPanels;
    procedure CloseAllPanels;
    procedure SavePanelPositions;
    procedure LoadPanelPositions;
    procedure UpdateGroup;
    procedure Clear;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure InitPanels;
    function AddPanel: TCustomAdvPanel;
    function AppendPanel: TCustomAdvPanel;
    function InsertPanel(Index: Integer): TCustomAdvPanel;
    procedure RemovePanel(Index: Integer);
    procedure MovePanel(FromIndex,ToIndex: Integer);
    property Panels[Index: Integer]: TCustomAdvPanel read GetPanel write SetPanel;
    property PanelCount: Integer read GetPanelCount;
  published
    property Columns: Integer read FColumns write SetColumns;
    property DefaultPanel: TAdvPanelSettings read FDefaultPanel write SetDefaultPanel;
    property GroupStyle: TGroupStyle read FGroupStyle write SetGroupStyle;
    property ScrollSmooth: boolean read FScrollSmooth write FScrollSmooth default false;
    property HorzPadding: Integer read FHorzPadding write SetHorzPadding;
    property VertPadding: Integer read FVertPadding write SetVertPadding;

  end;

  TAdvPanelStyle = (psXP, psFlat, psTMS, psClassic, psOffice2003Blue, psOffice2003Olive, psOffice2003Silver, psOffice2003Classic, psOffice2007Luna, psOffice2007Obsidian, psWhidbey, psWindowsXP, psCustom, psOffice2007Silver);

  TThemeNotifierWindow = class(TWinControl)
  private
    FOnThemeChange: TNotifyEvent;
  protected
    procedure WndProc(var Msg: TMessage); override;
  published
    property OnThemeChange: TNotifyEvent read FOnThemeChange write FOnThemeChange;
  end;

  TAdvPanelStyler = class(TComponent, ITMSStyle)
  private
    FSettings: TAdvPanelSettings;
    FComments: string;
    FTag: Integer;
    FNotifierWnd: TThemeNotifierWindow;
    FStyle: TAdvPanelStyle;
    FAutoThemeAdapt: boolean;
    procedure SetSettings(const Value: TAdvPanelSettings);
    procedure SetStyle(const Value: TAdvPanelStyle);
  protected
    procedure ThemeChanged(Sender: TObject);
    procedure Changed(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Loaded; override;
    procedure SetComponentStyle(AStyle: TTMSStyle);
  published
    property AutoThemeAdapt: boolean read FAutoThemeAdapt write FAutoThemeAdapt default False;
    property Settings: TAdvPanelSettings read FSettings write SetSettings;
    property Comments: string read FComments write FComments;
    property Style: TAdvPanelStyle read FStyle write SetStyle default psXP;
    {$IFNDEF TMSDOTNET}
    property Tag: Integer read FTag write FTag;
    {$ENDIF}
  end;

implementation

uses
  ShellApi, Commctrl, Math;

{$I HTMLENGO.PAS}

const
  // theme changed notifier
  WM_THEMECHANGED = $031A;

type
  XPColorScheme = (xpNone, xpBlue, xpGreen, xpGray);

{$IFNDEF TMSDOTNET}
var
  GetCurrentThemeName: function(pszThemeFileName: PWideChar;
    cchMaxNameChars: Integer;
    pszColorBuff: PWideChar;
    cchMaxColorChars: Integer;
    pszSizeBuff: PWideChar;
    cchMaxSizeChars: Integer): THandle cdecl stdcall;

//  IsThemeActive: function: BOOL cdecl stdcall;
{$ENDIF}


function IsWinXP: Boolean;
var
  VerInfo: TOSVersioninfo;
begin
{$IFNDEF TMSDOTNET}
  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
{$ENDIF}
{$IFDEF TMSDOTNET}
  VerInfo.dwOSVersionInfoSize := Marshal.SizeOf(TypeOf(OSVersionInfo));
{$ENDIF}
  GetVersionEx(verinfo);
  Result := (verinfo.dwMajorVersion > 5) OR
    ((verinfo.dwMajorVersion = 5) AND (verinfo.dwMinorVersion >= 1));
end;

{$IFDEF TMSDOTNET}
function CurrentXPTheme: XPColorScheme;
var
  FileName, ColorScheme, SizeName: StringBuilder;
begin
  Result := xpNone;

  if IsWinXP then
  begin
    if IsThemeActive then
    begin
      FileName := StringBuilder.Create(255);
      SizeName := StringBuilder.Create(255);
      ColorScheme := StringBuilder.Create(255);
      GetCurrentThemeName(FileName, 255, ColorScheme, 255, SizeName, 255);
      if(ColorScheme.ToString = 'NormalColor') then
        Result := xpBlue
      else if (ColorScheme.ToString = 'HomeStead') then
        Result := xpGreen
      else if (ColorScheme.ToString = 'Metallic') then
        Result := xpGray
    end;
  end;
end;
{$ENDIF}

{$IFNDEF TMSDOTNET}
function CurrentXPTheme: XPColorScheme;
var
  FileName, ColorScheme, SizeName: WideString;
  hThemeLib: THandle;
begin
  hThemeLib := 0;
  Result := xpNone;

  if not IsWinXP then
    Exit;

  try
    hThemeLib := LoadLibrary('uxtheme.dll');

    if hThemeLib > 0 then
    begin
      IsThemeActive := GetProcAddress(hThemeLib,'IsThemeActive');

      if Assigned(IsThemeActive) then
        if IsThemeActive then
        begin
          GetCurrentThemeName := GetProcAddress(hThemeLib,'GetCurrentThemeName');
          if Assigned(GetCurrentThemeName) then
          begin
            SetLength(FileName, 255);
            SetLength(ColorScheme, 255);
            SetLength(SizeName, 255);
            GetCurrentThemeName(PWideChar(FileName), 255,
              PWideChar(ColorScheme), 255, PWideChar(SizeName), 255);
            if (PWideChar(ColorScheme) = 'NormalColor') then
              Result := xpBlue
            else if (PWideChar(ColorScheme) = 'HomeStead') then
              Result := xpGreen
            else if (PWideChar(ColorScheme) = 'Metallic') then
              Result := xpGray
            else
              Result := xpNone;
          end;
        end;
    end;
  finally
    if hThemeLib <> 0 then
      FreeLibrary(hThemeLib);
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

function BlendColor(Col1,Col2:TColor; BlendFactor:Integer): TColor;
var
  r1,g1,b1: Integer;
  r2,g2,b2: Integer;

begin
  if BlendFactor = 100 then
  begin
    Result := Col1;
    Exit;
  end;

  Col1 := Longint(ColorToRGB(Col1));
  r1 := GetRValue(Col1);
  g1 := GetGValue(Col1);
  b1 := GetBValue(Col1);

  Col2 := Longint(ColorToRGB(Col2));
  r2 := GetRValue(Col2);
  g2 := GetGValue(Col2);
  b2 := GetBValue(Col2);

  r1 := Round( BlendFactor/100 * r1 + (1 - BlendFactor/100) * r2);
  g1 := Round( BlendFactor/100 * g1 + (1 - BlendFactor/100) * g2);
  b1 := Round( BlendFactor/100 * b1 + (1 - BlendFactor/100) * b2);

  Result := RGB(r1,g1,b1);
end;

procedure DrawGradient(Canvas: TCanvas; FromColor,ToColor: TColor; Steps: Integer;R:TRect; Direction: Boolean);
var
  diffr,startr,endr: Integer;
  diffg,startg,endg: Integer;
  diffb,startb,endb: Integer;
  iend: Integer;
  rstepr,rstepg,rstepb,rstepw: Real;
  i,stepw: Word;

begin
  if Steps = 0 then
    Steps := 1;
  
  if Steps > 32 then
	Steps := 32;

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
    for i := 0 to Steps - 1 do
    begin
      endr := startr + Round(rstepr*i);
      endg := startg + Round(rstepg*i);
      endb := startb + Round(rstepb*i);
      stepw := Round(i*rstepw);
      Pen.Color := endr + (endg shl 8) + (endb shl 16);
      Brush.Color := Pen.Color;
      if Direction then
      begin
        iend := R.Left + stepw + Trunc(rstepw) + 1;
        if iend > R.Right then
          iend := R.Right;
        Rectangle(R.Left + stepw,R.Top,iend,R.Bottom)
      end
      else
      begin
        iend := R.Top + stepw + Trunc(rstepw)+1;
        if iend > r.Bottom then
          iend := r.Bottom;
        Rectangle(R.Left,R.Top + stepw,R.Right,iend);
      end;
    end;
  end;
end;

// Draw gradient in the specified rectangle (if Fill = True and ColorFrom <> clNone),
// frame it with BorderColor color.
procedure DrawVistaGradient(ACanvas: TCanvas; ARect: TRect; ColorFrom, ColorTo, ColorMirrorFrom, ColorMirrorTo: TColor;
  Direction: TGradientDirection; BorderColor: TColor; Fill: Boolean = True);
const
  GradientSteps: Integer = 32;
var
  r: Trect;

begin
  if Fill and (ColorFrom <> clNone) then
  begin
    if ColorMirrorFrom <> clNone then
    begin
      r := ARect;

      if Direction = gdHorizontal then
      begin
        r.Right := r.Left + ((r.Right - r.Left) div 2);
        DrawGradient(ACanvas,  ColorFrom, ColorTo, GradientSteps, r, Direction = gdHorizontal);
        r := ARect;
        r.Left := r.Left + ((r.Right - r.Left) div 2);
        DrawGradient(ACanvas,  ColorMirrorFrom, ColorMirrorTo, GradientSteps, r, Direction = gdHorizontal);
      end
      else
      begin
        r.Bottom := r.Top + ((r.Bottom - r.Top) div 2);
        DrawGradient(ACanvas,  ColorFrom, ColorTo, GradientSteps, r, Direction = gdHorizontal);
        r := ARect;
        r.Top := r.Top + ((r.Bottom - r.Top) div 2);
        DrawGradient(ACanvas,  ColorMirrorFrom, ColorMirrorTo, GradientSteps, r, Direction = gdHorizontal);
      end;
    end
    else
      DrawGradient(ACanvas, ColorFrom, ColorTo, GradientSteps, ARect, Direction = gdVertical);
  end;

  if BorderColor <> clNone then
  begin
    ACanvas.Brush.Color := BorderColor;
    ACanvas.FrameRect(ARect);
  end;
end;

{ TAdvPanel }

procedure TCustomAdvPanel.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
end;

constructor TCustomAdvPanel.Create(AOwner: TComponent);
var
  dwVersion:Dword;
  dwWindowsMajorVersion,dwWindowsMinorVersion:Dword;
begin
  inherited;

  ControlStyle := ControlStyle - [csSetCaption];

  {$IFNDEF TMSDOTNET}
  FImage := TAdvImage.Create;
  {$ENDIF}
  FCaption := TPanelCaption.Create;
  FCaption.OnChange := CaptionChange;
  FCaption.OnStateChange := CaptionStateChange;
  FCaption.OnShadeChange := CaptionShadeChange;
  FCaption.OnPositionChange := CaptionPositionChange;
  //FCaption.Font.Name := 'Tahoma';  // make sure to use a Truetype font
  {$IFNDEF TMSDOTNET}
  FImage.OnChange := BackgroundChanged;
  {$ENDIF}
  FURLColor := clBlue;
  FHoverColor := clNone;
  FHoverFontColor := clNone;
  FShadowColor := clGray;
  FShadowOffset := 2;
  FPosition := TPanelPosition.Create(Self);
  FImageCache := THTMLPictureCache.Create;
  {$IFDEF DELPHI4_LVL}
  DoubleBuffered := True;
  {$ENDIF}
  FShadedHeader := TBitmap.Create;
  FIsCollapsing := False;
  FCollapsDelay := 20;
  FCollapsColor := clGray;
  FBuffered := True;
  FOldWidth := -1;
  FOldHeight := -1;
  FOptimizePaint := false;

  dwVersion := GetVersion;
  dwWindowsMajorVersion :=  DWORD(LOBYTE(LOWORD(dwVersion)));
  dwWindowsMinorVersion :=  DWORD(HIBYTE(LOWORD(dwVersion)));

  FIsWinXP := (dwWindowsMajorVersion > 5) OR
    ((dwWindowsMajorVersion = 5) AND (dwWindowsMinorVersion >= 1));

  FAutoSize := TAutoSize.Create(Self);
  FAutoHideChildren := True;
  FCanUpdate := True;
  FOldColor := Color;
  FColorTo := clNone;
  FColorMirror := clNone;
  FColorMirrorTo := clNone;

  FStatusBar:= TPanelStatusBar.Create;
  FStatusBar.OnChange := OnStatusBarChange;

  // make sure to use a Truetype font
  // Font.Name := 'Tahoma';

  FHideList := TList.Create;

  FShowSizeMoveGrip := True;
end;

destructor TCustomAdvPanel.Destroy;
begin
  {$IFNDEF TMSDOTNET}
  FImage.Free;
  {$ENDIF}
  FCaption.Free;
  FPosition.Free;
  FPosition := nil;
  FImageCache.Free;
  FShadedHeader.Free;
  FAutoSize.Free;
  FStatusBar.Free;
  FHideList.Free;
  inherited;
end;

procedure TCustomAdvPanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  r: TRect;
  GW: Integer;
  DueMinMax: Boolean;

begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  DueMinMax := FCaption.MinMaxCaption and FCaption.Visible;

  if FCaption.Visible then
  begin
    r := ClientRect;

    GW := 12;

    if (not FCaption.CloseMinGlyph.Empty and not FCaption.CloseMaxGlyph.Empty) then
      GW := FCaption.CloseMinGlyph.Width;

    if (not FCaption.MaxGlyph.Empty and not FCaption.MinGlyph.Empty)  then
      GW := FCaption.MaxGlyph.Width;

    if (FCaption.ShadeType = stXPCaption) and DoVisualStyles then
      GW := 16;

    if FCaption.ButtonPosition = cbpRight then
    begin
      {$IFNDEF TMSDOTNET}
      if ((PtInRect(Rect(r.Right-2-GW,r.Top+2,r.Right-2,r.Top+2+GW),point(x,y)) and (FCaption.Position = cpTop)) or ((PtInRect(Rect(r.Left + 2, r.Top + 2, r.Left+ 2+ GW,r.Top+2 + GW),point(x,y))) and (FCaption.Position = cpLeft) )) and FCaption.CloseButton then
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      if ((PtInRect(Borland.Vcl.Types.Rect(r.Right-2-GW,r.Top+2,r.Right-2,r.Top+2+GW),Borland.Vcl.Types.Point(x,y)) and (FCaption.Position = cpTop))
        or ((PtInRect(Borland.Vcl.Types.Rect(r.Left + 2, r.Top + 2, r.Left+ 2+ GW,r.Top+2 + GW),Borland.Vcl.Types.Point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.CloseButton then
      {$ENDIF}
      begin
        Visible := False;
        if Assigned(FOnClose) then
          FOnClose(Self);
          
        Synchronize;

        DueMinMax := False;

        if FreeOnClose then
        begin
          Free;
          Exit;
        end;
      end;
    end
    else
    begin
      {$IFNDEF TMSDOTNET}
      if ((PtInRect(Rect(r.Left+2,r.Top+2,r.Left + GW + 2,r.Top + 2 + GW),point(x,y)) and (FCaption.Position = cpTop)) or ((PtInRect(Rect(r.Left+2, r.Bottom-2 - GW, r.Left + GW + 2,r.Bottom - 2),point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.CloseButton then
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      if ((PtInRect(Borland.Vcl.Types.Rect(r.Left+2,r.Top+2,r.Left + GW + 2,r.Top + 2 + GW),Borland.Vcl.Types.Point(x,y)) and (FCaption.Position = cpTop))
        or ((PtInRect(Borland.Vcl.Types.Rect(r.Left+2, r.Bottom-2 - GW, r.Left + GW + 2,r.Bottom - 2),Borland.Vcl.Types.Point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.CloseButton then
      {$ENDIF}
      begin
        Visible := False;
        if Assigned(FOnClose) then
          FOnClose(Self);

        Synchronize;

        DueMinMax := False;

        if FreeOnClose then
        begin
          Free;
          Exit;
        end;
      end;
    end;

    if FCaption.Position = cpTop then
    begin
      if FCaption.ButtonPosition = cbpRight then
      begin
        if FCaption.CloseButton then
          r.Right := r.Right - GW;
      end
      else
      begin
        if FCaption.CloseButton then
          r.Left := r.Left + GW;
      end;
    end
    else   // cpLeft
    begin
      if FCaption.ButtonPosition = cbpRight then
      begin
        if FCaption.CloseButton then
          r.Top := r.Top + GW;
      end
      else
      begin
        if FCaption.CloseButton then
          r.Bottom := r.Bottom - GW;
      end;
    end;

    if FCaption.ButtonPosition = cbpRight then
    begin
      {$IFNDEF TMSDOTNET}
      if ((PtInRect(Rect(r.Right-2-GW,r.Top+2,r.Right-2,r.Top+2+GW),point(x,y)) and (FCaption.Position = cpTop)) or ((PtInRect(Rect(r.Left+ 2, r.Top+ 2, r.Left+2+GW, r.Top+2+GW),point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.MinMaxButton then
      {$ENDIF}

      {$IFDEF TMSDOTNET}
      if ((PtInRect(Borland.Vcl.Types.Rect(r.Right-2-GW,r.Top+2,r.Right-2,r.Top+2+GW),Borland.Vcl.Types.point(x,y)) and (FCaption.Position = cpTop))
        or ((PtInRect(Borland.Vcl.Types.Rect(r.Left+ 2, r.Top+ 2, r.Left+2+GW, r.Top+2+GW),Borland.Vcl.Types.point(x,y))) and (FCaption.Position = cpLeft))) and FCaption.MinMaxButton then
      {$ENDIF}
      begin
        DueMinMax := False;
        Collaps := not Collaps;
      end;
    end
    else
    begin
      {$IFNDEF TMSDOTNET}
      if ((PtInRect(Rect(r.Left + 2,r.Top + 2,r.Left + 2 + GW,r.Top+2+GW),point(x,y)) and (FCaption.Position = cpTop)) or ((PtInRect(Rect(r.Left + 2,r.Bottom - 2 - GW,r.Left + 2 + GW, r.Bottom - 2),point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.MinMaxButton then
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      if ((PtInRect(Borland.Vcl.Types.Rect(r.Left + 2,r.Top + 2,r.Left + 2 + GW,r.Top+2+GW),Borland.Vcl.Types.point(x,y)) and (FCaption.Position = cpTop))
        or ((PtInRect(Borland.Vcl.Types.Rect(r.Left + 2,r.Bottom - 2 - GW,r.Left + 2 + GW, r.Bottom - 2),Borland.Vcl.Types.point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.MinMaxButton then
      {$ENDIF}
      begin
        DueMinMax := False;
        Collaps := not Collaps;
      end;
    end;

    {$IFNDEF TMSDOTNET}
    if ((PtInRect(rect(r.left,r.Top,r.Right-2,r.Top + FCaption.Height),point(x,y)) and (FCaption.Position = cpTop)) or ((PtInRect(rect(r.left,r.Top,r.Left + FCaption.Height, r.Bottom),point(x,y))) and (FCaption.Position = cpLeft)) ) then
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    if ((PtInRect(Borland.Vcl.Types.rect(r.left,r.Top,r.Right-2,r.Top + FCaption.Height),Borland.Vcl.Types.Point(x,y)) and (FCaption.Position = cpTop)) or ((PtInRect(Borland.Vcl.Types.rect(r.left,r.Top,r.Left + FCaption.Height, r.Bottom),Borland.Vcl.Types.Point(x,y))) and (FCaption.Position = cpLeft)) ) then
    {$ENDIF}
    begin
      if DueMinMax then
        Collaps := not Collaps;

      if Assigned(FOnCaptionClick) then
        FOnCaptionClick(Self);
    end;
   end;
end;

procedure TCustomAdvPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  hr: TRect;
  anchor: string;
begin
  inherited;

  Anchor := IsAnchor(X,Y,hr);
  if Anchor <> '' then
  begin
    if (Pos('://',Anchor)>0) or (Pos('mailto:',Anchor)>0) then
      {$IFNDEF TMSDOTNET}
      ShellExecute(0,'open',PChar(Anchor),nil,nil,SW_NORMAL)
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      ShellExecute(0,'open',Anchor,'','',SW_NORMAL)
      {$ENDIF}
    else
      begin
        if Assigned(FAnchorClick) then
          FAnchorClick(Self,Anchor);
      end;
  end;
end;

procedure TCustomAdvPanel.ShadeHeader;
var
  a,x,y,xs,i,j,h,k,s,sizeX,sizeY: Integer;
  d : TColor;
  R: Trect;
  Light: Byte;
  rr,br,gr: Integer;

  function Dist(x1,y1,x2,y2: Integer): Integer;
  begin
    Result := Round(sqrt( sqr(x1-x2) + sqr(y1 - y2)));
  end;

begin
  rr := GetRValue(ColorToRGB(FCaption.Color));
  gr := GetGValue(ColorToRGB(FCaption.Color));
  br := GetBValue(ColorToRGB(FCaption.Color));

  Light := FCaption.ShadeLight;
  if FCaption.Position = cpTop then
  begin
    FShadedHeader.Width := Width;
    FShadedHeader.Height := FCaption.FHeight;

    Randomize;

    SizeX := FShadedHeader.Width;
    SizeY := FShadedHeader.Height;

    if SizeX = 0 then
      SizeX := 100;
    if SizeY = 0 then
      SizeY := 20;
  end
  else
  begin
    FShadedHeader.Width := FCaption.FHeight;
    FShadedHeader.Height := Height;

    Randomize;

    SizeX := FShadedHeader.Width;
    SizeY := FShadedHeader.Height;

    if SizeX = 0 then
      SizeX := 20;
    if SizeY = 0 then
      SizeY := 100;
  end;

  FShadedHeader.Canvas.Brush.Color := clWhite;
  {$IFNDEF TMSDOTNET}
  r := Rect(0,0,SizeX,SizeY);
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  r := Borland.Vcl.Types.Rect(0,0,SizeX,SizeY);
  {$ENDIF}
  FShadedHeader.Canvas.FillRect(r); //clear the bitmap

  case FCaption.ShadeType of
  stIRADIAL,stORADIAL:
    begin
      h := Dist(0,SizeX,0,SizeY);
      x := sizeX div 2;
      y := sizeY div 2;

      for i := 0 to x do
        for j := 0 to y do
        begin
          k := Dist(i,j,x,y);

          if FCaption.ShadeType = stIRADIAL then
            k := Round((h - k) / h * Light)
          else
            k := Round(k / h * Light);

          d := RGB( (rr*k) div 255,(gr*k) div 255,(br*k) div 255);

          FShadedHeader.Canvas.Pixels[i,j] := d;
          FShadedHeader.Canvas.Pixels[sizex - i,sizey - j] := d;
          FShadedHeader.Canvas.Pixels[sizex - i,j] := d;
          FShadedHeader.Canvas.Pixels[i,sizey - j] := d;
        end;
    end;
  stLMETAL,stRMETAL:
    begin
      for a := 0 to 250 do
      begin
        x := Random(sizeX);
        y := Random(sizeY);
        xs := Random(Min(sizeX,sizeY) div 2);
        i := Light - Random(40);
        d := RGB( (rr*i) div 255,(gr*i) div 255,(br*i) div 255);
        for i := 0 to xs - 1 do
        begin
          if FCaption.ShadeType = stLMetal then
          begin
            if (((x-i)>0)and((y+i)<sizeY)) then
              FShadedHeader.Canvas.Pixels[x + i,y + i] := d;
            if (((x+i)<sizeX)and((y-i)>0)) then
              FShadedHeader.Canvas.Pixels[x - i,y - i] := d;
          end
          else
          begin
            if (((x-i)>0)and((y+i)<sizeY)) then
              FShadedHeader.Canvas.Pixels[x - i,y + i] := d;
            if (((x+i)<sizeX)and((y-i)>0)) then
              FShadedHeader.Canvas.Pixels[x + i,y - i] := d;
          end;
        end;
      end;
      a := 120;
      for i := 0 to sizeX do
        for j := 0 to sizeY do
        begin
          d := FShadedHeader.Canvas.Pixels[i,j];
          x := GetBValue(d);
          x := Light - x;
          x := x + ((a*i) div sizeX)+((a*j) div sizeY);
          x := Light - x div 2;
          d := RGB( (rr*x) div 255,(gr*x) div 255,(br*x) div 255);
          FShadedHeader.Canvas.Pixels[i,j] := d;
        end;
    end;
  stHARDBUMP:
    begin
      for i := 0 to sizeY do
      begin
        x := (255*i div sizeY)-127;
        x := (x*(x*x) div 128) div 128;
        x := ((x*112) div 128) +128;
        for j:= 0 to sizeX do
        begin
          y := Light - x div 2; //offset
          d := RGB( (rr*y) div 255,(gr*y) div 255,(br*y) div 255);
          FShadedHeader.Canvas.Pixels[j,i] := d;
        end;
      end;
      k := min(16, sizeX div 6);
      a := (sizeY*sizeY) div 4;
      for i := 0 to sizeY do
      begin
        y := i - sizeY div 2;
        for j := 0 to sizeX do
        begin
          x  := j - sizeX div 2;
          xs := sizeX div 2 - k + (y*y*k) div a;
          if (x > xs)   then
          begin
            s := 8 + (((sizeX-j)*128) div k);
            s := Light - s div 2;//offset
            d := RGB( (rr*s) div 255,(gr*s) div 255,(br*s) div 255);
            FShadedHeader.Canvas.Pixels[j,i] := d;
          end;
          if (x + xs) < 0   then
          begin
            s := 247 - ((j*128) div k);
            s := Light - s div 2;//offset
            d := RGB( (rr*s) div 255,(gr*s) div 255,(br*s) div 255);
            FShadedHeader.Canvas.Pixels[j,i] := d;
          end;
        end;
      end;
    end;
  stSOFTBUMP:
    begin
      for i := 0 to sizeY do
      begin
        h := ((255 * i) div sizeY) - 127;
        for j := 0 to sizeX do
        begin
          k := 255 * (sizeX - j) div sizeX - 127;
          k := ((h * (h * h)) div 128) div 128 + (k * ( k * k) div 128) div 128;
          k := k * (128 - 8) div 128 + 128;
          if (k < 8)  then k := 8;
          if (k > 247) then k := 247;
          s := Light - k div 2;  //offset
          d := RGB( (rr*s) div 255,(gr*s) div 255,(br*s) div 255);
          FShadedHeader.Canvas.Pixels[j,i] := d;
        end;
      end;
    end;
  stHBUMP:
    begin
      for j := 0 to sizeX do
      begin
        k := (255*(sizeX - j)div sizeX)-127;
        k := (k*(k*k)div 128)div 128;
        k := (k*(128 - 8))div 128 + 128;
        for i := 0 to sizeY do
        begin
          s := Light - k div 2;//offset
          d := RGB( (rr*s) div 255,(gr*s) div 255,(br*s) div 255);
          FShadedHeader.Canvas.Pixels[j,i] := d;
        end;
      end;
    end;
  stVBUMP:
    begin
      for i := 0 to sizeY do
      begin
        k := (255*i div sizeY)-127;
        k := (k*(k*k)div 128)div 128;
        k := (k*(128 - 8))div 128 + 128;
        for j := 0 to sizeX do
        begin
          s := Light - k div 2;//offset
          d := RGB( (rr*s) div 255,(gr*s) div 255,(br*s) div 255);
          FShadedHeader.Canvas.Pixels[j,i] := d;
        end;
      end;
    end;
  stDIAGSHADE:
    begin
      a := 129;
      for i := 0 to sizeX do
        for j := 0 to sizeY do
        begin
          d := FShadedHeader.Canvas.Pixels[i,j];
          x := GetBValue(d);
          x := Light-x;
          x := x+((a*i) div sizeX)+((a*j) div sizeY);
          x := Light-x div 2;//offset
          d := RGB( (rr*x) div 255,(gr*x) div 255,(br*x) div 255);
          FShadedHeader.Canvas.Pixels[i,j] := d;
        end;
      end;
  stVSHADE,stVSHADEInv:
    begin
      a := 239;
      for i := 0 to sizeY do
      begin
        k := a * i div sizeY +8;
        k := Light-k div 4;//offset
        d := RGB( (rr*k) div 255,(gr*k) div 255,(br*k) div 255);
        for j := 0 to sizeX do
          if FCaption.ShadeType = stVSHADEInv then
            FShadedHeader.Canvas.Pixels[j,sizey - i] := d
          else
            FShadedHeader.Canvas.Pixels[sizeX - j, i] := d
      end;
    end;
  stHSHADE,stHShadeInv:
    begin
      a := 239;
      for j := 0 to sizeX do
      begin
        k := a * (sizeX-j) div sizeX +8;
        k := Light-k div 2;//offset
        d := RGB( (rr*k) div 255,(gr*k) div 255,(br*k) div 255);
        for i := 0 to sizeY do
          if FCaption.ShadeType = stHSHADE then
            FShadedHeader.Canvas.Pixels[j,i] := d
          else
            FShadedHeader.Canvas.Pixels[sizeX - j,i] := d
      end;
    end;
  stNOISE:
    begin
      for i := 0 to sizeX do
        for j := 0 to sizeY do
        begin
          k := 128 + random(FCaption.ShadeGrain) ;
          k := Light-k div 2;//offset
          d := RGB( (rr*k) div 255,(gr*k) div 255,(br*k) div 255);
          FShadedHeader.Canvas.Pixels[i,j] := d;
        end;
      end;
  stNORMAL,stXPCaption, stBitmap, stBitmapLStretch, stBitmapRStretch:
    begin  //for normal we use the panel caption color
      FShadedHeader.Canvas.Brush.Color:= FCaption.Color;
      FShadedHeader.Canvas.FillRect(r);
    end;
  end;
end;

procedure TCustomAdvPanel.DrawCaptionBkg(Canvas: TCanvas; r: TRect);
var
  tRgn,rgn1,rgn2: HRGN;
  BorderColor1, BorderColor2: TColor;
  ind: Integer;
  HTheme: THandle;
begin

  BorderColor1 := clWhite;
  BorderColor2 := clGray;

  if (FCaption.ShadeType = stXPCaption) and DoVisualStyles then
  begin
    HTheme := OpenThemeData(Handle,'window');
    InflateRect(r,1,1);
    //Hot := Panel.Index = FMousePanel;
    //Down := Hot and FMouseDown;
    {$IFNDEF TMSDOTNET}
    DrawThemeBackground(HTheme,Canvas.Handle,WP_CAPTION,CS_ACTIVE,@r,nil);
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    DrawThemeBackground(HTheme,Canvas.Handle,WP_CAPTION,CS_ACTIVE,r,nil);
    {$ENDIF}

    CloseThemeData(HTheme);
  end;


  if (FCaption.ShadeType in [stBitmap, stBitmapLStretch, stBitmapRStretch]) then
  begin
    if not FCaption.Background.Empty then
    begin
      if FCaption.ShadeType = stBitmapLStretch then
      begin
        if FCaption.Position = cpTop then
        begin
          ind := Width - FCaption.Background.Width;
          if ind < 0 then ind := 0;
          Canvas.Draw(r.Left + Ind, r.Top, FCaption.Background);
          {$IFNDEF TMSDOTNET}
          Canvas.CopyRect(Rect(0,r.Top,Ind,R.Bottom),FCaption.Background.Canvas,
          Rect(0,0,2,FCaption.Background.Height));
          {$ENDIF}
          {$IFDEF TMSDOTNET}
          Canvas.CopyRect(Borland.Vcl.Types.Rect(0,r.Top,Ind,R.Bottom),FCaption.Background.Canvas,
          Borland.Vcl.Types.Rect(0,0,2,FCaption.Background.Height));
          {$ENDIF}
        end
        else
        begin
          ind := Height - FCaption.Background.Height;
          if ind < 0 then ind := 0;
          Canvas.Draw(r.Left, r.Top, FCaption.Background);
          {$IFNDEF TMSDOTNET}
          Canvas.CopyRect(Rect(0, R.Bottom - Ind,R.Right,R.Bottom),FCaption.Background.Canvas,
          Rect(0,FCaption.Background.Height - 3, FCaption.Background.Width, FCaption.Background.Height));
          {$ENDIF}
          {$IFDEF TMSDOTNET}
          Canvas.CopyRect(Borland.Vcl.Types.Rect(0, R.Bottom - Ind,R.Right,R.Bottom),FCaption.Background.Canvas,
          Borland.Vcl.Types.Rect(0,FCaption.Background.Height - 3, FCaption.Background.Width, FCaption.Background.Height));
          {$ENDIF}
        end;


      end;

      if FCaption.ShadeType = stBitmapRStretch then
      begin
        if FCaption.Position = cpTop then
        begin
          ind := FCaption.Background.Width;

          Canvas.Draw(r.Left, r.Top, FCaption.Background);

          {$IFNDEF TMSDOTNET}
          Canvas.CopyRect(Rect(ind,r.Top,R.Right,R.Bottom),FCaption.Background.Canvas,
          Rect(FCaption.Background.Width -3 ,0,FCaption.Background.Width,FCaption.Background.Height));
          {$ENDIF}
          {$IFDEF TMSDOTNET}
          Canvas.CopyRect(Borland.Vcl.Types.Rect(ind,r.Top,R.Right,R.Bottom),FCaption.Background.Canvas,
          Borland.Vcl.Types.Rect(FCaption.Background.Width -3 ,0,FCaption.Background.Width,FCaption.Background.Height));
          {$ENDIF}
         end
         else
         begin
          ind := FCaption.Background.Height;

          Canvas.Draw(r.Left, r.Bottom - Ind, FCaption.Background);

          {$IFNDEF TMSDOTNET}
          Canvas.CopyRect(Rect(r.Left, r.Top,R.Right,R.Bottom - Ind),FCaption.Background.Canvas,
          Rect(0, 0 ,FCaption.Background.Width, 3));
          {$ENDIF}
          {$IFDEF TMSDOTNET}
          Canvas.CopyRect(Borland.Vcl.Types.Rect(r.Left, r.Top,R.Right,R.Bottom - Ind),FCaption.Background.Canvas,
          Borland.Vcl.Types.Rect(0, 0 ,FCaption.Background.Width, 3));
          {$ENDIF}
         end;
      end;

      if FCaption.ShadeType = stBitmap then
      begin
        Canvas.StretchDraw(r,FCaption.Background);
      end;
    end;
  end;


  if not (FCaption.ShadeType in [stXPCaption, stBitmap, stBitmapLStretch, stBitmapRStretch]) then
  begin
    trgn := 0;
    rgn1 := 0;
    rgn2 := 0;
    
    case FCaption.Shape of
    csRectangle:
      begin
        if not FCaption.Flat then
        begin
          Canvas.Pen.Color := BorderColor2;         //lines for 3D effect
          Canvas.MoveTo(R.Left,R.Bottom - 1);
          Canvas.LineTo(R.Right - 1,R.Bottom - 1);
          Canvas.LineTo(R.Right - 1,R.Top);
          Canvas.Pen.Color := BorderColor1;
          Canvas.LineTo(R.Left,R.Top);
          Canvas.LineTo(R.Left,R.Bottom - 1);
          InflateRect(R,-1,-1);
        end;

        tRgn := CreateRectRgn(R.Left,R.Top,R.Right,R.Bottom);
      end;                    //standard rectangle
    csRounded:
      begin
        Canvas.Pen.Color := BorderColor2;         //Round Rects for 3D effect
        tRgn := CreateRoundRectRgn(R.Left,R.Top+(r.Bottom-r.Top)div 2,R.Right,R.Bottom,32,32);
        SelectClipRgn(Canvas.Handle,tRgn);
        Canvas.RoundRect(R.Left,R.Top,R.Right,R.Bottom,32,32);
        Canvas.Pen.Color := BorderColor1;
        tRgn := CreateRoundRectRgn(R.Left,R.Top,R.Right,R.Bottom-(r.Bottom-r.Top)div 2,32,32);
        SelectClipRgn(Canvas.Handle,0);
        DeleteObject(tRgn);

        Canvas.RoundRect(R.Left,R.Top,R.Right,R.Bottom,32,32);
        tRgn := CreateRectRgn(0,0,Width,height);
        SelectClipRgn(Canvas.Handle,tRgn);
        Canvas.Pen.Color := BorderColor2;
        Canvas.MoveTo(R.Left + 16,r.Bottom - 1);
        Canvas.LineTo(r.Right - 16,r.Bottom - 1);
        R.Top := R.Top + 1;
        SelectClipRgn(Canvas.Handle,0);
        DeleteObject(tRgn);
        tRgn := CreateRoundRectRgn(R.Left,R.Top,R.Right,R.Bottom,32,32);
      end;              //round rectangle
    csSemiRounded:
      begin
        Canvas.Pen.Color := BorderColor2;     //Round Rects for 3D effect
        tRgn := CreateRoundRectRgn(R.Left,R.Top + (r.Bottom - r.Top)div 2,R.Right,R.Bottom,32,32);
        SelectClipRgn(Canvas.Handle,tRgn);
        Canvas.RoundRect(R.Left,R.Top,R.Right,R.Bottom,32,32);
        Canvas.Pen.Color := BorderColor1;
        SelectClipRgn(Canvas.Handle,0);
        DeleteObject(tRgn);
        tRgn := CreateRoundRectRgn(R.Left,R.Top,R.Right,R.Bottom-(r.Bottom - r.Top)div 2,32,32);
        SelectClipRgn(Canvas.Handle,tRgn);
        Canvas.RoundRect(R.Left,R.Top,R.Right,R.Bottom,32,32);
        SelectClipRgn(Canvas.Handle,0);
        DeleteObject(tRgn);
        tRgn := CreateRectRgn(0,0,Width,height);
        SelectClipRgn(Canvas.Handle,tRgn);
        Canvas.Pen.Color := BorderColor1;          //Lines for 3D effect
        Canvas.MoveTo(R.Left + (r.Right - r.Left)div 2,r.Top);
        Canvas.LineTo(R.Left,r.Top);
        Canvas.LineTo(R.Left,r.Bottom - 1);
        Canvas.Pen.Color := BorderColor2;
        Canvas.LineTo(r.Right - 16,r.Bottom - 1);
        SelectClipRgn(Canvas.Handle,0);
        DeleteObject(tRgn);
        R.Top := R.Top + 1;
        R.Left := R.Left + 1;
        rgn1 := CreateRoundRectRgn(R.Left,R.Top,R.Right,R.Bottom,32,32);
        rgn2  := CreateRectRgn(R.Left,R.Top,R.Right-(r.Right-r.Left)div 2,R.Bottom-1);
        CombineRgn(tRgn,rgn1,rgn2,RGN_OR);//round rectangle + rectangle
      end;
    end;

    SelectClipRgn(Canvas.Handle,tRgn);    //Set the Canvas Clip region
    Canvas.Draw(R.Left ,R.Top ,FShadedHeader);  //Put the shade

    SelectClipRgn(Canvas.Handle,0);   //Restore the Canvas Clip region
    DeleteObject(tRgn);
    if FCaption.Shape = csSemiRounded then
    begin
      DeleteObject(rgn1);
      DeleteObject(rgn2);
    end;
  end;
end;


{$WARNINGS OFF}
procedure TCustomAdvPanel.Paint;
var
  a,s,fa:string;
  xsize,ysize:integer;
  r,hr,cr,dr:trect;
  xo,yo,hl,ml:integer;
  hrgn:THandle;
  TopColor, BottomColor: TColor;
  HTheme: THandle;
  sz: TSize;
  bmp: TBitmap;
  ACanvas: TCanvas;
  R2: TRect;
  tf: TFont;
  lf: TLogFont;
  shadebdr: Integer;
  nohtmlcaption: string;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

  function Max(a,b:integer):integer;
  begin
    if a>b then result:=a else result:=b;
  end;


begin
  inherited;
  
  R := ClientRect;
  shadebdr := 0;
  if BorderShadow then
   shadebdr := 3;

  if FBuffered then
  begin
    bmp := TBitmap.Create;
    bmp.Width := r.Right - r.Left;
    bmp.Height := r.Bottom - r.Top;
    ACanvas := bmp.Canvas;
  end
  else
    ACanvas := Canvas;

  if ColorTo <> clNone then
  begin
    if ColorMirror <> clNone then
      DrawVistaGradient(ACanvas, r, Color, ColorTo, ColorMirror, ColorMirrorTo, GradientDirection, clNone)
    else
      DrawGradient(ACanvas,Color,ColorTo,64,r,GradientDirection = gdHorizontal)
  end
  else
  begin
    ACanvas.Brush.Color := Color;
    ACanvas.Pen.Color := Color;
    ACanvas.FillRect(r);
  end;

  if (BorderColor <> clNone) and (BorderWidth > 0) then
  begin
    ACanvas.Brush.Style := bsClear;
    ACanvas.Pen.Color := BorderColor;

    if FBorderShadow then
    begin
      r.Right := r.Right - 2;
      r.Bottom := r.Bottom - 2;
    end;

    ACanvas.Rectangle(r.Left,r.Top,r.Right,r.Bottom);

    if FBorderShadow then
    begin
      ACanvas.MoveTo(r.Right + 0,r.Top);
      ACanvas.Pen.Color := BlendColor(BorderColor,clBtnFace,50);
      ACanvas.LineTo(r.Right + 0,r.Bottom + 0);
      ACanvas.LineTo(r.Left,r.Bottom + 0);

      ACanvas.MoveTo(r.Right + 1,r.Top);
      ACanvas.Pen.Color := BlendColor(BorderColor,clBtnFace,20);
      ACanvas.LineTo(r.Right + 1,r.Bottom + 1);
      ACanvas.LineTo(r.Left,r.Bottom + 1);
    end;

    ACanvas.Brush.Style := bsSolid;
  end;


  if BevelOuter <> bvNone then
  begin
    AdjustColors(BevelOuter);
    Frame3D(ACanvas, R, TopColor, BottomColor, BevelWidth);
  end;

  if BorderColor = clNone then
    Frame3D(ACanvas, R, Color, Color, 1);

  if BevelInner <> bvNone then
  begin
    AdjustColors(BevelInner);
    Frame3D(ACanvas, R, TopColor, BottomColor, BevelWidth);
  end;


  ACanvas.Brush.Color := Color;
  ACanvas.Pen.Color := Color;

  R := GetClientRect;

  if FCaption.Visible then
  begin
    if FCaption.Position = cpTop then
      R.Top := R.Top + FCaption.Height - 2 * BevelWidth
    else
      R.Left := R.Left + 2 + FCaption.Height - 2 * BevelWidth;
  end;

  //if FStatusBar.Visible then
    //R.Bottom := R.Bottom - FStatusBar.Height;

  if FBorderShadow then
  begin
    R.Right := R.Right - 2;
    R.Bottom := R.Bottom - 3;
  end;

  hrgn := CreateRectRgn(R.Left, R.Top, R.Right,R.Bottom);
  SelectClipRgn(ACanvas.Handle, hrgn);

  {$IFNDEF TMSDOTNET}
  if Assigned(FImage) then
  begin
    if not FImage.Empty then
    case FBackgroundPosition of
    bpTopLeft:ACanvas.Draw(r.Left,r.Top,FImage);
    bpTopRight:ACanvas.Draw(Max(r.Left,r.Right - r.Left - FImage.Width - BevelWidth),r.top,FImage);
    bpBottomLeft:ACanvas.Draw(r.left,Max(r.top,Height - FImage.Height - BevelWidth),FImage);
    bpBottomRight:ACanvas.Draw(Max(r.Left,r.Right - r.Left - FImage.Width-BevelWidth),Max(r.Top,Height - FImage.Height - BevelWidth),FImage);
    bpCenter:ACanvas.Draw(Max(r.Left,r.Right - r.Left - FImage.Width - BevelWidth) shr 1,Max(r.Top,Height - FImage.Height - BevelWidth) shr 1,FImage);
    bpTiled:begin
              yo := r.Top;
              while (yo < Height) do
              begin
                xo := r.Left;
                while (xo<Width) do
                begin
                  ACanvas.Draw(xo,yo,FImage);
                  xo := xo + FImage.Width;
                end;
                yo := yo + FImage.Height;
              end;
            end;
    bpStretched:ACanvas.StretchDraw(R,FImage);
    else
    end;

  end;
  {$ENDIF}

  InflateRect(r,-BorderWidth,-BorderWidth);
  InflateRect(r,-1,-1);

  r.Left := r.Left + Indent;
  r.Top := r.Top + TopIndent;

  if FStatusBar.Visible then
  begin
    if FCaption.Position = cpTop then
      R.Bottom := R.Bottom - FStatusBar.Height
    else
      R.Right := R.Right - FStatusBar.Height;
  end;

  ACanvas.Font.Assign(self.Font);

  if FTextVAlign in [tvaCenter,tvaBottom] then
  begin
    dr := r;

    HTMLDrawEx(ACanvas,Text,dr,FImages,0,0,-1,FHoverHyperLink,FShadowOffset,true,false,false,false,false,fHover,not FEllipsis,1.0,fURLColor,fHoverColor,fHoverFontColor,fShadowColor,a,s,fa,
                      xsize,ysize,hl,ml,hr,FImageCache,FContainer,FLineSpacing);

    if FCaption.Visible then
      r.Top := r.Top + FCaption.Height - 2 * BevelWidth;

    if YSize < (r.Bottom - r.Top) then
    case FTextVAlign of
    tvaCenter:r.Top := r.Top + (((r.Bottom - r.Top) - YSize) div 2);
    tvaBottom:r.Top := r.Bottom - YSize;
    end;
  end;


  HTMLDrawEx(ACanvas,Text,r,FImages,0,0,-1,FHoverHyperLink,FShadowOffset,false,false,false,false,false,FHover,not FEllipsis,
    1.0,FURLColor,FHoverColor,fHoverFontColor,fShadowColor,a,s,fa,xsize,ysize,hl,ml,hr,FImageCache,FContainer,FLineSpacing);

  SelectClipRgn(ACanvas.handle, 0);
  DeleteObject(hrgn);

  if FCaption.Visible then
  begin
    r := ClientRect;

    if FBorderShadow then
    begin
	  r.Left := BorderWidth;
	  r.Top := BorderWidth;
      r.Right := r.Right - 2 - BorderWidth;
      r.Bottom := r.Bottom;
    end;

    if (bevelInner <> bvNone) or (bevelOuter <> bvNone) then
      Inflaterect(r,-BevelWidth,-BevelWidth);

    if not FCollaps then
    begin
      ACanvas.Brush.Color := FCaption.Color;
      ACanvas.Pen.Color := FCaption.Color;
    end
    else
    begin
      ACanvas.Brush.Color := FCaption.CloseColor;
      ACanvas.Pen.Color := FCaption.CloseColor;
    end;

    if (FCaption.ShadeType = stNormal) or
       ((FCaption.ShadeType = stXPCaption) and not DoVisualStyles) then
    begin
      if FCaption.ColorTo <> clNone then
      begin
        if FCaption.Position = cpTop then
        begin
          {$IFNDEF TMSDOTNET}
          DrawGradient(ACanvas,FCaption.Color,FCaption.ColorTo,64,
            Rect(r.Left,r.Top,r.Right,r.top + FCaption.Height - 2 * BevelWidth),Caption.GradientDirection = gdHorizontal)
          {$ENDIF}
          {$IFDEF TMSDOTNET}
          DrawGradient(ACanvas,FCaption.Color,FCaption.ColorTo,64,
            Borland.Vcl.Types.Rect(r.Left,r.Top,r.Right,r.top + FCaption.Height - 2 * BevelWidth),Caption.GradientDirection = gdHorizontal)
          {$ENDIF}
        end
        else  // FCaption.Position = cpLeft
        begin
          {$IFNDEF TMSDOTNET}
          DrawGradient(ACanvas,FCaption.Color,FCaption.ColorTo,64,
            Rect(r.Left,r.Top,r.Left + FCaption.Height - 2 * BevelWidth,r.Bottom - shadebdr),Caption.GradientDirection = gdHorizontal)
          {$ENDIF}
          {$IFDEF TMSDOTNET}
          DrawGradient(ACanvas,FCaption.Color,FCaption.ColorTo,64,
            Borland.Vcl.Types.Rect(r.Left,r.Top,r.Left + fCaption.Height - 2 * BevelWidth, r.Bottom - shadebdr),Caption.GradientDirection = gdHorizontal)
          {$ENDIF}
        end;
      end
      else
      begin
        if FCaption.Position = cpTop then
          ACanvas.Rectangle(r.Left,r.Top,r.Right,r.Top + FCaption.Height - 2 * BevelWidth)
        else
          ACanvas.Rectangle(r.Left,r.Top,r.Left + FCaption.Height - 2 * BevelWidth,r.Bottom - shadebdr);
      end;
    end
    else
    begin
      if FCaption.Position = cpTop then
      begin
        {$IFNDEF TMSDOTNET}
        DrawCaptionBkg(ACanvas,Rect(r.Left,r.Top,r.Right,r.Top + FCaption.Height - 2 * BevelWidth));
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        DrawCaptionBkg(ACanvas,Borland.Vcl.Types.Rect(r.Left,r.Top,r.Right,r.Top + FCaption.Height - 2 * BevelWidth));
        {$ENDIF}
      end
      else
      begin
        {$IFNDEF TMSDOTNET}
        DrawCaptionBkg(ACanvas,Rect(r.Left,r.Top,r.Left + FCaption.Height - 2 * BevelWidth,r.Bottom));
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        DrawCaptionBkg(ACanvas,Borland.Vcl.Types.Rect(r.Left,r.Top,r.Left + FCaption.Height - 2 * BevelWidth,r.Bottom));
        {$ENDIF}
      end;
    end;


    if FCaption.CloseButton then
    begin
      if (FCaption.ShadeType = stXPCaption) and DoVisualStyles then
      begin
        HTheme := OpenThemeData(self.Handle,'window');
        sz.Cx := 14;
        sz.Cy := 14;
        if FCaption.ButtonPosition = cbpRight then
        begin
          if FCaption.Position = cpTop then
          begin
            {$IFNDEF TMSDOTNET}
            cr := Rect(r.Right - sz.cx - 2, r.Top + 4,r.Right - 2, r.Top + Sz.cY + 4);
            {$ENDIF}
            {$IFDEF TMSDOTNET}
            cr := Borland.Vcl.Types.Rect(r.Right - sz.cx - 2, r.Top + 4,r.Right - 2, r.Top + Sz.cY + 4);
            {$ENDIF}
            r.Right := r.Right - 14;
          end
          else  // FCaption.Position = cpLeft
          begin
            {$IFNDEF TMSDOTNET}
            cr := Rect(r.Left + 4, r.Top + 2, r.Left + Sz.cY + 4, r.Top + Sz.cX + 2);
            {$ENDIF}
            {$IFDEF TMSDOTNET}
            cr := Borland.Vcl.Types.Rect(r.Left + 4, r.Top + 2, r.Left + Sz.cY + 4, r.Top + Sz.cX + 2);
            {$ENDIF}
            r.Top := r.Top - 14;
          end;
        end
        else
        begin
          if FCaption.Position = cpTop then
          begin
            {$IFNDEF TMSDOTNET}
            cr := Rect(r.Left + 2,r.Top + 4, r.Left + sz.cx + 2,r.Top + sz.cy + 4);
            {$ENDIF}
            {$IFDEF TMSDOTNET}
            cr := Borland.Vcl.Types.Rect(r.Left + 2,r.Top + 4, r.Left + sz.cx + 2,r.Top + sz.cy + 4);
            {$ENDIF}
            r.Left := r.Left + 14;
          end
          else   // FCaption.Position = cpLeft
          begin
            {$IFNDEF TMSDOTNET}
            cr := Rect(r.Left + 4,r.Bottom - sz.cx - 2, r.Left + Sz.cY + 4,r.Bottom - 2);
            {$ENDIF}
            {$IFDEF TMSDOTNET}
            cr := Borland.Vcl.Types.Rect(r.Left + 4,r.Bottom - sz.cx - 2, r.Left + Sz.cY + 4,r.Bottom - 2);
            {$ENDIF}
            r.Bottom := r.Bottom - 14;
          end;
        end;
        {$IFNDEF TMSDOTNET}
        DrawThemeBackground(HTheme,ACanvas.Handle,WP_CLOSEBUTTON,CS_ACTIVE,@cr,nil);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        DrawThemeBackground(HTheme,ACanvas.Handle,WP_CLOSEBUTTON,CS_ACTIVE,cr,nil);
        {$ENDIF}
        CloseThemeData(HTheme);
      end
      else
      begin
        if FCaption.CloseMinGlyph.Empty or FCaption.CloseMaxGlyph.Empty then
        begin

          ACanvas.Pen.Width := 2;
          ACanvas.Pen.Color := FCaption.FCloseButtonColor;
          if FHoverCloseBtn and (FCaption.CloseButtonHoverColor <> clNone) then
            ACanvas.Pen.Color := FCaption.CloseButtonHoverColor;

          if FCaption.ButtonPosition = cbpRight then
          begin
            if FCaption.Position = cpTop then
            begin
              ACanvas.MoveTo(r.Right - 10,r.Top + 4);
              ACanvas.LineTo(r.Right - 4,r.Top + 10);
              ACanvas.MoveTo(r.Right - 4,r.Top + 4);
              ACanvas.LineTo(r.Right - 10,r.Top + 10);
              r.Right := r.Right - 12;
            end
            else  // FCaption.Pocition = cpLeft
            begin
              ACanvas.MoveTo(r.Left + 14 - 10,r.Top + 4);
              ACanvas.LineTo(r.Left + 14 - 4,r.Top + 10);
              ACanvas.MoveTo(r.Left + 14 - 4,r.Top + 4);
              ACanvas.LineTo(r.Left + 14 - 10,r.Top + 10);
              r.Top := r.Top + 12;
            end;
          end
          else
          begin
            if FCaption.Position = cpTop then
            begin
              ACanvas.MoveTo(r.Left + 4,r.Top + 4);
              ACanvas.MoveTo(r.Left + 4,r.Top + 4);
              ACanvas.LineTo(r.Left + 10,r.Top + 10);
              ACanvas.MoveTo(r.Left + 10,r.Top + 4);
              ACanvas.LineTo(r.Left + 4,r.Top + 10);
              r.Left := r.Left + 12;
            end
            else  // FCaption.Pocition = cpLeft
            begin
              ACanvas.MoveTo(r.Left + 4,r.Bottom - 4);
              ACanvas.MoveTo(r.Left + 4,r.Bottom - 4);
              ACanvas.LineTo(r.Left + 10,r.Bottom - 10);
              ACanvas.MoveTo(r.Left + 10,r.Bottom - 4);
              ACanvas.LineTo(r.Left + 4,r.Bottom - 10);
              r.Bottom := r.Bottom - 12;
            end;
          end;

        end
        else
        begin
          if FCollaps then
          begin
            FCaption.CloseMinGlyph.TransparentMode := tmAuto;
            FCaption.CloseMinGlyph.Transparent := true;

            if FCaption.ButtonPosition = cbpRight then
            begin
              if FCaption.Position = cptop then
              begin
                ACanvas.Draw(r.Right - FCaption.CloseMinGlyph.Width,r.Top + 2,FCaption.CloseMinGlyph);
                r.Right := r.Right - FCaption.CloseMinGlyph.Width;
              end
              else  // FCaption.Pocition = cpLeft
              begin
                ACanvas.Draw(r.Left + 2,r.Top, FCaption.CloseMinGlyph);
                r.Top := r.Top + FCaption.CloseMinGlyph.Height;
              end;
            end
            else
            begin
              if FCaption.Position = cpTop then
              begin
                ACanvas.Draw(r.Left,r.Top + 2,FCaption.CloseMinGlyph);
                r.Left := r.Left + FCaption.CloseMinGlyph.Width;
              end
              else  // FCaption.Pocition = cpLeft
              begin
                ACanvas.Draw(r.Left + 2,r.Bottom - FCaption.CloseMinGlyph.Height,FCaption.CloseMinGlyph);
                r.Bottom := r.Bottom - FCaption.CloseMinGlyph.Height;
              end;
            end;
          end
          else
          begin
            FCaption.CloseMaxGlyph.TransparentMode := tmAuto;
            FCaption.CloseMaxGlyph.Transparent := true;

            if FCaption.ButtonPosition = cbpRight then
            begin
              if FCaption.Position = cpTop then
              begin
                ACanvas.Draw(r.Right - FCaption.CloseMaxGlyph.Width,r.Top + 2,FCaption.CloseMaxGlyph);
                r.Right := r.Right - FCaption.CloseMaxGlyph.Width;
              end
              else  // FCaption.Pocition = cpLeft
              begin
                ACanvas.Draw(r.Left+ 2, r.Top, FCaption.CloseMaxGlyph);
                r.Top := r.Top + FCaption.CloseMaxGlyph.Height;
              end;
            end
            else
            begin
              if FCaption.Position = cpTop then
              begin
                ACanvas.Draw(r.Left,r.Top + 2,FCaption.CloseMaxGlyph);
                r.Left := r.Left + FCaption.CloseMaxGlyph.Width;
              end
              else  // FCaption.Pocition = cpLeft
              begin
                ACanvas.Draw(r.Left + 2,r.Bottom - FCaption.CloseMaxGlyph.Height,FCaption.CloseMaxGlyph);
                r.Bottom := r.Bottom - FCaption.CloseMaxGlyph.Height;
              end;
            end;
          end;
        end;
      end;
    end;

    if FCaption.MinMaxButton and FCollaps then
    begin
      if (FCaption.ShadeType = stXPCaption) and DoVisualStyles then
      begin
        HTheme := OpenThemeData(self.Handle,'window');
        sz.Cx := 14;
        sz.Cy := 14;

        if FCaption.Position = cpTop then
        begin
          {$IFNDEF TMSDOTNET}
          if FCaption.ButtonPosition = cbpRight then
            cr := Rect(r.Right - sz.cx - 2, r.Top + 4,r.Right - 2, r.Top + Sz.cY + 4)
          else
            cr := Rect(r.Left + 2, r.Top + 4,r.Left + 2 + sz.cx, r.Top + Sz.cY + 4);
          {$ENDIF}

          {$IFDEF TMSDOTNET}
          if FCaption.ButtonPosition = cbpRight then
            cr := Borland.Vcl.Types.Rect(r.Right - sz.cx - 2, r.Top + 4,r.Right - 2, r.Top + Sz.cY + 4)
          else
            cr := Borland.Vcl.Types.Rect(r.Left + 2, r.Top + 4,r.Left + 2 + sz.cx, r.Top + Sz.cY + 4);
          {$ENDIF}
        end
        else   // cpLeft
        begin
          {$IFNDEF TMSDOTNET}
          if FCaption.ButtonPosition = cbpRight then
            cr := Rect(r.Left + 4, r.Top + 2, R.Left + Sz.cx + 4, r.Top + Sz.cy + 2)
          else
            cr := Rect(r.Left + 4, R.Bottom - Sz.cy - 2, r.Left + Sz.cx + 4, r.Bottom -2);
          {$ENDIF}

          {$IFDEF TMSDOTNET}
          if FCaption.ButtonPosition = cbpRight then
            cr := Borland.Vcl.Types.Rect(r.Left + 4, r.Top + 2, R.Left + Sz.cx + 4, r.Top + Sz.cy + 2)
          else
            cr := Borland.Vcl.Types.Rect(r.Left + 4, R.Bottom - Sz.cy - 2, r.Left + Sz.cx + 4, r.Bottom -2);
          {$ENDIF}
        end;

        {$IFNDEF TMSDOTNET}
        DrawThemeBackground(HTheme,ACanvas.Handle,WP_MAXBUTTON,CS_ACTIVE,@cr,nil);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        DrawThemeBackground(HTheme,ACanvas.Handle,WP_MAXBUTTON,CS_ACTIVE,cr,nil);
        {$ENDIF}

        CloseThemeData(HTheme);
      end
      else
      begin
        if FCaption.MaxGlyph.Empty then
        begin
          ACanvas.Pen.Width := 1;
          ACanvas.Pen.Color := FCaption.fMinMaxButtonColor;
          ACanvas.Brush.Color := FCaption.fMinMaxButtonColor;
          if FHoverMinMaxBtn and (FCaption.MinMaxButtonHoverColor <> clNone) then
          begin
            ACanvas.Pen.Color := FCaption.MinMaxButtonHoverColor;
            ACanvas.Brush.Color := FCaption.MinMaxButtonHoverColor;
          end;

          if FCaption.Position = cpTop then
          begin
            if FCaption.ButtonPosition = cbpRight then
              {$IFNDEF TMSDOTNET}
              ACanvas.Polygon([point(r.Right-10,r.Top + 5),point(r.right-4,r.top+5),point(r.right-7,r.top+8)])
              {$ENDIF}
              {$IFDEF TMSDOTNET}
              ACanvas.Polygon([Borland.Vcl.Types.Point(r.Right-10,r.Top + 5),Borland.Vcl.Types.point(r.right-4,r.top+5),Borland.Vcl.types.point(r.right-7,r.top+8)])
              {$ENDIF}
            else
              {$IFNDEF TMSDOTNET}
              ACanvas.Polygon([point(r.Left + 4,r.Top + 5),point(r.Left + 10,r.Top + 5),point(r.Left + 7,r.Top+8)]);
              {$ENDIF}
              {$IFDEF TMSDOTNET}
              ACanvas.Polygon([Borland.Vcl.Types.point(r.Left + 4,r.Top + 5),Borland.Vcl.Types.point(r.Left + 10,r.Top + 5),Borland.Vcl.Types.point(r.Left + 7,r.Top+8)]);
              {$ENDIF}
          end
          else   // cpLeft
          begin
            if FCaption.ButtonPosition = cbpRight then
              {$IFNDEF TMSDOTNET}
              ACanvas.Polygon([point(r.Left + 5, r.Top + 10),point(r.Left + 5, r.Top + 4),point(r.Left + 8, r.Top + 7)])
              {$ENDIF}
              {$IFDEF TMSDOTNET}
              ACanvas.Polygon([Borland.Vcl.Types.Point(r.Left + 5, r.Top + 10),Borland.Vcl.Types.point(r.Left + 5, r.Top + 4),Borland.Vcl.types.point(r.Left + 8, r.Top + 7)])
              {$ENDIF}
            else
              {$IFNDEF TMSDOTNET}
              ACanvas.Polygon([point(r.Left + 5, r.Bottom - 4),point(r.Left + 5, r.Bottom - 10),point(r.Left + 8, r.Bottom - 7)]);
              {$ENDIF}
              {$IFDEF TMSDOTNET}
              ACanvas.Polygon([Borland.Vcl.Types.point(r.Left + 5, r.Bottom - 4),Borland.Vcl.Types.point(r.Left + 5, r.Bottom - 10),Borland.Vcl.Types.point(r.Left + 8, r.Bottom - 7)]);
              {$ENDIF}
          end;

        end
        else
        begin
          FCaption.MaxGlyph.TransparentMode := tmAuto;
          FCaption.MaxGlyph.Transparent := true;
          if FCaption.Position = cpTop then
          begin
            if FCaption.ButtonPosition = cbpRight then
              ACanvas.Draw(r.Right - FCaption.MaxGlyph.Width,r.Top + 2,FCaption.MaxGlyph)
            else
              ACanvas.Draw(r.Left,r.Top + 2,FCaption.MaxGlyph);
          end
          else
          begin
            if FCaption.ButtonPosition = cbpRight then
              ACanvas.Draw(r.Left + 2, r.Top, FCaption.MaxGlyph)
            else
              ACanvas.Draw(r.Left + 2, r.Bottom - FCaption.MaxGlyph.Height,FCaption.MaxGlyph);
          end;
        end;
      end;
    end;

    if FCaption.MinMaxButton and not FCollaps then
    begin
      if (FCaption.ShadeType = stXPCaption) and DoVisualStyles then
      begin
        HTheme := OpenThemeData(self.Handle,'window');
        sz.Cx := 14;
        sz.Cy := 14;

        if FCaption.Position = cpTop then
        begin
          {$IFNDEF TMSDOTNET}
          if FCaption.ButtonPosition = cbpRight then
            cr := Rect(r.Right - sz.cx - 2, r.Top + 4,r.Right - 2, r.Top + Sz.cY + 4)
          else
            cr := Rect(r.Left +  2, r.Top + 4,r.Left + sz.cx + 2, r.Top + Sz.cY + 4);
          {$ENDIF}

          {$IFDEF TMSDOTNET}
          if FCaption.ButtonPosition = cbpRight then
            cr := Borland.Vcl.Types.Rect(r.Right - sz.cx - 2, r.Top + 4,r.Right - 2, r.Top + Sz.cY + 4)
          else
            cr := Borland.Vcl.Types.Rect(r.Left +  2, r.Top + 4,r.Left + sz.cx + 2, r.Top + Sz.cY + 4);
          {$ENDIF}
        end
        else    // cpLeft
        begin
          {$IFNDEF TMSDOTNET}
          if FCaption.ButtonPosition = cbpRight then
            cr := Rect(r.Left + 4, r.Top + 2, R.Left + Sz.cx + 4, r.Top + Sz.cy + 2)
          else
            cr := Rect(r.Left + 4, R.Bottom - Sz.cy - 2, r.Left + Sz.cx + 4, r.Bottom -2);
          {$ENDIF}

          {$IFDEF TMSDOTNET}
          if FCaption.ButtonPosition = cbpRight then
            cr := Borland.Vcl.Types.Rect(r.Left + 4, r.Top + 2, R.Left + Sz.cx + 4, r.Top + Sz.cy + 2)
          else
            cr := Borland.Vcl.Types.Rect(r.Left + 4, R.Bottom - Sz.cy - 2, r.Left + Sz.cx + 4, r.Bottom -2);
          {$ENDIF}
        end;


        {$IFNDEF TMSDOTNET}
        DrawThemeBackground(HTheme,ACanvas.Handle,WP_MINBUTTON,CS_ACTIVE,@cr,nil);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        DrawThemeBackground(HTheme,ACanvas.Handle,WP_MINBUTTON,CS_ACTIVE,cr,nil);
        {$ENDIF}

        CloseThemeData(HTheme);
      end
      else
      begin
        if FCaption.MinGlyph.Empty then
        begin
          ACanvas.Pen.Width := 1;
          ACanvas.Pen.Color := FCaption.FMinMaxButtonColor;
          ACanvas.Brush.Color := FCaption.FMinMaxButtonColor;
           if FHoverMinMaxBtn and (FCaption.MinMaxButtonHoverColor <> clNone) then
          begin
            ACanvas.Pen.Color := FCaption.MinMaxButtonHoverColor;
            ACanvas.Brush.Color := FCaption.MinMaxButtonHoverColor;
          end;

          if FCaption.Position = cpTop then
          begin
           {$IFNDEF TMSDOTNET}
            if FCaption.ButtonPosition = cbpRight then
              ACanvas.Polygon([Point(r.Right-10,r.top+8),point(r.right-4,r.Top+8),Point(r.Right-7,r.Top+5)])
            else
              ACanvas.Polygon([Point(r.Left + 4,r.Top+8),point(r.Left + 10,r.Top+8),Point(r.Left+7,r.Top+5)])
            {$ENDIF}
            {$IFDEF TMSDOTNET}
            if FCaption.ButtonPosition = cbpRight then
              ACanvas.Polygon([Borland.Vcl.Types.Point(r.Right-10,r.top+8),Borland.Vcl.Types.point(r.right-4,r.Top+8),Borland.Vcl.Types.Point(r.Right-7,r.Top+5)])
            else
              ACanvas.Polygon([Borland.Vcl.Types.Point(r.Left + 4,r.Top+8),Borland.Vcl.Types.point(r.Left + 10,r.Top+8),Borland.Vcl.Types.Point(r.Left+7,r.Top+5)])
            {$ENDIF}
          end
          else   // cpLeft
          begin
           {$IFNDEF TMSDOTNET}
            if FCaption.ButtonPosition = cbpRight then
              ACanvas.Polygon([Point(r.Left + 8, r.Top + 10),point(r.Left + 8, r.Top + 4),Point(r.Left + 5, r.Top + 7)])
            else
              ACanvas.Polygon([Point(R.Left + 8, r.Bottom - 4),point(r.Left + 8, r.Bottom - 10),Point(r.Left + 5, r.Bottom - 7)])
            {$ENDIF}
            {$IFDEF TMSDOTNET}
            if FCaption.ButtonPosition = cbpRight then
              ACanvas.Polygon([Borland.Vcl.Types.Point(r.Left + 8, r.Top + 10),Borland.Vcl.Types.point(r.Left + 8, r.Top + 4),Borland.Vcl.Types.Point(r.Left + 5, r.Top + 7)])
            else
              ACanvas.Polygon([Borland.Vcl.Types.Point(R.Left + 8, r.Bottom - 4),Borland.Vcl.Types.point(r.Left + 8, r.Bottom - 10),Borland.Vcl.Types.Point(r.Left + 5, r.Bottom - 7)])
            {$ENDIF}
          end;

        end
        else
        begin
          FCaption.MinGlyph.TransparentMode := tmAuto;
          FCaption.MinGlyph.Transparent := true;
          if FCaption.Position = cpTop then
          begin
          if FCaption.ButtonPosition = cbpRight then
            ACanvas.Draw(r.Right - FCaption.MinGlyph.Width,r.Top + 2,FCaption.MinGlyph)
          else
            ACanvas.Draw(r.Left,r.Top + 2,FCaption.MinGlyph)
          end
          else   // cpLeft
          begin
            if FCaption.ButtonPosition = cbpRight then
              ACanvas.Draw(r.Left + 2, r.Top,FCaption.MinGlyph)
            else
              ACanvas.Draw(r.Left + 2, r.Bottom - FCaption.MinGlyph.Height,FCaption.MinGlyph)
          end;

        end;
      end;
    end;

    ACanvas.Font.Assign(FCaption.Font);
    if FCaption.Position = cpTop then
    begin
      if FCaption.ButtonPosition = cbpRight then
      begin
        if FCaption.CloseButton then
          r.Right := r.Right - 20;
        if FCaption.MinMaxButton then
          r.Right := r.Right - 20;
      end
      else
      begin
        if FCaption.CloseButton then
          r.Left := r.Left + 20;
        if FCaption.MinMaxButton then
          r.Left := r.Left + 20;
      end;

      r.Bottom := r.Top + FCaption.Height;

      r.Left := r.Left + FCaption.Indent;
      r.Top := r.Top + FCaption.TopIndent;

      HTMLDrawEx(ACanvas,FCaption.Text,r,fImages,0,0,-1,FCaptionHoverHyperLink,FShadowOffset,false,false,false,false,false,fHover,false,1.0,
        FURLColor,FHoverColor,FHoverFontColor,FShadowColor,a,s,fa,xsize,ysize,hl,ml,hr,FImageCache,FContainer,FLineSpacing);
    end
    else   // cpLeft
    begin
      if FCaption.ButtonPosition = cbpRight then
      begin
        if FCaption.CloseButton then
          r.Top := r.Top + 20;
        if FCaption.MinMaxButton then
          r.Top := r.Top + 20;
      end
      else
      begin
        if FCaption.CloseButton then
          r.Bottom := r.Bottom - 20;
        if FCaption.MinMaxButton then
          r.Bottom := r.Bottom - 20;
      end;

      r.Right := r.Left + FCaption.Height;

      r.Bottom := r.Bottom - FCaption.Indent;
      r.Left := r.Left + FCaption.TopIndent;

      ACanvas.Brush.Style := bsClear;
      tf := TFont.Create;
      try
        {$IFNDEF TMSDOTNET}
        FillChar(lf, SizeOf(lf), 0);
        {$ENDIF}
        tf.Assign(ACanvas.Font);
        {$IFNDEF TMSDOTNET}
        GetObject(tf.Handle, SizeOf(Lf), @Lf);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        GetObject(tf.Handle, Marshal.SizeOf(TypeOf(Lf)), Lf);
        {$ENDIF}

        lf.lfEscapement := -2700;
        lf.lfOrientation := 30;

        tf.Handle := CreateFontIndirect(Lf);
        ACanvas.Font.Assign(tf);
      finally
        tf.Free;
      end;

      nohtmlcaption := HTMLStrip(FCaption.Text);
      //ACanvas.Pen.Color := clYellow;
      //ACanvas.Rectangle(r);
      {$IFNDEF TMSDOTNET}
      DrawText(ACanvas.Handle, PChar(nohtmlcaption), Length(nohtmlcaption), R, DT_SINGLELINE or DT_BOTTOM or DT_LEFT{ or DT_END_ELLIPSIS})
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      DrawText(ACanvas.Handle, nohtmlcaption, Length(nohtmlcaption), R, DT_SINGLELINE or DT_BOTTOM or DT_LEFT{ or DT_END_ELLIPSIS})
      {$ENDIF}

      //ACanvas.TextOut(r.Left, r.Bottom, FCaption.Text);
    end;
  end;

  if FStatusBar.Visible then
  begin
    if FCaption.Position = cpTop then
      R2 := Rect(1, Height - FStatusBar.Height-1, Width-1, Height-1)
    else
      R2 := Rect(Width - FStatusBar.Height - 1, 1, Width - 1, Height-1);

    if (FStatusBar.Color <> clNone) and (FStatusBar.ColorTo <> clNone) then
    begin
      DrawGradient(ACanvas, ColorToRGB(FStatusBar.Color), ColorToRGB(FStatusBar.ColorTo), 40, R2, FStatusBar.GradientDirection = gdHorizontal);
    end
    else
      if (FStatusBar.Color <> clNone) then
      begin
        ACanvas.Pen.Color := FStatusBar.Color;
        ACanvas.Brush.Color := FStatusBar.Color;
        ACanvas.Rectangle(R2.Left, R2.Top, R2.Right, R2.Bottom);
      end;

    if (FStatusBar.ImageIndex >= 0) and Assigned(FImages) then
    begin
      if FCaption.Position = cpTop then
      begin
        FImages.Draw(ACanvas, R2.Left + 1, R2.Top + 2, FStatusBar.ImageIndex);
        R2.Left := R2.Left + FImages.Width + 2;
      end
      else   // cpLeft
      begin
        if not Collaps and FCanSize then
          FImages.Draw(ACanvas, R2.Left + 2, R2.Bottom - FImages.Height - 12, FStatusBar.ImageIndex)
        else
          FImages.Draw(ACanvas, R2.Left + 2, R2.Bottom - FImages.Height - 1, FStatusBar.ImageIndex);
        R2.Bottom := R2.Bottom - FImages.Height - 2;
      end;
    end;

    if FCaption.Position = cpTop then
    begin
      R2.Left := R2.Left + 2;
      ACanvas.Font.Assign(self.StatusBar.Font);
      HTMLDrawEx(ACanvas, FStatusBar.Text, R2, FImages,0,0,-1,FCaptionHoverHyperLink,FShadowOffset,false,false,false,false,false,fHover,false,1.0,
        FURLColor,FHoverColor,FHoverFontColor,FShadowColor,a,s,fa,xsize,ysize,hl,ml,hr,FImageCache,FContainer,FLineSpacing);
      R2.Left := R2.Left - 2;
    end
    else   // cpLeft
    begin
      ACanvas.Font.Assign(self.StatusBar.Font);
      tf := TFont.Create;
      try
        {$IFNDEF TMSDOTNET}
        FillChar(lf, SizeOf(lf), 0);
        {$ENDIF}
        tf.Assign(aCanvas.Font);
        {$IFNDEF TMSDOTNET}
        GetObject(tf.Handle, SizeOf(Lf), @Lf);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        GetObject(tf.Handle, Marshal.SizeOf(TypeOf(Lf)), Lf);
        {$ENDIF}

        lf.lfEscapement := -2700;
        lf.lfOrientation := 30;

        tf.Handle := CreateFontIndirect(Lf);
        aCanvas.Font.Assign(tf);
      finally
        tf.Free;
      end;

      nohtmlcaption := HTMLStrip(FStatusBar.Text);

      if not Collaps and FCanSize then
        ACanvas.TextOut(R2.Left + 2, R2.Bottom -16, nohtmlcaption)
      else
        ACanvas.TextOut(R2.Left + 2, R2.Bottom -2, nohtmlcaption);

     { R2.Left := r2.Left+2;
      if not Collaps and FCanSize then
        R2.Bottom := r2.Bottom -16;
      DrawText(ACanvas.Handle, PChar(FStatusBar.Text), Length(FStatusBar.Text), R2, DT_SINGLELINE or DT_BOTTOM or DT_LEFT);
      R2.Left := r2.Left-2;
      if not Collaps and FCanSize then
        R2.Bottom := r2.Bottom +16;  }
    end;

    if (FStatusBar.BorderStyle <> bsNone) and not (FStatusBar.BorderColor = clNone) then
    begin
      ACanvas.Pen.Width := 1;
      ACanvas.Pen.Color := FStatusBar.BorderColor;
      ACanvas.Brush.Style := bsClear;
      if FCaption.Position = cpTop then
        ACanvas.Rectangle(0,R2.Top, R2.Right + 1, R2.Bottom + 1)
      else
        ACanvas.Rectangle(R2.Left, R2.Top, R2.Right + 1, Height);
    end;

    if FStatusBar.BevelInner then
    begin
      ACanvas.Pen.Width := 1;
      ACanvas.Pen.Color := clGray;
      if FCaption.Position = cpTop then
      begin
        ACanvas.MoveTo(0, r2.Bottom - 1);
        ACanvas.LineTo(0, R2.Top);
        ACanvas.LineTo(R2.Right, R2.Top);
        ACanvas.Pen.Color := clWhite;
        ACanvas.MoveTo(0, R2.Bottom - 1);
        ACanvas.LineTo(R2.Right-1, R2.Bottom - 1);
        ACanvas.LineTo(R2.Right-1, R2.Top);
      end
      else
      begin
        ACanvas.MoveTo(R2.Left, Height);
        ACanvas.LineTo(R2.Left, R2.Top);
        ACanvas.LineTo(R2.Right-1, R2.Top);
        ACanvas.Pen.Color := clWhite;
        ACanvas.MoveTo(R2.Left, Height);
        ACanvas.LineTo(R2.Right-1, Height);
        ACanvas.LineTo(R2.Right-1, R2.Top);
      end;
    end;
  end;

  if FShowSizeMoveGrip and not Collaps and FCanSize then
  begin
    r := ClientRect;
    if (bevelInner <> bvNone) or (bevelOuter <> bvNone) then
      Inflaterect(r,-2*BevelWidth,-2*BevelWidth);

    if FBorderShadow then
    begin
      r.Right := r.Right - 4;
      r.Bottom := r.Bottom - 4;
    end;

    r.left := r.right - GetSystemMetrics(SM_CXVSCROLL);
    r.top := r.bottom - GetSystemMetrics(SM_CXHSCROLL);

    with ACanvas do
    begin
      Pen.Color := clGray;
      Pen.Width := 2;
      MoveTo(r.right,r.bottom-11);
      Lineto(r.right-11,r.bottom);
      MoveTo(r.right,r.bottom-6);
      Lineto(r.right-7,r.bottom);
      MoveTo(r.right,r.bottom-3);
      Lineto(r.right-3,r.bottom);

      Pen.Color := clWhite;
      Pen.Width := 1;
      MoveTo(r.right,r.bottom - 12);
      Lineto(r.right - 12,r.bottom);
      MoveTo(r.right,r.bottom - 8);
      Lineto(r.right-8,r.bottom);
      MoveTo(r.right,r.bottom-4);
      Lineto(r.right-4,r.bottom);
    end;
  end;

  if Assigned(OnPaint) then
    OnPaint(Self, ACanvas, ClientRect);


  if FBuffered then
  begin
    Canvas.Draw(0,0,bmp);
    bmp.Free;
  end;

end;
{$WARNINGS ON}

procedure TCustomAdvPanel.SetBackgroundPosition(
  const Value: TBackgroundPosition);
begin
  FBackgroundPosition := Value;
  Invalidate;
end;

procedure TCustomAdvPanel.SetCaption(const Value: TPanelCaption);
begin
  FCaption.Assign(Value);
end;

{$IFNDEF TMSDOTNET}
procedure TCustomAdvPanel.SetImage(const Value: TAdvImage);
begin
  FImage.Assign(Value);
  Invalidate;
end;
{$ENDIF}

procedure TCustomAdvPanel.SetImages(const Value: TCustomImageList);
begin
  FImages := Value;
  Invalidate;
end;

procedure TCustomAdvPanel.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  if (AOperation = opRemove) and (AComponent = FImages) then
    FImages := nil;

  if (AOperation = opRemove) and (AComponent = FContainer) then
    FContainer := nil;

  if (AOperation = opRemove) and (AComponent = FStyler) then
    FStyler := nil;

  inherited;
end;

procedure TCustomAdvPanel.SetText(const Value: string);
begin
  FText := Value;
  Invalidate;
  DoAutoSize;
end;

procedure TCustomAdvPanel.SetURLColor(const Value: TColor);
begin
  FURLColor := Value;
  Invalidate;
end;

procedure TCustomAdvPanel.SetStatusBar(Value: TPanelStatusBar);
begin
  FStatusBar.Assign(Value);
end;

procedure TCustomAdvPanel.OnStatusBarChange(Sender: TObject);
begin
  Invalidate;
end;

procedure TCustomAdvPanel.CaptionPositionChange(Sender: TObject);
begin
  DoAutoSize;
  ShadeHeader;
  Invalidate;
end;

procedure TCustomAdvPanel.SetCollaps(const Value: boolean);
var
  i,delta,bdelta: Integer;

begin
  if FCollaps and not Value and Assigned(FOnMaximize) then
    FOnMaximize(Self);

  if not FCollaps and Value and Assigned(FOnMinimize) then
    FOnMinimize(Self);

  if FIsCollapsing then
    Exit;

  bdelta := 0;

  if (BorderWidth > 0) and BorderShadow then
    bdelta := BorderWidth + 4;


  if Value <> FCollaps then
  begin
    FIsCollapsing := True;
    FCollaps := Value;
    if not (csLoading in ComponentState) then
    begin
      if FCollaps then
      begin
        if FCaption.Position = cpTop then
        begin
          FFullHeight := Height;
          if FAutoHideChildren then
            ShowHideChildren(False);

          FOldColor := Color;
          if CollapsSteps > 0 then
          begin
            Color := CollapsColor;
            if FStatusBar.Visible then
              delta := (Height - FCaption.Height - FStatusBar.Height - 2 * BorderWidth) div CollapsSteps
            else
              delta := (Height - FCaption.Height - 2 * BorderWidth) div CollapsSteps;

            for i := 1 to CollapsSteps do
            begin
              Height := Height - delta;
              Application.ProcessMessages;
              Synchronize;
              Sleep(CollapsDelay);
            end;
          end;


          if FStatusBar.Visible then
            Height := FCaption.Height + FStatusBar.Height - 2 + bdelta
          else
            Height := FCaption.Height - 2 + bdelta;
        end
        else  // cpLeft
        begin
          FFullHeight := Width;
          if FAutoHideChildren then
            ShowHideChildren(False);
            
          FOldColor := Color;
          if CollapsSteps > 0 then
          begin
            Color := CollapsColor;

            if FStatusBar.Visible then
              delta := (Width - FCaption.Height - FStatusBar.Height) div CollapsSteps
            else
              delta := (Width - FCaption.Height) div CollapsSteps;

            for i := 1 to CollapsSteps do
            begin
              Width := Width - delta;
              Application.ProcessMessages;
              Synchronize;
              Sleep(CollapsDelay);
            end;
          end;

          if FStatusBar.Visible then
            Width := FCaption.Height + FStatusBar.Height + bdelta
          else
            Width := FCaption.Height + bdelta;
        end;
      end
      else
      begin

        if CollapsSteps > 0 then
        begin
          Color := FOldColor;

          if FStatusBar.Visible then
            delta := (FullHeight - FCaption.Height - FStatusBar.Height) div CollapsSteps
          else
            delta := (FullHeight - FCaption.Height) div CollapsSteps;

          for i := 1 to CollapsSteps do
          begin
            if FCaption.Position = cpTop then
              Height := Height + delta
            else   // cpLeft
              Width := Width + delta;

            Application.ProcessMessages;
            Synchronize;
            Sleep(CollapsDelay);
          end;
        end;

        if FCaption.Position = cpTop then
          Height := FFullHeight
        else
          Width := FFullHeight;

        if FAutoHideChildren then
          ShowHideChildren(True);
      end;

      Synchronize;
    end;
    FIsCollapsing := False;
  end;
  StateChange;

  if Assigned(FOnEndCollapsExpand) then
    FOnEndCollapsExpand(Self);
end;

procedure TCustomAdvPanel.Loaded;
begin
  inherited;
  
//  FFullHeight := Height;
//  if Collaps then Collaps := Collaps;

  if FPosition.Save then LoadPosition;

  FTopLeft := ClientOrigin;
  {$IFNDEF TMSDOTNET}
  FWidthHeight := Point(Width, Height);
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  FWidthHeight := Borland.Vcl.Types.Point(Width, Height);
  {$ENDIF}

  FOldCursor := Cursor;
  FOldColor := Color;

  if Assigned(Styler) then
    AssignStyle(Styler.Settings);
end;

function TCustomAdvPanel.GetHeightEx: integer;
begin
  Result := inherited Height;
end;

procedure TCustomAdvPanel.SetHeightEx(const Value: integer);
begin
  inherited Height := Value;
  if not FCollaps and not FIsCollapsing and (FCaption.Position = cpTop) then
    FFullHeight := Value;
end;

function TCustomAdvPanel.GetWidthEx: Integer;
begin
  Result := inherited Width;
end;

procedure TCustomAdvPanel.SetWidthEx(Value: Integer);
begin
  inherited Width := Value;
  if not FCollaps and not FIsCollapsing and (FCaption.Position = cpLeft) then
    FFullHeight := Value;
end;

function TCustomAdvPanel.IsAnchor(x, y: integer; var HoverRect: TRect): string;
var
  r,hr: TRect;
  xsize,ysize: Integer;
  a,s,fa: string;
  hl,ml: Integer;
  DrwRes: Boolean;
begin
  Result := '';
  DrwRes := false;     

  r := Clientrect;

  if (bevelInner <> bvNone) or (bevelOuter <> bvNone) then
  begin
    InflateRect(r,-BevelWidth,-BevelWidth);
  end;

  if FBorderShadow then
  begin
    r.Right := r.Right - 2;
    r.Bottom := r.Bottom - 2;
  end;

  InflateRect(r,-BorderWidth, -BorderWidth);
  InflateRect(r,-1, -1);

  r.Left := r.Left + Indent;
  r.Top := r.Top + TopIndent;

  //if FCaption.Position <> cpTop then
  //  R.Left := R.Left + FCaption.Height;

  a := '';

  Canvas.Font.Assign(Font);

  if FTextVAlign in [tvaCenter,tvaBottom] then
  begin
    HTMLDrawEx(Canvas,Text,r,FImages,0,0,-1,fHoverHyperLink,fShadowOffset,true,false,false,false,false,fHover,true,1.0,
      fURLColor,fHoverColor,FHoverFontColor,fShadowColor,a,s,fa,xsize,ysize,hl,ml,hr,FImageCache,FContainer,FLineSpacing);
  end;

  if FCaption.Visible and (((y < FCaption.Height) and (FCaption.Position = cpTop)) or ((X < FCaption.Height) and (FCaption.Position = cpLeft)) ) then
  begin
    if FCaption.Position = cpTop then
    begin
      r.Bottom := r.Top + FCaption.Height;

      if FTextVAlign in [tvaCenter,tvaBottom] then
      begin
        if ysize < (r.Bottom - r.Top) then
        case FTextVAlign of
        tvaCenter:r.Top := r.Top + (((r.Bottom - r.Top) - ysize) shr 1);
        tvaBottom:r.Top := r.Bottom - ysize;
        end;
      end;
      Canvas.Font.Assign(FCaption.Font);

      r.Left := r.Left + FCaption.Indent;
      r.Top := r.Top + FCaption.TopIndent;

      DrwRes := HTMLDrawEx(Canvas,FCaption.Text,r,fImages,x,y,-1,-1,2,true,false,false,false,false,false,true,1.0,
        FURLColor,clBlue,clRed,clgray,a,s,fa,xsize,ysize,hl,FCaptionHoverHyperlink,hoverrect,FImageCache,FContainer,FLineSpacing);
    end;
  end
  else
  begin
    if FCaption.Visible then
    begin
      if FCaption.Position = cpTop then
      begin
        r.Top := r.Top + FCaption.Height;
      end
      else
        r.Left := r.Left + FCaption.Height;
    end;



    if FTextVAlign in [tvaCenter,tvaBottom] then
    begin
      if ysize < (r.Bottom - r.Top) then
      case fTextVAlign of
      tvaCenter:r.Top := r.top + (((r.Bottom - r.Top) - ysize) shr 1);
      tvaBottom:r.Top := r.bottom - ysize;
      end;
    end;

    Canvas.Font.Assign(Font);

    r.Bottom := r.Bottom + 20;

    DrwRes := HTMLDrawEx(Canvas,Text,r,FImages,x,y,-1,-1,2,true,false,false,false,false,false,true,1.0,
      FURLColor,clBlue,clRed,clgray,a,s,fa,xsize,ysize,hl,FHoverHyperlink,hoverrect,FImageCache,FContainer,FLineSpacing);
  end;

  if DrwRes then
    Result := a;
end;

procedure TCustomAdvPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  r, hr: TRect;
  Anchor: string;
  GW: Integer;

begin
  inherited;

  Anchor := IsAnchor(x,y,hr);

  FInMove := False;

  if FCaption.Visible and not (csDesigning in ComponentState) then
  begin
    r := ClientRect;

    GW := 12;

    if (not FCaption.CloseMinGlyph.Empty and not FCaption.CloseMaxGlyph.Empty) then
      GW := FCaption.CloseMinGlyph.Width;

    if (not FCaption.MaxGlyph.Empty and not FCaption.MinGlyph.Empty)  then
      GW := FCaption.MaxGlyph.Width;

    if (FCaption.ShadeType = stXPCaption) and DoVisualStyles then
      GW := 16;

    if (FCaption.CloseButtonHoverColor <> clNone) then
    begin
      if FCaption.ButtonPosition = cbpRight then
      begin
        {$IFNDEF TMSDOTNET}
        if ((PtInRect(Rect(r.Right-2-GW,r.Top+2,r.Right-2,r.Top+2+GW),point(x,y)) and (FCaption.Position = cpTop)) or ((PtInRect(Rect(r.Left + 2, r.Top + 2, r.Left+ 2+ GW,r.Top+2 + GW),point(x,y))) and (FCaption.Position = cpLeft) )) and FCaption.CloseButton then
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        if ((PtInRect(Borland.Vcl.Types.Rect(r.Right-2-GW,r.Top+2,r.Right-2,r.Top+2+GW),Borland.Vcl.Types.Point(x,y)) and (FCaption.Position = cpTop))
          or ((PtInRect(Borland.Vcl.Types.Rect(r.Left + 2, r.Top + 2, r.Left+ 2+ GW,r.Top+2 + GW),Borland.Vcl.Types.Point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.CloseButton then
        {$ENDIF}
        begin
          if not FHoverCloseBtn then
          begin
            FHoverCloseBtn := True;
            Invalidate;
          end;
        end
        else if FHoverCloseBtn then
        begin
          FHoverCloseBtn := False;
          Invalidate;
        end;
      end
      else
      begin
        {$IFNDEF TMSDOTNET}
        if ((PtInRect(Rect(r.Left+2,r.Top+2,r.Left + GW + 2,r.Top + 2 + GW),point(x,y)) and (FCaption.Position = cpTop)) or ((PtInRect(Rect(r.Left+2, r.Bottom-2 - GW, r.Left + GW + 2,r.Bottom - 2),point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.CloseButton then
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        if ((PtInRect(Borland.Vcl.Types.Rect(r.Left+2,r.Top+2,r.Left + GW + 2,r.Top + 2 + GW),Borland.Vcl.Types.Point(x,y)) and (FCaption.Position = cpTop))
          or ((PtInRect(Borland.Vcl.Types.Rect(r.Left+2, r.Bottom-2 - GW, r.Left + GW + 2,r.Bottom - 2),Borland.Vcl.Types.Point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.CloseButton then
        {$ENDIF}
        begin
          if not FHoverCloseBtn then
          begin
            FHoverCloseBtn := True;
            Invalidate;
          end;
        end
        else if FHoverCloseBtn then
        begin
          FHoverCloseBtn := False;
          Invalidate;
        end;
      end;
    end;

    if (FCaption.MinMaxButtonHoverColor <> clNone) then
    begin
      if FCaption.ButtonPosition = cbpRight then
      begin
        if FCaption.CloseButton then
        begin
          if FCaption.Position = cpTop then
            r.Right := r.Right - GW
          else
            r.Top := r.Top + GW;
        end;
      end
      else
      begin
        if FCaption.CloseButton then
        begin
          if FCaption.Position = cpTop then
            r.Left := r.Left + GW
          else
            r.Bottom := r.Bottom - GW;
        end;
      end;

      if FCaption.ButtonPosition = cbpRight then
      begin
        {$IFNDEF TMSDOTNET}
        if ((PtInRect(Rect(r.Right-2-GW,r.Top+2,r.Right-2,r.Top+2+GW),point(x,y)) and (FCaption.Position = cpTop)) or ((PtInRect(Rect(r.Left+ 2, r.Top+ 2, r.Left+2+GW, r.Top+2+GW),point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.MinMaxButton then
        {$ENDIF}

        {$IFDEF TMSDOTNET}
        if ((PtInRect(Borland.Vcl.Types.Rect(r.Right-2-GW,r.Top+2,r.Right-2,r.Top+2+GW),Borland.Vcl.Types.point(x,y)) and (FCaption.Position = cpTop))
          or ((PtInRect(Borland.Vcl.Types.Rect(r.Left+ 2, r.Top+ 2, r.Left+2+GW, r.Top+2+GW),Borland.Vcl.Types.point(x,y))) and (FCaption.Position = cpLeft))) and FCaption.MinMaxButton then
        {$ENDIF}
        begin
          if not FHoverMinMaxBtn then
          begin
            FHoverMinMaxBtn := True;
            Invalidate;
          end;
        end
        else if FHoverMinMaxBtn then
        begin
          FHoverMinMaxBtn := False;
          Invalidate;
        end;
      end
      else
      begin
        {$IFNDEF TMSDOTNET}
        if ((PtInRect(Rect(r.Left + 2,r.Top + 2,r.Left + 2 + GW,r.Top+2+GW),point(x,y)) and (FCaption.Position = cpTop)) or ((PtInRect(Rect(r.Left + 2,r.Bottom - 2 - GW,r.Left + 2 + GW, r.Bottom - 2),point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.MinMaxButton then
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        if ((PtInRect(Borland.Vcl.Types.Rect(r.Left + 2,r.Top + 2,r.Left + 2 + GW,r.Top+2+GW),Borland.Vcl.Types.point(x,y)) and (FCaption.Position = cpTop))
          or ((PtInRect(Borland.Vcl.Types.Rect(r.Left + 2,r.Bottom - 2 - GW,r.Left + 2 + GW, r.Bottom - 2),Borland.Vcl.Types.point(x,y))) and (FCaption.Position = cpLeft)) ) and FCaption.MinMaxButton then
        {$ENDIF}
        begin
          if not FHoverMinMaxBtn then
          begin
            FHoverMinMaxBtn := True;
            Invalidate;
          end;
        end
        else if FHoverMinMaxBtn then
        begin
          FHoverMinMaxBtn := False;
          Invalidate;
        end;
      end;
    end;
  end;

  if ( ((y < FCaption.Height) and (FCaption.Position = cpTop)) or ((X < FCaption.Height) and (FCaption.Position = cpLeft)) ) and FCaption.Visible then
  begin

    if FHoverHyperLink <> -1 then
    begin
      {$IFNDEF TMSDOTNET}
      if FHover then InvalidateRect(Handle,@FCurrHoverRect,True);
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      if FHover then InvalidateRect(Handle,FCurrHoverRect,True);
      {$ENDIF}

      FHoverHyperLink := -1;
      FOldHoverHyperLink := -1;
    end;

    if Anchor <> '' then
    begin
      if (FAnchor <> Anchor) or not Equalrect(FCaptionCurrHoverRect,hr) or
         (FCaptionHoverHyperlink = -1) then
      begin
        if FAnchor <> '' then
          {$IFNDEF TMSDOTNET}
          if FHover then InvalidateRect(Handle,@FCaptionCurrHoverRect,True);
          {$ENDIF}
          {$IFDEF TMSDOTNET}
          if FHover then InvalidateRect(Handle,FCaptionCurrHoverRect,True);
          {$ENDIF}

        {$IFNDEF TMSDOTNET}
        if FHover then InvalidateRect(Handle,@hr,True);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        if FHover then InvalidateRect(Handle,hr,True);
        {$ENDIF}
      end;

      if (Cursor = FOldCursor) or (FAnchor <> Anchor) then
      begin
        if FAnchorHint then Application.CancelHint;
        Cursor := crHandPoint;
        if Assigned(FAnchorEnter) then FAnchorEnter(self,anchor);
        {$IFNDEF TMSDOTNET}
        if FHover then InvalidateRect(Handle,@hr,true);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        if FHover then InvalidateRect(Handle,hr,true);
        {$ENDIF}
       end;

       FAnchor := Anchor;
       FCaptionCurrHoverRect := hr;
     end
    else
    begin
      if Cursor = crHandPoint then
      begin
        Cursor := FOldCursor;
        if Assigned(FAnchorExit) then FAnchorExit(self,anchor);
        FCaptionHoverHyperlink := -1;
        {$IFNDEF TMSDOTNET}
        if FHover then InvalidateRect(self.handle,@FCaptionCurrHoverRect,True);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        if FHover then InvalidateRect(self.handle,FCaptionCurrHoverRect,True);
        {$ENDIF}

      end;
    end;
  end
  else
  begin
    if FCaptionHoverHyperLink <> -1 then
    begin
      FCaptionHoverHyperlink := -1;
      {$IFNDEF TMSDOTNET}
      if FHover then InvalidateRect(self.handle,@FCaptionCurrHoverRect,True);
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      if FHover then InvalidateRect(self.handle,FCaptionCurrHoverRect,True);
      {$ENDIF}
    end;

    if (Anchor <> '') then
    begin
      if (FAnchor <> Anchor) or not Equalrect(FCurrHoverRect,hr) or
         (FHoverHyperlink = -1) or (FHoverHyperLink <> FOldHoverHyperLink) then
      begin
        InflateRect(FCurrHoverRect,1,1);
        {$IFNDEF TMSDOTNET}
        if FHover then InvalidateRect(Handle,@FCurrHoverRect,True);
        if FHover then InvalidateRect(Handle,@hr,True);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        if FHover then InvalidateRect(Handle,FCurrHoverRect,True);
        if FHover then InvalidateRect(Handle,hr,True);
        {$ENDIF}

      end;

      if (Cursor = FOldCursor) or (FAnchor <> Anchor) then
      begin
        if FAnchorHint then Application.CancelHint;
        Cursor := crHandPoint;
        if Assigned(FAnchorEnter) then FAnchorEnter(Self,Anchor);
        {$IFNDEF TMSDOTNET}
        if FHover then InvalidateRect(self.handle,@hr,true);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        if FHover then InvalidateRect(self.handle,hr,true);
        {$ENDIF}

      end;

      FAnchor := Anchor;
      FCurrHoverRect := hr;
      FOldHoverHyperLink := FHoverHyperLink;
    end
    else
    begin
      if (Cursor = crHandPoint) then
      begin
        Cursor := FOldCursor;
        if Assigned(FAnchorExit) then FAnchorExit(Self,Anchor);

        Inflaterect(FCurrHoverRect,1,1);

        FHoverHyperLink := -1;
        FOldHoverHyperLink := -1;

        {$IFNDEF TMSDOTNET}
        if FHover then InvalidateRect(Handle,@FCurrHoverRect,True);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        if FHover then InvalidateRect(Handle,FCurrHoverRect,True);
        {$ENDIF}
      end;
    end;
  end;
end;

procedure TCustomAdvPanel.SetHover(const Value: boolean);
begin
  FHover := Value;
end;

procedure TCustomAdvPanel.CMMouseEnter(var Msg: TMessage);
begin
   if Assigned(FOnMouseEnter) then
     FOnMouseEnter(Self);
  inherited;
end;

procedure TCustomAdvPanel.CMMouseLeave(var Msg: TMessage);
begin
  if (FHoverHyperlink>=0) then
  begin
    FHoverHyperlink:=-1;
    inflaterect(fCurrHoverRect,1,1);
    {$IFNDEF TMSDOTNET}
    if fHover then invalidaterect(self.handle,@fcurrhoverrect,true);
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    if fHover then invalidaterect(self.handle,fcurrhoverrect,true);
    {$ENDIF}
  end;

  if (FCaptionHoverHyperlink>=0) then
  begin
    FCaptionHoverHyperlink:=-1;
    inflaterect(fCaptionCurrHoverRect,1,1);
    {$IFNDEF TMSDOTNET}
    if FHover then
      InvalidateRect(self.handle,@FCaptioncurrhoverrect,true);
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    if FHover then
      InvalidateRect(self.handle,FCaptioncurrhoverrect,true);
    {$ENDIF}
   end;

   if Assigned(FOnMouseLeave) then
     FOnMouseLeave(Self);

   if FHoverCloseBtn or FHoverMinMaxBtn then
   begin
     FHoverCloseBtn := False;
     FHoverMinMaxBtn := False;
     Invalidate;
   end;

  inherited;
end;

procedure TCustomAdvPanel.SetShadowColor(const Value: TColor);
begin
  FShadowColor := Value;
  Invalidate;
end;

procedure TCustomAdvPanel.SetShadowOffset(const Value: integer);
begin
  FShadowOffset := Value;
  Invalidate;
end;


procedure TCustomAdvPanel.WMNCHitTest(var Msg: TWMNCHitTest);
var
  r: TRect;
  pt: TPoint;
  GW: Integer;

begin
  inherited;

  if (csDesigning in ComponentState) then Exit;

  GW := 12;

  if not FCaption.CloseMinGlyph.Empty and not FCaption.CloseMaxGlyph.Empty then
    GW := FCaption.CloseMinGlyph.Width;

  if not FCaption.MinGlyph.Empty and not FCaption.MaxGlyph.Empty then
    GW := FCaption.MinGlyph.Width;

  if (FCaption.ShadeType = stXPCaption) and DoVisualStyles then
    GW := 16;

  r := ClientRect;
  if FCaption.Position = cpTop then
  begin
    if FCaption.ButtonPosition = cbpRight then
    begin
      if FCaption.FCloseButton then r.Right := r.Right - GW;
      if FCaption.FMinMaxButton then r.Right := r.Right - GW;
    end
    else
    begin
      if FCaption.FCloseButton then r.Left := r.Left + GW;
      if FCaption.FMinMaxButton then r.Left := r.Left + GW;
    end;
  end
  else   // cpLeft
  begin
    if FCaption.ButtonPosition = cbpRight then
    begin
      if FCaption.FCloseButton then r.Top := r.Top + GW;
      if FCaption.FMinMaxButton then r.Top := r.Top + GW;
    end
    else
    begin
      if FCaption.FCloseButton then r.Bottom := r.Bottom - GW;
      if FCaption.FMinMaxButton then r.Bottom := r.Bottom - GW;
    end;
  end;

  {$IFNDEF TMSDOTNET}
  pt := ScreenToClient(point(msg.xpos,msg.ypos));
  {$ENDIF}

  {$IFDEF TMSDOTNET}
  pt := ScreenToClient(Borland.Vcl.Types.Point(msg.xpos,msg.ypos));
  {$ENDIF}

  if (FCaption.Visible) and (((pt.y < FCaption.Height) and (pt.x < r.right) and (pt.X > r.Left) and (FCaption.Position = cpTop))
      or ((pt.x < FCaption.Height) and (pt.Y < r.Bottom) and (pt.Y > r.Top) and (FCaption.Position = cpLeft)))
     and (IsAnchor(pt.x,pt.y,r)='')
     and (Msg.Result = htClient) and FCanMove then
  begin
    MouseMove([],pt.X,pt.Y);
    Msg.Result := htCaption;
    FInMove := true;
    SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
  end;

  if (Msg.Result = htClient) and FCanSize and not FCollaps then
  begin
    if not FFixedHeight and not FFixedWidth and (pt.y > Height - GetSystemMetrics(SM_CYSIZEFRAME) - 2) and (pt.x > width - GetSystemMetrics(SM_CXSIZEFRAME) - 2) then
    begin
      SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
      Msg.Result := HTBOTTOMRIGHT;
    end

    else if not FFixedHeight and (pt.y > height - GetSystemMetrics(SM_CYSIZEFRAME)) then
    begin
      SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
      Msg.Result := HTBOTTOM;
    end
    else if not FFixedWidth and (pt.x > width - GetSystemMetrics(SM_CXSIZEFRAME)) then
    begin
      SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
      Msg.Result := HTRIGHT;
    end;

  end;

end;

procedure TCustomAdvPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TCustomAdvPanel.SetCanSize(const Value: boolean);
begin
  FCanSize := Value;
  Invalidate;
end;

procedure TCustomAdvPanel.SetBorderShadow(const Value: Boolean);
begin
  FBorderShadow := Value;
  Invalidate;
end;

procedure TCustomAdvPanel.SetTextVAlign(const Value: TTextVAlignment);
begin
  FTextVAlign := Value;
  Invalidate;
end;

{$IFNDEF TMSDOTNET}
procedure TCustomAdvPanel.CMHintShow(var Msg: TMessage);
var
  CanShow: Boolean;
  hi: PHintInfo;
  anchor:string;
  hr:trect;

Begin
  CanShow := True;
  hi := PHintInfo(Msg.LParam);

  if FAnchorHint then
  begin
    anchor := IsAnchor(hi^.cursorPos.x,hi^.cursorpos.y,hr);
    if (anchor<>'') then
    begin
      if Assigned(FOnAnchorHint) then
        FOnAnchorHint(self,anchor);

     hi^.HintPos := clienttoscreen(hi^.CursorPos);
     hi^.hintpos.y := hi^.hintpos.y-10;
     hi^.hintpos.x := hi^.hintpos.x+10;
     hi^.HintStr := anchor;
    end;
  end;
 Msg.Result := Ord(Not CanShow);

end;
{$ENDIF}

{$IFDEF TMSDOTNET}
procedure TCustomAdvPanel.CMHintShow(var Message: TCMHintShow);
var
  CanShow: Boolean;
  hi: THintInfo;
  anchor:string;
  hr:trect;

Begin
  CanShow := True;
  hi := Message.HintInfo;

  if FAnchorHint then
  begin
    anchor := IsAnchor(hi.cursorPos.x,hi.cursorpos.y,hr);
    if (anchor<>'') then
    begin
      if Assigned(FOnAnchorHint) then
        FOnAnchorHint(self,anchor);

     hi.HintPos := clienttoscreen(hi.CursorPos);
     hi.hintpos.y := hi.hintpos.y-10;
     hi.hintpos.x := hi.hintpos.x+10;
     hi.HintStr := anchor;
    end;
  end;
 Message.Result := Ord(Not CanShow);
end;
{$ENDIF}


{$IFNDEF TMSDOTNET}
procedure TCustomAdvPanel.WMEraseBkGnd(var Message: TMessage);
begin
  if FOptimizePaint then
  begin
    message.Result := 1;
    Exit;
  end
  else
    inherited;
end;
{$ENDIF}

procedure TCustomAdvPanel.SavePosition;
var
  {$IFDEF DELPHI4_LVL}
  IniFile: TCustomIniFile;
  {$ELSE}
  IniFile: TIniFile;
  {$ENDIF}

begin
  if (FPosition.Key <> '') and
     (FPosition.Section <> '') and
     (not (csDesigning in ComponentState)) then
  begin
    {$IFDEF DELPHI4_LVL}
    if FPosition.Location = clRegistry then
      IniFile := TRegistryIniFile.Create(FPosition.Key)
    else
   {$ENDIF}
      IniFile := TIniFile.Create(FPosition.Key);

    with IniFile do
    begin
      WriteInteger(FPosition.Section,'Top',Top);
      WriteInteger(FPosition.Section,'Left',Left);
      WriteInteger(FPosition.Section,'Height',Height);
      WriteInteger(FPosition.Section,'FullHeight',FFullHeight);
      WriteInteger(FPosition.Section,'Width',Width);
      if Collaps then
        WriteInteger(FPosition.Section,'Collaps',1)
      else
        WriteInteger(FPosition.Section,'Collaps',0);
    end;
    IniFile.Free;
  end;
end;

procedure TCustomAdvPanel.LoadPosition;
var
  {$IFDEF DELPHI4_LVL}
  IniFile: TCustomIniFile;
  {$ELSE}
  IniFile: TInifile;
  {$ENDIF}
begin
  if (FPosition.Key<>'') and
     (FPosition.Section<>'') and
     (not (csDesigning in ComponentState)) then
  begin
    {$IFDEF DELPHI4_LVL}
    if FPosition.Location = clRegistry then
      Inifile := TRegistryIniFile.Create(FPosition.Key)
    else
    {$ENDIF}
      Inifile := TIniFile.Create(FPosition.Key);

    with Inifile do
    begin
      Top := ReadInteger(FPosition.Section,'Top',Top);
      Left := ReadInteger(FPosition.Section,'Left',Left);
      Height := ReadInteger(FPosition.Section,'Height',Height);
      Width := ReadInteger(FPosition.Section,'Width',Width);
      Collaps := ReadInteger(FPosition.Section,'Collaps',0) = 1;
      FFullHeight := ReadInteger(FPosition.Section,'FullHeight',Height);
    end;

    IniFile.Free;
  end;
end;

procedure TCustomAdvPanel.WndProc(var Message: tMessage);
begin
  inherited;
  if Message.Msg = WM_DESTROY then
  begin
    if Assigned(FPosition) then
      if FPosition.Save then SavePosition;
  end;
end;

{$IFNDEF TMSDOTNET}
procedure TCustomAdvPanel.WMSizing(var Msg: TMessage);
var
  r: PRect;
begin
  if csDesigning in ComponentState then
    inherited
  else
  begin
    r := PRect(msg.LParam);

    if FFixedWidth then
    begin
      r.Right := r.Left + FWidthHeight.X;
    end;

    if FFixedHeight then
    begin
      r.Bottom := r.Top + FWidthHeight.Y;
    end;

    if FCaption.Position = cpTop then
      FFullHeight := r.Bottom - r.Top
    else
      FFullHeight := r.Right - r.Left;

    msg.Result := 0;

    if r.Right - r.Left <> Width then
      ShadeHeader;
  end;
end;
{$ENDIF}

{$IFNDEF TMSDOTNET}
procedure TCustomAdvPanel.WMSize(var Msg: TMessage);
{$ENDIF}
{$IFDEF TMSDOTNET}
procedure TCustomAdvPanel.WMSize(var Message: TWMSize);
{$ENDIF}
begin
  inherited;

  if Width <> FShadedHeader.Width then
    ShadeHeader;
end;

procedure TCustomAdvPanel.BeginUpdate;
begin
  SendMessage(Handle,WM_SETREDRAW,Integer(False),0);

end;

procedure TCustomAdvPanel.EndUpdate;
begin
  SendMessage(Handle,WM_SETREDRAW,Integer(True),0);
  Repaint;
end;


{$IFNDEF TMSDOTNET}
procedure TCustomAdvPanel.WMMoving(var Msg: TMessage);
var
  r: PRect;
  w: Integer;
begin
  FTopLeft := ClientOrigin;

  if csDesigning in ComponentState then
    inherited
  else
  begin
    r := PRect(msg.LParam);

    if FFixedLeft then
    begin
      w := r.Right - r.Left;
      r.Left := FTopLeft.X;
      r.Right := r.Left + w;
    end;

    if FFixedTop then
    begin
      w := r.Bottom - r.Top;
      r.Top := FTopLeft.Y;
      r.Bottom := r.Top + w;
    end;

    msg.Result := 0;
  end;
end;
{$ENDIF}

procedure TCustomAdvPanel.SetGradientDirection(const Value: TGradientDirection);
begin
  FGradientDirection := Value;
  Invalidate;
end;

procedure TCustomAdvPanel.WMEnterSizeMove(var Msg: TMessage);
begin
  FTopLeft := ClientOrigin;
  {$IFNDEF TMSDOTNET}
  FWidthHeight := Point(Width, Height);
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  FWidthHeight := Borland.Vcl.Types.Point(Width, Height);
  {$ENDIF}
end;

procedure TCustomAdvPanel.WMExitSizeMove(var Msg: TMessage);
begin
  inherited;
  if Assigned(FOnEndMoveSize) then
    FOnEndMoveSize(Self);
  Synchronize;
end;

procedure TCustomAdvPanel.CreateWnd;
var
  APG: TAdvPanelGroup;
begin
  inherited;
  if (Parent is TAdvPanelGroup) and (csDesigning in ComponentState) then
  begin
    APG := Parent as TAdvPanelGroup;

    if APG.FGroupStyle = gsVertical then
    begin
      Width := APG.Width - 2*APG.HorzPadding;
      Left := APG.HorzPadding;
      if Top < APG.VertPadding then
        Top := APG.VertPadding;
    end;

    if APG.FGroupStyle = gsHorizontal then
    begin
      Height := APG.Height - 2*APG.HorzPadding;
      Top := APG.VertPadding;
      if Left < APG.HorzPadding then
        Left := APG.HorzPadding;
    end;
  end;
end;


procedure TCustomAdvPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  i: Integer;
begin
  inherited;

  if csDesigning in ComponentState then
    Synchronize;

  if (FOldWidth <> AWidth) or (FOldHeight <> AHeight) then
  begin
    for i := 1 to ControlCount do
    begin
      Controls[i - 1].Invalidate;
    end;
    Invalidate;
  end;

  FOldWidth := AWidth;
  FOldHeight := AHeight;

end;

procedure TCustomAdvPanel.SetCursor(ACursor: TCursor);
begin
  FOldCursor := ACursor;
  Cursor := ACursor;
end;

procedure TCustomAdvPanel.Synchronize;
begin  
  if (Parent is TAdvPanelGroup) then
    with (Parent as TAdvPanelGroup) do
      ChildPanelChanged(Self);
end;

procedure TCustomAdvPanel.WMSetCursor(var Msg: TWMSetCursor);
begin
  inherited;
  if FInMove and FShowMoveCursor then
  begin
    {$IFDEF DELPHI4_LVL}
    SetCursor(Screen.Cursors[crSizeAll]);
    {$ENDIF}
  end;
end;

function TCustomAdvPanel.DoVisualStyles: Boolean;
begin
  if FIsWinXP then
    Result := IsThemeActive
  else
    Result := False;
end;


procedure TCustomAdvPanel.ShowHideChildren(Show: Boolean);
var
  i: Integer;
begin
  for i := 1 to ControlCount do
  begin
    if Show then
    begin
      if not (FHideList.IndexOf(Controls[i - 1]) >= 0) then
        Controls[i - 1].Visible := Show;
    end
    else
    begin
      if not Controls[i - 1].Visible then
        FHideList.Add(Controls[i - 1]);
      Controls[i - 1].Visible := Show;
    end;
  end;

  if Show then
    FHideList.Clear;
end;

procedure TCustomAdvPanel.WMLDblClk(var Message: TWMLButtonDblClk);
var
  r: TRect;
begin
  inherited;
  if FCaption.Visible then
  begin
    r := ClientRect;
    {$IFNDEF TMSDOTNET}
    if ((PtInRect(rect(r.Left,r.Top,r.Right-2,r.Top + FCaption.Height),point(Message.XPos,Message.YPos)) and (FCaption.Position = cpTop))
      or ((PtInRect(rect(r.Left,r.Top,r.Left + FCaption.Height,r.Bottom),point(Message.XPos,Message.YPos))) and (FCaption.Position = cpLeft))) then
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    if ((PtInRect(Borland.Vcl.types.rect(r.Left,r.Top,r.Right-2,r.Top + FCaption.Height),Borland.Vcl.types.point(Message.XPos,Message.YPos)) and (FCaption.Position = cpTop))
      or ((PtInRect(Borland.Vcl.types.rect(r.Left,r.Top,r.Left + FCaption.Height,r.Bottom),Borland.Vcl.types.point(Message.XPos,Message.YPos))) and (FCaption.Position = cpLeft))) then
    {$ENDIF}

    begin
      if Assigned(FOnCaptionDblClick) then
        FOnCaptionDblClick(Self);
    end;
  end;
end;

procedure TCustomAdvPanel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('FullHeight', LoadFullHeight, StoreFullHeight, True);
end;

procedure TCustomAdvPanel.LoadFullHeight(Reader: TReader);
begin
  FFullHeight := Reader.ReadInteger;
end;

procedure TCustomAdvPanel.StoreFullHeight(Writer: TWriter);
begin
  Writer.WriteInteger(FFullHeight);
end;


procedure TCustomAdvPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  if FCaption.Visible then
  begin
    if FCaption.Position = cpTop then
    begin
      if Rect.Top < FCaption.Height then
        Rect.Top := FCaption.Height - 2;
    end
    else    // cpLeft
    begin
      if Rect.Left < FCaption.Height then
        Rect.Left := FCaption.Height - 2;
    end;
  end;

  if FStatusBar.Visible then
  begin
    if FCaption.Position = cpTop then
    begin
      if Rect.Bottom > Height - FStatusBar.Height then
        Rect.Bottom := Height - FStatusBar.Height;
    end
    else
    begin
      if Rect.Right > Width - FStatusBar.Height then
        Rect.Right := Width - FStatusBar.Height;
    end;
  end;

  inherited;
end;

procedure TCustomAdvPanel.SetAutoSizeEx(const Value: TAutoSize);
begin
  if (csLoading in ComponentState) then
    Exit;
  if not Assigned(Value) then
    Exit;
  if (Value is TAutoSize) then
    FAutoSize.Assign(Value);
end;

procedure TCustomAdvPanel.DoAutoSize;
var
  r: TRect;
  a,s,fa: string;
  hr: TRect;
  hl,ml: Integer;
  XSize,YSize: Integer;
begin
  if not FAutoSize.Enabled then
    Exit;

  if (csLoading in ComponentState) then
    Exit;

  {$IFNDEF TMSDOTNET}
  r := Rect(0,0,0,0);
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  r := Borland.Vcl.Types.Rect(0,0,0,0);
  {$ENDIF}

  if FAutoSize.Width then
    r.Right := $FFFF
  else
    r.Right := Width - 2 * BevelWidth;

  if FAutoSize.Height then
    r.Bottom := $FFFF
  else
    r.Bottom := Height - 2 * BevelWidth;

  Canvas.Font.Assign(self.Font);

  HTMLDrawEx(Canvas,Text,r,FImages,0,0,-1,FHoverHyperLink,FShadowOffset,false,True,false,false,false,FHover,true,
    1.0,FURLColor,FHoverColor,fHoverFontColor,fShadowColor,a,s,fa,xsize,ysize,hl,ml,hr,FImageCache,FContainer,FLineSpacing);

  XSize := XSize + 2 * BorderWidth;
  YSize := YSize + 2 * BorderWidth;

  if FAutoSize.Width then
  begin
    if FCaption.Position = cpTop then
      Width := Xsize + 2 * BevelWidth + Indent
    else   // cpLeft
    begin
      if FCaption.Visible then
      begin
        if FStatusBar.Visible then
          Width := XSize + FCaption.Height + FStatusBar.Height + 2 * BevelWidth + Indent
        else
          Width := XSize + FCaption.Height + 2 * BevelWidth + Indent;
      end
      else
      begin
        if FStatusBar.Visible then
          Width := XSize + FStatusBar.Height + 2 * BevelWidth + Indent
        else
          Width := XSize + 2 * BevelWidth + Indent;
      end;
    end;
  end;

  if FAutoSize.Height then
  begin
    if FCaption.Position = cpTop then
    begin
      if FCaption.Visible then
      begin
        if FStatusBar.Visible then
          Height := YSize + FCaption.Height + FStatusBar.Height + 2 * BevelWidth + TopIndent + 2 * BorderWidth
        else
          Height := YSize + FCaption.Height + 2 * BevelWidth + TopIndent;
      end
      else
      begin
        if FStatusBar.Visible then
          Height := YSize + FStatusBar.Height + 2 * BevelWidth + TopIndent
        else
          Height := YSize + 2 * BevelWidth + TopIndent;
      end;
    end
    else
      Width := Ysize + 2 * BevelWidth + TopIndent
  end;

  Synchronize;
end;

procedure TCustomAdvPanel.StateChange;
begin

end;

procedure TCustomAdvPanel.Resize;
begin
  if not OptimizePaint then
    Paint;
  inherited Resize;
  DoAutoSize;
end;


procedure TCustomAdvPanel.WMPaint(var Msg: TWMPAINT);
var
  DC: HDC;
begin
  DC := GetDC(Handle);
  Canvas.Handle := DC;
  Canvas.Brush.Color := clWhite;
  ReleaseDC(Handle,DC);
  inherited;
end;


procedure TCustomAdvPanel.SetColorTo(const Value: TColor);
begin
  if (FColorTo <> Value) then
  begin
    FColorTo := Value;
    Invalidate;
  end;
end;

procedure TCustomAdvPanel.SetColorMirror(const Value: TColor);
begin
  if (FColorMirror <> Value) then
  begin
    FColorMirror := Value;
    Invalidate;
  end;
end;

procedure TCustomAdvPanel.SetColorMirrorTo(const Value: TColor);
begin
  if (FColorMirrorTo <> Value) then
  begin
    FColorMirrorTo := Value;
    Invalidate;
  end;
end;

procedure TCustomAdvPanel.SetEllipsis(const Value: Boolean);
begin
  FEllipsis := Value;
  Invalidate;
end;


procedure TCustomAdvPanel.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
  Invalidate;
end;

procedure TCustomAdvPanel.SetIndex(const Value: Integer);
begin
  FIndex := Value;
end;

procedure TCustomAdvPanel.Assign(Source: TPersistent);
begin

  AnchorHint := (Source as TCustomAdvPanel).AnchorHint;
//  AutoSize := (Source as TCustomAdvPanel).AutoSize;
  AutoHideChildren := (Source as TCustomAdvPanel).AutoHideChildren;
  {$IFNDEF TMSDOTNET}
  Background.Assign((Source as TCustomAdvPanel).Background);
  {$ENDIF}
  BackgroundPosition := (Source as TCustomAdvPanel).BackgroundPosition;
  BevelInner := (Source as TCustomAdvPanel).BevelInner;
  BevelOuter := (Source as TCustomAdvPanel).BevelOuter;
  BevelWidth := (Source as TCustomAdvPanel).BevelWidth;
  BorderColor := (Source as TCustomAdvPanel).BorderColor;
  BorderShadow := (Source as TCustomAdvPanel).BorderShadow;
  BorderStyle := (Source as TCustomAdvPanel).BorderStyle;
  CanMove := (Source as TCustomAdvPanel).CanMove;
  CanSize := (Source as TCustomAdvPanel).CanSize;
  Caption.Assign((Source as TCustomAdvPanel).Caption);
//  Collaps := (Source as TCustomAdvPanel).Collaps;
  CollapsColor := (Source as TCustomAdvPanel).CollapsColor;
  CollapsDelay := (Source as TCustomAdvPanel).CollapsDelay;
  CollapsSteps := (Source as TCustomAdvPanel).CollapsSteps;
  Color := (Source as TCustomAdvPanel).Color;
  ColorTo := (Source as TCustomAdvPanel).ColorTo;
  ColorMirror := (Source as TCustomAdvPanel).ColorMirror;
  ColorMirrorTo := (Source as TCustomAdvPanel).ColorMirrorTo;  
  {$IFDEF DELPHI4_LVL}
//  Constraints := (Source as TCustomAdvPanel).Constraints;
  {$ENDIF}
  Cursor := (Source as TCustomAdvPanel).Cursor;
  {$IFDEF DELPHI4_LVL}
//  DockSite := (Source as TCustomAdvPanel).DockSite;
  {$ENDIF}
//  DragCursor := (Source as TCustomAdvPanel).DragCursor;
  {$IFDEF DELPHI4_LVL}
//  DragKind := (Source as TCustomAdvPanel).DragKind;
  {$ENDIF}
//  DragMode := (Source as TCustomAdvPanel).DragMode;
  Enabled := (Source as TCustomAdvPanel).Enabled;

  Font.Assign((Source as TCustomAdvPanel).Font);
  FixedTop := (Source as TCustomAdvPanel).FixedTop;
  FixedLeft := (Source as TCustomAdvPanel).FixedLeft;
  FixedHeight := (Source as TCustomAdvPanel).FixedHeight;
  FixedWidth := (Source as TCustomAdvPanel).FixedWidth;
  FreeOnClose := (Source as TCustomAdvPanel).FreeOnClose;
  Height := (Source as TCustomAdvPanel).Height;
  HelpContext := (Source as TCustomAdvPanel).HelpContext;
  Hint := (Source as TCustomAdvPanel).Hint;
  Hover := (Source as TCustomAdvPanel).Hover;
  HoverColor := (Source as TCustomAdvPanel).HoverColor;
  HoverFontColor := (Source as TCustomAdvPanel).HoverFontColor;
  Images := (Source as TCustomAdvPanel).Images;
//  Locked := (Source as TCustomAdvPanel).Locked;
  ParentColor := (Source as TCustomAdvPanel).ParentColor;
  ParentFont := (Source as TCustomAdvPanel).ParentFont;
  ParentShowHint := (Source as TCustomAdvPanel).ParentShowHint;
  PictureContainer := (Source as TCustomAdvPanel).PictureContainer;

  PopupMenu := (Source as TCustomAdvPanel).PopupMenu;

  Position.Assign((Source as TCustomAdvPanel).Position);

  StatusBar.Assign((Source as TCustomAdvPanel).StatusBar);
  ShadowColor := (Source as TCustomAdvPanel).ShadowColor;
  ShadowOffset := (Source as TCustomAdvPanel).ShadowOffset;
  ShowHint := (Source as TCustomAdvPanel).ShowHint;
  ShowMoveCursor := (Source as TCustomAdvPanel).ShowMoveCursor;
  TabStop := (Source as TCustomAdvPanel).TabStop;
  Tag := (Source as TCustomAdvPanel).Tag;

  Text := (Source as TCustomAdvPanel).Text;
  TextVAlign := (Source as TCustomAdvPanel).TextVAlign;
  URLColor := (Source as TCustomAdvPanel).URLColor;
  {$IFDEF DELPHI4_LVL}
//  UseDockManager := (Source as TCustomAdvPanel).UseDockManager;
  {$ENDIF}
  Visible := (Source as TCustomAdvPanel).Visible;
end;

procedure TCustomAdvPanel.CaptionChange(Sender: TObject);
begin
  if self.ControlCount > 0 then
    Realign;
  Invalidate;
end;

procedure TCustomAdvPanel.CaptionShadeChange(Sender: TObject);
begin
  ShadeHeader;
end;

procedure TCustomAdvPanel.CaptionStateChange(Sender: TObject);
begin
  StateChange;
end;

procedure TCustomAdvPanel.ChangeScale(M, D: integer);
begin
  inherited;
  Caption.FHeight    := MulDiv(Caption.FHeight, M, D);
  Caption.FFont.Size := MulDiv(Caption.FFont.Size, M, D);
end;

procedure TCustomAdvPanel.AssignSettings(Settings: TAdvPanelSettings);
begin
  AssignStyle(Settings);
  Height := Settings.Height;
  Width := Settings.Width;
  Hint := Settings.Hint;
end;

procedure TCustomAdvPanel.AssignStyle(Settings: TAdvPanelSettings);
var
  CaptionCloseButton, CaptionMinMaxButton: Boolean;
begin
  AnchorHint := Settings.AnchorHint;
  AutoHideChildren := Settings.AutoHideChildren;
  BevelInner := Settings.BevelInner;
  BevelOuter := Settings.BevelOuter;
  BevelWidth := Settings.BevelWidth;
  BorderColor := Settings.BorderColor;
  BorderShadow := Settings.BorderShadow;
  BorderStyle := Settings.BorderStyle;
  BorderWidth := Settings.BorderWidth;
  CanMove := Settings.CanMove;
  CanSize := Settings.CanSize;

// CloseButton and MinMaxButton are independent on style
  CaptionCloseButton := Caption.CloseButton;
  CaptionMinMaxButton := Caption.MinMaxButton;
  Caption.Assign(Settings.Caption);
  Caption.MinMaxButton := CaptionMinMaxButton;
  Caption.CloseButton := CaptionCloseButton;

  //Collaps := Settings.Collaps;
  CollapsColor := Settings.CollapsColor;
  CollapsDelay := Settings.CollapsDelay;
  CollapsSteps := Settings.CollapsSteps;
  Color := Settings.Color;
  ColorTo := Settings.ColorTo;
  ColorMirror := Settings.ColorMirror;
  ColorMirrorTo := Settings.ColorMirrorTo;
  Cursor := Settings.Cursor;
  Font.Assign(Settings.Font);
  FixedTop := Settings.FixedTop;
  FixedLeft := Settings.FixedLeft;
  FixedHeight := Settings.FixedHeight;
  FixedWidth := Settings.FixedWidth;
  Hover := Settings.Hover;
  HoverColor := Settings.HoverColor;
  HoverFontColor := Settings.HoverFontColor;
  Indent := Settings.Indent;
  // Position := Settings.Position;
  ShadowColor := Settings.ShadowColor;
  ShadowOffset := Settings.ShadowOffset;
  ShowHint := Settings.ShowHint;
  ShowMoveCursor := Settings.ShowMoveCursor;
  StatusBar.Assign(Settings.StatusBar);
  // Text := Settings.Text;
  TextVAlign := Settings.TextVAlign;
  TopIndent := Settings.TopIndent;
  URLColor := Settings.URLColor;
end;


procedure TCustomAdvPanel.SetIndent(const Value: Integer);
begin
  FIndent := Value;
  Invalidate;
end;

procedure TCustomAdvPanel.SetTopIndent(const Value: Integer);
begin
  FTopIndent := Value;
  Invalidate;
end;

procedure TCustomAdvPanel.SetStyler(const Value: TAdvPanelStyler);
begin
  FStyler := Value;
  if not (csLoading in ComponentState) then
    if Assigned(FStyler) then
      if Assigned(FStyler.Settings) then
        AssignStyle(FStyler.Settings);
end;

procedure TCustomAdvPanel.SetLineSpacing(const Value: Integer);
begin
  FLineSpacing := Value;
  Invalidate;
end;

function TCustomAdvPanel.GetRawText: string;
begin
  Result := HTMLStrip(FText);
end;

function TCustomAdvPanel.GetVersionComp: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TCustomAdvPanel.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TCustomAdvPanel.SetVersion(const Value: string);
begin

end;

{ TPanelCaption }

procedure TPanelCaption.Assign(Source: TPersistent);
begin
  Background.Assign((Source as TPanelCaption).Background);
  ButtonPosition := (Source as TPanelCaption).ButtonPosition;
  Color := (Source as TPanelCaption).Color;
  ColorTo := (Source as TPanelCaption).ColorTo;
  CloseColor := (Source as TPanelCaption).CloseColor;
  CloseButton := (Source as TPanelCaption).CloseButton;
  CloseButtonColor := (Source as TPanelCaption).CloseButtonColor;
  CloseButtonHoverColor := (Source as TPanelCaption).CloseButtonHoverColor;
  CloseMinGlyph.Assign((Source as TPanelCaption).CloseMinGlyph);
  CloseMaxGlyph.Assign((Source as TPanelCaption).CloseMaxGlyph);
  Flat := (Source as TPanelCaption).Flat;
  Font.Assign((Source as TPanelCaption).Font);
  Height := (Source as TPanelCaption).Height;
  Indent := (Source as TPanelCaption).Indent;
  MaxGlyph.Assign((Source as TPanelCaption).MaxGlyph);
  MinGlyph.Assign((Source as TPanelCaption).MinGlyph);
  MinMaxButton := (Source as TPanelCaption).MinMaxButton;
  MinMaxButtonColor := (Source as TPanelCaption).MinMaxButtonColor;
  MinMaxButtonHoverColor := (Source as TPanelCaption).MinMaxButtonHoverColor;
  ShadeLight := (Source as TPanelCaption).ShadeLight;
  ShadeGrain := (Source as TPanelCaption).ShadeGrain;
  ShadeType := (Source as TPanelCaption).ShadeType;
  Shape := (Source as TPanelCaption).Shape;
  // Text := (Source as TPanelCaption).Text;
  // TopIndent := (Source as TPanelCaption).TopIndent;
  // Position := (Source as TPanelCaption).Position;
  // Visible := (Source as TPanelCaption).Visible;
  GradientDirection := (Source as TPanelCaption).GradientDirection;
end;

procedure TPanelCaption.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TPanelCaption.Create;
begin
  inherited Create;
  FFont := TFont.Create;
  FColor := clHighlight;
  FCloseColor := clBtnFace;
  FHeight := 20;
  FMinMaxButtonColor := clBlack;
  FCloseButtonColor := clBlack;
  FFont.OnChange := FontChanged;
  FFont.Color := clHighLightText;
  FCloseMinGlyph := TBitmap.Create;
  FCloseMaxGlyph := TBitmap.Create;
  FCloseButtonColor := clWhite;
  FMinMaxButtonColor := clWhite;
  FMinGlyph := TBitmap.Create;
  FMaxGlyph := TBitmap.Create;
  FShadeLight := 200;
  FShadeGrain := 32;
  FBackground := TBitmap.Create;
  FColorTo := clNone;
  FPosition := cpTop;
  FVisible := false;
  FMinMaxCaption := False;
  FCloseButtonHoverColor := clNone;
  FMinMaxButtonHoverColor := clNone;
  FGradientDirection := gdHorizontal;
end;

destructor TPanelCaption.Destroy;
begin
  FFont.Free;
  FCloseMinGlyph.Free;
  FCloseMaxGlyph.Free;
  FMinGlyph.Free;
  FMaxGlyph.Free;
  FBackground.Free;
  inherited;
end;

procedure TPanelCaption.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TPanelCaption.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
  ShadeChanged;
end;

procedure TPanelCaption.SetCaptionShape(const Value: TCaptionShape);
begin
  FShape := Value;
  ShadeChanged;
end;

procedure TPanelCaption.SetCloseButton(const Value: boolean);
begin
  if (FCloseButton <> Value) then
  begin
    FCloseButton := Value;
    Changed;
  end;
end;

procedure TPanelCaption.SetCloseButtonColor(const Value: TColor);
begin
  if (fCloseButtonColor <> Value) then
  begin
    FCloseButtonColor := Value;
    Changed;
  end;
end;

procedure TPanelCaption.SetCloseColor(const Value: TColor);
begin
  if FCloseColor <> Value then
  begin
    FCloseColor := Value;
    Changed;
  end;
end;

procedure TPanelCaption.SetCloseMaxGlyph(const Value: TBitmap);
begin
  FCloseMaxGlyph.Assign(Value);
  Changed;
end;

procedure TPanelCaption.SetCloseMinGlyph(const Value: TBitmap);
begin
  FCloseMinGlyph.Assign(Value);
  Changed;
end;

procedure TPanelCaption.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    ShadeChanged;
  end;
end;

procedure TPanelCaption.SetColorTo(const Value: TColor);
begin
  FColorTo := Value;
  Changed;
end;

procedure TPanelCaption.SetFlat(const Value: Boolean);
begin
  FFlat := Value;
  ShadeChanged;
end;

procedure TPanelCaption.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  Changed;
end;

procedure TPanelCaption.SetGradientDirection(
  const Value: TGradientDirection);
begin
  FGradientDirection := Value;
  Changed;
end;

procedure TPanelCaption.SetHeight(const Value: integer);
begin
  if (FHeight <> Value) then
  begin
    FHeight := Value;
    Changed;
  end;
end;

procedure TPanelCaption.SetIndent(const Value: Integer);
begin
  if FIndent <> Value then
  begin
    FIndent := Value;
    Changed;
  end;  
end;

procedure TPanelCaption.SetMaxGlyph(const Value: TBitmap);
begin
  FMaxGlyph.Assign(Value);
end;

procedure TPanelCaption.SetMinGlyph(const Value: TBitmap);
begin
  FMinGlyph.Assign(Value);
end;

procedure TPanelCaption.SetMinMaxButton(const Value: boolean);
begin
  if FMinMaxButton <> Value then
  begin
    FMinMaxButton := Value;
    Changed;
  end;
end;

procedure TPanelCaption.SetMinMaxButtonColor(const Value: TColor);
begin
  if FMinMaxButtonColor <> Value then
  begin
    FMinMaxButtonColor := Value;
    Changed;
  end;
end;

procedure TPanelCaption.SetMinMaxCaption(const Value: Boolean);
begin
  if (FMinMaxCaption <> Value) then
  begin
    FMinMaxCaption := Value;
  end;
end;

procedure TPanelCaption.SetPosition(const Value: TCaptionPosition);
begin
  if (FPosition <> Value) then
  begin
    FPosition := Value;
    if Assigned(FOnPositionChange) then
      FOnPositionChange(Self);
  end;
end;

procedure TPanelCaption.SetShadeGrain(const Value: Byte);
begin
  FShadeGrain := Value;
  ShadeChanged;
end;

procedure TPanelCaption.SetShadeLight(const Value: Integer);
begin
  if Value < 200 then
    FShadeLight := 200
  else
    FShadeLight := Value;
  ShadeChanged;
end;

procedure TPanelCaption.SetShadeType(const Value: TShadeType);
begin
  FShadeType := Value;
  ShadeChanged;
end;

procedure TPanelCaption.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

procedure TPanelCaption.SetTopIndent(const Value: Integer);
begin
  if FTop <> Value then
  begin
    FTop := Value;
    Changed;
  end;
end;

procedure TPanelCaption.SetVisible(const Value: boolean);
begin
  FVisible := Value;
  Changed;
  StateChanged;
end;

procedure TPanelCaption.ShadeChanged;
begin
  if Assigned(FOnShadeChange) then
    FOnShadeChange(Self);
  //FOwner.ShadeHeader;
  Changed;
end;

procedure TPanelCaption.StateChanged;
begin
  if Assigned(FOnStateChange) then
    FOnStateChange(Self);
end;

{ TPanelPosition }

procedure TPanelPosition.Assign(Source: TPersistent);
begin
  Key := (Source as TPanelPosition).Key;
  Section := (Source as TPanelPosition).Section;
  Save := (Source as TPanelPosition).Save;
  {$IFDEF DELPHI4_LVL}
  Location := (Source as TPanelPosition).Location;
  {$ENDIF}
end;

constructor TPanelPosition.Create(AOwner: TComponent);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TPanelPosition.Destroy;
begin
  inherited;
end;

{ TCustomAdvPanelGroup }

procedure TAdvPanelGroup.ArrangeControlsVert;
var
  PL: TList;
  i, j, T1,T2,H: Integer;
  Sorted: Boolean;
  {$IFNDEF TMSDOTNET}
  S: Pointer;
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  S: TObject;
  {$ENDIF}

begin
  if FUpdateCount > 0 then
    Exit;

  inc(FUpdateCount);

  PL := TList.Create;

  for i := 1 to ControlCount do
  begin
    if (Controls[i - 1] is TCustomAdvPanel) then
      PL.Add(Controls[i - 1]);
  end;

  Sorted := False;

  // perform a simple bubble sort, nr. of subpanels should be small

  while not Sorted do
  begin
    Sorted := True;
    for i := 2 to PL.Count do
    begin
      if FCode then
      begin
        T1 := TCustomAdvPanel(PL.Items[i - 2]).Index;
        T2 := TCustomAdvPanel(PL.Items[i - 1]).Index;
      end
      else
      begin
        T1 := TCustomAdvPanel(PL.Items[i - 2]).Top;
        T2 := TCustomAdvPanel(PL.Items[i - 1]).Top;
      end;

      if T1 > T2 then
      begin
        Sorted := False;
        S := PL.Items[i - 2];
        PL.Items[i - 2] := PL.Items[i - 1];
        PL.Items[i - 1] := S;
      end;
    end;
  end;

  H := VertPadding;

  if Assigned(FScrollBar) then
  begin
    if FScrollBar.Visible then
      H := VertPadding - FScrollBar.Position;
  end;

  if Assigned(Caption) then
  begin
    if Caption.Visible then
      H := H + Caption.Height;
  end;

  if ScrollSmooth then
    for i := 1 to PL.Count do
    begin
      if TCustomAdvPanel(PL.Items[i - 1]).Visible then
        TCustomAdvPanel(PL.Items[i - 1]).BeginUpdate;
    end;

  for i := 1 to PL.Count do
  begin
    TCustomAdvPanel(PL.Items[i - 1]).Top := H;

    if FScrollBar.Visible then
    begin
      TCustomAdvPanel(PL.Items[i - 1]).Left := HorzPadding + ((Width - FScrollBar.Width - HorzPadding) div Columns) * ((i - 1) mod Columns);
      TCustomAdvPanel(PL.Items[i - 1]).Width := (Width - 2* HorzPadding - FScrollBar.Width) div Columns
    end
    else
    begin
      TCustomAdvPanel(PL.Items[i - 1]).Left := HorzPadding + ((Width - HorzPadding) div Columns) * ((i - 1) mod Columns);
      TCustomAdvPanel(PL.Items[i - 1]).Width := (Width - 2* HorzPadding) div Columns;
    end;

    if TCustomAdvPanel(PL.Items[i - 1]).Visible then
      if (i mod Columns = 0) then
        H := H + TCustomAdvPanel(PL.Items[i - 1]).Height + VertPadding;
  end;

  for i := 1 to PL.Count do
  begin
    if ScrollSmooth then
    begin
      if TCustomAdvPanel(PL.Items[i - 1]).Visible then
        TCustomAdvPanel(PL.Items[i - 1]).EndUpdate;
    end;

    TCustomAdvPanel(PL.Items[i - 1]).Invalidate;

    for j := 1 to TCustomAdvPanel(PL.Items[i - 1]).ControlCount do
    begin

      if TCustomAdvPanel(PL.Items[i - 1]).Controls[j - 1] is TWinControl then
      begin
        if (TCustomAdvPanel(PL.Items[i - 1]).Controls[j - 1] as TWinControl).Visible and
           (TWinControl(TCustomAdvPanel(PL.Items[i - 1]).Controls[j - 1]).ControlCount = 0) then
        with TCustomAdvPanel(PL.Items[i - 1]).Controls[j - 1] as TWinControl do
        begin
          SendMessage(Handle, WM_SETREDRAW, Integer(False), 0);
          SendMessage(Handle, WM_SETREDRAW, Integer(True), 0);
        end;
      end;

      with TCustomAdvPanel(PL.Items[i - 1]).Controls[j - 1] do
      begin
        // Invalidate;
        // force a full repaint, including borders
        Width := Width + 1;
        Width := Width - 1;
      end;
    end;
  end;


  PL.Free;
  dec(FUpdateCount);
  Invalidate;
end;

procedure TAdvPanelGroup.ArrangeControlsHorz;
var
  PL: TList;
  i, T1,T2,H: Integer;
  Sorted: Boolean;
  {$IFNDEF TMSDOTNET}
  S: Pointer;
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  S: TObject;
  {$ENDIF}

begin
  PL := TList.Create;

  for i := 1 to ControlCount do
  begin
    if (Controls[i - 1] is TCustomAdvPanel) then
      PL.Add(Controls[i - 1]);
  end;

  Sorted := False;

  // perform a simple bubble sort, nr. of subpanels should be small

  while not Sorted do
  begin
    Sorted := True;
    for i := 2 to PL.Count do
    begin
      T1 := TCustomAdvPanel(PL.Items[i - 2]).Left;
      T2 := TCustomAdvPanel(PL.Items[i - 1]).Left;
      if T1 > T2 then
      begin
        Sorted := False;
        S := PL.Items[i - 2];
        PL.Items[i - 2] := PL.Items[i - 1];
        PL.Items[i - 1] := S;
      end;
    end;
  end;

  H := HorzPadding;

  if Assigned(FScrollBar) then
  begin
  if not FScrollBar.Visible then
    H := HorzPadding
  else
    H := HorzPadding - FScrollBar.Position;
  end;

  for i := 1 to PL.Count do
  begin
    TCustomAdvPanel(PL.Items[i - 1]).Left := H;
    TCustomAdvPanel(PL.Items[i - 1]).Top := VertPadding;

    if FScrollBar.Visible then
      TCustomAdvPanel(PL.Items[i - 1]).Height := Height - 2* VertPadding - FScrollBar.Height
    else
      TCustomAdvPanel(PL.Items[i - 1]).Height := Height - 2* VertPadding;

    if TCustomAdvPanel(PL.Items[i - 1]).Visible then
      H := H + TCustomAdvPanel(PL.Items[i - 1]).Width + HorzPadding;
  end;

  PL.Free;
end;

procedure TAdvPanelGroup.ArrangeControls;
begin
  if (csLoading in ComponentState) then
    Exit;

  if FIsArranging then
    Exit;
  if FUpdateCount > 0 then
    Exit;

  FIsArranging := True;
  if GroupStyle = gsVertical then
    ArrangeControlsVert
  else
    ArrangeControlsHorz;
  FIsArranging := False;
end;

procedure TAdvPanelGroup.ChildPanelChanged(APanel: TCustomAdvPanel);
begin
  UpdateScrollBar;
  ArrangeControls;
end;

constructor TAdvPanelGroup.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls];
  ControlStyle := ControlStyle - [csSetCaption];
  FScrollBar := TScrollBar.Create(nil);
  FScrollBar.Parent := Self;
  FScrollBar.Align := alRight;

  FScrollBar.Position := 0;
  FScrollBar.Kind := sbVertical;
  FScrollBar.OnScroll := Scroll;
  FScrollBar.Visible := False;
  FScrollBar.LargeChange := 20;
  FScrollBar.SmallChange := 2;
  FScrollBar.TabStop := False;

  FHorzPadding := 8;
  FVertPadding := 8;
  FPanels := TList.Create;

  FColumns := 1;
  FDefaultPanel := TAdvPanelSettings.Create;

  FScrollSmooth := false;
end;

procedure TAdvPanelGroup.SetGroupStyle(const Value: TGroupStyle);
begin
  if FGroupStyle <> Value then
  begin
    FGroupStyle := Value;
    UpdateScrollBar;
    ArrangeControls;
  end;
end;

procedure TAdvPanelGroup.SetHorzPadding(const Value: Integer);
begin
  if FHorzPadding <> Value then
  begin
    FHorzPadding := Value;
    ArrangeControls;
  end;
end;

procedure TAdvPanelGroup.SetVertPadding(const Value: Integer);
begin
  if FVertPadding <> Value then
  begin
    FVertPadding := Value;
    ArrangeControls;
  end;
end;

procedure TAdvPanelGroup.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  doarr: boolean;
begin
  doarr := (AWidth <> FOldWidth) or (AHeight <> FOldHeight);
  inherited;
  if doarr then
    ArrangeControls;
  FOldWidth := AWidth;
  FOldHeight := AHeight;
end;

destructor TAdvPanelGroup.Destroy;
var
  i: Integer;
begin
  for i := 1 to FPanels.Count do
    TCustomAdvPanel(FPanels[i - 1]).Free;
  FPanels.Free;
  FScrollBar.Free;
  FDefaultPanel.Free;
  inherited;
end;

procedure TAdvPanelGroup.Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  if (ScrollCode = scEndScroll) then
  begin
    if FScrollbar.Position > FScrollbar.Max - FScrollbar.Pagesize then
      FScrollbar.Position := FScrollbar.Max - FScrollbar.Pagesize;
    ArrangeControls;
  end;
end;

function TAdvPanelGroup.PanelHeights: Integer;
var
  H, i: Integer;
begin
  H := VertPadding;

  for i := 1 to ControlCount do
  begin
    if (Controls[i - 1] is TCustomAdvPanel) then
      if TCustomAdvPanel(Controls[i - 1]).Visible then
        if (i mod Columns = 0) then
          H := H + TCustomAdvPanel(Controls[i - 1]).Height + VertPadding;
  end;

  Result := H;
end;

function TAdvPanelGroup.PanelWidths: Integer;
var
  W, i: Integer;
begin
  W := HorzPadding;
  for i := 1 to ControlCount do
  begin
    if (Controls[i - 1] is TCustomAdvPanel) then
      if TCustomAdvPanel(Controls[i - 1]).Visible then
        W := W + TCustomAdvPanel(Controls[i - 1]).Width +  HorzPadding;
  end;

  Result := W;
end;

procedure TAdvPanelGroup.Loaded;
begin
  inherited;
  // force correct initialization
  Width := Width + 1;
  Width := Width - 1;

  UpdateScrollBar;
  ArrangeControls;
  InitPanels;
end;

procedure TAdvPanelGroup.UpdateScrollbar;
var
  TH: Integer;
begin
  if FUpdateCount > 0 then
    Exit;

  if GroupStyle = gsVertical then
  begin
    if FScrollBar.Kind = sbHorizontal then
    begin
      FScrollBar.Kind := sbVertical;
    end;

    FScrollBar.Width := 16;
    TH := PanelHeights;
    if (TH > Height) and (TH > 0) then
    begin
      if FScrollBar.Position > TH then
        FScrollBar.Position := TH;
      FScrollBar.PageSize := Height;
      FScrollBar.LargeChange := Height div 3;
      FScrollBar.Max := TH;
    end;
    FScrollBar.Visible := TH > Height;
    FScrollBar.Invalidate;
  end
  else
  begin
    if FScrollBar.Kind = sbVertical then
      FScrollBar.Kind := sbHorizontal;

    if FScrollBar.Align = alRight then
    begin
      FScrollBar.Align := alBottom;
    end;
    FScrollBar.Height := 16;

    TH := PanelWidths;
    if TH > Width then
    begin
      if FScrollBar.Position > TH then
        FScrollBar.Position := TH;
      FScrollBar.PageSize := Width;
      FScrollBar.LargeChange := Width div 3;
      FScrollBar.Max := TH;
    end;

    FScrollBar.Visible := TH > Width;
    FScrollBar.Invalidate;
  end;
end;

procedure TAdvPanelGroup.CloseAllPanels;
var
  i: Integer;
begin
  BeginUpdate;
  for i := 1 to ControlCount do
  begin
    if (Controls[i - 1] is TCustomAdvPanel) then
      TCustomAdvPanel(Controls[i - 1]).Collaps := True;
  end;
  EndUpdate;
  Invalidate;
end;

procedure TAdvPanelGroup.OpenAllPanels;
var
  i: Integer;
begin
  BeginUpdate;
  for i := 1 to ControlCount do
  begin
    if (Controls[i - 1] is TCustomAdvPanel) then
      TCustomAdvPanel(Controls[i - 1]).Collaps := False;
  end;
  EndUpdate;
end;

{$IFNDEF TMSDOTNET}
procedure TAdvPanelGroup.WMSize(var Msg: TMessage);
begin
  inherited;
  UpdateScrollBar;
end;
{$ENDIF}
{$IFDEF TMSDOTNET}
procedure TAdvPanelGroup.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateScrollBar;
end;
{$ENDIF}
procedure TAdvPanelGroup.LoadPanelPositions;
var
  i: Integer;
  pp: TPanelPosition;
  ap: TCustomAdvPanel;
begin
  pp := TPanelPosition.Create(Self);

  for i := 1 to ControlCount do
  begin
    if (Controls[i - 1] is TCustomAdvPanel) then
    begin
      ap := TCustomAdvPanel(Controls[i - 1]);
      PP.Assign(ap.Position);
      ap.Position.Assign(Self.Position);
      ap.Position.Section := ap.Name;
      ap.LoadPosition;
      ap.Position.Assign(pp);
    end;
  end;

  PP.Free;
end;

procedure TAdvPanelGroup.SavePanelPositions;
var
  i: Integer;
  pp: TPanelPosition;
  ap: TCustomAdvPanel;
begin
  pp := TPanelPosition.Create(Self);

  for i := 1 to ControlCount do
  begin
    if (Controls[i - 1] is TCustomAdvPanel) then
    begin
      ap := TCustomAdvPanel(Controls[i - 1]);
      PP.Assign(ap.Position);
      ap.Position.Assign(Self.Position);
      ap.Position.Section := ap.Name;
      ap.SavePosition;
      ap.Position.Assign(pp);
    end;
  end;
  PP.Free;
end;

{$IFDEF DELPHI5_LVL}
function TAdvPanelGroup.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  FScrollBar.Position :=  FScrollBar.Position + (2 * FScrollBar.SmallChange);
  Result := True;
end;

function TAdvPanelGroup.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
begin
  FScrollBar.Position :=  FScrollBar.Position - (2 * FScrollBar.SmallChange);
  Result := True;  
end;
{$ENDIF}

procedure TAdvPanelGroup.StateChange;
begin
  inherited;
  ArrangeControls;
  UpdateScrollBar;
end;

procedure TAdvPanelGroup.UpdateGroup;
begin
  ArrangeControls;
  UpdateScrollBar;
  Height := Height + 1;
  Height := Height - 1;
end;

procedure TAdvPanelGroup.Clear;
var
  i: Integer;
begin
  i := 0;
  while (i < ControlCount) do
  begin
    if (Controls[i] is TCustomAdvPanel) then
      Controls[i].Free
    else
      inc(i);
  end;
  FPanels.Clear;
  UpdateScrollbar;
end;


procedure TAdvPanelGroup.InitPanels;
var
  i: Integer;
begin
  i := 0;
  FPanels.Clear;
  while (i < ControlCount) do
  begin
    if (Controls[i] is TCustomAdvPanel) then
    begin
      {$IFNDEF TMSDOTNET}
      FPanels.Add(Pointer(Controls[i]));
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      FPanels.Add(TObject(Controls[i]));
      {$ENDIF}
    end;
    inc(i);
  end;
end;

function TAdvPanelGroup.AddPanel: TCustomAdvPanel;
begin
  Result := TCustomAdvPanel.Create(Self);
  Result.Parent := Self;
  Result.AssignSettings(DefaultPanel);
  Result.Caption.Visible := DefaultPanel.Caption.Visible;
  Result.Caption.MinMaxButton := DefaultPanel.Caption.MinMaxButton;
  Result.Caption.CloseButton := DefaultPanel.Caption.CloseButton;  
  Result.Index := FPanels.Count;
  {$IFNDEF TMSDOTNET}
  FPanels.Add(Pointer(Result));
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  FPanels.Add(TObject(Result));
  {$ENDIF}
  UpdateScrollbar;
  ArrangeControls;
  UpdateScrollbar;
end;

function TAdvPanelGroup.AppendPanel: TCustomAdvPanel;
begin
  Result := AddPanel;

  if PanelCount > 1 then
  begin
    MovePanel(PanelCount - 1,0);
  end;
end;


function TAdvPanelGroup.InsertPanel(Index: Integer): TCustomAdvPanel;
var
  i: Integer;
begin
  Result := TCustomAdvPanel.Create(Self);
  Result.Parent := Self;
  Result.AssignSettings(DefaultPanel);
  Result.Caption.Visible := DefaultPanel.Caption.Visible;
  Result.Caption.MinMaxButton := DefaultPanel.Caption.MinMaxButton;
  Result.Caption.CloseButton := DefaultPanel.Caption.CloseButton;  
  Result.Index := Index;
  {$IFNDEF TMSDOTNET}
  FPanels.Insert(Index,Pointer(Result));
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  FPanels.Insert(Index,TObject(Result));
  {$ENDIF}

  for i := 1 to FPanels.Count do
  begin
    TCustomAdvPanel(FPanels[i - 1]).Index := i - 1;
  end;

  UpdateScrollBar;
  ArrangeControls;
  UpdateScrollBar;
end;

procedure TAdvPanelGroup.RemovePanel(Index: Integer);
var
  i: Integer;
begin
  if (Index < FPanels.Count) and (Index >= 0) then
  begin
    TCustomAdvPanel(FPanels[Index]).Free;
    FPanels.Delete(Index);

    for i := 1 to FPanels.Count do
    begin
      TCustomAdvPanel(FPanels[i - 1]).Index := i - 1;
    end;
    ArrangeControls;
  end;
end;

function TAdvPanelGroup.GetPanel(Index: Integer): TCustomAdvPanel;
begin
  Result := TCustomAdvPanel(FPanels[Index]);
end;

procedure TAdvPanelGroup.SetPanel(Index: Integer; const Value: TCustomAdvPanel);
begin
  TCustomAdvPanel(FPanels[Index]).Assign(Value);
end;

procedure TAdvPanelGroup.MovePanel(FromIndex, ToIndex: Integer);
var
  i: Integer;
begin
  {
  outputdebugstring('before');
  for i := 0 to FPanels.Count - 1 do
  begin
    outputdebugstring(pchar(TCustomAdvPanel(fpanels[i]).Text+':'+inttostr(TCustomAdvPanel(fpanels[i]).Index)));
  end;
  }

  FPanels.Move(FromIndex,ToIndex);

  {
  outputdebugstring('after move');
  for i := 0 to FPanels.Count - 1 do
  begin
    outputdebugstring(pchar(TCustomAdvPanel(fpanels[i]).Text+':'+inttostr(TCustomAdvPanel(fpanels[i]).Index)));
  end;
  }

  for i := 1 to FPanels.Count do
  begin
    TCustomAdvPanel(FPanels[i - 1]).Index := FPanels.Count - (i - 1);
  end;

  FCode := True;
  ArrangeControls;
  FCode := False;

  {
  outputdebugstring('after');
  for i := 0 to FPanels.Count - 1 do
  begin
    outputdebugstring(pchar(TCustomAdvPanel(fpanels[i]).Text+':'+inttostr(TCustomAdvPanel(fpanels[i]).Index)));
  end;
  }

end;

procedure TAdvPanelGroup.SetDefaultPanel(const Value: TAdvPanelSettings);
begin
  FDefaultPanel.Assign(Value);
end;

procedure TAdvPanelGroup.BeginUpdate;
begin
  SendMessage(Handle,WM_SETREDRAW,Integer(False),0);
  inc(FUpdateCount);
end;

procedure TAdvPanelGroup.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    dec(FUpdateCount);
    if FUpdateCount = 0 then
    begin
      SendMessage(Handle,WM_SETREDRAW,Integer(True),0);
      UpdateScrollBar;
      ArrangeControls;
      UpdateScrollBar;
    end;
  end;
end;

procedure TAdvPanelGroup.SetColumns(const Value: Integer);
begin
  if (Value >= 1) then
  begin
    FColumns := Value;
    UpdateScrollBar;
    ArrangeControls;
    UpdateScrollBar;
  end;
end;


function TAdvPanelGroup.GetPanelCount: Integer;
begin
  Result := FPanels.Count;
end;

procedure TAdvPanelGroup.AlignControls(AControl: TControl;
  var Rect: TRect);
begin
  inherited;
  UpdateScrolLbar;
end;



{ TAutoSize }

procedure TAutoSize.Assign(Source: TPersistent);
begin
  Enabled := (Source as TAutoSize).Enabled;
  Height := (Source as TAutoSize).Height;
  Width := (Source as TAutoSize).Width;
end;

constructor TAutoSize.Create(AOwner: TCustomAdvPanel);
begin
  inherited Create;
  FOwner := TCustomAdvPanel(AOwner);
  FHeight := True;
  FWidth := True;
end;

procedure TAutoSize.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  if FEnabled then
    FOwner.DoAutoSize;
end;


{ TCustomAdvPanelSettings }

procedure TAdvPanelSettings.Assign(Source: TPersistent);
begin

end;

procedure TAdvPanelSettings.Changed;
begin
  if FUpdateCount = 0 then
    if Assigned(FOnChange) then
      FOnChange(Self);
end;

procedure TAdvPanelSettings.CaptionChanged(Sender: TObject);
begin
  if FUpdateCount = 0 then
    if Assigned(FOnChange) then
      FOnChange(Self);
end;


constructor TAdvPanelSettings.Create;
begin
  inherited Create;
  FCaption := TPanelCaption.Create;
  FCaption.OnChange := CaptionChanged;
  FColor := clBtnFace;
  FColorTo := clNone;
  FColorMirror := clNone;
  FColorMirrorTo := clNone;
  FHeight := 120;
  FBorderStyle := bsSingle;
  FFont := TFont.Create;
  FBevelWidth := 1;
  FCollapsColor := clBtnFace;
  FURLColor := clBlue;
  FUpdateCount := 0;
  FStatusBar := TPanelStatusBar.Create;
  FHover := false;
  FHoverColor := clNone;
  FHoverFontColor := clNone;
  FAutoHideChildren := true;
end;

destructor TAdvPanelSettings.Destroy;
begin
  FFont.Free;
  FCaption.Free;
  FStatusBar.Free;
  inherited;
end;

procedure TAdvPanelSettings.SetAnchorHint(const Value: Boolean);
begin
  FAnchorHint := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetAutoHideChildren(const Value: Boolean);
begin
  FAutoHideChildren := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetBevelInner(const Value: TBevelCut);
begin
  FBevelInner := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetBevelOuter(const Value: TBevelCut);
begin
  FBevelOuter := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetBevelWidth(const Value: Integer);
begin
  FBevelWidth := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetBorderShadow(const Value: Boolean);
begin
  FBorderShadow := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetBorderStyle(const Value: TBorderStyle);
begin
  FBorderStyle := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetCanMove(const Value: Boolean);
begin
  FCanMove := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetCanSize(const Value: Boolean);
begin
  FCanSize := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetCaption(const Value: TPanelCaption);
begin
  FCaption := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetCollaps(const Value: Boolean);
begin
  FCollaps := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetCollapsColor(const Value: TColor);
begin
  FCollapsColor := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetCollapsDelay(const Value: Integer);
begin
  FCollapsDelay := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetCollapsSteps(const Value: Integer);
begin
  FCollapsSteps := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetColorTo(const Value: TColor);
begin
  if (FColorTo <> Value) then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TAdvPanelSettings.SetColorMirror(const Value: TColor);
begin
  if (FColorMirror <> Value) then
  begin
    FColorMirror := Value;
    Changed;
  end;
end;


procedure TAdvPanelSettings.SetColorMirrorTo(const Value: TColor);
begin
  if (FColorMirrorTo <> Value) then
  begin
    FColorMirrorTo := Value;
    Changed;
  end;
end;


procedure TAdvPanelSettings.SetCursor(const Value: TCursor);
begin
  FCursor := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  Changed;
end;

procedure TAdvPanelSettings.SetHover(const Value: Boolean);
begin
  FHover := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetHoverColor(const Value: TColor);
begin
  FHoverColor := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetHoverFontColor(const Value: TColor);
begin
  FHoverFontColor := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetIndent(const Value: Integer);
begin
  FIndent := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetText(const Value: string);
begin
  FText := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetTextVAlign(const Value: TTextVAlignment);
begin
  FTextVAlign := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetTopIndent(const Value: Integer);
begin
  FTopIndent := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetURLColor(const Value: TColor);
begin
  FURLColor := Value;
  Changed;
end;

procedure TAdvPanelSettings.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TAdvPanelSettings.EndUpdate;
begin
  if FUpdateCount > 0 then
  begin
    dec(FUpdateCount);
    if FUpdateCount = 0 then
      Changed;
  end;
end;

procedure TAdvPanelSettings.SetBorderWidth(const Value: Integer);
begin
  FBorderWidth := Value;
  Changed;
end;

procedure TAdvPanelSettings.SetStatusBar(const Value: TPanelStatusBar);
begin
  FStatusBar.Assign(Value);
  Changed;
end;


{ TCustomAdvPanelStyler }

procedure TAdvPanelStyler.Assign(Source: TPersistent);
begin
  if (Source is TAdvPanelStyler) then
  begin
    AutoThemeAdapt  := (Source as TAdvPanelStyler).AutoThemeAdapt; 
    Settings.Assign((Source as TAdvPanelStyler).Settings);
    Comments := (Source as TAdvPanelStyler).Comments;
    Style := (Source as TAdvPanelStyler).Style;
  end;
end;

procedure TAdvPanelStyler.Changed(Sender: TObject);
var
  i: Integer;
begin
  if csLoading in ComponentState then
    Exit;

  for i := 1 to Owner.ComponentCount do
    if (Owner.Components[i - 1] is TCustomAdvPanel) then
    begin
      if TCustomAdvPanel(Owner.Components[i - 1]).Styler = Self then
        TCustomAdvPanel(Owner.Components[i - 1]).AssignStyle(Settings);
    end;
end;

constructor TAdvPanelStyler.Create(AOwner: TComponent);
var
  ctrl: TComponent;
begin
  inherited;
  FNotifierWnd := TThemeNotifierWindow.Create(Self);

  // find first owning TWinControl owner
  ctrl := AOwner;
  while Assigned(ctrl) and not (ctrl is TWinControl) do
  begin
    ctrl := ctrl.Owner;
  end;

  if Assigned(ctrl) then
    if (ctrl is TWinControl) then
      FNotifierWnd.Parent := TWinControl(ctrl);

  FNotifierWnd.OnThemeChange := ThemeChanged;

  FSettings := TAdvPanelSettings.Create;
  FSettings.OnChange := Changed;
  FStyle := psXP;
  SetStyle(psXP);
  FAutoThemeAdapt := False;
end;

destructor TAdvPanelStyler.Destroy;
begin
  FSettings.Free;
  inherited;
end;

procedure TAdvPanelStyler.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    ThemeChanged(Self);
  Changed(Self);
end;

procedure TAdvPanelStyler.SetSettings(const Value: TAdvPanelSettings);
begin
  FSettings := Value;
end;

procedure TAdvPanelStyler.ThemeChanged(Sender: TObject);
var
  eTheme: XPColorScheme;
begin
  if not AutoThemeAdapt then
    Exit;

  eTheme := CurrentXPTheme();
  case eTheme of
    xpBlue: Style := psOffice2003Blue;
    xpGreen: Style := psOffice2003Olive;
    xpGray: Style := psOffice2003Silver;
  else
    Style := psXP;
  end;
end;

procedure TAdvPanelStyler.SetComponentStyle(AStyle: TTMSStyle);
begin
  case AStyle of
    tsOffice2003Blue: Style := psOffice2003Blue;
    tsOffice2003Olive: Style := psOffice2003Olive;
    tsOffice2003Silver: Style := psOffice2003Silver;
    tsOffice2003Classic: Style := psOffice2003Classic;
    tsOffice2007Luna: Style := psOffice2007Luna;
    tsOffice2007Obsidian: Style := psOffice2007Obsidian;
    tsOffice2007Silver: Style := psOffice2007Silver;    
    tsWindowsXP: Style := psWindowsXP;
    tsWhidbey: Style := psWhidbey;
  end;
end;

procedure TAdvPanelStyler.SetStyle(const Value: TAdvPanelStyle);
begin
  FStyle := Value;

  //if csLoading in ComponentState then
  //  Exit;


  Settings.BeginUpdate;
  case FStyle of
  psXP:
    with Settings do
    begin
      Color := clWhite;
      ColorTo := $00E3F0F2;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;
      //Font.Name := 'Verdana';
      //Caption.Font.Name := 'Verdana';
      Caption.Font.Color := clHighLightText;
      Caption.ShadeType := stNormal;
      BevelInner := bvNone;
      BevelOuter := bvNone;
      BorderColor := clGray;
      BorderShadow := True;
      BorderStyle := bsNone;
      CollapsColor := clBtnFace;
      Caption.Color := clHighLight;
      Caption.ColorTo := clBlue;
      Caption.FHeight := 20;
      Caption.Indent := 2;
      Caption.GradientDirection := gdHorizontal;
      StatusBar.BorderColor := clSilver;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := $00E3F0F2;
      StatusBar.ColorTo := clWhite;
      StatusBar.Font.Color := clBlack;
    end;
  psOffice2003Classic:
    with Settings do
    begin
      Color := clWhite;
      ColorTo := $00E3F0F2;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;

      //Font.Name := 'Verdana';
      //Caption.Font.Name := 'Verdana';
      Caption.Font.Color := clHighLightText;
      Caption.ShadeType := stNormal;
      BevelInner := bvNone;
      BevelOuter := bvNone;
      BorderColor := clGray;
      BorderShadow := True;
      BorderStyle := bsNone;
      CollapsColor := clBtnFace;
      Caption.Color := clHighLight;
      Caption.ColorTo := clBlue;
      Caption.FHeight := 20;
      Caption.Indent := 2;
      Caption.GradientDirection := gdHorizontal;
      StatusBar.BorderColor := clSilver;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := $00E3F0F2;
      StatusBar.ColorTo := clWhite;
      StatusBar.Font.Color := clBlack;      
    end;
  psWhidbey:
    with Settings do
    begin
      Color := clWhite;
      ColorTo := $00E3F0F2;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;

      //Font.Name := 'Verdana';
      //Caption.Font.Name := 'Verdana';
      Caption.Font.Color := clBlack;
      Caption.ShadeType := stNormal;
      BevelInner := bvNone;
      BevelOuter := bvNone;
      BorderColor := clGray;
      BorderShadow := True;
      BorderStyle := bsNone;
      CollapsColor := clBtnFace;
      Caption.Color := $F3F7F8;
      Caption.ColorTo := $ACC3C3;
      Caption.FHeight := 20;
      Caption.Indent := 2;
      Caption.GradientDirection := gdVertical;
      StatusBar.BorderColor := clSilver;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := $00E3F0F2;
      StatusBar.ColorTo := clWhite;
      StatusBar.Font.Color := clBlack;
    end;
  psFlat:
    with Settings do
    begin
      Color := clBtnFace;
      ColorTo := clNone;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;

      Font.Color := clWindowText;
      //Font.Name := 'Tahoma';
      //Caption.Font.Name := 'Tahoma';
      Caption.Font.Color := clHighLightText;
      Caption.ShadeType := stNormal;
      BevelInner := bvNone;
      BevelOuter := bvNone;
      BorderColor := clGray;
      BorderShadow := False;
      BorderStyle := bsNone;
      CollapsColor := clBtnFace;
      Caption.Color := clHighLight;
      Caption.ColorTo := clNone;
      Caption.Height := 20;
      Caption.Indent := 0;
      Caption.GradientDirection := gdHorizontal;      
      StatusBar.BorderColor := clSilver;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := clBtnFace;
      StatusBar.ColorTo := clNone;
      StatusBar.Font.Color := clBlack;
    end;
  psTMS:
    with Settings do
    begin
      Color := clWhite;
      ColorTo := $00E4E4E4;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;

      Caption.ShadeGrain := 32;
      Caption.ShadeLight := 255;
      Caption.ShadeType := stRMetal;

      Font.Color := clWindowText;
      //Font.Name := 'Tahoma';
      //Caption.Font.Name := 'Tahoma';
      Caption.Font.Color := clBlack;
      Caption.Indent := 4;
      Caption.Font.Color := clBlack;
      BevelInner := bvNone;
      BevelOuter := bvNone;
      BorderColor := clGray;
      BorderShadow := True;
      BorderStyle := bsNone;
      CollapsColor := clBtnFace;
      Caption.Color := clWhite;
      Caption.ColorTo := clNone;
      Caption.Visible := True;
      Caption.FHeight := 20;
      Caption.GradientDirection := gdHorizontal;
      StatusBar.BorderColor := clWhite;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := $DEDEDE;
      StatusBar.ColorTo := $A9A9A9;
      StatusBar.Font.Color := clBlack;
    end;
  psClassic:
    with Settings do
    begin
      Color := clBtnFace;
      ColorTo := clNone;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;

      Caption.ShadeGrain := 32;
      Caption.ShadeLight := 255;
      Caption.ShadeType := stNormal;
      Font.Color := clWindowText;
      //Font.Name := 'MS Sans Serif';
      //Caption.Font.Name := 'MS Sans Serif';
      Caption.Font.Color := clBlack;
      BevelInner := bvNone;
      BevelOuter := bvRaised;
      BorderColor := clGray;
      BorderShadow := False;
      BorderStyle := bsNone;
      CollapsColor := clBtnFace;
      Caption.Color := clWhite;
      Caption.ColorTo := clNone;
      Caption.Visible := False;
      Caption.GradientDirection := gdHorizontal;
      StatusBar.BorderColor := clNone;
      StatusBar.BorderStyle := bsNone;
      StatusBar.BevelInner := True;
      StatusBar.Color := clBtnFace;
      StatusBar.ColorTo := clNone;
      StatusBar.Font.Color := clBlack;
    end;
  psWindowsXP:
    with Settings do
    begin
      Color := clBtnFace;
      ColorTo := clNone;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;

      Caption.ShadeGrain := 32;
      Caption.ShadeLight := 255;
      Caption.ShadeType := stNormal;

      Font.Color := clWindowText;
      //Font.Name := 'MS Sans Serif';
      //Caption.Font.Name := 'MS Sans Serif';
      Caption.Font.Color := clHighLightText;
      BevelInner := bvNone;
      BevelOuter := bvRaised;
      BorderColor := clGray;
      BorderShadow := False;
      BorderStyle := bsNone;
      CollapsColor := clBtnFace;
      Caption.Color := clWhite;
      Caption.ColorTo := clNone;
      Caption.Visible := False;
      Caption.GradientDirection := gdHorizontal;
      StatusBar.BorderColor := clNone;
      StatusBar.BorderStyle := bsNone;
      StatusBar.BevelInner := True;
      StatusBar.Color := clBtnFace;
      StatusBar.ColorTo := clNone;
      StatusBar.Font.Color := clBlack;
    end;
  psOffice2003Blue:
    with Settings do
    begin
      Color := $FDEADA;
      ColorTo := $E4AE88;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;

      Caption.ShadeGrain := 32;
      Caption.ShadeLight := 255;
      Caption.ShadeType := stNormal;

      Font.Color := clWindowText;
      //Font.Name := 'MS Sans Serif';
      //Caption.Font.Name := 'MS Sans Serif';
      Caption.Font.Color := clHighLightText;
      BevelInner := bvNone;
      BevelOuter := bvNone; // bvRaised
      BorderColor := clGray;
      BorderShadow := False;
      BorderStyle := bsNone;
      CollapsColor := clHighLight;
      Caption.Color := $00D68759;
      Caption.ColorTo := $00933803;

      //if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      //  Caption.Visible := True;

      Caption.Font.Color := clWhite;
      Caption.GradientDirection := gdVertical;
      StatusBar.BorderColor := clNone;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := $E08F65;
      StatusBar.ColorTo := $F9DBC4;
      StatusBar.Font.Color := clWhite;
    end;
  psOffice2003Olive:
    with Settings do
    begin
      Color := $CFF0EA;
      ColorTo := $8CC0B1;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;

      Caption.ShadeGrain := 32;
      Caption.ShadeLight := 255;
      Caption.ShadeType := stNormal;

      Font.Color := clWindowText;
      //Font.Name := 'MS Sans Serif';
      //Caption.Font.Name := 'MS Sans Serif';
      Caption.Font.Color := clHighLightText;
      BevelInner := bvNone;
      BevelOuter := bvNone; // bvRaised
      BorderColor := clGray;
      BorderShadow := False;
      BorderStyle := bsNone;
      CollapsColor := clHighLight;
      Caption.Color := $00C6EFE7;
      Caption.ColorTo := $0094BDB5;

      //if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      //  Caption.Visible := True;

      Caption.Font.Color := clBlack;
      Caption.GradientDirection := gdVertical;

      StatusBar.BorderColor := clNone;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := $80B0A1;
      StatusBar.ColorTo := $D3E4E3;
      StatusBar.Font.Color := clBlack;
    end;
  psOffice2003Silver:
    with Settings do
    begin
      Color := $ECE2E1;
      ColorTo := $B39698;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;

      Caption.ShadeGrain := 32;
      Caption.ShadeLight := 255;
      Caption.ShadeType := stNormal;

      Font.Color := clWindowText;
      //Font.Name := 'MS Sans Serif';
      //Caption.Font.Name := 'MS Sans Serif';
      Caption.Font.Color := clHighLightText;
      BevelInner := bvNone;
      BevelOuter := bvNone; // bvRaised
      BorderColor := clGray;
      BorderShadow := False;
      BorderStyle := bsNone;
      CollapsColor := clHighLight;
      Caption.Color := $00EFE7E7;
      Caption.ColorTo := $00AA8888;

      //if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      //  Caption.Visible := True;

      Caption.Font.Color := clBlack;
      Caption.GradientDirection := gdVertical;
      StatusBar.BorderColor := clNone;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := $BFA8A9;
      StatusBar.ColorTo := $DECFCF;
      StatusBar.Font.Color := clBlack;
    end;
  psOffice2007Luna:
    with Settings do
    begin
      {
      Color := $FFF4E3;
      ColorTo := $EDD9C8;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;
      }
      Color := $FAF1E9;
      ColorTo := $EDD8C7;
      ColorMirror := $EDD8C7;
      ColorMirrorTo := $FFF2E7;

      Caption.ShadeGrain := 32;
      Caption.ShadeLight := 255;
      Caption.ShadeType := stNormal;

      Font.Color := $723708;
      //Font.Name := 'MS Sans Serif';
      //Caption.Font.Name := 'MS Sans Serif';
      Caption.Font.Color := $723708;
      BevelInner := bvNone;
      BevelOuter := bvNone; // bvRaised
      BorderColor := $FFD2AF;
      BorderShadow := False;
      BorderStyle := bsNone;
      CollapsColor := clHighLight;
      Caption.Color := $FFEFE3;
      Caption.ColorTo := $FFD2AF;
      Caption.Font.Color := clBlack;

      //if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      //  Caption.Visible := True;

      Caption.GradientDirection := gdVertical;
      StatusBar.BorderColor := $FFD2AF;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := $F7E3D3;
      StatusBar.ColorTo := $F5D0B3;
      StatusBar.GradientDirection := gdVertical;
      StatusBar.Font.Color := $723708;
    end;
  psOffice2007Obsidian:
    with Settings do
    begin
      {
      Color := $F1F0E6;
      ColorTo := $C6BCB5;
      ColorMirror := clNone;
      ColorMirrorTo := clNone;
      }

      Color := $CFC6C1;
      ColorTo := $C5BBB4;
      ColorMirror := $C5BBB4;
      ColorMirrorTo := $ECECE5;

      Caption.ShadeGrain := 32;
      Caption.ShadeLight := 255;
      Caption.ShadeType := stNormal;

      Font.Color := $723708;
      //Font.Name := 'MS Sans Serif';
      //Caption.Font.Name := 'MS Sans Serif';
      Caption.Font.Color := clBlack;
      BevelInner := bvNone;
      BevelOuter := bvNone; // bvRaised
      BorderColor := $FFD2AF;
      BorderShadow := False;
      BorderStyle := bsNone;
      CollapsColor := clHighLight;

      // Caption.Color := $F2F1F0;
      // Caption.ColorTo := $C9C2BD;

      Caption.Color := $00B8B8B6; //$FFEFE3;
      Caption.ColorTo := $00A0A09E; //$FFD2AF;
      Caption.Font.Color := clWhite;

      //if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      //  Caption.Visible := True;

      Caption.GradientDirection := gdVertical;
      StatusBar.BorderColor := clBlack;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := $A19F9E;
      StatusBar.ColorTo := $534D4B;
      StatusBar.GradientDirection := gdVertical;
      StatusBar.Font.Color := clWhite;
    end;
  psOffice2007Silver:
    with Settings do
    begin
      Color := $F9F5F3;
      ColorTo := $E7DCD5;
      ColorMirror := $E7DCD5;
      ColorMirrorTo := $FBFAF0;

      Caption.ShadeGrain := 32;
      Caption.ShadeLight := 255;
      Caption.ShadeType := stNormal;

      Font.Color := $723708;
      //Font.Name := 'MS Sans Serif';
      //Caption.Font.Name := 'MS Sans Serif';
      Caption.Font.Color := $723708;
      BevelInner := bvNone;
      BevelOuter := bvNone; // bvRaised
      BorderColor := $FFD2AF;
      BorderShadow := False;
      BorderStyle := bsNone;
      CollapsColor := clHighLight;
      Caption.Color := $F8F7F6;
      Caption.ColorTo := $E8E0DB;
      Caption.Font.Color := clBlack;

      //if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      //  Caption.Visible := True;

      Caption.GradientDirection := gdVertical;
      StatusBar.BorderColor := clBlack;
      StatusBar.BorderStyle := bsSingle;
      StatusBar.BevelInner := false;
      StatusBar.Color := $FAEEEB;
      StatusBar.ColorTo := $E5DBD7;
      StatusBar.GradientDirection := gdVertical;
      StatusBar.Font.Color := $723708;
    end;
  end;
  Settings.EndUpdate;
end;


{ TPanelStatusBar }

procedure TPanelStatusBar.Assign(Source: TPersistent);
begin
  if (Source is TPanelStatusBar) then
  begin
    // FImageIndex := (Source as TPanelStatusBar).ImageIndex;
    // FText := (Source as TPanelStatusBar).Text;
    FColor := (Source as TPanelStatusBar).Color;
    FColorTo := (Source as TPanelStatusBar).ColorTo;
    FGradientDirection := (Source as TPanelStatusBar).GradientDirection;
    //FVisible := (Source as TPanelStatusBar).Visible;
    //FHeight := (Source as TPanelStatusBar).Height;
    FBorderStyle := (Source as TPanelStatusBar).BorderStyle;
    FBorderColor := (Source as TPanelStatusBar).BorderColor;
    FFont.Assign((Source as TPanelStatusBar).Font); 
  end;
end;

procedure TPanelStatusBar.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(self);
end;

constructor TPanelStatusBar.Create;
begin
  inherited;
  FImageIndex := -1;
  FText := '';
  FColor := clBtnFace;
  FColorTo := clNone;
  FGradientDirection := gdHorizontal;
  FVisible := False;
  FHeight := 18;
  FFont := TFont.Create;
  FFont.Name := 'Tahoma'; // make sure to use a Truetype font
  FFont.OnChange := FontChanged;
end;

destructor TPanelStatusBar.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TPanelStatusBar.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TPanelStatusBar.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TPanelStatusBar.SetBevelInner(const Value: Boolean);
begin
  if (FBevelInner <> Value) then
  begin
    FBevelInner := Value;
    Changed;
  end;
end;

procedure TPanelStatusBar.SetColor(const Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TPanelStatusBar.SetColorTo(const Value: TColor);
begin
  if (FColorTo <> Value) then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TPanelStatusBar.SetGradientDirection(
  const Value: TGradientDirection);
begin
  if (FGradientDirection <> Value) then
  begin
    FGradientDirection := Value;
    Changed;
  end;
end;

procedure TPanelStatusBar.SetHeight(const Value: Integer);
begin
  if (FHeight <> Value) then
  begin
    FHeight := Value;
    Changed;
  end;
end;

procedure TPanelStatusBar.SetImageIndex(const Value: integer);
begin
  if (FImageIndex <> Value) then
  begin
    FImageIndex := Value;
    Changed;
  end;
end;

procedure TPanelStatusBar.SetText(const Value: string);
begin
  if (FText <> Value) then
  begin
    FText := Value;
    Changed;
  end;
end;

procedure TPanelStatusBar.SetVisible(const Value: Boolean);
begin
  if (FVisible <> Value) then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TPanelStatusBar.SetBorderColor(const Value: TColor);
begin
  if (FBorderColor <> Value) then
  begin
    FBorderColor := Value;
    Changed;
  end;  
end;

procedure TPanelStatusBar.SetBorderStyle(const Value: TBorderStyle);
begin
  if (FBorderStyle <> Value) then
  begin
    FBorderStyle := Value;
    Changed;
  end; 
end;

{ TThemeNotifierWindow }

procedure TThemeNotifierWindow.WndProc(var Msg: TMessage);
begin
  if Msg.Msg = WM_THEMECHANGED  then
  begin
    if Assigned(FOnThemeChange) then
      FOnThemeChange(Self);
  end;
  inherited;
end;

{$IFDEF FREEWARE}
{$I TRIAL.INC}
{$ENDIF}

end.
