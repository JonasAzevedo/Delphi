(*
  cliente - pessoa jurídica
*)
unit unSelecionaRegistroClientePessoaJuridica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, plsComboBox, plsEdit,
  ExtCtrls, Grids, DBGrids;

type
  TfrmSelecionaRegistroClientePessoaJuridica = class(TfrmSelecionaRegistro)
    zqrySelecionarRegistroCODIGO: TIntegerField;
    zqrySelecionarRegistroNOME: TStringField;
    zqrySelecionarRegistroEMAIL: TStringField;
    zqrySelecionarRegistroTELEFONE_RESIDENCIAL: TStringField;
    zqrySelecionarRegistroTELEFONE_COMERCIAL: TStringField;
    zqrySelecionarRegistroTELEFONE_CELULAR: TStringField;
    zqrySelecionarRegistroCNPJ: TStringField;
    zqrySelecionarRegistroSIGLA_ESTADO: TStringField;
    zqrySelecionarRegistroNOME_CIDADE: TStringField;
    zqrySelecionarRegistroCC_CODIGO: TStringField;
    cdsSelecionarRegistroCODIGO: TIntegerField;
    cdsSelecionarRegistroNOME: TStringField;
    cdsSelecionarRegistroEMAIL: TStringField;
    cdsSelecionarRegistroTELEFONE_RESIDENCIAL: TStringField;
    cdsSelecionarRegistroTELEFONE_COMERCIAL: TStringField;
    cdsSelecionarRegistroTELEFONE_CELULAR: TStringField;
    cdsSelecionarRegistroCNPJ: TStringField;
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
  frmSelecionaRegistroClientePessoaJuridica: TfrmSelecionaRegistroClientePessoaJuridica;

implementation

uses
  unConstantes, unCadCliente, unCadImovelInteresse, unCadVenda,
  unCadClientePessoaJuridica;

{$R *.dfm}

{ TfrmSelecionaRegistroClientePessoaJuridica }

(* procedimentos de controle *)

