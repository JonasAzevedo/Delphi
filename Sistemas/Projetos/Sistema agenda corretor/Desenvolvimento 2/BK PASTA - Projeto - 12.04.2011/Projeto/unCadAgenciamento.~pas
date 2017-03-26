unit unCadAgenciamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, ComCtrls, ToolWin,
  StdCtrls, ExtCtrls, Mask, plsTMaskEdit, plsMemo, plsComboBox, plsEdit,
  Buttons, unObjAgenciamento, unVariaveis,
  unConjuntoDadosAgencPessoaFisica, unConjuntoDadosAgencPessoaJuridica;

  type
    TPessoa = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TImovel = record
      codigo: Integer;
      nome: string[100];
    end;

type
  TfrmCadAgenciamento = class(TfrmCadastroBasico)
    pnlDadosAgenciamento: TPanel;
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    rdGrpTipoAgenciamento: TRadioGroup;
    rdGrpTipoPessoa: TRadioGroup;
    plsMedDataAgenciamento: TPlsMaskEdit;
    lblCampoObrigatorio1: TLabel;
    lblDataAgenciamento: TLabel;
    pnlDataBaixa: TPanel;
    lblDataBaixa: TLabel;
    plsMedDataBaixa: TPlsMaskEdit;
    pnlPessoa: TPanel;
    lblPessoa: TLabel;
    spBtnBuscaPessoa: TSpeedButton;
    lblCampoObrigatorio2: TLabel;
    plsEdPessoa: TPlsEdit;
    pnlImovel: TPanel;
    spBtnBuscaImovel: TSpeedButton;
    lblImovel: TLabel;
    lblCampoObrigatorio3: TLabel;
    plsEdImovel: TPlsEdit;
    pnlOutrosDados: TPanel;
    lblCondicaoPagamento: TLabel;
    lblValorTotal: TLabel;
    lblCampoObrigatorio6: TLabel;
    lblCampoObrigatorio5: TLabel;
    plsCbBxCondicaoPagamento: TPlsComboBox;
    plsEdValorTotal: TPlsEdit;
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
    pnlDataReagenciamento: TPanel;
    lblDataReagenciamento: TLabel;
    plsMedReagenciamento: TPlsMaskEdit;
    pnlDataAutorizacao: TPanel;
    lblPrazoAutorizacao: TLabel;
    lblCampoObrigatorio7: TLabel;
    plsMedPrazoAutorizacao: TPlsMaskEdit;
    grpBxEditarAgenciamentoExpirou: TGroupBox;
    lblInformacaoEditarAgenciamentoExpirou: TLabel;
    btBtnDarBaixaAgenciamento: TBitBtn;
    btBtnReagenciarAgenciamento: TBitBtn;
    plsMedReagenciamentoAgenciamento: TPlsMaskEdit;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosDATA_AGENCIAMENTO: TDateField;
    zQryDadosATIVO: TStringField;
    zQryDadosNORMAL: TStringField;
    zQryDadosSTAND_BY: TStringField;
    zQryDadosTIPO_PESSOA: TStringField;
    zQryDadosCOD_FK_PESSOA_FISICA: TIntegerField;
    zQryDadosCOD_FK_PESSOA_JURIDICA: TIntegerField;
    zQryDadosCOD_FK_IMOVEL: TIntegerField;
    zQryDadosCONDICAO_PAGAMENTO: TStringField;
    zQryDadosVALOR_TOTAL: TFloatField;
    zQryDadosPGTO_VISTA_CACH: TFloatField;
    zQryDadosPGTO_VISTA_VALOR_BEM: TFloatField;
    zQryDadosPGTO_VISTA_DESCRICAO_BEM: TStringField;
    zQryDadosPGTO_FINCTO_CACH_FINANCIADO: TFloatField;
    zQryDadosPGTO_FINCTO_CACH: TFloatField;
    zQryDadosPGTO_FINCTO_VALOR_BEM: TFloatField;
    zQryDadosPGTO_FINCTO_DESCRICAO_BEM: TStringField;
    zQryDadosOBSERVACAO: TStringField;
    zQryDadosPRAZO_AUTORIZACAO: TDateField;
    zQryDadosDATA_REAGENCIAMENTO: TDateField;
    zQryDadosDATA_BAIXA: TDateField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosDATA_AGENCIAMENTO: TDateField;
    cdsDadosATIVO: TStringField;
    cdsDadosNORMAL: TStringField;
    cdsDadosSTAND_BY: TStringField;
    cdsDadosTIPO_PESSOA: TStringField;
    cdsDadosCOD_FK_PESSOA_FISICA: TIntegerField;
    cdsDadosCOD_FK_PESSOA_JURIDICA: TIntegerField;
    cdsDadosCOD_FK_IMOVEL: TIntegerField;
    cdsDadosCONDICAO_PAGAMENTO: TStringField;
    cdsDadosVALOR_TOTAL: TFloatField;
    cdsDadosPGTO_VISTA_CACH: TFloatField;
    cdsDadosPGTO_VISTA_VALOR_BEM: TFloatField;
    cdsDadosPGTO_VISTA_DESCRICAO_BEM: TStringField;
    cdsDadosPGTO_FINCTO_CACH_FINANCIADO: TFloatField;
    cdsDadosPGTO_FINCTO_CACH: TFloatField;
    cdsDadosPGTO_FINCTO_VALOR_BEM: TFloatField;
    cdsDadosPGTO_FINCTO_DESCRICAO_BEM: TStringField;
    cdsDadosOBSERVACAO: TStringField;
    cdsDadosPRAZO_AUTORIZACAO: TDateField;
    cdsDadosDATA_REAGENCIAMENTO: TDateField;
    cdsDadosDATA_BAIXA: TDateField;
    btBtnSelecionarCaracteristicasVista: TBitBtn;
    btBtnSelecionarCaracteristicasFinanciamento: TBitBtn;
    procedure spBtnBuscaImovelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure rdGrpTipoPessoaClick(Sender: TObject);
    procedure spBtnBuscaPessoaClick(Sender: TObject);
    procedure plsEdImovelClick(Sender: TObject);
    procedure plsEdImovelKeyPress(Sender: TObject; var Key: Char);
    procedure plsCbBxCondicaoPagamentoChange(Sender: TObject);
    procedure rdGrpTipoAgenciamentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBtnDarBaixaAgenciamentoClick(Sender: TObject);
    procedure btBtnReagenciarAgenciamentoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure plsEdPessoaExit(Sender: TObject);
    procedure btBtnSelecionarCaracteristicasVistaClick(Sender: TObject);
    procedure btBtnSelecionarCaracteristicasFinanciamentoClick(
      Sender: TObject);
  private
    FoAgenciamento: TObjAgenciamento;
    FoConjuntoDadosAgencPessoaFisica: TConjuntoDadosAgencPessoaFisica;
    FoConjuntoDadosAgencPessoaJuridica: TConjuntoDadosAgencPessoaJuridica;
    FoPessoaAgenciamento: TTiposPessoas;
    FoTipoAgenciamento: TTiposAgenciamentos;
    FoCondicaoPagamento: TCondicoesPagamento;
    FbEditarAgenciamentoExpirado: Boolean;
    FbEditarAgenciamentoStandBy: Boolean;

    procedure carregarObjeto(); override;
    procedure carregarComponentesApresentacao(); override;
    procedure selecionarTodosDados(); override;
    procedure limparObjeto(); override;
    procedure limparTela(poForm: TForm); override;
    function verificarHouveAlteracoes(): boolean; override;
    function verificarCamposObrigatorios(): boolean; override;
    function verificarRegistroJaExiste(): boolean; override;
    function verificarPodeDeletar(): boolean; override;
    procedure visibilidade(pnVisib: Integer); override;
    function outrasValidacoesAntesSalvar(): Boolean; override;
    procedure novo(); override;
    function salvar(): Boolean; override;
    function excluir(): Boolean; override;
    procedure verificarInseriuChamadaTelaExterna(); override;
    procedure configurarTela(psOpcao: String);
    //finaliza cadastro do agenciamento do tipo standBy
    procedure finalizarAgenciamentoStandBy(pnCodigo:Integer);
    //edita registro que expirou - pode-se dar baixa ou fazer re-agenciamento
    procedure editarRegistroExpirou(pnCodigo:Integer);
    procedure salvarEdicaoAgenciamentoExpirou(psOpcao: String);

    procedure AbreTelaSelecaoAgencPessoaFisica(pnTpSelecao:Word);
    procedure VerificarAgencPessoaFisicaExiste();

    procedure AbreTelaSelecaoAgencPessoaJuridica(pnTpSelecao:Word);
    procedure VerificarAgencPessoaJuridicaExiste();
  public
    //FoPessoaFisica: TPessoa;
    //FoPessoaJuridica: TPessoa;
    FoPessoa: TPessoa;
    FoImovel: TImovel;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadAgenciamento: TfrmCadAgenciamento;

implementation

uses
   unPesquisandoAgenciamento, unConstantes, unDM,
  (*unSelecionaRegistroImovel,*) unSelecionaRegistroPessoaFisica, unCadImoveis,
  unSelecionaRegistroPessoaJuridica, unPrincipal, unCadPessoaFisica,
  unCadPessoaJuridica, unFuncoes, unSelecionarCaracBemNegociavel;

