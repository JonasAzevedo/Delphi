(*
  cliente - pessoa jurídica
*)
unit unCadClientePessoaJuridica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ComCtrls, ToolWin, plsComboBox, plsMemo, Buttons, ExtCtrls, Mask,
  plsTMaskEdit, unObjClientePessoaJuridica,
  unConjuntoDadosMeioCaptacao, unConjuntoDadosEstado,unConjuntoDadosCidade,
  unConjuntoDadosBairro, unConjuntoDadosRua;

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
    TMeioCaptacao = record
      codigo: Integer;
      nome: string[50];
    end;

type
  TfrmCadClientePessoaJuridica = class(TfrmCadastroBasico)
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosDATA_CAPTACAO: TDateField;
    zQryDadosNOME: TStringField;
    zQryDadosEMAIL: TStringField;
    zQryDadosCNPJ: TStringField;
    zQryDadosTELEFONE_RESIDENCIAL: TStringField;
    zQryDadosTELEFONE_COMERCIAL: TStringField;
    zQryDadosTELEFONE_CELULAR: TStringField;
    zQryDadosCOD_FK_MEIO_CAPTACAO: TIntegerField;
    zQryDadosCOD_FK_ESTADO: TIntegerField;
    zQryDadosCOD_FK_CIDADE: TIntegerField;
    zQryDadosCOD_FK_BAIRRO: TIntegerField;
    zQryDadosCOD_FK_RUA: TIntegerField;
    zQryDadosENDERECO_CEP: TStringField;
    zQryDadosENDERECO_COMPLEMENTO: TStringField;
    zQryDadosHORARIO_LIGACAO: TStringField;
    zQryDadosHORA_INICIO: TTimeField;
    zQryDadosHORA_FINAL: TTimeField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosDATA_CAPTACAO: TDateField;
    cdsDadosNOME: TStringField;
    cdsDadosEMAIL: TStringField;
    cdsDadosCNPJ: TStringField;
    cdsDadosTELEFONE_RESIDENCIAL: TStringField;
    cdsDadosTELEFONE_COMERCIAL: TStringField;
    cdsDadosTELEFONE_CELULAR: TStringField;
    cdsDadosCOD_FK_MEIO_CAPTACAO: TIntegerField;
    cdsDadosCOD_FK_ESTADO: TIntegerField;
    cdsDadosCOD_FK_CIDADE: TIntegerField;
    cdsDadosCOD_FK_BAIRRO: TIntegerField;
    cdsDadosCOD_FK_RUA: TIntegerField;
    cdsDadosENDERECO_CEP: TStringField;
    cdsDadosENDERECO_COMPLEMENTO: TStringField;
    cdsDadosHORARIO_LIGACAO: TStringField;
    cdsDadosHORA_INICIO: TTimeField;
    cdsDadosHORA_FINAL: TTimeField;
    lblCodigo: TLabel;
    lblCampoObrigatorio1: TLabel;
    plsEdNome: TPlsEdit;
    plsEdCodigo: TPlsEdit;
    lblNome: TLabel;
    lblCPF: TLabel;
    plsMedCNPJ: TPlsMaskEdit;
    plsEdEmail: TPlsEdit;
    lblEmail: TLabel;
    pnlMeioCaptacao: TPanel;
    lblMeioCaptacao: TLabel;
    spBtnBuscaMeioCaptacao: TSpeedButton;
    lblCampoObrigatorio2: TLabel;
    plsEdMeioCaptacao: TPlsEdit;
    grpBxTelefones: TGroupBox;
    lblResidencial: TLabel;
    lblComercial: TLabel;
    lblCelular: TLabel;
    plsMedTelefoneResidencial: TPlsMaskEdit;
    plsMedTelefoneComercial: TPlsMaskEdit;
    plsMedTelefoneCelular: TPlsMaskEdit;
    grpBxEndereco: TGroupBox;
    lblCEP: TLabel;
    lblComplemento: TLabel;
    plsMedCEP: TPlsMaskEdit;
    plsMmEnderecoComplemento: TPlsMemo;
    grpBxHorarioLigacao: TGroupBox;
    lblPeriodo: TLabel;
    lblDas: TLabel;
    lblAs: TLabel;
    plsCbBxPeriodo: TPlsComboBox;
    plsMedHoraLigacaoFinal: TPlsMaskEdit;
    plsMedHoraLigacaoInicio: TPlsMaskEdit;
    zQryDadosRENDIMENTO: TFloatField;
    cdsDadosRENDIMENTO: TFloatField;
    plsMedRendimento: TPlsEdit;
    lblRendimento: TLabel;
    pnlEstado: TPanel;
    pnlCidade: TPanel;
    pnlBairro: TPanel;
    pnlRua: TPanel;
    lblEstado: TLabel;
    lblCampoObrigatorio3: TLabel;
    plsEdEstado: TPlsEdit;
    spBtnBuscaEstado: TSpeedButton;
    lblCidade: TLabel;
    lblCampoObrigatorio4: TLabel;
    plsEdCidade: TPlsEdit;
    spBtnBuscaCidade: TSpeedButton;
    lblBairro: TLabel;
    plsEdBairro: TPlsEdit;
    spBtnBuscaBairro: TSpeedButton;
    lblRua: TLabel;
    spBtnBuscaRua: TSpeedButton;
    plsEdRua: TPlsEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure plsEdCodigoExit(Sender: TObject);
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdNomeExit(Sender: TObject);
    procedure plsEdNomeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsMedCNPJExit(Sender: TObject);
    procedure plsMedCNPJKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spBtnBuscaEstadoClick(Sender: TObject);
    procedure spBtnBuscaCidadeClick(Sender: TObject);
    procedure spBtnBuscaBairroClick(Sender: TObject);
    procedure spBtnBuscaRuaClick(Sender: TObject);
    procedure spBtnBuscaMeioCaptacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure plsEdMeioCaptacaoExit(Sender: TObject);
    procedure plsEdEstadoExit(Sender: TObject);
    procedure plsEdCidadeExit(Sender: TObject);
    procedure plsEdBairroExit(Sender: TObject);
    procedure plsEdRuaExit(Sender: TObject);
    procedure plsCbBxPeriodoEnter(Sender: TObject);
    procedure plsCbBxPeriodoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCodigoEnter(Sender: TObject);
    procedure plsEdCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdNomeKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdNomeEnter(Sender: TObject);
    procedure plsMedCNPJEnter(Sender: TObject);
    procedure plsMedCNPJKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdEmailKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdEmailEnter(Sender: TObject);
    procedure plsMedRendimentoEnter(Sender: TObject);
    procedure plsMedRendimentoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdMeioCaptacaoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdMeioCaptacaoEnter(Sender: TObject);
    procedure plsMedTelefoneResidencialEnter(Sender: TObject);
    procedure plsMedTelefoneResidencialKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedTelefoneComercialKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedTelefoneComercialEnter(Sender: TObject);
    procedure plsMedTelefoneCelularEnter(Sender: TObject);
    procedure plsMedTelefoneCelularKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsEdEstadoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdEstadoEnter(Sender: TObject);
    procedure plsEdCidadeEnter(Sender: TObject);
    procedure plsEdCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdBairroKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdBairroEnter(Sender: TObject);
    procedure plsEdRuaEnter(Sender: TObject);
    procedure plsEdRuaKeyPress(Sender: TObject; var Key: Char);
    procedure plsMedCEPKeyPress(Sender: TObject; var Key: Char);
    procedure plsMedCEPEnter(Sender: TObject);
    procedure plsMmEnderecoComplementoKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedHoraLigacaoInicioKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedHoraLigacaoInicioEnter(Sender: TObject);
    procedure plsMedHoraLigacaoFinalEnter(Sender: TObject);
    procedure plsMedHoraLigacaoFinalKeyPress(Sender: TObject;
      var Key: Char);
  private
    FoClientePessoaJuridica: TObjClientePessoaJuridica;
    FoConjuntoDadosMeioCaptacao: TConjuntoDadosMeioCaptacao;
    FoConjuntoDadosEstado: TConjuntoDadosEstado;
    FoConjuntoDadosCidade: TConjuntoDadosCidade;
    FoConjuntoDadosBairro: TConjuntoDadosBairro;
    FoConjuntoDadosRua: TConjuntoDadosRua;

    FnCodigoEditar: Integer;
    FbPodeLimparEndereco: Boolean;

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
    procedure limparEndereco(iEnderecoChamou: String); //limpa os campos do endereço, a partir daquele que alterou
    function validarAcessoEndereco(iEnderecoChamou: String): boolean; //valida se o acesso ao endereço pode ser realizado
    procedure editarRegistroChamadaExterna();

    procedure AbreTelaSelecaoMeioCaptacao(pnTpSelecao:Word);
    procedure VerificarMeioCaptacaoExiste();

    procedure AbreTelaSelecaoEstado(pnTpSelecao:Word);
    procedure VerificarEstadoExiste();

    procedure AbreTelaSelecaoCidade(pnTpSelecao:Word);
    procedure VerificarCidadeExiste();

    procedure AbreTelaSelecaoBairro(pnTpSelecao:Word);
    procedure VerificarBairroExiste();

    procedure AbreTelaSelecaoRua(pnTpSelecao:Word);
    procedure VerificarRuaExiste();
  public
    FoMeioCaptacao: TMeioCaptacao;
    FoEstado: TEstado;
    FoCidade: TCidade;
    FoBairro: TBairro;
    FoRua: TRua;

    procedure iniciarTela(poForm: TForm); override;
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadClientePessoaJuridica: TfrmCadClientePessoaJuridica;

