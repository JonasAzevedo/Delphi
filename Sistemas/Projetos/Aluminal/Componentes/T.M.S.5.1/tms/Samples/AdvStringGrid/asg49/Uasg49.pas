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

unit Uasg49;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    Button1: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AdvStringGrid1AutoInsertRow(Sender: TObject; ARow: Integer);
    procedure AdvStringGrid1AutoDeleteRow(Sender: TObject; ARow: Integer);
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
  AdvStringGrid1.FloatingFooter.ColumnCalc[0] := acCount;
  AdvStringGrid1.FloatingFooter.ColumnCalc[1] := acSum;
  AdvStringGrid1.FloatingFooter.ColumnCalc[2] := acAvg;
  AdvStringGrid1.FloatingFooter.ColumnCalc[3] := acMin;
  AdvStringGrid1.FloatingFooter.ColumnCalc[4] := acMax;
  AdvStringGrid1.RandomFill(False, 100);
  AdvstringGrid1.AutoNumberCol(0);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  AdvStringGrid1.RandomFill(false, 100)
end;

procedure TForm1.AdvStringGrid1AutoInsertRow(Sender: TObject;
  ARow: Integer);
begin
  AdvstringGrid1.AutoNumberCol(0);
end;

procedure TForm1.AdvStringGrid1AutoDeleteRow(Sender: TObject;
  ARow: Integer);
begin
  AdvstringGrid1.AutoNumberCol(0);
end;

end.
