{***************************************************************************}
{ TAdvShapeButton component                                                 }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright � 2006 - 2009                                        }
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

unit AdvShapeButton;

{$I TMSDEFS.INC}

{$DEFINE TMS_DWM}

interface

uses
  Classes, Windows, Forms, Dialogs, Controls, Graphics, Messages, ExtCtrls,
  SysUtils, Math, GDIPicture, ActnList, AdvHintInfo, AdvPreviewMenu, AdvGlowButton,
  AdvToolBar, AdvGDIP, AdvDWM, AdvTBXPVS;


const

  MAJ_VER = 1; // Major version nr.
  MIN_VER = 1; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history:
  // 1.0.0.0 : first release
  // 1.0.0.1 : fixed issue with menu positioning on multimonitor screens
  // 1.0.1.0 : TabOrder, TabStop capability added & keyboard support
  // 1.0.1.1 : Fixed : painting for Windows Vista when TAdvToolBarPager is directly on TForm
  // 1.0.1.2 : Fixed : issue with compiling for C++Builder
  // 1.1.0.0 : New : Text property to put text on top of the shapebutton image
type
  TAdvCustomShapeButton = class;
  TInternalAdvPreviewMenu = class(TAdvPreviewMenu);
  
  TAdvToolButtonStyle = (tasButton, tasCheck);
  TAdvButtonState = (absUp, absDisabled, absDown, absDropDown, absExclusive);

{$IFDEF DELPHI6_LVL}
  TAdvShapeButtonActionLink = class(TControlActionLink)
  protected
    FClient: TAdvCustomShapeButton;
    procedure AssignClient(AClient: TObject); override;
    function IsCheckedLinked: Boolean; override;
    function IsGroupIndexLinked: Boolean; override;
    procedure SetGroupIndex(Value: Integer); override;
    procedure SetChecked(Value: Boolean); override;
  end;
{$ENDIF}

  TAdvCustomShapeButton = class(TCustomControl)
  private
    FGroupIndex: Integer;
    FDown: Boolean;
    FAllowAllUp: Boolean;
    FOffSet: integer;
    FMouseInControl: Boolean;
    FHot: Boolean;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FStyle: TAdvToolButtonStyle;
    FState: TAdvButtonState;
    FMouseDownInControl: Boolean;
    FGrouped: Boolean;
    FDragging: Boolean;
    FPropHot: Boolean;
    FUnHotTimer: TTimer;
    FInitialDown: Boolean;
    FOfficeHint: TAdvHintInfo;
    FIPictureDown: TGDIPPicture;
    FIPictureDisabled: TGDIPPicture;
    FIPicture: TGDIPPicture;
    FIPictureHot: TGDIPPicture;
    FAdvPreviewMenu: TAdvPreviewMenu;
    FShortCutHint: TShortCutHintWindow;
    FShortCutHintPos: TShortCutHintPos;
    FShortCutHintText: string;
    FPreviewMenuOffSet: Integer;
    FInternalClick: Boolean;
    FIsAeroVista: Boolean;
{$IFDEF DELPHI_UNICODE}
    FRef: Boolean;
    FRefGlowButton: TAdvGlowButton;
{$ENDIF}
    FShowMenuTimer: TTimer;
    FCanShowMenu: Boolean;
    FMenuBeingShown: Boolean;
    procedure OnShowMenuTime(Sender: TObject);
    procedure UnHotTimerOnTime(Sender: TObject);
    procedure UpdateExclusive;
    procedure UpdateTracking;
    procedure ButtonDown;
    procedure ShowMenu;
    procedure OnPictureChanged(Sender: TObject);
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    procedure WMLButtonDblClk(var Message: TWMLButtonDown); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
{$IFNDEF TMSDOTNET}
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
{$ENDIF}
    procedure ShapePaint(Sender: TObject; Canvas: TCanvas; R: TRect);
    procedure OnPreviewMenuHide(Sender: TObject);
    procedure SetDown(Value: Boolean);
    procedure SetAllowAllUp(Value: Boolean);
    procedure SetGroupIndex(Value: Integer);
    procedure SetStyle(const Value: TAdvToolButtonStyle);
    procedure SetState(const Value: TAdvButtonState);
    procedure SetGrouped(const Value: Boolean);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
    function GetHot: Boolean;
    procedure SetHot(const Value: Boolean);
    procedure SetOfficeHint(const Value: TAdvHintInfo);
    procedure SetIPicture(const Value: TGDIPPicture);
    procedure SetIPictureDisabled(const Value: TGDIPPicture);
    procedure SetIPictureDown(const Value: TGDIPPicture);
    procedure SetIPictureHot(const Value: TGDIPPicture);
    procedure SetAdvPreviewMenu(const Value: TAdvPreviewMenu);
  protected
    procedure SetParent(AParent: TWinControl); override;
{$IFDEF DELPHI6_LVL}
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
{$ENDIF}
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DrawButton(ACanvas: TCanvas); virtual;
    procedure DrawImage(ACanvas: TCanvas); virtual;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure DblClick; override;

    procedure InvalidateMe;
    property MouseInControl: Boolean read FMouseInControl;
    property State: TAdvButtonState read FState write SetState;

    // published
    property Action;
    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property Anchors;
    property BiDiMode;

    property Constraints;
    property Grouped: Boolean read FGrouped write SetGrouped default False;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Down: Boolean read FDown write SetDown default False;
    property Enabled;
    property Font;
    property Hot: Boolean read GetHot write SetHot default false;

    property Picture: TGDIPPicture read FIPicture write SetIPicture;
    property PictureHot: TGDIPPicture read FIPictureHot write SetIPictureHot;
    property PictureDown: TGDIPPicture read FIPictureDown write SetIPictureDown;
    property PictureDisabled: TGDIPPicture read FIPictureDisabled write SetIPictureDisabled;

    property AdvPreviewMenu: TAdvPreviewMenu read FAdvPreviewMenu write SetAdvPreviewMenu;

    property ParentFont;
    property ParentShowHint;
    property ParentBiDiMode;
    property PopupMenu;
    property ShowHint;
    property OfficeHint: TAdvHintInfo read FOfficeHint write SetOfficeHint;
    property Style: TAdvToolButtonStyle read FStyle write SetStyle default tasButton;
    property ShortCutHint: string read FShortCutHintText write FShortCutHintText;
    property ShortCutHintPos: TShortCutHintPos read FShortCutHintPos write FShortCutHintPos default shpCenter;
    property Version: string read GetVersion write SetVersion;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
{$IFDEF TMSDOTNET}
    procedure ButtonPressed(Group: Integer; Button: TAdvCustomShapeButton);
{$ENDIF}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function GetVersionNr: Integer; virtual;

    procedure ShowShortCutHint;
    procedure HideShortCutHint;
  end;

  TAdvShapeButton = class(TAdvCustomShapeButton)
  public
  published
    property Action;
    property AdvPreviewMenu;
    property AllowAllUp;
    property Constraints;
    property GroupIndex;
    property Down;
    property Enabled;
    property Font;
    property Picture;
    property PictureHot;
    property PictureDown;
    property PictureDisabled;
    property ParentFont;
    property ParentShowHint;
    property ParentBiDiMode;
    property PopupMenu;
    property OfficeHint;
    property ShowHint;
    property ShortCutHint;
    property ShortCutHintPos;
    property TabStop;
    property TabOrder;
    property Text;
    property Style;
    property Version;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
  end;



