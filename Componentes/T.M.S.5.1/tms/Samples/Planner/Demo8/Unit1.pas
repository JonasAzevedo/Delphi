unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Planner, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Planner1: TPlanner;
    Planner2: TPlanner;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    procedure Planner2ItemInsert(Sender: TObject; Position, FromSel,
      FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure Planner1ItemInsert(Sender: TObject; Position, FromSel,
      FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure Planner2DragOverItem(Sender, Source: TObject; X, Y: Integer;
      APlannerItem: TPlannerItem; State: TDragState; var Accept: Boolean);
    procedure Planner2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Planner2DragDropCell(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Planner2ItemInsert(Sender: TObject; Position, FromSel,
  FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  planner2.CreateItemAtSelection;
end;

procedure TForm1.Planner1ItemInsert(Sender: TObject; Position, FromSel,
  FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  planner1.CreateItemAtSelection;
end;

procedure TForm1.Planner2DragOverItem(Sender, Source: TObject; X,
  Y: Integer; APlannerItem: TPlannerItem; State: TDragState;
  var Accept: Boolean);
begin
  accept := true;
end;

procedure TForm1.Planner2DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  accept := true;
end;

procedure TForm1.Planner2DragDropCell(Sender, Source: TObject; X,
  Y: Integer);
var
  plit: tplanneritem;
  d: integer;
begin

  plit := planner2.CreateItem;
  plit.Assign(planner1.Items.Selected);
  d := plit.ItemEnd - plit.ItemBegin;
  plit.ItemBegin := y;
  plit.ItemEnd := y + d;
  plIt.ItemPos := x;
  if radiogroup1.ItemIndex = 1 then
    planner1.FreeItem(planner1.Items.Selected);
end;

end.
