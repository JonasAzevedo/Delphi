{**************************************************************************}
{ TAdvSmoothSlider component                                               }
{ for Delphi & C++Builder                                                  }
{                                                                          }
{ written                                                                  }
{   TMS Software                                                           }
{   copyright � 2009                                                       }
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

unit AdvSmoothSlider;

interface

{$I TMSDEFS.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Math, AdvSmoothGDIP, AdvStyleIF, GDIPFill, Forms, ExtCtrls;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : first release

type
  TAdvSmoothSlider = class;

  TAdvSmoothSliderButtonAppearance = class(TPersistent)
  private
    FOwner: TAdvSmoothSlider;
    FOnChange: TNotifyEvent;
    FSize: integer;
    FFill: TGDIPFill;
    procedure SetFill(const Value: TGDIPFill);
    procedure SetSize(const Value: integer);
  public
    constructor Create(AOwner: TAdvSmoothSlider);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
  published
    property Fill: TGDIPFill read FFill write SetFill;
    property Size: integer read FSize write SetSize default 40;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothSliderCaptionPosition = (cpTopLeft, cpTopCenter, cpTopRight, cpCenterLeft, cpCenterCenter, cpCenterRight, cpBottomLeft, cpBottomCenter, cpBottomRight, cpCustom);

  TAdvSmoothSliderAppearance = class(TPersistent)
  private
    FOwner: TAdvSmoothSlider;
    FFont: TFont;
    FCaption: String;
    FOnChange: TNotifyEvent;
    FFill: TGDIPFill;
    FCaptionPosition: TAdvSmoothSliderCaptionPosition;
    FCaptionTop: integer;
    FCaptionLeft: integer;
    procedure SetCaption(const Value: String);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetFont(const Value: TFont);
    procedure SetCaptionPosition(const Value: TAdvSmoothSliderCaptionPosition);
    procedure SetCaptionLeft(const Value: integer);
    procedure SetCaptionTop(const Value: integer);
  public
    constructor Create(AOwner: TAdvSmoothSlider);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure FontChanged(Sender: TObject);
  published
    property Fill: TGDIPFill read FFill write SetFill;
    property Caption: String read FCaption write SetCaption;
    property Font: TFont read FFont write SetFont;
    property CaptionPosition: TAdvSmoothSliderCaptionPosition read FCaptionPosition write SetCaptionPosition default cpCenterCenter;
    property CaptionLeft: integer read FCaptionLeft write SetCaptionLeft default 0;
    property CaptionTop: integer read FCaptionTop write SetCaptionTop default 0;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothSliderState = (ssOn, ssOff);

  TAdvSmoothStateChanged = procedure(Sender: TObject; State: TAdvSmoothSliderState; Value: Double) of object;

