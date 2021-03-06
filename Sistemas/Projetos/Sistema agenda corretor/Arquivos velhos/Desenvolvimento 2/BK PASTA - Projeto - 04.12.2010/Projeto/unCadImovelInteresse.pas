unit unCadImovelInteresse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ComCtrls, ToolWin, plsMemo, Buttons, plsComboBox, ExtCtrls, Mask,
  plsTMaskEdit, unObjImovelInteresse, unVariaveis;

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
  TfrmCadImovelInteresse = class(TfrmCadastroBasico)
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosATIVO: TStringField;
    zQryDadosDATA_CAPTACAO: TDateField;
    zQryDadosCOD_FK_CLIENTE: TIntegerField;
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
    zQryDadosRENDIMENTO: TFloatField;
    zQryDadosOBSERVACAO: TStringField;
    zQryDadosDATA_BAIXA: TDateTimeField;
    zQryDadosCARACTERISTICAS: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosATIVO: TStringField;
    cdsDadosDATA_CAPTACAO: TDateField;
    cdsDadosCOD_FK_CLIENTE: TIntegerField;
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
    cdsDadosRENDIMENTO: TFloatField;
    cdsDadosOBSERVACAO: TStringField;
    cdsDadosDATA_BAIXA: TDateTimeField;
    cdsDadosCARACTERISTICAS: TStringField;
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    lblDataCaptacao: TLabel;
    lblCampoObrigatorio1: TLabel;
    plsMedDataCaptacao: TPlsMaskEdit;
    pnlDataBaixa: TPanel;
    lblDataBaixa: TLabel;
    plsMedDataBaixa: TPlsMaskEdit;
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
    lblRendimento: TLabel;
    plsEdRendimento: TPlsEdit;
    plsMmCaracteristicas: TPlsMemo;
    lblCaracteristicas: TLabel;
    lblCondicaoPagamento: TLabel;
    plsCbBxCondicaoPagamento: TPlsComboBox;
    lblCampoObrigatorio6: TLabel;
    lblValorImovel: TLabel;
    plsEdValorImovel: TPlsEdit;
    lblCampoObrigatorio7: TLabel;
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
    procedure plsEdTipoImovelClick(Sender: TObject);
    procedure plsEdTipoImovelKeyPress(Sender: TObject; var Key: Char);
    procedure plsCbBxFinalidadeChange(Sender: TObject);
    procedure plsCbBxSituacaoChange(Sender: TObject);
    procedure spBtnBuscaClienteClick(Sender: TObject);
    procedure plsEdClienteClick(Sender: TObject);
    procedure plsEdClienteKeyPress(Sender: TObject; var Key: Char);
  private
    FoImovelInteresse: TObjImovelInteresse;
    FoCondicaoPagamento: TCondicoesPagamento;
    FoFinalidadeImovel: TFinalidadesImovel;
    FoSituacaoImovel: TSituacoesImovel;

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
  public
    FoCliente: TCliente;
    FoTipoImovel: TTipoImovel;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;


var
  frmCadImovelInteresse: TfrmCadImovelInteresse;

implementation

