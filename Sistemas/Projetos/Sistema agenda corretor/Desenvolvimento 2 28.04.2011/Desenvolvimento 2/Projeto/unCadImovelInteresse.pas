unit unCadImovelInteresse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ComCtrls, ToolWin, plsMemo, Buttons, plsComboBox, ExtCtrls, Mask,
  plsTMaskEdit, unObjImovelInteresse, unVariaveis,
  unConjuntoDadosTipoImovel,unConjuntoDadosClientePessoaFisica,
  unConjuntoDadosClientePessoaJuridica, Grids, DBGrids, unConjuntoDadosRegiaoLocalidade;

  type
    TCliente = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TTipoImovel = record
      codigo: Integer;
      nome: string[60];
    end;

  type
    TRegiaoLocalidade = record
      codigo: Integer;
      nome: string[50];
    end;


type
  TfrmCadImovelInteresse = class(TfrmCadastroBasico)
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    lblDataCaptacao: TLabel;
    lblCampoObrigatorio1: TLabel;
    plsMedDataCaptacao: TPlsMaskEdit;
    pnlDataBaixa: TPanel;
    pnlTipoImovel: TPanel;
    spBtnBuscaTipoImovel: TSpeedButton;
    lblTipoImovel: TLabel;
    lblCampoObrigatorio3: TLabel;
    plsEdTipoImovel: TPlsEdit;
    pnlCliente: TPanel;
    lblCliente: TLabel;
    spBtnBuscaCliente: TSpeedButton;
    lblCampoObrigatorio2: TLabel;
    plsEdCliente: TPlsEdit;
    grpBxFormaPagamento: TGroupBox;
    grpBxCondicaoPagamentoFinanciamento: TGroupBox;
    lblFinanciamentoCach: TLabel;
    lblFinanciamentoBemValor: TLabel;
    lblFinanciamentoBemDescricao: TLabel;
    lblFinanciamentoValorFinanciado: TLabel;
    plsEdFinanciamentoCach: TPlsEdit;
    plsEdFinanciamentoBemValor: TPlsEdit;
    plsMmFinanciamentoBemDescricao: TPlsMemo;
    plsEdFinanciamentoValorFinanciado: TPlsEdit;
    grpBxCondicaoPagamentoVista: TGroupBox;
    lblVistaCach: TLabel;
    lblVistaBemValor: TLabel;
    lblVistaBemDescricao: TLabel;
    plsEdVistaCach: TPlsEdit;
    plsEdVistaBemValor: TPlsEdit;
    plsMmVistaBemDescricao: TPlsMemo;
    lblObservacao: TLabel;
    plsMmObservacao: TPlsMemo;
    plsCbBxFinalidade: TPlsComboBox;
    lblFinalidade: TLabel;
    lblCampoObrigatorio4: TLabel;
    plsCbBxSituacao: TPlsComboBox;
    lblSituacao: TLabel;
    lblCampoObrigatorio5: TLabel;
    plsMmCaracteristicas: TPlsMemo;
    lblCaracteristicas: TLabel;
    lblCondicaoPagamento: TLabel;
    plsCbBxCondicaoPagamento: TPlsComboBox;
    lblCampoObrigatorio6: TLabel;
    lblValorImovel: TLabel;
    plsEdValorImovel: TPlsEdit;
    lblCampoObrigatorio7: TLabel;
    rdGrpTipoPessoa: TRadioGroup;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosATIVO: TStringField;
    zQryDadosDATA_CAPTACAO: TDateField;
    zQryDadosTIPO_PESSOA: TStringField;
    zQryDadosCOD_FK_CLIENTE_PESSOA_FISICA: TIntegerField;
    zQryDadosCOD_FK_CLIENTE_PESSOA_JURIDICA: TIntegerField;
    zQryDadosCOD_FK_TIPO_IMOVEL: TIntegerField;
    zQryDadosFINALIDADE_IMOVEL: TStringField;
    zQryDadosIMOVEL_DESEJAVEL: TStringField;
    zQryDadosVALOR_IMOVEL: TFloatField;
    zQryDadosCONDICAO_PAGAMENTO: TStringField;
    zQryDadosPGTO_VISTA_CACH: TFloatField;
    zQryDadosPGTO_VISTA_VALOR_BEM: TFloatField;
    zQryDadosPGTO_VISTA_DESCRICAO_BEM: TStringField;
    zQryDadosPGTO_FINCTO_CACH_FINANCIADO: TFloatField;
    zQryDadosPGTO_FINCTO_CACH: TFloatField;
    zQryDadosPGTO_FINCTO_VALOR_BEM: TFloatField;
    zQryDadosPGTO_FINCTO_DESCRICAO_BEM: TStringField;
    zQryDadosOBSERVACAO: TStringField;
    zQryDadosDATA_BAIXA: TDateTimeField;
    zQryDadosCARACTERISTICAS: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosATIVO: TStringField;
    cdsDadosDATA_CAPTACAO: TDateField;
    cdsDadosTIPO_PESSOA: TStringField;
    cdsDadosCOD_FK_CLIENTE_PESSOA_FISICA: TIntegerField;
    cdsDadosCOD_FK_CLIENTE_PESSOA_JURIDICA: TIntegerField;
    cdsDadosCOD_FK_TIPO_IMOVEL: TIntegerField;
    cdsDadosFINALIDADE_IMOVEL: TStringField;
    cdsDadosIMOVEL_DESEJAVEL: TStringField;
    cdsDadosVALOR_IMOVEL: TFloatField;
    cdsDadosCONDICAO_PAGAMENTO: TStringField;
    cdsDadosPGTO_VISTA_CACH: TFloatField;
    cdsDadosPGTO_VISTA_VALOR_BEM: TFloatField;
    cdsDadosPGTO_VISTA_DESCRICAO_BEM: TStringField;
    cdsDadosPGTO_FINCTO_CACH_FINANCIADO: TFloatField;
    cdsDadosPGTO_FINCTO_CACH: TFloatField;
    cdsDadosPGTO_FINCTO_VALOR_BEM: TFloatField;
    cdsDadosPGTO_FINCTO_DESCRICAO_BEM: TStringField;
    cdsDadosOBSERVACAO: TStringField;
    cdsDadosDATA_BAIXA: TDateTimeField;
    cdsDadosCARACTERISTICAS: TStringField;
    dsRegiaoLocalidade: TDataSource;
    cdsRegiaoLocalidade: TClientDataSet;
    zQryRegiaoLocalidade: TZQuery;
    zQryRegiaoLocalidadeCODIGO: TIntegerField;
    zQryRegiaoLocalidadeNOME: TStringField;
    grpBxRegioesLocalidade: TGroupBox;
    dbGrdRegiaoLocalidade: TDBGrid;
    pnlAddDeleteRegiaoLocalidade: TPanel;
    btBtnDeletarRegiaoLocalidade: TBitBtn;
    btBtnAdicionarRegiaoLocalidade: TBitBtn;
    lblDescFormaPagamento: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure plsCbBxCondicaoPagamentoChange(Sender: TObject);
    procedure spBtnBuscaTipoImovelClick(Sender: TObject);
    procedure plsCbBxFinalidadeChange(Sender: TObject);
    procedure plsCbBxSituacaoChange(Sender: TObject);
    procedure spBtnBuscaClienteClick(Sender: TObject);
    procedure rdGrpTipoPessoaClick(Sender: TObject);
    procedure plsEdTipoImovelExit(Sender: TObject);
    procedure plsEdClienteExit(Sender: TObject);
    procedure btBtnAdicionarRegiaoLocalidadeClick(Sender: TObject);
    procedure btBtnDeletarRegiaoLocalidadeClick(Sender: TObject);
    procedure lblCaracteristicasClick(Sender: TObject);
    procedure lblVistaBemDescricaoClick(Sender: TObject);
    procedure lblFinanciamentoBemDescricaoClick(Sender: TObject);
    procedure plsMedDataCaptacaoEnter(Sender: TObject);
    procedure plsMedDataCaptacaoKeyPress(Sender: TObject; var Key: Char);
    procedure rdGrpTipoPessoaEnter(Sender: TObject);
    procedure plsCbBxCondicaoPagamentoKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsCbBxCondicaoPagamentoEnter(Sender: TObject);
    procedure plsEdClienteEnter(Sender: TObject);
    procedure plsEdClienteKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdTipoImovelEnter(Sender: TObject);
    procedure plsEdTipoImovelKeyPress(Sender: TObject; var Key: Char);
    procedure plsCbBxFinalidadeKeyPress(Sender: TObject; var Key: Char);
    procedure plsCbBxFinalidadeEnter(Sender: TObject);
    procedure plsCbBxSituacaoEnter(Sender: TObject);
    procedure plsCbBxSituacaoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdValorImovelKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdValorImovelEnter(Sender: TObject);
    procedure plsEdVistaCachEnter(Sender: TObject);
    procedure plsEdVistaCachKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdVistaBemValorKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdVistaBemValorEnter(Sender: TObject);
    procedure plsMmVistaBemDescricaoEnter(Sender: TObject);
    procedure plsMmVistaBemDescricaoKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMmFinanciamentoBemDescricaoEnter(Sender: TObject);
    procedure plsMmFinanciamentoBemDescricaoKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsEdFinanciamentoBemValorKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsEdFinanciamentoBemValorEnter(Sender: TObject);
    procedure plsEdFinanciamentoCachEnter(Sender: TObject);
    procedure plsEdFinanciamentoCachKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsEdFinanciamentoValorFinanciadoKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsEdFinanciamentoValorFinanciadoEnter(Sender: TObject);
    procedure plsMmObservacaoEnter(Sender: TObject);
    procedure plsMmObservacaoKeyPress(Sender: TObject; var Key: Char);
    procedure plsMmCaracteristicasKeyPress(Sender: TObject; var Key: Char);
    procedure plsMmCaracteristicasEnter(Sender: TObject);
    procedure lblDicasClick(Sender: TObject);
  private
    FoImovelInteresse: TObjImovelInteresse;
    FoClienteInteresse: TTiposPessoas;
    FoCondicaoPagamento: TCondicoesPagamento;
    FoFinalidadeImovel: TFinalidadesImovel;
    FoSituacaoImovel: TSituacoesImovel;

    FoConjuntoDadosTipoImovel: TConjuntoDadosTipoImovel;
    FoConjuntoDadosClientePessoaFisica: TConjuntoDadosClientePessoaFisica;
    FoConjuntoDadosClientePessoaJuridica: TConjuntoDadosClientePessoaJuridica;
    FoConjuntoDadosRegiaoLocalidade: TConjuntoDadosRegiaoLocalidade;

    procedure carregarObjeto(); override;
    procedure carregarComponentesApresentacao(); override;
    procedure selecionarTodosDados(); override;
    procedure limparObjeto(); override;
    procedure limparTela(poForm: TForm); override;
    function verificarHouveAlteracoes(): boolean; override;
    function verificarCamposObrigatorios(): boolean; override;
    function verificarRegistroJaExiste(): boolean; override;
    procedure visibilidade(pnVisib: Integer); override;
    function outrasValidacoesAntesSalvar(): Boolean; override;
    procedure novo(); override;
    function salvar(): Boolean; override;
    function excluir(): Boolean; override;
    procedure AbreTelaSelecaoTipoImovel(pnTpSelecao:Word);
    procedure VerificarTipoImovelExiste();
    procedure AbreTelaSelecaoClientePessoaFisica(pnTpSelecao:Word);
    procedure VerificarClientePessoaFisicaExiste();
    procedure AbreTelaSelecaoClientePessoaJuridica(pnTpSelecao:Word);
    procedure VerificarClientePessoaJuridicaExiste();
    procedure BuscarAgenciamentosSatisfaz(pnCdImovInteresse: Integer);

    procedure AbreTelaSelecaoRegiaoLocalidade(pnTpSelecao:Word);
    //procedure ExibirRegioesLocalidades;
    procedure CriarDataSetRegioesLocalidades;
    procedure AdicionarRegiaoLocalidade;
    procedure DeletarRegiaoLocalidade;
    function GetCdImovelInteresseInserido: Integer;
  public
    FoCliente: TCliente;
    FoTipoImovel: TTipoImovel;
    FoRegiaoLocalidade: TRegiaoLocalidade;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;


