{**************************************************************************}
{ TAdvSmoothImageListBox Component                                         }
{ for Delphi & C++Builder                                                  }
{                                                                          }
{ written by TMS Software                                                  }
{            copyright � 2009                                              }
{            Email : info@tmssoftware.com                                  }
{            Web : http://www.tmssoftware.com                              }
{                                                                          }
{ The source code is given as is. The author is not responsible            }
{ for any possible damage done due to the use of this code.                }
{ The component can be freely used in any application. The complete        }
{ source code remains property of the author and may not be distributed,   }
{ published, given or sold in any form as such. No parts of the source     }
{ code can be included in any other component or application without       }
{ written authorization of the author.                                     }
{**************************************************************************}

unit AdvSmoothImageListBox;

{$DEFINE HILIGHT}
{$I TMSDEFS.INC}

interface

uses
  Forms, Messages, Windows, SysUtils, Classes, Graphics, Controls, StdCtrls,
  Comobj, Activex, AdvSmoothGDIP, AdvStyleIF, ImgList,               
  GDIPPictureContainer, ExtCtrls, Math, GDIPFill
  {$IFDEF TMSDOTNET}
  , Types
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 2; // Release nr.
  BLD_VER = 1; // Build nr.

  // version history
  // v1.0.0.0 : first release
  // v1.1.0.0 : New Multiselect items with mouse and keyboard.
  //          : New public PixelFormat, PixelDepth, HasAlphaChannel, HasPalette properties
  //          : Fixed Loading Image from formfile
  //          : Fixed Truetype initialization
  // v1.1.0.1 : Improved : Single click to zoom out image
  //          : Fixed : Memoryleak when calling TAdvSmoothImageListBox.Free at runtime
  //          : Fixed : Delphi 7 Font name causes Repainting loop
  // v1.1.0.2 : Fixed : issue with ScrollToItem in column mode
  // v1.1.1.0 : New : Methods SelectAll, UnSelectAll, Select(AItems: array of Integer) and CountSelected
  //          : Fixed : issue with Selected property of selected item in MouseUp
  // v1.1.1.1 : Fixed : issue with setting FileDate in AddImagesFromFolder
  // v1.1.1.2 : Fixed : issue with hints on navigator.
  // v1.1.1.3 : Fixed : issue with clearing Loading state
  // v1.1.1.4 : Improved : Keyboard item selection
  // v1.1.1.5 : Fixed : Disappearing items at designtime
  // v1.1.2.0 : New : OnItemAnchorClick event
  // v1.1.2.1 : Fixed : Issue when destroying in Timer routine

type
  TWinCtrl = class(TWinControl)
  public                 
    procedure PaintCtrls(DC: HDC; First: TControl);
  end;

  TAdvSmoothImageListBox = class;

  {$IFNDEF DELPHI2006_LVL}
  TMargins = class(TPersistent)
  private
    FOwner: TAdvSmoothImageListBox;
    FRight: integer;
    FBottom: integer;
    FTop: integer;
    FLeft: integer;
    FOnChange: TNotifyEvent;
    procedure SetBottom(const Value: integer);
    procedure SetLeft(const Value: integer);
    procedure SetRight(const Value: integer);
    procedure SetTop(const Value: integer);
  protected
    procedure Changed;
  public
    constructor Create(AOwner: TAdvSmoothImageListBox);
    procedure Assign(Source: TPersistent); override;
  published
    property Left: integer read FLeft write SetLeft;
    property Top: integer read FTop write SetTop;
    property Right: integer read FRight write SetRight;
    property Bottom: integer read FBottom write SetBottom;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;
  {$ENDIF}

  TAdvSmoothImageListBoxHTMLText = class;

  TImageLoaderThread = class(TThread)
  private
    ImageListBox: TAdvSmoothImageListBox;
  protected
    procedure Execute; override;
  public           
    constructor Create(AImageListBox: TAdvSmoothImageListBox);
  end;

  TImageThreadStatus = (stNone, stInitialized, stStarted, stLoaded);   

  TAdvSmoothImageListBoxLocation = (cpTopLeft, cpTopCenter, cpTopRight, cpCenterLeft, cpCenterCenter, cpCenterRight, cpBottomLeft, cpBottomCenter, cpBottomRight, cpCustom);

  TAdvSmoothImageListBoxImageState = (isDefault, isLoaded, isResizedLarger);

  TAdvSmoothImageListBoxTopLayerItem = class(TCollectionItem)
  private
    Fowner: TAdvSmoothImageListBox;
    FAlign: TAlign;
    FHTMLText: TAdvSmoothImageListBoxHTMLText;
    FWidth: integer;
    FVisible: Boolean;
    FTop: integer;
    FHeight: integer;
    FLeft: integer;
    FFill: TGDIPFill;
    procedure SetAlign(const Value: TAlign);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetHeight(const Value: integer);
    procedure SetHTMLText(const Value: TAdvSmoothImageListBoxHTMLText);
    procedure SetLeft(const Value: integer);
    procedure SetTop(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: integer);
  protected
    procedure Changed;
    procedure HTMLTextChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure Draw(g: TGPGraphics; r: TGPRectF);    
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Visible: Boolean read FVisible write SetVisible default true;
    property Top: integer read FTop write SetTop default 0;
    property Left: integer read FLeft write SetLeft default 0;
    property HTMLText: TAdvSmoothImageListBoxHTMLText read FHTMLText write SetHTMLText;
    property Fill: TGDIPFill read FFill write SetFill;
    property Align: TAlign read FAlign write SetAlign default alCustom;
    property Width: integer read FWidth write SetWidth default 100;
    property Height: integer read FHeight write SetHeight default 100;
  end;

  TAdvSmoothImageListBoxTopLayerItems = class(TCollection)
  private
    FOwner: TAdvSmoothImageListBox;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TAdvSmoothImageListBoxTopLayerItem;
    procedure SetItem(Index: Integer; const Value: TAdvSmoothImageListBoxTopLayerItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TAdvSmoothImageListBox);
    function Add: TAdvSmoothImageListBoxTopLayerItem;
    function Insert(Index: Integer): TAdvSmoothImageListBoxTopLayerItem;
    property Items[Index: Integer]: TAdvSmoothImageListBoxTopLayerItem read GetItem write SetItem; default;
    procedure Delete(Index: Integer);
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothImageListBoxSplitterState = (stExpanded, stCollapsed);

  TAdvSmoothImageListBoxItem = class(TCollectionItem)
  private
    FCollapsed: Boolean;
    FSelExp, FHovExp: integer;
    FMouseEntered, FMouseLeft: Boolean;
    FGoToNormalState: boolean;
    FDoubleClicked: Boolean;
    FX, FxTo, FY, FYTo, FWidth, FWidthTo: integer;
    FHeight, FHeightTo: integer;
    FCachedNormal: TGPBitmap;
    FCachedMaxWidth: integer;
    FCachedMaxHeight: integer;
    FOriginalImageWidth: single;
    FOriginalImageHeight: single;
    FThreadStatus: TImageThreadStatus;
    FOwner: TAdvSmoothImageListBox;
    FItemRect: TGPRectF;
    FImage: TAdvGDIPPicture;
    FCaption: TAdvSmoothImageListBoxHTMLText;
    FTag: integer;
    FSplitter: Boolean;
    FLocation: String;
    FEnabled: Boolean;
    FHint: string;
    FVisible: Boolean;
    FSplitterText: String;
    FFileDate: TDateTime;
    FFileSize: integer;
    FFileName: string;
    FSplitterState: TAdvSmoothImageListBoxSplitterState;
    FSelected: boolean;
    FHasPalette: Boolean;
    FHasAlphaChannel: Boolean;
    FPixelDepth: integer;
    FPixelFormat: TPixelFormat;
    procedure SetImage(const Value: TAdvGDIPPicture);
    procedure SetCaption(const Value: TAdvSmoothImageListBoxHTMLText);
    procedure SetSplitter(const Value: Boolean);
    procedure SetTag(const Value: integer);
    procedure SetLocation(const Value: String);
    procedure SetEnabled(const Value: Boolean);
    procedure SetHint(const Value: string);
    procedure SetVisible(const Value: Boolean);
    procedure SetSplitterText(const Value: String);
    procedure SetFileDate(const Value: TDateTime);
    procedure SetFileSize(const Value: integer);
    procedure SetFileName(const Value: string);
    procedure SetSplitterState(
      const Value: TAdvSmoothImageListBoxSplitterState);
    procedure SetSelected(const Value: boolean);
  protected
    procedure Changed;
    procedure ImageChanged(Sender: TObject);
    procedure CaptionChanged(Sender: TObject);
    procedure Draw(g: TGPGraphics; r: TGPRectF; dblclicked: Boolean);
    procedure DrawSplitter(g: TGPGraphics; h: TAdvSmoothImageListBoxHTMLText; r: TGPRectF);
    procedure DrawExpander(g: TGPGraphics; r: TGPRectF; Down, Hover: integer);    
    procedure ExpanderTextRect(g: TGPGraphics; rText: TGPRectF; var rTextArea: TGPRectF);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetOriginalImageWidth: integer;
    function GetOriginalImageHeight: integer;
    property PixelFormat: TPixelFormat read FPixelFormat;
    property PixelDepth: integer read FPixelDepth;
    property HasPalette: Boolean read FHasPalette;
    property HasAlphaChannel: Boolean read FHasAlphaChannel;
  published
    property SplitterState: TAdvSmoothImageListBoxSplitterState read FSplitterState write SetSplitterState default stExpanded;
    property Visible: Boolean read FVisible write SetVisible default true;
    property Image: TAdvGDIPPicture read FImage write SetImage;
    property Location: String read FLocation write SetLocation;
    property FileSize: integer read FFileSize write SetFileSize default 0;
    property FileDate: TDateTime read FFileDate write SetFileDate;
    property FileName: string read FFileName write SetFileName;
    property Splitter: Boolean read FSplitter write SetSplitter default false;
    property Tag: integer read FTag write SetTag default 0;
    property Caption: TAdvSmoothImageListBoxHTMLText read FCaption write SetCaption;
    property SplitterText: String read FSplitterText write SetSplitterText;
    property Enabled: Boolean read FEnabled write SetEnabled default true;
    property Hint: string read FHint write SetHint;
    property Selected: boolean read FSelected write SetSelected default false;
  end;

  TAdvSmoothImageListBoxItems = class(TCollection)
  private
    FUpdateCount: integer;
    FOwner: TAdvSmoothImageListBox;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TAdvSmoothImageListBoxItem;
    procedure SetItem(Index: Integer; const Value: TAdvSmoothImageListBoxItem);
  protected
    function GetOwner: TPersistent; override;
    function Compare(Item1, Item2 : TAdvSmoothImageListBoxItem) : integer; virtual;
    procedure QuickSort(L, R: Integer);
  public
    constructor Create(AOwner: TAdvSmoothImageListBox);
    function Add: TAdvSmoothImageListBoxItem;
    function Insert(Index: Integer): TAdvSmoothImageListBoxItem;
    property Items[Index: Integer]: TAdvSmoothImageListBoxItem read GetItem write SetItem; default;
    procedure Delete(Index: Integer);
    procedure Clear;
    procedure Sort;
    function Find(const s: string): integer;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    function HasSplitters: boolean;
    function HasItems: boolean;
    function FirstSplitter: integer;
    function NextSplitter(index: integer): integer;
    function FirstItem: integer;
    function NextItem(index: integer): integer;
    procedure SelectAll;
    procedure UnSelectAll;
    procedure Select(AItems: Array of Integer);
    function CountSelected: integer;    
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothImageListBoxNavigatorButtonsShape = (nsRounded, nsRoundRect, nsRect);

  TImageStretch = (isAlways, isShrinkOnly);

  TAdvSmoothImageListBoxSplitter = class(TPersistent)
  private
    FOwner: TAdvSmoothImageListBox;
    FSpacing: integer;
    FFill: TGDIPFill;
    FSize: integer;
    FOnChange: TNotifyEvent;
    FExpanderShape: TAdvSmoothImageListBoxNavigatorButtonsShape;
    FExpanderColor: TColor;
    FExpanderHoverColor: TColor;
    FExpanderSize: integer;
    FExpanderDownColor: TColor;
    FExpander: Boolean;
    FExpanderLocation: TAdvSmoothImageListBoxLocation;
    FExpanderBorderColor: TColor;
    FExpanderTop: integer;
    FExpanderLeft: Integer;
    FTextFont: TFont;
    FTextLocation: TAdvSmoothImageListBoxLocation;
    procedure SetFill(const Value: TGDIPFill);
    procedure SetSize(const Value: integer);
    procedure SetSpacing(const Value: integer);
    procedure SetExpander(const Value: Boolean);
    procedure SetExpanderColor(const Value: TColor);
    procedure SetExpanderDownColor(const Value: TColor);
    procedure SetExpanderHoverColor(const Value: TColor);
    procedure SetExpanderLocation(const Value: TAdvSmoothImageListBoxLocation);
    procedure SetExpanderShape(
      const Value: TAdvSmoothImageListBoxNavigatorButtonsShape);
    procedure SetExpanderSize(const Value: integer);
    procedure SetExpanderBorderColor(const Value: TColor);
    procedure SetExpanderLeft(const Value: Integer);
    procedure SetExpanderTop(const Value: integer);
    procedure SetTextFont(const Value: TFont);
    procedure SetTextLocation(const Value: TAdvSmoothImageListBoxLocation);
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure TextFontChanged(Sender: TObject);    
    function GetExpanderRect(r: TGPRectF): TGPRectF;
    function GetRect(r: TGPRectF): TGPRectF;
  public
    constructor Create(AOwner: TAdvSmoothImageListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Spacing: integer read FSpacing write SetSpacing default 10;
    property Size: integer read FSize write SetSize default 3;
    property Fill: TGDIPFill read FFill write SetFill;
    property TextLocation: TAdvSmoothImageListBoxLocation read FTextLocation write SetTextLocation default cpCenterLeft;
    property TextFont: TFont read FTextFont write SetTextFont;
    property Expander: Boolean read FExpander write SetExpander default false;
    property ExpanderColor: TColor read FExpanderColor write SetExpanderColor default clGray;
    property ExpanderBorderColor: TColor read FExpanderBorderColor write SetExpanderBorderColor default clBlack;    
    property ExpanderDownColor: TColor read FExpanderDownColor write SetExpanderDownColor default clBlue;
    property ExpanderHoverColor: TColor read FExpanderHoverColor write SetExpanderHoverColor default clRed;
    property ExpanderSize: integer read FExpanderSize write SetExpanderSize default 20;
    property ExpanderShape: TAdvSmoothImageListBoxNavigatorButtonsShape read FExpanderShape write SetExpanderShape default nsRounded;
    property ExpanderLocation: TAdvSmoothImageListBoxLocation read FExpanderLocation write SetExpanderLocation default cpCenterRight;
    property ExpanderLeft: Integer read FExpanderLeft write SetExpanderLeft default 0;
    property ExpanderTop: integer read FExpanderTop write SetExpanderTop default 0;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothImageListBoxItemAppearance = class(TPersistent)
  private
    FCachedFill, FCachedSelectedFill: TGPBitmap;
    FCachedDisabledFill, FCachedHoveredFill: TGPBitmap;
    FOwner: TAdvSmoothImageListBox;
    FOnChange: TNotifyEvent;
    FItemHorizontalSpacing: integer;
    FItemVerticalSpacing: integer;
    FDisabledFill: TGDIPFill;
    FSelectedFill: TGDIPFill;
    FFill: TGDIPFill;
    FHoverFill: TGDIPFill;
    FItemHeight: integer;
    FItemWidth: integer;
    FHoverSize: integer;
    FTextWidth: integer;
    FImageMargin: TMargins;
    FImageTop: integer;
    FImageHeight: integer;
    FImageLeft: integer;
    FTextMargin: TMargins;
    FTextTop: integer;
    FTextHeight: integer;
    FTextLeft: integer;
    FImageWidth: integer;
    FImageAlign: TAlign;
    FTextAlign: TAlign;
    FAutoSize: Boolean;
    FSplitter: TAdvSmoothImageListBoxSplitter;
    FTextVisible: Boolean;
    FImageVisible: Boolean;
    FAspectRatio: Boolean;
    FStretch: TImageStretch;
    procedure SetItemHorizontalSpacing(const Value: integer);
    procedure SetItemVerticalSpacing(const Value: integer);
    procedure SetDisabledFill(const Value: TGDIPFill);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetSelectedFill(const Value: TGDIPFill);
    procedure SetHoverFill(const Value: TGDIPFill);
    procedure SetItemHeight(const Value: integer);
    procedure SetItemWidth(const Value: integer);
    procedure SetHoverSize(const Value: integer);
    procedure SetImageHeight(const Value: integer);
    procedure SetImageLeft(const Value: integer);
    procedure SetImageMargin(const Value: TMargins);
    procedure SetImageTop(const Value: integer);
    procedure SetImageWidth(const Value: integer);
    procedure SetTextHeight(const Value: integer);
    procedure SetTextLeft(const Value: integer);
    procedure SetTextMargin(const Value: TMargins);
    procedure SetTextTop(const Value: integer);
    procedure SetTextWidth(const Value: integer);
    procedure SetImageAlign(const Value: TAlign);
    procedure SetTextAlign(const Value: TAlign);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetSplitter(const Value: TAdvSmoothImageListBoxSplitter);
    procedure SetImageVisible(const Value: Boolean);
    procedure SetTextVisible(const Value: Boolean);
    procedure SetAspectRatio(const Value: Boolean);
    procedure SetStretch(const Value: TImageStretch);
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure SelectedFillChanged(Sender: TObject);
    procedure DisabledFillChanged(Sender: TObject);
    procedure HoveredFillChanged(Sender: TObject);
    procedure SplitterChanged(Sender: TObject);
    procedure MarginChanged(Sender: TObject);
    procedure InitFills;
    procedure CheckItemWidth;
    procedure CheckItemHeight;
    procedure DrawFocusRect(f: TGDIPFill; g: TGPGraphics; r, rpos: TGPRectF);
    function GetRowHeight: integer;
    function GetColumnWidth: integer;
  public
    constructor Create(AOwner: TAdvSmoothImageListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property AutoSize: Boolean read FAutoSize write SetAutoSize default false;
    property AspectRatio: Boolean read FAspectRatio write SetAspectRatio default true;
    property ImageVisible: Boolean read FImageVisible write SetImageVisible default true;
    property ImageAlign: TAlign read FImageAlign write SetImageAlign default alClient;
    property ImageMargin: TMargins read FImageMargin write SetImageMargin;
    property ImageLeft: integer read FImageLeft write SetImageLeft default 10;
    property ImageTop: integer read FImageTop write SetImageTop default 10;
    property ImageWidth: integer read FImageWidth write SetImageWidth default 50;
    property ImageHeight: integer read FImageHeight write SetImageHeight default 50;
    property TextVisible: Boolean read FTextVisible write SetTextVisible default false;    
    property TextAlign: TAlign read FTextAlign write SetTextAlign default alBottom;
    property TextMargin: TMargins read FTextMargin write SetTextMargin;
    property TextLeft: integer read FTextLeft write SetTextLeft default 10;
    property TextTop: integer read FTextTop write SetTextTop default 10;
    property TextWidth: integer read FTextWidth write SetTextWidth default 10;
    property TextHeight: integer read FTextHeight write SetTextHeight default 10;
    property ItemWidth: integer read FItemWidth write SetItemWidth default 70;
    property ItemHeight: integer read FItemHeight write SetItemHeight default 70;
    property ItemVerticalSpacing: integer read FItemVerticalSpacing write SetItemVerticalSpacing default 10;
    property ItemHorizontalSpacing: integer read FItemHorizontalSpacing write SetItemHorizontalSpacing default 10;
    property Fill: TGDIPFill read FFill write SetFill;
    property SelectedFill: TGDIPFill read FSelectedFill write SetSelectedFill;
    property DisabledFill: TGDIPFill read FDisabledFill write SetDisabledFill;
    property HoverFill: TGDIPFill read FHoverFill write SetHoverFill;
    property HoverSize: integer read FHoverSize write SetHoverSize default 0;
    property Splitter: TAdvSmoothImageListBoxSplitter read FSplitter write SetSplitter;
    property Stretch: TImageStretch read FStretch write SetStretch default isAlways;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothImageListBoxHTMLText = class(TPersistent)
  private
    FDisableRepaint: Boolean;
    FOwner: TAdvSmoothImageListBox;
    FURLColor: TColor;
    FShadowOffset: integer;
    FFont: TFont;
    FText: string;
    FShadowColor: TColor;
    FOnChange: TNotifyEvent;
    FLocation: TAdvSmoothImageListBoxLocation;
    FTop: integer;
    FLeft: integer;
    procedure SetFont(const Value: TFont);
    procedure SetShadowColor(const Value: TColor);
    procedure SetShadowOffset(const Value: integer);
    procedure SetText(const Value: string);
    procedure SetURLColor(const Value: TColor);
    procedure SetLocation(const Value: TAdvSmoothImageListBoxLocation);
    procedure SetLeft(const Value: integer);
    procedure SetTop(const Value: integer);
  protected
    procedure Changed;
    procedure FontChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothImageListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Text: string read FText write SetText;
    property Location: TAdvSmoothImageListBoxLocation read FLocation write SetLocation default cpCenterLeft;
    property Top: integer read FTop write SetTop default 0;
    property Left: integer read FLeft write SetLeft default 0;
    property URLColor: TColor read FURLColor write SetURLColor default clBlue;
    property ShadowColor: TColor read FShadowColor write SetShadowColor default clGray;
    property ShadowOffset: integer read FShadowOffset write SetShadowOffset default 5;
    property Font: TFont read FFont write SetFont;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;    
  end;

  TAdvSmoothImageListBoxItemKind = (ikItem, ikSplitter);

  TAdvSmoothImageListBoxDisplayListItem = class(TObject)
  private
    FRectangle: TGPRectF;
    FKind: TAdvSmoothImageListBoxItemKind;
    FItem: TAdvSmoothImageListBoxItem;
    procedure SetKind(const Value: TAdvSmoothImageListBoxItemKind);
  protected
    procedure Changed;
  public
    property Kind: TAdvSmoothImageListBoxItemKind read FKind write SetKind;
    property DisplayItem: TAdvSmoothImageListBoxItem read FItem write FItem;
    property Rectangle: TGPRectF read FRectangle write FRectangle;
  end;

  TAdvSmoothImageListBoxDisplayList = class(TList)
  public
    procedure Clear; override;
    procedure DeleteItem(index: integer);
    function AddItem: TAdvSmoothImageListBoxDisplayListItem;
    function GetItem(index: integer): TAdvSmoothImageListBoxDisplayListItem;
  end;

  TAdvSmoothImageListBoxNavigator = class(TPersistent)
  private
    FOwner: TAdvSmoothImageListBox;
    FShape: TAdvSmoothImageListBoxNavigatorButtonsShape;
    FColor: TColor;
    FHoverColor: TColor;
    FVisible: Boolean;
    FSize: integer;
    FOnChange: TNotifyEvent;
    FLocation: TAdvSmoothImageListBoxLocation;
    FLeft: integer;
    FTop: integer;
    FDownColor: TColor;
    FBorderColor: TColor;
    FDisabledColor: TColor;
    FHintNext: String;
    FHintPreviousPage: String;
    FHintPrevious: String;
    FHintNextPage: String;
    procedure SetColor(const Value: TColor);
    procedure SetHoverColor(const Value: TColor);
    procedure SetSize(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetShape(
      const Value: TAdvSmoothImageListBoxNavigatorButtonsShape);
    procedure SetLocation(const Value: TAdvSmoothImageListBoxLocation);
    procedure SetLeft(const Value: integer);
    procedure SetTop(const Value: integer);
    procedure SetDownColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetDisabledColor(const Value: TColor);
    procedure SetHintNext(const Value: String);
    procedure SetHintNextPage(const Value: String);
    procedure SetHintPrevious(const Value: String);
    procedure SetHintPreviousPage(const Value: String);
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure FontChanged(Sender: TObject);
    procedure Draw(r: TGPRectF; Down, Hover: integer);    
    function GetNavigatorButtonRect(r: TGPRectF; Button: integer): TGPRectF;
    function GetNavigatorRect(r: TGPRectF): TGPRectF;
  public
    constructor Create(AOwner: TAdvSmoothImageListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published  
    property Visible: Boolean read FVisible write SetVisible;
    property Color: TColor read FColor write SetColor default clGray;
    property HintNext: String read FHintNext write SetHintNext;
    property HintPrevious: String read FHintPrevious write SetHintPrevious;
    property HintNextPage: String read FHintNextPage write SetHintNextPage;
    property HintPreviousPage: String read FHintPreviousPage write SetHintPreviousPage;
    property DisabledColor: TColor read FDisabledColor write SetDisabledColor;
    property HoverColor: TColor read FHoverColor write SetHoverColor default clBlue;
    property DownColor: TColor read FDownColor write SetDownColor default clRed;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clGray;
    property Size: integer read FSize write SetSize default 20;
    property Shape: TAdvSmoothImageListBoxNavigatorButtonsShape read FShape write SetShape default nsRoundRect;
    property Location: TAdvSmoothImageListBoxLocation read FLocation write SetLocation default cpCenterRight;
    property Left: integer read FLeft write SetLeft default 0;
    property Top: integer read FTop write SetTop default 0;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothImageListBoxHeader = class(TPersistent)
  private
    FOwner: TAdvSmoothImageListBox;
    FCaption: String;
    FCaptionLocation: TAdvSmoothImageListBoxLocation;
    FFill: TGDIPFill;
    FHeight: integer;
    FOnChange: TNotifyEvent;
    FVisible: Boolean;
    FCaptionTop: integer;
    FCaptionLeft: integer;
    FFont: TFont;
    FNavigator: TAdvSmoothImageListBoxNavigator;
    procedure SetCaption(const Value: String);
    procedure SetCaptionLocation(const Value: TAdvSmoothImageListBoxLocation);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetHeight(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetCaptionLeft(const Value: integer);
    procedure SetCaptionTop(const Value: integer);
    procedure SetFont(const Value: TFont);
    procedure SetNavigator(const Value: TAdvSmoothImageListBoxNavigator);
  protected
    procedure Changed;
    procedure FontChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure NavigatorChanged(Sender: TObject);
    function GetHeight: integer;
    function GetRect: TGPRectF;
  public
    constructor Create(AOwner: TAdvSmoothImageListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: String read FCaption write SetCaption;
    property CaptionLocation: TAdvSmoothImageListBoxLocation read FCaptionLocation write SetCaptionLocation default cpCenterCenter;
    property CaptionLeft: integer read FCaptionLeft write SetCaptionLeft default 0;
    property CaptionTop: integer read FCaptionTop write SetCaptionTop default 0;
    property Font: TFont read FFont write SetFont;
    property Height: integer read FHeight write SetHeight default 50;
    property Fill: TGDIPFill read FFill write SetFill;
    property Visible: Boolean read FVisible write SetVisible default true;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Navigator: TAdvSmoothImageListBoxNavigator read FNavigator write SetNavigator;
  end;

  TAdvSmoothImageListBoxFooter = class(TPersistent)
  private
    FOwner: TAdvSmoothImageListBox;
    FCaption: String;
    FCaptionLocation: TAdvSmoothImageListBoxLocation;
    FFill: TGDIPFill;
    FHeight: integer;
    FOnChange: TNotifyEvent;
    FVisible: Boolean;
    FCaptionTop: integer;
    FCaptionLeft: integer;
    FFont: TFont;
    FNavigator: TAdvSmoothImageListBoxNavigator;
    procedure SetCaption(const Value: String);
    procedure SetCaptionLocation(const Value: TAdvSmoothImageListBoxLocation);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetHeight(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetCaptionLeft(const Value: integer);
    procedure SetCaptionTop(const Value: integer);
    procedure SetFont(const Value: TFont);
    procedure SetNavigator(const Value: TAdvSmoothImageListBoxNavigator);
  protected
    procedure Changed;
    procedure FontChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure NavigatorChanged(Sender: TObject);
    function GetHeight: integer;
    function GetRect: TGPRectF;
  public
    constructor Create(AOwner: TAdvSmoothImageListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Caption: String read FCaption write SetCaption;
    property CaptionLocation: TAdvSmoothImageListBoxLocation read FCaptionLocation write SetCaptionLocation default cpCenterCenter;
    property CaptionLeft: integer read FCaptionLeft write SetCaptionLeft default 0;
    property CaptionTop: integer read FCaptionTop write SetCaptionTop default 0;
    property Font: TFont read FFont write SetFont;
    property Height: integer read FHeight write SetHeight default 50;
    property Fill: TGDIPFill read FFill write SetFill;
    property Visible: Boolean read FVisible write SetVisible default true;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Navigator: TAdvSmoothImageListBoxNavigator read FNavigator write SetNavigator;
  end;

  TAdvSmoothImageThreadLoading = (tlAll, tlOnDemand, tlOnDemandAfterAnimation);

  TAdvSmoothImageListBoxNavigationMode = (nmNone, nmPrior, nmPriorPage, nmNext, nmNextPage);

  TAdvSmoothImageListBoxItemClickEvent = procedure(Sender: TObject; itemindex: integer; Button: TMouseButton; Shift: TShiftState) of object;

  TAdvSmoothImageListBoxItemEvent = procedure(Sender: TObject; itemindex: integer) of object;

  TAdvSmoothImageListBoxNavigateEvent = procedure(Sender: TObject; NavigationMode: TAdvSmoothImageListBoxNavigationMode; var allow: Boolean) of object;

  TAdvSmoothImageListBoxItemHintEvent = procedure(Sender: TObject; itemindex: integer; var hint: string) of object;

  TAdvSmoothImageListBoxItemTextEvent = procedure(Sender: TObject; itemindex: integer; var text: string) of object;

  TAdvSmoothImageListBoxItemZoomEvent = procedure(Sender: TObject; itemindex: integer; var allow: boolean) of object;

  TAdvSmoothImageListBoxScrollEvent = procedure(Sender: TObject; scrollposition: integer) of object;

  TAdvSmoothImageListBoxItemAnchorEvent = procedure(Sender: TObject; itemindex: integer; Anchor: String) of object;

  TAdvSmoothImageListBoxZoomMode = (zmFullScreen, zmAspectRatio);

  TItemAnchor = record
    itemindex: integer;
    anchor: String;
  end;

  TAdvSmoothImageListBox = class(TCustomControl, ITMSStyle)
  private
    FFocused: Boolean;
    FStartImage: integer;
    FRestartLoop: Boolean;
    FDesignTime: Boolean;
    FPaintIndex: integer;
    FTimerCount: integer;
    FLookupKey: String;
    FScrollBar: TScrollBar;
    FOriginalDefaultWidth, FOriginalDefaultHeight: integer;
    FItemsInitialized, FItemRectsInitialized: Boolean;
    FImageLoaderThread: TImageLoaderThread;
    FThreadDone: Boolean;
    FUseThreading: Boolean;
    FDefaultNormal: TGPBitmap;
    FSp: single;
    FCurrentScPos, FScPosTo: integer;
    FClickY, FClickX: integer;
    FMouseDown, FMouseUp: Boolean;
    FTimeStart, FTimeStop: integer;    
    FDragXY, FScrollXY: integer;
    FDisplayList: TAdvSmoothImageListBoxDisplayList;
    FAnimating, FAnimate, FAnimateX: Boolean;
    FAnimateY, FAnimateW, FAnimateH: Boolean;
    FAnimateDoubleClick: Boolean;
    FAnimateTimer: TTimer;
    FItems: TAdvSmoothImageListBoxItems;
    FFill: TGDIPFill;
    FTransparent: Boolean;
    FDefaultImage: TAdvGDIPPicture;
    FItemAppearance: TAdvSmoothImageListBoxItemAppearance;
    FRows: integer;
    FColumns: integer;
    FSelectedItemIndex, FFocusedItemIndex: Integer;
    FHovF, FHovH, FSelF, FSelH, FHoveredItemIndex: Integer;
    FHeader: TAdvSmoothImageListBoxHeader;
    FFooter: TAdvSmoothImageListBoxFooter;
    FAnimationFactor: integer;
    FThreadLoading: TAdvSmoothImageThreadLoading;
    FZoomOnDblClick: Boolean;
    FDefaultHTMLText: TAdvSmoothImageListBoxHTMLText;
    FImages: TCustomImageList;
    FContainer: TGDIPPictureContainer;
    FTopLayerItems: TAdvSmoothImageListBoxTopLayerItems;
    FZoomOnTop: Boolean;
    FShowScrollBar: Boolean;
    FOnItemSelect: TAdvSmoothImageListBoxItemEvent;
    FOnScroll: TAdvSmoothImageListBoxScrollEvent;
    FKeyBoardLookUp: Boolean;
    FSorted: boolean;
    FHover: Boolean;
    FMark, FMarkTag: string;
    FMarkCase: boolean;
    FZoomMode: TAdvSmoothImageListBoxZoomMode;
    FOnItemDblClick: TAdvSmoothImageListBoxItemEvent;
    FOnItemMouseLeave: TAdvSmoothImageListBoxItemEvent;
    FOnItemZoomedOut: TAdvSmoothImageListBoxItemEvent;
    FOnItemClick: TAdvSmoothImageListBoxItemClickEvent;
    FOnItemZoomOut: TAdvSmoothImageListBoxItemZoomEvent;
    FOnItemZoomedIn: TAdvSmoothImageListBoxItemEvent;
    FOnItemMouseDown: TAdvSmoothImageListBoxItemEvent;
    FOnItemMouseEnter: TAdvSmoothImageListBoxItemEvent;
    FOnItemZoomIn: TAdvSmoothImageListBoxItemZoomEvent;
    FOnItemHint: TAdvSmoothImageListBoxItemHintEvent;
    FOnItemMouseUp: TAdvSmoothImageListBoxItemEvent;
    FOnItemGetDisplayText: TAdvSmoothImageListBoxItemTextEvent;
    FOnNavigate: TAdvSmoothImageListBoxNavigateEvent;
    FMultiSelect: Boolean;
    FShowFocus: Boolean;
    FFocusColor: TColor;
    FOnItemAnchorClick: TAdvSmoothImageListBoxItemAnchorEvent;
    procedure SetItems(const Value: TAdvSmoothImageListBoxItems);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetTransparent(const Value: Boolean);
    procedure SetDefaultImage(const Value: TAdvGDIPPicture);
    procedure SetItemAppearance(const Value: TAdvSmoothImageListBoxItemAppearance);
    procedure SetColumns(const Value: integer);
    procedure SetRows(const Value: integer);
    procedure SetSelectedItemIndex(const Value: Integer);
    procedure SetHeader(const Value: TAdvSmoothImageListBoxHeader);
    procedure SetFooter(const Value: TAdvSmoothImageListBoxFooter);
    function GetVersion: String;
    procedure SetAnimationFactor(const Value: integer);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetThreadLoading(const Value: TAdvSmoothImageThreadLoading);
    procedure SetZoomOnDblClick(const Value: Boolean);
    procedure SetDefaultHTMLText(const Value: TAdvSmoothImageListBoxHTMLText);
    procedure SetTopLayerItems(
      const Value: TAdvSmoothImageListBoxTopLayerItems);
    procedure SetZoomOnTop(const Value: Boolean);
    procedure SetShowScrollBar(const Value: Boolean);
    procedure SetKeyBoardLookUp(const Value: Boolean);
    procedure SetSorted(const Value: boolean);
    procedure SetHover(const Value: Boolean);
    procedure SetZoomMode(const Value: TAdvSmoothImageListBoxZoomMode);
    procedure SetMultiSelect(const Value: Boolean);
    procedure SetFocusColor(const Value: TColor);
    procedure SetShowFocus(const Value: Boolean);
  protected
    procedure Changed;
    procedure HeaderChanged(Sender: TObject);
    procedure DefaultHTMLTextChanged(Sender: TObject);    
    procedure FooterChanged(Sender: TObject);
    procedure DoEnter; override;
    procedure DoExit; override;    
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;    
    procedure DblClick; override;
    procedure KeyPress(var Key: char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ItemsChanged(Sender: TObject);
    procedure Scroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure TopLayerItemsChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure ItemAppearanceChanged(Sender: TObject);
    procedure DefaultImageChanged(Sender: TObject);
    procedure InitListBoxItems;
    procedure Animate(Sender: TObject);
    procedure DoZoom;
    function DrawHTMLText(g: TGPGraphics; HTML: TAdvSmoothImageListBoxHTMLText; r: TGPRectF; str: String;
      DoAnchor: Boolean = false; fX: integer = -1; fY: integer = -1): String;
    procedure DrawText(g: TGPGraphics; HTML: TAdvSmoothImageListBoxHTMLText; r: TGPRectF; str: String);
    procedure SelectImage(Key: Word; var itemindex: integer; itemselect: Boolean);
    procedure GetAspectSize(var w, h: integer; ow, oh, nw, nh: double);
    procedure InitPreview;
    procedure Navigate(Key: Word; Shift: TShiftState);
    procedure SetScrollBarPosition;
    procedure DrawDefaultImage(item: integer; g: TGPGraphics; r: TGPRectF);
    procedure DrawBackGround;
    procedure DrawHeader;
    procedure DrawFooter;
    procedure DrawItems;
    procedure DrawFill(g: TGPGraphics);
    procedure DrawHTML(g: TGPGraphics);
    procedure DrawDisplayItems(g: TGPGraphics);
    procedure DrawTopLayerItems;
    procedure DrawZoomedItem;
    procedure ThreadDone(Sender: TObject);
    procedure Resize; override;
    function GetScrollBarWidth: integer;
    function GetScrollBarHeight: integer;
    function GetTextRect(g: TGPGraphics; HTML: TAdvSmoothImageListBoxHTMLText; r: TGPRectF; str: String): TGPRectF;
    function GetHTMLTextRect(g: TGPGraphics; HTML: TAdvSmoothImageListBoxHTMLText; r: TGPRectF; str: String): TGPRectF;
    function HeaderButton(X, Y: integer; var State: integer): integer;
    function FooterButton(X, Y: integer; var State: integer): integer;
    function ExpanderButton(X, Y: integer; r: TGPRectF; item: TAdvSmoothImageListBoxItem; var State: integer): integer;
    function GetDisplayRectangle: TGPRectF;
    function GetStrippedHTMLText(HTML: TAdvSmoothImageListBoxHTMLText): String;
    function ProcessKeyDown(Key: Word; var itemindex: integer): Boolean;
    function InsideRect: TRect;
    function GetItemRectangleOnXY(X, Y: integer): TGPRectF;
    function FindItemOnXY(X, Y: integer): integer;
    function GetAnchorAt(X, Y: integer): TItemAnchor;
    function GetShadowOffset: integer;
    function GetOuterBorderWidth: integer;
    function GetVersionNr: Integer;
    function GetPositionTo: integer;
    function GetPosition: integer;
    function GetFullSize: integer; virtual;
    function GetFirstVisibleItem: integer;
    function GetLastVisibleItem: integer;
    function GetItemIsVisible(r: TGPRectF): Boolean;
    function GetItemIsDblClicked: Boolean;
    function GetTotalImageHeight: integer;
    function GetTotalImageWidth: integer;
    function GetTotalTextHeight: integer;
    function GetTotalTextWidth: integer;
    function GetImageHeight: integer;
    function GetImageWidth: integer;
    function GetTextHeight: integer;
    function GetTextWidth: integer;
    function GetItemImageRect(r: TGPRectF): TGPRectF;
    function GetItemTextRect(r: TGPRectF): TGPRectF;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseWheelHandler(var Message: TMessage); override;    
    procedure Assign(Source: TPersistent); override;
    procedure Paint; override;
    procedure Loaded; override;
    procedure CreateWnd; override;
    procedure SetComponentStyle(AStyle: TTMSStyle);
    procedure AddImagesFromFolder(AFolder: String; SetImageCaption: boolean = false);
    procedure AddImageLocationsFromFolder(AFolder: String; SetImageCaption: boolean = false);
    procedure Highlight(DoCase: Boolean; HiText: string);
    procedure UnHighlight;
    procedure Mark(DoCase: Boolean; HiText: string);
    procedure UnMark;
    procedure ExpandAll;
    procedure CollapseAll;
    procedure StopThread;
    procedure StartThread;
    procedure ScrollToItem(itemindex: integer);
    function GetRowCount: integer;
    function GetColumnCount: integer;
  published
    property AnimationFactor: integer read FAnimationFactor write SetAnimationFactor default 4;
    property Images: TCustomImageList read FImages write FImages;
    property PictureContainer: TGDIPPictureContainer read FContainer write FContainer;        
    property Version: String read GetVersion;
    property SelectedItemIndex: Integer read FSelectedItemIndex write SetSelectedItemIndex default -1;
    property Items: TAdvSmoothImageListBoxItems read FItems write SetItems;
    property TopLayerItems: TAdvSmoothImageListBoxTopLayerItems read FTopLayerItems write SetTopLayerItems;
    property ItemAppearance: TAdvSmoothImageListBoxItemAppearance read FItemAppearance write SetItemAppearance;
    property Header: TAdvSmoothImageListBoxHeader read FHeader write SetHeader;
    property Footer: TAdvSmoothImageListBoxFooter read FFooter write SetFooter;
    property Fill: TGDIPFill read FFill write SetFill;
    property DefaultImage: TAdvGDIPPicture read FDefaultImage write SetDefaultImage;
    property DefaultHTMLText: TAdvSmoothImageListBoxHTMLText read FDefaultHTMLText write SetDefaultHTMLText;
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property Columns: integer read FColumns write SetColumns default 0;
    property Rows: integer read FRows write SetRows default 3;
    property ThreadLoading: TAdvSmoothImageThreadLoading read FThreadLoading write SetThreadLoading default tlOnDemandAfterAnimation;
    property ZoomOnDblClick: Boolean read FZoomOnDblClick write SetZoomOnDblClick default true;
    property ZoomMode: TAdvSmoothImageListBoxZoomMode read FZoomMode write SetZoomMode default zmFullScreen;
    property ZoomOnTop: Boolean read FZoomOnTop write SetZoomOnTop default false;
    property KeyBoardLookUp: Boolean read FKeyBoardLookUp write SetKeyBoardLookUp default false;
    property ShowScrollBar: Boolean read FShowScrollBar write SetShowScrollBar default true;
    property Sorted: boolean read FSorted write SetSorted default false;
    property Hover: Boolean read FHover write SetHover default true;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default false;
    property ShowFocus: Boolean read FShowFocus write SetShowFocus default true;
    property FocusColor: TColor read FFocusColor write SetFocusColor default clBlack;

    property OnNavigate: TAdvSmoothImageListBoxNavigateEvent read FOnNavigate write FOnNavigate;
    property OnItemSelect: TAdvSmoothImageListBoxItemEvent read FOnItemSelect write FOnItemSelect;
    property OnItemClick: TAdvSmoothImageListBoxItemClickEvent read FOnItemClick write FOnItemClick;
    property OnItemMouseDown: TAdvSmoothImageListBoxItemEvent read FOnItemMouseDown write FOnItemMouseDown;
    property OnItemMouseUp: TAdvSmoothImageListBoxItemEvent read FOnItemMouseUp write FOnItemMouseUp;
    property OnItemMouseEnter: TAdvSmoothImageListBoxItemEvent read FOnItemMouseEnter write FOnItemMouseEnter;
    property OnItemMouseLeave: TAdvSmoothImageListBoxItemEvent read FOnItemMouseLeave write FOnItemMouseLeave;
    property OnItemDblClick: TAdvSmoothImageListBoxItemEvent read FOnItemDblClick write FOnItemDblClick;
    property OnItemZoomIn: TAdvSmoothImageListBoxItemZoomEvent read FOnItemZoomIn write FOnItemZoomIn;
    property OnItemZoomedIn: TAdvSmoothImageListBoxItemEvent read FOnItemZoomedIn write FOnItemZoomedIn;
    property OnItemZoomOut: TAdvSmoothImageListBoxItemZoomEvent read FOnItemZoomOut write FOnItemZoomOut;
    property OnItemZoomedOut: TAdvSmoothImageListBoxItemEvent read FOnItemZoomedOut write FOnItemZoomedOut;
    property OnItemHint: TAdvSmoothImageListBoxItemHintEvent read FOnItemHint write FOnItemHint;
    property OnItemAnchorClick: TAdvSmoothImageListBoxItemAnchorEvent read FOnItemAnchorClick write FOnItemAnchorClick;
    property OnItemGetDisplayText: TAdvSmoothImageListBoxItemTextEvent read FOnItemGetDisplayText write FOnItemGetDisplayText;
    property OnScroll: TAdvSmoothImageListBoxScrollEvent read FOnScroll write FOnScroll;

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
    property OnDblClick;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;   
    property Visible;
    property TabStop;
  end;

implementation

uses
  CommCtrl, ShellApi;

{$I GDIPHTMLEngine.pas}

type
  {$HINTS OFF}
  TShadowedCollection = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList;
  end;
  {$HINTS ON}

const
  RELOADFACTOR = 1.3;

function CreateRoundRectangle(R: TGPRectF; Radius: Integer; RoundingType: TFillRoundingType; Mirror: Boolean): TGPGraphicsPath;
var
  l, t, w, h, d: Double;
begin
  Result := TGPGraphicsPath.Create;
  l := R.X;
  t := R.Y;
  w := R.Width;
  h := R.Height;
  d := Radius shl 1;
  case RoundingType of
    rtNone:
    begin
      Result.AddLine(l, t, l + w, t); // top
      Result.AddLine(l + w, t, l + w, t + h); // right
      Result.AddLine(l + w, t + h, l, t + h); // bottom
      Result.AddLine(l, t + h, l, t); // left
    end;
    rtTop:
    begin
      Result.AddArc(l, t, d, d, 180, 90); // topleft
      Result.AddLine(l + radius, t, l + w - radius, t); // top
      Result.AddArc(l + w - d, t, d, d, 270, 90); // topright
      Result.AddLine(l + w, t + radius, l + w, t + h); // right
      Result.AddLine(l + w, t + h, l, t + h); // bottom
      Result.AddLine(l, t + h, l, t + Radius); // left
    end;
    rtBottom:
    begin
      Result.AddLine(l, t, l + w, t); // top
      Result.AddLine(l + w, t, l + w, t + h - radius); // right
      Result.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
      Result.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
      Result.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
      Result.AddLine(l, t + h - Radius, l, t ); // left
    end;
    rtBoth:
    begin
      Result.AddArc(l, t, d, d, 180, 90); // topleft
      Result.AddLine(l + radius, t, l + w - radius, t); // top
      Result.AddArc(l + w - d, t, d, d, 270, 90); // topright
      Result.AddLine(l + w, t + radius, l + w, t + h - radius); // right
      Result.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
      Result.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
      Result.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
      Result.AddLine(l, t + h - radius, l, t + radius); // left
    end;
  end;
  Result.CloseFigure();
end;

procedure GetObjectLocation(var x, y: integer; rectangle: TGPRectF; objectwidth, objectheight: integer; location: TAdvSmoothImageListBoxLocation);
var
  w, h, tw, th: integer;
begin
  tw := objectwidth;
  th := objectheight;
  w := Round(rectangle.Width);
  h := Round(rectangle.Height);
  case location of
    cpTopLeft:
    begin
      x := 0;
      y := 0;
    end;
    cpTopRight:
    begin
      x := w - tw;
      y := 0;
    end;
    cpBottomLeft:
    begin
      x := 0;
      y := h - th;
    end;
    cpBottomRight:
    begin
      x := w - tw;
      y := h - th;
    end;
    cpTopCenter:
    begin
      x := (w - tw) div 2;
      y := 0;
    end;
    cpBottomCenter:
    begin
      x := (w - tw) div 2;
      y := h - th;
    end;
    cpCenterCenter:
    begin
      x := (w - tw) div 2;
      y := (h - th) div 2;
    end;
    cpCenterLeft:
    begin
      x := 0;
      y := (h - th) div 2;
    end;
    cpCenterRight:
    begin
      x := w - tw;
      y := (h - th) div 2;
    end;
  end;

  x := x + Round(rectangle.X);
  y := y + Round(rectangle.Y);
end;

{ TAdvSmoothImageListBox }

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

function AnimateDouble(var Start: integer; Stop: integer; Delta: Double; Margin: integer): Boolean;
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

procedure TAdvSmoothImageListBox.AddImageLocationsFromFolder(AFolder:
String; SetImageCaption: Boolean = false); var
  SR: TSearchRec;

  procedure AddToList(s: string);
  begin
    with Items.Add do
    begin
      FLocation := s;
      FFileSize := SR.Size;
      FFileDate := FileDateToDateTime(SR.Time);
      FFileName := SR.Name;
      FThreadStatus := stInitialized;
      if SetImageCaption then
      begin
        FCaption.Text := ExtractFileName(s);
        FCaption.Location := cpCenterCenter;
      end;
    end;
  end;

begin
  if FItems.FUpdateCount = 0 then
    StopThread;


  if FindFirst(AFolder,faAnyFile,SR) = 0 then
  begin
    AddToList(ExtractFilePath(AFolder) + SR.Name);
    while FindNext(SR) = 0 do
      AddToList(ExtractFilePath(AFolder) + SR.Name);
  end;
  FindClose(SR);
  
  FUseThreading := true;

  if FItems.FUpdateCount = 0 then
    StartThread;

  if SetImageCaption then
    FItemAppearance.TextVisible := true;
end;

procedure TAdvSmoothImageListBox.AddImagesFromFolder(AFolder: String; SetImageCaption: Boolean = false);
var
  SR: TSearchRec;

  procedure AddToList(s: string);
  begin
    with Items.Add do
    begin
      try
        Image.LoadFromFile(s);
        FFileSize := SR.Size;
        FFileDate := FileDateToDateTime(SR.Time);
        FFileName := SR.Name;
        if SetImageCaption then
        begin
          FCaption.Text := ExtractFileName(s);
          FCaption.Location := cpCenterCenter;
        end;
      except
        Image.Assign(nil);
      end;
    end;
  end;

begin
  if FindFirst(AFolder,faAnyFile,SR) = 0 then
  begin
    AddToList(ExtractFilePath(AFolder) + SR.Name);
    while FindNext(SR) = 0 do
      AddToList(ExtractFilePath(AFolder) + SR.Name);
  end;
  FindClose(SR);
  if SetImageCaption then
    FItemAppearance.TextVisible := True;
end;

procedure TAdvSmoothImageListBox.Animate(Sender: TObject);
var
  d, dx, dy, dw, dh: Double;
  posto: integer;
  I, firstitem: Integer;
  nw, nh, x, y, w, h, cnt: integer;
  item: TAdvSmoothImageListBoxItem;
begin
  if (csDesigning in ComponentState) or ((Rows <> 0) and (Columns <> 0)) or (Items.Count = 0) then
    Exit;

  if FAnimate then
  begin
    posTo := GetPositionTo;
    firstitem := GetFirstVisibleItem;
    cnt := 0;
    for I := 0 to FDisplayList.Count - 1 do
      if GetItemIsVisible(FDisplayList.GetItem(i).Rectangle) then
        Inc(cnt);

    for I := Max(0, firstitem) to Min(FDisplayList.Count - 1, firstitem + cnt) do
    begin
      item := FDisplayList.GetItem(I).FItem;
      if item <> nil then      
        if item.FThreadStatus = stInitialized then
          FSp := 0.5;
    end;
    
    d := Abs(posto - FCurrentScPos) / Max(1, Abs(FSp) * FAnimationFactor);
    FAnimating := AnimateDouble(FCurrentScPos, posto, d, 1);
    if FAnimating then
    begin
      InitListBoxItems;
      Changed;
    end;
  end;

  if FAnimateDoubleClick then
  begin
    for I := 0 to FDisplayList.Count - 1 do
    begin
      item := FDisplayList.GetItem(i).FItem;
      if item <> nil then
      begin
        with item do
        begin
          if FGoToNormalState then
          begin
            dx := Abs(FX - FxTo) / 1.5;
            FAnimateX := AnimateDouble(FX, FxTo, dx, 1);

            dy := Abs(FY - FYTo) / 1.5;
            FAnimateY := AnimateDouble(FY, FYTo, dy, 1);

            dw := Abs(FWidth - FWidthTo) / 1.5;
            FAnimateW := AnimateDouble(FWidth, FWidthTo, dw, 1);

            dh := Abs(FHeight - FHeightTo) / 1.5;
            FAnimateH := AnimateDouble(FHeight, FHeightTo, dh, 1);

            if FAnimateX or FAnimateY or FAnimateW or FAnimateH then
              Changed
            else
            begin
              FAnimateDoubleClick := false;
              FDoubleClicked := false;
              FGoToNormalState := false;
              Changed;
              if Assigned(FOnItemZoomedOut) then
                FOnItemZoomedOut(Self, I);
            end;
          end
          else if FDoubleClicked and (FThreadStatus = stLoaded) then
          begin
            nw := 0;
            nh := 0;
            if Rows = 0 then
            begin
              nw := InsideRect.Right - InsideRect.Left - GetScrollBarWidth;
              nh := Round(InsideRect.Bottom - InsideRect.Top - Header.GetHeight - Footer.GetHeight);
            end
            else if Columns = 0 then               
            begin
              nw := InsideRect.Right - InsideRect.Left;
              nh := Round(InsideRect.Bottom - InsideRect.Top - Header.GetHeight - Footer.GetHeight - GetScrollBarHeight);
            end;

            case ZoomMode of
              zmFullScreen:
              begin
                w := nw;
                h := nh;
              end;
              zmAspectRatio: GetAspectSize(w, h, FOriginalImageWidth, FOriginalImageHeight, nw, nh);
            end;

            x := Round((nw - w) / 2);
            y := Header.GetHeight + InsideRect.Top + Round((nh - h) / 2);

            dx := Abs(FX - x) / 1.5;
            FAnimateX := AnimateDouble(FX, x, dx, 1);

            dy := Abs(FY - y) / 1.5;
            FAnimateY := AnimateDouble(FY, y, dy, 1);

            dw := Abs(FWidth - w) / 1.5;
            FAnimateW := AnimateDouble(FWidth, w, dw, 1);

            dh := Abs(FHeight - h) / 1.5;
            FAnimateH := AnimateDouble(FHeight, h, dh, 1);

            if FAnimateX or FAnimateY or FAnimateW or FAnimateH then
              Changed
            else
            begin
              FAnimateDoubleClick := false;
              if Assigned(FOnItemZoomedIn) then
                FOnItemZoomedIn(Self, I);
            end;
          end;
        end;
      end;
    end;
  end;

  Inc(FTimerCount);
  if FTimerCount >= 100 then
  begin
    FLookupKey := '';
    FTimerCount := 0;
  end;  
end;

procedure TAdvSmoothImageListBox.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothImageListBox then
  begin
    FThreadLoading := (Source as TAdvSmoothImageListBox).ThreadLoading;
    FAnimationFactor := (Source as TAdvSmoothImageListBox).AnimationFactor;
    FItems.Assign((Source as TAdvSmoothImageListBox).Items);
    FFill.Assign((Source as TAdvSmoothImageListBox).Fill);
    FTransparent := (Source as TAdvSmoothImageListBox).Transparent;
    FDefaultImage.Assign((Source as TAdvSmoothImageListBox).DefaultImage);
    FRows := (Source as TAdvSmoothImageListBox).Rows;
    FColumns := (Source as TAdvSmoothImageListBox).Columns;
    FSelectedItemIndex := (Source as TAdvSmoothImageListBox).SelectedItemIndex;
    FHeader.Assign((Source as TAdvSmoothImageListBox).Header);
    FFooter.Assign((Source as TAdvSmoothImageListBox).Footer);
    FDefaultHTMLText.Assign((Source as TAdvSmoothImageListBox).DefaultHTMLText);
    FTopLayerItems.Assign((Source as TAdvSmoothImageListBox).TopLayerItems);
    FZoomOnDblClick := (Source as TAdvSmoothImageListBox).ZoomOnDblClick;
    FZoomOnTop := (Source as TAdvSmoothImageListBox).ZoomOnTop;
    FShowScrollBar := (Source as TAdvSmoothImageListBox).ShowScrollBar;
    FKeyBoardLookUp := (Source as TAdvSmoothImageListBox).KeyBoardLookUp;
    FSorted := (Source as TAdvSmoothImageListBox).Sorted;
    FZoomMode := (Source as TAdvSmoothImageListBox).ZoomMode;
    FHover := (Source as TAdvSmoothImageListBox).Hover;
    FMultiSelect := (Source as TAdvSmoothImageListBox).MultiSelect;
    FShowFocus := (Source as TAdvSmoothImageListBox).ShowFocus;
    FFocusColor := (Source as TAdvSmoothImageListBox).FocusColor;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.Changed;
begin
  Invalidate;
end;

procedure TAdvSmoothImageListBox.CMHintShow(var Message: TMessage);
var
  item: integer;
  pt: TPoint;
  dItem: TAdvSmoothImageListBoxItem;
begin
  with TCMHintShow(Message).HintInfo^ do
  begin
    HintStr := self.Hint;
    pt := CursorPos;
    item := FindItemOnXY(pt.X, pt.Y);
    if item <> -1 then
    begin
      dItem := Items[item];
      if dItem <> nil then
      begin
        if dItem.Hint <> '' then
          HintStr := ditem.Hint;
        if Assigned(FOnItemHint) then
          FOnItemHint(Self, item, HintStr);
      end;
    end;

    case FHovF of
      0: Hintstr := Footer.Navigator.HintPreviousPage;
      1: Hintstr := Footer.Navigator.HintPrevious;
      2: Hintstr := Footer.Navigator.HintNext;
      3: Hintstr := Footer.Navigator.HintNextPage;
    end;

    case FHovH of
      0: Hintstr := Header.Navigator.HintPreviousPage;
      1: Hintstr := Header.Navigator.HintPrevious;
      2: Hintstr := Header.Navigator.HintNext;
      3: Hintstr := Header.Navigator.HintNextPage;
    end;

    ReshowTimeout := 0;
  end;
end;

procedure TAdvSmoothImageListBox.CMMouseLeave(var Message: TMessage);
begin
  FHoveredItemIndex := -1;
  Application.CancelHint;
  Changed;
end;

procedure TAdvSmoothImageListBox.CollapseAll;
var
  i: integer;
begin
  for I := 0 to Items.Count - 1 do
    with Items[I] do
      if Splitter then
        SplitterState := stCollapsed;
end;

constructor TAdvSmoothImageListBox.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls];
  FTimerCount := 0;
  FAnimationFactor := 4;
  FFocused := false;
  FShowFocus := true;
  FFocusColor := clBlack;
  DoubleBuffered := true;
  FHoveredItemIndex := -1;
  FAnimateTimer := TTimer.Create(Self);
  FAnimateTimer.Interval := 1;
  FAnimateTimer.OnTimer := Animate;
  FItems := TAdvSmoothImageListBoxItems.Create(Self);
  FItems.OnChange := ItemsChanged;
  FTopLayerItems := TAdvSmoothImageListBoxTopLayerItems.Create(Self);
  FTopLayerItems.OnChange := TopLayerItemsChanged;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FDefaultImage := TAdvGDIPPicture.Create;
  FDefaultImage.OnChange := DefaultImageChanged;
  FItemAppearance := TAdvSmoothImageListBoxItemAppearance.Create(Self);
  FItemAppearance.OnChange := ItemAppearanceChanged;
  Width := 600;
  Height := 450;
  FColumns := 0;
  FRows := 3;
  FThreadLoading := tlOnDemandAfterAnimation;
  FTransparent := false;
  FHeader := TAdvSmoothImageListBoxHeader.Create(Self);
  FHeader.OnChange := HeaderChanged;
  FFooter := TAdvSmoothImageListBoxFooter.Create(Self);
  FFooter.OnChange := FooterChanged;
  FDisplayList := TAdvSmoothImageListBoxDisplayList.Create;
  FDefaultNormal := TGPBitmap.Create;
  FZoomOnDblClick := true;
  FDefaultHTMLText := TAdvSmoothImageListBoxHTMLText.Create(Self);
  FDefaultHTMLText.OnChange := DefaultHTMLTextChanged;
  FScrollBar := TScrollBar.Create(Self);
  FScrollBar.Kind := sbVertical;
  FScrollBar.SmallChange := 20;
  FScrollBar.LargeChange := 40;
  FScrollBar.OnScroll := Scroll;
  FScrollBar.DoubleBuffered := true;
  FScrollBar.Visible := false;
  FScrollBar.Parent := self;
  FZoomOnTop := false;
  FShowScrollBar := true;
  FKeyBoardLookUp := false;
  FSorted := false;
  FHover := true;
  FZoomMode := zmFullScreen;
  FHovF := -1;
  FSelF := -1;
  FHovH := -1;
  FSelH := -1;
  FPaintIndex := -1;
  FMultiSelect := false;
  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));
end;

procedure TAdvSmoothImageListBox.CreateWnd;
begin
  inherited;

  if FDesignTime then
  begin
    InitPreview;
    SetComponentStyle(tsOffice2007Luna);
  end
  else
  begin
    if not ((Rows <> 0) and (Columns <> 0)) then
    begin
      StopThread;
      FThreadDone := false;
      StartThread;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.DblClick;
var
  rc: TRect;
  r: TGPRectF;
begin
  inherited;
  if Assigned(FOnItemDblClick) then
    FOnItemDblClick(Self, FSelectedItemIndex);

  if ZoomOnDblClick then
  begin
    r := GetDisplayRectangle;
    rc := Bounds(Round(r.X), Round(R.Y), Round(R.Width), Round(R.Height));
    if PtInRect(rc, ScreenToClient(Mouse.CursorPos)) then
      DoZoom;
  end;
end;

procedure TAdvSmoothImageListBox.DefaultHTMLTextChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBox.DefaultImageChanged(Sender: TObject);
var
  oh, ow, nh, nw: Double;
  w, h: integer;
  glo: TGPGraphics;
  rimg: TGPRectF;
begin
  if Assigned(FDefaultImage) and not(FDefaultImage.Empty) then
  begin
    FOriginalDefaultWidth := DefaultImage.Width;
    FOriginalDefaultHeight := DefaultImage.Height;
    rimg := GetItemImageRect(MakeRect(0, 0, ItemAppearance.GetColumnWidth, ItemAppearance.GetRowHeight));
    nw := rimg.Width;
    nh := rimg.Height;
    ow := DefaultImage.Width;
    oh := DefaultImage.Height;

    GetAspectSize(w, h, ow, oh, nw, nh);

    if Assigned(FDefaultNormal) then
      FDefaultNormal.Free;

    FDefaultNormal := tgpbitmap.Create(w,h, PixelFormat32bppARGB);
    glo := TGPGraphics.Create(FDefaultNormal);
    FDefaultImage.GDIPDraw(glo, Rect(0, 0, w,h));
    glo.Free;
    if not (csDesigning in ComponentState) then
      FDefaultImage.Assign(nil);
  end;

  if FItems.FUpdateCount = 0 then
  begin
    InitListBoxItems;
    Changed;
  end;
end;

destructor TAdvSmoothImageListBox.Destroy;
begin
  FAnimateTimer.Free;
  if Assigned(FDefaultNormal) then
    FDefaultNormal.Free;
  FItems.Free;
  FTopLayerItems.Free;
  FFill.Free;
  if Assigned(FDefaultImage) then
    FDefaultImage.Free;
  FItemAppearance.Free;
  FHeader.Free;
  FFooter.Free;
  FDisplayList.Free;
  FDefaultHTMLText.Free;
  if not FDesignTime then
    FScrollBar.Free;

  StopThread;    
  inherited;
end;

procedure TAdvSmoothImageListBox.DoEnter;
begin
  inherited;
  FFocused := true;
  Changed;
end;

procedure TAdvSmoothImageListBox.DoExit;
begin
  inherited;
  FhoveredItemIndex := -1;
  Application.CancelHint;
  FFocused := false;
  Changed;
end;

procedure TAdvSmoothImageListBox.DoZoom;
var
  item: integer;
  DItem: TAdvSmoothImageListBoxItem;
  I: Integer;
  AllowZoomIn, AllowZoomOut: Boolean;
begin
  AllowZoomOut := true;
  AllowZoomIn := true;
  if not GetItemIsDblClicked then
  begin
    item := FSelectedItemIndex;
    if (item >= 0) and (item <= Items.Count - 1) then
    begin
      with Items[item] do
      begin
        if Items[item].Enabled then
        begin
          if Assigned(FOnItemZoomIn) then
            FOnItemZoomIn(Self, item, AllowZoomIn);

          if AllowZoomIn then
          begin
            if Assigned(FCachedNormal) then
            begin
              FDoubleClicked := true;            
              if FUseThreading then
              begin
                if (FCachedNormal.Width < FOriginalImageWidth) and (FCachedNormal.Height < FOriginalImageHeight) then
                begin
                  FThreadStatus := stInitialized;
                  FOwner.FRestartLoop := true;
                  FOwner.FStartImage := item;
                end;
              end;
            FAnimateDoubleClick := true;
            end;
          end;
        end;
      end;
    end;
  end
  else
  begin
    for I := 0 to FDisplayList.Count - 1 do
    begin
      Ditem := FDisplayList.GetItem(I).FItem;
      if ditem <> nil then
      begin
        with Ditem do
        begin
          if FDoubleClicked then
          begin
            if Assigned(FOnItemZoomOut) then
              FOnItemZoomOut(Self, I, AllowZoomOut);

            if AllowZoomOut then
              FGoToNormalState := true;
          end;
        end;
      end;
    end;

    FAnimateDoubleClick := true;
  end;

  Changed;  
end;

procedure TAdvSmoothImageListBox.DrawBackGround;
var
  g: TGPGraphics;
  rc: TRect;
begin
  if not Transparent then
  begin
    g := TGPGraphics.Create(Canvas.Handle);
    if (fill.RoundingType <> rtNone) and (fill.Rounding > 0) then    
      g.SetSmoothingMode(SmoothingModeAntiAlias);
      
    rc := InsideRect;
    if (Fill.BorderColor = clNone) or (Fill.BorderWidth = 0) then
    begin
      rc.Right := rc.Right + 1;
      rc.Bottom := rc.Bottom + 1;
    end;

    fill.Fill(g, MakeRect(rc.Left, rc.Top, rc.Right - rc.Left, rc.Bottom - rc.Top));
    g.Free;
  end;
end;

procedure TAdvSmoothImageListBox.DrawDefaultImage(item: integer; g: TGPGraphics; r: TGPRectF);
var
  x, y: Single;
  imgw, imgh: integer;
  rimg: TGPRectF;
  pt: TGPPointF;
begin
  if Assigned(FDefaultNormal) then
  begin
    if not((FDefaultNormal.Width = 0) and (FDefaultNormal.Height = 0)) then
    begin
      //IMAGE
      imgw := FDefaultNormal.Width;
      imgh := FDefaultNormal.Height;
      rimg := GetItemImageRect(r);
      if (rimg.Width > 0) and (rimg.Height > 0) then
      begin
        GetAspectSize(imgw, imgh, imgw, imgh, rimg.Width, rimg.Height);
        x := rimg.X + (rimg.Width - imgw) / 2;
        y := rimg.Y + (rimg.Height - imgh) / 2;
        pt := MakePoint(x, y);
        if (imgw > 0) and (imgh > 0) then
          g.DrawImage(FDefaultNormal, x, y, imgw, imgh);
      end;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.DrawDisplayItems(g: TGPGraphics);
var
  i: integer;
  h: TAdvSmoothImageListBoxHTMLText;
  item: TAdvSmoothImageListBoxItem;
begin
  h := TAdvSmoothImageListBoxHTMLText.Create(Self);
  h.FDisableRepaint := true;  
  h.FLocation := ItemAppearance.Splitter.FTextLocation;
  h.FFont.Assign(FItemAppearance.FSplitter.FTextFont);
  h.FDisableRepaint := false;  

  for I := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      item := FItem;
      if item <> nil then
      begin
        if GetItemIsVisible(Rectangle) then
        begin
          //DRAW IMAGE OR SPLITTER
          case Kind of
            ikSplitter:
            begin
              h.FDisableRepaint := true;
              h.FText := item.SplitterText;
              h.FDisableRepaint := false;
              if (ItemAppearance.Splitter.Fill.Rounding > 0) and (ItemAppearance.Splitter.Fill.RoundingType <> rtNone) then
                g.SetSmoothingMode(SmoothingModeAntiAlias);

              item.DrawSplitter(g, h, Rectangle);

              g.SetSmoothingMode(SmoothingModeDefault);
            end;
            ikItem:
            begin
              if (Rectangle.Width > 0) and (Rectangle.Height > 0) then
              begin
                FPaintIndex := I;
                if not item.FDoubleClicked then
                  item.Draw(g, Rectangle, item.FDoubleClicked);
                FPaintIndex := -1;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  
  h.Free;
end;

procedure TAdvSmoothImageListBox.DrawFill(g: TGPGraphics);
var
  i: integer;
  r: TGPRectF;
  focustopitem: Boolean;
begin
  for I := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      if GetItemIsVisible(Rectangle) then
      begin
        //DRAW IMAGE FILL
        case Kind of
          ikItem:
          begin
            with DisplayItem do
            begin
              focustopitem := (FFocusedItemIndex = Index);
              R := Rectangle;
              if (r.Width > 0) and (r.Height > 0) then
              begin
                with ItemAppearance do
                begin
                  if not FEnabled then
                  begin
                    if (FDisabledFill.RoundingType <> rtNone) and (FDisabledFill.Rounding > 0) then
                      g.SetSmoothingMode(SmoothingModeAntiAlias);

                    if Assigned(FCachedDisabledFill) then
                      g.DrawImage(FCachedDisabledFill, R.X, R.Y, R.Width, R.Height);

                    g.SetSmoothingMode(SmoothingModeDefault);
                  end
                  else
                  begin
                    if (FSelectedItemIndex = Index) or (MultiSelect and Selected) then
                    begin
                      if (FHoveredItemIndex = Index) and Hover then
                      begin
                        R.X := R.X - (FHoverSize / 2);
                        R.Y := R.Y - (FHoverSize / 2);
                        R.Width := R.Width + FHoverSize;
                        R.Height := R.Height + FHoverSize;
                      end;

                      if (FSelectedFill.RoundingType <> rtNone) and (FSelectedFill.Rounding > 0) then
                        g.SetSmoothingMode(SmoothingModeAntiAlias);

                      if Assigned(FCachedSelectedFill) then
                        g.DrawImage(FCachedSelectedFill, R.X, R.Y, R.Width, R.Height);

                      if focustopitem then
                        DrawFocusRect(FSelectedFill, g, FSelectedFill.FocusRect, r);

                      g.SetSmoothingMode(SmoothingModeDefault);
                    end
                    else if (FHoveredItemIndex = Index) and Hover then
                    begin
                      R.X := R.X - (FHoverSize / 2);
                      R.Y := R.Y - (FHoverSize / 2);
                      R.Width := R.Width + FHoverSize;
                      R.Height := R.Height + FHoverSize;

                      if (FHoverFill.RoundingType <> rtNone) and (FHoverFill.Rounding > 0) then
                        g.SetSmoothingMode(SmoothingModeAntiAlias);

                      if Assigned(FCachedHoveredFill) then
                        g.DrawImage(FCachedHoveredFill, R.X, R.Y, R.Width, R.Height);

                      if focustopitem then
                        DrawFocusRect(FHoverFill, g, FHoverFill.FocusRect, r);

                      g.SetSmoothingMode(SmoothingModeDefault);
                    end
                    else
                    begin
                      if (FFill.RoundingType <> rtNone) and (FFill.Rounding > 0) then
                        g.SetSmoothingMode(SmoothingModeAntiAlias);

                      if Assigned(FCachedFill) then
                        g.DrawImage(FCachedFill, R.X, R.Y, R.Width, R.Height);

                      if focustopitem then
                        DrawFocusRect(FFill, g, FFill.FocusRect, r);

                      g.SetSmoothingMode(SmoothingModeDefault);
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.DrawFooter;
var
  g: TGPGraphics;
  rc: TRect;
  x, y: integer;
  xs, ys: single;
  fillr, sri: TGPRectF;
  sf: TGPStringFormat;
  f: TGPFont;
  ff: TGPFontFamily;
  fs: Integer;
  b: TGPSolidBrush;
  pt: TGPPointF;
  r: TGPRectF;
begin
  with Footer do
  begin
    if Visible then
    begin
      g := TGPGraphics.Create(Canvas.Handle);
      g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
      if (fill.RoundingType <> rtNone) and (fill.Rounding > 0) then
        g.SetSmoothingMode(SmoothingModeAntiAlias);
      
      rc := InsideRect;
      fillr := GetRect;

      Fill.Fill(g, fillr);

      ff := TGPFontFamily.Create(Font.Name);
      if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
      begin
        ff.Free;
        ff := TGPFontFamily.Create('Arial');
      end;

      fs := 0;
      if (fsBold in Font.Style) then
        fs := fs + 1;
      if (fsItalic in Font.Style) then
        fs := fs + 2;
      if (fsUnderline in Font.Style) then
        fs := fs + 4;

      sf := TGPStringFormat.Create;
      f := TGPFont.Create(ff, Font.Size, fs, UnitPoint);
      b := TGPSolidBrush.Create(ColorToARGB(Font.Color));
      g.MeasureString(Caption, length(Caption), f, fillr, sf, sri);

      if CaptionLocation <> cpCustom then
        GetObjectLocation(x, y, fillr, Round(sri.Width), Round(sri.Height), CaptionLocation)
      else
      begin
        x := CaptionLeft;
        y := CaptionTop;
      end;

      xs := x;
      ys := y;
      pt := MakePoint(xs, ys);
      g.DrawString(Caption, Length(Caption), f, pt, sf, b);


      b.Free;
      f.Free;
      sf.Free;
      ff.Free;
      g.Free;


      with Navigator do
      begin
        //NavigatorButtons
        if Navigator.Visible then
        begin
          r := GetNavigatorRect(fillr);
          Draw(r, FHovF, FSelF);
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.DrawHeader;
var
  g: TGPGraphics;
  x, y: integer;
  xs, ys: single;
  fillr, sri: TGPRectF;
  sf: TGPStringFormat;
  f: TGPFont;
  ff: TGPFontFamily;
  fs: Integer;
  b: TGPSolidBrush;
  pt: TGPPointF;
  r: TGPRectF;
begin
  with Header do
  begin
    if Visible then
    begin
      g := TGPGraphics.Create(Canvas.Handle);
      g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
      if (fill.RoundingType <> rtNone) and (fill.Rounding > 0) then
        g.SetSmoothingMode(SmoothingModeAntiAlias);

      fillr := GetRect;

      Fill.Fill(g, fillr);

      ff := TGPFontFamily.Create(Font.Name);
      if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
      begin
        ff.Free;
        ff := TGPFontFamily.Create('Arial');
      end;

      fs := 0;
      if (fsBold in Font.Style) then
        fs := fs + 1;
      if (fsItalic in Font.Style) then
        fs := fs + 2;
      if (fsUnderline in Font.Style) then
        fs := fs + 4;

      sf := TGPStringFormat.Create;
      f := TGPFont.Create(ff, Font.Size, fs, UnitPoint);
      b := TGPSolidBrush.Create(ColorToARGB(Font.Color));
      g.MeasureString(Caption, length(Caption), f, fillr, sf, sri);

      if CaptionLocation <> cpCustom then
        GetObjectLocation(x, y, fillr, Round(sri.Width), Round(sri.Height), CaptionLocation)
      else
      begin
        x := CaptionLeft;
        y := CaptionTop;
      end;

      xs := x;
      ys := y;
      pt := MakePoint(xs, ys);
      g.DrawString(Caption, Length(Caption), f, pt, sf, b);


      b.Free;
      f.Free;
      sf.Free;
      ff.Free;
      g.Free;


      with Navigator do
      begin
        //NavigatorButtons
        if Navigator.Visible then
        begin
          r := GetNavigatorRect(fillr);
          Draw(r, FHovH, FSelH);
        end;
      end;      
    end;
  end;
end;

procedure TAdvSmoothImageListBox.DrawHTML(g: TGPGraphics);
var
  i: integer;
  str: string;
  rtext: TGPRectF;
  item: TAdvSmoothImageListBoxItem;
  r: TGPRectF;
begin
  for I := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      if GetItemIsVisible(Rectangle) then
      begin
        item := FItem;
        case Kind of
          ikItem:
          begin
            if item <> nil then
            begin
              with item do
              begin
                r := Rectangle;
                if (r.Width > 0) and (r.Height > 0) then
                begin
                  if (FHoveredItemIndex = Index) and Hover then
                  begin
                    R.X := R.X - (FOwner.FItemAppearance.FHoverSize / 2);
                    R.Y := R.Y - (FOwner.FItemAppearance.FHoverSize / 2);
                    R.Width := R.Width + FOwner.FItemAppearance.FHoverSize;
                    R.Height := R.Height + FOwner.FItemAppearance.FHoverSize;
                  end;

                  //DRAW HTML TEXT
                  rtext := GetItemTextRect(r);
                  if (rtext.Width > 0) and (rtext.Height > 0) then
                  begin
                    if (FThreadStatus = stLoaded) and (Caption.Text <> '') then
                    begin
                      str := FCaption.Text;

                      if (FMarkTag <> '') then
                      begin
                        str := Hilight(FCaption.Text, FMark, FMarkTag, FMarkCase);
                      end;

                      if Assigned(FOnItemGetDisplayText) then
                        FOnItemGetDisplayText(Self, DisplayItem.Index, str);

                      DrawHTMLText(g, FCaption, rtext, str);
                    end
                    else if (FDefaultHTMLText.Text <> '') then
                    begin
                      //DEFAULT HTML TEXT
                      str := FDefaultHTMLText.Text;

                      if Assigned(FOnItemGetDisplayText) then
                        FOnItemGetDisplayText(Self, DisplayItem.Index, str);

                      DrawHTMLText(g, FDefaultHTMLText, rtext, str);
                    end
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothImageListBox.DrawHTMLText(g: TGPGraphics; HTML: TAdvSmoothImageListBoxHTMLText; r: TGPRectF;
  str: String; DoAnchor: Boolean = false; fX: integer = -1; fY: integer = -1): String;
var
  htmlr: TRect;
  a, s, k: String;
  l, m, XSize, YSize: integer;
  hr: TRect;
  x, y: integer;
begin
  with HTML do
  begin
    if str <> '' then
    begin
      htmlr := Rect(0, 0, Round(r.Width), Round(r.Height));

      HTMLDrawGDIP(g, FFont, str,htmlr,FImages, 0,0,-1,-1,FShadowOffset,False,true,false,false,
        False,False,true,1.0,FURLColor,clNone,clNone,FShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

      if FLocation <> cpCustom then
        GetObjectLocation(x, y, r, XSize, YSize, FLocation)
      else
      begin
        x := FLeft;
        y := FTop;
      end;

      htmlr := Bounds(Round(x), Round(y), xsize, ysize);

      HTMLDrawGDIP(g, FFont, str,htmlr,FImages, fx,fy,-1,-1,FShadowOffset,DoAnchor,false,false,false,
        False,False,true,1.0,FURLColor,clNone,clNone,FShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

      result := a;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.DrawItems;
var
  g: TGPGraphics;
  rc: TRect;
  rgn, rgnor: HRGN;
begin
  if ((Rows = 0) and (Columns = 0)) or (FDisplayList.Count = 0) or (Items.Count = 0) then
    exit;

  rc := InsideRect;
  rgnor := CreateRectRgn(0, 0, ClientWidth, ClientHeight);
  rgn := CreateRectRgn(rc.Left + 1, rc.Top + 1, rc.Right - rc.Left - 1 - GetShadowOffset, rc.Bottom - rc.Top - 1 - GetShadowOffset);
  SelectObject(Canvas.Handle, rgn);
  g := TGPGraphics.Create(Canvas.Handle);

  //Fill
  DrawFill(g);
  //HTML
  if ItemAppearance.TextVisible then
    DrawHTML(g);
  //Display Items
  if Itemappearance.ImageVisible then
    DrawDisplayItems(g);

  g.Free;

  if (not ZoomOnTop) and Itemappearance.ImageVisible then
    DrawZoomedItem;

  DeleteObject(rgn);
  //set to full region
  SelectObject(Canvas.Handle, rgnor);
  DeleteObject(rgnor);
end;

procedure TAdvSmoothImageListBox.DrawText(g: TGPGraphics;
  HTML: TAdvSmoothImageListBoxHTMLText; r: TGPRectF; str: String);
var
  x, y: integer;
  ff: TGPFontFamily;
  fs: integer;
  sf: TGPStringFormat;
  b: TGPSolidBrush;
  f: TGPFont;
  sri: TGPRectF;
  xs, ys: single;
  pt: TGPPointF;
  loc: TAdvSmoothImageListBoxLocation;
begin
  with HTML do
  begin
    if (str <> '') then
    begin
      g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);    

      ff := TGPFontFamily.Create(FFont.Name);
      if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
      begin
        ff.Free;
        ff := TGPFontFamily.Create('Arial');
      end;

      fs := 0;
      if (fsBold in FFont.Style) then
        fs := fs + 1;
      if (fsItalic in FFont.Style) then
        fs := fs + 2;
      if (fsUnderline in FFont.Style) then
        fs := fs + 4;

      sf := TGPStringFormat.Create(StringFormatFlagsDirectionVertical);
      f := TGPFont.Create(ff, FFont.Size, fs, UnitPoint);
      b := TGPSolidBrush.Create(ColorToARGB(FFont.Color));
      g.MeasureString(str, length(str), f, r, sf, sri);

      loc := FLocation;
      if Fowner.Columns = 0 then
      begin
        case FLocation of
          cpTopLeft: loc := cpTopRight;
          cpTopCenter: loc := cpCenterRight;
          cpTopRight: loc := cpBottomRight;
          cpCenterLeft: loc := cpTopCenter;
          cpCenterCenter: loc := cpCenterCenter;
          cpCenterRight: loc := cpBottomCenter;
          cpBottomLeft: loc := cpTopLeft;
          cpBottomCenter: loc := cpCenterLeft;
          cpBottomRight: loc := cpBottomLeft;
          cpCustom: loc := cpCustom;
        end;
      end;

      if loc <> cpCustom then
        GetObjectLocation(x, y, r, Round(sri.Width), Round(sri.Height), loc)
      else
      begin
        x := FLeft;
        y := FTop;
      end;

      xs := x;
      ys := y;

      GetObjectLocation(x, y, MakeRect(xs, ys, Round(sri.Width), Round(sri.Height)), Round(sri.Width), Round(sri.Height), cpCenterCenter);

      xs := x;
      ys := y;

      pt := MakePoint(xs, ys);
      g.DrawString(str, Length(str), f, pt, sf, b);

      b.Free;
      f.Free;
      sf.Free;
      ff.Free;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.DrawTopLayerItems;
var
  g: TGPGraphics;
  i: integer;
  r: TGPRectF;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  r := GetDisplayRectangle;
  for I := 0 to FTopLayerItems.Count - 1 do
    FTopLayerItems[I].Draw(g, r);
  g.Free;
end;

procedure TAdvSmoothImageListBox.DrawZoomedItem;
var
  i: integer;
  g: TGPGraphics;
  item: TAdvSmoothImageListBoxItem;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  for I := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      item := FDisplayList.GetItem(i).FItem;
      if item <> nil then
      begin
        case Kind of
          ikItem:
          if FItem.FDoubleClicked then
          begin
            FPaintIndex := I;
            FItem.Draw(g, Rectangle, FItem.FDoubleClicked);
            FPaintIndex := -1;
          end;
        end;
      end;
    end;
  end;
  g.Free;
end;

procedure TAdvSmoothImageListBox.ExpandAll;
var
  i: integer;
begin
  for I := 0 to Items.Count - 1 do
    with Items[I] do
      if Splitter then
        SplitterState := stExpanded;
end;

function TAdvSmoothImageListBox.ExpanderButton(X, Y: integer; r: TGPRectF; item: TAdvSmoothImageListBoxItem; var State: integer): integer;
var
  rtext, rTextArea: TGPRectF;
  g: TGPGraphics;
  h: TAdvSmoothImageListBoxHTMLText;
begin
  state := -1;
  Result := -1;
  g := TGPGraphics.Create(Canvas.Handle);
  with ItemAppearance.Splitter do
  begin
    with item do
    begin
      rtextArea := Getrect(r);

      h := TAdvSmoothImageListBoxHTMLText.Create(Self);
      h.FDisableRepaint := true;
      h.FLocation := FTextLocation;
      h.FFont.Assign(FTextFont);
      h.FText := FSplitterText;
      h.FDisableRepaint := false;

      if Fowner.Rows = 0 then
        rText := FOwner.GetHTMLTextRect(g, h, rTextArea, SplitterText)
      else if FOwner.Columns = 0 then
        rText := FOwner.GetTextRect(g, h, rTextArea, SplitterText);

      ExpanderTextRect(g, rText, rTextArea);

      r := ItemAppearance.Splitter.GetExpanderRect(rTextArea);
      if PtInRect(Bounds(Round(R.X), Round(R.Y), Round(R.Width), Round(R.Height)), Point(X, Y)) then
      begin
        Result := 1;
        State := 1;
      end;

      h.Free;
    end;
  end;
  g.free;
end;

procedure TAdvSmoothImageListBox.FillChanged(Sender: TObject);
begin
  InitListBoxItems;
  Changed;
end;

function TAdvSmoothImageListBox.FindItemOnXY(X, Y: integer): integer;
var
  I: Integer;
  item: TAdvSmoothImageListBoxItem;
  r: TGPRectF;
begin
  result := -1;
  r := GetDisplayRectangle;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    item := FDisplayList.GetItem(i).FItem;
    if item <> nil then
    begin
      with item do
      begin
        if not Splitter and Enabled then
        begin
          if PtInRect(Bounds(Round(FDisplayList.GetItem(i).Rectangle.X), Round(FDisplayList.GetItem(i).Rectangle.Y),
            Round(FDisplayList.GetItem(i).Rectangle.Width), Round(FDisplayList.GetItem(i).Rectangle.Height)), Point(X, Y)) and
            PtInRect(Bounds(Round(r.X), Round(R.Y), Round(R.Width), Round(R.Height)), Point(X, Y)) then
          begin
            result := Index;
            break;
          end;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.FooterChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothImageListBox.GetAnchorAt(X, Y: integer): TItemAnchor;
var
  itemindex: integer;
  g: TGPGraphics;
  str: String;
begin
  itemindex := FindItemOnXY(X, Y);
  if (itemindex >= 0) and (itemindex <= Items.Count - 1) then
  begin
    with Items[itemindex] do
    begin
      g := TGPGraphics.Create(Canvas.Handle);
      if (FThreadStatus = stLoaded) and (Caption.Text <> '') then
      begin
        str := Caption.Text;
        Result.anchor := DrawHTMLText(g, Caption, GetItemTextRect(GetItemRectangleOnXY(X, Y)), str, true, X, Y);
      end
      else if (FDefaultHTMLText.Text <> '') then
      begin
        str := FDefaultHTMLText.Text;
        Result.anchor := DrawHTMLText(g, DefaultHTMLText, GetItemTextRect(GetItemRectangleOnXY(X, Y)), str, true, X, Y);
      end;

      result.itemindex := itemindex;

      g.Free;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.GetAspectSize(var w, h: integer; ow, oh, nw, nh: double);
begin
  if ItemAppearance.AspectRatio then
  begin
    if (ow > 0) and (oh > 0) and (nw > 0) and (nh > 0) then
    begin
      if (ow < nw) and (oh < nh) and (ItemAppearance.Stretch = isShrinkOnly) then
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

function TAdvSmoothImageListBox.GetRowCount: integer;
var
  y: single;
  i: integer;
begin
  Result := 0;
  y := 0;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    if FDisplayList.GetItem(i).Rectangle.Y <> y then
    begin
      y := FDisplayList.GetItem(i).Rectangle.Y;
      Inc(Result);
    end;
  end;
end;

function TAdvSmoothImageListBox.GetDisplayRectangle: TGPRectF;
var
  hb, fb, scrl: integer;
begin
  hb := 0;
  if (Header.Fill.BorderColor <> clNone) and Header.Visible then
    hb := Header.Fill.BorderWidth;

  fb := 0;
  if (Footer.Fill.BorderColor <> clNone) and Footer.Visible then
    fb := Footer.Fill.BorderWidth;

  scrl := 0;
  case FScrollBar.Kind of
    sbHorizontal: scrl := GetScrollBarHeight;
    sbVertical: scrl := GetScrollBarWidth;
  end;
  
  if Rows = 0 then
  begin
    Result := MakeRect(InsideRect.Left, InsideRect.Top + Header.GetHeight + hb, InsideRect.Right - InsideRect.Left - GetShadowOffset - scrl,
      InsideRect.Bottom - InsideRect.Top - Footer.GetHeight - fb - hb - GetShadowOffset - Header.GetHeight);
  end
  else
  begin
    Result := MakeRect(InsideRect.Left, InsideRect.Top + Header.GetHeight + hb, InsideRect.Right - InsideRect.Left - GetShadowOffset,
      InsideRect.Bottom - InsideRect.Top - Footer.GetHeight - fb - hb - GetShadowOffset - Header.GetHeight - scrl);
  end;
end;

function TAdvSmoothImageListBox.GetFirstVisibleItem: integer;
var
  item: TAdvSmoothImageListBoxItem;
  i: integer;
begin
  result := 0;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      item := FDisplayList.GetItem(i).FItem;
      if item <> nil then
      begin
        if GetItemIsVisible(Rectangle) and item.Enabled and (item.Splitter = false) then
        begin
          result := I;
          break;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothImageListBox.GetFullSize: integer;
begin
  result := 0;
  if Rows = 0 then
  begin
    if FDisplayList.Count > 0 then
      Result := Round(FDisplayList.GetItem(FDisplayList.Count - 1).Rectangle.Y + ItemAppearance.GetRowHeight +
         FCurrentScPos + ItemAppearance.ItemVerticalSpacing);

    Result := Max(0, Result - Height + Footer.GetHeight + GetShadowOffset);
  end
  else if Columns = 0 then
  begin
    if FDisplayList.Count > 0 then
      Result := Round(FDisplayList.GetItem(FDisplayList.Count - 1).Rectangle.X + ItemAppearance.GetColumnWidth +
        FCurrentScPos + ItemAppearance.ItemHorizontalSpacing);

    Result := Max(0, Result - Width + GetShadowOffset);
  end;
end;

function TAdvSmoothImageListBox.GetHTMLTextRect(g: TGPGraphics;
  HTML: TAdvSmoothImageListBoxHTMLText; r: TGPRectF; str: String): TGPRectF;
var
  htmlr: TRect;
  a, s, k: String;
  l, m, XSize, YSize: integer;
  hr: TRect;
  x, y: integer;
begin
  with HTML do
  begin
    if FText <> '' then
    begin
      htmlr := Rect(0, 0, Round(r.Width), Round(r.Height));

      HTMLDrawGDIP(g, FFont, str,htmlr,FImages, 0,0,-1,-1,FShadowOffset,False,true,false,false,
        False,False,true,1.0,FURLColor,clNone,clNone,FShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

      if FLocation <> cpCustom then
        GetObjectLocation(x, y, r, XSize, YSize, FLocation)
      else
      begin
        x := FLeft;
        y := FTop;
      end;

      result := MakeRect(x, y, xsize, ysize);
    end;
  end;
end;

function TAdvSmoothImageListBox.GetImageHeight: integer;
begin
  result := 0;
  with ItemAppearance do
  begin
    if FImageVisible then
      Result := FImageHeight;
  end;
end;

function TAdvSmoothImageListBox.GetImageWidth: integer;
begin
  result := 0;
  with ItemAppearance do
  begin
    if FImageVisible then
      Result := FImageWidth;
  end;
end;

function TAdvSmoothImageListBox.GetItemImageRect(r: TGPRectF): TGPRectF;
begin
  with ItemAppearance do
  begin
    Result.X := r.X + ImageMargin.Left;
    Result.Y := r.Y + ImageMargin.Top;
    Result.Width := r.Width - ImageMargin.Right - ImageMargin.Left - 1;
    Result.Height := r.Height - ImageMargin.Bottom - ImageMargin.Top - 1;
    case ImageAlign of
      alTop:
      begin
        case TextAlign of
          alTop:
          begin
            Result.Y := Result.Y;
            Result.Height := GetImageHeight;
          end;
          alNone, alCustom, alClient, alRight, alLeft, alBottom: Result.Height := GetImageHeight;
        end;
      end;
      alBottom:
      begin
        Result.Y := Result.Y + Result.Height - GetImageHeight;
        Result.Height := GetImageHeight;
      end;
      alLeft:
      begin
        case TextAlign of
          alBottom:
          begin
            Result.Height := Result.Height - GetTotalTextHeight;
            Result.Width := GetImageHeight;
          end;
          alTop:
          begin
            Result.Y := Result.Y + GetTotalTextHeight;
            Result.Height := Result.Height - GetTotalTextHeight;
            Result.Width := GetImageWidth;
          end;
          alLeft, alClient, alCustom, alNone, alRight: Result.Width := GetImageWidth;
        end;
      end;
      alRight:
      begin
        case TextAlign of
          alBottom:
          begin
            Result.Height := Result.Height - GetTotalTextHeight;
            Result.X := Result.X + Result.Width - GetImageWidth;
            Result.Width := GetImageHeight;
          end;
          alTop:
          begin
            Result.Y := Result.Y + GetTotalTextHeight;
            Result.Height := Result.Height - GetTotalTextHeight;
            Result.X := Result.X + Result.Width - GetImageWidth;            
            Result.Width := GetImageWidth;
          end;
          alLeft, alClient, alCustom, alNone, alRight:
          begin
            Result.X := Result.X + Result.Width - GetImageWidth;
            Result.Width := GetImageWidth;
          end;
        end;
      end;
      alClient:
      begin
        case TextAlign of
          alTop:
          begin
            Result.Y := Result.Y + GetTotalTextHeight;
            Result.Height := Result.Height - GetTotalTextHeight;
          end;
          alBottom:
          begin
            Result.Height := Result.Height - GetTotalTextHeight;
          end;
          alLeft:
          begin
            Result.X := Result.X + GetTotalTextWidth;
            Result.Width := Result.Width - GetTotalTextWidth
          end;
          alRight: Result.Width := Result.Width - GetTotalTextWidth;
        end;
      end;
      alNone, alCustom:
      begin
        Result.X := Result.X + ImageLeft;
        Result.Y := Result.Y + ImageTop;
        Result.Width := GetImageWidth;
        Result.Height := GetImageHeight;
      end;
    end;
  end;
end;

function TAdvSmoothImageListBox.GetItemIsDblClicked: Boolean;
var
  i: integer;
  item: TAdvSmoothImageListBoxItem;
begin
  result := false;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    item := FDisplayList.GetItem(I).FItem;
    if item <> nil then
    begin
      if item.FDoubleClicked then
      begin
        result := true;
        break;
      end;
    end;
  end;
end;

function TAdvSmoothImageListBox.GetItemIsVisible(r: TGPRectF): Boolean;
begin
  Result := (R.Y > -R.Height) and (R.Y + R.Height < Height + R.Height)
    and (R.X > -R.Width) and (R.X + R.Width < Width + R.Width)
end;

function TAdvSmoothImageListBox.GetItemRectangleOnXY(X, Y: integer): TGPRectF;
var
  i: integer;
  item: TAdvSmoothImageListBoxItem;
  r: TGPRectF;
begin
  r := GetDisplayRectangle;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    item := FDisplayList.GetItem(i).FItem;
    if item <> nil then
    begin
      with item do
      begin
        if not Splitter and Enabled then
        begin
          if PtInRect(Bounds(Round(FDisplayList.GetItem(i).Rectangle.X), Round(FDisplayList.GetItem(i).Rectangle.Y),
            Round(FDisplayList.GetItem(i).Rectangle.Width), Round(FDisplayList.GetItem(i).Rectangle.Height)), Point(X, Y)) and
            PtInRect(Bounds(Round(r.X), Round(R.Y), Round(R.Width), Round(R.Height)), Point(X, Y)) then
          begin
            Result := FDisplayList.GetItem(I).Rectangle;
            break;
          end;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothImageListBox.GetItemTextRect(r: TGPRectF): TGPRectF;
begin
  with ItemAppearance do
  begin
    Result.X := r.X + TextMargin.Left;
    Result.Y := r.Y + TextMargin.Top;
    Result.Width := r.Width - TextMargin.Right - TextMargin.Left - 1;
    Result.Height := r.Height - TextMargin.Bottom - TextMargin.Top - 1;
    case TextAlign of
      alTop:
      begin
        case ImageAlign of
          alTop:
          begin
            Result.Y := Result.Y + GetTotalImageHeight;
            Result.Height := GetTextHeight;
          end;
          else Result.Height := GetTextHeight;
        end;
      end;
      alBottom:
      begin
        case ImageAlign of
          alBottom:
          begin
            Result.Y := Result.Y + Result.Height - GetTextHeight - GetTotalImageHeight;
            Result.Height := GetTextHeight;
          end;
          else
          begin
            Result.Y := Result.Y + result.Height - GetTextHeight;
            Result.Height := GetTextHeight;
          end;
        end;
      end;
      alLeft:
      begin
        case ImageAlign of
          alTop:
          begin
            Result.Y := Result.Y + GetTotalImageHeight;
            Result.Height := Result.Height - GetTotalImageHeight;
            Result.Width := GetTextWidth;
          end;
          alBottom:
          begin
            Result.Height := Result.Height - GetTotalImageHeight;
            Result.Width := GetTextWidth;
          end;
          alLeft:
          begin
            Result.X := Result.X + GetTotalImageWidth;
            Result.Width := GetTextWidth;
          end;
          alNone, alClient, alCustom, alRight: Result.Width := GetTextWidth;
        end;
      end;
      alRight:
      begin
        case ImageAlign of
          alTop:
          begin
            Result.Y := Result.Y + GetTotalImageHeight;
            Result.Height := Result.Height - GetTotalImageHeight;
            Result.X := Result.X + Result.Width - GetTextWidth;
            Result.Width := GetTextWidth;
          end;
          alBottom:
          begin
            Result.Height := Result.Height - GetTotalImageHeight;
            Result.X := Result.X + Result.Width - GetTextWidth;
            Result.Width := GetTextWidth;
          end;
          alNone, alCustom, alClient, alLeft:
          begin
            Result.X := Result.X + Result.Width - GetTextWidth;
            Result.Width := GetTextWidth;
          end;
          alRight:
          begin
            Result.X := Result.X + Result.Width - GetTextWidth - GetTotalImageWidth;
            Result.Width := GetTextWidth;
          end;
        end;
      end;
      alClient:
      begin
        case ImageAlign of
          alTop:
          begin
            Result.Y := Result.Y + GetTotalImageHeight;
            Result.Height := Result.Height - GetTotalImageHeight;
          end;
          alBottom: Result.Height := Result.Height - GetTotalImageHeight;
          alLeft:
          begin
            Result.X := Result.X + GetTotalImageWidth;
            Result.Width := Result.Width - GetTotalImageWidth;
          end;
          alRight:
          begin
            Result.Width := Result.Width - GetTotalImageWidth;
          end;
        end;
      end;
      alNone, alCustom:
      begin
        Result.X := Result.X + TextLeft;
        Result.Y := Result.Y + TextTop;
        Result.Width := GetTextWidth;
        Result.Height := GetTextHeight;
      end;
    end;
  end;
end;

function TAdvSmoothImageListBox.GetLastVisibleItem: integer;
var
  i: integer;
  item: TAdvSmoothImageListBoxItem;
begin
  result := 0;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      item := FItem;
      if Item <> nil then
      begin
        if GetItemIsVisible(Rectangle) and FItem.Enabled and (FItem.Splitter = false) then
        begin
          result := I;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothImageListBox.GetOuterBorderWidth: integer;
begin
  Result := 0;
  if (Fill.BorderColor <> clNone) and not Transparent then
    Result := Fill.BorderWidth;
end;

function TAdvSmoothImageListBox.GetPosition: integer;
begin
  if not (csDesigning in ComponentState) then
  begin
    if FCurrentScPos < -50 then
      FCurrentScPos := -50

    else if FCurrentScPos > GetFullSize + 50 then
      FCurrentScPos := GetFullSize + 50;

    result := FCurrentScPos;
  end
  else
    Result := 0;


  if Rows = 0 then
  begin
    if (GetFullSize + Height < Height) or (GetFullSize = 0) then
    begin
      result := 0;
      FCurrentScPos := 0;
      FScPosTo := 0;
    end;
  end
  else if Columns = 0 then
  begin
    if (GetFullSize + Width < Width) or (GetFullSize = 0) then
    begin
      result := 0;
      FCurrentScPos := 0;
    end;
  end;

  if Rows = 0 then
  begin
    if GetRowCount = 1 then
    begin
      FCurrentScPos := 0;
      Result := 0;
    end;
  end
  else if Columns = 0 then
  begin
    if GetColumnCount = 1 then
    begin
      FCurrentScPos := 0;
      Result := 0;
    end;
  end;

end;

function TAdvSmoothImageListBox.GetPositionTo: integer;
begin
  if not (csDesigning in ComponentState) then
  begin
    if FScPosTo < 0 then
      FscposTo := 0

    else if FScPosTo > GetFullSize then
      FscposTo := GetFullSize;

    result := FScPosTo;
  end
  else
    Result := 0;
end;

function TAdvSmoothImageListBox.GetColumnCount: integer;
var
  x: single;
  i: integer;
begin
  Result := 0;
  x := 0;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    if FDisplayList.GetItem(i).Rectangle.X <> x then
    begin
      x := FDisplayList.GetItem(i).Rectangle.X;
      Inc(Result);
    end;
  end;
end;

function TAdvSmoothImageListBox.GetScrollBarHeight: integer;
begin
  Result := 0;
  if not (csDesigning in ComponentState) and FShowScrollBar then
      Result := FScrollBar.Height;
end;

function TAdvSmoothImageListBox.GetScrollBarWidth: integer;
begin
  Result := 0;
  if not (csDesigning in ComponentState) and FShowScrollBar then
    Result := FScrollBar.Width;
end;

function TAdvSmoothImageListBox.GetShadowOffset: integer;
begin
  Result := 0;
  if (Fill.ShadowColor <> clNone) and not Transparent then
    Result := Fill.ShadowOffset;
end;

function TAdvSmoothImageListBox.GetStrippedHTMLText(
  HTML: TAdvSmoothImageListBoxHTMLText): String;
var
  g: TGPGraphics;
  a, s, k: string;
  XSize, YSize: integer;
  l, m: integer;
  hr: TRect;
begin
  result := '';
  g := TGPGraphics.Create(Canvas.Handle);
  with HTML do
  begin
    HTMLDrawGDIP(g, FFont, FText,Rect(0, 0, 0, 0),FImages, 0,0,-1,-1,FShadowOffset,False,true,false,false,
      False,False,true,1.0,FURLColor,clNone,clNone,FShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

    result := s;
  end;
  g.Free;
end;

function TAdvSmoothImageListBox.GetTextHeight: integer;
begin
  result := 0;
  with ItemAppearance do
  begin
    if FTextVisible then
      Result := FTextHeight;
  end;
end;

function TAdvSmoothImageListBox.GetTextRect(g: TGPGraphics;
  HTML: TAdvSmoothImageListBoxHTMLText; r: TGPRectF; str: String): TGPRectF;
var
  x, y, tw, th: integer;
  loc: TAdvSmoothImageListBoxLocation;
  ff: TGPFontFamily;
  fs: integer;
  f: TGPFont;
  sf: TGPStringFormat;
  sri: TGPRectF;
begin
  with HTML do
  begin
    if (str <> '') then
    begin
      g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

      ff := TGPFontFamily.Create(FFont.Name);
      if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
      begin
        ff.Free;
        ff := TGPFontFamily.Create('Arial');
      end;

      fs := 0;
      if (fsBold in FFont.Style) then
        fs := fs + 1;
      if (fsItalic in FFont.Style) then
        fs := fs + 2;
      if (fsUnderline in FFont.Style) then
        fs := fs + 4;

      sf := TGPStringFormat.Create(StringFormatFlagsDirectionVertical);
      f := TGPFont.Create(ff, FFont.Size, fs, UnitPoint);
      g.MeasureString(str, length(str), f, r, sf, sri);


      loc := FLocation;
      if Fowner.Columns = 0 then
      begin
        case FLocation of
          cpTopLeft: loc := cpTopRight;
          cpTopCenter: loc := cpCenterRight;
          cpTopRight: loc := cpBottomRight;
          cpCenterLeft: loc := cpTopCenter;
          cpCenterCenter: loc := cpCenterCenter;
          cpCenterRight: loc := cpBottomCenter;
          cpBottomLeft: loc := cpTopLeft;
          cpBottomCenter: loc := cpCenterLeft;
          cpBottomRight: loc := cpBottomLeft;
          cpCustom: loc := cpCustom;
        end;
      end;

      tw := Round(sri.Width);
      th := Round(sri.Height);

      if loc <> cpCustom then
        GetObjectLocation(x, y, r, tw, th, loc)
      else
      begin
        x := Left;
        y := Top;
      end;

      Result := MakeRect(x, y, tw, th);

      f.Free;
      sf.Free;
      ff.Free;
    end;
  end;
end;

function TAdvSmoothImageListBox.GetTextWidth: integer;
begin
  result := 0;
  with ItemAppearance do
  begin
    if FTextVisible then
      Result := FTextWidth;
  end;
end;

function TAdvSmoothImageListBox.GetTotalImageHeight: integer;
begin
  result := 0;
  with ItemAppearance do
  begin
    if FImageVisible then
      Result := FImageHeight + FImageMargin.Top + FImageMargin.Bottom;
  end;
end;

function TAdvSmoothImageListBox.GetTotalImageWidth: integer;
begin
  result := 0;
  with ItemAppearance do
  begin
    if FImageVisible then
      Result := FImageWidth + FImageMargin.Left + FImageMargin.Right;
  end;
end;

function TAdvSmoothImageListBox.GetTotalTextHeight: integer;
begin
  result := 0;
  with ItemAppearance do
  begin
    if FTextVisible then
      Result := FTextHeight + FTextMargin.Top + FTextMargin.Bottom;
  end;
end;

function TAdvSmoothImageListBox.GetTotalTextWidth: integer;
begin
  result := 0;
  with ItemAppearance do
  begin
    if FTextVisible then
      Result := FTextWidth + FTextMargin.Left + FTextMargin.Right;
  end;
end;

function TAdvSmoothImageListBox.GetVersion: String;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvSmoothImageListBox.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvSmoothImageListBox.HeaderChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothImageListBox.FooterButton(X, Y: integer; var state: integer): integer;
var
  i: integer;
  r: TGPRectF;
begin
  state := -1;
  Result := -1;
  for I := 0 to 3 do
  begin
    with Footer do
    begin
      if Navigator.Visible and Footer.Visible then
      begin
        r := Navigator.GetNavigatorButtonRect(Navigator.GetNavigatorRect(GetRect), I);
        if PtInRect(Bounds(Round(R.X), Round(R.Y), Round(R.Width), Round(R.Height)), Point(X, Y)) then
        begin
          state := I;
          Result := I;
          break;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothImageListBox.HeaderButton(X, Y: integer; var State: integer): integer;
var
  i: integer;
  r: TGPRectF;
begin
  State := -1;
  Result := -1;  
  for I := 0 to 3 do
  begin
    with Header do
    begin
      if Navigator.Visible and Header.Visible then
      begin
        r := Navigator.GetNavigatorButtonRect(Navigator.GetNavigatorRect(GetRect), I);
        if PtInRect(Bounds(Round(R.X), Round(R.Y), Round(R.Width), Round(R.Height)), Point(X, Y)) then
        begin
          State := I;
          Result := I;
          break;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.InitListBoxItems;
var
  col, row, I: Integer;
  h, w, startx, x, starty, y: Single;
  bw, shadoff: single;
  r: TGPRectF;
  ssz, hspc, vspc, spc, scrl, start, stop: integer;
begin
  FItemsInitialized := false;
  if ((Rows <> 0) and (Columns <> 0)) or (Items.Count = 0) then
    exit;

  bw := GetOuterBorderWidth;
  shadoff := GetShadowOffset;
  spc := ItemAppearance.Splitter.Spacing;
  ssz := ItemAppearance.Splitter.Size;
  hspc := ItemAppearance.ItemHorizontalSpacing;
  vspc := ItemAppearance.ItemVerticalSpacing;

  scrl := 0;
  case FScrollBar.Kind of
    sbHorizontal: scrl := GetScrollBarHeight;
    sbVertical: scrl := GetScrollBarWidth;
  end;

  w := ItemAppearance.GetColumnWidth;
  h := ItemAppearance.GetRowHeight;

  startx := 0;
  starty := 0;
  if Rows = 0 then
  begin
    starty := bw + vspc + Header.GetHeight - GetPosition;
    startx := bw + hspc;
  end
  else if Columns = 0 then
  begin
    starty := bw + vspc + Header.GetHeight;
    startx := bw + hspc - GetPosition;
  end;

  x := startx;
  y := starty;

  col := 0;
  row := 0;

  start := 0;
  stop := Items.Count - 1;

  FDisplayList.Clear;  

  for I := start to stop do
  begin
    with Items[I] do
    begin
      if Splitter then
      begin
        FDisplayList.AddItem;

        if Columns = 0 then
        begin
          if row > 0 then
            x := x + w + hspc + spc
          else
            x := x + spc;

          y := starty;

          r := MakeRect(x - (ssz / 2) - (hspc + spc) / 2, bw + Header.GetHeight, ssz, 
            InsideRect.Bottom - shadoff - bw - InsideRect.Top - Footer.GetHeight - Header.GetHeight - scrl);

          row := 0;
        end
        else if Rows = 0 then
        begin
          if col > 0 then
            y := y + h + vspc + spc
          else
            y := y + spc;

          x := startx;

          r := MakeRect(bw, y - (ssz / 2) - (vspc + spc) / 2,
            InsideRect.Right - shadoff - bw - InsideRect.Left - scrl, ssz);

          col := 0;
        end;

        FDisplayList.GetItem(FDisplayList.Count - 1).FItem := Items[I];               
        FDisplayList.GetItem(FDisplayList.Count - 1).Rectangle := r;     
        FDisplayList.GetItem(FDisplayList.Count - 1).FItem.FItemRect := r;
        FDisplayList.GetItem(FDisplayList.Count - 1).Kind := ikSplitter;                                        
      end
      else if FVisible and not FCollapsed then           
      begin
        FDisplayList.AddItem;      
        r := MakeRect(x, y, w, h);
        FDisplayList.GetItem(FDisplayList.Count - 1).FItem := Items[I];               
        FDisplayList.GetItem(FDisplayList.Count - 1).Rectangle := r;     
        FDisplayList.GetItem(FDisplayList.Count - 1).FItem.FItemRect := r;
        FDisplayList.GetItem(FDisplayList.Count - 1).Kind := ikItem;          
                      

        if Columns = 0 then
        begin
          y := y + h + vspc;
          Inc(row);

          if row = Rows then
          begin
            row := 0;
            y := starty;
            x := x + w + hspc;
          end;
        end
        else if Rows = 0 then
        begin
          x := x + w + hspc;
          Inc(col);

          if col = Columns then
          begin
            col := 0;
            x := startx;
            y := y + h + vspc;
          end;
        end;
      end;
    end;
  end;

  FItemsInitialized := true;
  FItemRectsInitialized := true;
  FRestartLoop := true;
  FStartImage := GetFirstVisibleItem;
end;

procedure TAdvSmoothImageListBox.InitPreview;
begin
  FFooter.FCaption := 'Footer';
  FFooter.FFont.Size := 10;
  FFooter.FFont.Color := clWhite;

  FHeader.FCaption := 'Header';
  FHeader.FFont.Size := 10;
  FHeader.FFont.Color := clWhite;
end;

function TAdvSmoothImageListBox.InsideRect: TRect;
var
  bw: integer;
begin
  Result := Rect(0, 0, Width, Height);
  // adapt width & height for GDI+ drawing rect
  
  Result.Right := Result.Right - 1;
  Result.Bottom := Result.Bottom - 1;

  if (Fill.BorderColor <> clNone) and not Transparent then
  begin
    if Fill.BorderWidth = 1 then
      bw := 1
    else
      bw := (Fill.BorderWidth + 1) div 2;

    InflateRect(Result, -bw, -bw);
  end;
end;

procedure TAdvSmoothImageListBox.ItemAppearanceChanged(Sender: TObject);
var
  i: integer;
begin
  Changed;
  if (csDesigning in ComponentState) then
  begin
    DefaultImageChanged(Self);
    for I := 0 to Items.Count - 1 do
    begin
      Items[I].ImageChanged(Self);
    end;
  end;
end;

procedure TAdvSmoothImageListBox.ItemsChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (FDisplayList.Count = 0) or not TabStop then
    exit;

  Navigate(Key, shift);
end;

procedure TAdvSmoothImageListBox.KeyPress(var Key: char);
var
  i: integer;
  flg: boolean;
  r: TRect;
begin
  inherited;

  if not KeyBoardLookup then
    Exit;

  FTimerCount := 0;

  if (Key >= '0') and (Key <= 'z') then
  begin
    FLookupKey := FLookupKey + key;
  end;

  if Key = #8 then
  begin
    if Length(FLookupKey) > 0 then
      Delete(FLookupKey, Length(FLookupKey), 1);
  end;


  flg := false;

  for i := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      if DisplayItem <> nil then
      begin
        if pos(Uppercase(FLookupKey), Uppercase(GetStrippedHTMLText(DisplayItem.Caption))) = 1 then
        begin
          FAnimate := true;

          if Rows = 0 then
          begin
            r := Bounds(Round(Rectangle.X), Round(Rectangle.Y + GetPosition), Round(Rectangle.Width), Round(Rectangle.Height));
            FScPosTo := r.Top - Header.GetHeight;
          end
          else if Columns = 0 then
          begin
            r := Bounds(Round(Rectangle.X + GetPosition), Round(Rectangle.Y), Round(Rectangle.Width), Round(Rectangle.Height));
            FScPosTo := R.Left;
          end;

          FSelectedItemIndex := DisplayItem.Index;
          FFocusedItemIndex := FSelectedItemIndex;
          FSp := FAnimationFactor;
          flg := true;
          break;
        end;
      end;
    end;
  end;

  if not flg then
    FLookupKey := '';
end;

procedure TAdvSmoothImageListBox.Loaded;
var
  i: integer;
begin
  inherited;
  DefaultImageChanged(Self);
  for I := 0 to Items.Count - 1 do
    Items[I].ImageChanged(Self);
end;

procedure TAdvSmoothImageListBox.Highlight(DoCase: Boolean; HiText: string);
begin
  FMarkCase := DoCase;
  FMarkTag := 'hi';
  FMark := HiText;
  Invalidate;  
end;

procedure TAdvSmoothImageListBox.Mark(DoCase: Boolean; HiText: string);
begin
  FMarkCase := DoCase;
  FMarkTag := 'e';
  FMark := HiText;
  Invalidate;
end;

procedure TAdvSmoothImageListBox.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  item: TAdvSmoothImageListBoxItem;
  md: Integer;
  i: integer;
  count: integer;
  ia: TItemAnchor;
begin
  inherited;

  SetFocus;

  if not GetItemIsDblClicked then
  begin
    FMouseDown := true;

    if Rows = 0 then
    begin
      FDragXY := Y;
      FScrollXY := Y;
    end
    else if Columns = 0 then
    begin
      FDragXY := X;
      FScrollXY := X;
    end;

    FTimeStart := GetTickCount;
    FClickY := Y;
    FClickX := X;

    md := FindItemOnXY(X, Y);
    if md <> -1 then
    begin
      if Assigned(FOnItemMouseDown) then
        FOnItemMouseDown(Self, md);
    end;

    count := 0;
    for I := 0 to FDisplayList.Count - 1 do
      if FDisplayList.GetItem(i).Kind = ikItem then
        Inc(Count);

    if (count > 1) and (FSelectedItemIndex <> -1) then
    begin
      if HeaderButton(X, Y, FSelH) <> -1 then
        Changed;

      if FooterButton(X, Y, FSelF) <> -1 then
        Changed;

      if ItemAppearance.Splitter.Expander then
      begin
        for I := 0 to FDisplayList.Count - 1 do
        begin
          with FDisplayList.GetItem(i) do
          begin
            item := FItem;
            if item <> nil then
            begin
              if item.Splitter then
              begin
                if ExpanderButton(X, Y, Rectangle, item, FItem.FSelExp) <> -1 then
                begin
                  Self.Changed;
                  break;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  ia := GetAnchorAt(X, Y);
  if (ia.anchor <> '') and (ia.itemindex >= 0) and (ia.itemindex <= Items.Count - 1) then
  begin
    if Assigned(FOnItemAnchorClick) then
      FOnItemAnchorClick(Self, ia.itemindex, ia.anchor);
  end;
end;

procedure TAdvSmoothImageListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  XY, hov, hoverh: integer;
  hoverf, i, exph: integer;
  item: TAdvSmoothImageListBoxItem;
  count: integer;
  ia: TItemAnchor;
begin
  inherited;

  if (csDesigning in ComponentState) then
  begin
    FMouseDown := false;
    FMouseUp := false;
    exit;
  end;


  ia := GetAnchorAt(X, Y);
  if (ia.itemindex >= 0) and (ia.itemindex <= Items.Count - 1) and (ia.anchor <> '') then
    Screen.Cursor := crHandPoint
  else
    Screen.Cursor := crDefault;

  if not GetItemIsDblClicked then
  begin
    XY := 0;
    if Rows = 0 then
      XY := Y
    else if Columns = 0 then
      XY := X;

    if FMouseDown then
    begin
      if ((FDragXY < XY-2) or (FDragXY > XY+2)) then
      begin
        FSp := 4;
        FAnimate := false;
        FHoveredItemIndex := -1;

        if (XY - FDragXY) > 0 then
          FCurrentScPos := GetPosition - Abs(XY - FDragXY)
        else
          FCurrentScPos := GetPosition + Abs(XY - FDragXY);

        FDragXY := XY;
        FScPosTo := GetPosition;
        InitListBoxItems;
        Changed;
      end;
    end
    else
    begin
      if FMouseUp then
      begin
        FMouseUp := false;

        if ((FTimeStop - FTimeStart) > 500) or ((FTimeStop - FTimeStart) = 0) then
          exit;

        FSp := Abs(XY - FScrollXY) / (FTimeStop - FTimeStart);
        if FSp > 0 then
        begin
          if (XY - FScrollXY) > 0 then
            FScPosTo := FScPosTo - Round(Abs(XY - FScrollXY) * FSp)
          else
            FScPosTo := FScPosTo + Round(Abs(XY - FScrollXY) * FSp);
        end;
      end;
    end;

    if not FAnimating and Hover then
    begin
      //HoverItem
      hov := FindItemOnXY(X, Y);
      if hov <> -1 then
      begin
        if hov <> FHoveredItemIndex then
        begin
          Application.CancelHint;        
          if Items[hov].Enabled then
            FHoveredItemIndex := hov;

          with Items[hov] do
          begin
            if not FMouseEntered then
            begin
              if Assigned(FOnItemMouseEnter) then
                FOnItemMouseEnter(Self, hov);

              FMouseEntered := true;
              FMouseLeft := false;
            end;
          end;
          Changed;
        end;
      end
      else
      begin
        if FHoveredItemIndex <> -1 then
        begin
          with Items[FHoveredItemIndex] do
          begin
            if not FMouseLeft then
            begin
              if Assigned(FOnItemMouseLeave) then
                FOnItemMouseLeave(Self, FHoveredItemIndex);

              FMouseLeft := true;
              FMouseEntered := false;
            end;
          end;
        end;

        if hov <> FHoveredItemIndex then
        begin
          FHoveredItemIndex := hov;
          Changed;
        end;
      end;

      count := 0;
      for I := 0 to FDisplayList.Count - 1 do
        if FDisplayList.GetItem(i).Kind = ikItem then
          Inc(Count);

      if (Count > 1) and (FSelectedItemIndex <> -1) then
      begin
        if HeaderButton(X, Y, hoverh) <> FHovH then
        begin
          FHovH := hoverh;
          Application.ActivateHint(Mouse.CursorPos);
          Changed;
        end;

        if FooterButton(X, Y, hoverf) <> FHovF then
        begin
          FHovF := hoverf;
          Application.ActivateHint(Mouse.CursorPos);
          Changed;
        end;
      end;

      if ItemAppearance.Splitter.Expander then
      begin
        for I := 0 to FDisplayList.Count - 1 do
        begin
          with FDisplayList.GetItem(i) do
          begin
            item := FItem;
            if item <> nil then
            begin
              if item.Splitter then
              begin
                if ExpanderButton(X, Y, Rectangle, item, exph) <> FItem.FHovExp then
                begin
                  FItem.FHovExp := exph;
                  Self.Changed;
                  break;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  sel, XY, c: integer;
  checkok: Boolean;
  key: Word;
  i: integer;
  item: TAdvSmoothImageListBoxItem;
  count: integer;
  allownavigate: Boolean;
  navigatemode: TAdvSmoothImageListBoxNavigationMode;
begin
  inherited;

  if not GetItemIsDblClicked then
  begin
    if csDesigning in ComponentState then
      exit;

    checkok := false;
    if Rows = 0 then
      Checkok := not (GetFullSize < Height)
    else if Columns = 0 then
      Checkok := not (GetFullSize < Width);

    if FAnimating and FAnimate and Checkok then
    begin
      FAnimate := false;
      FScrollXY := GetPosition;
      FScPosTo := GetPosition;
      FCurrentScPos := GetPosition;
      FTimeStart := 0;
      FTimeStop := 0;
    end;

    XY := 0;
    if Rows = 0 then
      XY := Y
    else if Columns = 0 then
      XY := X;

    FHovF := -1;
    FSelF := -1;
    FHovH := -1;
    FSelH := -1;
    
    for I := 0 to FDisplayList.Count - 1 do
    begin
      item := FDisplayList.GetItem(i).FItem;
      if item <> nil then
      begin
        item.FSelExp := -1;
        item.FHovExp := -1;
      end;
    end;
    
    FMouseDown := false;
    FMouseUp := true;
    FTimeStop := GetTickCount;
    FAnimate := (FTimeStop - FTimeStart > 0);

    if ((FScrollXY > XY - 2) and (FScrollXY < XY + 2)) then
    begin
      //SPLITTER EXPANDING
      if ItemAppearance.Splitter.Expander then
      begin
        for I := 0 to Items.Count - 1 do
        begin
          with Items[I] do
          begin
            c := ExpanderButton(X, Y, FItemRect, Items[I], c);
            if c <> -1 then
            begin
              if FCollapsed then
                SplitterState := stExpanded
              else
                SplitterState := stCollapsed;

              break;
            end;
          end;
        end;
      end;

      //NAVIGATION
      c := HeaderButton(X, Y, c);
      if c = -1 then
        c := FooterButton(X, Y, c);

      count := 0;
      for I := 0 to FDisplayList.Count - 1 do
        if FDisplayList.GetItem(i).Kind = ikItem then
          Inc(Count);

      if (c <> -1) and (count > 1) and (FSelectedItemIndex <> -1) then
      begin
        key := 0;
        navigatemode := nmNone;
        case c of
          0:
          begin
            navigatemode := nmPriorPage;
            key := VK_PRIOR;
          end;
          1:
          begin
            navigatemode := nmPrior;

            if Rows = 0 then
              key := VK_LEFT
            else if Columns = 0 then
              key := VK_UP;
          end;
          2:
          begin
            navigatemode := nmNext;

            if Rows = 0 then
              key := VK_RIGHT
            else if Columns = 0 then
              key := VK_DOWN;
          end;
          3:
          begin
            key := VK_NEXT;
            navigatemode := nmNextPage;
          end;
        end;

        allownavigate := true;
        
        if Assigned(FOnNavigate) then
          FOnNavigate(Self, navigatemode, allownavigate);

        if allownavigate then
        begin
          if ((c = 0) or (c = 1)) and (FSelectedItemIndex > 0) then
            Navigate(key, Shift)
          else if ((c = 2) or (c = 3)) and (FSelectedItemIndex < Items.Count - 1) then
            Navigate(key, Shift);

          if Assigned(FOnItemMouseUp) then
            FOnItemMouseUp(Self, FSelectedItemIndex);

          Exit;
        end;
      end
      else
      begin
        //Select item
        sel := FindItemOnXY(X, Y);
        if sel <> -1 then
        begin
          if Items[sel].Enabled then
          begin
            if (ssShift in Shift) and MultiSelect then
            begin
              for I := 0 to Items.Count - 1 do
                Items[i].Selected := false;

              if sel < FSelectedItemIndex then
              begin
                for I := FselectedItemIndex downto sel do
                  Items[I].Selected := true
              end
              else
              begin
                for I := FselectedItemIndex to sel do
                  Items[I].Selected := true
              end;
            end
            else if (ssCtrl in Shift) and MultiSelect then
            begin
              Items[sel].Selected := not Items[sel].Selected;
            end
            else
            begin
              if MultiSelect then
                for I := 0 to Items.Count - 1 do
                  Items[I].Selected := false;
                  
              FSelectedItemIndex := sel;
              FFocusedItemIndex := FSelectedItemIndex;
              Items[FSelectedItemIndex].Selected := true;
            end;
          end;
        end;
      end;

      if (FSelectedItemIndex <> -1) and (FDisplayList.Count > 0) and (Items.Count > 0) then
      begin
        FMouseUp := false;      
        if Assigned(FOnItemClick) then
          FOnItemClick(Self, FSelectedItemIndex, Button, Shift);

        if Assigned(FOnItemSelect) then
          FOnItemSelect(Self, FSelectedItemIndex);

        if Assigned(FOnItemMouseUp) then
          FOnItemMouseUp(Self, FSelectedItemIndex);

        Changed;
      end;
    end
    else
      FSp := 4;
  end
  else
  begin
    if not FAnimateDoubleClick then
      DoZoom;
  end;
end;

procedure TAdvSmoothImageListBox.MouseWheelHandler(var Message: TMessage);
begin
  inherited;
  case Message.Msg of
    WM_MOUSEWHEEL:
    begin
      if Message.WParam < 0 then
      begin
        FSp := FAnimationFactor;
        if Rows = 0 then
          FScPosTo := FScPosTo + ItemAppearance.GetRowHeight
        else if Columns = 0 then
          FScPosTo := FScPosTo + ItemAppearance.GetColumnWidth
      end
      else
      begin
        FSp := FAnimationFactor;
        if Rows = 0 then
          FScPosTo := FScPosTo - ItemAppearance.GetRowHeight
        else if Columns = 0 then
          FScPosTo := FScPosTo - ItemAppearance.GetColumnWidth
      end;

      FAnimate := true;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.Navigate(Key: Word; Shift: TShiftState);
var
  correctkey: Boolean;
  var
    i: integer;
begin
  if (FDisplayList.Count > 0) and (Items.Count > 0) then
  begin
    FTimerCount := 0;

    if Key = VK_SPACE then
    begin
      if MultiSelect then
      begin
        if FFocusedItemIndex <> FSelectedItemIndex then
        begin
          if not (ssCtrl in Shift) and not (ssShift in Shift) then
          begin
            for I := 0 to Items.Count - 1 do
              Items[I].Selected := false;

            FSelectedItemIndex := FFocusedItemIndex;
            Items[FSelectedItemIndex].Selected := true;
          end
        end
        else
          DoZoom;

        if ssCtrl in Shift then
        begin
          Items[FFocusedItemIndex].Selected := not Items[FFocusedItemIndex].Selected;
        end
        else if ssShift in Shift then
        begin
          for I := 0 to Items.Count - 1 do
            Items[i].Selected := false;

          if FFocusedItemIndex < FSelectedItemIndex then
          begin
            if FSelectedItemIndex <> -1 then
              for I := FselectedItemIndex downto FFocusedItemIndex do
                Items[I].Selected := true
          end
          else
          begin
            if FSelectedItemIndex <> -1 then
              for I := FselectedItemIndex to FFocusedItemIndex do
                Items[I].Selected := true
          end;
        end
      end
      else
        DoZoom;
    end
    else
    begin
      if MultiSelect then
      begin
        correctkey := ProcessKeyDown(Key, FFocusedItemIndex);
        if correctkey then
        begin
          case Key of
          VK_NEXT: FFocusedItemIndex := FFocusedItemIndex + 1;
          VK_PRIOR: FFocusedItemIndex := FFocusedItemIndex - 1;
          end;

          FFocusedItemIndex := Min(Items.Count - 1, Max(0, FFocusedItemIndex));
          while Items[FFocusedItemIndex].Splitter and (FFocusedItemIndex > 0) and (FFocusedItemIndex < Items.Count) or (Items[FFocusedItemIndex].Enabled = false) do
          begin
            case Key of
            VK_NEXT: FFocusedItemIndex := FFocusedItemIndex + 1;
            VK_PRIOR: FFocusedItemIndex := FFocusedItemIndex - 1;
            else
              ProcessKeyDown(Key, FFocusedItemIndex);
            end;
            if (FFocusedItemIndex <= 0) or (FFocusedItemIndex >= Items.Count) then
              break;
          end;

          FFocusedItemIndex := Min(Items.Count - 1, Max(0, FFocusedItemIndex));

          if (Items[Items.Count - 1].Splitter) and (FFocusedItemIndex = Items.Count - 1) then
            while Items[FFocusedItemIndex].Splitter do
              Dec(FFocusedItemIndex);

          if (Items[0].Splitter) and (FFocusedItemIndex = 0) then
            while Items[FFocusedItemIndex].Splitter do
              Inc(FFocusedItemIndex);

          if ssShift in Shift then
          begin
            for I := 0 to Items.Count - 1 do
              Items[i].Selected := false;

            if FSelectedItemIndex <> - 1 then
            begin
              if FFocusedItemIndex < FSelectedItemIndex then
              begin
                for I := FselectedItemIndex downto FFocusedItemIndex do
                  Items[I].Selected := true
              end
              else
              begin
                for I := FselectedItemIndex to FFocusedItemIndex do
                  Items[I].Selected := true
              end;
            end;
          end;

          SelectImage(Key, FFocusedItemIndex, false);
        end;
      end
      else
      begin
        correctkey := ProcessKeyDown(Key, FSelectedItemIndex);
        if correctkey then
        begin
          case Key of
          VK_NEXT: FSelectedItemIndex := FSelectedItemIndex + 1;
          VK_PRIOR: FSelectedItemIndex := FSelectedItemIndex - 1;
          end;

          FSelectedItemIndex := Min(Items.Count - 1, Max(0, FSelectedItemIndex));
          while Items[FSelectedItemIndex].Splitter and (FSelectedItemIndex > 0) and (FSelectedItemIndex < Items.Count) or (Items[FSelectedItemIndex].Enabled = false) do
          begin
            case Key of
            VK_NEXT: FSelectedItemIndex := FSelectedItemIndex + 1;
            VK_PRIOR: FSelectedItemIndex := FSelectedItemIndex - 1;
            else
              ProcessKeyDown(Key, FSelectedItemIndex);
            end;
            if (FSelectedItemIndex <= 0) or (FSelectedItemIndex >= Items.Count) then
              break;
          end;

          FSelectedItemIndex := Min(Items.Count - 1, Max(0, FSelectedItemIndex));      

          if (Items[Items.Count - 1].Splitter) and (FSelectedItemIndex = Items.Count - 1) then
            while Items[FselectedItemIndex].Splitter do
              Dec(FselectedItemIndex);

          if (Items[0].Splitter) and (FSelectedItemIndex = 0) then
            while Items[FselectedItemIndex].Splitter do
              Inc(FselectedItemIndex);

          SelectImage(Key, FselectedItemIndex, true);
          FFocusedItemIndex := FSelectedItemIndex;
        end;
      end;
      Changed;
    end;

    if (Key in [VK_DOWN, VK_UP, VK_LEFT, VK_RIGHT, VK_SPACE, VK_RETURN, VK_HOME, VK_END]) then
      FLookupKey := '';
  end;
end;

procedure TAdvSmoothImageListBox.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  if not (csDestroying in ComponentState) then
  begin
    if (AOperation = opRemove) and (AComponent = FImages) then
      FImages := nil;

    if (AOperation = opRemove) and (AComponent = FContainer) then
      FContainer := nil;
  end;
  inherited;
end;

procedure TAdvSmoothImageListBox.Paint;
begin
  inherited;
  
  if Items.FUpdateCount > 0 then
    Exit;

  DrawBackGround;

  if not ((Columns <> 0) and (Rows <> 0) and (Items.Count = 0)) then
    if (FItemsInitialized) and (FItems.FUpdateCount = 0) then
      DrawItems;

  DrawHeader;
  DrawFooter;
  DrawTopLayerItems;

  SetScrollBarPosition;

  if ZoomOnTop then
    DrawZoomedItem;
end;

function TAdvSmoothImageListBox.ProcessKeyDown(Key: Word; var itemindex: integer): Boolean;
begin
  result := false;
  case Key of
    VK_DOWN:
    begin
      if (Rows = 0) and (itemindex + columns <= Items.Count - 1) then
        itemindex := itemindex + Columns
      else if Columns = 0 then
        Inc(itemindex);

      Result := true;
    end;
    VK_UP:
    begin
      if (Rows = 0) and (itemindex - columns >= 0) then
        itemindex := itemindex - Columns
      else if Columns = 0 then
        Dec(itemindex);

      Result := true;
    end;
    VK_RIGHT:
    begin
      if Rows = 0 then
        Inc(itemindex)
      else if (Columns = 0) and (itemindex + Rows <= Items.Count - 1) then
        itemindex := itemindex + Rows;

      Result := true;
    end;
    VK_LEFT:
    begin
      if Rows = 0 then
        Dec(itemindex)
      else if (Columns = 0) and (itemindex - Rows >= 0) then
        itemindex := itemindex - Rows;

      Result := true;
    end;
    VK_HOME:
    begin
      itemindex := 0;
      Result := true;
    end;
    VK_END:
    begin
      itemindex := FDisplayList.Count - 1;
      Result := true;
    end;
    VK_NEXT:
    begin
      itemindex := GetLastVisibleItem;
      Result := true;
    end;
    VK_PRIOR:
    begin
      itemindex := GetFirstVisibleItem;
      Result := true;      
    end;
  end;
end;

procedure TAdvSmoothImageListBox.Resize;
begin
  inherited;
  FAnimateDoubleClick := true;
  ItemAppearance.InitFills;
  InitListBoxItems;
  ItemAppearance.CheckItemWidth;
  ItemAppearance.CheckItemHeight;
  FRestartLoop := true;
  FStartImage := GetFirstVisibleItem;
end;

procedure TAdvSmoothImageListBox.Scroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  if not GetItemIsDblClicked then
  begin
    FCurrentScPos := ScrollPos;
    FScPosTo := FCurrentScPos;
    InitListBoxItems;
    Changed;
    if Assigned(FOnScroll) then
      FOnScroll(Self, ScrollPos);
  end;
end;

procedure TAdvSmoothImageListBox.ScrollToItem(itemindex: integer);
var
  i: integer;
  ditem: TAdvSmoothImageListBoxItem;
begin
  for I := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      ditem := FItem;
      if ditem <> nil then
      begin
        if ditem.Index = itemindex then
        begin
          if Rows = 0 then
            FScPosTo := Round(Rectangle.Y)
          else if Columns = 0 then
            FScPosTo := Round(Rectangle.X);

          FCurrentScPos := Min(GetFullSize, Max(0, FScPosTo));
          FScPosTo := FCurrentScPos;
          InitListBoxItems;
          Changed;
          break;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.SelectImage(Key: Word; var itemindex: integer; itemselect: Boolean);
var
  i, h: integer;
  r: TRect;
begin
  itemindex := Min(Items.Count - 1, Max(0, itemindex));

  if (itemindex <> -1) and itemselect then
    if Assigned(FOnItemSelect) then
      FOnItemSelect(Self, FSelectedItemIndex);

  for I := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      if DisplayItem <> nil then
      begin
        if DisplayItem.Index = itemindex then
        begin
          h := Self.Height - Footer.GetHeight - Header.GetHeight - GetShadowOffset;
          if Key = VK_PRIOR then
          begin
            if Rows = 0 then
              FScPosTo := FScPosTo - h
            else
              FScPosTo := FScPosTo - Self.Width;
          end
          else if Key = VK_NEXT then
          begin
            if Rows = 0 then
              FScPosTo := FScPosTo + h
            else
              FScPosTo := FScPosTo + Self.Width;
          end
          else
          begin
            if Rows = 0 then
            begin
              r := Bounds(Round(Rectangle.X), Round(Rectangle.Y + GetPosition), Round(Rectangle.Width), Round(Rectangle.Height));
              if r.Top - GetPosition > Height - Footer.GetHeight - (r.Bottom-r.Top) then
              begin
                FScPosTo := r.Bottom - (Height - Footer.GetHeight);
                FScPosTo := FScPosTo + ItemAppearance.ItemVerticalSpacing;
              end
              else if r.Top < GetPosition + Header.GetHeight then
              begin
                FScPosTo := r.Top - Header.GetHeight;
                FScPosTo := FScPosTo - ItemAppearance.ItemVerticalSpacing;
              end;
            end
            else if Columns = 0 then
            begin
              r := Bounds(Round(Rectangle.X + GetPosition), Round(Rectangle.Y), Round(Rectangle.Width), Round(Rectangle.Height));
              if r.Left - GetPosition > Width - (r.Right-r.Left) then
              begin
                FScPosTo := r.Right - Width;
                FScPosTo := FScPosTo + ItemAppearance.ItemHorizontalSpacing;
              end
              else if r.Left < GetPosition then
              begin
                FScPosTo := r.Left;
                FScPosTo := FScPosTo - ItemAppearance.ItemHorizontalSpacing;
              end;
            end;
          end;

          FCurrentScPos := Min(GetFullSize, Max(0, FScPosTo));
          FScPosTo := FCurrentScPos;          
          InitListBoxItems;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.SetAnimationFactor(const Value: integer);
begin
  if FAnimationFactor <> value then
  begin
    FAnimationFactor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetColumns(const Value: integer);
begin
  if (FColumns <> value) then
  begin
    if FRows <> 0 then
      FRows := 0;

    FColumns := Value;
    ItemAppearance.InitFills;
    InitListBoxItems;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetComponentStyle(AStyle: TTMSStyle);
begin
  // TODO : do color settings here

  with ItemAppearance.Splitter do
  begin
    if Rows = 0 then
      Fill.GradientType := gtVertical
    else if Columns = 0 then
      Fill.GradientType := gtHorizontal
  end;

case AStyle of
  tsOffice2003Blue: 
    begin
      Fill.Color := $00FFD2AF;
      Fill.ColorTo := $00FFD2AF;

      Header.Fill.Color := $D68759;
      Header.Fill.ColorTo := $933803;
      Header.Font.Color := clWhite;
      Header.Fill.BorderColor := $962D00;

      Footer.Fill.Color := $D68759;
      Footer.Fill.ColorTo := $933803;
      Footer.Font.Color := clWhite;
      Footer.Fill.BorderColor := $962D00;

      ItemAppearance.Fill.Color := $FCE1CB;
      ItemAppearance.Fill.ColorTo := $E0A57D;
      ItemAppearance.Fill.ColorMirror := clNone;
      ItemAppearance.Fill.ColorMirrorTo := clNone;
      ItemAppearance.Fill.BorderColor := $962D00;
      ItemAppearance.Fill.GradientMirrorType := gtVertical;

      ItemAppearance.DisabledFill.Color := $00F2F2F2;
      ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirror := clNone;
      ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
      ItemAppearance.DisabledFill.BorderColor := $962D00;
      ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

      ItemAppearance.HoverFill.Color := $EBFDFF;
      ItemAppearance.HoverFill.ColorTo := $ACECFF;
      ItemAppearance.HoverFill.BorderColor :=  $962D00;
      ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

      ItemAppearance.SelectedFill.Color := $94E6FB;
      ItemAppearance.SelectedFill.ColorTo := $1595EE;
      ItemAppearance.SelectedFill.ColorMirror := clNone;
      ItemAppearance.SelectedFill.ColorMirrorTo := clNone;
      ItemAppearance.SelectedFill.BorderColor := $962D00;
      ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

      Footer.Navigator.Color := $00FFD2AF;
      Footer.Navigator.HoverColor := $94E6FB;
      Footer.Navigator.DownColor := $1595EE;
      Footer.Navigator.BorderColor := clBlack;

      ItemAppearance.Splitter.ExpanderColor := $00FFD2AF;
      ItemAppearance.Splitter.ExpanderHoverColor := $94E6FB;
      ItemAppearance.Splitter.ExpanderDownColor := $1595EE;
      ItemAppearance.Splitter.ExpanderBorderColor := clBlack;
      
      Header.Navigator.Color := $00FFD2AF;
      Header.Navigator.HoverColor := $94E6FB;
      Header.Navigator.DownColor := $1595EE;
      Header.Navigator.BorderColor := clBlack;

      with ItemAppearance.Splitter do
      begin
        Fill.Color := $94E6FB;
        Fill.ColorTo := $1595EE;
        Fill.BorderColor := $962D00;
      end;

    end;
  tsOffice2003Silver: 
    begin
      Fill.Color := $00E6D8D8;
      Fill.ColorTo := $00E6D8D8;

      Header.Fill.Color := $BDA4A5;
      Header.Fill.ColorTo := $957475;
      Header.Font.Color := clWhite;
      Header.Fill.BorderColor := $947C7C;

      Footer.Fill.Color := $BDA4A5;
      Footer.Fill.ColorTo := $957475;
      Footer.Font.Color := clWhite;
      Footer.Fill.BorderColor := $947C7C;

      ItemAppearance.Fill.Color := $ECE2E1;
      ItemAppearance.Fill.ColorTo := $B39698;
      ItemAppearance.Fill.ColorMirror := clNone;
      ItemAppearance.Fill.ColorMirrorTo := clNone;
      ItemAppearance.Fill.BorderColor := $947C7C;
      ItemAppearance.Fill.GradientMirrorType := gtVertical;

      ItemAppearance.DisabledFill.Color := $00F2F2F2;
      ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirror := clNone;
      ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
      ItemAppearance.DisabledFill.BorderColor := $947C7C;
      ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

      ItemAppearance.HoverFill.Color := $EBFDFF;
      ItemAppearance.HoverFill.ColorTo := $ACECFF;
      ItemAppearance.HoverFill.BorderColor :=  $947C7C;
      ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

      ItemAppearance.SelectedFill.Color := $94E6FB;
      ItemAppearance.SelectedFill.ColorTo := $1595EE;
      ItemAppearance.SelectedFill.ColorMirror := clNone;
      ItemAppearance.SelectedFill.ColorMirrorTo := clNone;
      ItemAppearance.SelectedFill.BorderColor := $947C7C;
      ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

      Footer.Navigator.Color := $ECE2E1;
      Footer.Navigator.HoverColor := $94E6FB;
      Footer.Navigator.DownColor := $1595EE;
      Footer.Navigator.BorderColor := clBlack;

      ItemAppearance.Splitter.ExpanderColor := $ECE2E1;
      ItemAppearance.Splitter.ExpanderHoverColor := $94E6FB;
      ItemAppearance.Splitter.ExpanderDownColor := $1595EE;
      ItemAppearance.Splitter.ExpanderBorderColor := clBlack;      

      Header.Navigator.Color := $ECE2E1;
      Header.Navigator.HoverColor := $94E6FB;
      Header.Navigator.DownColor := $1595EE;
      Header.Navigator.BorderColor := clBlack;

      with ItemAppearance.Splitter do
      begin
        Fill.Color := $94E6FB;
        Fill.ColorTo := $1595EE;
        Fill.BorderColor := $962D00;
      end;
                
    end;
  tsOffice2003Olive: 
    begin
      Fill.Color := $CFF0EA;
      Fill.ColorTo := $CFF0EA;

      Header.Fill.Color := $82C0AF;
      Header.Fill.ColorTo := $447A63;
      Header.Font.Color := clWhite;
      Header.Fill.BorderColor := $588060;

      Footer.Fill.Color := $82C0AF;
      Footer.Fill.ColorTo := $447A63;
      Footer.Font.Color := clWhite;
      Footer.Fill.BorderColor := $588060;

      ItemAppearance.Fill.Color := $CFF0EA;
      ItemAppearance.Fill.ColorTo := $8CC0B1;
      ItemAppearance.Fill.ColorMirror := clNone;
      ItemAppearance.Fill.ColorMirrorTo := clNone;
      ItemAppearance.Fill.BorderColor := $588060;
      ItemAppearance.Fill.GradientMirrorType := gtVertical;

      ItemAppearance.DisabledFill.Color := $00F2F2F2;
      ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirror := clNone;
      ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
      ItemAppearance.DisabledFill.BorderColor := $588060;
      ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

      ItemAppearance.HoverFill.Color := $EBFDFF;
      ItemAppearance.HoverFill.ColorTo := $ACECFF;
      ItemAppearance.HoverFill.BorderColor :=  $947C7C;
      ItemAppearance.HoverFill.GradientMirrorType := gtVertical;      

      ItemAppearance.SelectedFill.Color := $94E6FB;
      ItemAppearance.SelectedFill.ColorTo := $1595EE;
      ItemAppearance.SelectedFill.ColorMirror := clNone;
      ItemAppearance.SelectedFill.ColorMirrorTo := clNone;
      ItemAppearance.SelectedFill.BorderColor := $588060;
      ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

      Footer.Navigator.Color := $CFF0EA;
      Footer.Navigator.HoverColor := $94E6FB;
      Footer.Navigator.DownColor := $1595EE;
      Footer.Navigator.BorderColor := clBlack;

      ItemAppearance.Splitter.ExpanderColor := $CFF0EA;
      ItemAppearance.Splitter.ExpanderHoverColor := $94E6FB;
      ItemAppearance.Splitter.ExpanderDownColor := $1595EE;
      ItemAppearance.Splitter.ExpanderBorderColor := clBlack;            

      Header.Navigator.Color := $CFF0EA;
      Header.Navigator.HoverColor := $94E6FB;
      Header.Navigator.DownColor := $1595EE;
      Header.Navigator.BorderColor := clBlack;

      with ItemAppearance.Splitter do
      begin
        Fill.Color := $94E6FB;
        Fill.ColorTo := $1595EE;
        Fill.BorderColor := $962D00;
      end;               
    end;
    tsOffice2003Classic:
    begin
      Fill.Color := $00F2F2F2;
      Fill.ColorTo := $00F2F2F2;

      Header.Fill.Color := $808080;
      Header.Fill.ColorTo := $808080;
      Header.Font.Color := clWhite;
      Header.Fill.BorderColor := $808080;

      Footer.Fill.Color := $808080;
      Footer.Fill.ColorTo := $808080;
      Footer.Font.Color := clWhite;
      Footer.Fill.BorderColor := $808080;

      ItemAppearance.Fill.Color := clWhite;
      ItemAppearance.Fill.ColorTo := $C9D1D5;
      ItemAppearance.Fill.ColorMirror := clNone;
      ItemAppearance.Fill.ColorMirrorTo := clNone;
      ItemAppearance.Fill.BorderColor := $808080;
      ItemAppearance.Fill.GradientMirrorType := gtVertical;

      ItemAppearance.DisabledFill.Color := $D8D5D4;
      ItemAppearance.DisabledFill.ColorTo := $D8D5D4;
      ItemAppearance.DisabledFill.ColorMirror := clNone;
      ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
      ItemAppearance.DisabledFill.BorderColor := $808080;
      ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

      ItemAppearance.SelectedFill.Color := $B59285;
      ItemAppearance.SelectedFill.ColorTo := $B59285;
      ItemAppearance.SelectedFill.ColorMirror := clNone;
      ItemAppearance.SelectedFill.ColorMirrorTo := clNone;
      ItemAppearance.SelectedFill.BorderColor := $962D00;
      ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

      ItemAppearance.HoverFill.Color := $D2BDB6;
      ItemAppearance.HoverFill.ColorTo := $D2BDB6;
      ItemAppearance.HoverFill.BorderColor :=  $808080;
      ItemAppearance.HoverFill.ColorMirror := clNone;
      ItemAppearance.HoverFill.ColorMirrorTo := clNone;      
      ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

      Footer.Navigator.Color := clWhite;
      Footer.Navigator.HoverColor := $B59285;
      Footer.Navigator.DownColor := $D8D5D4;
      Footer.Navigator.BorderColor := clBlack;

      ItemAppearance.Splitter.ExpanderColor := clWhite;
      ItemAppearance.Splitter.ExpanderHoverColor := $B59285;
      ItemAppearance.Splitter.ExpanderDownColor := $D8D5D4;
      ItemAppearance.Splitter.ExpanderBorderColor := clBlack;            

      Header.Navigator.Color := clWhite;
      Header.Navigator.HoverColor := $B59285;
      Header.Navigator.DownColor := $D8D5D4;
      Header.Navigator.BorderColor := clBlack;

      with ItemAppearance.Splitter do
      begin
        Fill.Color := $B59285;
        Fill.ColorTo := $B59285;
        Fill.BorderColor := $962D00;
      end;
    end;
  tsOffice2007Luna: 
    begin          
      Fill.Color := $DCB698;
      Fill.ColorTo := $DCB698;

      Header.Fill.Color := $FFEFE3;
      Header.Fill.ColorTo := $FFD2AF;
      Header.Font.Color := $723708;  
      Header.Fill.BorderColor := $00FFD2AF;

      Footer.Fill.Color := $FFEFE3;
      Footer.Fill.ColorTo := $FFD2AF;
      Footer.Font.Color := $723708;        
      Footer.Fill.BorderColor := $00FFD2AF;    

      ItemAppearance.Fill.Color := $FFEFE3;
      ItemAppearance.Fill.ColorTo := $FFDDC4;        
      ItemAppearance.Fill.ColorMirror := $FFD1AD;
      ItemAppearance.Fill.ColorMirrorTo := $FFDBC0; 
      ItemAppearance.Fill.BorderColor := $FFD1AD;
      ItemAppearance.Fill.GradientMirrorType := gtVertical;

      ItemAppearance.DisabledFill.Color := $00F2F2F2;
      ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirror := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirrorTo := $00F2F2F2;
      ItemAppearance.DisabledFill.BorderColor := $FFD1AD;//$00B6B6B6;
      ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

      ItemAppearance.SelectedFill.Color := $AAD9FF;
      ItemAppearance.SelectedFill.ColorTo := $6EBBFF;
      ItemAppearance.SelectedFill.ColorMirror := $42AEFE;
      ItemAppearance.SelectedFill.ColorMirrorTo := $7AE1FE;
      ItemAppearance.SelectedFill.BorderColor := $FFD1AD;//$42AEFE;
      ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

      ItemAppearance.HoverFill.Color := $EBFDFF;
      ItemAppearance.HoverFill.ColorTo := $ACECFF;
      ItemAppearance.HoverFill.ColorMirror := $59DAFF;
      ItemAppearance.HoverFill.ColorMirrorTo := $A4E9FF;
      ItemAppearance.HoverFill.BorderColor :=  $99CEDB;
      ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

      Footer.Navigator.Color := $FFEFE3;
      Footer.Navigator.HoverColor := $AAD9FF;
      Footer.Navigator.DownColor := $6EBBFF;
      Footer.Navigator.BorderColor := clBlack;

      ItemAppearance.Splitter.ExpanderColor := $FFEFE3;
      ItemAppearance.Splitter.ExpanderHoverColor := $AAD9FF;
      ItemAppearance.Splitter.ExpanderDownColor := $6EBBFF;
      ItemAppearance.Splitter.ExpanderBorderColor := clBlack;            
      
      Header.Navigator.Color := $FFEFE3;
      Header.Navigator.HoverColor := $AAD9FF;
      Header.Navigator.DownColor := $6EBBFF;
      Header.Navigator.BorderColor := clBlack;

      with ItemAppearance.Splitter do
      begin
        Fill.Color := $AAD9FF;
        Fill.ColorTo := $6EBBFF;
        Fill.BorderColor := $FFD1AD;//$42AEFE;
      end;
        
    end;
  tsOffice2007Obsidian: 
    begin
      Fill.Color := $5C534C;
      Fill.ColorTo := $5C534C;          
                
      Header.Fill.Color := $F2F1F0;          
      Header.Fill.ColorTo := $C9C2BD;
      Header.Font.Color := $433C37;
      Header.Fill.BorderColor := $5C534C;

      Footer.Fill.Color := $F2F1F0;
      Footer.Fill.ColorTo := $C9C2BD;
      Footer.Font.Color := $433C37;
      Footer.Fill.BorderColor := $5C534C;

      ItemAppearance.Fill.Color := $F9F8F8;
      ItemAppearance.Fill.ColorTo := $E4E2DF;
      ItemAppearance.Fill.ColorMirror := $D1CBC7;
      ItemAppearance.Fill.ColorMirrorTo := $E2DEDB;
      ItemAppearance.Fill.BorderColor := clBlack;//$D1CBC7;
      ItemAppearance.Fill.GradientMirrorType := gtVertical;

      ItemAppearance.SelectedFill.Color := $AAD9FF;
      ItemAppearance.SelectedFill.ColorTo := $6EBBFF;
      ItemAppearance.SelectedFill.ColorMirror := $42AEFE;
      ItemAppearance.SelectedFill.ColorMirrorTo := $7AE1FE;
      ItemAppearance.SelectedFill.BorderColor := clBlack;//$42AEFE;
      ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

      ItemAppearance.DisabledFill.Color := $00F2F2F2;
      ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirror := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirrorTo := $00F2F2F2;
      ItemAppearance.DisabledFill.BorderColor := clBlack;//$00B6B6B6;
      ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

      ItemAppearance.HoverFill.Color := $EBFDFF;
      ItemAppearance.HoverFill.ColorTo := $ACECFF;
      ItemAppearance.HoverFill.ColorMirror := $59DAFF;
      ItemAppearance.HoverFill.ColorMirrorTo := $A4E9FF;
      ItemAppearance.HoverFill.BorderColor :=  $99CEDB;
      ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

      Footer.Navigator.Color := $F9F8F8;
      Footer.Navigator.HoverColor := $AAD9FF;
      Footer.Navigator.DownColor := $6EBBFF;
      Footer.Navigator.BorderColor := clBlack;

      ItemAppearance.Splitter.ExpanderColor := $F9F8F8;
      ItemAppearance.Splitter.ExpanderHoverColor := $AAD9FF;
      ItemAppearance.Splitter.ExpanderDownColor := $6EBBFF;
      ItemAppearance.Splitter.ExpanderBorderColor := clBlack;        

      Header.Navigator.Color := $F9F8F8;
      Header.Navigator.HoverColor := $AAD9FF;
      Header.Navigator.DownColor := $6EBBFF;
      Header.Navigator.BorderColor := clBlack;

      with ItemAppearance.Splitter do
      begin
        Fill.Color := $AAD9FF;
        Fill.ColorTo := $6EBBFF;
        Fill.BorderColor := clBlack;
      end;
    
    end;
  tsWindowsXP: 
    begin
      Fill.Color := $00B6B6B6;
      Fill.ColorTo := $00B6B6B6;

      Header.Fill.Color := clBtnFace;
      Header.Fill.ColorTo := clBtnFace;
      Header.Font.Color := clBlack;
      Header.Fill.BorderColor := clBlack;

      Footer.Fill.Color := clBtnFace;
      Footer.Fill.ColorTo := clBtnFace;
      Footer.Font.Color := clBlack;
      Footer.Fill.BorderColor := clBlack;

      ItemAppearance.SelectedFill.Color := clInactiveCaption;
      ItemAppearance.SelectedFill.ColorTo := clInactiveCaption;
      ItemAppearance.SelectedFill.ColorMirror := clNone;
      ItemAppearance.SelectedFill.ColorMirrorTo := clNone;
      ItemAppearance.SelectedFill.BorderColor := clBlack;
      ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

      ItemAppearance.Fill.Color := clWhite;
      ItemAppearance.Fill.ColorTo := clBtnFace;
      ItemAppearance.Fill.ColorMirror := clNone;
      ItemAppearance.Fill.ColorMirrorTo := clNone;
      ItemAppearance.Fill.BorderColor := clBlack;
      ItemAppearance.Fill.GradientMirrorType := gtVertical;

      ItemAppearance.HoverFill.Color := clInactiveCaptionText;
      ItemAppearance.HoverFill.ColorTo := clInactiveCaptionText;
      ItemAppearance.HoverFill.ColorMirror := clNone;
      ItemAppearance.HoverFill.ColorMirrorTo := clNone;
      ItemAppearance.HoverFill.BorderColor := clBlack;
      ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

      ItemAppearance.DisabledFill.Color := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirror := clNone;
      ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
      ItemAppearance.DisabledFill.BorderColor := clBlack;
      ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

      Footer.Navigator.Color := clBtnFace;
      Footer.Navigator.HoverColor := clInActiveCaption;
      Footer.Navigator.DownColor := clInActiveCaption;
      Footer.Navigator.BorderColor := clBlack;

      ItemAppearance.Splitter.ExpanderColor := clBtnFace;
      ItemAppearance.Splitter.ExpanderHoverColor := clInActiveCaption;
      ItemAppearance.Splitter.ExpanderDownColor := clInActiveCaption;
      ItemAppearance.Splitter.ExpanderBorderColor := clBlack;       

      Header.Navigator.Color := clBtnFace;
      Header.Navigator.HoverColor := clInActiveCaption;
      Header.Navigator.DownColor := clInactiveCaptionText;
      Header.Navigator.BorderColor := clBlack;

      with ItemAppearance.Splitter do
      begin
        Fill.Color := clInActiveCaption;
        Fill.ColorTo := clInActiveCaption;
        Fill.BorderColor := clBlack;
      end;      
    end;
  tsWhidbey:
    begin
      Fill.Color := $F5F9FA;
      Fill.ColorTo := $F5F9FA;

      Header.Fill.Color := $EBEEEF;
      Header.Fill.ColorTo := $7E9898;
      Header.Font.Color := clWhite;
      Header.Fill.BorderColor := $962D00;

      Footer.Fill.Color := $EBEEEF;
      Footer.Fill.ColorTo := $7E9898;
      Footer.Font.Color := clWhite;
      Footer.Fill.BorderColor := $962D00;

      ItemAppearance.Fill.Color := $F5F9FA;
      ItemAppearance.Fill.ColorTo := $A8C0C0;
      ItemAppearance.Fill.ColorMirror := clNone;
      ItemAppearance.Fill.ColorMirrorTo := clNone;
      ItemAppearance.Fill.BorderColor := $962D00;
      ItemAppearance.Fill.GradientMirrorType := gtVertical;

      ItemAppearance.DisabledFill.Color := $00F2F2F2;
      ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirror := clNone;
      ItemAppearance.DisabledFill.ColorMirrorTo := clNone;
      ItemAppearance.DisabledFill.BorderColor := $962D00;
      ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

      ItemAppearance.HoverFill.Color := $94E6FB;
      ItemAppearance.HoverFill.ColorTo := $1595EE;
      ItemAppearance.HoverFill.ColorMirror := clNone;
      ItemAppearance.HoverFill.ColorMirrorTo := clNone;
      ItemAppearance.HoverFill.BorderColor := clBlack;
      ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

      ItemAppearance.SelectedFill.Color := $94E6FB;
      ItemAppearance.SelectedFill.ColorTo := $1595EE;
      ItemAppearance.SelectedFill.ColorMirror := clNone;
      ItemAppearance.SelectedFill.ColorMirrorTo := clNone;
      ItemAppearance.SelectedFill.BorderColor := $962D00;
      ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

      Footer.Navigator.Color := $F5F9FA;
      Footer.Navigator.HoverColor := $94E6FB;
      Footer.Navigator.DownColor := $1595EE;
      Footer.Navigator.BorderColor := clBlack;

      ItemAppearance.Splitter.ExpanderColor := $F5F9FA;
      ItemAppearance.Splitter.ExpanderHoverColor := $94E6FB;
      ItemAppearance.Splitter.ExpanderDownColor := $1595EE;
      ItemAppearance.Splitter.ExpanderBorderColor := clBlack;       

      Header.Navigator.Color := $F5F9FA;
      Header.Navigator.HoverColor := $94E6FB;
      Header.Navigator.DownColor := $1595EE;
      Header.Navigator.BorderColor := clBlack;

      with ItemAppearance.Splitter do
      begin
        Fill.Color := $94E6FB;
        Fill.ColorTo := $1595EE;
        Fill.BorderColor := $962D00;
      end;
    end;
  tsCustom: ;
  tsOffice2007Silver:
    begin
      Fill.Color := $00CAC1BA;
      Fill.ColorTo := $00CAC1BA;

      Header.Fill.Color := $F8F7F6;
      Header.Fill.ColorTo := $E8E0DB;
      Header.Font.Color := $8B4215;
      Header.Fill.BorderColor := $74706F;

      Footer.Fill.Color := $F8F7F6;
      Footer.Fill.ColorTo := $E8E0DB;
      Footer.Font.Color := $8B4215;
      Footer.Fill.BorderColor := $74706F;

      ItemAppearance.Fill.Color := $FAEEEB;
      ItemAppearance.Fill.ColorTo := $E5DBD7;
      ItemAppearance.Fill.ColorMirror := $E2D8D4;
      ItemAppearance.Fill.ColorMirrorTo := $D1C7C5;
      ItemAppearance.Fill.BorderColor := clBlack;//$E2D8D4;
      ItemAppearance.Fill.GradientMirrorType := gtVertical;

      ItemAppearance.SelectedFill.Color := $AAD9FF;
      ItemAppearance.SelectedFill.ColorTo := $6EBBFF;
      ItemAppearance.SelectedFill.ColorMirror := $42AEFE;
      ItemAppearance.SelectedFill.ColorMirrorTo := $7AE1FE;
      ItemAppearance.SelectedFill.BorderColor := clBlack;//$42AEFE;
      ItemAppearance.SelectedFill.GradientMirrorType := gtVertical;

      ItemAppearance.HoverFill.Color := $EBFDFF;
      ItemAppearance.HoverFill.ColorTo := $ACECFF;
      ItemAppearance.HoverFill.ColorMirror := $59DAFF;
      ItemAppearance.HoverFill.ColorMirrorTo := $A4E9FF;
      ItemAppearance.HoverFill.BorderColor := clBlack;//$42AEFE;
      ItemAppearance.HoverFill.GradientMirrorType := gtVertical;

      ItemAppearance.DisabledFill.Color := $00F2F2F2;
      ItemAppearance.DisabledFill.ColorTo := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirror := $00B6B6B6;
      ItemAppearance.DisabledFill.ColorMirrorTo := $00F2F2F2;
      ItemAppearance.DisabledFill.BorderColor := clBlack;//$00B6B6B6;
      ItemAppearance.DisabledFill.GradientMirrorType := gtVertical;

      Footer.Navigator.Color := $FAEEEB;
      Footer.Navigator.HoverColor := $AAD9FF;
      Footer.Navigator.DownColor := $6EBBFF;
      Footer.Navigator.BorderColor := clBlack;

      ItemAppearance.Splitter.ExpanderColor := $FAEEEB;
      ItemAppearance.Splitter.ExpanderHoverColor := $AAD9FF;
      ItemAppearance.Splitter.ExpanderDownColor := $6EBBFF;
      ItemAppearance.Splitter.ExpanderBorderColor := clBlack;          

      Header.Navigator.Color := $FAEEEB;
      Header.Navigator.HoverColor := $AAD9FF;
      Header.Navigator.DownColor := $6EBBFF;
      Header.Navigator.BorderColor := clBlack;

      with ItemAppearance.Splitter do
      begin
        Fill.Color := $AAD9FF;
        Fill.ColorTo := $6EBBFF;
        Fill.BorderColor := clBlack;
      end;
    end;
  end;
end;

procedure TAdvSmoothImageListBox.SetDefaultHTMLText(
  const Value: TAdvSmoothImageListBoxHTMLText);
begin
  if FDefaultHTMLText <> value then
  begin
    FDefaultHTMLText.Assign(value);
    DefaultHTMLTextChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBox.SetDefaultImage(const Value: TAdvGDIPPicture);
begin
  if FDefaultImage <> value then
  begin
    FDefaultImage.Assign(Value);
    DefaultImageChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBox.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBox.SetFocusColor(const Value: TColor);
begin
  if FFocusColor <> value then
  begin
    FFocusColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetFooter(
  const Value: TAdvSmoothImageListBoxFooter);
begin
  if FFooter <> value then
  begin
    FFooter := Value;
    FooterChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBox.SetHeader(
  const Value: TAdvSmoothImageListBoxHeader);
begin
  if FHeader <> value then
  begin
    FHeader.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetHover(const Value: Boolean);
begin
  if FHover <> value then
  begin
    FHover := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetItemAppearance(
  const Value: TAdvSmoothImageListBoxItemAppearance);
begin
  if FItemAppearance <> value then
  begin
    FItemAppearance.Assign(Value);
    ItemAppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBox.SetItems(
  const Value: TAdvSmoothImageListBoxItems);
begin
  if FItems <> value then
  begin
    FItems.Assign(Value);
    ItemsChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBox.SetKeyBoardLookUp(const Value: Boolean);
begin
  if FKeyBoardLookUp <> value then
  begin
    FKeyBoardLookUp := Value;
    FLookupKey := '';    
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetMultiSelect(const Value: Boolean);
begin
  if FMultiSelect <> value then
  begin
    FMultiSelect := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetRows(const Value: integer);
begin
  if (FRows <> value) then
  begin
    if FColumns <> 0 then
      FColumns := 0;

    FRows := Value;
    ItemAppearance.InitFills;
    InitListBoxItems;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetScrollBarPosition;
begin
  if (csDesigning in ComponentState) then
  begin
    if (Rows = 0) then
    begin
      FScrollBar.Height := 0;
      FScrollBar.Top := -Fscrollbar.Width;
    end;
    if (Columns = 0) then
    begin
      FScrollBar.Width := 0;
      FScrollBar.Left := -Fscrollbar.Height;
    end;

    Exit;
  end;

  if Columns = 0 then
  begin
    FScrollBar.Visible := FShowScrollBar and not ((Columns <> 0) and (Rows <> 0))
      and (FDisplayList.Count > 0) and (Items.Count > 0) and not FDesignTime {and (GetFullSize + Width > Width)};
  end
  else if Rows = 0 then
  begin
    FScrollBar.Visible := FShowScrollBar and not ((Columns <> 0) and (Rows <> 0))
      and (FDisplayList.Count > 0) and (Items.Count > 0) and not FDesignTime {and (GetFullSize + Height > Height)};
  end;

  FScrollBar.Ctl3D := false;
  FScrollBar.Position := GetPosition;
  FScrollBar.Max := GetFullSize;
  if Rows = 0 then
  begin
    FScrollBar.Kind := sbVertical;
    FScrollBar.Left := InsideRect.Right - GetScrollBarWidth - GetOuterBorderWidth;
    FScrollBar.Top := InsideRect.Top + Header.GetHeight;
    FScrollBar.Height := InsideRect.Bottom - InsideRect.Top - GetShadowOffset - Header.GetHeight - Footer.GetHeight;
    FScrollBar.LargeChange := ItemAppearance.ItemHeight;
  end
  else if Columns = 0 then
  begin
    FScrollBar.Kind := sbHorizontal;
    FScrollBar.Width := InsideRect.Right - InsideRect.Left - GetShadowOffset - 1;
    FScrollBar.Left := InsideRect.Left + 1;
    FScrollBar.Top := InsideRect.Bottom - Footer.GetHeight - GetShadowOffset - GetScrollBarHeight;
    FScrollBar.LargeChange := ItemAppearance.ItemWidth;    
  end;

  if Assigned(FOnScroll) then
    FOnScroll(Self, FScrollBar.Position);
end;

procedure TAdvSmoothImageListBox.SetSelectedItemIndex(const Value: Integer);
begin
  if FSelectedItemIndex <> value then
  begin
    FSelectedItemIndex := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetShowFocus(const Value: Boolean);
begin
  FShowFocus := Value;
end;

procedure TAdvSmoothImageListBox.SetShowScrollBar(const Value: Boolean);
begin
  if FShowScrollBar <> value then
  begin
    FShowScrollBar := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetSorted(const Value: boolean);
begin
  if FSorted <> value then
  begin
    FSorted := Value;
    if Value = True then
    begin
      Items.Sort;
   end;    
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetThreadLoading(
  const Value: TAdvSmoothImageThreadLoading);
begin
  if FThreadLoading <> value then
  begin
    FThreadLoading := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetTopLayerItems(
  const Value: TAdvSmoothImageListBoxTopLayerItems);
begin
  if FTopLayerItems <> value then
  begin
    FTopLayerItems.Assign(Value);
    TopLayerItemsChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBox.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> value then
  begin
    FTransparent := Value;
    InitListBoxItems;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetZoomMode(
  const Value: TAdvSmoothImageListBoxZoomMode);
begin
  if FZoomMode <> value then
  begin
    FZoomMode := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetZoomOnDblClick(const Value: Boolean);
begin
  if FZoomOnDblClick <> value then
  begin
    FZoomOnDblClick := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.SetZoomOnTop(const Value: Boolean);
begin
  if FZoomOnTop <> value then
  begin
    FZoomOnTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBox.StartThread;
begin
  if HandleAllocated and not Assigned(FImageLoaderThread) then
  begin
    FImageLoaderThread := TImageLoaderThread.Create(Self);
    FImageLoaderThread.Priority := tpLowest;
    FImageLoaderThread.OnTerminate := ThreadDone;
  end;
end;

procedure TAdvSmoothImageListBox.StopThread;
begin
  if Assigned(FImageLoaderThread) then
  begin
    FImageLoaderThread.Terminate;

    while not FThreadDone do
    begin
      Application.ProcessMessages;
    end;

    FreeAndNil(FImageLoaderThread);
  end;
  FRestartLoop := false;
  FStartImage := 0;
end;

procedure TAdvSmoothImageListBox.ThreadDone(Sender: TObject);
begin
  FThreadDone := true;
end;

procedure TAdvSmoothImageListBox.TopLayerItemsChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBox.UnMark;
begin
  FMarkCase := false;
  FMarkTag := '';
  FMark := '';
  Invalidate;
end;

procedure TAdvSmoothImageListBox.UnHighlight;
begin
  FMarkCase := false;
  FMarkTag := '';
  FMark := '';
  Invalidate;
end;

procedure TAdvSmoothImageListBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.Result := 0;
end;

procedure TAdvSmoothImageListBox.WMPaint(var Message: TWMPaint);
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


{ TAdvSmoothImageListBoxItems }

function TAdvSmoothImageListBoxItems.Add: TAdvSmoothImageListBoxItem;
begin
  Result := TAdvSmoothImageListBoxItem(inherited Add);
end;

procedure TAdvSmoothImageListBoxItems.BeginUpdate;
begin
  inherited;
  Inc(FUpdateCount);
  FOwner.StopThread;
end;

procedure TAdvSmoothImageListBoxItems.Clear;
begin
  if Count > 0 then
  begin
    FOwner.FDisplayList.Clear;
    BeginUpdate;
    try
      while Count > 0 do
        TCollectionItem(Items[Count - 1]).Free;
    finally
      EndUpdate;
    end;
  end;
end;

function TAdvSmoothImageListBoxItems.Compare(Item1, Item2: TAdvSmoothImageListBoxItem): integer;
var
  s1, s2: String;
begin
  s1 := UpperCase(FOwner.GetStrippedHTMLText(item1.Caption));
  s2 := UpperCase(FOwner.GetStrippedHTMLText(item2.Caption));

  if s1 < s2 then
    result :=  -1
  else if s1 > s2 then
    result := 1
  else result := 0
end;

function TAdvSmoothImageListBoxItems.CountSelected: integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
    if Self[i].Selected then
      Inc(Result);
end;

constructor TAdvSmoothImageListBoxItems.Create(AOwner: TAdvSmoothImageListBox);
begin
  inherited Create(TAdvSmoothImageListBoxItem);
  FOwner := AOwner;
end;

procedure TAdvSmoothImageListBoxItems.Delete(Index: Integer);
begin
  Items[Index].Free;
end;

procedure TAdvSmoothImageListBoxItems.EndUpdate;
begin
  inherited;
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
  begin
    FOwner.InitListBoxItems;
    FOwner.Changed;
  end;
  FOwner.StartThread;
end;

function TAdvSmoothImageListBoxItems.HasSplitters: boolean;
var
  i: integer;
begin
  Result := false;
  for i := 0 to Count - 1 do
  begin
    if Items[i].Splitter then
    begin
      Result := true;
      break;
    end;
  end;
end;

function TAdvSmoothImageListBoxItems.HasItems: boolean;
var
  i: integer;
begin
  Result := false;
  for i := 0 to Count - 1 do
  begin
    if not Items[i].Splitter then
    begin
      Result := true;
      break;
    end;
  end;
end;


function TAdvSmoothImageListBoxItems.FirstSplitter: integer;
begin
  Result := NextSplitter(-1);
end;

function TAdvSmoothImageListBoxItems.NextSplitter(index: integer): integer;
var
  i: integer;
begin
  Result := -1;
  for i := index + 1 to Count - 1 do
  begin
    if Items[i].Splitter then
    begin
      Result := i;
      break;
    end;
  end;
end;

function TAdvSmoothImageListBoxItems.Find(const s: string): integer;
var
  i: integer;
begin
  Result := -1;

  for i := 0 to Count - 1 do
  begin
    if (Items[i].Caption.Text = s) then
    begin
      Result := i;
      break;
    end;
  end;
end;

function TAdvSmoothImageListBoxItems.FirstItem: integer;
begin
  Result := NextItem(-1);
end;

function TAdvSmoothImageListBoxItems.NextItem(index: integer): integer;
var
  i: integer;
begin
  Result := -1;
  for i := index + 1 to Count - 1 do
  begin
    if not Items[i].Splitter then
    begin
      Result := i;
      break;
    end;
  end;
end;


function TAdvSmoothImageListBoxItems.GetItem(
  Index: Integer): TAdvSmoothImageListBoxItem;
begin
  Result := TAdvSmoothImageListBoxItem(inherited Items[Index]);
end;

function TAdvSmoothImageListBoxItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TAdvSmoothImageListBoxItems.Insert(
  Index: Integer): TAdvSmoothImageListBoxItem;
begin
  Result := TAdvSmoothImageListBoxItem(inherited Insert(Index));
end;

procedure TAdvSmoothImageListBoxItems.QuickSort(L, R: Integer);
var
  I, J, p: Integer;
  Save: TCollectionItem;
  SortList: TList;
begin
  //This cast allows us to get at the private elements in the base class
  SortList := TShadowedCollection(Self).FItems;

  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while Compare(Items[I], Items[P]) < 0 do
        Inc(I);
      while Compare(Items[J], Items[P]) > 0 do
        Dec(J);
      if I <= J then begin
        Save              := SortList.Items[I];
        SortList.Items[I] := SortList.Items[J];
        SortList.Items[J] := Save;
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(L, J);
    L := I;
  until I >= R;
end;

procedure TAdvSmoothImageListBoxItems.Select(AItems: array of Integer);
var
  i, si: integer;
begin
  BeginUpdate;
  for I := 0 to Length(AItems) - 1 do
  begin
    si := AItems[i];
    if (si > -1) and (si < Count) then
      self[si].Selected := true;
  end;
  EndUpdate;
end;

procedure TAdvSmoothImageListBoxItems.SelectAll;
var
  i: integer;
begin
  BeginUpdate;
  for I := 0 to Count - 1 do
    Self[I].Selected := true;
  EndUpdate;
end;

procedure TAdvSmoothImageListBoxItems.SetItem(Index: Integer;
  const Value: TAdvSmoothImageListBoxItem);
begin
  inherited Items[Index] := Value;
end;

procedure TAdvSmoothImageListBoxItems.Sort;
begin
  if Count > 1 then
    QuickSort(0, pred(Count));

  FOwner.InitListBoxItems;
  FOwner.Invalidate;
end;

procedure TAdvSmoothImageListBoxItems.UnSelectAll;
var
  i: integer;
begin
  BeginUpdate;
  for I := 0 to Count - 1 do
    Self[I].Selected := false;
  EndUpdate;
end;

{ TAdvSmoothImageListBoxItem }

procedure TAdvSmoothImageListBoxItem.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothImageListBoxItem then
  begin
    FImage.Assign((Source as TAdvSmoothImageListBoxItem).Image);
    FTag := (Source as TAdvSmoothImageListBoxItem).Tag;
    FCaption.Assign((Source as TAdvSmoothImageListBoxItem).Caption);
    FSplitterText := (Source as TAdvSmoothImageListBoxItem).SplitterText;
    FSplitter := (Source as TAdvSmoothImageListBoxItem).Splitter;
    FEnabled := (Source as TAdvSmoothImageListBoxItem).Enabled;
    FHint := (Source as TAdvSmoothImageListBoxItem).Hint;
    FVisible := (Source as TAdvSmoothImageListBoxItem).Visible;
    FFileDate := (Source as TAdvSmoothImageListBoxItem).FileDate;
    FFileSize := (Source as TAdvSmoothImageListBoxItem).FileSize;
    FFileName := (Source as TAdvSmoothImageListBoxItem).FileName;
    FSplitterState := (Source as TAdvSmoothImageListBoxItem).SplitterState;
    FSelected := (Source as TAdvSmoothImageListBoxItem).Selected;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.CaptionChanged(Sender: TObject);
begin
  changed;
end;

procedure TAdvSmoothImageListBoxItem.Changed;
begin
  with FOwner do
  begin
    if Items.FUpdateCount = 0 then
    begin
      InitListBoxItems;
      Changed;
    end;
  end;
end;

constructor TAdvSmoothImageListBoxItem.Create(Collection: TCollection);
begin
  inherited;
  FCollapsed := false;
  FSplitterState := stExpanded;
  FOwner := (Collection as TAdvSmoothImageListBoxItems).FOwner;
  FImage := TAdvGDIPPicture.Create;
  FImage.OnChange := ImageChanged;
  FCaption := TAdvSmoothImageListBoxHTMLText.Create(Self.FOwner);
  FCaption.OnChange := CaptionChanged;
  FFileSize := 0;
  FTag := 0;
  FSplitter := false;
  FCachedNormal := TGPBitmap.Create;
  FEnabled := true;
  FVisible := true;
  FSelExp := -1;
  FHovExp := -1;
  FSelected := false;
  FThreadStatus := stLoaded;
  with FOwner do
  begin
    if Items.FUpdateCount = 0 then
    begin
      InitListBoxItems;
      Changed;
    end;
  end;
end;

destructor TAdvSmoothImageListBoxItem.Destroy;
begin
  FImage.Free;
  FCaption.Free;
  if Assigned(FCachedNormal) then
    FCachedNormal.free;

  inherited;    

  with FOwner do
  begin
    if Items.FUpdateCount = 0 then
    begin
      InitListBoxItems;
      Changed;
    end;
  end;
end;

procedure TAdvSmoothImageListBoxItem.Draw(g: TGPGraphics; r: TGPRectF; dblclicked: Boolean);
var
  pt: TGPPointF;
  x, y: single;
  imgw, imgh: integer;
  rimg: TGPRectF;
begin
  with FOwner do
  begin
    if FVisible then
    begin
      if (FHoveredItemIndex = Index) and Hover then
      begin
        R.X := R.X - (FOwner.FItemAppearance.FHoverSize / 2);
        R.Y := R.Y - (FOwner.FItemAppearance.FHoverSize / 2);
        R.Width := R.Width + FOwner.FItemAppearance.FHoverSize;
        R.Height := R.Height + FOwner.FItemAppearance.FHoverSize;
      end;

      //draw image
      if (FThreadStatus = stLoaded) and Assigned(FCachedNormal) then
      begin
        if (FCachedNormal.Width > 0) and (FCachedNormal.Height > 0) then
        begin
          //IMAGE
          imgw := FCachedNormal.Width;
          imgh := FCachedNormal.Height;
          rimg := FOwner.GetItemImageRect(r);
          if ((rimg.Width > 0) and (rimg.Height > 0)) or FDoubleClicked then
          begin
            GetAspectSize(imgw, imgh, imgw, imgh, rimg.Width, rimg.Height);
            x := rimg.X + (rimg.Width - imgw) / 2;
            y := rimg.Y + (rimg.Height - imgh) / 2;
            pt := MakePoint(x, y);

            if not dblclicked then
            begin
              FX := Round(x);
              FY := Round(y);
              FWidth := Round(imgw);
              FHeight := Round(imgh);
            end;

            FXto := round(x);
            FYto := round(y);
            FWidthto := round(imgw);
            FHeightTo := round(imgh);

            g.DrawImage(FCachedNormal, FX, FY, FWidth, FHeight);
          end;
        end
        else
          DrawDefaultImage(Index, g, r);
      end
      else
        DrawDefaultImage(Index, g, r);
    end;
  end;
end;

procedure TAdvSmoothImageListBoxItem.DrawExpander(g: TGPGraphics; r: TGPRectF; Down, Hover: integer);
var
  ct: TColor;
  fl: TGDIPFill;
  globalr: TGPRectF;
  p: TGPPen;
begin
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  with FOwner.ItemAppearance.Splitter do
  begin
    globalr := r;
    fl := TGDIPFill.Create;
    fl.GradientType := gtVertical;
    fl.GradientMirrorType := gtVertical;
    case ExpanderShape of
      nsRounded:
      begin
        fl.RoundingType := rtBoth;
        fl.Rounding := Round(ExpanderSize / 2);
      end;
      nsRoundRect:
      begin
        fl.RoundingType := rtBoth;
        fl.Rounding := Round(ExpanderSize / 6);
      end;
    end;

    fl.BorderColor := ExpanderBorderColor;

    r := MakeRect(R.X, R.Y, ExpanderSize, ExpanderSize);
    if Down <> -1 then
    begin
      ct := ExpanderDownColor;
      fl.Color := Lighter(ct, 60);
      fl.ColorTo := ct;
      fl.ColorMirror := ct;
      fl.ColorMirrorTo := Lighter(ct, 25);
    end
    else if Hover <> -1 then
    begin
      ct := ExpanderHoverColor;
      fl.Color := Lighter(ct, 60);
      fl.ColorTo := ct;
      fl.ColorMirror := ct;
      fl.ColorMirrorTo := Lighter(ct, 25);
    end
    else
    begin
      ct := ExpanderColor;
      fl.Color := Lighter(ct, 60);
      fl.ColorTo := ct;
      fl.ColorMirror := ct;
      fl.ColorMirrorTo := Lighter(ct, 25);
    end;

    if ct <> clNone then
      fl.Fill(g, r);

    //DRAW SIGN
    p := TGPPen.Create(MakeColor(255, clBlack));
    if FOwner.Rows = 0 then
    begin
      if FCollapsed then
      begin
        g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 3 * 2), r.X + (r.Width / 3), r.Y + (r.Height / 3));
        g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 3 * 2), r.X + (r.Width / 3 * 2), r.Y + (r.Height / 3));
      end
      else
      begin
        g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 3), r.X + (r.Width / 3), r.Y + (r.Height / 3 * 2));
        g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 3), r.X + (r.Width / 3 * 2), r.Y + (r.Height / 3 * 2));
      end;
    end
    else if FOwner.Columns = 0 then
    begin
      if FCollapsed then
      begin
        g.DrawLine(p, r.X + (r.Width / 3), r.Y + (r.Height / 3), r.X + (r.Width / 3 * 2), r.Y + (r.Height / 2));
        g.DrawLine(p, r.X + (r.Width / 3), r.Y + (r.Height / 3 * 2), r.X + (r.Width / 3 * 2), r.Y + (r.Height / 2));
      end
      else
      begin
        g.DrawLine(p, r.X + (r.Width / 3 * 2), r.Y + (r.Height / 3), r.X + (r.Width / 3), r.Y + (r.Height / 2));
        g.DrawLine(p, r.X + (r.Width / 3 * 2), r.Y + (r.Height / 3 * 2), r.X + (r.Width / 3), r.Y + (r.Height / 2));
      end;
    end;

    p.Free;
    fl.Free;
  end;
  g.SetSmoothingMode(SmoothingModeDefault);  
end;

procedure TAdvSmoothImageListBoxItem.DrawSplitter(g: TGPGraphics; h: TAdvSmoothImageListBoxHTMLText; r: TGPRectF);
var
  rtext, rtextArea, rexp: TGPRectF;
begin
  with FOwner.ItemAppearance do
  begin
    rTextArea := Splitter.GetRect(r);

    if Fowner.Rows = 0 then
      rText := FOwner.GetHTMLTextRect(g, h, rTextArea, SplitterText)
    else if FOwner.Columns = 0 then
      rText := FOwner.GetTextRect(g, h, rTextArea, SplitterText);

    if Splitter.Size <= 2 then
    begin
      if FOwner.Rows = 0 then
      begin
        rtext.X := rtext.X - 2;
        rtext.Width := rtext.Width + 2;

        ExpanderTextRect(g, rText, rTextArea);
        rexp := Splitter.GetExpanderRect(rTextArea);

        case Splitter.TextLocation of
          cpCenterLeft:
          begin
            case Splitter.ExpanderLocation of
              cpCenterLeft, cpCenterCenter, cpCenterRight:
              begin
                Splitter.Fill.Fill(g, MakeRect(rText.X + rtext.Width, r.Y, rexp.X - rText.X - rtext.Width, r.Height));
                if Splitter.ExpanderLocation <> cpCenterRight then
                  Splitter.Fill.Fill(g, MakeRect(rexp.X + rexp.Width, r.Y, r.Width - rexp.Width - rexp.X, r.Height))
              end;
              else
              begin
                Splitter.Fill.Fill(g, MakeRect(rtext.X + rtext.Width, r.Y, r.Width - rtext.X - rtext.Width , r.Height));
              end;
            end;
          end;
          cpCenterCenter:
          begin
            case Splitter.ExpanderLocation of
              cpCenterCenter, cpCenterRight:
              begin
                Splitter.Fill.Fill(g, MakeRect(r.X, r.Y, rText.X, r.Height));
                if Splitter.ExpanderLocation <> cpCenterCenter then                
                  Splitter.Fill.Fill(g, MakeRect(rText.X + rtext.Width, r.Y, rexp.X - rText.X - rtext.Width, r.Height));
                if Splitter.ExpanderLocation <> cpCenterRight then
                  Splitter.Fill.Fill(g, MakeRect(rexp.X + rexp.Width, r.Y, r.Width - rexp.Width - rexp.X, r.Height))
              end;
              cpCenterLeft:
              begin
                Splitter.Fill.Fill(g, MakeRect(rexp.X + rexp.Width, r.Y, rText.X - rExp.X - rExp.Width, r.Height));
                Splitter.Fill.Fill(g, MakeRect(rText.X + rText.Width, r.Y, r.Width - rText.Width - rText.X, r.Height))
              end
              else
              begin
                Splitter.Fill.Fill(g, MakeRect(r.X, r.Y, rtext.X, r.Height));
                Splitter.Fill.Fill(g, MakeRect(rtext.X + rtext.Width, r.Y, r.Width - rtext.X - rtext.Width , r.Height));
              end;
            end;
          end;
          cpCenterRight:
          begin
            case Splitter.ExpanderLocation of
              cpCenterRight, cpCenterCenter, cpCenterLeft:
              begin
                if Splitter.ExpanderLocation <> cpCenterLeft then                
                  Splitter.Fill.Fill(g, MakeRect(r.X, r.Y, rExp.X, r.Height));
                Splitter.Fill.Fill(g, MakeRect(rexp.X + rexp.Width, r.Y, rText.X - rExp.X - rExp.Width, r.Height));
                if Splitter.TextLocation <> cpCenterRight then
                  Splitter.Fill.Fill(g, MakeRect(rText.X + rText.Width, r.Y, r.Width - rText.Width - rText.X, r.Height))
              end
              else
              begin
                Splitter.Fill.Fill(g, MakeRect(r.X, r.Y, rtext.X, r.Height));
                Splitter.Fill.Fill(g, MakeRect(rtext.X + rtext.Width, r.Y, r.Width - rtext.X - rtext.Width , r.Height));
              end;
            end;
          end;
          else
          begin
            case Splitter.ExpanderLocation of
              cpCenterRight, cpCenterCenter, cpCenterLeft:
              begin
                if Splitter.ExpanderLocation <> cpCenterLeft then
                  Splitter.Fill.Fill(g, MakeRect(r.X, r.Y, rexp.X, r.Height));
               if Splitter.ExpanderLocation <> cpCenterRight then
                  Splitter.Fill.Fill(g, MakeRect(rexp.X + rexp.Width, r.Y, r.Width - rexp.X - rexp.Width , r.Height));
              end;
              else
                Splitter.Fill.Fill(g, r);
            end;
          end;          
        end;
      end
      else if FOwner.Columns = 0 then
      begin
        rtext.Y := rtext.Y - 2;
        rtext.Height := rtext.Height + 2;

        ExpanderTextRect(g, rText, rTextArea);
        rexp := Splitter.GetExpanderRect(rTextArea);

        case Splitter.TextLocation of
          cpCenterLeft:
          begin
            case Splitter.ExpanderLocation of
              cpCenterLeft, cpCenterCenter, cpCenterRight:
              begin
                Splitter.Fill.Fill(g, MakeRect(r.X, rText.Y + rText.Height, r.Width, rexp.Y - rText.Y - rText.Height));
                if Splitter.ExpanderLocation <> cpCenterRight then
                  Splitter.Fill.Fill(g, MakeRect(r.X, rExp.Y + rExp.Height, r.Width, r.Height + r.Y - rexp.Height - rexp.Y));
              end;
              else
              begin
                Splitter.Fill.Fill(g, MakeRect(r.X, rText.Y + rText.Height, r.Width, r.Height + R.Y - rText.Y - rText.Height));
              end;
            end;
          end;
          cpCenterCenter:
          begin
            case Splitter.ExpanderLocation of
              cpCenterCenter, cpCenterRight:
              begin
                Splitter.Fill.Fill(g, MakeRect(r.X, r.Y, r.Width, rText.Y - R.Y));
                if Splitter.ExpanderLocation <> cpCenterCenter then                
                  Splitter.Fill.Fill(g, MakeRect(r.X, rText.Y + rText.Height, r.Width, rexp.Y - rText.Y - rText.Height));
                if Splitter.ExpanderLocation <> cpCenterRight then                
                  Splitter.Fill.Fill(g, MakeRect(r.X, rexp.Y + rexp.Height, r.Width, r.Height + R.Y - rexp.Height - rexp.Y))
              end;
              cpCenterLeft:
              begin
                Splitter.Fill.Fill(g, MakeRect(r.X, rexp.Y + rexp.Height, r.Width, rText.Y - rExp.Y - rExp.Height));
                Splitter.Fill.Fill(g, MakeRect(r.X, rText.Y + rText.Height, r.Width, r.Height + R.Y - rText.Height - rText.Y))
              end
              else
              begin
                Splitter.Fill.Fill(g, MakeRect(r.X, r.Y, r.Width, rText.Y - R.Y));
                Splitter.Fill.Fill(g, MakeRect(r.X, rText.Y + rText.Height, r.Width, r.Height + R.Y - rText.Y - rText.Height));
              end;
            end;
          end;
          cpCenterRight:
          begin
            case Splitter.ExpanderLocation of
              cpCenterRight, cpCenterCenter, cpCenterLeft:
              begin
                if Splitter.ExpanderLocation <> cpCenterLeft then
                  Splitter.Fill.Fill(g, MakeRect(r.X, r.Y, r.Width, rexp.Y - R.Y));
                Splitter.Fill.Fill(g, MakeRect(r.X, rexp.Y + rexp.Height, r.Width, rText.Y - rExp.Y - rExp.Height));
                if Splitter.TextLocation <> cpCenterRight then
                  Splitter.Fill.Fill(g, MakeRect(r.X, rText.Y + rText.Height, r.Width, r.Height + R.Y - rText.Height - rText.Y))
              end
              else
              begin
                Splitter.Fill.Fill(g, MakeRect(r.X, r.Y, r.Width, rText.Y - R.Y));
              end;
            end;
          end;
          else
          begin
            case Splitter.ExpanderLocation of
              cpCenterRight, cpCenterCenter, cpCenterLeft:
              begin
                if Splitter.ExpanderLocation <> cpCenterLeft then                
                  Splitter.Fill.Fill(g, MakeRect(r.X, r.Y, r.Width, rexp.Y - R.Y));
                if Splitter.ExpanderLocation <> cpCenterRight then
                  Splitter.Fill.Fill(g, MakeRect(r.X, rexp.Y + rexp.Height, r.Width, r.Height + R.Y - rexp.Y - rexp.Height));
              end;
              else
                Splitter.Fill.Fill(g, r);
            end;
          end;          
        end;
      end;
    end
    else
      Splitter.Fill.Fill(g, r);

    if FOwner.Columns = 0 then
    begin
      //Rotated non-HTML
      rtext.Y := rtext.Y + 2;
      rtext.Height := rtext.Height - 2;
      FOwner.DrawText(g, h, rText, h.Text);
    end
    else if FOwner.Rows = 0 then
    begin
      //HTML
      rtext.X := rtext.X + 2;
      rtext.Width := rtext.Width - 2;      
      FOwner.DrawHTMLText(g, h, rtext, h.Text);
    end;

    if Splitter.Expander then
      DrawExpander(g, rexp, FSelExp, FHovExp);
  end;
end;

procedure TAdvSmoothImageListBoxItem.ExpanderTextRect(g: TGPGraphics; rText: TGPRectF; var rTextArea: TGPRectF);
begin
  with FOwner.ItemAppearance do
  begin
    if FOwner.Rows = 0 then
    begin
      case Splitter.TextLocation of
        cpTopLeft:
        begin
          case Splitter.ExpanderLocation of
            cpTopLeft: rtextArea.X := rText.X + rtext.Width;
          end;
        end;
        cpCenterLeft:
        begin
          case Splitter.ExpanderLocation of
            cpCenterLeft: rtextArea.X := rText.X + rtext.Width;
          end;
        end;
        cpBottomLeft:
        begin
          case Splitter.ExpanderLocation of
            cpBottomLeft: rtextArea.X := rText.X + rtext.Width;
          end;
        end;
        cpTopCenter:
        begin
          case Splitter.ExpanderLocation of
            cpTopCenter: rtextArea.Width := RTextArea.Width + rtext.Width + Splitter.ExpanderSize;
          end;
        end;
        cpCenterCenter:
        begin
          case Splitter.ExpanderLocation of
            cpCenterCenter: rtextArea.Width := RTextArea.Width + rtext.Width + Splitter.ExpanderSize;
          end;
        end;
        cpBottomCenter:
        begin
          case Splitter.ExpanderLocation of
            cpBottomCenter: rtextArea.Width := RTextArea.Width + rtext.Width + Splitter.ExpanderSize;
          end;
        end;
        cpTopRight:
        begin
          case Splitter.ExpanderLocation of
            cpTopRight: rtextArea.Width := rtextArea.Width - rtext.Width;
          end;
        end;
        cpCenterRight:
        begin
          case Splitter.ExpanderLocation of
            cpCenterRight: rtextArea.Width := rtextArea.Width - rtext.Width;
          end;
        end;
        cpBottomRight:
        begin
          case Splitter.ExpanderLocation of
            cpBottomRight: rtextArea.Width := rtextArea.Width - rtext.Width;
          end;
        end;
      end;
    end
    else if FOwner.Columns = 0 then
    begin
      case Splitter.TextLocation of
        cpTopLeft:
        begin
          case Splitter.ExpanderLocation of
            cpTopLeft: rtextArea.Y := rText.Y + rtext.Height;
          end;
        end;
        cpCenterLeft:
        begin
          case Splitter.ExpanderLocation of
            cpCenterLeft: rtextArea.Y := rText.Y + rtext.Height;
          end;
        end;
        cpBottomLeft:
        begin
          case Splitter.ExpanderLocation of
            cpBottomLeft: rtextArea.Y := rText.Y + rtext.Height;
          end;
        end;
        cpTopCenter:
        begin
          case Splitter.ExpanderLocation of
            cpTopCenter: rtextArea.Height := RTextArea.Height + rtext.Height + Splitter.ExpanderSize;
          end;
        end;
        cpCenterCenter:
        begin
          case Splitter.ExpanderLocation of
            cpCenterCenter: rtextArea.Height := RTextArea.Height + rtext.Height + Splitter.ExpanderSize;
          end;
        end;
        cpBottomCenter:
        begin
          case Splitter.ExpanderLocation of
            cpBottomCenter: rtextArea.Height := RTextArea.Height + rtext.Height + Splitter.ExpanderSize;
          end;
        end;
        cpTopRight:
        begin
          case Splitter.ExpanderLocation of
            cpTopRight: rtextArea.Height := rtextArea.Height - rtext.Height;
          end;
        end;
        cpCenterRight:
        begin
          case Splitter.ExpanderLocation of
            cpCenterRight: rtextArea.Height := rtextArea.Height - rtext.Height;
          end;
        end;
        cpBottomRight:
        begin
          case Splitter.ExpanderLocation of
            cpBottomRight: rtextArea.Height := rtextArea.Height - rtext.Height;
          end;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothImageListBoxItem.GetOriginalImageHeight: integer;
begin
  Result := Round(FOriginalImageHeight);
end;

function TAdvSmoothImageListBoxItem.GetOriginalImageWidth: integer;
begin
  Result := Round(FOriginalImageWidth);
end;

procedure TAdvSmoothImageListBoxItem.ImageChanged(Sender: TObject);
var
  ow, oh, nw, nh: Double;
  w, h: integer;
  glo: TGPGraphics;
  rimg: TGPRectF;
begin
  if Assigned(FImage) and (not FImage.Empty) then
  begin
    with FOwner do
    begin
      FThreadStatus := stInitialized;
      FOriginalImageWidth := Image.Width;
      FOriginalImageHeight := Image.Height;
      ow := Image.Width;
      oh := Image.Height;
      rimg := GetItemImageRect(MakeRect(0, 0, ItemAppearance.GetColumnWidth, ItemAppearance.GetRowHeight));
      nw := rimg.Width;
      nh := rimg.Height;

      GetAspectSize(w, h, ow, oh, nw, nh);

      if Assigned(FCachedNormal) then
        FCachedNormal.free;

      FCachedNormal := tgpbitmap.Create(w,h, PixelFormat32bppARGB);
      glo := TGPGraphics.Create(FCachedNormal);
      FImage.GDIPDraw(glo, Rect(0, 0, w,h));

      FPixelFormat := FImage.PixelFormat;
      FPixelDepth := FImage.PixelDepth;
      FHasPalette := FImage.HasPalette;
      FHasAlphaChannel := FImage.HasAlpha;

      FCachedMaxWidth := Max(Round(nw), FCachedMaxWidth);
      FCachedMaxHeight := Max(Round(nh), FCachedMaxHeight);

      glo.Free;
      if not (csDesigning in ComponentState) then
        FImage.Assign(nil);
      FThreadStatus := stLoaded;
      FUseThreading := false;
    end;
  end;

  if FOwner.Items.FUpdateCount = 0 then
  begin
    FOwner.InitListBoxItems;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetCaption(const Value: TAdvSmoothImageListBoxHTMLText);
begin
  if FCaption <> value then
  begin
    FCaption.Assign(Value);
    CaptionChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetFileDate(const Value: TDateTime);
begin
  if FFileDate <> value then
  begin
    FFileDate := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetFileName(const Value: string);
begin
  if FFileName <> value then
  begin
    FFileName := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetFileSize(const Value: integer);
begin
  if FFileSize <> value then
  begin
    FFileSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetHint(const Value: string);
begin
  if FHint <> value then
  begin
    FHint := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetImage(const Value: TAdvGDIPPicture);
begin
  if FImage <> value then
  begin
    FImage := Value;
    ImageChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetLocation(const Value: String);
begin
  if FLocation <> value then
  begin
    FLocation := Value;
    FThreadStatus := stInitialized;
    FOwner.FUseThreading := true;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetSelected(const Value: boolean);
begin
  if FSelected <> value then
  begin
    FSelected := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetSplitter(const Value: Boolean);
begin
  if FSplitter <> value then
  begin
    FSplitter := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetSplitterState(
  const Value: TAdvSmoothImageListBoxSplitterState);
var
  spl: integer;
begin
  if FSplitterState <> value then
  begin
    spl := Index;
    spl := spl + 1;
    FSplitterState := Value;
    case FSplitterState of
      stExpanded: FCollapsed := false;
      stCollapsed: FCollapsed := true;
    end;
    
    if spl < FOwner.FItems.Count then
    begin
      while FOwner.FItems[spl].FSplitter = false do
      begin
        FOwner.FItems[spl].FCollapsed := FCollapsed;
        Inc(spl);
        if (spl = FOwner.Items.Count) then
          break;
      end;
    end;
    
    if FOwner.FItems.FUpdateCount = 0 then
    begin
      FOwner.InitlistboxItems;
      Changed;
    end;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetSplitterText(const Value: String);
begin
  if FSplitterText <> value then
  begin
    FSplitterText := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetTag(const Value: integer);
begin
  if FTag <> value then
  begin
    FTag := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItem.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TAdvSmoothImageListBoxItemAppearance }

procedure TAdvSmoothImageListBoxItemAppearance.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothImageListBoxItemAppearance then
  begin
    FImageTop := (Source as TAdvSmoothImageListBoxItemAppearance).ImageTop;
    FImageLeft := (Source as TAdvSmoothImageListBoxItemAppearance).ImageLeft;
    FImageWidth := (Source as TAdvSmoothImageListBoxItemAppearance).ImageWidth;
    FImageHeight := (Source as TAdvSmoothImageListBoxItemAppearance).ImageHeight;
    FTextTop := (Source as TAdvSmoothImageListBoxItemAppearance).TextTop;
    FTextLeft := (Source as TAdvSmoothImageListBoxItemAppearance).TextLeft;
    FTextWidth := (Source as TAdvSmoothImageListBoxItemAppearance).TextWidth;
    FTextHeight := (Source as TAdvSmoothImageListBoxItemAppearance).TextHeight;
    FTextMargin.Assign((Source as TAdvSmoothImageListBoxItemAppearance).TextMargin);
    FImageMargin.Assign((Source as TAdvSmoothImageListBoxItemAppearance).ImageMargin);
    FItemHeight := (Source as TAdvSmoothImageListBoxItemAppearance).ItemHeight;
    FItemWidth := (Source as TAdvSmoothImageListBoxItemAppearance).ItemWidth;
    FFill.Assign((Source as TAdvSmoothImageListBoxItemAppearance).Fill);
    FHoverFill.Assign((Source as TAdvSmoothImageListBoxItemAppearance).HoverFill);
    FDisabledFill.Assign((Source as TAdvSmoothImageListBoxItemAppearance).DisabledFill);
    FSelectedFill.Assign((Source as TAdvSmoothImageListBoxItemAppearance).SelectedFill);
    FItemHorizontalSpacing := (Source as TAdvSmoothImageListBoxItemAppearance).ItemHorizontalSpacing;
    FItemVerticalSpacing := (Source as TAdvSmoothImageListBoxItemAppearance).ItemVerticalSpacing;
    FSplitter.Assign((Source as TAdvSmoothImageListBoxItemAppearance).Splitter);
    FHoverSize := (Source as TAdvSmoothImageListBoxItemAppearance).HoverSize;
    FAutoSize := (Source as TAdvSmoothImageListBoxItemAppearance).AutoSize;
    FTextVisible := (Source as TAdvSmoothImageListBoxItemAppearance).TextVisible;
    FImageVisible := (Source as TAdvSmoothImageListBoxItemAppearance).ImageVisible;
    FAspectRatio := (Source as TAdvSmoothImageListBoxItemAppearance).AspectRatio;
    FStretch := (Source as TAdvSmoothImageListBoxItemAppearance).Stretch;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.Changed;
begin
  FOwner.Changed;
end;

procedure TAdvSmoothImageListBoxItemAppearance.CheckItemWidth;
var
  w: Single;
  i: integer;
  item: TAdvSmoothImageListBoxItem;
begin
  if FOwner.FUseThreading then
  begin
    w := FOwner.GetItemImageRect(MakeRect(0, 0, GetColumnWidth, GetRowHeight)).Width;
    for I := 0 to FOwner.FDisplayList.Count - 1 do
    begin
      item := FOwner.FDisplayList.GetItem(I).FItem;
      if item <> nil then
      begin
        with item do
        begin
          if (FThreadStatus = stLoaded) then
          begin
            if (w > FCachedMaxWidth * RELOADFACTOR) and (w <= FOriginalImageWidth) then
            begin
              FThreadStatus := stInitialized;
              FOwner.FRestartLoop := true;
            end;
          end;
        end;
      end;
    end;
  
    if FOwner.FRestartLoop then
      FOwner.FStartImage := FOwner.GetFirstVisibleItem;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.CheckItemHeight;
var
  h: single;
  i: integer;
  item: TAdvSmoothImageListBoxItem;
begin
  if FOwner.FUseThreading then
  begin
    h := FOwner.GetItemImageRect(MakeRect(0, 0, GetColumnWidth, GetRowHeight)).Height;
    for I := 0 to FOwner.FDisplayList.Count - 1 do
    begin
      item := FOwner.FDisplayList.GetItem(I).FItem;
      if item <> nil then
      begin
        with item do
        begin
          if (FThreadStatus = stLoaded) then
          begin
            if (h > FCachedMaxHeight * RELOADFACTOR) and (h <= FOriginalImageHeight) then
            begin
              FThreadStatus := stInitialized;
              FOwner.FRestartLoop := true;
            end;
          end;
        end;
      end;
    end;

    if FOwner.FRestartLoop then
      FOwner.FStartImage := FOwner.GetFirstVisibleItem;
  end;
end;

constructor TAdvSmoothImageListBoxItemAppearance.Create(
  AOwner: TAdvSmoothImageListBox);
begin
  FOwner := AOwner;
  FAspectRatio := true;
  FAutoSize := false;
  FTextVisible := false;
  FTextAlign := alBottom;
  FTextLeft := 10;
  FTextTop := 10;
  FTextHeight := 10;
  FTextWidth := 10;
  FTextMargin := TMargins.Create(nil);
  FTextMargin.OnChange := MarginChanged;
  FImageVisible := true;
  FImageAlign := alClient;
  FImageLeft := 10;
  FImageTop := 10;
  FImageHeight := 50;
  FImageWidth := 50;
  FImageMargin := TMargins.Create(nil);
  FImageMargin.OnChange := MarginChanged;
  FItemHeight := 70;
  FItemWidth := 70;
  FItemHorizontalSpacing := 10;
  FItemVerticalSpacing := 10;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FSelectedFill := TGDIPFill.Create;
  FSelectedFill.OnChange := SelectedFillChanged;
  FDisabledFill := TGDIPFill.Create;
  FDisabledFill.OnChange := DisabledFillChanged;
  FHoverFill := TGDIPFill.Create;
  FHoverFill.OnChange := HoveredFillChanged;
  FHoverSize := 0;
  FCachedFill := TGPBitmap.Create;
  FCachedSelectedFill := TGPBitmap.Create;
  FCachedDisabledFill := TGPBitmap.Create;
  FCachedHoveredFill := TGPBitmap.Create;
  FSplitter := TAdvSmoothImageListBoxSplitter.Create(FOwner);
  FSplitter.OnChange := SplitterChanged;
  FStretch := isAlways;
end;

destructor TAdvSmoothImageListBoxItemAppearance.Destroy;
begin
  if Assigned(FCachedFill) then
    FCachedFill.Free;

  if Assigned(FCachedSelectedFill) then
    FCachedSelectedFill.Free;

  if Assigned(FCachedDisabledFill) then
    FCachedDisabledFill.Free;

  if Assigned(FCachedHoveredFill) then
    FCachedHoveredFill.Free;

  FFill.Free;
  FTextMargin.Free;
  FImageMargin.Free;
  FDisabledFill.Free;
  FSelectedFill.Free;
  FHoverFill.Free;
  FSplitter.Free;
  inherited;
end;

procedure TAdvSmoothImageListBoxItemAppearance.DisabledFillChanged(
  Sender: TObject);
var
  g: TGPGraphics;
  w, h: integer;
begin
  if Assigned(FCachedDisabledFill) then
    FCachedDisabledFill.Free;

  w := GetColumnWidth;
  h := GetRowHeight;

  FCachedDisabledFill := TGPBitmap.Create(w, h, PixelFormat32bppARGB);
  g := TGPGraphics.Create(FCachedDisabledFill);
  if (fill.RoundingType <> rtNone) and (fill.Rounding > 0) then
    g.SetSmoothingMode(SmoothingModeAntiAlias);

  FDisabledFill.Fill(g, MakeRect(0, 0, w - 1, h - 1));
  g.Free;
  Changed;
end;

procedure TAdvSmoothImageListBoxItemAppearance.DrawFocusRect(f: TGDIPFill; g: TGPGraphics;
  r, rpos: TGPRectF);
var
  pathfocus: TGPGraphicsPath;
  pfocus: TGPPen;
begin
  if FOwner.FFocused and Fowner.TabStop and Fowner.ShowFocus then
  begin
    r.X := rpos.X + r.X;
    r.Y := rpos.Y + r.y;
    pathfocus := CreateRoundRectangle(r, f.Rounding - f.BorderWidth, f.RoundingType, false);
    g.SetSmoothingMode(SmoothingModeDefault);
    pfocus := TGPPen.Create(MakeColor(255, Fowner.focuscolor), 1);
    pfocus.SetDashStyle(DashStyleDot);
    g.DrawPath(pfocus, pathfocus);
    pfocus.Free;
    pathfocus.Free;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.FillChanged(Sender: TObject);
var
  g: TGPGraphics;
  w, h: integer;
begin
  if Assigned(FCachedFill) then
    FCachedFill.Free;

  w := GetColumnWidth;
  h := GetRowHeight;

  FCachedFill := TGPBitmap.Create(w, h, PixelFormat32bppARGB);
  g := TGPGraphics.Create(FCachedFill);
  if (fill.RoundingType <> rtNone) and (fill.Rounding > 0) then
    g.SetSmoothingMode(SmoothingModeAntiAlias);

  FFill.Fill(g, MakeRect(0, 0, w - 1, h - 1));
  g.Free;
  Changed;
end;

function TAdvSmoothImageListBoxItemAppearance.GetColumnWidth: integer;
var
  scrl, w, cw: integer;
begin
  with FOwner do
  begin
    result := ItemAppearance.ItemWidth;

    scrl := 0;
    case FScrollBar.Kind of
      sbHorizontal: scrl := GetScrollBarHeight;
      sbVertical: scrl := GetScrollBarWidth;
    end;

    if Self.AutoSize then
    begin
      w := InsideRect.Right - InsideRect.Left - GetShadowOffset - scrl - ItemAppearance.ItemHorizontalSpacing;
      if Columns > 0 then
      begin
        cw := Round((w - (Columns * ItemAppearance.ItemHorizontalSpacing)) / Columns);
        if cw < ItemAppearance.ItemWidth then
          result := cw
      end;
    end;
  end;
end;

function TAdvSmoothImageListBoxItemAppearance.GetRowHeight: integer;
var
  scrl, h, rh: integer;
begin
  with FOwner do
  begin
    result := ItemAppearance.ItemHeight;

    scrl := 0;
    case FScrollBar.Kind of
      sbHorizontal: scrl := GetScrollBarHeight;
      sbVertical: scrl := GetScrollBarWidth;
    end;

    if Self.AutoSize then
    begin
      h := InsideRect.Bottom - InsideRect.Top - GetShadowOffset - Header.GetHeight - Footer.GetHeight - scrl - ItemAppearance.ItemVerticalSpacing;
      if Rows > 0 then
      begin
        rh := Round((h - (Rows * ItemAppearance.ItemVerticalSpacing)) / Rows);
        if rh < ItemAppearance.ItemHeight then
          result := rh
      end;
    end;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.HoveredFillChanged(
  Sender: TObject);
var
  g: TGPGraphics;
  w, h: integer;
begin
  if Assigned(FCachedHoveredFill) then
    FCachedHoveredFill.Free;

  w := GetColumnWidth;
  h := GetRowHeight;

  FCachedHoveredFill := TGPBitmap.Create(w, h, PixelFormat32bppARGB);
  g := TGPGraphics.Create(FCachedHoveredFill);
  if (fill.RoundingType <> rtNone) and (fill.Rounding > 0) then
    g.SetSmoothingMode(SmoothingModeAntiAlias);
  FHoverFill.Fill(g, MakeRect(0, 0, w - 1, h - 1));
  g.Free;
  Changed;
end;

procedure TAdvSmoothImageListBoxItemAppearance.InitFills;
begin
  FillChanged(Self);
  DisabledFillChanged(Self);
  SelectedFillChanged(Self);
  HoveredFillChanged(Self);
end;

procedure TAdvSmoothImageListBoxItemAppearance.MarginChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SelectedFillChanged(
  Sender: TObject);
var
  g: TGPGraphics;
  w, h: integer;
begin
  if Assigned(FCachedSelectedFill) then  
    FCachedSelectedFill.Free;

  w := GetColumnWidth;
  h := GetRowHeight;

  FCachedSelectedFill := TGPBitmap.Create(w, h, PixelFormat32bppARGB);
  g := TGPGraphics.Create(FCachedSelectedFill);
  if (fill.RoundingType <> rtNone) and (fill.Rounding > 0) then
    g.SetSmoothingMode(SmoothingModeAntiAlias);
  FSelectedFill.Fill(g, MakeRect(0, 0, w - 1, h - 1));
  g.Free;
  Changed;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetAspectRatio(
  const Value: Boolean);
begin
  if FAspectRatio <> Value then
  begin
    FAspectRatio := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetAutoSize(
  const Value: Boolean);
begin
  if FAutoSize <> value then
  begin
    FAutoSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetDisabledFill(
  const Value: TGDIPFill);
begin
  if FDisabledFill <> value then
  begin
    FDisabledFill.Assign(value);
    DisabledFillChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetHoverFill(
  const Value: TGDIPFill);
begin
  if FHoverFill <> value then
  begin
    FHoverFill.Assign(Value);
    HoveredFillChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetHoverSize(
  const Value: integer);
begin
  if FHoverSize <> value then
  begin
    FHoverSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetItemHorizontalSpacing(
  const Value: integer);
begin
  if FItemHorizontalSpacing <> value then
  begin
    FItemHorizontalSpacing := Value;
    FOwner.InitListBoxItems;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetItemVerticalSpacing(
  const Value: integer);
begin
  if FItemVerticalSpacing <> value then
  begin
    FItemVerticalSpacing := Value;
    FOwner.InitListBoxItems;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetImageAlign(
  const Value: TAlign);
begin
  if FImageAlign <> value then
  begin
    FImageAlign := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetImageHeight(
  const Value: integer);
begin
  if FImageHeight <> value then
  begin
    FImageHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetImageLeft(
  const Value: integer);
begin
  if FImageLeft <> value then
  begin
    FImageLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetImageMargin(
  const Value: TMargins);
begin
  if FImageMargin <> value then
  begin
    FImageMargin.Assign(value);
    MarginChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetImageTop(
  const Value: integer);
begin
  if FImageTop <> value then
  begin
    FImageTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetImageVisible(
  const Value: Boolean);
begin
  if FImageVisible <> value then
  begin
    FImageVisible := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetImageWidth(
  const Value: integer);
begin
  if FImageWidth <> value then
  begin
    FImageWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetItemHeight(
  const Value: integer);
begin
  if FItemHeight <> value then
  begin
    FItemHeight := Value;

    if FOwner.Items.FUpdateCount = 0 then
      FOwner.InitListBoxItems;

    CheckItemHeight;

    InitFills;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetItemWidth(
  const Value: integer);
begin
  if FItemWidth <> value then
  begin
    FItemWidth := Value;

    if FOwner.Items.FUpdateCount = 0 then
      FOwner.InitListBoxItems;

    CheckItemWidth;

    InitFills;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetSelectedFill(
  const Value: TGDIPFill);
begin
  if FSelectedFill <> value then
  begin
    FSelectedFill.Assign(value);
    SelectedFillChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetSplitter(
  const Value: TAdvSmoothImageListBoxSplitter);
begin
  if FSplitter <> value then
  begin
    FSplitter.Assign(Value);
    SplitterChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetStretch(
  const Value: TImageStretch);
begin
  if (FStretch <> Value) then
  begin
    FStretch := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetTextAlign(
  const Value: TAlign);
begin
  if FTextAlign <> value then
  begin
    FTextAlign := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetTextHeight(
  const Value: integer);
begin
  if FTextHeight <> value then
  begin
    FTextHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetTextLeft(
  const Value: integer);
begin
  if FTextLeft <> Value then
  begin
    FTextLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetTextMargin(
  const Value: TMargins);
begin
  if FTextMargin <> value then
  begin
    FTextMargin.Assign(Value);
    MarginChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetTextTop(const Value: integer);
begin
  if FTextTop <> value then
  begin
    FTextTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetTextVisible(
  const Value: Boolean);
begin
  if FTextVisible <> value then
  begin
    FTextVisible := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SetTextWidth(
  const Value: integer);
begin
  if FTextWidth <> value then
  begin
    FTextWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxItemAppearance.SplitterChanged(
  Sender: TObject);
begin
  Changed;
end;

{ TAdvSmoothImageListBoxHeader }

procedure TAdvSmoothImageListBoxHeader.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothImageListBoxHeader then
  begin
    FCaption := (Source as TAdvSmoothImageListBoxHeader).Caption;
    FCaptionLocation := (Source as TAdvSmoothImageListBoxHeader).CaptionLocation;
    FCaptionTop := (Source as TAdvSmoothImageListBoxHeader).CaptionTop;
    FCaptionLeft := (Source as TAdvSmoothImageListBoxHeader).CaptionLeft;
    FFill.Assign((Source as TAdvSmoothImageListBoxHeader).Fill);
    FHeight := (Source as TAdvSmoothImageListBoxHeader).Height;
    FVisible := (Source as TAdvSmoothImageListBoxHeader).Visible;
    FFont.Assign((Source as TAdvSmoothImageListBoxHeader).Font);
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHeader.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothImageListBoxHeader.Create(AOwner: TAdvSmoothImageListBox);
begin
  FOwner := AOwner;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}
  FCaptionLocation := cpCenterCenter;
  FCaptionTop := 0;
  FCaptionLeft := 0;
  FHeight := 50;
  FVisible := true;
  FNavigator := TAdvSmoothImageListBoxNavigator.Create(FOwner);
  FNavigator.Visible := false;
  FNavigator.OnChange := NavigatorChanged;
