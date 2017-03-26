{**************************************************************************}
{ TAdvSmoothExpanderButtonPanel component                                  }
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

unit AdvSmoothExpanderButtonPanel;

{$I TMSDEFS.inc}

interface

uses
  Windows, Messages, ExtCtrls, SysUtils, Classes, Graphics, Controls, StdCtrls, forms,
  Comobj, Activex, Math, AdvStyleIF, ImgList,
  AdvSmoothGDIP, GDIPPictureContainer, GDIPFill, AdvSmoothExpanderPanel
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
  TAdvSmoothExpanderButtonPanel = class;

  TAdvSmoothExpanderButtonAutoSize = class(TPersistent)
  private
    FOwner: TAdvSmoothExpanderButtonPanel;
    FDecreaseHeight: Boolean;
    FIncreaseHeight: Boolean;
    FOnChange: TNotifyEvent;
    procedure SetDecreaseHeight(const Value: Boolean);
    procedure SetIncreaseHeight(const Value: Boolean);
  protected
    procedure Changed;
  public
    constructor Create(AOwner: TAdvSmoothExpanderButtonPanel);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property IncreaseHeight: Boolean read FIncreaseHeight write SetIncreaseHeight default true;
    property DecreaseHeight: Boolean read FDecreaseHeight write SetDecreaseHeight default false;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothExpanderButtonStatus = class(TPersistent)
  private
    FOwner: TAdvSmoothExpanderButtonPanel;
    FOffsetTop: integer;
    FOffsetLeft: integer;
    FVisible: Boolean;
    FAppearance: TGDIPStatus;
    FOnChange: TNotifyEvent;
    procedure SetOffsetLeft(const Value: integer);
    procedure SetOffsetTop(const Value: integer);
    procedure SetVisible(const Value: Boolean);
    procedure SetAppearance(const Value: TGDIPStatus);
  protected
    procedure Changed;
    procedure AppearanceChanged(Sender: TObject);
  public
    constructor Create(AOwner: TAdvSmoothExpanderButtonPanel);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Visible: Boolean read FVisible write SetVisible default false;
    property OffsetLeft: integer read FOffsetLeft write SetOffsetLeft default 0;
    property OffsetTop: integer read FOffsetTop write SetOffsetTop default 0;
    property Appearance: TGDIPStatus read FAppearance write SetAppearance;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothExpanderButton = class(TCollectionItem)
  private
    FOwner: TAdvSmoothExpanderButtonPanel;
    FDown: Boolean;
    FEnabled: Boolean;
    FPicture: TAdvGDIPPicture;
    FBevel: boolean;
    FColor: TColor;
    FBevelColor: TColor;
    FCaption: string;
    FStatusCaption: String;
    FTextColor: TColor;
    procedure SetBevel(const Value: boolean);
    procedure SetBevelColor(const Value: TColor);
    procedure SetCaption(const Value: string);
    procedure SetColor(const Value: TColor);
    procedure SetEnabled(const Value: Boolean);
    procedure SetPicture(const Value: TAdvGDIPPicture);
    procedure SetStatusCaption(const Value: String);
    procedure SetTextColor(const Value: TColor);
  protected
    procedure Changed;
    procedure PictureChanged(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Bevel: boolean read FBevel write SetBevel default true;
    property BevelColor: TColor read FBevelColor write SetBevelColor default clWhite;
    property Caption: string read FCaption write SetCaption;
    property StatusCaption: String read FStatusCaption write SetStatusCaption;
    property Color: TColor read FColor write SetColor default clGray;
    property Picture: TAdvGDIPPicture read FPicture write SetPicture;
    property Enabled: Boolean read FEnabled write SetEnabled default true;
    property TextColor: TColor read FTextColor write SetTextColor default clBlack;
  end;

  TAdvSmoothExpanderButtons = class(TCollection)
  private
    FOwner: TAdvSmoothExpanderButtonPanel;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TAdvSmoothExpanderButton;
    procedure SetItem(Index: Integer; const Value: TAdvSmoothExpanderButton);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TAdvSmoothExpanderButtonPanel);
    function Add: TAdvSmoothExpanderButton;
    function Insert(Index: Integer): TAdvSmoothExpanderButton;
    property Items[Index: Integer]: TAdvSmoothExpanderButton read GetItem write SetItem; default;
    procedure Delete(Index: Integer);
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothExpanderButtonStatusDraw = procedure(Sender: TObject; StatusAppearance: TGDIPFill; StatusFont: TFont; ButtonIndex: integer) of object;

  TAdvSmoothExpanderButtonClickEvent = procedure(Sender: TObject; ButtonIndex: integer) of object;

  TAdvSmoothExpanderButtonPanel = class(TAdvSmoothExpanderPanel, ITMSStyle)
  private
    FFocused, FCalculateHeight: Boolean;
    FFocusedButtonIndex: integer;
    FDesignTime: Boolean;
    FCache: TGPBitmap;
    FValidCache: Boolean;
    FButtons: TAdvSmoothExpanderButtons;
    FButtonStatus: TAdvSmoothExpanderButtonStatus;
    FOnDrawStatus: TAdvSmoothExpanderButtonStatusDraw;
    FVerticalSpacing: integer;
    FHorizontalSpacing: integer;
    FButtonAppearance: TGDIPButton;
    FButtonHeight: integer;
    FButtonWidth: integer;
    FOnButtonClick: TAdvSmoothExpanderButtonClickEvent;
    FOnButtonClicked: TAdvSmoothExpanderButtonClickEvent;
    FVerticalMargin: integer;
    FHorizontalMargin: integer;
    FAutoSize: TAdvSmoothExpanderButtonAutoSize;
    FRows: integer;
    FColumns: integer;
    procedure SetButtons(const Value: TAdvSmoothExpanderButtons);
    procedure SetButtonStatus(const Value: TAdvSmoothExpanderButtonStatus);
    procedure SetHorizontalSpacing(const Value: integer);
    procedure SetVerticalSpacing(const Value: integer);
    procedure SetButtonAppearance(const Value: TGDIPButton);
    procedure SetButtonHeight(const Value: integer);
    procedure SetButtonWidth(const Value: integer);
    procedure SetHorizontalMargin(const Value: integer);
    procedure SetVerticalMargin(const Value: integer);
    procedure SetAS(const Value: TAdvSmoothExpanderButtonAutoSize);
    procedure SetColumns(const Value: integer);
    procedure SetRows(const Value: integer);
  protected
    procedure Changed;
    procedure PanelChanged(Sender: TObject);
    procedure ButtonStatusChanged(Sender: TObject);
    procedure ButtonsChanged(Sender: TObject);
    procedure AutoSizeChanged(Sender: TObject);
    procedure GDIPPaint(g: TGPGraphics); override;
    function GetVersionNr: integer; override;
    function ButtonAtXY(X, Y: integer): integer;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    function GetMaxButtons: integer;
    procedure CalculateHeight;
    function GetButtonWidth: integer;
    function GetButtonHeight: integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure SetComponentStyle(AStyle: TTMSStyle);
    procedure Resize; override;
    procedure Loaded; override;
    procedure DoEnter; override;
    procedure DoExit; override;
  published
    property AutoSize: TAdvSmoothExpanderButtonAutoSize read FAutoSize write SetAS;
    property Buttons: TAdvSmoothExpanderButtons read FButtons write SetButtons;
    property ButtonStatus: TAdvSmoothExpanderButtonStatus read FButtonStatus write SetButtonStatus;
    property ButtonAppearance: TGDIPButton read FButtonAppearance write SetButtonAppearance;
    property ButtonVerticalMargin: integer read FVerticalMargin write SetVerticalMargin default 35;
    property ButtonHorizontalMargin: integer read FHorizontalMargin write SetHorizontalMargin default 5;
    property ButtonHorizontalSpacing: integer read FHorizontalSpacing write SetHorizontalSpacing default 5;
    property ButtonWidth: integer read FButtonWidth write SetButtonWidth default 75;
    property ButtonHeight: integer read FButtonHeight write SetButtonHeight default 30;
    property Columns: integer read FColumns write SetColumns default -1;
    property Rows: integer read FRows write SetRows default -1;
    property ButtonVerticalSpacing: integer read FVerticalSpacing write SetVerticalSpacing default 5;
    property OnDrawStatus: TAdvSmoothExpanderButtonStatusDraw read FOnDrawStatus write FOnDrawStatus;
    property OnButtonClick: TAdvSmoothExpanderButtonClickEvent read FOnButtonClick write FOnButtonClick;
    property OnButtonClicked: TAdvSmoothExpanderButtonClickEvent read FOnButtonClicked write FOnButtonClicked;
  end;

