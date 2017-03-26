{**************************************************************************}
{ TAdvSmoothToggleButton Component                                         }
{ for Delphi & C++Builder                                                  }
{                                                                          }
{ written by TMS Software                                                  }
{            copyright © 2009                                              }
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

unit AdvSmoothToggleButton;

interface

uses
  Windows, Classes, Controls, Graphics, AdvSmoothGDIP, GDIPFill,
  SysUtils, Math, Menus, Messages, AdvStyleIF, Forms;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 3; // Build nr.

  // v1.0.0.0 : First Release
  // v1.0.0.1 : Improved: Bevel drawing when bevelwidth < 4
  // v1.1.0.0 : New : Property GroupIndex to create radiogroup behaviour
  //          : New : Focus indication
  //          : New : HotKey Support
  // v1.1.0.1 : Fixed : Issue with status caption = ''
  // v1.1.0.2 : Fixed : Disable Onclick event when button is disabled
  // v1.1.0.3 : Fixed : issue with getting Down state from OnClick event on double clicks 

type
  TAdvSmoothToggleButton = class;

  TAdvSmoothToggleButtonDropDownWindow = class(THintWindow)
  private
    FControl: TWinControl;
    FHideOnDeActivate: Boolean;
    procedure WMNCButtonDown(var Message: TMessage); message WM_NCLBUTTONDOWN;
    procedure WMActivate(var Message: TMessage); message WM_ACTIVATE;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    property HideOnDeActivate: Boolean read FHideOnDeActivate write FHideOnDeActivate;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BorderWidth;
    property Control: TWinControl read FControl write FControl;
  end;

  TAdvSmoothToggleButtonStatus = class(TPersistent)
  private
    FOwner: TAdvSmoothToggleButton;
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
    constructor Create(AOwner: TAdvSmoothToggleButton);
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

  TAdvSmoothToggleButtonState = (bsDown, bsUp);

  TAdvSmoothToggleButton = class(TCustomControl, ITMSStyle)
  private
    FFocused, FDesignTime: Boolean;
    FDroppedDown: Boolean;
    FState: TAdvSmoothToggleButtonState;
    FColor: TColor;
    FColorDown: TColor;
    FColorDisabled: TColor;
    FBorderColor: TColor;
    FPicture: TAdvGDIPPicture;
    FBevelColorDisabled: TColor;
    FBevelWidth: integer;
    FBevelColor: TColor;
    FDown: Boolean;
    FPictureDown: TAdvGDIPPicture;
    FAutoToggle: Boolean;
    FDropDownButton: Boolean;
    FPictureDisabled: TAdvGDIPPicture;
    FAppearance: TGDIPButton;
    FCaption: string;
    FBevelColorDown: TColor;
    FEnabled: Boolean;
    FBorderInnerColor: TColor;
    FDropDownMenu: TPopupMenu;
    FOnDropDown: TNotifyEvent;
    FDropDownArrowColor: TColor;
    FVerticalSpacing: integer;
    FHorizontalSpacing: integer;
    FStatus: TAdvSmoothToggleButtonStatus;
    FDropDownControl: TWinControl;
    FDropDownForm: TAdvSmoothToggleButtonDropDownWindow;
    FDropDownRounding: integer;
    FGroupIndex: integer;
    procedure SetColor(const Value: TColor);
    procedure SetColorDown(const Value: TColor);
    procedure SetColorDisabled(const Value: TColor);
    procedure SetAutoToggle(const Value: Boolean);
    procedure SetBevelColor(const Value: TColor);
    procedure SetBevelColorDisabled(const Value: TColor);
    procedure SetBevelColorDown(const Value: TColor);
    procedure SetBevelWidth(const Value: integer);
    procedure SetBorderColor(const Value: TColor);
    procedure SetDown(const Value: Boolean);
    procedure SetDropDownButton(const Value: Boolean);
    procedure SetPicture(const Value: TAdvGDIPPicture);
    procedure SetPictureDisabled(const Value: TAdvGDIPPicture);
    procedure SetPictureDown(const Value: TAdvGDIPPicture);
    function GetVersion: string;
    procedure SetAppearance(const Value: TGDIPButton);
    procedure SetCaption(const Value: string);
    procedure SetVersion(const Value: string);
    procedure SetBorderInnerColor(const Value: TColor);
    procedure SetDropDownArrowColor(const Value: TColor);
    procedure SetHorizontalSpacing(const Value: integer);
    procedure SetVerticalSpacing(const Value: integer);
    procedure SetStatus(const Value: TAdvSmoothToggleButtonStatus);
    function GetDropDown: boolean;
    procedure SetDropDown(const Value: boolean);
    procedure CMCancelMode(var Message: TMessage); message CM_CANCELMODE;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;        
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMLButtonUp(var Msg: TWMMouse); message WM_LBUTTONUP;
    procedure WMLButtonDown(var Msg: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;    
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure SetDropDownControl(const Value: TWinControl);
    procedure SetDropDownRounding(const Value: integer);
    procedure SetGroupIndex(const Value: integer);
  protected
    procedure SetEnabled(Value: Boolean); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;  
    procedure Changed;
    procedure PictureChanged(Sender: TObject);
    procedure AppearanceChanged(Sender: TObject);
    procedure StatusChanged(Sender: TObject);
    function GetVersionNr: integer;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure ShowDropDown;
    procedure HideDropDown;
    function GetButtonRect: TRect;
    procedure DoClick; virtual;
    procedure DoExit; override;
    procedure DoEnter; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Paint; override;
    procedure Resize; override;
    property DroppedDown: boolean read GetDropDown write SetDropDown;
    property DropDownRounding: integer read FDropDownRounding write SetDropDownRounding default 0;
    procedure SetComponentStyle(AStyle: TTMSStyle);
  published
    property Color: TColor read FColor write SetColor default clSilver;
    property ColorDisabled: TColor read FColorDisabled write SetColorDisabled default clGray;
    property ColorDown: TColor read FColorDown write SetColorDown default clNone;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clSilver;
    property BorderInnerColor: TColor read FBorderInnerColor write SetBorderInnerColor default clSilver;
    property BevelWidth: integer read FBevelWidth write SetBevelWidth default 6;
    property BevelColor: TColor read FBevelColor write SetBevelColor default clWhite;
    property BevelColorDisabled: TColor read FBevelColorDisabled write SetBevelColorDisabled default clGray;
    property BevelColorDown: TColor read FBevelColorDown write SetBevelColorDown default clWhite;
    property DropDownButton: Boolean read FDropDownButton write SetDropDownButton default false;
    property DropDownArrowColor: TColor read FDropDownArrowColor write SetDropDownArrowColor default clBlack;
    property DropDownMenu: TPopupMenu read FDropDownMenu write FDropDownMenu;
    property DropDownControl: TWinControl read FDropDownControl write SetDropDownControl;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property Down: Boolean read FDown write SetDown default false;
    property AutoToggle: Boolean read FAutoToggle write SetAutoToggle default true;
    property Picture: TAdvGDIPPicture read FPicture write SetPicture;
    property PictureDisabled: TAdvGDIPPicture read FPictureDisabled write SetPictureDisabled;
    property PictureDown: TAdvGDIPPicture read FPictureDown write SetPictureDown;
    property Enabled;
    property Appearance: TGDIPButton read FAppearance write SetAppearance;
    property VerticalSpacing: integer read FVerticalSpacing write SetVerticalSpacing default 5;
    property HorizontalSpacing: integer read FHorizontalSpacing write SetHorizontalSpacing default 5;
    property Caption: string read FCaption write SetCaption;
    property Version: string read GetVersion write SetVersion;
    property Status: TAdvSmoothToggleButtonStatus read FStatus write SetStatus;
    property GroupIndex: integer read FGroupIndex write SetGroupIndex default 0;

    property Action;
    property Align;
    property Anchors;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnDblClick;
    property OnContextPopup;
    property OnClick;
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

type
  TWinCtrl = class(TWinControl)
  public
    procedure PaintCtrls(DC: HDC; First: TControl);
  end;

{ TAdvSmoothToggleButton }

procedure TAdvSmoothToggleButton.AppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothToggleButton.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothToggleButton then
  begin
    FColor := (Source as TAdvSmoothToggleButton).Color;
    FColorDown := (Source as TAdvSmoothToggleButton).ColorDown;
    FColorDisabled := (Source as TAdvSmoothToggleButton).ColorDisabled;
    FBorderColor := (Source as TAdvSmoothToggleButton).BorderColor;
    FBevelWidth := (Source as TAdvSmoothToggleButton).BevelWidth;
    FBevelColor := (Source as TAdvSmoothToggleButton).BevelColor;
    FBevelColorDown := (Source as TAdvSmoothToggleButton).BevelColorDown;
    FBevelColorDisabled := (Source as TAdvSmoothToggleButton).BevelColorDisabled;
    FDropDownButton := (Source as TAdvSmoothToggleButton).DropDownButton;
    FDown := (Source as TAdvSmoothToggleButton).Down;
    FAutoToggle := (Source as TAdvSmoothToggleButton).AutoToggle;
    FPicture.Assign((Source as TAdvSmoothToggleButton).Picture);
    FPictureDisabled.Assign((Source as TAdvSmoothToggleButton).PictureDisabled);
    FPictureDown.Assign((Source as TAdvSmoothToggleButton).PictureDown);
    FAppearance.Assign((Source as TAdvSmoothToggleButton).Appearance);
    FCaption := (Source as TAdvSmoothToggleButton).Caption;
    FGroupIndex := (Source as TAdvSmoothToggleButton).GroupIndex;
    FBorderInnerColor := (Source as TAdvSmoothToggleButton).BorderInnerColor;
    FStatus.Assign((Source as TAdvSmoothToggleButton).Status);
    FEnabled := (Source as TAdvSmoothToggleButton).Enabled;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.Changed;
begin
  Invalidate;
end;

procedure TAdvSmoothToggleButton.CMButtonPressed(var Message: TMessage);
var
  Sender: TAdvSmoothToggleButton;
begin
  if Message.WParam = FGroupIndex then
  begin
    Sender := TAdvSmoothToggleButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;
        FState := bsUp;
        Invalidate;
      end;
    end;
  end;
end;

procedure TAdvSmoothToggleButton.CMCancelMode(var Message: TMessage);
begin
  inherited;
  if FDropDownForm.Visible then
    HideDropDown;
end;

procedure TAdvSmoothToggleButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      FDown := not FDown;
      Invalidate;
      DoClick;
      Result := 1;
    end
    else
      inherited;
end;

constructor TAdvSmoothToggleButton.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csDoubleClicks];
  
  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));
  DoubleBuffered := true;
  FAppearance := TGDIPButton.Create;
  FAppearance.OnChange := AppearanceChanged;
  FPicture := TAdvGDIPPicture.Create;
  FPicture.OnChange := PictureChanged;
  FPictureDown := TAdvGDIPPicture.Create;
  FPictureDown.OnChange := PictureChanged;
  FPictureDisabled := TAdvGDIPPicture.Create;
  FPictureDisabled.OnChange := PictureChanged;
  FColor := clSilver;
  FColorDisabled := clGray;
  FColorDown := clNone;
  FBorderColor := clSilver;
  FBevelWidth := 6;
  FBevelColor := clWhite;
  FBevelColorDisabled := clGray;
  FBevelColorDown := clWhite;
  FDropDownButton := false;
  FDown := False;
  FAutoToggle := true;
  FEnabled := true;
  FState := bsUp;
  FBorderInnerColor := clSilver;
  FHorizontalSpacing := 5;
  FVerticalSpacing := 5;
  FStatus := TAdvSmoothToggleButtonStatus.Create(Self);
  FStatus.OnChange := StatusChanged;
  FDropDownRounding := 0;
  FGroupIndex := 0;
  FEnabled := true;

  if not FDesignTime then
  begin
    FDropDownForm := TAdvSmoothToggleButtonDropDownWindow.Create(Self);
    FDropDownForm.Visible := False;
    FDropDownForm.Parent := Self;
    FDropDownForm.BorderWidth := 0;
    FDropDownForm.Color := clWhite;
  end;
