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
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
  protected
    procedure selecionarTodosRegistros();
    procedure popularClientDataSetPesquisa(poDados: TClientDataSet); override;
    procedure filtrarPesquisa(); override;
    procedure selecionouRegistro(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
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

procedure TfrmPesquisandoCidade.filtrarPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CC_CODIGO') then
  begin
    cdsPesquisando.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisa.Text + '%');
    cdsPesquisando.Filtered := true;
  end;

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
      (Self.FoNomeFormChamou as TfrmCadCidade).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
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

(* fim - procedimentos de controle *)



procedure TfrmPesquisandoCidade.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoFuncoes);
end;

procedure TfrmPesquisandoCidade.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoFuncoes := TFuncoes.Create;
end;

end.
