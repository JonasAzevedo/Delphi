unit unCadImoveis;

{
  c�digos do campo status:
    1: im�vel cadastrado - aberto
    2: vendido
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, ComCtrls, ToolWin,
  StdCtrls, plsMemo, plsComboBox, Buttons, Mask, plsTMaskEdit, plsEdit, unObjImovel,
  ExtCtrls;

  type
    TTipoImovel = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TEstado = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TCidade = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TBairro = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TRua = record
      codigo: Integer;
      nome: string[100];
      cep: string[9];
    end;

type
  TfrmCadImoveis = class(TfrmCadastroBasico)
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    lblDataCadastro: TLabel;
    plsMedDataCadastro: TPlsMaskEdit;
    lblTituloStatus: TLabel;
    lblStatus: TLabel;
    lblDescricao: TLabel;
    plsMmDescricao: TPlsMemo;
    grpBxEndereco: TGroupBox;
    lblEstado: TLabel;
    spBtnBuscaEstado: TSpeedButton;
    spBtnBuscaCidade: TSpeedButton;
    lblCidade: TLabel;
    lblBairro: TLabel;
    lblRua: TLabel;
    lblCEP: TLabel;
    spBtnBuscaBairro: TSpeedButton;
    spBtnBuscaRua: TSpeedButton;
    lblComplemento: TLabel;
    plsEdEstado: TPlsEdit;
    plsEdCidade: TPlsEdit;
    plsMedEnderecoCEP: TPlsMaskEdit;
    plsEdRua: TPlsEdit;
    plsEdBairro: TPlsEdit;
    plsMmEnderecoComplemento: TPlsMemo;
    pnlTipoImovel: TPanel;
    lblTipoImovel: TLabel;
    plsEdTipoImovel: TPlsEdit;
    spBtnBuscaTipoImovel: TSpeedButton;
    pnlSituacaoValor: TPanel;
    plsEdValor: TPlsEdit;
    lblSituacao: TLabel;
    plsCbBxSituacao: TPlsComboBox;
    lblCampoObrigatorio1: TLabel;
    lblCampoObrigatorio2: TLabel;
    lblCampoObrigatorio3: TLabel;
    Label1: TLabel;
    lblValor: TLabel;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosSTATUS: TSmallintField;
    zQryDadosCOD_FK_TIPO_IMOVEL: TIntegerField;
    zQryDadosCOD_FK_ESTADO: TIntegerField;
    zQryDadosCOD_FK_CIDADE: TIntegerField;
    zQryDadosCOD_FK_BAIRRO: TIntegerField;
    zQryDadosCOD_FK_RUA: TIntegerField;
    zQryDadosENDERECO_CEP: TStringField;
    zQryDadosENDERECO_COMPLEMENTO: TStringField;
    zQryDadosSITUACAO_DESEJAVEL: TStringField;
    zQryDadosVALOR_IMOVEL: TFloatField;
    zQryDadosDESCRICAO: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosSTATUS: TSmallintField;
    cdsDadosCOD_FK_TIPO_IMOVEL: TIntegerField;
    cdsDadosCOD_FK_ESTADO: TIntegerField;
    cdsDadosCOD_FK_CIDADE: TIntegerField;
    cdsDadosCOD_FK_BAIRRO: TIntegerField;
    cdsDadosCOD_FK_RUA: TIntegerField;
    cdsDadosENDERECO_CEP: TStringField;
    cdsDadosENDERECO_COMPLEMENTO: TStringField;
    cdsDadosSITUACAO_DESEJAVEL: TStringField;
    cdsDadosVALOR_IMOVEL: TFloatField;
    cdsDadosDESCRICAO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure plsEdCodigoExit(Sender: TObject);
    procedure spBtnBuscaTipoImovelClick(Sender: TObject);
    procedure spBtnBuscaEstadoClick(Sender: TObject);
    procedure spBtnBuscaCidadeClick(Sender: TObject);
    procedure spBtnBuscaBairroClick(Sender: TObject);
    procedure spBtnBuscaRuaClick(Sender: TObject);
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdTipoImovelClick(Sender: TObject);
    procedure plsEdEstadoClick(Sender: TObject);
    procedure plsEdCidadeClick(Sender: TObject);
    procedure plsEdBairroClick(Sender: TObject);
    procedure plsEdRuaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure plsEdTipoImovelKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdEstadoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdBairroKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdRuaKeyPress(Sender: TObject; var Key: Char);
  private
    FoImovel: TObjImovel;
    FnCodigoEditar: Integer;

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
    procedure novo(); override;
    function salvar(): Boolean; override;
    function excluir(): Boolean; override;
    procedure verificarInseriuChamadaTelaExterna(); override;
    procedure limparEndereco(nEnderecoChamou: String); //limpa os campos do endere�o, a partir daquele que alterou
    function validarAcessoEndereco(nEnderecoChamou: String): boolean; //valida se o acesso ao endere�o pode ser realizado
    procedure editarRegistroChamadaExterna();    
  public
    FoTipoImovel: TTipoImovel;
    FoEstado: TEstado;
    FoCidade: TCidade;
    FoBairro: TBairro;
    FoRua: TRua;
    //procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadImoveis: TfrmCadImoveis;

implementation

uses unConstantes, unDM, unSelecionaRegistroEstado, unSelecionaRegistroCidade,
  unSelecionaRegistroBairro, unSelecionaRegistroRua,
  unSelecionaRegistroTipoImovel, unPesquisandoImovel,
  unSelecionaRegistroImovel, unCadAgenciamento, unFuncoes;

{$R *.dfm}

{ TfrmCadImoveis }

(* procedimentos de controle *)

procedure TfrmCadImoveis.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;

  if(pTipo = PRM_CRIA_TELA_PESQUISA)then
  begin
    Application.CreateForm(TfrmPesquisandoImovel, Self.FoPesquisa);
    Self.FoPesquisa.passarParametro(PRM_INICIAR_TELA, null);
    Self.FoPesquisa.iniciarTela(frmCadImoveis);
    if(Assigned(Self.FoPesquisa))then
      Self.FoPesquisa.Hide;
  end

  else if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end

  else if(pTipo = PRM_EDITAR_PESSOA_AGENCIAMENTO_STAND_BY)then
  begin
    Self.FbChamadaExternaEditarRegistro := True;
    Self.FiTelaExternaChamouEditarRegistro := pValores;
  end

  else if(pTipo = PRM_CARREGA_REGISTRO_CODIGO)then
  begin
    Self.FnCodigoEditar := pValores;
  end;  
end;

procedure TfrmCadImoveis.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoImovel))) then
  begin
    Self.FoImovel.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoImovel.setDataCadastro(cdsDadosDATA_CADASTRO.AsDateTime);
    Self.FoImovel.setCodFK_TipoImovel(cdsDadosCOD_FK_TIPO_IMOVEL.AsInteger);
    Self.FoImovel.setCodFK_Estado(cdsDadosCOD_FK_ESTADO.AsInteger);
    Self.FoImovel.setCodFK_Cidade(cdsDadosCOD_FK_CIDADE.AsInteger);
    Self.FoImovel.setCodFK_Bairro(cdsDadosCOD_FK_BAIRRO.AsInteger);
    Self.FoImovel.setCodFK_Rua(cdsDadosCOD_FK_RUA.AsInteger);
    Self.FoImovel.setEnderecoCEP(cdsDadosENDERECO_CEP.AsString);
    Self.FoImovel.setEnderecoComplemento(cdsDadosENDERECO_COMPLEMENTO.AsString);
    Self.FoImovel.setStatus(cdsDadosSTATUS.AsInteger);
    Self.FoImovel.setSituacaoDesejavel(cdsDadosSITUACAO_DESEJAVEL.AsString);
    Self.FoImovel.setValorImovel(cdsDadosVALOR_IMOVEL.AsCurrency);
    Self.FoImovel.setDescricao(cdsDadosDESCRICAO.AsString);
    Self.FoImovel.setExibeTipoImovel();
    Self.FoImovel.setExibeEstado();
    Self.FoImovel.setExibeCidade();
    Self.FoImovel.setExibeBairro();
    Self.FoImovel.setExibeRua();
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadImoveis.carregarObjeto();','Acesso Indispon�vel');
  end;