end;

destructor TAdvSmoothImageListBoxHeader.Destroy;
begin
  FFill.Free;
  FFont.Free;
  FNavigator.Free;
  inherited;
end;

procedure TAdvSmoothImageListBoxHeader.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBoxHeader.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothImageListBoxHeader.GetHeight: integer;
begin
  Result := 0;
  if Visible then
    Result := Height;  
end;

function TAdvSmoothImageListBoxHeader.GetRect: TGPRectF;
var
  rc: TRect;
begin
  with FOwner do
  begin
    rc := InsideRect;
    Result := MakeRect(rc.Left, rc.Top, rc.Right - rc.Left - GetShadowOffset, Self.Height);
  end;
end;

procedure TAdvSmoothImageListBoxHeader.NavigatorChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBoxHeader.SetCaption(const Value: String);
begin
  if FCaption <> value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHeader.SetCaptionLeft(const Value: integer);
begin
  if FCaptionLeft <> value then
  begin
    FCaptionLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHeader.SetCaptionLocation(
  const Value: TAdvSmoothImageListBoxLocation);
begin
  if FCaptionLocation <> value then
  begin
    FCaptionLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHeader.SetCaptionTop(const Value: integer);
begin
  if FCaptionTop <> value then
  begin
    FCaptionTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHeader.SetFill(const Value: TGDIPFill);
