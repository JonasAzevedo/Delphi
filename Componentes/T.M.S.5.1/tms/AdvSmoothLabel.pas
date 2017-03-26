{**************************************************************************}
{ TAdvSmoothLabel component                                                }
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

unit AdvSmoothLabel;

interface

{$I TMSDEFS.INC}

uses
  SysUtils, Classes, Controls, Graphics, Messages, Windows, Math,
  AdvSmoothGDIP, GDIPFill, AdvStyleIF, ActiveX;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 1; // Build nr.

  // version history
  // v1.0.0.0 : first release
  // v1.1.0.0 : New : Wordwrapping
  // v1.1.0.1 : Fixed : Small Memory leak
  //          : Improved : Gradient drawing when end color is clNone

type
  TAdvSmoothLabelLocation = (plTopLeft, plTopCenter, plTopRight, plCenterLeft, plCenterCenter, plCenterRight, plBottomLeft, plBottomCenter, plBottomRight, plCustom);

  TAdvSmoothLabelBackGroundPosition = (bpTopLeft,bpTopCenter,bpTopRight,bpBottomLeft,bpBottomCenter,bpBottomRight,bpTiled,bpStretched,bpCenterLeft,bpCenterCenter,bpCenterRight);

  TAdvSmoothLabelCaption = class;

  TAdvSmoothLabel = class(TGraphicControl, ITMSStyle)
  private
    FCaption: TAdvSmoothLabelCaption;
    FTransparent: Boolean;
    FFill: TGDIPFill;
    FWordWrap: Boolean;
    procedure SetCaption(const Value: TAdvSmoothLabelCaption);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SetTransparent(const Value: Boolean);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetWordWrap(const Value: Boolean);
  protected
    procedure Changed;
    procedure FillChanged(Sender: TObject);
    procedure CaptionChanged(Sender: TObject);
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure GetPosition(var x, y: integer; rectangle: TGPRectF; objectwidth, objectheight: integer; location: TAdvSmoothLabelLocation);
    procedure InitPreview;
    function GetVersionNr: integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Paint; override;
    procedure SetComponentStyle(AStyle: TTMSStyle);    
  published
    property Fill: TGDIPFill read FFill write SetFill;

    property Caption: TAdvSmoothLabelCaption read FCaption write SetCaption;
    property Version: string read GetVersion write SetVersion;
    property Transparent: Boolean read FTransparent write SetTransparent default true;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default false;

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

  TAdvSmoothLabelCaption = class(TPersistent)
  private
    FOwner: TAdvSmoothLabel;
    FGradientType: TAdvGradientType;
    FLocation: TAdvSmoothLabelLocation;
    FPicture: TAdvGDIPPicture;
    FEndColor: TColor;
    FHatchStyle: THatchStyle;
    FFont: TFont;
    FStartOpacity: Byte;
    FText: String;
    FTop: integer;
    FLeft: integer;
    FEndOpacity: Byte;
    FStartColor: TColor;
    FOnChange: TNotifyEvent;
    procedure SetEndColor(const Value: TColor);
    procedure SetEndOpacity(const Value: Byte);
    procedure SetFont(const Value: TFont);
    procedure SetGradientType(const Value: TAdvGradientType);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetLeft(const Value: integer);
    procedure SetLocation(const Value: TAdvSmoothLabelLocation);
    procedure SetPicture(const Value: TAdvGDIPPicture);
    procedure SetStartColor(const Value: TColor);
    procedure SetStartOpacity(const Value: Byte);
    procedure SetText(const Value: String);
    procedure SetTop(const Value: integer);
  protected
    procedure Changed;
    procedure FontChanged(Sender: TObject);
    procedure PictureChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothLabel);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Text: String read FText write SetText;
    property Location: TAdvSmoothLabelLocation read FLocation write SetLocation default plCenterCenter;
    property Font: TFont read FFont write SetFont;
    property Left: integer read FLeft write SetLeft default 0;
    property Top: integer read FTop write SetTop default 0;
    property Picture: TAdvGDIPPicture read FPicture write SetPicture;
    property ColorStart: TColor read FStartColor write SetStartColor default $FFE09F;
    property ColorEnd: TColor read FEndColor write SetEndColor default $754F00;
    property OpacityStart: Byte read FStartOpacity write SetStartOpacity default 255;
    property OpacityEnd: Byte read FEndOpacity write SetEndOpacity default 255;
    property GradientType: TAdvGradientType read FGradientType write SetGradientType default gtVertical;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

procedure TAdvSmoothLabel.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothLabel) then
  begin
    FFill.Assign((Source as TAdvSmoothLabel).Fill);
    FCaption.Assign((Source as TAdvSmoothLabel).Caption);
    FTransparent := (Source as TAdvSmoothLabel).Transparent;
    FWordWrap := (Source as TAdvSmoothLabel).WordWrap;
    Changed;
  end;
end;

procedure TAdvSmoothLabel.CaptionChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothLabel.Changed;
begin
  Invalidate;
end;

