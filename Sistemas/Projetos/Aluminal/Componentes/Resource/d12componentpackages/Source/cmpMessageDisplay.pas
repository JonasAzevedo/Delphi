(*======================================================================*
 | cmpMessageDisplay unit for MiscUnits                                 |
 |                                                                      |
 | Displays messages containing objects - eg. TStrings, TGraphic        |
 | TWinControl, etc.                                                    |
 |                                                                      |
 | The contents of this file are subject to the Mozilla Public License  |
 | Version 1.1 (the "License"); you may not use this file except in     |
 | compliance with the License. You may obtain a copy of the License    |
 | at http://www.mozilla.org/MPL/                                       |
 |                                                                      |
 | Software distributed under the License is distributed on an "AS IS"  |
 | basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See  |
 | the License for the specific language governing rights and           |
 | limitations under the License.                                       |
 |                                                                      |
 | Copyright � Colin Wilson 2002.  All Rights Reserved                  |
 |                                                                      |
 | Version  Date        By    Description                               |
 | -------  ----------  ----  ------------------------------------------|
 | 1.0      09/04/2002  CPWW  Original                                  |
 *======================================================================*)

unit cmpMessageDisplay;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms, Contnrs, Math, StrUtils, StdActns, ShellAPI, Dialogs;

type
  TMessageDisplay = class;

//----------------------------------------------------------------------------
// TDisplayObjectLink - base class for links to displayable objects
  TDisplayObjectLink = class
  private
    fOwner : TMessageDisplay;
    fColor: TColor;
    fFont: TFont;
    fMessagePart : TObject;
    fCodePage: Integer;
    fPercentDecoded: Integer;
    fPageRect: TRect;
    procedure SetColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
  protected
    fObj : TObject;
    yPos : Integer;
    class function DisplaysObject (obj : TObject) : Boolean; virtual; abstract;

    procedure Display (const r : TRect; var y : Integer); virtual; abstract;
    function GetCursor : TCursor; virtual;
    function GetHeight : Integer; virtual; abstract;
    function GetWidth: Integer; virtual; abstract;
    function GetMargin: Integer; virtual;
    procedure SetCursor(const Value: TCursor); virtual;
    procedure SetHeight(const Value: Integer); virtual;
    procedure SetWidth(const Value: Integer); virtual;
    procedure Refresh; virtual;
    function GetObj : TObject; virtual;
    function GetBusy : Boolean ; virtual;
    procedure SetObj(const Value: TObject); virtual;
    function CursorAt (x, y : Integer) : TCursor; virtual;
    procedure KeyPress (var ch : char); virtual;
    function FindText (const SearchStr: string; NewSearch : Boolean; Options: TStringSearchOptions; y : Integer): Boolean; virtual;
    procedure GetSelectedText (var txt : WideString); virtual;
    procedure SetSelectedText (const txt : WideString); virtual;
    function GetSelLength : Integer; virtual;
    procedure GetText (var txt : WideString); virtual;
    procedure GetHTML (var txt : string; rawFragment : boolean = false); virtual;
    function GetHasText: boolean; virtual;
    procedure PageDown; virtual;
    constructor Create (AOwner : TMessageDisplay; AObj : TObject; codePage : Integer); virtual;
  public
    destructor Destroy; override;
    procedure Stop; virtual;
    procedure Print; virtual;
    property PageRect : TRect read fPageRect write fPageRect;
    property Owner : TMessageDisplay read fOwner;
    property Height : Integer read GetHeight write SetHeight;
    property Margin : Integer read GetMargin;
    property Width : Integer read GetWidth write SetWidth;
    property Obj : TObject read GetObj write SetObj;
    property MessagePart : TObject read fMessagePart write fMessagePart;
    property Busy : boolean read GetBusy;
    property Cursor : TCursor read GetCursor write SetCursor;
    property Font : TFont read fFont write SetFont;
    property Color : TColor read fColor write SetColor;
    property CodePage : Integer read fCodePage write fCodePage;
    property HasText : boolean read GetHasText;
    property PercentDecoded : Integer read fPercentDecoded write fPercentDecoded;
  end;
  TDisplayObjectLinkClass = class of TDisplayObjectLink;

//----------------------------------------------------------------------------
// TPictureDisplayObjectLink - base class for image-style links to displayable
// objects
  TPictureDisplayObjectLink = class (TDisplayObjectLink)
  protected
    function GetMargin: Integer; override;
  end;

//----------------------------------------------------------------------------
// TGraphicDisplayObjectLink - Displays 'TGraphics' based objects
  TGraphicDisplayObjectLink = class (TPictureDisplayObjectLink)
  private
    function GetGraphic: TGraphic;
    function AutoFitHeight : Integer;
    function AutoFitWidth : Integer;
    function AutoFitRect : TRect;
  private
    fWidth : Integer;
    fHeight : Integer;
  protected
    class function DisplaysObject (obj : TObject) : Boolean; override;
    procedure Display (const r : TRect; var y : Integer); override;
    function GetHeight : Integer; override;
    function GetWidth : Integer; override;
    procedure Refresh; override;
    procedure SetObj(const Value: TObject); override;
    property Graphic : TGraphic read GetGraphic;
  public
    constructor Create (AOwner : TMessageDisplay; AObj : TObject; codepage : Integer); override;
    procedure Print; override;
  end;

  TXFaceDisplayObjectLink = class (TGraphicDisplayObjectLink)
  public
    procedure Print; override;
  end;

//----------------------------------------------------------------------------
// TSWinControlObjectLink - Displays 'TWinControl' based objects
  TWinControlObjectLink = class (TPictureDisplayObjectLink)
  private
    function GetCtrl: TWinControl;
  protected
    class function DisplaysObject (obj : TObject) : Boolean; override;
    procedure Display (const r : TRect; var y : Integer); override;
    function GetCursor : TCursor; override;
    function GetHeight : Integer; override;
    function GetWidth : Integer; override;
    procedure SetCursor(const Value: TCursor); override;
    procedure SetHeight(const Value: Integer); override;
    procedure SetWidth(const Value: Integer); override;
    property Ctrl : TWinControl read GetCtrl;
    procedure PageDown; override;
  public
    constructor Create (AOwner : TMessageDisplay; AObj : TObject; codepage : Integer); override;
  end;

  TURLNotifyEvent = procedure (Sender : TObject; Button: TMouseButton; Shift: TShiftState; const url : WideString) of object;

