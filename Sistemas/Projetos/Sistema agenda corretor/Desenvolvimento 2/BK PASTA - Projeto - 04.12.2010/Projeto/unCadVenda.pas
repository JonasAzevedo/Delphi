unit unCadVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ComCtrls, ToolWin, Mask, plsTMaskEdit, ExtCtrls, plsComboBox, Buttons,
  plsMemo, unObjVenda, unVariaveis;

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
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosDATA_VENDA: TDateField;
    zQryDadosATIVO: TStringField;
    zQryDadosCOD_FK_CLIENTE: TIntegerField;
    zQryDadosCOD_FK_IMOVEL: TIntegerField;
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
    zQryDadosVALOR_PARA_CALCULO_COMISSAO: TFloatField;
    zQryDadosPERCENTUAL_SOBRE_VENDA: TFloatField;
    zQryDadosVALOR_TOTAL_COMISSAO: TFloatField;
    zQryDadosPERCENTUAL_SOBRE_COMISSAO: TFloatField;
    zQryDadosOBSERVACAO: TStringField;
    zQryDadosDATA_CANCELAMENTO: TDateTimeField;
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure plsCbBxTipoVendaChange(Sender: TObject);
    procedure spBtnBuscaClienteClick(Sender: TObject);
    procedure plsEdClienteKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdClienteClick(Sender: TObject);
    procedure spBtnBuscaImovelClick(Sender: TObject);
    procedure spBtnBuscaConstrutoraClick(Sender: TObject);
    procedure plsEdConstrutoraKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdConstrutoraClick(Sender: TObject);
    procedure plsCbBxImovelDeChange(Sender: TObject);
    procedure plsEdImovelClick(Sender: TObject);
    procedure plsEdImovelKeyPress(Sender: TObject; var Key: Char);
    procedure plsCbBxDeduzirBemNegociavelChange(Sender: TObject);
  private
    FoVenda: TObjVenda;
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
  public
    FoCliente: TCliente;
    FoImovel: TImovel;
    FoConstrutora: TConstrutora;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadVenda: TfrmCadVenda;

implementation

uses unConstantes, unDM, unSelecionaRegistroCliente,
  unSelecionaRegistroImovel, unSelecionaRegistroConstrutora, unFuncoes,
  unSelecionaRegistroAgenciamento;

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

  Self.FoCliente.codigo := NUMERO_INDEFINIDO;
  Self.FoCliente.nome := STRING_INDEFINIDO;

  Self.FoImovel.codigo := NUMERO_INDEFINIDO;
  Self.FoImovel.nome := STRING_INDEFINIDO;

  Self.FoConstrutora.codigo := NUMERO_INDEFINIDO;
  Self.FoConstrutora.nome := STRING_INDEFINIDO;

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
                       pnlConstrutora.Enabled := False;
                       pnlValores.Enabled := False;
                       plsMmObservacao.Enabled := False;
                       Self.FoFuncoes.focarComponente(plsEdCodigo);
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Enabled := False;
                       plsMedDataVenda.Enabled := True;
                       pnlDataCancelamento.Visible := False;
                       pnlCliente.Enabled := True;
                       pnlImovel.Enabled := True;
                       pnlTipoVenda.Enabled := True;
                       pnlConstrutora.Visible := False;
                       pnlValores.Enabled := True;
                       plsMmObservacao.Enabled := True;
                       Self.FoFuncoes.focarComponente(plsMedDataVenda);
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       plsMedDataVenda.Enabled := True;
                       pnlDataCancelamento.Visible := False;
                       pnlCliente.Enabled := True;
                       pnlImovel.Enabled := True;
                       pnlTipoVenda.Enabled := True;
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
  nCodFK_Cliente,nCodFK_Imovel: Integer;
  sTipoVenda: String;
  sVendaMeuAgenciamentoMeu,sVendaMeuAgenciamentoColegas: String;
  sVendaPautaConstrutora,sVendaPautaTerceiros: String;
  nCodFK_Construtora: Integer;
  dValorVenda,dDeducoes,dValorBemNegociavel: Currency;
  sDeduzirBemNegociavelValorVenda: String;
  dPercentualSobreVenda,dPercentualSobreComissao: Currency;
  dValorCalculoComissao,dValorTotalComissao: Currency;
  sObservacoes: String;

  procedure carregarValores();
  begin
    sAtivo := VLR_SIM;
    dtDataVenda := Self.FoFuncoes.formatarData(plsMedDataVenda.Text);
    nCodFK_Cliente := Self.FoCliente.codigo;
    nCodFK_Imovel := Self.FoImovel.codigo;

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
    dValorCalculoComissao := Self.FoFuncoes.formatarValorCurrency(plsMedValorCalculoComissao.Text);
    dValorTotalComissao := Self.FoFuncoes.formatarValorCurrency(plsMedValorTotalComissao.Text);
    sObservacoes := plsMmObservacao.Text;
  end;

