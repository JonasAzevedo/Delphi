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

unit Uasg36;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, StdCtrls, ExtCtrls
{$IFDEF VER140}
  , Variants
{$ENDIF}
  ;

type
  TForm1 = class(TForm)
    AdvStringGrid1: TAdvStringGrid;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
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
  AdvStringGrid1.AddCheckBox(1, 1, False, False);
  AdvStringGrid1.AddCheckBox(1, 2, True, False);
  AdvStringGrid1.Cells[1, 1] := 'Coupe';
  AdvStringGrid1.Cells[1, 2] := 'Roadster';

  with AdvStringGrid1.CreateRadio(2, 1, 0, 0) do
  begin
    Add('BMW');
    Add('Audi');
    Add('Porsche');
  end;

  with AdvStringGrid1.CreateRadio(2, 2, 0, 0) do
  begin
    Add('Mercedes');
    Add('Ferrari');
    Add('VW');
  end;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin

  if RadioGroup1.ItemIndex in [2] then
    AdvStringGrid1.ControlLook.CheckSize := 12
  else
    AdvStringGrid1.ControlLook.CheckSize := 16;

  case RadioGroup1.ItemIndex of
    0: AdvStringGrid1.ControlLook.ControlStyle := csClassic;
    1: AdvStringGrid1.ControlLook.ControlStyle := csFlat;
    2: AdvStringGrid1.ControlLook.ControlStyle := csBorland;
    3: AdvStringGrid1.ControlLook.ControlStyle := csTMS;
    4: AdvStringGrid1.ControlLook.ControlStyle := csGlyph;
    5: AdvStringGrid1.ControlLook.ControlStyle := csWinXP;
    6: AdvStringGrid1.ControlLook.ControlStyle := csTheme;
  end;
end;

end.
