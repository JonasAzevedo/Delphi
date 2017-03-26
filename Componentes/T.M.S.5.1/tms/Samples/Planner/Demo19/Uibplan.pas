unit Uibplan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Planner, DBPlanner, IBDatabase, Db, IBCustomDataSet, IBTable, Grids,
  DBGrids, StdCtrls, IBQuery;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    IBTable1: TIBTable;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    DBDaySource1: TDBDaySource;
    DBPlanner1: TDBPlanner;
    procedure DBPlanner1ItemInsert(Sender: TObject; Position, FromSel,
      FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure DBPlanner1ItemDelete(Sender: TObject; Item: TPlannerItem);
    procedure DBDaySource1SetFilter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.DBPlanner1ItemInsert(Sender: TObject; Position, FromSel,
  FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  with DBPlanner1.CreateItemAtSelection do
  begin
    Update;

//    IBTransaction1.Commit;
//    IBtransaction1.starttransaction;

  end;
end;

procedure TForm1.DBPlanner1ItemDelete(Sender: TObject; Item: TPlannerItem);
begin
  DBPlanner1.FreeItem(item);
end;

procedure TForm1.DBDaySource1SetFilter(Sender: TObject);
begin
//  IBTable1.Filter := 'ITEMEND > "5/7/2001"';
//  IBTable1.Filtered := true;
end;

end.
