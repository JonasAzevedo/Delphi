unit unCadVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ComCtrls, ToolWin, Mask, plsTMaskEdit, ExtCtrls, plsComboBox, Buttons,
  plsMemo, unObjVenda, unVariaveis,
  unConjuntoDadosConstrutora, unConjuntoDadosClientePessoaFisica, unConjuntoDadosClientePessoaJuridica;

  type
    TCliente = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TImovel = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TAgenciamento = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TConstrutora = record
      codigo: Integer;
      nome: string[100];
    end;

type
  TfrmCadVenda = class(TfrmCadastroBasico)
    pnlDataCancelamento: TPanel;
    lblDataCancelamento: TLabel;
    plsMedDataCancelamento: TPlsMaskEdit;
    plsMedDataVenda: TPlsMaskEdit;
    lblCampoObrigatorio1: TLabel;
    lblDataVenda: TLabel;
    plsEdCodigo: TPlsEdit;
    lblCodigo: TLabel;
    pnlCliente: TPanel;
    lblCliente: TLabel;
    spBtnBuscaCliente: TSpeedButton;
    lblCampoObrigatorio2: TLabel;
    plsEdCliente: TPlsEdit;
    pnlImovel: TPanel;
    spBtnBuscaImovel: TSpeedButton;
    lblImovel: TLabel;
    lblCampoObrigatorio3: TLabel;
    plsEdImovel: TPlsEdit;
    pnlTipoVenda: TPanel;
    lblTipoVenda: TLabel;
    lblCampoObrigatorio5: TLabel;
    plsCbBxTipoVenda: TPlsComboBox;
    lblImovelDe: TLabel;
    Label2: TLabel;
    plsCbBxImovelDe: TPlsComboBox;
    pnlConstrutora: TPanel;
    spBtnBuscaConstrutora: TSpeedButton;
    lblConstrutora: TLabel;
    Label3: TLabel;
    plsEdConstrutora: TPlsEdit;
    lblObservacao: TLabel;
    plsMmObservacao: TPlsMemo;
    pnlValores: TPanel;
    lblValorVenda: TLabel;
    plsMedValorVenda: TPlsEdit;
    lblDeducoes: TLabel;
    plsMedDeducoes: TPlsEdit;
    lblValorBemNegociavel: TLabel;
    plsMedValorBemNegociavel: TPlsEdit;
    lblDeduzirBemNegociavelValorVenda: TLabel;
    plsCbBxDeduzirBemNegociavel: TPlsComboBox;
    lblValorCalculoComissao: TLabel;
    plsMedValorCalculoComissao: TPlsEdit;
    lblPercentualSobreComissao: TLabel;
    plsMedPercentualSobreComissao: TPlsEdit;
    lblPercentualSobreVenda: TLabel;
    plsMedPercentualSobreVenda: TPlsEdit;
    plsMedValorTotalComissao: TPlsEdit;
    lblValorTotalComissao: TLabel;
    rdGrpTipoPessoa: TRadioGroup;
    lblTipoCalculoComissao: TLabel;
    plsCbBxTipoCalculoComissao: TPlsComboBox;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosDATA_VENDA: TDateField;
    zQryDadosATIVO: TStringField;
    zQryDadosTIPO_PESSOA: TStringField;
    zQryDadosCOD_FK_CLIENTE_PESSOA_FISICA: TIntegerField;
    zQryDadosCOD_FK_CLIENTE_PESSOA_JURIDICA: TIntegerField;
    zQryDadosCOD_FK_IMOVEL: TIntegerField;
    zQryDadosCOD_FK_AGENCIAMENTO: TIntegerField;
    zQryDadosTIPO_VENDA: TStringField;
    zQryDadosVENDA_MEU_AGENCIAMENTO_MEU: TStringField;
    zQryDadosVENDA_MEU_AGENCIAMENTO_COLEGAS: TStringField;
    zQryDadosVENDA_PAUTA_CONSTRUTORA: TStringField;
    zQryDadosVENDA_PAUTA_TERCEIROS: TStringField;
    zQryDadosCOD_FK_TP_VND_CONSTRUTORA: TIntegerField;
    zQryDadosVALOR_VENDA: TFloatField;
    zQryDadosDEDUCOES: TFloatField;
    zQryDadosVALOR_BEM_NEGOCIAVEL: TFloatField;
    zQryDadosDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField;
    zQryDadosTIPO_CALCULO_COMISSAO: TStringField;
    zQryDadosVALOR_PARA_CALCULO_COMISSAO: TFloatField;
    zQryDadosPERCENTUAL_SOBRE_VENDA: TFloatField;
    zQryDadosVALOR_TOTAL_COMISSAO: TFloatField;
    zQryDadosPERCENTUAL_SOBRE_COMISSAO: TFloatField;
    zQryDadosOBSERVACAO: TStringField;
    zQryDadosDATA_CANCELAMENTO: TDateTimeField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosDATA_VENDA: TDateField;
    cdsDadosATIVO: TStringField;
    cdsDadosTIPO_PESSOA: TStringField;
    cdsDadosCOD_FK_CLIENTE_PESSOA_FISICA: TIntegerField;
    cdsDadosCOD_FK_CLIENTE_PESSOA_JURIDICA: TIntegerField;
    cdsDadosCOD_FK_IMOVEL: TIntegerField;
    cdsDadosCOD_FK_AGENCIAMENTO: TIntegerField;
    cdsDadosTIPO_VENDA: TStringField;
    cdsDadosVENDA_MEU_AGENCIAMENTO_MEU: TStringField;
    cdsDadosVENDA_MEU_AGENCIAMENTO_COLEGAS: TStringField;
    cdsDadosVENDA_PAUTA_CONSTRUTORA: TStringField;
    cdsDadosVENDA_PAUTA_TERCEIROS: TStringField;
    cdsDadosCOD_FK_TP_VND_CONSTRUTORA: TIntegerField;
    cdsDadosVALOR_VENDA: TFloatField;
    cdsDadosDEDUCOES: TFloatField;
    cdsDadosVALOR_BEM_NEGOCIAVEL: TFloatField;
    cdsDadosDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField;
    cdsDadosTIPO_CALCULO_COMISSAO: TStringField;
    cdsDadosVALOR_PARA_CALCULO_COMISSAO: TFloatField;
    cdsDadosPERCENTUAL_SOBRE_VENDA: TFloatField;
    cdsDadosVALOR_TOTAL_COMISSAO: TFloatField;
    cdsDadosPERCENTUAL_SOBRE_COMISSAO: TFloatField;
    cdsDadosOBSERVACAO: TStringField;
    cdsDadosDATA_CANCELAMENTO: TDateTimeField;
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure plsCbBxTipoVendaChange(Sender: TObject);
    procedure spBtnBuscaClienteClick(Sender: TObject);
    procedure spBtnBuscaImovelClick(Sender: TObject);
    procedure spBtnBuscaConstrutoraClick(Sender: TObject);
    procedure plsCbBxImovelDeChange(Sender: TObject);
    procedure plsEdImovelKeyPress(Sender: TObject; var Key: Char);
    procedure lsCbBxDeduzirBemNegociavelChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdConstrutoraExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rdGrpTipoPessoaClick(Sender: TObject);
    procedure plsEdClienteExit(Sender: TObject);
    procedure plsCbBxTipoCalculoComissaoChange(Sender: TObject);
    procedure plsMedDataVendaEnter(Sender: TObject);
    procedure plsMedDataVendaKeyPress(Sender: TObject; var Key: Char);
    procedure plsMedDataCancelamentoKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedDataCancelamentoEnter(Sender: TObject);
    procedure plsCbBxTipoVendaEnter(Sender: TObject);
    procedure plsCbBxTipoVendaKeyPress(Sender: TObject; var Key: Char);
    procedure plsCbBxImovelDeKeyPress(Sender: TObject; var Key: Char);
    procedure plsCbBxImovelDeEnter(Sender: TObject);
    procedure rdGrpTipoPessoaEnter(Sender: TObject);
    procedure plsEdClienteEnter(Sender: TObject);
    procedure plsEdClienteKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdConstrutoraKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdConstrutoraEnter(Sender: TObject);
    procedure plsEdImovelEnter(Sender: TObject);
    procedure plsEdImovelClick(Sender: TObject);
    procedure plsMedValorVendaEnter(Sender: TObject);
    procedure plsMedValorVendaKeyPress(Sender: TObject; var Key: Char);
    procedure plsMedDeducoesKeyPress(Sender: TObject; var Key: Char);
    procedure plsMedDeducoesEnter(Sender: TObject);
    procedure plsMedValorBemNegociavelEnter(Sender: TObject);
    procedure plsMedValorBemNegociavelKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsCbBxDeduzirBemNegociavelKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsCbBxDeduzirBemNegociavelEnter(Sender: TObject);
    procedure plsCbBxTipoCalculoComissaoEnter(Sender: TObject);
    procedure plsCbBxTipoCalculoComissaoKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedPercentualSobreVendaKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedPercentualSobreVendaEnter(Sender: TObject);
    procedure plsMedValorCalculoComissaoEnter(Sender: TObject);
    procedure plsMedValorCalculoComissaoKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedValorTotalComissaoKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedValorTotalComissaoEnter(Sender: TObject);
    procedure plsMmObservacaoEnter(Sender: TObject);
    procedure plsMmObservacaoKeyPress(Sender: TObject; var Key: Char);
    procedure lblDicasClick(Sender: TObject);
  private
    FoVenda: TObjVenda;
    FoPessoaAgenciamento: TTiposPessoas;
    FoConjuntoDadosConstrutora: TConjuntoDadosConstrutora;
    FoConjuntoDadosClientePessoaFisica: TConjuntoDadosClientePessoaFisica;
    FoConjuntoDadosClientePessoaJuridica: TConjuntoDadosClientePessoaJuridica;
    FoTipoVenda: TTiposVendas;
    FoTipoImovelDe: TTiposImoveisDe;
    FoDeduzir: TTiposSimNao;

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
    procedure popularComboBoxImovelDe();

    procedure AbreTelaSelecaoConstrutora(pnTpSelecao:Word);
    procedure VerificarConstrutoraExiste();

    procedure AbreTelaSelecaoClientePessoaFisica(pnTpSelecao:Word);
    procedure VerificarClientePessoaFisicaExiste();

    procedure AbreTelaSelecaoClientePessoaJuridica(pnTpSelecao:Word);
    procedure VerificarClientePessoaJuridicaExiste();

    procedure LimparImovel;
  public
    FoCliente: TCliente;
    FoImovel: TImovel;
    FoAgenciamento: TAgenciamento;
    FoConstrutora: TConstrutora;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadVenda: TfrmCadVenda;