end;

procedure TfrmCadImoveis.carregarComponentesApresentacao();
  function carregarSituacaoDesejavel(psSituacaoDesejavel:String):Integer;
  begin
    if(psSituacaoDesejavel = 'PLANTA')then
      Result := 0
    else if(psSituacaoDesejavel = 'PRONTO PARA MORAR')then
      Result := 1
    else if(psSituacaoDesejavel = 'DE TERCEIROS')then
      Result := 2
    else
      Result := -1;
  end;

begin
  if(Assigned(Self.FoImovel))then
  begin
    if(Self.FoImovel.getCodigo <> NUMERO_INDEFINIDO)then
      plsEdCodigo.Text := IntToStr(Self.FoImovel.getCodigo)
    else
      plsEdCodigo.Clear;

    plsMedDataCadastro.Text := DateTimeToStr(Self.FoImovel.getDataCadastro);

    case Self.FoImovel.getStatus of
      IMOVEL_STATUS_ABERTO: lblStatus.Caption := IMOVEL_STATUS_ABERTO_EXIBE;
      IMOVEL_STATUS_VENDIDO: lblStatus.Caption := IMOVEL_STATUS_VENDIDO_EXIBE;
      else lblStatus.Caption := NAO_DEFINIDO;
    end;

    plsEdTipoImovel.Text := Self.FoImovel.getExibeTipoImovel;
    Self.FoTipoImovel.codigo := Self.FoImovel.getCodFK_TipoImovel;
    plsEdEstado.Text := Self.FoImovel.getExibeEstado;
    Self.FoEstado.codigo := Self.FoImovel.getCodFK_Estado;
    plsEdCidade.Text := Self.FoImovel.getExibeCidade;
    Self.FoCidade.codigo := Self.FoImovel.getCodFK_Cidade;
    plsEdBairro.Text := Self.FoImovel.getExibeBairro;
    Self.FoBairro.codigo := Self.FoImovel.getCodFK_Bairro;
    plsEdRua.Text := Self.FoImovel.getExibeRua;
    Self.FoRua.codigo := Self.FoImovel.getCodFK_Rua;
    plsMedEnderecoCEP.Text := Self.FoImovel.getEnderecoCEP;
    plsMmEnderecoComplemento.Text := Self.FoImovel.getEnderecoComplemento;
    plsCbBxSituacao.ItemIndex := carregarSituacaoDesejavel(Self.FoImovel.getSituacaoDesejavel);
    plsEdValor.Text := FloatToStr(Self.FoImovel.getValorImovel);
    plsEdValor.Text := FoFuncoes.formatarValorMonetario(plsEdValor.Text);

    plsMmDescricao.Text := Self.FoImovel.getDescricao;
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadImoveis.carregarComponentesApresentacao();','Objeto Indispon�vel');
  end;
