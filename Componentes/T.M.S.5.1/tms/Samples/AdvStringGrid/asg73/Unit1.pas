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
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1GetDisplText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure AdvStringGrid1CellValidate(Sender: TObject; ACol, ARow: Integer;
      var Value: string; var Valid: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AdvStringGrid1CellValidate(Sender: TObject; ACol,
  ARow: Integer; var Value: string; var Valid: Boolean);
begin
  Value := IntToStr(integer(advstringgrid1.ComboBox.Items.Objects[advstringgrid1.ComboBox.ItemIndex]));
end;

procedure TForm1.AdvStringGrid1GetDisplText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
var
  i, e: integer;
begin
  val(value, i, e);

  if e = 0 then
    Value := advstringgrid1.ComboBox.Items[StrToInt(Value)];
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  listbox1.Items.Add(advstringgrid1.Cells[1, 1]);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  listbox1.Items.Add(advstringgrid1.GridCells[1, 1]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  advstringgrid1.Options := advstringgrid1.Options + [goEditing];
  advstringgrid1.DefaultEditor := edComboList;
  advstringgrid1.ComboBox.Items.AddObject('Germany', TObject(0));
  advstringgrid1.ComboBox.Items.AddObject('France', TObject(1));
  advstringgrid1.ComboBox.Items.AddObject('Spain', TObject(2));
  advstringgrid1.ComboBox.Items.AddObject('Russia', TObject(3));

  advstringgrid1.Cells[1, 1] := '0';
  advstringgrid1.Cells[1, 2] := '1';
  advstringgrid1.Cells[1, 3] := '2';
  advstringgrid1.Cells[1, 4] := '3';
end;

end.
