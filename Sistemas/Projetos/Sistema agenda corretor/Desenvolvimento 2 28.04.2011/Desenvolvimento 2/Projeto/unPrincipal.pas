unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, unFuncoes, StdCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, unSistema, ExtCtrls, ComCtrls, unUsuario,
  Grids, DBGrids, Buttons, jpeg, plsEdit, AdvCircularProgress;

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
    zQryAgenda: TZQuery;
    tmrCompromissosAgenda: TTimer;
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
    mnItConfiguracoes: TMenuItem;
    mnItAlterarSenha: TMenuItem;
    zQryAgenciamentosStandBy: TZQuery;
    dsAgenciamentosStandBy: TDataSource;
    pnlDetalheAgenciamentosStandBy: TPanel;
    pnlBarraDetalhesAgenciamentosStandBy: TPanel;
    dbGrdDetalheAgenciamentosStandBy: TDBGrid;
    lblEsconderDetalhesAgenciamentosStandBy: TLabel;
    ppMnAgenciamentosStandBy: TPopupMenu;
    ppMnAgenciamentosStandBy2: TPopupMenu;
    mnItFinalizarCadastro2: TMenuItem;
    mnItFinalizarCadastro: TMenuItem;
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
    pnlInformacoesLadoEsquerdo: TPanel;
    grpBxCompromissosAgenda: TGroupBox;
    lblCompromissosHoje: TLabel;
    lblCompromissoProximos7Dias: TLabel;
    lblTotalCompromissosEmAberto: TLabel;
    lblTotCompromissosHoje: TLabel;
    lblTotCompromissoProximos7Dias: TLabel;
    lblTotTotalCompromissosEmAberto: TLabel;
    lblMaisCompromissos: TLabel;
    lblMenosCompromissos: TLabel;
    pnlDivisao1: TPanel;
    grpBxAgenciamentosStandBy: TGroupBox;
    lblTituloTotalAgenciamentosStandBy: TLabel;
    lblTotalAgenciamentosStandBy: TLabel;
    lblMenosAgenciamentosStandBy: TLabel;
    lblMaisAgenciamentosStandBy: TLabel;
    lblVerDetalhesAgenciamentosStandBy: TLabel;
    dbGrdAgenciamentosStandBy: TDBGrid;
    pnlDivisao2: TPanel;
    grpBxAgenciamentosExpirando: TGroupBox;
    lblMaisAgenciamentosExpirando: TLabel;
    lblTituloTotalAgenciamentosExpirando: TLabel;
    lblVerDetalhesAgenciamentosExpirando: TLabel;
    lblMenosAgenciamentosExpirando: TLabel;
    lblTotalAgenciamentosExpirando: TLabel;
    dbGrdAgenciamentosExpirando: TDBGrid;
    mnItAgenciadores: TMenuItem;
    mnItClientePessoaFisica: TMenuItem;
    mnItClientePessoaJuridica: TMenuItem;
    zQryAgenciamentosStandByCODIGO: TIntegerField;
    zQryAgenciamentosStandByDATA_AGENCIAMENTO: TDateField;
    zQryAgenciamentosStandBySTAND_BY: TStringField;
    zQryAgenciamentosStandByTIPO_PESSOA: TStringField;
    zQryAgenciamentosStandByCOD_FK_PESSOA_FISICA: TIntegerField;
    zQryAgenciamentosStandByCOD_FK_PESSOA_JURIDICA: TIntegerField;
    zQryAgenciamentosStandByCOD_FK_IMOVEL: TIntegerField;
    zQryAgenciamentosStandByCONDICAO_PAGAMENTO: TStringField;
    zQryAgenciamentosStandByVALOR_TOTAL: TFloatField;
    zQryAgenciamentosStandByPRAZO_AUTORIZACAO: TDateField;
    zQryAgenciamentosStandByNOMEPESSOAFISICA: TStringField;
    zQryAgenciamentosStandByNOMEPESSOAJURIDICA: TStringField;
    zQryAgenciamentosStandByCOD_FK_TIPO_IMOVEL: TIntegerField;
    zQryAgenciamentosStandByCOD_FK_ESTADO: TIntegerField;
    zQryAgenciamentosStandByCOD_FK_CIDADE: TIntegerField;
    zQryAgenciamentosStandBySITUACAO_DESEJAVEL: TStringField;
    zQryAgenciamentosStandByVALOR_IMOVEL: TFloatField;
    zQryAgenciamentosStandByNOMETIPOIMOVEL: TStringField;
    zQryAgenciamentosStandByNOMEESTADO: TStringField;
    zQryAgenciamentosStandBySIGLA: TStringField;
    zQryAgenciamentosStandByNOMECIDADE: TStringField;
    zQryAgenciamentosExpirandoCODIGO: TIntegerField;
    zQryAgenciamentosExpirandoDATA_AGENCIAMENTO: TDateField;
    zQryAgenciamentosExpirandoSTAND_BY: TStringField;
    zQryAgenciamentosExpirandoTIPO_PESSOA: TStringField;
    zQryAgenciamentosExpirandoCOD_FK_PESSOA_FISICA: TIntegerField;
    zQryAgenciamentosExpirandoCOD_FK_PESSOA_JURIDICA: TIntegerField;
    zQryAgenciamentosExpirandoCOD_FK_IMOVEL: TIntegerField;
    zQryAgenciamentosExpirandoCONDICAO_PAGAMENTO: TStringField;
    zQryAgenciamentosExpirandoVALOR_TOTAL: TFloatField;
    zQryAgenciamentosExpirandoPRAZO_AUTORIZACAO: TDateField;
    zQryAgenciamentosExpirandoNOMEPESSOAFISICA: TStringField;
    zQryAgenciamentosExpirandoNOMEPESSOAJURIDICA: TStringField;
    zQryAgenciamentosExpirandoCOD_FK_TIPO_IMOVEL: TIntegerField;
    zQryAgenciamentosExpirandoCOD_FK_ESTADO: TIntegerField;
    zQryAgenciamentosExpirandoCOD_FK_CIDADE: TIntegerField;
    zQryAgenciamentosExpirandoSITUACAO_DESEJAVEL: TStringField;
    zQryAgenciamentosExpirandoVALOR_IMOVEL: TFloatField;
    zQryAgenciamentosExpirandoNOMETIPOIMOVEL: TStringField;
    zQryAgenciamentosExpirandoNOMEESTADO: TStringField;
    zQryAgenciamentosExpirandoSIGLA: TStringField;
    zQryAgenciamentosExpirandoNOMECIDADE: TStringField;
    zQryAgendaTOTAL: TIntegerField;
    mnItDivisao3: TMenuItem;
    mnItGrupoConfiguracaoImovel: TMenuItem;
    mnItSubGrupoConfImovel: TMenuItem;
    mnItDivisao4: TMenuItem;
    mnItDicas: TMenuItem;
    mnItGrupoBemNegociavel: TMenuItem;
    mnItSubGrupoBemNegociavel: TMenuItem;
    mnItRegiaoLocalidades: TMenuItem;
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
    procedure tmrCompromissosAgendaTimer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnItNovoCompromissoClick(Sender: TObject);
    procedure mnItConsultaCompromissoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblTotCompromissosHojeClick(Sender: TObject);
    procedure lblTotCompromissoProximos7DiasClick(Sender: TObject);
    procedure lblTotTotalCompromissosEmAbertoClick(Sender: TObject);
    procedure lblMenosCompromissosClick(Sender: TObject);
    procedure lblMaisCompromissosClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure mnItSobreClick(Sender: TObject);
    procedure mnItMeioCaptacaoClick(Sender: TObject);
    procedure mnItAlterarSenhaClick(Sender: TObject);
    procedure lblMaisAgenciamentosStandByClick(Sender: TObject);
    procedure lblMenosAgenciamentosStandByClick(Sender: TObject);
    procedure lblVerDetalhesAgenciamentosStandByClick(Sender: TObject);
    procedure lblEsconderDetalhesAgenciamentosStandByClick(
      Sender: TObject);
    procedure mnItAgenciadorPessoaJuridicaClick(Sender: TObject);
    procedure mnItImovelDeInteresseClick(Sender: TObject);
    procedure lblMaisAgenciamentosExpirandoClick(Sender: TObject);
    procedure lblMenosAgenciamentosExpirandoClick(Sender: TObject);
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
  private
    FoFuncoes: TFuncoes;
    FoSistema: TSistema;
    FoUsuario: TUsuario;

    procedure FinalizarAgenciamentoStandBy(pnCodigoAgenciamento: Integer);
    procedure EditarAgenciamentoExpirando(pnCodigoAgenciamento: Integer);
    procedure AjustarPainelDireito();
  public
    procedure abrirConsultaCompromissos(const psCompromissos: String);
    procedure pesquisarCompromissosAgenda();
    procedure mostrarTotalCompromissosAgenda();
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
  unCadSubGrupoBemNegociavel, unCadRegiaoLocalidade; //unCadVenda;

