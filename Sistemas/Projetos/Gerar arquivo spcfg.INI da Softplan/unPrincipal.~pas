unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, plsComboBox, IniFiles, unFuncoes, plsEdit, ComCtrls,
  Buttons;

type
    TDadosConf = record
      sTipoBanco: String;
      sBasesDB2: String;
      sBasesOracle: String;
      sBasesMSQServer: String;
      sNomeArquivoSaida: String;
      sDiretorioSaida: String;
    end;

type
  TfrmPrincipal = class(TForm)
    plsCbBxTipoBanco: TPlsComboBox;
    plsCbBxBaseDados: TPlsComboBox;
    lblTipoBanco: TLabel;
    lblBaseDados: TLabel;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    lblLotacao: TLabel;
    plsEdUsuario: TPlsEdit;
    plsEdSenha: TPlsEdit;
    plsEdLotacao: TPlsEdit;
    grpBxLocalSaida: TGroupBox;
    lblNome: TLabel;
    lblDiretorio: TLabel;
    plsEdDiretorio: TPlsEdit;
    plsEdNome: TPlsEdit;
    PageControl: TPageControl;
    tbSheetServidor: TTabSheet;
    lblGUIDServidor: TLabel;
    plsEdGUIDServidor: TPlsEdit;
    lblNomeServidor: TLabel;
    plsEdNomeServidor: TPlsEdit;
    lblUsuarioConexaoPro: TLabel;
    plsEdUsuarioConexaoPro: TPlsEdit;
    lblSenhaConexaoPro: TLabel;
    plsEdSenhaConexaoPro: TPlsEdit;
    lblUsuarioConexaoSGC: TLabel;
    plsEdUsuarioConexaoSGC: TPlsEdit;
    lblSenhaConexaoSGC: TLabel;
    plsEdSenhaConexaoSGC: TPlsEdit;
    lblNomeComputador: TLabel;
    plsEdNomeComputador: TPlsEdit;
    lblTipoConexao: TLabel;
    plsEdTipoConexao: TPlsEdit;
    lblPorta: TLabel;
    plsEdPorta: TPlsEdit;
    lblNomeExecutavelServidor: TLabel;
    plsEdNomeExecutavelServidor: TPlsEdit;
    lblTimeOutRequisicaoCliente: TLabel;
    lblPodeBalancear: TLabel;
    lblUsuarioConexaoEst: TLabel;
    lblDesabilitaRecalculaTotal: TLabel;
    lblSenhaConexaoEst: TLabel;
    plsEdSenhaConexaoEst: TPlsEdit;
    plsEdUsuarioConexaoEst: TPlsEdit;
    tbSheetFluxoTrabalho: TTabSheet;
    ckBxGUID_NomeServidor: TCheckBox;
    ckBxUsuarioSenhaPRO: TCheckBox;
    ckBxUsuarioSenhaSGC: TCheckBox;
    ckBxNomeComputador: TCheckBox;
    ckBxTipoConexao: TCheckBox;
    ckBxPorta: TCheckBox;
    ckBxNomeExecutavelServidor: TCheckBox;
    plsCbBxTimeOutRequisicaoCliente: TPlsComboBox;
    ckBxTimeOutRequisicaoCliente: TCheckBox;
    plsCbBxPodeBalancear: TPlsComboBox;
    ckBxPodeBalancear: TCheckBox;
    plsCbBxDesabilitaRecalculaTotal: TPlsComboBox;
    ckBxDesabilitaRecalculaTotal: TCheckBox;
    ckBxUsuarioSenhaEST: TCheckBox;
    lblUsuarioParaLogarEventosFluxo: TLabel;
    plsEdUsuarioParaLogarEventosFluxo: TPlsEdit;
    ckBxUsuarioParaLogarEventosFluxo: TCheckBox;
    tbSheetServidoresAplicacao: TTabSheet;
    lblDesenvolvimento: TLabel;
    lblNomeComputadorServidorAplicacao: TLabel;
    lblBaseTestesTJSP: TLabel;
    lblIP: TLabel;
    lblBaseHomologacaoTJSP: TLabel;
    lblBaseProducaoTJSP: TLabel;
    lblMaquinaTestesTJSP: TLabel;
    lblBaseProducaoTJSC: TLabel;
    plsEdDesenvolvimento: TPlsEdit;
    plsEdBaseTestesTJSP: TPlsEdit;
    plsEdBaseHomologacaoTJSP: TPlsEdit;
    plsEdBaseProducaoTJSP: TPlsEdit;
    plsEdMaquinaTestesTJSP: TPlsEdit;
    plsEdBaseProducaoTJSC: TPlsEdit;
    tbSheetFluxo: TTabSheet;
    lblConsultarTotalFila: TLabel;
    plsCbBxConsultarTotalFila: TPlsComboBox;
    ckBxConsultarTotalFila: TCheckBox;
    tbSheetCliente: TTabSheet;
    lblTipoSistema: TLabel;
    lblNomeSistema: TLabel;
    lblLoginAutomatico: TLabel;
    lblNovoLoginAutomatico: TLabel;
    lblUsadoParaDepurarEditorInterno: TLabel;
    lblDepurandoDraw: TLabel;
    lblResolucao: TLabel;
    lblUsadoTestesCarga: TLabel;
    lblMostraBotoEsdeTeste: TLabel;
    plsEdTipoSistema: TPlsEdit;
    plsEdNomeSistema: TPlsEdit;
    plsCbBxLoginAutomatico: TPlsComboBox;
    plsCbBxDepurandoDraw: TPlsComboBox;
    plsEdResolucao: TPlsEdit;
    plsCbBxMostraBotoEsdeTeste: TPlsComboBox;
    plsEdNovoUsuario: TPlsEdit;
    plsEdNovaSenha: TPlsEdit;
    plsEdNovaLotacao: TPlsEdit;
    lblNovoUsuario: TLabel;
    lblNovaSenha: TLabel;
    lblNovaLotacao: TLabel;
    plsEdNomeComputadorServidorAplicacao: TPlsEdit;
    ckBxNomeComputadorServidorAplicacao: TCheckBox;
    ckBxTipoSistema: TCheckBox;
    ckBxNome: TCheckBox;
    ckBxDepurandoDraw: TCheckBox;
    ckBxResolucao: TCheckBox;
    ckBxMostraBotoEsdeTeste: TCheckBox;
    tbSheetDatabase: TTabSheet;
    lblEsquema: TLabel;
    lblNumeroMaximoConexoes: TLabel;
    lblNumeroMinimoConexoes: TLabel;
    lblTempoDesconexaoConexaoInativa: TLabel;
    lblTempoAtualizacaoLogConexoes: TLabel;
    lblTipoAcessoBD: TLabel;
    plsEdEsquema: TPlsEdit;
    plsEdNumeroMaximoConexoes: TPlsEdit;
    plsEdNumeroMinimoConexoes: TPlsEdit;
    plsEdTempoDesconexaoConexaoInativa: TPlsEdit;
    plsEdTempoAtualizacaoLogConexoes: TPlsEdit;
    plsEdTipoAcessoBD: TPlsEdit;
    ckBxTempoDesconexaoConexaoInativa: TCheckBox;
    ckBxEsquema: TCheckBox;
    ckBxNumeroMaximoConexoes: TCheckBox;
    ckBxNumeroMinimoConexoes: TCheckBox;
    ckBxTempoAtualizacaoLogConexoes: TCheckBox;
    ckBxTipoAcessoBD: TCheckBox;
    upDwTempoDesconexaoConexaoInativa: TUpDown;
    upDwTempoAtualizacaoLogConexoes: TUpDown;
    upDwNumeroMaximoConexoes: TUpDown;
    upDwNumeroMinimoConexoes: TUpDown;
    Label1: TLabel;
    tbSheetLog: TTabSheet;
    lblTempoReleituraINI: TLabel;
    plsEdTempoReleituraINI: TPlsEdit;
    ckBxTempoReleituraINI: TCheckBox;
    lblRegistraLogMetodo: TLabel;
    lblTamanhoMaximoLogMetodo: TLabel;
    lblQuantidadeArquivosLogMetodo: TLabel;
    lblRegistraLogSQL: TLabel;
    ckBxRegistraLogSQL: TCheckBox;
    ckBxQuantidadeArquivosLogMetodo: TCheckBox;
    upDwQuantidadeArquivosLogMetodo: TUpDown;
    plsEdQuantidadeArquivosLogMetodo: TPlsEdit;
    ckBxTamanhoMaximoLogMetodo: TCheckBox;
    upDwTamanhoMaximoLogMetodo: TUpDown;
    plsEdTamanhoMaximoLogMetodo: TPlsEdit;
    upDwTempoReleituraINI: TUpDown;
    ckBxRegistraLogMetodo: TCheckBox;
    plsCbBxRegistraLogMetodo: TPlsComboBox;
    plsCbBxRegistraLogSQL: TPlsComboBox;
    tbSheetGeral: TTabSheet;
    lblSiglaCliente: TLabel;
    lblNomeCliente: TLabel;
    lblLogoCliente: TLabel;
    plsEdLogoCliente: TPlsEdit;
    plsEdNomeCliente: TPlsEdit;
    plsEdSiglaCliente: TPlsEdit;
    ckBxNomeCliente: TCheckBox;
    ckBxSiglaCliente: TCheckBox;
    ckBxLogoCliente: TCheckBox;
    TbSheetSpUpdate: TTabSheet;
    lblPodeAtualizar: TLabel;
    plsCbBxPodeAtualizar: TPlsComboBox;
    ckBxPodeAtualizar: TCheckBox;
    lblAlias: TLabel;
    plsEdAlias: TPlsEdit;
    lblUsuarioSpUpdate: TLabel;
    plsEdUsuarioSpUpdate: TPlsEdit;
    plsEdSenhaSpUpdate: TPlsEdit;
    lblSenhaSpUpdate: TLabel;
    plsEdEsquemaSpUpdate: TPlsEdit;
    lblEsquemaSpUpdate: TLabel;
    plsEdCDSistema: TPlsEdit;
    lblCDSistema: TLabel;
    ckBxAlias: TCheckBox;
    ckBxUsuarioSpUpdate: TCheckBox;
    ckBxSenhaSpUpdate: TCheckBox;
    ckBxEsquemaSpUpdate: TCheckBox;
    ckBxCDSistema: TCheckBox;
    TbSheetSpMonitor: TTabSheet;
    ckBxTimerLog: TCheckBox;
    upDwTimerLog: TUpDown;
    plsEdTimerLog: TPlsEdit;
    lblTimerLog: TLabel;
    lblTimerUsuarios: TLabel;
    plsEdTimerUsuarios: TPlsEdit;
    upDwTimerUsuarios: TUpDown;
    ckBxTimerUsuarios: TCheckBox;
    ckBxReleituraAutomaticaLog: TCheckBox;
    plsCbBxReleituraAutomaticaLog: TPlsComboBox;
    lblReleituraAutomaticaLog: TLabel;
    ckBxAvaliaTravamentoAutomatico: TCheckBox;
    plsCbBxAvaliaTravamentoAutomatico: TPlsComboBox;
    lblAvaliaTravamentoAutomatico: TLabel;
    ckBxPosicionaUltimoLogAutomatico: TCheckBox;
    plsCbBxPosicionaUltimoLogAutomatico: TPlsComboBox;
    lblPosicionaUltimoLogAutomatico: TLabel;
    Label2: TLabel;
    lblAtualizacaoAutomatcaUsuarios: TLabel;
    lblCarregaLogMaisRecente: TLabel;
    plsCbBxCarregaLogMaisRecente: TPlsComboBox;
    ckBxCarregaLogMaisRecente: TCheckBox;
    ckBxAtualizacaoAutomaticaUsuarios: TCheckBox;
    plsCbBxAtualizacaoAutomaticaUsuarios: TPlsComboBox;
    btBtnSalvar: TBitBtn;
    lblDiretorioLog: TLabel;
    plsEdDiretorioLog: TPlsEdit;
    ckBxDiretorioLog: TCheckBox;
    rdBtnIPDesenvolvimento: TRadioButton;
    rdBtnIPBaseTestesTJSP: TRadioButton;
    rdBtnIPBaseHomologacaoTJSP: TRadioButton;
    rdBtnIPBaseProducaoTJSP: TRadioButton;
    rdBtnIPMaquinaTestesTJSP: TRadioButton;
    rdBtnIPBaseProducaoTJSC: TRadioButton;
    rdBtnLoginAutomatico: TRadioButton;
    rdBtnNovoLoginAutomatico: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure plsCbBxTipoBancoChange(Sender: TObject);
    procedure btBtnSalvarClick(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
    oDadosConf: TDadosConf;
    oIniConfDados: TIniFile;//arquivo .INI que contém os dados com as opções disponíveis
    FoLstNovoINI: TStringList;

    procedure CarregarTelaDadosDisponiveis;
    procedure DefinirEventoCheckBox;
    procedure EventoClickSelecao(Sender: TObject);
    procedure HabilitarDesabilitarComponentes(pnTabSheet: Integer);
    function VerificarPodeSalvarINI: Boolean;
    procedure GerarArquivoINI;
  public
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses unConstantes;

{$R *.dfm}

(* início procedimentos auxiliares *)
procedure TfrmPrincipal.DefinirEventoCheckBox;
var
  i:Integer;
begin
  for i:=0 to frmPrincipal.ComponentCount-1 do
  begin
    if (frmPrincipal.Components[i] is TCheckBox) then
      (frmPrincipal.Components[i] as TCheckBox).OnClick := EventoClickSelecao
    else if (frmPrincipal.Components[i] is TRadioButton) then
      (frmPrincipal.Components[i] as TRadioButton).OnClick := EventoClickSelecao;
  end;
end;

procedure TfrmPrincipal.EventoClickSelecao(Sender: TObject);
var
  i: Integer;
begin
  i := NUMERO_NULO;
  if (Sender is TCheckBox)then
  begin
    if((Sender as TCheckBox).Parent = tbSheetServidor) then
      i := nTBSHEET_SERVIDOR
    else if((Sender as TCheckBox).Parent = tbSheetFluxoTrabalho) then
      i := nTBSHEET_FLUXOTRABALHO
    else if((Sender as TCheckBox).Parent = tbSheetServidoresAplicacao) then
      i := nTBSHEET_SERVIDORES_APLICACAO
    else if((Sender as TCheckBox).Parent = tbSheetFluxo) then
      i := nTBSHEET_FLUXO
    else if((Sender as TCheckBox).Parent = tbSheetCliente) then
      i := nTBSHEET_CLIENTE
    else if((Sender as TCheckBox).Parent = tbSheetDatabase) then
      i := nTBSHEET_DATABASE
    else if((Sender as TCheckBox).Parent = tbSheetLog) then
      i := nTBSHEET_LOG
    else if((Sender as TCheckBox).Parent = tbSheetGeral) then
      i := nTBSHEET_GERAL
    else if((Sender as TCheckBox).Parent = TbSheetSpUpdate) then
      i := nTBSHEET_SP_UPDATE
    else if((Sender as TCheckBox).Parent = TbSheetSpMonitor) then
      i := nTBSHEET_SP_MONITOR;
  end
  else if (Sender is TRadioButton)then
  begin
    if((Sender as TRadioButton).Parent = tbSheetServidoresAplicacao) then
      i := nTBSHEET_SERVIDORES_APLICACAO
    else if((Sender as TRadioButton).Parent = tbSheetCliente) then
      i := nTBSHEET_CLIENTE;
  end;

  if(i <> NUMERO_NULO)then
    HabilitarDesabilitarComponentes(i);
end;

procedure TfrmPrincipal.HabilitarDesabilitarComponentes(pnTabSheet: Integer);
begin
  case pnTabSheet of
    nTBSHEET_SERVIDOR:
    begin
      plsEdGUIDServidor.Enabled := ckBxGUID_NomeServidor.Checked;
      plsEdNomeServidor.Enabled := ckBxGUID_NomeServidor.Checked;
      plsEdUsuarioConexaoPro.Enabled := ckBxUsuarioSenhaPRO.Checked;
      plsEdSenhaConexaoPro.Enabled := ckBxUsuarioSenhaPRO.Checked;
      plsEdUsuarioConexaoSGC.Enabled := ckBxUsuarioSenhaSGC.Checked;
      plsEdSenhaConexaoSGC.Enabled := ckBxUsuarioSenhaSGC.Checked;
      plsEdNomeComputador.Enabled := ckBxNomeComputador.Checked;
      plsEdTipoConexao.Enabled := ckBxTipoConexao.Checked;
      plsEdPorta.Enabled := ckBxPorta.Checked;
      plsEdNomeExecutavelServidor.Enabled := ckBxNomeExecutavelServidor.Checked;
      plsCbBxTimeOutRequisicaoCliente.Enabled := ckBxTimeOutRequisicaoCliente.Checked;
      plsCbBxPodeBalancear.Enabled := ckBxPodeBalancear.Checked;
      plsCbBxDesabilitaRecalculaTotal.Enabled := ckBxDesabilitaRecalculaTotal.Checked;
      plsEdUsuarioConexaoEst.Enabled := ckBxUsuarioSenhaEST.Checked;
      plsEdSenhaConexaoEst.Enabled := ckBxUsuarioSenhaEST.Checked;
    end;
    nTBSHEET_FLUXOTRABALHO:
    begin
      plsEdUsuarioParaLogarEventosFluxo.Enabled := ckBxUsuarioParaLogarEventosFluxo.Checked;
    end;
    nTBSHEET_SERVIDORES_APLICACAO:
    begin
      plsEdNomeComputadorServidorAplicacao.Enabled := ckBxNomeComputadorServidorAplicacao.Checked;
      plsEdDesenvolvimento.Enabled := rdBtnIPDesenvolvimento.Checked;
      plsEdBaseTestesTJSP.Enabled := rdBtnIPBaseTestesTJSP.Checked;
      plsEdBaseHomologacaoTJSP.Enabled := rdBtnIPBaseHomologacaoTJSP.Checked;
      plsEdBaseProducaoTJSP.Enabled := rdBtnIPBaseProducaoTJSP.Checked;
      plsEdMaquinaTestesTJSP.Enabled := rdBtnIPMaquinaTestesTJSP.Checked;
      plsEdBaseProducaoTJSC.Enabled := rdBtnIPBaseProducaoTJSC.Checked;
    end;
    nTBSHEET_FLUXO:
    begin
      plsCbBxConsultarTotalFila.Enabled := ckBxConsultarTotalFila.Checked;
    end;
    nTBSHEET_CLIENTE:
    begin
      plsEdTipoSistema.Enabled := ckBxTipoSistema.Checked;
      plsEdNomeSistema.Enabled := ckBxNome.Checked;
      plsCbBxLoginAutomatico.Enabled := rdBtnLoginAutomatico.Checked;
      plsEdNovoUsuario.Enabled := rdBtnNovoLoginAutomatico.Checked;
      plsEdNovaSenha.Enabled := rdBtnNovoLoginAutomatico.Checked;
      plsEdNovaLotacao.Enabled := rdBtnNovoLoginAutomatico.Checked;
      plsCbBxDepurandoDraw.Enabled := ckBxDepurandoDraw.Checked;
      plsEdResolucao.Enabled := ckBxResolucao.Checked;
      plsCbBxMostraBotoEsdeTeste.Enabled := ckBxMostraBotoEsdeTeste.Checked;
    end;
    nTBSHEET_DATABASE:
    begin
      plsEdEsquema.Enabled := ckBxEsquema.Checked;
      plsEdNumeroMaximoConexoes.Enabled := ckBxNumeroMaximoConexoes.Checked;
      upDwNumeroMaximoConexoes.Enabled := ckBxNumeroMaximoConexoes.Checked;
      plsEdNumeroMinimoConexoes.Enabled := ckBxNumeroMinimoConexoes.Checked;
      upDwNumeroMinimoConexoes.Enabled := ckBxNumeroMinimoConexoes.Checked;
      plsEdTempoDesconexaoConexaoInativa.Enabled := ckBxTempoDesconexaoConexaoInativa.Checked;
      upDwTempoDesconexaoConexaoInativa.Enabled := ckBxTempoDesconexaoConexaoInativa.Checked;
      plsEdTempoAtualizacaoLogConexoes.Enabled := ckBxTempoAtualizacaoLogConexoes.Checked;
      upDwTempoAtualizacaoLogConexoes.Enabled := ckBxTempoAtualizacaoLogConexoes.Checked;
      plsEdTipoAcessoBD.Enabled := ckBxTipoAcessoBD.Checked;
    end;
    nTBSHEET_LOG:
    begin
      plsEdTempoReleituraINI.Enabled := ckBxTempoReleituraINI.Checked;
      upDwTempoReleituraINI.Enabled := ckBxTempoReleituraINI.Checked;
      plsCbBxRegistraLogMetodo.Enabled := ckBxRegistraLogMetodo.Checked;
      plsEdTamanhoMaximoLogMetodo.Enabled := ckBxTamanhoMaximoLogMetodo.Checked;
      upDwTamanhoMaximoLogMetodo.Enabled := ckBxTamanhoMaximoLogMetodo.Checked;
      plsEdQuantidadeArquivosLogMetodo.Enabled := ckBxQuantidadeArquivosLogMetodo.Checked;
      upDwQuantidadeArquivosLogMetodo.Enabled := ckBxQuantidadeArquivosLogMetodo.Checked;
      plsCbBxRegistraLogSQL.Enabled := ckBxRegistraLogSQL.Checked;
    end;
    nTBSHEET_GERAL:
    begin
      plsEdSiglaCliente.Enabled := ckBxSiglaCliente.Checked;
      plsEdNomeCliente.Enabled := ckBxNomeCliente.Checked;
      plsEdLogoCliente.Enabled := ckBxLogoCliente.Checked;
    end;
    nTBSHEET_SP_UPDATE:
    begin
      plsCbBxPodeAtualizar.Enabled := ckBxPodeAtualizar.Checked;
      plsEdAlias.Enabled := ckBxAlias.Checked;
      plsEdUsuarioSpUpdate.Enabled := ckBxUsuarioSpUpdate.Checked;
      plsEdSenhaSpUpdate.Enabled := ckBxSenhaSpUpdate.Checked;
      plsEdEsquemaSpUpdate.Enabled := ckBxEsquemaSpUpdate.Checked;
      plsEdCDSistema.Enabled := ckBxCDSistema.Checked;
    end;
    nTBSHEET_SP_MONITOR:
    begin
      plsEdTimerLog.Enabled := ckBxTimerLog.Checked;
      upDwTimerLog.Enabled := ckBxTimerLog.Checked;
      plsEdTimerUsuarios.Enabled := ckBxTimerUsuarios.Checked;
      upDwTimerUsuarios.Enabled := ckBxTimerUsuarios.Checked;
      plsCbBxReleituraAutomaticaLog.Enabled := ckBxReleituraAutomaticaLog.Checked;
      plsCbBxAvaliaTravamentoAutomatico.Enabled := ckBxAvaliaTravamentoAutomatico.Checked;
      plsCbBxPosicionaUltimoLogAutomatico.Enabled := ckBxPosicionaUltimoLogAutomatico.Checked;
      plsCbBxAtualizacaoAutomaticaUsuarios.Enabled := ckBxAtualizacaoAutomaticaUsuarios.Checked;
      plsCbBxCarregaLogMaisRecente.Enabled := ckBxCarregaLogMaisRecente.Checked;
      plsEdDiretorioLog.Enabled := ckBxDiretorioLog.Checked;
    end;
  end;
end;

procedure TfrmPrincipal.CarregarTelaDadosDisponiveis;
begin
  //abrindo arquivo .INI
  if (FileExists(ExtractFilePath(ParamStr(0))+ sARQUIVO_INI_CONFIGURACOES_DADOS_DISPONIVEIS)) then //pega diretório do executável + arquivo .INI
  begin
    oIniConfDados := TIniFile.Create(ExtractFilePath(ParamStr(0))+ sARQUIVO_INI_CONFIGURACOES_DADOS_DISPONIVEIS);
    oDadosConf.sTipoBanco := oIniConfDados.ReadString('TIPO_BANCO','bancos','');
    FoFuncoes.InserirItensComboBox(oDadosConf.sTipoBanco,plsCbBxTipoBanco);

    oDadosConf.sBasesDB2 := oIniConfDados.ReadString('BASES_DADOS','db2','');
    oDadosConf.sBasesOracle := oIniConfDados.ReadString('BASES_DADOS','oracle','');
    oDadosConf.sBasesMSQServer := oIniConfDados.ReadString('BASES_DADOS','msqserver','');

    oDadosConf.sNomeArquivoSaida := oIniConfDados.ReadString('SAIDA_INI','nome','');
    oDadosConf.sDiretorioSaida := oIniConfDados.ReadString('SAIDA_INI','diretorio','');
    plsEdNome.Text := oDadosConf.sNomeArquivoSaida;
    plsEdDiretorio.Text := oDadosConf.sDiretorioSaida;

    oIniConfDados.Free;
  end
  else
    MessageDlg('Arquivo de Configurações de Dados Disponíveis não encontrado.',mtInformation,[mbOK],0);
end;

function TfrmPrincipal.VerificarPodeSalvarINI: Boolean;
var
  bRetorno: Boolean;
begin
  bRetorno := True;
  //aba servidor
  if ckBxGUID_NomeServidor.Checked then
  begin
    if(plsEdGUIDServidor.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'GUID SERVIDOR');
      FoFuncoes.FocarComponente(plsEdGUIDServidor);
      bRetorno := False;
    end;
    if bRetorno and (plsEdNomeServidor.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'NOME SERVIDOR');
      FoFuncoes.FocarComponente(plsEdNomeServidor);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxUsuarioSenhaPRO.Checked then
  begin
    if(plsEdUsuarioConexaoPro.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'USUÁRIO CONEXÃO PRO');
      FoFuncoes.FocarComponente(plsEdUsuarioConexaoPro);
      bRetorno := False;
    end;
    if bRetorno and (plsEdSenhaConexaoPro.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'SENHA CONEXÃO PRO');
      FoFuncoes.FocarComponente(plsEdSenhaConexaoPro);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxUsuarioSenhaSGC.Checked then
  begin
    if(plsEdUsuarioConexaoSGC.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'USUÁRIO CONEXÃO SGC');
      FoFuncoes.FocarComponente(plsEdUsuarioConexaoSGC);
      bRetorno := False;
    end;
    if bRetorno and (plsEdSenhaConexaoSGC.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'SENHA CONEXÃO SGC');
      FoFuncoes.FocarComponente(plsEdSenhaConexaoSGC);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxNomeComputador.Checked then
  begin
    if(plsEdNomeComputador.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'NOME COMPUTADOR');
      FoFuncoes.FocarComponente(plsEdNomeComputador);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxTipoConexao.Checked then
  begin
    if(plsEdTipoConexao.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'TIPO CONEXÃO');
      FoFuncoes.FocarComponente(plsEdTipoConexao);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxPorta.Checked then
  begin
    if(plsEdPorta.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'PORTA');
      FoFuncoes.FocarComponente(plsEdPorta);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxNomeExecutavelServidor.Checked then
  begin
    if(plsEdNomeExecutavelServidor.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'NOME EXECUTÁVEL SERVIDOR');
      FoFuncoes.FocarComponente(plsEdNomeExecutavelServidor);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxTimeOutRequisicaoCliente.Checked then
  begin
    if(plsCbBxTimeOutRequisicaoCliente.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'TIMEOUT REQUISIÇÃO CLIENTE');
      FoFuncoes.FocarComponente(plsCbBxTimeOutRequisicaoCliente);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxPodeBalancear.Checked then
  begin
    if(plsCbBxPodeBalancear.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'PODE BALANCEAR');
      FoFuncoes.FocarComponente(plsCbBxPodeBalancear);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxDesabilitaRecalculaTotal.Checked then
  begin
    if(plsCbBxDesabilitaRecalculaTotal.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'DESABILITA RECALCULA TOTAL');
      FoFuncoes.FocarComponente(plsCbBxDesabilitaRecalculaTotal);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxUsuarioSenhaEST.Checked then
  begin
    if(plsEdUsuarioConexaoEst.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'USUÁRIO CONEXÃO EST');
      FoFuncoes.FocarComponente(plsEdUsuarioConexaoEst);
      bRetorno := False;
    end;
    if bRetorno and (plsEdSenhaConexaoEst.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'SENHA CONEXÃO EST');
      FoFuncoes.FocarComponente(plsEdSenhaConexaoEst);
      bRetorno := False;
    end;
  end;
  //aba fluxo de trabalho
  if bRetorno and ckBxUsuarioParaLogarEventosFluxo.Checked then
  begin
    if(plsEdUsuarioParaLogarEventosFluxo.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'USUÁRIO PARA LOGAR EVENTOS FLUXO');
      FoFuncoes.FocarComponente(plsEdUsuarioParaLogarEventosFluxo);
      bRetorno := False;
    end;
  end;
  //aba servidores de aplicação
  //nome do computador pode ser em branco
  if bRetorno and rdBtnIPDesenvolvimento.Checked then
  begin
    if(plsEdDesenvolvimento.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'ID DO DESENVOLVIMENTO');
      FoFuncoes.FocarComponente(plsEdDesenvolvimento);
      bRetorno := False;
    end;
  end;

  if bRetorno and rdBtnIPBaseTestesTJSP.Checked then
  begin
    if(plsEdBaseTestesTJSP.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'ID DA BASE DE TESTES DO TJSP');
      FoFuncoes.FocarComponente(plsEdBaseTestesTJSP);
      bRetorno := False;
    end;
  end;

  if bRetorno and rdBtnIPBaseHomologacaoTJSP.Checked then
  begin
    if(plsEdBaseHomologacaoTJSP.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'ID DA BASE DE HOMOLOGAÇÃO DO TJSP');
      FoFuncoes.FocarComponente(plsEdBaseHomologacaoTJSP);
      bRetorno := False;
    end;
  end;

  if bRetorno and rdBtnIPBaseProducaoTJSP.Checked then
  begin
    if(plsEdBaseProducaoTJSP.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'ID DA BASE DE PRODUÇÃO DO TJSP');
      FoFuncoes.FocarComponente(plsEdBaseProducaoTJSP);
      bRetorno := False;
    end;
  end;

  if bRetorno and rdBtnIPMaquinaTestesTJSP.Checked then
  begin
    if(plsEdMaquinaTestesTJSP.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'ID DA MÁQUINA DE TESTES DO TJSP');
      FoFuncoes.FocarComponente(plsEdMaquinaTestesTJSP);
      bRetorno := False;
    end;
  end;

  if bRetorno and rdBtnIPBaseProducaoTJSC.Checked then
  begin
    if(plsEdBaseProducaoTJSC.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'ID DA BASE DE PRODUÇÃO DO TJSC');
      FoFuncoes.FocarComponente(plsEdBaseProducaoTJSC);
      bRetorno := False;
    end;
  end;
  //aba fluxo
  if bRetorno and ckBxConsultarTotalFila.Checked then
  begin
    if(plsCbBxConsultarTotalFila.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'CONSULTAR TOTAL FILA');
      FoFuncoes.FocarComponente(plsCbBxConsultarTotalFila);
      bRetorno := False;
    end;
  end;
  //aba cliente
  if bRetorno and ckBxTipoSistema.Checked then
  begin
    if(plsEdTipoSistema.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'TIPO SISTEMA');
      FoFuncoes.FocarComponente(plsEdTipoSistema);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxNome.Checked then
  begin
    if(plsEdNomeSistema.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'NOME CLIENTE');
      FoFuncoes.FocarComponente(plsEdNomeSistema);
      bRetorno := False;
    end;
  end;

  if bRetorno and rdBtnLoginAutomatico.Checked then
  begin
    if(plsCbBxLoginAutomatico.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'LOGIN AUTOMÁTICO');
      FoFuncoes.FocarComponente(plsCbBxLoginAutomatico);
      bRetorno := False;
    end;
  end;

  if bRetorno and rdBtnNovoLoginAutomatico.Checked then
  begin
    if(plsEdNovoUsuario.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'NOVO USUÁRIO LOGIN AUTOMÁTICO');
      FoFuncoes.FocarComponente(plsEdNovoUsuario);
      bRetorno := False;
    end;

    if bRetorno and (plsEdNovaSenha.Text = STRING_INDEFINIDO) then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'NOVA SENHA LOGIN AUTOMÁTICO');
      FoFuncoes.FocarComponente(plsEdNovaSenha);
      bRetorno := False;
    end;

    if bRetorno and (plsEdNovaLotacao.Text = STRING_INDEFINIDO) then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'NOVA LOTAÇÃO LOGIN AUTOMÁTICO');
      FoFuncoes.FocarComponente(plsEdNovaLotacao);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxDepurandoDraw.Checked then
  begin
    if(plsCbBxDepurandoDraw.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'DEPURANDO DRAW');
      FoFuncoes.FocarComponente(plsCbBxDepurandoDraw);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxResolucao.Checked then
  begin
    if(plsEdResolucao.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'RESOLUÇÃO');
      FoFuncoes.FocarComponente(plsEdResolucao);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxMostraBotoEsdeTeste.Checked then
  begin
    if(plsCbBxMostraBotoEsdeTeste.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'MOSTRA BOTÕES DE TESTE');
      FoFuncoes.FocarComponente(plsCbBxMostraBotoEsdeTeste);
      bRetorno := False;
    end;
  end;
  //aba database
  if bRetorno and ckBxEsquema.Checked then
  begin
    if(plsEdEsquema.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'ESQUEMA');
      FoFuncoes.FocarComponente(plsEdEsquema);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxNumeroMaximoConexoes.Checked then
  begin
    if(plsEdNumeroMaximoConexoes.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'NÚMERO MÁXIMO DE CONEXÕES');
      FoFuncoes.FocarComponente(plsEdNumeroMaximoConexoes);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxNumeroMinimoConexoes.Checked then
  begin
    if(plsEdNumeroMinimoConexoes.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'NÚMERO MÍNIMO DE CONEXÕES');
      FoFuncoes.FocarComponente(plsEdNumeroMinimoConexoes);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxTempoDesconexaoConexaoInativa.Checked then
  begin
    if(plsEdTempoDesconexaoConexaoInativa.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'TEMPO DESCONEXÃO CONEXÃO INATIVA');
      FoFuncoes.FocarComponente(plsEdTempoDesconexaoConexaoInativa);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxTempoAtualizacaoLogConexoes.Checked then
  begin
    if(plsEdTempoAtualizacaoLogConexoes.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'TEMPO ATUALIZAÇÃO LOG CONEXÕES');
      FoFuncoes.FocarComponente(plsEdTempoAtualizacaoLogConexoes);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxTipoAcessoBD.Checked then
  begin
    if(plsEdTipoAcessoBD.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'TIPO ACESSO BD');
      FoFuncoes.FocarComponente(plsEdTipoAcessoBD);
      bRetorno := False;
    end;
  end;
  //aba log
  if bRetorno and ckBxTempoReleituraINI.Checked then
  begin
    if(plsEdTempoReleituraINI.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'TEMPO RELEITURA INI');
      FoFuncoes.FocarComponente(plsEdTempoReleituraINI);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxRegistraLogMetodo.Checked then
  begin
    if(plsCbBxRegistraLogMetodo.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'REGISTRA LOG MÉTODO');
      FoFuncoes.FocarComponente(plsCbBxRegistraLogMetodo);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxTamanhoMaximoLogMetodo.Checked then
  begin
    if(plsEdTamanhoMaximoLogMetodo.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'TAMANHO MÁXIMO LOG MÉTODO');
      FoFuncoes.FocarComponente(plsEdTamanhoMaximoLogMetodo);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxQuantidadeArquivosLogMetodo.Checked then
  begin
    if(plsEdQuantidadeArquivosLogMetodo.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'QUANTIDADE ARQUIVOS LOG MÉTODO');
      FoFuncoes.FocarComponente(plsEdQuantidadeArquivosLogMetodo);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxRegistraLogSQL.Checked then
  begin
    if(plsCbBxRegistraLogSQL.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'REGISTRA LOG SQL');
      FoFuncoes.FocarComponente(plsCbBxRegistraLogSQL);
      bRetorno := False;
    end;
  end;
  //aba geral
  if bRetorno and ckBxSiglaCliente.Checked then
  begin
    if(plsEdSiglaCliente.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'SIGLA CLIENTE');
      FoFuncoes.FocarComponente(plsEdSiglaCliente);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxNomeCliente.Checked then
  begin
    if(plsEdNomeCliente.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'NOME CLIENTE');
      FoFuncoes.FocarComponente(plsEdNomeCliente);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxLogoCliente.Checked then
  begin
    if(plsEdLogoCliente.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'LOGO CLIENTE');
      FoFuncoes.FocarComponente(plsEdLogoCliente);
      bRetorno := False;
    end;
  end;
  //aba spUpdate
  if bRetorno and ckBxPodeAtualizar.Checked then
  begin
    if(plsCbBxPodeAtualizar.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'PODE ATUALIZAR');
      FoFuncoes.FocarComponente(plsCbBxPodeAtualizar);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxAlias.Checked then
  begin
    if(plsEdAlias.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'ALIAS SPUPDATE');
      FoFuncoes.FocarComponente(plsEdAlias);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxUsuarioSpUpdate.Checked then
  begin
    if(plsEdUsuarioSpUpdate.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'USUÁRIO SPUPDATE');
      FoFuncoes.FocarComponente(plsEdUsuarioSpUpdate);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxSenhaSpUpdate.Checked then
  begin
    if(plsEdSenhaSpUpdate.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'SENHA SPUPDATE');
      FoFuncoes.FocarComponente(plsEdSenhaSpUpdate);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxEsquemaSpUpdate.Checked then
  begin
    if(plsEdEsquemaSpUpdate.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'ESQUEMA SP UPDATE');
      FoFuncoes.FocarComponente(plsEdEsquemaSpUpdate);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxCDSistema.Checked then
  begin
    if(plsEdCDSistema.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'CD SISTEMA');
      FoFuncoes.FocarComponente(plsEdCDSistema);
      bRetorno := False;
    end;
  end;
  //aba spMonitor
  if bRetorno and ckBxTimerLog.Checked then
  begin
    if(plsEdTimerLog.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'TIMER LOG');
      FoFuncoes.FocarComponente(plsEdTimerLog);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxTimerUsuarios.Checked then
  begin
    if(plsEdTimerUsuarios.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'TIMER USUÁRIOS');
      FoFuncoes.FocarComponente(plsEdTimerUsuarios);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxReleituraAutomaticaLog.Checked then
  begin
    if(plsCbBxReleituraAutomaticaLog.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'RELEITURA AUTOMÁTICA LOG');
      FoFuncoes.FocarComponente(plsCbBxReleituraAutomaticaLog);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxAvaliaTravamentoAutomatico.Checked then
  begin
    if(plsCbBxAvaliaTravamentoAutomatico.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'AVALIA TRAVAMENTO AUTOMÁTICO');
      FoFuncoes.FocarComponente(plsCbBxAvaliaTravamentoAutomatico);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxPosicionaUltimoLogAutomatico.Checked then
  begin
    if(plsCbBxPosicionaUltimoLogAutomatico.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'POSICIONA ÚLTIMO LOG AUTOMÁTICO');
      FoFuncoes.FocarComponente(plsCbBxPosicionaUltimoLogAutomatico);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxAtualizacaoAutomaticaUsuarios.Checked then
  begin
    if(plsCbBxAtualizacaoAutomaticaUsuarios.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'ATUALIZAÇÃO AUTOMÁTICA USUÁRIOS');
      FoFuncoes.FocarComponente(plsCbBxAtualizacaoAutomaticaUsuarios);
      bRetorno := False;
    end;
  end;


  if bRetorno and ckBxCarregaLogMaisRecente.Checked then
  begin
    if(plsCbBxCarregaLogMaisRecente.ItemIndex = NUMERO_SEM_SELECAO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'CARREGA LOG MAIS RECENTE');
      FoFuncoes.FocarComponente(plsCbBxCarregaLogMaisRecente);
      bRetorno := False;
    end;
  end;

  if bRetorno and ckBxDiretorioLog.Checked then
  begin
    if(plsEdDiretorioLog.Text = STRING_INDEFINIDO)then
    begin
      FoFuncoes.MostrarMensagem(nCAMPO_OBRIGATORIO,'DIRETÓRIO DO LOG');
      FoFuncoes.FocarComponente(plsEdDiretorioLog);
      bRetorno := False;
    end;
  end;

  Result := bRetorno;
