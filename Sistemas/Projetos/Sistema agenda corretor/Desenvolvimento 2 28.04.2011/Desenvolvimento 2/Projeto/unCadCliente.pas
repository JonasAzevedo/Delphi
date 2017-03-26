(*
  cliente - pessoa física
*)
unit unCadCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, ComCtrls, ToolWin,
  StdCtrls, plsMemo, Buttons, Mask, plsTMaskEdit, plsEdit, unObjCliente,
  ExtCtrls, plsComboBox,
  unConjuntoDadosMeioCaptacao, unConjuntoDadosProfissao,unConjuntoDadosEstado,
  unConjuntoDadosCidade, unConjuntoDadosBairro, unConjuntoDadosRua;

  type
    TProfissao = record
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
    TMeioCaptacao = record
      codigo: Integer;
      nome: string[50];
    end;

type
  TfrmCadCliente = class(TfrmCadastroBasico)
    Label1: TLabel;
    plsEdCodigo: TPlsEdit;
    plsEdNome: TPlsEdit;
    Label2: TLabel;
    plsMedDataCaptacao: TPlsMaskEdit;
    lblDataCaptacao: TLabel;
    grpBxEndereco: TGroupBox;
    plsMedCEP: TPlsMaskEdit;
    lblCEP: TLabel;
    lblComplemento: TLabel;
    plsMmEnderecoComplemento: TPlsMemo;
    lblEmail: TLabel;
    plsEdEmail: TPlsEdit;
    grpBxTelefones: TGroupBox;
    lblResidencial: TLabel;
    lblComercial: TLabel;
    lblCelular: TLabel;
    plsMedTelefoneResidencial: TPlsMaskEdit;
    plsMedTelefoneComercial: TPlsMaskEdit;
    plsMedTelefoneCelular: TPlsMaskEdit;
    lblCPF: TLabel;
    lblIdentidade: TLabel;
    lblDataNascimento: TLabel;
    plsEdIdentidade: TPlsEdit;
    plsMedDataNascimento: TPlsMaskEdit;
    plsMedCPF: TPlsMaskEdit;
    pnlProfissao: TPanel;
    lblProfissao: TLabel;
    plsEdProfissao: TPlsEdit;
    spBtnBuscaProfissao: TSpeedButton;
    grpBxHorarioLigacao: TGroupBox;
    lblPeriodo: TLabel;
    lblDas: TLabel;
    lblAs: TLabel;
    plsCbBxPeriodo: TPlsComboBox;
    plsMedHoraLigacaoFinal: TPlsMaskEdit;
    plsMedHoraLigacaoInicio: TPlsMaskEdit;
    pnlMeioCaptacao: TPanel;
    lblMeioCaptacao: TLabel;
    spBtnBuscaMeioCaptacao: TSpeedButton;
    lblCampoObrigatorio3: TLabel;
    plsEdMeioCaptacao: TPlsEdit;
    lblCampoObrigatorio1: TLabel;
    lblCampoObrigatorio2: TLabel;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosDATA_CAPTACAO: TDateField;
    zQryDadosCOD_FK_PROFISSAO: TIntegerField;
    zQryDadosCOD_FK_MEIO_CAPTACAO: TIntegerField;
    zQryDadosCOD_FK_ESTADO: TIntegerField;
    zQryDadosCOD_FK_CIDADE: TIntegerField;
    zQryDadosCOD_FK_BAIRRO: TIntegerField;
    zQryDadosCOD_FK_RUA: TIntegerField;
    zQryDadosENDERECO_CEP: TStringField;
    zQryDadosENDERECO_COMPLEMENTO: TStringField;
    zQryDadosNOME: TStringField;
    zQryDadosEMAIL: TStringField;
    zQryDadosTELEFONE_RESIDENCIAL: TStringField;
    zQryDadosTELEFONE_COMERCIAL: TStringField;
    zQryDadosTELEFONE_CELULAR: TStringField;
    zQryDadosCPF: TStringField;
    zQryDadosIDENTIDADE: TStringField;
    zQryDadosDATA_NASCIMENTO: TDateField;
    zQryDadosHORARIO_LIGACAO: TStringField;
    zQryDadosHORA_INICIO: TTimeField;
    zQryDadosHORA_FINAL: TTimeField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosDATA_CAPTACAO: TDateField;
    cdsDadosCOD_FK_PROFISSAO: TIntegerField;
    cdsDadosCOD_FK_MEIO_CAPTACAO: TIntegerField;
    cdsDadosCOD_FK_ESTADO: TIntegerField;
    cdsDadosCOD_FK_CIDADE: TIntegerField;
    cdsDadosCOD_FK_BAIRRO: TIntegerField;
    cdsDadosCOD_FK_RUA: TIntegerField;
    cdsDadosENDERECO_CEP: TStringField;
    cdsDadosENDERECO_COMPLEMENTO: TStringField;
    cdsDadosNOME: TStringField;
    cdsDadosEMAIL: TStringField;
    cdsDadosTELEFONE_RESIDENCIAL: TStringField;
    cdsDadosTELEFONE_COMERCIAL: TStringField;
    cdsDadosTELEFONE_CELULAR: TStringField;
    cdsDadosCPF: TStringField;
    cdsDadosIDENTIDADE: TStringField;
    cdsDadosDATA_NASCIMENTO: TDateField;
    cdsDadosHORARIO_LIGACAO: TStringField;
    cdsDadosHORA_INICIO: TTimeField;
    cdsDadosHORA_FINAL: TTimeField;
    zQryDadosRENDIMENTO: TFloatField;
    cdsDadosRENDIMENTO: TFloatField;
    lblRendimento: TLabel;
    plsMedRendimento: TPlsEdit;
    pnlEstado: TPanel;
    pnlCidade: TPanel;
    pnlBairro: TPanel;
    pnlRua: TPanel;
    lblCampoObrigatorio4: TLabel;
    lblEstado: TLabel;
    plsEdEstado: TPlsEdit;
    spBtnBuscaEstado: TSpeedButton;
    lblCampoObrigatorio5: TLabel;
    lblCidade: TLabel;
    spBtnBuscaCidade: TSpeedButton;
    plsEdCidade: TPlsEdit;
    spBtnBuscaBairro: TSpeedButton;
    plsEdBairro: TPlsEdit;
    lblBairro: TLabel;
    lblRua: TLabel;
    plsEdRua: TPlsEdit;
    spBtnBuscaRua: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure plsEdCodigoExit(Sender: TObject);
    procedure plsEdNomeExit(Sender: TObject);
    procedure plsMedCPFExit(Sender: TObject);
    procedure plsEdIdentidadeExit(Sender: TObject);
    procedure spBtnBuscaProfissaoClick(Sender: TObject);
    procedure spBtnBuscaEstadoClick(Sender: TObject);
    procedure spBtnBuscaCidadeClick(Sender: TObject);
    procedure spBtnBuscaBairroClick(Sender: TObject);
    procedure spBtnBuscaRuaClick(Sender: TObject);
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdNomeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsMedCPFKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdIdentidadeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spBtnBuscaMeioCaptacaoClick(Sender: TObject);
    procedure plsEdMeioCaptacaoExit(Sender: TObject);
    procedure plsEdProfissaoExit(Sender: TObject);
    procedure plsEdEstadoExit(Sender: TObject);
    procedure plsEdCidadeExit(Sender: TObject);
    procedure plsEdBairroExit(Sender: TObject);
    procedure plsEdRuaExit(Sender: TObject);
    procedure plsEdCodigoEnter(Sender: TObject);
    procedure plsEdCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdNomeEnter(Sender: TObject);
    procedure plsEdNomeKeyPress(Sender: TObject; var Key: Char);
    procedure plsMedCPFEnter(Sender: TObject);
    procedure plsMedCPFKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdIdentidadeEnter(Sender: TObject);
    procedure plsEdIdentidadeKeyPress(Sender: TObject; var Key: Char);
    procedure plsMedDataNascimentoEnter(Sender: TObject);
    procedure plsMedDataNascimentoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdEmailKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdEmailEnter(Sender: TObject);
    procedure plsMedRendimentoEnter(Sender: TObject);
    procedure plsMedRendimentoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdProfissaoEnter(Sender: TObject);
    procedure plsEdProfissaoKeyPress(Sender: TObject; var Key: Char);
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
    procedure plsMmEnderecoComplementoEnter(Sender: TObject);
    procedure plsMmEnderecoComplementoKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsCbBxPeriodoKeyPress(Sender: TObject; var Key: Char);
    procedure plsCbBxPeriodoEnter(Sender: TObject);
    procedure plsMedHoraLigacaoInicioEnter(Sender: TObject);
    procedure plsMedHoraLigacaoInicioKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedHoraLigacaoFinalKeyPress(Sender: TObject;
      var Key: Char);
    procedure plsMedHoraLigacaoFinalEnter(Sender: TObject);
    procedure lblDicasClick(Sender: TObject);
    procedure plsMedDataCaptacaoEnter(Sender: TObject);
    procedure plsMedDataCaptacaoKeyPress(Sender: TObject; var Key: Char);
  private
    FoCliente: TObjCliente;
    FoConjuntoDadosMeioCaptacao: TConjuntoDadosMeioCaptacao;
    FoConjuntoDadosProfissao: TConjuntoDadosProfissao;
    FoConjuntoDadosEstado: TConjuntoDadosEstado;
    FoConjuntoDadosCidade: TConjuntoDadosCidade;
    FoConjuntoDadosBairro: TConjuntoDadosBairro;
    FoConjuntoDadosRua: TConjuntoDadosRua;

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


    procedure AbreTelaSelecaoProfissao(pnTpSelecao:Word);
    procedure VerificarProfissaoExiste();

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
    FoProfissao: TProfissao;
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
  frmCadCliente: TfrmCadCliente;