end;

destructor TAdvSmoothToggleButton.Destroy;
begin
  FAppearance.Free;
  FPicture.Free;
  FPictureDown.Free;
  FPictureDisabled.Free;
  FStatus.Free;
  if not (csDesigning in ComponentState) then
    FDropDownForm.Free;
  inherited;
end;

procedure TAdvSmoothToggleButton.DoClick;
begin
  if Assigned(OnClick) and Enabled then
    OnClick(Self);
end;

procedure TAdvSmoothToggleButton.DoEnter;
begin
  inherited;
  FFocused := true;
  Changed;
end;

procedure TAdvSmoothToggleButton.DoExit;
begin
  inherited;
  FFocused := false;
  Changed;
end;

function TAdvSmoothToggleButton.GetButtonRect: TRect;
begin
  Result := ClientRect;
end;

function TAdvSmoothToggleButton.GetDropDown: boolean;
begin
  Result := not (csDesigning in ComponentState) and FDropDownForm.Visible;
end;

function TAdvSmoothToggleButton.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvSmoothToggleButton.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvSmoothToggleButton.HideDropDown;
begin
  FDropDownForm.Visible := false;
  FDroppedDown := false;
  Invalidate;
end;

procedure TAdvSmoothToggleButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not TabStop then
    Exit;
  case Key of
    VK_SPACE, VK_RETURN: DoClick;
  end;