begin
  carregarValores();
  bSalvou := False;

  if(Self.FiFuncaoRegistro in [FUNCAO_REGISTRO_EDITAR, FUNCAO_REGISTRO_NOVO]) then
  begin
    inherited;
    if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR) then
    begin
      try
(*        DM.ZConnection.StartTransaction;
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('UPDATE cliente SET cod_fk_profissao=:cod_fk_pro, ');
        zQryDados.SQL.Add('cod_fk_estado=:cod_fk_est,cod_fk_cidade=:cod_fk_cid, ');
        zQryDados.SQL.Add('cod_fk_bairro=:cod_fk_bai,cod_fk_rua=:cod_fk_rua, ');
        zQryDados.SQL.Add('endereco_cep=:end_cep,endereco_complemento=:end_com, ');
        zQryDados.SQL.Add('nome=:nom,email=:ema,telefone_residencial=:tel_res, ');
        zQryDados.SQL.Add('telefone_comercial=:tel_com,telefone_celular=:tel_cel, ');
        zQryDados.SQL.Add('cpf=:cpf,identidade=:ide,data_nascimento=:dat_nas ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('cod_fk_pro').AsInteger := Self.FoProfissao.codigo;
        zQryDados.ParamByName('cod_fk_est').AsInteger := Self.FoEstado.codigo;
        zQryDados.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.codigo;
        zQryDados.ParamByName('cod_fk_bai').AsInteger := Self.FoBairro.codigo;
        zQryDados.ParamByName('cod_fk_rua').AsInteger := Self.FoRua.codigo;
        zQryDados.ParamByName('end_cep').AsString := plsMedCEP.Text;
        zQryDados.ParamByName('end_com').AsString := plsMmComplemento.Text;
        zQryDados.ParamByName('nom').AsString := plsEdNome.Text;
        zQryDados.ParamByName('ema').AsString := plsEdEmail.Text;
        zQryDados.ParamByName('tel_res').AsString := plsMedTelefoneResidencial.Text;
        zQryDados.ParamByName('tel_com').AsString := plsMedTelefoneComercial.Text;
        zQryDados.ParamByName('tel_cel').AsString := plsMedTelefoneCelular.Text;
        zQryDados.ParamByName('cpf').AsString := plsMedCPF.Text;
        zQryDados.ParamByName('ide').AsString := plsEdIdentidade.Text;
        zQryDados.ParamByName('dat_nas').AsString := plsMedDataNascimento.Text;
        zQryDados.ParamByName('cod').AsInteger := Self.Fcliente.getCodigo();
        zQryDados.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
*)      except
        DM.ZConnection.Rollback;
      end;

    end
    else if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_NOVO) then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('INSERT INTO vendas(data_venda,ativo,cod_fk_cliente,');
        zQryDados.SQL.Add('cod_fk_imovel,tipo_venda,venda_meu_agenciamento_meu,');
        zQryDados.SQL.Add('venda_meu_agenciamento_colegas,venda_pauta_construtora,');
        zQryDados.SQL.Add('venda_pauta_terceiros,cod_fk_tp_vnd_construtora,valor_venda,');
        zQryDados.SQL.Add('deducoes,valor_bem_negociavel,deduzir_bem_negoc_valor_venda,');
        zQryDados.SQL.Add('valor_para_calculo_comissao,percentual_sobre_venda,');
        zQryDados.SQL.Add('valor_total_comissao,percentual_sobre_comissao,');
        zQryDados.SQL.Add('observacao)');

        zQryDados.SQL.Add('VALUES(:data_venda,:ativo,:cod_fk_cliente,');
        zQryDados.SQL.Add(':cod_fk_imovel,:tipo_venda,:venda_meu_agenciamento_meu,');
        zQryDados.SQL.Add(':venda_meu_agenciamento_colegas,:venda_pauta_construtora,');
        zQryDados.SQL.Add(':venda_pauta_terceiros,:cod_fk_tp_vnd_construtora,:valor_venda,');
        zQryDados.SQL.Add(':deducoes,:valor_bem_negociavel,:deduzir_bem_negoc_valor_venda,');
        zQryDados.SQL.Add(':valor_para_calculo_comissao,:percentual_sobre_venda,');
        zQryDados.SQL.Add(':valor_total_comissao,:percentual_sobre_comissao,');
        zQryDados.SQL.Add(':observacao)');

        zQryDados.ParamByName('data_venda').AsDate := dtDataVenda;
        zQryDados.ParamByName('ativo').AsString := sAtivo;
        zQryDados.ParamByName('cod_fk_cliente').AsInteger := nCodFK_Cliente;
        zQryDados.ParamByName('cod_fk_imovel').AsInteger := nCodFK_Imovel;
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
        zQryDados.ParamByName('valor_para_calculo_comissao').AsCurrency := dValorCalculoComissao;
        zQryDados.ParamByName('percentual_sobre_venda').AsCurrency := dPercentualSobreVenda;
        zQryDados.ParamByName('valor_total_comissao').AsCurrency := dValorTotalComissao;
        zQryDados.ParamByName('percentual_sobre_comissao').AsCurrency := dPercentualSobreComissao;
        zQryDados.ParamByName('observacao').AsString := sObservacoes;
        zQryDados.ExecSQL();
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
(*  if ((cdsDados.Active) and (Assigned(Self.FoAgenciamento))) then
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
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadCidade.carregarObjeto();','Acesso Indisponível');
  end;
*)
end;

