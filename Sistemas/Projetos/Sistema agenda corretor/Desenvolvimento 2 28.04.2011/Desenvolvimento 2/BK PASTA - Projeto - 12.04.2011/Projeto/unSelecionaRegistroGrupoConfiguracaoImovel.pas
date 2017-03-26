unit unSelecionaRegistroGrupoConfiguracaoImovel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, plsComboBox, plsEdit,
  ExtCtrls, Grids, DBGrids;

type
  TfrmSelecionaRegistroGrupoConfiguracaoImovel = class(TfrmSelecionaRegistro)
    zqrySelecionarRegistroCODIGO: TIntegerField;
    zqrySelecionarRegistroNOME: TStringField;
    zqrySelecionarRegistroCC_CODIGO: TStringField;
    cdsSelecionarRegistroCODIGO: TIntegerField;
    cdsSelecionarRegistroNOME: TStringField;
    cdsSelecionarRegistroCC_CODIGO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure plsCbBxCampoPesquisarChange(Sender: TObject);
    procedure cdsSelecionarRegistroAfterScroll(DataSet: TDataSet);
    procedure plsEdValorPesquisarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FiCodigo: integer;
    FsNome: string;
    FsCampoPesquisa: string;
    FbSelecionarTodos: Boolean;
    //pog - devido ao estar pesquisando por um registro inexistente, e abrir esta tela, a mensagem era apresentada duas vezes
    FbMostraMensagemNaoEncontrouRegistro: Boolean;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure selecionarTodosRegistros(); override;
    procedure selecionouRegistro(); override;
    procedure filtrarPesquisa(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
    procedure inserirNovoRegistro(); override;
    procedure ConfigurarCampoPesquisa(); override;
    //seleciona todos os registros do conjunto de dados da tela pai
    procedure SelecionarTodosRegistrosConjuntoDadosTelaPai();
  end;

var
  frmSelecionaRegistroGrupoConfiguracaoImovel: TfrmSelecionaRegistroGrupoConfiguracaoImovel;

implementation

uses unConstantes, unCadSubGrupoConfiguracaoImovel,
  unCadGrupoConfiguracaoImovel;

{$R *.dfm}

{ TfrmSelecionaRegistroGrupoConfiguracaoImovel }

{***** Minhas Procedures - inicio *****}

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.passarParametro(pTipo:String; pValores:OleVariant);
var
  sCodGrupoNovo: String;
begin
  inherited;

  if(pTipo = PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.selecionarTodosRegistros();
    SelecionarTodosRegistrosConjuntoDadosTelaPai();
    if(MessageDlg('Selecionar o grupo que foi cadastrado?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
      sCodGrupoNovo := pValores;
      cdsSelecionarRegistro.Locate('CODIGO', sCodGrupoNovo, []);
      dbGrdDadosDblClick(Self);
    end;
  end

  else if(pTipo = PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO)then
  begin
    plsCbBxCampoPesquisar.ItemIndex := 1;
    FsCampoPesquisa := 'NOME';
    ConfigurarCampoPesquisa();
  end

  else if(pTipo = PRM_ENVIA_FILTRO_PESQUISA)then
  //pParametros[0]: campo do filtro
  //pParametros[1]: valor do filtro
  //pParametros[2]: FbSelecionarTodos - pode selecionar todos os registros
  begin
    plsEdValorPesquisar.Text := VarToStr(pValores[1]);
    if(pValores[0] = PRM_PESQUISA_NOME)then
    begin
      plsCbBxCampoPesquisar.ItemIndex := 1;
      FsCampoPesquisa := 'NOME';
      plsEdValorPesquisar.plsCaracteresAceitos := todos;
      FbMostraMensagemNaoEncontrouRegistro := False;
      filtrarPesquisa();
      FbMostraMensagemNaoEncontrouRegistro := True;
    end;
    FbSelecionarTodos := pValores[2];
  end;
end;

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.filtrarPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CC_CODIGO')) then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := true;
  end;

  if(cdsSelecionarRegistro.RecordCount=0)then
  begin
    if(FbMostraMensagemNaoEncontrouRegistro)then
      MessageDlg('Nenhum grupo encontrado.',mtInformation,[mbOK],0);
    cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
    cdsSelecionarRegistro.Filtered := true;
    //plsEdValorPesquisar.Clear;
    FoFuncoes.focarComponente(plsEdValorPesquisar);
  end;
end;

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.selecionarTodosRegistros();
begin
  if(FbSelecionarTodos)then
  begin
    cdsSelecionarRegistro.Filter := '';
    cdsSelecionarRegistro.Filtered := False;
    cdsSelecionarRegistro.Close;

    zQrySelecionarRegistro.Close;
    zQrySelecionarRegistro.SQL.Clear;
    zQrySelecionarRegistro.SQL.Add('SELECT g.codigo, g.nome, CAST(g.codigo AS VARCHAR(10)) AS cc_codigo ');
    zQrySelecionarRegistro.SQL.Add('FROM grupo_configuracao_imovel g ');
    zQrySelecionarRegistro.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('g'));
    zqrySelecionarRegistro.SQL.Add('ORDER BY g.nome ');
    zQrySelecionarRegistro.Open;
    cdsSelecionarRegistro.Open;
    cdsSelecionarRegistro.First;
  end;

  FbSelecionarTodos := True;

  inherited;
end;

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.selecionouRegistro();
begin
  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_SUB_GRUPO_CONF_IMOVEL)then //TfrmCadSubGrupoConfiguracaoImovel
    begin
      frmCadSubGrupoConfiguracaoImovel.FoGrupo.codigo := FiCodigo;
      frmCadSubGrupoConfiguracaoImovel.FoGrupo.nome := FsNome;
    end
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisar.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.inserirNovoRegistro();
begin
  try
    Application.CreateForm(TfrmCadGrupoConfiguracaoImovel,frmCadGrupoConfiguracaoImovel);
    frmCadGrupoConfiguracaoImovel.iniciarTela(frmCadGrupoConfiguracaoImovel);
    frmCadGrupoConfiguracaoImovel.passarParametro(PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO, FORM_SELECIONA_REGISTRO_GRUPO_CONFIGURACAO_IMOVEL);
    frmCadGrupoConfiguracaoImovel.ShowModal;
  finally
    FreeAndNil(frmCadGrupoConfiguracaoImovel);
  end;
end;

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.ConfigurarCampoPesquisa();
begin
  plsEdValorPesquisar.Clear;
  FoFuncoes.focarComponente(plsEdValorPesquisar);

  if(plsCbBxCampoPesquisar.ItemIndex = 0)then //código
    plsEdValorPesquisar.plsCaracteresAceitos := numeros
  else if(plsCbBxCampoPesquisar.ItemIndex = 1)then //nome
    plsEdValorPesquisar.plsCaracteresAceitos := todos;
end;

//seleciona todos os registros do conjunto de dados da tela pai
procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.SelecionarTodosRegistrosConjuntoDadosTelaPai();
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,0],varVariant);
  vParametros[0] := CONJUNTO_DADOS_GRUPO_CONFIGURACAO_IMOVEL;

  if(Self.FiTelaChamou = FORM_CAD_SUB_GRUPO_CONF_IMOVEL)then //TfrmCadSubGrupoConfiguracaoImovel
    frmCadSubGrupoConfiguracaoImovel.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, null)
