(*
  agenciador - pessoa jurídica
*)
unit unCadPessoaJuridica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, StdCtrls, plsEdit,
  ComCtrls, ToolWin, plsComboBox, plsMemo, Buttons, Mask, plsTMaskEdit,
  ExtCtrls, unObjPessoaJuridica;

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
  TfrmCadPessoaJuridica = class(TfrmCadastroBasico)
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    lblNome: TLabel;
    lblCampoObrigatorio1: TLabel;
    plsEdNome: TPlsEdit;
    lblCPF: TLabel;
    plsMedCNPJ: TPlsMaskEdit;
    plsEdEmail: TPlsEdit;
    lblEmail: TLabel;
    grpBxTelefones: TGroupBox;
    lblResidencial: TLabel;
    lblComercial: TLabel;
    lblCelular: TLabel;
    plsMedTelefoneResidencial: TPlsMaskEdit;
    plsMedTelefoneComercial: TPlsMaskEdit;
    plsMedTelefoneCelular: TPlsMaskEdit;
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
    lblCampoObrigatorio4: TLabel;
    lblCampoObrigatorio3: TLabel;
    plsEdEstado: TPlsEdit;
    plsEdCidade: TPlsEdit;
    plsMedCEP: TPlsMaskEdit;
    plsEdRua: TPlsEdit;
    plsEdBairro: TPlsEdit;
    plsMmEnderecoComplemento: TPlsMemo;
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
    lblCampoObrigatorio2: TLabel;
    plsEdMeioCaptacao: TPlsEdit;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
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
    procedure plsEdEstadoClick(Sender: TObject);
    procedure plsEdEstadoKeyPress(Sender: TObject; var Key: Char);
    procedure spBtnBuscaCidadeClick(Sender: TObject);
    procedure plsEdCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCidadeClick(Sender: TObject);
    procedure spBtnBuscaBairroClick(Sender: TObject);
    procedure plsEdBairroKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdBairroClick(Sender: TObject);
    procedure spBtnBuscaRuaClick(Sender: TObject);
    procedure plsEdRuaKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdRuaClick(Sender: TObject);
    procedure spBtnBuscaMeioCaptacaoClick(Sender: TObject);
    procedure plsEdMeioCaptacaoKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdMeioCaptacaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FoPessoaJuridica: TObjPessoaJuridica;
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
  frmCadPessoaJuridica: TfrmCadPessoaJuridica;

implementation

uses unPesquisandoPessoaJuridica, unConstantes, unDM,
  unSelecionaRegistroEstado, unSelecionaRegistroCidade,
  unSelecionaRegistroBairro, unSelecionaRegistroRua, unFuncoes,
  unVariaveis, unSelecionaRegistroPessoaJuridica,
  unSelecionaRegistroMeioCaptacao, unSelecionaRegistroPessoaFisica,
  unCadAgenciamento;

{$R *.dfm}

{ TfrmCadPessoaJuridica }

(* procedimentos de controle *)

procedure TfrmCadPessoaJuridica.iniciarTela(poForm: TForm);
begin
  inherited;
(*
  Application.CreateForm(TfrmPesquisandoPessoaFisica, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmCadPessoaFisica);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
*)
end;

procedure TfrmCadPessoaJuridica.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_CRIA_TELA_PESQUISA)then
  begin
    Application.CreateForm(TfrmPesquisandoPessoaJuridica, Self.FoPesquisa);
    Self.FoPesquisa.passarParametro(PRM_INICIAR_TELA, null);
    Self.FoPesquisa.iniciarTela(frmCadPessoaJuridica);
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
  end;
end;

procedure TfrmCadPessoaJuridica.limparObjeto();
begin
  if (Assigned(Self.FoPessoaJuridica)) then
  begin
    Self.FoPessoaJuridica.limparObjeto();
  end
end;