implementation

uses
  ActiveX
  {$IFDEF DELPHI7_LVL}
  , Themes
  {$ELSE}
  , AdvThemes
  {$ENDIF};

var
  WM_SBDRAWIMAGE: Word;

//------------------------------------------------------------------------------

function IsVista: boolean;
var
  hKernel32: HMODULE;
begin
  hKernel32 := GetModuleHandle('kernel32');
  if (hKernel32 > 0) then
  begin
    Result := GetProcAddress(hKernel32, 'GetLocaleInfoEx') <> nil;
  end
  else
    Result := false;
end;

//------------------------------------------------------------------------------

function IsComCtl6: Boolean;
var
  i: Integer;
begin
  i := GetFileVersion('COMCTL32.DLL');
  i := (i shr 16) and $FF;

  Result := (i > 5);
end;

//------------------------------------------------------------------------------

function AeroIsEnabled: boolean;
var
  enabled: bool;
begin
  Result := False;
  //if (DWMlibrary = 0) then
  begin
    if (@DwmIsCompositionEnabled <> nil) then
    begin
      DwmIsCompositionEnabled(enabled);
      Result := enabled;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure DrawGDIPImage(graphics: TGPGraphics; P: TPoint; Pic: TGDIPPicture);
var
  Img: TGPImage;
  pstm: IStream;
  hGlobal: THandle;
  pcbWrite: Longint;
  ms: TMemoryStream;
  ImageAttributes: TGPImageAttributes;
  r, g, b: byte;
  GPBmp: TGPBitmap;
  Aclr: TGPColor;
begin
  ms := TMemoryStream.Create;
  pic.SaveToStream(ms);
  hGlobal := GlobalAlloc(GMEM_MOVEABLE, ms.Size);
  if (hGlobal = 0) then
  begin
    ms.Free;
    raise Exception.Create('Could not allocate memory for image');
  end;

  try
    pstm := nil;

    // Create IStream* from global memory
    CreateStreamOnHGlobal(hGlobal, TRUE, pstm);
    pstm.Write(ms.Memory, ms.Size,@pcbWrite);

    Img := TGPImage.Create(pstm);

    if (Img.GetFormat = ifBMP) then
    begin

      GPBmp := TGPBitmap.Create(pstm);
      GPBmp.GetPixel(0, Img.GetHeight - 1, AClr);
      GPBmp.Free;

      r := ADVGDIP.GetRed(AClr);
      g := ADVGDIP.GetGreen(AClr);
      b := ADVGDIP.GetBlue(AClr);

      ImageAttributes := TGPImageAttributes.Create;
      ImageAttributes.SetColorKey(MakeColor(r, g, b), MakeColor(r, g, b), ColorAdjustTypeDefault);
      graphics.DrawImage(Img, MakeRect(P.X, P.Y, Img.GetWidth, Img.Getheight),  // destination rectangle
       0, 0,        // upper-left corner of source rectangle
       Img.GetWidth,       // width of source rectangle
       Img.GetHeight,      // height of source rectangle
       UnitPixel,
       ImageAttributes);
       
      //graphics.DrawImage(Img, P.X, P.y);

      ImageAttributes.Free;
    end
    else
      graphics.DrawImageRect(Img, p.X, p.Y, Img.GetWidth, Img.GetHeight);

    Img.Free;
    ms.Free;
  finally
    GlobalFree(hGlobal);
  end;
end;

//------------------------------------------------------------------------------

function DrawGDIPText(Canvas: TCanvas; g: TGPGraphics; Alignment: TAlignment; r: TRect; Caption:string; WideCaption: widestring; AFont: TFont; Enabled: Boolean; RealDraw: Boolean; AntiAlias: TAntiAlias): TRect;
var
  graphics : TGPGraphics;
  w,h: Integer;
  fontFamily: TGPFontFamily;
  font: TGPFont;
  rectf: TGPRectF;
  stringFormat: TGPStringFormat;
  solidBrush: TGPSolidBrush;
  x1,y1,x2,y2: single;
  fs: integer;
  sizerect: TGPRectF;
  szRect: TRect;
  DTFLAG: DWORD;
