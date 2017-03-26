(*======================================================================*
 | TDialogEditor component                                              |
 |                                                                      |
 | Dialog editor component.  Ouch.  This one hurt!                      |
 *======================================================================*)

unit DialogEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, commctrl, richedit, DialogBox;

type
  TControlProperty = (cpAcceptFiles, cpBorder, cpClientEdge, cpEnabled, cpGroup, cpHeight, cpHelpID, cpLeft,
                      cpStaticEdge, cpTabStop, cpText, cpTop, cpVisible, cpWidth);

type
  TDialogEditor = class;
  TPropertyType = (ptString, ptInteger, ptBoolean);

//----------------------------------------------------------------------
// TControlInfo allows us to manipulate controls on the dialog.  One is
// created automatically for each dialog control.
//
// nb.  To drop a new control on the dialog, set the TDialogEditor's
// 'DropComponent' property to the required control type, then click on
// the dialog.

  TControlInfo = class
  private
    fOwner : TDialogEditor;
    fItemID : Integer;
    fControlHWND : HWND;

    fOldWindowProc : pointer;
    fStyle : Integer;
    fExStyle : Integer;
    fGotStyle : boolean;

    constructor Create (AOwner : TDialogEditor; AItemID : Integer; AControlHWND : HWND);
    function WindowProc (uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : LRESULT;

    function GetStyle : Integer;
    function GetExStyle : Integer;
    function GetWindowRect: TRect;
    procedure SetWindowRect(const Value: TRect);
    function GetCtrlProperty(const name: string): variant;
    procedure SetCtrlProperty(const name: string; Value: variant);
    procedure SetExStyle(st: Integer; value: boolean);
    procedure SetStyle(st: Integer; value: boolean);
    function GetCtrlPropertyCount: Integer; virtual;
    function GetCtrlPropertyName(idx: Integer): string;
    function GetCtrlPropertyType(const name: string): TPropertyType;
  protected
    function FindControlProperty (const name : string) : TControlProperty;

  public
    class function GetClassName : PChar; virtual;
    class function GetDefaultStyle : DWORD; virtual;

    destructor Destroy; override;

    property Owner : TDialogEditor read fOwner;
    property ItemID : Integer read fItemID;
    property WindowRect : TRect read GetWindowRect write SetWindowRect;
    property ControlHandle : HWND read fControlHWND;

    property CtrlProperty [const name : string] : variant read GetCtrlProperty write SetCtrlProperty;
    property CtrlPropertyType [const name : string] : TPropertyType read GetCtrlPropertyType;
    property CtrlPropertyCount : Integer read GetCtrlPropertyCount;
    property CtrlPropertyName [idx : Integer] : string read GetCtrlPropertyName;
  end;

  TControlInfoClass = class of TControlInfo;

//----------------------------------------------------------------------
// Derive new TControlInfo based classes for each control type

  TDialogControlInfo = class (TControlInfo)
  public
    class function GetClassName : PChar; override;
  end;

  TStaticControlInfo = class (TControlInfo)
  public
    class function GetDefaultStyle : DWORD; override;
    class function GetClassName : PChar; override;
  end;

  TPictureControlInfo = class (TStaticControlInfo)
  public
    class function GetDefaultStyle : DWORD; override;
  end;

  TButtonControlInfo = class (TControlInfo)
  public
    class function GetClassName : PChar; override;
  end;

  TPushbuttonControlInfo = class (TButtonControlInfo)
  public
    class function GetDefaultStyle : DWORD; override;
  end;

  TGroupBoxControlInfo = class (TButtonControlInfo)
    class function GetDefaultStyle : DWORD; override;
  end;

  TCheckboxControlInfo = class (TButtonControlInfo)
  public
    class function GetDefaultStyle : DWORD; override;
  end;

  TEditControlInfo = class (TControlInfo)
  public
    class function GetDefaultStyle : DWORD; override;
    class function GetClassName : PChar; override;
  end;

//---------------------------------------------------------------------
// TResizeControl is attached to a control (or the dialog box itself)
// when it is selected

  TSnibType = (stLT, stMT, stRT, stLM, stRM, stLB, stMB, stRB, stFrame);

  TResizeControl = class (TWinControl)
  private
    fControlID: Integer;
    fDialogBox: TDialogEditor;
    FSizerWidth: Integer;
    fBasePT : TPoint;
    fBaseSnib : TSnibType;
    fControlHwnd : HWND;
    procedure SetControlID(const Value: Integer);
    procedure SetSizerWidth(const Value: Integer);
  protected
    procedure WmPaint (var msg : TWMPaint); message WM_PAINT;
    procedure PaintWindow (DC : HDC); override;
    procedure CreateWindowHandle (const Params : TCreateParams); override;
    procedure CreateParams (var Params : TCreateParams); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    constructor Create (AOwner : TComponent); override;
    property DialogBox : TDialogEditor read fDialogBox write fDialogBox;
    property ControlID : Integer read fControlID write SetControlID;
    property SizerWidth : Integer read FSizerWidth write SetSizerWidth;

    function PtInSnib (pt : TPoint; var snibType : TSnibType) : boolean;
    procedure RecalcSize;
  end;


  TDropControl = (drNone, drPicture, drStatic, drEdit, drGroupBox, drButton, drCheckBox,
                  drRadioButton, drComboBox, drListBox, drHScroll, drVScroll, drUpDown,
                  drProgressBar, drSlider, drHotKey, drListCtrl, drTreeCtrl, drPageCtrl,
                  drAnimate, drRichEdit, drDateTimePicker, drMonthCal, drIPAddress, drCustom,
                  drExtComboBox);

  TOnDropControl   = procedure (sender : TObject; x, y : Integer; control : TDropControl) of object;

  TDialogEditor = class (TDialogBox)
  private
    fDialogInfo : TControlInfo;
    fResizeControl : TResizeControl;
    fDropComponent: TDropControl;
    fDropping : boolean;
    fOnDropControl: TOnDropControl;
    fControlInfoList : TList;
    fSelectedItemID : Integer;
    fOnDesignModeSelectedItemChange : TNotifyEvent;
    procedure SetDesignModeSelectedItemID(const Value: Integer);
    procedure SetDropComponent(const Value: TDropControl);
    procedure SubclassDialogControls;
    procedure RestoreDialogControls;
    function EnumDialogControls (hwndCtrl : HWND) : boolean;

  protected
    procedure HandleDlgMessage (var Msg : TMessage); override;
    function HandleControlMessage (control : TControlInfo; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : LRESULT; virtual;

    procedure DestroyWnd; override;
  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    function GetControlInfo (itemID : Integer) : TControlInfo;

    property DesignModeSelectedItemID : Integer read FSelectedItemID write SetDesignModeSelectedItemID;
    property DropComponent : TDropControl read fDropComponent write SetDropComponent;
    procedure EndDialog; override;
    procedure ShowDialog; override;
  published
    property OnDesignModeSelectedItemChange : TNotifyEvent read fOnDesignModeSelectedItemChange write fOnDesignModeSelectedItemChange;
    property OnDesignModeDropControl : TOnDropControl read fOnDropControl write fOnDropControl;
  end;

function GetControlInfoClass (dropControl : TDropControl) : TControlInfoClass;

procedure Register;

implementation

(*
  controlWindowClassIDs : array [TDropControl] of Integer =
   (0, $82, $82, $81, $80, $80, $80,
    $80, $85, $83, $84, $84, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0);

  controlWindowDefaultStyles : array [TDropControl] of DWORD = (
    0,
    SS_BITMAP,                                  // drPicture
    WS_GROUP,                                   // drStatic
    ES_AUTOHSCROLL or WS_BORDER or WS_TABSTOP,  // drEdit
    BS_GROUPBOX,                                // drGroupBox
    WS_TABSTOP,                                 // drButton
    BS_AUTOCHECKBOX or WS_TABSTOP,              // drCheckBox
    BS_AUTORADIOBUTTON,                         // drRadiobutton
    WS_TABSTOP or CBS_SORT or WS_VSCROLL,       // ComboBox
    LBS_STANDARD or LBS_NOINTEGRALHEIGHT,       // Listbox
    SB_HORZ,                                    // Horizontal scroll bar
    SB_VERT,                                    // Vertical scroll bar
    UDS_ARROWKEYS,                              // Up/Down
    WS_BORDER,                                  // Progress bar
    WS_TABSTOP,                                 // Slider
    WS_TABSTOP,                                 // HotKey
    WS_TABSTOP or WS_BORDER,                    // Listview
    WS_TABSTOP or WS_BORDER,                    // TreeView
    0,                                          // Tabstop
    WS_TABSTOP or WS_BORDER,                    // Animate
    ECO_AUTOHSCROLL or WS_TABSTOP or WS_BORDER, // Richedit
    DTS_RIGHTALIGN or WS_TABSTOP,               // DateTime picker
    MCS_NOTODAY or WS_TABSTOP,                  // Monthcal
    WS_TABSTOP,                                 // IP Address
    0,                                          // Custom
    WS_TABSTOP);                                // ExComboBox
*)

const
  controlWindowClasses : array [TDropControl] of string =
   ('', 'STATIC', 'STATIC', 'EDIT', 'BUTTON', 'BUTTON', 'BUTTON',
    'BUTTON', 'COMBOBOX', 'LISTBOX', 'SCROLLBAR', 'SCROLLBAR', UPDOWN_CLASS,
    PROGRESS_CLASS, TRACKBAR_CLASS, HOTKEYCLASS, WC_LISTVIEW, WC_TREEVIEW, WC_TABCONTROL,
    ANIMATE_CLASS, RICHEDIT_CLASS, DATETIMEPICK_CLASS, MONTHCAL_CLASS, WC_IPADDRESS, 'Custom',
    WC_COMBOBOXEX);

  ControlPropertyNames : array [TControlProperty] of string =

  // nb.  *Must* be in alphabetical order

                     ('Accept Files', 'Border', 'Client Edge', 'Enabled', 'Group', 'Height', 'Help ID', 'Left',
                      'Static Edge', 'Tab Stop', 'Text', 'Top', 'Visible', 'Width');

  ControlPropertyNamesSupported : array [TControlProperty] of boolean =
                     (True, True, True, True, True, True, True, True,
                      True, True, True, True, True, True);

  ControlPropertyTypes : array [TControlProperty] of TPropertyType =
    (ptBoolean, ptBoolean, ptBoolean, ptBoolean, ptBoolean, ptInteger, ptInteger, ptInteger,
     ptBoolean, ptBoolean, ptString, ptInteger, ptBoolean, ptInteger);

procedure Register;
begin
  RegisterComponents('Misc Units', [TDialogEditor]);
end;

(*----------------------------------------------------------------------*
 | bsearch                                                              |
 |                                                                      |
 | Helper function to do a binary search on a sorted array              |
 *----------------------------------------------------------------------*)
function bsearch (a : array of string; const st : string) : Integer;

  function bs (s, e : Integer) : Integer;
  var
    m, c : Integer;
  begin
    if e >= s then
    begin
      m := s + (e - s) div 2;

      c := CompareText (st, a [m]);

      if c > 0 then
        result := bs (m + 1, e)
      else
        if c < 0 then
          result := bs (s, m - 1)
        else
          result := m
    end
    else
      result := -1
  end;

begin
  result := bs (Low (a), High (a))
end;


(*----------------------------------------------------------------------*
 | function GetDropControl () : TDropControl                            |
 |                                                                      |
 | Get our 'TDropControl' type from a windows class name and style.     |
 |                                                                      |
 | Parameters:                                                          |
 |                                                                      |
 |   const className : string        The Windows class name             |
 |   style : DWORD                   The window style                   |
 |                                                                      |
 | The function returns the TDropControl represntation of the windows   |
 | class type.                                                          |
 *----------------------------------------------------------------------*)
function GetDropControl (const className : string; style : DWORD) : TDropControl;
var
  i : TDropControl;

  function GetStaticDropControl (style : DWORD) : TDropControl;
  begin
    if (style and SS_BITMAP) <> 0 then
      result := drPicture
    else
      result := drStatic
  end;

  function GetButtonDropControl (style : DWORD) : TDropControl;
  begin
    case style and $1f of
      0..1, 8, 10, 11 : result := drButton;
      2..3, 5..6      : result := drCheckBox;
      4, 9            : result := drRadioButton;
      7               : result := drGroupBox;
      else
        result := drButton
    end
  end;

  function GetScrollbarDropControl (style : DWORD) : TDropControl;
  begin
    if (style and SB_VERT) <> 0 then
      result := drVScroll
    else
      result := drHScroll
  end;

begin
  result := drCustom;
  if CompareText (className, 'STATIC') = 0 then
    result := GetStaticDropControl (style)
  else
    if CompareText (className, 'BUTTON') = 0 then
      result := GetButtonDropControl (style)
    else
      if CompareText (className, 'SCROLLBAR') = 0 then
        result := GetScrollbarDropControl (style)
      else
        for i := Low (TDropControl) to High (TDropControl) do
          if CompareText (className, controlWindowClasses [i]) = 0 then
          begin
            result := i;
            break
          end
end;


(*----------------------------------------------------------------------*
 | function GetControlInfoClass () : TControlInfoClass                  |
 |                                                                      |
 | Get the TControlInfo derived class for a specified control           |
 |                                                                      |
 | Parameters:                                                          |
 |                                                                      |
 |   dropControl : TDropControl      The control type to find           |
 |                                                                      |
 | The function returns the derived TControlInfo class                  |
 *----------------------------------------------------------------------*)
function GetControlInfoClass (dropControl : TDropControl) : TControlInfoClass;
begin
  case dropControl of
    drPicture      : result := TPictureControlInfo;
    drStatic       : result := TStaticControlInfo;
    drEdit         : result := TEditControlInfo;
    drGroupBox     : result := TGroupBoxControlInfo;
    drButton       : result := TPushbuttonControlInfo;
    drCheckbox     : result := TCheckboxControlInfo;
  else
    result := TControlInfo;
  end;
end;


(*----------------------------------------------------------------------*
 | function ControlWindowProc () : LResult                              |
 |                                                                      |
 | WindowProc for subclassed dialog controls                            |
 |                                                                      |
 | Takes standard windows proc parameters, and returns standard lResult |
 *----------------------------------------------------------------------*)
function ControlWindowProc (wnd : HWND; uMsg : UINT; wParam : WPARAM; lParam : LPARAM) : LResult; stdcall;
var
  parentWnd : HWND;
  i : Integer;
  dlgInstance : TDialogBox;
  dlgEdInstance : TDialogEditor;
  ctrlThunk : TControlInfo;
begin
  result := 0;
  dlgInstance := Nil;

  parentWnd := GetParent (wnd);         // Find the dialog box who's parent
                                        // owns the control
  for i := 0 to dlgList.Count - 1 do
    if TDialogBox (dlgList [i]).DialogHandle = parentWnd then
    begin
      dlgInstance := TDialogBox (dlgList [i]);
      break
    end;

  if Assigned (dlgInstance) and (dlgInstance is TDialogEditor) then
  begin
                                        // Find the editor's controlInfo object
                                        // for the control.

    dlgEdInstance := TDialogEditor (dlgInstance);
    ctrlThunk := Nil;
    for i := 0 to dlgEdInstance.fControlInfoList.Count - 1 do
      if TControlInfo (dlgEdInstance.fControlInfoList [i]).fControlHWND = wnd then
      begin
        ctrlThunk := TControlInfo (dlgEdInstance.fControlInfoList [i]);
        break
      end;

    if Assigned (ctrlThunk) then
                                        // Call the controlInfo's WindowProc
      result := ctrlThunk.WindowProc (uMsg, wParam, lParam)
  end
end;

{ TDialogEditor }

(*----------------------------------------------------------------------*
 | constructor TDialogEditor.Create ();                                 |
 |                                                                      |
 | Constructor for TDialogEditor                                        |
 *----------------------------------------------------------------------*)
constructor TDialogEditor.Create (AOwner : TComponent);
begin
  inherited Create (AOwner);
  Margin := 5;
  fControlInfoList := TList.Create;
  fSelectedItemID := -1;
end;

(*----------------------------------------------------------------------*
 | destructor TDialogEditor.Destroy ();                                 |
 |                                                                      |
 | Destructor for TDialogEditor                                         |
 *----------------------------------------------------------------------*)
destructor TDialogEditor.Destroy;
begin
  fControlInfoList.Free;        // Free the ControlInfo list.  It will have
                                // been cleared by EndDialog below
  inherited;
end;

(*----------------------------------------------------------------------*
 | procedure TDialogEditor.DestroyWnd ();                               |
 |                                                                      |
 | Free the dialog's controlInfo.  That one's not on the control info   |
 | list                                                                 |
 *----------------------------------------------------------------------*)
procedure TDialogEditor.DestroyWnd;
begin
  FreeAndNil (fDialogInfo);
  inherited
end;

(*----------------------------------------------------------------------*
 | procedure TDialogEditor.EndDialog ();                                |
 |                                                                      |
 | Un-subclass the dialog controls.  Get rid of the resize control      |
 | too.                                                                 |
 *----------------------------------------------------------------------*)
procedure TDialogEditor.EndDialog;
begin
  FreeAndNil (fResizeControl);
  if DialogHandle <> 0 then
    RestoreDialogControls;

  inherited;
end;

(*----------------------------------------------------------------------*
 | procedure TDialogEditor.HandleDlgMessage                             |
 |                                                                      |
 | Overriden fro TDialogBox base class to handle dialog box messages    |
 *----------------------------------------------------------------------*)
procedure TDialogEditor.HandleDlgMessage (var Msg : TMessage);
var
  continueProcessing : boolean;
  pt : TPoint;
  r : TRect;
  i : Integer;

begin
{ TODO -oColin -cCosmetic Bug : Fix X close }

  if Msg.Msg <> WM_SYSCOMMAND then
    inherited HandleDlgMessage (Msg);

  case msg.Msg of
    WM_INITDIALOG:
      begin     // Initialize things.
        fDialogInfo := TDialogControlInfo.Create (self, 0, DialogHandle);
        fSelectedItemID := -1;
        DesignModeSelectedItemID := 0;
      end;

    WM_DESTROY: // Tidy up things.
      FreeAndNil (fDialogInfo);

                // Handle 'design mode' clicks
    WM_LBUTTONDOWN:

                // DropComponent is valid.  Tell the UI to drop one.
      if fDropping then
      begin
        fDropping := False;
        if Assigned (OnDesignModeDropControl) then
          OnDesignModeDropControl (self, LOWORD (msg.LParam), HIWORD (msg.LParam), fDropComponent)
      end
      else
      begin
        continueProcessing := False;

        pt.x := LOWORD (msg.LParam);
        pt.y := HIWORD (msg.LParam);

        for i := fControlInfoList.Count - 1 downto 0 do  // When controls are disabled they dont
        begin                                            // receive clicks, and we end up here.
                                                         // Forward the click to the control's handler

          GetWindowRect (TControlInfo (fControlInfoList [i]).fControlHWND, r);
          MapWindowPoints (HWND_DESKTOP, DialogHandle, r, 2);

          if PtInRect (r, pt) then
          begin
            SendMessage (TControlInfo (fControlInfoList [i]).fControlHWND, WM_LBUTTONDOWN, 0, 0);
            ContinueProcessing := True;
            break
          end
        end;

        if not ContinueProcessing then                  // No disabled control clicked
          if fSelectedItemID <> 0 then                  // select the dialog itself.
           DesignModeSelectedItemID := 0
      end
  end
end;

(*----------------------------------------------------------------------*
 | procedure TDialogEditor.RestoreDialogControls                        |
 |                                                                      |
 | Un-thunk the dialog controls, and clear the controls list            |
 *----------------------------------------------------------------------*)
procedure TDialogEditor.RestoreDialogControls;
var
  i : Integer;
begin
  for i := 0 to fControlInfoList.Count - 1 do
    TControlInfo (fControlInfoList [i]).Free;

  fControlInfoList.Clear;
end;

(*----------------------------------------------------------------------*
 | procedure TDialogEditor.EnumDialogControls                           |
 |                                                                      |
 | Called for each control.  Thunk the control to a new instance of the |
 | correct controlInfo class.                                           |
 *----------------------------------------------------------------------*)
function TDialogEditor.EnumDialogControls(hwndCtrl: HWND): boolean;
var
  parent : HWND;
  className : string;
  style : DWORD;
  dropControl : TDropControl;
  controlInfoClass : TControlInfoClass;
begin
  parent := GetParent (hwndCtrl);
  SetLength (className, 256);
  GetClassName (hwndCtrl, PChar (classname), 256);
  className := PChar (className);

  style := GetWindowLong (handle, GWL_STYLE);

  dropControl := GetDropControl (className, style);
  controlInfoClass := GetControlInfoClass (dropControl);

  if parent = DialogHandle then
    fControlInfoList.Add (controlInfoClass.Create (self, GetDlgCtrlID (hwndCtrl), hwndCtrl));
  result := True;
end;

(*----------------------------------------------------------------------*
 | procedure TDialogEditor.GetControlInfo                               |
 |                                                                      |
 | Find the controlInfo for a particular dialog item.  Get the          |
 | DialogInfo itelf if the itemID is 0.                                 |
 *----------------------------------------------------------------------*)
function TDialogEditor.GetControlInfo(itemID: Integer): TControlInfo;
var
  i : Integer;
begin
  if itemID = 0 then
    result := fDialogInfo
  else
  begin
    result := Nil;
    for i := 0 to fControlInfoList.Count - 1 do
      if TControlInfo (fControlInfoList [i]).fItemID = itemID then
      begin
        result := TControlInfo (fControlInfoList [i]);
        break
      end
  end
end;

(*----------------------------------------------------------------------*
 | procedure TDialogEditor.HandleControlMessage                         |
 |                                                                      |
 | Handle a windows message for a control                               |
 *----------------------------------------------------------------------*)
function TDialogEditor.HandleControlMessage(control: TControlInfo;
  uMsg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT;
var
  wmk : TWMKey;
begin
  result := 0;
  case uMsg of
    WM_LBUTTONDOWN :
      DesignModeSelectedItemID := control.fItemID;

    WM_SETFOCUS:;

    WM_NCACTIVATE:;

    WM_ACTIVATE:;

    WM_SYSCOMMAND:;

    WM_STYLECHANGED:
      begin
        if wParam = GWL_STYLE then
          control.fStyle := PStyleStruct (lParam).styleNew;
        if wParam = GWL_EXSTYLE then
          control.fExStyle := PStyleStruct (lParam).styleNew;
      end;

    WM_KEYDOWN:
      begin
        wmk.Msg := WM_KEYDOWN;
        wmk.CharCode := wParam;
        wmk.KeyData := lParam;
        DoKeyDown (wmk);
      end;

    WM_CHAR:;

    WM_KEYUP:;

    WM_LBUTTONDBLCLK :;

    WM_SIZE :
    begin
      result := CallWindowProc (control.fOldWindowProc, control.fControlHWND, uMsg, wParam, lParam);
      if control.fControlHWND = fResizeControl.fControlHwnd then
        fResizeControl.RecalcSize;
    end;

    else
      result := CallWindowProc (control.fOldWindowProc, control.fControlHWND, uMsg, wParam, lParam)
  end
end;

procedure TDialogEditor.SetDesignModeSelectedItemID(const Value: Integer);
begin
  if fSelectedItemID <> value then
  begin
    if fResizeControl <> Nil then
      fResizeControl.Free;

    if Value <> -1 then
    begin
      fResizeControl := TResizeControl.Create (owner);
      fResizeControl.DialogBox := self;
      fResizeControl.ControlID := value;

      if value = 0 then
        fResizeControl.ParentWindow := Handle
      else
        fResizeControl.ParentWindow := GetParent (fResizeControl.fControlHWND);

      FSelectedItemID := value;
      Invalidate
    end;

    if Assigned (OnDesignModeSelectedItemChange) and not (csDestroying in ComponentState) then
       OnDesignModeSelectedItemChange (self);
  end
end;

procedure TDialogEditor.SetDropComponent(const Value: TDropControl);
begin
  fDropComponent := Value;
  fDropping := True;
end;

procedure TDialogEditor.ShowDialog;
begin
  inherited;
  SubclassDialogControls
end;

function EnumChildProc (hWnd : HWND; lParam : LPARAM) : BOOL; stdcall;
begin
  result := TDialogEditor (lParam).EnumDialogControls (hWnd)
end;

procedure TDialogEditor.SubclassDialogControls;
begin
  if DialogHandle <> 0 then
    EnumChildWindows (DialogHandle, @EnumChildProc, LPARAM (self));
end;


{ TControlInfo }

constructor TControlInfo.Create(AOwner : TDialogEditor; AItemID: Integer; AControlHWND: HWND);
begin
  fOwner := AOWner;
  fItemID := AItemID;

  fControlHWnd := ACOntrolHWND;

  if fControlHWND <> AOwner.DialogHandle then
    fOldWindowProc := Pointer (SetWindowLong (fControlHWND, GWL_WNDPROC, Integer (@ControlWindowProc)));
end;

destructor TControlInfo.Destroy;
begin
  SetWindowLong (fControlHWND, GWL_WNDPROC, Integer (fOldWindowProc));
  inherited;
end;

function TControlInfo.GetExStyle: Integer;
begin
  if not fGotStyle then
  begin
    fStyle := GetWindowLong (fControlHWND, GWL_STYLE);
    fExStyle := GetWindowLong (fControlHWND, GWL_EXSTYLE);
    fGotStyle := True
  end;

  result := fExStyle
end;

function TControlInfo.GetStyle: Integer;
begin
  if not fGotStyle then
  begin
    fStyle := GetWindowLong (fControlHWND, GWL_STYLE);
    fExStyle := GetWindowLong (fControlHWND, GWL_EXSTYLE);
    fGotStyle := True
  end;

  result := fStyle
end;

function TControlInfo.GetWindowRect: TRect;
begin
  windows.GetWindowRect (fControlHWND, result);
  MapWindowPoints (HWND_DESKTOP, GetParent (fControlHWND), result, 2);
  result := fOwner.RectToDialogRect (result)
end;

procedure TControlInfo.SetWindowRect(const Value: TRect);
var
  r : TRect;
  r1, r2 : TRect;
begin
  r := WindowRect;
  if value.Left   <> -1 then r.left   := Value.Left;
  if value.Top    <> -1 then r.top    := Value.Top;
  if value.Right  <> -1 then r.right  := Value.Right;
  if value.Bottom <> -1 then r.bottom := Value.Bottom;

  r2 := r;
  r := fOwner.DialogRectToRect (r);
  r1 := fOwner.RectToDialogRect (r);
  if pint64 (@r1)^ <> pint64 (@r2)^ then
    MessageBeep ($ffff);
  SetWindowPos (fControlHWnd, 0, r.left, r.top, r.right - r.left, r.bottom - r.top, SWP_NOZORDER);
end;

function TControlInfo.WindowProc(uMsg: UINT; wParam: WPARAM;
  lParam: LPARAM): LRESULT;
begin
  result := fOwner.HandleControlMessage (self, uMsg, wParam, lParam);
end;

class function TControlInfo.GetClassName: PChar;
begin
  result := 'Custom';
end;

class function TControlInfo.GetDefaultStyle: DWORD;
begin
  result := 0;
end;

function TControlInfo.GetCtrlProperty(const name: string): variant;
var
  prop : TControlProperty;
  st : string;
begin
  prop := FindControlProperty (name);

  case prop of
    cpAcceptFiles : result := (GetEXStyle and WS_EX_ACCEPTFILES) <> 0;
    cpBorder      : result := (GetStyle and WS_BORDER) <> 0;
    cpClientEdge  : result := (GetEXStyle and WS_EX_CLIENTEDGE) <> 0;
    cpEnabled     : result := (GetStyle and WS_DISABLED) = 0;
    cpGroup       : result := (GetStyle and WS_GROUP) <> 0;
    cpHeight      : result := WindowRect.Bottom - WindowRect.Top;
    cpHelpID      : result := Integer (GetWindowContextHelpID (fControlHWND));
    cpLeft        : result := WindowRect.Left;
    cpStaticEdge  : result := (GetEXStyle and WS_EX_STATICEDGE) <> 0;
    cpTabStop     : result := (GetStyle and WS_TABSTOP) <> 0;
    cpText        :
      begin
        SetLength (st, 65536);
        GetWindowText (fControlHWND, PChar (st), 65536);
        st:= PChar (st);
        result := st;
      end;
    cpTop         : result := WindowRect.Top;
    cpVisible     : result := (GetStyle and WS_VISIBLE) <> 0;
    cpWidth       : result := WindowRect.Right - WindowRect.Left
  end
end;

procedure TControlInfo.SetCtrlProperty(const name: string; Value: variant);
var
  prop : TControlProperty;
  st : string;
  tp : TPropertyType;
begin
  prop := FindControlProperty (name);
  tp := ControlPropertyTypes [prop];

  if (varType (value) = varString) and (value = '') then
  case tp of
    ptBoolean : value := False;
    ptInteger : value := 0
  end;

  case prop of
    cpAcceptFiles : SetExStyle (WS_EX_ACCEPTFILES, Value = True);
    cpBorder      : SetStyle (WS_BORDER, Value = True);
    cpClientEdge  : SetExStyle (WS_EX_CLIENTEDGE, Value = True);
    cpEnabled     : SetStyle (WS_DISABLED, Value = False);
    cpGroup       : SetStyle (WS_GROUP, Value = True);
    cpHeight      : SetWindowRect (rect (-1, -1, -1, value + WindowRect.Top));
    cpHelpID      : SetWindowContextHelpId (fControlHWnd, Value);
    cpLeft        : SetWindowRect (rect (value, -1, -1, -1));
    cpStaticEdge  : SetExStyle (WS_EX_STATICEDGE, Value = True);
    cpTabStop     : SetStyle (WS_TABSTOP, Value = True);
    cpText        :
      begin
        st := Value;
        SetWindowText (fControlHWND, PChar (st));
      end;
    cpTop         : SetWindowRect (rect (-1, value, -1, -1));
    cpVisible     : SetStyle (WS_VISIBLE, Value = True);
    cpWidth       : SetWindowRect (rect (-1, -1, value + WindowRect.Left, -1));
  end

end;

function TControlInfo.FindControlProperty(
  const name: string): TControlProperty;
var
  i : Integer;
begin
  i := bsearch (ControlPropertyNames, name);
  if i = -1 then
    raise Exception.Create ('Property Not Found')
  else
    result := TControlProperty (i)
end;

procedure TControlInfo.SetExStyle (st : Integer; value : boolean);
var
  oldExStyle : Integer;
begin
  oldExStyle := GetEXStyle;
  if value then
  begin
    if oldExStyle <> oldExStyle or st then
    begin
      SetWindowLong (fControlHWnd, GWL_EXSTYLE, oldExStyle or st);
      InvalidateRect (GetParent (fControlHWND), Nil, True)
    end
  end
  else
  begin
    if oldExStyle <> oldExStyle and not st then
    begin
      SetWindowLong (fControlHWnd, GWL_EXSTYLE, oldExStyle and not st);
      InvalidateRect (GetParent (fControlHWND), Nil, True)
    end
  end
end;

procedure TControlInfo.SetStyle (st : Integer; value : boolean);
var
  oldStyle : Integer;
begin
  oldStyle := GetStyle;
  if value then
  begin
    if oldStyle <> oldstyle or st then
    begin
      SetWindowLong (fControlHWND, GWL_STYLE, oldStyle or st);
      if fOwner.fResizeControl.fControlHWND = fControlHWND then
        fOwner.fResizeControl.RecalcSize
    end
  end
  else
  begin
    if oldStyle <> oldstyle and not st then
    begin
      SetWindowLong (fControlHWnd, GWL_STYLE, oldStyle and not st);
      if fOwner.fResizeControl.fControlHWND = fControlHWND then
        fOwner.fResizeControl.RecalcSize
    end
  end
end;

function TControlInfo.GetCtrlPropertyCount: Integer;
var
  i : TControlProperty;
begin
  result := 0;
  for i := Low (TControlProperty) to High (TControlProperty) do
    if ControlPropertyNamesSupported [i] then
      Inc (result);
end;

function TControlInfo.GetCtrlPropertyName(idx: Integer): string;
var
  i : TControlProperty;
  found : boolean;
begin
  found := False;
  for i := Low (TControlProperty) to High (TControlProperty) do
    if ControlPropertyNamesSupported [i] then
      if idx = 0 then
      begin
        result := ControlPropertyNames [i];
        found := True;
        break
      end
      else
        Dec (idx);

  if not found then
    raise ERangeError.Create ('Index exceeds bounds');
end;

function TControlInfo.GetCtrlPropertyType(
  const name: string): TPropertyType;
var
  prop : TControlProperty;
begin
  prop := FindControlProperty (name);
  result := ControlPropertyTypes [prop];
end;

{ TResizeControl }

constructor TResizeControl.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csCaptureMouse, csClickEvents, csOpaque, csDoubleClicks];
  FSizerWidth := 5;
end;

procedure TResizeControl.CreateParams(var Params: TCreateParams);
var
  info : TControlInfo;
  r : TRect;

begin
  inherited;

  info := DialogBox.GetControlInfo (ControlID);

  r := info.WindowRect;
  r := DialogBox.DialogRectToRect (r);

  InflateRect (r, SizerWidth, SizerWidth);

  params.X := r.Left;
  params.Y := r.Top;
  params.Width := r.Right - r.Left;
  params.Height := r.Bottom - r.Top;
  params.Style := WS_VISIBLE or WS_CHILD;
  params.WindowClass.style := CS_VREDRAW + CS_HREDRAW + CS_DBLCLKS;
end;

procedure TResizeControl.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited;
  RecalcSize;
end;

procedure TResizeControl.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  fBasePt := point (x, y);

  // Keep BasePt in screen units
  MapWindowPoints (Handle, HWND_DESKTOP, fBasePt, 1);
  PtInSnib (point (x, y), fBaseSnib);
end;

procedure TResizeControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  r, br : TRect;
  deltaX, deltaY : Integer;
  r1, r2 : HRGN;
  sizeChanged : boolean;
  p : TPoint;
  adjX, adjY : Integer;
const
  inMouseMove : Integer = 0;

  procedure AdjustRect (var r : TRect);
  var
    r1 : TRect;
  begin
    r1 := r;
    case fBaseSnib of
      stLT : begin Inc (r.Left, deltaX); Inc (r.Top, DeltaY); end;
      stMT : Inc (r.Top, DeltaY);
      stRT : begin Inc (r.Right, deltaX); Inc (r.Top, DeltaY); end;
      stLM : Inc (r.Left, DeltaX);
      stRM : Inc (r.Right, DeltaX);
      stLB : begin Inc (r.Left, deltaX); Inc (r.Bottom, DeltaY); end;
      stMB : Inc (r.Bottom, DeltaY);
      stRB : begin Inc (r.Right, deltaX); Inc (r.Bottom, DeltaY); end;

      stFrame :
        begin
          Inc (r.Left, DeltaX);
          Inc (r.Right, DeltaX);
          Inc (r.Top, DeltaY);
          Inc (r.Bottom, DeltaY)
        end
    end;

    if ControlID = 0 then
    begin
      r.Left := r1.Left;
      r.Top := r1.Top
    end

  end;

begin
  if ssLeft in Shift then
  begin
    p := Point (x, y);
    MapWindowPoints (handle, HWND_DESKTOP, p, 1);

    DeltaX := p.x - fBasePt.x;
    DeltaY := p.y - fBasePt.y;

    GetWindowRect (handle, r);
    MapWindowPoints (HWND_DESKTOP, ParentWindow, r, 2);

    InvalidateRect (parentWindow, Nil, True);

    br := r;
    AdjustRect (r);   // BR & R in parent units...

    fBasePt := p;
    if (br.Top <> r.Top) or (br.Bottom <> r.Bottom) or (br.Right <> r.Right) or (br.Left <> r.Left)then
    begin
      sizeChanged := ((r.bottom - r.Top) <> (br.Bottom - br.Top)) or ((r.Left - r.Right) <> (br.Left - br.Right));

      MoveWindow (Handle, r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top, False);

      if sizeChanged then  // Redo mask...
      begin
        br := r;        // br in control units
        MapWindowPoints (ParentWindow, Handle, br, 2);

        r1 := CreateRectRgnIndirect (br);
        InflateRect (br, -SizerWidth, -SizerWidth);
        r2 := CreateRectRgnIndirect (br);

        CombineRgn (r1, r1, r2, RGN_DIFF);
        DeleteObject (r2);
        SetWindowRgn (Handle, r1, False);

        if ControlID = 0 then
        begin
          GetWindowRect (fControlHWND, r);
          adjX := (br.Right - br.Left) - (r.right - r.left);
          adjY := (br.Bottom - br.Top) - (r.bottom - r.top);
          if adjX > 0 then
            DialogBox.WidthAdjust := adjX
          else
            DialogBox.WidthAdjust := 0;

          if adjY > 0 then
            DialogBox.HeightAdjust := adjY
          else
            DialogBox.HeightAdjust := 0;

          DialogBox.AdjustSize
        end
      end;
      UpdateWindow (parentWindow)
    end
  end
end;

procedure TResizeControl.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  r : TRect;
begin
  inherited;

  if Button = mbLeft then
  begin
    GetWindowRect (handle, r);
    MapWindowPoints (HWND_DESKTOP, parentWindow, r, 2);
    InflateRect (r, -SizerWidth, -SizerWidth);

    if ControlID = 0 then
    begin
      SetWindowPos (fControlHwnd, 0, r.Left, r.top, r.Right - r.Left, r.Bottom - r.Top, SWP_NOZORDER);
      DialogBox.WidthAdjust := 0;
      DialogBox.HeightAdjust := 0;
      DialogBox.AdjustSize
    end
    else
    begin
      SetWindowPos (fControlHwnd, 0, r.Left, r.top, r.Right - r.Left, r.Bottom - r.Top, SWP_NOZORDER or SWP_NOREDRAW);
      InvalidateRect (parentWindow, Nil, True)
    end
  end
end;

procedure TResizeControl.PaintWindow(DC: HDC);
var
  r : TRect;
  w2, h2 : Integer;

  procedure DrawSnib (x, y : Integer);
  begin
    Rectangle (DC, x, y, x + SizerWidth, y + SizerWidth);
  end;

begin
  GetWindowRect (handle, r);
  MapWindowPoints (HWND_DESKTOP, Handle, r, 2);
  FillRect (DC, r, GetStockObject (GRAY_BRUSH));

  w2 := (ClientWidth - SizerWidth) div 2;
  h2 := (ClientHeight - SizerWidth) div 2;

  DrawSnib (r.Left, r.Top);
  DrawSnib (w2, r.Top);
  DrawSnib (r.Right - SizerWidth, r.Top);
  DrawSnib (r.Left, h2);
  DrawSnib (r.Right - SizerWidth, h2);
  DrawSnib (r.Left, ClientHeight - SizerWidth);
  DrawSnib (w2, ClientHeight - SizerWidth);
  DrawSnib (ClientWidth - SizerWidth, ClientHeight - SizerWidth);
end;

function TResizeControl.PtInSnib(pt: TPoint;
  var snibType: TSnibType): boolean;
var
  r, b, w2, h2 : Integer;
begin
  result := True;
  snibType := stFrame;

  r := ClientWidth - 1;
  b := ClientHeight - 1;
  w2 := (ClientWidth - SizerWidth) div 2;
  h2 := (ClientHeight - SizerWidth) div 2;

  if PtInRect (Rect (0, 0, r, SizerWidth), pt) then
  begin
    if pt.x <= sizerWidth then
      snibType := stLT
    else
      if pt.x >= ClientWidth - SizerWidth then
        snibType := stRT
      else
        if (pt.x >= w2) and (pt.x <= w2 + SizerWidth) then
          snibType := stMT
  end
  else
  if PtInRect (Rect (0, b - SizerWidth, r, b), pt) then
  begin
    if pt.x <= sizerWidth then
      snibType := stLB
    else
      if pt.x >= ClientWidth - SizerWidth then
        snibType := stRB
      else
        if (pt.x >= w2) and (pt.x <= w2 + SizerWidth) then
          snibType := stMB
  end
  else
    if PtInRect (Rect (0, h2, SizerWidth, h2 + SizerWidth), pt) then
      snibType := stLM
    else
      if PtInRect (Rect (r - sizerWidth, h2, r, h2 + SizerWidth), pt) then
        snibType := stRM
end;

procedure TResizeControl.RecalcSize;
var
  info : TControlInfo;
  r1, r2 : HRgn;
  r : TRect;
begin
  info := DialogBox.GetControlInfo (ControlID);

  r := info.WindowRect;
  MapDialogRect (DialogBox.DialogHandle, r);

  InflateRect (r, SizerWidth, SizerWidth);
  SetWindowPos (handle, 0, r.left, r.top, r.right - r.left, r.bottom - r.top, SWP_NOZORDER or SWP_NOREDRAW);

  MapWindowPoints (parentWindow, handle, r, 2);

  r1 := CreateRectRgnIndirect (r);
  InflateRect (r, -SizerWidth, -SizerWidth);
  r2 := CreateRectRgnIndirect (r);

  CombineRgn (r1, r1, r2, RGN_DIFF);
  DeleteObject (r2);
  SetWindowRgn (Handle, r1, False);
  InvalidateRect (parentWindow, Nil, True);
end;

procedure TResizeControl.SetControlID(const Value: Integer);
var
  info : TControlInfo;
begin
  fControlID := Value;
  info := fDialogBox.GetControlInfo (value);
  fControlHWND := info.fControlHWND

end;

procedure TResizeControl.SetSizerWidth(const Value: Integer);
begin
  if FSizerWidth <> value then
  begin
    FSizerWidth := Value;
    RecreateWnd
  end
end;

procedure TResizeControl.WmPaint(var msg: TWMPaint);
begin
  ControlState := ControlState + [csCustomPaint];
  inherited;
  ControlState := ControlState - [csCustomPaint];
end;


{ TDialogControlInfo }

class function TDialogControlInfo.GetClassName: PChar;
begin
  result := 'Dialog';
end;

{ TButtonControlInfo }

class function TButtonControlInfo.GetClassName: PChar;
begin
  result := PChar ($80);
end;

{ TStaticControlInfo }

class function TStaticControlInfo.GetClassName: PChar;
begin
  result := PChar ($82);
end;

class function TStaticControlInfo.GetDefaultStyle: DWORD;
begin
  result := inherited GetDefaultStyle or WS_GROUP;
end;

{ TEditControlInfo }

class function TEditControlInfo.GetClassName: PChar;
begin
  result := PChar ($81)
end;

class function TEditControlInfo.GetDefaultStyle: DWORD;
begin
  result := inherited GetDefaultStyle or ES_AUTOHSCROLL or WS_BORDER or WS_TABSTOP
end;

{ TPictureControlInfo }

class function TPictureControlInfo.GetDefaultStyle: DWORD;
begin
  result := (inherited GetDefaultStyle and not WS_GROUP) or SS_BITMAP;
end;

{ TGroupBoxControlInfo }

class function TGroupBoxControlInfo.GetDefaultStyle: DWORD;
begin
  result := inherited GetDefaultStyle or BS_GROUPBOX;
end;

{ TPushbuttonControlInfo }

class function TPushbuttonControlInfo.GetDefaultStyle: DWORD;
begin
  result := inherited GetDefaultStyle or WS_TABSTOP;
end;

{ TCheckboxControlInfo }

class function TCheckboxControlInfo.GetDefaultStyle: DWORD;
begin
  result := inherited GetDefaultStyle or (BS_AUTOCHECKBOX or WS_TABSTOP);
end;

end.
