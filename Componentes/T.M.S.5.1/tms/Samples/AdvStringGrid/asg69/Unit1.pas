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
  Dialogs, Grids, BaseGrid, AdvGrid, AdvStickyPopupMenu, Menus, AdvMenus,
  AdvMenuStylers, ImgList;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    AdvStickyPopupMenu1: TAdvStickyPopupMenu;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1FixedDropDownClick(Sender: TObject; ACol,
      ARow: Integer; var AMenu: TPopupMenu; var KeepFixedCellHighlighted: boolean);
    procedure AdvStickyPopupMenu1CheckClick(Sender: TObject; Index: Integer; Checked: boolean);
    procedure AdvStickyPopupMenu1ItemClick(Sender: TObject; Index: Integer);
    procedure AdvStickyPopupMenu1MenuHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FilterColumn: integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.AdvStickyPopupMenu1CheckClick(Sender: TObject; Index: Integer; Checked: boolean);
var
  fltr: string;

  function AppendFilter(s: string): string;
  begin
    if fltr = '' then
      fltr := s
    else
      fltr := fltr + ' | ' + s;
  end;


begin
  if Index in [0..3] then
  begin
    fltr := '';
    advstringgrid1.FilterActive := false;
    AdvStringGrid1.Filter.Clear;

    if AdvStickyPopupMenu1.MenuItems[0].Checked then
      AppendFilter('(<=25)');

    if AdvStickyPopupMenu1.MenuItems[1].Checked then
      AppendFilter('(>25 & <=50)');

    if AdvStickyPopupMenu1.MenuItems[2].Checked then
      AppendFilter('(>50 & <=75)');

    if AdvStickyPopupMenu1.MenuItems[3].Checked then
      AppendFilter('(>75 & <=100)');

    if fltr <> '' then
    begin
      with advstringgrid1.Filter.Add do
      begin
        condition := fltr;
        column := FilterColumn;
      end;
      AdvStringGrid1.FilterActive := true;
    end;
  end;
end;

procedure TForm1.AdvStickyPopupMenu1ItemClick(Sender: TObject; Index: Integer);
begin
  if Index = 5 then
    advstringgrid1.Sort(FilterColumn, sdAscending);
  if Index = 6 then
    advstringgrid1.Sort(FilterColumn, sdDescending);
end;

procedure TForm1.AdvStickyPopupMenu1MenuHide(Sender: TObject);
begin
  advstringgrid1.ResetFixedCellHighlight;
end;

procedure TForm1.AdvStringGrid1FixedDropDownClick(Sender: TObject; ACol,
  ARow: Integer; var AMenu: TPopupMenu; var KeepFixedCellHighlighted: boolean);
var
  r: TRect;
  pt: TPoint;
begin
  r := advstringgrid1.CellRect(ACol, ARow);
  pt := Advstringgrid1.ClientToScreen(Point(r.Right - 16, r.Bottom));
  FilterColumn := ACol;
  AdvStickyPopupMenu1.ShowMenu(pt.X, pt.y);
  KeepFixedCellHighlighted := true;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  advstringgrid1.RandomFill(false, 100);
  advstringgrid1.SortSettings.Show := true;
  advstringgrid1.FixedRowAlways := true;
  for i := 1 to advstringgrid1.ColCount - 1 do
    advstringgrid1.Cells[i, 0] := 'Col ' + inttostr(i);
end;

end.
