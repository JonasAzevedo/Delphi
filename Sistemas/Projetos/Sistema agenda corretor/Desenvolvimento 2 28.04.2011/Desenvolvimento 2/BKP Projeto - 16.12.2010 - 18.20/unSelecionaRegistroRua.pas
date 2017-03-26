unit unSelecionaRegistroRua;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DB, DBClient, Provider, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Grids, DBGrids, StdCtrls, plsComboBox,
  plsEdit, unFuncoes, Buttons, ExtCtrls;

type
  TfrmSelecionaRegistroRua = class(TfrmSelecionaRegistro)
    zqrySelecionarRegistroCODIGO: TIntegerField;
    zqrySelecionarRegistroNOME: TStringField;
    zqrySelecionarRegistroCEP: TStringField;
    zqrySelecionarRegistroCC_CODIGO: TStringField;
    cdsSelecionarRegistroCODIGO: TIntegerField;
    cdsSelecionarRegistroNOME: TStringField;
    cdsSelecionarRegistroCEP: TStringField;
    cdsSelecionarRegistroCC_CODIGO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure plsCbBxCampoPesquisarChange(Sender: TObject);
    procedure cdsSelecionarRegistroAfterScroll(DataSet: TDataSet);
    procedure plsEdValorPesquisarChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FoFuncoes: TFuncoes;
    FiCodigo: integer;
    FiFkCodBairro: integer;
    FsNome: string;
    FsCEP: string;
    FsCampoPesquisa: string;
  public
    procedure passarParametro(pTipo: String; pParametros: OleVariant); override;
    procedure selecionarTodosRegistros(); override;
    procedure selecionouRegistro(); override;
    procedure filtrarPesquisa(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
    procedure inserirNovoRegistro(); override;
  end;

var
  frmSelecionaRegistroRua: TfrmSelecionaRegistroRua;

implementation

uses unCadCliente, unConstantes, unCadPessoaFisica, unCadImoveis, unCadRua,
  unCadPessoaJuridica, unCadClientePessoaJuridica;

{$R *.dfm}

{ TfrmSelecionaRegistroBairro }

{***** Minhas Procedures - inicio *****}

procedure TfrmSelecionaRegistroRua.passarParametro(pTipo: String; pParametros: OleVariant);
var
  sCodRuaNovo: String;
begin
  inherited;
  if(pTipo = 'FK_COD_BAIRRO')then
  begin
    if(VarIsNumeric(pParametros))then
      Self.FiFkCodBairro := pParametros;
  end

  else if(pTipo = PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.selecionarTodosRegistros();
    if(MessageDlg('Selecionar a rua que foi cadastrada?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
      sCodRuaNovo := pParametros;
      cdsSelecionarRegistro.Locate('CODIGO', sCodRuaNovo, []);
      dbGrdDadosDblClick(Self);
    end;
  end;
end;

procedure TfrmSelecionaRegistroRua.filtrarPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CC_CODIGO')or
   (Self.FsCampoPesquisa = 'CEP')) then
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

procedure TfrmSelecionaRegistroRua.selecionarTodosRegistros();
begin
  cdsSelecionarRegistro.Filter := '';
  cdsSelecionarRegistro.Filtered := False;
  cdsSelecionarRegistro.Close;

  zQrySelecionarRegistro.Close;
  zQrySelecionarRegistro.SQL.Clear;
  zQrySelecionarRegistro.SQL.Add('SELECT codigo, nome, cep, CAST(codigo AS VARCHAR(10)) AS cc_codigo ');
  zQrySelecionarRegistro.SQL.Add('FROM rua ');
  zQrySelecionarRegistro.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  if(Self.FiFkCodBairro <> NUMERO_INDEFINIDO)then
  begin
    zQrySelecionarRegistro.SQL.Add('AND cod_fk_bairro=:fkBai ');
    zQrySelecionarRegistro.ParamByName('fkBai').AsInteger := Self.FiFkCodBairro;
  end;
  zQrySelecionarRegistro.SQL.Add('ORDER BY nome');
  zQrySelecionarRegistro.Open;
  cdsSelecionarRegistro.Open;
  cdsSelecionarRegistro.First;
end;

procedure TfrmSelecionaRegistroRua.selecionouRegistro();
begin

  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_CLIENTE)then //TfrmCadCliente
    begin
      frmCadCliente.FoRua.codigo := FiCodigo;
      frmCadCliente.FoRua.nome := FsNome;
      frmCadCliente.FoRua.cep := FsCEP;
    end
    else if(Self.FiTelaChamou = FORM_CAD_CLIENTE_PESSOA_JURIDICA)then //TfrmCadClientePessoaJuridica
    begin
      frmCadClientePessoaJuridica.FoRua.codigo := FiCodigo;
      frmCadClientePessoaJuridica.FoRua.nome := FsNome;
      frmCadClientePessoaJuridica.FoRua.cep := FsCEP;
    end
    else if(Self.FiTelaChamou = FORM_CAD_PESSOA_FISICA)then //TfrmCadPessoaFisica
    begin
      frmCadPessoaFisica.FoRua.codigo := FiCodigo;
      frmCadPessoaFisica.FoRua.nome := FsNome;
      frmCadPessoaFisica.FoRua.cep := FsCEP;
    end
    else if(Self.FiTelaChamou = FORM_CAD_PESSOA_JURIDICA)then //TfrmCadPessoaJuridica
    begin
      frmCadPessoaJuridica.FoRua.codigo := FiCodigo;
      frmCadPessoaJuridica.FoRua.nome := FsNome;
      frmCadPessoaJuridica.FoRua.cep := FsCEP;
    end
    else if(Self.FiTelaChamou = FORM_CAD_IMOVEL)then //TfrmCadImoveis
    begin
      frmCadImoveis.FoRua.codigo := FiCodigo;
      frmCadImoveis.FoRua.nome := FsNome;
      frmCadImoveis.FoRua.cep := FsCEP;
    end;
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroRua.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisar.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'CEP')then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

procedure TfrmSelecionaRegistroRua.inserirNovoRegistro();
begin
  try
    Application.CreateForm(TfrmCadRua,frmCadRua);
    frmCadRua.iniciarTela(frmCadRua);
    frmCadRua.passarParametro(PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO, FORM_SELECIONA_REGISTRO_RUA);
    frmCadRua.passarParametro(PRM_DEFINE_BAIRRO_RUA_INSERINDO, Self.FiFkCodBairro);
    frmCadRua.ShowModal;
  finally
    FreeAndNil(frmCadRua);
  end;
end;

{***** Minhas Procedures - fim *****}

procedure TfrmSelecionaRegistroRua.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoFuncoes := TFuncoes.Create;
  Self.FiCodigo := NUMERO_INDEFINIDO;
  Self.FsNome := STRING_INDEFINIDO;
  Self.FsCEP := STRING_INDEFINIDO;
  Self.FiFkCodBairro := NUMERO_INDEFINIDO;
  selecionarTodosRegistros();
end;

procedure TfrmSelecionaRegistroRua.plsCbBxCampoPesquisarChange(
  Sender: TObject);
begin
  inherited;
  Self.FsCampoPesquisa := STRING_INDEFINIDO; //default
  case plsCbBxCampoPesquisar.ItemIndex of
    0: Self.FsCampoPesquisa := 'CC_CODIGO';
    1: Self.FsCampoPesquisa := 'NOME';
    2: Self.FsCampoPesquisa := 'CEP';
  end;

  plsEdValorPesquisar.Clear;
  plsEdValorPesquisar.SetFocus;

  if(plsCbBxCampoPesquisar.ItemIndex IN [0,2])then //código, cep
    plsEdValorPesquisar.plsCaracteresAceitos := numeros
  else if(plsCbBxCampoPesquisar.ItemIndex = 1)then //nome
    plsEdValorPesquisar.plsCaracteresAceitos := todos;
end;

procedure TfrmSelecionaRegistroRua.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigo := cdsSelecionarRegistroCODIGO.AsInteger;
  Self.FsNome := cdsSelecionarRegistroNOME.AsString;
  Self.FsCEP := cdsSelecionarRegistroCEP.AsString;
end;

procedure TfrmSelecionaRegistroRua.plsEdValorPesquisarChange(
  Sender: TObject);
begin
  inherited;
  if ((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME')or
    (Self.FsCampoPesquisa = 'CEP'))then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := True;
    if(cdsSelecionarRegistro.RecordCount=0)then
    begin
      MessageDlg('Nenhuma rua encontrado.',mtInformation,[mbOK],0);
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

procedure TfrmSelecionaRegistroRua.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FoFuncoes);
end;

procedure TfrmSelecionaRegistroRua.FormKeyPress(Sender: TObject;
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
      frmCadImoveis.passarParametro(PRM_NAO_LIMPAR_ENDERECO, null);            
  end;

  inherited;
end;

end.
