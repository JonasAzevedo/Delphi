{*************************************************************************}
{ TAdvSmoothDock component                                                }
{ for Delphi & C++Builder                                                 }
{                                                                         }
{ written by TMS Software                                                 }
{           copyright © 2009                                              }
{           Email : info@tmssoftware.com                                  }
{           Website : http://www.tmssoftware.com/                         }
{                                                                         }
{ The source code is given as is. The author is not responsible           }
{ for any possible damage done due to the use of this code.               }
{ The component can be freely used in any application. The complete       }
{ source code remains property of the author and may not be distributed,  }
{ published, given or sold in any form as such. No parts of the source    }
{ code can be included in any other component or application without      }
{ written authorization of the author.                                    }
{*************************************************************************}

unit AdvSmoothDock;

{$I TMSDEFS.INC}

interface

uses
  Forms, Windows, Messages, Graphics, Controls, Classes,
  AdvStyleif, AdvSmoothGDIP, GDIPFill, Sysutils, Math,
  ExtCtrls, ActiveX, Menus, AdvSmoothDockDragDrop, OleCtnrs,
  ShellApi, AxCtrls;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 1; // Build nr.

  //v1.0.0.0 : first release
  //v1.0.0.1 : Fixed : issue with Array length of Sinus calculation

  DRAGMARGIN = 5;

type
  TAdvSmoothDock = class;

  TWinCtrl = class(TWinControl)
  public
    procedure PaintCtrls(DC: HDC; First: TControl);
  end;

  TAdvSmoothDockForm = class(TForm)
  private
    FMouseEntered: Boolean;
    OldWndProc, NewWndProc: Pointer;
    FMainBuffer: TGPBitmap;
    FDock: TAdvSmoothDock;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMActivate(var Message: TMessage); message WM_ACTIVATE;
  protected
    procedure CreateWnd; override;
    procedure DoCreate; override;
    procedure DoDestroy; override;
    procedure Paint; override;
    procedure DblClick; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;

    // ---- Paint proc
    procedure Draw(graphics: TGPGraphics);

    // ---- Paint buffer
    procedure CreateMainBuffer;
    procedure DestroyMainBuffer;
    procedure ClearBuffer(graphics: TGPGraphics);
    function CreateGraphics: TGPGraphics;

    //---- Layered window
    procedure SetLayeredWindow;
    procedure UpdateLayered;
    procedure UpdateMainWindow;
    procedure UpdateWindow;
    procedure WndProc(var Message: TMessage); override;
    procedure HookWndProc(var Msg: TMessage);
  public
    procedure Init;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    property OwnerDock: TAdvSmoothDock read FDock write FDock;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
  end;

  TAdvSmoothDockImageType = (itPNG, itBMP, itJPEG, itTIFF, itGIF);

  TAdvSmoothDockStatus = class(TPersistent)
  private
    FOwner: TAdvSmoothDock;
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
    constructor Create(AOwner: TAdvSmoothDock);
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

  TAdvSmoothDockItem = class(TCollectionItem)
  private
    FItemRect: TGPRectF;
    FInsertItem: Boolean;
    FDoItemAnimation: Boolean;
    FOwner: TAdvSmoothDock;
    FJMP, FJMPTO: Double;
    FHoverSizeW, FHoverSizeToW: Double;
    FHoverSizeH, FHoverSizeToH: Double;
    FReflectionImage: TGPBitmap;
    FImage: TAdvGDIPPicture;
    FEnabled: Boolean;
    FVisible: Boolean;
    FCaption: String;
    FHint: String;
    FJump, FJumpUp, FJumpDown: Boolean;
    FPopupMenu: TPopupMenu;
    FStatusIndicator: TAdvSmoothDockStatus;
    FSeparator: Boolean;
    FShowCaption: Boolean;
    FProgressMaximum: integer;
    FProgressMinimum: integer;
    FProgressPosition: integer;
    FFilePath: String;
    FObject: TObject;
    FTag: integer;
    FData: string;
    procedure SetImage(const Value: TAdvGDIPPicture);
    procedure SetCaption(const Value: String);
    procedure SetEnabled(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    procedure SetHint(const Value: String);
    procedure SetJump(const Value: Boolean);
    procedure SetStatusIndicator(const Value: TAdvSmoothDockStatus);
    procedure SetSeparator(const Value: Boolean);
    procedure SetShowCaption(const Value: Boolean);
    procedure SetProgressMaximum(const Value: integer);
    procedure SetProgressMinimum(const Value: integer);
    procedure SetProgressPosition(const Value: integer);
  protected
    procedure Changed;
    procedure ImageChanged(Sender: TObject);
    procedure StatusIndicatorChanged(Sender: TObject);
    procedure UpdateReflection;
    function GetItemRect: TGPRectF;
    function GetItemRectCenter: TGPRectF;
    function GetHoverRect: TGPRectF;
    function GetNormalRect: TGPRectF;
    procedure Popup(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property FilePath: String read FFilePath write FFilePath;
  published
    property Image: TAdvGDIPPicture read FImage write SetImage;
    property Caption: String read FCaption write SetCaption;
    property Visible: Boolean read FVisible write SetVisible default true;
    property Enabled: Boolean read FEnabled write SetEnabled default true;
    property Data: string read FData write FData;
    property Tag: integer read FTag write FTag;
    property ItemObject: TObject read FObject write FObject;
    property Hint: String read FHint write SetHint;
    property Jump: Boolean read FJump write SetJump default false;
    property StatusIndicator: TAdvSmoothDockStatus read FStatusIndicator write SetStatusIndicator;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    property Separator: Boolean read FSeparator write SetSeparator default false;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption default true;
    property ProgressMaximum: integer read FProgressMaximum write SetProgressMaximum default 100;
    property ProgressMinimum: integer read FProgressMinimum write SetProgressMinimum default 0;
    property ProgressPosition: integer read FProgressPosition write SetProgressPosition default 0;
  end;

  TAdvSmoothDockItems = class(TCollection)
  private
    FOwner: TAdvSmoothDock;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TAdvSmoothDockItem;
    procedure SetItem(Index: Integer; const Value: TAdvSmoothDockItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TAdvSmoothDock);
    function Add: TAdvSmoothDockItem;
    function Insert(Index: Integer): TAdvSmoothDockItem;
    property Items[Index: Integer]: TAdvSmoothDockItem read GetItem write SetItem; default;
    procedure Delete(Index: Integer);
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothDockItemAppearance = class(TPersistent)
  private
    FOwner: TAdvSmoothDock;
    FImageHeight: integer;
    FImageWidth: integer;
    FOnChanged: TNotifyEvent;
    FSpacing: integer;
    FFill: TGDIPFill;
    FMaxImageWidth: integer;
    FMaxImageHeight: integer;
    FBackGroundVisible: Boolean;
    FReflectionSpacing: integer;
    FImageOffset: integer;
    FReflectionStart: Byte;
    FReflectionEnd: Byte;
    FReflectionSize: integer;
    FSelectionFill: TGDIPFill;
    FCaptionFill: TGDIPFill;
    FCaptionFont: TFont;
    FSelectionSize: integer;
    FSelectionOffset: integer;
    FSelectedFill: TGDIPFill;
    FHoverFill: TGDIPFill;
    FDisabledFill: TGDIPFill;
    FItemFill: Boolean;
    FProgressFill: TGDIPFill;
    FSeparatorFill: TGDIPFill;
    FSeparatorSize: integer;
    FAspectRatio: Boolean;
    FJumpMargin: integer;
    FAnimationSpan: integer;
    procedure SetImageHeight(const Value: integer);
    procedure SetImageWidth(const Value: integer);
    procedure SetSpacing(const Value: integer);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetMaxImageHeight(const Value: integer);
    procedure SetMaxImageWidth(const Value: integer);
    procedure SetReflectionSpacing(const Value: integer);
    procedure SetImageOffset(const Value: integer);
    procedure SetReflectionEnd(const Value: Byte);
    procedure SetReflectionStart(const Value: Byte);
    procedure SetReflectionSize(const Value: integer);
    procedure SetSelectionFill(const Value: TGDIPFill);
    procedure SetCaptionFill(const Value: TGDIPFill);
    procedure SetCaptionFont(const Value: TFont);
    procedure SetSelectionSize(const Value: integer);
    procedure SetSelectionOffset(const Value: integer);
    procedure SetHoverFill(const Value: TGDIPFill);
    procedure SetSelectedFill(const Value: TGDIPFill);
    procedure SetDisabledFill(const Value: TGDIPFill);
    procedure SetItemFill(const Value: Boolean);
    procedure SetProgressFill(const Value: TGDIPFill);
    procedure SetSeparatorFill(const Value: TGDIPFill);
    procedure SetSeparatorSize(const Value: integer);
    procedure SetAspectRatio(const Value: Boolean);
    procedure SetJumpMargin(const Value: integer);
    procedure SetAnimationSpan(const Value: integer);
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure FontChanged(Sender: TObject);
    procedure SeparatorChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothDock);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property JumpMargin: integer read FJumpMargin write SetJumpMargin default 40;
    property Fill: TGDIPFill read FFill write SetFill;
    property AspectRatio: Boolean read FAspectRatio write SetAspectRatio default true;
    property HoverFill: TGDIPFill read FHoverFill write SetHoverFill;
    property SelectedFill: TGDIPFill read FSelectedFill write SetSelectedFill;
    property DisabledFill: TGDIPFill read FDisabledFill write SetDisabledFill;
    property ItemBackGround: Boolean read FItemFill write SetItemFill default false;
    property ImageWidth: integer read FImageWidth write SetImageWidth default 50;
    property ImageHeight: integer read FImageHeight write SetImageHeight default 50;
    property ImageOffset: integer read FImageOffset write SetImageOffset default 40;
    property MaximumImageHeight: integer read FMaxImageHeight write SetMaxImageHeight default 120;
    property MaximumImageWidth: integer read FMaxImageWidth write SetMaxImageWidth default 120;
    property Spacing: integer read FSpacing write SetSpacing default 40;
    property OnChange: TNotifyEvent read FOnChanged write FOnChanged;
    property ReflectionSize: integer read FReflectionSize write SetReflectionSize default 50;
    property ReflectionStart: Byte read FReflectionStart write SetReflectionStart default 100;
    property ReflectionEnd: Byte read FReflectionEnd write SetReflectionEnd default 0;
    property ReflectionSpacing: integer read FReflectionSpacing write SetReflectionSpacing default 0;
    property AnimationSpan: integer read FAnimationSpan write SetAnimationSpan default 400;
    property SelectionFill: TGDIPFill read FSelectionFill write SetSelectionFill;
    property SelectionSize: integer read FSelectionSize write SetSelectionSize default 20;
    property SelectionOffset: integer read FSelectionOffset write SetSelectionOffset default 10;
    property CaptionFill: TGDIPFill read FCaptionFill write SetCaptionFill;
    property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
    property ProgressFill: TGDIPFill read FProgressFill write SetProgressFill;
    property SeparatorFill: TGDIPFill read FSeparatorFill write SetSeparatorFill;
    property SeparatorSize: integer read FSeparatorSize write SetSeparatorSize;
  end;

  TAnimationPoint = record
    pt: TGPPointF;
    factor: Double;
  end;

  TDockItemArray = Array of TAdvSmoothDockItem;

  TAdvSmoothDockPosition = (dpLeft, dpRight, dpTop, dpBottom);

  TAdvSmoothDockDragOver = procedure(Sender, Source: TObject; DragItem: TAdvSmoothDockItem; X, Y: Integer; State: TDragState; var Accept: Boolean) of object;

  TAdvSmoothDockDragDrop = procedure(Sender, Source: TObject; DragItem: TAdvSmoothDockItem; X, Y: Integer) of object;

  TAdvSmoothDockItemHint = procedure(Sender: TObject; ItemIndex: integer; var Hint: String) of object;

  TAdvSmoothDockItemClick = procedure(Sender: TObject; ItemIndex: integer) of object;

  TAdvSmoothDockItemDblClick = procedure(Sender: TObject; ItemIndex: integer) of object;

  TAdvSmoothDockItemSelected = procedure(Sender: TObject; ItemIndex: integer) of object;

  TAdvSmoothDockItemHover = procedure(Sender: TObject; ItemIndex: integer) of object;

  TAdvSmoothDockDragInsert = procedure(Sender: TObject; PreviousItemIndex, NextItemIndex: integer; var AllowInsert: Boolean) of object;

  TAdvSmoothDockAlignDesktop = (adBottom, adLeft, adRight, adTop);

  TAdvSmoothDockDropTarget = class(TDockDropTarget)
  private
    FDock: TAdvSmoothDock;
  public
    constructor Create(ADock:TAdvSmoothDock);
    procedure DropText(pt:TPoint;s:string); override;
    procedure DropCol(pt:TPoint;Col: Integer); override;
    procedure DropRTF(pt:TPoint;s:string); override;
    procedure DropFiles(pt:TPoint;files:tstrings); override;
    procedure DropURL(pt:TPoint;s:string); override;
    procedure DragMouseMove(pt:TPoint;var Allow: Boolean; DropFormats:TDropFormats); override;
    procedure DragMouseLeave; override;
  end;

  TAdvSmoothDockArrowAppearance = class(TPersistent)
  private
    FOwner: TAdvSmoothDock;
    FOpacity: Byte;
    FBorderColor: TColor;
    FColor: TColor;
    FVisible: Boolean;
    FSize: integer;
    FOnChange: TNotifyEvent;
    procedure SetColor(const Value: TColor);
    procedure SetOpacity(const Value: Byte);
    procedure SetSize(const Value: integer);
    procedure SetVisibled(const Value: Boolean);
    procedure SetBorderColor(const Value: TColor);
  protected
    procedure Changed;
  public
    constructor Create(AOwner: TAdvSmoothDock);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Color: TColor read FColor write SetColor default clSilver;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property Opacity: Byte read FOpacity write SetOpacity default 200;
    property Size: integer read FSize write SetSize default 35;
    property Visible: Boolean read FVisible write SetVisibled default true;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TCaptionSize = record
    w: Double;
    h: Double;
  end;

  TAdvSmoothDockBounds = record
    Start, Stop: integer;
  end;

  TAdvSmoothDock = class(TCustomControl, ITMSStyle)
  private
    FTimeDownOnArrow: integer;
    FAnimateMove: Boolean;
    FCurrentPos, FPosTo: Single;
    FArrowLeftHover, FArrowLeftDown, FArrowRightHover, FArrowRightDown: Boolean;
    UpdateBounds, FMouseOnArrow, FResizeDisabled: Boolean;
    frm: TAdvSmoothDockForm;
    FFocused: Boolean;
    FSel: Integer;
    FDblClick: Boolean;
    FOleDropTargetAssigned: Boolean;
    FDockDropTarget: TAdvSmoothDockDropTarget;
    FSeparatorMemoryStream: TMemoryStream;
    FSeparatorImage: TGPBitmap;
    FConstructed: Boolean;
    FMouseEntered: Boolean;
    FStartPopupTimer, FDoPopup: Boolean;
    FPopupTime: integer;
    FDesigntime: Boolean;
    FMouseDown, FMouseCopy: Boolean;
    FDragDropItem, FInsertDropItem: TAdvSmoothDockItem;
    FClickX, FClickY: integer;
    FDragX, FDragY: integer;
    FPrevX, FPrevY: integer;
    FHintX, FHintY: integer;
    FHoveredItemIndex, FPopupClickIndex: integer;
    FUpdateCount: integer;
    //FBlockPaint: Boolean;
    FAnimate: TTimer;
    FSin: array of TAnimationPoint;
    FFill: TGDIPFill;
    FTransparent: Boolean;
    FItems: TAdvSmoothDockItems;
    FItemAppearance: TAdvSmoothDockItemAppearance;
    FSelectedItemIndex: integer;
    FPosition: TAdvSmoothDockPosition;
    FPlatformFill: TGDIPFill;
    FPlatformSize: integer;
    FOnDragDrop: TAdvSmoothDockDragDrop;
    FOnDragOver: TAdvSmoothDockDragOver;
    FOnItemHint: TAdvSmoothDockItemHint;
    FPlatForm3D: Boolean;
    FOleDragDrop: Boolean;
    FAnimationFactor: integer;
    FOnDragInsert: TAdvSmoothDockDragInsert;
    FOnItemDblClick: TAdvSmoothDockItemDblClick;
    FOnItemClick: TAdvSmoothDockItemClick;
    FOnItemSelected: TAdvSmoothDockItemSelected;
    FOnItemHover: TAdvSmoothDockItemHover;
    FFocus: Boolean;
    FPlatForm3DColor: TColor;
    FPlatForm3DColorTo: TColor;
    FPlatForm3DOpacity: Byte;
    FPlatForm3DOpacityTo: Byte;
    FDockOnDeskTop: Boolean;
    FDockVisible: Boolean;
    FArrowAppearance: TAdvSmoothDockArrowAppearance;
    FOnScroll: TNotifyEvent;
    procedure SetFill(const Value: TGDIPFill);
    procedure SetTransparent(const Value: Boolean);
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure SetItems(const Value: TAdvSmoothDockItems);
    procedure SetItemAppearance(const Value: TAdvSmoothDockItemAppearance);
    procedure SetSelectedItemIndex(const Value: integer);
    procedure SetPosition(const Value: TAdvSmoothDockPosition);
    procedure SetPlatformFill(const Value: TGDIPFill);
    procedure SetPlatformSize(const Value: integer);
    procedure SetPlatForm3D(const Value: Boolean);
    procedure SetOleDragDrop(const Value: Boolean);
    function GetVersion: String;
    procedure SetAnimationFactor(const Value: integer);
    procedure SetShowFocus(const Value: Boolean);
    procedure SetPlatForm3DColor(const Value: TColor);
    procedure SetPlatForm3DColorTo(const Value: TColor);
    procedure SetPlatForm3DOpacity(const Value: Byte);
    procedure SetPlatForm3DOpacityTo(const Value: Byte);
    procedure SetDockOnDesktop(const Value: Boolean);
    procedure SetDockVisible(const Value: Boolean);
    procedure SetArrowAppearance(const Value: TAdvSmoothDockArrowAppearance);
    function GetFirstIndex: integer;
    function GetVisibleItemCount: integer;
  protected
    procedure Changed;
    procedure AlignDesktop(Align: TAdvSmoothDockAlignDesktop); virtual;
    property DockOnDeskTop: Boolean read FDockOnDeskTop write SetDockOnDesktop default false;
    property DockVisible: Boolean read FDockVisible write SetDockVisible default false;
    procedure FillChanged(Sender: TObject);
    procedure ItemsChanged(Sender: TObject);
    procedure ItemAppearanceChanged(Sender: TObject);
    procedure ArrowAppearanceChanged(Sender: TObject);
    procedure DrawBackGround(g: TGPGraphics; Control: Boolean);
    procedure DrawPlatForm(g: TGPGraphics);
    procedure DrawItems(g: TGPGraphics);
    procedure DrawCaption(g: TGPGraphics);
    procedure DrawArrows(g: TGPGraphics);
    procedure DrawIndicator(g: TGPGraphics; ItemIndex: integer);
    procedure DoMouseEnter(var Msg: TMessage);
    procedure DoMouseLeave(var Msg: TMessage);
    procedure DoMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoMouseMove(Shift: TShiftState; X, Y: Integer);
    procedure DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoKeyDown(var Key: Word; Shift: TShiftState);
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CalculateSin;
    procedure Animate(Sender: TObject);
    procedure DoDblClick;
    procedure DoDrop(X, Y: integer);
    procedure DoDrag(X, Y: integer; Copy: Boolean);
    procedure DoDragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure DoDragDrop(Source: TObject; X, Y: Integer);
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure CreateWnd; override;
    procedure Loaded; override;
    procedure GetAspectSize(var w, h: integer; ow, oh, nw, nh: double; Separator: Boolean);
    function FactorInSinus(X, Y: integer; pt: TGPPointF): Double;
    function InsideRect: TRect;
    function GetBounds: TAdvSmoothDockBounds;
    function GetItemBounds: integer;
    function IsItemBounds(X, Y: integer): Boolean;
    function IsMoving(X, Y: integer): Boolean;
    function GetVersionNr: Integer;
    function GetWidth: integer;
    function GetHeight: integer;
    function GetTotalSize: Double;
    function GetMinimumHeight: integer;
    function GetMinimumWidth: integer;
    function GetMaximumHeight: integer;
    function GetMaximumWidth: integer;
    function GetItemsRectangle: TGPRectF;
    function GetItemsMinimumRectangle: TGPRectF;
    function GetArrowLeft: TGPRectF;
    function GetArrowRight: TGPRectF;
    function IsMouseOnArrow(X, Y: integer): Boolean;
    function PtInGPRect(r: TGPRectF; pt: TPoint): Boolean;
    function GetPlatFormRectangle: TGPRectF;
    function GetMaxSizeCaption: TCaptionSize;
    procedure DoArrowRightDown;
    procedure DoArrowLeftDown;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Paint; override;
    procedure SetComponentStyle(AStyle: TTMSStyle);
    procedure Resize; override;
    procedure UpdateSize;
    procedure AddImagesFromFolder(AFolder: String; SetImageCaption: boolean = false);
    procedure AddFilesFromFolder(AFolder: String; SetImageCaption: boolean = false; SetFilePath: Boolean = false; LoadIcon: Boolean = false);
    procedure BeginUpdate;
    procedure EndUpdate;
    function XYToItem(X, Y: integer; CountSeparator: Boolean = false; DragDrop: Boolean = false): integer;
    procedure ShowForm;
    property FirstVisibleIndex: integer read GetFirstIndex;
    property VisibleItemCount: integer read GetVisibleItemCount;
  published
    property AnimationFactor: integer read FAnimationFactor write SetAnimationFactor default 2;
    property Fill: TGDIPFill read FFill write SetFill;
    property PlatformFill: TGDIPFill read FPlatformFill write SetPlatformFill;
    property PlatformSize: integer read FPlatformSize write SetPlatformSize default 60;
    property Transparent: Boolean read FTransparent write SetTransparent default true;
    property Items: TAdvSmoothDockItems read FItems write SetItems;
    property ItemAppearance: TAdvSmoothDockItemAppearance read FItemAppearance write SetItemAppearance;
    property SelectedItemIndex: integer read FSelectedItemIndex write SetSelectedItemIndex default -1;
    property Position: TAdvSmoothDockPosition read FPosition write SetPosition default dpBottom;
    property PlatForm3D: Boolean read FPlatForm3D write SetPlatForm3D default true;
    property PlatForm3DColor: TColor read FPlatForm3DColor write SetPlatForm3DColor default clWhite;
    property PlatForm3DColorTo: TColor read FPlatForm3DColorTo write SetPlatForm3DColorTo default clWhite;
    property PlatForm3DOpacity: Byte read FPlatForm3DOpacity write SetPlatForm3DOpacity default 30;
    property PlatForm3DOpacityTo: Byte read FPlatForm3DOpacityTo write SetPlatForm3DOpacityTo default 100;
    property ArrowAppearance: TAdvSmoothDockArrowAppearance read FArrowAppearance write SetArrowAppearance;
    property OleDragDrop: Boolean read FOleDragDrop write SetOleDragDrop default false;
    property Version: String read GetVersion;
    property ShowFocus: Boolean read FFocus write SetShowFocus default true;

    property OnDragOver: TAdvSmoothDockDragOver read FOnDragOver write FOnDragOver;
    property OnDragDrop: TAdvSmoothDockDragDrop read FOnDragDrop write FOnDragDrop;
    property OnItemHint: TAdvSmoothDockItemHint read FOnItemHint write FOnItemHint;
    property OnItemClick: TAdvSmoothDockItemClick read FOnItemClick write FOnItemClick;
    property OnItemDblClick: TAdvSmoothDockItemDblClick read FOnItemDblClick write FOnItemDblClick;
    property OnItemHover: TAdvSmoothDockItemHover read FOnItemHover write FOnItemHover;
    property OnDragInsert: TAdvSmoothDockDragInsert read FOnDragInsert write FOnDragInsert;
    property OnItemSelected: TAdvSmoothDockItemSelected read FOnItemSelected write FOnItemSelected;
    property OnScroll: TNotifyEvent read FOnScroll write FOnScroll;

    property Align;
    property Anchors;
    property Constraints;
    property PopupMenu;
    property TabOrder;
    property ParentShowHint;
    property ShowHint;
    property OnKeyDown;
    property OnKeyPress;
    property OnMouseUp;
    property OnMouseMove;
    property OnMouseDown;
    {$IFDEF DELPHI2006_LVL}
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnResize;
    property Hint;
    property OnDblClick;
    property OnClick;
    property OnEnter;
    property OnExit;
    property Visible;
    property TabStop;
  end;

implementation

function Lighter(Color:TColor; Percent:Byte):TColor;
var
  r, g, b:Byte;
begin
  Color := ColorToRGB(Color);
  r := GetRValue(Color);
  g := GetGValue(Color);
  b := GetBValue(Color);
  r := r + muldiv(255 - r, Percent, 100); //Percent% closer to white
  g := g + muldiv(255 - g, Percent, 100);
  b := b + muldiv(255 - b, Percent, 100);
  result := RGB(r, g, b);
end;

function Darker(Color:TColor; Percent:Byte):TColor;
var
  r, g, b:Byte;
begin
  Color := ColorToRGB(Color);
  r := GetRValue(Color);
  g := GetGValue(Color);
  b := GetBValue(Color);
  r := r - muldiv(r, Percent, 100);  //Percent% closer to black
  g := g - muldiv(g, Percent, 100);
  b := b - muldiv(b, Percent, 100);
  result := RGB(r, g, b);
end;

function GetCLSID(ImageType: TAdvSmoothDockImageType): TCLSID;
var
  I: integer;
  num, numi, size: Cardinal;
  clsId: TCLSID;
  pinfo: PImageCodecInfo;
  infoarr: array[0..100] of TImageCodecInfo;
  str: String;
begin
  GdipGetImageEncodersSize(num, size);

  pinfo := AllocMem(size);

  numi := num;

  GdipGetImageEncoders(num, size, pinfo);

  move(pinfo^, infoarr[0], size);

  case ImageType of
    itPNG: str := 'image/png';
    itBMP: str := 'image/bmp';
    itJPEG: str := 'image/jpeg';
    itTIFF: str := 'image/tiff';
    itGIF: str := 'image/gif';
  end;

  for I := 0 to numi - 1 do
  begin
    if infoarr[i].MimeType = str then
    begin
      clsid := infoarr[i].Clsid;
      break;
    end;
  end;

  FreeMem(pinfo);

  Result := clsid;
end;

function AnimateDouble(var Start: Single; Stop, Delta, Margin: Single): Boolean;
begin
  Result := true;
  if (Start > Stop - Margin) and (Start < Stop + Margin) then
  begin
    Start := Stop;
    Result := false;
  end
  else
  begin
    Delta := Max(1, Delta);
    if Start < Stop then
      Start := Round(Start + Delta)
    else
      Start := Round(Start - Delta);
  end;
end;

{ TAdvSmoothDock }

type
  TFileInfo = record
    Icon : hIcon;
    Image : Integer;
    DisplayName : String;
    TypeName : String;
    Size : Integer;
    SizeDescription : String;
    DateTime : TDateTime;
    AttrArchive : Boolean;
    AttrReadOnly : Boolean;
    AttrSystem : Boolean;
    AttrHidden : Boolean;
    AttrVolume : Boolean;
    AttrDirectory : Boolean;
  end;

function scGetSizeDescription(const IntSize : Int64) : String;
begin
  if IntSize < 1024 then
    Result := IntToStr(IntSize)+' bytes'
  else
  begin
    if IntSize < (1024 * 1024) then
      Result := FormatFloat('####0.##',IntSize / 1024)+' Kb'
    else
      if IntSize < (1024 * 1024 * 1024) then
        Result := FormatFloat('####0.##',IntSize / 1024 / 1024)+' Mb'
      else
        Result := FormatFloat('####0.##',IntSize / 1024 / 1024 / 1024)+' Gb';
  end;
end;

procedure scGetFileInfo(StrPath : String; var Info : TFileInfo);
var
  SHFileInfo : TSHFileInfo;
  SearchRec : TSearchRec;
begin
  if Trim(StrPath) = '' then
    Exit;

  ShGetFileInfo(PChar(StrPath), 0, SHFileInfo, SizeOf (TSHFileInfo),
    SHGFI_TYPENAME or SHGFI_DISPLAYNAME or SHGFI_SYSICONINDEX or SHGFI_ICON);

  with Info do
  begin
    Icon  := SHFileInfo.hIcon;
    Image := SHFileInfo.iIcon;
    DisplayName := SHFileInfo.szDisplayName;
    TypeName := SHFileInfo.szTypeName;
  end;

  FindFirst(StrPath, 0, SearchRec);
  with Info do
  begin
    try
//      DateTime := FileDateToDateTime(SearchRec.Time);
    except
      DateTime := Now();
    end;

    {$WARNINGS OFF}
    AttrReadOnly := ((SearchRec.Attr and faReadOnly) > 0);
    AttrSystem := ((SearchRec.Attr and faSysFile) > 0);
    AttrHidden := ((SearchRec.Attr and faHidden) > 0);
    AttrArchive := ((SearchRec.Attr and faArchive) > 0);
    AttrVolume := ((SearchRec.Attr and faVolumeID) > 0);
    AttrDirectory := ((SearchRec.Attr and faDirectory) > 0);
    {$WARNINGS ON}

    Size := SearchRec.Size;

    SizeDescription := scGetSizeDescription(Size);
  end;
end;

procedure TAdvSmoothDock.AddFilesFromFolder(AFolder: String;
  SetImageCaption, SetFilePath, LoadIcon: boolean);
var
  SR: TSearchRec;
  m: TMemoryStream;
  ic: TIcon;
  inf: TFileInfo;

  procedure AddToList(s: string);
  begin
    with Items.Add do
    begin
      try
        Image.LoadFromFile(s);
        if SetFilePath then
          FFilePath := s;
        if SetImageCaption then
          FCaption := ExtractFileName(s);

        if LoadIcon then
        begin
          scGetFileInfo(s, inf);
           //ICON
          ic := TIcon.Create;
          try
           ic.Handle := inf.Icon;
           if not ic.Empty then
           begin
             m := TMemoryStream.Create;
             ic.SaveToStream(m);
             Image.LoadFromStream(m);
             m.Free;
           end;
          finally
           ic.free;
          end;
        end;
      except
        Image.Assign(nil);
      end;
    end;
  end;

begin
  BeginUpdate;
  if FindFirst(AFolder,faAnyFile-faDirectory,SR) = 0 then
  begin
    AddToList(ExtractFilePath(AFolder) + SR.Name);
    while FindNext(SR) = 0 do
      AddToList(ExtractFilePath(AFolder) + SR.Name);
  end;
  FindClose(SR);
  EndUpdate;
end;

procedure TAdvSmoothDock.AddImagesFromFolder(AFolder: String;
  SetImageCaption: boolean);
var
  SR: TSearchRec;

  procedure AddToList(s: string);
  begin
    with Items.Add do
    begin
      try
        Image.LoadFromFile(s);
        if SetImageCaption then
        begin
          FCaption := ExtractFileName(s);
        end;
      except
        Image.Assign(nil);
      end;
    end;
  end;

begin
  BeginUpdate;
  if FindFirst(AFolder,faAnyFile-faDirectory,SR) = 0 then
  begin
    AddToList(ExtractFilePath(AFolder) + SR.Name);
    while FindNext(SR) = 0 do
      AddToList(ExtractFilePath(AFolder) + SR.Name);
  end;
  FindClose(SR);
  EndUpdate;
end;

procedure TAdvSmoothDock.AlignDesktop(Align: TAdvSmoothDockAlignDesktop);
var
  r: TRect;
begin
  if Assigned(frm) then
  begin
    SystemParametersInfo(SPI_GETWORKAREA, 0, @r, 0);
    case Align of
      adBottom:
      begin
        Self.Position := dpBottom;
        frm.Left := r.Left;
        frm.Top := r.Bottom - frm.Height;
        frm.Width := r.Right;
      end;
      adLeft:
      begin
        Self.Position := dpLeft;
        frm.Left := r.Left;
        frm.Top := r.Top;
        frm.Height := r.Bottom;
      end;
      adRight:
      begin
        Self.Position := dpRight;
        frm.Left := r.Right - Width;
        frm.Top := r.Top;
        frm.Height := r.Bottom;
        frm.Width := Width;
      end;
      adTop:
      begin
        Self.Position := dpTop;
        frm.Left := r.Left;
        frm.Top := r.Top;
        frm.Width := r.Right;
      end;
    end;
  end;
end;

procedure TAdvSmoothDock.Animate(Sender: TObject);
var
  d, j, hsW, dW, hsH, dH, Fm: Single;
  dojump, domove, doanimationW, doanimationH: Boolean;
  I: Integer;
  hs: Double;
  f: Double;
  r: TGPREctF;
  w: Double;
  c: TGPPointF;
  b: TAdvSmoothDockBounds;
begin
  if csDestroying in ComponentState then
    Exit;

  if Assigned(frm) then
  begin
    Inc(FTimeDownOnArrow);
    if FTimeDownOnArrow >= 30 then
    begin
      if FArrowLeftDown then
        DoArrowLeftDown
      else if FArrowRightDown then
        DoArrowRightDown;
    end;

    if FAnimateMove then
    begin
      d := Abs(FCurrentPos - FPosTo) / AnimationFactor;
      fm := FCurrentPos;
      domove := AnimateDouble(fm, FPosTo, d, 1);
      if domove then
      begin
        FCurrentPos := fm;
        Changed;
      end;
    end
    else
    begin
      FPosTo := FCurrentPos;
      FAnimateMove := false;
    end;

    //POPUPMENU
    if FStartPopupTimer then
    begin
      Inc(FPopupTime);
      if (FPopupTime >= 100) and (FPopupClickIndex <> -1) then
      begin
        FStartPopupTimer := false;
        FDoPopup := true;
        with Items[FPopupClickIndex] do
        begin
          if Assigned(PopupMenu) then
          begin
            PopupMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
          end;

          FMouseDown := false;
        end;
      end;
    end;
    //
    b := GetBounds;
    for I := b.Start to b.Stop do
    begin
      with Items[i] do
      begin
        if FJump or (FJMP <> 0) then
        begin
          if FJumpDown then
          begin
            FJMPTO := 0;
            d := Abs(FJMP - FJMPTO) / AnimationFactor;
            if FJMP > 3 then
              d := ((ItemAppearance.FJumpMargin + 5) / AnimationFactor) - d
            else
              FJMP := 0;

            j := FJMP;
            dojump := AnimateDouble(j, FJMPTO, d, 1);
            if dojump then
            begin
              FJMP := Max(0, j);
              Changed;
            end
            else
            begin
              FJumpUp := true;
              FJumpDown := false;
            end;
          end;
          if FJumpUp then
          begin
            FJMPTO := ItemAppearance.FJumpMargin;
            d := Abs(FJMP - FJMPTO) / AnimationFactor;
            j := FJMP;
            dojump := AnimateDouble(j, FJMPTO, d, 1);
            if dojump then
            begin
              FJMP := j;
              Changed;
            end
            else
            begin
              FJumpUp := false;
              FJumpDown := true;
            end;
          end;
        end;

        if frm.FMouseEntered and not IsMouseOnArrow(FPRevX, FPRevY) then
        begin
          if (IsItemBounds(FPrevX, FPrevY)) then
          begin
            r := GetItemRect;
            case Position of
              dpRight, dpLeft:
              begin
                w := r.Height;
                c.Y := r.Y + (w / 2);
                f := FactorInSinus(FPrevX, FPrevY, c);
  //              HEIGHT
                hs := f * (ItemAppearance.MaximumImageHeight - ItemAppearance.ImageHeight);
                if hs <= 0 then
                  FHoverSizeToH := 0
                else
                  FHoverSizeToH := hs;

  //              WIDTH
                hs := f * (ItemAppearance.MaximumImageWidth - ItemAppearance.ImageWidth);
                if hs <= 0 then
                  FHoverSizeToW := 0
                else
                  FHoverSizeToW := hs;
              end;
              dpTop, dpBottom:
              begin
                w := r.Width;
                c.X := r.X + (w / 2);
                f := FactorInSinus(FPrevX, FPrevY, c);
                //HEIGHT
                hs := f * (ItemAppearance.MaximumImageHeight - ItemAppearance.ImageHeight);
                if hs <= 0 then
                  FHoverSizeToH := 0
                else
                  FHoverSizeToH := hs;

                //WIDTH
                hs := f * (ItemAppearance.MaximumImageWidth - ItemAppearance.ImageWidth);
                if hs <= 0 then
                  FHoverSizeToW := 0
                else
                  FHoverSizeToW := hs;
              end;
            end;
            FDoItemAnimation := true;
          end
          else
          begin
            FHoverSizeToW := 0;
            FHoverSizeToH := 0;
            FDoItemAnimation := false;
          end;
        end;

        if FDoItemAnimation then
        begin
          //WIDTH
          dW := Abs(FHoverSizeW - FHoverSizeToW) / AnimationFactor;
          hsW := FHoverSizeW;
          doanimationW := AnimateDouble(hsW, FHoverSizeToW, dW, 1);

          //HEIGHT
          dH := Abs(FHoverSizeH - FHoverSizeToH) / AnimationFactor;
          hsH := FHoverSizeH;
          doanimationH := AnimateDouble(hsH, FHoverSizeToH, dH, 1);


          if doanimationW or doanimationH then
          begin
            FHoverSizeW := hsW;
            FHoverSizeH := hsH;
            Changed;
          end
          else
            FDoItemAnimation := false;
        end;
      end;
    end;

    //dragdropitem needs repaint when dragging AFTER sinus animation on other items
    if FMouseDown and (FDragDropItem <> nil) then
      Changed;
  end;
end;

procedure TAdvSmoothDock.ArrowAppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothDock.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothDock) then
  begin
    FFill.Assign((Source as TAdvSmoothDock).Fill);
    FTransparent := (Source as TAdvSmoothDock).Transparent;
    FItems.Assign((Source as TAdvSmoothDock).Items);
    FItemAppearance.Assign((Source as TAdvSmoothDock).ItemAppearance);
    FSelectedItemIndex := (Source as TAdvSmoothDock).SelectedItemIndex;
    FPosition := (Source as TAdvSmoothDock).Position;
    FPlatForm3D := (Source as TAdvSmoothDock).PlatForm3D;
    FPlatForm3DColor := (Source as TAdvSmoothDock).PlatForm3DColor;
    FPlatForm3DColorTo := (Source as TAdvSmoothDock).PlatForm3DColorTo;
    FPlatForm3DOpacity := (Source as TAdvSmoothDock).PlatForm3DOpacity;
    FPlatForm3DOpacityTo := (Source as TAdvSmoothDock).PlatForm3DOpacityTo;
    FPlatformFill.Assign((Source as TAdvSmoothDock).PlatformFill);
    FPlatformSize := (Source as TAdvSmoothDock).PlatformSize;
    FArrowAppearance.Assign((Source as TAdvSmoothDock).ArrowAppearance);
    FAnimationFactor := (Source as TAdvSmoothDock).AnimationFactor;
    FOleDragDrop := (Source as TAdvSmoothDock).OleDragDrop;
    FFocus := (Source as TAdvSmoothDock).ShowFocus;
    Changed;
  end;
end;

procedure TAdvSmoothDock.DoDrop(X, Y: integer);
begin
  if IsItemBounds(X, Y) then
  begin
    if (FDragDropItem <> nil) and (FInsertDropItem <> nil) then
      FItems.Insert(FInsertDropItem.Index).Assign(FDragDropItem)
    else if (FDragDropItem <> nil) then
      FItems.Add.Assign(FDragDropItem);
  end;

  if (FDragDropItem <> nil) then
  begin
    FDragDropItem.Free;
    FDragDropItem := nil;
  end;
  if (FInsertDropItem <> nil) then
  begin
    FInsertDropItem.Free;
    FInsertDropItem := nil;
  end;
  FHoveredItemIndex := -1;
end;

procedure TAdvSmoothDock.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TAdvSmoothDock.CalculateSin;
var
  xp, yp, i: integer;
  o: TPoint;
  rad, iv: Double;
begin
  xp := FItemAppearance.AnimationSpan;
  yp := Height div 2;
  o := Point(-xp div 2,Height div 2);
  rad := -Pi / 2;
  iv := 4.0 * Pi / 175;
  SetLength(FSin, 90);
  for i := 0 to 89 do
  begin
    FSin[i].pt.X := o.x + Round(rad * xp / Pi);
    FSin[i].pt.Y := o.y - Round(sin(rad) * yp);
    FSin[i].factor := sin(rad);
    rad := rad + iv;
  end;
end;

procedure TAdvSmoothDock.Changed;
begin
  if not Assigned(frm) then
    UpdateSize;

  if FUpdateCount = 0 then
    Invalidate;

  if (csDestroying in ComponentState) then
    Exit;

  if Assigned(frm) then
    frm.Invalidate;
end;

procedure TAdvSmoothDock.CMHintShow(var Message: TMessage);
var
  hint: String;
begin
  if FHoveredItemIndex <> -1 then
  begin
    with TCMHintShow(Message).HintInfo^ do
    begin
      hint := Items[FHoveredItemIndex].Hint;
      if Assigned(OnItemHint) then
        OnItemHint(Self, FHoveredItemIndex, hint);
      HintStr := hint;
      ReshowTimeout := 0;
    end;
  end;
end;

constructor TAdvSmoothDock.Create(AOwner: TComponent);
begin
  FConstructed := false;
  inherited Create(AOwner);
  FFocus := true;
  FAnimationFactor := 2;
  DoubleBuffered := true;
  Width := 600;
  Height := 200;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FItemAppearance := TAdvSmoothDockItemAppearance.Create(Self);
  FItemAppearance.OnChange := ItemAppearanceChanged;
  FArrowAppearance := TAdvSmoothDockArrowAppearance.Create(Self);
  FArrowAppearance.OnChange := ArrowAppearanceChanged;
  FTransparent := true;
  FSelectedItemIndex := -1;
  FHoveredItemIndex := -1;
  FPosition := dpBottom;
  FPlatForm3D := true;
  FPlatformFill := TGDIPFill.Create;
  FPlatformFill.OnChange := FillChanged;
  FPlatformSize := 60;
  FDragDropItem := nil;
  FItems := TAdvSmoothDockItems.Create(Self);
  FItems.OnChange := ItemsChanged;
  FSeparatorImage := TGPBitmap.Create;
  FSeparatorMemoryStream := TMemoryStream.Create;
  FOleDropTargetAssigned := false;
  FOleDragDrop := false;
  FPlatForm3DColor := clWhite;
  FPlatForm3DColorTo := clWhite;
  FPlatForm3DOpacity := 30;
  FPlatForm3DOpacityTo := 100;
  FDockOnDeskTop := false;
  CalculateSin;
  FAnimate := TTimer.Create(Self);
  FAnimate.OnTimer := Animate;
  FAnimate.Interval := 10;
  FAnimate.Enabled := true;

  FDesignTime := (csDesigning in ComponentState) and not
  ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));
