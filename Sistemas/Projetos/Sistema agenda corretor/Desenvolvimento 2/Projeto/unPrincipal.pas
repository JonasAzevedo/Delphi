unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, unFuncoes, StdCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, unSistema, ExtCtrls, ComCtrls, unUsuario,
  Grids, DBGrids, Buttons, jpeg, plsEdit, AdvCircularProgress, EllipsLabel,
  AdvCardList, AdvGlowButton, DBClient, Provider, unBckupRestore;

  type TControlaAtalhoAgenciamento = record
    nTotalStandBy: Integer;
    nTotalExpirando: Integer;
  end;

type
  TfrmPrincipal = class(TForm)
    mainMenu: TMainMenu;
    menuCadastro: TMenuItem;
    mnItCidades: TMenuItem;
    mnItBairros: TMenuItem;
    mnItRuas: TMenuItem;
    mnItDivisao1: TMenuItem;
    mnItConstrutoras: TMenuItem;
    mnItProfissoes: TMenuItem;
    mnItClientes: TMenuItem;
    mnItTipoImovel: TMenuItem;
    mnItAgenciadorPessoaFisica: TMenuItem;
    mnItAgenciamentos: TMenuItem;
    mnItImovel: TMenuItem;
    StatusBar: TStatusBar;
    mnItAgenda: TMenuItem;
    mnItNovoCompromisso: TMenuItem;
    mnItConsultaCompromisso: TMenuItem;
    menuImovel: TMenuItem;
    mnItDivisao2: TMenuItem;
    mnItAgenciadorPessoaJuridica: TMenuItem;
    mnItAjuda: TMenuItem;
    mnItSobre: TMenuItem;
    mnItMeioCaptacao: TMenuItem;
    mnItAdministracao: TMenuItem;
    mnItAlterarSenha: TMenuItem;
    zQryAgenciamentosStandBy: TZQuery;
    dsAgenciamentosStandBy: TDataSource;
    pnlDetalheAgenciamentosStandBy: TPanel;
    pnlBarraDetalhesAgenciamentosStandBy: TPanel;
    dbGrdDetalheAgenciamentosStandBy: TDBGrid;
    lblEsconderDetalhesAgenciamentosStandBy: TLabel;
    ppMnAgenciamentosStandBy2: TPopupMenu;
    mnItFinalizarCadastro2: TMenuItem;
    mnItImovelDeInteresse: TMenuItem;
    zQryAgenciamentosExpirando: TZQuery;
    dsAgenciamentosExpirando: TDataSource;
    ppMnAgenciamentosExpirando: TPopupMenu;
    mnItEditarAgenciamentoExpirando: TMenuItem;
    mnItVendas: TMenuItem;
    mnItConsultar: TMenuItem;
    mnItPesquisarAgenciamentos: TMenuItem;
    mnItPesquisarImoveisdeInteresse: TMenuItem;
    mnItPesquisarVendas: TMenuItem;
    TimerDataHora: TTimer;
    Image: TImage;
    mnItAgenciadores: TMenuItem;
    mnItClientePessoaFisica: TMenuItem;
    mnItClientePessoaJuridica: TMenuItem;
    mnItDivisao3: TMenuItem;
    mnItGrupoConfiguracaoImovel: TMenuItem;
    mnItSubGrupoConfImovel: TMenuItem;
    mnItDivisao4: TMenuItem;
    mnItDicas: TMenuItem;
    mnItGrupoBemNegociavel: TMenuItem;
    mnItSubGrupoBemNegociavel: TMenuItem;
    mnItRegiaoLocalidades: TMenuItem;
    advGlwBtnAgenciamentosStandBy: TAdvGlowButton;
    advGlwBtnAgenciamentosExpirando: TAdvGlowButton;
    zQryAgenciamentosStandByCODIGO: TIntegerField;
    zQryAgenciamentosStandByTIPO_PESSOA: TStringField;
    zQryAgenciamentosStandByNOME_TIPO_PESSOA: TStringField;
    zQryAgenciamentosStandByCONDICAO_PAGAMENTO: TStringField;
    zQryAgenciamentosStandByCC_VALOR_TOTAL_AGENCIAMENTO: TStringField;
    zQryAgenciamentosStandBySITUACAO_DESEJAVEL: TStringField;
    zQryAgenciamentosStandByNOME_TIPO_IMOVEL: TStringField;
    zQryAgenciamentosStandByESTADO: TStringField;
    zQryAgenciamentosStandByCIDADE: TStringField;
    zQryAgenciamentosStandByBAIRRO: TStringField;
    dspAgenciamentosStandBy: TDataSetProvider;
    cdsAgenciamentosStandBy: TClientDataSet;
    cdsAgenciamentosStandByCODIGO: TIntegerField;
    cdsAgenciamentosStandByTIPO_PESSOA: TStringField;
    cdsAgenciamentosStandByNOME_TIPO_PESSOA: TStringField;
    cdsAgenciamentosStandByCONDICAO_PAGAMENTO: TStringField;
    cdsAgenciamentosStandByCC_VALOR_TOTAL_AGENCIAMENTO: TStringField;
    cdsAgenciamentosStandBySITUACAO_DESEJAVEL: TStringField;
    cdsAgenciamentosStandByNOME_TIPO_IMOVEL: TStringField;
    cdsAgenciamentosStandByESTADO: TStringField;
    cdsAgenciamentosStandByCIDADE: TStringField;
    cdsAgenciamentosStandByBAIRRO: TStringField;
    zQryAgenciamentosExpirandoCODIGO: TIntegerField;
    zQryAgenciamentosExpirandoTIPO_PESSOA: TStringField;
    zQryAgenciamentosExpirandoNOME_TIPO_PESSOA: TStringField;
    zQryAgenciamentosExpirandoCONDICAO_PAGAMENTO: TStringField;
    zQryAgenciamentosExpirandoCC_VALOR_TOTAL_AGENCIAMENTO: TStringField;
    zQryAgenciamentosExpirandoSITUACAO_DESEJAVEL: TStringField;
    zQryAgenciamentosExpirandoNOME_TIPO_IMOVEL: TStringField;
    zQryAgenciamentosExpirandoESTADO: TStringField;
    zQryAgenciamentosExpirandoCIDADE: TStringField;
    zQryAgenciamentosExpirandoBAIRRO: TStringField;
    dspAgenciamentosExpirando: TDataSetProvider;
    cdsAgenciamentosExpirando: TClientDataSet;
    cdsAgenciamentosExpirandoCODIGO: TIntegerField;
    cdsAgenciamentosExpirandoTIPO_PESSOA: TStringField;
    cdsAgenciamentosExpirandoNOME_TIPO_PESSOA: TStringField;
    cdsAgenciamentosExpirandoCONDICAO_PAGAMENTO: TStringField;
    cdsAgenciamentosExpirandoCC_VALOR_TOTAL_AGENCIAMENTO: TStringField;
    cdsAgenciamentosExpirandoSITUACAO_DESEJAVEL: TStringField;
    cdsAgenciamentosExpirandoNOME_TIPO_IMOVEL: TStringField;
    cdsAgenciamentosExpirandoESTADO: TStringField;
    cdsAgenciamentosExpirandoCIDADE: TStringField;
    cdsAgenciamentosExpirandoBAIRRO: TStringField;
    pnlDetalheAgenciamentosExpirando: TPanel;
    pnlBarraDetalhesAgenciamentosExpirando: TPanel;
    lblEsconderDetalhesAgenciamentosExpirando: TLabel;
    dbGrdDetalheAgenciamentosExpirando: TDBGrid;
    pnlTopoAgenciamentosExpirando: TPanel;
    lblAgenciamentosExpirando: TLabel;
    pnlTopoAgenciamentosStandBy: TPanel;
    lblAgenciamentosStandBy: TLabel;
    advGlwBtnRegistreSistema: TAdvGlowButton;
    tmrRealizarBackup: TTimer;
    mnItExecutarBckup: TMenuItem;
    mnItRestaurarBackup: TMenuItem;
    procedure mnItEstadoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnItCidadesClick(Sender: TObject);
    procedure mnItBairrosClick(Sender: TObject);
    procedure mnItRuasClick(Sender: TObject);
    procedure mnItConstrutorasClick(Sender: TObject);
    procedure mnItProfissoesClick(Sender: TObject);
    procedure mnItTipoImovelClick(Sender: TObject);
    procedure mnItAgenciadorPessoaFisicaClick(Sender: TObject);
    procedure mnItAgenciamentosClick(Sender: TObject);
    procedure mnItImovelClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnItNovoCompromissoClick(Sender: TObject);
    procedure mnItConsultaCompromissoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblTotCompromissosHojeClick(Sender: TObject);
    procedure lblTotCompromissoProximos7DiasClick(Sender: TObject);
    procedure lblTotTotalCompromissosEmAbertoClick(Sender: TObject);
    procedure mnItSobreClick(Sender: TObject);
    procedure mnItMeioCaptacaoClick(Sender: TObject);
    procedure mnItAlterarSenhaClick(Sender: TObject);
    procedure lblEsconderDetalhesAgenciamentosStandByClick(
      Sender: TObject);
    procedure mnItAgenciadorPessoaJuridicaClick(Sender: TObject);
    procedure mnItImovelDeInteresseClick(Sender: TObject);
    procedure mnItEditarAgenciamentoExpirandoClick(Sender: TObject);
    procedure mnItFinalizarCadastroClick(Sender: TObject);
    procedure mnItVendasClick(Sender: TObject);
    procedure mnItPesquisarAgenciamentosClick(Sender: TObject);
    procedure mnItPesquisarImoveisdeInteresseClick(Sender: TObject);
    procedure mnItPesquisarVendasClick(Sender: TObject);
    procedure TimerDataHoraTimer(Sender: TObject);
    procedure mnItClientePessoaFisicaClick(Sender: TObject);
    procedure mnItClientePessoaJuridicaClick(Sender: TObject);
    procedure mnItGrupoConfiguracaoImovelClick(Sender: TObject);
    procedure mnItSubGrupoConfImovelClick(Sender: TObject);
    procedure mnItDicasClick(Sender: TObject);
    procedure mnItGrupoBemNegociavelClick(Sender: TObject);
    procedure mnItSubGrupoBemNegociavelClick(Sender: TObject);
    procedure mnItRegiaoLocalidadesClick(Sender: TObject);
    procedure advGlwBtnAgenciamentosStandByClick(Sender: TObject);
    procedure advGlwBtnAgenciamentosExpirandoClick(Sender: TObject);
    procedure mnItFinalizarCadastro2Click(Sender: TObject);
    procedure dbGrdDetalheAgenciamentosStandByDblClick(Sender: TObject);
    procedure dbGrdDetalheAgenciamentosExpirandoDblClick(Sender: TObject);
    procedure lblEsconderDetalhesAgenciamentosExpirandoClick(
      Sender: TObject);
    procedure advGlwBtnRegistreSistemaClick(Sender: TObject);
    procedure tmrRealizarBackupTimer(Sender: TObject);
    procedure mnItExecutarBckupClick(Sender: TObject);
    procedure mnItRestaurarBackupClick(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
    FoSistema: TSistema;
    FoUsuario: TUsuario;
    FoBackupRestore: TBackupRestore;
    FoAtalhoAgenciamento: TControlaAtalhoAgenciamento;

    procedure FinalizarAgenciamentoStandBy(pnCodigoAgenciamento: Integer);
    procedure EditarAgenciamentoExpirando(pnCodigoAgenciamento: Integer);
    procedure ConfigurarRalizarBackup;
  public
    procedure abrirConsultaCompromissos(const psCompromissos: String);
    procedure mostrarAgenciamentosStandBy();
    procedure mostrarAgenciamentosExpirando();
    procedure mensagensUsuarioIniciarSistema();
    procedure passarParametro(pTipo:String; pValores:OleVariant);
    function GetCdUsuario: Integer; //código do usuário logado
    function GetNomeUsuario: String; //nome do usuário logado
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  unConstantes, unCadEstado, unCadCidade, unLixo, unCadBairro, unCadRua,
  unCadConstrutora, unCadProfissao, unCadCliente, unCadTipoImovel,
  unCadPessoaFisica, unCadAgenciamento, unCadImoveis, unDM,
  unCadAgenda, DateUtils, unConsultaCompromissosAgenda, unLogin, Unit3,
  unSobre, unCadMeioCaptacao, unAlterarLoginSistema, unCadPessoaJuridica,
  unCadImovelInteresse, unCadVenda, unPesquisarAgenciamentos,
  unPesquisarImoveisInteresse, unPesquisarVendas,
  unCadClientePessoaJuridica, unCadGrupoConfiguracaoImovel,
  unCadSubGrupoConfiguracaoImovel, unCadDicas, unCadGrupoBemNegociavel,
  unCadSubGrupoBemNegociavel, unCadRegiaoLocalidade, unRestaurarBackup; //unCadVenda;

const
  consCOMPROMISSOS_HOJE = 'HOJE';
  consCOMPROMISSOS_PROXIMOS_7_DIAS = 'PROX_7_DIAS';
  consCOMPROMISSOS_EM_ABERTO = 'EM_ABERTO';

{$R *.dfm}

{ TfrmPrincipal }

(* procedimentos de controle *)

procedure TfrmPrincipal.passarParametro(pTipo:String; pValores:OleVariant);

  procedure mostrarAgenciamentosStandByAoAbrirSistema;
  begin
    Self.MostrarAgenciamentosStandBy;
    //esconde agenciamentos stand by se não existem
    if(FoAtalhoAgenciamento.nTotalStandBy > NUMERO_INDEFINIDO)then
      advGlwBtnAgenciamentosStandBy.Visible := True
    else
      advGlwBtnAgenciamentosStandBy.Visible := False;
  end;

  procedure mostrarAgenciamentosExpirandoAoAbrirSistema;
  begin
    Self.MostrarAgenciamentosExpirando;
    //esconde agenciamentos expirando se não existem
    if(FoAtalhoAgenciamento.nTotalExpirando > NUMERO_INDEFINIDO)then
      advGlwBtnAgenciamentosExpirando.Visible := True
    else
      advGlwBtnAgenciamentosExpirando.Visible := False;
  end;

begin
  inherited;
  if(pTipo = PRM_REALIZOU_LOGIN)then
  begin
    try
      FoUsuario.setCodigo(pValores[0]);
      FoUsuario.setNome(pValores[1]);
      StatusBar.Panels[0].Text := 'USUÁRIO: ' + Self.FoUsuario.getNome;
      if(FoUsuario.getCodigo <> NUMERO_INDEFINIDO)then
        FoUsuario.iniciarLog;
      mostrarAgenciamentosStandByAoAbrirSistema;
      mostrarAgenciamentosExpirandoAoAbrirSistema;
      mensagensUsuarioIniciarSistema;
    except
    end;
  end

  else if(pTipo = PRM_ATUALIZAR_AGENCIAMENTOS_EDITANDO)then
  begin
    mostrarAgenciamentosExpirandoAoAbrirSistema;
  end

  else if(pTipo = PRM_ATUALIZAR_AGENCIAMENTOS_STANDBY)then
  begin
    mostrarAgenciamentosStandByAoAbrirSistema;
  end

end;

procedure TfrmPrincipal.abrirConsultaCompromissos(const psCompromissos: String);
  procedure passarParametros();
  var
    vParametros: Variant;
  begin
    vParametros := VarArrayCreate([0,3], varVariant);
    if (psCompromissos = consCOMPROMISSOS_HOJE)then
    begin
      vParametros[0] := Date;
      vParametros[1] := StrToTime('00:00:00');
      vParametros[2] := Date;
      vParametros[3] := StrToTime('23:59:59');
      frmConsultaCompromissosAgenda.passarParametro(PRM_CONSULTA_COMPROMISSOS_AGENDA, vParametros);
    end
    else if (psCompromissos = consCOMPROMISSOS_PROXIMOS_7_DIAS)then
    begin
      vParametros[0] := Date;
      vParametros[1] := StrToTime('00:00:00');
      vParametros[2] := IncDay(Date,7);
      vParametros[3] := StrToTime('23:59:59');
      frmConsultaCompromissosAgenda.passarParametro(PRM_CONSULTA_COMPROMISSOS_AGENDA, vParametros);
    end
    else if (psCompromissos = consCOMPROMISSOS_EM_ABERTO)then
    begin
      frmConsultaCompromissosAgenda.passarParametro(PRM_CRIA_TELA_CONSULTA_COMPROMISSOS_AGENDA_NORMAL, null);
    end;
  end;

begin

  try
    Application.CreateForm(TfrmConsultaCompromissosAgenda, frmConsultaCompromissosAgenda);
    passarParametros();
    frmConsultaCompromissosAgenda.ShowModal;
  finally
    FreeAndNil(frmConsultaCompromissosAgenda);
  end;
end;

procedure TfrmPrincipal.mostrarAgenciamentosStandBy;
var
  sSQL: String;
  sValorMonetario: String;
begin
  sSQL := STRING_INDEFINIDO;

  //agenciamentos standBy
  sSQL := 'SELECT a.codigo, a.tipo_pessoa,';
  sSQL := sSQL + 'CASE WHEN a.tipo_pessoa = ''FÍSICA'' THEN pf.nome ';
  sSQL := sSQL + 'WHEN a.tipo_pessoa = ''JURÍDICA'' THEN pj.nome ';
  sSQL := sSQL + 'ELSE ''NENHUMA'' END AS NOME_TIPO_PESSOA,';
  sSQL := sSQL + 'a.condicao_pagamento,';
  sSQL := sSQL + 'CAST(a.valor_total  AS VARCHAR(20)) AS CC_VALOR_TOTAL_AGENCIAMENTO,';
  sSQL := sSQL + 'i.situacao_desejavel,ti.nome AS NOME_TIPO_IMOVEL,';
  sSQL := sSQL + 'est.sigla AS estado,cid.nome AS cidade,bai.nome AS bairro ';
  sSQL := sSQL + 'FROM agenciamentos a ';
  sSQL := sSQL + 'JOIN agenc_pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo ';
  sSQL := sSQL + 'JOIN agenc_pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo ';
  sSQL := sSQL + 'JOIN imovel i ON a.cod_fk_imovel = i.codigo ';
  sSQL := sSQL + 'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ';
  sSQL := sSQL + 'JOIN estado est ON i.cod_fk_estado = est.codigo ';
  sSQL := sSQL + 'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ';
  sSQL := sSQL + 'JOIN bairro bai ON i.cod_fk_bairro = bai.codigo ';
  sSQL := sSQL + 'WHERE a.stand_by = ''SIM'' ';
  sSQL := sSQL + 'AND a.ativo = ''SIM'' ';

  cdsAgenciamentosStandBy.Close;
  zQryAgenciamentosStandBy.Close;
  zQryAgenciamentosStandBy.SQL.Clear;
  zQryAgenciamentosStandBy.SQL.Add(sSQL);
  zQryAgenciamentosStandBy.Open;
  cdsAgenciamentosStandBy.Open;

  //formatando valores
  if((cdsAgenciamentosStandBy.Active)and(cdsAgenciamentosStandBy.RecordCount>NUMERO_INDEFINIDO))then
  begin
    cdsAgenciamentosStandBy.First;
    while(not(cdsAgenciamentosStandBy.Eof))do
    begin
      cdsAgenciamentosStandBy.Edit;

      sValorMonetario :=  cdsAgenciamentosStandByCC_VALOR_TOTAL_AGENCIAMENTO.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsAgenciamentosStandByCC_VALOR_TOTAL_AGENCIAMENTO.AsString := FoFuncoes.formatarValorMonetario(sValorMonetario);
      cdsAgenciamentosStandBy.Post;

      cdsAgenciamentosStandBy.Next;
    end;
    advGlwBtnAgenciamentosStandBy.Caption := 'Agenciamentos Stand By (' +
      IntToStr(cdsAgenciamentosStandBy.RecordCount) + ')';
  end;

  FoAtalhoAgenciamento.nTotalStandBy := cdsAgenciamentosStandBy.RecordCount;
end;

procedure TfrmPrincipal.mostrarAgenciamentosExpirando;
var
  sSQL: String;
  sValorMonetario: String;
begin
  sSQL := STRING_INDEFINIDO;

  //agenciamentos expirando
  //agenciamentos standBy
  sSQL := 'SELECT a.codigo, a.tipo_pessoa,';
  sSQL := sSQL + 'CASE WHEN a.tipo_pessoa = ''FÍSICA'' THEN pf.nome ';
  sSQL := sSQL + 'WHEN a.tipo_pessoa = ''JURÍDICA'' THEN pj.nome ';
  sSQL := sSQL + 'ELSE ''NENHUMA'' END AS NOME_TIPO_PESSOA,';
  sSQL := sSQL + 'a.condicao_pagamento,';
  sSQL := sSQL + 'CAST(a.valor_total  AS VARCHAR(20)) AS CC_VALOR_TOTAL_AGENCIAMENTO,';
  sSQL := sSQL + 'i.situacao_desejavel,ti.nome AS NOME_TIPO_IMOVEL,';
  sSQL := sSQL + 'est.sigla AS estado,cid.nome AS cidade,bai.nome AS bairro ';
  sSQL := sSQL + 'FROM agenciamentos a ';
  sSQL := sSQL + 'JOIN agenc_pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo ';
  sSQL := sSQL + 'JOIN agenc_pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo ';
  sSQL := sSQL + 'JOIN imovel i ON a.cod_fk_imovel = i.codigo ';
  sSQL := sSQL + 'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ';
  sSQL := sSQL + 'JOIN estado est ON i.cod_fk_estado = est.codigo ';
  sSQL := sSQL + 'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ';
  sSQL := sSQL + 'JOIN bairro bai ON i.cod_fk_bairro = bai.codigo ';
  sSQL := sSQL + 'WHERE a.ativo = ''SIM'' ';
  sSQL := sSQL + 'AND ((a.data_reagenciamento < current_timestamp) OR ';
  sSQL := sSQL + '(a.prazo_autorizacao < current_timestamp AND ';
  sSQL := sSQL + 'a.data_reagenciamento IS NULL))';

  cdsAgenciamentosExpirando.Close;
  zQryAgenciamentosExpirando.Close;
  zQryAgenciamentosExpirando.SQL.Clear;
  zQryAgenciamentosExpirando.SQL.Add(sSQL);
  zQryAgenciamentosExpirando.Open;
  cdsAgenciamentosExpirando.Open;

  //formatando valores
  if((cdsAgenciamentosExpirando.Active)and(cdsAgenciamentosExpirando.RecordCount>NUMERO_INDEFINIDO))then
  begin
    cdsAgenciamentosExpirando.First;
    while(not(cdsAgenciamentosExpirando.Eof))do
    begin
      cdsAgenciamentosExpirando.Edit;

      sValorMonetario :=  cdsAgenciamentosExpirandoCC_VALOR_TOTAL_AGENCIAMENTO.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsAgenciamentosExpirandoCC_VALOR_TOTAL_AGENCIAMENTO.AsString := FoFuncoes.formatarValorMonetario(sValorMonetario);
      cdsAgenciamentosExpirando.Post;

      cdsAgenciamentosExpirando.Next;
    end;
    advGlwBtnAgenciamentosExpirando.Caption := 'Agenciamentos Expirando (' +
      IntToStr(cdsAgenciamentosExpirando.RecordCount) + ')';
  end;

  FoAtalhoAgenciamento.nTotalExpirando := cdsAgenciamentosExpirando.RecordCount;
end;

procedure TfrmPrincipal.mensagensUsuarioIniciarSistema();
var
  nTotAgenciamentosStandBy: Integer;
  nTotAgenciamentosExpirando: Integer;
begin
  //mensagens para agenciamentos stand by
  try
    nTotAgenciamentosStandBy := FoAtalhoAgenciamento.nTotalStandBy;
  except
    nTotAgenciamentosStandBy := NUMERO_INDEFINIDO;
  end;

  if(nTotAgenciamentosStandBy > NUMERO_INDEFINIDO)then
    MessageDlg('Existem ' + IntToStr(nTotAgenciamentosStandBy) + ' agenciamentos stand by.',
     mtInformation, [mbOK], 0);

  //mensagens para agenciamentos expirando
  try
    nTotAgenciamentosExpirando := FoAtalhoAgenciamento.nTotalExpirando;
  except
    nTotAgenciamentosExpirando := NUMERO_INDEFINIDO;
  end;

  if(nTotAgenciamentosExpirando > NUMERO_INDEFINIDO)then
    MessageDlg('Existem ' + IntToStr(nTotAgenciamentosExpirando) + ' agenciamentos expirando.',
     mtInformation, [mbOK], 0);
end;

procedure TfrmPrincipal.EditarAgenciamentoExpirando(pnCodigoAgenciamento: Integer);
begin
  if(pnCodigoAgenciamento <> NUMERO_INDEFINIDO)then
  begin
    try
      Application.CreateForm(TfrmCadAgenciamento, frmCadAgenciamento);
      frmCadAgenciamento.iniciarTela(frmCadAgenciamento);
      frmCadAgenciamento.passarParametro(PRM_EDITAR_AGENCIAMENTO_EXPIROU, pnCodigoAgenciamento);
      frmCadAgenciamento.ShowModal;
    finally
      FoFuncoes.fecharComponentesBD(frmCadAgenciamento);
      FreeAndNil(frmCadAgenciamento);
    end;
  end;
end;

procedure TfrmPrincipal.FinalizarAgenciamentoStandBy(pnCodigoAgenciamento: Integer);
begin
  if(pnCodigoAgenciamento <> NUMERO_INDEFINIDO)then
  begin
    try
      Application.CreateForm(TfrmCadAgenciamento, frmCadAgenciamento);
      frmCadAgenciamento.iniciarTela(frmCadAgenciamento);
      frmCadAgenciamento.passarParametro(PRM_FINALIZAR_AGENCIAMENTO_STANDBY, pnCodigoAgenciamento);
      frmCadAgenciamento.ShowModal;
    finally
      FoFuncoes.fecharComponentesBD(frmCadAgenciamento);
      FreeAndNil(frmCadAgenciamento);
    end;
  end;
end;

//código do usuário logado
function TfrmPrincipal.GetCdUsuario: Integer;
begin
  try
    Result := Self.FoUsuario.getCodigo;
  except
    Result := NUMERO_INDEFINIDO;
  end;
end;

//nome do usuário logado
function TfrmPrincipal.GetNomeUsuario: String;
begin
  try
    Result := Self.FoUsuario.getNome;
  except
    Result := STRING_INDEFINIDO;
  end;
end;

procedure TfrmPrincipal.ConfigurarRalizarBackup;
var
  nMinutos: Integer;
begin
  DM.zQryParametrosSistema.Close;
  DM.zQryParametrosSistema.SQL.Clear;
  DM.zQryParametrosSistema.SQL.Add('SELECT * FROM parametros_sistema WHERE codigo=1');
  DM.zQryParametrosSistema.Open;
  if(DM.zQryParametrosSistema.Active)and(DM.zQryParametrosSistema.RecordCount=1)then
  begin
    nMinutos := DM.zQryParametrosSistemaTEMPO_REALIZAR_BACKUP.AsInteger * 1000 * 60;
    tmrRealizarBackup.Interval := nMinutos;
    tmrRealizarBackup.Enabled := True;
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmPrincipal.mnItEstadoClick(Sender: TObject);
begin
(*
  try
    Application.CreateForm(TfrmCadEstado, frmCadEstado);
    frmCadEstado.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadEstado);
    FreeAndNil(frmCadEstado);
  end;
*)
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FoUsuario := TUsuario.Create;  
  try
    Application.CreateForm(TfrmLogin, frmLogin);
    frmLogin.ShowModal;
  finally
    FreeAndNil(frmLogin);
  end;

  //se o login foi realizado
  if(FoUsuario.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    FoFuncoes := TFuncoes.Create;
    FoSistema := TSistema.Create;
    FoBackupRestore := TBackupRestore.Create;
    FoBackupRestore.DeletarBackupAntigo;
    FoBackupRestore.RealizarBackup;
    ConfigurarRalizarBackup;
  end;

  FoAtalhoAgenciamento.nTotalStandBy := NUMERO_INDEFINIDO;
  FoAtalhoAgenciamento.nTotalExpirando := NUMERO_INDEFINIDO;
  FoFuncoes.AjustarLarguraColunasTDBGrid(dbGrdDetalheAgenciamentosStandBy);
  FoFuncoes.AjustarLarguraColunasTDBGrid(dbGrdDetalheAgenciamentosExpirando);

  //sistema não registrado
  if not(FoSistema.VerificarRegistroSistema)then
  begin
    mnItCidades.Enabled := False;
    mnItBairros.Enabled := False;
    mnItRuas.Enabled := False;
    mnItRegiaoLocalidades.Enabled := False;
    mnItConstrutoras.Enabled := False;
    mnItProfissoes.Enabled := False;
    mnItMeioCaptacao.Enabled := False;
    mnItTipoImovel.Enabled := False;
    mnItGrupoConfiguracaoImovel.Enabled := False;
    mnItSubGrupoConfImovel.Enabled := False;
    mnItGrupoBemNegociavel.Enabled := False;
    mnItSubGrupoBemNegociavel.Enabled := False;
    mnItDicas.Enabled := False;
    mnItAgenciamentos.Enabled := False;
    mnItImovelDeInteresse.Enabled := False;
    mnItVendas.Enabled := False;
    mnItPesquisarAgenciamentos.Enabled := False;
    mnItPesquisarImoveisdeInteresse.Enabled := False;
    mnItPesquisarVendas.Enabled := False;
    mnItAlterarSenha.Enabled := False;
    mnItExecutarBckup.Enabled := False;
    mnItRestaurarBackup.Enabled := False;
    advGlwBtnAgenciamentosStandBy.Enabled := False;
    advGlwBtnAgenciamentosExpirando.Enabled := False;
    advGlwBtnRegistreSistema.Visible := True;
  end;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  try
    if(Self.FoUsuario.getCodigo <> NUMERO_INDEFINIDO)then
      Self.FoUsuario.finalizarLog;
  except
  end;
  FreeAndNil(FoFuncoes);
  FreeAndNil(FoSistema);
  FreeAndNil(FoUsuario);
  FreeAndNil(FoBackupRestore);
end;

procedure TfrmPrincipal.mnItCidadesClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadCidade, frmCadCidade);
    frmCadCidade.iniciarTela(frmCadCidade);
    frmCadCidade.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadCidade);
    FreeAndNil(frmCadCidade);
  end;
