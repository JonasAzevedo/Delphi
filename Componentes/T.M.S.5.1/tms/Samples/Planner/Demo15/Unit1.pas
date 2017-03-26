unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Planner, PlanExOutlook, StdCtrls;

type
  TForm1 = class(TForm)
    PlannerOutlookExchange1: TPlannerOutlookExchange;
    Planner1: TPlanner;
    Button1: TButton;
    Label1: TLabel;
    lblApptCount: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    Button2: TButton;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure PlannerOutlookExchange1AcceptAppointment(Sender: TObject;
      Appointment: Variant; var Accept: Boolean);
    procedure PlannerOutlookExchange1AppointmentToItem(Sender: TObject;
      Appointment: Variant; Item: TPlannerItem);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  planner1.Items.BeginUpdate;
  PlannerOutlookExchange1.DoImport;
  planner1.Items.EndUpdate;
end;

procedure TForm1.PlannerOutlookExchange1AcceptAppointment(Sender: TObject;
  Appointment: Variant; var Accept: Boolean);
begin
  listbox1.items.Add(appointment.subject+' : ' + appointment.body);
  lblApptCount.Caption := IntToStr(StrToInt(lblApptCount.Caption) + 1);
  application.ProcessMessages;
end;

procedure TForm1.PlannerOutlookExchange1AppointmentToItem(Sender: TObject;
  Appointment: Variant; Item: TPlannerItem);
begin
  item.CaptionType := ctText;
  item.Alignment := taCenter;
  item.CaptionAlign := taCenter;
  item.CaptionBkg := clRed;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i:integer;
begin
  if Assigned(Planner1.Items.Selected) then
  begin
    for i := 1 to planner1.Items.Count do
      planner1.Items[i - 1].DoExport := false;

    planner1.Items.Selected.DoExport := true;

    PlannerOutlookExchange1.DoExport;

  end
  else
    ShowMessage('Sorry, no items selected');
end;

end.