implementation

uses
  unConstantes, unDM, unSelecionaRegistroCliente,
  unSelecionaRegistroImovel, unSelecionaRegistroConstrutora, unFuncoes,
  unSelecionaRegistroAgenciamento,
  unSelecionaRegistroClientePessoaJuridica, unPrincipal;

const
  fnSELECIONAR_CONSTRUTORA_NORMAL    = 1;
  fnSELECIONAR_CONSTRUTORA_DIGITANDO = 2;

  fnSELECIONAR_CLIENTE_PESSOA_FISICA_NORMAL = 1;
  fnSELECIONAR_CLIENTE_PESSOA_FISICA_DIGITANDO = 2;

  fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_NORMAL = 1;
  fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_DIGITANDO = 2;

{$R *.dfm}

{ TfrmCadVenda }

(* procedimentos de controle *)

procedure TfrmCadVenda.iniciarTela(poForm: TForm);
begin
  inherited;
(*  Application.CreateForm(TfrmPesquisandoAgenciamento, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmPesquisandoAgenciamento);
  Self.FoPesquisa.Hide;
*)
end;

procedure TfrmCadVenda.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;
{  if(pTipo = PRM_CRIA_TELA_PESQUISA)then
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
  end

  else if (pTipo = PRM_EDITAR_AGENCIAMENTO_EXPIROU)then
  begin
    if (VarIsNumeric(pValores)) then
    begin
      editarRegistroExpirou(pValores);
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
      finalizarAgenciamentoStandBy(pValores);
      Self.FbEditarAgenciamentoStandBy := True;
    end
    else
    begin
      MessageDlg('Código do Agenciamento passado no parâmetro é inválido.',
       mtInformation, [mbOK], 0);
    end;
  end;
}

  if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS)then
  begin
    if(pValores[0] = CONJUNTO_DADOS_CONSTRUTORA)then
      FoConjuntoDadosConstrutora.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_CLIENTE_PESSOA_FISICA)then
      FoConjuntoDadosClientePessoaFisica.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_CLIENTE_PESSOA_JURIDICA)then
      FoConjuntoDadosClientePessoaJuridica.ExecutarSQLSelecao();
  end;
end;

procedure TfrmCadVenda.limparObjeto();
begin
  if (Assigned(Self.FoVenda)) then
  begin
    Self.FoVenda.limparObjeto();
  end
end;

procedure TfrmCadVenda.limparTela(poForm: TForm);
begin
  inherited;

  rdGrpTipoPessoa.ItemIndex := -1;

  Self.FoCliente.codigo := NUMERO_INDEFINIDO;
  Self.FoCliente.nome := STRING_INDEFINIDO;

  Self.FoImovel.codigo := NUMERO_INDEFINIDO;
  Self.FoImovel.nome := STRING_INDEFINIDO;

  Self.FoAgenciamento.codigo := NUMERO_INDEFINIDO;
  Self.FoAgenciamento.nome := STRING_INDEFINIDO;

  Self.FoConstrutora.codigo := NUMERO_INDEFINIDO;
  Self.FoConstrutora.nome := STRING_INDEFINIDO;

  FoPessoaAgenciamento := [];
  Self.FoTipoVenda := [];
  Self.FoTipoImovelDe := [];
  Self.FoDeduzir := [];
end;

function TfrmCadVenda.verificarHouveAlteracoes(): boolean;
begin
  Result := True;
end;

