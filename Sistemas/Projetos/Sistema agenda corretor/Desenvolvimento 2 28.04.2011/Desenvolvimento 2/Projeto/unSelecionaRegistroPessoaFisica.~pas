(*
  agenciador - pessoa física
*)
unit unSelecionaRegistroPessoaFisica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, plsComboBox, plsEdit,
  ExtCtrls, Grids, DBGrids;

type
  TfrmSelecionaRegistroPessoaFisica = class(TfrmSelecionaRegistro)
    zqrySelecionarRegistroCODIGO: TIntegerField;
    zqrySelecionarRegistroNOME: TStringField;
    zqrySelecionarRegistroCPF: TStringField;
    zqrySelecionarRegistroIDENTIDADE: TStringField;
    zqrySelecionarRegistroDATA_NASCIMENTO: TDateTimeField;
    zqrySelecionarRegistroTELEFONE_RESIDENCIAL: TStringField;
    zqrySelecionarRegistroTELEFONE_COMERCIAL: TStringField;
    zqrySelecionarRegistroTELEFONE_CELULAR: TStringField;
    zqrySelecionarRegistroSIGLA_ESTADO: TStringField;
    zqrySelecionarRegistroNOME_CIDADE: TStringField;
    zqrySelecionarRegistroCC_CODIGO: TStringField;
    cdsSelecionarRegistroCODIGO: TIntegerField;
    cdsSelecionarRegistroNOME: TStringField;
    cdsSelecionarRegistroCPF: TStringField;
    cdsSelecionarRegistroIDENTIDADE: TStringField;
    cdsSelecionarRegistroDATA_NASCIMENTO: TDateTimeField;
    cdsSelecionarRegistroTELEFONE_RESIDENCIAL: TStringField;
    cdsSelecionarRegistroTELEFONE_COMERCIAL: TStringField;
    cdsSelecionarRegistroTELEFONE_CELULAR: TStringField;
    cdsSelecionarRegistroSIGLA_ESTADO: TStringField;
    cdsSelecionarRegistroNOME_CIDADE: TStringField;
    cdsSelecionarRegistroCC_CODIGO: TStringField;
    procedure plsCbBxCampoPesquisarChange(Sender: TObject);
    procedure plsEdValorPesquisarChange(Sender: TObject);
    procedure cdsSelecionarRegistroAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    FiCodigo: integer;
    FsNome: string;
    FsCampoPesquisa: string;
    FbSelecionarTodos: Boolean;
    //pog - devido ao estar pesquisando por um registro inexistente, e abrir esta tela, a mensagem era apresentada duas vezes
    FbMostraMensagemNaoEncontrouRegistro: Boolean;
  protected
    procedure selecionarTodosRegistros(); override;
    procedure formatarValores(); override;
    procedure filtrarPesquisa(); override;
    procedure selecionouRegistro(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
    procedure inserirNovoRegistro(); override;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
    procedure ConfigurarCampoPesquisa(); override;
    //seleciona todos os registros do conjunto de dados da tela pai
    procedure SelecionarTodosRegistrosConjuntoDadosTelaPai();
  end;

var
  frmSelecionaRegistroPessoaFisica: TfrmSelecionaRegistroPessoaFisica;

implementation

uses
  unConstantes, unCadAgenciamento, unCadPessoaFisica;

{$R *.dfm}

{ TfrmSelecionaRegistroPessoaFisica }

(* procedimentos de controle *)

procedure TfrmSelecionaRegistroPessoaFisica.passarParametro(pTipo:String; pValores:OleVariant);
var
  sCodPessoaFisicaNova: String;
begin
  inherited;

  if(pTipo = PRM_INICIAR_TELA)then
  begin
    selecionarTodosRegistros();
    plsCbBxCampoPesquisar.ItemIndex := 0;
    plsEdValorPesquisar.Visible := True;
    Self.FsCampoPesquisa := 'CC_CODIGO';
  end

  else if(pTipo = PRM_PESQUISAR_REGISTRO)then
  begin
    {pValores[0] = parâmetro do campo da pesquisa
    pValores[1] = campo da pesquisa
    pValores[1] = valor da pesquisa
    }
    if (pValores[0] = PRM_PESQUISA_CODIGO)then
    begin
      Self.FsCampoPesquisa := pValores[1];
      plsCbBxCampoPesquisar.ItemIndex := 0;
      plsEdValorPesquisar.Text := pValores[2];
      filtrarPesquisa();
      plsEdValorPesquisar.Text := pValores[2];
      Self.configurarCaracteresAceitosPesquisa();
    end;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros()

  else if(pTipo = PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.selecionarTodosRegistros();
    SelecionarTodosRegistrosConjuntoDadosTelaPai();
    if(MessageDlg('Selecionar a pessoa física que foi cadastrada?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
      sCodPessoaFisicaNova := pValores;
      cdsSelecionarRegistro.Locate('CODIGO', sCodPessoaFisicaNova, []);
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

procedure TfrmSelecionaRegistroPessoaFisica.filtrarPesquisa();
var
  sVlrPesquisa: String;
begin
  if((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME')or
  (Self.FsCampoPesquisa = 'CPF')or(Self.FsCampoPesquisa = 'IDENTIDADE')or
  (Self.FsCampoPesquisa = 'SIGLA_ESTADO')or(Self.FsCampoPesquisa = 'NOME_CIDADE'))then
  begin
    if(plsEdValorPesquisar.Text <> STRING_INDEFINIDO)then
    begin
      cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
      cdsSelecionarRegistro.Filtered := True;

      if(cdsSelecionarRegistro.RecordCount=0)then
      begin
        if(FbMostraMensagemNaoEncontrouRegistro)then
          MessageDlg('Nenhum agenciador encontrado.',mtInformation,[mbOK],0);
        cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
        cdsSelecionarRegistro.Filtered := True;
        plsEdValorPesquisar.Clear;
      end;
    end
    else
      limparFiltroPesquisa();
  end;
end;

procedure TfrmSelecionaRegistroPessoaFisica.selecionouRegistro();
begin
  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_AGENCIAMENTOS)then //TfrmCadAgenciamento
    begin
      frmCadAgenciamento.FoPessoa.codigo := FiCodigo;
      frmCadAgenciamento.FoPessoa.nome := FsNome;
    end;
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroPessoaFisica.configurarCaracteresAceitosPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CPF')or
  (Self.FsCampoPesquisa = 'IDENTIDADE')or(Self.FsCampoPesquisa = 'SIGLA_ESTADO')or
  (Self.FsCampoPesquisa = 'NOME_CIDADE'))then
    plsEdValorPesquisar.plsCaracteresAceitos := todos;

  if((Self.FsCampoPesquisa = 'CC_CODIGO'))then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

procedure TfrmSelecionaRegistroPessoaFisica.selecionarTodosRegistros();
  function inserirColunas(): String;
  var
    sql: String;
  begin
    sql := 'SELECT p.codigo,p.nome,p.cpf,p.identidade,p.data_nascimento,';
    sql := sql + 'p.telefone_residencial,p.telefone_comercial,p.telefone_celular,';
    sql := sql + 'e.sigla as sigla_estado,c.nome as nome_cidade,';
    sql := sql + 'CAST(p.codigo AS VARCHAR(10))AS cc_codigo ';
    Result := sql;
  end;

  function inserirTabelas(): String;
  var
    sql: String;
  begin
    sql := sql + 'FROM agenc_pessoa_fisica p ';
    Result := sql;
  end;

  function inserirCondicoes(): String;
  var
    sql: String;
  begin
    //JOIN poderia ser trocado por WHERE, para inserir table no inserirTabelas()
    sql := 'JOIN estado e ON p.cod_fk_estado=e.codigo ';
    sql := sql + 'JOIN cidade c ON p.cod_fk_cidade=c.codigo ';
    sql := sql + Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('p');
    Result := sql;
  end;

begin
  if(FbSelecionarTodos)then
  begin
    cdsSelecionarRegistro.Close;
    zqrySelecionarRegistro.Close;
    zqrySelecionarRegistro.SQL.Clear;
    zqrySelecionarRegistro.SQL.Add(inserirColunas);
    zqrySelecionarRegistro.SQL.Add(inserirTabelas);
    zqrySelecionarRegistro.SQL.Add(inserirCondicoes);
    zqrySelecionarRegistro.Open;
    cdsSelecionarRegistro.Open;
    Self.formatarValores();
  end;

  FbSelecionarTodos := True;

  inherited;
end;

procedure TfrmSelecionaRegistroPessoaFisica.formatarValores();
begin
  if((cdsSelecionarRegistro.Active)and(cdsSelecionarRegistro.RecordCount>0))then
  begin
    cdsSelecionarRegistro.First;
    while(not(cdsSelecionarRegistro.Eof))do
    begin
      if(Self.FoFuncoes.verificaCPF_EhVazio(cdsSelecionarRegistroCPF.AsString))then
      begin
        cdsSelecionarRegistro.Edit;
        cdsSelecionarRegistroCPF.AsString := STRING_INDEFINIDO;
        cdsSelecionarRegistro.Post;
      end;
      cdsSelecionarRegistro.Next;
    end;
  end;
end;

procedure TfrmSelecionaRegistroPessoaFisica.inserirNovoRegistro();
begin
  try
    Application.CreateForm(TfrmCadPessoaFisica,frmCadPessoaFisica);
    frmCadPessoaFisica.iniciarTela(frmCadPessoaFisica);
    frmCadPessoaFisica.passarParametro(PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO,
     FORM_SELECIONA_REGISTRO_PESSOA_FISICA);
    frmCadPessoaFisica.ShowModal;
  finally
    FreeAndNil(frmCadPessoaFisica)
  end;
end;

//seleciona todos os registros do conjunto de dados da tela pai
procedure TfrmSelecionaRegistroPessoaFisica.SelecionarTodosRegistrosConjuntoDadosTelaPai();
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,0],varVariant);
  vParametros[0] := CONJUNTO_DADOS_AGENC_PESSOA_FISICA;

  if(Self.FiTelaChamou = FORM_CAD_AGENCIAMENTOS)then //TfrmCadAgenciamento
    frmCadAgenciamento.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, vParametros);
