{**************************************************************************}
{ TAdvSmoothButton component                                               }
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

unit AdvSmoothButton;

interface

{$I TMSDEFS.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Math, AdvSmoothGDIP, AdvStyleIF, GDIPFill, Forms, ExtCtrls;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 6; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 1; // Build nr.

  // version history
  // v1.0.0.0 : first release
  // v1.5.0.0 : New: Status Indicator
  //          : Improved: GDI+ Drawing in seperate GDIPFill
  // v1.5.0.1 : Fixed : issue with wordwrapped caption
  // v1.6.0.0 : New : Focus indication
  //          : New : Keyboard support to handle click with SpaceBar and Enter keys
  //          : New : HotKey Support
  // v1.6.0.1 : Fixed : Picture and Text position
  //          : Fixed : Issue with status caption = ''
  // v1.6.0.2 : Improved : Button color gray when Enabled = false

type
  TAdvSmoothButton = class;

  TAdvSmoothButtonStatus = class(TPersistent)
  private
    FOwner: TAdvSmoothButton;
    FOffsetTop: integer;
    FOffsetLeft: integer;
    FVisible: Boolean;
    FCaption: String;
    FAppearance: TGDIPStatus;
    FOnChange: TNotifyEvent;
    procedure SetCaption(const Value: String);
    procedure SetOffsetLeft(const Value: integer);
    procedure SetOffsetTop(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetAppearance(const Value: TGDIPStatus);
  protected
    procedure Changed;
    procedure AppearanceChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothButton);
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

  TAdvSmoothButton = class(TCustomControl, ITMSStyle)
  private
    FCache: TGPBitmap;
    FValidCache: Boolean;
    FUpTimer: TTimer;
    FFocused: Boolean;
    FDesignTime: Boolean;
    FAppearance: TGDIPButton;
    FColor: TColor;
    FDown: boolean;
    FCaption: string;
    FPicture: TAdvGDIPPicture;
    FBevel: boolean;
    FShadow: boolean;
    FBevelColor: TColor;
    FButtonStatus: TAdvSmoothButtonStatus;
    FVerticalSpacing: integer;
    FHorizontalSpacing: integer;
    FEnabled: Boolean;
    procedure SetCaption(const Value: string);
    procedure SetColor(const Value: TColor);
    procedure SetPicture(const Value: TAdvGDIPPicture);
    procedure SetBevel(const Value: boolean);
    procedure SetShadow(const Value: boolean);
    procedure SetBevelColor(const Value: TColor);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;    
    procedure SetButtonStatus(const Value: TAdvSmoothButtonStatus);
    procedure SetHorizontalSpacing(const Value: integer);
    procedure SetVerticalSpacing(const Value: integer);
    procedure SetAppearance(const Value: TGDIPButton);
  protected
    procedure SetEnabled(Value: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;      
    procedure Paint; override;
    procedure Resize; override;
    procedure Changed;
    procedure AppearanceChanged(Sender: TObject);
    procedure PictureChanged(Sender: TObject);
    procedure StatusChanged(Sender: TObject);    
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure UpTime(Sender: TObject);
    function GetVersionNr: integer;
    procedure DoExit; override;
    procedure DoEnter; override;
    procedure DoClick; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetComponentStyle(AStyle: TTMSStyle);
  published
    property Action;
    property Align;
    property Anchors;
    property Appearance: TGDIPButton read FAppearance write SetAppearance;
    property Status: TAdvSmoothButtonStatus read FButtonStatus write SetButtonStatus;
    property Bevel: boolean read FBevel write SetBevel default true;
    property BevelColor: TColor read FBevelColor write SetBevelColor default clWhite;
    property Constraints;
    property Caption: string read FCaption write SetCaption;
    property Color: TColor read FColor write SetColor default clGray;
    property Picture: TAdvGDIPPicture read FPicture write SetPicture;
    property PopupMenu;
    property Shadow: boolean read FShadow write SetShadow default false;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Enabled: Boolean read FEnabled write SetEnabled default true;
    property HorizontalSpacing: integer read FHorizontalSpacing write SetHorizontalSpacing default 5;
    property VerticalSpacing: integer read FVerticalSpacing write SetVerticalSpacing default 5;
    property Version: string read GetVersion write SetVersion;

    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnClick;
    property OnDblClick;
    property OnContextPopup;
    {$IFDEF DELPHI2006_LVL}
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnExit;
    property OnEnter;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;


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

procedure DrawFocus(g: TGPGraphics; r: TGPRectF; rn: Integer);
var
  pathfocus: TGPGraphicsPath;
  pfocus: TGPPen;
begin
  pathfocus := CreateRoundRectangle(r, rn, rtBoth, false);
  g.SetSmoothingMode(SmoothingModeDefault);
  pfocus := TGPPen.Create(MakeColor(255, clBlack), 1);
  pfocus.SetDashStyle(DashStyleDot);
  g.DrawPath(pfocus, pathfocus);
  pfocus.Free;
  pathfocus.Free;
end;

{ TAdvSmoothButton }

type
  TWinCtrl = class(TWinControl)
  public
    procedure PaintCtrls(DC: HDC; First: TControl);
  end;

procedure TAdvSmoothButton.AppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothButton.Changed;
begin
  FValidCache := false;
  Invalidate;
end;

procedure TAdvSmoothButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus and TabStop then
    begin
      FDown := true;
      Repaint;
      DoClick;
      Sleep(150);
      FDown := false;
      repaint;
      Result := 1;      
    end
    else
      inherited;
end;

constructor TAdvSmoothButton.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := true;
  FPicture := TAdvGDIPPicture.Create;
  FPicture.OnChange := PictureChanged;
  FColor := clGray;
  FBevel := true;
  FBevelColor := clWhite;
  FVerticalSpacing := 5;
  FHorizontalSpacing := 5;
  FUpTimer := TTimer.Create(Self);
  FUpTimer.Interval := 1;
  FUpTimer.Enabled := false;
  FUpTimer.OnTimer := UpTime;
  FAppearance := TGDIPButton.Create;
  FAppearance.OnChange := AppearanceChanged;
  Width := 75;
  Height := 30;
  FEnabled := true;
  {$IFDEF DELPHI5_LVL}
  FCache := TGPBitmap.Create(Width, Height);
  {$ELSE}
  FCache := TGPBitmap.Create(Width, Height, PixelFormat32bppARGB);
  {$ENDIF}
  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));
  FButtonStatus := TAdvSmoothButtonStatus.Create(Self);
  FButtonStatus.OnChange := StatusChanged;    