begin
  if FFill <> Value then
  begin
    FFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxHeader.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHeader.SetHeight(const Value: integer);
begin
  if FHeight <> value then
  begin
    FHeight := Value;
    FOwner.InitListBoxItems;    
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHeader.SetNavigator(
  const Value: TAdvSmoothImageListBoxNavigator);
begin
  if FNavigator <> Value then
  begin
    FNavigator := Value;
    NavigatorChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxHeader.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    FOwner.InitListBoxItems;
    Changed;
  end;
end;

{ TAdvSmoothImageListBoxFooter }

procedure TAdvSmoothImageListBoxFooter.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothImageListBoxFooter then
  begin
    FCaption := (Source as TAdvSmoothImageListBoxFooter).Caption;
    FCaptionLocation := (Source as TAdvSmoothImageListBoxFooter).CaptionLocation;
    FCaptionTop := (Source as TAdvSmoothImageListBoxFooter).CaptionTop;
    FCaptionLeft := (Source as TAdvSmoothImageListBoxFooter).CaptionLeft;
    FFill.Assign((Source as TAdvSmoothImageListBoxFooter).Fill);
    FHeight := (Source as TAdvSmoothImageListBoxFooter).Height;
    FVisible := (Source as TAdvSmoothImageListBoxFooter).Visible;
    FFont.Assign((Source as TAdvSmoothImageListBoxFooter).Font);
    FNavigator.Assign((Source as TAdvSmoothImageListBoxFooter).Navigator);
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxFooter.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothImageListBoxFooter.Create(AOwner: TAdvSmoothImageListBox);
begin
  FOwner := AOwner;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}  
  FCaptionLocation := cpCenterCenter;
  FCaptionTop := 0;
  FCaptionLeft := 0;
  FHeight := 50;
  FVisible := true;
  FNavigator := TAdvSmoothImageListBoxNavigator.Create(Fowner);
  FNavigator.Visible := true;  
  FNavigator.OnChange := NavigatorChanged;
