{***************************************************************************}
{ GDI+ Fill                                                                 }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2006 - 2008                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

{
WorkAround GDI+ Border issue with LinearGradientBrush

-> MakeRect(r.X - 1, r.Y - 1, r.Width + 2, r.Height + 2)
}

unit GDIPFill;

{$I TMSDEFS.INC}

interface

uses
  Windows, Graphics, Classes, AdvSmoothGDIP, SysUtils, Math, Clipbrd;

type
  TFillPicturePosition = (ppTopLeft,ppTopCenter,ppTopRight,ppBottomLeft,ppBottomCenter,ppBottomRight,ppTiled,ppStretched,ppCenterLeft,ppCenterCenter,ppCenterRight,ppCustom);

  TFillRoundingType = (rtNone, rtTop, rtBottom, rtBoth, rtLeft, rtRight);

  TFillPictureSize = (psOriginal, psCustom);

  TFillPictureMode = (pmInsideFill, pmOutsideFill);

  TGDIPFill = class(TPersistent)
  private
    FBorderColor: TColor;
    FOpacity: Byte;
    FPicturePosition: TFillPicturePosition;
    FGradientType: TAdvGradientType;
    FOpacityTo: Byte;
    FPicture: TAdvGDIPPicture;
    FHatchStyle: THatchStyle;
    FColor: TColor;
    FShadowOffset: integer;
    FOpacityMirror: Byte;
    FGradientMirrorType: TAdvGradientType;
    FOpacityMirrorTo: Byte;
    FRounding: integer;
    FShadowColor: TColor;
    FBorderWidth: integer;
    FColorMirror: TColor;
    FColorMirrorTo: TColor;
    FColorTo: TColor;
    FOnChange: TNotifyEvent;
    FHatchStyleMirror: THatchStyle;
    FPictureTop: integer;
    FPictureLeft: integer;
    FBackGroundPictureTop: integer;
    FBackGroundPictureLeft: integer;
    FBackGroundPicturePosition: TFillPicturePosition;
    FBackGroundPicture: TAdvGDIPPicture;
    FpictureWidth: integer;
    FpictureSize: TFillPictureSize;
    FpictureHeight: integer;
    FRoundingType: TFillRoundingType;
    FUpdateCount: integer;
    FFocus: Boolean;
    FFocusColor: TColor;
    FAngle: integer;
    FBorderOpacity: Byte;
    FFocusRect: TGPRectF;
    FBackGroundPictureMode: TFillPictureMode;
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderWidth(const Value: integer);
    procedure SetColor(const Value: TColor);
    procedure SetColorMirror(const Value: TColor);
    procedure SetColorMirrorTo(const Value: TColor);
    procedure SetColorTo(const Value: TColor);
    procedure SetGradientMirrorType(const Value: TAdvGradientType);
    procedure SetGradientType(const Value: TAdvGradientType);
    procedure SetHatchStyle(const Value: THatchStyle);
    procedure SetOpacity(const Value: Byte);
    procedure SetOpacityMirror(const Value: Byte);
    procedure SetOpacityMirrorTo(const Value: Byte);
    procedure SetOpacityTo(const Value: Byte);
    procedure SetPicture(const Value: TAdvGDIPPicture);
    procedure SetPicturePosition(const Value: TFillPicturePosition);
    procedure SetRounding(const Value: integer);
    procedure SetShadowColor(const Value: TColor);
    procedure SetShadowOffset(const Value: integer);
    procedure SetHatchStyleMirror(const Value: THatchStyle);
    procedure SetPictureLeft(const Value: integer);
    procedure SetPictureTop(const Value: integer);
    procedure SetBackGroundPicture(const Value: TAdvGDIPPicture);
    procedure SetBackGroundPictureLeft(const Value: integer);
    procedure SetBackGroundPicturePosition(const Value: TFillPicturePosition);
    procedure SetBackGroundPictureTop(const Value: integer);
    procedure SetPictureHeight(const Value: integer);
    procedure SetPictureSize(const Value: TFillPictureSize);
    procedure SetPictureWidth(const Value: integer);
    procedure SetRoundingType(const Value: TFillRoundingType);
    procedure SetFocus(const Value: Boolean);
    procedure SetFocusColor(const Value: TColor);
    procedure SetAngle(const Value: integer);
    procedure SetBorderOpacity(const Value: Byte);
    procedure SetBackGroundPictureMode(const Value: TFillPictureMode);
  protected
    procedure Changed;
    procedure PictureChanged(Sender: TObject);
    procedure DrawGradientBackGround(Graphics: TGPGraphics; R: TGPRectF; Mirror: Boolean; oc, octo, ocmr, ocmrto: Byte);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Fill(Graphics: TGPGraphics; R: TGPRectF; ABorderOpacity: Byte = 255; AOpacity: Byte = 255; AOpacityTo: Byte = 255; AOpacityMirror: Byte = 255; AOpacityMirrorTo: Byte = 255): TGPRectF;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure SaveToClipBoard;
    procedure LoadFromClipBoard;
    property Focus: Boolean read FFocus write SetFocus default false;
    property FocusColor: TColor read FFocusColor write SetFocusColor default clBlack;
    property FocusRect: TGPRectF read FFocusRect write FFocusRect;
  published
    property Color: TColor read FColor write SetColor default clSilver;
    property ColorTo: TColor read FColorTo write SetColorTo default clGray;
    property ColorMirror: TColor read FColorMirror write SetColorMirror;
    property ColorMirrorTo: TColor read FColorMirrorTo write SetColorMirrorTo;
    property GradientType: TAdvGradientType read FGradientType write SetGradientType default gtVertical;
    property GradientMirrorType: TAdvGradientType read FGradientMirrorType write SetGradientMirrorType default gtSolid;
    property HatchStyle: THatchStyle read FHatchStyle write SetHatchStyle default HatchStyleHorizontal;
    property HatchStyleMirror: THatchStyle read FHatchStyleMirror write SetHatchStyleMirror default HatchStyleHorizontal;
    property BackGroundPictureMode: TFillPictureMode read FBackGroundPictureMode write SetBackGroundPictureMode default pmOutsideFill;
    property BackGroundPicture: TAdvGDIPPicture read FBackGroundPicture write SetBackGroundPicture;
    property BackGroundPicturePosition: TFillPicturePosition read FBackGroundPicturePosition write SetBackGroundPicturePosition default ppTopLeft;
    property BackGroundPictureLeft: integer read FBackGroundPictureLeft write SetBackGroundPictureLeft;
    property BackGroundPictureTop: integer read FBackGroundPictureTop write SetBackGroundPictureTop;
    property Picture: TAdvGDIPPicture read FPicture write SetPicture;
    property PicturePosition: TFillPicturePosition read FPicturePosition write SetPicturePosition default ppTopLeft;
    property PictureLeft: integer read FPictureLeft write SetPictureLeft;
    property PictureTop: integer read FPictureTop write SetPictureTop;
    property PictureSize: TFillPictureSize read FpictureSize write SetPictureSize default psOriginal;
    property PictureWidth: integer read FpictureWidth write SetPictureWidth default 50;
    property PictureHeight: integer read FpictureHeight write SetPictureHeight default 50;
    property Opacity: Byte read FOpacity write SetOpacity default 255;
    property OpacityTo: Byte read FOpacityTo write SetOpacityTo default 255;
    property OpacityMirror: Byte read FOpacityMirror write SetOpacityMirror default 255;
    property OpacityMirrorTo: Byte read FOpacityMirrorTo write SetOpacityMirrorTo default 255;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property BorderOpacity: Byte read FBorderOpacity write SetBorderOpacity default 255;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 1;
    property Rounding: integer read FRounding write SetRounding;
    property RoundingType: TFillRoundingType read FRoundingType write SetRoundingType default rtBoth;
    property ShadowColor: TColor read FShadowColor write SetShadowColor default clGray;
    property ShadowOffset: integer read FShadowOffset write SetShadowOffset;
    property Angle: integer read FAngle write SetAngle;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TGDIPButtonLayout = (blPictureLeft, blPictureRight, blPictureBottom, blPictureTop);

  TGDIPButton = class(TPersistent)
  private
    FUpdateCount: integer;
    FFont: TFont;
    FOnChange: TNotifyEvent;
    FLayout: TGDIPButtonLayout;
    FSpacing: integer;
    procedure SetFont(const Value: TFont);
    procedure SetLayout(const Value: TGDIPButtonLayout);
    procedure SetSpacing(const Value: integer);
  protected
    procedure FontChanged(Sender: TObject);
    procedure Changed;
  public
    procedure BeginUpdate;
    procedure EndUpdate;
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(g: TGPGraphics; Caption: String; x, y, Width, Height, VerticalSpacing,
      HorizontalSpacing: integer; Color, ColorDown, BevelColor: TColor; Shadow, Down, Bevel, VerticalText, RightToLeft: Boolean;
      RoundingType: TFillRoundingType; Picture: TAdvGDIPPicture; TextW, TextH: integer; WW: boolean);
  published
    property Font: TFont read FFont write SetFont;
    property Layout: TGDIPButtonLayout read FLayout write SetLayout default blPictureLeft;
    property Spacing: integer read FSpacing write SetSpacing default 3;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TGDIPDialogButton = class(TPersistent)
  private
    FFont: TFont;
    FOnChange: TNotifyEvent;
    FLayout: TGDIPButtonLayout;
    FSpacing: integer;
    procedure SetFont(const Value: TFont);
    procedure SetLayout(const Value: TGDIPButtonLayout);
    procedure SetSpacing(const Value: integer);
  protected
    procedure FontChanged(Sender: TObject);
    procedure Changed;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(g: TGPGraphics; Caption: String; x, y, Width, Height: integer; Color, BorderColor: TColor;
      BorderWidth: integer; BorderOpacity, Opacity: Byte; Border, Down: Boolean; Picture: TAdvGDIPPicture; WW: boolean);
  published
    property Font: TFont read FFont write SetFont;
    property Layout: TGDIPButtonLayout read FLayout write SetLayout default blPictureLeft;
    property Spacing: integer read FSpacing write SetSpacing default 3;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TGDIPStatus = class(TPersistent)
  private
    FWidth, FHeight: integer;
    FFill: TGDIPFill;
    FFont: TFont;
    FOnChange: TNotifyEvent;
    FAutoSize: Boolean;
    FSpacing: integer;
    FGlow: Boolean;
    procedure SetFill(const Value: TGDIPFill);
    procedure SetFont(const Value: TFont);
    procedure SetSpacing(const Value: integer);
    procedure SetGlow(const Value: Boolean);
  protected
    procedure FillChanged(Sender: TObject);
    procedure FontChanged(Sender: TObject);
    procedure Changed;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(g: TGPGraphics; x, y, Width, Height: integer; AutoSize: boolean; Caption: String);
    function GetWidth: integer;
    function GetHeight: integer;
    procedure CalculateSize(g: TGPGraphics; Caption: String);    
  published
    property Fill: TGDIPFill read FFill write SetFill;
    property Font: TFont read FFont write SetFont;
    property OnChange: TNotifyEvent read  FOnChange write FOnChange;
    property Spacing: integer read FSpacing write SetSpacing;
    property Glow: Boolean read FGlow write SetGlow default true;
  end;

  TGDIPProgressValueType = (vtPercentage, vtAbsolute);

  TGDIPProgressValuePosition = (vpProgressCenter, vpProgressRight, vpCenter, vpLeft, vpRight, vpCustom);

  TGDIPProgress = class(TPersistent)
  private
    FBackGroundFill: TGDIPFill;
    FValueFormat: String;
    FValueType: TGDIPProgressValueType;
    FProgressFill: TGDIPFill;
    FValuePositionTop: integer;
    FValuePositionLeft: integer;
    FFont: TFont;
    FValuePosition: TGDIPProgressValuePosition;
    FOnChange: TNotifyEvent;
    FValueVisible: Boolean;
    FProgressFont: TFont;
    FTransparent: Boolean;
    procedure SetBackGroundFill(const Value: TGDIPFill);
    procedure SetFont(const Value: TFont);
    procedure SetProgressFill(const Value: TGDIPFill);
    procedure SetValueFormat(const Value: String);
    procedure SetValuePosition(const Value: TGDIPProgressValuePosition);
    procedure SetValuePositionLeft(const Value: integer);
    procedure SetValuePositionTop(const Value: integer);
    procedure SetValueType(const Value: TGDIPProgressValueType);
    procedure SetValueVisible(const Value: Boolean);
    procedure SetProgressFont(const Value: TFont);
    procedure SetTransparent(const Value: Boolean);
  protected
    procedure FontChanged(Sender: TObject);
    procedure FillChanged(Sender: TObject);
    procedure Changed;
    procedure DrawBackGround(g: TGPGraphics; r: TGPRectF);
    procedure DrawShadows(g: TGPGraphics; r: TGPRectF);
    procedure DrawValue(g: TGPGraphics; r: TRect; min, max, position: double);
    procedure DrawProgress(g: TGPGraphics; r: TRect; min, max, position: Double);
    procedure DrawOverLay(g: TGPGraphics; r: TRect);
    procedure DrawGlow(g: TGPGRaphics; r: TRect; glowposition, min, max, position: Double);
    function InsideRect(r: TRect): TRect;
    procedure GetTextSize(g: TGPGraphics; r: TRect; s: String; ft: TFont; var sizer: TGPRectF);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(g: TGPGraphics; r: TRect; min, max, position: Double);
    function GetInsideRectF(r: TRect): TGPRectF;
    function CalculateProgressRectangle(r: TRect; min, max, pos: Double): TGPRectF;
  published
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property BackGroundFill: TGDIPFill read FBackGroundFill write SetBackGroundFill;
    property ProgressFill: TGDIPFill read FProgressFill write SetProgressFill;
    property Font: TFont read FFont write SetFont;
    property ProgressFont: TFont read FProgressFont write SetProgressFont;
    property ValueFormat: String read FValueFormat write SetValueFormat;
    property ValueType: TGDIPProgressValueType read FValueType write SetValueType default vtAbsolute;
    property ValuePosition: TGDIPProgressValuePosition read FValuePosition write SetValuePosition default vpCenter;
    property ValuePositionLeft: integer read FValuePositionLeft write SetValuePositionLeft default 0;
    property ValuePositionTop: integer read FValuePositionTop write SetValuePositionTop default 0;
    property ValueVisible: Boolean read FValueVisible write SetValueVisible default false;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