begin
  Result := Rect(0, 0, 0, 0);
  if not Assigned(g) and not Assigned(Canvas) then
    Exit;
    
  if (Caption <> '') or (WideCaption <> '') then
  begin
    graphics := g;
    if not Assigned(graphics) then
      graphics := TGPGraphics.Create(Canvas.Handle);
    fontFamily:= TGPFontFamily.Create(AFont.Name);

    if (fontFamily.Status in [FontFamilyNotFound, FontStyleNotFound]) then
    begin
      fontFamily.Free;
      fontFamily := TGPFontFamily.Create('Arial');
    end;
    

    fs := 0;

    if (fsBold in AFont.Style) then
      fs := fs + 1;

    if (fsItalic in AFont.Style) then
      fs := fs + 2;

    if (fsUnderline in AFont.Style) then
      fs := fs + 4;

    font := TGPFont.Create(fontFamily, AFont.Size , fs, UnitPoint);

    graphics.SetSmoothingMode(SmoothingModeAntiAlias);

    w := R.Right - R.Left;
    h := R.Bottom - R.Top;

    x1 := r.Left;
    y1 := r.Top;
    x2 := w;
    y2 := h;

    rectf := MakeRect(x1,y1,x2,y2);

    stringFormat := TGPStringFormat.Create;

    if Enabled then
      solidBrush := TGPSolidBrush.Create(ColorToARGB(AFont.Color))
    else
      solidBrush := TGPSolidBrush.Create(ColorToARGB(clGray));

    case Alignment of
      taLeftJustify: stringFormat.SetAlignment(StringAlignmentNear);
      taCenter:
      begin
        // Center-justify each line of text.
        stringFormat.SetAlignment(StringAlignmentCenter);
      end;
      taRightJustify: stringFormat.SetAlignment(StringAlignmentFar);
    end;

    // Center the block of text (top to bottom) in the rectangle.

    stringFormat.SetLineAlignment(StringAlignmentCenter);
    stringFormat.SetHotkeyPrefix(HotkeyPrefixShow);
    stringFormat.SetTrimming(StringTrimmingNone);


    case AntiAlias of
    aaClearType:graphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
    aaAntiAlias:graphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
    end;

    // graphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);

    if (AntiAlias = aaNone) then
    begin
      szRect.Left := round(rectf.X);
      szRect.Top := round(rectf.Y);

      szRect.Right := szRect.Left + 2;

      if (Caption <> '') then
        szRect.Bottom := DrawText(Canvas.Handle,PChar(Caption),Length(Caption), szrect, DT_CALCRECT or DT_LEFT or DT_WORDBREAK)
      else
        szRect.Bottom := DrawTextW(Canvas.Handle,PWideChar(WideCaption),Length(WideCaption), szrect, DT_CALCRECT or DT_LEFT or DT_WORDBREAK);

      sizeRect.X := szRect.Left;
      sizeRect.Y := szRect.Top;
      sizeRect.Width := szRect.Right - szRect.Left;
      sizeRect.Height := szRect.Bottom - szRect.Top;
    end
    else
    begin
      fillchar(sizerect,sizeof(sizerect),0);

      if (Caption <> '') then
        graphics.MeasureString(Caption, Length(Caption), font, rectf, stringFormat, sizerect)
      else
        graphics.MeasureString(WideCaption, Length(WideCaption), font, rectf, stringFormat, sizerect)
    end;

    Result := Rect(round(sizerect.X), Round(sizerect.Y), Round(sizerect.X + sizerect.Width), Round(sizerect.Y + sizerect.Height));
    rectf := MakeRect(x1,y1,x2,y2);

    if RealDraw then
    begin
      if (AntiAlias = aaNone) then
      begin
        szRect.Left := round(rectf.X);
        szRect.Top := round(rectf.Y);
        szRect.Right := szRect.Left + round(rectf.Width);
        szRect.Bottom := szRect.Top + round(rectf.Height);
        Canvas.Brush.Style := bsClear;

        DTFLAG := DT_LEFT;
        case Alignment of
        taRightJustify: DTFLAG := DT_RIGHT;
        taCenter: DTFLAG := DT_CENTER;
        end;
        if Caption <> '' then
          DrawText(Canvas.Handle,PChar(Caption),Length(Caption), szrect, DTFLAG or DT_VCENTER or DT_SINGLELINE)
        else
          DrawTextW(Canvas.Handle,PWideChar(WideCaption),Length(WideCaption), szrect, DTFLAG or DT_VCENTER or DT_SINGLELINE)
      end
      else
      begin
        if (Caption <> '') then
          graphics.DrawString(Caption, Length(Caption), font, rectf, stringFormat, solidBrush)
        else
          graphics.DrawString(WideCaption, Length(WideCaption), font, rectf, stringFormat, solidBrush)
      end;
    end;
    stringformat.Free;
    solidBrush.Free;
    font.Free;
    fontfamily.Free;
    if not Assigned(g) then
      graphics.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure DrawBlurredText(WinCtrl: TWinControl; Canvas: TCanvas; Text: string; R: TRect; Align: TAlignment; Pic: TGDIPPicture);
{$IFDEF DELPHI2006_LVL}
  procedure DoDrawThemeTextEx(DC: HDC; const Text: string; TextLen: Integer;
    var TextRect: TRect; HTheme: THandle; TextFlags: Cardinal);
  var
    Options: TDTTOpts;
  begin
    FillChar(Options, SizeOf(Options), 0);
    Options.dwSize := SizeOf(Options);
    Options.dwFlags := DTT_TEXTCOLOR or DTT_COMPOSITED or DTT_GLOWSIZE {or DTT_SHADOWTYPE};
    Options.iGlowSize := 12;
    with ThemeServices.GetElementDetails(teEditTextNormal) do
      DrawThemeTextEx(HTheme{ThemeServices.Theme[teEdit]}, DC, Part, State,
        PWideChar(WideString(Text)), TextLen, TextFlags, @TextRect, Options);
  end;
{$ENDIF}
var
  HTheme: THandle;
  dc, hdcPaint: HDC;
  {$IFDEF DELPHI2006_LVL}
  dt: DTTOPTS;
  {$ENDIF}
  cx, cy: Integer;
  CR: TRect;
  dib: BITMAPINFO;
  hbm, hbmOld: HBITMAP;
  pr: Pointer;
  lgFont: LOGFONT;
  hFontOld, hFont: LongWord;
  R2: TRect;
