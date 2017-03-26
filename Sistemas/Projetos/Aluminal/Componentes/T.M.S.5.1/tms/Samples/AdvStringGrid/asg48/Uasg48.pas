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

unit Uasg48;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1GetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
var
  i, j: Integer;
begin
  with AdvStringGrid1 do
    for i := 1 to ColCount - 1 do
      for j := 1 to RowCount - 1 do
        Ints[i, j] := Random(100) - 50;
end;

procedure TForm1.AdvStringGrid1GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if AdvStringGrid1.Ints[ACol, ARow] < 0 then
  begin
    ABrush.Color := clInfoBk;
    AFont.Color := clRed;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i, j: Integer;
begin
  AdvStringGrid1.ClearSelectedCells;
  with AdvStringGrid1 do
    for i := 1 to ColCount - 1 do
      for j := 1 to RowCount - 1 do
        SelectedCells[i, j] := (odd(i) and odd(j)) or (not odd(i) and not odd(j));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  AdvStringGrid1.ClearSelectedCells;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i: Integer;
  gc: TGridCoord;
begin
  listbox1.Items.Clear;
  listbox1.Items.Add('Nr. of cells : ' + IntToStr(AdvStringGrid1.SelectedCellsCount));
  for i := 1 to AdvStringGrid1.SelectedCellsCount do
  begin
    gc := AdvStringGrid1.SelectedCell[i - 1];
    listbox1.Items.Add(IntToStr(gc.X) + ':' + IntToStr(gc.Y));

  end;

end;

end.