end;

destructor TAdvSmoothImageListBoxFooter.Destroy;
begin
  FFill.Free;
  FFont.Free;
  FNavigator.Free;  
  inherited;
end;

procedure TAdvSmoothImageListBoxFooter.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBoxFooter.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothImageListBoxFooter.GetHeight: integer;
begin
  Result := 0;
  if Visible then
    Result := Height;
end;

function TAdvSmoothImageListBoxFooter.GetRect: TGPRectF;
var
  rc: TRect;
begin
  with FOwner do
  begin
    rc := InsideRect;
    Result := MakeRect(rc.Left, rc.Bottom - Self.Height - GetShadowOffset, rc.Right - rc.Left - GetShadowOffset, Self.Height);
  end;
end;

procedure TAdvSmoothImageListBoxFooter.NavigatorChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBoxFooter.SetCaption(const Value: String);
begin
  if FCaption <> value then
  begin
    FCaption := value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxFooter.SetCaptionLeft(const Value: integer);
begin
  if FCaptionLeft <> value then
  begin
    FcaptionLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxFooter.SetCaptionLocation(
  const Value: TAdvSmoothImageListBoxLocation);
begin
  if FCaptionLocation <> value then
  begin
    FCaptionLocation := value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxFooter.SetCaptionTop(const Value: integer);
