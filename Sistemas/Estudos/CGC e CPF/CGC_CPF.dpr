program CGC_CPF;

uses
  Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  unFuncoes in 'unFuncoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