end;

procedure TAdvSmoothToggleButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Enabled then
  begin
    if AutoToggle then
    begin
      if FState = bsUp then
      begin
        FState := bsDown;
        FDown := true;
      end
      else
      begin
        FState := bsUp;
        FDown := false;
      end;
    end
    else
      FDown := true;
  end
  else
    FDown := false;

  Changed;
end;

procedure TAdvSmoothToggleButton.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  msg: TMessage;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Enabled then
  begin
    if AutoToggle then
    begin
      if FState = bsUp then
        FDown := false;
    end
    else
      FDown := false;

    if (FGroupIndex <> 0) and (Parent <> nil) then
    begin
      Msg.Msg := CM_BUTTONPRESSED;
      Msg.WParam := FGroupIndex;
      Msg.LParam := Longint(Self);
      Msg.Result := 0;
      Parent.Broadcast(Msg);
    end;
  end
  else
    FDown := false;

  Changed;
  DoClick;
end;

procedure TAdvSmoothToggleButton.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  if not (csDestroying in ComponentState) then
  begin
    if (AOperation = opRemove) and (AComponent = FDropDownMenu) then
      FDropDownMenu := nil;

    if (AOperation = opRemove) and (AComponent = FDropDownControl) then
      FDropDownControl := nil;
  end;
  inherited;  
