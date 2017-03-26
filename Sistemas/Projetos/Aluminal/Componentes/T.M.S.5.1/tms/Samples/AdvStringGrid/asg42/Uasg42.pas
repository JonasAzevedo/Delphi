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

unit Uasg42;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, ImgList, AsgPrev
{$IFDEF VER140}
  , Variants
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    AdvStringGrid2: TAdvStringGrid;
    MergeBtn: TButton;
    Button5: TButton;
    AdvPreviewDialog1: TAdvPreviewDialog;
    Button6: TButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure FormCreate(Sender: TObject);
    procedure MergeBtnClick(Sender: TObject);
    procedure AdvStringGrid2GetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure AdvStringGrid2GetAlignment(Sender: TObject; ARow,
      ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
  private
    { Private declarations }
  public
    { Public declarations }
    sl: tstringlist;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R demo7.res}

procedure TForm1.FormCreate(Sender: TObject);
begin
  advstringgrid2.SaveFixedCells := false;
  advstringgrid2.Loadfromcsv('maincars.csv');
  advstringgrid2.SortSettings.Column := 1;
  advstringgrid2.QSort;
  advstringgrid2.AutoSizeColumns(true, 10);
end;

procedure TForm1.MergeBtnClick(Sender: TObject);
var
  i, k: Integer;
  s: array[0..5] of string;

begin
  MergeBtn.Enabled := False;
  AdvStringGrid2.MergeColumnCells(1, True);

  k := 0;

  s[0] := 'ALFA';
  s[1] := 'AUDI';
  s[2] := 'BMW';
  s[3] := 'FERRARI';
  s[4] := 'MB';
  s[5] := 'PORSCHE';

  with AdvStringGrid2 do
    for i := 1 to RowCount - 1 do
    begin
      if IsBaseCell(1, i) and (k < 6) then
      begin
        AdvStringGrid2.CreateBitmap(1, i, true, haCenter, vaAboveText).LoadFromResourceName(hinstance, s[k]);
        inc(k);
      end;
    end;

end;

procedure TForm1.AdvStringGrid2GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if ACol = 1 then
  begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if printersetupdialog1.Execute then
    AdvStringGrid2.Print;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  AdvPreviewDialog1.Execute;
end;

procedure TForm1.AdvStringGrid2GetAlignment(Sender: TObject; ARow,
  ACol: Integer; var HAlign: TAlignment; var VAlign: TVAlignment);
begin
  if ACol = 1 then
    HAlign := taCenter;
end;

end.
