unit unSelecionaRegistroCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Grids, DBGrids, StdCtrls, plsComboBox,
  plsEdit, unFuncoes, Buttons, ExtCtrls;

type
  TfrmSelecionaRegistroCidade = class(TfrmSelecionaRegistro)
    cdsSelecionarRegistroCODIGO: TIntegerField;
    cdsSelecionarRegistroNOME: TStringField;
    cdsSelecionarRegistroCC_CODIGO: TStringField;
    cdsSelecionarRegistroSIGLA: TStringField;
    zqrySelecionarRegistroCODIGO: TIntegerField;
    zqrySelecionarRegistroNOME: TStringField;
    zqrySelecionarRegistroCC_CODIGO: TStringField;
    zqrySelecionarRegistroCOD_FK_ESTADO: TIntegerField;
    zqrySelecionarRegistroSIGLA: TStringField;
    cdsSelecionarRegistroCOD_FK_ESTADO: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure plsCbBxCampoPesquisarChange(Sender: TObject);
    procedure cdsSelecionarRegistroAfterScroll(DataSet: TDataSet);
    procedure plsEdValorPesquisarChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    FiCodigo: integer;
    FsNome: string;
    FsCampoPesquisa: string;
    FiFkCodEstado: integer;
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
    procedure SelecionarTodosRegistrosConjuntoDadosTelaPai;
    //deletar todos os registros que nao sao do estado FiFkCodEstado
    procedure DeletarRegistrosNaoPertencemEstado();
  end;

var
  frmSelecionaRegistroCidade: TfrmSelecionaRegistroCidade;

implementation

uses unCadBairro, unConstantes, unCadCliente, unCadPessoaFisica,
  unCadImoveis, unCadCidade, unCadPessoaJuridica,
  unCadClientePessoaJuridica, unPesquisarAgenciamentos;

{$R *.dfm}

{ TfrmSelecionaRegistroCidade }

{***** Minhas Procedures - inicio *****}

procedure TfrmSelecionaRegistroCidade.passarParametro(pTipo:String; pValores:OleVariant);
var
  sCodCidadeNova: String;