end;

procedure TAdvSmoothDock.CreateWnd;
var
  i: integer;
begin
  inherited;
  ItemAppearance.SeparatorChanged(Self);
  for I := 0 to Items.Count - 1 do
    Items[i].UpdateReflection;

  if not (csDesigning in ComponentState) then
    ShowForm;

  if FConstructed then
    Exit;

  FConstructed := true;
end;

procedure TAdvSmoothDock.DoArrowLeftDown;
begin
  FAnimateMove := true;
  case Position of
    dpRight, dpLeft:
    begin
      if Items[0].GetItemRect.Y <= InsideRect.Top then
      begin
        FPosTo := FPosTo - ItemAppearance.ImageHeight;
        FanimateMove := true;
        if Assigned(FOnScroll) then
          FOnScroll(Self);
      end;
    end;
    dpTop, dpbottom:
    begin
      if Items[0].GetItemRect.X <= InsideRect.Left  then
      begin
        FPosTo := FPosTo - ItemAppearance.ImageWidth;
        FanimateMove := true;
        if Assigned(FOnScroll) then
          FOnScroll(Self);
      end;
    end;
  end;
end;

procedure TAdvSmoothDock.DoArrowRightDown;
begin
  case Position of
    dpRight, dpLeft:
    begin
      if Items[Items.Count - 1].GetItemRect.Y + Items[Items.Count - 1].GetItemRect.Height >= InsideRect.Bottom then
      begin
        FPosTo := FPosTo + ItemAppearance.ImageHeight;
        FAnimateMove := true;
        if Assigned(FOnScroll) then
          FOnScroll(Self);
      end;
    end;
    dpTop, dpbottom:
    begin
      if Items[Items.Count - 1].GetItemRect.X + Items[Items.Count - 1].GetItemRect.Width >= InsideRect.Right then
      begin
        FPosTo := FPosTo + ItemAppearance.ImageWidth;
        FAnimateMove := true;
        if Assigned(FOnScroll) then
          FOnScroll(Self);
      end;
    end;
  end;
