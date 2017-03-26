{**************************************************************************}
{ TAdvSmoothTimeLine component                                                }
{ for Delphi & C++Builder                                                  }
{                                                                          }
{ written                                                                  }
{   TMS Software                                                           }
{   copyright © 2009                                                       }
{   Email : info@tmssoftware.com                                           }
{   Web : http://www.tmssoftware.com                                       }
{                                                                          }
{ The source code is given as is. The author is not responsible            }
{ for any possible damage done due to the use of this code.                }
{ The component can be freely used in any application. The complete        }
{ source code remains property of the author and may not be distributed,   }
{ published, given or sold in any form as such. No parts of the source     }
{ code can be included in any other component or application without       }
{ written authorization of the author.                                     }
{**************************************************************************}

unit AdvSmoothTimeLine;

{$I TMSDEFS.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, forms,
  Math, AdvStyleIF, ImgList, DateUtils,
  AdvSmoothGDIP, GDIPFill, Menus
  {$IFDEF TMSDOTNET}
  , Types
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : first release

type
  TWinCtrl = class(TWinControl)
  public
    procedure PaintCtrls(DC: HDC; First: TControl);
  end;

  TAdvSmoothTimeLine = class;

  TAdvSmoothSectionHint = class(THintWindow)
  private
    FMainBuffer: TGPBitmap;
    FTimeLine: TAdvsmoothTimeLine;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    Procedure CMDialogKey(Var Msg: TWMKey); message CM_DIALOGKEY;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;  
  protected
    procedure CreateWnd; override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    // ---- Calc proc
    procedure UpdateButtons;

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
  public
    procedure Init;
    property TimeLine: TAdvsmoothTimeLine read FTimeLine write FTimeLine;
  end;

  TAdvSmoothTimeLineRangeAppearance = class(TPersistent)
  private
  FOwner: TAdvSmoothTimeLine;
    FSubDivisionTickMarkColor: TColor;
    FDivisionTickMarkColor: TColor;
    FSubDivisionFont: TFont;
    FDivisionFont: TFont;
    FSubDivisionTickMarkSize: integer;
    FDivisionTickMarkSize: integer;
    FOnChange: TNotifyEvent;
    FSubDivisionTickMarkWidth: integer;
    FDivisionTickMarkWidth: integer;
    FDivisionFormat: String;
    FSubDivisionFormat: String;
    FIndentSpacing: integer;
    FShowSubDivisionValue: Boolean;
    FShowDivisionValue: Boolean;
    procedure SetDivisionTickMarkColor(const Value: TColor);
    procedure SetDivisionFont(const Value: TFont);
    procedure SetSubDivisionFont(const Value: TFont);
    procedure SetSubDivisionTickMarkColor(const Value: TColor);
    procedure SetDivisionTickMarkSize(const Value: integer);
    procedure SetSubDivisionTickMarkSize(const Value: integer);
    procedure SetDivisionTickMarkWidth(const Value: integer);
    procedure SetSubDivisionTickMarkWidth(const Value: integer);
    procedure SetDivisionFormat(const Value: String);
    procedure SetSubDivisionFormat(const Value: String);
    procedure SetIndentSpacing(const Value: integer);
    procedure SetShowDivisionValue(const Value: Boolean);
    procedure SetShowSubDivisionValue(const Value: Boolean);
  protected
    procedure Changed;
    procedure FontChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothTimeLine);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property DivisionFont: TFont read FDivisionFont write SetDivisionFont;
    property SubDivisionFont: TFont read FSubDivisionFont write SetSubDivisionFont;
    property DivisionTickMarkColor: TColor read FDivisionTickMarkColor write SetDivisionTickMarkColor default clBlack;
    property SubDivisionTickMarkColor: TColor read FSubDivisionTickMarkColor write SetSubDivisionTickMarkColor default clBlack;
    property DivisionTickMarkSize: integer read FDivisionTickMarkSize write SetDivisionTickMarkSize default 10;
    property SubDivisionTickMarkSize: integer read FSubDivisionTickMarkSize write SetSubDivisionTickMarkSize default 8;
    property DivisionTickMarkWidth: integer read FDivisionTickMarkWidth write SetDivisionTickMarkWidth default 2;
    property SubDivisionTickMarkWidth: integer read FSubDivisionTickMarkWidth write SetSubDivisionTickMarkWidth default 1;
    property DivisionFormat: String read FDivisionFormat write SetDivisionFormat;
    property SubDivisionFormat: String read FSubDivisionFormat write SetSubDivisionFormat;
    property IndentSpacing: integer read FIndentSpacing write SetIndentSpacing default 20;
    property ShowDivisionValue: Boolean read FShowDivisionValue write SetShowDivisionValue default true;
    property ShowSubDivisionValue: Boolean read FShowSubDivisionValue write SetShowSubDivisionValue default true;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothTimeLineRange = class(TPersistent)
  private
    FOwner: TAdvSmoothTimeLine;
    FRangeFrom: TDateTime;
    FRangeTo: TDateTime;
    FSubDivisions: integer;
    FDivisions: integer;
    FOnChange: TNotifyEvent;
    procedure SetRangeFrom(const Value: TDateTime);
    procedure SetRangeTo(const Value: TDateTime);
    procedure SetDivisions(const Value: integer);
    procedure SetSubDivisions(const Value: integer);
  protected
    procedure Changed;
  public
    constructor Create(AOwner: TAdvSmoothTimeLine);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property RangeFrom: TDateTime read FRangeFrom write SetRangeFrom;
    property RangeTo: TDateTime read FRangeTo write SetRangeTo;
    property Divisions: integer read FDivisions write SetDivisions default 2;
    property SubDivisions: integer read FSubDivisions write SetSubDivisions default 5;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothTimeLineBarIndicatorShape = (isTriangleUp, isTriangleDown, isSquare, isDiamond, isCircle, isNone, isPicture);

  TAdvSmoothTimeLineBarIndicator = class(TCollectionItem)
  private
    FOwner: TAdvSmoothTimeLine;
    FPosition: TDateTime;
    FShape: TAdvSmoothTimeLineBarIndicatorShape;
    FBorderColor: TColor;
    FGradientType: TAdvGradientType;
    FOpacity: Byte;
    FOpacityTo: Byte;
    FAngle: integer;
    FColor: TColor;
    FColorTo: TColor;
    FBorderOpacity: Byte;
    FBorderWidth: integer;
    FPicture: TAdvGDIPPicture;
    FSize: integer;
    FHint: String;
    FTickMarkSize: integer;
    FShowTickMark: Boolean;
    FTickMarkWidth: integer;
    FTickMarkColor: TColor;
    FPopupMenu: TPopupMenu;
    procedure SetPosition(const Value: TDateTime);
    procedure SetShape(const Value: TAdvSmoothTimeLineBarIndicatorShape);
    procedure SetAngle(const Value: integer);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderOpacity(const Value: Byte);
    procedure SetBorderWidth(const Value: integer);
    procedure SetColor(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientType(const Value: TAdvGradientType);
    procedure SetOpacity(const Value: Byte);
    procedure SetOpacityTo(const Value: Byte);
    procedure SetPicture(const Value: TAdvGDIPPicture);
    procedure SetSize(const Value: integer);
    procedure SetHint(const Value: String);
    procedure SetShowTickMark(const Value: Boolean);
    procedure SetTickMarkColor(const Value: TColor);
    procedure SetTickMarkSize(const Value: integer);
    procedure SetTickMarkWidth(const Value: integer);
  protected
    procedure Changed;
    procedure PictureChanged(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetIndicatorRect: TGPRectF;
  published
    property Position: TDateTime read FPosition write SetPosition;
    property Shape: TAdvSmoothTimeLineBarIndicatorShape read FShape write SetShape default isDiamond;
    property Color: TColor read FColor write SetColor default clGray;
    property ColorTo: TColor read FColorTo write SetColorTo default clSilver;
    property Opacity: Byte read FOpacity write SetOpacity default 255;
    property OpacityTo: Byte read FOpacityTo write SetOpacityTo default 255;
    property Angle: integer read FAngle write SetAngle default 0;
    property GradientType: TAdvGradientType read FGradientType write SetGradientType default gtForwardDiagonal;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property BorderOpacity: Byte read FBorderOpacity write SetBorderOpacity default 255;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 1;
    property Picture: TAdvGDIPPicture read FPicture write SetPicture;
    property Size: integer read FSize write SetSize default 15;
    property Hint: String read FHint write SetHint;
    property ShowTickMark: Boolean read FShowTickMark write SetShowTickMark default true;
    property TickMarkSize: integer read FTickMarkSize write SetTickMarkSize default 10;
    property TickMarkWidth: integer read FTickMarkWidth write SetTickMarkWidth default 1;
    property TickMarkColor: TColor read FTickMarkColor write SetTickMarkColor default clBlack;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
  end;

  TAdvSmoothTimeLineBarIndicators = class(TCollection)
  private
    FOwner: TAdvSmoothTimeLine;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TAdvSmoothTimeLineBarIndicator;
    procedure SetItem(Index: Integer; const Value: TAdvSmoothTimeLineBarIndicator);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TAdvSmoothTimeLine);
    function Add: TAdvSmoothTimeLineBarIndicator;
    function Insert(Index: Integer): TAdvSmoothTimeLineBarIndicator;
    property Items[Index: Integer]: TAdvSmoothTimeLineBarIndicator read GetItem write SetItem; default;
    procedure Delete(Index: Integer);
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothTimeLineBarSection = class(TCollectionItem)
  private
    FOwner: TAdvSmoothTimeLine;
    FStartTime: TDateTime;
    FEndTime: TDateTime;
    FFill: TGDIPFill;
    FHint: String;
    FHintFill: TGDIPFill;
    FHintFont: TFont;
    FHintAutoSize: Boolean;
    FHintWidth: integer;
    FHintHeight: integer;
    procedure SetEndTime(const Value: TDateTime);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetStartTime(const Value: TDateTime);
    procedure SetHint(const Value: String);
    procedure SetHintFill(const Value: TGDIPFill);
    procedure SetHintFont(const Value: TFont);
    procedure SetHintAutoSize(const Value: Boolean);
    procedure SetHintHeight(const Value: integer);
    procedure SetHintWidth(const Value: integer);
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure FontChanged(Sender: TObject);
    function GetSectionRect: TGPRectF;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Fill: TGDIPFill read FFill write SetFill;
    property StartTime: TDateTime read FStartTime write SetStartTime;
    property EndTime: TDateTime read FEndTime write SetEndTime;
    property Hint: String read FHint write SetHint;
    property HintFill: TGDIPFill read FHintFill write SetHintFill;
    property HintFont: TFont read FHintFont write SetHintFont;
    property HintAutoSize: Boolean read FHintAutoSize write SetHintAutoSize default true;
    property HintWidth: integer read FHintWidth write SetHintWidth default 50;
    property HintHeight: integer read FHintHeight write SetHintHeight default 20;
  end;

  TAdvSmoothTimeLineBarSections = class(TCollection)
  private
    FOwner: TAdvSmoothTimeLine;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TAdvSmoothTimeLineBarSection;
    procedure SetItem(Index: Integer; const Value: TAdvSmoothTimeLineBarSection);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TAdvSmoothTimeLine);
    function Add: TAdvSmoothTimeLineBarSection;
    function Insert(Index: Integer): TAdvSmoothTimeLineBarSection;
    property Items[Index: Integer]: TAdvSmoothTimeLineBarSection read GetItem write SetItem; default;
    procedure Delete(Index: Integer);
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothTimeLineBar = class(TPersistent)
  private
    FOwner: TAdvSmoothTimeLine;
    FSections: TAdvSmoothTimeLineBarSections;
    FFill: TGDIPFill;
    FHeight: integer;
    FOnChange: TNotifyEvent;
    procedure SetFill(const Value: TGDIPFill);
    procedure SetHeight(const Value: integer);
  protected
    procedure Changed;
    procedure FillChanged(Sender: TOBject);
    procedure SectionsChanged(Sender: TOBject);
  public
    constructor Create(AOwner: TAdvSmoothTimeLine);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Fill: TGDIPFill read FFill write SetFill;
    property Height: integer read FHeight write SetHeight default 10;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothTimeLineDivisionText = procedure(Sender: TObject; DivisionValue: TDateTime; var DivisionValueString: String) of object;

  TAdvSmoothTimeLineIndicatorClick = procedure(Sender: TObject; indicator: TAdvSmoothTimeLineBarIndicator) of object;

  TAdvSmoothTimeLineIndicatorPosition = procedure(Sender: TObject; indicator: TAdvSmoothTimeLineBarIndicator; Position: TDateTime) of object;

  TAdvSmoothTimeLineIndicatorHint = procedure(Sender: TObject; indicator: TAdvSmoothTimeLineBarIndicator; var hint: String) of object;

  TAdvSmoothTimeLine = class(TCustomControl, ITMSStyle)
  private
    FDesignTime, FMbRight: Boolean;
    FCx, FCy, FPx, FPy: integer;
    FMouseMovedOnIndicator: Boolean;
    FMouseDownOnIndicator: Boolean;
    FhintSizeCalculated: Boolean;
    Fh: TAdvSmoothSectionHint;
    FHoveredSection, FHoveredIndicator, FSelectedIndicator: integer;
    FRange: TAdvSmoothTimeLineRange;
    FRangeAppearance: TAdvSmoothTimeLineRangeAppearance;
    FFill: TGDIPFill;
    FTimeLineBar: TAdvSmoothTimeLineBar;
    FTimeLineBarSections: TAdvSmoothTimeLineBarSections;
    FDefaultHintFill: TGDIPFill;
    FDefaultSectionFill: TGDIPFill;
    FVerticalMargin: integer;
    FHorizontalMargin: integer;
    FOnSubDivisionText: TAdvSmoothTimeLineDivisionText;
    FOnDivisionText: TAdvSmoothTimeLineDivisionText;
    FTimeLineIndicators: TAdvSmoothTimeLineBarIndicators;
    FOnIndicatorClick: TAdvSmoothTimeLineIndicatorClick;
    FOnIndicatorPositionChanged: TAdvSmoothTimeLineIndicatorPosition;
    FOnIndicatorHint: TAdvSmoothTimeLineIndicatorHint;
    FDefaultIndicators: TAdvSmoothTimeLineBarIndicators;
    FDefaultIndicator: TAdvSmoothTimeLineBarIndicator;
    FOnIndicatorPositionChanging: TAdvSmoothTimeLineIndicatorPosition;
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure SetRange(const Value: TAdvSmoothTimeLineRange);
    procedure SetRangeAppearance(
      const Value: TAdvSmoothTimeLineRangeAppearance);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetTimeLineBar(const Value: TAdvSmoothTimeLineBar);
    procedure SetTimeLineBarSections(
      const Value: TAdvSmoothTimeLineBarSections);
    procedure SetDefaultHintFill(const Value: TGDIPFill);
    procedure SetDefaultSectionFill(const Value: TGDIPFill);
    procedure SetHorizontalMargin(const Value: integer);
    procedure SetVerticalMargin(const Value: integer);
    procedure SetTimeLineIndicators(
      const Value: TAdvSmoothTimeLineBarIndicators);
    procedure SetDefaultIndicator(const Value: TAdvSmoothTimeLineBarIndicator);
  protected
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Changed;
    procedure RangeChanged(Sender: TObject);
    procedure RangeAppearanceChanged(Sender: TObject);
    procedure TimeLineBarChanged(Sender: TObject);
    procedure TimeLineBarSectionsChanged(Sender: TObject);
    procedure TimeLineBarIndicatorsChanged(Sender: TOBject);
    procedure FillChanged(Sender: TObject);
    procedure DrawBackground(g: TGPGraphics);
    procedure DrawTimeLineValues(g: TGPGraphics);
    procedure DrawTimeLineTickMarks(g: TGPGraphics);
    procedure DrawTimeBarIndicators(g: TGPGraphics);
    procedure DrawTimeBar(g: TGPGraphics);
    procedure DrawTimeBarSections(g: TGPGraphics);
    procedure DrawSectionHint(g: TGPGraphics);
    procedure CalculateHintSize(h: TAdvSmoothSectionHint);
    function InsideRect: TRect;
    function GetTimeLineBarRect: TGPRectF;
    function GetTimeLineRect: TGPRectF;
    function GetRange: Double;
    function SectionAtXY(X, Y: integer): integer;
    function IndicatorAtXY(X, Y: integer): integer;
    function PtInGPRect(r: TGPRectF; pt: TPoint): Boolean;
    function GetXPosition(Value: TDateTime): integer;
    function GetValuePosition(X: integer; indicator: integer): TDateTime;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Paint; override;
    procedure SetComponentStyle(AStyle: TTMSStyle);
  published
    property DefaultHintFill: TGDIPFill read FDefaultHintFill write SetDefaultHintFill;
    property DefaultSectionFill: TGDIPFill read FDefaultSectionFill write SetDefaultSectionFill;
    property DefaultIndicator: TAdvSmoothTimeLineBarIndicator read FDefaultIndicator write SetDefaultIndicator;
    property Range: TAdvSmoothTimeLineRange read FRange write SetRange;
    property RangeAppearance: TAdvSmoothTimeLineRangeAppearance read FRangeAppearance write SetRangeAppearance;
    property Fill: TGDIPFill read FFill write SetFill;
    property VerticalMargin: integer read FVerticalMargin write SetVerticalMargin default 10;
    property HorizontalMargin: integer read FHorizontalMargin write SetHorizontalMargin default 25;
    property TimeLineBar: TAdvSmoothTimeLineBar read FTimeLineBar write SetTimeLineBar;
    property TimeLineSections: TAdvSmoothTimeLineBarSections read FTimeLineBarSections write SetTimeLineBarSections;
    property TimeLineIndicators: TAdvSmoothTimeLineBarIndicators read FTimeLineIndicators write SetTimeLineIndicators;

    property OnIndicatorHint: TAdvSmoothTimeLineIndicatorHint read FOnIndicatorHint write FOnIndicatorHint;
    property OnIndicatorPositionChanged: TAdvSmoothTimeLineIndicatorPosition read FOnIndicatorPositionChanged write FOnIndicatorPositionChanged;
    property OnIndicatorPositionChanging: TAdvSmoothTimeLineIndicatorPosition read FOnIndicatorPositionChanging write FOnIndicatorPositionChanging;
    property OnIndicatorClick: TAdvSmoothTimeLineIndicatorClick read FOnIndicatorClick write FOnIndicatorClick;
    property OnDivisionText: TAdvSmoothTimeLineDivisionText read FOnDivisionText write FOnDivisionText;
    property OnSubDivisionText: TAdvSmoothTimeLineDivisionText read FOnSubDivisionText write FOnSubDivisionText;

    property Visible;
    property ShowHint;

    property Align;
    property Anchors;
    property Constraints;
    property DragMode;
    property DragCursor;
    property DragKind;

    {$IFDEF DELPHI2006_LVL}
    property OnCanResize;
    property OnConstrainedResize;
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    {$IFDEF DELPHI2006_LVL}
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseDown;
    property OnClick;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property Enabled;
  end;

implementation

{ TAdvSmoothTimeLine }

procedure TAdvSmoothTimeLine.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothTimeLine) then
  begin
    Frange.Assign((Source as TAdvSmoothTimeLine).Range);
    FRangeAppearance.Assign((Source as TAdvSmoothTimeLine).RangeAppearance);
    FFill.Assign((Source as TAdvSmoothTimeLine).Fill);
    FVerticalMargin := (Source as TAdvSmoothTimeLine).VerticalMargin;
    FHorizontalMargin := (Source as TAdvSmoothTimeLine).HorizontalMargin;
    FTimeLineBar.Assign((Source as TAdvSmoothTimeLine).TimeLineBar);
    FTimeLineBarSections.Assign((Source as TAdvSmoothTimeLine).TimeLineSections);
    FDefaultHintFill.Assign((Source as TAdvSmoothTimeLine).FDefaultHintFill);
    FDefaultSectionFill.Assign((Source as TAdvSmoothTimeLine).FDefaultSectionFill);
    FTimeLineIndicators.Assign((Source as TAdvSmoothTimeLine).TimeLineIndicators);
    FDefaultIndicator.Assign((source as TAdvSmoothTimeLine).DefaultIndicator);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.CalculateHintSize(h: TAdvSmoothSectionHint);