end;

procedure DrawArrow(Canvas: TCanvas; ArP: TPoint; ArClr, ArShad: TColor);
begin
  Canvas.Pen.Color := ArClr;
  Canvas.MoveTo(ArP.X, ArP.Y);
  Canvas.LineTo(ArP.X + 5, ArP.Y);
  Canvas.MoveTo(ArP.X + 1, ArP.Y + 1);
  Canvas.LineTo(ArP.X + 4, ArP.Y + 1);
  Canvas.Pixels[ArP.X + 2, ArP.Y + 2] := ArClr;
  Canvas.Pixels[ArP.X, ArP.Y + 1] := ArShad;
  Canvas.Pixels[ArP.X + 4, ArP.Y + 1] := ArShad;
  Canvas.Pixels[ArP.X + 1, ArP.Y + 2] := ArShad;
  Canvas.Pixels[ArP.X + 3, ArP.Y + 2] := ArShad;
  Canvas.Pixels[ArP.X + 2, ArP.Y + 3] := ArShad;
end;

procedure DrawRadialBackGround(Graphics: TGPGraphics; R: TGPRectF; CF,CT: TColor; o, ot: Byte; RoundingType: TFillRoundingType; Rounding: integer);
var
  path: TGPGraphicsPath;
  pthGrBrush: TGPPathGradientBrush;
  solGrBrush: TGPSolidBrush;

  w,h: Double;
  colors : array[0..0] of TGPColor;
  count: Integer;

begin
  w := r.Width;
  h := r.Height;

  solGrBrush := TGPSolidBrush.Create(MakeColor(255, CT));

  path := CreateRoundRectangle(r, Rounding, RoundingType, false);
  Graphics.FillPath(solGrBrush, path);
  path.Free;

  solGrBrush.Free;

  if R.Width > R.Height then
    r := MakeRect(r.X + 2, r.Y, r.Width - 4, r.Height)
  else
    r := MakeRect(r.X, r.Y + 2, r.Width, r.Height - 4);

  // Create a path that consists of a single ellipse.
  path := TGPGraphicsPath.Create;

  path.AddEllipse(r.X, r.Y, w ,h);

  pthGrBrush := TGPPathGradientBrush.Create(path);
  pthGrBrush.SetCenterPoint(MakePoint(r.X + (w / 2), r.Y + (h / 2)));

  // Set the color at the center point to blue.
  pthGrBrush.SetCenterColor(MakeColor(o, CF));
  colors[0] := MakeColor(ot, CT);

  count := 1;
  pthGrBrush.SetSurroundColors(@colors, count);
  graphics.FillRectangle(pthGrBrush, r);
  pthGrBrush.Free;

  path.Free;
end;

type
  EColorError = class(Exception);

  THSVTriplet = record
    H,S,V: double;
  end;

  TRGBTriplet = record
    R,G,B: double;
  end;

procedure RGBToHSV (const R,G,B: Double; var H,S,V: Double);
var
  Delta: double;
  Min : double;
begin
  Min := MinValue( [R, G, B] );
  V := MaxValue( [R, G, B] );

  Delta := V - Min;

  // Calculate saturation: saturation is 0 if r, g and b are all 0
  if V = 0.0 then
    S := 0
  else
    S := Delta / V;

  if (S = 0.0) then
    H := NaN    // Achromatic: When s = 0, h is undefined
  else
  begin       // Chromatic
    if (R = V) then
    // between yellow and magenta [degrees]
      H := 60.0 * (G - B) / Delta
    else
      if (G = V) then
       // between cyan and yellow
        H := 120.0 + 60.0 * (B - R) / Delta
      else
        if (B = V) then
        // between magenta and cyan
          H := 240.0 + 60.0 * (R - G) / Delta;

    if (H < 0.0) then
      H := H + 360.0
  end;
end; {RGBtoHSV}

procedure HSVtoRGB (const H,S,V: double; var R,G,B: double);
var
  f : double;
  i : INTEGER;
  hTemp: double; // since H is CONST parameter
  p,q,t: double;
begin
  if (S = 0.0) then    // color is on black-and-white center line
  begin
    if IsNaN(H) then
    begin
      R := V;           // achromatic: shades of gray
      G := V;
      B := V
    end
    else
      raise EColorError.Create('HSVtoRGB: S = 0 and H has a value');
  end
  else
  begin // chromatic color
    if (H = 360.0) then         // 360 degrees same as 0 degrees
      hTemp := 0.0
    else
      hTemp := H;

    hTemp := hTemp / 60;     // h is now IN [0,6)
    i := TRUNC(hTemp);        // largest integer <= h
    f := hTemp - i;                  // fractional part of h

    p := V * (1.0 - S);
    q := V * (1.0 - (S * f));
    t := V * (1.0 - (S * (1.0 - f)));

    case i of
      0: begin R := V; G := t;  B := p  end;
      1: begin R := q; G := V; B := p  end;
      2: begin R := p; G := V; B := t   end;
      3: begin R := p; G := q; B := V  end;
      4: begin R := t;  G := p; B := V  end;
      5: begin R := V; G := p; B := q  end;
    end;
  end;