end;

procedure TAdvSmoothDock.DoDblClick;
var
  item: integer;
  pt: TPoint;
begin
  inherited;
  FDblClick := true;
  FMouseDown := false;
  if Assigned(frm) then
    pt := frm.ScreenToClient(Mouse.CursorPos);

  if IsMouseOnArrow(Pt.X, pt.Y) then
    Exit;

  item := XYToItem(pt.X, pt.Y);
  if item <> -1 then
  begin
    if Assigned(FOnItemDblClick) then
      FOnItemDblClick(Self, item);
  end;
end;

destructor TAdvSmoothDock.Destroy;
begin
  if FInsertDropItem <> nil then
  begin
    FInsertDropItem.Free;
    FInsertDropItem := nil;
  end;
  if FDragDropItem <> nil then
  begin
    FDragDropItem.Free;
    FDragDropItem := nil;
  end;

  FArrowAppearance.Free;
  FSeparatorImage.Free;
  FSeparatorMemoryStream.Free;
  FFill.Free;
  FItems.Free;
  FItemAppearance.Free;
  FAnimate.Free;
  FPlatformFill.Free;
  inherited;
end;

procedure TAdvSmoothDock.DoDrag(X, Y: integer; Copy: Boolean);
var
  item: integer;
  allowinsert: Boolean;
begin
  if (FDragDropItem = nil) then
  begin
    item := XYToItem(X, Y, true);
    if item <> -1 then
    begin
      FDragDropItem := TAdvSmoothDockItem.Create(FItems);
      FDragDropItem.Assign(FItems[item]);
      FStartPopupTimer := false;
      if not Copy then
        FItems[item].Free;
    end;
  end;
  item := XYToItem(X, Y, true, true);
  if item <> -1 then
  begin
    if (FDragDropItem <> nil) then
    begin
      allowinsert := true;
      if Assigned(FOnDragInsert) then
      begin
        case Position of
          dpRight, dpLeft:
          begin
            if FDragY < Items[item].GetItemRect.Y + (Items[item].GetItemRect.Height / 2) then
              FOnDragInsert(Self, item - 1, item, allowinsert)
            else
              FOnDragInsert(Self, item, item + 1, allowinsert);
          end;
          dpTop, dpbottom:
          begin
            if FDragX < Items[item].GetItemRect.X + (Items[item].GetItemRect.Width / 2) then
              FOnDragInsert(Self, item - 1, item, allowinsert)
            else
              FOnDragInsert(Self, item, item + 1, allowinsert);
          end;
        end;
      end;
      if allowinsert then
      begin
        if FInsertDropItem = nil then
        begin
          FInsertDropItem := Items.Insert(item);
          FInsertDropItem.FInsertItem := true;
        end
        else
        begin
          if item <> FInsertDropItem.Index then
          begin
            FInsertDropItem.Free;
            FInsertDropItem := Items.Insert(item);
            FInsertDropItem.FInsertItem := true;
          end;
        end;
      end;
    end;
  end
  else if (FInsertDropItem <> nil) and not IsItemBounds(X, Y) then
  begin
    FInsertDropItem.Free;
    FInsertDropItem := nil;
  end;
end;

procedure TAdvSmoothDock.DoEnter;
begin
  inherited;
  FFocused := true;
  Changed;
end;

procedure TAdvSmoothDock.DoExit;
begin
  inherited;
  FFocused := false;
  Changed;
end;

procedure TAdvSmoothDock.DoDragDrop(Source: TObject; X, Y: Integer);
begin
  FMouseDown := false;
  if Assigned(FOnDragDrop) then
    FOnDragDrop(Self, Source, FDragDropItem, X, Y);

  DoDrop(X, Y);
  inherited;
end;

procedure TAdvSmoothDock.DoDragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited;
  FDragX := X;
  FDragY := Y;
  FMouseDown := true;
  if FDragDropItem = nil then
    FDragDropItem := TAdvSmoothDockItem.Create(FItems);

  if Assigned(FOnDragOver) then
    FOnDragOver(Self, Source, FDragDropItem, X, Y, State, Accept);

  if Accept then
  begin
    frm.FMouseEntered := true;
    DoDrag(X, Y, false);
    FPrevX := X;
    FPrevY := Y;
  end
  else if FDragDropItem <> nil then
  begin
    FMouseDown := false;
    FDragDropItem.Free;
    FDragDropItem := nil;
  end;
end;

procedure TAdvSmoothDock.DrawArrows(g: TGPGraphics);
var
  doArrow: Boolean;
  c, bc: TColor;
  p: TGPPen;
  b: TGPBrush;
  path: TGPGraphicsPath;
  rl, rr: TGPRectF;
  x, y: Single;
begin
  with ArrowAppearance do
  begin
    doArrow := false;
    case Position of
      dpRight, dpLeft: doArrow := Visible and (GetItemsRectangle.Height > (InsideRect.Bottom - InsideRect.Top) + ItemAppearance.ImageHeight);
      dpBottom, dpTop: doArrow := Visible and (GetItemsRectangle.Width > (InsideRect.Right - InsideRect.Left) + ItemAppearance.ImageWidth);
    end;
    if doArrow then
    begin
      rl := GetArrowLeft;
      x := rl.X;
      y := rl.Y;
      //left
      c := Color;
      if FArrowLeftDown then
        c := Darker(c, 30)
      else if FArrowLeftHover then
        c := Lighter(c, 30);

      path := TGPGraphicsPath.Create;
      case Position of
        dpRight, dpLeft:
        begin
          path.AddArc(rl, 0, 180);
          path.CloseFigure;
        end;
        dpBottom, dpTop:
        begin
          path.AddArc(rl, 270, 180);
          path.CloseFigure;
        end;
      end;

      b := TGPSolidBrush.Create(MakeColor(Opacity, c));
      g.FillPath(b, path);
      b.free;
      b := nil;
      case Position of
        dpRight, dpLeft:b := TGPLinearGradientBrush.Create(MakeRect(GetArrowLeft.X, GetArrowLeft.Y, GetArrowLeft.Height, GetArrowLeft.Width / 2), MakeColor(100, clWhite), Makecolor(0, clWhite), LinearGradientModeHorizontal);
        dpBottom, dpTop: b := TGPLinearGradientBrush.Create(MakeRect(GetArrowLeft.X, GetArrowLeft.Y, GetArrowLeft.Height / 2, GetArrowLeft.Width), MakeColor(100, clWhite), Makecolor(0, clWhite), LinearGradientModeVertical);
      end;
      g.FillPath(b, path);
      b.Free;
      p := TGPPen.Create(MakeColor(Opacity, BorderColor), 1);
      g.DrawPath(p, path);
      p.Free;
      path.Free;

      path := TGPGraphicsPath.Create;
      case Position of
        dpRight, dpLeft:
        begin
          path.AddLine(MakePoint(x + rl.Width / 2, y + rl.Height * 2 / 3), MakePoint(x + rl.Width / 3, y + rl.Height * 4 / 5));
          path.AddLine(MakePoint(x + rl.Width / 2, y + rl.Height * 2 / 3), MakePoint(x + rl.Width * 2 / 3, y + rl.Height * 4 / 5));
        end;
        dpBottom, dpTop:
        begin
          path.AddLine(MakePoint(x + rl.Width * 2 / 3, y + rl.Height / 2), MakePoint(x + rl.Width * 4 / 5, y + rl.Height / 3));
          path.AddLine(MakePoint(x + rl.Width * 2 / 3, y + rl.Height / 2), MakePoint(x + rl.Width * 4 / 5, y + rl.Height * 2 / 3));
        end;
      end;

      bc := BorderColor;
      case Position of
        dpRight, dpLeft:
        begin
          if not (Items[0].GetItemRect.Y <= InsideRect.Top) then
            bc := clGray;
        end;
        dpTop, dpbottom:
        begin
          if not (Items[0].GetItemRect.X <= InsideRect.Left) then
            bc := clGray;
        end;
      end;

      p := TGPPen.Create(MakeColor(Opacity, bc), 2);
      g.DrawPath(p, path);
      p.Free;
      path.Free;

      //right
      rr := GetArrowRight;
      x := rr.X;
      y := rr.Y;
      c := Color;
      if FArrowRightDown then
        c := Darker(c, 30)
      else if FArrowRightHover then
        c := Lighter(c, 30);

      path := TGPGraphicsPath.Create;
      case Position of
        dpRight, dpLeft:
        begin
          path.AddArc(rr, 180, 180);
          path.CloseFigure;
        end;
        dpBottom, dpTop:
        begin
          path.AddArc(rr, 90, 180);
          path.CloseFigure;
        end;
      end;


      b := TGPSolidBrush.Create(MakeColor(Opacity, c));
      g.FillPath(b, path);
      b.free;
      b := nil;
      case Position of
        dpRight, dpLeft:b := TGPLinearGradientBrush.Create(MakeRect(GetArrowRight.X, GetArrowRight.Y, GetArrowRight.Height, GetArrowRight.Width / 2), MakeColor(100, clWhite), Makecolor(0, clWhite), LinearGradientModeHorizontal);
        dpBottom, dpTop: b := TGPLinearGradientBrush.Create(MakeRect(GetArrowRight.X, GetArrowRight.Y, GetArrowRight.Height / 2, GetArrowRight.Width), MakeColor(100, clWhite), Makecolor(0, clWhite), LinearGradientModeVertical);
      end;
      g.FillPath(b, path);
      b.Free;
      p := TGPPen.Create(MakeColor(Opacity, BorderColor), 1);
      g.DrawPath(p, path);
      p.Free;
      path.Free;

      path := TGPGraphicsPath.Create;
      case Position of
        dpRight, dpLeft:
        begin
          path.AddLine(MakePoint(x + rr.Width / 2, y + rr.Height / 3), MakePoint(x + rr.Width / 3, y + rr.Height / 5));
          path.AddLine(MakePoint(x + rr.Width / 2, y + rr.Height / 3), MakePoint(x + rr.Width * 2 / 3, y + rr.Height / 5));
        end;
        dpBottom, dpTop:
        begin
          path.AddLine(MakePoint(x + rr.Width / 3, y + rl.Height / 2), MakePoint(x + rl.Width / 5, y + rl.Height / 3));
          path.AddLine(MakePoint(x + rr.Width / 3, y + rl.Height / 2), MakePoint(x + rl.Width / 5, y + rl.Height * 2 / 3));
        end;
      end;

      bc := BorderColor;
      case Position of
        dpRight, dpLeft:
        begin
          if not (Items[Items.Count - 1].GetItemRect.Y + Items[Items.Count - 1].GetItemRect.Height >= InsideRect.Bottom) then
            bc := clGray;
        end;
        dpTop, dpbottom:
        begin
          if not (Items[Items.Count - 1].GetItemRect.X + Items[Items.Count - 1].GetItemRect.Width >= InsideRect.Right) then
            bc := clGray;
        end;
      end;

      p := TGPPen.Create(MakeColor(Opacity, bc), 2);
      g.DrawPath(p, path);
      p.Free;
      path.Free;
    end;
  end;
end;

procedure TAdvSmoothDock.DrawBackGround(g: TGPGraphics; Control: Boolean);
var
  b: TGPSolidBrush;
begin
  //Transparent layer
  b := TGPSolidBrush.Create(MakeColor(1, clWhite));
  //Transparent layer
  g.FillRectangle(b, GetItemsMinimumRectangle);
  b.Free;
  if not Transparent and Control then
    FFill.Fill(g, MakeRect(0, 0, Width - 1, Height - 1));
end;

procedure TAdvSmoothDock.DrawCaption(g: TGPGraphics);
var
  item: integer;
  ff: TGPFontFamily;
  fs: integer;
  sf: TGPStringFormat;
  f: TGPFont;
  b: TGPSolidBrush;
  sizer: TGPRectF;
  r: TGPRectF;
  w: Double;
  h: Double;
