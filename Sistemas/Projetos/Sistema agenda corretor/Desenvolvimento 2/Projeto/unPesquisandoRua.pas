unit unPesquisandoRua;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, StdCtrls, plsEdit,
  ExtCtrls, Grids, DBGrids, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmPesquisandoRua = class(TfrmPesquisandoRegistro)
    cdsPesquisandoCODIGO: TStringField;
    cdsPesquisandoNOME: TStringField;
    cdsPesquisandoCEP: TStringField;
    cdsPesquisandoCC_CODIGO: TStringField;
    zQryCidade: TZQuery;
    zQryCidadeNOME_BAIRRO: TStringField;
    zQryCidadeNOME_CIDADE: TStringField;
    cdsPesquisandoNOME_BAIRRO: TStringField;
    cdsPesquisandoNOME_CIDADE: TStringField;
  private
    function GetNomeBairro(var psCidade:String; pnCodBairro:Integer): String;
  protected
    procedure popularClientDataSetPesquisa(poDados: TClientDataSet); override;
    procedure OrdenarGrideRegistrosInciarTela; override;
    procedure filtrarPesquisa(); override;
    procedure selecionouRegistro(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
    procedure FormatarValores(); override;
    procedure selecionarTodosRegistros();
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
  end;

var
  frmPesquisandoRua: TfrmPesquisandoRua;

implementation

uses unConstantes, unCadRua;


{$R *.dfm}

{ TfrmPesquisandoRua }

(* procedimentos de controle *)

procedure TfrmPesquisandoRua.passarParametro(pTipo:String; pValores:OleVariant);
begin
  inherited;
  
  if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros();
end;

procedure TfrmPesquisandoRua.selecionarTodosRegistros();
begin
end;

procedure TfrmPesquisandoRua.popularClientDataSetPesquisa(poDados: TClientDataSet);
var
  sCidade: String;
begin
  cdsPesquisando.EmptyDataSet;
  poDados.First;
  while(not(poDados.Eof))do
  begin
    cdsPesquisando.Insert;
    cdsPesquisando.FieldByName('CODIGO').AsString := poDados.FieldByName('CODIGO').AsString;
    cdsPesquisando.FieldByName('NOME').AsString := poDados.FieldByName('NOME').AsString;
    cdsPesquisando.FieldByName('CEP').AsString := poDados.FieldByName('CEP').AsString;
    cdsPesquisando.FieldByName('CC_CODIGO').AsString := poDados.FieldByName('CODIGO').AsString;
    cdsPesquisando.FieldByName('NOME_BAIRRO').AsString := GetNomeBairro(sCidade, poDados.FieldByName('COD_FK_BAIRRO').AsInteger);
    cdsPesquisando.FieldByName('NOME_CIDADE').AsString := sCidade;
    cdsPesquisando.Post;
    poDados.Next;
  end;
  cdsPesquisando.Active := True;
end;

function TfrmPesquisandoRua.GetNomeBairro(var psCidade:String; pnCodBairro:Integer): String;
begin
  zQryCidade.Close;
  zQryCidade.SQL.Clear;
  zQryCidade.SQL.Add('SELECT b.nome AS nome_bairro,c.nome AS nome_cidade ');
  zQryCidade.SQL.Add('FROM bairro b ');
  zQryCidade.SQL.Add('JOIN cidade c ON b.cod_fk_cidade=c.codigo ');
  zQryCidade.SQL.Add('WHERE b.codigo=:codigo');
  zQryCidade.ParamByName('codigo').AsInteger := pnCodBairro;
  zQryCidade.Open;
  if(zQryCidade.Active)and(zQryCidade.RecordCount=1)then
  begin
    psCidade := zQryCidadeNOME_CIDADE.AsString;
    Result := zQryCidadeNOME_BAIRRO.AsString;
  end
  else
  begin
    psCidade := STRING_INDEFINIDO;
    Result := STRING_INDEFINIDO;
  end;
end;

procedure TfrmPesquisandoRua.OrdenarGrideRegistrosInciarTela;
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

procedure TfrmPesquisandoRua.filtrarPesquisa();
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

  inherited;
end;

procedure TfrmPesquisandoRua.selecionouRegistro();
begin
  if(cdsPesquisando.Active)then
  begin
    if(Self.FoNomeFormChamou is TfrmCadRua)then
    begin
      (Self.FoNomeFormChamou as TfrmCadRua).passarParametro(PRM_PESQUISOU,null);
      (Self.FoNomeFormChamou as TfrmCadRua).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
    end;
    Self.Hide;
  end;
end;

procedure TfrmPesquisandoRua.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisa.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisa.plsCaracteresAceitos := numeros;
end;

procedure TfrmPesquisandoRua.FormatarValores();
begin
  if((cdsPesquisando.Active)and(cdsPesquisando.RecordCount>0))then
  begin
    cdsPesquisando.First;
    while(not(cdsPesquisando.Eof))do
    begin
      cdsPesquisando.Edit;

      if(FoFuncoes.verificaCEP_EhVazio(cdsPesquisandoCEP.AsString))then
        cdsPesquisandoCEP.AsString := STRING_INDEFINIDO;

      cdsPesquisando.Post;

      cdsPesquisando.Next;
    end;
  end;
end;

(* fim - procedimentos de controle *)

end.