var
  CF_GDIPFILL: Word;

implementation

type
  TSaver = class(TComponent)
private
  FSaveObject: TPersistent;
published
  property SaveObject: TPersistent read FSaveObject write FSaveObject;
end;

procedure SaveObject(AStream: TStream; AObject: TPersistent);
var
  ASaver: TSaver;
begin
  Assert(Assigned(AObject));
  ASaver := TSaver.Create(nil);
  try
    ASaver.SaveObject := AObject;
    AStream.WriteComponent(ASaver);
  finally
    ASaver.Free;
  end;
end;

procedure LoadObject(AStream: TStream; AObject: TPersistent);
var
  ASaver: TSaver;
begin
  Assert(Assigned(AObject));
  ASaver := TSaver.Create(nil);
  try
    ASaver.SaveObject := AObject;
    AStream.ReadComponent(ASaver);
  finally
    ASaver.Free;
  end;
end;

procedure Load(var f: TGDIPFill);
var
  hbuf    : THandle;
  bufptr  : Pointer;
  mstream : TMemoryStream;
begin
  hbuf := ClipBoard.GetAsHandle(CF_GDIPFILL);
  if hbuf <> 0 then begin
    bufptr := GlobalLock(hbuf);
    if bufptr <> nil then begin
      try
        mstream := TMemoryStream.Create;
        try
          mstream.WriteBuffer(bufptr^, GlobalSize(hbuf));
          mstream.Position := 0;
          LoadObject(mstream, f);
        finally
          mstream.Free;
        end;
      finally
        GlobalUnlock(hbuf);
      end;
    end;
  end;
end; 

procedure Save(f: TGDIPFill);
var
  hbuf    : THandle;
  bufptr  : Pointer;
  mstream : TMemoryStream;
begin
  mstream := TMemoryStream.Create;
  try
    SaveObject(mstream, f);
    hbuf := GlobalAlloc(GMEM_MOVEABLE, mstream.size);
    try
      bufptr := GlobalLock(hbuf);
      try
        Move(mstream.Memory^, bufptr^, mstream.size);
        Clipboard.SetAsHandle(CF_GDIPFILL, hbuf);
      finally
        GlobalUnlock(hbuf);
      end;
    except
      GlobalFree(hbuf);
      raise;
    end;
  finally
    mstream.Free;
  end;
end;

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

procedure TGDIPFill.DrawGradientBackGround(Graphics: TGPGraphics; R: TGPRectF; Mirror: Boolean; oc, octo, ocmr, ocmrto: Byte);
var
  path: TGPGraphicsPath;
  par: TGDIPFillParameters;
  gt: TAdvGradientType;
  c, ct: TColor;
  o, ot: Byte;
  ht: THatchStyle;
  smt: TSmoothingMode;
begin
  path := nil;

  if Mirror then
  begin
    gt := FGradientMirrorType;
    c := FColorMirror;
    ct := FColorMirrorTo;
    o := ocmr;
    ot := ocmrto;
    ht := HatchStyleMirror;
  end
  else
  begin
    gt := FGradientType;
    c := FColor;
    ct := FColorTo;
    o := oc;
    ot := octo;
    ht := HatchStyle;
  end;

  if c = clNone then
    gt := gtNone;

  if (ct = clNone) and (c <> clNone) then
    gt := gtSolid;

  par.Graphics := Graphics;

  if Rounding = 0 then
  begin
    par.Path := nil;
    par.Fillpath := false;
  end
  else
  begin
    if (FColorMirror <> clNone) then
    begin
      if Mirror then
      begin
        case RoundingType of
          rtNone: path := CreateRoundRectangle(r, Rounding, rtNone, Mirror);
          rtTop: path := CreateRoundRectangle(r, Rounding, rtNone, Mirror);
          rtBoth, rtBottom: path := CreateRoundRectangle(r, Rounding, rtBottom, Mirror);
          rtRight: path := CreateRoundRectangle(r, Rounding, rtRight, Mirror);
          rtLeft: path := CreateRoundRectangle(r, Rounding, rtLeft, Mirror);
        end;
      end
      else
      begin
        case RoundingType of
          rtNone: path := CreateRoundRectangle(r, Rounding, rtNone, Mirror);
          rtBoth, rtTop: path := CreateRoundRectangle(r, Rounding, rtTop, Mirror);
          rtBottom: path := CreateRoundRectangle(r, Rounding, rtNone, Mirror);
          rtRight: path := CreateRoundRectangle(r, Rounding, rtRight, Mirror);
          rtLeft: path := CreateRoundRectangle(r, Rounding, rtLeft, Mirror);
        end;
      end;
    end
    else
      path := CreateRoundRectangle(r, Rounding, RoundingType, Mirror);

    par.Path := path;
    par.Fillpath := true;
  end;

  par.R := r;
  par.GT := gt;
  par.Angle := FAngle;
  par.ColorFrom := c;
  par.ColorTo := ct;
  par.OpacityFrom := o;
  par.OpacityTo := ot;
  par.HatchStyle := ht;
  par.BorderColor := clNone;
  par.BorderWidth := 0;
  par.BorderStyle := DashStyleSolid;
  par.Mirror := Mirror;

  if (FBackGroundPicturePosition = ppTiled) then
    par.Image := FBackGroundPicture
  else
    par.Image := nil;

  smt := Graphics.GetSmoothingMode;

  if par.Fillpath then
    Graphics.SetSmoothingMode(SmoothingModeAntiAlias);

  FillGDIP(par);

  if par.Fillpath then
    Graphics.SetSmoothingMode(smt);

  if path <> nil then
    path.Free;
end;

procedure TGDIPFill.EndUpdate;
begin
  if (FUpdateCount > 0) then
  begin
    dec(FUpdateCount);
  end;
end;

procedure DrawRadialBackGround(Graphics: TGPGraphics; R: TGPRectF; CF,CT: TColor; o, ot: Byte; Upper: boolean;
  Radius: integer; RoundingType: TFillRoundingType);
var
  path: TGPGraphicsPath;
  pthGrBrush: TGPPathGradientBrush;
  solGrBrush: TGPSolidBrush;

  w,h,w2,h2: Double;
  colors : array[0..0] of TGPColor;
  count: Integer;
  rgn: TGPRegion;
begin
  w := r.Width;
  h := r.Height;

  h2 := h / 2;
  w2 := w / 2;

  if Upper then
    solGrBrush := TGPSolidBrush.Create(MakeColor(o, CF))
  else
    solGrBrush := TGPSolidBrush.Create(MakeColor(ot, CT));

  path := CreateRoundRectangle(r, Radius, RoundingType, false);
  Graphics.FillPath(solgrBrush, path);

  rgn := TGPRegion.Create(path);
  path.free;
  graphics.SetClip(rgn);

