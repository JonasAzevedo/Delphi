unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, PlannerWaitList, Planner;

type
  TForm1 = class(TForm)
    Planner1: TPlanner;
    PlannerWaitList1: TPlannerWaitList;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure Planner1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Planner1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Planner1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (source is tplannerwaitlist);
end;

procedure TForm1.Planner1DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if (source is tplannerwaitlist) then
  begin
    (source as tplannerwaitlist).movetoplanner(planner1,(source as TPlannerWaitlist).itemIndex,x,y);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 5 do
  begin
    with plannerwaitlist1.Items.Add do
    begin
      text.Text := 'item '+inttostr(i);
      itemend := itembegin + i;
    end;
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with PlannerWaitList1.Items.Add do
  begin
    Text.Text := 'Dynamic created';
    ItemBegin := 10;
    ItemEnd := 15;
    Color := clLime;
    ColorTo := clNone;
  end;
end;

end.