function TfrmCadVenda.verificarCamposObrigatorios(): boolean;
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

  if(not(Self.FoFuncoes.validarData(plsMedDataVenda.Text)))then
  begin
    campos := 'Data da Venda';
    compFoco := plsMedDataVenda;
  end;

  if(FoPessoaAgenciamento = [])then
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

  if(Self.FoTipoVenda = [])then
  begin
    if(campos <> '')then
      campos := campos + ', Tipo de Venda'
    else
    begin
      campos := 'Tipo de Venda';
    end;
    if(compFoco = nil)then
      compFoco := plsCbBxTipoVenda;
  end;

  if(Self.FoTipoImovelDe = [])then
  begin
    if(campos <> '')then
      campos := campos + ', Imóvel De'
    else
    begin
      campos := 'Imóvel De';
    end;
    if(compFoco = nil)then
      compFoco := plsCbBxImovelDe;
  end;

  //tipo venda = pauta, imóvel de = construtora
  if(plsCbBxTipoVenda.ItemIndex = 1)and(plsCbBxImovelDe.ItemIndex = 0)then
  begin
    if(Self.FoConstrutora.codigo = NUMERO_INDEFINIDO)then
    begin
      if(campos <> '')then
        campos := campos + ', Construtora'
      else
      begin
        campos := 'Construtora';
      end;
      if(compFoco = nil)then
        compFoco := plsEdConstrutora;
    end;
  end
  else
    Self.FoConstrutora.codigo := REGISTRO_NULO;

  if(not(plsCbBxTipoCalculoComissao.ItemIndex in[0,1]))then
  begin
    if(campos <> '')then
      campos := campos + ', Tipo Cálculo Comissão'
    else
    begin
      campos := 'Tipo Cálculo Comissão:';
    end;
    if(compFoco = nil)then
      compFoco := plsCbBxTipoCalculoComissao;
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

function TfrmCadVenda.verificarRegistroJaExiste(): boolean;
begin
  Result := False;
end;

function TfrmCadVenda.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  //só pode deletar se estiver editando
  if(not(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR))then
    bPodeDeletar := False;

  Result := bPodeDeletar;
end;

procedure TfrmCadVenda.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsMedDataVenda.Enabled := False;
                       pnlDataCancelamento.Enabled := False;
                       pnlCliente.Enabled := False;
                       pnlImovel.Enabled := False;
                       pnlTipoVenda.Enabled := False;
                       rdGrpTipoPessoa.Enabled := False;
                       pnlConstrutora.Enabled := False;
                       pnlValores.Enabled := False;
                       plsMmObservacao.Enabled := False;
                       Self.FoFuncoes.focarComponente(plsEdCodigo);
                       lblPercentualSobreVenda.Visible := False;
                       plsMedPercentualSobreVenda.Visible := False;
                       lblPercentualSobreComissao.Visible := False;
                       plsMedPercentualSobreComissao.Visible := False;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_VENDAS,True));
                       plsEdCodigo.Enabled := False;
                       plsMedDataVenda.Enabled := True;
                       pnlDataCancelamento.Visible := False;
                       pnlCliente.Enabled := True;
                       pnlImovel.Enabled := True;
                       pnlTipoVenda.Enabled := True;
                       rdGrpTipoPessoa.Enabled := True;
                       pnlConstrutora.Visible := False;
                       pnlValores.Enabled := True;
                       plsMmObservacao.Enabled := True;
                       Self.FoFuncoes.focarComponente(plsMedDataVenda);
                       lblPercentualSobreVenda.Visible := False;
                       plsMedPercentualSobreVenda.Visible := False;
                       lblPercentualSobreComissao.Visible := False;
                       plsMedPercentualSobreComissao.Visible := False;
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       plsMedDataVenda.Enabled := True;
                       pnlDataCancelamento.Visible := False;
                       pnlCliente.Enabled := True;
                       pnlImovel.Enabled := True;
                       pnlTipoVenda.Enabled := True;
                       rdGrpTipoPessoa.Enabled := True;
                       pnlConstrutora.Visible := False;
                       pnlValores.Enabled := True;
                       plsMmObservacao.Enabled := True;
                       Self.FoFuncoes.focarComponente(plsMedDataVenda);
                     end;
    OPC_SALVAR:      begin

                     end;
    OPC_EXCLUIR:     begin

                     end;
    OPC_CANCELAR:    begin

                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       plsMedDataVenda.Enabled := False;
                       pnlDataCancelamento.Visible := False;
                       pnlCliente.Enabled := False;
                       pnlImovel.Enabled := False;
                       pnlTipoVenda.Enabled := False;
                       rdGrpTipoPessoa.Enabled := False;
                       pnlConstrutora.Visible := False;
                       pnlValores.Enabled := False;
                       plsMmObservacao.Enabled := False;
                     end;
  end; //fim - case
end;

function TfrmCadVenda.outrasValidacoesAntesSalvar(): Boolean;
var
  compFoco: TWinControl;
  dValorTotal: Currency;
  bRetorno: Boolean;

begin
  compFoco := nil;
  bRetorno := True;

  //construtora
  if(Self.FoTipoVenda = [pauta])and(Self.FoTipoImovelDe = [construtora])and
   (Self.FoConstrutora.codigo = NUMERO_INDEFINIDO)then
  begin
    MessageDlg('Informe a construtora.',mtInformation,[mbOK],0);
    compFoco := plsEdConstrutora;
    bRetorno := False;
  end;

  //valor da venda
  if(bRetorno)then
  begin
    if(not(Self.FoFuncoes.validarValorMonetario(plsMedValorVenda.Text)))then
    begin
      MessageDlg('Informe o valor da venda.', mtInformation, [mbOK], 0);
      compFoco := plsMedValorVenda;
      bRetorno := False;
    end;
  end;

  //deduzir
  if(bRetorno)then
  begin
    if(Self.FoFuncoes.validarValorMonetario(plsMedValorBemNegociavel.Text))and
      (Self.FoDeduzir = [])then
    begin
      MessageDlg('Informe se deseja ou não deduzir o valor do bem negociável.', mtInformation, [mbOK], 0);
      compFoco := plsCbBxDeduzirBemNegociavel;
      bRetorno := False;
    end;
  end;

  //setar foco no componente que não foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    Self.FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

procedure TfrmCadVenda.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadVenda);
  visibilidade(OPC_NOVO);
  plsMedDataVenda.Text := DateToStr(Now);
end;