//  Graphics.FillRectangle(solGrBrush, r);

  solGrBrush.Free;

  // Create a path that consists of a single ellipse.
  path := TGPGraphicsPath.Create;

  if Upper then        // take borders in account
    path.AddEllipse(r.X, r.Y - h2, r.Width , r.Height + h2)
  else
    path.AddEllipse(r.X, r.Y, r.Width , r.Height + h2);

  pthGrBrush := TGPPathGradientBrush.Create(path);


  if Upper then
    pthGrBrush.SetCenterPoint(MakePoint(r.X + w2, r.Y))
  else
    pthGrBrush.SetCenterPoint(MakePoint(r.X + w2, r.Y + R.Height));

  // Set the color at the center point to blue.
  if Upper then
  begin
    pthGrBrush.SetCenterColor(MakeColor(ot, CT));
    colors[0] := MakeColor(o, CF);
  end
  else
  begin
    pthGrBrush.SetCenterColor(MakeColor(o, CF));
    colors[0] := MakeColor(ot, CT);
  end;

  count := 1;
  pthGrBrush.SetSurroundColors(@colors, count);
  graphics.FillRectangle(pthGrBrush, r);
  pthGrBrush.Free;

  path.Free;
  rgn.free;
  Graphics.ResetClip;
end;

procedure DrawPicture(g: TGPGraphics; picture: TAdvGDIPPicture; location: TFillPicturePosition; w, h: integer; r: TRect; x, y: integer);
begin
  if not picture.Empty then
  begin
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

function TGDIPFill.Fill(Graphics: TGPGraphics; R: TGPRectF; ABorderOpacity: Byte = 255; AOpacity: Byte = 255; AOpacityTo: Byte = 255; AOpacityMirror: Byte = 255; AOpacityMirrorTo: Byte = 255): TGPRectF;
var
  path, pathshadow, pathfocus, pathborder: TGPGraphicsPath;
  rnonmirror, rmirror: TGPRectF;
  gBrush: TGPPathGradientBrush;
  cb: array[0..2] of TGPColor;
  pb: array[0..2] of single;
  h, h2: Double;
  c, ct: integer;
  pw, ph: integer;
  ocbdr, oc, octo, ocmr, ocmrto: Byte;
  pfocus, pBorder: TGPPen;
  rc: TRect;
  rgn: TGPRegion;
  imgr: TGPRectF;
begin
  if AOpacity < 255 then
    oc := AOpacity
  else
    oc := Opacity;

  if AOpacityTo < 255 then
    octo := AOpacityTo
  else
    octo := OpacityTo;

  if AOpacityMirror < 255 then
    ocmr := AOpacityMirror
  else
    ocmr := OpacityMirror;

  if AOpacityMirrorTo < 255 then
    ocmrto := AOpacityMirrorTo
  else
    ocmrto := OpacityMirrorTo;

  if ABorderOpacity < 255 then
    ocbdr := ABorderOpacity
  else
    ocbdr := BorderOpacity;

  if (R.Height <> 1) and (R.Width <> 1) then
  begin
    if Graphics = nil then
      Exit;

    path := nil;

    if (ShadowOffset > 0) and (ShadowColor <> clNone) then
    begin
      pathshadow := CreateRoundRectangle(r, Rounding, RoundingType, true);
      gBrush := TGPPathGradientBrush.Create(pathshadow);
      gBrush.SetWrapMode(WrapModeClamp);

      cb[0] := MakeColor(0,0,0,0);
      cb[1] := MakeColor(180, ShadowColor);
      cb[2] := MakeColor(180, ShadowColor);

      pb[0] := 0;
      pb[1] := 0.1;
      pb[2] := 1;

      gBrush.SetInterpolationColors(@cb, @pb, 3);

      Graphics.FillPath(gbrush, pathshadow);
      pathshadow.Free;
      gBrush.Free;

      R.Width := R.Width - ShadowOffset;
      R.Height := R.Height - ShadowOffset;
    end;

    if (FGradientType <> gtHatch) and (FGradientType <> gtTexture) and (FColorMirror <> clNone) then
    begin
      h := r.Height;

      h2 := h / 2;

      rnonmirror := MakeRect(r.X, R.Y, R.Width, R.Height - h2 + 1);

      //rnonmirror := MakeRect(r.X, R.Y, R.Width, h2);
      if FGradientType = gtRadial then
      begin
        if Color <> clNone then
        begin
          c := Color;
          ct := ColorTo;
          if ColorTo = clNone then
          begin
            ct := c;
          end;
          DrawRadialBackGround(Graphics, rnonmirror, c, ct, oc, octo, true, Rounding, rtTop)
        end
      end
      else
        DrawGradientBackGround(Graphics, rnonmirror, false, oc, octo, ocmr, ocmrto);


      rmirror := MakeRect(r.X, r.Y + h2 - 1, r.Width, r.Height - h2 + 1);

      //rmirror := MakeRect(r.X, r.Y + h2 , r.Width, h2);

      if GradientMirrorType = gtRadial then
      begin
        if ColorMirror <> clNone then
        begin
          c := ColorMirror;
          ct := ColorMirrorTo;
          if ColorMirrorTo = clNone then
          begin
            ct := c;
          end;
          DrawRadialBackGround(Graphics, rmirror, c, ct, ocmr, ocmrto, false, Rounding, rtBottom)
        end;
      end
      else
        DrawGradientBackGround(Graphics, rmirror, true, oc, octo, ocmr, ocmrto);
    end
    else
    begin
      if FGradientType = gtRadial then
      begin
        if Color <> clNone then
        begin
          c := Color;
          ct := ColorTo;
          if ColorTo = clNone then
          begin
            ct := c;
          end;
          DrawRadialBackGround(Graphics, r, c, ct, oc, octo, true, Rounding, RoundingType)
        end
      end
      else
        DrawGradientBackGround(Graphics, r, false, oc, octo, ocmr, ocmrto);
    end;

    if path <> nil then
      path.Free;

    if BackGroundPictureMode = pmInsideFill then
    begin
      pw := 0;
      ph := 0;
      if not BackGroundPicture.Empty then
      begin
        BackGroundPicture.GetImageSizes;
        pw := BackGroundPicture.Width;
        ph := BackGroundPicture.Height;
      end;


      rc := Bounds(Round(r.X), Round(r.Y), Round(r.Width), Round(r.Height));

      if (FGradientType = gtTexture) then
      begin
        path := nil;
        rgn := nil;
        if BackGroundPictureMode = pmInsideFill then
        begin
          imgr := r;
          path := CreateRoundRectangle(imgr, Rounding, RoundingType, false);
          rgn := TGPRegion.Create(path);
          graphics.SetClip(rgn);
        end;

        if BackGroundPicturePosition <> ppCustom then
          DrawPicture(Graphics, BackGroundPicture, FBackGroundPicturePosition, pw, ph, rc,  rc.Left, rc.Top)
        else
          DrawPicture(Graphics, BackGroundPicture, FBackGroundPicturePosition, pw, ph, rc,  BackGroundPictureLeft, BackGroundPictureTop);

        if BackGroundPictureMode = pmInsideFill then
        begin
          graphics.ResetClip;
          if rgn <> nil then
            rgn.Free;

          if path <> nil then
          path.Free;
        end;
      end;
    end;

    if (BorderWidth > 0) and (BorderColor <> clNone) then
    begin
      pathborder := CreateRoundRectangle(r, Rounding, RoundingType, false);
      pBorder := TGPPen.Create(MakeColor(ocbdr, BorderColor), BorderWidth);
      pBorder.SetDashStyle(DashStyleSolid);
      Graphics.DrawPath(pBorder, pathborder);
      pBorder.Free;
      pathborder.Free;
    end;
  end
  else
  begin
    if (BorderWidth > 0) and (BorderColor <> clNone) then
    begin
      pBorder := TGPPen.Create(MakeColor(ocbdr, BorderColor), BorderWidth);
      Graphics.DrawLine(pBorder, r.X, r.Y, r.X + R.Width, r.Y + R.Height);
      pBorder.Free;
    end;
  end;

  FFocusRect := MakeRect(R.X + BorderWidth, R.Y + BorderWidth, R.Width - (BorderWidth * 2), R.Height - (BorderWidth * 2));
  if focus then
  begin
    pathfocus := CreateRoundRectangle(FFocusRect, Rounding - BorderWidth, RoundingType, false);
    graphics.SetSmoothingMode(SmoothingModeDefault);
    pfocus := TGPPen.Create(MakeColor(oc, focuscolor), 1);
    pfocus.SetDashStyle(DashStyleDot);
    Graphics.DrawPath(pfocus, pathfocus);
    pfocus.Free;
    pathfocus.Free;
  end;

  if BackGroundPictureMode = pmOutsideFill then
  begin
    pw := 0;
    ph := 0;
    if not BackGroundPicture.Empty then
    begin
      BackGroundPicture.GetImageSizes;
      pw := BackGroundPicture.Width;
      ph := BackGroundPicture.Height;
    end;


    rc := Bounds(Round(r.X), Round(r.Y), Round(r.Width), Round(r.Height));

    if (FGradientType = gtTexture) then
    begin
      if BackGroundPicturePosition <> ppCustom then
        DrawPicture(Graphics, BackGroundPicture, FBackGroundPicturePosition, pw, ph, rc,  rc.Left, rc.Top)
      else
        DrawPicture(Graphics, BackGroundPicture, FBackGroundPicturePosition, pw, ph, rc,  BackGroundPictureLeft, BackGroundPictureTop);
    end;
  end;

  pw := 0;
  ph := 0;
  if not picture.Empty then
  begin
    picture.GetImageSizes;
    case FPictureSize of
      psOriginal:
      begin
        pw := Picture.Width;
        ph := Picture.Height;
      end;
      psCustom:
      begin
        pw := FPictureWidth;
        ph := FPictureHeight;
      end;
    end;
  end;

  if FPicturePosition <> ppCustom then
    DrawPicture(Graphics, Picture, FPicturePosition, pw, ph,  rc,  rc.Left, rc.Top)
  else
    DrawPicture(Graphics, Picture, FPicturePosition, pw, ph, rc,  PictureLeft, PictureTop);

  Result := R;
end;


procedure TGDIPFill.LoadFromClipBoard;
begin
  Load(Self);
end;

procedure TGDIPFill.PictureChanged(Sender: TObject);
begin
  Changed;
end;

{ TGDIPFill }