implementation

uses
  CommCtrl, ShellApi;

{$IFNDEF DELPHI7_LVL}

const
  CS_DROPSHADOW = $00020000;

{$ENDIF}
{$i GDIPHTMLEngine.pas}

{ TAdvSmoothExpanderButtonPanel }

procedure TAdvSmoothExpanderButtonPanel.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothExpanderButtonPanel) then
  begin
    FButtons.Assign((Source as TAdvSmoothExpanderButtonPanel).Buttons);
    FButtonStatus.Assign((Source as TAdvSmoothExpanderButtonPanel).FButtonStatus);
    FButtonAppearance.Assign((Source as TAdvSmoothExpanderButtonPanel).ButtonAppearance);
    FHorizontalSpacing := (Source as TAdvSmoothExpanderButtonPanel).ButtonHorizontalSpacing;
    FVerticalSpacing := (Source as TAdvSmoothExpanderButtonPanel).ButtonVerticalSpacing;
    FButtonWidth := (Source as TAdvSmoothExpanderButtonPanel).ButtonWidth;
    FButtonHeight := (Source as TAdvSmoothExpanderButtonPanel).ButtonHeight;
    FAutoSize := (Source as TAdvSmoothExpanderButtonPanel).AutoSize;
    FVerticalMargin := (Source as TAdvSmoothExpanderButtonPanel).ButtonVerticalMargin;
    FHorizontalMargin := (Source as TAdvSmoothExpanderButtonPanel).ButtonHorizontalMargin;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.AutoSizeChanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothExpanderButtonPanel.ButtonAtXY(X, Y: integer): integer;