constructor TAdvSmoothLabel.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csReplicatable];

  FTransparent := true;
  Width := 280;
  Height := 50;
  FCaption := TAdvSmoothLabelCaption.Create(Self);
  FCaption.OnChange := CaptionChanged;

  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;

  FWordWrap := false;

  if (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState)) then
      InitPreview;
end;

destructor TAdvSmoothLabel.Destroy;
begin
  Fill.Free;
  Caption.Free;
  inherited;
end;

procedure TAdvSmoothLabel.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothLabel.GetPosition(var x, y: integer; rectangle: TGPRectF; objectwidth, objectheight: integer; location: TAdvSmoothLabelLocation);
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

function TAdvSmoothLabel.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvSmoothLabel.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvSmoothLabel.InitPreview;
begin
  FCaption.Text := 'AdvSmoothLabel';
end;

//fix for StreamAdapter with PNG
type
  TFixedStreamAdapter = class(TStreamAdapter)
  public
    function Stat(out statstg: TStatStg; grfStatFlag: Longint): HResult; override; stdcall;
  end;

function TFixedStreamAdapter.Stat(out statstg: TStatStg; grfStatFlag: Integer): HResult;
begin
  Result := inherited Stat(statstg, grfStatFlag);
  statstg.pwcsName := nil;
end;
//fix for StreamAdapter with PNG

procedure TAdvSmoothLabel.Paint;
var
  g: TGPGraphics;
  r: TGPRectF;
  th, tw, x, y: Integer;
  f: TGPFont;
  textb: TGPBrush;
  start, stop: TGPColor;
  stringformat: TGPStringFormat;
  gppointf : TGPPointF;
  xs,ys: single;
  ff: TGPFontFamily;
  fs: integer;
  texth, textw: single;
  sizeRect: TGPRectF;
  gpimg: TGPImage;
  st: TStream;
  sta: TFixedStreamAdapter;
  fl: Integer;
begin
  if ((Self.Width > 1) and (Self.Height > 1)) then
  begin
    g := TGPGraphics.Create(Canvas.Handle);

    r := MakeRect(0, 0, Width - 1, Height - 1);

    if not Transparent then
    begin
      ////Label Rectangle///
      r := Fill.Fill(g, r);
      //////////////////////
    end;

    ////Label Caption///
    if Caption.Text <> '' then
    begin
      ff := TGPFontFamily.Create(Caption.Font.Name);
      if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
      begin
        ff.Free;
        ff := TGPFontFamily.Create('Arial');
      end;

      fs := 0;
      if (fsBold in Caption.Font.Style) then
        fs := fs + 1;
      if (fsItalic in Caption.Font.Style) then
        fs := fs + 2;
      if (fsUnderline in Caption.Font.Style) then
        fs := fs + 4;

      fl := 0;
      if not WordWrap then
        fl := StringFormatFlagsNoWrap;

      stringformat := TGPStringFormat.Create(fl);
      f := TGPFont.Create(ff, Caption.Font.Size , fs, UnitPoint);
      g.MeasureString(Caption.Text, Length(Caption.Text), f, r, stringFormat, sizerect);

      tw := Round(sizerect.Width);
      th := Round(sizerect.Height);

      if Caption.Location <> plCustom then
        GetPosition(x, y, r, tw, th, Caption.Location)
      else
      begin
        x := Caption.Left;
        y := Caption.Top;
      end;

      xs := x;
      ys := y;
      textw := sizeRect.Width;
      texth := sizeRect.Height;
      textb := nil;
      start := MakeColor(Caption.OpacityStart, Caption.ColorStart);
      if Caption.ColorEnd = clNone then
        stop := start
      else
        stop := MakeColor(Caption.OpacityEnd, Caption.ColorEnd);

      gppointf := MakePoint(xs, ys);
      sizeRect.X := gppointf.X;
      sizeRect.Y := gppointf.Y;

      g.SetTextRenderingHint(TextRenderingHintAntiAlias);
      
      case Caption.GradientType of
        gtSolid: textb := TGPSolidBrush.Create(start);
        gtVertical: textb := TGPLinearGradientBrush.Create(MakePoint(xs, ys), MakePoint(xs, ys + texth), start, stop);
        gtHorizontal: textb := TGPLinearGradientBrush.Create(MakePoint(xs, ys), MakePoint(xs + textw, ys), start, stop);
        gtForwardDiagonal: textb := TGPLinearGradientBrush.Create(MakePoint(xs, ys), MakePoint(xs + textw, ys + texth), start, stop);
        gtBackwardDiagonal: textb := TGPLinearGradientBrush.Create(MakePoint(xs, ys + texth), MakePoint(xs + textw, ys), stop, start);
        gtHatch: textb := TGPHatchBrush.Create(Caption.HatchStyle, start, stop);
        gtTexture:
        begin
          if not Caption.Picture.Empty then
          begin
            st := TMemoryStream.Create;
            Caption.Picture.SaveToStream(st);
            sta := TFixedStreamAdapter.Create(st);
            gpimg := TGPImage.Create(sta);
            textb := TGPTextureBrush.Create(gpimg, WrapModeTile);
            g.DrawString(Caption.Text, Length(Caption.Text), f, MakeRect(gppointf.X, gppointf.Y, r.Width - gppointf.X, r.Height - gppointf.Y), stringformat, textb);
            st.free;
            gpimg.free;
          end;
        end;
        gtNone: ;
      end;

      if Caption.GradientType <> gtTexture then
        g.DrawString(Caption.Text, Length(Caption.Text), f, MakeRect(gppointf.X, gppointf.Y, r.Width - gppointf.X, r.Height - gppointf.Y), stringformat, textb);

      if textb <> nil then
        textb.free;

      ff.Free;
      f.Free;
      stringformat.Free;
    end;
    ////////////////////
    g.Free;
  end;