end;

procedure TfrmPrincipal.mnItBairrosClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadBairro, frmCadBairro);
    frmCadBairro.iniciarTela(frmCadBairro);
    frmCadBairro.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadBairro);
    FreeAndNil(frmCadBairro);
  end;
end;

procedure TfrmPrincipal.mnItRuasClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadRua, frmCadRua);
    frmCadRua.iniciarTela(frmCadRua);
    frmCadRua.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadRua);
    FreeAndNil(frmCadRua);
  end;
end;

procedure TfrmPrincipal.mnItConstrutorasClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadConstrutora, frmCadConstrutora);
    frmCadConstrutora.iniciarTela(frmCadConstrutora);
    frmCadConstrutora.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadConstrutora);
    FreeAndNil(frmCadConstrutora);
  end;
end;

procedure TfrmPrincipal.mnItProfissoesClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadProfissao, frmCadProfissao);
    frmCadProfissao.iniciarTela(frmCadProfissao);
    frmCadProfissao.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadProfissao);
    FreeAndNil(frmCadProfissao);
  end;
end;

procedure TfrmPrincipal.mnItTipoImovelClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadTipoImovel, frmCadTipoImovel);
    frmCadTipoImovel.iniciarTela(frmCadTipoImovel);
    frmCadTipoImovel.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadTipoImovel);
    FreeAndNil(frmCadTipoImovel);
  end;