const
  consCOMPROMISSOS_HOJE = 'HOJE';
  consCOMPROMISSOS_PROXIMOS_7_DIAS = 'PROX_7_DIAS';
  consCOMPROMISSOS_EM_ABERTO = 'EM_ABERTO';

{$R *.dfm}

{ TfrmPrincipal }

(* procedimentos de controle *)

procedure TfrmPrincipal.passarParametro(pTipo:String; pValores:OleVariant);

  procedure mostrarCompromissosAoAbrirSistema();
  begin
    Self.mostrarTotalCompromissosAgenda();
    //esconde compromissos se não existem
    if((lblTotCompromissosHoje.Caption = '0')and(lblTotCompromissoProximos7Dias.Caption = '0')and
     (lblTotTotalCompromissosEmAberto.Caption = '0'))then
    begin
      grpBxCompromissosAgenda.Height := 30;
      lblMaisCompromissos.Visible := True;
      lblMenosCompromissos.Visible := False;
    end
    else
    begin
      grpBxCompromissosAgenda.Height := 130;
      lblMaisCompromissos.Visible := False;
      lblMenosCompromissos.Visible := True;
    end;
  end;

  procedure mostrarAgenciamentosStandByAoAbrirSistema();
  begin
    Self.mostrarAgenciamentosStandBy();
    //esconde agenciamentos stand by se não existem
    if(lblTotalAgenciamentosStandBy.Caption = '0')then
    begin
      grpBxAgenciamentosStandBy.Height := 30;
      lblMaisAgenciamentosStandBy.Visible := True;
      lblMenosAgenciamentosStandBy.Visible := False;
    end
    else
    begin
      grpBxAgenciamentosStandBy.Height := 235;
      lblMaisAgenciamentosStandBy.Visible := False;
      lblMenosAgenciamentosStandBy.Visible := True;
    end;
  end;

  procedure mostrarAgenciamentosExpirandoAoAbrirSistema();
  begin
    Self.mostrarAgenciamentosExpirando();
    //esconde agenciamentos expirando se não existem
    if(lblTotalAgenciamentosExpirando.Caption = '0')then
    begin
      grpBxAgenciamentosExpirando.Height := 30;
      lblMaisAgenciamentosExpirando.Visible := True;
      lblMenosAgenciamentosExpirando.Visible := False;
    end
    else
    begin
      grpBxAgenciamentosExpirando.Height := 235;
      lblMaisAgenciamentosExpirando.Visible := False;
      lblMenosAgenciamentosExpirando.Visible := True;
    end;
  end;

