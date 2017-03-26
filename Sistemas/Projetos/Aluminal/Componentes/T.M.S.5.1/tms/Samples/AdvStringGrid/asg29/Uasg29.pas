{***************************************************************************}
{ TAdvStringGrid demo application                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 2009                                               }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{***************************************************************************}

unit Uasg29;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, AdvGrid, ComCtrls, ToolWin, ImgList, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    procedure AdvStringGrid1OleDrag(Sender: TObject; Arow, Acol: Integer;
      data: string; var allow: Boolean);
    procedure AdvStringGrid1OleDragStop(Sender: TObject;
      OLEEffect: Integer);
    procedure AdvStringGrid1OleDragOver(Sender: TObject; Arow,
      Acol: Integer; var allow: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1OleDragStart(Sender: TObject; Arow,
      Acol: Integer);
    procedure AdvStringGrid1OleDropCol(Sender: TObject; Arow, Acol,
      DropCol: Integer);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
    dragcolumn: integer;
    dragsource: TObject;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Ucollist;

{$R *.DFM}

procedure TForm1.AdvStringGrid1OleDrag(Sender: TObject; Arow,
  Acol: Integer; data: string; var allow: Boolean);
begin
  allow := (arow = 0) and (acol > 0);
  dragcolumn := Acol;
end;

procedure TForm1.AdvStringGrid1OleDragStop(Sender: TObject;
  OLEEffect: Integer);
begin
  FieldChooser.ButtonListbox1.AddItem(Advstringgrid1.Cells[dragcolumn, 0], TObject(dragcolumn));
  AdvStringGrid1.HideColumn(dragcolumn);
  dragsource := nil;
end;

procedure TForm1.AdvStringGrid1OleDragOver(Sender: TObject; Arow,
  Acol: Integer; var allow: Boolean);
begin
  allow := (dragsource = nil) and (acol > 0) and (arow = 0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  AdvStringGrid1.SaveFixedCells := false;
  AdvStringGrid1.LoadFromCSV('cars.csv');
end;

procedure TForm1.AdvStringGrid1OleDragStart(Sender: TObject; Arow,
  Acol: Integer);
begin
  dragsource := Sender;
end;

procedure TForm1.AdvStringGrid1OleDropCol(Sender: TObject; Arow, Acol,
  DropCol: Integer);
begin
  with Advstringgrid1 do
  begin
    UnhideColumn(dropcol);
    MoveColumn(DisplColIndex(dropcol), acol);
  end;
  with FieldChooser.ButtonListBox1 do Items.Delete(ItemIndex);
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  if FieldChooser.Visible then FieldChooser.Hide else FieldChooser.Show;
end;

end.
