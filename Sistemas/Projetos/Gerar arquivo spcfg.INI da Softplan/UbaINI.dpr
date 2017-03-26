program UbaINI;

uses
  Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  unConstantes in 'unConstantes.pas',
  unFuncoes in 'unFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
