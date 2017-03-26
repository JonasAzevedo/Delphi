{**************************************************************************}
{ TAdvSmoothLedLabel component                                             }
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

unit AdvSmoothLedLabel;

interface

{$I TMSDEFS.INC}

uses
  SysUtils, Classes, Controls, Graphics, Messages, Windows, Math,
  AdvSmoothGDIP, GDIPFill, AdvStyleIF;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : first release
  // v1.1.0.0 : New : Support DateTime
  //          : New : Property Format to format the led value
  //          : Fixed : Access violation when choosing gtNone
  //          : Improved : Property Angle to use with gradienttype gtAngle


type
  TAdvSmoothLedLabelBackGroundPosition = (bpTopLeft,bpTopCenter,bpTopRight,bpBottomLeft,bpBottomCenter,bpBottomRight,bpTiled,bpStretched,bpCenterLeft,bpCenterCenter,bpCenterRight);

  TAdvSmoothLedLabelCaption = class;

  TAdvSmoothLedLabel = class(TGraphicControl, ITMSStyle)
  private
    FDesignTime: Boolean;
    FCaption: TAdvSmoothLedLabelCaption;
    FTransparent: Boolean;
    FFill: TGDIPFill;
    procedure SetCaption(const Value: TAdvSmoothLedLabelCaption);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SetTransparent(const Value: Boolean);
    procedure SetFill(const Value: TGDIPFill);
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure CaptionChanged(Sender: TObject);
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure DrawLed(g: TGPGraphics);
    procedure DrawDigit(g: TGPGraphics; number: Integer; position: TGPPointF; h: integer;  b: TGPBrush; l: integer);
    function GetX(x: Double; width: Double): Double;
    function GetY(y: Double; height: Double): Double;
    function IsNumberAvailable(Number: integer; const listOfNumbers: array of integer): Boolean;        
    function GetVersionNr: integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Paint; override;
    procedure SetComponentStyle(AStyle: TTMSStyle);    
  published
    property Fill: TGDIPFill read FFill write SetFill;
    property Caption: TAdvSmoothLedLabelCaption read FCaption write SetCaption;
    property Version: string read GetVersion write SetVersion;
    property Transparent: Boolean read FTransparent write SetTransparent default false;

    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Visible;
    property ShowHint;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseDown;
    property OnResize;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    {$IFDEF DELPHI2006_LVL}
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    {$ENDIF}
    property OnStartDock;
    property OnStartDrag;
    property PopupMenu;
  end;

  TAdvSmoothLedLabelValueType = (vtNormal, vtDateTime);

  TAdvSmoothLedLabelCaption = class(TPersistent)
  private
    FOwner: TAdvSmoothLedLabel;
    FGradientType: TAdvGradientType;
    FPicture: TAdvGDIPPicture;
    FEndColor: TColor;
    FHatchStyle: THatchStyle;
    FStartOpacity: Byte;
    FValue: Double;
    FTop: integer;
    FLeft: integer;
    FEndOpacity: Byte;
    FStartColor: TColor;
    FOnChange: TNotifyEvent;
    FColorOff: TColor;
    FColorOffOpacity: Byte;
    FAngle: integer;
    FFormat: String;
    FTimeFormat: String;
    FTimeValue: TDateTime;
    FValueType: TAdvSmoothLedLabelValueType;
    procedure SetEndColor(const Value: TColor);
    procedure SetEndOpacity(const Value: Byte);
    procedure SetGradientType(const Value: TAdvGradientType);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetLeft(const Value: integer);
    procedure SetPicture(const Value: TAdvGDIPPicture);
    procedure SetStartColor(const Value: TColor);
    procedure SetStartOpacity(const Value: Byte);
    procedure SetTop(const Value: integer);
    procedure SetValue(const Value: Double);
    procedure SetColorOff(const Value: TColor);
    procedure SetColorOffOpacity(const Value: Byte);
    procedure SetAngle(const Value: integer);
    procedure SetFormat(const Value: String);
    procedure SetTimeFormat(const Value: String);
    procedure SetTimeValue(const Value: TDateTime);
    procedure SetValueType(const Value: TAdvSmoothLedLabelValueType);
  protected
    procedure Changed;
    procedure PictureChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothLedLabel);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Value: Double read FValue write SetValue;
    property Left: integer read FLeft write SetLeft default 0;
    property Top: integer read FTop write SetTop default 0;
    property Picture: TAdvGDIPPicture read FPicture write SetPicture;
    property ColorStart: TColor read FStartColor write SetStartColor default $004080FF;
    property ColorEnd: TColor read FEndColor write SetEndColor default clRed;
    property ColorOff: TColor read FColorOff write SetColorOff default clGray;
    property ColorOffOpacity: Byte read FColorOffOpacity write SetColorOffOpacity default 255;
    property OpacityStart: Byte read FStartOpacity write SetStartOpacity default 255;
    property OpacityEnd: Byte read FEndOpacity write SetEndOpacity default 255;
    property GradientType: TAdvGradientType read FGradientType write SetGradientType default gtVertical;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property Angle: integer read FAngle write SetAngle default 0;
    property Format: String read FFormat write SetFormat;
    property TimeFormat: String read FTimeFormat write SetTimeFormat;
    property ValueType: TAdvSmoothLedLabelValueType read FValueType write SetValueType default vtnormal;
    property TimeValue: TDateTime read FTimeValue write SetTimeValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;


