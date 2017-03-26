{*************************************************************************}
{ TAdvSmoothProgressBar component                                         }
{ for Delphi & C++Builder                                                 }
{                                                                         }
{ written by TMS Software                                                 }
{           copyright ©  2009                                             }
{           Email : info@tmssoftware.com                                  }
{           Web : http://www.tmssoftware.com                              }
{                                                                         }
{ The source code is given as is. The author is not responsible           }
{ for any possible damage done due to the use of this code.               }
{ The component can be freely used in any application. The complete       }
{ source code remains property of the author and may not be distributed,  }
{ published, given or sold in any form as such. No parts of the source    }
{ code can be included in any other component or application without      }
{ written authorization of the author.                                    }
{*************************************************************************}
unit AdvSmoothProgressBar;

interface

{$I TMSDEFS.INC}

uses
  Classes, Controls, GDIPFill, Windows, Graphics, AdvSmoothGDIP,
  ExtCtrls, Math, SysUtils, AdvStyleIF, Messages;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 2; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : first release
  // v1.0.0.1 : Fixed : issue with Maximum = Minimum
  // v1.0.1.0 : New: function AnimationInProgress returns true when progress bar is still animating
  // v1.0.1.1 : Fixed : Flicker when animating
  //          : Fixed : Issue with setting ProgressAnimation := false when Animation is busy
  // v1.0.2.0 : New : Property Transparent to hide background

type
  TWinCtrl = class(TWinControl)
  public
    procedure PaintCtrls(DC: HDC; First: TControl);
  end;

  TAdvSmoothProgressBarPositionChanged = procedure(Sender: TObject; Value: Double) of object;

  TAdvSmoothProgressBar = class(TCustomControl, ITMSStyle)
  private
    FPositionTo, FPositionTemp: double;
    FRect: TRect;
    FDesignTime, FDoAnimation, FAnimate: Boolean;
    FGlowCount: integer;
    FGlowPos: Double;
    FAnimationTimer: TTimer;
    FMaximum: Double;
    FAppearance: TGDIPProgress;
    FGlowAnimation: Boolean;
    FOnChange: TNotifyEvent;
    FMinimum: Double;
    FProgressAnimation: Boolean;
    FStep: Double;
    FPosition: Double;
    FOnPositionChanged: TAdvSmoothProgressBarPositionChanged;
    procedure SetAppearance(const Value: TGDIPProgress);
    procedure SetGlowAnimation(const Value: Boolean);
    procedure SetMaximum(const Value: Double);
    procedure SetMinimum(const Value: Double);
    procedure SetProgressAnimation(const Value: Boolean);
    procedure SetStep(const Value: Double);
    procedure SetPosition(const Value: Double);
    function GetVersion: String;
    procedure SetVersion(const Value: String);
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure AppearanceChanged(Sender: TObject);
    procedure AnimateProgress(Sender: TObject);
    procedure DrawGlow(g: TGPGRaphics; r: TRect);
    procedure SetStyle(AStyle: TTMSStyle; Selected: Boolean);
    function IsProgressAnimation: Boolean;
    function IsGlowAnimation: Boolean;
    function GetVersionNr: integer;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;    
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure Next; overload;
    procedure Previous; overload;
    procedure Next(AStep: Double); overload;
    procedure Previous(AStep: Double); overload;
    procedure GoToValue(AValue: Double);
    procedure GoToEnd;
    procedure GoToStart;
    procedure SetComponentStyle(AStyle: TTMSStyle);
    function AnimationInProgress: Boolean;
  published
    property Step: Double read FStep write SetStep;
    property Minimum: Double read FMinimum write SetMinimum;
    property Maximum: Double read FMaximum write SetMaximum;
    property Position: Double read FPosition write SetPosition;
    property GlowAnimation: Boolean read FGlowAnimation write SetGlowAnimation default true;
    property ProgressAnimation: Boolean read FProgressAnimation write SetProgressAnimation default true;
    property Appearance: TGDIPProgress read FAppearance write SetAppearance;
    property Version: String read GetVersion write SetVersion;
    
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnPositionChanged: TAdvSmoothProgressBarPositionChanged read FOnPositionChanged write FOnPositionChanged;

    property Align;
    property Anchors;
    property Constraints;
    property PopupMenu;
    property ParentShowHint;
    property ShowHint;
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
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;   
    property Visible;
    property Hint;
  end;

implementation

{ TAdvSmoothProgressBar }

function AnimateDouble(var Start, Stop: Double; Delta: Double; Margin: Double): Boolean;
begin
  Result := true;
  if (Start > Stop - Margin) and (Start < Stop + Margin) then
  begin
    Start := Stop;
    Result := false;
  end
  else
  begin
    Delta := Max(Margin, Delta);
    if Start < Stop then
      Start := Start + Delta
    else
      Start := Start - Delta;
  end;
end;

procedure TAdvSmoothProgressBar.AnimateProgress(Sender: TObject);
var
  d: Double;
  pos: Double;
begin
  if (IsProgressAnimation and FAnimate) or (Abs(FPositionTo - FPositionTemp) > 0) then
  begin
    d := Abs(FPositionTo - FPositionTemp) / 15;
    pos := FPositionTemp;
    FDoAnimation := AnimateDouble(pos, FPositionTo, d, 0.000001);
    if FDoAnimation then
    begin
      FPosition := Pos;    
      FPositionTemp := pos;
      if Assigned(FOnPositionChanged) then
        FOnPositionChanged(Self, FPosition);
      Changed;
    end
    else
    begin
      FAnimate := false;
      FPosition := FPositionTo;
      FPositionTemp := FPositionTo;
      if Assigned(FOnPositionChanged) then
        FOnPositionChanged(Self, FPosition);
      Changed;
    end;
  end;

  if (Position > Minimum) and IsGlowAnimation then
  begin
    if FGlowCount >= 1500 then
      FGlowPos := FGlowPos + 3;

    if FGlowPos > Appearance.CalculateProgressRectangle(FRect, Minimum, Maximum, Position).Width then
    begin
      FGlowCount := 0;
      FGlowPos := -60;
    end
    else
      FGlowCount := FGlowCount + 10;

    Changed;
  end;
end;

function TAdvSmoothProgressBar.AnimationInProgress: Boolean;
begin
 Result := IsProgressAnimation and not (Abs(FPositionTemp - FPositionTo) < 1e-3);
end;

procedure TAdvSmoothProgressBar.AppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothProgressBar.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothProgressBar) then
  begin
    FStep := (Source as TAdvSmoothProgressBar).Step;
    FMinimum := (Source as TAdvSmoothProgressBar).Minimum;
    FMaximum := (Source as TAdvSmoothProgressBar).Maximum;
    FPosition := (Source as TAdvSmoothProgressBar).Position;
    FGlowAnimation := (Source as TAdvSmoothProgressBar).GlowAnimation;
    FProgressAnimation := (Source as TAdvSmoothProgressBar).ProgressAnimation;
    FAppearance.Assign((Source as TAdvSmoothProgressBar).Appearance);
    Changed;
  end;
