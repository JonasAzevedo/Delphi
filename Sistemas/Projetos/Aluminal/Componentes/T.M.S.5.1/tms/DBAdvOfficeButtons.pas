{*************************************************************************}
{ DBAdvOfficeButtons components                                           }
{ for Delphi & C++Builder                                                 }
{ version 1.0                                                             }
{                                                                         }
{ written by                                                              }
{    TMS Software                                                         }
{    copyright � 2007                                                     }
{    Email : info@tmssoftware.com                                         }
{    Web : http://www.tmssoftware.com                                     }
{                                                                         }
{ The source code is given as is. The author is not responsible           }
{ for any possible damage done due to the use of this code.               }
{ The component can be freely used in any application. The complete       }
{ source code remains property of the author and may not be distributed,  }
{ published, given or sold in any form as such. No parts of the source    }
{ code can be included in any other component or application without      }
{ written authorization of the author.                                    }
{*************************************************************************}

unit DBAdvOfficeButtons;

{$I TMSDEFS.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBCtrls, StdCtrls, DBConsts, AdvOfficeButtons;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 2; // Build nr.

  // version history
  // v1.0.0.2 : Fixed issue with ReadOnly = true for TDBAdvOfficeRadioGroup

type

  TDBAdvOfficeCheckBox = class(TCustomAdvOfficeCheckBox)
  private
    FDataLink: TFieldDataLink;
    FValueUncheck: string;
    FValueCheck: string;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetFieldState: TCheckBoxState;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetValueCheck(const Value: string);
    procedure SetValueUncheck(const Value: string);
    function ValueMatch(const ValueList, Value: string): Boolean;
    {$IFNDEF TMSDOTNET}
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    {$ENDIF}
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const Value: Boolean);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    function GetCheckedEx: Boolean;
  protected
    { Protected declarations }
    function GetVersionNr: Integer; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure KeyPress(var Key: Char); override;
    {$IFDEF TMSDOTNET}
    function GetDataLink: TDataLink;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Toggle; override;
    property Checked: Boolean read GetCheckedEx;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ValueChecked: string read FValueCheck write SetValueCheck;
    property ValueUnchecked: string read FValueUncheck write SetValueUncheck;
  end;

  TDBAdvOfficeRadioGroup = class(TCustomAdvOfficeRadioGroup)
  private
    FDataLink: TFieldDataLink;
    FValue: string;
    FValues: TStrings;
    FInSetValue: Boolean;
    FOnChange: TNotifyEvent;
    FIgnoreChange: Boolean;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    function GetButtonValue(Index: Integer): string;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValue(const Value: string);
    procedure SetValues(Value: TStrings);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
    function GetVersionNr: Integer; override;
    procedure Change; dynamic;
    procedure Click; override;
    procedure KeyPress(var Key: Char); override;
    function CanModify: Boolean; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    property DataLink: TFieldDataLink read FDataLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF DELPHI4_LVL}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    {$ENDIF}
    property Field: TField read GetField;
    property ItemIndex;
    property Value: string read FValue write SetValue;
  published
    property Align;
    {$IFDEF DELPHI4_LVL}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    {$ENDIF}
    property Caption;
    property Color;
    property Columns;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    //property ItemIndex;
    property Items;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Values: TStrings read FValues write SetValues;
    property Visible;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick;
    {$IFDEF DELPHI5_LVL}
    property OnContextPopup;
    {$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    {$IFDEF DELPHI4_LVL}
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    property OnStartDrag;
  end;

  TDBAdvofficeCheckGroup = class(TCustomAdvOfficeCheckGroup)
  private
    FDataLink: TFieldDataLink;
    FIgnoreChange: Boolean;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(const Value: TDataSource);
    procedure SetReadOnly(const Value: Boolean);
  protected
    function CanModify: Boolean; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Click; override;
    procedure KeyPress(var Key: Char); override;
    property DataLink: TFieldDataLink read FDataLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF DELPHI4_LVL}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    {$ENDIF}
    property Value;
  published
    property Align;
    {$IFDEF DELPHI4_LVL}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    {$ENDIF}
    property Caption;
    property Color;
    property Columns;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Items;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    {$IFDEF DELPHI5_LVL}
    property OnContextPopup;
    {$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    {$IFDEF DELPHI4_LVL}
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    property OnStartDrag;
  end;

implementation

//------------------------------------------------------------------------------

{ TDBAdvOfficeCheckBox }

procedure TDBAdvOfficeCheckBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

//------------------------------------------------------------------------------

{$IFNDEF TMSDOTNET}
procedure TDBAdvOfficeCheckBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;
{$ENDIF}

//------------------------------------------------------------------------------

{$IFDEF TMSDOTNET}
function TDBAdvOfficeCheckBox.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;
{$ENDIF}

//------------------------------------------------------------------------------

constructor TDBAdvOfficeCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csReplicatable];
  State := cbUnchecked;
  FValueCheck := STextTrue;
  FValueUncheck := STextFalse;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeCheckBox.DataChange(Sender: TObject);