implementation

procedure TAdvSmoothLedLabel.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothLedLabel) then
  begin
    FFill.Assign((Source as TAdvSmoothLedLabel).Fill);
    FCaption.Assign((Source as TAdvSmoothLedLabel).Caption);
    FTransparent := (Source as TAdvSmoothLedLabel).Transparent;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabel.CaptionChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothLedLabel.Changed;
begin
  Invalidate;
end;

constructor TAdvSmoothLedLabel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csReplicatable];

  FTransparent := false;
  Width := 200;
  Height := 50;
  FCaption := TAdvSmoothLedLabelCaption.Create(Self);
  FCaption.OnChange := CaptionChanged;

  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  if FDesignTime then
  begin
    FFill.Color := clBlack;
    FFill.ColorTo := clGray;    
  end;
end;

destructor TAdvSmoothLedLabel.Destroy;
begin
  Fill.Free;
  Caption.Free;
  inherited;
end;

procedure TAdvSmoothLedLabel.DrawDigit(g: TGPGraphics; number: Integer;
  position: TGPPointF; h: integer; b: TGPBrush; l: integer);
type
  TArrayOfPointF = array of TGPPointF;
var
  segmentG: TArrayOfPointF;
  segmentF: TArrayOfPointF;
  segmentE: TArrayOfPointF;
  segmentD: TArrayOfPointF;
  segmentC: TArrayOfPointF;
  segmentB: TArrayOfPointF;
  segmentA: TArrayOfPointF;
  ot: TGPPen;
  w: Double;
  bo: TGPBrush;