var
  w, h, xb, yb, I, k, j: Integer;
begin
  result := -1;
  k := 0;
  J := 0;
  w := GetButtonWidth;
  h := GetButtonHeight;
  for I := 0 to Buttons.Count - 1 do
  begin
    xb := ButtonHorizontalMargin + K * w;
    yb := ButtonVerticalMargin + J * h;
    if xb + w > InsideRect.Right then
    begin
      K := 0;
      Inc(J);
      xb := ButtonHorizontalMargin + K * w;
      yb := ButtonVerticalMargin + J * h;
      Inc(K);
    end
    else
      Inc(K);

    if PtInRect(Bounds(xb, yb, w, h), Point(X, Y)) then
    begin
      result := I;
      break;
    end;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.ButtonsChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothExpanderButtonPanel.ButtonStatusChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothExpanderButtonPanel.CalculateHeight;
var
  k, j, i, w, h, x: integer;
  ah: integer;
begin
  if not AutoSize.DecreaseHeight and not AutoSize.IncreaseHeight or
    (csDestroying in ComponentState) or (Rows <> -1) or (csLoading in ComponentState) then
      Exit;

  FCalculateHeight := false;
  k := 0;
  J := 0;
  w := GetButtonWidth;
  h := GetButtonHeight;
  for I := 0 to Buttons.Count - 1 do
  begin
    with Buttons[I] do
    begin
      x := ButtonHorizontalMargin + K * w;
      if x + w > InsideRect.Right then
      begin
        K := 0;
        Inc(J);
        Inc(K);
      end
      else
        Inc(K);
    end;
  end;

  if Buttons.Count > 0 then
    ah := ButtonVerticalMargin + ((J + 1) * h) + 5
  else
    ah := ButtonVerticalMargin;

  if AutoSize.IncreaseHeight and (ah > Height) then
    Height := ah
  else if AutoSize.DecreaseHeight and (ah < Height) then
    Height := ah;

  FCalculateHeight := true;
end;

procedure TAdvSmoothExpanderButtonPanel.Changed;
begin
  FValidCache := false;
  CalculateHeight;
  Invalidate;
end;

