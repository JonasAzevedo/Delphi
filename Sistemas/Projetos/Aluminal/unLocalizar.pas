unit unLocalizar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, plsEdit, plsComboBox, Grids, BaseGrid, AdvGrid,
  DBAdvGrid, ExtCtrls, DB, DBClient, Provider, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ComCtrls, unFuncoes, DBGrids, unFrmBasico;

type
  TfrmLocalizar = class(TFrmBasico)
    zQryDados: TZQuery;
    dspDados: TDataSetProvider;
    cdsDados: TClientDataSet;
    dsDados: TDataSource;
    grpBxPesquisar: TGroupBox;
    cbBxCampoLocalizar: TPlsComboBox;
    edLocalizar: TPlsEdit;
    pnlDados: TPanel;
    StatusBar: TStatusBar;
    grDados: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure edLocalizarChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grDadosDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure grDadosTitleClick(Column: TColumn);
  private
    FsCampoPesquisar: string;
    FsValorPesquisar: string;
  protected
    FoTelaPai: TWinControl;
    FoFuncoes: TFuncoes;
    FsTipoLocalizar: string;
    FbLocalizarRegistroRapido: Boolean;
    FoCdsRetornaSelecao: TClientDataSet; //clientDataSet responsável por retornar a seleção do registro.
    
    procedure SetCampoPesquisar(psCampo: string);
    function GetCampoPesquisar: string;
    procedure SetValorPesquisar(psValor: string);
    function GetValorPesquisar: string;

    procedure FecharTela; dynamic; abstract;
    procedure AtualizarTela; dynamic;
    procedure Limpar; dynamic;
    procedure SelecionarTodosDados; dynamic; abstract; //seleciona todos os dados da tabela
    procedure DefinirCampoPesquisar(psCampo: string); dynamic; abstract;
    procedure LocalizarRegistroParte; dynamic; abstract;
    procedure DefinirTextoStatusBar(pnPanel: integer; psTexto: string); dynamic; abstract;
    procedure RetornarSelecao; dynamic;
    procedure EnviarOutrosParametrosRetornarSelecao; dynamic; abstract;
    procedure configurarCaracteresAceitosPesquisa; dynamic; abstract; //configura os caracteres aceitos no campo de pesquisa
    procedure DefinirDataSetRetornaSelecao; dynamic; abstract;
    procedure DefinirLarguraAlturaTela;
  public
    function RetornarTotalRegistros: Integer;
    procedure PassaParametro(const psParametro: string; const pvValor: OleVariant); override;
  end;

implementation

uses unDM, unConstantes;

{$R *.dfm}

procedure TfrmLocalizar.SetCampoPesquisar(psCampo: string);
begin
  FsCampoPesquisar := psCampo;
  configurarCaracteresAceitosPesquisa;
end;

function TfrmLocalizar.GetCampoPesquisar: string;
begin
  Result := FsCampoPesquisar;
end;

procedure TfrmLocalizar.SetValorPesquisar(psValor: string);
begin
  FsValorPesquisar := psValor;
end;

function TfrmLocalizar.GetValorPesquisar: string;
begin
  Result := FsValorPesquisar;
end;

procedure TfrmLocalizar.RetornarSelecao;
var
  oCdsRetorno: TClientDataSet;
  vRetorno: OleVariant;
begin
//  if not(Assigned(GetTelaPai)) then
  if not(Assigned(FoTelaPai)) then
    Exit;

  if (FoCdsRetornaSelecao.RecordCount = 0) then
  begin
    TFrmBasico(FoTelaPai).PassaParametro(sPRM_NAO_SELECIONOU_REGISTRO_TELA_LOCALIZAR, FsTipoLocalizar);
    Exit;
  end;

  oCdsRetorno := TClientDataSet.Create(nil);
  try
    FoFuncoes.CopiarCamposEntreDatasets(FoCdsRetornaSelecao, oCdsRetorno);
    oCdsRetorno.CreateDataSet;
    FoFuncoes.CopiarRegistro(FoCdsRetornaSelecao, oCdsRetorno);

    vRetorno := VarArrayCreate([0, 1], varVariant);
    vRetorno[0] := FsTipoLocalizar;
    vRetorno[1] := oCdsRetorno.Data;

    EnviarOutrosParametrosRetornarSelecao;
    TFrmBasico(FoTelaPai).PassaParametro(sPRM_SELECIONOU_REGISTRO_TELA_LOCALIZAR, vRetorno);
  finally
    FreeAndNil(oCdsRetorno);
  end;
end;

procedure TfrmLocalizar.DefinirLarguraAlturaTela;
begin
  Self.Constraints.MinWidth := Self.Width;
  Self.Constraints.MinHeight := Self.Height;
  Self.Constraints.MaxWidth := Self.Width;
  Self.Constraints.MaxHeight := Self.Height;
end;

function TfrmLocalizar.RetornarTotalRegistros: Integer;
begin
  Result := FoCdsRetornaSelecao.RecordCount;
end;

procedure TfrmLocalizar.PassaParametro(const psParametro: string; const pvValor: OleVariant);
begin
  inherited;
  
  if (psParametro = sPRM_ATUALIZAR_TELA) then
    AtualizarTela

  else if (psParametro = sPRM_TELA_PAI) and (not VarIsNull(pvValor)) then
    integer(FoTelaPai) := pvValor

  else if (psParametro = sPRM_CAMPO_PESQUISAR) then
  begin
    SetCampoPesquisar(pvValor);
    DefinirCampoPesquisar(GetCampoPesquisar);
  end

  else if (psParametro = sPRM_VALOR_PESQUISAR) then
  begin
    SetValorPesquisar(pvValor);
    edLocalizar.Text := GetValorPesquisar;
  end

  else if (psParametro = sPRM_EXECUTAR_PESQUISA) then
    LocalizarRegistroParte

  else if (psParametro = sPRM_LOCALIZAR_REGISTRO_RAPIDO) then
    FbLocalizarRegistroRapido := pvValor;
end;

procedure TfrmLocalizar.AtualizarTela;
begin
  Limpar;
  SelecionarTodosDados;
end;

procedure TfrmLocalizar.Limpar;
begin
  SetCampoPesquisar(STRING_INDEFINIDO);
  SetValorPesquisar(STRING_INDEFINIDO);

  cbBxCampoLocalizar.ItemIndex := -1;
  edLocalizar.Clear;
//  FoFuncoes.focarComponente(cbBxCampoLocalizar);
end;

procedure TfrmLocalizar.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  DefinirDataSetRetornaSelecao;
  Limpar;
  SelecionarTodosDados;
  FsTipoLocalizar := STRING_INDEFINIDO;
  //FoFuncoes.AjustarLarguraColunasTDBGrid(grDados);
  DefinirLarguraAlturaTela;
  FbLocalizarRegistroRapido := False;  
end;

procedure TfrmLocalizar.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

procedure TfrmLocalizar.edLocalizarChange(Sender: TObject);
begin
  LocalizarRegistroParte;
end;

procedure TfrmLocalizar.grDadosDblClick(Sender: TObject);
begin
  RetornarSelecao;
  Close;
end;

procedure TfrmLocalizar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
    FecharTela

  else if Key = #13 then
  begin
    RetornarSelecao;
    Close;
  end;
end;

procedure TfrmLocalizar.grDadosTitleClick(Column: TColumn);
begin
  FoFuncoes.CriarIndiceOrdenarDadosColuna(FoCdsRetornaSelecao,Column);
end;

end.