begin
  ot := nil;
  try
    w := Width / l;

    ot := TGPPen.Create(MakeColor(Caption.ColorOffOpacity, Caption.ColorOff));

    SetLength(segmentA, 5);
    segmentA[0] := MakePoint((position.X + GetX(2.8, w)), (position.Y + GetY(1, h)));
    segmentA[1] := MakePoint((position.X + GetX(10, w)), (position.Y + GetY(1, h)));
    segmentA[2] := MakePoint((position.X + GetX(8.8, w)), (position.Y + GetY(2, h)));
    segmentA[3] := MakePoint((position.X + GetX(3.8, w)), (position.Y + GetY(2, h)));
    segmentA[4] := segmentA[0];

    SetLength(segmentB, 5);
    segmentB[0] := MakePoint((position.X + GetX(10, w)), (position.Y + GetY(1.4, h)));
    segmentB[1] := MakePoint((position.X + GetX(9.3, w)), (position.Y + GetY(6.8, h)));
    segmentB[2] := MakePoint((position.X + GetX(8.4, w)), (position.Y + GetY(6.4, h)));
    segmentB[3] := MakePoint((position.X + GetX(9, w)), (position.Y + GetY(2.2, h)));
    segmentB[4] := segmentB[0];

    SetLength(segmentC, 5);
    segmentC[0] := MakePoint((position.X + GetX(9.2, w)), (position.Y + GetY(7.2, h)));
    segmentC[1] := MakePoint((position.X + GetX(8.7, w)), (position.Y + GetY(12.7, h)));
    segmentC[2] := MakePoint((position.X + GetX(7.6, w)), (position.Y + GetY(11.9, h)));
    segmentC[3] := MakePoint((position.X + GetX(8.2, w)), (position.Y + GetY(7.7, h)));
    segmentC[4] := segmentC[0];

    SetLength(segmentD, 5);
    segmentD[0] := MakePoint((position.X + GetX(7.4, w)), (position.Y + GetY(12.1, h)));
    segmentD[1] := MakePoint((position.X + GetX(8.4, w)), (position.Y + GetY(13, h)));
    segmentD[2] := MakePoint((position.X + GetX(1.3, w)), (position.Y + GetY(13, h)));
    segmentD[3] := MakePoint((position.X + GetX(2.2, w)), (position.Y + GetY(12.1, h)));
    segmentD[4] := segmentD[0];

    SetLength(segmentE, 5);
    segmentE[0] := MakePoint((position.X + GetX(2.2, w)), (position.Y + GetY(11.8, h)));
    segmentE[1] := MakePoint((position.X + GetX(1, w)), (position.Y + GetY(12.7, h)));
    segmentE[2] := MakePoint((position.X + GetX(1.7, w)), (position.Y + GetY(7.2, h)));
    segmentE[3] := MakePoint((position.X + GetX(2.8, w)), (position.Y + GetY(7.7, h)));
    segmentE[4] := segmentE[0];

    SetLength(segmentF, 5);
    segmentF[0] := MakePoint((position.X + GetX(3, w)), (position.Y + GetY(6.4, h)));
    segmentF[1] := MakePoint((position.X + GetX(1.8, w)), (position.Y + GetY(6.8, h)));
    segmentF[2] := MakePoint((position.X + GetX(2.6, w)), (position.Y + GetY(1.3, h)));
    segmentF[3] := MakePoint((position.X + GetX(3.6, w)), (position.Y + GetY(2.2, h)));
    segmentF[4] := segmentF[0];

    SetLength(segmentG, 7);
    segmentG[0] := MakePoint((position.X + GetX(2, w)), (position.Y + GetY(7, h)));
    segmentG[1] := MakePoint((position.X + GetX(3.1, w)), (position.Y + GetY(6.5, h)));
    segmentG[2] := MakePoint((position.X + GetX(8.3, w)), (position.Y + GetY(6.5, h)));
    segmentG[3] := MakePoint((position.X + GetX(9, w)), (position.Y + GetY(7, h)));
    segmentG[4] := MakePoint((position.X + GetX(8.2, w)), (position.Y + GetY(7.5, h)));
    segmentG[5] := MakePoint((position.X + GetX(2.9, w)), (position.Y + GetY(7.5, h)));
    segmentG[6] := segmentG[0];

    if Caption.ColorOff <> clNone then
    begin
      bo := ot.GetBrush;
      g.FillPolygon(bo, PGPpointF(segmentA), Length(segmentA));
      g.FillPolygon(bo, PGPpointF(segmentB), Length(segmentB));
      g.FillPolygon(bo, PGPpointF(segmentC), Length(segmentC));
      g.FillPolygon(bo, PGPpointF(segmentD), Length(segmentD));
      g.FillPolygon(bo, PGPpointF(segmentE), Length(segmentE));
      g.FillPolygon(bo, PGPpointF(segmentF), Length(segmentF));
      g.FillPolygon(bo, PGPpointF(segmentG), Length(segmentG));
      bo.free;
    end;

    if IsNumberAvailable(number, [0, 2, 3, 5, 6, 7, 8, 9]) then
      g.FillPolygon(b, PGPpointF(segmentA), Length(SegmentA));
    if IsNumberAvailable(number, [0, 1, 2, 3, 4, 7, 8, 9]) then
      g.FillPolygon(b, PGPpointF(segmentB), Length(SegmentB));
    if IsNumberAvailable(number, [0, 1, 3, 4, 5, 6, 7, 8, 9]) then
      g.FillPolygon(b, PGPpointF(segmentC), Length(SegmentC));
    if IsNumberAvailable(number, [0, 2, 3, 5, 6, 8, 9]) then
      g.FillPolygon(b, PGPpointF(segmentD), Length(SegmentD));
    if IsNumberAvailable(number, [0, 2, 6, 8]) then
      g.FillPolygon(b, PGPpointF(segmentE), Length(SegmentE));
    if IsNumberAvailable(number, [0, 4, 5, 6, 7, 8, 9]) then
      g.FillPolygon(b, PGPpointF(segmentF), Length(SegmentF));
    if IsNumberAvailable(number, [2, 3, 4, 5, 6, 8, 9, -1]) then
      g.FillPolygon(b, PGPpointF(segmentG), Length(SegmentG));
    if IsNumberAvailable(number, [-2]) then
    begin
      g.FillEllipse(b, MakeRect((position.X - (Width / l) + GetX(11.2, w)),(position.Y + GetY(3, h)), (w / 7), (w / 7)));
      g.FillEllipse(b, MakeRect((position.X - (Width / l) + GetX(10, w)),(position.Y + GetY(9.5, h)), (w / 7), (w / 7)));
    end;
    if IsNumberAvailable(number, [-3]) then
      g.FillEllipse(b, MakeRect((position.X - (Width / l) + GetX(10, w)),(position.Y + GetY(12, h)), (w / 7), (w / 7)));
  finally
    ot.Free;
  end;