begin
  HTheme := OpenThemeData(WinCtrl.Handle,'CompositedWindow::Window');
  if (HTheme > 0) then
  begin
    dc := GetDC(WinCtrl.Handle);
    hdcPaint := CreateCompatibleDC(dc);
    if (hdcPaint > 0) then
    begin
      CR := WinCtrl.ClientRect;
      cx := R.Right - R.Left;
      cy := R.Bottom - R.Top;

      dib.bmiHeader.biSize            := sizeof(BITMAPINFOHEADER);
      dib.bmiHeader.biWidth           := cx;
      dib.bmiHeader.biHeight          := -cy;
      dib.bmiHeader.biPlanes          := 1;
      dib.bmiHeader.biBitCount        := 32;{BIT_COUNT};
      dib.bmiHeader.biCompression     := BI_RGB;

      pr := nil;
      hbm := CreateDIBSection(dc, dib, DIB_RGB_COLORS, pr, 0, 0);
      if (hbm > 0) then
      begin
        hbmOld := HBITMAP(SelectObject(hdcPaint, hbm));

        {$IFDEF DELPHI2006_LVL}
        // Setup the theme drawing options.
        //dt := sizeof(DTTOPTS);
        dt.dwFlags := DTT_COMPOSITED or DTT_GLOWSIZE;
        dt.iGlowSize := 15;
        {$ENDIF}

        // Select a font.
        hFontOld := 0;
        hFont := 0;
        if (SUCCEEDED(GetThemeSysFont(hTheme, TMT_CAPTIONFONT, lgFont))) then
        begin
          hFont := CreateFontIndirect(lgFont);
          hFontOld := LongWord(SelectObject(hdcPaint, hFont));
        end;

        if Assigned(Pic) and not Pic.Empty then
        begin
          PostMessage(WinCtrl.Handle, WM_SBDRAWIMAGE, 0, 0);
        end;

        // Draw the title.
        R2 := Rect(4, R.Top + 6, cx, cy);
        {$IFDEF DELPHI2006_LVL}
        DoDrawThemeTextEx(hdcPaint, Text, Length(Text), R2, HTheme, DT_EXPANDTABS or DT_LEFT or DT_VCENTER or DT_END_ELLIPSIS);
        {$ENDIF}

        // Blit text to the frame.
        BitBlt(dc, R.Left, R.Top, cx, cy, hdcPaint, 0, 0, SRCCOPY);

        SelectObject(hdcPaint, hbmOld);
        if (hFontOld > 0) then
        begin
          SelectObject(hdcPaint, hFontOld);
          if (hFont > 0) then          
            DeleteObject(hFont);
        end;

        DeleteObject(hbm);
      end;
      DeleteDC(hdcPaint);
    end;
    ReleaseDC(WinCtrl.Handle, dc);
    CloseThemeData(hTheme);
  end;
end;

//------------------------------------------------------------------------------

{$IFDEF DELPHI6_LVL}

{ TAdvShapeButtonActionLink }

procedure TAdvShapeButtonActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TAdvCustomShapeButton;
end;

//------------------------------------------------------------------------------

function TAdvShapeButtonActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked {and (FClient.GroupIndex <> 0) and
    FClient.AllowAllUp} and (FClient.Down = (Action as TCustomAction).Checked);
end;

//------------------------------------------------------------------------------

function TAdvShapeButtonActionLink.IsGroupIndexLinked: Boolean;
begin
  Result := (FClient is TAdvCustomShapeButton) and
    (TAdvCustomShapeButton(FClient).GroupIndex = (Action as TCustomAction).GroupIndex);
end;

//------------------------------------------------------------------------------

procedure TAdvShapeButtonActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked then TAdvCustomShapeButton(FClient).Down := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvShapeButtonActionLink.SetGroupIndex(Value: Integer);
begin
  if IsGroupIndexLinked then TAdvCustomShapeButton(FClient).GroupIndex := Value;
end;

{$ENDIF}

//------------------------------------------------------------------------------

{ TAdvCustomShapeButton }

constructor TAdvCustomShapeButton.Create(AOwner: TComponent);
begin
{$IFNDEF DELPHI6_LVL}
  FIsAeroVista := False;
{$ELSE}
  FIsAeroVista := IsComCtl6 and IsVista and ThemeServices.ThemesEnabled and AeroIsEnabled and not (csDesigning in ComponentState);
{$ENDIF}  

{$IFNDEF TMS_DWM}
  FIsAeroVista := False;
{$ENDIF}  
  inherited Create(AOwner);

  if (csDesigning in ComponentState) then
    FIsAeroVista := False;

  //ControlStyle := [csCaptureMouse, csDoubleClicks, csClickEvents];
  ControlStyle := ControlStyle + [csCaptureMouse, csDoubleClicks, csClickEvents];
  {$IFDEF DELPHI7_LVL}
  if FIsAeroVista then
    ControlStyle := ControlStyle + [csParentBackground] - [csOpaque];
  {$ENDIF}  

  FIPicture := TGDIPPicture.Create;
  FIPicture.OnChange := OnPictureChanged;

  FIPictureHot := TGDIPPicture.Create;
  FIPictureDown := TGDIPPicture.Create;

  FIPictureDisabled := TGDIPPicture.Create;
  FIPictureDisabled.OnChange := OnPictureChanged;

  SetBounds(0, 0, 23, 22);
  ControlStyle := [csCaptureMouse, csDoubleClicks, csClickEvents];
  ParentFont := True;

  // make sure to use a Truetype font
  Font.Name := 'Tahoma';

  FOffSet := 4;

  FStyle := tasButton;
  FGroupIndex := 0;
  FGrouped := true;

  FUnHotTimer := TTimer.Create(self);
  FUnHotTimer.Interval := 1;
  FUnHotTimer.Enabled := false;
  FUnHotTimer.OnTimer := UnHotTimerOnTime;

  FOfficeHint := TAdvHintInfo.Create;
  FShortCutHint := nil;
  FShortCutHintPos := shpCenter;
  FShortCutHintText := '';

  ShowHint := False;
  if not FIsAeroVista then
    DoubleBuffered := True;

  {$IFDEF DELPHI7_LVL}
  if FIsAeroVista then
    ParentBackground := True;
  {$ENDIF}  