  TAdvSmoothSlider = class(TCustomControl, ITMSStyle)
  private
    Ffocused: Boolean;
    FDoAnimation, FDesignTime: Boolean;
    FSlide: TTimer;
    FCx: integer;
    FMouseDown: Boolean;
    FPosTo, FCurrentPos: Double;
    FAppearanceOff: TAdvSmoothSliderAppearance;
    FState: TAdvSmoothSliderState;
    FValueOff: Double;
    FButtonAppearance: TAdvSmoothSliderButtonAppearance;
    FAppearanceOn: TAdvSmoothSliderAppearance;
    FValueOn: Double;
    FFill: TGDIPFill;
    FOnStateChanged: TAdvSmoothStateChanged;
    FAnimationFactor: integer;
    FShowFocus: Boolean;
    FFocusColor: TColor;
    procedure SetAppearanceOff(const Value: TAdvSmoothSliderAppearance);
    procedure SetAppearanceOn(const Value: TAdvSmoothSliderAppearance);
    procedure SetButtonAppearance(
      const Value: TAdvSmoothSliderButtonAppearance);
    procedure SetState(const Value: TAdvSmoothSliderState);
    procedure SetValueOff(const Value: Double);
    procedure SetValueOn(const Value: Double);
    procedure SetFill(const Value: TGDIPFill);
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetAnimationFactor(const Value: integer);
    procedure SetFocusColor(const Value: TColor);
    procedure SetShowFocus(const Value: Boolean);
  protected
    procedure Changed;
    procedure AppearanceChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    function InsideRect: TRect;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure DrawBackGround(g: TGPGraphics);
    procedure DrawButton(g: TGPGraphics);
    procedure DrawCaption(g: TGPGraphics; app: TAdvSmoothSliderAppearance; r: TGPRectF);
    procedure DrawOn(g: TGPGraphics);
    procedure DrawOff(g: TGPGraphics);
    procedure DoSlide(Sender: TObject);
    function GetButtonRect: TGPRectF;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Paint; override;
    procedure SetComponentStyle(AStyle: TTMSStyle);
    procedure DoExit; override;
    procedure DoEnter; override;
  published
    property AnimationFactor: integer read FAnimationFactor write SetAnimationFactor default 15;
    property AppearanceOn: TAdvSmoothSliderAppearance read FAppearanceOn write SetAppearanceOn;
    property AppearanceOff: TAdvSmoothSliderAppearance read FAppearanceOff write SetAppearanceOff;
    property ButtonAppearance: TAdvSmoothSliderButtonAppearance read FButtonAppearance write SetButtonAppearance;
    property ValueOn: Double read FValueOn write SetValueOn;
    property ValueOff: Double read FValueOff write SetValueOff;
    property State: TAdvSmoothSliderState read FState write SetState default ssOn;
    property ShowFocus: Boolean read FShowFocus write SetShowFocus default true;
    property FocusColor: TColor read FFocusColor write SetFocusColor default clBlack;
    property Fill: TGDIPFill read FFill write SetFill;

    property OnStateChanged: TAdvSmoothStateChanged read FOnStateChanged write FOnStateChanged;

    property Align;
    property Anchors;
    property Constraints;
    property PopupMenu;
    property TabOrder;
    property Enabled;
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

procedure GetPosition(var x, y: Double; rectangle: TGPRectF; objectwidth, objectheight: integer; location: TAdvSmoothSliderCaptionPosition);
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

function PtInGPRect(r: TGPRectF; pt: TPoint): Boolean;
begin
  result := ((pt.X >= r.X) and (pt.X <= r.X + r.Width)) and
     ((pt.Y >= r.Y) and (pt.Y <= r.Y + r.Height));
end;

{ TAdvSmoothSlider }

procedure TAdvSmoothSlider.AppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothSlider.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothSlider) then
  begin
    FAppearanceOff.Assign((Source as TAdvSmoothSlider).AppearanceOff);
    FAppearanceOn.Assign((source as TAdvSmoothSlider).AppearanceOn);
    FState := (Source as TAdvSmoothSlider).State;
    FValueOff := (Source as TAdvSmoothSlider).ValueOff;
    FValueOn := (Source as TAdvSmoothSlider).ValueOn;
    FAnimationFactor := (Source as TAdvSmoothSlider).AnimationFactor;
    FFill.Assign((Source as TAdvSmoothSlider).Fill);
    FButtonAppearance.Assign((Source as TAdvSmoothSlider).ButtonAppearance);
    FFocusColor := (Source as TAdvSmoothSlider).FocusColor;
    FShowFocus := (Source as TAdvSmoothSlider).ShowFocus;
    Changed;
  end;
end;

procedure TAdvSmoothSlider.Changed;
begin
  Invalidate;
end;

procedure TAdvSmoothSlider.CMMouseLeave(var Message: TMessage);
begin
  FMouseDown := false;
end;