var
  frmCadImovelInteresse: TfrmCadImovelInteresse;

implementation

uses unConstantes, unDM, unSelecionaRegistroImovel, unSelecionaRegistroTipoImovel,
  unSelecionaRegistroCliente, unSelecionaRegistroClientePessoaJuridica,
  unSelecionarCaracBemNegociavel, unSelecionarCaracImovel, unBuscarAgenciamentosParaImovelInteresse,
  unSelecionaRegistroRegiaoLocalidade,unPrincipal,unExibirAgenciamentosParaImovelInteresse;

const
  fnSELECIONAR_TIPO_IMOVEL_NORMAL    = 1;
  fnSELECIONAR_TIPO_IMOVEL_DIGITANDO = 2;

  fnSELECIONAR_CLIENTE_PESSOA_FISICA_NORMAL    = 1;
  fnSELECIONAR_CLIENTE_PESSOA_FISICA_DIGITANDO = 2;

  fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_NORMAL    = 1;
  fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_DIGITANDO = 2;

  fnSELECIONAR_REGIAO_LOCALIDADE_NORMAL    = 1;
  fnSELECIONAR_REGIAO_LOCALIDADE_DIGITANDO = 2;

{$R *.dfm}

{ TfrmCadImovelInteresse }

(* procedimentos de controle *)

procedure TfrmCadImovelInteresse.iniciarTela(poForm: TForm);
begin
  inherited;        
(*  Application.CreateForm(TfrmPesquisandoAgenciamento, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmPesquisandoAgenciamento);
  Self.FoPesquisa.Hide;
*)
end;

procedure TfrmCadImovelInteresse.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;
(*  if(pTipo = PRM_CRIA_TELA_PESQUISA)then
  begin
    Application.CreateForm(TfrmPesquisandoAgenciamento, Self.FoPesquisa);
    Self.FoPesquisa.passarParametro(PRM_INICIAR_TELA, null);
    Self.FoPesquisa.iniciarTela(frmCadAgenciamento);
    if(Assigned(Self.FoPesquisa))then
      Self.FoPesquisa.Hide;
  end

  else if (pTipo = PRM_INSERIU_IMOVEL)then
  begin
    if(VarIsNumeric(pValores[0]))then
    begin
      Self.FoImovel.codigo := pValores[0];
      Self.FoImovel.nome := pValores[1];
      plsEdImovel.Text := pValores[1];
    end
    else
    begin
      Self.FoImovel.codigo := NUMERO_INDEFINIDO;
      Self.FoImovel.nome := STRING_INDEFINIDO;
      plsEdImovel.Text := STRING_INDEFINIDO;
    end;
  end;
*)
  if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS)then
  begin
    if(pValores[0] = CONJUNTO_DADOS_TIPO_IMOVEL)then
      FoConjuntoDadosTipoImovel.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_CLIENTE_PESSOA_FISICA)then
      FoConjuntoDadosClientePessoaFisica.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_CLIENTE_PESSOA_JURIDICA)then
      FoConjuntoDadosClientePessoaJuridica.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_REGIAO_LOCALIDADE)then
      FoConjuntoDadosRegiaoLocalidade.ExecutarSQLSelecao();
  end;
end;

procedure TfrmCadImovelInteresse.limparObjeto();
begin
  if (Assigned(Self.FoImovelInteresse)) then
  begin
    Self.FoImovelInteresse.limparObjeto();
  end
end;

procedure TfrmCadImovelInteresse.limparTela(poForm: TForm);
begin
  inherited;
  rdGrpTipoPessoa.ItemIndex := -1;

  Self.FoCliente.codigo := NUMERO_INDEFINIDO;
  Self.FoCliente.nome := STRING_INDEFINIDO;

  Self.FoTipoImovel.codigo := NUMERO_INDEFINIDO;
  Self.FoTipoImovel.nome := STRING_INDEFINIDO;

  Self.FoCondicaoPagamento := [];
  Self.FoFinalidadeImovel := [];
  Self.FoSituacaoImovel := [];
  FoClienteInteresse := [];
end;

function TfrmCadImovelInteresse.verificarHouveAlteracoes(): boolean;
begin
  Result := True;
end;

function TfrmCadImovelInteresse.verificarCamposObrigatorios(): boolean;
var
  bRetorno: Boolean;
  compFoco: TWinControl;
  campos: string;
  sAux: string;
  dValorImovel: Double;
