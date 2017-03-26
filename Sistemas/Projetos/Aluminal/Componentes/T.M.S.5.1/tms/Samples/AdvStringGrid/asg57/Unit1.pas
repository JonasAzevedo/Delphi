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
    AdvStringGrid2: TAdvStringGrid;
    AdvStringGrid3: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1ExpandNode(Sender: TObject; ARow,
      ARowreal: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  advstringgrid1.LinearFill(false);
  advstringgrid1.AddNode(1, 2);
  advstringgrid1.RowHeights[2] := 128;
  advstringgrid1.MergeCells(1, 2, 4, 1);
  advstringgrid1.CellControls[1, 2] := advstringgrid2;
  advstringgrid1.AddNode(3, 2);
  advstringgrid1.RowHeights[4] := 128;
  advstringgrid1.MergeCells(1, 4, 4, 1);
  advstringgrid1.CellControls[1, 4] := advstringgrid3;
  advstringgrid1.ContractNode(1);
  advstringgrid1.ContractNode(3);
end;

procedure TForm1.AdvStringGrid1ExpandNode(Sender: TObject; ARow,
  ARowreal: Integer);
begin
  advstringgrid2.RandomFill(false, 100);
  advstringgrid3.RandomFill(false, 100);
end;

end.
