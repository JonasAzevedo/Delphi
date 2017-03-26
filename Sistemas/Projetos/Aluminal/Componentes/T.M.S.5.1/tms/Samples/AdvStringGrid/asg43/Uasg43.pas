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

unit Uasg43;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, ComCtrls, ExtCtrls
{$IFDEF VER140}
  , Variants
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1GetCellBorder(Sender: TObject; ARow,
      ACol: Integer; APen: TPen; var Borders: TCellBorders);
    procedure AdvStringGrid1GetCellBorderProp(Sender: TObject; ARow,
      ACol: Integer; LeftPen, TopPen, RightPen, BottomPen: TPen);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  AdvStringGrid1.RandomFill(false, 100);
end;

procedure TForm1.AdvStringGrid1GetCellBorder(Sender: TObject; ARow,
  ACol: Integer; APen: TPen; var Borders: TCellBorders);
begin
  if not Odd(ACol) and (ARow > 0) and (ACol > 0) then
  begin
    Borders := [cbLeft];
    APen.Width := 1;
    APen.Color := clBlack;
  end;

  if not Odd(ARow) and (ARow > 0) and (ACol > 0) then
  begin
    Borders := Borders + [cbBottom];
    APen.Width := 1;
    APen.Color := clBlack;
  end;

end;

procedure TForm1.AdvStringGrid1GetCellBorderProp(Sender: TObject; ARow,
  ACol: Integer; LeftPen, TopPen, RightPen, BottomPen: TPen);
begin
  LeftPen.Color := clBlue;

  BottomPen.Color := clRed;
end;

end.
