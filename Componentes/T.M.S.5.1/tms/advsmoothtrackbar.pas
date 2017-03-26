{**************************************************************************}
{ TAdvSmoothTrackBar Component                                             }
{ for Delphi & C++Builder                                                  }
{                                                                          }
{ written by TMS Software                                                  }
{            copyright © 2098                                              }
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
unit AdvSmoothTrackBar;

{$I TMSDEFS.inc}

interface

uses
  Classes, SysUtils, Controls, GDIPFill, AdvSmoothGDIP, Graphics, Windows,
  AdvStyleIF, Math, ExtCtrls, Messages;


const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 1; // Build nr.

  // v1.0.0.0 : First Release
  // v1.0.0.1 : Improved: Event OnPositionChanged called when user programmatically changes position
  //            or click above or under thumb
  // v1.1.0.0 : New : Keyboard support to increase or decrease value
  //          : New : Focus indication on thumb fill
  // v1.1.0.1 : Fixed: issue with saving width and height

type
  TAdvSmoothTrackBarDirection = (dVertical, dHorizontal);

  TAdvSmoothTrackBarValueChanged = procedure(Sender: TObject; Position: Double) of object;

  TAdvSmoothTrackBar = class(TCustomControl, ITMSStyle)
  private
    FDoGlow, FFocused: Boolean;
    FGlowCount: integer;
    FGlowPos: Double;  
    FAnimationTimer: TTimer;
    FLoaded: Boolean;
    FMouseDownOnSlider: Boolean;
    FSliderPos: integer;
    FDesignTime: Boolean;  
    FResize: Boolean;
    FOldW, FOldH: integer;
    FDirection: TAdvSmoothTrackBarDirection;
    FFill: TGDIPFill;
    FProgressFill: TGDIPFill;
    FFont: TFont;
    FThumbFill: TGDIPFill;
    FMaximum: Double;
    FFormat: String;
    FMinimum: Double;
    FStep: Double;
    FThumbSize: integer;
    FPosition: Double;
    FTickMarkSize: integer;
    FShowValues: Boolean;
    FShowTickMarks: Boolean;
    FSnapToTickMarks: Boolean;
    FSnapMargin: Double;
    FOnPositionChanged: TAdvSmoothTrackBarValueChanged;
    FGlowAnimation: Boolean;
    FShowProgress: Boolean;
    FTickMarkColor: TColor;
    FProgressFont: TFont;
    procedure SetDirection(const Value: TAdvSmoothTrackBarDirection);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetProgressFill(const Value: TGDIPFill);
    procedure SetFont(const Value: TFont);
    procedure SetThumbFill(const Value: TGDIPFill);
    procedure SetFormat(const Value: String);
    procedure SetMaximum(const Value: Double);
    procedure SetMinimum(const Value: Double);
    procedure SetStep(const Value: Double);
    procedure setThumbSize(const Value: integer);
    procedure SetPosition(const Value: Double);
    procedure SetShowTickMarks(const Value: Boolean);
    procedure SetShowValues(const Value: Boolean);
    procedure SetTickMarkSize(const Value: integer);
    procedure SetSnapToTickMarks(const Value: Boolean);
    procedure SetSnapMargin(const Value: Double);
    procedure SetGlowAnimation(const Value: Boolean);
    procedure SetShowProgress(const Value: Boolean);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SetTickMarkColor(const Value: TColor);
    procedure SetProgressFont(const Value: TFont);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;    
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;  
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure FontChanged(Sender: TObject);
    procedure DrawBackGround(g: TGPGraphics);
    procedure DrawOverlay(g: TGPGraphics);
    procedure DrawProgress(g: TGPGraphics);
    procedure DrawSlider(g: TGPGraphics);
    procedure DrawNumbers(g: TGPGraphics);
    procedure AnimateGlow(Sender: TObject);
    procedure DoExit; override;
    procedure DoEnter; override;
    function IsGlowAnimation: Boolean;
    function InsideRect: TRect;
    function GetNumRect: TGPRectF;
    function GetSliderRect: TGPRectF;
    function GetPosition: Double; overload;
    function GetPosition(XYPos: Double): Double; overload;
    function GetVersionNr: integer;    
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure SetComponentStyle(AStyle: TTMSStyle);
    procedure Paint; override;
    procedure Resize; override;
    procedure CreateWnd; override;
  published
    property Direction: TAdvSmoothTrackBarDirection read FDirection write SetDirection default dVertical;
    property Fill: TGDIPFill read FFill write SetFill;
    property ProgressFill: TGDIPFill read FProgressFill write SetProgressFill;
    property ThumbFill: TGDIPFill read FThumbFill write SetThumbFill;
    property ThumbSize: integer read FThumbSize write setThumbSize default 40;
    property Font: TFont read FFont write SetFont;
    property ProgressFont: TFont read FProgressFont write SetProgressFont;
    property Minimum: Double read FMinimum write SetMinimum;
    property Maximum: Double read FMaximum write SetMaximum;
    property Step: Double read FStep write SetStep;
    property Position: Double read FPosition write SetPosition;
    property ValueFormat: String read FFormat write SetFormat;
    property ShowValues: Boolean read FShowValues write SetShowValues default true;
    property ShowTickMarks: Boolean read FShowTickMarks write SetShowTickMarks default true;
    property TickMarkSize: integer read FTickMarkSize write SetTickMarkSize default 15;
    property TickMarkColor: TColor read FTickMarkColor write SetTickMarkColor default clBlack;
    property SnapToTickMarks: Boolean read FSnapToTickMarks write SetSnapToTickMarks default true;
    property SnapMargin: Double read FSnapMargin write SetSnapMargin;
    property GlowAnimation: Boolean read FGlowAnimation write SetGlowAnimation default true;
    property ShowProgress: Boolean read FShowProgress write SetShowProgress default true;
    property Version: string read GetVersion write SetVersion;

    property OnPositionChanged: TAdvSmoothTrackBarValueChanged read FOnPositionChanged write FOnPositionChanged;
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