begin
  bRetorno := True;
  compFoco := nil;
  campos := '';
  sAux := '';

  if(not(Self.FoFuncoes.validarData(plsMedDataCaptacao.Text)))then
  begin
    campos := 'Data de Captação';
    compFoco := plsMedDataCaptacao;
  end;

  if(Self.FoClienteInteresse = [])then
  begin
    if(campos <> '')then
      campos := campos + ', Tipo de Pessoa'
    else
    begin
      campos := 'Tipo de Pessoa';
    end;
  end;

  if(Self.FoCliente.codigo = NUMERO_INDEFINIDO)then
  begin
    if(campos <> '')then
      campos := campos + ', Cliente'
    else
    begin
      campos := 'Cliente';
    end;
    if(compFoco = nil)then
      compFoco := plsEdCliente;
  end;

  if(Self.FoTipoImovel.codigo = NUMERO_INDEFINIDO)then
  begin
    if(campos <> '')then
      campos := campos + ', Tipo do Imóvel'
    else
    begin
      campos := 'Tipo do Imóvel';
    end;
    if(compFoco = nil)then
      compFoco := plsEdTipoImovel;
  end;

  if(Self.FoFinalidadeImovel = [])then
  begin
    if(campos <> '')then
      campos := campos + ', Finalidade'
    else
    begin
      campos := 'Finalidade';
    end;
    if(compFoco = nil)then
      compFoco := plsCbBxFinalidade;
  end;

  if(Self.FoSituacaoImovel = [])then
  begin
    if(campos <> '')then
      campos := campos + ', Situação'
    else
    begin
      campos := 'Situação';
    end;
    if(compFoco = nil)then
      compFoco := plsCbBxSituacao;
  end;

  if(Self.FoCondicaoPagamento = [])then
  begin
    if(campos <> '')then
      campos := campos + ', Condição de Pagamento'
    else
    begin
      campos := 'Condição de Pagamento';
    end;
    if(compFoco = nil)then
      compFoco := plsCbBxCondicaoPagamento;
  end;

  try
    dValorImovel := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdValorImovel.Text, '.'));
  except
    if(campos <> '')then
      campos := campos + ', Valor do Imóvel'
    else
    begin
      campos := 'Valor do Imóvel';
    end;
    if(compFoco = nil)then
      compFoco := plsEdValorImovel;
  end;

  if(campos <> '')then
  begin
    MessageDlg('Antes de salvar, verifique os campos: ' + campos + '.', mtInformation, [mbOK], 0);
    bRetorno := False;
  end;

  //setar foco no componente que não foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    Self.FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

function TfrmCadImovelInteresse.verificarRegistroJaExiste(): boolean;
begin
  Result := False;
end;

procedure TfrmCadImovelInteresse.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsMedDataCaptacao.Enabled := False;
                       pnlDataBaixa.Visible := False;
                       pnlCliente.Enabled := False;
                       pnlTipoImovel.Enabled := False;
                       plsCbBxFinalidade.Enabled := False;
                       plsCbBxSituacao.Enabled := False;
                       plsCbBxCondicaoPagamento.Enabled := False;
                       plsEdValorImovel.Enabled := False;
                       grpBxCondicaoPagamentoVista.Visible := False;
                       grpBxCondicaoPagamentoFinanciamento.Visible := False;
                       plsMmObservacao.Enabled := False;
                       plsMmCaracteristicas.Enabled := False;
                       pnlAddDeleteRegiaoLocalidade.Enabled := False;
                       cdsRegiaoLocalidade.Close;
                       Self.FoFuncoes.focarComponente(plsEdCodigo);
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_IMOVEL_DE_INTERESSE,True));
                       plsEdCodigo.Enabled := False;
                       plsMedDataCaptacao.Enabled := True;
                       rdGrpTipoPessoa.ItemIndex := 0;
                       pnlDataBaixa.Visible := False;
                       pnlCliente.Enabled := True;
                       pnlTipoImovel.Enabled := True;
                       plsCbBxFinalidade.Enabled := True;
                       plsCbBxSituacao.Enabled := True;
                       plsCbBxCondicaoPagamento.Enabled := True;
                       plsEdValorImovel.Enabled := True;
                       //grpBxCondicaoPagamentoVista.Visible := True;
                       //grpBxCondicaoPagamentoFinanciamento.Visible := True;
                       plsMmObservacao.Enabled := True;
                       plsMmCaracteristicas.Enabled := True;
                       pnlAddDeleteRegiaoLocalidade.Enabled := True;
                       cdsRegiaoLocalidade.Open;
                       if(cdsRegiaoLocalidade.Active)and(cdsRegiaoLocalidade.RecordCount > NUMERO_INDEFINIDO)then
                         cdsRegiaoLocalidade.EmptyDataSet;                  
                       Self.FoFuncoes.focarComponente(plsMedDataCaptacao);
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       plsMedDataCaptacao.Enabled := True;
                       pnlDataBaixa.Visible := False;
                       pnlCliente.Enabled := True;
                       pnlTipoImovel.Enabled := True;
                       plsCbBxFinalidade.Enabled := True;
                       plsCbBxSituacao.Enabled := True;
                       plsCbBxCondicaoPagamento.Enabled := True;
                       plsEdValorImovel.Enabled := True;
                       //grpBxCondicaoPagamentoVista.Visible := True;
                       //grpBxCondicaoPagamentoFinanciamento.Visible := True;
                       plsMmObservacao.Enabled := True;
                       plsMmCaracteristicas.Enabled := True;
                       pnlAddDeleteRegiaoLocalidade.Enabled := True;
                       cdsRegiaoLocalidade.Open;
                       Self.FoFuncoes.focarComponente(plsMedDataCaptacao);
                     end;
    OPC_SALVAR:      begin

                     end;
    OPC_EXCLUIR:     begin

                     end;
    OPC_CANCELAR:    begin

                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       plsMedDataCaptacao.Enabled := False;
                       pnlDataBaixa.Visible := False;
                       pnlCliente.Enabled := False;
                       pnlTipoImovel.Enabled := False;
                       plsCbBxFinalidade.Enabled := False;
                       plsCbBxSituacao.Enabled := False;
                       plsCbBxCondicaoPagamento.Enabled := False;
                       plsEdValorImovel.Enabled := False;
                       grpBxCondicaoPagamentoVista.Visible := False;
                       grpBxCondicaoPagamentoFinanciamento.Visible := False;
                       plsMmObservacao.Enabled := False;
                       plsMmCaracteristicas.Enabled := False;
                     end;
  end; //fim - case
end;