implementation

uses
  unConstantes, unDM, unPesquisandoCliente, unSelecionaRegistroEstado,
  unSelecionaRegistroCidade, unSelecionaRegistroBairro,
  unSelecionaRegistroRua, unSelecionaRegistroProfissao, unVariaveis,
  unSelecionaRegistroMeioCaptacao, unSelecionaRegistroCliente, unPrincipal;

const
  fnSELECIONAR_PROFISSAO_NORMAL    = 1;
  fnSELECIONAR_PROFISSAO_DIGITANDO = 2;

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

{ TfrmCadCliente }

(* procedimentos de controle *)

procedure TfrmCadCliente.iniciarTela(poForm: TForm);
begin
  inherited;
(*  Application.CreateForm(TfrmPesquisandoCliente, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmCadCliente);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
*)
end;

procedure TfrmCadCliente.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_CRIA_TELA_PESQUISA)then
  begin
    Application.CreateForm(TfrmPesquisandoCliente, Self.FoPesquisa);
    Self.FoPesquisa.passarParametro(PRM_INICIAR_TELA, null);
    Self.FoPesquisa.iniciarTela(frmCadCliente);
    if(Assigned(Self.FoPesquisa))then
      Self.FoPesquisa.Hide;
  end

  else if(pTipo = PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.FbChamadaExternaInserirRegistro := True;
    Self.FiTelaExternaChamouInserirRegistro := pValores;
  end

  else if(pTipo = PRM_NAO_LIMPAR_ENDERECO)then
  begin
    Self.FbPodeLimparEndereco := False;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS)then
  begin
    if(pValores[0] = CONJUNTO_DADOS_PROFISSAO)then
      FoConjuntoDadosProfissao.ExecutarSQLSelecao()

    else if(pValores[0] = CONJUNTO_DADOS_MEIO_CAPTACAO)then
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

procedure TfrmCadCliente.limparObjeto();
begin
  if (Assigned(Self.FoCliente)) then
  begin
    Self.FoCliente.limparObjeto();
  end;
end;

procedure TfrmCadCliente.limparTela(poForm: TForm);
begin
  inherited;
  Self.FoProfissao.codigo := NUMERO_INDEFINIDO;
  Self.FoProfissao.nome := STRING_INDEFINIDO;

  Self.FoMeioCaptacao.codigo := NUMERO_INDEFINIDO;
  Self.FoMeioCaptacao.nome := STRING_INDEFINIDO;

  Self.FoEstado.codigo := NUMERO_INDEFINIDO;
  Self.FoEstado.nome := STRING_INDEFINIDO;

  Self.FoCidade.codigo := NUMERO_INDEFINIDO;
  Self.FoCidade.nome := STRING_INDEFINIDO;

  Self.FoBairro.codigo := NUMERO_INDEFINIDO;
  Self.FoBairro.nome := STRING_INDEFINIDO;

  Self.FoRua.codigo := NUMERO_INDEFINIDO;
  Self.FoRua.nome := STRING_INDEFINIDO;
  Self.FoRua.cep := STRING_INDEFINIDO;
end;