end;

{***** Minhas Procedures - fim *****}


procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.FormCreate(
  Sender: TObject);
begin
  inherited;
  Self.FiCodigo := NUMERO_INDEFINIDO;
  Self.FsNome := STRING_INDEFINIDO;
  FbSelecionarTodos := True;
  FbMostraMensagemNaoEncontrouRegistro := True;
  selecionarTodosRegistros();
end;

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.plsCbBxCampoPesquisarChange(
  Sender: TObject);
begin
  inherited;
  Self.FsCampoPesquisa := STRING_INDEFINIDO; //default
  case plsCbBxCampoPesquisar.ItemIndex of
    0: Self.FsCampoPesquisa := 'CC_CODIGO';
    1: Self.FsCampoPesquisa := 'NOME';
  end;

  ConfigurarCampoPesquisa();
end;

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigo := cdsSelecionarRegistroCODIGO.AsInteger;
  Self.FsNome := cdsSelecionarRegistroNOME.AsString;
end;

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.plsEdValorPesquisarChange(
  Sender: TObject);
begin
  inherited;
  if ((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME'))then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := True;
    if(cdsSelecionarRegistro.RecordCount=0)then
    begin
      MessageDlg('Nenhum grupo encontrado.',mtInformation,[mbOK],0);
      selecionarTodosRegistros();
      FoFuncoes.focarComponente(plsEdValorPesquisar);
    end;
  end
  else
  //retira os filtro
  begin
    cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
    cdsSelecionarRegistro.Filtered := False;
  end;
end;

procedure TfrmSelecionaRegistroGrupoConfiguracaoImovel.FormShow(
  Sender: TObject);
begin
  inherited;
  FoFuncoes.focarComponente(plsEdValorPesquisar);
end;

end.
