{***************************************************************************}
{ TAdvMemo component                                                        }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2001 - 2009                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of TMS software.                                    }
{***************************************************************************}

{$I TMSDEFS.INC}

unit AdvMemo;                                                 

{$IFDEF TMSDOTNET} 
{$R AdvMemo.Resources}
{$ENDIF}                                               

{$IFNDEF TMSDOTNET}
{$R AdvMemo.res}
{$ENDIF}

//{$DEFINE TMSCLX}

interface

{$DEFINE BLINK}

uses
  Classes, SysUtils, Math, IniFiles, RTFEngine, AdvStyleIF,
{$IFDEF DELPHI6_LVL}
  Types,
{$ENDIF}
{$IFDEF TMSCLX}
  Qt, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QComCtrls, QPrinters, QActnList,
  AdvMemoCaret
{$ENDIF}
{$IFNDEF TMSCLX}
  Windows, Messages, Graphics, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Printers, ActnList
{$IFNDEF TMSDOTNET}
  , Controls
{$ENDIF}

{$IFDEF TMSDOTNET}
  , StrUtils, Borland.Vcl.Controls, System.Text, uxTheme
{$ENDIF}
{$ENDIF}
  ;

const
  MAJ_VER = 2; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 7; // Release nr.
  BLD_VER = 11; // Build nr.
  DATE_VER = 'Apr, 2009'; // Month version

{$IFDEF TMSDOTNET}
  ResourceBaseName = 'AdvMemo';
{$ENDIF}

  // version history
  // 1.6.0.8  : fixed Delphi 2005 issue with autocompletion showing
  // 1.6.0.9  : fixed handling of underscores in lookup
  // 1.6.0.10 : fixed Delete action & Redo action
  //          : fixed ActiveLineAtCursor behaviour with mouse clicks
  // 1.6.0.11 : scroll handling with wordwrap memo improved
  // 1.6.0.12 : improved scroll handling when click on partially visible last row
  // 1.6.0.13 : improved autocompletion handling with dot in procedures
  // 1.6.0.14 : fix with bookmarks for line insert/remove
  // 1.6.0.15 : fix for memosource line inserts
  // 1.6.0.16 : fix for highlighting whole words
  // 1.6.0.17 : fix for SetFocus handling
  // 1.6.0.18 : fix for SetBreakPoint, SetBookMark
  // 1.6.0.19 : improved behaviour of next/previous word
  // 1.6.0.20 : improved handling of backspace key with wordwrap
  // 1.6.1.0  : New FindAndReplace method added
  // 1.6.1.1  : Fixed issue with setting selection
  // 1.6.1.2  : Fixed issue with memochecker use combined with memosource
  // 1.6.1.3  : Fixed issue with return key handling on dialogs with default buttons
  // 1.6.1.4  : Fixed issue with Memo.Lines.AddStrings
  // 1.7.0.0  : RTF export
  // 1.7.0.1  : Wordwrap painting improvement
  // 2.0.0.0  : New Code folding support
  //          : OnGutterDblClick event added
  //          : Fixed issue with Delete,Backspace key and MemoSource
  //          : Fixed issue with selection & clipboard
  // 2.0.0.1  : Fixed issue with autocompletion position in Delphi 2005, 2006
  // 2.0.0.2  : Fixed issue with StylerManager font saving
  // 2.0.0.3  : Improvement for backspace key handling
  // 2.0.1.0  : New TIndentUndo class and AddUndoStep public method
  // 2.0.1.1  : Fix for memo checker on empty memo
  //          : Fix for Ctrl-Backspace for delete word for first word of line
  //          : Added CloseDialog method in AdvMemoFindDialog, AdvMemoReplaceDialog
  // 2.0.1.2  : Added properties FocusMemo to TAdvMemoFindDialog, TAdvMemoReplaceDialog
  //          : Fixed issues with Shift tab with use with MemoSource
  // 2.1.0.0  : New Style interface added
  //          : New Office 2007 Luna & Obsidian styles added
  // 2.1.0.3  : Improved property setting for ShowActiveLine
  // 2.1.0.4  : Fixed issue with underscore drawing for italic fonts
  //          : Fixed issue with wwRightMargin wordwrap mode
  // 2.1.0.5  : Fixed issue with block delete & Undo
  //          : Improved autocompletion
  // 2.1.0.6  : Fixed issue with hint parameters & codefolding
  // 2.1.0.7  : Fixed issue with SaveToHTML, SaveToRTF
  // 2.1.0.8  : Fixed issue with autocompletion in empty memo
  // 2.1.0.9  : Fixed memory leak issue with undolist
  // 2.1.1.0  : New : support for Office2007 silver style added
  // 2.1.2.0  : New : support for autocorrect on words followed by [, (, =
  // 2.1.2.1  : Fixed : issue with Undo for Paste action
  // 2.1.2.2  : Fixed : issue with Find&Replace dialog
  // 2.1.2.3  : Fixed : issue with autocompletion
  // 2.1.2.4  : Improved : ActiveLine show with wordwrapping enabled
  //          : Improved : smarttabs behaviour with backspace key
  //          : Fixed : issue with copy & paste in VCL.NET
  // 2.1.2.5  : Fixed : issue with DeleteSelection for ReadOnly memo
  // 2.1.2.6  : Fixed : issue with codefolding & mousewheel handling
  // 2.1.2.7  : Fixed : issue with Ctrl-End, Ctrl-Home selection
  //          : Improved : PageUp/PageDn scroll behaviour
  // 2.1.3.0  : New : C++Builder support added
  // 2.1.3.1  : New : public property ClearType added
  //          : Fixed : issue with setting TopLine when VisibleLineCount > LinesCount
  // 2.1.3.2  : Improved : GetSelText speed improvement for older Delphi versions
  // 2.1.3.3  : Improved : Faster Lines.LoadFromStream, Lines.Text access
  // 2.1.3.4  : Fixed : autoindent issue
  //          : Fixed : issue with backspace and AutoExpand = false
  // 2.1.3.5  : Fixed : issue with Undo & Modified with spell check
  // 2.1.3.6  : Fixed : issue with Enter in empty memo
  // 2.1.3.7  : Fixed : issue with adding multiline text via Memo.Lines.Add()
  // 2.1.3.8  : Fixed : issue with Paste Undo
  // 2.1.3.9  : Fixed : issue with autocompletion after '.'
  // 2.1.3.10 : Fixed : issue with delete char Undo
  // 2.1.3.11 : Fixed : issue with Lines.AddObject()
  // 2.1.3.12 : Improved : redraw in TDBAdvMemo
  // 2.1.3.13 : Fixed : issue with ClearModified
  // 2.1.3.14 : Fixed : issue with scrollbar handling
  // 2.1.3.15 : Fixed : issue with pasting multiline text in empty memo
  // 2.1.3.16 : Fixed : issue with paste on non expanded line
  // 2.1.3.17 : Fixed : issue with repainting after RemoveAllCodeFolding
  // 2.1.3.18 : Fixed : issue with pasting into an empty memo
  // 2.1.3.19 : Fixed : issue with TrimTrailingSpaces = false
  // 2.1.3.20 : Fixed : issue in Delphi 5 with inserting lines
  // 2.1.4.0  : Improved : block marking for try ...catch, case.. blocks in Pascal
  // 2.1.4.1  : Fixed : issue with scrollbar animation on Windows Vista
  // 2.1.4.2  : Fixed : gutter painting update when setting Modified = false programmatically
  //          : Improved : behaviour with SmartTabs = true
  // 2.1.5.0  : New : method SaveToRTFStream added
  //          : Improved : autocompletion list updating while typing
  // 2.1.5.1  : Improved : fix for destroying memo from some memo events
  // 2.1.5.2  : Improved : cursor handling during mousewheel actions
  // 2.1.5.3  : Improved : node expand/collaps in scrolled memo
  // 2.1.5.4  : Fixed : issue with getting correct bracket style of top line
  // 2.1.5.5  : Fixed : issue with Undo after Select-All/Cut
  // 2.1.5.6  : Fixed : issue with AdvMemoSource Assign (when no memo connected)
  //          : Improved : handling of stBracket type ending with #32
  // 2.1.6.0  : New : function PrintSelection added
  // 2.1.6.1  : Fixed : memory leak issue with wordwrap
  // 2.1.6.2  : Fixed : small issue with cursor position handling for wordwrapped memo
  // 2.1.7.0  : Improved : exposed VisiblePosCount as public property
  // 2.1.7.1  : Fixed : NumberOfPages bug when MemoSource is used
  // 2.1.7.2  : Improved : scrolling in memo when ActiveLine property is set
  // 2.1.7.3  : Fixed : issue with backspace & selection
  // 2.1.7.4  : Fixed : issue with input of unicode characters
  // 2.1.7.5  : Fixed : issue with paste after delete in specific circumstances
  // 2.1.7.6  : Fixed : issue with horiz. scrollbar updating
  // 2.1.7.7  : Improved : undo/redo shortcuts displayed in context menu
  // 2.1.7.8  : Fixed : Undo issue for line delete
  //          : Fixed : bookmark issue when lines are removed from memo
  // 2.1.7.9  : Fixed : issue with mouse wheel handling
  // 2.1.7.10 : Fixed : issue with Undo & line delete in specific circumstances
  // 2.1.7.11 : Improved : OnStatusChange triggered when INS key is pressed  

type
  TBorderType = (btRaised, btLowered, btFlatRaised, btFlatLowered);
  TStyleType = (stKeyword, stBracket, stSymbol);

  TAdvMemoStyle = (msOffice2003Blue, msOffice2003Olive, msOffice2003Silver, msOffice2003Classic, msOffice2007Luna, msOffice2007Obsidian, msWindowsXP, msWhidbey, msCustom, msOffice2007Silver);

  TTokenType = (ttNone, ttVar, ttProp, ttEvent, ttMethod, ttFunc, ttProc);

  TAutoHintParameters = (hpAuto, hpManual, hpNone);
  TAutoHintParameterPosition = (hpBelowCode, hpAboveCode);

  TRegionType = (rtOpen, rtClosed, rtFile, rtIgnore);

  TAllowEvent = procedure(Sender: TObject; var Allow: Boolean) of object;

  TAdvMemoFileDropEvent = procedure(Sender: TObject; FileName: string;
    var DefaultHandler: Boolean) of object;

  TAdvMemoScrollHintEvent = procedure (Sender:TObject; ARow: Integer;var hintstr:string) of object;

  TCommand = Integer;

  TCellSize = record
    W, H: integer;
  end;

  TCellPos = record
    X, Y: integer;
  end;

  TFullPos = record
    LineNo, Pos: integer;
  end;

  TStyle = record
    isComment,
    isBracket,
    isnumber,
    iskeyWord,
    isdelimiter,
    isURL: boolean;
    EndBracket: char;
    StartBracket: char;
    index: integer;
  end;

  TAdvAutoform = class(TForm)
  protected
    // make it possible to size the form at runtime.
{$IFNDEF TMSCLX}
    procedure CreateParams(var Params: TCreateParams); override;
{$ENDIF}
  public
  end;

  TAdvHintForm = class(TForm)
  protected
    procedure Paint; override;
{$IFNDEF TMSCLX}
    procedure CreateParams(var Params: TCreateParams); override;
{$ENDIF}
  public
    part1, part2, part3: string;
    Active: Byte;
  end;

  //--------------------------------------------------------------
  TIntList = class(TList)
  private
    procedure SetInteger(Index: Integer; Value: Integer);
    function GetInteger(Index: Integer): Integer;
  public
    constructor Create;
    function IndexOf(Value: integer): Integer;
    property Items[index: Integer]: Integer read GetInteger write SetInteger; default;
    procedure Add(Value: integer);
    procedure Insert(Index, Value: integer);
    procedure Delete(Index: Integer);
  end;

  TAutoCompletionListBox = class(TListBox)
  private
    FBmpVar: TBitmap;
    FBmpProp: TBitmap;
    FBmpEvent: TBitmap;
    FBmpProc: TBitmap;
    FBmpMethod: TBitmap;
    FShowImages: Boolean;
    FImages: TImageList;
    FColorVar: TColor;
    FColorProp: TColor;
    FColorIdentifier: TColor;
    FColorFunc: TColor;
    FColorEvent: TColor;
    FColorProc: TColor;
    FColorMethod: TColor;
    FIdentifierWidth: Integer;
    procedure SetImages(IL: TImageList);
  protected
{$IFNDEF TMSCLX}
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
{$ENDIF}
{$IFDEF TMSCLX}
    function DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState): Boolean; override;
{$ENDIF}
    property IdentifierWidth: Integer read FIdentifierWidth;
  public
    function AutoAdaptWidth: Integer;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ImageList: TImageList read FImages write SetImages;
  published
    property ShowImages: Boolean read FShowImages write FShowImages default false;
    property ColorVar: TColor read FColorVar write FColorVar;
    property ColorProp: TColor read FColorProp write FColorProp;
    property ColorEvent: TColor read FColorEvent write FColorEvent;
    property ColorMethod: TColor read FColorMethod write FColorMethod;
    property ColorFunc: TColor read FColorFunc write FColorFunc;
    property ColorProc: TColor read FColorProc write FColorProc;
    property ColorIdentifier: TColor read FColorIdentifier write FColorIdentifier;
  end;

  TLineProp = class
  private
    FObject: TObject;
    FErrStart: TIntList;
    FErrLen: TIntList;
    FExpanded: Boolean;
    FLastChildOfParents: integer;
    FHasParent: Boolean;
    FHasChildren: Boolean;
    procedure SetExpanded(const Value: Boolean);
    function GetLastChild: Boolean;
    procedure SetLastChildOfParents(Value: Integer);
  public
    BreakPoint: Boolean;
    Executable: Boolean;
    Modified: Boolean;
    ImageIndex: integer;
    Bookmark: Boolean;
    Style: TStyle;
    CachedStyle: Boolean;
    Wrapped: Boolean;
    constructor Create;
    destructor Destroy; override;
    property HasParent: Boolean read FHasParent write FHasParent;
    property HasChildren: Boolean read FHasChildren write FHasChildren;
    property Expanded: Boolean read FExpanded write SetExpanded;
    property LastChild: Boolean read GetLastChild;
    property LastChildOfParents: Integer read FLastChildOfParents write SetLastChildOfParents;
  end;

  TOnChangeEvent = procedure (Sender: TObject; ChangeMsg: Integer) of object;

  TCodeFolding = class(TPersistent)
  private
    FEnabled: Boolean;
    FExpandGlyph: TBitMap;
    FCollapsedGlyph: TBitMap;
    FLineColor: TColor;
    FOnChange: TOnChangeEvent;
    procedure SetCollapsedGlyph(const Value: TBitMap);
    procedure SetEnabled(const Value: Boolean);
    procedure SetExpandGlyph(const Value: TBitMap);
    procedure SetLineColor(const Value: TColor);
  protected
    procedure Changed(ChangeMsg: Integer);
    property OnChange: TOnChangeEvent read FOnChange write FOnChange;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled;
    property LineColor: TColor read FLineColor write SetLineColor;
    property ExpandGlyph: TBitMap read FExpandGlyph write SetExpandGlyph;
    property CollapsedGlyph: TBitMap read FCollapsedGlyph write SetCollapsedGlyph;
  end;

  THintParameter = class(TPersistent)
  private
    FTextColor, FBkColor: TColor;
    FStartchar: Char;
    FEndchar: Char;
    FDelimiterchar: Char;
    FParameters: Tstringlist;
    FWritedelimiterchar: char;
    procedure SetParameters(const Value: Tstringlist);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property TextColor: TColor read FTextColor write FTextColor;
    property BkColor: TColor read FBkColor write FBkColor;
    property HintCharStart: Char read FStartchar write FStartChar;
    property HintCharEnd: Char read FEndchar write FEndChar;
    property HintCharDelimiter: Char read FDelimiterChar write FDelimiterChar;
    property HintCharWriteDelimiter: Char read FWriteDelimiterChar write FWritedelimiterChar;
    property Parameters: TStringlist read FParameters write SetParameters;
  end;

  //--------------------------------------------------------------
  //        CHAR STYLE LIST
  //--------------------------------------------------------------
  TCharStyle = class(TPersistent)
  private
    FTextColor, FBkColor: TColor;
    FStyle: TFontStyles;
  published
    property TextColor: TColor read FTextColor write FTextColor;
    property BkColor: TColor read FBkColor write FBkColor;
    property Style: TFontStyles read FStyle write FStyle;
  end;

  TPrintOptions = class(TPersistent)
  private
    FJobName: string;
    FTitle: string;
    FPageNr: Boolean;
    FPrintLineNumbers: Boolean;
    FMarginLeft: Integer;
    FMarginRight: Integer;
    FMarginTop: Integer;
    FMarginBottom: Integer;
    FPagePrefix: string;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property JobName: string read FJobName write FJobName;
    property Title: string read FTitle write FTitle;
    property MarginLeft: integer read FMarginLeft write FMarginLeft;
    property MarginRight: integer read FMarginRight write FMarginRight;
    property MarginTop: integer read FMarginTop write FMarginTop;
    property MarginBottom: Integer read FMarginBottom write FMarginBottom;
    property PageNr: Boolean read FPageNr write FPageNr;
    property PagePrefix: string read FPagePrefix write FPagePrefix;
    property PrintLineNumbers: boolean read FPrintLineNumbers write FPrintLineNumbers;

  end;

  //--------------------------------------------------------------
  TAdvCustomMemo = class;
  TAdvCustomMemoStyler = class;
  TAdvMarkerList = class;

  TAdvMarker = class(TCollectionItem)
  private
    FText: string;
    FImageIndex: integer;
    FLineNumber: integer;
    procedure SetText(const Value: string);
    procedure SetImageIndex(const Value: integer);
    procedure SetLineNumber(const Value: integer);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Text: string read FText write SetText;
    property ImageIndex: integer read FImageIndex write SetImageIndex;
    property LineNumber: integer read FLineNumber write SetLineNumber;
  end;

  TAdvMarkers = class(TCollection)
  private
    FComponent: TPersistent;
    function GetItem(Index: Integer): TAdvMarker;
    procedure SetItem(Index: Integer; Value: TAdvMarker);
    function GetMarkerCount: integer;
    function Add: TAdvMarker;
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Component: TPersistent);
    destructor Destroy; override;
    {$IFNDEF DELPHI5_LVL}
    procedure Delete(Index: Integer);
    {$ENDIF}
    function HasMarkers: Boolean;
    function HigherMarkerThanLine(LineNo: Integer): boolean;
    function GetMarkerImageIndex(LineNo: integer): integer;
    function GetMarkers(Markers: TAdvMarkers): boolean;
    function GetMarkerAtLine(LineNo: integer): TAdvMarker;
    function MarkerAtLine(LineNo: Integer): boolean;
    procedure AddMarker(LineIndex, ImageIndex: integer); overload;
    procedure AddMarker(LineIndex, ImageIndex: integer; MarkerText: string); overload;
    procedure RemoveMarker(LineNo: integer);
    procedure AdjustMarkerLineMinus(StartIndex: integer);
    procedure AdjustMarkerLinePlus(StartIndex: integer);
    property MarkerCount: Integer read GetMarkerCount;
    property Items[Index: Integer]: TAdvMarker read GetItem write SetItem; default;
  published
  end;

  TAdvMarkerList = class(TPersistent)
  private
    FOwner: TComponent;
    FMarkers: TAdvMarkers;
    FMarkerImage: TBitmap; //default image
    FMarkerImageList: TImageList; //imagelist
    FDefaultMarkerImageIndex: integer;
    FUseDefaultMarkerImageIndex: boolean;
    procedure SetItems(Value: TAdvMarkers);
    procedure SetMarkerImageList(Il: TimageList);
    procedure SetDefaultMarkerImageIndex(MarkerIndex: integer);
    procedure SetUseDefaultMarkerImageIndex(Value: Boolean);
    procedure SetMarkerTransparentColor(MarkerTransColor: TColor);
    function GetMarkerTransparentColor: TColor;
  protected

  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure FastDeleteAll;
    property Markers: TAdvMarkers read FMarkers write SetItems;
  published
    property MarkerImageList: TImageList read FMarkerImageList write SetMarkerImageList;
    property UseDefaultMarkerImageIndex: boolean read FUseDefaultMarkerImageINdex write SetUseDefaultMarkerImageIndex;
    property DefaultMarkerImageIndex: integer read FDefaultMarkerImageIndex write SetDefaultMarkerImageIndex;
    property ImageTransparentColor: TColor read GetMarkerTransparentColor write SetMarkerTransparentColor;
  end;

  TAdvStylerList = class(TComponent)
  private
    FStylerList: TList;
  protected
    procedure Notification(comp: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property StylerList: TList read FStylerList;
  published
  end;

  //--------------------------------------------------------------
  //        TAdvMemoStrings
  //--------------------------------------------------------------
  TAdvMemoStrings = class(TStringList)
  private
    Memo: TAdvCustomMemo;
    FLockCount: Integer;
    FDeleting: Boolean;
    FLinesProp: TList;
    FListLengths: TIntList;
    function GetRealCount: integer;
    function GetTextEx: string;
    procedure SetTextEx(const Value: string);
  protected
    procedure SetUpdateState(Updating: boolean); override;
    function Get(Index: Integer): string; override;
    procedure Put(Index: Integer; const S: string); override;
    function GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure RestoreObject(Index: Integer; AObject: TObject);
    function CreateProp(Index: integer): TLineProp;
    procedure ClearLinesProp;
    function GetLineProp(Index: Integer): TLineProp;
    procedure SetLineProp(Index: Integer; const Value: TLineProp);
    procedure AssignEx(Source: TPersistent);
  public
    constructor Create;
    destructor Destroy; override;
    function DoAdd(const S: string): integer;
    function Add(const S: string): integer; override;
    function AddObject(const S: string; AObject: TObject): Integer; override;
    procedure Clear; override;
    procedure ClearStrings;
    procedure AddStrings(strings: TStrings); override;
    procedure DoInsert(Index: integer; const S: string);
    procedure Assign(Source: TPersistent); override;
    procedure Delete(Index: integer); override;
    procedure Insert(Index: integer; const S: string); override;
    procedure LoadFromFile(const FileName: string); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToFile(const FileName: string); override;
    property RealCount: Integer read GetRealcount;
    property Text: string read GetTextEx write SetTextEx;
  published
    property OnChange;
    property OnChanging;
  end;

  //------------------------------
  //    TAdvActiveLinesettings
  //------------------------------
  TAdvActiveLineSettings = class(TPersistent)
  private
    Memo: TAdvCustomMemo;
    FActiveLineColor: TColor;
    FActiveLineTextColor: TColor;
    FActiveLineAtCursor: Boolean;
    FShowActiveLine: Boolean;
    FShowActiveLineIndicator: Boolean;
    procedure SetShowActiveLine(const Value: boolean);
    procedure SetShowActiveLineIndicator(const Value: boolean);
    procedure SetActiveLineColor(const Value: TColor);
    procedure SetActiveLineTextColor(const Value: TColor);
    procedure SetActiveLineAtCursor(const Value: Boolean);
  public
    constructor Create(AOwner: TAdvCustomMemo);
  published
    property ShowActiveLine: boolean read FShowActiveLine write SetShowActiveLine;
    property ShowActiveLineIndicator: boolean read FShowActiveLineIndicator write SetShowActiveLineIndicator;
    property ActiveLineColor: TColor read FActiveLineColor write SetActiveLineColor default clNavy;
    property ActiveLineAtCursor: Boolean read FActiveLineAtCursor write SetActiveLineAtCursor default False;
    property ActiveLineTextColor: TColor read FActiveLineTextColor write SetActiveLineTextColor default clYellow;
  end;

  //--------------------------------------------------------------
  //        TAdvGutter
  //--------------------------------------------------------------
  TAdvGutter = class(TPersistent)
  private
    Memo: TAdvCustomMemo;
    FLeft, FTop, FWidth, FHeight: integer;
    FColor: TColor;
    FColorTo: TColor;
    FShowLeadingZeros: boolean;
    FShowGutter: boolean;
    FDigitCount: integer;
    FGutterWidth: integer;
    FGutterMargin: integer;
    FFont: TFont;
    FNumberSuffix: string;
    FLineNumberTextColor: TColor;
    FShowLineNumbers: boolean;
    FShowModified: Boolean;    
    FLineNumberStart: integer;
    FOnChange: TNotifyEvent;
    FModifiedColor: TColor;
    FModifiedColorBkg: TColor;
    FBorderColor: TColor;
    procedure SetLineNumberTextColor(const Value: TColor);
    procedure SetGutterWidth(Value: integer);
    procedure SetGutterMargin(Value: integer);
    procedure SetGutterColor(Value: TColor);
    function GetGutterColor: TColor;
    procedure SetShowLeadingZeros(const Value: boolean);
    procedure SetDigitCount(const Value: integer);
    procedure SetFont(Value: TFont);
    procedure OnFontChange(Sender: TObject);
    procedure SetGutterColorTo(const Value: TColor);
    function GetGutterColorTo: TColor;
    procedure SetShowLineNumbers(const Value: Boolean);
    procedure SetLineNumberStart(const Value: integer);
    procedure SetShowGutter(const Value: Boolean);
    procedure SetShowModified(const Value: Boolean);
    procedure SetNumberSuffix(const Value: string);
    procedure SetParams(Index: integer; Value: integer);
    procedure SetModifiedColor(const Value: TColor);
    procedure SetModifiedColorBkg(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    function GetRect: TRect;
  protected
    procedure PaintTo(ACanvas: TCanvas);
    procedure Invalidate;
  public
    constructor Create(AOwner: TAdvCustomMemo);
    destructor Destroy; override;
    property Left: integer index 0 read FLeft write SetParams;
    property Top: integer index 1 read FTop write SetParams;
    property Width: integer index 2 read FWidth write SetParams default 45;
    property Height: integer index 3 read FHeight write SetParams;
    property FullRect: TRect read GetRect;
  published
    property DigitCount: integer read FDigitCount write SetDigitCount;
    property Font: TFont read fFont write SetFont;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clGray;
    property GutterWidth: Integer read FGutterWidth write SetGutterWidth default 45;
    property GutterMargin: Integer read FGutterMargin write SetGutterMargin default 45;
    property GutterColor: TColor read GetGutterColor write SetGutterColor default clBtnFace;
    property GutterColorTo: TColor read GetGutterColorTo write SetGutterColorTo default clWhite;
    property LineNumberStart: Integer read FLineNumberStart write SetLineNumberStart default 1; // min value is 1
    property LineNumberTextColor: TColor read FLineNumberTextColor write SetLineNumberTextColor default clBlack;
    property ModifiedColorBkg: TColor read FModifiedColorBkg write SetModifiedColorBkg default clLime;
    property ModifiedColor: TColor read FModifiedColor write SetModifiedColor default clYellow;
    property NumberSuffix: string read FNumberSuffix write SetNumberSuffix;
    property ShowLineNumbers: Boolean read FShowLineNumbers write SetShowLineNumbers default true;
    property ShowModified: Boolean read FShowModified write SetShowModified default false;
    property Visible: boolean read FShowGutter write SetShowGutter default true;
    property ShowLeadingZeros: boolean read FShowLeadingZeros write SetShowLeadingZeros default false;
  end;

  //--------------------------------------------------------------
  //        TUNDO
  //--------------------------------------------------------------
  TUndo = class
  private
    Memo: TAdvCustomMemo;
    FUndoCurX0, FUndoCurY0: integer;
    FUndoCurX, FUndoCurY: integer;
    FUndoText: string;
  public
    constructor Create(ACurX0, ACurY0, ACurX, ACurY: integer; AText: string);
    function Append(NewUndo: TUndo): boolean; virtual;
    procedure Undo;
    procedure Redo;
    procedure PerformUndo; virtual; abstract;
    procedure PerformRedo; virtual; abstract;
    property UndoCurX0: integer read FUndoCurX0 write FUndoCurX0;
    property UndoCurY0: integer read FUndoCurY0 write FUndoCurY0;
    property UndoCurX: integer read FUndoCurX write FUndoCurX;
    property UndoCurY: integer read FUndoCurY write FUndoCurY;
  end;

  TInsertCharUndo = class(TUndo)
  public
    function Append(NewUndo: TUndo): boolean; override;
    procedure PerformUndo; override;
    procedure PerformRedo; override;
  end;

  TDeleteCharUndo = class(TUndo)
  private
    FIsBackspace: boolean;
  public
    function Append(NewUndo: TUndo): boolean; override;
    procedure PerformUndo; override;
    procedure PerformRedo; override;
    property IsBackspace: boolean read FIsBackspace write FIsBackspace;
  end;

  TDeleteLineUndo = class(TUndo)
  public
    procedure PerformUndo; override;
    procedure PerformRedo; override;
  end;

  TSelUndo = class(TUndo)
  private
    FUndoSelStartX, FUndoSelStartY,
    FUndoSelEndX, FUndoSelEndY: integer;
  public
    property UndoSelStartX: integer read FUndoSelStartX write FUndoSelStartX;
    property UndoSelStartY: integer read FUndoSelStartY write FUndoSelStartY;
    property UndoSelEndX: integer read FUndoSelEndX write FUndoSelEndX;
    property UndoSelEndY: integer read FUndoSelEndY write FUndoSelEndY;
  end;

  TDeleteBufUndo = class(TSelUndo)
  public
    procedure PerformUndo; override;
    procedure PerformRedo; override;
  end;

  TPasteUndo = class(TUndo)
  public
    procedure PerformUndo; override;
    procedure PerformRedo; override;
  end;

  TIndentUndo = class(TUndo)
  private
    FIndent: integer;
    FSelRowFrom: integer;
    FSelRowTo: integer;
  public
    constructor Create(SelFrom, SelTo, Indent: integer);
    procedure PerformUndo; override;
    procedure PerformRedo; override;
    property Indent: Integer read FIndent write FIndent;
    property SelRowFrom: integer read FSelRowFrom write FSelRowFrom;
    property SelRowTo: integer read FSelRowTo write FSelRowTo;
  end;

  TCorrectUndo = class(TUndo)
  public
    constructor Create(LineNo: integer; UndoLine: string);
    procedure PerformUndo; override;
    procedure PerformRedo; override;
  end;


  TAdvUndoList = class(TList)
  private
    FPos: integer;
    FMemo: TAdvCustomMemo;
    FIsPerforming: boolean;
    FLimit: integer;
  protected
    function Get(Index: integer): TUndo;
    procedure SetLimit(Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
{$IFNDEF TMSDOTNET}
    function Add(Item: Pointer): Integer;
{$ENDIF}
{$IFDEF TMSDOTNET}
    function Add(Item: TObject): Integer;
{$ENDIF}
{$IFNDEF DELPHI4_LVL} { Borland Delphi 3.0 }
    procedure Clear;
{$ELSE}
    procedure Clear; override;
{$ENDIF}
    procedure Delete(Index: integer);
    procedure Undo;
    procedure Redo;
    property Items[Index: integer]: TUndo read Get; default;
    property IsPerforming: boolean read FIsPerforming write FIsPerforming;
    property Memo: TAdvCustomMemo read FMemo write FMemo;
    property Pos: integer read FPos write FPos;
    property Limit: integer read FLimit write SetLimit;
  end;

  //--------------------------------------------------------------
  TGutterClickEvent = procedure(Sender: TObject; LineNo: integer) of object;
  TGutterDrawEvent = procedure(Sender: TObject; ACanvas: TCanvas;
    LineNo: integer; rct: TRect) of object;

  TUndoChangeEvent = procedure(Sender: TObject; CanUndo, CanRedo: boolean) of object;

  TURLClick = procedure(Sender: TObject; URL: string) of object;

  TScrollMode = (smAuto, smStrict);

  TMemoHintEvent = procedure(Sender: TObject; X, Y: Integer; AValue: string; var AHint: string; var Show: Boolean) of object;

  TMemoWordEvent = procedure(Sender: TObject; CurrentWord: string; var NewWord: string) of object;

  TMemoBeforeCompleteEvent = procedure(Sender: TObject; AToken: string; var Show: Boolean) of object;

  TMemoGetCompletionListEvent = procedure(Sender: TObject; AToken: string; AList: TStringList) of object;

  TMemoInsertCompletionEntryEvent = procedure(Sender: TObject; var AEntry: string) of object;

  TMemoSortCompletionListEvent = function(Sender: TObject; List: TStringList; Index1, Index2: Integer): Integer of object;

  TMemoGetParameterHintEvent = procedure(Sender: TObject; AToken: string; var AParameterHint: string; var Handled: boolean) of object;
  TDrawMode = (dmScreen, dmHTML, dmPrinter, dmPrintPreview, dmRTF);

  TMemoActiveLineChangeEvent = procedure(CurYPos: integer) of object;
  TMemoColumnChangeEvent = procedure(CurXPos: integer) of object;

  TMemoMarkerAddedEvent = procedure(LnNo: integer; MarkerText: string) of object;
  TMemoMarkerRemovedEvent = procedure(LnNo: integer) of object;


  TAutoCorrect = class(TPersistent)
  private
    FOldValue: TStringList;
    FNewValue: TStringList;
    FDoAutoCorrect: boolean;
    procedure SetDoAutoCorrect(const Value: boolean);
    procedure SetNewValue(const Value: TStringList);
    procedure SetOldValue(const Value: TStringList);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Active: Boolean read FDoAutoCorrect write SetDoAutoCorrect;
    property OldValue: TStringList read FOldValue write SetOldValue;
    property NewValue: TStringList read FNewValue write SetNewValue;
  end;

  TAutoCompletion = class(TPersistent)
  private
    FOwner: TAdvCustomMemo;
    FShowImages: Boolean;
    FActive: Boolean;
    FHeight: Integer;
    FWidth: Integer;
    FDelay: Integer;
    FColor: TColor;
    FFont: TFont;
    FColorVar: TColor;
    FColorProp: TColor;
    FColorIdentifier: TColor;
    FColorFunc: TColor;
    FColorEvent: TColor;
    FColorProc: TColor;
    FColorMethod: TColor;
    FSizeDropDown: Boolean;
    FAutoDisplay: Boolean;
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetShowImages(const Value: Boolean);
    procedure SetDelay(const Value: Integer);
  protected
  public
    constructor Create(AOwner: TAdvCustomMemo);
    destructor Destroy; override;
  published
    property Active: Boolean read FActive write FActive default True;
    property AutoDisplay: Boolean read FAutoDisplay write FAutoDisplay default true;
    property Color: TColor read FColor write SetColor default clWindow;
    property Delay: Integer read FDelay write SetDelay default 500;
    property Font: TFont read FFont write SetFont;
    property ColorVar: TColor read FColorVar write FColorVar default clBlue;
    property ColorProp: TColor read FColorProp write FColorProp default clTeal;
    property ColorMethod: TColor read FColorMethod write FColorMethod default clNavy;
    property ColorFunc: TColor read FColorFunc write FColorFunc default clNavy;
    property ColorProc: TColor read FColorProc write FColorProc default clNavy;
    property ColorEvent: TColor read FColorEvent write FColorEvent default clRed;
    property ColorIdentifier: TColor read FColorIdentifier write FColorIdentifier default clTeal;
    property Height: Integer read FHeight write FHeight default 100;
    property ShowImages: Boolean read FShowImages write SetShowImages default False;
    property SizeDropDown: Boolean read FSizeDropDown write FSizeDropDown default True;
    property Width: Integer read FWidth write FWidth default 200;
  end;

  //record used by memosource to save and restore cursor position
  //se TAdvMemoSource.SetMemo, TAdvCustomMemo.GetMemoState and TAdvCustomMemo.ResetMemoState
  TAdvMemoSavePos = record
    CurX: integer;
    CurY: integer;
    LeftCol: integer;
    TopLine: integer;
    //TODO - Selection not restoring 100% - sometimes moves..???
    SelStartX, SelStartY,
    SelEndX, SelEndY: integer;
  end;

  TAutoCorrectType = (acNone, acLineCorrect, acLineCheck, acWordCorrect, acWordCheck);

  TAdvMemoChecker = class(TComponent)
  private
    FMemo: TAdvCustomMemo;
    FAutoCorrectType: TAutoCorrectType;
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    function ReplaceOnce(const S, OldPattern, NewPattern: string): string;
    procedure AddUndo(LineNo: integer; UndoLine: string);
  public
    property Memo: TAdvCustomMemo read FMemo write FMemo;

    procedure CheckLine(LineNo: Integer); virtual;
    procedure CheckWord(LineNo, LinePos: Integer; s: string); virtual;

    procedure CorrectLine(LineNo: Integer); virtual;
    procedure CorrectWord(LineNo,LinePos: Integer; var s: string); virtual;
    procedure CheckAllLines; virtual;
    procedure CorrectAllLines; virtual;

    property AutoCorrectType: TAutoCorrectType read FAutoCorrectType write FAutoCorrectType default acNone;
  published
  end;

  TAdvMemoCapitalChecker = class(TAdvMemoChecker)
  public
    constructor Create(AOwner: TComponent); override;
    procedure CorrectLine(LineNo: Integer); override;  
  end;

  //--------------------------------------------------------------
  //        TAdvMemoSource - declaration
  //--------------------------------------------------------------
  TAdvMemoSource = class(TComponent)
  private
    FSyntaxStyler: TAdvCustomMemoStyler;
    FLines: TAdvMemoStrings;
    FUndoList: TAdvUndoList;
    FUndoLimit: integer;
    FMemo: TAdvCustomMemo;
    FModified: boolean;
    FReadOnly: boolean;
    FCaretInfo: TAdvMemoSavePos;
    FBookmarkList: TIntList;
    function GetReadOnly: boolean;
    procedure SetReadOnly(const Value: boolean);
  protected
    procedure SetSyntaxStyler(const Value: TAdvCustomMemoStyler);
    procedure SetLines(const Value: TAdvMemoStrings);
    procedure SetMemo(const Value: TAdvCustomMemo);
    function GetModified: boolean;
    procedure SetModified(const Value: boolean);
    function GetUndoList: TAdvUndoList;
    procedure SetUndoList(const Value: TAdvUndoList);
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Modified: boolean read GetModified write SetModified;
    property UndoList: TAdvUndoList read GetUndoList write SetUndoList;
  published
    property SyntaxStyler: TAdvCustomMemoStyler read FSyntaxStyler write SetSyntaxStyler;
    property Lines: TAdvMemoStrings read FLines write SetLines;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
  end;

  TWordWrapStyle = (wwNone, wwClientWidth, wwRightMargin);

  //--------------------------------------------------------------
  //        TAdvCustomMemo - declaration
  //--------------------------------------------------------------
  TAdvCustomMemo = class(TCustomControl, ITMSStyle)
  private
{$IFDEF TMSCLX}
    FCaretBmp: TBitmap;
{$ENDIF}
    FOwner: TComponent;
    FVersion: string;
    FUseStyler: boolean;
    FInternalStyles: TAdvCustomMemoStyler;
    FCaseSensitive: Boolean;
    FBorderStyle: TBorderStyle;
    FAutoIndent: Boolean;
    FMargin: Integer;
    FHiddenCaret, FCaretVisible: boolean;
    FCellSize: TCellSize;
    FCurX, FCurY: Integer;
    FbackupTopLine,
    FLeftCol, FTopLine: Integer;
    FTabSize: Integer;
    FFont: TFont;
    FBkColor: TColor;
    FSelColor: TColor;
    FSelBkColor: TColor;
    FReadOnly: boolean;
    FDelErase: boolean;
    FShowRightMargin: Boolean;
    FSmartTabs: Boolean;
    FEnhancedHomeKey: Boolean;
    FLines: TAdvMemoStrings;
    FSelStartX, FSelStartY,
    FSelEndX, FSelEndY,
    FPrevSelX, FPrevSelY: integer;
    FScrollBars: TScrollStyle;
    FActiveLineSettings: TAdvActiveLineSettings;
    FGutter: TAdvGutter;
    sbVert, sbHorz: TScrollBar;
    FLineBitmap: TBitmap;
    FSelCharPos: TFullPos;
    FLeftButtonDown: boolean;
    FSelButtonDown: boolean;
    FSelClick: Boolean;
    FSelDrag: boolean;
    FScrollMode: TScrollMode;
    FUndoList: TAdvUndoList;
    FUndoLimit: integer;
    FBackupTopStyle: Tstyle;
    FTempdelimiters: string;
    FUrlDelimiters: string;
    Timer: TTimer;
    FHintForm: TAdvHintform;
    FAutoHintParameters: TAutoHintParameters;
    FUrlStyle: TCharStyle;
    FUrlAware: Boolean;
    FActiveLine: Integer;
    FCtl3D: boolean;
    FOldCursor: TCursor;
    Html: TStringList;
    Htmlfont: string;
    FMaxLength: Integer;
    FLetShowAutoCompletion: Boolean;
    FSearching: Boolean;
    FHintShowing: Boolean;
    FListCompletion: TAutoCompletionListBox;
    FormAutoCompletion: TAdvAutoForm;
    FAutoCompletion: TAutoCompletion;
    FMarkerList: TAdvMarkerList;
    FStylerList: TAdvStylerList;
    FAutoCompletionListImages: TImageList;
    FAutoThemeAdapt: Boolean;
    { Events }
    FOnChange: TNotifyEvent;
    FOnStatusChange: TNotifyEvent;
    FOnSelectionChange: TNotifyEvent;
    FOnGutterDraw: TGutterDrawEvent;
    FOnGutterClick: TGutterClickEvent;
    FOnGutterRightClick: TGutterClickEvent;
    FOnUndoChange: TUndoChangeEvent;
    FOnURLClick: TurlClick;
    FOnReplace: TNotifyEvent;
    FOnFind: TNotifyEvent;
    FOnAutoCompletion: TNotifyEvent;
    FOnCancelAutoCompletion: TNotifyEvent;
    FOnStartAutoCompletion: TNotifyEvent;
    FOnActiveLineChange: TMemoActiveLineChangeEvent;
    FOnColumnChange: TMemoColumnChangeEvent;
    FOnMarkerAdded: TMemoMarkerAddedEvent;
    FOnMarkerRemoved: TMemoMarkerRemovedEvent;
    FPrintOptions: TPrintOptions;
    FAutoHintParameterPos: TAutoHintParameterPosition;
    FtmpNoStart, FtmpNo, FtmpNoHex: string;
    FCaretTime: cardinal;
    FletgetCaretTime: Boolean;
    FTrimTrailingSpaces: boolean;
    FCaretX, FCaretY: Cardinal;
    BSSelLine, BSSelStart, BSSelLen: Integer;
    BSOldSelLine: Integer;
    BESelLine, BESelStart, BESelLen: Integer;
    BEOldSelLine: Integer;
    FOnCursorChange: TNotifyEvent;
    FBlockShow: Boolean;
    FBlockColor: TColor;
    FBlockLineColor: TColor;
    FOverwrite: Boolean;
    FOnOverwriteToggle: TAllowEvent;
    FOnHintForWord: TMemoHintEvent;
    FOnHintForToken: TMemoHintEvent;
    FLastHintPos: TPoint;
    FonWordComplete: TMemoWordEvent;
    FWantTab: boolean;
    FHideSelection: boolean;
    FAutoCorrect: TAutoCorrect;
    FOnBeforeAutoComplete: TMemoBeforeCompleteEvent;
    FOnGetAutoCompletionList: TMemoGetCompletionListEvent;
    FAutoHintParameterDelay: Integer;
    FBookmarkBmp: TBitmap;
    FBookmarkList: TIntList;
    FOnInsertAutoCompletionEntry: TMemoInsertCompletionEntryEvent;
    FOnSortAutoCompletionList: TMemoSortCompletionListEvent;
    FOnGetParameterHint: TMemoGetParameterHintEvent;
    FAutoExpand: Boolean;
    FAutoCompleteDot: Boolean;
    FAutoCompleteTimer: TTimer;
    FAutoCompleteList: TStringList;
    FDotPoint: TPoint;
    FAllowAutoHint: boolean;
    FWWList: TIntList;
    FCachedDelimiters: string;
    FMemoSource: TAdvMemoSource;
    FRightMargin: Integer;
    FRightMarginColor: TColor;
    FBreakpointColor: TColor;
    FBreakpointTextColor: TColor;
    FAcceptFiles: Boolean;
    FWordWrap: TWordWrapStyle;
    FScrollHint: Boolean;
    FScrollHintWindow: THintWindow;
    FOnTopLeftChanged: TNotifyEvent;
    FOnFileDrop: TAdvMemoFileDropEvent;
    FOnScrollHint: TAdvMemoScrollHintEvent;
    FMemoChecker: TAdvMemoChecker;
    FRTFEngine: TRTFEngine;
    FCodeFolding: TCodeFolding;
    FOnGutterDblClick: TGutterClickEvent;
    FCursorChangedTrigered: Boolean;
    FShouldCheckCodeFolding: Boolean;
   	FCodeFoldingNodeCount: Integer;
    FBorderColor: TColor;
    FClearType: boolean;
    procedure OnCodeFoldingChange(Sender: TObject; ChangeMsg: Integer);
    function InternalUndoList: TAdvUndoList;
    procedure SetMemoSource(const Value: TAdvMemoSource);
    function GetModified: boolean;
    procedure SetModified(const Value: boolean);
    procedure AutoCompleteTimer(Sender: TObject);
    procedure UpdateCompletionList(token: string);
    //function SortAutoCompletList(List: TStringList; Index1, Index2: Integer): Integer;
    function IsDelimiter(value: Char): boolean;
    procedure ShowForm(ShowAlways: Boolean);
    procedure HideForm;
    procedure PrepareShowHint;
    function SearchParameter: Boolean;
    procedure FormHintMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Hideauto(Sender: Tobject);
    procedure ListKeyDown(Sender: Tobject; var Key: word; Shift: TShiftState);
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormHintClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerHint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetHiddenCaret(Value: boolean);
    procedure SetScrollBars(Value: TScrollStyle);
    procedure SetUseStyler(const Value: boolean);
    procedure SetCaseSensitive(Value: boolean);
    procedure SetCurX(Value: integer);
    procedure SetCurY(Value: integer);
    procedure SetFont(Value: TFont);
    procedure SetColor(Index: integer; Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetLines(ALines: TAdvMemoStrings);
    procedure ExpandSelection;
    function GetSelText: string;
    procedure SetSelText(const AValue: string);
    function GetSelLength: integer;
    procedure MovePage(dP: integer; Shift: TShiftState);
    procedure ShowCaret(State: boolean);
    procedure MakeVisible;
    function GetVisible(Index: integer): Integer;
    procedure SetMaxLength;
    function TrimRightWW(LineNo: Integer): string;
{$IFNDEF TMSCLX}
    procedure WMSysChar(var Msg: TWMSysChar); message WM_SYSCHAR;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMEraseBkgnd(var Msg: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
{$IFDEF DELPHI5_LVL}
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
{$ENDIF}
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMDropFiles(var Message: TMessage); message WM_DROPFILES;
    procedure CMWantSpecialKey(var Msg: TCMWantSpecialKey); message CM_WANTSPECIALKEY;    
{$IFDEF TMSDOTNET}
    procedure CMHintShow(var Msg: TCMHintShow); message CM_HINTSHOW;
{$ENDIF}
{$IFNDEF TMSDOTNET}
    procedure CMHintShow(var Msg: TMessage); message CM_HINTSHOW;
{$ENDIF}
{$ENDIF}
    procedure SetSmartTabs(const Value: boolean);
    procedure SetAcceptFiles(const Value: boolean);
    procedure SetEnhancedHomeKey(const Value: boolean);
    procedure SetShowRightMargin(const Value: boolean);
    procedure SetTrimTrailingSpaces(const Value: boolean);
    function FormatLineNumber(var Position: integer; Line: integer): string;
    procedure MoveCursor(dX, dY: integer; Shift: TShiftState);
    procedure ResizeEditor;
    procedure ResizeScrollBars(DoRepaint: Boolean);
    procedure ResizeGutter;
    procedure DoCommand(cmd: TCommand; const AShift: TShiftState);
    procedure DrawLine(ACanvas: TCanvas; LineNo: integer; var Style: TStyle; DM: TDrawMode; PR: TRect; VisLineNo: Integer = -1);
    procedure DrawHTML(Part: string; var Drawstyle: Tstyle; lineno: integer);
    procedure DrawRTF(Part: string; var Drawstyle: Tstyle; lineno: integer);
    procedure ExtractURL(s: string; var urls: TStringList);
    procedure FreshLineBitmap;
    procedure SetUndoLimit(Value: integer);
    function GetSelStart: Integer;
    procedure SetSelStart(const Value: integer);
    procedure SetSelLength(const Value: integer);
    procedure SetActiveLine(const Value: integer);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetCtl3D(const Value: boolean);
    procedure UpdateGutter;
    procedure SetLeftCol(const Value: integer);
    procedure SetWordWrap(const Value: TWordWrapStyle);
    procedure SetTopLine(const Value: integer);
    procedure SetMemoStyler(Value: TAdvCustomMemoStyler);
    function GetUpStyle(stopat: Integer): TStyle;
    procedure SetUrlAware(const Value: boolean);
    procedure SetUrlStyle(const Value: TCharStyle);
    procedure ScrollVChange(Sender: TObject);
    procedure ScrollHChange(Sender: TObject);
    function GetBreakPoint(Index: Integer): Boolean;
    procedure SetBreakPoint(Index: Integer; const Value: Boolean);
    function GetModifiedState(Index: Integer): Boolean;
    procedure SetModifiedState(Index: Integer; const Value: Boolean);
    function GetWrapped(Index: Integer): Boolean;
    procedure SetWrapped(Index: Integer; const Value: Boolean);
    function GetBookmark(Index: Integer): Boolean;
    procedure SetBookmark(Index: Integer; const Value: Boolean);
    function GetExecutable(Index: Integer): Boolean;
    procedure SetExecutable(Index: Integer; const Value: Boolean);
    procedure SetLineStyle(Index: Integer; const LineStyle: TStyle);
    procedure ClearLineStyles;
    function GetLineStyle(Index: Integer; var LineStyle: TStyle): Boolean;
    procedure SwapColors;
    procedure SetEventAutoCompletion;
    procedure KilleventAutoCompletion;
    procedure SetAutoHintParameters(const Value: TAutoHintParameters);
    procedure SetPrintOptions(const Value: TPrintOptions);
    procedure SetAutoHintParameterDelay(const Value: Integer);
    function GetBookmarks(Index: Integer): Integer;
    procedure SetBookmarks(Index: Integer; const Value: Integer);
    function GetInternalStyles: TAdvCustomMemoStyler;
    function GetInternalLines: TAdvMemoStrings;
    procedure SetInternalLines(const Value: TAdvMemoStrings);
    procedure SetRightMargin(const Value: Integer);
    procedure SetRightMarginColor(const Value: TColor);
    procedure SetBreakpointColor(const Value: TColor);
    procedure SetBreakpointTextColor(const Value: TColor);
    procedure SetHideSelection(const Value: Boolean);
    procedure DoActiveLineChange(LnNo: Integer);
    procedure DoColumnChange(ColNo: Integer);
    procedure DoMarkerAdded(LnNo: Integer; MarkerText: string);
    procedure DoMarkerRemoved(LnNo: Integer);
    procedure SearchForStylers;
    function GetMarkerCount: Integer;
    procedure SetAutoCompletionListImages(IL: TImageList);
    procedure SetMemoChecker(const AMemoChecker: TAdvMemoChecker);
{$IFDEF TMSCLX}
    procedure InvalidateRect(Handle: QWidgetH; rect: pointer; flag: boolean);
{$ENDIF}
    procedure SetVersion(const Value: string);
    function GetVersion: string;
    procedure SetCodeFolding(Value: TCodeFolding);
    function GetExpandNode(Index: Integer): Boolean;
    procedure SetExpandNode(Index: Integer; const Value: Boolean);
    procedure SetAutoThemeAdapt(const value: boolean);
  protected
    FLetRefresh: Boolean;
    function VisIndexToLineIndex(Index: Integer): Integer;
    function LineIndexToVisIndex(Index: Integer): Integer;
    function LastChildOfParent(ParentIndex: Integer): Integer;
    procedure ExpandParents(ChildIndex: Integer);
    procedure RemoveCodeFoldingFromChild(EndLineIndex: Integer);
    function IsCommentedNode(LineIndex: Integer): Boolean;
    function GetNodeComments(LineIndex: Integer; var RgnIndex: Integer; var Coments: String): Boolean;
    procedure ResetMemoState(value: TAdvMemoSavePos);
    procedure GetMemoState(var value: TAdvMemoSavePos);
    property InternalStyles: TAdvCustomMemoStyler read GetInternalStyles;
    property InternalLines: TAdvMemoStrings read GetInternalLines write SetInternalLines;
{$IFDEF DELPHI5_LVL}
{$IFNDEF TMSCLX}
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): boolean; override;
    procedure WndProc(var Message: TMessage); override;
{$ENDIF}
{$ENDIF}
    procedure SelClickUpdate(X, Y: Integer; Down: Boolean; Shift: TShiftState; Button: TMouseButton);
    function EditorRect: TRect;
    function CodeFoldingRect: TRect;
    function CellFromPos(X, Y: integer): TCellPos;
    function CellRect(ACol, ARow: integer): TRect;
    function LineRect(ARow: integer): TRect;
    function LineRangeRect(FromLine, ToLine: integer): TRect;
    function ColRect(ACol: integer): TRect;
    function ColRangeRect(FromCol, ToCol: integer): TRect;
    function AddString(S: string): integer;
    procedure InsertString(Index: integer; S: string);
    procedure GoHome(Shift: TShiftState);
    procedure GoEnd(Shift: TShiftState);
    procedure InsertChar(C: char);
    procedure DeleteChar(OldX, OldY: integer);
    procedure BackSpace;
    procedure BackWord;
    function IndentCurrLine: string;
    procedure TestforURLClick(s: string);
    function TestforURLMove(s: string; locx: integer): boolean;
    procedure SetBlockMatchStart(LineNo, BlockStart, BlockLen: Integer);
    procedure SetBlockMatchEnd(LineNo, BlockStart, BlockLen: Integer);
    procedure NewLine;
    procedure TabLine(AShift: TShiftState); //perform the tab and smarttab if set
    procedure DoEscape;
    procedure Resize; override;
{$IFNDEF TMSCLX}
    procedure CreateParams(var Params: TCreateParams); override;
{$ENDIF}
    procedure Paint; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DrawMargin;
    procedure DrawGutter;
    procedure ThemeAdapt;
    procedure ScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: integer);
    procedure KeyDown(var Key: word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
    procedure KeyUp(var Key: word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure DoScroll(Sender: TScrollBar; ByValue: integer);
    procedure DoScrollPage(Sender: TScrollBar; ByValue: integer);
    property MaxLength: Integer read FMaxLength;
    property VisiblePosCount: Integer index 0 read GetVisible;
    property VisibleLineCount: Integer index 1 read GetVisible;
    property LastVisiblePos: Integer index 2 read GetVisible;
    property LastVisibleLine: Integer index 3 read GetVisible;
    property UseStyler: boolean read FUseStyler write SetUseStyler;
    procedure DeleteSelectionInt(bRepaint: boolean);
    procedure LinesChanged(Sender: TObject);
    procedure LineRefresh;
    procedure SelectionChanged; virtual;
    procedure StatusChanged; virtual;
    procedure FontChangedProc(Sender: TObject);
    function IsWordBoundary(ch: char): boolean; virtual;
    function IsTokenBoundary(ch: char): boolean; virtual;
    procedure ClearUndoList;
    procedure UndoChange;
    function GetCursorEx: TCursor;
    procedure CursorChanged; virtual;
    procedure SetCursorEx(const Value: TCursor);
    function EditCanModify: Boolean; virtual;
    procedure InsertTemplate(AText: string);
    procedure OutputHTML(FixedFonts: Boolean);
    procedure OutputRTF(FixedFonts: Boolean);
    procedure DoFind;
    procedure DoReplace;
    procedure DoWrap;
    procedure UndoWrap;
    procedure Change; virtual;
    procedure DoGutterClick(LineNo: integer); virtual;
    procedure DoGetAutoCompletionList(AToken: string; AList: TStringList); virtual;
    //procedure Loaded; override;
    property ShowRightMargin: boolean read FShowRightMargin write SetShowRightMargin;
    property AutoCorrect: TAutoCorrect read FAutoCorrect write FAutoCorrect;
    property AutoIndent: Boolean read FAutoIndent write FAutoIndent default true;
    property AutoExpand: Boolean read FAutoExpand write FAutoExpand default true;
    property AutoThemeAdapt: Boolean read FAutoThemeAdapt write SetAutoThemeAdapt default False;
    property BlockShow: Boolean read FBlockShow write FBlockShow default true;
    property BlockColor: TColor read FBlockColor write FBlockColor default clAqua;
    property BlockLineColor: TColor read FBlockLineColor write FBlockLineColor default clNone;
    property Gutter: TAdvGutter read FGutter write FGutter;
    property ActiveLineSettings: TAdvActiveLineSettings read FActiveLineSettings write FActiveLineSettings;
    property RightMargin: Integer read FRightMargin write SetRightMargin default 80;
    property RightMarginColor: TColor read FRightMarginColor write SetRightMarginColor;
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars default ssBoth;
    property Font: TFont read FFont write SetFont;
    property ReadOnly: boolean read FReadOnly write FReadOnly;
    property BkColor: TColor index 0 read FBkColor write SetColor;
    property SelColor: TColor index 1 read FSelColor write SetColor;
    property SelBkColor: TColor index 2 read FSelBkColor write SetColor;
    property HiddenCaret: boolean read FHiddenCaret write SetHiddenCaret;
    property TabSize: integer read FTabSize write FTabSize;
    property Searching: Boolean read FSearching write FSearching;
    property ScrollMode: TScrollMode read FScrollMode write FScrollMode default smAuto;
    property UndoLimit: Integer read FUndoLimit write SetUndoLimit;
    property UrlStyle: TCharStyle read FUrlStyle write SetUrlStyle;
    property AutoCompletion: TAutoCompletion read FAutoCompletion write FAutoCompletion;
    property AutoHintParameters: TAutoHintParameters read FAutoHintParameters write SetAutoHintParameters default hpAuto;
    property AutoHintParameterPosition: TAutoHintParameterPosition read FAutoHintParameterPos write FAutoHintParameterPos;
    property AutoHintParameterDelay: Integer read FAutoHintParameterDelay write SetAutoHintParameterDelay default 2500;
    property MemoSource: TAdvMemoSource read FMemoSource write SetMemoSource;
    property MarkerList: TAdvMarkerList read FMarkerList write FMarkerList;
    property MarkerCount: integer read GetMarkerCount;
    property AutoCompletionListImages: TImageList read FAutoCompletionListImages write SetAutoCompletionListImages;
    property TrimTrailingSpaces: boolean read FTrimTrailingSpaces write SetTrimTrailingSpaces;
    property ScrollHint: Boolean read FScrollHint write FScrollHint;
    property SmartTabs: Boolean read FSmartTabs write SetSmartTabs;
    property EnhancedHomeKey: boolean read FEnhancedHomeKey write SetEnhancedHomeKey;
    property MemoChecker: TAdvMemoChecker read FMemoChecker write SetMemoChecker;
    property CodeFolding: TCodeFolding read FCodeFolding write SetCodeFolding;
    { Events }
    property OnBeforeAutoCompletion: TMemoBeforeCompleteEvent read FOnBeforeAutoComplete write FOnBeforeAutoComplete;
    property OnStartAutoCompletion: TNotifyEvent read FOnStartAutoCompletion write FOnStartAutoCompletion;
    property OnGetAutoCompletionList: TMemoGetCompletionListEvent read FOnGetAutoCompletionList write FOnGetAutoCompletionList;
    property OnAutoCompletion: TNotifyEvent read FOnAutoCompletion write FOnAutoCompletion;
    property OnCancelAutoCompletion: TNotifyEvent read FOnCancelAutoCompletion write FOnCancelAutoCompletion;
    property OnGutterClick: TGutterClickEvent read FOnGutterClick write FOnGutterClick;
    property OnGutterRightClick: TGutterClickEvent read FOnGutterRightClick write FOnGutterRightClick;
    property OnGutterDblClick: TGutterClickEvent read FOnGutterDblClick write FOnGutterDblClick;
    property OnGutterDraw: TGutterDrawEvent read FOnGutterDraw write FOnGutterDraw;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnStatusChange: TNotifyEvent read FOnStatusChange write FOnStatusChange;
    property OnUndoChange: TUndoChangeEvent read FOnUndoChange write FOnUndoChange;
    property OnFind: TNotifyEvent read FOnFind write FOnFind;
    property OnReplace: TNotifyEvent read FOnReplace write FOnReplace;
    property OnCursorChange: TNotifyEvent read FOnCursorChange write FOnCursorChange;
    property OnOverwriteToggle: TAllowEvent read FOnOverwriteToggle write FOnOverwriteToggle;
    property OnURLClick: TurlClick read FOnURLClick write FOnURLClick;
    property OnHintForWord: TMemoHintEvent read FOnHintForWord write FOnHintForWord;
    property OnHintForToken: TMemoHintEvent read FOnHintForToken write FOnHintForToken;
    property OnWordComplete: TMemoWordEvent read FonWordComplete write FOnWordComplete;
    property OnInsertAutoCompletionEntry: TMemoInsertCompletionEntryEvent read FOnInsertAutoCompletionEntry write FOnInsertAutoCompletionEntry;
    property OnSortAutoCompletionList: TMemoSortCompletionListEvent read FOnSortAutoCompletionList write FOnSortAutoCompletionList;
    property OnTopLeftChanged: TNotifyEvent read FOnTopLeftChanged write FOnTopLeftChanged;
    property OnGetParameterHint: TMemoGetParameterHintEvent read FOnGetParameterHint write FOnGetParameterHint;
    property CompletionList: TAutoCompletionListBox read FlistCompletion;
    property OnActiveLineChange: TMemoActiveLineChangeEvent read FOnActiveLineChange write FOnActiveLineChange;
    property OnColumnChange: TMemoColumnChangeEvent read FOnColumnChange write FOnColumnChange;
    property OnMarkerAdded: TMemoMarkerAddedEvent read FOnMarkerAdded write FOnMarkerAdded;
    property OnMarkerRemoved: TMemoMarkerRemovedEvent read FOnMarkerRemoved write FOnMarkerRemoved;
    property OnFileDrop: TAdvMemoFileDropEvent read FOnFileDrop write FOnFileDrop;
    property OnScrollHint: TAdvMemoScrollHintEvent read FOnScrollHint write FOnScrollHint;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure DropText(X, Y: Integer; s: string);
    procedure MouseToCursor(X,Y: integer; var CursorX, CursorY: integer);
    procedure UpdateWrap;
    function GetWrappedLineIndex(Index: Integer): Integer;
    procedure CopyToClipBoard;
    procedure PasteFromClipBoard;
    procedure CutToClipBoard;
    procedure SelectAll;
    procedure DeleteLine;
    procedure ClearBreakpoints;
    procedure ClearModified;
    procedure ClearExecutableLines;
    procedure SetError(LineNo, ErrPos, ErrLen: Integer);
    procedure ClearErrors;
    procedure ClearLineErrors(LineNo: Integer);
    procedure ClearWordError(LineNo, LinePos: Integer);
    function CharFromPos(X, Y: integer): TFullPos;
    procedure PosFromText(TextPos: integer; var X, Y: Integer);
    procedure TextFromPos(X, Y: Integer; var TextPos: Integer);
    procedure DeleteSelection;
    procedure InsertText(AValue: string);
    procedure InsertTextAtXY(AValue: string; X, Y: Integer);
    procedure DeleteTextAtXY(X, Y, NumChar: Integer);
    procedure BlockIndent(FromLine, ToLine, Indent: Integer);
    function GetMarkers(Markers: TAdvMarkers): boolean;
    function MarkerAtLine(LineNo: Integer): boolean;
    procedure SaveMemoSettingsToFile(FileName: string); //saves the settings of the memo to a file
    procedure LoadMemoSettingsFromFile(FileName: string); //saves the settings of the memo to a file
    property Lines: TAdvMemoStrings read FLines write SetLines;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle;
    property Ctl3D: boolean read FCtl3D write SetCtl3D;
    property ClearType: boolean read FClearType write FClearType;
    property SyntaxStyles: TAdvCustomMemoStyler read FInternalStyles write SetMemoStyler;
    property Selection: string read GetSelText write SetSelText;
    property SelStart: integer read GetSelStart write SetSelStart;
    property SelLength: integer read GetSelLength write SetSelLength;
    property SelStartX: Integer read FSelStartX;
    property SelStartY: Integer read FSelStartY;
    property SelEndX: Integer read FSelEndX;
    property SelEndY: Integer read FSelEndY;
    function WordAtCursor: string;
    function WordTillCursor: string;
    function WordAtCursorPos(var Pos: Integer): string;
    function WordAtXY(X, Y: Integer): string;
    function TokenAtXY(X, Y: Integer): string;
    function FullWordAtXY(X, Y: Integer): string;
    function FullWordAtCursor: string;
    property CaseSensitive: boolean read FCaseSensitive write SetCaseSensitive default False;
    procedure ClearSelection;
    procedure ClearBookmarks;
    procedure ClearUndoRedo;
    procedure GotoBookmark(Index: Integer);
    function HasBookmarks: Boolean;
    function HasMarkers: boolean;
    function FindText(SearchStr: string; Options: TFindOptions): Integer;
    function FindTextPos(SearchStr: string; Options: TFindOptions): Integer;
    function FindAndReplace(SearchStr, NewStr: string; Options: TFindOptions): Integer;
    procedure Clear;
    procedure SetCursor(ACurX, ACurY: integer);
    procedure Undo;
    procedure Redo;
    procedure AddUndoStep(AUndoStep: TUndo);
    procedure HideHint;
    function CanUndo: boolean;
    function CanRedo: boolean;
    function CanCopy: boolean;
    function CanPaste: boolean;

    procedure GoToMarker(Marker: Integer);
    procedure GoToMarkerName(MarkerText: string);
    procedure AddMarker(LineIndex, ImageIndex: Integer); overload;
    procedure AddMarker(LineIndex, ImageIndex: Integer; MarkerText: string); overload;
    procedure RemoveMarker(LineIndex: integer);
    procedure ClearAllMarkers;

    function WordIsURL(s: string): Boolean; virtual;

    function AddCodeFolding(StartLineIndex, EndLineIndex: Integer): Boolean;
    procedure RemoveCodeFolding(StartLineIndex: Integer);
    procedure RemoveAllCodeFolding;
    function IsNode(LineIndex: Integer): Boolean;
    procedure ExpandAllNodes;
    procedure CollapseAllNodes;
    procedure ToggleNode(LineIndex: Integer);
    procedure AutoCodeFold;
    property ExpandNode[Index: Integer]: Boolean read GetExpandNode write SetExpandNode;

    property AcceptFiles: Boolean read FAcceptFiles write SetAcceptFiles default False;
    property ActiveLine: integer read FActiveLine write SetActiveLine;
    property Bookmark[Index: Integer]: Boolean read GetBookmark write SetBookmark;
    property Bookmarks[Index: Integer]: Integer read GetBookmarks write SetBookmarks;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clGray;
    property BreakPoint[Index: Integer]: Boolean read GetBreakPoint write SetBreakPoint;
    property LineModified[Index: Integer]: Boolean read GetModifiedState write SetModifiedState;
    property BreakpointColor: TColor read FBreakpointColor write SetBreakpointColor default clRed;
    property BreakpointTextColor: TColor read FBreakpointTextColor write SetBreakpointTextColor default clWhite;
    property Executable[Index: Integer]: Boolean read GetExecutable write SetExecutable;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default true;
    property Overwrite: Boolean read FOverwrite write FOverwrite;
    property CurX: integer read FCurX write SetCurX;
    property CurY: integer read FCurY write SetCurY;
    property DelErase: boolean read FDelErase write FDelErase;
    property TopLine: integer read FTopLine write SetTopLine;
    property LeftCol: integer read FLeftCol write SetLeftCol;
    property UrlAware: boolean read FUrlAware write SetUrlAware default True;
    property WantTab: boolean read FWantTab write FWantTab default True;
    property PrintOptions: TPrintOptions read FPrintOptions write SetPrintOptions;
    property Modified: boolean read GetModified write SetModified;
    property WordWrap: TWordWrapStyle read FWordWrap write SetWordWrap;
    function SaveToHTML(FileName: string; Fixedfonts: Boolean = True): Boolean;
    function SaveToRTF(FileName: string; Fixedfonts: Boolean = True): Boolean;
    {$IFNDEF TMSDOTNET}
    function SaveToRTFStream(AStream: TMemoryStream;Fixedfonts: Boolean = True): Boolean;
    {$ENDIF}
    procedure CopyHTMLToClipboard;
    function NumberOfPages(ACanvas: TCanvas; PageWidth, PageHeight: Integer): Integer;
    procedure PrintToCanvas(ACanvas: TCanvas; PageWidth, PageHeight, PageNr: Integer);
    procedure PrintPages(FromPage, ToPage : integer);
    procedure Print;
    procedure PrintSelection;
    procedure BeginUpdate;
    procedure EndUpdate;
    function GetVersionNr: Integer; virtual;
    function GetVersionString: string; virtual;
    property Version: string read GetVersion write SetVersion;
    procedure SetStyle(AStyle: TAdvMemoStyle);
    procedure SetComponentStyle(AStyle: TTMSStyle);    
  published
    property Cursor: TCursor read GetCursorEx write SetCursorEx;
  end;

  //---------------------------------------------------------
  //--------------------- TAdvStringList---------------------
  TAdvStringList = class(TStringList)
  private
    procedure ReadStrings(Reader: TReader);
    procedure WriteStrings(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
  end;

  TElementStyles = class;
  TAdvMemo = class;

  TRegionDefinition = class(TCollectionItem)
  private
    FRegionType: TRegionType;
    FRegionEnd: string;
    FIdentifier: string;
    FRegionStart: string;
    FShowComments: Boolean;
    procedure SetIdentifier(const Value: string);
    procedure SetRegionEnd(const Value: string);
    procedure SetRegionStart(const Value: string);
    procedure SetRegionType(const Value: TRegionType);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Identifier: string read FIdentifier write SetIdentifier;
    property RegionStart: string read FRegionStart write SetRegionStart;
    property RegionEnd: string read FRegionEnd write SetRegionEnd;
    property RegionType: TRegionType read FRegionType write SetRegionType;
    property ShowComments: Boolean read FShowComments write FShowComments;
  end;

  TRegionDefinitions = class(TCollection)
  private
    FComponent: TPersistent;
    function GetItem(Index: Integer): TRegionDefinition;
    procedure SetItem(Index: Integer; Value: TRegionDefinition);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Component: TPersistent);
    destructor Destroy; override;
    property Items[Index: Integer]: TRegionDefinition read GetItem write SetItem; default;
    function Add: TRegionDefinition;
    function Insert(Index: Integer): TRegionDefinition;
  end;


  TAdvCustomMemoStyler = class(TComponent)
  private
    FAllStyles: TElementStyles;
    FLineComment: string;
    FMultiCommentLeft: string;
    FMultiCommentRight: string;
    FCommentStyle: TCharStyle;
    FNumberStyle: TCharStyle;
    FlistAuto: Tstringlist;
    FHintParameter: THintParameter;
    FNumericChars: string;
    FHexIdentifier: string;
    FBlockEnd: string;
    FBlockStart: string;
    FLiteral: string;
    FCustomDraw: Boolean;
    FFilter: string;
    FDefaultExtension: string;
    FExtensions: string;
    FDescription: string;
    FStylerName: string;
    FRegionDefinitions: TRegionDefinitions;
    procedure SetStyle(const Index: integer; const Value: TCharStyle); virtual;
    procedure SetStyles(const Value: TElementStyles);
    procedure Update;
    procedure SetlistAuto(const Value: Tstringlist);
    procedure SetRegionDefinitions(Value: TRegionDefinitions);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Description: string read FDescription write FDescription;
    property Filter: string read FFilter write FFilter;
    property DefaultExtension: string read FDefaultExtension write FDefaultExtension;
    property Extensions: string read FExtensions write FExtensions;
    property StylerName: string read FStylerName write FStylerName;
    property BlockStart: string read FBlockStart write FBlockStart;
    property BlockEnd: string read FBlockEnd write FBlockEnd;
    property LineComment: string read FLineComment write FLineComment;
    property Literal: string read FLiteral write FLiteral;
    property MultiCommentLeft: string read FMultiCommentLeft write FMultiCommentLeft;
    property MultiCommentRight: string read FMultiCommentRight write FMultiCommentRight;
    property AllStyles: TElementStyles read FAllStyles write SetStyles;
    property CommentStyle: TCharStyle index 1 read FCommentStyle write SetStyle;
    property NumberStyle: TCharStyle index 2 read FNumberStyle write SetStyle;
    property AutoCompletion: TStringlist read FlistAuto write SetlistAuto;
    property HintParameter: THintParameter read fHintParameter write fhintparameter;
    property NumericChars: string read FNumericChars write FNumericChars;
    property HexIdentifier: string read FHexIdentifier write FHexIdentifier;
    property CustomDraw: Boolean read FCustomDraw write FCustomDraw;
    procedure DrawKeyword(Canvas: TCanvas; AKeyword: string; var ARect: TRect); virtual;
    property RegionDefinitions: TRegionDefinitions read FRegionDefinitions write SetRegionDefinitions;
  end;

  //--------------------------------------------------------------
  //         TAdvMemo (SYNTAX MEMO) - declaration
  //--------------------------------------------------------------
  TAdvMemo = class(TAdvCustomMemo)
  private
    { Private declarations }
    FInComment: boolean;
    FInBrackets: integer;
    procedure AdvSyntaxMemoChange(Sender: TObject);
    procedure AdvSyntaxMemoGutterDraw(Sender: TObject; ACanvas: TCanvas;
      LineNo: integer; rct: TRect);
    procedure AdvSyntaxMemoGutterClick(Sender: TObject; LineNo: integer);
    procedure LoadStyle;
  protected
    { Protected declarations }
    procedure Loaded; override;
    function IsWordBoundary(ch: char): boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RefreshMemo;
    property VisiblePosCount;
    property VisibleLineCount;
    property ActiveLine;
    property MarkerCount;
  published
    {TControl}
    property PopupMenu;
    {TCustomControl}
    property AcceptFiles;
    property ActiveLineSettings;
    property Align;
    property Anchors;
    property AutoCompletion;
    property AutoCompletionListImages;
    property AutoCorrect;
    property AutoHintParameterDelay;
    property AutoHintParameters;
    property AutoHintParameterPosition;
    property AutoIndent;
    property AutoExpand;
    property AutoThemeAdapt;
    property BlockShow;
    property BlockColor;
    property BlockLineColor;
    property BkColor default clWhite;
    property BorderColor;
    property BorderStyle;
    property BreakpointColor;
    property BreakpointTextColor;
    property CaseSensitive;
    property CodeFolding;
    property Ctl3D;
    property Cursor;
    property DelErase;
    property Enabled;
    property EnhancedHomeKey;
    property Gutter;
    property Font;
    property HiddenCaret;
    property HideSelection;
    property Lines;
    property MarkerList;
    property MemoChecker;
    property MemoSource;
    property PrintOptions;
    property ReadOnly default False;
    property RightMargin;
    property RightMarginColor;
    property ScrollBars;
    property ScrollHint;
    property ScrollMode;
    property SelColor;
    property SelBkColor;
    property ShowHint;
    property ShowRightMargin;
    property SmartTabs;
    property SyntaxStyles;
    property TabOrder;
    property TabSize;
    property TabStop;
    property TrimTrailingSpaces;
    property UndoLimit;
    property UrlAware;
    property UrlStyle;
    property UseStyler;
    property Version;
    property Visible;
    property WantTab;
    property WordWrap;
    property OnAutoCompletion;
    property OnBeforeAutoCompletion;
    property OnCancelAutoCompletion;
    property OnCursorChange;
    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnDragOver;
    property OnDragDrop;
{$IFNDEF TMSCLX}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
    property OnEndDrag;
    property OnGetAutoCompletionList;
    property OnHintForWord;
    property OnHintForToken;
    property OnStartDrag;
    property OnGutterClick;
    property OnGutterRightClick;
    property OnGutterDblClick;
    property OnGutterDraw;
    property OnChange;
    property OnOverwriteToggle;
    property OnSelectionChange;
    property OnStartAutoCompletion;
    property OnStatusChange;
    property OnUndoChange;
    property OnURLClick;
    property OnFind;
    property OnFileDrop;
    property OnReplace;
    property OnWordComplete;
    property OnInsertAutoCompletionEntry;
    property OnScrollHint;
    property OnSortAutoCompletionList;
    property OnGetParameterHint;
    property OnTopLeftChanged;
    property OnActiveLineChange;
    property OnColumnChange;
    property OnMarkerAdded;
    property OnMarkerRemoved;
  end;

  TElementStyle = class(TCollectionItem)
  private
    FKeyWords: TStringList;
    FFont: Tfont;
    FBGColor: Tcolor;
    FInfo: string;
    FStyleType: TStyleType;
    StyleNo: integer;
    FBracketStart: Char;
    FBracketEnd: Char;
    FSymbols: string;
    procedure SetColorbg(const Value: Tcolor);
    procedure SetFont(const Value: Tfont);
    procedure SetKeyWords(const Value: TStringList);
    procedure SetStyleType(const Value: TStyleType);
    //procedure SetBracket(const Value: Char);
    //function GetBracket: char;
    procedure SetBracketStart(const Value: Char);
    procedure SetBracketEnd(const Value: Char);
    function GetBracketStart: char;
    function GetBracketEnd: char;

    procedure SetSymbols(const Value: string);
  protected
    function GetDisplayName: string; override;
  public
    procedure Changed;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property KeyWords: TStringList read FKeyWords write SetKeyWords;
    property Font: TFont read FFont write SetFont;
    property BGColor: TColor read FBGColor write SetColorbg;
    property StyleType: TStyleType read FStyleType write SetStyleType;
    //property Bracket: Char read GetBracket write SetBracket;
    property BracketStart: Char read GetBracketStart write SetBracketStart;
    property BracketEnd: Char read GetBracketEnd write SetBracketEnd;
    property Symbols: string read FSymbols write SetSymbols;
    property Info: string read Finfo write Finfo;
  end;

  TElementStyles = class(TOwnedCollection)
  private
    FOwner: TAdvmemo;
    FModified: boolean;
    function GetItem(Index: integer): TElementStyle;
    procedure SetItem(Index: integer; const Value: TElementStyle);
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    function CreateItemClass: TCollectionItemClass; virtual;
    constructor Create(AOwner: TComponent);
    procedure Init;
    function Add: TElementStyle;
    function Insert(Index: integer): TElementStyle;
    property Items[Index: integer]: TElementStyle read GetItem write SetItem; default;
    function IsWordBoundary(ch: char): boolean;
  published
  end;

  TAdvMemoFindDialog = class(TComponent)
  private
    FDisplayMessage: boolean;
    FNotFoundMessage: string;
    FFindText: string;
    FAdvMemo: TAdvcustomMemo;
    FindDialog: TFinddialog;
    FOnFindDone: TNotifyEvent;
    FOnFindText: TNotifyEvent;
    FFocusMemo: boolean;
    function GetFindOptions: TFindOptions;
    function GetFindText: string;
  protected
    procedure Find(Sender: TObject);
    procedure Close(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    procedure Execute;
    procedure CloseDialog;
    property Options: TFindOptions read GetFindOptions;
  published
    property NotFoundMessage: string read FNotFoundMessage write FNotFoundMessage;
    property DisplayMessage: boolean read FDisplayMessage write FDisplayMessage default True;
    property FindText: string read GetFindText write FFindText;
    property FocusMemo: boolean read FFocusMemo write FFocusMemo default true;
    property AdvMemo: TAdvcustomMemo read FAdvMemo write FAdvMemo;
    property OnFindDone: TNotifyEvent read FOnFindDone write FOnFindDone;
    property OnFindText: TNotifyEvent read FOnFindText write FOnFindText;
  end;

  TAdvMemoFindReplaceDialog = class(TComponent)
  private
    FDisplayMessage: boolean;
    FNotFoundMessage: string;
    FFindText: string;
    FAdvMemo: TAdvcustomMemo;
    ReplaceDialog: TReplacedialog;
    FReplaceText: string;
    FOnReplaceDone: TNotifyEvent;
    FFocusMemo: boolean;
    function GetReplaceText: string;
    function GetFindText: string;
    function GetFindOptions: TFindOptions;
  protected
    procedure Find(Sender: TObject);
    procedure Close(Sender: TObject);
    procedure Replace(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    procedure Execute;
    procedure CloseDialog;
    property Options: TFindOptions read GetFindOptions;
  published
    property NotFoundMessage: string read FNotFoundMessage write FNotFoundMessage;
    property DisplayMessage: boolean read FDisplayMessage write FDisplayMessage default True;
    property FindText: string read GetFindText write FFindText;
    property ReplaceText: string read GetReplaceText write FReplaceText;
    property AdvMemo: TAdvcustomMemo read FAdvMemo write FAdvMemo;
    property FocusMemo: boolean read FFocusMemo write FFocusMemo default true;
    property OnReplaceDone: TNotifyEvent read FOnReplaceDone write FOnReplaceDone;
  end;

  TAdvMemoAction = class(TAction)
  private
    FControl: TAdvCustomMemo;
    procedure SetControl(Value: TAdvCustomMemo);
  protected
    function GetControl(Target: TObject): TAdvCustomMemo; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    destructor Destroy; override;
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    property Control: TAdvCustomMemo read FControl write SetControl;
  end;

  TAdvMemoCut = class(TAdvMemoAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TAdvMemoCopy = class(TAdvMemoAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TAdvMemoPaste = class(TAdvMemoAction)
  public
    procedure UpdateTarget(Target: TObject); override;
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TAdvMemoSelectAll = class(TAdvMemoAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TAdvMemoUndo = class(TAdvMemoAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TAdvMemoRedo = class(TAdvMemoAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    procedure UpdateTarget(Target: TObject); override;
  end;

  TAdvMemoDelete = class(TAdvMemoAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
    { UpdateTarget is required because TEditAction.UpdateTarget specifically
      checks to see if the action is TEditCut or TEditCopy }
    procedure UpdateTarget(Target: TObject); override;
  end;


implementation

uses
{$IFNDEF TMSCLX}
  ClipBrd, ComObj, ShellAPI
{$ENDIF}
{$IFDEF TMSCLX}
  QClipBrd
{$ENDIF}
{$IFDEF TMSDOTNET}
  , System.Runtime.InteropServices, System.Reflection.Emit, System.Reflection
{$ENDIF}
  ;

var
  SortingObject: TAdvCustomMemo;

const
{$IFDEF TMSCLX}
  VK_DELETE = KEY_DELETE;
  VK_BACK = KEY_BACKSPACE;
  VK_RETURN = KEY_RETURN;
  VK_HOME = KEY_HOME;
  VK_END = KEY_END;
  VK_PRIOR = KEY_PRIOR;
  VK_NEXT = KEY_NEXT;
  VK_INSERT = KEY_INSERT;
  VK_UP = KEY_UP;
  VK_DOWN = KEY_DOWN;
  VK_RIGHT = KEY_RIGHT;
  VK_LEFT = KEY_LEFT;
  VK_TAB = KEY_TAB;
  VK_SPACE = KEY_SPACE;
  VK_ESCAPE = KEY_ESCAPE;
  VK_MENU = KEY_MENU;
  VK_SHIFT = KEY_SHIFT;
  VK_CONTROL = KEY_CONTROL;
{$ENDIF}

  cmDelete = VK_DELETE;
  cmBackSpace = VK_BACK;
  cmNewLine = VK_RETURN;
  cmHome = VK_HOME;
  cmEnd = VK_END;
  cmPageUp = VK_PRIOR;
  cmPageDown = VK_NEXT;
  cmInsert = VK_INSERT;
  cmDelLine = 25; // Ctrl-Y
  cmSelectAll = 1; //Ctrl+A
  cmCopy = 3; // Ctrl-C
  cmCut = 24; // Ctrl-X
  cmPaste = 22; // Ctrl-V
  cmTab = VK_TAB;
  cmEscape = VK_ESCAPE;

  // theme changed notifier
  {$IFDEF DELPHI2007_LVL}
  {$EXTERNALSYM WM_THEMECHANGED}
  {$ENDIF}
  WM_THEMECHANGED = $031A;

  NODE_WIDTH = 16;

type
  TColorRecord = record
    RedValue: Byte; //  clRed = TColor($0000FF);   Low byte
    GreenValue: Byte; //  clLime = TColor($00FF00);  Middle byte
    BlueValue: Byte; //  clBlue = TColor($FF0000);  High byte
    SystemValue: Byte; //  becomes zero when calling ColorToRgb
  end;


  XPColorScheme = (xpNone, xpBlue, xpGreen, xpGray);

{$IFNDEF TMSDOTNET}
var
  GetCurrentThemeName: function(pszThemeFileName: PWideChar;
    cchMaxNameChars: Integer;
    pszColorBuff: PWideChar;
    cchMaxColorChars: Integer;
    pszSizeBuff: PWideChar;
    cchMaxSizeChars: Integer): THandle cdecl stdcall;

  IsThemeActive: function: BOOL cdecl stdcall;
{$ENDIF}


{$IFDEF TMSCLX}

function MakeLong(lo_, hi_: dword): dword;
begin
  Result := ((hi_ shl 16) and $FFFF0000) or (Lo_ and $0000FFFF);
end;

function MakeWord(lo_, hi_: word): word;
begin
  Result := ((hi_ shl 8) and $FF00) or (Lo_ and $00FF);
end;


function LoWord(t: Integer): word;
begin
  Result := t and $0000FFFF;
end;

function HiWord(t: Integer): word;
begin
  Result := (t and $FFFF0000) shr 16;
end;
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
            OleCheck(GetCurrentThemeName(PWideChar(FileName), 255,
              PWideChar(ColorScheme), 255, PWideChar(SizeName), 255));
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


function RemoveTrailingSpaces(const S: string): string;
var
  I: Integer;
begin
  I := Length(S);
  while (I > 0) and (S[I] = #32) do Dec(I);
  Result := Copy(S, 1, I);
end;

(*
function SortAutoCompletList(List: TStringList; Index1, Index2: Integer): Integer;
begin
  if Assigned(SortingObject) then
    result := SortingObject.SortAutoCompletList(List, Index1, Index2)
  else
    result := Index1;
end;
*)

procedure DrawError(Canvas: TCanvas; cr: TRect);
var
  l, o: Integer;
begin
  Canvas.Pen.Color := clRed;
  Canvas.Pen.Width := 1;
  l := (cr.Left div 2) * 2;
  if (l mod 4) = 0 then o := 2 else o := 0;

  Canvas.MoveTo(l, cr.Bottom + o - 1);
  while l < cr.Right do
  begin
    if o = 2 then o := 0 else o := 2;
    Canvas.LineTo(l + 2, cr.bottom + o - 1);
    Inc(l, 2);
  end;
end;

procedure DrawGradient(Canvas: TCanvas; FromColor, ToColor: TColor; Steps: Integer; R: TRect; Direction: Boolean);
var
  diffr, startr, endr: Integer;
  diffg, startg, endg: Integer;
  diffb, startb, endb: Integer;
  iend: Integer;
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
    for i := 0 to Steps - 1 do
    begin
      endr := startr + Round(rstepr * i);
      endg := startg + Round(rstepg * i);
      endb := startb + Round(rstepb * i);
      stepw := Round(i * rstepw);
      Pen.Color := endr + (endg shl 8) + (endb shl 16);
      Brush.Color := Pen.Color;
      if Direction then
      begin
        iend := R.Left + stepw + Trunc(rstepw) + 1;
        if iend > R.Right then
          iend := R.Right;
        Rectangle(R.Left + stepw, R.Top, iend, R.Bottom)
      end
      else
      begin
        iend := R.Top + stepw + Trunc(rstepw) + 1;
        if iend > r.Bottom then
          iend := r.Bottom;
        Rectangle(R.Left, R.Top + stepw, R.Right, iend);
      end;
    end;
  end;
end;


//--------------------------------------------------------------
//        POINT IN RECT
//--------------------------------------------------------------

function PointInRect(P: TPoint; rct: TRect): boolean;
begin
  with rct do
    Result := (Left <= P.X) and (Top <= P.Y) and
      (Right >= P.X) and (Bottom >= P.Y);
end;

//--------------------------------------------------------------
//        SWAP
//--------------------------------------------------------------

procedure Swap(var I1, I2: integer);
var
  temp: integer;
begin
  temp := I1;
  I1 := I2;
  I2 := temp;
end;

//--------------------------------------------------------------
//        ORDER POS
//--------------------------------------------------------------

procedure OrderPos(var StartX, StartY, EndX, EndY: integer);
begin
  if (EndY < StartY) or
    ((EndY = StartY) and (EndX < StartX)) then
  begin
    Swap(StartX, EndX);
    Swap(StartY, EndY);
  end;
end;

//--------------------------------------------------------------
//        TOTAL RECT
//--------------------------------------------------------------

function TotalRect(rct1, rct2: TRect): TRect;
begin
  Result := rct1;
  with Result do
  begin
    if rct2.Left < Left then Left := rct2.Left;
    if rct2.Top < Top then Top := rct2.Top;
    if rct2.Right > Right then Right := rct2.Right;
    if rct2.Bottom > Bottom then Bottom := rct2.Bottom;
  end;
end;

{ TAdvCustomMemo }

function TAdvCustomMemo.GetMarkers(Markers: TAdvMarkers): boolean;
begin
  Result := FMarkerList.Markers.GetMarkers(Markers);
end;

function TAdvCustomMemo.MarkerAtLine(LineNo: Integer): Boolean;
begin
  Result := FMarkerList.Markers.MarkerAtLine(LineNo);
end;

procedure TAdvCustomMemo.GoToMarker(Marker: integer);
var
  LineNo: Integer;
begin
  if (Marker >= 0) and (Marker < FMarkerList.Markers.Count) then
  begin
    LineNo := FMarkerList.Markers.Items[Marker].LineNumber;
    CurX := 0;
    CurY := LineNo;
  end
  else
    raise Exception.Create('Invalid marker index');
end;

procedure TAdvCustomMemo.GoToMarkerName(MarkerText: string);
var
  LineNo,i: Integer;

begin
  for i := 1 to FMarkerList.Markers.Count do
  begin
    if FMarkerList.Markers[i - 1].Text = MarkerText then
    begin
      LineNo := FMarkerList.Markers[i - 1].LineNumber;

      if CodeFolding.Enabled then
        ExpandParents(LineNo);

      CurX := 0;
      CurY := LineNo;
      Exit;
    end;
  end;
  raise Exception.Create('Marker name not found');
end;


//------------------------------------------------------------
//   SAVE AND LOAD MEMO SETTINGS
//------------------------------------------------------------

procedure TAdvCustomMemo.SaveMemoSettingsToFile(FileName: string); //saves the settings of the memo to a file
var
  ini: TIniFile;
  strStyleString: string;
begin
  ini := TIniFile.Create(FileName);
  with ini do
  begin
    // active line
    WriteString('Memo Settings', 'ActiveLineColor', ColorTostring(ActiveLineSettings.ActiveLineColor));
    WriteString('Memo Settings', 'ActiveLineTextColor', ColorTostring(ActiveLineSettings.ActiveLineTextColor));
    WriteBool('Memo Settings', 'ShowActiveLine', ActiveLineSettings.ShowActiveLine);
    WriteBool('Memo Settings', 'ShowActiveLineIndicator', ActiveLineSettings.ShowActiveLineIndicator);

    // gutter
    WriteBool('Memo Settings', 'ShowGutter', fGutter.FShowGutter);
    WriteInteger('Memo Settings', 'GutterDigitCount', fGutter.FDigitCount);
    WriteString('Memo Settings', 'GutterColor', ColorToString(fGutter.GutterColor));
    WriteString('Memo Settings', 'GutterColorTo', ColorToString(fGutter.GutterColorTo));
    WriteInteger('Memo Settings', 'GutterMargin', fGutter.FGutterMargin);
    WriteInteger('Memo Settings', 'GutterWidth', fGutter.FGutterWidth);
    WriteBool('Memo Settings', 'ShowLineNumbers', fGutter.FShowLineNumbers);
    WriteInteger('Memo Settings', 'LineNumberStart', fGutter.FLineNumberStart);
    WriteString('Memo Settings', 'LineNumberTextColor', ColorToString(fGutter.FLineNumberTextColor));
    WriteBool('Memo Settings', 'ShowLeadingZeros', fGutter.FShowLeadingZeros);
    WriteString('Memo Settings', 'GutterFontName', fGutter.Font.Name);
    WriteString('Memo Settings', 'GutterFontColor', ColorToString(fGutter.Font.Color));
    WriteInteger('Memo Settings', 'GutterFontSize', fGutter.Font.Size);
    WriteString('Memo Settings', 'GutterNumberSuffix', fGutter.NumberSuffix);
    
    if fsBold in fGutter.FFont.Style then strStyleString := 'fsBold';
    if fsItalic in fGutter.FFont.Style then strStyleString := strStyleString + 'fsItalic';
    if fsUnderline in fGutter.FFont.Style then strStyleString := strStyleString + 'fsUnderline';
    if fsStrikeOut in fGutter.FFont.Style then strStyleString := strStyleString + 'fsStrikeOut';

    WriteString('Memo Settings', 'GutterFontStyle', strStyleString);
    strStyleString := ''; //reset

    //  autocompletion
    WriteBool('Memo Settings', 'AutoCompletionActive', FAutoCompletion.FActive);
    WriteString('Memo Settings', 'AutoCompletionColor', ColorToString(FAutoCompletion.fColor));
    WriteString('Memo Settings', 'AutoCompletionColorEvent', ColorToString(FAutoCompletion.FColorEvent));
    WriteString('Memo Settings', 'AutoCompletionColorFunc', ColorToString(FAutoCompletion.FColorFunc));
    WriteString('Memo Settings', 'AutoCompletionColorIdentifier', ColorToString(FAutoCompletion.FColorIdentifier));
    WriteString('Memo Settings', 'AutoCompletionColorMethod', ColorToString(FAutoCompletion.FColorMethod));
    WriteString('Memo Settings', 'AutoCompletionColorProc', ColorToString(FAutoCompletion.FColorProc));
    WriteString('Memo Settings', 'AutoCompletionColorVar', ColorToString(FAutoCompletion.FColorVar));
    WriteInteger('Memo Settings', 'AutoCompletionDelay', FAutoCompletion.Delay);
    WriteBool('Memo Settings', 'AutoCompletionShowImages', FAutoCompletion.ShowImages);
    WriteBool('Memo Settings', 'AutoCompletionSizeDropDown', FAutoCompletion.SizeDropDown);
    WriteInteger('Memo Settings', 'AutoCompletionWidth', FAutoCompletion.Width);
    WriteString('Memo Settings', 'AutoCompletionFontName', FAutoCompletion.FFont.Name);
    WriteString('Memo Settings', 'AutoCompletionFontColor', ColorToString(FAutoCompletion.FFont.Color));
    WriteInteger('Memo Settings', 'AutoCompletionFontSize', FAutoCompletion.FFont.Size);
    if fsBold in FAutoCompletion.FFont.Style then
      strStyleString := 'fsBold';
    if fsItalic in FAutoCompletion.FFont.Style then
      strStyleString := strStyleString + 'fsItalic';
    if fsUnderline in FAutoCompletion.FFont.Style then
      strStyleString := strStyleString + 'fsUnderline';
    if fsStrikeOut in FAutoCompletion.FFont.Style then
      strStyleString := strStyleString + 'fsStrikeOut';

    WriteString('Memo Settings', 'AutoCompletionFontStyle', strStyleString);
    strStyleString := ''; //reset


       //  autohintparameter
    WriteInteger('Memo Settings', 'AutoHintParameterDelay', FAutoHintParameterDelay);
    case FAutoHintParameters of
      hpAuto: WriteString('Memo Settings', 'AutoHintParameters', 'hpAuto');
      hpNone: WriteString('Memo Settings', 'AutoHintParameters', 'hpNone');
      hpManual: WriteString('Memo Settings', 'AutoHintParameters', 'hpManual');
    end;

    if fAutoHintParameterPos = hpBelowCode then
      WriteString('Memo Settings', 'AutoHintParameterPosition', 'hpBelowCode')
    else
      WriteString('Memo Settings', 'AutoHintParameterPosition', 'hpAboveCode');

    //  general
    WriteBool('Memo Settings', 'AutoIndent', FAutoIndent);
    WriteString('Memo Settings', 'BkColor', ColorToString(FBkColor));
    WriteString('Memo Settings', 'BlockColor', ColorToString(FBlockColor));
    WriteString('Memo Settings', 'BlockLineColor', ColorToString(FBlockLineColor));
    WriteString('Memo Settings', 'BreakpointColor', ColorToString(FBreakpointColor));
    WriteString('Memo Settings', 'BreakpointTextColor', ColorToString(FBreakpointTextColor));
    WriteBool('Memo Settings', 'BlockShow', FBlockShow);
    WriteBool('Memo Settings', 'CaseSensitive', FCaseSensitive);
    WriteBool('Memo Settings', 'DelErase', FDelErase);
    WriteBool('Memo Settings', 'EnhancedHomeKey', FEnhancedHomeKey);

    WriteString('Memo Settings', 'FontName', FFont.Name);
    WriteString('Memo Settings', 'FontColor', ColorToString(FFont.Color));
    WriteInteger('Memo Settings', 'FontSize', FFont.Size);
    if fsBold in FFont.Style then
      strStyleString := 'fsBold';
    if fsItalic in FFont.Style then
      strStyleString := strStyleString + 'fsItalic';
    if fsUnderline in FFont.Style then
      strStyleString := strStyleString + 'fsUnderline';
    if fsStrikeOut in FFont.Style then
      strStyleString := strStyleString + 'fsStrikeOut';

    WriteString('Memo Settings', 'FontStyle', strStyleString);
    strStyleString := ''; //reset

    WriteBool('Memo Settings', 'HiddenCaret', FHiddenCaret);
    WriteBool('Memo Settings', 'HideSelection', FHideSelection);

    WriteBool('Memo Settings', 'ReadOnly', FReadOnly);

    WriteInteger('Memo Settings', 'RightMargin', FRightMargin);
    WriteString('Memo Settings', 'RightMarginColor', ColorToString(FRightMarginColor));
    WriteBool('Memo Settings', 'ShowRightMargin', FShowRightMargin);

    WriteBool('Memo Settings', 'SmartTabs', FSmartTabs);
    WriteInteger('Memo Settings', 'TabSize', FTabSize);

    WriteBool('Memo Settings', 'TrimTralingSpaces', FTrimTrailingSpaces);

    WriteInteger('Memo Settings', 'UndoLimit', fUndolimit);
    WriteBool('Memo Settings', 'URLAware', FUrlAware);
    WriteString('Memo Settings', 'URLBKColor', ColorToString(FUrlstyle.FBkColor));
    WriteString('Memo Settings', 'URLTextColor', ColorToString(FUrlstyle.FTextColor));

    if fsBold in fURLStyle.FStyle then
      strStyleString := 'fsBold';
    if fsItalic in fURLStyle.FStyle then
      strStyleString := strStyleString + 'fsItalic';
    if fsUnderline in fURLStyle.FStyle then
      strStyleString := strStyleString + 'fsUnderline';
    if fsStrikeOut in fURLStyle.FStyle then
      strStyleString := strStyleString + 'fsStrikeOut';
      
    WriteString('Memo Settings', 'URLStyleStyle', strStyleString);
    strStyleString := ''; //reset

    WriteBool('Memo Settings', 'UseStyler', FUseStyler);
    WriteBool('Memo Settings', 'WantTab', FWantTab);
    case fWordWrap of
    wwNone: WriteString('Memo Settings', 'WordWrap', 'wwNone');
    wwClientWidth: WriteString('Memo Settings', 'WordWrap', 'wwClientWidth');
    wwRightMargin: WriteString('Memo Settings', 'WordWrap', 'wwRightMargin');
    end;

    // print options
    WriteInteger('Memo Settings', 'PrintMarginLeft', PrintOptions.FMarginLeft);
    WriteInteger('Memo Settings', 'PrintMarginRight', PrintOptions.FMarginRight);
    WriteInteger('Memo Settings', 'PrintMarginTop', PrintOptions.FMarginTop);
    WriteInteger('Memo Settings', 'PrintMarginBottom', PrintOptions.FMarginBottom);
    WriteString('Memo Settings', 'PrintJobName', PrintOptions.FJobName);
    WriteBool('Memo Settings', 'PrintPageNr', PrintOptions.FPageNr);
    WriteString('Memo Setings', 'PrintPagePrefix', PrintOptions.FPagePrefix);
    WriteBool('Memo Settings', 'PrintLineNumbers', PrintOptions.FPrintLineNumbers);
    WriteString('Memo Settings', 'PrintTitle', PrintOptions.FTitle);

    // markerlist
    WriteInteger('Memo Settings', 'DefaultMarkerImageIndex', FMarkerList.fDefaultMarkerImageIndex);
    WriteBool('Memo Settings', 'UseDefaultMarkerImageIndex', FMarkerList.fUseDefaultMarkerImageIndex);

    Free; //free ini
  end; // with
end;

procedure TAdvCustomMemo.LoadMemoSettingsFromFile(FileName: string); //saves the settings of the memo to a file
var
  ini: TIniFile;
  strStyleString: string;
begin
    //load the settings of a file to the memo - ini format
  if not FileExists(FileName) then
    Exit;

  ini := TIniFile.Create(FileName);
  with ini do
  begin
    FActiveLineSettings.FActiveLineColor := StringToColor(ReadString('Memo Settings', 'ActiveLineColor', ColorToString(FActiveLineSettings.FActiveLineColor)));
    FActiveLineSettings.FActiveLineTextColor := StringToColor(ReadString('Memo Settings', 'ActiveLineTextColor', ColorToString(FActiveLineSettings.FActiveLineTextColor)));
    FActiveLineSettings.FShowActiveLine := ReadBool('Memo Settings', 'ShowActiveLine', FActiveLineSettings.FShowActiveLine);
    FActiveLineSettings.FShowActiveLineIndicator := ReadBool('Memo Settings', 'ShowActiveLineIndicator', FActiveLineSettings.FShowActiveLineIndicator);

    fGutter.FShowGutter := ReadBool('Memo Settings', 'ShowGutter', fGutter.FShowGutter);
    fGutter.FDigitCount := ReadInteger('Memo Settings', 'GutterDigitCount', fGutter.FDigitCount);
    fGutter.GutterColor := StringToColor(ReadString('Memo Settings', 'GutterColor', ColorToString(fGutter.GutterColor)));
    fGutter.GutterColorTo := StringToColor(ReadString('Memo Settings', 'GutterColorTo', ColorToString(fGutter.GutterColorTo)));
    fGutter.FGutterMargin := ReadInteger('Memo Settings', 'GutterMargin', fGutter.FGutterMargin);
    fGutter.FGutterWidth := ReadInteger('Memo Settings', 'GutterWidth', fGutter.FGutterWidth);
    fGutter.FShowLineNumbers := ReadBool('Memo Settings', 'ShowLineNumbers', fGutter.FShowLineNumbers);
    fGutter.FLineNumberStart := ReadInteger('Memo Settings', 'LineNumberStart', fGutter.FLineNumberStart);
    fGutter.FLineNumberTextColor := StringToColor(ReadString('Memo Settings', 'LineNumberTextColor', ColorToString(fGutter.FLineNumberTextColor)));
    fGutter.FShowLeadingZeros := ReadBool('Memo Settings', 'ShowLeadingZeros', fGutter.FShowLeadingZeros);
    fGutter.Font.Name := ReadString('Memo Settings', 'GutterFontName', fGutter.Font.Name);
    fGutter.Font.Color := StringToColor(ReadString('Memo Settings', 'GutterFontColor', ColorToString(fGutter.Font.Color)));
    fGutter.Font.Size := ReadInteger('Memo Settings', 'GutterFontSize', fGutter.Font.Size);
    fGutter.NumberSuffix := ReadString('Memo Settings', 'GutterNumberSuffix', fGutter.NumberSuffix);

    strStyleString := ReadString('Memo Settings', 'GutterFontStyle', strStyleString);

    if Pos('fsBold', strStyleString) > 0 then
      fGutter.FFont.Style := fGutter.FFont.Style + [fsBold];
    if Pos('fsItalic', strStyleString) > 0 then
      fGutter.FFont.Style := fGutter.FFont.Style + [fsItalic];
    if Pos('fsUnderline', strStyleString) > 0 then
      fGutter.FFont.Style := fGutter.FFont.Style + [fsUnderline];
    if Pos('fsStrikeOut', strStyleString) > 0 then
      fGutter.FFont.Style := fGutter.FFont.Style + [fsStrikeOut];
      
    strStyleString := ''; //reset

       //  autocompletion
    FAutoCompletion.FActive := ReadBool('Memo Settings', 'AutoCompletionActive', FAutoCompletion.FActive);
    FAutoCompletion.fColor := StringToColor(ReadString('Memo Settings', 'AutoCompletionColor', ColorToString(FAutoCompletion.fColor)));
    FAutoCompletion.FColorEvent := StringToColor(ReadString('Memo Settings', 'AutoCompletionColorEvent', ColorToString(FAutoCompletion.FColorEvent)));
    FAutoCompletion.FColorFunc := StringToColor(ReadString('Memo Settings', 'AutoCompletionColorFunc', ColorToString(FAutoCompletion.FColorFunc)));
    FAutoCompletion.FColorIdentifier := StringToColor(ReadString('Memo Settings', 'AutoCompletionColorIdentifier', ColorToString(FAutoCompletion.FColorIdentifier)));
    FAutoCompletion.FColorMethod := StringToColor(ReadString('Memo Settings', 'AutoCompletionColorMethod', ColorToString(FAutoCompletion.FColorMethod)));
    FAutoCompletion.FColorProc := StringToColor(ReadString('Memo Settings', 'AutoCompletionColorProc', ColorToString(FAutoCompletion.FColorProc)));
    FAutoCompletion.FColorVar := StringToColor(ReadString('Memo Settings', 'AutoCompletionColorVar', ColorToString(FAutoCompletion.FColorVar)));
    FAutoCompletion.Delay := ReadInteger('Memo Settings', 'AutoCompletionDelay', FAutoCompletion.Delay);
    FAutoCompletion.ShowImages := ReadBool('Memo Settings', 'AutoCompletionShowImages', FAutoCompletion.ShowImages);
    FAutoCompletion.SizeDropDown := ReadBool('Memo Settings', 'AutoCompletionSizeDropDown', FAutoCompletion.SizeDropDown);
    FAutoCompletion.Width := ReadInteger('Memo Settings', 'AutoCompletionWidth', FAutoCompletion.Width);
    fAutoCompletion.FFont.Name := ReadString('Memo Settings', 'AutoCompletionFontName', fAutoCompletion.FFont.Name);
    FAutoCompletion.FFont.Color := StringToColor(ReadString('Memo Settings', 'AutoCompletionFontColor', ColorToString(FAutoCompletion.FFont.Color)));
    FAutoCompletion.FFont.Size := ReadInteger('Memo Settings', 'AutoCompletionFontSize', FAutoCompletion.FFont.Size);

    strStyleString := ReadString('Memo Settings', 'AutoCompletionFontStyle', strStyleString);
    
    if Pos('fsBold', strStyleString) > 0 then
      FAutoCompletion.FFont.Style := FAutoCompletion.FFont.Style + [fsBold];
    if Pos('fsItalic', strStyleString) > 0 then
      FAutoCompletion.FFont.Style := FAutoCompletion.FFont.Style + [fsItalic];
    if Pos('fsUnderline', strStyleString) > 0 then
      FAutoCompletion.FFont.Style := FAutoCompletion.FFont.Style + [fsUnderline];
    if Pos('fsStrikeOut', strStyleString) > 0 then
      FAutoCompletion.FFont.Style := FAutoCompletion.FFont.Style + [fsStrikeOut];
      
    strStyleString := ''; //reset

    //  autohintparameter
    FAutoHintParameterDelay := ReadInteger('Memo Settings', 'AutoHintParameterDelay', FAutoHintParameterDelay);

    if ReadString('Memo Settings', 'AutoHintParameters', 'hpAuto') = 'hpAuto' then
      FAutoHintParameters := hpAuto;
    if ReadString('Memo Settings', 'AutoHintParameters', 'hpAuto') = 'hpNone' then
      FAutoHintParameters := hpNone;
    if ReadString('Memo Settings', 'AutoHintParameters', 'hpAuto') = 'hpManual' then
      FAutoHintParameters := hpManual;

    if ReadString('Memo Settings', 'AutoHintParameterPosition', 'hpBelowCode') = 'hpBelowCode' then
      fAutoHintParameterPos := hpBelowCode
    else
      fAutoHintParameterPos := hpAboveCode;

    //  general
    FAutoIndent := ReadBool('Memo Settings', 'AutoIndent', FAutoIndent);
    FBkColor := StringToColor(ReadString('Memo Settings', 'BkColor', ColorToString(FBkColor)));
    FBlockColor := StringToColor(ReadString('Memo Settings', 'BlockColor', ColorToString(FBlockColor)));
    FBlockLineColor := StringToColor(ReadString('Memo Settings', 'BlockLineColor', ColorToString(FBlockLineColor)));
    FBreakpointColor := StringToColor(ReadString('Memo Settings', 'BreakpointColor', ColorToString(FBreakpointColor)));
    FBreakpointTextColor := StringToColor(ReadString('Memo Settings', 'BreakpointTextColor', ColorToString(FBreakpointTextColor)));
    FBlockShow := ReadBool('Memo Settings', 'BlockShow', FBlockShow);
    FCaseSensitive := ReadBool('Memo Settings', 'CaseSensitive', FCaseSensitive);
    FDelErase := ReadBool('Memo Settings', 'DelErase', FDelErase);
    FEnhancedHomeKey := ReadBool('Memo Settings', 'EnhancedHomeKey', FEnhancedHomeKey);

    FFont.Name := ReadString('Memo Settings', 'FontName', FFont.Name);
    FFont.Color := StringToColor(ReadString('Memo Settings', 'FontColor', ColorToString(FFont.Color)));
    FFont.Size := ReadInteger('Memo Settings', 'FontSize', FFont.Size);

    strStyleString := ReadString('Memo Settings', 'FontStyle', strStyleString);
    
    if Pos('fsBold', strStyleString) > 0 then
      FFont.Style := FFont.Style + [fsBold];
    if Pos('fsItalic', strStyleString) > 0 then
      FFont.Style := FFont.Style + [fsItalic];
    if Pos('fsUnderline', strStyleString) > 0 then
      FFont.Style := FFont.Style + [fsUnderline];
    if Pos('fsStrikeOut', strStyleString) > 0 then
      FFont.Style := FFont.Style + [fsStrikeOut];
      
    strStyleString := ''; //reset

    FHiddenCaret := ReadBool('Memo Settings', 'HiddenCaret', FHiddenCaret);
    FHideSelection := ReadBool('Memo Settings', 'HideSelection', FHideSelection);

    FReadOnly := ReadBool('Memo Settings', 'ReadOnly', FReadOnly);

    FRightMargin := ReadInteger('Memo Settings', 'RightMargin', FRightMargin);
    FRightMarginColor := StringToColor(ReadString('Memo Settings', 'RightMarginColor', ColorToString(FRightMarginColor)));
    FShowRightMargin := ReadBool('Memo Settings', 'ShowRightMargin', FShowRightMargin);

    FSmartTabs := ReadBool('Memo Settings', 'SmartTabs', FSmartTabs);
    FTabSize := ReadInteger('Memo Settings', 'TabSize', FTabSize);

    FTrimTrailingSpaces := ReadBool('Memo Settings', 'TrimTralingSpaces', FTrimTrailingSpaces);

    FUndolimit := ReadInteger('Memo Settings', 'UndoLimit', FUndolimit);
    FUrlAware := ReadBool('Memo Settings', 'URLAware', FUrlAware);
    FUrlstyle.FBkColor := StringToColor(ReadString('Memo Settings', 'URLBKColor', ColorToString(FUrlstyle.FBkColor)));
    FUrlstyle.FTextColor := StringToColor(ReadString('Memo Settings', 'URLTextColor', ColorToString(FUrlstyle.FTextColor)));

    strStyleString := ReadString('Memo Settings', 'URLStyleStyle', strStyleString);
    
    if Pos('fsBold', strStyleString) > 0 then
      fURLStyle.Style := fURLStyle.Style + [fsBold];
    if Pos('fsItalic', strStyleString) > 0 then
      fURLStyle.Style := fURLStyle.Style + [fsItalic];
    if Pos('fsUnderline', strStyleString) > 0 then
      fURLStyle.Style := fURLStyle.Style + [fsUnderline];
    if Pos('fsStrikeOut', strStyleString) > 0 then
      fURLStyle.Style := fURLStyle.Style + [fsStrikeOut];

    strStyleString := ''; //reset

    FUseStyler := ReadBool('Memo Settings', 'UseStyler', FUseStyler);

    FWantTab := ReadBool('Memo Settings', 'WantTab', FWantTab);

    if ReadString('Memo Settings', 'WordWrap', 'wwNone') = 'wwNone' then
      fWordWrap := wwNone;
    if ReadString('Memo Settings', 'WordWrap', 'wwNone') = 'wwClientWidth' then
      fWordWrap := wwClientWidth;
    if ReadString('Memo Settings', 'WordWrap', 'wwNone') = 'wwRightMargin' then
      fWordWrap := wwRightMargin;

       // print options
    PrintOptions.FMarginLeft := ReadInteger('Memo Settings', 'PrintMarginLeft', PrintOptions.FMarginLeft);
    PrintOptions.FMarginRight := ReadInteger('Memo Settings', 'PrintMarginRight', PrintOptions.FMarginRight);
    PrintOptions.FMarginTop := ReadInteger('Memo Settings', 'PrintMarginTop', PrintOptions.FMarginTop);
    PrintOptions.FMarginBottom := ReadInteger('Memo Settings', 'PrintMarginBottom', PrintOptions.FMarginBottom);
    PrintOptions.FJobName := ReadString('Memo Settings', 'PrintJobName', PrintOptions.FJobName);
    PrintOptions.FPageNr := ReadBool('Memo Settings', 'PrintPageNr', PrintOptions.FPageNr);
    PrintOptions.FPagePrefix := ReadString('Memo Setings', 'PrintPagePrefix', PrintOptions.FPagePrefix);
    PrintOptions.FPrintLineNumbers := ReadBool('Memo Settings', 'PrintLineNumbers', PrintOptions.FPrintLineNumbers);
    PrintOptions.FTitle := ReadString('Memo Settings', 'PrintTitle', PrintOptions.FTitle);

       //  markerlist
    FMarkerList.fDefaultMarkerImageIndex := ReadInteger('Memo Settings', 'DefaultMarkerImageIndex', FMarkerList.fDefaultMarkerImageIndex);
    FMarkerList.fUseDefaultMarkerImageIndex := ReadBool('Memo Settings', 'UseDefaultMarkerImageIndex', FMarkerList.fUseDefaultMarkerImageIndex);

    Free; //free ini
  end; // with
  Invalidate;
end;



//--------------------------------------------------------------
//        SET CURSOR
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetCursor(ACurX, ACurY: integer);
begin
  ClearSelection;
  FCurX := 0;
  CurY := ACurY;
  CurX := ACurX;
end;


//--------------------------------------------------------------
//        CLEAR
//--------------------------------------------------------------

procedure TAdvCustomMemo.Clear;
begin
  CurX := 0;
  CurY := 0;
  FLeftCol := 0;
  FTopLine := 0;
  Fletrefresh := False;
  InternalLines.Clear;
  Invalidate;
  CurY := 0;
  CurX := 0;
  FSelStartX := 0;
  FSelEndX := 0;
  FSelStartY := 0;
  FSelEndY := 0;
  Fletrefresh := True;
  LinesChanged(nil);
  ClearLineStyles;
end;

procedure TAdvCustomMemo.AddMarker(LineIndex, ImageIndex: integer);
begin
  FMarkerList.Markers.AddMarker(LineIndex, ImageIndex);
  DoMarkerAdded(LineIndex, '');
  Gutter.Invalidate;
end;

procedure TAdvCustomMemo.AddMarker(LineIndex, ImageIndex: integer; MarkerText: string);
begin
  FMarkerList.Markers.AddMarker(LineIndex, ImageIndex, MarkerText);
  DoMarkerAdded(LineIndex, MarkerText);
  Gutter.Invalidate;  
end;

procedure TAdvCustomMemo.RemoveMarker(LineIndex: integer);
begin
  FMarkerList.Markers.RemoveMarker(LineIndex);
  DoMarkerRemoved(LineIndex);
  FGutter.Invalidate;
end;

function TAdvCustomMemo.WordIsURL(s: string): Boolean;
begin
  s := LowerCase(s);

  Result := (AnsiPos('http://', s) = 1) or
            (AnsiPos('mailto:', s) = 1) or
            (AnsiPos('www.', s) = 1) or
            (AnsiPos('https://', s) = 1) or
            (AnsiPos('ftp://', s) = 1) or
            (AnsiPos('nntp://', s) = 1);
end;

procedure TAdvCustomMemo.ClearAllMarkers;
begin
  FMarkerList.Markers.Clear;
  Gutter.Invalidate;  
end;

//--------------------------------------------------------------
//        SELECT ALL
//--------------------------------------------------------------

procedure TAdvCustomMemo.SelectAll;
begin
  FSelStartY := 0;
  FSelStartX := 0;
  if (InternalLines.Count > 0) then
  begin
    FSelEndY := InternalLines.Count - 1;
    FSelEndX := Length(InternalLines[InternalLines.Count - 1]);
  end;
  Invalidate;
  if Assigned(OnSelectionChange) then
    OnSelectionChange(Self);
end;
//--------------------------------------------------------------
//        COPY TO CLIPBOARD
//--------------------------------------------------------------

procedure TAdvCustomMemo.CopyToClipBoard;
begin
{$IFDEF DELPHI_UNICODE}
  Clipboard.AsText := GetSelText;
{$ENDIF}

{$IFNDEF DELPHI_UNICODE}
{$IFDEF TMSCLX}
  Clipboard.AsText := GetSelText;
{$ENDIF}

{$IFNDEF TMSCLX}
{$IFNDEF TMSDOTNET}
  ClipBoard.SetTextBuf(PChar(GetSelText));
{$ENDIF}
{$IFDEF TMSDOTNET}
  ClipBoard.SetTextBuf(GetSelText);
{$ENDIF}
{$ENDIF}
{$ENDIF}
end;
//--------------------------------------------------------------
//        PASTE FROM CLIPBOARD
//--------------------------------------------------------------

procedure TAdvCustomMemo.PasteFromClipBoard;
var
  H, len, cX, cY, ss,i : integer;
  Buff: string;
begin
  if FReadOnly or not EditCanModify then
    Exit;

  cX := CurX;
  cY := CurY;

  if AutoExpand and (CurY < InternalLines.Count) then
  begin
    len := Length(InternalLines[CurY]);
    if (CurX > len) then
    begin
      InternalLines[CurY] := InternalLines[CurY] + StringOfChar(' ', curx - len);
    end;
  end;

//  TextFromPos(cx,cy,ss);
//  SelStart := ss;

{$IFNDEF TMSCLX}
  H := ClipBoard.GetAsHandle(CF_TEXT);
  len := GlobalSize(H);
  if len = 0 then
    Exit;

  SetLength(Buff, len);
{$IFNDEF TMSDOTNET}
  SetLength(Buff, ClipBoard.GetTextBuf(PChar(Buff), len));
{$ENDIF}
{$IFDEF TMSDOTNET}
  SetLength(Buff, ClipBoard.GetTextBuf(Buff, len));
{$ENDIF}
  AdjustLineBreaks(Buff);

  SetSelText(Buff);

  TextFromPos(CurX,CurY,ss);  // khn:

  for i := cy to CurY do
   LineModified[i] := true;

  SelLength := 0;
  SelStart := ss;

{$ENDIF}

{$IFDEF TMSCLX}
  Buff := Clipboard.AsText;
  if Buff <> '' then
    SetSelText(Buff);
{$ENDIF}

  if WordWrap <> wwNone then
  begin
    UpdateWrap;
    PosFromText(ss,cx,cy);
    CurY := cY;
    CurX := cX;
    LeftCol := 0;
  end
  else
    Invalidate;
end;

procedure TAdvCustomMemo.DeleteSelection;
begin
  DeleteSelectionInt(true);
end;

//--------------------------------------------------------------
//        DELETE SELECTION
//--------------------------------------------------------------

procedure TAdvCustomMemo.DeleteSelectionInt(bRepaint: boolean);
var
  xSelStartX, xSelStartY, xSelEndX, xSelEndY: integer;
  i: integer;
  OldX, OldY: integer;
  S1, S2, S: string;
  Undo: TDeleteBufUndo;
  oldperf: boolean;
  extralf: boolean;
begin
  if not EditCanModify then
    Exit;

  if ReadOnly then
    Exit;

  if (FSelStartY = FSelEndY) and (FSelStartX = FSelEndX) then
    Exit;

  extralf := (FSelStartY <> FSelEndY) and (FSelEndX = 0);

  if (Max(FSelStartY, FSelEndY) >= InternalLines.Count) or (Min(FSelStartY, FSelEndY) < 0) or
    (InternalLines.Count = 0) then
  begin
    FSelStartY := 0;
    FSelEndY := 0;
    FSelStartX := 0;
    FSelEndX := 0;
    Exit;
  end;

  OldX := CurX;
  OldY := CurY;
  xSelStartX := FSelStartX;
  xSelStartY := FSelStartY;
  xSelEndX := FSelEndX;
  xSelEndY := FSelEndY;

  OrderPos(xSelStartX, xSelStartY, xSelEndX, xSelEndY);

  if xSelStartY = xSelEndY then
  begin
    S1 := Copy(InternalLines[xSelStartY], xSelStartX + 1, xSelEndX - xSelStartX);
    S2 := '';
  end
  else
  begin
    S1 := Copy(InternalLines[xSelStartY], xSelStartX + 1, Length(InternalLines[xSelStartY]));
    S2 := Copy(InternalLines[xSelEndY], 1, xSelEndX);
  end;

  Fletrefresh := False;

  InternalLines[xSelStartY] := Copy(InternalLines[xSelStartY], 1, xSelStartX) +
    Copy(InternalLines[xSelEndY], xSelEndX + 1, Length(InternalLines[xSelEndY]));

  if TrimTrailingSpaces //trim spaces
    then RemoveTrailingSpaces(InternalLines[xSelStartY]);

  CurY := xSelStartY;
  CurX := xSelStartX;

  ClearSelection;

  oldperf := InternalUndoList.IsPerforming;
  InternalUndoList.IsPerforming := true;

  if xSelStartY <> xSelEndY then
    InternalLines.Delete(xSelEndY);

  S := S1 + S;
  for i := xSelStartY + 1 to xSelEndY - 1 do
  begin
    ClearLineErrors(i);

    if GetWrapped(xSelStartY + 1) then
      S := S + InternalLines[xSelStartY + 1]
    else
      S := S + #13#10 + InternalLines[xSelStartY + 1];

    InternalLines.Delete(xSelStartY + 1);
  end;

  InternalUndoList.IsPerforming := oldperf;

  if GetWrapped(xSelEndY) then
    S := S + S2
  else
    if S2 <> '' then
      S := S + #13#10 + S2;

  SelectionChanged;

  if bRepaint then
    Invalidate;

  UpdateWrap;

  Fletrefresh := True;

  if extralf then
    s:= s + #13#10;

  Undo := TDeleteBufUndo.Create(OldX, OldY, CurX, CurY, S);
  Undo.UndoSelStartX := xSelStartX;
  Undo.UndoSelStartY := xSelStartY;
  Undo.UndoSelEndX := xSelEndX;
  Undo.UndoSelEndY := xSelEndY;

  InternalUndoList.Add(Undo);

  LinesChanged(nil);

  ClearSelection;
  ClearLineErrors(CurY);
end;

//--------------------------------------------------------------
//        CUT TO CLIPBOARD
//--------------------------------------------------------------

procedure TAdvCustomMemo.CutToClipBoard;
begin
  if FReadOnly or not EditCanModify then
    Exit;

{$IFNDEF TMSCLX}

{$IFNDEF TMSDOTNET}
  ClipBoard.SetTextBuf(PChar(GetSelText));
{$ENDIF}

{$IFDEF TMSDOTNET}
  ClipBoard.SetTextBuf(GetSelText);
{$ENDIF}

{$ENDIF}


{$IFDEF TMSCLX}
  Clipboard.AsText := GetSelText;
{$ENDIF}

  DeleteSelectionInt(True);
end;

procedure TAdvCustomMemo.TextFromPos(X, Y: Integer; var TextPos: integer);
var
  i, l: Integer;
begin
  l := 0;

  for i := 0 to Y - 1 do
  begin
    if i < InternalLines.Count then
    begin
      if not GetWrapped(i + 1) then
        l := l + Length(InternalLines[i]) + 2
      else
        l := l + Length(InternalLines[i]);
    end;
  end;
  if Y < InternalLines.Count then
  begin
    if X < Length(InternalLines[Y]) then
      l := l + X
    else
      l := l + Length(InternalLines[Y]);
  end;

  TextPos := l;
end;

procedure TAdvCustomMemo.PosFromText(TextPos: integer; var X, Y: integer);
var
  i, j, l: integer;
begin
  X := 0;
  Y := 0;

  j := 0;
  i := 0;

  l := TextPos;

  while (j <= TextPos) and (i < InternalLines.Count) do
  begin
    if not GetWrapped(i + 1) then
      j := j + Length(InternalLines[i]) + 2
    else
      j := j + Length(InternalLines[i]);

    if (TextPos < j) then
    begin
      X := l;
      Y := i;
      Break;
    end;
    if not GetWrapped(i + 1) then
      l := l - (Length(InternalLines[i]) + 2)
    else
      l := l - (Length(InternalLines[i]));
    inc(i);
  end;
end;

procedure TAdvCustomMemo.InsertText(AValue: string);
begin
  SetSelText(Avalue);
end;

procedure TAdvCustomMemo.InsertTextAtXY(AValue: string; X, Y: Integer);
var
  ss: integer;
begin
  if InternalLines.Count = 0 then
    InternalLines.Add('');

  TextFromPos(x,y,ss);
  selstart := ss;
  sellength := 0;
  SetSelText(AValue);
end;

procedure TAdvCustomMemo.BlockIndent(FromLine, ToLine, Indent: Integer);
var
  i,j: Integer;
  s:string;
  TempLines : TAdvMemoStrings;   
begin
  if FromLine > ToLine then
    Swap(FromLine, ToLine);

  FLetRefresh := False;

  if Assigned(FMemoSource) then  
    TempLines := FMemoSource.Lines 
  else
    TempLines := Lines;

  for i := FromLine to ToLine do
  begin
    if (i < TempLines.Count) then
    begin
      s := TempLines[i];

      if Indent > 0 then
      begin
        TempLines[i] := StringOfChar(' ',Indent) + s;
      end
      else
      begin
        j := 0;
        while (j < -Indent) and (length(s) > 0) do
        begin
          if s[1] = ' ' then
            delete(s,1,1);
          inc(j);
        end;
        TempLines[i] := s;
      end;
    end;
  end;
  FLetRefresh := true;
  Invalidate;
end;

procedure TAdvCustomMemo.DeleteTextAtXY(X, Y, NumChar: Integer);
var
  s: string;
begin
  s := InternalLines[y];
  Delete(s, X + 1, NumChar);
  InternalLines[y] := s;
end;


function TAdvCustomMemo.GetSelStart: Integer;
var
  i: integer;
  xSelStartX, xSelStartY, xSelEndX, xSelEndY: integer;
begin
  Result := 0;

  if InternalLines.Count = 0 then
    Exit;

  if (FSelStartY = FSelEndY) and (FSelStartX = FSelEndX) then
  begin
    for i := 1 to FSelStartY do
    begin
      Result := Result + Length(InternalLines[i - 1]) + 2;
    end;

    Result := Result + FSelStartX;

    Exit;
  end;

  xSelStartX := FSelStartX;
  xSelStartY := FSelStartY;
  xSelEndX := FSelEndX;
  xSelEndY := FSelEndY;

  OrderPos(xSelStartX, xSelStartY, xSelEndX, xSelEndY);

  for i := 1 to xSelStartY do
  begin
    Result := Result + Length(InternalLines[i - 1]) + 2;
  end;

  Result := Result + xSelStartX;
end;


procedure TAdvCustomMemo.SetSelStart(const Value: integer);
var
  len: integer;
begin
  len := GetSelLength;
  PosFromText(Value, FSelStartX, FSelStartY);

{$IFDEF TMSDEBUG}
  outputdebugstring(PChar(IntToStr(FSelStartX) + ':' + IntToStr(FSelStartY)));
  outputdebugstring(PChar('len=' + IntToStr(len)));
{$ENDIF}

  PosFromText(Value + len, FSelEndX, FSelEndY);

{$IFDEF TMSDEBUG}
  outputdebugstring(PChar(IntToStr(FSelEndX) + ':' + IntToStr(FSelEndY)));
{$ENDIF}
  Invalidate;
end;

procedure TAdvCustomMemo.SetSelLength(const Value: integer);
begin
{$IFDEF TMSDEBUG}
  outputdebugstring(PChar(IntToStr(FSelStartX) + ':' + IntToStr(FSelStartY)));
{$ENDIF}
  PosFromText(SelStart + Value, FSelEndX, FSelEndY);
  Invalidate;
end;



//--------------------------------------------------------------
//        GET SEL TEXT
//--------------------------------------------------------------

function TAdvCustomMemo.GetSelText: string;

{$IFNDEF DELPHI_UNICODE}
{$IFNDEF TMSDOTNET}
  procedure Append(const source, destination: string; var position: Integer);
  begin
    Move(PChar(source)^, PChar(@destination[position+ 1])^, Length(source));
    Inc(position, Length(source));
  end;

  function _GetSelText(xSelStartX, xSelStartY, xSelEndX, xSelEndY: Integer): string;
  var
    I, position,s: Integer;
  begin
    position := 0;
    s := Length(InternalLines.Text);
    SetLength(Result, s);
    Append(Copy(InternalLines[xSelStartY], xSelStartX + 1, Length(InternalLines[xSelStartY])), Result, position);

    for i := xSelStartY + 1 to xSelEndY - 1 do
    begin
      if not GetWrapped(i) then
        Append(#13#10, Result, position);
      Append(InternalLines[i], Result, position);
    end;

    //last line

    if xSelEndY < InternalLines.Count then
    begin
      if not GetWrapped(xSelEndY) then
        Append(#13#10, Result, position);
      Append(Copy(InternalLines[xSelEndY], 1, xSelEndX), Result, position);
    end;

    SetLength(Result, position);
  end;
{$ENDIF}
{$ENDIF}

var
  xSelStartX, xSelStartY, xSelEndX, xSelEndY: integer;
{$IFDEF DELPHI_UNICODE}
  i: integer;
{$ENDIF}    
{$IFDEF TMSDOTNET}
  i: integer;
{$ENDIF}
begin
  Result := '';

  if InternalLines.Count = 0 then
    exit;
  if (FSelStartY = FSelEndY) and (FSelStartX = FSelEndX) then
    Exit;

  xSelStartX := FSelStartX;
  xSelStartY := FSelStartY;
  xSelEndX := FSelEndX;
  xSelEndY := FSelEndY;

  OrderPos(xSelStartX, xSelStartY, xSelEndX, xSelEndY);

  if xSelStartY = xSelEndY then
    Result := Copy(InternalLines[xSelStartY], xSelStartX + 1, xSelEndX - xSelStartX)
  else
  {$IFNDEF DELPHI_UNICODE}
  {$IFNDEF TMSDOTNET}
    Result := _GetSelText(xSelStartX, xSelStartY, xSelEndX, xSelEndY);
  {$ENDIF}
  {$ENDIF}

  {$IFDEF DELPHI_UNICODE}
  begin
    Result := Copy(InternalLines[xSelStartY], xSelStartX + 1, Length(InternalLines[xSelStartY]));
    for i := xSelStartY + 1 to xSelEndY - 1 do
    begin
      if not GetWrapped(i) then
        Result := Result + #13#10;
      Result := Result + InternalLines[i];
    end;

    //last line
    if not GetWrapped(xSelEndY) then
      Result := Result + #13#10;

    Result := Result + Copy(InternalLines[xSelEndY], 1, xSelEndX);
  end;
  {$ENDIF}

  {$IFDEF TMSDOTNET}
  begin
    Result := Copy(InternalLines[xSelStartY], xSelStartX + 1, Length(InternalLines[xSelStartY]));
    for i := xSelStartY + 1 to xSelEndY - 1 do
    begin
      if not GetWrapped(i) then
        Result := Result + #13#10;
      Result := Result + InternalLines[i];
    end;

    //last line
    if not GetWrapped(xSelEndY) then
      Result := Result + #13#10;

    Result := Result + Copy(InternalLines[xSelEndY], 1, xSelEndX);
  end;
  {$ENDIF}
end;

//--------------------------------------------------------------
//        SET SEL TEXT
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetSelText(const AValue: string);
var
  i, k, j: integer;
  xSelStartX, xSelStartY, xSelEndX, xSelEndY: integer;
  Buff, S: string;
  OldX, OldY: integer;
  tz: Tstringlist;
begin
  Buff := AValue;
  xSelStartX := FSelStartX;
  xSelStartY := FSelStartY;
  xSelEndX := FSelEndX;
  xSelEndY := FSelEndY;
  OrderPos(xSelStartX, xSelStartY, xSelEndX, xSelEndY);

  DeleteSelectionInt(False);

  OldX := CurX;
  OldY := CurY;
  i := Pos(#13#10, Buff);

  if InternalLines.Count > 0 then
    S := InternalLines[xSelStartY]
  else
    InternalLines.Add('');

  if i = 0 then
  begin
    k := SelStart;
    j := Length(AValue);

    //i := CurX;

    InternalLines[xSelStartY] := Copy(S, 1, xSelStartX) + Buff + Copy(S, xSelStartX + 1, Length(S));
    CurX := xSelStartX;
    if Buff <> '' then
      CurX := CurX + Length(Buff);

    InternalLines.OnChange := LinesChanged;

    InternalUndoList.Add(TPasteUndo.Create(OldX, OldY, CurX, CurY, AValue));

    //+++ 1.5.0.8
    if WordWrap <> wwNone then
    begin
      InternalLines.OnChange := nil;
      UpdateWrap;
      LeftCol := 0;
      SelStart := k;
      SelLength := j;
      Exit;
    end;
    //--- 1.5.0.8
  end
  else
  begin

    k := xSelStartY;
    InternalLines[k] := Copy(S, 1, xSelStartX) + Copy(Buff, 1, i - 1); // first line
    TAdvMemoStrings(InternalLines).DoInsert(k + 1, Copy(S, xSelStartX + 1, Length(S)));

    InternalLines.OnChange := nil;
    tz := TStringList.Create;

    while pos(#13#10, buff) > 0 do
    begin
      tz.Add(copy(buff, 1, pos(#13#10, buff) - 1));
      delete(buff, 1, pos(#13#10, buff) + 1);
      if buff = '' then
        tz.Add('');
    end;

    if buff <> '' then
      tz.Add(buff);

//    tz.Text := buff;

    j := 0;
    for k := 1 to tz.count - 1 do
    begin
      if xSelStartY + k >= InternalLines.Count then
        Continue;
      if k < tz.Count - 1 then
        TAdvMemoStrings(InternalLines).DoInsert(xSelStartY + k, tz.Strings[k])
      else
      begin
        InternalLines[xSelStartY + k] := tz.Strings[k] + InternalLines[xSelStartY + k];
        j := length(tz.Strings[k]);
      end;
    end;

    k := xSelStartY + tz.count - 1;
    tz.free;

    UpdateWrap;

    InternalLines.OnChange := LinesChanged;

    CurY := k;
    CurX := j;
    MakeVisible;
    LinesChanged(nil);
    InternalUndoList.Add(TPasteUndo.Create(OldX, OldY, CurX, CurY, AValue));
  end;
  ClearSelection;
  Invalidate;
end;

//--------------------------------------------------------------
//        GET SEL LENGTH
//--------------------------------------------------------------

function TAdvCustomMemo.GetSelLength: integer;
begin
  Result := Length(GetSelText);
end;

//--------------------------------------------------------------
//        SELECTION CHANGED
//--------------------------------------------------------------

procedure TAdvCustomMemo.SelectionChanged;
begin
  if Assigned(FOnSelectionChange) then
    FOnSelectionChange(Self);
end;

//--------------------------------------------------------------
//        FONT CHANGED
//--------------------------------------------------------------

procedure TAdvCustomMemo.FontChangedProc(Sender: TObject);
var
  OldFontName: string;
{$IFNDEF TMSCLX}
  tm: TTextMetric;
{$ENDIF}
begin
  if not HandleAllocated then
    Exit;

  if (csCreating in ControlState) then
    Exit;

{$IFNDEF TMSCLX}

  OldFontName := Canvas.Font.Name;
  Canvas.Font.Name := FFont.Name;

  GetTextMetrics(Canvas.Handle, tm);

  if tm.tmPitchAndFamily and TMPF_FIXED_PITCH = TMPF_FIXED_PITCH then
  begin
    Canvas.Font.Name := OldFontName;

    // restore old font
    GetTextMetrics(Canvas.Handle, tm);

    // if old font is not fixed font either, use FixedSys
    if tm.tmPitchAndFamily and TMPF_FIXED_PITCH = TMPF_FIXED_PITCH then
      FFont.Name := 'FixedSys';
  end;

  Canvas.Font.Assign(FFont);
  //outputdebugstring(pchar(canvas.Font.Name));
  Canvas.Font.Style  := [fsBold];
  FCellSize.W := Canvas.TextWidth('W');
  FCellSize.H := Canvas.TextHeight('W_') + 1;

  //outputdebugstring(pchar(inttostr(fcellsize.W)+':'+inttostr(fcellsize.h)));
{$ENDIF}

{$IFDEF TMSCLX}
  Canvas.Font.Assign(FFont);
  FCellSize.W := Canvas.TextWidth('W');
  FCellSize.H := Canvas.TextHeight('W_') + 1;
{$ENDIF}

  if FCaretVisible then
  begin
    ShowCaret(False);
    DestroyCaret;
{$IFNDEF TMSCLX}
    CreateCaret(Handle, HBITMAP(0), 2, FCellSize.H - 2);
{$ENDIF}
{$IFDEF TMSCLX}
    CreateCaret(Canvas, FCaretBmp, 2, FCellSize.H - 2);
{$ENDIF}

    ShowCaret(True);
  end;

  //outputdebugstring(pchar(ffont.name));

  // update scrollbars in case new font settings require scrollbar change
  ResizeScrollBars(False);
  Invalidate;
end;


//--------------------------------------------------------------
//        STATUS CHANGED
//--------------------------------------------------------------

procedure TAdvCustomMemo.StatusChanged;
begin
  if Assigned(FOnStatusChange) then
    FOnStatusChange(Self);
end;

//--------------------------------------------------------------
//        CLEAR SELECTION
//--------------------------------------------------------------

procedure TAdvCustomMemo.ClearSelection;
var
  Changed: boolean;
begin
  Changed := not ((FSelStartX = FSelEndX) and (FSelStartY = FSelEndY));
  FSelStartX := CurX;
  FSelStartY := CurY;
  FSelEndX := CurX;
  FSelEndY := CurY;
  FPrevSelX := CurX;
  FPrevSelY := CurY;
  if Changed then
  begin
    SelectionChanged;
    Invalidate;
  end;
end;

//--------------------------------------------------------------
//        EXPAND SELECTION
//--------------------------------------------------------------

procedure TAdvCustomMemo.ExpandSelection;
var
  rct: TRect;
begin
  if not CodeFolding.Enabled then    // kh:
    rct := LineRangeRect(FPrevSelY, CurY)
  else
    rct := LineRangeRect(LineIndexToVisIndex(FPrevSelY), LineIndexToVisIndex(CurY));

  FSelEndX := CurX;
  //if not CodeFolding.Enabled then      // kh:
    FSelEndY := CurY;
  //else
    //FSelEndY := VisIndexToLineIndex(CurY);
  FPrevSelX := CurX;
  FPrevSelY := CurY;
  SelectionChanged;
{$IFNDEF TMSDOTNET}
  InvalidateRect(Handle, @rct, True);
{$ENDIF}
{$IFDEF TMSDOTNET}
  InvalidateRect(Handle, rct, True);
{$ENDIF}
end;

function TAdvCustomMemo.GetMarkerCount: integer;
begin
  Result := FMarkerList.Markers.MarkerCount;
end;

function TAdvCustomMemo.TrimRightWW(LineNo: Integer): string;
begin
  if GetWrapped(LineNo + 1) then
    Result := InternalLines[LineNo]
  else
    Result := TrimRight(InternalLines[LineNo]);
end;

//--------------------------------------------------------------
//        MAX LENGTH
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetMaxLength;
var
  i, len, mx: integer;
begin
  mx := 0;

  if InternalLines.FListLengths.Count <> InternalLines.Count then
    Exit;

  for i := 0 to InternalLines.FListLengths.Count - 1 do
  begin
    len := InternalLines.FListLengths.Items[i];
    if len > mx then
    begin
      mx := len;
    end;
  end;
  FmaxLength := mx;
end;

//--------------------------------------------------------------
//        DO SCROLL
//--------------------------------------------------------------

procedure TAdvCustomMemo.DoScroll(Sender: TScrollBar; ByValue: integer);
var
  eRect: TRect;
  Old: integer;
begin
  eRect := EditorRect;
  case Sender.Kind of
    sbVertical:
      begin
        Old := FTopLine;
        if not FCodeFolding.Enabled then
        begin
          FTopLine := FTopLine + ByValue;
          if FTopLine > Sender.Max then
            FTopLine := Sender.Max;
          if FTopLine < 0 then FTopLine := 0;
        end
        else
        begin
          if ByValue <> 0 then
            FTopLine := VisIndexToLineIndex(LineIndexToVisIndex(FTopLine) + ByValue);
          if FTopLine > VisIndexToLineIndex(Sender.Max) then
            FTopLine := VisIndexToLineIndex(Sender.Max);
          if FTopLine < 0 then FTopLine := 0;
        end;  
{$IFDEF TMSDEBUG}
        outputdebugstring(pchar('doscroll:' + inttostr(ftopline)));
{$ENDIF}
        if Old <> FTopLine then
        begin
          Invalidate; {!!!!!!}
          if CurX > FLeftCol then
            ShowCaret(True)
          else
            ShowCaret(false);
        end;
      end;
    sbHorizontal:
      begin
        Old := FLeftCol;
        FLeftCol := FLeftCol + ByValue;
        if FLeftCol > Sender.Max then
          FLeftCol := Sender.Max;
        if FLeftCol < 0 then FLeftCol := 0;
        if Old <> FLeftCol then
        begin
          Invalidate;
          if CurX > FLeftCol then
            ShowCaret(True)
          else
            ShowCaret(false);
        end;
      end;
  end;
end;

//--------------------------------------------------------------
//        DO SCROLL PAGE
//--------------------------------------------------------------

procedure TAdvCustomMemo.DoScrollPage(Sender: TScrollBar; ByValue: integer);
begin
  case Sender.Kind of
    sbVertical: DoScroll(Sender, ByValue * VisibleLineCount);
    sbHorizontal: DoScroll(Sender, ByValue * VisiblePosCount);
  end;
end;

//--------------------------------------------------------------
//        SET LINES
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetLines(ALines: TAdvMemoStrings);
var
  I: Integer;
begin
  if ALines <> nil then
  begin
    InternalLines.Clear;
    InternalLines.AddStrings(ALines);

    //trim
    if TrimTrailingSpaces
      then begin
      for I := 0 to InternalLines.Count - 1 do // Iterate
        InternalLines[i] := RemoveTrailingSpaces(InternalLines[i]);
    end; // for

    if (csDesigning in ComponentState) then
    begin
      ResizeEditor;
      Repaint;
    end
    else
    begin
      SelectionChanged;
      Invalidate;
    end;
  end;
end;


//--------------------------------------------------------------
//        SYNTAX MEMO - SET CASE SENSITIVE
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetCaseSensitive(Value: boolean);
begin
  if Value <> FCaseSensitive then
  begin
    FCaseSensitive := Value;
    Invalidate;
  end;
end;
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetCurX(Value: integer);
var
  len: integer;
  WasVisible: boolean;
  lf: boolean;
begin
  if Value = FCurX then
    Exit;

  if (InternalLines.Count = 0) and not AutoExpand then
    Exit;

  if Value < 0 then
    if CurY = 0 then Value := 0
    else
    begin
      if not CodeFolding.Enabled then   // kh:
        CurY := CurY - 1
      else
        CurY := VisIndexToLineIndex(LineIndexToVisIndex(CurY) - 1);
      if (CurY >= 0) and (CurY < InternalLines.Count) then
        Value := Length(InternalLines[CurY]);
    end;

  FCurX := Value;

  if (CurY >= 0) and (CurY < InternalLines.Count) then
  begin
    len := Length(InternalLines[CurY]);

    lf := FLetRefresh;
    FLetRefresh := False;

    if Value > FMaxLength then
    begin
      FLeftCol := Value - VisiblePosCount;
      if FLeftCol < 0 then
        FLeftCol := 0;
      FmaxLength := value;
    end
    else
    begin
      len := Length(InternalLines[cury]);
      SetMaxLength;
    end;

    if Value > len then
    begin
      if AutoExpand then
      begin
        if InternalLines.Count > 0 then
          InternalLines[CurY] := InternalLines[CurY] + StringOfChar(' ', Value - len)
        else
          InternalLines.Add(StringOfChar(' ', Value - len));
      end
      else
      begin
        if InternalLines.Count = 0 then
        begin
          InternalLines.Add('');
          Value := 0;
        end
        else
          Value := len;
      end;

      Invalidate;
    end;
    FLetRefresh := lf;
  end;

  FCurX := Value;
  WasVisible := FCaretVisible;

  MakeVisible;
  ResizeScrollBars(False);
  StatusChanged;

  if WasVisible then
    ShowCaret(True);

  if (FAutoHintParameters = hpAuto) and FAllowAutoHint then
    PrepareShowHint;

  CursorChanged;
  DoColumnChange(FCurX);
end;

procedure TAdvCustomMemo.DoActiveLineChange(LnNo: integer);
begin
  if Assigned(FOnActiveLineChange) then
    FOnActiveLineChange(LnNo);
end;

procedure TAdvCustomMemo.DoColumnChange(ColNo: integer);
begin
  if Assigned(FOnColumnChange) then
    FOnColumnChange(ColNo);
end;

procedure TAdvCustomMemo.DoMarkerAdded(LnNo: integer; MarkerText: string);
begin
  if Assigned(FOnMarkerAdded) then
    FOnMarkerAdded(LnNo, MarkerText);
end;

procedure TAdvCustomMemo.DoMarkerRemoved(LnNo: integer);
begin
  if Assigned(FOnMarkerRemoved) then
    FOnMarkerRemoved(LnNo);
end;

//--------------------------------------------------------------
//        SET CUR Y
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetCurY(Value: integer);
var
  Old: integer;
  WasVisible: boolean;
  lf: boolean;
  ny: Boolean;
begin
// The current should NOT test:  if Value = FCurY then Exit

  if Value = FCurY then
    Exit;

  ny := Value <> FCurY;

  if InternalLines.Count = 0 then
    InternalLines.Add('');

  WasVisible := FCaretVisible;
  Old := CurY;

  if Value >= InternalLines.Count then
    Value := InternalLines.Count - 1;

  if Value < 0 then
    Value := 0;

  if ActiveLineSettings.ActiveLineAtCursor then
    ActiveLine := Value;

  FCurY := Value;
  lf := FLetRefresh;
  FLetRefresh := False;

  if (CurY <> Old) and (Old >= 0) and (Old < InternalLines.Count) then
  begin
    if TrimTrailingSpaces or (WordWrap <> wwNone) then
      InternalLines[Old] := TrimRightWW(old);

    if FHintForm.Visible then
      FHintForm.Hide;
  end;

  FLetRefresh := lf;

  CurX := CurX;

  MakeVisible;
  ResizeScrollBars(False);
  StatusChanged;
  if WasVisible then
    ShowCaret(True);

  if (FAutoHintParameters = hpAuto) and FAllowAutoHint then
    PrepareShowHint;

  if ny then
    CursorChanged;

  if ActiveLineSettings.ActiveLineAtCursor then
    DoActiveLineChange(FCurY);

  if FShouldCheckCodeFolding then
  begin
    AutoCodeFold;
    FShouldCheckCodeFolding := False;
  end;
end;

//--------------------------------------------------------------
//        MOVE CURSOR
//--------------------------------------------------------------

procedure TAdvCustomMemo.MoveCursor(dX, dY: integer; Shift: TShiftState);
var
  Selecting: Boolean;
  S: string;

  //------------------------------------------------------------
  procedure MoveWordLeft;
  begin
    FLetRefresh := false;
    CurX := CurX - 1;

    S := TrimRightWW(CurY);
    while (CurX > 0) and (CurX <= Length(s)) do
    begin
//      if (S[CurX] = ' ') and (S[CurX + 1] <> ' ') then
      if IsDelimiter(S[CurX]) and (S[CurX + 1] <> ' ') then
        Break;
      CurX := CurX - 1;
    end;
    if (CurX < 0) then
      if CurY > 0 then
      begin
        if not CodeFolding.Enabled then  // kh: not passed
          CurY := CurY - 1
        else
          CurY := VisIndexToLineIndex(LineIndexToVisIndex(CurY) - 1);
        CurX := Length(InternalLines[CurY]);
      end;
    FLetRefresh := true;
  end;

  //------------------------------------------------------------
  procedure MoveWordRight;
  var
    Len: Integer;
  begin
    FLetRefresh := false;
    S := TrimRightWW(CurY);
    Len := Length(S);
    CurX := CurX + 1;
    while CurX < Len do
    begin
//      if (S[CurX] = ' ') and (S[CurX + 1] <> ' ') then
      if IsDelimiter(S[CurX]) and (S[CurX + 1] <> ' ') then
        Break;
      CurX := CurX + 1;
    end;
    if CurX > Len then
      if CurY < InternalLines.Count - 1 then
      begin
        if not CodeFolding.Enabled then  // kh:
          CurY := CurY + 1
        else
          CurY := VisIndexToLineIndex(LineIndexToVisIndex(CurY) + 1);
        CurX := 0;
      end;
    FLetRefresh := true;
  end;
  //------------------------------------------------------------
begin
  Selecting := (ssShift in Shift) and (CurX = FPrevSelX) and (CurY = FPrevSelY);

  if ssCtrl in Shift then
  begin
    if dX > 0 then MoveWordRight;
    if dX < 0 then MoveWordLeft;
  end
  else
  begin
    if not CodeFolding.Enabled then  // kh:
      CurY := CurY + dY
    else
      CurY := VisIndexToLineIndex(LineIndexToVisIndex(CurY) + dY);

    if (ssShift in Shift) then  // kh: Restricting Selection to end.
      CurX := min(Length(InternalLines[cury]), CurX + dX)
    else
      CurX := CurX + dX;
  end;

  if Selecting then
    ExpandSelection
  else
    ClearSelection;
end;

//--------------------------------------------------------------
//        MOVE PAGE
//--------------------------------------------------------------

procedure TAdvCustomMemo.MovePage(dP: integer; Shift: TShiftState);
var
  eRect: TRect;
  LinesPerPage: integer;
  Selecting: boolean;
  tr: integer;
begin
  if FCellSize.H = 0 then
    Exit;

  tr := TopLine;

  Selecting := (ssShift in Shift) and (CurX = FPrevSelX) and (CurY = FPrevSelY);

  eRect := EditorRect;
  LinesPerPage := (eRect.Bottom - eRect.Top) div FCellSize.H - 1;

  if not CodeFolding.Enabled then   // kh:
  begin
    CurY := CurY + dP * LinesPerPage;
    TopLine := tr + dP * LinesPerPage;
  end
  else
  begin
    CurY := VisIndexToLineIndex(LineIndexToVisIndex(CurY) + dP * LinesPerPage);
    TopLine := tr + dP * LinesPerPage;
  end;


  if ssCtrl in Shift then
    if dP > 0 then
    begin
      CurY := InternalLines.Count - 1;
      CurX := Length(InternalLines[InternalLines.Count - 1]);
    end
    else
    begin
      CurY := 0;
      CurX := 0;
    end;

  if Selecting then
    ExpandSelection
  else
    ClearSelection;
end;

//--------------------------------------------------------------
//        GO HOME
//--------------------------------------------------------------

procedure TAdvCustomMemo.GoHome(Shift: TShiftState);
var
  Selecting: boolean;
  S: string;
  first_nonblank: integer;
begin
  if (ssCtrl in Shift) then
  begin
    CurX := 0;
    CurY := 0;
  end;

  Selecting := (ssShift in Shift) and (CurX = FPrevSelX) and (CurY = FPrevSelY);

  //---------------
  if FEnhancedHomeKey then
  begin //using enhanced home key
    s := InternalLines[CurY];
    first_nonblank := CurX - 1;
    if first_nonblank > length(s) then
      first_nonblank := length(s);
    while (first_nonblank > 0) do
    begin
      if (s[first_nonblank] = #32) then
      begin //found a space
        if s[first_nonblank + 1] = #32 then
        begin //next char is a space
          dec(first_nonblank);
        end
        else
        begin //next char is NOT a space
          break;
        end;
      end
      else
        dec(first_nonblank);
    end;
    CurX := first_nonblank;
    if CurX < FLeftCol then
      FLeftCol := CurX;
  end
  else
  begin
    CurX := 0;
    FLeftCol := 0;
  end;
  //-----------------

  if Selecting then
    ExpandSelection
  else
    ClearSelection;
end;

//--------------------------------------------------------------
//        GO END
//--------------------------------------------------------------

procedure TAdvCustomMemo.GoEnd(Shift: TShiftState);
var
  Selecting: boolean;
begin
  if ssCtrl in Shift then
  begin
    CurY := InternalLines.Count - 1;
    CurX := Length(InternalLines[InternalLines.Count - 1]);
  end;

  Selecting := (ssShift in Shift) and (CurX = FPrevSelX) and (CurY = FPrevSelY);
  CurX := Length(TrimRightWW(CurY));

  if Selecting then ExpandSelection
  else
    ClearSelection;
end;

//--------------------------------------------------------------
//        INSERT CHAR
//--------------------------------------------------------------

procedure TAdvCustomMemo.InsertChar(C: Char);
var
  S, S1: string;
  NewPlace: integer;
  CurX0, CurY0: integer;
  tp, x, y: integer;
  lib: integer;

begin
  if (curY >= InternalLines.Count) then
  begin
    curY := curY;
  end;

  if InternalLines.Count = 0 then
    InternalLines.Add('');

  CurX0 := CurX;
  CurY0 := CurY;
  S := InternalLines[CurY];
  S1 := '';

  // Tab key pressed
  if C = #9 then
  begin
    if FOverwrite then
    begin
      if CurX + TabSize < Length(InternalLines[CurY]) then
        CurX := CurX + TabSize
      else
      begin
        S1 := StringOfChar(' ', TabSize - (Length(InternalLines[CurY]) - CurX));
        CurX := Length(InternalLines[CurY]);
      end;
      C := #0;
    end
    else
      S1 := StringOfChar(' ', TabSize)
  end
  else
  begin
    if CurX > Length(s) then
      S := S + StringOfChar(' ', CurX);
    S1 := C;
  end;

  NewPlace := CurX + length(S1);

  if FOverwrite then
  begin
    if (length(S) >= CurX + 1) and (C <> #0) then
      S[CurX + 1] := C
    else
      Insert(S1, S, CurX + 1);
  end
  else
    Insert(S1, S, CurX + 1);

  FLetRefresh := False;

  InternalLines[CurY] := S;

  TextFromPos(NewPlace, CurY, tp);

//  otl := TopLine;

  lib := Lines.Count;

  UpdateWrap;

  //--1.6
  FLetRefresh := True;

  if (WordWrap <> wwNone) then
  begin
    PosFromText(tp, x, y);
    CurX := x;
    CurY := y;
    if (WordWrap <> wwRightMargin) or (VisiblePosCount > RightMargin ) then
      LeftCol := 0;

    //FTopLine := otl; // restore old topline
  end
  else
    CurX := NewPlace;

  ClearSelection;
  InternalUndoList.Add(TInsertCharUndo.Create(CurX0, CurY0, CurX, CurY, S1));

  //++1.6
  // FLetRefresh := True;

  if (WordWrap <> wwNone) and (lib <> Lines.Count) then
    ResizeScrollBars(false);
end;

//--------------------------------------------------------------
//        INSERT TEMPLATE
//--------------------------------------------------------------

procedure TAdvCustomMemo.InsertTemplate(AText: string);
var
  i, NewCurX, NewCurY: integer;
  Indent: string;
  FoundCursor: boolean;
begin
  Indent := IndentCurrLine;

  NewCurX := CurX;
  NewCurY := CurY;
  FoundCursor := False;
  i := 1;
  while i <= Length(AText) do
  begin
    if AText[i] = #13 then
    begin
      if (i = Length(AText)) or (AText[i + 1] <> #10) then
        Insert(#10 + Indent, AText, i + 1);
      if not FoundCursor then
      begin
        Inc(NewCurY);
        NewCurX := Length(Indent);
      end;
      Inc(i, 1 + Length(Indent));
    end
    else if AText[i] = #7 then
    begin
      FoundCursor := True;
      Delete(AText, i, 1);
      Dec(i);
    end
    else if Ord(AText[i]) < Ord(' ') then
    begin
      Delete(AText, i, 1);
      Dec(i);
    end
    else if not FoundCursor then
      Inc(NewCurX);
    Inc(i);
  end;

  ClearSelection;
  SetSelText(AText);
  SetCursor(NewCurX, NewCurY);
  SetFocus;
end;

//--------------------------------------------------------------
//        DELETE CHAR
//--------------------------------------------------------------

procedure TAdvCustomMemo.DeleteChar(OldX, OldY: integer);
var
  S: string;
  C: char;
  Undo: TDeleteCharUndo;
  IsBackspace: boolean;
  CurLnIdx: Integer;
  Tlp: TLineProp;
  oldperf: boolean;
begin
  if not EditCanModify then
    Exit;

  Fletrefresh := False;

  if OldX < 0 then
  begin
    OldX := CurX;
    OldY := CurY;
    IsBackspace := False;
  end
  else
    IsBackspace := True;

  ClearSelection;

{$IFDEF TMSDEBUG}
  outputdebugstring(pchar('before delete ->' + InternalLines[cury] + '*'));
{$ENDIF}

  //if not FCodeFolding.Enabled then
    CurLnIdx := CurY;  // kh:
  //else
    //CurLnIdx := VisIndexToLineIndex(CurY);
  if (CurX < Length(InternalLines[CurLnIdx])) then
  begin
    S := InternalLines[CurLnIdx];
    C := S[CurX + 1];
    Delete(S, CurX + 1, 1);
    InternalLines[CurLnIdx] := S;

    Undo := TDeleteCharUndo.Create(OldX, OldY, CurX, CurLnIdx, C);
    Undo.IsBackSpace := IsBackSpace;
    InternalUndoList.Add(Undo);
  end
  else if CurY < InternalLines.Count - 1 then
  begin
    Tlp := InternalLines.GetLineProp(CurY+1);
    if Assigned(Tlp) and (Tlp is TLineProp) and (WordWrap <> WWNone) and tlp.Wrapped then
    begin
      S := InternalLines[CurY+1];
      C := S[1];
      Delete(S, 1, 1);
      InternalLines[CurY+1] := S;

      Undo := TDeleteCharUndo.Create(OldX, OldY, CurX, CurY+1, C);
      Undo.IsBackSpace := IsBackSpace;
      InternalUndoList.Add(Undo);
    end
    else
    begin
      S := InternalLines[CurY] + InternalLines[CurY + 1];

      InternalLines[CurY] := S;
      InternalLines[CurY + 1] := '';

      oldperf := InternalUndoList.IsPerforming;
      InternalUndoList.IsPerforming := true;

      InternalLines.Delete(CurY + 1);

      InternalUndoList.IsPerforming := oldperf;

      Undo := TDeleteCharUndo.Create(OldX, OldY, CurX, CurY, #13);
      Undo.IsBackSpace := IsBackSpace;
      InternalUndoList.Add(Undo);

      AutoCodeFold;
    end;
  end;

  UpdateWrap;

  Fselstartx := CurX;
  Fselstarty := CurY;
  FSelEndX := CurX;
  FSelEndY := CurY;


  Fletrefresh := True;
  LinesChanged(nil);

  //--1.6
  //Invalidate;

{$IFDEF TMSDEBUG}
  outputdebugstring(pchar('after delete ->' + InternalLines[cury] + '*'));
{$ENDIF}
end;

//--------------------------------------------------------------
//        DELETE LINE
//--------------------------------------------------------------

procedure TAdvCustomMemo.DeleteLine;
var
  OldX, OldY: integer;
  s: string;
  i: Integer;
begin
  if not EditCanModify then
    Exit;
  ClearLineErrors(CurY);
  OldX := CurX;
  OldY := CurY;
  s := InternalLines[CurY];
  CurX := 0;
  if MarkerAtLine(OldY) then
    FMarkerList.Markers.RemoveMarker(OldY);
  //if FMarkers.HigherMarkerThanLine(OldY) then
    //FMarkers.AdjustMarkerLineMinus(OldY);
  if InternalLines.Count = 1 then
    TAdvMemoStrings(InternalLines)[0] := ''
  else if CurY = InternalLines.Count - 1 then
  begin
    CurY := CurY - 1;
    InternalLines.Delete(CurY + 1);
  end
  else
    InternalLines.Delete(CurY);

  for i := 0 to 9 do
  begin
    if FBookmarkList.Items[i] >= CurY then
      FBookmarkList.Items[i] := FBookmarkList.Items[i] - 1;
  end;

  ClearSelection;
  Invalidate;
  InternalUndoList.Add(TDeleteLineUndo.Create(OldX, OldY, CurX, CurY, S));
end;

//--------------------------------------------------------------
//        BACK SPACE
//--------------------------------------------------------------

procedure TAdvCustomMemo.BackSpace;
var
  iIndent: integer;
  strOrigLine: string;
  OldX, OldY: integer;
  S1, S2: string;

  function IsFirstNonBlank: boolean;
  var
    iCur: integer;
    CurLine: string;
  begin
     //check to see if the ursor is located at the first non blank char
    iCur := 0;
    CurLine := InternalLines[CurY];
    if Length(CurLine) = 0
      then begin
      result := false;
      exit;
    end;

    repeat
      if ((CurLine[iCur] = #32) or (CurLine[iCur] = #0)) then //found a space
        inc(iCur)
      else
        break;
    until iCur = CurX;
    Result := (iCur = CurX);
  end;

  function GetTabIndent: integer;
  var
    // use for smarttabs
    MinLen, iLine: integer;
    PrevLine: string;
    first_nonblank: integer;
    stFound: boolean;
  begin //get the number of spaces to indent the
    MinLen := CurX - 1;
    first_nonblank := MinLen;
    iLine := CurY - 1;
    stFound := false;
    if (iLine > 0) and (iLine < InternalLines.Count) then
    begin
      repeat
        //locate a prev line to get tab
        PrevLine := InternalLines[iLine];

        if fWordWrap <> wwNone then
          while (iLine > 0) and GetWrapped(iLine) do
          begin
            Dec(iLine);
            PrevLine := InternalLines[iLine] + PrevLine;
          end;

        first_nonblank := MinLen;
        //first go until we find a blank
        if first_nonblank > Length(PrevLine) then
          first_nonblank := Length(PrevLine) + 1;

        //now go til we find a non blank
        while (first_nonblank < Length(PrevLine)) and (first_nonblank > 0) do
        begin
          if not ( (PrevLine[first_nonblank] = #32) or (PrevLine[first_nonblank] = #9)) then
          begin
            stFound := true;
            break;
          end
          else
            dec(first_nonblank);
        end;

        while (first_nonblank < Length(PrevLine)) and (first_nonblank > 0) do
        begin
          if (PrevLine[first_nonblank] = #32) or (PrevLine[first_nonblank] =  #9) then
          begin
            break;
          end
          else
            dec(first_nonblank);
        end;

        if stFound then break; //found the point

        Dec(iLine);
      until iLine < 0;
    end;
    //  now actually use the tab
    Result := first_nonblank;
  end;
  (*
  function GetTabIndent: integer;
  var
     // use for smarttabs
    MinLen, iLine: integer;
    PrevLine: string;
    first_nonblank: integer;
    stFound: boolean;
  begin //get the number of spaces to indent the
    MinLen := CurX - 1;
    first_nonblank := MinLen;
    iLine := CurY - 1;
    stFound := false;
    if (iLine > 0) and (iLine < InternalLines.Count) then
    begin
      repeat
        //locate a prev line to get tab
        PrevLine := InternalLines[iLine];
        if fWordWrap <> wwNone then
          while (iLine > 0) and GetWrapped(iLine) do
          begin
            Dec(iLine);
            PrevLine := InternalLines[iLine] + PrevLine;
          end;

        first_nonblank := MinLen;
        //first go until we find a blank
        if first_nonblank > Length(PrevLine) then
          first_nonblank := Length(PrevLine) + 1;

        //now go til we find a non blank
        while (first_nonblank < Length(PrevLine)) and (first_nonblank > 0) do
        begin
          if not ( (PrevLine[first_nonblank] = #32) or (PrevLine[first_nonblank] = #9)) then
          begin
            stFound := true;
            break;
          end
          else
            dec(first_nonblank);
        end;

        while (first_nonblank < Length(PrevLine)) and (first_nonblank > 0) do
        begin
          if (PrevLine[first_nonblank] = #32) or (PrevLine[first_nonblank] =  #9) then
          begin
            break;
          end
          else
            dec(first_nonblank);
        end;

        if stFound then break; //found the point

        Dec(iLine);
      until iLine < 0;
    end;
    //  now actually use the tab
    Result := first_nonblank;
  end;
  *)


begin
  OldX := CurX;
  OldY := CurY;

  if FSmartTabs and (InternalLines.Count > 0) and (InternalLines.Count > CurY) and (IsFirstNonBlank) then
  begin
     // only perform smart tab if property is set and
     //    the cursor is at the first non blank char
    FLetRefresh := False;

    strOrigLine := InternalLines[CurY];
    iIndent := GetTabIndent; //figure out how many spaces to indent over

    s1 := Copy(strOrigLine, 1, iIndent);
    s2 := Copy(strOrigLine, curX + 1, Length(strOrigLine));
    InternalLines[CurY] := s1 + s2;

    if iIndent < 1 then
      CurX := 0
    else
      CurX := iIndent;

    InternalUndoList.Add(TInsertCharUndo.Create(OldX, OldY, CurX, CurY, ''));
    Fletrefresh := True;
    LinesChanged(Self);
  end
  else
  begin
    if CodeFolding.Enabled then
    begin
      if CurX = 0 then
      begin
        ExpandNode[VisIndexToLineIndex(LineIndexToVisIndex(CurY)-1)] := True;
        FShouldCheckCodeFolding := False;
      end;
    end;

    MoveCursor(-1, 0, []);

    if (OldX = CurX) and (OldY = CurY) then
      Exit;

    DeleteChar(OldX, OldY);

    if CurY >= InternalLines.Count then
    begin
      CurY := InternalLines.Count -1;
      CurX := Length(InternalLines[CurY]);
    end;

    FSelStartX := CurX;
    FSelStartY := CurY;
    FSelEndX := CurX;
    FSelEndY := CurY;

    if (OldY <> CurY) then
      if FMarkerList.Markers.HigherMarkerThanLine(OldY) then
        FMarkerList.Markers.AdjustMarkerLineMinus(OldY);
  end;
end;

procedure TAdvCustomMemo.BackWord;
var
  OldX, OldY: Integer;
  s: string;
begin
  s := InternalLines[CurY];
  repeat
    OldX := CurX;
    OldY := CurY;

    MoveCursor(-1, 0, []);

    if (OldX = CurX) and (OldY = CurY) then
      Exit;

    DeleteChar(OldX, OldY);

  until (OldX = CurX) or (s[CurX] = ' ') or (CurY <> OldY);
end;

function TAdvCustomMemo.HasMarkers: boolean;
begin
  Result := FMarkerList.Markers.HasMarkers;
end;
                                   
//--------------------------------------------------------------
//        INDENT CURR LINE
//--------------------------------------------------------------

function TAdvCustomMemo.IndentCurrLine: string;
var
  Len, Count,i: integer;
  CurS: string;
begin
  Result := '';

  if not AutoIndent then
    Exit;

  CurS := InternalLines[CurY];
  Len := Length(CurS);

  Count := 0;

  i := 1;

  if length(Curs) > 0 then
  begin
    while Curs[i] = ' ' do
    begin
      inc(Count);
      inc(i);
      if i >= Length(Curs) then
        break;
    end;
  end;


  while (Count < CurX) and (Count < Len) do
  begin
    if CurS[Count + 1] <> ' ' then break;
    Inc(Count);
  end;
  Result := StringOfChar(' ', Count);
end;

//--------------------------------------------------------------
//        TAB
//--------------------------------------------------------------

procedure TAdvCustomMemo.TabLine(AShift: TShiftState);
var
  S1, S2, sIndent: string;
  strOrigLine: string;
  OldX, OldY: integer;
  first_nonblank: integer;

  function GetTabIndent: string;
  var
    // use for smarttabs
    MinLen, iLine: integer;
    PrevLine, Spaces: string;
    stFound: boolean;
    nDistanceToTab: Integer;

  begin //get the number of spaces to indent the
    MinLen := CurX + 1;
    first_nonblank := MinLen;
    iLine := CurY - 1;

    stFound := false;
    if (iLine >= 0) and (iLine < InternalLines.Count) then
    begin
      repeat
        //locate a prev line to get tab
        PrevLine := InternalLines[iLine] + #13#10;
        if (fWordWrap <> wwNone) then
          while (iLine > 0) and GetWrapped(iLine) do
          begin
            Dec(iLine);
            PrevLine := InternalLines[iLine] + PrevLine;
          end;

        if (Length(PrevLine) >= MinLen) then
        begin
          first_nonblank := MinLen;
          //first go until we find a blank
          while first_nonblank < Length(PrevLine) do
          begin
            if (PrevLine[first_nonblank] = #32) or (PrevLine[first_nonblank] = #9) or
               (PrevLine[first_nonblank] = #13) or (PrevLine[first_nonblank] = #10) then
            begin
              break;
            end
            else
              inc(first_nonblank);
          end;

          //now go till we find a non blank
          while first_nonblank <= Length(PrevLine) do
          begin
            if not ( (PrevLine[first_nonblank] = #32) or (PrevLine[first_nonblank] = #9) ) then
            begin
              stFound := true;
              break;
            end
            else
              inc(first_nonblank);
          end;

          if stFound then
            break; //found the point
        end;

        Dec(iLine);
      until
        iLine < 0;
    end;

    //  now actually use the tab
    dec(first_nonblank);

    nDistanceToTab := first_nonblank - CurX;

    if nDistanceToTab > 0 then
      Spaces := Spaces + StringOfChar(#32, nDistanceToTab)
    else
    begin
      //no smart tab found so do normal tab
      Spaces := '';
    end;
    
    Result := Spaces;
  end;

begin
  if not EditCanModify then
    Exit;

  if FSmartTabs and (InternalLines.Count > 0) then
  begin
    FLetRefresh := False;

    OldX := CurX;
    OldY := CurY;

    strOrigLine := InternalLines[CurY];
    sIndent := GetTabIndent; //figure out how many spaces to indent over

    if Length(sIndent) = 0 then
    begin
      InsertChar(#9);
      LineRefresh;
    end
    else
    begin
      S1 := Copy(strOrigLine, 1, CurX);
      S2 := TrimRight(Copy(strOrigLine, CurX + 1, Length(strOrigLine)));

      InternalLines[CurY] := S1 + sIndent + S2;
      CurX := first_nonblank;
    end;

    InternalUndoList.Add(TInsertCharUndo.Create(OldX, OldY, CurX, CurY, #13 + sIndent));
    FLetRefresh := True;
    LinesChanged(Self);
  end
  else
  begin //no smarttabs
    if not (ssCtrl in AShift) then
    begin
      if ssShift in AShift then
      begin
        if CurX > TabSize
          then CurX := CurX - TabSize
        else CurX := 0;
      end
      else
      begin
        InsertChar(#9);
        LineRefresh;
      end;
    end;
  end;
end;

//--------------------------------------------------------------
//        ESCAPE
//--------------------------------------------------------------

procedure TAdvCustomMemo.DoEscape;
begin
  //go to drop point if available

end;

//--------------------------------------------------------------
//        NEW LINE
//--------------------------------------------------------------

procedure TAdvCustomMemo.NewLine;
var
  S, sIndent: string;
  OldX, OldY, CurLineIdx: integer;
begin
  if not EditCanModify then
    Exit;
    
  FLetRefresh := False;
  if (curY >= InternalLines.Count) then
  begin
    curY := curY;
  end;

  OldX := CurX;
  OldY := CurY;

  if FMarkerList.Markers.HigherMarkerThanLine(OldY) then
    FMarkerList.Markers.AdjustMarkerLinePlus(OldY);

  if InternalLines.Count = 0 then
    InternalLines.Add('');

  //if not CodeFolding.Enabled then
  //begin
    S := InternalLines[CurY];
    CurLineIdx := CurY;
 { end        // kh:
  else
  begin
    CurLineIdx := VisIndexToLineIndex(CurY);
    S := InternalLines[CurLineIdx];
  end;  }
  sIndent := IndentCurrLine;
  if not CodeFolding.Enabled then
    InternalLines[CurY] := Copy(S, 1, CurX)
  else
    InternalLines[CurLineIdx] := Copy(S, 1, CurX);

  S := TrimRight(Copy(S, CurX + 1, Length(S)));

  if AutoIndent then
    while (Length(S) > 0) and (S[1] = ' ') do
      Delete(S, 1, 1);

  if not CodeFolding.Enabled then
    TAdvMemoStrings(InternalLines).DoInsert(CurY + 1, sIndent + S)
  else
  begin
    ExpandNode[CurY] := True;
    TAdvMemoStrings(InternalLines).DoInsert(CurY + 1, sIndent + S);
    //TAdvMemoStrings(InternalLines).DoInsert(VisIndexToLineIndex(LineIndexToVisIndex(CurY) + 1), sIndent + S);
  end;  
  //GoHome([]);
  MoveCursor(0, 1, []);
  CurX := Length(sIndent);
  ClearSelection;
  InternalUndoList.Add(TInsertCharUndo.Create(OldX, OldY, CurX, CurY, #13 + sIndent));
  Fletrefresh := True;
  LinesChanged(Self);
end;

//--------------------------------------------------------------
//        ADD STRING
//--------------------------------------------------------------

function TAdvCustomMemo.AddString(S: string): integer;
begin
  if InternalLines.Count = 0 then
    TAdvMemoStrings(InternalLines).DoAdd('');

  MovePage(1, [ssCtrl]); // end of text
  if not ((InternalLines.Count = 1) and (InternalLines[0] = '')) then
  begin
    TAdvMemoStrings(InternalLines).DoAdd('');
    CurX := 0;
    CurY := InternalLines.Count;
    ClearSelection;
  end;
  SetSelText(S);
  Result := InternalLines.Count - 1;
end;

//--------------------------------------------------------------
//        INSERT STRING
//--------------------------------------------------------------

procedure TAdvCustomMemo.InsertString(Index: integer; S: string);
begin
  CurY := Index;
  CurX := 0;
  ClearSelection;
  if not ((InternalLines.Count = 1) and (InternalLines[0] = '')) then
    S := S + #13#10;
  SetSelText(S);
end;

procedure TAdvCustomMemo.SearchForStylers;
var
  I: Integer;
begin
  if not Assigned(FOwner) then
    Exit;
     
  with FOwner do
  begin
    for I := 0 to ComponentCount - 1 do { Iterate }
    begin
      if Components[I].ClassParent = TAdvCustomMemoStyler then
      begin
      {$IFNDEF TMSDOTNET}
        if FStylerList.FStylerList.IndexOf(Pointer(Components[I])) = -1 then
          FStylerList.FStylerList.Add(Pointer(Components[I]));
      {$ENDIF}
      {$IFDEF TMSDOTNET}
        if FStylerList.FStylerList.IndexOf(Components[I]) = -1 then
          FStylerList.FStylerList.Add(Components[I]);
      {$ENDIF}
      end;
    end; { for }
  end; { with }
end;

//--------------------------------------------------------------
//        DO COMMAND
//--------------------------------------------------------------

procedure TAdvCustomMemo.DoCommand(cmd: TCommand; const AShift: TShiftState);
var
  Allow: Boolean;
  OldCurY, OldCurX: Integer;
begin
  case cmd of
    cmCopy: CopyToClipboard;
    cmInsert: if ssCtrl in AShift then CopyToClipboard;
    cmEscape: DoEscape;
    cmHome:
      begin
        if InternalLines.Count = 0 then
        begin
          CurX := 0;
          Exit;
        end;

        OldCurY := FSelStartY; //CurY;
        OldCurX := FSelStartX; //CurX;

        GoHome(AShift);
        if (ssCtrl in AShift) and (ssShift in AShift) then
        begin
          //SelectAll;
          FSelStartY := OldCurY;
          FSelStartX := OldCurX;
          Invalidate;
          SelectionChanged;
        end;
      end;
    cmEnd:
      begin
        if InternalLines.Count = 0 then
        begin
          CurX := 0;
          Exit;
        end;

        OldCurY := FSelStartY; //CurY;
        OldCurX := FSelStartX; //CurX;

        GoEnd(AShift);
        if (ssCtrl in AShift) and (ssShift in AShift) then
        begin
          //SelectAll;

          FSelStartY := OldCurY;
          FSelStartX := OldCurX;
          Invalidate;
          SelectionChanged;
        end;
      end;
    cmPageDown: MovePage(1, AShift);
    cmPageUp: MovePage(-1, AShift);
  end;

  if ReadOnly then
    Exit;

  case cmd of
    cmDelete:
      begin
        if InternalLines.Count = 0 then
          Exit;

        if ssShift in AShift then
          CutToClipboard
        else
          if FDelErase and
             (not ((FSelStartX = FSelEndX) and (FSelStartY = FSelEndY))) then
            DeleteSelectionInt(True)
          else
            DeleteChar(-1, -1);

         LineModified[CurY] := true;
      end;

    cmBackSpace:
      begin
        if not EditCanModify then
          Exit;

        if InternalLines.Count = 0 then
          Exit;

        if ssCtrl in AShift then
        begin
          BackWord;
        end
        else
        begin
          if FDelErase and
            (not ((FSelStartX = FSelEndX) and (FSelStartY = FSelEndY))) then
            DeleteSelectionInt(True)
          else
            BackSpace;
        end;

        LineModified[CurY] := true;
      end;
{$IFDEF TMSCLX}
    13: NewLine;
{$ENDIF}
    cmNewLine:
      begin
        NewLine;
        LineModified[CurY] := true;
      end;
    cmDelLine:
      begin
        DeleteLine;
        LineModified[CurY] := true;
      end;  
    cmSelectAll: SelectAll;
    cmCut:
      begin
        CutToClipboard;
        LineModified[CurY] := true;
      end;  
    cmPaste: PasteFromClipboard;
    cmInsert:
      begin
        if ssShift in AShift then
          PasteFromClipboard
        else
          if not (ssCtrl in AShift) then
          begin
            Allow := True;
            if Assigned(OnOverwriteToggle) then
              OnOverwriteToggle(Self, Allow);
            if Allow then
              FOverwrite := not FOverwrite;
          end;
        if FMarkerList.Markers.HigherMarkerThanLine(FCurY) then
          FMarkerList.Markers.AdjustMarkerLinePlus(FCurY);
      end;
    cmTab:
      begin
        TabLine(AShift);
        LineModified[CurY] := true;
      end;
  end;
end;

//--------------------------------------------------------------
//        KEY DOWN
//--------------------------------------------------------------

procedure TAdvCustomMemo.KeyDown(var Key: word; Shift: TShiftState);
var
  token: string;
begin
  if Assigned(OnKeyDown) then
    OnKeyDown(Self, Key, Shift);

  FAutoCompleteTimer.Enabled := False;

{$IFDEF BLINK}
  if (key <> VK_CONTROL) then
  begin
    {$IFNDEF DELPHI2006_LVL}
    if FletgetCaretTime then
      FCaretTime := GetCaretBlinkTime;
    FletgetCaretTime := False;
    SetCaretBlinkTime(dword(-1));
    {$ELSE}
    FCaretTime := GetCaretBlinkTime;
    SetCaretBlinkTime(FCaretTime);
    FletgetCaretTime := True;
    if not FHiddenCaret then
      ShowCaret(True);
    {$ENDIF}
  end;
{$ENDIF}

  FLetShowAutocompletion := True;
  FAllowAutoHint := not (ssctrl in Shift);

  if (Key <> VK_UP) and
    (Key <> VK_DOWN) and
    (Key <> VK_LEFT) and
    (Key <> VK_RIGHT) and
    (Key <> VK_MENU) and
    (Key <> VK_CONTROL) and
    (Key <> VK_NEXT) and
    (Key <> VK_PRIOR) and
    (Key <> VK_HOME) and
    (Key <> VK_END) then
//  if not (Key in [VK_UP,VK_DOWN,VK_LEFT,VK_RIGHT,VK_MENU,VK_CONTROL,VK_NEXT,VK_PRIOR,VK_HOME,VK_END]) then
  begin
    CurX := CurX;
    CurY := CurY;
  end;

  if (Key in [VK_DELETE, VK_BACK, VK_TAB, VK_INSERT, VK_SPACE]) and IsNode(CurY) and not ExpandNode[CurY] and IsCommentedNode(CurY) then
    Exit;

  case Key of
    VK_LEFT: MoveCursor(-1, 0, Shift);
    VK_RIGHT: MoveCursor(1, 0, Shift);
    VK_UP: MoveCursor(0, -1, Shift);
    VK_DOWN: MoveCursor(0, 1, Shift);
    VK_HOME, VK_END, VK_ESCAPE, VK_DELETE: DoCommand(Key, Shift);
    VK_PRIOR, VK_NEXT: DoCommand(Key, Shift);
    VK_INSERT: DoCommand(Key, Shift);
    VK_BACK:
      begin
        if ssAlt in Shift then
        begin
          if ssShift in Shift then
            Redo
          else
            Undo;
        end
        else
          DoCommand(Key, Shift);
      end;
    VK_TAB:
      DoCommand(Key, Shift);
       { if not (ssCtrl in Shift) then
        begin
           if ssShift in Shift then
           begin
             if CurX > TabSize then
               CurX := CurX - TabSize
             else
               CurX := 0;
           end
           else
            InsertChar(#9);
        end; }

    ord('F'): if ssctrl in Shift then DoFind;
    ord('H'): if ssctrl in Shift then DoReplace;

    ord('Z'): if (ssctrl in Shift) and not (ssAlt in Shift) then Undo;
    ord('Y'): if ssctrl in Shift then Redo;

    VK_SPACE: if Shift = [ssctrl] then
      begin
        if AutoCompletion.Active then
        begin
          FletShowAutocompletion := False;

          if (Lines.Count > 0) then
            token := FullWordAtCursor
          else
            token := '';

{$IFNDEF TMSDOTNET}
          if (StrRScan(PChar(token), '.') <> nil) or
            (StrRScan(PChar(token), '(') <> nil) then
{$ENDIF}
{$IFDEF TMSDOTNET}
            if (PosEx(token, '.') > 0) or
              (PosEx(token, ')') > 0) then
{$ENDIF}
            begin
              token := TokenAtXY(CurX, CurY);
              FAutoCompleteDot := True;
              FDotPoint := Point(CurX - Length(token), CurY);
            end
            else
              FAutoCompleteDot := False;

          ShowForm(True);
        end;
      end
      else
      begin
        if ([ssShift, ssCtrl] = shift) and (FAutoHintParameters <> hpNone) then
        begin
          PrepareShowHint;
        end
      end;
  end;

  if (Key = VK_INSERT) then
    StatusChanged;
end;

//--------------------------------------------------------------
//        KEY PRESS
//--------------------------------------------------------------

procedure TAdvCustomMemo.KeyPress(var Key: char);
var
  wrd, newword: string;
  ps, pe, d: Integer;
  r: TRect;

begin
  if Assigned(OnKeyPress) then
    OnKeyPress(Self, Key);

  if Ord(Key) = 3 then
    DoCommand(Ord(Key), []);

  if FReadOnly or not EditCanModify then
    Exit;

  if AutoCompletion.Active then
    if not FletShowAutocompletion then
      Exit;

  if IsNode(CurY) and not ExpandNode[CurY] and IsCommentedNode(CurY) and (Ord(Key) <> 13) then
    Exit;

  FShouldCheckCodeFolding := True;

  inherited;

  if Ord(Key) in [13, 32, 9,ord('.'),ord('('),ord(','),ord('['),ord('=')] then
  begin
    if Ord(Key) = 13 then
    begin
      if Assigned(MemoChecker) then
      begin
        if MemoChecker.AutoCorrectType = acLineCorrect then
        begin
          if InternalLines.Count <> 0 then
          begin
            wrd := InternalLines[CurY];

            MemoChecker.CorrectLine(CurY);

            if Assigned(MemoSource) then
              CurX := Length(MemoSource.Lines[CurY])
            else
              CurX := Length(Lines[CurY]);
          end;

        end;
        if MemoChecker.AutoCorrectType = acLineCheck then
        begin
          MemoChecker.CheckLine(CurY);
        end;

        if MemoChecker.AutoCorrectType = acWordCheck then
        begin
          wrd := WordTillCursor;
          MemoChecker.CheckWord(CurY,CurX, wrd);
        end;
      end;

      if InternalLines.Count = 0 then
        InternalLines.Add('');

      if (CurX = 0) and (Length(Trim(InternalLines[CurY])) = 0) then
        FShouldCheckCodeFolding := False;
    end;

    if (Ord(Key) in [9,32]) then
    begin
      wrd := WordTillCursor;
      newword := wrd;

      if wrd <> '' then
        if Assigned(MemoChecker) then
        begin
          if MemoChecker.AutoCorrectType = acWordCorrect then
          begin
            MemoChecker.CorrectWord(CurY,CurX, newword);
            if newword <> wrd then
            begin
              pe := CurX;
              ps := CurX - length(wrd);
              d := Length(newword) - length(wrd);

              wrd := InternalLines[CurY];
              InternalLines[CurY] := Copy(wrd, 1, ps) + newword + Copy(wrd, pe + 1, length(wrd));
              CurX := CurX + d;

              MemoChecker.AddUndo(CurY, wrd);
            end;
          end;
          if MemoChecker.AutoCorrectType = acWordCheck then
          begin
            MemoChecker.CheckWord(CurY,CurX, newword);
          end;
        end
    end;

    if Assigned(FOnWordComplete) or (AutoCorrect.FDoAutoCorrect and (AutoCorrect.OldValue.Count > 0)) then
    begin
      wrd := WordAtCursor;
      if wrd <> '' then
      begin
        newword := wrd;

        for d := 1 to AutoCorrect.OldValue.Count do
        begin
          if AutoCorrect.OldValue.Strings[d - 1] = wrd then
          begin
            newword := AutoCorrect.NewValue.Strings[d - 1];
            Break;
          end;
        end;

        if Assigned(FOnWordComplete) then
          FOnWordComplete(Self, wrd, newword);
        if newword <> wrd then
        begin
          pe := CurX;
          ps := CurX - length(wrd);
          d := Length(newword) - length(wrd);

          wrd := InternalLines[CurY];

          InternalLines[CurY] := Copy(wrd, 1, ps) + newword + Copy(wrd, pe + 1, length(wrd));
          CurX := CurX + d;
        end;
      end;
    end;
  end;

  if (Ord(Key) in [32..126, 128..255])
  {$IFDEF DELPHI_UNICODE}
  or (Ord(Key) > 255)
  {$ENDIF}
  then
  begin
    if FDelErase and (not ((FSelStartX = FSelEndX) and (FSelStartY = FSelEndY))) then
      DeleteSelectionInt(True);

    InsertChar(Key);

    LineModified[CurY] := true;

    r := ClientRect;
    {$IFDEF TMSDOTNET}
    InvalidateRect(Handle, r, false);
    {$ENDIF}
    {$IFNDEF TMSDOTNET}
    InvalidateRect(Handle, @r, false);
    {$ENDIF}
    Change;
  end
  else
    if not (Ord(Key) in [8, 9]) then
      DoCommand(Ord(Key), []);

  if ((Key = '.') or (Key = '(')) and (AutoCompletion.Active) then
  begin
    FAutoCompleteTimer.Enabled := True;
  end;
end;

procedure TAdvCustomMemo.SelClickUpdate(X, Y: Integer; Down: Boolean; Shift: TShiftState; Button: TMouseButton);
var
  newPos: TCellPos;
  yold: Integer;
  lc, OldV: Boolean;
  tp: integer;
begin
  if PointInRect(Point(X, Y), EditorRect) then
  begin
    newPos := CellFromPos(X, Y);

    TextFromPos(newPos.X + LeftCol, newPos.Y + TopLine, tp);

    // do not unselect for click on selected text
    if (SelStart < tp) and (SelStart + SelLength > tp) and Down then
    begin
      FSelButtonDown := True;
      Exit;
    end;

    ShowCaret(False);

    yold := Fcury;

    if newPos.x < 0 then
      newPos.x := 0;
    if newPos.y < 0 then
      newPos.y := 0;

    FCursorChangedTrigered := False;
    // Please leave FCury not Cury (otherwise problems appear when the text is
    // scrolled and when the cursor is not in the visible area and the user
    // clicks)

    if not CodeFolding.Enabled then   // kh:
      FCurY := newPos.Y + FTopLine
    else
      FCurY := VisIndexToLineIndex(newPos.Y + LineIndexToVisIndex(FTopLine));

    if FCury >= InternalLines.Count then
      FCury := InternalLines.Count - 1;

    if FCury < 0 then
      FCury := 0;

    // 1.6.0.12
    FSelClick := true;

    OldV := FAutoExpand;
    if AutoExpand and FCodeFolding.Enabled and (InternalLines.Count > 0) then
    begin
      if (FCurY < InternalLines.Count) and IsNode(FCurY) and not ExpandNode[FCurY] then
      begin
        if (newPos.X + FLeftCol > Length(InternalLines[FCurY])) and (newPos.X + FLeftCol < Length(InternalLines[FCurY]) + 5) then
          FAutoExpand := False;
      end;
    end;

    CurX := newPos.X + FLeftCol;
    CurY := FCury;

    FAutoExpand := OldV;

    if not FCursorChangedTrigered and (yold <> FCurY) then
      CursorChanged;
    // 1.6.0.12
    MakeVisible;

    lc := FLetRefresh;
    FLetRefresh := False;

    if (yold <> FCurY) and (yold < InternalLines.Count) then
    begin
      if TrimTrailingSpaces and (WordWrap = wwNone) then
        InternalLines[yold] := TrimRightWW(yold);
    end;

    FLetRefresh := lc;

    if (Button = mbLeft) and Down then
    begin
      if (ssShift in Shift) then
        ExpandSelection
      else
        ClearSelection;

      FLeftButtonDown := True;  //Continue selection if hold shift and mouse move
      if CurY < InternalLines.Count then
        TestForURLClick(InternalLines[CurY]);
    end
    else
      ShowCaret(True);
  end;
end;

//--------------------------------------------------------------
//        MOUSE DOWN
//--------------------------------------------------------------

procedure TAdvCustomMemo.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);
var
  charPos: TFullPos;
  R: TRect;
  Tlp: TLineProp;
  tl: integer;
begin
  inherited;

  FSelButtonDown := false;

  tl := TopLine;

  if not Focused then
  begin
    Windows.SetFocus(self.Handle);
    { Allow direct caret positioning when memo has not focus }
    //Exit;
  end;

  FSelButtonDown := false;

  if Assigned(FOnGutterRightClick) and (Button = mbRight) then
    if PointInRect(Point(X, Y), FGutter.FullRect) then
    begin
      CharPos := CharFromPos(X, Y);
      if charPos.LineNo < InternalLines.Count then
        FOnGutterRightClick(Self, charPos.LineNo);
    end;

  if Button <> mbLeft then
    Exit;

  SelClickUpdate(X, Y, True, Shift, Button);

  if ActiveLineSettings.ActiveLineAtCursor then
    FActiveLine := CurY;

  if PointInRect(Point(X, Y), FGutter.FullRect) then
  begin
    CharPos := CharFromPos(X, Y);
    if charPos.LineNo < InternalLines.Count then
      DoGutterClick(charPos.LineNo);
  end;

  if FCodeFolding.Enabled then
  begin
    R := CodeFoldingRect;
    if PtInRect(R, Point(X, Y)) then
    begin
      CharPos := CharFromPos(X, Y);
      if charPos.LineNo < InternalLines.Count then
      begin
        Tlp := InternalLines.GetLineProp(charPos.LineNo);
        if Assigned(Tlp) and (Tlp is TLineProp) then
        begin
          CurY := charPos.LineNo;
          ToggleNode(charPos.LineNo);

          if ActiveLineSettings.ActiveLineAtCursor then
            FActiveLine := CurY;

          TopLine := tl;
        end;
      end;
    end;
  end;
end;

procedure TAdvCustomMemo.DropText(X, Y: integer; s: string);
begin
  SelClickUpdate(X, Y, false, [], mbLeft);
  FSelStartX := CurX;
  FSelStartY := CurY;
  FSelEndX := CurX;
  FSelEndY := CurY;
  SetSelText(s);
  Modified := true;
end;


procedure TAdvCustomMemo.DragDrop(Source: TObject; X, Y: Integer);
var
  s: string;
begin
  FSelButtonDown := false;

  if (Source = Self) then
  begin
    s := GetSelText;
{$IFNDEF TMSCLX}
    if (GetKeystate(VK_CONTROL) and $8000 = $0) then
      DeleteSelectionInt(false);
{$ENDIF}

    SelClickUpdate(X, Y, false, [], mbLeft);
    FSelStartX := CurX;
    FSelStartY := CurY;
    FSelEndX := CurX;
    FSelEndY := CurY;
    SetSelText(s);
    Modified := true;
  end;

  inherited;
end;

///-------------------------------------------------------------
//        MOUSE MOVE
//--------------------------------------------------------------

procedure TAdvCustomMemo.MouseMove(Shift: TShiftState; X, Y: integer);
var
  newPos: TCellPos;
  oldSx, oldSy, oldEy, oldEx: integer;
begin
  inherited;

  // 1.6.0.12
  if FSelClick then
  begin
    FSelClick := false;
    Exit;
  end;

  newPos := CellFromPos(X, Y);
  if newPos.x < 0 then
    newPos.x := 0
  else
    newPos.x := newPos.x + FLeftCol;

  if newPos.Y < 0 then newPos.y := 0
  else
    newPos.y := newPos.y + FTopLine;

  if ShowHint and (FLastHintPos.X >= 0) and (FLastHintPos.Y >= 0) then
  begin
    if (FLastHintPos.X <> newPos.x) or (FLastHintPos.Y <> newpos.y) then
    begin
      Application.CancelHint;
      FLastHintPos := Point(-1, -1);
    end;
  end;

  if FSelButtonDown then
  begin
    FSelDrag := true;
    FSelButtonDown := false;
    BeginDrag(false, 2);
  end;

  if (newPos.y >= 0) and (newPos.y < InternalLines.Count) then
  begin
    tokenatxy(newPos.x, newPos.y);

    if TestforURLMove(InternalLines[newPos.y], newPos.x) then
    begin
      if Cursor <> crHandPoint then
        FoldCursor := Cursor;
      inherited Cursor := crHandPoint;
    end
    else
      inherited Cursor := FoldCursor;
  end
  else
    inherited Cursor := FoldCursor;

  oldSx := FSelStartX;
  oldSy := FSelStartY;
  oldEx := FSelEndX;
  oldEY := FSelEndY;

  if (ssLeft in Shift) and FLeftButtonDown and not FSelButtonDown and not FSelClick then
  begin
    newPos := CellFromPos(X, Y);
   { if newPos.x < 0 then
    begin
      curx := 0;
      FLeftCol := 0;
    end
    else
      CurX := newPos.X + FLeftCol;

    if not CodeFolding.Enabled then    // kh:
      CurY := newPos.Y + FTopLine
    else
      CurY := VisIndexToLineIndex(newPos.Y + LineIndexToVisIndex(FTopLine));
    }
    if not CodeFolding.Enabled then    // kh:
      CurY := newPos.Y + FTopLine
    else
      CurY := VisIndexToLineIndex(newPos.Y + LineIndexToVisIndex(FTopLine));

    if newPos.x < 0 then
    begin
      curx := 0;
      FLeftCol := 0;
    end
    else
      if cury <= (InternalLines.Count - 1) then
        CurX := min(Length(InternalLines[cury]), newPos.X + FLeftCol)
      else
        CurX := newPos.X + FLeftCol;

    ExpandSelection;
    // Force
    if ((oldSx <> FSelStartX) or
      (oldSy <> FSelStartY) or
      (oldEx <> FSelEndX) or
      (oldEY <> FSelEndY)) then Repaint;
  end;
end;

//--------------------------------------------------------------
//        MOUSE UP
//--------------------------------------------------------------

procedure TAdvCustomMemo.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);
begin
  inherited;

  if Button = mbLeft then
    ShowCaret(True);
  FLeftButtonDown := False;

  if FSelButtonDown and not Dragging then
  begin
    ClearSelection;
    FSelButtonDown := False;
    SelClickUpdate(X, Y, false, Shift, Button);
  end;
end;



procedure TAdvCustomMemo.ReSize;
begin
  inherited;
  ResizeEditor;
end;

//--------------------------------------------------------------
//        WM_SIZE
//--------------------------------------------------------------
(*
procedure TAdvCustomMemo.WMSize(var Msg: TWMSize);
begin
  try
    ResizeEditor;
  except
  end;
end;
*)

{$IFNDEF TMSCLX}
//--------------------------------------------------------------
//        WM_GETDLGCODE
//--------------------------------------------------------------

procedure TAdvCustomMemo.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  if FWantTab then
    Msg.Result := DLGC_WANTARROWS or DLGC_WANTTAB or DLGC_WANTCHARS
  else
    Msg.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

//--------------------------------------------------------------
//        WM_ERASEBKGND
//--------------------------------------------------------------

procedure TAdvCustomMemo.WMEraseBkgnd(var Msg: TWmEraseBkgnd);
begin
  Msg.Result := 1;
end;

procedure TAdvCustomMemo.WMSysChar(var Msg: TWMSysChar);
begin
  if (Msg.CharCode = VK_BACK) and (GetKeyState(VK_MENU) and $8000 = $8000) then
  begin
    // eliminate beep
    Msg.CharCode := 0;
    Msg.Result := 0;
  end
  else
  begin
    inherited;
  end;
end;


procedure TAdvCustomMemo.CMWantSpecialKey(var Msg: TCMWantSpecialKey);
begin
  if (Msg.CharCode = VK_RETURN) then    // always get the return key
  begin
    Msg.Result := 1;
    Exit;
  end;
  inherited;
end;

//--------------------------------------------------------------
//        WM_SETCURSOR
//--------------------------------------------------------------

procedure TAdvCustomMemo.WMSetCursor(var Msg: TWMSetCursor);
var
  P: TPoint;
begin
  Msg.Result := 1;
  GetCursorPos(P);
  P := ScreenToClient(P);
  if PointInRect(P, EditorRect) then
    Windows.SetCursor(Screen.Cursors[Cursor])
  else
    Windows.SetCursor(Screen.Cursors[crArrow]);
end;
{$ENDIF}

//--------------------------------------------------------------
//        WM_SETFOCUS
//--------------------------------------------------------------

procedure TAdvCustomMemo.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if FCellSize.H = 0 then
    SetFont(FFont);

{$IFNDEF TMSCLX}
  CreateCaret(Handle, HBITMAP(0), 2, FCellSize.H - 2);
{$ENDIF}

{$IFDEF TMSCLX}
  CreateCaret(Canvas, FCaretBmp, 2, FCellSize.H - 2);
{$ENDIF}

  FCaretX := $FFFF;
  FCaretY := $FFFF;

  ShowCaret(True);
{$IFDEF BLINK}
  FCaretTime := GetCaretBlinkTime;
  SetCaretBlinkTime(FCaretTime);
  FletgetCaretTime := True;
  if not FHiddenCaret then
    ShowCaret(True);
{$ENDIF}
  Invalidate;
end;

//--------------------------------------------------------------
//        WM_KILLFOCUS
//--------------------------------------------------------------

procedure TAdvCustomMemo.WMKillFocus(var Message: TWMKillFocus);
begin
  Timer.Enabled := True;

  if not FHintShowing and FHintForm.Visible then
    FHintForm.Visible := False;

  if (sbVert.Focused) or (sbHorz.Focused) then
  begin
    inherited;
    Exit;
  end;

{$IFDEF BLINK}
  SetCaretBlinkTime(FCaretTime);
{$ENDIF}

  DestroyCaret;
  FCaretVisible := False;

  inherited;

  Invalidate;
end;

//--------------------------------------------------------------
//        WM_DROPFILES
//--------------------------------------------------------------

procedure TAdvCustomMemo.WMDropFiles(var Message: TMessage);
var
  Files: TStringList;
  FileCount,Len,i: Integer;
  {$IFNDEF TMSDOTNET}
  FileName: array[0..255] of Char;
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  FileName : StringBuilder;
  {$ENDIF}
  DefaultHandler: Boolean;
begin
  {$IFDEF TMSDOTNET}
  FileName := StringBuilder.Create(255);
  {$ENDIF}

  Files := TStringList.Create;
  try
    FileCount := DragQueryFile(Message.wParam, UINT(-1), nil, 0);
    for i := 0 to FileCount - 1 do
    begin
      {$IFNDEF TMSDOTNET}
      Len := DragQueryFile(Message.wParam, I, FileName, 255);
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      Len := DragQueryFile(Message.wParam, I, FileName, 255);
      {$ENDIF}
      if Len > 0 then
      begin
        {$IFNDEF TMSDOTNET}
        Files.Add(StrPas(FileName));
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        Files.Add(FileName.ToString);
        {$ENDIF}

        DefaultHandler := True;
        if Assigned(FOnFileDrop) then
          {$IFNDEF TMSDOTNET}
          FOnFileDrop(Self,StrPas(FileName),DefaultHandler);
          {$ENDIF}
          {$IFDEF TMSDOTNET}
          FOnFileDrop(Self,FileName.ToString,DefaultHandler);
          {$ENDIF}
        if DefaultHandler then
        begin
        {$IFNDEF TMSDOTNET}
          Lines.LoadFromFile(FileName);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
          Lines.LoadFromFile(FileName.ToString);
        {$ENDIF}
        end;
      end;
    end;
  finally
    Files.Free;
  end;
end;


//--------------------------------------------------------------
//        SHOW CARET
//--------------------------------------------------------------

procedure TAdvCustomMemo.ShowCaret(State: boolean);
var
  rct: TRect;
begin
  if not State then
  begin
    if FCaretVisible then
      HideCaret(Handle);

    FCaretVisible := False;
  end
  else if Focused and not HiddenCaret then
  begin
    if not CodeFolding.Enabled then    // kh:
      rct := CellRect(CurX - FLeftCol, CurY - FTopLine)
    else                                    // LineIndexToVisIndex(CurY - FTopLine)
      rct := CellRect(CurX - FLeftCol, LineIndexToVisIndex(CurY) - LineIndexToVisIndex(FTopLine));

    if (FCaretX <> Cardinal(rct.Left)) or (FCaretY <> Cardinal(rct.Top + 1)) then
      SetCaretPos(rct.Left, rct.Top + 1);

    FCaretX := rct.Left;
    FCaretY := rct.Top + 1;

    if not FCaretVisible then
{$IFDEF TMSCLX}
      AdvMemoCaret.ShowCaret(Handle);
{$ENDIF}
{$IFNDEF TMSCLX}
    Windows.ShowCaret(Handle);
{$ENDIF}
    FCaretVisible := True;
  end;
end;

//--------------------------------------------------------------
//        CELL RECT
//--------------------------------------------------------------

function TAdvCustomMemo.CellRect(ACol, ARow: integer): TRect;
var
  rct: TRect;
begin
  rct := EditorRect;
  with FCellSize do
    Result := Rect(rct.Left + W * ACol, rct.Top + H * ARow + 1,
      rct.Left + W * (ACol + 1), rct.Top + H * (ARow + 1) + 1);
end;

//--------------------------------------------------------------
//        LINE RECT
//--------------------------------------------------------------

function TAdvCustomMemo.LineRect(ARow: integer): TRect;
var
  rct: TRect;
begin
  rct := EditorRect;
  ARow := ARow - LineIndexToVisIndex(FTopLine);     // kh: FF: Sel iss
  with FCellSize do
    Result := Rect(rct.Left, rct.Top + H * ARow, rct.Right, rct.Top + H * (ARow + 1));
end;

//--------------------------------------------------------------
//        COL RECT
//--------------------------------------------------------------

function TAdvCustomMemo.ColRect(ACol: integer): TRect;
var
  rct: TRect;
begin
  rct := EditorRect;
  ACol := ACol - FLeftCol;
  with FCellSize do
    Result := Rect(rct.Left + W * ACol, rct.Top, rct.Left + W * (ACol + 1), rct.Bottom);
end;

//--------------------------------------------------------------
//        LINE RANGE RECT
//--------------------------------------------------------------

function TAdvCustomMemo.LineRangeRect(FromLine, ToLine: integer): TRect;
var
  rct1, rct2: TRect;
begin
  rct1 := LineRect(FromLine);
  rct2 := LineRect(ToLine);
  Result := TotalRect(rct1, rct2);
end;

//--------------------------------------------------------------
//        COL RANGE RECT
//--------------------------------------------------------------

function TAdvCustomMemo.ColRangeRect(FromCol, ToCol: integer): TRect;
var
  rct1, rct2: TRect;
begin
  rct1 := ColRect(FromCol);
  rct2 := ColRect(ToCol);
  Result := TotalRect(rct1, rct2);
end;

//--------------------------------------------------------------
//        MOUSE TO CURSOR
//--------------------------------------------------------------
procedure TAdvCustomMemo.MouseToCursor(X,Y: integer; var CursorX, CursorY: integer);
var
  cp: TCellPos;
begin
  cp := CellFromPos(X,Y);

  CursorX := cp.X;
  CursorY := cp.Y;
end;
//--------------------------------------------------------------
//        CELL and CHAR FROM POS
//--------------------------------------------------------------

function TAdvCustomMemo.CellFromPos(X, Y: integer): TCellPos;
var
  rct: TRect;
begin
  rct := EditorRect;
  if (FCellSize.H = 0) and Assigned(FFont) then
    SetFont(FFont);
  if (FCellSize.W <> 0) and (FCellSize.H <> 0) then
  begin
    Result.X := (X - rct.Left) div FCellSize.W;
    Result.Y := (Y - rct.Top) div FCellSize.H;
    {if not CodeFolding.Enabled then
      Result.Y := (Y - rct.Top) div FCellSize.H
    else
      Result.Y := VisIndexToLineIndex((Y - rct.Top) div FCellSize.H); }
  end
  else
  begin
    Result.X := 0;
    Result.Y := 0;
  end;
end;

function TAdvCustomMemo.CharFromPos(X, Y: integer): TFullPos;
var
  rct: TRect;
  I: Integer;
begin
  rct := EditorRect;
  if (FCellSize.H = 0) and Assigned(FFont) then SetFont(FFont);
  if (FCellSize.W <> 0) and (FCellSize.H <> 0) then
  begin
    Result.Pos := (X - rct.Left) div FCellSize.W + FLeftCol;
    if not CodeFolding.Enabled then
      Result.LineNo := (Y - rct.Top) div FCellSize.H + FTopLine
    else
    begin
      I := LineIndexToVisIndex(FTopLine) + (Y - rct.Top) div FCellSize.H;
      Result.LineNo := VisIndexToLineIndex(I);
    end;
  end
  else
  begin
    Result.Pos := 1;
    Result.LineNo := 1;
  end;
end;

//--------------------------------------------------------------
//        SET BORDER COLOR
//--------------------------------------------------------------
procedure TAdvCustomMemo.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
  Invalidate;
end;

//--------------------------------------------------------------
//        SET COLOR
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetColor(Index: integer; Value: TColor);
var
  Changed: boolean;
begin
  Changed := False;
  case Index of
    0: if FBkColor <> Value then
      begin
        FBkColor := Value;
        Changed := True;
      end;
    1: if FSelColor <> Value then
      begin
        FSelColor := Value;
        Changed := True;
      end;
    2: if FSelBkColor <> Value then
      begin
        FSelBkColor := Value;
        Changed := True;
      end;
  end;

  if Changed then
    Invalidate;
end;

//--------------------------------------------------------------
//        SET FONT
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetFont(Value: TFont);
var
  wW, wi: integer;
  OldFontName: string;
begin
  OldFontName := Canvas.Font.Name;
  Canvas.Font.Name := Value.Name;
  wW := Canvas.TextWidth('W');
  wi := Canvas.TextWidth('i');
  Canvas.Font.Name := OldFontName;

  if wW <> wi then
  begin
    // raise EAbort.Create('Monospace font required');
    Value.Name := 'FixedSys';
  end;

  FFont.Assign(Value);
  Canvas.Font.Assign(Value);

  FCellSize.W := Canvas.TextWidth('W');
  FCellSize.H := Canvas.TextHeight('W_') + 1;

  if FCaretVisible then
  begin
    ShowCaret(False);
    DestroyCaret;
{$IFNDEF TMSCLX}
    CreateCaret(Handle, HBITMAP(0), 2, FCellSize.H - 2);
{$ENDIF}
{$IFDEF TMSCLX}
    CreateCaret(Canvas, FCaretBmp, 2, FCellSize.H - 2);
{$ENDIF}
    ShowCaret(True);
  end;

  Invalidate;
end;


//--------------------------------------------------------------
//        SET HIDDEN CARET
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetHiddenCaret(Value: boolean);
begin
  if Value <> FHiddenCaret then
  begin
    FHiddenCaret := Value;
    if Focused then
      if FHiddenCaret = FCaretVisible then
        ShowCaret(not FHiddenCaret);
  end;
end;

function ansiRPos(Substr, str: string): integer;
var
  i, last: integer;
begin
  Result := 0;
  if length(Substr) > length(str) then exit;
  if Substr = str then
  begin
    Result := 1;
    exit;
  end;
  last := 0;
  repeat
    i := ansipos(Substr, str);
    if i > 0 then
    begin
      last := last + i;
      Delete(str, 1, i);
    end;
  until i = 0;
  Result := last;
end;


//--------------------------------------------------------------
//        BORDER
//--------------------------------------------------------------

procedure Border(Canvas: TCanvas; rct: TRect; BorderType: TBorderType);
const
  Colors: array[TBorderType] of array[1..4] of
  TColor = (($D0D0D0, clWhite, clGray, clBlack),
    (clGray, clBlack, $D0D0D0, clWhite),
    (clWhite, clWhite, clWhite, clGray),
    (clGray, clWhite, clWhite, clGray));
begin
  with Canvas do
  begin
    Pen.Color := Colors[BorderType][1];
    MoveTo(rct.Left, rct.Bottom - 1);
    LineTo(rct.Left, rct.Top);
    LineTo(rct.Right, rct.Top);
    if BorderType in [btRaised, btLowered] then
    begin
      Pen.Color := Colors[BorderType][2];
      MoveTo(rct.Left + 1, rct.Bottom);
      LineTo(rct.Left + 1, rct.Top + 1);
      LineTo(rct.Right, rct.Top + 1);
      Pen.Color := Colors[BorderType][3];
      MoveTo(rct.Left + 1, rct.Bottom - 2);
      LineTo(rct.Right - 2, rct.Bottom - 2);
      LineTo(rct.Right - 2, rct.Top + 1);
    end;
    Pen.Color := Colors[BorderType][4];
    MoveTo(rct.Left, rct.Bottom - 1);
    LineTo(rct.Right - 1, rct.Bottom - 1);
    LineTo(rct.Right - 1, rct.Top);
  end;
end;

//--------------------------------------------------------------
//        EDITOR RECT
//--------------------------------------------------------------

function TAdvCustomMemo.EditorRect: TRect;
var
  l, t, r, b: integer;
begin
  l := 2;
  r := Width - 2;
  t := 2;
  b := Height - 2;

  if (FGutter.GutterWidth > 2) and (fGutter.fShowGutter) then
    l := l + FGutter.GutterWidth;

  if (FScrollBars in [ssBoth, ssVertical]) and (sbVert.Visible) then
    r := r - sbVert.Width;

  if (FScrollBars in [ssBoth, ssHorizontal]) and (sbHorz.Visible) then
    b := b - sbHorz.Height;

  Result := Rect(l + FMargin, t, r, b);

  if BorderStyle = bsNone then
  begin
    InflateRect(Result, 2, 2);
  end
  else
  begin
    if not Ctl3D then
      InflateRect(Result, 1, 1);
  end;

  if FCodeFolding.Enabled and (FCodeFoldingNodeCount > 0) then
    Result.Left := Result.Left + NODE_WIDTH;
end;

//--------------------------------------------------------------
//        CodeFolding Rect
//--------------------------------------------------------------

function TAdvCustomMemo.CodeFoldingRect: TRect;
begin
  Result := Rect(0, 0, 0, 0);
  if FCodeFolding.Enabled then
  begin
    Result := EditorRect;
    Result.Right := Result.Left;
    Result.Left := Result.Left - NODE_WIDTH;
  end;
end;

//--------------------------------------------------------------
//        DRAW MARGIN
//--------------------------------------------------------------

procedure TAdvCustomMemo.DrawMargin;
var
  eRect: TRect;
  i: integer;
begin
  eRect := EditorRect;

  with Canvas do
  begin
    Pen.Color := BkColor;

    for i := 1 to FMargin do
    begin
      MoveTo(eRect.Left - i, eRect.Top);
      LineTo(eRect.Left - i, eRect.Bottom );
    end;

    Brush.Color := clScrollBar;
    Pen.Color := clScrollBar;

    if (FScrollBars in [ssBoth, ssHorizontal]) and (WordWrap = wwNone) and sbHorz.Visible then
    begin
      eRect := sbHorz.BoundsRect;
      InflateRect(eRect, 1, 1);
      FillRect(eRect);
    end;

    if (FScrollBars in [ssBoth, ssVertical]) and sbVert.Visible then
    begin
      eRect := sbVert.BoundsRect;
      InflateRect(eRect, 1, 1);
      FillRect(eRect);
    end;
  end;
end;

//--------------------------------------------------------------
//        DRAW GUTTER
//--------------------------------------------------------------

procedure TAdvCustomMemo.DrawGutter;
begin
  if (FGutter.GutterWidth < 2) or (not fGutter.fShowGutter) then
    Exit;
  ResizeGutter;
  FGutter.PaintTo(Canvas);
end;

//--------------------------------------------------------------
//        FRESH LINE BITMAP
//--------------------------------------------------------------

procedure TAdvCustomMemo.FreshLineBitmap;
var
  eRect: TRect;
begin
  eRect := EditorRect;
  with FLineBitmap do
  begin
    Width := Max(0, eRect.Right - eRect.Left);
    Height := FCellSize.H;
    FLineBitmap.Canvas.Font.Assign(Self.Canvas.Font);
    FLineBitmap.HandleType := bmDDB;
    if FClearType then
      FLineBitmap.PixelFormat := pfDevice
    else
      FLineBitmap.PixelFormat := pf8bit;
  end;
end;

//--------------------------------------------------------------
//        PAINT
//--------------------------------------------------------------

function TAdvCustomMemo.GetUpStyle(stopat: integer): TStyle;
var
  i, allb, ll, Iurl: integer;
  comment, bracket, linecomment: boolean;
  chBE, chBS: char;
  s: string;
  urls: TStringList;
  start: Integer;
  AStyle: TStyle;
  lit: char;
begin
  Result.isComment := False;
  Result.isBracket := False;
  Result.isnumber := False;
  Result.iskeyWord := False;
  Result.isdelimiter := False;
  Result.isURL := False;
  Result.index := -1;
  Result.EndBracket := #0;
  Result.StartBracket := #0;

  chBE := #0;
  chBS := #0;
  FTempdelimiters := '';

  if (not Assigned(InternalStyles)) or (not UseStyler) then
    Exit;

  s := InternalStyles.Literal;

  if length(s) > 0 then
    lit := s[1]
  else
    lit := #0;

  comment := False;
  bracket := False;

  for allb := 0 to InternalStyles.FAllStyles.Count - 1 do
  begin
    if InternalStyles.FAllStyles.Items[allb].FStyleType <> stSymbol then
      Continue;
    FTempdelimiters := FTempdelimiters + InternalStyles.FAllStyles.Items[allb].FSymbols;
  end;

  start := 0;

  if InternalLines.Count = 0 then
    Exit;

  // Find first occurence of cached last line style
  i := stopat - 1;
  while (i >= 0) do
  begin
    if GetLineStyle(i, AStyle) then
    begin
      comment := AStyle.isComment;
      bracket := AStyle.isBracket;
      //////////
      chBE := AStyle.EndBracket;
      chBS := AStyle.StartBracket;
      //////////
      start := i;
      Result := AStyle;
      Break;
    end
    else
      dec(i);
  end;

  urls := TStringList.Create;
  for i := start to stopat - 1 do
  begin
    if i >= InternalLines.Count then
      Break;
    s := InternalLines.Strings[i];
    if s = '' then
      Continue;
    urls.Clear;

    ExtractURL(s, urls);
    linecomment := False;

    for Iurl := 0 to urls.Count - 1 do
    begin
      s := urls[iurl];

      if FUrlAware then
        Result.isURL := WordIsURL(s) //(AnsiPos('http://', LowerCase(s)) = 1) or (AnsiPos('mailto:', LowerCase(s)) = 1) or (AnsiPos('www.', Lowercase(s)) = 1) or (AnsiPos('https://', LowerCase(s)) = 1)
      else
        Result.isURL := False;

      if (not linecomment) and (not Result.isURL) and (InternalStyles.FMultiCommentLeft <> '') and (s <> '') and
        (InternalStyles.FMultiCommentRight <> '') then
      begin
        while s <> '' do
        begin
          if (not comment) and (not bracket) then
          begin
            ll := AnsiPos(InternalStyles.FMultiCommentLeft, s);
            if ll = 1 then
            begin
              comment := true;
              Delete(s, 1, length(InternalStyles.FMultiCommentLeft));
            end;
          end;

          if s = '' then
            Break;

          if (comment) and (not bracket) then
          begin
            ll := AnsiPos(InternalStyles.FMultiCommentRight, s);
            if ll = 1 then
            begin
              comment := False;
              Delete(s, 1, length(InternalStyles.FMultiCommentRight));
            end;
          end;

          if s = '' then
            Break;

          if (not comment) and (not bracket) then
          begin
            ll := AnsiPos(InternalStyles.FLineComment, s);
            if ll = 1 then
            begin
              linecomment := True;
              Break;
            end;
          end;

          if not comment then
          begin
            for allb := 0 to InternalStyles.FAllStyles.Count - 1 do
              if (InternalStyles.FAllStyles.Items[allb].FStyleType = stBracket) and
                (InternalStyles.FAllStyles.Items[allb].BracketStart <> #0) and
                (InternalStyles.FAllStyles.Items[allb].BracketEnd <> #0) then
              begin
                if not bracket then
                begin
                  chBS := InternalStyles.FAllStyles.Items[allb].BracketStart;
                  chBE := InternalStyles.FAllStyles.Items[allb].BracketEnd;
                  Result.Index := allb;
                end;

                if length(s) > 0 then
                begin
                  if bracket then
                  begin
                    if s[1] = lit then
                    begin
                      Delete(s, 1, 1);
                      if length(s) > 0 then
                        Delete(s, 1, 1);
                      Continue;
                    end;
                  end;

                  if (s[1] = chBS) or (s[1] = chBE)
                    then
                  begin
                    bracket := not bracket;
                    Break;
                  end;
                end;
              end;
          end;
          Delete(s, 1, 1);
        end; //while s
      end; //if
    end; //for urls

    if (i mod 20 = 0) then
    begin
      if not GetLineStyle(i, AStyle) then
      begin
        AStyle.isComment := comment;
        AStyle.isBracket := bracket;
        AStyle.EndBracket := chBE;
        AStyle.StartBracket := chBS;
        AStyle.Index := Result.Index;
        SetLineStyle(i, AStyle);
      end;
    end;

  end; //for

  urls.Free;
  Result.isComment := comment;
  Result.isBracket := bracket;
  Result.EndBracket := chBE;
  Result.StartBracket := chBS;
  SetLineStyle(stopat, Result);
end;

function TAdvCustomMemo.GetBreakPoint(Index: Integer): Boolean;
var
  Tlp: TlineProp;
begin
  Tlp := InternalLines.GetLineProp(Index);
  if Assigned(Tlp) and (tlp is TLineProp) then
    Result := tlp.BreakPoint
  else
    Result := False;
end;

function TAdvCustomMemo.GetModifiedState(Index: Integer): Boolean;
var
  Tlp: TlineProp;
begin
  Tlp := InternalLines.GetLineProp(Index);
  if Assigned(Tlp) and (tlp is TLineProp) then
    Result := tlp.Modified
  else
    Result := False;
end;

function TAdvCustomMemo.GetWrapped(Index: Integer): Boolean;
var
  Tlp: TlineProp;
begin
  Tlp := InternalLines.GetLineProp(Index);
  if Assigned(Tlp) and (tlp is TLineProp) then
    Result := tlp.Wrapped
  else
    Result := False;
end;

function TAdvCustomMemo.GetWrappedLineIndex(Index: integer): integer;
var
  i: integer;
  LineNoR: integer;
begin
  if WordWrap = wwNone then
    Result := Index
  else
  begin
    LineNoR := Index;
    for i := 0 to Index do
    begin
      if GetWrapped(i) then
        dec(LineNoR);
    end;
    Result := LineNoR;
  end;

end;

function TAdvCustomMemo.GetBookmark(Index: Integer): Boolean;
var
  Tlp: TlineProp;
begin
  Tlp := InternalLines.GetLineProp(Index);
  if Assigned(Tlp) and (tlp is TLineProp) then
    Result := tlp.Bookmark
  else
    Result := False;
end;

function TAdvCustomMemo.GetExecutable(Index: Integer): Boolean;
var
  Tlp: TlineProp;
begin
  Tlp := InternalLines.GetLineProp(index);
  if (Tlp <> nil) and (tlp is TLineProp) then
    Result := tlp.Executable
  else
    Result := False;
end;

procedure TAdvCustomMemo.SetBreakPoint(Index: Integer;
  const Value: Boolean);
var
  Tlp: TlineProp;
begin
  InternalLines.OnChange := nil;
  Tlp := InternalLines.GetLineProp(index);
  if Tlp = nil then
    tlp := InternalLines.CreateProp(index);
  tlp.BreakPoint := Value;
  InternalLines.SetLineProp(index, tlp);
  InternalLines.OnChange := LinesChanged;
  Invalidate;
end;

procedure TAdvCustomMemo.SetModifiedState(Index: Integer;
  const Value: Boolean);
var
  tlp: TlineProp;
begin
  if Index >= InternalLines.Count then
    Exit;

  InternalLines.OnChange := nil;

  tlp := InternalLines.GetLineProp(index);
  if tlp = nil then
    tlp := InternalLines.CreateProp(index);

  if tlp.Modified <> Value then
  begin
    tlp.Modified := Value;
    InternalLines.SetLineProp(index, tlp);
    InternalLines.OnChange := LinesChanged;
    Invalidate;
  end;
end;

procedure TAdvCustomMemo.SetBookmark(Index: Integer;
  const Value: Boolean);
var
  Tlp: TlineProp;
begin
  InternalLines.OnChange := nil;
  Tlp := InternalLines.GetLineProp(index);
  if Tlp = nil then
    tlp := InternalLines.CreateProp(index);
  tlp.Bookmark := Value;
  InternalLines.SetLineProp(index, tlp);
  InternalLines.OnChange := LinesChanged;  
  Invalidate;
end;

procedure TAdvCustomMemo.SetWrapped(Index: Integer;
  const Value: Boolean);
var
  Tlp: TlineProp;
begin
  Tlp := InternalLines.GetLineProp(index);
  if Tlp = nil then
    tlp := InternalLines.CreateProp(index);
  tlp.Wrapped := Value;
  InternalLines.SetLineProp(index, tlp);
end;

function TAdvCustomMemo.GetLineStyle(Index: Integer; var LineStyle: TStyle): Boolean;
var
  Tlp: TlineProp;
begin
  Tlp := InternalLines.GetLineProp(index);
  if (Tlp <> nil) and (tlp is TLineProp) then
  begin
    Result := tlp.CachedStyle;
    if tlp.CachedStyle then
      LineStyle := tlp.Style
  end
  else
    Result := False;
end;

procedure TAdvCustomMemo.ClearLineStyles;
var
  i: Integer;
begin
  for i := 0 to InternalLines.FLinesProp.Count - 1 do
  begin
    TLineProp(InternalLines.FlinesProp[i]).CachedStyle := False;
  end;
end;

procedure TAdvCustomMemo.SetLineStyle(Index: Integer; const LineStyle: TStyle);
var
  Tlp: TlineProp;
begin
  Tlp := InternalLines.GetLineProp(index);
  if Tlp = nil then
    tlp := InternalLines.CreateProp(index);
  tlp.Style := LineStyle;
  tlp.CachedStyle := True;
  InternalLines.SetLineProp(index, tlp);
end;

procedure TAdvCustomMemo.SetExecutable(Index: Integer;
  const Value: Boolean);
var
  Tlp: TlineProp;
begin
  Tlp := InternalLines.GetLineProp(index);

  if Tlp = nil then
    tlp := InternalLines.CreateProp(index);

  tlp.Executable := value;

  InternalLines.SetLineProp(index, tlp);
  Invalidate;
end;

procedure TAdvCustomMemo.SetHideSelection(const Value: boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    Invalidate;
  end;
end;

procedure TAdvCustomMemo.SWAPColors;
var
  c: TColor;
begin
  c := FLineBitmap.Canvas.Brush.Color;
  FLineBitmap.Canvas.Brush.Color := FLineBitmap.Canvas.Font.Color;
  FLineBitmap.Canvas.Font.Color := c;
end;

procedure TAdvCustomMemo.ClearBreakpoints;
var
  i: Integer;
begin
  for i := 0 to InternalLines.FlinesProp.Count - 1 do
  begin
    TLineProp(InternalLines.FlinesProp[i]).BreakPoint := False;
  end;
  Invalidate;
end;

procedure TAdvCustomMemo.ClearModified;
var
  i: Integer;
begin
  for i := 0 to InternalLines.FlinesProp.Count - 1 do
  begin
    TLineProp(InternalLines.FlinesProp[i]).Modified := False;
  end;
  Invalidate;
end;


procedure TAdvCustomMemo.ClearExecutableLines;
var
  i: Integer;
begin
  for i := 0 to InternalLines.FlinesProp.Count - 1 do
  begin
    TlineProp(InternalLines.FlinesProp[i]).Executable := False;
  end;
  Invalidate;
end;

//--------------------------------------------------------------
//        DRAW LINE
//--------------------------------------------------------------

procedure TAdvCustomMemo.DrawLine(ACanvas: TCanvas; LineNo: Integer; var style: TStyle; DM: TDrawMode; PR: TRect; VisLineNo: Integer = -1);
const
  tab = #9;
var
  eRect, rct0, rct1, rct, lineRct, bkrct: TRect;
  LineSelStart, LineSelEnd, posln, i, ep, XC: integer;
  urls: TStringList;
  lnstr: string;
  S, S1, S2, S3: string;
  xSelStartX, xSelStartY, xSelEndX, xSelEndY: integer;
  isinlinecomment: boolean;
  backupstyle: TStyle;
  backupstring: string;
  LineCanvas: TCanvas;
  Tlp: TLineProp;
  lit: char;
  errstart, errend: Integer;
  RgnComentsFound: Boolean;
  RgnIndex: Integer;
  CodeFoldComent: Boolean;

  function Equal(s1, s2: string): boolean;
  begin
    if FCaseSensitive then
      Result := s1 = s2
    else
      Result := AnsiLowerCase(s1) = AnsiLowerCase(s2);
  end;

  //--------- FIND LINE SELECTION -------------
  procedure FindLineSelection(Selpart: string);
  var
    len: integer;
  begin
    s1 := '';
    s2 := '';
    s3 := '';

    if HideSelection then
    begin
      if not Focused and not FSearching then
      begin
        s1 := Selpart;
        Exit;
      end;
    end;

    if (lineno < xSelStartY) or (lineno > xSelEndY) then
    begin // outside selection lines (vertically)
      s1 := Selpart;
      Exit;
    end;

    if (xSelStartY < LineNo) and (LineNo < xSelEndY) then
    begin // inside multiple selection
      s2 := Selpart;
      Exit;
    end;

    len := length(Selpart);
    LineSelStart := 0;
    LineSelEnd := 0;

    if (xSelStartY = xSelEndY) then // single line selection
    begin
      if xSelStartX = xSelEndX then
      begin // nothing is selected
        s1 := Selpart;
        Exit;
      end;
      if xSelStartX >= posln + len then // selection didn't start
      begin
        s1 := Selpart;
        Exit;
      end;
      if xSelEndX <= posln then // selection ended
      begin
        s3 := Selpart;
        Exit;
      end;
      LineSelStart := xSelStartX - posln;
      LineSelEnd := xSelEndX - posln;
    end
    else
    begin // selection on 2 or more lines
      if (xSelStartY = LineNo) then
      begin
        LineSelStart := xSelStartX - posln;
        LineSelEnd := len;
      end;
      if (xSelEndY = LineNo) then
      begin
        LineSelEnd := xSelEndX - posln; ;
      end;
    end;

    if LineSelEnd > len then LineSelEnd := len;
    if LineSelEnd < 0 then LineSelEnd := 0;
    if LineSelStart < 0 then LineSelStart := 0;
    if LineSelStart > len then LineSelStart := len;

    S1 := Copy(Selpart, 1, LineSelStart);
    S2 := Copy(Selpart, LineSelStart + 1, LineSelEnd - LineSelStart);
    S3 := Copy(Selpart, LineSelEnd + 1, len - LineSelEnd);
  end;

  //------------- DRAW PART ---------------------
  procedure DrawPart(Part: string; var Drawstyle: TStyle);
  var
    len, selcol, brushcol, lx: integer;

    procedure LoadFromItemstyle;
    begin
      with LineCanvas do
      begin
        try
          Font.Color := InternalStyles.FAllStyles.Items[DrawStyle.index].Font.Color;
          Font.Style := InternalStyles.FAllStyles.Items[DrawStyle.index].Font.Style;

          if InternalStyles.FAllStyles.Items[DrawStyle.index].FBGColor <> clNone then
            Brush.Color := InternalStyles.FAllStyles.Items[DrawStyle.index].FBGColor
          else
            Brush.Color := self.BkColor;
        except
          on Exception do
          begin
            Font.Color := Self.Font.Color;
            Font.Style := Self.Font.Style;
            Brush.Color := Self.BkColor;
          end;
        end;
      end;
    end;

  begin
    len := Length(Part);

    if len > 0 then
    begin
      if DM = dmHTML then
      begin
        DrawHTML(part, Drawstyle, lineno);
        inc(posln, length(Part));
        Exit;
      end;

      if DM = dmRTF then
      begin
        DrawRTF(part, Drawstyle, lineno);
        inc(posln, length(Part));
        Exit;
      end;

      with LineCanvas do
      begin
        Font.Color := Self.Font.Color;
        Font.Style := Self.Font.Style;

        Brush.Color := Self.BkColor;
        begin
          if (DrawStyle.isComment) and (not DrawStyle.isURL) then
          begin
            Font.Color := InternalStyles.CommentStyle.FTextColor;
            Font.Style := InternalStyles.CommentStyle.FStyle;
            if InternalStyles.CommentStyle.FBkColor <> clNone then
              Brush.Color := InternalStyles.CommentStyle.FBkColor
            else
              Brush.Color := Self.BkColor
          end
          else
          begin
            if (DrawStyle.isBracket) and (not DrawStyle.isURL) then
              LoadFromItemStyle
            else
            begin
              if DrawStyle.isNumber then
              begin
                Font.Color := InternalStyles.FNumberStyle.FTextColor;
                Font.Style := InternalStyles.FNumberStyle.Style;
                if InternalStyles.FNumberStyle.FBkColor <> clNone then
                  Brush.Color := InternalStyles.FNumberStyle.FBkColor
                else
                  Brush.Color := self.BkColor
              end;

              if DrawStyle.isDelimiter then
                LoadFromItemStyle;

              if DrawStyle.isKeyWord then
              begin
                LoadFromItemStyle;
              end;

              if DrawStyle.isURL then
              begin
                Font.Color := FUrlStyle.FTextColor;
                Font.Style := FUrlStyle.Style;
                if FUrlStyle.BkColor <> clNone then
                  Brush.Color := FUrlStyle.FBkColor
                else
                  Brush.Color := self.BkColor
              end;
            end;
          end;
        end;

        if (LineNo = ActiveLine) and (FActiveLineSettings.FShowActiveLine) then
        begin
          Font.Color := FActiveLineSettings.FActiveLineTextColor;
          Brush.Color := FActiveLineSettings.FActiveLineColor;
        end;

        if BreakPoint[LineNo] then
        begin
          Font.Color := FBreakpointTextColor;
          Brush.Color := FBreakpointColor;
        end;

        if CodeFoldComent then
          Font.Color := FCodeFolding.LineColor;

        if part <> '' then
        begin
          FindLineSelection(part);
          selcol := LineCanvas.Font.Color;
          brushcol := LineCanvas.Brush.Color;

          lx := rct1.Left div FCellSize.W;

          if FBlockShow then
          begin
            if (Lineno = bsselline) and (lx = bsselstart) then
              LineCanvas.Brush.Color := BlockColor;
            if (Lineno = beselline) and (lx = beselstart) then
              LineCanvas.Brush.Color := BlockColor;
          end;

          if s1 <> '' then
          begin
{$IFNDEF TMSCLX}

{$IFNDEF TMSDOTNET}
            DrawText(LineCanvas.Handle, PChar(s1), length(s1), rct1,
              DT_LEFT or DT_SINGLELINE or DT_NOPREFIX or DT_NOCLIP or DT_EDITCONTROL);
{$ENDIF}

{$IFDEF TMSDOTNET}
            DrawText(LineCanvas.Handle, s1, length(s1), rct1,
              DT_LEFT or DT_SINGLELINE or DT_NOPREFIX or DT_NOCLIP OR DT_EDITCONTROL);
{$ENDIF}

{$ENDIF}

{$IFDEF TMSCLX}
            LineCanvas.TextOut(rct1.Left, 0, s1);
{$ENDIF}

            if DM = dmScreen then
              rct1.Left := rct1.Left + (Length(s1) * FCellSize.W)
            else
              rct1.Left := rct1.Left + (Length(s1) * LineCanvas.TextWidth('w'));
          end;
          if s2 <> '' then
          begin
            if ((LineNo = ActiveLine) and (fActiveLineSettings.fShowActiveLine)) or (BreakPoint[LineNo]) then
              SWAPColors
            else
            begin
              LineCanvas.Font.Color := Self.FSelColor;
              LineCanvas.Brush.Color := Self.FSelBkColor;
            end;

{$IFNDEF TMSCLX}
{$IFNDEF TMSDOTNET}
            DrawText(LineCanvas.Handle, PChar(s2), Length(s2), rct1,
              DT_LEFT or DT_SINGLELINE or DT_NOPREFIX or DT_NOCLIP or DT_EDITCONTROL);
{$ENDIF}

{$IFDEF TMSDOTNET}
            DrawText(LineCanvas.Handle, s2, Length(s2), rct1,
              DT_LEFT or DT_SINGLELINE or DT_NOPREFIX or DT_NOCLIP or DT_EDITCONTROL);
{$ENDIF}
{$ENDIF}

{$IFDEF TMSCLX}
            LineCanvas.TextOut(rct1.Left, 0, s2);
{$ENDIF}

            if DM = dmScreen then
              rct1.Left := rct1.Left + (Length(s2) * FCellSize.W)
            else
              rct1.Left := rct1.Left + (Length(s2) * LineCanvas.TextWidth('w'));

          end;
          if s3 <> '' then
          begin
            LineCanvas.Font.Color := selcol;
            LineCanvas.Brush.Color := brushcol;

{$IFNDEF TMSCLX}
{$IFNDEF TMSDOTNET}
            DrawText(LineCanvas.Handle, PChar(s3), length(s3), rct1,
              DT_LEFT or DT_SINGLELINE or DT_NOPREFIX or DT_NOCLIP or DT_EDITCONTROL);
{$ENDIF}
{$IFDEF TMSDOTNET}
            DrawText(LineCanvas.Handle, s3, length(s3), rct1,
              DT_LEFT or DT_SINGLELINE or DT_NOPREFIX or DT_NOCLIP or DT_EDITCONTROL);
{$ENDIF}
{$ENDIF}

{$IFDEF TMSCLX}
            Canvas.TextOut(rct1.Left, 0, s3);
{$ENDIF}

            if DM = dmScreen then
              rct1.Left := rct1.Left + (Length(s3) * FCellSize.W)
            else
              rct1.Left := rct1.Left + (Length(s3) * LineCanvas.TextWidth('w'));
          end;
          Inc(posln, length(Part));
        end;
      end;
    end;
  end;

  procedure BufferingDraw(part: string; var bufstyle: TStyle);

    function egalstyle(stl1, stl2: Tstyle): Boolean;
    begin
      Result :=
        (stl1.isComment = stl2.isComment) and
        (stl1.isBracket = stl2.isBracket) and
        (stl1.isnumber = stl2.isnumber) and
        (stl1.iskeyWord = stl2.iskeyWord) and
        (stl1.isdelimiter = stl2.isdelimiter) and
        (stl1.isURL = stl2.isURL) and
        (stl1.EndBracket = stl2.EndBracket) and
        (stl1.StartBracket = stl2.StartBracket) and
        (stl1.index = stl2.index);
    end;

    procedure ResetPartStyle;
    begin
      bufstyle.isnumber := False;
      bufstyle.iskeyWord := False;
      bufstyle.isdelimiter := False;
      bufstyle.isURL := False;
    end;

  begin
    if egalstyle(bufstyle, backupstyle) then
    begin
      backupstring := backupstring + part;
    end
    else
    begin
      DrawPart(backupstring, backupstyle);
      backupstyle := bufstyle;
      backupstring := part;
    end;
    resetPartStyle;
  end;

  //------------- DRAW SEGMENTS ---------------------
  procedure DrawSegments(S: string; var rct: TRect;
    var SegmentStyle: Tstyle);
  var
    i, len, toStart, toEnd, Innr, lc, rc: integer;
    done, WasPoint: boolean;
    validno: boolean;
    part, partc: string;
    numsallowed: string;
    mcrl, mcll: Integer;
  begin
    if (not Assigned(InternalStyles)) or (not UseStyler) then
    begin
      BufferingDraw(s, SegmentStyle);
      Exit;
    end;

    if (SegmentStyle.isURL) and (FUrlAware) then
    begin
      BufferingDraw(s, SegmentStyle);
      Exit;
    end;

    toStart := 1;
    validno := True;
    done := false;

    mcrl := length(InternalStyles.FMultiCommentRight);
    mcll := length(InternalStyles.FMultiCommentLeft);

    while S <> '' do
    begin
      Len := Length(S);
      if (len = 0) or (tostart > len) then
        Exit;

      if not done then
      begin
        validno := (toStart = 1) or (s[toStart] = #32) or (FTempDelimiters = '') or
          ((AnsiPos(S[toStart], FTempDelimiters) > 0));
      end;

      done := False;

      // Parse for multi-line comments
      if (not SegmentStyle.isBracket) then
        if (InternalStyles.FMultiCommentLeft <> '') and
          (InternalStyles.FMultiCommentRight <> '') then
        begin
          if SegmentStyle.isComment then
          begin
            rc := AnsiPos(InternalStyles.FMultiCommentRight, s);

            if (rc > 0) then
            begin
              BufferingDraw(copy(s, 1, rc + mcrl - 1), SegmentStyle);
              Delete(s, 1, rc + mcrl - 1);
              SegmentStyle.isComment := False;
              len := length(s);
              if len = 0 then
                Exit;
            end
            else
            begin
              BufferingDraw(s, SegmentStyle);
              Exit;
            end;
          end
          else
          begin
          // rc := AnsiPos(InternalStyles.FLineComment, s);
            lc := AnsiPos(InternalStyles.FMultiCommentLeft, s);

          // For canceling the multi-line comment
          //if (lc > 0) and ((lc < rc) or (rc = 0)) then
            if (lc = tostart) {and ((lc < rc) or (rc = 0))} then
            begin
            //part := copy(s, 1, lc - 1);
            //BufferingDraw(part, SegmentStyle);
              Delete(s, 1, (lc - 1) + mcll);
              tostart := 1;   // Set toStart back to 1 dur to above deletion
              SegmentStyle.isComment := True;
              BufferingDraw(InternalStyles.FMultiCommentLeft, SegmentStyle);
              len := length(s);
              if len = 0 then
                Exit;
              done := True;
            end
          end;
        end;

      if not done then
      begin
        // line comment
        if (not SegmentStyle.isComment) then
        begin
          if (not SegmentStyle.isBracket) and (AnsiPos(InternalStyles.LineComment, s) = tostart) then
          begin
            part := copy(s, tostart, len - tostart + 1);
            SegmentStyle.isComment := True;
            BufferingDraw(part, SegmentStyle);
            isinlinecomment := True;
            Exit;
          end;

          // parse for bracket
          if (SegmentStyle.isBracket) and (SegmentStyle.StartBracket <> #0) then
          begin
            // literal output
            if s[tostart] = lit then
            begin
              BufferingDraw(s[tostart], SegmentStyle);
              Delete(s, tostart, 1);
              len := length(s);
              if tostart > len then
                Exit;

              BufferingDraw(s[tostart], SegmentStyle);
              Delete(s, tostart, 1);
              len := length(s);
              if tostart > len then
                Exit;
              done := True;
              Continue;
            end;

            // end of bracket string detected here
            if s[tostart] = SegmentStyle.EndBracket then
            begin
              BufferingDraw(s[tostart], SegmentStyle);
              Delete(s, tostart, 1);
              SegmentStyle.isBracket := False;
              validno := False;
              done := True;
              Continue;
            end
            else
            begin
              BufferingDraw(s[tostart], SegmentStyle);
              inc(tostart);
              len := length(s);
              if tostart > len then
              begin
                if SegmentStyle.EndBracket = #32 then
                begin
                  SegmentStyle.isBracket := false;
                  SegmentStyle.StartBracket := #0;
                  SegmentStyle.EndBracket := #0;
                end;
                Exit;
              end;
              done := True;
            end;
          end
          else
          begin
            SegmentStyle.EndBracket := #0;
            SegmentStyle.StartBracket := #0;

            for lc := 0 to InternalStyles.FAllStyles.Count - 1 do
            begin
              if InternalStyles.FAllStyles.Items[lc].FStyleType <> stBracket then
                Continue;

              SegmentStyle.EndBracket := InternalStyles.FAllStyles.Items[lc].BracketEnd;
              SegmentStyle.StartBracket := InternalStyles.FAllStyles.Items[lc].BracketStart;

              SegmentStyle.index := lc;
              if (SegmentStyle.EndBracket <> #0) and
                (s[toStart] = SegmentStyle.StartBracket) then
              begin
                SegmentStyle.isBracket := True;
                SegmentStyle.EndBracket := InternalStyles.FAllStyles.Items[lc].BracketEnd;
                SegmentStyle.StartBracket := InternalStyles.FAllStyles.Items[lc].BracketStart;
                Break;
              end;
            end;

            if SegmentStyle.isBracket then
            begin
              BufferingDraw(s[toStart], SegmentStyle);
              Delete(s, toStart, 1);
              Continue;
            end;
          end;
        end;
      end; //End if not done

      len := length(s);
      if (Len = 0) or (toStart > len) then
        Exit;

      if not done then
        for i := 0 to InternalStyles.FAllStyles.Count - 1 do
        begin
          if InternalStyles.FAllStyles.Items[i].FStyleType <> stSymbol then
            Continue;

          if (toStart <= len) and
            (AnsiPos(S[toStart], InternalStyles.FAllStyles.Items[i].FSymbols) > 0) then
          begin
            SegmentStyle.isDelimiter := True;
            SegmentStyle.index := i;
            BufferingDraw(s[toStart], SegmentStyle);
            Delete(s, toStart, 1);
            validno := True;
            Len := Length(S);
            done := True;
            Break;
          end;
        end;

      if done then
        Continue;

      toEnd := tostart;
      if (len = 0) or (tostart > Len) then
        Exit;

      if validno then
        if (AnsiPos(UpCase(S[tostart]), FtmpNoStart) > 0) then
        begin
          if Pos(FtmpNoHex, Uppercase(s)) = toStart then
          begin
            numsallowed := FtmpNo + 'ABCDEF';
            toEnd := toEnd + length(ftmpnohex);
          end
          else
            numsallowed := FtmpNo;

          WasPoint := False;
          Innr := toStart;

          while ((toEnd <= Len) and (AnsiPos(UpCase(S[toEnd]), numsallowed) > 0)) do
          begin
            if UpperCase(copy(s, tostart, toend)) = FtmpNoHex then
              numsallowed := FtmpNo + 'ABCDEF';

            if S[toEnd] = '.' then
            begin
              if WasPoint then
              begin
                toEnd := Innr;
                Break;
              end;
              WasPoint := True;
              Innr := toEnd;
            end;
            Inc(toEnd);
          end;

          Dec(toEnd);

          if (tostart <= toend) then
          begin
            SegmentStyle.isDelimiter := False;
            SegmentStyle.isNumber := True;
            part := copy(s, tostart, toend - tostart + 1);
            Delete(s, tostart, toend - tostart + 1);
            BufferingDraw(part, SegmentStyle);
            validno := False;
            done := True;
          end;
        end;

      if done then
        Continue;

      Len := Length(S);

      if (len = 0) or (tostart > Len) then
        Exit;

      toend := tostart + 1;

      while (toend <= Len) and (S[toend] <> #32) and (not ( (s[toend] = ';') or (s[toend] = ':')) )
        and (AnsiPos(S[toend], FTempdelimiters) = 0) do
        Inc(toend);

      part := Copy(S, toStart, toEnd - toStart);

      //1.6.0.16 fix
      // part := Copy(S, 1, toEnd -1);

      if (length(part) >= 1) and (validno) then
      begin

        if not CaseSensitive then
          partc := AnsiLowerCase(part)
        else
          partc := part;

        for i := 0 to InternalStyles.FAllStyles.Count - 1 do
        begin
          if InternalStyles.FAllStyles.Items[i].FStyleType = stKeyword then
          begin
            {$IFDEF DELPHI6_LVL}
            InternalStyles.FAllStyles.Items[i].FKeywords.CaseSensitive := CaseSensitive;
            {$ENDIF}

            if InternalStyles.FAllStyles.Items[i].FKeyWords.IndexOf(partc) <> - 1 then
            begin
              SegmentStyle.iskeyWord := True;
              SegmentStyle.index := i;

              if InternalStyles.CustomDraw then
              begin
                BufferingDraw(backupstring, SegmentStyle);
                InternalStyles.DrawKeyword(LineCanvas, part, rct1);
                backupstring := '';
              end
              else
              begin
                BufferingDraw(part, SegmentStyle);
              end;
              Delete(s, toStart, toend - tostart);
              done := True;
              Break;
            end;
          end;
        end;
      end;


      if done then
        Continue;

      if not done then
      begin
        BufferingDraw(s[toStart], SegmentStyle);
      //  BufferingDraw(part,SegmentStyle);
      //  delete(s,1,length(part)-1);
      //  inc(tostart,length(part));
      end;
      //else
      inc(toStart);

      //inc(toStart,length(part));
    end;
  end;

  // Writes the line number.
  procedure DrawLineNumber(s: string);
  var
    AStr: string;
    fillertotallen, fillerlen: integer;
  begin
    if fGutter.FShowLeadingZeros then
      AStr := FormatLineNumber(XC, LineNo + FGutter.FLineNumberStart) + FGutter.NumberSuffix
    else
      AStr := IntToStr(LineNo + fGutter.FLineNumberStart) + FGutter.NumberSuffix;

    fillertotallen := Length(IntToStr(Lines.Count) + FGutter.NumberSuffix) * LineCanvas.TextWidth('w');
    fillerlen := fillertotallen - (Length(AStr) * LineCanvas.TextWidth('w'));

    LineCanvas.Font.Style := [];
    LineCanvas.Font.Color := clBlack;
    //set left margin for line number
    rct1.Left := rct1.Left + fillerlen;
    LineCanvas.TextOut(rct1.Left, rct1.Top, AStr);
    //reset left margin for starting of text
    rct1.Left := rct1.Left + fillertotallen - fillerlen;
  end;

begin
  if not (DM = dmHTML) and not (DM = dmRTF) then
  begin
    eRect := EditorRect;
    if CodeFolding.Enabled and (VisLineNo > -1) then
      rct := CellRect(0, VisLineNo - FTopLine)
    else
      rct := CellRect(0, LineNo - FTopLine);
    rct0 := Rect(eRect.Left, rct.Top, eRect.Right, rct.Bottom);
    lineRct := rct0;
  end;

  case DM of
    dmScreen: LineCanvas := FLineBitmap.Canvas;
    dmPrinter, dmHTML, dmRTF: LineCanvas := ACanvas;
    dmPrintPreview: LineCanvas := FLineBitmap.canvas;
  end;

//{$IFDEF CLX}
  LineCanvas.Brush.Color := bkColor;
  LineCanvas.FillRect(Rect(0, 0, erect.Right, rct.Bottom - rct.Top ));
//{$ENDIF}

  s := '';
  if (Assigned(InternalStyles)) and (UseStyler) then
    s := InternalStyles.Literal;

  if length(s) > 0 then
    lit := s[1]
  else
    lit := #0;

  if LineNo < InternalLines.Count then
  begin
    rct := rct0;
    S := InternalLines[LineNo];

    if not (DM = dmHTML) and not (DM = dmRTF) then
    begin
      xSelStartX := FSelStartX;
      xSelEndX := FSelEndX;
      xSelStartY := FSelStartY;
      xSelEndY := FSelEndY;
      OrderPos(xSelStartX, xSelStartY, xSelEndX, xSelEndY);
      rct1 := rct;
      rct1.Left := rct1.Left - eRect.Left;
      rct1.Right := rct1.Right - eRect.Left;
      rct1.Top := rct1.Top - rct.Top;
      rct1.Bottom := rct1.Bottom - rct.Top;
      rct1.Left := rct1.Left - FLeftCol * FCellSize.W;
    end;

    if (DM = dmPrinter) or (DM = dmPrintPreview) then
      rct1 := PR;

    // print line numbers
    if (PrintOptions.FPrintLineNumbers) and ((DM = dmPrinter) or (DM = dmPrintPreview)) then
    begin
      lnstr := IntToStr(LineNo + 1) + FGutter.NumberSuffix;
      DrawLineNumber(lnstr);
    end;
    //-----------------------------------------

    posln := 0;
    backupstyle := style;
    isinlinecomment := False;

    RgnComentsFound := False;
    CodeFoldComent := False;
    if IsNode(LineNo) and not ExpandNode[LineNo] then
    begin
      if GetNodeComments(LineNo, RgnIndex, BackupString) then
      begin
        RgnComentsFound := True;
        CodeFoldComent := True;
        DrawPart(BackupString, BackupStyle);
        CodeFoldComent := False;
      end;
    end;

    if not RgnComentsFound then
    begin
      if URLAware then
      begin
        urls := TStringList.Create;

        ExtractURL(s, urls);

        for i := 0 to urls.Count - 1 do
        begin
          if FUrlAware then
            style.isURL := WordIsUrl(urls.Strings[i])
              {
              (ansipos('http://', LowerCase(urls.Strings[i])) = 1) or
              (AnsiPos('https://', LowerCase(urls.Strings[i])) = 1) or
              (AnsiPos('mailto:', LowerCase(urls.Strings[i])) = 1) or
              (AnsiPos('www.', LowerCase(urls.Strings[i])) = 1)
              }
          else
            style.isURL := False;
          DrawSegments(urls.Strings[i], rct1, style);
        end;
        urls.Free;
      end
      else
      begin
        DrawSegments(s, rct1, style);
      end;
    end;
    {
    RgnFound := False;
    if CodeFolding.Enabled and IsNode(LineNo) and not ExpandNode[LineNo] and (DM <> dmHTML) and (DM <> dmRTF) then
    begin
      ToSt := 1;
      PartLen := Length(BackupString);
      ToEn := ToSt;
      while (ToEn <= PartLen) and (BackupString[ToEn] <> #32) and (not (BackupString[ToEn] in [';', ':']))
        and (BackupString[ToEn] <> InternalStyles.FMultiCommentRight) do
        Inc(ToEn);

      PartS := Trim(Copy(BackupString, ToSt, ToEn));

      for rgn := 0 to FInternalStyles.RegionDefinitions.Count - 1 do
      begin
        if (UpperCase(PartS) = UpperCase(FInternalStyles.RegionDefinitions.Items[rgn].Identifier))
          or (UpperCase(PartS) = UpperCase(FInternalStyles.RegionDefinitions.Items[rgn].RegionStart))
          or (UpperCase(PartS) = UpperCase(FInternalStyles.RegionDefinitions.Items[rgn].RegionEnd)) then
        begin
          if FInternalStyles.RegionDefinitions.Items[rgn].ShowComments then
          begin
            RgnFound := True;
            ToSt := ToEn;
            PartLen := Length(BackupString);
            ToEn := ToSt;
            while (ToEn <= PartLen) and (BackupString[ToEn] <> InternalStyles.FMultiCommentRight) do
              Inc(ToEn);

            PartS := '['+Trim(Copy(BackupString, ToSt, ToEn - ToSt))+']';
            BackupString := PartS;
            CodeFoldComent := True;
            DrawPart(BackupString, BackupStyle);
            CodeFoldComent := False;
          end;
          Break;
        end;
      end;

      if not RgnFound then
        DrawPart(BackupString, BackupStyle);
    end
    else }

    if not RgnComentsFound then
      DrawPart(BackupString, BackupStyle);

    if isinlinecomment then
      style.isComment := False;

    if (DM = dmHTML) or (DM = dmRTF) then
      Exit;

    with LineCanvas do
    begin
      if BreakPoint[LineNo] then
        Brush.color := FBreakpointColor
      else
      begin
        if (LineNo = ActiveLine) and (FActiveLineSettings.FShowActiveLine) then
          Brush.color := FActiveLineSettings.FActiveLineColor
        else
          Brush.Color := BkColor;
      end;

      bkrct := rct1;
      bkrct.Bottom := bkrct.Bottom - 1;
      FillRect(bkrct);

      if CodeFolding.Enabled then
      begin
        if IsNode(LineNo) and not ExpandNode[LineNo] and not RgnComentsFound then
        begin
          LineCanvas.Brush.Color := BkColor;
          LineCanvas.Pen.Color := CodeFolding.LineColor;
          LineCanvas.Rectangle(rct1.Left + 5, rct1.Top, rct1.Left + 30, rct1.Bottom);

          LineCanvas.Rectangle(rct1.Left + 9, rct1.Bottom - 6, rct1.Left + 11, rct1.Bottom - 4);
          LineCanvas.Rectangle(rct1.Left + 17, rct1.Bottom - 6, rct1.Left + 19, rct1.Bottom - 4);
          LineCanvas.Rectangle(rct1.Left + 25, rct1.Bottom - 6, rct1.Left + 27, rct1.Bottom - 4);
        end;
      end;

      Tlp := InternalLines.GetLineProp(LineNo);

      if Assigned(Tlp) then
      begin
        for ep := 1 to Tlp.FErrStart.Count do
        begin
          errstart := Tlp.FErrStart.Items[ep - 1] - LeftCol;
          errend := Tlp.FErrStart.Items[ep - 1] + Tlp.FErrLen.Items[ep - 1] - LeftCol;

          if errstart < 0 then
            errstart := 0;
          if errend < 0 then
            errend := 0;

          if errstart <> errend then
            DrawError(LineCanvas, Rect(errstart * FCellSize.W, FCellSize.H - 2,
              errend * FCellSize.W, FCellSize.H - 2));
        end;
      end;

      if (LineNo = BSSelLine) and (BSSelStart >= 0) and (fBlockShow) and (BlockLineColor <> clNone) then
      begin
        LineCanvas.Pen.Color := FBlockLineColor;
        LineCanvas.MoveTo(BSSelStart * FCellSize.W, FCellSize.H - 2);
        LineCanvas.LineTo((BSSelStart + BSSelLen) * FCellSize.W, FCellSize.H - 2);
      end;

      if (LineNo = BESelLine) and (BESelStart >= 0) and (fBlockShow) and (BlockLineColor <> clNone) then
      begin
        LineCanvas.Pen.Color := FBlockLineColor;
        LineCanvas.MoveTo(BESelStart * FCellSize.W, FCellSize.H - 2);
        LineCanvas.LineTo((BESelStart + BESelLen) * FCellSize.W, FCellSize.H - 2);
      end;
    end;

    if (DM = dmScreen) or (DM = dmPrintPreview) then
      with LineRct do
{$IFNDEF TMSCLX}
        BitBlt(ACanvas.Handle, Left, Top, Right - Left, Bottom - Top,
          LineCanvas.Handle, 0, 0, SRCCOPY);
{$ENDIF}
{$IFDEF TMSCLX}
    ACanvas.CopyRect(LineRct, LineCanvas, Rect(0, 0, Right - Left, Bottom - Top));
{$ENDIF}
  end
  else
    with ACanvas do
    begin
      Brush.Color := BkColor;
      case DM of
        dmScreen: FillRect(rct0);
        dmPrinter: FillRect(PR);
        dmPrintPreview: FillRect(rct0);
      end;
    end;
end;

{$IFDEF TMSCLX}

procedure TAdvCustomMemo.InvalidateRect(Handle: QWidgetH; rect: pointer; flag: boolean);
begin
  Invalidate;
end;
{$ENDIF}

procedure TAdvCustomMemo.Paint;
var
  eRect, pRect: TRect;
  i, dw, ll: integer;
//  clipRgn: HRGN;
  LineStyle: TStyle;
{$IFDEF FREEWARE}
  OldFont: TFont;
{$ENDIF}
{$IFDEF TMSDEBUG}
  t: dword;
{$ENDIF}
  brk, DoDrwLine: Boolean;
  Tlp: TLineProp;
  rct, cfRct: TRect;
  PrentCount, P, C, ln, ch, nt: Integer;
  DrawConectLine: Boolean;
  GlpRct: TRect;
begin
  if TAdvMemoStrings(InternalLines).FLockCount > 0 then
    Exit;

{$IFDEF TMSDEBUG}
  t := gettickcount;
{$ENDIF}

  with Canvas do
  begin
    if FCellSize.H = 0 then
      SetFont(FFont);

    FreshLineBitmap;

    // CodeFolding BackGround
    eRect := CodeFoldingRect;
    Canvas.Brush.color := FbkColor;
    Canvas.Pen.Color := FBkColor;
    eRect.Left := eRect.Left - 2;

    FillRect(eRect);

    DrawGutter;

    pRect := EditorRect;
    eRect := EditorRect;

    eRect.Bottom := 2;
    Canvas.Brush.color := FbkColor;
    Canvas.Pen.Color := FBkColor;
    FillRect(eRect);

    if TopLine = FbackupTopLine then
      LineStyle := FbackupTopStyle
    else
    begin
      FLetRefresh := False;
      LineStyle := GetUpStyle(TopLine);
      FLetRefresh := True;
      FbackupTopStyle := LineStyle;
      FbackupTopLine := TopLine;
    end;

    if (Assigned(InternalStyles)) and (UseStyler) then
    begin
      FtmpNoStart := UpperCase(InternalStyles.FNumericChars + InternalStyles.FHexIdentifier);
      FtmpNo := UpperCase(InternalStyles.FNumericChars) + 'E';
      FtmpNoHex := Uppercase(InternalStyles.FHexIdentifier);
    end
    else
    begin
      FtmpNoStart := '';
      FtmpNo := '';
    end;

    ll := FTopLine;
    brk := False;

    {
    for i := FTopLine to FTopLine + VisibleLineCount do
    begin
      if InternalLines.Count <= i then
      begin
        brk := true;
        Break;
      end;
      DrawLine(Canvas, i, LineStyle, dmScreen, pRect);
      ll := i;
    end; }

    PrentCount:= 0;
    i := FTopLine;
    ln := FTopLine;
    while  i <= (FTopLine + VisibleLineCount) do
    begin
      if InternalLines.Count <= i then
      begin
        brk := true;
        Break;
      end;

      //ll := i;

      if FCodeFolding.Enabled then
      begin
        if InternalLines.Count <= ln then
        begin
          brk := true;
          Break;
        end;

        rct := CellRect(0, i - FTopLine);
        cfRct := Rect(eRect.Left, rct.Top, eRect.Right, rct.Bottom);
        rct := CodeFoldingRect;
        cfRct.Left := Rct.Left;
        cfRct.Right := rct.Right;
        nt := ((cfRct.Bottom - cfRct.Top) - 9) div 2;

        Tlp := InternalLines.GetLineProp(ln);
        if Assigned(Tlp) and (Tlp is TLineProp) then
        begin
          DoDrwLine := True;
          Canvas.Pen.Color := FCodeFolding.LineColor;
          if Tlp.HasParent {and (PrentCount > 0)} then
          begin
            DrawConectLine := True;
            if not Tlp.Expanded then
            begin
              ch := LastChildOfParent(ln);
              if (ch >= 0) and ((ch + 1) >= InternalLines.Count) then
                DrawConectLine := False;
            end;
            if DrawConectLine then
            begin
              Canvas.MoveTo(cfRct.Left + 6, cfRct.Top);
              Canvas.LineTo(cfRct.Left + 6, cfRct.Bottom);
            end
            else
            begin
              Canvas.MoveTo(cfRct.Left + 6, cfRct.Top);
              Canvas.LineTo(cfRct.Left + 6, cfRct.Top + nt);
            end;

            if Tlp.LastChild then
            begin
              Canvas.MoveTo(cfRct.Left + 6, cfRct.Bottom);
              Canvas.LineTo(cfRct.Left + 10, cfRct.Bottom);
              Dec(PrentCount);
            end;
            DoDrwLine := True;
          end;

          if Tlp.HasChildren then
          begin
            if not Tlp.Expanded then
            begin
              // draw [+]
              Canvas.Brush.Color := BkColor;
              if not FCodeFolding.ExpandGlyph.Empty then
              begin
                Canvas.Pen.Color:= BkColor;
                Canvas.Rectangle(cfRct.Left + 2, cfRct.Top + nt, cfRct.Left + 11, cfRct.Top + 9 + nt);
                if FCodeFolding.ExpandGlyph.Width > (cfRct.Right - cfRct.Left) then
                begin
                  GlpRct := Rect(cfRct.Left, cfRct.Top + nt, cfRct.Right, cfRct.Top + 9 + nt);
                  Canvas.StretchDraw(GlpRct, FCodeFolding.ExpandGlyph);
                end
                else
                  Canvas.Draw(cfRct.Left + 2, cfRct.Top + nt, FCodeFolding.ExpandGlyph);
              end
              else
              begin
                Canvas.Rectangle(cfRct.Left + 2, cfRct.Top + nt, cfRct.Left + 11, cfRct.Top + 9 + nt);

                Canvas.MoveTo(cfRct.Left + 4, cfRct.Top + 4 + nt);
                Canvas.LineTo(cfRct.Left + 9, cfRct.Top + 4 + nt);

                Canvas.MoveTo(cfRct.Left + 6, cfRct.Top + 2 + nt);
                Canvas.LineTo(cfRct.Left + 6, cfRct.Top + 7 + nt);
              end;

              DoDrwLine := False;
              DrawLine(Canvas, ln, LineStyle, dmScreen, pRect, i);
              // skip Lines
              Inc(ln);
              P := 1;
              C := 0;
              while  ln < InternalLines.Count do
              begin

                Tlp := InternalLines.GetLineProp(ln);
                if Assigned(Tlp) and (Tlp is TLineProp) then
                begin
                  //if Tlp.HasParent then
                  if Tlp.LastChild then
                  begin
                    Inc(C, Tlp.LastChildOfParents);
                    if P <= C then
                      Break;
                  end;
                  if Tlp.HasChildren then
                  begin
                    Inc(P);
                  end;
                end;
                Inc(ln);
              end;
              //---
            end
            else
            begin
              if Tlp.HasParent then
              begin
                Canvas.MoveTo(cfRct.Left + 6, cfRct.Top);
                Canvas.LineTo(cfRct.Left + 6, cfRct.Bottom);
              end
              else
              begin
                Canvas.MoveTo(cfRct.Left + 6, cfRct.Top + nt);
                Canvas.LineTo(cfRct.Left + 6, cfRct.Bottom);
              end;

              Canvas.Brush.Color := BkColor;
              if not FCodeFolding.CollapsedGlyph.Empty then
              begin
                Canvas.Pen.Color:= BkColor;
                Canvas.Rectangle(cfRct.Left + 2, cfRct.Top + nt, cfRct.Left + 11, cfRct.Top + 9 + nt);
                Inc(PrentCount);
                DoDrwLine := True;

                if FCodeFolding.CollapsedGlyph.Width > (cfRct.Right - cfRct.Left) then
                begin
                  GlpRct := Rect(cfRct.Left, cfRct.Top + nt, cfRct.Right, cfRct.Top + 9 + nt);
                  Canvas.StretchDraw(GlpRct, FCodeFolding.CollapsedGlyph);
                end
                else
                  Canvas.Draw(cfRct.Left + 2, cfRct.Top + nt, FCodeFolding.CollapsedGlyph);
              end
              else
              begin
                Canvas.Rectangle(cfRct.Left + 2, cfRct.Top + nt, cfRct.Left + 11, cfRct.Top + 9 + nt);
                Inc(PrentCount);
                DoDrwLine := True;
                // draw [-]
                Canvas.MoveTo(cfRct.Left + 4, cfRct.Top + 4 + nt);
                Canvas.LineTo(cfRct.Left + 9, cfRct.Top + 4 + nt);
              end;
            end;
          end;

          if DoDrwLine then
            DrawLine(Canvas, ln, LineStyle, dmScreen, pRect, i);
        end
        else

        begin
          if (PrentCount > 0) then
          begin
            Canvas.MoveTo(cfRct.Left + 6, cfRct.Top);
            Canvas.LineTo(cfRct.Left + 6, cfRct.Bottom);
          end;
          DrawLine(Canvas, ln, LineStyle, dmScreen, pRect, i);
        end;
      end
      else
        DrawLine(Canvas, i, LineStyle, dmScreen, pRect);

      ll := i;
      Inc(ln);
      Inc(i);
    end;

    if brk then
    begin
      eRect := EditorRect;
      if InternalLines.Count = 0 then
        eRect.Top := CellRect(0, ll - FTopLine).Top
      else
        eRect.Top := CellRect(0, ll - FTopLine).Bottom;

      Canvas.Brush.color := FbkColor;
      Canvas.Pen.Color := FBkColor;
      FillRect(eRect);
    end;

    eRect := EditorRect;

    DrawMargin;

    if (FRightMargin > 0) and (FShowRightMargin) then
    begin
      dw := Canvas.TextWidth('w') * (FRightMargin - LeftCol);
      Canvas.Pen.Color := FRightMarginColor;
      Canvas.Pen.Width := 2;
      Canvas.MoveTo(eRect.Left + dw, eRect.Top);
      Canvas.LineTo(eRect.Left + dw, eRect.Bottom);
      Canvas.Pen.Color := clGray;
      Canvas.Pen.Width := 1;
    end;

{$IFDEF FREEWARE}
    OldFont := TFont.Create;
    OldFont.Assign(Canvas.Font);
    Canvas.Font.Name := 'Verdana';
    Canvas.Font.Size := 8;
    Canvas.Font.Color := clSilver;
    Canvas.Brush.Style := bsClear;
    Canvas.TextOut(eRect.Left, eRect.Bottom - 14, 'copyright � 2009 tmssoftware.com');
    Canvas.Font.Assign(OldFont);
    OldFont.Free;
{$ENDIF}

    if BorderStyle <> bsNone then
    begin
      if Ctl3D then
        Border(Canvas, Rect(-10, -10, Width, Height), btLowered)
      else
      begin
        Pen.Color := FBorderColor;
        Pen.Width := 1;
        MoveTo(0, Height);
        LineTo(0, 0);
        LineTo(Width -1, 0);
        LineTo(Width -1, Height - 1);
        LineTo(0, Height - 1);
      end;
    end;

  end;

//  inherited;

{$IFDEF TMSDEBUG}
  outputdebugstring(pchar(inttostr(gettickcount - t) + ':paint'));
{$ENDIF}
end;

//--------------------------------------------------------------
//        GET VISIBLE
//--------------------------------------------------------------

function TAdvCustomMemo.GetVisible(Index: integer): integer;
var
  Coord: TFullPos;
  Cell: TCellPos;
  eRect: TRect;
begin
  eRect := EditorRect;

  Coord := CharFromPos(eRect.Right - 1, eRect.Bottom - 1);
  Cell := CellFromPos(eRect.Right - 1, eRect.Bottom - 1);
  case Index of
    0: Result := Cell.X;
    1: Result := Cell.Y;
    2: Result := Coord.Pos - 1;
    3: Result := Coord.LineNo - 1;
  else
    Result := 0;
  end;
end;

//--------------------------------------------------------------
//        MAKE VISIBLE
//--------------------------------------------------------------

procedure TAdvCustomMemo.MakeVisible;
var
  Modified: boolean;
begin
  Modified := False;
  if CurX < FLeftCol then
  begin
    FLeftCol := CurX - 2;
    if FLeftCol < 0 then FLeftCol := 0;
    Modified := True;
  end;

  if CurX > LastVisiblePos then
  begin
    if (FScrollBars in [ssBoth, ssHorizontal]) or
      (ScrollMode = smAuto) then
    begin
      FLeftCol := FLeftCol + CurX - LastVisiblePos + 2;
      if FLeftCol < 0 then
        FLeftCol := 0;
    end
    else
      CurX := LastVisiblePos;
    Modified := True;
  end;

  if CurY < FTopLine then
  begin
    FTopLine := CurY;
    if FTopLine < 0 then
      FTopLine := 0;
    Modified := True;
{$IFDEF TMSDEBUG}
    outputdebugstring(pchar('makevisible1:' + inttostr(ftopline)));
{$ENDIF}
  end;

  if CurY > LastVisibleLine then
  begin
    if (FScrollBars in [ssBoth, ssVertical]) or
      (ScrollMode = smAuto) then
    begin
      FTopLine := FTopLine + CurY - LastVisibleLine;
    end
    else
      CurY := LastVisibleLine;

    Modified := True;
{$IFDEF TMSDEBUG}
    outputdebugstring(pchar('makevisible2:' + inttostr(ftopline)));
{$ENDIF}
  end;
  if Modified then
    Invalidate;
end;

//--------------------------------------------------------------
//        RESIZE EDITOR
//--------------------------------------------------------------

procedure TAdvCustomMemo.ResizeEditor;
var
  otl ,lib: Integer;

  tp, x, y: Integer;
begin
  if (csCreating in ControlState) then
    Exit;
    
  otl := TopLine;

  TextFromPos(CurX, CurY, tp);

  lib := Lines.Count;
  UpdateWrap;

  PosFromText(tp, x, y);

  SetCursor(x, y);

  if WordWrap = wwNone then
    ResizeScrollBars(False);
  ResizeGutter;
  MakeVisible;
  if (lib = Lines.Count) or (WordWrap = wwNone) then
    FTopLine := otl;

{$IFDEF TMSDEBUG}
  outputdebugstring(pchar('resize editor:' + inttostr(ftopline)));
{$ENDIF}
  Invalidate;
end;

//--------------------------------------------------------------
//        RESIZE SCROLLBARS
//--------------------------------------------------------------

procedure TAdvCustomMemo.ResizeScrollBars(DoRepaint: Boolean);
var
  eRect, sbRect: TRect;
  MaxLen, OldMax: integer;
  V, H: Boolean;
  InternalLinesCount: Integer;

begin
  if not (FScrollBars in [ssBoth, ssVertical]) then
    sbVert.Visible := False;

  if not (FScrollBars in [ssBoth, ssHorizontal]) or (WordWrap <> wwNone) then
    sbHorz.Visible := False;

  if not FLetRefresh then
    Exit;

  V := sbVert.Visible;
  H := sbHorz.Visible;
  eRect := EditorRect;

{$IFDEF TMSDEBUG}
  outputdebugstring('scroll update');
{$ENDIF}

  if FScrollBars in [ssBoth, ssVertical] then
  begin
    with sbVert do
    begin
      Width := 16;
      Height := eRect.Bottom - eRect.Top + 1;
      Left := eRect.Right;
{$IFDEF TMSDEBUG}
      outputdebugstring(pchar(inttostr(visiblelinecount) + ':' + inttostr(internallines.Count) + ':' + inttostr(FTopLine)));
{$ENDIF}
      if CodeFolding.Enabled then
        InternalLinesCount := LineIndexToVisIndex(InternalLines.Count-1)
      else
        InternalLinesCount := InternalLines.Count;

      if (VisibleLineCount > 0) and
        ({InternalLines.Count}InternalLinesCount > VisibleLineCount) then
      begin
        oldmax := max;
        {position := FTopLine;
        if oldmax <> InternalLines.Count then
          sbVert.Max := InternalLines.Count; }
        position := LineIndexToVisIndex(FTopLine);
        if oldmax <> InternalLines.Count then
          sbVert.Max := LineIndexToVisIndex(InternalLines.Count-1);
{$IFNDEF TMSCLX}
        sbVert.PageSize := VisibleLineCount;// + 1;  // kh:
        sbVert.Width := GetSystemMetrics(SM_CXVSCROLL);
{$ENDIF}
        sbVert.Visible := true;
        sbRect := sbVert.ClientRect;
{$IFNDEF TMSDOTNET}
{$IFNDEF TMSCLX}
        InvalidateRect(Handle, @sbRect, True);
{$ENDIF}
{$ENDIF}

{$IFDEF TMSDOTNET}
        InvalidateRect(Handle, sbRect, True);
{$ENDIF}
      end
      else
      begin
{$IFDEF TMSDEBUG}
        outputdebugstring(pchar('hide vert scroll'));
{$ENDIF}
{$IFNDEF TMSCLX}
        sbVert.PageSize := -1;
{$ENDIF}
        FTopLine := 0;
        sbVert.visible := False;
      end;
    end;
  end;

  if (FScrollBars in [ssBoth, ssHorizontal]) and (WordWrap = wwNone) then
  begin
    MaxLen := MaxLength;
    with sbHorz do
    begin
      if FScrollBars = ssBoth then
        Width := Width - sbVert.Width;
      Height := 16;
      Left := 2;
      Top := eRect.Bottom;
      if (VisiblePosCount > 0) and
        (MaxLen > VisiblePosCount) then
      begin
        oldmax := sbHorz.max;
        if oldmax <> MaxLen then
          sbHorz.max := MaxLen;
{$IFNDEF TMSCLX}
        sbHorz.PageSize := VisiblePosCount + 1;
        sbHorz.Height := GetSystemMetrics(SM_CYHSCROLL);
{$ENDIF}
        Position := FLeftCol;
        sbHorz.Visible := true;
        sbRect := sbHorz.ClientRect;
{$IFNDEF TMSDOTNET}
{$IFNDEF TMSCLX}
        InvalidateRect(Handle, @sbRect, True);
{$ENDIF}
{$ENDIF}

{$IFDEF TMSDOTNET}
        InvalidateRect(Handle, sbRect, True);
{$ENDIF}
      end
      else
      begin
        if curx < VisiblePosCount then
        begin
          sbHorz.Visible := False;
{$IFNDEF TMSCLX}
          sbHorz.PageSize := -1;
{$ENDIF}
        end;
        FLeftCol := 0;
      end;
    end;
  end;

  if (sbVert.Visible <> V) or (sbHorz.Visible <> h) then
    ResizeScrollBars(DoRepaint);

  if DoRepaint then
  begin
    FGutter.Invalidate;
    eRect := EditorRect;
{$IFNDEF TMSDOTNET}
    InvalidateRect(Handle, @eRect, True);
{$ENDIF}

{$IFDEF TMSDOTNET}
    InvalidateRect(Handle, eRect, True);
{$ENDIF}
  end;

  if FScrollBars in [ssBoth, ssVertical] then
    ScrollVChange(nil);
  if FScrollBars in [ssBoth, ssHorizontal] then
    ScrollHChange(nil);

end;

//--------------------------------------------------------------
//        RESIZE GUTTER
//--------------------------------------------------------------

procedure TAdvCustomMemo.ResizeGutter;
var
  eRect: TRect;
begin
  eRect := EditorRect;
  with FGutter do
  begin
    Height := eRect.Bottom - eRect.Top;
  end;
end;

procedure TAdvCustomMemo.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FInternalStyles) then
  begin
    FInternalStyles := nil;
    inherited;
    Invalidate;
    Exit;
  end;
  if (Operation = opRemove) and (AComponent = FMemoSource) then
  begin
    SetMemoSource(nil);
    Invalidate;
  end;
  if (Operation = opRemove) and (AComponent = FMemoChecker) then
    FMemoChecker := nil;
  inherited;
end;

//--------------------------------------------------------------
//        CREATE PARAMS
//--------------------------------------------------------------
{$IFNDEF TMSCLX}

procedure TAdvCustomMemo.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := Params.Style or WS_CLIPCHILDREN;
end;
{$ENDIF}

//--------------------------------------------------------------
//        UNDO, REDO
//--------------------------------------------------------------

procedure TAdvCustomMemo.Undo;
begin
  InternalUndoList.Undo;
end;

procedure TAdvCustomMemo.Redo;
begin
  InternalUndoList.Redo;
  Refresh;
end;

procedure TAdvCustomMemo.AddUndoStep(AUndoStep: TUndo);
begin
  InternalUndoList.Add(AUndoStep);
end;

//--------------------------------------------------------------
//        SET UNDO LIMIT
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetUndoLimit(Value: integer);
begin
  if (FUndoLimit <> Value) then
  begin
    if Value <= 0 then Value := 1;
    if Value > 100 then Value := 100;
    FUndoLimit := Value;
    FUndoList.Limit := Value;
  end;
end;

//--------------------------------------------------------------
//        UNDO (REDO) CHANGE
//--------------------------------------------------------------

procedure TAdvCustomMemo.UndoChange;
begin
  if Assigned(FOnUndoChange) then
    FOnUndoChange(Self, InternalUndoList.Pos < InternalUndoList.Count,
      InternalUndoList.Pos > 0);
end;

//--------------------------------------------------------------
//        CAN UNDO
//--------------------------------------------------------------

function TAdvCustomMemo.CanUndo: boolean;
begin
  Result := (InternalUndoList.FPos < InternalUndoList.Count);
end;

//--------------------------------------------------------------
//        CAN REDO
//--------------------------------------------------------------

function TAdvCustomMemo.CanRedo: boolean;
begin
  Result := InternalUndoList.FPos > 0;
end;

//--------------------------------------------------------------
//        CLEAR UNDO LIST
//--------------------------------------------------------------

procedure TAdvCustomMemo.ClearUndoList;
begin
  InternalUndoList.Clear;
end;

//--------------------------------------------------------------
//        SET SCROLL BARS
//--------------------------------------------------------------

procedure TAdvCustomMemo.SetScrollBars(Value: TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    ResizeEditor;
    Invalidate;
  end;
end;

//--------------------------------------------------------------
//        CREATE
//--------------------------------------------------------------

constructor TAdvCustomMemo.Create(AOwner: TComponent);
var
  i: Integer;
{$IFDEF TMSDOTNET}
  BaseAssembly: System.Reflection.Assembly;
{$ENDIF}

begin
  inherited;
  ControlStyle := [csCaptureMouse, csClickEvents,
    csDoubleClicks, csReplicatable];

  FletShowAutocompletion := true;
  FOwner := AOwner;
  FletgetCaretTime := true;
  FClearType := true;
  FCaretX := 0;
  FCarety := 0;
  FBlockShow := True;
  FWantTab := True;
  FBlockLineColor := clNone;
  FBlockColor := clAqua;
  FBorderColor := clGray;
  FAutoHintParameterDelay := 2500;
  FBackupTopLine := -1;
  FRightMargin := 80;
  FRightMarginColor := $00E2E2E2;
  FUrlAware := True;
  FUrlStyle := TCharStyle.Create;
  FUrlStyle.FTextColor := clBlue;
  FUrlStyle.FBkColor := clWhite;
  FUrlStyle.FStyle := [fsUnderline];
  FUrlDelimiters := #32#34#39#44;
  FLetRefresh := True;
  FTrimTrailingSpaces := False;
  FShowRightMargin := True;
  FUseStyler := True;
  FSmartTabs := False;
  FEnhancedHomeKey := False;
  Width := 100;
  Height := 40;
  TabStop := True;
  Cursor := crIBeam;
  FBorderStyle := bsSingle;
  FCtl3D := False;
  FActiveLine := -1;
  FBreakpointColor := clRed;
  FBreakpointTextColor := clWhite;
  FCaseSensitive := False;
  FFont := TFont.Create;
  FFont.Name := 'Courier New';
  FFont.Size := 10;
  FFont.OnChange := FontChangedProc;
  Canvas.Font.Assign(FFont);
  FHintShowing := False;
  FHiddenCaret := False;
  FCaretVisible := False;
  html := TStringList.Create;
  FCurX := 0;
  FCurY := 0;
  FLeftCol := 0;
  FTopLine := 0;
  FTabSize := 4;
  FMargin := 2;
  FAutoIndent := True;
  FAutoExpand := True;
  FHideSelection := True;
  FLines := TAdvMemoStrings.Create;
  FLines.Add(''); // Please leave the add here, before assigning OnChange
  FLines.OnChange := LinesChanged;
  FLines.Memo := Self;
  FPrintOptions := TPrintOptions.Create;
  FAutoCorrect := TAutoCorrect.Create;
  FAutoCompletion := TAutoCompletion.Create(Self);
  FMarkerList := TAdvMarkerList.Create(Self);
  FStylerList := TAdvStylerList.Create(Self);
  FBookmarkBmp := TBitmap.Create;
{$IFNDEF TMSDOTNET}
  FBookmarkBmp.LoadFromResourceName(HInstance, 'TMS_FLAG');
{$ENDIF}

{$IFDEF TMSDOTNET}
  BaseAssembly := Assembly.GetExecutingAssembly;
  //FMarker.MarkerBmp.LoadFromResourceName('TMS_FLAG', ResourceBaseName, BaseAssembly);
  FBookmarkBmp.LoadFromResourceName('TMS_FLAG', ResourceBaseName, BaseAssembly);
{$ENDIF}

  FWWList := TIntList.Create;

  FBookmarkList := TIntList.Create;
  for i := 1 to 10 do
    FBookmarkList.Add(-1);

  FScrollBars := ssBoth;
  sbVert := TScrollBar.Create(Self);
  with sbVert do
  begin
    Parent := Self;
    Visible := False;
    Kind := sbVertical;
    Align := alRight;
    Top := 0;
    Width := 16;
    TabStop := False;
    SmallChange := 1;
{$IFNDEF TMSCLX}
    DoubleBuffered := not IsVista;
    pagesize := -1;
{$ENDIF}
    ControlStyle := ControlStyle + [csNoDesignVisible];
    OnScroll := ScrollBarScroll;
    OnChange := ScrollVChange;
    Enabled := True;
  end;

  sbHorz := TScrollBar.Create(Self);
  with sbHorz do
  begin
    Kind := sbHorizontal;
    Align := alBottom;
    Visible := False;
    Parent := self;
    Height := 16;
    TabStop := False;
{$IFNDEF TMSCLX}
    DoubleBuffered := not IsVista;
    pagesize := -1;
{$ENDIF}
    ControlStyle := ControlStyle + [csNoDesignVisible];
    OnScroll := ScrollBarScroll;
    OnChange := ScrollHChange;
  end;

  FActiveLineSettings := TAdvActiveLineSettings.Create(self);

  FGutter := TAdvGutter.Create(Self);
  with FGutter do
  begin
    FLeft := 1;
    FTop := 1;
    FWidth := 45;
    FHeight := 0;
    FColor := clBtnFace;
    FColorTo := clWhite;
    Memo := Self;
  end;

  FSelStartX := 0;
  FSelStartY := 0;
  FSelEndX := 0;
  FSelEndY := 0;

  FBkColor := clWhite;
  FSelColor := clWhite;
  FSelBkColor := clNavy;

  FSelCharPos.LineNo := -1;
  FSelCharPos.Pos := -1;

  FLineBitmap := TBitmap.Create;

  FLeftButtonDown := False;
  FScrollMode := smAuto;

  FUndoList := TAdvUndoList.Create;
  FUndoList.Memo := Self;

  FUndoLimit := 100;
  FSearching := False;
{$IFDEF DELPHI4_LVL}
  FormAutocompletion := TAdvAutoform.CreateNew(self, 0);
{$ELSE}
  FormAutocompletion := TAdvAutoform.CreateNew(self);
{$ENDIF}
  FormAutocompletion.Name := '_fa';
{$IFNDEF TMSCLX}
  FormAutocompletion.BorderStyle := bsSizeToolWin;
{$ENDIF}
  FormAutocompletion.FormStyle := fsStayOnTop;
  FormAutocompletion.Visible := False;
  FormAutocompletion.Caption := '';
  FormAutocompletion.OnClose := FormClose;

  Flistcompletion := TAutoCompletionListBox.Create(FormAutocompletion);
  Flistcompletion.Name := '_lc';
  Flistcompletion.Parent := FormAutocompletion;
  Flistcompletion.Align := alClient;
  Flistcompletion.Cursor := crArrow;
{$IFNDEF TMSCLX}
  FListcompletion.Ctl3D := False;
{$ENDIF}
  FListcompletion.BorderStyle := bsNone;
  FListcompletion.Style := lbOwnerDrawFixed;

{$IFDEF DELPHI4_LVL}
  FHintForm := TAdvHintform.CreateNew(self, 0);
{$ELSE}
  FHintForm := TAdvHintform.CreateNew(self);
{$ENDIF}

  FHintForm.Name := '_hf';
{$IFNDEF TMSCLX}
  FHintForm.BorderStyle := bsnone;
{$ENDIF}
  FHintForm.FormStyle := fsStayOnTop;
  FHintForm.Visible := False;
  FHintForm.OnClose := FormHintClose;

  FHintForm.OnMouseDown := FormHintMouseDown;

  Timer := TTimer.Create(nil);
  Timer.OnTimer := TimerHint;
  Timer.Interval := FAutoHintParameterDelay;
  Timer.Enabled := False;
  FAutoHintParameters := hpAuto;

  BSSelLine := -1;
  BSSelStart := -1;
  BSSelLen := -1;

  BESelLine := -1;
  BESelStart := -1;
  BESelLen := -1;

  FAutoCompleteTimer := TTimer.Create(nil);
  FAutoCompleteTimer.Enabled := False;
  FAutoCompleteTimer.OnTimer := AutoCompleteTimer;
  FAutoCompleteTimer.Interval := 500; //expose as property
  FAutoCompleteDot := False;
  FAutoCompleteList := TStringList.Create;

  FScrollHintWindow := THintWindow.Create(Self);

{$IFDEF TMSCLX}
  FCaretBmp := TBitmap.Create;
{$ENDIF}

  //if csDesigning in ComponentState then
  SearchForStylers;
  FRTFEngine := nil;

  FCodeFoldingNodeCount := 0;
  FCodeFolding := TCodeFolding.Create;
  FCodeFolding.OnChange := OnCodeFoldingChange;
end;

procedure TAdvCustomMemo.SetAutoThemeAdapt(const value: boolean);
begin
  FAutoThemeAdapt := Value;
  if value then
    ThemeAdapt;
end;

procedure TAdvCustomMemo.OnCodeFoldingChange(Sender: TObject; ChangeMsg: Integer);
begin
  if (ChangeMsg = 2) then
  begin
    ShowCaret(true);
    AutoCodeFold;
  end;
  Invalidate;
end;

procedure TAdvCustomMemo.SetCodeFolding(Value: TCodeFolding);
begin
  FCodeFolding.Assign(Value);
end;

function TAdvCustomMemo.IsCommentedNode(LineIndex: Integer): Boolean;
var
  RgnIndex: Integer;
  Coments: String;
begin
  Result := GetNodeComments(LineIndex, RgnIndex, Coments);
end;

function TAdvCustomMemo.GetNodeComments(LineIndex: Integer; var RgnIndex: Integer; var Coments: String): Boolean;
var
  S, PartS, sp: String;
  ToSt, PartLen, ToEn, rgn: Integer;
begin
  Result := False;

  if CodeFolding.Enabled and (LineIndex >= 0) and (LineIndex < InternalLines.Count) and IsNode(LineIndex) then
  begin
    ToSt := 1;
    S := InternalLines[LineIndex];
    PartLen := Length(S);
    sp := '';
    while (ToSt <= PartLen) and (S[ToSt] = #32) do
    begin
      sp := sp + ' ';
      Inc(ToSt);
    end;

    ToSt := 1;
    S := Trim(S);
    PartLen := Length(S);
    ToEn := ToSt;
    while (ToEn <= PartLen) and (S[ToEn] <> #32) and (not ( (S[ToEn] = ';') or (S[ToEn] = ':')))
      and (S[ToEn] <> InternalStyles.FMultiCommentRight) do
      Inc(ToEn);

    PartS := Trim(Copy(S, ToSt, ToEn));

    for rgn := 0 to FInternalStyles.RegionDefinitions.Count - 1 do
    begin
      if (UpperCase(PartS) = UpperCase(FInternalStyles.RegionDefinitions.Items[rgn].Identifier))
        or (UpperCase(PartS) = UpperCase(FInternalStyles.RegionDefinitions.Items[rgn].RegionStart))
        or (UpperCase(PartS) = UpperCase(FInternalStyles.RegionDefinitions.Items[rgn].RegionEnd)) then
      begin
        if FInternalStyles.RegionDefinitions.Items[rgn].ShowComments then
        begin
          Result := True;
          RgnIndex := rgn;
          ToSt := ToEn;
          PartLen := Length(S);
          ToEn := ToSt;
          while (ToEn <= PartLen) and (S[ToEn] <> InternalStyles.FMultiCommentRight) do
            Inc(ToEn);

          PartS := sp + '['+Trim(Copy(S, ToSt, ToEn - ToSt))+']';
          Coments := PartS;
        end;
        Break;
      end;
    end;
  end
end;

procedure TAdvCustomMemo.AutoCodeFold;
var
  i, k, r, RSCount, j: Integer;
  KL, ClosedRL, OpenRL, FileRL, OldRgn: TStringList;
  s: String;
  RecentIdf: array[0..1, 0..2] of Integer;
  RgnFound, MultiLineComent: Boolean;
  Tlp: TLineProp;
  Tempdelimiters: string;

  procedure ParseString(s: String; var SL: TStringList);
  var
    toStart, toEnd, Len, Lc, Mc, Rc, l: Integer;
    part: String;
    RgnFound: Boolean;
  begin
    if MultiLineComent then
    begin
      Rc := AnsiPos(InternalStyles.FMultiCommentRight, s);
      if (Rc > 0) then
      begin
        MultiLineComent := False;
        Delete(s, 1, Rc);
      end
      else
        Exit;
    end
    else
    begin
      Mc := AnsiPos(InternalStyles.FMultiCommentLeft, s);
      Lc := AnsiPos(InternalStyles.LineComment, s);
      if (Mc > 0) and (Lc > 0) then
      begin
        if (Mc < Lc) then
        begin
          Rc := AnsiPos(InternalStyles.FMultiCommentRight, s);
          if (Rc > 0) then
          begin
            Delete(s, Mc, Rc - Mc);
            Lc := AnsiPos(InternalStyles.LineComment, s);
            if (Lc > 0) then
              Delete(s, Lc, Length(s) - Lc);
          end
          else
          begin
            MultiLineComent := True;
            Delete(s, Mc, Length(s) - Mc);
          end;
        end
        else
        begin
          Delete(s, Lc, Length(s) - Lc);
        end;
      end
      else
      if (Mc > 0) then
      begin
        Rc := AnsiPos(InternalStyles.FMultiCommentRight, s);
        if (Rc > 0) then
        begin
          // Checking for Identifier/RegionStart/RegionEnd in whole comments ie: {$region}
          //part := Trim(Copy(S, Mc, Rc - Mc+1));
          RgnFound := False;
          toStart := 1;
          Len := Length(S);
          toEnd := toStart;
          while (toend <= Len) and (S[toend] <> #32) and (not ( (s[toend] = ';') or (s[toend] = ':')))
            and (s[toend] <> InternalStyles.FMultiCommentRight) do
            Inc(toend);

          part := Trim(Copy(S, toStart, toEnd{ - toStart}));

          for l := 0 to FInternalStyles.RegionDefinitions.Count - 1 do
          begin
            if (UpperCase(part) = UpperCase(FInternalStyles.RegionDefinitions.Items[l].Identifier))
              or (UpperCase(part) = UpperCase(FInternalStyles.RegionDefinitions.Items[l].RegionStart))
              or (UpperCase(part) = UpperCase(FInternalStyles.RegionDefinitions.Items[l].RegionEnd)) then
            begin
              SL.Add(part);
              RgnFound := True;
              Break;
            end;
          end;

          if not RgnFound and (toEnd <= Len) then
          begin
            Delete(part, Length(part), 1);

            if (part <> ';') and (part <> ':') and (Trim(part) <> '') then
            begin
              for l := 0 to FInternalStyles.RegionDefinitions.Count - 1 do
              begin
                if (UpperCase(part) = UpperCase(FInternalStyles.RegionDefinitions.Items[l].Identifier))
                  or (UpperCase(part) = UpperCase(FInternalStyles.RegionDefinitions.Items[l].RegionStart))
                  or (UpperCase(part) = UpperCase(FInternalStyles.RegionDefinitions.Items[l].RegionEnd)) then
                begin
                  SL.Add(part);
                  Break;
                end;
              end;
            end;
          end;

          Delete(s, Mc, Rc - Mc + 1);
        end
        else
        begin
          MultiLineComent := True;
          Delete(s, Mc, Length(s) - Mc);
        end;
      end
      else if (Lc > 0) then
      begin
        Delete(s, Lc, Length(s) - Lc);
      end
    end;

    while (Length(s) > 0) do
    begin
      toStart := 1;
      Len := Length(s);
      toEnd := toStart + 1;
      while (toend <= Len) and (S[toend] <> #32) and (not ( (s[toend] = ';') or (s[toend] = ':')))
        and (AnsiPos(S[toend], Tempdelimiters) = 0) and (not ( (s[toStart] = ';') or (s[toStart] = ':')))
        and (AnsiPos(S[toStart], Tempdelimiters) = 0) do
        Inc(toend);

      part := Copy(S, toStart, toEnd - toStart);
      if (part <> ';') and (part <> ':') and (Trim(part) <> ''){and not (part in FTempdelimiters)} then
        SL.Add(Trim(part));
      Delete(s, toStart, toEnd - tostart);
      if (Length(s) > 0) and ( (s[1] = ';') or (s[1] = ':')) then
        Delete(s, 1, 1);
      //toStart := toEnd+1;
    end;

  end;

begin
  if FCodeFolding.Enabled and Assigned(FInternalStyles) and UseStyler and (FInternalStyles.RegionDefinitions.Count > 0) then
  begin

    KL := TStringList.Create;
    ClosedRL := TStringList.Create;
    //ClosedRL.Sorted := False;
    OpenRL := TStringList.Create;
    //OpenRL.Sorted := False;
    FileRL := TStringList.Create;
    //FileRL.Sorted := False;
    OldRgn := TStringList.Create;
    //SEL.Sorted := False;

    // Saving expanded State
    for i := 0 to InternalLines.Count - 1 do
    begin
      Tlp := InternalLines.GetLineProp(i);
      if Assigned(Tlp) and (Tlp is TLineProp) and (Tlp.HasChildren) then
        if Tlp.Expanded then
          OldRgn.Values[IntToStr(i)] := '1'
        else
          OldRgn.Values[IntToStr(i)] := '0';
    end;

    // Remove all Old CodeFolding
    RemoveAllCodeFolding;

    RSCount := 0;
    // Ln No:              // Regiong Idx         // Mark
    RecentIdf[0, 0] := -1; RecentIdf[0, 1] := -1; RecentIdf[0, 2] := -1;
    RecentIdf[1, 0] := -1; RecentIdf[1, 1] := -1; RecentIdf[1, 2] := -1;
    MultiLineComent := False;

    Tempdelimiters := '';//FTempdelimiters;
    for i := 0 to InternalStyles.FAllStyles.Count - 1 do
    begin
      if InternalStyles.FAllStyles.Items[i].FStyleType <> stSymbol then
        Continue;
      Tempdelimiters := Tempdelimiters + InternalStyles.FAllStyles.Items[i].FSymbols;
    end;

    if (AnsiPos('{', Tempdelimiters) = 0) then Tempdelimiters := Tempdelimiters + '{';
    if (AnsiPos('}', Tempdelimiters) = 0) then Tempdelimiters := Tempdelimiters + '}';

    for i := 0 to InternalLines.Count - 1 do
    begin
      S := UpperCase(Trim(InternalLines[i]));
      KL.Clear;
      ParseString(S, KL);
      for k := 0 to KL.Count-1 do
      begin
        for r := 0 to FInternalStyles.RegionDefinitions.Count - 1 do
        begin
          if UpperCase(KL[k]) = UpperCase(FInternalStyles.RegionDefinitions.Items[r].Identifier) then
          begin
            case FInternalStyles.RegionDefinitions.Items[r].RegionType of
              rtClosed, rtIgnore:
              begin
                if (UpperCase(FInternalStyles.RegionDefinitions.Items[r].Identifier) = UpperCase(FInternalStyles.RegionDefinitions.Items[r].RegionStart)) then
                begin
                  // Add in List
                  ClosedRL.Values[IntToStr(i)] := IntToStr(r);
                end
                else
                begin
                  if (RecentIdf[0, 0] = -1) then
                  begin
                    RecentIdf[0, 0] := i;
                    RecentIdf[0, 1] := r;
                  end
                  else
                  begin
                    if (RecentIdf[1, 0] > -1) then
                    begin
                      RecentIdf[0, 0] := RecentIdf[1, 0];
                      RecentIdf[0, 1] := RecentIdf[1, 1];
                    end;
                    RecentIdf[1, 0] := i;
                    RecentIdf[1, 1] := r;
                  end;
                end;

                Break;
              end;
              rtOpen:
              begin
                //IdfLn := -1;
                //RIdx := -1;
                // Close previous open region
                if (OpenRL.Count > 0) and (i > 0) then
                begin
                  {$IFNDEF TMSDOTNET}
                  OpenRL.Objects[OpenRL.Count-1] := Pointer(StrToInt(OpenRL.Values[OpenRL.Names[OpenRL.Count-1]]));
                  {$ENDIF}
                  {$IFDEF TMSDOTNET}
                  OpenRL.Objects[OpenRL.Count-1] := TObject(StrToInt(OpenRL.Values[OpenRL.Names[OpenRL.Count-1]]));
                  {$ENDIF}
                  OpenRL.Values[OpenRL.Names[OpenRL.Count-1]] := IntToStr(i-1);
                end;
                // add new open region
                OpenRL.Values[IntToStr(i)] := IntToStr(r);
              end;
              rtFile:
              begin
                //IdfLn := -1;
                //RIdx := -1;
                FileRL.Values[IntToStr(i)] := IntToStr(r);
              end;
            end;
          end
          else     //----- Checking Region start
          if Uppercase(KL[k]) = UpperCase(FInternalStyles.RegionDefinitions.Items[r].RegionStart) then
          begin
            case FInternalStyles.RegionDefinitions.Items[r].RegionType of
              rtClosed, rtIgnore:
              begin
                if (RSCount = 0) and (RecentIdf[1, 0] >= 0) and (RecentIdf[1, 1] >= 0) and (RecentIdf[1, 2] = -1) then
                begin
                  ClosedRL.Values[IntToStr(RecentIdf[1, 0])] := IntToStr(RecentIdf[1, 1]);
                  RecentIdf[1, 2] := 1;
                end
                else if (RSCount = 0) and (RecentIdf[0, 0] >= 0) and (RecentIdf[0, 1] >= 0) and (RecentIdf[1, 2] = -1) then
                begin
                  ClosedRL.Values[IntToStr(RecentIdf[0, 0])] := IntToStr(RecentIdf[0, 1]);
                  RecentIdf[0, 0] := -1; RecentIdf[0, 1] := -1; RecentIdf[0, 2] := -1;
                  RecentIdf[1, 0] := -1; RecentIdf[1, 1] := -1; RecentIdf[1, 2] := -1;
                end
                else
                begin
                  Inc(RSCount);
                end;

                Break;
              end;
              rtOpen:
              begin
                //IdfLn := -1;
                //RIdx := -1;
                // search for previous open region and close it

                // add new open region
                //OpenRL.Values[IntToStr(i)] := IntToStr(r);
              end;
              rtFile:
              begin
                //IdfLn := -1;
                //RIdx := -1;
                //FileRL.Values[IntToStr(i)] := IntToStr(r);
              end;
            end;
          end
         else     //----- Checking Region End
          if Uppercase(KL[k]) = UpperCase(FInternalStyles.RegionDefinitions.Items[r].RegionEnd) then
          begin
            case FInternalStyles.RegionDefinitions.Items[r].RegionType of
              rtClosed, rtIgnore:
              begin
                if (RSCount = 0) then
                begin
                  RgnFound := False;
                  for j:= ClosedRL.Count-1 downto 0 do
                  begin
                    if (ClosedRL.Objects[j] = nil) then
                    begin
                      if KL[k] = UpperCase(FInternalStyles.RegionDefinitions.Items[StrToInt(ClosedRL.Values[ClosedRL.Names[j]])].RegionEnd) then
                      begin
                        RgnFound := True;
                        {$IFNDEF TMSDOTNET}
                        ClosedRL.Objects[j] := Pointer(StrToInt(ClosedRL.Values[ClosedRL.Names[j]]) + 1);
                        {$ENDIF}
                        {$IFDEF TMSDOTNET}
                        ClosedRL.Objects[j] := TObject(StrToInt(ClosedRL.Values[ClosedRL.Names[j]]) + 1);
                        {$ENDIF}

                        ClosedRL.Values[ClosedRL.Names[j]] := IntToStr(i);

                        if (StrToInt(ClosedRL.Names[j]) = RecentIdf[1, 0]) and (RecentIdf[1, 2] = 1) then
                        begin
                          RecentIdf[1, 0] := -1; RecentIdf[1, 1] := -1; RecentIdf[1, 2] := -1;
                        end;  

                        // remove RecentIdf if endregion found having RecentIdf inside that ie: for Class

                        Break; 
                      end;
                    end;
                  end;

                  if not RgnFound then
                  begin
                    RecentIdf[0, 0] := -1; RecentIdf[0, 1] := -1; RecentIdf[0, 2] := -1;
                    RecentIdf[1, 0] := -1; RecentIdf[1, 1] := -1; RecentIdf[1, 2] := -1;
                  end;
                  
                end
                else if (RSCount > 0) then
                  Dec(RSCount)
                else
                  RSCount := 0;
                Break;
              end;
              rtOpen:
              begin
              end;
              rtFile:
              begin
              end;
            end;
          end;

          //if {() and} (IdfLn >= 0) and (IdfLn < i) then
          begin
            //IdfLn := -1;
            //RIdx := -1;
          end;

        end;
      end;

    end;  // end Lines For

    for i := 0 to ClosedRL.Count - 1 do
    begin
      if (ClosedRL.Objects[i] <> nil) and (InternalStyles.RegionDefinitions.Items[Integer(ClosedRL.Objects[i])-1].RegionType <> rtIgnore) then
      begin
        j := StrToInt(ClosedRL.Names[i]);
        k := StrToInt(ClosedRL.Values[ClosedRL.Names[i]]);
        if (j >= 0) and (j < InternalLines.Count) and (k >= 0) and (k < InternalLines.Count) and (j < k) then
          AddCodeFolding(j, k);
      end;
    end;

    for i := 0 to OpenRL.Count - 1 do
    begin
      if (OpenRL.Objects[i] = nil) then
      begin
        {$IFNDEF TMSDOTNET}
        OpenRL.Objects[i] := Pointer(StrToInt(OpenRL.Values[OpenRL.Names[i]]));
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        OpenRL.Objects[i] := TObject(StrToInt(OpenRL.Values[OpenRL.Names[i]]));
        {$ENDIF}
        OpenRL.Values[OpenRL.Names[i]] := IntToStr(InternalLines.Count-1);
      end;
      j := StrToInt(OpenRL.Names[i]);
      k := StrToInt(OpenRL.Values[OpenRL.Names[i]]);
      if (j >= 0) and (j < InternalLines.Count) and (k >= 0) and (k < InternalLines.Count) and (j < k) then
        AddCodeFolding(j, k);
    end;

    for i := 0 to FileRL.Count - 1 do
    begin
      {$IFNDEF TMSDOTNET}
      FileRL.Objects[i] := Pointer(StrToInt(FileRL.Values[FileRL.Names[i]]));
      {$ENDIF}
      {$IFDEF TMSDOTNET}
      FileRL.Objects[i] := TObject(StrToInt(FileRL.Values[FileRL.Names[i]]));
      {$ENDIF}
      FileRL.Values[FileRL.Names[i]] := IntToStr(InternalLines.Count - 1);

      j := StrToInt(FileRL.Names[i]);
      k := StrToInt(FileRL.Values[FileRL.Names[i]]);

      if (j >= 0) and (j < InternalLines.Count) and (k >= 0) and (k < InternalLines.Count) and (j < k) then
        AddCodeFolding(j, k);
    end;

    // Restoring Old Expanded State
    for i := 0 to OldRgn.Count - 1 do
    begin
      j := StrToInt(OldRgn.Names[i]);
      k := StrToInt(OldRgn.Values[OldRgn.names[i]]);
      if (j >= 0) and (j < InternalLines.Count) then
      begin
        Tlp := InternalLines.GetLineProp(j);
        if Assigned(Tlp) and (Tlp is TLineProp) and (Tlp.HasChildren) then
          Tlp.Expanded := Boolean(k);
      end;
    end;

    KL.Free;
    ClosedRL.Free;
    OpenRL.Free;
    FileRL.Free;
    OldRgn.Free;
  end;
end;

function TAdvCustomMemo.VisIndexToLineIndex(Index: Integer): Integer;
var
  i, ln, P, C: Integer;
  Tlp: TLineProp;
begin
  Result := Index;
  if FCodeFolding.Enabled then
  begin
    i := 0;
    ln := 0;
    while  i < InternalLines.Count do
    begin
      if InternalLines.Count <= i then
      begin
        //brk := true;
        Break;
      end;

      if (Index = i) then
      begin
        Result := ln;
        Break;
      end;

      Tlp := InternalLines.GetLineProp(ln);
      if Assigned(Tlp) and (Tlp is TLineProp) then
      begin
        if Tlp.HasChildren then
        begin
          if not Tlp.Expanded then
          begin
            // skip Lines
            Inc(ln);
            P := 1;
            C := 0;
            while  ln < InternalLines.Count do
            begin
              if InternalLines.Count <= ln then
              begin
                //brk := true;
                Break;
              end;
              Tlp := InternalLines.GetLineProp(ln);
              if Assigned(Tlp) and (Tlp is TLineProp) then
              begin
                //if Tlp.HasParent then
                if Tlp.LastChild then
                begin
                  Inc(C, Tlp.LastChildOfParents);
                  if P <= C then   // p = c
                    Break;
                end;
                if Tlp.HasChildren then
                begin
                  Inc(P);
                end;
              end;
              Inc(ln);
            end;
            //---
          end;
        end;
      end;

      Inc(ln);
      Inc(I);
    end;
  end;
end;

function TAdvCustomMemo.LineIndexToVisIndex(Index: Integer): Integer;
var
  i, ln, P, C: Integer;
  Tlp: TLineProp;
begin
  Result := Index;
  if FCodeFolding.Enabled then
  begin
    i := 0;
    ln := 0;
    while  i < InternalLines.Count do
    begin
      if InternalLines.Count <= i then
      begin
        //brk := true;
        Break;
      end;

      if (Index = ln) then
      begin
        Result := i;
        Break;
      end;

      Tlp := InternalLines.GetLineProp(ln);
      if Assigned(Tlp) and (Tlp is TLineProp) then
      begin
        if Tlp.HasChildren then
        begin
          if not Tlp.Expanded then
          begin
            // skip Lines
            Inc(ln);
            P := 1;
            C := 0;
            while  ln < InternalLines.Count do
            begin
              if InternalLines.Count <= ln then
              begin
                //brk := true;
                Break;
              end;
              
              if (Index = ln) then
              begin
                Result := i;
                Break;
              end;

              Tlp := InternalLines.GetLineProp(ln);
              if Assigned(Tlp) and (Tlp is TLineProp) then
              begin
                //if Tlp.HasParent then
                if Tlp.LastChild then
                begin
                  Inc(C, Tlp.LastChildOfParents);
                  if P <= C then
                    Break;
                end;
                if Tlp.HasChildren then
                begin
                  Inc(P);
                end;
              end;
              Inc(ln);
            end;
            //---
          end;
        end;
      end;

      Inc(ln);
      Inc(I);
    end;
  end;
end;

function TAdvCustomMemo.GetExpandNode(Index: Integer): Boolean;
var
  Tlp: TlineProp;
begin
  Tlp := InternalLines.GetLineProp(Index);
  if Assigned(Tlp) and (Tlp is TLineProp) then
    Result := Tlp.Expanded
  else
    Result := True;
end;

procedure TAdvCustomMemo.SetExpandNode(Index: Integer; const Value: Boolean);
var
  Tlp: TlineProp;
  OldCurX: Integer;
begin
  Tlp := InternalLines.GetLineProp(Index);
  if Assigned(Tlp) and (Tlp is TLineProp) and FCodeFolding.Enabled then
  begin
    if IsNode(Index) and (Tlp.Expanded <> Value) then
    begin
      Tlp.Expanded := Value;
      ResizeScrollBars(True);
      Invalidate;
      // Adjust CurY
      OldCurX := CurX;
      MoveCursor(1, 0, []);
      if OldCurX < CurX then
      begin
        MoveCursor(-1, 0, []);

        if AutoExpand and (CurY < InternalLines.Count) and (CurY >= 0) then
          InternalLines[CurY] := TrimRightWW(CurY);
      end;  

      if FCaretVisible then
        ShowCaret(True);
    end;
  end;
end;

function TAdvCustomMemo.LastChildOfParent(ParentIndex: Integer): Integer;
var
  i, P, C: Integer;
  Tlp, TlpP: TLineProp;
begin
  Result := -1;
  if (ParentIndex < 0) then
    Exit;

  Tlp := nil;
  TlpP := InternalLines.GetLineProp(ParentIndex);
  if Assigned(TlpP) and (TlpP is TLineProp) and (TlpP.HasChildren) then
  begin
    i := ParentIndex + 1;
    P := 1;
    C := 0;
    while  (i < InternalLines.Count) do
    begin
      Tlp := InternalLines.GetLineProp(i);
      if Assigned(Tlp) and (Tlp is TLineProp) then
      begin
        if Tlp.LastChild then
        begin
          Inc(C, Tlp.LastChildOfParents);
          if P <= C then
            Break;
        end;
        if Tlp.HasChildren then
          Inc(P);
      end;
      Inc(i);
    end;

    if (P <= C) and Assigned(Tlp) and (Tlp is TLineProp) then
      Result := i;
  end;
end;

procedure TAdvCustomMemo.ExpandParents(ChildIndex: Integer);
var
  Tlp, TlpC: TlineProp;
  i, P, C: Integer;

begin
  if (ChildIndex >= InternalLines.Count) then
    Exit;

  TlpC := InternalLines.GetLineProp(ChildIndex);
  if Assigned(TlpC) and (TlpC is TLineProp) then
  begin
    if (TlpC.HasParent) then
    begin

      i := ChildIndex;
      Dec(i);
      P := 0;
      C := 1;
      while  i >= 0 do
      begin
        Tlp := InternalLines.GetLineProp(i);
        if Assigned(Tlp) and (Tlp is TLineProp) then
        begin
          if Tlp.HasChildren then
          begin
            Inc(P);
            if C <= P then
            begin
              ExpandNode[i] := True;
              if not Tlp.HasParent then
                Break;
            end;
          end;

          if Tlp.LastChild then
            Inc(C, Tlp.LastChildOfParents);
        end;
        Dec(i);
      end;
    end;
  end;
end;

function TAdvCustomMemo.AddCodeFolding(StartLineIndex, EndLineIndex: Integer): Boolean;
var
  Tlp, TlpSt, TlpEd: TlineProp;
  I: Integer;
begin
  Result := False;
  if {FCodeFolding.Enabled and }(StartLineIndex >= 0) and (StartLineIndex < InternalLines.Count) and (not IsNode(StartLineIndex))
     and (EndLineIndex >= 0) and (EndLineIndex < InternalLines.Count) and (EndLineIndex > StartLineIndex) then
  begin
    TlpSt := InternalLines.GetLineProp(StartLineIndex);
    if (TlpSt = nil) then
    begin
      InternalLines.OnChange := nil;
      TlpSt := InternalLines.CreateProp(StartLineIndex);
      InternalLines.SetLineProp(StartLineIndex, TlpSt);
      InternalLines.OnChange := LinesChanged;
    end;
    TlpEd := InternalLines.GetLineProp(EndLineIndex);
    if (TlpEd = nil) then
    begin
      InternalLines.OnChange := nil;
      TlpEd := InternalLines.CreateProp(EndLineIndex);
      InternalLines.SetLineProp(EndLineIndex, TlpEd);
      InternalLines.OnChange := LinesChanged;
    end;

    if {not (TlpEd.LastChild) and} (TlpSt is TLineProp) and (TlpEd is TLineProp)then
    begin
      Inc(FCodeFoldingNodeCount);
      TlpSt.HasChildren := True;
      TlpEd.HasParent := True;
      //TlpEd.LastChild := True;
      TlpEd.LastChildOfParents := TlpEd.LastChildOfParents + 1;
      
      InternalLines.OnChange := nil;
      for I:= StartLineIndex + 1 to EndLineIndex-1 do
      begin
        Tlp := InternalLines.GetLineProp(I);
        if Assigned(Tlp) and (Tlp is TLineProp) then
          Tlp.HasParent := True
        else
        begin
          Tlp := InternalLines.CreateProp(I);
          Tlp.HasParent := True;
          InternalLines.SetLineProp(I, Tlp);
        end;
      end;
      InternalLines.OnChange := LinesChanged;
    end;
    ResizeScrollBars(True);
    Invalidate;
  end;
end;

procedure TAdvCustomMemo.RemoveCodeFoldingFromChild(EndLineIndex: Integer);
var
  i, P, C: Integer;
  Tlp, TlpC: TLineProp;
  DelP: Boolean;
begin
  if (EndLineIndex >= InternalLines.Count) then
    Exit;

  Tlp := nil;
  TlpC := InternalLines.GetLineProp(EndLineIndex);
  if Assigned(TlpC) and (TlpC is TLineProp) and (TlpC.HasParent) then
  begin
    DelP := True;
    if (EndLineIndex+1 < InternalLines.Count) then
    begin
      Tlp := InternalLines.GetLineProp(EndLineIndex+1);
      if Assigned(Tlp) and (Tlp is TLineProp) then
        DelP := not Tlp.HasParent;
    end;

    i := EndLineIndex;
    Dec(i);
    P := 0;
    C := 1;
    while  i >= 0 do
    begin
      Tlp := InternalLines.GetLineProp(i);
      if Assigned(Tlp) and (Tlp is TLineProp) then
      begin
        if Tlp.HasChildren then
        begin
          Inc(P);
          if C = P then
            Break;
        end;

        if Tlp.LastChild then
        begin
          Inc(C, Tlp.LastChildOfParents);
        end;

        if DelP and (C-1 = P) then
          Tlp.HasParent := False;
      end;
      Dec(i);
    end;

    if (C = P) and Assigned(Tlp) and (Tlp is TLineProp) then
    begin
      //TlpC.LastChild := False;
      Dec(FCodeFoldingNodeCount);

      TlpC.LastChildOfParents := TlpC.LastChildOfParents - 1;
      TlpC.HasParent := not DelP;
      Tlp.HasChildren := False;
    end;
  end;
  Invalidate;
end;

procedure TAdvCustomMemo.RemoveCodeFolding(StartLineIndex: Integer);
var
  i, P, C: Integer;
  Tlp, TlpP: TLineProp;
begin
  if (StartLineIndex < 0) then
    Exit;
    
  Tlp := nil;
  TlpP := InternalLines.GetLineProp(StartLineIndex);
  if Assigned(TlpP) and (TlpP is TLineProp) and (TlpP.HasChildren) then
  begin
    i := StartLineIndex;
    Inc(i);
    P := 1;
    C := 0;
    while  i < InternalLines.Count do
    begin
      Tlp := InternalLines.GetLineProp(i);
      if Assigned(Tlp) and (Tlp is TLineProp) then
      begin
        if not TlpP.HasParent and (P-1 = C) then
          Tlp.HasParent := False;
        if Tlp.LastChild then
        begin
          Inc(C, Tlp.LastChildOfParents);
          if P <= C then
            Break;
        end;
        if Tlp.HasChildren then
        begin
          Inc(P);
        end;
      end;
      Inc(i);
    end;

    if (P = C) and Assigned(Tlp) and (Tlp is TLineProp) then
    begin
      //Tlp.LastChild := False;
      Dec(FCodeFoldingNodeCount);

      Tlp.LastChildOfParents := Tlp.LastChildOfParents - 1;
      TlpP.HasChildren := False;
    end;
  end;
end;

procedure TAdvCustomMemo.RemoveAllCodeFolding;
var
  i: Integer;
  Tlp: TLineProp;
begin
  FCodeFoldingNodeCount := 0;
  for i:= 0 to InternalLines.Count-1 do
  begin
    Tlp := InternalLines.GetLineProp(i);
    if Assigned(Tlp) and (Tlp is TLineProp) then
    begin
      Tlp.Expanded := True;
      //Tlp.LastChild := False;
      Tlp.LastChildOfParents := 0;
      Tlp.HasParent := False;
      Tlp.HasChildren := False;
    end;
  end;
  Invalidate;
end;

function TAdvCustomMemo.IsNode(LineIndex: Integer): Boolean;
var
  Tlp: TlineProp;
begin
  Result := False;
  Tlp := InternalLines.GetLineProp(LineIndex);
  if Assigned(Tlp) and (Tlp is TLineProp) then
    Result := Tlp.HasChildren;
end;

procedure TAdvCustomMemo.ExpandAllNodes;
var
  I: Integer;
begin
  if not FCodeFolding.Enabled then
    Exit;

  for I:= 0 to InternalLines.Count-1 do
  begin
    if IsNode(I) then
    begin
      ExpandNode[I] := True;
    end;
  end;
end;

procedure TAdvCustomMemo.CollapseAllNodes;
var
  I: Integer;
begin
  if not FCodeFolding.Enabled then
    Exit;
    
  for I:= 0 to InternalLines.Count-1 do
  begin
    if IsNode(I) then
    begin
      ExpandNode[I] := False;
    end;
  end;
end;

procedure TAdvCustomMemo.ToggleNode(LineIndex: Integer);
//var
  //Tlp: TlineProp;
begin
  ExpandNode[LineIndex] := not ExpandNode[LineIndex];
  {Tlp := InternalLines.GetLineProp(LineIndex);
  if Assigned(Tlp) and (Tlp is TLineProp) and IsNode(LineIndex) and FCodeFolding.Enabled then
  begin
    Tlp.Expanded := not Tlp.Expanded;
    ResizeScrollBars(True);
    Invalidate;
  end; }
end;

function TAdvCustomMemo.GetCursorEx: TCursor;
begin
  Result := inherited Cursor;
end;

procedure TAdvCustomMemo.SetCursorEx(const Value: TCursor);
begin
  inherited Cursor := Value;
  FoldCursor := Value;
end;

function TAdvCustomMemo.WordAtXY(X, Y: Integer): string;
var
  i: integer;
  s: string;
  fe, fb: integer;
begin
  Result := '';

  if Y >= InternalLines.Count then
    Exit;

  s := InternalLines.Strings[Y];

  if (X > Length(s)) then
    Exit;

  fe := X;
  fb := X + 1;

  for i := X + 1 to Length(s) do
    if not IsWordBoundary(s[i]) then
      fe := i
    else
      Break;

  for i := X downto 1 do
    if not IsWordBoundary(s[i]) then
      fb := i
    else
      Break;

  Result := Copy(s, fb, fe - fb + 1);
end;

function TAdvCustomMemo.FullWordAtXY(X, Y: Integer): string;
var
  i: integer;
  s: string;
  fe, fb: integer;
begin
  Result := '';

  if (Y >= InternalLines.Count) or (Y < 0) then
    Exit;

  s := InternalLines.Strings[Y];

  if (X > Length(s)) then
    Exit;

  fe := X;
  fb := X + 1;

  for i := X + 1 to Length(s) do
//    if not (s[i] in [#32,#39,'"',')','(']) then
    if s[i] <> #32 then
    
      fe := i
    else
      Break;

  for i := X downto 1 do
//    if not (s[i] in [#32,#39,'"','(',')']) then
    if s[i] <> #32 then
      fb := i
    else
      Break;

  Result := Copy(s, fb, fe - fb + 1);
end;


function TAdvCustomMemo.TokenAtXY(X, Y: Integer): string;
var
  i: integer;
  s: string;
  fe, fb: integer;
begin
  Result := '';

  if (Y >= InternalLines.Count) or (Y < 0) then
    Exit;

  s := InternalLines.Strings[Y];

  if (X > Length(s)) then
    Exit;

  fe := X;
  fb := X + 1;

  for i := X + 1 to Length(s) do
    if (i > 0) and not IsTokenBoundary(s[i]) then
      fe := i
    else
      Break;

  for i := X downto 1 do
    if not IsTokenBoundary(s[i]) then
      fb := i
    else
      Break;

  Result := Copy(s, fb, fe - fb + 1);
end;


function TAdvCustomMemo.WordAtCursor: string;
var
  p: integer;
begin
  Result := WordAtCursorPos(p);
end;

function CheckSeparator(ch: char): boolean;
begin
  {$IFNDEF DELPHI_UNICODE}
  Result := ch in [#32,#39,'"','(',')'];
  {$ENDIF}
  {$IFDEF DELPHI_UNICODE}
  Result := (ch = #32) or (ch = #39) or (ch = '"') or (ch ='(') or (ch = ')');
  {$ENDIF}
end;

function TAdvCustomMemo.FullWordAtCursor: string;
var
  s: string;
  i: integer;
  fb, fe: integer;
begin
  Result := '';

  if InternalLines.Count = 0 then
    Exit
  else
    if InternalLines.Count <= CurY then
      CurY := InternalLines.Count - 1;

  s := InternalLines.Strings[CurY];

  if (CurX > Length(s)) then
    Exit;

  fe := CurX;
  fb := CurX + 1;

  for i := CurX + 1 to Length(s) do
    if not (CheckSeparator(s[i])) then
//    if (s[i] <> #32) and (s[i] <> ')') and (s[i] <> '(') then
      fe := i
    else
      Break;

  for i := CurX downto 1 do
    if not (CheckSeparator(s[i])) then
//    if (s[i] <> #32) and (s[i] <> ')') and (s[i] <> '(') then
      fb := i
    else
      Break;

  Result := Copy(s, fb, fe - fb + 1);
end;


function TAdvCustomMemo.WordAtCursorPos(var Pos: Integer): string;
var
  s: string;
  i: integer;
  fb, fe: integer;
begin
  Result := '';

  if InternalLines.Count = 0 then
    Exit
  else
    if InternalLines.Count <= CurY then
      CurY := InternalLines.Count - 1;

  s := InternalLines.Strings[CurY];

  if (CurX > Length(s)) then
    Exit;

  fe := CurX;
  fb := CurX + 1;

  for i := CurX + 1 to Length(s) do
    if not IsWordBoundary(s[i]) then
      fe := i
    else
      Break;

  for i := CurX downto 1 do
    if not IsWordBoundary(s[i]) then
      fb := i
    else
      Break;
  Pos := fb;
  Result := Copy(s, fb, fe - fb + 1);
end;

function TAdvCustomMemo.WordTillCursor: string;
var
  s: string;
  i: integer;
  fb, fe: integer;
begin
  Result := '';

  if InternalLines.Count = 0 then
    Exit
  else
    if InternalLines.Count <= CurY then
      CurY := InternalLines.Count - 1;

  s := InternalLines.Strings[CurY];

  if (CurX > Length(s)) then
    Exit;

  fe := CurX;
  fb := CurX + 1;

  for i := CurX downto 1 do
    if not IsTokenBoundary(s[i]) then
      fb := i
    else
      Break;

  Result := Copy(s, fb, fe - fb + 1);
end;

function TAdvCustomMemo.IsWordBoundary(ch: char): boolean;
begin
  {$IFNDEF DELPHI_UNICODE}
  Result := (ch in [#32,#39,'"']);
  {$ENDIF}
  {$IFDEF DELPHI_UNICODE}
  Result := (ch = #32) or (ch = #39) or (ch = '"');
  {$ENDIF}
end;

function TAdvCustomMemo.IsTokenBoundary(ch: char): boolean;
begin
  {$IFNDEF DELPHI_UNICODE}
  Result := ch in [#32, '(', ')', '[', ']', ',', '.', ':', ';', '"', '''', '='];
  {$ENDIF}
  {$IFDEF DELPHI_UNICODE}
  Result := (ch = #32) or (ch = '(') or (ch = ')') or (ch = '[') or (ch = ']') or (ch = ',') or (ch = '.')
    or (ch = ':') or (ch = ';') or (ch = '"') or (ch = '''') or (ch = '=');
  {$ENDIF}
end;

procedure TAdvCustomMemo.LineRefresh;
var
  r: TRect;
begin
  r := ClientRect;
{$IFNDEF TMSDOTNET}
  InvalidateRect(Handle, @r, False);
{$ENDIF}

{$IFDEF TMSDOTNET}
  InvalidateRect(Handle, r, False);
{$ENDIF}
end;

procedure TAdvCustomMemo.LinesChanged(Sender: TObject);
var
  r: TRect;
  i: integer;
begin
  if FLetRefresh then
  begin
    Change;

    SetMaxLength;
    ResizeScrollBars(False);
    MakeVisible;

    r := ClientRect;
{$IFNDEF TMSDOTNET}
    InvalidateRect(Handle, @r, False);
{$ENDIF}

{$IFDEF TMSDOTNET}
    InvalidateRect(Handle, r, False);
{$ENDIF}

    for i := 0 to FBookMarkList.Count - 1 do
    begin
      if FBookmarkList.Items[i] >= Lines.Count then
        FBookmarkList.Items[i] := -1;
    end;
  end;
end;

//--------------------------------------------------------------
//        DESTROY
//--------------------------------------------------------------

destructor TAdvCustomMemo.Destroy;
begin
  FPrintOptions.Free;
  html.Free;
  FLines.OnChange := nil;
  FWWList.Free;
  FFont.Free;
  FLines.Free;
  FGutter.Free;
  FActiveLineSettings.Free;
  sbVert.Free;
  sbHorz.Free;
  FurlStyle.Free;
  FLineBitmap.Free;
  FUndoList.Clear;
  FUndoList.Capacity := 0;
  FUndoList.Free;
  Flistcompletion.Free;
  FormAutocompletion.Free;
  Timer.Enabled := False;
  Timer.Free;
  FHintForm.Free;
  FAutoCorrect.Free;
  FAutoCompletion.Free;
  FBookmarkBmp.Free;
  FBookmarkList.Free;
  FAutoCompleteTimer.Free;
  FAutoCompleteList.Free;
  FMarkerList.Free;
  FStylerList.Free;
  FScrollHintWindow.Free;
{$IFDEF TMSCLX}
  FCaretBmp.Free;
{$ENDIF}
  FCodeFolding.Free;
  inherited Destroy;
end;

function TAdvCustomMemo.EditCanModify: Boolean;
begin
  Result := True;
end;

{$IFDEF TMSCLX}

function GetRValue(Color: TColor): integer;
var
  CR: TColorRecord;
begin
  CR := TColorRecord(ColorToRGB(Color));
  Result := CR.RedValue;
end;

function GetGValue(Color: TColor): integer;
var
  CR: TColorRecord;
begin
  CR := TColorRecord(ColorToRGB(Color));
  Result := CR.GreenValue;
end;

function GetBValue(Color: TColor): integer;
var
  CR: TColorRecord;
begin
  CR := TColorRecord(ColorToRGB(Color));
  Result := CR.BlueValue;
end;
{$ENDIF}

function HTMLClr(color: TColor): string;
begin
  Result := '#' + inttohex(GetRValue(color), 2) +
    inttohex(GetGValue(color), 2) +
    inttohex(GetBValue(color), 2);
end;

function TAdvCustomMemo.NumberOfPages(ACanvas: TCanvas; PageWidth, PageHeight: Integer): Integer;
var
  cRect: TRect;
  th, lpp: Integer;
begin
  ACanvas.Font.Assign(Font);

//  cRect := ACanvas.ClipRect;

  cRect := Rect(0, 0, PageWidth, PageHeight);

  cRect.Left := cRect.Left + PrintOptions.MarginLeft;
  cRect.Right := cRect.Right - PrintOptions.MarginRight;
  cRect.Top := cRect.Top + PrintOptions.MarginTop;
  cRect.Bottom := cRect.Bottom - PrintOptions.MarginBottom;

  th := ACanvas.TextHeight('W_') + 3;

  if PrintOptions.PageNr then
    cRect.Bottom := cRect.Bottom - th;

  if PrintOptions.Title <> '' then
    cRect.Top := cRect.Top + th;

  lpp := (cRect.Bottom - cRect.Top) div th;

  if Assigned(FMemoSource) then
    Result := 1 + ((FMemoSource.Lines.Count - 1) div lpp)
  else
    Result := 1 + ((Lines.Count - 1) div lpp);
end;

procedure TAdvCustomMemo.PrintToCanvas(ACanvas: TCanvas; PageWidth, PageHeight, PageNr: Integer);
var
  hstl: TStyle;
  i: Integer;
  pRect: TRect;
  cRect: TRect;
  th: Integer;
  lpp, sl, el, tt: Integer;

  procedure PrintCentered(PCanvas: TCanvas; s: string; r: TRect);
  var
    tw: Integer;
  begin
    PCanvas.Font.Assign(Font);
    tw := PCanvas.TextWidth(s);
    if tw < r.Right - r.Left then
      r.Left := r.Left + ((r.Right - r.Left) - tw) div 2;
    PCanvas.TextOut(r.Left, r.Top, s);
  end;

begin
  ACanvas.Font.Assign(Font);

//  ACanvas.Font.Size := 10;
//  cRect := ACanvas.ClipRect;

  cRect := Rect(0, 0, PageWidth, PageHeight);
  cRect.Left := cRect.Left + PrintOptions.MarginLeft;
  cRect.Right := cRect.Right - PrintOptions.MarginRight;
  cRect.Top := cRect.Top + PrintOptions.MarginTop;
  cRect.Bottom := cRect.Bottom - PrintOptions.MarginBottom;

  th := ACanvas.TextHeight('W_') + 3;
  tt := 0;

  if PrintOptions.PageNr then
    cRect.Bottom := cRect.Bottom - th;

  pRect := Rect(cRect.Left, cRect.Top, cRect.Right, cRect.Top + th);

  if PrintOptions.Title <> '' then
  begin
    PrintCentered(ACanvas, PrintOptions.Title, pRect);
    OffsetRect(pRect, 0, th);
    tt := th;
  end;

  if PrintOptions.PageNr then
    tt := tt + th;

  lpp := (cRect.Bottom - cRect.Top - tt) div th;

  sl := 1 + ((PageNr - 1) * lpp);

  el := sl + (lpp - 1);
  if el > InternalLines.Count then
    el := InternalLines.Count;

  if sl > InternalLines.Count then
    Exit;

  hstl := GetUpStyle(sl - 1);

  for i := sl to el do
  begin
    DrawLine(ACanvas, i - 1, hstl, dmPrinter, pRect);
    OffsetRect(pRect, 0, th);
  end;

  if PrintOptions.PageNr then
  begin
    pRect := Rect(cRect.Left, cRect.Bottom, cRect.Right, cRect.Bottom + th);
    PrintCentered(ACanvas, PrintOptions.PagePrefix + ' ' + IntToStr(PageNr), pRect);
  end;

end;

procedure TAdvCustomMemo.PrintPages(FromPage, ToPage : integer);
var
  lp1, np : integer;
begin
  if (FromPage < 1) or (ToPage < 1) or (FromPage > ToPage) then
    Exit;

  with Printer do begin
    if PrintOptions.JobName <> '' then
      Title := PrintOptions.JobName
    else
      Title := 'AdvMemo print job';

    BeginDoc;
    np := NumberOfPages(Printer.Canvas, Printer.PageWidth, Printer.PageHeight);
    FromPage := Min(FromPage, np);
    ToPage := Min(ToPage, np);

    for lp1 := FromPage to ToPage do
    begin
      PrintToCanvas(Printer.Canvas, Printer.PageWidth, Printer.PageHeight, lp1);
      if (lp1 < ToPage) then
        NewPage;
    end;
    EndDoc;
  end;
end;

procedure TAdvCustomMemo.PrintSelection;
var
  tmpmemo: TAdvCustomMemo;
begin
  tmpmemo := TAdvCustomMemo.Create(self);
  tmpmemo.Parent := self;
  tmpmemo.Visible := false;
  tmpmemo.PrintOptions.Assign(self.PrintOptions);
  tmpmemo.SyntaxStyles := self.SyntaxStyles;
  tmpmemo.Lines.Clear;
  tmpmemo.Lines.Add(self.Selection);
  tmpmemo.Gutter.LineNumberStart := SelStartY;
  tmpmemo.Print;
  tmpmemo.Free;
end;

procedure TAdvCustomMemo.Print;
var
  i, np: Integer;

begin
  with Printer do
  begin
    if PrintOptions.JobName <> '' then
      Title := PrintOptions.JobName
    else
      Title := 'AdvMemo print job';

    BeginDoc;
    np := NumberOfPages(Printer.Canvas, Printer.PageWidth, Printer.PageHeight);

    for i := 1 to np do
    begin
      PrintToCanvas(Printer.Canvas, Printer.PageWidth, Printer.PageHeight, i);
      if i < np then
        NewPage;
    end;
    EndDoc;
  end;
end;


function TAdvCustomMemo.SaveToHTML(FileName: string;
  Fixedfonts: Boolean = True): Boolean;
begin
  Result := False;
  OutputHTML(FixedFonts);
  try
    html.SaveToFile(FileName);
    Result := True;
  except
    on Exception do ;
  end;
end;


{$IFNDEF TMSDOTNET}
function TAdvCustomMemo.SaveToRTFStream(AStream: TMemorystream;Fixedfonts: Boolean = True): boolean;
begin
  Result := false;
  FRTFEngine := TRTFEngine.Create;
  OutputRTF(FixedFonts);
  try
    AStream.Position := 0;
    FRTFEngine.SaveToStream(AStream);
    AStream.Position := 0;
    Result := True;
  except
    on Exception do;
  end;
  FRTFEngine.Free;
  FRTFEngine := nil;
end;
{$ENDIF}

function TAdvCustomMemo.SaveToRTF(FileName: string;
  Fixedfonts: Boolean = True): Boolean;
begin
  Result := False;
  FRTFEngine := TRTFEngine.Create;
  OutputRTF(FixedFonts);
  try
    FRTFEngine.SaveToFile(FileName);
    Result := True;
  except
    on Exception do ;
  end;
  FRTFEngine.Free;
  FRTFEngine := Nil;
end;

procedure MakeFragment(var HTML: string);
// Helper routine to build a properly-formatted HTML fragment.
const
  Version = 'Version:1.0'#13#10;
  StartHTML = 'StartHTML:';
  EndHTML = 'EndHTML:';
  StartFragment = 'StartFragment:';
  EndFragment = 'EndFragment:';
  DocType = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">';
  HTMLIntro = '<html><head><META http-equiv=Content-Type content="text/html; charset=utf-8">' +
    '</head><body><!--StartFragment-->';
  HTMLExtro = '<!--EndFragment--></body></html>';
  NumberLengthAndCR = 10;

  // Let the compiler determine the description length.
  DescriptionLength = Length(Version) + Length(StartHTML) + Length(EndHTML) + Length(StartFragment) +
    Length(EndFragment) + 4 * NumberLengthAndCR;

var
  Description: string;
  StartHTMLIndex,
    EndHTMLIndex,
    StartFragmentIndex,
    EndFragmentIndex: Integer;

begin
  // The HTML clipboard format is defined by using byte positions in the entire block where HTML text and
  // fragments start and end. These positions are written in a description. Unfortunately the positions depend on the
  // length of the description but the description may change with varying positions.
  // To solve this dilemma the offsets are converted into fixed length strings which makes it possible to know
  // the description length in advance.
  StartHTMLIndex := DescriptionLength; // position 0 after the description
  StartFragmentIndex := StartHTMLIndex + Length(DocType) + Length(HTMLIntro);
  EndFragmentIndex := StartFragmentIndex + Length(HTML);
  EndHTMLIndex := EndFragmentIndex + Length(HTMLExtro);

  Description := Version +
    SysUtils.Format('%s%.8d', [StartHTML, StartHTMLIndex]) + #13#10 +
    SysUtils.Format('%s%.8d', [EndHTML, EndHTMLIndex]) + #13#10 +
    SysUtils.Format('%s%.8d', [StartFragment, StartFragmentIndex]) + #13#10 +
    SysUtils.Format('%s%.8d', [EndFragment, EndFragmentIndex]) + #13#10;
  HTML := Description + DocType + HTMLIntro + HTML + HTMLExtro;
end;

procedure TAdvCustomMemo.SetUseStyler(const Value: boolean);
begin
  FUseStyler := Value;
  Invalidate;
end;

procedure TAdvCustomMemo.SetTrimTrailingSpaces(const Value: boolean);
begin
  FTrimTrailingSpaces := Value;
  Invalidate;
end;

procedure TAdvCustomMemo.SetShowRightMargin(const Value: boolean);
begin
  FShowRightMargin := Value;
  Invalidate;
end;

procedure TAdvCustomMemo.SetSmartTabs(const Value: boolean);
begin
  FSmartTabs := Value;
  Invalidate;
end;

procedure TAdvCustomMemo.SetAcceptFiles(const Value: Boolean);
begin
  FAcceptFiles := Value;
  DragAcceptFiles(Self.Handle,Value);
end;


procedure TAdvCustomMemo.SetEnhancedHomeKey(const Value: boolean);
begin
  FEnhancedHomeKey := Value;
  Invalidate;
end;

procedure TAdvCustomMemo.CopyHTMLToClipboard;
{$IFDEF TMSCLX}
begin
end;
{$ENDIF}
{$IFDEF TMSDOTNET}
begin
end;
{$ENDIF}
{$IFNDEF TMSCLX}
{$IFNDEF TMSDOTNET}
var
  Data: THandle;
  DataPtr: Pointer;
  CF_HTML: word;
  s: string;

begin

  GetUpStyle(0);

  if (Assigned(InternalStyles)) and (UseStyler) then
  begin
    FtmpNoStart := UpperCase(InternalStyles.FNumericChars + InternalStyles.FHexIdentifier);
    FtmpNo := UpperCase(InternalStyles.FNumericChars) + 'E';
    FtmpNoHex := Uppercase(InternalStyles.FHexIdentifier);
  end
  else
  begin
    FtmpNoStart := '';
    FtmpNo := '';
  end;

  OutputHTML(False);

  s := html.Text;
  MakeFragment(s);

  CF_HTML := RegisterClipboardFormat('HTML Format');

  Data := GlobalAlloc(GMEM_MOVEABLE, Length(s));
  try
    // Obtain a pointer to the first byte of the allocated memory
    DataPtr := GlobalLock(Data);
    try
      // Move the data in Rec to the memory block
      Move(s[1], DataPtr^, Length(s));

      Clipboard.Open;
      try
        ClipBoard.SetAsHandle(CF_HTML, Data);
        ClipBoard.AsText := html.Text;
      finally
        Clipboard.Close;
      end;
    finally
      // Unlock the globally allocated memory
      GlobalUnlock(Data);
    end;
  except
    // A call to GlobalFree is required only if an exception occurs.
    //  Otherwise, the clipboard takes over managing any allocated
    //  memory to it.
    GlobalFree(Data);
    raise;
  end;
end;
{$ENDIF}
{$ENDIF}

procedure TAdvCustomMemo.DoFind;
begin
  if Assigned(FonFind) then
    FOnFind(self);
end;

procedure TAdvCustomMemo.DoReplace;
begin
  if Assigned(FonReplace) then
    FOnReplace(self);
end;

procedure TAdvCustomMemo.OutputHTML(Fixedfonts: Boolean);
var
  i: Integer;
  hstl: TStyle;
  pRect: TRect;
begin
  InternalLines.OnChange := nil;
  BeginUpdate;

  if (WordWrap <> wwNone) then
    UndoWrap;

  html.Clear;
  {$IFDEF FREEWARE}
  html.Add('<!-- saved from TAdvMemo -->');
  {$ENDIF}
  html.Add('<HTML>');
  html.Add('<BODY bgColor=' + HTMLClr(FBkColor) + ' LINK=' + HTMLClr(UrlStyle.FTextColor) + ' VLINK=' + HTMLClr(UrlStyle.FTextColor) + ' ALINK=' + HTMLClr(UrlStyle.FTextColor) + '>');
  html.Add('<PRE>');

  if FixedFonts then
    html.Add('<FONT style="font-family:' + Font.Name + '; font-size:' + IntToStr(font.Size) + '">')
  else
    html.Add('<FONT style="font-family:' + Font.Name + ';">');

  hstl.isComment := False;
  hstl.isBracket := False;
  hstl.isnumber := False;
  hstl.iskeyWord := False;
  hstl.isdelimiter := False;
  hstl.isURL := False;
  hstl.EndBracket := #0;
  hstl.index := 0;
  htmlfont := '';

  for i := 0 to InternalLines.Count - 1 do
  begin
    html.Add('');
    DrawLine(Canvas, i, hstl, dmHTML, pRect);
  end;

  if htmlfont <> '' then
    html.Add('</FONT>');

  html.Add('</FONT>');
  html.Add('</PRE>');
  html.Add('</BODY>');
  html.Add('</HTML>');

  if (WordWrap <> wwNone) then
    DoWrap;

  InternalLines.OnChange := LinesChanged;

  EndUpdate;
end;

procedure TAdvCustomMemo.OutputRTF(FixedFonts: Boolean);
var
  i: Integer;
  hstl: TStyle;
  pRect: TRect;
begin
  if not Assigned(FRTFEngine) then
    Exit;

  if (WordWrap <> wwNone) then
    UndoWrap;

 { html.Clear;
  html.Add('<!-- saved from TAdvMemo -->');
  html.Add('<HTML>');
  html.Add('<BODY bgColor=' + HTMLClr(FBkColor) + ' LINK=' + HTMLClr(UrlStyle.FTextColor) + ' VLINK=' + HTMLClr(UrlStyle.FTextColor) + ' ALINK=' + HTMLClr(UrlStyle.FTextColor) + '>');
  html.Add('<PRE>');
}
  if FixedFonts then
  begin
    //html.Add('<FONT style="font-family:' + Font.Name + '; font-size:' + IntToStr(font.Size) + '">')
    FRTFEngine.AddFontName(Font.Name);
    FRTFEngine.AddFontSize(Font.Size*2);
    FRTFEngine.AddForeColor(Font.Color);
  end
  else
  begin
    //html.Add('<FONT style="font-family:' + Font.Name + ';">');
    FRTFEngine.AddFontName(Font.Name);
    FRTFEngine.AddFontSize(Font.Size*2);
    FRTFEngine.AddForeColor(Font.Color);
  end;

  hstl.isComment := False;
  hstl.isBracket := False;
  hstl.isnumber := False;
  hstl.iskeyWord := False;
  hstl.isdelimiter := False;
  hstl.isURL := False;
  hstl.EndBracket := #0;
  hstl.index := 0;
  htmlfont := '';

  for i := 0 to InternalLines.Count - 1 do
  begin
    //html.Add('');
    DrawLine(Canvas, i, hstl, dmRTF, pRect);
    FRTFEngine.AddNewLine;
  end;

  if (WordWrap <> wwNone) then
    DoWrap;
end;

procedure TAdvCustomMemo.ThemeAdapt;
var
  eTheme: XPColorScheme;
begin
  eTheme := CurrentXPTheme();
  case eTheme of
  xpNone:
    begin
      Gutter.FColorTo := clBtnFace;
      Gutter.FColor := clWhite;
    end;
  xpBlue:
    begin
      Gutter.FColorTo := $FCE1CB;
      Gutter.FColor := $E0A57D;
    end;
  xpGreen:
    begin
      Gutter.FColorTo := $CFF0EA;
      Gutter.FColor := $8CC0B1;
    end;
  xpGray:
    begin
      Gutter.FColorTo := $ECE2E1;
      Gutter.FColor := $B39698;
    end;
  end;
end;


procedure TAdvCustomMemo.DrawHTML(Part: string; var Drawstyle: Tstyle; lineno: integer);
var
  bc, c: Tcolor;
  sl: Tfontstyles;
  localhtmlfont, shtml: string;

  procedure loadfromitemstyle;
  begin
    with FLineBitmap.Canvas do
    begin
      try
        C := InternalStyles.FAllStyles.Items[DrawStyle.index].Font.Color;
        Sl := InternalStyles.FAllStyles.Items[DrawStyle.index].Font.Style;
        BC := InternalStyles.FAllStyles.Items[DrawStyle.index].FBGColor;
      except
        on Exception do
        begin
          C := Self.Font.Color;
          Sl := Self.Font.Style;
          BC := Self.BkColor;
        end;
      end;
    end;
  end;

  function tagstrl(stc: Tfontstyles): string;
  var
    rz: string;
  begin
    rz := '';
    if fsbold in stc then rz := rz + 'bold';
    if fsItalic in stc then
    begin
      if rz = '' then
        rz := rz + 'italic'
      else
        rz := rz + ',italic'
    end;
//    if rz <> '' then rz := 'font:'#39 + rz + #39';';
    if rz <> '' then rz := 'font:' + rz + ';';
    if fsUnderline in stc then
      rz := rz + 'text-decoration:'#39 + 'underline' + #39';';
    Result := rz;
  end;

begin
  if html.Count <= 0 then
    Exit;

  C := Self.Font.Color;
  Sl := Self.Font.Style;
  BC := Self.BkColor;

  begin
    if (DrawStyle.isComment) and (not DrawStyle.isURL) then
    begin
      C := InternalStyles.CommentStyle.FTextColor;
      SL := InternalStyles.CommentStyle.FStyle;
      if InternalStyles.CommentStyle.FBkColor <> clNone then
        BC := InternalStyles.CommentStyle.FBkColor
      else
        BC := self.BkColor;
    end
    else
    begin
      if (DrawStyle.isBracket) and (not DrawStyle.isURL) then
        loadfromitemstyle
      else
      begin
        if DrawStyle.isnumber then
        begin
          C := InternalStyles.FNumberStyle.FTextColor;
          SL := InternalStyles.FNumberStyle.Style;
          if InternalStyles.FNumberStyle.FBkColor <> clNone then
            BC := InternalStyles.FNumberStyle.FBkColor
          else
            BC := self.BkColor;
        end;
        if DrawStyle.isdelimiter then loadfromitemstyle;
        if DrawStyle.iskeyWord then loadfromitemstyle;
        if DrawStyle.isURL then
        begin
          C := FurlStyle.FTextColor;
          SL := FurlStyle.Style;
          if FurlStyle.FBkColor <> clNone then
            BC := FurlStyle.FBkColor
          else
            BC := self.BkColor;
        end;
      end;
    end;
  end;

  if part <> '' then
  begin
    // Needed only for HTTP comment rest of symbols solved by tag <PRE>
    part := StringReplace(part, '<', '&lt', [rfReplaceAll]);
    part := StringReplace(part, '>', '&gt', [rfReplaceAll]);

    if Drawstyle.isURL then
      part := '<a href="' + part + '">' + part + '</a>';
    localhtmlfont := '<FONT style="background-color: ' + HTMLClr(bc) + ';color:' + HTMLClr(C) + ';' + tagstrl(sl) + '">';
    if localhtmlfont = htmlfont then
      shtml := html.Strings[html.Count - 1] + part
    else
    begin
      if htmlfont <> '' then
        shtml := html.Strings[html.Count - 1] + '</FONT>' + localhtmlfont + part
      else
        shtml := html.Strings[html.Count - 1] + localhtmlfont + part;
    end;
    htmlfont := localhtmlfont;
    html.Strings[html.Count - 1] := shtml;
  end;
end;

procedure TAdvCustomMemo.DrawRTF(Part: string; var Drawstyle: Tstyle; lineno: integer);
var
  bc, c, OldHClr: Tcolor;
  sl: Tfontstyles;
  AFont: TFont;

  procedure loadfromitemstyle;
  begin
    with FLineBitmap.Canvas do
    begin
      try
        C := InternalStyles.FAllStyles.Items[DrawStyle.index].Font.Color;
        Sl := InternalStyles.FAllStyles.Items[DrawStyle.index].Font.Style;
        BC := InternalStyles.FAllStyles.Items[DrawStyle.index].FBGColor;
      except
        on Exception do
        begin
          C := Self.Font.Color;
          Sl := Self.Font.Style;
          BC := Self.BkColor;
        end;
      end;
    end;
  end;

  procedure tagstrl(stc: Tfontstyles);
  begin
    if fsbold in stc then
    begin
      if not FRTFEngine.Bold then
        FRTFEngine.AddBold(True);
    end
    else if FRTFEngine.Bold then
      FRTFEngine.AddBold(False);

    if fsItalic in stc then
    begin
      if not FRTFEngine.Italic then
        FRTFEngine.AddItalic(True);
    end
    else if FRTFEngine.Italic then
      FRTFEngine.AddItalic(False);

    //if rz <> '' then rz := 'font:' + rz + ';';
    if fsUnderline in stc then
    begin
      //rz := rz + 'text-decoration:'#39 + 'underline' + #39';';
      if not FRTFEngine.UnderLine then
        FRTFEngine.AddUnderLine(True);
    end
    else if FRTFEngine.UnderLine then
      FRTFEngine.AddUnderLine(False);
  end;

begin
  if not Assigned(FRTFEngine) then
    Exit;

  C := Self.Font.Color;
  Sl := Self.Font.Style;
  BC := Self.BkColor;

  begin
    if (DrawStyle.isComment) and (not DrawStyle.isURL) then
    begin
      C := InternalStyles.CommentStyle.FTextColor;
      SL := InternalStyles.CommentStyle.FStyle;
      if InternalStyles.CommentStyle.FBkColor <> clNone then
        BC := InternalStyles.CommentStyle.FBkColor
      else
        BC := self.BkColor;
    end
    else
    begin
      if (DrawStyle.isBracket) and (not DrawStyle.isURL) then
        loadfromitemstyle
      else
      begin
        if DrawStyle.isnumber then
        begin
          C := InternalStyles.FNumberStyle.FTextColor;
          SL := InternalStyles.FNumberStyle.Style;
          if InternalStyles.FNumberStyle.FBkColor <> clNone then
            BC := InternalStyles.FNumberStyle.FBkColor
          else
            BC := self.BkColor;
        end;
        if DrawStyle.isdelimiter then loadfromitemstyle;
        if DrawStyle.iskeyWord then loadfromitemstyle;
        if DrawStyle.isURL then
        begin
          C := FurlStyle.FTextColor;
          SL := FurlStyle.Style;
          if FurlStyle.FBkColor <> clNone then
            BC := FurlStyle.FBkColor
          else
            BC := self.BkColor;
        end;
      end;
    end;
  end;

  if part <> '' then
  begin
    // Needed only for HTTP comment rest of symbols solved by tag <PRE>
    //part := StringReplace(part, '<', '&lt', [rfReplaceAll]);
    //part := StringReplace(part, '>', '&gt', [rfReplaceAll]);

    if Drawstyle.isURL then
    begin
      //part := '<a href="' + part + '">' + part + '</a>';
      AFont := TFont.Create;
      AFont.Assign(Font);
      AFont.Style := UrlStyle.Style;
      OldHClr := FRTFEngine.HighLightColor;
      if (UrlStyle.FBkColor = clNone) then
      begin
        if (OldHClr <> clNone) then
          FRTFEngine.AddHighLightColor(clNone);
      end
      else
      begin
        FRTFEngine.AddHighLightColor(UrlStyle.FBkColor);
      end;
      AFont.Color := UrlStyle.FTextColor;
      FRTFEngine.AddHyperLink(part, part, AFont);
      if OldHClr <> clNone then
        FRTFEngine.AddHighLightColor(OldHClr);
      AFont.Free;
      Exit;
    end;

    //localhtmlfont := '<FONT style="background-color: ' + HTMLClr(bc) + ';color:' + HTMLClr(C) + ';' + tagstrl(sl) + '">';
    FRTFEngine.AddHighLightColor(bc);
    FRTFEngine.AddForeColor(C);
    tagstrl(sl);
    FRTFEngine.AddText(part);
    
   { if localhtmlfont = htmlfont then
      shtml := html.Strings[html.Count - 1] + part
    else
    begin
      if htmlfont <> '' then
        shtml := html.Strings[html.Count - 1] + '</FONT>' + localhtmlfont + part
      else
        shtml := html.Strings[html.Count - 1] + localhtmlfont + part;
    end;
    htmlfont := localhtmlfont;
    html.Strings[html.Count - 1] := shtml;
    }
  end;
end;

{$IFNDEF TMSCLX}

procedure TAdvCustomMemo.WMLButtonDblClk(var Message: TWMLButtonDblClk);
var
  s: string;
  i: integer;
  fb, fe: integer;
  charPos: TFullPos;
begin
  if Assigned(FOnGutterDblClick) then
    if PointInRect(Point(Message.XPos, Message.YPos), FGutter.FullRect) then
    begin
      CharPos := CharFromPos(Message.XPos, Message.YPos);
      if charPos.LineNo < InternalLines.Count then
        FOnGutterDblClick(Self, charPos.LineNo);
    end;

  if (Message.XPos < FGutter.GutterWidth) and (FGutter.Visible) then
    Exit;

  if not PointInRect(Point(Message.XPos, Message.YPos), EditorRect) then
    Exit;

  if Assigned(OnDblClick) then
    OnDblClick(Self);

  if Message.XPos > Width then
    Exit;

  if InternalLines.Count = 0 then
    Exit;

  s := InternalLines.Strings[CurY];

  if (CurX + 1 > Length(s)) or IsWordBoundary(s[CurX + 1]) then
  begin
    if FCodeFolding.Enabled then
    begin
      if AutoExpand and (CurY < InternalLines.Count) then
      begin
        InternalLines[CurY] := TrimRightWW(CurY);
        CurX := Length(InternalLines[CurY]);
      end;
      ExpandNode[CurY] := True;
    end;

    Exit;
  end
  else
  begin
    if IsNode(CurY) and not ExpandNode[CurY] and (CurX < Length(s)) and IsCommentedNode(CurY) then
      ExpandNode[CurY] := True;
  end;

  fe := 0;
  fb := 0;

  for i := CurX to Length(s) do
    if not IsWordBoundary(s[i]) then
      fe := i
    else
      Break;

  for i := CurX downto 1 do
    if not IsWordBoundary(s[i]) then
      fb := i - 1
    else
      Break;

  ClearSelection;

  if (fb < Fe) then
  begin
    FSelStartX := fb;
    FSelEndX := fe;
    FSelStartY := curY;
    FSelEndY := curY;
  end;
  SelectionChanged;
  Invalidate;
end;

procedure TAdvCustomMemo.BeginUpdate;
begin
  FLetRefresh := False;
end;

procedure TAdvCustomMemo.EndUpdate;
begin
  FLetRefresh := True;
  ResizeScrollBars(False);
end;

procedure TAdvCustomMemo.WMCommand(var Message: TWMCommand);
begin
  case message.itemid of
    1: CopyToClipboard;
    2: CutToClipboard;
    3: PasteFromClipboard;
    4: SelectAll;
    5: Undo;
    6: Redo;
    7: DeleteSelectionInt(true);
  end;
end;

{$IFDEF DELPHI5_LVL}
procedure TAdvCustomMemo.WMContextMenu(var Message: TWMContextMenu);
var
  popmenu: THandle;
  OldCursor: TCursor;
  pt: TPoint;
begin
  SetFocus;
  inherited;

  pt := ScreenToClient(Point(Message.XPos, Message.YPos));

  if not Assigned(PopupMenu) and (pt.X > FGutter.GutterWidth) then
  begin
    popMenu := CreatePopupMenu;

    clipboard.HasFormat(cf_Text);

{$IFNDEF TMSDOTNET}
    if CanUndo and not ReadOnly then
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 5, pchar('Undo'#9'Ctrl-Z'))
    else
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 5, pchar('Undo'#9'Ctrl-Z'));

    if CanRedo and not ReadOnly then
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 6, pchar('Redo'#9'Ctrl-Y'))
    else
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 5, pchar('Redo'#9'Ctrl-Y'));

    InsertMenu(popmenu, $FFFFFFFF, MF_SEPARATOR, 0, pchar('null'));
{$ENDIF}

{$IFDEF TMSDOTNET}
    if CanUndo and not ReadOnly then
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 5, 'Undo'#9'Ctrl-Z')
    else
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 5, 'Undo'#9'Ctrl-Z');

    if CanRedo and not ReadOnly then
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 6, 'Redo'#9'Ctrl-Y')
    else
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 5, 'Redo'#9'Ctrl-Y');

    InsertMenu(popmenu, $FFFFFFFF, MF_SEPARATOR, 0, 'null');
{$ENDIF}

    if SelLength > 0 then
    begin
{$IFNDEF TMSDOTNET}
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 1, pchar('Copy'#9'Ctrl-C'));
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 2, pchar('Cut'#9'Ctrl-X'));
{$ENDIF}

{$IFDEF TMSDOTNET}
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 1, 'Copy'#9'Ctrl-C');
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 2, 'Cut'#9'Ctrl-X');
{$ENDIF}
    end
    else
    begin
{$IFNDEF TMSDOTNET}
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 1, pchar('Copy'#9'Ctrl-C'));
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 2, pchar('Cut'#9'Ctrl-X'));
{$ENDIF}

{$IFDEF TMSDOTNET}
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 1, 'Copy'#9'Ctrl-C');
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 2, 'Cut'#9'Ctrl-X');
{$ENDIF}
    end;

{$IFNDEF TMSDOTNET}
    if Clipboard.HasFormat(cf_Text) and not ReadOnly then
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 3, pchar('Paste'#9'Ctrl-V'))
    else
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 3, pchar('Paste'#9'Ctrl-V'));

    if SelLength > 0 then
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 7, pchar('Delete'))
    else
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 7, pchar('Delete'));

    InsertMenu(popmenu, $FFFFFFFF, MF_SEPARATOR, 0, pchar('null'));
    InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 4, pchar('Select All'#9'Ctrl-A'));
{$ENDIF}

{$IFDEF TMSDOTNET}
    if Clipboard.HasFormat(cf_Text) and not ReadOnly then
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 3, 'Paste'#9'Ctrl-V')
    else
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 3, 'Paste'#9'Ctrl-V');

    if SelLength > 0 then
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 7, 'Delete')
    else
      InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION or MF_GRAYED, 7, 'Delete');

    InsertMenu(popmenu, $FFFFFFFF, MF_SEPARATOR, 0, 'null');
    InsertMenu(popmenu, $FFFFFFFF, MF_BYPOSITION, 4, 'Select All'#9'Ctrl-A');
{$ENDIF}

    OldCursor := Cursor;
    Cursor := crDefault;
    TrackPopupMenu(popmenu, TPM_LEFTALIGN or TPM_LEFTBUTTON, Message.XPos, Message.YPos, 0, Handle, nil);

    DestroyMenu(popmenu);

    Cursor := OldCursor;
  end;
end;
{$ENDIF}

{$ENDIF}

//------------------------------------------------------
//          TAdvgutter
//------------------------------------------------------

constructor TAdvGutter.Create(AOwner: TAdvCustomMemo);
begin
  inherited Create;
  Memo := AOwner;
  FGutterWidth := 45;
  FGutterMargin := 45;
  FBorderColor := clGray;
  FShowLineNumbers := True;
  FShowGutter := True;
  FShowLeadingZeros := false;
  FDigitCount := 4;
  FLineNumberStart := 1;
  FFont := TFont.Create;
  FFont.Name := 'Courier New';
  FFont.Size := 10;
  FFont.OnChange := OnFontChange;
  Font.Assign(FFont);
  FNumberSuffix := '';
  FLeft := 1;
  FTop := 1;
  FWidth := 45;
  FHeight := 0;
  FColor := clBtnFace;
  FColorTo := clWhite;
  FModifiedColorBkg := clLime;
  FModifiedColor := clYellow;
end;

destructor TAdvGutter.Destroy;
begin
  FFont.Free;
  inherited;
end;

function TAdvGutter.GetGutterColor: TColor;
begin
  Result := FColor;
end;

procedure TAdvGutter.SetGutterColorTo(const Value: TColor);
begin
  FColorTo := Value;
  Invalidate;
end;

procedure TAdvGutter.SetNumberSuffix(const Value: string);
begin
  FNumberSuffix := Value;
  Invalidate;
end;  

procedure TAdvGutter.SetLineNumberStart(const Value: integer);
begin
  if FLineNumberStart <> value then
  begin
    if value >= 0 then
    begin
      FLineNumberStart := Value;
      Invalidate;
    end;
  end;
end;

procedure TAdvGutter.SetShowLineNumbers(const Value: Boolean);
begin
  FShowLineNumbers := Value;
  Invalidate;
end;

procedure TAdvGutter.SetLineNumberTextColor(const Value: TColor);
begin
  if FLineNumberTextColor <> Value then
  begin
    FLineNumberTextColor := Value;
    Invalidate;
  end;
end;

function TAdvGutter.GetGutterColorTo: TColor;
begin
  Result := FColorTo;
end;

procedure TAdvGutter.SetDigitCount(const Value: integer);
begin
  FDigitCount := Value;
  Invalidate;
end;

procedure TAdvGutter.SetShowLeadingZeros(const Value: boolean);
begin
  FShowLeadingZeros := Value;
  Invalidate;
end;

procedure TAdvGutter.SetShowModified(const Value: boolean);
begin
  FShowModified := Value;
  Invalidate;
end;

procedure TAdvGutter.SetModifiedColor(const Value: TColor);
begin
  FModifiedColor := Value;
  Invalidate;
end;

procedure TAdvGutter.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
  Invalidate;
end;

procedure TAdvGutter.SetModifiedColorBkg(const Value: TColor);
begin
  FModifiedColorBkg := Value;
  Invalidate;
end;

procedure TAdvGutter.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TAdvGutter.SetGutterWidth(Value: integer);
begin
  FGutterWidth := Value;
  FWidth := Value;
  if not (csLoading in memo.ComponentState) then
    memo.ResizeEditor;
end;

procedure TAdvGutter.SetGutterMargin(Value: integer);
begin
  if Value < 45 then
    Value := 45;
  if Value <> FGutterMargin then
    FGutterMargin := Value;
end;

procedure TAdvGutter.SetGutterColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Invalidate;
  end;
end;

procedure TAdvGutter.OnFontChange(Sender: TObject);
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TAdvGutter.SetShowGutter(const Value: boolean);
begin
  FShowGutter := Value;
  Invalidate;
  Memo.Invalidate;
end;

//-------------------- SET PARAMS -----------------------

procedure TAdvGutter.SetParams(Index: integer; Value: integer);
begin
  case Index of
    0: FLeft := Value;
    1: FTop := Value;
    2: FWidth := Value;
    3: FHeight := Value;
  end;
end;

//-------------------- PAINT TO -----------------------

procedure TAdvGutter.PaintTo(ACanvas: TCanvas);
var
  LineNo, T, H, LineNoR, I: Integer;
begin
  with ACanvas do
  begin
    Pen.Color := FBorderColor;
    MoveTo(Left + Width - 1, Top);
    LineTo(Left + Width - 1, Top + Height);
    Pen.Color := clWhite;
    MoveTo(Left + Width - 2, Top);
    LineTo(Left + Width - 2, Top + Height);

    Brush.Color := Self.FColor;

    if FColorTo = clNone then
      FillRect(Rect(Left, Top, Left + Width - 2, Top + Height))
    else
      DrawGradient(ACanvas, FColor, FColorTo, 48, Rect(Left, Top, Left + Width - 1, Top + Height), True);

    if Assigned(Memo.OnGutterDraw) then
    begin
      T := Top;
      H := Memo.FCellSize.H;
      if not Memo.CodeFolding.Enabled then
        LineNo := Memo.FTopLine // topline ?
      else
        LineNo := Memo.LineIndexToVisIndex(Memo.FTopLine);
      LineNoR := LineNo;

      for I := 0 to LineNo - 1 do
      begin
        if Memo.GetWrapped(i) then
          dec(LineNoR);
      end;

      while T < Top + Height do
      begin
        if not Memo.GetWrapped(LineNo) then
        begin
          Memo.OnGutterDraw(Memo, ACanvas, LineNoR, Rect(Left, T, Left + Width - 2, T + H));
          Inc(LineNoR);
        end;
        T := T + H;

        Inc(LineNo);

        if not Memo.CodeFolding.Enabled then
        begin
          if LineNo >= Memo.InternalLines.Count then
            Break;
        end
        else
        begin
          if LineNo >= Memo.LineIndexToVisIndex(Memo.InternalLines.Count) then
            Break;
        end;
      end;
    end;
  end;
end;

//-------------------- INVALIDATE -----------------------

procedure TAdvGutter.Invalidate;
var
  gRect: TRect;
begin
  gRect := Rect(Left, Top, Left + Width, Top + Height);

{$IFDEF TMSCLX}
  Memo.Invalidate;
{$ENDIF}

{$IFNDEF TMSCLX}
{$IFNDEF TMSDOTNET}
  InvalidateRect(Memo.Handle, @gRect, False);
{$ENDIF}

{$IFDEF TMSDOTNET}
  InvalidateRect(Memo.Handle, gRect, False);
{$ENDIF}
{$ENDIF}
end;

//-------------------- GET RECT -----------------------

function TAdvGutter.GetRect: TRect;
begin
  Result := Rect(Left, Top, Left + Width, Top + Height);
end;


procedure TAdvCustomMemo.SetComponentStyle(AStyle: TTMSStyle);
begin
  SetStyle(TAdvMemoStyle(AStyle));
end;

procedure TAdvCustomMemo.SetStyle(AStyle: TAdvMemoStyle);
begin
  case AStyle of
  msOffice2003Blue:
    begin
      Gutter.FColor := $FCE1CB;
      Gutter.FColorTo := $E0A57D;
      BorderColor := $962D00;
    end;
  msOffice2003Olive:
    begin
      Gutter.FColor := $ECE2E1;
      Gutter.FColorTo := $B39698;
      BorderColor := $947C7C;
    end;
  msOffice2003Silver:
    begin
      Gutter.FColor := $CFF0EA;
      Gutter.FColorTo := $8CC0B1;
      BorderColor := $588060;
    end;
  msOffice2003Classic:
    begin
      Gutter.FColorTo := $ccd4d8;
      Gutter.FColor := clWhite;
      BorderColor := $808080;      
    end;
  msOffice2007Luna:
    begin
      Gutter.FColorTo := $FFD2AF;
      Gutter.FColor := $FFEFE3;
      BorderColor := $FFD2AF;
    end;
  msOffice2007Obsidian:
    begin
      Gutter.FColorTo := $C9C2BD;
      Gutter.FColor := $F2F1F0;
      BorderColor := $5C534C;
    end;
  msOffice2007Silver:
    begin
      Gutter.FColorTo := $E8E0DB;
      Gutter.FColor := $F8F7F6;
      BorderColor := $74706F;
    end;
  msWhidbey:
    begin
      Gutter.FColorTo := $F5F9FA;
      Gutter.FColor := $A8C0C0;
      BorderColor := $962D00;      
    end;
  msWindowsXP:
    begin
      Gutter.FColorTo := clBtnFace;
      Gutter.FColor := clBtnFace;
      BorderColor := clBlack;      
    end;
  end;
  Gutter.BorderColor := BorderColor;
  Invalidate;

end;


//---------------------------------------------
//     TAdvActiveLineSettings
//---------------------------------------------

constructor TAdvActiveLineSettings.Create(AOwner: TAdvCustomMemo);
begin
  inherited Create;
  Memo := AOwner;
  FActiveLineColor := clNavy;
  FActiveLineTextColor := clYellow;
  FShowActiveLine := False;
  FShowActiveLineIndicator := False;
end;

procedure TAdvActiveLineSettings.SetShowActiveLineIndicator(const Value: boolean);
begin
  if (FShowActiveLineIndicator <> Value) then
  begin
    FShowActiveLineIndicator := Value;
    Memo.Invalidate;
  end;
end;

procedure TAdvActiveLineSettings.SetShowActiveLine(const Value: boolean);
begin
  FShowActiveLine := Value;
  Memo.Invalidate;
end;

procedure TAdvActiveLineSettings.SetActiveLineColor(const Value: TColor);
begin
  if FActiveLineColor <> Value then
  begin
    FActiveLineColor := Value;
    Memo.Invalidate;
  end;
end;

procedure TAdvActiveLineSettings.SetActiveLineTextColor(const Value: TColor);
begin
  if FActiveLineTextColor <> Value then
  begin
    FActiveLineTextColor := Value;
    Memo.Invalidate;
  end;
end;

procedure TAdvActiveLineSettings.SetActiveLineAtCursor(const Value: Boolean);
begin
  if FActiveLineAtCursor <> Value then
  begin
    FActiveLineAtCursor := Value;
    if Value then
      Memo.ActiveLine := Memo.CurY;
    Memo.Invalidate;
  end;
end;

//--------------------------------------------------------------
//        Adv MEMO STRINGS
//--------------------------------------------------------------

destructor TAdvMemoStrings.Destroy;
begin
  ClearLinesProp;
  FlinesProp.Free;
  FListLengths.Free;
  inherited;
end;

//-------------------- ADD ----------------------

function TAdvMemoStrings.DoAdd(const S: string): integer;
begin
  Result := TStringList(Self).Add(s);
end;

//-------------------- DO INSERT ----------------------

procedure TAdvMemoStrings.DoInsert(Index: integer; const S: string);
var
  s1: string;
  i: integer;
begin
  if Assigned(memo) then
  begin
    s1 := StringReplace(S, #9, stringofchar(#32, memo.tabsize), [rfreplaceall]);
    if index < memo.FTopLine then memo.FbackupTopLine := -1;
    FListLengths.Insert(Index, length(s1));

    for i := 0 to 9 do
    begin
      if (memo.FBookmarkList.Items[i] >= Index) then
        memo.FBookmarkList.Items[i] := memo.FBookmarkList.Items[i] + 1;
    end;

    inherited Insert(Index, s1);
  end
  else
  begin
    FListLengths.Insert(Index, length(s));
    inherited Insert(Index, s);
  end;
end;

//-------------------- DELETE ----------------------

procedure TAdvMemoStrings.Delete(Index: integer);
var
  SaveCurY, SaveCurX: integer;
  Tlp: TLineProp;
begin
  if (Index < 0) or (Index > Count - 1) then Exit;
  if FDeleting or (not Assigned(Memo)) then
  begin
    FListLengths.Delete(index);
    inherited;
  end
  else
  begin
    if index < memo.FTopLine then memo.FbackupTopLine := -1;
    FDeleting := True;
    if Memo.CodeFolding.Enabled then
    begin
      Tlp := GetLineProp(Index);
      if Assigned(Tlp) and (Tlp is TLineProp) then
      begin
        if Tlp.HasChildren then
        begin
          Memo.RemoveCodeFolding(Index);
        end
        else if Tlp.HasParent and Tlp.LastChild then
        begin
          Memo.RemoveCodeFoldingFromChild(Index);
        end;
      end;
    end;
    
    SaveCurX := Memo.CurX;
    SaveCurY := Memo.CurY;
    if Index < SaveCurY then Dec(SaveCurY);
    if Count = 1 then SaveCurX := 0;
    Memo.CurY := Index;
    Memo.DeleteLine;
    Memo.FCurX := SaveCurX;
    Memo.FCurY := SaveCurY;
    FDeleting := False;
  end;
end;

procedure TAdvMemoStrings.Insert(Index: integer; const S: string);
begin
  Memo.ClearSelection;
  DoInsert(index, s);
  Memo.curx := Memo.curx;
  Memo.curY := Memo.curY;
  Memo.Invalidate;
end;

procedure TAdvMemoStrings.SaveToFile(const FileName: string);
begin
  if (Memo.WordWrap <> wwNone) then
    Memo.UndoWrap;
  inherited SaveToFile(FileName);
  if (Memo.WordWrap <> wwNone) then
    Memo.DoWrap;
end;

//-------------------- LOAD FROM FILE ----------------------

procedure TAdvMemoStrings.LoadFromFile(const FileName: string);
var
  i, len, mx: integer;
  s: string;
begin
  if not Assigned(Memo) then
  begin
    inherited LoadFromFile(FileName);
    Exit;
  end;

  with Memo do
  begin
    ClearSelection;
    ClearUndoList;
    CurX := 0;
    CurY := 0;
    FLetRefresh := False;
  end;
  
  Memo.InternalLines.OnChange := nil;

  inherited LoadFromFile(FileName);
  Memo.FbackupTopLine := -1;
  Memo.CurX := 0;
  Memo.CurY := 0;
  mx := 0;

  Memo.FLetRefresh := false;

  for i := 0 to Memo.InternalLines.Count - 1 do
  begin
    s := Strings[i];
    if pos(#9,s) > 0 then
    begin
      s := StringReplace(s, #9, stringofchar(#32, memo.TabSize), [rfreplaceall]);
      Strings[i] := s;
    end;

    len := Length(s);
    if len > mx then
      mx := len;
  end;
  Memo.FmaxLength := mx;

  Memo.FLetRefresh := true;
  Memo.InternalLines.OnChange := Memo.LinesChanged;

  Memo.FLetRefresh := True;
  Memo.LinesChanged(nil);

  Memo.UpdateWrap;

  Memo.AutoCodeFold;

  Memo.Refresh;
end;

procedure TAdvMemoStrings.LoadFromStream(Stream: TStream);
var
  i, len, mx: integer;
  s: string;

begin
  if not Assigned(Memo) then
  begin
    inherited LoadFromStream(Stream);
    Exit;
  end;

  with Memo do
  begin
    ClearSelection;
    ClearUndoList;
    CurX := 0;
    CurY := 0;
    FLetRefresh := False;
  end;

  Memo.InternalLines.OnChange := nil;

  inherited LoadFromStream(Stream);

  Memo.FbackupTopLine := -1;
  Memo.CurX := 0;
  Memo.CurY := 0;
  mx := 0;

  for i := 0 to Memo.InternalLines.Count - 1 do
  begin
    s := Strings[i];
    if pos(#9,s) > 0 then
    begin
      s := StringReplace(s, #9, stringofchar(#32, memo.TabSize), [rfreplaceall]);
      Strings[i] := s;
    end;
    len := Length(s);
    if len > mx then
      mx := len;
  end;

  Memo.FmaxLength := mx;
  Memo.InternalLines.OnChange := Memo.LinesChanged;
  Memo.FLetRefresh := True;
  Memo.LinesChanged(nil);
  Memo.UpdateWrap;
  Memo.AutoCodeFold;
  Memo.Refresh;
end;

//-------------------- GET OBJECT ---------------------------

function TAdvMemoStrings.GetObject(Index: Integer): TObject;
begin
  Result := nil;

  if (Index >= 0) and (Index < Count) then
  begin
    Result := inherited GetObject(Index);
    if Assigned(Result) and (Result is TLineProp) then
      Result := TLineProp(Result).FObject;
  end;
end;

//-------------------- PUT OBJECT ---------------------------

procedure TAdvMemoStrings.PutObject(Index: Integer; AObject: TObject);
var
  P: TObject;
begin
  if (Index >= 0) and (Index < Count) then
  begin
    P := inherited GetObject(Index);
    if Assigned(P) and (P is TLineProp) then
      TLineProp(P).FObject := AObject
    else
      inherited PutObject(Index, AObject);
  end;
end;

procedure TAdvMemoStrings.RestoreObject(Index: Integer; AObject: TObject);
begin
  inherited PutObject(Index, AObject);
end;


function TAdvMemoStrings.Get(Index: Integer): string;
begin
  Result := inherited Get(Index);
end;

procedure TAdvMemoStrings.Put(Index: Integer; const S: string);
var
  sz: string;
begin
  if not Assigned(Memo) then
  begin
    inherited Put(index, s)
  end
  else
  begin
    sz := (StringReplace(s, #9, StringOfChar(#32, memo.Tabsize), [rfreplaceall]));
    if Index < FListLengths.Count then
      FListLengths.Items[Index] := length(sz)
    else
      FListLengths.Add(length(sz));

    inherited Put(Index, sz);

    if Index < Memo.FTopLine then
      Memo.FbackupTopLine := -1;
  end;
end;


//-------------------- SET UPDATE STATE ----------------------

procedure TAdvMemoStrings.SetUpdateState(Updating: boolean);
begin
  if Updating then
    Inc(FLockCount)
  else
    if FLockCount > 0 then
      Dec(FLockCount);
end;

function TAdvMemoStrings.CreateProp(Index: integer): TLineProp;
var
  Tlp: TLineProp;
begin
  Result := TLineProp.Create;
  with Result do
    FObject := inherited GetObject(Index);

  if Assigned(Memo) then
  begin
    if Memo.CodeFolding.Enabled and (Index > 0)then
    begin
      Tlp := self.GetLineProp(Index -1);
      if Assigned(Tlp) and (Tlp is TLineProp) then
      begin
        if Tlp.HasParent and not Tlp.LastChild then
          Result.HasParent := True;
        if Tlp.HasChildren and Tlp.Expanded then
          Result.HasParent := True;
      end;

      if not Result.HasParent then
      begin
        Tlp := self.GetLineProp(Index +1);
        if Assigned(Tlp) and (Tlp is TLineProp) then
        begin
          if Tlp.HasParent then
            Result.HasParent := True;
        end;
      end;
    end;
  end;

  inherited PutObject(Index, Result);
{$IFDEF TMSDOTNET}
  FLinesProp.Add(TObject(result));
{$ENDIF}
{$IFNDEF TMSDOTNET}
  FLinesProp.Add(Pointer(result));
{$ENDIF}
end;

procedure TAdvMemoStrings.ClearStrings;
begin
  FLinesProp.Clear;
  FListLengths.Clear;
  inherited Clear;
end;

procedure TAdvMemoStrings.Clear;
begin
  if Assigned(Memo) then
  begin
    with Memo do
    begin
      FSelStartX := 0;
      FSelStartY := 0;
      FSelEndX := 0;
      FSelEndY := 0;
      CurY := 0;
      CurX := 0;
      Invalidate;
    end;
  end;
  ClearLinesProp;
  FListLengths.Clear;
  if Assigned(Memo) then
    Memo.FCodeFoldingNodeCount := 0;;
  inherited;
end;

constructor TAdvMemoStrings.Create;
begin
  inherited;
  FLinesProp := TList.Create;
  FListLengths := TIntList.Create;
end;

procedure TAdvMemoStrings.ClearLinesProp;
var
  P: TLineProp;
  i: Integer;
begin
  for i := 0 to FLinesProp.Count - 1 do
  begin
{$IFNDEF TMSDOTNET}
    p := FLinesProp[i];
{$ENDIF}

{$IFDEF TMSDOTNET}
    p := TLineProp(FLinesProp[i]);
{$ENDIF}

    if p <> nil then
    begin
      if Assigned(p) then
      begin
        p.Free;
      end;
    end;
  end;
  FLinesProp.Clear;
end;

function TAdvMemoStrings.GetLineProp(Index: Integer): TlineProp;
var
  P: Tobject;
begin
  if (index < Count) and (Index >= 0) then
  begin
    p := inherited GetObject(Index);
    if p is TlineProp then
      Result := TlineProp(p)
    else
      Result := nil;
  end
  else
    Result := nil;
end;

procedure TAdvMemoStrings.SetLineProp(Index: Integer;
  const Value: TlineProp);
begin
  if (Index < Count) and (Index >= 0) then
    inherited PutObject(index, value)
end;

procedure TAdvMemoStrings.SetTextEx(const Value: string);
{$IFNDEF DELPHI_UNICODE}
var
  ms: TMemoryStream;
{$ENDIF}
begin
{$IFDEF DELPHI_UNICODE}
  inherited text := value;
{$ENDIF}
{$IFNDEF DELPHI_UNICODE}
  ms := TMemoryStream.Create;
  ms.WriteBuffer(Value[1],length(Value));
  ms.Position := 0;
  LoadFromStream(ms);
  ms.Free;
{$ENDIF}
end;

//--------------------------------------------------------------
//        TUNDO LIST
//--------------------------------------------------------------

constructor TUndo.Create(ACurX0, ACurY0, ACurX, ACurY: integer; AText: string);
begin
  inherited Create;
  FUndoCurX0 := ACurX0;
  FUndoCurY0 := ACurY0;
  FUndoCurX := ACurX;
  FUndoCurY := ACurY;
  FUndoText := AText;
end;

procedure TUndo.Undo;
begin
  if Assigned(Memo) then
    with Memo do
    begin
      CurY := FUndoCurY;
      CurX := FUndoCurX;
      PerformUndo;
      CurY := FUndoCurY0;
      CurX := FUndoCurX0;
    end;
end;

procedure TUndo.Redo;
begin
  if Assigned(Memo) then
    with Memo do
    begin
      CurY := FUndoCurY0;
      CurX := FUndoCurX0;
      PerformRedo;
      CurY := FUndoCurY;
      CurX := FUndoCurX;
    end;
end;

function TUndo.Append(NewUndo: TUndo): boolean;
begin
  Result := False;
end;

//----------------  TINSERTCHARUNDO --------------------------

procedure TInsertCharUndo.PerformUndo;
var
  i: Integer;
  CurrLine: string;
begin
  for i := Length(FUndoText) downto 1 do
  begin
    CurrLine := Memo.InternalLines[Memo.CurY];
    if ((FUndoText[i] = #13) and (Memo.CurX = 0)) or ((Length(CurrLine) > 0) and
      (FUndoText[i] = CurrLine[Memo.CurX])) then
      Memo.BackSpace;
  end;
end;

procedure TInsertCharUndo.PerformRedo;
var
  i: Integer;
begin
  with Memo do
    for i := 1 to Length(FUndoText) do
      if FUndoText[i] = #13 then
        NewLine
      else
        InsertChar(FUndoText[i]);
end;

function TInsertCharUndo.Append(NewUndo: TUndo): boolean;
begin
  Result := False;
  if not ((NewUndo is TInsertCharUndo) and
    (NewUndo.UndoCurX0 = FUndoCurX) and
    (NewUndo.UndoCurY0 = FUndoCurY)) then Exit;
  FUndoText := FUndoText + NewUndo.FUndoText;
  FUndoCurX := NewUndo.UndoCurX;
  FUndoCurY := NewUndo.UndoCurY;
  Result := True;
end;

//----------------  TDELETECHARUNDO --------------------------

procedure TDeleteCharUndo.PerformUndo;
var
  i: integer;
begin
  with Memo do
    for i := 1 to Length(FUndoText) do
    begin
      if not FIsBackspace then
      begin
        Memo.CurY := FUndoCurY0;
        Memo.CurX := FUndoCurX0;
      end;
      if FUndoText[i] = #13 then
        NewLine
      else
      begin
        InsertChar(FUndoText[i]);
        Invalidate;
      end;
    end;
end;

procedure TDeleteCharUndo.PerformRedo;
var
  i: integer;
begin
  with Memo do
    for i := 1 to Length(FUndoText) do
      if FIsBackspace then
        BackSpace
      else
        DeleteChar(-1, -1);
end;

function TDeleteCharUndo.Append(NewUndo: TUndo): boolean;
begin
  Result := False;
  if not ((NewUndo is TDeleteCharUndo) and
    (NewUndo.UndoCurX0 = FUndoCurX) and
    (NewUndo.UndoCurY0 = FUndoCurY)) then Exit;
  if TDeleteCharUndo(NewUndo).FIsBackspace <> FIsBackspace then Exit;
  FUndoText := NewUndo.FUndoText + FUndoText;
  FUndoCurX := NewUndo.UndoCurX;
  FUndoCurY := NewUndo.UndoCurY;
  Result := True;
end;

//----------------  TDELETE BUF, LINE UNDO --------------------------

procedure TDeleteLineUndo.PerformUndo;
begin
  with Memo do
  begin
    ClearSelection;
{$IFNDEF TMSDOTNET}
    SetSelText(PChar(FUndoText + #13#10));
{$ENDIF}

{$IFDEF TMSDOTNET}
    SetSelText(FUndoText + #13#10);
{$ENDIF}
  end;
end;

procedure TDeleteLineUndo.PerformRedo;
begin
  Memo.DeleteLine;
end;

procedure TDeleteBufUndo.PerformUndo;
begin
  with Memo do
  begin
    ClearSelection;

{$IFNDEF TMSDOTNET}
    SetSelText(PChar(FUndoText));
{$ENDIF}

{$IFDEF TMSDOTNET}
    SetSelText(FUndoText);
{$ENDIF}

    SetFocus;

    FSelStartX := FUndoSelStartX;
    FSelStartY := FUndoSelStartY;
    FSelEndX := FUndoSelEndX;
    FSelEndY := FUndoSelEndY;
  end;
end;

procedure TDeleteBufUndo.PerformRedo;
begin
  with Memo do
  begin
    FSelStartX := FUndoSelStartX;
    FSelStartY := FUndoSelStartY;
    FSelEndX := FUndoSelEndX;
    FSelEndY := FUndoSelEndY;
    DeleteSelectionInt(True);
  end;
end;


//----------------  TINDENTUNDO --------------------------

constructor TIndentUndo.Create(SelFrom, SelTo, Indent: integer);
begin
  inherited Create(0,0,0,0,'');
  SelRowFrom := SelFrom;
  SelRowTo := SelTo;
  FIndent := Indent;
end;

procedure TIndentUndo.PerformRedo;
begin
  Memo.BlockIndent(SelRowFrom, SelRowTo, Indent);
end;

procedure TIndentUndo.PerformUndo;
begin
  Memo.BlockIndent(SelRowFrom, SelRowTo, -Indent);
end;


//----------------  TPASTEUNDO --------------------------

procedure TPasteUndo.PerformUndo;
begin
  with Memo do
  begin
    FSelStartX := FUndoCurX0;
    FSelStartY := FUndoCurY0;
    FSelEndX := FUndoCurX;
    FSelEndY := FUndoCurY;
    DeleteSelectionInt(True);
  end;
end;

procedure TPasteUndo.PerformRedo;
begin
  with Memo do
  begin
    ClearSelection;
{$IFNDEF TMSDOTNET}
    SetSelText(PChar(FUndoText));
{$ENDIF}

{$IFDEF TMSDOTNET}
    SetSelText(FUndoText);
{$ENDIF}
  end;
end;

//----------------  TCORRECT UNDO --------------------------

{ TCorrectUndo }

constructor TCorrectUndo.Create(LineNo: integer; UndoLine: string);
begin
  inherited Create(-1,-1,-1,-1,'');
  FUndoCurY := LineNo;
  FUndoText := UndoLine;
end;

procedure TCorrectUndo.PerformRedo;
begin
  PerformUndo;
end;

procedure TCorrectUndo.PerformUndo;
var
  s: string;
begin
  with Memo do
  begin
    if Assigned(MemoSource) then
    begin
      s := MemoSource.Lines[CurY];
      MemoSource.Lines[CurY] := FUndoText
    end
    else
    begin
      s := Lines[CurY];
      Lines[CurY] := FUndoText;
    end;
    FUndoText := s;
  end;
end;



//----------------  TUNDO LIST --------------------------

constructor TAdvUndoList.Create;
begin
  inherited;
  FPos := 0;
  FIsPerforming := False;
  FLimit := 100;
end;

destructor TAdvUndoList.Destroy;
begin
  Clear;
  inherited;
end;

function TAdvUndoList.Get(Index: integer): TUndo;
begin
  Result := TUndo(inherited Get(Index));
end;

{$IFNDEF TMSDOTNET}

function TAdvUndoList.Add(Item: Pointer): integer;
{$ENDIF}
{$IFDEF TMSDOTNET}
function TAdvUndoList.Add(Item: TObject): integer;
{$ENDIF}
{$IFDEF TMSDEBUG}
var
 s: string;
{$ENDIF}
begin
{$IFDEF TMSDEBUG}
  s := tundo(item).ClassName;
  outputdebugstring(pchar(s));
{$ENDIF}

  Result := -1;
  if FIsPerforming then
  begin
    TUndo(Item).Free;
    Exit;
  end;

  if (Count > 0) and
    Items[0].Append(TUndo(Item)) then
  begin
    TUndo(Item).Free;
    Exit;
  end;

  TUndo(Item).Memo := Self.Memo;
  if FPos > 0 then
    while FPos > 0 do
    begin
      Delete(0);
      Dec(FPos);
    end;
  Insert(0, Item);
  if Count > FLimit then Delete(Count - 1);
  Memo.UndoChange;
  Result := 0;
end;

procedure TAdvUndoList.Clear;
begin
  while (Count > 0) do 
    Delete(0);  

  FPos := 0;
  if Assigned(Memo) then
    with Memo do
      if not (csDestroying in ComponentState) then
        UndoChange;
  inherited;      
end;

procedure TAdvUndoList.Delete(Index: integer);
begin
  TUndo(Items[Index]).Free;
  inherited;
end;

procedure TAdvUndoList.Undo;
var
  OldAutoIndent: boolean;
begin
  if FPos < Count then
  begin
    OldAutoIndent := Memo.AutoIndent;
    Memo.AutoIndent := False;
    FIsPerforming := True;
    Items[FPos].Undo;
    Inc(FPos);
    FIsPerforming := False;
    Memo.AutoIndent := OldAutoIndent;
    Memo.UndoChange;
  end;
end;

procedure TAdvUndoList.Redo;
var
  OldAutoIndent: boolean;
begin
  if FPos > 0 then
  begin
    OldAutoIndent := Memo.AutoIndent;
    Memo.AutoIndent := False;
    FIsPerforming := True;
    Dec(FPos);
    Items[FPos].Redo;
    FIsPerforming := False;
    Memo.AutoIndent := OldAutoIndent;
    Memo.UndoChange;
  end;
end;

procedure TAdvUndoList.SetLimit(Value: integer);
begin
  if FLimit <> Value then
  begin
    if Value <= 0 then Value := 10;
    if Value > 0 then Value := 100;
    FLimit := Value;
    Clear;
  end;
end;

procedure TAdvCustomMemo.ScrollBarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: integer);
var
  delta: integer;
  r: TRect;
  s:string;
  pt: TPoint;
begin
  if not Focused then
    SetFocus;

  if (TScrollBar(Sender).Kind = sbVertical) then
  begin
    case ScrollCode of
      scPageUp: ScrollPos := ScrollPos - VisibleLineCount;
      scPageDown: ScrollPos := ScrollPos + VisibleLineCount;
    end;

    if ScrollHint then
    begin
      if (ScrollCode = scENDSCROLL) then
      begin
        FScrollHintWindow.ReleaseHandle;
      end;

      if ScrollCode = scTRACK then
      begin
        s := 'Row : '+inttostr(ScrollPos + 1);
        if Assigned(OnScrollHint) then
          OnScrollHint(self,ScrollPos + 1,s);
        r := FScrollHintWindow.CalcHintRect(100,s,Nil);
        FScrollHintWindow.Caption := s;
        FScrollHintWindow.Color := clInfoBk;
        GetCursorPos(pt);
        r.Left := r.Left + pt.x + 10;
        r.Right := r.Right + pt.x + 10;
        r.Top := r.Top + pt.y;
        r.Bottom := r.Bottom + pt.y;
        FScrollHintWindow.ActivateHint(r,s);
      end;
    end;
  end;

  delta := TScrollBar(Sender).Position - ScrollPos;
  DoScroll(TScrollBar(Sender), -delta);

  Invalidate;
end;

//--------------------------------------------------------------
//        TAdvMemo - CREATE
//--------------------------------------------------------------
constructor TAdvMemo.Create(AOwner: TComponent);
begin
  inherited;
  SetBounds(0, 0, 350, 250);
  BkColor := clWhite;
  HiddenCaret := False;
  DelErase := True;
  CaseSensitive := False;
  ReadOnly := False;
  Font.Name := 'COURIER NEW';
  Font.Charset := DEFAULT_CHARSET;
  Font.Color := clBlack;
  Font.Height := -13;
  Font.Style := [];
{$IFNDEF TMSCLX}
  DoubleBuffered := True;
{$ENDIF}
  OnGutterClick := AdvSyntaxMemoGutterClick;
  OnGutterDraw := AdvSyntaxMemoGutterDraw;
  OnChange := AdvSyntaxMemoChange;
  FInBrackets := -1;
  FInComment := False;
  FVersion := GetVersionString;
end;

//--------------------------------------------------------------
//        TAdvMemo - DESTROY
//--------------------------------------------------------------
destructor TAdvMemo.Destroy;
begin
  inherited;
end;

//--------------------------------------------------------------
//        TAdv STRING LIST - READ STRINGS
//--------------------------------------------------------------
procedure TAdvStringList.ReadStrings(Reader: TReader);
var
  i: integer;
begin
  try
    Reader.ReadListBegin;
    Clear;
    while not Reader.EndOfList do
    begin
      i := Add(Reader.ReadString);
      Objects[i] := TObject(Reader.ReadInteger);
    end;
    Reader.ReadListEnd;
  finally
  end;
end;

//--------------------------------------------------------------
//        TAdv STRING LIST - WRITE STRINGS
//--------------------------------------------------------------
procedure TAdvStringList.WriteStrings(Writer: TWriter);
var
  i: integer;
begin
  with Writer do
  begin
    WriteListBegin;
    for i := 0 to Count - 1 do
    begin
      WriteString(Strings[i]);
      WriteInteger(integer(Objects[i]));
    end;
    WriteListEnd;
  end;
end;

//--------------------------------------------------------------
//        TAdv STRING LIST - DEFINE PROPERTIES
//--------------------------------------------------------------
procedure TAdvStringList.DefineProperties(Filer: TFiler);
begin
  Filer.Defineproperty('Strings', ReadStrings, WriteStrings, Count > 0);
end;

{ TElementStyles }

function TElementStyles.Add: TElementStyle;
begin
  Result := TElementStyle(inherited Add);
end;

constructor TElementStyles.Create(AOwner: TComponent);
begin
  FModified := False;

{$IFNDEF TMSDOTNET}
  inherited Create(AOwner, CreateItemClass);
{$ENDIF}

{$IFDEF TMSDOTNET}
  inherited Create(AOwner, TElementStyle);
{$ENDIF}
end;

function TElementStyles.CreateItemClass: TCollectionItemClass;
begin
  Result := TElementStyle;
end;


function TElementStyles.GetItem(Index: integer): TElementStyle;
begin
  Result := TElementStyle(inherited Items[Index]);
end;

procedure TElementStyles.Init;
begin
  FModified := true;
end;

function TElementStyles.Insert(index: integer): TElementStyle;
begin
  Result := TElementStyle(inherited Insert(Index));
  if Assigned(FOwner) then
    FOwner.LoadStyle;
end;

function TElementStyles.IsWordBoundary(ch: char): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 1 to Count do
  begin
    if Items[i - 1].FStyleType = stSymbol then
      if Pos(ch, Items[i - 1].Symbols) > 0 then
      begin
        Result := True;
        Break;
      end;

    if Items[i - 1].FStyleType = stBracket then
      if (ch = Items[i - 1].BracketEnd) or (ch = Items[i - 1].BracketStart)
        then
      begin
        Result := True;
        Break;
      end;
  end;
end;

procedure TElementStyles.SetItem(Index: integer; const Value: TElementStyle);
begin
  inherited Items[Index] := Value;
  if Assigned(FOwner) then
    FOwner.LoadStyle;
end;

procedure TElementStyles.Update(Item: TCollectionItem);
begin
  inherited;
  if Assigned(Item) then
  begin
    if Assigned(FOwner) then
      FOwner.LoadStyle;
  end;
end;

{ TElementStyle }

procedure TElementStyle.Changed;
begin
  TElementStyles(GetOwner).Update(Self);
end;

constructor TElementStyle.Create(Collection: TCollection);
begin
  inherited;
  FKeyWords := TStringList.Create;
  FFont := TFont.Create;
  FFont.Name := 'Courier New';
  FFont.Style := [];
  if Assigned(TElementStyles(GetOwner).FOwner) then
    FBGColor := TElementStyles(GetOwner).FOwner.BkColor
  else
    FBGColor := clWhite;
  FFont.Color := clblack;
  FFont.Size := 8;
  FStyleType := stKeyword;
  StyleNo := -1;
{$IFDEF TMSCLX}
  FBracket := ' ';
{$ENDIF}
{$IFNDEF TMSCLX}
  FBracketEnd := #0;
  FBracketStart := #0;
{$ENDIF}
end;

destructor TElementStyle.Destroy;
begin
  TElementStyles(GetOwner).FModified := True;
  FKeyWords.Free;
  FFont.Free;
  inherited;
end;

(*
function TElementStyle.GetBracket: Char;
begin
Result := FBracketStart;

{$IFDEF TMSCLX}
if Result = ' ' then
  Result := #0;
{$ENDIF}
end; *)

procedure TElementStyle.SetBracketStart(const Value: char);
begin
{$IFDEF TMSCLX}
  if Value = #0 then
    FBracketStart := ' '
  else
    FBracketStart := Value;
{$ENDIF}

{$IFNDEF TMSCLX}
  FBracketStart := Value;
{$ENDIF}
  Changed;
end;

procedure TElementStyle.SetBracketEnd(const Value: char);
begin
{$IFDEF TMSCLX}
  if Value = #0 then
    FBracketEnd := ' '
  else
    FBracketEnd := Value;
{$ENDIF}

{$IFNDEF TMSCLX}
  FBracketEnd := Value;
{$ENDIF}
  Changed;
end;

function TElementStyle.GetBracketStart: Char;
begin
  Result := FBracketStart;

{$IFDEF TMSCLX}
  if Result = ' ' then
    Result := #0;
{$ENDIF}
end;

(*
procedure TElementStyle.SetBracket(const Value: char);
begin
{$IFDEF TMSCLX}
if Value = #0 then
  FBracketStart := ' '
else
  FBracketStart := Value;
{$ENDIF}

{$IFNDEF TMSCLX}
FBracketStart := Value;
{$ENDIF}
Changed;
end; *)

function TElementStyle.GetBracketEnd: Char;
begin
  Result := FBracketEnd;

{$IFDEF TMSCLX}
  if Result = ' ' then
    Result := #0;
{$ENDIF}
end;


procedure TElementStyle.SetSymbols(const Value: string);
begin
  FSymbols := Value;
  Changed;
end;

procedure TElementStyle.SetColorbg(const Value: Tcolor);
begin
  FBGColor := Value;
  Changed;
end;

procedure TElementStyle.SetStyleType(const Value: TStyleType);
begin
  FStyleType := Value;
  Changed;
end;

procedure TElementStyle.SetFont(const Value: Tfont);
begin
  FFont.Assign(Value);
  Changed;
end;

procedure TElementStyle.SetKeyWords(const Value: TStringList);
begin
  FKeyWords.Assign(Value);
  Changed;
end;

procedure TAdvMemo.AdvSyntaxMemoChange(Sender: TObject);
begin
  invalidate;
end;

procedure TAdvMemo.AdvSyntaxMemoGutterClick(Sender: TObject;
  LineNo: integer);
begin
  CurY := LineNo;
end;

function TAdvCustomMemo.FormatLineNumber(var Position: integer; Line: integer): string;
var
  strCurLine: string;
begin
  strCurLine := IntToStr(Line);
  if fGutter.fShowLeadingZeros then
  begin
    while Length(strCurLine) < FGutter.FDigitCount do
      strCurLine := '0' + strCurLine;
  end;
  Position := FGutter.GutterWidth - FGutter.GutterMargin;
  case Length(strCurLine) + 1 of
    2: Position := Position + 24;
    3: Position := Position + 16;
    4: Position := Position + 8;
  end; { case }
  Result := strCurLine;
end;

procedure TAdvMemo.AdvSyntaxMemoGutterDraw(Sender: TObject;
  ACanvas: TCanvas; LineNo: integer; rct: TRect);
var
  XC, AcLineNo: integer;
  TmpBrushStyle: TBrushStyle;
  AStr: string;
begin
  if not CodeFolding.Enabled then
    AcLineNo := LineNo
  else
    AcLineNo := VisIndexToLineIndex(LineNo);
    
  with rct, ACanvas, FMarkerList do
  begin
    if HasMarkers then
      if Markers.MarkerAtLine(AcLineNo) then
      begin
        FMarkerImage.Assign(nil);

        if FUseDefaultMarkerImageIndex then
        begin //use default imageindex if an imagelist is specified
          if (fDefaultMarkerImageIndex > -1) and (Assigned(FMarkerImageList)) then
          begin //as long as an imagelist is specified and index chosen for marker //
            MarkerImageList.GetBitmap(fDefaultMarkerImageIndex, FMarkerImage);
            FMarkerImage.Transparent := true;

            FMarkerImageList.Draw(Canvas, Left + 1, Top + 2, fDefaultMarkerImageIndex);
          end;
        end
        else begin
          XC := Markers.GetMarkerImageIndex(AcLineNo); //get the imageindex of the marker to draw
          if (XC > -1) and (Assigned(FMarkerImageList)) then
          begin //as long as an imagelist is specified and index chosen for marker //
            MarkerImageList.GetBitmap(XC, FMarkerImage);
            FMarkerImage.Transparent := true;

            FMarkerImageList.Draw(Canvas, Left + 1, Top + 2, XC);
          end;
        end;
    //Draw(Left + 1, Top + 2, FMarkerImage);

        Left := Left + 16;
      end;

    if GetBookmark(AcLineNo) then
    begin
      FBookMarkBMP.Transparent := true;
      ACanvas.Draw(Left, Top, FBookMarkBMP);
    end;

    if FGutter.FShowLineNumbers then
    begin
      TmpBrushStyle := Brush.Style;
      Brush.Style := bsClear;

      ACanvas.Font.Assign(FGutter.Font);
      ACanvas.Font.Color := fGutter.fLineNumberTextColor;
      AStr := FormatLineNumber(XC, AcLineNo + FGutter.FLineNumberStart) + FGutter.NumberSuffix;
      TextOut(XC, TOP, AStr);
      Brush.Style := TmpBrushStyle;

      ACanvas.Font.Assign(self.Font);
    end;

    if (AcLineNo < InternalLines.Count) or ((InternalLines.Count = 0) and (AcLineNo = 0)) then
    begin
      if Gutter.ShowModified then
      begin
        if LineModified[AcLineNo] then
          Brush.Color := FGutter.ModifiedColor
        else
          Brush.Color := FGutter.ModifiedColorBkg;

        if Brush.Color <> clNone then
          ACanvas.FillRect(Rect(Right - 4, Top, Right, Bottom));
      end;

      if Executable[AcLineNo] then
      begin
        Brush.Color := clBlue;
        Pen.Color := clNavy;
        ACanvas.Ellipse(Left + 5, Top + 8, Left + 9, Top + 12);
        Pen.Color := clAqua;
        Pen.Width := 1;
        ACanvas.MoveTo(Left + 6, Top + 8);
        ACanvas.LineTo(Left + 4, Top + 10);
      end;

      if BreakPoint[AcLineNo] then
      begin
        Brush.Color := clRed;
        Pen.Color := clBlack;
        ACanvas.Ellipse(Left + 2, Top + 4, Left + 12, Top + 14);
      end;

      if ((AcLineNo) = GetWrappedLineIndex(ActiveLine)) and (FActiveLineSettings.FShowActiveLineIndicator) then
      begin
        Brush.Color := clLime;
        Pen.Color := clGray;
        Polygon([Point(Left + 13, Top + 7), Point(Left + 13, Top + 11),
        Point(Left + 16, Top + 11),
        Point(Left + 16, Top + 14), Point(Left + 21, Top + 9),
        Point(Left + 16, Top + 4),
        Point(Left + 16, Top + 7)]);
      end;

    end;
  end;
end;



function TElementStyle.GetDisplayName: string;
begin
  if Info <> '' then
    Result := Info
  else
    Result := inherited GetDisplayName;
end;

procedure TElementStyle.Assign(Source: TPersistent);
begin
  if Source is TElementStyle then
  begin
    KeyWords.Assign(TElementStyle(Source).KeyWords);
    Font.Assign(TElementStyle(Source).Font);
    BGColor := TElementStyle(Source).BGColor;
    StyleType := TElementStyle(Source).StyleType;
    BracketStart := TElementStyle(Source).BracketStart;
    BracketEnd := TElementStyle(Source).BracketEnd;
    Symbols := TElementStyle(Source).Symbols;
    Info := TElementStyle(Source).Info;
  end;
end;

procedure TAdvCustomMemoStyler.SetStyles(const Value: TElementStyles);
begin
  FAllStyles.Assign(Value);
  Update;
end;


constructor TAdvCustomMemoStyler.Create(AOwner: TComponent);
begin
  inherited;

  FAllStyles := TElementStyles.Create(Self);
  FCommentStyle := TCharStyle.Create;
  FlistAuto := TStringList.Create;
  FHintParameter := THintParameter.Create;

  with FCommentStyle do
  begin
    TextColor := clSilver;
    BkColor := clWhite;
    Style := [fsItalic];
  end;

  FNumberStyle := TCharStyle.Create;
  with FNumberStyle do
  begin
    TextColor := clNavy;
    BkColor := clWhite;
    Style := [fsBold];
  end;

  FNumericChars := '+-.0123456789';
  FHexIdentifier := '';
  FLiteral := '';

  FRegionDefinitions := TRegionDefinitions.Create(self);
end;

destructor TAdvCustomMemoStyler.Destroy;
begin
  FlistAuto.free;
  FNumberStyle.Free;
  FCommentStyle.Free;
  FAllStyles.Free;
  fHintParameter.free;
  FRegionDefinitions.Free;
  inherited;
end;

procedure TAdvCustomMemoStyler.SetStyle(const Index: integer;
  const Value: TCharStyle);
begin
  case Index of
    1: FCommentStyle := Value;
    2: FNumberStyle := Value;
  end;
end;



procedure TAdvMemo.LoadStyle;
begin
end;



procedure TAdvCustomMemoStyler.Update;
begin
  if Assigned(FAllStyles.FOwner) then
    FAllStyles.FOwner.loadstyle;
end;

procedure TAdvCustomMemoStyler.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FAllStyles.FOwner) then
  begin
    if assigned(FAllStyles) then
    begin
      FAllStyles.FOwner := nil;
    end;
  end;
  inherited;
end;

procedure TAdvCustomMemoStyler.DrawKeyword(Canvas: TCanvas;
  AKeyword: string; var ARect: TRect);
begin

end;

procedure TAdvCustomMemoStyler.Loaded;
begin
  inherited;
  if not FAllStyles.FModified then
    FAllStyles.Clear;
  Update;
end;

procedure TAdvMemo.Loaded;
begin
  inherited;
  if (FMemoSource <> nil) and not (csDesigning in ComponentState) then
    FMemoSource.SetMemo(Self);

  if AutoThemeAdapt and not (csDesigning in ComponentState) then
    ThemeAdapt;

  LoadStyle;
  SetMaxLength;
  ResizeScrollBars(True);
end;


function TAdvMemo.IsWordBoundary(ch: char): boolean;
begin
  Result := inherited IsWordBoundary(ch);

  if (Assigned(InternalStyles)) and (UseStyler) then
    Result := Result or InternalStyles.FAllStyles.IsWordBoundary(ch);
end;

procedure TAdvMemo.RefreshMemo;
begin
  curx := curx;
  cury := cury;
  SetMaxLength;
  ResizeScrollBars(False);
  Invalidate;
  if WordWrap <> wwNone then
    UpdateWrap;
end;

procedure TAdvCustomMemo.SetActiveLine(const Value: integer);
var
  r: TRect;
begin
  FActiveLine := Value;
  if ActiveLineSettings.ShowActiveLineIndicator and not ActiveLineSettings.ShowActiveLine and Gutter.Visible then
  begin
    r := Rect(0, 0, Gutter.Width, Height);

{$IFNDEF TMSDOTNET}
    InvalidateRect(Handle, @r, False);
{$ENDIF}
{$IFDEF TMSDOTNET}
    InvalidateRect(Handle, R, False);
{$ENDIF}
  end;

  if ActiveLineSettings.ShowActiveLine then
  begin
    MakeVisible;

    if (FActiveLine > TopLine + VisibleLineCount) or (FActiveLine < TopLine) then
       TopLine := Max((Value - VisibleLineCount div 2), 0); // make sure setting active line makes it visible
      
    r := ClientRect;
{$IFNDEF TMSDOTNET}
    InvalidateRect(Handle, @r, False);
{$ENDIF}
{$IFDEF TMSDOTNET}
    InvalidateRect(Handle, R, False);
{$ENDIF}
  end;
end;

procedure TAdvCustomMemo.SetMemoChecker(const AMemoChecker: TAdvMemoChecker);
begin
  FMemoChecker := AMemoChecker;
  if Assigned(FMemoChecker) then
    FMemoChecker.Memo := self;
end;

procedure TAdvCustomMemo.SetAutoCompletionListImages(IL: TImageList);
begin
  FAutoCompletionListImages := IL;
  FListCompletion.ImageList := IL;
end;

procedure TAdvCustomMemo.UpdateGutter;
begin
  if FBorderStyle = bsSingle then
  begin
    if Ctl3D then
    begin
      FGutter.Left := 2;
      FGutter.Top := 2;
      FGutter.Width := FGutter.GutterWidth;
    end
    else
    begin
      FGutter.Left := 1;
      FGutter.Top := 1;
      FGutter.Width := FGutter.GutterWidth;
    end;
  end
  else
  begin
    FGutter.Left := 0;
    FGutter.Top := 0;
    FGutter.Width := FGutter.GutterWidth + 2;
  end;
end;

procedure TAdvCustomMemo.SetBorderStyle(const Value: TBorderStyle);
begin
  FBorderStyle := Value;

  UpdateGutter;
  Invalidate;
end;

procedure TAdvCustomMemo.SetCtl3D(const Value: boolean);
begin
  FCtl3D := Value;
  UpdateGutter;
  Invalidate;
end;


procedure TAdvCustomMemo.SetLeftCol(const Value: integer);
begin
  if FLeftCol >= 0 then
  begin
    if (FLeftCol <> Value) then
    begin
      FLeftCol := Value;
      sbHorz.Position := FLeftCol;
      Invalidate;
      if Assigned(FOnTopLeftChanged) then
        FOnTopLeftChanged(self);
    end;
  end;
end;

procedure TAdvCustomMemo.SetMemoStyler(Value: TAdvCustomMemoStyler);
var
  i, j: Integer;
begin
  FInternalStyles := Value;
  if Value <> nil
    then FUseStyler := true
  else FUseStyler := false;

  if Value <> nil then
  begin
    Value.FreeNotification(Self);
    FInternalStyles.FAllStyles.FOwner := TAdvMemo(Self);

    for i := 1 to FInternalStyles.FAllStyles.Count do
    begin
      if FInternalStyles.FAllStyles[i - 1].StyleType = stKeyword then
      begin
        FInternalStyles.FAllStyles[i - 1].KeyWords.Sorted := False;

        if not CaseSensitive then
          for j := 1 to FInternalStyles.FAllStyles[i - 1].KeyWords.Count do
          begin
            FInternalStyles.FAllStyles[i - 1].KeyWords.Strings[j - 1] := AnsiLowerCase(FInternalStyles.FAllStyles[i - 1].KeyWords.Strings[j - 1]);
          end;
        FInternalStyles.FAllStyles[i - 1].KeyWords.Sorted := true;
      end;
    end;
  end;

  FCachedDelimiters := '';
  FbackupTopLine := -1;
//  SetTopLine(0);
  Invalidate;
end;

procedure TAdvCustomMemo.SetWordWrap(const Value: TWordWrapStyle);
begin
  if Value = wwNone then
    UndoWrap;

  FWordWrap := Value;

  if Value <> wwNone then
    DoWrap;
end;

procedure TAdvCustomMemo.SetTopLine(const Value: integer);
var
  nv, LinesCount: Integer;
  newval: Boolean;
  WasVisible: boolean;

begin
  newval := FTopLine <> Value;

  //if not CodeFolding.Enabled then
    LinesCount := InternalLines.Count
  //else
    ;//LinesCount := LineIndexToVisIndex(InternalLines.Count-1);

  if (VisibleLineCount > LinesCount) then
  begin
    CurY := 0;
    CurX := 0;
    Exit;
  end;

  if (Value >= 0) and (Value + VisibleLineCount < LinesCount) then
  begin
    FTopLine := Value;
    if not FCodeFolding.Enabled then
      sbVert.Position := FTopLine
    else
      sbVert.Position := LineIndexToVisIndex(FTopLine);
    Invalidate;
  end
  else
    if (Value >= 0) then
    begin
      if not FCodeFolding.Enabled then
      begin
        nv := LinesCount - (VisibleLineCount div 2);
        if nv < 0 then
          nv := 0;
        FTopLine := nv;
        sbVert.Position := FTopLine;
      end
      else
      begin
        nv := LineIndexToVisIndex(InternalLines.Count-1) - VisibleLineCount + 1;
        nv := VisIndexToLineIndex(nv);
        if nv < 0 then
          nv := 0;
        FTopLine := nv;
        sbVert.Position := LineIndexToVisIndex(FTopLine);
      end;
      Invalidate;
    end;

  WasVisible := FCaretVisible;

  if (CurY >= TopLine) and (CurY <= TopLine - VisibleLineCount) then
    MakeVisible;

  if WasVisible then
    ShowCaret(True);

  if newval and Assigned(FOnTopLeftChanged) then
    FOnTopLeftChanged(self);
end;

{$IFDEF DELPHI5_LVL}
{$IFNDEF TMSCLX}
procedure TAdvCustomMemo.WndProc(var Message: TMessage);
begin
  if (csDestroying in ComponentState) then
  begin
    inherited;
    Exit;
  end;  

  inherited;

  if (Message.Msg = WM_THEMECHANGED) and AutoThemeAdapt then
    ThemeAdapt;

  if (Message.Msg = CM_SYSFONTCHANGED) and AutoThemeAdapt then
    ThemeAdapt;

  if (Message.Msg = WM_COPY) then
    CopyToClipBoard
  else
    if (Message.Msg = WM_CUT) then
      CutToClipBoard
    else
      if (Message.Msg = WM_PASTE) then
        PasteFromClipBoard
{$IFNDEF TMSDOTNET}
      else
        if (Message.Msg = EM_GETSEL) then
        begin
          PInteger(Message.WParam)^ := SelStart;
          PInteger(Message.LParam)^ := SelStart + SelLength;
        end;


{$ENDIF}

end;

function TAdvCustomMemo.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): boolean;
var
  LinesCount: Integer;
begin
  inherited DoMousewheelDown(Shift, MousePos);

  if not CodeFolding.Enabled then
    LinesCount := InternalLines.Count
  else
    LinesCount := LineIndexToVisIndex(InternalLines.Count);

  if (LineIndexToVisIndex(TopLine) + VisibleLineCount < LinesCount) then
  begin
    if not CodeFolding.Enabled then
      TopLine := FTopLine + 4
    else
      TopLine := VisIndexToLineIndex(LineIndexToVisIndex(FTopLine) + 4);
  end;

  ShowCaret(true);

  Result := true;
end;

function TAdvCustomMemo.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): boolean;
var
  LinesCount: Integer;
begin
  inherited DoMousewheelUp(Shift, MousePos);

  if not CodeFolding.Enabled then
    LinesCount := InternalLines.Count
  else
    LinesCount := LineIndexToVisIndex(InternalLines.Count-1);

  if LineIndexToVisIndex(TopLine) > 4 then
  begin
    if not CodeFolding.Enabled then
      TopLine := TopLine - 4
    else
      TopLine := VisIndexToLineIndex(LineIndexToVisIndex(TopLine) - 4);
  end
  else
    if LinesCount > VisibleLineCount then
    begin
      TopLine := 0;
    end;

  ShowCaret(true);

  Result := true;
end;
{$ENDIF}
{$ENDIF}


procedure TAdvCustomMemo.SetUrlAware(const Value: boolean);
begin
  if FUrlAware <> Value then
  begin
    FUrlAware := Value;
    invalidate;
  end;
end;

procedure TAdvCustomMemo.TestforURLClick(s: string);
var
  i, x, locx: integer;
  urls: TStringList;
begin
  if not FUrlAware then exit;
  urls := TStringList.Create;
  ExtractURL(s, urls);
  x := 0;
  locx := curx;
  for i := 0 to urls.Count - 1 do
  begin
    if (x <= locx) and (x + length(urls[i]) > locX) then
    begin
      if WordIsURL(urls[i]) then
        if Assigned(FOnURLClick) then
        begin
          FOnURLClick(self, urls[i]);
        end
        else
        {$IFNDEF TMSDOTNET}
          ShellExecute(0,'open',PChar(urls[i]),nil,nil,SW_NORMAL);
        {$ENDIF}
        {$IFDEF TMSDOTNET}
          ShellExecute(0,'open',urls[i],'','',SW_NORMAL);
        {$ENDIF}
    end;
    x := x + length(urls[i]);
  end;
  urls.Free;
end;

procedure TAdvCustomMemo.SetUrlStyle(const Value: TCharStyle);
begin
  FUrlStyle := Value;
  inherited;
end;

procedure TAdvCustomMemo.ExtractURL(s: string; var urls: TStringList);
var
  s1: string;
  txt, i: integer;
  lit: char;
begin
  if not Assigned(urls) then
    Exit;

  urls.Clear;

  if not FUrlAware then
  begin
    urls.Add(s);
    Exit;
  end;

  s1 := '';
  if (Assigned(InternalStyles)) and (UseStyler) then
    s1 := InternalStyles.Literal;

  if length(s1) > 0 then
    lit := s1[1]
  else
    lit := #0;

  txt := -1;
  s1 := '';
  i := 1;
  while i <= length(s) do
  begin
    if s[i] = lit then
    begin
      s1 := s1 + s[i];
      inc(i);
      if i <= length(s) then
      begin
        s1 := s1 + s[i];
        inc(i);
      end;
      continue;
    end;

    if AnsiPos(s[i], Furldelimiters) > 0 then
    begin
      if txt = 0 then
      begin
        urls.Add(s1);
        s1 := '';
      end;
      txt := 1;
      s1 := s1 + s[i];
    end
    else
    begin
      if txt = 1 then
      begin
        urls.Add(s1);
        s1 := '';
      end;
      txt := 0;
      s1 := s1 + s[i];
    end;
    inc(i);
  end;
  if s1 <> '' then urls.Add(s1);
end;

function TAdvCustomMemo.TestforURLMove(s: string; locx: integer): boolean;
var
  i, x: integer;
  urls: TStringList;
begin
  if not FUrlAware then
  begin
    Result := False;
    Exit;
  end;

  urls := TStringList.Create;
  ExtractURL(s, urls);
  x := 0;
  Result := False;
  for i := 0 to urls.Count - 1 do
  begin
    if (x <= locx) and (x + length(urls[i]) > locX) then
    begin
      if WordIsUrl(urls[i]) then
      begin
        Result := True;
      end;
    end;
    x := x + length(urls[i]);
  end;
  urls.Free;
end;

procedure TAdvCustomMemo.ScrollHChange(Sender: TObject);
var
  delta: integer;
begin
  if not sbHorz.Visible then
    Exit;
{$IFNDEF TMSCLX}
  delta := sbHorz.Max - sbHorz.PageSize + 1;
  if (sbHorz.Position > delta) and (sbHorz.PageSize > 0) then
    sbHorz.Position := delta + 1;
{$ENDIF}
{$IFDEF TMSCLX}
  sbHorz.Position := delta + 1;
{$ENDIF}

  FLeftCol := sbHorz.Position;
  if Assigned(FOnTopLeftChanged) then
    FOnTopLeftChanged(self);
end;

procedure TAdvCustomMemo.ScrollVChange(Sender: TObject);
var
  delta: integer;
begin
  if not sbVert.Visible then
    Exit;
{$IFNDEF TMSCLX}
  delta := sbVert.Max - sbVert.PageSize + 1;
  if (sbVert.Position > delta) and (sbVert.PageSize > 0) then
    sbVert.Position := delta;
{$ENDIF}
{$IFDEF TMSCLX}
  sbVert.Position := delta + 1;
{$ENDIF}

  if not CodeFolding.Enabled then
    FTopLine := sbVert.Position
  else
    FTopLine := VisIndexToLineIndex(sbVert.Position);

{$IFDEF TMSDEBUG}
  outputdebugstring(pchar('vscrollchange:' + inttostr(FTopLine)));
{$ENDIF}

  if Assigned(FOnTopLeftChanged) then
    FOnTopLeftChanged(self);
end;

function TAdvCustomMemo.FindText(SearchStr: string; Options: TFindOptions): integer;
var
  i, j, cit: integer;
  s: string;

  function compareLinetext: integer;
  var
    position: integer;
  begin
    if frMatchCase in Options then
    begin
      if frDown in Options then position := ansipos(SearchStr, s)
      else
        position := ansiRPos(SearchStr, s);
    end
    else
    begin
      if frDown in Options then position := ansipos(LowerCase(SearchStr), LowerCase(s))
      else
        position := ansiRPos(LowerCase(SearchStr), LowerCase(s));
    end;

    Result := position;
    if (frWholeWord in Options) and (position > 0) then
    begin
      if length(s) = position + length(SearchStr) - 1 then
      begin
        if position = 1 then
          Exit;
        if s[position - 1] = #32 then
          Exit;
      end;

      if (position = 1) and (s[length(SearchStr) + 1] = #32) then
        Exit;


      if (s[position - 1] = #32) and (s[length(SearchStr) + position] = #32) then
        Exit;

      Result := 0;
    end;
  end;

  procedure nextline;
  begin
    if frDown in Options then inc(i)
    else
      dec(i);
  end;

begin
  Result := -1;
  if SearchStr = '' then
    Exit;

  i := CurY;
  cit := 0;

  while (i <= InternalLines.Count - 1) and (i >= 0) do
  begin
  //s := InternalLines[i];
    s := TrimRightWW(i);

    if (i = FSelStartY) and
      (FSelStartY = FSelEndY) then
    begin
      if frDown in Options then
      begin
        if FSelEndX >= length(s) then
        begin
          nextline;
          Continue;
        end;
        Delete(s, 1, FSelEndX);
        cit := FSelEndX;
      end
      else
      begin
        Delete(s, FSelStartX + 1, (length(s) - FSelStartX));
        cit := -(length(s) - FSelStartX);
      end;
    end
    else
      cit := 0;

    j := compareLinetext;
    if j > 0 then
    begin
      CurY := i;
      Curx := (j - 1) + cit;

      FSelStartX := Curx;
      FSelEndX := Curx + Length(SearchStr);
      FSelStartY := CurY;
      FSelEndY := CurY;

      Result := GetSelStart;
      Invalidate;
      Exit;
    end;
    nextline;
  end;

  FSelStartX := 0;
  FSelStartY := 0;
  FSelEndX := 0;
  FSelEndY := 0;
  Invalidate;
end;

function TAdvCustomMemo.FindAndReplace(SearchStr, NewStr: string; Options: TFindOptions): integer;
var
  rz,oldrz,count: integer;
begin
  oldrz := -1;
  count := 0;

  repeat
    rz := FindText(SearchStr, Options);
    if rz = oldrz then Break;
    oldrz := rz;
    if (rz > -1) then
    begin
      Selection := NewStr;
      inc(count);
    end;  
  until rz = -1;

  Result := count;
end;


function TAdvCustomMemo.FindTextPos(SearchStr: string; Options: TFindOptions): integer;
var
  i, j, cit: integer;
  s: string;

  function compareLinetext: integer;
  var
    position: integer;
  begin
    if frMatchCase in Options then
    begin
      if frDown in Options then position := ansipos(SearchStr, s)
      else
        position := ansiRPos(SearchStr, s);
    end
    else
    begin
      if frDown in Options then
        position := ansipos(LowerCase(SearchStr), LowerCase(s))
      else
        position := ansiRPos(LowerCase(SearchStr), LowerCase(s));
    end;

    Result := position;
    if (frWholeWord in Options) and (position > 0) then
    begin
      if length(s) = position + length(SearchStr) - 1 then
      begin
        if position = 1 then
          Exit;
        if s[position - 1] = #32 then
          Exit;
      end;

      if (position = 1) and (s[length(SearchStr) + 1] = #32) then
        Exit;
      if (s[position - 1] = #32) and (s[length(SearchStr) + 1] = #32) then
        Exit;

      Result := 0;
    end;
  end;

  procedure NextLine;
  begin
    if frDown in Options then inc(i)
    else
      dec(i);
  end;

begin
  Result := -1;
  if SearchStr = '' then
    Exit;

  i := CurY;
  cit := 0;

  while (i <= InternalLines.Count - 1) and (i >= 0) do
  begin
  //s := InternalLines[i];
    s := TrimRightWW(i);
    if (i = FSelStartY) and
      (FSelStartY = FSelEndY) then
    begin
      if frDown in Options then
      begin
        if FSelEndX >= length(s) then
        begin
          nextline;
          Continue;
        end;
        Delete(s, 1, FSelEndX);
        cit := FSelEndX;
      end
      else
      begin
        Delete(s, FSelStartX + 1, (length(s) - FSelStartX));
        cit := -(length(s) - FSelStartX);
      end;
    end
    else
      cit := 0;

    j := compareLinetext;
    if j > 0 then
    begin
      TextFromPos((j - 1) + cit, i, Result);
      Exit;
    end;
    NextLine;
  end;
end;


function TAdvMemoStrings.GetRealCount: integer;
begin
  if (Text = '') or (Text = #13#10) then
    Result := 0
  else
    Result := inherited Count;
end;

function TAdvMemoStrings.GetTextEx: string;
begin
  Result := inherited Text;
end;

function TAdvMemoStrings.AddObject(const S: string; AObject: TObject): Integer;
var
  P: TObject;
begin
  P := TLineProp.Create;
  (P as TLineProp).FObject := AObject;
  FLinesProp.Add(p);
  Result := inherited AddObject(S,P);
  FListLengths.Add(length(s));
end;


function TAdvMemoStrings.Add(const S: string): integer;
var
  sz,sc: string;
  p: integer;
begin

  if not Assigned(Memo) then
  begin
    Result := inherited Add(s);
    //FListLengths.Add(length(sz));
  end
  else
  begin
    sz := StringReplace(s, #9, StringOfChar(#32, memo.tabsize), [rfreplaceall]);
    sz := StringReplace(sz, #10, '', [rfreplaceall]);

    while pos(#13,sz) > 0 do
    begin
      p := pos(#13,sz);
      sc := copy(sz,1,p-1);
      inherited Add(sc);
      sz := Copy(sz,p+1,length(sz));
    end;

    Result := inherited Add(sz);
    {$IFNDEF DELPHI6_LVL}
    FListLengths.Add(length(sz));
    {$ENDIF}
    //if not (csLoading in Memo.ComponentState) then
    //  Memo.LinesChanged(nil);
  end;
end;

{ TAdvMemoFindDialog }

constructor TAdvMemoFindDialog.Create(AOwner: TComponent);
begin
  inherited;
  FindDialog := TFindDialog.Create(nil);
  FindDialog.OnFind := Find;
  FindDialog.OnClose := Close;
  FDisplayMessage := True;
  FNotFoundMessage := 'Finished searching the document. The search item was not found.';
  FFocusMemo := true;
end;

destructor TAdvMemoFindDialog.Destroy;
begin
  FindDialog.Free;
  inherited;
end;

function TAdvMemoFindDialog.GetFindOptions: TFindOptions;
begin
  Result := FindDialog.Options;
end;

function TAdvMemoFindDialog.GetFindText: string;
begin
  Result := FindDialog.FindText;
end;

procedure TAdvMemoFindDialog.CloseDialog;
begin
  FindDialog.CloseDialog;
end;

procedure TAdvMemoFindDialog.Execute;
var
  p: TPoint;
begin
  if Assigned(FAdvMemo) then
  begin
    FAdvMemo.FSelStartX := 0;
    FAdvMemo.FSelStartY := 0;
    FAdvMemo.FSelEndX := 0;
    FAdvMemo.FSelEndY := 0;
    FAdvMemo.Searching := True;
    FindDialog.FindText := FFindText;
    p := Point(FAdvMemo.Left, FAdvMemo.top);
    p := FAdvMemo.ClientToScreen(p);
    if not PointInRect(p, rect(0, 0, Screen.DeskTopWidth, Screen.DeskTopHeight)) then
      p := point(0, 0);
    FindDialog.Position := p;
    FindDialog.Execute;
  end
  else
    raise Exception.Create('No memo assigned.');
end;

procedure TAdvMemoFindDialog.Close(Sender: TObject);
begin
  if Assigned(FAdvMemo) then
    FAdvMemo.Searching := False;
end;

procedure TAdvMemoFindDialog.Find(Sender: TObject);
var
  rz: Integer;
begin
  if not Assigned(FAdvMemo) then
    Exit;
  rz := FAdvMemo.FindText(FindDialog.FindText, FindDialog.Options);
  if (rz = -1) then
  begin
    if (FDisplayMessage) then
      MessageDlg(Format(FNotFoundMessage, [FindDialog.FindText]), mtInformation, [mbOK], 0);

    if Assigned(OnFindDone) then
      OnFindDone(Self);
  end
  else
  begin
    if FocusMemo then
      FAdvMemo.SetFocus;
    if Assigned(OnFindText) then
      OnFindText(Self);
  end;
end;

procedure TAdvMemoFindDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FAdvMemo) then
    FAdvMemo := nil;
  inherited;
end;

{ TAdvMemoFindReplaceDialog }

constructor TAdvMemoFindReplaceDialog.Create(AOwner: TComponent);
begin
  inherited;
  ReplaceDialog := TReplaceDialog.Create(nil);
  ReplaceDialog.OnFind := Find;
  ReplaceDialog.OnClose := Close;
  ReplaceDialog.OnReplace := Replace;
  FDisplayMessage := True;
  FNotFoundMessage := 'Text not found';
  FFocusMemo := True;
end;

destructor TAdvMemoFindReplaceDialog.Destroy;
begin
  ReplaceDialog.Free;
  inherited;
end;

function TAdvMemoFindReplaceDialog.GetReplaceText: string;
begin
  Result := ReplaceDialog.ReplaceText;
end;

function TAdvMemoFindReplaceDialog.GetFindText: string;
begin
  Result := ReplaceDialog.FindText;
end;

function TAdvMemoFindReplaceDialog.GetFindOptions: TFindOptions;
begin
  Result := ReplaceDialog.Options;
end;

procedure TAdvMemoFindReplaceDialog.CloseDialog;
begin
  ReplaceDialog.CloseDialog;
end;

procedure TAdvMemoFindReplaceDialog.Execute;
var
  p: TPoint;
begin
  if Assigned(FAdvMemo) then
  begin
    FAdvMemo.FSelStartX := 0;
    FAdvMemo.FSelStartY := 0;
    FAdvMemo.FSelEndX := 0;
    FAdvMemo.FSelEndY := 0;
    ReplaceDialog.FindText := FFindText;
    ReplaceDialog.ReplaceText := FReplaceText;
    p := Point(FAdvMemo.Left, FAdvMemo.top);
    p := FAdvMemo.ClientToScreen(p);
    if not PointInRect(p, rect(0, 0, Screen.DesktopWidth, Screen.DesktopHeight)) then
      p := point(0, 0);
    ReplaceDialog.Position := p;
    FAdvMemo.Searching := True;
    ReplaceDialog.Execute;
  end
  else
    raise Exception.Create('No memo assigned.');
end;

procedure TAdvMemoFindReplaceDialog.Close(Sender: TObject);
begin
  if Assigned(FAdvMemo) then
  begin
    FAdvMemo.Searching := False;
  end;
end;

procedure TAdvMemoFindReplaceDialog.Find(Sender: TObject);
var
  rz: integer;
begin
  if not Assigned(FAdvMemo) then
    Exit;
  rz := FAdvMemo.FindText(ReplaceDialog.FindText, ReplaceDialog.Options);
  if (rz = -1) then
  begin
    if (FDisplayMessage) then
      MessageDlg(Format(FNotFoundMessage, [ReplaceDialog.FindText]), mtInformation, [mbOK], 0);

    if Assigned(OnReplaceDone) then
      OnReplaceDone(Self);
  end
  else
    if FocusMemo then
      FAdvMemo.SetFocus;
end;

procedure TAdvMemoFindReplaceDialog.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FAdvMemo) then
  begin
    FAdvMemo := nil;
  end;
  inherited;
end;

procedure TAdvMemoFindReplaceDialog.Replace(Sender: TObject);
var
  rz, oldrz: integer;
begin
  if not Assigned(FadvMemo) then
    Exit;
  with ReplaceDialog do
  begin
    if frReplaceAll in Options then
    begin
      oldrz := -1;
      repeat
      //Cursor := crWait;
        rz := FAdvMemo.FindText(FindText, Options);
        if rz = oldrz then Break;
        oldrz := rz;
        if rz > -1 then
          FAdvMemo.Selection := replacetext;
      until rz = -1;
    //Cursor := crDefault;
    end
    else
    begin
      if FAdvMemo.Selection = '' then
      begin
        rz := FAdvMemo.FindText(FindText, Options);
        FAdvMemo.Invalidate;
        if (rz = -1) and (FDisplayMessage) then
          MessageDlg(Format(FNotFoundMessage, [FindText]), mtInformation, [mbOK], 0);
      end
      else
      begin
        FAdvMemo.Selection := replacetext;
        //Replace(nil);
      end;
    end;
  end;
  FAdvMemo.Invalidate;
end;



{ TlineProp }

constructor TLineProp.Create;
begin
  inherited;
  Executable := False;
  BreakPoint := False;
  Wrapped := False;
  ImageIndex := -1;
  FErrStart := TIntList.Create;
  FErrLen := TIntList.Create;

  FExpanded := True;
  FLastChildOfParents := 0;
  FHasParent := False;
  FHasChildren := False;
end;

destructor TLineProp.destroy;
begin
  FErrStart.Free;
  FErrLen.Free;
  inherited;
end;

procedure TLineProp.SetExpanded(const Value: Boolean);
begin
  FExpanded := Value;
end;

function TLineProp.GetLastChild: Boolean;
begin
  Result := (FLastChildOfParents > 0);
end;

procedure TLineProp.SetLastChildOfParents(Value: integer);
begin
  if (Value >= 0) then
    FLastChildOfParents := Value;
end;

{ TAdvMemoStrings }

procedure TAdvMemoStrings.AddStrings(Strings: TStrings);
var
  i: integer;
begin
  if Assigned(Memo) then
  begin
    inherited AddStrings(Strings);
    FListLengths.Clear;
    for i := 1 to Memo.Lines.Count do
      FListLengths.Add(Length(Memo.Lines[i - 1]));

    if FLockCount = 0 then
      Memo.Refresh;
  end;
end;


procedure TAdvMemoStrings.Assign(Source: TPersistent);
var
  i: Integer;
  cf: boolean;
begin
  if Source is TStrings then
  begin
    if Assigned(Memo) then
    begin
      cf := Memo.CodeFolding.Enabled;
      Memo.CodeFolding.Enabled := false;
      Memo.Clear;
      Memo.FBackupTopLine := -1;
      Memo.SetLines(TAdvMemoStrings(Source));
      FListLengths.Clear;
      for i := 1 to TAdvMemoStrings(Source).Count do
        FListLengths.Add(Length(TAdvMemoStrings(Source)[i - 1]));
      Memo.SetMaxLength;
      Memo.ResizeScrollBars(True);
      Memo.CodeFolding.Enabled := cf;
    end
    else
    begin
      inherited Assign(Source);
      inherited AddStrings(Source as TStrings);
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TAdvMemoStrings.AssignEx(Source: TPersistent);
var
  i: integer;
begin
  if Source is TStrings then
  begin
    if Assigned(Memo) then
    begin
      Memo.FBackupTopLine := -1;

      Memo.InternalLines.ClearStrings; // deletes all the object references!
      Memo.InternalLines.AddStrings(TAdvMemoStrings(Source));

//      Memo.SetLines(TAdvMemoStrings(Source));
      FListLengths.Clear;
      for i := 1 to TAdvMemoStrings(Source).Count do
        FListLengths.Add(Length(TAdvMemoStrings(Source)[i - 1]));
      Memo.SetMaxLength;
    end
    else
      inherited Assign(Source);
  end
  else
    inherited Assign(Source);
end;



procedure TAdvCustomMemoStyler.SetlistAuto(const Value: Tstringlist);
begin
  FListAuto.Assign(Value);
end;

procedure TAdvCustomMemoStyler.SetRegionDefinitions(Value: TRegionDefinitions);
begin
  FRegionDefinitions.Assign(Value);
end;

procedure TAdvCustomMemo.HideForm;
begin
  if FormAutocompletion.Visible then
  begin
    FormAutoCompletion.Hide;
    SetFocus;
  end;
end;

(*
function StripSpaces(s:string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to length(s) do
    if s[i] <> ' ' then
      Result := Result + s[i];
end;
*)

procedure TAdvCustomMemo.ShowForm(ShowAlways: Boolean);
var
  s, method: string;
  i: Integer;
  ab, ae, vp, dw: Integer;
  p: TPoint;
  Show: Boolean;
  token: string;
  gWidth: integer;

begin
  if not AutoCompletion.Active then
    Exit;

  if ReadOnly then
    Exit;

  if (Assigned(InternalStyles)) and (UseStyler) then
  begin
    if InternalStyles.FlistAuto.Count = 0 then
      Exit;
  end
  else
    Exit;

  s := UpperCase(FullWordAtCursor);

  Show := True;

  if Assigned(OnBeforeAutoCompletion) then
    OnBeforeAutoCompletion(Self, s, Show);

  if not Show then
    Exit;

  FAutoCompleteList.Clear;

  if (not FAutoCompleteDot) or (1 > 0) then //don't use the internal list for after dot
  begin
    if (Assigned(InternalStyles)) and (UseStyler) then
    begin
      for i := 1 to InternalStyles.FlistAuto.Count do
      begin
        method := UpperCase(InternalStyles.FlistAuto.Strings[i - 1]);

        vp := pos(' ', method);
        if (vp > 0) then
          Delete(method, 1, vp);

        if (pos(s, method) = 1) or (s = '') then
        begin
          FAutoCompleteList.AddObject(InternalStyles.FlistAuto.Strings[i - 1], InternalStyles.FlistAuto.Objects[i - 1]);
        end;
      end;
    end;
  end;

  DoGetAutoCompletionList(S, FAutoCompleteList);

  if (FAutoCompleteList.Count = 0) then
  begin
    Exit;
  end;

//implement sorting on the main list before we get to the list box (couldn't find a way to customsort a listbox)
  SortingObject := Self;
  try
  //FAutoCompleteList.CustomSort(Self.SortAutoCompletList);
  finally
    SortingObject := nil;
  end;

  if FGutter.FShowGutter then
    gWidth := FGutter.fWidth
  else
    gWidth := 0;

  if FCodeFolding.Enabled and (FCodeFoldingNodeCount > 0) then
    gWidth := gWidth + NODE_WIDTH;

  P := Point(0, 0);
  P := ClientToScreen(P);
  P.X := p.X + gWidth + FCellSize.W * (FCurx - FLeftCol);


  if not FCodeFolding.Enabled then
    P.Y := p.Y + FCellSize.H * (Fcury - FTopLine + 1) + 2
  else
    P.Y := p.Y + FCellSize.H * (LineIndexToVisIndex(Fcury) - LineIndexToVisIndex(FTopLine) + 1) + 2;

  FormAutocompletion.Visible := false;
  {$IFDEF DELPHI9_LVL}
  FormAutocompletion.Width := 0;
  FormAutocompletion.Height := 0;
  {$ELSE}
  FormAutocompletion.Width := FAutoCompletion.Width;
  FormAutocompletion.Height := FAutoCompletion.Height;
  {$ENDIF}
  FormAutocompletion.Left := P.X;
  FormAutocompletion.Top := P.Y;

  FListCompletion.Items.Assign(FAutoCompleteList);
  FListCompletion.Font.Assign(FAutoCompletion.Font);
  FListCompletion.ColorVar := FAutoCompletion.ColorVar;
  FListCompletion.ColorProc := FAutoCompletion.ColorProc;
  FListCompletion.ColorFunc := FAutoCompletion.ColorFunc;
  FListCompletion.ColorProp := FAutoCompletion.ColorProp;
  FListCompletion.ColorEvent := FAutoCompletion.ColorEvent;
  FListCompletion.ColorMethod := FAutoCompletion.ColorMethod;
  FListCompletion.ColorIdentifier := FAutoCompletion.ColorIdentifier;
  FListCompletion.ShowImages := FAutoCompletion.ShowImages;

  if Lines.Count > 0 then
    s := InternalLines[cury]
  else
  begin
    s := '';
    Lines.Add('');
  end;

  ae := Length(s);

  if ae > 0 then
  begin
    for i := curx + 1 to Length(s) do
      if s[i] = #32 then
      begin
        ae := i - 1;
        Break;
      end;
    ab := 1;
    for i := curx + 1 downto 1 do
      if s[i] = #32 then
      begin
        ab := i + 1;
        Break;
      end;
    s := copy(s, ab, ae - ab + 1);

{$IFDEF TMSDEBUG}
    OutputDebugString(pchar('READ FROM CURSOR ' + s));
{$ENDIF}
  end
  else
    s := '';

  SetEventAutoCompletion;

  if Assigned(FOnStartAutoCompletion) then
    FOnStartAutoCompletion(self);

  dw := FListCompletion.AutoAdaptWidth;

  if AutoCompletion.SizeDropDown then
  begin
    FormAutoCompletion.Width := dw
  end;

  FormAutoCompletion.Show;

  {$IFDEF DELPHI9_LVL}
  FormAutoCompletion.Left := P.X;
  FormAutoCompletion.Top := P.Y;
  FormAutocompletion.Width := dw;
  FormAutocompletion.Height := FAutoCompletion.Height;
  {$ENDIF}

  FListCompletion.SetFocus;

  if FAutoCompleteDot then
  begin
    token := TokenAtXY(FDotPoint.X, FDotPoint.Y);
    if token <> '' then
    begin
      UpdateCompletionList(UpperCase(token));
    end
    else
      Flistcompletion.ItemIndex := 0;
  end
  else
    FListCompletion.ItemIndex := 0;
end;

procedure TAdvCustomMemo.hideauto(sender: Tobject);
begin
  if Assigned(FOnCancelAutoCompletion) then
    FOnCancelAutoCompletion(Self);
  HideForm;
end;

procedure TAdvCustomMemo.UpdateCompletionList(token: string);
var
  i, j, vp: Integer;
  method: string;
  dw: Integer;
begin
  FListCompletion.Items.Clear;
  j := -1;

  DoGetAutoCompletionList(token, FAutoCompleteList);

// search cached list rather just the internal styles..

// if the token is not blank then filter based on the token,
// otherwise just filll the list and set the itemindex to the
// first item in the list

  for i := 0 to FAutoCompleteList.Count - 1 do
  begin
    if token <> '' then
    begin
      method := uppercase(FAutoCompleteList.Strings[i]);

      vp := pos(' ', method);
      if vp > 0 then
        Delete(method, 1, vp);

      vp := pos('.', method);
      if vp > 0 then
        Delete(method, 1, vp);

      if pos(token, method) = 1 then
      begin
        flistcompletion.Items.AddObject(FAutoCompleteList.Strings[i], FAutoCompleteList.Objects[i]);
        if j = -1 then
          j := flistcompletion.Items.Count - 1;
      end;
    end
    else
      flistcompletion.Items.AddObject(FAutoCompleteList.Strings[i], FAutoCompleteList.Objects[i]);
  end;
//if the token was empty then set the item index to first item
  if flistcompletion.Items.Count > 0 then
  begin
    if j > -1 then
      flistcompletion.ItemIndex := j
    else
      flistcompletion.ItemIndex := 0;
  end;

  dw := FListCompletion.AutoAdaptWidth;

  if AutoCompletion.SizeDropDown then
  begin
    FormAutoCompletion.Width := dw
  end;

end;

procedure TAdvCustomMemo.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  sEntry, s: string;
  ae, ab, vp, i: integer;

begin
  if FListCompletion.ItemIndex > -1 then
  begin
    sEntry := Flistcompletion.Items[Flistcompletion.ItemIndex];

    if Assigned(FOnInsertAutoCompletionEntry) then
      FOnInsertAutoCompletionEntry(Self, sEntry);

  //check if event handler modified the string, if not then apply std behaviour
    if sEntry = Flistcompletion.Items[Flistcompletion.ItemIndex] then
    begin
    // strip identifier if available
      vp := pos(' ', sEntry);
      if vp > 0 then
        Delete(sEntry, 1, vp);
    //search for the next delimiter, for example ( or ; and stop there
    //so Test(parama : string); becomes Test
      s := '';
      for i := 1 to Length(sEntry) do
      begin
        if not ( (sEntry[i] = '(') or (sEntry[i] = ';') or (sEntry[i] = ' ')) then
          s := s + sEntry[i]
        else
          break;
      end;
      sEntry := s;
    end;

    FSelStartY := CurY;
    FSelEndY := CurY;

    if FAutoCompleteDot and (Pos('.', sEntry) = 0) then
    begin
      FSelStartX := FDotPoint.X;
      FSelEndX := FDotPoint.X + Length(sEntry);
    end
    else
    begin
      s := InternalLines[cury];
      ae := length(s);
      ab := 1;

      if (ae > 0) then
      begin
        for vp := CurX + 1 to length(s) do
          if s[vp] = #32 then
          begin
            ae := vp - 1;
            Break;
          end;

        for vp := CurX downto 1 do
        begin
          if s[vp] = #32 then
          begin
            ab := vp + 1;
            break;
          end;
        end;
      end;

      FSelStartX := ab - 1;
      FSelEndX := ae;
    end;

    if Assigned(FOnAutoCompletion) then
      FOnAutoCompletion(self);

    SetSelText(sEntry);
    KillEventAutoCompletion;
    HideForm;
    ShowCaret(True);
  end;
end;

procedure TAdvCustomMemo.ListKeyDown(sender: TObject; var Key: word; Shift: TShiftState);
var
  i: Integer;
  s: string;
  ae, ab, vp: integer;
  c: char;
  sEntry: string;
  flg: Boolean;
begin
  case key of
    VK_ESCAPE, VK_TAB:
      begin
        HideForm;
        ShowCaret(true);
      end;
    VK_RETURN, VK_SPACE, 53:
      begin
        if FListCompletion.ItemIndex > -1 then
        begin
          sEntry := Flistcompletion.Items[Flistcompletion.ItemIndex];
          if Assigned(FOnInsertAutoCompletionEntry) then
            FOnInsertAutoCompletionEntry(Self, sEntry);

          flg := false;
      //check if event handler modified the string, if not then apply std behaviour
          if sEntry = Flistcompletion.Items[Flistcompletion.ItemIndex] then
          begin
        // strip identifier if available
            vp := pos(' ', sEntry);
            if vp > 0 then
              Delete(sEntry, 1, vp);
        //search for the next delimiter, for example ( or ; and stop there
        //so Test(parama : string); becomes Test
            s := '';
            for i := 1 to Length(sEntry) do
            begin
              if not ((sEntry[i] = '(') or (sEntry[i] = ';') or (sEntry[i] = ' ')) then
                s := s + sEntry[i]
              else
                break;
            end;

            if pos('(', sEntry) > 0 then
            begin
              sEntry := s + '()';
              flg := true;
            end
            else
              sEntry := s;
          end;

          FSelStartY := CurY;
          FSelEndY := CurY;
          if FAutoCompleteDot and (Pos('.', sEntry) = 0) then
          begin
            FSelStartX := FDotPoint.X;
            FSelEndX := CurX; // + Length(sEntry);
          end
          else
          begin
            s := InternalLines[cury];
            ae := length(s);
            ab := 1;
            if ae > 0 then
            begin
              for vp := CurX + 1 to length(s) do
                if (s[vp] = #32) or (s[vp] = '(') or (s[vp] = ')') then
                begin
                  ae := vp - 1;
                  Break;
                end;
              for vp := CurX  downto 1 do
                if (s[vp] = #32) or (s[vp] = '(') or (s[vp] = ')') then
                begin
                  ab := vp + 1;
                  break;
                end;
            end;

            FSelStartX := ab - 1;
            FSelEndX := ae;
          end;
          if Assigned(FOnAutoCompletion) then
            FOnAutoCompletion(self);
          SetSelText(sEntry);
          if flg then
          begin
            CurX := CurX - 1;
            PrepareShowHint;
          end;
          KillEventAutoCompletion;
          HideForm;
          ShowCaret(True);
        end;
      end;
    VK_BACK:
      begin
        if not ReadOnly then BackSpace;

        if FAutoCompleteDot then
          s := UpperCase(WordAtXY(FDotPoint.X, FDotPoint.Y))
        else
          s := Uppercase(FullWordAtCursor);

        if (FAutoCompleteDot and (pos('.', FullWordAtCursor) = 0)) { or (s='') } then //why?? -> *BF* it needs to close again when backspace deletes to '.' otherwise it just sticks there floating
          HideForm
        else
          UpdateCompletionList(s);
      end;
    VK_DELETE: if not ReadOnly then DeleteChar(-1, -1);
{$IFNDEF TMSCLX}
    VK_LEFT, VK_UP, VK_DOWN, VK_RIGHT, VK_HOME, VK_END, VK_PRIOR, VK_NEXT, VK_MENU, VK_SHIFT, VK_LSHIFT, VK_RSHIFT, VK_RMENU, VK_LMENU, VK_CONTROL: ; // do nothing
{$ENDIF}
{$IFDEF TMSCLX}
    VK_LEFT, VK_UP, VK_DOWN, VK_RIGHT, VK_HOME, VK_END, VK_PRIOR, VK_NEXT, VK_MENU, VK_SHIFT, VK_CONTROL: ; // do nothing
{$ENDIF}
  else
    begin
      if Key in [ord('a')..ord('z'), ord('A')..ord('Z'), ord('-'), ord('0')..ord('9'), 189] then
      begin
        if Key = 189 then
          Key := 95;

        c := chr(Key);
        s := c;
        s := lowercase(s);
        c := s[1];

        if (ssShift in Shift) then
          InsertChar(chr(key))
        else
          InsertChar(c);

        // if invoked by dot then search on the string after the dot
        if FAutoCompleteDot then
          s := Uppercase(WordAtXY(FDotPoint.X, FDotPoint.Y))
        else
          s := Uppercase(FullWordAtCursor);

        UpdateCompletionList(s);
        Refresh;
      end
      else
      begin
        if Assigned(FOnCancelAutoCompletion) then
          FOnCancelAutoCompletion(self);
        HideForm;
        ShowCaret(true);
      end;
    end;
  end;
end;

procedure TAdvCustomMemo.KillEventAutoCompletion;
begin
  FormAutocompletion.OnDeactivate := nil;
  Flistcompletion.OnExit := nil;
  Flistcompletion.OnKeyDown := nil;
end;

procedure TAdvCustomMemo.SetEventAutoCompletion;
begin
  FormAutocompletion.OnDeactivate := HideAuto;
  Flistcompletion.OnExit := HideAuto;
  Flistcompletion.OnKeyDown := ListKeyDown;
  Flistcompletion.OnMouseUp := ListMouseUp;
end;

procedure TAdvCustomMemo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;


{ TAdvAutoform }

{$IFNDEF TMSCLX}
procedure TAdvAutoform.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    with Params do
    begin
      Style := Style and not (WS_CAPTION or WS_THICKFRAME) or WS_POPUP;
      ExStyle := ExStyle and not WS_EX_CLIENTEDGE or WS_EX_TOOLWINDOW;
      if BorderStyle = bsSizeToolWin then
        Style := Style or WS_DLGFRAME or WS_THICKFRAME
      else
        Style := Style or WS_BORDER;
    end
end;
{$ENDIF}

procedure TAdvCustomMemo.PrepareShowHint;
var
  p: TPoint;
  bp, np: string;
  gWidth: integer;
  ht: TPoint;
begin
  if not (Assigned(InternalStyles)) or (not useStyler) then
    Exit;

  if (cury < FTopLine) or (cury > FTopLine + VisibleLineCount) then
    Exit;

  if FGutter.FShowGutter then
    gWidth := FGutter.fWidth
  else
    gWidth := 0;

  if SearchParameter then
  begin
    P := Point(0, 0);
    P := ClientToScreen(P);

    with FHintForm do
    begin
      ht.X := p.x + gWidth + FCellSize.W * (Fcurx - FLeftCol);

      if not FCodeFolding.Enabled then
      begin
        if FAutoHintParameterPos = hpBelowCode then
          ht.Y := p.y + FCellSize.H * (FCury - FTopLine + 1)
        else
          ht.Y := p.y + FCellSize.H * (FCury - FTopLine - 1);
      end
      else
      begin
        if FAutoHintParameterPos = hpBelowCode then
          ht.Y := p.y + FCellSize.H * (LineIndexToVisIndex(FCury) - LineIndexToVisIndex(FTopLine) + 1)
        else
          ht.Y := p.y + FCellSize.H * (LineIndexToVisIndex(FCury) - LineIndexToVisIndex(FTopLine) - 1);
      end;

      bp := '';
      np := '';
      case FHintForm.Active of
        0: np := part1 + part2 + part3;
        1: begin
            np := part2 + part3;
            bp := part1;
          end;
        2: begin
            np := part1 + part3;
            bp := part2;
          end;
        3: begin
            np := part1 + part2;
            bp := part3;
          end;
      end;
      Left := ht.X;
      Top := ht.Y;
      Height := Canvas.TextHeight('h,g_`') + 5;
      Width := Canvas.TextWidth(np);
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
      Width := Width + Canvas.TextWidth(bp) + 6;
      Canvas.Font.Style := Canvas.Font.Style - [fsBold];

      Color := InternalStyles.HintParameter.FBkColor;
      Font.Color := InternalStyles.HintParameter.FTextColor;
    end;

    FHintShowing := True;
    FHintForm.Visible := True;

{$IFDEF DELPHI9_LVL}
    FHintForm.Left := ht.X;
    FHintForm.Top := ht.Y;
{$ENDIF}

    FHintForm.Refresh;

{$IFNDEF TMSCLX}
    if ((Owner is TForm) and ((Owner as TForm).FormStyle = fsMDIChild)) then
      SendMessage((Owner as TForm).Handle, WM_MDIACTIVATE, 0, (Owner as TForm).Handle)
    else
      SetFocus;
{$ENDIF}

    FHintShowing := False;
  end
  else
    if FHintForm.Visible then
      FHintForm.Hide;
end;

procedure TAdvCustomMemo.FormHintClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TAdvCustomMemo.TimerHint(Sender: TObject);
begin
  FHintForm.Hide;
  Timer.Enabled := False;
end;


{ TAdvHintform }
{$IFNDEF TMSCLX}
procedure TAdvHintform.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;

begin
  inherited CreateParams(Params);

  if (Win32Platform = VER_PLATFORM_WIN32_NT) and
    ((Win32MajorVersion > 5) or
    ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1))) then
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
end;
{$ENDIF}

procedure TAdvHintform.Paint;
var
  x: Integer;

begin
  inherited;

  Canvas.Pen.Color := clGray;
  Canvas.Pen.Width := 1;
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  Canvas.Rectangle(ClientRect.Left, ClientRect.Top, ClientRect.Right, ClientRect.Bottom);
  Canvas.Font.Style := [];

  case Active of
    0: begin
        Canvas.TextOut(2, 2, part1 + part2 + part3);
      end;
    1: begin
        Canvas.Font.Style := [fsBold];
        Canvas.TextOut(2, 2, part1);
        x := Canvas.TextWidth(part1);
        Canvas.Font.Style := [];
        Canvas.TextOut(x + 2, 2, part2 + part3);
      end;
    2: begin
        Canvas.TextOut(2, 2, part1);
        x := Canvas.TextWidth(part1);
        Canvas.Font.Style := [fsBold];
        Canvas.TextOut(x + 2, 2, part2);
        x := x + Canvas.TextWidth(part2);
        Canvas.Font.Style := [];
        Canvas.TextOut(x + 2, 2, part3);
      end;
    3: begin
        Canvas.TextOut(2, 2, part1 + part2);
        x := Canvas.TextWidth(part1 + part2);
        Canvas.Font.Style := [fsBold];
        Canvas.TextOut(x + 2, 2, part3);
      end;
  end;
end;

{ THintParameter }

constructor THintParameter.Create;
begin
  inherited;

  FParameters := TStringList.Create;
  FTextColor := clBlack;
  FBkColor := clInfoBk;
  FStartchar := '(';
  FEndchar := ')';
  FDelimiterChar := ';';
  FWriteDelimiterChar := ',';
end;

destructor THintParameter.Destroy;
begin
  FParameters.free;
  inherited;
end;

procedure ThintParameter.SetParameters(const Value: Tstringlist);
begin
  FParameters.Assign(Value);
end;

function TAdvCustomMemo.SearchParameter: Boolean;
var
  i, x, j, fnd, fnds, fnd_chb, fnd_che, Cx: integer;
  s, st, stemp: string;
  paridx: Integer;
  handled: boolean;

  function ApplyCS(s: string): string;
  begin
    if FCaseSensitive then
      Result := s
    else
      Result := UpperCase(s);
  end;

  function NearestStart(s: string; fromX: integer; var res: string; var ParNum: Integer): integer;
  var
    found: boolean;
    space: Integer;
  begin
    ParNum := 0;
    res := '';

    if fromX > length(s) then
      fromX := length(s);

    found := False;

    space := 0;

    while (fromX > 0) and not found and (space < 5) do
    begin
      if (s[fromX] = InternalStyles.FHintParameter.FWriteDelimiterChar) then
        inc(ParNum);

      if s[fromX] = ' ' then
        inc(space)
      else
        space := 0;

      if s[fromX] = InternalStyles.FHintParameter.FEndChar then
      begin
        Result := -1;
        Exit;
      end;

      if s[fromX] = InternalStyles.FHintParameter.FStartChar then
        found := true;

      dec(fromX);
    end;

    if space >= 5 then
    begin
      Result := -1;
      Exit;
    end;

    Result := fromX;

    if found then
    begin
      found := false;
      while (fromX > 0) and not found do
      begin
        if (s[fromX] = InternalStyles.FHintParameter.FStartchar) or (s[fromX] = InternalStyles.FHintParameter.FEndchar) then
          found := true
        else
        begin
          if s[fromX] = ' ' then break; //17 ap
          res := s[fromX] + res;
          dec(fromX);
        end;
      end;
    end;
  end;

begin
  Result := False;

  if (not Assigned(InternalStyles)) or (not useStyler) then
    Exit;

  if InternalLines.Count = 0 then
    Exit;

  st := ApplyCS(InternalLines[cury]);
  s := '';

  cx := curx;
  x := NearestStart(st, cx, stemp, paridx);

  if x = -1 then
  begin
    FHintForm.Hide;
    Exit;
  end;

  stemp := Trim(stemp);

  if stemp = '' then
    Exit;

{$IFDEF TMSDEBUG}
  outputdebugstring(pchar(inttostr(x) + ':' + stemp + ';' + inttostr(paridx)));
{$ENDIF}

  st := '';
  s := '';
  Handled := False;
  if Assigned(FOnGetParameterHint) then
    FOnGetParameterHint(Self, sTemp, s, handled);

  if not Handled then
  begin
    for i := 0 to InternalStyles.FHintParameter.FParameters.Count - 1 do
    begin
      s := InternalStyles.FHintParameter.FParameters[i];
      st := ApplyCS(s);
      if AnsiPos(stemp, st) = 1 then
        Break
      else
      begin
        st := '';
        s := '';
        Continue;
      end;
    end;
  end;


  if s <> '' then
  begin
    x := AnsiPos(InternalStyles.FHintParameter.FStartchar, s);

    if x > 0 then
      delete(s, 1, x);
    x := AnsiPos(InternalStyles.FHintParameter.FEndchar, s);
    if x > 0 then
      s := Copy(s, 1, x - 1);
//        delete(s,x,length(s)-x); // doesn't work
    fnd := paridx;

    fnds := 0;
    fnd_chb := 0;
    fnd_che := Length(s);

  // extract the parameter to highlight
    for j := 1 to Length(s) do
    begin
      if (s[j] = InternalStyles.FHintParameter.FWritedelimiterChar) or
        (s[j] = InternalStyles.FHintParameter.FDelimiterChar) then
      begin
        inc(fnds);
        if fnds = fnd then
          fnd_chb := j;
        if fnds = fnd + 1 then
        begin
          fnd_che := j;
          Break;
        end;
      end;
    end;

//      if fnd >= fnds then
//      begin
//        Showmessage('doh');
//        exit;// Continue; ????
//      end;

    FHintForm.part1 := copy(s, 1, fnd_chb);
    FHintForm.part2 := copy(s, fnd_chb + 1, fnd_che - fnd_chb);
    FHintForm.part3 := copy(s, fnd_che + 1, length(s) - fnd_che);

{$IFDEF TMSDEBUG}
    OutputDebugString(pchar('1="' + FHintForm.part1 + '"'));
    OutputDebugString(pchar('2="' + FHintForm.part2 + '"'));
    OutputDebugString(pchar('3="' + FHintForm.part3 + '"'));
{$ENDIF}

    if FHintForm.part2 = '' then
      FHintForm.Active := 1
    else
      FHintForm.Active := 2;

    Timer.Enabled := False;
    Result := True;
    Timer.Enabled := True;
    Exit;
  end;
  FHintForm.Hide;
end;

procedure TAdvCustomMemo.FormHintMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetFocus;
  ShowCaret(true);
  Invalidate;
  SetFocus;
end;

procedure TAdvCustomMemo.SetAutoHintParameters(
  const Value: TAutoHintParameters);
begin
  FAutoHintParameters := Value;
  FHintForm.Hide;
end;

procedure TAdvCustomMemo.HideHint;
begin
  if FHintForm.Visible then
    FHintForm.Visible := False;
end;

{ TPrintOptions }

procedure TPrintOptions.Assign(Source: TPersistent);
begin
  FJobName := (Source as TPrintOptions).JobName;
  FTitle := (Source as TPrintOptions).FTitle;
  FMarginLeft := (Source as TPrintOptions).FMarginLeft;
  FMarginRight := (Source as TPrintOptions).FMarginRight;
  FMarginTop := (Source as TPrintOptions).FMarginTop;
  FMarginBottom := (Source as TPrintOptions).FMarginBottom;
  FPageNr := (Source as TPrintOptions).FPageNr;
  FPagePrefix := (Source as TPrintOptions).FPagePrefix;
  FPrintLineNumbers := (Source as TPrintOptions).PrintLineNumbers;
end;

procedure TAdvCustomMemo.SetPrintOptions(const Value: TPrintOptions);
begin
  FPrintOptions.Assign(Value);
end;

procedure TAdvCustomMemo.KeyUp(var Key: word; Shift: TShiftState);
begin
{$IFDEF BLINK}
  SetCaretBlinkTime(FCaretTime);
  FletgetCaretTime := True;
{$ENDIF}
  if not FHiddenCaret then
    ShowCaret(True);
  inherited;
end;


{$B+}
procedure TAdvCustomMemo.CursorChanged;
var
  wac, s, wstart, wend: string;
  i, b, vp1, vp2: Integer;
  flgs, flge: Boolean;
  es, ee: integer;

  function varpos1(su, s: string; var vp: integer): integer;
  var
    sg, eg: Boolean;
  begin
    Result := 0;
    vp := Pos(su, s);

    if vp > 0 then
    begin
      sg := True;
      if (vp > 1) then
        sg := IsWordBoundary(s[vp - 1]);

      eg := True;

      if (vp + Length(su) <= Length(s)) then
       eg := IsWordBoundary(s[vp + Length(su)]);

      if eg and sg then
        Result := vp;
    end;
  end;

  function varpos(var su : string;  s: string; var vp: integer): integer;
  var
    sl : TStrings;
  begin
    result := -1;
    if pos(',', su) = 0 then
      result := varpos1(su, s, vp)
    else
    begin
      sl := TStringList.Create;
      sl.text := StringReplace(su, ',', #13#10, [rfreplaceall]);
      while sl.Count > 0 do
      begin
        result := varpos1(sl[0], s, vp);
        if result > 0 then
        begin
          su := sl[0];//return the matched key
          break;
        end;
        sl.delete(0);
      end;
      sl.free;
    end;
  end;


begin
  FCursorChangedTrigered := True;
  if Assigned(SyntaxStyles) then
  begin
    wstart := UpperCase(SyntaxStyles.BlockStart);
    wend := UpperCase(SyntaxStyles.BlockEnd);
  end;

// wstart := '(';
// wend := ')';

  if InternalLines.Count > 0 then
  begin

    if (wstart <> '') and (wend <> '') then
    begin
      flgs := false;
      flge := false;
      ee := 0;

      wac := Uppercase(WordAtCursor);

      if (wac = wstart) or (1 > 0) then
      begin
        b := 0;
        i := CurY;

        if (i < InternalLines.Count) then
        begin
          //if (pos(wstart, Uppercase(InternalLines[i])) > 0) then
          if (varpos(wstart, Uppercase(InternalLines[i]), ee) > 0) then
            ee := 0
          else
            ee := -1;
        end;

        while (i <= TopLine + VisibleLineCount) and not flgs do
        begin
          if i < InternalLines.Count then
          begin
            s := Uppercase(InternalLines[i]);

            wstart := UpperCase(SyntaxStyles.BlockStart);


            while (varpos(wstart, s, vp1) > 0) or (varpos(wend, s, vp2) > 0) do
            begin
              if (vp1 > 0) and ((vp1 < vp2) or (vp2 = 0)) then
                inc(b);

              if (vp2 > 0) and ((vp2 < vp1) or (vp1 = 0)) then
                dec(b);

              if (vp2 > 0) and (b = ee) then
              begin
                SetBlockMatchStart(i, vp2 - 1, Length(wend));
                flgs := true;
                Break;
              end;

              if vp1 > 0 then
                delete(s, 1, vp1 + Length(wend))
              else
                s := '';

              wstart := UpperCase(SyntaxStyles.BlockStart);

            end;
          end;
          inc(i);
        end;
      end;

      if (wac = wend) or (1 > 0) then
      begin
        b := 0;
        i := CurY;

        //if (pos(wend, Uppercase(InternalLines[i])) > 0) then
        if (varpos(wend, Uppercase(InternalLines[i]), es) > 0) then
          es := 0
        else
          es := -1;


        while (i >= TopLine) and not flge do
        begin
          if i < InternalLines.Count then
          begin
            s := Uppercase(InternalLines[i]);

            wstart := UpperCase(SyntaxStyles.BlockStart);

            while (varpos(wend, s, vp1) > 0) or (varpos(wstart, s, vp2) > 0) do
            begin
              if (vp1 > 0) and ((vp1 < vp2) or (vp2 = 0)) then
                inc(b);

              if (vp2 > 0) and ((vp2 < vp1) or (vp1 = 0)) then
                dec(b);

              if (vp2 > 0) and (b = es) then
              begin
                SetBlockMatchEnd(i, vp2 - 1, Length(wstart));
                flge := true;
                Break;
              end;

              if vp1 > 0 then
                delete(s, 1, vp1 + Length(wstart))
              else
                s := '';

              wstart := UpperCase(SyntaxStyles.BlockStart);
            end;

          end;
          dec(i);
        end;
      end;

      if not flgs or not flge then
      begin
        SetBlockMatchStart(-1, -1, -1);
        SetBlockMatchEnd(-1, -1, -1);
      end;

    {
    if (wac <> wstart) and (wac <> wend) then
    begin
      SetBlockMatchStart(-1,-1,-1);
      SetBlockMatchEnd(-1,-1,-1);
    end;
    }
    end;
  end;

  if Assigned(FOnCursorChange) then
    FOnCursorChange(Self);
end;
{$B-}

{ TIntList }

constructor TIntList.Create;
begin
  inherited Create;
end;

procedure TIntList.SetInteger(Index: Integer; Value: Integer);
begin
{$IFNDEF TMSDOTNET}
  inherited Items[Index] := Pointer(Value);
{$ENDIF}
{$IFDEF TMSDOTNET}
  inherited Items[Index] := TObject(Value);
{$ENDIF}
end;

function TIntList.GetInteger(Index: Integer): Integer;
begin
  Result := Integer(inherited Items[Index]);
end;

procedure TIntList.Add(Value: Integer);
begin
{$IFNDEF TMSDOTNET}
  inherited Add(Pointer(Value));
{$ENDIF}
{$IFDEF TMSDOTNET}
  inherited Add(TObject(Value));
{$ENDIF}
end;

procedure TIntList.Insert(Index, Value: Integer);
begin
{$IFNDEF TMSDOTNET}
  inherited Insert(Index, Pointer(Value));
{$ENDIF}
{$IFDEF TMSDOTNET}
  inherited Insert(Index, TObject(Value));
{$ENDIF}
end;

function TIntList.IndexOf(Value: Integer): Integer;
var
  Low, Mid, High: Integer;
begin
  Result := -1;

  Low := 0;
  High := Count - 1;

  while (Low <= High) do
  begin
    Mid := (Low + High) div 2;

    if Value < Items[Mid] then
      High := Mid - 1
    else
      if (Value > Items[Mid]) then
        Low := Mid + 1
      else
      begin
        Result := Mid;
        break;
      end;
  end;
end;

procedure TIntList.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

procedure TAdvCustomMemo.ClearErrors;
var
  i: Integer;
  Tlp: TLineProp;
begin
  for i := 1 to InternalLines.Count do
  begin
    Tlp := InternalLines.GetLineProp(i - 1);
    if Assigned(Tlp) then
    begin
      Tlp.FErrStart.Clear;
      Tlp.FErrLen.Clear;
    end;
  end;
  Invalidate;
end;

procedure TAdvCustomMemo.ClearLineErrors(LineNo: Integer);
var
  Tlp: TLineProp;
begin
  Tlp := InternalLines.GetLineProp(LineNo);
  if Assigned(Tlp) then
  begin
    Tlp.FErrStart.Clear;
    Tlp.FErrLen.Clear;
  end;
end;

procedure TAdvCustomMemo.ClearWordError(LineNo, LinePos: Integer);
var
  Tlp: TLineProp;
  i: Integer;
begin
  Tlp := InternalLines.GetLineProp(LineNo);
  if Assigned(Tlp) then
  begin
    for i := 1 to Tlp.FerrStart.Count do
    begin
      if (tlp.FErrStart[i - 1] = LinePos) then
      begin
        tlp.FErrStart.Delete(i - 1);
        tlp.FErrLen.Delete(i - 1);
        Exit;
      end;
    end;
  end;
end;

procedure TAdvCustomMemo.SetError(LineNo, ErrPos, ErrLen: Integer);
var
  Tlp: TlineProp;
  r: TRect;
begin
  Tlp := InternalLines.GetLineProp(LineNo);
  if Tlp = nil then
    tlp := InternalLines.CreateProp(LineNo);
  tlp.FErrStart.Add(ErrPos);
  tlp.FErrLen.Add(ErrLen);
  InternalLines.SetLineProp(LineNo, tlp);
  r := LineRect(LineNo);
{$IFNDEF TMSDOTNET}
  InvalidateRect(Handle, @r, True);
{$ENDIF}

{$IFDEF TMSDOTNET}
  InvalidateRect(Handle, r, True);
{$ENDIF}
end;

procedure TAdvCustomMemo.SetBlockMatchStart(LineNo, BlockStart, BlockLen: Integer);
var
  r: TRect;
begin
  if (BSOldSelLine <> -1) and (BSOldSelLine < InternalLines.Count) then
  begin
    r := LineRect(LineIndexToVisIndex(BSOldSelLine));  // kh: FF: Sel iss
    r.Bottom := r.Bottom + 2;
{$IFNDEF TMSDOTNET}
    InvalidateRect(Handle, @r, True);
{$ENDIF}
{$IFDEF TMSDOTNET}
    InvalidateRect(Handle, r, True);
{$ENDIF}
  end;

  BSSelLine := LineNo;
  BSSelStart := BlockStart;
  BSSelLen := BlockLen;

  BSOldSelLine := BSSelLine;
  r := LineRect(LineIndexToVisIndex(BSOldSelLine));  // kh: FF: Sel iss

{$IFNDEF TMSDOTNET}
  InvalidateRect(Handle, @r, True);
{$ENDIF}

{$IFDEF TMSDOTNET}
  InvalidateRect(Handle, r, True);
{$ENDIF}
end;

procedure TAdvCustomMemo.SetBlockMatchEnd(LineNo, BlockStart, BlockLen: Integer);
var
  r: TRect;
begin
  if (BEOldSelLine <> -1) and (BEOldSelLine < InternalLines.Count) then
  begin
    r := LineRect(LineIndexToVisIndex(BEOldSelLine));  // kh: FF: Sel iss
    r.Bottom := r.Bottom + 2;
{$IFNDEF TMSDOTNET}
    InvalidateRect(Handle, @r, True);
{$ENDIF}
{$IFDEF TMSDOTNET}
    InvalidateRect(Handle, r, True);
{$ENDIF}
  end;

  BESelLine := LineNo;
  BESelStart := BlockStart;
  BESelLen := BlockLen;

  BEOldSelLine := BESelLine;
  r := LineRect(LineIndexToVisIndex(BEOldSelLine));      // kh: FF: Sel iss

{$IFNDEF TMSDOTNET}
  InvalidateRect(Handle, @r, True);
{$ENDIF}

{$IFDEF TMSDOTNET}
  InvalidateRect(Handle, r, True);
{$ENDIF}
end;

{$IFNDEF TMSCLX}
{$IFDEF TMSDOTNET}
procedure TAdvCustomMemo.CMHintShow(var Msg: TCMHintShow);
{$ENDIF}
{$IFNDEF TMSDOTNET}
procedure TAdvCustomMemo.CMHintShow(var Msg: TMessage);
{$ENDIF}
var
  CanShow: Boolean;
{$IFDEF TMSDOTNET}
  hi: THintInfo;
{$ENDIF}
{$IFNDEF TMSDOTNET}
  hi: PHintInfo;
{$ENDIF}
  newPos: TCellPos;
  s, ahint: string;
  gw: integer;
begin
  CanShow := True;

{$IFDEF TMSDOTNET}
  hi := Msg.HintInfo;
{$ENDIF}

{$IFNDEF TMSDOTNET}
  hi := PHintInfo(Msg.LParam);
{$ENDIF}

  newpos := CellFromPos(hi.CursorPos.X, hi.CursorPos.Y);

  newpos.X := newpos.X + LeftCol;
  newpos.Y := newpos.Y + TopLine;

  FLastHintPos := Point(newpos.x, newpos.y);

  gw := 0;
  if Gutter.Visible then
    gw := Gutter.Width;

  if (hi.CursorPos.X > gw) then
  begin
    if Assigned(FOnHintForWord) then
    begin
      s := WordAtXY(newpos.x, newpos.y);
      if (s <> '') then
      begin
        AHint := s;
        FOnHintForWord(Self, newpos.x, newpos.y, s, AHint, CanShow);
        if CanShow then
        begin
          hi.HintStr := AHint;
          Msg.Result := Ord(not CanShow);
          Exit;
        end;
      end;
    end;

    if Assigned(FOnHintForToken) then
    begin
      s := TokenAtXY(newpos.x, newpos.y);
      if s <> '' then
      begin
        AHint := s;
        FOnHintForToken(Self, newpos.x, newpos.y, s, AHint, CanShow);
        if CanShow then
        begin
          hi.HintStr := AHint;
          Msg.Result := Ord(not CanShow);
          Exit;
        end;
      end;
    end;
  end;

  Msg.Result := Ord(not CanShow);
end;
{$ENDIF}

procedure TAdvCustomMemo.SetAutoHintParameterDelay(const Value: Integer);
begin
  FAutoHintParameterDelay := Value;
  if Value > 0 then
    Timer.Interval := Value;
end;

// delayed code completion
procedure TAdvCustomMemo.AutoCompleteTimer(Sender: TObject);
var
  sWord: string;

begin
  FAutoCompleteTimer.Enabled := False;
// trigger autocomplete

  if FAutoCompletion.Active and FAutoCompletion.AutoDisplay then
  begin
    sWord := FullWordAtCursor;
    if ((sWord <> '.') or (sWord <> '(')) and (sWord <> '') then
    begin
      FAutoCompleteDot := True; //code completion invoked by .
      FDotPoint := Point(CurX, CurY); //the position of the .
      ShowForm(False);
    end;
  end;
end;

// custom sorting of the autocompletelist
(*
function TAdvCustomMemo.SortAutoCompletList(List: TStringList; Index1, Index2: Integer): Integer;
var
  entry1, entry2: string;

  function TrimEntry(value: string): string;
  var
    vp: integer;
    s: string;
    i: integer;
  begin
    vp := pos(' ', value);
    if vp > 0 then
      Delete(value, 1, vp);
//search for the next delimiter, for example ( or ; and stop there
//so Test(parama : string); becomes Test
    s := '';
    for i := 1 to Length(value) do
    begin
      if not (value[i] in ['(', ';', ' ']) then
        s := s + value[i]
      else
        break;
    end;
    result := s;
  end;

begin
  if Assigned(FOnSortAutoCompletionList) then
    Result := FOnSortAutoCompletionList(Self, List, Index1, Index2)
  else
  begin
    entry1 := TrimEntry(List.Strings[index1]);
    entry2 := TrimEntry(List.Strings[index2]);
    result := CompareText(entry1, entry2);
  end;
end;
*)

function TAdvCustomMemo.GetBookmarks(Index: Integer): Integer;
begin
  if (Index < 10) and (Index >= 0) then
  begin
    Result := FBookmarkList.Items[Index]
  end
  else
    raise Exception.Create('Invalid bookmark index');
end;

procedure TAdvCustomMemo.SetBookmarks(Index: Integer;
  const Value: Integer);
begin
  if (Index < 10) and (Index >= 0) then
  begin
    if FBookmarkList.Items[Index] <> -1 then
      Bookmark[FBookmarkList.Items[Index]] := False;
    FBookmarkList.Items[Index] := Value;
    if Value <> -1 then
      Bookmark[FBookmarkList.Items[Index]] := True;
  end
  else
    raise Exception.Create('Invalid bookmark index');
end;

procedure TAdvCustomMemo.ClearUndoRedo;
begin
  ClearUndoList;
end;

procedure TAdvCustomMemo.ClearBookmarks;
var
  i: Integer;
begin
  for i := 1 to 10 do
  begin
    Bookmark[FBookmarkList.Items[i - 1]] := False;
    FBookmarkList.Items[i - 1] := -1;
  end;
end;

procedure TAdvCustomMemo.GotoBookmark(Index: Integer);
begin
  if (Index < 10) and (Index >= 0) then
  begin
    if FBookmarkList.Items[Index] <> -1 then
    begin
      if CodeFolding.Enabled then
        ExpandParents(FBookmarkList.Items[Index]);

      TopLine := FBookmarkList.Items[Index];
      CurX := 0;
      CurY := FBookmarkList.Items[Index];
    end;
  end
  else
    raise Exception.Create('Invalid bookmark index');
end;

function TAdvCustomMemo.HasBookmarks: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to 10 do
    if FBookmarkList.Items[i - 1] <> -1 then
    begin
      Result := True;
      Break;
    end;
end;

procedure TAdvCustomMemo.SetMemoSource(const Value: TAdvMemoSource);
begin
  if FMemoSource <> Value then
  begin
    if FMemoSource <> nil then
      FMemoSource.SetMemo(nil);
    FMemoSource := Value;
    if (FMemoSource <> nil) then
      if not (csLoading in ComponentState) and not (csDesigning in ComponentState) then
      begin
        FMemoSource.SetMemo(Self);

        TopLine := 0;
        CurX := 0;
        CurY := 0;
      end;
    SetMaxLength;
    ResizeScrollbars(True);
  end;
end;

function TAdvCustomMemo.GetInternalStyles: TAdvCustomMemoStyler;
begin
  if FMemoSource <> nil then
    Result := FMemoSource.SyntaxStyler
  else
    Result := FInternalStyles;
end;

function TAdvCustomMemo.GetInternalLines: TAdvMemoStrings;
begin
  if FMemoSource <> nil then
    Result := FMemoSource.Lines
  else
    Result := FLines;
end;

procedure TAdvCustomMemo.SetInternalLines(const Value: TAdvMemoStrings);
begin
  if FMemoSource <> nil then
    FMemoSource.Lines.Assign(Value)
  else
    FLines.Assign(Value);
end;

procedure TAdvCustomMemo.GetMemoState(var value: TAdvMemoSavePos);
begin
  value.CurX := FCurX;
  value.CurY := FCurY;
  value.LeftCol := FLeftCol;
  value.TopLine := FTopLine;
  value.SelStartX := FSelStartX;
  value.SelStartY := FSelStartY;
  value.SelEndX := FSelEndX;
  value.SelEndY := FSelEndY;
end;

procedure TAdvCustomMemo.ResetMemoState(value: TAdvMemoSavePos);
begin
  FCurX := value.CurX;
  FCurY := value.CurY;
  FLeftCol := value.LeftCol;
  FTopLine := value.TopLine;
  FSelStartX := value.SelStartX;
  FSelStartY := value.SelStartY;
  FSelEndX := value.SelEndX;
  FSelEndY := value.SelEndY;
  if FCaretVisible then
    ShowCaret(FCaretVisible);
  ResizeScrollBars(True);
end;

function TAdvCustomMemo.InternalUndoList: TAdvUndoList;
begin
  if FMemoSource <> nil then
    Result := FMemoSource.UndoList
  else
    Result := FUndoList;
end;

function TAdvCustomMemo.CanCopy: boolean;
begin
  Result := GetSelLength > 0;
end;

function TAdvCustomMemo.CanPaste: boolean;
begin
  Result := EditCanModify;
end;

{ TAutoCorrect }

constructor TAutoCorrect.Create;
begin
  inherited Create;
  FOldValue := TStringList.Create;
  FNewValue := TStringList.Create;
  FDoAutoCorrect := True;
end;

destructor TAutoCorrect.Destroy;
begin
  FOldValue.Free;
  FNewValue.Free;
  inherited;
end;

procedure TAutoCorrect.SetDoAutoCorrect(const Value: boolean);
begin
  FDoAutoCorrect := Value;
end;

procedure TAutoCorrect.SetNewValue(const Value: TStringList);
begin
  FNewValue.Assign(Value);
end;

procedure TAutoCorrect.SetOldValue(const Value: TStringList);
begin
  FOldValue.Assign(Value);
end;

{ TAutoCompletion }

constructor TAutoCompletion.Create(AOwner: TAdvCustomMemo);
begin
  inherited Create;
  FFont := TFont.Create;
  FOwner := AOwner;
  FColor := clWindow;
  FHeight := 100;
  FWidth := 200;
  FActive := True;
  FDelay := 500;
  FColorVar := clBlue;
  FColorProp := clTeal;
  FColorFunc := clNavy;
  FColorProc := clNavy;
  FColorMethod := clNavy;
  FColorEvent := clRed;
  FColorIdentifier := clTeal;
  FSizeDropDown := True;
  FAutoDisplay := True;
end;

destructor TAutoCompletion.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TAutoCompletion.SetColor(const Value: TColor);
begin
  FColor := Value;
  FOwner.CompletionList.Color := FColor;
end;

procedure TAutoCompletion.SetDelay(const Value: Integer);
begin
  FDelay := Value;
  FOwner.FAutoCompleteTimer.Interval := FDelay;
end;

procedure TAutoCompletion.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  FOwner.CompletionList.Font.Assign(FFont);
end;

function TAdvCustomMemo.IsDelimiter(value: Char): boolean;
var
  i: Integer;
begin
  result := False;

  if FCachedDelimiters <> '' then
    result := pos(value, FCachedDelimiters) <> 0
  else if (Assigned(InternalStyles)) and (UseStyler) then
  begin
    for i := 0 to InternalStyles.FAllStyles.Count - 1 do
    begin
      if InternalStyles.FAllStyles.Items[i].FStyleType = stSymbol then
      begin
        FCachedDelimiters := InternalStyles.FAllStyles.Items[i].Symbols;
        result := pos(value, InternalStyles.FAllStyles.Items[i].Symbols) <> 0;
        break;
      end;
    end;
  end
  else
    Result := value = ' ';
end;

procedure TAdvCustomMemo.SetRightMargin(const Value: Integer);
begin
  if FRightMargin <> Value then
  begin
    FRightMargin := Value;
    Invalidate;
  end;
end;

procedure TAdvCustomMemo.SetRightMarginColor(const Value: TColor);
begin
  if FRightMarginColor <> Value then
  begin
    FRightMarginColor := Value;
    Invalidate;
  end;
end;

procedure TAdvCustomMemo.SetBreakpointColor(const Value: TColor);
begin
  if FBreakpointColor <> Value then
  begin
    FBreakpointColor := Value;
    Invalidate;
  end;
end;

procedure TAdvCustomMemo.SetBreakpointTextColor(const Value: TColor);
begin
  if FBreakpointTextColor <> Value then
  begin
    FBreakpointTextColor := Value;
    Invalidate;
  end;
end;


procedure TAutoCompletion.SetShowImages(const Value: Boolean);
begin
  FShowImages := Value;
end;

{ TAutoCompleteListBox }

function TAutoCompletionListBox.AutoAdaptWidth: Integer;
var
  s: string;
  vp, i: Integer;
  tw, iw, idw: Integer;

begin
  tw := 0;

  idw := 0;
  Canvas.Font.Assign(Font);

  for i := 1 to Items.Count do
  begin
//iw := 0;
    s := Items[i - 1];

    vp := Pos(' ', s);
    if vp > 0 then
    begin
      iw := Canvas.TextWidth(copy(s, 1, vp));
      if iw > idw then
        idw := iw;
    end;
  end;

  FIdentifierWidth := idw;

  for i := 1 to Items.Count do
  begin
    iw := 0;

    s := Items[i - 1];

    vp := Pos(' ', s);
    if vp > 0 then
    begin
      iw := iw + idw;
      delete(s, 1, vp);
    end;

    Canvas.Font.Style := [fsBold];

    vp := Pos('(', s);
    if vp > 0 then
    begin
      iw := iw + Canvas.TextWidth(copy(s, 1, vp - 1));
      delete(s, 1, vp - 1);
      Canvas.Font.Style := [];
      iw := iw + Canvas.TextWidth(s);
    end
    else
      iw := iw + Canvas.TextWidth(s);

    if iw > tw then
      tw := iw;
  end;

  if ShowImages then
    tw := tw + 20;

  iw := Canvas.TextHeight('h_') + 1;
  if iw > 16 then
    ItemHeight := iw
  else
    ItemHeight := 16;

{$IFNDEF TMSCLX}
  Result := tw + 8 + GetSystemMetrics(SM_CXVSCROLL);
{$ENDIF}

{$IFDEF TMSCLX}
  Result := tw + 16;
{$ENDIF}
end;

procedure TAutoCompletionListBox.SetImages(IL: TImageList);
begin
  FImages := IL;

  FBmpVar.FreeImage;
  FBmpProp.FreeImage;
  FBmpEvent.FreeImage;
  FBmpProc.FreeImage;
  FBmpMethod.FreeImage;

  FBmpVar.PixelFormat := pf24bit;
  FBmpProp.PixelFormat := pf24bit;
  FBmpEvent.PixelFormat := pf24bit;
  FBmpProc.PixelFormat := pf24bit;
  FBmpMethod.PixelFormat := pf24bit;

  FImages.GetBitmap(0, FBmpVar);
  FImages.GetBitmap(1, FBmpProp);
  FImages.GetBitmap(2, FBmpEvent);
  FImages.GetBitmap(3, FBmpProc);
  FImages.GetBitmap(4, FBmpMethod);

end;

constructor TAutoCompletionListBox.Create(AOwner: TComponent);
{$IFDEF TMSDOTNET}
var
  BaseAssembly: System.Reflection.Assembly;
{$ENDIF}
begin
  inherited;
  FBmpVar := TBitmap.Create;
  FBmpProp := TBitmap.Create;
  FBmpEvent := TBitmap.Create;
  FBmpProc := TBitmap.Create;
  FBmpMethod := TBitmap.Create;

{$IFNDEF TMSDOTNET}
  FBmpVar.LoadFromResourceName(HInstance, 'TMS_VAR');
  FBmpProp.LoadFromResourceName(HInstance, 'TMS_PROP');
  FBmpEvent.LoadFromResourceName(HInstance, 'TMS_EVENT');
  FBmpProc.LoadFromResourceName(HInstance, 'TMS_PROC');
  FBmpMethod.LoadFromResourceName(HInstance, 'TMS_METHOD');
{$ENDIF}

{$IFDEF TMSDOTNET}
  BaseAssembly := Assembly.GetExecutingAssembly;
  FBmpVar.LoadFromResourceName('TMS_VAR', ResourceBaseName, BaseAssembly);
  FBmpProp.LoadFromResourceName('TMS_PROP', ResourceBaseName, BaseAssembly);
  FBmpEvent.LoadFromResourceName('TMS_EVENT', ResourceBaseName, BaseAssembly);
  FBmpProc.LoadFromResourceName('TMS_PROC', ResourceBaseName, BaseAssembly);
  FBmpMethod.LoadFromResourceName('TMS_METHOD', ResourceBaseName, BaseAssembly);
{$ENDIF}

end;

destructor TAutoCompletionListBox.Destroy;
begin
  FImages := nil;
  FBmpVar.Free;
  FBmpProp.Free;
  FBmpEvent.Free;
  FBmpProc.Free;
  FBmpMethod.Free;
  inherited;
end;

{$IFNDEF TMSCLX}
procedure TAutoCompletionListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
{$ENDIF}
{$IFDEF TMSCLX}
function TAutoCompletionListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState): boolean;
{$ENDIF}
var
  s: string;
  vp: Integer;
  tt: TTokenType;
  bmp: TBitmap;
begin
  Canvas.Pen.Color := Canvas.Brush.Color;
  Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);

  if Index >= 0 then
  begin
    s := Items[Index];

    tt := TTokenType(Items.Objects[Index]);

    bmp := nil;
// ttVar, ttProp, ttEvent, ttMethod, ttFunc, ttProc);
    case tt of
      ttVar: bmp := FBmpVar;
      ttProp: bmp := FBmpProp;
      ttEvent: bmp := FBmpEvent;
      ttMethod: bmp := FBmpMethod;
      ttFunc: bmp := FBmpProc;
      ttProc: bmp := FBmpProc;
    end;

    if (tt <> ttNone) and ShowImages then
    begin
      bmp.Transparent := True;
      bmp.TransparentColor := clLime;
      Canvas.Draw(Rect.Left, Rect.Top, bmp);
    end;

    if ShowImages then
      Rect.Left := Rect.Left + 20;

    vp := Pos(' ', s);
    if vp > 0 then
    begin
      if not (odSelected in State) then
        case tt of
          ttNone: Canvas.Font.Color := ColorIdentifier;
          ttVar: Canvas.Font.Color := ColorVar;
          ttProp: Canvas.Font.Color := ColorProp;
          ttEvent: Canvas.Font.Color := ColorEvent;
          ttMethod: Canvas.Font.Color := ColorMethod;
          ttFunc: Canvas.Font.Color := ColorFunc;
          ttProc: Canvas.Font.Color := ColorProc;
        end;

      Canvas.TextOut(Rect.Left, Rect.Top, copy(s, 1, vp));
//Rect.Left := Rect.Left + Canvas.TextWidth(copy(s,1,vp));
      Rect.Left := Rect.Left + IdentifierWidth;
      delete(s, 1, vp);
    end;

    if not (odSelected in State) then
      Canvas.Font.Color := Font.Color;

    Canvas.Font.Style := [fsBold];

    vp := Pos('(', s);
    if vp > 0 then
    begin
      Canvas.TextOut(Rect.Left, Rect.Top, copy(s, 1, vp - 1));
      Rect.Left := Rect.Left + Canvas.TextWidth(copy(s, 1, vp - 1));
      delete(s, 1, vp - 1);
      Canvas.Font.Style := [];
      Canvas.TextOut(Rect.Left, Rect.Top, s);
    end
    else
      Canvas.TextOut(Rect.Left, Rect.Top, s);
  end;
end;


function TAdvCustomMemo.GetModified: boolean;
begin
  Result := (InternalUndoList.Count > 0);
end;

procedure TAdvCustomMemo.SetModified(const Value: boolean);
begin
  if (Value = False) then
  begin
    ClearUndoList;
    StatusChanged;
    ClearModified;
  end;
end;

function TAdvCustomMemo.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER, REL_VER), MakeWord(MIN_VER, MAJ_VER));
end;

function TAdvCustomMemo.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn))) + '.' + IntToStr(Lo(Hiword(vn))) + '.' + IntToStr(Hi(Loword(vn))) + '.' + IntToStr(Lo(Loword(vn)));
end;

procedure TAdvCustomMemo.SetVersion(const Value: string);
begin
end;

function TAdvCustomMemo.GetVersionString: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn))) + '.' + IntToStr(Lo(Hiword(vn))) + '.' + IntToStr(Hi(Loword(vn))) + '.' + IntToStr(Lo(Loword(vn))) + ' ' + DATE_VER;
end;

function NextWord(var str, strword: string): boolean;
var
  vp: integer;
begin
  vp := pos(' ', str);

  if vp > 0 then
  begin
    strword := copy(str, 1, vp);
    str := copy(str, vp + 1, length(str));
  end;
  Result := vp > 0;
end;


procedure TAdvCustomMemo.DoWrap;
var
  i: Integer;
  os, s, nw, ns: string;
  brk, ovf: boolean;
  sl: TStringList;
{$IFDEF TMSDEBUG}
  t: dword;
{$ENDIF}
  vcc: Integer;
begin
  if InternalLines.Count = 0 then
    Exit;

  if (csLoading in ComponentState) then
    Exit;

  if WordWrap = wwNone then
    Exit;

{$IFDEF TMSDEBUG}
  t := gettickcount;
{$ENDIF}

  FWWList.Clear;

  sl := TStringlist.Create;
  sl.Assign(InternalLines);

// copy lineprops
  for i := 1 to sl.Count do
    sl.Objects[i - 1] := InternalLines.GetLineProp(i - 1);


  // *wwRight*
  
  if WordWrap = wwClientWidth then
    vcc := VisiblePosCount - 1
  else
//    vcc := Min(VisiblePosCount - 1, RightMargin);
   vcc := RightMargin;

  if vcc <= 0 then
    Exit;

  i := 0;

  while i < sl.Count do
  begin
    s := sl.Strings[i];
    os := s;

    if (length(s) > vcc) then
    begin
      ns := '';
      brk := false;
      ovf := false;
      while (length(ns) < vcc) and not brk and not ovf do
      begin
        if NextWord(s, nw) then
        begin
          if (length(ns) + length(nw) < vcc) then
          begin
            ns := ns + nw
          end
          else
          begin
            if ns = '' then
            begin
              brk := true;
              ns := copy(os, 1, vcc);
              s := copy(os, vcc + 1, length(os));
            end
            else
            begin
              s := nw + s;
              ovf := true;
            end;
          end;
        end
        else
        begin
          brk := true;
          if (ns = '') then
          begin
            ns := copy(os, 1, vcc);
            s := copy(os, vcc + 1, length(os));
          end;
        end;
      end;

      sl.Insert(i, ns);
      sl.Strings[i + 1] := s;
      FWWList.Add(i + 1);
      inc(i);
    end
    else
      inc(i);
  end;

  //InternalLines.Clear;
  InternalLines.AssignEx(sl);
  InternalLines.BeginUpdate;

  for i := 1 to sl.Count do
  begin
    if Assigned(sl.Objects[i - 1]) then
      TLineProp(sl.Objects[i - 1]).Wrapped := false;

    InternalLines.RestoreObject(i - 1, sl.Objects[i - 1]);
  end;

  sl.Free;

//  for i := 1 to InternalLines.Count do
//    SetWrapped(i - 1,false);

  for i := 1 to FWWList.Count do
  begin
    SetWrapped(FWWList.Items[i - 1], true);
  end;

  InternalLines.EndUpdate;

  if InternalLines.FLockCount = 0  then
    Invalidate;

{$IFDEF TMSDEBUG}
  outputdebugstring(pchar(inttostr(gettickcount - t) + ':dowrap'));
{$ENDIF}
end;

procedure TAdvCustomMemo.UpdateWrap;
var
  sbvis: boolean;
{$IFDEF TMSDEBUG}
  t: DWORD;
{$ENDIF}
begin
  if WordWrap <> wwNone then
  begin
{$IFDEF TMSDEBUG}
    t := GetTickCount;
{$ENDIF}
    InternalLines.BeginUpdate;
    sbvis := sbVert.Visible;
    UndoWrap;
    sbVert.Visible := sbvis;
    DoWrap;
    InternalLines.EndUpdate;
    ResizeScrollBars(True);
{$IFDEF TMSDEBUG}
    Outputdebugstring(pchar('uw: ' + inttostr(gettickcount - t)));
{$ENDIF}
  end;
end;

procedure TAdvCustomMemo.UndoWrap;
var
  i, offs: Integer;
  sl: TStringList;
{$IFDEF TMSDEBUG}
  t: Integer;
{$ENDIF}

begin
  if InternalLines.Count = 0 then
    Exit;

  if (csLoading in ComponentState) then
    Exit;

  if WordWrap = wwNone then
    Exit;

{$IFDEF TMSDEBUG}
  t := GetTickCount;
{$ENDIF}

  sl := TStringList.Create;
  sl.Assign(InternalLines);


  for i := 1 to sl.Count do
  begin
    sl.Objects[i - 1] := InternalLines.GetLineProp(i - 1);
  end;


  offs := 0;

  FWWList.Clear;
  for i := 1 to InternalLines.Count do
  begin
    if GetWrapped(i - 1) then
    begin
      FWWList.Add(i - 1);
      SetWrapped(i - 1, False);
    end;
  end;

  for i := 1 to FWWList.Count do
  begin
    sl.Strings[FWWList.Items[i - 1] - 1 - offs] := sl.Strings[FWWList.Items[i - 1] - 1 - offs] + sl.Strings[FWWList.Items[i - 1] - offs];
    sl.Delete(FWWList.Items[i - 1] - offs);
    inc(offs);
  end;

//  InternalLines.Clear;

  InternalLines.AssignEx(sl);

  InternalLines.BeginUpdate;
  for i := 1 to sl.Count do
    InternalLines.RestoreObject(i - 1, sl.Objects[i - 1]);

  InternalLines.EndUpdate;

  sl.Free;

{$IFDEF TMSDEBUG}
  Outputdebugstring(pchar(inttostr(gettickcount - t) + ':unodowrap'));
{$ENDIF}
end;
procedure TAdvCustomMemo.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TAdvCustomMemo.DoGutterClick(LineNo: integer);
begin
  if Assigned(FOnGutterClick) then
    FOnGutterClick(Self, LineNo);
end;

procedure TAdvCustomMemo.DoGetAutoCompletionList(AToken: string; AList: TStringList);
begin
  if Assigned(FOnGetAutoCompletionList) then
    FOnGetAutoCompletionList(Self, AToken, AList);
end;

{ TAdvMemoSource }

constructor TAdvMemoSource.Create(AOwner: TComponent);
begin
  inherited;
  FLines := TAdvMemoStrings.Create;
  FUndoList := TAdvUndoList.Create;
  FUndoLimit := 100;
  FModified := False;
  FReadOnly := False;
  FCaretInfo.CurX := 0;
  FCaretInfo.CurY := 0;
  FCaretInfo.LeftCol := 0;
  FCaretInfo.TopLine := 0;
  FBookmarkList := TIntList.Create; ;
end;

destructor TAdvMemoSource.Destroy;
begin
  FLines.Free;
  FUndoList.Free;
  FBookmarkList.Free;
  inherited;
end;

function TAdvMemoSource.GetModified: boolean;
begin
  if FMemo <> nil then
    result := FMemo.Modified
  else
    result := FUndoList.Count > 0;
end;

function TAdvMemoSource.GetReadOnly: boolean;
begin
  if FMemo <> nil then
    result := FMemo.ReadOnly
  else
    result := FReadOnly;

end;

function TAdvMemoSource.GetUndoList: TAdvUndoList;
begin
  result := FUndoList;
end;

procedure TAdvMemoSource.Loaded;
begin
  inherited;
end;

procedure TAdvMemoSource.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FSyntaxStyler) then
  begin
    FSyntaxStyler := nil;
    inherited;
    if FMemo <> nil then
      FMemo.Invalidate;
    Exit;
  end;
  
  if (Operation = opRemove) and (AComponent = FMemo) then
    SetMemo(nil);
    
  inherited;
end;

procedure TAdvMemoSource.SetLines(const Value: TAdvMemoStrings);
begin
  FLines.Clear;
  FLines.AddStrings(Value);
end;

procedure TAdvMemoSource.SetMemo(const Value: TAdvCustomMemo);
var
  i: Integer;
begin
  if (value <> FMemo) then
  begin
    try
      if FMemo <> nil then
      begin
        if FSyntaxStyler <> nil then
          FSyntaxStyler.FAllStyles.FOwner := nil;
        FLines.Memo := nil;
        FLines.OnChange := nil;
        FModified := FMemo.Modified;
        FReadOnly := FMemo.ReadOnly;
        FMemo.GetMemoState(FCaretInfo);

        FBookmarkList.Clear;
        if FMemo.FBookmarkList.Count = 10 then
          for i := 1 to 10 do
            FBookmarkList.Add(FMemo.FBookmarkList.Items[i - 1]);

        FUndoList.Memo := nil;
  //FMemo.ClearUndoList;
        FMemo.Invalidate;
      end;
      FMemo := value;
      if FMemo <> nil then
      begin
        if Assigned(FSyntaxStyler) then
          FSyntaxStyler.FAllStyles.FOwner := TAdvMemo(FMemo);
        FLines.Memo := FMemo;
        FLines.OnChange := FMemo.LinesChanged;
        FMemo.ResetMemoState(FCaretInfo);
        if FBookmarkList.Count = 10 then
          for i := 1 to 10 do
            FMemo.FBookmarkList.Items[i - 1] := FBookmarkList.Items[i - 1];

        FUndoList.Memo := FMemo;
        FMemo.ReadOnly := FReadOnly;
        FMemo.Invalidate;
      end
      else
      begin
        if FSyntaxStyler <> nil then
          FSyntaxStyler.FAllStyles.FOwner := nil;
        FLines.Memo := nil;
        FLines.OnChange := nil;
        FUndoList.Memo := nil;
      end;
    finally
    end;
  end;
end;

procedure TAdvMemoSource.SetModified(const Value: boolean);
begin
  if (FMemo <> nil) then
    FMemo.Modified := Value
  else
    FModified := Value;
end;

procedure TAdvMemoSource.SetReadOnly(const Value: boolean);
begin
  if FMemo <> nil then
    FMemo.ReadOnly := Value
  else
    FReadOnly := Value;
end;

procedure TAdvMemoSource.SetSyntaxStyler(const Value: TAdvCustomMemoStyler);
begin
  if FSyntaxStyler <> value then
  begin
    FSyntaxStyler := Value;
  end;
end;

procedure TAdvMemoSource.SetUndoList(const Value: TAdvUndoList);
{$IFNDEF DELPHI7}
var
  i: Integer;
{$ENDIF}
begin
{$IFDEF DELPHI7}
  FUndoList.Assign(Value);
{$ELSE}
  FUndoList.Clear;

  for i := 1 to Value.Count do
  begin
    FUndoList.Add(Value.Items[i - 1]);
  end;
{$ENDIF}
end;


{ TAdvMemoAction }

destructor TAdvMemoAction.Destroy;
begin
{$IFDEF DELPHI5_LVL}
  if Assigned(FControl) then
    FControl.RemoveFreeNotification(Self);
{$ENDIF}
  inherited;
end;

function TAdvMemoAction.GetControl(Target: TObject): TAdvCustomMemo;
begin
{ We could hard cast Target as a TCustomEdit since HandlesTarget "should" be
called before ExecuteTarget and UpdateTarget, however, we're being safe. }
  Result := Target as TAdvCustomMemo;
end;

function TAdvMemoAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := ((Control <> nil) and (Target = Control) or
    (Control = nil) and (Target is TAdvCustomMemo)) and TCustomEdit(Target).Focused;
end;

procedure TAdvMemoAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Control) then
    Control := nil;
end;

procedure TAdvMemoAction.UpdateTarget(Target: TObject);
begin
  if (Self is TAdvMemoCut) or (Self is TAdvMemoCopy) then
    Enabled := GetControl(Target).SelLength > 0;
end;

procedure TAdvMemoAction.SetControl(Value: TAdvCustomMemo);
begin
  if Value <> FControl then
  begin
    FControl := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

{ TEditCopy }

procedure TAdvMemoCopy.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).CopyToClipboard;
end;

{ TEditCut }

procedure TAdvMemoCut.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).CutToClipboard;
end;

{ TEditPaste }

procedure TAdvMemoPaste.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).PasteFromClipboard;
end;

procedure TAdvMemoPaste.UpdateTarget(Target: TObject);
begin
{$IFNDEF TMSCLX}
  Enabled := Clipboard.HasFormat(CF_TEXT);
{$ENDIF}
end;

{ TEditSelectAll }

procedure TAdvMemoSelectAll.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).SelectAll;
end;

procedure TAdvMemoSelectAll.UpdateTarget(Target: TObject);
begin
  Enabled := Length(GetControl(Target).Lines.Text) > 0;
end;

{ TEditUndo }

procedure TAdvMemoUndo.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).Undo;
end;

procedure TAdvMemoUndo.UpdateTarget(Target: TObject);
begin
  Enabled := GetControl(Target).CanUndo;
end;

{ TAdvMemoRedo }

procedure TAdvMemoRedo.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).Redo;
end;

procedure TAdvMemoRedo.UpdateTarget(Target: TObject);
begin
  Enabled := GetControl(Target).CanRedo;
end;

{ TEditDelete }

procedure TAdvMemoDelete.ExecuteTarget(Target: TObject);
begin
  GetControl(Target).DeleteSelection;
end;

procedure TAdvMemoDelete.UpdateTarget(Target: TObject);
begin
  Enabled := GetControl(Target).SelLength > 0;
end;

{ TAdvMarkers }
function TAdvMarker.GetDisplayName: string;
begin
  Result := Text;
  if Result = '' then Result := inherited GetDisplayName;
end;

constructor TAdvMarker.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := 0;
end;

procedure TAdvMarker.SetText(const Value: string);
begin
  if FText <> Value then
    FText := Value;
end;

procedure TAdvMarker.SetImageIndex(const Value: integer);
begin
  if FImageIndex <> Value then
    FImageIndex := Value;
end;

procedure TAdvMarker.SetLineNumber(const Value: integer);
begin
  if FLineNumber <> Value then
    FLineNumber := Value;
end;

procedure TAdvMarker.Assign(Source: TPersistent);
begin
  if Source is TAdvMarker then
  begin
    Text := TAdvMarker(Source).Text;
    ImageIndex := TAdvMarker(Source).ImageIndex;
    LineNumber := TAdvMarker(Source).LineNumber;
    Exit;
  end;
  inherited Assign(Source);
end;


{ TAdvMarkers }

constructor TAdvMarkers.Create(Component: TPersistent);
begin
  inherited Create(TAdvMarker);
  FComponent := Component;
end;

destructor TAdvMarkers.Destroy;
begin

  inherited Destroy;
end;

function TAdvMarkers.Add: TAdvMarker;
begin
  Result := TAdvMarker(inherited Add);
end;

{$IFNDEF DELPHI5_LVL}
procedure TAdvMarkers.Delete(Index: Integer);
begin
  Items[Index].Free;
end;
{$ENDIF}


function TAdvMarkers.GetItem(Index: Integer): TAdvMarker;
begin
  Result := TAdvMarker(inherited GetItem(Index));
end;

procedure TAdvMarkers.SetItem(Index: Integer;
  Value: TAdvMarker);
begin
  inherited SetItem(Index, Value);
end;

function TAdvMarkers.GetOwner: TPersistent;
begin
  Result := FComponent;
end;

procedure TAdvMarkers.AddMarker(LineIndex, ImageIndex: integer);
var
  Itm: TAdvMarker;
begin
  if MarkerAtLine(LineIndex) then Exit;
  Itm := Add;
  Itm.LineNumber := LineIndex;
  Itm.ImageIndex := ImageIndex;
end;

procedure TAdvMarkers.AddMarker(LineIndex, ImageIndex: integer; MarkerText: string);
var
  Itm: TAdvMarker;
begin
  if MarkerAtLine(LineIndex) then Exit;
  Itm := Add;
  Itm.LineNumber := LineIndex;
  Itm.ImageIndex := ImageIndex;
  Itm.Text := MarkerText;
end;

function TAdvMarkers.GetMarkerCount: integer;
begin
  Result := Count;
end;

function TAdvMarkers.HasMarkers: boolean;
begin
  Result := Count > 0;
end;

function TAdvMarkers.MarkerAtLine(LineNo: Integer): boolean;
var
  i: Integer;
begin
  Result := false;
  for i := 0 to MarkerCount - 1 do
  begin
    if Items[i].FLineNumber = LineNo then
    begin
      Result := true;
      Break;
    end;
  end;
end;

function TAdvMarkers.HigherMarkerThanLine(LineNo: Integer): boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to MarkerCount - 1 do { Iterate }
  begin
    if Items[i].FLineNumber > LineNo then
    begin
      Result := True;
      break;
    end;
  end; { for }
end;

procedure TAdvMarkers.AdjustMarkerLineMinus(StartIndex: integer);
var
  I, LineNo, NewLineNo: Integer;
begin
  for I := Count - 1 downto 0 do { Iterate }
  begin
    LineNo := Items[I].LineNumber;
    if LineNo < StartIndex then
      Continue;
    NewLineNo := LineNo;
    dec(NewLineNo);
    Items[i].LineNumber := NewLineNo;
  end; { for }
end;

procedure TAdvMarkers.AdjustMarkerLinePlus(StartIndex: integer);
var
  LineNo, I, NewLineNo: Integer;
begin
  for I := MarkerCount - 1 downto 0 do { Iterate }
  begin
    LineNo := Items[i].FLineNumber;
    if LineNo < StartIndex then
      continue;

    NewLineNo := LineNo;
    inc(NewLineNo);
    Items[i].LineNumber := NewLineNo;
  end; { for }

end;

procedure TAdvMarkers.RemoveMarker(LineNo: integer);
var
  i: Integer;
begin
  if MarkerAtLine(LineNo) then
  begin
    for i := 0 to MarkerCount - 1 do
    begin
      if Items[i].FLineNumber = LineNo then
      begin
        Delete(i);
        Break;
      end;
    end;
  end;
end;

function TAdvMarkers.GetMarkerImageIndex(LineNo: integer): integer;
var
  m: TAdvMarker;
begin
  Result := -1;

  if MarkerAtLine(LineNo)
    then begin
    m := GetMarkerAtLine(LineNo);
    Result := m.FImageIndex;
  end;
end;

function TAdvMarkers.GetMarkers(Markers: TAdvMarkers): boolean;
begin
  Markers.Assign(Self);
  Result := Count > 0;
end;

function TAdvMarkers.GetMarkerAtLine(LineNo: integer): TAdvMarker;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to MarkerCount - 1 do
  begin
    if Items[i].FLineNumber = LineNo then
    begin
      Result := Items[i];
      Break;
    end;
  end;
end;

{ TAdvMarkerList }

procedure TAdvMarkerList.SetMarkerImageList(IL: TImageList);
begin
  FMarkerImageList := IL;
end;

procedure TAdvMarkerList.SetMarkerTransparentColor(MarkerTransColor: TColor);
begin
  if Assigned(FMarkerImage) then
    FMarkerImage.TransparentColor := MarkerTransColor;
end;

function TAdvMarkerList.GetMarkerTransparentColor: TColor;
begin
  Result := clWhite;
  if Assigned(FMarkerImage) then
    Result := FMarkerImage.TransparentColor;
end;

procedure TAdvMarkerList.SetDefaultMarkerImageIndex(MarkerIndex: integer);
begin
  if csLoading in FOwner.ComponentState then
    Exit;
  FDefaultMarkerImageIndex := MarkerIndex;
end;

procedure TAdvMarkerList.SetUseDefaultMarkerImageIndex(Value: boolean);
begin
  if csLoading in FOwner.ComponentState then
    Exit;
  FUseDefaultMarkerImageIndex := Value;
end;

constructor TAdvMarkerList.Create(AOwner: TComponent);
begin
  inherited Create;
  FOwner := AOwner;
  FMarkers := TAdvMarkers.Create(Self);
  FMarkerImage := TBitmap.Create;
  FDefaultMarkerImageIndex := -1;
end;

destructor TAdvMarkerList.Destroy;
begin
  FMarkerImage.Free;
  FMarkers.Free;
  inherited Destroy;
end;

procedure TAdvMarkerList.SetItems(Value: TAdvMarkers);
begin
  FMarkers.Assign(Value);
end;

procedure TAdvMarkerList.FastDeleteAll;
begin
  FMarkers.Clear;
  TAdvCustomMemo(FOwner).FGutter.Invalidate;
end;


{ TAdvStylerList }

procedure TAdvStylerList.Notification(comp: TComponent; Operation: TOperation);
begin
  inherited;
  {$IFNDEF TMSDOTNET}
  if (Operation in [opInsert]) and (Comp.ClassParent = TAdvCustomMemoStyler) then
    FStylerList.Add(Pointer(Comp));
  if (Operation in [opRemove]) and (Comp.ClassParent = TAdvCustomMemoStyler) then
  begin
    if FStylerList.IndexOf(Pointer(Comp)) > -1 then
      FStylerList.Delete(FStylerList.IndexOf(Pointer(Comp)));
  end;
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  if (Operation in [opInsert]) and (Comp.ClassParent = TAdvCustomMemoStyler) then
    FStylerList.Add(Comp);
  if (Operation in [opRemove]) and (Comp.ClassParent = TAdvCustomMemoStyler) then
  begin
    if FStylerList.IndexOf(Comp) > -1 then
      FStylerList.Delete(FStylerList.IndexOf(Comp));
  end;
  {$ENDIF}

end;

constructor TAdvStylerList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStylerList := TList.Create;
end;

destructor TAdvStylerList.Destroy;
begin
  FStylerList.Free;
  inherited Destroy;
end;

{ TAdvMemoChecker }

procedure TAdvMemoChecker.CheckLine(LineNo: Integer);
var
  s:string;
begin
  if Assigned(FMemo) then
  begin
    s := FMemo.Lines[LineNo];
    FMemo.ClearLineErrors(LineNo);
  end;
end;

procedure TAdvMemoChecker.CorrectLine(LineNo: Integer);
begin

end;

procedure TAdvMemoChecker.CorrectWord(LineNo,LinePos: Integer; var s: string);
begin
end;

procedure TAdvMemoChecker.CheckWord(LineNo,LinePos: Integer; s: string);
begin
end;

procedure TAdvMemoChecker.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AComponent = FMemo) and (AOperation = opRemove) then
    FMemo := nil;
end;

function TAdvMemoChecker.ReplaceOnce(const S, OldPattern, NewPattern: string): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  SearchStr := S;
  Patt := OldPattern;

  NewStr := S;
  Result := '';

  {$IFDEF DELPHI3_LVL}
  Offset := AnsiPos(Patt, SearchStr);
  {$ELSE}
  Offset := Pos(Patt, SearchStr);
  {$ENDIF}

  if Offset = 0 then
    Result := Result + NewStr
  else
  begin
    Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    Result := Result + NewStr;
  end;
end;

procedure TAdvMemoChecker.AddUndo(LineNo: integer; UndoLine: string);
var
  cu: TCorrectUndo;
begin
  cu := TCorrectUndo.Create(LineNo, UndoLine);
  FMemo.FUndoList.Add(cu);
end;

procedure TAdvMemoChecker.CheckAllLines;
var
  i: Integer;
begin
  for i := 1 to Memo.Lines.COunt do
    CheckLine(i - 1);
end;

procedure TAdvMemoChecker.CorrectAllLines;
var
  i: Integer;
begin
  for i := 1 to Memo.Lines.COunt do
    CorrectLine(i - 1);
end;


{ TAdvMemoCapitalChecker }

constructor TAdvMemoCapitalChecker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoCorrectType := acLineCorrect;
end;


procedure TAdvMemoCapitalChecker.CorrectLine(LineNo: Integer);
var
  Prev,PrevPrev: char;
  i: Integer;
  s: string;
  FUndoText: string;
begin
  Prev := ' ';
  PrevPrev := '.';
  if Assigned(FMemo) then
  begin
    if Assigned(FMemo.MemoSource) then
      s:= FMemo.MemoSource.Lines[LineNo]
    else
      s := FMemo.Lines[LineNo];

    FUndoText := s;

    for i := 1 to Length(s) do
    begin
      if (Prev = ' ') and ( (PrevPrev = '!') or (PrevPrev = '?') or (PrevPrev = '.')) and (s[i] <> Upcase(s[i])) then
        s[i] := UpCase(s[i]);
      PrevPrev := Prev;
      Prev := s[i];
    end;

    if Assigned(FMemo.MemoSource) then
      FMemo.MemoSource.Lines[LineNo] := s
    else
      FMemo.Lines[LineNo] := s;

    FMemo.Modified := true;

    AddUndo(LineNo,FUndoText);
  end;
end;

{ TCodeFolding }

constructor TCodeFolding.Create;
begin
  inherited;
  FEnabled := False;
  FExpandGlyph := TBitMap.Create;
  FCollapsedGlyph := TBitMap.Create;
  FLineColor := clGray;
end;

destructor TCodeFolding.Destroy;
begin
  FExpandGlyph.Free;
  FCollapsedGlyph.Free;
  inherited;
end;

procedure TCodeFolding.Assign(Source: TPersistent);
begin
  if (Source is TCodeFolding) then
  begin
    FEnabled := (Source as TCodeFolding).Enabled;
    FLineColor := (Source as TCodeFolding).LineColor;
  end;  
end;

procedure TCodeFolding.Changed(ChangeMsg: Integer);
begin
  if Assigned(FOnChange) then
    FOnChange(Self, ChangeMsg);
end;

procedure TCodeFolding.SetCollapsedGlyph(const Value: TBitMap);
begin
  FCollapsedGlyph.Assign(Value);
  Changed(1);
end;

procedure TCodeFolding.SetEnabled(const Value: Boolean);
begin
  if (FEnabled <> Value) then
  begin
    FEnabled := Value;
    Changed(2);
  end;
end;

procedure TCodeFolding.SetExpandGlyph(const Value: TBitMap);
begin
  FExpandGlyph.Assign(Value);
  Changed(1);
end;

procedure TCodeFolding.SetLineColor(const Value: TColor);
begin
  if (FLineColor <> Value) then
  begin
    FLineColor := Value;
    Changed(1);
  end;
end;


constructor TRegionDefinition.Create(Collection: TCollection);
begin
  inherited;
  FRegionType := rtClosed;
  FRegionEnd := '';
  FIdentifier := '';
  FRegionStart := '';
end;

procedure TRegionDefinition.Assign(Source: TPersistent);
begin
  if (Source is TRegionDefinition) then
  begin
    FRegionType := (Source as TRegionDefinition).RegionType;
    FRegionEnd := (Source as TRegionDefinition).RegionEnd;
    FIdentifier := (Source as TRegionDefinition).Identifier;
    FRegionStart := (Source as TRegionDefinition).RegionStart;
  end
  else
    inherited;
end;

procedure TRegionDefinition.SetIdentifier(const Value: string);
begin
  FIdentifier := Trim(Value);
end;

procedure TRegionDefinition.SetRegionEnd(const Value: string);
begin
  FRegionEnd := Trim(Value);
end;

procedure TRegionDefinition.SetRegionStart(const Value: string);
begin
  FRegionStart := Trim(Value);
end;

procedure TRegionDefinition.SetRegionType(const Value: TRegionType);
begin
  FRegionType := Value;
end;

function TRegionDefinition.GetDisplayName: string;
begin
  Result := inherited GetDisplayName;
end;

constructor TRegionDefinitions.Create(Component: TPersistent);
begin
  inherited Create(TRegionDefinition);
  FComponent := Component;
end;

destructor TRegionDefinitions.Destroy;
begin
  inherited;
end;

function TRegionDefinitions.GetItem(Index: Integer): TRegionDefinition;
begin
  Result := TRegionDefinition(inherited Items[Index]);
end;

procedure TRegionDefinitions.SetItem(Index: Integer; Value: TRegionDefinition);
begin
  inherited Items[Index] := Value;
end;

function TRegionDefinitions.GetOwner: TPersistent;
begin
  Result := FComponent;
end;

function TRegionDefinitions.Add: TRegionDefinition;
begin
  Result := TRegionDefinition(inherited Add);
end;

function TRegionDefinitions.Insert(Index: Integer): TRegionDefinition;
begin
  Result := TRegionDefinition(inherited Insert(Index));
end;


{$IFDEF FREEWARE}
{$I TRIAL.INC}
{$ENDIF}


end.
