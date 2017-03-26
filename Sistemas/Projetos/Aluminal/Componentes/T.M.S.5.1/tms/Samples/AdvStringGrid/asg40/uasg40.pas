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

unit uasg40;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls
{$IFDEF VER140}
  , Variants
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1GetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Advstringgrid1.UnSortedCells[1, 12] := TimeToStr(Now);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  AdvStringGrid1.SaveFixedCells := False;
  AdvStringGrid1.LoadFromCSV('cars.csv');
  AdvStringGrid1.SortSettings.Show := True;
  AdvStringGrid1.InitSortXRef;
  AdvStringGrid1.AutoNumberCol(0);
  AdvStringGrid1.AutoSizeColumns(False, 10);
end;

procedure TForm1.AdvStringGrid1GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if (AdvStringGrid1.SortedRowIndex(ARow) in [12..29]) and (ACol > 0) then
  begin
    AFont.Style := [fsBold];
    AFont.Color := clBlue;
  end;
end;

end.