end;

destructor TAdvSmoothButton.Destroy;
begin
  FPicture.Free;
  FButtonStatus.Free;
  FAppearance.Free;
  FUpTimer.Free;
  if FCache <> nil then
    FCache.Free;
  inherited;
end;

procedure TAdvSmoothButton.DoClick;
begin
  if Assigned(OnClick) then
    OnClick(Self);
end;

procedure TAdvSmoothButton.DoEnter;
begin
  inherited;
  FFocused := true;
  changed;
end;

procedure TAdvSmoothButton.DoExit;
begin
  inherited;
  FFocused := false;
  Changed;
end;

function TAdvSmoothButton.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvSmoothButton.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvSmoothButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not TabStop then
    Exit;
  case Key of
    VK_SPACE, VK_RETURN: DoClick;
  end;
end;

procedure TAdvSmoothButton.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TAdvSmoothButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Enabled then
  begin
    FDown := true;
    SetFocus;
    Changed;
  end;
end;

procedure TAdvSmoothButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if Enabled then
  begin
    FDown := false;
    Changed;
  end;
end;

procedure TAdvSmoothButton.Paint;
var
  g: TGPGraphics;
  x, y, hs, vs: integer;
  c: TColor;
begin
  if not FValidCache then
  begin
    g := TGPGraphics.Create(FCache);
    g.SetSmoothingMode(SmoothingModeAntiAlias);
    g.SetTextRenderingHint(TextRenderingHintAntiAlias);
    g.Clear(MakeColor(0, clWhite));

    hs := 0;
    vs := 0;
    if Status.Visible and ((Status.Caption <> '') or not Status.Appearance.Fill.Picture.Empty) then
    begin
      vs := VerticalSpacing;
      hs := HorizontalSpacing;
    end;

    if Enabled then
      c := Color
    else
      c := RGB(80, 80, 80);

    FAppearance.Draw(g, Caption, 0, 0, Width, Height, vs, hs, c, clNone, BevelColor,
      Shadow, FDown, Bevel, false, false, rtBoth, Picture, 0, 0, true);

    if TabStop and FFocused then
      DrawFocus(g, MakeRect(0,0, Width - 1, Height - 1), 8);

    if Status.Visible and ((Status.Caption <> '') or not Status.Appearance.Fill.Picture.Empty) then
    begin
      with Status do
      begin
        Appearance.CalculateSize(g, Status.Caption);
        x := Self.Width + FButtonStatus.OffsetLeft - Status.Appearance.GetWidth;
        y := Status.OffsetTop;
        Appearance.Draw(g, Status.OffsetLeft + x, y, 0, 0, true,Status.Caption);
      end;
    end;

    FValidCache := true;

    g.Free;
  end;

  if FValidCache then
  begin
    g := TGPGraphics.Create(Canvas.Handle);
    g.DrawImage(FCache, 0, 0);
    g.Free;
  end;