function TfrmCadVenda.salvar(): boolean;
var
  bSalvou: boolean;

  sAtivo: String;
  dtDataVenda: TDate;
  nCodFK_Imovel: Integer;
  nCodFk_Agenciamento: Integer;
  sTipoVenda: String;
  sVendaMeuAgenciamentoMeu,sVendaMeuAgenciamentoColegas: String;
  sVendaPautaConstrutora,sVendaPautaTerceiros: String;
  sTipoPessoa: String;
  nCodFK_ClientePessoaFisica,nCodFK_ClientePessoaJuridica: Integer;
  nCodFK_Construtora: Integer;
  dValorVenda,dDeducoes,dValorBemNegociavel: Currency;
  sDeduzirBemNegociavelValorVenda: String;
  dPercentualSobreVenda,dPercentualSobreComissao: Currency;
  sTipoCalculoComissao: String;
  dValorCalculoComissao,dValorTotalComissao: Currency;
  sObservacoes: String;

  procedure CalcularComissao();
  var
    bDeduzir: Boolean;
    dValorVenda, dDeducoes, dValorBemNegociavel: Currency;
    dValorCalculoComissao: Currency;

    sTipoCalculoComissao: String;
    dPercentualComissao: Currency;
    dValorTotalComissao: Currency;
  begin
    (* VALOR PARA CÁLCULO DE COMISSÃO.
       Se  deduzir bem negociável do valor da venda for "S"
       Valor da venda vezes deduções, (se houver valor diferente de zero ou diferente de vazio), dividido por 100.
       O valor da venda menos o valor do resultado acima menos o valor do bem negociável.

       Se deduzir bem negociável do valor da venda for "N"
       Valor da venda vezes deduções, (se houver valor diferente de zero ou diferente de vazio), dividido por 100.
       O valor da venda menos o valor do resultado acima.
    *)
    bDeduzir := FoDeduzir = [sim];
    dValorVenda := FoFuncoes.formatarValorCurrency(plsMedValorVenda.Text);
    dDeducoes := FoFuncoes.formatarValorCurrency(plsMedDeducoes.Text);
    dValorBemNegociavel := FoFuncoes.formatarValorCurrency(plsMedValorBemNegociavel.Text);

    if(bDeduzir)then
    begin
      if(dDeducoes <> NUMERO_INDEFINIDO)then
      begin
        dValorCalculoComissao := (dValorVenda * dDeducoes) / 100;
        dValorCalculoComissao := (dValorVenda - dValorCalculoComissao) - dValorBemNegociavel;
      end
      else
        dValorCalculoComissao := NUMERO_INDEFINIDO;
    end

    else
    begin
      if(dDeducoes <> NUMERO_INDEFINIDO)then
      begin
        dValorCalculoComissao := (dValorVenda * dDeducoes) / 100;
        dValorCalculoComissao := dValorVenda - dValorCalculoComissao;
      end
      else
        dValorCalculoComissao := NUMERO_INDEFINIDO;
    end;

    plsMedValorCalculoComissao.Text := CurrToStr(dValorCalculoComissao);
    plsMedValorCalculoComissao.Text := FoFuncoes.formatarValorMonetario(plsMedValorCalculoComissao.Text);

    (* VALOR TOTAL DA COMISSÃO
       "Sobre venda"
       Valor para cálculo da comissão vezes percentual para comissão dividido por 100
       "Sobre comissão"
       Valor total da comissão vezes percentual para comissão, dividido por 100.
    *)
    sTipoCalculoComissao := plsCbBxTipoCalculoComissao.Text;
    if(sTipoCalculoComissao = 'VENDA')then
    begin
      dPercentualComissao := FoFuncoes.formatarValorCurrency(plsMedPercentualSobreVenda.Text);
      dValorTotalComissao := (dValorCalculoComissao * dPercentualComissao) / 100;
    end

    else if(sTipoCalculoComissao = 'COMISSÃO')then
    begin
      dPercentualComissao := FoFuncoes.formatarValorCurrency(plsMedPercentualSobreComissao.Text);
      dValorTotalComissao := (dValorCalculoComissao * dPercentualComissao) / 100;
    end;

    plsMedValorTotalComissao.Text := CurrToStr(dValorTotalComissao);
    plsMedValorTotalComissao.Text := FoFuncoes.formatarValorMonetario(plsMedValorTotalComissao.Text);

  end; //fim - CalcularComissao()

  procedure carregarValores();
  begin
    sAtivo := VLR_SIM;
    dtDataVenda := Self.FoFuncoes.formatarData(plsMedDataVenda.Text);
    nCodFK_Imovel := Self.FoImovel.codigo;

    if(Self.FoAgenciamento.codigo <> NUMERO_INDEFINIDO)then
      nCodFk_Agenciamento := Self.FoAgenciamento.codigo
    else
      nCodFk_Agenciamento := REGISTRO_NULO;

    if(Self.FoTipoVenda = [meu_agenciamento])then
      sTipoVenda := TIPO_VENDA_MEU_AGENCIAMENTO
    else if(Self.FoTipoVenda = [pauta])then
      sTipoVenda := TIPO_VENDA_PAUTA
    else
      sTipoVenda := STRING_INDEFINIDO;

    sVendaMeuAgenciamentoMeu := VLR_NAO;
    sVendaMeuAgenciamentoColegas := VLR_NAO;
    sVendaPautaConstrutora := VLR_NAO;
    sVendaPautaTerceiros := VLR_NAO;
    if(Self.FoTipoImovelDe = [meu])then
      sVendaMeuAgenciamentoMeu := VLR_SIM
    else if(Self.FoTipoImovelDe = [colegas])then
      sVendaMeuAgenciamentoColegas := VLR_SIM
    else if(Self.FoTipoImovelDe = [construtora])then
      sVendaPautaConstrutora := VLR_SIM
    else if(Self.FoTipoImovelDe = [terceiros])then
      sVendaPautaTerceiros := VLR_SIM;

    if(FoPessoaAgenciamento = [pessoaFisica])then
    begin
      sTipoPessoa := VLR_TP_PESSOA_FISICA;
      nCodFK_ClientePessoaFisica := FoCliente.codigo;
      nCodFK_ClientePessoaJuridica := REGISTRO_NULO;
    end
    else if(FoPessoaAgenciamento = [pessoaJuridica])then
    begin
      sTipoPessoa := VLR_TP_PESSOA_JURIDICA;
      nCodFK_ClientePessoaFisica := REGISTRO_NULO;
      nCodFK_ClientePessoaJuridica := FoCliente.codigo;
    end
    else
    begin
      sTipoPessoa := STRING_INDEFINIDO;
      nCodFK_ClientePessoaFisica := REGISTRO_NULO;
      nCodFK_ClientePessoaJuridica := REGISTRO_NULO;
    end;

    nCodFK_Construtora := Self.FoConstrutora.codigo;
    dValorVenda := Self.FoFuncoes.formatarValorCurrency(plsMedValorVenda.Text);
    dDeducoes := Self.FoFuncoes.formatarValorCurrency(plsMedDeducoes.Text);
    dValorBemNegociavel := Self.FoFuncoes.formatarValorCurrency(plsMedValorBemNegociavel.Text);

    if(Self.FoDeduzir = [sim])then
      sDeduzirBemNegociavelValorVenda := VLR_SIM
    else if(Self.FoDeduzir = [nao])then
      sDeduzirBemNegociavelValorVenda := VLR_NAO
    else
      sDeduzirBemNegociavelValorVenda := STRING_INDEFINIDO;

    dPercentualSobreVenda := Self.FoFuncoes.formatarValorCurrency(plsMedPercentualSobreVenda.Text);
    dPercentualSobreComissao := Self.FoFuncoes.formatarValorCurrency(plsMedPercentualSobreComissao.Text);
    sTipoCalculoComissao := plsCbBxTipoCalculoComissao.Text;
    dValorCalculoComissao := Self.FoFuncoes.formatarValorCurrency(plsMedValorCalculoComissao.Text);
    dValorTotalComissao := Self.FoFuncoes.formatarValorCurrency(plsMedValorTotalComissao.Text);
    sObservacoes := plsMmObservacao.Text;
  end; //fim - carregarValores()

  //atualiza status do imóvel para IMOVEL_STATUS_VENDIDO
  procedure AtualizarImovel();
  begin
    DM.zQryImovel.Close;
    DM.zQryImovel.SQL.Clear;
    DM.zQryImovel.SQL.Add('UPDATE imovel SET status=:status WHERE codigo=:codigo');
    DM.zQryImovel.ParamByName('status').AsInteger := IMOVEL_STATUS_VENDIDO;
    DM.zQryImovel.ParamByName('codigo').AsInteger := Self.FoImovel.codigo;
    DM.zQryImovel.ExecSQL;
  end;

  //atualiza ativo do agenciamento para VLR_NAO
  procedure AtualizarAgenciamento();
  begin
    if(Self.FoAgenciamento.codigo <> NUMERO_INDEFINIDO)then
    begin
      DM.zQryAgenciamentos.Close;
      DM.zQryAgenciamentos.SQL.Clear;
      DM.zQryAgenciamentos.SQL.Add('UPDATE agenciamentos SET ativo=:ativo WHERE codigo=:codigo');
      DM.zQryAgenciamentos.ParamByName('ativo').AsString := VLR_NAO;
      DM.zQryAgenciamentos.ParamByName('codigo').AsInteger := Self.FoAgenciamento.codigo;
      DM.zQryAgenciamentos.ExecSQL;
    end;
  end;