end;

procedure TfrmCadImoveis.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM imovel ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY codigo');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

procedure TfrmCadImoveis.limparObjeto();
begin
  if (Assigned(Self.FoImovel)) then
  begin
    Self.FoImovel.limparObjeto();
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadImoveis.limparObjeto();','Objeto Indispon�vel');
  end;
end;

procedure TfrmCadImoveis.limparTela(poForm: TForm);
var
  n: Integer;
  nTotComponentes: integer;
begin
  inherited;

  nTotComponentes := poForm.ComponentCount;
  try
    for n:=0 to nTotComponentes-1 do
    begin
      try
        if(poForm.Components[n] is TCheckBox)then
        begin
          if((poForm.Components[n] as TCheckBox).CanFocus)then
            (poForm.Components[n] as TCheckBox).Checked := False;
        end;
      except
        Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadImoveis.limparTela(poForm: TForm);', 'Erro');
      end;
    end;

  except
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadImoveis.limparTela(poForm: TForm);', 'Erro');
  end;
  lblStatus.Caption := STRING_INDEFINIDO;
end;

function TfrmCadImoveis.verificarHouveAlteracoes(): boolean;
var
  nCodTipoImovel: Integer;
  nCodEstado: Integer;
  nCodCidade: Integer;
  nCodBairro: Integer;
  nCodRua: Integer;
  sEnderecoCEP: String;
  sEnderecoComplemento: String;
  sSituacao: String;
  dValor: Double;
  sDescricao: String;

  bAlteracao: Boolean;
begin
  nCodTipoImovel := Self.FoTipoImovel.codigo;
  nCodEstado := Self.FoEstado.codigo;
  nCodCidade := Self.FoCidade.codigo;
  nCodBairro := Self.FoBairro.codigo;
  nCodRua := Self.FoRua.codigo;
  sEnderecoCEP := Trim(plsMedEnderecoCEP.Text);
  sEnderecoComplemento := Trim(plsMmEnderecoComplemento.Text);
  sSituacao := Trim(plsCbBxSituacao.Text);
  dValor := StrToFloat(plsEdValor.Text);
  sDescricao := trim(plsMmDescricao.Text);

  try
    bAlteracao := Self.FoImovel.verificarDiferencaCadastro(nCodTipoImovel,
    nCodEstado,nCodCidade,nCodBairro,nCodRua,sEnderecoCEP,sEnderecoComplemento,
    sSituacao,dValor,sDescricao);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;


function TfrmCadImoveis.verificarCamposObrigatorios(): boolean;
var
  bRetorno: Boolean;
  oCompFoco: TWinControl;
  sCampos: string;
