(*
  cliente - pessoa f�sica
*)
unit unCadCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, ComCtrls, ToolWin,
  StdCtrls, plsMemo, Buttons, Mask, plsTMaskEdit, plsEdit, unObjCliente,
  ExtCtrls, plsComboBox;

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
    lblEstado: TLabel;
    plsEdEstado: TPlsEdit;
    spBtnBuscaEstado: TSpeedButton;
    spBtnBuscaCidade: TSpeedButton;
    plsEdCidade: TPlsEdit;
    lblCidade: TLabel;
    lblBairro: TLabel;
    lblRua: TLabel;
    plsMedCEP: TPlsMaskEdit;
    lblCEP: TLabel;
    plsEdRua: TPlsEdit;
    plsEdBairro: TPlsEdit;
    spBtnBuscaBairro: TSpeedButton;
    spBtnBuscaRua: TSpeedButton;
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
    lblCampoObrigatorio4: TLabel;
    lblCampoObrigatorio5: TLabel;
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
    procedure plsEdEstadoClick(Sender: TObject);
    procedure plsEdCidadeClick(Sender: TObject);
    procedure plsEdBairroClick(Sender: TObject);
    procedure plsEdRuaClick(Sender: TObject);
    procedure plsEdMeioCaptacaoClick(Sender: TObject);
    procedure plsEdProfissaoClick(Sender: TObject);
    procedure plsEdProfissaoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdMeioCaptacaoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdEstadoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdBairroKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdRuaKeyPress(Sender: TObject; var Key: Char);
    procedure spBtnBuscaMeioCaptacaoClick(Sender: TObject);
  private
    FoCliente: TObjCliente;
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
    procedure limparEndereco(iEnderecoChamou: String); //limpa os campos do endere�o, a partir daquele que alterou
    function validarAcessoEndereco(iEnderecoChamou: String): boolean; //valida se o acesso ao endere�o pode ser realizado
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

uses unConstantes, unDM, unPesquisandoCliente, unSelecionaRegistroEstado,
  unSelecionaRegistroCidade, unSelecionaRegistroBairro,
  unSelecionaRegistroRua, unSelecionaRegistroProfissao, unVariaveis,
  unSelecionaRegistroMeioCaptacao, unSelecionaRegistroCliente;

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
    Self.FoCliente.setExibeProfissao(False);
    Self.FoCliente.setExibeMeioCaptacao(False);
    Self.FoCliente.setExibeEstado(False);
    Self.FoCliente.setExibeCidade(False);
    Self.FoCliente.setExibeBairro(False);
    Self.FoCliente.setExibeRua(False);
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadCliente.carregarObjeto();','Acesso Indispon�vel');
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

  try
    bAlteracao := Self.FoCliente.verificarDiferencaCadastro(dDataCaptacao,
    iProfissao,iMeioCaptacao,iEstado,iCidade,iBairro,iRua,sEnderecoCEP,
    sEnderecoComplemento,sNome,sEmail,sTelefoneResidencial,sTelefoneComercial,
    sTelefoneCelular,sCPF,sIdentidade,dDataNascimento,sHorarioLigacao,
    tHoraInicio,tHoraFinal);
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
    campos := 'Data Capta��o';
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

  //verifica hor�rio da liga��o
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
      MessageDlg('Verifique o hor�rio da liga��o.', mtInformation, [mbOK], 0);
      compFoco := plsMedHoraLigacaoFinal;
    end
    else if((tHoraInicio=NUMERO_INDEFINIDO)and(tHoraFinal<>NUMERO_INDEFINIDO))then
    begin
      MessageDlg('Verifique o hor�rio da liga��o.', mtInformation, [mbOK], 0);
      compFoco := plsMedHoraLigacaoInicio;
    end;
  end;

  //setar foco no componente que n�o foi validado
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
    if(not(Self.FoFuncoes.validarCPF(sCPF)))then
    begin
      MessageDlg('CPF inv�lido.',mtWarning,[mbOK],0);
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
        MessageDlg('Data de nascimento inv�lida.',mtWarning,[mbOK],0);
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
        MessageDlg('Email inv�lido.',mtWarning,[mbOK],0);
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
        MessageDlg('Telefone residencial inv�lido.',mtWarning,[mbOK],0);
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
        MessageDlg('Telefone comercial inv�lido.',mtWarning,[mbOK],0);
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
        MessageDlg('Telefone celular inv�lido.',mtWarning,[mbOK],0);
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
        MessageDlg('Hor�rio de in�cio da liga��o inv�lida.',mtWarning,[mbOK],0);
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
        MessageDlg('Hor�rio final da liga��o inv�lida.',mtWarning,[mbOK],0);
        compFoco := plsMedHoraLigacaoFinal;
        bRetorno := False;
      end;
    end;
  end;

  //setar foco no componente que n�o foi validado
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
  end;

  //limpa par�metro nulos - para o insert e update
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
        zQryDados.SQL.Add('horario_ligacao=:hor_lig,hora_inicio=:hor_ini,hora_final=:hor_fin ');
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
        zQryDados.SQL.Add('horario_ligacao,hora_inicio,hora_final) ');
        zQryDados.SQL.Add('VALUES(:dt_cap,:cod_fk_pro,:cod_fk_me_cap,:cod_fk_est,');
        zQryDados.SQL.Add(':cod_fk_cid,:cod_fk_bai,:cod_fk_rua,:end_cep,:end_com,');
        zQryDados.SQL.Add(':nom,:ema,:tel_res,:tel_com,:tel_cel,:cpf,:ide,:dat_nas,');
        zQryDados.SQL.Add(':hor_lig,:hor_ini,:hor_fin)');
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
    MessageDlg('Cliente j� cadastrado.', mtWarning, [mbOK], 0);
  end
  else
  begin
    //cpf igual
    if(Self.FoFuncoes.retirarCaracteres(plsMedCPF.Text,'.-')<>STRING_INDEFINIDO)then
    begin
      if(Self.FoFuncoes.validarCPF(plsMedCPF.Text))then
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
          MessageDlg('Cliente com este CPF j� cadastrado.', mtWarning, [mbOK], 0);
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

