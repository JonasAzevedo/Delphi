{***************************************************************************}
{ TAdvOfficePager component                                                 }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2006 - 2009                                        }
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

unit AdvOfficePager;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Math, Menus,
  Dialogs, Forms, ImgList, CommCtrl, ExtCtrls, ComCtrls, AdvGDIP, GDIPicture,
  AdvHintInfo, AdvGlowButton
  {$IFNDEF TMSDOTNET}
  , AxCtrls
  {$ENDIF};

{$R ADVOFFICEPAGER.RES}

const
  GLOWSPEED = 50;
  GLOWSTEP = 20;
  IMG_SPACE = 2;
  DropDownSectWidth = 13;
  DEFAULT_TABHEIGHT = 26;
  ADVPAGE_OFFSET = 1;
  SCROLLER_SIZE = 32;
  PAGEBUTTON_SIZE = 18;

  MAJ_VER = 1; // Major version nr.
  MIN_VER = 6; // Minor version nr.
  REL_VER = 5; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // 1.1.0.0 : fixed issue with TAdvGlowButton painting on pager
  //         : fixed issue with anchored controls
  //         : fixed issue with page reorder in object treeview
  //         : added OnResize event
  //         : added FreeOnClose property
  // 1.1.1.0 : added PopupMenu property on TAdvOfficePage
  // 1.1.1.1 : fixed issue with tabs with TabEnabled = false
  // 1.1.2.0 : added new property PageIndex
  // 1.2.0.0 : New: keybooard support added
  //         : New: shortcuthints added
  //         : New: page OnShow event added
  // 1.2.0.1 : Fixed issue with form windows hook proc
  // 1.2.0.2 : Fixed issue with return value of AddAdvPage
  // 1.2.0.3 : Fixed issue with use of OnChanging event during component load
  //         : Fixed issue with Tab key handling
  // 1.2.0.4 : Fixed issue with hidden tabs & scrolling
  // 1.2.0.5 : Fixed issue with resizing control to very small sizes
  // 1.2.1.0 : New : OnClosedPage event added
  //         : New : drag & drop events added for TAdvOfficePager
  // 1.2.1.1 : Fixed issue with TabVisible and close button on tab
  // 1.2.1.2 : Improved : minor border drawing cosmetic issue
  // 1.2.1.3 : Improved : prevented reentrance in page close
  // 1.2.1.4 : Fixed : issue with styler change and button appearance update
  // 1.2.1.5 : Fixed : issue with FindNextPage
  // 1.2.1.6 : Fixed : issue with destroy during timer activity
  // 1.3.0.0 : New : ImagePosition can be set in TabSettings as left, top, bottom, right from tab caption
  //           New : Wordwrapped tab caption support
  //           New : autoscrolling pages while mouse is down on scroll buttons
  //           New : ScrollButtonsAlways property to show scroll buttons always irrespective of nr. of tabs
  //           New : OnDrawTab event for custom tab drawing
  //           New : fixed tab width setting with ellipsis text for non fitting tab caption
  // 1.3.0.1 : Fixed : issue with destroy of TAdvOfficePagerOfficeStyler at design time
  // 1.3.1.0 : New : added event OnHide to TAdvOfficePage
  // 1.3.1.1 : Fixed : issue with sequence on event OnClosedPage
  // 1.3.1.2 : Fixed : issue with OnChange event during loading
  // 1.3.2.0 : New : rotated prev/next buttons in left/right tab mode
  //         : Improved : image/text alignment in rotated tabs left/right
  // 1.3.2.1 : Fixed : issue with tabscroller update from setting TabVisible
  // 1.3.2.2 : Improved : position of text in tab with AntiAlias = aaNone
  // 1.3.2.3 : Fixed : issue with painting text on tab with fixed with & close button
  // 1.3.4.0 : New : Supports invisible tabs (with TabHeight = 0)
  // 1.3.5.0 : Improved : painting performance
  // 1.3.5.1 : Fixed : issue with OnShow event sequence
  // 1.3.5.2 : Fixed : issue with drawing imagelist images in tabs
  // 1.4.0.0 : New : Optional TabAppearance & PageAppearance control per page
  //         : New : Optional control on close button per page
  //         : New : left, right or left/right rounded tabs
  // 1.4.0.1 : Fixed : issue with copy & paste at design time
  // 1.4.1.0 : New : function IndexOfTabAt added
  // 1.4.1.1 : Fixed : small issue with OnChange/OnChanging event after removing all pages
  // 1.4.2.0 : New : AdvOfficePager.TabScroller public property exposed
  // 1.4.2.1 : Fixed : issue with OnPictureChanged handling
  // 1.5.0.0 : New : support for unicode captions
  // 1.5.1.0 : Improved : gradient, highlight & shadow painting improvements
  // 1.5.1.1 : Improved : GDI+ drawing
  // 1.5.2.0 : New : public property BufferedPages added
  // 1.5.3.0 : New : property Glow added
  // 1.5.3.1 : Fixed : issue with PageListMenu when WideCaptions are used
  // 1.6.0.0 : New : DockSite support
  // 1.6.0.1 : Fixed : issue with font styles on right positioned tabs
  // 1.6.0.2 : Fixed : issue with possible double auto creation of pages
  // 1.6.1.0 : Improved : undocking through tab
  // 1.6.2.0 : New : TabSettings.Alignment property for alignment control in fixed width tabs
  // 1.6.2.1 : Fixed : issue with font on disabled tabs
  // 1.6.2.2 : Fixed : issue with wordwrapped tabs
  // 1.6.2.3 : Fixed : issue with docking TTntForms on TAdvOfficePager
  // 1.6.2.4 : Fixed : issue with destroying pages in Delphi 7 or older
  // 1.6.2.5 : Fixed : issue with center alignment on left/right horiz. tabs
  // 1.6.2.6 : Fixed : issue with tab width calculation for wordwrapped tabs
  // 1.6.2.7 : Fixed : issue with tab width calculation for WideCaption
  // 1.6.2.8 : Improved : accelerator keys for wide captions also handled
  // 1.6.3.0 : New : exposed public property HotPageIndex
  // 1.6.4.0 : New : exposed OnClick / OnDblClick event on TAdvOfficePage
  // 1.6.4.1 : Fixed : update of tabs when TabAppearance.Font & tab picture changes at runtime
  // 1.6.4.2 : Fixed : issue with control aligning in Delphi 2009
  // 1.6.5.0 : New : method CloseActivePage added

type
  {$IFDEF DELPHI_UNICODE}
  THintInfo = Controls.THintInfo;
  PHintInfo = Controls.PHintInfo;
  {$ENDIF}

  TAdvOfficePager = class;
  TAdvOfficePage = class;

  TGradientDirection = (gdHorizontal, gdVertical);
  TGlowState = (gsHover, gsPush, gsNone);
  TButtonLayout = (blGlyphLeft, blGlyphTop, blGlyphRight, blGlyphBottom);
  TImagePosition = (ipLeft, ipTop, ipRight, ipBottom);
  TDropDownPosition = (dpRight, dpBottom);
  //TGDIPGradient = (ggRadial, ggVertical, ggDiagonalForward, ggDiagonalBackward);
  TCloseOnTabPos = (cpRight, cpLeft);
  TAdvTabShape =  (tsRectangle, tsLeftRamp, tsRightRamp, tsLeftRightRamp);

  TTabRounding = 0..8;

  TPagerTabSettings = class(TPersistent)
  private
    FLeftMargin: Integer;
    FRightMargin: Integer;
    FOnChange: TNotifyEvent;
    FHeight: Integer;
    FStartMargin: Integer;
    FEndMargin: Integer;
    FSpacing: Integer;
    FWidth: Integer;
    FWordWrap: Boolean;
    FImagePosition: TImagePosition;
    FRounding: TTabRounding;
    FShape: TAdvTabShape;
    FAlignment: TAlignment;
    procedure SetLeftMargin(const Value: Integer);
    procedure SetRightMargin(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetStartMargin(const Value: Integer);
    procedure SetEndMargin(const Value: Integer);
    procedure SetSpacing(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetImagePosition(const Value: TImagePosition);
    procedure SetRounding(const Value: TTabRounding);
    procedure SetShape(const Value: TAdvTabShape);
    procedure SetAlignment(const Value: TAlignment);
  protected
    procedure Changed;
    property EndMargin: Integer read FEndMargin write SetEndMargin;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property LeftMargin: Integer read FLeftMargin write SetLeftMargin default 4;
    property RightMargin: Integer read FRightMargin write SetRightMargin default 4;
    property StartMargin: Integer read FStartMargin write SetStartMargin default 60;
    property Height: Integer read FHeight write SetHeight default 26;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Width: Integer read FWidth write SetWidth default 0;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
    property ImagePosition: TImagePosition read FImagePosition write SetImagePosition default ipLeft;
    property Shape: TAdvTabShape read FShape write SetShape default tsRectangle;
    property Rounding: TTabRounding read FRounding write SetRounding default 1;
  end;

  TGradientBackground = class(TPersistent)
  private
    FSteps: Integer;
    FColor: TColor;
    FColorTo: TColor;
    FDirection: TGradientDirection;
    FOnChange: TNotifyEvent;
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetDirection(const Value: TGradientDirection);
    procedure SetSteps(const Value: Integer);
    procedure Changed;
  protected
  public
    constructor Create; 
    procedure Assign(Source: TPersistent); override;  
  published
    property Color: TColor read FColor write SetColor;
    property ColorTo: TColor read FColorTo write SetColorTo;
    property Direction: TGradientDirection read FDirection write SetDirection;
    property Steps: Integer read FSteps write SetSteps default 64;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TVistaBackground = class(TPersistent)
  private
    FSteps: Integer;
    FColor: TColor;
    FColorTo: TColor;
    FOnChange: TNotifyEvent;
    FColorMirror: TColor;
    FColorMirrorTo: TColor;
    FBorderColor: TColor;
    FGradientMirror: TGDIPGradient;
    FGradient: TGDIPGradient;
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetSteps(const Value: Integer);
    procedure Changed;
    procedure SetBorderColor(const Value: TColor);
    procedure SetColorMirror(const Value: TColor);
    procedure SetColorMirrorTo(const Value: TColor);
    procedure SetGradient(const Value: TGDIPGradient);
    procedure SetGradientMirror(const Value: TGDIPGradient);
  protected
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property Color: TColor read FColor write SetColor;
    property ColorTo: TColor read FColorTo write SetColorTo;
    property ColorMirror: TColor read FColorMirror write SetColorMirror;
    property ColorMirrorTo: TColor read FColorMirrorTo write SetColorMirrorTo;
    property Gradient: TGDIPGradient read FGradient write SetGradient;
    property GradientMirror: TGDIPGradient read FGradientMirror write SetGradientMirror;
    property Steps: Integer read FSteps write SetSteps default 64;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TCustomTabAppearance = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FBorderColor: TColor;
    FBorderColorHot: TColor;
    FColor: TColor;
    FColorTo: TColor;
    FColorHot: TColor;
    FColorHotTo: TColor;
    FColorSelectedTo: TColor;
    FBorderColorDisabled: TColor;
    FBorderColorSelected: TColor;
    FColorDisabled: TColor;
    FColorDisabledTo: TColor;
    FColorSelected: TColor;
    FColorMirror: TColor;
    FColorMirrorTo: TColor;
    FColorMirrorHot: TColor;
    FColorMirrorHotTo: TColor;
    FGradientMirror: TGDIPGradient;
    FGradientMirrorHot: TGDIPGradient;
    FGradient: TGDIPGradient;
    FGradientHot: TGDIPGradient;
    FColorMirrorDisabledTo: TColor;
    FColorMirrorDisabled: TColor;
    FColorMirrorSelectedTo: TColor;
    FColorMirrorSelected: TColor;
    FGradientSelected: TGDIPGradient;
    FGradientDisabled: TGDIPGradient;
    FGradientMirrorSelected: TGDIPGradient;
    FGradientMirrorDisabled: TGDIPGradient;
    FTextColorDisabled: TColor;
    FTextColorSelected: TColor;
    FTextColor: TColor;
    FTextColorHot: TColor;
    FBackGround: TGradientBackground;
    FBorderColorSelectedHot: TColor;
    FBorderColorDown: TColor;
    FFont: TFont;
    FHighLightColorHot: TColor;
    FShadowColor: TColor;
    FHighLightColorDown: TColor;
    FHighLightColorSelected: TColor;
    FHighLightColorSelectedHot: TColor;
    FHighLightColor: TColor;
    FOnFontChange: TNotifyEvent;
    procedure OnBackGroundChanged(Sender: TObject);
    procedure OnFontChanged(Sender: TObject);
    procedure SetBackGround(const Value: TGradientBackground);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderColorDisabled(const Value: TColor);
    procedure SetBorderColorSelected(const Value: TColor);
    procedure SetBorderColorSelectedHot(const Value: TColor);
    procedure SetColor(const Value: TColor);
    procedure SetColorDisabled(const Value: TColor);
    procedure SetColorDisabledTo(const Value: TColor);
    procedure SetColorHot(const Value: TColor);
    procedure SetColorHotTo(const Value: TColor);
    procedure SetColorMirror(const Value: TColor);
    procedure SetColorMirrorDisabled(const Value: TColor);
    procedure SetColorMirrorDisabledTo(const Value: TColor);
    procedure SetColorMirrorHot(const Value: TColor);
    procedure SetColorMirrorHotTo(const Value: TColor);
    procedure SetColorMirrorSelected(const Value: TColor);
    procedure SetColorMirrorSelectedTo(const Value: TColor);
    procedure SetColorMirrorTo(const Value: TColor);
    procedure SetColorSelected(const Value: TColor);
    procedure SetColorSelectedTo(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetGradient(const Value: TGDIPGradient);
    procedure SetGradientDisabled(const Value: TGDIPGradient);
    procedure SetGradientHot(const Value: TGDIPGradient);
    procedure SetGradientMirror(const Value: TGDIPGradient);
    procedure SetGradientMirrorDisabled(const Value: TGDIPGradient);
    procedure SetGradientMirrorHot(const Value: TGDIPGradient);
    procedure SetGradientMirrorSelected(const Value: TGDIPGradient);
    procedure SetGradientSelected(const Value: TGDIPGradient);
    procedure SetTextColor(const Value: TColor);
    procedure SetTextColorDisabled(const Value: TColor);
    procedure SetTextColorHot(const Value: TColor);
    procedure SetTextColorSelected(const Value: TColor);
    procedure SetBorderColorDown(const Value: TColor);
    procedure SetFont(const Value: TFont);
  protected
    procedure Changed;
    property BackGround: TGradientBackground read FBackGround write SetBackGround;
    property OnFontChange: TNotifyEvent read FOnFontChange write FOnFontChange;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property BorderColorHot: TColor read FBorderColorHot write FBorderColorHot;
    property BorderColorSelected: TColor read FBorderColorSelected write SetBorderColorSelected;
    property BorderColorSelectedHot: TColor read FBorderColorSelectedHot write SetBorderColorSelectedHot;
    property BorderColorDisabled: TColor read FBorderColorDisabled write SetBorderColorDisabled;
    property BorderColorDown: TColor read FBorderColorDown write SetBorderColorDown;
    property Color: TColor read FColor write SetColor;
    property ColorTo: TColor read FColorTo write SetColorTo;
    property ColorSelected: TColor read FColorSelected write SetColorSelected;
    property ColorSelectedTo: TColor read FColorSelectedTo write SetColorSelectedTo;
    property ColorDisabled: TColor read FColorDisabled write SetColorDisabled;
    property ColorDisabledTo: TColor read FColorDisabledTo write SetColorDisabledTo;
    property ColorHot: TColor read FColorHot write SetColorHot;
    property ColorHotTo: TColor read FColorHotTo write SetColorHotTo;
    property ColorMirror: TColor read FColorMirror write SetColorMirror;
    property ColorMirrorTo: TColor read FColorMirrorTo write SetColorMirrorTo;
    property ColorMirrorHot: TColor read FColorMirrorHot write SetColorMirrorHot;
    property ColorMirrorHotTo: TColor read FColorMirrorHotTo write SetColorMirrorHotTo;
    property ColorMirrorSelected: TColor read FColorMirrorSelected write SetColorMirrorSelected;
    property ColorMirrorSelectedTo: TColor read FColorMirrorSelectedTo write SetColorMirrorSelectedTo;
    property ColorMirrorDisabled: TColor read FColorMirrorDisabled write SetColorMirrorDisabled;
    property ColorMirrorDisabledTo: TColor read FColorMirrorDisabledTo write SetColorMirrorDisabledTo;
    property Font: TFont read FFont write SetFont;
    property Gradient: TGDIPGradient read FGradient write SetGradient;
    property GradientMirror: TGDIPGradient read FGradientMirror write SetGradientMirror;
    property GradientHot: TGDIPGradient read FGradientHot write SetGradientHot;
    property GradientMirrorHot: TGDIPGradient read FGradientMirrorHot write SetGradientMirrorHot;
    property GradientSelected: TGDIPGradient read FGradientSelected write SetGradientSelected;
    property GradientMirrorSelected: TGDIPGradient read FGradientMirrorSelected write SetGradientMirrorSelected;
    property GradientDisabled: TGDIPGradient read FGradientDisabled write SetGradientDisabled;
    property GradientMirrorDisabled: TGDIPGradient read FGradientMirrorDisabled write SetGradientMirrorDisabled;
    property TextColor: TColor read FTextColor write SetTextColor;
    property TextColorHot: TColor read FTextColorHot write SetTextColorHot;
    property TextColorSelected: TColor read FTextColorSelected write SetTextColorSelected;
    property TextColorDisabled: TColor read FTextColorDisabled write SetTextColorDisabled;
    property ShadowColor: TColor read FShadowColor write FShadowColor;
    property HighLightColor: TColor read FHighLightColor write FHighLightColor;
    property HighLightColorHot: TColor read FHighLightColorHot write FHighLightColorHot;
    property HighLightColorSelected: TColor read FHighLightColorSelected write FHighLightColorSelected;
    property HighLightColorSelectedHot: TColor read FHighLightColorSelectedHot write FHighLightColorSelectedHot;
    property HighLightColorDown: TColor read FHighLightColorDown write FHighLightColorDown;
  end;

  TTabAppearance = class(TCustomTabAppearance)
  private
  protected
  public
  published
    property BackGround;
  end;

  TPagerTabScroller = class(TObject)
  private
    FMin: integer;
    FMax: integer;
    FPosition: integer;
    FVisible: Boolean;
    procedure SetMax(const Value: integer);
    procedure SetMin(const Value: integer);
    procedure SetPosition(const Value: integer);
    procedure SetVisible(const Value: Boolean);
  protected
  public
    constructor Create;
    function CanGoForward: Boolean;
    function CanGoBack: Boolean;
    property Min: integer read FMin write SetMin;
    property Max: integer read FMax write SetMax;
    property Position: integer read FPosition write SetPosition;
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TDbgList = class(TList)
  private
    function GetItemsEx(Index: Integer): Pointer;
    procedure SetItemsEx(Index: Integer; const Value: Pointer);
  public
    property Items[Index: Integer]: Pointer read GetItemsEx write SetItemsEx; default;
  end;

  TPageButtonSettings = class(TPersistent)
  private
    FOnChange: TNotifyEvent;
    FPageListButton: boolean;
    FCloseButton: Boolean;
    FScrollButtonNextPicture: TGDIPPicture;
    FScrollButtonPrevPicture: TGDIPPicture;
    FPageListButtonPicture: TGDIPPicture;
    FCloseButtonPicture: TGDIPPicture;
    FScrollButtonPrevHint: String;
    FScrollButtonNextHint: String;
    FCloseButtonHint: String;
    FPageListButtonHint: String;
    FScrollButtonsAlways: Boolean;
    procedure Changed;
    procedure OnPictureChanged(Sender: TObject);
    procedure SetCloseButton(const Value: Boolean);
    procedure SetCloseButtonPicture(const Value: TGDIPPicture);
    procedure SetPageListButton(const Value: boolean);
    procedure SetPageListButtonPicture(const Value: TGDIPPicture);
    procedure SetScrollButtonNextPicture(const Value: TGDIPPicture);
    procedure SetScrollButtonPrevPicture(const Value: TGDIPPicture);
    procedure SetScrollButtonsAlways(const Value: Boolean);
  protected
    FScrollButtonDownPicture: TGDIPPicture;
    FScrollButtonUpPicture: TGDIPPicture;
    FPrevPictureChanged: Boolean;
    FNextPictureChanged: Boolean;
    //property NextPictureChanged: Boolean read FNextPictureChanged write SetNextPictureChanged;
    //property PrevPictureChanged: Boolean read FPrevPictureChanged write SetPrevPictureChanged;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property CloseButton: Boolean read FCloseButton write SetCloseButton default false;
    property PageListButton: boolean read FPageListButton write SetPageListButton default false;
    property CloseButtonPicture: TGDIPPicture read FCloseButtonPicture write SetCloseButtonPicture;
    property PageListButtonPicture: TGDIPPicture read FPageListButtonPicture write SetPageListButtonPicture;
    property ScrollButtonPrevPicture: TGDIPPicture read FScrollButtonPrevPicture write SetScrollButtonPrevPicture;
    property ScrollButtonNextPicture: TGDIPPicture read FScrollButtonNextPicture write SetScrollButtonNextPicture;
    property CloseButtonHint: String read FCloseButtonHint write FCloseButtonHint;
    property PageListButtonHint: String read FPageListButtonHint write FPageListButtonHint;
    property ScrollButtonsAlways: Boolean read FScrollButtonsAlways write SetScrollButtonsAlways default False;
    property ScrollButtonNextHint: String read FScrollButtonNextHint write FScrollButtonNextHint;
    property ScrollButtonPrevHint: String read FScrollButtonPrevHint write FScrollButtonPrevHint;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TCustomAdvOfficePagerStyler = class(TComponent)
  private
    FControlList: TDbgList;
    FTabAppearance: TTabAppearance;
    FPageAppearance: TVistaBackground;
    FRoundEdges: Boolean;
    FAutoThemeAdapt: boolean;
    FGlowButtonAppearance: TGlowButtonAppearance;
    FBlendFactor: Integer;
    procedure OnTabAppearanceChanged(Sender: TObject);
    procedure OnPageAppearanceChanged(Sender: TObject);
    procedure OnGlowButtonAppearanceChanged(Sender: TObject);
    procedure SetRoundEdges(const Value: boolean);
    procedure SetTabAppearance(const Value: TTabAppearance);
    procedure SetPageAppearance(const Value: TVistaBackground);
    procedure SetGlowButtonAppearance(const Value: TGlowButtonAppearance);
  protected
    procedure AddControl(AControl: TCustomControl);
    procedure RemoveControl(AControl: TCustomControl);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change(PropID: integer);
    property BlendFactor: Integer read FBlendFactor write FBlendFactor;

    property AutoThemeAdapt: boolean read FAutoThemeAdapt write FAutoThemeAdapt default False;
    property TabAppearance: TTabAppearance read FTabAppearance write SetTabAppearance;  // 1
    property PageAppearance: TVistaBackground read FPageAppearance write SetPageAppearance; // 2
    property RoundEdges: boolean read FRoundEdges write SetRoundEdges default True;   // 3
    property GlowButtonAppearance: TGlowButtonAppearance read FGlowButtonAppearance write SetGlowButtonAppearance; // 4
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Assign(Source: TPersistent); override;
  end;

  TProWinControl = class(TWinControl);

  TAdvOfficePage = class(TCustomControl)
  private
    FTabVisible: Boolean;
    FAdvOfficePager: TAdvOfficePager;
    FCaption: TCaption;
    FTabEnabled: Boolean;
    FImageIndex: Integer;
    FTimer: TTimer;
    FTimeInc: Integer;
    FStepHover: Integer;
    FStepPush: Integer;
    FGlowState: TGlowState;
    FTabHint: string;
    FOfficeHint: TAdvHintInfo;
    FIPicture: TGDIPPicture;
    FIDisabledPicture: TGDIPPicture;
    FUpdatingParent: Boolean;
    FShortCutHint: TShortCutHintWindow;
    FShortCutHintPos: TShortCutHintPos;
    FShortCutHintText: string;
    FOnShow: TNotifyEvent;
    FOnHide: TNotifyEvent;
    FShowClose: Boolean;
    FUseTabAppearance: Boolean;
    FTabAppearance: TTabAppearance;
    FPageAppearance: TVistaBackground;
    FUsePageAppearance: Boolean;
    FBkgCache: TBitmap;
    FValidCache: boolean;
    FWideCaption: widestring;
    procedure TimerProc(Sender: TObject);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure PictureChanged(Sender: TObject);
    procedure OnTabAppearanceFontChanged(Sender: TObject);
    procedure OnTabAppearanceChanged(Sender: TObject);
    procedure OnPageAppearanceChanged(Sender: TObject);
    procedure SetAdvOfficePager(const Value: TAdvOfficePager);
    procedure SetTabVisible(const Value: Boolean);
    procedure SetCaption(const Value: TCaption);
    procedure SetTabEnabled(const Value: Boolean);
    procedure SetImageIndex(const Value: Integer);
    procedure SetOfficeHint(const Value: TAdvHintInfo);
    procedure SetDisabledPicture(const Value: TGDIPPicture);
    procedure SetPicture(const Value: TGDIPPicture);
    function GetPageIndex: Integer;
    procedure SetPageIndex(const Value: Integer);
    procedure SetShowClose(const Value: Boolean);
    procedure SetTabAppearance(const Value: TTabAppearance);
    procedure SetUseTabAppearance(const Value: Boolean);
    procedure SetPageAppearance(const Value: TVistaBackground);
    procedure SetUsePageAppearance(const Value: Boolean);
    procedure SetWideCaption(const Value: widestring);
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
    procedure ShowShortCutHint;
    procedure HideShortCutHint;

    property AdvOfficePager: TAdvOfficePager read FAdvOfficePager write SetAdvOfficePager;
  published
    property Caption: TCaption read FCaption write SetCaption;
    property WideCaption: widestring read FWideCaption write SetWideCaption;
    property DisabledPicture: TGDIPPicture read FIDisabledPicture write SetDisabledPicture;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property PageAppearance: TVistaBackground read FPageAppearance write SetPageAppearance;
    property UsePageAppearance: Boolean read FUsePageAppearance write SetUsePageAppearance default false;
    property Picture: TGDIPPicture read FIPicture write SetPicture;
    property TabHint: string read FTabHint write FTabHint;
    property TabVisible: Boolean read FTabVisible write SetTabVisible default true;
    property TabEnabled: Boolean read FTabEnabled write SetTabEnabled default true;
    property ShowClose: Boolean read FShowClose write SetShowClose default true;
    property ShowHint;
    property OfficeHint: TAdvHintInfo read FOfficeHint write SetOfficeHint;
    property PageIndex: Integer read GetPageIndex write SetPageIndex stored false;
    property ShortCutHint: string read FShortCutHintText write FShortCutHintText;
    property ShortCutHintPos: TShortCutHintPos read FShortCutHintPos write FShortCutHintPos default shpTop;
    property TabAppearance: TTabAppearance read FTabAppearance write SetTabAppearance;
    property UseTabAppearance: Boolean read FUseTabAppearance write SetUseTabAppearance default false;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;    
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnClick;
    property OnDblClick;
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
  TTabClickEvent = procedure(Sender: TObject; PageIndex: integer) of object;

  TAdvOfficePager = class(TCustomControl)
  private
    FInternalOfficePagerStyler: TCustomAdvOfficePagerStyler;
    FOfficePagerStyler: TCustomAdvOfficePagerStyler;
    FCurrentOfficePagerStyler: TCustomAdvOfficePagerStyler;
    FPageMargin: integer;
    FOffSetY: integer;
    FOffSetX: integer;
    FAdvPages: TDbgList;
    FPropertiesLoaded: Boolean;
    FShowNonSelectedTabs: Boolean;
    FTabSettings: TPagerTabSettings;
    FTabScroller: TPagerTabScroller;
    FActivePageIndex: Integer;
    FHotPageIndex: Integer;
    FDownPageIndex: Integer;
    FOldHotPageIndex: Integer;
    FHintPageIndex: Integer;
    FImages: TCustomImageList;
    FDisabledImages: TCustomImageList;
    FNewPage: TAdvOfficePage;
    FUndockPage: TAdvOfficePage;
    //FScrollerHoverLeftBtn: Boolean;
    //FScrollerDownLeftBtn: Boolean;
    //FScrollerHoverRightBtn: Boolean;
    //FScrollerDownRightBtn: Boolean;
    FShowTabHint: Boolean;
    FOnChange: TNotifyEvent;
    FOnChanging: TTabChangingEvent;
    FOldCapRightIndent: Integer;
    FOfficeHint: TAdvHintInfo;
    FTabPosition: TTabPosition;
    FAntiAlias: TAntiAlias;
    FButtonSettings: TPageButtonSettings;
    FPageListMenu: TPopupMenu;
    FOnClosePage: TOnClosePage;
    FOnClosedPage: TOnClosedPage;
    FOnPageListClick: TOnPageListClick;
    FRotateTabLeftRight: Boolean;
    FCloseOnTab: Boolean;
    FCloseButton: TAdvGlowButton;
    FPageListButton: TAdvGlowButton;
    FScrollPrevButton: TAdvGlowButton;
    FScrollNextButton: TAdvGlowButton;
    FTabOffSet: Integer;
    FUseMaxSpace: Boolean;
    FFreeOnClose: Boolean;
    FShortCutHintWinList: TDbgList;
    FFormWndProc: TWndMethod;
    FTabShortCutHintShowing: Boolean;
    FTabShortCutChars: String;
    FShowShortCutHints: Boolean;
    FTabReorder: Boolean;
    FOnTabMoved: TTabMovedEvent;
    FIsClosing: Boolean;
    FOnDrawTab: TDrawTabEvent;
    FButtonsBkg: TBitmap;
    FCloseOnTabPosition: TCloseOnTabPos;
    FDesignTime: boolean;
    FBufferedPages: boolean;
    FOnTabClick: TTabClickEvent;
    FOnTabDblClick: TTabClickEvent;
    FOnTabRightClick: TTabClickEvent;
    FGlow: Boolean;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMControlListChange(var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;    
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMDockClient(var Message: TCMDockClient); message CM_DOCKCLIENT;
    procedure CMDockNotification(var Message: TCMDockNotification); message CM_DOCKNOTIFICATION;
    procedure CMUnDockClient(var Message: TCMUnDockClient); message CM_UNDOCKCLIENT;

    procedure OnTabSettingsChanged(Sender: TObject);
    procedure OnButtonSettingChanged(Sender: TObject);
    procedure OnCloseButtonClick(Sender: TObject);
    procedure OnPageListButtonClick(Sender: TObject);
    procedure OnPageListMenuClick(Sender: TObject);
    procedure OnScrollPrevButtonClick(Sender: TObject);
    procedure OnScrollNextButtonClick(Sender: TObject);
    procedure SubclassProc(var Msg: TMessage);
    procedure OnEnterTab(PageIndex: Integer);
    procedure OnExitTab(PageIndex: Integer);
    procedure SetPageValidCache(Value: Boolean);
    procedure SetPagePosition(AdvPage: TAdvOfficePage);
    procedure SetAllPagesPosition;
    procedure SetOfficePagerStyler(const Value: TCustomAdvOfficePagerStyler);
    function GetAdvOfficePageCount: integer;
    function GetAdvPages(index: integer): TAdvOfficePage;
    function GetPopupMenuEx: TPopupMenu;
    procedure SetPopupMenuEx(const Value: TPopupMenu);
    procedure SetShowNonSelectedTabs(const Value: Boolean);
    function GetActivePage: TAdvOfficePage;
    function GetActivePageIndex: Integer;
    procedure SetActivePage(const Value: TAdvOfficePage);
    procedure SetActivePageIndex(const Value: Integer);
    procedure SetTabSettings(const Value: TPagerTabSettings);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetDisabledImages(const Value: TCustomImageList);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SetOfficeHint(const Value: TAdvHintInfo);
    procedure SetTabPosition(const Value: TTabPosition);
    procedure SetAntiAlias(const Value: TAntiAlias);
    procedure SetButtonSettings(const Value: TPageButtonSettings);
    procedure SetPageListMenu(const Value: TPopupMenu);
    procedure SetCloseOnTab(const Value: Boolean);
    procedure SetRotateTabLeftRight(const Value: Boolean);
    procedure SetPageMargin(const Value: integer);
    function GetNextPictureChanged: Boolean;
    function GetPrevPictureChanged: Boolean;
    procedure SetNextPictureChanged(const Value: Boolean);
    procedure SetPrevPictureChanged(const Value: Boolean);
    procedure ReadNextPicChanged(Reader: TReader);
    procedure ReadPrevPicChanged(Reader: TReader);
    procedure WriteNextPicChanged(Writer: TWriter);
    procedure WritePrevPicChanged(Writer: TWriter);
    procedure SetCloseOnTabPosition(const Value: TCloseOnTabPos);
    function GetDockClientFromMousePos(MousePos: TPoint): TControl;    
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
    procedure DoAddDockClient(Client: TControl; const ARect: TRect); override;
    procedure DockOver(Source: TDragDockObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean); override;
    procedure DoRemoveDockClient(Client: TControl); override;
    function GetPageFromDockClient(Client: TControl): TAdvOfficePage;

    procedure AdjustClientRect(var Rect: TRect); override;
    procedure DefineProperties(Filer : TFiler); override;
    procedure DrawTab(PageIndex: Integer);
    procedure DrawAllTabs;
    //procedure DrawTabScrollBtnLeft;
    //procedure DrawTabScrollBtnRight;
    procedure DrawTabScrollButtons;
    procedure Paint; override;

    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetAdvPageBounds(AdvPage: TAdvOfficePage; var ALeft, ATop, AWidth, AHeight: Integer);

    procedure UpdateMe(PropID: integer);
    procedure ChangeActivePage(PageIndex: Integer);

    procedure UpdateTabScroller;
    procedure ScrollLeftBtnClick;
    procedure ScrollRightBtnClick;

    procedure ShowShortCutHintOfAllPages;
    procedure HideShortCutHintOfAllPages;
    function CreateShortCutHintWin: TShortCutHintWindow;
    procedure DestroyShortCutHintWin(ShortCutWin: TShortCutHintWindow);

    procedure InitializeAndUpdateButtons;
    function AnyButtonVisible: Boolean;

    function CanShowTab(PageIndex: Integer): Boolean;
    function GetVisibleTabCount: Integer;

    function GetTextSize(PageIndex: Integer): TSize;
    function GetTabImageSize(PageIndex: Integer): TSize;
    procedure GetCloseBtnImageAndTextRect(PageIndex: Integer; var CloseBtnR, TextR: TRect; var ImgP: TPoint); // used when TabSettings.Width > 0
    procedure InvalidateTab(PageIndex: Integer);
    function GetAdvPageRect: TRect;
    function GetButtonsRect: TRect;
    function GetTabsArea: TRect;
    function GetTabsRect: TRect;
    function GetTabRect(StartIndex, PageIndex: Integer; ConsiderTabScroller: Boolean): TRect;  overload;
    function GetTabRect(PageIndex: Integer): TRect;  overload;
    function GetTabRect(Page: TAdvOfficePage): TRect; overload;
    function PTOnTab(X, Y: Integer): Integer;
    function GetCloseButtonRect: TRect;
    function GetPageListRect: TRect;
    function GetTabScrollerRect: TRect;
    function GetTabScrollerLeftRect: TRect;
    function GetTabScrollerRightRect: TRect;
    function PtOnTabScrollLeftBtn(X, Y: integer): Boolean;
    function PtOnTabScrollRightBtn(X, Y: integer): Boolean;

    function IsActivePageNeighbour(PageIndex: Integer): Integer;   // -1= previous;  0= No;   +1= Next
    function GetLeftRoundingOffset: Integer;
    function GetRightRoundingOffset: Integer;

    function CanShowCloseButton: Boolean;
    function UseOldDrawing: Boolean;
    procedure UpdatePageAppearanceOfPages;
    procedure UpdateTabAppearanceOfPages;

    property NextPictureChanged: Boolean read GetNextPictureChanged write SetNextPictureChanged;
    property PrevPictureChanged: Boolean read GetPrevPictureChanged write SetPrevPictureChanged;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    destructor Destroy; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure Init;
    function  CloseActivePage : Boolean;

    procedure DragDrop(Source: TObject; X, Y: Integer); override;

    function GetVersionNr: integer;

    function AddAdvPage(AdvPage: TAdvOfficePage): integer; overload;
    function AddAdvPage(PageCaption: TCaption): integer; overload;
    procedure RemoveAdvPage(AdvPage: TAdvOfficePage);
    procedure MoveAdvPage(CurIndex, NewIndex: Integer);
    function FindNextPage(CurPage: TAdvOfficePage; GoForward, CheckTabVisible: Boolean): TAdvOfficePage;
    procedure SelectNextPage(GoForward: Boolean);
    function IndexOfPage(AdvPage: TAdvOfficePage): Integer;
    function IndexOfTabAt(X,Y: Integer): integer;    
    property ActivePageIndex: Integer read GetActivePageIndex write SetActivePageIndex;
    property BufferedPages: boolean read FBufferedPages write FBufferedPages;
    property AdvPageCount: integer read GetAdvOfficePageCount;
    property AdvPages[index: integer]: TAdvOfficePage read GetAdvPages;
    property TabScroller: TPagerTabScroller read FTabScroller;
    property HotPageIndex: Integer read FHotPageIndex;
  published
    property AdvOfficePagerStyler: TCustomAdvOfficePagerStyler read FOfficePagerStyler write SetOfficePagerStyler;
    property Align;
    property Anchors;
    property ActivePage: TAdvOfficePage read GetActivePage write SetActivePage;
    property AntiAlias: TAntiAlias read FAntiAlias write SetAntiAlias default aaClearType;
    property ButtonSettings: TPageButtonSettings read FButtonSettings write SetButtonSettings;
    property Constraints;
    property CloseOnTab: Boolean read FCloseOnTab write SetCloseOnTab default false;
    property CloseOnTabPosition: TCloseOnTabPos read FCloseOnTabPosition write SetCloseOnTabPosition default cpRight;
    property DisabledImages: TCustomImageList read FDisabledImages write SetDisabledImages;
    property FreeOnClose: boolean read FFreeOnClose write FFreeOnClose default false;
    property DockSite;
    property Glow: Boolean read FGlow write FGlow default true;
    property Images: TCustomImageList read FImages write SetImages;
    property OfficeHint: TAdvHintInfo read FOfficeHint write SetOfficeHint;
    property PageMargin: integer read FPageMargin write SetPageMargin default 1;
    property PageListMenu: TPopupMenu read FPageListMenu write SetPageListMenu;
    property PopupMenu: TPopupMenu read GetPopupMenuEx write SetPopupMenuEx;
    property RotateTabLeftRight: Boolean read FRotateTabLeftRight write SetRotateTabLeftRight default true;
    property ShowNonSelectedTabs: Boolean read FShowNonSelectedTabs write SetShowNonSelectedTabs default False;
    property ShowTabHint: Boolean read FShowTabHint write FShowTabHint default false;
    property ShowHint;
    property TabPosition: TTabPosition read FTabPosition write SetTabPosition default tpTop;
    property TabSettings: TPagerTabSettings read FTabSettings write SetTabSettings;
    property TabReorder: Boolean read FTabReorder write FTabReorder;
    property ShowShortCutHints: Boolean read FShowShortCutHints write FShowShortCutHints;
    property Version: string read GetVersion write SetVersion stored false;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChanging: TTabChangingEvent read FOnChanging write FOnChanging;
    property OnClosePage: TOnClosePage read FOnClosePage write FOnClosePage;
    property OnClosedPage: TOnClosedPage read FOnClosedPage write FOnClosedPage;
    property OnDrawTab: TDrawTabEvent read FOnDrawTab write FOnDrawTab;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnStartDock;
    property OnUnDock;

    property OnEnter;
    property OnExit;
    property OnPageListClick: TOnPageListClick read FOnPageListClick write FOnPageListClick;
    property OnTabMoved: TTabMovedEvent read FOnTabMoved write FOnTabMoved;
    property OnTabClick: TTabClickEvent read FOnTabClick write FOnTabClick;
    property OnTabDblClick: TTabClickEvent read FOnTabDblClick write FOnTabDblClick;
    property OnTabRightClick: TTabClickEvent read FOnTabRightClick write FOnTabRightClick;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
    property TabOrder;
    property TabStop;
  end;


  {function DrawVistaText(Canvas: TCanvas; Alignment: TAlignment; r: TRect; Caption:string; AFont: TFont; Enabled: Boolean; RealDraw: Boolean; AntiAlias: TAntiAlias; Direction: TTabPosition): TRect;
  procedure DrawVistaGradient(Canvas: TCanvas; r: TRect; CFU, CTU, CFB, CTB, PC: TColor;
     GradientU,GradientB: TGDIPGradient; Caption:string; AFont: TFont; Enabled: Boolean; Focus: Boolean;
     AntiAlias: TAntiAlias; RoundEdges: Boolean; Direction: TTabPosition = tpTop; X: Integer = 0; Y: Integer =0; Ang: Single = 0); overload;
   }
procedure DrawVistaTab(Canvas: TCanvas; r: TRect; CFU, CTU, CFB, CTB, PC: TColor; GradientU,GradientB: TGDIPGradient;
   Enabled: Boolean; Shape: TAdvTabShape; Focus: Boolean; {AntiAlias: TAntiAlias; }Rounding: TTabRounding; RotateLeftRight: Boolean; Direction: TTabPosition);

implementation

uses
  AdvOfficePagerStylers;

type
  TAccessCanvas = class(TCanvas);

var
  WM_OPDESTROYCLOSEBTN: Word;
  
  
//------------------------------------------------------------------------------

function ColorToARGB(Color: TColor): ARGB;
var
  c: TColor;
begin
  c := ColorToRGB(Color);
  Result := ARGB( $FF000000 or ((DWORD(c) and $FF) shl 16) or ((DWORD(c) and $FF00) or ((DWORD(c) and $ff0000) shr 16)));
end;

//------------------------------------------------------------------------------

procedure DrawGradient(Canvas: TCanvas; FromColor, ToColor: TColor; Steps: Integer; R: TRect; Direction: Boolean);
var
  diffr, startr, endr: Integer;
  diffg, startg, endg: Integer;
  diffb, startb, endb: Integer;
  rstepr, rstepg, rstepb, rstepw: Real;
  i, stepw: Word;

begin
  if Direction then
    R.Right := R.Right - 1
  else
    R.Bottom := R.Bottom - 1;

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

//------------------------------------------------------------------------------

function BlendColor(Col1,Col2:TColor; BlendFactor:Integer): TColor;
var
  r1,g1,b1: Integer;
  r2,g2,b2: Integer;

begin
  if BlendFactor >= 100 then
  begin
    Result := Col1;
    Exit;
  end;
  if BlendFactor <= 0 then
  begin
    Result := Col2;
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

//------------------------------------------------------------------------------

procedure DrawRoundRect(graphics: TGPGraphics; Pen: TGPPen; X,Y,Width,Height,Radius: integer);
var
  path:TGPGraphicsPath;
begin
  path := TGPGraphicsPath.Create;
  path.AddLine(X + radius, Y, X + width - (radius*2), Y);
  path.AddArc(X + width - (radius*2), Y, radius*2, radius*2, 270, 90);
  path.AddLine(X + width, Y + radius, X + width, Y + height - (radius*2));
  path.AddArc(X + width - (radius*2), Y + height - (radius*2), radius*2, radius*2,0,90);
  path.AddLine(X + width - (radius*2), Y + height, X + radius, Y + height);
  path.AddArc(X, Y + height - (radius*2), radius*2, radius*2, 90, 90);
  path.AddLine(X, Y + height - (radius*2), X, Y + radius);
  path.AddArc(X, Y, radius*2, radius*2, 180, 90);
  path.CloseFigure;
  graphics.DrawPath(pen, path);
  path.Free;
end;

//------------------------------------------------------------------------------

procedure DrawRect(graphics: TGPGraphics; Pen: TGPPen; X,Y,Width,Height: integer);
var
  path:TGPGraphicsPath;
begin
  path := TGPGraphicsPath.Create;
  path.AddLine(X, Y, X + width, Y);
  path.AddLine(X + width, Y, X + width, Y + height);
  path.AddLine(X + width, Y + height, X, Y + height);
  path.AddLine(X, Y + height, X, Y);
  path.CloseFigure;
  graphics.DrawPath(pen, path);
  path.Free;
end;

//------------------------------------------------------------------------------

function TrimText(Text: String; r: TRect; GDIPDraw: Boolean; graphics : TGPGraphics; Canvas: TCanvas; font: TGPFont; stringFormat: TGPStringFormat; Ellipsis: Boolean; Direction: TTabPosition; WordWrap: boolean): string;
var
  rectf: TGPRectF;
  w, h: Integer;
  x1,y1,y2: single;
  sizerect: TGPRectF;
  s, s2: string;
  i, j: integer;
  R2: TRect;
begin
  if WordWrap then
  begin
    Result := Text;
    Exit;
  end;

  //R.Right := R.Right - 2;
  w := R.Right - R.Left;
  h := R.Bottom - R.Top;
  x1 := r.Left;
  y1 := r.Top;
  y2 := h;

  if Direction in [tpLeft, tpRight] then
  begin
    //h := R.Right - R.Left;
    w := R.Bottom - R.Top;
  end;

  if Ellipsis then
    s := '...'
  else
    s := '';

  if GDIPDraw then
  begin
    stringFormat := TGPStringFormat.Create;
    w := w - 2;
    rectf := MakeRect(x1,y1,1000,y2);
    graphics.MeasureString(Text, Length(Text), font, rectf, stringFormat, sizerect);

    //-- Add ellipsis
    if (sizerect.Width >= w) then
    begin
      rectf := MakeRect(x1,y1,1000,y2);
      j := Length(Text);
      for i := 0 to j do
      begin
        s2 := Text + s;
        graphics.MeasureString(s2, Length(s2), font, rectf, stringFormat, sizerect);
        if (sizerect.Width >= w) and (Text <> '') then
        begin
          Text := Copy(Text, 1, Length(Text)-1);
        end
        else
        begin
          Break;
        end;
      end;
      Text := Text + s;
    end;
    stringFormat.Free;
  end
  else
  begin
    R2 := Rect(0, 0, 1000, 100);
    DrawText(Canvas.Handle,PChar(Text),Length(Text), R2, DT_CALCRECT or DT_LEFT or DT_SINGLELINE);
    if (R2.Right >= w) then
    begin
      j := Length(Text);
      for i := 0 to j do
      begin
        s2 := Text + s;
        DrawText(Canvas.Handle,PChar(s2),Length(s2), R2, DT_CALCRECT or DT_LEFT or DT_SINGLELINE);
        if (R2.Right >= w) and (Text <> '') then
        begin
          Text := Copy(Text, 1, Length(Text)-1);
        end
        else
        begin
          Break;
        end;
      end;
      Text := Text + s;
    end;
  end;

  Result := Text;
end;

function TrimTextW(Text: WideString; r: TRect; GDIPDraw: Boolean; graphics : TGPGraphics; Canvas: TCanvas; font: TGPFont; stringFormat: TGPStringFormat; Ellipsis: Boolean; Direction: TTabPosition; WordWrap: boolean): WideString;
var
  rectf: TGPRectF;
  w, h: Integer;
  x1,y1,y2: single;
  sizerect: TGPRectF;
  s, s2: WideString;
  i, j: integer;
  R2: TRect;
begin
  if WordWrap then
  begin
    Result := Text;
    Exit;
  end;


  //R.Right := R.Right - 2;
  w := R.Right - R.Left;
  h := R.Bottom - R.Top;
  x1 := r.Left;
  y1 := r.Top;
  y2 := h;

  if Direction in [tpLeft, tpRight] then
  begin
    //h := R.Right - R.Left;
    w := R.Bottom - R.Top;
  end;

  if Ellipsis then
    s := '...'
  else
    s := '';
    
  if GDIPDraw then
  begin
    stringFormat := TGPStringFormat.Create;
    w := w - 2;
    rectf := MakeRect(x1,y1,1000,y2);
    graphics.MeasureString(Text, Length(Text), font, rectf, stringFormat, sizerect);
    //-- Add ellipsis
    if (sizerect.Width >= w) then
    begin
      rectf := MakeRect(x1,y1,1000,y2);
      j := Length(Text);
      for i := 0 to j do
      begin
        s2 := Text + s;
        graphics.MeasureString(s2, Length(s2), font, rectf, stringFormat, sizerect);
        if (sizerect.Width >= w) and (Text <> '') then
        begin
          Text := Copy(Text, 1, Length(Text)-1);
        end
        else
        begin
          Break;
        end;
      end;
      Text := Text + s;
    end;
    stringFormat.Free;
  end
  else
  begin
    R2 := Rect(0, 0, 1000, 100);
    DrawTextW(Canvas.Handle, PWideChar(Text), -1, R2, DT_CALCRECT or DT_LEFT or DT_SINGLELINE);
    if (R2.Right >= w) then
    begin
      j := Length(Text);
      for i := 0 to j do
      begin
        s2 := Text + s;
        DrawTextW(Canvas.Handle, PWideChar(s2), -1, R2, DT_CALCRECT or DT_LEFT or DT_SINGLELINE);
        if (R2.Right >= w) and (Text <> '') then
        begin
          Text := Copy(Text, 1, Length(Text)-1);
        end
        else
        begin
          Break;
        end;
      end;
      Text := Text + s;
    end;
  end;

  Result := Text;
end;

//------------------------------------------------------------------------------

function WideDCTextExtent(hDC: THandle; const Text: WideString): TSize;
begin
  Result.cx := 0;
  Result.cy := 0;
  Windows.GetTextExtentPoint32W(hDC, PWideChar(Text), Length(Text), Result);
end;

function WideCanvasTextExtent(Canvas: TCanvas; const Text: WideString): TSize;
begin
  with TAccessCanvas(Canvas) do begin
    RequiredState([csHandleValid, csFontValid]);
    Result := WideDCTextExtent(Handle, Text);
  end;
end;

function WideCanvasTextWidth(Canvas: TCanvas; const Text: WideString): Integer;
begin
  Result := WideCanvasTextExtent(Canvas, Text).cX;
end;

function WideCanvasTextHeight(Canvas: TCanvas; const Text: WideString): Integer;
begin
  Result := WideCanvasTextExtent(Canvas, Text).cY;
end;

//------------------------------------------------------------------------------

function DrawVistaText(Canvas: TCanvas; Alignment: TAlignment; r: TRect; Caption: string; WideCaption: WideString; AFont: TFont; Enabled: Boolean; RealDraw: Boolean; AntiAlias: TAntiAlias; Direction: TTabPosition; Ellipsis, WordWrap: Boolean): TRect;
var
  graphics : TGPGraphics;
  w,h: Integer;
  fontFamily: TGPFontFamily;
  font: TGPFont;
  rectf: TGPRectF;
  stringFormat: TGPStringFormat;
  solidBrush: TGPSolidBrush;
  x1,y1,x2,y2: single;
  fs: integer;
  sizerect: TGPRectF;
  szRect: TRect;
  DTFLAG: DWORD;
begin
  stringFormat := nil;
  graphics := nil;
  fontFamily := nil;
  font := nil;
  solidBrush := nil;

  if (Caption <> '') or (WideCaption <> '') then
  begin
    try
      w := R.Right - R.Left;
      h := R.Bottom - R.Top;

      x1 := r.Left;
      y1 := r.Top;
      x2 := w;
      y2 := h;

      rectf := MakeRect(x1,y1,x2,y2);      

      try
        if AntiAlias <> aaNone then
        begin
          graphics := TGPGraphics.Create(Canvas.Handle);
          fontFamily:= TGPFontFamily.Create(AFont.Name);

          if (fontFamily.Status in [FontFamilyNotFound, FontStyleNotFound]) then
          begin
            fontFamily.Free;
            fontFamily := TGPFontFamily.Create('Arial');
          end;

          fs := 0;

          if (fsBold in AFont.Style) then
            fs := fs + 1;

          if (fsItalic in AFont.Style) then
            fs := fs + 2;

          if (fsUnderline in AFont.Style) then
            fs := fs + 4;


          font := TGPFont.Create(fontFamily, AFont.Size , fs, UnitPoint);

          graphics.SetSmoothingMode(SmoothingModeAntiAlias);

          if RealDraw then
          begin
            case Direction of
              tpTop, tpBottom: stringFormat := TGPStringFormat.Create;
              tpLeft:  stringFormat := TGPStringFormat.Create;
              tpRight: stringFormat := TGPStringFormat.Create($00000002);
            end;
          end
          else
            stringFormat := TGPStringFormat.Create;

          if Enabled then
            solidBrush := TGPSolidBrush.Create(ColorToARGB(AFont.Color))
          else
            solidBrush := TGPSolidBrush.Create(ColorToARGB(clGray));

          case Alignment of
            taLeftJustify: stringFormat.SetAlignment(StringAlignmentNear);
            taCenter: stringFormat.SetAlignment(StringAlignmentCenter);
            taRightJustify: stringFormat.SetAlignment(StringAlignmentFar);
          end;

          // Center the block of text (top to bottom) in the rectangle.
          stringFormat.SetLineAlignment(StringAlignmentCenter);
          stringFormat.SetHotkeyPrefix(HotkeyPrefixShow);

          case AntiAlias of
          aaClearType:graphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
          aaAntiAlias:graphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
          end;
        end;

        if AntiAlias = aaNone then
        begin
          szRect.Left := round(rectf.X);
          szRect.Top := round(rectf.Y);

          szRect.Right := szRect.Left + 2;
          DTFLAG := DT_CALCRECT or DT_LEFT;
          if Ellipsis then
            DTFLAG := DTFLAG or DT_END_ELLIPSIS
          else
            DTFLAG := DTFLAG or DT_WORDBREAK;

          if RealDraw and Ellipsis then
          begin
            if (Caption <> '')  then
              Caption := TrimText(Caption, r, False, nil, Canvas, font, nil, True, Direction, WordWrap)
            else if (WideCaption <> '') then
              WideCaption := TrimTextW(WideCaption, r, False, nil, Canvas, font, nil, True, Direction, WordWrap);
          end;

          if (Caption <> '') then
            szRect.Bottom := DrawText(Canvas.Handle,PChar(Caption),Length(Caption), szrect, DTFLAG)
          else
            szRect.Bottom := DrawTextW(Canvas.Handle,PWideChar(WideCaption), -1, szrect, DTFLAG);

          sizeRect.X := szRect.Left;
          sizeRect.Y := szRect.Top;
          sizeRect.Width := szRect.Right - szRect.Left;
          sizeRect.Height := szRect.Bottom - szRect.Top;
        end
        else
        begin
          if RealDraw and Ellipsis then
          begin
            //stringFormat.SetTrimming(StringTrimmingEllipsisCharacter);
            if (Caption <> '') then
              Caption := TrimText(Caption, r, True, graphics, nil, font, stringformat, True, Direction, WordWrap)
            else if (WideCaption <> '') then
              WideCaption := TrimTextW(WideCaption, r, True, graphics, nil, font, stringformat, True, Direction, WordWrap);
          end;

          if (Caption <> '') then
            graphics.MeasureString(Caption, Length(Caption), font, rectf, stringFormat, sizerect)
          else
            graphics.MeasureString(WideCaption, Length(WideCaption), font, rectf, stringFormat, sizerect);

        end;


        Result := Rect(round(sizerect.X), Round(sizerect.Y), Round(sizerect.X + sizerect.Width), Round(sizerect.Y + sizerect.Height));
        rectf := MakeRect(x1,y1,x2,y2);

        if RealDraw then
        begin
          //graphics.DrawString(Caption, Length(Caption), font, rectf, stringFormat, solidBrush);
          if AntiAlias = aaNone then
          begin
            szRect.Left := round(rectf.X) + 3;
            szRect.Top := round(rectf.Y);
            szRect.Right := szRect.Left + round(rectf.Width);
            szRect.Bottom := szRect.Top + round(rectf.Height);
            Canvas.Brush.Style := bsClear;

            DTFLAG := DT_LEFT;
            case Alignment of
            taRightJustify: DTFLAG := DT_RIGHT;
            taCenter: DTFLAG := DT_CENTER;
            end;

            {if Ellipsis then
            begin
              Caption := TrimText(Caption, r, False, nil, Canvas, font, stringformat, True);
            end;}
            if (Caption <> '') then
              DrawText(Canvas.Handle,PChar(Caption),Length(Caption), szrect, DTFLAG or DT_VCENTER or DT_SINGLELINE)
            else
              DrawTextW(Canvas.Handle,PWideChar(WideCaption), -1, szrect, DTFLAG or DT_VCENTER or DT_SINGLELINE);
          end
          else
          begin
            {if Ellipsis then
            begin
              //stringFormat.SetTrimming(StringTrimmingEllipsisCharacter);
              Caption := TrimText(Caption, r, True, graphics, nil, font, stringformat, True);
            end;}

            if (Caption <> '') then
              graphics.DrawString(Caption, Length(Caption), font, rectf, stringFormat, solidBrush)
            else
              graphics.DrawString(WideCaption, Length(WideCaption), font, rectf, stringFormat, solidBrush);
          end;
        end;
      except

      end;

    finally

      if (AntiAlias <> aaNone) then
      begin
        if Assigned(stringformat) then
          FreeAndNil(stringformat);

        if Assigned(solidBrush) then
          FreeAndNil(solidBrush);

        if Assigned(font) then
          FreeAndNil(font);

        if Assigned(fontfamily) then
          FreeAndNil(fontfamily);

        if Assigned(graphics) then
          FreeAndNil(graphics);
      end;

    end;
  end;
end;

//------------------------------------------------------------------------------

procedure DrawVistaGradient(Canvas: TCanvas; r: TRect; CFU, CTU, CFB, CTB, PC: TColor;
   GradientU,GradientB: TGDIPGradient; Caption: string; AFont: TFont;
   Images: TImageList; ImageIndex: integer; EnabledImage: Boolean; Layout: TButtonLayout;
   DropDownButton: Boolean; DrawDwLine: Boolean; Enabled: Boolean; Focus: Boolean; DropDownPos: TDropDownPosition;
   Picture: TGDIPPicture; AntiAlias: TAntiAlias; RoundEdges: Boolean; RotateLeftRight: Boolean; Direction: TTabPosition); overload;
var
  graphics : TGPGraphics;
  path: TGPGraphicsPath;
  pthGrBrush: TGPPathGradientBrush;
  solGrBrush: TGPSolidBrush;
  linGrBrush: TGPLinearGradientBrush;
  gppen : tgppen;
  count: Integer;
  w,h,h2,w2: Integer;
  colors : array[0..0] of TGPColor;
  fontFamily: TGPFontFamily;
  font: TGPFont;
  rectf: TGPRectF;
  stringFormat: TGPStringFormat;
  solidBrush: TGPSolidBrush;
  x1,y1,x2,y2: single;
  fs: integer;
  sizerect: TGPRectF;
  ImgX, ImgY, ImgW, ImgH: Integer;
  BtnR, DwR: TRect;
  AP: TPoint;
  szRect: TRect;

  procedure DrawArrow(ArP: TPoint; ArClr: TColor);
  begin
    Canvas.Pen.Color := ArClr;
    Canvas.MoveTo(ArP.X, ArP.Y);
    Canvas.LineTo(ArP.X + 5, ArP.Y);
    Canvas.MoveTo(ArP.X + 1, ArP.Y + 1);
    Canvas.LineTo(ArP.X + 4, ArP.Y + 1);
    Canvas.Pixels[ArP.X + 2, ArP.Y + 2] := ArClr;
  end;

begin
  BtnR := R;
  if DropDownPos = dpRight then
  begin
    DwR := Rect(BtnR.Right - DropDownSectWidth, BtnR.Top, BtnR.Right, BtnR.Bottom);
    if DropDownButton then
      BtnR.Right := DwR.Left;
  end
  else // DropDownPos = doBottom
  begin
    DwR := Rect(BtnR.Left, BtnR.Bottom - DropDownSectWidth, BtnR.Right, BtnR.Bottom);
    if DropDownButton then
      BtnR.Bottom := DwR.Top;
  end;

  w := r.Right - r.Left;
  h := r.Bottom - r.Top;

  h2 := h div 2;
  w2 := w div 2;

  graphics := TGPGraphics.Create(Canvas.Handle);

  case (Direction) of
    tpTop:
    begin
      // down ellips brush

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfb));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.top +  h2, w, h2));
      solGrBrush.Free;

      //Canvas.Brush.Color := cfb;
      //Canvas.FillRect(rect(r.Left , r.top +  h2, r.Right , r.Bottom ));

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      //  path.AddRectangle(MakeRect(r.Left, r.Top +  (h div 2), w , h));
      path.AddEllipse(r.Left, r.Top +  h2, w , h);

      pthGrBrush := nil;
      linGrBrush := nil;

      case GradientB of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2,w,h2),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeVertical);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2,w,h2),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2,w,h2),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeBackwardDiagonal);
      end;

      if GradientB = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left + w2, r.Bottom));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTB));

        colors[0] := ColorToARGB(CFB);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);
        graphics.FillRectangle(pthGrBrush, r.Left + 1,r.Top + h2, w - 1, h2+1);
        pthGrBrush.Free;
      end
      else
      begin
        if not RotateLeftRight then
          graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + h2 + 1, w - 1, h2 - 1)
        else
          graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + h2 + 1, w - 1, h2 + 1);
        linGrBrush.Free;
      end;

      path.Free;

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfu));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.Top , w , h2));
      solGrBrush.Free;

      //Canvas.Brush.Color := cfu;
      //Canvas.FillRect(rect(r.Left , r.Top , r.Right , r.top +  h2));

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Left, r.Top - h2 , w , h);

      case GradientU of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);                      // FF: Gradient fix here replace h by h2
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h2+1),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeVertical);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeBackwardDiagonal);
      end;

      if GradientU = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left + w2, r.top));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTU));

        colors[0] := ColorToARGB(CFU);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);

        graphics.FillRectangle(pthGrBrush, r.Left + 1,r.Top + 1, w - 1, h - h2 - 1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + 1, w - 1, h2);
        linGrBrush.Free;
      end;

      path.Free;

    end;
    tpBottom:
    begin
      // down ellips brush

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfb));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.top, w , h2));
      solGrBrush.Free;

      //Canvas.Brush.Color := cfb;
      //Canvas.FillRect(rect(r.Left , r.top, r.Right , r.top +  h2));

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      //  path.AddRectangle(MakeRect(r.Left, r.Top +  (h div 2), w , h));
      path.AddEllipse(r.Left, r.Top, w , h2);

      pthGrBrush := nil;
      linGrBrush := nil;

      case GradientB of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h2),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeVertical);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h2),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h2),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeBackwardDiagonal);
      end;

      if GradientB = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left + w2, r.Top));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTB));

        colors[0] := ColorToARGB(CFB);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);
        graphics.FillRectangle(pthGrBrush, r.Left + 1,r.Top, w - 1, h2+1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + 1, w - 1, h2 + 1);
        linGrBrush.Free;
      end;

      path.Free;

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfu));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.top +  h2, w , h2));
      solGrBrush.Free;

      //Canvas.Brush.Color := cfu;
      //Canvas.FillRect(rect(r.Left , r.top +  h2, r.Right , r.Bottom));

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Left, r.Bottom - h2 , w , h);

      case GradientU of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);                      // FF: Gradient fix here replace h by h2
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2-1,w,h2),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeVertical);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2,w,h),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2,w,h),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeBackwardDiagonal);
      end;

      if GradientU = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left + w2, r.Bottom));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTU));

        colors[0] := ColorToARGB(CFU);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);

        graphics.FillRectangle(pthGrBrush, r.Left + 1,r.Top + h2 + 1, w - 1, h2 - 1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + h2, w - 1, h2 - 1);
        linGrBrush.Free;
      end;

      path.Free;
    end;
    tpLeft:
    begin
      // down ellips brush

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfb));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left + w2, r.top, w2 , h));
      solGrBrush.Free;

      //Canvas.Brush.Color := cfb;
      //Canvas.FillRect(rect(r.Left + w2, r.top, r.Right , r.Bottom));

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      //  path.AddRectangle(MakeRect(r.Left, r.Top +  (h div 2), w , h));
      path.AddEllipse(r.Left + w2, r.Top, w , h);

      pthGrBrush := nil;
      linGrBrush := nil;

      case GradientB of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left + w2,r.Top,w2,h),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeHorizontal);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left + w2,r.Top,w2,h),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left + w2,r.Top,w2,h),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeBackwardDiagonal);
      end;

      if GradientB = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Right, r.Top + h2));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTB));

        colors[0] := ColorToARGB(CFB);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);
        graphics.FillRectangle(pthGrBrush, r.Left + w2, r.Top, w2 + 1, h-1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left + w2 + 1,r.Top, w2 + 1, h - 1);
        linGrBrush.Free;
      end;

      path.Free;

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfu));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.Top , w2 , h));
      solGrBrush.Free;

      //Canvas.Brush.Color := cfu;
      //Canvas.FillRect(rect(r.Left , r.Top , r.Left + w2 , r.Bottom));

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Left - w2, r.Top, w , h);

      case GradientU of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);                      // FF: Gradient fix here replace h by h2
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w2,h),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeHorizontal);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeBackwardDiagonal);
      end;

      if GradientU = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left, r.top + h2));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTU));

        colors[0] := ColorToARGB(CFU);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);

        graphics.FillRectangle(pthGrBrush, r.Left + 1,r.Top + 1, w2 - 1, h - 1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + 1, w2 - 1, h - 1);
        linGrBrush.Free;
      end;

      path.Free;

    end;
    tpRight:
    begin

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfu));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Right - w2 , r.Top , w2, h));
      solGrBrush.Free;

      //Canvas.Brush.Color := cfu;
      //Canvas.FillRect(rect(r.Right - w2 , r.Top , r.Right ,r.Bottom));

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Right - w2, r.Top, w, h);

      pthGrBrush := nil;
      linGrBrush := nil;

      case GradientU of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);                      // FF: Gradient fix here replace h by h2
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Right-w2,r.Top,w2,h),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeHorizontal);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Right-w2,r.Top,w,h),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Right-w2,r.Top,w,h),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeBackwardDiagonal);
      end;

      if GradientU = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Right, r.top + h2));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTU));

        colors[0] := ColorToARGB(CFU);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);

        graphics.FillRectangle(pthGrBrush, r.Right - w2 + 1,r.Top + 1, w2 - 1, h - 1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Right - w2, r.Top + 1, w2, h - 1);
        linGrBrush.Free;
      end;

      path.Free;

      // down ellips brush

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfb));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.top, w2, h));
      solGrBrush.Free;

      //Canvas.Brush.Color := cfb;
      //Canvas.FillRect(rect(r.Left , r.top, r.Left + w2, r.Bottom ));


      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      //  path.AddRectangle(MakeRect(r.Left, r.Top +  (h div 2), w , h));
      path.AddEllipse(r.Left - w2, r.Top, w , h);

      pthGrBrush := nil;
      linGrBrush := nil;

      case GradientB of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w2+2,h),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeHorizontal);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w2,h),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w2,h),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeBackwardDiagonal);
      end;

      if GradientB = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left, r.Top + h2));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTB));

        colors[0] := ColorToARGB(CFB);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);
        graphics.FillRectangle(pthGrBrush, r.Left,r.Top, w2 + 1, h-1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left,r.Top, w2 + 2, h - 1);
        linGrBrush.Free;
      end;

      path.Free;

    end;
  end;


  gppen := tgppen.Create(ColorToARGB(PC),1);

  graphics.SetSmoothingMode(SmoothingModeAntiAlias);

  if (PC <> clNone) then
  begin
    if not RoundEdges then
      DrawRect(graphics, gppen,r.Left,r.Top, w - 1, h - 1)
    else
      DrawRoundRect(graphics, gppen,r.Left,r.Top, w - 1, h - 1, 3);
  end;

  gppen.Free;

  if Focus then
  begin
    gppen := tgppen.Create(ColorToARGB($E4AD89),1);
    graphics.SetSmoothingMode(SmoothingModeAntiAlias);
    DrawRoundRect(graphics, gppen,r.Left + 1,r.Top + 1, r.Right - 3, r.Bottom - 3, 3);
    gppen.Free;
    gppen := tgppen.Create(ColorToARGB(clgray),1);
    gppen.SetDashStyle(DashStyleDot);
    graphics.SetSmoothingMode(SmoothingModeAntiAlias);
    DrawRoundRect(graphics, gppen,r.Left + 2,r.Top + 2, r.Right - 5, r.Bottom - 5, 3);
    gppen.Free;
  end;

  fontFamily:= TGPFontFamily.Create(AFont.Name);

  fs := 0;

  ImgH := 0;
  ImgW := 0;

  if (fsBold in AFont.Style) then
    fs := fs + 1;
  if (fsItalic in AFont.Style) then
    fs := fs + 2;
  if (fsUnderline in AFont.Style) then
    fs := fs + 4;

  if Assigned(Picture) and not Picture.Empty then
  begin
    Picture.GetImageSizes;
    ImgW := Picture.Width;
    ImgH := Picture.Height;
  end
  else
  begin
    if (ImageIndex > -1) and Assigned(Images) then
    begin
      ImgW := Images.Width;
      ImgH := Images.Height;
    end;
  end;

  if (Caption <> '') then
  begin
    font := TGPFont.Create(fontFamily, AFont.Size , fs, UnitPoint);

    w := BtnR.Right - BtnR.Left;
    h := BtnR.Bottom - BtnR.Top;

    x1 := r.Left;
    y1 := r.Top;
    x2 := w;
    y2 := h;

    rectf := MakeRect(x1,y1,x2,y2);

    stringFormat := TGPStringFormat.Create;

    if Enabled then
      solidBrush := TGPSolidBrush.Create(ColorToARGB(AFont.Color))
    else
      solidBrush := TGPSolidBrush.Create(ColorToARGB(clGray));

    // Center-justify each line of text.
    stringFormat.SetAlignment(StringAlignmentCenter);

    // Center the block of text (top to bottom) in the rectangle.
    stringFormat.SetLineAlignment(StringAlignmentCenter);

    stringFormat.SetHotkeyPrefix(HotkeyPrefixShow);

    case AntiAlias of
    aaClearType:graphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
    aaAntiAlias:graphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
    end;

    //graphics.MeasureString(Caption, Length(Caption), font, rectf, stringFormat, sizerect);
    if AntiAlias = aaNone then
    begin
      szRect.Left := round(rectf.X);
      szRect.Top := round(rectf.Y);

      szRect.Right := szRect.Left + 2;
      szRect.Bottom := DrawText(Canvas.Handle,PChar(Caption),Length(Caption), szrect, DT_CALCRECT or DT_LEFT or DT_WORDBREAK);

      sizeRect.X := szRect.Left;
      sizeRect.Y := szRect.Top;
      sizeRect.Width := szRect.Right - szRect.Left;
      sizeRect.Height := szRect.Bottom - szRect.Top;
    end
    else
      graphics.MeasureString(Caption, Length(Caption), font, rectf, stringFormat, sizerect);

    if (ImgW > 0) then
    begin
      case Layout of
        blGlyphLeft:
        begin
          x1 := r.Left + 2 + ImgW;
          x2 := w - 2 - ImgW;

          ImgX := round(sizerect.X - ImgW div 2);
          if ImgX < 2 then ImgX := 2;
          ImgY := r.Top + Max(0, (h - ImgH) div 2);
        end;
        blGlyphTop:
        begin
          y1 := r.Top{ + 2} + ImgH;
          y2 := h - 2 - ImgH;

          ImgX := r.Left + Max(0, (w - ImgW) div 2);
          ImgY := round(y2 - sizerect.Height);
          ImgY := Max(0, ImgY div 2);
          ImgY := round(y1) - ImgH + ImgY; //round(sizerect.Height) - ImgY - 4;
          if ImgY < 2 then ImgY := 2;
        end;
        blGlyphRight:
        begin
          x1 := 2;
          x2 := w - 4 - ImgW;

          ImgX := round(X2 - sizerect.width);
          ImgX := Max(0, ImgX div 2);
          ImgX := ImgX + round(sizerect.width) + 4;
          if ImgX > (w - ImgW) then
            ImgX := w - ImgW - 2;
          ImgY := r.Top + Max(0, (h - ImgH) div 2);
        end;
        blGlyphBottom:
        begin
          y1 := 2;
          y2 := h - 2 - ImgH;

          ImgX := r.Left + Max(0, (w - ImgW) div 2);
          ImgY := round(y2 - sizerect.Height);
          ImgY := Max(0, ImgY div 2);
          ImgY := round(sizerect.Height + 2) + ImgY;
          if ImgY > (h - ImgH) then ImgY := h - ImgH - 2;
        end;
      end;
    end;

    rectf := MakeRect(x1,y1,x2,y2);

    //graphics.DrawString(Caption, Length(Caption), font, rectf, stringFormat, solidBrush);
    if AntiAlias = aaNone then
    begin
      szRect.Left := round(rectf.X);
      szRect.Top := round(rectf.Y);
      szRect.Right := szRect.Left + round(rectf.Width);
      szRect.Bottom := szRect.Top + round(rectf.Height);
      Canvas.Brush.Style := bsClear;
      DrawText(Canvas.Handle,PChar(Caption),Length(Caption), szrect, DT_CENTER or DT_VCENTER or DT_SINGLELINE)
    end
    else
      graphics.DrawString(Caption, Length(Caption), font, rectf, stringFormat, solidBrush);

    stringformat.Free;
    font.Free;
  end;

  fontfamily.Free;

  if DropDownButton then
  begin

    if DropDownPos = dpRight then
      w := w - 8
    else
      h := h - 8;
  end;

  if Assigned(Picture) and not Picture.Empty then
  begin
     if Caption = '' then
       Canvas.Draw(r.Left + Max(0, (w - ImgW) div 2), r.Top + Max(0, (h - ImgH) div 2), Picture)
     else
       Canvas.Draw(ImgX, ImgY, Picture);
  end
  else
    if (ImageIndex <> -1) and Assigned(Images) then
    begin
      if Caption = '' then
        Images.Draw(Canvas, r.Left + Max(0, (w - Images.Width) div 2), r.Top + Max(0, (h - Images.Height) div 2), ImageIndex, EnabledImage)
      else
      begin
        Images.Draw(Canvas, ImgX, ImgY, ImageIndex, EnabledImage);
      end;
    end;

  Canvas.Brush.Style := bsClear;
  if DropDownButton then
  begin
    if DrawDwLine then
    begin
      Canvas.Pen.Color := PC;
      //Canvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, 6, 6);
      if (DropDownPos = dpRight) then
      begin
        Canvas.MoveTo(DwR.Left, DwR.Top);
        Canvas.LineTo(DwR.Left, DwR.Bottom);
      end
      else
      begin
        Canvas.MoveTo(DwR.Left, DwR.Top);
        Canvas.LineTo(DwR.Right, DwR.Top);
      end;
    end;
    AP.X := DwR.Left + ((DwR.Right - DwR.Left - 5) div 2);
    AP.Y := DwR.Top + ((DwR.Bottom - DwR.Top - 3) div 2) + 1;
    if not Enabled then
      DrawArrow(AP, clGray)
    else
      DrawArrow(AP, clBlack);
  end;

  graphics.Free;
end;


procedure DrawVistaGradient(Canvas: TCanvas; r: TRect; CFU, CTU, CFB, CTB, PC: TColor;
   GradientU,GradientB: TGDIPGradient; Caption:string; AFont: TFont; Layout: TButtonLayout; Enabled: Boolean; Focus: Boolean;
   AntiAlias: TAntiAlias; RoundEdges: Boolean; RotateLeftRight: Boolean; Direction: TTabPosition = tpTop); overload;
begin
  DrawVistaGradient(Canvas, r, CFU, CTU, CFB, CTB, PC, GradientU,GradientB, Caption, AFont,
   nil, -1, True, Layout, False, False, Enabled, Focus, dpRight, nil, AntiAlias, RoundEdges, RotateLeftRight, Direction);
end;

//------------------------------------------------------------------------------

function GetTabPath(R: TRect; Shape: TAdvTabShape; Rounding: TTabRounding; RotateLeftRight: Boolean; Direction: TTabPosition): TGPGraphicsPath;
var
  p, P2: array[0..2] of TGPPoint;
  P5, p6: array[0..3] of TGPPoint;
  tension: double;
  w, h, i, j, h3, w3, rd2: Integer;
begin
  w := r.Right - r.Left;
  h := r.Bottom - r.Top;
  //h2 := h div 2;
  h3 := h div 3;
  w3 := w div 3;
  tension := 0.8;
  i := 3;

  Result := TGPGraphicsPath.Create;
  case Shape of
    tsRectangle:
    begin
      case (Direction) of
        tpTop:
        begin
          p[0] := MakePoint(R.Left, R.Top + Rounding * i);
          p[1] := MakePoint(R.Left + Rounding, R.Top + Rounding);
          p[2] := MakePoint(R.Left + Rounding * i, R.Top);
          Result.AddLine(R.Left, R.Bottom, R.Left, P[0].Y);
          Result.AddCurve(PGPPoint(@p), 3, tension);

          p2[0] := MakePoint(R.Right - (Rounding * i), R.Top);
          p2[1] := MakePoint(R.Right - Rounding, R.Top + Rounding);
          p2[2] := MakePoint(R.Right, R.Top + (Rounding * i));
          Result.AddLine(P[2].x, R.Top, P2[0].X, R.Top);
          Result.AddCurve(PGPPoint(@p2), 3, tension);
          Result.AddLine(R.Right, P2[2].Y, R.Right, R.Bottom);
          Result.CloseFigure;
        end;
        tpBottom:
        begin
          p[0] := MakePoint(R.Left, R.Bottom - Rounding * i);
          p[1] := MakePoint(R.Left + Rounding, R.Bottom - Rounding);
          p[2] := MakePoint(R.Left + Rounding * i, R.Bottom);
          Result.AddLine(R.Left, R.Top, R.Left, P[0].Y);
          Result.AddCurve(PGPPoint(@p), 3, tension);

          p2[0] := MakePoint(R.Right - (Rounding * i), R.Bottom);
          p2[1] := MakePoint(R.Right - Rounding, R.Bottom - Rounding);
          p2[2] := MakePoint(R.Right, R.Bottom - (Rounding * i));
          Result.AddLine(P[2].x, R.Bottom, P2[0].X, R.Bottom);
          Result.AddCurve(PGPPoint(@p2), 3, tension);
          Result.AddLine(R.Right, P2[2].Y, R.Right, R.Top);
          Result.CloseFigure;
        end;
        tpLeft:
        begin
          p[0] := MakePoint(R.Left + Rounding * i, R.Top);
          p[1] := MakePoint(R.Left + Rounding, R.Top + Rounding);
          p[2] := MakePoint(R.Left, R.Top + Rounding * i);
          Result.AddLine(R.Right, R.Top, p[0].X, R.Top);
          Result.AddCurve(PGPPoint(@p), 3, tension);

          p2[0] := MakePoint(R.Left, R.Bottom - (Rounding * i));
          p2[1] := MakePoint(R.Left + Rounding, R.Bottom - Rounding);
          p2[2] := MakePoint(R.Left + (Rounding * i), R.Bottom);
          Result.AddLine(R.Left, P[2].Y, R.Left, p2[0].Y);
          Result.AddCurve(PGPPoint(@p2), 3, tension);
          Result.AddLine(p2[2].X, R.Bottom, R.Right, R.Bottom);
          Result.CloseFigure;
        end;
        tpRight:
        begin
          p[0] := MakePoint(R.Right - Rounding * i, R.Top);
          p[1] := MakePoint(R.Right - Rounding, R.Top + Rounding);
          p[2] := MakePoint(R.Right, R.Top + Rounding * i);
          Result.AddLine(R.Left, R.Top, p[0].X, R.Top);
          Result.AddCurve(PGPPoint(@p), 3, tension);

          p2[0] := MakePoint(R.Right, R.Bottom - (Rounding * i));
          p2[1] := MakePoint(R.Right - Rounding, R.Bottom - Rounding);
          p2[2] := MakePoint(R.Right - (Rounding * i), R.Bottom);
          Result.AddLine(R.Right, P[2].Y, R.Right, p2[0].Y);
          Result.AddCurve(PGPPoint(@p2), 3, tension);
          Result.AddLine(p2[2].X, R.Bottom, R.Left, R.Bottom);
          Result.CloseFigure;
        end;
      end;
    end;
    tsLeftRamp:
    begin
      case (Direction) of
        tpTop:
        begin
          j := h3 + Rounding;

          p5[0] := MakePoint(R.Left, R.Bottom);
          p5[1] := MakePoint(R.Left + Rounding*i, R.Bottom - Rounding{* 2});
          p5[2] := MakePoint(R.Left - Rounding + j, R.Top + Rounding);
          p5[3] := MakePoint(R.Left + (Rounding * 2) + j, R.Top);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);

          rd2 := Max(0, Rounding div 2);
          
          p2[0] := MakePoint(R.Right - (rd2 * i), R.Top);
          p2[1] := MakePoint(R.Right - rd2, R.Top + rd2);
          p2[2] := MakePoint(R.Right, R.Top + (rd2 * i));
          Result.AddLine(P5[3].x, R.Top, P2[0].X, R.Top);
          Result.AddCurve(PGPPoint(@p2), 3, tension);
          Result.AddLine(R.Right, p2[2].Y, R.Right, R.Bottom);

          //Result.AddLine(R.Right, R.Bottom, R.Left, R.Bottom);
          Result.CloseFigure;
        end;
        tpBottom:
        begin
          j := h3 + Rounding;

          p5[0] := MakePoint(R.Left + (Rounding * 2) + j, R.Bottom);
          p5[1] := MakePoint(R.Left - Rounding + j, R.Bottom - Rounding);
          p5[2] := MakePoint(R.Left + Rounding*i, R.Top + Rounding{* 2});
          p5[3] := MakePoint(R.Left, R.Top);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);

          rd2 := Max(0, Rounding div 2);

          p2[0] := MakePoint(R.Right, R.Bottom - (rd2 * i));
          p2[1] := MakePoint(R.Right - rd2, R.Bottom - rd2);
          p2[2] := MakePoint(R.Right - (rd2 * i), R.Bottom);

          Result.AddLine(R.Left, R.top, R.Right, R.Top);
          Result.AddLine(R.Right, R.Top, R.Right, p2[0].Y);
          Result.AddCurve(PGPPoint(@p2), 3, tension);
          //Result.AddLine(P2[2].X, R.Bottom, P5[0].x, R.Bottom);
          Result.CloseFigure;
        end;
        tpLeft:
        begin
          j := w3 + Rounding;
          if not RotateLeftRight then
            j := h3 + Rounding;
          rd2 := Max(0, Rounding div 2);

          p[0] := MakePoint(R.Left + Rd2 * i, R.Top);
          p[1] := MakePoint(R.Left + Rd2, R.Top + Rd2);
          p[2] := MakePoint(R.Left, R.Top + Rd2 * i);
          Result.AddLine(R.Right, R.Top, p[0].X, R.Top);
          Result.AddCurve(PGPPoint(@p), 3, tension);

          p5[0] := MakePoint(R.Left, R.Bottom - (Rounding * 2) - j);
          p5[1] := MakePoint(R.Left + Rounding, R.Bottom + Rounding - j);
          p5[2] := MakePoint(R.Right - Rounding{* 2}, R.Bottom - Rounding * i);
          p5[3] := MakePoint(R.Right, R.Bottom);
          Result.AddLine(R.Left, P[2].Y, R.Left, P5[0].Y);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);
          //Result.AddLine(R.Right, R.Bottom, R.Right, R.Top);
          Result.CloseFigure;
        end;
        tpRight:
        begin
          j := w3 + Rounding;
          if not RotateLeftRight then
            j := h3 + Rounding;

          p5[0] := MakePoint(R.Left, R.Top);
          p5[1] := MakePoint(R.Left + Rounding{* 2}, R.Top + Rounding*i);
          p5[2] := MakePoint(R.Right - Rounding, R.Top - Rounding + j);
          p5[3] := MakePoint(R.Right, R.Top + (Rounding * 2) + j);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);

          rd2 := Max(0, Rounding div 2);
          p2[0] := MakePoint(R.Right, R.Bottom - (Rd2 * i));
          p2[1] := MakePoint(R.Right - Rd2, R.Bottom - Rd2);
          p2[2] := MakePoint(R.Right - (Rd2 * i), R.Bottom);

          Result.AddLine(R.Right, P5[3].Y, R.Right, p2[0].Y);
          Result.AddCurve(PGPPoint(@p2), 3, tension);

          Result.AddLine(p2[2].X, R.Bottom, R.Left, R.Bottom);
          //Result.AddLine(R.Right, R.Bottom, R.Right, Top);
          Result.CloseFigure;
        end;
      end;
    end;
    tsRightRamp:
    begin
      case (Direction) of
        tpTop:
        begin
          //k := 0;
          //if (Rounding * i > h2) then
          //  k := i div 2;

          j := h3 + Rounding;
          //k := (j div 2);

          rd2 := Max(0, Rounding div 2);

          p[0] := MakePoint(R.Left, R.Top + rd2 * i);
          p[1] := MakePoint(R.Left + rd2, R.Top + rd2);
          p[2] := MakePoint(R.Left + rd2 * i, R.Top);

          Result.AddLine(R.Left, R.Bottom, R.Left, P[0].Y);
          Result.AddCurve(PGPPoint(@p), 3, tension);

          p5[0] := MakePoint(R.Right - (Rounding * 2) - j, R.Top);
          p5[1] := MakePoint(R.Right + Rounding - j, R.Top + Rounding);
          p5[2] := MakePoint(R.Right - Rounding*i, R.Bottom - Rounding{* 2});
          p5[3] := MakePoint(R.Right, R.Bottom);
          Result.AddLine(P[2].x, R.Top, P5[0].X, R.Top);
          //Result.AddCurve(PGPPoint(@p5), 4, tension);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);

          Result.AddLine(R.Left, R.Bottom, R.Right, R.Bottom);
          Result.CloseFigure;
        end;
        tpBottom:
        begin
          j := h3 + Rounding;
          rd2 := Max(0, Rounding div 2);

          p[0] := MakePoint(R.Left, R.Bottom - rd2 * i);
          p[1] := MakePoint(R.Left + Rd2, R.Bottom - Rd2);
          p[2] := MakePoint(R.Left + Rd2 * i, R.Bottom);
          Result.AddLine(R.Left, R.Top, R.Left, P[0].Y);
          Result.AddCurve(PGPPoint(@p), 3, tension);

          p5[0] := MakePoint(R.Right - (Rounding * 2) - j, R.Bottom);
          p5[1] := MakePoint(R.Right + Rounding - j, R.Bottom - Rounding);
          p5[2] := MakePoint(R.Right - Rounding*i, R.Top + Rounding{* 2});
          p5[3] := MakePoint(R.Right, R.Top);
          Result.AddLine(P[2].x, R.Bottom, P5[0].X, R.Bottom);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);

          Result.AddLine(R.Left, R.Top, R.Right, R.Top);
          Result.CloseFigure;
        end;
        tpLeft:
        begin
          j := w3 + Rounding;
          if not RotateLeftRight then
            j := h3 + Rounding;
          rd2 := Max(0, Rounding div 2);

          p5[0] := MakePoint(R.Right, R.Top);
          p5[1] := MakePoint(R.Right - Rounding{* 2}, R.Top + Rounding*i);
          p5[2] := MakePoint(R.Left + Rounding, R.Top - Rounding + j);
          p5[3] := MakePoint(R.Left, R.Top + (Rounding * 2) + j);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);

          p2[0] := MakePoint(R.Left, R.Bottom - (Rd2 * i));
          p2[1] := MakePoint(R.Left + Rd2, R.Bottom - Rd2);
          p2[2] := MakePoint(R.Left + (Rd2 * i), R.Bottom);

          Result.AddLine(R.Left, P5[3].Y, R.Left, p2[0].Y);
          Result.AddCurve(PGPPoint(@p2), 3, tension);

          Result.AddLine(p2[2].X, R.Bottom, R.Right, R.Bottom);
          //Result.AddLine(R.Right, R.Bottom, R.Right, Top);
          Result.CloseFigure;
        end;
        tpRight:
        begin
          j := w3 + Rounding;
          if not RotateLeftRight then
            j := h3 + Rounding;
          rd2 := Max(0, Rounding div 2);

          p[0] := MakePoint(R.Right - Rd2 * i, R.Top);
          p[1] := MakePoint(R.Right - Rd2, R.Top + Rd2);
          p[2] := MakePoint(R.Right, R.Top + Rd2 * i);
          Result.AddLine(R.Left, R.Top, p[0].X, R.Top);
          Result.AddCurve(PGPPoint(@p), 3, tension);

          p5[0] := MakePoint(R.Right, R.Bottom - (Rounding * 2) - j);
          p5[1] := MakePoint(R.Right - Rounding, R.Bottom + Rounding - j);
          p5[2] := MakePoint(R.Left + Rounding{* 2}, R.Bottom - Rounding * i);
          p5[3] := MakePoint(R.Left, R.Bottom);
          Result.AddLine(R.Right, P[2].Y, R.Right, P5[0].Y);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);
          //Result.AddLine(R.Right, R.Bottom, R.Right, R.Top);
          Result.CloseFigure;
        end;
      end;
    end;
    tsLeftRightRamp:
    begin
      case (Direction) of
        tpTop:
        begin
          j := h3 + Rounding;

          p5[0] := MakePoint(R.Left, R.Bottom);
          p5[1] := MakePoint(R.Left + Rounding*i, R.Bottom - Rounding{* 2});
          p5[2] := MakePoint(R.Left - Rounding + j, R.Top + Rounding);
          p5[3] := MakePoint(R.Left + (Rounding * 2) + j, R.Top);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);

          p6[0] := MakePoint(R.Right - (Rounding * 2) - j, R.Top);
          p6[1] := MakePoint(R.Right + Rounding - j, R.Top + Rounding);
          p6[2] := MakePoint(R.Right - Rounding*i, R.Bottom - Rounding{* 2});
          p6[3] := MakePoint(R.Right, R.Bottom);

          Result.AddLine(p5[3].X, R.Top, p6[0].X, R.Top);
          Result.AddBezier(P6[0],P6[1], P6[2], P6[3]);
          
          //Result.AddLine(R.Right, R.Bottom, R.Left, R.Bottom);
          Result.CloseFigure;
        end;
        tpBottom:
        begin
          j := h3 + Rounding;

          p5[0] := MakePoint(R.Left + (Rounding * 2) + j, R.Bottom);
          p5[1] := MakePoint(R.Left - Rounding + j, R.Bottom - Rounding);
          p5[2] := MakePoint(R.Left + Rounding*i, R.Top + Rounding{* 2});
          p5[3] := MakePoint(R.Left, R.Top);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);

          p6[0] := MakePoint(R.Right, R.Top);
          p6[1] := MakePoint(R.Right - Rounding*i, R.Top + Rounding{* 2});
          p6[2] := MakePoint(R.Right + Rounding - j, R.Bottom - Rounding);
          p6[3] := MakePoint(R.Right - (Rounding * 2) - j, R.Bottom);

          Result.AddLine(R.Left, R.top, R.Right, R.Top);
          Result.AddBezier(P6[0],P6[1], P6[2], P6[3]);
          Result.AddLine(P6[3].x, R.Bottom, P5[0].X, R.Bottom);

          Result.CloseFigure;
        end;
        tpLeft:
        begin
          j := w3 + Rounding;
          if not RotateLeftRight then
            j := h3 + Rounding;

          p5[0] := MakePoint(R.Right, R.Top);
          p5[1] := MakePoint(R.Right - Rounding{* 2}, R.Top + Rounding*i);
          p5[2] := MakePoint(R.Left + Rounding, R.Top - Rounding + j);
          p5[3] := MakePoint(R.Left, R.Top + (Rounding * 2) + j);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);

          p6[0] := MakePoint(R.Left, R.Bottom - (Rounding * 2) - j);
          p6[1] := MakePoint(R.Left + Rounding, R.Bottom + Rounding - j);
          p6[2] := MakePoint(R.Right - Rounding{* 2}, R.Bottom - Rounding * i);
          p6[3] := MakePoint(R.Right, R.Bottom);
          Result.AddLine(R.Left, P5[3].Y, R.Left, P6[0].Y);
          Result.AddBezier(P6[0],P6[1], P6[2], P6[3]);
          //Result.AddLine(R.Right, R.Bottom, R.Right, R.Top);
          Result.CloseFigure;
        end;
        tpRight:
        begin
          j := w3 + Rounding;
          if not RotateLeftRight then
            j := h3 + Rounding;

          p5[0] := MakePoint(R.Left, R.Top);
          p5[1] := MakePoint(R.Left + Rounding{* 2}, R.Top + Rounding*i);
          p5[2] := MakePoint(R.Right - Rounding, R.Top - Rounding + j);
          p5[3] := MakePoint(R.Right, R.Top + (Rounding * 2) + j);
          Result.AddBezier(P5[0],P5[1], P5[2], P5[3]);

          p6[0] := MakePoint(R.Right, R.Bottom - (Rounding * 2) - j);
          p6[1] := MakePoint(R.Right - Rounding, R.Bottom + Rounding - j);
          p6[2] := MakePoint(R.Left + Rounding{* 2}, R.Bottom - Rounding * i);
          p6[3] := MakePoint(R.Left, R.Bottom);
          Result.AddLine(R.Right, P5[3].Y, R.Right, P6[0].Y);
          Result.AddBezier(P6[0],P6[1], P6[2], P6[3]);

          //Result.AddLine(R.Right, R.Bottom, R.Right, R.Top);
          Result.CloseFigure;
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure DrawVistaTab(Canvas: TCanvas; r: TRect; CFU, CTU, CFB, CTB, PC: TColor; GradientU,GradientB: TGDIPGradient;
   Enabled: Boolean; Shape: TAdvTabShape; Focus: Boolean; {AntiAlias: TAntiAlias; }Rounding: TTabRounding; RotateLeftRight: Boolean; Direction: TTabPosition);
var
  graphics : TGPGraphics;
  TabPath, path: TGPGraphicsPath;
  pthGrBrush: TGPPathGradientBrush;
  solGrBrush: TGPSolidBrush;
  linGrBrush: TGPLinearGradientBrush;
  gppen : tgppen;
  count: Integer;
  w,h,h2,w2: Integer;
  colors : array[0..0] of TGPColor;
  BtnR: TRect;
  Rgn: TGPRegion;
begin
  BtnR := R;

  w := r.Right - r.Left;
  h := r.Bottom - r.Top;

  h2 := h div 2;
  w2 := w div 2;


  graphics := TGPGraphics.Create(Canvas.Handle);
  Tabpath := GetTabPath(R, Shape, Rounding, RotateLeftRight, Direction);

  if (Direction in [tpLeft, tpRight]) and not RotateLeftRight then
  begin
    Direction := tpTop;
    RotateLeftRight := False;
  end;

  Rgn := TGPRegion.Create(TabPath);
  graphics.SetClip(Rgn);

  case (Direction) of
    tpTop:
    begin
      // down ellips brush

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfb));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.top +  h2, w, h2));
      solGrBrush.Free;


      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Left, r.Top +  h2, w , h);

      pthGrBrush := nil;
      linGrBrush := nil;

      case GradientB of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2,w,h2),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeVertical);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2,w,h2),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2,w,h2),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeBackwardDiagonal);
      end;

      if GradientB = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left + w2, r.Bottom));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTB));

        colors[0] := ColorToARGB(CFB);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);
        graphics.FillRectangle(pthGrBrush, r.Left + 1,r.Top + h2, w - 1, h2+1);
        pthGrBrush.Free;
      end
      else
      begin
        if not RotateLeftRight then
          graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + h2 + 1, w - 1, h2 - 1)
        else
          graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + h2 + 1, w - 1, h2 + 1);
        linGrBrush.Free;
      end;

      path.Free;

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfu));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.Top , w , h2));
      solGrBrush.Free;

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Left, r.Top - h2 , w , h);

      case GradientU of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);                      // FF: Gradient fix here replace h by h2
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h2+1),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeVertical);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeBackwardDiagonal);
      end;

      if GradientU = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left + w2, r.top));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTU));

        colors[0] := ColorToARGB(CFU);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);

        graphics.FillRectangle(pthGrBrush, r.Left + 1,r.Top + 1, w - 1, h - h2 - 1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + 1, w - 1, h2);
        linGrBrush.Free;
      end;

      path.Free;

    end;
    tpBottom:
    begin
      // down ellips brush

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfb));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.top, w , h2));
      solGrBrush.Free;

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      //  path.AddRectangle(MakeRect(r.Left, r.Top +  (h div 2), w , h));
      path.AddEllipse(r.Left, r.Top, w , h2);

      pthGrBrush := nil;
      linGrBrush := nil;

      case GradientB of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h2),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeVertical);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h2),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h2),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeBackwardDiagonal);
      end;

      if GradientB = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left + w2, r.Top));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTB));

        colors[0] := ColorToARGB(CFB);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);
        graphics.FillRectangle(pthGrBrush, r.Left + 1,r.Top, w - 1, h2+1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + 1, w - 1, h2 + 1);
        linGrBrush.Free;
      end;

      path.Free;

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfu));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.top +  h2, w , h2));
      solGrBrush.Free;

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Left, r.Bottom - h2 , w , h);

      case GradientU of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);                      // FF: Gradient fix here replace h by h2
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2-1,w,h2),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeVertical);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2,w,h),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top + h2,w,h),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeBackwardDiagonal);
      end;

      if GradientU = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left + w2, r.Bottom));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTU));

        colors[0] := ColorToARGB(CFU);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);

        graphics.FillRectangle(pthGrBrush, r.Left + 1,r.Top + h2 + 1, w - 1, h2 - 1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + h2, w - 1, h2 - 1);
        linGrBrush.Free;
      end;

      path.Free;
    end;
    tpLeft:
    begin
      // down ellips brush

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfb));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left + w2, r.top, w2 , h));
      solGrBrush.Free;

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Left + w2, r.Top, w , h);

      pthGrBrush := nil;
      linGrBrush := nil;

      case GradientB of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left + w2,r.Top,w2,h),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeHorizontal);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left + w2,r.Top,w2,h),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left + w2,r.Top,w2,h),ColorToARGB(CFB),ColorToARGB(CTB), LinearGradientModeBackwardDiagonal);
      end;

      if GradientB = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Right, r.Top + h2));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTB));

        colors[0] := ColorToARGB(CFB);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);
        graphics.FillRectangle(pthGrBrush, r.Left + w2, r.Top, w2 + 1, h-1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left + w2 + 1,r.Top, w2 + 1, h - 1);
        linGrBrush.Free;
      end;

      path.Free;

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfu));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.Top , w2 , h));
      solGrBrush.Free;

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Left - w2, r.Top, w , h);

      case GradientU of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);                      // FF: Gradient fix here replace h by h2
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w2,h),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeHorizontal);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w,h),ColorToARGB(CFU),ColorToARGB(CTU), LinearGradientModeBackwardDiagonal);
      end;

      if GradientU = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left, r.top + h2));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTU));

        colors[0] := ColorToARGB(CFU);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);

        graphics.FillRectangle(pthGrBrush, r.Left + 1,r.Top + 1, w2 - 1, h - 1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left + 1,r.Top + 1, w2 - 1, h - 1);
        linGrBrush.Free;
      end;

      path.Free;

    end;
    tpRight:
    begin

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfu));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Right - w2 , r.Top , w2, h));
      solGrBrush.Free;

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Right - w2, r.Top, w, h);

      pthGrBrush := nil;
      linGrBrush := nil;

      case GradientU of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);                      // FF: Gradient fix here replace h by h2
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Right-w2,r.Top,w2,h),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeHorizontal);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Right-w2,r.Top,w,h),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Right-w2,r.Top,w,h),ColorToARGB(CTU),ColorToARGB(CFU), LinearGradientModeBackwardDiagonal);
      end;

      if GradientU = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Right, r.top + h2));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTU));

        colors[0] := ColorToARGB(CFU);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);

        graphics.FillRectangle(pthGrBrush, r.Right - w2 + 1,r.Top + 1, w2 - 1, h - 1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Right - w2, r.Top + 1, w2, h - 1);
        linGrBrush.Free;
      end;

      path.Free;

      // down ellips brush

      solGrBrush := TGPSolidBrush.Create(ColorToARGB(cfb));
      graphics.FillRectangle(solGrBrush, MakeRect(r.Left , r.top, w2, h));
      solGrBrush.Free;

      // Create a path that consists of a single ellipse.
      path := TGPGraphicsPath.Create;
      path.AddEllipse(r.Left - w2, r.Top, w , h);

      pthGrBrush := nil;
      linGrBrush := nil;

      case GradientB of
      ggRadial: pthGrBrush := TGPPathGradientBrush.Create(path);
      ggVertical: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w2+2,h),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeHorizontal);
      ggDiagonalForward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w2,h),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeForwardDiagonal);
      ggDiagonalBackward: linGrBrush := TGPLinearGradientBrush.Create(MakeRect(r.Left,r.Top,w2,h),ColorToARGB(CTB),ColorToARGB(CFB), LinearGradientModeBackwardDiagonal);
      end;

      if GradientB = ggRadial then
      begin
        pthGrBrush.SetCenterPoint(MakePoint(r.Left, r.Top + h2));

        // Set the color at the center point to blue.
        pthGrBrush.SetCenterColor(ColorToARGB(CTB));

        colors[0] := ColorToARGB(CFB);
        count := 1;
        pthGrBrush.SetSurroundColors(@colors, count);
        graphics.FillRectangle(pthGrBrush, r.Left,r.Top, w2 + 1, h-1);
        pthGrBrush.Free;
      end
      else
      begin
        graphics.FillRectangle(linGrBrush, r.Left,r.Top, w2 + 2, h - 1);
        linGrBrush.Free;
      end;

      path.Free;

    end;
  end;

  graphics.SetSmoothingMode(SmoothingModeAntiAlias);

  if (PC <> clNone) then
  begin
    graphics.ResetClip;
    gppen := TGPPen.Create(ColorToARGB(PC), 1.6);
    graphics.DrawPath(gpPen, TabPath);
    gppen.Free;
  end;

  if Focus then
  begin
    gppen := tgppen.Create(ColorToARGB($E4AD89),1);
    graphics.SetSmoothingMode(SmoothingModeAntiAlias);
    DrawRoundRect(graphics, gppen,r.Left + 1,r.Top + 1, r.Right - 3, r.Bottom - 3, 3);
    gppen.Free;
    gppen := tgppen.Create(ColorToARGB(clgray),1);
    gppen.SetDashStyle(DashStyleDot);
    graphics.SetSmoothingMode(SmoothingModeAntiAlias);
    DrawRoundRect(graphics, gppen,r.Left + 2,r.Top + 2, r.Right - 5, r.Bottom - 5, 3);
    gppen.Free;
  end;

  if Assigned(Rgn) then
    Rgn.Free;
  TabPath.Free;
  graphics.Free;
end;

//------------------------------------------------------------------------------

{ TPagerTabSettings }

constructor TPagerTabSettings.Create;
begin
  inherited;
  FLeftMargin := 4;
  FRightMargin := 4;
  FHeight := DEFAULT_TABHEIGHT;
  FStartMargin := 4;
  FEndMargin := 0;
  FSpacing := 4;
  FWidth := 0;
  FWordWrap := False;
  FImagePosition := ipLeft;
  FShape := tsRectangle;
  FRounding := 1;
  FAlignment := taLeftJustify;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.Assign(Source: TPersistent);
begin
  if (Source is TPagerTabSettings) then
  begin
    LeftMargin := (Source as TPagerTabSettings).LeftMargin;
    RightMargin := (Source as TPagerTabSettings).RightMargin;
    Height := (Source as TPagerTabSettings).Height;
    StartMargin := (Source as TPagerTabSettings).StartMargin;
    EndMargin := (Source as TPagerTabSettings).EndMargin;
    Width := (Source as TPagerTabSettings).Width;
    WordWrap := (Source as TPagerTabSettings).WordWrap;
    ImagePosition := (Source as TPagerTabSettings).ImagePosition;
    Shape := (Source as TPagerTabSettings).Shape;
    Rounding := (Source as TPagerTabSettings).Rounding;
    Alignment := (Source as TPagerTabSettings).Alignment;
  end
  else
    inherited;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetLeftMargin(const Value: Integer);
begin
  if (FLeftMargin <> Value) then
  begin
    FLeftMargin := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetRightMargin(const Value: Integer);
begin
  if (FRightMargin <> Value) then
  begin
    FRightMargin := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetHeight(const Value: Integer);
begin
  if (FHeight <> Value) then
  begin
    FHeight := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetStartMargin(const Value: Integer);
begin
  if (FStartMargin <> Value) then
  begin
    FStartMargin := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetEndMargin(const Value: Integer);
begin
  if (FEndMargin <> Value) then
  begin
    FEndMargin := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetSpacing(const Value: Integer);
begin
  if (FSpacing <> Value) then
  begin
    FSpacing := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetWidth(const Value: Integer);
begin
  if (FWidth <> Value) then
  begin
    FWidth := Value;
    changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetWordWrap(const Value: Boolean);
begin
  if (FWordWrap <> Value) then
  begin
    FWordWrap := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetImagePosition(const Value: TImagePosition);
begin
  if (FImagePosition <> Value) then
  begin
    FImagePosition := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetRounding(const Value: TTabRounding);
begin
  if (FRounding <> Value) then
  begin
    FRounding := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetShape(const Value: TAdvTabShape);
begin
  if (FShape <> Value) then
  begin
    FShape := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPagerTabSettings.SetAlignment(const Value: TAlignment);
begin
  if (FAlignment <> Value) then
  begin
    FAlignment := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

{ TPagerTabScroller }

constructor TPagerTabScroller.Create;
begin
  inherited;
  FMin := 0;
  FMax := 0;
  FPosition := 0;
  FVisible := False;
end;

//------------------------------------------------------------------------------

function TPagerTabScroller.CanGoBack: Boolean;
begin
  Result := Position > Min;
end;

//------------------------------------------------------------------------------

function TPagerTabScroller.CanGoForward: Boolean;
begin
  Result := Position < Max;
end;

//------------------------------------------------------------------------------

procedure TPagerTabScroller.SetMax(const Value: integer);
begin
  if Value >= FMin then FMax := Value;
end;

//------------------------------------------------------------------------------

procedure TPagerTabScroller.SetMin(const Value: integer);
begin
  if Value <= FMax then FMin := Value;
end;

//------------------------------------------------------------------------------

procedure TPagerTabScroller.SetPosition(const Value: integer);
begin
  FPosition := Value;
end;

//------------------------------------------------------------------------------

procedure TPagerTabScroller.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

//------------------------------------------------------------------------------

{ TGradientBackground }

procedure TGradientBackground.Assign(Source: TPersistent);
begin
  if (Source is TGradientBackground) then
  begin
    FColor := (Source as TGradientBackground).Color;
    FColorTo := (Source as TGradientBackground).ColorTo;
    FDirection := (Source as TGradientBackground).Direction;
    FSteps := (Source as TGradientBackground).Steps;
  end;
end;

//------------------------------------------------------------------------------

procedure TGradientBackground.Changed;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

//------------------------------------------------------------------------------

constructor TGradientBackground.Create;
begin
  inherited;
  Color := clWhite;
  ColorTo := clBtnFace;
  Steps := 64;
  Direction := gdHorizontal;
end;

//------------------------------------------------------------------------------

procedure TGradientBackground.SetColor(const Value: TColor);
begin
  FColor := Value;
  Changed;
end;

//------------------------------------------------------------------------------

procedure TGradientBackground.SetColorTo(const Value: TColor);
begin
  FColorTo := Value;
  Changed;
end;

//------------------------------------------------------------------------------

procedure TGradientBackground.SetDirection(
  const Value: TGradientDirection);
begin
  FDirection := Value;
  Changed;
end;

//------------------------------------------------------------------------------

procedure TGradientBackground.SetSteps(const Value: Integer);
begin
  FSteps := Value;
  Changed;
end;


//------------------------------------------------------------------------------

{ TVistaBackground }

constructor TVistaBackground.Create;
begin
  inherited;
  FSteps := 64;
  FColor := clWhite;
  FColorTo := clWhite;
  FColorMirror := clSilver;
  FColorMirrorTo := clWhite;
  FBorderColor := clGray;
  FGradient := ggVertical;
  FGradientMirror := ggVertical;
end;

//------------------------------------------------------------------------------

procedure TVistaBackground.Assign(Source: TPersistent);
begin
  if (Source is TVistaBackground) then
  begin
    FSteps := (Source as TVistaBackground).Steps;
    FColor := (Source as TVistaBackground).Color;
    FColorTo := (Source as TVistaBackground).ColorTo;
    FColorMirror := (Source as TVistaBackground).ColorMirror;
    FColorMirrorTo := (Source as TVistaBackground).ColorMirrorTo;
    FBorderColor := (Source as TVistaBackground).BorderColor;
    Gradient := (Source as TVistaBackground).Gradient;
    GradientMirror := (Source as TVistaBackground).GradientMirror;
  end
  else
    inherited Assign(Source);
end;

//------------------------------------------------------------------------------

procedure TVistaBackground.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

//------------------------------------------------------------------------------

procedure TVistaBackground.SetColor(const Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TVistaBackground.SetColorTo(const Value: TColor);
begin
  if (FColorTo  <> Value) then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TVistaBackground.SetBorderColor(const Value: TColor);
begin
  if (FBorderColor <> Value) then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TVistaBackground.SetColorMirror(const Value: TColor);
begin
  if (FColorMirror <> Value) then
  begin
    FColorMirror := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TVistaBackground.SetColorMirrorTo(const Value: TColor);
begin
  if (FColorMirrorTo <> Value) then
  begin
    FColorMirrorTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TVistaBackground.SetGradient(const Value: TGDIPGradient);
begin
  if (FGradient <> Value) then
  begin
    FGradient := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TVistaBackground.SetGradientMirror(const Value: TGDIPGradient);
begin
  if(FGradientMirror <> Value) then
  begin
    FGradientMirror := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TVistaBackground.SetSteps(const Value: Integer);
begin
  if (FSteps <> Value) then
  begin
    FSteps := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

{ TCustomTabAppearance }

constructor TCustomTabAppearance.Create;
begin
  inherited;
  FBorderColor := clBtnFace;
  FBorderColorHot := clBlue;
  FBorderColorSelectedHot := clNone;
  FBorderColorDown := clNone;
  FColor := clBtnFace;
  FColorTo := clWhite;
  FColorHot := clYellow;
  FColorHotTo := clNone;
  FColorSelectedTo := clBtnFace;
  FBorderColorDisabled := clNone;
  FBorderColorSelected := clBtnFace;
  FColorDisabled := clNone;
  FColorDisabledTo := clNone;
  FColorSelected := clWhite;
  FColorMirror := clWhite;
  FColorMirrorTo := clWhite;
  FColorMirrorHot := clNone;
  FColorMirrorHotTo := clNone;
  FGradientMirror := ggVertical;
  FGradientMirrorHot := ggVertical;
  FGradient := ggVertical;
  FGradientHot := ggVertical;
  FColorMirrorDisabledTo := clNone;
  FColorMirrorDisabled := clNone;
  FColorMirrorSelectedTo := clWhite;
  FColorMirrorSelected := clWhite;
  FGradientSelected := ggVertical;
  FGradientDisabled := ggVertical;
  FGradientMirrorSelected := ggVertical;
  FGradientMirrorDisabled := ggVertical;
  FTextColorDisabled := clWhite;
  FTextColorSelected := clBlue;
  FTextColor := clBlue;
  FTextColorHot := clBlue;
  FBackGround := TGradientBackground.Create;
  FBackGround.OnChange := OnBackGroundChanged;
  FFont := TFont.Create;
  FFont.Name := 'Tahoma';
  FFont.Size := 8;
  FFont.Style := [];
  FFont.OnChange := OnFontChanged;
  FShadowColor := RGB(174, 199, 232);
  FHighLightColor := RGB(191, 250, 255);
  FHighLightColorSelected := RGB(248, 204, 99);
  FHighLightColorSelectedHot := RGB(255, 255, 189);
  FHighLightColorDown := RGB(208, 251, 255);
  FHighLightColorHot := RGB(237, 244, 253);
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.Assign(Source: TPersistent);
begin
  if (Source is TCustomTabAppearance) then
  begin
    FBorderColor := (Source as TCustomTabAppearance).BorderColor;
    FBorderColorHot := (Source as TCustomTabAppearance).BorderColorHot;
    FBorderColorSelectedHot := (Source as TCustomTabAppearance).BorderColorSelectedHot;
    FBorderColorDown := (Source as TCustomTabAppearance).BorderColorDown;
    FColor := (Source as TCustomTabAppearance).Color;
    FColorTo := (Source as TCustomTabAppearance).ColorTo;
    FColorHot := (Source as TCustomTabAppearance).ColorHot;
    FColorHotTo := (Source as TCustomTabAppearance).ColorHotTo;
    FColorSelectedTo := (Source as TCustomTabAppearance).ColorSelectedTo;
    FBorderColorDisabled := (Source as TCustomTabAppearance).BorderColorDisabled;
    FBorderColorSelected := (Source as TCustomTabAppearance).BorderColorSelected;
    FColorDisabled := (Source as TCustomTabAppearance).ColorDisabled;
    FColorDisabledTo := (Source as TCustomTabAppearance).ColorDisabledTo;
    FColorSelected := (Source as TCustomTabAppearance).ColorSelected;
    FColorMirror := (Source as TCustomTabAppearance).ColorMirror;
    FColorMirrorTo := (Source as TCustomTabAppearance).ColorMirrorTo;
    FColorMirrorHot := (Source as TCustomTabAppearance).ColorMirrorHot;
    FColorMirrorHotTo := (Source as TCustomTabAppearance).ColorMirrorHotTo;
    FGradientMirror := (Source as TCustomTabAppearance).GradientMirror;
    FGradientMirrorHot := (Source as TCustomTabAppearance).GradientMirrorHot;
    FGradient := (Source as TCustomTabAppearance).Gradient;
    FGradientHot := (Source as TCustomTabAppearance).GradientHot;
    FColorMirrorDisabledTo := (Source as TCustomTabAppearance).ColorMirrorDisabledTo;
    FColorMirrorDisabled := (Source as TCustomTabAppearance).ColorMirrorDisabled;
    FColorMirrorSelectedTo := (Source as TCustomTabAppearance).ColorMirrorSelectedTo;
    FColorMirrorSelected := (Source as TCustomTabAppearance).ColorMirrorSelected;
    FGradientSelected := (Source as TCustomTabAppearance).GradientSelected;
    FGradientDisabled := (Source as TCustomTabAppearance).GradientDisabled;
    FGradientMirrorSelected := (Source as TCustomTabAppearance).GradientMirrorSelected;
    FGradientMirrorDisabled := (Source as TCustomTabAppearance).GradientMirrorDisabled;
    FTextColorDisabled := (Source as TCustomTabAppearance).TextColorDisabled;
    FTextColorSelected := (Source as TCustomTabAppearance).TextColorSelected;
    Font.Assign((Source as TCustomTabAppearance).Font);
    TextColor := (Source as TCustomTabAppearance).TextColor;
    TextColorHot := (Source as TCustomTabAppearance).TextColorHot;
    FShadowColor := (Source as TCustomTabAppearance).ShadowColor;
    FHighLightColor := (Source as TCustomTabAppearance).HighLightColor;
    FHighLightColorHot := (Source as TCustomTabAppearance).HighLightColorHot;
    FHighLightColorDown := (Source as TCustomTabAppearance).HighLightColorDown;
    FHighLightColorSelected := (Source as TCustomTabAppearance).HighLightColorSelected;
    FHighLightColorSelectedHot := (Source as TCustomTabAppearance).HighLightColorSelectedHot;
    BackGround.Assign((Source as TCustomTabAppearance).BackGround);
  end
  else
    inherited Assign(Source);
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

//------------------------------------------------------------------------------

destructor TCustomTabAppearance.Destroy;
begin
  FBackGround.Free;
  FFont.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetBackGround(const Value: TGradientBackground);
begin
  FBackGround.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetBorderColor(const Value: TColor);
begin
  if (FBorderColor <> Value) then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetBorderColorDisabled(const Value: TColor);
begin
  if (FBorderColorDisabled <> Value) then
  begin
    FBorderColorDisabled := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetBorderColorSelected(const Value: TColor);
begin
  if (FBorderColorSelected <> Value) then
  begin
    FBorderColorSelected := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetBorderColorSelectedHot(
  const Value: TColor);
begin
  if (FBorderColorSelectedHot <> Value) then
  begin
    FBorderColorSelectedHot := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColor(const Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorDisabled(const Value: TColor);
begin
  if (FColorDisabled <> Value) then
  begin
    FColorDisabled := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorDisabledTo(const Value: TColor);
begin
  if (FColorDisabledTo <> Value) then
  begin
    FColorDisabledTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorHot(const Value: TColor);
begin
  if (FColorHot <> Value) then
  begin
    FColorHot := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorHotTo(const Value: TColor);
begin
  if (FColorHotTo <> Value) then
  begin
    FColorHotTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorMirror(const Value: TColor);
begin
  if (FColorMirror <> Value) then
  begin
    FColorMirror := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorMirrorDisabled(const Value: TColor);
begin
  if (FColorMirrorDisabled <> Value) then
  begin
    FColorMirrorDisabled := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorMirrorDisabledTo(
  const Value: TColor);
begin
  if (FColorMirrorDisabledTo <> Value) then
  begin
    FColorMirrorDisabledTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorMirrorHot(const Value: TColor);
begin
  if (FColorMirrorHot <> Value) then
  begin
    FColorMirrorHot := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorMirrorHotTo(const Value: TColor);
begin
  if (FColorMirrorHotTo <> Value) then
  begin
    FColorMirrorHotTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorMirrorSelected(const Value: TColor);
begin
  if (FColorMirrorSelected <> Value) then
  begin
    FColorMirrorSelected := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorMirrorSelectedTo(
  const Value: TColor);
begin
  if (FColorMirrorSelectedTo <> Value) then
  begin
    FColorMirrorSelectedTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorMirrorTo(const Value: TColor);
begin
  if (FColorMirrorTo <> Value) then
  begin
    FColorMirrorTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorSelected(const Value: TColor);
begin
  if (FColorSelected <> Value) then
  begin
    FColorSelected := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorSelectedTo(const Value: TColor);
begin
  if (FColorSelectedTo <> Value) then
  begin
    FColorSelectedTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetColorTo(const Value: TColor);
begin
  if (FColorTo <> Value) then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetGradient(const Value: TGDIPGradient);
begin
  if (FGradient <> Value) then
  begin
    FGradient := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetGradientDisabled(
  const Value: TGDIPGradient);
begin
  if (FGradientDisabled <> Value) then
  begin
    FGradientDisabled := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetGradientHot(const Value: TGDIPGradient);
begin
  if (FGradientHot <> Value) then
  begin
    FGradientHot := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetGradientMirror(
  const Value: TGDIPGradient);
begin
  if (FGradientMirror <> Value) then
  begin
    FGradientMirror := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetGradientMirrorDisabled(
  const Value: TGDIPGradient);
begin
  if (FGradientMirrorDisabled <> Value) then
  begin
    FGradientMirrorDisabled := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetGradientMirrorHot(
  const Value: TGDIPGradient);
begin
  if (FGradientMirrorHot <> Value) then
  begin
    FGradientMirrorHot := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetGradientMirrorSelected(
  const Value: TGDIPGradient);
begin
  if (FGradientMirrorSelected <> Value) then
  begin
    FGradientMirrorSelected := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetGradientSelected(
  const Value: TGDIPGradient);
begin
  if (FGradientSelected <> Value) then
  begin
    FGradientSelected := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetTextColor(const Value: TColor);
begin
  if (FTextColor <> Value) then
  begin
    FTextColor := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetTextColorDisabled(const Value: TColor);
begin
  if (FTextColorDisabled <> Value) then
  begin
    FTextColorDisabled := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetTextColorHot(const Value: TColor);
begin
  if (FTextColorHot <> Value) then
  begin
    FTextColorHot := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetTextColorSelected(const Value: TColor);
begin
  if (FTextColorSelected <> Value) then
  begin
    FTextColorSelected := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.OnBackGroundChanged(Sender: TObject);
begin
  Changed;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetBorderColorDown(const Value: TColor);
begin
  if (FBorderColorDown <> Value) then
  begin
    FBorderColorDown := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TCustomTabAppearance.OnFontChanged(Sender: TObject);
begin
  if Assigned(FOnFontChange) then
    FOnFontChange(Self);
end;

//------------------------------------------------------------------------------

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

//------------------------------------------------------------------------------

{ TCustomAdvOfficePagerStyler }

procedure TCustomAdvOfficePagerStyler.AddControl(AControl: TCustomControl);
begin
  FControlList.Add(AControl);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.Assign(Source: TPersistent);
begin
  if Source is TCustomAdvOfficePagerStyler then
  begin
    TabAppearance.Assign((Source as TCustomAdvOfficePagerStyler).TabAppearance);
    PageAppearance.Assign((Source as TCustomAdvOfficePagerStyler).PageAppearance);
    RoundEdges := (Source as TCustomAdvOfficePagerStyler).RoundEdges;
  end
  else
    inherited Assign(Source);
end;

//------------------------------------------------------------------------------

constructor TCustomAdvOfficePagerStyler.Create(AOwner: TComponent);
begin
  inherited;
  FControlList := TDbgList.Create;
  FRoundEdges := True;
  FBlendFactor := 50;

  FTabAppearance := TTabAppearance.Create;
  FTabAppearance.OnChange := OnTabAppearanceChanged;
  FPageAppearance := TVistaBackground.Create;
  FPageAppearance.OnChange := OnPageAppearanceChanged;
  FGlowButtonAppearance := TGlowButtonAppearance.Create;
  FGlowButtonAppearance.onChange := OnGlowButtonAppearanceChanged;
end;

//------------------------------------------------------------------------------

destructor TCustomAdvOfficePagerStyler.Destroy;
var
  i: Integer;
begin
  if (csDesigning in ComponentState) then
  begin
    for i := 0 to FControlList.Count - 1 do
    begin
      if (TCustomControl(FControlList[i]) is TAdvOfficePager) then
      begin                            
        if (TAdvOfficePager(FControlList[i]).AdvOfficePagerStyler = Self) and not (csDestroying in TAdvOfficePager(FControlList[i]).ComponentState) then
          TAdvOfficePager(FControlList[i]).AdvOfficePagerStyler := nil;
      end;
    end;
  end;
  FControlList.Free;
  FTabAppearance.Free;
  FPageAppearance.Free;
  FGlowButtonAppearance.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.Change(PropID: integer);
var
  i: integer;
begin
  if (csDestroying in ComponentState) then
    Exit;

  for i := 0 to FControlList.Count - 1 do
  begin
    if (TCustomControl(FControlList[i]) is TAdvOfficePager) then
      TAdvOfficePager(FControlList[i]).UpdateMe(PropID);
  end;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: integer;
begin
  inherited;
  if not (csDestroying in ComponentState) and (Operation = opRemove) then
  begin
    i := FControlList.IndexOf(AComponent);
    if i >= 0 then
      FControlList.Remove(AComponent);
  end;

end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.RemoveControl(AControl: TCustomControl);
var
  i: integer;
begin
  i := FControlList.IndexOf(AControl);
  if i >= 0 then
    FControlList.Delete(i);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.OnTabAppearanceChanged(Sender: TObject);
begin
  Change(1);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.OnPageAppearanceChanged(Sender: TObject);
begin
  Change(2);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.OnGlowButtonAppearanceChanged(Sender: TObject);
begin
  Change(4);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.Loaded;
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.SetRoundEdges(const Value: boolean);
begin
  FRoundEdges := Value;
  Change(3);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.SetTabAppearance(
  const Value: TTabAppearance);
begin
  FTabAppearance.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.SetPageAppearance(
  const Value: TVistaBackground);
begin
  FPageAppearance.assign(Value);
end;

//------------------------------------------------------------------------------

procedure TCustomAdvOfficePagerStyler.SetGlowButtonAppearance(
  const Value: TGlowButtonAppearance);
begin
  FGlowButtonAppearance.Assign(Value);
end;

//------------------------------------------------------------------------------

{ TAdvOfficePage }

constructor TAdvOfficePage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csAcceptsControls] - [csOpaque];
  FCaption := '';
  FWideCaption := '';
  FTabVisible := True;
  FTabEnabled := True;
  FImageIndex := -1;
  FTimer := nil;
  FTabHint := '';
  FOfficeHint := TAdvHintInfo.Create;

  FIPicture := TGDIPPicture.Create;
  FIPicture.OnChange := PictureChanged;

  FIDisabledPicture := TGDIPPicture.Create;
  FIDisabledPicture.OnChange := PictureChanged;

  FBkgCache := TBitmap.Create;

  FShortCutHint := nil;
  FShortCutHintPos := shpTop;

  FShowClose := True;

  FTabAppearance := TTabAppearance.Create;
  FTabAppearance.OnChange := OnTabAppearanceChanged;
  FUseTabAppearance := false;
  FTabAppearance.OnFontChange := OnTabAppearanceFontChanged;

  FPageAppearance := TVistaBackground.Create;
  FPageAppearance.OnChange := OnPageAppearanceChanged;
  FUsePageAppearance := false;

  DoubleBuffered := true;
end;

//------------------------------------------------------------------------------

destructor TAdvOfficePage.Destroy;
begin
  if (FAdvOfficePager <> nil) then
  begin
    FAdvOfficePager.RemoveAdvPage(Self);
  end;

  if Assigned(FTimer) then
  begin
    FTimer.Enabled := false;
    FreeAndNil(FTimer);
  end;

  FOfficeHint.Free;
  FIPicture.Free;
  FIDisabledPicture.Free;
  FTabAppearance.Free;
  FPageAppearance.Free;
  FBkgCache.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.AlignControls(AControl: TControl; var ARect: TRect);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.CMShowingChanged(var Message: TMessage);
begin
  inherited;
  if Showing then
  begin
    if Assigned(FOnShow) then
      FOnShow(self);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.Loaded;
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.Paint;
var
  R, TabR: TRect;
  LnClr: TColor;
  i: Integer;
  Layout: TButtonLayout;
  aPageAppearance: TVistaBackground;
begin
  //inherited;
  if not Assigned(FAdvOfficePager) or not Assigned(FAdvOfficePager.FCurrentOfficePagerStyler) then
    Exit;

  if UsePageAppearance then
    aPageAppearance := PageAppearance
  else
    aPageAppearance := FAdvOfficePager.FCurrentOfficePagerStyler.PageAppearance;

  if (Self.Color <> aPageAppearance.Color) then
    Self.Color := aPageAppearance.Color;

  R := ClientRect;

  case FAdvOfficePager.TabSettings.ImagePosition of
    ipTop: Layout := blGlyphTop;
    ipBottom: Layout := blGlyphBottom;
    ipLeft: Layout := blGlyphLeft;
    ipRight: Layout := blGlyphRight;
    else Layout := blGlyphLeft;
  end;

  with aPageAppearance do
  begin
    LnClr := Color;

    if FValidCache and FAdvOfficePager.BufferedPages then
     Canvas.Draw(R.Left, R.Top, FBkgCache)
    else
    begin
      if FAdvOfficePager.BufferedPages then
      begin
        FBkgCache.Height := R.Bottom - R.Top;
        FBkgCache.Width := R.Right - R.Left;
        DrawVistaGradient(FBkgCache.Canvas, Rect(0, 0, FBkgCache.Width, FBkgCache.Height), Color, ColorTo, ColorMirror, ColorMirrorTo, BorderColor,
           Gradient, GradientMirror, '', Font, Layout, Enabled, False, FAdvOfficePager.AntiAlias, FAdvOfficePager.FCurrentOfficePagerStyler.RoundEdges, True, FAdvOfficePager.TabPosition);
        Canvas.Draw(R.Left, R.Top, FBkgCache);
        FValidCache := true;
      end
      else
        DrawVistaGradient(Canvas, Rect(0, 0, Width, Height), Color, ColorTo, ColorMirror, ColorMirrorTo, BorderColor,
           Gradient, GradientMirror, '', Font, Layout, Enabled, False, FAdvOfficePager.AntiAlias, FAdvOfficePager.FCurrentOfficePagerStyler.RoundEdges, True, FAdvOfficePager.TabPosition);

      {
      bmp := TBitMap.Create;
      bmp.Height := R.Bottom - R.Top;
      bmp.Width := R.Right - R.Left;
      DrawVistaGradient(bmp.Canvas, Rect(0, 0, bmp.Width, bmp.Height), Color, ColorTo, ColorMirror, ColorMirrorTo, BorderColor,
        Gradient, GradientMirror, '', Font, Layout, Enabled, False, FAdvOfficePager.AntiAlias, FAdvOfficePager.FCurrentOfficePagerStyler.RoundEdges, True, FAdvOfficePager.TabPosition);
      //DrawVistaGradient(Canvas, R, Color, ColorTo, ColorMirror, ColorMirrorTo, BorderColor,
        //Gradient, GradientMirror, '', Font, Enabled, False, FAdvOfficePager.AntiAlias, FAdvOfficePager.FCurrentOfficePagerStyler.RoundEdges, FAdvOfficePager.TabPosition);
      Canvas.Draw(R.Left, R.Top, bmp);
      bmp.Free;
      }
    end;

    //DrawVistaGradient(Canvas, R, Color, ColorTo, ColorMirror, ColorMirrorTo, BorderColor,
    //  Gradient, GradientMirror, '', Font, Enabled, False, FAdvOfficePager.AntiAlias, FAdvOfficePager.FCurrentOfficePagerStyler.RoundEdges, FAdvOfficePager.TabPosition);

    i := 3; // 10
    if not FAdvOfficePager.FCurrentOfficePagerStyler.RoundEdges then
      i := 2;

    case (FAdvOfficePager.TabPosition) of
      tpTop:
      begin
        // Draw 3D effect
        Canvas.Pen.Color := BlendColor(clWhite, BorderColor, FAdvOfficePager.FCurrentOfficePagerStyler.BlendFactor);
        Canvas.MoveTo(R.Left+1, R.Top + i);
        Canvas.LineTo(R.Left+1, R.Bottom-2);
        //Canvas.Pixels[R.Left+2, R.Bottom-3] := Canvas.Pen.Color;
        Canvas.MoveTo(R.Right-2, R.Top + i);
        Canvas.LineTo(R.Right-2, R.Bottom-2);
        //Canvas.Pixels[R.Right-3, R.Bottom-3] := Canvas.Pen.Color;

        Canvas.MoveTo(R.Left+3, R.Bottom -2);
        Canvas.LineTo(R.Right-2, R.Bottom-2);
      end;
      tpBottom:
      begin
        // Draw 3D effect
        Canvas.Pen.Color := BlendColor(clWhite, BorderColor, FAdvOfficePager.FCurrentOfficePagerStyler.BlendFactor);
        Canvas.MoveTo(R.Left+1, R.Top + 2);
        Canvas.LineTo(R.Left+1, R.Bottom-i);
        Canvas.MoveTo(R.Right-2, R.Top + 2);
        Canvas.LineTo(R.Right-2, R.Bottom-i);

        Canvas.MoveTo(R.Left+3, R.Top +1);
        Canvas.LineTo(R.Right-2, R.Top +1);
      end;
      tpLeft:
      begin
        // Draw 3D effect
        Canvas.Pen.Color := BlendColor(clWhite, BorderColor, FAdvOfficePager.FCurrentOfficePagerStyler.BlendFactor);
        Canvas.MoveTo(R.Left+i, R.Top + 1);
        Canvas.LineTo(R.Right-2, R.Top + 1);
        Canvas.MoveTo(R.Left+i, R.Bottom - 2);
        Canvas.LineTo(R.Right-2, R.Bottom - 2);

        Canvas.MoveTo(R.Right-2, R.Top +3);
        Canvas.LineTo(R.Right-2, R.Bottom-2);
      end;
      tpRight:
      begin
        // Draw 3D effect
        Canvas.Pen.Color := BlendColor(clWhite, BorderColor, FAdvOfficePager.FCurrentOfficePagerStyler.BlendFactor);
        Canvas.MoveTo(R.Left+2, R.Top + 1);
        Canvas.LineTo(R.Right-i, R.Top + 1);
        Canvas.MoveTo(R.Left+2, R.Bottom - 2);
        Canvas.LineTo(R.Right-i, R.Bottom - 2);

        Canvas.MoveTo(R.Left+1, R.Top +3);
        Canvas.LineTo(R.Left+1, R.Bottom-2);
      end;
    end;

  end;

  if (FAdvOfficePager.ActivePage = self) then
  begin
    TabR := FAdvOfficePager.GetTabRect(Self);

    if (FAdvOfficePager.TabSettings.Height > 0) then
    begin
    // Attaching to Tab
      case (FAdvOfficePager.TabPosition) of
        tpTop:
        begin
          TabR.Left := TabR.Left - FAdvOfficePager.FPageMargin;
          TabR.Right := Min(TabR.Right - FAdvOfficePager.FPageMargin, FAdvOfficePager.GetButtonsRect.Left);
          if not FAdvOfficePager.UseOldDrawing then
          begin
            case FAdvOfficePager.TabSettings.Shape of
              tsRectangle: TabR.Left := TabR.Left + 1;
              tsLeftRamp: TabR.Left := TabR.Left + 2 + FAdvOfficePager.TabSettings.Rounding div 2;
              tsRightRamp:
              begin
                TabR.Left := TabR.Left + 1;
                TabR.Right := TabR.Right - 1 - FAdvOfficePager.TabSettings.Rounding div 2;
              end;
              tsLeftRightRamp:
              begin
                TabR.Left := TabR.Left + 2 + FAdvOfficePager.TabSettings.Rounding div 2;
                TabR.Right := TabR.Right - 1 - FAdvOfficePager.TabSettings.Rounding div 2;
              end;
            end;
          end;
          Canvas.Pen.Color := LnClr;
          Canvas.MoveTo(TabR.Left, 0);
          Canvas.LineTo(TabR.Right, 0);
        end;
        tpBottom:
        begin
          TabR.Left := TabR.Left - FAdvOfficePager.FPageMargin;
          TabR.Right := Min(TabR.Right - FAdvOfficePager.FPageMargin, FAdvOfficePager.GetButtonsRect.Left);
          if not FAdvOfficePager.UseOldDrawing then
          begin
            case FAdvOfficePager.TabSettings.Shape of
              tsRectangle: TabR.Left := TabR.Left + 1;
              tsLeftRamp: TabR.Left := TabR.Left + 2 + FAdvOfficePager.TabSettings.Rounding div 2;
              tsRightRamp:
              begin
                TabR.Left := TabR.Left + 1;
                TabR.Right := TabR.Right - FAdvOfficePager.TabSettings.Rounding div 2;
              end;
              tsLeftRightRamp:
              begin
                TabR.Left := TabR.Left + 1 + FAdvOfficePager.TabSettings.Rounding div 2;
                TabR.Right := TabR.Right - FAdvOfficePager.TabSettings.Rounding div 2;
              end;
            end;
          end;
          Canvas.Pen.Color := LnClr;
          Canvas.MoveTo(TabR.Left, Height-1);
          Canvas.LineTo(TabR.Right, Height-1);
        end;
        tpLeft:
        begin
          TabR.Top := TabR.Top - FAdvOfficePager.FPageMargin;
          TabR.Bottom := Min(TabR.Bottom - FAdvOfficePager.FPageMargin, FAdvOfficePager.GetButtonsRect.Top);
          if not FAdvOfficePager.UseOldDrawing then
          begin
            case FAdvOfficePager.TabSettings.Shape of
              tsRectangle: TabR.Top := TabR.Top + 1;
              tsLeftRamp:
              begin
                TabR.Top := TabR.Top + 1;
                TabR.Bottom := TabR.Bottom - 1 - FAdvOfficePager.TabSettings.Rounding div 2;
              end;
              tsRightRamp: TabR.Top := TabR.Top + 2 + FAdvOfficePager.TabSettings.Rounding div 2;
              tsLeftRightRamp:
              begin
                TabR.Top := TabR.Top + 2 + FAdvOfficePager.TabSettings.Rounding div 2;
                TabR.Bottom := TabR.Bottom - 1 - FAdvOfficePager.TabSettings.Rounding div 2;
              end;
            end;
          end;
          Canvas.Pen.Color := LnClr;
          Canvas.MoveTo(0, TabR.Top-1);
          Canvas.LineTo(0, TabR.Bottom-1);
        end;
        tpRight:
        begin
          TabR.Top := TabR.Top - FAdvOfficePager.FPageMargin;
          TabR.Bottom := Min(TabR.Bottom - FAdvOfficePager.FPageMargin, FAdvOfficePager.GetButtonsRect.Top);
          if not FAdvOfficePager.UseOldDrawing then
          begin
            case FAdvOfficePager.TabSettings.Shape of
              tsRectangle: TabR.Top := TabR.Top + 1;
              tsLeftRamp: TabR.Top := TabR.Top + 1 + FAdvOfficePager.TabSettings.Rounding div 2;
              tsRightRamp:
              begin
                TabR.Top := TabR.Top + 1;
                TabR.Bottom := TabR.Bottom - 1 - FAdvOfficePager.TabSettings.Rounding div 2;
              end;
              tsLeftRightRamp:
              begin
                TabR.Top := TabR.Top + 2 + FAdvOfficePager.TabSettings.Rounding div 2;
                TabR.Bottom := TabR.Bottom - 1 - FAdvOfficePager.TabSettings.Rounding div 2;
              end;
            end;
          end;
          Canvas.Pen.Color := LnClr;
          Canvas.MoveTo(Width-1, TabR.Top-1);
          Canvas.LineTo(Width-1, TabR.Bottom-1);
        end;
      end;
    end;

    if FAdvOfficePager.FCurrentOfficePagerStyler.RoundEdges and (FAdvOfficePager.PageMargin > 0) then
    begin
      // Clean up edges
      Canvas.Pixels[R.Left, R.Top] := FAdvOfficePager.Canvas.Pixels[self.Left - 1, self.Top - 1];
      Canvas.Pixels[R.Left + 1, R.Top] := FAdvOfficePager.Canvas.Pixels[self.Left + 1, self.Top - 1];
      Canvas.Pixels[R.Left, R.Top + 1] := FAdvOfficePager.Canvas.Pixels[self.Left - 1, self.Top];

      Canvas.Pixels[R.Left, R.Bottom - 1] := FAdvOfficePager.Canvas.Pixels[self.Left - 1, self.Top + Height];
      Canvas.Pixels[R.Left + 1, R.Bottom - 1] := FAdvOfficePager.Canvas.Pixels[self.Left - 1, self.Top + Height];
      Canvas.Pixels[R.Left, R.Bottom - 2] := FAdvOfficePager.Canvas.Pixels[self.Left - 1, self.Top + Height];

      Canvas.Pixels[R.Right - 1, R.Top] := FAdvOfficePager.Canvas.Pixels[self.Left + Width, self.Top];
      Canvas.Pixels[R.Right - 2, R.Top] := FAdvOfficePager.Canvas.Pixels[self.Left + Width, self.Top];
      Canvas.Pixels[R.Right - 1, R.Top + 1] := FAdvOfficePager.Canvas.Pixels[self.Left + Width, self.Top];

      Canvas.Pixels[R.Right - 1, R.Bottom - 1] := FAdvOfficePager.Canvas.Pixels[self.Left + Width, self.Top + Height];
      Canvas.Pixels[R.Right - 2, R.Bottom - 1] := FAdvOfficePager.Canvas.Pixels[self.Left + Width, self.Top + Height];
      Canvas.Pixels[R.Right - 1, R.Bottom - 2] := FAdvOfficePager.Canvas.Pixels[self.Left + Width, self.Top + Height];
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetAdvOfficePager(const Value: TAdvOfficePager);
begin
  if (FAdvOfficePager <> Value) then
  begin
    if FAdvOfficePager <> nil then FAdvOfficePager.RemoveAdvPage(Self);
    Parent := Value;
    if (Value <> nil) then
    begin
      Value.AddAdvPage(Self);
    end;
    OnTabAppearanceFontChanged(FTabAppearance);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetParent(AParent: TWinControl);
var
  ci, ni: Integer;
  AOfficePager: TAdvOfficePager;
begin
  if ((AParent is TAdvOfficePage) or (AParent is TAdvOfficePager)) and not (FUpdatingParent) then
  begin
    AOfficePager := nil;
    if (AParent is TAdvOfficePage) then
    begin
      AOfficePager := TAdvOfficePage(AParent).FAdvOfficePager;
    end
    else if (AParent is TAdvOfficePager) then
    begin
      AOfficePager := TAdvOfficePager(AParent);
    end;

    if Assigned(FAdvOfficePager) and Assigned(AOfficePager) then
    begin

      if (FAdvOfficePager <> AOfficePager) then
      begin
        FUpdatingParent := True;
        AdvOfficePager := AOfficePager;
        FUpdatingParent := False;
      end;

      if (FAdvOfficePager = AOfficePager) then
      begin
        if (AParent is TAdvOfficePage) then
        begin
          ci := FAdvOfficePager.IndexOfPage(self);
          ni := FAdvOfficePager.IndexOfPage(TAdvOfficePage(AParent));
          AParent := AOfficePager;
          if (ci >= 0) and (ci < FAdvOfficePager.FAdvPages.Count) and
             (ni >= 0) and (ni < FAdvOfficePager.FAdvPages.Count) then
          begin
            FAdvOfficePager.MoveAdvPage(ci, ni);
          end
          else
            raise Exception.Create('Invalid Parent '+inttostr(ci)+':'+inttostr(ni));
        end
        else if (AParent is TAdvOfficePager) then
        begin
          AParent := AOfficePager;
        end;
        
        FAdvOfficePager.Invalidate;
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

procedure TAdvOfficePage.SetTabVisible(const Value: Boolean);
begin
  if (FTabVisible <> Value) then
  begin
    FTabVisible := Value;
    if Assigned(FAdvOfficePager) then
    begin
      if FAdvOfficePager.CloseOnTab then
        FAdvOfficePager.InitializeAndUpdateButtons;
      if Assigned(FAdvOfficePager.ActivePage) then
        FAdvOfficePager.ActivePage.Invalidate;
      FAdvOfficePager.Invalidate;
      FAdvOfficePager.UpdateTabScroller;
    end;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.TimerProc(Sender: TObject);
var
  P: TPoint;
begin
  case FGlowState of
    gsHover:
    begin
      FStepHover := FStepHover + FTimeInc;
      if ((FStepHover > 100) and (FTimeInc > 0))
         or ((FStepHover < 0) and (FTimeInc < 0)) then
      begin
        if (FStepHover > 100) and (FTimeInc > 0) and Assigned(FAdvOfficePager) then
        begin
          FStepHover := 120;
          GetCursorPos(P);
          P := FAdvOfficePager.ScreenToClient(P);
          if not PtInRect(FAdvOfficePager.GetTabRect(Self), P) then
          begin
            FTimeInc := -GLOWSTEP;
            FGlowState := gsHover;
            FAdvOfficePager.FHotPageIndex := -1;
            Exit;
          end;
        end
        else if ((FStepHover < 0) and (FTimeInc < 0)) then
        begin
          FreeAndNil(FTimer);
          FGlowState := gsNone;
          if Assigned(FAdvOfficePager) then
            FAdvOfficePager.InvalidateTab(-1);
        end;

        FStepPush := 0;
        if (FStepHover > 100) then
          FStepHover := 120;
        if (FStepHover < 0) then
          FStepHover := -20;
      end
      else if Assigned(FAdvOfficePager) then
        FAdvOfficePager.InvalidateTab(-1);
    end;
    gsPush:
    begin
      FStepPush := FStepPush + FTimeInc;
      if ((FStepPush > 100) and (FTimeInc > 0))
         or ((FStepPush < 0) and (FTimeInc < 0)) then
      begin
        FreeAndNil(FTimer);
        FGlowState := gsNone;
        FStepPush := 0;
        //FStepHover := 0;
      end
      else if Assigned(FAdvOfficePager) then
        FAdvOfficePager.InvalidateTab(-1);
    end;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.WMSize(var Message: TWMSize);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.CMControlChange(var Message: TCMControlChange);
begin
  inherited;
  with Message do
  begin

  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.CMControlListChange(var Message: TCMControlListChange);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.WMEraseBkGnd(var Message: TWMEraseBkGnd);
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

procedure TAdvOfficePage.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TAdvOfficePager then
    AdvOfficePager := TAdvOfficePager(Reader.Parent);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.PictureChanged(Sender: TObject);
begin
  if Assigned(FAdvOfficePager) then
  begin
    FAdvOfficePager.Invalidate;
    if not (csLoading in ComponentState) then
    begin
      if FAdvOfficePager.CloseOnTab and (FAdvOfficePager.ActivePage = self) then
        FAdvOfficePager.InitializeAndUpdateButtons;
      FAdvOfficePager.UpdateTabScroller;
    end;
  end;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetDisabledPicture(const Value: TGDIPPicture);
begin
  FIDisabledPicture.Assign(Value);
  if Assigned(FAdvOfficePager) then
    FAdvOfficePager.Invalidate;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetPicture(const Value: TGDIPPicture);
begin
  FIPicture.Assign(Value);
  if Assigned(FAdvOfficePager) then
    FAdvOfficePager.Invalidate;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetCaption(const Value: TCaption);
begin
  if (FCaption <> Value) then
  begin
    FCaption := Value;
    Invalidate;
    if Assigned(FAdvOfficePager) then
    begin
      FAdvOfficePager.Invalidate;
      if FAdvOfficePager.CloseOnTab and (FAdvOfficePager.ActivePage = self) then
        FAdvOfficePager.InitializeAndUpdateButtons;
      FAdvOfficePager.UpdateTabScroller;  
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetTabEnabled(const Value: Boolean);
begin
  if (FTabEnabled <> Value) then
  begin
    FTabEnabled := Value;
    Invalidate;
    if Assigned(FAdvOfficePager) then
      FAdvOfficePager.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
  if Assigned(FAdvOfficePager) then
    FAdvOfficePager.Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetOfficeHint(const Value: TAdvHintInfo);
begin
  FOfficeHint.Assign(Value);
end;

//------------------------------------------------------------------------------

function TAdvOfficePage.GetPageIndex: Integer;
begin
  if Assigned(FAdvOfficePager) then
    Result := FAdvOfficePager.IndexOfPage(Self)
  else
    Result := -1;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetPageIndex(const Value: Integer);
begin
  if Assigned(FAdvOfficePager) and (Value >= 0) and (Value < FAdvOfficePager.AdvPageCount) then
  begin
    FAdvOfficePager.MoveAdvPage(FAdvOfficePager.IndexOfPage(Self), Value);
    FAdvOfficePager.Invalidate;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.HideShortCutHint;
begin
  if Assigned(FShortCutHint) and Assigned(AdvOfficePager) then
  begin
    FShortCutHint.Visible := false;
    AdvOfficePager.DestroyShortCutHintWin(FShortCutHint);
    //FShortCutHint.Free;
    FShortCutHint := nil;
  end;
end;


//------------------------------------------------------------------------------

procedure TAdvOfficePage.ShowShortCutHint;
var
  pt: TPoint;
  TabR: TRect;
begin
  if not Assigned(AdvOfficePager) then
    Exit;

  if not Assigned(FShortCutHint) then
  begin
    FShortCutHint := AdvOfficePager.CreateShortCutHintWin;
  end;

  FShortCutHint.Visible := false;
  FShortCutHint.Caption := FShortCutHintText;

  TabR := AdvOfficePager.GetTabRect(Self);
  pt := AdvOfficePager.ClientToScreen(Point(TabR.Left, TabR.Top));

  case ShortCutHintPos of
  shpLeft:
    begin
      FShortCutHint.Left := pt.X - (FShortCutHint.Width div 2);
      FShortCutHint.Top := pt.Y + ((TabR.bottom - TabR.Top) - FShortCutHint.Height) div 2;
    end;
  shpTop:
    begin
      FShortCutHint.Left := pt.X + ((TabR.Right - TabR.Left) - FShortCutHint.Width) div 2;
      FShortCutHint.Top := pt.Y - (FShortCutHint.Height div 2);
    end;
  shpRight:
    begin
      FShortCutHint.Left := pt.X + (TabR.Right - TabR.Left) - (FShortCutHint.Width div 2);
      FShortCutHint.Top := pt.Y + ((TabR.bottom - TabR.Top) - FShortCutHint.Height) div 2;
    end;
  shpBottom:
    begin
      FShortCutHint.Left := pt.X + ((TabR.Right - TabR.Left) - FShortCutHint.Width) div 2;
      FShortCutHint.Top := pt.Y + (TabR.bottom - TabR.Top) - (FShortCutHint.Height div 2);
    end;
  end;

  FShortCutHint.Visible := true;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.AdjustClientRect(var Rect: TRect);
begin
  Rect := Classes.Rect(2, 2, Rect.Right-2, Rect.Bottom - 2);
  inherited AdjustClientRect(Rect);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetShowClose(const Value: Boolean);
begin
  if (FShowClose <> Value) then
  begin
    FShowClose := Value;
    if Assigned(FAdvOfficePager) then
    begin
      FAdvOfficePager.InitializeAndUpdateButtons;
      FAdvOfficePager.Invalidate;
    end;  
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetTabAppearance(const Value: TTabAppearance);
begin
  FTabAppearance.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetUseTabAppearance(const Value: Boolean);
begin
  if (FUseTabAppearance <> Value) then
  begin
    FUseTabAppearance := Value;
    OnTabAppearanceFontChanged(FTabAppearance);
    if Assigned(FAdvOfficePager) then
      FAdvOfficePager.Invalidate;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.OnTabAppearanceFontChanged(Sender: TObject);
begin
  if (FUseTabAppearance) then
  begin
    Invalidate;
    if Assigned(FAdvOfficePager) then
    begin
      FAdvOfficePager.Invalidate;
      if FAdvOfficePager.CloseOnTab and (FAdvOfficePager.ActivePage = self) then
        FAdvOfficePager.InitializeAndUpdateButtons;
      FAdvOfficePager.UpdateTabScroller;  
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.OnTabAppearanceChanged(Sender: TObject);
begin
  if Assigned(FAdvOfficePager) then
    FAdvOfficePager.Invalidate;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetPageAppearance(const Value: TVistaBackground);
begin
  FPageAppearance.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.OnPageAppearanceChanged(Sender: TObject);
begin
  FValidCache := False;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetUsePageAppearance(const Value: Boolean);
begin
  if (FUsePageAppearance <> Value) then
  begin
    FUsePageAppearance := Value;
    FValidCache := False;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePage.SetWideCaption(const Value: widestring);
begin
  if (FWideCaption <> Value) then
  begin
    FWideCaption := Value;
    Invalidate;
    if Assigned(FAdvOfficePager) and (Caption = '') then
    begin
      FAdvOfficePager.Invalidate;
      if FAdvOfficePager.CloseOnTab and (FAdvOfficePager.ActivePage = self) then
        FAdvOfficePager.InitializeAndUpdateButtons;
      FAdvOfficePager.UpdateTabScroller;
    end;
  end;
end;

//------------------------------------------------------------------------------

{ TAdvOfficePager }

constructor TAdvOfficePager.Create(AOwner: TComponent);
var
  ps: TAdvOfficePagerOfficeStyler;

begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls] - [csOpaque];

  FBufferedPages := false;

  //inherited Align := alTop;

  FInternalOfficePagerStyler := TCustomAdvOfficePagerStyler.Create(self);
  FInternalOfficePagerStyler.Name := 'InternalStyler';

  FOfficePagerStyler := nil;
  FCurrentOfficePagerStyler := FInternalOfficePagerStyler;
  FCurrentOfficePagerStyler.AddControl(self);
  {$IFDEF DELPHI6_LVL}
  FInternalOfficePagerStyler.SetSubComponent(True);
  {$ENDIF}

  FOffSetX := 0;
  FOffSetY := 0;

  FTabOffSet := 4;
  FPageMargin := ADVPAGE_OFFSET;
  FIsClosing := false;

  FTabPosition := tpTop;

  FAntiAlias := aaClearType;

  FAdvPages := TDbgList.Create;

  FTabScroller := TPagerTabScroller.Create;

  FTabSettings := TPagerTabSettings.Create;
  FTabSettings.OnChange := OnTabSettingsChanged;

  FActivePageIndex := -1;
  FHotPageIndex := -1;
  FOldHotPageIndex := -1;
  FDownPageIndex := -1;

  FShowTabHint := false;
  FHintPageIndex := -1;
  ShowHint := false;

  FButtonSettings := TPageButtonSettings.Create;
  FButtonSettings.OnChange := OnButtonSettingChanged;
  FPageListMenu := nil;
  FRotateTabLeftRight := true;
  FCloseOnTab := false;
  FCloseOnTabPosition := cpRight;

  DoubleBuffered := true;
  Height := 200;
  Width := 400;
  FOldCapRightIndent := 0;

  FOfficeHint := TAdvHintInfo.Create;

  FCloseButton := nil;
  FPageListButton := nil;
  FScrollPrevButton := nil;
  FScrollNextButton := nil;

  FShortCutHintWinList := TDbgList.Create;
  FShowShortCutHints := False;

  FTabReorder := False;
  FButtonsBkg := TBitmap.Create;

  FDesignTime := (csDesigning in ComponentState) and not
      ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  ps := TAdvOfficePagerOfficeStyler.Create(self);
  ps.Style := psOffice2007Luna;
  FInternalOfficePagerStyler.Assign(ps);
  ps.Free;

  FGlow := true;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CreateParams(var Params: TCreateParams);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CreateWnd;
var
  p: TWinControl;
  t: TAdvOfficePage;
  gotpages: boolean;
  i: integer;
  
begin
  inherited;

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
    FDesignTime := false;
    t := TAdvOfficePage.Create(Owner);
    t.AdvOfficePager := self;
    t.Name := Name + '1';
    t.Caption := t.Name;
    t := TAdvOfficePage.Create(Owner);
    t.AdvOfficePager := self;
    t.Name := Name + '2';
    t.Caption := t.Name;
    t := TAdvOfficePage.Create(Owner);
    t.AdvOfficePager := self;
    t.Name := Name + '3';
    t.Caption := t.Name;
    ActivePageIndex := 0;
  end;
end;

//------------------------------------------------------------------------------

destructor TAdvOfficePager.Destroy;
var
  i: Integer;
begin
   if Assigned(FOfficePagerStyler)
     and (FOfficePagerStyler <> FInternalOfficePagerStyler) then
       FOfficePagerStyler.RemoveControl(self);

  FreeAndNil(FInternalOfficePagerStyler);

  for I := 0 to FAdvPages.Count - 1 do
    TAdvOfficePage(FAdvPages[I]).FAdvOfficePager := nil;

  FAdvPages.Free;
  FTabSettings.Free;
  FTabScroller.Free;
  FOfficeHint.Free;
  FButtonSettings.Free;
  if (FCloseButton <> nil) then
    FCloseButton.Free;
  if (FPageListButton <> nil) then
    FPageListButton.Free;
  if (FScrollPrevButton <> nil) then
    FScrollPrevButton.Free;
  if (FScrollNextButton <> nil) then
    FScrollNextButton.Free;

  for i := 0 to FShortCutHintWinList.Count - 1 do
  begin
    if (FShortCutHintWinList.Items[i] <> nil) then
    begin
      TShortCutHintWindow(FShortCutHintWinList.Items[i]).Free;
      FShortCutHintWinList.Items[i] := nil;
    end;
  end;

  FShortCutHintWinList.Free;
  FButtonsBkg.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.MoveAdvPage(CurIndex, NewIndex: Integer);
var
  OldActivePage: TAdvOfficePage;
begin
  if (CurIndex >= 0) and (CurIndex < FAdvPages.Count) and
     (NewIndex >= 0) and (NewIndex < FAdvPages.Count) then
  begin
    OldActivePage := ActivePage;
    FAdvPages.Move(CurIndex, NewIndex);
    ActivePage := OldActivePage;
    UpdateTabScroller;

    if Assigned(FOnTabMoved) then
      FOnTabMoved(Self, CurIndex, NewIndex);
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.AddAdvPage(AdvPage: TAdvOfficePage): integer;
begin
  Result := FAdvPages.IndexOf(AdvPage);
  if (FAdvPages.IndexOf(AdvPage) < 0) then
  begin
    FAdvPages.Add(AdvPage);
    Result := FAdvPages.Count - 1;

    if (csDesigning in ComponentState) and Assigned(FCurrentOfficePagerStyler) then
    begin
      if not AdvPage.UsePageAppearance then
        AdvPage.PageAppearance.Assign(FCurrentOfficePagerStyler.PageAppearance);
        
      if not AdvPage.UseTabAppearance then
        AdvPage.TabAppearance.Assign(FCurrentOfficePagerStyler.TabAppearance);
    end;
  end;

  if (AdvPage.Parent <> Self) then
    AdvPage.Parent := Self;
  AdvPage.FAdvOfficePager := Self;
  SetPagePosition(AdvPage);
  if (AdvPage <> ActivePage) then
    AdvPage.Visible := False;

  InvalidateTab(-1);
  if Assigned(ActivePage) then
  begin
    ActivePage.BringToFront;
    ActivePage.Invalidate;
  end;

  UpdateTabScroller;  
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.AddAdvPage(PageCaption: TCaption): integer;
var
  aPage: TAdvOfficePage;
begin
  aPage := TAdvOfficePage.Create(Self);
  aPage.Caption := PageCaption;
  Result := AddAdvPage(aPage);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.AlignControls(AControl: TControl;
  var ARect: TRect);
begin
  inherited;
  {if (AControl <> nil) and (AControl is TAdvOfficePage) then
    SetPagePosition(TAdvOfficePage(AControl))
  else if (AControl is TAdvOfficePage) then} 
  SetAllPagesPosition;  
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.Loaded;
begin
  inherited;
  FPropertiesLoaded := True;
  InitializeAndUpdateButtons;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if not (csDestroying in ComponentState) and (Operation = opRemove) then
  begin
    if AComponent = AdvOfficePagerStyler then
      AdvOfficePagerStyler := nil; 
    if (AComponent = PopupMenu) then
      PopupMenu := nil;
    if (AComponent = Images) then
      Images := nil;
    if (AComponent = DisabledImages) then
      DisabledImages := nil;    
    if (AComponent = PageListMenu) then
      PageListMenu := nil;
  end;

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.AdjustClientRect(var Rect: TRect);
begin
  { if Align in [daTop, daBottom] then
   begin
     if (FAdvPages.Count > 0) then
       Rect.Top := Rect.Top + TabSettings.Height;
     if (FCaption.Visible) then
       Rect.Top := Rect.Top + FCaption.Height;
   end; }
  inherited AdjustClientRect(Rect);
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetTabImageSize(PageIndex: Integer): TSize;
var
  Pic: TGDIPPicture;
begin
  Result.cx := 0;
  Result.cy := 0;
  if (PageIndex < 0) or (PageIndex >= FAdvPages.Count) then
    Exit;

  if AdvPages[PageIndex].Enabled or AdvPages[PageIndex].DisabledPicture.Empty then
    Pic := AdvPages[PageIndex].Picture
  else
    Pic := AdvPages[PageIndex].DisabledPicture;

  if Assigned(Pic) and not Pic.Empty then
  begin
    Pic.GetImageSizes;
    Result.cx := Pic.Width;
    Result.cy := Pic.Height;
  end
  else
  if (Assigned(FImages) or Assigned(DisabledImages)) and (AdvPages[PageIndex].ImageIndex >= 0) then
  begin
    if AdvPages[PageIndex].Enabled then
    begin
      if Assigned(FImages) then
      begin
        Result.cx := FImages.Width;
        Result.cy := FImages.Height;
      end;
    end
    else
    begin
      if Assigned(FDisabledImages) then
      begin
        Result.cx := FDisabledImages.Width;
        Result.cy := FDisabledImages.Height;
      end
      else if Assigned(FImages) then
      begin
        Result.cx := FImages.Width;
        Result.cy := FImages.Height;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetTextSize(PageIndex: Integer): TSize;
var
  R: TRect;
  //Ellipsis: Boolean;
  OldF: TFont;
begin
  Result.cx := 0;
  Result.cy := 0;
  if (PageIndex < 0) or (PageIndex >= FAdvPages.Count) then
    Exit;

  //Ellipsis := (TabSettings.Width > 0) and not TabSettings.WordWrap;
  OldF := TFont.Create;
  OldF.assign(Canvas.Font);
  Canvas.Font.Assign(FCurrentOfficePagerStyler.TabAppearance.Font);

  if (AdvPages[PageIndex].Caption <> '') then
  begin
    R := Rect(0,0, 1000, 100);
    DrawText(Canvas.Handle,PChar(AdvPages[PageIndex].Caption),Length(AdvPages[PageIndex].Caption), R, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
    Result.cx := R.Right;
    Result.cy := R.Bottom;
    case AntiAlias of
      aaNone, aaClearType:
        Result.cx := Result.cx + length(AdvPages[PageIndex].Caption) div 3;
    end;
  end
  else if (AdvPages[PageIndex].WideCaption <> '') then
  begin
    R := Rect(0,0, 1000, 100);
{$IFNDEF TMSDOTNET}
    DrawTextW(Canvas.Handle, PWideChar(AdvPages[PageIndex].WideCaption), -1, R, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
{$ENDIF}
{$IFDEF TMSDOTNET}
    DrawTextW(Canvas.Handle, AdvPages[PageIndex].WideCaption, -1, R, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
{$ENDIF}
    Result.cx := R.Right;
    Result.cy := R.Bottom;
    case AntiAlias of
      aaNone, aaClearType:
        Result.cx := Result.cx + length(AdvPages[PageIndex].WideCaption);
    end;
  end;

  Canvas.Font.Assign(OldF);
  OldF.Free;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.GetCloseBtnImageAndTextRect(PageIndex: Integer;
  var CloseBtnR, TextR: TRect; var ImgP: TPoint);
var
  ActivePg: Boolean;
  R: TRect;
  i: Integer;
  ImgSize, TxtSize, CloseBtnSize: TSize;
begin
  if (PageIndex < 0) or (PageIndex >= FAdvPages.Count) or (TabSettings.Height <= 0) or (TabSettings.Width <= 0) then
    Exit;

  R := GetTabRect(PageIndex);
  if (R.Left <= -1) and (R.Right <= -1) then
    Exit;

  ActivePg := (ActivePageIndex = PageIndex);

  ImgSize := GetTabImageSize(PageIndex);
  TxtSize := GetTextSize(PageIndex);
  if CloseOnTab then
  begin
    CloseBtnSize.cx := PAGEBUTTON_SIZE;
    CloseBtnSize.cy := PAGEBUTTON_SIZE;
  end
  else
  begin
    CloseBtnSize.cx := 0;
    CloseBtnSize.cy := 0;
  end;
  
  if (TabPosition in [tpTop, tpBottom]) or (not RotateTabLeftRight) then
  begin
    i := R.Right - R.Left;
    
    if (TabSettings.Shape in [tsRightRamp, tsLeftRightRamp]) then
      R.Right := R.Right - TabSettings.Rounding;

    case TabSettings.ImagePosition of
      ipTop, ipBottom:
        ImgSize.cx := 0;
      ipLeft, ipRight:
      begin
      end;
    end;
    
    case TabSettings.Alignment of
      taLeftJustify:
      begin
      end;
      taCenter:
      begin
        if (CloseBtnSize.cx > 0) and ActivePg then
          i := (i - CloseBtnSize.cx - 4);
        if (ImgSize.cx > 0) then
          i := i - ImgSize.cx - IMG_SPACE;
        i := (i - TxtSize.cx) div 2;
        R.Left := Max(R.Left + i, R.Left);
        
        if ActivePg and CloseOnTab and (CloseOnTabPosition = cpLeft) then
        begin
          CloseBtnR.Left := R.Left;
          CloseBtnR.Right := CloseBtnR.Left + PAGEBUTTON_SIZE;
          R.Left := CloseBtnR.Right + 4;
        end;

        if (TabSettings.ImagePosition = ipLeft) and (ImgSize.cx > 0) then
        begin
          ImgP.X := R.Left;
          R.Left := R.Left + ImgSize.cx + IMG_SPACE;
        end;

        if (TxtSize.cx > 0) then
        begin
          TextR.Left := R.Left;
          TextR.Right := TextR.Left + TxtSize.cx;
          R.Left := Min(R.Left + TxtSize.cx, R.Right);
        end;
        
        if (TabSettings.ImagePosition = ipRight) and (ImgSize.cx > 0) then
        begin
          ImgP.X := R.Left + IMG_SPACE;
          R.Left := R.Left + ImgSize.cx + IMG_SPACE;
        end;

        if ActivePg and CloseOnTab and (CloseOnTabPosition = cpRight) then
        begin
          CloseBtnR.Left := R.Left + 4;
          CloseBtnR.Right := CloseBtnR.Left + PAGEBUTTON_SIZE;
        end;
      end;
      taRightJustify:
      begin
      end;
    end;
  end
  else if (TabPosition = tpLeft) then
  begin
    i := R.Bottom - R.Top;
    if (TabSettings.Shape in [tsLeftRamp, tsLeftRightRamp]) then
      R.Bottom := R.Bottom - TabSettings.Rounding;
    if (TabSettings.Shape in [tsRightRamp, tsLeftRightRamp]) then
      R.Top := R.Top + TabSettings.Rounding;

    case TabSettings.ImagePosition of
      ipTop, ipBottom:
        ImgSize.cx := 0;
      ipLeft, ipRight:
      begin
      end;
    end;

    if (CloseBtnSize.cx > 0) and ActivePg then
      i := (i - CloseBtnSize.cx - 4);
    if (ImgSize.cx > 0) then
      i := i - ImgSize.cx - IMG_SPACE;
    i := (i - TxtSize.cx) div 2;
    
    case TabSettings.Alignment of
      taLeftJustify:
      begin
      end;
      taCenter:
      begin
        R.Bottom := Min(R.Bottom - i, R.Bottom);

        if ActivePg and CloseOnTab and (CloseOnTabPosition = cpLeft) then
        begin
          CloseBtnR.Top := R.Bottom - PAGEBUTTON_SIZE;
          CloseBtnR.Bottom := CloseBtnR.Top + PAGEBUTTON_SIZE;
          R.Bottom := CloseBtnR.Top - 4;
        end;

        if (TabSettings.ImagePosition = ipLeft) and (ImgSize.cx > 0) then
        begin
          ImgP.Y := R.Bottom - ImgSize.cy;
          R.Bottom := R.Bottom - ImgSize.cy - IMG_SPACE;
        end;

        if (TxtSize.cx > 0) then
        begin
          TextR.Bottom := R.Bottom;
          TextR.Top := TextR.Bottom - TxtSize.cx;
          R.Bottom := Max(R.Bottom - TxtSize.cx, R.Top);
        end;

        if (TabSettings.ImagePosition = ipRight) and (ImgSize.cx > 0) then
        begin
          ImgP.Y := R.Bottom - ImgSize.cy - IMG_SPACE;
          R.Bottom := ImgP.Y;
        end;

        if ActivePg and CloseOnTab and (CloseOnTabPosition = cpRight) then
        begin
          CloseBtnR.Bottom := R.Bottom - 4;
          CloseBtnR.Top := CloseBtnR.Bottom - PAGEBUTTON_SIZE;
        end;
      end;
      taRightJustify:
      begin
        R.Bottom := Min(R.Bottom - i, R.Bottom);

        if ActivePg and CloseOnTab and (CloseOnTabPosition = cpRight) then
        begin
          CloseBtnR.Top := R.Top;
          CloseBtnR.Bottom := CloseBtnR.Top + PAGEBUTTON_SIZE;
          R.Top := CloseBtnR.Bottom + 4;
        end;

        if (TabSettings.ImagePosition = ipRight) and (ImgSize.cx > 0) then
        begin
          ImgP.Y := R.Top;
          R.Top := ImgP.Y + ImgSize.cy + IMG_SPACE;
        end;

        if (TxtSize.cx > 0) then
        begin
          TextR.Top := R.Top;
          TextR.Bottom := TextR.Top + TxtSize.cx;
          R.Top := Min(R.Top + TxtSize.cx, R.Bottom);
        end;

        if (TabSettings.ImagePosition = ipLeft) and (ImgSize.cx > 0) then
        begin
          ImgP.Y := R.Top + IMG_SPACE;
          R.Top := ImgP.Y + ImgSize.cy;
        end;
        if ActivePg and CloseOnTab and (CloseOnTabPosition = cpLeft) then
        begin
          CloseBtnR.Top := R.Top + 4;
          CloseBtnR.Bottom := CloseBtnR.Top + PAGEBUTTON_SIZE;
          R.Top := CloseBtnR.Bottom;
        end;
      end;
    end;
  end
  else if (TabPosition = tpRight) then
  begin
    i := R.Bottom - R.Top;
    if (TabSettings.Shape in [tsLeftRamp, tsLeftRightRamp]) then
      R.Bottom := R.Bottom - TabSettings.Rounding;
    if (TabSettings.Shape in [tsRightRamp, tsLeftRightRamp]) then
      R.Top := R.Top + TabSettings.Rounding;

    case TabSettings.ImagePosition of
      ipTop, ipBottom:
        ImgSize.cx := 0;
      ipLeft, ipRight:
      begin
      end;
    end;

    if (CloseBtnSize.cx > 0) and ActivePg then
      i := (i - CloseBtnSize.cx - 4);
    if (ImgSize.cx > 0) then
      i := i - ImgSize.cx - IMG_SPACE;
    i := (i - TxtSize.cx) div 2;
    
    case TabSettings.Alignment of
      taLeftJustify:
      begin
      end;
      taCenter:
      begin
        R.Top := Min(R.Top + i, R.Bottom);

        if ActivePg and CloseOnTab and (CloseOnTabPosition = cpLeft) then
        begin
          CloseBtnR.Top := R.Top;
          CloseBtnR.Bottom := CloseBtnR.Top + PAGEBUTTON_SIZE;
          R.Top := CloseBtnR.Top + PAGEBUTTON_SIZE + 4;
        end;

        if (TabSettings.ImagePosition = ipLeft) and (ImgSize.cx > 0) then
        begin
          ImgP.Y := R.Top;
          R.Top := R.Top + ImgSize.cy + IMG_SPACE;
        end;

        if (TxtSize.cx > 0) then
        begin
          TextR.Top := R.Top;
          TextR.Bottom := TextR.Top + TxtSize.cx;
          R.Top := Min(R.Top + TxtSize.cx, R.Bottom);
        end;

        if (TabSettings.ImagePosition = ipRight) and (ImgSize.cx > 0) then
        begin
          ImgP.Y := R.Top + IMG_SPACE;
          R.Top := ImgP.Y + ImgSize.cy;
        end;

        if ActivePg and CloseOnTab and (CloseOnTabPosition = cpRight) then
        begin
          CloseBtnR.Top := R.Top + 4;
          CloseBtnR.Bottom := CloseBtnR.Top + PAGEBUTTON_SIZE;
        end;
      end;
      taRightJustify:
      begin
        //R.Top := Min(R.Top + i, R.Bottom);

        if ActivePg and CloseOnTab and (CloseOnTabPosition = cpRight) then
        begin
          CloseBtnR.Top := R.Bottom - PAGEBUTTON_SIZE;
          CloseBtnR.Bottom := CloseBtnR.Top + PAGEBUTTON_SIZE;
          R.Bottom := CloseBtnR.Top - 4;
        end;

        if (TabSettings.ImagePosition = ipRight) and (ImgSize.cx > 0) then
        begin
          ImgP.Y := R.Bottom - ImgSize.cy;
          R.Bottom := ImgP.Y - ImgSize.cy - IMG_SPACE;
        end;

        if (TxtSize.cx > 0) then
        begin
          TextR.Bottom := R.Bottom;
          TextR.Top := TextR.Bottom - TxtSize.cx;
          R.Bottom := Max(R.Bottom - TxtSize.cx, R.Top);
        end;

        if (TabSettings.ImagePosition = ipLeft) and (ImgSize.cx > 0) then
        begin
          ImgP.Y := R.Bottom - IMG_SPACE - ImgSize.cy;
          R.Bottom := ImgP.Y;
        end;
        if ActivePg and CloseOnTab and (CloseOnTabPosition = cpLeft) then
        begin
          CloseBtnR.Bottom := R.Bottom - 4;
          CloseBtnR.Top := CloseBtnR.Bottom - PAGEBUTTON_SIZE;
          R.Bottom := CloseBtnR.Top;
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.DrawTab(PageIndex: Integer);
var
  GradColor: TColor;
  GradColorTo: TColor;
  GradColorMirror: TColor;
  GradColorMirrorTo: TColor;
  PenColor, TempClr: TColor;
  GradB, GradU: TGDIPGradient;
  ImgList: TCustomImageList;
  Pic: TGDIPPicture;
  ImgEnabled: Boolean;
  R, CapR: TRect;
  ImgX, ImgY, ImgTxtSp: Integer;
  ImgW, ImgH: Integer;
  DCaption: string;
  WCaption: WideString;
  DoRepaint: Boolean;
  TxtClr: TColor;
  TabAppearance: TCustomTabAppearance;
  tf: TFont;
  lf: TLogFont;
  bmp: TBitMap;
  TabPos: TTabPosition;
  RotateLR: Boolean;
  SelectedHot: Boolean;
  Ellipsis: Boolean;
  Layout: TButtonLayout;
  TxtR, R2, R3, CapR2: TRect;
  AAlign: TAlignment;
  Shape: TAdvTabShape;
  HighLightClr: TColor;
  cbr, TR: TRect;
  ImgP: TPoint;
begin
  if (PageIndex < 0) or (PageIndex >= FAdvPages.Count) or (TabSettings.Height <= 0) then
    Exit;

  ImgTxtSp := IMG_SPACE;
  GradColor := clNone;
  GradColorTo := clNone;
  GradColorMirror := clNone;
  GradColorMirrorTo := clNone;
  PenColor := clNone;
  TxtClr := clNone;
  GradB := ggRadial;
  GradU := ggRadial;

  ImgList := nil;
  DoRepaint := True;

  SelectedHot := False;

  R := GetTabRect(PageIndex);

  if (R.Left <= -1) and (R.Right <= -1) then
    Exit;

  Layout := blGlyphLeft;
  ImgY := 0;
  ImgX := 0;
  ImgH := 0;
  ImgW := 0;

  ImgEnabled := True;

  Ellipsis := (TabSettings.Width > 0) and not TabSettings.WordWrap;
  if AdvPages[PageIndex].UseTabAppearance then
    TabAppearance := AdvPages[PageIndex].TabAppearance
  else
    TabAppearance := FCurrentOfficePagerStyler.TabAppearance;

  HighLightClr := TabAppearance.HighLightColor;
    
  with TabAppearance do
  begin
    //DrawDwLn := False;
    if not(AdvPages[PageIndex].TabEnabled) and ShowNonSelectedTabs then
    begin
      if ShowNonSelectedTabs then
      begin
        GradColor := ColorDisabled;
        GradColorTo := ColorDisabledTo;
        GradColorMirror := ColorMirrorDisabled;
        GradColorMirrorTo := ColorMirrorDisabledTo;
        PenColor := BorderColorDisabled;
        GradU := GradientDisabled;
        GradB := GradientMirrorDisabled;
        TxtClr := TextColorDisabled;
      end
      else
      begin

      end;
    end
    else
    if (PageIndex = ActivePageIndex) then
    begin
      GradColor := ColorSelected;
      GradColorTo := ColorSelectedTo;
      GradColorMirror := ColorMirrorSelected;
      GradColorMirrorTo := ColorMirrorSelectedTo;
      PenColor := BorderColorSelected;
      GradU := GradientSelected;
      GradB := GradientMirrorSelected;
      TxtClr := TextColorSelected;
      HighLightClr := TabAppearance.HighLightColor;

     { if (GroupOfTab(PageIndex) >= 0) then
      begin
        GradColor := ColorSelectedGroup;
        GradColorTo := ColorSelectedGroupTo;
        GradColorMirror := ColorMirrorSelectedGroup;
        GradColorMirrorTo := ColorMirrorSelectedGroupTo;
        //PenColor := BorderColorSelectedGroup;
        GradU := GradientSelectedGroup;
        GradB := GradientMirrorSelectedGroup;
        TxtClr := TextColorSelectedGroup;
      end;
      }
      if (PageIndex = FHotPageIndex) then
      begin
        PenColor := BorderColorSelectedHot;
        HighLightClr := TabAppearance.HighLightColorSelectedHot;
      end;

      if Assigned(AdvPages[PageIndex].FTimer) then
      begin
        if (AdvPages[PageIndex].FGlowState = gsPush) then
        begin
          GradColor := BlendColor(GradColor, FColorHot, AdvPages[PageIndex].FStepPush);
          GradColorTo := BlendColor(GradColorTo, FColorHotTo, AdvPages[PageIndex].FStepPush);
          GradColorMirror := BlendColor(GradColorMirror, FColorMirrorHot, AdvPages[PageIndex].FStepPush);
          GradColorMirrorTo := BlendColor(GradColorMirrorTo, FColorMirrorHotTo, AdvPages[PageIndex].FStepPush);
          PenColor := BlendColor(PenColor, BorderColorHot, AdvPages[PageIndex].FStepPush);
        end
        else if (AdvPages[PageIndex].FGlowState = gsHover) then
          PenColor := BlendColor(BorderColorSelectedHot, BorderColorSelected, AdvPages[PageIndex].FStepHover);
      end;

      if (FDownPageIndex = PageIndex) and not (csDesigning in ComponentState) then
      begin
        PenColor := BorderColorDown;
        HighLightClr := TabAppearance.HighLightColorDown;
      end;
    end
    else //if State = absUp then
    begin
      if (PageIndex = FHotPageIndex) then
      begin
        GradColor := ColorHot;
        GradColorTo := ColorHotTo;
        GradColorMirror := ColorMirrorHot;
        GradColorMirrorTo := ColorMirrorHotTo;
        PenColor := BorderColorHot;
        GradU := GradientHot;
        GradB := GradientMirrorHot;
        TxtClr := TextColorHot;
        HighLightClr := TabAppearance.HighLightColorHot;
        //DrawDwLn := True;
        if Assigned(AdvPages[PageIndex].FTimer) and (AdvPages[PageIndex].FGlowState = gsHover) then
        begin
          if ShowNonSelectedTabs then
          begin
            GradColor := BlendColor(FColorHot, FColor, AdvPages[PageIndex].FStepHover);
            GradColorTo := BlendColor(FColorHotTo, FColorTo, AdvPages[PageIndex].FStepHover);
            GradColorMirror := BlendColor(FColorMirrorHot, FColorMirror, AdvPages[PageIndex].FStepHover);
            GradColorMirrorTo := BlendColor(FColorMirrorHotTo, FColorMirrorTo, AdvPages[PageIndex].FStepHover);
            PenColor := BlendColor(BorderColorHot, BorderColor, AdvPages[PageIndex].FStepHover);
          end
          else
          begin
            GradColor := BlendColor(FColorHot, FCurrentOfficePagerStyler.TabAppearance.BackGround.Color, AdvPages[PageIndex].FStepHover);
            if (FCurrentOfficePagerStyler.TabAppearance.BackGround.ColorTo <> clNone) then
              GradColorTo := BlendColor(FColorHotTo, FCurrentOfficePagerStyler.TabAppearance.BackGround.ColorTo, AdvPages[PageIndex].FStepHover)
            else
              GradColorTo := BlendColor(FColorHotTo, FCurrentOfficePagerStyler.TabAppearance.BackGround.Color, AdvPages[PageIndex].FStepHover);
            GradColorMirror := BlendColor(FColorMirrorHot, FCurrentOfficePagerStyler.TabAppearance.BackGround.Color, AdvPages[PageIndex].FStepHover);
            GradColorMirrorTo := BlendColor(FColorMirrorHotTo, FCurrentOfficePagerStyler.TabAppearance.BackGround.Color, AdvPages[PageIndex].FStepHover);
            PenColor := BlendColor(BorderColorHot, FCurrentOfficePagerStyler.TabAppearance.BackGround.Color, AdvPages[PageIndex].FStepHover);
          end;
        end;
      end
      else // Normal draw
      begin
        if ShowNonSelectedTabs then
        begin
          GradColor := Color;
          GradColorTo := ColorTo;
          GradColorMirror := ColorMirror;
          GradColorMirrorTo := ColorMirrorTo;
          PenColor := BorderColor;
          GradU := Gradient;
          GradB := GradientMirror;
          TxtClr := TextColor;
          if Assigned(AdvPages[PageIndex].FTimer) and (AdvPages[PageIndex].FGlowState = gsHover) {and (PageIndex = FOldHotPageIndex)} then
          begin
            GradColor := BlendColor(FColorHot, FColor, AdvPages[PageIndex].FStepHover);
            GradColorTo := BlendColor(FColorHotTo, FColorTo, AdvPages[PageIndex].FStepHover);
            GradColorMirror := BlendColor(FColorMirrorHot, FColorMirror, AdvPages[PageIndex].FStepHover);
            GradColorMirrorTo := BlendColor(FColorMirrorHotTo, FColorMirrorTo, AdvPages[PageIndex].FStepHover);
            PenColor := BlendColor(BorderColorHot, BorderColor, AdvPages[PageIndex].FStepHover);
          end;
        end
        else
        begin
          DoRepaint := False;
          TxtClr := TextColor;
          GradU := GradientHot;
          GradB := GradientMirrorHot;

          if not AdvPages[PageIndex].TabEnabled then
           TxtClr := TextColorDisabled;

          if Assigned(AdvPages[PageIndex].FTimer) and (AdvPages[PageIndex].FGlowState = gsHover){ and (PageIndex = FOldHotPageIndex)} then
          begin
            GradColor := BlendColor(FColorHot, FCurrentOfficePagerStyler.TabAppearance.BackGround.Color, AdvPages[PageIndex].FStepHover);
            if (FCurrentOfficePagerStyler.TabAppearance.BackGround.ColorTo <> clNone) then
              GradColorTo := BlendColor(FColorHotTo, FCurrentOfficePagerStyler.TabAppearance.BackGround.ColorTo, AdvPages[PageIndex].FStepHover)
            else
              GradColorTo := BlendColor(FColorHotTo, FCurrentOfficePagerStyler.TabAppearance.BackGround.Color, AdvPages[PageIndex].FStepHover);
            GradColorMirror := BlendColor(FColorMirrorHot, FCurrentOfficePagerStyler.TabAppearance.BackGround.Color, AdvPages[PageIndex].FStepHover);
            GradColorMirrorTo := BlendColor(FColorMirrorHotTo, FCurrentOfficePagerStyler.TabAppearance.BackGround.Color, AdvPages[PageIndex].FStepHover);
            PenColor := BlendColor(BorderColorHot, FCurrentOfficePagerStyler.TabAppearance.BackGround.Color, AdvPages[PageIndex].FStepHover);
            DoRepaint := True;
          end;
        end;
      end;
    end;

    if Focused and (PageIndex = ActivePageIndex) then
    begin
      GradColor := ColorHot;
      GradColorTo := ColorHotTo;
      GradColorMirror := ColorMirrorHot;
      GradColorMirrorTo := ColorMirrorHotTo;
      PenColor := BorderColorSelectedHot;
      GradU := GradientHot;
      GradB := GradientMirrorHot;
      TxtClr := TextColorHot;
      HighLightClr := TabAppearance.HighLightColorSelected;
      SelectedHot := True;
    end;

  {  if FHot then
    begin
      GradColor := FColorHot;
      GradColorTo := FColorHotTo;
      GradColorMirror := FColorMirrorHot;
      GradColorMirrorTo := FColorMirrorHotTo;
      PenColor := BorderColorHot;
      GradU := GradientHot;
      GradB := GradientMirrorHot;
    end
    else
    begin
      GradColor := FColor;
      GradColorTo := FColorTo;
      GradColorMirror := FColorMirror;
      GradColorMirrorTo := FColorMirrorTo;
      PenColor := BorderColor;
      GradU := Gradient;
      GradB := GradientMirror;
    end;

    if FDown then
    begin
      PenColor := BorderColorDown;
      GradU := GradientDown;
      GradB := GradientMirrorDown;
    end;
  }
  (*  if Assigned(FTimer) then
    begin
      if not FDown and not ((State = absExclusive) or ((Style = bsCheck) and (State = absDown))) then
      begin
        GradColor := BlendColor(FColorHot, FColor, FStepHover);
        GradColorTo := BlendColor(FColorHotTo, FColorTo, FStepHover);
        GradColorMirror := BlendColor(FColorMirrorHot, FColorMirror, FStepHover);
        GradColorMirrorTo := BlendColor(FColorMirrorHotTo, FColorMirrorTo, FStepHover);
        PenColor := BlendColor(BorderColorHot, BorderColor, FStepHover);
      end
      else
      begin
        if FDown and (State <> absExclusive) then
        begin
          GradColor := BlendColor(FColorDown, FColorHot, FStepPush);
          GradColorTo := BlendColor(FColorDownTo, FColorHotTo, FStepPush);
          GradColorMirror := BlendColor(FColorMirrorDown, FColorMirrorHot, FStepPush);
          GradColorMirrorTo := BlendColor(FColorMirrorDownTo, FColorMirrorHotTo, FStepPush);
          PenColor := BlendColor(BorderColorDown, BorderColorHot, FStepPush);
        end;
      end;
    end;   *)

  {  if Enabled or (DisabledImages = nil) then
    begin
      ImgList := Images;
      EnabledImg := Enabled;
    end
    else
    begin
      ImgList := DisabledImages;
      EnabledImg := True;
    end;

    if Enabled or DisabledPicture.Empty then
      Pic := Picture
    else
      Pic := DisabledPicture;


    if (ImgList = nil) then
    begin
      ImgList := FInternalImages;
      EnabledImg := True;
    end;

    if ShowCaption then
      DCaption := Caption
    else
      DCaption := '';
    }
    DCaption := AdvPages[PageIndex].Caption;
    WCaption := AdvPages[PageIndex].WideCaption;
    {Canvas.Font.Name := 'Tahoma';
    Canvas.Font.Size := 8;
    Canvas.Font.Style := []; }
    Canvas.Font.Assign(TabAppearance.Font);
    Canvas.Font.Color := TxtClr;

    if DoRepaint then
    begin
      Shape := TabSettings.Shape;
      RotateLR := True;
      TabPos := TabPosition;
      if (TabPos in [tpLeft, tpRight]) and not RotateTabLeftRight then
      begin
        TabPos := tpTop;
        RotateLR := False;
        Shape := tsRectangle;
      end;
      if (ActivePageIndex = PageIndex) and (CloseOnTab) and (ButtonSettings.CloseButton) then
      begin
        bmp := TBitmap.Create;
        bmp.Height := R.Bottom - R.Top;
        bmp.Width := R.Right - R.Left;
        R3 := Rect(0, 0, R.Right - R.Left, R.Bottom-R.Top);
        if UseOldDrawing then
          DrawVistaGradient(bmp.Canvas, Rect(0, 0, R.Right - R.Left, R.Bottom-R.Top),GradColor, GradColorTo, GradColorMirror, GradColorMirrorTo, PenColor,
            GradU, GradB, '', {Canvas.}Font, Layout, Enabled, False, FAntiAlias, True{FCurrentToolBarStyler.RoundEdges}, RotateLR, TabPos)
        else
        begin
          case TabPosition of
            tpTop: R3.Bottom := R3.Bottom - 3;
            tpBottom: R3.Top := R3.Top + 2;
            tpLeft: R3.Right := R3.Right - 3;
            tpRight: R3.Left := R3.Left + 2;
          end;

          TempClr := BlendColor(PenColor, clWhite, 50);
          bmp.Canvas.Brush.Color := TempClr;
          bmp.Canvas.FillRect(R3);
          case TabPosition of
            tpTop: R3.Right := R3.Right - 1;
            tpBottom:
            begin
              R3.Right := R3.Right - 1;
              R3.Bottom := R3.Bottom - 1;
            end;
            tpLeft: R3.Bottom := R3.Bottom - 1;
            tpRight:
            begin
              R3.Right := R3.Right - 1;
              R3.Bottom := R3.Bottom - 2;
            end;
          end;
          DrawVistaTab(bmp.Canvas, R3, GradColor, GradColorTo, GradColorMirror, GradColorMirrorTo, PenColor,
            GradU, GradB, Enabled, Shape, False, TabSettings.Rounding, RotateTabLeftRight, TabPosition);
          bmp.TransparentColor := TempClr;
          bmp.Transparent := True;  
        end;

        Canvas.Draw(R.Left, R.Top, bmp);
        bmp.Free;
      end
      else
      begin
        if UseOldDrawing then
          DrawVistaGradient(Canvas, R,GradColor, GradColorTo, GradColorMirror, GradColorMirrorTo, PenColor,
           GradU, GradB, '', {Canvas.}Font, Layout, Enabled, False, FAntiAlias, True{FCurrentToolBarStyler.RoundEdges}, RotateLR, TabPos)
        else
        begin
          R3 := R;
          case TabPosition of
            tpTop: R3.Bottom := R3.Bottom - 3;
            tpBottom: R3.Top := R3.Top + 2;
            tpLeft: R3.Right := R3.Right - 3;
            tpRight: R3.Left := R3.Left + 2;
          end;

          DrawVistaTab(Canvas, R3,GradColor, GradColorTo, GradColorMirror, GradColorMirrorTo, PenColor, GradU, GradB,
            Enabled, Shape, False, TabSettings.Rounding, RotateTabLeftRight, TabPosition);
        end;

        //DrawVistaButton(Canvas, R,GradColor, GradColorTo, GradColorMirror, GradColorMirrorTo, PenColor,
         // GradU, GradB, DCaption, {Canvas.}Font, nil, -1, True, blGlyphLeft, False, False, Enabled, False, dpRight, aaAntiAlias, True);
      end;

      if UseOldDrawing then
      begin
        case TabPosition of
          tpTop:
          begin
            if True{FCurrentOfficePagerStyler.RoundEdges} then
            begin
              Canvas.Pixels[R.Left, R.Top] := Canvas.Pixels[R.Left - 1, R.Top - 1];
              Canvas.Pixels[R.Left + 1, R.Top] := Canvas.Pixels[R.Left + 1, R.Top - 1];
              Canvas.Pixels[R.Left, R.Top + 1] := Canvas.Pixels[R.Left - 1, R.Top];

              Canvas.Pixels[R.Right - 1, R.Top] := Canvas.Pixels[R.Right + 1, R.Top];
              Canvas.Pixels[R.Right - 2, R.Top] := Canvas.Pixels[R.Right + 1, R.Top];
              Canvas.Pixels[R.Right - 1, R.Top + 1] := Canvas.Pixels[R.Right + 1, R.Top];
            end;

            //--- Draw 3D effect
            if not Assigned(AdvPages[PageIndex].FTimer) then
            begin
              if SelectedHot then
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20)
              else
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 50);
              Canvas.MoveTo(R.Left+3, R.Top + 3);
              Canvas.LineTo(R.Right-3, R.Top+3);
            end
            else
            begin
              if (AdvPages[PageIndex].FGlowState = gsHover) then
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20) //Min(20, AdvPages[PageIndex].FStepHover))
              else
              begin
                if SelectedHot then
                  Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20)
                else
                  Canvas.Pen.Color := BlendColor(clWhite, GradColor, 50);
              end;
              Canvas.MoveTo(R.Left+3, R.Top + 3);
              Canvas.LineTo(R.Right-3, R.Top+3);
            end;

            //-- Draw Shadow
            if (TabAppearance.ShadowColor <> clNone) then
            begin
              Canvas.Pen.Color := TabAppearance.ShadowColor;
              Canvas.MoveTo(R.Right, R.Top + 3);
              Canvas.LineTo(R.Right, R.Bottom-4);
              Canvas.Pen.Color := BlendColor(TabAppearance.ShadowColor, TabAppearance.BackGround.Color, 40);
              Canvas.MoveTo(R.Right + 1, R.Top + 4);
              Canvas.LineTo(R.Right + 1, R.Bottom-4);
            end;

            if (HighLightClr <> clNone) then
            begin
              Canvas.Pen.Color := BlendColor(GradColor, PenColor, 80);
              Canvas.MoveTo(R.Left+3, R.Top+1);
              Canvas.LineTo(R.Right-3, R.Top+1);
              Canvas.Pen.Color := HighLightClr; //BlendColor(GradColor, PenColor, FCurrentOfficePagerStyler.BlendFactor);
              Canvas.MoveTo(R.Left+1, R.Top + 3);
              Canvas.LineTo(R.Left+1, R.Bottom-5);
              Canvas.MoveTo(R.Right-2, R.Top + 3);
              Canvas.LineTo(R.Right-2, R.Bottom-5);
            end;
          end;
          tpBottom:
          begin
            if True{FCurrentOfficePagerStyler.RoundEdges} then
            begin
              Canvas.Pixels[R.Left, R.Bottom-2] := Canvas.Pixels[R.Left - 1, R.Bottom - 1];
              Canvas.Pixels[R.Left + 1, R.Bottom-1] := Canvas.Pixels[R.Left - 1, R.Bottom - 1];
              Canvas.Pixels[R.Left, R.Bottom - 1] := Canvas.Pixels[R.Left - 1, R.Bottom -1];

              Canvas.Pixels[R.Right - 1, R.Bottom-1] := Canvas.Pixels[R.Right + 1, R.Bottom];
              Canvas.Pixels[R.Right - 2, R.Bottom-1] := Canvas.Pixels[R.Right + 1, R.Bottom];
              Canvas.Pixels[R.Right - 1, R.Bottom - 2] := Canvas.Pixels[R.Right + 1, R.Bottom];
            end;

            //--- Draw 3D effect
            if not Assigned(AdvPages[PageIndex].FTimer) then
            begin
              if SelectedHot then
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20)
              else
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 50);
              Canvas.MoveTo(R.Left+3, R.Bottom - 3);
              Canvas.LineTo(R.Right-3, R.Bottom - 3);
            end
            else
            begin
              if (AdvPages[PageIndex].FGlowState = gsHover) then
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20) //Min(20, AdvPages[PageIndex].FStepHover))
              else
              begin
                if SelectedHot then
                  Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20)
                else
                  Canvas.Pen.Color := BlendColor(clWhite, GradColor, 50);
              end;
              Canvas.MoveTo(R.Left+3, R.Bottom - 3);
              Canvas.LineTo(R.Right-3, R.Bottom - 3);
            end;

            if (TabAppearance.ShadowColor <> clNone) then
            begin
              Canvas.Pen.Color := TabAppearance.ShadowColor;
              Canvas.MoveTo(R.Right, R.Top + 4);
              Canvas.LineTo(R.Right, R.Bottom-2);
              Canvas.Pen.Color := BlendColor(TabAppearance.ShadowColor, TabAppearance.BackGround.Color, 40);
              Canvas.MoveTo(R.Right + 1, R.Top + 4);
              Canvas.LineTo(R.Right + 1, R.Bottom-3);
            end;

            if (HighLightClr <> clNone) then
            begin
              Canvas.Pen.Color := BlendColor(GradColor, PenColor, 80);
              Canvas.MoveTo(R.Left+3, R.Bottom -2);
              Canvas.LineTo(R.Right-3, R.Bottom -2);
              Canvas.Pen.Color := HighLightClr; //BlendColor(GradColor, PenColor, FCurrentOfficePagerStyler.BlendFactor);
              Canvas.MoveTo(R.Left+1, R.Bottom - 3);
              Canvas.LineTo(R.Left+1, R.Top + 5);
              Canvas.MoveTo(R.Right-2, R.Bottom - 3);
              Canvas.LineTo(R.Right-2, R.Top + 5);
            end;
          end;
          tpLeft:
          begin
            if True{FCurrentOfficePagerStyler.RoundEdges} then
            begin
              Canvas.Pixels[R.Left, R.Top] := Canvas.Pixels[R.Left - 1, R.Top - 1];
              Canvas.Pixels[R.Left + 1, R.Top] := Canvas.Pixels[R.Left + 1, R.Top - 1];
              Canvas.Pixels[R.Left, R.Top + 1] := Canvas.Pixels[R.Left - 1, R.Top];

              Canvas.Pixels[R.Left, R.Bottom-1] := Canvas.Pixels[R.Left - 1, R.Bottom];
              Canvas.Pixels[R.Left + 1, R.Bottom-1] := Canvas.Pixels[R.Left - 1, R.Bottom];
              Canvas.Pixels[R.Left, R.Bottom - 2] := Canvas.Pixels[R.Left - 1, R.Bottom];
            end;

            //--- Draw 3D effect
            if not Assigned(AdvPages[PageIndex].FTimer) then
            begin
              if SelectedHot then
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20)
              else
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 50);

              if RotateTabLeftRight then
              begin
                Canvas.MoveTo(R.Left+3, R.Top + 3);
                Canvas.LineTo(R.Left+3, R.Bottom - 3);
              end
              else
              begin
                Canvas.MoveTo(R.Left+3, R.Top + 3);
                Canvas.LineTo(R.Right-5, R.Top + 3);
              end;
            end
            else
            begin
              if (AdvPages[PageIndex].FGlowState = gsHover) then
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20) //Min(20, AdvPages[PageIndex].FStepHover))
              else
              begin
                if SelectedHot then
                  Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20)
                else
                  Canvas.Pen.Color := BlendColor(clWhite, GradColor, 50);
              end;

              if RotateTabLeftRight then
              begin
                Canvas.MoveTo(R.Left+3, R.Top + 3);
                Canvas.LineTo(R.Left+3, R.Bottom - 3);
              end
              else
              begin
                Canvas.MoveTo(R.Left+3, R.Top + 3);
                Canvas.LineTo(R.Right-5, R.Top + 3);
              end
            end;

            //--- Draw Shadow
            if RotateTabLeftRight then
            begin
              if (TabAppearance.ShadowColor <> clNone) then
              begin
                Canvas.Pen.Color := TabAppearance.ShadowColor;
                Canvas.MoveTo(R.Left + 3, R.Top - 1);
                Canvas.LineTo(R.Right, R.Top - 1);
                Canvas.Pen.Color := BlendColor(TabAppearance.ShadowColor, TabAppearance.BackGround.Color, 40);
                Canvas.MoveTo(R.Left + 4, R.Top - 2);
                Canvas.LineTo(R.Right, R.Top - 2);
              end;
            end
            else
            begin
              if (TabAppearance.ShadowColor <> clNone) then
              begin
                Canvas.Pen.Color := TabAppearance.ShadowColor;
                Canvas.MoveTo(R.Left + 3, R.Bottom);
                Canvas.LineTo(R.Right, R.Bottom);
                Canvas.Pen.Color := BlendColor(TabAppearance.ShadowColor, TabAppearance.BackGround.Color, 40);
                Canvas.MoveTo(R.Left + 4, R.Bottom + 1);
                Canvas.LineTo(R.Right, R.Bottom + 1);
              end;
            end;

            if (HighLightClr <> clNone) then
            begin
              Canvas.Pen.Color := BlendColor(GradColor, PenColor, 80);
              Canvas.MoveTo(R.Left+1, R.Top+3);
              Canvas.LineTo(R.Left+1, R.Bottom-3);
              Canvas.Pen.Color := HighLightClr; //BlendColor(GradColor, PenColor, FCurrentOfficePagerStyler.BlendFactor);
              Canvas.MoveTo(R.Left+3, R.Top + 1);
              Canvas.LineTo(R.Right-5, R.Top+1);
              Canvas.MoveTo(R.Left+3, R.Bottom-2);
              Canvas.LineTo(R.Right-5, R.Bottom-2);
            end;
          end;
          tpRight:
          begin
            if True{FCurrentOfficePagerStyler.RoundEdges} then
            begin
              Canvas.Pixels[R.Right, R.Top] := Canvas.Pixels[R.Right + 1, R.Top - 1];
              Canvas.Pixels[R.Right - 1, R.Top] := Canvas.Pixels[R.Right + 1, R.Top - 1];
              Canvas.Pixels[R.Right, R.Top + 1] := Canvas.Pixels[R.Right + 1, R.Top];

              Canvas.Pixels[R.Right, R.Bottom-1] := Canvas.Pixels[R.Right + 1, R.Bottom];
              Canvas.Pixels[R.Right - 1, R.Bottom-1] := Canvas.Pixels[R.Right + 1, R.Bottom];
              Canvas.Pixels[R.Right, R.Bottom - 2] := Canvas.Pixels[R.Right + 1, R.Bottom];
            end;

            //--- Draw 3D effect
            if not Assigned(AdvPages[PageIndex].FTimer) then
            begin
              if SelectedHot then
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20)
              else
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 50);

              if RotateTabLeftRight then
              begin
                Canvas.MoveTo(R.Right-3, R.Top + 3);
                Canvas.LineTo(R.Right-3, R.Bottom - 3);
              end
              else
              begin
                Canvas.MoveTo(R.Left+5, R.Top + 3);
                Canvas.LineTo(R.Right-3, R.Top + 3);
              end;
            end
            else
            begin
              if (AdvPages[PageIndex].FGlowState = gsHover) then
                Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20) //Min(20, AdvPages[PageIndex].FStepHover))
              else
              begin
                if SelectedHot then
                  Canvas.Pen.Color := BlendColor(clWhite, GradColor, 20)
                else
                  Canvas.Pen.Color := BlendColor(clWhite, GradColor, 50);
              end;

              if RotateTabLeftRight then
              begin
                Canvas.MoveTo(R.Right-3, R.Top + 3);
                Canvas.LineTo(R.Right-3, R.Bottom - 3);
              end
              else
              begin
                Canvas.MoveTo(R.Left+5, R.Top + 3);
                Canvas.LineTo(R.Right-3, R.Top + 3);
              end;
            end;

            //-- Draw Shadow
            if (TabAppearance.ShadowColor <> clNone) then
            begin
              Canvas.Pen.Color := TabAppearance.ShadowColor;
              Canvas.MoveTo(R.Left + 3, R.Bottom);
              Canvas.LineTo(R.Right - 3, R.Bottom);
              Canvas.Pen.Color := BlendColor(TabAppearance.ShadowColor, TabAppearance.BackGround.Color, 40);
              Canvas.MoveTo(R.Left + 4, R.Bottom + 1);
              Canvas.LineTo(R.Right - 4, R.Bottom + 1);
            end;

            if (HighLightClr <> clNone) then
            begin
              Canvas.Pen.Color := BlendColor(GradColor, PenColor, 80);
              Canvas.MoveTo(R.Right-2, R.Top+3);
              Canvas.LineTo(R.Right-2, R.Bottom-3);
              Canvas.Pen.Color := HighLightClr; //BlendColor(GradColor, PenColor, FCurrentOfficePagerStyler.BlendFactor);
              Canvas.MoveTo(R.Left+5, R.Top + 1);
              Canvas.LineTo(R.Right-3, R.Top+1);
              Canvas.MoveTo(R.Left+5, R.Bottom-2);
              Canvas.LineTo(R.Right-3, R.Bottom-2);
            end;
          end;
        end;
      end;

    end;

    if Assigned(FOnDrawTab) then
    begin
      FOnDrawTab(Self, PageIndex, R);
      Exit;
    end;

    if not UseOldDrawing then
    begin
      if TabPosition in [tpTop, tpBottom] then
      begin
        R.Left := R.Left + GetLeftRoundingOffset;
      end
      else if RotateTabLeftRight then
      begin
        if TabPosition = tpLeft then
          R.Bottom := R.Bottom - GetLeftRoundingOffset
        else
        begin
          if TabSettings.Shape in [tsLeftRamp, tsLeftRightRamp] then
            R.Top := R.Top + GetLeftRoundingOffset;
        end;
      end;
    end;

    if (TabSettings.Width > 0) then
      GetCloseBtnImageAndTextRect(PageIndex, cbr, TR, ImgP);

    case TabPosition of
      tpTop, tpBottom:
      begin
        CapR := Rect(R.Left + FTabSettings.LeftMargin, R.Top, R.Right, R.Bottom);
        if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex <> PageIndex) and AdvPages[PageIndex].ShowClose) then
          CapR.Left := CapR.Left + (PAGEBUTTON_SIZE + 4 ) div 2
        else if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex = PageIndex) and AdvPages[PageIndex].ShowClose) and (CloseOnTabPosition = cpLeft) and (TabSettings.Alignment <> taCenter) then
          CapR.Left := CapR.Left + PAGEBUTTON_SIZE + 4;
      end;
      tpLeft:
      begin
        if RotateTabLeftRight then
        begin
          CapR := Rect(R.Left, R.Top, R.Right, R.Bottom - FTabSettings.LeftMargin);
          if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex <> PageIndex) and AdvPages[PageIndex].ShowClose) then
            CapR.Bottom := CapR.Bottom - (PAGEBUTTON_SIZE + 4) div 2
          else if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex = PageIndex) and AdvPages[PageIndex].ShowClose) and (CloseOnTabPosition = cpLeft) and (TabSettings.Alignment <> taCenter) then
            CapR.Bottom := CapR.Bottom - PAGEBUTTON_SIZE - 4;
        end
        else
        begin
          CapR := Rect(R.Left + FTabSettings.LeftMargin, R.Top, R.Right, R.Bottom);
          if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex = PageIndex) and AdvPages[PageIndex].ShowClose) and (CloseOnTabPosition = cpLeft) and (TabSettings.Alignment <> taCenter) then
            CapR.Left := CapR.Left + PAGEBUTTON_SIZE + 4
          else if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex = PageIndex) and AdvPages[PageIndex].ShowClose) and (CloseOnTabPosition = cpRight) and ((TabSettings.Width <= 0) or (TabSettings.Alignment <> taCenter)) then
            CapR.Right := CapR.Right - (PAGEBUTTON_SIZE + 4)
        end;
      end;
      tpRight:
      begin
        if RotateTabLeftRight then
        begin
          CapR := Rect(R.Left, R.Top + FTabSettings.LeftMargin, R.Right, R.Bottom);
          if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex <> PageIndex) and AdvPages[PageIndex].ShowClose) then
            CapR.Top := CapR.Top + (PAGEBUTTON_SIZE + 4) div 2
          else if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex = PageIndex) and AdvPages[PageIndex].ShowClose) and (CloseOnTabPosition = cpLeft) and (TabSettings.Alignment <> taCenter) then
            CapR.Top := CapR.Top + PAGEBUTTON_SIZE + 4;
        end
        else
        begin
          CapR := Rect(R.Left + FTabSettings.LeftMargin + 3, R.Top, R.Right, R.Bottom);
          //if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex <> PageIndex)) then
            //CapR.Top := CapR.Top + (PAGEBUTTON_SIZE+3) div 2;
          if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex = PageIndex) and AdvPages[PageIndex].ShowClose) and (CloseOnTabPosition = cpLeft) and (TabSettings.Alignment <> taCenter) then
            CapR.Left := CapR.Left + PAGEBUTTON_SIZE + 5
          else if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex = PageIndex) and AdvPages[PageIndex].ShowClose) and (CloseOnTabPosition = cpRight) and ((TabSettings.Width <= 0) or (TabSettings.Alignment <> taCenter)) then
            CapR.Right := CapR.Right - (PAGEBUTTON_SIZE + 4)
        end;
      end;
    end;

    if AdvPages[PageIndex].Enabled or AdvPages[PageIndex].DisabledPicture.Empty then
      Pic := AdvPages[PageIndex].Picture
    else
      Pic := AdvPages[PageIndex].DisabledPicture;

    if Assigned(Pic) and not Pic.Empty then
    begin
      Pic.GetImageSizes;
      ImgW := Pic.Width;
      ImgH := Pic.Height;

      ImgY := CapR.Top;
      ImgX := CapR.Left;
      case TabPosition of
        tpTop, tpBottom:
        begin
          case TabSettings.ImagePosition of
            ipTop:
            begin
              ImgX := R.Left + ((R.Right - R.Left) - ImgW) div 2;
              ImgY := CapR.Top;
              CapR.Top := CapR.Top + ImgH{ + ImgTxtSp};
            end;
            ipBottom:
            begin
              ImgX := R.Left + ((R.Right - R.Left) - ImgW) div 2;
              ImgY := CapR.Bottom - ImgH;
              CapR.Bottom := CapR.Bottom - ImgH;
            end;
            ipLeft:
            begin
              if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                ImgX := ImgP.X
              else
                ImgX := CapR.Left;
              CapR.Left := CapR.Left + ImgW + ImgTxtSp;
              ImgY := R.Top + ((R.Bottom - R.Top) - ImgH) div 2;
            end;
            ipRight:
            begin
              if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                ImgX := ImgP.X
              else
                ImgX := CapR.Right - ImgW - FTabSettings.RightMargin;
              CapR.Right := ImgX - ImgTxtSp;
              if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex = PageIndex) and AdvPages[PageIndex].ShowClose) and (CloseOnTabPosition = cpRight) and not ((TabSettings.Width > 0) and (TabSettings.Alignment = taCenter)) then
                ImgX := ImgX - PAGEBUTTON_SIZE;

              ImgY := R.Top + ((R.Bottom - R.Top) - ImgH) div 2;
            end;
          end;
        end;
        tpLeft:
        begin
          if not RotateTabLeftRight then
          begin
            case TabSettings.ImagePosition of
              ipTop:
              begin
                ImgX := R.Left + ((R.Right - R.Left) - ImgW) div 2;
                ImgY := CapR.Top;
                CapR.Top := CapR.Top + ImgH;
              end;
              ipBottom:
              begin
                ImgX := R.Left + ((R.Right - R.Left) - ImgW) div 2;
                ImgY := CapR.Bottom - ImgH;
                CapR.Bottom := CapR.Bottom - ImgH;
              end;
              ipLeft:
              begin
                if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                  ImgX := ImgP.X
                else
                  ImgX := CapR.Left;
                CapR.Left := CapR.Left + ImgW + ImgTxtSp;
                ImgY := R.Top + ((R.Bottom - R.Top) - ImgH) div 2;
              end;
              ipRight:
              begin
                if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                  ImgX := ImgP.X
                else
                ImgX := CapR.Right - ImgW - FTabSettings.RightMargin;
                CapR.Right := ImgX - ImgTxtSp;
                ImgY := R.Top + ((R.Bottom - R.Top) - ImgH) div 2;
              end;
            end;
          end
          else
          begin
            case TabSettings.ImagePosition of
              ipTop:
              begin
                ImgY := R.Top + ((R.Bottom - R.Top) - ImgH) div 2;
                ImgX := CapR.Left;
                CapR.Left := CapR.Left + ImgW;
              end;
              ipBottom:
              begin
                ImgY := R.Top + ((R.Bottom - R.Top) - ImgH) div 2;
                ImgX := CapR.Right - ImgW;
                CapR.Right := CapR.Right - ImgW;
              end;
              ipLeft:
              begin
                ImgX := R.Left + ((R.Right - R.Left) - ImgW) div 2;
                if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                  ImgY := ImgP.Y
                else
                  ImgY := CapR.Bottom - ImgH;
                CapR.Bottom := ImgY - ImgTxtSp;
              end;
              ipRight:
              begin
                ImgX := R.Left + ((R.Right - R.Left) - ImgW) div 2;
                if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                  ImgY := ImgP.Y
                else
                  ImgY := CapR.Top + TabSettings.RightMargin;
                CapR.Top := ImgY + ImgTxtSp;
              end;
            end;
          end;
        end;
        tpRight:
        begin
          if not RotateTabLeftRight then
          begin
            case TabSettings.ImagePosition of
              ipTop:
              begin
                ImgX := R.Left + ((R.Right - R.Left) - ImgW) div 2;
                ImgY := CapR.Top;
                CapR.Top := CapR.Top + ImgH;
              end;
              ipBottom:
              begin
                ImgX := R.Left + ((R.Right - R.Left) - ImgW) div 2;
                ImgY := CapR.Bottom - ImgH;
                CapR.Bottom := CapR.Bottom - ImgH;
              end;
              ipLeft:
              begin
                if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                  ImgX := ImgP.X
                else
                  ImgX := CapR.Left;
                CapR.Left := CapR.Left + ImgW + ImgTxtSp;
                ImgY := R.Top + ((R.Bottom - R.Top) - ImgH) div 2;
              end;
              ipRight:
              begin
                ImgX := CapR.Right - ImgW;
                CapR.Right := ImgX - ImgTxtSp;
                ImgY := R.Top + ((R.Bottom - R.Top) - ImgH) div 2;
              end;
            end;
          end
          else
          begin
            case TabSettings.ImagePosition of
              ipTop:
              begin
                ImgY := R.Top + ((R.Bottom - R.Top) - ImgH) div 2;
                ImgX := CapR.Right - ImgW;
                CapR.Right := CapR.Right - ImgW;
              end;
              ipBottom:
              begin
                ImgY := R.Top + ((R.Bottom - R.Top) - ImgH) div 2;
                ImgX := CapR.Left;
                CapR.Left := CapR.Left + ImgW;
              end;
              ipLeft:
              begin
                ImgX := R.Left + ((R.Right - R.Left) - ImgW) div 2;
                if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                  ImgY := ImgP.Y
                else
                  ImgY := CapR.Top;
                CapR.Top := CapR.Top + ImgH + ImgTxtSp;
              end;
              ipRight:
              begin
                ImgX := R.Left + ((R.Right - R.Left) - ImgW) div 2;
                if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                  ImgY := ImgP.Y
                else
                  ImgY := CapR.Bottom - ImgH - TabSettings.RightMargin;
                CapR.Bottom := ImgY - ImgTxtSp;
              end;
            end;
          end;
        end;
      end;
      //Canvas.Draw(ImgX, ImgY, Pic);
    end
    else
    if (Assigned(FImages) or Assigned(DisabledImages)) and (AdvPages[PageIndex].ImageIndex >= 0) then
    begin

      if AdvPages[PageIndex].Enabled then
      begin
        if Assigned(FImages) then
          ImgList := FImages;

        ImgEnabled := AdvPages[PageIndex].TabEnabled;
      end
      else
      begin
        if Assigned(FDisabledImages) then
          ImgList := FDisabledImages
        else if Assigned(FImages) then
        begin
          ImgList := FImages;
          ImgEnabled := False;
        end;
      end;

      if (ImgList <> nil) then
      begin
        ImgY := CapR.Top;
        ImgX := CapR.Left;

        case TabPosition of
          tpTop, tpBottom:
          begin
            case TabSettings.ImagePosition of
              ipTop:
              begin
                ImgX := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
                ImgY := CapR.Top;
                CapR.Top := CapR.Top + ImgList.Height{ + ImgTxtSp};
              end;
              ipBottom:
              begin
                ImgX := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
                ImgY := CapR.Bottom - ImgList.Height;
                CapR.Bottom := CapR.Bottom - ImgList.Height;
              end;
              ipLeft:
              begin
                if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                  ImgX := ImgP.X
                else
                  ImgX := CapR.Left;
                CapR.Left := CapR.Left + ImgList.Width + ImgTxtSp;
                ImgY := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
              end;
              ipRight:
              begin
                if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                  ImgX := ImgP.X
                else
                  ImgX := CapR.Right - ImgList.Width - FTabSettings.RightMargin;
                CapR.Right := ImgX - ImgTxtSp;
                if (ButtonSettings.CloseButton and CloseOnTab and (ActivePageIndex = PageIndex) and AdvPages[PageIndex].ShowClose) and (CloseOnTabPosition = cpRight) and not ((TabSettings.Width > 0) and (TabSettings.Alignment = taCenter)) then
                  ImgX := ImgX - PAGEBUTTON_SIZE;
                ImgY := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
              end;
            end;
          end;
          tpLeft:
          begin
            if not RotateTabLeftRight then
            begin
              case TabSettings.ImagePosition of
                ipTop:
                begin
                  ImgX := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
                  ImgY := CapR.Top;
                  CapR.Top := CapR.Top + ImgList.Height{ + ImgTxtSp};
                end;
                ipBottom:
                begin
                  ImgX := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
                  ImgY := CapR.Bottom - ImgList.Height;
                  CapR.Bottom := CapR.Bottom - ImgList.Height;
                end;
                ipLeft:
                begin
                  if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                    ImgX := ImgP.X
                  else
                    ImgX := CapR.Left;
                  CapR.Left := CapR.Left + ImgList.Width + ImgTxtSp;
                  ImgY := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
                end;
                ipRight:
                begin
                  if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                    ImgX := ImgP.X
                  else
                    ImgX := CapR.Right - ImgList.Width - FTabSettings.RightMargin;
                  CapR.Right := ImgX - ImgTxtSp;
                  ImgY := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
                end;
              end;
            end
            else
            begin
              case TabSettings.ImagePosition of
                ipTop:
                begin
                  ImgY := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
                  ImgX := CapR.Left;
                  CapR.Left := CapR.Left + ImgList.Width;
                end;
                ipBottom:
                begin
                  ImgY := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
                  ImgX := CapR.Right - ImgList.Width;
                  CapR.Right := CapR.Right - ImgList.Width;
                end;
                ipLeft:
                begin
                  ImgX := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
                  if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                    ImgY := ImgP.Y
                  else
                    ImgY := CapR.Bottom - ImgList.Height;
                  CapR.Bottom := ImgY - ImgTxtSp;
                end;
                ipRight:
                begin
                  ImgX := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
                  if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                    ImgY := ImgP.Y
                  else
                    ImgY := CapR.Top + TabSettings.RightMargin;
                  CapR.Top := ImgY + ImgTxtSp;
                end;
              end;
            end;
          end;
          tpRight:
          begin
            if not RotateTabLeftRight then
            begin
              case TabSettings.ImagePosition of
                ipTop:
                begin
                  ImgX := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
                  ImgY := CapR.Top;
                  CapR.Top := CapR.Top + ImgList.Height;
                end;
                ipBottom:
                begin
                  ImgX := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
                  ImgY := CapR.Bottom - ImgList.Height;
                  CapR.Bottom := CapR.Bottom - ImgList.Height;
                end;
                ipLeft:
                begin
                  if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                    ImgX := ImgP.X
                  else
                    ImgX := CapR.Left;
                  CapR.Left := CapR.Left + ImgList.Width + ImgTxtSp;
                  ImgY := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
                end;
                ipRight:
                begin
                  if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                    ImgX := ImgP.X
                  else
                    ImgX := CapR.Right - ImgList.Width;
                  CapR.Right := ImgX - ImgTxtSp;
                  ImgY := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
                end;
              end;
            end
            else
            begin
              case TabSettings.ImagePosition of
                ipTop:
                begin
                  ImgY := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
                  ImgX := CapR.Right - ImgList.Width;
                  CapR.Right := CapR.Right - ImgList.Width;
                end;
                ipBottom:
                begin
                  ImgY := R.Top + ((R.Bottom - R.Top) - ImgList.Height) div 2;
                  ImgX := CapR.Left;
                  CapR.Left := CapR.Left + ImgList.Width;
                end;
                ipLeft:
                begin
                  ImgX := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
                  if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                    ImgY := ImgP.Y
                  else
                    ImgY := CapR.Top;
                  CapR.Top := CapR.Top + ImgList.Height + ImgTxtSp;
                end;
                ipRight:
                begin
                  ImgX := R.Left + ((R.Right - R.Left) - ImgList.Width) div 2;
                  if (TabSettings.Width > 0) and (TabSettings.Alignment = taCenter) then
                    ImgY := ImgP.Y
                  else
                    ImgY := CapR.Bottom - ImgList.Height - TabSettings.RightMargin;
                  CapR.Bottom := ImgY - ImgTxtSp;
                end;
              end;
            end;
          end;
        end;

        ImgList.Draw(Canvas, ImgX, ImgY, AdvPages[PageIndex].ImageIndex, ImgEnabled);
        ImgList := nil;
      end;


    end;

    Canvas.Brush.Style := bsClear;
    Canvas.Font.Color := TxtClr;
    if (not RotateTabLeftRight and (TabPosition in [tpLeft, tpRight])) then
    begin
      CapR2 := CapR;
      AAlign := taLeftJustify;
      if (TabSettings.Width <> 0) then
      begin
        case TabSettings.Alignment of
          taLeftJustify:
          begin
            AAlign := taLeftJustify;
          end;
          taCenter:
          begin
            AAlign := taCenter;
            //CapR2.Left := TR.Left;
          end;
          taRightJustify:
          begin
            AAlign := taRightJustify;
            CapR2.Right := CapR.Right - 3;
          end;
        end;
      end
      else
      begin
        if TabSettings.ImagePosition in [ipTop,ipBottom] then
        begin
          AAlign := taCenter;
          if (TabPosition = tpLeft) then
          begin
            CapR2.Left := CapR2.Left - FTabSettings.LeftMargin;
            CapR2.Right := CapR2.Right - 3;
          end;
        end
        else
          AAlign := taLeftJustify;
      end;

      TxtR := DrawVistaText(Canvas, AAlign, CapR2, DCaption, WCaption, Canvas.Font, AdvPages[PageIndex].Enabled, True, FAntiAlias, tpTop, Ellipsis, TabSettings.WordWrap);
    end
    else
    if (TabPosition = tpLeft) then
    begin
      if (DCaption <> '') or (WCaption <> '') then
      begin
        CapR2 := CapR;
        TxtR.Left := CapR.Left + ((CapR.Right - CapR.Left)-Canvas.TextHeight('gh')) div 2;
        if (TabSettings.Width <> 0) then
        begin
          case TabSettings.Alignment of
            taCenter: CapR2.Bottom := TR.Bottom;
            taRightJustify: CapR2.Bottom := TR.Bottom;
          end;  
        end;
          
        TxtR.Top := CapR.Bottom;
        TxtR.Right := TxtR.Left + Canvas.TextHeight('gh');
        if (DCaption <> '') then
          TxtR.Bottom := TxtR.Top + Canvas.TextWidth(DCaption)
        else
          TxtR.Bottom := TxtR.Top + WideCanvasTextWidth(Canvas, WCaption);

        // Make sure to use a truetype font!
        // Font.Name := 'Tahoma';

        tf := TFont.Create;
        try
          if (TabPosition = tpLeft) or (TabPosition = tpRight) then
          begin
{$IFNDEF TMSDOTNET}
            FillChar(lf, SizeOf(lf), 0);
{$ENDIF}
            tf.Assign(Canvas.Font);
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
        if (DCaption <> '') then
        begin
          DCaption := TrimText(DCaption, CapR, False, nil, Canvas, nil, nil, Ellipsis, TabPosition, TabSettings.WordWrap);
          Canvas.TextOut(CapR.Left + ((CapR.Right - CapR.Left)-Canvas.TextHeight('gh')) div 2, CapR2.Bottom, DCaption);
        end
        else
        begin
          WCaption := TrimTextW(WCaption, CapR, False, nil, Canvas, nil, nil, Ellipsis, TabPosition, TabSettings.WordWrap);
          TextOutW(Canvas.Handle, CapR.Left + ((CapR.Right - CapR.Left)-Canvas.TextHeight('gh')) div 2, CapR2.Bottom, PWideChar(WCaption), Length(WCaption));
        end;
      end;
    end
    else
    if (TabPosition = tpRight) and ((AntiAlias = aaNone) or (TabSettings.Width > 0)) then
    begin
      if (DCaption <> '') or (WCaption <> '') then
      begin
        CapR2 := CapR;
        TxtR.Left := CapR.Left + ((CapR.Right - CapR.Left)-Canvas.TextHeight('gh')) div 2;
        if (TabSettings.Width <> 0) then
        begin
          case TabSettings.Alignment of
            taCenter: CapR2.Top := TR.Top;
            taRightJustify: CapR2.Top := TR.Top;
          end;
        end;

        TxtR.Top := CapR.Bottom;
        TxtR.Right := TxtR.Left + Canvas.TextHeight('gh');
        if (DCaption <> '') then
          TxtR.Bottom := TxtR.Top + Canvas.TextWidth(DCaption)
        else
          TxtR.Bottom := TxtR.Top + WideCanvasTextWidth(Canvas, WCaption);

        // Make sure to use a truetype font!
        // Font.Name := 'Tahoma';

        tf := TFont.Create;
        try
          if (TabPosition = tpLeft) or (TabPosition = tpRight) then
          begin
{$IFNDEF TMSDOTNET}
            FillChar(lf, SizeOf(lf), 0);
{$ENDIF}
            tf.Assign(Canvas.Font);
{$IFNDEF TMSDOTNET}
            GetObject(tf.Handle, SizeOf(Lf), @Lf);
{$ENDIF}
{$IFDEF TMSDOTNET}
            GetObject(tf.Handle, Marshal.SizeOf(TypeOf(Lf)), Lf);
{$ENDIF}

            if TabPosition = tpLeft then lf.lfEscapement := -900
            else lf.lfEscapement := -900;
            lf.lfOrientation := 30;

            tf.Handle := CreateFontIndirect(Lf);
            Canvas.Font.Assign(tf);
          end;
        finally
          tf.Free;
        end;

        if (DCaption <> '') then
        begin
          DCaption := TrimText(DCaption, CapR, False, nil, Canvas, nil, nil, Ellipsis, TabPosition, TabSettings.WordWrap);
          Canvas.TextOut(CapR.Right - ((CapR.Right - CapR.Left)-Canvas.TextHeight('gh')) div 2, CapR2.Top, DCaption);
        end
        else
        begin
          WCaption := TrimTextW(WCaption, CapR, False, nil, Canvas, nil, nil, Ellipsis, TabPosition, TabSettings.WordWrap);
          TextOutW(Canvas.Handle, CapR.Right - ((CapR.Right - CapR.Left)-Canvas.TextHeight('gh')) div 2, CapR2.Top, PWideChar(WCaption), Length(WCaption));
        end;
      end;
    end
    else
    begin
      CapR2 := CapR;
      AAlign := taLeftJustify;
      if (TabSettings.Width <> 0) then
      begin
        case TabSettings.Alignment of
          taLeftJustify:
          begin
            AAlign := taLeftJustify;
          end;
          taCenter:
          begin
            AAlign := taLeftJustify;
            CapR2.Left := TR.Left;
          end;
          taRightJustify:
          begin
            AAlign := taRightJustify;
            //CapR2.Right := CapR2.Right - 3;
            if (TabSettings.Shape in [tsRightRamp, tsLeftRightRamp]) then
              CapR2.Right := CapR2.Right - GetRightRoundingOffset;
          end;
        end;
      end
      else
      begin
        if TabSettings.ImagePosition in [ipTop,ipBottom] then
          AAlign := taCenter
        else
          AAlign := taLeftJustify;
      end;
      
      if CloseOnTab and (TabSettings.Width <> 0) and (PageIndex = ActivePageIndex) and AdvPages[PageIndex].ShowClose then
      begin
        if CloseOnTabPosition = cpRight then
          CapR2.Right := CapR2.Right - PAGEBUTTON_SIZE - 4;
        //else                                                    
          //CapR.Left := CapR.Left + 18
      end;

      if (DCaption <> '') then
        DCaption := TrimText(DCaption, CapR2, False, nil, Canvas, nil, nil, Ellipsis, TabPosition, TabSettings.WordWrap)
      else
        WCaption := TrimTextW(WCaption, CapR2, False, nil, Canvas, nil, nil, Ellipsis, TabPosition, TabSettings.WordWrap);

      TxtR := DrawVistaText(Canvas, AAlign, CapR2, DCaption, WCaption, Canvas.Font, AdvPages[PageIndex].Enabled, True, FAntiAlias, TabPosition, Ellipsis, TabSettings.WordWrap);
      //DrawText(Canvas.Handle, PChar(DCaption), Length(DCaption), R, DT_SINGLELINE or DT_VCENTER);
    end;

    if Assigned(Pic) and not Pic.Empty then
    begin
      case TabPosition of
        tpTop, tpBottom:
        begin
          case TabSettings.ImagePosition of
            ipTop: ImgY := Max(TxtR.Top - ImgH - ImgTxtSp, 4);
            ipBottom: ImgY := Min(TxtR.Bottom + ImgTxtSp, CapR.Bottom);
          end;
        end;
        tpLeft:
        begin
          if not RotateTabLeftRight then
          begin
            case TabSettings.ImagePosition of
              ipTop: ImgY := Max(TxtR.Top - ImgH - ImgTxtSp, 4);
              ipBottom: ImgY := Max(TxtR.Bottom + ImgTxtSp, 4);
              ipRight:  ImgX := TxtR.Right + ImgTxtSp*2;
            end;
          end
          else
          begin
            case TabSettings.ImagePosition of
              ipTop: ImgX := Max(TxtR.Left - ImgW - ImgTxtSp, 4);
              ipBottom: ImgX := Max(TxtR.Right + ImgTxtSp, 4);
            end;
          end;
        end;
        tpRight:
        begin
          if not RotateTabLeftRight then
          begin
            case TabSettings.ImagePosition of
              ipTop: ImgY := Max(TxtR.Top - ImgH - ImgTxtSp, 4);
              ipBottom: ImgY := Max(TxtR.Bottom + ImgTxtSp, 4);
              ipRight: ImgX := TxtR.Right + ImgTxtSp*2;
            end;
          end
          else
          begin
            case TabSettings.ImagePosition of
              ipTop: ImgX := Max(TxtR.Right + ImgTxtSp, 4);
              ipBottom: ImgX := Max(TxtR.Left - ImgW - ImgTxtSp, 4);
            end;
          end;
        end;
      end;

      Canvas.Draw(ImgX, ImgY, Pic);
    end
    else
    if (Assigned(FImages) or Assigned(DisabledImages)) and (AdvPages[PageIndex].ImageIndex >= 0) then
    begin
      if (ImgList <> nil) then
      begin
        case TabPosition of
          tpTop, tpBottom:
          begin
            case TabSettings.ImagePosition of
              ipTop: ImgY := Max(TxtR.Top - ImgList.Height - ImgTxtSp, 4);
              ipBottom: ImgY := Min(TxtR.Bottom + ImgTxtSp, CapR.Bottom);
            end;
          end;
          tpLeft:
          begin
            if not RotateTabLeftRight then
            begin
              case TabSettings.ImagePosition of
                ipTop: ImgY := Max(TxtR.Top - ImgList.Height - ImgTxtSp, 4);
                ipBottom: ImgY := Max(TxtR.Bottom + ImgTxtSp, 4);
                ipRight: ImgX := TxtR.Right + ImgTxtSp*2;
              end;
            end
            else
            begin
              case TabSettings.ImagePosition of
                ipTop: ImgX := Max(TxtR.Left - ImgList.Width - ImgTxtSp, 4);
                ipBottom: ImgX := Max(TxtR.Right + ImgTxtSp, 4);
              end;
            end;
          end;
          tpRight:
          begin
            if not RotateTabLeftRight then
            begin
              case TabSettings.ImagePosition of
                ipTop: ImgY := Max(TxtR.Top - ImgList.Height - ImgTxtSp, 4);
                ipBottom: ImgY := Max(TxtR.Bottom + ImgTxtSp, 4);
                ipRight: ImgX := TxtR.Right + ImgTxtSp*2;
              end;
            end
            else
            begin
              case TabSettings.ImagePosition of
                ipTop: ImgX := Max(TxtR.Right + ImgTxtSp, 4);
                ipBottom: ImgX := Max(TxtR.Left - ImgList.Width - ImgTxtSp, 4);
              end;
            end;
          end;
        end;

        ImgList.Draw(Canvas, ImgX, ImgY, AdvPages[PageIndex].ImageIndex, true);
      end;
    end;

    if FTabScroller.Visible or (ButtonSettings.PageListButton) or (ButtonSettings.CloseButton and not CloseOnTab) then
    begin
      if IntersectRect(R2, R, GetButtonsRect) then
      begin
        Canvas.CopyMode := cmSrcCopy;
        Canvas.CopyRect(R2, FButtonsBkg.Canvas, Rect(0, 0, R2.Right - R2.Left, R2.Bottom - R.Top));
      end;
    end;

    {Canvas.Pen.Color := clBlack;
    Canvas.Brush.Style := bsClear;
    Canvas.Rectangle(R); }

    if (PageIndex <> ActivePageIndex) and (IsActivePageNeighbour(PageIndex) <> 0) then
      DrawTab(ActivePageIndex);
      
    if not Assigned(Parent) then
      Exit;
   {
    R := ClientRect;
    rgn1 := CreateRectRgn(0, 0, 1, 1);
    rgn2 := CreateRectRgn(R.Right-1, 0, R.Right, 1);
    CombineRgn(rgn1, rgn1, rgn2, RGN_OR);
    DeleteObject(rgn2);
    rgn2 := CreateRectRgn(0, R.Bottom - 1, 1, R.Bottom);
    CombineRgn(rgn1, rgn1, rgn2, RGN_OR);
    DeleteObject(rgn2);
    rgn2 := CreateRectRgn(R.Right - 1, R.Bottom - 1, R.Right, R.Bottom);
    CombineRgn(rgn1, rgn1, rgn2, RGN_OR);

    SelectClipRgn(Canvas.Handle, rgn1);

    i := SaveDC(Canvas.Handle);
    p := ClientOrigin;
    Windows.ScreenToClient(Parent.Handle, p);
    p.x := -p.x;
    p.y := -p.y;
    MoveWindowOrg(Canvas.Handle, p.x, p.y);
    //SendMessage(Parent.Handle, WM_ERASEBKGND, Canvas.Handle, 0);
    SendMessage(Parent.Handle, WM_PAINT, Canvas.Handle, 0);
    if (Parent is TWinCtrl) then
      (Parent as TWinCtrl).PaintCtrls(Canvas.Handle, nil);
    RestoreDC(Canvas.Handle, i);

    SelectClipRgn(Canvas.Handle, 0);
    DeleteObject(rgn1);
    DeleteObject(rgn2);  }
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.DrawAllTabs;
var
  i: Integer;
  R: TRect;
begin
  // Draw TabBackGround
  
  R := GetTabsArea;

  case TabPosition of
    tpTop: R.Bottom := ClientRect.Bottom;
    tpBottom: R.Top := ClientRect.Top;
    tpLeft: R.Right := ClientRect.Right;
    tpRight: R.Left := ClientRect.Left;
  end;

  with FCurrentOfficePagerStyler.TabAppearance do
  begin
    if (BackGround.Color <> clNone) and (BackGround.ColorTo <> clNone) then
      DrawGradient(Canvas, BackGround.Color, BackGround.ColorTo, BackGround.Steps, R, BackGround.Direction = gdHorizontal)
    else if (BackGround.Color <> clNone) then
    begin
      Canvas.Brush.Color := BackGround.Color;
      Canvas.Pen.Color := BackGround.Color;
      Canvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    end;
  end;

  if FTabScroller.Visible or (ButtonSettings.PageListButton) or (ButtonSettings.CloseButton and not CloseOnTab) then
  begin
    R := GetButtonsRect;
    FButtonsBkg.Height := (R.Bottom - R.Top);
    FButtonsBkg.Width := (R.Right - R.Left);
    FButtonsBkg.Canvas.CopyMode := cmSrcCopy;
    FButtonsBkg.Canvas.CopyRect(Rect(0, 0, FButtonsBkg.Width, FButtonsBkg.Height), Canvas, R);
  end;

  for i:= 0 to FAdvPages.Count-1 do
    DrawTab(i);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.Paint;
var
  R: TRect;
  th: integer;
begin
  inherited;

  R := ClientRect;
  with FCurrentOfficePagerStyler, Canvas do
  begin
   (* if not BackGround.Empty then
    begin

      case BackGroundDisplay of
        bdTile:
          begin
            c := 1;
            ro := 1;
            while ro < Height - 2 do
            begin
              while c < width - 2 do
              begin
                Draw(c, ro, BackGround);
                c := c + BackGround.Width;
              end;
              c := 1;
              ro := ro + BackGround.Height;
            end;
          end;
        bdCenter:
          begin
            Draw((Width - BackGround.Width) div 2, (Height - BackGround.Height) div 2, BackGround);
          end;
        bdStretch:
          begin
            StretchDraw(Rect(R.Left + 2, R.Top + 2, R.Right - 2, R.Bottom - 2), BackGround);
          end;
      end;
    end;  *)
  end;

  DrawAllTabs;
  DrawTabScrollButtons;

  if (csDesigning in ComponentState) and (FAdvPages.Count = 0) then
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

  //Canvas.Draw(0, 0, FMyImage);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.RemoveAdvPage(AdvPage: TAdvOfficePage);
var
  i, ni: Integer;
begin
  i := FAdvPages.IndexOf(AdvPage);
  if (i >= 0) then
  begin
    if i < ActivePageIndex then
      ni := ActivePageIndex - 1
    else
      ni := ActivePageIndex;

    if (ActivePage = AdvPage) then
      SelectNextPage(True);

    FAdvPages.Delete(i);
    AdvPage.FAdvOfficePager := nil;

    ActivePageIndex := ni;

    if not (csDestroying in ComponentState) then
    begin
      InitializeAndUpdateButtons;
      UpdateTabScroller;
    end;

    InvalidateTab(-1);
    Invalidate;
    if Assigned(ActivePage) then
      ActivePage.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetParent(AParent: TWinControl);
begin
  if (AParent is TAdvOfficePager) then
    raise Exception.Create('Invalid Parent');

  inherited;

  if (not FPropertiesLoaded) and not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
  begin
    Init;
    InitializeAndUpdateButtons;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetOfficePagerStyler(
  const Value: TCustomAdvOfficePagerStyler);
var
  i: integer;
begin
  SetPageValidCache(false);
  if (FOfficePagerStyler <> Value) or (Value = nil) then
  begin
    if Assigned(FOfficePagerStyler) and (FOfficePagerStyler <> FInternalOfficePagerStyler) then
      FOfficePagerStyler.RemoveControl(self);

    FOfficePagerStyler := Value;

    if FOfficePagerStyler = nil then
    begin
      FCurrentOfficePagerStyler := FInternalOfficePagerStyler;
    end
    else
    begin
      FCurrentOfficePagerStyler := FOfficePagerStyler;
      FOfficePagerStyler.AddControl(self);
    end;

    if not (csDestroying in ComponentState) and not (csLoading in ComponentState) then
    begin
      for i := 0 to FAdvPages.Count - 1 do
      begin
       (* for j:= 0 to AdvPages[i].ControlCount -1 do
        begin
          if (AdvPages[i].Controls[j] is TAdvToolBar) then
            TAdvCustomToolBar(AdvPages[i].Controls[j]).ParentStyler := TAdvCustomToolBar(AdvPages[i].Controls[j]).ParentStyler;
        end; *)
        AdvPages[i].Invalidate;
      end;
    end;
    UpdateMe(0);
    PopupMenu := PopupMenu;   // Refresh Styler
    SetPageValidCache(false);
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetAdvOfficePageCount: integer;
begin
  Result := FAdvPages.Count;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetAdvPages(index: integer): TAdvOfficePage;
begin
  Result := TAdvOfficePage(FAdvPages[index]);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetAdvPageBounds(AdvPage: TAdvOfficePage;
  var ALeft, ATop, AWidth, AHeight: Integer);
begin
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetChildOrder(Child: TComponent; Order: Integer);
begin
  inherited SetChildOrder(Child, Order);
end;

//------------------------------------------------------------------------------


procedure TAdvOfficePager.WMSize(var Message: TWMSize);
begin
  inherited;
  SetAllPagesPosition;
  UpdateTabScroller;
  SetPageValidCache(false);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetPopupMenuEx(const Value: TPopupMenu);
begin
  Inherited PopupMenu := Value;
  (*if Assigned(PopupMenu) and (PopupMenu is TAdvPopupMenu) and Assigned(FCurrentOfficePagerStyler) then
    TAdvPopupMenu(PopupMenu).MenuStyler := FCurrentOfficePagerStyler.CurrentAdvMenuStyler; *)
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CMShowingChanged(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetPopupMenuEx: TPopupMenu;
begin
  Result := Inherited PopupMenu;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetShowNonSelectedTabs(const Value: Boolean);
begin
  FShowNonSelectedTabs := Value;
  InvalidateTab(-1);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CMControlChange(var Message: TCMControlChange);
begin
  inherited;

  with Message do
  begin
    if (Control is TAdvOfficePage) then
    begin
      if Inserting then
        //InsertControl(Control)
      else
        //RemoveControl(Control);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CMControlListChange(
  var Message: TCMControlListChange);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CMMouseLeave(var Message: TMessage);
var
  P: TPoint;
  R: TRect;
begin
  inherited;

  {if FScrollerHoverLeftBtn or FScrollerHoverRightBtn then
  begin
    FScrollerHoverLeftBtn := false;
    FScrollerHoverRightBtn := false;
    DrawTabScrollButtons;
  end;
  }
  FHintPageIndex := -1;

  if (csDesigning in ComponentState) then
    Exit;

  // work around to avoid false call  
  GetCursorPos(P);
  P := ScreenToClient(P);
  R := GetTabsRect;
  case (TabPosition) of
    tpTop: R.Bottom := R.Bottom - 4;
    tpBottom: R.Top := R.Top + 4;
    tpLeft: R.Right := R.Right - 4;
    tpRight: R.Left := R.Left + 4;
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
    if (FHotPageIndex < FAdvPages.Count) then
    begin
      if not Assigned(AdvPages[FHotPageIndex].FTimer) and Glow then
      begin
        AdvPages[FHotPageIndex].FTimer := TTimer.Create(self);
        AdvPages[FHotPageIndex].FTimer.OnTimer := AdvPages[FHotPageIndex].TimerProc;
        AdvPages[FHotPageIndex].FTimer.Interval := GlowSpeed;
        AdvPages[FHotPageIndex].FTimer.Enabled := true;
      end;

      AdvPages[FHotPageIndex].FTimeInc := -GLOWSTEP;
      AdvPages[FHotPageIndex].FGlowState := gsHover;
    end;
    FHotPageIndex := -1;
    InvalidateTab(-1);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
  Tab: Integer;
begin
  inherited;
  P := Point(X, Y);

  FDownPageIndex := -1;

  if PtInRect(GetTabsArea, p) then
  begin
    Tab := PTOnTab(X, Y);
    if (Tab >= 0) then
    begin
    
      if (Button = mbLeft) then
      begin
        if Assigned(FOnTabClick) then
          FOnTabClick(Self, Tab);
      end
      else if (Button = mbRight) then
      begin
        if Assigned(FOnTabRightClick) then
          FOnTabRightClick(Self, Tab);
      end;
    
      if (Button <> mbMiddle) and (Tab <> ActivePageIndex) and AdvPages[Tab].TabEnabled then
      begin
        // Select Tab
        ChangeActivePage(Tab);
        if not (csDesigning in ComponentState) then
        begin
          if not Assigned(AdvPages[Tab].FTimer) and Glow then
          begin
            AdvPages[Tab].FTimer := TTimer.Create(self);
            AdvPages[Tab].FTimer.OnTimer := AdvPages[Tab].TimerProc;
            AdvPages[Tab].FTimer.Interval := GlowSpeed;
            AdvPages[Tab].FTimer.Enabled := true;
          end;
          AdvPages[Tab].FTimeInc := +GLOWSTEP;
          AdvPages[Tab].FGlowState := gsPush;
        end;
        Invalidate;
      end
      else
      begin
        FDownPageIndex := Tab;
        InvalidateTab(-1);
      end;

      if (Button = mbLeft) and AdvPages[Tab].TabEnabled and TabReorder then
      begin
        BeginDrag(false,4);
      end;
    end
    else
    begin
      (*
      if PtOnTabScrollLeftBtn(X, Y) then
      begin
        FScrollerDownLeftBtn := true;
        DrawTabScrollBtnLeft;
      end;
      if PtOnTabScrollRightBtn(X, Y) then
      begin
        FScrollerDownRightBtn := true;
        DrawTabScrollBtnRight;
      end;
      *)
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.MouseMove(Shift: TShiftState; X, Y: Integer);
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
          if (FHotPageIndex < FAdvPages.Count) then
          begin
            if not Assigned(AdvPages[FHotPageIndex].FTimer) and Glow then
            begin
              AdvPages[FHotPageIndex].FTimer := TTimer.Create(self);
              AdvPages[FHotPageIndex].FTimer.OnTimer := AdvPages[FHotPageIndex].TimerProc;
              AdvPages[FHotPageIndex].FTimer.Interval := GlowSpeed;
              AdvPages[FHotPageIndex].FTimer.Enabled := true;
            end;
            AdvPages[FHotPageIndex].FTimeInc := -GLOWSTEP;

            AdvPages[FHotPageIndex].FGlowState := gsHover;
          end;
          FHotPageIndex := -1;
          InvalidateTab(-1);
        end;
      end;

      // Hot Tab
      OnEnterTab(Tab);

      //InvalidateTab(-1);
      //if (Tab <> FActivePageIndex) then
      if AdvPages[Tab].TabEnabled then
      begin
        FHotPageIndex := Tab;
        FOldHotPageIndex := FHotPageIndex;
        if not Assigned(AdvPages[FHotPageIndex].FTimer) and Glow then
        begin
          AdvPages[FHotPageIndex].FTimer := TTimer.Create(self);
          AdvPages[FHotPageIndex].FTimer.OnTimer := AdvPages[FHotPageIndex].TimerProc;
          AdvPages[FHotPageIndex].FTimer.Interval := GlowSpeed;
          AdvPages[FHotPageIndex].FTimer.Enabled := true;
        end;

        AdvPages[FHotPageIndex].FTimeInc := GLOWSTEP;
        Invalidate;
        AdvPages[FHotPageIndex].FGlowState := gsHover;

     { end
      else if (FHotPageIndex >= 0) then
      begin
        OnExitTab(FHotPageIndex);
        begin
          if not Assigned(AdvPages[FHotPageIndex].FTimer) then
          begin
            AdvPages[FHotPageIndex].FTimer := TTimer.Create(self);
            AdvPages[FHotPageIndex].FTimer.OnTimer := AdvPages[FHotPageIndex].TimerProc;
            AdvPages[FHotPageIndex].FTimer.Interval := GlowSpeed;
            AdvPages[FHotPageIndex].FTimer.Enabled := true;
          end;
          AdvPages[FHotPageIndex].FTimeInc := -20;

          AdvPages[FHotPageIndex].FGlowState := gsHover;
          FHotPageIndex := -1;
          InvalidateTab(-1);
        end; }
      end;

      if (FHintPageIndex <> Tab) then
      begin
        FHintPageIndex := Tab;
        Application.CancelHint;
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
        if (FHotPageIndex < FAdvPages.Count) then
        begin
          if not Assigned(AdvPages[FHotPageIndex].FTimer) and Glow then
          begin
            AdvPages[FHotPageIndex].FTimer := TTimer.Create(self);
            AdvPages[FHotPageIndex].FTimer.OnTimer := AdvPages[FHotPageIndex].TimerProc;
            AdvPages[FHotPageIndex].FTimer.Interval := GlowSpeed;
            AdvPages[FHotPageIndex].FTimer.Enabled := true;
          end;
          AdvPages[FHotPageIndex].FTimeInc := -GLOWSTEP;

          AdvPages[FHotPageIndex].FGlowState := gsHover;
        end;
        FHotPageIndex := -1;
        InvalidateTab(-1);
      end;
    end;

    if (Tab < 0) then
    begin
      FHintPageIndex := -1;
      Application.CancelHint;
    end;

    {// Checking for TabScrollButtons
    if PtOnTabScrollLeftBtn(X, Y) then
    begin
      if not FScrollerHoverLeftBtn then
      begin
        FScrollerHoverLeftBtn := true;
        DrawTabScrollBtnLeft;
      end;
    end
    else if FScrollerHoverLeftBtn then
    begin
      FScrollerHoverLeftBtn := false;
      DrawTabScrollBtnLeft;
    end;

    if PtOnTabScrollRightBtn(X, Y) then
    begin
      if not FScrollerHoverRightBtn then
      begin
        FScrollerHoverRightBtn := true;
        DrawTabScrollBtnRight;
      end;
    end
    else if FScrollerHoverRightBtn then
    begin
      FScrollerHoverRightBtn := false;
      DrawTabScrollBtnRight;
    end;
    }
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.MouseUp(Button: TMouseButton;
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

  if PtInRect(GetTabsArea, p) then
  begin
    {if PtOnTabScrollLeftBtn(X, Y) then
    begin
      FScrollerDownLeftBtn := false;
      DrawTabScrollBtnLeft;
      ScrollLeftBtnClick;
    end
    else if PtOnTabScrollRightBtn(X, Y) then
    begin
      FScrollerDownRightBtn := false;
      DrawTabScrollBtnRight;
      ScrollRightBtnClick;
    end; }
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.GetChildren(Proc: TGetChildProc;
  Root: TComponent);
var
  I: Integer;
  Control: TControl;
begin
  for I := 0 to FAdvPages.Count - 1 do Proc(TComponent(FAdvPages[I]));

  for I := 0 to ControlCount - 1 do
  begin
    Control := Controls[I];
    if (Control.Owner = Root) and (FAdvPages.IndexOf(Control) < 0) then Proc(Control);
  end;

end;

//------------------------------------------------------------------------------

function TAdvOfficePager.FindNextPage(CurPage: TAdvOfficePage; GoForward,
  CheckTabVisible: Boolean): TAdvOfficePage;
var
  i, j, CurIndex: Integer;
begin
  Result := nil;
  CurIndex := FAdvPages.IndexOf(CurPage);


  if (CurPage = nil) or (CurIndex < 0) then
  begin

    if FAdvPages.Count > 0 then
    begin
      if GoForward then
        Result := FAdvPages[0]
      else
        Result := FAdvPages[FAdvPages.Count - 1];
    end;
    Exit;
  end;
    
  if GoForward then
  begin
    i := CurIndex;
    j := 0; //1;
    while (j < FAdvPages.Count) do
    begin
      Inc(i);    
      if (i >= FAdvPages.Count) then
        i := 0;
      if (CheckTabVisible and AdvPages[i].TabVisible) or not CheckTabVisible then
      begin
        Result := AdvPages[i];
        Break;
      end;
      Inc(j);
    end;
  end
  else  // BackWard
  begin
    i := CurIndex;
    j := 0; //1;
    while (j < FAdvPages.Count) do
    begin
      dec(i);
      if (i >= FAdvPages.Count) then
        i := 0;
      if (i < 0) then
        i := FAdvPages.Count-1;
      if (CheckTabVisible and AdvPages[i].TabVisible) or not CheckTabVisible then
      begin
        Result := AdvPages[i];
        Break;
      end;
      Inc(j);
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetActivePage: TAdvOfficePage;
begin
  Result := nil;
  if (ActivePageIndex >= 0) and (ActivePageIndex < FAdvPages.Count) then
    Result := AdvPages[FActivePageIndex];
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetActivePageIndex: Integer;
begin
  Result := FActivePageIndex;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SelectNextPage(GoForward: Boolean);
var
  i, j: Integer;
begin
  if (ActivePageIndex < 0) then
    Exit;

  if GoForward then
  begin
    i := ActivePageIndex;
    j := 0; //1;
    while (j < FAdvPages.Count) do
    begin
      Inc(i);
      if (i >= FAdvPages.Count) then
        i := 0;
      if (ActivePage <> AdvPages[i]) and AdvPages[i].TabVisible and AdvPages[i].TabEnabled then
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
    while (j < FAdvPages.Count) do
    begin
      dec(i);
      if (i >= FAdvPages.Count) then
        i := 0;
      if (i < 0) then
        i := FAdvPages.Count-1;
      if (ActivePage <> AdvPages[i]) and AdvPages[i].TabVisible and AdvPages[i].TabEnabled then
      begin
        ActivePageIndex := i;
        Break;
      end;
      Inc(j);
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.IndexOfPage(AdvPage: TAdvOfficePage): Integer;
begin
  Result := FAdvPages.IndexOf(AdvPage);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetActivePage(const Value: TAdvOfficePage);
begin
  if (FAdvPages.IndexOf(Value) >= 0) then
    ActivePageIndex := FAdvPages.IndexOf(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.ChangeActivePage(PageIndex: Integer);
var
  aForm: TCustomForm;
  AllowChange: Boolean;
begin
  if (PageIndex >= 0) and (PageIndex < FAdvPages.Count) and ((PageIndex <> ActivePageIndex) or (FAdvPages.Count = 1)) then
  begin
    if FTabShortCutHintShowing then
    begin
      HideShortCutHintOfAllPages;
    end;

    AllowChange := True;
    if Assigned(FOnChanging) and FPropertiesLoaded and not (csDestroying in ComponentState) then
      FOnChanging(Self, ActivePageIndex, PageIndex, AllowChange);

    if not AllowChange then
      Exit;

    if (ActivePageIndex >= 0) and (ActivePageIndex < FAdvPages.Count) then
    begin
      AdvPages[FActivePageIndex].Visible := False;

      if Assigned(AdvPages[FActivePageIndex].FOnHide) then
        AdvPages[FActivePageIndex].FOnHide(AdvPages[FActivePageIndex]);
    end;


    FActivePageIndex := PageIndex;
    AdvPages[FActivePageIndex].Visible := True;
    AdvPages[FActivePageIndex].BringToFront;

    if Assigned(FOnChange) and not (csDestroying in ComponentState)
      and not (csLoading in ComponentState) then
      FOnChange(Self);

    if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    begin
      aForm := GetParentForm(Self);
      if (aForm <> nil) and (aForm.Designer <> nil) then
        aForm.Designer.Modified;
    end;

    InitializeAndUpdateButtons;

    //if not (csLoading in ComponentState) then
    //  if Assigned(AdvPages[FActivePageIndex].FOnShow) then
    //    AdvPages[FActivePageIndex].FOnShow(AdvPages[FActivePageIndex]);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetActivePageIndex(const Value: Integer);
var
  R: TRect;
  i, j: Integer;
begin
  { if (Value >= 0) and (Value < FAdvPages.Count) and (Value <> ActivePageIndex) then
  begin
    if (ActivePageIndex >= 0) and (ActivePageIndex < FAdvPages.Count) then
    begin
      AdvPages[FActivePageIndex].Visible := False;
    end;

    FActivePageIndex := Value;
    AdvPages[FActivePageIndex].Visible := True;
    AdvPages[FActivePageIndex].BringToFront;
 }
    R := GetTabRect(Value);

    if (R.Left = -1) and (Value >= 0) and (Value < FAdvPages.Count) then // force activated tab to be visible
    begin
      //FTabScroller.Position := Value;
      j := 0;
      for i:= 0 to Value - 1 do
      begin
        if AdvPages[i].TabVisible then
          inc(j);
      end;

      FTabScroller.Position := Min(j, FTabScroller.Max);
    end;

    ChangeActivePage(Value);
    R := GetTabsArea;
    InvalidateRect(Handle, @R, True);
 // end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetTabSettings(const Value: TPagerTabSettings);
begin
  FTabSettings.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetAllPagesPosition;
var
  i: Integer;
begin
  for i:= 0 to FAdvPages.Count-1 do
  begin
    SetPagePosition(TAdvOfficePage(FAdvPages[i]));
  end;
end;

//------------------------------------------------------------------------------
(*
function TAdvOfficePager.GetCaptionRect: TRect;
begin
  Result := Rect(-1, -1, -1, -1);
  if FCaption.Visible then
  begin
    Result := ClientRect;
    Result.Bottom := Result.Top + Caption.Height;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetAvailableCaptionRect: TRect;
begin
  Result := GetCaptionRect;
  if FCaption.Visible then
  begin
    Result.Left := Result.Left + FCaption.Indent;
    Result.Right := Result.Right - FCaption.RightIndent;
  end;
end;
*)
//------------------------------------------------------------------------------

function TAdvOfficePager.GetAdvPageRect: TRect;
begin
  Result := ClientRect;
  case TabPosition of
    tpTop:
    begin
      Result.Top := Result.Top + TabSettings.Height;
      Result.Left := Result.Left + FPageMargin;
      Result.Right := Result.Right-FPageMargin;
      Result.Bottom := Result.Bottom - FPageMargin-1;
    end;
    tpBottom:
    begin
      Result.Top := Result.Top + FPageMargin+1;
      Result.Left := Result.Left + FPageMargin;
      Result.Right := Result.Right-FPageMargin;
      Result.Bottom := Result.Bottom - TabSettings.Height;
    end;
    tpLeft:
    begin
      Result.Top := Result.Top + FPageMargin+1;
      Result.Left := Result.Left + TabSettings.Height;
      Result.Right := Result.Right-FPageMargin;
      Result.Bottom := Result.Bottom - FPageMargin-1;
    end;
    tpRight:
    begin
      Result.Top := Result.Top + FPageMargin+1;
      Result.Left := Result.Left + FPageMargin;
      Result.Right := Result.Right- TabSettings.Height;
      Result.Bottom := Result.Bottom - FPageMargin-1;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetPagePosition(AdvPage: TAdvOfficePage);
var
  R: TRect;
begin
  if (AdvPage <> nil) and (FAdvPages.IndexOf(AdvPage) >= 0) then
  begin
    R := GetAdvPageRect;
    {
    AdvPage.Left := R.Left;
    AdvPage.Top := R.Top;
    AdvPage.Width := R.Right - R.Left;
    AdvPage.Height := R.Bottom - R.Top;
    }
    AdvPage.SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.IndexOfTabAt(X,Y: Integer): integer;
begin
  Result := PtOnTab(x,y);
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.PTOnTab(X, Y: Integer): Integer;
var
  i: Integer;
  P: TPoint;
  TabR: TRect;
begin
  Result := -1;
  P := Point(X, Y);
  for i:= 0 to FAdvPages.Count-1 do
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

function TAdvOfficePager.GetButtonsRect: TRect;
var
  Spc: Integer;
begin
  Result := ClientRect;
  Spc := 3;
  case TabPosition of
    tpTop:
    begin
      Result.Top := Result.Top + FTabOffset;
      Result.Bottom := Result.Top + FTabSettings.Height;
      Result.Top := Result.Bottom - PAGEBUTTON_SIZE - 8;
      Result.Right := Result.Right - FTabSettings.EndMargin - FPageMargin - 3;
      Result.Left := Result.Right-3;
      if FTabScroller.Visible then
        Result.Left := Result.Left -(PAGEBUTTON_SIZE * 2 + 2 + 3);
      if (ButtonSettings.PageListButton) then
        Result.Left := Result.Left - PAGEBUTTON_SIZE - Spc;
      if (ButtonSettings.CloseButton and not CloseOnTab) then
        Result.Left := Result.Left - PAGEBUTTON_SIZE - Spc;
    end;
    tpBottom:
    begin
      Result.Top := Result.Bottom - FTabSettings.Height - FTabOffSet;
      //Result.Bottom := Result.Bottom - FTabOffSet;
      Result.Bottom := Result.Top + PAGEBUTTON_SIZE + 8;
      Result.Right := Result.Right - FTabSettings.EndMargin - FPageMargin-3;
      Result.Left := Result.Right -3;
      if FTabScroller.Visible then
        Result.Left := Result.Left -(PAGEBUTTON_SIZE*2 + 2 + 3);
      if (ButtonSettings.PageListButton) then
        Result.Left := Result.Left - PAGEBUTTON_SIZE - Spc;
      if (ButtonSettings.CloseButton and not CloseOnTab) then
        Result.Left := Result.Left - PAGEBUTTON_SIZE - Spc;
    end;
    tpLeft:
    begin
      Result.Bottom := Result.Bottom - FTabSettings.EndMargin - FPageMargin-3;
      Result.Top := Result.Bottom -3;
      Result.Left := Result.Left + FTabOffSet;
      Result.Right := Result.Left + FTabSettings.Height;
      Result.Left := Result.Right - PAGEBUTTON_SIZE - 8;
      if FTabScroller.Visible then
        Result.Top := Result.Top -(PAGEBUTTON_SIZE * 2 + 2 + 3);
      if (ButtonSettings.PageListButton) then
        Result.Top := Result.Top - PAGEBUTTON_SIZE - Spc;
      if (ButtonSettings.CloseButton and not CloseOnTab) then
        Result.Top := Result.Top - PAGEBUTTON_SIZE - Spc;

      if not RotateTabLeftRight then
        Result.Left := Result.Right - 5 - PAGEBUTTON_SIZE - 3;
    end;
    tpRight:
    begin
      Result.Bottom := Result.Bottom - FTabSettings.EndMargin - FPageMargin-3;
      Result.Top := Result.Bottom -3;
      Result.Left := Result.Right - TabSettings.Height - FTabOffSet;
      //Result.Right := Result.Right - FTabOffSet;
      Result.Right := Result.Left + PAGEBUTTON_SIZE + 8;
      if FTabScroller.Visible then
        Result.Top := Result.Top -(PAGEBUTTON_SIZE*2 + 2 + 3);
      if (ButtonSettings.PageListButton) then
        Result.Top := Result.Top - PAGEBUTTON_SIZE - Spc;
      if (ButtonSettings.CloseButton and not CloseOnTab) then
        Result.Top := Result.Top - PAGEBUTTON_SIZE - Spc;

      if not RotateTabLeftRight then
        Result.Right := Result.Left + 5 + PAGEBUTTON_SIZE + 3;
    end;
  end;
end;

//------------------------------------------------------------------------------

// Independent to Start/End Margins and Scroller
function TAdvOfficePager.GetTabsArea: TRect;
begin
  Result := ClientRect;
  case TabPosition of
    tpTop: Result.Bottom := Result.Top + FTabSettings.Height;
    tpBottom: Result.Top := Result.Bottom - FTabSettings.Height;
    tpLeft: Result.Right := Result.Left + FTabSettings.Height;
    tpRight: Result.Left := Result.Right - FTabSettings.Height;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetTabsRect: TRect;
begin
  Result := ClientRect;
  case TabPosition of
    tpTop:
    begin
      Result.Top := Result.Top + FTabOffSet;
      Result.Bottom := Result.Top + FTabSettings.Height;
      Result.Left := Result.Left + FTabSettings.StartMargin + FPageMargin;
      Result.Right := GetButtonsRect.Left; //Result.Right - FTabSettings.EndMargin;
    end;
    tpBottom:
    begin
      Result.Top := Result.Bottom - FTabSettings.Height - FTabOffSet;
      Result.Bottom := Result.Bottom - FTabOffSet;
      Result.Left := Result.Left + FTabSettings.StartMargin + FPageMargin;
      Result.Right := GetButtonsRect.Left; //Result.Right - FTabSettings.EndMargin;
    end;
    tpLeft:
    begin
      Result.Top := Result.Top + FTabSettings.StartMargin + FPageMargin;
      Result.Bottom := GetButtonsRect.Top; // Result.Bottom - FTabSettings.EndMargin;
      Result.Left := Result.Left + FTabOffSet;
      Result.Right := Result.Left + FTabSettings.Height;
    end;
    tpRight:
    begin
      Result.Top := Result.Top + FTabSettings.StartMargin + FPageMargin;
      Result.Bottom := GetButtonsRect.Top; //Result.Bottom - FTabSettings.EndMargin;
      Result.Left := Result.Right - TabSettings.Height - FTabOffSet;
      Result.Right := Result.Right - FTabOffSet;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetTabRect(PageIndex: Integer): TRect;
begin
  Result := GetTabRect(0, PageIndex, True);
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetTabRect(StartIndex, PageIndex: Integer; ConsiderTabScroller: Boolean): TRect;
var
  i, TbW, TbH, j, Sp, fdW, ImgTxtSp, ImgW, ImgH: Integer;
  R, CR, R2: TRect;
  TabAppearance: TCustomTabAppearance;
  Pic: TGDIPPicture;
  DTSTYLE: dword;
  //Ellipsis: Boolean;
begin
  Result := Rect(-1, -1, -1, -1);
  Sp := FTabSettings.Spacing; //0;
  fdW := 5;
  ImgTxtSp := IMG_SPACE;
  //Ellipsis := (TabSettings.Width > 0) and not TabSettings.WordWrap;

  if (PageIndex >= 0) and (PageIndex < FAdvPages.Count) then
  begin
    if not AdvPages[PageIndex].TabVisible then
      Exit;

    CR := GetTabsRect; // ClientRect;
    //if Align in [daTop, daBottom] then
    begin
      {if FCaption.Visible then
        CR.Top := CR.Top + FCaption.Height;

      CR.Bottom := CR.Top + FTabSettings.Height;
      CR.Left := CR.Left + FTabSettings.StartMargin;
      CR.Right := CR.Right - FTabSettings.EndMargin;
      if FTabScroller.Visible then
        CR.Right := CR.Right - SCROLLER_SIZE; }
      //TbW := 0;
      j := 0;
      for i:= StartIndex to PageIndex do
      begin
        if not AdvPages[i].TabVisible then
          Continue;

        if (AdvPages[i].UseTabAppearance) then
          TabAppearance := AdvPages[i].TabAppearance
        else
          TabAppearance := FCurrentOfficePagerStyler.TabAppearance;

        Canvas.Font.Assign(TabAppearance.Font);
        ImgW := 0;
        ImgH := 0;

        if (TabPosition in [tpTop, tpBottom]) then
        begin
          if FUseMaxSpace then
            CR.Right := GetTabsArea.Right;

          if TabSettings.WordWrap then
            DTSTYLE := DT_WORDBREAK
          else
            DTSTYLE := DT_SINGLELINE;

          if (AdvPages[i].Caption <> '') then
          begin
            R2 := Rect(0,0, 1000, 100);
            DrawText(Canvas.Handle,PChar(AdvPages[i].Caption),Length(AdvPages[i].Caption), R2, DT_CALCRECT or DT_LEFT or DTSTYLE);
          end
          else if (AdvPages[i].WideCaption <> '') then
          begin
            R2 := Rect(0,0, 1000, 100);
            //R2 := DrawVistaText(Canvas, taLeftJustify, R2, '', AdvPages[i].WideCaption, Canvas.Font, Enabled, False, FAntiAlias, TabPosition, Ellipsis);

      {$IFNDEF TMSDOTNET}
            DrawTextW(Canvas.Handle, PWideChar(AdvPages[i].WideCaption), -1, R2, DT_CALCRECT or DT_LEFT or DTSTYLE);
      {$ENDIF}
      {$IFDEF TMSDOTNET}
            DrawTextW(Canvas.Handle, AdvPages[i].WideCaption, -1, R2, DT_CALCRECT or DT_LEFT or DTSTYLE);
      {$ENDIF}
            //R2.Right := WideCanvasTextWidth(Canvas, AdvPages[i].WideCaption);
          end
          else
            R2 := Rect(0, 0, 0, 0);
          //R2 := DrawVistaText(Canvas, R2, AdvPages[i].Caption, Canvas.Font, AdvPages[PageIndex].Enabled, False);
          TbW := GetLeftRoundingOffset + TabSettings.LeftMargin + R2.Right+ fdW + TabSettings.RightMargin + GetRightRoundingOffset;

          if AdvPages[i].Enabled or AdvPages[i].DisabledPicture.Empty then
            Pic := AdvPages[i].Picture
          else
            Pic := AdvPages[i].DisabledPicture;

          if Assigned(Pic) and not Pic.Empty then
          begin
            Pic.GetImageSizes;
            //TbW := TbW + Pic.Width + ImgTxtSp;
            ImgW := Pic.Width;
          end
          else
          if (Assigned(FImages) or Assigned(DisabledImages)) and (AdvPages[i].ImageIndex >= 0) then
          begin
            if AdvPages[i].Enabled then
            begin
              if Assigned(FImages) then
              begin
                //TbW := TbW + FImages.Width + ImgTxtSp;
                ImgW := FImages.Width;
              end;
            end
            else
            begin
              if Assigned(FDisabledImages) then
              begin
                //TbW := TbW + FDisabledImages.Width + ImgTxtSp
                ImgW := FDisabledImages.Width;
              end
              else if Assigned(FImages) then
              begin
                //TbW := TbW + FImages.Width + ImgTxtSp;
                ImgW := FImages.Width;
              end;
            end;
          end;
          
          //TbW := TbW + ImgW;
          case TabSettings.ImagePosition of
            ipTop, ipBottom:
            begin
              // do nothing
            end;
            ipLeft, ipRight:
            begin
              TbW := TbW + ImgW + ImgTxtSp;
            end;
          end;

          if (ButtonSettings.CloseButton and CloseOnTab and AdvPages[i].ShowClose) then
            TbW := Tbw + PAGEBUTTON_SIZE + 4;

          if (TabSettings.Width > 0) then
            TbW := TabSettings.Width;
            
          if ((CR.Left + TbW) > (CR.Right - FPageMargin)) and (not ConsiderTabScroller or (FTabScroller.Visible and(i = PageIndex) and (FTabScroller.Position <> PageIndex))) then
            Break;

          if FTabScroller.Visible and ConsiderTabScroller then
          begin
            if (j >= FTabScroller.Position) then
            begin
              R := Rect(CR.Left, CR.Top, CR.Left + TbW, CR.Bottom);
              if (i = PageIndex) then
                Result := R;
              CR.Left := CR.Left + TbW + Sp;
            end;
          end
          else
          begin
            R := Rect(CR.Left, CR.Top, CR.Left + TbW, CR.Bottom);
            if (i = PageIndex) then
              Result := R;
            CR.Left := CR.Left + TbW + Sp;
          end;
        end
        else // TabPosition in [tpLeft, tpRight]
        begin
          if FUseMaxSpace then
            CR.Bottom := GetTabsArea.Bottom;

          if (AdvPages[i].Caption <> '') then
          begin
            R2 := Rect(0,0, 1000, 100);
            DrawText(Canvas.Handle,PChar(AdvPages[i].Caption),Length(AdvPages[i].Caption), R2, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
          end
          else if (AdvPages[i].WideCaption <> '') then
          begin
            R2 := Rect(0,0, 1000, 100);
      {$IFNDEF TMSDOTNET}
            DrawTextW(Canvas.Handle, PWideChar(AdvPages[i].WideCaption), -1, R2, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
      {$ENDIF}
      {$IFDEF TMSDOTNET}
            DrawTextW(Canvas.Handle, AdvPages[i].WideCaption, -1, R2, DT_CALCRECT or DT_LEFT or DT_SINGlELINE);
      {$ENDIF}
          end
          else
            R2 := Rect(0, 0, 0, 0);
          //R2 := DrawVistaText(Canvas, R2, AdvPages[i].Caption, Canvas.Font, AdvPages[PageIndex].Enabled, False);
          TbW := TabSettings.LeftMargin + R2.Right+ fdW + TabSettings.RightMargin;
          TbH := R2.Bottom;

          if AdvPages[i].Enabled or AdvPages[i].DisabledPicture.Empty then
            Pic := AdvPages[i].Picture
          else
            Pic := AdvPages[i].DisabledPicture;

          if Assigned(Pic) and not Pic.Empty then
          begin
            Pic.GetImageSizes;
            //TbW := TbW + Pic.Height + ImgTxtSp;
            //TbH := Max(TbH, Pic.Height);
            ImgW := Pic.Width;
            ImgH := Pic.Height;
          end
          else
          if (Assigned(FImages) or Assigned(DisabledImages)) and (AdvPages[i].ImageIndex >= 0) then
          begin
            if AdvPages[i].Enabled then
            begin
              if Assigned(FImages) then
              begin
                //TbW := TbW + FImages.Height + ImgTxtSp;
                //TbH := Max(TbH, FImages.Height);
                ImgW := FImages.Width;
                ImgH := FImages.Height;
              end;  
            end
            else
            begin
              if Assigned(FDisabledImages) then
              begin
                //TbW := TbW + FDisabledImages.Height + ImgTxtSp;
                //TbH := Max(TbH, FDisabledImages.Height);
                ImgW := FDisabledImages.Width;
                ImgH := FDisabledImages.Height;
              end
              else if Assigned(FImages) then
              begin
                //TbW := TbW + FImages.Height + ImgTxtSp;
                //TbH := Max(TbH, FImages.Height);
                ImgW := FImages.Width;
                ImgH := FImages.Height;
              end;
            end;
          end;

          case TabSettings.ImagePosition of
            ipTop, ipBottom:
            begin
              TbH := Tbh + ImgH + ImgTxtSp;
            end;
            ipLeft, ipRight:
            begin
              TbW := TbW + ImgW + ImgTxtSp;
              TbH := Max(TbH, ImgH);
            end;
          end;

          TbH := TbH + 12; //TabSettings.RightMargin;

          if not RotateTabLeftRight then
          begin
            if (TabSettings.Width > 0) then
              TbH := TabSettings.Width;

            if ((CR.Top + TbH) > (CR.Bottom - FPageMargin)) and (not ConsiderTabScroller or (FTabScroller.Visible and(i = PageIndex) and (FTabScroller.Position <> PageIndex))) then
              Break;

            if FTabScroller.Visible and ConsiderTabScroller then
            begin
              if (j >= FTabScroller.Position) then
              begin
                R := Rect(CR.Left, CR.Top, CR.Right, CR.Top + TbH);
                if (i = PageIndex) then
                  Result := R;
                CR.Top := CR.Top + TbH + Sp;
              end;
            end
            else
            begin
              R := Rect(CR.Left, CR.Top, CR.Right, CR.Top + TbH);
              if (i = PageIndex) then
                Result := R;
              CR.Top := CR.Top + TbH + Sp;
            end;
          end
          else
          begin
            TbW := TbW + GetLeftRoundingOffset + GetRightRoundingOffset;
            if (ButtonSettings.CloseButton and CloseOnTab and AdvPages[i].ShowClose) then
              TbW := Tbw + PAGEBUTTON_SIZE + 4;

            if (TabSettings.Width > 0) then
              TbW := TabSettings.Width;

            if ((CR.Top + TbW) > (CR.Bottom - FPageMargin)) and (not ConsiderTabScroller or (FTabScroller.Visible and(i = PageIndex) and (FTabScroller.Position <> PageIndex))) then
              Break;

            if FTabScroller.Visible and ConsiderTabScroller then
            begin
              if (j >= FTabScroller.Position) then
              begin
                R := Rect(CR.Left, CR.Top, CR.Right, CR.Top + TbW);
                if (i = PageIndex) then
                  Result := R;
                CR.Top := CR.Top + TbW + Sp;
              end;
            end
            else
            begin
              R := Rect(CR.Left, CR.Top, CR.Right, CR.Top + TbW);
              if (i = PageIndex) then
                Result := R;
              CR.Top := CR.Top + TbW + Sp;
            end;
          end;
        end;
        Inc(j);
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetTabRect(Page: TAdvOfficePage): TRect;
begin
  Result := GetTabRect(FAdvPages.IndexOf(Page));
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CMDesignHitTest(var Msg: TCMDesignHitTest);
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

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetImages(const Value: TCustomImageList);
begin
  FImages := Value;
  Invalidate;
  if Assigned(ActivePage) then
    ActivePage.Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.InvalidateTab(PageIndex: Integer);
var
  R: TRect;
begin
  if (PageIndex >= 0) and (PageIndex < FAdvPages.Count) then
    R := GetTabRect(PageIndex)
  else
    R := GetTabsArea;
  InvalidateRect(Handle, @R, True);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.OnEnterTab(PageIndex: Integer);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.OnExitTab(PageIndex: Integer);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetDisabledImages(
  const Value: TCustomImageList);
begin
  FDisabledImages := Value;
  Invalidate;
  if Assigned(ActivePage) then
    ActivePage.Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.UpdateTabScroller;
var
  AnyTabVisible: Boolean;
  i, j, VisTabCount: Integer;

  function GetScrollMax: Integer;
  var
    i, j, LastVisTab: Integer;
    R: TRect;
  begin
    Result := 0;
    LastVisTab := 0;
    for i:= FAdvPages.Count -1 downto 0 do
    begin
      if AdvPages[i].TabVisible then
      begin
        LastVisTab := i;
        Break;
      end;
    end;

    if (LastVisTab <= 0) then
      Exit;

    i := 0;
    j := 0;
    while (i < FAdvPages.Count) do
    begin
      R := GetTabRect(i, LastVisTab, False);
      if (R.Left > -1) and (R.Right > -1) then
      begin
        Result := j; //i;
        AnyTabVisible := True;
        
        for j := i to LastVisTab do
        begin
          if AdvPages[j].TabVisible then
            Inc(VisTabCount);
        end;
        Break;
      end;

      if AdvPages[i].TabVisible then
        inc(j);

      inc(i);
      if (i >= FAdvPages.Count) then
        Break;

      //if AdvPages[i].TabVisible then
        //inc(j);
      FTabScroller.Visible := True;  // just to be counted in calculation
    end;
  end;

begin
  AnyTabVisible := False;
  VisTabCount := 0;
  FUseMaxSpace := False;
  if not ButtonSettings.ScrollButtonsAlways then
    FTabScroller.Visible := False;
  FTabScroller.Min := 0;
  FTabScroller.Max := GetScrollMax;
  if (FTabScroller.Max = 0) and not AnyTabVisible then
  begin
    FUseMaxSpace := True;
    FTabScroller.Max := GetScrollMax;
    if (FTabScroller.Max = 0) then
    begin
      //FUseMaxSpace := False;
      FTabScroller.Max := max(0, GetVisibleTabCount-1);
    end;
  end
  else
  if (AnyTabVisible) then
  begin
    if (FTabScroller.Position > FTabScroller.Max) then
      FTabScroller.Position := FTabScroller.Max;

    j := 0;
    for i:= 0 to FAdvPages.Count -1 do
    begin
      if AdvPages[i].TabVisible then
      begin
        inc(j);
        if (j >= FTabScroller.Position) then
          Break;
      end;
    end;
                                       // FF: 2nd tab overlaping scroll buttons 
    if (GetTabRect(j).Right = -1) and (FTabScroller.Position > 0) then
    begin
      FUseMaxSpace := True;
      FTabScroller.Max := GetScrollMax;
      if (FTabScroller.Max = 0) then
        FUseMaxSpace := False;
    end;
  end;
  FTabScroller.Visible := (FTabScroller.Min < FTabScroller.Max) or ButtonSettings.ScrollButtonsAlways;
  if (FTabScroller.Position > FTabScroller.Max) then
    FTabScroller.Position := FTabScroller.Max;

  InitializeAndUpdateButtons;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.PtOnTabScrollLeftBtn(X, Y: integer): Boolean;
var
  P: TPoint;
begin
  P := Point(X, Y);
  Result := PtInRect(GetTabScrollerLeftRect, P);
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.PtOnTabScrollRightBtn(X, Y: integer): Boolean;
var
  P: TPoint;
begin
  P := Point(X, Y);
  Result := PtInRect(GetTabScrollerRightRect, P);
end;

//------------------------------------------------------------------------------
{
procedure TAdvOfficePager.DrawTabScrollBtnLeft;
var
  R: TRect;
  y: Integer;
  Clr: TColor;
begin
  if FTabScroller.Visible then
  begin
    R := GetTabScrollerLeftRect;
    y := 0;
    case (TabPosition) of
      tpTop: y := ((R.Bottom - R.Top) - 12) div 2;
      tpBottom: y := 4 + ((R.Bottom - R.Top) - 12) div 2;
      tpLeft: y := ((R.Right - R.Left) - 12) div 2;
      tpRight: y := 4 + ((R.Right - R.Left) - 12) div 2;
    end;

    Clr := FCurrentOfficePagerStyler.TabAppearance.TextColor;
    if FScrollerDownLeftBtn then
      Clr := FCurrentOfficePagerStyler.TabAppearance.ColorSelected
    else if FScrollerHoverLeftBtn then
      Clr := FCurrentOfficePagerStyler.TabAppearance.ColorMirrorHotTo;

    if not FTabScroller.CanGoBack then
      Clr := clGray;
      
    with Canvas do
    begin
      //Brush.color:= Color;
      //FillRect(Rect(0,0,12,13));
      //Brush.Style := bsClear;
      //Rectangle(R);

      Pen.Color:= Clr;
      if TabPosition in [tpTop, tpBottom] then
      begin
          // |
        MoveTo(R.left+9, R.Top+y+0);
        LineTo(R.left+9, R.Top+y+8);
          // /
        MoveTo(R.left+9, R.Top+y+0);
        LineTo(R.left+5, R.Top+y+4);
          // \
        MoveTo(R.left+9, R.Top+y+8);
        LineTo(R.left+4, R.Top+y+3);
          // Fill arrow |
        MoveTo(R.left+8, R.Top+y+2);
        LineTo(R.left+8, R.Top+y+7);
        MoveTo(R.left+7, R.Top+y+3);
        LineTo(R.left+7, R.Top+y+6);
        Pixels[R.left+6, R.Top+y+4]:= Pen.Color;
      end
      else
      begin
          // |
        MoveTo(R.left+y, R.Top+9);
        LineTo(R.left+y+8, R.Top+9);
          // /
        MoveTo(R.left+y, R.Top+9);
        LineTo(R.left+y+4, R.Top+5);
          // \
        MoveTo(R.left+y+8, R.Top+9);
        LineTo(R.left+y+3, R.Top+4);
          // Fill arrow |
        MoveTo(R.left+y+2, R.Top+8);
        LineTo(R.left+y+7, R.Top+8);
        MoveTo(R.left+y+3, R.Top+7);
        LineTo(R.left+y+6, R.Top+7);
        Pixels[R.left+y+4, R.Top+6]:= Pen.Color;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.DrawTabScrollBtnRight;
var
  R: TRect;
  y: Integer;
  Clr: TColor;
begin
  if FTabScroller.Visible then
  begin
    R := GetTabScrollerRightRect;
    y := 0;
    case (TabPosition) of
      tpTop: y := ((R.Bottom - R.Top) - 12) div 2;
      tpBottom: y := 4 +((R.Bottom - R.Top) - 12) div 2;
      tpLeft: y := ((R.Right - R.Left) - 12) div 2;
      tpRight: y := 4 +((R.Right - R.Left) - 12) div 2;
    end;

    Clr := FCurrentOfficePagerStyler.TabAppearance.TextColor;
    if FScrollerDownRightBtn then
      Clr := FCurrentOfficePagerStyler.TabAppearance.ColorSelected
    else if FScrollerHoverRightBtn then
      Clr := FCurrentOfficePagerStyler.TabAppearance.ColorMirrorHotTo;

    if not FTabScroller.CanGoForward then
      Clr := clGray;

    with Canvas do
    begin
      //Brush.color:= Color;
      //FillRect(Rect(12,0,24,13));
      //Brush.Style := bsClear;
      //Rectangle(R);

      Pen.Color:= Clr;
      if TabPosition in [tpTop, tpBottom] then
      begin
          // |
        MoveTo(R.Left+3, R.Top+y);
        LineTo(R.Left+3, R.Top+y+8);
          // \
        MoveTo(R.Left+3, R.Top+y);
        LineTo(R.Left+7, R.Top+y+4);
          // /
        MoveTo(R.Left+3, R.Top+y+8);
        LineTo(R.Left+8, R.Top+y+3);
          // Fill Arrow |
        MoveTo(R.Left+4, R.Top+y+2);
        LineTo(R.Left+4, R.Top+y+7);
        MoveTo(R.Left+5, R.Top+y+3);
        LineTo(R.Left+5, R.Top+y+6);
        Pixels[R.Left+6, R.Top+y+4]:= Pen.Color;
      end
      else
      begin
          // |
        MoveTo(R.Left+y, R.Top+3);
        LineTo(R.Left+y+8, R.Top+3);
          // \
        MoveTo(R.Left+y, R.Top+3);
        LineTo(R.Left+y+4, R.Top+7);
          // /
        MoveTo(R.Left+y+8, R.Top+3);
        LineTo(R.Left+y+3, R.Top+8);
          // Fill Arrow |
        MoveTo(R.Left+y+2, R.Top+4);
        LineTo(R.Left+y+7, R.Top+4);
        MoveTo(R.Left+y+3, R.Top+5);
        LineTo(R.Left+y+6, R.Top+5);
        Pixels[R.Left+y+4, R.Top+6]:= Pen.Color;
      end;
    end;
  end;
end;
}
//------------------------------------------------------------------------------

procedure TAdvOfficePager.DrawTabScrollButtons;
var
  R: TRect;
begin
  //DrawTabScrollBtnLeft;
  //DrawTabScrollBtnRight;

  if (FTabScroller.Visible or (ButtonSettings.CloseButton and not CloseOnTab) or ButtonSettings.PageListButton) then
  begin
    R := GetButtonsRect;
    {case (TabPosition) of
      tpTop, tpBottom:
      begin
        R.Left := R.Right;
        R.Right := ClientRect.Right;
      end;
      tpLeft, tpRight:
      begin
        R.Top := R.Bottom;
        R.Bottom := ClientRect.Bottom;
      end;
    end; }

    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color := FCurrentOfficePagerStyler.PageAppearance.BorderColor;
    Canvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, 5, 5);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.ScrollLeftBtnClick;
begin
  if FTabScroller.Visible then
  begin
    if FTabScroller.CanGoBack then
    begin
      FTabScroller.Position := FTabScroller.Position - 1;
      InvalidateTab(-1);
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.ScrollRightBtnClick;
begin
  if FTabScroller.Visible then
  begin
    if FTabScroller.CanGoForward then
    begin
      FTabScroller.Position := FTabScroller.Position + 1;
      InvalidateTab(-1);
      if ActivePage <> nil then
        ActivePage.Invalidate;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetTabScrollerLeftRect: TRect;
begin
  Result := Rect(-1, -1, -1, -1);
  if FTabScroller.Visible then
  begin
    Result := GetTabScrollerRect;
    case TabPosition of
      tpTop, tpBottom:
      begin
        Result.Left := Result.Left + 3;
        Result.Right := Result.Left + PAGEBUTTON_SIZE; // (Result.Right - Result.Left) div 2 - 1;
      end;
      tpLeft, tpRight:
      begin
        //Result.Bottom := Result.Top + (Result.Bottom - Result.Top) div 2 - 1;
        Result.Top := Result.Top + 3;
        Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetCloseButtonRect: TRect;
var
  i: Integer;
  cbr, tr: TRect;
  ip: TPoint;
begin
  Result := Rect(-1, -1, -1, -1);
  if ButtonSettings.CloseButton then
  begin
    if CloseOnTab then
    begin
      if (ActivePageIndex >= 0) then
      begin
        case TabPosition of
          tpTop:
          begin
            Result := GetTabRect(ActivePageIndex);
            if (TabSettings.Width > 0) and (TabSettings.alignment = taCenter) and (ActivePageIndex >= 0) then
            begin
              GetCloseBtnImageAndTextRect(ActivePageIndex, cbr, tr, ip);
              Result.Left := cbr.Left;
            end
            else
            begin
              if (CloseOnTabPosition = cpRight) then
                Result.Left := Result.Right - PAGEBUTTON_SIZE - 4 - GetRightRoundingOffset
              else //CloseOnTabPosition = cpLeft
                Result.Left := Result.Left + 4 + GetLeftRoundingOffset;
            end;
            Result.Right := Result.Left + PAGEBUTTON_SIZE;
            Result.Bottom := Result.Bottom - 5;
            Result.Top := Result.Bottom - PAGEBUTTON_SIZE;
          end;
          tpBottom:
          begin
            Result := GetTabRect(ActivePageIndex);
            if (TabSettings.Width > 0) and (TabSettings.alignment = taCenter) and (ActivePageIndex >= 0) then
            begin
              GetCloseBtnImageAndTextRect(ActivePageIndex, cbr, tr, ip);
              Result.Left := cbr.Left;
            end
            else
            begin
              if (CloseOnTabPosition = cpRight) then
                Result.Left := Result.Right - PAGEBUTTON_SIZE - 4 - GetRightRoundingOffset
              else //CloseOnTabPosition = cpLeft
                Result.Left := Result.Left + 4 + GetLeftRoundingOffset;
            end;    
            Result.Right := Result.Left + PAGEBUTTON_SIZE;
            Result.Top := Result.Top + 5;
            Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
          end;
          tpLeft:
          begin
            if RotateTabLeftRight then
            begin
              Result := GetTabRect(ActivePageIndex);
              Result.Right := Result.Right - 5;
              Result.Left := Result.Right - PAGEBUTTON_SIZE;
              if (TabSettings.Width > 0) and (TabSettings.alignment = taCenter) and (ActivePageIndex >= 0) then
              begin
                GetCloseBtnImageAndTextRect(ActivePageIndex, cbr, tr, ip);
                Result.Top := cbr.Top;
              end
              else
              begin
                if (CloseOnTabPosition = cpRight) then
                  Result.Top := Result.Top + 4 + GetRightRoundingOffset
                else
                  Result.Top := Result.Bottom - PAGEBUTTON_SIZE - 4 - GetLeftRoundingOffset;
              end;
              Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
            end
            else
            begin
              Result := GetTabRect(ActivePageIndex);
              i := (Result.Bottom - Result.Top - PAGEBUTTON_SIZE) div 2;

              if (TabSettings.Width > 0) and (TabSettings.alignment = taCenter) and (ActivePageIndex >= 0) then
              begin
                GetCloseBtnImageAndTextRect(ActivePageIndex, cbr, tr, ip);
                Result.Left := cbr.Left;
              end
              else
              begin
                if (CloseOnTabPosition = cpRight) then
                  Result.Left := Result.Right - PAGEBUTTON_SIZE - 5
                else //CloseOnTabPosition = cpLeft
                  Result.Left := Result.Left + 4;
              end;
              Result.Right := Result.Left + PAGEBUTTON_SIZE;
              Result.Top := Result.Top + i;
              Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
            end;
          end;
          tpRight:
          begin
            if RotateTabLeftRight then
            begin
              Result := GetTabRect(ActivePageIndex);
              Result.Left := Result.Left + 5;
              Result.Right := Result.Left + PAGEBUTTON_SIZE;
              if (TabSettings.Width > 0) and (TabSettings.alignment = taCenter) and (ActivePageIndex >= 0) then
              begin
                GetCloseBtnImageAndTextRect(ActivePageIndex, cbr, tr, ip);
                Result.Bottom := cbr.Bottom;
              end
              else
              begin
                if (CloseOnTabPosition = cpRight) then
                  Result.Bottom := Result.Bottom - 4 - GetRightRoundingOffset
                else
                  Result.Bottom := Result.Top + PAGEBUTTON_SIZE + 4 + GetLeftRoundingOffset;
              end;    
              Result.Top := Result.Bottom - PAGEBUTTON_SIZE;
            end
            else
            begin
              Result := GetTabRect(ActivePageIndex);
              i := (Result.Bottom - Result.Top - PAGEBUTTON_SIZE) div 2;

              if (TabSettings.Width > 0) and (TabSettings.alignment = taCenter) and (ActivePageIndex >= 0) then
              begin
                GetCloseBtnImageAndTextRect(ActivePageIndex, cbr, tr, ip);
                Result.Left := cbr.Left;
              end
              else
              begin
                if (CloseOnTabPosition = cpRight) then
                  Result.Left := Result.Right - PAGEBUTTON_SIZE - 3
                else //CloseOnTabPosition = cpLeft
                  Result.Left := Result.Left + 5;
              end;    

              Result.Right := Result.Left + PAGEBUTTON_SIZE;
              Result.Top := Result.Top + i;
              Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
            end;
          end;
        end;
      end;
    end
    else
    begin
      case TabPosition of
        tpTop:
        begin
          if ButtonSettings.PageListButton then
          begin
            Result := GetPageListRect;
            Result.Left := Result.Right + 2;
            Result.Right := Result.Left + PAGEBUTTON_SIZE;
          end
          else if FTabScroller.Visible then
          begin
            Result := GetTabScrollerRightRect;
            Result.Left := Result.Right + 3;
            Result.Right := Result.Left + PAGEBUTTON_SIZE;
          end
          else
          begin
            Result := GetButtonsRect; // GetTabsRect;
            Result.Left := Result.Left + 3;
            Result.Right := Result.Left + PAGEBUTTON_SIZE;
            Result.Bottom := Result.Bottom - 5;
            Result.Top := Result.Bottom - PAGEBUTTON_SIZE;
          end;
        end;
        tpBottom:
        begin
          if ButtonSettings.PageListButton then
          begin
            Result := GetPageListRect;
            Result.Left := Result.Right + 2;
            Result.Right := Result.Left + PAGEBUTTON_SIZE;
          end
          else if FTabScroller.Visible then
          begin
            Result := GetTabScrollerRightRect;
            Result.Left := Result.Right + 3;
            Result.Right := Result.Left + PAGEBUTTON_SIZE;
          end
          else
          begin
            Result := GetButtonsRect; // GetTabsRect;
            Result.Left := Result.Left + 3;
            Result.Right := Result.Left + PAGEBUTTON_SIZE;
            Result.Top := Result.Top + 5;
            Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
          end;
        end;
        tpLeft:
        begin
          if ButtonSettings.PageListButton then
          begin
            Result := GetPageListRect;
            Result.Top := Result.Bottom + 2;
            Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
          end
          else if FTabScroller.Visible then
          begin
            Result := GetTabScrollerRightRect;
            Result.Top := Result.Bottom + 3;
            Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
          end
          else
          begin
            Result := GetButtonsRect; // GetTabsRect;
            Result.Top := Result.Top + 3;
            Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
            Result.Right := Result.Right - 5;
            Result.Left := Result.Right - PAGEBUTTON_SIZE;
          end;
        end;
        tpRight:
        begin
          if ButtonSettings.PageListButton then
          begin
            Result := GetPageListRect;
            Result.Top := Result.Bottom + 2;
            Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
          end
          else if FTabScroller.Visible then
          begin
            Result := GetTabScrollerRightRect;
            Result.Top := Result.Bottom + 3;
            Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
          end
          else
          begin
            Result := GetButtonsRect; // GetTabsRect;
            Result.Top := Result.Top + 3;
            Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
            Result.Left := Result.Left + 5;
            Result.Right := Result.Left + PAGEBUTTON_SIZE;
          end;
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetPageListRect: TRect;
begin
  Result := Rect(-1, -1, -1, -1);
  if ButtonSettings.PageListButton then
  begin
    case TabPosition of
      tpTop:
      begin
        if FTabScroller.Visible then
        begin
          Result := GetTabScrollerRightRect; // GetTabScrollerRect;
          Result.Left := Result.Right + 3;
          Result.Right := Result.Left + PAGEBUTTON_SIZE;
        end
        else
        begin
          Result := GetButtonsRect; // GetTabsRect;
          Result.Left := Result.Left + 3;
          Result.Right := Result.Left + PAGEBUTTON_SIZE;
          Result.Bottom := Result.Bottom - 5;
          Result.Top := Result.Bottom - PAGEBUTTON_SIZE;
        end;
      end;
      tpBottom:
      begin
        if FTabScroller.Visible then
        begin
          Result := GetTabScrollerRightRect;
          Result.Left := Result.Right + 3;
          Result.Right := Result.Left + PAGEBUTTON_SIZE;
        end
        else
        begin
          Result := GetButtonsRect;
          Result.Left := Result.Left + 3;
          Result.Right := Result.Left + PAGEBUTTON_SIZE;
          Result.Top := Result.Top + 5;
          Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
        end;
      end;
      tpLeft:
      begin
        if FTabScroller.Visible then
        begin
          Result := GetTabScrollerRightRect;
          Result.Top := Result.Bottom + 3;
          Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
        end
        else
        begin
          Result := GetButtonsRect;
          Result.Top := Result.Top + 3;
          Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
          Result.Right := Result.Right - 5;
          Result.Left := Result.Right - PAGEBUTTON_SIZE;
        end;
      end;
      tpRight:
      begin
        if FTabScroller.Visible then
        begin
          Result := GetTabScrollerRightRect;
          Result.Top := Result.Bottom + 3;
          Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
        end
        else
        begin
          Result := GetButtonsRect;
          Result.Top := Result.Top + 3;
          Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
          Result.Left := Result.Left + 5;
          Result.Right := Result.Left + PAGEBUTTON_SIZE;
        end;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetTabScrollerRect: TRect;
begin
  Result := Rect(-1, -1, -1, -1);
  if FTabScroller.Visible then
  begin
    Result := GetButtonsRect;
    case TabPosition of
      tpTop:
      begin
        Result.Right := Result.Left + 3 +(PAGEBUTTON_SIZE*2 + 2+ 3);// SCROLLER_SIZE;
        Result.Bottom := Result.Bottom - 5;
        Result.Top := Result.Bottom - PAGEBUTTON_SIZE;
      end;
      tpBottom:
      begin
        Result.Right := Result.Left + 3 +(PAGEBUTTON_SIZE*2 + 2+ 3);// SCROLLER_SIZE;
        Result.Top := Result.Top + 5;
        Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
      end;
      tpLeft:
      begin
        Result.Bottom := Result.Top + 3 +(PAGEBUTTON_SIZE*2 + 2+ 3);
        Result.Right := Result.Right - 5;
        Result.Left := Result.Right - PAGEBUTTON_SIZE;
      end;
      tpRight:
      begin
        Result.Bottom := Result.Top + 3 +(PAGEBUTTON_SIZE*2 + 2+ 3);
        Result.Left := Result.Left + 5;
        Result.Right := Result.Left + PAGEBUTTON_SIZE;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetTabScrollerRightRect: TRect;
begin
  Result := Rect(-1, -1, -1, -1);
  if FTabScroller.Visible then
  begin
    Result := GetTabScrollerLeftRect;// GetTabScrollerRect;
    case TabPosition of
      tpTop, tpBottom:
      begin
        Result.Left := Result.Right + 2;
        Result.Right := Result.Left + PAGEBUTTON_SIZE; // ((Result.Right - Result.Left) div 2);
      end;
      tpLeft, tpRight:
      begin
        //Result.Top := Result.Top + ((Result.Bottom - Result.Top) div 2);
        Result.Top := Result.Bottom + 2;
        Result.Bottom := Result.Top + PAGEBUTTON_SIZE;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CMHintShow(var Message: TMessage);
var
  PHI: PHintInfo;
begin
  PHI := TCMHintShow(Message).HintInfo;
  if ShowTabHint then
  begin
    if (FHintPageIndex >= 0) then
      PHI^.HintStr := AdvPages[FHintPageIndex].TabHint;
  end
  else
    PHI^.HintStr := '';
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.OnTabSettingsChanged(Sender: TObject);
begin
  SetPageValidCache(false);
  SetAllPagesPosition;
  InitializeAndUpdateButtons;
  UpdateTabScroller;
  Invalidate;
  if Assigned(ActivePage) then
    ActivePage.Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.UpdateMe(PropID: integer);
begin
  UpdatePageAppearanceOfPages;
  UpdateTabAppearanceOfPages;
  
  SetPageValidCache(false);
  Invalidate;
  if Assigned(ActivePage) then
    ActivePage.Invalidate;

  case PropID of
    2, 4: InitializeAndUpdateButtons;
  end;

  if Assigned(AdvOfficePagerStyler) then
  begin
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

{  pt := ScreenToClient(point(msg.xpos,msg.ypos));

  if (FCaption.Visible) and PtInRect(GetCaptionRect, pt)
     and (Msg.Result = htClient) and FCanMove then
  begin
    //MouseMove([],pt.X,pt.Y);

    Msg.Result := htCaption;
    //FInMove := true;

    SetWindowPos(GetParentForm(Self).Handle, HWND_TOP,0,0,0,0,  SWP_NOMOVE or SWP_NOSIZE);
  end;  }
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetVersion(const Value: string);
begin

end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetOfficeHint(const Value: TAdvHintInfo);
begin
  FOfficeHint.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetTabPosition(const Value: TTabPosition);
begin
  if (FTabPosition <> Value) then
  begin
    FTabPosition := Value;
    SetPageValidCache(false);
    SetAllPagesPosition;
    UpdateTabScroller;
    Invalidate;
    if Assigned(ActivePage) then
      ActivePage.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CMDialogChar(var Message: TCMDialogChar);
var
  I: Integer;
begin
  for I:= 0 to FAdvPages.Count-1 do
  begin
    if AdvPages[I].Caption <> '' then
    begin
      if IsAccel(Message.CharCode, AdvPages[I].Caption) and CanShowTab(I) and CanFocus then
      begin
        Message.Result := 1;
        ActivePageIndex := I;
        Exit;
      end;
    end
    else
    begin
      if IsAccel(Message.CharCode, AdvPages[I].WideCaption) and CanShowTab(I) and CanFocus then
      begin
        Message.Result := 1;
        ActivePageIndex := I;
        Exit;
      end;
    end;
  end;
  inherited;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.CanShowTab(PageIndex: Integer): Boolean;
begin
  Result := (PageIndex >= 0) and (PageIndex < FAdvPages.Count) and (AdvPages[PageIndex].TabVisible);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetAntiAlias(const Value: TAntiAlias);
begin
  FAntiAlias := Value;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetButtonSettings(
  const Value: TPageButtonSettings);
begin
  FButtonSettings.Assign(Value);
  Invalidate;
  if Assigned(ActivePage) then
    ActivePage.Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.OnButtonSettingChanged(Sender: TObject);
begin
  UpdateTabScroller;
  Invalidate;
  if (ActivePage <> nil) then
    ActivePage.Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetPageListMenu(const Value: TPopupMenu);
begin
  FPageListMenu := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetPageMargin(const Value: integer);
begin
  if FPageMargin <> Value then
  begin
    FPageMargin := Value;
    UpdateTabScroller;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetDockClientFromMousePos(MousePos: TPoint): TControl;
var
  Page: TAdvOfficePage;
  Tab: integer;
begin
  Result := nil;
  if DockSite then
  begin
    Tab := PTOnTab(mousepos.X, mousepos.Y);

    if (Tab >= 0) and (Tab < AdvPageCount) then
    begin
      Page := AdvPages[Tab];
      if Page.ControlCount > 0 then
      begin
        Result := Page.Controls[0];
        if Result.HostDockSite <> Self then Result := nil;
      end;
    end;
  end;
end;


//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetCloseOnTab(const Value: Boolean);
begin
  if (FCloseOnTab <> Value) then
  begin
    FCloseOnTab := Value;
    UpdateTabScroller;
    Invalidate;
    if (ActivePage <> nil) then
      ActivePage.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetCloseOnTabPosition(
  const Value: TCloseOnTabPos);
begin
  if (FCloseOnTabPosition <> Value) then
  begin
    FCloseOnTabPosition := Value;
    InitializeAndUpdateButtons;
    if (ActivePage <> nil) then
      ActivePage.Invalidate;
    Invalidate;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetRotateTabLeftRight(const Value: Boolean);
begin
  if (FRotateTabLeftRight <> Value) then
  begin
    FRotateTabLeftRight := Value;
    UpdateTabScroller;
    Invalidate;
    if Assigned(ActivePage) then
      ActivePage.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetVisibleTabCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FAdvPages.Count-1 do
  begin
    if (AdvPages[I].TabVisible) then
      Result := Result + 1;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.Init;
begin
  FPropertiesLoaded := true;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.CloseActivePage : Boolean;
var lPage : TAdvOfficePage;

begin
  Result := true;
  if Assigned(ActivePage) then begin
    lPage := ActivePage;
    OnCloseButtonClick(self);
    Result := lPage <> ActivePage;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.CanShowCloseButton: Boolean;
begin
  Result := ButtonSettings.CloseButton;
  if Assigned(ActivePage) then
    Result := ActivePage.ShowClose and Result;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.InitializeAndUpdateButtons;
var
  R: TRect;
begin
  if (not FPropertiesLoaded) and not (csDesigning in ComponentState) then
    Exit;

  if ButtonSettings.CloseButton{ and not CloseOnTab} and (CanShowCloseButton or not CloseOnTab) then
  begin
    if (FCloseButton = nil) then
    begin
      FCloseButton := TAdvGlowButton.Create(Self);
      FCloseButton.Parent := Self;
      FCloseButton.OnClick := OnCloseButtonClick;
    end;

    R := GetCloseButtonRect;
    FCloseButton.Left := R.Left;
    FCloseButton.Top := R.Top;
    FCloseButton.Width := R.Right - R.Left;
    FCloseButton.Height := R.Bottom - R.Top;
    if Assigned(FCurrentOfficePagerStyler) then
      FCloseButton.Appearance.Assign(FCurrentOfficePagerStyler.GlowButtonAppearance);
    FCloseButton.Picture.Assign(ButtonSettings.CloseButtonPicture);
    FCloseButton.Hint := ButtonSettings.CloseButtonHint;
    FCloseButton.ShowHint := True;
    FCloseButton.Enabled := GetVisibleTabCount > 0; //(ActivePage <> nil);
    if FCloseButton.Enabled then
      if not CloseOnTab then
        FCloseButton.Enabled := CanShowCloseButton;
  end
  else
  if (FCloseButton <> nil) then
  begin
    //FCloseButton.Free;
    PostMessage(Handle, WM_OPDESTROYCLOSEBTN, Integer(Pointer(FCloseButton)), 0);
    FCloseButton := nil;
  end;

  if ButtonSettings.PageListButton then
  begin
    if (FPageListButton = nil) then
    begin
      FPageListButton := TAdvGlowButton.Create(Self);
      FPageListButton.Parent := Self;
      FPageListButton.OnClick := OnPageListButtonClick;
    end;

    R := GetPageListRect;
    FPageListButton.Left := R.Left;
    FPageListButton.Top := R.Top;
    FPageListButton.Width := R.Right - R.Left;
    FPageListButton.Height := R.Bottom - R.Top;
    if Assigned(FCurrentOfficePagerStyler) then
      FPageListButton.Appearance.Assign(FCurrentOfficePagerStyler.GlowButtonAppearance);
    FPageListButton.Picture.Assign(ButtonSettings.PageListButtonPicture);
    FPageListButton.Hint := ButtonSettings.PageListButtonHint;
    FPageListButton.ShowHint := True;
    FPageListButton.Enabled := GetVisibleTabCount > 0; //(AdvPageCount > 0);
  end
  else
  if (FPageListButton <> nil) then
  begin
    FPageListButton.Free;
    FPageListButton := nil;
  end;

  if (FTabScroller.Visible) then
  begin
    if (FScrollPrevButton = nil) then
    begin
      FScrollPrevButton := TAdvGlowButton.Create(Self);
      FScrollPrevButton.Parent := Self;
      FScrollPrevButton.OnClick := OnScrollPrevButtonClick;
    end;
    R := GetTabScrollerLeftRect;
    FScrollPrevButton.Left := R.Left;
    FScrollPrevButton.Top := R.Top;
    FScrollPrevButton.Width := R.Right - R.Left;
    FScrollPrevButton.Height := R.Bottom - R.Top;
    if Assigned(FCurrentOfficePagerStyler) then
      FScrollPrevButton.Appearance.Assign(FCurrentOfficePagerStyler.GlowButtonAppearance);

    if (TabPosition in [tpLeft, tpRight]) {and not RotateTabLeftRight} then
    begin
      if ButtonSettings.FPrevPictureChanged then
        FScrollPrevButton.Picture.Assign(ButtonSettings.ScrollButtonPrevPicture)
      else
        FScrollPrevButton.Picture.Assign(ButtonSettings.FScrollButtonUpPicture);
    end
    else
      FScrollPrevButton.Picture.Assign(ButtonSettings.ScrollButtonPrevPicture);

    FScrollPrevButton.Hint := ButtonSettings.ScrollButtonPrevHint;
    FScrollPrevButton.ShowHint := True;
    FScrollPrevButton.Enabled := FTabScroller.CanGoBack;
    FScrollPrevButton.RepeatClick := True;

    if (FScrollNextButton = nil) then
    begin
      FScrollNextButton := TAdvGlowButton.Create(Self);
      FScrollNextButton.Parent := Self;
      FScrollNextButton.OnClick := OnScrollNextButtonClick;
    end;
    R := GetTabScrollerRightRect;
    FScrollNextButton.Left := R.Left;
    FScrollNextButton.Top := R.Top;
    FScrollNextButton.Width := R.Right - R.Left;
    FScrollNextButton.Height := R.Bottom - R.Top;
    if Assigned(FCurrentOfficePagerStyler) then
      FScrollNextButton.Appearance.Assign(FCurrentOfficePagerStyler.GlowButtonAppearance);

    if (TabPosition in [tpLeft, tpRight]) {and not RotateTabLeftRight} then
    begin
      if ButtonSettings.FNextPictureChanged then
        FScrollNextButton.Picture.Assign(ButtonSettings.ScrollButtonNextPicture)
      else
        FScrollNextButton.Picture.Assign(ButtonSettings.FScrollButtonDownPicture);
    end
    else
      FScrollNextButton.Picture.Assign(ButtonSettings.ScrollButtonNextPicture);
    FScrollNextButton.Hint := ButtonSettings.ScrollButtonNextHint;
    FScrollNextButton.ShowHint := True;
    FScrollNextButton.Enabled := FTabScroller.CanGoForward;
    FScrollNextButton.RepeatClick := True;
  end
  else
  begin
    if (FScrollPrevButton <> nil) then
    begin
      FScrollPrevButton.Free;
      FScrollPrevButton := nil;
    end;

    if (FScrollNextButton <> nil) then
    begin
      FScrollNextButton.Free;
      FScrollNextButton := nil;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.OnCloseButtonClick(Sender: TObject);
var
  Allow: Boolean;
  ActTabIndex: Integer;
  NewActivePage: TAdvOfficePage;
begin
  if (ActivePageIndex >= 0) and not FIsClosing then
  begin
    Allow := True;
    FIsClosing := True;
    if Assigned(FOnClosePage) then
      FOnClosePage(Self, ActivePageIndex, Allow);

    if Allow then
    begin
      if Assigned(AdvPages[ActivePageIndex].FTimer) then
        FreeAndNil(AdvPages[ActivePageIndex].FTimer);

      ActTabIndex := ActivePageIndex;
      SelectNextPage(True);
      NewActivePage := ActivePage;
      InvalidateTab(-1);

      if FreeOnClose then
      begin
        AdvPages[ActTabIndex].Free;
        FActivePageIndex := -1;
        ActivePage := NewActivePage;
        //SelectNextPage(True);
      end
      else if (ActTabIndex >= 0) then
      begin
        AdvPages[ActTabIndex].TabVisible := False;
        AdvPages[ActTabIndex].Visible := False;
      end;

      UpdateTabScroller;

      if Assigned(ActivePage) then
        ActivePage.Invalidate
      else
        Invalidate;

      if Assigned(FOnClosedPage) then
        FOnClosedPage(Self, ActTabIndex);
    end;
    FIsClosing := False;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.OnPageListMenuClick(Sender: TObject);
begin
  if (Sender is TMenuItem) and ((TMenuItem(Sender).Tag >= 0) and (TMenuItem(Sender).Tag < FAdvPages.Count)) then
  begin
    ActivePageIndex := TMenuItem(Sender).Tag;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.OnPageListButtonClick(Sender: TObject);
var
  I: Integer;
  MenuItem: TMenuItem;
  P: TPoint;
  R: TRect;
begin
  if Assigned(PageListMenu) and (ButtonSettings.PageListButton) then
  begin
    PageListMenu.Items.Clear;
    for I := 0 to FAdvPages.Count-1 do
    begin
      if AdvPages[I].TabVisible then
      begin
        MenuItem := TMenuItem.Create(self);
        if AdvPages[I].Caption <> '' then
          MenuItem.Caption := AdvPages[I].Caption
        else
          MenuItem.Caption := AdvPages[I].WideCaption;
        MenuItem.RadioItem := True;
        MenuItem.Checked := ActivePageIndex = I;
        MenuItem.Tag := I;
        MenuItem.OnClick := OnPageListMenuClick;
        PageListMenu.Items.Add(MenuItem);
      end;
    end;

    if (FPageListButton <> nil) then
    begin
      case (TabPosition) of
        tpTop:
        begin
          R := GetPageListRect;
          P.X := R.Left + self.Left;
          P.Y := R.Bottom + self.Top;

          p := Parent.ClientToScreen(p);

          (*
          {$IFNDEF TMSDOTNET}
          SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
          {$ENDIF}
          {$IFDEF TMSDOTNET}
          SystemParametersInfo(SPI_GETWORKAREA, 0, R, 0);
          {$ENDIF}

          if R.Bottom < (P.Y + FOptionWindow.Height + 2) then
            spt.Y := spt.Y - ((spt.Y + FOptionWindow.Height + 2) - R.Bottom);

          if (R.Right < spt.X + FOptionWindow.Width) then
          begin
            if Position = daRight then
              spt.X := ClientToScreen(Point(Left - FOptionWindow.Width, Top + Height + 1)).X
            else
              spt.X := spt.X - ((spt.X + FOptionWindow.Width) - R.Right);
          end; *)  
        end;
        tpBottom:
        begin
          R := GetPageListRect;
          P.X := R.Left + self.Left;
          P.Y := R.Bottom + self.Top;
          p := Parent.ClientToScreen(p);
          if (GetSystemMetrics(SM_CYMENU) * PageListMenu.Items.Count) + P.Y + 10 >
          {$IFDEF DELPHI6_LVL}
            Screen.MonitorFromPoint(P).Height then
          {$ELSE}
            Screen.Height then
          {$ENDIF}
          begin
            if (FPageListButton <> nil) then
              Dec(P.Y, (GetSystemMetrics(SM_CYMENU) * PageListMenu.Items.Count) + (FPageListButton.Height) + 4);
          end;
        end;
        tpLeft:
        begin
          R := GetPageListRect;
          P.X := R.Right + self.Left;
          P.Y := R.Top + self.Top;
          p := Parent.ClientToScreen(p);
        end;
        tpRight:
        begin
          R := GetPageListRect;
          P.X := R.Right + self.Left;
          P.Y := R.Top + self.Top;
          p := Parent.ClientToScreen(p);
        end;
      end;

      if Assigned(FOnPageListClick) then
        FOnPageListClick(Self, P.X, P.Y)
      else
        PageListMenu.Popup(P.X, P.Y);
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.OnScrollPrevButtonClick(Sender: TObject);
begin
  ScrollLeftBtnClick;
  InitializeAndUpdateButtons;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.OnScrollNextButtonClick(Sender: TObject);
begin
  ScrollRightBtnClick;
  InitializeAndUpdateButtons;
  //if (FScrollNextButton <> nil) and not FScrollNextButton.Enabled then
    //FScrollNextButton.Invalidate;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.AnyButtonVisible: Boolean;
begin
  Result := (FTabScroller.Visible or (ButtonSettings.CloseButton and not CloseOnTab) or ButtonSettings.PageListButton);
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.CreateShortCutHintWin: TShortCutHintWindow;
begin
  Result := TShortCutHintWindow.Create(Self);
  Result.Parent := Self;
  FShortCutHintWinList.Add(Result);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.DestroyShortCutHintWin(
  ShortCutWin: TShortCutHintWindow);
var
  i: Integer;
begin
  i := FShortCutHintWinList.IndexOf(ShortCutWin);
  if (i >= 0) then
  begin
    TShortCutHintWindow(FShortCutHintWinList.Items[i]).Free;
    FShortCutHintWinList.Items[i] := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.HideShortCutHintOfAllPages;
var
  i: Integer;
  p: TWinControl;
begin
  for I:= 0 to FAdvPages.Count-1 do
  begin
    AdvPages[I].HideShortCutHint;
  end;
  FTabShortCutHintShowing := False;


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

//------------------------------------------------------------------------------

procedure TAdvOfficePager.ShowShortCutHintOfAllPages;
var
  i: Integer;
  p: TWinControl;
begin
  if FShowShortCutHints then
  begin
    for I:= 0 to FAdvPages.Count-1 do
    begin
      AdvPages[I].ShowShortCutHint;
    end;
    FTabShortCutHintShowing := True;
    FTabShortCutChars := '';


    if not (csDesigning in ComponentState) and not Assigned(FFormWndProc) then
    begin
      p := self;

      repeat
        p := p.Parent;
      until (p is TForm) {$IFNDEF TMSDOTNET} or (p is TActiveForm) {$ENDIF} or not Assigned(p);

      if Assigned(p) then
      begin
        FFormWndProc := p.WindowProc;
        p.WindowProc := SubClassProc;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.WMKeyDown(var Message: TWMKeyDown);
var
  i, c: Integer;
  s, sub: String;
  found: Boolean;
  Ctrl: TWinControl;
begin
  case Message.CharCode of
    VK_LEFT, VK_UP:
    begin
      HideShortCutHintOfAllPages;
      SelectNextPage(False);
    end;
    VK_RIGHT, VK_DOWN:
    begin
      HideShortCutHintOfAllPages;
      SelectNextPage(True);
    end;
    {VK_DOWN:
    begin
      if Assigned(ActivePage) and Focused and (ActivePage.ControlCount > 0) then
      begin
        ATB := ActivePage.GetFirstToolBar(True);
        ATB.SetFocus;
        HideShortCutHintOfAllPages;
        ActivePage.ShowShortCutHintOfAllToolBars;
      end;
    end;}
    VK_ESCAPE:
    begin
      HideShortCutHintOfAllPages;
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
    else
    begin
      if FTabShortCutHintShowing then
      begin
        s := char(Message.CharCode);
        FTabShortCutChars := FTabShortCutChars + s;
        found := False;
        c := 0;
        for i := 0 to FAdvPages.Count-1 do
        begin
          if (UpperCase(AdvPages[i].ShortCutHint) = UpperCase(FTabShortCutChars)) then
          begin
            HideShortCutHintOfAllPages;
            ActivePageIndex := i;
            if Assigned(ActivePage) then
            begin
              {ATB := ActivePage.GetFirstToolBar(True);
              ATB.SetFocus;
              ActivePage.ShowShortCutHintOfAllToolBars; }
            end;
            found := True;
            Break;
          end
          else if (Length(AdvPages[i].ShortCutHint) > 0) then
          begin
            sub := Copy(AdvPages[i].ShortCutHint, 1, Length(FTabShortCutChars));
            if (UpperCase(sub) <> UpperCase(FTabShortCutChars)) then
            begin
              AdvPages[i].HideShortCutHint;
            end
            else
            begin
              found := True;
            end;
          end;

          if Assigned(AdvPages[i].FShortCutHint) and (AdvPages[i].FShortCutHint.Visible) then
          begin
            Inc(c);
          end;
        end;

        if (c = 0) then
          FTabShortCutHintShowing := False;

        if not found then
        begin
          Beep;
        end;
      end;
    end;
  end;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS + DLGC_WANTCHARS{ + DLGC_WANTTAB};
  {using DLGC_WANTTAB, disabled default Tab key functioning}
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.CMDialogKey(var Message: TCMDialogKey);
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

procedure TAdvOfficePager.CMFocusChanged(var Message: TCMFocusChanged);
{var
  i: Integer;
  h: HWND;
  Active: Boolean;}
begin
  inherited;

 { Active := Self.Focused;
  if not Active and (Message.Sender <> Self) and (self.HandleAllocated) then
  begin
    h := GetFocus;
    i := 1;
    while (h <> 0) do
    begin
      if (h = self.Handle) then
      begin
        Active := True;
        Break;
      end;
      h := GetParent(h);
      inc(i);
      if (i > 50) then
        Break;
    end;
  end;
  }
  if (Message.Sender <> Self) and FTabShortCutHintShowing then
  begin
    HideShortCutHintOfAllPages;
  end;

  if (Message.Sender = Self) and not (csLoading in ComponentState) and not (csDesigning in ComponentState) then
    ShowShortCutHintOfAllPages;

  InvalidateTab(-1);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.WMKillFocus(var Message: TWMSetFocus);
begin
  inherited;

  if FTabShortCutHintShowing then
  begin
    HideShortCutHintOfAllPages;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.WndProc(var Msg: TMessage);
var
  p: TWinControl;
  cb: TAdvGlowButton;
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
  end
  else if (Msg.Msg = WM_OPDESTROYCLOSEBTN) then
  begin
    if (Msg.WParam <> 0) then
    begin
      cb := TAdvGlowButton(Pointer(Msg.WParam));
      cb.Free;
    end;
  end;

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SubclassProc(var Msg: TMessage);
begin
  if not Assigned(FFormWndProc) then
    Exit;
    
  FFormWndProc(Msg);

  //if (Msg.Msg = WM_CLOSE) then

  if ((Msg.Msg = WM_MOVING) or (Msg.Msg = WM_LBUTTONDOWN) or (Msg.Msg = WM_SIZE)) or
     ((Msg.Msg = WM_SYSCOMMAND) and ((Msg.WParam = SC_MAXIMIZE) or (Msg.WParam = SC_MINIMIZE))) then
  begin
    HideShortCutHintOfAllPages;
  end;

end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.DragDrop(Source: TObject; X, Y: Integer);
var
  CurIndex, NewIndex: Integer;
begin
  inherited;
  CurIndex := ActivePageIndex;
  NewIndex := PTOnTab(X, Y);
  if (CurIndex >= 0) and (CurIndex < AdvPageCount) and (NewIndex >= 0) and (NewIndex < AdvPageCount) and (CurIndex <> NewIndex) then
  begin
    MoveAdvPage(CurIndex, NewIndex);
    Invalidate;
    if Assigned(ActivePage) then
      ActivePage.Invalidate;
  end;
end;

procedure TAdvOfficePager.CMDockClient(var Message: TCMDockClient);
var
  IsVisible: Boolean;
  DockCtl: TControl;
  I: Integer;
begin
  Message.Result := 0;
  DockCtl := Message.DockSource.Control;
  { First, look and see if the page is already docked. If it is,
    then simply move the page index to the end }
  for I := 0 to AdvPageCount - 1 do
  begin
    if DockCtl.Parent = AdvPages[I] then
    begin
      { We did find it; just move the page to the end }
      AdvPages[I].PageIndex := AdvPageCount - 1;
      Exit;
    end;
  end;

  FNewPage := TAdvOfficePage.Create(Self);
  try
    try
      FNewPage.AdvOfficePager := Self;
      DockCtl.Dock(Self, Message.DockSource.DockRect);
    except
      FNewPage.Free;
      raise;
    end;
    IsVisible := DockCtl.Visible;
    FNewPage.TabVisible := IsVisible;
    if IsVisible then
      ActivePage := FNewPage;
    DockCtl.Align := alClient;

    if DockCtl is TCustomForm then
    begin
      FNewPage.Caption := TCustomForm(DockCtl).Caption;
    end;

  finally
    FNewPage := nil;
  end;
end;

procedure TAdvOfficePager.CMDockNotification(var Message: TCMDockNotification);
var
  I: Integer;
  S: string;
  Page: TAdvOfficePage;
begin
  Page := GetPageFromDockClient(Message.Client);
  if Page <> nil then
    case Message.NotifyRec.ClientMsg of
      WM_SETTEXT:
        begin
          S := PChar(Message.NotifyRec.MsgLParam);
          { Search for first CR/LF and end string there }
          for I := 1 to Length(S) do
          {$IFDEF DELPHI_UNICODE}
            if CharInSet(S[I],[#13,#10]) then
          {$ENDIF}
          {$IFNDEF DELPHI_UNICODE}
            if S[I] in [#13, #10] then
          {$ENDIF}
            begin
              SetLength(S, I - 1);
              Break;
            end;

          if (Message.Client is TCustomForm) then
            Page.Caption := (Message.Client as TCustomForm).Caption
          else
            Page.Caption := S;
          
        end;
      CM_VISIBLECHANGED:
        Page.TabVisible := Boolean(Message.NotifyRec.MsgWParam);
    end;
  inherited;
end;

procedure TAdvOfficePager.CMUnDockClient(var Message: TCMUnDockClient);
var
  Page: TAdvOfficePage;
begin
  Message.Result := 0;
  Page := GetPageFromDockClient(Message.Client);
  if Page <> nil then
  begin
    FUndockPage := Page;
    Message.Client.Align := alNone;
  end;
end;



procedure TAdvOfficePager.DoAddDockClient(Client: TControl; const ARect: TRect);
begin
  if FNewPage <> nil then
    Client.Parent := FNewPage;
end;

procedure TAdvOfficePager.DockOver(Source: TDragDockObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  R: TRect;
begin
  GetWindowRect(Handle, R);
  Source.DockRect := R;
  DoDockOver(Source, X, Y, State, Accept);
end;

procedure TAdvOfficePager.DoRemoveDockClient(Client: TControl);
begin
  if (FUndockPage <> nil) and not (csDestroying in ComponentState) then
  begin
    SelectNextPage(True);
    FUndockPage.Free;
    FUndockPage := nil;
  end;
end;

function TAdvOfficePager.GetPageFromDockClient(Client: TControl): TAdvOfficePage;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to AdvPageCount - 1 do
  begin
    if (Client.Parent = AdvPages[I]) and (Client.HostDockSite = Self) then
    begin
      Result := AdvPages[I];
      Exit;
    end;
  end;
end;



//------------------------------------------------------------------------------

procedure TAdvOfficePager.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  i: Integer;
begin
  inherited;
  i := PTOnTab(X, Y);
  Accept := (i >= 0) and (i < AdvPageCount) and (Source = Self);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('NextPictureChanged', ReadNextPicChanged, WriteNextPicChanged, True);
  Filer.DefineProperty('PrevPictureChanged', ReadPrevPicChanged, WritePrevPicChanged, True);
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetNextPictureChanged: Boolean;
begin
  Result := FButtonSettings.FNextPictureChanged;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetPrevPictureChanged: Boolean;
begin
  Result := FButtonSettings.FPrevPictureChanged;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetNextPictureChanged(const Value: Boolean);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetPrevPictureChanged(const Value: Boolean);
begin

end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.ReadNextPicChanged(Reader: TReader);
begin
  FButtonSettings.FNextPictureChanged := Reader.ReadBoolean;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.ReadPrevPicChanged(Reader: TReader);
begin
  FButtonSettings.FPrevPictureChanged := Reader.ReadBoolean;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.WriteNextPicChanged(Writer: TWriter);
begin
  Writer.WriteBoolean(FButtonSettings.FNextPictureChanged);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.WritePrevPicChanged(Writer: TWriter);
begin
  Writer.WriteBoolean(FButtonSettings.FPrevPictureChanged);
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.UseOldDrawing: Boolean;
begin
  Result := (TabSettings.Shape = tsRectangle) and (TabSettings.Rounding = 1);
  if not Result and (TabPosition in [tpLeft, tpRight]) and not RotateTabLeftRight then
    Result := (TabSettings.Rounding = 1);
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.IsActivePageNeighbour(
  PageIndex: Integer): Integer;
var
  i: Integer;  
begin
  Result := 0;
  if (PageIndex = ActivePageIndex) or (PageIndex < 0) or (PageIndex >= AdvPageCount) then
    Exit;

  if (PageIndex < ActivePageIndex) then
  begin
    for i:= ActivePageIndex - 1 downto PageIndex do
    begin
      if AdvPages[i].TabVisible then
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
      if AdvPages[i].TabVisible then
      begin
        if (i = PageIndex) then
          Result := 1;
        Break;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetLeftRoundingOffset: Integer;
begin
  Result := 0;
  if (TabSettings.Shape in [tsLeftRamp, tsLeftRightRamp]) and not UseOldDrawing and not ((TabPosition in [tpLeft, tpRight]) and not RotateTabLeftRight) then
    Result := TabSettings.Rounding * 2 + 5;
end;

//------------------------------------------------------------------------------

function TAdvOfficePager.GetRightRoundingOffset: Integer;
begin
  Result := 0;
  if (TabSettings.Shape in [tsRightRamp, tsLeftRightRamp]) and not UseOldDrawing and not ((TabPosition in [tpLeft, tpRight]) and not RotateTabLeftRight) then
    Result := TabSettings.Rounding * 2 + 5;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.SetPageValidCache(Value: Boolean);
var
  i: Integer;
begin
  for i := 0 to AdvPageCount -1 do
    AdvPages[i].FValidCache := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.UpdatePageAppearanceOfPages;
var
  i: Integer;
begin
  if not (csDesigning in ComponentState) or not Assigned(FCurrentOfficePagerStyler) then
    Exit;

  for i := 0 to AdvPageCount -1 do
  begin
    if not AdvPages[i].UsePageAppearance then
      AdvPages[i].PageAppearance.Assign(FCurrentOfficePagerStyler.PageAppearance);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.UpdateTabAppearanceOfPages;
var
  i: Integer;
begin
  if not (csDesigning in ComponentState) or not Assigned(FCurrentOfficePagerStyler) then
    Exit;

  for i := 0 to AdvPageCount -1 do
  begin
    if not AdvPages[i].UseTabAppearance then
      AdvPages[i].TabAppearance.Assign(FCurrentOfficePagerStyler.TabAppearance);
  end;
end;

//------------------------------------------------------------------------------

type
  TOverrideControl = class(TControl);


procedure TAdvOfficePager.WMLButtonDown(var Message: TWMLButtonDown);

var
  DockCtl: TControl;
  p: TPoint;
begin
  inherited;
  p := Point(Message.XPos, Message.YPos);
  DockCtl := GetDockClientFromMousePos(p);
  if (DockCtl <> nil) then
    if (TOverrideControl(DockCtl).DragMode = dmAutomatic) and (TOverrideControl(DockCtl).DragKind = dkDock) then
      DockCtl.BeginDrag(False);
end;

//------------------------------------------------------------------------------

procedure TAdvOfficePager.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  Tab: integer;
  p: TPoint;
  DockCtl: TControl;

begin
  inherited;

  p := Point(Message.XPos, Message.YPos);

  DockCtl := GetDockClientFromMousePos(p);
  if DockCtl <> nil then DockCtl.ManualDock(nil, nil, alNone);

  if PtInRect(GetTabsArea, p) then
  begin
    Tab := PTOnTab(p.X, p.Y);
    if (Tab >= 0) then
    begin
      if Assigned(FOnTabDblClick) then
        FOnTabDblClick(Self, Tab);
    end;
  end;
end;

//------------------------------------------------------------------------------

{ TPageButtonSettings }

constructor TPageButtonSettings.Create;
begin
  inherited;
  FPageListButton := False;
  FCloseButton := False;

  FScrollButtonNextPicture := TGDIPPicture.Create;
  FScrollButtonNextPicture.LoadFromResourceName(hinstance,'TMSAONEXT');
  FScrollButtonNextPicture.OnChange := OnPictureChanged;
  FNextPictureChanged := False;

  FScrollButtonPrevPicture := TGDIPPicture.Create;
  FScrollButtonPrevPicture.LoadFromResourceName(hinstance,'TMSAOPREV');
  FScrollButtonPrevPicture.OnChange := OnPictureChanged;
  FPrevPictureChanged := False;

  FPageListButtonPicture := TGDIPPicture.Create;
  FPageListButtonPicture.LoadFromResourceName(hinstance,'TMSAOLIST');
  FPageListButtonPicture.OnChange := OnPictureChanged;

  FCloseButtonPicture := TGDIPPicture.Create;
  FCloseButtonPicture.LoadFromResourceName(hinstance,'TMSAOCLOSE');
  FCloseButtonPicture.OnChange := OnPictureChanged;

  FScrollButtonPrevHint := 'Previous';
  FScrollButtonNextHint := 'Next';
  FCloseButtonHint := 'Close';;
  FPageListButtonHint := 'Page List';
  FScrollButtonsAlways := False;

  FScrollButtonDownPicture := TGDIPPicture.Create;
  FScrollButtonDownPicture.LoadFromResourceName(hinstance,'TMSAODOWN');

  FScrollButtonUpPicture := TGDIPPicture.Create;
  FScrollButtonUpPicture.LoadFromResourceName(hinstance,'TMSAOUP');
end;

//------------------------------------------------------------------------------

destructor TPageButtonSettings.Destroy;
begin
  FScrollButtonNextPicture.Free;
  FScrollButtonPrevPicture.Free;
  FPageListButtonPicture.Free;
  FCloseButtonPicture.Free;
  FScrollButtonDownPicture.Free;
  FScrollButtonUpPicture.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TPageButtonSettings.Assign(Source: TPersistent);
begin
  if (Source is TPageButtonSettings) then
  begin
    FPageListButton := (Source as TPageButtonSettings).FPageListButton;
    FCloseButton := (Source as TPageButtonSettings).FCloseButton;
    FScrollButtonNextPicture.Assign((Source as TPageButtonSettings).FScrollButtonNextPicture);
    FScrollButtonPrevPicture.Assign((Source as TPageButtonSettings).FScrollButtonPrevPicture);
    FPageListButtonPicture.Assign((Source as TPageButtonSettings).FPageListButtonPicture);
    FCloseButtonPicture.Assign((Source as TPageButtonSettings).FCloseButtonPicture);
    FScrollButtonsAlways := (Source as TPageButtonSettings).ScrollButtonsAlways;
  end
  else
    inherited Assign(Source);
end;

//------------------------------------------------------------------------------

procedure TPageButtonSettings.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

//------------------------------------------------------------------------------

procedure TPageButtonSettings.OnPictureChanged(Sender: TObject);
begin
  FNextPictureChanged := FNextPictureChanged or (Sender = FScrollButtonNextPicture);
  FPrevPictureChanged := FPrevPictureChanged or (Sender = FScrollButtonPrevPicture);
  
  Changed;
end;

//------------------------------------------------------------------------------

procedure TPageButtonSettings.SetCloseButton(const Value: Boolean);
begin
  if (FCloseButton <> Value) then
  begin
    FCloseButton := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPageButtonSettings.SetCloseButtonPicture(
  const Value: TGDIPPicture);
begin
  FCloseButtonPicture.Assign(Value);
  Changed;
end;

//------------------------------------------------------------------------------

procedure TPageButtonSettings.SetPageListButton(const Value: boolean);
begin
  if (FPageListButton <> Value) then
  begin
    FPageListButton := Value;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

procedure TPageButtonSettings.SetPageListButtonPicture(
  const Value: TGDIPPicture);
begin
  FPageListButtonPicture.Assign(Value);
  Changed;
end;

//------------------------------------------------------------------------------

procedure TPageButtonSettings.SetScrollButtonNextPicture(
  const Value: TGDIPPicture);
begin
  FScrollButtonNextPicture.Assign(Value);
  Changed;
end;

//------------------------------------------------------------------------------

procedure TPageButtonSettings.SetScrollButtonPrevPicture(
  const Value: TGDIPPicture);
begin
  FScrollButtonPrevPicture.Assign(Value);
  Changed;
end;

//------------------------------------------------------------------------------

procedure TPageButtonSettings.SetScrollButtonsAlways(const Value: Boolean);
begin
  if (FScrollButtonsAlways <> Value) then
  begin
    FScrollButtonsAlways := Value;
    Changed;
  end;
end;

{$IFDEF FREEWARE}
function Scramble(s:string): string;
var
  r:string;
  i: integer;
  c: char;
  b: byte;
begin
  r := '';
  for i := 1 to length(s) do
  begin
    b := ord(s[i]);
    b := (b and $E0) + ((b and $1F) xor 5);
    c := chr(b);
    r := r + c;
  end;
  Result := r;
end;
{$ENDIF}

//------------------------------------------------------------------------------
initialization
  WM_OPDESTROYCLOSEBTN := RegisterWindowMessage('OPDESTROYCLOSEBTN');

{$IFDEF FREEWARE}
  if  (FindWindow(PChar(Scramble('QDuuilfdqljk')), nil) = 0) OR
      (FindWindow(PChar(Scramble('QDuuGplia`w')), nil) = 0) then
  begin
    MessageBox(0,PChar(Scramble('Duuilfdqljk%pv`v%qwldi%s`wvljk%jc%QHV%vjcqrdw`%fjhujk`kqv+')+#13#10+Scramble('Fjkqdfq%QHV%vjcqrdw`%mqqu?**rrr+qhvvjcqrdw`+fjh%cjw%sdila%ilf`kvlkb+')),PChar(Scramble('Rdwklkb')),MB_OK);
  end
{$ENDIF}


end.
