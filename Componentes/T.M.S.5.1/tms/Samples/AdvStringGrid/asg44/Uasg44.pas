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

unit Uasg44;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, ImgList, StdCtrls
{$IFDEF VER140}
  , Variants
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1GetDisplText(Sender: TObject; ACol,
      ARow: Integer; var Value: string);
    procedure AdvStringGrid1CellValidate(Sender: TObject; Col,
      Row: Integer; var Value: string; var Valid: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateSums;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  AdvStringGrid1.RandomFill(false, 1000);
  UpdateSums;
end;

procedure TForm1.AdvStringGrid1GetDisplText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  if (Arow = AdvStringgrid1.Rowcount - 1) and (ACol > 0) then
    Value := '<b>' + value + '</B>';
end;

procedure TForm1.AdvStringGrid1CellValidate(Sender: TObject; Col,
  Row: Integer; var Value: string; var Valid: Boolean);
begin
  UpdateSums;
end;

procedure TForm1.UpdateSums;
var
  i: Integer;
begin
  for i := 1 to AdvStringGrid1.ColCount - 1 do
    AdvStringGrid1.Floats[i, AdvStringGrid1.RowCount - 1] :=
      AdvStringGrid1.ColumnSum(i, 1, AdvStringGrid1.RowCount - 2);
  AdvStringGrid1.FloatingFooter.Invalidate;
end;

end.
