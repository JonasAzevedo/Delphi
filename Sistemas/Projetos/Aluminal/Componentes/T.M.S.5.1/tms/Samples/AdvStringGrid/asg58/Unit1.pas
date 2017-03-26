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
  Dialogs, Grids, BaseGrid, AdvGrid, AdvGridWorkbook, StdCtrls,
  Menus, ExtCtrls;

type
  TForm1 = class(TForm)
    AdvGridWorkbook1: TAdvGridWorkbook;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Loadfiles2Click(Sender: TObject);
    procedure Sortgrid1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Loadfiles2Click(Sender: TObject);
var
  i: integer;
  filelist: TStringList;
  fname: string;
begin
  filelist := TStringList.Create;
  filelist.Add('.\cars.csv');
  filelist.Add('.\data.csv');
  filelist.Add('.\germany.csv');

  with AdvGridWorkBook1 do
  begin
    Sheets.Clear;
    Grid.SaveFixedCells := false;

    for i := 1 to filelist.Count do
    begin
      fname := ExtractFileName(filelist.Strings[i - 1]);
      if pos('.', fname) > 0 then
        delete(fname, pos('.', fname), length(fname));

      Sheets.Add.Name := fname;
      ActiveSheet := i - 1;
      Grid.LoadFromCSV(filelist.Strings[i - 1]);
      Grid.AutoNumberCol(0);
      Grid.AutoNumberRow(0);
    end;

    ActiveSheet := 0;
  end;

  filelist.Free;
end;

procedure TForm1.Sortgrid1Click(Sender: TObject);
begin
  with AdvGridWorkbook1.Grid do
  begin
    SortSettings.Column := 1;
    if SortSettings.Direction = sdAscending then
      SortSettings.Direction := sdDescending
    else
      SortSettings.Direction := sdAscending;
    QSort;
  end;
end;

end.