begin
  CalcularComissao();
  carregarValores();
  bSalvou := False;

  if(Self.FiFuncaoRegistro in [FUNCAO_REGISTRO_EDITAR, FUNCAO_REGISTRO_NOVO]) then
  begin
    inherited;
    if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR) then
    begin
    end

    else if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_NOVO) then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('INSERT INTO vendas(data_venda,ativo,');
        zQryDados.SQL.Add('tipo_pessoa,cod_fk_cliente_pessoa_fisica,cod_fk_cliente_pessoa_juridica,');
        zQryDados.SQL.Add('cod_fk_imovel,cod_fk_agenciamento,tipo_venda,venda_meu_agenciamento_meu,');
        zQryDados.SQL.Add('venda_meu_agenciamento_colegas,venda_pauta_construtora,');
        zQryDados.SQL.Add('venda_pauta_terceiros,cod_fk_tp_vnd_construtora,valor_venda,');
        zQryDados.SQL.Add('deducoes,valor_bem_negociavel,deduzir_bem_negoc_valor_venda,');
        zQryDados.SQL.Add('tipo_calculo_comissao,valor_para_calculo_comissao,percentual_sobre_venda,');
        zQryDados.SQL.Add('valor_total_comissao,percentual_sobre_comissao,');
        zQryDados.SQL.Add('observacao)');

        zQryDados.SQL.Add('VALUES(:data_venda,:ativo,');
        zQryDados.SQL.Add(':tipo_pessoa,:cod_fk_cliente_pessoa_fisica,:cod_fk_cliente_pessoa_juridica,');
        zQryDados.SQL.Add(':cod_fk_imovel,:cod_fk_agenciamento,:tipo_venda,:venda_meu_agenciamento_meu,');
        zQryDados.SQL.Add(':venda_meu_agenciamento_colegas,:venda_pauta_construtora,');
        zQryDados.SQL.Add(':venda_pauta_terceiros,:cod_fk_tp_vnd_construtora,:valor_venda,');
        zQryDados.SQL.Add(':deducoes,:valor_bem_negociavel,:deduzir_bem_negoc_valor_venda,');
        zQryDados.SQL.Add(':tipo_calculo_comissao,:valor_para_calculo_comissao,:percentual_sobre_venda,');
        zQryDados.SQL.Add(':valor_total_comissao,:percentual_sobre_comissao,');
        zQryDados.SQL.Add(':observacao)');

        zQryDados.ParamByName('data_venda').AsDate := dtDataVenda;
        zQryDados.ParamByName('ativo').AsString := sAtivo;
        zQryDados.ParamByName('tipo_pessoa').AsString := sTipoPessoa;
        zQryDados.ParamByName('cod_fk_cliente_pessoa_fisica').AsInteger := nCodFK_ClientePessoaFisica;
        zQryDados.ParamByName('cod_fk_cliente_pessoa_juridica').AsInteger := nCodFK_ClientePessoaJuridica;
        zQryDados.ParamByName('cod_fk_imovel').AsInteger := nCodFK_Imovel;
        zQryDados.ParamByName('cod_fk_agenciamento').AsInteger := nCodFk_Agenciamento;
        zQryDados.ParamByName('tipo_venda').AsString := sTipoVenda;
        zQryDados.ParamByName('venda_meu_agenciamento_meu').AsString := sVendaMeuAgenciamentoMeu;
        zQryDados.ParamByName('venda_meu_agenciamento_colegas').AsString := sVendaMeuAgenciamentoColegas;
        zQryDados.ParamByName('venda_pauta_construtora').AsString := sVendaPautaConstrutora;
        zQryDados.ParamByName('venda_pauta_terceiros').AsString := sVendaPautaTerceiros;
        zQryDados.ParamByName('cod_fk_tp_vnd_construtora').AsInteger := nCodFK_Construtora;
        zQryDados.ParamByName('valor_venda').AsCurrency := dValorVenda;
        zQryDados.ParamByName('deducoes').AsCurrency := dDeducoes;
        zQryDados.ParamByName('valor_bem_negociavel').AsCurrency := dValorBemNegociavel;
        zQryDados.ParamByName('deduzir_bem_negoc_valor_venda').AsString := sDeduzirBemNegociavelValorVenda;
        zQryDados.ParamByName('tipo_calculo_comissao').AsString := sTipoCalculoComissao;
        zQryDados.ParamByName('valor_para_calculo_comissao').AsCurrency := dValorCalculoComissao;
        zQryDados.ParamByName('percentual_sobre_venda').AsCurrency := dPercentualSobreVenda;
        zQryDados.ParamByName('valor_total_comissao').AsCurrency := dValorTotalComissao;
        zQryDados.ParamByName('percentual_sobre_comissao').AsCurrency := dPercentualSobreComissao;
        zQryDados.ParamByName('observacao').AsString := sObservacoes;
        zQryDados.ExecSQL();
        AtualizarImovel();
        AtualizarAgenciamento();
        DM.ZConnection.Commit;
        bSalvou := True;
      except
        DM.ZConnection.Rollback;
      end;
    end;
  end;

  Result := bSalvou;
end;

function TfrmCadVenda.excluir(): Boolean;
var
  bDeletou: Boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM vendas WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoVenda.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadVenda.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

procedure TfrmCadVenda.carregarObjeto();
begin
end;

procedure TfrmCadVenda.carregarComponentesApresentacao();
begin
end;

procedure TfrmCadVenda.selecionarTodosDados();
begin
end;

procedure TfrmCadVenda.popularComboBoxImovelDe();
begin
  if(Self.FoTipoVenda = [meu_agenciamento])then
  begin
    plsCbBxImovelDe.Clear;
    plsCbBxImovelDe.Items.Add('MEU');
    plsCbBxImovelDe.Items.Add('COLEGAS');
  end
  else if(Self.FoTipoVenda = [pauta])then
  begin
    plsCbBxImovelDe.Clear;
    plsCbBxImovelDe.Items.Add('CONSTRUTORA');
    plsCbBxImovelDe.Items.Add('TERCEIROS');
  end;
  plsCbBxImovelDe.ItemIndex := -1;
end;