implementation

uses
  unPesquisandoClientePessoaJuridica, unConstantes, unDM,
  unSelecionaRegistroEstado, unSelecionaRegistroCidade,
  unSelecionaRegistroBairro, unSelecionaRegistroRua,
  unSelecionaRegistroMeioCaptacao, unVariaveis,
  unSelecionaRegistroClientePessoaJuridica, unPrincipal;

const
  fnSELECIONAR_MEIO_CAPTACAO_NORMAL    = 1;
  fnSELECIONAR_MEIO_CAPTACAO_DIGITANDO = 2;

  fnSELECIONAR_ESTADO_NORMAL    = 1;
  fnSELECIONAR_ESTADO_DIGITANDO = 2;

  fnSELECIONAR_CIDADE_NORMAL    = 1;
  fnSELECIONAR_CIDADE_DIGITANDO = 2;

  fnSELECIONAR_BAIRRO_NORMAL    = 1;
  fnSELECIONAR_BAIRRO_DIGITANDO = 2;

  fnSELECIONAR_RUA_NORMAL    = 1;
  fnSELECIONAR_RUA_DIGITANDO = 2;


{$R *.dfm}

{ TfrmCadClientePessoaJuridica }

(* procedimentos de controle *)

procedure TfrmCadClientePessoaJuridica.iniciarTela(poForm: TForm);
begin
  inherited;
(*
  Application.CreateForm(TfrmPesquisandoPessoaFisica, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmCadPessoaFisica);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
*)
end;

procedure TfrmCadClientePessoaJuridica.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_CRIA_TELA_PESQUISA)then
  begin
    Application.CreateForm(TfrmPesquisandoClientePessoaJuridica, Self.FoPesquisa);
    Self.FoPesquisa.passarParametro(PRM_INICIAR_TELA, null);
    Self.FoPesquisa.iniciarTela(frmCadClientePessoaJuridica);
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
  end

  else if(pTipo = PRM_NAO_LIMPAR_ENDERECO)then
  begin
    Self.FbPodeLimparEndereco := False;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS)then
  begin
    if(pValores[0] = CONJUNTO_DADOS_MEIO_CAPTACAO)then
      FoConjuntoDadosMeioCaptacao.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_ESTADO)then
      FoConjuntoDadosEstado.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_CIDADE)then
      FoConjuntoDadosCidade.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_BAIRRO)then
      FoConjuntoDadosBairro.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_RUA)then
      FoConjuntoDadosRua.ExecutarSQLSelecao();
  end;
end;

procedure TfrmCadClientePessoaJuridica.limparObjeto();
begin
  if (Assigned(FoClientePessoaJuridica)) then
  begin
    FoClientePessoaJuridica.limparObjeto();
  end
end;