constructor TAdvSmoothSlider.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := true;
  FSlide := TTimer.Create(Self);
  FSlide.Interval := 10;
  FSlide.Enabled := true;
  FSlide.OnTimer := DoSlide;
  FAppearanceOff := TAdvSmoothSliderAppearance.Create(Self);
  FAppearanceOff.OnChange := AppearanceChanged;
  FAppearanceOn := TAdvSmoothSliderAppearance.Create(Self);
  FAppearanceOn.OnChange := AppearanceChanged;
  FState := ssOn;
  FButtonAppearance := TAdvSmoothSliderButtonAppearance.Create(Self);
  FButtonAppearance.OnChange := AppearanceChanged;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  Width := 80;
  Height := 30;
  FDoAnimation := false;
  FAnimationFactor := 15;
  FShowFocus := true;
  FFocusColor := clBlack;
  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  if FDesignTime then
    SetComponentStyle(tsOffice2007Luna);
end;

destructor TAdvSmoothSlider.Destroy;
begin
  FAppearanceOff.Free;
  FAppearanceOn.Free;
  FButtonAppearance.Free;
  FFill.Free;
  inherited;
end;

procedure TAdvSmoothSlider.DoEnter;
begin
  inherited;
  Ffocused := true;
  Changed;
end;

procedure TAdvSmoothSlider.DoExit;
begin
  inherited;
  FFocused := false;
  Changed;
end;

procedure TAdvSmoothSlider.DoSlide(Sender: TObject);
var
  d, pos: Single;
  doanim: Boolean;
begin
  if FDoAnimation then
  begin
    d := Abs(FCurrentPos - FPosTo) / AnimationFactor;
    pos := FCurrentPos;
    doanim := AnimateDouble(pos, FposTo, d, 0.01);
    if doanim then
    begin
      FCurrentPos := pos;
      Changed;
    end
    else
      FDoAnimation := false;
  end;
end;

procedure TAdvSmoothSlider.DrawBackGround(g: TGPGraphics);
begin
  FFill.Fill(g, MakeRect(0, 0, Width - 1, Height - 1));
end;

procedure TAdvSmoothSlider.DrawButton(g: TGPGraphics);
begin
  with FButtonAppearance do
  begin
    FFill.BeginUpdate;
    FFill.Focus := ShowFocus and TabStop and Ffocused;
    FFill.FocusColor := FocusColor;
    FFill.Fill(g, GetButtonRect);
    FFill.EndUpdate;
  end;
end;

procedure TAdvSmoothSlider.DrawCaption(g: TGPGraphics;
  app: TAdvSmoothSliderAppearance; r: TGPRectF);
var
  ff: TGPFontFamily;
  fs: integer;
  sf: TGPStringFormat;
  f: TGPFont;
  sizerect: TGPRectF;
  tw, th: integer;
  x, y: Double;
  b: TGPSolidBrush;
begin
  with app do
  begin
    if Caption <> '' then
    begin
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
      f := TGPFont.Create(ff, FFont.Size , fs, UnitPoint);
      g.MeasureString(Caption, Length(Caption), f, r, sf, sizerect);

      tw := Round(sizerect.Width);
      th := Round(sizerect.Height);

      if CaptionPosition <> cpCustom then
        GetPosition(x, y, r, tw, th, CaptionPosition)
      else
      begin
        x := CaptionLeft;
        y := CaptionLeft;
      end;

      b := TGPSolidBrush.Create(MakeColor(255, FFont.Color));
      g.DrawString(Caption, Length(Caption), f, MakePoint(r.X + x, r.Y + y), sf, b);
      b.Free;

      f.Free;
      sf.Free;
      ff.Free;
    end;
  end;
end;

procedure TAdvSmoothSlider.DrawOff(g: TGPGraphics);
var
  r: TGPRectF;
begin
  with AppearanceOff do
  begin
    r := MakeRect(GetButtonRect.X + ButtonAppearance.Size / 2, InsideRect.Top, InsideRect.Right - GetButtonRect.X - ButtonAppearance.Size / 2, InsideRect.Bottom - InsideRect.Top);
    FFill.Fill(g, r);
    DrawCaption(g, AppearanceOff, MakeRect(r.X, r.Y, r.Width + r.X, r.Height));
  end;
end;