//----------------------------------------------------------------------------
// TMessageDisplay component
  TMessageDisplay = class(TCustomControl)
  private
    FBorder: TBorderStyle;
    fLineHeight : Integer;
    fObjects : TObjectList;
    fFocusedObject: Integer;
    fTextIndent: Integer;
    fPictureIndent: Integer;
    fNewsAttributes: Boolean;
    fUpdateCount : Integer;
    fOnURLClick: TURLNotifyEvent;
    fOnURLDblClick: TURLNotifyEvent;
    fReadOnly: boolean;
    fRawMode: boolean;
    fCreateWindowSizeW: Integer;
    fCreateWindowSizeH: Integer;
    fSearchY : Integer;
    fSubject: string;
    fAutoFit: boolean;
    procedure SetAutoFit(const Value: boolean);

    procedure SetBorder(const Value: TBorderStyle);
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;

    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMMouseWheel (var Message : TWMMouseWheel); message WM_MOUSEWHEEL;

    function GetMessageHeight: Integer;
    function GetMessageWidth: Integer;
    function GetObjectCount : Integer;
    function GetObjects (idx : Integer) : TDisplayObjectLink;
    procedure SetPictureIndent(const Value: Integer);
    procedure SetTextIndent(const Value: Integer);
    procedure SetFocusedObject(const Value: Integer);
    function GetUpdating: boolean;
    function GetHasSelection: boolean;
    procedure SetRawMode(const Value: boolean);
    function GetText: WideString;
    function GetSelLength: Integer;
    function GetFocusedTextObject: TDisplayObjectLink;
  protected
    //    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Paint; override;
    procedure MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure AdjustSize; override;
    property FocusedTextObject : TDisplayObjectLink read GetFocusedTextObject;
  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure FocusObject (obj : TObject);
    function AddObject (obj : TObject; codepage : Integer) : TDisplayObjectLink;
    function FindText (const SearchStr: string; NewSearch : Boolean; Options: TStringSearchOptions): Boolean;
    function GetObjectLinkClass (obj : TObject; XFace : boolean) : TDisplayObjectLinkClass;
    function InsertObject (idx : Integer; obj : TObject;  codepage : Integer; tp : TDisplayObjectLinkClass = Nil) : TDisplayObjectLink;
    function ObjectAt (x, y : Integer) : Integer;
    procedure RecalcBounds;
    procedure Refresh (objIdx : Integer = -1);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    property IsUpdating : boolean read GetUpdating;
    procedure CopyToClipboard;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function GetSelectedText(var txt: WideString): boolean;
    procedure SetSelectedText (const st : WideString);
    procedure PageDown;
    function GetHTML (rawFragment : boolean = false): string;

    procedure Print;
    function GetPageCount (dc : HDC) : Integer;

    function TextWidth (const st : string) : Integer;
    function UpdateAction (Action : TBasicAction) : Boolean; override;

    property HasSelection : boolean read GetHasSelection;
    property FocusedObject : Integer read fFocusedObject write SetFocusedObject;

    property Objects [idx : Integer] : TDisplayObjectLink read GetObjects;
    property ObjectCount : Integer read GetObjectCount;

    property MessageHeight : Integer read GetMessageHeight;
    property MessageWidth : Integer read GetMessageWidth;
    property LineHeight : Integer read fLineHeight;
    property Canvas;

    property CreateWindowSizeW : Integer read fCreateWindowSizeW write fCreateWindowSizeW;
    property CreateWindowSizeH : Integer read fCreateWindowSizeH write fCreateWindowSizeH;
    property Text : WideString read GetText;
    property SelLength : Integer read GetSelLength;
    property Subject : string read fSubject write fSubject;
  published
    property Align;
    property AutoFit : boolean read fAutoFit write SetAutoFit default True;
    property Border: TBorderStyle read FBorder write SetBorder;
    property Color default clWhite;
    property Ctl3D;
    property Font;
    property NewsAttributes : Boolean read fNewsAttributes write fNewsAttributes;
    property PictureIndent : Integer read fPictureIndent write SetPictureIndent;
    property RawMode : boolean read fRawMode write SetRawMode;
    property ReadOnly : boolean read fReadOnly write fReadOnly default True;
    property TextIndent : Integer read fTextIndent write SetTextIndent;
    property TabOrder;
    property TabStop;

    property OnURLClick : TURLNotifyEvent read fOnURLClick write fOnURLClick;
    property OnURLDblClick : TURLNotifyEvent read fOnURLDblClick write fOnURLDblClick;
    property OnDblClick;
  end;

var
  gNoHTML : boolean = False;

procedure RegisterDisplayObjectLink (dispObj : TDisplayObjectLinkClass; Position : Integer = -1);

implementation

uses ClipBrd, unitCharsetMap, Printers, unitHTMLStringsDisplayObject;

//----------------------------------------------------------------------------
// Keep details of registered display objects

var
  fRegisteredLinks : array of TDisplayObjectLinkClass;
  fRegisteredLinkCount : Integer = 0;
  fRegisteredLinkSize : Integer = 0;

resourcestring
  rstCantSetCursor = 'Can''t set cursor for this object';
  rstCantSetHeight = 'Can''t set height of this object';
  rstCantSetWidth = 'Can''t set width of this object';
  rstCantSetObj   = 'Can''t set Obj for this object';

(*----------------------------------------------------------------------*
 | procedure RegisterDisplayObjectLink                                  |
 |                                                                      |
 | Register a display object link class that supports a particular      |
 | object                                                               |
 |                                                                      |
 | Parameters:                                                          |
 |   dispObj : TDisplayObjectLinkClass  The class to register           |
 *----------------------------------------------------------------------*)
procedure RegisterDisplayObjectLink (dispObj : TDisplayObjectLinkClass; Position : Integer);
var
  i : Integer;
begin
  i := 0;
  while i < fRegisteredLinkCount do
    if dispObj = fRegisteredLinks [i] then
      break
    else
      Inc (i);

  if i >= fRegisteredLinkSize then
  begin
    Inc (fRegisteredLinkSize, 5);
    SetLength (fRegisteredLinks, fRegisteredLinkSize)
  end;

  if i >= fRegisteredLinkCount then
  begin
    Inc (fRegisteredLinkCount);


    if Position = -1 then
      fRegisteredLinks [i] := dispObj
    else
    begin
      for i := fRegisteredLinkCount - 1 downto Position + 1 do
        fRegisteredLinks [i] := fRegisteredLinks [i - 1];
      fRegisteredLinks [Position] := dispObj
    end
  end
  else
    fRegisteredLinks [i] := dispObj