end;

procedure TAdvSmoothButton.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothButton.Resize;
begin
  inherited;
  if Assigned(FCache) then
    FCache.Free;

  FCache := TGPBitmap.Create(Width, Height, PixelFormat32bppARGB);
  FValidCache := false;
end;

procedure TAdvSmoothButton.SetAppearance(const Value: TGDIPButton);
begin
  if FAppearance <> value then
  begin
    FAppearance.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothButton.SetBevel(const Value: boolean);
begin
  if (FBevel <> Value) then
  begin
    FBevel := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButton.SetBevelColor(const Value: TColor);
begin
  if (FBevelColor <> Value) then
  begin
    FBevelColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButton.SetButtonStatus(const Value: TAdvSmoothButtonStatus);
begin
  if FButtonStatus <> value then
  begin
    FButtonStatus.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothButton.SetCaption(const Value: string);
begin
  if (FCaption <> Value) then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButton.SetColor(const Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButton.SetComponentStyle(AStyle: TTMSStyle);
begin
  // TODO : do color settings here
  case astyle of
    tsOffice2003Blue:
      Color := $00E3B28D;
    tsOffice2003Silver:
      Color := $00927476;
    tsOffice2003Olive:
      Color := $447A63; //08CC0B1; 006B7760;
    tsOffice2003Classic:
      Color := $00C9D1D5;
    tsOffice2007Luna:
      Color := $00FDEADA;
    tsOffice2007Obsidian:
      Color := $006E6E6D;
    tsWindowsXP:
      Color := $B9D8DC;
    tsWhidbey:
      Color := $00828F92;
    tsCustom: ;
    tsOffice2007Silver:
      Color := $00E7DCD5;
  end;
end;

procedure TAdvSmoothButton.SetEnabled(Value: Boolean);
begin
  inherited;
  if FEnabled <> value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButton.SetHorizontalSpacing(const Value: integer);
begin
  if FHorizontalSpacing <> value then
  begin
    FHorizontalSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButton.SetPicture(const Value: TAdvGDIPPicture);
begin
  FPicture.Assign(Value);
end;

procedure TAdvSmoothButton.SetShadow(const Value: boolean);
begin
  if (FShadow <> Value) then
  begin
    FShadow := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButton.SetVersion(const Value: string);
begin
end;

procedure TAdvSmoothButton.SetVerticalSpacing(const Value: integer);
begin
  if FVerticalSpacing <> value then
  begin
    FVerticalSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButton.StatusChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothButton.UpTime(Sender: TObject);
begin
//  if FDoDown then
//  begin
//    Inc(
//  end;
end;

procedure TAdvSmoothButton.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TAdvSmoothButton.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.Result := 0;
end;

procedure TAdvSmoothButton.WMPaint(var Message: TWMPaint);
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

{ TAdvSmoothButtonStatus }


procedure TAdvSmoothButtonStatus.AppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothButtonStatus.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothButtonStatus) then
  begin
    FAppearance.Assign((Source as TAdvSmoothButtonStatus).Appearance);
    FOffsetTop := (Source as TAdvSmoothButtonStatus).OffsetTop;
    FOffsetLeft := (Source as TAdvSmoothButtonStatus).OffsetLeft;
    FVisible := (Source as TAdvSmoothButtonStatus).Visible;
    FCaption := (Source as TAdvSmoothButtonStatus).Caption;
  end;
end;

procedure TAdvSmoothButtonStatus.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothButtonStatus.Create(AOwner: TAdvSmoothButton);
begin
  FOwner := AOwner;
  FOffsetTop := 0;
  FOffsetLeft := 0;
  FVisible := False;
  FAppearance := TGDIPStatus.Create;
  FAppearance.OnChange := AppearanceChanged;
  if FOwner.FDesigntime then
  begin
    FCaption := '0';
    FAppearance.Fill.Color := clRed;
    FAppearance.Fill.GradientType := gtSolid;
    FAppearance.Fill.BorderColor := clGray;
    FAppearance.Font.Color := clWhite;
  end;
end;

destructor TAdvSmoothButtonStatus.Destroy;
begin
  FAppearance.Free;
  inherited;
end;

procedure TAdvSmoothButtonStatus.SetAppearance(const Value: TGDIPStatus);
begin
  if FAppearance <> value then
  begin
    FAppearance.Assign(Value);
    AppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothButtonStatus.SetCaption(const Value: String);
begin
  if FCaption <> value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButtonStatus.SetOffsetLeft(const Value: integer);
begin
  if FOffsetLeft <> value then
  begin
    FOffsetLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButtonStatus.SetOffsetTop(const Value: integer);
begin
  if FOffsetTop <> value then
  begin
    FOffsetTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothButtonStatus.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

end.