function TfrmCadImovelInteresse.outrasValidacoesAntesSalvar(): Boolean;
var
  compFoco: TWinControl;
  dValorTotal: Currency;
  bRetorno: Boolean;

  procedure validarPagamentoVista();
  var
    dVistaCach,dVistaValorBem: Currency;
    dTotalValorVista: Currency;
  begin
    try
      dVistaCach := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdVistaCach.Text, '.'));
    except
      dVistaCach := NUMERO_INDEFINIDO;
    end;
    try
      dVistaValorBem := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdVistaBemValor.Text, '.'));
    except
      dVistaValorBem := NUMERO_INDEFINIDO;
    end;

    dTotalValorVista := dVistaCach + dVistaValorBem;
    if(dTotalValorVista > dValorTotal)then
    begin
      MessageDlg('O total do valor à vista não pode ser superior que o valor total.',mtWarning,[mbOK],0);
      compFoco := plsEdValorImovel;
      bRetorno := False;
    end;
  end; //fim - validarPagamentoVista()

  procedure validarPagamentoFinanciamento();
  var
    dFinctoCach,dFinctoValorFinanciado,dFinctoValorBem: Currency;
    dTotalValorFincto: Currency;
  begin
    try
      dFinctoCach := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdFinanciamentoCach.Text, '.'));
    except
      dFinctoCach := NUMERO_INDEFINIDO;
    end;
    try
      dFinctoValorFinanciado := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdFinanciamentoValorFinanciado.Text, '.'));
    except
      dFinctoValorFinanciado := NUMERO_INDEFINIDO;
    end;
    try
      dFinctoValorBem := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdFinanciamentoBemValor.Text, '.'));
    except
      dFinctoValorBem := NUMERO_INDEFINIDO;
    end;

    dTotalValorFincto := dFinctoCach + dFinctoValorFinanciado + dFinctoValorBem;
    if(dTotalValorFincto > dValorTotal)then
    begin
      MessageDlg('O total do valor do financiamento não pode ser superior que o valor total.',mtWarning,[mbOK],0);
      compFoco := plsEdValorImovel;
      bRetorno := False;
    end;
  end; //fim - validarPagamentoFinanciamento()

  procedure validarDescricaoBemVista();
  var
    dValorBem: Currency;
  begin
    try
      dValorBem := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdVistaBemValor.Text, '.'));
    except
      dValorBem := NUMERO_INDEFINIDO;
    end;
    if((dValorBem <> NUMERO_INDEFINIDO)and(Trim(plsMmVistaBemDescricao.Text) = STRING_INDEFINIDO))then
    begin
      MessageDlg('Insira a descrição do bem.',mtWarning,[mbOK],0);
      compFoco := plsMmVistaBemDescricao;
      bRetorno := False;
    end;
  end; //fim - validarDescricaoBemVista()

  procedure validarDescricaoBemFinanciamento();
  var
    dValorBem: Currency;
  begin                    
    try
      dValorBem := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdFinanciamentoBemValor.Text, '.'));
    except
      dValorBem := NUMERO_INDEFINIDO;
    end;
    if((dValorBem <> NUMERO_INDEFINIDO)and(Trim(plsMmFinanciamentoBemDescricao.Text) = STRING_INDEFINIDO))then
    begin
      MessageDlg('Insira a descrição do bem.',mtWarning,[mbOK],0);
      compFoco := plsMmFinanciamentoBemDescricao;
      bRetorno := False;
    end;
  end; //fim - validarDescricaoBemFinanciamento()

  procedure validarTotalValorVista();
  var
    dTotal: Currency;
    dCach,dValorBem: Currency;
  begin
    try
      dTotal := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdValorImovel.Text, '.'));
    except
      dTotal := NUMERO_INDEFINIDO;
    end;
    try
      dCach := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdVistaCach.Text, '.'));
    except
      dCach := NUMERO_INDEFINIDO;
    end;
    try
      dValorBem := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdVistaBemValor.Text, '.'));
    except
      dValorBem := NUMERO_INDEFINIDO;
    end;

    if(dTotal <> dCach+dValorBem)then
    begin
      MessageDlg('O valor total é diferente da soma do valor à vista informado.',mtWarning,[mbOK],0);
      compFoco := plsEdValorImovel;
      bRetorno := False;
    end;
  end; //validarTotalValorVista();


  procedure validarTotalValorFinanciamento();
  var
    dTotal: Currency;
    dCach,dValorFinanciado,dValorBem: Currency;
  begin
    try
      dTotal := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdValorImovel.Text, '.'));
    except
      dTotal := NUMERO_INDEFINIDO;
    end;
    try
      dCach := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdFinanciamentoCach.Text, '.'));
    except
      dCach := NUMERO_INDEFINIDO;
    end;
    try
      dValorFinanciado := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdFinanciamentoValorFinanciado.Text, '.'));
    except
      dValorFinanciado := NUMERO_INDEFINIDO;
    end;
    try
      dValorBem := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdFinanciamentoBemValor.Text, '.'));
    except
      dValorBem := NUMERO_INDEFINIDO;
    end;

    if(dTotal <> dCach+dValorFinanciado+dValorBem)then
    begin
      MessageDlg('O valor total é diferente da soma do valor do financiamento informado.',mtWarning,[mbOK],0);
      compFoco := plsEdValorImovel;
      bRetorno := False;
    end;
  end; //fim - validarTotalValorFinanciamento()

begin                
  compFoco := nil;
  bRetorno := True;

  //validando valor total
  try
    dValorTotal := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdValorImovel.Text, '.'));
  except
    dValorTotal := NUMERO_INDEFINIDO;
  end;

  if(Self.FoCondicaoPagamento = [vista])then
  begin
    validarPagamentoVista();
    if(bRetorno)then
      validarDescricaoBemVista();
  end;

  if(bRetorno)then
  begin
    if(Self.FoCondicaoPagamento = [aceitaFinanciamento])then
    begin
      validarPagamentoFinanciamento();
      if(bRetorno)then
        validarDescricaoBemFinanciamento();
    end;
  end;

  //valor vista/financiamento deve ser igual ao valor total
  if(bRetorno)then
  begin
    if(Self.FoCondicaoPagamento = [aceitaFinanciamento])then
      validarTotalValorFinanciamento()
    else if(Self.FoCondicaoPagamento = [vista])then
      validarTotalValorVista();
  end;

  //setar foco no componente que não foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    Self.FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

procedure TfrmCadImovelInteresse.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadImovelInteresse);
  visibilidade(OPC_NOVO);
  plsMedDataCaptacao.Text := DateToStr(Now);
end;

