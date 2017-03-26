unit unSelecionaRegistroGrupoBemNegociavel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, plsComboBox, plsEdit,
  ExtCtrls, Grids, DBGrids;

type
  TfrmSelecionaRegistroGrupoBemNegociavel = class(TfrmSelecionaRegistro)
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
  frmSelecionaRegistroGrupoBemNegociavel: TfrmSelecionaRegistroGrupoBemNegociavel;

implementation

uses unConstantes, unCadGrupoBemNegociavel, unCadSubGrupoBemNegociavel;

{$R *.dfm}

{ TfrmSelecionaRegistroGrupoBemNegociavel }

{***** Minhas Procedures - inicio *****}

procedure TfrmSelecionaRegistroGrupoBemNegociavel.passarParametro(pTipo:String; pValores:OleVariant);
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

procedure TfrmSelecionaRegistroGrupoBemNegociavel.filtrarPesquisa();
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

procedure TfrmSelecionaRegistroGrupoBemNegociavel.selecionarTodosRegistros();
begin
  if(FbSelecionarTodos)then
  begin
    cdsSelecionarRegistro.Filter := '';
    cdsSelecionarRegistro.Filtered := False;
    cdsSelecionarRegistro.Close;

    zQrySelecionarRegistro.Close;
    zQrySelecionarRegistro.SQL.Clear;
    zQrySelecionarRegistro.SQL.Add('SELECT g.codigo, g.nome, CAST(g.codigo AS VARCHAR(10)) AS cc_codigo ');
    zQrySelecionarRegistro.SQL.Add('FROM grupo_bem_negociavel g ');
    zQrySelecionarRegistro.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('g'));
    zqrySelecionarRegistro.SQL.Add('ORDER BY g.nome ');
    zQrySelecionarRegistro.Open;
    cdsSelecionarRegistro.Open;
    cdsSelecionarRegistro.First;
  end;

  FbSelecionarTodos := True;

  inherited;
end;

procedure TfrmSelecionaRegistroGrupoBemNegociavel.selecionouRegistro();
begin
  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_SUB_GRUPO_BEM_NEGOCIAVEL)then //TfrmCadSubGrupoBemNegociavel
    begin
      frmCadSubGrupoBemNegociavel.FoGrupo.codigo := FiCodigo;
      frmCadSubGrupoBemNegociavel.FoGrupo.nome := FsNome;
    end                                  
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroGrupoBemNegociavel.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisar.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

procedure TfrmSelecionaRegistroGrupoBemNegociavel.inserirNovoRegistro();
begin
  try
    Application.CreateForm(TfrmCadGrupoBemNegociavel,frmCadGrupoBemNegociavel);
    frmCadGrupoBemNegociavel.iniciarTela(frmCadGrupoBemNegociavel);
    frmCadGrupoBemNegociavel.passarParametro(PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO, FORM_SELECIONA_REGISTRO_GRUPO_BEM_NEGOCIAVEL);
    frmCadGrupoBemNegociavel.ShowModal;
  finally
    FreeAndNil(frmCadGrupoBemNegociavel);
  end;
end;

procedure TfrmSelecionaRegistroGrupoBemNegociavel.ConfigurarCampoPesquisa();
begin
  plsEdValorPesquisar.Clear;
  FoFuncoes.focarComponente(plsEdValorPesquisar);

  if(plsCbBxCampoPesquisar.ItemIndex = 0)then //c�digo
    plsEdValorPesquisar.plsCaracteresAceitos := numeros
  else if(plsCbBxCampoPesquisar.ItemIndex = 1)then //nome
    plsEdValorPesquisar.plsCaracteresAceitos := todos;
end;

//seleciona todos os registros do conjunto de dados da tela pai
procedure TfrmSelecionaRegistroGrupoBemNegociavel.SelecionarTodosRegistrosConjuntoDadosTelaPai();
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,0],varVariant);
  vParametros[0] := CONJUNTO_DADOS_GRUPO_CONFIGURACAO_IMOVEL;

  if(Self.FiTelaChamou = FORM_CAD_SUB_GRUPO_BEM_NEGOCIAVEL)then //TfrmCadSubGrupoBemNegociavel
    frmCadSubGrupoBemNegociavel.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, null)
end;

{***** Minhas Procedures - fim *****}

procedure TfrmSelecionaRegistroGrupoBemNegociavel.FormCreate(
  Sender: TObject);
begin
  inherited;
  Self.FiCodigo := NUMERO_INDEFINIDO;
  Self.FsNome := STRING_INDEFINIDO;
  FbSelecionarTodos := True;
  FbMostraMensagemNaoEncontrouRegistro := True;
  selecionarTodosRegistros();
end;

procedure TfrmSelecionaRegistroGrupoBemNegociavel.plsCbBxCampoPesquisarChange(
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

procedure TfrmSelecionaRegistroGrupoBemNegociavel.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigo := cdsSelecionarRegistroCODIGO.AsInteger;
  Self.FsNome := cdsSelecionarRegistroNOME.AsString;
end;

procedure TfrmSelecionaRegistroGrupoBemNegociavel.plsEdValorPesquisarChange(
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

procedure TfrmSelecionaRegistroGrupoBemNegociavel.FormShow(
  Sender: TObject);
begin
  inherited;
  FoFuncoes.focarComponente(plsEdValorPesquisar);
end;

end.