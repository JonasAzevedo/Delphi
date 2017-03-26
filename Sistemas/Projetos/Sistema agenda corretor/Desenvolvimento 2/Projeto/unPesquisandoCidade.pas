unit unPesquisandoCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, Grids, DBGrids, StdCtrls,
  plsEdit, ExtCtrls, unFuncoes, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Provider;

type
  TfrmPesquisandoCidade = class(TfrmPesquisandoRegistro)
    cdsPesquisandoCODIGO: TIntegerField;
    cdsPesquisandoNOME: TStringField;
    cdsPesquisandoCC_CODIGO: TStringField;
    dspPesquisando: TDataSetProvider;
    zQryPesquisando: TZQuery;
    zQryPesquisandoCODIGO: TIntegerField;
    zQryPesquisandoNOME: TStringField;
    zQryPesquisandoCC_CODIGO: TStringField;
  private
  protected
    procedure selecionarTodosRegistros();
    procedure popularClientDataSetPesquisa(poDados: TClientDataSet); override;
    procedure OrdenarGrideRegistrosInciarTela; override;
    procedure filtrarPesquisa(); override;
    procedure selecionouRegistro(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
    procedure FormatarValores(); override;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
  end;

var
  frmPesquisandoCidade: TfrmPesquisandoCidade;

implementation

uses unCadCidade, unConstantes;

{$R *.dfm}

{ TfrmPesquisandoCidade }

(* procedimentos de controle *)

procedure TfrmPesquisandoCidade.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;
  
  if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros();
end;

procedure TfrmPesquisandoCidade.selecionarTodosRegistros();
(*
  function inserirColunas(): String;
  var
    sql: String;
  begin
    sql := 'SELECT codigo,nome,CAST(codigo AS VARCHAR(20))AS cc_codigo ';
    Result := sql;
  end;

  function inserirTabelas(): String;
  var
    sql: String;
  begin
    sql := 'FROM cidade ';
    Result := sql;
  end;

  function inserirCondicoes(): String;
  var
    sql: String;
  begin
    sql := Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo();
    sql := sql + 'ORDER BY codigo ';
    Result := sql;
  end;
*)
begin
  //não implementado, pois no método popularClientDataSetPesquisa() é populado o cdsPesquisando
  //método foi definido pois ele é abstract na classe-base
(*
  cdsPesquisando.Close;
  zQryPesquisando.Close;
  zQryPesquisando.SQL.Clear;
  zQryPesquisando.SQL.Add(inserirColunas);
  zQryPesquisando.SQL.Add(inserirTabelas);
  zQryPesquisando.SQL.Add(inserirCondicoes);
  zQryPesquisando.Open;
  cdsPesquisando.Open;
*)
end;

procedure TfrmPesquisandoCidade.popularClientDataSetPesquisa(poDados: TClientDataSet);
begin
  cdsPesquisando.EmptyDataSet;
  poDados.First;
  while(not(poDados.Eof))do
  begin
    cdsPesquisando.Insert;
    cdsPesquisando.FieldByName('CODIGO').AsString := poDados.FieldByName('CODIGO').AsString;
    cdsPesquisando.FieldByName('NOME').AsString := poDados.FieldByName('NOME').AsString;
    cdsPesquisando.FieldByName('CC_CODIGO').AsString := poDados.FieldByName('CODIGO').AsString;
    cdsPesquisando.Post;
    poDados.Next;
  end;
  cdsPesquisando.Active := True;
end;

procedure TfrmPesquisandoCidade.OrdenarGrideRegistrosInciarTela;
var
  sIndexName: String;
  options: TIndexOptions;

  procedure AdicionarIndice(psCampo:String);
  begin
    if (cdsPesquisando.IndexDefs.IndexOf(sIndexName)< 0) then
      cdsPesquisando.AddIndex(sIndexName, psCampo, options);
    cdsPesquisando.IndexName := sIndexName;
  end;

begin
    if(Self.FsCampoPesquisa = 'CC_CODIGO')then
    begin
      sIndexName := 'CODIGO_ASC';
      options := [];
      AdicionarIndice('CODIGO');
    end

    else if(Self.FsCampoPesquisa = 'NOME')then
    begin
      sIndexName := 'NOME_ASC';
      options := [];
      AdicionarIndice('NOME');
    end;
end;

procedure TfrmPesquisandoCidade.filtrarPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CC_CODIGO') then
  begin
    cdsPesquisando.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisa.Text + '%');
    cdsPesquisando.Filtered := true;
  end;

  Self.FnTotalRegistrosFiltrandoPesquisa := cdsPesquisando.RecordCount; //04/04/2011
  if(cdsPesquisando.RecordCount=0)then
  begin
    MessageDlg('Nenhum registro encontrado.',mtInformation,[mbOK],0);
    cdsPesquisando.Filter := STRING_INDEFINIDO;
    cdsPesquisando.Filtered := true;
    plsEdValorPesquisa.Clear;
  end;
end;

procedure TfrmPesquisandoCidade.selecionouRegistro();
begin
  if(cdsPesquisando.Active)then
  begin
    if(Self.FoNomeFormChamou is TfrmCadCidade)then
    begin
      (Self.FoNomeFormChamou as TfrmCadCidade).passarParametro(PRM_PESQUISOU,null);
      (Self.FoNomeFormChamou as TfrmCadCidade).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
    end;
    Self.Hide;
  end;
end;

procedure TfrmPesquisandoCidade.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisa.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisa.plsCaracteresAceitos := numeros;
end;

procedure TfrmPesquisandoCidade.FormatarValores();
begin

end;

(* fim - procedimentos de controle *)


end.