{$IFDEF DELPHI_UNICODE}
  if FIsAeroVista then
  begin
    FRefGlowButton := TAdvGlowButton.Create(Self);
    with FRefGlowButton do
    begin
      Parent := Self;
      Align := alNone;
      Left := 1;
      Top := 1;
      Height := 1;
      Width := 1;
      TabStop := False;
    end;
  end;
{$ENDIF}
  //Width := 32;
  //Height := 32;
  FShowMenuTimer := TTimer.Create(Self);
  FShowMenuTimer.Enabled := False;
  FShowMenuTimer.Interval := 100;
  FShowMenuTimer.OnTimer := OnShowMenuTime;
end;

//------------------------------------------------------------------------------

destructor TAdvCustomShapeButton.Destroy;
begin
  FShowMenuTimer.Free;
  if Assigned(FShortCutHint) then
    FShortCutHint.Free;
  FIPicture.Free;
  FIPictureHot.Free;
  FIPictureDown.Free;
  FIPictureDisabled.Free;
  FUnHotTimer.Free;
  FOfficeHint.Free;
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.CMDialogChar(var Message: TCMDialogChar);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.CMFontChanged(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if (csDesigning in ComponentState) then
    Exit;

  FMouseInControl := true;
  if Enabled then
  begin
    //if Assigned(FAdvToolBar) then
    begin
      //Hot := True;
    end;
    InvalidateMe;
  end;
  FUnHotTimer.Enabled := True;

  if Assigned(FOnMouseEnter) then
     FOnMouseEnter(Self);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;

  if (csDesigning in ComponentState) then
    exit;

  FUnHotTimer.Enabled := False;
  FMouseInControl := false;
  FHot := false;

  //if Assigned(FAdvToolBar) then
    //if not (FAdvToolBar.FInMenuLoop and FAdvToolBar.FMenuFocused) then
      //Hot := False;

  if Enabled then
    InvalidateMe;

  if Assigned(FOnMouseLeave) then
     FOnMouseLeave(Self);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.CMSysColorChange(var Message: TMessage);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.CMTextChanged(var Message: TMessage);
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.Loaded;
begin
  inherited;

  if (Down <> FInitialDown) then
    Down := FInitialDown;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if (Button <> mbLeft) or not Enabled or (csDesigning in ComponentState) then
    Exit;

  FMouseDownInControl := true;

  ButtonDown;

  if not FDown then
  begin
    FState := absDown;
    Invalidate;
  end;

  if Style = tasCheck then
  begin
    FState := absDown;
    Repaint;
  end;

  FDragging := True;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.MouseMove(Shift: TShiftState; X,
  Y: Integer);
var
  NewState: TAdvButtonState;
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  if FDragging then
  begin
    if (not FDown) then NewState := absUp
    else NewState := absExclusive;

    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
      if FDown then NewState := absExclusive else NewState := absDown;

    if (Style = tasCheck) and FDown then
    begin
      NewState := absDown;
    end;

    if NewState <> FState then
    begin
      FState := NewState;
      Invalidate;
    end;
  end
  else if not FMouseInControl then
    UpdateTracking;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  DoClick: Boolean;
begin
  inherited;

  if (csDesigning in ComponentState) then
    exit;

  FMouseDownInControl := false;
  InvalidateMe;

  if FDragging then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
    if FGroupIndex = 0 then
    begin
      // Redraw face in-case mouse is captured
      FState := absUp;
      FMouseInControl := False;
      FHot := false;

      if Style = tasCheck then
      begin
        SetDown(not FDown);
        FState := absUp;
      end;

      if DoClick and not (FState in [absExclusive, absDown]) then
        Invalidate;
    end
    else
      if DoClick then
      begin
        SetDown(not FDown);
        if FDown then Repaint;
      end
      else
      begin
        if FDown then
          FState := absExclusive;
        Repaint;
      end;
    //if DoClick then Click;
    UpdateTracking;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;

  if not (csDestroying in ComponentState) and (AOperation = opRemove) then
  begin
    if (AComponent = AdvPreviewMenu) then
      AdvPreviewMenu := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.WMLButtonDblClk(var Message: TWMLButtonDown);
begin
  FCanShowMenu := False;
  FMenuBeingShown := False;
  FMouseDownInControl := False;
  inherited;
  FMouseDownInControl := False;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.DblClick;
begin
  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.WndProc(var Message: TMessage);
begin
  inherited;
  if (Message.Msg = WM_SBDRAWIMAGE) then
  begin
    DrawImage(Canvas);
  end;

  if (Message.Msg = WM_SETTEXT) then
    Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.Paint;
var
  Rgn1: HRGN;
  R: TRect;
  i: Integer;
  p: TPoint;
begin
  if not Enabled then
  begin
    FState := absDisabled;
    FDragging := False;
  end
  else
  begin
    if (FState = absDisabled) then
      if FDown and (GroupIndex <> 0) then
        FState := absExclusive
      else
        FState := absUp;
  end;

  if (Style = tasCheck) and (Down) then
  begin
    FState := absDown;
  end;

  if True and not FIsAeroVista then
  begin
    // TRANSPARENCY CODE

    R := ClientRect;
    rgn1 :=  CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);
    SelectClipRgn(Canvas.Handle, rgn1);

    i := SaveDC(Canvas.Handle);
    p := ClientOrigin;
    Windows.ScreenToClient(Parent.Handle, p);
    p.x := -p.x;
    p.y := -p.y;
    MoveWindowOrg(Canvas.Handle, p.x, p.y);

    SendMessage(Parent.Handle, WM_ERASEBKGND, Canvas.Handle, 0);
    // transparency ?
    SendMessage(Parent.Handle, WM_PAINT, Canvas.Handle, 0);

    if (Parent is TWinCtrl) then
     (Parent as TWinCtrl).PaintCtrls(Canvas.Handle, nil);

    RestoreDC(Canvas.Handle, i);

    SelectClipRgn(Canvas.Handle, 0);
    DeleteObject(rgn1);
  end;

  //inherited;

  DrawButton(Canvas);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.DrawButton(ACanvas: TCanvas);