end; {HSVtoRGB}


procedure TAdvSmoothToggleButton.Paint;
var
  g: TGPGraphics;
  path: TGPGraphicsPath;
  x, xs, y, ys, w, h: integer;
  p: TGPPen;
  b: TGPSolidBrush;
  bvcto, bvc, c, cd: TColor;
  pc: TAdvGDIPPicture;
  fHSV: THSVTriplet;
  fRGB: TRGBTriplet;
  ap: TPoint;
  vs, hs: integer;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  g.SetTextRenderingHint(TextRenderingHintAntiAlias);

  if Status.Visible and ((Status.Caption <> '') or not Status.Appearance.Fill.Picture.Empty) then
  begin
    vs := VerticalSpacing;
    hs := HorizontalSpacing;
  end
  else
  begin
    vs := 0;
    hs := 0;
  end;

  x := hs;
  y := vs;
  w := Width - 1 - (hs * 2);
  h := Height - 1 - (vs * 2);

  bvc := BevelColor;
  c := Color;
  cd := ColorDown;
  pc := Picture;

  if not Enabled then
  begin
    if not PictureDisabled.Empty then
      pc := PictureDisabled;
    bvc := BevelColorDisabled;
    c := ColorDisabled;
    cd := clNone;
  end
  else if Down then
  begin
    if not PictureDown.Empty then
      pc := PictureDown;      
    bvc := BevelColorDown;
  end;

  if BevelWidth >= 4 then
  begin
    fRGB.R := GetRed(bvc);
    fRGB.G := GetGreen(bvc);
    fRGB.B := GetBlue(bvc);
    RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
    fHSV.V := 0.6 * fHSV.V;
    HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);
    bvcto := RGB(Round(fRGB.R), Round(fRGB.G), Round(fRGB.B));

    DrawRadialBackGround(g, MakeRect(x, y, w, BevelWidth), bvc, bvcto, 255, 255, rtTop, 7);
    DrawRadialBackGround(g, MakeRect(x, y + BevelWidth - 1, BevelWidth, h - (BevelWidth * 2) + 2), bvc, bvcto, 255, 255, rtNone, 7);
    DrawRadialBackGround(g, MakeRect(x, h - BevelWidth + vs, w, BevelWidth), bvc, bvcto, 255, 255, rtBottom, 7);
    DrawRadialBackGround(g, MakeRect(w - BevelWidth + hs, y + BevelWidth - 1, BevelWidth, h - (BevelWidth * 2) + 2), bvc, bvcto, 255, 255, rtNone, 7);
  end
  else if BevelWidth > 0 then
  begin
    path := CreateRoundRectangle(MakeRect(x, y, w, h), 7, rtBoth, false);
    b := TGPSolidBrush.Create(MakeColor(255, bvc));
    g.FillPath(b, path);
    b.Free;
    path.Free;  
  end;

  if BorderColor <> clNone then
  begin
    path := CreateRoundRectangle(MakeRect(x, y, w, h), 7, rtBoth, false);
    p := TGPPen.Create(MakeColor(255, BorderColor));
    g.DrawPath(p, path);
    p.Free;
    path.Free;
    x := x + 1;
    y := y + 1;
    w := w - 1;
    h := h - 1;
  end;

  if BevelWidth > 0 then
  begin
    if BevelWidth < 4 then
    begin
      x := x + BevelWidth;
      y := y + BevelWidth;
      w := w - BevelWidth * 2;
      h := h - BevelWidth * 2;
    end
    else
    begin
      x := x + (BevelWidth div 2);
      y := y + (BevelWidth div 2);
      w := w - BevelWidth;
      h := h - BevelWidth;
    end;
  end;

  FAppearance.Draw(g, Caption, x, y, w, h, 0, 0, c, cd, clNone, False, FDown, false, false, false, rtBoth, pc, 0, 0, true);

  if BorderInnerColor <> clNone then
  begin
    path := CreateRoundRectangle(MakeRect(x, y, w - 1, h - 1), 7, rtBoth, false);
    p := TGPPen.Create(MakeColor(255, BorderInnerColor));
    g.DrawPath(p, path);
    p.Free;
    path.Free;
  end;

  if Status.Visible and ((Status.Caption <> '') or not Status.Appearance.Fill.Picture.Empty) then
  begin
    with Status do
    begin
      Appearance.CalculateSize(g, Status.Caption);
      xs := Self.Width + Status.OffsetLeft - Status.Appearance.GetWidth;
      ys := Status.OffsetTop;
      Appearance.Draw(g, Status.OffsetLeft + xs, ys, 0, 0, true,Status.Caption);
    end;
  end;

  if TabStop and FFocused then
    DrawFocus(g, MakeRect(0,0, Width - 1 , Height - 1), 8);  

  g.Free;

  if DropDownButton then
  begin
    ap.X := x + ((w - 5) div 2);
    ap.Y := y + ((h - 5) div 2) + 1;

    if (Caption <> '') or not Picture.Empty then
      ap.x := x + w - 10;

    DrawArrow(Canvas, ap, DropDownArrowColor, DropDownArrowColor);
  end;