function CreateRoundRectangle(R: TGPRectF; Radius: Integer; RoundingType: TFillRoundingType): TGPGraphicsPath; overload;
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

{ TAdvSmoothTrackBar }

procedure TAdvSmoothTrackBar.AnimateGlow(Sender: TObject);
var
  endpos: Double;
begin
  if IsGlowAnimation then
  begin
    FGlowPos := FGlowPos + 3;
    endpos := 0;
    case Direction of
      dVertical: endpos := GetPosition;
      dHorizontal: endpos := GetPosition;
    end;

    if FGlowPos > endpos then
    begin
      FGlowCount := 0;
      FGlowPos := -60;
      FDoGlow := false;
    end
    else
      FGlowCount := FGlowCount + 10;

    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothTrackBar) then
  begin
    FDirection := (Source as TAdvSmoothTrackBar).Direction;
    FFill.Assign((Source as TAdvSmoothTrackBar).Fill);
    FProgressFill.Assign((Source as TAdvSmoothTrackBar).ProgressFill);
    FThumbFill.Assign((Source as TAdvSmoothTrackBar).ThumbFill);
    FThumbSize := (Source as TAdvSmoothTrackBar).ThumbSize;
    FFont.Assign((Source as TAdvSmoothTrackBar).Font);
    FMinimum := (Source as TAdvSmoothTrackBar).Minimum;
    FMaximum := (Source as TAdvSmoothTrackBar).Maximum;
    FStep := (Source as TAdvSmoothTrackBar).Step;
    FPosition := (Source as TAdvSmoothTrackBar).Position;
    FFormat := (Source as TAdvSmoothTrackBar).ValueFormat;
    FShowValues := (Source as TAdvSmoothTrackBar).ShowValues;
    FShowTickMarks := (Source as TAdvSmoothTrackBar).ShowTickMarks;
    FTickMarkSize := (Source as TAdvSmoothTrackBar).TickMarkSize;
    FSnapToTickMarks := (Source as TAdvSmoothTrackBar).SnapToTickMarks;
    FSnapMargin := (Source as TAdvSmoothTrackBar).SnapMargin;
    FGlowAnimation := (Source as TAdvSmoothTrackBar).GlowAnimation;
    FTickMarkColor := (Source as TAdvSmoothTrackBar).TickMarkColor;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.Changed;
begin
  Invalidate;
end;

constructor TAdvSmoothTrackBar.Create(AOwner: TComponent);
begin
  inherited;
  FAnimationTimer := TTimer.Create(self);
  FAnimationTimer.Interval := 10;
  FAnimationTimer.Enabled := true;  
  FAnimationTimer.OnTimer := AnimateGlow;
  FSliderPos := 0;
  DoubleBuffered := true;
  FResize := false;
  Width := 90;
  Height := 250;
  FOldW := Height;
  FOldH := Width;
  FDirection := dVertical;
  FResize := true;  
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FProgressFill := TGDIPFill.Create;
  FProgressFill.OnChange := FillChanged;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FProgressFont := TFont.Create;
  FProgressFont.OnChange := FontChanged;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  FProgressFont.Name := 'Tahoma';  
  {$ENDIF}
  FThumbFill := TGDIPFill.Create;
  FThumbFill.OnChange := FillChanged;
  FMaximum := 100;
  FMinimum := 0;
  FStep := 20;
  FFormat := '%g db';
  FThumbSize := 40;
  FTickMarkSize := 15;
  FShowValues := true;
  FShowTickMarks := true;
  FSnapToTickMarks := true;
  FSnapMargin := 10;
  FGlowAnimation := true;
  FShowProgress := true;
  FGlowCount := 3000; //3sec
  FGlowPos := -40;
  FTickMarkColor := clBlack;
  FGlowPos := -60;
  FGlowCount := 0;
  FDoGlow := false;

  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  if FDesignTime then
  begin
    SetComponentStyle(tsOffice2007Luna);