procedure TfrmSelecionaRegistroClientePessoaJuridica.passarParametro(pTipo:String; pValores:OleVariant);
var
  sCodClienteNovo: String;
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
    if(MessageDlg('Selecionar o cliente que foi cadastrado?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
      sCodClienteNovo := pValores;
      cdsSelecionarRegistro.Locate('CODIGO', sCodClienteNovo, []);
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
    FbMostraMensagemNaoEncontrouRegistro := False;
    if(pValores[0] = PRM_PESQUISA_NOME)then
      filtrarPesquisa();
    FbMostraMensagemNaoEncontrouRegistro := True;
    FbSelecionarTodos := pValores[2];
  end;
end;

procedure TfrmSelecionaRegistroClientePessoaJuridica.filtrarPesquisa();
var
  sVlrPesquisa: String;
begin
  if((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME')or
  (Self.FsCampoPesquisa = 'CNPJ')or(Self.FsCampoPesquisa = 'SIGLA_ESTADO')or
  (Self.FsCampoPesquisa = 'NOME_CIDADE'))then
  begin
    if(plsEdValorPesquisar.Text <> STRING_INDEFINIDO)then
    begin
      cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
      cdsSelecionarRegistro.Filtered := True;

      if(cdsSelecionarRegistro.RecordCount=0)then
      begin
        if(FbMostraMensagemNaoEncontrouRegistro)then
          MessageDlg('Nenhum cliente encontrado.',mtInformation,[mbOK],0);
        cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
        cdsSelecionarRegistro.Filtered := True;
        plsEdValorPesquisar.Clear;
      end;
    end
    else
      limparFiltroPesquisa();
  end;
end;

procedure TfrmSelecionaRegistroClientePessoaJuridica.selecionouRegistro();
begin
  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_IMOVEL_INTERESSE)then //TfrmCadImovelInteresse
    begin
      frmCadImovelInteresse.FoCliente.codigo := FiCodigo;
      frmCadImovelInteresse.FoCliente.nome := FsNome;
    end

    else if(Self.FiTelaChamou = FORM_CAD_VENDAS)then //TfrmCadVenda
    begin
      frmCadVenda.FoCliente.codigo := FiCodigo;
      frmCadVenda.FoCliente.nome := FsNome;
    end;
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroClientePessoaJuridica.configurarCaracteresAceitosPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CNPJ')or
  (Self.FsCampoPesquisa = 'SIGLA_ESTADO')or(Self.FsCampoPesquisa = 'NOME_CIDADE'))then
    plsEdValorPesquisar.plsCaracteresAceitos := todos;

  if((Self.FsCampoPesquisa = 'CC_CODIGO'))then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

procedure TfrmSelecionaRegistroClientePessoaJuridica.selecionarTodosRegistros();
  function inserirColunas(): String;
  var
    sql: String;
  begin
    sql := 'SELECT c.codigo,c.nome,c.email,c.telefone_residencial,c.telefone_comercial,';
    sql := sql + 'c.telefone_celular,c.cnpj,est.sigla as sigla_estado,cid.nome as nome_cidade,';
    sql := sql + '  CAST(c.codigo AS VARCHAR(10))AS cc_codigo ';
    Result := sql;
  end;

  function inserirTabelas(): String;
  var
    sql: String;
  begin
    sql := sql + 'FROM cliente_pessoa_juridica c ';
    Result := sql;
  end;

  function inserirCondicoes(): String;
  var
    sql: String;
  begin
    //JOIN poderia ser trocado por WHERE, para inserir table no inserirTabelas()
    sql := 'JOIN estado est ON c.cod_fk_estado=est.codigo ';
    sql := sql + 'JOIN cidade cid ON c.cod_fk_cidade=cid.codigo ';
    sql := sql + Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('c');
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
end;

procedure TfrmSelecionaRegistroClientePessoaJuridica.formatarValores();
begin
  if((cdsSelecionarRegistro.Active)and(cdsSelecionarRegistro.RecordCount>0))then
  begin
    cdsSelecionarRegistro.First;
    while(not(cdsSelecionarRegistro.Eof))do
    begin
      if(Self.FoFuncoes.verificaCNPJ_EhVazio(cdsSelecionarRegistroCNPJ.AsString))then
      begin
        cdsSelecionarRegistro.Edit;
        cdsSelecionarRegistroCNPJ.AsString := STRING_INDEFINIDO;
        cdsSelecionarRegistro.Post;
      end;
      if(Self.FoFuncoes.verificaTelefone_EhVazio(cdsSelecionarRegistroTELEFONE_RESIDENCIAL.AsString))then
      begin
        cdsSelecionarRegistro.Edit;
        cdsSelecionarRegistroTELEFONE_RESIDENCIAL.AsString := STRING_INDEFINIDO;
        cdsSelecionarRegistro.Post;
      end;
      if(Self.FoFuncoes.verificaTelefone_EhVazio(cdsSelecionarRegistroTELEFONE_COMERCIAL.AsString))then
      begin
        cdsSelecionarRegistro.Edit;
        cdsSelecionarRegistroTELEFONE_COMERCIAL.AsString := STRING_INDEFINIDO;
        cdsSelecionarRegistro.Post;
      end;
      if(Self.FoFuncoes.verificaTelefone_EhVazio(cdsSelecionarRegistroTELEFONE_CELULAR.AsString))then
      begin
        cdsSelecionarRegistro.Edit;
        cdsSelecionarRegistroTELEFONE_CELULAR.AsString := STRING_INDEFINIDO;
        cdsSelecionarRegistro.Post;
      end;
      cdsSelecionarRegistro.Next;
    end;
  end;
end;

procedure TfrmSelecionaRegistroClientePessoaJuridica.inserirNovoRegistro();
begin
  try
    Application.CreateForm(TfrmCadClientePessoaJuridica, frmCadClientePessoaJuridica);
    frmCadClientePessoaJuridica.iniciarTela(frmCadClientePessoaJuridica);
    frmCadClientePessoaJuridica.passarParametro(PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO,
     FORM_SELECIONA_REGISTRO_CLIENTE_PESSOA_JURIDICA);
    frmCadClientePessoaJuridica.ShowModal;
  finally
    FreeAndNil(frmCadClientePessoaJuridica);
  end;
end;


procedure TfrmSelecionaRegistroClientePessoaJuridica.ConfigurarCampoPesquisa();
begin
  plsEdValorPesquisar.Clear;
  FoFuncoes.focarComponente(plsEdValorPesquisar);
end;

procedure TfrmSelecionaRegistroClientePessoaJuridica.SelecionarTodosRegistrosConjuntoDadosTelaPai();
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,0],varVariant);
  vParametros[0] := CONJUNTO_DADOS_CLIENTE_PESSOA_JURIDICA;

  if(Self.FiTelaChamou = FORM_CAD_IMOVEL_INTERESSE)then //TfrmCadImovelInteresse
    frmCadImovelInteresse.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, vParametros)

  else if(FiTelaChamou = FORM_CAD_VENDAS)then //TfrmCadVenda
    frmCadVenda.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, vParametros);
end;


(* fim - procedimentos de controle *)

procedure TfrmSelecionaRegistroClientePessoaJuridica.plsCbBxCampoPesquisarChange(
  Sender: TObject);
begin
  inherited;

  Self.FsCampoPesquisa := STRING_INDEFINIDO; //default

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
      Self.FsCampoPesquisa := 'CNPJ';
      plsEdValorPesquisar.Clear;
      plsEdValorPesquisar.SetFocus;
    end;
    3:
    begin
      Self.FsCampoPesquisa := 'SIGLA_ESTADO';
      plsEdValorPesquisar.Clear;
      plsEdValorPesquisar.SetFocus;
    end;
    4:
    begin
      Self.FsCampoPesquisa := 'NOME_CIDADE';
      plsEdValorPesquisar.Clear;
      plsEdValorPesquisar.SetFocus;
    end;
  end;

  configurarCaracteresAceitosPesquisa();
  ConfigurarCampoPesquisa();
end;

procedure TfrmSelecionaRegistroClientePessoaJuridica.plsEdValorPesquisarChange(
  Sender: TObject);
begin
  inherited;
  filtrarPesquisa();
end;

procedure TfrmSelecionaRegistroClientePessoaJuridica.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigo := cdsSelecionarRegistroCODIGO.AsInteger;
  Self.FsNome := cdsSelecionarRegistroNOME.AsString;
end;

procedure TfrmSelecionaRegistroClientePessoaJuridica.FormCreate(
  Sender: TObject);
begin
  inherited;
  Self.FiCodigo := NUMERO_INDEFINIDO;
  Self.FsNome := STRING_INDEFINIDO;
  FbSelecionarTodos := True;
  FbMostraMensagemNaoEncontrouRegistro := True;
  selecionarTodosRegistros();
end;

end.