begin
  inherited;
  if(pTipo = PRM_REALIZOU_LOGIN)then
  begin
    try
      Self.FoUsuario.setCodigo(pValores[0]);
      Self.FoUsuario.setNome(pValores[1]);
      StatusBar.Panels[0].Text := 'USUÁRIO: ' + Self.FoUsuario.getNome;
      if(Self.FoUsuario.getCodigo <> NUMERO_INDEFINIDO)then
        Self.FoUsuario.iniciarLog;
      mostrarCompromissosAoAbrirSistema();
      mostrarAgenciamentosStandByAoAbrirSistema();
      mostrarAgenciamentosExpirandoAoAbrirSistema();
      mensagensUsuarioIniciarSistema();
    except
    end;
  end

  else if(pTipo = PRM_ATUALIZAR_COMPROMISSOS_AGENDA)then
  begin
    Self.mostrarTotalCompromissosAgenda();
  end

  else if(pTipo = PRM_ATUALIZAR_AGENCIAMENTOS_EDITANDO)then
  begin
    mostrarAgenciamentosExpirandoAoAbrirSistema();
  end

  else if(pTipo = PRM_ATUALIZAR_AGENCIAMENTOS_STANDBY)then
  begin
    mostrarAgenciamentosStandByAoAbrirSistema();
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