begin
  State := GetFieldState;
end;

//------------------------------------------------------------------------------

destructor TDBAdvOfficeCheckBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeCheckBox.GetCheckedEx: Boolean;
begin
  Result := inherited Checked;
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeCheckBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeCheckBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeCheckBox.GetFieldState: TCheckBoxState;
var
  Text: string;
begin
  if FDatalink.Field <> nil then
    if FDataLink.Field.IsNull then
      Result := cbGrayed
    else if FDataLink.Field.DataType = ftBoolean then
      if FDataLink.Field.AsBoolean then
        Result := cbChecked
      else
        Result := cbUnchecked
    else
    begin
      Result := cbGrayed;
      Text := FDataLink.Field.Text;
      if ValueMatch(FValueCheck, Text) then Result := cbChecked else
        if ValueMatch(FValueUncheck, Text) then Result := cbUnchecked;
    end
  else
    Result := cbUnchecked;
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeCheckBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeCheckBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ':
      FDataLink.Edit;
    #27:
      FDataLink.Reset;
  end;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeCheckBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeCheckBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeCheckBox.SetDataSource(const Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeCheckBox.SetReadOnly(const Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeCheckBox.SetValueCheck(const Value: string);
begin
  FValueCheck := Value;
  DataChange(Self);
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeCheckBox.SetValueUncheck(const Value: string);
begin
  FValueUncheck := Value;
  DataChange(Self);
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeCheckBox.Toggle;
begin
  if FDataLink.Edit then
  begin
    inherited Toggle;
    FDataLink.Modified;
  end;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeCheckBox.UpdateData(Sender: TObject);
var
  Pos: Integer;
  S: string;
begin
  if State = cbGrayed then
    FDataLink.Field.Clear
  else
    if FDataLink.Field.DataType = ftBoolean then
      FDataLink.Field.AsBoolean := Checked
    else
    begin
      if Checked then S := FValueCheck else S := FValueUncheck;
      Pos := 1;
      {$IFDEF DELPHI9_LVL}
      FDataLink.Field.Text := ExtractFieldName(WideString(S), Pos);
      {$ELSE}
      FDataLink.Field.Text := ExtractFieldName(S, Pos);
      {$ENDIF}
    end;
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeCheckBox.ValueMatch(const ValueList,
  Value: string): Boolean;
var
  Pos: Integer;
begin
  Result := False;
  Pos := 1;
  while Pos <= Length(ValueList) do
    {$IFDEF DELPHI9_LVL}
    if AnsiCompareText(ExtractFieldName(WideString(ValueList), Pos), Value) = 0 then
    {$ELSE}
    if AnsiCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
    {$ENDIF}
    begin
      Result := True;
      Break;
    end;
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeCheckBox.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

{ TDBAdvOfficeRadioGroup }

function TDBAdvOfficeRadioGroup.CanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.Click;
begin
  if not FInSetValue then
  begin
    inherited Click;
    if ItemIndex >= 0 then
      Value := GetButtonValue(ItemIndex);

    FIgnoreChange := True;
    FDataLink.Edit;
    if FDataLink.Editing then FDataLink.Modified;
    FIgnoreChange := False;
  end;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    if ItemIndex >= 0 then
      TAdvOfficeRadioButton(Controls[ItemIndex]).SetFocus else
      TAdvOfficeRadioButton(Controls[0]).SetFocus;
    raise;
  end;
  inherited;
end;

//------------------------------------------------------------------------------

constructor TDBAdvOfficeRadioGroup.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FValues := TStringList.Create;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.DataChange(Sender: TObject);
begin
  if not FIgnoreChange then
  begin
    if FDataLink.Field <> nil then
      Value := FDataLink.Field.Text else
      Value := '';
  end;
end;

//------------------------------------------------------------------------------

destructor TDBAdvOfficeRadioGroup.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FValues.Free;
  inherited;
end;

//------------------------------------------------------------------------------

{$IFDEF DELPHI4_LVL}
function TDBAdvOfficeRadioGroup.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataLink <> nil) and
    DataLink.ExecuteAction(Action);
end;
{$ENDIF}

//------------------------------------------------------------------------------

function TDBAdvOfficeRadioGroup.GetButtonValue(Index: Integer): string;
begin
  if (Index < FValues.Count) and (FValues[Index] <> '') then
    Result := FValues[Index]
  else if Index < Items.Count then
    Result := Items[Index]
  else
    Result := '';
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeRadioGroup.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeRadioGroup.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeRadioGroup.GetField: TField;
begin
  Result := FDataLink.Field;
end;

//------------------------------------------------------------------------------

function TDBAdvOfficeRadioGroup.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ': FDataLink.Edit;
    #27: FDataLink.Reset;
  end;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
  IsReadOnly := value;
end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.SetValue(const Value: string);
var
  I, Index: Integer;
begin
  if FValue <> Value then
  begin
    FInSetValue := True;
    try
      Index := -1;
      for I := 0 to Items.Count - 1 do
        if Value = GetButtonValue(I) then
        begin
          Index := I;
          Break;
        end;
      ItemIndex := Index;
    finally
      FInSetValue := False;
    end;
    FValue := Value;
    Change;
  end;

end;

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.SetValues(Value: TStrings);
begin
  FValues.Assign(Value);
  DataChange(Self);
end;

//------------------------------------------------------------------------------

{$IFDEF DELPHI4_LVL}
function TDBAdvOfficeRadioGroup.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataLink <> nil) and
    DataLink.UpdateAction(Action);