begin
  bRetorno := True;
  oCompFoco := nil;
  sCampos := '';

  if(Self.FoTipoImovel.codigo = NUMERO_INDEFINIDO)then
  begin
    sCampos := 'Tipo do Im�vel';
  end;

  if(Self.FoEstado.codigo = NUMERO_INDEFINIDO)then
  begin
    if(sCampos <> '')then
      sCampos := sCampos + ', Estado'
    else
    begin
      sCampos := 'Estado';
    end;
  end;

  if(Self.FoCidade.codigo = NUMERO_INDEFINIDO)then
  begin
    if(sCampos <> '')then
      sCampos := sCampos + ', Cidade'
    else
    begin
      sCampos := 'Cidade';
    end;
  end;

  if(plsCbBxSituacao.Text = STRING_INDEFINIDO)then
  begin
    if(sCampos <> '')then
      sCampos := sCampos + ', Situa��o'
    else
    begin
      sCampos := 'Situa��o';
    end;
    oCompFoco := plsCbBxSituacao;
  end;


  if(sCampos <> '')then
  begin
    MessageDlg('Antes de salvar, verifique os campos: ' + sCampos + '.', mtInformation, [mbOK], 0);
    bRetorno := False;
  end;

  //setar foco no componente que n�o foi validado
  if((not(bRetorno))and(oCompFoco is TWinControl))then
    FoFuncoes.focarComponente(oCompFoco);

  Result := bRetorno;
end;

function TfrmCadImoveis.verificarRegistroJaExiste(): boolean;
var
  nTemSacada,nTemPiscina,nTemSalaoFesta,nTemChurrasqueira: Integer;

  //carrega valores para serem usados no ParamByName do sql
  procedure carregarValores();
  begin

  end;

begin
(*
  carregarValores();

  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM imovel WHERE cod_fk_tipo_imovel=:cod_fk_tip_imov ');
  zQryDados.SQL.Add('AND cod_fk_estado=:cod_fk_est AND cod_fk_cidade=:cod_fk_cid ');
  zQryDados.SQL.Add('AND cod_fk_bairro=:cod_fk_bai AND cod_fk_rua=:cod_fk_rua ');
  zQryDados.SQL.Add('AND situacao_desejavel=:sit_des');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoImovel.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoImovel.getCodigo;
  end;
  zQryDados.ParamByName('cod_fk_tip_imov').AsInteger := Self.FoTipoImovel.codigo;
  zQryDados.ParamByName('cod_fk_est').AsInteger := Self.FoEstado.codigo;
  zQryDados.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.codigo;
  zQryDados.ParamByName('cod_fk_bai').AsInteger := Self.FoBairro.codigo;
  zQryDados.ParamByName('cod_fk_rua').AsInteger := Self.FoRua.codigo;
  zQryDados.ParamByName('sit_des').AsString := plsCbBxSituacao.Text;
  zQryDados.Open;

  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Im�vel j� cadastrado.', mtWarning, [mbOK], 0);
  end
  else
*)
    Result := False;
end;

function TfrmCadImoveis.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  Result := bPodeDeletar;
end;

procedure TfrmCadImoveis.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       pnlTipoImovel.Enabled := False;
                       grpBxEndereco.Enabled := False;
                       pnlSituacaoValor.Enabled := False;
                       plsMmDescricao.Enabled := False;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Enabled := False;
                       pnlTipoImovel.Enabled := True;
                       grpBxEndereco.Enabled := True;
                       pnlSituacaoValor.Enabled := True;
                       plsMmDescricao.Enabled := True;
                       plsEdTipoImovel.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       plsEdAux.SetFocus;
                       plsEdCodigo.Enabled := False;
                       pnlTipoImovel.Enabled := True;
                       grpBxEndereco.Enabled := True;
                       pnlSituacaoValor.Enabled := True;
                       plsMmDescricao.Enabled := True;
                       plsEdTipoImovel.SetFocus;
                     end;
    OPC_SALVAR:      begin

                     end;
    OPC_EXCLUIR:     begin

                     end;
    OPC_CANCELAR:    begin

                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       pnlTipoImovel.Enabled := False;
                       grpBxEndereco.Enabled := False;
                       pnlSituacaoValor.Enabled := False;
                       plsMmDescricao.Enabled := False;
                       plsEdCodigo.SetFocus;
                     end;
  end; //fim - case
end;

procedure TfrmCadImoveis.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadImoveis);
  visibilidade(OPC_NOVO);
end;