//    ThumbFill.Rounding := 10;
//    ThumbFill.BorderColor := clGray;
//    ThumbFill.Color := clwhite;
//    ThumbFill.ColorTo := clWhite;
//    ThumbFill.GradientType := gtForwardDiagonal;
//    ThumbFill.OpacityTo := 0;
//
//    Fill.GradientType := gtSolid;
//    Fill.Color := $ABC6C9;
//
//    ProgressFill.GradientType := gtVertical;
//    ProgressFill.Color := $A4F8FB;
//    ProgressFill.ColorTo := $3FF210;
  end;
end;

procedure TAdvSmoothTrackBar.CreateWnd;
begin
  inherited;
  FLoaded := true;
  SetDirection(Direction);
end;

destructor TAdvSmoothTrackBar.Destroy;
begin
  FFill.Free;
  FProgressFill.Free;
  FThumbFill.Free;
  FFont.Free;
  FProgressFont.Free;
  inherited;
end;

procedure TAdvSmoothTrackBar.DoEnter;
begin
  inherited;
  FFocused := true;
  Changed;
end;

procedure TAdvSmoothTrackBar.DoExit;
begin
  inherited;
  FFocused := false;
  Changed;
end;

procedure TAdvSmoothTrackBar.DrawBackGround(g: TGPGraphics);
begin
  FFill.Fill(g, MakeRect(0, 0, Width - 1, Height - 1));
end;

procedure TAdvSmoothTrackBar.DrawNumbers;
var
  numr, sizer: TGPRectF;
  pos, st: Double;
  ff: TGPFontFamily;
  fs: integer;
  f: TGPFont;
  sf: TGPStringFormat;
  I: Integer;
  s: String;
  b: TGPSolidBrush;
  pt: TGPPointF;
  p: TGPPen;
  numCount: integer;
  y, pty: single;
begin
  g.SetTextRenderingHint(TextRenderingHintAntiAlias);
  numCount := Round((Maximum - Minimum) / Step);
  pos := 0;
  st := 0;
  case Direction of
    dVertical:
    begin
     numr := GetNumRect;
     st := numr.Height / numcount;
     pos := numr.Height + numr.Y;
    end;
    dHorizontal:
    begin
     numr := GetNumRect;
     st := numr.Width / numcount;
     pos := numr.Width + numr.X;
    end;
  end;

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

  p := TGPPen.Create(MakeColor(125, TickMarkColor), 2);
  for I := 0 to numcount do
  begin
    try
      s := Format(FFormat, [I * step + Minimum]);
    except
      s := '';
    end;

    g.MeasureString(s, Length(s), f, numr, sf, sizer);
    case Direction of
      dVertical:
      begin
        pt := MakePoint((numr.Width - sizer.Width) / 2, pos - (sizer.Height / 2));
        if ShowTickMarks then
        begin
          //draw tickmarks
          g.DrawLine(p, numr.X, pos, numr.X + TickMarkSize, pos);
          g.DrawLine(p, numr.X + numr.Width - TickMarkSize, pos, numr.X + numr.Width, pos);
        end;
      end;
      dHorizontal:
      begin
        pt := MakePoint(numr.X + numr.Width - pos + (ThumbSize / 2) - (sizer.Width / 2), (numr.Height - sizer.Height) / 2);
        //draw tickmarks
        if ShowTickMarks then
        begin
          g.DrawLine(p, pos, numr.Y , pos, numr.Y + TickMarkSize);
          g.DrawLine(p, pos, numr.Y + numr.Height - TickMarkSize, pos, numr.Y + numr.Height);
        end;
      end;
    end;

    if ShowValues then
    begin
      //draw numbers
      b := nil;
      case Direction of
        dVertical:
        begin
          pty := pt.Y;
          y := InsideRect.Bottom - GetPosition - (ThumbSize / 2) - (sizer.Height / 2);
          if (pty < y) then
            b := TGPSolidBrush.Create(MakeColor(255, FFont.Color))
          else
            b := TGPSolidBrush.Create(MakeColor(255, FProgressFont.Color));
        end;
        dHorizontal:
        begin
          pty := pt.X;
          y := GetPosition + (ThumbSize / 2) - (sizer.Width / 2);
          if (pty > y) then
            b := TGPSolidBrush.Create(MakeColor(255, FFont.Color))
          else
            b := TGPSolidBrush.Create(MakeColor(255, FProgressFont.Color));
        end;
      end;

      g.DrawString(s, Length(s), f, pt,  sf, b);
      b.Free;
    end;
    pos := pos - st;
  end;
  p.Free;
  f.Free;
  sf.Free;
  ff.Free;
