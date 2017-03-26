{***************************************************************************}
{ TAdvStringGrid demo application                                           }
{ for Delphi & C++Builder                                                   }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2009                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{***************************************************************************}

unit Uasg18;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, AdvGrid, StdCtrls, ExtCtrls, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    sortgroup: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure sortgroupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  with advstringgrid1 do
  begin
    SaveFixedCells := false;
    Loadfromcsv('cars.csv');
    cells[1, 0] := 'Car';
    cells[2, 0] := 'Model';
    cells[3, 0] := 'Cc';
    cells[4, 0] := 'Pk';
    cells[5, 0] := 'Cyl.';
    cells[6, 0] := 'Kw';
    cells[7, 0] := 'Price';
    cells[8, 0] := 'Country';
  end;

end;

procedure TForm1.sortgroupClick(Sender: TObject);
begin
  case sortgroup.itemindex of
    0: begin
        advstringgrid1.QSort;
      end;
    1: begin
        advstringgrid1.SortIndexes.Clear;
        advstringgrid1.SortIndexes.Add(5);
        advstringgrid1.SortIndexes.Add(7);
        advstringgrid1.SortIndexes.Add(1);
        advstringgrid1.QSortIndexed;
      end;
    2: begin
        advstringgrid1.SortIndexes.Clear;
        advstringgrid1.SortIndexes.Add(4);
        advstringgrid1.SortIndexes.Add(6);
        advstringgrid1.SortIndexes.Add(3);
        advstringgrid1.QSortIndexed;
      end;
    3: begin
        advstringgrid1.SortIndexes.Clear;
        advstringgrid1.SortIndexes.Add(3);
        advstringgrid1.SortIndexes.Add(7);
        advstringgrid1.SortIndexes.Add(1);
        advstringgrid1.QSortIndexed;
      end;
  end;

end;

end.