procedure TfrmCadCliente.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoCliente))) then
  begin
    Self.FoCliente.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoCliente.setDataCadastro(cdsDadosDATA_CADASTRO.AsDateTime);
    Self.FoCliente.setDataCaptacao(cdsDadosDATA_CAPTACAO.AsDateTime);
    Self.FoCliente.setFkProfissao(cdsDadosCOD_FK_PROFISSAO.AsInteger);
    Self.FoCliente.setFkMeioCaptacao(cdsDadosCOD_FK_MEIO_CAPTACAO.AsInteger);
    Self.FoCliente.setFkEstado(cdsDadosCOD_FK_ESTADO.AsInteger);
    Self.FoCliente.setFkCidade(cdsDadosCOD_FK_CIDADE.AsInteger);
    Self.FoCliente.setFkBairro(cdsDadosCOD_FK_BAIRRO.AsInteger);
    Self.FoCliente.setFkRua(cdsDadosCOD_FK_RUA.AsInteger);
    Self.FoCliente.setEnderecoCEP(cdsDadosENDERECO_CEP.AsString);
    Self.FoCliente.setEnderecoComplemento(cdsDadosENDERECO_COMPLEMENTO.AsString);
    Self.FoCliente.setNome(cdsDadosNOME.AsString);
    Self.FoCliente.setEmail(cdsDadosEMAIL.AsString);
    Self.FoCliente.setTelefoneResidencial(cdsDadosTELEFONE_RESIDENCIAL.AsString);
    Self.FoCliente.setTelefoneComercial(cdsDadosTELEFONE_COMERCIAL.AsString);
    Self.FoCliente.setTelefoneCelular(cdsDadosTELEFONE_CELULAR.AsString);
    Self.FoCliente.setCPF(cdsDadosCPF.AsString);
    Self.FoCliente.setIdentidade(cdsDadosIDENTIDADE.AsString);
    Self.FoCliente.setDataNascimento(cdsDadosDATA_NASCIMENTO.AsDateTime);
    Self.FoCliente.setHorarioLigacao(cdsDadosHORARIO_LIGACAO.AsString);
    Self.FoCliente.setHoraInicio(cdsDadosHORA_INICIO.AsDateTime);
    Self.FoCliente.setHoraFinal(cdsDadosHORA_FINAL.AsDateTime);
    Self.FoCliente.setRendimento(cdsDadosRENDIMENTO.AsCurrency);    
    Self.FoCliente.setExibeProfissao(False);
    Self.FoCliente.setExibeMeioCaptacao(False);
    Self.FoCliente.setExibeEstado(False);
    Self.FoCliente.setExibeCidade(False);
    Self.FoCliente.setExibeBairro(False);
    Self.FoCliente.setExibeRua(False);
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadCliente.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadCliente.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoCliente))then
  begin
    if(Self.FoCliente.getCodigo <> NUMERO_INDEFINIDO)then
      plsEdCodigo.Text := IntToStr(Self.FoCliente.getCodigo)
    else
      plsEdCodigo.Clear;
    if(Self.FoCliente.getDataCaptacao <> NUMERO_INDEFINIDO)then
      plsMedDataCaptacao.Text := DateToStr(Self.FoCliente.getDataCaptacao)
    else
      plsMedDataCaptacao.Clear;
    plsEdNome.Text := Self.FoCliente.getNome;
    plsMedCPF.Text := Self.FoCliente.getCPF;
    plsEdIdentidade.Text := Self.FoCliente.getIdentidade;
    if(Self.FoCliente.getDataNascimento <> NUMERO_INDEFINIDO)then
      plsMedDataNascimento.Text := DateToStr(Self.FoCliente.getDataNascimento)
    else
      plsMedDataNascimento.Clear;
    plsEdEmail.Text := Self.FoCliente.getEmail;
    plsEdProfissao.Text := Self.FoCliente.getExibeProfissao;
    Self.FoProfissao.codigo := Self.FoCliente.getFkProfissao;
    Self.FoProfissao.nome := Self.FoCliente.getExibeProfissao;
    plsEdMeioCaptacao.Text := Self.FoCliente.getExibeMeioCaptacao;
    Self.FoMeioCaptacao.codigo := Self.FoCliente.getFkMeioCaptacao;
    Self.FoMeioCaptacao.nome := Self.FoCliente.getExibeMeioCaptacao;
    plsMedTelefoneResidencial.Text := Self.FoCliente.getTelefoneResidencial;
    plsMedTelefoneComercial.Text := Self.FoCliente.getTelefoneComercial;
    plsMedTelefoneCelular.Text := Self.FoCliente.getTelefoneCelular;
    plsEdEstado.Text := Self.FoCliente.getExibeEstado;
    Self.FoEstado.codigo := Self.FoCliente.getFkEstado;
    Self.FoEstado.nome := Self.FoCliente.getExibeEstado;
    plsEdCidade.Text := Self.FoCliente.getExibeCidade;
    Self.FoCidade.codigo := Self.FoCliente.getFkCidade;
    Self.FoCidade.nome := Self.FoCliente.getExibeCidade;
    plsEdBairro.Text := Self.FoCliente.getExibeBairro;
    Self.FoBairro.codigo := Self.FoCliente.getFkBairro;
    Self.FoBairro.nome := Self.FoCliente.getExibeBairro;
    plsEdRua.Text := Self.FoCliente.getExibeRua;
    Self.FoRua.codigo := Self.FoCliente.getFkRua;
    Self.FoRua.nome := Self.FoCliente.getExibeRua;
    plsMedCEP.Text := Self.FoCliente.getEnderecoCEP;
    plsMmEnderecoComplemento.Text := Self.FoCliente.getEnderecoComplemento;

    if(Self.FoCliente.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_MANHA)then
      plsCbBxPeriodo.ItemIndex := 0
    else if(Self.FoCliente.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_TARDE)then
      plsCbBxPeriodo.ItemIndex := 1
    else if(Self.FoCliente.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_NOITE)then
      plsCbBxPeriodo.ItemIndex := 2
    else if(Self.FoCliente.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_QUALQUER)then
      plsCbBxPeriodo.ItemIndex := 3
    else
      plsCbBxPeriodo.ItemIndex := -1;

    if(Self.FoCliente.getHoraInicio <> NUMERO_INDEFINIDO)then
      plsMedHoraLigacaoInicio.Text := TimeToStr(Self.FoCliente.getHoraInicio)
    else
      plsMedHoraLigacaoInicio.Clear;

    if(Self.FoCliente.getHoraFinal <> NUMERO_INDEFINIDO)then
      plsMedHoraLigacaoFinal.Text := TimeToStr(Self.FoCliente.getHoraFinal)
    else
      plsMedHoraLigacaoFinal.Clear;

    if(Self.FoCliente.getRendimento <> NUMERO_INDEFINIDO)then
    begin
      plsMedRendimento.Text := FloatToStr(Self.FoCliente.getRendimento);
      plsMedRendimento.Text := FoFuncoes.formatarValorMonetario(plsMedRendimento.Text);
    end
    else
      plsMedRendimento.Clear;
  end;
end;

procedure TfrmCadCliente.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM cliente_pessoa_fisica ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadCliente.verificarHouveAlteracoes(): boolean;
var
  dDataCaptacao: TDate;
  iProfissao: Integer;
  iMeioCaptacao: Integer;
  iEstado: Integer;
  iCidade: Integer;
  iBairro: Integer;
  iRua: Integer;
  sEnderecoCEP: String;
  sEnderecoComplemento: String;
  sNome: String;
  sEmail: String;
  sTelefoneResidencial: String;
  sTelefoneComercial: String;
  sTelefoneCelular: String;
  sCPF: String;
  sIdentidade: String;
  dDataNascimento: TDate;
  sHorarioLigacao: String;
  tHoraInicio: TTime;
  tHoraFinal: TTime;
  dRendimento: Double;

  bAlteracao: Boolean;
