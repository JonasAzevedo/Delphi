unit unPesquisandoRegistro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Provider, DB, DBClient, Grids, DBGrids, StdCtrls, plsEdit,
  ExtCtrls, unFuncoes;

type
  TfrmPesquisandoRegistro = class(TForm)
    dbGrdRegistros: TDBGrid;
    cdsPesquisando: TClientDataSet;
    dsPesquisando: TDataSource;
    pnlTopo: TPanel;
    plsEdValorPesquisa: TPlsEdit;
    lblCampo: TLabel;
    procedure dbGrdRegistrosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure plsEdValorPesquisaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbGrdRegistrosTitleClick(Column: TColumn);
    procedure FormDestroy(Sender: TObject);
  private

  protected
    FoFuncoes: TFuncoes;
    FoNomeFormChamou: TForm;
    FsCampoPesquisa: String;
    FnTotalRegistrosFiltrandoPesquisa: Integer; //04/04/2011

    procedure popularClientDataSetPesquisa(poDados: TClientDataSet); dynamic; abstract; //popula o DataSet que realiza a pesquisa
    procedure filtrarPesquisa(); dynamic;//filtra pesquisa com o que for digitando
    procedure selecionouRegistro(); dynamic; abstract; //selecionou registro
    procedure configurarCaracteresAceitosPesquisa(); dynamic; abstract; //configura os caracteres aceitos no campo de pesquisa
    procedure FormatarValores(); dynamic; abstract; //formata valores que aparecem na gride
    procedure OrdenarGrideRegistrosInciarTela(); dynamic; abstract; //ordena o gride dbGrdRegistros com base na variável FsCampoPesquisa ao iniciar a tela
  public
    procedure iniciarTela(poForm: TForm); dynamic;
    procedure passarParametro(pTipo:String; pValores:OleVariant); dynamic;
    procedure atualizarPesquisando(psCampoPesquisa: string; psNomeCampo: string; psValor: string; poDados: TClientDataSet); dynamic;
    function PodeAbrirTelaPesquisandoRegistro(): Boolean; //04/04/2011
  end;

var
  frmPesquisandoRegistro: TfrmPesquisandoRegistro;

implementation

uses unConstantes;

{$R *.dfm}

{ TfrmPesquisandoRegistro }

(* procedimentos de controle *)

procedure TfrmPesquisandoRegistro.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = sPRM_AJUSTAR_LARGURA_GRIDE)then
    FoFuncoes.AjustarLarguraColunasTDBGrid(dbGrdRegistros);
end;

procedure TfrmPesquisandoRegistro.iniciarTela(poForm: TForm);
begin
  Self.FoNomeFormChamou := poForm;
  Self.FnTotalRegistrosFiltrandoPesquisa := NUMERO_INDEFINIDO; //04/04/2011
end;

procedure TfrmPesquisandoRegistro.filtrarPesquisa();
begin
  FormatarValores();
end;

procedure TfrmPesquisandoRegistro.atualizarPesquisando(psCampoPesquisa: string;
 psNomeCampo: string; psValor: string; poDados: TClientDataSet);
begin
  plsEdValorPesquisa.Text := STRING_INDEFINIDO;
  Self.FsCampoPesquisa := psCampoPesquisa;
  lblCampo.Caption := psNomeCampo;
  Self.popularClientDataSetPesquisa(poDados);
  Self.OrdenarGrideRegistrosInciarTela;
  plsEdValorPesquisa.Text := psValor;
  //Self.filtrarPesquisa();
  Self.configurarCaracteresAceitosPesquisa();
  FormatarValores();
end;

function TfrmPesquisandoRegistro.PodeAbrirTelaPesquisandoRegistro(): Boolean;
begin
  Result := Self.FnTotalRegistrosFiltrandoPesquisa > NUMERO_INDEFINIDO; //04/04/2011
end;

(* fim - procedimentos de controle *)

procedure TfrmPesquisandoRegistro.dbGrdRegistrosDblClick(Sender: TObject);
begin
  Self.selecionouRegistro();
end;

procedure TfrmPesquisandoRegistro.FormShow(Sender: TObject);
begin
  plsEdValorPesquisa.SetFocus;
end;

procedure TfrmPesquisandoRegistro.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if(Key=#13)then
  begin
    if((cdsPesquisando.Active)and(cdsPesquisando.RecordCount>0))then
      selecionouRegistro();
//    Key := #0;
  end

  else if(Key=#27)then
    Self.Close;
end;

procedure TfrmPesquisandoRegistro.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  cdsPesquisando.CreateDataSet;
end;

procedure TfrmPesquisandoRegistro.FormHide(Sender: TObject);
begin
  cdsPesquisando.Filter := STRING_INDEFINIDO;
  cdsPesquisando.Filtered := False;
end;

procedure TfrmPesquisandoRegistro.plsEdValorPesquisaChange(
  Sender: TObject);
begin
  if(plsEdValorPesquisa.Text = STRING_INDEFINIDO)then
  begin
    cdsPesquisando.Filter := STRING_INDEFINIDO;
    cdsPesquisando.Filtered := False;
    FormatarValores();
  end
  else
    Self.filtrarPesquisa();
end;

procedure TfrmPesquisandoRegistro.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F5) then
    selecionouRegistro();
end;

procedure TfrmPesquisandoRegistro.dbGrdRegistrosTitleClick(
  Column: TColumn);
begin
  FoFuncoes.CriarIndiceOrdenarDadosColuna(cdsPesquisando,Column);
end;

procedure TfrmPesquisandoRegistro.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

end.