procedure TfrmCadVenda.carregarComponentesApresentacao();
begin
(*  if(Assigned(Self.FoAgenciamento))then
  begin
    if(Self.FoAgenciamento.getCodigo <> NUMERO_INDEFINIDO)then
      plsEdCodigo.Text := IntToStr(Self.FoAgenciamento.getCodigo)
    else
      plsEdCodigo.Clear;

    try
      plsMedDataAgenciamento.Text := DateToStr(Self.FoAgenciamento.getDataAgenciamento);
    except
      plsMedDataAgenciamento.Clear;
    end;

    try
      plsMedDataBaixa.Text := DateToStr(Self.FoAgenciamento.getData_Baixa);
    except
      plsMedDataBaixa.Clear;
    end;

    if(Self.FoAgenciamento.getNormal = VLR_SIM)and(Self.FoAgenciamento.getStandBy = VLR_NAO)then
    begin
      rdGrpTipoAgenciamento.ItemIndex := 0;
      Self.FoTipoAgenciamento := [normal];
    end
    else if(Self.FoAgenciamento.getNormal = VLR_NAO)and(Self.FoAgenciamento.getStandBy = VLR_SIM)then
    begin
      rdGrpTipoAgenciamento.ItemIndex := 1;
      Self.FoTipoAgenciamento := [standBy];
    end
    else
    begin
      rdGrpTipoAgenciamento.ItemIndex := -1;
      Self.FoTipoAgenciamento := [];
    end;

    if(Self.FoAgenciamento.getTipoPessoa = VLR_TP_PESSOA_FISICA)then
    begin
      rdGrpTipoPessoa.ItemIndex := 0;
      plsEdPessoa.Text := Self.FoAgenciamento.getExibePessoaFisica;
      Self.FoPessoaAgenciamento := [pessoaFisica];
    end
    else if(Self.FoAgenciamento.getTipoPessoa = VLR_TP_PESSOA_JURIDICA)then
    begin
      rdGrpTipoPessoa.ItemIndex := 1;
      plsEdPessoa.Text := Self.FoAgenciamento.getExibePessoaJuridica;
      Self.FoPessoaAgenciamento := [pessoaJuridica];
    end
    else
    begin
      rdGrpTipoPessoa.ItemIndex := -1;
      plsEdPessoa.Clear;
      Self.FoPessoaAgenciamento := [];
    end;

    plsEdImovel.Text := Self.FoAgenciamento.getExibeImovel;

    //vista
    plsEdVistaCach.Text := FloatToStr(Self.FoAgenciamento.getPgto_Vista_Cach);
    plsEdVistaCach.Text := FoFuncoes.formatarValorMonetario(plsEdVistaCach.Text);
    plsEdVistaBemValor.Text := FloatToStr(Self.FoAgenciamento.getPgto_Vista_Valor_Bem);
    plsEdVistaBemValor.Text := FoFuncoes.formatarValorMonetario(plsEdVistaBemValor.Text);
    plsMmVistaBemDescricao.Text := Self.FoAgenciamento.getPgto_Vista_Descricao_Bem;
    //financiamento
    plsEdFinanciamentoCach.Text := FloatToStr(Self.FoAgenciamento.getPgto_Fincto_Cach);
    plsEdFinanciamentoCach.Text := FoFuncoes.formatarValorMonetario(plsEdFinanciamentoCach.Text);
    plsEdFinanciamentoValorFinanciado.Text := FloatToStr(Self.FoAgenciamento.getPgto_Fincto_Cach_Financiado);
    plsEdFinanciamentoValorFinanciado.Text := FoFuncoes.formatarValorMonetario(plsEdFinanciamentoValorFinanciado.Text);
    plsEdFinanciamentoBemValor.Text := FloatToStr(Self.FoAgenciamento.getPgto_Fincto_Valor_Bem);
    plsEdFinanciamentoBemValor.Text := FoFuncoes.formatarValorMonetario(plsEdFinanciamentoBemValor.Text);
    plsMmFinanciamentoBemDescricao.Text := Self.FoAgenciamento.getPgto_Fincto_Descricao_Bem;

    if(Self.FoAgenciamento.getCondicaoPagamento = VLR_CD_PAGAMENTO_VISTA)then
    begin
      plsCbBxCondicaoPagamento.ItemIndex := 0;
      grpBxCondicaoPagamentoVista.Visible := True;
      grpBxCondicaoPagamentoFinanciamento.Visible := False;
      Self.FoCondicaoPagamento := [vista];
    end
    else if(Self.FoAgenciamento.getCondicaoPagamento = VLR_CD_PAGAMENTO_ACEITA_FINANCIAMENTO)then
    begin
      plsCbBxCondicaoPagamento.ItemIndex := 1;
      grpBxCondicaoPagamentoVista.Visible := False;
      grpBxCondicaoPagamentoFinanciamento.Visible := True;
      Self.FoCondicaoPagamento := [aceitaFinanciamento];
    end
    else
    begin
      plsCbBxCondicaoPagamento.ItemIndex := -1;
      grpBxCondicaoPagamentoVista.Visible := False;
      grpBxCondicaoPagamentoFinanciamento.Visible := False;
      Self.FoCondicaoPagamento := [];
    end;

    plsEdValorTotal.Text := FloatToStr(Self.FoAgenciamento.getValorTotal);
    plsEdValorTotal.Text := FoFuncoes.formatarValorMonetario(plsEdValorTotal.Text);

    plsMmObservacao.Text := Self.FoAgenciamento.getObservacao;
    plsMedPrazoAutorizacao.Text := DateToStr(Self.FoAgenciamento.getPrazo_Autorizacao);
    plsMedReagenciamento.Text := DateToStr(Self.FoAgenciamento.getData_Reagenciamento);
  end;
*)end;

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
    plsCbBxImovelDe.Items.Add('CONTRUTORA');
    plsCbBxImovelDe.Items.Add('TERCEIROS');
  end;
  plsCbBxImovelDe.ItemIndex := -1;
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
  popularComboBoxImovelDe();
