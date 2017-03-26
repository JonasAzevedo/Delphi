program AdvChartwithListBox;

uses
  Forms,
  UlbChart in 'UlbChart.pas' {Form65};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm65, Form65);
  Application.Run;
end.