begin
  try
    dDataCaptacao := StrToDate(plsMedDataCaptacao.Text);
  except
    dDataCaptacao := NUMERO_INDEFINIDO;
  end;
  iProfissao := Self.FoProfissao.codigo;
  iMeioCaptacao := Self.FoMeioCaptacao.codigo;
  iEstado := Self.FoEstado.codigo;
  iCidade := Self.FoCidade.codigo;
  iBairro := Self.FoBairro.codigo;
  iRua := Self.FoRua.codigo;
  sEnderecoCEP := Trim(plsMedCEP.Text);
  sEnderecoComplemento := Trim(plsMmEnderecoComplemento.Text);
  sNome := Trim(plsEdNome.Text);
  sEmail := Trim(plsEdEmail.Text);
  sTelefoneResidencial := Trim(plsMedTelefoneResidencial.Text);
  sTelefoneComercial := Trim(plsMedTelefoneComercial.Text);
  sTelefoneCelular := Trim(plsMedTelefoneCelular.Text);
  sCPF := Trim(plsMedCPF.Text);
  sIdentidade := Trim(plsEdIdentidade.Text);
  dDataNascimento := StrToDate(plsMedDataNascimento.Text);
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
    bAlteracao := Self.FoCliente.verificarDiferencaCadastro(dDataCaptacao,
    iProfissao,iMeioCaptacao,iEstado,iCidade,iBairro,iRua,sEnderecoCEP,
    sEnderecoComplemento,sNome,sEmail,sTelefoneResidencial,sTelefoneComercial,
    sTelefoneCelular,sCPF,sIdentidade,dDataNascimento,sHorarioLigacao,
    tHoraInicio,tHoraFinal,dRendimento);
  except
    bAlteracao := True;
  end;
  Result := bAlteracao;
end;

function TfrmCadCliente.verificarCamposObrigatorios(): boolean;
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

  if(not(Self.FoFuncoes.validarData(plsMedDataCaptacao.Text)))then
  begin
    campos := 'Data Captação';
    compFoco := plsMedDataCaptacao;
  end;

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
    FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

procedure TfrmCadCliente.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsMedDataCaptacao.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsMedCPF.Enabled := True;
                       plsEdIdentidade.Enabled := True;
                       plsMedDataNascimento.Enabled := False;
                       plsEdEmail.Enabled := False;
                       pnlProfissao.Enabled := False;
                       pnlMeioCaptacao.Enabled := False;
                       grpBxTelefones.Enabled := False;
                       grpBxEndereco.Enabled := False;
                       grpBxHorarioLigacao.Enabled := False;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Text := IntToStr(FoFuncoes.RetornarProximoCodigo(TABLE_CLIENTE_PESSOA_FISICA,True));    
                       plsEdCodigo.Enabled := True;
                       plsMedDataCaptacao.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsMedCPF.Enabled := True;
                       plsEdIdentidade.Enabled := True;
                       plsMedDataNascimento.Enabled := True;
                       plsEdEmail.Enabled := True;
                       pnlProfissao.Enabled := True;
                       pnlMeioCaptacao.Enabled := True;
                       grpBxTelefones.Enabled := True;
                       grpBxEndereco.Enabled := True;
                       grpBxHorarioLigacao.Enabled := True;
                       Self.FoFuncoes.focarComponente(plsMedDataCaptacao);
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := True;
                       plsMedDataCaptacao.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsMedCPF.Enabled := True;
                       plsEdIdentidade.Enabled := True;
                       plsMedDataNascimento.Enabled := True;
                       plsEdEmail.Enabled := True;
                       pnlProfissao.Enabled := True;
                       pnlMeioCaptacao.Enabled := True;
                       grpBxTelefones.Enabled := True;
                       grpBxEndereco.Enabled := True;
                       grpBxHorarioLigacao.Enabled := True;
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
                       plsEdNome.Enabled := True;
                       plsMedCPF.Enabled := True;
                       plsEdIdentidade.Enabled := True;
                       plsMedDataNascimento.Enabled := False;
                       plsEdEmail.Enabled := False;
                       pnlProfissao.Enabled := False;
                       pnlMeioCaptacao.Enabled := False;
                       grpBxTelefones.Enabled := False;
                       grpBxEndereco.Enabled := False;
                     end;
  end; //fim - case
end;

function TfrmCadCliente.outrasValidacoesAntesSalvar(): Boolean;
var
  compFoco: TWinControl;
  sCPF: String;
  bRetorno: Boolean;
begin
  compFoco := nil;
  bRetorno := True;

  sCPF := Self.FoFuncoes.retirarCaracteres(plsMedCPF.Text,'.-');
  if(not(sCPF=STRING_INDEFINIDO))then
  begin
    if(not(Self.FoFuncoes.VerificaDigitoCPF(sCPF)))then
    begin
      MessageDlg('CPF inválido.',mtWarning,[mbOK],0);
      compFoco := plsMedCPF;
      bRetorno := False;
    end;
  end;

  if(bRetorno)then
  begin
    if(not(Self.FoFuncoes.retirarCaracteres(plsMedDataNascimento.Text,'/')=STRING_INDEFINIDO))then
    begin
      if(not(Self.FoFuncoes.validarData(plsMedDataNascimento.Text)))then
      begin
        MessageDlg('Data de nascimento inválida.',mtWarning,[mbOK],0);
        compFoco := plsMedDataNascimento;
        bRetorno := False;
      end;
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

procedure TfrmCadCliente.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadCliente);
  visibilidade(OPC_NOVO);
  plsMedDataCaptacao.Text := DateToStr(Now);
end;