function TfrmCadImovelInteresse.salvar(): boolean;
var
  bSalvou: boolean;

  sAtivo, sTipoPessoa: String;
  dtDataCaptacao: TDate;
  nCodFK_ClientePesssoaFisica,nCodFK_ClientePesssoaJuridica: Integer;
  nCodFk_TipoImovel: Integer;
  sFinalidadeImovel, sImovelDesejavel: String;
  dValorImovel: Currency;
  sCondicaoPagamento: String;
  dPgtoVistaCach,dPgtoVistaValorBem: Currency;
  sPgtoVistaDescricaoBem: String;
  dPgtoFinctoCach,dPgtoFinctoCachFinanciado,dPgtoFinctoValorBem: Currency;
  sPgtoFinctoDescricaoBem: String;
  sObservacao: String;
  sCaracteristicas: String;
  nCodigo: Integer;

  procedure carregarValores();
  begin
    sAtivo := VLR_SIM;
    dtDataCaptacao := StrToDate(plsMedDataCaptacao.Text);

    //nCodFk_Cliente := Self.FoCliente.codigo;
    if(FoClienteInteresse = [pessoaFisica])then
    begin
      sTipoPessoa := VLR_TP_PESSOA_FISICA;
      nCodFK_ClientePesssoaFisica := FoCliente.codigo;
      nCodFK_ClientePesssoaJuridica := REGISTRO_NULO;
    end
    else if(FoClienteInteresse = [pessoaJuridica])then
    begin
      sTipoPessoa := VLR_TP_PESSOA_JURIDICA;
      nCodFK_ClientePesssoaFisica := REGISTRO_NULO;
      nCodFK_ClientePesssoaJuridica := FoCliente.codigo;
    end
    else
    begin
      sTipoPessoa := STRING_INDEFINIDO;
      nCodFK_ClientePesssoaFisica := REGISTRO_NULO;
      nCodFK_ClientePesssoaJuridica := REGISTRO_NULO;
    end;

    nCodFk_TipoImovel := Self.FoTipoImovel.codigo;

    if(Self.FoFinalidadeImovel = [morar])then
      sFinalidadeImovel := VLR_FINALIDADE_MORAR
    else if(Self.FoFinalidadeImovel = [investir])then
      sFinalidadeImovel := VLR_FINALIDADE_INVESTIR
    else
      sFinalidadeImovel := STRING_INDEFINIDO;

    if(Self.FoSituacaoImovel = [planta])then
      sImovelDesejavel := VLR_SITUACAO_PLANTA
    else if(Self.FoSituacaoImovel = [prontoMorar])then
      sImovelDesejavel := VLR_SITUACAO_PRONTO_PARA_MORAR
    else if(Self.FoSituacaoImovel = [deTerceiros])then
      sImovelDesejavel := VLR_SITUACAO_DE_TERCEIROS
    else
      sImovelDesejavel := STRING_INDEFINIDO;

    try
      dValorImovel := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdValorImovel.Text, '.'));
    except
      dValorImovel := NUMERO_INDEFINIDO;
    end;

    if(Self.FoCondicaoPagamento = [vista])then
    begin
      sCondicaoPagamento := VLR_CD_PAGAMENTO_VISTA;
      try
        dPgtoVistaCach := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdVistaCach.Text, '.'));
      except
        dPgtoVistaCach := NUMERO_INDEFINIDO;
      end;
      try
        dPgtoVistaValorBem := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdVistaBemValor.Text, '.'));
      except
        dPgtoVistaValorBem := NUMERO_INDEFINIDO;
      end;
      sPgtoVistaDescricaoBem := Trim(plsMmVistaBemDescricao.Text);
      dPgtoFinctoCach := NUMERO_INDEFINIDO;
      dPgtoFinctoCachFinanciado := NUMERO_INDEFINIDO;
      dPgtoFinctoValorBem := NUMERO_INDEFINIDO;
      sPgtoFinctoDescricaoBem := STRING_INDEFINIDO;
    end
    else if(Self.FoCondicaoPagamento = [aceitaFinanciamento])then
    begin
      sCondicaoPagamento := VLR_CD_PAGAMENTO_ACEITA_FINANCIAMENTO;
      dPgtoVistaCach := NUMERO_INDEFINIDO;
      dPgtoVistaValorBem := NUMERO_INDEFINIDO;
      sPgtoVistaDescricaoBem := STRING_INDEFINIDO;
      try
        dPgtoFinctoCach := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdFinanciamentoCach.Text, '.'));
      except
        dPgtoFinctoCach := NUMERO_INDEFINIDO;
      end;
      try
        dPgtoFinctoCachFinanciado := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdFinanciamentoValorFinanciado.Text, '.'));
      except
        dPgtoFinctoCachFinanciado := NUMERO_INDEFINIDO;
      end;
      try
        dPgtoFinctoValorBem := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdFinanciamentoBemValor.Text, '.'));
      except
        dPgtoFinctoValorBem := NUMERO_INDEFINIDO;
      end;
      sPgtoFinctoDescricaoBem := Trim(plsMmFinanciamentoBemDescricao.Text);
    end
    else
    begin
      sCondicaoPagamento := STRING_INDEFINIDO;
      dPgtoVistaCach := NUMERO_INDEFINIDO;
      dPgtoVistaValorBem := NUMERO_INDEFINIDO;
      sPgtoVistaDescricaoBem := STRING_INDEFINIDO;
      dPgtoFinctoCach := NUMERO_INDEFINIDO;
      dPgtoFinctoCachFinanciado := NUMERO_INDEFINIDO;
      dPgtoFinctoValorBem := NUMERO_INDEFINIDO;
      sPgtoFinctoDescricaoBem := STRING_INDEFINIDO;
    end;

    sObservacao := Trim(plsMmObservacao.Text);
    sCaracteristicas := Trim(plsMmCaracteristicas.Text);
  end;

  //limpa parâmetro nulos - para o insert e update
  procedure limparParametrosNulos();
  begin
    if(dtDataCaptacao = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('data_captacao').Clear;
  end;

  procedure InserirImovInteresseRegiaoLocal;
  begin
    cdsRegiaoLocalidade.First;
    while not(cdsRegiaoLocalidade.Eof)do
    begin
      DM.zQryImovInteresseRegiaoLocal.Close;
      DM.zQryImovInteresseRegiaoLocal.SQL.Clear;
      DM.zQryImovInteresseRegiaoLocal.SQL.Add('INSERT INTO imov_interesse_regiao_local (cod_fk_imovel_de_interesse, cod_fk_regiao_localidade) ');
      DM.zQryImovInteresseRegiaoLocal.SQL.Add('VALUES (:cod_fk_imovel_de_interesse, :cod_fk_regiao_localidade)');
      DM.zQryImovInteresseRegiaoLocal.ParamByName('cod_fk_imovel_de_interesse').AsInteger := nCodigo;
      DM.zQryImovInteresseRegiaoLocal.ParamByName('cod_fk_regiao_localidade').AsInteger := cdsRegiaoLocalidade.FieldByName('CODIGO_REGIAO_LOCALIDADE').AsInteger;
      DM.zQryImovInteresseRegiaoLocal.ExecSQL;
      cdsRegiaoLocalidade.Next;
    end;
  end;

begin
  carregarValores();
  bSalvou := False;

  if(Self.FiFuncaoRegistro in [FUNCAO_REGISTRO_NOVO]) then
  begin
    inherited;
    try
      DM.ZConnection.StartTransaction;
      zQryDados.Close;
      zQryDados.SQL.Clear;
      zQryDados.SQL.Add('INSERT INTO imovel_de_interesse(ativo,data_captacao,');
      zQryDados.SQL.Add('tipo_pessoa,cod_fk_cliente_pessoa_fisica,');
      zQryDados.SQL.Add('cod_fk_cliente_pessoa_juridica,cod_fk_Tipo_Imovel,finalidade_imovel,');
      zQryDados.SQL.Add('imovel_desejavel,valor_imovel,condicao_pagamento,');
      zQryDados.SQL.Add('pgto_vista_cach,pgto_vista_valor_bem,');
      zQryDados.SQL.Add('pgto_vista_descricao_bem,pgto_fincto_cach_financiado,');
      zQryDados.SQL.Add('pgto_fincto_cach,pgto_fincto_valor_bem,pgto_fincto_descricao_bem,');
      zQryDados.SQL.Add('observacao,caracteristicas) ');

      zQryDados.SQL.Add('VALUES(:ativo,:data_captacao,:tipo_pessoa,');
      zQryDados.SQL.Add(':cod_fk_cliente_pessoa_fisica,:cod_fk_cliente_pessoa_juridica,');
      zQryDados.SQL.Add(':cod_fk_Tipo_Imovel,:finalidade_imovel,:imovel_desejavel,');
      zQryDados.SQL.Add(':valor_imovel,:condicao_pagamento,:pgto_vista_cach,');
      zQryDados.SQL.Add(':pgto_vista_valor_bem,:pgto_vista_descricao_bem,');
      zQryDados.SQL.Add(':pgto_fincto_cach_financiado,:pgto_fincto_cach,');
      zQryDados.SQL.Add(':pgto_fincto_valor_bem,:pgto_fincto_descricao_bem,');
      zQryDados.SQL.Add(':observacao,:caracteristicas)');

      zQryDados.ParamByName('ativo').AsString := sAtivo;
      zQryDados.ParamByName('data_captacao').AsDate := dtDataCaptacao;
      zQryDados.ParamByName('tipo_pessoa').AsString := sTipoPessoa;
      zQryDados.ParamByName('cod_fk_cliente_pessoa_fisica').AsInteger := nCodFK_ClientePesssoaFisica;
      zQryDados.ParamByName('cod_fk_cliente_pessoa_juridica').AsInteger := nCodFK_ClientePesssoaJuridica;
      //zQryDados.ParamByName('cod_fk_cliente').AsInteger := nCodFk_Cliente;
      zQryDados.ParamByName('cod_fk_Tipo_Imovel').AsInteger := nCodFk_TipoImovel;
      zQryDados.ParamByName('finalidade_imovel').AsString := sFinalidadeImovel;
      zQryDados.ParamByName('imovel_desejavel').AsString := sImovelDesejavel;
      zQryDados.ParamByName('valor_imovel').AsCurrency := dValorImovel;
      zQryDados.ParamByName('condicao_pagamento').AsString := sCondicaoPagamento;
      zQryDados.ParamByName('pgto_vista_cach').AsCurrency := dPgtoVistaCach;
      zQryDados.ParamByName('pgto_vista_valor_bem').AsCurrency := dPgtoVistaValorBem;
      zQryDados.ParamByName('pgto_vista_descricao_bem').AsString := sPgtoVistaDescricaoBem;
      zQryDados.ParamByName('pgto_fincto_cach_financiado').AsCurrency := dPgtoFinctoCachFinanciado;
      zQryDados.ParamByName('pgto_fincto_cach').AsCurrency := dPgtoFinctoCach;
      zQryDados.ParamByName('pgto_fincto_valor_bem').AsCurrency := dPgtoFinctoValorBem;
      zQryDados.ParamByName('pgto_fincto_descricao_bem').AsString := sPgtoFinctoDescricaoBem;
      zQryDados.ParamByName('observacao').AsString := sObservacao;
      zQryDados.ParamByName('caracteristicas').AsString := sCaracteristicas;
      limparParametrosNulos();
      zQryDados.ExecSQL();

      //pegando código do imóvel de interesse que foi inserido
        DM.zQryImovelDeInteresse.Close;
        DM.zQryImovelDeInteresse.SQL.Clear;
        DM.zQryImovelDeInteresse.SQL.Add('SELECT * FROM imovel_de_interesse ORDER BY codigo DESC ROWS 1');
        DM.zQryImovelDeInteresse.Open;
        if(DM.zQryImovelDeInteresse.RecordCount = 1)then
        begin
          nCodigo := DM.zQryImovelDeInteresseCODIGO.AsInteger;
          //inserindo imov_interesse_regiao_local
          InserirImovInteresseRegiaoLocal;
        end;
      DM.ZConnection.Commit;
      bSalvou := True;
    except
      DM.ZConnection.Rollback;
    end;
  end;

  //busca por agenciamentos 'parecidos' com este imóvel de interesse
  if(bSalvou)then
    BuscarAgenciamentosSatisfaz(GetCdImovelInteresseInserido);

  Result := bSalvou;
end;

function TfrmCadImovelInteresse.excluir(): Boolean;
begin
  Result := False;
end;

procedure TfrmCadImovelInteresse.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

procedure TfrmCadImovelInteresse.carregarObjeto();
begin
end;

procedure TfrmCadImovelInteresse.carregarComponentesApresentacao();
begin
  //ExibirRegioesLocalidades;
end;

procedure TfrmCadImovelInteresse.selecionarTodosDados();
begin
end;

procedure TfrmCadImovelInteresse.AbreTelaSelecaoTipoImovel(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME; //campo a filtrar
  vParametros[1] := plsEdTipoImovel.Text; //valor do filtro
  vParametros[2] := False; //não deixar selecionar todos os dados

  case pnTpSelecao of

    fnSELECIONAR_TIPO_IMOVEL_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroTipoImovel, frmSelecionaRegistroTipoImovel);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL_INTERESSE);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdTipoImovel.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroTipoImovel.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadImovelInteresse,frmSelecionaRegistroTipoImovel,pnlTipoImovel,ToolBar);
        frmSelecionaRegistroTipoImovel.ShowModal;
      finally
        if(Self.FoTipoImovel.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdTipoImovel.Text := Self.FoTipoImovel.nome;
          Self.FoFuncoes.focarComponente(plsCbBxFinalidade);
        end;
        FreeAndNil(frmSelecionaRegistroTipoImovel);
      end;
    end;

    fnSELECIONAR_TIPO_IMOVEL_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroTipoImovel, frmSelecionaRegistroTipoImovel);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL_INTERESSE);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadImovelInteresse,frmSelecionaRegistroTipoImovel,pnlTipoImovel,ToolBar);
        frmSelecionaRegistroTipoImovel.ShowModal;
      finally
        if(Self.FoTipoImovel.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdTipoImovel.Text := Self.FoTipoImovel.nome;
          FoFuncoes.focarComponente(plsCbBxFinalidade);
        end
        else
          plsEdTipoImovel.Clear;
        FreeAndNil(frmSelecionaRegistroTipoImovel);
      end;
    end;

  end;

end;

procedure TfrmCadImovelInteresse.VerificarTipoImovelExiste();
begin
  if(plsEdTipoImovel.Text <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosTipoImovel.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdTipoImovel.Text + '%'));
    FoConjuntoDadosTipoImovel.ExecutarFiltrar();

    if(FoConjuntoDadosTipoImovel.TotalRegistros = 1)then
    begin
      FoTipoImovel.codigo := FoConjuntoDadosTipoImovel.GetCodigo;
      FoTipoImovel.nome := FoConjuntoDadosTipoImovel.GetNome;
      plsEdTipoImovel.Text := FoTipoImovel.nome;
    end
    else if(FoConjuntoDadosTipoImovel.TotalRegistros > 1)then
      AbreTelaSelecaoTipoImovel(fnSELECIONAR_TIPO_IMOVEL_DIGITANDO)
    else
    begin
      MessageDlg('Tipo de Imóvel não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdTipoImovel);
    end;
  end;
end;


procedure TfrmCadImovelInteresse.AbreTelaSelecaoClientePessoaFisica(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME; //campo a filtrar
  vParametros[1] := plsEdCliente.Text; //valor do filtro
  vParametros[2] := False; //não deixar selecionar todos os dados

  case pnTpSelecao of

    fnSELECIONAR_CLIENTE_PESSOA_FISICA_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroCliente, frmSelecionaRegistroCliente);
        frmSelecionaRegistroCliente.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroCliente.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL_INTERESSE);
        frmSelecionaRegistroCliente.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdCliente.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroCliente.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadImovelInteresse,frmSelecionaRegistroCliente,pnlCliente,ToolBar);
        frmSelecionaRegistroCliente.ShowModal;
      finally
        if(Self.FoCliente.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdCliente.Text := Self.FoCliente.nome;
          Self.FoFuncoes.focarComponente(plsEdTipoImovel);
        end;
        FreeAndNil(frmSelecionaRegistroCliente);
      end;
    end;

    fnSELECIONAR_CLIENTE_PESSOA_FISICA_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroCliente, frmSelecionaRegistroCliente);
        frmSelecionaRegistroCliente.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroCliente.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL_INTERESSE);
        frmSelecionaRegistroCliente.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroCliente.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadImovelInteresse,frmSelecionaRegistroCliente,pnlCliente,ToolBar);        
        frmSelecionaRegistroCliente.ShowModal;
      finally
        if(Self.FoCliente.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdCliente.Text := Self.FoCliente.nome;
          FoFuncoes.focarComponente(plsEdTipoImovel);
        end
        else
          plsEdCliente.Clear;
        FreeAndNil(frmSelecionaRegistroCliente);
      end;
    end;

  end;

end;

procedure TfrmCadImovelInteresse.VerificarClientePessoaFisicaExiste();
begin
  if(plsEdCliente.Text <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosClientePessoaFisica.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdCliente.Text + '%'));
    FoConjuntoDadosClientePessoaFisica.ExecutarFiltrar();

    if(FoConjuntoDadosClientePessoaFisica.TotalRegistros = 1)then
    begin
      FoCliente.codigo := FoConjuntoDadosClientePessoaFisica.GetCodigo;
      FoCliente.nome := FoConjuntoDadosClientePessoaFisica.GetNome;
      plsEdCliente.Text := FoCliente.nome;
    end
    else if(FoConjuntoDadosClientePessoaFisica.TotalRegistros > 1)then
      AbreTelaSelecaoClientePessoaFisica(fnSELECIONAR_CLIENTE_PESSOA_FISICA_DIGITANDO)
    else
    begin
      MessageDlg('Cliente não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdCliente);
    end;
  end;
end;

procedure TfrmCadImovelInteresse.AbreTelaSelecaoClientePessoaJuridica(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME; //campo a filtrar
  vParametros[1] := plsEdCliente.Text; //valor do filtro
  vParametros[2] := False; //não deixar selecionar todos os dados

  case pnTpSelecao of

    fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroClientePessoaJuridica, frmSelecionaRegistroClientePessoaJuridica);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL_INTERESSE);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdCliente.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadImovelInteresse,frmSelecionaRegistroClientePessoaJuridica,pnlCliente,ToolBar);
        frmSelecionaRegistroClientePessoaJuridica.ShowModal;
      finally
        if(Self.FoCliente.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdCliente.Text := Self.FoCliente.nome;
          Self.FoFuncoes.focarComponente(plsEdTipoImovel);
        end;
        FreeAndNil(frmSelecionaRegistroClientePessoaJuridica);
      end;
    end;

    fnSELECIONAR_CLIENTE_PESSOA_FISICA_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroClientePessoaJuridica, frmSelecionaRegistroClientePessoaJuridica);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL_INTERESSE);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadImovelInteresse,frmSelecionaRegistroClientePessoaJuridica,pnlCliente,ToolBar);
        frmSelecionaRegistroClientePessoaJuridica.ShowModal;
      finally
        if(Self.FoCliente.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdCliente.Text := Self.FoCliente.nome;
          FoFuncoes.focarComponente(plsEdTipoImovel);
        end
        else
          plsEdCliente.Clear;
        FreeAndNil(frmSelecionaRegistroClientePessoaJuridica);
      end;
    end;

  end;

end;

procedure TfrmCadImovelInteresse.VerificarClientePessoaJuridicaExiste();
begin
  if(plsEdCliente.Text <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosClientePessoaJuridica.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdCliente.Text + '%'));
    FoConjuntoDadosClientePessoaJuridica.ExecutarFiltrar();

    if(FoConjuntoDadosClientePessoaJuridica.TotalRegistros = 1)then
    begin
      FoCliente.codigo := FoConjuntoDadosClientePessoaJuridica.GetCodigo;
      FoCliente.nome := FoConjuntoDadosClientePessoaJuridica.GetNome;
      plsEdCliente.Text := FoCliente.nome;
    end
    else if(FoConjuntoDadosClientePessoaJuridica.TotalRegistros > 1)then
      AbreTelaSelecaoClientePessoaJuridica(fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_DIGITANDO)
    else
    begin
      MessageDlg('Cliente não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdCliente);
    end;
  end;
end;

procedure TfrmCadImovelInteresse.BuscarAgenciamentosSatisfaz(pnCdImovInteresse: Integer);
var
  oAgenciamentos: TAgenciamentosParaImovelInteresse;
  frmAgenc: TfrmAgenciamentosParaImovelInteresse;
begin
  oAgenciamentos := TAgenciamentosParaImovelInteresse.CriaObjeto(pnCdImovInteresse);
  if oAgenciamentos.GetTotalAgenciamentos > NUMERO_INDEFINIDO then
  begin
    try
      Application.CreateForm(TfrmAgenciamentosParaImovelInteresse,frmAgenc);
      frmAgenc.passarParametro(PRM_PASSAR_DATA_SET, oAgenciamentos.GetDataSet);
      frmAgenc.passarParametro(PRM_PASSAR_CODIGO_IMOVEL_INTERESSE,GetCdImovelInteresseInserido);
      frmAgenc.ShowModal;
    finally
      FreeAndNil(oAgenciamentos);
      FoFuncoes.fecharComponentesBD(frmAgenc);
      FreeAndNil(frmAgenc);
    end;
  end;
end;

procedure TfrmCadImovelInteresse.AbreTelaSelecaoRegiaoLocalidade(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  case pnTpSelecao of

    fnSELECIONAR_REGIAO_LOCALIDADE_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroRegiaoLocalidade, frmSelecionaRegistroRegiaoLocalidade);
        frmSelecionaRegistroRegiaoLocalidade.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL_INTERESSE);
        frmSelecionaRegistroRegiaoLocalidade.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroRegiaoLocalidade.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE, null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadImovelInteresse,frmSelecionaRegistroRegiaoLocalidade,pnlAddDeleteRegiaoLocalidade,ToolBar);
        frmSelecionaRegistroRegiaoLocalidade.ShowModal;
      finally
        if(Self.FoRegiaoLocalidade.codigo <> NUMERO_INDEFINIDO)then
          AdicionarRegiaoLocalidade;
        FreeAndNil(frmSelecionaRegistroRegiaoLocalidade);
      end;
    end;

    //fnSELECIONAR_REGIAO_LOCALIDADE_DIGITANDO:
  end;