end;

procedure TfrmPrincipal.mnItAgenciadorPessoaFisicaClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadPessoaFisica, frmCadPessoaFisica);
    frmCadPessoaFisica.iniciarTela(frmCadPessoaFisica);
    frmCadPessoaFisica.passarParametro(PRM_CRIA_TELA_PESQUISA, null);
    frmCadPessoaFisica.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadPessoaFisica);
    FreeAndNil(frmCadPessoaFisica);
  end;
end;

procedure TfrmPrincipal.mnItAgenciamentosClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadAgenciamento, frmCadAgenciamento);
    frmCadAgenciamento.iniciarTela(frmCadAgenciamento);
//    frmCadAgenciamento.passarParametro(PRM_CRIA_TELA_PESQUISA, null);
    frmCadAgenciamento.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadAgenciamento);
    FreeAndNil(frmCadAgenciamento);
  end;
end;

procedure TfrmPrincipal.mnItImovelClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadImoveis, frmCadImoveis);
    frmCadImoveis.iniciarTela(frmCadImoveis);
    //frmCadImoveis.passarParametro(PRM_INICIAR_TELA, null);
    frmCadImoveis.passarParametro(PRM_CRIA_TELA_PESQUISA, null);
    frmCadImoveis.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadImoveis);
    FreeAndNil(frmCadImoveis);
  end;