var
  Pic: TGDIPPicture;
  x, y: Integer;
  graphics: TGPGraphics;
  R: TRect;
  //bmp: TBitmap;
begin
  R := ClientRect;
  if FIsAeroVista then
  begin
    DrawBlurredText(Self, Self.Canvas, '', Rect(R.Left, R.Top, R.Right, 27 - Top), taLeftJustify, Picture);
    Canvas.Brush.Color := Color; //$00FFDBBF;
    Canvas.FillRect(Rect(R.Left, 27 - Top, R.Right, R.Bottom));
    Canvas.Pen.Color := clBlack;
    Canvas.MoveTo(R.Left, 28 - Top);
    Canvas.LineTo(R.Right, 28 - Top);
  end;

  Pic := Picture;
  if not Enabled and not PictureDisabled.Empty then
    Pic := PictureDisabled
  else if ((FMouseDownInControl and FMouseInControl) or (Down) or ((Assigned(AdvPreviewMenu) and (TInternalAdvPreviewMenu(AdvPreviewMenu).visible))) or FMenuBeingShown) and not PictureDown.Empty then
    Pic := PictureDown
  else if (FMouseInControl or Self.Focused) and not PictureHot.Empty then
    Pic := PictureHot;

  if Assigned(Pic) and not Pic.Empty then
  begin
    Pic.GetImageSizes;
    x := (Width - Pic.Width) div 2;
    y := (Height - Pic.Height) div 2;

    if not FIsAeroVista then
    begin
      ACanvas.Draw(x, y, Pic);
      DrawGDIPText(ACanvas, nil, taCenter, R, Text, '', Font, Enabled, True, aaAntiAlias);
    end
    else
    begin
      graphics := TGPGraphics.Create(Canvas.Handle);
      graphics.SetSmoothingMode(SmoothingModeAntiAlias);
      DrawGDIPImage(graphics, Point(x, y), Pic);

      DrawGDIPText(nil, graphics, taCenter, R, Text, '', Font, Enabled, True, aaAntiAlias);
      graphics.Free;
    end;
  end
  else
  begin
    ACanvas.Pen.Style := psDot;
    ACanvas.Pen.Color := clBlue;
    ACanvas.Brush.Style := bsClear;
    ACanvas.Rectangle(ClientRect);
  end;

{$IFDEF DELPHI_UNICODE}
  if FIsAeroVista then
  begin
    if FRef then
    begin
      FRef := False;
      if Assigned(FRefGlowButton) then
        FRefGlowButton.Invalidate;
    end
    else
      FRef := True;
  end;
{$ENDIF}
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.DrawImage(ACanvas: TCanvas);
var
  Pic: TGDIPPicture;
  x, y: Integer;
  graphics: TGPGraphics;
  R: TRect;
begin
  R := ClientRect;
  Pic := Picture;
  if not Enabled and not PictureDisabled.Empty then
    Pic := PictureDisabled
  else if ((FMouseDownInControl and FMouseInControl) or (Down) or ((Assigned(AdvPreviewMenu) and (TInternalAdvPreviewMenu(AdvPreviewMenu).visible))) or FMenuBeingShown) and not PictureDown.Empty then
    Pic := PictureDown
  else if (FMouseInControl or Self.Focused) and not PictureHot.Empty then
    Pic := PictureHot;

  if Assigned(Pic) and not Pic.Empty then
  begin
    Pic.GetImageSizes;
    x := (Width - Pic.Width) div 2;
    y := (Height - Pic.Height) div 2;

    if not FIsAeroVista then
    begin
      ACanvas.Draw(x, y, Pic);
      DrawGDIPText(ACanvas, nil, taCenter, R, Text, '', Font, Enabled, True, aaAntiAlias);
    end
    else
    begin
      graphics := TGPGraphics.Create(Canvas.Handle);
      graphics.SetSmoothingMode(SmoothingModeAntiAlias);
      DrawGDIPImage(graphics, Point(x, y), Pic);
      DrawGDIPText(nil, graphics, taCenter, R, Text, '', Font, Enabled, True, aaAntiAlias);
      graphics.Free;
    end;
  end
  else
  begin
    ACanvas.Pen.Style := psDot;
    ACanvas.Pen.Color := clBlue;
    ACanvas.Brush.Style := bsClear;
    ACanvas.Rectangle(ClientRect);
  end;
end;

//------------------------------------------------------------------------------

{$IFNDEF TMSDOTNET}

procedure TAdvCustomShapeButton.UpdateExclusive;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);

    {if Assigned(FAdvToolBar) and not (Parent is TAdvCustomToolBar) then
      FAdvToolBar.Broadcast(Msg)
    else if Assigned(AdvToolBar) and (Parent is TAdvCustomToolBar) and Assigned(AdvToolBar.FOptionWindowPanel) then
      FAdvToolBar.FOptionWindowPanel.Broadcast(Msg);}
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

{$IFDEF TMSDOTNET}

procedure TAdvCustomShapeButton.ButtonPressed(Group: Integer; Button: TAdvCustomShapeButton);
begin
  if (Group = FGroupIndex) and (Button <> Self) then
  begin
    if Button.Down and FDown then
    begin
      FDown := False;
      FState := absUp;
      if (Action is TCustomAction) then
        TCustomAction(Action).Checked := False;
      Invalidate;
    end;
    FAllowAllUp := Button.AllowAllUp;
  end;
end;

procedure TAdvCustomShapeButton.UpdateExclusive;
var
  I: Integer;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    for I := 0 to Parent.ControlCount - 1 do
      if Parent.Controls[I] is TSpeedButton then
        TAdvToolButton(Parent.Controls[I]).ButtonPressed(FGroupIndex, Self);
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.UpdateTracking;
var
  P: TPoint;
