{**************************************************************************}
{ TAdvSmoothMessageDialog component                                        }
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

unit AdvSmoothMessageDialog;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, Forms, Classes, Dialogs, AdvSmoothGDIP, Controls,
  Graphics, SysUtils, GDIPFill, imglist, GDIPPicturecontainer, AdvStyleIF, Math;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.

  // version history
  // v1.0.0.0 : first release

type
  TAdvSmoothMessageDialog = class;

  TAdvSmoothMessageDialogForm = class(TForm)
  private
    FButtonidx: integer;
    FMouseDownOnButton: Boolean;
    FMainBuffer: TGPBitmap;
    FDialog: TAdvSmoothMessageDialog;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    Procedure CMDialogKey(Var Msg: TWMKey); message CM_DIALOGKEY;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DoCreate; override;
    procedure DoDestroy; override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    // ---- Calc proc
    procedure UpdateButtons;

    // ---- Paint proc
    procedure Draw(graphics: TGPGraphics);

    // ---- Paint buffer
    procedure CreateMainBuffer;
    procedure DestroyMainBuffer;
    procedure ClearBuffer(graphics: TGPGraphics);
    function CreateGraphics: TGPGraphics;

    //---- Layered window
    procedure SetLayeredWindow;
    procedure UpdateLayered;
    procedure UpdateMainWindow;
    procedure UpdateWindow;
  public
    procedure Init;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    property Dialog: TAdvSmoothMessageDialog read FDialog write FDialog;
  end;

  TAdvSmoothMessageDialogLocation = (hlTopLeft, hlTopCenter, hlTopRight, hlCenterLeft, hlCenterCenter, hlCenterRight, hlBottomLeft, hlBottomCenter, hlBottomRight, hlCustom);

  TAdvSmoothMessageDialogHTMLText = class(TPersistent)
  private
    FOwner: TAdvSmoothMessageDialog;
    FURLColor: TColor;
    FShadowOffset: integer;
    FFont: TFont;
    FText: String;
    FShadowColor: TColor;
    FOnChange: TNotifyEvent;
    FLocation: TAdvSmoothMessageDialogLocation;
    FTop: integer;
    FLeft: integer;
    procedure SetFont(const Value: TFont);
    procedure SetLeft(const Value: integer);
    procedure SetLocation(const Value: TAdvSmoothMessageDialogLocation);
    procedure SetShadowColor(const Value: TColor);
    procedure SetShadowOffset(const Value: integer);
    procedure SetText(const Value: string);
    procedure SetTop(const Value: integer);
    procedure SetURLColor(const Value: TColor);
  protected
    procedure Changed;
  public
    constructor Create(AOwner: TAdvSmoothMessageDialog);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Text: string read FText write SetText;
    property Location: TAdvSmoothMessageDialogLocation read FLocation write SetLocation default hlCenterLeft;
    property Top: integer read FTop write SetTop default 0;
    property Left: integer read FLeft write SetLeft default 0;
    property URLColor: TColor read FURLColor write SetURLColor default clBlue;
    property ShadowColor: TColor read FShadowColor write SetShadowColor default clGray;
    property ShadowOffset: integer read FShadowOffset write SetShadowOffset default 5;
    property Font: TFont read FFont write SetFont;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothMessageDialogButton = class(TCollectionItem)
  private
    FDown, FHover: Boolean;
    FBtnr: TGPRectF;
    Fowner: TAdvSmoothMessageDialog;
    FOpacity: Byte;
    FPicture: TAdvGDIPPicture;
    FColor: TColor;
    FCaption: string;
    FButtonResult: TModalResult;
    FPictureLocation: TGDIPButtonLayout;
    FSpacing: integer;
    FColorDown: TColor;
    FBorderColor: TColor;
    FBorderWidth: integer;
    FBorderOpacity: Byte;
    FHoverColor: TColor;
    FEnabled: Boolean;
    FColorDisabled: TColor;
    procedure SetCaption(const Value: string);
    procedure SetColor(const Value: TColor);
    procedure SetOpacity(const Value: Byte);
    procedure SetPicture(const Value: TAdvGDIPPicture);
    procedure SetButtonResult(const Value: TModalResult);
    procedure SetPictureLocation(const Value: TGDIPButtonLayout);
    procedure SetSpacing(const Value: integer);
    procedure SetColorDown(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderWidth(const Value: integer);
    procedure SetBorderOpacity(const Value: Byte);
    procedure SetHoverColor(const Value: TColor);
    procedure SetEnabled(const Value: Boolean);
    procedure SetColorDisabled(const Value: TColor);
  protected
    procedure Changed;
    procedure PictureChanged(Sender: TObject);
    procedure ButtonChanged(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property PictureLocation: TGDIPButtonLayout read FPictureLocation write SetPictureLocation default blPictureLeft;
    property Spacing: integer read FSpacing write SetSpacing default 3;
    property Caption: string read FCaption write SetCaption;
    property Color: TColor read FColor write SetColor default clGray;
    property ColorDown: TColor read FColorDown write SetColorDown default cldkGray;
    property ColorDisabled: TColor read FColorDisabled write SetColorDisabled default $797979;

    property HoverColor: TColor read FHoverColor write SetHoverColor default clLtGray;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clBlack;
    property BorderWidth: integer read FBorderWidth write SetBorderWidth default 1;
    property BorderOpacity: Byte read FBorderOpacity write SetBorderOpacity default 255;
    property Opacity: Byte read FOpacity write SetOpacity default 255;
    property ButtonResult: TModalResult read FButtonResult write SetButtonResult default mrOk;
    property Picture: TAdvGDIPPicture read FPicture write SetPicture;
    property Enabled: Boolean read FEnabled write SetEnabled default true;
  end;

  TAdvSmoothMessageDialogButtons = class(TCollection)
  private
    FOwner: TAdvSmoothMessageDialog;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TAdvSmoothMessageDialogButton;
    procedure SetItem(Index: Integer;
      const Value: TAdvSmoothMessageDialogButton);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TAdvSmoothMessageDialog);
    function Add: TAdvSmoothMessageDialogButton;
    function Insert(Index: Integer): TAdvSmoothMessageDialogButton;
    property Items[Index: Integer]: TAdvSmoothMessageDialogButton read GetItem write SetItem; default;
    procedure Delete(Index: Integer);
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TAdvSmoothMessageDialogButtonLayout = (blHorizontal, blVertical);

  TAdvSmoothMessageDialogAnchorClick = procedure(Sender: TObject; Anchor: String) of object;

  TDialogMaxSize = record
    maxbuttonwidth: Double;
    maxbuttonheight: Double;
    maxhtmlheight: Double;
    maxhtmlwidth: Double;
    maxcaptionheight: Double;
    maxcaptionwidth: Double;
    totalmaxheight: Double;
    totalmaxwidth: Double;
  end;

  TAdvSmoothMessageDialog = class(TComponent, ITMSStyle)
  private
    FFocusedButton: integer;
    FMaxDialog: TDialogMaxSize;
    FDesignTime: Boolean;
    FCaption: string;
    FCaptionFill: TGDIPFill;
    FCaptionHeight: integer;
    FMargin: integer;
    FFill: TGDIPFill;
    FImages: TCustomImageList;
    FContainer: TGDIPPictureContainer;
    FHTMLText: TAdvSmoothMessageDialogHTMLText;
    FButtonAreaFill: TGDIPFill;
    FOnChange: TNotifyEvent;
    frm: TAdvSmoothMessageDialogForm;
    FButtons: TAdvSmoothMessageDialogButtons;
    FCaptionLocation: TAdvSmoothMessageDialogLocation;
    FCaptionTop: integer;
    FCaptionLeft: integer;
    FCaptionFont: TFont;
    FButtonFont: TFont;
    FButtonLayout: TAdvSmoothMessageDialogButtonLayout;
    FHTMLAreaHeight: integer;
    FButtonSpacing: integer;
    FMinimumButtonWidth: integer;
    FMinimumButtonHeight: integer;
    FEnableKeyEvents: Boolean;
    FOnAnchorClick: TAdvSmoothMessageDialogAnchorClick;
    FTabStop: Boolean;
    FPosition: TPosition;
    FTop, FLeft: Integer;
    procedure SetCaptionFill(const Value: TGDIPFill);
    procedure SetCaptionHeight(const Value: integer);
    procedure SetMargin(const Value: integer);
    procedure SetFill(const Value: TGDIPFill);
    procedure SetHTMLText(const Value: TAdvSmoothMessageDialogHTMLText);
    procedure SetButtonAreaFill(const Value: TGDIPFill);
    procedure SetButtons(const Value: TAdvSmoothMessageDialogButtons);
    procedure SetCaptionLocation(const Value: TAdvSmoothMessageDialogLocation);
    procedure SetCaptionLeft(const Value: integer);
    procedure SetCaptionTop(const Value: integer);
    procedure SetCaptionFont(const Value: TFont);
    procedure SetButtonFont(const Value: TFont);
    procedure SetButtonLayout(const Value: TAdvSmoothMessageDialogButtonLayout);
    procedure SetButtonSpacing(const Value: integer);
    procedure SetEnableKeyEvents(const Value: Boolean);
    procedure SetTabStop(const Value: Boolean);
    function GetVersion: String;
    procedure SetVersion(const Value: String);
  protected
    procedure Changed; virtual;
    procedure CloseForm(Sender: TObject; var Action: TCloseAction);
    procedure FillChanged(Sender: TObject);
    procedure ButtonsChanged(Sender: TObject);
    procedure Fontchanged(Sender: TObject);
    function DrawHTMLText(g: TGPGraphics; HTML: TAdvSmoothMessageDialogHTMLText; r: TGPRectF; str: String;
      DoAnchor: Boolean = false; fX: integer = -1; fY: integer = -1): String;
    procedure DrawButton(g: TGPGraphics; btn: TAdvSmoothMessageDialogButton; r: TGPRectF);
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    function GetCaptionRect(R: TRect): TGPRectF;
    function GetHTMLRect(R: TRect): TGPRectF;
    function GetButtonRect(R: TRect): TGPRectF;
    function GetButtonIndexAtXY(X, Y: integer): integer;
    function GetAnchorAt(g: TGPGraphics; X, Y: integer; R: TRect): String;
    procedure CalculateMaximum;
    procedure InitSample;
    procedure SetName(const Value: TComponentName); override;
    function GetVersionNr: integer;
    function CreateAndShowDialog: TModalResult;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function ExecuteDialog: TModalResult;
    function Execute: Boolean;
    procedure Preview;
    procedure SetComponentStyle(AStyle: TTMSStyle);
  published
    property EnableKeyEvents: Boolean read FEnableKeyEvents write SetEnableKeyEvents default true;
    property Images: TCustomImageList read FImages write FImages;
    property PictureContainer: TGDIPPictureContainer read FContainer write FContainer;
    property Margin: integer read FMargin write SetMargin default 0;
    property ButtonLayout: TAdvSmoothMessageDialogButtonLayout read FButtonLayout write SetButtonLayout default blHorizontal;
    property ButtonAreaFill: TGDIPFill read FButtonAreaFill write SetButtonAreaFill;
    property Buttons: TAdvSmoothMessageDialogButtons read FButtons write SetButtons;
    property ButtonSpacing: integer read FButtonSpacing write SetButtonSpacing default 5;
    property Caption: string read FCaption write FCaption;
    property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
    property ButtonFont: TFont read FButtonFont write SetButtonFont;
    property CaptionFill: TGDIPFill read FCaptionFill write SetCaptionFill;
    property CaptionLocation: TAdvSmoothMessageDialogLocation read FCaptionLocation write SetCaptionLocation default hlCenterCenter;
    property CaptionHeight: integer read FCaptionHeight write SetCaptionHeight default 30;
    property CaptionLeft: integer read FCaptionLeft write SetCaptionLeft default 0;
    property CaptionTop: integer read FCaptionTop write SetCaptionTop default 0;
    property Fill: TGDIPFill read FFill write SetFill;
    property HTMLText: TAdvSmoothMessageDialogHTMLText read FHTMLText write SetHTMLText;
    property DialogLeft: Integer read FLeft write FLeft default 0;
    property Position: TPosition read FPosition write FPosition default poDefaultPosOnly;
    property DialogTop: Integer read FTop write FTop default 0;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnAnchorClick: TAdvSmoothMessageDialogAnchorClick read FOnAnchorClick write FOnAnchorClick;
    property TabStop: Boolean read FTabStop write SetTabStop default false;
    property Version: String read GetVersion write SetVersion;
  end;

procedure ShowSmoothMessage(const Msg: string; AStyle: TTMSStyle = tsOffice2007Luna);

function SmoothMessageDlg(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; AStyle: TTMSStyle = tsOffice2007Luna): Integer; overload;

function SmoothMessageDlg(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn; AStyle: TTMSStyle = tsOffice2007Luna): Integer; overload;

function SmoothMessageDlgPos(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer; AStyle: TTMSStyle = tsOffice2007Luna): Integer; overload;

function SmoothMessageDlgPos(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn; AStyle: TTMSStyle = tsOffice2007Luna): Integer; overload;

  
implementation

uses
  CommCtrl, ShellApi, Consts;

{$I GDIPHTMLEngine.pas}

function SmoothMessageDlgPosInt(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn; AStyle: TTMSStyle; Position: TPosition): Integer; overload;
var
  i: integer;
  d: TAdvSmoothMessageDialog;
begin
  d := TAdvSmoothMessageDialog.Create(Application.MainForm);

  d.FFocusedButton := 0;
  i := 0;

  if mbOK in Buttons then
    with d.Buttons.Add do
    begin
      Caption := SMsgDlgOK;
      ButtonResult := mrOK;

      if DefaultButton = mbOK then
        d.FFocusedButton := i;
      inc(i);
    end;
  if mbCancel in Buttons then
    with d.Buttons.Add do
    begin
      Caption := SMsgDlgCancel;
      ButtonResult := mrCancel;
      if DefaultButton = mbCancel then
        d.FFocusedButton := i;
      inc(i);
    end;
  if mbYES in Buttons then
    with d.Buttons.Add do
    begin
      Caption := SMsgDlgYes;
      ButtonResult := mrYes;
      if DefaultButton = mbYes then
        d.FFocusedButton := i;
      inc(i);
    end;
  if mbNO in Buttons then
    with d.Buttons.Add do
    begin
      Caption := SMsgDlgNo;
      ButtonResult := mrNo;
      if DefaultButton = mbNO then
        d.FFocusedButton := i;
      inc(i);
    end;
  if mbAbort in Buttons then
    with d.Buttons.Add do
    begin
      Caption := SMsgDlgAbort;
      ButtonResult := mrAbort;
      if DefaultButton = mbAbort then
        d.FFocusedButton := i;
      inc(i);
    end;
  if mbRetry in Buttons then
    with d.Buttons.Add do
    begin
      Caption := SMsgDlgRetry;
      ButtonResult := mrRetry;
      if DefaultButton = mbRetry then
        d.FFocusedButton := i;
      inc(i);
     end;
  if mbIgnore in Buttons then
    with d.Buttons.Add do
    begin
      Caption := SMsgDlgIgnore;
      ButtonResult := mrIgnore;
      if DefaultButton = mbIgnore then
        d.FFocusedButton := i;
      inc(i);
    end;
  if mbAll in Buttons then
    with d.Buttons.Add do
    begin
      Caption := SMsgDlgAll;
      ButtonResult := mrAll;
      if DefaultButton = mbAll then
        d.FFocusedButton := i;
      inc(i);
    end;
  if mbNoToAll in Buttons then
    with d.Buttons.Add do
    begin
      Caption := SMsgDlgNoToAll;
      ButtonResult := mrNoToAll;
      if DefaultButton = mbNoToAll then
        d.FFocusedButton := i;
      inc(i);
    end;
  if mbYesToAll in Buttons then
    with d.Buttons.Add do
    begin
      Caption := SMsgDlgYesToAll;
      ButtonResult := mrYesToAll;
      if DefaultButton = mbYesToAll then
        d.FFocusedButton := i;
      inc(i);
    end;
  if mbHelp in Buttons then
    with d.Buttons.Add do
    begin
      Caption := 'Help';
      if DefaultButton = mbHelp then
        d.FFocusedButton := i;
    end;

  d.Caption := Title;
  d.CaptionLocation := hlCenterLeft;
  d.HTMLText.Text := Msg;
  d.DialogLeft := X;
  d.DialogTop := Y;
  d.Position := Position;
  d.SetComponentStyle(Astyle);
  Result := d.CreateAndShowDialog;
  d.Free;
end;


function SmoothMessageDlg(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; AStyle: TTMSStyle = tsOffice2007Luna): Integer;
begin
  Result := SmoothMessageDlgPosInt(Title, Msg, DlgType, Buttons, HelpCtx, 0, 0, mbOK, AStyle, poScreenCenter);
end;

function SmoothMessageDlg(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn; AStyle: TTMSStyle = tsOffice2007Luna): Integer; overload;
begin
  Result := SmoothMessageDlgPosInt(Title, Msg, DlgType, Buttons, HelpCtx, 0, 0, DefaultButton, AStyle, poScreenCenter);
end;

function SmoothMessageDlgPos(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer; AStyle: TTMSStyle = tsOffice2007Luna): Integer; overload;
begin
  Result := SmoothMessageDlgPosInt(Title, Msg, DlgType, Buttons, HelpCtx, X,Y, mbOK, AStyle, poDesigned);
end;

function SmoothMessageDlgPos(const Title, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn; AStyle: TTMSStyle = tsOffice2007Luna): Integer; overload;
begin
  Result := SmoothMessageDlgPosInt(Title, Msg, DlgType, Buttons, HelpCtx, X,Y, DefaultButton, AStyle, poDesigned);
end;

procedure ShowSmoothMessage(const Msg: String; AStyle: TTMSStyle = tsOffice2007Luna);
var
  d: TAdvSmoothMessageDialog;
begin
  d := TAdvSmoothMessageDialog.Create(Application.MainForm);
  d.FFocusedButton := 0;
  d.Buttons.Add.Caption := 'OK';
  d.Caption := Application.Title;
  d.CaptionLocation := hlCenterLeft;
  d.Position := poScreenCenter;
  d.HTMLText.Text := Msg;
  d.SetComponentStyle(Astyle);
  d.ExecuteDialog;
  d.Free;
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

procedure DrawFocus(g: TGPGraphics; r: TGPRectF; rn: Integer; c: TColor);
var
  pathfocus: TGPGraphicsPath;
  pfocus: TGPPen;
begin
  pathfocus := CreateRoundRectangle(r, rn, rtBoth, false);
  pfocus := TGPPen.Create(MakeColor(255, c), 1);
  pfocus.SetDashStyle(DashStyleDot);
  g.DrawPath(pfocus, pathfocus);
  pfocus.Free;
  pathfocus.Free;
end;

function PtInGPRect(r: TGPRectF; pt: TPoint): Boolean;
begin
  result := ((pt.X >= r.X) and (pt.X <= r.X + r.Width)) and
     ((pt.Y >= r.Y) and (pt.Y <= r.Y + r.Height));
end;

procedure GetObjectLocation(var x, y: single; rectangle: TGPRectF; objectwidth, objectheight: integer; location: TAdvSmoothMessageDialogLocation);
var
  w, h, tw, th: single;
begin
  tw := objectwidth;
  th := objectheight;
  w := rectangle.Width;
  h := rectangle.Height;
  case location of
    hlTopLeft:
    begin
      x := 0;
      y := 0;
    end;
    hlTopRight:
    begin
      x := w - tw;
      y := 0;
    end;
    hlBottomLeft:
    begin
      x := 0;
      y := h - th;
    end;
    hlBottomRight:
    begin
      x := w - tw;
      y := h - th;
    end;
    hlTopCenter:
    begin
      x := (w - tw) / 2;
      y := 0;
    end;
    hlBottomCenter:
    begin
      x := (w - tw) / 2;
      y := h - th;
    end;
    hlCenterCenter:
    begin
      x := (w - tw) / 2;
      y := (h - th) / 2;
    end;
    hlCenterLeft:
    begin
      x := 0;
      y := (h - th) / 2;
    end;
    hlCenterRight:
    begin
      x := w - tw;
      y := (h - th) / 2;
    end;
  end;

  x := x + Round(rectangle.X);
  y := y + Round(rectangle.Y);
end;

{ TAdvSmoothMessageDialog }

procedure TAdvSmoothMessageDialog.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothMessageDialog) then
  begin
    FMargin := (Source as TAdvSmoothMessageDialog).Margin;
    FCaption := (Source as TAdvSmoothMessageDialog).Caption;
    FCaptionFill.Assign((Source as TAdvSmoothMessageDialog).CaptionFill);
    FCaptionHeight := (Source as TAdvSmoothMessageDialog).CaptionHeight;
    FFill.Assign((Source as TAdvSmoothMessageDialog).Fill);
    FHTMLText.Assign((Source as TAdvSmoothMessageDialog).HTMLText);
    FCaptionLocation := (Source as TAdvSmoothMessageDialog).CaptionLocation;
    FCaptionLeft := (Source as TAdvSmoothMessageDialog).CaptionLeft;
    FCaptionTop := (Source as TAdvSmoothMessageDialog).CaptionTop;
    FCaptionFont.Assign((Source as TAdvSmoothMessageDialog).CaptionFont);
    FButtonFont.Assign((Source as TAdvSmoothMessageDialog).ButtonFont);
    FButtonLayout := (Source as TAdvSmoothMessageDialog).ButtonLayout;
    FButtonSpacing := (Source as TAdvSmoothMessageDialog).ButtonSpacing;
    FEnableKeyEvents := (Source as TAdvSmoothMessageDialog).EnableKeyEvents;
    FTabStop := (source as TAdvSmoothMessageDialog).TabStop;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.ButtonsChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothMessageDialog.CalculateMaximum;