end;

procedure TfrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(key=121)then //F10
  begin
    try
      Application.CreateForm(TfrmCadAgenda, frmCadAgenda);
      frmCadAgenda.ShowModal;
    finally
      FreeAndNil(frmCadAgenda);
    end;
  end;
end;

procedure TfrmPrincipal.mnItNovoCompromissoClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadAgenda, frmCadAgenda);
    frmCadAgenda.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadAgenda);
    FreeAndNil(frmCadAgenda);
  end;
end;

procedure TfrmPrincipal.mnItConsultaCompromissoClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmConsultaCompromissosAgenda, frmConsultaCompromissosAgenda);
    frmConsultaCompromissosAgenda.passarParametro(PRM_CRIA_TELA_CONSULTA_COMPROMISSOS_AGENDA_NORMAL, null);
    frmConsultaCompromissosAgenda.ShowModal;
  finally
    FreeAndNil(frmConsultaCompromissosAgenda);
  end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
//  mostrarTotalCompromissosAgenda();
end;

procedure TfrmPrincipal.lblTotCompromissosHojeClick(Sender: TObject);
begin
  abrirConsultaCompromissos(consCOMPROMISSOS_HOJE);
end;

procedure TfrmPrincipal.lblTotCompromissoProximos7DiasClick(
  Sender: TObject);