procedure TfrmCadClientePessoaJuridica.limparTela(poForm: TForm);
begin
  inherited;
  FoEstado.codigo := NUMERO_INDEFINIDO;
  FoEstado.nome := STRING_INDEFINIDO;

  FoCidade.codigo := NUMERO_INDEFINIDO;
  FoCidade.nome := STRING_INDEFINIDO;

  FoBairro.codigo := NUMERO_INDEFINIDO;
  FoBairro.nome := STRING_INDEFINIDO;

  FoRua.codigo := NUMERO_INDEFINIDO;
  FoRua.nome := STRING_INDEFINIDO;
  FoRua.cep := STRING_INDEFINIDO;

  FoMeioCaptacao.codigo := NUMERO_INDEFINIDO;
  FoMeioCaptacao.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadClientePessoaJuridica.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(FoClientePessoaJuridica))) then
  begin
    FoClientePessoaJuridica.setCodigo(cdsDadosCODIGO.AsInteger);
    FoClientePessoaJuridica.setDataCadastro(cdsDadosDATA_CADASTRO.AsDateTime);
    FoClientePessoaJuridica.setNome(cdsDadosNOME.AsString);
    FoClientePessoaJuridica.setEmail(cdsDadosEMAIL.AsString);
    FoClientePessoaJuridica.setCNPJ(cdsDadosCNPJ.AsString);
    FoClientePessoaJuridica.setTelefoneResidencial(cdsDadosTELEFONE_RESIDENCIAL.AsString);
    FoClientePessoaJuridica.setTelefoneComercial(cdsDadosTELEFONE_COMERCIAL.AsString);
    FoClientePessoaJuridica.setTelefoneCelular(cdsDadosTELEFONE_CELULAR.AsString);
    FoClientePessoaJuridica.setFkMeioCaptacao(cdsDadosCOD_FK_MEIO_CAPTACAO.AsInteger);
    FoClientePessoaJuridica.setFkEstado(cdsDadosCOD_FK_ESTADO.AsInteger);
    FoClientePessoaJuridica.setFkCidade(cdsDadosCOD_FK_CIDADE.AsInteger);
    FoClientePessoaJuridica.setFkBairro(cdsDadosCOD_FK_BAIRRO.AsInteger);
    FoClientePessoaJuridica.setFkRua(cdsDadosCOD_FK_RUA.AsInteger);
    FoClientePessoaJuridica.setEnderecoCEP(cdsDadosENDERECO_CEP.AsString);
    FoClientePessoaJuridica.setEnderecoComplemento(cdsDadosENDERECO_COMPLEMENTO.AsString);
    FoClientePessoaJuridica.setHorarioLigacao(cdsDadosHORARIO_LIGACAO.AsString);
    FoClientePessoaJuridica.setHoraInicio(cdsDadosHORA_INICIO.AsDateTime);
    FoClientePessoaJuridica.setHoraFinal(cdsDadosHORA_FINAL.AsDateTime);
    FoClientePessoaJuridica.setRendimento(cdsDadosRENDIMENTO.AsCurrency);
    FoClientePessoaJuridica.setExibeMeioCaptacao(False);
    FoClientePessoaJuridica.setExibeEstado(False);
    FoClientePessoaJuridica.setExibeCidade(False);
    FoClientePessoaJuridica.setExibeBairro(False);
    FoClientePessoaJuridica.setExibeRua(False);
  end
  else
  begin
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadClientePessoaJuridica.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadClientePessoaJuridica.carregarComponentesApresentacao();
begin
  if(Assigned(FoClientePessoaJuridica))then
  begin
    if(FoClientePessoaJuridica.getCodigo <> NUMERO_INDEFINIDO)then
      plsEdCodigo.Text := IntToStr(FoClientePessoaJuridica.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdNome.Text := FoClientePessoaJuridica.getNome;
    plsMedCNPJ.Text := FoClientePessoaJuridica.getCNPJ;
    plsEdEmail.Text := FoClientePessoaJuridica.getEmail;
    plsEdMeioCaptacao.Text := FoClientePessoaJuridica.getExibeMeioCaptacao;
    Self.FoMeioCaptacao.codigo := FoClientePessoaJuridica.getFkMeioCaptacao;
    Self.FoMeioCaptacao.nome := FoClientePessoaJuridica.getExibeMeioCaptacao;
    plsMedTelefoneResidencial.Text := FoClientePessoaJuridica.getTelefoneResidencial;
    plsMedTelefoneComercial.Text := FoClientePessoaJuridica.getTelefoneComercial;
    plsMedTelefoneCelular.Text := FoClientePessoaJuridica.getTelefoneCelular;
    plsEdEstado.Text := FoClientePessoaJuridica.getExibeEstado;
    Self.FoEstado.codigo := FoClientePessoaJuridica.getFkEstado;
    Self.FoEstado.nome := FoClientePessoaJuridica.getExibeEstado;
    plsEdCidade.Text := FoClientePessoaJuridica.getExibeCidade;
    Self.FoCidade.codigo := FoClientePessoaJuridica.getFkCidade;
    Self.FoCidade.nome := FoClientePessoaJuridica.getExibeCidade;
    plsEdBairro.Text := FoClientePessoaJuridica.getExibeBairro;
    Self.FoBairro.codigo := FoClientePessoaJuridica.getFkBairro;
    Self.FoBairro.nome := FoClientePessoaJuridica.getExibeBairro;
    plsEdRua.Text := FoClientePessoaJuridica.getExibeRua;
    Self.FoRua.codigo := FoClientePessoaJuridica.getFkRua;
    Self.FoRua.nome := FoClientePessoaJuridica.getExibeRua;
    plsMedCEP.Text := FoClientePessoaJuridica.getEnderecoCEP;
    plsMmEnderecoComplemento.Text := FoClientePessoaJuridica.getEnderecoComplemento;

    if(FoClientePessoaJuridica.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_MANHA)then
      plsCbBxPeriodo.ItemIndex := 0
    else if(FoClientePessoaJuridica.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_TARDE)then
      plsCbBxPeriodo.ItemIndex := 1
    else if(FoClientePessoaJuridica.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_NOITE)then
      plsCbBxPeriodo.ItemIndex := 2
    else if(FoClientePessoaJuridica.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_QUALQUER)then
      plsCbBxPeriodo.ItemIndex := 3
    else
      plsCbBxPeriodo.ItemIndex := -1;

    if(FoClientePessoaJuridica.getHoraInicio <> NUMERO_INDEFINIDO)then
      plsMedHoraLigacaoInicio.Text := TimeToStr(FoClientePessoaJuridica.getHoraInicio)
    else
      plsMedHoraLigacaoInicio.Clear;

    if(FoClientePessoaJuridica.getHoraFinal <> NUMERO_INDEFINIDO)then
      plsMedHoraLigacaoFinal.Text := TimeToStr(FoClientePessoaJuridica.getHoraFinal)
    else
      plsMedHoraLigacaoFinal.Clear;

    if(FoClientePessoaJuridica.getRendimento <> NUMERO_INDEFINIDO)then
    begin
      plsMedRendimento.Text := FloatToStr(Self.FoClientePessoaJuridica.getRendimento);
      plsMedRendimento.Text := FoFuncoes.formatarValorMonetario(plsMedRendimento.Text);
    end
    else
      plsMedRendimento.Clear;
  end;
end;

procedure TfrmCadClientePessoaJuridica.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM cliente_pessoa_juridica ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadClientePessoaJuridica.verificarHouveAlteracoes(): boolean;
var
  sNome: String;
  sEmail: String;
  sCNPJ: String;
  sTelefoneResidencial: String;
  sTelefoneComercial: String;
  sTelefoneCelular: String;
  iMeioCaptacao: Integer;
  iEstado: Integer;
  iCidade: Integer;
  iBairro: Integer;
  iRua: Integer;
  sEnderecoCEP: String;
  sEnderecoComplemento: String;
  sHorarioLigacao: String;
  tHoraInicio: TTime;
  tHoraFinal: TTime;
  dRendimento: Double;

  bAlteracao: Boolean;
begin
  sNome := Trim(plsEdNome.Text);
  sEmail := Trim(plsEdEmail.Text);
  sCNPJ := Trim(plsMedCNPJ.Text);
  sTelefoneResidencial := Trim(plsMedTelefoneResidencial.Text);
  sTelefoneComercial := Trim(plsMedTelefoneComercial.Text);
  sTelefoneCelular := Trim(plsMedTelefoneCelular.Text);
  iMeioCaptacao := Self.FoMeioCaptacao.codigo;
  iEstado := Self.FoEstado.codigo;
  iCidade := Self.FoCidade.codigo;
  iBairro := Self.FoBairro.codigo;
  iRua := Self.FoRua.codigo;
  sEnderecoCEP := Trim(plsMedCEP.Text);
  sEnderecoComplemento := Trim(plsMmEnderecoComplemento.Text);
  sHorarioLigacao := Trim(plsCbBxPeriodo.Text);
  try
    tHoraInicio := StrToTime(plsMedHoraLigacaoInicio.Text);
  except
    tHoraInicio := NUMERO_INDEFINIDO;
  end;
  try
    tHoraFinal := StrToTime(plsMedHoraLigacaoFinal.Text);
  except
    tHoraFinal := NUMERO_INDEFINIDO;
  end;
  dRendimento := FoFuncoes.formatarValorCurrency(plsMedRendimento.Text);

  try
    bAlteracao := FoClientePessoaJuridica.verificarDiferencaCadastro(sNome,sEmail,
     sCNPJ,sTelefoneResidencial,sTelefoneComercial,sTelefoneCelular,iMeioCaptacao,
     iEstado,iCidade,iBairro,iRua,sEnderecoCEP,sEnderecoComplemento,sHorarioLigacao,
     tHoraInicio,tHoraFinal,dRendimento);
  except
    bAlteracao := True;
  end;
  Result := bAlteracao;
end;

function TfrmCadClientePessoaJuridica.verificarCamposObrigatorios(): boolean;
var
  bRetorno: Boolean;
  compFoco: TWinControl;
  campos: string;
  sAux: string;
  tHoraInicio,tHoraFinal: TTime;
begin
  bRetorno := True;
  compFoco := nil;
  campos := '';
  sAux := '';

  if(Trim(plsEdNome.Text) = '')then
  begin
    if(campos <> '')then
      campos := campos + ', Nome'
    else
    begin
      campos := 'Nome';
      compFoco := plsEdNome;
    end;
  end;

  if(Self.FoMeioCaptacao.codigo = NUMERO_INDEFINIDO)then
  begin
    if(campos <> '')then
      campos := campos + ', Meio de Captação'
    else
    begin
      campos := 'Meio de Captação';
      compFoco := plsEdMeioCaptacao;
    end;
  end;

  if(Self.FoEstado.codigo = NUMERO_INDEFINIDO)then
  begin
    if(campos <> '')then
      campos := campos + ', Estado'
    else
    begin
      campos := 'Estado';
      compFoco := plsEdEstado;
    end;
  end;

  if(Self.FoCidade.codigo = NUMERO_INDEFINIDO)then
  begin
    if(campos <> '')then
      campos := campos + ', Cidade'
    else
    begin
      campos := 'Cidade';
      compFoco := plsEdCidade;
    end;
  end;

  if(campos <> '')then
  begin
    MessageDlg('Antes de salvar, verifique os campos: ' + campos + '.', mtInformation, [mbOK], 0);
    bRetorno := False;
  end;

  //verifica horário da ligação
  if(bRetorno)then
  begin
    try
      tHoraInicio := StrToTime(plsMedHoraLigacaoInicio.Text);
    except
      tHoraInicio := NUMERO_INDEFINIDO;
    end;
    try
      tHoraFinal := StrToTime(plsMedHoraLigacaoFinal.Text);
    except
      tHoraFinal := NUMERO_INDEFINIDO;
    end;
    if((tHoraInicio<>NUMERO_INDEFINIDO)and(tHoraFinal=NUMERO_INDEFINIDO))then
    begin
      MessageDlg('Verifique o horário da ligação.', mtInformation, [mbOK], 0);
      compFoco := plsMedHoraLigacaoFinal;
    end
    else if((tHoraInicio=NUMERO_INDEFINIDO)and(tHoraFinal<>NUMERO_INDEFINIDO))then
    begin
      MessageDlg('Verifique o horário da ligação.', mtInformation, [mbOK], 0);
      compFoco := plsMedHoraLigacaoInicio;
    end;
  end;

  //setar foco no componente que não foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    Self.FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

procedure TfrmCadClientePessoaJuridica.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsMedCNPJ.Enabled := True;
                       plsEdEmail.Enabled := False;
                       pnlMeioCaptacao.Enabled := False;
                       grpBxTelefones.Enabled := False;
                       grpBxEndereco.Enabled := False;
                       grpBxHorarioLigacao.Enabled := False;
                       Self.FoFuncoes.focarComponente(plsEdCodigo);
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_CLIENTE_PESSOA_JURIDICA,True));    
                       plsEdCodigo.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsMedCNPJ.Enabled := True;
                       plsEdEmail.Enabled := True;
                       pnlMeioCaptacao.Enabled := True;
                       grpBxTelefones.Enabled := True;
                       grpBxEndereco.Enabled := True;
                       grpBxHorarioLigacao.Enabled := True;
                       Self.FoFuncoes.focarComponente(plsEdNome);
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsMedCNPJ.Enabled := True;
                       plsEdEmail.Enabled := True;
                       pnlMeioCaptacao.Enabled := True;
                       grpBxTelefones.Enabled := True;
                       grpBxEndereco.Enabled := True;
                       grpBxHorarioLigacao.Enabled := True;
                       Self.FoFuncoes.focarComponente(plsEdNome);
                     end;
    OPC_SALVAR:      begin

                     end;
    OPC_EXCLUIR:     begin

                     end;
    OPC_CANCELAR:    begin

                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsMedCNPJ.Enabled := True;
                       plsEdEmail.Enabled := False;
                       pnlMeioCaptacao.Enabled := False;
                       grpBxTelefones.Enabled := False;
                       grpBxEndereco.Enabled := False;
                       grpBxHorarioLigacao.Enabled := False;
                     end;
  end; //fim - case
end;

function TfrmCadClientePessoaJuridica.outrasValidacoesAntesSalvar(): Boolean;
var
  compFoco: TWinControl;
  sCNPJ: String;
  bRetorno: Boolean;