//limpa os campos do endere�o, a partir daquele que alterou
procedure TfrmCadCliente.limparEndereco(iEnderecoChamou: String);
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
  if(Self.FbPodeLimparEndereco)then
  begin
    if(iEnderecoChamou = 'ESTADO')then
    begin
      limparCidade();
      limparBairro();
      limparRua();
    end
    else if(iEnderecoChamou = 'CIDADE')then
    begin
      limparBairro();
      limparRua();
    end
    else if(iEnderecoChamou = 'BAIRRO')then
    begin
      limparRua();
    end;
  end;

  Self.FbPodeLimparEndereco := True;
end;

//valida se o acesso ao endere�o pode ser realizado
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

(* fim - procedimentos de controle *)

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoCliente := TObjCliente.Create;
  Self.FbPodeLimparEndereco := True;
end;

procedure TfrmCadCliente.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoCliente);
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
  try
    Application.CreateForm(TfrmSelecionaRegistroProfissao, frmSelecionaRegistroProfissao);
    frmSelecionaRegistroProfissao.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
    frmSelecionaRegistroProfissao.ShowModal;
  finally
    if(FoProfissao.codigo <> NUMERO_INDEFINIDO)then
    begin
      plsEdProfissao.Text := Self.FoProfissao.nome;
      Self.FoFuncoes.focarComponente(plsEdMeioCaptacao);
    end;
    FreeAndNil(frmSelecionaRegistroProfissao);
  end;
end;

procedure TfrmCadCliente.spBtnBuscaEstadoClick(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmSelecionaRegistroEstado, frmSelecionaRegistroEstado);
    frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
    frmSelecionaRegistroEstado.ShowModal;
  finally
    if(FoEstado.codigo <> NUMERO_INDEFINIDO)then
    begin
      plsEdEstado.Text := FoEstado.nome;
      limparEndereco('ESTADO');
      Self.FoFuncoes.focarComponente(plsEdCidade);
    end;
    FreeAndNil(frmSelecionaRegistroEstado);
  end;
end;