begin
  if FCaptionTop <> value then
  begin
    FCaptionTop := value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxFooter.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxFooter.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(value);
    FontChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxFooter.SetHeight(const Value: integer);
begin
  if FHeight <> value then
  begin
    FHeight := value;
    FOwner.Changed;    
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxFooter.SetNavigator(
  const Value: TAdvSmoothImageListBoxNavigator);
begin
  if FNavigator <> value then
  begin
    FNavigator.Assign(Value);
    NavigatorChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxFooter.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := value;
    FOwner.InitListBoxItems;
    Changed;
  end;
end;

{ TAdvSmoothImageListBoxDisplayListItem }

procedure TAdvSmoothImageListBoxDisplayListItem.Changed;
begin

end;

procedure TAdvSmoothImageListBoxDisplayListItem.SetKind(
  const Value: TAdvSmoothImageListBoxItemKind);
begin
  if FKind <> value then
  begin
    FKind := Value;
    Changed;
  end;
end;

{ TAdvSmoothListBoxDisplayList }

function TAdvSmoothImageListBoxDisplayList.AddItem: TAdvSmoothImageListBoxDisplayListItem;
begin
  result := TAdvSmoothImageListBoxDisplayListItem.Create;
  add(result);
end;

procedure TAdvSmoothImageListBoxDisplayList.Clear;
var
  i: integer;