end;

procedure TfrmPrincipal.GerarArquivoINI;

  //atalho para adicionar uma entrada em FoLstNovoINI
  procedure AddItem(psItem,psValor:string);
  begin
    FoLstNovoINI.Add(psItem + '=' + psValor);
  end;

  procedure AdicionarGuiaServidor;
  begin
    (*
    [Servidor]
    ;SG5
    GUIDServidor={F67F7610-BDB7-4258-9B13-003C19084FDC}
    nomeServidor=sg5Servidor.fsgServidorDM
    ;UsuarioConexaoPro=SAJPRO
    ;SenhaConexaoPro=A46CE3D5968C9BDC859792868291945657949287
    ;UsuarioConexaoSGC=SAJPRO
    ;SenhaConexaoSGC=A46CE3D5968C9BDC859792868291945657949287
    ;nomeComputador=localhost
    TipoConexao=socket
    Porta=211
    NomeExecutavelServidor=fsgServidor.exe
    TimeoutRequisicaoCliente=N
    PODEBALANCEAR=N
    DesabilitaRecalculaTotal=S
    UsuarioConexaoEst=saj
    SenhaConexaoEst=A79EE0D5A7D1D4DF859792868291945657949287
    *)
    if ckBxGUID_NomeServidor.Checked then
    begin
      AddItem(sGUID_SERVIDOR, plsEdGUIDServidor.Text);
      AddItem(sNOME_SERVIDOR, plsEdNomeServidor.Text);
    end;
    if ckBxUsuarioSenhaPRO.Checked then
    begin
      AddItem(sUSUARIO_CONEXAO_PRO, plsEdUsuarioConexaoPro.Text);
      AddItem(sSENHA_CONEXAO_PRO, plsEdSenhaConexaoPro.Text);
    end;
    if ckBxUsuarioSenhaSGC.Checked then
    begin
      AddItem(sUSUARIO_CONEXAO_SGC, plsEdUsuarioConexaoSGC.Text);
      AddItem(sSENHA_CONEXAO_SGC, plsEdSenhaConexaoSGC.Text);
    end;
    if ckBxNomeComputador.Checked then
      AddItem(sNOME_COMPUTADOR, plsEdNomeComputador.Text);
    if ckBxTipoConexao.Checked then
      AddItem(sTIPO_CONEXAO, plsEdTipoConexao.Text);
    if ckBxPorta.Checked then
      AddItem(sPORTA, plsEdPorta.Text);
    if ckBxNomeExecutavelServidor.Checked then
      AddItem(sNOME_EXECUTAVEL_SERVIDOR, plsEdNomeExecutavelServidor.Text);
    if ckBxTimeOutRequisicaoCliente.Checked then
      AddItem(sTIMEOUT_REQUISICAO_CLIENTE, plsCbBxTimeOutRequisicaoCliente.Text);
    if ckBxPodeBalancear.Checked then
      AddItem(sPODE_BALANCEAR, plsCbBxPodeBalancear.Text);
    if ckBxDesabilitaRecalculaTotal.Checked then
      AddItem(sDESABILITA_RECALCULA_TOTAL, plsCbBxDesabilitaRecalculaTotal.Text);
    if ckBxUsuarioSenhaEST.Checked then
    begin
      AddItem(sUSUARIO_CONEXAO_EST, plsEdUsuarioConexaoEst.Text);
      AddItem(sSENHA_CONEXAO_EST, plsEdSenhaConexaoEst.Text);
    end;
  end;

  procedure AdicionarGuiaFluxoTrabalho;
  begin
    //;[FluxoTrabalho]
    //;UsuarioParaLogarEventosFluxo=SOFTPLAN
    if ckBxUsuarioParaLogarEventosFluxo.Checked then
      AddItem(sUSUARIO_PARA_LOGAR_EVENTOS_FLUXO, plsEdUsuarioParaLogarEventosFluxo.Text);
  end;

  procedure AdicionarServidoresAplicacao;
  begin
    //;;;;;;;;;;;;;;;;;;;;;;;;;;;
    //; Servidores de aplicação ;
    //;;;;;;;;;;;;;;;;;;;;;;;;;;;
    //; Desenvolvimento
    //enderecoIP=127.0.0.1
    //NomeComputador=
    //; Base Testes TJSP
    //;enderecoIP=10.33.192.112
    //; Base Homologação TJSP
    //;enderecoIP=10.33.192.166
    //; Base Produção TJSP
    //;enderecoIP=10.33.192.127
    //; Máquina de testes do TJSP
    //;enderecoIP=10.33.88.119
    //; Base Homologação TJSP
    //;enderecoIP=10.33.192.135
    //; Base Produção TJSC
    //;enderecoIP=10.17.6.130
    if ckBxNomeComputadorServidorAplicacao.Checked then
      AddItem(sNOME_COMPUTADOR_SERV_APLICACAO, plsEdNomeComputadorServidorAplicacao.Text);

    if rdBtnIPDesenvolvimento.Checked then
      AddItem(sENDERECO_IP, plsEdDesenvolvimento.Text);

    if rdBtnIPBaseTestesTJSP.Checked then
      AddItem(sENDERECO_IP, plsEdBaseTestesTJSP.Text);

    if rdBtnIPBaseHomologacaoTJSP.Checked then
      AddItem(sENDERECO_IP, plsEdBaseHomologacaoTJSP.Text);

    if rdBtnIPBaseProducaoTJSP.Checked then
      AddItem(sENDERECO_IP, plsEdBaseProducaoTJSP.Text);

    if rdBtnIPMaquinaTestesTJSP.Checked then
      AddItem(sENDERECO_IP, plsEdMaquinaTestesTJSP.Text);

    if rdBtnIPBaseProducaoTJSC.Checked then
      AddItem(sENDERECO_IP, plsEdBaseProducaoTJSC.Text);
  end;

  procedure AdicionarFluxo;
  begin
    //[FLUXO]
    //ConsultarTotalFila=N
    if ckBxConsultarTotalFila.Checked then
      AddItem(sCONSULTAR_TOTAL_FILA, plsCbBxConsultarTotalFila.Text);
  end;

  procedure AdicionarCliente;
  begin
    //[Cliente]
    //TipoSistema=SG
    //Nome=Tribunal de Justiça de São Paulo
    //; Usado internamente para dar agilidade aos desenvolvedores
    //;LoginAutomatico=BEATRIZM,mira100,1
    //;LoginAutomatico=SOFTPLAN,agesune1,1
    //;LoginAutomatico=SOFTPLAN,ejc4vvm,1
    //;LoginAutomatico=ADMIN,agesune1,1
    //; Usado para depurar o editor interno
    //DepurandoDraw=N
    //Resolucao=1024
    //; Usado em testes de carga
    //MOSTRABOTOESDETESTE=N
    if ckBxTipoSistema.Checked then
      AddItem(sTIPO_SISTEMA, plsEdTipoSistema.Text);

    if ckBxNome.Checked then
      AddItem(sNOME, plsEdNomeSistema.Text);

    if rdBtnLoginAutomatico.Checked then
      AddItem(sLOGIN_AUTOMATICO, plsCbBxLoginAutomatico.Text)
    else if rdBtnNovoLoginAutomatico.Checked then
      AddItem(sLOGIN_AUTOMATICO, plsEdNovoUsuario.Text+','+plsEdNovaSenha.Text+','+plsEdNovaLotacao.Text);

    if ckBxDepurandoDraw.Checked then
      AddItem(sDEPURANDO_DRAW, plsCbBxDepurandoDraw.Text);

    if ckBxResolucao.Checked then
      AddItem(sRESOLUCAO, plsEdResolucao.Text);

    if ckBxMostraBotoEsdeTeste.Checked then
      AddItem(sMOSTRA_BOTOES_DE_TESTE, plsCbBxMostraBotoEsdeTeste.Text);
  end;

  procedure AdicionarDatabase;
  begin
    //[Database]
    //Esquema=SAJ
    //NumeroMaximoConexoes =2
    //NumeroMinimoConexoes = 2
    //TempoDesconexaoConexaoInativa=1
    //TempoAtualizacaoLogConexoes=1
    //TipoAcessoBD=sqld
    if ckBxEsquema.Checked then
      AddItem(sESQUEMA_DATABASE, plsEdEsquema.Text);

    if ckBxNumeroMaximoConexoes.Checked then
      AddItem(sNUMERO_MAXIMO_CONEXOES, plsEdNumeroMaximoConexoes.Text);

    if ckBxNumeroMinimoConexoes.Checked then
      AddItem(sNUMERO_MINIMO_CONEXOES, plsEdNumeroMinimoConexoes.Text);

    if ckBxTempoDesconexaoConexaoInativa.Checked then
      AddItem(sTEMPO_DESCONEXAO_CONEXAO_INATIVA, plsEdTempoDesconexaoConexaoInativa.Text);

    if ckBxTempoAtualizacaoLogConexoes.Checked then
      AddItem(sTEMPO_ATUALIZACAO_LOG_CONEXOES, plsEdTempoAtualizacaoLogConexoes.Text);

    if ckBxTipoAcessoBD.Checked then
      AddItem(sTIPO_ACESSO_BD, plsEdTipoAcessoBD.Text);
  end;

  procedure AdicionarLog;
  begin
    //[Log]
    //TempoReleituraIni
    //RegistraLogMetodo
    //TamanhoMaximoLogMetodo
    //QuantidadeArquivosLogMetodo
    //RegistraLogSQL
    if ckBxTempoReleituraINI.Checked then
      AddItem(sTEMPO_RELEITURA_INI, plsEdTempoReleituraINI.Text);

    if ckBxRegistraLogMetodo.Checked then
      AddItem(sREGISTRA_LOG_METODO, plsCbBxRegistraLogMetodo.Text);

    if ckBxTamanhoMaximoLogMetodo.Checked then
      AddItem(sTAMANHO_MAXIMO_LOG_METODO, plsEdTamanhoMaximoLogMetodo.Text);

    if ckBxQuantidadeArquivosLogMetodo.Checked then
      AddItem(sQUANTIDADE_ARQUIVOS_LOG_METODO, plsEdQuantidadeArquivosLogMetodo.Text);

    if ckBxRegistraLogSQL.Checked then
      AddItem(sREGISTRA_LOG_SQL, plsCbBxRegistraLogSQL.Text);
  end;

  procedure AdicionarGeral;
  begin
    //[GERAL]
    //SIGLACLIENTE
    //NOMECLIENTE
    //LOGOCLIENTE
    if ckBxSiglaCliente.Checked then
      AddItem(sSIGLA_CLIENTE, plsEdSiglaCliente.Text);

    if ckBxNomeCliente.Checked then
      AddItem(sNOME_CLIENTE, plsEdNomeCliente.Text);

    if ckBxLogoCliente.Checked then
      AddItem(sLOGO_CLIENTE, plsEdLogoCliente.Text);
  end;

  procedure AdicionarSpUpdate;
  begin
    //[spUpdate]
    //PodeAtualizar
    //Alias
    //Usuario
    //Senha
    //Esquema
    //cdSistema
    if ckBxPodeAtualizar.Checked then
      AddItem(sPODE_ATUALIZAR, plsCbBxPodeAtualizar.Text);

    if ckBxAlias.Checked then
      AddItem(sALIAS, plsEdAlias.Text);

    if ckBxUsuarioSpUpdate.Checked then
      AddItem(sUSUARIO, plsEdUsuarioSpUpdate.Text);

    if ckBxSenhaSpUpdate.Checked then
      AddItem(sSENHA, plsEdSenhaSpUpdate.Text);

   if ckBxEsquemaSpUpdate.Checked then
      AddItem(sESQUEMA_SP_UPDATE, plsEdEsquemaSpUpdate.Text);

    if ckBxCDSistema.Checked then
      AddItem(sCD_SISTEMA, plsEdCDSistema.Text);
  end;

  procedure AdicionarSpMonitor;
  begin
    //[spMonitor]
    //TimerLog
    //TimerUsuarios
    //ReleituraAutomaticaLog
    //AvaliaTravamentoAutomatico
    //PosicionaUltimoLogAutomatico
    //AtualizacaoAutomaticaUsuarios
    //CarregaLogMaisRecente
    //DiretorioLog
    if ckBxTimerLog.Checked then
      AddItem(sTIMER_LOG, plsEdTimerLog.Text);

    if ckBxTimerUsuarios.Checked then
      AddItem(sTIMER_USUARIOS, plsEdTimerUsuarios.Text);

    if ckBxReleituraAutomaticaLog.Checked then
      AddItem(sRELEITURA_AUMATICA_LOG, plsCbBxReleituraAutomaticaLog.Text);

    if ckBxAvaliaTravamentoAutomatico.Checked then
      AddItem(sAVALA_TRAVAMENTO_AUTOMATICO, plsCbBxAvaliaTravamentoAutomatico.Text);

    if ckBxPosicionaUltimoLogAutomatico.Checked then
      AddItem(sPOSICIONA_ULTIMO_LOG_AUTOMATICO, plsCbBxPosicionaUltimoLogAutomatico.Text);

    if ckBxAtualizacaoAutomaticaUsuarios.Checked then
      AddItem(sATUALIZACAO_AUTOMATICA_USUARIOS, plsCbBxAtualizacaoAutomaticaUsuarios.Text);

    if ckBxCarregaLogMaisRecente.Checked then
      AddItem(sCARREGA_LOG_MAIS_RECENTE, plsCbBxCarregaLogMaisRecente.Text);

    if ckBxDiretorioLog.Checked then
      AddItem(sDIRETORIO_LOG, plsEdDiretorioLog.Text);
  end;