procedure TAdvSmoothSlider.DrawOn(g: TGPGraphics);
var
  r: TGPRectF;
begin
  with AppearanceOn do
  begin
    r := MakeRect(InsideRect.Left, InsideRect.Top, GetButtonRect.X + ButtonAppearance.Size / 2, InsideRect.Bottom - InsideRect.Top);
    FFill.Fill(g, r);
    DrawCaption(g, AppearanceOn, MakeRect(FCurrentPos, r.Y, r.Width - FCurrentPos - ButtonAppearance.Size / 2, r.Height));
  end;
end;

procedure TAdvSmoothSlider.FillChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothSlider.GetButtonRect: TGPRectF;
begin
  with ButtonAppearance do
  begin
    if (FFill.BorderColor <> clNone) and (FFill.BorderWidth <> 0) then
      result := MakeRect(InsideRect.Right - Size, InsideRect.Top, Size, InsideRect.Bottom - InsideRect.Top)
    else
      result := MakeRect(InsideRect.Right - Size, InsideRect.Top, Size, InsideRect.Bottom - InsideRect.Top);

    result.X := Result.X + FCurrentPos;
    Result.X := Max(result.X, InsideRect.Left);
    result.X := Min(result.X, InsideRect.Right - ButtonAppearance.Size);
  end;
end;

function TAdvSmoothSlider.InsideRect: TRect;
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

procedure TAdvSmoothSlider.KeyDown(var Key: Word; Shift: TShiftState);
var
  s: TAdvSmoothSliderState;
  v: Double;
begin
  inherited;
  s := FState;
  case Key of
    VK_UP, VK_LEFT: FState := ssOff;
    VK_DOWN, VK_RIGHT: FState := ssOn;
    VK_F4:
    begin
      if FState = ssOn then
        FState := ssOff
      else
        FState := ssOn;
    end;
  end;

  if s <> FState then
  begin
    case FState of
      ssOn: FPosTo := 0;
      ssOff: FPosTo := -Width + ButtonAppearance.Size;
    end;
    FDoAnimation := true;

    if Assigned(FOnStateChanged) then
    begin
      v := 0;
      case FState of
        ssOn: v := ValueOn;
        ssOff: v := ValueOff;
      end;
      FOnStateChanged(Self, FState, v);
    end;
  end;
end;

procedure TAdvSmoothSlider.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FFocused := true;
  FMouseDown := PtInGPRect(GetButtonRect, Point(X, Y));
  FCx := X;
end;

procedure TAdvSmoothSlider.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FMouseDown and not FDoAnimation then
  begin
    case FState of
      ssOn: FCurrentPos := Max(Min(X - FCx, 0), - Width + ButtonAppearance.Size);
      ssOff: FCurrentPos := Max(Min(X - FCx - Width + ButtonAppearance.Size, 0), - Width + ButtonAppearance.Size);
    end;
    Changed;
  end;
end;

procedure TAdvSmoothSlider.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  s: TAdvSmoothSliderState;
  v: Double;
begin
  inherited;
  s := FState;
  if FMouseDown then
  begin
    if GetButtonRect.X + (GetButtonRect.Width / 2) > Width / 2 then
    begin
      FPosTo := 0;
      FState := ssOn;
    end
    else
    begin
      FPosTo := -Width + ButtonAppearance.Size;
      FState := ssOff;
    end;
  end
  else
  begin
    if X < GetButtonRect.X then
    begin
      FPosTo := -Width + ButtonAppearance.Size;
      FState := ssOff;
    end
    else if x > GetbuttonRect.X then
    begin
      FPosTo := 0;
      FState := ssOn;
    end;
  end;

  FDoAnimation := true;
  FMouseDown := false;

  if s <> FState then
  begin
    if Assigned(FOnStateChanged) then
    begin
      v := 0;
      case FState of
        ssOn: v := ValueOn;
        ssOff: v := ValueOff;
      end;
      FOnStateChanged(Self, FState, v);
    end;
  end;
end;