end;

procedure TAdvSmoothToggleButton.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothToggleButton.Resize;
begin
  inherited;
end;

procedure TAdvSmoothToggleButton.SetAppearance(const Value: TGDIPButton);
begin
  if FAppearance <> value then
  begin
    FAppearance.Assign(Value);
    AppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothToggleButton.SetAutoToggle(const Value: Boolean);
begin
  if FAutoToggle <> value then
  begin
    FAutoToggle := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetBevelColor(const Value: TColor);
begin
  if FBevelColor <> value then
  begin
    FBevelColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetBevelColorDisabled(const Value: TColor);
begin
  if FBevelColorDisabled <> value then
  begin
    FBevelColorDisabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetBevelColorDown(const Value: TColor);
begin
  if FBevelColorDown <> value then
  begin
    FBevelColorDown := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetBevelWidth(const Value: integer);
begin
  if FBevelWidth <> value then
  begin
    FBevelWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetBorderInnerColor(const Value: TColor);
begin
  if FBorderInnerColor <> value then
  begin
    FBorderInnerColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetCaption(const Value: string);
begin
  if FCaption <> value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetColor(const Value: TColor);
begin
  if FColor <> value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetColorDisabled(const Value: TColor);
begin
  if FColorDisabled <> value then
  begin
    FColorDisabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetColorDown(const Value: TColor);
begin
  if FColorDown <> Value then
  begin
    FColorDown := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetComponentStyle(AStyle: TTMSStyle);
begin
  case astyle of
    tsOffice2003Blue:
    begin
      Color := $00E3B28D;
      ColorDown := $AAD9FF;
      ColorDisabled := $00F2F2F2;
    end;
    tsOffice2003Silver:
    begin
      Color := $00927476;
      ColorDown := $AAD9FF;
      ColorDisabled := $947C7C;
    end;
    tsOffice2003Olive:
    begin
      Color := $447A63;
      ColorDown := $AAD9FF;
      ColorDisabled := $947C7C;
    end;
    tsOffice2003Classic:
    begin
      Color := $00C9D1D5;
      ColorDown := $AAD9FF;
      ColorDisabled := $FFD1AD;  
    end;
    tsOffice2007Luna:
    begin
      Color := $00FDEADA;
      ColorDown := $AAD9FF;
      ColorDisabled := $FFD1AD;
    end;
    tsOffice2007Obsidian:
    begin
      Color := $006E6E6D;
      ColorDown := $AAD9FF;
      ColorDisabled := $FFD1AD;
    end;
    tsWindowsXP:
    begin
      Color := $B9D8DC;
      ColorDown := $AAD9FF;
      ColorDisabled := $FFD1AD;
    end;
    tsWhidbey:
    begin
      Color := $00828F92;
      ColorDown := $AAD9FF;
      ColorDisabled := $FFD1AD;
    end;
    tsCustom: ;
    tsOffice2007Silver:
    begin
      Color := $00E7DCD5;
      ColorDown := $AAD9FF;
      ColorDisabled := $FFD1AD;      
    end;
  end;

  BevelColor := Color;
  BevelColorDisabled := ColorDisabled;
  BevelColorDown := ColorDown;
end;

procedure TAdvSmoothToggleButton.SetDown(const Value: Boolean);
var
  msg: TMessage;
begin
  if FDown <> value then
  begin
    FDown := Value;
    if Value then
      FState := bsDown
    else
      FState := bsUp;

    if (FGroupIndex <> 0) and (Parent <> nil) then
    begin
      Msg.Msg := CM_BUTTONPRESSED;
      Msg.WParam := FGroupIndex;
      Msg.LParam := Longint(Self);
      Msg.Result := 0;
      Parent.Broadcast(Msg);
    end;
          
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetDropDown(const Value: boolean);
begin
  if Value then 
    ShowDropDown
  else
    HideDropDown;
end;

procedure TAdvSmoothToggleButton.SetDropDownArrowColor(const Value: TColor);
begin
  if FDropDownArrowColor <> value then
  begin
    FDropDownArrowColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetDropDownButton(const Value: Boolean);
begin
  if FDropDownButton <> value then
  begin
    FDropDownButton := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetDropDownControl(const Value: TWinControl);
begin
  if FDropDownControl <> value then
  begin
    FDropDownControl := Value;
    FDropDownControl.Visible := false;
  end;