procedure TfrmCadPessoaJuridica.limparTela(poForm: TForm);
begin
  inherited;
  Self.FoEstado.codigo := NUMERO_INDEFINIDO;
  Self.FoEstado.nome := STRING_INDEFINIDO;

  Self.FoCidade.codigo := NUMERO_INDEFINIDO;
  Self.FoCidade.nome := STRING_INDEFINIDO;

  Self.FoBairro.codigo := NUMERO_INDEFINIDO;
  Self.FoBairro.nome := STRING_INDEFINIDO;

  Self.FoRua.codigo := NUMERO_INDEFINIDO;
  Self.FoRua.nome := STRING_INDEFINIDO;
  Self.FoRua.cep := STRING_INDEFINIDO;

  Self.FoMeioCaptacao.codigo := NUMERO_INDEFINIDO;
  Self.FoMeioCaptacao.nome := STRING_INDEFINIDO;
end;

procedure TfrmCadPessoaJuridica.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoPessoaJuridica))) then
  begin
    Self.FoPessoaJuridica.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoPessoaJuridica.setDataCadastro(cdsDadosDATA_CADASTRO.AsDateTime);
    Self.FoPessoaJuridica.setNome(cdsDadosNOME.AsString);
    Self.FoPessoaJuridica.setEmail(cdsDadosEMAIL.AsString);
    Self.FoPessoaJuridica.setCNPJ(cdsDadosCNPJ.AsString);
    Self.FoPessoaJuridica.setTelefoneResidencial(cdsDadosTELEFONE_RESIDENCIAL.AsString);
    Self.FoPessoaJuridica.setTelefoneComercial(cdsDadosTELEFONE_COMERCIAL.AsString);
    Self.FoPessoaJuridica.setTelefoneCelular(cdsDadosTELEFONE_CELULAR.AsString);
    Self.FoPessoaJuridica.setFkMeioCaptacao(cdsDadosCOD_FK_MEIO_CAPTACAO.AsInteger);
    Self.FoPessoaJuridica.setFkEstado(cdsDadosCOD_FK_ESTADO.AsInteger);
    Self.FoPessoaJuridica.setFkCidade(cdsDadosCOD_FK_CIDADE.AsInteger);
    Self.FoPessoaJuridica.setFkBairro(cdsDadosCOD_FK_BAIRRO.AsInteger);
    Self.FoPessoaJuridica.setFkRua(cdsDadosCOD_FK_RUA.AsInteger);
    Self.FoPessoaJuridica.setEnderecoCEP(cdsDadosENDERECO_CEP.AsString);
    Self.FoPessoaJuridica.setEnderecoComplemento(cdsDadosENDERECO_COMPLEMENTO.AsString);
    Self.FoPessoaJuridica.setHorarioLigacao(cdsDadosHORARIO_LIGACAO.AsString);
    Self.FoPessoaJuridica.setHoraInicio(cdsDadosHORA_INICIO.AsDateTime);
    Self.FoPessoaJuridica.setHoraFinal(cdsDadosHORA_FINAL.AsDateTime);
    Self.FoPessoaJuridica.setExibeMeioCaptacao(False);
    Self.FoPessoaJuridica.setExibeEstado(False);
    Self.FoPessoaJuridica.setExibeCidade(False);
    Self.FoPessoaJuridica.setExibeBairro(False);
    Self.FoPessoaJuridica.setExibeRua(False);
  end
  else
  begin
    Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadPessoaJuridica.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadPessoaJuridica.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoPessoaJuridica))then
  begin
    if(Self.FoPessoaJuridica.getCodigo <> NUMERO_INDEFINIDO)then
      plsEdCodigo.Text := IntToStr(Self.FoPessoaJuridica.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdNome.Text := Self.FoPessoaJuridica.getNome;
    plsMedCNPJ.Text := Self.FoPessoaJuridica.getCNPJ;
    plsEdEmail.Text := Self.FoPessoaJuridica.getEmail;
    plsEdMeioCaptacao.Text := Self.FoPessoaJuridica.getExibeMeioCaptacao;
    Self.FoMeioCaptacao.codigo := Self.FoPessoaJuridica.getFkMeioCaptacao;
    Self.FoMeioCaptacao.nome := Self.FoPessoaJuridica.getExibeMeioCaptacao;
    plsMedTelefoneResidencial.Text := Self.FoPessoaJuridica.getTelefoneResidencial;
    plsMedTelefoneComercial.Text := Self.FoPessoaJuridica.getTelefoneComercial;
    plsMedTelefoneCelular.Text := Self.FoPessoaJuridica.getTelefoneCelular;
    plsEdEstado.Text := Self.FoPessoaJuridica.getExibeEstado;
    Self.FoEstado.codigo := Self.FoPessoaJuridica.getFkEstado;
    Self.FoEstado.nome := Self.FoPessoaJuridica.getExibeEstado;
    plsEdCidade.Text := Self.FoPessoaJuridica.getExibeCidade;
    Self.FoCidade.codigo := Self.FoPessoaJuridica.getFkCidade;
    Self.FoCidade.nome := Self.FoPessoaJuridica.getExibeCidade;
    plsEdBairro.Text := Self.FoPessoaJuridica.getExibeBairro;
    Self.FoBairro.codigo := Self.FoPessoaJuridica.getFkBairro;
    Self.FoBairro.nome := Self.FoPessoaJuridica.getExibeBairro;
    plsEdRua.Text := Self.FoPessoaJuridica.getExibeRua;
    Self.FoRua.codigo := Self.FoPessoaJuridica.getFkRua;
    Self.FoRua.nome := Self.FoPessoaJuridica.getExibeRua;
    plsMedCEP.Text := Self.FoPessoaJuridica.getEnderecoCEP;
    plsMmEnderecoComplemento.Text := Self.FoPessoaJuridica.getEnderecoComplemento;

    if(Self.FoPessoaJuridica.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_MANHA)then
      plsCbBxPeriodo.ItemIndex := 0
    else if(Self.FoPessoaJuridica.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_TARDE)then
      plsCbBxPeriodo.ItemIndex := 1
    else if(Self.FoPessoaJuridica.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_NOITE)then
      plsCbBxPeriodo.ItemIndex := 2
    else if(Self.FoPessoaJuridica.getHorarioLigacao = PESSOA_FISICA_HORARIO_LIGACAO_QUALQUER)then
      plsCbBxPeriodo.ItemIndex := 3
    else
      plsCbBxPeriodo.ItemIndex := -1;

    if(Self.FoPessoaJuridica.getHoraInicio <> NUMERO_INDEFINIDO)then
      plsMedHoraLigacaoInicio.Text := TimeToStr(Self.FoPessoaJuridica.getHoraInicio)
    else
      plsMedHoraLigacaoInicio.Clear;

    if(Self.FoPessoaJuridica.getHoraFinal <> NUMERO_INDEFINIDO)then
      plsMedHoraLigacaoFinal.Text := TimeToStr(Self.FoPessoaJuridica.getHoraFinal)
    else
      plsMedHoraLigacaoFinal.Clear;
  end;
end;

procedure TfrmCadPessoaJuridica.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM agenc_pessoa_juridica ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadPessoaJuridica.verificarHouveAlteracoes(): boolean;
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

  try
    bAlteracao := Self.FoPessoaJuridica.verificarDiferencaCadastro(sNome,sEmail,
     sCNPJ,sTelefoneResidencial,sTelefoneComercial,sTelefoneCelular,iMeioCaptacao,
     iEstado,iCidade,iBairro,iRua,sEnderecoCEP,sEnderecoComplemento,sHorarioLigacao,
     tHoraInicio,tHoraFinal);
  except
    bAlteracao := True;
  end;
  Result := bAlteracao;
end;

function TfrmCadPessoaJuridica.verificarCamposObrigatorios(): boolean;
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

procedure TfrmCadPessoaJuridica.visibilidade(pnVisib: Integer);
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

function TfrmCadPessoaJuridica.outrasValidacoesAntesSalvar(): Boolean;
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

procedure TfrmCadPessoaJuridica.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadPessoaJuridica);
  visibilidade(OPC_NOVO);