const
  fnSELECIONAR_AGENC_PESSOA_FISICA_NORMAL    = 1;
  fnSELECIONAR_AGENC_PESSOA_FISICA_DIGITANDO = 2;

  fnSELECIONAR_AGENC_PESSOA_JURIDICA_NORMAL    = 1;
  fnSELECIONAR_AGENC_PESSOA_JURIDICA_DIGITANDO = 2;

{$R *.dfm}

{ TfrmCadAgenciamento }

(* procedimentos de controle *)

procedure TfrmCadAgenciamento.configurarTela(psOpcao: String);
begin
  if(psOpcao = 'normal')then
  begin
    grpBxEditarAgenciamentoExpirou.Visible := False;
    grpBxDados.Enabled :=  True;
    frmCadAgenciamento.Height := 544;
    tlBtnExcluir.Visible := False;
  end

  else if(psOpcao = 'editarStandBy')then
  begin
    grpBxEditarAgenciamentoExpirou.Visible := False;
    grpBxDados.Enabled :=  True;
    frmCadAgenciamento.Height := 544;
    (*tlBtnNovo.Enabled := False;
    tlBtnSalvar.Enabled := True;
    tlBtnExcluir.Visible := True;
    tlBtnExcluir.Enabled := True;
    tlBtnCancelar.Enabled := True;*)
    tlBtnNovo.Visible := False;
    tlBtnSalvar.Visible := True;
    tlBtnSalvar.Enabled := True;
    tlBtnExcluir.Visible := True;
    tlBtnExcluir.Enabled := True;
    tlBtnCancelar.Visible := True;
    tlBtnCancelar.Enabled := True;
    plsEdCodigo.Enabled := False;
    pnlDataReagenciamento.Visible := False;
    pnlDataBaixa.Visible := False;
  end

  else if(psOpcao = 'editarRegistroExpirou')then
  begin
    grpBxEditarAgenciamentoExpirou.Visible := True;
    grpBxEditarAgenciamentoExpirou.Enabled := True;
    grpBxDados.Enabled :=  False;
    frmCadAgenciamento.Height := 650;
    tlBtnNovo.Enabled := False;
    tlBtnSalvar.Enabled := False;
    tlBtnExcluir.Visible := False;
    tlBtnCancelar.Enabled := True;
  end;
end;

procedure TfrmCadAgenciamento.iniciarTela(poForm: TForm);
begin
  inherited;
(*  Application.CreateForm(TfrmPesquisandoAgenciamento, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmPesquisandoAgenciamento);
  Self.FoPesquisa.Hide;
*)
end;

procedure TfrmCadAgenciamento.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;
  if(pTipo = PRM_CRIA_TELA_PESQUISA)then
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
      plsEdValorTotal.Text := FoFuncoes.formatarValorMonetario(pValores[2]);
    end
    else
    begin
      Self.FoImovel.codigo := NUMERO_INDEFINIDO;
      Self.FoImovel.nome := STRING_INDEFINIDO;
      plsEdImovel.Text := STRING_INDEFINIDO;
      plsEdValorTotal.Clear;
    end;
  end

  else if (pTipo = PRM_EDITAR_AGENCIAMENTO_EXPIROU)then
  begin
    if (VarIsNumeric(pValores)) then
    begin
      Self.editarRegistroExpirou(pValores);
      Self.FbEditarAgenciamentoExpirado := True;
    end
    else
    begin
      MessageDlg('Código do Agenciamento passado no parâmetro é inválido.',
       mtInformation, [mbOK], 0);
    end;
  end

  else if (pTipo = PRM_FINALIZAR_AGENCIAMENTO_STANDBY)then
  begin
    if (VarIsNumeric(pValores)) then
    begin
      Self.finalizarAgenciamentoStandBy(pValores);
      Self.FbEditarAgenciamentoStandBy := True;
    end
    else
    begin
      MessageDlg('Código do Agenciamento passado no parâmetro é inválido.',
       mtInformation, [mbOK], 0);
    end;
    rdGrpTipoPessoa.Enabled := False;
  end

  else if (pTipo = PRM_EDITOU_REGISTRO_AGENCIAMENTO_STAND_BY)then
  begin
    if(VarIsNumeric(pValores[0]))then
    begin
      if(pValores[2] = EDITOU_PESSOA)then
      begin
        Self.FoPessoa.codigo := pValores[0];
        Self.FoPessoa.nome := pValores[1];
        plsEdPessoa.Text := pValores[1];
      end
      else if(pValores[2] = EDITOU_IMOVEL)then
      begin
        Self.FoImovel.codigo := pValores[0];
        Self.FoImovel.nome := pValores[1];
        plsEdImovel.Text := pValores[1];
        plsEdValorTotal.Text := FoFuncoes.formatarValorMonetario(pValores[3]);
      end
    end;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS)then
  begin
    if(pValores[0] = CONJUNTO_DADOS_AGENC_PESSOA_FISICA)then
      FoConjuntoDadosAgencPessoaFisica.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_AGENC_PESSOA_JURIDICA)then
      FoConjuntoDadosAgencPessoaJuridica.ExecutarSQLSelecao();
  end;
end;

procedure TfrmCadAgenciamento.realizouPesquisa(piCodigo: Integer);
begin

end;

procedure TfrmCadAgenciamento.limparObjeto();
begin
  if (Assigned(Self.FoAgenciamento)) then
  begin
    Self.FoAgenciamento.limparObjeto();
  end
end;

procedure TfrmCadAgenciamento.limparTela(poForm: TForm);
begin
  inherited;
  rdGrpTipoAgenciamento.ItemIndex := -1;
  rdGrpTipoPessoa.ItemIndex := -1;

  Self.FoPessoa.codigo := NUMERO_INDEFINIDO;
  Self.FoPessoa.nome := STRING_INDEFINIDO;

  Self.FoImovel.codigo := NUMERO_INDEFINIDO;
  Self.FoImovel.nome := STRING_INDEFINIDO;

  Self.FoPessoaAgenciamento := [];
  Self.FoTipoAgenciamento := [];
  Self.FoCondicaoPagamento := [];
end;

function TfrmCadAgenciamento.verificarHouveAlteracoes(): boolean;
begin
  Result := True;
end;

function TfrmCadAgenciamento.verificarCamposObrigatorios(): boolean;
var
  bRetorno: Boolean;
  compFoco: TWinControl;
  campos: string;
  sAux: string;
begin
  bRetorno := True;
  compFoco := nil;
  campos := '';
  sAux := '';

  //agenciamento normal e stand by
  if(not(Self.FoFuncoes.validarData(plsMedDataAgenciamento.Text)))then
  begin
    campos := 'Data do Agenciamento';
    compFoco := plsMedDataAgenciamento;
  end;

  if(Self.FoTipoAgenciamento = [])then
  begin
    if(campos <> '')then
      campos := campos + ', Tipo de Agenciamento'
    else
    begin
      campos := 'Tipo de Agenciamento';
    end;
  end;

  if(Self.FoPessoaAgenciamento = [])then
  begin
    if(campos <> '')then
      campos := campos + ', Tipo de Pessoa'
    else
    begin
      campos := 'Tipo de Pessoa';
    end;
  end;

  if(Self.FoPessoa.codigo = NUMERO_INDEFINIDO)then
  begin
    if(campos <> '')then
      campos := campos + ', Pessoa'
    else
    begin
      campos := 'Pessoa';
    end;
    if(compFoco = nil)then
      compFoco := plsEdPessoa;
  end;

  if(Self.FoImovel.codigo = NUMERO_INDEFINIDO)then
  begin
    if(campos <> '')then
      campos := campos + ', Imóvel'
    else
    begin
      campos := 'Imóvel';
    end;
    if(compFoco = nil)then
      compFoco := plsEdImovel;
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

  //agenciamento normal
  if(Self.FoTipoAgenciamento = [normal])then
  begin
    if(not(Self.FoFuncoes.validarData(plsMedPrazoAutorizacao.Text)))then
    begin
      if(campos <> '')then
        campos := campos + ', Prazo Autorização'
      else
      begin
        campos := 'Prazo Autorização';
      end;
      if(compFoco = nil)then
        compFoco := plsMedPrazoAutorizacao;
    end;
  end;

  if(campos <> '')then
  begin
    MessageDlg('Antes de salvar, verifique os campos: ' + campos + '.', mtInformation, [mbOK], 0);
    bRetorno := False;
  end;

  //setar foco no componente que não foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

function TfrmCadAgenciamento.verificarRegistroJaExiste(): boolean;
begin
  Result := False;
end;

function TfrmCadAgenciamento.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  //só pode deletar se estiver editando - agenciamento StandBy
  if(not(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR))then
    bPodeDeletar := False;

  Result := bPodeDeletar;
end;

