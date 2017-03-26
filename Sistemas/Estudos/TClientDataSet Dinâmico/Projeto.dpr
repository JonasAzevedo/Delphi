program Projeto;

uses
  Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