begin
  abrirConsultaCompromissos(consCOMPROMISSOS_PROXIMOS_7_DIAS);
end;

procedure TfrmPrincipal.lblTotTotalCompromissosEmAbertoClick(Sender: TObject);
begin
  abrirConsultaCompromissos(consCOMPROMISSOS_EM_ABERTO);
end;

procedure TfrmPrincipal.mnItSobreClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmSobre, frmSobre);
    frmSobre.ShowModal;
  finally
    FreeAndNil(frmSobre);
  end;
end;

procedure TfrmPrincipal.mnItMeioCaptacaoClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadMeioCaptacao, frmCadMeioCaptacao);
    frmCadMeioCaptacao.iniciarTela(frmCadMeioCaptacao);
    frmCadMeioCaptacao.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadMeioCaptacao);
    FreeAndNil(frmCadMeioCaptacao);
  end;
end;

procedure TfrmPrincipal.mnItAlterarSenhaClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmAlterarLoginSistema, frmAlterarLoginSistema);
    frmAlterarLoginSistema.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmAlterarLoginSistema);
    FreeAndNil(frmAlterarLoginSistema);
  end;
end;

procedure TfrmPrincipal.lblEsconderDetalhesAgenciamentosStandByClick(
  Sender: TObject);
begin
  pnlDetalheAgenciamentosStandBy.Visible := False;
