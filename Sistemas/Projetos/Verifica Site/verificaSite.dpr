program verificaSite;

uses
  Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  unDM in 'unDM.pas' {DM: TDataModule},
  unCadastroSite in 'unCadastroSite.pas' {frmCadastroSite},
  unCadastroEmail in 'unCadastroEmail.pas' {frmCadastroEmails},
  unTeste in 'unTeste.pas' {Form1},
  unSelecionaEmailEnviar in 'unSelecionaEmailEnviar.pas' {frmSelecionaEmailEnviar};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