begin
  compFoco := nil;
  bRetorno := True;

  sCNPJ := Self.FoFuncoes.retirarCaracteres(plsMedCNPJ.Text,'./-');
  if(not(sCNPJ=STRING_INDEFINIDO))then
  begin
    if(not(Self.FoFuncoes.validarCNPJ(sCNPJ)))then
    begin
      MessageDlg('CNPJ inválido.',mtWarning,[mbOK],0);
      compFoco := plsMedCNPJ;
      bRetorno := False;
    end;
  end;

  if(bRetorno)then
  begin
    if(Trim(plsEdEmail.Text)<>STRING_INDEFINIDO)then
    begin
      if(not(Self.FoFuncoes.validarEmail(plsEdEmail.Text)))then
      begin
        MessageDlg('Email inválido.',mtWarning,[mbOK],0);
        compFoco := plsEdEmail;
        bRetorno := False;
      end;
    end;
  end;

  if(bRetorno)then
  begin
    if(not(Self.FoFuncoes.retirarCaracteres(plsMedTelefoneResidencial.Text,'()-')=STRING_INDEFINIDO))then
    begin
      if(not(Self.FoFuncoes.validarTelefone(plsMedTelefoneResidencial.Text)))then
      begin
        MessageDlg('Telefone residencial inválido.',mtWarning,[mbOK],0);
        compFoco := plsMedTelefoneResidencial;
        bRetorno := False;
      end;
    end;
  end;

  if(bRetorno)then
  begin
    if(not(Self.FoFuncoes.retirarCaracteres(plsMedTelefoneComercial.Text,'()-')=STRING_INDEFINIDO))then
    begin
      if(not(Self.FoFuncoes.validarTelefone(plsMedTelefoneComercial.Text)))then
      begin
        MessageDlg('Telefone comercial inválido.',mtWarning,[mbOK],0);
        compFoco := plsMedTelefoneComercial;
        bRetorno := False;
      end;
    end;
  end;

  if(bRetorno)then
  begin
    if(not(Self.FoFuncoes.retirarCaracteres(plsMedTelefoneCelular.Text,'()-')=STRING_INDEFINIDO))then
    begin
      if(not(Self.FoFuncoes.validarTelefone(plsMedTelefoneCelular.Text)))then
      begin
        MessageDlg('Telefone celular inválido.',mtWarning,[mbOK],0);
        compFoco := plsMedTelefoneCelular;
        bRetorno := False;
      end;
    end;
  end;

  if(bRetorno)then
  begin
    if(not(Self.FoFuncoes.retirarCaracteres(plsMedHoraLigacaoInicio.Text,':')=STRING_INDEFINIDO))then
    begin
      if(not(Self.FoFuncoes.validarHora(plsMedHoraLigacaoInicio.Text)))then
      begin
        MessageDlg('Horário de início da ligação inválida.',mtWarning,[mbOK],0);
        compFoco := plsMedHoraLigacaoInicio;
        bRetorno := False;
      end;
    end;
  end;

  if(bRetorno)then
  begin
    if(not(Self.FoFuncoes.retirarCaracteres(plsMedHoraLigacaoFinal.Text,':')=STRING_INDEFINIDO))then
    begin
      if(not(Self.FoFuncoes.validarHora(plsMedHoraLigacaoFinal.Text)))then
      begin
        MessageDlg('Horário final da ligação inválida.',mtWarning,[mbOK],0);
        compFoco := plsMedHoraLigacaoFinal;
        bRetorno := False;
      end;
    end;
  end;

  //setar foco no componente que não foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    Self.FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

procedure TfrmCadClientePessoaJuridica.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadClientePessoaJuridica);
  visibilidade(OPC_NOVO);
end;

