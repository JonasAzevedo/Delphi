unit cmpPropertyListBox;

interface

{$R PropertyListBoxBitmaps.Res}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, buttons;

type
  TPropertyListBox = class;

  TPropertyType = (ptString, ptInteger, ptBoolean);
  TPropertyListProperty = class (TCollectionItem)
  private
    fTag: Integer;
    fPropertyType: TPropertyType;
    function GetValueAsStr: string;
    procedure SetPropertyValue(const Value: variant);
  private
    fPropertyName: string;
    fPropertyValue : variant;

    property ValueAsStr : string read GetValueAsStr;
  public
    property PropertyValue : variant read fPropertyValue write SetPropertyValue;
    procedure IncValue;
    procedure DecValue;
  published
    property PropertyName : string read fPropertyName write fPropertyName;
    property PropertyType : TPropertyType read fPropertyType write fPropertyType;
    property Tag : Integer read fTag write fTag;
  end;

  TPropertyListProperties = class (TOwnedCollection)
  private
    fParent: TPropertyListBox;
    function GetItem(index: Integer): TPropertyListProperty;
    procedure SetItem(index: Integer; const Value: TPropertyListProperty);
  public
    property Parent : TPropertyListBox read fParent;
    property Items [index : Integer] : TPropertyListProperty read GetItem write SetItem; default;
  end;

  TPropertyListBox = class(TScrollingWinControl)
  private
    fProperties: TPropertyListProperties;
    fCanvas : TCanvas;
    fNameColWidth: Integer;
    fBorderStyle: TBorderStyle;
    fSelectedPropertyNo: Integer;
    fLineHeight : Integer;
    fPropertyEdit : TEdit;
    fDropdownButton : TBitBtn;
    fDownArrowBitmap : TBitmap;
    fOnPropertyChanged: TNotifyEvent;
    procedure WmPaint (var Message : TWMPaint); message WM_PAINT;
    procedure RecalcScrollbars;
    procedure SetNameColWidth(const Value: Integer);
    procedure SetBorderStyle(const Value: TBorderStyle);
    procedure SetSelectedPropertyNo(const Value: Integer);
    procedure SetPropertyEdit;
    procedure DoOnPropertyEditChange (Sender: TObject);
    procedure DoOnPropertyEditDblClick (Sender : TObject);
    procedure PropertyChanged;
  protected
    procedure PaintWindow (DC : HDC); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint;
    property Canvas : TCanvas read fCanvas;
    procedure Resize; override;
    procedure CreateParams (var Params : TCreateParams); override;
    procedure CreateWnd; override;
  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    function FindProperty (const propName : string) : TPropertyListProperty;
    property SelectedPropertyNo : Integer read fSelectedPropertyNo write SetSelectedPropertyNo;
  published
    property Align;
    property Anchors;
    property AutoScroll;
    property BiDiMode;
    property BorderStyle : TBorderStyle read fBorderStyle write SetBorderStyle default bsSingle;
    property Color;
    property ParentColor;
    property Properties : TPropertyListProperties read fProperties write fProperties;
    property NameColWidth : Integer read fNameColWidth write SetNameColWidth default 90;
    property OnPropertyChanged : TNotifyEvent read fOnPropertyChanged write fOnPropertyChanged;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Misc Units', [TPropertyListBox]);
end;

{ TPropertyListBox }

constructor TPropertyListBox.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csCaptureMouse,csClickEvents, csSetCaption, csDoubleClicks, csOpaque];
  fDownArrowBitmap := TBitmap.Create;
  fDownArrowBitmap.LoadFromResourceID (HInstance, 0);
  fBorderStyle := bsSingle;
  fSelectedPropertyNo := 0;
  Width := 180;
  fNameColWidth := 90;
  Height := 120;
  fCanvas := TControlCanvas.Create;
  TControlCanvas (fCanvas).Control := Self;
  fProperties := TPropertyListProperties.Create (Self, TPropertyListProperty);
  fProperties.fParent := self;
end;

procedure TPropertyListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;

  if fBorderStyle = bsSingle then
    Params.Style := params.Style or WS_BORDER;
end;

procedure TPropertyListBox.CreateWnd;
begin
  inherited;
  RecalcScrollBars;
end;