end;

procedure TAdvSmoothTrackBar.DrawOverlay(g: TGPGraphics);
var
  olr, toplr: TGPRectF;
  path: TGPGraphicsPath;
  rgn: TGPRegion;
  b: TGPBrush;
  p: TGPPen;
begin
  toplr := MakeRect(InsideRect.Left, InsideRect.Top, InsideRect.Right, InsideRect.Bottom);
  olr := MakeRect(InsideRect.Left + 7, InsideRect.Top + 7, InsideRect.Right - 14, InsideRect.Bottom - 14);
  path := CreateRoundRectangle(olr, 8, rtBoth);

  rgn := TGPRegion.Create(toplr);
  rgn.Exclude(path);
  g.SetClip(rgn);
  b := TGPSolidBrush.Create(MakeColor(75, clWhite));
  g.FillRectangle(b, toplr);
  g.ResetClip;
  rgn.Free;
  b.free;

  path.Free;

  path := CreateRoundRectangle(Makerect(olr.X, olr.Y, olr.Width, olr.Height), 10, rtBoth);
  p := TGPPen.Create(MakeColor(225, clWhite), 2);
  g.DrawPath(p, path);
  p.Free;
  path.Free;
end;

procedure TAdvSmoothTrackBar.DrawProgress(g: TGPGraphics);
var
  b: TGPLinearGradientBrush;
  rr, lr, o: TGPRectF;
  rgn: TGPRegion;
begin
  case Direction of
    dVertical:
    begin
      o := MakeRect(InsideRect.Left, InsideRect.Bottom - GetPosition - (ThumbSize / 2), InsideRect.Right, GetPosition + (ThumbSize / 2));
      FProgressFill.Fill(g, o);
      if IsGlowAnimation then
      begin
        rgn := TGPRegion.Create(o);
        g.SetClip(rgn);
        lr := MakeRect(o.X, InsideRect.Bottom - FGlowPos - 30, o.Width, 30);
        rr := MakeRect(o.X, InsideRect.Bottom - FGlowPos, o.Width, 30);
        b := TGPLinearGradientBrush.Create(MakeRect(lr.X - 1, lr.Y - 1, lr.Width + 2, lr.Height + 2), MakeColor(0, clWhite), MakeColor(120, clWhite), LinearGradientModeVertical);
        g.FillRectangle(b, lr);
        b.free;
        b := TGPLinearGradientBrush.Create(MakeRect(rr.X - 1, rr.Y - 1, rr.Width + 2, rr.Height + 2), MakeColor(120, clWhite), MakeColor(0, clWhite), LinearGradientModeVertical);
        g.FillRectangle(b, rr);
        b.free;
        g.ResetClip;
        rgn.free;
      end;
    end;
    dHorizontal:
    begin
      o := MakeRect(InsideRect.Left, InsideRect.Top, GetPosition + (ThumbSize / 2), InsideRect.Bottom);
      FProgressFill.Fill(g, o);
      if IsGlowAnimation then
      begin
        rgn := TGPRegion.Create(o);
        g.SetClip(rgn);
        lr := MakeRect(FGlowPos - 30, o.Y, 30, o.Height);
        rr := MakeRect(FGlowPos, o.Y, 30, o.Height);
        b := TGPLinearGradientBrush.Create(MakeRect(lr.X - 1, lr.Y - 1, lr.Width + 2, lr.Height + 2), MakeColor(0, clWhite), MakeColor(120, clWhite), LinearGradientModeHorizontal);
        g.FillRectangle(b, lr);
        b.free;
        b := TGPLinearGradientBrush.Create(MakeRect(rr.X - 1, rr.Y - 1, rr.Width + 2, rr.Height + 2), MakeColor(120, clWhite), MakeColor(0, clWhite), LinearGradientModeHorizontal);
        g.FillRectangle(b, rr);
        b.free;
        g.ResetClip;
        rgn.free;
      end;
    end;
  end;
end;

procedure TAdvSmoothTrackBar.DrawSlider(g: TGPGraphics);
var
  p, p2: TGPPen;
  slr: TGPRectF;