begin
  inherited;

  if(pTipo = 'FK_COD_ESTADO')then
  begin
    if(VarIsNumeric(pValores))then
      Self.FiFkCodEstado := pValores;
  end

  else if(pTipo = PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.selecionarTodosRegistros();
    SelecionarTodosRegistrosConjuntoDadosTelaPai();
    if(MessageDlg('Selecionar a cidade que foi cadastrada?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
      sCodCidadeNova := pValores;
      cdsSelecionarRegistro.Locate('CODIGO', sCodCidadeNova, []);
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
  //pParametros[3]: FbSelecionarTodos - codigo do estado para filtrar as cidades
  begin
    plsEdValorPesquisar.Text := VarToStr(pValores[1]);
    if(pValores[0] = PRM_PESQUISA_NOME)then
    begin
      plsCbBxCampoPesquisar.ItemIndex := 1;
      FsCampoPesquisa := 'NOME';
      plsEdValorPesquisar.plsCaracteresAceitos := todos;
      if(FiFkCodEstado <> NUMERO_INDEFINIDO)then
        DeletarRegistrosNaoPertencemEstado();
      FbMostraMensagemNaoEncontrouRegistro := False;
      filtrarPesquisa();
      FbMostraMensagemNaoEncontrouRegistro := True;
    end;
    FbSelecionarTodos := pValores[2];
  end;
end;

procedure TfrmSelecionaRegistroCidade.filtrarPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CC_CODIGO')) then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := true;
  end;

  if(cdsSelecionarRegistro.RecordCount=0)then
  begin
    if(FbMostraMensagemNaoEncontrouRegistro)then
      MessageDlg('Nenhuma cidade encontrada.',mtInformation,[mbOK],0);
    cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
    cdsSelecionarRegistro.Filtered := true;
    //plsEdValorPesquisar.Clear;
    FoFuncoes.focarComponente(plsEdValorPesquisar);
  end;
end;

procedure TfrmSelecionaRegistroCidade.selecionarTodosRegistros();
begin
  if(FbSelecionarTodos)then
  begin
    cdsSelecionarRegistro.Filter := '';
    cdsSelecionarRegistro.Filtered := False;
    cdsSelecionarRegistro.Close;

    zQrySelecionarRegistro.Close;
    zQrySelecionarRegistro.SQL.Clear;
    zQrySelecionarRegistro.SQL.Add('SELECT c.codigo, c.nome, CAST(c.codigo AS VARCHAR(10)) AS cc_codigo,');
    zQrySelecionarRegistro.SQL.Add('e.codigo AS cod_fk_estado,e.sigla ');
    zQrySelecionarRegistro.SQL.Add('FROM cidade c ');
    zQrySelecionarRegistro.SQL.Add('JOIN estado e ON c.cod_fk_estado = e.codigo ');
    zQrySelecionarRegistro.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('c'));
    if(Self.FiFkCodEstado <> NUMERO_INDEFINIDO)then
    begin
      zQrySelecionarRegistro.SQL.Add('AND c.cod_fk_estado=:fkEst ');
      zQrySelecionarRegistro.ParamByName('fkEst').AsInteger := Self.FiFkCodEstado;
    end;
    zqrySelecionarRegistro.SQL.Add('ORDER BY c.nome ');
    zQrySelecionarRegistro.Open;
    cdsSelecionarRegistro.Open;
    cdsSelecionarRegistro.First;
  end;

  FbSelecionarTodos := True;

  inherited;
end;

procedure TfrmSelecionaRegistroCidade.selecionouRegistro();
begin

  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_BAIRRO)then //TfrmCadBairro
    begin
      frmCadBairro.FoCidade.codigo := FiCodigo;
      frmCadBairro.FoCidade.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_CLIENTE)then //TfrmCadCliente
    begin
      frmCadCliente.FoCidade.codigo := FiCodigo;
      frmCadCliente.FoCidade.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_CLIENTE_PESSOA_JURIDICA)then //TfrmCadClientePessoaJuridica
    begin
      frmCadClientePessoaJuridica.FoCidade.codigo := FiCodigo;
      frmCadClientePessoaJuridica.FoCidade.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_PESSOA_FISICA)then //TfrmCadPessoaFisica
    begin
      frmCadPessoaFisica.FoCidade.codigo := FiCodigo;
      frmCadPessoaFisica.FoCidade.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_PESSOA_JURIDICA)then //TfrmCadPessoaJuridica
    begin
      frmCadPessoaJuridica.FoCidade.codigo := FiCodigo;
      frmCadPessoaJuridica.FoCidade.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_IMOVEL)then //TfrmCadImoveis
    begin
      frmCadImoveis.FoCidade.codigo := FiCodigo;
      frmCadImoveis.FoCidade.nome := FsNome;
    end
    else if(FiTelaChamou = FORM_PESQUISAR_AGENCIAMENTO)then //TfrmPesquisarAgenciamentos
    begin
      frmPesquisarAgenciamentos.FoCidade.codigo := FiCodigo;
      frmPesquisarAgenciamentos.FoCidade.nome := FsNome;
    end;
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroCidade.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisar.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

procedure TfrmSelecionaRegistroCidade.inserirNovoRegistro();
begin
  try
    Application.CreateForm(TfrmCadCidade,frmCadCidade);
    frmCadCidade.iniciarTela(frmCadCidade);
    frmCadCidade.passarParametro(PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO, FORM_SELECIONA_REGISTRO_CIDADE);
    frmCadCidade.passarParametro(PRM_DEFINE_ESTADO_CIDADE_INSERINDO, Self.FiFkCodEstado);
    frmCadCidade.ShowModal;
  finally
    FreeAndNil(frmCadCidade);
  end;
end;

procedure TfrmSelecionaRegistroCidade.ConfigurarCampoPesquisa();
begin
  plsEdValorPesquisar.Clear;
  FoFuncoes.focarComponente(plsEdValorPesquisar);

  if(plsCbBxCampoPesquisar.ItemIndex = 0)then //código
    plsEdValorPesquisar.plsCaracteresAceitos := numeros
  else if(plsCbBxCampoPesquisar.ItemIndex = 1)then //nome
    plsEdValorPesquisar.plsCaracteresAceitos := todos;
end;