constructor TAdvSmoothExpanderButtonPanel.Create(AOwner: TComponent);
begin
  inherited;
  DoubleBuffered := true;
  Width := 286;
  Height := 128;
  FAutoSize := TAdvSmoothExpanderButtonAutoSize.Create(Self);
  FAutoSize.OnChange := AutoSizeChanged;
  FButtons := TAdvSmoothExpanderButtons.Create(Self);
  Fbuttons.OnChange := ButtonsChanged;
  FButtonStatus := TAdvSmoothExpanderButtonStatus.Create(Self);
  FButtonStatus.OnChange := ButtonStatusChanged;
  FButtonAppearance := TGDIPButton.Create;
  FButtonAppearance.OnChange := ButtonsChanged;
  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));
  FButtonWidth := 75;
  FButtonHeight := 30;
  FVerticalMargin := 35;
  FHorizontalMargin := 5;
  FCache := TGPBitmap.Create(Width, Height - ButtonVerticalMargin);
  FFocusedButtonIndex := 0;
  FCalculateHeight := true;
  FVerticalSpacing := 5;
  FHorizontalSpacing := 5;
  FColumns := -1;
  FRows := -1;
end;

destructor TAdvSmoothExpanderButtonPanel.Destroy;
begin
  Fbuttons.Free;
  Fbuttonstatus.Free;
  FButtonAppearance.Free;
  if FCache <> nil then
    FCache.Free;
  inherited;
end;

procedure TAdvSmoothExpanderButtonPanel.DoEnter;
begin
  inherited;
  FFocused := true;
  Changed;
end;

procedure TAdvSmoothExpanderButtonPanel.DoExit;
begin
  inherited;
  FFocused := false;
  Changed;
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
  g.SetSmoothingMode(SmoothingModeAntiAlias);
end;

procedure TAdvSmoothExpanderButtonPanel.GDIPPaint(g: TGPGraphics);
var
  gp: TGPGraphics;
  i: integer;
  hs, vs, x, y, w, h: integer;
  f: TGDIPFill;
  ft: TFont;
  K, J: integer;
  c: TColor;
begin
  inherited;
  if not FValidCache then
  begin
    gp := TGPGraphics.Create(FCache);
    gp.SetSmoothingMode(SmoothingModeAntiAlias);
    gp.SetTextRenderingHint(TextRenderingHintAntiAlias);
    gp.Clear(MakeColor(0, clWhite));
    f := TGDIPFill.Create;
    ft := TFont.Create;

    k := 0;
    J := 0;
    w := GetButtonWidth;
    h := GetButtonHeight;
    vs := ButtonVerticalSpacing;
    hs := ButtonHorizontalSpacing;
    for I := 0 to Buttons.Count - 1 do
    begin
      f.Assign(ButtonStatus.Appearance.Fill);
      ft.Assign(Buttonstatus.Appearance.Font);
      with Buttons[I] do
      begin
        x := ButtonHorizontalMargin + K * w;
        y := ButtonVerticalMargin + J * h;
        if x + w > InsideRect.Right then
        begin
          K := 0;
          Inc(J);
          x := ButtonHorizontalMargin + K * w;
          y := ButtonVerticalMargin + J * h;
          Inc(K);
        end
        else
          Inc(K);

        FButtonAppearance.BeginUpdate;
        c := FButtonAppearance.Font.Color;
        if TextColor <> clNone then
          FButtonAppearance.Font.Color := TextColor;
        FButtonAppearance.Draw(gp, Caption, x, y, w, h, vs, hs, Color, clNone, BevelColor,
          false, FDown, Bevel, false, false, rtBoth, Picture, 0, 0, true);
        if TextColor <> clNone then
          FbuttonAppearance.Font.Color := c;
        FButtonAppearance.EndUpdate;

        if TabStop and (FFocusedButtonIndex = I) and FFocused then
          DrawFocus(gp, MakeRect(x + hs,y +vs, w - (hs * 2), h - (vs * 2)), 8);

        if ButtonStatus.Visible and ((StatusCaption <> '') or not ButtonStatus.Appearance.Fill.Picture.Empty) then
        begin
          with ButtonStatus do
          begin
            if Assigned(FOnDrawStatus) then
              FOnDrawStatus(Self, ButtonStatus.Appearance.Fill, ButtonStatus.Appearance.Font, i);

            Appearance.CalculateSize(gp, StatusCaption);
            x := x + w + FButtonStatus.OffsetLeft - ButtonStatus.Appearance.GetWidth;
            y := y + ButtonStatus.OffsetTop;
            Appearance.Draw(gp, ButtonStatus.OffsetLeft + x, y, 0, 0, true, StatusCaption);
          end;
        end;
      end;
      ButtonStatus.Appearance.Fill.Assign(f);
      ButtonStatus.Appearance.Font.Assign(ft);
    end;
    f.Free;
    ft.Free;
    gp.Free;
    FValidCache := true;
  end;

  if FValidCache then
  begin
    g.DrawImage(FCache, 0, 0);
  end;