begin
  p := TGPPen.Create(MakeColor(120, ThumbFill.BorderColor));
  p2:= TGPPen.Create(MakeColor(150, clWhite));
  case Direction of
    dVertical:
    begin
      slr := GetSliderRect;
      FThumbFill.Fill(g, slr);
      g.DrawLine(p, slr.X, slr.Y + (slr.Height / 2), slr.X + slr.Width, slr.Y + (slr.Height / 2));
      g.DrawLine(p2, slr.X, slr.Y + (slr.Height / 2)+1, slr.X + slr.Width, slr.Y + (slr.Height / 2)+1);
    end;
    dHorizontal:
    begin
      slr := GetSliderRect;
      FThumbFill.Fill(g, slr);
      g.DrawLine(p, slr.X + (slr.Width / 2), slr.Y , slr.X + (slr.Width / 2), slr.Y  + slr.Height);
      g.DrawLine(p2, slr.X + (slr.Width / 2)+1, slr.Y, slr.X  + (slr.Width / 2)+1, slr.Y + slr.Height);
    end;
  end;

  if TabStop and FFocused then
    DrawFocus(g, slr, FThumbFill.Rounding, FThumbFill.RoundingType);

  p.Free;
  p2.Free;
end;

procedure TAdvSmoothTrackBar.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothTrackBar.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothTrackBar.GetNumRect: TGPRectF;
begin
  case Direction of
    dVertical: Result := MakeRect(InsideRect.Left, InsideRect.Top + (ThumbSize / 2), InsideRect.Right, InsideRect.Bottom - ThumbSize);
    dHorizontal: Result := MakeRect(InsideRect.Left + (ThumbSize / 2), InsideRect.Top, InsideRect.Right - ThumbSize, InsideRect.Bottom);
  end;
end;

function TAdvSmoothTrackBar.GetPosition(XYPos: Double): Double;
var
  v, totals, qr: Double;
begin
  totals := 0;
  case Direction of
    dVertical: totals := GetNumRect.Height;
    dHorizontal: totals := GetNumRect.Width;
  end;

  if (Maximum - Minimum) > 0 then
  begin
    v := (XYPos / Totals) * (Maximum - Minimum) + Minimum;
    if FSnapToTickMarks then
    begin
      qr := Round(v / Step) * Step;
      if (v >= qr - FSnapMargin) and (v <= qr + FSnapMargin) then
        v := qr
      else
    end;

    Result := Max(Min(v, Maximum), Minimum);
  end
  else
    Result := 0;
end;

function TAdvSmoothTrackBar.GetPosition: Double;
var
  totals: Double;
begin
  totals := 0;
  case Direction of
    dVertical: totals := GetNumRect.Height;
    dHorizontal: totals := GetNumRect.Width;
  end;

  if (Maximum - Minimum) > 0 then
    Result := Min(((Position - Minimum) / (Maximum - Minimum)) * totals, totals)
  else
    Result := 0;
end;

function TAdvSmoothTrackBar.GetSliderRect: TGPRectF;
begin
  case Direction of
    dVertical: Result := MakeRect(InsideRect.Left + 7, GetNumRect.Y + GetNumRect.Height - GetPosition - (ThumbSize / 2), InsideRect.Right - 14, ThumbSize);
    dHorizontal: Result := MakeRect(GetNumRect.X + GetPosition - (ThumbSize / 2), InsideRect.Top + 7, ThumbSize, InsideRect.Bottom - 14);
  end;
end;

function TAdvSmoothTrackBar.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvSmoothTrackBar.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

function TAdvSmoothTrackBar.InsideRect: TRect;
var
  sh, bw: integer;
begin
  sh := 0;
  if (Fill.ShadowColor <> clNone) {and not Transparent} then
    sh := Fill.ShadowOffset;

  Result := Rect(0, 0, Width, Height);
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

function TAdvSmoothTrackBar.IsGlowAnimation: Boolean;
begin
  Result := false;
  if not (csDesigning in ComponentState) and FDoGlow then
    Result := GlowAnimation;
end;

procedure TAdvSmoothTrackBar.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not TabStop then
    Exit;

  case Key of
    VK_LEFT, VK_DOWN: Position := Position - Step;
    VK_RIGHT, VK_UP: Position := Position + Step;
    VK_HOME: Position := Minimum;
    VK_END: Position := Maximum;
  end;
end;

procedure TAdvSmoothTrackBar.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  r: TGPRectF;
begin
  inherited;
  SetFocus;
  r := GetSliderRect;
  FMouseDownOnSlider := PtInRect(Bounds(Round(r.X), Round(r.Y), Round(r.Width), Round(r.Height)), Point(X, Y));
end;

procedure TAdvSmoothTrackBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  r: TGPRectF;
  pos, v: Double;