procedure TfrmCadVenda.AbreTelaSelecaoConstrutora(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  //caiu a ficha de um conjunto de dados
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdConstrutora.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_CONSTRUTORA_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroConstrutora,frmSelecionaRegistroConstrutora);
        frmSelecionaRegistroConstrutora.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroConstrutora.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);
        frmSelecionaRegistroConstrutora.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdConstrutora.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroConstrutora.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadVenda,frmSelecionaRegistroConstrutora,pnlConstrutora,ToolBar);
        frmSelecionaRegistroConstrutora.ShowModal;
      finally
        if(Self.FoConstrutora.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdConstrutora.Text := Self.FoConstrutora.nome;
          FoFuncoes.focarComponente(plsMedValorVenda);
        end;
        FreeAndNil(frmSelecionaRegistroConstrutora);
      end;
    end;

    fnSELECIONAR_CONSTRUTORA_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroConstrutora,frmSelecionaRegistroConstrutora);
        frmSelecionaRegistroConstrutora.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroConstrutora.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);
        frmSelecionaRegistroConstrutora.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroConstrutora.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadVenda,frmSelecionaRegistroConstrutora,pnlConstrutora,ToolBar);
        frmSelecionaRegistroConstrutora.ShowModal;
      finally
        if(Self.FoConstrutora.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdConstrutora.Text := Self.FoConstrutora.nome;
          FoFuncoes.focarComponente(plsMedValorVenda);
        end
        else
          plsEdConstrutora.Clear;
        FreeAndNil(frmSelecionaRegistroConstrutora);
      end;
    end;

  end;

end;

procedure TfrmCadVenda.VerificarConstrutoraExiste();
begin
  if(Trim(plsEdConstrutora.Text) <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosConstrutora.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdConstrutora.Text + '%'));
    FoConjuntoDadosConstrutora.ExecutarFiltrar();

    if(FoConjuntoDadosConstrutora.TotalRegistros = 1)then
    begin
      FoConstrutora.codigo := FoConjuntoDadosConstrutora.GetCodigo;
      FoConstrutora.nome := FoConjuntoDadosConstrutora.GetNome;
      plsEdConstrutora.Text := FoConstrutora.nome;
    end
    else if(FoConjuntoDadosConstrutora.TotalRegistros > 1)then
      AbreTelaSelecaoConstrutora(fnSELECIONAR_CONSTRUTORA_DIGITANDO)
    else
    begin
      MessageDlg('Construtora não encontrada.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdConstrutora);
    end;
  end
  else
  begin
    plsEdConstrutora.Clear;
    FoConstrutora.codigo := NUMERO_INDEFINIDO;
    FoConstrutora.nome := STRING_INDEFINIDO;
  end;
end;

procedure TfrmCadVenda.AbreTelaSelecaoClientePessoaFisica(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdCliente.Text;
  vParametros[2] := False;

  case pnTpSelecao of
    fnSELECIONAR_CLIENTE_PESSOA_FISICA_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroCliente, frmSelecionaRegistroCliente);
        frmSelecionaRegistroCliente.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroCliente.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);
        frmSelecionaRegistroCliente.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdCliente.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroCliente.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadVenda,frmSelecionaRegistroCliente,pnlCliente,ToolBar);
        frmSelecionaRegistroCliente.ShowModal;
        finally
          if(FoCliente.codigo <> NUMERO_INDEFINIDO)then
          begin
            plsEdCliente.Text := FoCliente.nome;
            FoFuncoes.focarComponente(plsEdImovel);
          end;
          FreeAndNil(frmSelecionaRegistroCliente);
        end;
    end;

    fnSELECIONAR_CLIENTE_PESSOA_FISICA_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroCliente, frmSelecionaRegistroCliente);
        frmSelecionaRegistroCliente.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroCliente.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);
        frmSelecionaRegistroCliente.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroCliente.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadVenda,frmSelecionaRegistroCliente,pnlCliente,ToolBar);
        frmSelecionaRegistroCliente.ShowModal;
      finally
        if(FoCliente.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdCliente.Text := FoCliente.nome;
          Self.FoFuncoes.focarComponente(plsEdImovel);
        end;
        FreeAndNil(frmSelecionaRegistroCliente);
      end;
    end;

  end; //case

end;

procedure TfrmCadVenda.VerificarClientePessoaFisicaExiste();
begin
  if(Trim(plsEdCliente.Text) <> STRING_INDEFINIDO)then
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
      MessageDlg('Pessoa Física não encontrada.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdCliente);
    end;
  end
  else
    AbreTelaSelecaoClientePessoaFisica(fnSELECIONAR_CLIENTE_PESSOA_FISICA_DIGITANDO);
end;

procedure TfrmCadVenda.AbreTelaSelecaoClientePessoaJuridica(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdCliente.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroClientePessoaJuridica, frmSelecionaRegistroClientePessoaJuridica);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdCliente.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadVenda,frmSelecionaRegistroClientePessoaJuridica,pnlCliente,ToolBar);
        frmSelecionaRegistroClientePessoaJuridica.ShowModal;
        finally
          if(FoCliente.codigo <> NUMERO_INDEFINIDO)then
          begin
            plsEdCliente.Text := FoCliente.nome;
            Self.FoFuncoes.focarComponente(plsEdImovel);
          end;
          FreeAndNil(frmSelecionaRegistroClientePessoaJuridica);
        end;
    end;

    fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroClientePessoaJuridica, frmSelecionaRegistroClientePessoaJuridica);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadVenda,frmSelecionaRegistroClientePessoaJuridica,pnlCliente,ToolBar);
        frmSelecionaRegistroClientePessoaJuridica.ShowModal;
      finally
        if(FoCliente.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdCliente.Text := FoCliente.nome;
          Self.FoFuncoes.focarComponente(plsEdImovel);
        end;
        FreeAndNil(frmSelecionaRegistroClientePessoaJuridica);
      end;
    end;

  end; //case

end;

procedure TfrmCadVenda.VerificarClientePessoaJuridicaExiste();
begin

  if(Trim(plsEdCliente.Text) <> STRING_INDEFINIDO)then
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
      MessageDlg('Pessoa Jurídica não encontrada.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdCliente);
    end;
  end
  else
    AbreTelaSelecaoClientePessoaJuridica(fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_DIGITANDO);
end;

procedure TfrmCadVenda.LimparImovel;
begin
  FoImovel.codigo := NUMERO_INDEFINIDO;
  FoImovel.nome := STRING_INDEFINIDO;
  plsEdImovel.Clear;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadVenda.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo
end;

procedure TfrmCadVenda.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadVenda.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadVenda.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadVenda.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadVenda.plsCbBxTipoVendaChange(Sender: TObject);
begin
  inherited;
  case plsCbBxTipoVenda.ItemIndex of
    0: Self.FoTipoVenda := [meu_agenciamento];
    1: Self.FoTipoVenda := [pauta];
    else
      Self.FoTipoVenda := [];
  end;
  popularComboBoxImovelDe;
  LimparImovel;
end;

procedure TfrmCadVenda.spBtnBuscaClienteClick(Sender: TObject);
begin
  inherited;

  if(FoPessoaAgenciamento = [pessoaFisica])then
    AbreTelaSelecaoClientePessoaFisica(fnSELECIONAR_CLIENTE_PESSOA_FISICA_NORMAL)
  else if(FoPessoaAgenciamento = [pessoaJuridica])then
    AbreTelaSelecaoClientePessoaJuridica(fnSELECIONAR_CLIENTE_PESSOA_JURIDICA_NORMAL)
  else if(plsEdCliente.Text <> STRING_INDEFINIDO)then
    MessageDlg('Selecione um tipo de pessoa.', mtInformation, [mbOK], 0);
end;

procedure TfrmCadVenda.spBtnBuscaImovelClick(Sender: TObject);
var
  sFiltro: String;
begin
  inherited;

  //antes de selecionar o imóvel, devem estar o Tipo de Venda e o Imóvel De selecionados
  if(Self.FoTipoVenda = [])or(Self.FoTipoImovelDe = [])then
  begin
    MessageDlg('O Tipo de Venda e o Imóvel De devem estar selecionados.',
      mtInformation, [mbOK], 0);
    if(Self.FoTipoVenda = [])then
      Self.FoFuncoes.focarComponente(plsCbBxTipoVenda)
    else
      Self.FoFuncoes.focarComponente(plsCbBxImovelDe);
  end

  //Imóvel De = meu
  //selecionar agenciamento
  else if (Self.FoTipoImovelDe = [meu])then
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroAgenciamento, frmSelecionaRegistroAgenciamento);
      frmSelecionaRegistroAgenciamento.passarParametro(PRM_INICIAR_TELA, null);
      frmSelecionaRegistroAgenciamento.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);
      frmSelecionaRegistroAgenciamento.passarParametro(PRM_DEFINE_FILTRO,'a.ativo=''SIM'' AND a.NORMAL = ''SIM''');
      FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
        frmCadVenda,frmSelecionaRegistroAgenciamento,pnlImovel,ToolBar);
      frmSelecionaRegistroAgenciamento.ShowModal;
    finally
      if(Self.FoImovel.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdImovel.Text := Self.FoImovel.nome;
        Self.FoFuncoes.focarComponente(plsMedValorVenda);
      end;
      FreeAndNil(frmSelecionaRegistroAgenciamento);
    end;
  end
  //Imóvel De = colegas, construtora ou terceiros
  else if (FoTipoImovelDe = [colegas])or(FoTipoImovelDe = [construtora])or
    (FoTipoImovelDe = [terceiros])then
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroImovel, frmSelecionaRegistroImovel);
      frmSelecionaRegistroImovel.passarParametro(PRM_INICIAR_TELA, null);
      frmSelecionaRegistroImovel.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);

      if(FoTipoImovelDe = [colegas])then
      begin
        frmSelecionaRegistroImovel.passarParametro(PRM_DEFINE_IMOVEL_DE_CADASTRO_IMOVEL, TIPO_IMOVEL_DE_VENDA_MEU_AGENCIAMENTO_COLEGAS);
        sFiltro := 'status=''1'' AND imovel_de=''COLEGAS'' AND i.codigo NOT IN (SELECT a.cod_fk_imovel FROM agenciamentos a) ';
      end
      else if(FoTipoImovelDe = [construtora])then
      begin
        frmSelecionaRegistroImovel.passarParametro(PRM_DEFINE_IMOVEL_DE_CADASTRO_IMOVEL, TIPO_IMOVEL_DE_VENDA_PAUTA_CONSTRUTORA);
        sFiltro := 'status=''1'' AND imovel_de=''CONSTRUTORA'' AND i.codigo NOT IN (SELECT a.cod_fk_imovel FROM agenciamentos a) ';
      end
      else if(FoTipoImovelDe = [terceiros])then
      begin
        frmSelecionaRegistroImovel.passarParametro(PRM_DEFINE_IMOVEL_DE_CADASTRO_IMOVEL, TIPO_IMOVEL_DE_VENDA_TERCEIROS);
        sFiltro := 'status=''1'' AND imovel_de=''TERCEIROS'' AND i.codigo NOT IN (SELECT a.cod_fk_imovel FROM agenciamentos a) ';
      end;
      frmSelecionaRegistroImovel.passarParametro(PRM_DEFINE_FILTRO, sFiltro);
      FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
        frmCadVenda,frmSelecionaRegistroImovel,pnlImovel,ToolBar);
      frmSelecionaRegistroImovel.ShowModal;
    finally
      if(Self.FoImovel.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdImovel.Text := Self.FoImovel.nome;
        if(Self.FoTipoImovelDe = [construtora])then
          Self.FoFuncoes.focarComponente(plsEdConstrutora)
        else
          Self.FoFuncoes.focarComponente(plsMedValorVenda);
      end;
      FreeAndNil(frmSelecionaRegistroImovel);
    end;
  end;
end;

procedure TfrmCadVenda.spBtnBuscaConstrutoraClick(Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoConstrutora(fnSELECIONAR_CONSTRUTORA_NORMAL);
end;

procedure TfrmCadVenda.plsCbBxImovelDeChange(Sender: TObject);
begin
  inherited;
  FoTipoImovelDe := [];
  case plsCbBxImovelDe.ItemIndex of
    0:
    begin
      case plsCbBxTipoVenda.ItemIndex of
        0: Self.FoTipoImovelDe := [meu]; //tipo venda = meu agenciamento, imóvel de = meu
        1: Self.FoTipoImovelDe := [construtora]; //tipo venda = pauta, imóvel de = construtora
      end;
    end;
    1:
    begin
      case plsCbBxTipoVenda.ItemIndex of
        0: Self.FoTipoImovelDe := [colegas]; //tipo venda = meu agenciamento, imóvel de = colegas
        1: Self.FoTipoImovelDe := [terceiros]; //tipo venda = pauta, imóvel de = terceiros
      end;
    end;
  end;

  //habilita e exige construtora
  if(plsCbBxTipoVenda.ItemIndex = 1)and(plsCbBxImovelDe.ItemIndex = 0)then
  begin
    pnlConstrutora.Visible := True;
    pnlConstrutora.Enabled := True;
  end
  else
    pnlConstrutora.Visible := False;

  LimparImovel;
end;

procedure TfrmCadVenda.plsEdImovelKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Imóvel');

  if(Key=#13)then
    spBtnBuscaImovelClick(Self);
end;

procedure TfrmCadVenda.lsCbBxDeduzirBemNegociavelChange(Sender: TObject);
begin
  inherited;
  case plsCbBxDeduzirBemNegociavel.ItemIndex of
    0: Self.FoDeduzir := [sim];
    1: Self.FoDeduzir := [nao];
  else
    Self.FoDeduzir := [];
  end;
end;

procedure TfrmCadVenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadVenda.plsEdConstrutoraExit(Sender: TObject);
begin
  inherited;
  VerificarConstrutoraExiste();
end;

procedure TfrmCadVenda.FormCreate(Sender: TObject);
begin
  inherited;
  FoVenda := TObjVenda.Create;
  FoConjuntoDadosConstrutora := TConjuntoDadosConstrutora.CriaObjeto;
  FoConjuntoDadosClientePessoaFisica := TConjuntoDadosClientePessoaFisica.CriaObjeto;
  FoConjuntoDadosClientePessoaJuridica := TConjuntoDadosClientePessoaJuridica.CriaObjeto;

  lblPercentualSobreVenda.Visible := False;
  plsMedPercentualSobreVenda.Visible := False;
  lblPercentualSobreComissao.Visible := False;
  plsMedPercentualSobreComissao.Visible := False;
end;

procedure TfrmCadVenda.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FoVenda);
  FreeAndNil(FoConjuntoDadosConstrutora);
  FreeAndNil(FoConjuntoDadosClientePessoaFisica);
  FreeAndNil(FoConjuntoDadosClientePessoaJuridica);
end;

procedure TfrmCadVenda.rdGrpTipoPessoaClick(Sender: TObject);
begin
  inherited;

  //caso já tivesse uma pessoa selecionada, limpa dados da pessoa
  if(FoCliente.codigo <> NUMERO_INDEFINIDO)then
  begin
    if(FoPessoaAgenciamento = [pessoaFisica])and(rdGrpTipoPessoa.ItemIndex = 1)then
    begin
      FoCliente.codigo := NUMERO_INDEFINIDO;
      FoCliente.nome := STRING_INDEFINIDO;
      plsEdCliente.Clear;
    end
    else if(FoPessoaAgenciamento = [pessoaJuridica])and(rdGrpTipoPessoa.ItemIndex = 0)then
    begin
      FoCliente.codigo := NUMERO_INDEFINIDO;
      FoCliente.nome := STRING_INDEFINIDO;
      plsEdCliente.Clear;
    end;
  end;

  case rdGrpTipoPessoa.ItemIndex of
    0: FoPessoaAgenciamento := [pessoaFisica];
    1: FoPessoaAgenciamento := [pessoaJuridica];
    else FoPessoaAgenciamento := [];
  end;
end;

procedure TfrmCadVenda.plsEdClienteExit(Sender: TObject);
begin
  inherited;

  if(FoPessoaAgenciamento = [pessoaFisica])then
    VerificarClientePessoaFisicaExiste()
  else if(FoPessoaAgenciamento = [pessoaJuridica])then
    VerificarClientePessoaJuridicaExiste()
  else if(plsEdCliente.Text <> STRING_INDEFINIDO)then
    MessageDlg('Selecione um tipo de pessoa.', mtInformation, [mbOK], 0);
end;

procedure TfrmCadVenda.plsCbBxTipoCalculoComissaoChange(Sender: TObject);
begin
  inherited;
  case plsCbBxTipoCalculoComissao.ItemIndex of
    0: //VENDA
    begin
      lblPercentualSobreVenda.Visible := True;
      plsMedPercentualSobreVenda.Visible := True;
      lblPercentualSobreComissao.Visible := False;
      plsMedPercentualSobreComissao.Visible := False;
    end;
    1: //COMISSÃO
    begin
      lblPercentualSobreVenda.Visible := False;
      plsMedPercentualSobreVenda.Visible := False;
      lblPercentualSobreComissao.Visible := True;
      plsMedPercentualSobreComissao.Visible := True;
    end;
    else
    begin
      lblPercentualSobreVenda.Visible := False;
      plsMedPercentualSobreVenda.Visible := False;
      lblPercentualSobreComissao.Visible := False;
      plsMedPercentualSobreComissao.Visible := False;
    end;
  end;
end;

procedure TfrmCadVenda.plsMedDataVendaEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Data da Venda',False);
end;

procedure TfrmCadVenda.plsMedDataVendaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Data da Venda',False);
end;

procedure TfrmCadVenda.plsMedDataCancelamentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Data do Cancelamento',False);
end;

procedure TfrmCadVenda.plsMedDataCancelamentoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Data do Cancelamento',False);
end;

procedure TfrmCadVenda.plsCbBxTipoVendaEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Tipo de Venda',True,2);
end;

procedure TfrmCadVenda.plsCbBxTipoVendaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Tipo de Venda',True,2);
end;

procedure TfrmCadVenda.plsCbBxImovelDeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Imóvel de',True,2);
end;

procedure TfrmCadVenda.plsCbBxImovelDeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Imóvel de',True,2);
end;

procedure TfrmCadVenda.rdGrpTipoPessoaEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Tipo de Pessoa',True,2);
end;

procedure TfrmCadVenda.plsEdClienteEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Cliente');
end;

procedure TfrmCadVenda.plsEdClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Cliente');
  if(Key=#13)then
    spBtnBuscaClienteClick(Self);
end;

procedure TfrmCadVenda.plsEdConstrutoraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Construtora',False);
  if(Key=#13)then
    spBtnBuscaConstrutoraClick(Self);  
end;

procedure TfrmCadVenda.plsEdConstrutoraEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Construtora',False);
end;

procedure TfrmCadVenda.plsEdImovelEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Imóvel');
end;

procedure TfrmCadVenda.plsEdImovelClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaImovelClick(Self);
end;

procedure TfrmCadVenda.plsMedValorVendaEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor da Venda');
end;

procedure TfrmCadVenda.plsMedValorVendaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor da Venda');
end;

procedure TfrmCadVenda.plsMedDeducoesKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Percentagem de Deduções',False);
end;

procedure TfrmCadVenda.plsMedDeducoesEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Percentagem de Deduções',False);
end;

procedure TfrmCadVenda.plsMedValorBemNegociavelEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor do Bem Negociável');
end;

procedure TfrmCadVenda.plsMedValorBemNegociavelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor do Bem Negociável');
end;

procedure TfrmCadVenda.plsCbBxDeduzirBemNegociavelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Deduzir',True,2);
end;

procedure TfrmCadVenda.plsCbBxDeduzirBemNegociavelEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Deduzir',True,2);
end;

procedure TfrmCadVenda.plsCbBxTipoCalculoComissaoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Tipo de Cálculo de Comissão',True,2);
end;

procedure TfrmCadVenda.plsCbBxTipoCalculoComissaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Tipo de Cálculo de Comissão',True,2);
end;

procedure TfrmCadVenda.plsMedPercentualSobreVendaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  case plsCbBxTipoCalculoComissao.ItemIndex of
    //VENDA
    0: MostrarHintCampos(STRING_INDEFINIDO,'Percentagem Sobre a Venda',False);
    //COMISSÃO
    1: MostrarHintCampos(STRING_INDEFINIDO,'Percentagem Sobre a Comissão',False);
  end;
end;

procedure TfrmCadVenda.plsMedPercentualSobreVendaEnter(Sender: TObject);
begin
  inherited;
  case plsCbBxTipoCalculoComissao.ItemIndex of
    //VENDA
    0: MostrarHintCampos(STRING_INDEFINIDO,'Percentagem Sobre a Venda',False);
    //COMISSÃO
    1: MostrarHintCampos(STRING_INDEFINIDO,'Percentagem Sobre a Comissão',False);
  end;
end;

procedure TfrmCadVenda.plsMedValorCalculoComissaoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor de Cálculo de Comissão');
end;

procedure TfrmCadVenda.plsMedValorCalculoComissaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor de Cálculo de Comissão');
end;

procedure TfrmCadVenda.plsMedValorTotalComissaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor Total de Comissão');
end;

procedure TfrmCadVenda.plsMedValorTotalComissaoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Valor Total de Comissão');
end;

procedure TfrmCadVenda.plsMmObservacaoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Observação',False);
end;

procedure TfrmCadVenda.plsMmObservacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Observação',False);
end;

procedure TfrmCadVenda.lblDicasClick(Sender: TObject);
begin
  inherited;
  FoFuncoes.CriarTelaDicas(FORM_CAD_VENDAS);
end;

end.