end;

procedure TfrmPrincipal.mnItAgenciadorPessoaJuridicaClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadPessoaJuridica, frmCadPessoaJuridica);
    frmCadPessoaJuridica.iniciarTela(frmCadPessoaJuridica);
    frmCadPessoaJuridica.passarParametro(PRM_CRIA_TELA_PESQUISA, null);
    frmCadPessoaJuridica.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadPessoaJuridica);
    FreeAndNil(frmCadPessoaJuridica);
  end;
end;

procedure TfrmPrincipal.mnItImovelDeInteresseClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadImovelInteresse, frmCadImovelInteresse);
    frmCadImovelInteresse.iniciarTela(frmCadImovelInteresse);
    frmCadImovelInteresse.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadImovelInteresse);
    FreeAndNil(frmCadImovelInteresse);
  end;
end;

procedure TfrmPrincipal.mnItEditarAgenciamentoExpirandoClick(
  Sender: TObject);
begin
  if(zQryAgenciamentosExpirando.RecordCount>0)and(zQryAgenciamentosExpirando.Active)then
    EditarAgenciamentoExpirando(zQryAgenciamentosExpirandoCODIGO.AsInteger);
end;

procedure TfrmPrincipal.mnItFinalizarCadastroClick(Sender: TObject);
begin
  if(zQryAgenciamentosStandBy.RecordCount>0)and(zQryAgenciamentosStandBy.Active)then
    FinalizarAgenciamentoStandBy(zQryAgenciamentosStandByCODIGO.AsInteger);