begin
  inherited;
  r := GetSliderRect;

  if FMouseDownOnSlider then
    Cursor := crHandPoint
  else
    Cursor := crArrow;


  if FMouseDownOnSlider then
  begin
    case Direction of
      dVertical:
      begin
        pos := Height - (ThumbSize / 2) - Y;
        v := GetPosition(pos);
        if (v >= Minimum) and (v <= Maximum) and (v <> FPosition) then
        begin
          FPosition := v;
          if FGlowPos = -60 then
            FDoGlow := true;
          if Assigned(OnPositionChanged) then
            OnPositionChanged(Self, Position);
        end;
      end;
      dHorizontal:
      begin
        pos := X - (ThumbSize / 2);
        v := GetPosition(pos);
        if (v >= Minimum) and (v <= Maximum) and (v <> FPosition) then
        begin
          FPosition := v;
          if FGlowPos = -60 then
            FDoGlow := true;
          if Assigned(OnPositionChanged) then
            OnPositionChanged(Self, Position);
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothTrackBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  r: TGPRectF;
  v: Double;
begin
  inherited;
  v := Maximum + 1;
  if not FMouseDownOnSlider then
  begin
    r := GetSliderRect;
    if FDirection = dVertical then
    begin
      if Y < r.Y  then
        v := FPosition + Step
      else if Y > r.Y + r.Height then
        v := FPosition - Step;
    end
    else
    begin
      if X < r.X  then
        v := FPosition - Step
      else if X > r.X + r.Width then
        v := FPosition + Step;
    end;
    if (v >= Minimum) and (v <= Maximum) and (v <> FPosition) then
    begin
      FPosition := v;
      if FGlowPos = -60 then
        FDoGlow := true;
      if Assigned(FOnPositionChanged) then
        FOnPositionChanged(Self, FPosition);
    end;
  end;

  FMouseDownOnSlider := false;
  Cursor := crArrow;
  Changed;
end;

procedure TAdvSmoothTrackBar.Paint;
var
  g: TGPGraphics;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  DrawBackGround(g);
  if ShowProgress then
    DrawProgress(g);
    
  DrawNumbers(g);
  DrawOverlay(g);
  DrawSlider(g);


  g.Free;
end;

procedure TAdvSmoothTrackBar.Resize;
begin
  if FResize then
  begin
    case FDirection of
      dHorizontal:
      begin
        FOldW := Width;
        FOldH := Height;
      end;
      dVertical:
      begin
        FOldW := Height;
        FOldH := Width;
      end;
    end;
  end;
  inherited;
end;

procedure TAdvSmoothTrackBar.SetComponentStyle(AStyle: TTMSStyle);
begin
  ThumbFill.Rounding := 10;
  ThumbFill.BorderColor := clGray;
  ThumbFill.Color := clwhite;
  ThumbFill.ColorTo := clWhite;
  ThumbFill.GradientType := gtForwardDiagonal;
  ThumbFill.OpacityTo := 0;
  
  case AStyle of
    tsOffice2003Blue:
    begin
      Fill.Color := $00FFD2AF;
      Fill.ColorTo := $00FFD2AF;
      Fill.BorderColor := $00C0C0C0;

      ProgressFill.Color := $FCE1CB;
      ProgressFill.ColorTo := $E0A57D;
      ProgressFill.ColorMirror := clNone;
      ProgressFill.ColorMirrorTo := clNone;
      ProgressFill.BorderColor := $962D00;
      ProgressFill.GradientMirrorType := gtVertical;
//      ProgressFill.Color := $94E6FB;
//      ProgressFill.ColorTo := $1595EE;
//      ProgressFill.ColorMirror := clNone;
//      ProgressFill.ColorMirrorTo := clNone;
//      ProgressFill.BorderColor := $962D00;
//      ProgressFill.GradientMirrorType := gtVertical;
    end;
    tsOffice2003Silver:
    begin
      Fill.Color := $00E6D8D8;
      Fill.ColorTo := $00E6D8D8;
      Fill.BorderColor := $00C0C0C0;
      ProgressFill.Color := $ECE2E1;
      ProgressFill.ColorTo := $B39698;
      ProgressFill.ColorMirror := clNone;
      ProgressFill.ColorMirrorTo := clNone;
      ProgressFill.BorderColor := $947C7C;
      ProgressFill.GradientMirrorType := gtVertical;
//        ProgressFill.Color := $94E6FB;
//        ProgressFill.ColorTo := $1595EE;
//        ProgressFill.ColorMirror := clNone;
//        ProgressFill.ColorMirrorTo := clNone;
//        ProgressFill.BorderColor := $947C7C;
//        ProgressFill.GradientMirrorType := gtVertical;
    end;
    tsOffice2003Olive:
    begin
      Fill.Color := $CFF0EA;
      Fill.ColorTo := $CFF0EA;
      Fill.BorderColor := $00C0C0C0;

      ProgressFill.Color := $CFF0EA;
      ProgressFill.ColorTo := $8CC0B1;
      ProgressFill.ColorMirror := clNone;
      ProgressFill.ColorMirrorTo := clNone;
      ProgressFill.BorderColor := $588060;
      ProgressFill.GradientMirrorType := gtVertical;