function TfrmCadImoveis.salvar(): boolean;
var
  bSalvou: boolean;

  nTipoImovel,nEstado,nCidade,nBairro,nRua,nQtdeDormitorios,nQtdeGarragens: Integer;
  dValor: Currency;
  nTemSacada,nTemPiscina,nTemSalaoFesta,nTemChurrasqueira: Integer;

  //carrega valores para serem usados no ParamByName do sql
  procedure carregarValores();
  begin
    if(Self.FoTipoImovel.codigo <> NUMERO_INDEFINIDO)then
      nTipoImovel := Self.FoTipoImovel.codigo
    else
      nTipoImovel := REGISTRO_NULO;

    if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)then
      nEstado := Self.FoEstado.codigo
    else
      nEstado := REGISTRO_NULO;

    if(Self.FoCidade.codigo <> NUMERO_INDEFINIDO)then
      nCidade := Self.FoCidade.codigo
    else
      nCidade := REGISTRO_NULO;

    if(Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
      nBairro := Self.FoBairro.codigo
    else
      nBairro := REGISTRO_NULO;

    if(Self.FoRua.codigo <> NUMERO_INDEFINIDO)then
      nRua := Self.FoRua.codigo
    else
      nRua := REGISTRO_NULO;

    try
      dValor := StrToCurr(Self.FoFuncoes.retirarCaracteres(plsEdValor.Text, '.'));
    except
      dValor := NUMERO_INDEFINIDO;
    end;
  end;

  //limpa par�metro nulos - para o insert e update
  procedure limparParametrosNulos();
  begin
    //vazio
  end;

begin
  bSalvou := False;

  if(Self.FiFuncaoRegistro in [FUNCAO_REGISTRO_EDITAR, FUNCAO_REGISTRO_NOVO]) then
  begin
    inherited;
    carregarValores();
    if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR) then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('UPDATE imovel SET cod_fk_tipo_imovel=:cod_fk_ti_im, ');
        zQryDados.SQL.Add('cod_fk_estado=:cod_fk_es,cod_fk_cidade=:cod_fk_ci, ');
        zQryDados.SQL.Add('cod_fk_bairro=:cod_fk_ba,cod_fk_rua=:co_fk_ru, ');
        zQryDados.SQL.Add('endereco_cep=:end_cep,endereco_complemento=:end_com, ');
        zQryDados.SQL.Add('situacao_desejavel=:sit_des,valor_imovel=:val_imo, ');
        zQryDados.SQL.Add('descricao=:des ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('cod_fk_ti_im').AsInteger := nTipoImovel;
        zQryDados.ParamByName('cod_fk_es').AsInteger := nEstado;
        zQryDados.ParamByName('cod_fk_ci').AsInteger := nCidade;
        zQryDados.ParamByName('cod_fk_ba').AsInteger := nBairro;
        zQryDados.ParamByName('co_fk_ru').AsInteger := nRua;
        zQryDados.ParamByName('end_cep').AsString := plsMedEnderecoCEP.Text;
        zQryDados.ParamByName('end_com').AsString := plsMmEnderecoComplemento.Text;
        zQryDados.ParamByName('sit_des').AsString := plsCbBxSituacao.Text;
        zQryDados.ParamByName('val_imo').AsCurrency := dValor;
        zQryDados.ParamByName('des').AsString := plsMmDescricao.Text;
        zQryDados.ParamByName('cod').AsInteger := Self.FoImovel.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO imovel (status,cod_fk_tipo_imovel, ');
        zQryDados.SQL.Add('cod_fk_estado,cod_fk_cidade,cod_fk_bairro,cod_fk_rua, ');
        zQryDados.SQL.Add('endereco_cep,endereco_complemento,situacao_desejavel, ');
        zQryDados.SQL.Add('valor_imovel,descricao) ');
        zQryDados.SQL.Add('VALUES (:sta,:cod_fk_ti_im,:cod_fk_es,:cod_fk_ci, ');
        zQryDados.SQL.Add(':cod_fk_ba,:co_fk_ru,:end_cep,:end_com,:sit_des, ');
        zQryDados.SQL.Add(':val_imo,:des)');
        zQryDados.ParamByName('sta').AsInteger := IMOVEL_STATUS_ABERTO;
        zQryDados.ParamByName('cod_fk_ti_im').AsInteger := nTipoImovel;
        zQryDados.ParamByName('cod_fk_es').AsInteger := nEstado;
        zQryDados.ParamByName('cod_fk_ci').AsInteger := nCidade;
        zQryDados.ParamByName('cod_fk_ba').AsInteger := nBairro;
        zQryDados.ParamByName('co_fk_ru').AsInteger := nRua;
        zQryDados.ParamByName('end_cep').AsString := plsMedEnderecoCEP.Text;
        zQryDados.ParamByName('end_com').AsString := plsMmEnderecoComplemento.Text;
        zQryDados.ParamByName('sit_des').AsString := plsCbBxSituacao.Text;
        zQryDados.ParamByName('val_imo').AsCurrency := dValor;
        zQryDados.ParamByName('des').AsString := plsMmDescricao.Text;
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

  if((bSalvou)and(not(FbChamadaExternaInserirRegistro)))and
    (not(Self.FbChamadaExternaEditarRegistro))then
    Self.FoPesquisa.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS,null);

  Result := bSalvou;
end;

procedure TfrmCadImoveis.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
  sDescricao: String;
  vParametros: Variant;
begin
  nCodigo := NUMERO_INDEFINIDO;
  sDescricao := STRING_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    DM.zQryAux.Close;
    DM.zQryAux.SQL.Clear;
    DM.zQryAux.SQL.Add('SELECT i.codigo,i.valor_imovel,e.sigla,c.nome ');
    DM.zQryAux.SQL.Add('FROM imovel i ');
    DM.zQryAux.SQL.Add('JOIN estado e ON i.cod_fk_estado = e.codigo ');
    DM.zQryAux.SQL.Add('JOIN cidade c ON i.cod_fk_cidade = c.codigo ');
    DM.zQryAux.SQL.Add('ORDER BY i.codigo DESC ROWS 1');
    DM.zQryAux.Open;
    if(DM.zQryAux.RecordCount = 1)then
    begin
      nCodigo := DM.zQryAux.FieldByName('codigo').AsInteger;
      sDescricao := DM.zQryAux.FieldByName('sigla').AsString + ' - ' +
        DM.zQryAux.FieldByName('nome').AsString + ' - ' +
        Self.FoFuncoes.formatarValorMonetario(DM.zQryAux.FieldByName('valor_imovel').AsString);
    end;

    if(Self.FiTelaExternaChamouInserirRegistro = FORM_CAD_AGENCIAMENTOS)then
    begin
      vParametros := VarArrayCreate([0,1], varVariant);
      vParametros[0] := nCodigo;
      vParametros[1] := sDescricao;
      frmCadAgenciamento.passarParametro(PRM_INSERIU_IMOVEL,vParametros);
      Self.Close;
      Exit;
    end

    else if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_IMOVEL)then
    begin
      frmSelecionaRegistroImovel.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end

  else if(Self.FbChamadaExternaEditarRegistro)then
  begin
    DM.zQryAux.Close;
    DM.zQryAux.SQL.Clear;
    DM.zQryAux.SQL.Add('SELECT i.codigo,i.valor_imovel,e.sigla,c.nome ');
    DM.zQryAux.SQL.Add('FROM imovel i ');
    DM.zQryAux.SQL.Add('JOIN estado e ON i.cod_fk_estado = e.codigo ');
    DM.zQryAux.SQL.Add('JOIN cidade c ON i.cod_fk_cidade = c.codigo ');
    DM.zQryAux.SQL.Add('WHERE i.codigo=:codigo');
    DM.zQryAux.ParamByName('codigo').AsInteger := Self.FoImovel.getCodigo;
    DM.zQryAux.Open;
    if(DM.zQryAux.RecordCount = 1)then
    begin
      nCodigo := DM.zQryAux.FieldByName('codigo').AsInteger;
      sDescricao := DM.zQryAux.FieldByName('sigla').AsString + ' - ' +
        DM.zQryAux.FieldByName('nome').AsString + ' - ' +
        Self.FoFuncoes.formatarValorMonetario(DM.zQryAux.FieldByName('valor_imovel').AsString);
    end;

    if(Self.FiTelaExternaChamouEditarRegistro = FORM_CAD_AGENCIAMENTOS)then
    begin
      vParametros := VarArrayCreate([0,2], varVariant);
      vParametros[0] := nCodigo;
      vParametros[1] := sDescricao;
      vParametros[2] := EDITOU_IMOVEL;
      frmCadAgenciamento.passarParametro(PRM_EDITOU_REGISTRO_AGENCIAMENTO_STAND_BY,vParametros);
      Self.Close;
      Exit;
    end;
  end;