end;

function TfrmCadPessoaJuridica.salvar(): boolean;
var
  bSalvou: boolean;

  sNome,sEmail,sCNPJ: String;
  sTelefoneResidencial,sTelefoneComercial,sTelefoneCelular: String;
  nCodFK_MeioCaptacao,nCodFK_Estado,nCodFK_Cidade,nCodFK_Bairro,nCodFK_Rua: Integer;
  sEnderecoCEP,sEnderecoComplemento,sHoraLigacao: String;
  tHoraLigacaoInicio,tHoraLigacaoFinal: TTime;

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
        zQryDados.SQL.Add('UPDATE agenc_pessoa_juridica SET nome=:nom,email=:ema,cnpj=:cnpj, ');
        zQryDados.SQL.Add('telefone_residencial=:tel_res,telefone_comercial=:tel_com, ');
        zQryDados.SQL.Add('telefone_celular=:tel_cel,cod_fk_meio_captacao=:cod_fk_mei_cap, ');
        zQryDados.SQL.Add('cod_fk_estado=:cod_fk_est,cod_fk_cidade=:cod_fk_cid,');
        zQryDados.SQL.Add('cod_fk_bairro=:cod_fk_bai,cod_fk_rua=:cod_fk_rua,');
        zQryDados.SQL.Add('endereco_cep=:end_cep,endereco_complemento=:end_com,');
        zQryDados.SQL.Add('horario_ligacao=:hor_lig,hora_inicio=:hor_ini,hora_final=:hor_fin ');
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
        zQryDados.ParamByName('cod').AsInteger := Self.FoPessoaJuridica.getCodigo();
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
        zQryDados.SQL.Add('INSERT INTO agenc_pessoa_juridica (nome,email,cnpj,');
        zQryDados.SQL.Add('telefone_residencial,telefone_comercial,telefone_celular,');
        zQryDados.SQL.Add('cod_fk_meio_captacao,cod_fk_estado,cod_fk_cidade,');
        zQryDados.SQL.Add('cod_fk_bairro,cod_fk_rua,endereco_cep,endereco_complemento,');
        zQryDados.SQL.Add('horario_ligacao,hora_inicio,hora_final) ');
        zQryDados.SQL.Add('VALUES (:nom,:ema,:cnpj,:tel_res,:tel_com,:tel_cel,');
        zQryDados.SQL.Add(':cod_fk_mei_cap,:cod_fk_est,:cod_fk_cid,:cod_fk_bai,');
        zQryDados.SQL.Add(':cod_fk_rua,:end_cep,:end_com,:hor_lig,:hor_ini,:hor_fin)');
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

  if(bSalvou)then
    Self.verificarInseriuChamadaTelaExterna();

  if((bSalvou)and(not(FbChamadaExternaInserirRegistro)))and
    (not(Self.FbChamadaExternaEditarRegistro))then
    Self.FoPesquisa.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS,null);

  Result := bSalvou;
