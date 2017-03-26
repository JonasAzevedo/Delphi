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

unit Uasg2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, AdvGrid, ColorGrd, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    Button1: TButton;
    ColorGrid1: TColorGrid;
    Label1: TLabel;
    Label2: TLabel;
    ColorGrid2: TColorGrid;
    procedure Button1Click(Sender: TObject);
    procedure AdvStringGrid1GetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure ColorGrid1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  i, j: Integer;
begin
  for i := 1 to AdvStringGrid1.RowCount - 1 do
    for j := 1 to AdvStringGrid1.ColCount - 1 do
      AdvStringGrid1.Ints[j, i] := Random(1000) - 500;
end;

procedure TForm1.AdvStringGrid1GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if AdvStringGrid1.Cells[ACol, ARow] <> '' then
    if AdvStringGrid1.Ints[ACol, ARow] < 0 then
    begin
      ABrush.Color := ColorGrid2.BackgroundColor;
      AFont.Color := ColorGrid2.ForegroundColor;
    end
    else
    begin
      Abrush.Color := Colorgrid1.BackgroundColor;
      AFont.Color := Colorgrid1.ForegroundColor;
      AFont.Style := [fsBold];
    end;
end;

procedure TForm1.ColorGrid1Change(Sender: TObject);
begin
  AdvStringGrid1.Invalidate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Button1Click(Sender);
end;

end.