end;

procedure TfrmPrincipal.mnItVendasClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadVenda, frmCadVenda);
    frmCadVenda.iniciarTela(frmCadVenda);
    frmCadVenda.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadVenda);
    FreeAndNil(frmCadVenda);
  end;
end;

procedure TfrmPrincipal.mnItPesquisarAgenciamentosClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmPesquisarAgenciamentos, frmPesquisarAgenciamentos);
//    frmPesquisarAgenciamentos.iniciarTela(frmPesquisarAgenciamentos);
    frmPesquisarAgenciamentos.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmPesquisarAgenciamentos);
    FreeAndNil(frmPesquisarAgenciamentos);
  end;
end;

procedure TfrmPrincipal.mnItPesquisarImoveisdeInteresseClick(
  Sender: TObject);
begin
  try
    Application.CreateForm(TfrmPesquisarImoveisInteresse, frmPesquisarImoveisInteresse);
//    frmPesquisarImoveisInteresse.iniciarTela(frmPesquisarImoveisInteresse);
    frmPesquisarImoveisInteresse.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmPesquisarImoveisInteresse);
    FreeAndNil(frmPesquisarImoveisInteresse);
  end;
end;

procedure TfrmPrincipal.mnItPesquisarVendasClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmPesquisarVendas, frmPesquisarVendas);
//    frmPesquisarVendas.iniciarTela(frmPesquisarVendas);
    frmPesquisarVendas.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmPesquisarVendas);
    FreeAndNil(frmPesquisarVendas);
  end;
end;

procedure TfrmPrincipal.TimerDataHoraTimer(Sender: TObject);
begin
  StatusBar.Panels[2].Text := DateTimeToStr(Now);
end;

procedure TfrmPrincipal.mnItClientePessoaFisicaClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadCliente, frmCadCliente);
    frmCadCliente.iniciarTela(frmCadCliente);
    frmCadCliente.passarParametro(PRM_CRIA_TELA_PESQUISA, null);
    frmCadCliente.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadCliente);
    FreeAndNil(frmCadCliente);
  end;