end;

procedure TAdvSmoothLedLabel.DrawLed(g: TGPGraphics);
var
  num: String;
  i: Integer;
  shift: Double;
  numch: char;
  dRect: TGPRectF;
  textb: TGPBrush;
  start, stop: TGPColor;
  xs, ys, w, h: double;
  p: TGPPointF;
  gpimg: TGPImage;
  st: TStream;
  sta: TStreamAdapter;
  total: integer;
begin
  dRect := MakeRect(0, 0, Width, Height);
  case Caption.ValueType of
    vtNormal: num := FormatFloat(Caption.Format, Caption.Value);
    vtDateTime: num := FormatDateTime(Caption.TimeFormat, Caption.TimeValue)
  end;
  shift := 0;

  xs := 0;
  ys := 0;
  w := Width;
  h := Height;
  textb := nil;

  p := MakePoint(xs, ys);

  start := MakeColor(Caption.OpacityStart, Caption.ColorStart);
  stop := MakeColor(Caption.OpacityEnd, Caption.ColorEnd);

  case Caption.GradientType of
    gtAngle: textb := TGPLinearGradientBrush.Create(Makerect(xs, ys, w, h), start, stop, Caption.Angle);
    gtRadial, gtPath, gtSolid: textb := TGPSolidBrush.Create(start);
    gtVertical: textb := TGPLinearGradientBrush.Create(MakePoint(xs, ys), MakePoint(xs, ys + h), start, stop);
    gtHorizontal: textb := TGPLinearGradientBrush.Create(MakePoint(xs, ys), MakePoint(xs + w, ys), start, stop);
    gtForwardDiagonal: textb := TGPLinearGradientBrush.Create(MakePoint(xs, ys), MakePoint(xs + w, ys + h), start, stop);
    gtBackwardDiagonal: textb := TGPLinearGradientBrush.Create(MakePoint(xs, ys + h), MakePoint(xs + w, ys), stop, start);
    gtHatch: textb := TGPHatchBrush.Create(Caption.HatchStyle, start, stop);
    gtTexture:
    begin
      if not Caption.Picture.Empty then
      begin
        st := TMemoryStream.Create;
        Caption.Picture.SaveToStream(st);
        sta := TStreamAdapter.Create(st);
        gpimg := TGPImage.Create(sta);
        textb := TGPTextureBrush.Create(gpimg, WrapModeTile);
        st.free;
        gpimg.free;
      end;
    end;
    gtNone: ;
  end;

  total := 0;
  for i := 1 to length(num) do
  begin
    if (num[I] <> DecimalSeparator) and (num[I] <> ':') then
    begin
      Inc(total);
    end;
  end;


  if textb <> nil then
  begin
    for i := 1 to length(num) do
    begin
      numch := num[i];
      if numch = DecimalSeparator then
        DrawDigit(g, -3, MakePoint((drect.X + shift), drect.Y), Round(drect.Height), textb, total)
      else
      begin
        case numch of
        ':':
          begin
            DrawDigit(g, -2, MakePoint((drect.X + shift), drect.Y), Round(drect.Height), textb, total);
          end;
        '-':
          begin
            DrawDigit(g, -1, MakePoint((drect.X + shift), drect.Y), Round(drect.Height), textb, total);
            shift := shift + (Width / total);
          end;
        '0'..'9':
          begin
            DrawDigit(g, ord(numch) - ord('0') , MakePoint((drect.X + shift), drect.Y), Round(drect.Height), textb, total);
            shift := shift + (Width / total);
          end;
        end;
      end;
    end;
    textb.Free;
  end;