begin
  item := XYToItem(FHintX, FHintY);
  if item <> -1 then
  begin
    with Items[item] do
    begin
      if not ShowCaption or Separator or (caption = '') then
        Exit;

      ff := TGPFontFamily.Create(ItemAppearance.CaptionFont.Name);
      if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
      begin
        ff.Free;
        ff := TGPFontFamily.Create('Arial');
      end;

      fs := 0;
      if (fsBold in ItemAppearance.CaptionFont.Style) then
        fs := fs + 1;
      if (fsItalic in ItemAppearance.CaptionFont.Style) then
        fs := fs + 2;
      if (fsUnderline in ItemAppearance.CaptionFont.Style) then
        fs := fs + 4;

      sf := TGPStringFormat.Create;
      f := TGPFont.Create(ff, ItemAppearance.CaptionFont.Size, fs, UnitPoint);
      g.SetTextRenderingHint(TextRenderingHintAntiAlias);
      g.MeasureString(Caption, length(Caption), f, MakeRect(GetItemRect.X, GetItemRect.Y, 10000, 10000), sf, sizer);

      sizer.Width := sizer.Width + 6;
      sizer.Height := sizer.Height + 4;

      r := MakeRect(sizer.X + (GetItemRect.Width - sizer.Width) / 2, sizer.Y - sizer.Height, sizer.Width, sizer.Height);
      w := r.X + r.Width;
      h := r.Y + r.Height;
      if w > InsideRect.Right then
        r.X := r.X - Abs(Insiderect.Right - w)
      else if r.X < InsideRect.Left then
        r.X := r.X + Abs(InsideRect.Left - r.X);

      if h > InsideRect.Bottom then
        r.Y := r.Y - Abs(Insiderect.Bottom - h)
      else if r.Y < InsideRect.Top then
        r.Y := r.Y + Abs(Insiderect.Top - r.Y);



      FItemAppearance.CaptionFill.Fill(g, r);

      b := TGPSolidBrush.Create(MakeColor(255, ItemAppearance.CaptionFont.Color));
      g.DrawString(Caption, Length(Caption), f, MakePoint(r.X + 2, r.Y + 2), sf, b);

      ff.Free;
      sf.Free;
      f.free;
      b.Free;
    end;
  end;
end;

procedure TAdvSmoothDock.DrawIndicator(g: TGPGraphics; ItemIndex: integer);
var
  r: TGPRectF;
  s: Integer;
  off: integer;
begin
  Exit;
  if (ItemIndex >= 0) and (Itemindex <= Items.Count - 1) then
  begin
    with Items[ItemIndex] do
    begin
      r := GetItemRect;
      s := ItemAppearance.SelectionSize;
      off := ItemAppearance.SelectionOffset;
      case Position of
        dpLeft: ItemAppearance.SelectionFill.Fill(g, MakeRect(InsideRect.Left + off, r.Y + (r.Height - s) / 2, s, s));
        dpRight: ItemAppearance.SelectionFill.Fill(g, MakeRect(InsideRect.Right - off - s, r.Y + (r.Height - s) / 2, s, s));
        dpTop: ItemAppearance.SelectionFill.Fill(g, MakeRect(r.X + (r.Width - s) / 2, Insiderect.Top + off, s, s));
        dpBottom: ItemAppearance.SelectionFill.Fill(g, MakeRect(r.X + (r.Width - s) / 2, Insiderect.Bottom - off - s, s, s));
      end;
    end;
  end;
end;

procedure TAdvSmoothDock.DrawItems(g: TGPGraphics);
var
  i: integer;
  r: TGPRectF;
  x, y: integer;
  xs, ys: Double;
  check: Boolean;
  w, h: integer;
  f, foc: TGDIPFill;
  b: TAdvSmoothDockBounds;
begin
  with ItemAppearance do
  begin
    foc := TGDIPFill.Create;
    foc.Color := clNone;
    //Draw normal items
    b := GetBounds;
    for I := b.Start to b.Stop do
    begin
      with Items[i] do
      begin
        if (FDragDropItem <> nil) and (FInsertDropItem <> nil) then
          check := (Items[i] <> FDragDropItem) and not FInsertItem
        else if (FDragDropItem <> nil) then
          check := (Items[i] <> FdragDropItem)
        else
          check := true;

        if check and Visible then
        begin
          r := GetItemRect;
          if ItemBackGround and not Separator then
          begin
            if Enabled then
            begin
              if FSelectedItemIndex = Index then
                f := FSelectedFill
              else if FHoveredItemIndex = index then
                f := FHoverFill
              else
                f := FFill;
            end
            else
              f := FDisabledFill;

            f.Fill(g, r);
          end;

          foc.Focus := FFocused and ShowFocus and TabStop and (FSel = index);
          foc.Fill(g, r);

          if not Separator then
          begin
            if ProgressPosition > ProgressMinimum then
            begin
              if (ProgressMaximum - ProgressMinimum > 0) and (ProgressPosition >= ProgressMinimum) and (ProgressPosition <= ProgressMaximum) then
                FProgressFill.Fill(g, MakeRect(r.X, r.Y, r.Width / (ProgressMaximum - ProgressMinimum) * ProgressPosition,r.Height));
            end;
          end;

          FImage.GetImageSizes;
          GetAspectSize(w, h, FImage.Width, FImage.Height, r.Width, r.Height, Separator);
          r.X := r.X + (r.Width - w) / 2;
          r.Width := w;
          r.Y := r.Y + (r.Height - h) / 2;
          r.Height := h;

          if Assigned(FImage) and not FImage.Empty then
          begin
            FImage.GDIPDraw(g, Bounds(Round(r.X), Round(R.Y), Round(R.Width), Round(R.Height)));

            if Assigned(FReflectionImage) and (ReflectionSize > 0) then
            begin
              case FOwner.Position of
                dpLeft:
                begin
                  x := Round(r.X - r.Width - (FJMP * 2));
                  y := Round(R.Y);
                  g.DrawImageRect(FReflectionImage, x - FReflectionSpacing, y, Round(r.Width), Round(r.Height))
                end;
                dpRight:
                begin
                  x := Round(r.X + r.Width + (FJMP * 2));
                  y := Round(R.Y);
                  g.DrawImageRect(FReflectionImage, x + FReflectionSpacing, y, Round(r.Width), Round(r.Height))
                end;
                dpTop:
                begin
                  x := Round(r.X);
                  y := Round(R.Y - r.Height - (FJMP * 2));
                  g.DrawImageRect(FReflectionImage, x, y - FReflectionSpacing, Round(r.Width), Round(r.Height))
                end;
                dpBottom:
                begin
                  x := Round(r.X);
                  y := Round(R.Y + r.Height + (FJMP * 2));
                  g.DrawImageRect(FReflectionImage, x, y + FReflectionSpacing, Round(r.Width), Round(r.Height))
                end;
              end;
            end;
          end;
          if not Separator then
          begin
            with StatusIndicator do
            begin
              if Visible then
              begin
                xs := 0;
                ys := 0;
                Appearance.CalculateSize(g, Caption);
                case Position of
                  dpRight, dpLeft, dpTop, dpBottom:
                  begin
                    xs := r.X + R.Width + OffsetLeft - Appearance.GetWidth;
                    ys := r.Y - Appearance.GetHeight div 2 + OffsetTop;
                  end;
                end;
                Appearance.Draw(g, Round(xs), Round(ys), 0, 0, true,Caption);
              end;
            end;
          end;
        end;
      end;
    end;
    //
    //Draw DragDropItem
    if FDragDropItem <> nil then
    begin
      with FDragDropItem do
      begin
        if not Visible then
          Exit;

        r := GetNormalRect;
        FImage.GetImageSizes;
        GetAspectSize(w, h, FImage.Width, FImage.Height, r.Width, r.Height, Separator);
        r.X := r.X + (r.Width - w) / 2;
        r.Width := w;
        r.Y := r.Y + (r.Height - h) / 2;
        r.Height := h;
        r.X := FDragX;
        r.Y := FDragY;

        if Separator then
        begin
          case Position of
            dpLeft, dpRight: r.Height := SeparatorSize;
            dpTop, dpBottom: r.Width := SeparatorSize;
          end;
        end;

        if ItemBackGround and not Separator then
        begin
          if Enabled then
          begin
            if FSelectedItemIndex = Index then
              FSelectedFill.Fill(g, MakeRect(r.X - r.Width / 2, r.Y - R.Height / 2, R.Width, R.Height))
            else if FHoveredItemIndex = index then
              FHoverFill.Fill(g, MakeRect(r.X - r.Width / 2, r.Y - R.Height / 2, R.Width, R.Height))
            else
              FFill.Fill(g, MakeRect(r.X - r.Width / 2, r.Y - R.Height / 2, R.Width, R.Height));
          end
          else
            FDisabledFill.Fill(g, MakeRect(r.X - r.Width / 2, r.Y - R.Height / 2, R.Width, R.Height));
        end;

        if Assigned(FImage) and not FImage.Empty then
          FImage.GDIPDraw(g, Bounds(Round(r.X - r.Width / 2), Round(r.Y - R.Height / 2), Round(R.Width), Round(R.Height)));
      end;
    end;
    //
    foc.free;
  end;
end;

procedure TAdvSmoothDock.DrawPlatForm(g: TGPGraphics);
var
  gp: TGPGraphicsPath;
  x, y, w, h: single;
  b: TGPBrush;
  p: TGPPen;
begin
  h := PlatformSize;
  w := h;
  case Position of
    dpLeft:
    begin
      if PlatForm3D then
      begin
        gp := TGPGraphicsPath.Create;
        h := GetPlatFormRectangle.Height;
        x := GetPlatFormRectangle.X;
        y := GetPlatFormRectangle.Y;
        gp.AddLine(MakePoint(x + 12, y), MakePoint(x + w, y + 30));
        gp.AddLine(MakePoint(x + w, y + 30), MakePoint(x + w, y + h - 30));
        gp.AddLine(MakePoint(x + w, y + h - 30), MakePoint(x + 12, y + h));
        gp.CloseFigure;

        b := TGPLinearGradientBrush.Create(MakeRect(x, y, w, h), MakeColor(PlatForm3DOpacity, PlatForm3DColor), MakeColor(PlatForm3DOpacityTo, PlatForm3DColorTo), 180);
        p := TGPPen.Create(MakeColor(80, PlatForm3DColorTo));
        g.FillPath(b, gp);
        g.DrawPath(p, gp);
        p.Free;
        b.Free;

        b := TGPSolidBrush.Create(MakeColor(PlatForm3DOpacityTo, PlatForm3DColorTo));
        p := TGPPen.Create(MakeColor(80, PlatForm3DColorTo));
        g.FillRectangle(b, MakeRect(x, y, 12, h));
        g.DrawRectangle(p, MakeRect(x, y, 12, h));
        b.Free;
        p.Free;

        gp.Free;
      end
      else
        FPlatformFill.Fill(g, MakeRect(InsideRect.Left, InsideRect.Top, h, InsideRect.Bottom));
    end;
    dpRight:
    begin
      if PlatForm3D then
      begin
        gp := TGPGraphicsPath.Create;
        h := GetPlatFormRectangle.Height;
        x := GetPlatFormRectangle.X + GetPlatFormRectangle.Width;
        y := GetPlatFormRectangle.Y;
        gp.AddLine(MakePoint(x - 12, y), MakePoint(x - w, y + 30));
        gp.AddLine(MakePoint(x - w, y + 30), MakePoint(x - w, y + h - 30));
        gp.AddLine(MakePoint(x - w, y + h - 30), MakePoint(x - 12, y + h));
        gp.CloseFigure;

        b := TGPLinearGradientBrush.Create(MakeRect(x, y, w, h), MakeColor(PlatForm3DOpacity, PlatForm3DColor), MakeColor(PlatForm3DOpacityTo, PlatForm3DColorTo), 0);
        p := TGPPen.Create(MakeColor(80, PlatForm3DColorTo));
        g.FillPath(b, gp);
        g.DrawPath(p, gp);
        p.Free;
        b.Free;

        b := TGPSolidBrush.Create(MakeColor(PlatForm3DOpacityTo, PlatForm3DColorTo));
        p := TGPPen.Create(MakeColor(80, PlatForm3DColorTo));
        g.FillRectangle(b, MakeRect(x - 12, y, 12, h));
        g.DrawRectangle(p, MakeRect(x - 12, y, 12, h));
        b.Free;
        p.Free;

        gp.Free;
      end
      else
        FPlatformFill.Fill(g, MakeRect(InsideRect.Right - h, InsideRect.Top, h, InsideRect.Bottom));
    end;
    dpTop:
    begin
      if PlatForm3D then
      begin
        gp := TGPGraphicsPath.Create;
        w := GetPlatFormRectangle.Width;
        x := GetPlatFormRectangle.X;
        y := InsideRect.Top + 12;
        gp.AddLine(MakePoint(x, y), MakePoint(x + 30, y + h));
        gp.AddLine(MakePoint(x + 30, y + h), MakePoint(x + w - 30, y + h));
        gp.AddLine(MakePoint(x + w - 30, y + h), MakePoint(x + w, y));
        gp.CloseFigure;

        b := TGPLinearGradientBrush.Create(MakeRect(x, y, w, h), MakeColor(PlatForm3DOpacity, PlatForm3DColor), MakeColor(PlatForm3DOpacityTo, PlatForm3DColorTo), -90);
        p := TGPPen.Create(MakeColor(80, PlatForm3DColorTo));
        g.FillPath(b, gp);
        g.DrawPath(p, gp);
        p.Free;
        b.Free;

        b := TGPSolidBrush.Create(MakeColor(PlatForm3DOpacityTo, PlatForm3DColorTo));
        p := TGPPen.Create(MakeColor(80, PlatForm3DColorTo));
        g.FillRectangle(b, MakeRect(x, y - 12, w, 12));
        g.DrawRectangle(p, MakeRect(x, y - 12, w, 12));
        b.Free;
        p.Free;

        gp.Free;
      end
      else
        FPlatformFill.Fill(g, MakeRect(InsideRect.Left, InsideRect.Top, InsideRect.Right, h));
    end;
    dpBottom:
    begin
      if PlatForm3D then
      begin
        gp := TGPGraphicsPath.Create;
        w := GetPlatFormRectangle.Width;
        x := GetPlatFormRectangle.X;
        y := InsideRect.Bottom - 12;
        gp.AddLine(MakePoint(x, y), MakePoint(x + 30, y - h));
        gp.AddLine(MakePoint(x + 30, y - h), MakePoint(x + w - 30, y - h));
        gp.AddLine(MakePoint(x + w - 30, y - h), MakePoint(x + w, y));
        gp.CloseFigure;

        b := TGPLinearGradientBrush.Create(MakeRect(x, y, w, h), MakeColor(PlatForm3DOpacity, PlatForm3DColor), MakeColor(PlatForm3DOpacityTo, PlatForm3DColorTo), 90);
        p := TGPPen.Create(MakeColor(80, PlatForm3DColorTo));
        g.FillPath(b, gp);
        g.DrawPath(p, gp);
        p.Free;
        b.Free;

        b := TGPSolidBrush.Create(MakeColor(PlatForm3DOpacityTo, PlatForm3DColorTo));
        p := TGPPen.Create(MakeColor(80, PlatForm3DColorTo));
        g.FillRectangle(b, MakeRect(x, y, w, 12));
        g.DrawRectangle(p, MakeRect(x, y, w, 12));
        b.Free;
        p.Free;

        gp.Free;
      end
      else
        FPlatformFill.Fill(g, MakeRect(InsideRect.Left, InsideRect.Bottom - h, InsideRect.Right, h));
    end;
  end;
end;

procedure TAdvSmoothDock.EndUpdate;
begin
  Dec(FUpdateCount);
end;

function TAdvSmoothDock.FactorInSinus(X, Y: integer; pt: TGPPointF): Double;
var
  I: Integer;
  ch: Boolean;
begin
  result := 0;
  for I := 0 to Length(FSin) - 2 do
  begin
    ch := false;
    case Position of
      dpLeft, dpRight: ch := (pt.Y >= FSin[i].pt.X + Y) and (pt.Y <= FSin[i + 1].pt.X + Y);
      dpTop, dpBottom: ch := (pt.X >= FSin[i].pt.X + X) and (pt.X <= FSin[i + 1].pt.X + X);
    end;
    if ch then
    begin
      result := FSin[i].factor;
      break;
    end;
  end;
end;

procedure TAdvSmoothDock.FillChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothDock.GetArrowLeft: TGPRectF;
var
  doArrow: Boolean;
begin
  doarrow := false;
  case Position of
    dpRight, dpLeft: doArrow := Visible and (GetItemsRectangle.Height > (InsideRect.Bottom - InsideRect.Top) + ItemAppearance.ImageHeight);
    dpBottom, dpTop: doArrow := Visible and (GetItemsRectangle.Width > (InsideRect.Right - InsideRect.Left) + ItemAppearance.ImageWidth);
  end;

  if Doarrow then
  begin
    case Position of
      dpLeft:Result := MakeRect(InsideRect.Left + (GetMinimumHeight - ArrowAppearance.Size) / 2, InsideRect.Top - ArrowAppearance.Size / 2, ArrowAppearance.Size, ArrowAppearance.Size);
      dpRight: Result := MakeRect(InsideRect.Right - GetMinimumHeight / 2 - ArrowAppearance.Size / 2, InsideRect.Top - ArrowAppearance.Size / 2, ArrowAppearance.Size, ArrowAppearance.Size);
      dpTop: Result := MakeRect(InsideRect.Left - ArrowAppearance.Size / 2, InsideRect.Top + (GetMinimumHeight - ArrowAppearance.Size) / 2, ArrowAppearance.Size, ArrowAppearance.Size);
      dpBottom: Result := MakeRect(InsideRect.Left - ArrowAppearance.Size / 2, InsideRect.Bottom - GetMinimumHeight / 2 - ArrowAppearance.Size / 2, ArrowAppearance.Size, ArrowAppearance.Size);
    end;
  end
  else
    Result := MakeRect(0, 0, 0, 0);
end;

function TAdvSmoothDock.GetArrowRight: TGPRectF;
var
  doArrow: Boolean;
begin
  doarrow := false;
  case Position of
    dpRight, dpLeft: doArrow := Visible and (GetItemsRectangle.Height > (InsideRect.Bottom - InsideRect.Top) + ItemAppearance.ImageHeight);
    dpBottom, dpTop: doArrow := Visible and (GetItemsRectangle.Width > (InsideRect.Right - InsideRect.Left) + ItemAppearance.ImageWidth);
  end;

  if Doarrow then
  begin
    case Position of
      dpLeft:Result := MakeRect(InsideRect.Left + (GetMinimumHeight - ArrowAppearance.Size) / 2, InsideRect.Bottom - ArrowAppearance.Size / 2, ArrowAppearance.Size, ArrowAppearance.Size);
      dpRight: Result := MakeRect(InsideRect.Right - GetMinimumHeight / 2 - ArrowAppearance.Size / 2, InsideRect.Bottom - ArrowAppearance.Size / 2, ArrowAppearance.Size, ArrowAppearance.Size);
      dpTop:Result := MakeRect(InsideRect.Right - ArrowAppearance.Size / 2 , InsideRect.Top + (GetMinimumHeight - ArrowAppearance.Size) / 2, ArrowAppearance.Size, ArrowAppearance.Size);
      dpBottom: Result := MakeRect(InsideRect.Right - ArrowAppearance.Size / 2, InsideRect.Bottom  - GetMinimumHeight / 2 - ArrowAppearance.Size / 2, ArrowAppearance.Size, ArrowAppearance.Size);
    end;
  end
  else
    Result := MakeRect(0, 0, 0, 0);