end;

procedure TAdvSmoothToggleButton.SetDropDownRounding(const Value: integer);
begin
  if FDropDownRounding <> value then
  begin
    FDropDownRounding := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetEnabled(Value: Boolean);
begin
  inherited;
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetGroupIndex(const Value: integer);
begin
  if FGroupIndex <> value then
  begin
    FGroupIndex := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetHorizontalSpacing(const Value: integer);
begin
  if FHorizontalSpacing <> value then
  begin
    FHorizontalSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.SetPicture(const Value: TAdvGDIPPicture);
begin
  if Fpicture <> value then
  begin
    FPicture.Assign(Value);
    PictureChanged(Self);
  end;
end;

procedure TAdvSmoothToggleButton.SetPictureDisabled(
  const Value: TAdvGDIPPicture);
begin
  if FPictureDisabled <> value then
  begin
    FPictureDisabled.Assign(Value);
    PictureChanged(Self);
  end;
end;

procedure TAdvSmoothToggleButton.SetPictureDown(const Value: TAdvGDIPPicture);
begin
  if FPictureDown <> value then
  begin
    FPictureDown.Assign(Value);
    PictureChanged(Self);
  end;
end;

procedure TAdvSmoothToggleButton.SetStatus(
  const Value: TAdvSmoothToggleButtonStatus);
begin
  if FStatus <> value then
  begin
    FStatus.Assign(Value);
    StatusChanged(Self);
  end;
end;

procedure TAdvSmoothToggleButton.SetVersion(const Value: string);
begin

end;

procedure TAdvSmoothToggleButton.SetVerticalSpacing(const Value: integer);
begin
  if FVerticalSpacing <> value then
  begin
    FVerticalSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButton.ShowDropDown;
var
  P: TPoint;
  R: TRect;
  DoMenu, DoControl: Boolean;
  hs, vs: integer;
  rgn: HRGN;
begin
  if not Enabled then
    Exit;

  DoMenu := Assigned(FDropDownMenu);
  DoControl := Assigned(FDropDownForm) and Assigned(FDropDownControl);

  if DoMenu and not DoControl then
  begin
    if Assigned(FOnDropDown) then
      FOnDropDown(self);

    p := Point(Left, Top + Height);
    p := Parent.ClientToScreen(p);
    Invalidate;
    FDropDownMenu.Popup(p.X, p.Y);
  end;

  if DoControl and not DoMenu then
  begin
    if FDropDownForm.Visible then
    begin
      HideDropDown;
      Exit;
    end;

    FDropDownForm.Control := FDropDownControl;
    FDropDownControl.Parent := FDropDownForm;

    {$IFNDEF TMSDOTNET}
    SystemParametersInfo(SPI_GETWORKAREA, 0, @r, 0);
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    SystemParametersInfo(SPI_GETWORKAREA, 0, r, 0);
    {$ENDIF}

    FDropDownForm.Width := FDropDownControl.Width;
    FDropDownForm.Height := FDropDownControl.Height;
    FDropDownForm.Width := FDropDownForm.Width + 2;
    FDropDownForm.Height := FDropDownForm.Height + 2;

    if Status.Visible then
    begin
      hs := HorizontalSpacing;
      vs := VerticalSpacing;
    end
    else
    begin
      hs := 0;
      vs := 0;
    end;

    p := Point(0, self.Height);
    P := ClientToScreen(P);

    if (R.Bottom < (P.Y + FDropDownForm.Height + 4)) and (R.Right < (P.X + FDropDownForm.Width + 4)) then
    begin
      FDropDownForm.Left := P.X + self.Width - FDropDownForm.Width - hs;
      FDropDownForm.Top := P.Y - self.Height - FDropDownForm.Height + vs;
    end
    else if R.Bottom < (P.Y + FDropDownForm.Height + 4) then
    begin
      FDropDownForm.Left := P.X + hs;
      FDropDownForm.Top := P.Y - self.Height - FDropDownForm.Height + vs;
    end
    else if R.Right < (P.X + FDropDownForm.Width + 4) then
    begin
      FDropDownForm.Left := P.X + self.Width - FDropDownForm.Width - hs;
      FDropDownForm.Top := P.Y - vs;
    end
    else
    begin
      FDropDownForm.Left := P.X + hs;
      FDropDownForm.Top := P.Y - vs;
    end;

    if DropDownRounding > 0 then
    begin
      rgn := CreateRoundRectRgn(0, 0, FDropDownForm.Width, FDropDownForm.Height, DropDownRounding, DropDownRounding);
      SetWindowRgn(FDropDownForm.Handle, rgn, true);
    end;

    FDropDownForm.Visible := true;
    FDropDownControl.Visible := true;
    FDropDownForm.SetFocus;
    FDropDownControl.Align := alClient;
    FDroppedDown := true;
        
    if Assigned(FOnDropDown) then
      FOnDropDown(self);
    Invalidate;
  end;
