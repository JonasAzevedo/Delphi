unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Planner, DBPlanner, StdCtrls;

type
  TForm1 = class(TForm)
    DBDaySource1: TDBDaySource;
    DBPlanner1: TDBPlanner;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    Label1: TLabel;
    procedure DBPlanner1ItemInsert(Sender: TObject; Position, FromSel,
      FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DBPlanner1ItemInsert(Sender: TObject; Position, FromSel,
  FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  if DBPlanner1.Items.HasItem(FromSel,ToSel,Position) then
    ShowMessage('Sorry, the selected timeslot already has an event')
  else
    DBPlanner1.CreateItemAtSelection;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBPlanner1.Overlap := False;
  DBPlanner1.DefaultItem.AllowOverlap := False;
  ADOTable1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=.\dbplanner.mdb;Persist Security Info=False';
  ADOTable1.Active := true;
end;

end.