end;

procedure TAdvSmoothDock.GetAspectSize(var w, h: integer; ow, oh, nw,
  nh: double; Separator: Boolean);
begin
  if ItemAppearance.AspectRatio or Separator then
  begin
    if (ow > 0) and (oh > 0) and (nw > 0) and (nh > 0) then
    begin
      if (ow < nw) and (oh < nh) then
      begin
        w := round(ow);
        h := round(oh);
      end
      else
      begin
        if ow / oh < nw / nh then
        begin
          h := Round(nh);
          w := MulDiv(Round(nh), round(ow), round(oh));
        end
        else
        begin
          w := Round(nw);
          h := MulDiv(Round(nw), round(oh), round(ow));
        end;
      end;
    end
    else
    begin
      w := 0;
      h := 0;
    end;
  end
  else
  begin
    w := Round(nw);
    h := Round(nh);
  end;
end;

function TAdvSmoothDock.GetBounds: TAdvSmoothDockBounds;
var
  I: Integer;
  res1, res2, res1Found, res2Found: Boolean;
begin
  Result.Start := 0;
  Result.Stop := Items.Count - 1;

  res1 := false;
  res2 := false;
  res1Found := false;
  res2Found := false;
  for I := 0 to Items.Count - 1 do
  begin
    with Items[I] do
    begin
      case Position of
        dpRight, dpLeft:
        begin
          res1 := GetItemRect.Y >= -ItemAppearance.ImageHeight;
          res2 := GetItemRect.Y >= InsideRect.Bottom - ItemAppearance.ImageHeight;
        end;
        dpBottom, dpTop:
        begin
          res1 := GetItemRect.X >= -ItemAppearance.ImageWidth;
          res2 := GetItemRect.X >= InsideRect.Right - ItemAppearance.ImageWidth;
        end;
      end;

      if not res1Found and res1 then
      begin
        res1Found := true;
        result.Start := I;
      end;

      if not res2Found and res2 then
      begin
        res2Found := true;
        Result.Stop := I;
      end;

      if res1Found and res2Found then
      begin
        Break;
      end;
    end;
  end;
end;

function TAdvSmoothDock.GetFirstIndex: integer;
begin
  Result := GetBounds.Start;
end;

function TAdvSmoothDock.GetHeight: integer;
begin
  if Assigned(frm) then
    Result := frm.Height
  else
    Result := Height;
end;

function TAdvSmoothDock.GetMaximumHeight: integer;
begin
  Result := ItemAppearance.ImageOffset + ItemAppearance.MaximumImageHeight + Round(GetMaxSizeCaption.h);
end;

function TAdvSmoothDock.GetMaximumWidth: integer;
begin
  Result := ItemAppearance.ImageOffset + ItemAppearance.MaximumImageWidth + Round(GetMaxSizeCaption.w);
end;

function TAdvSmoothDock.GetMaxSizeCaption: TCaptionSize;
var
  ff: TGPFontFamily;
  fs: integer;
  sf: TGPStringFormat;
  f: TGPFont;
  sizer: TGPRectF;
  I: Integer;
  g: TGPGraphics;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetTextRenderingHint(TextRenderingHintAntiAlias);
  Result.h := 0;
  Result.w := 0;
  ff := TGPFontFamily.Create(ItemAppearance.CaptionFont.Name);
  if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
  begin
    ff.Free;
    ff := TGPFontFamily.Create('Arial');
  end;

  fs := 0;
  if (fsBold in ItemAppearance.CaptionFont.Style) then
    fs := fs + 1;
  if (fsItalic in ItemAppearance.CaptionFont.Style) then
    fs := fs + 2;
  if (fsUnderline in ItemAppearance.CaptionFont.Style) then
    fs := fs + 4;

  sf := TGPStringFormat.Create;
  f := TGPFont.Create(ff, ItemAppearance.CaptionFont.Size, fs, UnitPoint);
  for I := 0 to Items.Count - 1 do
  begin
    with Items[I] do
    begin
      if ShowCaption and not Separator then
      begin
        g.MeasureString(Caption, length(Caption), f, MakeRect(GetItemRect.X, GetItemRect.Y, 10000, 10000), sf, sizer);
        sizer.Width := sizer.Width + 6;
        sizer.Height := sizer.Height + 4;
        if sizer.Width > Result.w then
          Result.w := sizer.Width;
        if sizer.Height > Result.h then
          Result.h := sizer.Height;
      end;
    end;
  end;

  ff.Free;
  sf.Free;
  f.free;
  g.Free;
end;

function TAdvSmoothDock.GetItemsMinimumRectangle: TGPRectF;
begin
  case Position of
    dpLeft: result := MakeRect(InsideRect.Left, InsideRect.Top + (GetHeight - GetTotalSize) / 2, GetMinimumWidth, GetTotalSize);
    dpRight: result := MakeRect(InsideRect.Right - GetMinimumWidth, InsideRect.Top + (GetHeight - GetTotalSize) / 2, GetMinimumWidth, GetTotalSize);
    dpTop: result := MakeRect(InsideRect.Left + (GetWidth - GetTotalSize) / 2, InsideRect.Top, GetTotalSize, GetMinimumHeight);
    dpBottom: result := MakeRect(InsideRect.Left + (GetWidth - GetTotalSize) / 2, InsideRect.Bottom - GetMinimumHeight, GetTotalSize, GetMinimumHeight);
  end;
end;

function TAdvSmoothDock.GetItemsRectangle: TGPRectF;
begin
  case Position of
    dpLeft, dpRight: result := MakeRect(InsideRect.Left, InsideRect.Top + (GetHeight - Max(ItemAppearance.ImageHeight * 2, GetTotalSize)) / 2, InsideRect.Right, Max(ItemAppearance.ImageHeight * 2, GetTotalSize));
    dpTop, dpBottom: result := MakeRect(InsideRect.Left + (GetWidth - Max(ItemAppearance.ImageWidth * 2, GetTotalSize)) / 2, InsideRect.Top, Max(ItemAppearance.ImageWidth * 2, GetTotalSize), InsideRect.Bottom);
  end;
end;

function TAdvSmoothDock.GetMinimumHeight: integer;
begin
  Result := ItemAppearance.ImageOffset + ItemAppearance.ImageHeight + 25;
end;

function TAdvSmoothDock.GetTotalSize: Double;
var
  total: Double;
  i: integer;
  r: TGPRectF;
begin
  total := 0;
  for I := 0 to Items.Count - 1 do
  begin
    with Items[I] do
    begin
      if Items[I].Visible then
      begin
        r := GetItemRectCenter;
        case FOwner.Position of
          dpRight, dpLeft: total := total + r.Height + ItemAppearance.Spacing;
          dpTop, dpBottom: total := total + r.Width + ItemAppearance.Spacing;
        end;
      end;
    end;
  end;
  result := total;
end;

function TAdvSmoothDock.GetMinimumWidth: integer;
begin
  Result := ItemAppearance.ImageOffset + ItemAppearance.ImageWidth + 25;
end;

function TAdvSmoothDock.GetPlatFormRectangle: TGPRectF;
begin
  case Position of
    dpRight, dpLeft: Result := MakeRect(GetItemsRectangle.X, Max(0, GetItemsRectangle.Y), GetItemsRectangle.Width, Min(InsideRect.Bottom - Insiderect.Left, GetItemsRectangle.Height));
    dpBottom, dpTop: Result := MakeRect(Max(0, GetItemsRectangle.X), GetItemsRectangle.Y, Min(InsideRect.Right - InsideRect.Left, GetItemsRectangle.Width), GetItemsRectangle.Height);
  end;
end;

function TAdvSmoothDock.GetVersion: String;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvSmoothDock.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;


function TAdvSmoothDock.GetVisibleItemCount: integer;
var
  b: TAdvSmoothDockBounds;
begin
  b := GetBounds;
  Result := b.Stop - b.Start;
end;

function TAdvSmoothDock.GetWidth: integer;
begin
  if Assigned(frm) then
    Result := frm.Width
  else
    Result := Width;
end;

function TAdvSmoothDock.InsideRect: TRect;
var
  sh, bw: integer;
begin
  sh := 0;
  if (Fill.ShadowColor <> clNone) {and not Transparent} then
    sh := Fill.ShadowOffset;

  Result := Rect(0, 0, GetWidth, GetHeight);
  // adapt width & height for GDI+ drawing rect

  Result.Right := Result.Right - 1 - sh;
  Result.Bottom := Result.Bottom - 1 - sh;

  if (Fill.BorderColor <> clNone) {and not Transparent} then
  begin
    if Fill.BorderWidth = 1 then
      bw := 1
    else
      bw := (Fill.BorderWidth + 1) div 2;

    InflateRect(Result, -bw, -bw);
  end;
end;

function TAdvSmoothDock.IsItemBounds(X, Y: integer): Boolean;
begin
  result := false;
  case Position of
    dpLeft: result := X <= GetItemBounds;
    dpRight: result := X >= GetItemBounds;
    dpBottom: result := y >= GetItemBounds;
    dpTop: result := y <= GetItemBounds;
  end;
end;

function TAdvSmoothDock.IsMouseOnArrow(X, Y: integer): Boolean;
begin
  Result := PtInGPRect(GetArrowLeft, Point(X, Y)) or PtInGPRect(GetArrowRight, Point(X, Y));
end;

function TAdvSmoothDock.IsMoving(X, Y: integer): Boolean;
begin
  Result := not PtInGPRect(MakeRect(FClickX - DRAGMARGIN / 2, FClickY - DRAGMARGIN / 2, DRAGMARGIN, DRAGMARGIN), Point(X, Y));
end;

function TAdvSmoothDock.GetItemBounds: integer;
begin
  result := 0;
  with ItemAppearance do
  begin
    case Position of
      dpLeft: result := InsideRect.Left + MaximumImageWidth + FImageOffset;
      dpRight: result := InsideRect.Right - MaximumImageWidth - FImageOffset;
      dpTop: result := InsideRect.Top + MaximumImageHeight + FImageOffset;
      dpBottom: result := InsideRect.Bottom - MaximumImageHeight - FImageOffset;
    end;
  end;
end;

procedure TAdvSmoothDock.ItemAppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothDock.ItemsChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothDock.DoKeyDown(var Key: Word; Shift: TShiftState);
var
  r: TGPRectF;
  s: integer;
begin
  s := FSel;
  case Key of
    VK_LEFT, VK_UP: FSel := FSel - 1;
    VK_RIGHT, VK_DOWN: FSel := FSel + 1;
    VK_HOME : FSel := 0;
    VK_END: FSel := Items.Count - 1;
    VK_NEXT : FSel := FSel + 3;
    VK_PRIOR : FSel := FSel - 3;
  end;

  if Fsel = s then
    Exit;


  if (Key <> VK_RETURN) and (Key <> VK_SPACE) then
  begin
    Fsel := Max(0, Min(Fsel, Items.Count - 1));
    r := Items[FSel].GetItemRect;
    FPrevx := Round(r.X + r.Width / 2);
    FPrevy := Round(r.Y + r.Height / 2);
  end;

  case Key of
    VK_RETURN: SelectedItemIndex := FSel;
    VK_SPACE:
    begin
      if (FSel >= 0) and (FSel < Items.Count - 1) then
      begin
        if Assigned(FOnItemClick) then
          FOnItemClick(Self, SelectedItemIndex);
      end;
    end;
  end;
end;

procedure TAdvSmoothDock.Loaded;
begin
  inherited;
  if FOleDropTargetAssigned then
  begin
    FDockDropTarget.AcceptText := true;
    FDockDropTarget.AcceptFiles := true;
    FDockDropTarget.AcceptURLs := true;
  end;
end;

procedure TAdvSmoothDock.DoMouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if IsMouseOnArrow(X, Y) then
  begin
    FArrowLeftDown := PtInGPRect(GetArrowLeft, Point(x, y));
    FArrowRightDown := PtInGPRect(GetArrowRight, Point(x, Y));
    FTimeDownOnArrow := 0;

    Changed;
    Exit;
  end;

  FMouseDown := true;
  FClickX := X;
  FClickY := Y;
  FMouseCopy := (Button = mbRight);
  FStartPopupTimer := true;
  FDoPopup := false;
  FPopupTime := 0;
  FPopupClickIndex := XYToItem(X, Y);
end;

procedure TAdvSmoothDock.DoMouseEnter(var Msg: TMessage);
var
  i: integer;
begin
  for I := 0 to Items.Count - 1 do
  begin
    Items[i].FHoverSizeToW := 0;
    Items[i].FHoverSizeToH := 0;
    Items[i].FDoItemAnimation := true;
  end;
  FHoveredItemIndex := -1;
  FDoPopup := false;
  FMouseEntered := true;
  Changed;
end;

procedure TAdvSmoothDock.DoMouseLeave(var Msg: TMessage);
var
  I: Integer;
begin
  if FDoPopup then
    Exit;

  for I := 0 to Items.Count - 1 do
  begin
    Items[i].FHoverSizeToW := 0;
    Items[i].FHoverSizeToH := 0;
    Items[i].FDoItemAnimation := true;
  end;

  FArrowLeftDown := false;
  FArrowLeftHover := false;
  FArrowRightHover := false;
  FArrowRightDown := false;
  FHintX := -1;
  FHintY := -1;
  FHoveredItemIndex := -1;
  FTimeDownOnArrow := 0;
  Changed;
end;

procedure TAdvSmoothDock.DoMouseMove(Shift: TShiftState; X, Y: Integer);
var
  hi: integer;
  I: Integer;
begin

  FPrevX := X;
  FPrevY := Y;

  if IsMouseOnArrow(X, Y) then
  begin
    if not FMouseOnArrow then
    begin
      FArrowLeftHover := PtInGPRect(GetArrowLeft, Point(x, y));
      FArrowRightHover := PtInGPRect(GetArrowRight, Point(x, Y));

      FMouseOnArrow := true;
      if FDoPopup then
        Exit;

      for I := 0 to Items.Count - 1 do
      begin
        Items[i].FHoverSizeToW := 0;
        Items[i].FHoverSizeToH := 0;
        Items[i].FDoItemAnimation := true;
      end;
      FHintX := -1;
      FHintY := -1;
      FHoveredItemIndex := -1;
      Changed;
      Exit;
    end
    else
      Exit;
  end
  else
  begin
    FMouseOnArrow := false;
    FArrowLeftHover := false;
    FArrowRightHover := false;
  end;

  if IsMoving(X, Y) then
    FPopupTime := 0;

//  if FDoPopup then
//    Exit;

  if FMouseDown then
  begin
    FDragX := X;
    FDragY := Y;
  end;

  if FMouseDown and IsMoving(X, Y) then
    DoDrag(X, Y, FMouseCopy)
  else
  begin
    FDblClick := false;
    FMouseEntered := false;
  end;

  FHintX := X;
  FHintY := Y;

  Application.CancelHint;
  if IsItemBounds(X, Y) then
  begin
    hi := XYToItem(X, Y);
    if hi <> -1 then
      if Assigned(FOnItemHover) then
        FOnItemHover(Self, hi);

    if hi <> FHoveredItemIndex then
    begin
      FHoveredItemIndex := hi;
      if ItemAppearance.AnimationSpan = 0 then
        Changed;
    end;
  end;
end;

procedure TAdvSmoothDock.DoMouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  item: integer;
begin
  FTimeDownOnArrow := 0;
  if IsMouseOnArrow(X, Y) then
  begin
    if FArrowRightDown then
      DoArrowRightDown;

    if FArrowLeftDown then
      DoArrowLeftDown;

    FArrowLeftDown := false;
    FArrowRightDown := false;
    Changed;

    Exit;
  end;

  FArrowLeftDown := false;
  FArrowRightDown := false;
  Changed;

  FFocused := true;

  FMouseCopy := false;
  FMouseDown := false;
  FPopupTime := 0;
  FStartPopupTimer := false;
  FDoPopup := false;

  if FDragDropItem = nil then
  begin
    item := XYToItem(X, Y);
    if item <> -1 then
    begin
      SelectedItemIndex := item;
      if Assigned(FOnItemSelected) then
        FOnItemSelected(Self, SelectedItemIndex);
      if Assigned(FOnItemClick) then
        FOnItemClick(Self, SelectedItemIndex);
    end;
  end
  else
    DoDrop(X, Y);

end;

procedure TAdvSmoothDock.Notification(AComponent: TComponent;
  AOperation: TOperation);
var
  I: Integer;
begin
  inherited;

  if (csDestroying in ComponentState) then
    Exit;

  if (AOperation = opRemove) then
  begin
    for I := 0 to Items.Count - 1 do
    begin
      with Items[i] do
      begin
        if (AComponent = FPopupMenu) then
          FPopupMenu := nil;
      end;
    end;
  end;
end;

procedure TAdvSmoothDock.Paint;
var
  g: TGPGraphics;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  g.SetTextRenderingHint(TextRenderingHintAntiAlias);
  DrawBackGround(g, true);
  if Assigned(frm) then
  begin
    g.Free;
    Exit;
  end;

  DrawPlatForm(g);
  Drawitems(g);
  DrawArrows(g);
  DrawIndicator(g, SelectedItemIndex);
  DrawCaption(g);
  g.Free;
end;

function TAdvSmoothDock.PtInGPRect(r: TGPRectF; pt: TPoint): Boolean;
begin
  result := ((pt.X >= r.X) and (pt.X <= r.X + r.Width)) and
     ((pt.Y >= r.Y) and (pt.Y <= r.Y + r.Height));
end;

procedure TAdvSmoothDock.Resize;
begin
  if FResizeDisabled then
    Exit;

  UpdateBounds := true;
  UpdateSize;
  inherited;
end;

procedure TAdvSmoothDock.SetAnimationFactor(const Value: integer);
begin
  if FAnimationFactor <> Value then
  begin
    FAnimationFactor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetArrowAppearance(
  const Value: TAdvSmoothDockArrowAppearance);
begin
  if FArrowAppearance <> Value then
  begin
    FArrowAppearance.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetPlatForm3D(const Value: Boolean);
begin
  if FPlatForm3D <> Value then
  begin
    FPlatForm3D := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetPlatForm3DColor(const Value: TColor);
begin
  if FPlatForm3DColor <> value then
  begin
    FPlatForm3DColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetPlatForm3DColorTo(const Value: TColor);
begin
  if FPlatForm3DColorTo <> value then
  begin
    FPlatForm3DColorTo := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetPlatForm3DOpacity(const Value: Byte);
begin
  if FPlatForm3DOpacity <> value then
  begin
    FPlatForm3DOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetPlatForm3DOpacityTo(const Value: Byte);
begin
  if FPlatForm3DOpacityTo <> value then
  begin
    FPlatForm3DOpacityTo := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetComponentStyle(AStyle: TTMSStyle);
