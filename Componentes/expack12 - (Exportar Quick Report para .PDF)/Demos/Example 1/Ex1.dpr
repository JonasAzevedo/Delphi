program Ex1;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Report in 'Report.pas' {Rep: TQuickRep},
  PreviewQR in 'PreviewQR.pas' {FPreviewQR};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TRep, Rep);
  Application.CreateForm(TFPreviewQR, FPreviewQR);
  Application.Run;
end.
