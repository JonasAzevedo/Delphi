unit unSelecionaRegistroProfissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Grids, DBGrids, StdCtrls, plsComboBox,
  plsEdit, unFuncoes, Buttons, ExtCtrls;

type
  TfrmSelecionaRegistroProfissao = class(TfrmSelecionaRegistro)
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
    procedure FormDestroy(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
    FiCodigo: integer;
    FsNome: string;
    FsCampoPesquisa: string;
    FbSelecionarTodos: Boolean;
  public
    procedure passarParametro(pTipo: String; pParametros: OleVariant); override;
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
  frmSelecionaRegistroProfissao: TfrmSelecionaRegistroProfissao;

implementation

uses unCadCliente, unConstantes, unCadProfissao;

{$R *.dfm}

{ TfrmSelecionaRegistroBairro }

{***** Minhas Procedures - inicio *****}

procedure TfrmSelecionaRegistroProfissao.passarParametro(pTipo: String; pParametros: OleVariant);
var
  sCodProfissaoNova: String;
begin
  inherited;
  if(pTipo = PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.selecionarTodosRegistros();
    SelecionarTodosRegistrosConjuntoDadosTelaPai();
    if(MessageDlg('Selecionar a profissão que foi cadastrada?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
      sCodProfissaoNova := pParametros;
      cdsSelecionarRegistro.Locate('CODIGO', sCodProfissaoNova, []);
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
    plsEdValorPesquisar.Text := VarToStr(pParametros[1]);
    if(pParametros[0] = PRM_PESQUISA_NOME)then
      filtrarPesquisa();
    FbSelecionarTodos := pParametros[2];
  end;
end;

procedure TfrmSelecionaRegistroProfissao.filtrarPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CC_CODIGO')) then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := true;
  end;

  if(cdsSelecionarRegistro.RecordCount=0)then
  begin
    MessageDlg('Nenhum registro encontrado.',mtInformation,[mbOK],0);
    cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
    cdsSelecionarRegistro.Filtered := true;
    plsEdValorPesquisar.Clear;
  end;
end;

procedure TfrmSelecionaRegistroProfissao.selecionarTodosRegistros();
begin
  if(FbSelecionarTodos)then
  begin
    cdsSelecionarRegistro.Filter := '';
    cdsSelecionarRegistro.Filtered := False;
    cdsSelecionarRegistro.Close;

    zQrySelecionarRegistro.Close;
    zQrySelecionarRegistro.SQL.Clear;
    zQrySelecionarRegistro.SQL.Add('SELECT codigo, nome, CAST(codigo AS VARCHAR(10)) AS cc_codigo ');
    zQrySelecionarRegistro.SQL.Add('FROM profissao ');
    zQrySelecionarRegistro.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
    zQrySelecionarRegistro.SQL.Add('ORDER BY nome');
    zQrySelecionarRegistro.Open;
    cdsSelecionarRegistro.Open;
    cdsSelecionarRegistro.First;
  end;

  FbSelecionarTodos := True;
end;

procedure TfrmSelecionaRegistroProfissao.selecionouRegistro();
begin

  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_CLIENTE)then //TfrmCadCliente
    begin
      frmCadCliente.FoProfissao.codigo := FiCodigo;
      frmCadCliente.FoProfissao.nome := FsNome;
    end;
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroProfissao.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisar.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

procedure TfrmSelecionaRegistroProfissao.inserirNovoRegistro();
begin
  try
    Application.CreateForm(TfrmCadProfissao,frmCadProfissao);
    frmCadProfissao.iniciarTela(frmCadProfissao);
    frmCadProfissao.passarParametro(PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO, FORM_SELECIONA_REGISTRO_PROFISSAO);
    frmCadProfissao.ShowModal;
  finally
    FreeAndNil(frmCadProfissao);
  end;
end;

procedure TfrmSelecionaRegistroProfissao.ConfigurarCampoPesquisa();
begin
  plsEdValorPesquisar.Clear;
  FoFuncoes.focarComponente(plsEdValorPesquisar);

  if(plsCbBxCampoPesquisar.ItemIndex = 0)then //código
    plsEdValorPesquisar.plsCaracteresAceitos := numeros
  else if(plsCbBxCampoPesquisar.ItemIndex = 1)then //nome
    plsEdValorPesquisar.plsCaracteresAceitos := todos;
end;

//seleciona todos os registros do conjunto de dados da tela pai
procedure TfrmSelecionaRegistroProfissao.SelecionarTodosRegistrosConjuntoDadosTelaPai();
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,0],varVariant);
  vParametros[0] := CONJUNTO_DADOS_PROFISSAO;

  if(Self.FiTelaChamou = FORM_CAD_CLIENTE)then //TfrmCadCliente
  begin
    frmCadCliente.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, vParametros);
  end;
end;


{***** Minhas Procedures - fim *****}

procedure TfrmSelecionaRegistroProfissao.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FiCodigo := NUMERO_INDEFINIDO;
  Self.FsNome := STRING_INDEFINIDO;
  FbSelecionarTodos := True;
  Self.FoFuncoes := TFuncoes.Create;
  selecionarTodosRegistros();
end;

procedure TfrmSelecionaRegistroProfissao.plsCbBxCampoPesquisarChange(
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

procedure TfrmSelecionaRegistroProfissao.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigo := cdsSelecionarRegistroCODIGO.AsInteger;
  Self.FsNome := cdsSelecionarRegistroNOME.AsString;
end;

procedure TfrmSelecionaRegistroProfissao.plsEdValorPesquisarChange(
  Sender: TObject);
begin
  inherited;
  if ((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME'))then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := True;
    if(cdsSelecionarRegistro.RecordCount=0)then
    begin
      MessageDlg('Nenhuma profissão encontrado.',mtInformation,[mbOK],0);
      selecionarTodosRegistros();
      plsEdValorPesquisar.Clear;
    end;
  end
  else
  //retira os filtro
  begin
    cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
    cdsSelecionarRegistro.Filtered := False;
  end;
end;

procedure TfrmSelecionaRegistroProfissao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FoFuncoes);
end;

end.