var
  ff: TGPFontFamily;
  f: TGPFont;
  fs: integer;
  sf: TGPStringFormat;
  fillr, layr, sizer: TGPRectF;
  b: TGPSolidBrush;
  x, y: integer;
  g: TGPGraphics;
begin
  if (FHoveredSection >= 0) and (FHoveredSection <= TimeLineSections.Count - 1) then
  begin
    with TimeLineSections[FHoveredSection] do
    begin
      g := TGPGraphics.Create(Canvas.Handle);

      ff := TGPFontFamily.Create(HintFont.Name);
      if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
      begin
        ff.Free;
        ff := TGPFontFamily.Create('Arial');
      end;

      fs := 0;
      if (fsBold in HintFont.Style) then
        fs := fs + 1;
      if (fsItalic in HintFont.Style) then
        fs := fs + 2;
      if (fsUnderline in HintFont.Style) then
        fs := fs + 4;

      sf := TGPStringFormat.Create;        
      if HintAutoSize then      
        Layr := MakeRect(0, 0, 10000, 10000)        
      else
        Layr := MakeRect(0, 0, HintWidth, HintHeight);      

      f := TGPFont.Create(ff, HintFont.Size, fs, UnitPoint);
      b := TGPSolidBrush.Create(MakeColor(255, Hintfont.Color));
      g.MeasureString(Hint, length(Hint), f, layr, sf, sizer);

      x := 0;
      y := 0;

      if HintAutoSize then      
        fillr := MakeRect(x, y, sizer.Width + 5, sizer.Height + 5)
      else
        fillr := MakeRect(x, y, layr.Width + 5, layr.Height + 5);

      Fh.Width := Round(fillr.Width);
      Fh.Height := Round(fillr.Height);

      if not HintFill.Picture.Empty then
      begin
        HintFill.Picture.GetImageSizes;
        fh.Width := Max(fh.Width, hintfill.Picture.Width);
        fh.Height := Max(fh.Height, hintfill.Picture.Height);
      end;

      fh.Width := fh.Width + 1;
      fh.Height := fh.Height + 1;
              
      b.Free;
      f.Free;
      ff.Free;      
      sf.Free;
      g.Free;
    end;
  end;
