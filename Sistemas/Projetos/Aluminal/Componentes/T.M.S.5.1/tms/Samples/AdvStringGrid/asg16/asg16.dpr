program asg16;

uses
  Forms,
  uasg16 in 'uasg16.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