end;

{ TMessageDisplay }

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.AddObject                                  |
 |                                                                      |
 | Add an object to the message display.  It will be displayed as long  |
 | as there is a registered TDisplayObjectLink class that supports      |
 | the object.                                                          |
 |                                                                      |
 | Parameters:                                                          |
 |   obj: TObject               The object to add                       |
 *----------------------------------------------------------------------*)
function TMessageDisplay.AddObject(obj: TObject;  codepage : Integer) : TDisplayObjectLink;
var
  i : Integer;
begin
  Result := nil;
  i := fRegisteredLinkCount - 1;
  while i >= 0 do
    if fRegisteredLinks [i].DisplaysObject(obj) then
    begin
      Result := fRegisteredLinks [i].Create(Self, obj, codepage);
      fObjects.Add(result);
      RecalcBounds;
      break
    end
    else
      Dec (i);

  if fFocusedObject = -1 then
    fFocusedObject := 0;
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.BeginUpdate                                |
 |                                                                      |
 | Start updating - delays RecalcBounds until EndUpdate                 |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.AdjustSize;
begin
  if not (csLoading in ComponentState) and (fUpdateCount = 0) then
  begin
    SetBounds(Left, Top, Width, Height);
    RequestAlign
  end
end;

procedure TMessageDisplay.BeginUpdate;
begin
  Inc (fUpdateCount);
end;

(*----------------------------------------------------------------------*
 | function TMessageDisplay.CanAutoSize                                 |
 |                                                                      |
 | Support auto-size so it works in (eg) a scroll box.                  |
 *----------------------------------------------------------------------*)
(*
function TMessageDisplay.CanAutoSize(var NewWidth,
  NewHeight: Integer): Boolean;
begin
  Result := True;
  if not (csDesigning in ComponentState) or (MessageWidth > 0) and
    (MessageHeight > 0) then
  begin
    if Align in [alNone, alLeft, alRight] then
      NewWidth := MessageWidth;
    if Align in [alNone, alTop, alBottom] then
      NewHeight := MessageHeight;
  end
end;
*)

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.Clear                                      |
 |                                                                      |
 | Clear the message display                                            |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.Clear;
var
  i : Integer;
  busy : boolean;
  n : Integer;
begin
  try
    for i := 0 to fObjects.Count - 1 do
      TDisplayObjectLink (fObjects [i]).Stop;

    n := 500;
    repeat
      busy := False;
      for i := 0 to fObjects.Count - 1 do
        if TDisplayObjectLink (fObjects [i]).Busy then
        begin
          Sleep (10);
          busy := True;
          break
        end;
      Dec (n)
    until (n <= 0) or not busy;

    if busy then
      Windows.Beep (440, 100);
  except
  end;

  fFocusedObject := -1;
  fObjects.Clear;
  RecalcBounds;
  InvalidateRect (Handle, Nil, True);
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.CMColorChanged                             |
 |                                                                      |
 | Respond to CMColorChanged messages                                   |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if Canvas <> nil then Canvas.Brush.Color := Color;
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.CMCtl3DChanged                             |
 |                                                                      |
 | Respond to CMCtl3DChanged messages                                   |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (Border = bsSingle) then RecreateWnd;
  inherited;
end;

(*----------------------------------------------------------------------*
 | TMessageDisplay.CMFontChanged                                        |
 |                                                                      |
 | Respond to CMFontChanged messages                                    |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font := Self.Font;
  fLineHeight := Canvas.TextHeight('M');
  InvalidateRect (Handle, Nil, True);
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.CopyToClipboard                            |
 |                                                                      |
 | Copy the selected text to the clipboard                              |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.CopyToClipboard;
var
  t : TStrings;
  s : WideString;
begin
  t := TStringList.Create;
  try
    GetSelectedText (s);
    Clipboard.AsText := s
  finally
    t.Free
  end
end;

(*----------------------------------------------------------------------*
 | constructor TMessageDisplay.Create                                   |
 |                                                                      |
 | Constructor for TMessageDisplay                                      |
 |                                                                      |
 | Parameters:                                                          |
 |   AOwner: TComponent                                                 |
 *----------------------------------------------------------------------*)
constructor TMessageDisplay.Create(AOwner: TComponent);
begin
  fCreateWindowSizeW := 1024*1024*1024;
  fCreateWindowSizeH := 1024*1024*1024;
  inherited;

//  DoubleBuffered := True;      Don't double buffer if you can avoid it -
//                               Painting is much more efficient if you
//                               don't in this case.

  Width := 185;
  Height := 41;
  fAutoFit := True;

  fReadOnly := True;
  ControlStyle := [csFramed, csCaptureMouse, csClickEvents, csDoubleClicks, csReflector, csOpaque];
  TabStop := True;

  fObjects := TObjectList.Create;
  fFocusedObject := -1
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.CreateParams                               |
 |                                                                      |
 | Override CreateParams to set up the border.                          |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if not (csDesigning in ComponentState) then
  begin
    params.Width := fCreateWindowSizeW;
    params.Height := fCreateWindowSizeH;
  end;

  with Params do
  begin
    if FBorder = bsSingle then
      Style := Style or WS_BORDER;
  end
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.CreateWnd                                  |
 |                                                                      |
 | Override CreateWnd to initialize the control                         |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.CreateWnd;
begin
  inherited;

  if Handle = 0 then
    ShowMessage (Format ('Could not create a %dx%d window.  Unable to display messages.', [fCreateWindowSizeW, fCreateWindowSizeH]));

  Canvas.Font := Self.Font;
  RecalcBounds;         // Will be required if RecreateWnd was called
end;

(*----------------------------------------------------------------------*
 | destructor TMessageDisplay.Destroy                                   |
 |                                                                      |
 | Destructor for TMessageDisplay                                       |
 *----------------------------------------------------------------------*)
destructor TMessageDisplay.Destroy;
begin
  fObjects.Free;

  inherited;
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.EndUpdate                                  |
 |                                                                      |
 | End updating, and perform delayed RecalcBounds                       |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.EndUpdate;
var
  i, y, h : Integer;
  obj : TDisplayObjectLink;

begin
  if fUpdateCount = 1 then
  begin
    y := 0;

    for i := 0 to ObjectCount - 1 do
    begin
      obj := Objects [i];
      h := obj.Height;

      if obj is TWinControlObjectLink then
      begin
        TWinControlObjectLink (obj).Ctrl.Top := y;
        obj.Height := h
      end;

      Inc (y, h)
    end
  end;
  Dec (fUpdateCount);
  if fUpdateCount <= 0 then
  begin
    fUpdateCount := 0;
    RecalcBounds
  end
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.FindText                                   |
 |                                                                      |
 | Search for text                                                      |
 |                                                                      |
 | Parameters:                                                          |
 |   const SearchStr: string;                                           |
 |   NewSearch: Boolean;                                                |
 |   Options: TStringSearchOptions                                      |
 |                                                                      |
 | The function returns 'True' if the text was found                    |
 *----------------------------------------------------------------------*)
