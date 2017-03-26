{*************************************************************************}
{ TAdvSmoothListBox component                                             }
{ for Delphi & C++Builder                                                 }
{                                                                         }
{ written by TMS Software                                                 }
{           copyright � 2009                                              }
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

unit AdvSmoothListBox;

{$I TMSDEFS.INC}

interface

uses
  Forms, Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls,
  Comobj, Activex, AdvSmoothGDIP, AdvStyleIF, ImgList, AdvSmoothTheme,
  GDIPPictureContainer, ExtCtrls, Math, GDIPFill
  {$IFDEF TMSDOTNET}
  , Types
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 5; // Minor version nr.
  REL_VER = 1; // Release nr.
  BLD_VER = 2; // Build nr.

  // version history
  // v1.0.0.0 : first release
  // v1.0.1.0 : Fixed : issue with resize & detail control
  //          : Fixed : not fully hide detail control
  //          : Fixed : setting Items.SelectedItem programmatically updates list
  //          : Fixed : Items.SelectedItem set to nil when no item is selected
  //          : New : exposed Anchors, Constraints, PopupMenu
  //          : New : exposed OnMouseLeave, OnMouseEnter events
  // v1.0.2.0 : New : ScrollToItem method
  //          : New : Published property SelectedItemIndex
  //          : New : Selection mode to persist selection or auto deselect during scrolling
  //          : Fixed : focused item = last selected item
  // v1.1.0.0 : New : Exposed events OnItemMouseLeave, OnItemMouseEnter
  //          : New : Exposed events OnHeaderClick, OnFooterClick, OnLookupClick
  //          : New : Exposed events OnItemSelected, OnItemSelectionChanged
  //          : New : Exposed event OnItemHint with new item property Hint
  //          : New : function ItemAtXY(x, y: integer): integer to find the item at the given position (returns -1 when nothing is found)
  //          : New : Drag drop and reorganize items.
  //          : New : Exposed events OnItemDragStart, OnItemDragEnd, OnItemDragDrop, OnItemDragOver  
  //          : New : Multiselect items with mouse and keyboard.
  //          : New : Custom categories with improved lookupbar functionality
  //          : Fixed : Delete and free of item Access violation
  // v1.1.0.1 : Fixed : Access Violation Items.SelectedItem := nil;
  //          : Fixed : No keyboard OnItemSelected event & OnItemSelectionChanged event
  // v1.1.0.2 : Fixed : Issue with OnItemInfoClick
  // v1.1.0.3 : Fixed : List index out of bounds when hovering listbox and items.Count = 0;
  // v1.5.0.0 : New : SmoothButton and SmoothProgressBar in ListBoxItem
  //          : New : Mode sPersistAlways to MultiSelect items without keyboard.
  //          : New : Exposed event OnButtonClick.
  //          : New : Visible property
  //          : New : Item Grouping with Levels and Expanded State
  // v1.5.0.1 : Fixed : issue with progressbar with Maximum = Minimum
  // v1.5.0.2 : Fixed : issue with HTML anchor detection
  //          : Improved : ANSI sort order for items
  // v1.5.0.3 : Improved : Added lookupbar support for special characters (�, �, .. etc)
  // v1.5.0.4 : Fixed : Vertical line paint problem on right side of listbox
  // v1.5.0.5 : Improved : lookup support for special characters (�, �, .. etc)
  //          : Improved : item position after lookup click
  //          : Fixed : FHoveredItemIndex out of bounds when deleting item at runtime
  //          : Fixed : GetTopIndex and GetBottomIndex always returning 0 and DisplayList.Count - 1 causing slow painting of items
  //          : Fixed : Anchor click of Footer
  //          : Fixed : Wrong itemindex when selecting
  //          : Fixed : ProgressBar text value positioning
  //          : Fixed : OnItemSelected Event not called when Graphic type is set to gtNone
  //          : Fixed : Issue with component initialization during reparenting
  // v1.5.0.6 : New : Public property GraphicClicked which indicates if the graphic left or right is clicked
  //          : Fixed : Issue when repeatedly resizing listbox
  //          : Fixed : Issue with symbols ? < > = , ... in lookupbar
  //          : Fixed : Issue with Initlookupbar when destroying component
  //          : Fixed : Issue with Expanding / Collapsing items when total itemheight exceeds listbox height
  // v1.5.0.7 : Fixed : Issue with font creation in Delphi7
  //          : Improved : Collapse/Expand state of items
  // v1.5.0.8 : Fixed : Issue with flicker with sdOnDblClick
  // v1.5.0.9 : Fixed : Issue with focused item when detail item is animating
  // v1.5.1.0 : New : Enabled Checkbox with space key when item has focus
  //          : Fixed : Issue with multiple group expanding / collapsing on same level
  // v1.5.1.1 : Fixed : Issue with Border rounding
  // v1.5.1.2 : Fixed : Issue with Items.SelectedItem := nil
  //          : Fixed : Issue with VK_F4 in TAdvSmoothComboBox
  //          : Fixed : Issue with multiple group expanding / collapsing on same level
  //          : Fixed : Issue with Events and expanding after mouse move on graphic left


