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

unit uasg20;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, AdvGrid, StdCtrls, ComCtrls, ImgList, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure AdvStringGrid1GetFormat(Sender: TObject; ACol: Integer;
      var AStyle: TSortStyle; var aPrefix, aSuffix: string);
    procedure AdvStringGrid1CanSort(Sender: TObject; aCol: Integer;
      var dosort: Boolean);
    procedure AdvStringGrid1ClickSort(Sender: TObject; aCol: Integer);
  private
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
    for i := FixedRows to Rowcount - 1 do
      for j := FixedCols to ColCount - 1 do
        cells[j, i] := '<IMG src="idx:' + inttostr((i + j) mod 3) + '">This is <FONT color="clred">cell</FONT> <B>[' + inttostr(j) + ':' + inttostr(i) + ']</B>';

    autosizecolumns(false, 10);
    autonumbercol(0);
  end;
end;

procedure TForm1.AdvStringGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  r, c: integer;
begin
  advstringgrid1.mousetocell(x, y, c, r);
  if (c >= 0) and (r >= 0) then
    statusbar1.simpletext := advstringgrid1.strippedcells[c, r];
end;

procedure TForm1.AdvStringGrid1GetFormat(Sender: TObject; ACol: Integer;
  var AStyle: TSortStyle; var aPrefix, aSuffix: string);
begin
  if checkbox1.checked then aStyle := ssAlphabetic else aStyle := ssHtml;
end;

procedure TForm1.AdvStringGrid1CanSort(Sender: TObject; aCol: Integer;
  var dosort: Boolean);
begin
  advstringgrid1.cursor := crHourGlass;
end;

procedure TForm1.AdvStringGrid1ClickSort(Sender: TObject; aCol: Integer);
begin
  advstringgrid1.cursor := crDefault;
end;

end.