function TMessageDisplay.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action);

  if not Result then
  begin
    Result := Action is TEditCopy;
    if Result then
    begin
      CopyToClipboard;
      Exit
    end;

    Result := Action is TEditSelectAll;
    if Result then
    begin
      Invalidate;
      Exit
    end
  end
end;

(*----------------------------------------------------------------------*
 | function TMessageDisplay.FindText                                    |
 |                                                                      |
 | Search for a string.  Select it if it's found.                       |
 |                                                                      |
 | Parameters:                                                          |
 |   const SearchStr: string;           // The string to search for     |
 |   NewSearch: Boolean;                // Start search from the        |
 |                                      // beginning.  Otherwise start  |
 |                                      // from the current position    |
 |    Options: TStringSearchOptions     // Search options               |
 |                                                                      |
 | The function returns True if the string was found                    |
 *----------------------------------------------------------------------*)
function TMessageDisplay.FindText(const SearchStr: string;
  NewSearch: Boolean; Options: TStringSearchOptions): Boolean;
var
  obj : TDisplayObjectLink;

  y, c : Integer;
begin
  Result := False;
  if NewSearch then   // Nothing was found last time - start again at the beginning
  begin
    fSearchY := 0;
    c := 0
  end
  else
    c := FocusedObject;

  y := fSearchY;

  while (c >= 0) and (c < ObjectCount) do
  begin
    obj := Objects [c];

    result := obj.FindText (SearchStr, NewSearch, Options, y);
    if result then Exit;

    NewSearch := True;
    if soDown in Options then
      Inc (c)
    else
      Dec (c);

    fSearchY := 0;
  end
end;

procedure TMessageDisplay.FocusObject(obj: TObject);
begin
  FocusedObject := fObjects.IndexOf(obj);
end;

function TMessageDisplay.GetFocusedTextObject: TDisplayObjectLink;
var
  n : Integer;
begin
  result := nil;
  n := fFocusedObject;

  if n >= 0 then
  begin
    while (n < ObjectCount) and not Objects [n].HasText do
      Inc (n);

    if n < ObjectCount then
      result := Objects [n];
  end
end;

function TMessageDisplay.GetHasSelection: boolean;
begin
  result := SelLength > 0
end;

function TMessageDisplay.GetHTML (rawFragment : boolean = false): string;
var
  d : TDisplayObjectLink;
begin
  d := GetFocusedTextObject;
  if Assigned (d) then
    d.GetHTML (result, rawFragment)
  else
    result := ''
end;

function TMessageDisplay.GetMessageHeight: Integer;
var
  i : Integer;
  obj : TDisplayObjectLink;
begin
  Result := 0;
  for i := 0 to ObjectCount - 1 do
  begin
    obj := Objects [i];
    Inc (Result, obj.Height)
  end
end;

(*----------------------------------------------------------------------*
 | function TMessageDisplay.GetMessageWidth                             |
 |                                                                      |
 | 'Get' method for MessageWidth - return the widest point in the       |
 | message.                                                             |
 *----------------------------------------------------------------------*)
function TMessageDisplay.GetMessageWidth: Integer;
var
  i, w : Integer;
  obj : TDisplayObjectLink;
begin
  Result := 0;
  for i := 0 to ObjectCount - 1 do
  begin
    obj := Objects [i];
    w := obj.Width + obj.Margin;
    if w > Result then
      Result := w
  end
end;

(*----------------------------------------------------------------------*
 | function TMessageDisplay.GetObjectCount                              |
 |                                                                      |
 | 'Get' method for ObjectCount                                         |
 *----------------------------------------------------------------------*)
function TMessageDisplay.GetObjectCount: Integer;
begin
  if Assigned (fObjects) then
    Result := fObjects.Count
  else
    result := 0
end;

(*----------------------------------------------------------------------*
 | function TMessageDisplay.GetObjects                                  |
 |                                                                      |
 | 'Get' method for Objects property                                    |
 *----------------------------------------------------------------------*)
function TMessageDisplay.GetObjectLinkClass(
  obj: TObject; XFace : boolean): TDisplayObjectLinkClass;
var
  i : Integer;
begin
  result := Nil;
  i := fRegisteredLinkCount - 1;
  while i >= 0 do
    if fRegisteredLinks [i].DisplaysObject(obj) then
    begin
      result := fRegisteredLinks [i];
      if gNoHTML and (result = THTMLStringsDisplayObjectLink) then
      begin
        Dec (i);
        continue
      end;

      if (result = TGraphicDisplayObjectLink) and XFace then
        result := TXFaceDisplayObjectLink;
      break
    end
    else
      Dec (i);
end;

function TMessageDisplay.GetObjects(idx: Integer): TDisplayObjectLink;
begin
  Result := TDisplayObjectLink (fObjects [idx])
end;

(*----------------------------------------------------------------------*
 | function TMessageDisplay.GetSelectedText                             |
 |                                                                      |
 | Return the selected text                                             |
 |                                                                      |
 | Parameters:                                                          |
 |   txt: TStrings              Returns the selected text               |
 |                                                                      |
 | The function returns true if some text was selected                  |
 *----------------------------------------------------------------------*)

function TMessageDisplay.GetPageCount(dc: HDC): Integer;
begin
  result := 1
end;

function TMessageDisplay.GetSelectedText(var txt : WideString): boolean;
var
  d : TDisplayObjectLink;
begin
  d := GetFocusedTextObject;
  if Assigned (d) then
  begin
    d.GetSelectedText(txt);
    result := txt <> ''
  end
  else
    result := False
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.GetUpdating                                |
 |                                                                      |
 | Get method for IsUpdating property.  Returns true if we're in the    |
 | Parse phase.                                                         |
 |                                                                      |
 | The function returns true if the component is updating               |
 *----------------------------------------------------------------------*)