end;

procedure TAdvSmoothTimeLine.Changed;
begin
  invalidate;
end;

procedure TAdvSmoothTimeLine.CMHintShow(var Message: TMessage);
var
  hint: String;
  id: integer;
  pt: TPoint;
begin
  with TCMHintShow(Message).HintInfo^ do
  begin
    pt := CursorPos;
    id := IndicatorAtXY(pt.X, pt.Y);
    if id <> -1 then
    begin
      hint := TimeLineIndicators[id].Hint;
      if Assigned(OnIndicatorHint) then
        OnIndicatorHint(Self, TimeLineIndicators[id], hint);
      HintStr := hint;
      ReshowTimeout := 0;
    end;
  end;
end;

procedure TAdvSmoothTimeLine.CMMouseLeave(var Message: TMessage);
begin
  FHoveredSection := -1;
  FMouseMovedOnIndicator := false;
  FMouseDownOnIndicator := false;
  if Fh.Visible then
    FH.Hide;
  Application.CancelHint;
  Changed;
end;

constructor TAdvSmoothTimeLine.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := true;
  FRange := TAdvSmoothTimeLineRange.Create(Self);
  FRange.OnChange := RangeChanged;
  FRangeAppearance := TAdvSmoothTimeLineRangeAppearance.Create(Self);
  FRangeAppearance.OnChange := RangeAppearanceChanged;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FVerticalMargin := 10;
  FHorizontalMargin := 25;
  Width := 500;
  Height := 80;
  FTimeLineBar := TAdvSmoothTimeLineBar.Create(Self);
  FTimeLineBar.OnChange := TimeLineBarChanged;
  FTimeLineBarSections := TAdvSmoothTimeLineBarSections.Create(Self);
  FTimeLinebarSections.OnChange := TimeLineBarSectionsChanged;
  FDefaultHintFill := TGDIPFill.Create;
  FDefaultSectionFill := TGDIPFill.Create;
  FTimeLineIndicators := TAdvSmoothTimeLineBarIndicators.Create(Self);
  FTimeLineIndicators.OnChange := TimeLineBarIndicatorsChanged;
  FHoveredSection := -1;
  FHoveredIndicator := -1;
  FSelectedIndicator := -1;
  FDefaultIndicators := TAdvSmoothTimeLineBarIndicators.Create(Self);
  FDefaultIndicator := FDefaultIndicators.Add;
  Fh := TAdvSmoothSectionHint.Create(Application);
  fh.Visible := False;
  Fh.Parent := Self;
  fh.TimeLine := Self;

  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  if FDesignTime then
    SetComponentStyle(tsOffice2007Luna);
end;

destructor TAdvSmoothTimeLine.Destroy;
begin
  FDefaultIndicator.Free;
  FDefaultIndicator := nil;
  FDefaultIndicators.Free;
  FRange.Free;
  FRangeAppearance.Free;
  FFill.Free;
  FTimeLineBar.Free;
  FTimeLineBarSections.Free;
  FDefaultHintFill.Free;
  FDefaultSectionFill.Free;
  FTimeLineIndicators.Free;
  inherited;
end;

procedure TAdvSmoothTimeLine.DrawBackground(g: TGPGraphics);
begin
  FFill.Fill(g, MakeRect(0,0, Width - 1, Height - 1));
end;

procedure TAdvSmoothTimeLine.DrawSectionHint(g: TGPGraphics);
var
  ff: TGPFontFamily;
  f: TGPFont;
  fs: integer;
  sf: TGPStringFormat;
  fillr, layr, sizer: TGPRectF;
  b: TGPSolidBrush;
  x, y: integer;
  bmp: TGPBitmap;
  bmpg: TGPGraphics;
begin
  if (FHoveredSection >= 0) and (FHoveredSection <= TimeLineSections.Count - 1) then
  begin
    with TimeLineSections[FHoveredSection] do
    begin
      if (Hint = '') and HintFill.Picture.Empty then
        Exit;

      ff := TGPFontFamily.Create(HintFont.Name);
      if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
      begin
        ff.Free;
        ff := TGPFontFamily.Create('Arial');
      end;

      fs := 0;
      if (fsBold in HintFont.Style) then
        fs := fs + 1;
      if (fsItalic in HintFont.Style) then
        fs := fs + 2;
      if (fsUnderline in HintFont.Style) then
        fs := fs + 4;

      sf := TGPStringFormat.Create;        
      if HintAutoSize then      
        Layr := MakeRect(0, 0, 10000, 10000)        
      else
        Layr := MakeRect(0, 0, HintWidth, HintHeight);      

      f := TGPFont.Create(ff, HintFont.Size, fs, UnitPoint);
      b := TGPSolidBrush.Create(MakeColor(255, Hintfont.Color));
      g.MeasureString(Hint, length(Hint), f, layr, sf, sizer);

      x := 0;
      y := 0;

      if HintAutoSize then      
        fillr := MakeRect(x, y, sizer.Width + 5, sizer.Height + 5)
      else
        fillr := MakeRect(x, y, layr.Width + 5, layr.Height + 5);


      if not HintFill.Picture.Empty then
      begin
        HintFill.Picture.GetImageSizes;
        fillr.Width := Max(fillr.Width, hintfill.Picture.Width);
        fillr.Height := Max(fillr.Height, hintfill.Picture.Height);
      end;

      bmp := TGPBitmap.Create(Width, Height);
      bmpg := g.FromImage(bmp);
      bmpg.SetTextRenderingHint(TextRenderingHintAntiAlias);

      FHintFill.Fill(bmpg, fillr);

      bmpg.DrawString(Hint, Length(Hint), f, MakeRect(fillr.X + (fillr.Width - sizer.Width) / 2, fillr.Y + (fillr.Height - sizer.Height) / 2, sizer.Width, sizer.Height), sf, b);

      bmpg.Free;
      g.DrawImage(bmp, 0, 0);
      bmp.Free;

      b.Free;
      f.Free;
      ff.Free;
      sf.Free;
    end;
  end;
end;

procedure TAdvSmoothTimeLine.DrawTimeBar(g: TGPGraphics);
begin
  TimeLineBar.Fill.Fill(g, GetTimeLineBarRect);
end;

procedure TAdvSmoothTimeLine.DrawTimeBarIndicators(g: TGPGraphics);
type
  TPointArray = array of TGPPointF;
var
  I: Integer;
  fp: TGDIPFillParameters;
  path: TGPGraphicsPath;
  pa: TPointArray;
  s: integer;
  p: TGPPen;