type
  TWinCtrl = class(TWinControl)
  public                 
    procedure PaintCtrls(DC: HDC; First: TControl);
  end;

  TAdvSmoothListBox = class;

  TAdvSmoothListBoxLocation = (plTopLeft, plTopCenter, plTopRight, plCenterLeft, plCenterCenter, plCenterRight, plBottomLeft, plBottomCenter, plBottomRight, plCustom);

  TAdvSmoothListBoxShowDetailClick = (sdOnClick, sdOnDetailImageClick, sdOnDblClick, sdOnDetailImageDblClick);

  TAdvSmoothListBoxShowDetailKey = (dkSpace, dkNone, dkF2, dkReturn);

  TAdvSmoothListBoxItems = class;

  TAdvSmoothListBoxItem = class;

  TAdvSmoothListBoxGraphicClicked = (cLeft, cRight);

  TAdvSmoothListBoxItemAppearance = class(TPersistent)
  private
    FOwner: TAdvSmoothListBox;
    FSpacingVert: integer;
    FSpacingHorz: integer;
    FItemHeight: integer;
    FOnChange: TNotifyEvent;
    FFill: TGDIPFill;
    FFillDisabled: TGDIPFill;
    FFillSelected: TGDIPFill;
    FProgressAppearance: TGDIPProgress;
    FButtonAppearance: TGDIPButton;
    procedure SetItemHeight(const Value: integer);
    procedure SetSpacingHorz(const Value: integer);
    procedure SetSpacingVert(const Value: integer);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetFillDisabled(const Value: TGDIPFill);
    procedure SetFillSelected(const Value: TGDIPFill);
    procedure SetProgressAppearance(const Value: TGDIPProgress);
    procedure SetButtonAppearance(const Value: TGDIPButton);
  protected
    procedure Changed;
    procedure FontChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure ProgressAppearanceChanged(Sender: TObject);
    procedure ButtonAppearanceChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Fill: TGDIPFill read FFill write SetFill;
    property FillSelected: TGDIPFill read FFillSelected write SetFillSelected;
    property FillDisabled: TGDIPFill read FFillDisabled write SetFillDisabled;
    property ProgressAppearance: TGDIPProgress read FProgressAppearance write SetProgressAppearance;
    property ButtonAppearance: TGDIPButton read FButtonAppearance write SetButtonAppearance;
    property VerticalSpacing: integer read FSpacingVert write SetSpacingVert default 0;
    property HorizontalSpacing: integer read FSpacingHorz write SetSpacingHorz default 0;
    property Height: integer read FItemHeight write SetItemHeight default 30;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothListBoxItemKind = (ikItem, ikSection);

  TAdvSmoothListBoxGraphicType = (gtCheckBox, gtRadio, gtButton, gtImage, gtDetailImage, gtCommonImage, gtCommonDetailImage, gtSmoothButton, gtNone);

  TAdvSmoothListBoxGraphicShow = (gsAlways, gsSelected, gsEnabled, gsNever);

  TAdvSmoothListBoxItem = class(TCollectionItem)
  private
    FLastNode: integer;
    FVisualizeNodes: Boolean;
    FOwner: TAdvSmoothListBox;
    FMouseEntered, FMouseLeft: Boolean;
    fgrRight, fgrLeft, fcaptionr, finfor: TRect;
    fn: String;
    Fhtmlr: TRect;
    FCaption: string;
    FEnabled: Boolean;
    FGraphicLeftType: TAdvSmoothListBoxGraphicType;
    FGraphicLeftShow: TAdvSmoothListBoxGraphicShow;
    FCaptionAlignment: TAlignment;
    FGraphicRightType: TAdvSmoothListBoxGraphicType;
    FNotes: String;
    FGraphicLeft: TAdvGDIPPicture;
    FGraphicRightShow: TAdvSmoothListBoxGraphicShow;
    FGraphicRight: TAdvGDIPPicture;
    FInfo: String;
    FCaptionFont: TFont;
    FInfoFont: TFont;
    FControl: TControl;
    FSplitter: Boolean;
    FNotesTop: integer;
    FNotesLeft: integer;
    FNoteshadowColor: TColor;
    FNotesLocation: TAdvSmoothListBoxLocation;
    FNotesURLColor: TColor;
    FNotesShadowOffset: integer;
    FObject: TObject;
    FTag: integer;
    FButtonLeft: Boolean;
    FButtonRight: Boolean;
    FChecked: Boolean;
    FMargin: integer;
    FGraphicLeftMargin: integer;
    FGraphicRightMargin: integer;
    FNotesFont: TFont;
    FHint: String;
    FSelected: Boolean;
    FCategoryID: integer;
    FProgressMin: Double;
    FProgressValue: Double;
    FProgressHeight: integer;
    FProgressPosition: TAdvSmoothListBoxLocation;
    FProgressMax: Double;
    FProgressWidth: integer;
    FProgressMargin: integer;
    FProgressVisible: Boolean;
    FProgressTop: integer;
    FProgressLeft: integer;
    FGraphicLeftHeight: integer;
    FGraphicRightHeight: integer;
    FGraphicLeftWidth: integer;
    FGraphicRightWidth: integer;
    FButtonColor: TColor;
    FBevelColor: TColor;
    FButtonShadow: Boolean;
    FButtonCaption: String;
    FButtonBevel: Boolean;
    FVisible: Boolean;
    FIndent: integer;
    FLevel: integer;
    FExpanded: Boolean;
    procedure SetCaption(const Value: string);
    procedure SetEnabled(const Value: Boolean);
    procedure SetCaptionAlignment(const Value: TAlignment);
    procedure SetGraphicLeft(const Value: TAdvGDIPPicture);
    procedure SetGraphicLeftShow(const Value: TAdvSmoothListBoxGraphicShow);
    procedure SetGraphicLeftType(const Value: TAdvSmoothListBoxGraphicType);
    procedure SetGraphicRight(const Value: TAdvGDIPPicture);
    procedure SetGraphicRightShow(const Value: TAdvSmoothListBoxGraphicShow);
    procedure SetGraphicRightType(const Value: TAdvSmoothListBoxGraphicType);
    procedure SetInfo(const Value: String);
    procedure SetNotes(const Value: String);
    procedure SetCaptionFont(const Value: TFont);
    procedure SetInfoFont(const Value: TFont);
    procedure SetControl(const Value: TControl);
    procedure SetSplitter(const Value: Boolean);
    procedure SetNotesLeft(const Value: integer);
    procedure SetNotesLocation(const Value: TAdvSmoothListBoxLocation);
    procedure SetNotesShadowColor(const Value: TColor);
    procedure SetNotesShadowOffset(const Value: integer);
    procedure SetNotesTop(const Value: integer);
    procedure SetNotesURLColor(const Value: TColor);
    procedure SetChecked(const Value: Boolean);
    procedure SetMargin(const Value: integer);
    procedure SetGraphicLeftMargin(const Value: integer);
    procedure SetGraphicRightMargin(const Value: integer);
    procedure SetNotesFont(const Value: TFont);
    procedure SetHint(const Value: String);
    procedure SetSelected(const Value: Boolean);
    procedure SetCategoryID(const Value: integer);
    procedure SetProgressHeight(const Value: integer);
    procedure SetProgressMax(const Value: Double);
    procedure SetProgressMin(const Value: Double);
    procedure SetProgressPosition(
      const Value: TAdvSmoothListBoxLocation);
    procedure SetProgressValue(const Value: Double);
    procedure SetProgressWidth(const Value: integer);
    procedure SetProgressMargin(const Value: integer);
    procedure SetProgressVisible(const Value: Boolean);
    procedure SetProgressLeft(const Value: integer);
    procedure SetProgressTop(const Value: integer);
    procedure SetGraphicLeftHeight(const Value: integer);
    procedure SetGraphicLeftWidth(const Value: integer);
    procedure SetGraphicRightHeight(const Value: integer);
    procedure SetGraphicRightWidth(const Value: integer);
    procedure SetBevelColor(const Value: TColor);
    procedure SetButtonCaption(const Value: String);
    procedure SetButtonColor(const Value: TColor);
    procedure SetButtonShadow(const Value: Boolean);
    procedure SetButtonBevel(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    procedure SetIndent(const Value: integer);
    procedure SetExpanded(const Value: Boolean);
    procedure SetLevel(const Value: integer);
  protected
    procedure Changed;
    procedure PictureChanged(Sender: TObject);
    procedure FontChanged(Sender: TObject);

    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignVisuals(Source: TPersistent);
    procedure CopySettings(Source: TPersistent); //no repaint
    procedure SaveItemValues(Caption, Info, Notes: String);
    function GetAnchorAt(X, Y: integer): String;
    property ItemObject: TObject read FObject write FObject;
    procedure Collapse;
    procedure Expand;
    property Expanded: Boolean read FExpanded write SetExpanded default false;
    //ADVSMOOTHCOMBOBOX
    procedure Draw(ACanvas: TCanvas; R: TRect; DisplayIndex: integer);
    function IsGraphicLeft(X, Y: integer): Boolean;
    function IsGraphicRight(X, Y: integer): Boolean;
    function IsInfo(X, Y: integer): Boolean;
    function IsCaption(X, Y: integer): Boolean;
    property ButtonLeftDown: Boolean read FButtonLeft write FButtonLeft;
    property ButtonRightDown: Boolean read FButtonRight write FButtonRight;
    //
  published
    property Caption: string read FCaption write SetCaption;
    property Checked: Boolean read FChecked write SetChecked default false;
    property Enabled: Boolean read FEnabled write SetEnabled default true;
    property Visible: Boolean read FVisible write SetVisible default true;
    property Indent: integer read FIndent write SetIndent default 0;
    property CaptionAlignment: TAlignment read FCaptionAlignment write SetCaptionAlignment default taLeftJustify;
    property Notes: String read FNotes write SetNotes;
    property NotesURLColor: TColor read FNotesURLColor write SetNotesURLColor default clBlue;
    property NotesShadowColor: TColor read FNoteshadowColor write SetNotesShadowColor default clGray;
    property NotesShadowOffset: integer read FNotesShadowOffset write SetNotesShadowOffset default 5;
    property NotesLocation: TAdvSmoothListBoxLocation read FNotesLocation write SetNotesLocation default plCenterCenter;
    property NotesLeft: integer read FNotesLeft write SetNotesLeft default 0;
    property NotesTop: integer read FNotesTop write SetNotesTop default 0;
    property Info: String read FInfo write SetInfo;
    property Hint: String read FHint write SetHint;
    property GraphicLeftMargin: integer read FGraphicLeftMargin write SetGraphicLeftMargin default 3;
    property GraphicRightMargin: integer read FGraphicRightMargin write SetGraphicRightMargin default 3;
    property GraphicLeftType: TAdvSmoothListBoxGraphicType read FGraphicLeftType write SetGraphicLeftType default gtNone;
    property GraphicRightType: TAdvSmoothListBoxGraphicType read FGraphicRightType write SetGraphicRightType default gtNone;
    property GraphicLeft: TAdvGDIPPicture read FGraphicLeft write SetGraphicLeft;
    property GraphicRight: TAdvGDIPPicture read FGraphicRight write SetGraphicRight;
    property GraphicLeftShow: TAdvSmoothListBoxGraphicShow read FGraphicLeftShow write SetGraphicLeftShow default gsAlways;
    property GraphicRightShow: TAdvSmoothListBoxGraphicShow read FGraphicRightShow write SetGraphicRightShow default gsAlways;
    property GraphicLeftWidth: integer read FGraphicLeftWidth write SetGraphicLeftWidth default 30;
    property GraphicLeftHeight: integer read FGraphicLeftHeight write SetGraphicLeftHeight default 25;
    property GraphicRightWidth: integer read FGraphicRightWidth write SetGraphicRightWidth default 30;
    property GraphicRightHeight: integer read FGraphicRightHeight write SetGraphicRightHeight default 25;
    property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
    property InfoFont: TFont read FInfoFont write SetInfoFont;
    property NotesFont: TFont read FNotesFont write SetNotesFont;
    property DetailControl: TControl read FControl write SetControl;
    property Tag: integer read FTag write FTag;
    property Splitter: Boolean read FSplitter write SetSplitter;
    property CaptionMargin: integer read FMargin write SetMargin default 3;
    property Selected: Boolean read FSelected write SetSelected default false;
    property CategoryID: integer read FCategoryID write SetCategoryID default -1;
    property ProgressMinimum: Double read FProgressMin write SetProgressMin;
    property ProgressMaximum: Double read FProgressMax write SetProgressMax;
    property ProgressValue: Double read FProgressValue write SetProgressValue;
    property ProgressPosition: TAdvSmoothListBoxLocation read FProgressPosition write SetProgressPosition default plBottomCenter;
    property ProgressHeight: integer read FProgressHeight write SetProgressHeight default 15;
    property ProgressWidth: integer read FProgressWidth write SetProgressWidth default 130;
    property ProgressMargin: integer read FProgressMargin write SetProgressMargin default 3;
    property ProgressVisible: Boolean read FProgressVisible write SetProgressVisible default false;
    property ProgressLeft: integer read FProgressLeft write SetProgressLeft default 0;
    property ProgressTop: integer read FProgressTop write SetProgressTop default 0;
    property ButtonColor: TColor read FButtonColor write SetButtonColor default clGray;
    property ButtonBevelColor: TColor read FBevelColor write SetBevelColor default clWhite;
    property ButtonBevel: Boolean read FButtonBevel write SetButtonBevel default true;
    property ButtonShadow: Boolean read FButtonShadow write SetButtonShadow default false;
    property ButtonCaption: String read FButtonCaption write SetButtonCaption;
    property Level: integer read FLevel write SetLevel default 0;
  end;

  TItemSelectArray = Array of Integer;  

  TAdvSmoothListBoxItems = class(TCollection)
  private
    FUpdateCount: integer;
    FOwner: TAdvSmoothListBox;
    FOnChange: TNotifyEvent;
    FSelectedItem: TAdvSmoothListBoxItem;
    function GetItem(Index: Integer): TAdvSmoothListBoxItem;
    procedure SetItem(Index: Integer; const Value: TAdvSmoothListBoxItem);
    procedure SetSelectedItem(const Value: TAdvSmoothListBoxItem);
  protected
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    function Compare(Item1, Item2 : TAdvSmoothListBoxItem) : integer; virtual;
    procedure QuickSort(L, R: Integer);
    function GetOwner: TPersistent; override;
  public
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    constructor Create(AOwner: TAdvSmoothListBox);
    property Items[Index: Integer]: TAdvSmoothListBoxItem read GetItem write SetItem; default;
    function Add: TAdvSmoothListBoxItem;
    function Insert(Index: Integer): TAdvSmoothListBoxItem;
    procedure Delete(Index: Integer);
    procedure Sort;
    procedure Clear;
    property SelectedItem: TAdvSmoothListBoxItem read FSelectedItem write SetSelectedItem;
    procedure SelectAll;
    procedure UnSelectAll;
    procedure Select(AItems: Array of Integer);
    function CountSelected: integer;
  end;

  TAdvSmoothListBoxCategoryItem = class(TCollectionItem)
  private
    FOwner: TAdvSmoothListBox;
    FText: String;
    FID: integer;
    FTag: integer;
    FImageIndex: integer;
    FLookupText: String;
    procedure SetText(const Value: String);
    procedure SetId(const Value: integer);
    procedure SetImageIndex(const Value: integer);
    procedure SetTag(const Value: integer);
    procedure SetLookupText(const Value: String);
  protected
    procedure Changed;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property ImageIndex: integer read FImageIndex write SetImageIndex default -1;
    property Tag: integer read FTag write SetTag;
    property Text: String read FText write SetText;
    property LookupText: String read FLookupText write SetLookupText;
    property Id: integer read FID write SetId;
  end;

  TAdvSmoothListBoxCategoryItems = class(TCollection)
  private
    FOwner: TAdvSmoothListBox;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TAdvSmoothListBoxCategoryItem;
    procedure SetItem(Index: Integer; const Value: TAdvSmoothListBoxCategoryItem);
  protected
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    function GetOwner: TPersistent; override;
    function Compare(Item1, Item2 : TAdvSmoothListBoxCategoryItem) : integer; virtual;
    procedure QuickSort(L, R: Integer);    
  public
    constructor Create(AOwner: TAdvSmoothListBox);
    property Items[Index: Integer]: TAdvSmoothListBoxCategoryItem read GetItem write SetItem; default;
    function ItemById(id: integer): TAdvSmoothListBoxCategoryItem;
    function ItemIndexById(id: integer): integer;    
    function Add: TAdvSmoothListBoxCategoryItem;
    function Insert(Index: Integer): TAdvSmoothListBoxCategoryItem;
    procedure Delete(Index: Integer);
    procedure Sort;    
    procedure Clear;
  end;

  TAdvSmoothListBoxLookUpBarPosition = (pLeft, pRight);

  TAdvSmoothListBoxLookUpBar = class(TPersistent)
  private
    FChar: array[1..36] of Boolean;
    FCustomChar: array of Boolean;
    Fowner: TAdvSmoothListBox;
    FDisabledFont: TFont;
    FColor: TColor;
    FColorTo: TColor;
    FFont: TFont;
    FVisible: Boolean;
    FNumeric: Boolean;
    FOnChange: TNotifyEvent;
    FPosition: TAdvSmoothListBoxLookUpBarPosition;
    FOpacity: Byte;
    FOpacityTo: Byte;
    FGradientType: TAdvGradientType;
    FHatchStyle: THatchStyle;
    FOnTop: Boolean;
    FAutoSize: Boolean;
    FSpacing: integer;
    FRotated: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetDisabledFont(const Value: TFont);
    procedure SetFont(const Value: TFont);
    procedure SetNumeric(const Value: Boolean);
    procedure SetPosition(const Value: TAdvSmoothListBoxLookUpBarPosition);
    procedure SetVisible(const Value: Boolean);
    procedure SetOpacity(const Value: Byte);
    procedure SetOpacityTo(const Value: Byte);
    procedure SetGradientType(const Value: TAdvGradientType);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetOnTop(const Value: Boolean);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetRotated(const Value: Boolean);
    procedure SetSpacing(const Value: integer);
  protected
    procedure Changed;
    procedure FontChanged(Sender: TObject);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    procedure InitLookupBar;
  public
    constructor Create(AOwner: TAdvSmoothListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetWidth: integer;
  published
    property Color: TColor read FColor write SetColor default clWhite;
    property ColorTo: TColor read FColorTo write SetColorTo default clWhite;
    property GradientType: TAdvGradientType read FGradientType write SetGradientType default gtSolid;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property Opacity: Byte read FOpacity write SetOpacity default 100;
    property OpacityTo: Byte read FOpacityTo write SetOpacityTo default 100;
    property Numeric: Boolean read FNumeric write SetNumeric default false;
    property Visible: Boolean read FVisible write SetVisible default true;
    property Position: TAdvSmoothListBoxLookUpBarPosition read FPosition write SetPosition default pRight;
    property Font: TFont read FFont write SetFont;
    property OnTop: Boolean read FOnTop write SetOnTop default false;
    property DisabledFont: TFont read FDisabledFont write SetDisabledFont;
    property Spacing: integer read FSpacing write SetSpacing default 3;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default true;
    property Rotated: Boolean read FRotated write SetRotated default false;
  end;

  TAdvSmoothListBoxCategoryType = (alphanumeric, custom);

  TAdvSmoothListBoxSections = class(TPersistent)
  private
    FOwner: TAdvSmoothListBox;
    FOpacity: Byte;
    FBorderColor: TColor;
    FGradientType: TAdvGradientType;
    FOpacityTo: Byte;
    FHatchStyle: THatchStyle;
    FColor: TColor;
    FColorTo: TColor;
    FFont: TFont;
    FVisible: Boolean;
    FOnChange: TNotifyEvent;
    FCategoryType: TAdvSmoothListBoxCategoryType;
    FBorderWidth: integer;
    FCategories: TAdvSmoothListBoxCategoryItems;
    procedure SetBorderColor(const Value: TColor);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetGradientType(const Value: TAdvGradientType);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetOpacity(const Value: Byte);
    procedure SetOpacityTo(const Value: Byte);
    procedure SetVisible(const Value: Boolean);
    procedure SetBorderWidth(const Value: integer);
  public
    procedure Changed;
    procedure FontChanged(Sender: TObject);
    procedure CategoriesChanged(Sender: TObject);
    constructor Create(AOwner: TAdvSmoothListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Font: TFont read FFont write SetFont;
    property Visible: Boolean read FVisible write SetVisible default false;
    property GradientType: TAdvGradientType read FGradientType write SetGradientType default gtSolid;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clSilver;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 1;
    property Color: TColor read FColor write SetColor default clWhite;
    property ColorTo: TColor read FColorTo write SetColorTo default clSilver;
    property Opacity: Byte read FOpacity write SetOpacity default 180;
    property OpacityTo: Byte read FOpacityTo write SetOpacityTo default 180;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothListBoxDisplayListItem = class(TObject)
  private
    FItemRect: TRect;
    FFloating: Boolean;
    FKind: TAdvSmoothListBoxItemKind;
    FItem: TAdvSmoothListBoxItem;
    FSectionCaption: String;
    FSectionCategoryID: integer;
    procedure SetFloating(const Value: Boolean);
    procedure SetKind(const Value: TAdvSmoothListBoxItemKind);
    procedure SetSectionCaption(const Value: String);
    procedure SetSectionCategoryID(const Value: integer);
  protected
    procedure Changed;
  public
    property Kind: TAdvSmoothListBoxItemKind read FKind write SetKind;
    property SectionCaption: String read FSectionCaption write SetSectionCaption;
    property SectionCategoryID: integer read FSectionCategoryID write SetSectionCategoryID;
    property Floating: Boolean read FFloating write SetFloating;
    property DisplayItem: TAdvSmoothListBoxItem read FItem write FItem;
    property ItemRect: TRect read FItemRect write FItemRect;
  end;

  TAdvSmoothListBoxDisplayList = class(TList)
  public
    procedure Clear; override;
    procedure DeleteItem(index: integer);
    function AddItem: TAdvSmoothListBoxDisplayListItem;
    function GetItem(index: integer): TAdvSmoothListBoxDisplayListItem;
  end;

  TAdvSmoothListBoxCaptionLocation = (cpTopLeft, cpTopCenter, cpTopRight, cpCenterLeft, cpCenterCenter, cpCenterRight, cpBottomLeft, cpBottomCenter, cpBottomRight, cpCustom);

  TAdvSmoothListBoxHeaderFooter = class(TPersistent)
  private
    FOwner: TAdvSmoothListBox;
    FFont: TFont;
    FCaption: String;
    FHeight: integer;
    FOnChange: TNotifyEvent;
    FVisible: Boolean;
    FCaptionTop: integer;
    FCaptionLeft: integer;
    FFill: TGDIPFill;
    FCaptionShadowColor: TColor;
    FCaptionLocation: TAdvSmoothListBoxCaptionLocation;
    FCaptionURLColor: TColor;
    FCaptionShadowOffset: integer;
    procedure SetCaption(const Value: String);
    procedure SetFont(const Value: TFont);
    procedure SetVisible(const Value: Boolean);
    procedure SetCaptionLeft(const Value: integer);
    procedure SetCaptionTop(const Value: integer);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetHeight(const Value: integer);
    procedure SetCaptionLocation(const Value: TAdvSmoothListBoxCaptionLocation);
    procedure SetCaptionShadowColor(const Value: TColor);
    procedure SetCaptionShadowOffset(const Value: integer);
    procedure SetCaptionURLColor(const Value: TColor);
  public
    procedure Changed;
    procedure FontChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    constructor Create(AOwner: TAdvSmoothListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetHeight: integer;
    function GetAnchorAt(r: TRect; X, Y: integer): String;
  published
    property Fill: TGDIPFill read FFill write SetFill;
    property Height: integer read FHeight write SetHeight default 40;
    property Caption: String read FCaption write SetCaption;
    property CaptionURLColor: TColor read FCaptionURLColor write SetCaptionURLColor default clBlue;
    property CaptionShadowColor: TColor read FCaptionShadowColor write SetCaptionShadowColor default clGray;
    property CaptionShadowOffset: integer read FCaptionShadowOffset write SetCaptionShadowOffset default 5;
    property CaptionLocation: TAdvSmoothListBoxCaptionLocation read FCaptionLocation write SetCaptionLocation default cpCenterCenter;
    property CaptionLeft: integer read FCaptionLeft write SetCaptionLeft default 0;
    property CaptionTop: integer read FCaptionTop write SetCaptionTop default 0;
    property Font: TFont read FFont write SetFont;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Visible: Boolean read FVisible write SetVisible default true;
  end;

  TAdvSmoothListBoxIndicator = class(TPersistent)
  private
    FOwner: TAdvSmoothListBox;
    FGradientType: TAdvGradientType;
    FOpacity: Byte;
    FHatchStyle: THatchStyle;
    FColor: TColor;
    FColorTo: TColor;
    FVisible: Boolean;
    FFade: Boolean;
    FOnChange: TNotifyEvent;
    FWidth: integer;
    FHeight: integer;
    FAnimateOpacity: integer;
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientType(const Value: TAdvGradientType);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetOpacity(const Value: Byte);
    procedure SetVisible(const Value: Boolean);
    procedure SetFade(const Value: Boolean);
    procedure Setwidth(const Value: integer);
  protected
    procedure Changed;
  public
    constructor Create(AOwner: TAdvSmoothListBox);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetAnimationOpacity: Byte;
    function GetWidth: integer;
  published
    property Visible: Boolean read FVisible write SetVisible default true;
    property Color: TColor read FColor write SetColor default clBlack;
    property ColorTo: TColor read FColorTo write SetColorTo default clDkGray;
    property Opacity: Byte read FOpacity write SetOpacity default 100;
    property GradientType: TAdvGradientType read FGradientType write SetGradientType default gtSolid;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property Fade: Boolean read FFade write SetFade default true;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Width: integer read FWidth write Setwidth default 5;
  end;

  TAdvSmoothListBoxDetailStatus = (dsDetailsNotVisible, dsDetailsVisible);

  TAdvSmoothListBoxItemClickEvent = procedure(Sender: TObject; itemindex: integer) of object;

  TAdvSmoothListBoxItemSelectedEvent = procedure(Sender: TObject; itemindex: integer) of object;

  TAdvSmoothListBoxItemSelectionChangedEvent = procedure(Sender: TObject; previousitemindex, itemindex: integer) of object;

  TAdvSmoothListBoxItemCheckedEvent = procedure(Sender: TObject; itemindex: integer; checked: Boolean) of object;

  TAdvSmoothListBoxScrollEvent = procedure(Sender: TObject; CurrentPosition, EndPosition: Double) of object;

  TAdvSmoothListBoxDetailEvent = procedure(Sender: TObject; itemindex: integer) of object;

  TAdvSmoothListBoxItemTextEvent = procedure(Sender: TObject; itemindex: integer; var itemcaption: String; var iteminfo: String; var itemnotes: String) of object;

  TAdvSmoothListBoxItemBkgDrawEvent = procedure(Sender: TObject; Canvas: TCanvas; itemindex: integer; itemRect: TRect; var defaultdraw: Boolean) of object;

  TAdvSmoothListBoxItemDrawEvent = procedure(Sender: TObject; Canvas: TCanvas; itemindex: integer; itemrect: TRect; var defaultdraw: Boolean) of object;

  TAdvSmoothListBoxAnchorClickEvent = procedure(Sender: TObject; Anchor: String) of object;

  TAdvSmoothListBoxItemAnchorClickEvent = procedure(Sender: TObject; Anchor: String; ItemIndex: integer) of object;

  TAdvSmoothListBoxItemCaptionClick = procedure(Sender: TObject; itemindex: integer) of object;

  TAdvSmoothListBoxItemInfoClick = procedure(Sender: TObject; itemindex: integer) of object;

  TAdvSmoothListBoxItemMouseEvent = procedure(Sender: TObject; itemindex: integer) of object;

  TAdvSmoothListBoxLookUpClickEvent = procedure(Sender: TObject; lookupindex: integer; lookupvalue: string) of object;

  TAdvSmoothListBoxItemHintEvent = procedure(Sender: TObject; itemindex: integer; var hint: string) of object;

  TAdvSmoothListBoxFooterClickEvent = procedure(Sender: TObject; X, Y: integer) of object;

  TAdvSmoothListBoxHeaderClickEvent = procedure(Sender: TObject; X, Y: integer) of object;

  TAdvSmoothListBoxItemDragStartEvent = procedure(Sender: TObject; DragItemIndex: integer; var allowdrag: Boolean) of object;

  TAdvSmoothListBoxItemDragDropEvent = procedure(Sender: TObject; DragItemIndex, DropItemIndex: integer; var allowdrop: Boolean) of object;

  TAdvSmoothListBoxItemDragEndEvent = procedure(Sender: TObject; DragItemIndex: integer) of object;

  TAdvSmoothListBoxItemChanged = procedure(Sender: TObject; itemindex: integer) of object;

  TAdvSmoothListBoxItemDragOverEvent = procedure(Sender: TObject; DragItemIndex, DropItemIndex: integer) of object;

  TAdvSmoothListBoxSelectionMode = (sPersistSelection, sAutoDeselect, sPersistSelectionAlways);

  TDragMode = (dmDrag, dmRelease);

  TAdvSmoothListBox = class(TCustomControl, ITMSStyle)
  private
    FBypassBitBlt : Boolean;
    FDrawingBitmap: TBitmap;

    FConstructed: boolean;
    FSelectedDragItem: TAdvSmoothListBoxItem;  
    FMode: TDragMode;
    FDragItemForm: TForm;
    FDragAnimateDelta, FDragDelta: integer;
    FDragClickY: integer;
    FDragOldTop: integer;    
    FPrevHoveredItemIndex, FhoveredItemIndex: integer;
    FTimerCount: integer;
    FDesignTime, FFocused: Boolean;
    FCurrentControl: TControl;
    FLookupKey: String;
    FAnimateBitmap: TBitmap;
    FClickX, FClickY: integer;
    FLookUp: Boolean;
    FLookUpSize: integer;
    FSp: Double;
    FTimeStart, FTimeStop: integer;
    FDetailShow, FAnimatingdetail, FAnimatingScroll,
      FMouseUp, FAnimating, FAnimate, FMouseDown: Boolean;
    FDetailIndex: integer; 
    FDragY, FScrollY: integer;
    FSmoothTimer, FDragTimer: TTimer;
    FScPosTo: integer;
    FCurrentScPos: integer;
    FSelectedItemIndex, FFocusedItemIndex: integer;
    FItems: TAdvSmoothListBoxItems;
    FDisplayList: TAdvSmoothListBoxDisplayList;
    FItemAppearance: TAdvSmoothListBoxItemAppearance;
    FLookUpBar: TAdvSmoothListBoxLookUpBar;
    FSpeedFactor: integer;
    FSorted: Boolean;
    FSections: TAdvSmoothListBoxSections;
    FHeader: TAdvSmoothListBoxHeaderFooter;
    FScrollIndicator: TAdvSmoothListBoxIndicator;
    FFooter: TAdvSmoothListBoxHeaderFooter;
    FControl: TControl;
    FDetailStatus: TAdvSmoothListBoxDetailStatus;
    FOnItemDblClick: TAdvSmoothListBoxItemClickEvent;
    FOnItemClick: TAdvSmoothListBoxItemClickEvent;
    FKeyBoardLookup: Boolean;
    FSplitterHeight: integer;
    FOnScroll: TAdvSmoothListBoxScrollEvent;
    FOnShowDetail: TAdvSmoothListBoxDetailEvent;
    FOnHideDetail: TAdvSmoothListBoxDetailEvent;
    FOnItemDraw: TAdvSmoothListBoxItemDrawEvent;
    FOnItemText: TAdvSmoothListBoxItemTextEvent;
    FOnItemBkgDraw: TAdvSmoothListBoxItemBkgDrawEvent;
    FContainer: TGDIPPictureContainer;
    FOnAnchorClick: TAdvSmoothListBoxAnchorClickEvent;
    FShowDetailKey: TAdvSmoothListBoxShowDetailKey;
    FShowDetailClick: TAdvSmoothListBoxShowDetailClick;
    FFill: TGDIPFill;
    FShowFocus: Boolean;
    FFocusColor: TColor;
    FDefaultItems: TAdvSmoothListBoxItems;
    FDefaultItem: TAdvSmoothListBoxItem;
    FImages: TCustomImageList;
    FIsWinXP: boolean;
    FDetailItemImage: TAdvGDIPPicture;
    FItemImage: TAdvGDIPPicture;
    FOnItemRadioClick: TAdvSmoothListBoxItemCheckedEvent;
    FOnItemCheckClick: TAdvSmoothListBoxItemCheckedEvent;
    FOnItemImageClick: TAdvSmoothListBoxItemClickEvent;
    FOnItemCaptionClick: TAdvSmoothListBoxItemCaptionClick;
    FOnItemInfoClick: TAdvSmoothListBoxItemInfoClick;
    FOnItemAnchorClick: TAdvSmoothListBoxItemAnchorClickEvent;
    FSelectionMode: TAdvSmoothListBoxSelectionMode;
    FOnItemMouseLeave: TAdvSmoothListBoxItemMouseEvent;
    FOnItemMouseEnter: TAdvSmoothListBoxItemMouseEvent;
    FOnItemHint: TAdvSmoothListBoxItemHintEvent;
    FOnLookUpClick: TAdvSmoothListBoxLookUpClickEvent;
    FOnHeaderClick: TAdvSmoothListBoxHeaderClickEvent;
    FOnFooterClick: TAdvSmoothListBoxFooterClickEvent;
    FOnItemSelected: TAdvSmoothListBoxItemSelectedEvent;
    FOnItemSelectionChanged: TAdvSmoothListBoxItemSelectionChangedEvent;
    FDragAlphaBlend: Boolean;
    FDragOpacity: Byte;
    FDragBorderWidth: integer;
    FDragBorderColor: TColor;
    FOnItemDragStart: TAdvSmoothListBoxItemDragStartEvent;
    FOnItemDragEnd: TAdvSmoothListBoxItemDragEndEvent;
    FItemDragging: Boolean;
    FMultiSelect: Boolean;
    FOnItemDragDrop: TAdvSmoothListBoxItemDragDropEvent;
    FOnItemDragOver: TAdvSmoothListBoxItemDragOverEvent;
    FCategories: TAdvSmoothListBoxCategoryItems;
    FCategoryType: TAdvSmoothListBoxCategoryType;
    FOnItemButtonClick: TAdvSmoothListBoxItemClickEvent;
    FOnItemChanged: TAdvSmoothListBoxItemChanged;
    FGraphicClicked: TAdvSmoothListBoxGraphicClicked;
    FDetailSpeedFactor: integer;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;    
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;    
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;    
    function GetVersion: string;
    procedure SetItems(const Value: TAdvSmoothListBoxItems);
    procedure SetItemAppearance(const Value: TAdvSmoothListBoxItemAppearance);
    procedure SetLookUpBar(const Value: TAdvSmoothListBoxLookUpBar);
    procedure SetSpeedFactor(const Value: integer);
    procedure SetSorted(const Value: Boolean);
    procedure SetSections(const Value: TAdvSmoothListBoxSections);
    procedure SetHeader(const Value: TAdvSmoothListBoxHeaderFooter);
    procedure SetScrollIndicator(const Value: TAdvSmoothListBoxIndicator);
    procedure SetFooter(const Value: TAdvSmoothListBoxHeaderFooter);
    procedure SetControl(const Value: TControl);
    procedure SetKeyBoardLookup(const Value: Boolean);
    procedure SetSplitterHeight(const Value: integer);
    procedure SetShowDetailClick(const Value: TAdvSmoothListBoxShowDetailClick);
    procedure SetShowDetailKey(const Value: TAdvSmoothListBoxShowDetailKey);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetShowFocus(const Value: Boolean);
    procedure SetFocusColor(const Value: TColor);
    procedure SetDefaultItem(const Value: TAdvSmoothListBoxItem);
    procedure SetDetailItemImage(const Value: TAdvGDIPPicture);
    procedure SetItemImage(const Value: TAdvGDIPPicture);
    function GetSelectedItemIndex: integer;
    procedure SetSelectedItemIndex(const Value: integer);
    procedure SetSelectionMode(const Value: TAdvSmoothListBoxSelectionMode);
    procedure SetDragAlphaBlend(const Value: Boolean);
    procedure SetDragOpacity(const Value: Byte);
    procedure SetDragBorderColor(const Value: TColor);
    procedure SetDragBorderWidth(const Value: integer);
    procedure SetItemDragging(const Value: Boolean);
    procedure SetMultiSelect(const Value: Boolean);
    procedure SetCategories(const Value: TAdvSmoothListBoxCategoryItems);
    procedure SetCategoryType(const Value: TAdvSmoothListBoxCategoryType);
    function GetNewCanvas: TCanvas;
    procedure SetDetailSpeedFactor(const Value: integer);
  protected
    procedure Paint; override;
    procedure CreateParams(var params: TCreateParams); override;
    procedure CategoriesChanged(Sender: TObject);
    procedure ItemsChanged(Sender: TObject);
    procedure ScrollIndicatorChanged(Sender: TObject);
    procedure AppearanceChanged(Sender: TObject);
    procedure LookupBarChanged(Sender: TObject);
    procedure HeaderFooterChanged(Sender: TObject);
    procedure ItemAppearanceChanged(Sender: TObject); virtual;
    procedure SectionsChanged(Sender: TObject);
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure DoItemDblClick(Sender: TObject; itemindex: integer);
    procedure DoItemClick(Sender: TObject; itemindex: integer);
    procedure DoItemImageClick(Sender: TObject; itemindex: integer);
    procedure DoItemCheckClick(Sender: TObject; itemindex: integer; checked: Boolean);
    procedure DoItemRadioClick(Sender: TObject; itemindex: integer; checked: Boolean);
    procedure DoItemButtonClick(Sender: TObject; itemindex: integer);
    procedure DoScroll(Sender: TObject; CurrentPosition, EndPosition: Double);
    procedure DoHideDetail(Sender: TObject; itemindex: integer);
    procedure DoShowDetail(Sender: TObject; itemindex: integer);
    procedure DoItemText(Sender: TObject; itemindex: integer; var itemcaption: String; var iteminfo: String; var itemnotes: String);
    procedure DoItemBkgDraw(Sender: TObject; Canvas: TCanvas; itemindex: integer; itemrect: TRect; var defaultdraw: boolean);
    procedure DoItemDraw(Sender: TObject; Canvas: TCanvas; itemindex: integer; itemrect: TRect; var defaultdraw: boolean);
    procedure DoAnchorClick(Sender: TObject; Anchor: String);
    procedure DoItemAnchorClick(Sender: TObject; Anchor: String; ItemIndex: integer);    
    procedure DoItemCaptionClick(Sender: TObject; itemindex: integer);
    procedure DoItemInfoClick(Sender: TObject; itemindex: integer); 
    procedure DrawBackground;
    procedure DrawHeaderFooter(Part: TAdvSmoothListBoxHeaderFooter; Header: Boolean);
    procedure DrawItems;
    procedure DrawLookUpBar;
    procedure DrawScrollIndicator;
    procedure DrawSection(itemRect: TRect; ch: String; catindex: integer);
    procedure Changed;
    procedure Click; override;
    procedure CreateWnd; override;    
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyPress(var Key: char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;        
    procedure DblClick; override;
    procedure Resize; override;
    procedure AnimateSmoothPos(Sender: TObject);
    procedure DragSmoothPos(Sender: TObject);
    procedure InitDisplayList;
    procedure InitPreview;
    procedure AddDisplaySection(Item: TAdvSmoothListBoxItem; var prevrect: TRect; height, lookup: integer);
    procedure AddDisplayItem(Item: TAdvSmoothListBoxItem; var prevrect: TRect; height, lookup: integer);
    procedure GetTextPosition(var x, y: integer; rectangle: TGPRectF; objectwidth, objectheight: integer; location: TAdvSmoothListBoxLocation);
    function GetVersionNr: Integer; virtual;
    function GetShadowOffset: integer;
    function GetHeaderFooterCaptionRect(Part: TAdvSmoothListBoxHeaderFooter; Header: Boolean): TRect;
    function GetHeaderFooterRect(Part: TAdvSmoothListBoxHeaderFooter; Header: Boolean): TRect;
    function ItemFromDifferentCategory(item1, item2: TAdvSmoothListBoxItem): Boolean; virtual;
    function FindFirstItemWithChar(ch: String): TAdvSmoothListBoxDisplayListItem;
    function FindFirstSectionWithChar(ch: String): TAdvSmoothListBoxDisplayListItem;
    function FindFirstItemWithCategoryID(CategoryID: integer): TAdvSmoothListBoxDisplayListItem;
    function FindFirstSectionWithCategoryID(CategoryID: integer): TAdvSmoothListBoxDisplayListItem;
    function InsideRect: TRect;
    function GetFullHeight: integer; virtual;
    function GetFullWidth: integer; virtual;
    function GetDisplayRect: TRect;
    function GetMaximumCustomTextWidth(ACanvas: TCanvas): integer;
    function GetMaximumCustomTextHeight(ACanvas: TCanvas): integer;
    function GetDisplayIndex(ItemIndex: integer): integer;
    function GetPositionTo: integer;
    function GetPosition: integer;    
  public
    procedure MouseWheelHandler(var Message: TMessage); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ShowDetails(itemindex: integer = -1; const bypasstimer: Boolean = false);
    procedure HideDetails;
//    procedure SetComponentStyle(AStyle: TTMSStyle);
    property DetailStatus: TAdvSmoothListBoxDetailStatus read FDetailStatus;
    function YToItem(X, Y: integer; CountSections: Boolean = false; CheckDisplayRectangle: Boolean = true): integer;
    function ItemAtXY(X, Y: integer): integer;
    function GetTopIndex: integer;
    function GetBottomIndex: integer;
    procedure ScrollToItem(ItemIndex: integer);
    procedure SetComponentStyle(AStyle: TTMSStyle); virtual;
    procedure SetProgressStyle(AStyle: TTMSStyle; Selected: Boolean);
    //ADVSMOOTHCOMBOBOX
    procedure InitState;
    procedure InitSelection(itemindex: integer);
    function CheckSelection(X, Y: integer): Boolean;
    //
    property GraphicClicked: TAdvSmoothListBoxGraphicClicked read FGraphicClicked;
    property Canvas: TCanvas read GetNewCanvas;
  published
    property Version: String read GetVersion;
    property Fill: TGDIPFill read FFill write SetFill;
    property Images: TCustomImageList read FImages write FImages;
    property Items: TAdvSmoothListBoxItems read FItems write SetItems;
    property ItemAppearance: TAdvSmoothListBoxItemAppearance read FItemAppearance write SetItemAppearance;
    property SplitterHeight: integer read FSplitterHeight write SetSplitterHeight default 20;
    property LookupBar: TAdvSmoothListBoxLookUpBar read FLookUpBar write SetLookUpBar;
    property SpeedFactor: integer read FSpeedFactor write SetSpeedFactor default 4;
    property DetailSpeedFactor: integer read FDetailSpeedFactor write SetDetailSpeedFactor default 4;
    property Sorted: Boolean read FSorted write SetSorted default false;
    property Sections: TAdvSmoothListBoxSections read FSections write SetSections;
    property SelectedItemIndex: integer read GetSelectedItemIndex write SetSelectedItemIndex;
    property Header: TAdvSmoothListBoxHeaderFooter read FHeader write SetHeader;
    property Footer: TAdvSmoothListBoxHeaderFooter read FFooter write SetFooter;
    property ScrollIndicator: TAdvSmoothListBoxIndicator read FScrollIndicator write SetScrollIndicator;
    property DetailControl: TControl read FControl write SetControl;
    property KeyBoardLookup: Boolean read FKeyBoardLookup write SetKeyBoardLookup default false;
    property PictureContainer: TGDIPPictureContainer read FContainer write FContainer;
    property ShowDetailClick: TAdvSmoothListBoxShowDetailClick read FShowDetailClick write SetShowDetailClick default sdOnClick;
    property ShowDetailKey: TAdvSmoothListBoxShowDetailKey read FShowDetailKey write SetShowDetailKey default dkSpace;
    property OnHeaderClick: TAdvSmoothListBoxHeaderClickEvent read FOnHeaderClick write FOnHeaderClick;
    property OnFooterClick: TAdvSmoothListBoxFooterClickEvent read FOnFooterClick write FOnFooterClick;
    property OnItemDragStart: TAdvSmoothListBoxItemDragStartEvent read FOnItemDragStart write FOnItemDragStart;
    property OnItemDragEnd: TAdvSmoothListBoxItemDragEndEvent read FOnItemDragEnd write FOnItemDragEnd;
    property OnItemDragOver: TAdvSmoothListBoxItemDragOverEvent read FOnItemDragOver write FOnItemDragOver;
    property OnItemDragDrop: TAdvSmoothListBoxItemDragDropEvent read FOnItemDragDrop write FOnItemDragDrop;
    property OnItemMouseLeave: TAdvSmoothListBoxItemMouseEvent read FOnItemMouseLeave write FOnItemMouseLeave;
    property OnItemMouseEnter: TAdvSmoothListBoxItemMouseEvent read FOnItemMouseEnter write FOnItemMouseEnter;
    property OnLookUpClick: TAdvSmoothListBoxLookUpClickEvent read FOnLookUpClick write FOnLookUpClick;
    property OnItemHint: TAdvSmoothListBoxItemHintEvent read FOnItemHint write FOnItemHint;
    property OnItemDblClick: TAdvSmoothListBoxItemClickEvent read FOnItemDblClick write FOnItemDblClick;
    property OnItemClick: TAdvSmoothListBoxItemClickEvent read FOnItemClick write FOnItemClick;
    property OnItemSelectionChanged: TAdvSmoothListBoxItemSelectionChangedEvent read FOnItemSelectionChanged write FOnItemSelectionChanged;
    property OnItemSelected: TAdvSmoothListBoxItemSelectedEvent read FOnItemSelected write FOnItemSelected;
    property OnItemCheckClick: TAdvSmoothListBoxItemCheckedEvent read FOnItemCheckClick write FOnItemCheckClick;
    property OnItemRadioClick: TAdvSmoothListBoxItemCheckedEvent read FOnItemRadioClick write FOnItemRadioClick;
    property OnItemImageClick: TAdvSmoothListBoxItemClickEvent read FOnItemImageClick write FOnItemImageClick;
    property OnItemButtonClick: TAdvSmoothListBoxItemClickEvent read FOnItemButtonClick write FOnItemButtonClick;
    property OnScroll: TAdvSmoothListBoxScrollEvent read FOnScroll write FOnScroll;
    property OnHideDetail: TAdvSmoothListBoxDetailEvent read FOnHideDetail write FOnHideDetail;
    property OnShowDetail: TAdvSmoothListBoxDetailEvent read FOnShowDetail write FOnShowDetail;
    property OnItemDraw: TAdvSmoothListBoxItemDrawEvent read FOnItemDraw write FOnItemDraw;
    property OnItemBkgDraw: TAdvSmoothListBoxItemBkgDrawEvent read FOnItemBkgDraw write FOnItemBkgDraw;
    property OnItemText: TAdvSmoothListBoxItemTextEvent read FOnItemText write FOnItemText;
    property OnAnchorClick: TAdvSmoothListBoxAnchorClickEvent read FOnAnchorClick write FOnAnchorClick;
    property OnItemAnchorClick: TAdvSmoothListBoxItemAnchorClickEvent read FOnItemAnchorClick write FOnItemAnchorClick;
    property OnItemCaptionClick: TAdvSmoothListBoxItemCaptionClick read FOnItemCaptionClick write FOnItemCaptionClick;
    property OnItemInfoClick: TAdvSmoothListBoxItemInfoClick read FOnItemInfoClick write FOnItemInfoClick;
    property OnItemChanged: TAdvSmoothListBoxItemChanged read FOnItemChanged write FOnItemChanged;
    property ShowFocus: Boolean read FShowFocus write SetShowFocus default true;
    property FocusColor: TColor read FFocusColor write SetFocusColor default clBlack;
    property DragOpacity: Byte read FDragOpacity write SetDragOpacity default 200;
    property DragAlphaBlend: Boolean read FDragAlphaBlend write SetDragAlphaBlend default true;
    property DragBorderWidth: integer read FDragBorderWidth write SetDragBorderWidth default 1; 
    property DragBorderColor: TColor read FDragBorderColor write SetDragBorderColor default clBlack;
    property DefaultItem: TAdvSmoothListBoxItem read FDefaultItem write SetDefaultItem;
    property ItemImage: TAdvGDIPPicture read FItemImage write SetItemImage;
    property DetailItemImage: TAdvGDIPPicture read FDetailItemImage write SetDetailItemImage;
    property SelectionMode: TAdvSmoothListBoxSelectionMode read FSelectionMode write SetSelectionMode default sAutoDeselect;
    property ItemDragging: Boolean read FItemDragging write SetItemDragging default true;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default false;
    property CategoryType: TAdvSmoothListBoxCategoryType read FCategoryType write SetCategoryType default alphanumeric;
    property Categories: TAdvSmoothListBoxCategoryItems read FCategories write SetCategories;

    property Align;
    property Anchors;
    property Constraints;
    property PopupMenu;
    property TabOrder;
    property ParentShowHint;
    property ShowHint;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
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

const
  CLICKMARGIN = 2;

{$I GDIPHTMLEngine.pas}

type
  {$HINTS OFF}
  TShadowedCollection = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TList;
  end;
  {$HINTS ON}

{$IFNDEF DELPHI7_LVL}
function GetFileVersion(FileName:string): Integer; var
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

procedure GetCaptionPosition(var x, y: integer; rectangle: TGPRectF; objectwidth, objectheight: integer; location: TAdvSmoothListBoxCaptionLocation);
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
end;

procedure DrawPicture(g: TGPGraphics; picture: TAdvGDIPPicture; location: TFillPicturePosition; r: TRect; x, y: integer);
var
  w, h: integer;
begin
  if not picture.Empty then
  begin
    picture.GetImageSizes;
    w := picture.Width;
    h := picture.Height;
    case location of
    ppTopLeft: picture.GDIPDraw(g, Rect(r.Left,r.Top,r.Left + w, r.Top + h));
    ppTopCenter:
    begin
      r.Left := r.Left + ((r.Right - r.Left) - w) div 2;
      picture.GDIPDraw(g, Rect(r.Left,r.Top,r.Left + w, r.Top + h));
    end;
    ppTopRight: picture.GDIPDraw(g, Rect(r.Right - w, r.Top, r.Right, r.Top + h));
    ppBottomLeft: picture.GDIPDraw(g, Rect(r.Left, r.Bottom - h, r.Left + w, r.Bottom));
    ppBottomCenter:
    begin
      r.Left := r.Left + ((r.Right - r.Left) - w) div 2;
      picture.GDIPDraw(g, Rect(r.Left, r.Bottom - h, r.Left + w, r.Bottom));
    end;
    ppBottomRight: picture.GDIPDraw(g, Rect(r.Right - w, r.Bottom - h, r.Right, r.Bottom));
    ppStretched: picture.GDIPDraw(g, Rect(r.Left,r.Top,r.Right, r.Bottom));
    ppCustom: picture.GDIPDraw(g, Bounds(x, y, w, h));
    ppCenterLeft:
      begin
        r.Top := r.Top + ((r.Bottom - r.Top) - h) div 2;
        picture.GDIPDraw(g, Rect(r.Left,r.Top,r.Left + w, r.Top + h));
      end;
    ppCenterRight:
      begin
        r.Top := r.Top + ((r.Bottom - r.Top) - h) div 2;
        picture.GDIPDraw(g, Rect(r.Right - w,r.Top,r.Right, r.Top + h));
      end;
    ppCenterCenter:
      begin
        r.Left := r.Left + ((r.Right - r.Left) - w) div 2;
        r.Top := r.Top + ((r.Bottom - r.Top) - h) div 2;
        picture.GDIPDraw(g, Rect(r.Left,r.Top,r.Left + w, r.Top + h));
      end;
    end;
  end;
end;

function AnimateDouble(var Start, Stop: integer; Delta: Double; Margin: integer): Boolean;
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

function TAdvSmoothListBox.GetBottomIndex: integer;
var
  res: integer;
begin
  res := YToItem((InsideRect.Right - InsideRect.Left) div 2, GetDisplayRect.Bottom, false, false);
  if res = -1 then
    result := FDisplayList.Count - 1
  else
    result := res + 1;
end;

function TAdvSmoothListBox.GetDisplayIndex(ItemIndex: integer): integer;
var
  i: integer;
begin
  Result := -1;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    if FDisplayList.GetItem(i).DisplayItem <> nil  then
    begin
      if FDisplayList.GetItem(i).DisplayItem.Index = itemindex then
      begin
        Result := i;
        break;
      end;
    end;
  end;
end;

function TAdvSmoothListBox.GetDisplayRect: TRect;
begin
  Result := Bounds(InsideRect.Left, InsideRect.Top + Header.GetHeight, InsideRect.Right - LookupBar.GetWidth - InsideRect.Left - GetShadowOffset,
    InsideRect.Bottom - InsideRect.Top - Footer.GetHeight - Header.GetHeight - GetShadowOffset);
end;

function TAdvSmoothListBox.GetFullHeight: integer;
begin
  result := 0;
  if FDisplayList.Count > 0 then
    Result := FDisplayList.GetItem(FDisplayList.Count - 1).ItemRect.Top + ItemAppearance.Height;

  Result := Result - Height + Footer.GetHeight + GetShadowOffset;
end;

function TAdvSmoothListBox.GetFullWidth: integer;
begin
  Result := 0;
end;

function TAdvSmoothListBox.GetHeaderFooterCaptionRect(
  Part: TAdvSmoothListBoxHeaderFooter; Header: Boolean): TRect;
var
  g: TGPGraphics;
  r, htmlr: TRect;
  fillr: TGPRectF;
  a, s, k: String;
  XSize, Ysize: integer;
  l, m: integer;
  hr: TRect;
  x, y: integer;
  rc: TRect;
begin
  with Part do
  begin
    if Visible then
    begin
      g := TGPGraphics.Create(Canvas.Handle);

      rc := InsideRect;

      if header then
        r := Bounds(rc.Left, rc.Top, rc.Right - rc.Left - GetShadowOffset, Height)
      else
        r := Bounds(rc.Left, rc.Bottom - Height - GetShadowOffset, rc.Right - rc.Left - GetShadowOffset, Height);

      fillr := MakeRect(R.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top);

      if Caption <> '' then
      begin
        htmlr := Rect(0, 0, 10000, 10000);

        HTMLDrawGDIP(g, FFont, Caption,htmlr,FImages, 0,0,-1,-1,CaptionShadowOffset,False,true,false,false,
          False,False,true,1.0,CaptionURLColor,clNone,clNone,CaptionShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

        if CaptionLocation <> cpCustom then
          GetCaptionPosition(x, y, fillr, XSize, YSize, CaptionLocation)
        else
        begin
          x := CaptionLeft;
          y := CaptionTop;
        end;

        Result := Bounds(Round(fillr.X + x), Round(fillr.Y + y), xsize, ysize);

      end;
      g.Free;
    end;
  end;
end;

function TAdvSmoothListBox.GetHeaderFooterRect(Part: TAdvSmoothListBoxHeaderFooter; Header: Boolean): TRect;
var
  rc: TRect;
begin
  with Part do
  begin
    if Visible then
    begin
      rc := InsideRect;
      if header then
        Result := Bounds(rc.Left, rc.Top, rc.Right - rc.Left - GetShadowOffset, Height)
      else
        Result := Bounds(rc.Left, rc.Bottom - Height - GetShadowOffset, rc.Right - rc.Left - GetShadowOffset, Height);
    end;
  end;
end;

function TAdvSmoothListBox.GetMaximumCustomTextHeight(
  ACanvas: TCanvas): integer;
var
  I: integer;
  tempw: integer;
  tw: integer;
  s: String;
begin
  tempw := 0;
  for I := 0 to Categories.Count - 1 do
  begin
    with Categories[I] do
    begin
      if LookupText <> '' then
        s := LookupText
      else
        s := Text;

      tw := ACanvas.TextWidth(s);
      if tw > tempw then
        tempw := tw
    end;
  end;

  if tempw > 0 then
    tempw := tempw + 4;

  result := tempw;
end;


function TAdvSmoothListBox.GetMaximumCustomTextWidth(ACanvas: TCanvas): integer;
var
  I: integer;
  tempw: integer;
  tw: integer;
  s: string;
begin
  tempw := 0;
  for I := 0 to Categories.Count - 1 do
  begin
    with Categories[I] do
    begin
      if LookupText <> '' then
        s := LookupText
      else
        s := Text;

      if LookupBar.Rotated then
      begin
        tw := ACanvas.TextHeight(s);
      end
      else
      begin
        if Assigned(FImages) then
        begin
          if (FImageIndex > -1) and (FImageIndex < FImages.Count) then
            tw := ACanvas.TextWidth(s) + FImages.Width
          else
            tw := ACanvas.TextWidth(s);
        end
        else
          tw := ACanvas.TextWidth(s);
      end;

      if tw > tempw then
        tempw := tw
    end;
  end;

  if tempw > 0 then
    tempw := tempw + 4;
    
  result := tempw;
end;

function TAdvSmoothListBox.GetNewCanvas: TCanvas;
begin
  if FBypassBitBlt then
  begin
    if not Assigned(FDrawingBitmap) then
      FDrawingBitmap:= TBitmap.Create;

    if Width <> FDrawingBitmap.Width then
      FDrawingBitmap.Width:= Width;

    if Height <> FDrawingBitmap.Height then
      FDrawingBitmap.Height:= Height;

    Result:= FDrawingBitmap.Canvas;
  end
  else
    Result:= inherited Canvas;
end;

function TAdvSmoothListBox.GetPosition: integer;
begin
  if not (csDesigning in ComponentState) then
  begin
    if FCurrentScPos <> FScPosTo then
    begin
      if FCurrentScPos < -50 then
        FCurrentScPos := -50

      else if FCurrentScPos > GetFullHeight + 50 then
        FCurrentScPos := GetFullHeight + 50;
    end;

    result := FCurrentScPos;
  end
  else
    Result := 0;


  if GetFullHeight + Height < Height then
    result := 0;
end;

function TAdvSmoothListBox.GetPositionTo: Integer;
begin
  if not (csDesigning in ComponentState) then
  begin
    if FScPosTo < 0 then
      FscposTo := 0

    else if FScPosTo > GetFullHeight then
      FscposTo := GetFullHeight;

    result := FScPosTo;
  end
  else
    Result := 0;
end;

function TAdvSmoothListBox.GetSelectedItemIndex: integer;
begin
  if Items.SelectedItem <> nil then
    Result := Items.SelectedItem.Index
  else
    Result := -1;
end;

function TAdvSmoothListBox.GetShadowOffset: integer;
begin
  Result := 0;
  if FFill.ShadowColor <> clNone then
    result := FFill.ShadowOffset;
end;

procedure TAdvSmoothListBox.GetTextPosition(var x, y: integer;
  rectangle: TGPRectF; objectwidth, objectheight: integer;
  location: TAdvSmoothListBoxLocation);
var
  w, h, tw, th: integer;
begin
  tw := objectwidth;
  th := objectheight;
  w := Round(rectangle.Width);
  h := Round(rectangle.Height);
  case location of
    plTopLeft:
    begin
      x := 0;
      y := 0;
    end;
    plTopRight:
    begin
      x := w - tw;
      y := 0;
    end;
    plBottomLeft:
    begin
      x := 0;
      y := h - th;
    end;
    plBottomRight:
    begin
      x := w - tw;
      y := h - th;
    end;
    plTopCenter:
    begin
      x := (w - tw) div 2;
      y := 0;
    end;
    plBottomCenter:
    begin
      x := (w - tw) div 2;
      y := h - th;
    end;
    plCenterCenter:
    begin
      x := (w - tw) div 2;
      y := (h - th) div 2;
    end;
    plCenterLeft:
    begin
      x := 0;
      y := (h - th) div 2;
    end;
    plCenterRight:
    begin
      x := w - tw;
      y := (h - th) div 2;
    end;
  end;
end;

function TAdvSmoothListBox.GetTopIndex: integer;
begin
  Result := Max(0, YToItem((InsideRect.Right - InsideRect.Left) div 2, GetDisplayRect.Top, false, true));
end;

function TAdvSmoothListBox.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvSmoothListBox.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvSmoothListBox.HeaderFooterChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothListBox.HideDetails;
begin
  if Assigned(FCurrentControl) and FDetailShow then
  begin
    FDetailShow := false;
    FDetailStatus := dsDetailsNotVisible;
    FCurrentControl.Left := 0;
    DoHideDetail(self, FDetailIndex);
  end;
end;

procedure TAdvSmoothListBox.InitDisplayList;
var
  I: Integer;
  thsection, twlookup: integer;
  prevrect: TRect;
  j: integer;
  ca: TCanvas;
begin
  if (csDestroying in ComponentState) or not Assigned(Canvas) then
    Exit;

  FDisplayList.Clear;

  ca := TCanvas.Create;
  ca.Handle := Canvas.Handle;

  ca.Font.Assign(Sections.Font);
  thsection := ca.TextHeight('gh') + 4;
  twLookup := 0;

  ca.Free;

  if LookupBar.Visible and (not LookupBar.OnTop) then
  begin
    twLookup := LookupBar.GetWidth;
    FLookUpSize := twlookup;
  end;

  prevrect := Rect(0, GetShadowOffset, 0, Header.GetHeight);

  j := 0;
  for I := 0 to Items.Count - 1 do
  begin
    if Sections.Visible then
    begin
      if I = 0 then
      begin
        AddDisplaySection(Items[I], prevrect, thsection, twLookup);
        AddDisplayItem(Items[I], prevrect, ItemAppearance.Height, twLookup);
        Inc(J);
      end
      else
      begin
        if ItemFromDifferentCategory(Items[I], Items[J - 1]) and (not Items[I].Splitter) then
        begin
          AddDisplaySection(Items[I], prevrect, thsection, twLookup);
          AddDisplayItem(Items[I], prevrect, ItemAppearance.Height, twLookup);
          Inc(J);
        end
        else
        begin
          AddDisplayItem(Items[I], prevrect, ItemAppearance.Height, twLookup);
          if not Items[I].Splitter then
            Inc(J);
        end;
      end;
    end
    else
    begin
      AddDisplayItem(Items[I], prevrect, ItemAppearance.Height, twLookup);
    end;
  end;
end;

procedure TAdvSmoothListBox.InitPreview;
var
  i: integer;
begin
  Items.Clear;
  FFooter.Caption := 'Footer';
  FFooter.Font.Size := 10;
  FFooter.FFont.Color := clWhite;

  FHeader.Caption := 'Header';
  FHeader.Font.Size := 10;
  FHeader.FFont.Color := clWhite;

  for I := 0 to 20 do
    Items.Add;
end;

procedure TAdvSmoothListBox.InitSelection(itemindex: integer);
begin
  FSelectedItemIndex := -1;
  FFocusedItemIndex := -1;
end;

procedure TAdvSmoothListBox.InitState;
begin
  FMouseUp := false;
  FMouseDown := false;
end;

function TAdvSmoothListBox.InsideRect: TRect;
var
  bw: integer;
begin
  Result := ClientRect;
  // adapt width & height for GDI+ drawing rect
  Result.Right := Result.Right - 1;
  Result.Bottom := Result.Bottom - 1;

  if (Fill.BorderColor <> clNone) then
  begin
    if Fill.BorderWidth = 1 then
      bw := 1
    else
      bw := (Fill.BorderWidth + 1) div 2;

    InflateRect(Result, -bw, -bw);
  end;

end;

procedure TAdvSmoothListBox.ItemAppearanceChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothListBox.ItemAtXY(X, Y: integer): integer;
var
  displ: integer;
  DItem: TAdvSmoothListBoxItem;
begin
  Result := -1;
  displ := YToItem(X, Y, false);
  if displ <> -1 then
  begin
    DItem := FDisplayList.GetItem(displ).DisplayItem;
    if DItem <> nil then
      Result := DItem.Index;
  end;
end;

function TAdvSmoothListBox.YToItem(X, Y: integer; CountSections: Boolean = false; CheckDisplayRectangle: Boolean = true): integer;
var
  i: Integer;
  c, check: Boolean;
begin
  Result := -1;
  if CheckDisplayRectangle then
    check := PtInRect(GetDisplayRect, Point(X, Y))
  else
    check := true;

  for i := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      if CountSections then
        c := true
      else
        c := (DisplayItem <> nil);

      if c then
      begin
        if PtInRect(ItemRect, Point(X, Y + GetPosition)) and check then
        begin
          Result := i;
          Break;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothListBox.ItemFromDifferentCategory(item1,
  item2: TAdvSmoothListBoxItem): Boolean;
begin
  Result := false;
  if (item1 = nil) or (item2 = nil) then
  begin
    Result := true
  end
  else
  begin
    case CategoryType of
      alphanumeric:
      begin
        if (Length(item1.Caption) > 0) and (Length(item2.Caption) > 0) then
        begin
          Result := (Item1.Caption[1] <> item2.Caption[1]);
        end
        else
        begin
          if (Length(item1.Caption) = 0) and (Length(item2.Caption) = 0) then
            Result := false
          else
            Result := true;
        end;
      end;
      custom:
      begin
        if (item1.CategoryID > -1) and (item2.CategoryID > -1) then
        begin
          Result := (Item1.CategoryID <> item2.CategoryID);
        end
        else
        begin
          if (item1.CategoryID = -1) and (item2.CategoryID = -1) then
            Result := false
          else
            Result := true;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothListBox.ItemsChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothListBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  KeyCheck: Word;
  i, sh: integer;
  prev: integer;
  doelse: Boolean;
begin
  inherited;


  doelse := true;
  if (FFocusedItemIndex >= 0) and (FFocusedItemIndex <= Items.Count - 1) then
  begin
    if ((Items[FFocusedItemIndex].GraphicLeftType = gtCheckBox) or (Items[FFocusedItemIndex].GraphicRightType = gtCheckBox))
      and (Key = VK_SPACE) then
        Items[FFocusedItemIndex].Checked := not Items[FFocusedItemIndex].Checked;
  end;

  if not doelse then
    Exit;


  prev := FSelectedItemIndex;

  if (FDisplayList.Count = 0) or (Key = VK_MENU{alt}) or (Key = VK_CONTROL) or (Key = VK_SHIFT) then
    exit;

  FTimerCount := 0;

  KeyCheck := 0;
  case ShowDetailKey of
    dkSpace: KeyCheck := VK_SPACE;
    dkF2: KeyCheck := VK_F2;
    dkReturn: KeyCheck := VK_RETURN;
  end;

  if FDetailStatus = dsDetailsVisible then
  begin
    if Key = KeyCheck then
      HideDetails;
  end
  else
  begin
    if (Key = KeyCheck) or (FSelectionMode = sPersistSelectionAlways) then
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
            Items.SelectedItem := FItems[FSelectedItemIndex];
            Items.SelectedItem.Selected := true;
          end
        end
        else
          ShowDetails;

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
        ShowDetails;
    end
    else
    begin
      if MultiSelect then
      begin
        case Key of
          VK_DOWN: Inc(FFocusedItemIndex);
          VK_UP: Dec(FFocusedItemIndex);
          VK_HOME: FFocusedItemIndex := 0;
          VK_END: FFocusedItemIndex := FDisplayList.Count - 1;
          VK_NEXT: FFocusedItemIndex := FFocusedItemIndex + 5;
          VK_PRIOR: FFocusedItemIndex := FFocusedItemIndex - 5;
        end;

        FFocusedItemIndex := Min(Items.Count - 1, Max(0, FFocusedItemIndex));
        while Items[FFocusedItemIndex].Splitter and (FFocusedItemIndex > 0) do
        begin
          case Key of
            VK_DOWN: Inc(FFocusedItemIndex);
            VK_UP: Dec(FFocusedItemIndex);
            VK_HOME: FFocusedItemIndex := 0;
            VK_END: FFocusedItemIndex := FDisplayList.Count - 1;
            VK_NEXT: FFocusedItemIndex := FFocusedItemIndex + 5;
            VK_PRIOR: FFocusedItemIndex := FFocusedItemIndex - 5;
          end;
        end;

        sh := 0;
        if Sections.Visible then
          sh := FDisplayList.GetItem(0).ItemRect.Bottom - FDisplayList.GetItem(0).ItemRect.Top;

        FFocusedItemIndex := Min(Items.Count - 1, Max(0, FFocusedItemIndex));

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

        for I := 0 to FDisplayList.Count - 1 do
        begin
          with FDisplayList.GetItem(i) do
          begin
            if DisplayItem <> nil then
            begin
              if DisplayItem.Index = FFocusedItemIndex then
              begin
                if ItemRect.Top - GetPosition > Height - Footer.GetHeight - (ItemRect.Bottom-ItemRect.Top) then
                  FScPosTo := ItemRect.Bottom - (Height - Footer.GetHeight)
                else if ItemRect.Top < GetPosition + Header.GetHeight then
                  FScPosTo := ItemRect.Top - Header.GetHeight - sh;

                if FScposTo <> FCurrentScPos then
                begin
                  ScrollIndicator.FAnimateOpacity := ScrollIndicator.Opacity;
                  FCurrentScPos := FScPosTo;
                  FAnimate := true;
                end;
              end;
            end;
          end;
        end;
        Changed;
      end
      else if (Key = VK_DOWN) or (Key = VK_UP) or (Key = VK_LEFT) or (Key = VK_Right)
        or (Key = VK_END) or (Key = VK_NEXT) or (Key = VK_PRIOR) or (Key = VK_HOME) then
      begin
        //FSelectedItemIndex := FFocusedItemIndex;
        case Key of
          VK_DOWN, VK_RIGHT: Inc(FSelectedItemIndex);
          VK_UP, VK_LEFT: Dec(FSelectedItemIndex);
          VK_HOME: FSelectedItemIndex := 0;
          VK_END: FSelectedItemIndex := FDisplayList.Count - 1;
          VK_NEXT: FSelectedItemIndex := FSelectedItemIndex + 5;
          VK_PRIOR: FSelectedItemIndex := FSelectedItemIndex - 5;
        end;

        FSelectedItemIndex := Min(Items.Count - 1, Max(0, FSelectedItemIndex));
        while Items[FSelectedItemIndex].Splitter and (FSelectedItemIndex > 0) do
        begin
          case Key of
            VK_DOWN, VK_RIGHT: Inc(FSelectedItemIndex);
            VK_UP, VK_LEFT: Dec(FSelectedItemIndex);
            VK_HOME: FSelectedItemIndex := 0;
            VK_END: FSelectedItemIndex := FDisplayList.Count - 1;
            VK_NEXT: FSelectedItemIndex := FSelectedItemIndex + 5;
            VK_PRIOR: FSelectedItemIndex := FSelectedItemIndex - 5;
          end;
        end;

        sh := 0;
        if Sections.Visible then
          sh := FDisplayList.GetItem(0).ItemRect.Bottom - FDisplayList.GetItem(0).ItemRect.Top;

        FSelectedItemIndex := Min(Items.Count - 1, Max(0, FSelectedItemIndex));
        Items.SelectedItem := FItems[FSelectedItemIndex];

        for I := 0 to FDisplayList.Count - 1 do
        begin
          with FDisplayList.GetItem(i) do
          begin
            if DisplayItem <> nil then
            begin
              if DisplayItem.Index = FSelectedItemIndex then
              begin
                if ItemRect.Top - GetPosition > Height - Footer.GetHeight - (ItemRect.Bottom-ItemRect.Top) then
                  FScPosTo := ItemRect.Bottom - (Height - Footer.GetHeight)
                else if ItemRect.Top < GetPosition + Header.GetHeight then
                  FScPosTo := ItemRect.Top - Header.GetHeight - sh;

                if FScposTo <> FCurrentScPos then
                begin
                  ScrollIndicator.FAnimateOpacity := ScrollIndicator.Opacity;
                  FCurrentScPos := FScPosTo;
                  FAnimate := true;
                end;
              end;
            end;
          end;
        end;
        Changed;
      end;
    end;
  end;

  if FSelectedItemIndex <> prev then
    if Assigned(FOnItemSelectionChanged) then
      FOnItemSelectionChanged(Self, prev, FSelectedItemIndex);

  if not (Key = VK_F4) then
  begin
    if Assigned(FOnItemSelected) then
      FOnItemSelected(Self, FSelectedItemIndex);
  end;

  if (Key in [VK_DOWN, VK_UP, VK_LEFT, VK_RIGHT, VK_SPACE, VK_RETURN, VK_HOME, VK_END]) then
    FLookupKey := '';

end;

procedure TAdvSmoothListBox.KeyPress(var Key: char);
var
  i, sh, prev: integer;
  flg: boolean;
begin
  inherited;

  if Key = #32 then
  begin
    if Assigned(OnItemClick) then
      OnItemClick(Self, SelectedItemIndex);
  end;
  
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

  sh := 0;
  if Sections.Visible then
    sh := FDisplayList.GetItem(0).ItemRect.Bottom;

  prev := FSelectedItemIndex;
  for i := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      if DisplayItem <> nil then
      begin
        if pos(Uppercase(FLookupKey), Uppercase(DisplayItem.Caption)) = 1 then
        begin
          Items.SelectedItem := DisplayItem;
          FAnimate := true;
          
          if Sections.Visible then          
            FScPosTo := ItemRect.Top - sh
          else
            FScPosTo := ItemRect.Top - Header.GetHeight;

          FSelectedItemIndex := DisplayItem.Index;

          if FSelectedItemIndex <> prev then
            if Assigned(FOnItemSelectionChanged) then
              FOnItemSelectionChanged(Self, prev, FSelectedItemIndex);

          if Assigned(FOnItemSelected) then
            FOnItemSelected(Self, FSelectedItemIndex);
          FLookupKey := '';
          FSp := FSpeedFactor;
          flg := true;
          break;
          Changed;
        end;
      end;
    end;
  end;

  if not flg then
    FLookupKey := '';
end;

procedure TAdvSmoothListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  item: integer;
  AnchorI, AnchorF, AnchorH: String;
  rh, rf: TRect;
begin
  inherited;

  if FAnimatingdetail then
    Exit;

  FMouseDown := true;  

  //HEADER
  rh := GetHeaderFooterCaptionRect(Header, true);
  AnchorH := Header.GetAnchorAt(rh, X, Y);

  //FOOTER
  rf := GetHeaderFooterCaptionRect(Footer, false);
  AnchorF := Footer.GetAnchorAt(rf, X, Y);
                                                
  //ITEMS
  item := YToItem(X, Y);
  if item <> -1 then
  begin
    with FDisplayList.GetItem(item).DisplayItem do
    begin
      AnchorI := GetAnchorAt(X, Y);
      
      if PtInRect(finfor, Point(X, Y)) then
        DoItemInfoClick(Self, Index);

      if PtInRect(fcaptionr, Point(X, Y)) then
        DoItemCaptionClick(Self, Index);

      if (PtInRect(fgrLeft, Point(X, Y)) and Enabled) then
      begin
        case GraphicLeftType of
          gtButton, gtSmoothButton: FButtonLeft := not FButtonLeft;
        end;
        Changed;
      end;

      if (PtInRect(fgrRight, Point(X, Y)) and Enabled) then
      begin
        case GraphicRightType of
          gtButton, gtSmoothButton: FButtonRight := not FButtonRight;
        end;
        Changed;
      end;
    end;
  end;

  if (AnchorI <> '') or (AnchorF <> '') or (AnchorH <> '') then
  begin
    if AnchorI <> '' then
    begin
      if item <> -1 then
      begin
        with FDisplayList.GetItem(item).DisplayItem do
          DoItemAnchorClick(Self, AnchorI, Index);
      end;
    end;

    if AnchorF <> '' then
      DoAnchorClick(Self, AnchorF);

    if AnchorH <> '' then
      DoAnchorClick(Self, AnchorH);
  end;
    
  FDragY := Y;
  FScrollY := Y;
  FTimeStart := GetTickCount;
  FDragClickY := Y;
  FClickY := Y;
  FClickX := X;
end;

procedure TAdvSmoothListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  item: integer;
  AnchorF, AnchorH, AnchorI: String;
  rh, rf, dfb, r: TRect;
  dItem: TAdvSmoothListBoxItem;
  di: TImage;
  mindrag, maxdrag: integer;
  AllowDrag: Boolean;
  i: integer;
begin
  inherited;
  
  if (csDesigning in ComponentState) or (FDetailStatus = dsDetailsVisible)
    or (FAnimatingdetail) then
  begin
    FMouseDown := false;
    FMouseUp := false;
    Exit;
  end;

  if FLookUp then
  begin
    FTimeStart := 0;
    FTimeStop := 0;
  end;

  if FMouseDown then
  begin
    if (ssAlt in Shift) and ItemDragging then
    begin
      if not Assigned(FDragItemForm) then
      begin
        //Build Form
        FDragItemForm := nil;
        item := YToItem(X, Y, false);
        if item <> -1 then
        begin
          DItem := FDisplayList.GetItem(item).DisplayItem;
          AllowDrag := true;
          if Assigned(FOnItemDragStart) then
            if DItem <> nil then            
              FOnItemDragStart(Self, item, allowdrag);

          if AllowDrag and (DItem <> nil) then
          begin
            FMode := dmDrag;
            FSelectedDragItem := DItem;
            r := FDisplayList.GetItem(item).FItemRect;
            dfb := Bounds(r.Left , r.Top , r.Right - r.Left , r.Bottom - r.Top + GetPosition);

            FDragItemForm := TForm.Create(Application);
            FDragItemForm.Position := poDesigned;
            FDragItemForm.SetBounds(Self.Parent.ClientOrigin.X + Self.Left + r.Left , dfb.Top + Self.Parent.ClientOrigin.Y + Self.Top - GetPosition, r.Right - r.Left, r.Bottom - r.Top);

            FDragOldTop := FDragItemForm.Top;

            FDragItemForm.BorderStyle := bsNone;
            FDragItemForm.BorderWidth := DragBorderWidth;
            FDragItemForm.Brush.Style := bsClear;
            FDragItemForm.Brush.Color := DragBorderColor;
            {$IFDEF DELPHI6_LVL}
            FDragItemForm.AlphaBlend := DragAlphaBlend;
            FDragItemForm.AlphaBlendValue := DragOpacity;
            {$ENDIF}
            di := TImage.Create(FDragItemForm);
            di.Width := r.Right - r.Left;
            di.Height := r.Bottom - R.Top;
            FSelectedDragItem.Draw(di.Canvas, Bounds(0, GetPosition, r.Right - r.Left, r.Bottom - r.Top), item);
//            BitBlt(di.Canvas.Handle,0,0,r.Right, r.Bottom - getPosition, Self.Canvas.Handle, r.Left, r.Top - GetPosition, SRCCopy);
            di.Parent := FDragItemForm;
            FDragItemForm.Show;
          end;
        end;
      end;
      if FDragItemForm <> nil then
      begin
        mindrag := Self.Top + Self.Parent.ClientOrigin.Y + Header.GetHeight;
        maxdrag := Self.Top + Self.Parent.ClientOrigin.Y + self.Height - GetShadowOffset - Footer.GetHeight - FDragItemForm.Height;

        FDragDelta := (Y - FDragClickY);
        FDragItemForm.SetBounds(FDragItemForm.Left, Min(maxdrag, Max(FDragDelta + FDragOldTop, mindrag)) , FDragItemForm.Width, FDragItemForm.Height);

        if ((FDragItemForm.Top = mindrag) and (ClientToScreen(Point(X, Y)).Y < FDragItemForm.Top)) or
          ((FDragItemForm.Top = maxdrag) and (ClientToScreen(Point(X, Y)).Y > FDragItemForm.Top + FDragItemForm.Height)) then
        begin
          if (FDragItemForm.Top = mindrag) then
            FDragAnimateDelta := ClientToScreen(Point(X, Y)).Y - FDragItemForm.Top
          else if (FDragItemForm.Top = maxdrag) then
            FDragAnimateDelta := ClientToScreen(Point(X, Y)).Y - FDragItemForm.Top - FDragItemForm.Height
          else
            FDragAnimateDelta := 0;
        end
        else
          FDragAnimateDelta := 0;

        FDragTimer.Enabled := (FDragItemForm.Top = maxdrag) or (FDragItemForm.Top = mindrag);

        if Assigned(FOnItemDragOver) then
        begin
          if FSelectedDragItem <> nil then
          begin
            item := YToItem(X, Y);
            if item <> -1 then
            begin
              DItem := FDisplayList.GetItem(item).DisplayItem;
              if DItem <> nil then
                FOnItemDragOver(Self, FSelectedDragItem.Index, dITem.Index);            
            end
            else
              FOnItemDragOver(Self, FSelectedDragItem.Index, -1);
          end;
        end;
      end;
    end
    else
    begin
      if Assigned(FDragItemForm) then
      begin
        FDragItemForm.Free;
        FDragItemForm := nil;
        if Assigned(FOnItemDragEnd) then
          if FSelectedDragItem <> nil then
            FOnItemDragEnd(Self, FSelectedDragItem.Index);
      end;

      FDragTimer.Enabled := false;
      FDragAnimateDelta := 0;
      FMode := dmRelease;      

      if ((FDragY < Y - CLICKMARGIN) or (FDragY > Y + CLICKMARGIN)) then
      begin
        ScrollIndicator.FAnimateOpacity := ScrollIndicator.Opacity;
        FSp := 4;
        FHoveredItemIndex := -1;

        case SelectionMode of
          sAutoDeselect:
          begin
            for I := 0 to FItems.Count - 1 do
              Items[I].Selected := false;
              
            FSelectedItemIndex := -1;
          end;
        end;

        FAnimate := false;

        if (Y - FDragY) > 0 then
         FCurrentScPos := GetPosition - Abs(Y - FDragY)
        else
          FCurrentScPos := GetPosition + Abs(Y - FDragY);

        FDragY := Y;
        FScPosTo := GetPosition;
        Changed;
      end;
    end;
  end
  else
  begin
    if FMouseUp and not FLookUp then
    begin
      FMouseUp := false;
      if ((FTimeStop - FTimeStart) > 500) or ((FTimeStop - FTimeStart) = 0) then
        exit;

      FSp := Abs(Y - FScrollY) / (FTimeStop - FTimeStart);
      if FSp > 0 then
      begin
        if (Y - FScrollY) > 0 then
          FScPosTo := FScPosTo - Round(Abs(Y - FScrollY) * FSp)
        else
          FScPosTo := FScPosTo + Round(Abs(Y - FScrollY) * FSp);
      end;
    end;
  end;

  if FMode = dmRelease then
  begin
    //HEADER
    rh := GetHeaderFooterCaptionRect(Header, true);
    AnchorH := Header.GetAnchorAt(rh, X, Y);

    //FOOTER
    rf := GetHeaderFooterCaptionRect(Footer, false);
    AnchorF := Footer.GetAnchorAt(rf, X, Y);

    //ITEM ANCHOR
    item := YToItem(X, Y);
    if item <> -1 then
    begin
      dItem := FDisplayList.GetItem(item).DisplayItem;
      if dItem <> nil then
      begin
        with dItem do
        begin
          AnchorI := GetAnchorAt(X, Y);
        end;
      end;
    end;

    if (AnchorI <> '') or (AnchorF <> '') or (AnchorH <> '') then
      Cursor := crHandPoint
    else
      Cursor := crArrow;  

    if Items.Count > 0 then
    begin
      //ITEMS
      if item <> -1 then
      begin
        dItem := FDisplayList.GetItem(item).DisplayItem;
        if Ditem <> nil then
        begin
          with dItem do
          begin
            if FhoveredItemIndex <> dItem.Index then
              Application.CancelHint;

            FhoveredItemIndex := DItem.Index;
            if (FPrevHoveredItemIndex <> FhoveredItemIndex) and (FPrevHoveredItemIndex >= 0) and (FPrevHoveredItemIndex <= Items.Count -1)
              and (FhoveredItemIndex >= 0) and (FhoveredItemIndex <= Items.Count -1) then
            begin
              with Items[FPrevHoveredItemIndex] do
              begin
                if not FMouseLeft then
                begin
                  if Assigned(FOnItemMouseLeave) then
                    FOnItemMouseLeave(Self, FPrevHoveredItemIndex);

                  FPrevHoveredItemIndex := FhoveredItemIndex;
                  FMouseLeft := true;
                  FMouseEntered := false;
                end;
              end;
            end;

            if (FhoveredItemIndex >= 0) and (FhoveredItemIndex <= Items.Count -1) then
            begin
              if not FMouseEntered then
              begin
                FPrevHoveredItemIndex := FHoveredItemIndex;
                if Assigned(FOnItemMouseEnter) then
                  FOnItemMouseEnter(Self, FhoveredItemIndex);

                FMouseEntered := true;
                FMouseLeft := false;
              end
            end;
          end;
        end;
      end
      else
      begin
        if (FHoveredItemIndex >= 0) and (FHoveredItemIndex <= Items.Count -1) then
        begin
          with Items[FhoveredItemIndex] do
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
      end;
    end;
  end;
end;

procedure TAdvSmoothListBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  selitem: Boolean;
  l, th, i, si, wr, wl: integer;
  ch: Char;
  s: String;
  stop, sh: integer;
  sdOnImg: Boolean;
  itemrclick, itemr, rh, rf: TRect;
  item: integer;
  DItem: TAdvSmoothListBoxItem;
  AllowDrop: Boolean;
  catid: integer;
  selecteditem: TAdvSmoothListBoxItem;
begin
  inherited;

  if FAnimatingdetail then
    Exit;

  if csDesigning in ComponentState then
    Exit;

  if FAnimating and FAnimate and not (GetFullHeight < Height) then
  begin
    FAnimate := false;
    FScrollY := GetPosition;
    FScPosTo := GetPosition;
    FCurrentScPos := GetPosition;
    FTimeStart := 0;
    FTimeStop := 0;
  end;

  FMouseDown := false;
  FMouseUp := true;
  FTimeStop := GetTickCount;
  FAnimate := (FTimeStop - FTimeStart > 0);
  FDragAnimateDelta := 0;
  FDragTimer.Enabled := false;
  selitem := true;

  for I := 0 to Items.Count - 1 do
  begin
    case Items[I].GraphicLeftType of
      gtButton, gtSmoothButton:
      begin
        Items[I].FButtonLeft := false;
      end;
    end;
    case Items[I].GraphicRightType of
      gtButton, gtSmoothButton: Items[I].FButtonRight := false;
    end;
  end;

  if FMode = dmRelease then
  begin
    if LookupBar.Visible then
    begin
      Canvas.Font.Assign(LookupBar.Font);
      th := 0;
      case CategoryType of
        alphanumeric:
        begin
          if not Lookupbar.Rotated then
            th := Canvas.TextHeight('gh')
          else
            th := Canvas.TextWidth('W');
        end;
        custom:
        begin
          if not Lookupbar.Rotated then
            th := Canvas.TextHeight('gh')
          else
            th := GetMaximumCustomTextHeight(Canvas);
        end;
      end;

      case LookupBar.Position of
        pLeft:
        begin
          selitem := not (X < FLookUpSize);
        end;
        pRight:
        begin
          selitem := not (X > InsideRect.Right - FLookUpSize - GetShadowOffset);
        end;
      end;

      if not selitem then
      begin
        case CategoryType of
          alphanumeric:
          begin
            if LookupBar.Numeric then
              stop := 35
            else
              stop := 26;

            if LookupBar.AutoSize then
              l := 1 + Round((Y - Header.GetHeight - (th / 2)) / (InsideRect.Bottom - InsideRect.Top - Footer.GetHeight - Header.GetHeight) * stop)
            else
            begin
              l := 1 + Round((Y - Header.GetHeight - ((th + LookupBar.Spacing) / 2)) / (th + LookupBar.Spacing));
            end;

            if LookupBar.FChar[l] then
            begin
              if l < 27 then
                ch := chr(ord('A') + (l - 1))
              else
                ch := chr(ord('0') + (l - 27));

              s := ch;
              if Assigned(FOnLookUpClick) then
                FOnLookUpClick(Self, l, s);

              if Sections.Visible then
              begin
                sh := FDisplayList.GetItem(0).ItemRect.Bottom;
                s := ch;
                FScPosTo := FindFirstItemWithChar(ch).ItemRect.Top - sh ;
                FCurrentScPos := FScPosTo;
              end
              else
              begin
                FScPosTo := FindFirstItemWithChar(ch).ItemRect.Top - Header.GetHeight;
                FCurrentScPos := FScPosTo;
              end;

              FLookUp := true;
              FSp := 2;
            end;
          end;
          custom:
          begin
            stop := Categories.Count;            
            if LookupBar.AutoSize then
              l := Round((Y - Header.GetHeight - (th / 2)) / (InsideRect.Bottom - InsideRect.Top - Footer.GetHeight - Header.GetHeight) * stop)
            else
              l := Round((Y - Header.GetHeight - ((th + LookupBar.Spacing) / 2)) / (th + LookupBar.Spacing));

            if (l > -1) and (l < Categories.Count) then
            begin
              catid := Categories[l].Id;
              if LookupBar.FCustomChar[catid] then
              begin
                if Categories[catid].LookupText <> '' then
                  s := Categories[catid].LookupText
                else
                  s := Categories[catid].Text;

                if Assigned(FOnLookUpClick) then
                  FOnLookUpClick(Self, l, s);

                if Sections.Visible then
                begin
                  sh := FDisplayList.GetItem(0).ItemRect.Bottom;
                  FScPosTo := FindFirstSectionWithCategoryID(catid).ItemRect.Top - sh ;
                  FCurrentScPos := FScPosTo;
                end
                else
                begin
                  FScPosTo := FindFirstItemWithCategoryID(catid).ItemRect.Top - ItemAppearance.Height - ItemAppearance.VerticalSpacing;
                  FCurrentScPos := FScPosTo;
                end;

                FLookUp := true;
                FSp := 2;
              end;
            end;
          end;
        end;
      end;
    end;

    if selitem and (PtInRect(GetDisplayRect, Point(X, Y))) then
    begin
      si := ItemAtXY(X, Y);
      if (si <> -1) and (si <= Items.Count - 1) then
      begin
        if Items[si].Enabled then
        begin
          if PtInRect(Items[si].fgrLeft, Point(X, Y)) and Items[si].Enabled and (Items[si].GraphicLeftType <> gtNone) then
          begin
            FGraphicClicked := cLeft;
            with Items[si] do
            begin
             case GraphicLeftType of
               gtSmoothButton, gtCommonDetailImage, gtImage, gtCommonImage, gtDetailImage: Expanded := not Expanded;
             end;
             case GraphicLeftType of
               gtCheckBox:
               begin
                 Checked := not Checked;
                 DoItemCheckClick(Self, Index, Checked);
               end;
               gtRadio:
               begin
                 for I := 0 to Items.Count - 1 do
                   Items[I].Checked := false;

                 Checked := not Checked;
                 DoItemRadioClick(Self, Index, Checked);
               end;
               gtButton, gtSmoothButton: DoItemButtonClick(Self, Index);
               gtImage, gtCommonImage: DoItemImageClick(Self, Index);
               gtDetailImage, gtCommonDetailImage:
               begin
                 DoItemImageClick(Self, Index);
               end;
             end;
            end
          end
          else if PtInRect(Items[si].fgrRight, Point(X, Y)) and Items[si].Enabled and (Items[si].GraphicRightType <> gtNone) then
          begin
            FGraphicClicked := cRight;
            with Items[si] do
            begin
              case GraphicRightType of
               gtCheckBox:
               begin
                 Checked := not Checked;
                 DoItemCheckClick(Self, Index, Checked);
               end;
               gtRadio:
               begin
                 for I := 0 to Items.Count - 1 do
                   Items[I].Checked := false;

                 Checked := not Checked;
                 DoItemRadioClick(Self, Index, Checked);
               end;
               gtButton, gtSmoothButton: DoItemButtonClick(Self, Index);
               gtImage, gtCommonImage: DoItemImageClick(Self, Index);               
               gtDetailImage, gtCommonDetailImage:
               begin
                 DoItemImageClick(Self, Index);
               end;
              end;
            end;
          end
          else if ((FScrollY > Y - CLICKMARGIN) and (FScrollY < Y + CLICKMARGIN)) then
          begin
            DItem := Items[si];
            if FSelectedItemIndex <> DItem.Index then
              if Assigned(FOnItemSelectionChanged) then
                FOnItemSelectionChanged(Self, FSelectedItemIndex, DItem.Index);

            if (ssShift in Shift) and MultiSelect then
            begin
              for I := 0 to Items.Count - 1 do
                Items[i].Selected := false;

              if Ditem.Index < FSelectedItemIndex then
              begin
                if FSelectedItemIndex <> -1 then
                  for I := FselectedItemIndex downto DItem.Index do
                    Items[I].Selected := true
              end
              else
              begin
                if FSelectedItemIndex <> -1 then
                  for I := FselectedItemIndex to DItem.Index do
                    Items[I].Selected := true
              end;

              if Assigned(FOnItemSelected) then
                FOnItemSelected(Self, DItem.Index);
            end
            else if ((ssCtrl in Shift) and MultiSelect) or ((FSelectionMode = sPersistSelectionAlways) and MultiSelect) then
            begin
              Items[DItem.Index].Selected := not Items[DItem.Index].Selected;
              if Assigned(FOnItemSelected) then
                FOnItemSelected(Self, DItem.Index);
            end
            else
            begin
              for I := 0 to Items.Count - 1 do
                Items[i].Selected := false;

              Items.Selecteditem := Ditem;
              Fselecteditemindex := Ditem.Index;
              Items.Selecteditem.Selected := True;
              Doitemclick(Self, Items.Selecteditem.Index);
              If Assigned(Fonitemselected) Then
                Fonitemselected(Self, Items.Selecteditem.Index);
            end;
          end;
        end;
        if (si > -1) and (si <= Items.Count - 1) and ((FScrollY > Y - 2) and (FScrollY < Y + 2)) then
        begin
          with Items[si] do
          begin
            sdOnImg := false;
            case ShowDetailClick of
              sdOnClick:
              begin
                itemr := FDisplayList.GetItem(si).ItemRect;
                wl := fgrLeft.Right - fgrLeft.Left;
                wr := fgrRight.Right - fgrRight.Left;
                itemrclick := Rect(itemr.Left + wl, itemr.Top - GetPosition, itemr.Right - wr, itemr.Bottom);

                if PtInRect(itemrclick, Point(X, Y)) then
                  ShowDetails;
              end;
              sdOnDetailImageClick: sdOnImg := true;
            end;
          end;
          if (PtInRect(Items[si].fgrLeft, Point(X, Y)) and Items[si].Enabled) then
          begin
           with Items[si] do
           begin
             case GraphicLeftType of
               gtDetailImage, gtCommonDetailImage:
               begin
                 if sdOnImg then
                   ShowDetails(si);
               end;
             end;
            end
          end
          else if (PtInRect(Items[si].fgrRight, Point(X, Y)) and Items[si].Enabled) then
          begin
            with Items[si] do
            begin
              case GraphicRightType of
               gtDetailImage, gtCommonDetailImage:
               begin
                 if sdOnImg then
                   ShowDetails(si);
               end;
              end;
            end;
          end;
        end;
      end;
      Changed;
    end
    else
    begin
      ScrollIndicator.FAnimateOpacity := ScrollIndicator.Opacity;
      FSp := 4;
    end;

    //HEADER
    rh := GetHeaderFooterRect(Header, true);
    if PtInRect(rh, Point(X, Y)) then
      if Assigned(FOnHeaderClick) then
        FOnHeaderClick(Self, X, Y);


    //FOOTER
    rf := GetHeaderFooterRect(Footer, false);

    if PtInRect(rf, Point(X, Y)) then
      if Assigned(FOnFooterClick) then
        FOnFooterClick(Self, X, Y);
  end
  else
  begin
    if Assigned(FDragItemForm) then
    begin
      FDragItemForm.Free;
      FDragItemForm := nil;
      Selecteditem := nil;
      if FSelectedItemIndex <> -1 then
        selecteditem := Items[SelectedItemIndex];

      FMode := dmRelease;
      item := YToItem(X, Y, false);
      if item <> -1 then
      begin
        DItem := FDisplayList.GetItem(item).DisplayItem;
        AllowDrop := true;
        if Assigned(FOnItemDragDrop) then
          if FSelectedDragItem <> nil then
            FOnItemDragDrop(Self, FSelectedDragItem.Index, DItem.Index, AllowDrop);

        if AllowDrop and (FSelectedDragItem <> nil) and (DItem <> nil) then
        begin
          FSelectedDragItem.Index := DItem.Index;

          if (selecteditem <> nil) and (FSelectedItemIndex <> -1) then
            FSelectedItemIndex := selecteditem.Index;

          InitDisplayList;
          Changed;
        end;
      end
      else
      begin
        if Assigned(FOnItemDragEnd) then
          if FSelectedDragItem <> nil then
            FOnItemDragEnd(Self, FSelectedDragItem.Index);
      end;
    end;
  end;
end;

procedure TAdvSmoothListBox.MouseWheelHandler(var Message: TMessage);
begin
  inherited;
  case Message.Msg of
    WM_MOUSEWHEEL:
    begin
      if FDetailStatus = dsDetailsNotVisible then
      begin
        if Message.WParam < 0 then
        begin
          FSp := FSpeedFactor;
          FScPosTo := FScPosTo + ItemAppearance.Height
        end
        else
        begin
          FSp := FSpeedFactor;
          FScPosTo := FScPosTo - ItemAppearance.Height;
        end;

        FAnimate := true;
      end;
    end;
  end;
end;

{$WARNINGS OFF}
// compiler generates incorrect warning
function NormalizeSpecialChar(s: string): string;
begin
  Result := s;

  if (AnsiCompareStr('A',s) < 0) and (AnsiCompareStr('B',s) > 0) then
    Result :=  'A'
  else
  if (AnsiCompareStr('C',s) < 0) and (AnsiCompareStr('D',s) > 0) then
    Result :=  'C'
  else
  if (AnsiCompareStr('E',s) < 0) and (AnsiCompareStr('F',s) > 0) then
    Result :=  'E'
  else
  if (AnsiCompareStr('G',s) < 0) and (AnsiCompareStr('H',s) > 0) then
    Result :=  'G'
  else
  if (AnsiCompareStr('H',s) < 0) and (AnsiCompareStr('I',s) > 0) then
    Result :=  'H'
  else
  if (AnsiCompareStr('I',s) < 0) and (AnsiCompareStr('J',s) > 0) then
    Result :=  'I'
  else
  if (AnsiCompareStr('J',s) < 0) and (AnsiCompareStr('K',s) > 0) then
    Result :=  'J'
  else
  if (AnsiCompareStr('K',s) < 0) and (AnsiCompareStr('L',s) > 0) then
    Result :=  'K'
  else
  if (AnsiCompareStr('L',s) < 0) and (AnsiCompareStr('M',s) > 0) then
    Result :=  'L'
  else
  if (AnsiCompareStr('N',s) < 0) and (AnsiCompareStr('N',s) > 0) then
    Result :=  'N'
  else
  if (AnsiCompareStr('O',s) < 0) and (AnsiCompareStr('P',s) > 0) then
    Result :=  'O'
  else
  if (AnsiCompareStr('P',s) < 0) and (AnsiCompareStr('Q',s) > 0) then
    Result :=  'P'
  else
  if (AnsiCompareStr('R',s) < 0) and (AnsiCompareStr('S',s) > 0) then
    Result :=  'R'
  else
  if (AnsiCompareStr('S',s) < 0) and (AnsiCompareStr('T',s) > 0) then
    Result :=  'S'
  else
  if (AnsiCompareStr('T',s) < 0) and (AnsiCompareStr('U',s) > 0) then
    Result :=  'T'
  else
  if (AnsiCompareStr('U',s) < 0) and (AnsiCompareStr('V',s) > 0) then
    Result :=  'U'
  else
  if (AnsiCompareStr('W',s) < 0) and (AnsiCompareStr('X',s) > 0) then
    Result :=  'W'
  else
  if (AnsiCompareStr('Z',s) < 0) then
    Result :=  'Z'
  else
    Result := s;

end;
{$WARNINGS ON}

procedure TAdvSmoothListBox.Notification(AComponent: TComponent;
  AOperation: TOperation);
var
  i: integer;
begin
 if (AOperation = opRemove) and (AComponent = FContainer) then
    FContainer := nil;
 
  if (AOperation = opRemove) and (AComponent = FImages) then
    FImages := nil;

  if (AOperation = opRemove) and (AComponent = FControl) then
    FControl := nil;

  inherited; 

  if (csDestroying in ComponentState) then  
    Exit;

  if (AOperation = opRemove) then
  begin
    for I := 0 to Items.Count - 1 do
    begin
      if (AComponent = Items[I].FControl) then
        Items[I].FControl := nil;
    end;
  end;
end;

procedure TAdvSmoothListBox.Paint;
var
  rgn: THandle;
begin
  DrawBackground;

//  if not FAnimatingdetail and ((FDetailStatus = dsDetailsNotVisible) or FBypassBitBlt) then

  if FDisplayList.Count > 0 then
  begin
    rgn := CreateRectRgn(InsideRect.Left, InsideRect.Top + Header.GetHeight, InsideRect.Right + 1{- InsideRect.Left}, InsideRect.Bottom - Footer.GetHeight - GetShadowOffset + 1);
    SelectClipRgn(Canvas.Handle,rgn);
    DrawItems;
    DrawScrollIndicator;
    DrawLookUpBar;
    SelectClipRgn(Canvas.Handle,0);
    DeleteObject(rgn);
  end;

  DrawHeaderFooter(Header, true);
  DrawHeaderFooter(Footer, false);

end;

procedure TAdvSmoothListBox.Resize;
var
  r: TRect;
begin
  inherited;

  InitDisplayList;

  if Assigned(FCurrentControl) then
  begin
    case FDetailStatus of
      dsDetailsNotVisible: FCurrentControl.Left := Self.Width;
      dsDetailsVisible: FCurrentControl.Left := 0;
    end;

    r := Rect(InsideRect.Left, Header.GetHeight, InsideRect.Right, InsideRect.Bottom - Footer.GetHeight - Header.GetHeight);

    FCurrentControl.Width := r.Right + 1;
    FCurrentControl.Height := r.Bottom + 1;
  end;
end;

procedure TAdvSmoothListBox.LookupBarChanged(Sender: TObject);
begin
  InitDisplayList;
  Changed;
end;

procedure TAdvSmoothListBox.ScrollIndicatorChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothListBox.ScrollToItem(ItemIndex: integer);
var
  i, sh: integer;
begin
  if (ItemIndex >= 0) and (ItemIndex <= Items.Count - 1) then
  begin

    sh := 0;
    if Sections.Visible then
      sh := FDisplayList.GetItem(0).ItemRect.Bottom - FDisplayList.GetItem(0).ItemRect.Top;

    FSelectedItemIndex := ItemIndex;
    Items.SelectedItem := FItems[FSelectedItemIndex];
    for I := 0 to FDisplayList.Count - 1 do
    begin
      with FDisplayList.GetItem(i) do
      begin
        if DisplayItem <> nil then
        begin
          if DisplayItem.Index = FSelectedItemIndex then
          begin
            if ItemRect.Top - GetPosition > Height - Footer.GetHeight - (ItemRect.Bottom-ItemRect.Top) then
              FScPosTo := ItemRect.Bottom - (Height - Footer.GetHeight)
            else if ItemRect.Top < GetPosition + Header.GetHeight then
              FScPosTo := ItemRect.Top - Header.GetHeight - sh;

            if FScPosTo <> FCurrentScPos then
            begin
              FCurrentScPos := FScPosTo;
              ScrollIndicator.FAnimateOpacity := ScrollIndicator.Opacity;
              FAnimate := true;
            end;
          end;
        end;
      end;
    end;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SectionsChanged(Sender: TObject);
begin
  InitDisplayList;
  Changed;
end;

procedure TAdvSmoothListBox.SetCategories(
  const Value: TAdvSmoothListBoxCategoryItems);
begin
  if FCategories <> value then
  begin
    FCategories.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetCategoryType(
  const Value: TAdvSmoothListBoxCategoryType);
begin
  if FCategoryType <> value then
  begin
    FCategoryType := Value;
    if FItems.FUpdateCount = 0 then
    begin
      if Assigned(FCurrentControl) then
        FCurrentControl.Left := width;
      LookupBar.InitLookupBar;
      InitDisplayList;
      Changed;
    end;
  end;
end;

procedure TAdvSmoothListBox.SetComponentStyle(AStyle: TTMSStyle);
begin
  // TODO : do color settings here
  SetProgressStyle(AStyle, false);
  
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

        ItemAppearance.FillDisabled.Color := $00F2F2F2;
        ItemAppearance.FillDisabled.ColorTo := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirror := clNone;
        ItemAppearance.FillDisabled.ColorMirrorTo := clNone;
        ItemAppearance.FillDisabled.BorderColor := $962D00;
        ItemAppearance.FillDisabled.GradientMirrorType := gtVertical;

        ItemAppearance.FillSelected.Color := $94E6FB;
        ItemAppearance.FillSelected.ColorTo := $1595EE;
        ItemAppearance.FillSelected.ColorMirror := clNone;
        ItemAppearance.FillSelected.ColorMirrorTo := clNone;
        ItemAppearance.FillSelected.BorderColor := $962D00;
        ItemAppearance.FillSelected.GradientMirrorType := gtVertical;

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

        ItemAppearance.FillDisabled.Color := $00F2F2F2;
        ItemAppearance.FillDisabled.ColorTo := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirror := clNone;
        ItemAppearance.FillDisabled.ColorMirrorTo := clNone;
        ItemAppearance.FillDisabled.BorderColor := $947C7C;
        ItemAppearance.FillDisabled.GradientMirrorType := gtVertical;

        ItemAppearance.FillSelected.Color := $94E6FB;
        ItemAppearance.FillSelected.ColorTo := $1595EE;
        ItemAppearance.FillSelected.ColorMirror := clNone;
        ItemAppearance.FillSelected.ColorMirrorTo := clNone;
        ItemAppearance.FillSelected.BorderColor := $947C7C;
        ItemAppearance.FillSelected.GradientMirrorType := gtVertical;
                
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

        ItemAppearance.FillDisabled.Color := $00F2F2F2;
        ItemAppearance.FillDisabled.ColorTo := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirror := clNone;
        ItemAppearance.FillDisabled.ColorMirrorTo := clNone;
        ItemAppearance.FillDisabled.BorderColor := $588060;
        ItemAppearance.FillDisabled.GradientMirrorType := gtVertical;

        ItemAppearance.FillSelected.Color := $94E6FB;
        ItemAppearance.FillSelected.ColorTo := $1595EE;
        ItemAppearance.FillSelected.ColorMirror := clNone;
        ItemAppearance.FillSelected.ColorMirrorTo := clNone;
        ItemAppearance.FillSelected.BorderColor := $588060;
        ItemAppearance.FillSelected.GradientMirrorType := gtVertical;
               
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

        ItemAppearance.FillDisabled.Color := $D8D5D4;
        ItemAppearance.FillDisabled.ColorTo := $D8D5D4;
        ItemAppearance.FillDisabled.ColorMirror := clNone;
        ItemAppearance.FillDisabled.ColorMirrorTo := clNone;
        ItemAppearance.FillDisabled.BorderColor := $808080;
        ItemAppearance.FillDisabled.GradientMirrorType := gtVertical;

        ItemAppearance.FillSelected.Color := $B59285;
        ItemAppearance.FillSelected.ColorTo := $B59285;
        ItemAppearance.FillSelected.ColorMirror := clNone;
        ItemAppearance.FillSelected.ColorMirrorTo := clNone;
        ItemAppearance.FillSelected.BorderColor := $962D00;
        ItemAppearance.FillSelected.GradientMirrorType := gtVertical;
      end;
    tsOffice2007Luna: 
      begin          
        Fill.Color := $00FFD2AF;
        Fill.ColorTo := $00FFD2AF;          

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

        ItemAppearance.FillDisabled.Color := $00F2F2F2;
        ItemAppearance.FillDisabled.ColorTo := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirror := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirrorTo := $00F2F2F2;
        ItemAppearance.FillDisabled.BorderColor := $FFD1AD;//$00B6B6B6;
        ItemAppearance.FillDisabled.GradientMirrorType := gtVertical;

        ItemAppearance.FillSelected.Color := $AAD9FF;
        ItemAppearance.FillSelected.ColorTo := $6EBBFF;
        ItemAppearance.FillSelected.ColorMirror := $42AEFE;
        ItemAppearance.FillSelected.ColorMirrorTo := $7AE1FE;
        ItemAppearance.FillSelected.BorderColor := $FFD1AD;//$42AEFE;
        ItemAppearance.FillSelected.GradientMirrorType := gtVertical;        
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

        ItemAppearance.Fillselected.Color := $AAD9FF;
        ItemAppearance.Fillselected.ColorTo := $6EBBFF;
        ItemAppearance.Fillselected.ColorMirror := $42AEFE;
        ItemAppearance.Fillselected.ColorMirrorTo := $7AE1FE;
        ItemAppearance.FillSelected.BorderColor := clBlack;//$42AEFE;          
        ItemAppearance.FillSelected.GradientMirrorType := gtVertical;               

        ItemAppearance.FillDisabled.Color := $00F2F2F2;
        ItemAppearance.FillDisabled.ColorTo := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirror := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirrorTo := $00F2F2F2;
        ItemAppearance.FillDisabled.BorderColor := clBlack;//$00B6B6B6;
        ItemAppearance.FillDisabled.GradientMirrorType := gtVertical;
    
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

        ItemAppearance.Fillselected.Color := clInActiveCaption;
        ItemAppearance.Fillselected.ColorTo := clInActiveCaption;
        ItemAppearance.Fillselected.ColorMirror := clNone;
        ItemAppearance.Fillselected.ColorMirrorTo := clNone;
        ItemAppearance.FillSelected.BorderColor := clBlack;
        ItemAppearance.FillSelected.GradientMirrorType := gtVertical;

        ItemAppearance.Fill.Color := clWhite;
        ItemAppearance.Fill.ColorTo := clBtnFace;
        ItemAppearance.Fill.ColorMirror := clNone;
        ItemAppearance.Fill.ColorMirrorTo := clNone;
        ItemAppearance.Fill.BorderColor := clBlack;
        ItemAppearance.Fill.GradientMirrorType := gtVertical;

        ItemAppearance.FillDisabled.Color := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorTo := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirror := clNone;
        ItemAppearance.FillDisabled.ColorMirrorTo := clNone;
        ItemAppearance.FillDisabled.BorderColor := clBlack;
        ItemAppearance.FillDisabled.GradientMirrorType := gtVertical;
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

        ItemAppearance.FillDisabled.Color := $00F2F2F2;
        ItemAppearance.FillDisabled.ColorTo := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirror := clNone;
        ItemAppearance.FillDisabled.ColorMirrorTo := clNone;
        ItemAppearance.FillDisabled.BorderColor := $962D00;
        ItemAppearance.FillDisabled.GradientMirrorType := gtVertical;

        ItemAppearance.FillSelected.Color := $94E6FB;
        ItemAppearance.FillSelected.ColorTo := $1595EE;
        ItemAppearance.FillSelected.ColorMirror := clNone;
        ItemAppearance.FillSelected.ColorMirrorTo := clNone;
        ItemAppearance.FillSelected.BorderColor := $962D00;
        ItemAppearance.FillSelected.GradientMirrorType := gtVertical;
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

        ItemAppearance.Fillselected.Color := $AAD9FF;
        ItemAppearance.Fillselected.ColorTo := $6EBBFF;
        ItemAppearance.Fillselected.ColorMirror := $42AEFE;
        ItemAppearance.Fillselected.ColorMirrorTo := $7AE1FE;
        ItemAppearance.FillSelected.BorderColor := clBlack;//$42AEFE;
        ItemAppearance.FillSelected.GradientMirrorType := gtVertical;

        ItemAppearance.FillDisabled.Color := $00F2F2F2;
        ItemAppearance.FillDisabled.ColorTo := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirror := $00B6B6B6;
        ItemAppearance.FillDisabled.ColorMirrorTo := $00F2F2F2;
        ItemAppearance.FillDisabled.BorderColor := clBlack;//$00B6B6B6;
        ItemAppearance.FillDisabled.GradientMirrorType := gtVertical;
      end;
  end;
end;

procedure TAdvSmoothListBox.SetControl(const Value: TControl);
begin
  if FControl <> value then
  begin
    FControl := Value;

//    FControl.Left   := InsideRect.Right;
//    FControl.Top    := Header.GetHeight;
//    FControl.Width  := Width;
//    FControl.Height := Height - Header.GetHeight - Footer.GetHeight;
//    FControl.Visible := false;

    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetDefaultItem(const Value: TAdvSmoothListBoxItem);
begin
  if FDefaultItem <> value then
  begin
    FDefaultItem.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetDetailItemImage(const Value: TAdvGDIPPicture);
begin
  if FDetailItemImage <> value then
  begin
    FDetailItemImage.Assign(value);
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetDetailSpeedFactor(const Value: integer);
begin
  if FDetailSpeedFactor <> value then
  begin
    FDetailSpeedFactor := Max(0, Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetDragAlphaBlend(const Value: Boolean);
begin
  if FDragAlphaBlend <> value then
  begin
    FDragAlphaBlend := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetDragBorderColor(const Value: TColor);
begin
  if FDragBorderColor <> value then
  begin
    FDragBorderColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetDragBorderWidth(const Value: integer);
begin
  if FDragBorderWidth <> value then
  begin
    FDragBorderWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetItemDragging(const Value: Boolean);
begin
  if FItemDragging <> value then
  begin
    FItemDragging := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetDragOpacity(const Value: Byte);
begin
  if FDragOpacity <> value then
  begin
    FDragOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetFocusColor(const Value: TColor);
begin
  if FFocusColor <> value then
  begin
    FFocusColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetFooter(
  const Value: TAdvSmoothListBoxHeaderFooter);
begin
  if FFooter <> value then
  begin
    FFooter.Assign(Value);
    HeaderFooterChanged(self);
  end;
end;

procedure TAdvSmoothListBox.SetHeader(const Value: TAdvSmoothListBoxHeaderFooter);
begin
  if FHeader <> value then
  begin
    FHeader.Assign(Value);
    HeaderFooterChanged(self);
  end;
end;

procedure TAdvSmoothListBox.SetItemAppearance(
  const Value: TAdvSmoothListBoxItemAppearance);
begin
  if FItemAppearance <> value then
  begin
    FItemAppearance.Assign(Value);
  end;
end;

procedure TAdvSmoothListBox.SetItemImage(const Value: TAdvGDIPPicture);
begin
  if FItemImage <> value then
  begin
    FItemImage.Assign(value);
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetItems(const Value: TAdvSmoothListBoxItems);
begin
  if FItems <> value then
  begin
    FItems.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetKeyBoardLookup(const Value: Boolean);
begin
  if FKeyBoardLookup <> value then
  begin
    FKeyBoardLookup := Value;
    FLookupKey := '';
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetLookUpBar(
  const Value: TAdvSmoothListBoxLookUpBar);
begin
  if FLookUpBar <> value then
  begin
    FLookUpBar.Assign(Value);
    LookupBarChanged(Self);
  end;
end;

procedure TAdvSmoothListBox.SetMultiSelect(const Value: Boolean);
begin
  if FMultiSelect <> value then
  begin
    FMultiSelect := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetProgressStyle(AStyle: TTMSStyle;
  Selected: Boolean);
begin
  with ItemAppearance.ProgressAppearance do
  begin
    case AStyle of
      tsOffice2003Blue:
      begin
        BackGroundFill.Color := $00FFD2AF;
        BackGroundFill.ColorTo := $00FFD2AF;
        BackGroundFill.BorderColor := $00C0C0C0;

        if not Selected then
        begin
          ProgressFill.Color := $FCE1CB;
          ProgressFill.ColorTo := $E0A57D;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := $962D00;
          ProgressFill.GradientMirrorType := gtVertical;
        end
        else
        begin
          ProgressFill.Color := $94E6FB;
          ProgressFill.ColorTo := $1595EE;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := $962D00;
          ProgressFill.GradientMirrorType := gtVertical;
        end;
      end;
      tsOffice2003Silver:
      begin
        BackGroundFill.Color := $00E6D8D8;
        BackGroundFill.ColorTo := $00E6D8D8;
        BackGroundFill.BorderColor := $00C0C0C0;

        if not Selected then
        begin
          ProgressFill.Color := $ECE2E1;
          ProgressFill.ColorTo := $B39698;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := $947C7C;
          ProgressFill.GradientMirrorType := gtVertical;
        end
        else
        begin
          ProgressFill.Color := $94E6FB;
          ProgressFill.ColorTo := $1595EE;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := $947C7C;
          ProgressFill.GradientMirrorType := gtVertical;
        end;
      end;
      tsOffice2003Olive:
      begin
        BackGroundFill.Color := $CFF0EA;
        BackGroundFill.ColorTo := $CFF0EA;
        BackGroundFill.BorderColor := $00C0C0C0;

        if not Selected then
        begin
          ProgressFill.Color := $CFF0EA;
          ProgressFill.ColorTo := $8CC0B1;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := $588060;
          ProgressFill.GradientMirrorType := gtVertical;
        end
        else
        begin
          ProgressFill.Color := $94E6FB;
          ProgressFill.ColorTo := $1595EE;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := $588060;
          ProgressFill.GradientMirrorType := gtVertical;
        end;
      end;
      tsOffice2003Classic:
      begin
        BackGroundFill.Color := $00F2F2F2;
        BackGroundFill.ColorTo := $00F2F2F2;
        BackGroundFill.BorderColor := $00C0C0C0;

        if not Selected then
        begin
          ProgressFill.Color := clWhite;
          ProgressFill.ColorTo := $C9D1D5;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := $808080;
          ProgressFill.GradientMirrorType := gtVertical;
        end
        else
        begin
          ProgressFill.Color := $B59285;
          ProgressFill.ColorTo := $B59285;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := $962D00;
          ProgressFill.GradientMirrorType := gtVertical;
        end;
      end;
      tsOffice2007Luna:
      begin
        BackGroundFill.Color := $00FFD2AF;
        BackGroundFill.ColorTo := $00FFD2AF;
        BackGroundFill.BorderColor := $00C0C0C0;

        if not Selected then
        begin
          ProgressFill.Color := $FFEFE3;
          ProgressFill.ColorTo := $FFDDC4;
          ProgressFill.ColorMirror := $FFD1AD;
          ProgressFill.ColorMirrorTo := $FFDBC0;
          ProgressFill.BorderColor := $FFD1AD;
          ProgressFill.GradientMirrorType := gtVertical;
        end
        else
        begin
          ProgressFill.Color := $AAD9FF;
          ProgressFill.ColorTo := $6EBBFF;
          ProgressFill.ColorMirror := $42AEFE;
          ProgressFill.ColorMirrorTo := $7AE1FE;
          ProgressFill.BorderColor := $FFD1AD;//$42AEFE;
          ProgressFill.GradientMirrorType := gtVertical;
        end;
      end;
      tsOffice2007Obsidian:
      begin
        BackGroundFill.Color := $5C534C;
        BackGroundFill.ColorTo := $5C534C;
        BackGroundFill.BorderColor := $00C0C0C0;

        if not Selected then
        begin
          ProgressFill.Color := $F9F8F8;
          ProgressFill.ColorTo := $E4E2DF;
          ProgressFill.ColorMirror := $D1CBC7;
          ProgressFill.ColorMirrorTo := $E2DEDB;
          ProgressFill.BorderColor := clBlack;//$D1CBC7;
          ProgressFill.GradientMirrorType := gtVertical;
        end
        else
        begin
          ProgressFill.Color := $AAD9FF;
          ProgressFill.ColorTo := $6EBBFF;
          ProgressFill.ColorMirror := $42AEFE;
          ProgressFill.ColorMirrorTo := $7AE1FE;
          ProgressFill.BorderColor := clBlack;//$42AEFE;
          ProgressFill.GradientMirrorType := gtVertical;
        end;
      end;
      tsWindowsXP:
      begin
        BackGroundFill.Color := $00B6B6B6;
        BackGroundFill.ColorTo := $00B6B6B6;
        BackGroundFill.BorderColor := $00C0C0C0;

        if not Selected then
        begin
          ProgressFill.Color := clWhite;
          ProgressFill.ColorTo := clBtnFace;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := clBlack;
          ProgressFill.GradientMirrorType := gtVertical;
        end
        else
        begin
          ProgressFill.Color := clInActiveCaption;
          ProgressFill.ColorTo := clInActiveCaption;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := clBlack;
          ProgressFill.GradientMirrorType := gtVertical;
        end;
      end;
      tsWhidbey:
      begin
        BackGroundFill.Color := $F5F9FA;
        BackGroundFill.ColorTo := $F5F9FA;
        BackGroundFill.BorderColor := $00C0C0C0;

        if not Selected then
        begin
          ProgressFill.Color := $F5F9FA;
          ProgressFill.ColorTo := $A8C0C0;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := $962D00;
          ProgressFill.GradientMirrorType := gtVertical;
        end
        else
        begin
          ProgressFill.Color := $94E6FB;
          ProgressFill.ColorTo := $1595EE;
          ProgressFill.ColorMirror := clNone;
          ProgressFill.ColorMirrorTo := clNone;
          ProgressFill.BorderColor := $962D00;
          ProgressFill.GradientMirrorType := gtVertical;
        end;
      end;
      tsCustom: ;
      tsOffice2007Silver:
      begin
        BackGroundFill.Color := $00CAC1BA;
        BackGroundFill.ColorTo := $00CAC1BA;
        BackGroundFill.BorderColor := $00C0C0C0;

        if not Selected then
        begin
          ProgressFill.Color := $FAEEEB;
          ProgressFill.ColorTo := $E5DBD7;
          ProgressFill.ColorMirror := $E2D8D4;
          ProgressFill.ColorMirrorTo := $D1C7C5;
          ProgressFill.BorderColor := clBlack;//$E2D8D4;
          ProgressFill.GradientMirrorType := gtVertical;
        end
        else
        begin
          ProgressFill.Color := $AAD9FF;
          ProgressFill.ColorTo := $6EBBFF;
          ProgressFill.ColorMirror := $42AEFE;
          ProgressFill.ColorMirrorTo := $7AE1FE;
          ProgressFill.BorderColor := clBlack;//$42AEFE;
          ProgressFill.GradientMirrorType := gtVertical;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothListBox.SetScrollIndicator(
  const Value: TAdvSmoothListBoxIndicator);
begin
  if FScrollIndicator <> value then
  begin
    FScrollIndicator.Assign(Value);
    ScrollIndicatorChanged(Self);
  end;
end;

procedure TAdvSmoothListBox.SetSections(const Value: TAdvSmoothListBoxSections);
begin
  if FSections <> value then
  begin
    FSections.Assign(Value);
    SectionsChanged(Self);
  end;
end;

procedure TAdvSmoothListBox.SetSelectedItemIndex(const Value: integer);
var
  prev: integer;
begin
  if (Value >= 0) and (Value <= Items.Count - 1) then
  begin
    if value <> FSelectedItemIndex then
    begin
      prev := FSelectedItemIndex;
      Items.SelectedItem := Items[Value];
      if Assigned(FOnItemSelectionChanged) then
        FOnItemSelectionChanged(Self, prev, Value);
    end;
  end
  else if (Value = -1) then
  begin
    FSelectedItemIndex := Value;
    Items.SelectedItem := nil;
  end;
end;

procedure TAdvSmoothListBox.SetSelectionMode(
  const Value: TAdvSmoothListBoxSelectionMode);
begin
  if FSelectionMode <> value then
  begin
    FSelectionMode := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetShowDetailClick(
  const Value: TAdvSmoothListBoxShowDetailClick);
begin
  if FShowDetailClick <> value then
  begin
    FShowDetailClick := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetShowDetailKey(
  const Value: TAdvSmoothListBoxShowDetailKey);
begin
  if FShowDetailKey <> value then
  begin
    FShowDetailKey := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetShowFocus(const Value: Boolean);
begin
  if FShowFocus <> value then
  begin
    FShowFocus := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetSorted(const Value: Boolean);
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

procedure TAdvSmoothListBox.SetSpeedFactor(const Value: integer);
begin
  if FSpeedFactor <> Value then
  begin
    FSpeedFactor := Max(1, Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBox.SetSplitterHeight(const Value: integer);
begin
  if FSplitterHeight <> value then
  begin
    FSplitterHeight := Value;
    InitDisplayList;
    Changed;
  end;
end;

procedure TAdvSmoothListBox.ShowDetails(itemindex: integer = -1; const bypasstimer: Boolean = false);
var
  op,
  p: TWinControl;
  t: Integer;
  r: TRect;
  ditem: TAdvSmoothListBoxItem;
begin
  if (itemindex = -1) then
    Ditem := Items.SelectedItem
  else if (itemindex >= 0) and (itemindex <= Items.Count - 1) then
    DItem := Items[itemindex]
  else
    Exit;

  if DItem <> nil then
  begin
    if Assigned(DItem.DetailControl) then
      FCurrentControl := DItem.DetailControl
    else if Assigned(DetailControl) then
      FCurrentControl := DetailControl
    else
      Exit;
  end
  else if Assigned(DetailControl) then
    FCurrentControl := DetailControl
  else
    Exit;

  if DItem <> nil then
  begin
    FDetailIndex := DItem.Index;
    FDetailShow := true;
    FDetailStatus := dsDetailsVisible;

    if FCurrentControl.Parent <> self then
    begin
      FCurrentControl.Width := 0;
      FCurrentControl.Height := 0;
      FCurrentControl.Visible := false;
      FCurrentControl.Parent := self;
    end;


    FCurrentControl.Left := InsideRect.Right;

    if FAnimateBitmap = nil then
    begin
      FAnimateBitmap := TBitmap.Create;
      r := Rect(InsideRect.Left, Header.GetHeight, InsideRect.Right, InsideRect.Bottom - Footer.GetHeight - Header.GetHeight);
      FAnimateBitmap.Width := r.Right;
      FAnimateBitmap.Height := r.Bottom;
      FBypassBitBlt:= True;
      try
        if Visible then
        begin
          Paint;
          BitBlt(FAnimateBitmap.Canvas.Handle,0,0,r.Right, r.Bottom, Self.Canvas.Handle, r.Left, r.Top, SRCCopy)
        end
        else
        begin
            op:= Parent;

            p:= Parent;
            while Assigned(p) and not (p is TForm) do
              p:= p.Parent;

            if Assigned(p) then
              Parent:= p;

            Show;
            Invalidate;
            Paint;
            BitBlt(FAnimateBitmap.Canvas.Handle,0,0,r.Right, r.Bottom, Self.Canvas.Handle, r.Left, r.Top, SRCCopy);
            Hide;
            if Parent<>op then
              Parent:= op;
        end;
      finally
        FBypassBitBlt:= False;
      end;

    end;

    DoShowDetail(self, FDetailIndex);

    if bypasstimer then
    begin
      t:= SpeedFactor;
      SpeedFactor:= 1;
      AnimateSmoothPos(FSmoothTimer);
      SpeedFactor:= t;
    end;
  end;
end;

procedure TAdvSmoothListBox.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.Result := 0;
end;

procedure TAdvSmoothListBox.WMPaint(var Message: TWMPaint);
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

procedure TAdvSmoothListBox.AddDisplayItem(Item: TAdvSmoothListBoxItem; var prevrect: TRect; height, lookup: integer);
var
  hs, vs, left, right, h: integer;
begin
  if Item.Visible
   then
  begin
    left := 0;
    right := 0;
    case LookupBar.Position of
      pLeft: left := lookup;
      pright: right := lookup;
    end;

    if Item.Splitter then
      h := SplitterHeight
    else
      h := ItemAppearance.Height;

    hs := ItemAppearance.HorizontalSpacing;
    vs := ItemAppearance.VerticalSpacing;

    with FDisplayList.AddItem do
    begin
      Kind := ikItem;
      ItemRect := Rect(InsideRect.Left + left + hs + Item.Indent, prevrect.Bottom + vs, InsideRect.Right {- InsideRect.Left} - right - GetShadowOffset - hs, prevrect.Bottom + vs + h);
      DisplayItem := Item;
      prevrect := ItemRect;
      prevrect.Bottom := prevrect.Bottom;
    end;
  end;
end;

procedure TAdvSmoothListBox.AddDisplaySection(Item: TAdvSmoothListBoxItem; var prevrect: TRect; height, lookup: integer);
var
  left, right: integer;
  cat: TAdvSmoothListBoxCategoryItem;
begin
  if Item.Visible then
  begin
    left := 0;
    right := 0;
    case LookupBar.Position of
      pLeft: left := lookup;
      pright: right := lookup;
    end;

    with FDisplayList.AddItem do
    begin
      Kind := ikSection;
      ItemRect := Rect(InsideRect.Left + left, prevrect.Bottom, InsideRect.Right {- InsideRect.Left} - right - GetShadowOffset, prevrect.Bottom + height);
      prevrect := ItemRect;

      case CategoryType of
        alphanumeric:
        begin
          if Length(Item.Caption) > 0 then
            SectionCaption := Item.Caption[1]
          else
            SectionCaption := '';
        end;
        custom:
        begin
          if (Item.CategoryID <> -1) and (Item.CategoryID < Categories.Count) then
          begin
            cat := Categories[Categories.ItemIndexByID(Item.CategoryID)];
            SectionCaption := cat.Text;
            SectionCategoryID := Item.CategoryID;
          end
          else
          begin
            SectionCaption := '';
            SectionCategoryID := -1;
          end;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothListBox.AnimateSmoothPos(Sender: TObject);
var
  c: TCanvas;
  d, opc: Double;
  posto, opcto, lto, l: integer;
begin
  if (csDesigning in ComponentState) then
    Exit;

  if FAnimate and (GetFullHeight >= 0) then
  begin
    posTo := GetPositionTo;
    d := Abs(posto - GetPosition) / Max(1, Abs(FSp) * FSpeedFactor);
    FAnimating := AnimateDouble(FCurrentScPos, posto, d, 1);
    if not FAnimating then
    begin
      opcto := 0;
      opc := Abs(ScrollIndicator.FAnimateOpacity) / FSpeedFactor;
      FAnimatingScroll := AnimateDouble(ScrollIndicator.FAnimateOpacity, opcto, opc, 1);
      if FAnimatingScroll then
        Changed;
    end
    else
    begin
      ScrollIndicator.FAnimateOpacity := ScrollIndicator.Opacity;
      DoScroll(self, GetPosition, GetPositionTo);
      Changed;
    end;
  end
  else
  begin
    opcto := 0;
    opc := Abs(ScrollIndicator.FAnimateOpacity) / Max(1, fsp);
    FAnimatingScroll := AnimateDouble(ScrollIndicator.FAnimateOpacity, opcto, opc, 1);
    if FAnimatingScroll then
      Changed;
  end;

  if FDetailShow then
    lto := 0
  else
    lto := InsideRect.Right;

  if Assigned(FCurrentControl) then
  begin
    l := FCurrentControl.Left;
    if FDetailSpeedFactor = 0 then
      d := Abs(l - lto) / 1
    else
      d := Abs(l - lto) / FDetailSpeedFactor;

    FAnimatingdetail := AnimateDouble(l, lto, d, 1);
    if FAnimatingdetail then
    begin
      FCurrentControl.Visible := true;
      FCurrentControl.Left := l;
      FCurrentControl.Top := Header.GetHeight;
      FCurrentControl.Width := Width;
      FCurrentControl.Height := Height - Header.GetHeight - Footer.GetHeight;

      c:= inherited Canvas;
      if lto = 0 then
        c.Draw(FCurrentControl.Left - InsideRect.Right, FCurrentControl.Top, FAnimateBitmap)
      else
        c.Draw(-InsideRect.Right + FCurrentControl.Left, FCurrentControl.Top, FAnimateBitmap)
    end
    else
    begin

      if FDetailStatus = dsDetailsNotVisible then
      begin
        if FAnimateBitmap <> nil then
        begin
          FCurrentControl.Visible := false;
          FAnimateBitmap.Free;
          FAnimateBitmap := nil;
          Changed;
        end;
      end;
    end;
  end;

  Inc(FTimerCount);
  if FTimerCount >= 100 then
  begin
    FLookUp := false;
    FLookupKey := '';
    FTimerCount := 0;
  end;
end;

procedure TAdvSmoothListBox.AppearanceChanged(Sender: TObject);
begin
  InitDisplayList;
  Changed;
end;

procedure TAdvSmoothListBox.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothListBox then
  begin
    FFill.Assign((Source as TAdvSmoothListBox).Fill);
    FItems.Assign((Source as TAdvSmoothListBox).Items);
    FItemAppearance.Assign((Source as TAdvSmoothListBox).ItemAppearance);
    FScrollIndicator.Assign((Source as TAdvSmoothListBox).ScrollIndicator);
    FLookupBar.Assign((Source as TAdvSmoothListBox).LookupBar);
    FSpeedFactor := (Source as TAdvSmoothListBox).SpeedFactor;
    FDetailSpeedFactor := (Source as TAdvSmoothListBox).DetailSpeedFactor;
    FSorted := (Source as TAdvSmoothListBox).Sorted;
    FSections.Assign((Source as TAdvSmoothListBox).Sections);
    FHeader.Assign((Source as TAdvSmoothListBox).Header);
    FFooter.Assign((Source as TAdvSmoothListBox).Footer);
    FKeyBoardLookup := (Source as TAdvSmoothListBox).KeyBoardLookup;
    FSplitterHeight := (Source as TAdvSmoothListBox).SplitterHeight;
    FShowDetailClick := (Source as TAdvSmoothListBox).ShowDetailClick;
    FShowDetailKey := (Source as TAdvSmoothListBox).ShowDetailKey;
    FShowFocus := (Source as TAdvSmoothListBox).ShowFocus;
    FFocusColor := (Source as TAdvSmoothListBox).FocusColor;
    FItemImage.Assign((Source as TAdvSmoothListBox).ItemImage);
    FDetailItemImage.Assign((Source as TAdvSmoothListBox).DetailItemImage);
    FSelectionMode := (Source as TAdvSmoothListBox).SelectionMode;
    FDragAlphaBlend := (Source as TAdvSmoothListBox).DragAlphaBlend;
    FDragOpacity := (Source as TAdvSmoothListBox).DragOpacity;
    FDragBorderWidth := (Source as TAdvSmoothListBox).DragBorderWidth;
    FDragBorderColor := (Source as TAdvSmoothListBox).DragBorderColor;
    FItemDragging := (Source as TAdvSmoothListBox).ItemDragging;
    FMultiSelect := (Source as TAdvSmoothListBox).MultiSelect;
    FCategoryType := (Source as TAdvSmoothListBox).CategoryType;
    FCategories.Assign((Source as TAdvSmoothListBox).Categories);
    FDefaultItem.Assign((Source as TAdvSmoothListBox).DefaultItem);
    Changed;
  end;
end;

procedure TAdvSmoothListBox.CategoriesChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothListBox.Changed;
begin
  Invalidate;
end;

function TAdvSmoothListBox.CheckSelection(X, Y: integer): Boolean;
var
  itemindex: integer;
  right, left: Boolean;
begin
  result := false;
  itemindex := ItemAtXY(X, Y);
  if (itemindex >= 0) and (itemindex <= Items.Count - 1) then
  begin
    with Items[itemindex] do
    begin
      right := ((GraphicRightType <> gtNone) and PtInRect(fgrRight, Point(X, Y)));
      left := ((GraphicLeftType <> gtNone) and PtInRect(fgrLeft, Point(X, Y)));
      result := not right and not left;
    end;
  end;
end;

procedure TAdvSmoothListBox.Click;
begin
  inherited;
  SetFocus;
end;

procedure TAdvSmoothListBox.CMHintShow(var Message: TMessage);
var
  pt: TPoint;
  item: integer;
  ditem: TAdvSmoothListBoxItem;
begin
  with TCMHintShow(Message).HintInfo^ do
  begin
    HintStr := self.Hint;
    pt := CursorPos;
    item := YToItem(pt.X, pt.Y);
    if item <> -1 then
    begin
      dItem := FDisplayList.GetItem(item).DisplayItem;
      if dItem <> nil then
      begin
        if dItem.Hint <> '' then
          HintStr := ditem.Hint;
        if Assigned(FOnItemHint) then
          FOnItemHint(Self, item, HintStr);
      end;
    end;

    ReshowTimeout := 0;
  end;
end;

procedure TAdvSmoothListBox.CMMouseLeave(var Message: TMessage);
begin
  if (FHoveredItemIndex >= 0) and (FHoveredItemIndex <= Items.Count - 1) then
  begin
    with Items[FhoveredItemIndex] do
    begin
      if not FMouseLeft then
      begin
        if Assigned(FOnItemMouseLeave) then
          FOnItemMouseLeave(Self, FhoveredItemIndex);

        FMouseEntered := false;
        FMouseLeft := true;
      end
    end;
  end;
  FPrevHoveredItemIndex := -1;
  FHoveredItemIndex := -1;
  Application.CancelHint;
end;

constructor TAdvSmoothListBox.Create(AOwner: TComponent);
var
  i: integer;
begin
  FConstructed := false;
  inherited Create(AOwner);
  FDragItemForm := nil;
  FMode := dmRelease;
  FTimerCount := 0;
  FFocusColor := clBlack;
  FShowFocus := true;
  ControlStyle := ControlStyle + [csAcceptsControls];  
  FSelectedItemIndex := -1;
  FShowDetailKey := dkSpace;
  FShowDetailClick := sdOnClick;
  FKeyBoardLookup := false;
  FDisplayList := TAdvSmoothListBoxDisplayList.Create;
  FSorted := false;
  FSpeedFactor := 4;
  FDetailSpeedFactor := 4;
  FCurrentScPos := 0;
  FScPosTo := 0;
  DoubleBuffered := true;
  FItems := TAdvSmoothListBoxItems.Create(Self);
  FItems.OnChange := ItemsChanged;
  FFill := TGDIPFill.Create;
  FFill.OnChange := AppearanceChanged;
  FItemAppearance := TAdvSmoothListBoxItemAppearance.Create(Self);
  FItemAppearance.OnChange := ItemAppearanceChanged;
  FLookUpBar := TAdvSmoothListBoxLookUpBar.Create(Self);
  FLookUpBar.OnChange := LookupBarChanged;
  FSections := TAdvSmoothListBoxSections.Create(Self);
  FSections.OnChange := SectionsChanged;
  FHeader := TAdvSmoothListBoxHeaderFooter.Create(Self);
  FHeader.OnChange := HeaderFooterChanged;
  FScrollIndicator := TAdvSmoothListBoxIndicator.Create(Self);
  FScrollIndicator.OnChange := ScrollIndicatorChanged;
  FFooter := TAdvSmoothListBoxHeaderFooter.Create(Self);
  FFooter.OnChange := HeaderFooterChanged;
  Width := 250;
  Height := 350;
  FItemDragging := true;
  FMultiSelect := false;
  FCategories := TAdvSmoothListBoxCategoryItems.Create(Self);
  FCategories.OnChange := CategoriesChanged;
  FCategoryType := alphanumeric;
  FSmoothTimer :=  TTimer.Create(self);
  FSmoothTimer.Interval := 1;
  FSmoothTimer.Enabled := not (csDesigning in ComponentState);
  FSmoothTimer.OnTimer := AnimateSmoothPos;

  FDragTimer :=  TTimer.Create(self);
  FDragTimer.Interval := 1;
  FDragTimer.Enabled := false;
  FDragTimer.OnTimer := DragSmoothPos;

  FAnimate := true;
  FDetailShow := false;
  FDetailStatus := dsDetailsNotVisible;
  FSplitterHeight := 20;
  FhoveredItemIndex := -1;
  FPrevHoveredItemIndex := -1;
  FSelectionMode := sAutoDeselect;
  FDragAlphaBlend := true;
  FDragOpacity := 200;
  FDragBorderWidth := 1;
  FDragBorderColor := clBlack;

  FItemImage := TAdvGDIPPicture.Create;
  FItemImage.OnChange := ItemAppearanceChanged;

  FDetailItemImage := TAdvGDIPPicture.Create;
  FDetailItemImage.OnChange := ItemAppearanceChanged;

  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  FDefaultItems := TAdvSmoothListBoxItems.Create(Self);
  FDefaultItems.BeginUpdate;
  FDefaultItem := FDefaultItems.Add;

  // app is linked with COMCTL32 v6 or higher -> xp themes enabled
  i := GetFileVersion('COMCTL32.DLL');
  i := (i shr 16) and $FF;

  FIsWinXP := (i > 5);
end;

procedure TAdvSmoothListBox.CreateParams(var params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TAdvSmoothListBox.CreateWnd;
begin
  inherited;
  FDefaultItems.EndUpdate;
  if FConstructed then
    Exit;
  if FDesignTime then
  begin
    InitPreview;
    SetComponentStyle(tsOffice2007Luna);
  end;
  FConstructed := true;
end;

procedure TAdvSmoothListBox.DblClick;
var
  item: integer;
  sdOnImg: Boolean;
begin
  inherited;
  FMouseUp := false;
  FMouseDown := false;
  if FDisplayList.Count > 0 then
  begin
    item := YToItem(FClickX, FClickY);

    sdOnImg := false;
    case ShowDetailClick of
      sdOnDblClick: ShowDetails;
      sdOnDetailImageDblClick: sdOnImg := true;
    end;

    if (FSelectedItemIndex <> -1) then
    begin
      with Items[FSelectedItemIndex] do
      begin
        if (PtInRect(fgrLeft, Point(FClickX, FClickY))) then
        begin
          case GraphicLeftType of
            gtDetailImage, gtCommonDetailImage:
            begin
              if sdOnImg then
                ShowDetails;
            end;
          end;
        end;

        if (PtInRect(fgrRight, Point(FClickX, FClickY))) then
        begin
          case GraphicRightType of
            gtDetailImage, gtCommonDetailImage:
            begin
              if sdOnImg then
                ShowDetails;
            end;
          end;
        end;
      end;
      if item <> -1 then
        DoItemDblClick(self, FDisplayList.GetItem(item).DisplayItem.Index);
    end;
  end;
end;

destructor TAdvSmoothListBox.Destroy;
begin
  if FAnimateBitmap <> nil then
    FAnimateBitmap.Free;

  FCategories.free;
  FItemImage.Free;
  FDetailItemImage.Free;
  FDefaultItem.Free;
  FDefaultItem := nil;
  FDefaultItems.Free;
  FSmoothTimer.Free;
  FDragTimer.Free;
  FLookUpBar.Free;
  FItemAppearance.Free;
  FFill.Free;
  FSections.Free;
  Header.Free;
  Footer.Free;
  FScrollIndicator.Free;
  FDisplayList.Free;
  FItems.Free;
  inherited;
end;

procedure TAdvSmoothListBox.DoAnchorClick(Sender: TObject; Anchor: String);
begin
  FAnimate := false;
  FMouseUp := false;
  FMouseDown := false;
  if Assigned(FOnAnchorClick) then
    FOnAnchorClick(Sender, Anchor);
end;

procedure TAdvSmoothListBox.DoEnter;
begin
  inherited;
  FFocused := true;
  Changed;
end;

procedure TAdvSmoothListBox.DoExit;
begin
  inherited;
  FhoveredItemIndex := -1;
  FPrevHoveredItemIndex := -1;
  Application.CancelHint;
  FFocused := false;
  Changed;  
end;

procedure TAdvSmoothListBox.DoHideDetail(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(FOnHideDetail) then
    FOnHideDetail(Sender, itemindex);
end;

procedure TAdvSmoothListBox.DoItemAnchorClick(Sender: TObject; Anchor: String;
  ItemIndex: integer);
begin
  FAnimate := false;
  FMouseUp := false;
  FMouseDown := false;
  if Assigned(FOnItemAnchorClick) then
    FOnItemAnchorClick(Sender, Anchor, ItemIndex);
end;

procedure TAdvSmoothListBox.DoItemBkgDraw(Sender: TObject; Canvas: TCanvas;
  itemindex: integer; itemrect: TRect; var defaultdraw: boolean);
begin
  if Assigned(FOnItemBkgDraw) then
    FOnItemBkgDraw(Sender, Canvas, itemindex, itemrect, defaultdraw);
end;

procedure TAdvSmoothListBox.DoItemButtonClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(FOnItemButtonClick) then
    FOnItemButtonClick(Sender, itemindex);
end;

procedure TAdvSmoothListBox.DoItemCaptionClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(FOnItemCaptionClick) then
    FOnItemCaptionClick(Sender, itemindex);
end;

procedure TAdvSmoothListBox.DoItemCheckClick(Sender: TObject;
  itemindex: integer; checked: Boolean);
begin
  if Assigned(FOnItemCheckClick) then
    FOnItemCheckClick(Sender, itemindex, checked);
end;

procedure TAdvSmoothListBox.DoItemClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(FOnItemClick) then
    FOnItemClick(Sender, itemindex);
end;

procedure TAdvSmoothListBox.DoItemDblClick(Sender: TObject; itemindex: integer);
begin
  if Assigned(FOnItemDblClick) then
    FOnItemDblClick(Sender, itemindex);
end;

procedure TAdvSmoothListBox.DoItemDraw(Sender: TObject; Canvas: TCanvas;
  itemindex: integer; itemrect: TRect; var defaultdraw: boolean);
begin
  if Assigned(FOnItemDraw) then
    FOnItemDraw(Sender, Canvas, itemindex, itemrect, defaultdraw);
end;

procedure TAdvSmoothListBox.DoItemImageClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(FOnItemImageClick) then
    FOnItemImageClick(Sender, itemindex);
end;

procedure TAdvSmoothListBox.DoItemInfoClick(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(FOnItemInfoClick) then
    FOnItemInfoClick(Sender, itemindex);
end;

procedure TAdvSmoothListBox.DoItemRadioClick(Sender: TObject;
  itemindex: integer; checked: Boolean);
begin
  if Assigned(FOnItemRadioClick) then
    FOnItemRadioClick(Sender, itemindex, checked);
end;

procedure TAdvSmoothListBox.DoItemText(Sender: TObject; itemindex: integer;
  var itemcaption, iteminfo, itemnotes: String);
begin
  if Assigned(FOnItemText) then
    FOnItemText(Sender, itemindex, itemcaption, iteminfo, itemnotes);
end;

procedure TAdvSmoothListBox.DoScroll(Sender: TObject; CurrentPosition,
  EndPosition: Double);
begin
  if Assigned(FOnScroll) then
    FOnScroll(Sender, CurrentPosition, EndPosition);
end;

procedure TAdvSmoothListBox.DoShowDetail(Sender: TObject;
  itemindex: integer);
begin
  if Assigned(FOnShowDetail) then
    FOnShowDetail(Sender, itemindex);
end;

procedure TAdvSmoothListBox.DragSmoothPos(Sender: TObject);
begin
  FScPosTo := Min(GetFullHeight, Max(FScPosTo + FDragAnimateDelta, 0));
  FCurrentScPos := FScPosTo;
  Changed;
end;

procedure TAdvSmoothListBox.DrawBackground;
var
  rc: TRect;
  g: TGPGraphics;
begin
  if not Assigned(Fill) then
    Exit;

  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  rc := ClientRect;
  if (Fill.BorderWidth <> 0) and (Fill.BorderColor <> clNone) then
    fill.Fill(g, MakeRect(rc.Left, rc.Top, rc.Right - rc.Left - 1, rc.Bottom - rc.Top - 1))
  else
    fill.Fill(g, MakeRect(rc.Left, rc.Top, rc.Right - rc.Left, rc.Bottom - rc.Top));

  g.Free;
end;

procedure TAdvSmoothListBox.DrawHeaderFooter(Part: TAdvSmoothListBoxHeaderFooter; Header: Boolean);
var
  rc: TRect;
  x, y: integer;
  g: TGPGraphics;
  fillr: TGPRectF;
  htmlr: TRect;
  a, s, k: String;
  l, m, XSize, YSize: integer;
  hr: TRect;
begin
  if not Assigned(Part) then
    Exit;

  with Part do
  begin
    if Visible then
    begin
      g := TGPGraphics.Create(Canvas.Handle);
      g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
      
      rc := InsideRect;

      if header then
        fillr := fill.Fill(g, MakeRect(rc.Left, rc.Top, rc.Right - rc.Left - GetShadowOffset, Height))
      else
        fillr := fill.Fill(g, MakeRect(rc.Left, rc.Bottom - Height - GetShadowOffset, rc.Right - rc.Left - GetShadowOffset, Height));

      if Caption <> '' then
      begin
        htmlr := Rect(0, 0, 10000, 10000);

        HTMLDrawGDIP(g, FFont, Caption,htmlr,FImages, 0,0,-1,-1,CaptionShadowOffset,False,true,false,false,
          False,False,true,1.0,CaptionURLColor,clNone,clNone,CaptionShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

        if CaptionLocation <> cpCustom then
          GetCaptionPosition(x, y, fillr, XSize, YSize, CaptionLocation)
        else
        begin
          x := CaptionLeft;
          y := CaptionTop;
        end;

        htmlr := Bounds(Round(fillr.X + x), Round(fillr.Y + y), xsize, ysize);

        HTMLDrawGDIP(g, FFont, Caption,htmlr,FImages, 0,0,-1,-1,CaptionShadowOffset,False,false,false,false,
          False,False,true,1.0,CaptionURLColor,clNone,clNone,CaptionShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

      end;
      g.Free;
    end;
  end;
end;

procedure TAdvSmoothListBox.DrawItems;
var
  i: Integer;
  r: TRect;
  top: integer;
  bottom: integer;
  j, pos, diff: integer;
  nextfloatitem, floatitem: TAdvSmoothListBoxDisplayListItem;
  draws: Boolean;
begin
  top := GetTopIndex;
  bottom := GetBottomIndex;

  floatitem := nil;
  for i := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      Floating := false;
      case Kind of
        ikItem:
        begin
          if DisplayItem <> nil then
          begin
            if (I >= top) and (I <= bottom) and not (DisplayItem.Splitter) then
              DisplayItem.Draw(Canvas, ItemRect, i);

            j := i;

            while((j > 0) and (FDisplayList.GetItem(j).Kind = ikItem)) do
            begin
              Dec(j);
            end;

            with FDisplayList.GetItem(j) do
            begin
              Floating := ItemRect.Top <= GetPosition + Header.GetHeight;
              if Floating then
              begin
                if floatitem <> nil then
                begin
                  if floatitem <> FDisplayList.GetItem(j) then
                    floatitem := FDisplayList.GetItem(j);
                end
                else
                  floatitem := FDisplayList.GetItem(j);
              end;
            end;
          end;
        end;
      end;
    end;
  end;

  nextfloatitem := nil;

  for i := 0 to FDisplayList.Count - 1 do
  begin
    with FDisplayList.GetItem(i) do
    begin
      case Kind of
        ikSection:
        begin
          draws := true;
          if floatitem <> nil then
          begin
            draws := floatitem <> FDisplayList.GetItem(i);
            if not draws then
            begin
              j := i + 1;
              while((j < FDisplayList.Count) and (FDisplayList.GetItem(j).Kind = ikItem)) do
              begin
                Inc(j);
              end;
              if j < FDisplayList.Count then
                nextfloatitem := FDisplayList.GetItem(j);
            end;
          end;

          if draws then
          begin
            r := ItemRect;
            DrawSection(r, SectionCaption, SectionCategoryID);
          end;
        end;
      end;
    end;
  end;

  if (floatitem <> nil) then
  begin
    with floatitem do
    begin
      r := ItemRect;
      diff := floatitem.ItemRect.Bottom - floatitem.ItemRect.Top;
      
      pos := GetPosition + Header.GetHeight;

      if (nextfloatitem <> nil) then
        if nextfloatitem.ItemRect.Top - GetPosition <= diff + Header.GetHeight then
          pos := nextfloatitem.ItemRect.top - diff;

      DrawSection(Bounds(r.Left, pos, r.Right, r.Bottom - r.Top), SectionCaption, SectionCategoryID);
    end;
  end
end;

procedure TAdvSmoothListBox.DrawLookUpBar;
var
  ch: Char;
  customch: String;
  I: integer;
  f, fd: TGPFont;
  sf: TGPStringFormat;
  p: TGDIPFillParameters;
  pt: TGPPointF;
  ximg, x, y: Single;
  b: TGPBrush;
  tw, th: integer;
  stop: integer;
  pos: integer;
  g: TGPGraphics;
  rf: TGPRectF;
  ca: TCanvas;
  maxtextw: integer;
begin
  if not Assigned(LookupBar) then
    Exit;

  with LookupBar do
  begin
    if FVisible then
    begin
      ca := TCanvas.Create;
      ca.Handle := Canvas.Handle;
      ca.Font.Assign(Font);
      tw := 0;
      maxtextw := GetMaximumCustomTextWidth(ca);
      case CategoryType of
        alphanumeric: tw := ca.TextWidth('W') + 4;
        custom: tw := maxtextw;
      end;

      g := TGPGraphics.Create(ca.Handle);
      g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

      p.Graphics := g;
      p.Path := nil;
      p.Fillpath := false;
      case Position of
        pRight: rf := MakeRect(InsideRect.Right - tw - GetShadowOffset, InsideRect.Top + Header.GetHeight, tw, InsideRect.Bottom - Footer.GetHeight - 1 - GetShadowOffset);
        pLeft: rf := MakeRect(InsideRect.Left, InsideRect.Top + Header.GetHeight, InsideRect.Left + tw, InsideRect.Bottom - Footer.GetHeight - 1 - GetShadowOffset);
      end;

      p.R := rf;
      p.GT := FGradientType;
      p.Image := nil;
      p.HatchStyle := FHatchStyle;
      p.ColorFrom := FColor;
      p.ColorTo := FColorTo;
      p.OpacityFrom := FOpacity;
      p.OpacityTo := FOpacityTo;
      p.Angle := 0;
      p.BorderColor := clNone;
      p.BorderWidth := 0;
      p.BorderStyle := DashStyleSolid;

      FillGDIP(p);

      if Rotated then
        sf := TGPStringFormat.Create(StringFormatFlagsDirectionVertical)
      else
        sf := TGPStringFormat.Create;

      f := g.MakeFont(Font);
      fd := g.MakeFont(DisabledFont);

      y := 0;
      if not AutoSize then
         y := InsideRect.Top + Header.GetHeight;

      case CategoryType of
        alphanumeric:
        begin
          if Numeric then
            stop := 37
          else
            stop := 27;

          for I := 1 to stop - 1 do
          begin

            if I < 27 then
              ch := chr(ord('A') + (i - 1))
            else
              ch := chr(ord('0') + (i - 27));

            if Rotated then
            begin
              th := ca.TextWidth('W');
              tw := ca.TextHeight('gh');
            end
            else
            begin
              tw := ca.TextWidth('W');
              th := ca.TextHeight('gh');
            end;

            x := 0;
            case Position of
              pLeft: x := InsideRect.Left;
              pRight: x := InsideRect.Right - GetShadowOffset - (tw + 2);
            end;

            if AutoSize then
            begin
              pos := InsideRect.Top + Header.GetHeight;
              y := pos + Round(((InsideRect.Bottom - pos - GetShadowOffset - Footer.GetHeight) / (stop - 1)) * (I - 1));
            end;

            pt := MakePoint(x, y);

            if FChar[I] then
            begin
              b := TGPSolidBrush.Create(ColorToARGB(Font.Color));
              g.DrawString(ch, length(ch), f, pt, sf, b);
              b.Free;
            end
            else
            begin
              b := TGPSolidBrush.Create(ColorToARGB(DisabledFont.Color));
              g.DrawString(ch, length(ch), fd, pt, sf, b);
              b.Free;
            end;

            if not AutoSize then
              y := y + th + LookupBar.Spacing
          end;
        end;
        custom:
        begin
          stop := Categories.Count;

          for I := 0 to stop - 1 do
          begin
            with Categories[I] do
            begin
              if LookupText <> '' then
                customch := LookupText
              else
                customch := Text;

              if Rotated then
              begin
                th := ca.TextWidth(customch);
                tw := ca.TextHeight(customch);
              end
              else
              begin
                tw := ca.TextWidth(customch);
                th := ca.TextHeight(customch);
              end;

              x := 0;
              ximg := 0;
              case Position of
                pLeft:
                begin
                  x := InsideRect.Left + (maxtextw - 4 - tw) div 2;
                  ximg := InsideRect.left;
                  if Assigned(FImages) and Rotated then
                    if (FImageIndex > -1) and (FImageIndex < FImages.Count) then
                      ximg := InsideRect.Left + (maxtextw - 4 - FImages.Width) div 2;
                end;
                pRight:
                begin
                  x := InsideRect.Right - 1 - GetShadowOffset - (maxtextw + 4 + tw) div 2;                
                  ximg := InsideRect.Right - 1 - maxtextw;
                  if Assigned(FImages) and Rotated then
                    if (FImageIndex > -1) and (FImageIndex < FImages.Count) then
                      ximg := InsideRect.Right - 1 - GetShadowOffset - (maxtextw + 4 + FImages.Width) div 2;
                end;
              end;

              if Assigned(FImages) and not Rotated then
                if (FImageIndex > -1) and (FImageIndex < FImages.Count) then
                  x := x + Images.Width div 2;

              if AutoSize then
              begin
                pos := InsideRect.Top + Header.GetHeight;
                y := pos + Round(((InsideRect.Bottom - pos - GetShadowOffset - Footer.GetHeight) / stop) * I);
              end;

              pt := MakePoint(x, y);
              if Assigned(FImages) and LookupBar.Rotated then
                if (FImageIndex > -1) and (FImageIndex < FImages.Count) then
                  pt := MakePoint(x, y + FImages.Height);

              if FCustomChar[ID] then
              begin
                b := TGPSolidBrush.Create(ColorToARGB(Font.Color));
                g.DrawString(customch, length(customch), f, pt, sf, b);
                b.Free;
              end
              else
              begin
                b := TGPSolidBrush.Create(ColorToARGB(DisabledFont.Color));
                g.DrawString(customch, length(customch), fd, pt, sf, b);
                b.Free;
              end;

              if Assigned(FImages) then
              begin
                if (ImageIndex <> -1) and (ImageIndex < FImages.Count) then
                begin
                  if Rotated then
                    FImages.Draw(Canvas, Round(ximg), Round(y + 1), ImageIndex)
                  else
                    FImages.Draw(Canvas, Round(ximg + 3), Round(y + 1), ImageIndex)
                end;
              end;

              if not AutoSize then
              begin
                y := y + th + LookupBar.Spacing;
                if Assigned(FImages) and LookupBar.Rotated then
                  if (FImageIndex > -1) and (FImageIndex < FImages.Count) then
                    y := y + FImages.Height;
              end;
            end;
          end;
        end;
      end;

      f.Free;
      fd.Free;
      sf.Free;
      ca.Free;
      g.Free;
    end;
  end;
end;

procedure TAdvSmoothListBox.DrawScrollIndicator;
var
  p: TGDIPFillParameters;
  pos, h: Single;
  g: TGPGraphics;
  w: integer;
begin
  if not Assigned(ScrollIndicator) then
    exit;

  if not ScrollIndicator.Visible then
    exit;

  if GetFullHeight + Height < Height then
    exit;

  with ScrollIndicator do
  begin
    w := LookupBar.GetWidth;

    g := TGPGraphics.Create(Canvas.Handle);

    p.Graphics := g;
    p.Path := nil;
    p.Fillpath := false;
    h := 0;
    if (GetFullHeight > 0) and (Self.Height > 0) then
      h := ((Self.Height - Header.GetHeight - Footer.GetHeight - GetShadowOffset) / (GetFullHeight + Height + GetShadowOffset)) * Self.Height;
    pos := 0;
    if (GetPosition > 0) and (GetFullHeight > 0) then
      pos := (Self.Height - Header.GetHeight - h - Footer.GetHeight - GetShadowOffset) / GetFullHeight * GetPosition;

    pos := pos + Header.GetHeight;
    if LookupBar.Position = pRight then
      p.R := MakeRect(InsideRect.Right - w - Width - 2 - GetShadowOffset, pos, Width, h)
    else
      p.R := MakeRect(InsideRect.Right - Width - 2  - GetShadowOffset, pos, Width, h);

    p.GT := GradientType;
    p.ColorFrom := Color;
    p.ColorTo := ColorTo;
    p.OpacityFrom := GetAnimationOpacity;
    p.OpacityTo := GetAnimationOpacity;
    p.HatchStyle := HatchStyle;
    p.Angle := 0;
    p.Image := nil;
    p.BorderStyle := DashStyleSolid;
    p.BorderColor := clNone;
    p.BorderWidth := 0;

    FillGDIP(p);

    g.Free;
  end;
end;

procedure TAdvSmoothListBox.DrawSection(itemRect: TRect; ch: String; catindex: integer);
var
  p: TGDIPFillParameters;
  ff: TGPFontFamily;
  f: TGPFont;
  fs: integer;
  sf: TGPStringFormat;
  b: TGPSolidBrush;
  x, y: Single;
  pt: TGPPointF;
  g: TGPGraphics;
  cat: TAdvSmoothListBoxCategoryItem;
  ca: TCanvas;
begin
  with Sections do
  begin
    if not Visible then
      exit;

    ca := TCanvas.Create;
    ca.Handle := Canvas.Handle;

    g := TGPGraphics.Create(Canvas.Handle);
    g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

    p.Graphics := g;
    p.Path := nil;
    p.Fillpath := false;

    p.R := MakeRect(itemrect.Left, itemRect.Top - GetPosition, itemRect.Right - itemRect.Left, itemRect.Bottom - itemRect.Top);

    p.GT := GradientType;
    p.ColorFrom := Color;
    p.ColorTo := ColorTo;
    p.OpacityFrom := Opacity;
    p.OpacityTo := OpacityTo;
    p.HatchStyle := HatchStyle;
    p.Angle := 0;
    p.Image := nil;

    if BorderWidth = 0 then
      p.BorderColor := clNone
    else
      p.BorderColor := BorderColor;

    p.BorderWidth := BorderWidth;
    p.BorderStyle := DashStyleSolid;

    FillGDIP(p);

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

    sf := TGPStringFormat.Create;
    f := TGPFont.Create(ff, FFont.Size, fs, UnitPoint);

    x := itemRect.Left + 2;
    y := p.R.Y + 2;

    if Assigned(FImages) then
    begin
      cat := Categories.ItemById(catindex);
      if (cat.ImageIndex > -1) and (cat.ImageIndex < FImages.Count) then
      begin
        FImages.Draw(ca, Round(x), Round(y - 1), cat.ImageIndex);
        pt := MakePoint(x + FImages.Width + 4, y)
      end
      else
        pt := MakePoint(x, y)
    end
    else
      pt := MakePoint(x, y);


    b := TGPSolidBrush.Create(ColorToARGB(FFont.Color));
    g.DrawString(ch, length(ch), f, pt, sf, b);
    b.Free;

    ff.free;
    sf.free;
    f.free;
    g.Free;
    ca.free;    
  end;
end;

function TAdvSmoothListBox.FindFirstItemWithCategoryID(
  CategoryID: integer): TAdvSmoothListBoxDisplayListItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FDisplayList.Count - 1 do
  begin
   result := FDisplayList.GetItem(i);
    with result do
    begin
      if DisplayItem <> nil then
      begin
        if DisplayItem.CategoryID > -1 then
        begin
          if CategoryID = DisplayItem.CategoryID then
          begin
            break;
          end;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothListBox.FindFirstItemWithChar(ch: String): TAdvSmoothListBoxDisplayListItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FDisplayList.Count - 1 do
  begin
   result := FDisplayList.GetItem(i);
    with result do
    begin
      if DisplayItem <> nil then
      begin
        if Length(DisplayItem.Caption) > 0 then
        begin
          if UpCase(NormalizeSpecialChar(DisplayItem.Caption)[1]) = ch then
          begin
            break;
          end;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothListBox.FindFirstSectionWithCategoryID(
  CategoryID: integer): TAdvSmoothListBoxDisplayListItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    result := FDisplayList.GetItem(i);
    with Result do
    begin
      if DisplayItem = nil then
      begin
        if SectionCategoryID <> -1 then
        begin
          if SectionCategoryID = CategoryID then
          begin
            break;
          end;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothListBox.FindFirstSectionWithChar(ch: String): TAdvSmoothListBoxDisplayListItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FDisplayList.Count - 1 do
  begin
    result := FDisplayList.GetItem(i);
    with Result do
    begin
      if DisplayItem = nil then
      begin
        if Length(SectionCaption) > 0 then
        begin
          if UpCase(SectionCaption[1]) = ch then
          begin
            break;
          end;
        end;
      end;
    end;
  end;
end;

{ TAdvSmoothListBoxItem }

procedure TAdvSmoothListBoxItem.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothListBoxItem then
  begin
    CopySettings(Source);
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.AssignVisuals(Source: TPersistent);
begin
  if Source is TAdvSmoothListBoxItem then
  begin
    FCaptionFont.Assign((Source as TAdvSmoothListBoxItem).CaptionFont);
    FEnabled := (Source as TAdvSmoothListBoxItem).Enabled;
    FChecked := (Source as TAdvSmoothListBoxItem).Checked;
    FCaptionAlignment := (Source as TAdvSmoothListBoxItem).CaptionAlignment;
    FInfoFont.Assign((Source as TAdvSmoothListBoxItem).InfoFont);
    FGraphicLeftType := (Source as TAdvSmoothListBoxItem).GraphicLeftType;
    FGraphicRightType := (Source as TAdvSmoothListBoxItem).GraphicRightType;
    FGraphicLeft.Assign((Source as TAdvSmoothListBoxItem).GraphicLeft);
    FGraphicRight.Assign((Source as TAdvSmoothListBoxItem).GraphicRight);
    FGraphicLeftShow := (Source as TAdvSmoothListBoxItem).GraphicLeftShow;
    FGraphicRightShow := (Source as TAdvSmoothListBoxItem).GraphicRightShow;
    FSplitter := (Source as TAdvSmoothListBoxItem).Splitter;
    FNotesFont.Assign((Source as TAdvSmoothListBoxItem).NotesFont);
    FNotesURLColor := (Source as TAdvSmoothListBoxItem).NotesURLColor;
    FNoteShadowColor := (Source as TAdvSmoothListBoxItem).NotesShadowColor;
    FNotesShadowOffset := (Source as TAdvSmoothListBoxItem).NotesShadowOffset;
    FNotesLocation := (Source as TAdvSmoothListBoxItem).NotesLocation;
    FNotesLeft := (Source as TAdvSmoothListBoxItem).NotesLeft;
    FNotesTop := (Source as TAdvSmoothListBoxItem).NotesTop;
    FControl := (Source as TAdvSmoothListBoxItem).DetailControl;
    FMargin := (Source as TAdvSmoothListBoxItem).CaptionMargin;
    FGraphicLeftMargin := (Source as TAdvSmoothListBoxItem).GraphicLeftMargin;
    FGraphicRightMargin := (Source as TAdvSmoothListBoxItem).GraphicRightMargin;
    FSelected := (Source as TAdvSmoothListBoxItem).Selected;
    FProgressMin := (Source as TAdvSmoothListBoxItem).ProgressMinimum;
    FProgressMax := (Source as TAdvSmoothListBoxItem).ProgressMaximum;
    FProgressValue := (Source as TAdvSmoothListBoxItem).ProgressValue;
    FProgressHeight := (Source as TAdvSmoothListBoxItem).ProgressHeight;
    FProgressWidth := (Source as TAdvSmoothListBoxItem).ProgressWidth;
    FProgressPosition := (Source as TAdvSmoothListBoxItem).ProgressPosition;
    FProgressVisible := (Source as TAdvSmoothListBoxItem).ProgressVisible;
    FProgressTop := (Source as TAdvSmoothListBoxItem).ProgressTop;
    FProgressLeft := (Source as TAdvSmoothListBoxItem).ProgressLeft;
    FGraphicLeftWidth := (Source as TAdvSmoothListBoxItem).GraphicLeftWidth;
    FGraphicLeftHeight := (Source as TAdvSmoothListBoxItem).GraphicLeftHeight;
    FGraphicRightWidth := (Source as TAdvSmoothListBoxItem).GraphicRightWidth;
    FGraphicRightHeight := (Source as TAdvSmoothListBoxItem).GraphicRightHeight;
    FButtonCaption := (Source as TAdvSmoothListBoxItem).ButtonCaption;
    FButtonColor := (Source as TAdvSmoothListBoxItem).ButtonColor;
    FBevelColor := (Source as TAdvSmoothListBoxItem).ButtonBevelColor;
    FButtonBevel := (Source as TAdvSmoothListBoxItem).ButtonBevel;
    FButtonShadow := (Source as TAdvSmoothListBoxItem).ButtonShadow;
    FIndent := (Source as TAdvSmoothListBoxItem).Indent;
    FLevel := (Source as TAdvSmoothListBoxItem).Level;
    FExpanded := (Source as TAdvSmoothListBoxItem).Expanded;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.Changed;
begin
  with (Collection as TAdvSmoothListBoxItems) do
  begin
    if FUpdateCount = 0 then
    begin
      if Assigned(FOwner.FCurrentControl) and not FOwner.FAnimatingdetail then
        FOwner.FCurrentControl.Left := FOwner.Width;
      FOwner.LookupBar.InitLookupBar;
      FOwner.InitDisplayList;
      if Assigned(FOwner.FOnItemChanged) then
        FOwner.FOnItemChanged(Self, index);
      FOwner.Changed;
    end;
  end;
end;

procedure TAdvSmoothListBoxItem.Collapse;
var
  i: integer;
begin
  FExpanded := false;
  with FOwner.Items do
  begin
    BeginUpdate;
    for I := (Self.Index + 1) to Count - 1 do
    begin
      if (Items[I].Level > Self.Level) then
        Items[I].Visible := false
      else
        break;
    end;
    EndUpdate;
  end;
end;

procedure TAdvSmoothListBoxItem.CopySettings(Source: TPersistent);
begin
  if Source is TAdvSmoothListBoxItem then
  begin
    FCaptionFont.Assign((Source as TAdvSmoothListBoxItem).CaptionFont);
    FCaption := (Source as TAdvSmoothListBoxItem).Caption;
    FEnabled := (Source as TAdvSmoothListBoxItem).Enabled;
    FChecked := (Source as TAdvSmoothListBoxItem).Checked;
    FCaptionAlignment := (Source as TAdvSmoothListBoxItem).CaptionAlignment;
    FNotes := (Source as TAdvSmoothListBoxItem).Notes;
    FInfo := (Source as TAdvSmoothListBoxItem).Info;
    FInfoFont.Assign((Source as TAdvSmoothListBoxItem).InfoFont);
    FGraphicLeftType := (Source as TAdvSmoothListBoxItem).GraphicLeftType;
    FGraphicRightType := (Source as TAdvSmoothListBoxItem).GraphicRightType;
    FGraphicLeft.Assign((Source as TAdvSmoothListBoxItem).GraphicLeft);
    FGraphicRight.Assign((Source as TAdvSmoothListBoxItem).GraphicRight);
    FGraphicLeftShow := (Source as TAdvSmoothListBoxItem).GraphicLeftShow;
    FGraphicRightShow := (Source as TAdvSmoothListBoxItem).GraphicRightShow;
    FSplitter := (Source as TAdvSmoothListBoxItem).Splitter;
    FNotesURLColor := (Source as TAdvSmoothListBoxItem).NotesURLColor;
    FNoteshadowColor := (Source as TAdvSmoothListBoxItem).NotesShadowColor;
    FNotesShadowOffset := (Source as TAdvSmoothListBoxItem).NotesShadowOffset;
    FNotesLocation := (Source as TAdvSmoothListBoxItem).NotesLocation;
    FNotesLeft := (Source as TAdvSmoothListBoxItem).NotesLeft;
    FNotesTop := (Source as TAdvSmoothListBoxItem).NotesTop;
    FControl := (Source as TAdvSmoothListBoxItem).DetailControl;
    FMargin := (Source as TAdvSmoothListBoxItem).CaptionMargin;
    FProgressMin := (Source as TAdvSmoothListBoxItem).ProgressMinimum;
    FProgressMax := (Source as TAdvSmoothListBoxItem).ProgressMaximum;
    FProgressValue := (Source as TAdvSmoothListBoxItem).ProgressValue;
    FProgressHeight := (Source as TAdvSmoothListBoxItem).ProgressHeight;
    FProgressWidth := (Source as TAdvSmoothListBoxItem).ProgressWidth;
    FProgressPosition := (Source as TAdvSmoothListBoxItem).ProgressPosition;
    FProgressVisible := (Source as TAdvSmoothListBoxItem).ProgressVisible;
    FProgressTop := (Source as TAdvSmoothListBoxItem).ProgressTop;
    FProgressLeft := (Source as TAdvSmoothListBoxItem).ProgressLeft;
    FVisible := (Source as TAdvSmoothListBoxItem).Visible;
    FIndent :=(Source as TAdvSmoothListBoxItem).Indent;
    Fhint := (Source as TAdvSmoothListBoxItem).Hint;
    FGraphicLeftMargin := (Source as TAdvSmoothListBoxItem).GraphicLeftMargin;
    FGraphicRightMargin := (Source as TAdvSmoothListBoxItem).GraphicRightMargin;
    FGraphicLeftWidth := (Source as TAdvSmoothListBoxItem).GraphicLeftWidth;
    FGraphicLeftHeight := (Source as TAdvSmoothListBoxItem).GraphicLeftHeight;
    FGraphicRightWidth := (Source as TAdvSmoothListBoxItem).GraphicRightWidth;
    FGraphicRightHeight := (Source as TAdvSmoothListBoxItem).GraphicRightWidth;
    FNotesFont.Assign((Source as TAdvSmoothListBoxItem).NotesFont);
    FTag := (Source as TAdvSmoothListBoxItem).Tag;
    FSelected := (Source as TAdvSmoothListBoxItem).Selected;
    FCategoryId := (Source as TAdvSmoothListBoxItem).CategoryID;
    FProgressMargin := (Source as TAdvSmoothListBoxItem).ProgressMargin;
    FButtonColor := (Source as TAdvSmoothListBoxItem).ButtonColor;
    FButtonBevel := (Source as TAdvSmoothListBoxItem).ButtonBevel;
    FBevelColor := (Source as TAdvSmoothListBoxItem).ButtonBevelColor;
    FButtonShadow := (Source as TAdvSmoothListBoxItem).ButtonShadow;
    FButtonCaption := (Source as TAdvSmoothListBoxItem).ButtonCaption;
    FLevel := (Source as TAdvSmoothListBoxItem).Level;
    FExpanded := (Source as TAdvSmoothListBoxItem).Expanded;
  end;
end;

constructor TAdvSmoothListBoxItem.Create(Collection: TCollection);
begin
  inherited;
  FOwner := (Collection as TAdvSmoothListBoxItems).FOwner;
  FMargin := 3;
  FChecked := false;
  FNotesTop := 0;
  FNotesLeft := 0;
  FNoteshadowColor := clGray;
  FNotesLocation :=  plCenterCenter;
  FNotesURLColor := clBlue;
  FNotesShadowOffset := 5;
  FSplitter := false;
  FCaption := 'Item ' + inttostr(Index);
  FEnabled := true;
  FCaptionAlignment := taLeftJustify;
  FNotes := '';
  FInfo := '';
  FSelected := false;
  FGraphicLeftType := gtNone;
  FGraphicLeftShow := gsAlways;
  FGraphicLeft := TAdvGDIPPicture.Create;
  FGraphicLeft.DoubleBuffered := true;
  FGraphicLeft.OnChange := PictureChanged;
  FGraphicLeftMargin := 3;
  FGraphicLeftWidth := 30;
  FGraphicLeftHeight := 25;
  FVisible := true;
  FCategoryID := -1;
  FIndent := 0;
  FLevel := 0;
  FExpanded := true;

  FButtonColor := clGray;
  FButtonShadow := false;
  FButtonBevel := true;
  FBevelColor := clWhite;
  FButtonCaption := '';

  FProgressMin := 0;
  FProgressMax := 100;
  FProgressValue := 0;
  FProgressHeight := 15;
  FProgressWidth := 130;
  FProgressPosition := plBottomCenter;
  FProgressMargin := 3;
  FProgressVisible := false;
  FProgressLeft := 0;
  FProgressTop := 0;

  FGraphicRightType := gtNone;
  FGraphicRightShow := gsAlways;
  FGraphicRight := TAdvGDIPPicture.Create;
  FGraphicRight.DoubleBuffered := true;
  FGraphicRight.OnChange := PictureChanged;
  FGraphicRightMargin := 3;
  FGraphicRightWidth := 30;
  FGraphicRightHeight := 25;

  FCaptionFont := TFont.Create;
  FCaptionFont.OnChange := FontChanged;

  FNotesFont := TFont.Create;
  FNotesFont.OnChange := FontChanged;

  FInfoFont := TFont.Create;
  FInfoFont.OnChange := FontChanged;

  {$IFNDEF DELPHI9_LVL}
  FCaptionFont.Name := 'Tahoma';
  FNotesFont.Name := 'Tahoma';
  FInfoFont.Name := 'Tahoma';
  {$ENDIF}

  with (collection as TAdvSmoothListBoxItems) do
  begin
    if FUpdateCount = 0 then
    begin
      if Assigned(FOwner.FCurrentControl) then
        FOwner.FCurrentControl.Left := FOwner.width;
      FOwner.LookupBar.InitLookupBar;
      FOwner.InitDisplayList;
      FOwner.Changed;
    end;
  end;

  if Assigned((Collection as TAdvSmoothListBoxItems).FOwner.FDefaultItem) then
    AssignVisuals((Collection as TAdvSmoothListBoxItems).FOwner.FDefaultItem);
end;

destructor TAdvSmoothListBoxItem.Destroy;
begin
  FGraphicLeft.Free;
  FGraphicRight.Free;
  FCaptionFont.Free;
  FNotesFont.Free;
  FInfoFont.Free;

  inherited;


  with FOwner do
  begin
    if (csDestroying in componentstate) then
      Exit;

    if FItems.FUpdateCount = 0 then
    begin
      if Assigned(FCurrentControl) then
        FCurrentControl.Left := FOwner.width;
      LookupBar.InitLookupBar;
      InitDisplayList;
      Changed;
    end;
  end;
end;

procedure TAdvSmoothListBoxItem.Draw(ACanvas: TCanvas; R: TRect; DisplayIndex: integer);
var
  o: TAdvSmoothListBox;
  gppointf: TGPPointF;
  crl, crt: Single;
  a, s, k: String;
  XSize, YSize: integer;
  l, m: integer;
  hr: TRect;
  ca: TCanvas;
  g, gpic: TGPGraphics;
  ff: TGPFontFamily;
  sf: TGPStringFormat;
  f: TGPFont;
  fs: integer;
  b: TGPSolidBrush;
  src, sri: TGPRectF;
  showgraphic: Boolean;
  htmlr: TRect;
  defaultdraw: Boolean;
  c, i, n: String;
  ir: TGPRectF;
  x, y, ch: integer;
  cht, iht: integer;
  DChecked: Integer;
  ntitem, pritem: TAdvSmoothListBoxItem;
  rt: TFillRoundingType;
  htheme: THandle;
  ThemeStyle: dword;
  w, bx, by, bw, bh: integer;
  focustopitem: Boolean;
  sizegr, sizegl: integer;
  pr: TRect;
begin
  o := FOwner;
  with o do
  begin
    if (DisplayIndex < 0) or (DisplayIndex >= FDisplayList.Count) then
      Exit;

    if (R.Left < 0) and (R.Right < 0) then
      Exit;

    defaultdraw := true;
    if (o.FFill.BorderWidth > 0) and (o.FFill.BorderColor <> clNone) then
      DoItemBkgDraw(self, ACanvas, FDisplayList.GetItem(DisplayIndex).DisplayItem.Index, Bounds(r.Left, r.Top - GetPosition, r.Right - r.Left, r.Bottom - r.Top), defaultdraw)
    else
      DoItemBkgDraw(self, ACanvas, FDisplayList.GetItem(DisplayIndex).DisplayItem.Index, Bounds(r.Left, r.Top - GetPosition, r.Right - r.Left - 1, r.Bottom - r.Top), defaultdraw);

    g := TGPGraphics.Create(ACanvas.Handle);
    g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

    if (o.FFill.BorderWidth > 0) and (o.FFill.BorderColor <> clNone) then
      ir := MakeRect(r.Left, r.Top - GetPosition, r.Right - r.Left, r.Bottom - R.Top)
    else
      ir := MakeRect(r.Left, r.Top - GetPosition, r.Right - r.Left - 1, r.Bottom - R.Top);

    if defaultdraw then
    begin
      pritem := Items[Max(0, Index - 1)];
      ntitem := Items[Min(Items.Count - 1, Index + 1)];

      if (pritem.Index <> Index) and (ntitem.Index <> Index) then
      begin
        if (ItemAppearance.VerticalSpacing > 0) or (pritem.Splitter and ntitem.Splitter) then
          rt := rtBoth
        else
        begin
          if pritem.Splitter then
            rt := rtTop
          else if ntitem.Splitter then
            rt := rtBottom
          else
            rt := rtNone;
        end;
      end
      else
      begin
        if ItemAppearance.VerticalSpacing = 0 then
        begin
          if (prItem.Index = Index) and not ntItem.Splitter then
            rt := rtTop
          else if (ntItem.Index = Index) and not prItem.Splitter then
            rt := rtBottom
          else
            rt := rtBoth;
        end
        else
          rt := rtBoth;
      end;

      focustopitem := (FFocusedItemIndex = Index);

      if FEnabled then
      begin
        if (FSelectedItemIndex = Index) or (MultiSelect and Selected) then
        begin
          ItemAppearance.FillSelected.BeginUpdate;
          ItemAppearance.FillSelected.RoundingType := rt;
          ItemAppearance.FillSelected.Focus := FFocused and TabStop and ShowFocus and focustopitem;
          ItemAppearance.FillSelected.FocusColor := FocusColor;
          ItemAppearance.FillSelected.EndUpdate;
          ir := ItemAppearance.FillSelected.Fill(g, ir);
        end
        else
        begin
          ItemAppearance.Fill.BeginUpdate;
          ItemAppearance.Fill.RoundingType := rt;
          ItemAppearance.Fill.Focus := FFocused and TabStop and ShowFocus and focustopitem;
          ItemAppearance.Fill.FocusColor := FocusColor;
          ItemAppearance.Fill.EndUpdate;
          ir := ItemAppearance.Fill.Fill(g, ir);
        end;
      end
      else
      begin
        ItemAppearance.FillDisabled.BeginUpdate;
        ItemAppearance.FillDisabled.RoundingType := rt;
        ItemAppearance.FillDisabled.EndUpdate;
        ir := ItemAppearance.FillDisabled.Fill(g, ir);
      end;
    end;

    c := Self.Caption;
    i := Self.Info;
    n := Self.Notes;

    DoItemText(Self, FDisplayList.GetItem(DisplayIndex).DisplayItem.Index, c, i, n);

    iht := 0;
    if i <> '' then
    begin
      ff := TGPFontFamily.Create(InfoFont.Name);
      if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
      begin
        ff.Free;
        ff := TGPFontFamily.Create('Arial');
      end;

      fs := 0;
      if (fsBold in InfoFont.Style) then
        fs := fs + 1;
      if (fsItalic in InfoFont.Style) then
        fs := fs + 2;
      if (fsUnderline in InfoFont.Style) then
        fs := fs + 4;

      sf := TGPStringFormat.Create;
      f := TGPFont.Create(ff, InfoFont.Size, fs, UnitPoint);
      b := TGPSolidBrush.Create(ColorToARGB(InfoFont.Color));

      g.MeasureString(i, length(i), f, ir, sf, sri);

      crl := ir.X + ir.Width - sri.Width;

      w := 0;
      if FGraphicRightType <> gtNone then
        w := FGraphicRightWidth;
      if (n = '') then
      begin
        crt := ir.Y + (ir.Height - sri.Height) / 2;
        gppointf := MakePoint(crl - ScrollIndicator.GetWidth - w, crt);
      end
      else
      begin
        crt := ir.Y;
        gppointf := MakePoint(crl - ScrollIndicator.GetWidth, crt);
      end;

      iht := Round(sri.Height);
      g.DrawString(i, Length(i), f, gppointf, sf, b);

      finfor := Bounds(Round(gppointf.X), Round(gppointf.Y), Round(sri.Width), Round(sri.Height));

      b.free;
      ff.free;
      sf.Free;
      f.free;
    end;

    cht := 0;
    if c <> '' then
    begin
      ff := TGPFontFamily.Create(CaptionFont.Name);
      if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
      begin
        ff.Free;
        ff := TGPFontFamily.Create('Arial');
      end;

      fs := 0;
      if (fsBold in CaptionFont.Style) then
        fs := fs + 1;
      if (fsItalic in CaptionFont.Style) then
        fs := fs + 2;
      if (fsUnderline in CaptionFont.Style) then
        fs := fs + 4;

      sf := TGPStringFormat.Create;
      f := TGPFont.Create(ff, CaptionFont.Size, fs, UnitPoint);
      b := TGPSolidBrush.Create(ColorToARGB(CaptionFont.Color));

      g.MeasureString(c, length(c), f, ir, sf, src);

      crl := 0;
      case CaptionAlignment of
        taLeftJustify: crl := ir.X;
        taRightJustify: crl := ir.Width - src.Width - sri.Width;
        taCenter: crl := (ir.Width - src.Width) / 2;
      end;

      w := 0;
      if FGraphicLeftType <> gtNone then
        w := FGraphicLeftWidth;

      if (n = '') then
      begin
        crt := ir.Y + (ir.Height - src.Height) / 2;
        gppointf := MakePoint(crl + FMargin + w, crt);
      end
      else
      begin
        crt := ir.Y;
        gppointf := MakePoint(crl + FMargin, crt);
      end;

      cht := Round(src.Height);
      g.DrawString(c, Length(c), f, gppointf, sf, b);

      fcaptionr := Bounds(Round(gppointf.X), Round(gppointf.Y), Round(src.Width), Round(src.Height));

      b.free;
      ff.free;
      sf.Free;
      f.free;
    end;

    if n <> '' then
    begin
      fn := n;

      htmlr := Rect(0, 0, 10000, 10000);

      HTMLDrawGDIP(g, NotesFont, n,htmlr,FImages, 0,0,-1,-1,NotesShadowOffset,False,true,false,false,
        False,False,true,1.0,NotesURLColor,clNone,clNone,NotesShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

      sizegl := 0;
      if FGraphicLeftType <> gtNone then
        sizegl := FGraphicLeftMargin + FGraphicLeftWidth;

      sizegr := 0;
      if FGraphicRightType <> gtNone then
        sizegr := FGraphicRightMargin + FGraphicRightWidth;

      case FNotesLocation of
        plBottomLeft, plCenterLeft, plTopLeft: ir.X := ir.X + sizegl;
        plBottomRight, plTopRight, plCenterRight: ir.X := ir.X - sizegr;
      end;

      if NotesLocation <> plCustom then
        GetTextPosition(x, y, ir, XSize, YSize, NotesLocation)
      else
      begin
        x := NotesLeft;
        y := NotesTop;
      end;

      ch := 0;
      case FNotesLocation of
        plTopLeft: ch := Max(cht, iht);
        plTopCenter: ch := Max(cht, iht);
        plTopRight: ch := Max(cht, iht);
      end;

      if NotesLocation <> plCustom then
        htmlr := Bounds(Round(ir.X + x), Round(ir.Y + y + ch), xsize, ysize)
      else
        htmlr := Bounds(Round(ir.X + x), Round(ir.Y + y), xsize, ysize);

      HTMLDrawGDIP(g, NotesFont,n,htmlr,FImages, 0,0,-1,-1,NotesShadowOffset,False,false,false,false,
        False,False,true,1.0,NotesURLColor,clNone,clNone,NotesShadowColor,a,s,k,XSize,YSize,l,m,hr,nil, FContainer,2);

      Fhtmlr := htmlr;
    end;

    g.Free;

    defaultdraw := true;
    DoItemDraw(self, ACanvas, FDisplayList.GetItem(DisplayIndex).DisplayItem.Index, Rect(R.Left, r.Top - GetPosition, R.Right, r.Bottom), defaultdraw);

    if defaultdraw then
    begin
      ca := TCanvas.Create;
      ca.Handle := ACanvas.Handle;

      DChecked := 0;
      ThemeStyle := 0;

      showgraphic := false;
      case GraphicLeftShow of
        gsAlways: showgraphic := true;
        gsSelected:  showgraphic := (FSelectedItemIndex = Index);
        gsEnabled: showgraphic := FEnabled;
      end;

      if showgraphic then
      begin
          fgrLeft := Bounds(R.Left + GraphicLeftMargin, r.Top - GetPosition + (R.Bottom - R.Top - FGraphicLeftHeight) div 2,
          FGraphicLeftWidth, FGraphicLeftHeight);

        if Checked or FButtonLeft then
        begin
          case GraphicLeftType of
            gtCheckBox:
              begin
                DChecked := DFCS_BUTTONCHECK or DFCS_CHECKED;
                if FEnabled then
                  ThemeStyle := CBS_CHECKEDNORMAL
                else
                  ThemeStyle := CBS_CHECKEDDISABLED;
              end;
            gtRadio:
              begin
                DChecked := DFCS_BUTTONRADIO or DFCS_CHECKED;
                if FEnabled then
                  ThemeStyle := RBS_CHECKEDNORMAL
                else
                  ThemeStyle := RBS_CHECKEDDISABLED;
              end;
            gtButton:
              begin
                DChecked := DFCS_BUTTONPUSH;
                if FEnabled then
                  ThemeStyle := PBS_PRESSED
                else
                  ThemeStyle := PBS_DISABLED;
              end;
          end;
        end
        else
        begin
          case GraphicLeftType of
            gtCheckBox:
              begin
                DChecked := DFCS_BUTTONCHECK;
                if FEnabled then
                  ThemeStyle := CBS_UNCHECKEDNORMAL
                else
                  ThemeStyle := CBS_UNCHECKEDDISABLED;

              end;
            gtRadio:
              begin
                DChecked := DFCS_BUTTONRADIO;
                if FEnabled then
                  ThemeStyle := RBS_UNCHECKEDNORMAL
                else
                  ThemeStyle := RBS_UNCHECKEDDISABLED;

              end;
            gtButton:
              begin
                DChecked := DFCS_BUTTONPUSH;
                if FEnabled then
                  ThemeStyle := PBS_NORMAL
                else
                  ThemeStyle := PBS_DISABLED;
              end;
          end;
        end;

        if not Enabled then
          DChecked := DChecked or DFCS_INACTIVE;

        case GraphicLeftType of
          gtCheckBox:
            if FIsWinXP and IsThemeActive then
            begin
              htheme := OpenThemeData(Handle,'button');
              DrawThemeBackground(HTheme,ca.Handle, BP_CHECKBOX,ThemeStyle,@fgrLeft,nil);
              CloseThemeData(htheme);
            end
            else
              DrawFrameControl(ca.Handle,fgrLeft,DFC_BUTTON, DChecked);
          gtRadio:
            if FIsWinXP and IsThemeActive then
            begin
              htheme := OpenThemeData(Handle,'button');
              DrawThemeBackground(HTheme,ca.Handle, BP_RADIOBUTTON,ThemeStyle,@fgrLeft,nil);
              CloseThemeData(htheme);
            end
            else
              DrawFrameControl(ca.Handle,fgrLeft,DFC_BUTTON, DChecked);
          gtButton:
            if FIsWinXP and IsThemeActive then
            begin
              htheme := OpenThemeData(Handle,'button');
              DrawThemeBackground(HTheme,ca.Handle, BP_PUSHBUTTON,ThemeStyle,@fgrLeft,nil);
              CloseThemeData(htheme);
            end
            else
              DrawFrameControl(ca.Handle,fgrLeft,DFC_BUTTON,DChecked);

          gtDetailImage, gtImage:
          begin
            gpic := TGPGraphics.Create(ca.Handle);
            GraphicLeft.GDIPDraw(gpic, fgrLeft);
            gpic.Free;
          end;
          gtCommonImage:
          begin
            gpic := TGPGraphics.Create(ca.Handle);
            ItemImage.GDIPDraw(gpic, fgrLeft);
            gpic.Free;
          end;
          gtCommonDetailImage:
          begin
            gpic := TGPGraphics.Create(ca.Handle);
            DetailItemImage.GDIPDraw(gpic, fgrLeft);
            gpic.Free;
          end;
          gtSmoothButton:
          begin
            gpic := TGPGraphics.Create(ca.Handle);
            gpic.SetSmoothingMode(SmoothingModeAntiAlias);
            bx := fgrLeft.Left;
            by := fgrLeft.Top;
            bw := GraphicLeftWidth;
            bh := GraphicLeftHeight;
            FOwner.FItemAppearance.FButtonAppearance.Draw(gpic, ButtonCaption, bx, by, bw, bh, 0, 0,
              ButtonColor, clNone, ButtonBevelColor, ButtonShadow, FButtonLeft and FMouseDown, ButtonBevel, false, false,
              rtBoth, FGraphicLeft, 0, 0, true);
            gpic.Free;
          end;
        end;
      end;

      showgraphic := false;
      case GraphicRightShow of
        gsAlways: showgraphic := true;
        gsSelected:  showgraphic := (FSelectedItemIndex = Index);
        gsEnabled: showgraphic := FEnabled;
      end;

      if showgraphic then
      begin
        fgrRight := Bounds(R.Right - GraphicRightMargin - FGraphicRightWidth - ScrollIndicator.GetWidth,
          r.Top - GetPosition + (R.Bottom - R.Top - FGraphicRightHeight) div 2, FGraphicRightWidth, FGraphicRightHeight);

        if Checked or FButtonRight then
        begin
          case GraphicRightType of
            gtCheckBox:
              begin
                DChecked := DFCS_BUTTONCHECK or DFCS_CHECKED;
                if FEnabled then
                  ThemeStyle := CBS_CHECKEDNORMAL
                else
                  ThemeStyle := CBS_CHECKEDDISABLED;
              end;
            gtRadio:
              begin
                DChecked := DFCS_BUTTONRADIO or DFCS_CHECKED;
                if FEnabled then
                  ThemeStyle := RBS_CHECKEDNORMAL
                else
                  ThemeStyle := RBS_CHECKEDDISABLED;
              end;
            gtButton:
              begin
                DChecked := DFCS_BUTTONPUSH;
                if FEnabled then
                  ThemeStyle := PBS_PRESSED
                else
                  ThemeStyle := PBS_DISABLED;
              end;
          end;
        end
        else
        begin
          case GraphicRightType of
            gtCheckBox:
              begin
                DChecked := DFCS_BUTTONCHECK;
                if FEnabled then
                  ThemeStyle := CBS_UNCHECKEDNORMAL
                else
                  ThemeStyle := CBS_UNCHECKEDDISABLED;

              end;
            gtRadio:
              begin
                DChecked := DFCS_BUTTONRADIO;
                if FEnabled then
                  ThemeStyle := RBS_UNCHECKEDNORMAL
                else
                  ThemeStyle := RBS_UNCHECKEDDISABLED;

              end;
            gtButton:
              begin
                DChecked := DFCS_BUTTONPUSH;
                if FEnabled then
                  ThemeStyle := PBS_NORMAL
                else
                  ThemeStyle := PBS_DISABLED;
              end;
          end;
        end;

        if not Enabled then
          DChecked := DChecked or DFCS_INACTIVE;

        case GraphicRightType of
          gtCheckBox:
            if FIsWinXP and IsThemeActive then
            begin
              htheme := OpenThemeData(Handle,'button');
              DrawThemeBackground(HTheme,ca.Handle, BP_CHECKBOX,ThemeStyle,@fgrRight,nil);
              CloseThemeData(htheme);
            end
            else
              DrawFrameControl(ca.Handle,fgrRight,DFC_BUTTON, DChecked);
          gtRadio:
            if FIsWinXP and IsThemeActive then
            begin
              htheme := OpenThemeData(Handle,'button');
              DrawThemeBackground(HTheme,ca.Handle, BP_RADIOBUTTON,ThemeStyle,@fgrRight,nil);
              CloseThemeData(htheme);
            end
            else
              DrawFrameControl(ca.Handle,fgrRight,DFC_BUTTON, DChecked);
          gtButton:
            if FIsWinXP and IsThemeActive then
            begin
              htheme := OpenThemeData(Handle,'button');
              DrawThemeBackground(HTheme,ca.Handle, BP_PUSHBUTTON,ThemeStyle,@fgrRight,nil);
              CloseThemeData(htheme);
            end
            else
              DrawFrameControl(ca.Handle,fgrRight,DFC_BUTTON,DChecked);
          gtDetailImage, gtImage:
          begin
            gpic := TGPGraphics.Create(ca.Handle);
            GraphicRight.GDIPDraw(gpic, fgrRight);
            gpic.Free;
          end;
          gtCommonDetailImage:
          begin
            gpic := TGPGraphics.Create(ca.Handle);
            DetailItemImage.GDIPDraw(gpic, fgrRight);
            gpic.Free;
          end;
          gtCommonImage:
          begin
            gpic := TGPGraphics.Create(ca.Handle);
            ItemImage.GDIPDraw(gpic, fgrRight);
            gpic.Free;
          end;
          gtSmoothButton:
          begin
            gpic := TGPGraphics.Create(ca.Handle);
            gpic.SetSmoothingMode(SmoothingModeAntiAlias);
            bx := fgrRight.Left;
            by := fgrRight.Top;
            bw := GraphicRightWidth;
            bh := GraphicRightHeight;
            FOwner.FItemAppearance.FButtonAppearance.Draw(gpic, ButtonCaption, bx, by, bw, bh, 0, 0,
              ButtonColor, clNone, ButtonBevelColor, ButtonShadow, FButtonRight and FMouseDown, ButtonBevel, false, false,
              rtBoth, FGraphicRight, 0, 0, true);
            gpic.Free;
          end;          
        end;
      end;
      ca.Free;
    end;

    g := TGPGraphics.Create(Canvas.Handle);
    g.SetSmoothingMode(SmoothingModeAntiAlias);
    g.SetTextRenderingHint(TextRenderingHintAntiAlias);
    //ProgressBar
    with ItemAppearance.ProgressAppearance do
    begin
      if ProgressVisible then
      begin
        if ProgressPosition <> plCustom then
          GetTextPosition(x, y, MakeRect(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top),
            ProgressWidth + (ProgressMargin * 2), ProgressHeight + (ProgressMargin * 2), ProgressPosition)
        else
        begin
          x := ProgressLeft;
          y := ProgressTop;
        end;

        pr := Bounds(R.Left + x + ProgressMargin, R.Top - GetPosition + y + ProgressMargin, ProgressWidth, ProgressHeight);
        Draw(g, pr, ProgressMinimum, ProgressMaximum, ProgressValue);
      end;
    end;
    g.free;
  end;
end;

procedure TAdvSmoothListBoxItem.Expand;
var
  i: integer;
begin
  FExpanded := true;
  FVisualizeNodes := true;
  with FOwner.Items do
  begin
    BeginUpdate;
    for I := (Self.Index + 1) to Count - 1 do
    begin
      if (Items[i].Level > Self.Level) and FVisualizeNodes then
      begin
        FLastNode := Items[i].Level + 1;
        if Items[i].Expanded then
          Items[i].Visible := true
        else
        begin
          FVisualizeNodes := false;
          Items[I].Visible := true;
        end;
      end
      else
      begin
        if Items[i].Level < FLastNode then
        begin
          FVisualizeNodes := true;

          if Items[i].Expanded then
            Items[i].Visible := true
          else
          begin
            FVisualizeNodes := false;
            FLastNode := Items[i].Level + 1;
            Items[I].Visible := true;
          end;
        end;
      end;
    end;
    EndUpdate;
  end;
end;

procedure TAdvSmoothListBoxItem.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothListBoxItem.GetAnchorAt(X, Y: integer): String;
var
  a, s, k: String;
  XSize, YSize: integer;
  l, m: integer;
  hr: TRect;
  g: TGPGraphics;
begin
  with (Collection as TAdvSmoothListBoxItems).FOwner do
  begin
    if PtInRect(Fhtmlr, Point(X, Y)) then
    begin
      g := TGPGraphics.Create(Canvas.Handle);

      g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

      a := '';

      HTMLDrawGDIP(g, NotesFont, fn,Fhtmlr,FImages, X,Y,-1,-1,NotesShadowOffset,true,false,false,false,
        False,False,true,1.0,NotesURLColor,clNone,clNone,NotesShadowColor,a,s,k,XSize,YSize,l,m,hr,nil, FContainer,2);

      g.Free;
    end;
  end;

  Result :=  a;
end;

function TAdvSmoothListBoxItem.GetDisplayName: string;
begin
  if Caption <> '' then
    Result := Caption
  else
    Result := ClassName + inttostr(index);
end;

function TAdvSmoothListBoxItem.IsCaption(X, Y: integer): Boolean;
begin
  result := PtInRect(fcaptionr, Point(X, Y));
end;

function TAdvSmoothListBoxItem.IsGraphicLeft(X, Y: integer): Boolean;
begin
  result := PtInRect(fgrLeft, Point(X, Y));
end;

function TAdvSmoothListBoxItem.IsGraphicRight(X, Y: integer): Boolean;
begin
  result := PtInRect(fgrRight, Point(X, Y));
end;

function TAdvSmoothListBoxItem.IsInfo(X, Y: integer): Boolean;
begin
  result := PtInRect(finfor, Point(X, Y));
end;

procedure TAdvSmoothListBoxItem.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothListBoxItem.SaveItemValues(Caption, Info, Notes: String);
begin
  FOwner.Items.BeginUpdate;
  Self.Caption := Caption;
  Self.Info := Info;
  Self.Notes := Notes;
  FOwner.Items.EndUpdate;
end;

procedure TAdvSmoothListBoxItem.SetBevelColor(const Value: TColor);
begin
  if FBevelColor <> Value then
  begin
    FBevelColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetButtonBevel(const Value: Boolean);
begin
  if FButtonBevel <> value then
  begin
    FButtonBevel := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetButtonCaption(const Value: String);
begin
  if FButtonCaption <> value then
  begin
    FButtonCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetButtonColor(const Value: TColor);
begin
  if FButtonColor <> value then
  begin
    FButtonColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetButtonShadow(const Value: Boolean);
begin
  if FButtonShadow <> value then
  begin
    FButtonShadow := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetCaption(const Value: string);
begin
  if FCaption <> value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetCaptionAlignment(const Value: TAlignment);
begin
  if FCaptionAlignment <> value then
  begin
    FCaptionAlignment := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetCaptionFont(const Value: TFont);
begin
  if FCaptionFont <> value then
  begin
    FCaptionFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TAdvSmoothListBoxItem.SetCategoryID(const Value: integer);
begin
  if FCategoryID <> value then
  begin
    FCategoryID := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetChecked(const Value: Boolean);
begin
  if FChecked <> value then
  begin
    FChecked := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetExpanded(const Value: Boolean);
begin
  if FExpanded <> value then
  begin
    FExpanded := Value;
    if FExpanded then
      Expand
    else
      Collapse;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetControl(const Value: TControl);
begin
  if FControl <> value then
  begin
    FControl := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicLeft(
  const Value: TAdvGDIPPicture);
begin
  if FGraphicLeft <> Value then 
  begin
    FGraphicLeft.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicLeftHeight(const Value: integer);
begin
  if FGraphicLeftHeight <> value then
  begin
    FGraphicLeftHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicLeftMargin(const Value: integer);
begin
  if FGraphicLeftMargin <> value then
  begin
    FGraphicLeftMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicLeftShow(
  const Value: TAdvSmoothListBoxGraphicShow);
begin
  if FGraphicLeftShow <> value then
  begin
    FGraphicLeftShow := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicLeftType(
  const Value: TAdvSmoothListBoxGraphicType);
begin
  if FGraphicLeftType <> value then
  begin
    FGraphicLeftType := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicLeftWidth(const Value: integer);
begin
  if FGraphicLeftWidth <> value then
  begin
    FGraphicLeftWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicRight(
  const Value: TAdvGDIPPicture);
begin
  if FGraphicRight <> value then
  begin
    FGraphicRight.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicRightHeight(const Value: integer);
begin
  if FGraphicRightHeight <> value then
  begin
    FGraphicRightHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicRightMargin(const Value: integer);
begin
  if FGraphicRightMargin <> value then
  begin
    FGraphicRightMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicRightShow(
  const Value: TAdvSmoothListBoxGraphicShow);
begin
  if FGraphicRightShow <> value then
  begin
    FGraphicRightShow := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicRightType(
  const Value: TAdvSmoothListBoxGraphicType);
begin
  if FGraphicRightType <> value then
  begin
    FGraphicRightType := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetGraphicRightWidth(const Value: integer);
begin
  if FGraphicRightWidth <> value then
  begin
    FGraphicRightWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetHint(const Value: String);
begin
  if Fhint <> value then
  begin
    FHint := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetIndent(const Value: integer);
begin
  if FIndent <> value then
  begin
    FIndent := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetInfo(const Value: String);
begin
  if FInfo <> value then
  begin
    FInfo := Value;
    FontChanged(Self);
  end;
end;

procedure TAdvSmoothListBoxItem.SetInfoFont(const Value: TFont);
begin
  if FInfoFont <> value then
  begin
    FInfoFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TAdvSmoothListBoxItem.SetLevel(const Value: integer);
begin
  if Value >= 0 then
  begin
    FLevel := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetMargin(const Value: Integer);
begin
  if FMargin <> value then
  begin
    FMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetNotes(const Value: String);
begin
  if FNotes <> Value then
  begin
    FNotes := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetNotesFont(const Value: TFont);
begin
  if FNotesFont <> value then
  begin
    FNotesFont.Assign(value);
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetNotesLeft(const Value: integer);
begin
  if FNotesLeft <> value then
  begin
    FNotesLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetNotesLocation(
  const Value: TAdvSmoothListBoxLocation);
begin
  if FNotesLocation <> value then
  begin
    FNotesLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetNotesShadowColor(const Value: TColor);
begin
  if FNoteshadowColor <> value then
  begin
    FNoteshadowColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetNotesShadowOffset(const Value: integer);
begin
  if FNotesShadowOffset <> value then
  begin
    FNotesShadowOffset := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetNotesTop(const Value: integer);
begin
  if FNotesTop <> value then
  begin
    FNotesTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetNotesURLColor(const Value: TColor);
begin
  if FNotesURLColor <> value then
  begin
    FNotesURLColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetProgressHeight(const Value: integer);
begin
  if FProgressHeight <> value then
  begin
    FProgressHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetProgressLeft(const Value: integer);
begin
  if FProgressLeft <> value then
  begin
    FProgressLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetProgressMargin(const Value: integer);
begin
  if FProgressMargin <> value then
  begin
    FProgressMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetProgressMax(const Value: Double);
begin
  if FProgressMax <> Value then
  begin
    FProgressMax := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetProgressMin(const Value: Double);
begin
  if FProgressMin <> value then
  begin
    FProgressMin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetProgressPosition(
  const Value: TAdvSmoothListBoxLocation);
begin
  if FProgressPosition <> value then
  begin
    FProgressPosition := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetProgressTop(const Value: integer);
begin
  if FProgressTop <> value then
  begin
    FProgressTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetProgressValue(const Value: Double);
begin
  if FProgressValue <> value then
  begin
    FProgressValue := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetProgressVisible(const Value: Boolean);
begin
  if FProgressVisible <> value then
  begin
    FProgressVisible := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetProgressWidth(const Value: integer);
begin
  if FProgressWidth <> value then
  begin
    FProgressWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetSelected(const Value: Boolean);
begin
  if FSelected <> value then
  begin
    FSelected := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetSplitter(const Value: Boolean);
begin
  if FSplitter <> value then
  begin
    FSplitter := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItem.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TAdvSmoothListBoxItems }

function TAdvSmoothListBoxItems.Add: TAdvSmoothListBoxItem;
begin
  Result := TAdvSmoothListBoxItem(inherited Add);
end;

procedure TAdvSmoothListBoxItems.BeginUpdate;
begin
  inherited;
  Inc(FUpdateCount);
end;

procedure TAdvSmoothListBoxItems.Clear;
begin
  if Count > 0 then
  begin
    FOwner.FDisplayList.Clear;
    BeginUpdate;
    try
      while Count > 0 do
        TCollectionItem(Items[Count - 1]).Free;

      FOwner.SelectedItemIndex := -1;
    finally
      EndUpdate;
    end;
  end;
end;

function TAdvSmoothListBoxItems.Compare(Item1, Item2: TAdvSmoothListBoxItem): integer;
var
  cIdx1, cIdx2: integer;
begin
  Result := 0;
  case FOwner.CategoryType of
    alphanumeric:
    begin
      Result := AnsiCompareStr(item1.Caption, item2.Caption);
      {
      if item1.Caption < item2.Caption then
        result :=  -1
      else if item1.Caption > item2.Caption then
        result := 1
      else result := 0
      }
    end;
    custom:
    begin
      cIdx1 := FOwner.Categories.ItemIndexById(item1.CategoryID);
      cIdx2 := FOwner.Categories.ItemIndexById(item2.CategoryID);

      if cIdx1 < cIdx2 then
        result :=  -1
      else if cIdx1 > cIdx2 then
        result := 1
      else
      begin
        if item1.Caption < item2.Caption then
          result :=  -1
        else if item1.Caption > item2.Caption then
          result := 1
        else result := 0
      end;
    end;
  end;
end;

function TAdvSmoothListBoxItems.CountSelected: integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
    if Self[i].Selected then
      Inc(Result);
end;

constructor TAdvSmoothListBoxItems.Create(AOwner: TAdvSmoothListBox);
begin
  inherited Create(TAdvSmoothListBoxItem);
  FOwner := AOwner;
  FSelectedItem := nil;
end;

procedure TAdvSmoothListBoxItems.Delete(Index: Integer);
begin
  Items[Index].Free;
end;

procedure TAdvSmoothListBoxItems.EndUpdate;
begin    
  inherited;
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
  begin
    if Assigned(FOwner.FCurrentControl) then
      FOwner.FCurrentControl.Left := FOwner.width;
    FOwner.LookupBar.InitLookupBar;
    FOwner.InitDisplayList;
    FOwner.Changed;
  end;
end;

function TAdvSmoothListBoxItems.GetItem(Index: Integer): TAdvSmoothListBoxItem;
begin
  Result := TAdvSmoothListBoxItem(inherited Items[Index]);
end;

function TAdvSmoothListBoxItems.GetOwner: TPersistent;
begin
  Result := FOwner; 
end;

function TAdvSmoothListBoxItems.Insert(Index: Integer): TAdvSmoothListBoxItem;
begin
  Result := TAdvSmoothListBoxItem(inherited Insert(Index));
end;

procedure TAdvSmoothListBoxItems.QuickSort(L, R: Integer);
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

procedure TAdvSmoothListBoxItems.Select(AItems: Array of Integer);
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

procedure TAdvSmoothListBoxItems.SelectAll;
var
  i: integer;
begin
  BeginUpdate;
  for I := 0 to Count - 1 do
    Self[I].Selected := true;
  EndUpdate;
end;

procedure TAdvSmoothListBoxItems.SetItem(Index: Integer;
  const Value: TAdvSmoothListBoxItem);
begin
  inherited Items[Index] := Value;
end;

procedure TAdvSmoothListBoxItems.SetSelectedItem(
  const Value: TAdvSmoothListBoxItem);
var
  i, sh: integer;
begin
  if FSelectedItem <> value then
  begin
    with FOwner do
    begin
      FSelectedItem := Value;
      if Value <> nil then
      begin
        FFocusedItemIndex := Value.Index;
        FSelectedItemIndex := Value.Index;
      end
      else
      begin
        FFocusedItemIndex := Fowner.FSelectedItemIndex;
        FSelectedItemIndex := -1;
        Changed;
        Exit;
      end;

      sh := 0;
      if Sections.Visible then
        sh := FDisplayList.GetItem(0).ItemRect.Bottom - FDisplayList.GetItem(0).ItemRect.Top;

      FSelectedItemIndex := Min(Items.Count - 1, Max(0, FSelectedItemIndex));
      Items.SelectedItem := FItems[FSelectedItemIndex];
      for I := 0 to FDisplayList.Count - 1 do
      begin
        with FDisplayList.GetItem(i) do
        begin
          if DisplayItem <> nil then
          begin
            if DisplayItem.Index = FSelectedItemIndex then
            begin
              if ItemRect.Top - GetPosition > Height - Footer.GetHeight - (ItemRect.Bottom-ItemRect.Top) then
                FScPosTo := ItemRect.Bottom - (Height - Footer.GetHeight)
              else if ItemRect.Top < GetPosition + Header.GetHeight then
                FScPosTo := ItemRect.Top - Header.GetHeight - sh;

              if FScPosTo <> FCurrentScPos then
              begin
                FCurrentScPos := FScPosTo;
                ScrollIndicator.FAnimateOpacity := ScrollIndicator.Opacity;
                FAnimate := true;
              end;
            end;
          end;
        end;
      end;
      Changed;
    end;
  end;
end;

procedure TAdvSmoothListBoxItems.Sort;
begin
  if Count > 1 then
    QuickSort(0, pred(Count));

  FOwner.InitDisplayList;
  FOwner.Invalidate;
end;

procedure TAdvSmoothListBoxItems.UnSelectAll;
var
  i: integer;
begin
  BeginUpdate;
  for I := 0 to Count - 1 do
    Self[I].Selected := false;
  EndUpdate;
end;

{ TAdvSmoothListBoxItemAppearance }

procedure TAdvSmoothListBoxItemAppearance.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothListBoxItemAppearance then
  begin
    FSpacingVert := (Source as TAdvSmoothListBoxItemAppearance).VerticalSpacing;
    FSpacingHorz := (Source as TAdvSmoothListBoxItemAppearance).HorizontalSpacing;
    FItemHeight := (Source as TAdvSmoothListBoxItemAppearance).Height;
    FFill.Assign((Source as TAdvSmoothListBoxItemAppearance).Fill);
    FFillSelected.Assign((Source as TAdvSmoothListBoxItemAppearance).FillSelected);
    FFillDisabled.Assign((Source as TAdvSmoothListBoxItemAppearance).FillDisabled);
    FProgressAppearance.Assign((Source as TAdvSmoothListBoxItemAppearance).ProgressAppearance); 
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItemAppearance.ButtonAppearanceChanged(
  Sender: TObject);
begin
  FOwner.ItemAppearanceChanged(Self);
end;

procedure TAdvSmoothListBoxItemAppearance.Changed;
begin
  FOwner.ItemAppearanceChanged(Self);
end;

constructor TAdvSmoothListBoxItemAppearance.Create(AOwner: TAdvSmoothListBox);
begin
  Fowner := AOwner;
  FSpacingVert := 0;
  FSpacingHorz := 0;
  FItemHeight := 30;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FFillSelected := TGDIPFill.Create;
  FFillSelected.OnChange := FillChanged;
  FFillDisabled := TGDIPFill.Create;
  FFillDisabled.OnChange := FillChanged;
  FProgressAppearance := TGDIPProgress.Create;
  FProgressAppearance.OnChange := ProgressAppearanceChanged;
  FButtonAppearance := TGDIPButton.Create;
  FButtonAppearance.OnChange := ButtonAppearanceChanged;
end;

destructor TAdvSmoothListBoxItemAppearance.Destroy;
begin
  FFill.Free;
  FFillDisabled.Free;
  FFillSelected.Free;
  FProgressAppearance.Free;
  FButtonAppearance.Free;
  inherited;
end;

procedure TAdvSmoothListBoxItemAppearance.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothListBoxItemAppearance.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothListBoxItemAppearance.ProgressAppearanceChanged(
  Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothListBoxItemAppearance.SetButtonAppearance(
  const Value: TGDIPButton);
begin
  if FButtonAppearance <> value then
  begin
    FButtonAppearance.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItemAppearance.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItemAppearance.SetFillDisabled(
  const Value: TGDIPFill);
begin
  if FFillDisabled <> value then
  begin
    FFillDisabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItemAppearance.SetFillSelected(
  const Value: TGDIPFill);
begin
  if FFillSelected <> value then
  begin
    FFillSelected := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItemAppearance.SetItemHeight(const Value: integer);
begin
  if FItemHeight <> value then
  begin
    FItemHeight := Value;
    FOwner.InitDisplayList;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItemAppearance.SetProgressAppearance(
  const Value: TGDIPProgress);
begin
  if FProgressAppearance <> value then
  begin
    FProgressAppearance := Value;
    ProgressAppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothListBoxItemAppearance.SetSpacingHorz(const Value: integer);
begin
  if FSpacingHorz <> value then
  begin
    FSpacingHorz := Value;
    FOwner.InitDisplayList;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxItemAppearance.SetSpacingVert(const Value: integer);
begin
  if FSpacingVert <> value then
  begin
    FSpacingVert := Value;
    FOwner.InitDisplayList;    
    Changed;
  end;
end;

{ TAdvSmoothListBoxLookUpBar }

procedure TAdvSmoothListBoxLookUpBar.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothListBoxLookUpBar then
  begin
    FColor := (Source as TAdvSmoothListBoxLookUpBar).Color;
    FColorTo := (Source as TAdvSmoothListBoxLookUpBar).ColorTo;
    FOpacity := (Source as TAdvSmoothListBoxLookUpBar).Opacity;
    FOpacityTo := (Source as TAdvSmoothListBoxLookUpBar).OpacityTo;
    FNumeric := (Source as TAdvSmoothListBoxLookUpBar).Numeric;
    FVisible := (Source as TAdvSmoothListBoxLookUpBar).Visible;
    FPosition := (Source as TAdvSmoothListBoxLookUpBar).Position;
    FFont.Assign((Source as TAdvSmoothListBoxLookUpBar).Font);
    FDisabledFont.Assign((Source as TAdvSmoothListBoxLookUpBar).DisabledFont);
    FOnTop := (Source as TAdvSmoothListBoxLookUpBar).OnTop;
    FGradientType := (Source as TAdvSmoothListBoxLookUpBar).GradientType;
    FHatchStyle := (Source as TAdvSmoothListBoxLookUpBar).HatchStyle;
    FSpacing := (Source as TAdvSmoothListBoxLookUpBar).Spacing;
    FRotated := (Source as TAdvSmoothListBoxLookUpBar).Rotated;
    FAutoSize := (Source as TAdvSmoothListBoxLookUpBar).AutoSize;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.Changed;
begin
  FOwner.LookupBarChanged(self);
end;

constructor TAdvSmoothListBoxLookUpBar.Create(AOwner: TAdvSmoothListBox);
begin
  FOwner := AOwner;
  FSpacing := 3;
  FRotated := false;
  FAutoSize := true;
  Fcolor := clWhite;
  FColorTo := clWhite;
  FGradientType := gtSolid;
  FHatchStyle := HatchStyleHorizontal;
  FOnTop := false;
  FOpacity := 100;
  FOpacityTo := 100;
  FNumeric := false;
  FVisible := true;
  FPosition := pRight;
  FFont := TFont.Create;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}
  FFont.OnChange := FontChanged;
  FDisabledFont := TFont.Create;
  FDisabledFont.Color := clSilver;
  {$IFNDEF DELPHI9_LVL}
  FDisabledFont.Name := 'Tahoma';
  {$ENDIF}
  FDisabledFont.OnChange := FontChanged;
end;

destructor TAdvSmoothListBoxLookUpBar.Destroy;
begin
  Font.Free;
  DisabledFont.Free;
  inherited;
end;

procedure TAdvSmoothListBoxLookUpBar.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothListBoxLookUpBar.GetWidth: integer;
var
  c: TCanvas;
begin
  Result := 0;
  if Visible then
  begin
    c := TCanvas.Create;
    c.handle := Fowner.Canvas.Handle;
    c.Font.Assign(Font);
    case Fowner.CategoryType of
      alphanumeric: Result := c.TextWidth('W') + 4;
      custom: result := Fowner.GetMaximumCustomTextWidth(c);
    end;
   c.Free;    
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.InitLookupBar;
var
  I, j: Integer;
  s: String;

begin
  case Fowner.CategoryType of
    alphanumeric:
    begin
      for I := 1 to 36 do
        FChar[I] := false;

      for I := 0 to FOwner.Items.Count - 1 do
      begin
        with FOwner.Items[I] do
        begin
          S := AnsiUpperCase(Caption);
          if not Splitter and (S <> '') then
          begin
            if (Ord(s[1]) <= 90) then
            begin
              j := Ord(s[1]) - 64;
              if (j < 27) and (J > 0) then
                FChar[j] := true
              else
              begin
                j := Ord(s[1]) - 48;
                if (j < 10) and (j >= 0) then
                begin
                  FChar[27 + j] := true
                end;
              end;
            end
            else
            begin
              if (AnsiCompareStr('A',S) < 0) and (AnsiCompareStr('B',S) > 0) then
                FChar[1] := true
              else
              if (AnsiCompareStr('C',S) < 0) and (AnsiCompareStr('D',S) > 0) then
                FChar[3] := true
              else
              if (AnsiCompareStr('E',S) < 0) and (AnsiCompareStr('F',S) > 0) then
                FChar[5] := true
              else
              if (AnsiCompareStr('G',S) < 0) and (AnsiCompareStr('H',S) > 0) then
                FChar[7] := true
              else
              if (AnsiCompareStr('H',S) < 0) and (AnsiCompareStr('I',S) > 0) then
                FChar[8] := true
              else
              if (AnsiCompareStr('I',S) < 0) and (AnsiCompareStr('J',S) > 0) then
                FChar[9] := true
              else
              if (AnsiCompareStr('J',S) < 0) and (AnsiCompareStr('K',S) > 0) then
                FChar[10] := true
              else
              if (AnsiCompareStr('K',S) < 0) and (AnsiCompareStr('L',S) > 0) then
                FChar[11] := true
              else
              if (AnsiCompareStr('L',S) < 0) and (AnsiCompareStr('M',S) > 0) then
                FChar[12] := true
              else
              if (AnsiCompareStr('N',S) < 0) and (AnsiCompareStr('N',S) > 0) then
                FChar[14] := true
              else
              if (AnsiCompareStr('O',S) < 0) and (AnsiCompareStr('P',S) > 0) then
                FChar[15] := true
              else
              if (AnsiCompareStr('P',S) < 0) and (AnsiCompareStr('Q',S) > 0) then
                FChar[16] := true
              else
              if (AnsiCompareStr('R',S) < 0) and (AnsiCompareStr('S',S) > 0) then
                FChar[18] := true
              else
              if (AnsiCompareStr('S',S) < 0) and (AnsiCompareStr('T',S) > 0) then
                FChar[19] := true
              else
              if (AnsiCompareStr('T',S) < 0) and (AnsiCompareStr('U',S) > 0) then
                FChar[20] := true
              else
              if (AnsiCompareStr('U',S) < 0) and (AnsiCompareStr('V',S) > 0) then
                FChar[21] := true
              else
              if (AnsiCompareStr('W',S) < 0) and (AnsiCompareStr('X',S) > 0) then
                FChar[22] := true
              else
              if (AnsiCompareStr('Z',S) < 0) then
                FChar[26] := true
            end;
          end;
        end;
      end;
    end;
    custom:
    begin
      for I := 0 to Fowner.Categories.Count - 1 do
      begin
        SetLength(FCustomChar, I + 1);
        FCustomChar[I] := false;
      end;

      for I := 0 to Fowner.Items.Count - 1 do
      begin
        with Fowner.Items[I] do
        begin
          S := Caption;
          if not Splitter and (S <> '') then
          begin
            j := CategoryID;
            if (j < FOwner.Categories.Count) and (J > -1) then
              FCustomChar[j] := true
          end;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize <> value then
  begin
    FAutoSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetColor(const Value: TColor);
begin
  if FColor <> value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetColorTo(const Value: TColor);
begin
  if FColorTo <> value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetDisabledFont(const Value: TFont);
begin
  if FDisabledFont <> value then
  begin
    FDisabledFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetGradientType(
  const Value: TAdvGradientType);
begin
  if FGradientType <> value then
  begin
    FGradientType := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetHatchStyle(const Value: THatchStyle);
begin
  if FHatchStyle <> value then
  begin
    FHatchStyle := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetNumeric(const Value: Boolean);
begin
  if FNumeric <> value then
  begin
    FNumeric := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetOnTop(const Value: Boolean);
begin
  if FOnTop <> value then
  begin
    FOnTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetOpacity(const Value: Byte);
begin
  if FOpacity <> value then
  begin
    FOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetOpacityTo(const Value: Byte);
begin
  if FOpacityTo <> value then
  begin
    FOpacityTo := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetPosition(
  const Value: TAdvSmoothListBoxLookUpBarPosition);
begin
  if FPosition <> value then
  begin
    FPosition := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetRotated(const Value: Boolean);
begin
  if FRotated <> value then
  begin
    FRotated := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetSpacing(const Value: integer);
begin
  if FSpacing <> value then
  begin
    FSpacing := Value;
    if FOwner.FItems.FUpdateCount = 0 then
    begin
      if Assigned(FOwner.FCurrentControl) then
        FOwner.FCurrentControl.Left := FOwner.width;
      InitLookupBar;
      FOwner.InitDisplayList;
      Changed;
    end;
  end;
end;

procedure TAdvSmoothListBoxLookUpBar.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TAdvSmoothListBoxSections }

procedure TAdvSmoothListBoxSections.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothListBoxSections then
  begin
    FFont.Assign((Source as TAdvSmoothListBoxSections).Font);
    FVisible := (Source as TAdvSmoothListBoxSections).Visible;
    FGradientType := (Source as TAdvSmoothListBoxSections).GradientType;
    FHatchStyle := (Source as TAdvSmoothListBoxSections).HatchStyle;
    FBorderColor := (Source as TAdvSmoothListBoxSections).BorderColor;
    FColor := (Source as TAdvSmoothListBoxSections).Color;
    FColorTo := (Source as TAdvSmoothListBoxSections).ColorTo;
    FOpacity := (Source as TAdvSmoothListBoxSections).Opacity;
    FOpacityTo := (Source as TAdvSmoothListBoxSections).OpacityTo;
    FBorderWidth := (Source as TAdvSmoothListBoxSections).BorderWidth;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxSections.CategoriesChanged(Sender: TObject);
begin
  FOwner.Changed;
end;

procedure TAdvSmoothListBoxSections.Changed;
begin
  FOwner.SectionsChanged(self);
end;

constructor TAdvSmoothListBoxSections.Create(AOwner: TAdvSmoothListBox);
begin
  FOwner := AOwner;
  FBorderWidth := 1;
  FFont := TFont.Create;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}  
  FFont.OnChange := FontChanged;
  FVisible := false;
  FGradientType := gtSolid;
  FHatchStyle := HatchStyleHorizontal;
  FOpacity := 180;
  FOpacityTo := 180;
  FColor := clWhite;
  FColorTo := clSilver;
  FCategoryType := alphanumeric;
  FCategories := TAdvSmoothListBoxCategoryItems.Create(AOwner);
  FCategories.OnChange := CategoriesChanged;
end;

destructor TAdvSmoothListBoxSections.Destroy;
begin
  FFont.Free;
  FCategories.free;
  inherited;
end;

procedure TAdvSmoothListBoxSections.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothListBoxSections.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxSections.SetBorderWidth(const Value: integer);
begin
  if FBorderWidth <> value then
  begin
    FBorderWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxSections.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxSections.SetColorTo(const Value: TColor);
begin
  if FColorTo <> Value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxSections.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBoxSections.SetGradientType(
  const Value: TAdvGradientType);
begin
  if FGradientType <> value then
  begin
    FGradientType := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxSections.SetHatchStyle(const Value: THatchStyle);
begin
  if FHatchStyle <> Value then
  begin
    FHatchStyle := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxSections.SetOpacity(const Value: Byte);
begin
  if FOpacity <> value then
  begin
    FOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxSections.SetOpacityTo(const Value: Byte);
begin
  if FOpacityTo <> value then
  begin
    FOpacityTo := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxSections.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TAdvSmoothListBoxDisplayList }

procedure TAdvSmoothListBoxDisplayListItem.Changed;
begin
//  Fowner.InitDisplayList;
end;

procedure TAdvSmoothListBoxDisplayListItem.SetFloating(const Value: Boolean);
begin
  if FFloating <> Value then
  begin
    FFloating := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxDisplayListItem.SetKind(
  const Value: TAdvSmoothListBoxItemKind);
begin
  if FKind <> value then
  begin
    FKind := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxDisplayListItem.SetSectionCaption(
  const Value: String);
begin
  if FSectionCaption <> value then
  begin
    FSectionCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxDisplayListItem.SetSectionCategoryID(
  const Value: integer);
begin
  if FSectionCategoryID <> value then
  begin
    FSectionCategoryID := Value;
    Changed;
  end;
end;

{ TAdvSmoothListBoxDisplayList }

function TAdvSmoothListBoxDisplayList.AddItem: TAdvSmoothListBoxDisplayListItem;
begin
  result := TAdvSmoothListBoxDisplayListItem.Create;
  add(result);
end;

procedure TAdvSmoothListBoxDisplayList.Clear;
var
  i: integer;
begin
  for i := Count - 1 downto 0 do
    TAdvSmoothListBoxDisplayListItem(Items[i]).Free;
  inherited;
end;

procedure TAdvSmoothListBoxDisplayList.DeleteItem(index: integer);
begin
  TAdvSmoothListBoxDisplayListItem(Items[Index]).Free;
  Delete(index);
end;

function TAdvSmoothListBoxDisplayList.GetItem(index: integer): TAdvSmoothListBoxDisplayListItem;
begin
  if Index >= Count then
    Index := Count - 1;
    
  Result := TAdvSmoothListBoxDisplayListItem(Items[Index]);
end;

{ TAdvSmoothListBoxHeader }

procedure TAdvSmoothListBoxHeaderFooter.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothListBoxHeaderFooter then
  begin
    FHeight := (Source as TAdvSmoothListBoxHeaderFooter).Height;
    FCaptionLocation := (Source as TAdvSmoothListBoxHeaderFooter).CaptionLocation;
    FCaptionURLColor := (Source as TAdvSmoothListBoxHeaderFooter).CaptionURLColor;
    FCaptionShadowColor := (Source as TAdvSmoothListBoxHeaderFooter).CaptionShadowColor;
    FCaptionShadowOffset := (Source as TAdvSmoothListBoxHeaderFooter).CaptionShadowOffset;
    FCaption := (Source as TAdvSmoothListBoxHeaderFooter).Caption;
    FFont.Assign((Source as TAdvSmoothListBoxHeaderFooter).Font);
    FVisible := (Source as TAdvSmoothListBoxHeaderFooter).Visible;
    FCaptionLeft := (Source as TAdvSmoothListBoxHeaderFooter).CaptionLeft;
    FCaptionTop := (Source as TAdvSmoothListBoxHeaderFooter).CaptionTop;
    FFill.Assign((Source as TAdvSmoothListBoxHeaderFooter).Fill);
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.Changed;
begin
  Fowner.HeaderFooterChanged(Self);
end;

constructor TAdvSmoothListBoxHeaderFooter.Create(AOwner: TAdvSmoothListBox);
begin
  FOwner := AOwner;
  FHeight := 40;
  FCaptionLocation := cpCenterCenter;
  FCaptionShadowColor := clGray;
  FCaptionURLColor := clBlue;
  FCaptionShadowOffset := 5;
  FCaption := '';
  FFont := TFont.Create;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}  
  FFont.OnChange := FontChanged;
  FVisible := true;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FCaptionLeft := 0;
  FCaptionTop := 0;
end;

destructor TAdvSmoothListBoxHeaderFooter.Destroy;
begin
  FFont.Free;
  FFill.Free;
  inherited;
end;

procedure TAdvSmoothListBoxHeaderFooter.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothListBoxHeaderFooter.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothListBoxHeaderFooter.GetAnchorAt(r: TRect; X, Y: integer): String;
var
  a, s, k: String;
  g: TGPGraphics;
  XSize, YSize: integer;
  l, m: integer;
  hr: TRect;
begin
  Result := '';
  if PtInRect(r, Point(X, Y)) then
  begin
    g := TGPGraphics.Create(Fowner.Canvas.Handle);

    HTMLDrawGDIP(g, Font, Caption ,r,Fowner.FImages, X,Y,-1,-1,CaptionShadowOffset,true,false,false,false,
      False,False,true,1.0,CaptionURLColor,clNone,clNone,CaptionShadowColor,a,s,k,XSize,YSize,l,m,hr,nil, FOwner.FContainer,2);

    result := a;

    g.Free;
  end;
end;

function TAdvSmoothListBoxHeaderFooter.GetHeight: integer;
var
  hb: integer;
begin
  hb := 0;
  if Fill.BorderColor <> clNone then
    hb := Fill.BorderWidth;

  if Visible then
    Result := Height + hb
  else
    Result := 0;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetCaption(const Value: String);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetCaptionLeft(const Value: integer);
begin
  if FCaptionLeft <> Value then
  begin
    FCaptionLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetCaptionLocation(
  const Value: TAdvSmoothListBoxCaptionLocation);
begin
  if FCaptionLocation <> value then
  begin
    FCaptionLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetCaptionShadowColor(
  const Value: TColor);
begin
  if FCaptionShadowColor <> value then
  begin
    FCaptionShadowColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetCaptionShadowOffset(
  const Value: integer);
begin
  if FCaptionShadowOffset <> value then
  begin
    FCaptionShadowOffset := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetCaptionTop(const Value: integer);
begin
  if FCaptionTop <> value then
  begin
    FCaptionTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetCaptionURLColor(const Value: TColor);
begin
  if FCaptionURLColor <> value then
  begin
    FCaptionURLColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetHeight(const Value: integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    FOwner.InitDisplayList;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxHeaderFooter.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    FOwner.InitDisplayList;
    Changed;
  end;
end;

{ TAdvSmoothListBoxIndicator }

procedure TAdvSmoothListBoxIndicator.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothListBoxIndicator then
  begin
    FVisible := (Source as TAdvSmoothListBoxIndicator).Visible;
    FColor := (Source as TAdvSmoothListBoxIndicator).Color;
    FColorTo := (Source as TAdvSmoothListBoxIndicator).ColorTo;
    FOpacity := (Source as TAdvSmoothListBoxIndicator).Opacity;
    FGradientType := (Source as TAdvSmoothListBoxIndicator).GradientType;
    FHatchStyle := (Source as TAdvSmoothListBoxIndicator).HatchStyle;
    FFade := (Source as TAdvSmoothListBoxIndicator).Fade;
    FWidth := (Source as TAdvSmoothListBoxIndicator).Width;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxIndicator.Changed;
begin
  FOwner.ScrollIndicatorChanged(Self);
end;

constructor TAdvSmoothListBoxIndicator.Create(AOwner: TAdvSmoothListBox);
begin
  FAnimateOpacity := 0;
  FOwner := AOwner;
  Fvisible := true;
  FColor := clBlack;
  FColorTo := clDkGray;
  FOpacity := 100;
  FGradientType := gtSolid;
  FHatchStyle := HatchStyleHorizontal;
  FWidth := 5;
  FHeight := 60;
  FFade := true;
end;

destructor TAdvSmoothListBoxIndicator.Destroy;
begin
  inherited;
end;

function TAdvSmoothListBoxIndicator.GetAnimationOpacity: Byte;
begin
  if FOwner.FAnimate and FFade then
    result := FAnimateOpacity
  else
    result := FOpacity;
end;

function TAdvSmoothListBoxIndicator.GetWidth: integer;
begin
  Result := 0;
  if Visible then
    Result := Width;
end;

procedure TAdvSmoothListBoxIndicator.SetColor(const Value: TColor);
begin
  if FColor <> value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxIndicator.SetColorTo(const Value: TColor);
begin
  if FColorTo <> value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxIndicator.SetFade(const Value: Boolean);
begin
  if FFade <> value then
  begin
    FFade := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxIndicator.SetGradientType(
  const Value: TAdvGradientType);
begin
  if FGradientType <> value then
  begin
    FGradientType := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxIndicator.SetHatchStyle(const Value: THatchStyle);
begin
  if FHatchStyle <> value then
  begin
    FHatchStyle := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxIndicator.SetOpacity(const Value: Byte);
begin
  if FOpacity <> value then
  begin
    FOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxIndicator.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxIndicator.Setwidth(const Value: integer);
begin
  if FWidth <> value then
  begin
    FWidth := Value;
    Changed;
  end;
end;

{ TAdvSmoothListBoxCategoryItem }

procedure TAdvSmoothListBoxCategoryItem.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothListBoxCategoryItem) then
  begin
    FText := (Source as TAdvSmoothListBoxCategoryItem).Text;
    FLookupText := (Source as TAdvSmoothListBoxCategoryItem).LookupText;
    FId := (Source as TAdvSmoothListBoxCategoryItem).Id;
    FImageIndex := (Source as TAdvSmoothListBoxCategoryItem).ImageIndex;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxCategoryItem.Changed;
begin
  with FOwner do
  begin
    if FItems.FUpdateCount = 0 then
    begin
      if Assigned(FOwner.FCurrentControl) then
        FCurrentControl.Left := FOwner.Width;
      LookupBar.InitLookupBar;
      InitDisplayList;
      Changed;
    end;
  end;
end;

constructor TAdvSmoothListBoxCategoryItem.Create(Collection: TCollection);
begin
  inherited;
  Fowner := (Collection as TAdvSmoothListBoxCategoryItems).FOwner;
  FID := (Collection as TAdvSmoothListBoxCategoryItems).Count - 1;
  FImageIndex := -1;
  with FOwner do
  begin
    if FItems.FUpdateCount = 0 then
    begin
      if Assigned(FCurrentControl) then
        FCurrentControl.Left := FOwner.width;
      LookupBar.InitLookupBar;
      InitDisplayList;
      Changed;
    end;
  end;  
end;

destructor TAdvSmoothListBoxCategoryItem.Destroy;
begin
  inherited;
  with FOwner do
  begin
    if FItems.FUpdateCount = 0 then
    begin
      if Assigned(FCurrentControl) then
        FCurrentControl.Left := FOwner.width;
      LookupBar.InitLookupBar;
      InitDisplayList;
      Changed;
    end;
  end;
end;

procedure TAdvSmoothListBoxCategoryItem.SetId(const Value: integer);
begin
  if FId <> value then
  begin
    FId := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxCategoryItem.SetImageIndex(const Value: integer);
begin
  if FImageIndex <> value then
  begin
    FImageIndex := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxCategoryItem.SetLookupText(const Value: String);
begin
  if FLookupText <> value then
  begin
    FLookupText := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxCategoryItem.SetTag(const Value: integer);
begin
  if FTag <> value then
  begin
    FTag := Value;
    Changed;
  end;
end;

procedure TAdvSmoothListBoxCategoryItem.SetText(const Value: String);
begin
  if FText <> value then
  begin
    FText := Value;
    Changed;
  end;
end;

{ TAdvSmoothListBoxCategoryItems }

function TAdvSmoothListBoxCategoryItems.Add: TAdvSmoothListBoxCategoryItem;
begin
  Result := TAdvSmoothListBoxCategoryItem(inherited Add);
end;

procedure TAdvSmoothListBoxCategoryItems.Clear;
begin
  if Count > 0 then
  begin
    while Count > 0 do
      TCollectionItem(Items[Count - 1]).Free;
  end;
end;

function TAdvSmoothListBoxCategoryItems.Compare(Item1,
  Item2: TAdvSmoothListBoxCategoryItem): integer;
begin
  if item1.Text < item2.Text then
    result :=  -1
  else if item1.Text > item2.Text then
    result := 1
  else result := 0;
end;

constructor TAdvSmoothListBoxCategoryItems.Create(AOwner: TAdvSmoothListBox);
begin
  inherited Create(TAdvSmoothListBoxCategoryItem);
  FOwner := AOwner;
end;

procedure TAdvSmoothListBoxCategoryItems.Delete(Index: Integer);
begin
  Items[Index].Free;
end;

function TAdvSmoothListBoxCategoryItems.GetItem(
  Index: Integer): TAdvSmoothListBoxCategoryItem;
begin
  Result := TAdvSmoothListBoxCategoryItem(inherited Items[Index]);
end;

function TAdvSmoothListBoxCategoryItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TAdvSmoothListBoxCategoryItems.Insert(
  Index: Integer): TAdvSmoothListBoxCategoryItem;
begin
  Result := TAdvSmoothListBoxCategoryItem(inherited Insert(Index));
end;

function TAdvSmoothListBoxCategoryItems.ItemById(
  id: integer): TAdvSmoothListBoxCategoryItem;
var
  i: integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
  begin
    Result := Items[I];
    if Result.ID = id then
      break;
  end;
end;

function TAdvSmoothListBoxCategoryItems.ItemIndexByID(id: integer): integer;
var
  ci: TAdvSmoothListBoxCategoryItem;
begin
  ci := ItemByID(id);
  if Assigned(ci) then
    result := ci.Index
  else
    result := -1;
end;

procedure TAdvSmoothListBoxCategoryItems.QuickSort(L, R: Integer);
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

procedure TAdvSmoothListBoxCategoryItems.SetItem(Index: Integer;
  const Value: TAdvSmoothListBoxCategoryItem);
begin
  inherited Items[Index] := Value;
end;

procedure TAdvSmoothListBoxCategoryItems.Sort;
begin
  if Count > 1 then
    QuickSort(0, pred(Count));

  Fowner.LookupBar.InitLookupBar;
  FOwner.Invalidate;
end;


{ TWinCtrl }

procedure TWinCtrl.PaintCtrls(DC: HDC; First: TControl);
begin
  PaintControls(DC, First);
end;

end.