function TMessageDisplay.GetSelLength: Integer;
var
  d : TDisplayObjectLink;
begin
  d := FocusedTextObject;
  if Assigned (d) then
    result := d.GetSelLength
  else
    result := 0
end;

function TMessageDisplay.GetText: WideString;
var
  d : TDisplayObjectLink;
begin
  d := GetFocusedTextObject;
  if Assigned (d) then
    d.GetText (result)
  else
    result := ''
end;

function TMessageDisplay.GetUpdating: boolean;
begin
  result := fUpdateCount > 0
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.InsertObject                               |
 |                                                                      |
 | Insert an object in the display                                      |
 |                                                                      |
 | Parameters:                                                          |
 |   idx : Integer;             Where to insert the object              |
 |   obj: TObject               The objetc to insert                    |
 |                                                                      |
 | The function returns the link to the inserted object                 |
 *----------------------------------------------------------------------*)

function TMessageDisplay.InsertObject(idx : Integer; obj: TObject; codepage : Integer; tp : TDisplayObjectLinkClass): TDisplayObjectLink;
begin
  Result := nil;

  if not Assigned (tp) then
    tp := GetObjectLinkClass (obj, False);

  if Assigned (tp) then
  begin
    Result := tp.Create(Self, obj, codepage);
    fObjects.Insert(idx, result);
    RecalcBounds;
    if fFocusedObject = -1 then
      fFocusedObject := 0;
  end
end;
(*----------------------------------------------------------------------*
 | function TMessageDisplay.ObjectAt                                    |
 |                                                                      |
 | Return the index of the object at the selected position              |
 |                                                                      |
 | Parameters:                                                          |
 |   x, y: Integer                                                      |
 |                                                                      |
 | The function returns the index of the object                         |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  FocusedObject := ObjectAt (x, y);
end;

function TMessageDisplay.ObjectAt(x, y: Integer): Integer;
var
  i, h : Integer;
begin
  Result := -1;

  for i := 0 to ObjectCount - 1 do
  begin
    h := Objects [i].Height;
    if y < h then
    begin
      Result := i;
      exit
    end
    else
      Dec (y, h)
  end
end;

(*----------------------------------------------------------------------*
 | proceudre TMessageDisplay.Paint                                      |
 |                                                                      |
 | Paint the control                                                    |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.PageDown;
var
  obj : TDisplayObjectLink;
begin
  if FocusedObject <> -1 then
  begin
    obj := Objects [FocusedObject];
    obj.PageDown
  end

end;

procedure TMessageDisplay.Paint;
var
  y, oc : Integer;
  obj : TDisplayObjectLink;
  objNo : Integer;
  r : TRect;

begin
  if IsUpdating then Exit;

  objNo := 0;

  GetClipBox (Canvas.Handle, r);

  y := 0;

  oc := ObjectCount;
  while objNo < oc do
  begin
    obj := Objects [objNo];
    obj.yPos := y;

    obj.Display (r, y);               // Display the object
    if y > r.Bottom then
    begin
    end;

    Inc (objNo)
  end;

  inherited Paint
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.RecalcBounds                               |
 |                                                                      |
 | Recalculate the bounds so that it includes all the display oblects   |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.Print;
var
  i, LogX, LogY : Integer;
  PageRect : TRect;
  hadXFace : boolean;

begin
  LogX := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
  LogY := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
  pageRect := rect (0, 0, Printer.PageWidth, Printer.PageHeight);
  InflateRect (pageRect, -LogX div 2, -LogY div 2);
  hadXFace := False;

  printer.Title := Subject;
  printer.BeginDoc;
  try
    for i := 0 to ObjectCount - 1 do
    begin
      pageRect := rect (0, 0, Printer.PageWidth, Printer.PageHeight);
      InflateRect (pageRect, -LogX div 2, -LogY div 2);
      Objects [i].PageRect := PageRect;
      Objects [i].Print;
      if hadXFace then;

      if Objects [i] is TXFaceDisplayObjectLink then
        hadXFace := True
      else
      begin
        hadXFace := False;
        if i < ObjectCount - 1 then
          printer.NewPage
      end
    end
  finally
    printer.EndDoc
  end
end;

procedure TMessageDisplay.RecalcBounds;
begin
  if fUpdateCount > 0 then
    Exit;
  fLineHeight := Canvas.TextHeight('M');
  SetBounds(Left, Top, MessageWidth, MessageHeight);
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.Refresh                                    |
 |                                                                      |
 | Refresh the object with index objIdx.  objIdx defaults to -1 - in    |
 | which case refresh all objects                                       |
 |                                                                      |
 | Parameters:                                                          |
 |   objIdx: Integer            Index of the object to refresh          |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.Refresh(objIdx: Integer);
var
  i : Integer;
begin
  BeginUpdate;
  try
    if objIdx = -1 then
      for i := 0 to ObjectCount - 1 do
        Objects [i].Refresh
    else
      Objects [objIdx].Refresh;
  finally
    EndUpdate
  end
end;

(*----------------------------------------------------------------------*
 | proceudre TMessageDisplay.SetBorder                                  |
 |                                                                      |
 | 'Set' method for Border Style property                               |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.SetAutoFit(const Value: boolean);
begin
  if fAutoFit <> Value then
  begin
    fAutoFit := Value;
    RecreateWnd
  end
end;

procedure TMessageDisplay.SetBorder(const Value: TBorderStyle);
begin
  if Value <> FBorder then
  begin
    FBorder := Value;
    RecreateWnd
  end;
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.SetCaretPos                                |
 |                                                                      |
 | Set the caret position.  Adjust it if necessary (eg. so it's on an   |
 | exact line).                                                         |
 |                                                                      |
 | Parameters:                                                          |
 |   selToo : boolean = False                                           |
 |   repaint : boolean = False                                          |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  sb : TScrollingWinControl;
begin
  if (csDesigning in ComponentState) then
    inherited
  else
  begin
    if Assigned (parent) then
    begin
      if parent is TScrollingWinControl then
      begin
        sb := TScrollingWinControl (parent);

        if (MessageWidth <> sb.HorzScrollBar.Range) or (MessageHeight <> sb.VertScrollBar.Range) then
        begin
          sb.HorzScrollBar.Range := MessageWidth;
          sb.VertScrollBar.Range := MessageHeight
        end
      end;
    end
  end
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.SetFocusedObject                           |
 |                                                                      |
 | 'Set' method for FocusedObject property.                             |
 |                                                                      |
 | Parameters:                                                          |
 |   const Value: Integer                                               |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.SetFocusedObject(const Value: Integer);
begin
  if Value <> fFocusedObject then
  begin
    fFocusedObject := Value;
    fSearchY := 0;
    Invalidate
  end
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.SetPictureIndent                           |
 |                                                                      |
 | 'Set' method for PictureIndent property                              |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.SetPictureIndent(const Value: Integer);
begin
  if value <> fPictureIndent then
  begin
    fPictureIndent := Value;
    Invalidate
  end
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.SetSelPos                                  |
 |                                                                      |
 | Set the sel start position.  Make sure it's valid.                   |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.SetRawMode(const Value: boolean);
begin
  if fRawMode <> value then
  begin
    fRawMode := Value;
    Refresh;
    Invalidate
  end
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.SetTextIndent                              |
 |                                                                      |
 | 'Set' method for TextIndent property                                 |
 *----------------------------------------------------------------------*)
procedure TMessageDisplay.SetSelectedText(const st: WideString);
var
  d : TDisplayObjectLink;
begin
  d := GetFocusedTextObject;
  if Assigned (d) then
    d.SetSelectedText (st)
end;

procedure TMessageDisplay.SetTextIndent(const Value: Integer);
begin
  if fTextIndent <> Value then
  begin
    fTextIndent := Value;
    Invalidate
  end
end;

(*----------------------------------------------------------------------*
 | function TMessageDisplay.TextWidth                                   |
 |                                                                      |
 | Return the width of some text - taking into acount tabs, etc.        |
 *----------------------------------------------------------------------*)
function TMessageDisplay.TextWidth(const st: string): Integer;
var
  r : TRect;
begin
  if st = '' then
    Result := 0
  else
  begin
    r := rect (0, 0, MaxInt, LineHeight);
    DrawText (Canvas.Handle, PChar (st), Length (st), r, DT_CALCRECT or DT_NOPREFIX or DT_EXPANDTABS);
    Result := r.Right - r.Left
  end
end;

(*----------------------------------------------------------------------*
 | function TMessageDisplay.UpdateAction                                |
 |                                                                      |
 | Enables/disables standard actions for the control - like edit/copy   |
 | etc.                                                                 |
 |                                                                      |
 | Parameters:                                                          |
 |   Action: TBasicAction                                               |
 |                                                                      |
 | The function returns true if the action is allowed.                  |
 *----------------------------------------------------------------------*)
function TMessageDisplay.UpdateAction(Action: TBasicAction): Boolean;
begin
  if Action is TEditCopy then
   Result := True
  else
    if Action is TEditSelectAll then
      Result := True
    else
      Result := inherited UpdateAction (Action)
end;

(*----------------------------------------------------------------------*
 | procedure TMessageDisplay.WMGetDlgCode                               |
 |                                                                      |
 | Message handler for WM_GETDLGCODE.  Indicate that we want arrow keys |
 |                                                                      |
 | Parameters:                                                          |
 |   var Message: TWMGetDlgCode                                         |
 *----------------------------------------------------------------------*)

procedure TMessageDisplay.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
  if not ReadOnly then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

{ TDisplayObjectLink }

(*----------------------------------------------------------------------*
 | constructor TDisplayObjectLink.Create                                |
 |                                                                      |
 | Constructor for TDisplayObjectLink base class                        |
 *----------------------------------------------------------------------*)
constructor TDisplayObjectLink.Create(AOwner : TMessageDisplay; AObj: TObject; codePage : Integer);
begin
  fOwner := AOwner;
  yPos := Owner.MessageHeight;
  fObj := AObj;
  fFont := TFont.Create;
  fFont.Assign(AOwner.Font);
  fCodePage := codePage;
  fFont.Charset := CodePageToCharset (codepage);
  fColor := AOwner.Color;
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.CursorAt                                |
 |                                                                      |
 | Stub function.  Return the TMessageDisplay's cursor                  |
 *----------------------------------------------------------------------*)
function TDisplayObjectLink.CursorAt(x, y: Integer): TCursor;
begin
  Result := Cursor
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.GetBusy                                 |
 |                                                                      |
 | Stub 'Get' method for 'Busy' property                                |
 *----------------------------------------------------------------------*)
