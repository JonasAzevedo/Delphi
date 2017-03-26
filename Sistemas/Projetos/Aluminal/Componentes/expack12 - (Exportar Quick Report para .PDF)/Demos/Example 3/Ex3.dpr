program Ex3;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Report in 'Report.pas' {Rep: TQuickRep};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TRep, Rep);
  Application.Run;
end.