function TfrmCadCliente.salvar(): boolean;
var
  bSalvou: boolean;

  dtDataCaptacao: TDate;
  sNome,sCPF,sIdentidade: String;
  dtDataNascimento: TDate;
  sEmail: String;
  nCodFk_Profissao,nCodFk_MeioCaptacao: Integer;
  sTelefoneResidencial,sTelefoneComercial,sTelefoneCelular: String;
  nCodFK_Estado,nCodFK_Cidade,nCodFK_Bairro,nCodFK_Rua: Integer;
  sEnderecoCEP,sEnderecoComplemento: String;
  sHorarioLigacao: String;
  tHoraInicio,tHoraFinal: TTime;
  dRendimento: Double;

  procedure carregarValores();
  begin
    try
      dtDataCaptacao := StrToDate(plsMedDataCaptacao.Text);
    except
      dtDataCaptacao := 0;
    end;
    sNome := Trim(plsEdNome.Text);
    sCPF := Trim(plsMedCPF.Text);
    sIdentidade := Trim(plsEdIdentidade.Text);
    try
      dtDataNascimento := StrToDate(plsMedDataNascimento.Text);
    except
      dtDataNascimento := 0;
    end;
    sEmail := Trim(plsEdEmail.Text);
    if(Self.FoProfissao.codigo <> NUMERO_INDEFINIDO)then
      nCodFk_Profissao := Self.FoProfissao.codigo
    else
      nCodFk_Profissao := REGISTRO_NULO;
    if(Self.FoMeioCaptacao.codigo <> NUMERO_INDEFINIDO)then
      nCodFk_MeioCaptacao := Self.FoMeioCaptacao.codigo
    else
      nCodFk_MeioCaptacao := REGISTRO_NULO;

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
      0: sHorarioLigacao := PESSOA_FISICA_HORARIO_LIGACAO_MANHA;
      1: sHorarioLigacao := PESSOA_FISICA_HORARIO_LIGACAO_TARDE;
      2: sHorarioLigacao := PESSOA_FISICA_HORARIO_LIGACAO_NOITE;
      3: sHorarioLigacao := PESSOA_FISICA_HORARIO_LIGACAO_QUALQUER;
    end;

    if(Self.FoFuncoes.validarHora(plsMedHoraLigacaoInicio.Text))then
      tHoraInicio := StrToTime(plsMedHoraLigacaoInicio.Text)
    else
      tHoraInicio := NUMERO_INDEFINIDO;

    if(Self.FoFuncoes.validarHora(plsMedHoraLigacaoFinal.Text))then
      tHoraFinal := StrToTime(plsMedHoraLigacaoFinal.Text)
    else
      tHoraFinal := NUMERO_INDEFINIDO;

    dRendimento := FoFuncoes.formatarValorCurrency(plsMedRendimento.Text);
  end;

  //limpa parâmetro nulos - para o insert e update
  procedure limparParametrosNulos();
  begin
    if(dtDataCaptacao = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('dt_cap').Clear;
    if(Self.FoFuncoes.verificaCPF_EhVazio(sCPF))then
      zQryDados.ParamByName('cpf').Clear;
    if(dtDataNascimento = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('dat_nas').Clear;
    if(tHoraInicio = NUMERO_INDEFINIDO)then
      zQryDados.ParamByName('hor_ini').Clear;
    if(tHoraFinal = NUMERO_INDEFINIDO)then
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

        zQryDados.SQL.Add('UPDATE cliente_pessoa_fisica SET data_captacao=:dt_cap,');
        zQryDados.SQL.Add('cod_fk_profissao=:cod_fk_pro,cod_fk_meio_captacao=:cod_fk_me_cap,');
        zQryDados.SQL.Add('cod_fk_estado=:cod_fk_est,cod_fk_cidade=:cod_fk_cid,');
        zQryDados.SQL.Add('cod_fk_bairro=:cod_fk_bai,cod_fk_rua=:cod_fk_rua,');
        zQryDados.SQL.Add('endereco_cep=:end_cep,endereco_complemento=:end_com,');
        zQryDados.SQL.Add('nome=:nom,email=:ema,telefone_residencial=:tel_res,');
        zQryDados.SQL.Add('telefone_comercial=:tel_com,telefone_celular=:tel_cel,');
        zQryDados.SQL.Add('cpf=:cpf,identidade=:ide,data_nascimento=:dat_nas,');
        zQryDados.SQL.Add('horario_ligacao=:hor_lig,hora_inicio=:hor_ini,');
        zQryDados.SQL.Add('hora_final=:hor_fin,rendimento=:ren ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('dt_cap').AsDate := dtDataCaptacao;
        zQryDados.ParamByName('cod_fk_pro').AsInteger := nCodFk_Profissao;
        zQryDados.ParamByName('cod_fk_me_cap').AsInteger := nCodFk_MeioCaptacao;
        zQryDados.ParamByName('cod_fk_est').AsInteger := nCodFK_Estado;
        zQryDados.ParamByName('cod_fk_cid').AsInteger := nCodFK_Cidade;
        zQryDados.ParamByName('cod_fk_bai').AsInteger := nCodFK_Bairro;
        zQryDados.ParamByName('cod_fk_rua').AsInteger := nCodFK_Rua;
        zQryDados.ParamByName('end_cep').AsString := sEnderecoCEP;
        zQryDados.ParamByName('end_com').AsString := sEnderecoComplemento;
        zQryDados.ParamByName('nom').AsString := sNome;
        zQryDados.ParamByName('ema').AsString := sEmail;
        zQryDados.ParamByName('tel_res').AsString := sTelefoneResidencial;
        zQryDados.ParamByName('tel_com').AsString := sTelefoneComercial;
        zQryDados.ParamByName('tel_cel').AsString := sTelefoneCelular;
        zQryDados.ParamByName('cpf').AsString := sCPF;
        zQryDados.ParamByName('ide').AsString := sIdentidade;
        zQryDados.ParamByName('dat_nas').AsDate := dtDataNascimento;
        zQryDados.ParamByName('hor_lig').AsString := sHorarioLigacao;
        zQryDados.ParamByName('hor_ini').AsTime := tHoraInicio;
        zQryDados.ParamByName('hor_fin').AsTime := tHoraFinal;
        zQryDados.ParamByName('ren').AsCurrency := dRendimento;
        zQryDados.ParamByName('cod').AsInteger := Self.FoCliente.getCodigo();
        zQryDados.ExecSQL();
        limparParametrosNulos();
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
        zQryDados.SQL.Add('INSERT INTO cliente_pessoa_fisica (data_captacao,cod_fk_profissao,');
        zQryDados.SQL.Add('cod_fk_meio_captacao,cod_fk_estado,cod_fk_cidade,');
        zQryDados.SQL.Add('cod_fk_bairro,cod_fk_rua,endereco_cep,endereco_complemento,');
        zQryDados.SQL.Add('nome,email,telefone_residencial,telefone_comercial,');
        zQryDados.SQL.Add('telefone_celular,cpf,identidade,data_nascimento,');
        zQryDados.SQL.Add('horario_ligacao,hora_inicio,hora_final,rendimento) ');
        zQryDados.SQL.Add('VALUES(:dt_cap,:cod_fk_pro,:cod_fk_me_cap,:cod_fk_est,');
        zQryDados.SQL.Add(':cod_fk_cid,:cod_fk_bai,:cod_fk_rua,:end_cep,:end_com,');
        zQryDados.SQL.Add(':nom,:ema,:tel_res,:tel_com,:tel_cel,:cpf,:ide,:dat_nas,');
        zQryDados.SQL.Add(':hor_lig,:hor_ini,:hor_fin,:ren)');
        zQryDados.ParamByName('dt_cap').AsDate := dtDataCaptacao;
        zQryDados.ParamByName('cod_fk_pro').AsInteger := nCodFk_Profissao;
        zQryDados.ParamByName('cod_fk_me_cap').AsInteger := nCodFk_MeioCaptacao;
        zQryDados.ParamByName('cod_fk_est').AsInteger := nCodFK_Estado;
        zQryDados.ParamByName('cod_fk_cid').AsInteger := nCodFK_Cidade;
        zQryDados.ParamByName('cod_fk_bai').AsInteger := nCodFK_Bairro;
        zQryDados.ParamByName('cod_fk_rua').AsInteger := nCodFK_Rua;
        zQryDados.ParamByName('end_cep').AsString := sEnderecoCEP;
        zQryDados.ParamByName('end_com').AsString := sEnderecoComplemento;
        zQryDados.ParamByName('nom').AsString := sNome;
        zQryDados.ParamByName('ema').AsString := sEmail;
        zQryDados.ParamByName('tel_res').AsString := sTelefoneResidencial;
        zQryDados.ParamByName('tel_com').AsString := sTelefoneComercial;
        zQryDados.ParamByName('tel_cel').AsString := sTelefoneCelular;
        zQryDados.ParamByName('cpf').AsString := sCPF;
        zQryDados.ParamByName('ide').AsString := sIdentidade;
        zQryDados.ParamByName('dat_nas').AsDate := dtDataNascimento;
        zQryDados.ParamByName('hor_lig').AsString := sHorarioLigacao;
        zQryDados.ParamByName('hor_ini').AsTime := tHoraInicio;
        zQryDados.ParamByName('hor_fin').AsTime := tHoraFinal;
        zQryDados.ParamByName('ren').AsCurrency := dRendimento;
        zQryDados.ExecSQL();
        limparParametrosNulos();
        DM.ZConnection.Commit;
        bSalvou := True;
        Self.verificarInseriuChamadaTelaExterna();
      except
        DM.ZConnection.Rollback;
      end;
    end;
  end;

  if((bSalvou)and(not(FbChamadaExternaInserirRegistro)))then
    Self.FoPesquisa.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS,null);

  Result := bSalvou;
end;

procedure TfrmCadCliente.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
begin
  DM.zQryClientePessoaFisica.Close;
  DM.zQryClientePessoaFisica.SQL.Clear;
  DM.zQryClientePessoaFisica.SQL.Add('SELECT * FROM cliente_pessoa_fisica ORDER BY codigo DESC ROWS 1');
  DM.zQryClientePessoaFisica.Open;
  if(DM.zQryClientePessoaFisica.RecordCount = 1)then
    nCodigo := DM.zQryClientePessoaFisicaCODIGO.AsInteger
  else
    nCodigo := NUMERO_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_CLIENTE)then
    begin
      frmSelecionaRegistroCliente.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end;
end;


function TfrmCadCliente.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM cliente_pessoa_fisica WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoCliente.getCodigo();
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

function TfrmCadCliente.verificarRegistroJaExiste(): boolean;
var
  bRetorno: Boolean;
  sCPF: String;
begin
  bRetorno := False;

  //nome,cpf,estado e cidade iguais
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM cliente_pessoa_fisica WHERE nome=:nom AND cpf=:cpf ');
  zQryDados.SQL.Add('AND cod_fk_estado=:cod_fk_est AND cod_fk_cidade=:cod_fk_cid');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoCliente.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoCliente.getCodigo;
  end;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.ParamByName('cpf').AsString := Trim(plsMedCPF.Text);
  zQryDados.ParamByName('cod_fk_est').AsInteger := Self.FoEstado.codigo;
  zQryDados.ParamByName('cod_fk_cid').AsInteger := Self.FoCidade.codigo;
  zQryDados.Open;

  if(zQryDados.RecordCount <> 0)then
  begin
    bRetorno := True;
    MessageDlg('Cliente já cadastrado.', mtWarning, [mbOK], 0);
  end
  else
  begin
    //cpf igual
    sCPF := Self.FoFuncoes.retirarCaracteres(plsMedCPF.Text,'.-');
    if(sCPF <> STRING_INDEFINIDO)then
    begin
      if(Self.FoFuncoes.VerificaDigitoCPF(sCPF))then
      begin
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('SELECT * FROM cliente_pessoa_fisica WHERE cpf=:cpf ');
        //se estiver editando, pode salvar com os mesmos dados
        if(Self.FoCliente.getCodigo <> NUMERO_INDEFINIDO)then
        begin
          zQryDados.SQL.Add(' AND codigo <> :cod');
          zQryDados.ParamByName('cod').AsInteger := Self.FoCliente.getCodigo;
        end;
        zQryDados.ParamByName('cpf').AsString := Trim(plsMedCPF.Text);
        zQryDados.Open;

        if(zQryDados.RecordCount <> 0)then
        begin
          bRetorno := True;
          MessageDlg('Cliente com este CPF já cadastrado.', mtWarning, [mbOK], 0);
        end;
      end;
    end;
  end;

  Result := bRetorno;
end;

function TfrmCadCliente.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  Result := bPodeDeletar;
end;


procedure TfrmCadCliente.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

//limpa os campos do endereço, a partir daquele que alterou
procedure TfrmCadCliente.limparEndereco(iEnderecoChamou: String);
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
function TfrmCadCliente.validarAcessoEndereco(iEnderecoChamou: String): boolean;
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


procedure TfrmCadCliente.AbreTelaSelecaoProfissao(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdProfissao.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_PROFISSAO_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroProfissao, frmSelecionaRegistroProfissao);
        frmSelecionaRegistroProfissao.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroProfissao.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdProfissao.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroProfissao.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroProfissao.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroProfissao,pnlProfissao,ToolBar);
        frmSelecionaRegistroProfissao.ShowModal;
      finally
        if(Self.FoProfissao.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdProfissao.Text := Self.FoProfissao.nome;
          Self.FoFuncoes.focarComponente(plsEdMeioCaptacao);
        end;
        FreeAndNil(frmSelecionaRegistroProfissao);
      end;
    end;

    fnSELECIONAR_MEIO_CAPTACAO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroProfissao, frmSelecionaRegistroProfissao);
        frmSelecionaRegistroProfissao.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroProfissao.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroProfissao.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroProfissao.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroProfissao,pnlProfissao,ToolBar);
        frmSelecionaRegistroProfissao.ShowModal;
      finally
        if(Self.FoProfissao.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdProfissao.Text := Self.FoProfissao.nome;
          Self.FoFuncoes.focarComponente(plsEdMeioCaptacao);
        end
        else
          plsEdProfissao.Clear;
        FreeAndNil(frmSelecionaRegistroProfissao);
      end;
    end;
  end;
end;    

procedure TfrmCadCliente.VerificarProfissaoExiste();
begin
  if(Trim(plsEdProfissao.Text) <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosProfissao.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdProfissao.Text + '%'));
    FoConjuntoDadosProfissao.ExecutarFiltrar();

    if(FoConjuntoDadosProfissao.TotalRegistros = 1)then
    begin
      FoProfissao.codigo := FoConjuntoDadosProfissao.GetCodigo;
      FoProfissao.nome := FoConjuntoDadosProfissao.GetNome;
      plsEdProfissao.Text := FoProfissao.nome;
    end
    else if(FoConjuntoDadosProfissao.TotalRegistros > 1)then
      AbreTelaSelecaoProfissao(fnSELECIONAR_PROFISSAO_DIGITANDO)
    else
    begin
      MessageDlg('Profissão não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdProfissao);
    end;
  end
  else
  begin
    plsEdProfissao.Clear;
    FoProfissao.codigo := NUMERO_INDEFINIDO;
    FoProfissao.nome := STRING_INDEFINIDO;
  end;
end;

procedure TfrmCadCliente.AbreTelaSelecaoMeioCaptacao(pnTpSelecao:Word);
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
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdMeioCaptacao.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroMeioCaptacao,pnlMeioCaptacao,ToolBar);
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
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroMeioCaptacao,pnlMeioCaptacao,ToolBar);
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