end;

procedure TAdvSmoothProgressBar.Changed;
begin
  Invalidate;
end;

constructor TAdvSmoothProgressBar.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := true;
  FStep := 10;
  FMinimum := 0;
  FMaximum := 100;
  FPositionTo := 0;
  FPositionTemp := 0;
  FPosition := 0;
  FGlowAnimation := true;
  FProgressAnimation := true;
  FGlowCount := 3000; //3sec
  FGlowPos := -40;
  FAnimationTimer := TTimer.Create(Self);
  FAnimationTimer.Interval := 10;
  FAnimationTimer.Enabled := true;
  FAnimationTimer.OnTimer := AnimateProgress;
  FAppearance := TGDIPProgress.Create;
  FAppearance.OnChange := AppearanceChanged;

  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  if FDesignTime then
    SetComponentStyle(tsOffice2007Luna);

  Height := 17;
  Width := 150;
end;

destructor TAdvSmoothProgressBar.Destroy;
begin
  FAppearance.Free;
  FAnimationTimer.Free;
  inherited;
end;

procedure TAdvSmoothProgressBar.DrawGlow(g: TGPGRaphics; r: TRect);
var
  b: TGPLinearGradientBrush;
  rr, lr, o: TGPRectF;
  rgn: TGPRegion;
begin
  rgn := TGPRegion.Create(Appearance.CalculateProgressRectangle(r, Minimum, Maximum, Position));
  g.SetClip(rgn);
  o := Appearance.GetInsideRectF(r);
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

procedure TAdvSmoothProgressBar.FillChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothProgressBar.IsGlowAnimation: Boolean;
begin
  Result := false;
  if not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    Result := GlowAnimation;