begin
  if Enabled then
  begin
    GetCursorPos(P);
    FMouseInControl := not (FindDragTarget(P, True) = Self);
    if FMouseInControl then
      Perform(CM_MOUSELEAVE, 0, 0)
    else
      Perform(CM_MOUSEENTER, 0, 0);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetAllowAllUp(Value: Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetDown(Value: Boolean);
begin
  if (csLoading in ComponentState) then
    FInitialDown := Value;

  if (FGroupIndex = 0) and (Style = tasButton) then
    Value := False;

  if (Style = tasCheck) then
  begin
    FDown := Value;
    if FDown then
      FState := absDown
    else
      FState := absUp;
    Repaint;
    Exit;
  end;

  if Value <> FDown then
  begin
    if FDown and (not FAllowAllUp) then Exit;
    FDown := Value;
    if Value then
    begin
      if FState = absUp then Invalidate;
      FState := absExclusive
    end
    else
    begin
      FState := absUp;
      Repaint;
    end;
    if Value then UpdateExclusive;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetState(const Value: TAdvButtonState);
begin
  if FState <> Value then
  begin
    FState := Value;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetStyle(const Value: TAdvToolButtonStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.InvalidateMe;
begin
  invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited;

end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetGrouped(const Value: Boolean);
begin
  FGrouped := Value;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.ButtonDown;
begin
  //State:= absDown;
//InvalidateMe;
end;

//------------------------------------------------------------------------------

{$IFNDEF TMSDOTNET}

procedure TAdvCustomShapeButton.CMButtonPressed(var Message: TMessage);
var
  Sender: TAdvCustomShapeButton;
begin
  if Message.WParam = FGroupIndex then
  begin
    Sender := TAdvCustomShapeButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;
        FState := absUp;
        if (Action is TCustomAction) then
          TCustomAction(Action).Checked := False;
        Invalidate;
      end;
      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;
{$ENDIF}

//------------------------------------------------------------------------------

{$IFDEF DELPHI6_LVL}

procedure TAdvCustomShapeButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if CheckDefaults or (Self.GroupIndex = 0) then
        Self.GroupIndex := GroupIndex;
      //Self.ImageIndex := ImageIndex;
    end;
end;

//------------------------------------------------------------------------------

function TAdvCustomShapeButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TAdvShapeButtonActionLink;
end;
{$ENDIF}

//------------------------------------------------------------------------------

function TAdvCustomShapeButton.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

function TAdvCustomShapeButton.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetVersion(const Value: string);
begin

end;

//------------------------------------------------------------------------------

function TAdvCustomShapeButton.GetHot: Boolean;
begin
  Result := FPropHot;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetHot(const Value: Boolean);
var
  OldV: Boolean;
begin
  OldV := FPropHot;
  FPropHot := Value;
  if (State <> absUp) then
    FPropHot := false;

  {if Assigned(FAdvToolBar) then
    FAdvToolBar.UpdateButtonHot(self)
  else }
    FPropHot := false;
  if OldV <> FPropHot then
    InvalidateMe;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.UnHotTimerOnTime(Sender: TObject);
var
  CurP: TPoint;
begin
  GetCursorPos(CurP);
  CurP := ScreenToClient(CurP);
  if (not PtInRect(ClientRect, CurP)) then
  begin
    FUnHotTimer.Enabled := False;
    FMouseInControl := false;
    FHot := false;

    {if Assigned(FAdvToolBar) then
      if not (FAdvToolBar.FInMenuLoop and FAdvToolBar.FMenuFocused) then
        Hot := False; }

    if Enabled then
      InvalidateMe;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetParent(AParent: TWinControl);
begin
  inherited;
  if FIsAeroVista and not (csDesigning in ComponentState) then
  begin
    if Assigned(Parent) and not (AParent.Parent is TAdvToolBarForm) then
    begin
      FIsAeroVista := False;
    {$IFDEF DELPHI7_LVL}
      ControlStyle := ControlStyle - [csParentBackground];
    {$ENDIF}
    DoubleBuffered := True;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetOfficeHint(const Value: TAdvHintInfo);
begin
  FOfficeHint.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetIPicture(const Value: TGDIPPicture);
begin
  FIPicture.Assign(Value);
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetIPictureDisabled(const Value: TGDIPPicture);
begin
  FIPictureDisabled.Assign(Value);
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetIPictureDown(const Value: TGDIPPicture);
begin
  FIPictureDown.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetIPictureHot(const Value: TGDIPPicture);
begin
  FIPictureHot.Assign(Value);
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.OnPictureChanged(Sender: TObject);
begin
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.SetAdvPreviewMenu(
  const Value: TAdvPreviewMenu);
begin
  if (FAdvPreviewMenu <> nil) then
  begin
    FAdvPreviewMenu.OnDrawButtonFrameTop := nil;
    TInternalAdvPreviewMenu(AdvPreviewMenu).OnPreviewHide := nil;
  end;

  FAdvPreviewMenu := Value;

  if Assigned(FAdvPreviewMenu) then
  begin
    FAdvPreviewMenu.OnDrawButtonFrameTop := ShapePaint;
    TInternalAdvPreviewMenu(AdvPreviewMenu).OnPreviewHide := OnPreviewMenuHide;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.OnShowMenuTime(Sender: TObject);
begin
  FShowMenuTimer.Enabled := False;
  ShowMenu;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.ShowMenu;
var
  Pt: TPoint;
  DoShowMenuHint: Boolean;
  W, H: Integer;
  R: TRect;
begin
  if not FCanShowMenu or (csDestroying in ComponentState) or (csDesigning in ComponentState) then
    Exit;
    
  DoShowMenuHint := Assigned(FShortCutHint) and FShortCutHint.Visible and not FInternalClick;
  if Assigned(AdvPreviewMenu) then
  begin
    W := 0;
    H := 0;
    FPreviewMenuOffSet := 0;
    TInternalAdvPreviewMenu(AdvPreviewMenu).GetMenuSize(W, H);

    Pt.X := 0;
    Pt.Y := Height - TInternalAdvPreviewMenu(AdvPreviewMenu).TopFrameHeight+2;
    pt := ClientToScreen(pt);

    {$IFDEF DELPHI7_LVL}
    r := Screen.MonitorFromPoint(pt).WorkareaRect;
    {$ELSE}
    SystemParametersInfo(SPI_GETWORKAREA, 0, @R, 0);
    {$ENDIF}

    pt.X := pt.X - 3;

    if (pt.X + w) > R.Right then
    begin
      FPreviewMenuOffSet := (R.Right - (pt.X + w));
      pt.X := pt.X + FPreviewMenuOffSet; {-ve vlaue}
      FAdvPreviewMenu.OnDrawButtonFrameTop := ShapePaint;
      TInternalAdvPreviewMenu(AdvPreviewMenu).OnPreviewHide := OnPreviewMenuHide;
    end;

    AdvPreviewMenu.ShowMenu(Pt.X, Pt.Y);
    if DoShowMenuHint then
      AdvPreviewMenu.ShowShortCutHints;
    FMenuBeingShown := False;  
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.Click;
begin
  if not FInternalClick then
    inherited;
  if Assigned(AdvPreviewMenu) and Enabled and not (csDestroying in ComponentState) and not (csDesigning in ComponentState) then
  begin
    FCanShowMenu := True;
    FShowMenuTimer.Enabled := True;
    FMenuBeingShown := True;
    InvalidateMe;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.ShapePaint(Sender: TObject;
  Canvas: TCanvas; R: TRect);
var
  Pic: TGDIPPicture;
  x, y: Integer;
  R1: TRect;
begin
  Pic := Picture;
  if not Enabled and not PictureDisabled.Empty then
    Pic := PictureDisabled
  else if ((FMouseDownInControl and FMouseInControl) or (Assigned(AdvPreviewMenu) and (TInternalAdvPreviewMenu(AdvPreviewMenu).visible))) and not PictureDown.Empty then
    Pic := PictureDown
  else if FMouseInControl and not PictureHot.Empty then
    Pic := PictureHot;

  if Assigned(Pic) and not Pic.Empty then
  begin
    Pic.GetImageSizes;
    x := (Width - Pic.Width) div 2;
    y := (Height - Pic.Height) div 2;

    x := x - FPreviewMenuOffSet;
    Canvas.Draw(R.Left + 3+x, R.top - (Height - TInternalAdvPreviewMenu(AdvPreviewMenu).TopFrameHeight+2 - y), Pic);

    R1 := Rect(R.Left + 3, R.top - (Height - TInternalAdvPreviewMenu(AdvPreviewMenu).TopFrameHeight+2 - y), 0, 0);
    R1.Right := R1.Left + ClientWidth;
    R1.Bottom := R1.Top + ClientHeight;
    DrawGDIPText(Canvas, nil, taCenter, R1, Text, '', Font, Enabled, True, aaAntiAlias);
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.OnPreviewMenuHide(Sender: TObject);
begin
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.HideShortCutHint;
begin
  if Assigned(FShortCutHint) then
  begin
    FShortCutHint.Visible := false;
    FShortCutHint.Free;
    FShortCutHint := nil;
  end;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.ShowShortCutHint;
var
  pt: TPoint;
begin
  if not Assigned(Parent) then
    Exit;

  if not Assigned(FShortCutHint) then
  begin
    FShortCutHint := TShortCutHintWindow.Create(Self);
    FShortCutHint.Visible := False;
    FShortCutHint.Parent := nil;
    FShortCutHint.ParentWindow := Parent.Handle;

    FShortCutHint.Color := clWhite;
    FShortCutHint.ColorTo := clSilver;

    if (Parent is TAdvToolBarPager) then
    begin
      if Assigned( (Parent as TAdvToolBarPager).ToolBarStyler) then
        FShortCutHint.ColorTo := (Parent as TAdvToolBarPager).ToolBarStyler.GlowButtonAppearance.Color;
    end;
  end;

  FShortCutHint.Caption := FShortCutHintText;

  pt := ClientToScreen(Point(0,0));

  case ShortCutHintPos of
  shpLeft:
    begin
      FShortCutHint.Left := pt.X - (FShortCutHint.Width div 2);
      FShortCutHint.Top := pt.Y + (self.Height - FShortCutHint.Height) div 2;
    end;
  shpTop:
    begin
      FShortCutHint.Left := pt.X + (self.Width - FShortCutHint.Width) div 2;
      FShortCutHint.Top := pt.Y - (FShortCutHint.Height div 2);
    end;
  shpRight:
    begin
      FShortCutHint.Left := pt.X + self.Width - (FShortCutHint.Width div 2);
      FShortCutHint.Top := pt.Y + (self.Height - FShortCutHint.Height) div 2;
    end;
  shpBottom:
    begin
      FShortCutHint.Left := pt.X + (self.Width - FShortCutHint.Width) div 2;
      FShortCutHint.Top := pt.Y + self.Height - (FShortCutHint.Height div 2);
    end;
  shpCenter:
    begin
      FShortCutHint.Left  := pt.X + (self.Width - FShortCutHint.Width) div 2;
      FShortCutHint.Top := pt.Y + (self.Height - FShortCutHint.Height) div 2;
    end;  
    
  end;

  FShortCutHint.Visible := true;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.CMHintShow(var Message: TMessage);
begin
  if (Message.WParam = 1) then
  begin
    if (Message.LParam = 0) then
    //if Assigned(FShortCutHint) and FShortCutHint.Visible then
    begin
      HideShortCutHint;
    end
    else if (Message.LParam = 1) then
    begin
      ShowShortCutHint;
    end;
    Message.Result := 1;
  end;

  inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  Message.Result := 1;
  if not FIsAeroVista then
    inherited;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.CMFocusChanged(
  var Message: TCMFocusChanged);
begin
  inherited;
  Invalidate;
end;

//------------------------------------------------------------------------------

procedure TAdvCustomShapeButton.WMKeyDown(var Message: TWMKeyDown);
begin
  case Message.CharCode of
    VK_RETURN, VK_SPACE:
    begin
      if not FDown then
      begin
        FState := absDown;
        Invalidate;
      end;

      if Style = tasCheck then
      begin
        FState := absDown;
        Repaint;
      end;

      FInternalClick := True;
      Click;
      FInternalClick := False;
    end;
  end;
  inherited;

end;


initialization
WM_SBDRAWIMAGE := RegisterWindowMessage('SBDRAWIMAGE');

end.