end;

procedure TfrmCadVenda.spBtnBuscaClienteClick(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmSelecionaRegistroCliente, frmSelecionaRegistroCliente);
    frmSelecionaRegistroCliente.passarParametro(PRM_INICIAR_TELA, null);
    frmSelecionaRegistroCliente.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);
    frmSelecionaRegistroCliente.ShowModal;
  finally
    if(Self.FoCliente.codigo <> NUMERO_INDEFINIDO)then
    begin
      plsEdCliente.Text := Self.FoCliente.nome;
      Self.FoFuncoes.focarComponente(plsEdImovel);
    end;
    FreeAndNil(frmSelecionaRegistroCliente);
  end;
end;

procedure TfrmCadVenda.plsEdClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaClienteClick(Self);
end;

procedure TfrmCadVenda.plsEdClienteClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaClienteClick(Self);
end;

procedure TfrmCadVenda.spBtnBuscaImovelClick(Sender: TObject);
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
  else if (Self.FoTipoImovelDe = [colegas])or(Self.FoTipoImovelDe = [construtora])or
    (Self.FoTipoImovelDe = [terceiros])then
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroImovel, frmSelecionaRegistroImovel);
      frmSelecionaRegistroImovel.passarParametro(PRM_INICIAR_TELA, null);
      frmSelecionaRegistroImovel.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);
      frmSelecionaRegistroImovel.passarParametro(PRM_DEFINE_FILTRO,'status=''1''');

      frmSelecionaRegistroImovel.ShowModal;
    finally
      if(Self.FoImovel.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdImovel.Text := Self.FoImovel.nome;
        Self.FoFuncoes.focarComponente(plsCbBxTipoVenda);
      end;
      FreeAndNil(frmSelecionaRegistroImovel);
    end;
  end;
end;

procedure TfrmCadVenda.spBtnBuscaConstrutoraClick(Sender: TObject);
begin
  inherited;
    try
      Application.CreateForm(TfrmSelecionaRegistroConstrutora,frmSelecionaRegistroConstrutora);
      frmSelecionaRegistroConstrutora.passarParametro(PRM_INICIAR_TELA, null);
      frmSelecionaRegistroConstrutora.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_VENDAS);
      frmSelecionaRegistroConstrutora.ShowModal;
    finally
      if(Self.FoConstrutora.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdConstrutora.Text := Self.FoConstrutora.nome;
        Self.FoFuncoes.focarComponente(plsMedValorVenda);
      end;
      FreeAndNil(frmSelecionaRegistroConstrutora);
    end;
end;

procedure TfrmCadVenda.plsEdConstrutoraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaConstrutoraClick(Self);
end;

procedure TfrmCadVenda.plsEdConstrutoraClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaConstrutoraClick(Self);
end;

procedure TfrmCadVenda.plsCbBxImovelDeChange(Sender: TObject);
begin
  inherited;             
  Self.FoTipoImovelDe := [];
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
end;

procedure TfrmCadVenda.plsEdImovelClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaImovelClick(Self);
end;

procedure TfrmCadVenda.plsEdImovelKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaImovelClick(Self);
end;

procedure TfrmCadVenda.plsCbBxDeduzirBemNegociavelChange(Sender: TObject);
begin
  inherited;

  case plsCbBxDeduzirBemNegociavel.ItemIndex of
    0: Self.FoDeduzir := [sim];
    1: Self.FoDeduzir := [nao];
  else
    Self.FoDeduzir := [];
  end;
end;

end.