end;

function TAdvSmoothProgressBar.IsProgressAnimation: Boolean;
begin
  Result := false;
  if not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
    Result := ProgressAnimation;
end;

function TAdvSmoothProgressBar.GetVersion: String;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvSmoothProgressBar.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvSmoothProgressBar.GoToEnd;
begin
  Position := Maximum;
end;

procedure TAdvSmoothProgressBar.GoToValue(AValue: Double);
begin
  Position := AValue;
end;

procedure TAdvSmoothProgressBar.GoToStart;
begin
  Position := Minimum;
end;

procedure TAdvSmoothProgressBar.Next(AStep: Double);
begin
  Position := Position + AStep;
end;

procedure TAdvSmoothProgressBar.Next;
begin
  Position := Position + Step;
end;

procedure TAdvSmoothProgressBar.Paint;
var
  g: TGPGraphics;
  r: TRect;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

  r := Rect(0, 0, Width, Height);
  Frect := r;
  Appearance.Draw(g, r, Minimum, Maximum, Position);
  if IsGlowAnimation and (Position > 0) then
    DrawGlow(g, r);


  g.Free;
end;

procedure TAdvSmoothProgressBar.Previous(AStep: Double);
begin
  Position := Position - AStep;
end;

procedure TAdvSmoothProgressBar.Previous;
begin
  Position := Position - Step;
end;

procedure TAdvSmoothProgressBar.Resize;
begin
  inherited;
  Changed;
end;

procedure TAdvSmoothProgressBar.SetAppearance(const Value: TGDIPProgress);
begin
  if FAppearance <> value then
  begin
    FAppearance.Assign(Value);
    AppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothProgressBar.SetComponentStyle(AStyle: TTMSStyle);
begin
  SetStyle(AStyle, false);
end;

procedure TAdvSmoothProgressBar.SetGlowAnimation(const Value: Boolean);
begin
  if FGlowAnimation <> value then
  begin
    FGlowAnimation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothProgressBar.SetMaximum(const Value: Double);
begin
  if FMaximum <> value then
  begin
    FMaximum := Value;
    if FMaximum < FPosition then
    begin
      if IsProgressAnimation then
        FPositionTo := FMaximum
      else
      begin
        FPosition := FMaximum;
        FPositionTemp := FMaximum;
        FPositionTo := FMaximum;
      end;
    end;

    Changed;
  end;
end;

procedure TAdvSmoothProgressBar.SetMinimum(const Value: Double);
begin
  if FMinimum <> value then
  begin
    FMinimum := Value;
    if FMinimum > FPosition then
    begin
      if IsProgressAnimation then
        FPositionTo := FMinimum
      else
      begin
        FPosition := FMinimum;
        FPositionTemp := FMinimum;
        FPositionTo := FMinimum;
      end;
    end;

    Changed;
  end;
end;

procedure TAdvSmoothProgressBar.SetPosition(const Value: Double);
begin
  FPositionTo := Min(Max(Minimum, Value), Maximum);
  if not IsProgressAnimation then
  begin
    FPosition := FPositionTo;
    FPositionTemp := FPositionTo;
    if Assigned(FOnPositionChanged) then
      FOnPositionChanged(Self, FPosition);

    Changed;
  end
  else
    FAnimate := true;
end;

procedure TAdvSmoothProgressBar.SetProgressAnimation(const Value: Boolean);
begin
  if FProgressAnimation <> value then
  begin
    FProgressAnimation := Value;
    Changed;
  end;
  if FProgressAnimation = false then
    SetPosition(FPositionTo);
end;

procedure TAdvSmoothProgressBar.SetStep(const Value: Double);
begin
  if FStep <> value then
  begin
    FStep := Value;
    Changed;
  end;
end;

procedure TAdvSmoothProgressBar.SetStyle(AStyle: TTMSStyle; Selected: Boolean);
begin
  with Appearance do
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

procedure TAdvSmoothProgressBar.SetVersion(const Value: String);
begin

end;

procedure TAdvSmoothProgressBar.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  message.Result := 1;
end;

procedure TAdvSmoothProgressBar.WMPaint(var Message: TWMPaint);
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

{ TWinCtrl }

procedure TWinCtrl.PaintCtrls(DC: HDC; First: TControl);
begin
  PaintControls(DC, First);
end;

end.
