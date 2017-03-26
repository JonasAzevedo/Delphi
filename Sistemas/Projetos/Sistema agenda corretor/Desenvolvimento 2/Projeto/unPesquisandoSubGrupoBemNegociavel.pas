unit unPesquisandoSubGrupoBemNegociavel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, StdCtrls, plsEdit,
  ExtCtrls, Grids, DBGrids, Provider, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmPesquisandoSubGrupoBemNegociavel = class(TfrmPesquisandoRegistro)
    zQryPesquisando: TZQuery;
    dspPesquisando: TDataSetProvider;
    zQryPesquisandoCODIGO: TIntegerField;
    zQryPesquisandoNOME: TStringField;
    zQryPesquisandoCC_CODIGO: TStringField;
    cdsPesquisandoCODIGO: TIntegerField;
    cdsPesquisandoNOME: TStringField;
    cdsPesquisandoCC_CODIGO: TStringField;
    zQryPesquisandoNOME_GRUPO: TStringField;
    cdsPesquisandoNOME_GRUPO: TStringField;
    zQryGrupo: TZQuery;
    zQryGrupoCODIGO: TIntegerField;
    zQryGrupoNOME: TStringField;
  private
    function GetNomeGrupo(pnCodGrupo:Integer): String;  
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
  frmPesquisandoSubGrupoBemNegociavel: TfrmPesquisandoSubGrupoBemNegociavel;

implementation

uses unConstantes, unCadSubGrupoBemNegociavel;

{$R *.dfm}

{ TfrmPesquisandoSubGrupoBemNegociavel }

(* procedimentos de controle *)

procedure TfrmPesquisandoSubGrupoBemNegociavel.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;
  
  if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros();
end;

procedure TfrmPesquisandoSubGrupoBemNegociavel.selecionarTodosRegistros();
begin
end;

procedure TfrmPesquisandoSubGrupoBemNegociavel.popularClientDataSetPesquisa(poDados: TClientDataSet);
begin
  cdsPesquisando.EmptyDataSet;
  poDados.First;
  while(not(poDados.Eof))do
  begin
    cdsPesquisando.Insert;
    cdsPesquisando.FieldByName('CODIGO').AsString := poDados.FieldByName('CODIGO').AsString;
    cdsPesquisando.FieldByName('NOME').AsString := poDados.FieldByName('NOME').AsString;
    cdsPesquisando.FieldByName('CC_CODIGO').AsString := poDados.FieldByName('CODIGO').AsString;
    cdsPesquisando.FieldByName('NOME_GRUPO').AsString := GetNomeGrupo(poDados.FieldByName('COD_FK_GRUPO').AsInteger);
    cdsPesquisando.Post;
    poDados.Next;
  end;
  cdsPesquisando.Active := True;
end;

function TfrmPesquisandoSubGrupoBemNegociavel.GetNomeGrupo(pnCodGrupo:Integer): String;
begin
  zQryGrupo.Close;
  zQryGrupo.SQL.Clear;
  zQryGrupo.SQL.Add('SELECT * FROM grupo_bem_negociavel WHERE codigo=:codigo');
  zQryGrupo.ParamByName('codigo').AsInteger := pnCodGrupo;
  zQryGrupo.Open;
  if(zQryGrupo.Active)and(zQryGrupo.RecordCount=1)then
    Result := zQryGrupoNOME.AsString
  else
    Result := STRING_INDEFINIDO;
end;

procedure TfrmPesquisandoSubGrupoBemNegociavel.OrdenarGrideRegistrosInciarTela;
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

procedure TfrmPesquisandoSubGrupoBemNegociavel.filtrarPesquisa();
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

procedure TfrmPesquisandoSubGrupoBemNegociavel.selecionouRegistro();
begin
  if(cdsPesquisando.Active)then
  begin
    if(Self.FoNomeFormChamou is TfrmCadSubGrupoBemNegociavel)then
    begin
      (Self.FoNomeFormChamou as TfrmCadSubGrupoBemNegociavel).passarParametro(PRM_PESQUISOU,null);
      (Self.FoNomeFormChamou as TfrmCadSubGrupoBemNegociavel).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
    end;
    Self.Hide;
  end;
end;

procedure TfrmPesquisandoSubGrupoBemNegociavel.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisa.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisa.plsCaracteresAceitos := numeros;
end;

procedure TfrmPesquisandoSubGrupoBemNegociavel.FormatarValores();
begin
end;

(* fim - procedimentos de controle *)

end.