begin
  FoLstNovoINI.Clear;
  //guia Servidor
  FoLstNovoINI.Add(sOPCOES_SERVIDOR);
  AdicionarGuiaServidor;
  FoLstNovoINI.Add(sOPCOES_FLUXO_TRABALHO);
  AdicionarGuiaFluxoTrabalho;
  FoLstNovoINI.Add(sOPCOES_SERVIDORES_APLICACAO);
  AdicionarServidoresAplicacao;
  FoLstNovoINI.Add(sOPCOES_FLUXO);
  AdicionarFluxo;
  FoLstNovoINI.Add(sOPCOES_CLIENTE);
  AdicionarCliente;
  FoLstNovoINI.Add(sOPCOES_DATABASE);
  AdicionarDatabase;
  FoLstNovoINI.Add(sOPCOES_LOG);
  AdicionarLog;
  FoLstNovoINI.Add(sOPCOES_GERAL);
  AdicionarGeral;
  FoLstNovoINI.Add(sOPCOES_SP_UPDATE);
  AdicionarSpUpdate;


  FoLstNovoINI.Add(sOPCOES_SP_UPDATE);
  AdicionarSpMonitor;

ShowMessage(IntToStr(FoLstNovoINI.Count));
end;

(* fim - início procedimentos auxiliares *)

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  FoLstNovoINI := TStringList.Create;

  CarregarTelaDadosDisponiveis;
  DefinirEventoCheckBox;
  HabilitarDesabilitarComponentes(nTBSHEET_SERVIDOR);
  HabilitarDesabilitarComponentes(nTBSHEET_FLUXOTRABALHO);
  HabilitarDesabilitarComponentes(nTBSHEET_SERVIDORES_APLICACAO);
  HabilitarDesabilitarComponentes(nTBSHEET_FLUXO);
  HabilitarDesabilitarComponentes(nTBSHEET_CLIENTE);
  HabilitarDesabilitarComponentes(nTBSHEET_DATABASE);
  HabilitarDesabilitarComponentes(nTBSHEET_LOG);
  HabilitarDesabilitarComponentes(nTBSHEET_GERAL);
  HabilitarDesabilitarComponentes(nTBSHEET_SP_UPDATE);
  HabilitarDesabilitarComponentes(nTBSHEET_SP_MONITOR);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
  FreeAndNil(FoLstNovoINI);
end;

procedure TfrmPrincipal.plsCbBxTipoBancoChange(Sender: TObject);
begin
  if(plsCbBxTipoBanco.Text = 'DB2')then
    FoFuncoes.InserirItensComboBox(oDadosConf.sBasesDB2,plsCbBxBaseDados)
  else if(plsCbBxTipoBanco.Text = 'ORACLE')then
    FoFuncoes.InserirItensComboBox(oDadosConf.sBasesOracle,plsCbBxBaseDados)
  else if(plsCbBxTipoBanco.Text = 'MSQSERVER')then
    FoFuncoes.InserirItensComboBox(oDadosConf.sBasesMSQServer,plsCbBxBaseDados);
end;


procedure TfrmPrincipal.btBtnSalvarClick(Sender: TObject);
begin
  if VerificarPodeSalvarINI then
  begin
    GerarArquivoINI;
  end;
end;

end.