destructor TDisplayObjectLink.Destroy;
begin
  fFont.Free;

  inherited;
end;

function TDisplayObjectLink.FindText(const SearchStr: string;
  NewSearch: Boolean; Options: TStringSearchOptions; y : Integer): Boolean;
begin
  result := False;
end;

function TDisplayObjectLink.GetBusy: Boolean;
begin
  result := False
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.GetCursor                               |
 |                                                                      |
 | Stub function.  'Get' ,ethod for 'Cursor' property.  Return the      |
 | TMessageDisplay's cursor                                             |
 *----------------------------------------------------------------------*)
function TDisplayObjectLink.GetCursor: TCursor;
begin
  Result := Owner.Cursor
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.GetMargin                               |
 |                                                                      |
 | Stub 'Get' method for Margin property                                |
 *----------------------------------------------------------------------*)
function TDisplayObjectLink.GetHasText: boolean;
begin
  result := False;
end;

procedure TDisplayObjectLink.GetHTML(var txt: string; rawFragment : boolean = false);
begin
  // stub
end;

function TDisplayObjectLink.GetMargin: Integer;
begin
  Result := 0; // Stub
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.GetObj                                  |
 |                                                                      |
 | Stub 'Get' method for 'Obj' property                                 |
 *----------------------------------------------------------------------*)
function TDisplayObjectLink.GetObj : TObject;
begin
  Result := fObj
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.Refresh                                 |
 |                                                                      |
 | Stub 'Refresh' method.  Do nothing                                   |
 *----------------------------------------------------------------------*)
procedure TDisplayObjectLink.GetSelectedText(var txt: WideString);
begin
// stub
end;

function TDisplayObjectLink.GetSelLength: Integer;
begin
  result := 0; // stub
end;

procedure TDisplayObjectLink.GetText(var txt: WideString);
begin
// stub
end;

procedure TDisplayObjectLink.KeyPress(var ch: char);
begin
end;

procedure TDisplayObjectLink.PageDown;
begin

end;

procedure TDisplayObjectLink.Print;
begin
// stub
end;