begin
  for i := Count - 1 downto 0 do
    TAdvSmoothImageListBoxDisplayListItem(Items[i]).Free;
  inherited;
end;

procedure TAdvSmoothImageListBoxDisplayList.DeleteItem(index: integer);
begin
  if Index < Count then
  begin
    TAdvSmoothImageListBoxDisplayListItem(Items[Index]).Free;
    Delete(index);
  end;
end;

function TAdvSmoothImageListBoxDisplayList.GetItem(
  index: integer): TAdvSmoothImageListBoxDisplayListItem;
begin
  Result := nil;
  if Index < Count then
    Result := TAdvSmoothImageListBoxDisplayListItem(Items[Index]);
end;

{ TImageLoaderThread }

constructor TImageLoaderThread.Create(AImageListBox: TAdvSmoothImageListBox);
begin
  ImageListBox := AImageListBox;
  inherited Create(False);
end;


function GetImageSizesFromFileName(FileName: String;var width,height: integer): boolean;
var
  sExt: String;
  w, h: Word;
begin
  Result := true;
  Width := 0;
  Height := 0;

  sExt := UpperCase(ExtractFileExt(FileName));

  if (sExt = '.JPG') or (sExt = '.JPEG') then
    GetJPGSize(FileName, w, h)
  else if sExt = '.PNG' then
    GetPNGSize(FileName, w, h)
  else if sExt = '.BMP' then
    GetBMPSize(FileName, w, h)
  else if sExt = '.TIFF' then
    GetTifSize(FileName, w, h)
  else if sExt = '.GIF' then
    GetGIFSize(FileName, w, h)
  else if sExt = '.ICO' then
    GetICOSize(FileName, w, h)
  else
  begin
    Result := false;
    w := 0;
    h := 0;
  end;

  width := w;
  Height := h;