procedure TfrmCadAgenciamento.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       pnlDataBaixa.Visible := False;
                       rdGrpTipoAgenciamento.Enabled := False;
                       rdGrpTipoPessoa.Enabled := False;
                       pnlPessoa.Enabled := False;
                       pnlImovel.Enabled := False;
                       pnlOutrosDados.Enabled := False;
                       grpBxCondicaoPagamentoVista.Visible := False;
                       grpBxCondicaoPagamentoFinanciamento.Visible := False;
                       plsMmObservacao.Enabled := False;
                       pnlDataAutorizacao.Enabled := False;
                       pnlDataReagenciamento.Visible := False;
                       Self.FoFuncoes.focarComponente(plsEdCodigo);
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_AGENCIAMENTO,True));
                       plsEdCodigo.Enabled := False;
                       pnlDataBaixa.Visible := False;
                       rdGrpTipoAgenciamento.Enabled := True;
                       rdGrpTipoPessoa.Enabled := True;
                       pnlPessoa.Enabled := True;
                       pnlImovel.Enabled := True;
                       pnlOutrosDados.Enabled := True;
                       //grpBxCondicaoPagamentoVista.Visible := True;
                       //grpBxCondicaoPagamentoFinanciamento.Visible := True;
                       plsMmObservacao.Enabled := True;
                       pnlDataAutorizacao.Enabled := True;
                       pnlDataReagenciamento.Enabled := False;
                       Self.FoFuncoes.focarComponente(plsMedDataAgenciamento);
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       pnlDataBaixa.Visible := False;
                       rdGrpTipoAgenciamento.Enabled := True;
                       rdGrpTipoPessoa.Enabled := True;
                       pnlPessoa.Enabled := True;
                       pnlImovel.Enabled := True;
                       pnlOutrosDados.Enabled := True;
                       //grpBxCondicaoPagamentoVista.Visible := True;
                       //grpBxCondicaoPagamentoFinanciamento.Visible := True;
                       plsMmObservacao.Enabled := True;
                       pnlDataAutorizacao.Enabled := True;
                       pnlDataReagenciamento.Enabled := True;
                       Self.FoFuncoes.focarComponente(plsMedDataAgenciamento);
                     end;
    OPC_SALVAR:      begin

                     end;
    OPC_EXCLUIR:     begin
                       if(Self.FbEditarAgenciamentoStandBy)then
                         Self.Close;
                     end;
    OPC_CANCELAR:    begin

                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       pnlDataBaixa.Visible := True;
                       rdGrpTipoAgenciamento.Enabled := False;
                       rdGrpTipoPessoa.Enabled := False;
                       pnlPessoa.Enabled := False;
                       pnlImovel.Enabled := False;
                       pnlOutrosDados.Enabled := False;
                       grpBxCondicaoPagamentoVista.Visible := False;
                       grpBxCondicaoPagamentoFinanciamento.Visible := False;
                       plsMmObservacao.Enabled := False;
                       pnlDataAutorizacao.Enabled := False;
                       pnlDataReagenciamento.Visible := True;
                     end;
  end; //fim - case
end;

function TfrmCadAgenciamento.outrasValidacoesAntesSalvar(): Boolean;
var
  compFoco: TWinControl;
  dValorTotal: Currency;
  bRetorno: Boolean;

  procedure validarPagamentoVista();
  var
    dVistaCach,dVistaValorBem: Currency;
    dTotalValorVista: Currency;
  begin
    dVistaCach := Self.FoFuncoes.formatarValorCurrency(plsEdVistaCach.Text,True);
    dVistaValorBem := Self.FoFuncoes.formatarValorCurrency(plsEdVistaBemValor.Text,True);

    dTotalValorVista := dVistaCach + dVistaValorBem;
    if(dTotalValorVista > dValorTotal)then
    begin
      MessageDlg('O total do valor à vista não pode ser superior que o valor total.',mtWarning,[mbOK],0);
      //compFoco := plsEdValorTotal;
      compFoco := plsEdVistaCach;
      bRetorno := False;
    end;
  end; //fim - validarPagamentoVista()

  procedure validarPagamentoFinanciamento();
  var
    dFinctoCach,dFinctoValorFinanciado,dFinctoValorBem: Currency;
    dTotalValorFincto: Currency;
  begin
    dFinctoCach := Self.FoFuncoes.formatarValorCurrency(plsEdFinanciamentoCach.Text,True);
    dFinctoValorFinanciado := Self.FoFuncoes.formatarValorCurrency(plsEdFinanciamentoValorFinanciado.Text,True);
    dFinctoValorBem := Self.FoFuncoes.formatarValorCurrency(plsEdFinanciamentoBemValor.Text,True);

    dTotalValorFincto := dFinctoCach + dFinctoValorFinanciado + dFinctoValorBem;
    if(dTotalValorFincto > dValorTotal)then
    begin
      MessageDlg('O total do valor do financiamento não pode ser superior que o valor total.',mtWarning,[mbOK],0);
      //compFoco := plsEdValorTotal;
      compFoco := plsEdFinanciamentoCach;
      bRetorno := False;
    end;
  end; //fim - validarPagamentoFinanciamento()

  procedure validarDescricaoBemVista();
  var
    dValorBem: Currency;
  begin
    dValorBem := Self.FoFuncoes.formatarValorCurrency(plsEdVistaBemValor.Text,True);

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
    dValorBem := Self.FoFuncoes.formatarValorCurrency(plsEdFinanciamentoBemValor.Text,True);

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
    dTotal := Self.FoFuncoes.formatarValorCurrency(plsEdValorTotal.Text,True);
    dCach := Self.FoFuncoes.formatarValorCurrency(plsEdVistaCach.Text,True);
    dValorBem := Self.FoFuncoes.formatarValorCurrency(plsEdVistaBemValor.Text,True);

    if(dTotal <> dCach+dValorBem)then
    begin
      MessageDlg('O valor total é diferente da soma do valor à vista informado.',mtWarning,[mbOK],0);
      //compFoco := plsEdValorTotal;
      compFoco := plsEdVistaCach;
      bRetorno := False;
    end;
  end; //validarTotalValorVista();


  procedure validarTotalValorFinanciamento();
  var
    dTotal: Currency;
    dCach,dValorFinanciado,dValorBem: Currency;
  begin
    dTotal := Self.FoFuncoes.formatarValorCurrency(plsEdValorTotal.Text,True);
    dCach := Self.FoFuncoes.formatarValorCurrency(plsEdFinanciamentoCach.Text,True);
    dValorFinanciado := Self.FoFuncoes.formatarValorCurrency(plsEdFinanciamentoValorFinanciado.Text,True);
    dValorBem := Self.FoFuncoes.formatarValorCurrency(plsEdFinanciamentoBemValor.Text,True);

    if(dTotal <> dCach+dValorFinanciado+dValorBem)then
    begin
      MessageDlg('O valor total é diferente da soma do valor do financiamento informado.',mtWarning,[mbOK],0);
      //compFoco := plsEdValorTotal;
      compFoco := plsEdFinanciamentoCach;
      bRetorno := False;
    end;
  end; //fim - validarTotalValorFinanciamento()

  //prazo autorização deve ser maior que a data do agenciamento
  procedure validarDataAutorizacaoAgenciamento();
  var
    dtPrazoAutorizacao: TDate;
    dtDataAgenciamento: TDate;
  begin
    dtPrazoAutorizacao := Self.FoFuncoes.formatarData(plsMedPrazoAutorizacao.Text);
    dtDataAgenciamento := Self.FoFuncoes.formatarData(plsMedDataAgenciamento.Text);
    if(dtPrazoAutorizacao < dtDataAgenciamento)then
    begin
      MessageDlg('O prazo de autorização deve ser maior que a data do agenciamento.',mtWarning,[mbOK],0);
      compFoco := plsMedPrazoAutorizacao;
      bRetorno := False;
    end;
  end; //fim - validarDataAutorizacaoAgenciamento()

begin
  compFoco := nil;
  bRetorno := True;

  //se o tipo do agenciamento for normal, realiza as demais validações
  if(Self.FoTipoAgenciamento = [normal])then
  begin
    //validando valor total
    dValorTotal := Self.FoFuncoes.formatarValorCurrency(plsEdValorTotal.Text,True);

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

    //prazo autorização deve ser maior que a data do agenciamento
    if(bRetorno)then
      validarDataAutorizacaoAgenciamento();

    //setar foco no componente que não foi validado
    if((not(bRetorno))and(compFoco is TWinControl))then
      Self.FoFuncoes.focarComponente(compFoco);
  end;

  Result := bRetorno;
end;

procedure TfrmCadAgenciamento.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadAgenciamento);
  visibilidade(OPC_NOVO);
  plsMedDataAgenciamento.Text := DateToStr(Now);
end;