procedure TGDIPFill.Assign(Source: TPersistent);
begin
  Color := (Source as TGDIPFill).Color;
  ColorTo := (Source as TGDIPFill).ColorTo;
  ColorMirror := (Source as TGDIPFill).ColorMirror;
  ColorMirrorTo := (Source as TGDIPFill).ColorMirrorTo;
  GradientType := (Source as TGDIPFill).GradientType;
  GradientMirrorType := (Source as TGDIPFill).GradientMirrorType;
  HatchStyle := (Source as TGDIPFill).HatchStyle;
  HatchStyleMirror := (Source as TGDIPFill).HatchStyleMirror;
  BackGroundPicture.Assign((Source as TGDIPFill).BackGroundPicture);
  BackGroundPicturePosition := (Source as TGDIPFill).BackGroundPicturePosition;
  BackGroundPictureLeft := (Source as TGDIPFill).BackGroundPictureLeft;
  BackGroundPictureTop := (Source as TGDIPFill).BackGroundPictureTop;
  Picture.Assign((Source as TGDIPFill).Picture);
  PicturePosition := (Source as TGDIPFill).PicturePosition;
  PictureLeft := (Source as TGDIPFill).PictureLeft;
  PictureTop := (Source as TGDIPFill).PictureTop;
  PictureSize := (Source as TGDIPFill).PictureSize;
  PictureWidth := (Source as TGDIPFill).PictureWidth;
  PictureHeight := (Source as TGDIPFill).PictureHeight;
  Opacity := (Source as TGDIPFill).Opacity;
  OpacityTo := (Source as TGDIPFill).OpacityTo;
  OpacityMirror := (Source as TGDIPFill).OpacityMirror;
  OpacityMirrorTo := (Source as TGDIPFill).OpacityMirrorTo;
  BorderColor := (Source as TGDIPFill).BorderColor;
  BorderWidth := (Source as TGDIPFill).BorderWidth;
  Rounding := (Source as TGDIPFill).Rounding;
  RoundingType := (Source as TGDIPFill).RoundingType;
  ShadowColor := (Source as TGDIPFill).ShadowColor;
  ShadowOffset := (Source as TGDIPFill).ShadowOffset;
  Angle := (Source as TGDIPFill).Angle;
  BorderOpacity := (Source as TGDIPFill).BorderOpacity;
  BackGroundPictureMode := (Source as TGDIPFill).BackGroundPictureMode;
end;

procedure TGDIPFill.BeginUpdate;
begin
  inc(FUpdateCount);
end;

procedure TGDIPFill.Changed;
begin
  if Assigned(FOnChange) and (FUpdateCount = 0) then
    FOnChange(Self);
end;

constructor TGDIPFill.Create;
begin
  FUpdateCount := 0;
  FBorderOpacity := 255;
  FAngle := 0;
  FFocus := false;
  FFocusColor := clBlack;
  FPictureSize := psOriginal;
  FPictureWidth := 50;
  FPictureHeight := 50;
  FBackGroundPictureTop := 0;
  FBackGroundPictureLeft := 0;
  FBackGroundPicturePosition := ppTopLeft;
  FBackGroundPicture := TAdvGDIPPicture.Create;
  FBackGroundPicture.OnChange := PictureChanged;
  FPictureTop := 0;
  FPictureLeft := 0;
  FColor := clSilver;
  FColorTo := clGray;
  FColorMirror := clNone;
  FColorMirrorTo := clNone;
  FGradientType := gtVertical;
  FGradientMirrorType := gtSolid;
  FHatchStyle := HatchStyleHorizontal;
  FPicture := TAdvGDIPPicture.Create;
  FPicture.OnChange := PictureChanged;
  FPicturePosition := ppTopLeft;
  FOpacity := 255;
  FOpacityTo := 255;
  FOpacityMirror := 255;
  FOpacityMirrorTo := 255;
  FBorderColor := clNone;
  FBorderWidth := 1;
  FRounding := 0;
  FRoundingType := rtBoth;
  FShadowColor := clGray;
  FShadowOffset := 0;
  FBackGroundPictureMode := pmOutsideFill;
end;

destructor TGDIPFill.Destroy;
begin
  Picture.Free;
  BackGroundPicture.Free;
  inherited;
end;

procedure TGDIPFill.SaveToClipBoard;
begin
  Save(Self);
end;

procedure TGDIPFill.SetAngle(const Value: integer);
begin
  if FAngle <> value then
  begin
    FAngle := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetBackGroundPicture(const Value: TAdvGDIPPicture);
begin
  if FBackGroundPicture <> value then
  begin
    FBackGroundPicture.Assign(value);
    Changed;
  end;
end;

procedure TGDIPFill.SetBackGroundPictureLeft(const Value: integer);
begin
  if FBackGroundPictureLeft <> value then
  begin
    FBackGroundPictureLeft := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetBackGroundPictureMode(const Value: TFillPictureMode);
begin
  if FBackGroundPictureMode <> Value then
  begin
    FBackGroundPictureMode := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetBackGroundPicturePosition(const Value: TFillPicturePosition);
begin
  if FBackGroundPicturePosition <> value then
  begin
    FBackGroundPicturePosition := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetBackGroundPictureTop(const Value: integer);
begin
  if FBackGroundPictureTop <> value then
  begin
    FBackGroundPictureTop := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetBorderOpacity(const Value: Byte);
begin
  if FBorderOpacity <> value then
  begin
    FBorderOpacity := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetBorderWidth(const Value: integer);
begin
  if FBorderWidth <> value then
  begin
    FBorderWidth := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetColor(const Value: TColor);
begin
  if FColor <> value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetColorMirror(const Value: TColor);
begin
  if FColorMirror <> value then
  begin
    FColorMirror := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetColorMirrorTo(const Value: TColor);
begin
  if FColorMirrorTo <> value then
  begin
    FColorMirrorTo := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetColorTo(const Value: TColor);
begin
  if FColorTo <> value then
  begin
    FColorTo := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetFocus(const Value: Boolean);
begin
  if FFocus <> value then
  begin
    FFocus := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetFocusColor(const Value: TColor);
begin
  if FFocusColor <> value then
  begin
    FFocusColor := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetGradientMirrorType(const Value: TAdvGradientType);
begin
  if FGradientMirrorType <> value then
  begin
    FGradientMirrorType := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetGradientType(const Value: TAdvGradientType);
begin
  if FGradientType <> value then
  begin
    FGradientType := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetHatchStyle(const Value: THatchStyle);
begin
  if FHatchStyle <> value then
  begin
    FHatchStyle := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetHatchStyleMirror(const Value: THatchStyle);
begin
  if FHatchStyleMirror <> value then
  begin
    FHatchStyleMirror := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetOpacity(const Value: Byte);
begin
  if FOpacity <> value then
  begin
    FOpacity := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetOpacityMirror(const Value: Byte);
begin
  if FOpacityMirror <> value then
  begin
    FOpacityMirror := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetOpacityMirrorTo(const Value: Byte);
begin
  if FOpacityMirrorTo <> value then
  begin
    FOpacityMirrorTo := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetOpacityTo(const Value: Byte);
begin
  if FOpacityTo <> value then
  begin
    FOpacityTo := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetPicture(const Value: TAdvGDIPPicture);
begin
  if FPicture <> value then
  begin
    FPicture.Assign(value);
    PictureChanged(Self);
  end;
end;

procedure TGDIPFill.SetPictureHeight(const Value: integer);
begin
  if FpictureHeight <> value then
  begin
    FpictureHeight := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetPictureLeft(const Value: integer);
begin
  if FPictureLeft <> value then
  begin
    FPictureLeft := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetPicturePosition(const Value: TFillPicturePosition);
begin
  if FPicturePosition <> value then
  begin
    FPicturePosition := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetPictureSize(const Value: TFillPictureSize);
begin
  if FpictureSize <> value then
  begin
    FpictureSize := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetPictureTop(const Value: integer);
begin
  if FPictureTop <> value then
  begin
    FPictureTop := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetPictureWidth(const Value: integer);
begin
  if FpictureWidth <> value then
  begin
    FpictureWidth := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetRounding(const Value: integer);
begin
  if FRounding <> value then
  begin
    FRounding := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetRoundingType(const Value: TFillRoundingType);
begin
  if FRoundingType <> value then
  begin
    FRoundingType := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetShadowColor(const Value: TColor);
begin
  if FShadowColor <> value then
  begin
    FShadowColor := Value;
    Changed;
  end;
end;

procedure TGDIPFill.SetShadowOffset(const Value: integer);
begin
  if FShadowOffset <> value then
  begin
    FShadowOffset := Value;
    Changed;    
  end;
end;

{ TGDIPProgress }

procedure TGDIPProgress.Assign(Source: TPersistent);
begin
  if (Source is TGDIPProgress) then
  begin
    FBackGroundFill.Assign((Source as TGDIPProgress).BackGroundFill);
    FProgressFill.Assign((Source as TGDIPProgress).ProgressFill);
    FValueFormat := (Source as TGDIPProgress).ValueFormat;
    FValueType := (Source as TGDIPProgress).ValueType;
    FValuePositionTop := (Source as TGDIPProgress).ValuePositionTop;
    FValuePositionLeft := (Source as TGDIPProgress).ValuePositionLeft;
    FValuePosition := (Source as TGDIPProgress).ValuePosition;
    FValueVisible := (Source as TGDIPProgress).ValueVisible;
    FFont.Assign((Source as TGDIPProgress).Font);
    Ftransparent := (Source as TGDIPProgress).Transparent;
  end;
end;

function TGDIPProgress.CalculateProgressRectangle(r: TRect; min, max, pos: Double): TGPRectF;
var
  totalw, xpos: Double;
begin
  if (ProgressFill.BorderColor <> clNone) and (ProgressFill.BorderWidth <> 0) then
    totalw := InsideRect(r).Right - ProgressFill.BorderWidth - InsideRect(r).Left
  else
    totalw := InsideRect(r).Right - InsideRect(r).Left;

  if (max - min) > 0 then
    xpos := Math.Min(((pos - min) / (max - min)) * totalw, totalw)
  else
    xpos := 0;

  if (ProgressFill.BorderColor <> clNone) and (ProgressFill.BorderWidth <> 0) then
    Result := MakeRect(InsideRect(r).Left + (ProgressFill.BorderWidth / 2), InsideRect(r).Top + (ProgressFill.BorderWidth / 2),
      xpos, InsideRect(r).Bottom - ProgressFill.BorderWidth  - InsideRect(r).Top)
  else
    Result := MakeRect(InsideRect(r).Left, InsideRect(r).Top, xpos, InsideRect(r).Bottom - InsideRect(r).Top);
end;

procedure TGDIPProgress.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TGDIPProgress.Create;
begin
  FBackGroundFill := TGDIPFill.Create;
  FBackGroundFill.OnChange := FillChanged;
  FProgressFill := TGDIPFill.Create;
  FProgressFill.OnChange := FillChanged;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FValueFormat := '%.0f%%';
  FValueType := vtAbsolute;
  FValuePositionTop := 0;
  FValuePositionLeft := 0;
  FValueVisible := false;
  FValuePosition := vpCenter;
  FProgressFont := TFont.Create;
  FProgressFont.OnChange := FontChanged;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  FProgressFont.Name := 'Tahoma';  
  {$ENDIF}
  FTransparent := false;
end;