end;

procedure TfrmCadPessoaJuridica.verificarInseriuChamadaTelaExterna();
var
  nCodigo: Integer;
  sNome: String;
  vParametros: Variant;
begin
  nCodigo := NUMERO_INDEFINIDO;
  sNome := STRING_INDEFINIDO;

  if(Self.FbChamadaExternaInserirRegistro)then
  begin
    DM.zQryAgencPessoaJuridica.Close;
    DM.zQryAgencPessoaJuridica.SQL.Clear;
    DM.zQryAgencPessoaJuridica.SQL.Add('SELECT * FROM agenc_pessoa_juridica ORDER BY codigo DESC ROWS 1');
    DM.zQryAgencPessoaJuridica.Open;
    if(DM.zQryAgencPessoaJuridica.RecordCount = 1)then
      nCodigo := DM.zQryAgencPessoaJuridicaCODIGO.AsInteger
    else
      nCodigo := NUMERO_INDEFINIDO;

    if(Self.FiTelaExternaChamouInserirRegistro = FORM_SELECIONA_REGISTRO_PESSOA_JURIDICA)then
    begin
      frmSelecionaRegistroPessoaJuridica.passarParametro(PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO,nCodigo);
      Self.Close;
      Exit;
    end;
  end

  else if(Self.FbChamadaExternaEditarRegistro)then
  begin
    DM.zQryAgencPessoaJuridica.Close;
    DM.zQryAgencPessoaJuridica.SQL.Clear;
    DM.zQryAgencPessoaJuridica.SQL.Add('SELECT * FROM agenc_pessoa_juridica ');
    DM.zQryAgencPessoaJuridica.SQL.Add('WHERE codigo=:codigo');
    DM.zQryAgencPessoaJuridica.ParamByName('codigo').AsInteger := Self.FoPessoaJuridica.getCodigo;
    DM.zQryAgencPessoaJuridica.Open;
    if(DM.zQryAgencPessoaJuridica.RecordCount = 1)then
    begin
      nCodigo := DM.zQryAgencPessoaJuridicaCODIGO.AsInteger;
      sNome := DM.zQryAgencPessoaJuridicaNOME.AsString;
    end;

    if(Self.FiTelaExternaChamouEditarRegistro = FORM_CAD_AGENCIAMENTOS)then
    begin
      vParametros := VarArrayCreate([0,2], varVariant);
      vParametros[0] := nCodigo;
      vParametros[1] := sNome;
      vParametros[2] := EDITOU_PESSOA;
      frmCadAgenciamento.passarParametro(PRM_EDITOU_REGISTRO_AGENCIAMENTO_STAND_BY,vParametros);
      Self.Close;
      Exit;
    end;
  end;