function TfrmCadAgenciamento.salvar(): boolean;
var
  bSalvou: boolean;

  dtDataAgenciamento: TDate;
  sAtivo,sNormal,sStandBy,sTipoPessoa: String;
  nCodFK_PesssoaFisica,nCodFK_PesssoaJuridica,nCodFK_Imovel: Integer;
  sCondicaoPagamento: String;
  dValorTotal,dPgtoVistaCach,dPgtoVistaValorBem: Currency;
  sPgtoVistaDescricaoBem: String;
  dPgtoFinctoCach,dPgtoFinctoCachFinanciado,dPgtoFinctoValorBem: Currency;
  sPgtoFinctoDescricaoBem,sObservacao: String;
  dtPrazoAutorizacao: TDate;

  procedure carregarValores();
  begin
    dtDataAgenciamento := Self.FoFuncoes.formatarData(plsMedDataAgenciamento.Text);

    sAtivo := VLR_SIM;

    if(Self.FoTipoAgenciamento = [normal])then
    begin
      sNormal := VLR_SIM;
      sStandBy := VLR_NAO;
    end
    else if(Self.FoTipoAgenciamento = [standBy])then
    begin
      sNormal := VLR_NAO;
      sStandBy := VLR_SIM;
    end
    else
    begin
      sNormal := VLR_NAO;
      sStandBy := VLR_NAO;
    end;

    if(Self.FoPessoaAgenciamento = [pessoaFisica])then
    begin
      sTipoPessoa := VLR_TP_PESSOA_FISICA;
      nCodFK_PesssoaFisica := Self.FoPessoa.codigo;
      nCodFK_PesssoaJuridica := REGISTRO_NULO;
    end
    else if(Self.FoPessoaAgenciamento = [pessoaJuridica])then
    begin
      sTipoPessoa := VLR_TP_PESSOA_JURIDICA;
      nCodFK_PesssoaFisica := REGISTRO_NULO;
      nCodFK_PesssoaJuridica := Self.FoPessoa.codigo;
    end
    else
    begin
      sTipoPessoa := STRING_INDEFINIDO;
      nCodFK_PesssoaFisica := REGISTRO_NULO;
      nCodFK_PesssoaJuridica := REGISTRO_NULO;
    end;

    nCodFK_Imovel := Self.FoImovel.codigo;

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

    try
      dValorTotal := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdValorTotal.Text, '.'));
    except
      dValorTotal := 0;
    end;
    sObservacao := Trim(plsMmObservacao.Text);

    dtPrazoAutorizacao := Self.FoFuncoes.formatarData(plsMedPrazoAutorizacao.Text);
  end;


  //limpa parâmetro nulos - para o insert e update
  procedure limparParametrosNulos();
  begin
    if(dtDataAgenciamento = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('data_agenciamento').Clear;
    if(dValorTotal = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('valor_total').Clear;
    if(dPgtoVistaCach = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('pgto_vista_cach').Clear;
    if(dPgtoVistaCach = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('pgto_vista_cach').Clear;
    if(dPgtoVistaValorBem = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('pgto_vista_valor_bem').Clear;
    if(dPgtoFinctoCachFinanciado = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('pgto_fincto_cach_financiado').Clear;
    if(dPgtoFinctoCachFinanciado = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('pgto_fincto_cach_financiado').Clear;
    if(dPgtoFinctoCach = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('pgto_fincto_cach').Clear;
    if(dPgtoFinctoValorBem = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('pgto_fincto_valor_bem').Clear;
    if(dtPrazoAutorizacao = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('prazo_autorizacao').Clear;
  end;

begin
  carregarValores();
  bSalvou := False;

  if(Self.FiFuncaoRegistro in [FUNCAO_REGISTRO_EDITAR, FUNCAO_REGISTRO_NOVO]) then
  begin
    inherited;
    //somente pode editar se for agenciamento stand by
    if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR)and(Self.FbEditarAgenciamentoStandBy)then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('UPDATE agenciamentos SET data_agenciamento=:data_agenciamento,');
        zQryDados.SQL.Add('ativo=:ativo,normal=:normal,stand_by=:stand_by,');
        zQryDados.SQL.Add('tipo_pessoa=:tipo_pessoa,cod_fk_pessoa_fisica=:cod_fk_pessoa_fisica,');
        zQryDados.SQL.Add('cod_fk_pessoa_juridica=:cod_fk_pessoa_juridica,');
        zQryDados.SQL.Add('cod_fk_imovel=:cod_fk_imovel,condicao_pagamento=:condicao_pagamento,');
        zQryDados.SQL.Add('valor_total=:valor_total,pgto_vista_cach=:pgto_vista_cach,');
        zQryDados.SQL.Add('pgto_vista_valor_bem=:pgto_vista_valor_bem,pgto_vista_descricao_bem=:pgto_vista_descricao_bem,');
        zQryDados.SQL.Add('pgto_fincto_cach_financiado=:pgto_fincto_cach_financiado,');
        zQryDados.SQL.Add('pgto_fincto_cach=:pgto_fincto_cach,pgto_fincto_valor_bem=:pgto_fincto_valor_bem,');
        zQryDados.SQL.Add('pgto_fincto_descricao_bem=:pgto_fincto_descricao_bem,observacao=:observacao,');
        zQryDados.SQL.Add('prazo_autorizacao=:prazo_autorizacao WHERE codigo=:codigo');
        zQryDados.ParamByName('data_agenciamento').AsDate := dtDataAgenciamento;
        zQryDados.ParamByName('ativo').AsString := sAtivo;
        zQryDados.ParamByName('normal').AsString := sNormal;
        zQryDados.ParamByName('stand_by').AsString := sStandBy;
        zQryDados.ParamByName('tipo_pessoa').AsString := sTipoPessoa;
        zQryDados.ParamByName('cod_fk_pessoa_fisica').AsInteger := nCodFK_PesssoaFisica;
        zQryDados.ParamByName('cod_fk_pessoa_juridica').AsInteger := nCodFK_PesssoaJuridica;
        zQryDados.ParamByName('cod_fk_imovel').AsInteger := nCodFK_Imovel;
        zQryDados.ParamByName('condicao_pagamento').AsString := sCondicaoPagamento;
        zQryDados.ParamByName('valor_total').AsCurrency := dValorTotal;
        zQryDados.ParamByName('pgto_vista_cach').AsCurrency := dPgtoVistaCach;
        zQryDados.ParamByName('pgto_vista_valor_bem').AsCurrency := dPgtoVistaValorBem;
        zQryDados.ParamByName('pgto_vista_descricao_bem').AsString := sPgtoVistaDescricaoBem;
        zQryDados.ParamByName('pgto_fincto_cach_financiado').AsCurrency := dPgtoFinctoCachFinanciado;
        zQryDados.ParamByName('pgto_fincto_cach').AsCurrency := dPgtoFinctoCach;
        zQryDados.ParamByName('pgto_fincto_valor_bem').AsCurrency := dPgtoFinctoValorBem;
        zQryDados.ParamByName('pgto_fincto_descricao_bem').AsString := sPgtoFinctoDescricaoBem;
        zQryDados.ParamByName('observacao').AsString := sObservacao;
        zQryDados.ParamByName('prazo_autorizacao').AsDate := dtPrazoAutorizacao;
        zQryDados.ParamByName('codigo').AsInteger := Self.FoAgenciamento.getCodigo;
        limparParametrosNulos();
        zQryDados.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
      except
        DM.ZConnection.Rollback;
      end;

    end
    else if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_NOVO) then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('INSERT INTO agenciamentos(data_agenciamento,ativo,normal,stand_by,');
        zQryDados.SQL.Add('tipo_pessoa,cod_fk_pessoa_fisica,cod_fk_pessoa_juridica,');
        zQryDados.SQL.Add('cod_fk_imovel,condicao_pagamento,');
        zQryDados.SQL.Add('valor_total,pgto_vista_cach,pgto_vista_valor_bem,');
        zQryDados.SQL.Add('pgto_vista_descricao_bem,pgto_fincto_cach_financiado,');
        zQryDados.SQL.Add('pgto_fincto_cach,pgto_fincto_valor_bem,pgto_fincto_descricao_bem,');
        zQryDados.SQL.Add('observacao,prazo_autorizacao) ');
        //data_reagenciamento,data_baixa
        zQryDados.SQL.Add('VALUES (:data_agenciamento,:ativo,:normal,:stand_by,');
        zQryDados.SQL.Add(':tipo_pessoa,:cod_fk_pessoa_fisica,:cod_fk_pessoa_juridica,');
        zQryDados.SQL.Add(':cod_fk_imovel,:condicao_pagamento,');
        zQryDados.SQL.Add(':valor_total,:pgto_vista_cach,:pgto_vista_valor_bem,');
        zQryDados.SQL.Add(':pgto_vista_descricao_bem,:pgto_fincto_cach_financiado,');
        zQryDados.SQL.Add(':pgto_fincto_cach,:pgto_fincto_valor_bem,:pgto_fincto_descricao_bem,');
        zQryDados.SQL.Add(':observacao,:prazo_autorizacao) ');
        //:data_reagenciamento,:data_baixa
        zQryDados.ParamByName('data_agenciamento').AsDate := dtDataAgenciamento;
        zQryDados.ParamByName('ativo').AsString := sAtivo;
        zQryDados.ParamByName('normal').AsString := sNormal;
        zQryDados.ParamByName('stand_by').AsString := sStandBy;
        zQryDados.ParamByName('tipo_pessoa').AsString := sTipoPessoa;
        zQryDados.ParamByName('cod_fk_pessoa_fisica').AsInteger := nCodFK_PesssoaFisica;
        zQryDados.ParamByName('cod_fk_pessoa_juridica').AsInteger := nCodFK_PesssoaJuridica;
        zQryDados.ParamByName('cod_fk_imovel').AsInteger := nCodFK_Imovel;
        zQryDados.ParamByName('condicao_pagamento').AsString := sCondicaoPagamento;
        zQryDados.ParamByName('valor_total').AsCurrency := dValorTotal;
        zQryDados.ParamByName('pgto_vista_cach').AsCurrency := dPgtoVistaCach;
        zQryDados.ParamByName('pgto_vista_valor_bem').AsCurrency := dPgtoVistaValorBem;
        zQryDados.ParamByName('pgto_vista_descricao_bem').AsString := sPgtoVistaDescricaoBem;
        zQryDados.ParamByName('pgto_fincto_cach_financiado').AsCurrency := dPgtoFinctoCachFinanciado;
        zQryDados.ParamByName('pgto_fincto_cach').AsCurrency := dPgtoFinctoCach;
        zQryDados.ParamByName('pgto_fincto_valor_bem').AsCurrency := dPgtoFinctoValorBem;
        zQryDados.ParamByName('pgto_fincto_descricao_bem').AsString := sPgtoFinctoDescricaoBem;
        zQryDados.ParamByName('observacao').AsString := sObservacao;
        zQryDados.ParamByName('prazo_autorizacao').AsDate := dtPrazoAutorizacao;
        limparParametrosNulos();
        zQryDados.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
      except
        DM.ZConnection.Rollback;
      end;
    end;
  end;

  if(bSalvou)then
    Self.verificarInseriuChamadaTelaExterna();

  Result := bSalvou;
end;

function TfrmCadAgenciamento.excluir(): Boolean;
var
  bDeletou: Boolean;
  bPodeDeletar: Boolean;
begin
  bDeletou := False;
  bPodeDeletar := True;

  if(bPodeDeletar)then
  begin
    try
      DM.ZConnection.StartTransaction;
      zQryDados.Close;
      zQryDados.SQL.Clear;
      //zQryDados.SQL.Add('DELETE FROM agenciamentos WHERE codigo=:cod');
      zQryDados.SQL.Add('UPDATE agenciamentos SET ativo=:ativo WHERE codigo=:cod');
      zQryDados.ParamByName('ativo').AsString := VLR_NAO;
      zQryDados.ParamByName('cod').AsInteger := Self.FoAgenciamento.getCodigo();
      zQryDados.ExecSQL();
      DM.ZConnection.Commit;
      bDeletou := True;
    except
      DM.ZConnection.Rollback;
    end;
  end;

  if(bPodeDeletar = False)then
    Result := True //retorna True pois já foi exibida mensagem que registro não pode ser deletado
  else
    Result := bDeletou;
end;

procedure TfrmCadAgenciamento.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoAgenciamento))) then
  begin
    Self.FoAgenciamento.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoAgenciamento.setDataCadastro(cdsDadosDATA_CADASTRO.AsDateTime);
    Self.FoAgenciamento.setDataAgenciamento(cdsDadosDATA_AGENCIAMENTO.AsDateTime);
    Self.FoAgenciamento.setAtivo(cdsDadosATIVO.AsString);
    Self.FoAgenciamento.setNormal(cdsDadosNORMAL.AsString);
    Self.FoAgenciamento.setStandBy(cdsDadosSTAND_BY.AsString);
    Self.FoAgenciamento.setTipoPessoa(cdsDadosTIPO_PESSOA.AsString);
    Self.FoAgenciamento.setFk_Pessoa_Fisica(cdsDadosCOD_FK_PESSOA_FISICA.AsInteger);
    Self.FoAgenciamento.setFk_Pessoa_Juridica(cdsDadosCOD_FK_PESSOA_JURIDICA.AsInteger);
    Self.FoAgenciamento.setFk_Imovel(cdsDadosCOD_FK_IMOVEL.AsInteger);
    Self.FoAgenciamento.setCondicaoPagamento(cdsDadosCONDICAO_PAGAMENTO.AsString);
    Self.FoAgenciamento.setValorTotal(cdsDadosVALOR_TOTAL.AsCurrency);
    Self.FoAgenciamento.setPgto_Vista_Cach(cdsDadosPGTO_VISTA_CACH.AsCurrency);
    Self.FoAgenciamento.setPgto_Vista_Valor_Bem(cdsDadosPGTO_VISTA_VALOR_BEM.AsCurrency);
    Self.FoAgenciamento.setPgto_Vista_Descricao_Bem(cdsDadosPGTO_VISTA_DESCRICAO_BEM.AsString);
    Self.FoAgenciamento.setPgto_Fincto_Cach_Financiado(cdsDadosPGTO_FINCTO_CACH_FINANCIADO.AsCurrency);
    Self.FoAgenciamento.setPgto_Fincto_Cach(cdsDadosPGTO_FINCTO_CACH.AsCurrency);
    Self.FoAgenciamento.setPgto_Fincto_Valor_Bem(cdsDadosPGTO_FINCTO_VALOR_BEM.AsCurrency);
    Self.FoAgenciamento.setPgto_Fincto_Descricao_Bem(cdsDadosPGTO_FINCTO_DESCRICAO_BEM.AsString);
    Self.FoAgenciamento.setObservacao(cdsDadosOBSERVACAO.AsString);
    Self.FoAgenciamento.setPrazo_Autorizacao(cdsDadosPRAZO_AUTORIZACAO.AsDateTime);
    Self.FoAgenciamento.setData_Reagenciamento(cdsDadosDATA_REAGENCIAMENTO.AsDateTime);
    Self.FoAgenciamento.setData_Baixa(cdsDadosDATA_BAIXA.AsDateTime);
    Self.FoAgenciamento.setExibePessoaFisica();
    Self.FoAgenciamento.setExibePessoaJuridica();
    Self.FoAgenciamento.setExibeImovel();
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadAgenciamento.carregarObjeto();','Acesso Indisponível');
  end;

end;

procedure TfrmCadAgenciamento.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoAgenciamento))then
  begin
    if(Self.FoAgenciamento.getCodigo <> NUMERO_INDEFINIDO)then
      plsEdCodigo.Text := IntToStr(Self.FoAgenciamento.getCodigo)
    else
      plsEdCodigo.Clear;

    if(Self.FoAgenciamento.getDataAgenciamento <> NUMERO_INDEFINIDO)then
      plsMedDataAgenciamento.Text := DateToStr(Self.FoAgenciamento.getDataAgenciamento)
    else
      plsMedDataAgenciamento.Clear;

    if(Self.FoAgenciamento.getData_Baixa <> NUMERO_INDEFINIDO)then
      plsMedDataBaixa.Text := DateToStr(Self.FoAgenciamento.getData_Baixa)
    else
      plsMedDataBaixa.Clear;

    if(Self.FoAgenciamento.getNormal = VLR_SIM)and(Self.FoAgenciamento.getStandBy = VLR_NAO)then
    begin
      rdGrpTipoAgenciamento.ItemIndex := 0;
      FoTipoAgenciamento := [normal];
    end
    else if(Self.FoAgenciamento.getNormal = VLR_NAO)and(Self.FoAgenciamento.getStandBy = VLR_SIM)then
    begin
      rdGrpTipoAgenciamento.ItemIndex := 1;
      FoTipoAgenciamento := [standBy];
    end
    else
    begin
      rdGrpTipoAgenciamento.ItemIndex := -1;
      FoTipoAgenciamento := [];
    end;

    if(Self.FoAgenciamento.getTipoPessoa = VLR_TP_PESSOA_FISICA)then
    begin
      rdGrpTipoPessoa.ItemIndex := 0;
      plsEdPessoa.Text := Self.FoAgenciamento.getExibePessoaFisica;
      Self.FoPessoaAgenciamento := [pessoaFisica];
      Self.FoPessoa.codigo := Self.FoAgenciamento.getFk_Pessoa_Fisica;
      Self.FoPessoa.nome := Self.FoAgenciamento.getExibePessoaFisica;
    end
    else if(Self.FoAgenciamento.getTipoPessoa = VLR_TP_PESSOA_JURIDICA)then
    begin
      rdGrpTipoPessoa.ItemIndex := 1;
      plsEdPessoa.Text := Self.FoAgenciamento.getExibePessoaJuridica;
      Self.FoPessoaAgenciamento := [pessoaJuridica];
      Self.FoPessoa.codigo := Self.FoAgenciamento.getFk_Pessoa_Juridica;
      Self.FoPessoa.nome := Self.FoAgenciamento.getExibePessoaJuridica;
    end
    else
    begin
      rdGrpTipoPessoa.ItemIndex := -1;
      plsEdPessoa.Clear;
      Self.FoPessoaAgenciamento := [];
      Self.FoPessoa.codigo := NUMERO_INDEFINIDO;
      Self.FoPessoa.nome := STRING_INDEFINIDO;
    end;

    plsEdImovel.Text := Self.FoAgenciamento.getExibeImovel;
    Self.FoImovel.codigo := Self.FoAgenciamento.getFk_Imovel;
    Self.FoImovel.nome := Self.FoAgenciamento.getExibeImovel;

    if(Self.FoAgenciamento.getCondicaoPagamento = VLR_CD_PAGAMENTO_VISTA)then
    begin
      plsCbBxCondicaoPagamento.ItemIndex := 0;
      Self.FoCondicaoPagamento := [vista];
    end
    else if(Self.FoAgenciamento.getCondicaoPagamento = VLR_CD_PAGAMENTO_ACEITA_FINANCIAMENTO)then
    begin
      plsCbBxCondicaoPagamento.ItemIndex := 1;
      Self.FoCondicaoPagamento := [aceitaFinanciamento];
    end
    else
    begin
      plsCbBxCondicaoPagamento.ItemIndex := -1;
      Self.FoCondicaoPagamento := [];
    end;

    plsEdValorTotal.Text := FloatToStr(Self.FoAgenciamento.getValorTotal);
    plsEdValorTotal.Text := FoFuncoes.formatarValorMonetario(plsEdValorTotal.Text);

    plsEdVistaCach.Text := FloatToStr(Self.FoAgenciamento.getPgto_Vista_Cach);
    plsEdVistaCach.Text := FoFuncoes.formatarValorMonetario(plsEdVistaCach.Text);

    plsEdVistaBemValor.Text := FloatToStr(Self.FoAgenciamento.getPgto_Vista_Valor_Bem);
    plsEdVistaBemValor.Text := FoFuncoes.formatarValorMonetario(plsEdVistaBemValor.Text);

    plsMmVistaBemDescricao.Text := Self.FoAgenciamento.getPgto_Vista_Descricao_Bem;

    plsEdFinanciamentoCach.Text := FloatToStr(Self.FoAgenciamento.getPgto_Fincto_Cach);
    plsEdFinanciamentoCach.Text := FoFuncoes.formatarValorMonetario(plsEdFinanciamentoCach.Text);

    plsEdFinanciamentoValorFinanciado.Text := FloatToStr(Self.FoAgenciamento.getPgto_Fincto_Cach_Financiado);
    plsEdFinanciamentoValorFinanciado.Text := FoFuncoes.formatarValorMonetario(plsEdFinanciamentoValorFinanciado.Text);

    plsEdFinanciamentoBemValor.Text := FloatToStr(Self.FoAgenciamento.getPgto_Fincto_Valor_Bem);
    plsEdFinanciamentoBemValor.Text := FoFuncoes.formatarValorMonetario(plsEdFinanciamentoBemValor.Text);

    plsMmFinanciamentoBemDescricao.Text := Self.FoAgenciamento.getPgto_Fincto_Descricao_Bem;

    plsMmObservacao.Text := Self.FoAgenciamento.getObservacao;

    if(Self.FoAgenciamento.getPrazo_Autorizacao <> NUMERO_INDEFINIDO)then
      plsMedPrazoAutorizacao.Text := DateToStr(Self.FoAgenciamento.getPrazo_Autorizacao)
    else
      plsMedPrazoAutorizacao.Clear;

    if(Self.FoAgenciamento.getData_Reagenciamento <> NUMERO_INDEFINIDO)then
      plsMedReagenciamento.Text := DateToStr(Self.FoAgenciamento.getData_Reagenciamento)
    else
      plsMedReagenciamento.Clear;
  end;
end;

procedure TfrmCadAgenciamento.selecionarTodosDados();
begin

end;

//finaliza cadastro do agenciamento do tipo standBy
procedure TfrmCadAgenciamento.finalizarAgenciamentoStandBy(pnCodigo:Integer);

  procedure pesquisarRegistro();
  begin
    cdsDados.Close;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('SELECT * FROM agenciamentos WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := pnCodigo;
    zQryDados.Open;
    cdsDados.Open;
  end;

begin
  pesquisarRegistro();
  if(cdsDados.Active)and(cdsDados.RecordCount>0)then
  begin
    Self.carregarObjeto();
    Self.carregarComponentesApresentacao();
    Self.configurarTela('editarStandBy');
    Self.FiFuncaoRegistro := FUNCAO_REGISTRO_EDITAR;
  end
  else
  begin
    MessageDlg('Erro ao pesquisar por agenciamento stand by.', mtWarning, [mbOK], 0);
  end;
end;

//edita registro que expirou - pode-se dar baixa ou fazer re-agenciamento
procedure TfrmCadAgenciamento.editarRegistroExpirou(pnCodigo:Integer);
  procedure pesquisarRegistro();
  begin
    cdsDados.Close;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('SELECT * FROM agenciamentos WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := pnCodigo;
    zQryDados.Open;
    cdsDados.Open;
  end;
begin
  pesquisarRegistro();
  if(cdsDados.Active)and(cdsDados.RecordCount>0)then
  begin
    Self.carregarObjeto();
    Self.carregarComponentesApresentacao();
    Self.configurarTela('editarRegistroExpirou');
  end
  else
  begin
    MessageDlg('Erro ao pesquisar por agenciamento para ser editado.', mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmCadAgenciamento.salvarEdicaoAgenciamentoExpirou(psOpcao: String);
var
  bSalvou: Boolean;
begin
  bSalvou := False;
  if(psOpcao = 'darBaixa')then
  begin
    try
      DM.ZConnection.StartTransaction;
      DM.zQryAgenciamentos.Close;
      DM.zQryAgenciamentos.SQL.Clear;
      DM.zQryAgenciamentos.SQL.Add('UPDATE agenciamentos SET ativo=:ativo, ');
      DM.zQryAgenciamentos.SQL.Add('data_baixa=current_date ');
      DM.zQryAgenciamentos.SQL.Add('WHERE codigo=:codigo');
      DM.zQryAgenciamentos.ParamByName('ativo').AsString := VLR_NAO;
      DM.zQryAgenciamentos.ParamByName('codigo').AsInteger := Self.FoAgenciamento.getCodigo;
      DM.zQryAgenciamentos.ExecSQL;
      DM.ZConnection.Commit;
      bSalvou := True;
    except
      DM.ZConnection.Rollback;
    end;
  end
  
  else if(psOpcao = 'reAgenciar')then
  begin
    try
      DM.ZConnection.StartTransaction;
      DM.zQryAgenciamentos.Close;
      DM.zQryAgenciamentos.SQL.Clear;
      DM.zQryAgenciamentos.SQL.Add('UPDATE agenciamentos SET data_reagenciamento=:data_reagenciamento ');
      DM.zQryAgenciamentos.SQL.Add('WHERE codigo=:codigo');
      DM.zQryAgenciamentos.ParamByName('codigo').AsInteger := Self.FoAgenciamento.getCodigo;
      DM.zQryAgenciamentos.ParamByName('data_reagenciamento').AsDate := StrToDate(plsMedReagenciamentoAgenciamento.Text);
      DM.zQryAgenciamentos.ExecSQL;
      DM.ZConnection.Commit;
      bSalvou := True;
    except
      DM.ZConnection.Rollback;
    end;                 
  end;

  if(bSalvou)then
  begin
    if(Assigned(frmPrincipal))then
      frmPrincipal.passarParametro(PRM_ATUALIZAR_AGENCIAMENTOS_EDITANDO, null);
    Self.Close;
    Exit;
  end;
end;

procedure TfrmCadAgenciamento.verificarInseriuChamadaTelaExterna();
begin
  if(Self.FbEditarAgenciamentoExpirado)or(Self.FbEditarAgenciamentoStandBy)then
  begin
    Self.Close;
    Exit;
  end;
end;


procedure TfrmCadAgenciamento.AbreTelaSelecaoAgencPessoaFisica(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdPessoa.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_AGENC_PESSOA_FISICA_NORMAL:
    begin
      if(Self.FbEditarAgenciamentoStandBy)then
      begin
        try
          Application.CreateForm(TfrmCadPessoaFisica,frmCadPessoaFisica);
          frmCadPessoaFisica.iniciarTela(frmCadPessoaFisica);
          frmCadPessoaFisica.passarParametro(PRM_EDITAR_PESSOA_AGENCIAMENTO_STAND_BY, FORM_CAD_AGENCIAMENTOS);
          frmCadPessoaFisica.passarParametro(PRM_CARREGA_REGISTRO_CODIGO, Self.FoAgenciamento.getFk_Pessoa_Fisica);
          frmCadPessoaFisica.ShowModal;
        finally
          if(Self.FoPessoa.codigo <> NUMERO_INDEFINIDO)then
          begin
            plsEdPessoa.Text := Self.FoPessoa.nome;
            Self.FoFuncoes.focarComponente(plsEdImovel);
          end;
          FreeAndNil(frmCadPessoaFisica);
        end;
      end //FbEditarAgenciamentoStandBy = true

      else //FbEditarAgenciamentoStandBy = False
      begin
        try
          Application.CreateForm(TfrmSelecionaRegistroPessoaFisica, frmSelecionaRegistroPessoaFisica);
          frmSelecionaRegistroPessoaFisica.passarParametro(PRM_INICIAR_TELA, null);
          frmSelecionaRegistroPessoaFisica.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_AGENCIAMENTOS);
          frmSelecionaRegistroPessoaFisica.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
          if(plsEdPessoa.Text <> STRING_INDEFINIDO)then
            frmSelecionaRegistroPessoaFisica.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
          frmSelecionaRegistroPessoaFisica.ShowModal;
        finally
          if(Self.FoPessoa.codigo <> NUMERO_INDEFINIDO)then
          begin
            plsEdPessoa.Text := Self.FoPessoa.nome;
            Self.FoFuncoes.focarComponente(plsEdImovel);
          end;
          FreeAndNil(frmSelecionaRegistroPessoaFisica);
        end;
      end; //FbEditarAgenciamentoStandBy = False
    end; //fnSELECIONAR_AGENC_PESSOA_FISICA_NORMAL

    fnSELECIONAR_AGENC_PESSOA_FISICA_DIGITANDO:
    begin
      if(Self.FbEditarAgenciamentoStandBy)then
      begin
        try
          Application.CreateForm(TfrmCadPessoaFisica,frmCadPessoaFisica);
          frmCadPessoaFisica.iniciarTela(frmCadPessoaFisica);
          frmCadPessoaFisica.passarParametro(PRM_EDITAR_PESSOA_AGENCIAMENTO_STAND_BY, FORM_CAD_AGENCIAMENTOS);
          frmCadPessoaFisica.passarParametro(PRM_CARREGA_REGISTRO_CODIGO, Self.FoAgenciamento.getFk_Pessoa_Fisica);
          frmCadPessoaFisica.ShowModal;
        finally
          if(Self.FoPessoa.codigo <> NUMERO_INDEFINIDO)then
          begin
            plsEdPessoa.Text := Self.FoPessoa.nome;
            Self.FoFuncoes.focarComponente(plsEdImovel);
          end;
          FreeAndNil(frmCadPessoaFisica);
        end;
      end //FbEditarAgenciamentoStandBy = true

      else //FbEditarAgenciamentoStandBy = False
      begin
        try
          Application.CreateForm(TfrmSelecionaRegistroPessoaFisica, frmSelecionaRegistroPessoaFisica);
          frmSelecionaRegistroPessoaFisica.passarParametro(PRM_INICIAR_TELA, null);
          frmSelecionaRegistroPessoaFisica.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_AGENCIAMENTOS);
          frmSelecionaRegistroPessoaFisica.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
          frmSelecionaRegistroPessoaFisica.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
          frmSelecionaRegistroPessoaFisica.ShowModal;
        finally
          if(Self.FoPessoa.codigo <> NUMERO_INDEFINIDO)then
          begin
            plsEdPessoa.Text := Self.FoPessoa.nome;
            Self.FoFuncoes.focarComponente(plsEdImovel);
          end;
          FreeAndNil(frmSelecionaRegistroPessoaFisica);
        end;
      end; //FbEditarAgenciamentoStandBy = False
    end; //fnSELECIONAR_ESTADO_DIGITANDO

  end; //case
end;


procedure TfrmCadAgenciamento.VerificarAgencPessoaFisicaExiste();
begin

  if(Trim(plsEdPessoa.Text) <> STRING_INDEFINIDO)then
  begin
    if not(Self.FbEditarAgenciamentoStandBy)then
    begin
      FoConjuntoDadosAgencPessoaFisica.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdPessoa.Text + '%'));
      FoConjuntoDadosAgencPessoaFisica.ExecutarFiltrar();

      if(FoConjuntoDadosAgencPessoaFisica.TotalRegistros = 1)then
      begin
        FoPessoa.codigo := FoConjuntoDadosAgencPessoaFisica.GetCodigo;
        FoPessoa.nome := FoConjuntoDadosAgencPessoaFisica.GetNome;
        plsEdPessoa.Text := FoPessoa.nome;
      end
      else if(FoConjuntoDadosAgencPessoaFisica.TotalRegistros > 1)then
        AbreTelaSelecaoAgencPessoaFisica(fnSELECIONAR_AGENC_PESSOA_FISICA_DIGITANDO)
      else
      begin
        MessageDlg('Pessoa Física não encontrada.', mtInformation, [mbOK], 0);
        FoFuncoes.focarComponente(plsEdPessoa);
      end;
    end
    else
      AbreTelaSelecaoAgencPessoaFisica(fnSELECIONAR_AGENC_PESSOA_FISICA_DIGITANDO);
  end;
end;

procedure TfrmCadAgenciamento.AbreTelaSelecaoAgencPessoaJuridica(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdPessoa.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_AGENC_PESSOA_JURIDICA_NORMAL:
    begin
      if(Self.FbEditarAgenciamentoStandBy)then
      begin
        try
          Application.CreateForm(TfrmCadPessoaJuridica,frmCadPessoaJuridica);
          frmCadPessoaJuridica.iniciarTela(frmCadPessoaJuridica);
          frmCadPessoaJuridica.passarParametro(PRM_EDITAR_PESSOA_AGENCIAMENTO_STAND_BY, FORM_CAD_AGENCIAMENTOS);
          frmCadPessoaJuridica.passarParametro(PRM_CARREGA_REGISTRO_CODIGO, Self.FoAgenciamento.getFk_Pessoa_Juridica);
          frmCadPessoaJuridica.ShowModal;
        finally
          if(Self.FoPessoa.codigo <> NUMERO_INDEFINIDO)then
          begin
            plsEdPessoa.Text := Self.FoPessoa.nome;
            Self.FoFuncoes.focarComponente(plsEdImovel);
          end;
          FreeAndNil(frmCadPessoaJuridica);
        end;
      end //FbEditarAgenciamentoStandBy = true

      else //FbEditarAgenciamentoStandBy = False
      begin
        try
          Application.CreateForm(TfrmSelecionaRegistroPessoaJuridica, frmSelecionaRegistroPessoaJuridica);
          frmSelecionaRegistroPessoaJuridica.passarParametro(PRM_INICIAR_TELA, null);
          frmSelecionaRegistroPessoaJuridica.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_AGENCIAMENTOS);
          frmSelecionaRegistroPessoaJuridica.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
          if(plsEdPessoa.Text <> STRING_INDEFINIDO)then
            frmSelecionaRegistroPessoaJuridica.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
          frmSelecionaRegistroPessoaJuridica.ShowModal;
        finally
          if(Self.FoPessoa.codigo <> NUMERO_INDEFINIDO)then
          begin
            plsEdPessoa.Text := Self.FoPessoa.nome;
            Self.FoFuncoes.focarComponente(plsEdImovel);
          end;
          FreeAndNil(frmSelecionaRegistroPessoaJuridica);
        end;
      end; //FbEditarAgenciamentoStandBy = False
    end; //fnSELECIONAR_AGENC_PESSOA_JURIDICA_NORMAL

    fnSELECIONAR_AGENC_PESSOA_JURIDICA_DIGITANDO:
    begin
      if(Self.FbEditarAgenciamentoStandBy)then
      begin
        try
          Application.CreateForm(TfrmCadPessoaFisica,frmCadPessoaFisica);
          frmCadPessoaFisica.iniciarTela(frmCadPessoaFisica);
          frmCadPessoaFisica.passarParametro(PRM_EDITAR_PESSOA_AGENCIAMENTO_STAND_BY, FORM_CAD_AGENCIAMENTOS);
          frmCadPessoaFisica.passarParametro(PRM_CARREGA_REGISTRO_CODIGO, Self.FoAgenciamento.getFk_Pessoa_Fisica);
          frmCadPessoaFisica.ShowModal;
        finally
          if(Self.FoPessoa.codigo <> NUMERO_INDEFINIDO)then
          begin
            plsEdPessoa.Text := Self.FoPessoa.nome;
            Self.FoFuncoes.focarComponente(plsEdImovel);
          end;
          FreeAndNil(frmCadPessoaFisica);
        end;
      end //FbEditarAgenciamentoStandBy = true

      else //FbEditarAgenciamentoStandBy = False
      begin
        try
          Application.CreateForm(TfrmSelecionaRegistroPessoaJuridica, frmSelecionaRegistroPessoaJuridica);
          frmSelecionaRegistroPessoaJuridica.passarParametro(PRM_INICIAR_TELA, null);
          frmSelecionaRegistroPessoaJuridica.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_AGENCIAMENTOS);
          frmSelecionaRegistroPessoaJuridica.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
          frmSelecionaRegistroPessoaJuridica.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
          frmSelecionaRegistroPessoaJuridica.ShowModal;
        finally
          if(Self.FoPessoa.codigo <> NUMERO_INDEFINIDO)then
          begin
            plsEdPessoa.Text := Self.FoPessoa.nome;
            Self.FoFuncoes.focarComponente(plsEdImovel);
          end;
          FreeAndNil(frmSelecionaRegistroPessoaJuridica);
        end;
      end; //FbEditarAgenciamentoStandBy = False
    end; //fnSELECIONAR_AGENC_PESSOA_JURIDICA_DIGITANDO

  end; //case
end;

procedure TfrmCadAgenciamento.VerificarAgencPessoaJuridicaExiste();
begin         

  if(Trim(plsEdPessoa.Text) <> STRING_INDEFINIDO)then
  begin
    if not(Self.FbEditarAgenciamentoStandBy)then
    begin
      FoConjuntoDadosAgencPessoaJuridica.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdPessoa.Text + '%'));
      FoConjuntoDadosAgencPessoaJuridica.ExecutarFiltrar();

      if(FoConjuntoDadosAgencPessoaJuridica.TotalRegistros = 1)then
      begin
        FoPessoa.codigo := FoConjuntoDadosAgencPessoaJuridica.GetCodigo;
        FoPessoa.nome := FoConjuntoDadosAgencPessoaJuridica.GetNome;
        plsEdPessoa.Text := FoPessoa.nome;
      end
      else if(FoConjuntoDadosAgencPessoaJuridica.TotalRegistros > 1)then
        AbreTelaSelecaoAgencPessoaJuridica(fnSELECIONAR_AGENC_PESSOA_JURIDICA_DIGITANDO)
      else
      begin
        MessageDlg('Pessoa Jurídica não encontrada.', mtInformation, [mbOK], 0);
        FoFuncoes.focarComponente(plsEdPessoa);
      end;
    end
    else                              
      AbreTelaSelecaoAgencPessoaJuridica(fnSELECIONAR_AGENC_PESSOA_JURIDICA_DIGITANDO);
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadAgenciamento.spBtnBuscaImovelClick(Sender: TObject);
begin
  inherited;
  if(Self.FbEditarAgenciamentoStandBy)then
  begin
    try
      Application.CreateForm(TfrmCadImoveis,frmCadImoveis);
      frmCadImoveis.iniciarTela(frmCadImoveis);
      frmCadImoveis.passarParametro(PRM_EDITAR_PESSOA_AGENCIAMENTO_STAND_BY,
        FORM_CAD_AGENCIAMENTOS);
      frmCadImoveis.passarParametro(PRM_CARREGA_REGISTRO_CODIGO,
        Self.FoAgenciamento.getFk_Imovel);
      frmCadImoveis.ShowModal;
    finally
      if(Self.FoImovel.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdImovel.Text := Self.FoImovel.nome;
        Self.FoFuncoes.focarComponente(plsCbBxCondicaoPagamento);
      end;
      FreeAndNil(frmCadImoveis);
    end;
  end

  else //FbEditarAgenciamentoStandBy = False
  begin
    try
      Application.CreateForm(TfrmCadImoveis,frmCadImoveis);
      frmCadImoveis.iniciarTela(frmCadImoveis);
      frmCadImoveis.passarParametro(PRM_INICIAR_TELA, null);
      frmCadImoveis.passarParametro(PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO, FORM_CAD_AGENCIAMENTOS);
      frmCadImoveis.ShowModal;
    finally
      if(Self.FoImovel.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdImovel.Text := Self.FoImovel.nome;
        Self.FoFuncoes.focarComponente(plsCbBxCondicaoPagamento);
      end;
      FreeAndNil(frmCadImoveis);
    end;
  end;
end;

procedure TfrmCadAgenciamento.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoAgenciamento := TObjAgenciamento.Create;
  FoConjuntoDadosAgencPessoaFisica := TConjuntoDadosAgencPessoaFisica.CriaObjeto;
  FoConjuntoDadosAgencPessoaJuridica := TConjuntoDadosAgencPessoaJuridica.CriaObjeto;
  Self.FbEditarAgenciamentoExpirado := False;
  Self.FbEditarAgenciamentoStandBy := False;
  configurarTela('normal');
end;

procedure TfrmCadAgenciamento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoAgenciamento);
  FreeAndNil(FoConjuntoDadosAgencPessoaFisica);
  FreeAndNil(FoConjuntoDadosAgencPessoaJuridica);
  if(Assigned(frmSelecionarCaracBemNegociavel))then
    FreeAndNil(frmSelecionarCaracBemNegociavel);  
end;

procedure TfrmCadAgenciamento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadAgenciamento.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo
end;

procedure TfrmCadAgenciamento.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadAgenciamento.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadAgenciamento.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadAgenciamento.tlBtnCancelarClick(Sender: TObject);
begin
  if(Self.FbEditarAgenciamentoExpirado)or(Self.FbEditarAgenciamentoStandBy)then
    Self.Close
  else
    inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadAgenciamento.rdGrpTipoPessoaClick(Sender: TObject);
begin
  inherited;

  //caso já tivesse uma pessoa selecionada, limpa dados da pessoa
  if(Self.FoPessoa.codigo <> NUMERO_INDEFINIDO)then
  begin
    if(Self.FoPessoaAgenciamento = [pessoaFisica])and(rdGrpTipoPessoa.ItemIndex = 1)then
    begin
      Self.FoPessoa.codigo := NUMERO_INDEFINIDO;
      Self.FoPessoa.nome := STRING_INDEFINIDO;
      plsEdPessoa.Clear;
    end
    else if(Self.FoPessoaAgenciamento = [pessoaJuridica])and(rdGrpTipoPessoa.ItemIndex = 0)then
    begin
      Self.FoPessoa.codigo := NUMERO_INDEFINIDO;
      Self.FoPessoa.nome := STRING_INDEFINIDO;
      plsEdPessoa.Clear;
    end;
  end;

  case rdGrpTipoPessoa.ItemIndex of
    0: Self.FoPessoaAgenciamento := [pessoaFisica];
    1: Self.FoPessoaAgenciamento := [pessoaJuridica];
    else Self.FoPessoaAgenciamento := [];
  end;
end;

procedure TfrmCadAgenciamento.spBtnBuscaPessoaClick(Sender: TObject);
begin
  inherited;

  if(Self.FoPessoaAgenciamento = [pessoaFisica])then
    AbreTelaSelecaoAgencPessoaFisica(fnSELECIONAR_AGENC_PESSOA_FISICA_NORMAL)
  else if(Self.FoPessoaAgenciamento = [pessoaJuridica])then
    AbreTelaSelecaoAgencPessoaJuridica(fnSELECIONAR_AGENC_PESSOA_JURIDICA_NORMAL)
  else
    MessageDlg('Selecione um tipo de pessoa.', mtInformation, [mbOK], 0);
end;

procedure TfrmCadAgenciamento.plsEdImovelClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaImovelClick(Self);
end;

procedure TfrmCadAgenciamento.plsEdImovelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaImovelClick(Self);
end;

procedure TfrmCadAgenciamento.plsCbBxCondicaoPagamentoChange(
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

procedure TfrmCadAgenciamento.rdGrpTipoAgenciamentoClick(Sender: TObject);
begin
  inherited;
  case rdGrpTipoAgenciamento.ItemIndex of
    0: Self.FoTipoAgenciamento := [normal];
    1: Self.FoTipoAgenciamento := [standBy];
    else Self.FoTipoAgenciamento := [];
  end;
end;

procedure TfrmCadAgenciamento.FormShow(Sender: TObject);
begin
  if(not(Self.FbEditarAgenciamentoExpirado))and(not(Self.FbEditarAgenciamentoStandBy))then
    inherited;
end;

procedure TfrmCadAgenciamento.btBtnDarBaixaAgenciamentoClick(
  Sender: TObject);
begin
  inherited;
  if(MessageDlg('Deseja dar baixa neste agenciamento?', mtConfirmation, [mbYes,mbNo], 0)=mrYes)then
    Self.salvarEdicaoAgenciamentoExpirou('darBaixa');
end;

procedure TfrmCadAgenciamento.btBtnReagenciarAgenciamentoClick(
  Sender: TObject);
var
  dtDataReagenciamento: TDate;
  bContinua: Boolean;
begin
  inherited;

  bContinua := True;
  dtDataReagenciamento := Self.FoFuncoes.formatarData(plsMedReagenciamentoAgenciamento.Text);

  if(dtDataReagenciamento = NUMERO_INDEFINIDO)then
  begin
    MessageDlg('Data do reagenciamento inválida.', mtInformation, [mbOK], 0);
    bContinua := False;
  end;

  //data informada deve ser maior que a data do re-agencimento (se já foi informada)
  if(bContinua)then
  begin
    if(Self.FoAgenciamento.getData_Reagenciamento <> NUMERO_INDEFINIDO)then
    begin
      if(Self.FoAgenciamento.getData_Reagenciamento >= dtDataReagenciamento)then
      begin
        MessageDlg('Data do reagenciamento deve ser maior que a data do re-agenciamento já cadastrada.', mtInformation, [mbOK], 0);
        bContinua := False;
      end;
    end;
  end;

  //data informada deve ser maior que a data do agenciamento
  if(bContinua)then
  begin
    if(Self.FoAgenciamento.getPrazo_Autorizacao <> NUMERO_INDEFINIDO)then
    begin
      if(Self.FoAgenciamento.getPrazo_Autorizacao >= dtDataReagenciamento)then
      begin
        MessageDlg('Data do reagenciamento deve ser maior que o prazo de autorização.', mtInformation, [mbOK], 0);
        bContinua := False;
      end;
    end;
  end;

  //data informada deve ser maior que a data atual
  if(bContinua)then
  begin
    if(dtDataReagenciamento < Now)then
    begin
      MessageDlg('Data do reagenciamento deve ser maior que a data atual.', mtInformation, [mbOK], 0);
      bContinua := False;
    end;
  end;

  if(bContinua)then
  begin
    if(MessageDlg('Deseja realizar o re-agenciamento deste agenciamento?', mtConfirmation, [mbYes,mbNo], 0)=mrYes)then
      Self.salvarEdicaoAgenciamentoExpirou('reAgenciar');
  end
  else
    Self.FoFuncoes.focarComponente(plsMedReagenciamentoAgenciamento);
end;

procedure TfrmCadAgenciamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if(Assigned(frmPrincipal))then
  begin
    frmPrincipal.passarParametro(PRM_ATUALIZAR_AGENCIAMENTOS_EDITANDO, null);
    frmPrincipal.passarParametro(PRM_ATUALIZAR_AGENCIAMENTOS_STANDBY, null);
  end;
end;

procedure TfrmCadAgenciamento.plsEdPessoaExit(Sender: TObject);
begin
  inherited;

  if(Self.FoPessoaAgenciamento = [pessoaFisica])then
    VerificarAgencPessoaFisicaExiste()
  else if(Self.FoPessoaAgenciamento = [pessoaJuridica])then
    VerificarAgencPessoaJuridicaExiste()
  else
    MessageDlg('Selecione um tipo de pessoa.', mtInformation, [mbOK], 0);
end;

procedure TfrmCadAgenciamento.btBtnSelecionarCaracteristicasVistaClick(
  Sender: TObject);
var
  vParametros: OleVariant;
begin
  vParametros := VarArrayCreate([0,0], varVariant);
  vParametros[0] := 1; //à vista

  Application.CreateForm(TfrmSelecionarCaracBemNegociavel, frmSelecionarCaracBemNegociavel);
  frmSelecionarCaracBemNegociavel.passarParametro(PRM_DEFINE_QUEM_RECEBE_CARACTERISTICAS_BEM_NEGOCIAVEL, vParametros);
  frmSelecionarCaracBemNegociavel.Show;
end;

procedure TfrmCadAgenciamento.btBtnSelecionarCaracteristicasFinanciamentoClick(
  Sender: TObject);
var
  vParametros: OleVariant;
begin
  vParametros := VarArrayCreate([0,0], varVariant);
  vParametros[0] := 2; //financiamento

  Application.CreateForm(TfrmSelecionarCaracBemNegociavel, frmSelecionarCaracBemNegociavel);
  frmSelecionarCaracBemNegociavel.passarParametro(PRM_DEFINE_QUEM_RECEBE_CARACTERISTICAS_BEM_NEGOCIAVEL, vParametros);
  frmSelecionarCaracBemNegociavel.Show;
end;

end.

