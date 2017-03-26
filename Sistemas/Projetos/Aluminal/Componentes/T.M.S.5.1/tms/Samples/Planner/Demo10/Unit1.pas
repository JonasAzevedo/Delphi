unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Planner, StdCtrls, ComCtrls
  {$IFDEF VER150}
  , XPMan
  {$ENDIF}
  ;

type
  TForm1 = class(TForm)
    Planner1: TPlanner;
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Planner1ItemInsert(Sender: TObject; Position, FromSel,
      FromSelPrecise, ToSel, ToSelPrecise: Integer);
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
var
  i: integer;
begin
  if Planner1.Selections.Count = 0 then
    planner1.CreateItemAtSelection
  else
  begin
  planner1.Items.BeginUpdate;
  for i := 1 to Planner1.Selections.Count do
  begin
    with Planner1.Items.Add do
    begin
      itembegin := Planner1.Selections[i - 1].SelBegin;
      itemend := Planner1.Selections[i - 1].SelEnd;
      itempos := Planner1.Selections[i - 1].SelPos;
    end;
  end;
  planner1.Selections.Clear;
  planner1.Items.EndUpdate;
  end;
end;

procedure TForm1.Planner1ItemInsert(Sender: TObject; Position, FromSel,
  FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  planner1.CreateItemAtSelection;
end;

end.