end;

procedure TAdvSmoothLabel.SetCaption(const Value: TAdvSmoothLabelCaption);
begin
  if FCaption <> value then
  begin
    FCaption.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothLabel.SetComponentStyle(AStyle: TTMSStyle);
begin
  // TODO : do color settings here
end;

procedure TAdvSmoothLabel.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothLabel.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabel.SetVersion(const Value: string);
begin

end;

procedure TAdvSmoothLabel.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabel.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  Message.result := 1;
end;

{ TAdvSmoothLabelCaption }

procedure TAdvSmoothLabelCaption.Assign(Source: TPersistent);
begin
  if Source is TAdvSmoothLabelCaption then
  begin
    FLocation := (Source as TAdvSmoothLabelCaption).Location;
    FLeft := (Source as TAdvSmoothLabelCaption).Left;
    FTop := (Source as TAdvSmoothLabelCaption).Top;
    FStartColor := (Source as TAdvSmoothLabelCaption).ColorStart;
    FEndColor := (Source as TAdvSmoothLabelCaption).ColorEnd;
    FGradientType := (Source as TAdvSmoothLabelCaption).GradientType;
    FHatchStyle := (Source as TAdvSmoothLabelCaption).HatchStyle;
    FStartOpacity := (Source as TAdvSmoothLabelCaption).OpacityStart;
    FEndOpacity := (Source as TAdvSmoothLabelCaption).OpacityEnd;
    FPicture.Assign((Source as TAdvSmoothLabelCaption).Picture);
    FText := (Source as TAdvSmoothLabelCaption).Text;
    Changed;
  end;
end;

procedure TAdvSmoothLabelCaption.Changed;
begin
  FOwner.CaptionChanged(Self);
end;

constructor TAdvSmoothLabelCaption.Create(AOwner: TAdvSmoothLabel);
begin
  FOwner := AOwner;
  FLocation := plCenterCenter;
  FFont := TFont.Create;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}  
  FFont.OnChange := FontChanged;
  FStartColor := $FFE09F;
  FEndColor := $754F00;
  FStartOpacity := 255;
  FEndOpacity := 255;
  FFont.Size := 20;
  FGradientType := gtVertical;
  FHatchStyle := HatchStyleHorizontal;
  FPicture := TAdvGDIPPicture.Create;
  FPicture.OnChange := PictureChanged;
end;

destructor TAdvSmoothLabelCaption.Destroy;
begin
  FPicture.Free;
  FFont.Free;
  inherited;
end;

procedure TAdvSmoothLabelCaption.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothLabelCaption.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothLabelCaption.SetEndColor(const Value: TColor);
begin
  if FEndColor <> value then
  begin
    FEndColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabelCaption.SetEndOpacity(const Value: Byte);
begin
  if FEndOpacity <> value  then
  begin
    FEndOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabelCaption.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(Value);
    FontChanged(self);
  end;
end;

procedure TAdvSmoothLabelCaption.SetGradientType(
  const Value: TAdvGradientType);
begin
  if FGradientType <> value then
  begin
    FGradientType := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabelCaption.SetHatchStyle(const Value: THatchStyle);
begin
  if FHatchStyle <> value then
  begin
    FHatchStyle := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabelCaption.SetLeft(const Value: integer);
begin
  if FLeft <> value then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabelCaption.SetLocation(
  const Value: TAdvSmoothLabelLocation);
begin
  if FLocation <> value then
  begin
    FLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabelCaption.SetPicture(
  const Value: TAdvGDIPPicture);
begin
  if FPicture <> value then
  begin
    FPicture.Assign(Value);
    PictureChanged(Self);
  end;
end;

procedure TAdvSmoothLabelCaption.SetStartColor(const Value: TColor);
begin
  if FStartColor <> Value then
  begin
    FStartColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabelCaption.SetStartOpacity(const Value: Byte);
begin
  if FStartOpacity <> value then
  begin
    FStartOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabelCaption.SetText(const Value: String);
begin
  if FText <> value then
  begin
    FText := Value;
    Changed;
  end;
end;

procedure TAdvSmoothLabelCaption.SetTop(const Value: integer);
begin
  if FTop <> value then
  begin
    FTop := Value;
    Changed;
  end;
end;

end.