procedure TAdvSmoothSlider.Paint;
var
  g: TGPGraphics;
begin
  inherited;
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
  DrawBackGround(g);
  DrawOn(g);
  DrawOff(g);
  DrawButton(g);
  g.Free;
end;

procedure TAdvSmoothSlider.SetAnimationFactor(const Value: integer);
begin
  if (FAnimationFactor <> value) and (Value > 0) then
  begin
    FAnimationFactor := Value;
    changed;
  end;
end;

procedure TAdvSmoothSlider.SetAppearanceOff(
  const Value: TAdvSmoothSliderAppearance);
begin
  if FAppearanceOff <> value then
  begin
    FAppearanceOff.Assign(Value);
    AppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothSlider.SetAppearanceOn(
  const Value: TAdvSmoothSliderAppearance);
begin
  if FAppearanceOn <> Value then
  begin
    FAppearanceOn.Assign(Value);
    AppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothSlider.SetButtonAppearance(
  const Value: TAdvSmoothSliderButtonAppearance);
begin
  if FButtonAppearance <> Value then
  begin
    FButtonAppearance.Assign(Value);
    AppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothSlider.SetComponentStyle(AStyle: TTMSStyle);
begin
  // TODO : do color settings here
 case AStyle of
    tsOffice2003Blue:
      begin
        Fill.Color := $00FFD2AF;
        Fill.ColorTo := $00FFD2AF;
        Fill.BorderColor := clNone;

        ButtonAppearance.Fill.Color := $D68759;
        ButtonAppearance.Fill.ColorTo := $933803;
        ButtonAppearance.Fill.BorderColor := $962D00;

        AppearanceOff.Fill.Color := $EEDBC8;
        AppearanceOff.Fill.ColorTo := $F6DDC9;
        AppearanceOff.Fill.ColorMirror := $EDD4C0;
        AppearanceOff.Fill.ColorMirrorTo := $F7E1D0;
        AppearanceOff.Fill.BorderColor := clNone;
        AppearanceOff.Fill.GradientMirrorType := gtVertical;

        AppearanceOn.Fill.Color := $AAD9FF;
        AppearanceOn.Fill.ColorTo := $6EBBFF;
        AppearanceOn.Fill.ColorMirror := $42AEFE;
        AppearanceOn.Fill.ColorMirrorTo := $7AE1FE;
        AppearanceOn.Fill.BorderColor := $42AEFE;
        AppearanceOn.Fill.GradientMirrorType := gtVertical;

      end;
    tsOffice2003Silver:
      begin
        ButtonAppearance.Fill.Color := $BDA4A5;
        ButtonAppearance.Fill.ColorTo := $957475;
        ButtonAppearance.Fill.BorderColor := $947C7C;

        AppearanceOff.Fill.Color := $E6E9E2;
        AppearanceOff.Fill.ColorTo := $00E6D8D8;
        AppearanceOff.Fill.ColorMirror := $C8B2B3;
        AppearanceOff.Fill.ColorMirrorTo := $E6E9E2;
        AppearanceOff.Fill.BorderColor := clNone;
        AppearanceOff.Fill.GradientMirrorType := gtVertical;

        AppearanceOn.Fill.Color := $AAD9FF;
        AppearanceOn.Fill.ColorTo := $6EBBFF;
        AppearanceOn.Fill.ColorMirror := $42AEFE;
        AppearanceOn.Fill.ColorMirrorTo := $7AE1FE;
        AppearanceOn.Fill.BorderColor := $42AEFE;
        AppearanceOn.Fill.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Olive:
      begin
        ButtonAppearance.Fill.Color := $82C0AF;
        ButtonAppearance.Fill.ColorTo := $447A63;
        ButtonAppearance.Fill.BorderColor := $588060;

        AppearanceOff.Fill.Color := $CFF0EA;
        AppearanceOff.Fill.ColorTo := $CFF0EA;
        AppearanceOff.Fill.ColorMirror := $8CC0B1;
        AppearanceOff.Fill.ColorMirrorTo := $CFF0EA;
        AppearanceOff.Fill.BorderColor := clNone;
        AppearanceOff.Fill.GradientMirrorType := gtVertical;

        AppearanceOn.Fill.Color := $AAD9FF;
        AppearanceOn.Fill.ColorTo := $6EBBFF;
        AppearanceOn.Fill.ColorMirror := $42AEFE;
        AppearanceOn.Fill.ColorMirrorTo := $7AE1FE;
        AppearanceOn.Fill.BorderColor := $42AEFE;
        AppearanceOn.Fill.GradientMirrorType := gtVertical;
      end;
    tsOffice2003Classic:
      begin
        ButtonAppearance.Fill.Color := $808080;
        ButtonAppearance.Fill.ColorTo := $808080;
        ButtonAppearance.Fill.BorderColor := $808080;

        AppearanceOff.Fill.Color := clWhite;
        AppearanceOff.Fill.ColorTo := $C9D1D5;
        AppearanceOff.Fill.ColorMirror := clNone;
        AppearanceOff.Fill.ColorMirrorTo := clNone;
        AppearanceOff.Fill.BorderColor := clNone;
        AppearanceOff.Fill.GradientMirrorType := gtVertical;

        AppearanceOn.Fill.Color := $B59285;
        AppearanceOn.Fill.ColorTo := $B59285;
        AppearanceOn.Fill.ColorMirror := clNone;
        AppearanceOn.Fill.ColorMirrorTo := clNone;
        AppearanceOn.Fill.BorderColor := $808080;
        AppearanceOn.Fill.GradientMirrorType := gtVertical;
      end;
    tsOffice2007Luna:
      begin
        ButtonAppearance.Fill.Color := $FFEFE3;
        ButtonAppearance.Fill.ColorTo := $FFD2AF;
        ButtonAppearance.Fill.BorderColor := $00FFD2AF;

        AppearanceOff.Fill.Color := $FFEFE3;
        AppearanceOff.Fill.ColorTo := $FFDDC4;
        AppearanceOff.Fill.ColorMirror := $FFD1AD;
        AppearanceOff.Fill.ColorMirrorTo := $FFDBC0;
        AppearanceOff.Fill.BorderColor := clNone;
        AppearanceOff.Fill.GradientMirrorType := gtVertical;

        AppearanceOn.Fill.Color := $AAD9FF;
        AppearanceOn.Fill.ColorTo := $6EBBFF;
        AppearanceOn.Fill.ColorMirror := $42AEFE;
        AppearanceOn.Fill.ColorMirrorTo := $7AE1FE;
        AppearanceOn.Fill.BorderColor := $42AEFE;
        AppearanceOn.Fill.GradientMirrorType := gtVertical;
      end;
    tsOffice2007Obsidian:
      begin
        ButtonAppearance.Fill.Color := $F2F1F0;
        ButtonAppearance.Fill.ColorTo := $C9C2BD;
        ButtonAppearance.Fill.BorderColor := $5C534C;

        AppearanceOff.Fill.Color := $F9F8F8;
        AppearanceOff.Fill.ColorTo := $E4E2DF;
        AppearanceOff.Fill.ColorMirror := $D1CBC7;
        AppearanceOff.Fill.ColorMirrorTo := $E2DEDB;
        AppearanceOff.Fill.BorderColor := clNone;
        AppearanceOff.Fill.GradientMirrorType := gtVertical;

        AppearanceOn.Fill.Color := $AAD9FF;
        AppearanceOn.Fill.ColorTo := $6EBBFF;
        AppearanceOn.Fill.ColorMirror := $42AEFE;
        AppearanceOn.Fill.ColorMirrorTo := $7AE1FE;
        AppearanceOn.Fill.BorderColor := $42AEFE;
        AppearanceOn.Fill.GradientMirrorType := gtVertical;
      end;
    tsWindowsXP:
      begin
        ButtonAppearance.Fill.Color := clBtnFace;
        ButtonAppearance.Fill.ColorTo := clBtnFace;
        ButtonAppearance.Fill.BorderColor := clBlack;

        AppearanceOff.Fill.Color := clBtnFace;//clWhite;
        AppearanceOff.Fill.ColorTo := clBtnFace;//$B9D8DC;
        AppearanceOff.Fill.ColorMirror := clNone;
        AppearanceOff.Fill.ColorMirrorTo := clNone;
        AppearanceOff.Fill.BorderColor := clNone;
        AppearanceOff.Fill.GradientMirrorType := gtVertical;

        AppearanceOn.Fill.Color := clInactiveCaption;
        AppearanceOn.Fill.ColorTo := clInactiveCaption;
        AppearanceOn.Fill.ColorMirror := clNone;
        AppearanceOn.Fill.ColorMirrorTo := clNone;
        AppearanceOn.Fill.BorderColor := clHighLight;
        AppearanceOn.Fill.GradientMirrorType := gtVertical;
      end;
    tsWhidbey:
      begin
        ButtonAppearance.Fill.Color := $EBEEEF;
        ButtonAppearance.Fill.ColorTo := $7E9898;
        ButtonAppearance.Fill.BorderColor := $962D00;

        AppearanceOff.Fill.Color := clWhite;
        AppearanceOff.Fill.ColorTo := $DFEDF0;
        AppearanceOff.Fill.ColorMirror := $DFEDF0;
        AppearanceOff.Fill.ColorMirrorTo := $DFEDF0;
        AppearanceOff.Fill.BorderColor := clNone;
        AppearanceOff.Fill.GradientMirrorType := gtVertical;

        AppearanceOn.Fill.Color := $AAD9FF;
        AppearanceOn.Fill.ColorTo := $6EBBFF;
        AppearanceOn.Fill.ColorMirror := $42AEFE;
        AppearanceOn.Fill.ColorMirrorTo := $7AE1FE;
        AppearanceOn.Fill.BorderColor := $42AEFE;
        AppearanceOn.Fill.GradientMirrorType := gtVertical;
      end;
    tsCustom: ;
    tsOffice2007Silver:
      begin
        ButtonAppearance.Fill.Color := $F8F7F6;
        ButtonAppearance.Fill.ColorTo := $E8E0DB;
        ButtonAppearance.Fill.BorderColor := $74706F;

        AppearanceOff.Fill.Color := $F9F8F8;
        AppearanceOff.Fill.ColorTo := $E4E2DF;
        AppearanceOff.Fill.ColorMirror := $D1CBC7;
        AppearanceOff.Fill.ColorMirrorTo := $E2DEDB;
        AppearanceOff.Fill.BorderColor := clNone;
        AppearanceOff.Fill.GradientMirrorType := gtVertical;

        AppearanceOn.Fill.Color := $AAD9FF;
        AppearanceOn.Fill.ColorTo := $6EBBFF;
        AppearanceOn.Fill.ColorMirror := $42AEFE;
        AppearanceOn.Fill.ColorMirrorTo := $7AE1FE;
        AppearanceOn.Fill.BorderColor := $42AEFE;
        AppearanceOn.Fill.GradientMirrorType := gtVertical;
      end;
  end;

  Fill.Rounding := 4;
  Fill.RoundingType := rtBoth;
  ButtonAppearance.Fill.Rounding := 4;
  AppearanceOn.Fill.Rounding := 4;
  AppearanceOn.Fill.RoundingType := rtLeft;
  AppearanceOff.Fill.Rounding := 4;
  AppearanceOff.Fill.RoundingType := rtRight;
  AppearanceOn.Caption := 'On';
  AppearanceOff.Caption := 'Off';