procedure TfrmCadCliente.VerificarMeioCaptacaoExiste();
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

procedure TfrmCadCliente.AbreTelaSelecaoEstado(pnTpSelecao:Word);
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
        frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroEstado.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdEstado.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroEstado.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroEstado.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroEstado,pnlEstado,ToolBar,grpBxEndereco);
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
        frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroEstado.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroEstado.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroEstado.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroEstado,pnlEstado,ToolBar,grpBxEndereco);
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


procedure TfrmCadCliente.VerificarEstadoExiste();
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


procedure TfrmCadCliente.AbreTelaSelecaoCidade(pnTpSelecao:Word);
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
        frmSelecionaRegistroCidade.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroCidade.passarParametro('FK_COD_ESTADO', Self.FoEstado.codigo);
        frmSelecionaRegistroCidade.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroCidade.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroCidade.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroCidade,pnlCidade,ToolBar,grpBxEndereco);
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
        frmSelecionaRegistroCidade.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroCidade.passarParametro('FK_COD_ESTADO', Self.FoEstado.codigo);
        frmSelecionaRegistroCidade.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroCidade.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroCidade.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroCidade,pnlCidade,ToolBar,grpBxEndereco);
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


procedure TfrmCadCliente.VerificarCidadeExiste();
var
  sFiltro: String;