end;

function TAdvSmoothExpanderButtonPanel.GetButtonHeight: integer;
begin
  if Rows = -1 then
    Result := ButtonHeight
  else
    Result := (InsideRect.Bottom - ButtonVerticalMargin ) div Rows;
end;

function TAdvSmoothExpanderButtonPanel.GetButtonWidth: integer;
begin
  if Columns = -1 then
    Result := ButtonWidth
  else
    Result := (InsideRect.Right - ButtonHorizontalMargin * 2) div Columns;
end;

function TAdvSmoothExpanderButtonPanel.GetMaxButtons: integer;
begin
  Result := (InsideRect.Right - ButtonHorizontalMargin) div GetButtonWidth;
end;

function TAdvSmoothExpanderButtonPanel.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvSmoothExpanderButtonPanel.KeyDown(var Key: Word;
  Shift: TShiftState);
var
  tempfi, fi: integer;
begin
  inherited;
  fi := FFocusedButtonIndex;
  tempfi := fi;
  case Key of
  VK_UP: tempfi := tempfi - GetMaxButtons;
  VK_Left: Dec(tempfi);
  VK_RIGHT: Inc(tempfi);
  VK_DOWN: tempfi := tempfi + GetMaxButtons;
  VK_PRIOR: tempfi := tempfi - 5;
  VK_NEXT: tempfi := tempfi + 5;
  VK_HOME: tempfi := 0;
  VK_END: tempfi := Buttons.Count - 1;
  VK_SPACE:
  begin
    if (FFocusedButtonIndex >= 0) and (FFocusedButtonIndex <= Buttons.Count - 1) then
    begin
      with Buttons[FFocusedButtonIndex] do
      begin
        FDown := true;
        Changed;
        if Assigned(FOnButtonClick) then
          FOnButtonClick(Self, FFocusedButtonIndex);
      end;
    end;
  end;
  end;
  if (tempfi >= 0) and (tempfi <= Buttons.Count - 1) then
  begin
    FFocusedButtonIndex := tempfi;
    if (fi <> FFocusedButtonIndex) and FFocused then
      Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.KeyUp(var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_SPACE then
  begin
    if (FFocusedButtonIndex >= 0) and (FFocusedButtonIndex <= Buttons.Count - 1) then
    begin
      with Buttons[FFocusedButtonIndex] do
      begin
        FDown := false;
        Changed;
        if Assigned(FOnButtonClicked) then
          FOnButtonClicked(Self, FFocusedButtonIndex);
      end;
    end;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.Loaded;
begin
  inherited;
  if Assigned(FCache)  then
    FCache.Free;
  FCache := TGPBitmap.Create(Width, Height - ButtonVerticalMargin);
  FValidCache := false;
end;

procedure TAdvSmoothExpanderButtonPanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  btnidx: integer;
begin
  inherited;
//  SetFocus;
  btnidx := ButtonAtXY(X, Y);
  if btnidx <> -1 then
  begin
    FFocusedButtonIndex := btnidx;
    Buttons[btnidx].Fdown := true;
    FValidCache := false;
    Changed;
    if Assigned(FOnButtonClick) then
      FOnButtonClick(Self, btnidx);
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.MouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;

end;

procedure TAdvSmoothExpanderButtonPanel.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
  btndown: Boolean;
  btnidx: integer;
begin
  inherited;
  btnidx := ButtonAtXY(X, Y);
  if btnidx <> -1 then
  begin
    if Assigned(FOnButtonClicked) then
      FOnButtonClicked(Self, btnidx);
  end;

  btndown :=false;
  for I := 0 to buttons.Count - 1 do
  begin
    if Buttons[I].Fdown then
    begin
      btndown := true;
      Break;
    end;
  end;

  if btndown then
  begin
    for I := 0 to buttons.Count - 1 do
      Buttons[I].Fdown := false;

    FValidCache := false;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.PanelChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothExpanderButtonPanel.Resize;
var
  h: integer;
begin
  inherited;

  if IsResizeEnabled then
  begin
    if FCalculateHeight then
      CalculateHeight;

    h := Height;
    if Assigned(FCache) then
    begin
      h := FCache.Height;
      FCache.Free;
    end;

    if Expanded then
    begin
      FCache := TGPBitmap.Create(Width, Height - 2)
    end
    else
      FCache := TGPBitmap.Create(Width, h);

    FValidCache := false;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetAS(
  const Value: TAdvSmoothExpanderButtonAutoSize);
begin
  if FAutoSize <> value then
  begin
    FAutoSize.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetButtonAppearance(
  const Value: TGDIPButton);
begin
  if FButtonAppearance <> Value then
  begin
    FButtonAppearance.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetButtonHeight(const Value: integer);
begin
  if FButtonHeight <> value then
  begin
    FButtonHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetButtons(
  const Value: TAdvSmoothExpanderButtons);
begin
  if FButtons <> value then
  begin
    FButtons.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetButtonStatus(
  const Value: TAdvSmoothExpanderButtonStatus);
begin
  if FButtonStatus <> value then
  begin
    FButtonStatus.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetButtonWidth(const Value: integer);
begin
  if FButtonWidth <> Value then
  begin
    FButtonWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetColumns(const Value: integer);
begin
  if (FColumns <> value) and (Value = -1) or (Value > 0) then
  begin
    FColumns := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetComponentStyle(AStyle: TTMSStyle);
begin
  inherited;
end;

procedure TAdvSmoothExpanderButtonPanel.SetHorizontalMargin(
  const Value: integer);
begin
  if FHorizontalMargin <> value then
  begin
    FHorizontalMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetHorizontalSpacing(
  const Value: integer);
begin
  if FHorizontalSpacing <> value then
  begin
    FHorizontalSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetRows(const Value: integer);
begin
  if (FRows <> value) and (Value = -1) or (Value > 0) then
  begin
    FRows := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetVerticalMargin(const Value: integer);
begin
  if FVerticalMargin <> value then
  begin
    FVerticalMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonPanel.SetVerticalSpacing(
  const Value: integer);
begin
  if FVerticalSpacing <> value then
  begin
    FVerticalSpacing := Value;
    Changed;
  end;
end;

{ TAdvSmoothExpanderButtons }

function TAdvSmoothExpanderButtons.Add: TAdvSmoothExpanderButton;
begin
  Result := TAdvSmoothExpanderButton(inherited Add);
end;

constructor TAdvSmoothExpanderButtons.Create(AOwner: TAdvSmoothExpanderButtonPanel);
begin
  inherited Create(TAdvSmoothExpanderButton);
  FOwner := AOwner;
end;

procedure TAdvSmoothExpanderButtons.Delete(Index: Integer);
begin
  Items[Index].Free;
end;

function TAdvSmoothExpanderButtons.GetItem(
  Index: Integer): TAdvSmoothExpanderButton;
begin
  Result := TAdvSmoothExpanderButton(inherited Items[Index]);
end;

function TAdvSmoothExpanderButtons.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TAdvSmoothExpanderButtons.Insert(
  Index: Integer): TAdvSmoothExpanderButton;
begin
  Result := TAdvSmoothExpanderButton(inherited Insert(Index));
end;

procedure TAdvSmoothExpanderButtons.SetItem(Index: Integer;
  const Value: TAdvSmoothExpanderButton);
begin
  inherited Items[Index] := value;
end;

{ TAdvSmoothExpanderButton }

procedure TAdvSmoothExpanderButton.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothExpanderButton) then
  begin
    FEnabled := (Source as TAdvSmoothExpanderButton).Enabled;
    FPicture.Assign((Source as TAdvSmoothExpanderButton).Picture);
    FBevel := (Source as TAdvSmoothExpanderButton).Bevel;
    FBevelColor := (Source as TAdvSmoothExpanderButton).BevelColor;
    FColor := (Source as TAdvSmoothExpanderButton).Color;
    FBevelColor := (Source as TAdvSmoothExpanderButton).BevelColor;
    FCaption := (Source as TAdvSmoothExpanderButton).Caption;
    FTextColor := (Source as TAdvSmoothExpanderButton).TextColor;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButton.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothExpanderButton.Create(Collection: TCollection);
