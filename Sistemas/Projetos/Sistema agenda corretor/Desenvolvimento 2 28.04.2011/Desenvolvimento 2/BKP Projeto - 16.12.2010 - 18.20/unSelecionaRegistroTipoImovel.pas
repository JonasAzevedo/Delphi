unit unSelecionaRegistroTipoImovel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Grids, DBGrids, StdCtrls, plsComboBox,
  plsEdit, unFuncoes, Buttons, ExtCtrls;

type
  TfrmSelecionaRegistroTipoImovel = class(TfrmSelecionaRegistro)
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
  public
    procedure passarParametro(pTipo: String; pParametros: OleVariant); override;
    procedure selecionarTodosRegistros(); override;
    procedure selecionouRegistro(); override;
    procedure filtrarPesquisa(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
  end;

var
  frmSelecionaRegistroTipoImovel: TfrmSelecionaRegistroTipoImovel;

implementation

uses unConstantes, unCadImoveis, unCadImovelInteresse;

{$R *.dfm}

{ TfrmSelecionaRegistroTipoImovel }

{***** Minhas Procedures - inicio *****}

procedure TfrmSelecionaRegistroTipoImovel.passarParametro(pTipo: String; pParametros: OleVariant);
begin
  inherited;
end;

procedure TfrmSelecionaRegistroTipoImovel.filtrarPesquisa();
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

procedure TfrmSelecionaRegistroTipoImovel.selecionarTodosRegistros();
begin
  cdsSelecionarRegistro.Filter := '';
  cdsSelecionarRegistro.Filtered := False;
  cdsSelecionarRegistro.Close;

  zQrySelecionarRegistro.Close;
  zQrySelecionarRegistro.SQL.Clear;
  zQrySelecionarRegistro.SQL.Add('SELECT codigo, nome, CAST(codigo AS VARCHAR(10)) AS cc_codigo ');
  zQrySelecionarRegistro.SQL.Add('FROM tipo_imovel ');
  zQrySelecionarRegistro.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQrySelecionarRegistro.SQL.Add('ORDER BY nome');
  zQrySelecionarRegistro.Open;
  cdsSelecionarRegistro.Open;
  cdsSelecionarRegistro.First;
end;

procedure TfrmSelecionaRegistroTipoImovel.selecionouRegistro();
begin

  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_IMOVEL)then //TfrmCadImoveis
    begin
      frmCadImoveis.FoTipoImovel.codigo := FiCodigo;
      frmCadImoveis.FoTipoImovel.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_IMOVEL_INTERESSE)then //TfrmCadImovelInteresse
    begin
      frmCadImovelInteresse.FoTipoImovel.codigo := FiCodigo;
      frmCadImovelInteresse.FoTipoImovel.nome := FsNome;
    end;
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroTipoImovel.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisar.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO')then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

{***** Minhas Procedures - fim *****}



procedure TfrmSelecionaRegistroTipoImovel.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FiCodigo := NUMERO_INDEFINIDO;
  Self.FsNome := STRING_INDEFINIDO;
  Self.FoFuncoes := TFuncoes.Create;
  selecionarTodosRegistros();
end;

procedure TfrmSelecionaRegistroTipoImovel.plsCbBxCampoPesquisarChange(
  Sender: TObject);
begin
  inherited;
  Self.FsCampoPesquisa := STRING_INDEFINIDO; //default
  case plsCbBxCampoPesquisar.ItemIndex of
    0: Self.FsCampoPesquisa := 'CC_CODIGO';
    1: Self.FsCampoPesquisa := 'NOME';
  end;

  plsEdValorPesquisar.Clear;
  plsEdValorPesquisar.SetFocus;

  if(plsCbBxCampoPesquisar.ItemIndex = 0)then //código
    plsEdValorPesquisar.plsCaracteresAceitos := numeros
  else if(plsCbBxCampoPesquisar.ItemIndex = 1)then //nome
    plsEdValorPesquisar.plsCaracteresAceitos := todos;
end;

procedure TfrmSelecionaRegistroTipoImovel.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigo := cdsSelecionarRegistroCODIGO.AsInteger;
  Self.FsNome := cdsSelecionarRegistroNOME.AsString;
end;

procedure TfrmSelecionaRegistroTipoImovel.plsEdValorPesquisarChange(
  Sender: TObject);
begin
  inherited;
  if ((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME'))then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := True;
    if(cdsSelecionarRegistro.RecordCount=0)then
    begin
      MessageDlg('Nenhum tipo de imóvel encontrado.',mtInformation,[mbOK],0);
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

procedure TfrmSelecionaRegistroTipoImovel.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FoFuncoes);
end;

end.