var
  i: integer;
  ff: TGPFontFamily;
  f: TGPFont;
  fs: integer;
  sf: TGPStringFormat;
  sri: TGPRectF;
  g: TGPGraphics;
  mxw, mxh: Double;
  maxr: TGPRectF;
  XSize, YSize: integer;
  a, s, k: string;
  l: integer;
  m: integer;
  hr: TRect;
begin
  if not Assigned(frm) then
    Exit;

  g := TGPGraphics.Create(frm.Canvas.Handle);
  g.SetTextRenderingHint(TextRenderingHintAntiAlias);

  maxr := MakeRect(0, 0, 10000, 10000);

  if Buttons.Count > 0 then
  begin
    //BUTTON maximum width and height
    ff := TGPFontFamily.Create(ButtonFont.Name);
    if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
    begin
      ff.Free;
      ff := TGPFontFamily.Create('Arial');
    end;

    fs := 0;
    if (fsBold in ButtonFont.Style) then
      fs := fs + 1;
    if (fsItalic in ButtonFont.Style) then
      fs := fs + 2;
    if (fsUnderline in ButtonFont.Style) then
      fs := fs + 4;

    sf := TGPStringFormat.Create;
    f := TGPFont.Create(ff, ButtonFont.Size, fs, UnitPoint);

    mxw := 0;
    mxh := 0;
    g.MeasureString('gh', Length('gh'), f, maxr, sf, sri);
    for I := 0 to Buttons.Count - 1 do
    begin
      g.MeasureString(Buttons[i].Caption, length(Buttons[i].Caption), f, maxr, sf, sri);
      if Assigned(Buttons[I].Picture) and not (Buttons[I].Picture.Empty) then
      begin
        Buttons[I].Picture.GetImageSizes;
        if ((Buttons[I].PictureLocation = blPictureLeft) or (Buttons[I].PictureLocation = blPictureRight)) then
          sri.Width := sri.Width + Buttons[I].Picture.Width + Buttons[I].Spacing
        else
          sri.Width := Buttons[I].Picture.Width;
      end;

      sri.Width := Max(75, ((sri.Width * 1.5) + ButtonSpacing));

      if sri.Width > mxw then
        mxw := sri.Width;

      if Assigned(Buttons[I].Picture) and not (Buttons[I].Picture.Empty) then
      begin
        Buttons[I].Picture.GetImageSizes;
        if ((Buttons[I].PictureLocation = blPictureTop) or (Buttons[I].PictureLocation = blPictureBottom)) then
          sri.Height := sri.Height + Buttons[I].Picture.Height + Buttons[I].Spacing
        else
          sri.Height := Buttons[I].Picture.Height;
      end;

      sri.Height := Max(25, ((sri.Height * 1.5) + ButtonSpacing));

      if sri.Height > mxh then
        mxh := sri.Height;
    end;

    FMaxDialog.maxbuttonwidth := mxw;
    FMaxDialog.maxbuttonheight := mxh;
    FMaxDialog.totalmaxwidth := FMaxDialog.maxbuttonwidth;
    FMaxDialog.totalmaxheight := FMaxDialog.maxbuttonheight;

    sf.Free;
    f.Free;
    ff.Free;
  end;

  //CAPTION maximum width and height

  if Caption <> '' then
  begin
    ff := TGPFontFamily.Create(CaptionFont.Name);
    if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
    begin
      ff.Free;
      ff := TGPFontFamily.Create('Arial');
    end;

    fs := 0;
    if (fsBold in CaptionFont.Style) then
      fs := fs + 1;
    if (fsItalic in CaptionFont.Style) then
      fs := fs + 2;
    if (fsUnderline in CaptionFont.Style) then
      fs := fs + 4;

    sf := TGPStringFormat.Create;
    f := TGPFont.Create(ff, CaptionFont.Size, fs, UnitPoint);

    g.MeasureString(Caption, Length(Caption), f, maxr, sf, sri);
    FMaxDialog.maxcaptionheight := CaptionHeight;
    FMaxDialog.maxcaptionwidth := sri.Width * 1.5;

    FMaxDialog.totalmaxheight := FMaxDialog.totalmaxheight + FMaxDialog.maxcaptionheight;

    if FMaxDialog.maxcaptionwidth > FMaxDialog.totalmaxwidth then
      FMaxDialog.totalmaxwidth := FMaxDialog.maxcaptionwidth;

    sf.Free;
    f.Free;
    ff.Free;
  end;

  //HTML maximum width and height
  with HTMLText do
  begin
    if Text <> '' then
    begin
      HTMLDrawGDIP(g, FFont, Text,Bounds(Round(maxr.X), Round(maxr.Y), Round(maxr.Width), Round(maxr.Height)),FImages, 0,0,-1,-1,FShadowOffset,
        False,true,false,false, False,False,true,1.0,FURLColor,clNone,clNone,FShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

      FMaxDialog.maxhtmlheight := YSize * 2;
      FMaxDialog.maxhtmlwidth := XSize * 1.5;

      FMaxDialog.totalmaxheight := FMaxDialog.totalmaxheight + FMaxDialog.maxhtmlheight;

      if FMaxDialog.maxhtmlwidth > FMaxDialog.totalmaxwidth then
        FMaxDialog.totalmaxwidth := FMaxDialog.maxhtmlwidth;
    end;
  end;


  g.Free;
end;

procedure TAdvSmoothMessageDialog.Changed;
begin
  if Assigned(frm) then
  begin
    CalculateMaximum;
    frm.Width := Round(FMaxDialog.totalmaxwidth);
    frm.Height := Round(FMaxDialog.totalmaxheight + Margin * 2);
    frm.UpdateButtons;
    frm.UpdateWindow;
  end;
end;

procedure TAdvSmoothMessageDialog.CloseForm(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  frm := nil;
end;

constructor TAdvSmoothMessageDialog.Create(AOwner: TComponent);
begin
  inherited;
  FFill := TGDIPFill.Create;
  FFill.OnChange := fillChanged;
  FCaptionFill := TGDIPFill.Create;
  FCaptionFill.OnChange := fillChanged;
  FCaptionHeight := 30;
  FMargin := 0;
  FHTMLText := TAdvSmoothMessageDialogHTMLText.Create(Self);
  FButtonAreaFill := TGDIPFill.Create;
  FButtonAreaFill.OnChange := fillChanged;
  FHTMLAreaHeight := 50;
  FButtons := TAdvSmoothMessageDialogButtons.Create(Self);
  FButtons.OnChange := ButtonsChanged;
  FCaptionLocation := hlCenterCenter;
  FCaptionLeft := 0;
  FCaptionTop := 0;
  FCaptionFont := TFont.Create;
  FCaptionFont.OnChange := Fontchanged;
  FButtonFont := TFont.Create;
  FButtonFont.OnChange := Fontchanged;
  FButtonLayout := blHorizontal;
  FButtonSpacing := 5;
  FMinimumButtonWidth := 75;
  FMinimumButtonHeight := 50;
  FEnableKeyEvents := true;
  FTabStop := false;
  FFocusedButton := 0;
  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  if FDesignTime then
  begin
    InitSample;
    SetComponentStyle(tsOffice2007Luna);
  end;
end;

destructor TAdvSmoothMessageDialog.Destroy;
begin
  FFill.Free;
  FCaptionFill.Free;
  FHTMLText.Free;
  FButtonAreaFill.Free;
  FButtons.Free;
  FCaptionFont.Free;
  FButtonFont.Free;
  inherited;
end;

procedure TAdvSmoothMessageDialog.DrawButton(g: TGPGraphics;
  btn: TAdvSmoothMessageDialogButton; r: TGPRectF);
var
  b: TGDIPDialogButton;
  c: TColor;
begin
  with btn do
  begin
    b := TGDIPDialogButton.Create;
    b.Spacing := Spacing;
    b.Layout := PictureLocation;
    b.Font := ButtonFont;
    c := Color;

    if Enabled then
    begin
      if FDown then
        c := ColorDown
      else if FHover then
        c := HoverColor;
    end
    else
      c := ColorDisabled;

      b.Draw(g, Caption, Round(r.X), Round(r.Y), Round(r.Width), Round(r.Height), c,
        BorderColor, BorderWidth, BorderOpacity, Opacity, (BorderColor <> clNone), FDown,Picture, false);

      if Index = FFocusedButton then
        DrawFocus(g, MakeRect(r.X - 1 , r.Y - 1, r.Width + 1, r.Height + 1), 4, clBlack );

    b.Free;
  end;
end;

function TAdvSmoothMessageDialog.DrawHTMLText(g: TGPGraphics;
  HTML: TAdvSmoothMessageDialogHTMLText; r: TGPRectF; str: String;
  DoAnchor: Boolean; fX, fY: integer): String;
var
  htmlr: TRect;
  a, s, k: String;
  l, m, XSize, YSize: integer;
  hr: TRect;
  x, y: single;
begin
  with HTML do
  begin
    if str <> '' then
    begin
      htmlr := Rect(0, 0, Round(r.Width), Round(r.Height));

      HTMLDrawGDIP(g, FFont, str,htmlr,FImages, 0,0,-1,-1,FShadowOffset,False,true,false,false,
        False,False,true,1.0,FURLColor,clNone,clNone,FShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

      if FLocation <> hlCustom then
        GetObjectLocation(x, y, r, XSize, YSize, FLocation)
      else
      begin
        x := FLeft;
        y := FTop;
      end;

      htmlr := Bounds(Round(x), Round(y), xsize, ysize);

      HTMLDrawGDIP(g, FFont, str,htmlr,FImages, fx,fy,-1,-1,FShadowOffset,DoAnchor,false,false,false,
        False,False,true,1.0,FURLColor,clNone,clNone,FShadowColor,a,s,k,XSize,YSize,l,m,hr,nil,FContainer,2);

      result := a;
    end;
  end;
end;

function TAdvSmoothMessageDialog.Execute: Boolean;
var
  res: TModalResult;
begin
  res := ExecuteDialog;
  result := (res = mrOk) or (res = mrYes);
end;

function TAdvSmoothMessageDialog.ExecuteDialog: TModalResult;
begin
  FFocusedButton := 0;
  Result := CreateAndShowDialog;
end;

function TAdvSmoothMessageDialog.CreateAndShowDialog;
begin
  if (Owner is TCustomForm) then
    frm := TAdvSmoothMessageDialogForm.CreateNew(Owner as TCustomForm)
  else
    frm := TAdvSmoothMessageDialogForm.CreateNew(Application.MainForm);

  frm.Dialog := Self;
  frm.Init;
  Result := frm.ShowModal;
  frm.Free;
  frm := nil;
end;


procedure TAdvSmoothMessageDialog.FillChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothMessageDialog.Fontchanged(Sender: TObject);
begin
  Changed;
end;

function TAdvSmoothMessageDialog.GetAnchorAt(g: TGPGraphics; X, Y: integer; R: TRect): String;
begin
  with HTMLText do
    result := DrawHTMLText(g, HTMLText, GetHTMLRect(R), HtmlText.Text, true, X, Y);
end;

function TAdvSmoothMessageDialog.GetButtonIndexAtXY(X, Y: integer): integer;
var
  i: integer;
begin
  result := -1;
  for I := 0 to Buttons.Count - 1 do
  begin
    with Buttons[i] do
    begin
      if Buttons[I].Enabled then
      begin
        if PtInGPRect(FBtnr, Point(X, Y)) then
        begin
          Result := I;
          break;
        end;
      end;
    end;
  end;
end;

function TAdvSmoothMessageDialog.GetButtonRect(R: TRect): TGPRectF;
var
  totalr, boundsr: TGPRectF;
begin
  totalr := MakeRect(R.Left, R.Top, R.Right - R.Left - 1, R.Bottom - R.Top - 1);
  boundsr := MakeRect(totalr.X + Margin, totalr.Y + Margin, totalr.Width - (Margin * 2), totalr.Height - (Margin * 2));
  result := MakeRect(Boundsr.X, boundsr.Y + FMaxDialog.maxcaptionheight + FMaxDialog.maxhtmlheight, boundsr.Width, Boundsr.Height - FMaxDialog.maxcaptionheight - FMaxDialog.maxhtmlheight);
end;

function TAdvSmoothMessageDialog.GetCaptionRect(R: TRect): TGPRectF;
var
  totalr, boundsr: TGPRectF;
begin
  totalr := MakeRect(R.Left, R.Top, R.Right - R.Left - 1, R.Bottom - R.Top - 1);
  boundsr := MakeRect(totalr.X + Margin, totalr.Y + Margin, totalr.Width - (Margin * 2), totalr.Height - (Margin * 2));
  result := MakeRect(Boundsr.X, boundsr.Y, boundsr.Width, FMaxDialog.maxcaptionheight);
  result.X := result.X + 5;
  result.Width := result.Width - 5;
end;

function TAdvSmoothMessageDialog.GetHTMLRect(R: TRect): TGPRectF;
var
  totalr, boundsr: TGPRectF;
begin
  totalr := MakeRect(R.Left, R.Top, R.Right - R.Left - 1, R.Bottom - R.Top - 1);
  boundsr := MakeRect(totalr.X + Margin, totalr.Y + Margin, totalr.Width - (Margin * 2), totalr.Height - (Margin * 2));
  result := MakeRect(Boundsr.X, boundsr.Y + FMaxDialog.maxcaptionheight, boundsr.Width, FMaxDialog.maxhtmlheight);
  Result.X := Result.X + 5;
  Result.Width := Result.Width - 5;
end;

function TAdvSmoothMessageDialog.GetVersion: String;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TAdvSmoothMessageDialog.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TAdvSmoothMessageDialog.InitSample;
begin
  Caption := '';
  with Buttons.Add do
  begin
    Caption := 'Ok';
    ButtonResult := mrOk;
  end;
end;

procedure TAdvSmoothMessageDialog.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  if not (csDestroying in ComponentState) then
  begin
    if (AOperation = opRemove) and (AComponent = FImages) then
      FImages := nil;

    if (AOperation = opRemove) and (AComponent = FContainer) then
      FContainer := nil;
  end;
  inherited;
end;

procedure TAdvSmoothMessageDialog.Preview;
begin
  FFocusedButton := 0;
  frm := TAdvSmoothMessageDialogForm.CreateNew(Application);
  frm.Dialog := Self;
  frm.Init;
  frm.OnClose := CloseForm;
  frm.Show;
end;

procedure TAdvSmoothMessageDialog.SetButtonAreaFill(const Value: TGDIPFill);
begin
  if FButtonAreaFill <> value then
  begin
    FButtonAreaFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetButtonFont(const Value: TFont);
begin
  if FButtonFont <> value then
  begin
    FButtonFont.Assign(Value);
    changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetButtonLayout(
  const Value: TAdvSmoothMessageDialogButtonLayout);
begin
  if FButtonLayout <> value then
  begin
    FButtonLayout := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetButtons(
  const Value: TAdvSmoothMessageDialogButtons);
begin
  if FButtons <> value then
  begin
    FButtons.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetButtonSpacing(const Value: integer);
begin
  if FButtonSpacing <> value then
  begin
    FButtonSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetCaptionFill(const Value: TGDIPFill);
begin
  if FCaptionFill <> value then
  begin
    FCaptionFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetCaptionFont(const Value: TFont);
begin
  if FCaptionFont <> value then
  begin
    FCaptionFont.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetCaptionHeight(const Value: integer);
begin
  if FCaptionHeight <> Value then
  begin
    FCaptionHeight := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetCaptionLeft(const Value: integer);
begin
  if FCaptionLeft <> value then
  begin
    FCaptionLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetCaptionLocation(
  const Value: TAdvSmoothMessageDialogLocation);
begin
  if FCaptionLocation <> Value then
  begin
    FCaptionLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetCaptionTop(const Value: integer);
begin
  if FCaptionTop <> Value then
  begin
    FCaptionTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetComponentStyle(AStyle: TTMSStyle);
var
  i: integer;
begin
  // TODO : do color settings here
 case AStyle of
    tsOffice2003Blue:
      begin
        Fill.Color := $00FFD2AF;
        Fill.ColorTo := $00FFD2AF;
      end;
    tsOffice2003Silver:
      begin
        Fill.Color := $00E6D8D8;
        Fill.ColorTo := $00E6D8D8;
      end;
    tsOffice2003Olive:
      begin
        Fill.Color := RGB(225, 234, 185);
        Fill.ColorTo := RGB(225, 234, 185);
      end;
    tsOffice2003Classic:
      begin
        Fill.Color := $00F2F2F2;
        Fill.ColorTo := $00F2F2F2;
      end;
    tsOffice2007Luna:
      begin
        Fill.Color := $00F3E5DA;
        Fill.ColorTo := $00F0DED0;
      end;
    tsOffice2007Obsidian:
      begin
        Fill.Color := $5C534C;
        Fill.ColorTo := $5C534C;
      end;
    tsWindowsXP:
      begin
        Fill.Color := $00B6B6B6;
        Fill.ColorTo := $00B6B6B6;
      end;
    tsWhidbey:
      begin
        Fill.Color := $F5F9FA;
        Fill.ColorTo := $F5F9FA;
      end;
    tsCustom: ;
    tsOffice2007Silver:
      begin
        Fill.Color := RGB(241, 244, 248);
        Fill.ColorTo := RGB(227, 232, 240);
      end;
  end;

  Fill.Opacity := 240;
  Fill.OpacityTo := 220;
  Fill.BorderColor := clBlack;
  CaptionFill.Color := clWhite;
  CaptionFill.Opacity := 100;
  CaptionFill.OpacityTo := 0;
  CaptionFill.Rounding := 5;
  CaptionFill.RoundingType := rtTop;
  CaptionFont.Size := 10;
  ButtonFont.Size := 8;

  Fill.Rounding := 5;
  CaptionFill.Rounding := 5;
  CaptionFill.RoundingType := rtTop;
  ButtonAreaFill.Color := clwhite;
  ButtonAreaFill.Colorto := clWhite;
  ButtonAreaFill.Opacity := 0;
  ButtonAreaFill.OpacityTo := 100;
  ButtonAreaFill.Rounding := 5;
  ButtonAreaFill.RoundingType := rtBottom;

  for I := 0 to Buttons.Count - 1 do
  begin
    Buttons[I].Color := Fill.Color;
    Buttons[I].ColorDown := Fill.ColorTo;
    Buttons[I].HoverColor := $F5F9FA;
  end;

end;

procedure TAdvSmoothMessageDialog.SetEnableKeyEvents(const Value: Boolean);
begin
  if FEnableKeyEvents <> value then
  begin
    FEnableKeyEvents := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetFill(const Value: TGDIPFill);
begin
  if FFill <> Value then
  begin
    FFill.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetHTMLText(
  const Value: TAdvSmoothMessageDialogHTMLText);
begin
  if FHTMLText <> Value then
  begin
    FHTMLText.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetMargin(const Value: integer);
begin
  if FMargin <> Value then
  begin
    FMargin := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetName(const Value: TComponentName);
begin
  inherited;
  if not (csLoading in ComponentState) then
    Caption := Name;
end;

procedure TAdvSmoothMessageDialog.SetTabStop(const Value: Boolean);
begin
  if FTabStop <> Value then
  begin
    FTabStop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialog.SetVersion(const Value: String);
begin

end;

{ TAdvSmoothMessageDialogForm }

procedure TAdvSmoothMessageDialogForm.ClearBuffer(graphics: TGPGraphics);
var
  g: TGPGraphics;
begin
  g := graphics;
  if not Assigned(g) then
    g := CreateGraphics;
  g.Clear($00000000);
  if not Assigned(graphics) then
    g.Free;
end;

procedure TAdvSmoothMessageDialogForm.CMDialogKey(var Msg: TWMKey);
begin
  if Assigned(Dialog) and IsWindowVisible(self.Handle) and (msg.charcode = VK_TAB) then
  begin
    if Dialog.FFocusedButton = Dialog.Buttons.Count - 1 then
      Dialog.FFocusedButton := 0
    else
      Inc(Dialog.FFocusedButton);

    Dialog.Changed;
  end;
end;

procedure TAdvSmoothMessageDialogForm.CMMouseLeave(var Message: TMessage);
begin
  Invalidate;
end;

function TAdvSmoothMessageDialogForm.CreateGraphics: TGPGraphics;
begin
  Result := nil;
  if Assigned(FMainBuffer) then
    Result := TGPGraphics.Create(FMainBuffer);
end;

procedure TAdvSmoothMessageDialogForm.CreateMainBuffer;
begin
  if Assigned(FMainBuffer) then
    FMainBuffer.Free;

  FMainBuffer := TGPBitmap.Create(Width, Height, PixelFormat32bppARGB);
end;

constructor TAdvSmoothMessageDialogForm.CreateNew(AOwner: TComponent;
  Dummy: Integer);
begin
  inherited;
end;

procedure TAdvSmoothMessageDialogForm.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := WS_EX_NOACTIVATE;
end;

procedure TAdvSmoothMessageDialogForm.CreateWnd;
begin
  inherited;
  if Assigned(Dialog) then
  begin
    Dialog.CalculateMaximum;
    Width := Round(Dialog.FMaxDialog.totalmaxwidth);
    Height := Round(Dialog.FMaxDialog.totalmaxheight + Dialog.Margin * 2);
    UpdateButtons;
    UpdateWindow;
  end;
end;

procedure TAdvSmoothMessageDialogForm.DestroyMainBuffer;
begin
  if Assigned(FMainBuffer) then
    FMainBuffer.Free;
end;

procedure TAdvSmoothMessageDialogForm.DoCreate;
begin
  inherited;
  FMainBuffer := nil;
end;

procedure TAdvSmoothMessageDialogForm.DoDestroy;
begin
  inherited;
  DestroyMainBuffer;
end;

procedure TAdvSmoothMessageDialogForm.Draw(graphics: TGPGraphics);
var
  R: TRect;
  sri, captionr, htmlr, totalr: TGPRectF;
  boundsr, buttonr: TGPRectF;
  g: TGPGraphics;
  ff: TGPFontFamily;
  fs: integer;
  sf: TGPStringFormat;
  x, y: single;
  f: TGPFont;
  b: TGPSolidBrush;
  pt: TGPPointF;
  i: integer;
begin
  g := graphics;
  if not Assigned(g) then
    g := CreateGraphics;

  g.SetSmoothingMode(SmoothingModeAntiAlias);
  g.SetTextRenderingHint(TextRenderingHintAntiAlias);

  if Assigned(Dialog) then
  begin
    with Dialog do
    begin
      R := ClientRect;
      totalr := MakeRect(R.Left, R.Top, R.Right - R.Left - 1, R.Bottom - R.Top - 1);
      boundsr := MakeRect(totalr.X + Margin, totalr.Y + Margin, totalr.Width - (Margin * 2), totalr.Height - (Margin * 2));

      captionr := GetCaptionRect(R);
      captionr.X := captionr.X - 5;
      captionr.Width := captionr.Width + 5;
      htmlr := GetHTMLRect(R);
      buttonr := GetButtonRect(R);

      //background
      FFill.Fill(g, boundsr);

      if (buttonr.Width <> 0) and (buttonr.Height <> 0) and (Buttons.Count > 0) then
      begin
        //Background button area
        FButtonAreaFill.Fill(g, buttonr);

        //buttons
        for I := 0 to Buttons.Count - 1 do
        begin
          DrawButton(g, Buttons[i], Buttons[I].FBtnr);
        end;
      end;

      //caption
      if captionr.Height <> 0 then
      begin
        FCaptionFill.Fill(g, captionr);
        if FCaption <> '' then
        begin
          ff := TGPFontFamily.Create(CaptionFont.Name);
          if (ff.Status in [FontFamilyNotFound, FontStyleNotFound]) then
          begin
            ff.Free;
            ff := TGPFontFamily.Create('Arial');
          end;

          fs := 0;
          if (fsBold in CaptionFont.Style) then
            fs := fs + 1;
          if (fsItalic in CaptionFont.Style) then
            fs := fs + 2;
          if (fsUnderline in CaptionFont.Style) then
            fs := fs + 4;

          sf := TGPStringFormat.Create;
          f := TGPFont.Create(ff, CaptionFont.Size, fs, UnitPoint);
          b := TGPSolidBrush.Create(ColorToARGB(CaptionFont.Color));
          g.MeasureString(Caption, length(Caption), f, captionr, sf, sri);

          if CaptionLocation <> hlCustom then
            GetObjectLocation(x, y, captionr, Round(sri.Width), Round(sri.Height), CaptionLocation)
          else
          begin
            x := CaptionLeft;
            y := CaptionTop;
          end;

          pt := MakePoint(x, y);
          g.DrawString(Caption, Length(Caption), f, pt, sf, b);
          b.Free;
          sf.Free;
          f.Free;
          ff.Free;
        end;
      end;
      //html
      if htmlr.Height <> 0 then
      begin
        DrawHTMLText(g, HTMLText, htmlr, HTMLText.Text);
      end;

      {
      //Closebutton
      cb := TGDIPDialogButton.Create;
      cb.Font.Style := [fsBold];
      cb.Draw(g, 'X', Round(captionr.X + captionr.Width - 20 - Fill.Rounding / 2), Round(captionr.Y + Fill.Rounding / 2),
        20, 20, clRed, clBlack, 1, 255, 150,
      true, false, nil, false);
      cb.Free;
      }
    end;
  end;

  if not Assigned(graphics) then
    g.Free;
end;

procedure TAdvSmoothMessageDialogForm.Init;
begin
  Visible := False;
  BorderIcons := [];
  BorderStyle := bsNone;
  Ctl3D := false;
  FormStyle := fsStayOnTop;
  Color := clWhite;
  Position := Dialog.Position;
  Left := Dialog.DialogLeft;
  Top := Dialog.DialogTop;
  CreateMainBuffer;
  SetLayeredWindow;
  UpdateLayered;
end;

procedure TAdvSmoothMessageDialogForm.KeyDown(var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Assigned(Dialog) then
  begin
    if Dialog.EnableKeyEvents then
    begin
      if key = VK_ESCAPE then
        ModalResult := mrCancel
      else if key = VK_RETURN then
        ModalResult := mrOk
      else if Key in [VK_LEFT, VK_UP] then
      begin
        if Dialog.FFocusedButton = 0 then
          Dialog.FFocusedButton := Dialog.Buttons.Count - 1
        else
          Dec(Dialog.FFocusedButton);

        Dialog.Changed;
      end
      else if Key in [VK_RIGHT, VK_DOWN] then
      begin
        if Dialog.FFocusedButton = Dialog.Buttons.Count - 1 then
          Dialog.FFocusedButton := 0
        else
          Inc(Dialog.FFocusedButton);

        Dialog.Changed;
      end
      else if Key = VK_SPACE then
      begin
        if (Dialog.FFocusedButton >= 0) and (Dialog.FFocusedButton <= Dialog.Buttons.Count - 1) then
        begin
          Dialog.Buttons[Dialog.FFocusedButton].FDown := true;
          Dialog.Changed;
        end;
      end;
    end;
  end;

end;

procedure TAdvSmoothMessageDialogForm.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Assigned(Dialog) then
  begin
    if (Key = VK_SPACE) and Dialog.EnableKeyEvents then
    begin
      if (Dialog.FFocusedButton >= 0) and (Dialog.FFocusedButton <= Dialog.Buttons.Count - 1) then
      begin
        Dialog.Buttons[Dialog.FFocusedButton].FDown := false;
        Dialog.Changed;
        ModalResult := Dialog.Buttons[Dialog.FFocusedButton].ButtonResult;
      end;
    end;
  end;
end;

procedure TAdvSmoothMessageDialogForm.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  btnidx: integer;
  anchor: String;
  g: TGPGraphics;
begin
  inherited;
  if Assigned(Dialog) then
  begin
    if Assigned(Dialog.OnAnchorClick) then
    begin
      g := CreateGraphics;
      anchor := Dialog.GetAnchorAt(g, X, Y, ClientRect);
      if anchor <> '' then
        Dialog.OnAnchorClick(Self, anchor);

      g.Free;
    end;

    btnidx := Dialog.GetButtonIndexAtXY(X, Y);
    if btnidx <> -1 then
    begin
      FMouseDownOnButton := true;
      FButtonidx := btnidx;
      Dialog.Buttons[btnidx].FDown := true;
      Dialog.Changed;
    end;
  end;
end;

procedure TAdvSmoothMessageDialogForm.MouseMove(Shift: TShiftState; X,
  Y: Integer);
var
  i, btnidx: integer;
  g: TGPGraphics;
begin
  inherited;

  if FMouseDownOnButton then
    Exit;

  if Assigned(Dialog) then
  begin
    g := CreateGraphics;
    if Dialog.GetAnchorAt(g, X, Y, ClientRect) <> '' then
      Screen.Cursor := crHandPoint
    else
      Screen.Cursor := crDefault;
    g.Free;

    btnidx := Dialog.GetButtonIndexAtXY(X, Y);
    for I := 0 to Dialog.Buttons.Count - 1 do
    begin
      if btnidx <> I then
      begin
        if Dialog.Buttons[I].FHover then
        begin
          Dialog.Buttons[I].FHover := false;
          Dialog.Changed;
        end;
      end;
    end;
    if (btnidx <> -1) then
    begin
      if not Dialog.Buttons[btnidx].FHover then
      begin
        Dialog.Buttons[btnidx].FHover := true;
        Dialog.Changed;
      end;
    end;
  end;
end;

procedure TAdvSmoothMessageDialogForm.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
  btnidx: integer;
begin
  inherited;
  FMouseDownOnButton := false;
  if Assigned(Dialog) then
  begin
    btnidx := Dialog.GetButtonIndexAtXY(X, Y);
    if (btnidx <> -1) and (btnidx = FButtonidx) then
    begin
      ModalResult := Dialog.Buttons[btnidx].ButtonResult;
      Close;
    end;

    for I := 0 to Dialog.Buttons.Count - 1 do
    begin
      Dialog.Buttons[I].FDown := false;
      Dialog.Buttons[I].FHover := false;
    end;

    Dialog.Changed;
  end;
end;

procedure TAdvSmoothMessageDialogForm.Paint;
begin
  inherited;
end;

procedure TAdvSmoothMessageDialogForm.SetLayeredWindow;
begin
  if GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_LAYERED = 0 then
    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);

  UpdateLayered;
end;

procedure TAdvSmoothMessageDialogForm.UpdateButtons;
var
  buttonr: TGPRectF;
  i: integer;
  smaxw, smaxh, bwidth, bheight: Double;
begin
  if Assigned(Dialog) then
  begin
    with Dialog do
    begin
      buttonr := GetButtonRect(ClientRect);
      smaxw := 0;
      smaxh := 0;

      case ButtonLayout of
        blhorizontal:
        begin
          smaxw :=  (FMaxDialog.maxbuttonwidth * Buttons.Count) + ButtonSpacing;
          smaxh :=  FMaxDialog.maxbuttonheight;
        end;
        blVertical:
        begin
          smaxw :=  FMaxDialog.maxbuttonwidth + ButtonSpacing;
          smaxh :=  FMaxDialog.maxbuttonheight * Buttons.Count;
        end;

      end;

      if smaxw > buttonr.Width then
        Self.Width := Round(smaxw + Margin * 2);

      if smaxh > buttonr.Height then
        Self.Height := Round(GetCaptionRect(ClientRect).Height + GetHTMLRect(ClientRect).Height + smaxh + Margin * 2 + ButtonSpacing);

      bwidth := FMaxDialog.maxbuttonwidth - ButtonSpacing;
      bheight := FMaxDialog.maxbuttonheight - ButtonSpacing;

      buttonr := GetButtonRect(ClientRect);

      case ButtonLayout of
        blHorizontal:
        begin
          if smaxw < buttonr.Width then
            buttonr.X := buttonr.X + Max(0, (buttonr.Width - smaxw) / 2);

          for I := 0 to Buttons.Count - 1 do
            Buttons[I].FBtnr := MakeRect(buttonr.X + (I * bwidth) + ((I + 1) * ButtonSpacing),
              buttonr.Y + (buttonr.Height - bheight) / 2, bwidth, bheight)
        end;
        blVertical:
        begin
          for I := 0 to Buttons.Count - 1 do
            Buttons[I].FBtnr := MakeRect(buttonr.X + (buttonr.Width - bwidth) / 2,
              buttonr.Y + (I * bheight) + ((I + 1) * ButtonSpacing), bwidth, bheight);
        end;
      end;
    end;
  end;
end;

procedure TAdvSmoothMessageDialogForm.UpdateLayered;
begin
  ClearBuffer(nil);

  self.Activate;
  SetWindowPos(Self.Handle, HWND_TOPMOST, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED);

  Draw(nil);

  UpdateMainWindow;
end;

procedure TAdvSmoothMessageDialogForm.UpdateMainWindow;
var
  ScrDC, MemDC: HDC;
  BitmapHandle, PrevBitmap: HBITMAP;
  BlendFunc: _BLENDFUNCTION;
  Size: TSize;
  P, S: TPoint;
begin
//  while BlendFunc.SourceConstantAlpha < 255 do  
//  begin
    ScrDC := CreateCompatibleDC(0);
    MemDC := CreateCompatibleDC(ScrDC);

    FMainBuffer.GetHBITMAP(0, BitmapHandle);
    PrevBitmap := SelectObject(MemDC, BitmapHandle);
    Size.cx := Width;
    Size.cy := Height;
    P := Point(Left, Top);
    S := Point(0, 0);

    with BlendFunc do
    begin
      BlendOp := AC_SRC_OVER;
      BlendFlags := 0;
      SourceConstantAlpha := 255;      
      AlphaFormat := AC_SRC_ALPHA;
    end;

    UpdateLayeredWindow(Handle, ScrDC, @P, @Size, MemDC, @S, 0, @BlendFunc, ULW_ALPHA);    

    SelectObject(MemDC, PrevBitmap);
    DeleteObject(BitmapHandle);

    DeleteDC(MemDC);
    DeleteDC(ScrDC);
//  end;
end;

procedure TAdvSmoothMessageDialogForm.UpdateWindow;
begin
  CreateMainBuffer;
  UpdateLayered;
end;

procedure TAdvSmoothMessageDialogForm.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  inherited;
end;

procedure TAdvSmoothMessageDialogForm.WMNCHitTest(var Msg: TWMNCHitTest);
var
  pt: TPoint;
  r: TGPRectF;
begin
  inherited;

  if Assigned(Dialog) then
  begin
    with Dialog do
    begin
      pt := ScreenToClient(Point(msg.XPos, msg.YPos));
      r := GetCaptionRect(ClientRect);
      if pt.Y < r.Y + r.Height then
        Msg.Result := HTCAPTION;
    end;
  end;
end;

procedure TAdvSmoothMessageDialogForm.WMPaint(var Message: TWMPaint);
begin
  inherited;
end;

{ TAdvSmoothMessageDialogHTMLText }

procedure TAdvSmoothMessageDialogHTMLText.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothMessageDialogHTMLText) then
  begin
    FURLColor := (Source as TAdvSmoothMessageDialogHTMLText).URLColor;
    FShadowOffset := (Source as TAdvSmoothMessageDialogHTMLText).ShadowOffset;
    FShadowColor := (Source as TAdvSmoothMessageDialogHTMLText).ShadowColor;
    FFont.Assign((Source as TAdvSmoothMessageDialogHTMLText).Font);
    FText := (Source as TAdvSmoothMessageDialogHTMLText).Text;
    FLocation := (Source as TAdvSmoothMessageDialogHTMLText).Location;
    FTop := (Source as TAdvSmoothMessageDialogHTMLText).Top;
    FLeft := (Source as TAdvSmoothMessageDialogHTMLText).Left;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogHTMLText.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothMessageDialogHTMLText.Create(
  AOwner: TAdvSmoothMessageDialog);
begin
  FOwner := AOwner;
  FURLColor := clBlue;
  FShadowOffset := 5;
  FShadowColor := clGray;
  FLocation := hlCenterLeft;
  FFont := TFont.Create;
  {$IFNDEF DELPHI9_LVL}
  FFont.Name := 'Tahoma';
  {$ENDIF}
  FTop := 0;
  FLeft := 0;
end;

destructor TAdvSmoothMessageDialogHTMLText.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TAdvSmoothMessageDialogHTMLText.SetFont(const Value: TFont);
begin
  if FFont <> Value then
  begin
    FFont.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogHTMLText.SetLeft(const Value: integer);
begin
  if FLeft <> Value then
  begin
    FLeft := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogHTMLText.SetLocation(
  const Value: TAdvSmoothMessageDialogLocation);
begin
  if FLocation <> value then
  begin
    FLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogHTMLText.SetShadowColor(const Value: TColor);
begin
  if FShadowColor <> value then
  begin
    FShadowColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogHTMLText.SetShadowOffset(const Value: integer);
begin
  if FShadowOffset <> value then
  begin
    FShadowOffset := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogHTMLText.SetText(const Value: string);
begin
  if FText <> value then
  begin
    FText := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogHTMLText.SetTop(const Value: integer);
begin
  if FTop <> Value then
  begin
    FTop := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogHTMLText.SetURLColor(const Value: TColor);
begin
  if FURLColor <> Value then
  begin
    FURLColor := Value;
    Changed;
  end;
end;

{ TAdvSmoothMessageDialogButton }

procedure TAdvSmoothMessageDialogButton.Assign(Source: TPersistent);
begin
  if (Source is TAdvSmoothMessageDialogButton) then
  begin
    FOpacity := (Source as TAdvSmoothMessageDialogButton).Opacity;
    FPicture.Assign((Source as TAdvSmoothMessageDialogButton).Picture);
    FColor := (Source as TAdvSmoothMessageDialogButton).Color;
    FCaption := (Source as TAdvSmoothMessageDialogButton).Caption;
    FSpacing := (Source as TAdvSmoothMessageDialogButton).Spacing;
    FPictureLocation := (Source as TAdvSmoothMessageDialogButton).PictureLocation;
    FButtonResult := (Source as TAdvSmoothMessageDialogButton).ButtonResult;
    FColorDown := (Source as TAdvSmoothMessageDialogButton).ColorDown;
    FBorderColor := (Source as TAdvSmoothMessageDialogButton).BorderColor;
    FBorderWidth := (Source as TAdvSmoothMessageDialogButton).BorderWidth;
    FBorderOpacity := (Source as TAdvSmoothMessageDialogButton).BorderOpacity;
    FHoverColor := (Source as TAdvSmoothMessageDialogButton).HoverColor;
    FEnabled := (Source as TAdvSmoothMessageDialogButton).Enabled;
    FColorDisabled := (Source as TAdvSmoothMessageDialogButton).ColorDisabled;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.ButtonChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothMessageDialogButton.Changed;
begin
  FOwner.Changed;
end;

constructor TAdvSmoothMessageDialogButton.Create(Collection: TCollection);
begin
  inherited;
  Fowner := (Collection as TAdvSmoothMessageDialogButtons).FOwner;
  FOpacity := 255;
  FPicture := TAdvGDIPPicture.Create;
  FPicture.OnChange := PictureChanged;
  FColor := clGray;
  FButtonResult  := mrOk;
  FPictureLocation := blPictureLeft;
  FColorDown := clDkGray;
  FBorderColor := clBlack;
  FHoverColor := clLtGray;
  FBorderWidth := 1;
  FBorderOpacity := 255;
  FEnabled := true;
  FColorDisabled := $797979;
end;

destructor TAdvSmoothMessageDialogButton.Destroy;
begin
  FPicture.Free;
  inherited;
end;

procedure TAdvSmoothMessageDialogButton.PictureChanged(Sender: TObject);
begin
  Changed;
end;

procedure TAdvSmoothMessageDialogButton.SetCaption(const Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetColor(const Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetColorDisabled(const Value: TColor);
begin
  if FColorDisabled <> value then
  begin
    FColorDisabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetColorDown(const Value: TColor);
begin
  if FColorDown <> value then
  begin
    FColorDown := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> value then
  begin
    FEnabled := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetHoverColor(const Value: TColor);
begin
  if FHoverColor <> value then
  begin
    FHoverColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetOpacity(const Value: Byte);
begin
  if FOpacity <> value then
  begin
    FOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetPicture(
  const Value: TAdvGDIPPicture);
begin
  if FPicture <> value then
  begin
    FPicture.Assign(Value);
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetPictureLocation(
  const Value: TGDIPButtonLayout);
begin
  if FPictureLocation <> value then
  begin
    FPictureLocation := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetSpacing(const Value: integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> value then
  begin
    FBorderColor := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetBorderOpacity(const Value: Byte);
begin
  if FBorderOpacity <> Value then
  begin
    FBorderOpacity := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetBorderWidth(const Value: integer);
begin
  if FBorderWidth <> value then
  begin
    FBorderWidth := Value;
    Changed;
  end;
end;

procedure TAdvSmoothMessageDialogButton.SetButtonResult(const Value: TModalResult);
begin
  if FButtonResult <> Value then
  begin
    FButtonResult := Value;
    Changed;
  end;
end;

{ TAdvSmoothMessageDialogButtons }

function TAdvSmoothMessageDialogButtons.Add: TAdvSmoothMessageDialogButton;
begin
  Result := TAdvSmoothMessageDialogButton(inherited Add);
end;

constructor TAdvSmoothMessageDialogButtons.Create(
  AOwner: TAdvSmoothMessageDialog);
begin
  inherited Create(TAdvSmoothMessageDialogButton);
  FOwner := AOwner;
end;

procedure TAdvSmoothMessageDialogButtons.Delete(Index: Integer);
begin
  Items[Index].Free;
end;

function TAdvSmoothMessageDialogButtons.GetItem(
  Index: Integer): TAdvSmoothMessageDialogButton;
begin
  Result := TAdvSmoothMessageDialogButton(inherited Items[Index]);
end;

function TAdvSmoothMessageDialogButtons.GetOwner: TPersistent;
begin
  result := FOwner;
end;

function TAdvSmoothMessageDialogButtons.Insert(
  Index: Integer): TAdvSmoothMessageDialogButton;
begin
  Result := TAdvSmoothMessageDialogButton(inherited Insert(Index));
end;

procedure TAdvSmoothMessageDialogButtons.SetItem(Index: Integer;
  const Value: TAdvSmoothMessageDialogButton);
begin
  inherited Items[Index] := Value;
end;

{ TMargins }

end.
