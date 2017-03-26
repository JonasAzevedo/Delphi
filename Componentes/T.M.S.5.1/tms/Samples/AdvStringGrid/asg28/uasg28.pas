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

unit uasg28;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, AdvGrid, StdCtrls, ExtCtrls, activex, ComCtrls, BaseGrid;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    AdvStringGrid1: TAdvStringGrid;
    AdvStringGrid2: TAdvStringGrid;
    AdvStringGrid3: TAdvStringGrid;
    AdvStringGrid4: TAdvStringGrid;
    AdvStringGrid5: TAdvStringGrid;
    AdvStringGrid6: TAdvStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid2OleDropCol(Sender: TObject; Arow, Acol,
      DropCol: Integer);
    procedure AdvStringGrid1OleDrag(Sender: TObject; Arow, Acol: Integer;
      data: string; var allow: Boolean);
    procedure AdvStringGrid5OleDragStart(Sender: TObject; Arow,
      Acol: Integer);
    procedure AdvStringGrid5OleDragStop(Sender: TObject;
      OLEEffect: Integer);
    procedure AdvStringGrid5OleDropCol(Sender: TObject; Arow, Acol,
      DropCol: Integer);
    procedure AdvStringGrid6OleDrag(Sender: TObject; Arow, Acol: Integer;
      data: string; var allow: Boolean);
    procedure AdvStringGrid6OleDragOver(Sender: TObject; Arow,
      Acol: Integer; var allow: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    colsource, coltarget: tadvstringgrid;
    colsourceidx: integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  pagecontrol1.activepage := tabsheet1;

  advstringgrid1.randomfill(false, 100);
  advstringgrid1.autonumbercol(1);

  advstringgrid1.excelclipboardformat := true;
  advstringgrid2.excelclipboardformat := true;
  advstringgrid3.excelclipboardformat := true;
  advstringgrid4.excelclipboardformat := true;

  for i := 1 to advstringgrid1.rowcount - 1 do advstringgrid1.cells[2, i] := 'A';

  advstringgrid2.randomfill(false, 100);
  advstringgrid2.autonumbercol(1);
  for i := 1 to advstringgrid2.rowcount - 1 do advstringgrid2.cells[2, i] := 'B';

  advstringgrid3.randomfill(false, 100);
  advstringgrid3.autonumbercol(1);
  for i := 1 to advstringgrid3.rowcount - 1 do advstringgrid3.cells[2, i] := 'C';

  advstringgrid4.randomfill(false, 100);
  advstringgrid4.autonumbercol(1);
  for i := 1 to advstringgrid4.rowcount - 1 do advstringgrid4.cells[2, i] := 'D';

  advstringgrid5.randomfill(false, 100);
  advstringgrid5.autonumbercol(1);
  advstringgrid6.randomfill(false, 100);
  advstringgrid6.autonumbercol(1);

end;

procedure TForm1.AdvStringGrid2OleDropCol(Sender: TObject; Arow, Acol,
  DropCol: Integer);

var
  sl: TStringList;
begin
  coltarget := sender as TAdvStringGrid;
  sl := TStringList.Create;
  sl.Assign(colsource.Cols[DropCol]);

  coltarget.insertcols(acol, 1);
  coltarget.Cols[acol].Assign(sl);
  sl.Free;

end;

procedure TForm1.AdvStringGrid1OleDrag(Sender: TObject; Arow,
  Acol: Integer; data: string; var allow: Boolean);
begin
  allow := arow > 0;
end;

procedure TForm1.AdvStringGrid5OleDragStart(Sender: TObject; Arow,
  Acol: Integer);
begin
  colsource := sender as TAdvStringGrid;
  colsourceidx := acol;
end;

procedure TForm1.AdvStringGrid5OleDragStop(Sender: TObject;
  OLEEffect: Integer);
begin
  if OLEEffect = DROPEFFECT_MOVE then
  begin
    colsource.RemoveCols(colsourceidx, 1);
  end;
end;

procedure TForm1.AdvStringGrid5OleDropCol(Sender: TObject; Arow, Acol,
  DropCol: Integer);
var
  sl: TStringList;
begin
  coltarget := sender as TAdvStringGrid;
  sl := TStringList.Create;
  sl.Assign(colsource.Cols[DropCol]);

  if (acol = 0) then inc(acol);

  coltarget.insertcols(acol, 1);
  coltarget.Cols[acol].Assign(sl);
  sl.Free;
end;

procedure TForm1.AdvStringGrid6OleDrag(Sender: TObject; Arow,
  Acol: Integer; data: string; var allow: Boolean);
begin
  allow := arow = 0;
end;

procedure TForm1.AdvStringGrid6OleDragOver(Sender: TObject; Arow,
  Acol: Integer; var allow: Boolean);
begin
  with Sender as TAdvStringGrid do
    allow := (sender <> colsource) and (arow = 0) and ((acol > 0) or (colcount = 1));
end;

end.