end;


procedure TImageLoaderThread.Execute;
var
  i: integer;
  gotImage: boolean;
  ow, oh, nw, nh: Double;
  loading: Boolean;
  glo: TGPGraphics;
  gpimage: TGPImage;
  w, h: integer;
  rimg: TGPRectF;
  start: integer;
  picWidth,picHeight: integer;

begin
  if ImageListBox.FDesignTime and ImageListBox.FItemsInitialized then
    Exit;

  if ((ImageListBox.Rows <> 0) and (ImageListBox.Columns <> 0)) or (ImageListBox.Items.Count = 0) then
      Exit;

  while not Terminated do
  begin
    if ImageListBox.Items.FUpdateCount = 0 then
    begin
      gotImage := false;

      if ImageListBox.FRestartLoop then
      begin
        start := ImageListBox.FStartImage;
        ImageListBox.FRestartLoop := false;
      end
      else
        start := 0;

      for i := start to ImageListBox.Items.Count - 1 do
      begin
        if Terminated then
          break;

        if (i < ImageListbox.Items.Count) then
        with ImageListBox.Items[i] do
        begin
          if Terminated or ImageListBox.FRestartLoop then
            break;

          loading := false;

          case ImageListBox.ThreadLoading of
            tlAll: loading := true;
            tlOnDemand: loading := (ImageListBox.GetItemIsVisible(FItemRect));
            tlOnDemandAfterAnimation: loading := (ImageListBox.GetItemIsVisible(FItemRect)) and not ImageListBox.FAnimating;
          end;

          if (FThreadStatus = stInitialized) and loading and not (Index = ImageListBox.FPaintIndex) then
          begin
            rimg := ImageListBox.GetItemImageRect(MakeRect(0, 0, ImageListBox.ItemAppearance.GetColumnWidth, ImageListBox.ItemAppearance.GetRowHeight));

            if Assigned(FCachedNormal) then
              FreeAndNil(FCachedNormal);

            gotImage := true;
            FThreadStatus := stStarted;

            GetImageSizesFromFileName(Location, picWidth, picHeight);

            if not (picWidth = 0) or (picHeight = 0) then
            begin
              FOriginalImageWidth := picWidth;
              FOriginalImageHeight := picHeight;
              ow := picWidth;
              oh := picHeight;

              if not FDoubleClicked then
              begin
                nw := rimg.Width;
                nh := rimg.Height;
              end
              else
              begin
                nw := FOriginalImageWidth;
                nh := FOriginalImageHeight;
              end;

              ImageListBox.GetAspectSize(w, h, ow, oh, nw, nh);

              gpimage := tgpimage.Create(Location);

              FCachedNormal := tgpbitmap.Create(w,h, gpimage.GetPixelFormat);
              FPixelFormat := FCachedNormal.GetPixelFormat;
              FPixelDepth := FCachedNormal.GetPixelDepth;
              FHasPalette := FCachedNormal.HasPalette;
              FHasAlphaChannel := FCachedNormal.HasAlphaChannel;

              glo := TGPGraphics.Create(FCachedNormal);
              glo.DrawImageRect(gpimage, 0,0, w,h);
              FCachedMaxWidth := Max(Round(nw), FCachedMaxWidth);
              FCachedMaxHeight := Max(Round(nh), FCachedMaxHeight);
              glo.Free;
              gpimage.Free;
              FThreadStatus := stLoaded;
            end
            else
              FCachedNormal := nil;

            if Terminated then
              break;

            if (ImageListBox.GetItemIsVisible(FItemRect)) then
              ImageListBox.Changed;
          end;
        end;
        if not gotImage then sleep(10);
      end;
    end;
  end;