end;


function TfrmCadImoveis.excluir(): Boolean;
var
  bDeletou: Boolean;
  bPodeDeletar: Boolean;
begin
  bDeletou := False;
  bPodeDeletar := True;

  //verifica se im�vel n�o est� associado a um agenciamento
  DM.zQryAgenciamentos.Close;
  DM.zQryAgenciamentos.SQL.Clear;
  DM.zQryAgenciamentos.SQL.Add('SELECT * FROM agenciamentos WHERE cod_fk_imovel=:cod_fk_im');
  DM.zQryAgenciamentos.ParamByName('cod_fk_im').AsInteger := Self.FoImovel.getCodigo;
  DM.zQryAgenciamentos.Open;
  if(DM.zQryAgenciamentos.RecordCount <> 0)then
  begin
    MessageDlg('Im�vel n�o pode ser deletado, pois existe agenciamento para o mesmo.',
      mtInformation, [mbOK], 0);
    bPodeDeletar := False;
  end;

  //verifica se im�vel n�o est� vendido

  if(bPodeDeletar)then
  begin
    try
      DM.ZConnection.StartTransaction;
      zQryDados.Close;
      zQryDados.SQL.Clear;
      zQryDados.SQL.Add('DELETE FROM imovel WHERE codigo=:cod');
      zQryDados.ParamByName('cod').AsInteger := Self.FoImovel.getCodigo();
      zQryDados.ExecSQL();
      DM.ZConnection.Commit;
      bDeletou := True;
    except
      DM.ZConnection.Rollback;
    end;
  end;

  if(bPodeDeletar = False)then
    Result := True //retorna True pois j� foi exibida mensagem que registro n�o pode ser deletado
  else
    Result := bDeletou;
