unit unPesquisandoDica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, StdCtrls, plsEdit,
  ExtCtrls, Grids, DBGrids, Provider, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmPesquisandoDica = class(TfrmPesquisandoRegistro)
    zQryPesquisando: TZQuery;
    dspPesquisando: TDataSetProvider;
    zQryPesquisandoCODIGO: TIntegerField;
    zQryPesquisandoTELA: TStringField;
    zQryPesquisandoDICA: TStringField;
    zQryPesquisandoCC_CODIGO: TStringField;
    cdsPesquisandoCODIGO: TIntegerField;
    cdsPesquisandoTELA: TStringField;
    cdsPesquisandoDICA: TStringField;
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
  frmPesquisandoDica: TfrmPesquisandoDica;

implementation

uses unCadDicas, unConstantes;

{$R *.dfm}

{ TfrmPesquisandoDica }

(* procedimentos de controle *)

procedure TfrmPesquisandoDica.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;
  if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros();
end;

procedure TfrmPesquisandoDica.selecionarTodosRegistros();
begin
end;

procedure TfrmPesquisandoDica.popularClientDataSetPesquisa(poDados: TClientDataSet);
begin
  cdsPesquisando.EmptyDataSet;
  poDados.First;
  while(not(poDados.Eof))do
  begin
    cdsPesquisando.Insert;
    cdsPesquisando.FieldByName('CODIGO').AsString := poDados.FieldByName('CODIGO').AsString;
    cdsPesquisando.FieldByName('TELA').AsString := poDados.FieldByName('TELA').AsString;
    cdsPesquisando.FieldByName('DICA').AsString := poDados.FieldByName('DICA').AsString;
    cdsPesquisando.FieldByName('CC_CODIGO').AsString := poDados.FieldByName('CODIGO').AsString;
    cdsPesquisando.Post;
    poDados.Next;
  end;
  cdsPesquisando.Active := True;
end;


procedure TfrmPesquisandoDica.OrdenarGrideRegistrosInciarTela;
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

    else if(Self.FsCampoPesquisa = 'DICA')then
    begin
      sIndexName := 'DICA_ASC';
      options := [];
      AdicionarIndice('DICA');
    end

    else if(Self.FsCampoPesquisa = 'TELA')then
    begin
      sIndexName := 'TELA_ASC';
      options := [];
      AdicionarIndice('TELA');
    end;
end;

procedure TfrmPesquisandoDica.filtrarPesquisa();
begin
  if(Self.FsCampoPesquisa = 'TELA')or(Self.FsCampoPesquisa = 'DICA')or(Self.FsCampoPesquisa = 'CC_CODIGO') then
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

procedure TfrmPesquisandoDica.selecionouRegistro();
begin
  if(cdsPesquisando.Active)then
  begin
    if(Self.FoNomeFormChamou is TfrmCadDica)then
    begin
      (Self.FoNomeFormChamou as TfrmCadDica).passarParametro(PRM_PESQUISOU,null);
      (Self.FoNomeFormChamou as TfrmCadDica).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
    end;
    Self.Hide;
  end;
end;

procedure TfrmPesquisandoDica.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'TELA')or(Self.FsCampoPesquisa = 'DICA')then
    plsEdValorPesquisa.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisa.plsCaracteresAceitos := numeros;
end;

procedure TfrmPesquisandoDica.FormatarValores();
begin                        
end;

(* fim - procedimentos de controle *)

end.
