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

unit Uasg3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, AdvGrid, Mask, BaseGrid;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    procedure AdvStringGrid1GetEditMask(Sender: TObject; ACol,
      ARow: Integer; var Value: string);
    procedure AdvStringGrid1AutoInsertRow(Sender: TObject; ARow: Integer);
    procedure AdvStringGrid1CellValidate(Sender: TObject; ACol, ARow: Integer;
      var Value: string; var Valid: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.AdvStringGrid1CellValidate(Sender: TObject; ACol,
  ARow: Integer; var Value: string; var Valid: Boolean);
begin
  if ACol = 0 then
    Value := Trim(Value);
end;

procedure TForm1.AdvStringGrid1GetEditMask(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  case ACol of
    0: Value := '!000;1;_';
    1: Value := '';
    2: Value := '!000;1;_';
    3: Value := '!99/99/00;1;_';
    4: Value := '!90:00;1;_';
  end;
end;

procedure TForm1.AdvStringGrid1AutoInsertRow(Sender: TObject;
  ARow: Integer);
var
  i: Integer;
begin
  with AdvStringGrid1 do
  begin
    if (Cells[0, ARow - 1] <> '') and (ARow > 1) then
      i := Ints[0, ARow - 1]
    else
      i := 0;

    Cells[0, ARow] := Inttostr(i + 1);
  end;
end;

end.