destructor TGDIPProgress.Destroy;
begin
  FBackGroundFill.Free;
  FProgressFill.Free;
  FFont.Free;
  FProgressFont.Free;
  inherited;
end;

procedure TGDIPProgress.Draw(g: TGPGraphics; r: TRect; min, max, position: Double);
var
  bg: TGPRectF;
begin
  bg := MakeRect(r.Left, r.Top, r.Right - r.Left - 1, r.Bottom - r.Top - 1);
  if not Transparent then
    DrawBackGround(g, bg);

  if position > min then
    DrawProgress(g, r, min, max, position);

  if not Transparent then
    DrawShadows(g, GetInsideRectF(r));

  if ValueVisible then
    DrawValue(g, r, min, max, position);

  if not Transparent then
    DrawOverLay(g, r);
end;

procedure TGDIPProgress.DrawBackGround(g: TGPGraphics; r: TGPRectF);
begin
  BackGroundFill.Fill(g, r);
end;

procedure TGDIPProgress.DrawGlow(g: TGPGRaphics; r: TRect; glowposition, min, max, position: Double);
var
  b: TGPLinearGradientBrush;
  rr, lr, o: TGPRectF;
  rgn: TGPRegion;
begin
  rgn := TGPRegion.Create(CalculateProgressRectangle(r, min, max, position));
  g.SetClip(rgn);
  o := GetInsideRectF(r);
  lr := MakeRect(glowposition - 30, o.Y, 30, o.Height);
  rr := MakeRect(glowposition, o.Y, 30, o.Height);
  b := TGPLinearGradientBrush.Create(MakeRect(lr.X - 1, lr.Y - 1, lr.Width + 2, lr.Height + 2), MakeColor(0, clWhite), MakeColor(120, clWhite), LinearGradientModeHorizontal);
  g.FillRectangle(b, lr);
  b.free;
  b := TGPLinearGradientBrush.Create(MakeRect(rr.X - 1, rr.Y - 1, rr.Width + 2, rr.Height + 2), MakeColor(120, clWhite), MakeColor(0, clWhite), LinearGradientModeHorizontal);
  g.FillRectangle(b, rr);
  b.free;
  g.ResetClip;
  rgn.free;
end;

procedure TGDIPProgress.DrawOverLay(g: TGPGraphics; r: TRect);
var
  b: TGPLinearGradientBrush;
  ro: TGPRectF;
begin
  ro := MakeRect(InsideRect(r).Left, InsideRect(r).Top, InsideRect(r).Right - InsideRect(r).Left, (InsideRect(r).Bottom - InsideRect(r).Top) / 2.5);
  b := TGPLinearGradientBrush.Create(MakeRect(ro.X - 1, ro.Y - 1, ro.Width + 2, ro.Height + 2), MakeColor(180, clWhite), MakeColor(0, clWhite), LinearGradientModeVertical);
  g.FillRectangle(b, ro);
  b.free;
  //
  ro := MakeRect(InsideRect(r).Left, InsideRect(r).Bottom - (InsideRect(r).Bottom - InsideRect(r).Top) / 5, InsideRect(r).Right - InsideRect(r).Left, (InsideRect(r).Bottom - InsideRect(r).Top) / 5);
  b := TGPLinearGradientBrush.Create(MakeRect(ro.X - 1, ro.Y - 1, ro.Width + 2, ro.Height + 2), MakeColor(0, clWhite), MakeColor(255, clWhite), LinearGradientModeVertical);
  g.FillRectangle(b, ro);
  b.free;
end;

procedure TGDIPProgress.DrawProgress(g: TGPGraphics; r: TRect; min, max, position: Double);
var
  pr: TGPRectF;
begin
  pr := CalculateProgressRectangle(r, min, max, position);
  ProgressFill.Fill(g, pr);
  if pr.Width > 0 then
    DrawShadows(g, pr);
end;

procedure TGDIPProgress.DrawShadows(g: TGPGraphics; r: TGPRectF);
var
  o, rRight, rLeft: TGPRectF;
  b: TGPLinearGradientBrush;
begin
  o := r;
  rLeft := MakeRect(o.X, o.y, 10, o.Height);
  rRight := MakeRect(o.Width - 10 + o.X, o.y, 10, o.Height);

  b := TGPLinearGradientBrush.Create(MakeRect(rLeft.X - 1, rLeft.Y - 1, rLeft.Width + 2, rLeft.Height + 2), MakeColor(30, clBlack), MakeColor(0, clBlack), LinearGradientModeHorizontal);
  g.FillRectangle(b, rLeft);
  b.free;

  b := TGPLinearGradientBrush.Create(MakeRect(rRight.X - 1, rRight.Y - 1, rRight.Width + 2, rRight.Height + 2), MakeColor(0, clBlack), MakeColor(30, clBlack), LinearGradientModeHorizontal);
  g.FillRectangle(b, rRight);
  b.Free;
end;

procedure TGDIPProgress.DrawValue(g: TGPGraphics; r: TRect; min, max, position: double);
var
  f: TGPFont;
  ff: TGPFontFamily;
  fs: integer;
  sf: TGPStringFormat;
  b: TGPSolidBrush;
  bn, sizerect, pr: TGPRectF;
  s: String;
  tw, th: Double;
  p: TGPPointF;
  x, y, v: Double;
  ft: TFont;
begin
  if position < min then
    position := min
  else if position > max then
    position := max;

  v := 0;
  case ValueType of
    vtPercentage:
      begin  
        if (max > min) then
          v := (Position - min) / (max - min) * 100
        else
      	  v := max;
      end;
    vtAbsolute: v := Position;
  end;

  s := Format(ValueFormat, [v]);
  GetTextSize(g, r, s, Font, sizerect);
  tw := sizerect.Width;
  th := sizerect.Height;

  pr := CalculateProgressRectangle(r, min, max, position);
  bn := GetInsideRectF(r);
  y := (bn.Height - th) / 2;
  x := r.Left;

  case ValuePosition of
    vpProgressCenter:
    begin
      if pr.Width >= tw then
        x := bn.X + (pr.Width - tw) / 2
      else
        x := bn.X;
    end;
    vpProgressRight:
    begin
      if pr.Width >= tw then
        x := bn.X + (pr.Width - tw)
      else
        x := bn.X;
    end;
    vpCenter: x := x + (bn.Width - tw) / 2;
    vpLeft: x := bn.x;
    vpRight: x := x + bn.Width - tw;
    vpCustom:
    begin
      x := x + ValuePositionLeft;
      y := ValuePositionTop;
    end;
  end;

  if (x + (tw / 2) < pr.X + pr.Width) then
    ft := ProgressFont
  else
    ft := Font;

  ff := TGPFontFamily.Create(ft.Name);

  fs := 0;
  if (fsBold in ft.Style) then
    fs := fs + 1;
  if (fsItalic in ft.Style) then
    fs := fs + 2;
  if (fsUnderline in ft.Style) then
    fs := fs + 4;

  bn := GetInsideRectF(r);
  sf := TGPStringFormat.Create;
  f := TGPFont.Create(ff, ft.Size , fs, UnitPoint);

  p := MakePoint(x, y + r.Top);

  b := TGPSolidBrush.Create(MakeColor(255, ft.Color));
  g.DrawString(s, Length(s), f, p, sf, b);


  b.Free;
  sf.Free;
  ff.Free;
  f.Free;
end;

procedure TGDIPProgress.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TGDIPProgress.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TGDIPProgress.GetInsideRectF(r: TRect): TGPRectF;
begin
  Result := MakeRect(InsideRect(r).Left, InsideRect(r).Top, InsideRect(r).Right - InsideRect(r).Left,
    InsideRect(r).Bottom - InsideRect(r).Top);
end;

procedure TGDIPProgress.GetTextSize(g: TGPGraphics; r: TRect; s: String; ft: TFont; var sizer: TGPRectF);
var
  ff: TGPFontFamily;
  fs: integer;
  bn: TGPRectF;
  sf: TGPStringFormat;
  f: TGPFont;
begin
  ff := TGPFontFamily.Create(ft.Name);

  fs := 0;
  if (fsBold in ft.Style) then
    fs := fs + 1;
  if (fsItalic in ft.Style) then
    fs := fs + 2;
  if (fsUnderline in ft.Style) then
    fs := fs + 4;

  bn := GetInsideRectF(r);
  sf := TGPStringFormat.Create;
  f := TGPFont.Create(ff, ft.Size , fs, UnitPoint);
  g.MeasureString(s, Length(s), f, bn, sf, sizer);
  
  ff.Free;
  sf.free;
  f.free;
end;

function TGDIPProgress.InsideRect(r: TRect): TRect;
var
  bw: integer;
begin
  Result := Bounds(r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top);
  // adapt width & height for GDI+ drawing rect

  Result.Right := Result.Right - 1;
  Result.Bottom := Result.Bottom - 1;

  if (BackGroundFill.BorderColor <> clNone) then
  begin
    if BackGroundFill.BorderWidth = 1 then
      bw := 1
    else
      bw := (BackGroundFill.BorderWidth + 1) div 2;

    InflateRect(Result, -bw, -bw);
  end;
end;

procedure TGDIPProgress.SetBackGroundFill(const Value: TGDIPFill);
begin
  if FBackGroundFill <> value then
  begin
    FBackGroundFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TGDIPProgress.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TGDIPProgress.SetProgressFill(const Value: TGDIPFill);
begin
  if FProgressFill <> value then
  begin
    FProgressFill.Assign(Value);
    FillChanged(Self);
  end;
end;

procedure TGDIPProgress.SetProgressFont(const Value: TFont);
begin
  if FProgressFont <> value then
  begin
    FProgressFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TGDIPProgress.SetTransparent(const Value: Boolean);
begin
  if FTransparent <> value then
  begin
    FTransparent := Value;
    Changed;
  end;
end;

procedure TGDIPProgress.SetValueFormat(const Value: String);
begin
  if FValueFormat <> value then
  begin
    FValueFormat := Value;
    Changed;
  end;
end;

procedure TGDIPProgress.SetValuePosition(
  const Value: TGDIPProgressValuePosition);
begin
  if FValuePosition <> Value then
  begin
    FValuePosition := Value;
    Changed;
  end;
end;

procedure TGDIPProgress.SetValuePositionLeft(const Value: integer);
begin
  if FValuePositionLeft <> value then
  begin
    FValuePositionLeft := Value;
    Changed;
  end;
end;

procedure TGDIPProgress.SetValuePositionTop(const Value: integer);
begin
  if FValuePositionTop <> value then
  begin
    FValuePositionTop := Value;
    Changed;
  end;
end;

procedure TGDIPProgress.SetValueType(const Value: TGDIPProgressValueType);
begin
  if FValueType <> Value then
  begin
    FValueType := Value;
    Changed;
  end;
end;

