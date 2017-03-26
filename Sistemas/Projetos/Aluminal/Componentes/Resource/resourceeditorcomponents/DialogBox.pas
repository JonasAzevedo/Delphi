unit DialogBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, commctrl, richedit;

type
  TOnDlgMessage = procedure (sender : TObject; var msg : TMessage; bcontinue : boolean) of object;

  TDialogBox = class(TWinControl)
  private
    fResourceTemplate: pointer;
    fHwndDlg : HWND;
    fOnDlgMessage: TOnDlgMessage;
    fParentObjectInstance : pointer;
    fOldParentWindowProc : TFNWndProc;

    fBaseUnitX, fBaseUnitY : Double;
    fMargin: Integer;
    fWidthAdjust: Integer;
    fHeightAdjust: Integer;

    procedure SetResourceTemplate(const Value: pointer);
    procedure WmActivate (var Msg : TWMActivate); message WM_ACTIVATE;
    procedure WmDestroy (var msg : TwmDestroy); message WM_DESTROY;
    procedure WmEraseBkGnd (var msg : TWmEraseBkGnd); message WM_ERASEBKGND;
    procedure ParentWindowProc(var msg: TMessage);

  protected
    procedure HandleDlgMessage (var Msg : TMessage); virtual;
    procedure PaintWindow (DC : HDC); override;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    property Margin : Integer read fMargin write fMargin;
    property WidthAdjust : Integer read fWidthAdjust write fWidthAdjust;
    property HeightAdjust : Integer read fHeightAdjust write fHeightAdjust;

    { Protected declarations }
  public
    constructor Create (AOwner : TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    procedure EndDialog; virtual;
    procedure ShowDialog; virtual;
    procedure AdjustStyle; virtual;
    procedure Changed;

    property ResourceTemplate : pointer read fResourceTemplate write SetResourceTemplate;

    property DialogHandle : HWND read fHwndDlg;
    function PointToDialogPoint (pt : TPoint) : TPoint;
    function RectToDialogRect (r : TRect) : TRect;
    function DialogRectToRect (r : TRect) : TRect;
  published
    property OnDlgMessage : TOnDlgMessage read fOnDlgMessage write fOnDlgmessage;
    property AutoSize default True;
    property Color default clBtnFace;
    property OnKeyDown;
    property ParentColor;
    property OnResize;
    { Published declarations }
  end;


var
  dlgList : TList;

procedure Register;

implementation

type
  TDlgTemplateEx = packed record
    dlgVer : word;
    signature : word;
    helpID : DWORD;
    exStyle : DWORD;
    style : DWORD;
    cDlgItems : WORD;
    x, y, cx, cy : smallint;


    // ... etc...
  end;
  PDlgTemplateEx = ^TDlgTemplateEx;


procedure Register;
begin
  RegisterComponents('Misc Units', [TDialogBox]);
end;

function DialogProc (hwndDlg : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : BOOL; stdcall;
var
  dlgInstance : TDialogBox;
  msg : TMessage;
  i : Integer;
  rect : TRect;

begin
  result := False;
  dlgInstance := Nil;
  if uMsg = WM_INITDIALOG then
  begin
    dlgInstance := TDialogBox (lParam);
    dlgInstance.fhwndDlg := hwndDlg;
    GetWindowRect (hwndDlg, rect);
    MapWindowPoints (HWND_DESKTOP, dlgInstance.Parent.Handle, rect, 2);
    with rect do dlgInstance.SetBounds (dlgInstance.Left, dlgInstance.Top, right - left, bottom - top);
    dlgList.Add (dlgInstance);
  end
  else
    for i := 0 to dlgList.Count - 1 do
      if TDialogBox (dlgList [i]).fhwndDlg = hwndDlg then
      begin
        dlgInstance := TDialogBox (dlgList [i]);
        break
      end;

  if Assigned (dlgInstance) then
  begin
    msg.Msg := uMsg;
    msg.WParam := wParam;
    msg.LParam := lParam;
    msg.Result := 0;

    dlgInstance.HandleDlgMessage (msg);
    result := Bool (msg.Result);

    if uMsg = WM_DESTROY then
    begin
      dlgList.Delete (dlgList.IndexOf (dlgInstance));
      SetParent (dlgInstance.fhwndDlg, 0);
      dlgInstance.fhwndDlg := 0;
      result := True;
    end
  end
end;

{ TDialogBox }

procedure TDialogBox.AdjustStyle;
var
  Template : PDlgTemplate;
  ExTemplate : PDlgTemplateEx;
begin
  Template := PDlgTemplate (fResourceTemplate);
  if HiWord (Template^.Style) = $ffff then
  begin
    ExTemplate := PDlgTemplateEx (fResourceTemplate);
    ExTemplate^.style := (ExTemplate^.style and not (WS_POPUP or DS_CENTER)) or WS_CHILD;
    ExTemplate^.x := Margin;
    ExTemplate^.y := Margin;
  end
  else
  begin
    Template^.style := (Template^.style and not (WS_POPUP or DS_CENTER)) or WS_CHILD;
    Template^.x := Margin;
    Template^.y := Margin;
  end
end;

function TDialogBox.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var
  r : TRect;
  w, h : Integer;
begin
  Result := True;
  if not (csDesigning in ComponentState) then
  begin
    if fHWndDlg <> 0 then
      GetWindowRect (fHWndDlg, r)
    else
      FillChar (r, SizeOf (r), 0);

    w := r.Right - r.Left + 1;
    h := r.Bottom - r.Top + 1;

    if Align in [alNone, alLeft, alRight] then
      NewWidth := w + 2 * Margin + WidthAdjust;

    if Align in [alNone, alTop, alBottom] then
      NewHeight := h + 2 * Margin + HeightAdjust;
  end
end;

procedure TDialogBox.Changed;
begin
  Realign;
  Resize;
  Invalidate
end;

constructor TDialogBox.Create(AOwner: TComponent);
begin
  inherited;
  width := 180;
  height := 120;
  Color := clBtnFace;
  AutoSize := True;
end;

procedure TDialogBox.CreateWnd;
begin
  inherited;
  fParentObjectInstance := MakeObjectInstance (ParentWindowProc);
  fOldParentWindowProc := TfnWndProc (SetWindowLong (Parent.Handle, GWL_WNDPROC, Integer (fParentObjectInstance)));
end;

procedure TDialogBox.DestroyWnd;
begin
  SetWindowLong (Parent.Handle, GWL_WNDPROC, Integer (fOldParentWindowProc));
  if Assigned (fParentObjectInstance) then
    FreeObjectInstance (fParentObjectInstance);

  inherited;
end;

procedure TDialogBox.EndDialog;
begin
  if fHWndDlg <> 0 then
    SendMessage (fHWndDlg, WM_CLOSE, 0, 0)
end;


procedure TDialogBox.HandleDlgMessage(var Msg: TMessage);
var
  p : PWindowPos;
  continueProcessing : boolean;

  procedure GetFontBaseUnits (var baseX, baseY : Double);
  var
    r : TRect;
  begin
    r := Rect (0, 0, 4, 8);
    MapDialogRect (fHWNDDlg, r);
    baseX := r.Right;
    baseY := r.Bottom;
  end;

begin
  ContinueProcessing := True;
  if Assigned (fOnDlgMessage) and not (csDestroying in ComponentState) then
  begin
    msg.result := Ord (False);
    OnDlgMessage (self, msg, ContinueProcessing)
  end;

  if continueProcessing then
  begin
    msg.result := Ord (True);
    case msg.Msg of
      WM_INITDIALOG :
        GetFontBaseUnits (fBaseUnitX, fBaseUnitY);

      WM_CLOSE :
        DestroyWindow (fHwndDlg);

      WM_LBUTTONDOWN,
      WM_RBUTTONDOWN,
      WM_NCLBUTTONDOWN,
      WM_NCRBUTTONDOWN :
        begin
          BringWindowToTop (Handle);
          SetActiveWindow (Handle);
          msg.result := Ord (False)
        end;

      WM_WINDOWPOSCHANGING :
      begin
        p := PWindowPos (msg.LParam);
        p.Flags := p.Flags or SWP_NOMOVE;
      end;

      else
        msg.result := Ord (FALSE);
    end
  end
end;

procedure TDialogBox.PaintWindow(DC: HDC);
var
  r : TRect;
begin
  inherited;
  if (csDesigning in ComponentState) then
  begin
    r := ClientRect;
    InflateRect (r, -2, -2);
    DrawEdge (DC, r, EDGE_RAISED, BF_RECT)
  end
end;

procedure TDialogBox.ParentWindowProc(var msg: TMessage);
begin
  if msg.Msg = WM_LBUTTONDOWN then
    Windows.Beep (440, 100);
  with Msg do
    result := CallWindowProc (fOldParentWindowProc, Parent.Handle, msg, wParam, lParam);
end;

procedure TDialogBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if fHWndDlg <> 0 then
    SetWindowPos (fhWndDlg, 0, Margin, Margin, AWidth, AHeight, SWP_NOZORDER);

  inherited;
end;

procedure TDialogBox.SetResourceTemplate(const Value: pointer);
begin
  EndDialog;
  fResourceTemplate := value;
  ShowDialog
end;

procedure TDialogBox.ShowDialog;
begin
  if Assigned (fResourceTemplate) then
  begin
    AdjustStyle;
    CreateDialogIndirectParam (hInstance, PDlgTemplate (fResourceTemplate)^, handle, @DialogProc, LPARAM (self));

    if fHWndDlg <> 0 then
    begin
      Parent.Invalidate;
      ShowWindow (fHwndDlg, SW_SHOW);
      Changed
    end
  end
end;

procedure TDialogBox.WmActivate(var Msg: TWMActivate);
begin
  MessageBeep ($ffff);
end;

procedure TDialogBox.WmDestroy(var msg: TwmDestroy);
begin
  EndDialog;
  inherited;
end;

procedure TDialogBox.WmEraseBkGnd(var msg: TWmEraseBkGnd);
begin
//  if not (csDesigning in ComponentState) then
//    msg.Result := 1
//  else
    inherited
end;

function TDialogBox.PointToDialogPoint(pt: TPoint): TPoint;
begin
  if fBaseUnitX = 0 then
    result := pt
  else
  begin
    result.x := Round (pt.x * 4 / fBaseUnitX);
    result.y := Round (pt.y * 8 / fBaseUnitY)
  end
end;

function TDialogBox.RectToDialogRect(r: TRect): TRect;
begin
  if fBaseUnitX = 0 then
    result := r
  else
  begin
    result.Left := Round (r.Left * 4 / fBaseUnitX);
    result.Top := Round (r.Top * 8 / fBaseUnitY);
    result.Right := Round (r.Right * 4 / fBaseUnitX);
    result.Bottom := Round (r.Bottom * 8 / fBaseUnitY)
  end
end;

function TDialogBox.DialogRectToRect(r: TRect): TRect;
begin
  MapDialogRect (DialogHandle, r);
  result := r;

end;

initialization
  dlgList := TList.Create;
finalization
  dlgList.Free;
end.
