unit unPesquisandoGrupoBemNegociavel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, StdCtrls, plsEdit,
  ExtCtrls, Grids, DBGrids, Provider, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmPesquisandoGrupoBemNegociavel = class(TfrmPesquisandoRegistro)
    zQryPesquisando: TZQuery;
    zQryPesquisandoCODIGO: TIntegerField;
    zQryPesquisandoNOME: TStringField;
    zQryPesquisandoCC_CODIGO: TStringField;
    dspPesquisando: TDataSetProvider;
    cdsPesquisandoCODIGO: TIntegerField;
    cdsPesquisandoNOME: TStringField;
    cdsPesquisandoCC_CODIGO: TStringField;
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
  frmPesquisandoGrupoBemNegociavel: TfrmPesquisandoGrupoBemNegociavel;

implementation

uses unConstantes, unCadGrupoBemNegociavel;

{$R *.dfm}

{ TfrmPesquisandoGrupoBemNegociavel }

(* procedimentos de controle *)

procedure TfrmPesquisandoGrupoBemNegociavel.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;
  
  if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros();
end;

procedure TfrmPesquisandoGrupoBemNegociavel.selecionarTodosRegistros();
begin
end;

procedure TfrmPesquisandoGrupoBemNegociavel.popularClientDataSetPesquisa(poDados: TClientDataSet);
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

procedure TfrmPesquisandoGrupoBemNegociavel.OrdenarGrideRegistrosInciarTela;
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

procedure TfrmPesquisandoGrupoBemNegociavel.filtrarPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CC_CODIGO') then
  begin
    cdsPesquisando.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisa.Text + '%');
    cdsPesquisando.Filtered := true;
  end;

  Self.FnTotalRegistrosFiltrandoPesquisa := cdsPesquisando.RecordCount;
  if(cdsPesquisando.RecordCount=0)then
  begin
    MessageDlg('Nenhum registro encontrado.',mtInformation,[mbOK],0);
    cdsPesquisando.Filter := STRING_INDEFINIDO;
    cdsPesquisando.Filtered := true;
    plsEdValorPesquisa.Clear;
  end;
end;

procedure TfrmPesquisandoGrupoBemNegociavel.selecionouRegistro();
begin
  if(cdsPesquisando.Active)then
  begin
    if(Self.FoNomeFormChamou is TfrmCadGrupoBemNegociavel)then
    begin
      (Self.FoNomeFormChamou as TfrmCadGrupoBemNegociavel).passarParametro(PRM_PESQUISOU,null);
      (Self.FoNomeFormChamou as TfrmCadGrupoBemNegociavel).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
    end;
    Self.Hide;
  end;
end;

procedure TfrmPesquisandoGrupoBemNegociavel.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisa.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisa.plsCaracteresAceitos := numeros;
end;

procedure TfrmPesquisandoGrupoBemNegociavel.FormatarValores();
begin
end;

(* fim - procedimentos de controle *)

end.