begin
  inherited;
  FOwner := (Collection as TAdvSmoothExpanderButtons).FOwner;
  FPicture := TAdvGDIPPicture.Create;
  FPicture.OnChange := PictureChanged;
  FColor := clGray;
  FBevel := true;
  FBevelColor := clWhite;
  FEnabled := true;
  FTextColor := clBlack;
  Fowner.Changed;
end;

destructor TAdvSmoothExpanderButton.Destroy;
begin
  FPicture.Free;
  Fowner.Changed;
  inherited;
end;

procedure TAdvSmoothExpanderButton.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothExpanderButton.SetBevel(const Value: boolean);
begin
  if FBevel <> value then
  begin
    FBevel := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButton.SetBevelColor(const Value: TColor);
begin
  if FBevelColor <> Value then
  begin
    FBevelColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButton.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButton.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButton.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButton.SetPicture(const Value: TAdvGDIPPicture);
begin
  if FPicture <> value then
  begin
    FPicture.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButton.SetStatusCaption(const Value: String);
begin
  if FStatusCaption <> value then
  begin
    FStatusCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButton.SetTextColor(const Value: TColor);
begin
  if FTextColor <> value then
  begin
    FTextColor := Value;
    Changed;
  end;
end;

{ TAdvSmoothExpanderButtonStatus }