begin
  for I := 0 to TimeLineIndicators.Count - 1 do
  begin
    with TimeLineIndicators[I] do
    begin
      if (Position >= Range.RangeFrom) and (Position <= Range.RangeTo) then
      begin
        s := Size;
        fp.Graphics := g;
        fp.ColorFrom := Color;
        fp.ColorTo := Colorto;
        fp.GT := GradientType;
        fp.R := GetIndicatorRect;
        fp.OpacityFrom := Opacity;
        fp.OpacityTo := OpacityTo;
        fp.Angle := Angle;
        fp.BorderColor := clNone;
        fp.BorderWidth := 0;
        fp.Path := nil;
        fp.Mirror := false;

        case Shape of
          isNone: ; // draw nothing
          isCircle:
            begin
              path := TGPGraphicsPath.Create;
              path.AddEllipse(fp.R);
              path.CloseFigure;

              fp.Path := path;
              fp.Fillpath := true;
              FillGDIP(fp);

              if (BorderColor <> clNone) and (Borderwidth > 0) then
              begin
                p := TGPPen.Create(MakeColor(BorderOpacity, BorderColor), BorderWidth);
                g.DrawPath(p, path);
                p.Free;
              end;

              path.Free;
            end;
          isSquare:
            begin
              fp.Fillpath := false;
              FillGDIP(fp);
              if (BorderColor <> clNone) and (Borderwidth > 0) then
              begin
                p := TGPPen.Create(MakeColor(BorderOpacity, BorderColor), BorderWidth);
                g.DrawRectangle(p, fp.R);
                p.Free;
              end;
            end;
          isDiamond:
            begin
              SetLength(pa, 4); //DIAMOND 4 POINTS
              pa[0] := MakePoint(fp.R.x, fp.R.y + s / 2);
              pa[1] := MakePoint(fp.R.x + s / 2, fp.R.y);
              pa[2] := MakePoint(fp.R.x + s, fp.R.y + s / 2);
              pa[3] := MakePoint(fp.R.x + s / 2, fp.R.y + s);

              path := TGPGraphicsPath.Create;
              path.AddPolygon(PGPPointF(pa),4);
              path.CloseFigure;

              fp.Path := path;
              fp.Fillpath := true;
              FillGDIP(fp);
              if (BorderColor <> clNone) and (Borderwidth > 0) then
              begin
                p := TGPPen.Create(MakeColor(BorderOpacity, BorderColor), BorderWidth);
                g.DrawPath(p, path);
                p.Free;
              end;

              path.Free;
            end;
          isTriangleDown:
            begin
              SetLength(pa, 3); //TRIANGLE 3 POINTS
              pa[0] := MakePoint(fp.R.x + s / 2, fp.R.y + s);
              pa[1] := MakePoint(fp.R.x, fp.R.y);
              pa[2] := MakePoint(fp.R.x + s, fp.R.y);

              path := TGPGraphicsPath.Create;
              path.AddPolygon(PGPPointF(pa), 3);
              path.CloseFigure;

              fp.Path := path;
              fp.Fillpath := true;
              FillGDIP(fp);
              if (BorderColor <> clNone) and (Borderwidth > 0) then
              begin
                p := TGPPen.Create(MakeColor(BorderOpacity, BorderColor), BorderWidth);
                g.DrawPath(p, path);
                p.Free;
              end;
              path.Free;
            end;
          isTriangleUp:
            begin
              SetLength(pa, 3); //TRIANGLE 3 POINTS
              pa[0] := MakePoint(fp.R.x + s / 2, fp.R.y);
              pa[1] := MakePoint(fp.R.x, fp.R.y + s);
              pa[2] := MakePoint(fp.R.x + s, fp.R.y + s);

              path := TGPGraphicsPath.Create;
              path.AddPolygon(PGPPointF(pa), 3);
              path.CloseFigure;

              fp.Path := path;
              fp.Fillpath := true;
              FillGDIP(fp);
              if (BorderColor <> clNone) and (Borderwidth > 0) then
              begin
                p := TGPPen.Create(MakeColor(BorderOpacity, BorderColor), BorderWidth);
                g.DrawPath(p, path);
                p.Free;
              end;
              path.Free;
            end;
          isPicture:
          begin
            if not Picture.Empty then
              Picture.GDIPDraw(g, Bounds(Round(fp.R.x), Round(fp.R.y), s, s));
          end;
        end;

        if ShowTickMark and (TickMarkColor <> clNone) then
        begin
          p := TGPPen.Create(MakeColor(255, TickMarkColor), TickMarkWidth);
          g.DrawLine(p, fp.R.X + fp.R.Width / 2, fp.R.Y + fp.R.Height, fp.R.X + fp.R.Width / 2, fp.R.Y + fp.R.Height + TickMarkSize);
          p.Free;
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothTimeLine.DrawTimeBarSections(g: TGPGraphics);
var
  i: integer;
begin
  for I := 0 to TimeLineSections.Count - 1 do
  begin
    with TimeLineSections[I] do
    begin
      if GetSectionRect.Width > 0 then
        FFill.Fill(g, GetSectionRect);
    end;
  end;
end;

procedure TAdvSmoothTimeLine.DrawTimeLineTickMarks(g: TGPGraphics);
var
  x, w, y: double;
  pdiv, psubdiv: TGPPen;
  I: Integer;
  J: Integer;
  wdiv: Double;
  wsubdiv: Double;
begin
  if Range.Divisions = 0 then
    Exit;

  w := GetTimeLineRect.Width;
  x := GetTimeLinerect.X;
  pdiv := TGPPen.Create(MakeColor(255, RangeAppearance.DivisionTickMarkColor), RangeAppearance.DivisionTickMarkWidth);
  psubdiv := TGPPen.Create(MakeColor(255, RangeAppearance.SubDivisionTickMarkColor), RangeAppearance.SubDivisionTickMarkWidth);

  wdiv := w / Range.Divisions;
  wsubdiv := 0;
  if Range.SubDivisions > 0 then
    wsubdiv := wdiv / Range.SubDivisions;

  y := GetTimeLineRect.Y + 2;
  for I := 0 to Range.Divisions do
  begin
    g.DrawLine(pdiv, x, y, x, y + RangeAppearance.DivisionTickMarkSize);
    if (I < Range.Divisions) and (Range.SubDivisions > 0) then
    begin
      for J := 1 to Range.SubDivisions - 1 do
      begin
        g.DrawLine(psubdiv, x + (wsubdiv * J), y, x + (wsubdiv * J), y + RangeAppearance.SubDivisionTickMarkSize);
      end;
    end;
    x := x + wdiv;
  end;

  pdiv.Free;
  psubdiv.Free;
end;

procedure TAdvSmoothTimeLine.DrawTimeLineValues(g: TGPGraphics);
var
  x, w, y, ysub: double;
  I, J, K, ind: Integer;
  wdiv: Double;
  wsubdiv: Double;
  ff, ffsub: TGPFontFamily;
  fs: integer;
  sf, sfsub: TGPStringFormat;
  f, fsub: TGPFont;
  b, bsub: TGPSolidBrush;
  v: TDateTime;
  s: String;
  Layr, sizer: TGPRectF;
  overlap: Boolean;
  totalw: Double;
  indent: integer;
begin
  if (Range.Divisions = 0) or ((RangeAppearance.ShowDivisionValue = false)
    and (RangeAppearance.ShowSubDivisionValue = false)) then
      Exit;

  //Division font
  ff := TGPFontFamily.Create(FRangeAppearance.DivisionFont.Name);
  if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
  begin
    ff.Free;
    ff := TGPFontFamily.Create('Arial');
  end;

  fs := 0;
  if (fsBold in FRangeAppearance.DivisionFont.Style) then
    fs := fs + 1;
  if (fsItalic in FRangeAppearance.DivisionFont.Style) then
    fs := fs + 2;
  if (fsUnderline in FRangeAppearance.DivisionFont.Style) then
    fs := fs + 4;

  sf := TGPStringFormat.Create;
  f := TGPFont.Create(ff, FRangeAppearance.DivisionFont.Size, fs, UnitPoint);
  b := TGPSolidBrush.Create(MakeColor(255, FRangeAppearance.DivisionFont.Color));
  //

  //Sub division font
  ffsub := TGPFontFamily.Create(FRangeAppearance.SubDivisionFont.Name);
  if (ffsub.Status in [FontFamilyNotFound, FontStyleNotFound]) then
  begin
    ffsub.Free;
    ffsub := TGPFontFamily.Create('Arial');
  end;

  fs := 0;
  if (fsBold in FRangeAppearance.SubDivisionFont.Style) then
    fs := fs + 1;
  if (fsItalic in FRangeAppearance.SubDivisionFont.Style) then
    fs := fs + 2;
  if (fsUnderline in FRangeAppearance.SubDivisionFont.Style) then
    fs := fs + 4;

  sfsub := TGPStringFormat.Create;
  fsub := TGPFont.Create(ffsub, FRangeAppearance.SubDivisionFont.Size, fs, UnitPoint);
  bsub := TGPSolidBrush.Create(MakeColor(255, FRangeAppearance.SubDivisionFont.Color));
  //

  w := GetTimeLineRect.Width;
  x := GetTimeLinerect.X;

  wdiv := w / Range.Divisions;
  wsubdiv := 0;
  if Range.SubDivisions > 0 then
    wsubdiv := wdiv / Range.SubDivisions;

  Layr := MakeRect(0, 0, 10000, 10000);
  y := GetTimeLineRect.Y + 2 + RangeAppearance.DivisionTickMarkSize;
  ysub := GetTimeLineRect.Y + 2 + RangeAppearance.SubDivisionTickMarkSize;

  indent := 0;
  ind := 0;
  totalw := 0;
  overlap := true;
  while overlap do
  begin
    K := 1;
    for I := 0 to Range.Divisions do
    begin
      if RangeAppearance.ShowDivisionValue then
      begin
        v := Range.RangeFrom + (GetRange / Range.Divisions * I);
        s := formatDatetime(FRangeAppearance.DivisionFormat, v);
        if Assigned(FOnDivisionText) then
          FOnDivisionText(Self, v, s);
        g.MeasureString(s, Length(s), f, Layr, sf, sizer);
        if ind = 0 then
          totalw := totalw + sizer.Width + 5;

        if ind < indent then
          Inc(ind)
        else
          ind := 0;
      end;

      if (I < Range.Divisions) and (Range.SubDivisions > 0) then
      begin
        for J := 1 to Range.SubDivisions - 1 do
        begin
          if RangeAppearance.ShowSubDivisionValue then
          begin
            v := Range.RangeFrom + (GetRange / (Range.SubDivisions * Range.Divisions)) * K;
            s := formatDatetime(FRangeAppearance.SubDivisionFormat, v);
            if Assigned(FOnSubDivisionText) then
              FOnSubDivisionText(Self, v, s);

            g.MeasureString(s, Length(s), fsub, Layr, sf, sizer);
            if ind = 0 then
              totalw := totalw + sizer.Width + 5;

            if ind < indent then
              Inc(ind)
            else
              ind := 0;
          end;

          Inc(K);
        end;
        Inc(K);
      end;
      x := x + wdiv;
    end;

    if totalw > w then
    begin
      Inc(indent);
      totalw := 0;
    end
    else
      overlap := false;
  end;

  K := 1;
  ind := 0;
  x := GetTimeLinerect.X;
  for I := 0 to Range.Divisions do
  begin
    if RangeAppearance.ShowDivisionValue then
    begin
      v := Range.RangeFrom + (GetRange / Range.Divisions * I);
      s := formatDatetime(FRangeAppearance.DivisionFormat, v);
      if Assigned(FOnDivisionText) then
        FOnDivisionText(Self, v, s);
      g.MeasureString(s, Length(s), f, Layr, sf, sizer);
      g.DrawString(s, Length(s), f, MakePoint(x - sizer.Width / 2, y + (RangeAppearance.IndentSpacing * ind)), sf, b);

      if ind < indent then
        Inc(ind)
      else
        ind := 0;
    end;

    if (I < Range.Divisions) and (Range.SubDivisions > 0) then
    begin
      for J := 1 to Range.SubDivisions - 1 do
      begin
        if RangeAppearance.ShowSubDivisionValue then
        begin
          v := Range.RangeFrom + (GetRange / (Range.SubDivisions * Range.Divisions)) * K;
          s := formatDatetime(FRangeAppearance.SubDivisionFormat, v);
          if Assigned(FOnSubDivisionText) then
            FOnSubDivisionText(Self, v, s);

          g.MeasureString(s, Length(s), fsub, Layr, sf, sizer);
          g.DrawString(s, Length(s), fsub, MakePoint(x + (wsubdiv * J) - sizer.Width / 2, ysub  + (RangeAppearance.IndentSpacing * ind)), sfsub, bsub);

          if ind < indent then
            Inc(ind)
          else
            ind := 0;
        end;
        Inc(K);
      end;
      Inc(K);
    end;
    x := x + wdiv;
  end;

  ff.Free;
  ffsub.Free;
  f.Free;
  fsub.Free;
  sf.Free;
  sfsub.Free;
  b.Free;
  bsub.Free;