begin
  sFiltro := '(nome ' + ' LIKE ' + QuotedStr('%' + plsEdCidade.Text + '%') + ')';
  sFiltro := sFiltro + ' AND cod_fk_estado = ' + QuotedStr(IntToStr(FoEstado.codigo));
  if(plsEdCidade.Text <> STRING_INDEFINIDO)then
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


procedure TfrmCadCliente.AbreTelaSelecaoBairro(pnTpSelecao:Word);
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
        frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroBairro.passarParametro('FK_COD_CIDADE', Self.FoCidade.codigo);
        frmSelecionaRegistroBairro.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdBairro.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroBairro.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroBairro.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroBairro,pnlBairro,ToolBar,grpBxEndereco);
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
        frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroBairro.passarParametro('FK_COD_CIDADE', Self.FoCidade.codigo);
        frmSelecionaRegistroBairro.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroBairro.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroBairro.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroBairro,pnlBairro,ToolBar,grpBxEndereco);
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

procedure TfrmCadCliente.VerificarBairroExiste();
var
  sFiltro: String;
begin
  sFiltro := '(nome ' + ' LIKE ' + QuotedStr('%' + plsEdBairro.Text + '%') + ')';
  sFiltro := sFiltro + ' AND cod_fk_cidade = ' + QuotedStr(IntToStr(FoCidade.codigo));
  if(plsEdBairro.Text <> STRING_INDEFINIDO)then
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


procedure TfrmCadCliente.AbreTelaSelecaoRua(pnTpSelecao:Word);
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
        frmSelecionaRegistroRua.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroRua.passarParametro('FK_COD_BAIRRO', Self.FoBairro.codigo);
        frmSelecionaRegistroRua.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdRua.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroRua.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroRua.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroRua,pnlRua,ToolBar,grpBxEndereco);
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
        frmSelecionaRegistroRua.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
        frmSelecionaRegistroRua.passarParametro('FK_COD_BAIRRO', Self.FoBairro.codigo);
        frmSelecionaRegistroRua.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroRua.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroRua.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmCadCliente,frmSelecionaRegistroRua,pnlRua,ToolBar,grpBxEndereco);
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

procedure TfrmCadCliente.VerificarRuaExiste();
var
  sFiltro: String;
begin
  sFiltro := '(nome ' + ' LIKE ' + QuotedStr('%' + plsEdRua.Text + '%') + ')';
  sFiltro := sFiltro + ' AND cod_fk_bairro = ' + QuotedStr(IntToStr(FoBairro.codigo));

  if(plsEdRua.Text <> STRING_INDEFINIDO)then
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

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoCliente := TObjCliente.Create;
  FoConjuntoDadosProfissao := TConjuntoDadosProfissao.CriaObjeto;
  FoConjuntoDadosMeioCaptacao := TConjuntoDadosMeioCaptacao.CriaObjeto;
  FoConjuntoDadosEstado := TConjuntoDadosEstado.CriaObjeto;
  FoConjuntoDadosCidade := TConjuntoDadosCidade.CriaObjeto;
  FoConjuntoDadosBairro := TConjuntoDadosBairro.CriaObjeto;
  FoConjuntoDadosRua := TConjuntoDadosRua.CriaObjeto;
  Self.FbPodeLimparEndereco := True;
end;

procedure TfrmCadCliente.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoCliente);
  FreeAndNil(FoConjuntoDadosProfissao);
  FreeAndNil(FoConjuntoDadosMeioCaptacao);
  FreeAndNil(FoConjuntoDadosEstado);
  FreeAndNil(FoConjuntoDadosCidade);
  FreeAndNil(FoConjuntoDadosBairro);
  FreeAndNil(FoConjuntoDadosRua);
end;

procedure TfrmCadCliente.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadCliente.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadCliente.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadCliente.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadCliente.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadCliente.plsEdCodigoExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadCliente.plsEdNomeExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadCliente.plsMedCPFExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadCliente.plsEdIdentidadeExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadCliente.spBtnBuscaProfissaoClick(Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoProfissao(fnSELECIONAR_PROFISSAO_NORMAL);
end;

procedure TfrmCadCliente.spBtnBuscaEstadoClick(Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoEstado(fnSELECIONAR_ESTADO_NORMAL);
end;

procedure TfrmCadCliente.spBtnBuscaCidadeClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('CIDADE'))then
    MessageDlg('Um estado deve estar selecionado.', mtInformation, [mbOK], 0)
  else
    AbreTelaSelecaoCidade(fnSELECIONAR_CIDADE_NORMAL);
end;

procedure TfrmCadCliente.spBtnBuscaBairroClick(Sender: TObject);
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

procedure TfrmCadCliente.spBtnBuscaRuaClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('RUA'))then
    MessageDlg('Um bairro deve estar selecionado.', mtInformation, [mbOK], 0)
  else
    AbreTelaSelecaoRua(fnSELECIONAR_RUA_NORMAL);
end;

procedure TfrmCadCliente.plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sValor: string;
  vParametros: Variant;