end;

procedure TfrmCadImoveis.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

procedure TfrmCadImoveis.limparEndereco(nEnderecoChamou: String);
  procedure limparCidade();
  begin
    plsEdCidade.Clear;
    Self.FoCidade.codigo := NUMERO_INDEFINIDO;
    Self.FoCidade.nome := STRING_INDEFINIDO;
  end;
  procedure limparBairro();
  begin
    plsEdBairro.Clear;
    Self.FoBairro.codigo := NUMERO_INDEFINIDO;
    Self.FoBairro.nome := STRING_INDEFINIDO;
  end;
  procedure limparRua();
  begin
    plsEdRua.Clear;
    Self.FoRua.codigo := NUMERO_INDEFINIDO;
    Self.FoRua.nome := STRING_INDEFINIDO;
    Self.FoRua.cep := STRING_INDEFINIDO;
  end;

begin
  if(nEnderecoChamou = 'ESTADO')then
  begin
    limparCidade();
    limparBairro();
    limparRua();
  end
  else if(nEnderecoChamou = 'CIDADE')then
  begin
    limparBairro();
    limparRua();
  end
  else if(nEnderecoChamou = 'BAIRRO')then
  begin
    limparRua();
  end;
end;

//valida se o acesso ao endere�o pode ser realizado
function TfrmCadImoveis.validarAcessoEndereco(nEnderecoChamou: String): boolean;
var
  bAcesso: Boolean;
begin
  bAcesso := False;

  if(nEnderecoChamou = 'CIDADE')then
  begin
    if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)then
      bAcesso := True;
  end
  else if(nEnderecoChamou = 'BAIRRO')then
  begin
    if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)and(Self.FoCidade.codigo <> NUMERO_INDEFINIDO)then
      bAcesso := True;
  end
  else if(nEnderecoChamou = 'RUA')then
  begin
    if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)and(Self.FoCidade.codigo <> NUMERO_INDEFINIDO)and
      (Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
      bAcesso := True;
  end;

  Result := bAcesso;
end;

procedure TfrmCadImoveis.editarRegistroChamadaExterna();

  procedure pesquisarRegistro();
  begin
    cdsDados.Close;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('SELECT * FROM imovel WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FnCodigoEditar;
    zQryDados.Open;
    cdsDados.Open;
  end;

begin
  pesquisarRegistro();
  if(cdsDados.Active)and(cdsDados.RecordCount>0)then
  begin
    Self.carregarObjeto();
    Self.carregarComponentesApresentacao();
    Self.FiFuncaoRegistro := FUNCAO_REGISTRO_EDITAR;
    tlBtnNovo.Enabled := False;
    tlBtnEditar.Enabled := False;
    tlBtnSalvar.Enabled := True;
    tlBtnExcluir.Enabled := False;
    tlBtnCancelar.Enabled := True;
  end
  else
  begin
    MessageDlg('Erro ao pesquisar por im�vel ao editar agenciamento stand by.', mtWarning, [mbOK], 0);
  end;
end;

(* fim - procedimentos de controle *)


procedure TfrmCadImoveis.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoImovel := TObjImovel.Create;
  Self.FnCodigoEditar := NUMERO_INDEFINIDO;  
end;

procedure TfrmCadImoveis.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoImovel);
end;

procedure TfrmCadImoveis.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo();
end;

procedure TfrmCadImoveis.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadImoveis.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadImoveis.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadImoveis.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadImoveis.plsEdCodigoExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadImoveis.spBtnBuscaTipoImovelClick(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmSelecionaRegistroTipoImovel, frmSelecionaRegistroTipoImovel);
    frmSelecionaRegistroTipoImovel.passarParametro(PRM_TELA_CHAMOU,FORM_CAD_IMOVEL);
    frmSelecionaRegistroTipoImovel.ShowModal;
  finally
    if(Self.FoTipoImovel.codigo <> NUMERO_INDEFINIDO)then
    begin
      plsEdTipoImovel.Text := Self.FoTipoImovel.nome;
      Self.FoFuncoes.focarComponente(plsEdEstado);
    end;
    FreeAndNil(frmSelecionaRegistroTipoImovel);
  end;
end;

procedure TfrmCadImoveis.spBtnBuscaEstadoClick(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmSelecionaRegistroEstado, frmSelecionaRegistroEstado);
    frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL);
    frmSelecionaRegistroEstado.ShowModal;
  finally
    if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)then
    begin
      plsEdEstado.Text := Self.FoEstado.nome;
      limparEndereco('ESTADO');
      Self.FoFuncoes.focarComponente(plsEdCidade);
    end;
    FreeAndNil(frmSelecionaRegistroEstado);
  end;