end;

procedure TAdvSmoothTimeLine.FillChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothTimeLine.GetXPosition(Value: TDateTime): integer;
var
  r: TGPRectF;
  w: Double;
begin
  r := GetTimeLineBarRect;
  w := r.Width;
  if GetRange > 0 then
    Result := {Min(w, Max(0, }round((w / GetRange) * (Value - Range.RangeFrom)){))}
  else
    Result := 0;
end;

function TAdvSmoothTimeLine.GetRange: Double;
begin
  Result := FRange.RangeTo - FRange.RangeFrom;
end;

function TAdvSmoothTimeLine.GetTimeLineBarRect: TGPRectF;
var
  r: TRect;
begin
  r := InsideRect;
  Result := MakeRect(r.Left + HorizontalMargin, r.Top + VerticalMargin, r.Right - r.Left - (HorizontalMargin * 2), TimeLineBar.Height);
end;

function TAdvSmoothTimeLine.GetTimeLineRect: TGPRectF;
var
  r: TRect;
begin
  r := InsideRect;
  Result := MakeRect(r.Left + HorizontalMargin, r.Top + VerticalMargin + TimeLineBar.Height, r.Right - r.Left - (HorizontalMargin * 2), r.Bottom - r.Top - TimeLineBar.Height - (VerticalMargin * 2));
end;

function TAdvSmoothTimeLine.GetValuePosition(X: integer; indicator: Integer): TDateTime;
var
  r: TGPRectF;
  w: Double;
begin
  r := GetTimeLineBarRect;
  w := r.Width;
  result := Range.RangeFrom + ((GetRange / w) * x);
  result := Min(Max(Range.RangeFrom, Result), Range.RangeTo);
end;

function TAdvSmoothTimeLine.IndicatorAtXY(X, Y: integer): integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to TimeLineIndicators.Count - 1 do
  begin
    if PtInGPRect(TimeLineIndicators[I].GetIndicatorRect, Point(X, Y)) then
    begin
      result := I;
      break;
    end;
  end;
end;

function TAdvSmoothTimeLine.InsideRect: TRect;
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

  if (Fill.ShadowOffset <> 0) and (Fill.ShadowColor <> clNone) then
  begin
    Result.Right := Result.Right -Fill.ShadowOffset;
    Result.Bottom := Result.Bottom -Fill.ShadowOffset;
  end;

  Result.Left := Result.Left + 2;
  Result.Right := Result.Right - 2;
  Result.Top := Result.Top + 2;
  Result.Bottom := Result.Bottom - 2;
end;

procedure TAdvSmoothTimeLine.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  i: integer;
begin
  FMbRight := (Button = mbRight);
  i := IndicatorAtXY(X, Y);
  if (i <> -1) then
  begin
    FMouseDownOnIndicator := true;
    FSelectedIndicator := i;
    FCx := X;
    FCy := Y;
  end;
  inherited;
end;

procedure TAdvSmoothTimeLine.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  sc, id: integer;
  pt: TPoint;
  r: TGPRectF;
  xs: Double;
  v: TDateTime;
begin
  inherited;
  id := IndicatorAtXY(X, Y);
  if (id = -1) or (id <> FHoveredIndicator) then
  begin
    FHoveredIndicator := id;
    Application.CancelHint;
  end;

  if FMbRight then
    Exit;

  if FMouseMovedOnIndicator and FMouseDownOnIndicator then
  begin
    FPx := X;
    FPy := Y;
    if(FSelectedIndicator >= 0) and (FSelectedIndicator <= TimeLineIndicators.Count - 1) then
    begin
      r := TimeLineIndicators[FSelectedIndicator].GetIndicatorRect;
      xs := r.X - GetTimeLineBarRect.X + r.Width / 2;
      v := GetValuePosition(Round(xs), FSelectedIndicator);
      if Assigned(FOnIndicatorPositionChanging) then
        FOnIndicatorPositionChanging(Self, TimeLineIndicators[FSelectedIndicator], v);
    end;
    Changed;
  end
  else
  begin
    if FMouseDownOnIndicator then
    begin
      if not ((X < FCx + 2) and (X > FCx - 2) and (Y < FCy + 2) and (Y > FCY - 2)) then
      begin
        FMouseMovedOnIndicator := true;
      end;
    end
    else
    begin
      sc := SectionAtXY(X, Y);
      if not ((sc = -1) and (FHoveredSection = -1)) then
      begin
        FHoveredSection := sc;
        if not FhintSizeCalculated then
        begin
          CalculateHintSize(FH);
          FhintSizeCalculated := true;
        end;
        pt := Point(X, Y);
        fh.Left := ClientToScreen(pt).X;
        fh.Top := ClientToScreen(pt).Y + 20;
        if not fh.Visible then
        begin
          fh.Show;
          fh.Init;
        end;
      end
      else
      begin
        if fh.Visible then
          fh.Hide;
      end;
    end;
  end;
end;

procedure TAdvSmoothTimeLine.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  v: TDateTime;
  indr, r: TGPRectF;
  xs: Double;
  ptpopup: TPoint;
begin
  inherited;
  if FMouseDownOnIndicator then
  begin
    if FMouseMovedOnIndicator then
    begin
      if(FSelectedIndicator >= 0) and (FSelectedIndicator <= TimeLineIndicators.Count - 1) then
      begin
        r := TimeLineIndicators[FSelectedIndicator].GetIndicatorRect;
        xs := r.X - GetTimeLineBarRect.X + r.Width / 2;
        v := GetValuePosition(Round(xs), FSelectedIndicator);
        FMouseMovedOnIndicator := false;
        TimeLineIndicators[FSelectedIndicator].Position := v;
        if Assigned(FOnIndicatorPositionChanged) then
          FOnIndicatorPositionChanged(Self, TimeLineIndicators[FSelectedIndicator], TimeLineIndicators[FSelectedIndicator].Position);
      end;
    end
    else
    begin
      if (FSelectedIndicator >= 0) and (FSelectedIndicator <= TimeLineIndicators.Count - 1) then
      begin
        if FMbRight then
        begin
          with TimeLineIndicators[FSelectedIndicator] do
          begin
            if Assigned(PopupMenu) then
            begin
              indr := GetIndicatorRect;
              ptpopup := ClientToScreen(Point(Round(indr.X + indr.Width / 2), Round(indr.Y)));
              PopupMenu.Popup(ptpopup.X, ptpopup.Y);
            end;
          end
        end
        else
        begin
          if Assigned(FOnIndicatorClick) then
            FOnIndicatorClick(Self, TimeLineIndicators[FSelectedIndicator]);
        end;
      end;
    end;
  end;

  FMouseDownOnIndicator := false;
  FSelectedIndicator := -1;
  Changed;
end;

procedure TAdvSmoothTimeLine.Notification(AComponent: TComponent;
  AOperation: TOperation);
var
  I: Integer;
begin
  inherited;

  if (csDestroying in ComponentState) then
    Exit;

  if (AOperation = opRemove) then
  begin
    for I := 0 to TimeLineIndicators.Count - 1 do
    begin
      with TimeLineIndicators[i] do
      begin
        if (AComponent = FPopupMenu) then
          FPopupMenu := nil;
      end;
    end;
  end;
end;

procedure TAdvSmoothTimeLine.Paint;
var
  g: TGPGraphics;
begin
  inherited;
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
  DrawBackground(g);
  DrawTimeBar(g);
  DrawTimeLineTickMarks(g);
  DrawTimeLineValues(g);
  DrawTimeBarSections(g);
  DrawTimeBarIndicators(g);
  g.Free;
end;

function TAdvSmoothTimeLine.PtInGPRect(r: TGPRectF; pt: TPoint): Boolean;
begin
  result := ((pt.X >= r.X) and (pt.X <= r.X + r.Width)) and
     ((pt.Y >= r.Y) and (pt.Y <= r.Y + r.Height));
end;

procedure TAdvSmoothTimeLine.RangeAppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothTimeLine.RangeChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothTimeLine.SectionAtXY(X, Y: integer): integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to TimeLineSections.Count - 1 do
  begin
    if PtInGPRect(TimeLineSections[I].GetSectionRect, Point(X, Y)) and ((TimeLineSections[I].Hint <> '') or not TimeLineSections[I].HintFill.Picture.Empty) then
    begin
      result := I;
      break;
    end;
  end;
end;

procedure TAdvSmoothTimeLine.SetComponentStyle(AStyle: TTMSStyle);
var
  I: Integer;
