unit DBDateTimePicker_Copiada;

interface

uses
SysUtils, Classes, Controls, ComCtrls, Forms, Dialogs, Graphics, DBCtrls,DB, stdctrls; 

type
TDBDateTimePicker = class(TDateTimePicker)
private
  { Private declarations }
  FDataLink : TFieldDataLink;
  function GetDataField:String;
  procedure SetDataField(const Value : string);
  function GetDataSource:TDataSource;
  procedure SetDataSource(const Value : TDataSource);
  procedure DataChange(Sender:TObject);
  procedure UpdateData(Sender:TObject);
  procedure Change;override;
protected
  { Protected declarations }
public
  { Public declarations }
  constructor Create(AOwner:TComponent);override;
  destructor Destroy;override;
  property Field: TField read GetField;
published
  { Published declarations }
  property DataSource : TDataSource read GetDataSource Write SetDataSource;
  property DataField : String read GetDataField write SetDataField;
end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents("Fernando", [TDBDateTimePicker]);
end;

{ TDBDateTimePicker }

procedure TDBDateTimePicker.Change;
begin
  FDataLink.Modified;
  inherited Change;
  Try
    FDataLink.Edit;
    FDataLink.UpdateRecord;
  Except
  End;
end;

constructor TDBDateTimePicker.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.Control := self;
  Width := 100;
end;

procedure TDBDateTimePicker.DataChange(Sender: TObject);
begin
  Date := FDataLink.Field.AsDateTime;
end;

destructor TDBDateTimePicker.Destroy;
begin
  FDataLink.Free;
  inherited;
end;

function TDBDateTimePicker.GetDataField: String;
begin
  Result := FDataLink.FieldName;
end;

function TDBDateTimePicker.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBDateTimePicker.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TDBDateTimePicker.SetDataSource(const Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

procedure TDBDateTimePicker.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsDateTime := FDataLink.Field.AsDateTime;
end;

end.

