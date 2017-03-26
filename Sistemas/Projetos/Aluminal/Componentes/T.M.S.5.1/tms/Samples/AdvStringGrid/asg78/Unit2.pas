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

unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    Panel1: TPanel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Edit1Change(Sender: TObject);
begin
  if checkbox1.checked then
    advstringgrid1.NarrowDown(Edit1.Text, 1)
  else
    advstringgrid1.NarrowDown(Edit1.Text);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  advstringgrid1.SaveFixedCells := false;
  advstringgrid1.WordWrap := true;
  advstringgrid1.Delimiter := ';';
  advstringgrid1.ScrollSynch := true;
  advstringgrid1.LoadFromCSV('cars.csv');
  advstringgrid1.FixedRowAlways := true;
  AdvStringGrid1.AutoSizeColumns(false);
end;

end.