end;

procedure TfrmPrincipal.mnItClientePessoaJuridicaClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadClientePessoaJuridica, frmCadClientePessoaJuridica);
    frmCadClientePessoaJuridica.iniciarTela(frmCadClientePessoaJuridica);
    frmCadClientePessoaJuridica.passarParametro(PRM_CRIA_TELA_PESQUISA, null);
    frmCadClientePessoaJuridica.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadClientePessoaJuridica);
    FreeAndNil(frmCadClientePessoaJuridica);
  end;
end;

procedure TfrmPrincipal.mnItGrupoConfiguracaoImovelClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadGrupoConfiguracaoImovel, frmCadGrupoConfiguracaoImovel);
    frmCadGrupoConfiguracaoImovel.iniciarTela(frmCadGrupoConfiguracaoImovel);
    frmCadGrupoConfiguracaoImovel.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadGrupoConfiguracaoImovel);
    FreeAndNil(frmCadGrupoConfiguracaoImovel);
  end;
end;

procedure TfrmPrincipal.mnItSubGrupoConfImovelClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadSubGrupoConfiguracaoImovel, frmCadSubGrupoConfiguracaoImovel);
    frmCadSubGrupoConfiguracaoImovel.iniciarTela(frmCadSubGrupoConfiguracaoImovel);
    frmCadSubGrupoConfiguracaoImovel.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadSubGrupoConfiguracaoImovel);
    FreeAndNil(frmCadSubGrupoConfiguracaoImovel);
  end;
end;

procedure TfrmPrincipal.mnItDicasClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadDica, frmCadDica);
    frmCadDica.iniciarTela(frmCadDica);
    frmCadDica.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadDica);
    FreeAndNil(frmCadDica);
  end;
end;

procedure TfrmPrincipal.mnItGrupoBemNegociavelClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadGrupoBemNegociavel, frmCadGrupoBemNegociavel);
    frmCadGrupoBemNegociavel.iniciarTela(frmCadGrupoBemNegociavel);
    frmCadGrupoBemNegociavel.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadGrupoBemNegociavel);
    FreeAndNil(frmCadGrupoBemNegociavel);
  end;
end;

procedure TfrmPrincipal.mnItSubGrupoBemNegociavelClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadSubGrupoBemNegociavel, frmCadSubGrupoBemNegociavel);
    frmCadSubGrupoBemNegociavel.iniciarTela(frmCadSubGrupoBemNegociavel);
    frmCadSubGrupoBemNegociavel.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadSubGrupoBemNegociavel);
    FreeAndNil(frmCadSubGrupoBemNegociavel);
  end;
end;

procedure TfrmPrincipal.mnItRegiaoLocalidadesClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmCadRegiaoLocalidade, frmCadRegiaoLocalidade);
    frmCadRegiaoLocalidade.iniciarTela(frmCadRegiaoLocalidade);
    frmCadRegiaoLocalidade.ShowModal;
  finally
    FoFuncoes.fecharComponentesBD(frmCadRegiaoLocalidade);
    FreeAndNil(frmCadRegiaoLocalidade);
  end;
end;


procedure TfrmPrincipal.advGlwBtnAgenciamentosStandByClick(
  Sender: TObject);
begin
  pnlDetalheAgenciamentosStandBy.Visible := True;
end;

procedure TfrmPrincipal.advGlwBtnAgenciamentosExpirandoClick(
  Sender: TObject);
begin
  pnlDetalheAgenciamentosExpirando.Visible := True;
end;

procedure TfrmPrincipal.mnItFinalizarCadastro2Click(Sender: TObject);
begin
  if(cdsAgenciamentosStandBy.RecordCount>0)and(cdsAgenciamentosStandBy.Active)then
    FinalizarAgenciamentoStandBy(cdsAgenciamentosStandByCODIGO.AsInteger);
end;

procedure TfrmPrincipal.dbGrdDetalheAgenciamentosStandByDblClick(
  Sender: TObject);
begin
  if(cdsAgenciamentosStandBy.RecordCount>0)and(cdsAgenciamentosStandBy.Active)then
    FinalizarAgenciamentoStandBy(cdsAgenciamentosStandByCODIGO.AsInteger);
end;

procedure TfrmPrincipal.dbGrdDetalheAgenciamentosExpirandoDblClick(
  Sender: TObject);
begin
  if(cdsAgenciamentosExpirando.RecordCount>0)and(cdsAgenciamentosExpirando.Active)then
    EditarAgenciamentoExpirando(cdsAgenciamentosExpirandoCODIGO.AsInteger);
end;

procedure TfrmPrincipal.lblEsconderDetalhesAgenciamentosExpirandoClick(
  Sender: TObject);
begin
  pnlDetalheAgenciamentosExpirando.Visible := False;
end;

procedure TfrmPrincipal.advGlwBtnRegistreSistemaClick(Sender: TObject);
begin
  FoFuncoes.ChamarRegistrarSistema;
end;

procedure TfrmPrincipal.tmrRealizarBackupTimer(Sender: TObject);
begin
  FoBackupRestore.RealizarBackup;
end;

procedure TfrmPrincipal.mnItExecutarBckupClick(Sender: TObject);
begin
  FoBackupRestore.RealizarBackup;
  MessageDlg('Backup realizado.',mtInformation,[mbOK],0);
end;

procedure TfrmPrincipal.mnItRestaurarBackupClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmRestaurarBackup, frmRestaurarBackup);
    frmRestaurarBackup.ShowModal;
  finally
    FreeAndNil(frmRestaurarBackup);
  end;
end;


end.