end;

procedure TAdvSmoothLedLabel.FillChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothLedLabel.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvSmoothLedLabel.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

function TAdvSmoothLedLabel.GetX(x, width: Double): Double;
begin
  Result := x * width / 12;
end;

function TAdvSmoothLedLabel.GetY(y, height: Double): Double;
begin
  Result := y * height / 15;
end;

function TAdvSmoothLedLabel.IsNumberAvailable(Number: integer;
  const listOfNumbers: array of integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  if (Length(listOfNumbers) > 0) then
  begin
    for i := 0 to Length(ListOfNumbers) - 1 do
    begin
      if (ListOfNumbers[i] = number) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
end;

procedure TAdvSmoothLedLabel.Paint;
var
  r: TGPRectF;
  g: TGPGraphics;
begin
  g := TGPGraphics.Create(Canvas.Handle);
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  r := MakeRect(0, 0, Width - 1, Height - 1);

  if not Transparent then
  begin
    ////Label Rectangle///
    r := Fill.Fill(g, r);
    //////////////////////
  end;
  DrawLed(g);
  g.Free;
end;

procedure TAdvSmoothLedLabel.SetCaption(const Value: TAdvSmoothLedLabelCaption);
begin
  if FCaption <> value then
  begin
    FCaption.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothLedLabel.SetComponentStyle(AStyle: TTMSStyle);
begin
  // TODO : do color settings here
end;

procedure TAdvSmoothLedLabel.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothLedLabel.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabel.SetVersion(const Value: string);
begin

end;

procedure TAdvSmoothLedLabel.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.result := 1;
end;

{ TAdvSmoothLedLabelCaption }

procedure TAdvSmoothLedLabelCaption.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothLedLabelCaption then
  begin
    FLeft := (Source as TAdvSmoothLedLabelCaption).Left;
    FTop := (Source as TAdvSmoothLedLabelCaption).Top;
    FStartColor := (Source as TAdvSmoothLedLabelCaption).ColorStart;
    FEndColor := (Source as TAdvSmoothLedLabelCaption).ColorEnd;
    FGradientType := (Source as TAdvSmoothLedLabelCaption).GradientType;
    FHatchStyle := (Source as TAdvSmoothLedLabelCaption).HatchStyle;
    FStartOpacity := (Source as TAdvSmoothLedLabelCaption).OpacityStart;
    FEndOpacity := (Source as TAdvSmoothLedLabelCaption).OpacityEnd;
    FPicture.Assign((Source as TAdvSmoothLedLabelCaption).Picture);
    FValue := (Source as TAdvSmoothLedLabelCaption).Value;
    FColorOff := (Source as TAdvSmoothLedLabelCaption).ColorOff;
    FColorOffOpacity := (Source as TAdvSmoothLedLabelCaption).ColorOffOpacity;
    FAngle := (source as TAdvSmoothLedLabelCaption).Angle;
    FFormat := (Source as TAdvSmoothLedLabelCaption).Format;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.Changed;
begin
  FOwner.CaptionChanged(Self);
end;

constructor TAdvSmoothLedLabelCaption.Create(AOwner: TAdvSmoothLedLabel);
begin
  FOwner := AOwner;
  FStartColor := $004080FF;
  FEndColor := clRed;
  FStartOpacity := 255;
  FEndOpacity := 255;
  FGradientType := gtVertical;
  FHatchStyle := HatchStyleHorizontal;
  FPicture := TAdvGDIPPicture.Create;
  FPicture.OnChange := PictureChanged;
  FValue := 0;
  FColorOff := clGray;
  FColorOffOpacity := 255;
  FAngle := 0;
  FFormat := '000.00';
  FTimeFormat := 'hh:nn:ss';
  FValueType := vtNormal;
  FTimeValue := Now;
end;

destructor TAdvSmoothLedLabelCaption.Destroy;
begin
  FPicture.Free;
  inherited;
end;

procedure TAdvSmoothLedLabelCaption.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothLedLabelCaption.SetAngle(const Value: integer);
begin
  if FAngle <> value then
  begin
    FAngle := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetColorOff(const Value: TColor);
begin
  if FColorOff <> value then
  begin
    FColorOff := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetColorOffOpacity(const Value: Byte);
begin
  if FColorOffOpacity <> value then
  begin
    FColorOffOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetTimeFormat(const Value: String);
begin
  if FTimeFormat <> value then
  begin
    FTimeFormat := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetEndColor(const Value: TColor);
begin
  if FEndColor <> value then
  begin
    FEndColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetEndOpacity(const Value: Byte);
begin
  if FEndOpacity <> value  then
  begin
    FEndOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetFormat(const Value: String);
begin
  if FFormat <> value then
  begin
    FFormat := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetGradientType(
  const Value: TAdvGradientType);
begin
  if FGradientType <> value then
  begin
    FGradientType := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetHatchStyle(const Value: THatchStyle);
begin
  if FHatchStyle <> value then
  begin
    FHatchStyle := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetLeft(const Value: integer);
begin
  if FLeft <> value then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetPicture(
  const Value: TAdvGDIPPicture);
begin
  if FPicture <> value then
  begin
    FPicture.Assign(Value);
    PictureChanged(Self);
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetStartColor(const Value: TColor);
begin
  if FStartColor <> Value then
  begin
    FStartColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetStartOpacity(const Value: Byte);
begin
  if FStartOpacity <> value then
  begin
    FStartOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetValue(const Value: Double);
begin
  if FValue <> value then
  begin
    FValue := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetTimeValue(const Value: TDateTime);
begin
  if FTimeValue <> value then
  begin
    FTimeValue := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetValueType(
  const Value: TAdvSmoothLedLabelValueType);
begin
  if FvalueType <> value then
  begin
    FValueType := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLedLabelCaption.SetTop(const Value: integer);
begin
  if FTop <> value then
  begin
    FTop := Value;
    Changed;
  end;
end;

end.