end;

{ TAdvSmoothImageListBoxHTMLText }

procedure TAdvSmoothImageListBoxHTMLText.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothImageListBoxHTMLText) then
  begin
    FText := (Source as TAdvSmoothImageListBoxHTMLText).Text;
    FURLColor := (Source as TAdvSmoothImageListBoxHTMLText).URLColor;
    FShadowOffset := (Source as TAdvSmoothImageListBoxHTMLText).ShadowOffset;
    FFont.Assign((Source as TAdvSmoothImageListBoxHTMLText).Font);
    FShadowColor := (Source as TAdvSmoothImageListBoxHTMLText).ShadowColor;
    FLocation := (Source as TAdvSmoothImageListBoxHTMLText).Location;
    FLeft := (Source as TAdvSmoothImageListBoxHTMLText).Left;
    FTop := (Source as TAdvSmoothImageListBoxHTMLText).Top;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHTMLText.Changed;
begin
  if not FDisableRepaint then
    FOwner.Changed;
end;

constructor TAdvSmoothImageListBoxHTMLText.Create(
  AOwner: TAdvSmoothImageListBox);
begin
  FOwner := AOwner;
  FURLColor := clBlue;
  FShadowOffset := 5;
  FShadowColor := clGray;
  FLocation := cpTopLeft;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  {$IFNDEF DELPHI9_LVL}
  FDisableRepaint := true;
  FFont.Name := 'Tahoma';
  FDisableRepaint := false;
  {$ENDIF}  
  FTop := 0;
  FLeft := 0;
end;

destructor TAdvSmoothImageListBoxHTMLText.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TAdvSmoothImageListBoxHTMLText.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBoxHTMLText.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(value);
    FontChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxHTMLText.SetLeft(const Value: integer);
begin
  if FLeft <> value then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHTMLText.SetLocation(
  const Value: TAdvSmoothImageListBoxLocation);
begin
  if FLocation <> value then
  begin
    FLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHTMLText.SetShadowColor(const Value: TColor);
begin
  if FShadowColor <> value then
  begin
    FShadowColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHTMLText.SetShadowOffset(const Value: integer);
begin
  if FShadowOffset <> value then
  begin
    FShadowOffset := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHTMLText.SetText(const Value: string);
begin
  if FText <> value then
  begin
    FText := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHTMLText.SetTop(const Value: integer);
begin
  if FTop <> value then
  begin
    FTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxHTMLText.SetURLColor(const Value: TColor);
begin
  if FURLColor <> value then
  begin
    FURLColor := Value;
    Changed;
  end;
end;

{ TAdvSmoothImageListBoxTopLayerItem }

procedure TAdvSmoothImageListBoxTopLayerItem.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothImageListBoxTopLayerItem then
  begin
    FHTMLText.Assign((Source as TAdvSmoothImageListBoxTopLayerItem).HTMLText);
    FVisible := (Source as TAdvSmoothImageListBoxTopLayerItem).Visible;
    FTop := (Source as TAdvSmoothImageListBoxTopLayerItem).Top;
    FLeft := (Source as TAdvSmoothImageListBoxTopLayerItem).Left;
    FHeight := (Source as TAdvSmoothImageListBoxTopLayerItem).Height;
    FWidth := (Source as TAdvSmoothImageListBoxTopLayerItem).Width;
    FFill.Assign((Source as TAdvSmoothImageListBoxTopLayerItem).Fill);
    FAlign := (Source as TAdvSmoothImageListBoxTopLayerItem).Align;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.HTMLTextChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.Changed;
begin
  Fowner.Invalidate;
end;

constructor TAdvSmoothImageListBoxTopLayerItem.Create(Collection: TCollection);
begin
  inherited;
  FAlign := alCustom;
  FOwner := (Collection as TAdvSmoothImageListBoxTopLayerItems).FOwner;
  FHTMLText := TAdvSmoothImageListBoxHTMLText.Create(FOwner);
  FHTMLText.OnChange := HTMLTextChanged;
  FWidth := 100;
  FHeight := 100;
  FVisible := true;
  FLeft := 0;
  FTop := 0;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FOwner.Changed;
end;

destructor TAdvSmoothImageListBoxTopLayerItem.Destroy;
begin
  FHTMLText.Free;
  FFill.Free;
  FOwner.Changed;
  inherited;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.Draw(g: TGPGraphics; r: TGPRectF);
var
  rd: TGPRectF;
begin
  if FVisible then
  begin
    if (FFill.Rounding > 0) and (FFill.RoundingType <> rtNone) then
      g.SetSmoothingMode(SmoothingModeAntiAlias);
    //FILL
    case Align of
      alNone:;
      alTop: rd := MakeRect(r.X, r.Y, r.Width - r.X, FHeight);
      alBottom: rd := MakeRect(r.X, R.Y + r.Height - FHeight, r.Width - r.X, FHeight);
      alLeft: rd := MakeRect(r.X, r.Y, FWidth, r.Height);
      alRight: rd := MakeRect(r.Width - FWidth, r.Y, FWidth, r.Height);
      alClient: rd := MakeRect(r.X, R.Y, R.Width - R.X, R.Height);
      alCustom: rd := MakeRect(r.X + FLeft, R.Y + FTop, FWidth, FHeight);
    end;

    if (Fill.BorderColor = clNone) or (Fill.BorderWidth = 0) then
      rd.Height := rd.Height + 1;

    Fill.Fill(g, rd);
    //HTML
    Fowner.DrawHTMLText(g, HTMLText, rd, HTMLText.Text);

    g.SetSmoothingMode(SmoothingModeDefault);
  end;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.SetAlign(const Value: TAlign);
begin
  if FAlign <> value then
  begin
    FAlign := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.SetHeight(const Value: integer);
begin
  if FHeight <> value then
  begin
    FHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.SetHTMLText(
  const Value: TAdvSmoothImageListBoxHTMLText);
begin
  if FHTMLText <> value then
  begin
    FHTMLText.Assign(value);
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.SetLeft(const Value: integer);
begin
  if FLeft <> value then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.SetTop(const Value: integer);
begin
  if FTop <> value then
  begin
    FTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxTopLayerItem.SetWidth(const Value: integer);
begin
  if FWidth <> value then
  begin
    FWidth := Value;
    Changed;
  end;
end;

{ TAdvSmoothImageListBoxTopLayerItems }

function TAdvSmoothImageListBoxTopLayerItems.Add: TAdvSmoothImageListBoxTopLayerItem;
begin
  Result := TAdvSmoothImageListBoxTopLayerItem(inherited Add);
end;

constructor TAdvSmoothImageListBoxTopLayerItems.Create(
  AOwner: TAdvSmoothImageListBox);
begin
  inherited Create(TAdvSmoothImageListBoxTopLayerItem);
  FOwner := AOwner;
end;

procedure TAdvSmoothImageListBoxTopLayerItems.Delete(Index: Integer);
begin
  Items[Index].Free;
end;

function TAdvSmoothImageListBoxTopLayerItems.GetItem(
  Index: Integer): TAdvSmoothImageListBoxTopLayerItem;
begin
  Result := TAdvSmoothImageListBoxTopLayerItem(inherited Items[Index]);
end;

function TAdvSmoothImageListBoxTopLayerItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TAdvSmoothImageListBoxTopLayerItems.Insert(
  Index: Integer): TAdvSmoothImageListBoxTopLayerItem;
begin
  Result := TAdvSmoothImageListBoxTopLayerItem(inherited Insert(Index));
end;

procedure TAdvSmoothImageListBoxTopLayerItems.SetItem(Index: Integer;
  const Value: TAdvSmoothImageListBoxTopLayerItem);
begin
  inherited Items[Index] := Value;
end;

{ TAdvSmoothImageListBoxNavigator }

procedure TAdvSmoothImageListBoxNavigator.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothImageListBoxNavigator then
  begin
    FVisible := (Source as TAdvSmoothImageListBoxNavigator).Visible;
    FShape := (Source as TAdvSmoothImageListBoxNavigator).Shape;
    FColor := (Source as TAdvSmoothImageListBoxNavigator).Color;
    FDownColor := (Source as TAdvSmoothImageListBoxNavigator).DownColor;
    FHoverColor := (Source as TAdvSmoothImageListBoxNavigator).FHoverColor;
    FSize := (Source as TAdvSmoothImageListBoxNavigator).Size;
    FLocation := (Source as TAdvSmoothImageListBoxNavigator).Location;
    FLeft := (Source as TAdvSmoothImageListBoxNavigator).Left;
    FTop := (Source as TAdvSmoothImageListBoxNavigator).Top;
    FBorderColor := (Source as TAdvSmoothImageListBoxNavigator).BorderColor;
    FDisabledColor := (Source as TAdvSmoothImageListBoxNavigator).DisabledColor;
    FHintNext := (Source as TAdvSmoothImageListBoxNavigator).HintNext;
    FHintPreviousPage := (Source as TAdvSmoothImageListBoxNavigator).HintPreviousPage;
    FHintNextPage := (Source as TAdvSmoothImageListBoxNavigator).HintNextPage;
    FHintPrevious := (Source as TAdvSmoothImageListBoxNavigator).HintPrevious;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothImageListBoxNavigator.Create(
  AOwner: TAdvSmoothImageListBox);
begin
  FDisabledColor := clDkGray;
  FOwner := AOwner;
  FVisible := false;
  FColor := clGray;
  FDownColor := clRed;
  FHoverColor := clBlue;
  FSize := 20;
  FShape := nsRoundRect;
  FLocation := cpCenterRight;
  FBorderColor := clGray;
  FTop := 0;
  FLeft := 0;
  FHintNext := 'Next Item';
  FHintPrevious := 'Previous Item';
  FHintNextPage := 'Next Page';
  FHintPreviousPage := 'Previous Page';
end;

destructor TAdvSmoothImageListBoxNavigator.Destroy;
begin
  inherited;
end;

procedure TAdvSmoothImageListBoxNavigator.Draw(r: TGPRectF; Down, Hover: integer);
var
  g: TGPGraphics;
  ct: TColor;
  fl: TGDIPFill;
  globalr: TGPRectF;
  i: integer;
  p: TGPPen;
  count: integer;
begin
  g := TGPGraphics.Create(FOwner.Canvas.Handle);
  if (Shape <> nsRect) then
    g.SetSmoothingMode(SmoothingModeAntiAlias);

  globalr := r;

  count := 0;
  for I := 0 to FOwner.FDisplayList.Count - 1 do
    if FOwner.FDisplayList.GetItem(i).Kind = ikItem then
      Inc(Count);

  fl := TGDIPFill.Create;
  fl.GradientType := gtVertical;
  fl.GradientMirrorType := gtVertical;
  case Shape of
    nsRounded:
    begin
      fl.RoundingType := rtBoth;
      fl.Rounding := Round(Size / 2);
    end;
    nsRoundRect:
    begin
      fl.RoundingType := rtBoth;
      fl.Rounding := Round(Size / 6);    
    end;
  end;

  fl.BorderColor := FBorderColor;

  p := TGPPen.Create(MakeColor(255, clBlack));

  for I := 0 to 3 do
  begin
    r := GetNavigatorButtonRect(globalr, I);
    ct := DisabledColor;    
    if (Count > 1) and (FOwner.FSelectedItemIndex <> -1) then
    begin
      if Hover = I then
      begin
        case I of
          0:
          begin
            if FOwner.SelectedItemIndex > 0 then
              ct := HoverColor
          end;
          1:
          begin
            if FOwner.SelectedItemIndex > 0 then
              ct := HoverColor
          end;
          2:
          begin
            if FOwner.SelectedItemIndex < count then
              ct := HoverColor
          end;
          3:
          begin
            if FOwner.SelectedItemIndex < count then
              ct := HoverColor
          end;
        end;
      end
      else if Down = I then
      begin
        case I of
          0:
          begin
            if FOwner.SelectedItemIndex > 0 then
              ct := DownColor
          end;
          1:
          begin
            if FOwner.SelectedItemIndex > 0 then
              ct := DownColor
          end;
          2:
          begin
            if FOwner.SelectedItemIndex < count then
              ct := DownColor
          end;
          3:
          begin
            if FOwner.SelectedItemIndex < count then
              ct := DownColor
          end;
        end;
      end
      else
      begin
        case I of
          0:
          begin
            if FOwner.SelectedItemIndex > 0 then
              ct := Color
          end;
          1:
          begin
            if FOwner.SelectedItemIndex > 0 then
              ct := Color
          end;
          2:
          begin
            if FOwner.SelectedItemIndex < count then
              ct := Color
          end;
          3:
          begin
            if FOwner.SelectedItemIndex < count then
              ct := Color
          end;
        end;
      end;
    end;

    fl.Color := Lighter(ct, 60);
    fl.ColorTo := ct;
    fl.ColorMirror := ct;
    fl.ColorMirrorTo := Lighter(ct, 25);
    fl.Fill(g, r);

    case I of
      0:
      begin
        g.DrawLine(p, r.X + (r.Width / 4 * 2), r.Y + (r.Height / 3), r.X + (r.Width / 4), r.Y + (r.Height / 2));
        g.DrawLine(p, r.X + (r.Width / 4 * 2), r.Y + (r.Height / 3 * 2), r.X + (r.Width / 4), r.Y + (r.Height / 2));
        g.DrawLine(p, r.X + (r.Width / 4 * 3), r.Y + (r.Height / 3), r.X + (r.Width / 4 * 2), r.Y + (r.Height / 2));
        g.DrawLine(p, r.X + (r.Width / 4 * 3), r.Y + (r.Height / 3 * 2), r.X + (r.Width / 4 * 2), r.Y + (r.Height / 2));
      end;
      1:
      begin
        g.DrawLine(p, r.X + (r.Width / 3 * 2), r.Y + (r.Height / 3), r.X + (r.Width / 3), r.Y + (r.Height / 2));
        g.DrawLine(p, r.X + (r.Width / 3 * 2), r.Y + (r.Height / 3 * 2), r.X + (r.Width / 3), r.Y + (r.Height / 2));
      end;
      2:
      begin
        g.DrawLine(p, r.X + (r.Width / 3), r.Y + (r.Height / 3), r.X + (r.Width / 3 * 2), r.Y + (r.Height / 2));
        g.DrawLine(p, r.X + (r.Width / 3), r.Y + (r.Height / 3 * 2), r.X + (r.Width / 3 * 2), r.Y + (r.Height / 2));
      end;
      3:
      begin
        g.DrawLine(p, r.X + (r.Width / 4), r.Y + (r.Height / 3), r.X + (r.Width / 4 * 2), r.Y + (r.Height / 2));
        g.DrawLine(p, r.X + (r.Width / 4), r.Y + (r.Height / 3 * 2), r.X + (r.Width / 4 * 2), r.Y + (r.Height / 2));
        g.DrawLine(p, r.X + (r.Width / 4 * 2), r.Y + (r.Height / 3), r.X + (r.Width / 4 * 3), r.Y + (r.Height / 2));
        g.DrawLine(p, r.X + (r.Width / 4 * 2), r.Y + (r.Height / 3 * 2), r.X + (r.Width / 4 * 3), r.Y + (r.Height / 2));
      end;
    end;
  end;

  p.Free;
  g.Free;
  fl.Free;
end;

procedure TAdvSmoothImageListBoxNavigator.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothImageListBoxNavigator.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothImageListBoxNavigator.GetNavigatorButtonRect(r: TGPRectF;
  Button: integer): TGPRectF;
begin
  Result := MakeRect(R.X + Button * (size + 3), R.Y, size, size);
end;

function TAdvSmoothImageListBoxNavigator.GetNavigatorRect(r: TGPRectF): TGPRectF;
var
  w, h, x, y: integer;
begin
  w := (Size + 3) * 4;
  h := Size;

  if FLocation <> cpCustom then
    GetObjectLocation(x, y, r, w, h, FLocation)
  else
  begin
    x := FLeft;
    y := FTop;
  end;

  case FLocation of
    cpTopLeft: Result := MakeRect(x + 3, y + 3, w, h);
    cpTopCenter: Result := MakeRect(x, y + 3, w, h);
    cpTopRight: Result := MakeRect(x, y + 3, w, h);
    cpCenterLeft: Result := MakeRect(x + 3, y, w, h);
    cpBottomLeft: Result := MakeRect(x + 3, y - 3, w, h);
    cpBottomCenter: Result := MakeRect(x, y - 3, w, h);
    cpBottomRight: Result := MakeRect(x, y - 3, w, h);
  else
    Result := MakeRect(x, y, w, h);
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetDisabledColor(const Value: TColor);
begin
  if FDisabledColor <> value then
  begin
    FDisabledColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetDownColor(const Value: TColor);
begin
  if FDownColor <> Value then
  begin
    FDownColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetHintNext(const Value: String);
begin
  if FHintNext <> value then
  begin
    FHintNext := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetHintNextPage(const Value: String);
begin
  if FHintNextPage <> value then
  begin
    FHintNextPage := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetHintPrevious(const Value: String);
begin
  if FHintPrevious <> value then
  begin
    FHintPrevious := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetHintPreviousPage(
  const Value: String);
begin
  if FHintPreviousPage <> value then
  begin
    FHintPreviousPage := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetHoverColor(const Value: TColor);
begin
  if FHoverColor <> value then
  begin
    FHoverColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetLeft(const Value: integer);
begin
  if FLeft <> value then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetLocation(
  const Value: TAdvSmoothImageListBoxLocation);
begin
  if FLocation <> value then
  begin
    FLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetShape(
  const Value: TAdvSmoothImageListBoxNavigatorButtonsShape);
begin
  if FShape <> Value then
  begin
    FShape := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetSize(const Value: integer);
begin
  if FSize <> value then
  begin
    FSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetTop(const Value: integer);
begin
  if FTop <> Value then
  begin
    FTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxNavigator.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TAdvSmoothImageListBoxSplitter }

procedure TAdvSmoothImageListBoxSplitter.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothImageListBoxSplitter) then
  begin
    FSpacing := (Source as TAdvSmoothImageListBoxSplitter).Spacing;
    FFill.Assign((Source as TAdvSmoothImageListBoxSplitter).Fill);
    FSize := (Source as TAdvSmoothImageListBoxSplitter).Size;
    FExpanderShape := (Source as TAdvSmoothImageListBoxSplitter).ExpanderShape;
    FExpanderColor := (Source as TAdvSmoothImageListBoxSplitter).ExpanderColor;
    FExpanderHoverColor := (Source as TAdvSmoothImageListBoxSplitter).ExpanderHoverColor;
    FExpanderDownColor := (Source as TAdvSmoothImageListBoxSplitter).ExpanderDownColor;
    FExpanderSize := (Source as TAdvSmoothImageListBoxSplitter).ExpanderSize;
    FExpander := (Source as TAdvSmoothImageListBoxSplitter).Expander;
    FExpanderLocation := (Source as TAdvSmoothImageListBoxSplitter).ExpanderLocation;
    FExpanderBorderColor := (Source as TAdvSmoothImageListBoxSplitter).ExpanderBorderColor;
    FExpanderLeft := (Source as TAdvSmoothImageListBoxSplitter).ExpanderLeft;
    FExpanderTop := (Source as TAdvSmoothImageListBoxSplitter).ExpanderTop;
    FTextFont.Assign((Source as TAdvSmoothImageListBoxSplitter).TextFont);
    FTextLocation := (Source as TAdvSmoothImageListBoxSplitter).TextLocation;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothImageListBoxSplitter.Create(
  AOwner: TAdvSmoothImageListBox);
begin
  FOwner := AOwner;
  FSpacing := 10;
  FSize := 3;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FExpanderShape := nsRounded;
  FExpanderColor := clGray;
  FExpanderHoverColor := clBlue;
  FExpanderDownColor := clRed;
  FExpanderSize := 20;
  FExpander := false;
  FExpanderLocation := cpCenterRight;
  FExpanderBorderColor := clBlack;
  FExpanderLeft := 0;
  FExpanderTop := 0;
  FTextFont := TFont.Create;
  FTextFont.OnChange := TextFontChanged;
  {$IFNDEF DELPHI9_LVL}
  FTextFont.Name := 'Tahoma';
  {$ENDIF}
  FTextLocation := cpCenterLeft;
end;

destructor TAdvSmoothImageListBoxSplitter.Destroy;
begin
  FTextFont.Free;
  FFill.Free;
  inherited;
end;

procedure TAdvSmoothImageListBoxSplitter.FillChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothImageListBoxSplitter.GetExpanderRect(r: TGPRectF): TGPRectF;
var
  w, h, x, y: integer;
  loc: TAdvSmoothImageListBoxLocation;
begin
  w := ExpanderSize;
  h := ExpanderSize;

  loc := FExpanderLocation;
  if Fowner.Columns = 0 then
  begin
    case FExpanderLocation of
      cpTopLeft: loc := cpTopRight;
      cpTopCenter: loc := cpCenterRight;
      cpTopRight: loc := cpBottomRight;
      cpCenterLeft: loc := cpTopCenter;
      cpCenterCenter: loc := cpCenterCenter;
      cpCenterRight: loc := cpBottomCenter;
      cpBottomLeft: loc := cpTopLeft;
      cpBottomCenter: loc := cpCenterLeft;
      cpBottomRight: loc := cpBottomLeft;
      cpCustom: loc := cpCustom;
    end;
  end;

  if loc <> cpCustom then
    GetObjectLocation(x, y, r, w, h, loc)
  else
  begin
    x := FExpanderLeft;
    y := FExpanderTop;
  end;

  Result := MakeRect(x, y, w, h);
end;

function TAdvSmoothImageListBoxSplitter.GetRect(r: TGPRectF): TGPRectF;
begin
  if FOwner.Rows = 0 then
    Result := MakeRect(R.X + 2, R.Y - (Spacing / 2), R.Width - 4, R.Height + Spacing)
  else if FOwner.Columns = 0 then
    Result := MakeRect(R.X - (Spacing  / 2), R.Y + 2, R.Width + Spacing, R.Height - 4);
end;

procedure TAdvSmoothImageListBoxSplitter.SetExpander(const Value: Boolean);
begin
  if FExpander <> value then
  begin
    FExpander := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetExpanderBorderColor(
  const Value: TColor);
begin
  if FExpanderBorderColor <> Value then
  begin
    FExpanderBorderColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetExpanderColor(const Value: TColor);
begin
  if FExpanderColor <> value then
  begin
    FExpanderColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetExpanderDownColor(
  const Value: TColor);
begin
  if FExpanderDownColor <> Value then
  begin
    FExpanderDownColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetExpanderHoverColor(
  const Value: TColor);
begin
  if FExpanderHoverColor <> Value then
  begin
    FExpanderHoverColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetExpanderLeft(const Value: Integer);
begin
  if FExpanderLeft <> value then
  begin
    FExpanderLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetExpanderLocation(
  const Value: TAdvSmoothImageListBoxLocation);
begin
  if FExpanderLocation <> value then
  begin
    FExpanderLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetExpanderShape(
  const Value: TAdvSmoothImageListBoxNavigatorButtonsShape);
begin
  if FExpanderShape <> value then
  begin
    FExpanderShape := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetExpanderSize(const Value: integer);
begin
  if FExpanderSize <> Value then
  begin
    FExpanderSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetExpanderTop(const Value: integer);
begin
  if FExpanderTop <> Value then
  begin
    FExpanderTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetSize(const Value: integer);
begin
  if FSize <> value then
  begin
    FSize := Value;
    FOwner.InitListBoxItems;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetSpacing(const Value: integer);
begin
  if FSpacing <> value then
  begin
    FSpacing := Value;
    FOwner.InitListBoxItems;
    changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetTextFont(const Value: TFont);
begin
  if FTextFont <> value then
  begin
    FTextFont.Assign(value);
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.SetTextLocation(
  const Value: TAdvSmoothImageListBoxLocation);
begin
  if FTextLocation <> value then
  begin
    FTextLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothImageListBoxSplitter.TextFontChanged(Sender: TObject);
begin
  Changed;
end;

{ TMargins }


{$IFNDEF DELPHI2006_LVL}

procedure TMargins.Assign(Source: TPersistent);
begin
  if Source is TMargins then
  begin
    FLeft := (Source as TMargins).Left;
    FTop := (Source as TMargins).Top;
    FRight := (Source as TMargins).Right;
    FBottom := (Source as TMargins).Bottom;
  end;
end;

procedure TMargins.Changed;
begin
  Fowner.Changed;
end;

constructor TMargins.Create(AOwner: TAdvSmoothImageListBox);
begin
  FLeft := 0;
  FBottom := 0;
  FRight := 0;
  FTop := 0;
end;

procedure TMargins.SetBottom(const Value: integer);
begin
  if FBottom <> value then
  begin
    FBottom := Value;
    Changed;
  end;
end;

procedure TMargins.SetLeft(const Value: integer);
begin
  if FLeft <> value then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TMargins.SetRight(const Value: integer);
begin
  if FRight <> value then
  begin
    FRight := Value;
    Changed;
  end;
end;

procedure TMargins.SetTop(const Value: integer);
begin
  if FTop <> value then
  begin
    FTop := Value;
    Changed;
  end;
end;

{$ENDIF}

{ TWinCtrl }

procedure TWinCtrl.PaintCtrls(DC: HDC; First: TControl);
begin
  PaintControls(DC, First);
end;

initialization
  RegisterClass(TAdvSmoothImageListBox);

end.