procedure TfrmCadCliente.spBtnBuscaCidadeClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('CIDADE'))then
    MessageDlg('Um estado deve estar selecionado.', mtInformation, [mbOK], 0)
  else
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroCidade, frmSelecionaRegistroCidade);
      frmSelecionaRegistroCidade.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
      frmSelecionaRegistroCidade.passarParametro('FK_COD_ESTADO', Self.FoEstado.codigo);
      frmSelecionaRegistroCidade.ShowModal;
    finally
      if(FoCidade.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdCidade.Text := FoCidade.nome;
        limparEndereco('CIDADE');
        Self.FoFuncoes.focarComponente(plsEdBairro);
      end;
      FreeAndNil(frmSelecionaRegistroCidade);
    end;
  end;
end;

procedure TfrmCadCliente.spBtnBuscaBairroClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('BAIRRO'))then
    MessageDlg('Uma cidade deve estar selecionada.', mtInformation, [mbOK], 0)
  else
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
      frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
      frmSelecionaRegistroBairro.passarParametro('FK_COD_CIDADE', Self.FoCidade.codigo);
      frmSelecionaRegistroBairro.ShowModal;
    finally
      if(FoBairro.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdBairro.Text := FoBairro.nome;
        limparEndereco('BAIRRO');
        Self.FoFuncoes.focarComponente(plsEdRua);
      end;
      FreeAndNil(frmSelecionaRegistroBairro);
    end;
  end;
end;

procedure TfrmCadCliente.spBtnBuscaRuaClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('RUA'))then
    MessageDlg('Um bairro deve estar selecionado.', mtInformation, [mbOK], 0)
  else
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroRua, frmSelecionaRegistroRua);
      frmSelecionaRegistroRua.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
      frmSelecionaRegistroRua.passarParametro('FK_COD_BAIRRO', Self.FoBairro.codigo);
      frmSelecionaRegistroRua.ShowModal;
    finally
      if(FoRua.codigo <> NUMERO_INDEFINIDO)then
      begin
        plsEdRua.Text := Self.FoRua.nome;
        plsMedCEP.Text := Self.FoRua.cep;
        Self.FoFuncoes.focarComponente(plsMmEnderecoComplemento);
      end;
      FreeAndNil(frmSelecionaRegistroBairro);
    end;
  end;
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
        {vParametros[0] = par�metro do campo da pesquisa
        vParametros[1] = campo da pesquisa
        vParametros[1] = valor da pesquisa
         }
        vParametros[0] := PRM_PESQUISA_NOME;
        vParametros[1] := 'NOME';
        vParametros[2] := sValor;
        Self.FoPesquisa.passarParametro(PRM_PESQUISAR_REGISTRO, vParametros);
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
        {vParametros[0] = par�metro do campo da pesquisa
        vParametros[1] = campo da pesquisa
        vParametros[1] = valor da pesquisa
         }
        vParametros[0] := PRM_PESQUISA_CPF;
        vParametros[1] := 'CPF';
        vParametros[2] := sValor;
        Self.FoPesquisa.passarParametro(PRM_PESQUISAR_REGISTRO, vParametros);
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
        {vParametros[0] = par�metro do campo da pesquisa
        vParametros[1] = campo da pesquisa
        vParametros[1] = valor da pesquisa
         }
        vParametros[0] := PRM_PESQUISA_IDENTIDADE;
        vParametros[1] := 'IDENTIDADE';
        vParametros[2] := sValor;
        Self.FoPesquisa.passarParametro(PRM_PESQUISAR_REGISTRO, vParametros);
        Self.FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;                       

procedure TfrmCadCliente.plsEdEstadoClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaEstadoClick(Self);
end;

procedure TfrmCadCliente.plsEdCidadeClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaCidadeClick(Self);
end;

procedure TfrmCadCliente.plsEdBairroClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaBairroClick(Self);
end;

procedure TfrmCadCliente.plsEdRuaClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaRuaClick(Self);
end;

procedure TfrmCadCliente.plsEdMeioCaptacaoClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaMeioCaptacaoClick(Self);
end;

procedure TfrmCadCliente.plsEdProfissaoClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaProfissaoClick(Self);
end;

procedure TfrmCadCliente.plsEdProfissaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaProfissaoClick(Self);
end;

procedure TfrmCadCliente.plsEdMeioCaptacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaMeioCaptacaoClick(Self);
end;

procedure TfrmCadCliente.plsEdEstadoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaEstadoClick(Self);
end;

procedure TfrmCadCliente.plsEdCidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaCidadeClick(Self);
end;

procedure TfrmCadCliente.plsEdBairroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaBairroClick(Self);
end;

procedure TfrmCadCliente.plsEdRuaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaRuaClick(Self);
end;

procedure TfrmCadCliente.spBtnBuscaMeioCaptacaoClick(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmSelecionaRegistroMeioCaptacao, frmSelecionaRegistroMeioCaptacao);
    frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_INICIAR_TELA, null);
    frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_CLIENTE);
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

end.