procedure TGDIPProgress.SetValueVisible(const Value: Boolean);
begin
  if FValueVisible <> value then
  begin
    FValueVisible := Value;
    Changed;
  end;
end;

{ TGDIPStatus }

procedure TGDIPStatus.Assign(Source: TPersistent);
begin
  if (Source is TGDIPStatus) then
  begin
    FFill.Assign((Source as TGDIPStatus).Fill);
    FFont.Assign((Source as TGDIPStatus).Font);
    FGlow := (Source as TGDIPStatus).Glow;
    FSpacing := (Source as TGDIPStatus).Spacing;
    Changed;
  end;
end;

procedure TGDIPStatus.CalculateSize(g: TGPGraphics; Caption: String);
var
  ff: TGPFontFamily;
  f: TGPFont;
  fs: integer;
  sf: TGPStringFormat;
  SizeRect: TGPRectF;
  pw, ph: integer;
begin
  if Caption <> '' then
  begin
    ff := TGPFontFamily.Create(Font.Name);

    fs := 0;
    if (fsBold in FFont.Style) then
      fs := fs + 1;
    if (fsItalic in FFont.Style) then
      fs := fs + 2;
    if (fsUnderline in FFont.Style) then
      fs := fs + 4;

    sf := TGPStringFormat.Create;
    f := TGPFont.Create(ff, FFont.Size , fs, UnitPoint);

    g.MeasureString(Caption, Length(Caption), f, MakeRect(0, 0, 10000, 10000), sf, sizeRect);

    FHeight := Round(SizeRect.Height + 4);
    FWidth := Max(Round(SizeRect.Width + 4), FHeight) + (Spacing * 2);

    ff.Free;
    f.free;
    sf.Free;
  end;

  if not Self.Fill.Picture.Empty then
  begin
    if Self.Fill.PictureSize = psOriginal then
    begin
      Self.Fill.Picture.GetImageSizes;
      pw := Fill.Picture.Width;
      ph := Fill.Picture.Height;
    end
    else
    begin
      pw := Fill.PictureWidth;
      ph := Fill.PictureHeight;
    end;

    if pw > FWidth then
      FWidth := pw;

    if ph > FHeight then
      FHeight := ph;
  end;
end;

procedure TGDIPStatus.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TGDIPStatus.Create;
begin
  FFill := TGDIPFill.Create;
  FFill.OnChange := FillChanged;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}
  FAutoSize := true;
  FGlow := true;
  FSpacing := 0;
end;

destructor TGDIPStatus.Destroy;
begin
  FFill.Free;
  FFont.Free;
  inherited;
end;

procedure TGDIPStatus.Draw(g: TGPGraphics; x, y, Width, Height: integer; AutoSize: boolean; Caption: String);
var
  f: TGPFont;
  ff: TGPFontFamily;
  fs: integer;
  bw: Double;
  sf: TGPStringFormat;
  r, sizeRect: TGPRectF;
  p: TGPPointF;
  b: TGPSolidBrush;
  o: TGDIPFill;
  w, h: integer;
begin
  ff := TGPFontFamily.Create(FFont.Name);

  if AutoSize then
  begin
    w := FWidth;
    h := FHeight;
  end
  else
  begin
    w := Width;
    h := Height;
  end;

  w := w;
  h := h;

  fs := 0;
  if (fsBold in FFont.Style) then
    fs := fs + 1;
  if (fsItalic in FFont.Style) then
    fs := fs + 2;
  if (fsUnderline in FFont.Style) then
    fs := fs + 4;

  sf := TGPStringFormat.Create;
  f := TGPFont.Create(ff, FFont.Size , fs, UnitPoint);

  g.MeasureString(Caption, Length(Caption), f, MakeRect(0, 0, 10000, 10000), sf, sizeRect);

  Fill.BeginUpdate;
  bw := 0;
  if (Fill.BorderColor <> clNone) then
    bw := Fill.BorderWidth / 2;

  r := MakeRect(x, y, w - (bw * 2), h - (bw * 2));
  Fill.Rounding := Round(r.Height / 2);
  Fill.Fill(g, r);
  Fill.EndUpdate;

  p := MakePoint((w - (Spacing * 2) - sizeRect.Width) / 2, (h - sizeRect.Height) / 2);
  p.x := p.x + x + Spacing;
  p.y := p.y + y;
  b := TGPSolidBrush.Create(MakeColor(255, FFont.Color));
  g.DrawString(Caption, Length(Caption),f , p, sf, b);

  if Glow then
  begin
    o := TGDIPFill.Create;
    o.Color := clWhite;
    o.ColorTo := clWhite;
    o.GradientType := gtVertical;
    o.Opacity := 170;
    o.OpacityTo := 30;
    o.RoundingType := rtTop;
    o.Rounding := Fill.Rounding;
    r := MakeRect(r.X, r.y, r.Width, r.Height / 2);
    o.Fill(g, r);

    o.Free;
  end;

  b.Free;
  f.Free;
  ff.Free;
  sf.Free;
end;

procedure TGDIPStatus.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TGDIPStatus.FontChanged(Sender: TObject);
begin
  Changed;
end;

function TGDIPStatus.GetHeight: integer;
begin
  Result := FHeight;
end;

function TGDIPStatus.GetWidth: integer;
begin
  Result := FWidth;
end;

procedure TGDIPStatus.SetFill(const Value: TGDIPFill);
begin
  if FFill <> value then
  begin
    FFill.Assign(Value);
    FillChanged(self);
  end;
end;

procedure TGDIPStatus.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TGDIPStatus.SetGlow(const Value: Boolean);
begin
  if FGlow <> value then
  begin
    FGlow := Value;
    changed;
  end;
end;

procedure TGDIPStatus.SetSpacing(const Value: integer);
begin
  if FSpacing <> value then
  begin
    FSpacing := Value;
    Changed;
  end;
end;

{ TGDIPButton }

{$IFNDEF DELPHI6_LVL}
const
  Nan = -361.0;

function IsNan(d: double): boolean;
begin
  Result := (d = Nan);
end;
{$ENDIF}

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


function CreateBubbleRectangleConcave(R: TRect; Radius, Delta: Integer): TGPGraphicsPath;
var
  l, t, w, h, d: Integer;
  rs: single;
  alpha1, alpha2: single;
  mid: tpoint;
  ar: tgprectf;
  ri: integer;
begin
  Result := TGPGraphicsPath.Create;
  
  l := R.Left;
  t := R.Top;
  w := R.Right - R.Left;
  h := R.Bottom - R.Top;
  d := Radius shl 1;

  if delta = 0 then
    Exit;

  rs := (sqr(w/2) + sqr(Delta)) / (2 * Delta);

  ri := round(rs);

  if (rs - Delta = 0) then
  begin
    alpha1 := 0;
    alpha2 := 180;
  end
  else
  begin
    alpha1 := 90 + RadToDeg(ArcTan( 1/2 * w / (rs - Delta)));
    alpha2 := 180 - alpha1;
  end;

  mid.x := l + w div 2;
  mid.y := t + h + Delta - round(rs);

  ar := MakeRect(mid.x - ri, mid.Y - ri - delta, ri * 2, ri * 2);

  Result.AddArc(ar, alpha1, alpha2 - alpha1);
  Result.AddLine(l + w, t + h - delta, l + w, t + 2 * h - radius); // right
  Result.AddArc(l + w - d,  t + 2 * h - d, d, d, 0, 90); // topleft
  Result.AddLine(l + w - radius, t + 2 * h, l + radius, t + 2 * h ); // right
  Result.AddArc(l,  t + 2 * h - d, d, d, 90, 90); // topleft
  Result.AddLine(l , t + 2 * h - radius, l , t + h - delta ); // right
  Result.CloseFigure();
end;

function CreateBubbleRectangleConvex(R: TRect; Radius, Delta: Integer): TGPGraphicsPath;
var
  l, t, w, h, d: Integer;
  rs: single;
  alpha1, alpha2: single;
  mid: tpoint;
  ar: tgprectf;
  ri: integer;
begin
  Result := TGPGraphicsPath.Create;
  l := R.Left;
  t := R.Top;
  w := R.Right - R.Left;
  h := R.Bottom - R.Top;
  d := Radius shl 1;

  if delta = 0 then
    Exit;

  rs := (sqr(w/2) + sqr(Delta)) / (2 * Delta);

  ri := round(rs);

  if (rs - Delta = 0) then
  begin
    alpha1 := 0;
    alpha2 := 180;
  end
  else
  begin
    alpha1 := 90 + RadToDeg(ArcTan( 1/2 * w / (rs - Delta)));
    alpha2 := 180 - alpha1;
  end;

  mid.x := l + w div 2;
  mid.y := t + h + Delta - round(rs);

  ar := MakeRect(mid.x - ri, mid.Y - ri - delta, ri*2, ri*2);

  Result.AddArc(l, t, d, d, 180, 90); // topleft
  Result.AddLine(l + radius, t, l + w - radius, t); // top
  Result.AddArc(l + w - d, t, d, d, 270, 90); // topright
  Result.AddLine(l + w, t + radius, l + w, t + h - delta); // right


  Result.AddArc(ar, alpha1, alpha2 - alpha1);
  Result.AddLine(l, t + h - delta, l, t + radius); // right

  Result.CloseFigure();
end;

function CreateRoundRectangle(R: TRect; Radius: Integer; BottomRounding: Boolean): TGPGraphicsPath; overload;
var
  l, t, w, h, d: Integer;
begin
  Result := TGPGraphicsPath.Create;
  l := R.Left;
  t := R.Top;
  w := R.Right - R.Left;
  h := R.Bottom - R.Top;
  d := Radius shl 1;

  if not BottomRounding then
  begin
    Result.AddArc(l, t + h div 2, d, d, 180, 90); // topleft
    Result.AddLine(l + radius, t +  h div 2, l + w - radius, t + h div 2); // top
    Result.AddArc(l + w - d, t + h div 2, d, d, 270, 90); // topright
    Result.AddLine(l + w, t + radius + h div 2, l + w, t + h - radius); // right
    Result.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
    Result.AddLine(l + w - radius, t + h, l + radius, t + h); // bottom
    Result.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
    Result.AddLine(l, t + h - radius, l, t + radius +  h div 2); // left
  end
  else
  begin
    Result.AddArc(l, t + h div 2, d, d, 180, 90); // topleft
    Result.AddLine(l + radius, t +  h div 2, l + w - radius, t + h div 2); // top
    Result.AddArc(l + w - d, t + h div 2, d, d, 270, 90); // topright
    Result.AddLine(l + w, t + radius + h div 2, l + w, t + h); // right
//    Result.AddArc(l + w - d, t + h - d, d, d, 0, 90); // bottomright
    Result.AddLine(l + w, t + h, l, t + h); // bottom