//        ProgressFill.Color := $94E6FB;
//        ProgressFill.ColorTo := $1595EE;
//        ProgressFill.ColorMirror := clNone;
//        ProgressFill.ColorMirrorTo := clNone;
//        ProgressFill.BorderColor := $588060;
//        ProgressFill.GradientMirrorType := gtVertical;
    end;
    tsOffice2003Classic:
    begin
      Fill.Color := $00F2F2F2;
      Fill.ColorTo := $00F2F2F2;
      Fill.BorderColor := $00C0C0C0;
      ProgressFill.Color := clWhite;
      ProgressFill.ColorTo := $C9D1D5;
      ProgressFill.ColorMirror := clNone;
      ProgressFill.ColorMirrorTo := clNone;
      ProgressFill.BorderColor := $808080;
      ProgressFill.GradientMirrorType := gtVertical;
//        ProgressFill.Color := $B59285;
//        ProgressFill.ColorTo := $B59285;
//        ProgressFill.ColorMirror := clNone;
//        ProgressFill.ColorMirrorTo := clNone;
//        ProgressFill.BorderColor := $962D00;
//        ProgressFill.GradientMirrorType := gtVertical;
    end;
    tsOffice2007Luna:
    begin
      Fill.Color := $00FFD2AF;
      Fill.ColorTo := $00FFD2AF;
      Fill.BorderColor := $00C0C0C0;

      ProgressFill.Color := $FFEFE3;
      ProgressFill.ColorTo := $FFDDC4;
      ProgressFill.ColorMirror := $FFD1AD;
      ProgressFill.ColorMirrorTo := $FFDBC0;
      ProgressFill.BorderColor := $FFD1AD;
      ProgressFill.GradientMirrorType := gtVertical;
//        ProgressFill.Color := $AAD9FF;
//        ProgressFill.ColorTo := $6EBBFF;
//        ProgressFill.ColorMirror := $42AEFE;
//        ProgressFill.ColorMirrorTo := $7AE1FE;
//        ProgressFill.BorderColor := $FFD1AD;//$42AEFE;
//        ProgressFill.GradientMirrorType := gtVertical;
    end;
    tsOffice2007Obsidian:
    begin
      Fill.Color := $5C534C;
      Fill.ColorTo := $5C534C;
      Fill.BorderColor := $00C0C0C0;

      ProgressFill.Color := $F9F8F8;
      ProgressFill.ColorTo := $E4E2DF;
      ProgressFill.ColorMirror := $D1CBC7;
      ProgressFill.ColorMirrorTo := $E2DEDB;
      ProgressFill.BorderColor := clBlack;//$D1CBC7;
      ProgressFill.GradientMirrorType := gtVertical;
//        ProgressFill.Color := $AAD9FF;
//        ProgressFill.ColorTo := $6EBBFF;
//        ProgressFill.ColorMirror := $42AEFE;
//        ProgressFill.ColorMirrorTo := $7AE1FE;
//        ProgressFill.BorderColor := clBlack;//$42AEFE;
//        ProgressFill.GradientMirrorType := gtVertical;
    end;
    tsWindowsXP:
    begin
      Fill.Color := $00B6B6B6;
      Fill.ColorTo := $00B6B6B6;
      Fill.BorderColor := $00C0C0C0;
      ProgressFill.Color := clWhite;
      ProgressFill.ColorTo := clBtnFace;
      ProgressFill.ColorMirror := clNone;
      ProgressFill.ColorMirrorTo := clNone;
      ProgressFill.BorderColor := clBlack;
      ProgressFill.GradientMirrorType := gtVertical;
//        ProgressFill.Color := clInActiveCaption;
//        ProgressFill.ColorTo := clInActiveCaption;
//        ProgressFill.ColorMirror := clNone;
//        ProgressFill.ColorMirrorTo := clNone;
//        ProgressFill.BorderColor := clBlack;
//        ProgressFill.GradientMirrorType := gtVertical;
    end;
    tsWhidbey:
    begin
      Fill.Color := $F5F9FA;
      Fill.ColorTo := $F5F9FA;
      Fill.BorderColor := $00C0C0C0;

      ProgressFill.Color := $F5F9FA;
      ProgressFill.ColorTo := $A8C0C0;
      ProgressFill.ColorMirror := clNone;
      ProgressFill.ColorMirrorTo := clNone;
      ProgressFill.BorderColor := $962D00;
      ProgressFill.GradientMirrorType := gtVertical;