end;

procedure TfrmCadImovelInteresse.CriarDataSetRegioesLocalidades;
begin
  if(cdsRegiaoLocalidade.Active)then
    cdsRegiaoLocalidade.EmptyDataSet;
  cdsRegiaoLocalidade.FieldDefs.Add('CODIGO_REGIAO_LOCALIDADE', ftInteger, 0, True);
  cdsRegiaoLocalidade.FieldDefs.Add('NOME_REGIAO_LOCALIDADE', ftString, 100, True);
  cdsRegiaoLocalidade.CreateDataSet;
  cdsRegiaoLocalidade.Open;
end;

procedure TfrmCadImovelInteresse.AdicionarRegiaoLocalidade;
begin
  cdsRegiaoLocalidade.First;
  if not(cdsRegiaoLocalidade.Locate('CODIGO_REGIAO_LOCALIDADE',FoRegiaoLocalidade.codigo,[])) then
  begin
    cdsRegiaoLocalidade.Append;
    cdsRegiaoLocalidade.FieldByName('CODIGO_REGIAO_LOCALIDADE').AsInteger := FoRegiaoLocalidade.codigo;
    cdsRegiaoLocalidade.FieldByName('NOME_REGIAO_LOCALIDADE').AsString := FoRegiaoLocalidade.nome;
    cdsRegiaoLocalidade.Post;
  end;