//    Result.AddArc(l, t + h - d, d, d, 90, 90); // bottomleft
    Result.AddLine(l, t + h, l, t + h div 2); // left
  end;

  Result.CloseFigure();
end;

function CreateRoundLine(R: TRect; Radius: Integer; RoundingType: TFillRoundingType; bw: integer): TGPGraphicsPath;
var
  l, t, w, h, d: Integer;
begin
  Result := TGPGraphicsPath.Create;
  l := R.Left;
  t := R.Top;
  w := R.Right - R.Left;
  h := R.Bottom - R.Top;
  d := Radius shl 1;

  GetPath(l, t, w, h, d, Radius, RoundingType, result);

  InflateRect(r, -bw, -bw);

  l := R.Left;
  t := R.Top;
  w := R.Right - R.Left;
  h := R.Bottom - R.Top;

  GetPath(l, t, w, h, d, Radius, RoundingType, result);
end;

function ChangeColor(Color: TColor; Delta: integer): TColor;
var
  r,g,b: longint;
  l: longint;
begin
  l := ColorToRGB(Color);
  b := ((l AND $FF0000) shr 16);
  g := ((l AND $FF00) shr 8);
  r := (l AND $FF);

  r := Max(0,Min(255,r + Delta));
  g := Max(0,Min(255,g + Delta));
  b := Max(0,Min(255,b + Delta));

//  r := round(Min(255,r * delta /100));
//  g := round(Min(255,g * delta /100));
//  b := round(Min(255,b * delta /100));

  Result := RGB(r,g,b);
end;

procedure TGDIPButton.Assign(Source: TPersistent);
begin
  if (Source is TGDIPButton) then
  begin
    FFont.Assign((Source as TGDIPButton).Font);
    FLayout := (Source as TGDIPButton).Layout;
    FSpacing := (Source as TGDIPButton).Spacing;
    Changed;
  end;
end;

procedure TGDIPButton.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TGDIPButton.Changed;
begin
  if Assigned(FOnChange) and (FUpdateCount = 0) then
    FOnChange(Self);
end;

constructor TGDIPButton.Create;
begin
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}
  FLayout := blPictureLeft;
  FSpacing := 3;
end;

destructor TGDIPButton.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TGDIPButton.Draw(g: TGPGraphics; Caption: String; x, y, Width, Height, VerticalSpacing,
  HorizontalSpacing: integer; Color, ColorDown, BevelColor: TColor; Shadow, Down, Bevel, VerticalText, RightToLeft: Boolean;
  RoundingType: TFillRoundingType; Picture: TAdvGDIPPicture; TextW, TextH: integer; WW: boolean);
var
  p: TGPGraphicsPath;
  b: TGPLinearGradientBrush;
  bs: TGPSolidBrush;
  delta: integer;
  ff: TGPFontFamily;
  fs: integer;
  f: TGPFont;
  stringformat: TGPStringFormat;
  l, t: integer;
  DrawColor: TColor;
  colors : array[0..3] of TGPColor;
  positions: array[0..3] of single;
  ph: integer;
  fHSV: THSVTriplet;
  fRGB: TRGBTriplet;
  vs, hs: integer;
  sizer, textr: TGPRectF;
  pt: TGPPointF;
  tf: TFont;
  lf: TLogFont;
  tw, th: Double;
  ly: TGDIPButtonLayout;
  pathshadow: TGPGraphicsPath;
  gBrush: TGPPathGradientBrush;
  cb: array[0..2] of TGPColor;
  pb: array[0..2] of single;
begin
  ly := Layout;
  if VerticalText then
  begin
    if not RightToLeft then
    begin
      case Layout of
        blPictureLeft: ly := blPictureTop;
        blPictureRight: ly := blPictureBottom;
        blPictureBottom: ly := blPictureRight;
        blPictureTop: ly := blPictureLeft;
      end;
    end
    else
    begin
      case Layout of
        blPictureLeft: ly := blPictureBottom;
        blPictureRight: ly := blPictureTop;
        blPictureBottom: ly := blPictureRight;
        blPictureTop: ly := blPictureLeft;
      end;
    end;
  end;

  if Down and (ColorDown = clNone) then
  begin
    fRGB.R := GetRed(Color);
    fRGB.G := GetGreen(Color);
    fRGB.B := GetBlue(Color);
    RGBToHSV(fRGB.B, fRGB.G, fRGB.R, fHSV.H, fHSV.S, fHSV.V);
    fHSV.V := 0.8 * fHSV.V;
    HSVToRGB(fHSV.H, fHSV.S, fHSV.V, fRGB.R, fRGB.G, fRGB.B);
    DrawColor := RGB(Round(fRGB.R), Round(fRGB.G), Round(fRGB.B));
  end
  else if Down then
    DrawColor := ColorDown
  else
    DrawColor := Color;

  hs := HorizontalSpacing;
  vs := VerticalSpacing;

  if Shadow then
  begin
    {
    bs := TGPSolidBrush.Create(ColorToARGB(clBlack));
    p := CreateRoundRectangle(MakeRect(2 + hs + x,2 + vs + y, Width - 3 - hs, Height - 1 - vs), 4, RoundingType, false);
    ph := Height - 2;
    g.FillPath(bs, p);
    bs.Free;
    p.Free;
    }
    pathshadow := CreateRoundRectangle(MakeRect(2 + hs + x,2 + vs + y, Width - 4 - (hs * 2), Height - 2 - (vs * 2)), 8, RoundingType, false);
    gBrush := TGPPathGradientBrush.Create(pathshadow);
    gBrush.SetWrapMode(WrapModeClamp);

    cb[0] := MakeColor(0,0,0,0);
    cb[1] := MakeColor(180, clBlack);
    cb[2] := MakeColor(180, clBlack);

    pb[0] := 0;
    pb[1] := 0.1;
    pb[2] := 1;

    gBrush.SetInterpolationColors(@cb, @pb, 3);

    g.FillPath(gbrush, pathshadow);
    pathshadow.Free;
    gBrush.Free;

    Height := Height - 4;
    Width := Width - 6;
  end;

  ph := Height;

  delta := ph div 6;

  bs := TGPSolidBrush.Create(ColorToARGB(ChangeColor(DrawColor,-40)));
  p := TGPGraphicsPath.Create;
  p.AddRectangle(MakeRect(hs + x, ph div 2 - delta + y, Width - 1 - (hs * 2), delta * 2));
  g.FillPath(bs, p);
  bs.Free;
  p.Free;

  p := CreateBubbleRectangleConcave(Rect(hs + x,vs + y, x + Width - 1 - hs, y + (ph div 2)), 8, delta);

  b := TGPLinearGradientBrush.Create(MakeRect(hs - 1 + x,(ph div 2) - delta - 1 + y, Width - (hs * 2) + 1, (ph div 2) + delta + 2), ColorToARGB(ChangeColor(DrawColor,-40)),
    ColorToARGB(ChangeColor(DrawColor,180)),LinearGradientModeVertical);

  b.SetGammaCorrection(true);

  colors[0] := ColorToARGB(ChangeColor(DrawColor,-40));
  colors[1] := ColorToARGB(ChangeColor(DrawColor,100));
  colors[2] := ColorToARGB(ChangeColor(DrawColor,220));
  positions[0] := 0;
  positions[1] := 0.9;
  positions[2] := 1;

  b.SetInterpolationColors(@colors,@positions,3);

  g.FillPath(b,p);

  b.Free;
  p.Free;

  p := CreateBubbleRectangleConvex(Rect(hs + x,vs + y,x + Width - 1 - hs, y + (ph div 2)), 8, delta);

  b := TGPLinearGradientBrush.Create(MakeRect(hs - 1 + x,vs - 1 + y,Width - (hs * 2) + 1, (ph div 2) + 3) , ColorToARGB(ChangeColor(DrawColor,180)),
    ColorToARGB(DrawColor),LinearGradientModeVertical);

  b.SetGammaCorrection(true);

  colors[0] := ColorToARGB(ChangeColor(DrawColor,220));
  colors[1] := ColorToARGB(ChangeColor(DrawColor,100));
  colors[2] := ColorToARGB(DrawColor);
  positions[0] := 0;
  positions[1] := 0.2;
  positions[2] := 1;

  b.SetInterpolationColors(@colors,@positions,3);

  g.FillPath(b,p);

  b.Free;
  p.Free;

  if Bevel then
  begin
    p := CreateRoundLine(Rect(hs + x,1 + vs + y,x + Width - 1 - hs, y + ph -1 - vs), 7, RoundingType, 2);
    bs := TGPSolidBrush.Create(MakeColor(160, BevelColor));
    g.FillPath(bs,p);
    bs.Free;
    p.Free;
  end;

  tw := 0;
  th := 0;
  ////Button Caption///
  if Caption <> '' then
  begin
    f := nil;
    if Down then
      textr := MakeRect(1 + hs + x,1 + vs + y,Width - (hs * 2),ph - vs)
    else
      textr := MakeRect(hs + x,vs + y,Width - (hs * 2),ph - vs);

    if (Picture <> nil) and (Picture.Empty = false)  then
    begin
      Picture.GetImageSizes;
      case ly of
        blPictureRight, blPictureLeft: textr.Width := textr.Width - picture.Width - Spacing;
        blPictureTop, blPictureBottom: textr.Height := textr.Height - picture.Height - Spacing;
      end;
    end;

    stringformat := nil;
    if not VerticalText then
    begin
      ff := TGPFontFamily.Create(Font.Name);

      fs := 0;
      if (fsBold in Font.Style) then
        fs := fs + 1;
      if (fsItalic in Font.Style) then
        fs := fs + 2;
      if (fsUnderline in Font.Style) then
        fs := fs + 4;

      stringformat := TGPStringFormat.Create(0);

      g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

      f := TGPFont.Create(ff, Font.Size , fs, UnitPoint);

      g.MeasureString(Caption, Length(Caption), f, textr, stringformat, sizer);

      bs := TGPSolidBrush.Create(ColorToARGB(Font.Color));
    end;

    if not VerticalText then
    begin
      tw := sizer.Width;
      th := sizer.Height;
    end
    else
    begin
      tw := TextW;
      th := TextH;
    end;

    pt := MakePoint(textr.X + (textr.Width - tw) / 2, textr.Y + (textr.Height - th) / 2);
    if (Picture <> nil) and not Picture.Empty then
    begin
      case ly of
        blPictureLeft:
        begin
          pt := MakePoint(textr.X + (textr.Width - tw) / 2,
            textr.Y + (textr.Height - th) / 2);

          if pt.X < Spacing then
            pt.X := Spacing;

          pt.X := pt.X + Picture.Width + Spacing;
        end;
        blPictureRight:
        begin
          pt := MakePoint(textr.X + (textr.Width - tw) / 2,
            textr.Y + (textr.Height - th) / 2);

          if pt.X < Spacing then
          begin
            pt.X := Spacing;
            tw := Width - Picture.Width - Spacing - Spacing;
            textr.Width := tw;
          end;
          
        end;
        blPictureBottom:
        begin
          pt := MakePoint(textr.X + (textr.Width - tw) / 2,
            textr.Y + (textr.Height - th) / 2);
        end;
        blPictureTop:
        begin
          pt := MakePoint(textr.X + (textr.Width - tw) / 2,
            textr.Y + (textr.Height - th) / 2);
          pt.Y := pt.Y + Picture.Height + Spacing;
        end;
      end;
    end;

    if not VerticalText then
    begin
      textr := MakeRect(pt.X, pt.Y, sizer.Width, sizer.Height);//textr.Width - (pt.X - X), textr.Height - (pt.Y - Y));
      stringFormat.SetHotkeyPrefix(HotkeyPrefixShow);
      if WW then
        g.DrawString(Caption, Length(Caption), f, textr, stringformat, bs)
      else
        g.DrawString(Caption, Length(Caption), f, pt, stringformat, bs);
      bs.Free;
      f.Free;
      ff.Free;
      stringformat.Free;
    end;
  end;

  if (Picture <> nil) and not Picture.Empty then
  begin
    Picture.GetImageSizes;
    l := (Width - Picture.Width) div 2;
    t := (ph + vs - Picture.Height) div 2;
    if Down then
    begin
      l := l + 2;
      t := t + 2;
    end;

    if Caption <> '' then
    begin
      case ly of
        blPictureLeft:
        begin
          l := Round(pt.X - Picture.Width - Spacing);
          Picture.GDIPDraw(g, Bounds(l, t + y, Picture.Width, Picture.Height));
        end;
        blPictureRight:
        begin
          l := Round(pt.X + tw + spacing);
          Picture.GDIPDraw(g, Bounds(l, t + y, Picture.Width, Picture.Height));
        end;
        blPictureBottom:
        begin
          t := Round(pt.Y + th + spacing);
          Picture.GDIPDraw(g, Bounds(l + x, t, Picture.Width, Picture.Height));
        end;
        blPictureTop:
        begin
          t := Round(pt.Y - Picture.Height - Spacing);
          Picture.GDIPDraw(g, Bounds(l + x, t, Picture.Width, Picture.Height));
        end;
      end;
    end
    else
    begin
      Picture.GDIPDraw(g, Bounds(l + x, t + y, Picture.Width, Picture.Height));
    end;
  end;