destructor TPropertyListBox.Destroy;
begin
  fProperties.Free;
  fCanvas.Free;
  fDownArrowBitmap.Free;
  inherited;
end;

procedure TPropertyListBox.DoOnPropertyEditChange(Sender: TObject);
var
  prop : TPropertyListProperty;
begin
  if fSelectedPropertyNo >= fProperties.Count then Exit;
  prop := fProperties [fSelectedPropertyNo];
  prop.SetPropertyValue (fPropertyEdit.Text);
  PropertyChanged
end;

procedure TPropertyListBox.DoOnPropertyEditDblClick(Sender: TObject);
var
  prop : TPropertyListProperty;
begin
  if fSelectedPropertyNo >= fProperties.Count then Exit;
  prop := fProperties [fSelectedPropertyNo];
  prop.IncValue;
end;

function TPropertyListBox.FindProperty(
  const propName: string): TPropertyListProperty;
var
  i : Integer;
begin
  result := nil;
  for i := 0 to fProperties.Count - 1 do
    if CompareText (fProperties [i].PropertyName, propName) = 0 then
    begin
      result := fProperties [i];
      break
    end
end;

procedure TPropertyListBox.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  offset : Integer;
  pt : TPoint;
  r : TRect;
begin
  inherited;

  pt.x := x;
  pt.y := y;

  r := ClientRect;
  r.Left := NameColWidth - 1;
  r.Right := r.Left + 3;

  if PtInRect (r, pt) then
  begin
    MessageBeep ($ffff);
  end
  else
  begin
    offset := VertScrollBar.Position;

    Inc (y, Offset);

    SelectedPropertyNo := y div fLineHeight
  end
end;

procedure TPropertyListBox.Paint;
var
  i, offset, y, indent : Integer;
  prop : TPropertyListProperty;
  r : TRect;
begin
  if fLineHeight = 0 then Exit;
  if fPropertyEdit = Nil then
    SetPropertyEdit;
  offset := VertScrollBar.Position;
  Canvas.Font.Color := Font.Color;
  Canvas.Brush.Color := Color;
  indent := 8;

  y := 0;
  i := 0;
  while y < ClientHeight + offset + fLineHeight do
  begin
    if y >= offset then
    begin
      if i < Properties.Count then
      begin
        prop := fProperties [i];

        r.left := 0;
        r.right := ClientWidth - 1;
        r.top := y - offset + 1;
        r.bottom := r.top + fLineHeight - 1;

        Canvas.TextRect (r, indent, y - offset + 2, prop.PropertyName);
        Canvas.TextOut (NAmeColWidth + Indent, y - offset, prop.ValueAsStr);

        if i = SelectedPropertyNo then
        begin
          Frame3d (Canvas, r, clBtnShadow, clBtnHighlight, 1);
        end;
        Inc (i)
      end;
      Canvas.Pen.Color := clGray;
      Canvas.MoveTo (0, y - offset);
      Canvas.LineTo (ClientWidth, y - offset);
    end
    else
      Inc (i);

    Inc (y, fLineHeight);
  end;

  r := ClientRect;
  r.Left := NameColWidth;
  r.Right := r.Left;
  DrawEdge (Canvas.Handle, r, EDGE_ETCHED, BF_LEFT);
end;

procedure TPropertyListBox.PaintWindow(DC: HDC);
begin
  FCanvas.Lock;
  try
    FCanvas.Handle := DC;
    try
      TControlCanvas(FCanvas).UpdateTextFlags;
      Paint;
    finally
      FCanvas.Handle := 0;
    end;
  finally
    FCanvas.Unlock;
  end;
end;

procedure TPropertyListBox.PropertyChanged;
var
  prop : TPropertyListProperty;
begin
  if fSelectedPropertyNo >= fProperties.Count then exit;
  prop := fproperties [fSelectedPropertyNo];
  if Assigned (fPropertyEdit) then
  begin
    fPropertyEdit.Text := prop.ValueAsStr;
    Invalidate
  end
  else
  begin
    Invalidate
  end;

  if Assigned (OnPropertyChanged) and not (csDestroying in ComponentState) then
    OnPropertyChanged (self)
end;

procedure TPropertyListBox.RecalcScrollbars;
begin
  fLineHeight := Canvas.TextHeight ('M') + 4;
  VertScrollBar.Range := fLineHeight * fProperties.Count;
  VertScrollBar.Increment := fLineHeight