procedure TDisplayObjectLink.Refresh;
begin
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.SetCursor                               |
 |                                                                      |
 | Stub 'Get' method for 'Cursor' propery.  This should be treated as   |
 | Read Only in the base class                                          |
 *----------------------------------------------------------------------*)

procedure TDisplayObjectLink.SetColor(const Value: TColor);
begin
  if fColor <> Value then
  begin
    fColor := Value;
    Refresh
  end
end;

procedure TDisplayObjectLink.SetCursor(const Value: TCursor);
begin
  raise Exception.Create (rstCantSetCursor);
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.SetHeight                               |
 |                                                                      |
 | Stub 'Get' method for 'Height' propery.  This should be treated as   |
 | Read Only in the base class                                          |
 *----------------------------------------------------------------------*)
procedure TDisplayObjectLink.SetFont(const Value: TFont);
begin
  fFont.Assign (Value);
  Refresh
end;

procedure TDisplayObjectLink.SetHeight(const Value: Integer);
begin
  raise Exception.Create (rstCantSetHeight);
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.SetObj                                  |
 |                                                                      |
 | Stub 'Get' method for 'Obj' propery.  This should be treated as      |
 | Read Only in the base class                                          |
 *----------------------------------------------------------------------*)
procedure TDisplayObjectLink.SetObj(const Value: TObject);
begin
  raise Exception.Create (rstCantSetObj);
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.SetWidth                                |
 |                                                                      |
 | Stub 'Get' method for 'Width' propery.  This should be treated as    |
 | Read Only in the base class                                          |
 *----------------------------------------------------------------------*)
procedure TDisplayObjectLink.SetSelectedText(const txt: WideString);
begin
// stub
end;

procedure TDisplayObjectLink.SetWidth(const Value: Integer);
begin
  raise Exception.Create (rstCantSetWidth);
end;

(*----------------------------------------------------------------------*
 | procedure TDisplayObjectLink.Stop                                    |
 |                                                                      |
 | Stub 'Stop' method.  Do nothing                                      |
 *----------------------------------------------------------------------*)
procedure TDisplayObjectLink.Stop;
begin
// stub
end;

{ TGraphicDisplayObjectLink }

(*----------------------------------------------------------------------*
 | constructor TGraphicDisplayObjectLink.Create                         |
 |                                                                      |
 | Constructor for TGraphicDisplayObjectLink                            |
 *----------------------------------------------------------------------*)
function TGraphicDisplayObjectLink.AutoFitHeight: Integer;
var
  r : TRect;
begin
  r := AutoFitRect;
  result := r.Bottom - r.Top;
end;

function HasHScrollBar (ctrl : TWinControl) : boolean;
begin
  result := (GetWindowLong (ctrl.Handle, GWL_STYLE) and WS_HSCROLL) <> 0;
end;

function HasVScrollBar (ctrl : TWinControl) : boolean;
begin
  result := (GetWindowLong (ctrl.Handle, GWL_STYLE) and WS_VSCROLL) <> 0;
end;

function TGraphicDisplayObjectLink.AutoFitRect: TRect;
var
  w,dw,h,dh : Integer;
  resized : boolean;
begin
  w := Owner.Parent.Width;
  h := Owner.Parent.Height;

  if HasHScrollBar (Owner.Parent) then
    Inc (h, GetSystemMetrics (SM_CYHSCROLL));

  if HasVScrollBar (Owner.Parent) then
    Inc (w, GetSystemMetrics (SM_CXVSCROLL));

  dh := graphic.Height;
  dw := graphic.Width + 2 * Margin;

  repeat
    resized := False;
    if w < dw then
    begin
      dh := dh * w div dw;
      dw :=w;
      resized := True;
    end;

    if h < dh then
    begin
      dw := dw * h div dh;
      dh := h;
      resized := True
    end
  until not resized;
  result := Rect (Margin, yPos, dw - Margin, yPos + dh);
end;

function TGraphicDisplayObjectLink.AutoFitWidth: Integer;
var
  r : TRect;
begin
  r := AutoFitRect;
  result := r.Right - r.Left;
end;

constructor TGraphicDisplayObjectLink.Create(AOwner: TMessageDisplay; AObj: TObject; codepage : Integer);
begin
  inherited;

  fWidth := -1;
  fHeight := -1;
end;

(*----------------------------------------------------------------------*
 | TGraphicDisplayObjectLink.Display                                    |
 |                                                                      |
 | Display the image if any of it is in the rectangle to be updated     |
 |                                                                      |
 | Parameters:                                                          |
 |   const r : TRect            The rectangle to be updated             |
 |   var y: Integer             The y position to draw at relative to   |
 |                              the control.                            |
 *----------------------------------------------------------------------*)
procedure TGraphicDisplayObjectLink.Display(const r : TRect; var y: Integer);
var
  r1, r2 : TRect;

  procedure DrawGraphic;
  var
    rgn : HRGN;
    r : TRect;
  begin
    rgn := 0;
    try
      if PercentDecoded <> 100 then
      begin
        rgn := CreateRectRgn (Margin, y, Margin + Graphic.Width, y + (height * PercentDecoded) div 100);
        SelectClipRgn (Owner.Canvas.Handle, rgn);
        Owner.Canvas.Draw(Margin, y, Graphic);
      end
      else
        if Owner.AutoFit then
        begin
          r := Rect (Margin, y, Margin + Width, y + Height);
          Owner.Canvas.StretchDraw(r, Graphic);
        end
        else
          Owner.Canvas.Draw(Margin, y, Graphic);
    finally
      if rgn <> 0 then
      begin
        SelectClipRgn (Owner.Canvas.Handle, 0);
        DeleteObject (rgn)
      end
    end
  end;

begin
  r1 := Rect (0, y, Owner.ClientWidth, y + Height);

  if IntersectRect (r2, r, r1) then
  try
    DrawGraphic
  except
    Sleep (10);
    DrawGraphic
  end;
  Inc (y, Height)
end;

(*----------------------------------------------------------------------*
 | class function TGraphicDisplayObjectLink.DisplaysObject              |
 |                                                                      |
 | Return true if the passed object is a TGraphic descendant - because  |
 | we know how to draw it.                                              |
 *----------------------------------------------------------------------*)
class function TGraphicDisplayObjectLink.DisplaysObject(
  obj: TObject): Boolean;
begin
  Result := obj is TGraphic
end;

function TGraphicDisplayObjectLink.GetGraphic: TGraphic;
begin
  Result := TGraphic (fObj);