end;

function TfrmCadPessoaJuridica.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM agenc_pessoa_juridica WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoPessoaJuridica.getCodigo();
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

function TfrmCadPessoaJuridica.verificarRegistroJaExiste(): boolean;
var
  bRetorno: Boolean;
begin
  bRetorno := False;

  //nome,cnpj,estado e cidade iguais
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM agenc_pessoa_juridica WHERE nome=:nom AND cnpj=:cnpj ');
  zQryDados.SQL.Add('AND cod_fk_estado=:cod_fk_est AND cod_fk_cidade=:cod_fk_cid');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoPessoaJuridica.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoPessoaJuridica.getCodigo;
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
        zQryDados.SQL.Add('SELECT * FROM agenc_pessoa_juridica WHERE cnpj=:cnpj ');
        //se estiver editando, pode salvar com os mesmos dados
        if(Self.FoPessoaJuridica.getCodigo <> NUMERO_INDEFINIDO)then
        begin
          zQryDados.SQL.Add(' AND codigo <> :cod');
          zQryDados.ParamByName('cod').AsInteger := Self.FoPessoaJuridica.getCodigo;
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

function TfrmCadPessoaJuridica.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  Result := bPodeDeletar;
end;

procedure TfrmCadPessoaJuridica.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

//limpa os campos do endereço, a partir daquele que alterou
procedure TfrmCadPessoaJuridica.limparEndereco(iEnderecoChamou: String);
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

//valida se o acesso ao endereço pode ser realizado
function TfrmCadPessoaJuridica.validarAcessoEndereco(iEnderecoChamou: String): boolean;
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

procedure TfrmCadPessoaJuridica.editarRegistroChamadaExterna();

  procedure pesquisarRegistro();
  begin
    cdsDados.Close;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('SELECT * FROM agenc_pessoa_juridica WHERE codigo=:cod');
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
    MessageDlg('Erro ao pesquisar por pessoa jurídica ao editar agenciamento stand by.', mtWarning, [mbOK], 0);
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadPessoaJuridica.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoPessoaJuridica := TObjPessoaJuridica.Create;
  Self.FnCodigoEditar := NUMERO_INDEFINIDO;
  Self.FbPodeLimparEndereco := True;
end;

procedure TfrmCadPessoaJuridica.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoPessoaJuridica);
end;

