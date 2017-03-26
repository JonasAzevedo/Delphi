program Ex2;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  PreviewFR in 'PreviewFR.pas' {FPreviewFR};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFPreviewFR, FPreviewFR);
  Application.Run;
end.