begin
  inherited;
  if(Self.FoFuncoes.verificarCaracterPertenceConjuntoTeclasAceitas(Key,[numeros],False))then
  begin
    if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter)) then
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
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadCliente.plsEdNomeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TfrmCadCliente.plsMedCPFKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
        sValor := Self.FoFuncoes.retirarCaracteres(plsMedCPF.Text,'.-');
        sValor := Self.FoFuncoes.formatarCPF(sValor);
        vParametros := VarArrayCreate([0,2],varVariant);
        {vParametros[0] = parâmetro do campo da pesquisa
        vParametros[1] = campo da pesquisa
        vParametros[1] = valor da pesquisa
         }
        vParametros[0] := PRM_PESQUISA_CPF;
        vParametros[1] := 'CPF';
        vParametros[2] := sValor;
        Self.FoPesquisa.passarParametro(PRM_PESQUISAR_REGISTRO, vParametros);
        if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
          Self.FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadCliente.plsEdIdentidadeKeyUp(Sender: TObject;
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
        sValor := plsEdIdentidade.Text;
        vParametros := VarArrayCreate([0,2],varVariant);
        {vParametros[0] = parâmetro do campo da pesquisa
        vParametros[1] = campo da pesquisa
        vParametros[1] = valor da pesquisa
         }
        vParametros[0] := PRM_PESQUISA_IDENTIDADE;
        vParametros[1] := 'IDENTIDADE';
        vParametros[2] := sValor;
        Self.FoPesquisa.passarParametro(PRM_PESQUISAR_REGISTRO, vParametros);
        if(FoPesquisa.PodeAbrirTelaPesquisandoRegistro)then
          Self.FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadCliente.spBtnBuscaMeioCaptacaoClick(Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoMeioCaptacao(fnSELECIONAR_MEIO_CAPTACAO_NORMAL);
end;

procedure TfrmCadCliente.plsEdMeioCaptacaoExit(Sender: TObject);
begin
  inherited;
  VerificarMeioCaptacaoExiste();
end;

procedure TfrmCadCliente.plsEdProfissaoExit(Sender: TObject);
begin
  inherited;
  VerificarProfissaoExiste();
end;

procedure TfrmCadCliente.plsEdEstadoExit(Sender: TObject);
begin
  inherited;
  VerificarEstadoExiste();
end;

procedure TfrmCadCliente.plsEdCidadeExit(Sender: TObject);
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

procedure TfrmCadCliente.plsEdBairroExit(Sender: TObject);
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

procedure TfrmCadCliente.plsEdRuaExit(Sender: TObject);
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

procedure TfrmCadCliente.plsEdCodigoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Cliente pelo Código',STRING_INDEFINIDO);
end;

procedure TfrmCadCliente.plsEdCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Cliente pelo Código',STRING_INDEFINIDO);
end;

procedure TfrmCadCliente.plsEdNomeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Cliente pelo Nome', 'Nome do Cliente');
end;

procedure TfrmCadCliente.plsEdNomeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos('Cliente pelo Nome', 'Nome do Cliente');
end;

procedure TfrmCadCliente.plsMedCPFEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Cliente pelo CPF', 'CPF do Cliente');
end;

procedure TfrmCadCliente.plsMedCPFKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos('Cliente pelo CPF', 'CPF do Cliente');
end;

procedure TfrmCadCliente.plsEdIdentidadeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos('Cliente pela Identidade', 'Identidade do Cliente',False);
end;

procedure TfrmCadCliente.plsEdIdentidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos('Cliente pela Identidade', 'Identidade do Cliente',False);
end;

procedure TfrmCadCliente.plsMedDataNascimentoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Data de Nascimento do Cliente',False);
end;

procedure TfrmCadCliente.plsMedDataNascimentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Data de Nascimento do Cliente',False);
end;

procedure TfrmCadCliente.plsEdEmailKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'E-mail do Cliente');
end;

procedure TfrmCadCliente.plsEdEmailEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'E-mail do Cliente');
end;

procedure TfrmCadCliente.plsMedRendimentoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Rendimento do Cliente');
end;

procedure TfrmCadCliente.plsMedRendimentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Rendimento do Cliente');
end;

procedure TfrmCadCliente.plsEdProfissaoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Profissão do Cliente',False);
end;

procedure TfrmCadCliente.plsEdProfissaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Profissão do Cliente',False);
end;

procedure TfrmCadCliente.plsEdMeioCaptacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Meio de Captação do Cliente');
end;

procedure TfrmCadCliente.plsEdMeioCaptacaoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Meio de Captação do Cliente');
end;

procedure TfrmCadCliente.plsMedTelefoneResidencialEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Residencial do Cliente');
end;

procedure TfrmCadCliente.plsMedTelefoneResidencialKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Residencial do Cliente');
end;

procedure TfrmCadCliente.plsMedTelefoneComercialKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Comercial do Cliente');
end;

procedure TfrmCadCliente.plsMedTelefoneComercialEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Comercial do Cliente');
end;

procedure TfrmCadCliente.plsMedTelefoneCelularEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Celular do Cliente');
end;

procedure TfrmCadCliente.plsMedTelefoneCelularKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Telefone Celular do Cliente');
end;

procedure TfrmCadCliente.plsEdEstadoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Estado do Cliente');
end;

procedure TfrmCadCliente.plsEdEstadoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Estado do Cliente');
end;

procedure TfrmCadCliente.plsEdCidadeEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Cidade do Cliente',False);
end;

procedure TfrmCadCliente.plsEdCidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Cidade do Cliente',False);
end;

procedure TfrmCadCliente.plsEdBairroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Bairro do Cliente');
end;

procedure TfrmCadCliente.plsEdBairroEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Bairro do Cliente');
end;

procedure TfrmCadCliente.plsEdRuaEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Rua do Cliente');
end;

procedure TfrmCadCliente.plsEdRuaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Rua do Cliente');
end;

procedure TfrmCadCliente.plsMedCEPKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'CEP da Rua do Cliente');
end;

procedure TfrmCadCliente.plsMedCEPEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'CEP da Rua do Cliente');
end;

procedure TfrmCadCliente.plsMmEnderecoComplementoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Complemento do Endereço do Cliente');
end;

procedure TfrmCadCliente.plsMmEnderecoComplementoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Complemento do Endereço do Cliente');
end;

procedure TfrmCadCliente.plsCbBxPeriodoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente',True,2);
end;

procedure TfrmCadCliente.plsCbBxPeriodoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente',True,2);
end;

procedure TfrmCadCliente.plsMedHoraLigacaoInicioEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente');
end;

procedure TfrmCadCliente.plsMedHoraLigacaoInicioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente');
end;

procedure TfrmCadCliente.plsMedHoraLigacaoFinalKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente');
end;

procedure TfrmCadCliente.plsMedHoraLigacaoFinalEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO, 'Perído de ligação para o Cliente');
end;

procedure TfrmCadCliente.lblDicasClick(Sender: TObject);
begin
  inherited;
  FoFuncoes.CriarTelaDicas(FORM_CAD_CLIENTE);
end;

procedure TfrmCadCliente.plsMedDataCaptacaoEnter(Sender: TObject);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Data de Captação',False);
end;

procedure TfrmCadCliente.plsMedDataCaptacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  MostrarHintCampos(STRING_INDEFINIDO,'Data de Captação',False);
end;

end.

