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

unit Uasg38;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, ComCtrls, ImgList
{$IFDEF VER140}
  , Variants
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    GroupBtn: TButton;
    Button3: TButton;
    Button4: TButton;
    ImageList1: TImageList;
    UnGroupBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure GroupBtnClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure AdvStringGrid1GetCellColor(Sender: TObject; ARow,
      ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure UnGroupBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    IsGrouped: Boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  AdvStringGrid1.SaveFixedCells := false;
  AdvStringGrid1.LoadFromCSV('cars.csv');
  AdvStringGrid1.AddImageIdx(2, 2, 0, haBeforeText, vaTop);
  AdvStringGrid1.AddImageIdx(2, 3, 1, haBeforeText, vaTop);
  AdvStringGrid1.AddImageIdx(2, 4, 2, haBeforeText, vaTop);
end;

procedure TForm1.GroupBtnClick(Sender: TObject);
var
  i: Integer;
begin
  AdvStringGrid1.InsertCols(0, 1);
  AdvStringGrid1.ColWidths[0] := 20;
  AdvStringGrid1.Group(1);
  UnGroupBtn.Enabled := True;
  GroupBtn.Enabled := False;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  AdvStringGrid1.ExpandAll;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  AdvStringGrid1.ContractAll;
end;

procedure TForm1.AdvStringGrid1GetCellColor(Sender: TObject; ARow,
  ACol: Integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
begin
  if advstringgrid1.IsNode(ARow) then
  begin
    afont.Style := [fsBold];
    abrush.color := clGray;
    afont.Color := clWhite;
  end;
end;

procedure TForm1.UnGroupBtnClick(Sender: TObject);
var
  i: Integer;
begin
  AdvStringGrid1.ExpandAll;
  AdvStringGrid1.UnGroup;
  AdvStringGrid1.RemoveCols(0, 1);
  UnGroupBtn.Enabled := False;
  GroupBtn.Enabled := True;
end;

end.