//        ProgressFill.Color := $94E6FB;
//        ProgressFill.ColorTo := $1595EE;
//        ProgressFill.ColorMirror := clNone;
//        ProgressFill.ColorMirrorTo := clNone;
//        ProgressFill.BorderColor := $962D00;
//        ProgressFill.GradientMirrorType := gtVertical;
    end;
    tsCustom: ;
    tsOffice2007Silver:
    begin
      Fill.Color := $00CAC1BA;
      Fill.ColorTo := $00CAC1BA;
      Fill.BorderColor := $00C0C0C0;

      ProgressFill.Color := $FAEEEB;
      ProgressFill.ColorTo := $E5DBD7;
      ProgressFill.ColorMirror := $E2D8D4;
      ProgressFill.ColorMirrorTo := $D1C7C5;
      ProgressFill.BorderColor := clBlack;//$E2D8D4;
      ProgressFill.GradientMirrorType := gtVertical;
//        ProgressFill.Color := $AAD9FF;
//        ProgressFill.ColorTo := $6EBBFF;
//        ProgressFill.ColorMirror := $42AEFE;
//        ProgressFill.ColorMirrorTo := $7AE1FE;
//        ProgressFill.BorderColor := clBlack;//$42AEFE;
//        ProgressFill.GradientMirrorType := gtVertical;
    end;
  end;
end;

procedure TAdvSmoothTrackBar.SetDirection(
  const Value: TAdvSmoothTrackBarDirection);
begin
  FDirection := Value;
  if not FLoaded or (csLoading in ComponentState) then
    Exit;

  FResize := false;
  if FDirection = dHorizontal then
  begin
    Width := FOldW;
    Height := FOldH;
  end
  else
  begin
    Width := FOldH;
    Height := FOldW;
  end;
  FResize := true;
  Changed;
end;

procedure TAdvSmoothTrackBar.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothTrackBar.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetFormat(const Value: String);
begin
  if FFormat <> value then
  begin
    FFormat := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetGlowAnimation(const Value: Boolean);
begin
  if FGlowAnimation <> value then
  begin
    FGlowAnimation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetMaximum(const Value: Double);
begin
  if FMaximum <> value then
  begin
    FMaximum := Value;
    if FMaximum < FPosition then
      FPosition := FMaximum;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetMinimum(const Value: Double);
begin
  if FMinimum <> Value then
  begin
    FMinimum := Value;
    if FMinimum > FPosition then
      FPosition := FMinimum;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetPosition(const Value: Double);
begin
  if (FPosition <> Value) and (Value >= Minimum) and (Value <= Maximum) then
  begin
    FPosition := Value;
    if FGlowPos = -60 then
      FDoGlow := true;
    if Assigned(FOnPositionChanged) then
      FOnPositionChanged(Self, FPosition);
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetProgressFill(const Value: TGDIPFill);
begin
  if FProgressFill <> value then
  begin
    FProgressFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothTrackBar.SetProgressFont(const Value: TFont);
begin
  if FProgressFont <> Value then
  begin
    FProgressFont.Assign(Value);
    Fontchanged(Self);
  end;
end;

procedure TAdvSmoothTrackBar.SetShowProgress(const Value: Boolean);
begin
  if FShowProgress <> value then
  begin
    FShowProgress := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetShowTickMarks(const Value: Boolean);
begin
  if FShowTickMarks <> value then
  begin
    FShowTickMarks := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetShowValues(const Value: Boolean);
begin
  if FShowValues <> Value then
  begin
    FShowValues := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetSnapMargin(const Value: Double);
begin
  if FSnapMargin <> Value then
  begin
    FSnapMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetSnapToTickMarks(const Value: Boolean);
begin
  if FSnapToTickMarks <> Value then
  begin
    FSnapToTickMarks := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetStep(const Value: Double);
begin
  if (FStep <> Value) and (FStep > 0) then
  begin
    FStep := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetThumbFill(const Value: TGDIPFill);
begin
  if FThumbFill <> value then
  begin
    FThumbFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TAdvSmoothTrackBar.setThumbSize(const Value: integer);
begin
  if FThumbSize <> Value then
  begin
    FThumbSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetTickMarkColor(const Value: TColor);
begin
  if FTickMarkColor <> value then
  begin
    FTickMarkColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetTickMarkSize(const Value: integer);
begin
  if FTickMarkSize <> Value then
  begin
    FTickMarkSize := Value;
    Changed;
  end;
end;

procedure TAdvSmoothTrackBar.SetVersion(const Value: string);
begin

end;

procedure TAdvSmoothTrackBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.Result := 0;
end;

end.
