program BugriLoteria;

uses
  Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  unLotoFacil in 'unLotoFacil.pas' {frmCadastroLotoFacil},
  unDM in 'unDM.pas' {DM: TDataModule},
  unCapturarNumerosSite in 'unCapturarNumerosSite.pas' {frmCapturarNumerosSite},
  unDefinicaoJogos in 'unDefinicaoJogos.pas',
  unImportaCSV_LotoFacil in 'unImportaCSV_LotoFacil.pas' {frmImportaDadosLotoFacil},
  unDiferencaOcorrenciaNumeroSorteio in 'unDiferencaOcorrenciaNumeroSorteio.pas' {frmDiferencaOcorrenciaNumerosSorteios},
  unVerificaOcorrenciaSorteio in 'unVerificaOcorrenciaSorteio.pas' {frmVerificaOcorrenciaSorteio},
  unOcorrenciasSorteio in 'unOcorrenciasSorteio.pas' {frmOcorrenciasSorteio},
  unSobre in 'unSobre.pas' {frmSobre},
  unApostaLotoFacil in 'unApostaLotoFacil.pas' {frmApostaLotoFacil};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'TIME MONEY';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCadastroLotoFacil, frmCadastroLotoFacil);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmImportaDadosLotoFacil, frmImportaDadosLotoFacil);
  Application.CreateForm(TfrmDiferencaOcorrenciaNumerosSorteios, frmDiferencaOcorrenciaNumerosSorteios);
  Application.CreateForm(TfrmVerificaOcorrenciaSorteio, frmVerificaOcorrenciaSorteio);
  Application.CreateForm(TfrmOcorrenciasSorteio, frmOcorrenciasSorteio);
  Application.CreateForm(TfrmSobre, frmSobre);
  Application.CreateForm(TfrmApostaLotoFacil, frmApostaLotoFacil);
  Application.Run;
end.
