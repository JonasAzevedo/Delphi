unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Planner;

type
  TForm1 = class(TForm)
    Planner1: TPlanner;
    Button1: TButton;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  planner1.DateTimeList.Add(encodetime(9,45,0,0));
  planner1.DateTimeList.Add(encodetime(10,10,0,0));
  planner1.DateTimeList.Add(encodetime(10,35,0,0));
  planner1.DateTimeList.Add(encodetime(11,00,0,0));
  planner1.DateTimeList.Add(encodetime(11,25,0,0));
  planner1.DateTimeList.Add(encodetime(11,50,0,0));
  planner1.DateTimeList.Add(encodetime(12,15,0,0));
  planner1.DateTimeList.Add(encodetime(12,40,0,0));
  planner1.DateTimeList.Add(encodetime(13,05,0,0));
  planner1.DateTimeList.Add(encodetime(13,30,0,0));
  planner1.DateTimeList.Add(encodetime(13,55,0,0));
  planner1.DateTimeList.Add(encodetime(14,20,0,0));
  planner1.DateTimeList.Add(encodetime(14,45,0,0));
  planner1.DateTimeList.Add(encodetime(15,10,0,0));
  planner1.DateTimeList.Add(encodetime(15,35,0,0));
  planner1.DateTimeList.Add(encodetime(16,00,0,0));
  planner1.DateTimeList.Add(encodetime(16,25,0,0));
  planner1.DateTimeList.Add(encodetime(16,50,0,0));
  planner1.DateTimeList.Add(encodetime(17,15,0,0));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with planner1.CreateItem do
  begin
    itemstarttime := encodetime(11,0,0,0);
    itemendtime := encodetime(11,25,0,0);
    text.Text := 'test 1';
  end;
  with planner1.CreateItem do
  begin
    itemstarttime := encodetime(16,25,0,0);
    itemendtime := encodetime(16,50,0,0);
    text.Text := 'test 2';
  end;
  with planner1.CreateItem do
  begin
    itemstarttime := encodetime(13,05,0,0);
    itemendtime := encodetime(14,20,0,0);
    text.Text := 'test 3';
  end;
end;

end.