function TfrmCadClientePessoaJuridica.salvar(): boolean;
var
  bSalvou: boolean;

  sNome,sEmail,sCNPJ: String;
  sTelefoneResidencial,sTelefoneComercial,sTelefoneCelular: String;
  nCodFK_MeioCaptacao,nCodFK_Estado,nCodFK_Cidade,nCodFK_Bairro,nCodFK_Rua: Integer;
  sEnderecoCEP,sEnderecoComplemento,sHoraLigacao: String;
  tHoraLigacaoInicio,tHoraLigacaoFinal: TTime;
  dRendimento: Double;

  procedure carregarValores();
  begin
    sNome := Trim(plsEdNome.Text);
    sEmail := Trim(plsEdEmail.Text);
    sCNPJ := Trim(plsMedCNPJ.Text);
    if(Self.FoFuncoes.retirarCaracteres(plsMedTelefoneResidencial.Text,'()-')<>STRING_INDEFINIDO)then
      sTelefoneResidencial := plsMedTelefoneResidencial.Text
    else
      sTelefoneResidencial := STRING_INDEFINIDO;

    if(Self.FoFuncoes.retirarCaracteres(plsMedTelefoneComercial.Text,'()-')<>STRING_INDEFINIDO)then
      sTelefoneComercial := plsMedTelefoneComercial.Text
    else
      sTelefoneComercial := STRING_INDEFINIDO;

    if(Self.FoFuncoes.retirarCaracteres(plsMedTelefoneCelular.Text,'()-')<>STRING_INDEFINIDO)then
      sTelefoneCelular := plsMedTelefoneComercial.Text
    else
      sTelefoneCelular := STRING_INDEFINIDO;

    if(Self.FoMeioCaptacao.codigo <> NUMERO_INDEFINIDO)then
      nCodFK_MeioCaptacao := Self.FoMeioCaptacao.codigo
    else
      nCodFK_MeioCaptacao := REGISTRO_NULO;

    if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)then
      nCodFK_Estado := Self.FoEstado.codigo
    else
      nCodFK_Estado := REGISTRO_NULO;

    if(Self.FoCidade.codigo <> NUMERO_INDEFINIDO)then
      nCodFK_Cidade := Self.FoCidade.codigo
    else
      nCodFK_Cidade := REGISTRO_NULO;

    if(Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
      nCodFK_Bairro := Self.FoBairro.codigo
    else
      nCodFK_Bairro := REGISTRO_NULO;

    if(Self.FoRua.codigo <> NUMERO_INDEFINIDO)then
      nCodFK_Rua := Self.FoRua.codigo
    else
      nCodFK_Rua := REGISTRO_NULO;

    if(Self.FoFuncoes.retirarCaracteres(plsMedCEP.Text,'-')<>STRING_INDEFINIDO)then
      sEnderecoCEP := plsMedCEP.Text
    else
      sEnderecoCEP := STRING_INDEFINIDO;

    sEnderecoComplemento := Trim(plsMmEnderecoComplemento.Text);
    case plsCbBxPeriodo.ItemIndex of
      0: sHoraLigacao := PESSOA_FISICA_HORARIO_LIGACAO_MANHA;
      1: sHoraLigacao := PESSOA_FISICA_HORARIO_LIGACAO_TARDE;
      2: sHoraLigacao := PESSOA_FISICA_HORARIO_LIGACAO_NOITE;
      3: sHoraLigacao := PESSOA_FISICA_HORARIO_LIGACAO_QUALQUER;
    end;

    if(Self.FoFuncoes.validarHora(plsMedHoraLigacaoInicio.Text))then
      tHoraLigacaoInicio := StrToTime(plsMedHoraLigacaoInicio.Text)
    else
      tHoraLigacaoInicio := NUMERO_INDEFINIDO;

    if(Self.FoFuncoes.validarHora(plsMedHoraLigacaoFinal.Text))then
      tHoraLigacaoFinal := StrToTime(plsMedHoraLigacaoFinal.Text)
    else
      tHoraLigacaoFinal := NUMERO_INDEFINIDO;

      dRendimento := FoFuncoes.formatarValorCurrency(plsMedRendimento.Text);
  end;

  //limpa parâmetro nulos - para o insert e update
  procedure limparParametrosNulos();
  begin
    if(Self.FoFuncoes.verificaCNPJ_EhVazio(sCNPJ))then
      zQryDados.ParamByName('cnpj').Clear;
    if(tHoraLigacaoInicio = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('hor_ini').Clear;
    if(tHoraLigacaoFinal = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('hor_fin').Clear;
  end;

begin
  bSalvou := False;

  carregarValores();

  if(Self.FiFuncaoRegistro in [FUNCAO_REGISTRO_EDITAR, FUNCAO_REGISTRO_NOVO]) then
  begin
    inherited;
    if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR) then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('UPDATE cliente_pessoa_juridica SET nome=:nom,email=:ema,cnpj=:cnpj, ');
        zQryDados.SQL.Add('telefone_residencial=:tel_res,telefone_comercial=:tel_com, ');
        zQryDados.SQL.Add('telefone_celular=:tel_cel,cod_fk_meio_captacao=:cod_fk_mei_cap, ');
        zQryDados.SQL.Add('cod_fk_estado=:cod_fk_est,cod_fk_cidade=:cod_fk_cid,');
        zQryDados.SQL.Add('cod_fk_bairro=:cod_fk_bai,cod_fk_rua=:cod_fk_rua,');
        zQryDados.SQL.Add('endereco_cep=:end_cep,endereco_complemento=:end_com,');
        zQryDados.SQL.Add('horario_ligacao=:hor_lig,hora_inicio=:hor_ini,');
        zQryDados.SQL.Add('hora_final=:hor_fin,rendimento=:ren ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('nom').AsString := sNome;
        zQryDados.ParamByName('ema').AsString := sEmail;
        zQryDados.ParamByName('cnpj').AsString := sCNPJ;
        zQryDados.ParamByName('tel_res').AsString := sTelefoneResidencial;
        zQryDados.ParamByName('tel_com').AsString := sTelefoneComercial;
        zQryDados.ParamByName('tel_cel').AsString := sTelefoneCelular;
        zQryDados.ParamByName('cod_fk_mei_cap').AsInteger := nCodFK_MeioCaptacao;
        zQryDados.ParamByName('cod_fk_est').AsInteger := nCodFK_Estado;
        zQryDados.ParamByName('cod_fk_cid').AsInteger := nCodFK_Cidade;
        zQryDados.ParamByName('cod_fk_bai').AsInteger := nCodFK_Bairro;
        zQryDados.ParamByName('cod_fk_rua').AsInteger := nCodFK_Rua;
        zQryDados.ParamByName('end_cep').AsString := sEnderecoCEP;
        zQryDados.ParamByName('end_com').AsString := sEnderecoComplemento;
        zQryDados.ParamByName('hor_lig').AsString := sHoraLigacao;
        zQryDados.ParamByName('hor_ini').AsTime := tHoraLigacaoInicio;
        zQryDados.ParamByName('hor_fin').AsTime := tHoraLigacaoFinal;
        zQryDados.ParamByName('ren').AsCurrency := dRendimento;
        zQryDados.ParamByName('cod').AsInteger := FoClientePessoaJuridica.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO cliente_pessoa_juridica (nome,email,cnpj,');
        zQryDados.SQL.Add('telefone_residencial,telefone_comercial,telefone_celular,');
        zQryDados.SQL.Add('cod_fk_meio_captacao,cod_fk_estado,cod_fk_cidade,');
        zQryDados.SQL.Add('cod_fk_bairro,cod_fk_rua,endereco_cep,endereco_complemento,');
        zQryDados.SQL.Add('horario_ligacao,hora_inicio,hora_final,rendimento) ');
        zQryDados.SQL.Add('VALUES (:nom,:ema,:cnpj,:tel_res,:tel_com,:tel_cel,');
        zQryDados.SQL.Add(':cod_fk_mei_cap,:cod_fk_est,:cod_fk_cid,:cod_fk_bai,');
        zQryDados.SQL.Add(':cod_fk_rua,:end_cep,:end_com,:hor_lig,:hor_ini,:hor_fin,:ren)');
        zQryDados.ParamByName('nom').AsString := sNome;
        zQryDados.ParamByName('ema').AsString := sEmail;
        zQryDados.ParamByName('cnpj').AsString := sCNPJ;
        zQryDados.ParamByName('tel_res').AsString := sTelefoneResidencial;
        zQryDados.ParamByName('tel_com').AsString := sTelefoneComercial;
        zQryDados.ParamByName('tel_cel').AsString := sTelefoneCelular;
        zQryDados.ParamByName('cod_fk_mei_cap').AsInteger := nCodFK_MeioCaptacao;
        zQryDados.ParamByName('cod_fk_est').AsInteger := nCodFK_Estado;
        zQryDados.ParamByName('cod_fk_cid').AsInteger := nCodFK_Cidade;
        zQryDados.ParamByName('cod_fk_bai').AsInteger := nCodFK_Bairro;
        zQryDados.ParamByName('cod_fk_rua').AsInteger := nCodFK_Rua;
        zQryDados.ParamByName('end_cep').AsString := sEnderecoCEP;
        zQryDados.ParamByName('end_com').AsString := sEnderecoComplemento;
        zQryDados.ParamByName('hor_lig').AsString := sHoraLigacao;
        zQryDados.ParamByName('hor_ini').AsTime := tHoraLigacaoInicio;
        zQryDados.ParamByName('hor_fin').AsTime := tHoraLigacaoFinal;
        zQryDados.ParamByName('ren').AsCurrency := dRendimento;        
        limparParametrosNulos();
        zQryDados.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
        Self.verificarInseriuChamadaTelaExterna();
      except
        DM.ZConnection.Rollback;
      end;
    end;
  end;

  if((bSalvou)and(not(FbChamadaExternaInserirRegistro)))and
    (not(Self.FbChamadaExternaEditarRegistro))then
    Self.FoPesquisa.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS,null);

  Result := bSalvou;
end;

procedure TfrmCadClientePessoaJuridica.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
  sNome: String;
  vParametros: Variant;
begin
  nCodigo := NUMERO_INDEFINIDO;
  sNome := STRING_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    DM.zQryClientePessoaJuridica.Close;
    DM.zQryClientePessoaJuridica.SQL.Clear;
    DM.zQryClientePessoaJuridica.SQL.Add('SELECT * FROM cliente_pessoa_juridica ORDER BY codigo DESC ROWS 1');
    DM.zQryClientePessoaJuridica.Open;
    if(DM.zQryClientePessoaJuridica.RecordCount = 1)then
      nCodigo := DM.zQryClientePessoaJuridicaCODIGO.AsInteger
    else
      nCodigo := NUMERO_INDEFINIDO;

    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_CLIENTE_PESSOA_JURIDICA)then
    begin
      frmSelecionaRegistroClientePessoaJuridica.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end

  else if(Self.FbChamadaExternaEditarRegistro)then
  begin
    DM.zQryClientePessoaJuridica.Close;
    DM.zQryClientePessoaJuridica.SQL.Clear;
    DM.zQryClientePessoaJuridica.SQL.Add('SELECT * FROM cliente_pessoa_juridica ');
    DM.zQryClientePessoaJuridica.SQL.Add('WHERE codigo=:codigo');
    DM.zQryClientePessoaJuridica.ParamByName('codigo').AsInteger := FoClientePessoaJuridica.getCodigo;
    DM.zQryClientePessoaJuridica.Open;
    if(DM.zQryClientePessoaJuridica.RecordCount = 1)then
    begin
      nCodigo := DM.zQryClientePessoaJuridicaCODIGO.AsInteger;
      sNome := DM.zQryClientePessoaJuridicaNOME.AsString;
    end;

(*    if(Self.FiTelaExternaChamouEditarRegistro = FORM_CAD_AGENCIAMENTOS)then
    begin
      vParametros := VarArrayCreate([0,2], varVariant);
      vParametros[0] := nCodigo;
      vParametros[1] := sNome;
      vParametros[2] := EDITOU_PESSOA;
      frmCadAgenciamento.passarParametro(PRM_EDITOU_REGISTRO_AGENCIAMENTO_STAND_BY,vParametros);
      Self.Close;
      Exit;
    end;
  *)end;
end;

function TfrmCadClientePessoaJuridica.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM cliente_pessoa_juridica WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := FoClientePessoaJuridica.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  if(bDeletou)then
    Self.FoPesquisa.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS,null);

  Result := bDeletou;
end;

function TfrmCadClientePessoaJuridica.verificarRegistroJaExiste(): boolean;
var
  bRetorno: Boolean;
begin
  bRetorno := False;

  //nome,cnpj,estado e cidade iguais
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM cliente_pessoa_juridica WHERE nome=:nom AND cnpj=:cnpj ');
  zQryDados.SQL.Add('AND cod_fk_estado=:cod_fk_est AND cod_fk_cidade=:cod_fk_cid');
  //se estiver editando, pode salvar com os mesmos dados
  if(FoClientePessoaJuridica.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := FoClientePessoaJuridica.getCodigo;
  end;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.ParamByName('cnpj').AsString := Trim(plsMedCNPJ.Text);
  zQryDados.ParamByName('cod_fk_est').AsInteger := Self.FoEstado.codigo;
  zQryDados.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.codigo;
  zQryDados.Open;

  if(zQryDados.RecordCount <> 0)then
  begin
    bRetorno := True;
    MessageDlg('Pessoa Jurídica já cadastrada.', mtWarning, [mbOK], 0);
  end
  else
  begin
    //cnpj igual
    if(Self.FoFuncoes.retirarCaracteres(plsMedCNPJ.Text,'./-')<>STRING_INDEFINIDO)then
    begin
      if(Self.FoFuncoes.validarCNPJ(plsMedCNPJ.Text))then
      begin
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('SELECT * FROM cliente_pessoa_juridica WHERE cnpj=:cnpj ');
        //se estiver editando, pode salvar com os mesmos dados
        if(FoClientePessoaJuridica.getCodigo <> NUMERO_INDEFINIDO)then
        begin
          zQryDados.SQL.Add(' AND codigo <> :cod');
          zQryDados.ParamByName('cod').AsInteger := FoClientePessoaJuridica.getCodigo;
        end;
        zQryDados.ParamByName('cnpj').AsString := Trim(plsMedCNPJ.Text);
        zQryDados.Open;

        if(zQryDados.RecordCount <> 0)then
        begin
          bRetorno := True;
          MessageDlg('Pessoa Jurídica com este CNPJ já cadastrado.', mtWarning, [mbOK], 0);
        end;
      end;
    end;
  end;

  Result := bRetorno;
end;

function TfrmCadClientePessoaJuridica.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  Result := bPodeDeletar;
end;

procedure TfrmCadClientePessoaJuridica.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

//limpa os campos do endereço, a partir daquele que alterou
procedure TfrmCadClientePessoaJuridica.limparEndereco(iEnderecoChamou: String);
  procedure limparEstado();
  begin
    plsEdEstado.Clear;
    Self.FoEstado.codigo := NUMERO_INDEFINIDO;
    Self.FoEstado.nome := STRING_INDEFINIDO;
  end;
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
    plsMedCEP.Clear;
    Self.FoRua.codigo := NUMERO_INDEFINIDO;
    Self.FoRua.nome := STRING_INDEFINIDO;
    Self.FoRua.cep := STRING_INDEFINIDO;
  end;

begin
  if(Self.FbPodeLimparEndereco)then
  begin
    if(iEnderecoChamou = 'ESTADO')then
    begin
      limparEstado();
      limparCidade();
      limparBairro();
      limparRua();
    end
    else if(iEnderecoChamou = 'CIDADE')then
    begin
      limparCidade();
      limparBairro();
      limparRua();
    end
    else if(iEnderecoChamou = 'BAIRRO')then
    begin
      limparBairro();
      limparRua();
    end
    else if(iEnderecoChamou = 'RUA')then
    begin
      limparRua();
    end;
  end;

  Self.FbPodeLimparEndereco := True;
end;

//valida se o acesso ao endereço pode ser realizado
function TfrmCadClientePessoaJuridica.validarAcessoEndereco(iEnderecoChamou: String): boolean;
var
  bAcesso: Boolean;
begin
  bAcesso := False;

  if(iEnderecoChamou = 'CIDADE')then
  begin
    if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)then
      bAcesso := True;
  end
  else if(iEnderecoChamou = 'BAIRRO')then
  begin
    if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)and(Self.FoCidade.codigo <> NUMERO_INDEFINIDO)then
      bAcesso := True;
  end
  else if(iEnderecoChamou = 'RUA')then
  begin
    if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)and(Self.FoCidade.codigo <> NUMERO_INDEFINIDO)and
      (Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
      bAcesso := True;
  end;

  Result := bAcesso;
end;

procedure TfrmCadClientePessoaJuridica.editarRegistroChamadaExterna();

  procedure pesquisarRegistro();
  begin
    cdsDados.Close;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('SELECT * FROM cliente_pessoa_juridica WHERE codigo=:cod');
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
    MessageDlg('Erro ao pesquisar por cliente ao editar agenciamento stand by.', mtWarning, [mbOK], 0);
  end;
end;


procedure TfrmCadClientePessoaJuridica.AbreTelaSelecaoMeioCaptacao(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdMeioCaptacao.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_MEIO_CAPTACAO_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroMeioCaptacao, frmSelecionaRegistroMeioCaptacao);
        //frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_INICIAR_TELA, null);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE_PESSOA_JURIDICA);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdMeioCaptacao.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadClientePessoaJuridica,frmSelecionaRegistroMeioCaptacao,pnlMeioCaptacao,ToolBar);
        frmSelecionaRegistroMeioCaptacao.ShowModal;
      finally
        if(Self.FoMeioCaptacao.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdMeioCaptacao.Text := Self.FoMeioCaptacao.nome;
          Self.FoFuncoes.focarComponente(plsMedTelefoneResidencial);
        end;
        FreeAndNil(frmSelecionaRegistroMeioCaptacao);
      end;
    end;

    fnSELECIONAR_MEIO_CAPTACAO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroMeioCaptacao, frmSelecionaRegistroMeioCaptacao);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE_PESSOA_JURIDICA);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadClientePessoaJuridica,frmSelecionaRegistroMeioCaptacao,pnlMeioCaptacao,ToolBar);
        frmSelecionaRegistroMeioCaptacao.ShowModal;
      finally
        if(Self.FoMeioCaptacao.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdMeioCaptacao.Text := Self.FoMeioCaptacao.nome;
          Self.FoFuncoes.focarComponente(plsMedTelefoneResidencial);
        end
        else
          plsEdMeioCaptacao.Clear;
        FreeAndNil(frmSelecionaRegistroMeioCaptacao);
      end;
    end;

  end;

end;

procedure TfrmCadClientePessoaJuridica.VerificarMeioCaptacaoExiste();
begin
  if(Trim(plsEdMeioCaptacao.Text) <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosMeioCaptacao.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdMeioCaptacao.Text + '%'));
    FoConjuntoDadosMeioCaptacao.ExecutarFiltrar();

    if(FoConjuntoDadosMeioCaptacao.TotalRegistros = 1)then
    begin
      FoMeioCaptacao.codigo := FoConjuntoDadosMeioCaptacao.GetCodigo;
      FoMeioCaptacao.nome := FoConjuntoDadosMeioCaptacao.GetNome;
      plsEdMeioCaptacao.Text := FoMeioCaptacao.nome;
    end
    else if(FoConjuntoDadosMeioCaptacao.TotalRegistros > 1)then
      AbreTelaSelecaoMeioCaptacao(fnSELECIONAR_MEIO_CAPTACAO_DIGITANDO)
    else
    begin
      MessageDlg('Meio de Captação não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdMeioCaptacao);
    end;
  end
  else
  begin
    plsEdMeioCaptacao.Clear;
    FoMeioCaptacao.codigo := NUMERO_INDEFINIDO;
    FoMeioCaptacao.nome := STRING_INDEFINIDO;
  end;
end;

procedure TfrmCadClientePessoaJuridica.AbreTelaSelecaoEstado(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdEstado.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_ESTADO_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroEstado, frmSelecionaRegistroEstado);
        frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE_PESSOA_JURIDICA);
        frmSelecionaRegistroEstado.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdEstado.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroEstado.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroEstado.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadClientePessoaJuridica,frmSelecionaRegistroEstado,pnlEstado,ToolBar,grpBxEndereco);
        frmSelecionaRegistroEstado.ShowModal;
      finally
        if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdEstado.Text := Self.FoEstado.nome;
          limparEndereco('CIDADE');
          Self.FoFuncoes.focarComponente(plsEdCidade);
        end;
        FreeAndNil(frmSelecionaRegistroEstado);
      end;
    end;

    fnSELECIONAR_ESTADO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroEstado, frmSelecionaRegistroEstado);
        frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE_PESSOA_JURIDICA);
        frmSelecionaRegistroEstado.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroEstado.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroEstado.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadClientePessoaJuridica,frmSelecionaRegistroEstado,pnlEstado,ToolBar,grpBxEndereco);
        frmSelecionaRegistroEstado.ShowModal;
      finally
        if(Self.FoEstado.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdEstado.Text := Self.FoEstado.nome;
          limparEndereco('CIDADE');
          Self.FoFuncoes.focarComponente(plsEdCidade);
        end
        else
          plsEdEstado.Clear;
        FreeAndNil(frmSelecionaRegistroEstado);
      end;
    end;

  end;

end;


procedure TfrmCadClientePessoaJuridica.VerificarEstadoExiste();
begin
  if(Trim(plsEdEstado.Text) <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosEstado.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdEstado.Text + '%'));
    FoConjuntoDadosEstado.ExecutarFiltrar();

    if(FoConjuntoDadosEstado.TotalRegistros = 1)then
    begin
      FoEstado.codigo := FoConjuntoDadosEstado.GetCodigo;
      FoEstado.nome := FoConjuntoDadosEstado.GetNome;
      plsEdEstado.Text := FoEstado.nome;
    end
    else if(FoConjuntoDadosEstado.TotalRegistros > 1)then
      AbreTelaSelecaoEstado(fnSELECIONAR_ESTADO_DIGITANDO)
    else
    begin
      MessageDlg('Estado não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdEstado);
    end;
  end
  else
    limparEndereco('ESTADO');
end;

procedure TfrmCadClientePessoaJuridica.AbreTelaSelecaoCidade(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdCidade.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_CIDADE_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroCidade, frmSelecionaRegistroCidade);
        frmSelecionaRegistroCidade.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE_PESSOA_JURIDICA);
        frmSelecionaRegistroCidade.passarParametro('FK_COD_ESTADO', Self.FoEstado.codigo);
        frmSelecionaRegistroCidade.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroCidade.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroCidade.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadClientePessoaJuridica,frmSelecionaRegistroCidade,pnlCidade,ToolBar,grpBxEndereco);
        frmSelecionaRegistroCidade.ShowModal;
      finally
        if(FoCidade.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdCidade.Text := FoCidade.nome;
          limparEndereco('BAIRRO');
          Self.FoFuncoes.focarComponente(plsEdBairro);
        end;
        FreeAndNil(frmSelecionaRegistroCidade);
      end;
    end;

    fnSELECIONAR_CIDADE_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroCidade, frmSelecionaRegistroCidade);
        frmSelecionaRegistroCidade.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE_PESSOA_JURIDICA);
        frmSelecionaRegistroCidade.passarParametro('FK_COD_ESTADO', Self.FoEstado.codigo);
        frmSelecionaRegistroCidade.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroCidade.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroCidade.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadClientePessoaJuridica,frmSelecionaRegistroCidade,pnlCidade,ToolBar,grpBxEndereco);
        frmSelecionaRegistroCidade.ShowModal;
      finally
        if(Self.FoCidade.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdCidade.Text := Self.FoCidade.nome;
          limparEndereco('BAIRRO');
          Self.FoFuncoes.focarComponente(plsEdBairro);
        end
        else
          plsEdCidade.Clear;
        FreeAndNil(frmSelecionaRegistroCidade);
      end;
    end;

  end;

end;


procedure TfrmCadClientePessoaJuridica.VerificarCidadeExiste();
var
  sFiltro: String;
begin
  sFiltro := '(nome ' + ' LIKE ' + QuotedStr('%' + plsEdCidade.Text + '%') + ')';
  sFiltro := sFiltro + ' AND cod_fk_estado = ' + QuotedStr(IntToStr(FoEstado.codigo));
  if(Trim(plsEdCidade.Text) <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosCidade.SetFiltro(sFiltro);
    FoConjuntoDadosCidade.ExecutarFiltrar();

    if(FoConjuntoDadosCidade.TotalRegistros = 1)then
    begin
      FoCidade.codigo := FoConjuntoDadosCidade.GetCodigo;
      FoCidade.nome := FoConjuntoDadosCidade.GetNome;
      plsEdCidade.Text := FoCidade.nome;
    end
    else if(FoConjuntoDadosCidade.TotalRegistros > 1)then
      AbreTelaSelecaoCidade(fnSELECIONAR_CIDADE_DIGITANDO)
    else
    begin
      MessageDlg('Cidade não encontrada.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdCidade);
    end;
  end
  else
    limparEndereco('CIDADE');
end;


procedure TfrmCadClientePessoaJuridica.AbreTelaSelecaoBairro(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdBairro.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_BAIRRO_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
        frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE_PESSOA_JURIDICA);
        frmSelecionaRegistroBairro.passarParametro('FK_COD_CIDADE', Self.FoCidade.codigo);
        frmSelecionaRegistroBairro.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdBairro.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroBairro.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroBairro.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadClientePessoaJuridica,frmSelecionaRegistroBairro,pnlBairro,ToolBar,grpBxEndereco);
        frmSelecionaRegistroBairro.ShowModal;
      finally
        if(FoBairro.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdBairro.Text := FoBairro.nome;
          limparEndereco('RUA');
          Self.FoFuncoes.focarComponente(plsEdRua);
        end;
        FreeAndNil(frmSelecionaRegistroBairro);
      end;
    end;

    fnSELECIONAR_BAIRRO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
        frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE_PESSOA_JURIDICA);
        frmSelecionaRegistroBairro.passarParametro('FK_COD_CIDADE', Self.FoCidade.codigo);
        frmSelecionaRegistroBairro.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroBairro.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroBairro.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadClientePessoaJuridica,frmSelecionaRegistroBairro,pnlBairro,ToolBar,grpBxEndereco);
        frmSelecionaRegistroBairro.ShowModal;
      finally
        if(Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdBairro.Text := Self.FoBairro.nome;
          limparEndereco('RUA');
          Self.FoFuncoes.focarComponente(plsEdRua);
        end
        else
          plsEdBairro.Clear;
        FreeAndNil(frmSelecionaRegistroBairro);
      end;
    end;

  end;

end;

procedure TfrmCadClientePessoaJuridica.VerificarBairroExiste();
var
  sFiltro: String;
begin
  sFiltro := '(nome ' + ' LIKE ' + QuotedStr('%' + plsEdBairro.Text + '%') + ')';
  sFiltro := sFiltro + ' AND cod_fk_cidade = ' + QuotedStr(IntToStr(FoCidade.codigo));
  if(Trim(plsEdBairro.Text) <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosBairro.SetFiltro(sFiltro);
    FoConjuntoDadosBairro.ExecutarFiltrar();

    if(FoConjuntoDadosBairro.TotalRegistros = 1)then
    begin
      FoBairro.codigo := FoConjuntoDadosBairro.GetCodigo;
      FoBairro.nome := FoConjuntoDadosBairro.GetNome;
      plsEdBairro.Text := FoBairro.nome;
    end
    else if(FoConjuntoDadosBairro.TotalRegistros > 1)then
      AbreTelaSelecaoBairro(fnSELECIONAR_BAIRRO_DIGITANDO)
    else
    begin
      MessageDlg('Bairro não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdBairro);
    end;
  end
  else
    limparEndereco('BAIRRO');
end;


procedure TfrmCadClientePessoaJuridica.AbreTelaSelecaoRua(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdRua.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_RUA_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroRua, frmSelecionaRegistroRua);
        frmSelecionaRegistroRua.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE_PESSOA_JURIDICA);
        frmSelecionaRegistroRua.passarParametro('FK_COD_BAIRRO', Self.FoBairro.codigo);
        frmSelecionaRegistroRua.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdRua.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroRua.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroRua.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadClientePessoaJuridica,frmSelecionaRegistroRua,pnlRua,ToolBar,grpBxEndereco);
        frmSelecionaRegistroRua.ShowModal;
      finally
        if(FoRua.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdRua.Text := Self.FoRua.nome;
          plsMedCEP.Text := Self.FoRua.cep;
          Self.FoFuncoes.focarComponente(plsMmEnderecoComplemento);
        end;
        FreeAndNil(frmSelecionaRegistroRua);
      end;
    end;

    fnSELECIONAR_RUA_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroRua, frmSelecionaRegistroRua);
        frmSelecionaRegistroRua.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE_PESSOA_JURIDICA);
        frmSelecionaRegistroRua.passarParametro('FK_COD_BAIRRO', Self.FoBairro.codigo);
        frmSelecionaRegistroRua.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroRua.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroRua.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadClientePessoaJuridica,frmSelecionaRegistroRua,pnlRua,ToolBar,grpBxEndereco);
        frmSelecionaRegistroRua.ShowModal;
      finally
        if(FoRua.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdRua.Text := Self.FoRua.nome;
          plsMedCEP.Text := Self.FoRua.cep;
          Self.FoFuncoes.focarComponente(plsMmEnderecoComplemento);
        end
        else
          plsEdRua.Clear;
        FreeAndNil(frmSelecionaRegistroRua);
      end;
    end;

  end;

end;

procedure TfrmCadClientePessoaJuridica.VerificarRuaExiste();
var
  sFiltro: String;
begin
  sFiltro := '(nome ' + ' LIKE ' + QuotedStr('%' + plsEdRua.Text + '%') + ')';
  sFiltro := sFiltro + ' AND cod_fk_bairro = ' + QuotedStr(IntToStr(FoBairro.codigo));

  if(Trim(plsEdRua.Text) <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosRua.SetFiltro(sFiltro);
    FoConjuntoDadosRua.ExecutarFiltrar();

    if(FoConjuntoDadosRua.TotalRegistros = 1)then
    begin
      FoRua.codigo := FoConjuntoDadosRua.GetCodigo;
      FoRua.nome := FoConjuntoDadosRua.GetNome;
      FoRua.cep := FoConjuntoDadosRua.GetCEP;
      plsEdRua.Text := FoRua.nome;
      plsMedCEP.Text := FoRua.cep;
    end
    else if(FoConjuntoDadosRua.TotalRegistros > 1)then
      AbreTelaSelecaoRua(fnSELECIONAR_RUA_DIGITANDO)
    else
    begin
      MessageDlg('Rua não encontrada.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdRua);
    end;
  end
  else
    limparEndereco('RUA');
end;


(* fim - procedimentos de controle *)

procedure TfrmCadClientePessoaJuridica.FormCreate(Sender: TObject);
begin
  inherited;
  FoClientePessoaJuridica := TObjClientePessoaJuridica.Create;
  FoConjuntoDadosMeioCaptacao := TConjuntoDadosMeioCaptacao.CriaObjeto;
  FoConjuntoDadosEstado := TConjuntoDadosEstado.CriaObjeto;
  FoConjuntoDadosCidade := TConjuntoDadosCidade.CriaObjeto;
  FoConjuntoDadosBairro := TConjuntoDadosBairro.CriaObjeto;
  FoConjuntoDadosRua := TConjuntoDadosRua.CriaObjeto;
  FnCodigoEditar := NUMERO_INDEFINIDO;
  FbPodeLimparEndereco := True;
end;

procedure TfrmCadClientePessoaJuridica.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FoClientePessoaJuridica);
  FreeAndNil(FoConjuntoDadosMeioCaptacao);
  FreeAndNil(FoConjuntoDadosEstado);
  FreeAndNil(FoConjuntoDadosCidade);
  FreeAndNil(FoConjuntoDadosBairro);
  FreeAndNil(FoConjuntoDadosRua);
end;

procedure TfrmCadClientePessoaJuridica.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadClientePessoaJuridica.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadClientePessoaJuridica.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadClientePessoaJuridica.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadClientePessoaJuridica.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadClientePessoaJuridica.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadClientePessoaJuridica.plsEdCodigoExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadClientePessoaJuridica.plsEdCodigoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  sValor: string;
  vParametros: Variant;
begin
  inherited;
  if(Self.FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[numeros],False))then
  begin
    if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
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
        {vParametros[0] = parâmetro do campo da pesquisa
        vParametros[1] = campo da pesquisa
        vParametros[1] = valor da pesquisa
        }
        vParametros[0] := PRM_PESQUISA_CODIGO;
        vParametros[1] := 'CC_CODIGO';
        vParametros[2] := sValor;
        Self.FoPesquisa.passarParametro(PRM_PESQUISAR_REGISTRO, vParametros);
        if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
          Self.FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;


procedure TfrmCadClientePessoaJuridica.plsEdNomeExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadClientePessoaJuridica.plsEdNomeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  sValor: string;
  vParametros: Variant;
begin
  inherited;
  if(Self.FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[todas],False))then
  begin
    if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
    begin
      if(Key=27)then //esc
      begin
        if(Assigned(Self.FoPesquisa))then
          Self.FoPesquisa.Hide;
      end
      else
      begin
        sValor := plsEdNome.Text;
        vParametros := VarArrayCreate([0,2],varVariant);
        {vParametros[0] = parâmetro do campo da pesquisa
        vParametros[1] = campo da pesquisa
        vParametros[1] = valor da pesquisa
         }
        vParametros[0] := PRM_PESQUISA_NOME;
        vParametros[1] := 'NOME';
        vParametros[2] := sValor;
        Self.FoPesquisa.passarParametro(PRM_PESQUISAR_REGISTRO, vParametros);
        if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
          Self.FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadClientePessoaJuridica.plsMedCNPJExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadClientePessoaJuridica.plsMedCNPJKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  sValor: string;
  vParametros: Variant;