end;

procedure TfrmCadImovelInteresse.DeletarRegiaoLocalidade;
begin
end;

function TfrmCadImovelInteresse.GetCdImovelInteresseInserido: Integer;
begin
  DM.zQryImovelDeInteresse.Close;
  DM.zQryImovelDeInteresse.SQL.Clear;
  DM.zQryImovelDeInteresse.SQL.Add('SELECT * FROM imovel_de_interesse ORDER BY codigo DESC ROWS 1');
  DM.zQryImovelDeInteresse.Open;
  if(DM.zQryImovelDeInteresse.RecordCount = 1)then
    Result := DM.zQryImovelDeInteresseCODIGO.AsInteger
  else
    Result := NUMERO_INDEFINIDO;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadImovelInteresse.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoImovelInteresse := TObjImovelInteresse.Create;
  FoConjuntoDadosTipoImovel := TConjuntoDadosTipoImovel.CriaObjeto;
  FoConjuntoDadosClientePessoaFisica := TConjuntoDadosClientePessoaFisica.CriaObjeto;
  FoConjuntoDadosClientePessoaJuridica := TConjuntoDadosClientePessoaJuridica.CriaObjeto;
  FoConjuntoDadosRegiaoLocalidade := TConjuntoDadosRegiaoLocalidade.CriaObjeto;
  CriarDataSetRegioesLocalidades;
end;

procedure TfrmCadImovelInteresse.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoImovelInteresse);
  FreeAndNil(FoConjuntoDadosTipoImovel);
  FreeAndNil(FoConjuntoDadosClientePessoaFisica);
  FreeAndNil(FoConjuntoDadosClientePessoaJuridica);
  FreeAndNil(FoConjuntoDadosRegiaoLocalidade);
  if(Assigned(frmSelecionarCaracBemNegociavel))then
    FreeAndNil(frmSelecionarCaracBemNegociavel);
end;

procedure TfrmCadImovelInteresse.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadImovelInteresse.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo
end;

procedure TfrmCadImovelInteresse.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadImovelInteresse.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadImovelInteresse.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadImovelInteresse.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadImovelInteresse.plsCbBxCondicaoPagamentoChange(
  Sender: TObject);
begin
  inherited;
  case plsCbBxCondicaoPagamento.ItemIndex of
    0:
    begin
      grpBxCondicaoPagamentoVista.Visible := True;
      grpBxCondicaoPagamentoFinanciamento.Visible := False;
      Self.FoCondicaoPagamento := [vista];
    end;
    1:
    begin
      grpBxCondicaoPagamentoVista.Visible := False;
      grpBxCondicaoPagamentoFinanciamento.Visible := True;
      Self.FoCondicaoPagamento := [aceitaFinanciamento];
    end;
    else
    begin
      grpBxCondicaoPagamentoVista.Visible := False;
      grpBxCondicaoPagamentoFinanciamento.Visible := False;
      Self.FoCondicaoPagamento := [];
    end;
  end;

  if(Assigned(frmSelecionarCaracBemNegociavel))then
    FreeAndNil(frmSelecionarCaracBemNegociavel);  
end;