end;

procedure TfrmSelecionaRegistroPessoaFisica.ConfigurarCampoPesquisa();
begin
  plsEdValorPesquisar.Clear;
  FoFuncoes.focarComponente(plsEdValorPesquisar);
end;

(* fim - procedimentos de controle *)

procedure TfrmSelecionaRegistroPessoaFisica.plsCbBxCampoPesquisarChange(
  Sender: TObject);
begin
  inherited;

  case plsCbBxCampoPesquisar.ItemIndex of
    0:
    begin
      Self.FsCampoPesquisa := 'CC_CODIGO';
      plsEdValorPesquisar.Clear;
      plsEdValorPesquisar.SetFocus;
    end;
    1:
    begin
      Self.FsCampoPesquisa := 'NOME';
      plsEdValorPesquisar.Clear;
      plsEdValorPesquisar.SetFocus;
    end;
    2:
    begin
      Self.FsCampoPesquisa := 'CPF';
      plsEdValorPesquisar.Clear;
      plsEdValorPesquisar.SetFocus;
    end;
    3:
    begin
      Self.FsCampoPesquisa := 'IDENTIDADE';
      plsEdValorPesquisar.Clear;
      plsEdValorPesquisar.SetFocus;
    end;
    4:
    begin
      Self.FsCampoPesquisa := 'SIGLA_ESTADO';
      plsEdValorPesquisar.Clear;
      plsEdValorPesquisar.SetFocus;
    end;
    5:
    begin
      Self.FsCampoPesquisa := 'NOME_CIDADE';
      plsEdValorPesquisar.Clear;
      plsEdValorPesquisar.SetFocus;
    end;
  end;

  configurarCaracteresAceitosPesquisa();
  ConfigurarCampoPesquisa();
end;

procedure TfrmSelecionaRegistroPessoaFisica.plsEdValorPesquisarChange(
  Sender: TObject);
begin
  inherited;
  filtrarPesquisa();
end;

procedure TfrmSelecionaRegistroPessoaFisica.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigo := cdsSelecionarRegistroCODIGO.AsInteger;
  Self.FsNome := cdsSelecionarRegistroNOME.AsString;
end;

procedure TfrmSelecionaRegistroPessoaFisica.FormCreate(Sender: TObject);
begin
  inherited;
  FbMostraMensagemNaoEncontrouRegistro := True;
  FbSelecionarTodos := True;
end;

end.