begin
  inherited;
  if(Self.FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[numeros],False))then
  begin
    if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
    begin
      if(Key=27)then //esc
      begin
        if(Assigned(Self.FoPesquisa))then
          Self.FoPesquisa.Hide;
      end
      else
      begin
        sValor := Self.FoFuncoes.retirarCaracteres(plsMedCNPJ.Text,'./-');
        sValor := Self.FoFuncoes.formatarCNPJ(sValor);
        vParametros := VarArrayCreate([0,2],varVariant);
        {vParametros[0] = parâmetro do campo da pesquisa
        vParametros[1] = campo da pesquisa
        vParametros[1] = valor da pesquisa
         }
        vParametros[0] := PRM_PESQUISA_CNPJ;
        vParametros[1] := 'CNPJ';
        vParametros[2] := sValor;
        Self.FoPesquisa.passarParametro(PRM_PESQUISAR_REGISTRO, vParametros);
        if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
          Self.FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadClientePessoaJuridica.spBtnBuscaEstadoClick(
  Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoEstado(fnSELECIONAR_ESTADO_NORMAL);
end;

procedure TfrmCadClientePessoaJuridica.spBtnBuscaCidadeClick(
  Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('CIDADE'))then
    MessageDlg('Um estado deve estar selecionado.', mtInformation, [mbOK], 0)
  else
    AbreTelaSelecaoCidade(fnSELECIONAR_CIDADE_NORMAL);
end;

procedure TfrmCadClientePessoaJuridica.spBtnBuscaBairroClick(
  Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('BAIRRO'))then
  begin
    MessageDlg('Uma cidade deve estar selecionada.', mtInformation, [mbOK], 0);
    FoFuncoes.focarComponente(plsEdCidade);
  end
  else
    AbreTelaSelecaoBairro(fnSELECIONAR_BAIRRO_NORMAL);
end;

procedure TfrmCadClientePessoaJuridica.spBtnBuscaRuaClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('RUA'))then
    MessageDlg('Um bairro deve estar selecionado.', mtInformation, [mbOK], 0)
  else
    AbreTelaSelecaoRua(fnSELECIONAR_RUA_NORMAL);
