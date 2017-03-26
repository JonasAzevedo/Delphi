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

unit Uasg11;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, AdvGrid, StdCtrls, ExtCtrls, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AdvStringGrid1ContractNode(Sender: TObject; arow,
      arowreal: Integer);
    procedure AdvStringGrid1ExpandNode(Sender: TObject; arow,
      arowreal: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure AdvStringGrid1ClickCell(Sender: TObject; Arow,
      Acol: Integer);
  private
    bmwnode: integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j: integer;
begin
  with advstringgrid1 do
  begin
    savefixedcells := false;
    loadfromcsv('cars.csv');
    autosizecolumns(true, 10);
    ColWidths[0] := 20;
    i := 1; j := 1;
    while (i < rowcount - 1) do
    begin
      if cells[1, j] = 'BMW' then bmwnode := j;
      while (cells[1, j] = cells[1, j + 1]) and (j < rowcount - 1) do inc(j);
      if (i <> j) then AddNode(i, j - i + 1);
      i := j + 1;
      j := i;
    end;
    fixedcols := 0;
    row := 1; col := 1;
  end;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  case radiogroup1.itemindex of
    0: advstringgrid1.cellnode.nodetype := cnFlat;
    1: advstringgrid1.cellnode.nodetype := cn3D;
    2: advstringgrid1.cellnode.nodetype := cnLeaf;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Advstringgrid1.Expandall;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  advstringgrid1.contractall;
end;

procedure TForm1.AdvStringGrid1ContractNode(Sender: TObject; arow,
  arowreal: Integer);
begin
  listbox1.items.add('Contract : ' + inttostr(arow) + '-' + inttostr(arowreal));
end;

procedure TForm1.AdvStringGrid1ExpandNode(Sender: TObject; arow,
  arowreal: Integer);
begin
  listbox1.items.add('Expand : ' + inttostr(arow) + '-' + inttostr(arowreal));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  advstringgrid1.ExpandNode(bmwnode);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  advstringgrid1.ContractNode(bmwnode);
end;

procedure TForm1.AdvStringGrid1ClickCell(Sender: TObject; Arow,
  Acol: Integer);
begin
  with AdvStringGrid1 do
  begin
    if (ACol = 1) and (IsNode(ARow)) then
    begin
      arow := getrealrow;

      SetNodeState(arow, not GetNodeState(arow));
    end;
  end;
end;



end.