procedure TfrmPrincipal.pesquisarCompromissosAgenda();
(*
var
  dtDataInicio: TDateTime;
  dtDataFinal: TDateTime;
*)
begin
(*
  dtDataInicio := Now;
  dtDataFinal := IncMinute(dtDataInicio, FoSistema.FnTempoAvisaAgenda);

  zQryAgendaProximos.Close;
  zQryAgendaProximos.SQL.Clear;
  zQryAgendaProximos.SQL.Add('SELECT * FROM agenda ');
  inserirCondicaoSelectNaoTrazerRegistroNulo();
  zQryAgendaProximos.SQL.Add('WHERE data_hora_aux BETWEEN :dtIni AND :dtFin ');
  zQryAgendaProximos.SQL.Add('AND status = :sta');
  zQryAgendaProximos.ParamByName('dtIni').AsDateTime := dtDataInicio;
  zQryAgendaProximos.ParamByName('dtFin').AsDateTime := dtDataFinal;
  zQryAgendaProximos.ParamByName('sta').AsInteger := COMPROMISSO_ABERTO;
  zQryAgendaProximos.Open;
  if(zQryAgendaProximos.RecordCount > 0)then
    Self.mostrarCompromissosAgenda();

  ShowMessage(inttostr(zQryAgendaProximos.RecordCount));
*)
end;

procedure TfrmPrincipal.mostrarTotalCompromissosAgenda();
var
  sSQL: String;
  sDataHoje: String;
  sDataInicio: String;
  sDataFim: String;
  dtDataFim: TDate;