procedure TfrmCadPessoaJuridica.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadPessoaJuridica.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadPessoaJuridica.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadPessoaJuridica.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadPessoaJuridica.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadPessoaJuridica.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadPessoaJuridica.plsEdCodigoExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadPessoaJuridica.plsEdCodigoKeyUp(Sender: TObject;
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
        Self.FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadPessoaJuridica.plsEdNomeExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadPessoaJuridica.plsEdNomeKeyUp(Sender: TObject;
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
        Self.FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadPessoaJuridica.plsMedCNPJExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadPessoaJuridica.plsMedCNPJKeyUp(Sender: TObject;
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
        Self.FoPesquisa.Show;
      end;
    end;
  end;

  Self.FbPesquisouKeyEnter := False;
end;

procedure TfrmCadPessoaJuridica.spBtnBuscaEstadoClick(Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmSelecionaRegistroEstado, frmSelecionaRegistroEstado);
    frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_PESSOA_JURIDICA);
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

procedure TfrmCadPessoaJuridica.plsEdEstadoClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaEstadoClick(Self);
end;

procedure TfrmCadPessoaJuridica.plsEdEstadoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaEstadoClick(Self);
end;

procedure TfrmCadPessoaJuridica.spBtnBuscaCidadeClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('CIDADE'))then
    MessageDlg('Um estado deve estar selecionado.', mtInformation, [mbOK], 0)
  else
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroCidade, frmSelecionaRegistroCidade);
      frmSelecionaRegistroCidade.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_PESSOA_JURIDICA);
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

procedure TfrmCadPessoaJuridica.plsEdCidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaCidadeClick(Self);
end;

procedure TfrmCadPessoaJuridica.plsEdCidadeClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaCidadeClick(Self);
end;

procedure TfrmCadPessoaJuridica.spBtnBuscaBairroClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('BAIRRO'))then
    MessageDlg('Uma cidade deve estar selecionada.', mtInformation, [mbOK], 0)
  else
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
      frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_PESSOA_JURIDICA);
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

procedure TfrmCadPessoaJuridica.plsEdBairroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaBairroClick(Self);
end;

procedure TfrmCadPessoaJuridica.plsEdBairroClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaBairroClick(Self);
end;

procedure TfrmCadPessoaJuridica.spBtnBuscaRuaClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('RUA'))then
    MessageDlg('Um bairro deve estar selecionado.', mtInformation, [mbOK], 0)
  else
  begin
    try
      Application.CreateForm(TfrmSelecionaRegistroRua, frmSelecionaRegistroRua);
      frmSelecionaRegistroRua.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_PESSOA_JURIDICA);
      frmSelecionaRegistroRua.passarParametro('FK_COD_BAIRRO', Self.FoBairro.codigo);
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
end;

procedure TfrmCadPessoaJuridica.plsEdRuaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaRuaClick(Self);
end;

procedure TfrmCadPessoaJuridica.plsEdRuaClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaRuaClick(Self);
end;

procedure TfrmCadPessoaJuridica.spBtnBuscaMeioCaptacaoClick(
  Sender: TObject);
begin
  inherited;
  try
    Application.CreateForm(TfrmSelecionaRegistroMeioCaptacao, frmSelecionaRegistroMeioCaptacao);
    frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_INICIAR_TELA, null);
    frmSelecionaRegistroMeioCaptacao.passarParametro(PRM_TELA_CHAMOU, FORM_CAD_PESSOA_JURIDICA);
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

procedure TfrmCadPessoaJuridica.plsEdMeioCaptacaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if(Key=#13)then
    spBtnBuscaMeioCaptacaoClick(Self);
end;

procedure TfrmCadPessoaJuridica.plsEdMeioCaptacaoClick(Sender: TObject);
begin
  inherited;
  spBtnBuscaMeioCaptacaoClick(Self);
end;

procedure TfrmCadPessoaJuridica.FormShow(Sender: TObject);
begin
  if(FbChamadaExternaEditarRegistro)then
  begin
    Self.editarRegistroChamadaExterna();
  end
  else
    inherited;
end;

end.
