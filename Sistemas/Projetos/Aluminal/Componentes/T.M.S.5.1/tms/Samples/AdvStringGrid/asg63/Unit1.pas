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

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitGrid;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.InitGrid;
begin
  advstringgrid1.Grouping.MergeHeader := true;
  advstringgrid1.Grouping.HeaderColor := clWhite;
  advstringgrid1.Grouping.HeaderColorTo := clInfoBk;
  advstringgrid1.SaveFixedCells := false;
  advstringgrid1.LoadFromCSV('.\cargroups.csv');

  advstringgrid1.Group(1);
  advstringgrid1.SubGroup(1);
  advstringgrid1.ContractAll;
  advstringgrid1.Cells[1, 0] := 'Brand';
  advstringgrid1.Cells[2, 0] := 'Type';
  advstringgrid1.Cells[3, 0] := 'Cyl';
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  InitGrid;

end;

end.
