program Cadastro_Emails;

uses
  Forms,
  unPrincipal in 'unPrincipal.pas' {frmCadastroEmails},
  unDM in 'unDM.pas' {DM: TDataModule},
  unConstantes in 'unConstantes.pas',
  unResumoInserirEmail in 'unResumoInserirEmail.pas' {frmResumoInseriuEmail},
  unPesquisaEmails in 'unPesquisaEmails.pas' {frmPesquisaEmails},
  unMenuPrincipal in 'unMenuPrincipal.pas' {frmPrincipal},
  unEnviarEmail in 'unEnviarEmail.pas' {frmEnviarEmail},
  unCadAreasInteresse in 'unCadAreasInteresse.pas' {frmCadAreasInteresse},
  unVariaveis in 'unVariaveis.pas',
  unExibirMeiosCaptacao in 'unExibirMeiosCaptacao.pas' {frmExibirMeiosCaptacao},
  unEditarEmail in 'unEditarEmail.pas' {frmEditarEmail},
  unAjustarCadastroEmails in 'unAjustarCadastroEmails.pas' {frmAjustarCadastroEmails},
  unResumoServidorDominiosNaoCadastrados in 'unResumoServidorDominiosNaoCadastrados.pas' {frmResumoServidorDominiosNaoCadastrados},
  unAcompanharProcesso in 'unAcompanharProcesso.pas' {frmAcompanharProcesso},
  unConfiguracoes in 'unConfiguracoes.pas' {frmConfiguracoes},
  unIniciarConiguracoes in 'unIniciarConiguracoes.pas',
  unEmail in 'unEmail.pas',
  USendMail in 'USendMail.pas' {frmSendMail},
  unFuncoes in 'unFuncoes.pas';

//  unCadMelhoriasSistema in 'unCadMelhoriasSistema.pas' {frmCadMelhoriasSistema};

{$R *.res}

var
  oConf: TIniciarConfiguracoes;

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmEnviarEmail, frmEnviarEmail);
  Application.CreateForm(TfrmSendMail, frmSendMail);
  //  Application.CreateForm(TfrmCadMelhoriasSistema, frmCadMelhoriasSistema);
  oConf := TIniciarConfiguracoes.Create;
  if oConf.ConfigurarBD then
  begin
    oConf.Destroy;
    Application.Run;
  end
  else
  begin
    oConf.Destroy;
    Application.Terminate;
  end;

end.