begin
 case AStyle of
    tsOffice2003Blue:
      begin
        Fill.Color := $00FFD2AF;
        Fill.ColorTo := $00FFD2AF;
        Fill.BorderColor := clNone;

        TimeLineBar.Fill.Color := $D68759;
        TimeLineBar.Fill.ColorTo := $933803;
        TimeLineBar.Fill.Color := clWhite;
        TimeLineBar.Fill.BorderColor := $962D00;

        DefaultSectionFill.Color := $AAD9FF;
        DefaultSectionFill.ColorTo := $6EBBFF;
        DefaultSectionFill.ColorMirror := $42AEFE;
        DefaultSectionFill.ColorMirrorTo := $7AE1FE;
        DefaultSectionFill.BorderColor := $42AEFE;
        DefaultSectionFill.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Silver:
      begin
        Fill.Color := $00E6D8D8;
        Fill.ColorTo := $00E6D8D8;
        Fill.BorderColor := clNone;

        TimeLineBar.Fill.Color := $BDA4A5;
        TimeLineBar.Fill.ColorTo := $957475;
        TimeLineBar.Fill.BorderColor := $947C7C;

        DefaultSectionFill.Color := $AAD9FF;
        DefaultSectionFill.ColorTo := $6EBBFF;
        DefaultSectionFill.ColorMirror := $42AEFE;
        DefaultSectionFill.ColorMirrorTo := $7AE1FE;
        DefaultSectionFill.BorderColor := $42AEFE;
        DefaultSectionFill.GradientMirrorType := gtVertical;

      end;
    tsOffice2003Olive:
      begin
        Fill.Color := RGB(225, 234, 185);
        Fill.ColorTo := RGB(225, 234, 185);
        Fill.BorderColor := clNone;

        TimeLineBar.Fill.Color := $82C0AF;
        TimeLineBar.Fill.ColorTo := $447A63;
        TimeLineBar.Fill.BorderColor := $588060;

        DefaultSectionFill.Color := $AAD9FF;
        DefaultSectionFill.ColorTo := $6EBBFF;
        DefaultSectionFill.ColorMirror := $42AEFE;
        DefaultSectionFill.ColorMirrorTo := $7AE1FE;
        DefaultSectionFill.BorderColor := $42AEFE;
        DefaultSectionFill.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Classic:
      begin
        Fill.Color := $00F2F2F2;
        Fill.ColorTo := $00F2F2F2;
        Fill.BorderColor := clNone;

        TimeLineBar.Fill.Color := $808080;
        TimeLineBar.Fill.ColorTo := $808080;
        TimeLineBar.Fill.BorderColor := $808080;

        DefaultSectionFill.Color := $B59285;
        DefaultSectionFill.ColorTo := $B59285;
        DefaultSectionFill.ColorMirror := clNone;
        DefaultSectionFill.ColorMirrorTo := clNone;
        DefaultSectionFill.BorderColor := $808080;
        DefaultSectionFill.GradientMirrorType := gtVertical;
      end;
    tsOffice2007Luna:
      begin
        Fill.Color := $00F3E5DA;
        Fill.ColorTo := $00F0DED0;
        Fill.BorderColor := clNone;

        TimeLineBar.Fill.Color := $FFEFE3;
        TimeLineBar.Fill.ColorTo := $FFD2AF;
        TimeLineBar.Fill.BorderColor := $00FFD2AF;

        DefaultSectionFill.Color := $AAD9FF;
        DefaultSectionFill.ColorTo := $6EBBFF;
        DefaultSectionFill.ColorMirror := $42AEFE;
        DefaultSectionFill.ColorMirrorTo := $7AE1FE;
        DefaultSectionFill.BorderColor := $42AEFE;
        DefaultSectionFill.GradientMirrorType := gtVertical;
      end;
    tsOffice2007Obsidian:
      begin
        Fill.Color := $5C534C;
        Fill.ColorTo := $5C534C;
        Fill.BorderColor := clNone;

        TimeLineBar.Fill.Color := $F2F1F0;
        TimeLineBar.Fill.ColorTo := $C9C2BD;
        TimeLineBar.Fill.BorderColor := $5C534C;

        DefaultSectionFill.Color := $AAD9FF;
        DefaultSectionFill.ColorTo := $6EBBFF;
        DefaultSectionFill.ColorMirror := $42AEFE;
        DefaultSectionFill.ColorMirrorTo := $7AE1FE;
        DefaultSectionFill.BorderColor := $42AEFE;
        DefaultSectionFill.GradientMirrorType := gtVertical;
      end;
    tsWindowsXP:
      begin
        Fill.Color := $00B6B6B6;
        Fill.ColorTo := $00B6B6B6;

        TimeLineBar.Fill.Color := clBtnFace;
        TimeLineBar.Fill.ColorTo := clBtnFace;
        TimeLineBar.Fill.BorderColor := clBlack;

        DefaultSectionFill.Color := clInactiveCaption;
        DefaultSectionFill.ColorTo := clInactiveCaption;
        DefaultSectionFill.ColorMirror := clNone;
        DefaultSectionFill.ColorMirrorTo := clNone;
        DefaultSectionFill.BorderColor := clHighLight;
        DefaultSectionFill.GradientMirrorType := gtVertical;
      end;
    tsWhidbey:
      begin
        Fill.Color := $F5F9FA;
        Fill.ColorTo := $F5F9FA;
        Fill.BorderColor := clNone;

        TimeLineBar.Fill.Color := $EBEEEF;
        TimeLineBar.Fill.ColorTo := $7E9898;
        TimeLineBar.Fill.BorderColor := $962D00;

        DefaultSectionFill.Color := $AAD9FF;
        DefaultSectionFill.ColorTo := $6EBBFF;
        DefaultSectionFill.ColorMirror := $42AEFE;
        DefaultSectionFill.ColorMirrorTo := $7AE1FE;
        DefaultSectionFill.BorderColor := $42AEFE;
        DefaultSectionFill.GradientMirrorType := gtVertical;
      end;
    tsCustom: ;
    tsOffice2007Silver:
      begin
        Fill.Color := RGB(241, 244, 248);
        Fill.ColorTo := RGB(227, 232, 240);
        Fill.BorderColor := clNone;

        TimeLineBar.Fill.Color := $F8F7F6;
        TimeLineBar.Fill.ColorTo := $E8E0DB;
        TimeLineBar.Fill.BorderColor := $74706F;

        DefaultSectionFill.Color := $AAD9FF;
        DefaultSectionFill.ColorTo := $6EBBFF;
        DefaultSectionFill.ColorMirror := $42AEFE;
        DefaultSectionFill.ColorMirrorTo := $7AE1FE;
        DefaultSectionFill.BorderColor := $42AEFE;
        DefaultSectionFill.GradientMirrorType := gtVertical;
      end;
  end;

  DefaultIndicator.Color := DefaultSectionFill.Color;
  DefaultIndicator.ColorTo := DefaultSectionFill.ColorTo;
  DefaultIndicator.OpacityTo := 150;
  DefaultIndicator.Opacity := 200;

  DefaultHintFill.Color := clWhite;
  DefaultHintFill.ColorTo := clWhite;
  DefaultHintFill.Opacity := 225;
  DefaultHintFill.OpacityTo := 175;

  Fill.BorderColor := clSilver;

  DefaultHintFill.BorderColor := clBlack;


  for I := 0 to TimeLineSections.Count - 1 do
  begin
    TimeLineSections[I].HintFill.Assign(DefaultHintFill);
    TimeLineSections[I].Fill.Assign(DefaultSectionFill);
  end;

  for I := 0 to TimeLineIndicators.Count - 1 do
    TimeLineIndicators[I].Assign(DefaultIndicator);
end;

procedure TAdvSmoothTimeLine.SetDefaultHintFill(const Value: TGDIPFill);
begin
  if FDefaultHintFill <> value then
  begin
    FDefaultHintFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.SetDefaultIndicator(
  const Value: TAdvSmoothTimeLineBarIndicator);
begin
  if FDefaultIndicator <> value then
  begin
    FDefaultIndicator.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.SetDefaultSectionFill(const Value: TGDIPFill);
begin
  if FDefaultSectionFill <> value then
  begin
    FDefaultSectionFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.SetHorizontalMargin(const Value: integer);
begin
  if FHorizontalMargin <> value then
  begin
    FHorizontalMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.SetRange(const Value: TAdvSmoothTimeLineRange);
begin
  if FRange <> value then
  begin
    FRange.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.SetRangeAppearance(
  const Value: TAdvSmoothTimeLineRangeAppearance);
begin
  if FRangeAppearance <> value then
  begin
    FRangeAppearance.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.SetTimeLineBar(const Value: TAdvSmoothTimeLineBar);
begin
  if FTimeLineBar <> value then
  begin
    FTimeLineBar.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.SetTimeLineBarSections(
  const Value: TAdvSmoothTimeLineBarSections);
begin
  if FTimeLineBarSections <> value then
  begin
    FTimeLineBarSections.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.SetTimeLineIndicators(
  const Value: TAdvSmoothTimeLineBarIndicators);
begin
  if FTimeLineIndicators <> Value then
  begin
    FTimeLineIndicators.Assign(value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.SetVerticalMargin(const Value: integer);
begin
  if FVerticalMargin <> value then
  begin
    FVerticalMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLine.TimeLineBarChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothTimeLine.TimeLineBarIndicatorsChanged(Sender: TOBject);
begin
  Changed;
end;

procedure TAdvSmoothTimeLine.TimeLineBarSectionsChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothTimeLine.WMPaint(var Message: TWMPaint);
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

{ TAdvSmoothTimeLineRange }

procedure TAdvSmoothTimeLineRange.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothTimeLineRange) then
  begin
    FRangeFrom := (Source as TAdvSmoothTimeLineRange).RangeFrom;
    FRangeTo := (Source as TAdvSmoothTimeLineRange).RangeTo;
    FSubDivisions := (Source as TAdvSmoothTimeLineRange).SubDivisions;
    FDivisions := (Source as TAdvSmoothTimeLineRange).Divisions;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRange.Changed;
begin
   FOwner.Changed;
end;

constructor TAdvSmoothTimeLineRange.Create(AOwner: TAdvSmoothTimeLine);
var
  y, m, d, h, n, s, mi: Word;
begin
  FOwner := AOwner;
  DecodeDateTime(Now, y, m, d, h, n, s, mi);
  FRangeFrom := EncodeDateTime(y, m, d, h, n, s, 0);
  FRangeTo := IncSecond(FRangeFrom, 10);
  FDivisions := 2;
  FSubDivisions := 5;
end;

destructor TAdvSmoothTimeLineRange.Destroy;
begin
  inherited;
end;

procedure TAdvSmoothTimeLineRange.SetDivisions(const Value: integer);
begin
  if (FDivisions <> value) and (Value >= 0) then
  begin
    FDivisions := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRange.SetRangeFrom(const Value: TDateTime);
begin
  if FRangeFrom <> value then
  begin
    FRangeFrom := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRange.SetRangeTo(const Value: TDateTime);
begin
  if FRangeTo <> value then
  begin
    FRangeTo := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRange.SetSubDivisions(const Value: integer);
begin
  if (FSubDivisions <> value) and (Value >= 0) then
  begin
    FSubDivisions := Value;
    Changed;
  end;
end;

{ TAdvSmoothTimeLineRangeAppearance }

