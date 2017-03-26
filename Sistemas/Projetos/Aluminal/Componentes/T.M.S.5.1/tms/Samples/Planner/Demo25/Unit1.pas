unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, PlannerMonthView, MyMonthPlanner, StdCtrls;

type
  TForm1 = class(TForm)
    MyMonthPlannerView1: TMyMonthPlannerView;
    Button1: TButton;
    Label1: TLabel;
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

procedure TForm1.Button1Click(Sender: TObject);
begin
  with TMyMonthPlannerItem(MyMonthPlannerView1.CreateItem) do
  begin
    MyProperty := 'New property';
    ItemStartTime := Now;
    ItemEndTime := Now + 1;
  end;      


end;

end.