uses unConstantes, unDM, unSelecionaRegistroImovel, unSelecionaRegistroTipoImovel,
  unSelecionaRegistroCliente;

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
  Self.FoCliente.codigo := NUMERO_INDEFINIDO;
  Self.FoCliente.nome := STRING_INDEFINIDO;

  Self.FoTipoImovel.codigo := NUMERO_INDEFINIDO;
  Self.FoTipoImovel.nome := STRING_INDEFINIDO;

  Self.FoCondicaoPagamento := [];
  Self.FoFinalidadeImovel := [];
  Self.FoSituacaoImovel := [];
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
    campos := 'Data de Capta��o';
    compFoco := plsMedDataCaptacao;
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
      campos := campos + ', Tipo do Im�vel'
    else
    begin
      campos := 'Tipo do Im�vel';
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
      campos := campos + ', Situa��o'
    else
    begin
      campos := 'Situa��o';
    end;
    if(compFoco = nil)then
      compFoco := plsCbBxSituacao;
  end;

  if(Self.FoCondicaoPagamento = [])then
  begin
    if(campos <> '')then
      campos := campos + ', Condi��o de Pagamento'
    else
    begin
      campos := 'Condi��o de Pagamento';
    end;
    if(compFoco = nil)then
      compFoco := plsCbBxCondicaoPagamento;
  end;

  try
    dValorImovel := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdValorImovel.Text, '.'));
  except
    if(campos <> '')then
      campos := campos + ', Valor do Im�vel'
    else
    begin
      campos := 'Valor do Im�vel';
    end;
    if(compFoco = nil)then
      compFoco := plsEdValorImovel;
  end;

  if(campos <> '')then
  begin
    MessageDlg('Antes de salvar, verifique os campos: ' + campos + '.', mtInformation, [mbOK], 0);
    bRetorno := False;
  end;

  //setar foco no componente que n�o foi validado
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
                       plsEdRendimento.Enabled := False;
                       plsMmObservacao.Enabled := False;
                       plsMmCaracteristicas.Enabled := False;
                       Self.FoFuncoes.focarComponente(plsEdCodigo);
                     end;
    OPC_NOVO:        begin
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
                       plsEdRendimento.Enabled := True;
                       plsMmObservacao.Enabled := True;
                       plsMmCaracteristicas.Enabled := True;
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
                       plsEdRendimento.Enabled := True;
                       plsMmObservacao.Enabled := True;
                       plsMmCaracteristicas.Enabled := True;
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
                       plsEdRendimento.Enabled := False;
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
      MessageDlg('O total do valor � vista n�o pode ser superior que o valor total.',mtWarning,[mbOK],0);
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
      MessageDlg('O total do valor do financiamento n�o pode ser superior que o valor total.',mtWarning,[mbOK],0);
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
      MessageDlg('Insira a descri��o do bem.',mtWarning,[mbOK],0);
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
      MessageDlg('Insira a descri��o do bem.',mtWarning,[mbOK],0);
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
      MessageDlg('O valor total � diferente da soma do valor � vista informado.',mtWarning,[mbOK],0);
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
      MessageDlg('O valor total � diferente da soma do valor do financiamento informado.',mtWarning,[mbOK],0);
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

  //setar foco no componente que n�o foi validado
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

  sAtivo: String;
  dtDataCaptacao: TDate;
  nCodFk_Cliente, nCodFk_TipoImovel: Integer;
  sFinalidadeImovel, sImovelDesejavel: String;
  dValorImovel: Currency;
  sCondicaoPagamento: String;
  dPgtoVistaCach,dPgtoVistaValorBem: Currency;
  sPgtoVistaDescricaoBem: String;
  dPgtoFinctoCach,dPgtoFinctoCachFinanciado,dPgtoFinctoValorBem: Currency;
  sPgtoFinctoDescricaoBem: String;
  dRendimento: Currency;
  sObservacao: String;
  sCaracteristicas: String;

  procedure carregarValores();
  begin
    sAtivo := VLR_SIM;
    dtDataCaptacao := StrToDate(plsMedDataCaptacao.Text);
    nCodFk_Cliente := Self.FoCliente.codigo;
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

    try
      dRendimento := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdRendimento.Text, '.'));
    except
      dRendimento := NUMERO_INDEFINIDO;
    end;

    sObservacao := Trim(plsMmObservacao.Text);
    sCaracteristicas := Trim(plsMmCaracteristicas.Text);
  end;

  //limpa par�metro nulos - para o insert e update
  procedure limparParametrosNulos();
  begin
    if(dtDataCaptacao = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('data_captacao').Clear;
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
      zQryDados.SQL.Add('cod_fk_cliente,cod_fk_Tipo_Imovel,finalidade_imovel,');
      zQryDados.SQL.Add('imovel_desejavel,valor_imovel,condicao_pagamento,');
      zQryDados.SQL.Add('pgto_vista_cach,pgto_vista_valor_bem,');
      zQryDados.SQL.Add('pgto_vista_descricao_bem,pgto_fincto_cach_financiado,');
      zQryDados.SQL.Add('pgto_fincto_valor_bem,pgto_fincto_descricao_bem,');
      zQryDados.SQL.Add('rendimento,observacao,caracteristicas) ');

      zQryDados.SQL.Add('VALUES(:ativo,:data_captacao,:cod_fk_cliente,');
      zQryDados.SQL.Add(':cod_fk_Tipo_Imovel,:finalidade_imovel,:imovel_desejavel,');
      zQryDados.SQL.Add(':valor_imovel,:condicao_pagamento,:pgto_vista_cach,');
      zQryDados.SQL.Add(':pgto_vista_valor_bem,:pgto_vista_descricao_bem,');
      zQryDados.SQL.Add(':pgto_fincto_cach_financiado,:pgto_fincto_valor_bem,');
      zQryDados.SQL.Add(':pgto_fincto_descricao_bem,:rendimento,:observacao,');
      zQryDados.SQL.Add(':caracteristicas)');

      zQryDados.ParamByName('ativo').AsString := sAtivo;
      zQryDados.ParamByName('data_captacao').AsDate := dtDataCaptacao;
      zQryDados.ParamByName('cod_fk_cliente').AsInteger := nCodFk_Cliente;
      zQryDados.ParamByName('cod_fk_Tipo_Imovel').AsInteger := nCodFk_TipoImovel;
      zQryDados.ParamByName('finalidade_imovel').AsString := sFinalidadeImovel;
      zQryDados.ParamByName('imovel_desejavel').AsString := sImovelDesejavel;
      zQryDados.ParamByName('valor_imovel').AsCurrency := dValorImovel;
      zQryDados.ParamByName('condicao_pagamento').AsString := sCondicaoPagamento;
      zQryDados.ParamByName('pgto_vista_cach').AsCurrency := dPgtoVistaCach;
      zQryDados.ParamByName('pgto_vista_valor_bem').AsCurrency := dPgtoVistaValorBem;
      zQryDados.ParamByName('pgto_vista_descricao_bem').AsString := sPgtoVistaDescricaoBem;
      zQryDados.ParamByName('pgto_fincto_cach_financiado').AsCurrency := dPgtoFinctoCachFinanciado;
      zQryDados.ParamByName('pgto_fincto_valor_bem').AsCurrency := dPgtoFinctoValorBem;
      zQryDados.ParamByName('pgto_fincto_descricao_bem').AsString := sPgtoFinctoDescricaoBem;
      zQryDados.ParamByName('rendimento').AsCurrency := dRendimento;
      zQryDados.ParamByName('observacao').AsString := sObservacao;
      zQryDados.ParamByName('caracteristicas').AsString := sCaracteristicas;
      limparParametrosNulos();
      zQryDados.ExecSQL();
      DM.ZConnection.Commit;
      bSalvou := True;
    except
      DM.ZConnection.Rollback;
    end;
  end;

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
end;

procedure TfrmCadImovelInteresse.selecionarTodosDados();
begin
end;

(* fim - procedimentos de controle *)


procedure TfrmCadImovelInteresse.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoImovelInteresse := TObjImovelInteresse.Create;
end;

procedure TfrmCadImovelInteresse.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoImovelInteresse);
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
end;

procedure TfrmCadImovelInteresse.spBtnBuscaTipoImovelClick(
  Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmSelecionaRegistroTipoImovel, frmSelecionaRegistroTipoImovel);
    frmSelecionaRegistroTipoImovel.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL_INTERESSE);
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

procedure TfrmCadImovelInteresse.plsEdTipoImovelClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaTipoImovelClick(Self);
end;

procedure TfrmCadImovelInteresse.plsEdTipoImovelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaTipoImovelClick(Self);
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
  try
    Application.CreateForm(TfrmSelecionaRegistroCliente, frmSelecionaRegistroCliente);
    frmSelecionaRegistroCliente.passarParametro(PRM_INICIAR_TELA, null);
    frmSelecionaRegistroCliente.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL_INTERESSE);
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

procedure TfrmCadImovelInteresse.plsEdClienteClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaClienteClick(Self);
end;

procedure TfrmCadImovelInteresse.plsEdClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaClienteClick(Self);
end;

end.