end;

procedure TGDIPButton.EndUpdate;
begin
  Dec(FUpdateCount);
end;

procedure TGDIPButton.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TGDIPButton.SetFont(const Value: TFont);
begin
  if FFont <> value then
  begin
    FFont.Assign(Value);
    FontChanged(Self);
  end;
end;

procedure TGDIPButton.SetLayout(const Value: TGDIPButtonLayout);
begin
  if FLayout <> value then
  begin
    FLayout := Value;
    Changed;
  end;
end;

procedure TGDIPButton.SetSpacing(const Value: integer);
begin
  if FSpacing <> value then
  begin
    FSpacing := Value;
    Changed;
  end;
end;

{ TGDIPDialogButton }

procedure TGDIPDialogButton.Assign(Source: TPersistent);
begin
  if (Source is TGDIPDialogButton) then
  begin
    FFont.Assign((Source as TGDIPDialogButton).Font);
    FLayout := (Source as TGDIPDialogButton).Layout;
    FSpacing := (Source as TGDIPDialogButton).Spacing;
    Changed;
  end;
end;

procedure TGDIPDialogButton.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TGDIPDialogButton.Create;
begin
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}
  FLayout := blPictureLeft;
  FSpacing := 3;
end;

destructor TGDIPDialogButton.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TGDIPDialogButton.Draw(g: TGPGraphics; Caption: String; x, y, Width, Height: integer; Color, BorderColor: TColor;
  BorderWidth: integer; BorderOpacity, Opacity: Byte; Border, Down: Boolean; Picture: TAdvGDIPPicture; WW: boolean);
var
  p: TGPGraphicsPath;
  b: TGPLinearGradientBrush;
  bs: TGPSolidBrush;
  ff: TGPFontFamily;
  fs: integer;
  f: TGPFont;
  stringformat: TGPStringFormat;
  l, t: integer;
  DrawColor: TColor;
  ph: integer;
  sizer, textr: TGPRectF;
  pt: TGPPointF;
  tw, th: Double;
  ly: TGDIPButtonLayout;
  r: TGPRectF;
begin
  ly := Layout;

  DrawColor := Color;

  ph := Height;

  r := MakeRect(x, y, Width, Height);
  p := CreateRoundRectangle(r, 4, rtBoth, false);
  b := TGPLinearGradientBrush.Create(MakeRect(r.X - 1, r.Y - 1, r.Width + 2, r.Height + 2), MakeColor(Opacity, DrawColor), MakeColor(Opacity, Drawcolor), LinearGradientModeVertical);
  g.FillPath(b, p);
  p.Free;


  r := MakeRect(x, y, Width, Height / 2);
  p := CreateRoundRectangle(r, 4, rttop, false);
  b := TGPLinearGradientBrush.Create(MakeRect(r.X - 1, r.Y - 1, r.Width + 2, r.Height + 2), MakeColor(125, clWhite), MakeColor(30, clWhite), LinearGradientModeVertical);
  g.FillPath(b, p);
  p.Free;
  b.Free;

  tw := 0;
  th := 0;

  if Border and (BorderWidth > 0) then
  begin
    p := CreateRoundLine(Bounds(Round(X), Round(Y), Round(Width), Round(Height)), 4, rtBoth, BorderWidth);
    bs := TGPSolidBrush.Create(MakeColor(BorderOpacity, BorderColor));
    g.FillPath(bs,p);
    bs.Free;
    p.Free;
  end;

  ////Button Caption///
  if Caption <> '' then
  begin
    if Down then
      textr := MakeRect(1 + x,1 + y,Width,ph)
    else
      textr := MakeRect(x,y,Width,ph);

    if (Picture <> nil) and (Picture.Empty = false)  then
    begin
      Picture.GetImageSizes;
      case ly of
        blPictureRight, blPictureLeft: textr.Width := textr.Width - picture.Width - Spacing;
        blPictureTop, blPictureBottom: textr.Height := textr.Height - picture.Height - Spacing;
      end;
    end;


    ff := TGPFontFamily.Create(Font.Name);

    fs := 0;
    if (fsBold in Font.Style) then
      fs := fs + 1;
    if (fsItalic in Font.Style) then
      fs := fs + 2;
    if (fsUnderline in Font.Style) then
      fs := fs + 4;

    stringformat := TGPStringFormat.Create(0);

    g.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

    f := TGPFont.Create(ff, Font.Size , fs, UnitPoint);

    g.MeasureString(Caption, Length(Caption), f, textr, stringformat, sizer);

    bs := TGPSolidBrush.Create(ColorToARGB(Font.Color));

    tw := sizer.Width;
    th := sizer.Height;

    pt := MakePoint(textr.X + (textr.Width - tw) / 2, textr.Y + (textr.Height - th) / 2);
    if (Picture <> nil) and not Picture.Empty then
    begin
      case ly of
        blPictureLeft:
        begin
          pt := MakePoint(textr.X + (textr.Width - tw) / 2,
            textr.Y + (textr.Height - th) / 2);

          if pt.X < Spacing then
            pt.X := Spacing;

          pt.X := pt.X + Picture.Width + Spacing;
        end;
        blPictureRight:
        begin
          pt := MakePoint(textr.X + (textr.Width - tw) / 2,
            textr.Y + (textr.Height - th) / 2);

          if pt.X < Spacing then
          begin
            pt.X := Spacing;
            tw := Width - Picture.Width - Spacing - Spacing;
            textr.Width := tw;
          end;

        end;
        blPictureBottom:
        begin
          pt := MakePoint(textr.X + (textr.Width - tw) / 2,
            textr.Y + (textr.Height - th) / 2);
        end;
        blPictureTop:
        begin
          pt := MakePoint(textr.X + (textr.Width - tw) / 2,
            textr.Y + (textr.Height - th) / 2);
          pt.Y := pt.Y + Picture.Height + Spacing;
        end;
      end;
    end;

    textr := MakeRect(pt.X, pt.Y, sizer.Width, sizer.Height);//textr.Width - (pt.X - X), textr.Height - (pt.Y - Y));
    stringFormat.SetHotkeyPrefix(HotkeyPrefixShow);
    if WW then
      g.DrawString(Caption, Length(Caption), f, textr, stringformat, bs)
    else
      g.DrawString(Caption, Length(Caption), f, pt, stringformat, bs);
    bs.Free;
    f.Free;
    ff.Free;
  end;

  if (Picture <> nil) and not Picture.Empty then
  begin
    Picture.GetImageSizes;
    l := (Width - Picture.Width) div 2;
    t := (ph - Picture.Height) div 2;
    if Down then
    begin
      l := l + 2;
      t := t + 2;
    end;

    if Caption <> '' then
    begin
      case ly of
        blPictureLeft:
        begin
          l := Round(pt.X - Picture.Width - Spacing);
          Picture.GDIPDraw(g, Bounds(l, t + y, Picture.Width, Picture.Height));
        end;
        blPictureRight:
        begin
          l := Round(pt.X + tw + spacing);
          Picture.GDIPDraw(g, Bounds(l, t + y, Picture.Width, Picture.Height));
        end;
        blPictureBottom:
        begin
          t := Round(pt.Y + th + spacing);
          Picture.GDIPDraw(g, Bounds(l + x, t, Picture.Width, Picture.Height));
        end;
        blPictureTop:
        begin
          t := Round(pt.Y - Picture.Height - Spacing);
          Picture.GDIPDraw(g, Bounds(l + x, t, Picture.Width, Picture.Height));
        end;
      end;
    end
    else
    begin
      Picture.GDIPDraw(g, Bounds(l + x, t + y, Picture.Width, Picture.Height));
    end;
  end;
end;

procedure TGDIPDialogButton.FontChanged(Sender: TObject);
begin
  Changed;
end;

procedure TGDIPDialogButton.SetFont(const Value: TFont);
begin
  if (FFont <> value) then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TGDIPDialogButton.SetLayout(const Value: TGDIPButtonLayout);
begin
  if FLayout <> value then
  begin
    FLayout := Value;
    Changed;
  end;
end;

procedure TGDIPDialogButton.SetSpacing(const Value: integer);
begin
  if FSpacing <> value then
  begin
    FSpacing := Value;
    Changed;
  end;
end;

initialization
  CF_GDIPFILL := RegisterClipboardFormat('GDI+ Fill');

end.