procedure TAdvSmoothTimeLineRangeAppearance.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothTimeLineRangeAppearance) then
  begin
    FDivisionTickMarkColor := (Source as TAdvSmoothTimeLineRangeAppearance).DivisionTickMarkColor;
    FDivisionTickMarkSize := (Source as TAdvSmoothTimeLineRangeAppearance).DivisionTickMarkSize;
    DivisionFont.Assign((Source as TAdvSmoothTimeLineRangeAppearance).DivisionFont);
    FSubDivisionTickMarkColor := (Source as TAdvSmoothTimeLineRangeAppearance).SubDivisionTickMarkColor;
    FSubDivisionTickMarkSize := (Source as TAdvSmoothTimeLineRangeAppearance).SubDivisionTickMarkSize;
    FSubDivisionFont.Assign((Source as TAdvSmoothTimeLineRangeAppearance).SubDivisionFont);
    FDivisionTickMarkWidth := (Source as TAdvSmoothTimeLineRangeAppearance).DivisionTickMarkWidth;
    FSubDivisionTickMarkWidth := (Source as TAdvSmoothTimeLineRangeAppearance).SubDivisionTickMarkWidth;
    FDivisionFormat := (Source as TAdvSmoothTimeLineRangeAppearance).DivisionFormat;
    FSubDivisionFormat := (Source as TAdvSmoothTimeLineRangeAppearance).SubDivisionFormat;
    FIndentSpacing := (Source as TAdvSmoothTimeLineRangeAppearance).IndentSpacing;
    FShowSubDivisionValue := (Source as TAdvSmoothTimeLineRangeAppearance).ShowSubDivisionValue;
    FShowDivisionValue := (Source as TAdvSmoothTimeLineRangeAppearance).ShowDivisionValue;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothTimeLineRangeAppearance.Create(
  AOwner: TAdvSmoothTimeLine);
begin
  FOwner := AOwner;
  FDivisionTickMarkColor := clBlack;
  FSubDivisionTickMarkColor := clBlack;
  FDivisionTickMarkSize := 10;
  FSubDivisionTickMarkSize := 8;
  FSubDivisionFont := TFont.Create;
  FSubDivisionFont.OnChange := fontChanged;
  FDivisionFont := TFont.Create;
  {$IFNDEF DELPHI9_LVL}
  FDivisionFont.Name := 'Tahoma';
  FSubDivisionFont.Name := 'Tahoma';
  {$ENDIF}
  FDivisionFont.OnChange := fontChanged;
  FDivisionTickMarkWidth := 2;
  FSubDivisionTickMarkWidth := 1;
  FDivisionFormat := 'hh:nn:ss';
  FSubDivisionFormat := 'hh:nn:ss';
  FIndentSpacing := 20;
  FShowSubDivisionValue := true;
  FShowDivisionValue := true;
end;

destructor TAdvSmoothTimeLineRangeAppearance.Destroy;
begin
  FDivisionFont.Free;
  FSubDivisionFont.Free;
  inherited;
end;

procedure TAdvSmoothTimeLineRangeAppearance.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetDivisionTickMarkColor(
  const Value: TColor);
begin
  if FDivisionTickMarkColor <> value then
  begin
    FDivisionTickMarkColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetDivisionTickMarkSize(
  const Value: integer);
begin
  if FDivisionTickMarkSize <> value then
  begin
    FDivisionTickMarkSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetDivisionTickMarkWidth(
  const Value: integer);
begin
  if FDivisionTickMarkWidth <> value then
  begin
    FDivisionTickMarkWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetIndentSpacing(
  const Value: integer);
begin
  if FIndentSpacing <> value then
  begin
    FIndentSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetDivisionFont(const Value: TFont);