//seleciona todos os registros do conjunto de dados da tela pai
procedure TfrmSelecionaRegistroCidade.SelecionarTodosRegistrosConjuntoDadosTelaPai;
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,0],varVariant);
  vParametros[0] := CONJUNTO_DADOS_CIDADE;

  if(Self.FiTelaChamou = FORM_CAD_BAIRRO)then //TfrmCadBairro
    frmCadBairro.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, null)

  else if(Self.FiTelaChamou = FORM_CAD_CLIENTE)then //TfrmCadCliente
    frmCadCliente.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, vParametros)

  else if(Self.FiTelaChamou = FORM_CAD_CLIENTE_PESSOA_JURIDICA)then //TfrmCadClientePessoaJuridica
    frmCadClientePessoaJuridica.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, vParametros)

  else if(Self.FiTelaChamou = FORM_CAD_PESSOA_FISICA)then //TfrmCadPessoaFisica
    frmCadPessoaFisica.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, vParametros)

  else if(Self.FiTelaChamou = FORM_CAD_PESSOA_JURIDICA)then //TfrmCadPessoaJuridica
    frmCadPessoaJuridica.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, vParametros)

  else if(Self.FiTelaChamou = FORM_CAD_IMOVEL)then //TfrmCadImoveis
    frmCadImoveis.passarParametro(PRM_SELECIONAR_TODOS_REGISTROS_CONJUNTO_DADOS, vParametros)
end;

procedure TfrmSelecionaRegistroCidade.DeletarRegistrosNaoPertencemEstado();
var
  sFiltro: String;
begin
  sFiltro := cdsSelecionarRegistro.Filter;
  cdsSelecionarRegistro.Filter := '';
  cdsSelecionarRegistro.filtered := False;

  if(FiFkCodEstado <> NUMERO_INDEFINIDO)then
  begin
    cdsSelecionarRegistro.First;
    while(not(cdsSelecionarRegistro.Eof))do
    begin
      if(cdsSelecionarRegistro.FieldByName('cod_fk_estado').AsInteger <> FiFkCodEstado)then
        cdsSelecionarRegistro.Delete
      else
        cdsSelecionarRegistro.Next;
    end;
  end;

  cdsSelecionarRegistro.Filter := sFiltro;
  cdsSelecionarRegistro.Filtered := True;
end;

{***** Minhas Procedures - fim *****}

procedure TfrmSelecionaRegistroCidade.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FiCodigo := NUMERO_INDEFINIDO;
  Self.FsNome := STRING_INDEFINIDO;
  Self.FiFkCodEstado := NUMERO_INDEFINIDO;
  FbSelecionarTodos := True;
  FbMostraMensagemNaoEncontrouRegistro := True;
  selecionarTodosRegistros();
end;

procedure TfrmSelecionaRegistroCidade.plsCbBxCampoPesquisarChange(
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

procedure TfrmSelecionaRegistroCidade.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigo := cdsSelecionarRegistroCODIGO.AsInteger;
  Self.FsNome := cdsSelecionarRegistroNOME.AsString;
end;

procedure TfrmSelecionaRegistroCidade.plsEdValorPesquisarChange(
  Sender: TObject);
begin
  inherited;
  if ((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME'))then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := True;
    if(cdsSelecionarRegistro.RecordCount=0)then
    begin
      MessageDlg('Nenhuma cidade encontrada.',mtInformation,[mbOK],0);
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

procedure TfrmSelecionaRegistroCidade.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  //apertou 'ESC', então não limpa o endereço
  if(Key=#27)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_CLIENTE)then //TfrmCadCliente
      frmCadCliente.passarParametro(PRM_NAO_LIMPAR_ENDERECO, null)

    else if(Self.FiTelaChamou = FORM_CAD_PESSOA_FISICA)then //TfrmCadPessoaFisica
      frmCadPessoaFisica.passarParametro(PRM_NAO_LIMPAR_ENDERECO, null)

    else if(Self.FiTelaChamou = FORM_CAD_PESSOA_JURIDICA)then //TfrmCadPessoaJuridica
      frmCadPessoaJuridica.passarParametro(PRM_NAO_LIMPAR_ENDERECO, null)

    else if(Self.FiTelaChamou = FORM_CAD_IMOVEL)then //TfrmCadImoveis
      frmCadImoveis.passarParametro(PRM_NAO_LIMPAR_ENDERECO, null)

    else if(FiTelaChamou = FORM_PESQUISAR_AGENCIAMENTO)then //TfrmPesquisarAgenciamentos
      frmPesquisarAgenciamentos.passarParametro(PRM_NAO_LIMPAR_ENDERECO, null)

  end;

  inherited;
end;

procedure TfrmSelecionaRegistroCidade.FormShow(Sender: TObject);
begin
  inherited;
  FoFuncoes.focarComponente(plsEdValorPesquisar);
end;

end.