procedure TAdvSmoothExpanderButtonStatus.AppearanceChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothExpanderButtonStatus.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothExpanderButtonStatus) then
  begin
    FAppearance.Assign((Source as TAdvSmoothExpanderButtonStatus).Appearance);
    FOffsetTop := (Source as TAdvSmoothExpanderButtonStatus).OffsetTop;
    FOffsetLeft := (Source as TAdvSmoothExpanderButtonStatus).OffsetLeft;
    FVisible := (Source as TAdvSmoothExpanderButtonStatus).Visible;
  end;
end;

procedure TAdvSmoothExpanderButtonStatus.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothExpanderButtonStatus.Create(AOwner: TAdvSmoothExpanderButtonPanel);
begin
  FOwner := AOwner;
  FOffsetTop := 0;
  FOffsetLeft := 0;
  FVisible := False;
  FAppearance := TGDIPStatus.Create;
  FAppearance.OnChange := AppearanceChanged;
  if FOwner.FDesigntime then
  begin
    FAppearance.Fill.Color := clRed;
    FAppearance.Fill.GradientType := gtSolid;
    FAppearance.Fill.BorderColor := clGray;
    FAppearance.Font.Color := clWhite;
  end;
end;

destructor TAdvSmoothExpanderButtonStatus.Destroy;
begin
  FAppearance.Free;
  inherited;
end;

procedure TAdvSmoothExpanderButtonStatus.SetAppearance(const Value: TGDIPStatus);
begin
  if FAppearance <> value then
  begin
    FAppearance.Assign(Value);
    AppearanceChanged(Self);
  end;
end;

procedure TAdvSmoothExpanderButtonStatus.SetOffsetLeft(const Value: integer);
begin
  if FOffsetLeft <> value then
  begin
    FOffsetLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonStatus.SetOffsetTop(const Value: integer);
begin
  if FOffsetTop <> value then
  begin
    FOffsetTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonStatus.SetVisible(const Value: Boolean);
begin
  if FVisible <> value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

{ TAdvSmoothExpanderButtonAutoSize }

procedure TAdvSmoothExpanderButtonAutoSize.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothExpanderButtonAutoSize) then
  begin
    FIncreaseHeight := (Source as TAdvSmoothExpanderButtonAutoSize).IncreaseHeight;
    FDecreaseHeight := (Source as TAdvSmoothExpanderButtonAutoSize).DecreaseHeight;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonAutoSize.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothExpanderButtonAutoSize.Create(
  AOwner: TAdvSmoothExpanderButtonPanel);
begin
  FOwner := AOwner;
  FDecreaseHeight := false;
  FIncreaseHeight := true;
end;

destructor TAdvSmoothExpanderButtonAutoSize.Destroy;
begin
  inherited;
end;

procedure TAdvSmoothExpanderButtonAutoSize.SetDecreaseHeight(
  const Value: Boolean);
begin
  if FDecreaseHeight <> value then
  begin
    FDecreaseHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothExpanderButtonAutoSize.SetIncreaseHeight(
  const Value: Boolean);
begin
  if FIncreaseHeight <> value then
  begin
    FIncreaseHeight := Value;
    Changed;
  end;
end;

end.