procedure TfrmCadImovelInteresse.spBtnBuscaTipoImovelClick(
  Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoTipoImovel(fnSELECIONAR_TIPO_IMOVEL_NORMAL);
end;

procedure TfrmCadImovelInteresse.plsCbBxFinalidadeChange(Sender: TObject);
begin
  inherited;

  case plsCbBxFinalidade.ItemIndex of
    0: Self.FoFinalidadeImovel := [morar];
    1: Self.FoFinalidadeImovel := [investir];
    else
      Self.FoFinalidadeImovel := [];
  end;
end;

procedure TfrmCadImovelInteresse.plsCbBxSituacaoChange(Sender: TObject);
begin
  inherited;

  case plsCbBxSituacao.ItemIndex of
    0: Self.FoSituacaoImovel := [planta];
    1: Self.FoSituacaoImovel := [prontoMorar];
    2: Self.FoSituacaoImovel := [deTerceiros];
    else
      Self.FoSituacaoImovel := [];
  end;
end;

procedure TfrmCadImovelInteresse.spBtnBuscaClienteClick(Sender: TObject);
begin
  inherited;

  if(FoClienteInteresse = [pessoaFisica])then
    AbreTelaSelecaoClientePessoaFisica(fnSELECIONAR_CLIENTE_PESSOA_FISICA_NORMAL)
  else if(FoClienteInteresse = [pessoaJuridica])then
    AbreTelaSelecaoClientePessoaJuridica(fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_NORMAL)
  else
    MessageDlg('Selecione um tipo de pessoa.', mtInformation, [mbOK], 0);
end;

procedure TfrmCadImovelInteresse.rdGrpTipoPessoaClick(Sender: TObject);
begin
  inherited;

  //caso já tivesse um cliente selecionado, limpa dados do cliente
  if(FoCliente.codigo <> NUMERO_INDEFINIDO)then
  begin
    if(Self.FoClienteInteresse = [pessoaFisica])and(rdGrpTipoPessoa.ItemIndex = 1)then
    begin
      FoCliente.codigo := NUMERO_INDEFINIDO;
      FoCliente.nome := STRING_INDEFINIDO;
      plsEdCliente.Clear;
    end
    else if(Self.FoClienteInteresse = [pessoaJuridica])and(rdGrpTipoPessoa.ItemIndex = 0)then
    begin
      FoCliente.codigo := NUMERO_INDEFINIDO;
      FoCliente.nome := STRING_INDEFINIDO;
      plsEdCliente.Clear;
    end;
  end;

  case rdGrpTipoPessoa.ItemIndex of
    0: FoClienteInteresse := [pessoaFisica];
    1: FoClienteInteresse := [pessoaJuridica];
    else FoClienteInteresse := [];
  end;
end;

procedure TfrmCadImovelInteresse.plsEdTipoImovelExit(Sender: TObject);
begin
  inherited;
  VerificarTipoImovelExiste();
end;

procedure TfrmCadImovelInteresse.plsEdClienteExit(Sender: TObject);
begin
  inherited;

  if(FoClienteInteresse = [pessoaFisica])then
    VerificarClientePessoaFisicaExiste
  else if(FoClienteInteresse = [pessoaJuridica])then
    VerificarClientePessoaJuridicaExiste
  else
  begin
    if(plsEdCliente.Text <> STRING_INDEFINIDO)then
      MessageDlg('Selecione um tipo de pessoa.', mtInformation, [mbOK], 0);
  end;
end;

procedure TfrmCadImovelInteresse.btBtnAdicionarRegiaoLocalidadeClick(
  Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoRegiaoLocalidade(fnSELECIONAR_REGIAO_LOCALIDADE_NORMAL);
end;

procedure TfrmCadImovelInteresse.btBtnDeletarRegiaoLocalidadeClick(
  Sender: TObject);
begin
  inherited;
  if(cdsRegiaoLocalidade.Active)and(cdsRegiaoLocalidade.RecordCount > NUMERO_INDEFINIDO)then
    cdsRegiaoLocalidade.Delete;
end;

procedure TfrmCadImovelInteresse.lblCaracteristicasClick(Sender: TObject);
var
  vParametros: OleVariant;
begin
  vParametros := VarArrayCreate([0,0], varVariant);
  vParametros[0] := nRECEBER_CARAC_CAD_IMOVEL_INTERESSE_CARACTERISTICA;

  Application.CreateForm(TfrmSelecionarCaracImovel, frmSelecionarCaracImovel);
  frmSelecionarCaracImovel.passarParametro(PRM_DEFINE_QUEM_RECEBE_CARACTERISTICAS_IMOVEL, vParametros);
  frmSelecionarCaracImovel.Show;
end;

procedure TfrmCadImovelInteresse.lblVistaBemDescricaoClick(
  Sender: TObject);
var
  vParametros: OleVariant;
begin
  vParametros := VarArrayCreate([0,0], varVariant);
  vParametros[0] := 3; //à vista

  Application.CreateForm(TfrmSelecionarCaracBemNegociavel, frmSelecionarCaracBemNegociavel);
  frmSelecionarCaracBemNegociavel.passarParametro(PRM_DEFINE_QUEM_RECEBE_CARACTERISTICAS_BEM_NEGOCIAVEL, vParametros);
  frmSelecionarCaracBemNegociavel.Show;
end;

procedure TfrmCadImovelInteresse.lblFinanciamentoBemDescricaoClick(
  Sender: TObject);
var
  vParametros: OleVariant;
begin
  vParametros := VarArrayCreate([0,0], varVariant);
  vParametros[0] := 4; //financiamento

  Application.CreateForm(TfrmSelecionarCaracBemNegociavel, frmSelecionarCaracBemNegociavel);
  frmSelecionarCaracBemNegociavel.passarParametro(PRM_DEFINE_QUEM_RECEBE_CARACTERISTICAS_BEM_NEGOCIAVEL, vParametros);
  frmSelecionarCaracBemNegociavel.Show;
end;

procedure TfrmCadImovelInteresse.plsMedDataCaptacaoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Data de Captação',False);
end;

procedure TfrmCadImovelInteresse.plsMedDataCaptacaoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Data de Captação',False);
end;

procedure TfrmCadImovelInteresse.rdGrpTipoPessoaEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Tipo de Pessoa',True,2);
end;

procedure TfrmCadImovelInteresse.plsCbBxCondicaoPagamentoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Condição de Pagamento',False,2);
end;

procedure TfrmCadImovelInteresse.plsCbBxCondicaoPagamentoEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Condição de Pagamento',False,2);
end;

procedure TfrmCadImovelInteresse.plsEdClienteEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Nome da Cliente');
end;

procedure TfrmCadImovelInteresse.plsEdClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Nome da Cliente');
end;

procedure TfrmCadImovelInteresse.plsEdTipoImovelEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Tipo do Imóvel');
end;

procedure TfrmCadImovelInteresse.plsEdTipoImovelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Tipo do Imóvel');
end;

procedure TfrmCadImovelInteresse.plsCbBxFinalidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Finalidade',False,2);
end;

procedure TfrmCadImovelInteresse.plsCbBxFinalidadeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Finalidade',False,2);
end;

procedure TfrmCadImovelInteresse.plsCbBxSituacaoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Situação',False,2);
end;

procedure TfrmCadImovelInteresse.plsCbBxSituacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Situação',False,2);
end;

procedure TfrmCadImovelInteresse.plsEdValorImovelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor do Imóvel');
end;

procedure TfrmCadImovelInteresse.plsEdValorImovelEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor do Imóvel');
end;

procedure TfrmCadImovelInteresse.plsEdVistaCachEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor à Vista em Cach');
end;

procedure TfrmCadImovelInteresse.plsEdVistaCachKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor à Vista em Cach');
end;

procedure TfrmCadImovelInteresse.plsEdVistaBemValorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor à Vista do Bem');
end;

procedure TfrmCadImovelInteresse.plsEdVistaBemValorEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor à Vista do Bem');
end;

procedure TfrmCadImovelInteresse.plsMmVistaBemDescricaoEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Descrição do Bem dado à Vista',False);
end;

procedure TfrmCadImovelInteresse.plsMmVistaBemDescricaoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Descrição do Bem dado à Vista',False);
end;

procedure TfrmCadImovelInteresse.plsMmFinanciamentoBemDescricaoEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Descrição do Bem dado à Vista',False);
end;

procedure TfrmCadImovelInteresse.plsMmFinanciamentoBemDescricaoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Descrição do Bem dado à Vista',False);
end;

procedure TfrmCadImovelInteresse.plsEdFinanciamentoBemValorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor à Vista do Bem');
end;

procedure TfrmCadImovelInteresse.plsEdFinanciamentoBemValorEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor à Vista do Bem');
end;

procedure TfrmCadImovelInteresse.plsEdFinanciamentoCachEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor à Vista em Cach');
end;

procedure TfrmCadImovelInteresse.plsEdFinanciamentoCachKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor à Vista em Cach');
end;

procedure TfrmCadImovelInteresse.plsEdFinanciamentoValorFinanciadoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor Financiado');
end;

procedure TfrmCadImovelInteresse.plsEdFinanciamentoValorFinanciadoEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor Financiado');
end;

procedure TfrmCadImovelInteresse.plsMmObservacaoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Observação do Imóvel de Interesse',False);
end;

procedure TfrmCadImovelInteresse.plsMmObservacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Observação do Imóvel de Interesse',False);
end;

procedure TfrmCadImovelInteresse.plsMmCaracteristicasKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Características do Imóvel de Interesse',False);
end;

procedure TfrmCadImovelInteresse.plsMmCaracteristicasEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Características do Imóvel de Interesse',False);
end;

procedure TfrmCadImovelInteresse.lblDicasClick(Sender: TObject);
begin
  inherited;
  FoFuncoes.CriarTelaDicas(FORM_CAD_IMOVEL_INTERESSE);
end;

end.