end;
{$ENDIF}

//------------------------------------------------------------------------------

procedure TDBAdvOfficeRadioGroup.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil then FDataLink.Field.Text := Value;
end;

//------------------------------------------------------------------------------

{$IFDEF DELPHI4_LVL}
function TDBAdvOfficeRadioGroup.UseRightToLeftAlignment: Boolean;
begin
  Result := inherited UseRightToLeftAlignment;
end;
{$ENDIF}

//------------------------------------------------------------------------------

function TDBAdvOfficeRadioGroup.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

//------------------------------------------------------------------------------

{ TDBAdvofficeCheckGroup }

constructor TDBAdvofficeCheckGroup.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

//------------------------------------------------------------------------------

destructor TDBAdvofficeCheckGroup.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited;
end;

//------------------------------------------------------------------------------

{$IFDEF DELPHI4_LVL}
function TDBAdvofficeCheckGroup.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (DataLink <> nil) and DataLink.ExecuteAction(Action);
end;

function TDBAdvofficeCheckGroup.UpdateAction(
  Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (DataLink <> nil) and
    DataLink.UpdateAction(Action);
end;
{$ENDIF}

//------------------------------------------------------------------------------

function TDBAdvofficeCheckGroup.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

//------------------------------------------------------------------------------

function TDBAdvofficeCheckGroup.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

//------------------------------------------------------------------------------

function TDBAdvofficeCheckGroup.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

//------------------------------------------------------------------------------

procedure TDBAdvofficeCheckGroup.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

//------------------------------------------------------------------------------

procedure TDBAdvofficeCheckGroup.SetDataSource(const Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

//------------------------------------------------------------------------------

procedure TDBAdvofficeCheckGroup.SetReadOnly(const Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

//------------------------------------------------------------------------------

function TDBAdvofficeCheckGroup.CanModify: Boolean;
begin
  Result := FDataLink.Edit;
end;

//------------------------------------------------------------------------------

procedure TDBAdvofficeCheckGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

//------------------------------------------------------------------------------

procedure TDBAdvofficeCheckGroup.DataChange(Sender: TObject);
begin
  if not FIgnoreChange then
  begin
    if FDataLink.Field <> nil then
      Value := FDataLink.Field.AsInteger
    else
      Value := 0;
  end;
end;

//------------------------------------------------------------------------------

procedure TDBAdvofficeCheckGroup.UpdateData(Sender: TObject);
begin
  if FDataLink.Field <> nil then FDataLink.Field.AsInteger := Value;
end;

//------------------------------------------------------------------------------

procedure TDBAdvofficeCheckGroup.Click;
begin
  inherited;
  FIgnoreChange := True;
  FDataLink.Edit;
  if FDataLink.Editing then FDataLink.Modified;
  FIgnoreChange := False;
end;

//------------------------------------------------------------------------------

procedure TDBAdvofficeCheckGroup.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ': FDataLink.Edit;
    #27: FDataLink.Reset;
  end;
end;

//------------------------------------------------------------------------------

procedure TDBAdvofficeCheckGroup.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    raise;
  end;
  inherited;
end;

//------------------------------------------------------------------------------

end.