end;

procedure TfrmCadClientePessoaJuridica.spBtnBuscaMeioCaptacaoClick(
  Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoMeioCaptacao(fnSELECIONAR_MEIO_CAPTACAO_NORMAL);
end;

procedure TfrmCadClientePessoaJuridica.FormShow(Sender: TObject);
begin
  if(FbChamadaExternaEditarRegistro)then
  begin
    Self.editarRegistroChamadaExterna();
  end
  else
    inherited;
end;

procedure TfrmCadClientePessoaJuridica.plsEdMeioCaptacaoExit(
  Sender: TObject);
begin
  inherited;
  VerificarMeioCaptacaoExiste();
end;

procedure TfrmCadClientePessoaJuridica.plsEdEstadoExit(Sender: TObject);
begin
  inherited;
  VerificarEstadoExiste();
end;

procedure TfrmCadClientePessoaJuridica.plsEdCidadeExit(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('CIDADE'))then
  begin
    if(Trim(plsEdCidade.Text) <> STRING_INDEFINIDO)then
    begin
      MessageDlg('Um estado deve estar selecionado.', mtInformation, [mbOK], 0);
      plsEdCidade.Clear;
      FoFuncoes.focarComponente(plsEdEstado);
    end;
  end
  else
    VerificarCidadeExiste();
end;

procedure TfrmCadClientePessoaJuridica.plsEdBairroExit(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('BAIRRO'))then
  begin
    if(Trim(plsEdBairro.Text) <> STRING_INDEFINIDO)then
    begin
      MessageDlg('Uma cidade deve estar selecionada.', mtInformation, [mbOK], 0);
      plsEdBairro.Clear;
      FoFuncoes.focarComponente(plsEdCidade);
    end;
  end
  else
    VerificarBairroExiste();
end;

procedure TfrmCadClientePessoaJuridica.plsEdRuaExit(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('RUA'))then
  begin
    if(Trim(plsEdRua.Text) <> STRING_INDEFINIDO)then
    begin
      MessageDlg('Um bairro deve estar selecionado.', mtInformation, [mbOK], 0);
      plsEdRua.Clear;
      FoFuncoes.focarComponente(plsEdBairro);
    end;
  end
  else
    VerificarRuaExiste();
end;

procedure TfrmCadClientePessoaJuridica.plsCbBxPeriodoEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente',True,2);
end;

procedure TfrmCadClientePessoaJuridica.plsCbBxPeriodoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente',True,2);
end;

procedure TfrmCadClientePessoaJuridica.plsEdCodigoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Cliente pelo Código',STRING_INDEFINIDO);
end;

procedure TfrmCadClientePessoaJuridica.plsEdCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Cliente pelo Código',STRING_INDEFINIDO);
end;

procedure TfrmCadClientePessoaJuridica.plsEdNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Cliente pelo Nome', 'Nome do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsEdNomeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Cliente pelo Nome', 'Nome do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedCNPJEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Cliente pelo CNPJ', 'CNPJ do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedCNPJKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Cliente pelo CNPJ', 'CNPJ do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsEdEmailKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'E-mail do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsEdEmailEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'E-mail do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedRendimentoEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Rendimento do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedRendimentoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Rendimento do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsEdMeioCaptacaoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Meio de Captação do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsEdMeioCaptacaoEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Meio de Captação do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedTelefoneResidencialEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Residencial do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedTelefoneResidencialKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Residencial do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedTelefoneComercialKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Comercial do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedTelefoneComercialEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Comercial do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedTelefoneCelularEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Celular do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedTelefoneCelularKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Celular do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsEdEstadoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Estado do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsEdEstadoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Estado do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsEdCidadeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Cidade do Cliente',False);
end;

procedure TfrmCadClientePessoaJuridica.plsEdCidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Cidade do Cliente',False);
end;

procedure TfrmCadClientePessoaJuridica.plsEdBairroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Bairro do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsEdBairroEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Bairro do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsEdRuaEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Rua do Cliente',False);
end;

procedure TfrmCadClientePessoaJuridica.plsEdRuaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Rua do Cliente',False);
end;

procedure TfrmCadClientePessoaJuridica.plsMedCEPKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'CEP da Rua do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedCEPEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'CEP da Rua do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMmEnderecoComplementoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Complemento do Endereço do Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedHoraLigacaoInicioKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedHoraLigacaoInicioEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedHoraLigacaoFinalEnter(
  Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente');
end;

procedure TfrmCadClientePessoaJuridica.plsMedHoraLigacaoFinalKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente');
end;

end.