end;

procedure TAdvSmoothToggleButton.StatusChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothToggleButton.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TAdvSmoothToggleButton.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.Result := 0;
end;

procedure TAdvSmoothToggleButton.WMKillFocus(var Msg: TWMKillFocus);
begin
  if (csLoading in ComponentState) then
    Exit;

  if FDropDownForm.Visible and not (msg.FocusedWnd = FDropDownForm.Handle) then
    HideDropDown;

  inherited;
end;

procedure TAdvSmoothToggleButton.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if Assigned(OnDblClick) then
    OnDblClick(Self);
end;

procedure TAdvSmoothToggleButton.WMLButtonDown(var Msg: TWMMouse);
var
  SecondDown: Boolean;
begin
  SecondDown := false;
  if FDroppedDown and Assigned(FDropDownForm) and (FDropDownForm.Visible) then   // CancelMode wihe DropDown on second click
    SecondDown := true;

  inherited;
  if csDesigning in ComponentState then
    Exit;

  if PtInRect(GetButtonRect, point(msg.xpos, msg.ypos)) then
  begin
    if not SecondDown then
      ShowDropDown;
  end;
end;

procedure TAdvSmoothToggleButton.WMLButtonUp(var Msg: TWMMouse);
begin
  inherited;
end;

procedure TAdvSmoothToggleButton.WMPaint(var Message: TWMPaint);
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

procedure TAdvSmoothToggleButton.WMSetFocus(var Msg: TWMSetFocus);
begin
  if csLoading in ComponentState then
    Exit;
  inherited;
end;

{ TAdvSmoothToggleButtonStatus }

procedure TAdvSmoothToggleButtonStatus.AppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothToggleButtonStatus.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothToggleButtonStatus) then
  begin
    FAppearance := (Source as TAdvSmoothToggleButtonStatus).Appearance;
    FOffsetTop := (Source as TAdvSmoothToggleButtonStatus).OffsetTop;
    FOffsetLeft := (Source as TAdvSmoothToggleButtonStatus).OffsetLeft;
    FVisible := (Source as TAdvSmoothToggleButtonStatus).Visible;
    FCaption := (Source as TAdvSmoothToggleButtonStatus).Caption;
  end;
end;

procedure TAdvSmoothToggleButtonStatus.Changed;
begin
  FOwner.Invalidate;
end;

constructor TAdvSmoothToggleButtonStatus.Create(AOwner: TAdvSmoothToggleButton);
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

destructor TAdvSmoothToggleButtonStatus.Destroy;
begin
  FAppearance.Free;
  inherited;
end;

procedure TAdvSmoothToggleButtonStatus.SetAppearance(const Value: TGDIPStatus);
begin
  if FAppearance <> value then
  begin
    FAppearance.Assign(Value);
    AppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothToggleButtonStatus.SetCaption(const Value: String);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButtonStatus.SetOffsetLeft(const Value: integer);
begin
  if FOffsetLeft <> Value then
  begin
    FOffsetLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButtonStatus.SetOffsetTop(const Value: integer);
begin
  if FOffsetTop <> Value then
  begin
    FOffsetTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothToggleButtonStatus.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TAdvSmoothToggleButtonDropDownWindow }

constructor TAdvSmoothToggleButtonDropDownWindow.Create(AOwner: TComponent);
begin
  inherited;
  FHideOnDeActivate := true;
end;

procedure TAdvSmoothToggleButtonDropDownWindow.CreateParams(
  var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited CreateParams(Params);
  
  if (Win32Platform = VER_PLATFORM_WIN32_NT) and
    ((Win32MajorVersion > 5) or
    ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1))) then
    Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;

  if (Win32Platform = VER_PLATFORM_WIN32_NT) then
    Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST;
end;

destructor TAdvSmoothToggleButtonDropDownWindow.Destroy;
begin
  inherited;
end;

procedure TAdvSmoothToggleButtonDropDownWindow.WMActivate(
  var Message: TMessage);
begin
  inherited;
  if Message.WParam = integer(False) then
  begin
    if HideOnDeActivate then
      Hide;
  end
  else if Assigned(FControl) then
    if Visible then
      FControl.SetFocus
    else
      self.Parent.SetFocus;
end;

procedure TAdvSmoothToggleButtonDropDownWindow.WMNCButtonDown(
  var Message: TMessage);
begin
  inherited;
end;

procedure TAdvSmoothToggleButtonDropDownWindow.WMNCHitTest(
  var Message: TWMNCHitTest);
var
  pt: TPoint;
begin
  pt := ScreenToClient(Point(Message.XPos, Message.YPos));

  if (pt.X > Width - 10) and (pt.Y > Height - 10) then
    message.Result := HTBOTTOMRIGHT
end;

{ TWinCtrl }

procedure TWinCtrl.PaintCtrls(DC: HDC; First: TControl);
begin
  PaintControls(DC, First);
end;

end.
