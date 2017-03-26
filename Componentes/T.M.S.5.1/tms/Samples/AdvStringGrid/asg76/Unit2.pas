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

unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Grids, BaseGrid, AdvGrid;

type
  TForm2 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure AdvStringGrid1CellBalloon(Sender: TObject; ACol, ARow: Integer;
      var ATitle, AText: string; var AIcon: Integer);
    procedure FormCreate(Sender: TObject);
    procedure AdvStringGrid1CellValidate(Sender: TObject; ACol, ARow: Integer;
      var Value: string; var Valid: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.AdvStringGrid1CellBalloon(Sender: TObject; ACol, ARow: Integer;
  var ATitle, AText: string; var AIcon: Integer);
begin
  if (acol = 1) and (arow = 1) then
  begin
    ATitle := 'Hello';
    AText := 'I am cell 1,1';
  end;
end;

procedure TForm2.AdvStringGrid1CellValidate(Sender: TObject; ACol,
  ARow: Integer; var Value: string; var Valid: Boolean);
begin
  if length(value) < 3 then
  begin
    advstringgrid1.InvalidEntryTitle := 'Input error';
    Advstringgrid1.InvalidEntryText := 'Entry not sufficiently long';
    Valid := false;
  end;

  if length(value) > 5 then
  begin
    advstringgrid1.InvalidEntryTitle := 'Input error';
    Advstringgrid1.InvalidEntryText := 'Entry is too long';
    Valid := false;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  advstringgrid1.Options :=  advstringgrid1.Options+ [goEditing];
  advstringgrid1.AddBalloon(2,2,'Title A','Cell 2,2 is here', biError);
  advstringgrid1.AddBalloon(3,3,'Title B','Cell 3,3 is here', biWarning);
end;

end.