begin
  // TODO : do color settings here
 case AStyle of
    tsOffice2003Blue:
      begin
        Fill.Color := $00FFD2AF;
        Fill.ColorTo := $00FFD2AF;
        Fill.BorderColor := clNone;

        ItemAppearance.Fill.Color := $EEDBC8;
        ItemAppearance.Fill.ColorTo := $F6DDC9;
        ItemAppearance.Fill.ColorMirror := $EDD4C0;
        ItemAppearance.Fill.ColorMirrorTo := $F7E1D0;
        //ItemAppearance.Fill.BorderColor := $E0B99B;
        ItemAppearance.Fill.BorderColor := clNone;
        ItemAppearance.Fill.GradientMirrorType := gtVertical;

        ItemAppearance.HoverFill.Color := $EBFDFF;
        ItemAppearance.HoverFill.ColorTo := $ACECFF;
        ItemAppearance.HoverFill.ColorMirror := $59DAFF;
        ItemAppearance.HoverFill.ColorMirrorTo := $A4E9FF;
        ItemAppearance.HoverFill.BorderColor :=  $99CEDB;
        ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

        ItemAppearance.SelectedFill.Color := $AAD9FF;
        ItemAppearance.SelectedFill.ColorTo := $6EBBFF;
        ItemAppearance.SelectedFill.ColorMirror := $42AEFE;
        ItemAppearance.SelectedFill.ColorMirrorTo := $7AE1FE;
        ItemAppearance.SelectedFill.BorderColor := $42AEFE;
        ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

        ItemAppearance.DisabledFill.Color := $00F2F2F2;
        ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirror := clNone;
        ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
        ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Silver:
      begin
        Fill.Color := $00E6D8D8;
        Fill.ColorTo := $00E6D8D8;
        Fill.BorderColor := clNone;

        ItemAppearance.Fill.Color := $E6E9E2;
        ItemAppearance.Fill.ColorTo := $00E6D8D8;
        ItemAppearance.Fill.ColorMirror := $C8B2B3;
        ItemAppearance.Fill.ColorMirrorTo := $E6E9E2;
        ItemAppearance.Fill.BorderColor := clNone;
        ItemAppearance.Fill.GradientMirrorType := gtVertical;

        ItemAppearance.HoverFill.Color := $EBFDFF;
        ItemAppearance.HoverFill.ColorTo := $ACECFF;
        ItemAppearance.HoverFill.ColorMirror := $59DAFF;
        ItemAppearance.HoverFill.ColorMirrorTo := $A4E9FF;
        ItemAppearance.HoverFill.BorderColor :=  $99CEDB;
        ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

        ItemAppearance.DisabledFill.Color := $00F2F2F2;
        ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirror := clNone;
        ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
        ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

        ItemAppearance.SelectedFill.Color := $AAD9FF;
        ItemAppearance.SelectedFill.ColorTo := $6EBBFF;
        ItemAppearance.SelectedFill.ColorMirror := $42AEFE;
        ItemAppearance.SelectedFill.ColorMirrorTo := $7AE1FE;
        ItemAppearance.SelectedFill.BorderColor := $42AEFE;
        ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Olive:
      begin
        Fill.Color := RGB(225, 234, 185);
        Fill.ColorTo := RGB(225, 234, 185);
        Fill.BorderColor := clNone;

        ItemAppearance.Fill.Color := $CFF0EA;
        ItemAppearance.Fill.ColorTo := $CFF0EA;
        ItemAppearance.Fill.ColorMirror := $8CC0B1;
        ItemAppearance.Fill.ColorMirrorTo := $CFF0EA;
        ItemAppearance.Fill.BorderColor := clNone;
        ItemAppearance.Fill.GradientMirrorType := gtVertical;

        ItemAppearance.DisabledFill.Color := $00F2F2F2;
        ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirror := clNone;
        ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
        ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

        ItemAppearance.HoverFill.Color := $EBFDFF;
        ItemAppearance.HoverFill.ColorTo := $ACECFF;
        ItemAppearance.HoverFill.ColorMirror := $59DAFF;
        ItemAppearance.HoverFill.ColorMirrorTo := $A4E9FF;
        ItemAppearance.HoverFill.BorderColor :=  $99CEDB;
        ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

        ItemAppearance.SelectedFill.Color := $AAD9FF;
        ItemAppearance.SelectedFill.ColorTo := $6EBBFF;
        ItemAppearance.SelectedFill.ColorMirror := $42AEFE;
        ItemAppearance.SelectedFill.ColorMirrorTo := $7AE1FE;
        ItemAppearance.SelectedFill.BorderColor := $42AEFE;
        ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Classic:
      begin
        Fill.Color := $00F2F2F2;
        Fill.ColorTo := $00F2F2F2;
        Fill.BorderColor := clNone;

        ItemAppearance.Fill.Color := clWhite;
        ItemAppearance.Fill.ColorTo := $C9D1D5;
        ItemAppearance.Fill.ColorMirror := clNone;
        ItemAppearance.Fill.ColorMirrorTo := clNone;
        ItemAppearance.Fill.BorderColor := clNone;
        ItemAppearance.Fill.GradientMirrorType := gtVertical;

        ItemAppearance.HoverFill.Color := $D2BDB6;
        ItemAppearance.HoverFill.ColorTo := $D2BDB6;
        ItemAppearance.HoverFill.ColorMirror := clNone;
        ItemAppearance.HoverFill.ColorMirrorTo := clNone;
        ItemAppearance.HoverFill.BorderColor := $808080;
        ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

        ItemAppearance.DisabledFill.Color := $D8D5D4;
        ItemAppearance.DisabledFill.ColorTo := $D8D5D4;
        ItemAppearance.DisabledFill.ColorMirror := clNone;
        ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
        ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

        ItemAppearance.SelectedFill.Color := $B59285;
        ItemAppearance.SelectedFill.ColorTo := $B59285;
        ItemAppearance.SelectedFill.ColorMirror := clNone;
        ItemAppearance.SelectedFill.ColorMirrorTo := clNone;
        ItemAppearance.SelectedFill.BorderColor := $808080;
        ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;
      end;
    tsOffice2007Luna:
      begin
        Fill.Color := $00F3E5DA;
        Fill.ColorTo := $00F0DED0;
        Fill.BorderColor := clNone;

        ItemAppearance.Fill.Color := $FFEFE3;
        ItemAppearance.Fill.ColorTo := $FFDDC4;
        ItemAppearance.Fill.ColorMirror := $FFD1AD;
        ItemAppearance.Fill.ColorMirrorTo := $FFDBC0;
        ItemAppearance.Fill.BorderColor := clNone;
        ItemAppearance.Fill.GradientMirrorType := gtVertical;

        ItemAppearance.HoverFill.Color := $EBFDFF;
        ItemAppearance.HoverFill.ColorTo := $ACECFF;
        ItemAppearance.HoverFill.ColorMirror := $59DAFF;
        ItemAppearance.HoverFill.ColorMirrorTo := $A4E9FF;
        ItemAppearance.HoverFill.BorderColor :=  $99CEDB;
        ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

        ItemAppearance.DisabledFill.Color := $00F2F2F2;
        ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirror := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirrorTo := $00F2F2F2;
        ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

        ItemAppearance.SelectedFill.Color := $AAD9FF;
        ItemAppearance.SelectedFill.ColorTo := $6EBBFF;
        ItemAppearance.SelectedFill.ColorMirror := $42AEFE;
        ItemAppearance.SelectedFill.ColorMirrorTo := $7AE1FE;
        ItemAppearance.SelectedFill.BorderColor := $42AEFE;
        ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

      end;
    tsOffice2007Obsidian:
      begin
        Fill.Color := $5C534C;
        Fill.ColorTo := $5C534C;
        Fill.BorderColor := clNone;

        ItemAppearance.Fill.Color := $F9F8F8;
        ItemAppearance.Fill.ColorTo := $E4E2DF;
        ItemAppearance.Fill.ColorMirror := $D1CBC7;
        ItemAppearance.Fill.ColorMirrorTo := $E2DEDB;
        ItemAppearance.Fill.BorderColor := clNone;
        ItemAppearance.Fill.GradientMirrorType := gtVertical;

        ItemAppearance.HoverFill.Color := $EBFDFF;
        ItemAppearance.HoverFill.ColorTo := $ACECFF;
        ItemAppearance.HoverFill.ColorMirror := $59DAFF;
        ItemAppearance.HoverFill.ColorMirrorTo := $A4E9FF;
        ItemAppearance.HoverFill.BorderColor :=  $99CEDB;
        ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

        ItemAppearance.DisabledFill.Color := $00F2F2F2;
        ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirror := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirrorTo := $00F2F2F2;
        ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

        ItemAppearance.SelectedFill.Color := $AAD9FF;
        ItemAppearance.SelectedFill.ColorTo := $6EBBFF;
        ItemAppearance.SelectedFill.ColorMirror := $42AEFE;
        ItemAppearance.SelectedFill.ColorMirrorTo := $7AE1FE;
        ItemAppearance.SelectedFill.BorderColor := $42AEFE;
        ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;
      end;
    tsWindowsXP:
      begin
        Fill.Color := $00B6B6B6;
        Fill.ColorTo := $00B6B6B6;

        ItemAppearance.Fill.Color := clBtnFace;//clWhite;
        ItemAppearance.Fill.ColorTo := clBtnFace;//$B9D8DC;
        ItemAppearance.Fill.ColorMirror := clNone;
        ItemAppearance.Fill.ColorMirrorTo := clNone;
        ItemAppearance.Fill.BorderColor := clNone;
        ItemAppearance.Fill.GradientMirrorType := gtVertical;

        ItemAppearance.DisabledFill.Color := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirror := clNone;
        ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
        ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

        ItemAppearance.HoverFill.Color := $EFD3C6;
        ItemAppearance.HoverFill.ColorTo := $EFD3C6;
        ItemAppearance.HoverFill.ColorMirror := clNone;
        ItemAppearance.HoverFill.ColorMirrorTo := clNone;
        ItemAppearance.HoverFill.BorderColor :=  clHighlight;
        ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

        ItemAppearance.SelectedFill.Color := clInactiveCaption;
        ItemAppearance.SelectedFill.ColorTo := clInactiveCaption;
        ItemAppearance.SelectedFill.ColorMirror := clNone;
        ItemAppearance.SelectedFill.ColorMirrorTo := clNone;
        ItemAppearance.SelectedFill.BorderColor := clHighLight;
        ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;
      end;
    tsWhidbey:
      begin
        Fill.Color := $F5F9FA;
        Fill.ColorTo := $F5F9FA;
        Fill.BorderColor := clNone;

        ItemAppearance.Fill.Color := clWhite;
        ItemAppearance.Fill.ColorTo := $DFEDF0;
        ItemAppearance.Fill.ColorMirror := $DFEDF0;
        ItemAppearance.Fill.ColorMirrorTo := $DFEDF0;
        ItemAppearance.Fill.BorderColor := clNone;
        ItemAppearance.Fill.GradientMirrorType := gtVertical;

        ItemAppearance.DisabledFill.Color := $00F2F2F2;
        ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirror := clNone;
        ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
        ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

        ItemAppearance.HoverFill.Color := $EBFDFF;
        ItemAppearance.HoverFill.ColorTo := $ACECFF;
        ItemAppearance.HoverFill.ColorMirror := $59DAFF;
        ItemAppearance.HoverFill.ColorMirrorTo := $A4E9FF;
        ItemAppearance.HoverFill.BorderColor :=  $99CEDB;
        ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

        ItemAppearance.SelectedFill.Color := $AAD9FF;
        ItemAppearance.SelectedFill.ColorTo := $6EBBFF;
        ItemAppearance.SelectedFill.ColorMirror := $42AEFE;
        ItemAppearance.SelectedFill.ColorMirrorTo := $7AE1FE;
        ItemAppearance.SelectedFill.BorderColor := $42AEFE;
        ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;
   end;
    tsCustom: ;
    tsOffice2007Silver:
      begin
        Fill.Color := RGB(241, 244, 248);
        Fill.ColorTo := RGB(227, 232, 240);
        Fill.BorderColor := clNone;

        ItemAppearance.Fill.Color := $F9F8F8;
        ItemAppearance.Fill.ColorTo := $E4E2DF;
        ItemAppearance.Fill.ColorMirror := $D1CBC7;
        ItemAppearance.Fill.ColorMirrorTo := $E2DEDB;
        ItemAppearance.Fill.BorderColor := clNone;
        ItemAppearance.Fill.GradientMirrorType := gtVertical;

        ItemAppearance.HoverFill.Color := $EBFDFF;
        ItemAppearance.HoverFill.ColorTo := $ACECFF;
        ItemAppearance.HoverFill.ColorMirror := $59DAFF;
        ItemAppearance.HoverFill.ColorMirrorTo := $A4E9FF;
        ItemAppearance.HoverFill.BorderColor :=  $99CEDB;
        ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

        ItemAppearance.SelectedFill.Color := $AAD9FF;
        ItemAppearance.SelectedFill.ColorTo := $6EBBFF;
        ItemAppearance.SelectedFill.ColorMirror := $42AEFE;
        ItemAppearance.SelectedFill.ColorMirrorTo := $7AE1FE;
        ItemAppearance.SelectedFill.BorderColor := $42AEFE;
        ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

        ItemAppearance.DisabledFill.Color := $00F2F2F2;
        ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirror := $00B6B6B6;
        ItemAppearance.DisabledFill.ColorMirrorTo := $00F2F2F2;
        ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;
      end;
  end;
end;

procedure TAdvSmoothDock.SetDockOnDesktop(const Value: Boolean);
begin
  if FDockOnDeskTop <> value then
  begin
    FDockOnDeskTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetDockVisible(const Value: Boolean);
begin
  if FDockVisible <> value then
  begin
    FDockVisible := Value;
    if Assigned(frm) then
      frm.Visible := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothDock.SetShowFocus(const Value: Boolean);
begin
  if FFocus <> value then
  begin
    FFocus := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetItemAppearance(
  const Value: TAdvSmoothDockItemAppearance);
begin
  if FItemAppearance <> Value then
  begin
    FItemAppearance.Assign(value);
    ItemAppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothDock.SetItems(const Value: TAdvSmoothDockItems);
begin
  if FItems <> value then
  begin
    FItems.Assign(Value);
    ItemsChanged(Self);
  end;
end;

procedure TAdvSmoothDock.SetOleDragDrop(const Value: Boolean);
begin
  FOleDragDrop := Value;

  if not (csDesigning in ComponentState) and Assigned(frm) then
  begin
    if FOleDragDrop then
    begin
      FDockDropTarget := TAdvSmoothDockDropTarget.Create(Self);
      FOleDropTargetAssigned := RegisterDragDrop(frm.Handle, FDockDropTarget) = S_OK;
    end
    else if FOleDropTargetAssigned then RevokeDragDrop(frm.Handle);
  end;
end;

procedure TAdvSmoothDock.SetPlatformFill(const Value: TGDIPFill);
begin
  if FPlatformFill <> value then
  begin
    FPlatformFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetPlatformSize(const Value: integer);
begin
  if FPlatformSize <> Value then
  begin
    FPlatformSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetPosition(const Value: TAdvSmoothDockPosition);
var
  I: Integer;
  b: TAdvSmoothDockBounds;
begin
  if FPosition <> value then
  begin
    if Assigned(frm) then
      frm.FMouseEntered := false;

    FCurrentPos := 0;
    FPosTo := 0;

    FPosition := Value;
    UpdateBounds := true;


    ItemAppearance.SeparatorChanged(Self);
    b := GetBounds;
    for I := b.Start to b.Stop do
      Items[i].UpdateReflection;

    UpdateBounds := true;
    UpdateSize;

    if FUpdateCount = 0 then
      Invalidate;

    if (csDestroying in ComponentState) then
      Exit;

    if Assigned(frm) then
      frm.Invalidate;
  end;
end;

procedure TAdvSmoothDock.SetSelectedItemIndex(const Value: integer);
begin
  if FSelectedItemIndex <> value then
  begin
    FSelectedItemIndex := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> value then
  begin
    FTransparent := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDock.ShowForm;
begin
  frm := TAdvSmoothDockForm.CreateNew(Application);
  frm.OwnerDock := Self;
  frm.Height := GetMaximumHeight;
  frm.Width := self.Width;
  frm.Init;
  frm.Show;
  frm.SetBounds(Self.Parent.ClientOrigin.X + Self.Left , Self.Parent.ClientOrigin.Y + Self.Top , frm.Width, frm.Height);
  SetOleDragDrop(FOleDragDrop);
end;

procedure TAdvSmoothDock.UpdateSize;
var
  h, dif: integer;
begin
  FResizeDisabled := true;
  if not UpdateBounds then
  begin
    if Assigned(frm) and not (csDestroying in ComponentState) then
    begin
      case Position of
        dpLeft:
        begin
          frm.Left := Parent.ClientOrigin.X + Self.Left;
          frm.Top := Parent.ClientOrigin.Y + Self.Top;
        end;
        dpRight:
        begin
          frm.Left := Parent.ClientOrigin.X + Self.Left - (GetMaximumWidth - GetMinimumWidth);
          frm.Top := Parent.ClientOrigin.Y + Self.Top;
        end;
        dpTop:
        begin
          frm.Left := Parent.ClientOrigin.X + Self.Left;
          frm.Top := Parent.ClientOrigin.Y + Self.Top;
        end;
        dpBottom:
        begin
          frm.Left := Parent.ClientOrigin.X + Self.Left;
          frm.Top := Parent.ClientOrigin.Y + Self.Top - (GetMaximumHeight - GetMinimumHeight);
        end;
      end;
    end;
  end
  else
  begin
    Updatebounds := false;
    case Position of
      dpRight:
      begin
        Self.Width := GetMinimumWidth;
        h := GetMaximumWidth;
        dif := h - Self.Width;
        if Assigned(frm) and not (csDestroying in ComponentState) then
          frm.SetBounds(Parent.ClientOrigin.X + Self.Left - dif , Parent.ClientOrigin.Y + Self.Top, h, Self.Height)
      end;
      dpLeft:
      begin
        Self.Width := GetMinimumWidth;
        h := GetMaximumWidth;
        if Assigned(frm) and not (csDestroying in ComponentState) then
            frm.SetBounds(Parent.ClientOrigin.X + Self.Left , Parent.ClientOrigin.Y + Self.Top, h, Self.Height);
      end;
      dpTop:
      begin
        Self.Height := GetMinimumHeight;
        h := GetMaximumHeight;
        if Assigned(frm) and not (csDestroying in ComponentState) then
          frm.SetBounds(Parent.ClientOrigin.X + Self.Left , Parent.ClientOrigin.Y + Self.Top , Self.Width, h);
      end;
      dpBottom:
      begin
        Self.Height := GetMinimumHeight;
        h := GetMaximumHeight;
        dif := h - Self.Height;
        if Assigned(frm) and not (csDestroying in ComponentState) then
          frm.SetBounds(Parent.ClientOrigin.X + Self.Left , Parent.ClientOrigin.Y + Self.Top - dif , Self.Width, h);
      end;
    end;
    FResizeDisabled := false;
  end;
end;

procedure TAdvSmoothDock.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TAdvSmoothDock.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.Result := 0;
end;