end;

procedure TAdvSmoothSlider.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill := Value;
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothSlider.SetFocusColor(const Value: TColor);
begin
  if FFocusColor <> value then
  begin
    FFocusColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothSlider.SetShowFocus(const Value: Boolean);
begin
  if FShowFocus <> value then
  begin
    FShowFocus := Value;
    Changed;
  end;
end;

procedure TAdvSmoothSlider.SetState(const Value: TAdvSmoothSliderState);
begin
  if FState <> value then
  begin
    FState := Value;
    case Value of
      ssOn: FPosTo := 0;
      ssOff: FPosTo := -Width + ButtonAppearance.Size;
    end;
    FCurrentPos := FPosTo;
    Changed;
  end;
end;

procedure TAdvSmoothSlider.SetValueOff(const Value: Double);
begin
  if FValueOff <> value then
  begin
    FValueOff := Value;
    Changed;
  end;
end;

procedure TAdvSmoothSlider.SetValueOn(const Value: Double);
begin
  if FValueOn <> value then
  begin
    FValueOn := Value;
    Changed;
  end;
end;

procedure TAdvSmoothSlider.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.Result := 0;
end;

{ TAdvSmoothSliderAppearance }

procedure TAdvSmoothSliderAppearance.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothSliderAppearance) then
  begin
    FFont.Assign((Source as TAdvSmoothSliderAppearance).Font);
    FCaption := (Source as TAdvSmoothSliderAppearance).Caption;
    FFill.Assign((Source as TAdvSmoothSliderAppearance).Fill);
    FCaptionPosition := (Source as TAdvSmoothSliderAppearance).CaptionPosition;
    FCaptionLeft := (Source as TAdvSmoothSliderAppearance).CaptionLeft;
    FCaptionTop := (Source as TAdvSmoothSliderAppearance).CaptionTop;
    Changed;
  end;