end;

procedure TfrmCadImoveis.spBtnBuscaCidadeClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('CIDADE'))then
    MessageDlg('Um estado deve estar selecionado.', mtInformation, [mbOK], 0)
  else
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroCidade, frmSelecionaRegistroCidade);
      frmSelecionaRegistroCidade.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL);
      frmSelecionaRegistroCidade.passarParametro('FK_COD_ESTADO', Self.FoEstado.codigo);
      frmSelecionaRegistroCidade.ShowModal;
    finally
      if(Self.FoCidade.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdCidade.Text := Self.FoCidade.nome;
        limparEndereco('CIDADE');
        Self.FoFuncoes.focarComponente(plsEdBairro);
      end;
      FreeAndNil(frmSelecionaRegistroCidade);
    end;
  end;
end;

procedure TfrmCadImoveis.spBtnBuscaBairroClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('BAIRRO'))then
    MessageDlg('Uma cidade deve estar selecionada.', mtInformation, [mbOK], 0)
  else
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
      frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL);
      frmSelecionaRegistroBairro.passarParametro('FK_COD_CIDADE', Self.FoCidade.codigo);
      frmSelecionaRegistroBairro.ShowModal;
    finally
      if(Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdBairro.Text := Self.FoBairro.nome;
        limparEndereco('BAIRRO');
        Self.FoFuncoes.focarComponente(plsEdRua);
      end;
      FreeAndNil(frmSelecionaRegistroBairro);
    end;
  end;
end;

procedure TfrmCadImoveis.spBtnBuscaRuaClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('RUA'))then
    MessageDlg('Um bairro deve estar selecionado.', mtInformation, [mbOK], 0)
  else
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroRua, frmSelecionaRegistroRua);
      frmSelecionaRegistroRua.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_IMOVEL);
      frmSelecionaRegistroRua.passarParametro('FK_COD_BAIRRO', Self.FoBairro.codigo);
      frmSelecionaRegistroRua.ShowModal;
    finally
      if(Self.FoRua.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdRua.Text := Self.FoRua.nome;
        plsMedEnderecoCEP.Text := Self.FoRua.cep;
        Self.FoFuncoes.focarComponente(plsMmEnderecoComplemento);
      end;
      FreeAndNil(frmSelecionaRegistroRua);
    end;
  end;
end;

procedure TfrmCadImoveis.plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sValor: string;
  vParametros: Variant;
begin
  inherited;
  if (Key in[48,49,50,51,52,53,54,55,56,57,8])then //48..57 = n�meros - 8 = backspace
  begin
    if (Self.FbPodePesquisar) then
    begin
      if(Key=27)then //esc
        begin
          if(Assigned(Self.FoPesquisa))then
            Self.FoPesquisa.Hide;
        end
      else
      begin
        sValor := plsEdCodigo.Text;
        vParametros := VarArrayCreate([0,2],varVariant);
        {vParametros[0] = par�metro do campo da pesquisa
        vParametros[1] = campo da pesquisa
        vParametros[1] = valor da pesquisa
        }
        vParametros[0] := PRM_PESQUISA_CODIGO;
        vParametros[1] := 'CC_CODIGO';
        vParametros[2] := sValor;
        Self.FoPesquisa.passarParametro(PRM_PESQUISAR_REGISTRO, vParametros);
        Self.FoPesquisa.Show;
      end;
    end;
  end;
end;

procedure TfrmCadImoveis.plsEdTipoImovelClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaTipoImovelClick(Self);
end;

procedure TfrmCadImoveis.plsEdEstadoClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaEstadoClick(Self);
end;

procedure TfrmCadImoveis.plsEdCidadeClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaCidadeClick(Self);
end;

procedure TfrmCadImoveis.plsEdBairroClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaBairroClick(Self);
end;

procedure TfrmCadImoveis.plsEdRuaClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaRuaClick(Self);
end;

procedure TfrmCadImoveis.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadImoveis.FormShow(Sender: TObject);
begin
  if(FbChamadaExternaEditarRegistro)then
  begin
    Self.editarRegistroChamadaExterna();
  end
  else
    inherited;
end;

procedure TfrmCadImoveis.plsEdTipoImovelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaTipoImovelClick(Self);
end;

procedure TfrmCadImoveis.plsEdEstadoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaEstadoClick(Self);
end;

procedure TfrmCadImoveis.plsEdCidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaCidadeClick(Self);
end;

procedure TfrmCadImoveis.plsEdBairroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaBairroClick(Self);
end;

procedure TfrmCadImoveis.plsEdRuaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaRuaClick(Self);
end;

end.