end;

(*----------------------------------------------------------------------*
 | function TGraphicDisplayObjectLink.GetHeight                         |
 |                                                                      |
 | Overriddes base class function.  Get method for Height property      |
 *----------------------------------------------------------------------*)
function TGraphicDisplayObjectLink.GetHeight: Integer;
begin
  try
    if Owner.AutoFit then
      Result := AutoFitHeight
    else
      Result := Graphic.Height;
  except
    result := 0;
  end;
  fHeight := Result;
end;

(*----------------------------------------------------------------------*
 | function TGraphicDisplayObjectLink.GetWidth                          |
 |                                                                      |
 | Overriddes base class function.  Get method for Width property       |
 *----------------------------------------------------------------------*)
function TGraphicDisplayObjectLink.GetWidth: Integer;
begin
  try
    if Owner.AutoFit then
      Result := AutoFitWidth
    else
      Result := Graphic.Width;
  except
    result := 0
  end;
  fWidth := Result;
end;

(*----------------------------------------------------------------------*
 | TGraphicDisplayObjectLink.Reset                                      |
 |                                                                      |
 | Overrides base class Reset method.  Clear cached information         |
 *----------------------------------------------------------------------*)
procedure TGraphicDisplayObjectLink.Print;
var
  w, h, pw, ph : Integer;
  r : TRect;
begin
  w := Graphic.Width;
  h := Graphic.Height;
  pw := PageRect.Right - PageRect.Left;
  ph := PageRect.Bottom - PageRect.Top;

  if (w < pw) and (h < ph) then
  begin
    if ((w*100) div pw) > ((h * 100) div ph) then
    begin
      h := h * pw div w;
      w := pw
    end
    else
    begin
      w := w * ph div h;
      h := ph
    end
  end;

  if w > pw then
  begin
    h := h * pw div w;
    w := pw
  end;

  if h > ph then
  begin
    w := w * ph div h;
    h := ph
  end;

  r.Left := PageRect.Left;
  r.Top := PageRect.Top;
  r.Right := pageRect.Left+ w;
  r.Bottom := pageRect.Top + h;

  Printer.Canvas.StretchDraw(r, Graphic);
end;

procedure TGraphicDisplayObjectLink.Refresh;
var
  ow, oh : Integer;
  r : TRect;
begin
  inherited;

  ow := fWidth;
  oh := fHeight;

  if (Height <> oh) or (Width <> ow) then
    Owner.RecalcBounds
  else
  begin
    r := Rect (Margin, yPos, Margin + fWidth, yPos + fHeight);
    InvalidateRect (Owner.Handle, @r, false)
  end
end;

procedure TGraphicDisplayObjectLink.SetObj(const Value: TObject);
var
  gr : TGraphic;
begin
  gr := Value as TGraphic;
  fObj := gr;
  Refresh
end;

{ TWinControlObjectLink }

(*----------------------------------------------------------------------*
 | constructor TWinControlObjectLink.Create                             |
 |                                                                      |
 | Constructor for TWinControlObjectLink                                |
 *----------------------------------------------------------------------*)
constructor TWinControlObjectLink.Create(AOwner: TMessageDisplay; AObj: TObject; codepage : Integer);
begin
  inherited;

  Ctrl.Parent := Owner;
  Ctrl.Left := Margin;
  Ctrl.Top := Owner.MessageHeight;
end;

(*----------------------------------------------------------------------*
 | procedure TWinControlObjectLink.Display                              |
 |                                                                      |
 | Don't actually display anything - Windows itself will ensure         |
 | WinControls are drawn.  Simply update 'y' to take into account the   |
 | control's height                                                     |
 *----------------------------------------------------------------------*)
procedure TWinControlObjectLink.Display(const r : TRect; var y: Integer);
begin
  y := y + Height
end;

(*----------------------------------------------------------------------*
 | class function TWinControlObjectLink.DisplaysObject                  |
 |                                                                      |
 | Return true if the obj is a TWinControl to tell the world that we    |
 | know how to handle it.                                               |
 *----------------------------------------------------------------------*)
class function TWinControlObjectLink.DisplaysObject(obj: TObject): Boolean;
begin
  Result := obj is TWinControl
end;

function TWinControlObjectLink.GetCtrl: TWinControl;
begin
  Result := TWinControl (fObj);
end;

function TWinControlObjectLink.GetCursor: TCursor;
begin
  Result := Ctrl.Cursor
end;

(*----------------------------------------------------------------------*
 | function TWinControlObjectLink.GetHeight                             |
 |                                                                      |
 | Overriddes base class function.  Get method for Height property      |
 *----------------------------------------------------------------------*)
function TWinControlObjectLink.GetHeight: Integer;
begin
  Result := Ctrl.Height;
end;

(*----------------------------------------------------------------------*
 | function TWinControlObjectLink.GetWidth                              |
 |                                                                      |
 | Overriddes base class function.  Get method for Width property       |
 *----------------------------------------------------------------------*)
function TWinControlObjectLink.GetWidth: Integer;
begin
  Result := Ctrl.Width
end;

procedure TWinControlObjectLink.PageDown;
begin
end;

procedure TWinControlObjectLink.SetCursor(const Value: TCursor);
begin
  Ctrl.Cursor := value
end;

procedure TWinControlObjectLink.SetHeight(const Value: Integer);
begin
  Ctrl.Height := Value;
  Owner.RecalcBounds
end;

procedure TWinControlObjectLink.SetWidth(const Value: Integer);
begin
  Ctrl.Width := Value;
  Owner.RecalcBounds
end;


{ TPictureDisplayObjectLink }

function TPictureDisplayObjectLink.GetMargin: Integer;
begin
  Result := Owner.PictureIndent
end;

procedure TMessageDisplay.WMMouseWheel(var Message: TWMMouseWheel);
begin
  inherited
end;

{ TXFaceDisplayObjectLink }

procedure TXFaceDisplayObjectLink.Print;
var
  w : Integer;
  r : TRect;
begin
  r.Left := PageRect.Left;
  r.Top  := PageRect.Top div 6;
  w := PageRect.Top * 4 div 6;
  r.Bottom := r.Top + w;
  r.Right := r.Left + w;
  printer.Canvas.StretchDraw(r, Graphic);
end;

initialization
  RegisterDisplayObjectLink (TGraphicDisplayObjectLink);
  RegisterDisplayObjectLink (TWinControlObjectLink)
end.
