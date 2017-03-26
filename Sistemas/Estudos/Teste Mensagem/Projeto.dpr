program Projeto;

uses
  Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  UMessageStr in 'UMessageStr.pas',
  unThread in 'unThread.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
