unit unSelecionaRegistroEstado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Menus, Grids, DBGrids, StdCtrls, plsEdit, plsComboBox,
  Provider, DBClient, unFuncoes, Buttons, ExtCtrls;

type
  TfrmSelecionaRegistroEstado = class(TfrmSelecionaRegistro)
    cdsSelecionarRegistroCODIGO: TIntegerField;
    cdsSelecionarRegistroNOME: TStringField;
    cdsSelecionarRegistroSIGLA: TStringField;
    cdsSelecionarRegistroCC_CODIGO: TStringField;
    zqrySelecionarRegistroCODIGO: TIntegerField;
    zqrySelecionarRegistroNOME: TStringField;
    zqrySelecionarRegistroSIGLA: TStringField;
    zqrySelecionarRegistroCC_CODIGO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure plsCbBxCampoPesquisarChange(Sender: TObject);
    procedure cdsSelecionarRegistroAfterScroll(DataSet: TDataSet);
    procedure plsEdValorPesquisarChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FiCodigo: integer;
    FsNome: string;
    FsCampoPesquisa: string;
    FoFuncoes: TFuncoes;
  public
    procedure passarParametro(pTipo: String; pParametros: OleVariant); override;
    procedure selecionarTodosRegistros(); override;
    //procedure popularCampoInteiroTipoString(); override;
    procedure selecionouRegistro(); override;
    procedure filtrarPesquisa(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
  end;

var
  frmSelecionaRegistroEstado: TfrmSelecionaRegistroEstado;

implementation

uses unConstantes, unCadCidade, unCadCliente, unCadPessoaFisica,
  unCadImoveis, unCadPessoaJuridica;

{$R *.dfm}

{ TfrmSelecionaRegistroCliente }

{***** Minhas Procedures - inicio *****}

procedure TfrmSelecionaRegistroEstado.passarParametro(pTipo: String; pParametros: OleVariant);
begin
  inherited;
end;

procedure TfrmSelecionaRegistroEstado.filtrarPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'SIGLA')or
   (Self.FsCampoPesquisa = 'CC_CODIGO')) then
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

procedure TfrmSelecionaRegistroEstado.selecionarTodosRegistros();
begin
  cdsSelecionarRegistro.Filter := '';
  cdsSelecionarRegistro.Filtered := False;
  cdsSelecionarRegistro.Close;

  zQrySelecionarRegistro.Close;
  zQrySelecionarRegistro.SQL.Clear;
  zQrySelecionarRegistro.SQL.Add('SELECT codigo, nome, sigla, CAST(codigo AS VARCHAR(10))AS cc_codigo ');
  zQrySelecionarRegistro.SQL.Add('FROM estado ');
  zQrySelecionarRegistro.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  //zQrySelecionarRegistro.SQL.Add('ORDER BY sigla');
  zQrySelecionarRegistro.SQL.Add('ORDER BY codigo');
  zQrySelecionarRegistro.Open;
  cdsSelecionarRegistro.Open;
  cdsSelecionarRegistro.First;
end;

{
procedure TfrmSelecionaRegistroEstado.popularCampoInteiroTipoString();
begin
  cdsSelecionarRegistro.First;
  while(not(cdsSelecionarRegistro.Eof))do
  begin
    cdsSelecionarRegistro.Edit;
    cdsSelecionarRegistro.FieldByName('CC_CODIGO').AsString := cdsSelecionarRegistro.FieldByName('CODIGO').AsString;
    cdsSelecionarRegistro.Post;
    cdsSelecionarRegistro.Next;
  end;
  cdsSelecionarRegistro.Active := True;
end;
}

procedure TfrmSelecionaRegistroEstado.selecionouRegistro();
begin

  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_CIDADE)then //TfrmCadCidade
    begin
      frmCadCidade.FoEstado.codigo := FiCodigo;
      frmCadCidade.FoEstado.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_CLIENTE)then //TfrmCadCliente
    begin
      frmCadCliente.FoEstado.codigo := FiCodigo;
      frmCadCliente.FoEstado.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_PESSOA_FISICA)then //TfrmCadPessoaFisica
    begin
      frmCadPessoaFisica.FoEstado.codigo := FiCodigo;
      frmCadPessoaFisica.FoEstado.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_PESSOA_JURIDICA)then //TfrmCadPessoaJuridica
    begin
      frmCadPessoaJuridica.FoEstado.codigo := FiCodigo;
      frmCadPessoaJuridica.FoEstado.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_IMOVEL)then //TfrmCadImoveis
    begin
      frmCadImoveis.FoEstado.codigo := FiCodigo;
      frmCadImoveis.FoEstado.nome := FsNome;
    end;
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroEstado.configurarCaracteresAceitosPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'SIGLA'))then
    plsEdValorPesquisar.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

{***** Minhas Procedures - fim *****}

procedure TfrmSelecionaRegistroEstado.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FiCodigo := NUMERO_INDEFINIDO;
  Self.FsNome := STRING_INDEFINIDO;
  Self.FoFuncoes := TFuncoes.Create;
  selecionarTodosRegistros();
end;

procedure TfrmSelecionaRegistroEstado.plsCbBxCampoPesquisarChange(
  Sender: TObject);
begin
  inherited;

  Self.FsCampoPesquisa := STRING_INDEFINIDO; //default
  case plsCbBxCampoPesquisar.ItemIndex of
    0: Self.FsCampoPesquisa := 'CC_CODIGO';
    1: Self.FsCampoPesquisa := 'NOME';
    2: Self.FsCampoPesquisa := 'SIGLA';
  end;

  plsEdValorPesquisar.Clear;
  plsEdValorPesquisar.SetFocus;


  if(plsCbBxCampoPesquisar.ItemIndex = 0)then //código
    plsEdValorPesquisar.plsCaracteresAceitos := numeros
  else if(plsCbBxCampoPesquisar.ItemIndex IN [1,2])then //nome ou sigla
    plsEdValorPesquisar.plsCaracteresAceitos := todos;
end;

procedure TfrmSelecionaRegistroEstado.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigo := cdsSelecionarRegistroCODIGO.AsInteger;
  Self.FsNome := cdsSelecionarRegistroNOME.AsString;
end;

procedure TfrmSelecionaRegistroEstado.plsEdValorPesquisarChange(
  Sender: TObject);
begin
  inherited;

  if ((Self.FsCampoPesquisa = 'CC_CODIGO') or (Self.FsCampoPesquisa = 'NOME')
    or (Self.FsCampoPesquisa = 'SIGLA'))then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := True;
    if(cdsSelecionarRegistro.RecordCount=0)then
    begin
      MessageDlg('Nenhum estado encontrado.',mtInformation,[mbOK],0);
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

procedure TfrmSelecionaRegistroEstado.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FoFuncoes);
end;

end.