end;

procedure TAdvSmoothSliderAppearance.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TAdvSmoothSliderAppearance.Create(AOwner: TAdvSmoothSlider);
begin
  FOwner := AOwner;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FFont := TFont.Create;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}
  FFont.OnChange := FontChanged;
  FCaptionPosition := cpCenterCenter;
  FCaptionLeft := 0;
  FCaptionTop := 0;
end;

destructor TAdvSmoothSliderAppearance.Destroy;
begin
  FFill.Free;
  FFont.Free;
  inherited;
end;

procedure TAdvSmoothSliderAppearance.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothSliderAppearance.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothSliderAppearance.SetCaption(const Value: String);
begin
  if FCaption <> value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothSliderAppearance.SetCaptionLeft(const Value: integer);
begin
  if FCaptionTop <> value then
  begin
    FCaptionLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothSliderAppearance.SetCaptionPosition(
  const Value: TAdvSmoothSliderCaptionPosition);
begin
  if FCaptionPosition <> value then
  begin
    FCaptionPosition := Value;
    Changed;
  end;
end;

procedure TAdvSmoothSliderAppearance.SetCaptionTop(const Value: integer);
begin
  if FCaptionTop <> value then
  begin
    FCaptionTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothSliderAppearance.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothSliderAppearance.SetFont(const Value: TFont);
begin
  if FFont <> value  then
  begin
    FFont.Assign(Value);
    FontChanged(Self);
  end;
end;

{ TAdvSmoothSliderButtonAppearance }

procedure TAdvSmoothSliderButtonAppearance.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothSliderButtonAppearance) then
  begin
    FSize := (Source as TAdvSmoothSliderButtonAppearance).Size;
    FFill.Assign((Source as TAdvSmoothSliderButtonAppearance).Fill);
    Changed;
  end;
end;

procedure TAdvSmoothSliderButtonAppearance.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TAdvSmoothSliderButtonAppearance.Create(AOwner: TAdvSmoothSlider);
begin
  FOwner := AOwner;
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FSize := 40;
end;

destructor TAdvSmoothSliderButtonAppearance.Destroy;
begin
  FFill.Free;
  inherited;
end;

procedure TAdvSmoothSliderButtonAppearance.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothSliderButtonAppearance.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill := Value;
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothSliderButtonAppearance.SetSize(const Value: integer);
begin
  if FSize <> value then
  begin
    FSize := Value;
    Changed;
  end;
end;

end.