procedure TAdvSmoothDock.WMPaint(var Message: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  {$IFNDEF DELPHI_UNICODE}
  dbl: boolean;
  {$ENDIF}
  p: TPoint;
  i: integer;
begin
  if Assigned(Parent) {and (Fill.ShadowOffset > 0) ?} then
  begin
    {$IFNDEF DELPHI_UNICODE}
    dbl := Parent.DoubleBuffered;
    Parent.DoubleBuffered := false;
    {$ENDIF}
    DC := Message.DC;
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
    RestoreDC(DC, i);
    {$IFNDEF DELPHI_UNICODE}
    Parent.DoubleBuffered := dbl;
    {$ENDIF}
  end;

  if not FDoubleBuffered or (Message.DC <> 0) then
  begin
    if not (csCustomPaint in ControlState) and (ControlCount = 0) then
      inherited
    else
      PaintHandler(Message);
  end
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      Perform(WM_ERASEBKGND, MemDC, MemDC);
      Message.DC := MemDC;
      WMPaint(Message);
      Message.DC := 0;
      BitBlt(DC, 0, 0, ClientRect.Right, ClientRect.Bottom, MemDC, 0, 0, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

function TAdvSmoothDock.XYToItem(X, Y: integer; CountSeparator: Boolean = false; DragDrop: Boolean = false): integer;
var
  I: Integer;
  r: TGPRectF;
  spc: integer;
  chk: Boolean;
  b: TAdvSmoothDockBounds;
begin
  result := -1;
  spc := ItemAppearance.Spacing div 2;
  b := GetBounds;
  for I := b.Start to b.Stop do
  begin
    if Items[i].Visible then
    begin
      if Items[I] <> FDragDropItem then
      begin
        if not (Items[i].Separator and not CountSeparator) and Items[I].Enabled then
        begin
          r := Items[I].GetItemRect;
          case Position of
            dpLeft, dpRight:
            begin
              r.y := r.Y - spc;
              r.Height := r.Height + spc;
            end;
            dpTop, dpBottom:
            begin
              r.X := r.X - spc;
              r.Width := r.Width + spc;
            end;
          end;
          if PtInRect(Bounds(Round(r.X), Round(r.Y), Round(r.Width), Round(r.Height)), Point(X, Y)) then
          begin
            if DragDrop and (FDragDropItem <> nil) then
            begin
              chk := false;
              case Position of
                dpLeft, dpRight:
                begin
                  if FDragY > r.Y then
                    chk := FDragY > r.Y + (R.Height / 2)
                  else if FDragY > r.Y + R.Height then
                    chk := FDragY < r.Y + (R.Height / 2);
                end;
                dpTop, dpBottom:
                begin
                  if FDragX > r.X then
                    chk := FDragX > r.X + (R.Width / 2)
                  else if FDragX > r.X + R.Width then
                    chk := FDragX < r.X + (R.Width / 2);
                end;
              end;

              if chk then
              begin
                Result := I;
                break;
              end;
            end
            else
            begin
              Result := I;
              break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{ TAdvSmoothDockItems }

function TAdvSmoothDockItems.Add: TAdvSmoothDockItem;
begin
  Result := TAdvSmoothDockItem(inherited Add);
end;

constructor TAdvSmoothDockItems.Create(AOwner: TAdvSmoothDock);
begin
  inherited Create(TAdvSmoothDockItem);
  FOwner := AOwner;
end;

procedure TAdvSmoothDockItems.Delete(Index: Integer);
begin
  Items[index].Free;
end;

function TAdvSmoothDockItems.GetItem(Index: Integer): TAdvSmoothDockItem;
begin
  Result := TAdvSmoothDockItem(inherited Items[index]);
end;

function TAdvSmoothDockItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TAdvSmoothDockItems.Insert(Index: Integer): TAdvSmoothDockItem;
begin
  Result := TAdvSmoothDockItem(inherited Insert(Index));
end;

procedure TAdvSmoothDockItems.SetItem(Index: Integer;
  const Value: TAdvSmoothDockItem);
begin
  inherited Items[Index] := Value;
end;

{ TAdvSmoothDockItem }

procedure TAdvSmoothDockItem.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothDockItem) then
  begin
    FImage.Assign((Source as TAdvSmoothDockItem).Image);
    FCaption := (Source as TAdvSmoothDockItem).Caption;
    FVisible := (Source as TAdvSmoothDockItem).Visible;
    FEnabled := (Source as TAdvSmoothDockItem).Enabled;
    FHint := (Source as TAdvSmoothDockItem).Hint;
    FJump := (Source as TAdvSmoothDockItem).Jump;
    FStatusIndicator.Assign((Source as TAdvSmoothDockItem).StatusIndicator);
    FSeparator := (Source as TAdvSmoothDockItem).Separator;
    FShowCaption := (Source as TAdvSmoothDockItem).ShowCaption;
    FProgressMaximum := (Source as TAdvSmoothDockItem).ProgressMaximum;
    FProgressMinimum := (Source as TAdvSmoothDockItem).ProgressMinimum;
    FProgressPosition := (Source as TAdvSmoothDockItem).ProgressPosition;
    FData := (Source as TAdvSmoothDockItem).Data;
    FTag := (Source as TAdvSmoothDockItem).Tag;
    FPopupMenu := (Source as TAdvSmoothDockItem).PopupMenu;
    FObject := (Source as TAdvSmoothDockItem).ItemObject;
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothDockItem.Create(Collection: TCollection);
begin
  inherited;
  FOwner := (Collection as TAdvSmoothDockItems).FOwner;
  FImage := TAdvGDIPPicture.Create;
  FImage.OnChange := ImageChanged;
  FVisible := true;
  FEnabled := true;
  FReflectionImage := nil;
  FJump := false;
  FJumpUp := true;
  FStatusIndicator := TAdvSmoothDockStatus.Create(FOwner);
  FStatusIndicator.OnChange := StatusIndicatorChanged;
  FSeparator := false;
  FShowCaption := true;
  FProgressMaximum := 100;
  FProgressMinimum := 0;
  FProgressPosition := 0;
  Changed;
end;

destructor TAdvSmoothDockItem.Destroy;
begin
  FImage.Free;
  FStatusIndicator.Free;
  if Assigned(FReflectionImage) then
    FReflectionImage.Free;
  inherited;
  Changed;
end;

function TAdvSmoothDockItem.GetHoverRect: TGPRectF;
var
  x, w: Single;
  hsh, hsw: Double;
begin
  hsh := FHoverSizeH;
  hsw := FHoverSizeW;
  if Separator then
  begin
    case FOwner.Position of
      dpRight, dpLeft: hsw := 0;
      dpBottom, dpTop: hsh := 0;
    end;
  end;
  with FOwner.ItemAppearance do
  begin
    case FOwner.Position of
      dpLeft:
      begin
        w := ImageHeight;
        x := ((Index + 1) * Spacing) + (Index * w);
        Result := MakeRect((FOwner.InsideRect.Left + FImageOffset),x, ImageWidth, w);
        Result.X := Result.X;
        Result.Y := Result.Y;
        Result.Width := Result.Width + hsh;
        Result.Height := Result.Height + hsw;
        Result.X := Result.X + FJMP;
      end;
      dpRight:
      begin
        w := ImageHeight;
        x := ((Index + 1) * Spacing) + (Index * w);
        Result := MakeRect((FOwner.InsideRect.Right - FImageOffset - ImageWidth),x, ImageWidth, w);
        Result.X := Result.X - hsh;
        Result.Y := Result.Y;
        Result.Width := Result.Width + hsh;
        Result.Height := Result.Height + hsw;
        Result.X := Result.X - FJMP;
      end;
      dpTop:
      begin
        w := ImageWidth;
        x := ((Index + 1) * Spacing) + (Index * w);
        Result := MakeRect(x, (FOwner.InsideRect.Top + FImageOffset), w, ImageHeight);
        Result.X := Result.X;
        Result.Y := Result.Y;
        Result.Width := Result.Width + hsw;
        Result.Height := Result.Height + hsh;
        Result.Y := Result.Y + FJMP;
      end;
      dpBottom:
      begin
        w := ImageWidth;
        x := ((Index + 1) * Spacing) + (Index * w);
        Result := MakeRect(x, (FOwner.InsideRect.Bottom - FImageOffset - ImageHeight), w, ImageHeight);
        Result.X := Result.X;
        Result.Y := Result.Y - hsh;
        Result.Width := Result.Width + hsw;
        Result.Height := Result.Height + hsh;
        Result.Y := Result.Y - FJMP;
      end;
    end;
  end;
end;

function TAdvSmoothDockItem.GetItemRectCenter: TGPRectF;
var
  prevr: TGPRectF;
begin
  with FOwner.ItemAppearance do
  begin
    if Visible then
    begin
      if (Index > 0) then
      begin
        prevr := FOwner.Items[Index - 1].FItemRect;
        result := GetHoverRect;
        case FOwner.Position of
          dpRight, dpLeft: result.Y := prevr.Y + prevr.Height + Spacing;
          dpTop, dpBottom: result.X := prevr.X + prevr.Width + Spacing;
        end;
        FitemRect := Result;
      end
      else
      begin
        result := GetHoverRect;
        FItemRect := Result;
      end;
    end
    else if Index > 0 then
      result := FOwner.Items[Index - 1].FItemRect;
  end;
end;

function TAdvSmoothDockItem.GetItemRect: TGPRectF;
var
  total: Double;
  r: TGPRectF;
begin
  total := FOwner.GetTotalSize;
  r := GetItemRectCenter;
  case FOwner.Position of
    dpRight, dpLeft:
    begin
      if not (FOwner.GetItemsRectangle.Height > (FOwner.InsideRect.Bottom - FOwner.InsideRect.Top) + FOwner.ItemAppearance.ImageHeight) then
      begin
        FOwner.FCurrentPos := 0;
        FOwner.FPosTo := 0;
      end;
      Result := MakeRect(r.X, r.Y - FOwner.FCurrentPos + (FOwner.GetHeight - total) / 2,
        r.Width, r.Height)
    end;
    dpTop, dpBottom:
    begin
      if not (FOwner.GetItemsRectangle.Width > (FOwner.InsideRect.Right - FOwner.InsideRect.Left) + FOwner.ItemAppearance.ImageWidth) then
      begin
        FOwner.FCurrentPos := 0;
        FOwner.FPosTo := 0;
      end;
      Result := MakeRect(r.X - FOwner.FCurrentPos + (FOwner.GetWidth - total) / 2, r.Y,
        r.Width, r.Height)
    end;
  end;
end;

function TAdvSmoothDockItem.GetNormalRect: TGPRectF;
var
  x, w: Single;
begin
  with FOwner.ItemAppearance do
  begin
    w := ImageWidth;
    x := ((Index + 1) * Spacing) + (Index * w);
    Result := MakeRect(x, (FOwner.InsideRect.Bottom - FImageOffset), w, ImageHeight);
    Result.X := Result.X;
    Result.Y := Result.Y;
    Result.Width := Result.Width;
    Result.Height := Result.Height;
  end;
end;

procedure TAdvSmoothDockItem.ImageChanged(Sender: TObject);
begin
  UpdateReflection;
  Changed;
end;

procedure TAdvSmoothDockItem.Popup(Sender: TObject);
begin
  if FOwner.FDoPopup then
    FOwner.FDoPopup := false;
end;

procedure TAdvSmoothDockItem.SetCaption(const Value: String);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.SetHint(const Value: String);
begin
  if FHint <> value then
  begin
    FHint := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.SetImage(const Value: TAdvGDIPPicture);
begin
  if FImage <> value then
  begin
    FImage.Assign(Value);
    ImageChanged(Self);
  end;
end;

procedure TAdvSmoothDockItem.SetJump(const Value: Boolean);
begin
  if FJump <> Value then
  begin
    FJump := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.SetProgressMaximum(const Value: integer);
begin
  if FProgressMaximum <> value then
  begin
    FProgressMaximum := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.SetProgressMinimum(const Value: integer);
begin
  if FProgressMinimum <> Value then
  begin
    FProgressMinimum := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.SetProgressPosition(const Value: integer);
begin
  if FProgressPosition <> value then
  begin
    FProgressPosition := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.SetSeparator(const Value: Boolean);
begin
  if FSeparator <> value then
  begin
    FSeparator := Value;
    if Value then
      Self.Image.LoadFromStream(FOwner.FSeparatorMemoryStream)
    else
      Self.Image.Assign(nil);
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.SetShowCaption(const Value: Boolean);
begin
  if FShowCaption <> value then
  begin
    FShowCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.SetStatusIndicator(const Value: TAdvSmoothDockStatus);
begin
  if FStatusIndicator <> value then
  begin
    FStatusIndicator.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItem.StatusIndicatorChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothDockItem.UpdateReflection;
var
  gpbmp: TGPBitmap;
  pstm: IStream;
  hGlobal: THandle;
  pcbWrite: Longint;
  ms: TMemoryStream;
  w, h, x, y, op, alph: integer;
  clr, clrTemp: TGPColor;
  a: byte;
  s: Double;
begin
  if Image.Empty {or (csLoading in FOwner.ComponentState)} then
    Exit;

  with FOwner.ItemAppearance do
  begin
    Image.GetImageSizes;

    w := Image.Width;
    h := Image.Height;

    s := FReflectionSize;

    ms := TMemoryStream.Create;
    Image.SaveToStream(ms);
    hGlobal := GlobalAlloc(GMEM_MOVEABLE, ms.Size);
    if (hGlobal = 0) then
    begin
      ms.Free;
      raise Exception.Create('Could not allocate memory for reflection image');
    end;

    try
      pstm := nil;

      // Create IStream* from global memory
      CreateStreamOnHGlobal(hGlobal, TRUE, pstm);
      pstm.Write(ms.Memory, ms.Size,@pcbWrite);

      gpbmp := TGPBitmap.Create(pstm);

      if Assigned(FReflectionImage) then
      begin
        FReflectionImage.Free;
        FReflectionImage := nil;
      end;

      FReflectionImage := TGPBitmap.Create(w, h{, PixelFormat32bppARGB});

      for y := 0 to h do
      begin
        if (y < FReflectionSize) then
        begin
          op := Round( ((s - y)/FReflectionSize * FReflectionStart) +
                         y/s * FReflectionEnd);
        end
        else
          op := 0;

        if (op < 0) then
          op := 0;
        if (op > 255) then
          op := 255;

        for x := 0 to w do
        begin
          case FOwner.Position of
            dpLeft: gpbmp.GetPixel(y, w - x, clr);
            dpRight: gpbmp.GetPixel(h - y, w - x, clr);
            dpTop: gpbmp.GetPixel(x, y, clr);
            dpBottom: gpbmp.GetPixel(x, h - y, clr);
          end;
          a := GetAlpha(clr);
          if (a = 0) then
            continue;

          alph := Round((op / 255) * a);
          clrTemp := MakeColor(alph, GetRed(clr), GetGreen(clr), GetBlue(clr));
          case FOwner.Position of
            dpLeft: FReflectionImage.SetPixel(h - y, w - x, clrTemp);
            dpRight: FReflectionImage.SetPixel(y, w - x, clrTemp);
            dpTop: FReflectionImage.SetPixel(x, h - y, clrTemp);
            dpBottom: FReflectionImage.SetPixel(x, y, clrTemp);
          end;
        end;
      end;
      gpbmp.Free;
      ms.Free;
    finally
      GlobalFree(hGlobal);
    end;
  end;
end;

{ TAdvSmoothDockItemAppearance }

procedure TAdvSmoothDockItemAppearance.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothDockItemAppearance then
  begin
    FImageHeight := (Source as TAdvSmoothDockItemAppearance).ImageHeight;
    FImageWidth := (Source as TAdvSmoothDockItemAppearance).ImageWidth;
    FSpacing := (Source as TAdvSmoothDockItemAppearance).Spacing;
    FMaxImageWidth := (Source as TAdvSmoothDockItemAppearance).MaximumImageWidth;
    FMaxImageHeight := (Source as TAdvSmoothDockItemAppearance).MaximumImageHeight;
    FReflectionSize := (Source as TAdvSmoothDockItemAppearance).ReflectionSize;
    FReflectionStart := (Source as TAdvSmoothDockItemAppearance).ReflectionStart;
    FReflectionEnd := (Source as TAdvSmoothDockItemAppearance).ReflectionEnd;
    FReflectionSpacing := (Source as TAdvSmoothDockItemAppearance).ReflectionSpacing;
    FSelectionFill.Assign((Source as TAdvSmoothDockItemAppearance).SelectionFill);
    FCaptionFill.Assign((Source as TAdvSmoothDockItemAppearance).CaptionFill);
    FCaptionFont.Assign((Source as TAdvSmoothDockItemAppearance).CaptionFont);
    FSelectionSize := (Source as TAdvSmoothDockItemAppearance).SelectionSize;
    FSelectionOffset := (Source as TAdvSmoothDockItemAppearance).SelectionOffset;
    FFill.Assign((Source as TAdvSmoothDockItemAppearance).Fill);
    FHoverFill.Assign((Source as TAdvSmoothDockItemAppearance).HoverFill);
    FSelectedFill.Assign((Source as TAdvSmoothDockItemAppearance).SelectedFill);
    FDisabledFill.Assign((Source as TAdvSmoothDockItemAppearance).DisabledFill);
    FItemFill := (Source as TAdvSmoothDockItemAppearance).ItemBackGround;
    FSeparatorFill.Assign((Source as TAdvSmoothDockItemAppearance).SeparatorFill);
    FSeparatorSize := (Source as TAdvSmoothDockItemAppearance).SeparatorSize;
    FAspectRatio := (Source as TAdvSmoothDockItemAppearance).AspectRatio;
    FJumpMargin := (Source as TAdvSmoothDockItemAppearance).JumpMargin;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothDockItemAppearance.Create(AOwner: TAdvSmoothDock);
begin
  FOwner := AOwner;
  FAspectRatio := true;
  FImageWidth := 50;
  FImageHeight := 50;
  FSpacing := 15;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FMaxImageWidth := 120;
  FMaxImageHeight := 120;
  FBackGroundVisible := false;
  FReflectionStart := 100;
  FReflectionEnd := 0;
  FReflectionSize := 50;
  FReflectionSpacing := 0;
  FImageOffset := 40;
  FJumpMargin := 40;
  FAnimationSpan := 400;
  FSelectionFill := TGDIPFill.Create;
  FSelectionFill.OnChange := FillChanged;
  FCaptionFill := TGDIPFill.Create;
  FCaptionFill.OnChange := FillChanged;
  FCaptionFont := TFont.Create;
  FCaptionFont.OnChange := FontChanged;
  {$IFNDEF DELPHI9_LVL}
  FCaptionFont.Name := 'Tahoma';
  {$ENDIF}
  FSelectionSize := 20;
  FSelectionOffset := 10;
  FSelectedFill := TGDIPFill.Create;
  FSelectedFill.OnChange := FillChanged;
  FHoverFill := TGDIPFill.Create;
  FHoverFill.OnChange := FillChanged;
  FDisabledFill := TGDIPFill.Create;
  FDisabledFill.OnChange := FillChanged;
  FItemFill := false;
  FProgressFill := TGDIPFill.Create;
  FProgressFill.OnChange := FillChanged;
  FSeparatorFill := TGDIPFill.Create;
  FSeparatorFill.OnChange := SeparatorChanged;
  FSeparatorSize := 10;
end;

destructor TAdvSmoothDockItemAppearance.Destroy;
begin
  FSelectionFill.Free;
  FFill.Free;
  FHoverFill.Free;
  FSelectedFill.Free;
  FDisabledFill.Free;
  FCaptionFill.Free;
  FCaptionFont.Free;
  FProgressFill.Free;
  FSeparatorFill.Free;
  inherited;
end;

procedure TAdvSmoothDockItemAppearance.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothDockItemAppearance.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothDockItemAppearance.SeparatorChanged(Sender: TObject);
var
  sep: TGPGraphics;
  g: TGPGraphics;
  clsid: TGUID;
  I: integer;
begin
  with FOwner do
  begin
    g := TGPGraphics.Create(FOwner.Canvas.Handle);
    g.SetSmoothingMode(SmoothingModeAntiAlias);

    FSeparatorImage.Free;
    FSeparatorImage := nil;
    sep := nil;

    case Position of
      dpLeft, dpRight:
      begin
        FSeparatorImage := TGPBitmap.Create(ImageWidth, SeparatorSize);
        sep := g.FromImage(FSeparatorImage);
        FSeparatorFill.Fill(sep, MakeRect(0, 0, ImageWidth - 1, SeparatorSize - 1));
      end;
      dpTop, dpBottom:
      begin
        FSeparatorImage := TGPBitmap.Create(SeparatorSize, ImageHeight);
        sep := g.FromImage(FSeparatorImage);
        FSeparatorFill.Fill(sep, MakeRect(0, 0, SeparatorSize - 1, ImageHeight - 1));
      end;
    end;
    if sep <> nil then
      sep.Free;
    g.Free;

    clsid := GetCLSID(itPNG);
    FOwner.FSeparatorImage.Save(TStreamAdapter.Create(FSeparatorMemoryStream), clsid);
    FSeparatorMemoryStream.Position := 0;

    for I := 0 to Items.Count - 1 do
      with Items[i] do
        if Separator then
          Image.LoadFromStream(FSeparatorMemoryStream);


    Changed;

  end;
end;

procedure TAdvSmoothDockItemAppearance.SetAnimationSpan(const Value: integer);
begin
  if FAnimationSpan <> Value then
  begin
    FAnimationSpan := Value;
    FOwner.CalculateSin;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetAspectRatio(const Value: Boolean);
begin
  if FAspectRatio <> value then
  begin
    FAspectRatio := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetCaptionFill(const Value: TGDIPFill);
begin
  if FCaptionFill <> value then
  begin
    FCaptionFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetCaptionFont(const Value: TFont);
begin
  if FCaptionFont <> value then
  begin
    FCaptionFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetDisabledFill(const Value: TGDIPFill);
begin
  if FDisabledFill <> value then
  begin
    FDisabledFill := Value;
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetFill(const Value: TGDIPFill);
begin
  if FFill <> Value then
  begin
    FFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetHoverFill(const Value: TGDIPFill);
begin
  if FHoverFill <> value then
  begin
    FHoverFill.Assign(Value);
    FillChanged(self);
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetImageHeight(const Value: integer);
begin
  if FImageHeight <> value then
  begin
    FImageHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetImageOffset(const Value: integer);
begin
  if FImageOffset <> Value then
  begin
    FImageOffset := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetImageWidth(const Value: integer);
begin
  if FImageWidth <> value then
  begin
    FImageWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetItemFill(const Value: Boolean);
begin
  if FItemFill <> value then
  begin
    FItemFill := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetJumpMargin(const Value: integer);
begin
  if FJumpMargin <> Value then
  begin
    FJumpMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetMaxImageHeight(const Value: integer);
begin
  if FMaxImageHeight <> Value then
  begin
    FMaxImageHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetMaxImageWidth(const Value: integer);
begin
  if FMaxImageWidth <> Value then
  begin
    FMaxImageWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetProgressFill(const Value: TGDIPFill);
begin
  if FProgressFill <> value then
  begin
    FProgressFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetReflectionEnd(const Value: Byte);
var
  i: integer;
begin
  if FReflectionEnd <> value then
  begin
    FReflectionEnd := value;
    FOwner.BeginUpdate;
    for I := 0 to FOwner.Items.Count - 1 do
      FOwner.Items[I].UpdateReflection;

    FOwner.EndUpdate;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetReflectionSize(const Value: integer);
begin
  if FReflectionSize <> Value then
  begin
    FReflectionSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetReflectionSpacing(
  const Value: integer);
begin
  if FReflectionSpacing <> Value then
  begin
    FReflectionSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetReflectionStart(const Value: Byte);
var
  i: integer;
begin
  if FReflectionStart <> value then
  begin
    FReflectionStart := value;
    FOwner.BeginUpdate;
    for I := 0 to FOwner.Items.Count - 1 do
      FOwner.Items[I].UpdateReflection;

    FOwner.EndUpdate;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetSelectedFill(const Value: TGDIPFill);
begin
  if FSelectedFill <> value then
  begin
    FSelectedFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetSelectionFill(const Value: TGDIPFill);
begin
  if FSelectionFill <> value then
  begin
    FSelectionFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetSelectionOffset(const Value: integer);
begin
  if FSelectionOffset <> value then
  begin
    FSelectionOffset := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetSelectionSize(const Value: integer);
begin
  if FSelectionSize <> value then
  begin
    FSelectionSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetSeparatorFill(const Value: TGDIPFill);
begin
  if FSeparatorFill <> value then
  begin
    FSeparatorFill := Value;
    SeparatorChanged(Self);
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetSeparatorSize(const Value: integer);
begin
  if FSeparatorSize <> Value then
  begin
    FSeparatorSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockItemAppearance.SetSpacing(const Value: integer);
begin
  if FSpacing <> value then
  begin
    FSpacing := Value;
    Changed;
  end;
end;

{ TAdvSmoothDockStatus }

procedure TAdvSmoothDockStatus.AppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothDockStatus.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothDockStatus) then
  begin
    FAppearance.Assign((Source as TAdvSmoothDockStatus).Appearance);
    FOffsetTop := (Source as TAdvSmoothDockStatus).OffsetTop;
    FOffsetLeft := (Source as TAdvSmoothDockStatus).OffsetLeft;
    FVisible := (Source as TAdvSmoothDockStatus).Visible;
    FCaption := (Source as TAdvSmoothDockStatus).Caption;
  end;