begin
  sSQL := STRING_INDEFINIDO;

  //compromissos de hoje
  sDataHoje := Self.FoFuncoes.formatarDataFormatoAmericano(Now);
  sSQL := 'SELECT COUNT(codigo) AS total FROM agenda ';
  sSQL := sSQL + FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo();
  sSQL := sSQL + 'AND data_aviso BETWEEN '''+sDataHoje+'''';
  sSQL := sSQL + 'AND '''+sDataHoje+'''';
  sSQL := sSQL + 'AND status='''+IntToStr(COMPROMISSO_ABERTO)+'''';
  zQryAgenda.Close;
  zQryAgenda.SQL.Clear;
  zQryAgenda.SQL.Add(sSQL);
  zQryAgenda.Open;
  lblTotCompromissosHoje.Caption := IntToStr(zQryAgendaTOTAL.AsInteger);

  //compromissos para os próximos 7 dias
  sDataInicio := Self.FoFuncoes.formatarDataFormatoAmericano(Now);
  dtDataFim := IncDay(Now,7);
  sDataFim := Self.FoFuncoes.formatarDataFormatoAmericano(dtDataFim);
  sSQL := 'SELECT COUNT(codigo) AS total FROM agenda ';
  sSQL := sSQL + FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo();
  sSQL := sSQL + 'AND data_aviso BETWEEN '''+sDataInicio+'''';
  sSQL := sSQL + 'AND '''+sDataFim+'''';
  sSQL := sSQL + 'AND status='''+IntToStr(COMPROMISSO_ABERTO)+'''';
  zQryAgenda.Close;
  zQryAgenda.SQL.Clear;
  zQryAgenda.SQL.Add(sSQL);
  zQryAgenda.Open;
  lblTotCompromissoProximos7Dias.Caption := IntToStr(zQryAgendaTOTAL.AsInteger);

  //compromissos em aberto
  sSQL := 'SELECT COUNT(codigo) AS total FROM agenda ';
  sSQL := sSQL + FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo();
  sSQL := sSQL + 'AND status='''+IntToStr(COMPROMISSO_ABERTO)+'''';
  zQryAgenda.Close;
  zQryAgenda.SQL.Clear;
  zQryAgenda.SQL.Add(sSQL);
  zQryAgenda.Open;
  lblTotTotalCompromissosEmAberto.Caption := IntToStr(zQryAgendaTOTAL.AsInteger);
end;

procedure TfrmPrincipal.mostrarAgenciamentosStandBy();
var
  sSQL: String;
begin
  sSQL := STRING_INDEFINIDO;

  //agenciamentos standBy
  sSQL := 'SELECT a.codigo,a.data_agenciamento,a.stand_by,a.tipo_pessoa,';
  sSQL := sSQL + 'a.cod_fk_pessoa_fisica,a.cod_fk_pessoa_juridica,';
  sSQL := sSQL + 'a.cod_fk_imovel,a.condicao_pagamento,'; //a.cod_fk_meio_captacao,
  sSQL := sSQL + 'a.valor_total,a.prazo_autorizacao,pf.nome AS nomePessoaFisica,';
  sSQL := sSQL + 'pj.nome AS nomePessoaJuridica,'; //m.nome AS nomeMeioCaptacao,';
  sSQL := sSQL + 'i.cod_fk_tipo_imovel,i.cod_fk_estado,i.cod_fk_cidade,';
  sSQL := sSQL + 'i.situacao_desejavel,i.valor_imovel,ti.nome AS nomeTipoImovel,';
  sSQL := sSQL + 'est.nome AS nomeEstado,est.sigla,cid.nome AS nomeCidade ';
  sSQL := sSQL + 'FROM agenciamentos a ';
  sSQL := sSQL + 'JOIN agenc_pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo ';
  sSQL := sSQL + 'JOIN agenc_pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo ';
  //sSQL := sSQL + 'JOIN meio_captacao m ON a.cod_fk_meio_captacao = m.codigo ';
  sSQL := sSQL + 'JOIN imovel i ON a.cod_fk_imovel = i.codigo ';
  sSQL := sSQL + 'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ';
  sSQL := sSQL + 'JOIN estado est ON i.cod_fk_estado = est.codigo ';
  sSQL := sSQL + 'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ';
  sSQL := sSQL + 'WHERE a.stand_by = ''SIM'' ';
  sSQL := sSQL + 'AND a.ativo = ''SIM'' ';

  zQryAgenciamentosStandBy.Close;
  zQryAgenciamentosStandBy.SQL.Clear;
  zQryAgenciamentosStandBy.SQL.Add(sSQL);
  zQryAgenciamentosStandBy.Open;
  lblTotalAgenciamentosStandBy.Caption := IntToStr(zQryAgenciamentosStandBy.RecordCount);
end;

procedure TfrmPrincipal.mostrarAgenciamentosExpirando();
var
  sSQL: String;
begin
  sSQL := STRING_INDEFINIDO;

  //agenciamentos standBy
  sSQL := 'SELECT a.codigo,a.data_agenciamento,a.stand_by,a.tipo_pessoa,';
  sSQL := sSQL + 'a.cod_fk_pessoa_fisica,a.cod_fk_pessoa_juridica,';
  sSQL := sSQL + 'a.cod_fk_imovel,a.condicao_pagamento,'; //a.cod_fk_meio_captacao,
  sSQL := sSQL + 'a.valor_total,a.prazo_autorizacao,pf.nome AS nomePessoaFisica,';
  sSQL := sSQL + 'pj.nome AS nomePessoaJuridica,'; //m.nome AS nomeMeioCaptacao,';
  sSQL := sSQL + 'i.cod_fk_tipo_imovel,i.cod_fk_estado,i.cod_fk_cidade,';
  sSQL := sSQL + 'i.situacao_desejavel,i.valor_imovel,ti.nome AS nomeTipoImovel,';
  sSQL := sSQL + 'est.nome AS nomeEstado,est.sigla,cid.nome AS nomeCidade ';
  sSQL := sSQL + 'FROM agenciamentos a ';
  sSQL := sSQL + 'JOIN agenc_pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo ';
  sSQL := sSQL + 'JOIN agenc_pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo ';
  //sSQL := sSQL + 'JOIN meio_captacao m ON a.cod_fk_meio_captacao = m.codigo ';
  sSQL := sSQL + 'JOIN imovel i ON a.cod_fk_imovel = i.codigo ';
  sSQL := sSQL + 'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ';
  sSQL := sSQL + 'JOIN estado est ON i.cod_fk_estado = est.codigo ';
  sSQL := sSQL + 'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ';
  sSQL := sSQL + 'WHERE a.ativo = ''SIM'' ';
  sSQL := sSQL + 'AND ((a.data_reagenciamento < current_timestamp) OR ';
  sSQL := sSQL + '(a.prazo_autorizacao < current_timestamp AND ';
  sSQL := sSQL + 'a.data_reagenciamento IS NULL))';

  zQryAgenciamentosExpirando.Close;
  zQryAgenciamentosExpirando.SQL.Clear;
  zQryAgenciamentosExpirando.SQL.Add(sSQL);
  zQryAgenciamentosExpirando.Open;
  lblTotalAgenciamentosExpirando.Caption := IntToStr(zQryAgenciamentosExpirando.RecordCount);
end;

procedure TfrmPrincipal.mensagensUsuarioIniciarSistema();
var
  nTotAgenciamentosStandBy: Integer;
  nTotAgenciamentosExpirando: Integer;
begin
  //mensagens para agenciamentos stand by
  try
    nTotAgenciamentosStandBy := StrToInt(lblTotalAgenciamentosStandBy.Caption);
  except
    nTotAgenciamentosStandBy := NUMERO_INDEFINIDO;
  end;

  if(nTotAgenciamentosStandBy > NUMERO_INDEFINIDO)then
    MessageDlg('Existem ' + IntToStr(nTotAgenciamentosStandBy) + ' agenciamentos stand by.',
     mtInformation, [mbOK], 0);

  //mensagens para agenciamentos expirando
  try
    nTotAgenciamentosExpirando := StrToInt(lblTotalAgenciamentosExpirando.Caption);
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

procedure TfrmPrincipal.AjustarPainelDireito();
var
  nHeight: Integer;
begin
  nHeight := grpBxCompromissosAgenda.Height + pnlDivisao1.Height +
   grpBxAgenciamentosStandBy.Height + pnlDivisao2.Height +
   grpBxAgenciamentosExpirando.Height;
  pnlInformacoesLadoEsquerdo.Height := nHeight;
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
  Self.FoUsuario := TUsuario.Create;

  try
    Application.CreateForm(TfrmLogin, frmLogin);
    frmLogin.ShowModal;
  finally
    FreeAndNil(frmLogin);
  end;

  //se o login foi realizado
  if(Self.FoUsuario.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    Self.FoFuncoes := TFuncoes.Create;
    Self.FoSistema := TSistema.Create;

    //configura tempo para pesquisar compromissos da agenda
    if(FoSistema.FnTempoAvisaAgenda <> NUMERO_INDEFINIDO)then
      tmrCompromissosAgenda.Interval := (1000 * 60) * FoSistema.FnTempoAvisaAgenda
    else
      tmrCompromissosAgenda.Interval := (1000 * 60) * 10; //default 10 minutos

    tmrCompromissosAgenda.Enabled := True;
  end;
  Self.AjustarPainelDireito();
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

procedure TfrmPrincipal.tmrCompromissosAgendaTimer(Sender: TObject);
begin
  Self.mostrarTotalCompromissosAgenda();
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

procedure TfrmPrincipal.lblMenosCompromissosClick(Sender: TObject);
begin
  grpBxCompromissosAgenda.Height := 30;
  lblMaisCompromissos.Visible := True;
  lblMenosCompromissos.Visible := False;
  Self.AjustarPainelDireito();
end;

procedure TfrmPrincipal.lblMaisCompromissosClick(Sender: TObject);
begin
  grpBxCompromissosAgenda.Height := 130;
  lblMaisCompromissos.Visible := False;
  lblMenosCompromissos.Visible := True;
  Self.mostrarTotalCompromissosAgenda();
  Self.AjustarPainelDireito();  
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  try
    Application.CreateForm(TForm3, form3);
    form3.ShowModal;
  finally
    FreeAndNil(form3);
  end;
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

procedure TfrmPrincipal.lblMaisAgenciamentosStandByClick(Sender: TObject);
begin
  grpBxAgenciamentosStandBy.Height := 235;
  lblMaisAgenciamentosStandBy.Visible := False;
  lblMenosAgenciamentosStandBy.Visible := True;
  Self.mostrarAgenciamentosStandBy();
  Self.AjustarPainelDireito();
end;

procedure TfrmPrincipal.lblMenosAgenciamentosStandByClick(Sender: TObject);
begin
  grpBxAgenciamentosStandBy.Height := 30;
  lblMaisAgenciamentosStandBy.Visible := True;
  lblMenosAgenciamentosStandBy.Visible := False;
  Self.AjustarPainelDireito();
end;

procedure TfrmPrincipal.lblVerDetalhesAgenciamentosStandByClick(
  Sender: TObject);
begin
  pnlDetalheAgenciamentosStandBy.Visible := True;
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

procedure TfrmPrincipal.lblMaisAgenciamentosExpirandoClick(
  Sender: TObject);
begin
  grpBxAgenciamentosExpirando.Height := 235;
  lblMaisAgenciamentosExpirando.Visible := False;
  lblMenosAgenciamentosExpirando.Visible := True;
  Self.mostrarAgenciamentosExpirando();
  Self.AjustarPainelDireito();
end;

procedure TfrmPrincipal.lblMenosAgenciamentosExpirandoClick(
  Sender: TObject);
begin
  grpBxAgenciamentosExpirando.Height := 30;
  lblMaisAgenciamentosExpirando.Visible := True;
  lblMenosAgenciamentosExpirando.Visible := False;
  Self.AjustarPainelDireito();
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


end.