end;

procedure TPropertyListBox.Resize;
begin
  inherited;
  RecalcScrollBars;
end;

procedure TPropertyListBox.SetBorderStyle(const Value: TBorderStyle);
begin
  if value <> fBorderStyle then
  begin
    fBorderStyle := Value;
    RecreateWnd
  end
end;

procedure TPropertyListBox.SetNameColWidth(const Value: Integer);
begin
  if value <> fNameColWidth then
  begin
    fNameColWidth := Value;
    Invalidate
  end
end;

procedure TPropertyListBox.SetPropertyEdit;
var
  prop : TPropertyListProperty;
begin
  if Assigned (fPropertyEdit) then
    FreeAndNil (fPropertyEdit);

  if Assigned (fDropdownButton) then
    FreeAndNil (fDropdownButton);

  if csDesigning in ComponentState then Exit;
  if fSelectedPropertyNo >= fProperties.Count then Exit;

  prop := fProperties [fSelectedPropertyNo];

  fPropertyEdit := TEdit.Create (self);
  fPropertyEdit.Parent := self;
  fPropertyEdit.OnChange := DoOnPropertyEditChange;
  fPropertyEdit.OnDblClick := DoOnPropertyEditDblClick;

  fPropertyEdit.Height := fLineHeight;
  fPropertyEdit.Left := fNameColWidth + 2;
  fPropertyEdit.Top := fSelectedPropertyNo * fLineHeight;

  if prop.PropertyType = ptBoolean then
  begin
    fDropdownButton := TBitBtn.Create (self);
    fDropdownButton.Parent := self;
    fDropdownButton.Top := fPropertyEdit.Top + 2;
    fDropdownButton.Height := fPropertyEdit.Height - 4;
    fDropdownButton.Width := 12;
    fDropdownButton.Glyph := fDownArrowBitmap;
    fPropertyEdit.Width := ClientWidth - fNameColWidth - 2 - fDropdownButton.Width;
    fDropdownButton.Left := fPropertyEdit.Left + fPropertyEdit.Width;
  end
  else
    fPropertyEdit.Width := ClientWidth - fNameColWidth - 2;

  fPropertyEdit.Text := prop.ValueAsStr;

  fPropertyEdit.SetFocus;
  fPropertyEdit.Show
end;

procedure TPropertyListBox.SetSelectedPropertyNo(const Value: Integer);
begin
  if value <> fSelectedPropertyNo then
  begin
    fSelectedPropertyNo := Value;
    SetPropertyEdit;

    Invalidate;
  end
end;

procedure TPropertyListBox.WmPaint(var Message: TWMPaint);
begin
  ControlState := ControlState + [csCustomPaint];
  inherited;
  ControlState := ControlState - [csCustomPaint];
end;

{ TPropertyListProperties }

function TPropertyListProperties.GetItem(
  index: Integer): TPropertyListProperty;
begin
  result := inherited Items [index] as TPropertyListProperty;
end;

procedure TPropertyListProperties.SetItem(index: Integer;
  const Value: TPropertyListProperty);
begin
  inherited Items [index] := Value
end;

{ TPropertyListProperty }

procedure TPropertyListProperty.DecValue;
begin
  case PropertyType of
    ptInteger : fPropertyValue := fPropertyValue - 1;
    ptBoolean : fPropertyValue := not fPropertyValue
  end;

  TPropertyListProperties (collection).Parent.PropertyChanged
end;

function TPropertyListProperty.GetValueAsStr: string;
begin
  if VarType (fPropertyValue) = varBoolean then
    if fPropertyValue then
      result := 'True'
    else
      result := 'False'
  else
    result := fPropertyValue;

end;

procedure TPropertyListProperty.IncValue;
begin
  case PropertyType of
    ptInteger : fPropertyValue := fPropertyValue + 1;
    ptBoolean : fPropertyValue := not fPropertyValue
  end;

  TPropertyListProperties (collection).Parent.PropertyChanged;
end;

procedure TPropertyListProperty.SetPropertyValue(const Value: variant);
begin
  if VarIsEmpty (fPropertyValue) or (fPropertyValue <> Value) then
  begin
    fPropertyValue := value;
    TPropertyListProperties (collection).Parent.PropertyChanged
  end
end;

end.