begin
  if FDivisionFont <> Value then
  begin
    FDivisionFont.Assign(value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetDivisionFormat(
  const Value: String);
begin
  if FDivisionFormat <> value then
  begin
    FDivisionFormat := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetShowDivisionValue(
  const Value: Boolean);
begin
  if FShowDivisionValue <> value then
  begin
    FShowDivisionValue := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetShowSubDivisionValue(
  const Value: Boolean);
begin
  if FShowSubDivisionValue <> value then
  begin
    FShowSubDivisionValue := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetSubDivisionFont(
  const Value: TFont);
begin
  if FSubDivisionFont <> value then
  begin
    FSubDivisionFont.Assign(value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetSubDivisionFormat(
  const Value: String);
begin
  if FSubDivisionFormat <> value then
  begin
    FSubDivisionFormat := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetSubDivisionTickMarkColor(
  const Value: TColor);
begin
  if FSubDivisionTickMarkColor <> Value then
  begin
    FSubDivisionTickMarkColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetSubDivisionTickMarkSize(
  const Value: integer);
begin
  if FSubDivisionTickMarkSize <> value then
  begin
    FSubDivisionTickMarkSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineRangeAppearance.SetSubDivisionTickMarkWidth(
  const Value: integer);
begin
  if FSubDivisionTickMarkWidth <> value then
  begin
    FSubDivisionTickMarkWidth := Value;
    Changed;
  end;
end;

{ TAdvSmoothTimeLineBarSection }

procedure TAdvSmoothTimeLineBarSection.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothTimeLineBarSection) then
  begin
    FEndTime := (Source as  TAdvSmoothTimeLineBarSection).EndTime;
    FStartTime := (Source as TAdvSmoothTimeLineBarSection).StartTime;
    FFill.Assign((Source as TAdvSmoothTimeLineBarSection).Fill);
    FHintFill.Assign((Source as TAdvSmoothTimeLineBarSection).HintFill);
    FHintFont.Assign((Source as TAdvSmoothTimeLineBarSection).HintFont);
    FHintHeight := (Source as TAdvSmoothTimeLineBarSection).HintHeight;
    FHintWidth := (Source as TAdvSmoothTimeLineBarSection).HintWidth;
    FHintAutoSize := (Source as TAdvSmoothTimeLineBarSection).HintAutoSize;
  end;
end;

procedure TAdvSmoothTimeLineBarSection.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothTimeLineBarSection.Create(Collection: TCollection);
begin
  inherited;
  FOwner := (Collection as TAdvSmoothTimeLineBarSections).FOwner;
  FStartTime := IncSecond(FOwner.Range.RangeFrom, 3);
  FEndTime := IncSecond(FOwner.Range.RangeFrom, 5);
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FHintFill := TGDIPFill.Create;
  FHintFill.OnChange := FillChanged;
  FHintFont := TFont.Create;
  FHintFont.OnChange := fontChanged;
  FHintWidth := 50;
  FHintHeight := 20;
  FHintAutoSize := true;
  if not (csLoading in FOwner.ComponentState) then
  begin
    FHintFill.Assign(FOwner.FDefaultHintFill);
    FFill.Assign(FOwner.FDefaultSectionFill);
  end;
  FOwner.Changed;
end;

destructor TAdvSmoothTimeLineBarSection.Destroy;
begin
  FFill.Free;
  FHintFill.Free;
  FOwner.Changed;
  FHintFont.Free;
  inherited;
end;

procedure TAdvSmoothTimeLineBarSection.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothTimeLineBarSection.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothTimeLineBarSection.GetSectionRect: TGPRectF;
var
  xs, xe: Double;
  r: TGPRectF;
begin
  r := FOwner.GetTimeLineBarRect;
  xs := Min(Max(FOwner.GetXPosition(StartTime), 0), r.Width);
  xe := Min(Max(FOwner.GetXPosition(EndTime), 0), r.Width);
  Result := MakeRect(r.X + xs, r.Y, xe - xs, r.Height);
end;

procedure TAdvSmoothTimeLineBarSection.SetEndTime(const Value: TDateTime);
begin
  if FEndTime <> value then
  begin
    FEndTime := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarSection.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarSection.SetHint(const Value: String);
begin
  if FHint <> value then
  begin
    FHint := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarSection.SetHintAutoSize(const Value: Boolean);
begin
  if FHintAutoSize <> value then
  begin
    FHintAutoSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarSection.SetHintFill(const Value: TGDIPFill);
begin
  if FHintFill <> value then
  begin
    FHintFill.Assign(value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothTimeLineBarSection.SetHintFont(const Value: TFont);
begin
  if FHintFont <> value then
  begin
    FHintFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TAdvSmoothTimeLineBarSection.SetHintHeight(const Value: integer);
begin
  if FHintHeight <> value then
  begin
    FHintHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarSection.SetHintWidth(const Value: integer);
begin
  if FHintWidth <> value then
  begin
    FHintWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarSection.SetStartTime(const Value: TDateTime);
begin
  if FStartTime <> value then
  begin
    FStartTime := Value;
    Changed;
  end;
end;

{ TAdvSmoothTimeLineBarSections }

function TAdvSmoothTimeLineBarSections.Add: TAdvSmoothTimeLineBarSection;
begin
  result := TAdvSmoothTimeLineBarSection(inherited Add);
end;

constructor TAdvSmoothTimeLineBarSections.Create(
  AOwner: TAdvSmoothTimeLine);
begin
  inherited Create(TAdvSmoothTimeLineBarSection);
  FOwner := AOwner;
end;

procedure TAdvSmoothTimeLineBarSections.Delete(Index: Integer);
begin
  inherited Items[Index].Free;
end;

function TAdvSmoothTimeLineBarSections.GetItem(
  Index: Integer): TAdvSmoothTimeLineBarSection;
begin
  Result := TAdvSmoothTimeLineBarSection(inherited Items[Index]);
end;

function TAdvSmoothTimeLineBarSections.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TAdvSmoothTimeLineBarSections.Insert(
  Index: Integer): TAdvSmoothTimeLineBarSection;
begin
  Result := TAdvSmoothTimeLineBarSection(inherited Insert(Index));
end;

procedure TAdvSmoothTimeLineBarSections.SetItem(Index: Integer;
  const Value: TAdvSmoothTimeLineBarSection);
begin
  inherited Items[Index] := Value;
end;

{ TAdvSmoothTimeLineBar }

procedure TAdvSmoothTimeLineBar.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothTimeLineBar) then
  begin
    FFill.Assign((Source as TAdvSmoothTimeLineBar).Fill);
    FHeight := (Source as TAdvSmoothTimeLineBar).Height;
  end;
end;

procedure TAdvSmoothTimeLineBar.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothTimeLineBar.Create(AOwner: TAdvSmoothTimeLine);
begin
  FOwner := AOwner;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FSections := TAdvSmoothTimeLineBarSections.Create(FOwner);
  FSections.OnChange := SectionsChanged;
  FHeight := 10;
end;

destructor TAdvSmoothTimeLineBar.Destroy;
begin
  FFill.Free;
  FSections.Free;
  inherited;
end;

procedure TAdvSmoothTimeLineBar.FillChanged(Sender: TOBject);
begin
  Changed;
end;

procedure TAdvSmoothTimeLineBar.SectionsChanged(Sender: TOBject);
begin
  Changed;
end;

procedure TAdvSmoothTimeLineBar.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBar.SetHeight(const Value: integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Changed;
  end;
end;

{ TAdvSmoothSectionHint }

procedure TAdvSmoothSectionHint.ClearBuffer(graphics: TGPGraphics);
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

procedure TAdvSmoothSectionHint.CMDialogKey(var Msg: TWMKey);
begin

end;

procedure TAdvSmoothSectionHint.CMMouseLeave(var Message: TMessage);
begin
  Invalidate;
end;

constructor TAdvSmoothSectionHint.Create(AOwner: TComponent);
begin
  inherited;
  FMainBuffer := nil;

end;

function TAdvSmoothSectionHint.CreateGraphics: TGPGraphics;
begin
  Result := nil;
  if Assigned(FMainBuffer) then
    Result := TGPGraphics.Create(FMainBuffer);
end;

procedure TAdvSmoothSectionHint.CreateMainBuffer;
begin
//  if not Assigned(FMainBuffer) then
  if Assigned(FMainBuffer) then
    FMainBuffer.Free;

  FMainBuffer := TGPBitmap.Create(Width, Height, PixelFormat32bppARGB);
end;

procedure TAdvSmoothSectionHint.CreateWnd;
begin
  inherited;
  UpdateWindow;
end;

destructor TAdvSmoothSectionHint.Destroy;
begin
  inherited;
  DestroyMainBuffer;  
end;

procedure TAdvSmoothSectionHint.DestroyMainBuffer;
begin
  if Assigned(FMainBuffer) then
    FMainBuffer.Free;
end;

procedure TAdvSmoothSectionHint.Draw(graphics: TGPGraphics);
var
  g: TGPGraphics;
begin
  g := graphics;
  if not Assigned(g) then
    g := CreateGraphics;

  g.SetSmoothingMode(SmoothingModeAntiAlias);

  if Assigned(TimeLine) then  
    TimeLine.DrawSectionHint(g);

  if not Assigned(graphics) then
    g.Free;  
end;

procedure TAdvSmoothSectionHint.Init;
begin
  CreateMainBuffer;
  SetLayeredWindow;
  UpdateLayered;
end;

procedure TAdvSmoothSectionHint.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TAdvSmoothSectionHint.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TAdvSmoothSectionHint.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

procedure TAdvSmoothSectionHint.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

procedure TAdvSmoothSectionHint.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

procedure TAdvSmoothSectionHint.Paint;
begin
  inherited;

end;

procedure TAdvSmoothSectionHint.SetLayeredWindow;
begin
  if GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

  UpdateLayered;
end;

procedure TAdvSmoothSectionHint.UpdateButtons;
begin

end;

procedure TAdvSmoothSectionHint.UpdateLayered;
begin
  ClearBuffer(nil);

  SetWindowPos(Self.Handle, HWND_TOPMOST, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED or SWP_NOACTIVATE);

  Draw(nil);

  UpdateMainWindow;
end;

procedure TAdvSmoothSectionHint.UpdateMainWindow;
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

procedure TAdvSmoothSectionHint.UpdateWindow;
begin
  CreateMainBuffer;
  UpdateLayered;
end;

procedure TAdvSmoothSectionHint.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  inherited;
end;

procedure TAdvSmoothSectionHint.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
end;

procedure TAdvSmoothSectionHint.WMPaint(var Message: TWMPaint);
begin
  inherited;
end;

{ TWinCtrl }

procedure TWinCtrl.PaintCtrls(DC: HDC; First: TControl);
begin
  inherited PaintControls(DC, First);
end;

{ TAdvSmoothTimeLineBarIndicators }

function TAdvSmoothTimeLineBarIndicators.Add: TAdvSmoothTimeLineBarIndicator;
begin
  Result := TAdvSmoothTimeLineBarIndicator(inherited Add);
end;

constructor TAdvSmoothTimeLineBarIndicators.Create(AOwner: TAdvSmoothTimeLine);
begin
  inherited Create(TAdvSmoothTimeLineBarIndicator);
  FOwner := AOwner;
end;

procedure TAdvSmoothTimeLineBarIndicators.Delete(Index: Integer);
begin
  inherited Items[Index].Free;
end;

function TAdvSmoothTimeLineBarIndicators.GetItem(
  Index: Integer): TAdvSmoothTimeLineBarIndicator;
begin
  Result := TAdvSmoothTimeLineBarIndicator(inherited Items[Index]);
end;

function TAdvSmoothTimeLineBarIndicators.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TAdvSmoothTimeLineBarIndicators.Insert(
  Index: Integer): TAdvSmoothTimeLineBarIndicator;
begin
  Result := TAdvSmoothTimeLineBarIndicator(inherited Insert(Index));
end;

procedure TAdvSmoothTimeLineBarIndicators.SetItem(Index: Integer;
  const Value: TAdvSmoothTimeLineBarIndicator);
begin
  Items[Index] := Value;
end;

{ TAdvSmoothTimeLineBarIndicator }

procedure TAdvSmoothTimeLineBarIndicator.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothTimeLineBarIndicator) then
  begin
//    FPosition := (Source as TAdvSmoothTimeLineBarIndicator).Position;
    FShape := (Source as TAdvSmoothTimeLineBarIndicator).Shape;
    FColor := (Source as TAdvSmoothTimeLineBarIndicator).Color;
    FColorTo := (Source as TAdvSmoothTimeLineBarIndicator).ColorTo;
    FOpacity := (Source as TAdvSmoothTimeLineBarIndicator).Opacity;
    FOpacityTo := (Source as TAdvSmoothTimeLineBarIndicator).OpacityTo;
    FAngle := (Source as TAdvSmoothTimeLineBarIndicator).Angle;
    FGradientType := (Source as TAdvSmoothTimeLineBarIndicator).GradientType;
    FBorderColor := (Source as TAdvSmoothTimeLineBarIndicator).BorderColor;
    FBorderOpacity := (Source as TAdvSmoothTimeLineBarIndicator).Opacity;
    FBorderWidth := (Source as TAdvSmoothTimeLineBarIndicator).BorderWidth;
    FPicture.Assign((Source as TAdvSmoothTimeLineBarIndicator).Picture);
    FSize := (Source as TAdvSmoothTimeLineBarIndicator).Size;
    FHint := (Source as TAdvSmoothTimeLineBarIndicator).Hint;
    FShowTickMark := (Source as TAdvSmoothTimeLineBarIndicator).ShowTickMark;
    FTickMarkSize := (Source as TAdvSmoothTimeLineBarIndicator).TickMarkSize;
    FTickMarkWidth := (Source as TAdvSmoothTimeLineBarIndicator).TickMarkWidth;
    FTickMarkColor := (Source as TAdvSmoothTimeLineBarIndicator).TickMarkColor;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothTimeLineBarIndicator.Create(Collection: TCollection);
begin
  inherited;
  FOwner := (Collection as TAdvSmoothTimeLineBarIndicators).FOwner;
  FPosition := IncSecond(FOwner.Range.RangeFrom, 5);
  FShape := isDiamond;
  FColor := clGray;
  FColorTo := clSilver;
  FOpacity := 255;
  FOpacityTo := 255;
  FAngle := 0;
  FGradientType := gtForwardDiagonal;
  FBorderColor := clBlack;
  FBorderOpacity := 255;
  FBorderWidth := 1;
  FPicture := TAdvGDIPPicture.Create;
  FPicture.OnChange := PictureChanged;
  FSize := 15;
  FTickMarkSize := 10;
  FTickMarkWidth := 1;
  FTickMarkColor := clBlack;
  FShowTickMark := true;
  if Assigned(FOwner.FDefaultIndicator) then
    Assign(FOwner.FDefaultIndicator);
  FOwner.Changed;
end;

destructor TAdvSmoothTimeLineBarIndicator.Destroy;
begin
  FPicture.Free;
  FOwner.Changed;
  inherited;
end;

function TAdvSmoothTimeLineBarIndicator.GetIndicatorRect: TGPRectF;
var
  r: TGPRectF;
begin
  r := FOwner.GetTimeLineBarRect;
  if FOwner.FMouseMovedOnIndicator and FOwner.FMouseMovedOnIndicator and (Index = FOwner.FSelectedIndicator) then
    Result.X := FOwner.FPx - Size / 2
  else
    Result.X := r.X + FOwner.GetXPosition(Position) - Size / 2;

  Result.Y := r.y + r.Height / 2 - Size / 2;
  Result.Width := Size;
  Result.Height := Size;
end;

procedure TAdvSmoothTimeLineBarIndicator.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetAngle(const Value: integer);
begin
  if FAngle <> value then
  begin
    FAngle := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetBorderOpacity(const Value: Byte);
begin
  if FBorderOpacity <> value then
  begin
    FBorderOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetBorderWidth(const Value: integer);
begin
  if FBorderWidth <> value then
  begin
    FBorderWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetColor(const Value: TColor);
begin
  if FColor <> value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetColorTo(const Value: TColor);
begin
  if FColorTo <> value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetGradientType(
  const Value: TAdvGradientType);
begin
  if FGradientType <> value then
  begin
    FGradientType := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetHint(const Value: String);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetOpacity(const Value: Byte);
begin
  if FOpacity <> value then
  begin
    FOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetOpacityTo(const Value: Byte);
begin
  if FOpacityTo <> Value then
  begin
    FOpacityTo := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetPicture(
  const Value: TAdvGDIPPicture);
begin
  if FPicture <> value then
  begin
    FPicture.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetPosition(const Value: TDateTime);
begin
  FPosition := Value;
  Changed;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetShape(
  const Value: TAdvSmoothTimeLineBarIndicatorShape);
begin
  if FShape <> value then
  begin
    FShape := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetShowTickMark(const Value: Boolean);
begin
  if FShowTickMark <> value then
  begin
    FShowTickMark := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetSize(const Value: integer);
begin
  if FSize <> value then
  begin
    FSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetTickMarkColor(const Value: TColor);
begin
  if FTickMarkColor <> value then
  begin
    FTickMarkColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetTickMarkSize(const Value: integer);
begin
  if FTickMarkSize <> value then
  begin
    FTickMarkSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTimeLineBarIndicator.SetTickMarkWidth(const Value: integer);
begin
  if FTickMarkWidth <> value then
  begin
    FTickMarkWidth := Value;
    Changed;
  end;
end;

end.