end;

procedure TAdvSmoothDockStatus.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothDockStatus.Create(AOwner: TAdvSmoothDock);
begin
  FOwner := AOwner;
  FOffsetTop := 0;
  FOffsetLeft := 0;
  FVisible := False;
  FCaption := '0';
  FAppearance := TGDIPStatus.Create;
  FAppearance.OnChange := AppearanceChanged;
  if FOwner.FDesigntime then
  begin
    FAppearance.Fill.Color := clRed;
    FAppearance.Fill.GradientType := gtSolid;
    FAppearance.Fill.BorderColor := clGray;
    FAppearance.Font.Color := clWhite;
  end;
end;

destructor TAdvSmoothDockStatus.Destroy;
begin
  FAppearance.Free;
  inherited;
end;

procedure TAdvSmoothDockStatus.SetAppearance(const Value: TGDIPStatus);
begin
  if FAppearance <> value then
  begin
    FAppearance.Assign(Value);
    AppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothDockStatus.SetCaption(const Value: String);
begin
  if FCaption <> value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockStatus.SetOffsetLeft(const Value: integer);
begin
  if FOffsetLeft <> value then
  begin
    FOffsetLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockStatus.SetOffsetTop(const Value: integer);
begin
  if FOffsetTop <> value then
  begin
    FOffsetTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockStatus.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;


{ TGridDropTarget }

constructor TAdvSmoothDockDropTarget.Create(ADock: TAdvSmoothDock);
begin
  Inherited Create;
  FDock := ADock;
end;

procedure TAdvSmoothDockDropTarget.DragMouseLeave;
begin
  inherited;
end;

procedure TAdvSmoothDockDropTarget.DragMouseMove(pt: TPoint; var Allow: Boolean;
  DropFormats: TDropFormats);
begin
  inherited;
  pt := FDock.frm.ScreenToClient(pt);
  FDock.DoDragOver(nil, pt.X, pt.Y, dsDragMove, Allow);
end;

procedure TAdvSmoothDockDropTarget.DropCol(pt: TPoint; Col: Integer);
begin
  inherited;

end;

procedure TAdvSmoothDockDropTarget.DropFiles(pt: TPoint; files: tstrings);
begin
  inherited;
  pt := FDock.frm.ScreenToClient(pt);
  FDock.DoDragDrop(files, pt.X, pt.Y);
end;

procedure TAdvSmoothDockDropTarget.DropRTF(pt: TPoint; s: string);
begin
  inherited;

end;

procedure TAdvSmoothDockDropTarget.DropText(pt: TPoint; s: string);
begin
  inherited;

end;

procedure TAdvSmoothDockDropTarget.DropURL(pt: TPoint; s: string);
begin
  inherited;

end;

{ TAdvSmoothDockForm }

procedure TAdvSmoothDockForm.ClearBuffer(graphics: TGPGraphics);
var
  g: TGPGraphics;
begin
  g := graphics;
  if not Assigned(g) then
    g := CreateGraphics;
  g.Clear($00000000);
  if not Assigned(graphics) then
    g.Free;
end;

procedure TAdvSmoothDockForm.CMMouseEnter(var Msg: TMessage);
begin
  FMouseEntered := true;
  if Assigned(OwnerDock) then
  begin
    OwnerDock.DoMouseEnter(Msg);
    Self.Invalidate;
  end;
end;

procedure TAdvSmoothDockForm.CMMouseLeave(var Msg: TMessage);
begin
  FMouseEntered := false;
  if Assigned(OwnerDock) then
  begin
    OwnerDock.DoMouseLeave(Msg);
    Self.Invalidate;
  end;
end;

function TAdvSmoothDockForm.CreateGraphics: TGPGraphics;
begin
  Result := nil;
  if Assigned(FMainBuffer) then
    Result := TGPGraphics.Create(FMainBuffer);
end;

procedure TAdvSmoothDockForm.CreateMainBuffer;
begin
  if Assigned(FMainBuffer) then
    FMainBuffer.Free;

  FMainBuffer := TGPBitmap.Create(Width, Height, PixelFormat32bppARGB);
end;

constructor TAdvSmoothDockForm.CreateNew(AOwner: TComponent;
  Dummy: Integer);
begin
  inherited;
end;

procedure TAdvSmoothDockForm.CreateParams(var Params: TCreateParams);
begin
  inherited;

end;

procedure TAdvSmoothDockForm.CreateWnd;
begin
  inherited;

  if not FDock.DockOnDeskTop then
  begin
     { Hook parent }
    OldWndProc := TFarProc(GetWindowLong((Fdock.Owner as TForm).Handle, GWL_WNDPROC));
    {$IFDEF DELPHI9_LVL}
    NewWndProc := Classes.MakeObjectInstance(HookWndProc);
    {$ELSE}
    NewWndProc := MakeObjectInstance(HookWndProc);
    {$ENDIF}

    SetWindowLong((Fdock.Owner as TForm).Handle, GWL_WNDPROC, LongInt(NewWndProc));
  end;

  UpdateWindow;
end;

procedure TAdvSmoothDockForm.DblClick;
begin
  inherited;
  if Assigned(OwnerDock) then
    OwnerDock.DoDblClick;
end;

procedure TAdvSmoothDockForm.DestroyMainBuffer;
begin
  if Assigned(FMainBuffer) then
    FMainBuffer.Free;
end;

procedure TAdvSmoothDockForm.DoCreate;
begin
  inherited;
  FMainBuffer := nil;
end;

procedure TAdvSmoothDockForm.DoDestroy;
begin
  inherited;
  DestroyMainBuffer;
end;

procedure TAdvSmoothDockForm.DragDrop(Source: TObject; X, Y: Integer);
begin
  inherited;
  if Assigned(OwnerDock) then
    OwnerDock.DoDragDrop(Source, X, Y);
end;

procedure TAdvSmoothDockForm.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited;
  if Assigned(OwnerDock) then
    OwnerDock.DoDragOver(Source, X, Y, State, Accept);
end;

procedure TAdvSmoothDockForm.Draw(graphics: TGPGraphics);
var
  g: TGPGraphics;
begin
  g := graphics;
  if not Assigned(g) then
    g := CreateGraphics;

  g.SetSmoothingMode(SmoothingModeAntiAlias);
  g.SetTextRenderingHint(TextRenderingHintAntiAlias);

  if Assigned(OwnerDock) then
  begin
    OwnerDock.DrawBackGround(g, false);
    OwnerDock.DrawPlatForm(g);
    OwnerDock.Drawitems(g);
    OwnerDock.DrawArrows(g);
    OwnerDock.DrawIndicator(g, OwnerDock.SelectedItemIndex);
    OwnerDock.DrawCaption(g);
  end;

  if not Assigned(graphics) then
    g.Free;
end;

procedure TAdvSmoothDockForm.HookWndProc(var Msg: TMessage);
begin
  Msg.Result := CallWindowProc(OldWndProc, (Fdock.Owner as TForm).Handle, Msg.Msg , Msg.wParam, Msg.lParam);
  case Msg.Msg of
   WM_WINDOWPOSCHANGING:
   begin
     if not FMouseEntered then
     begin
       FDock.UpdateBounds := true;
       FDock.UpdateSize;
     end;
   end;
   WM_SIZE:
   begin
     if not FMouseEntered then
     begin
       FDock.UpdateBounds := true;
       Fdock.UpdateSize;
       FDock.Changed;
     end;
   end;
  end;
end;

procedure TAdvSmoothDockForm.Init;
begin
  Visible := False;
  BorderIcons := [];
  BorderStyle := bsNone;
  Ctl3D := false;
  FormStyle := fsStayOnTop;
  Color := clWhite;
  Position := poScreenCenter;
  CreateMainBuffer;
  SetLayeredWindow;
  UpdateLayered;
end;

procedure TAdvSmoothDockForm.KeyDown(var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Assigned(OwnerDock) then
    OwnerDock.DoKeyDown(Key, Shift);
end;

procedure TAdvSmoothDockForm.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Assigned(OwnerDock) then
    OwnerDock.DoMouseDown(Button, Shift, X, Y);
end;

procedure TAdvSmoothDockForm.MouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if Assigned(OwnerDock) then
    OwnerDock.DoMouseMove(Shift, X, Y);
end;

procedure TAdvSmoothDockForm.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Assigned(OwnerDock) then
    OwnerDock.DoMouseUp(Button, Shift, X, Y);
end;

procedure TAdvSmoothDockForm.Paint;
begin
  inherited;
  UpdateWindow;
end;

procedure TAdvSmoothDockForm.SetLayeredWindow;
begin
  if GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

  UpdateLayered;
end;

procedure TAdvSmoothDockForm.UpdateLayered;
begin
  ClearBuffer(nil);

  SetWindowPos(Self.Handle, HWND_TOPMOST, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED or SWP_NOACTIVATE);

  Draw(nil);

  UpdateMainWindow;
end;

procedure TAdvSmoothDockForm.UpdateMainWindow;
var
  ScrDC, MemDC: HDC;
  BitmapHandle, PrevBitmap: HBITMAP;
  BlendFunc: _BLENDFUNCTION;
  Size: TSize;
  P, S: TPoint;
begin
//  while BlendFunc.SourceConstantAlpha < 255 do
//  begin
    ScrDC := CreateCompatibleDC(0);
    MemDC := CreateCompatibleDC(ScrDC);

    FMainBuffer.GetHBITMAP(0, BitmapHandle);
    PrevBitmap := SelectObject(MemDC, BitmapHandle);
    Size.cx := Width;
    Size.cy := Height;
    P := Point(Left, Top);
    S := Point(0, 0);

    with BlendFunc do
    begin
      BlendOp := AC_SRC_OVER;
      BlendFlags := 0;
      SourceConstantAlpha := 255;
      AlphaFormat := AC_SRC_ALPHA;
    end;

    UpdateLayeredWindow(Handle, ScrDC, @P, @Size, MemDC, @S, 0, @BlendFunc, ULW_ALPHA);

    SelectObject(MemDC, PrevBitmap);
    DeleteObject(BitmapHandle);

    DeleteDC(MemDC);
    DeleteDC(ScrDC);
//  end;
end;

procedure TAdvSmoothDockForm.UpdateWindow;
begin
  CreateMainBuffer;
  UpdateLayered;
end;

procedure TAdvSmoothDockForm.WMActivate(var Message: TMessage);
begin
  inherited;
  Message.Result := 1;
end;

procedure TAdvSmoothDockForm.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
  inherited;
end;

procedure TAdvSmoothDockForm.WMMouseActivate(var msg: TWMMouseActivate);
begin
  msg.result := MA_NOACTIVATE;
end;

procedure TAdvSmoothDockForm.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  DefaultHandler(Msg);
  if Msg.Result = HTCAPTION then
    Msg.Result := HTNOWHERE;
end;

procedure TAdvSmoothDockForm.WMPaint(var Message: TWMPaint);
begin
  inherited;
end;

procedure TAdvSmoothDockForm.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_DESTROY then
  begin
    if not FDock.DockOnDeskTop then
      SetWindowLong((Fdock.Owner as TForm).Handle, GWL_WNDPROC, LongInt(OldWndProc));

    if Assigned(FDock) then
    begin
      if FDock.FOleDropTargetAssigned then
        RevokeDragDrop(self.Handle);
    end;
  end;
  inherited;
end;

{ TWinCtrl }

procedure TWinCtrl.PaintCtrls(DC: HDC; First: TControl);
begin
  PaintControls(DC, First);
end;

{ TAdvSmoothDockArrowAppearance }

procedure TAdvSmoothDockArrowAppearance.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothDockArrowAppearance) then
  begin
    FBorderColor := (Source as TAdvSmoothDockArrowAppearance).BorderColor;
    FColor := (Source as TAdvSmoothDockArrowAppearance).Color;
    FVisible := (Source as TAdvSmoothDockArrowAppearance).Visible;
    FSize := (Source as TAdvSmoothDockArrowAppearance).Size;
    FOpacity := (Source as TAdvSmoothDockArrowAppearance).Opacity;
  end;
end;

procedure TAdvSmoothDockArrowAppearance.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothDockArrowAppearance.Create(AOwner: TAdvSmoothDock);
begin
  FOwner := AOwner;
  FColor := clSilver;
  FOpacity := 200;
  FBorderColor := clBlack;
  FVisible := true;
  FSize := 35;
end;

destructor TAdvSmoothDockArrowAppearance.Destroy;
begin
  inherited;
end;

procedure TAdvSmoothDockArrowAppearance.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockArrowAppearance.SetColor(const Value: TColor);
begin
  if FColor <> value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockArrowAppearance.SetOpacity(const Value: Byte);
begin
  if FOpacity <> value then
  begin
    FOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockArrowAppearance.SetSize(const Value: integer);
begin
  if FSize <> value then
  begin
    FSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothDockArrowAppearance.SetVisibled(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

end.


