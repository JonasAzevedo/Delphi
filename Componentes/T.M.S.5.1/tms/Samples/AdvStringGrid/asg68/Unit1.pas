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
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, IniFiles;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    UnHideBtn: TButton;
    SaveBtn: TButton;
    LoadBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1ButtonClick(Sender: TObject; ACol, ARow: Integer);
    procedure UnHideBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AdvStringGrid1ButtonClick(Sender: TObject; ACol,
  ARow: Integer);
begin
  advstringgrid1.HideColumn(advstringgrid1.RealColIndex(Acol));
end;

procedure TForm1.UnHideBtnClick(Sender: TObject);
begin
  advstringgrid1.UnHideColumnsAll;
end;

procedure TForm1.SaveBtnClick(Sender: TObject);
var
  inifile: TInifile;
begin
  inifile := TIniFile.Create('.\grid.ini');
  inifile.WriteString('GRID', 'SETTINGS', advstringgrid1.ColumnStatesToString);
  inifile.Free;
end;

procedure TForm1.LoadBtnClick(Sender: TObject);
var
  inifile: TInifile;
  s: string;
begin
  inifile := TIniFile.Create('.\grid.ini');
  s := inifile.ReadString('GRID', 'SETTINGS', '');
  inifile.Free;

  if s <> '' then
    AdvStringGrid1.StringToColumnStates(s);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  {no fixed columns in grid}
  advstringgrid1.FixedCols := 0;
  advstringgrid1.ColCount := 10;
  advstringgrid1.RowCount := 50;
  {fill grid with easy to recognize data for this demo}
  advstringgrid1.LinearFill(false);
  advstringgrid1.AutoNumberRow(0);
  {enable column moving & column sizing}
  advstringgrid1.Options := advstringgrid1.Options + [goColSizing, goColMoving];

  {add buttons in the column header cells that will allow column hiding}
  for i := 0 to AdvStringGrid1.ColCount - 1 do
    advstringgrid1.AddButton(i, 0, 16, 16, 'X', haRight, vaTop);

  {make sure that buttons on a readonly cell are not disabled}
  advstringgrid1.ControlLook.NoDisabledButtonLook := true;

  {important call to set the reference column order of the grid}
  advstringgrid1.SetColumnOrder;
end;

end.
