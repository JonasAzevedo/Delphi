unit unLocalizarDescricaoProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unLocalizar, DB, DBClient, Provider, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ComCtrls, Grids, DBGrids, ExtCtrls, StdCtrls,
  plsEdit, plsComboBox;

type
  TfrmLocalizarDescricaoProdutos = class(TfrmLocalizar)
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosNOME: TStringField;
    zQryDadosVALOR: TFloatField;
    zQryDadosCC_CODIGO: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosNOME: TStringField;
    cdsDadosVALOR: TFloatField;
    cdsDadosCC_CODIGO: TStringField;
    cdsExibeDados: TClientDataSet;
    procedure cbBxCampoLocalizarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure FecharTela; override;
    procedure SelecionarTodosDados; override;
    procedure DefinirCampoPesquisar(psCampo: string); override;
    procedure LocalizarRegistroParte; override;
    procedure DefinirTextoStatusBar(pnPanel: integer; psTexto: string); override;
    procedure EnviarOutrosParametrosRetornarSelecao; override;
    procedure configurarCaracteresAceitosPesquisa; override;
    procedure DefinirDataSetRetornaSelecao; override;
    procedure CriarDataSetExibirDados;
    procedure CopiarDadosDataSetExibeDados;
  public
    procedure PassaParametro(const psParametro: string; const pvValor: OleVariant); override;
  end;

implementation

uses unDM, unConstantes;

{$R *.dfm}

{ TfrmLocalizarDescricaoProdutos }

procedure TfrmLocalizarDescricaoProdutos.PassaParametro(const psParametro: string; const pvValor: OleVariant);
begin
  inherited;
end;

procedure TfrmLocalizarDescricaoProdutos.FecharTela;
begin
  Self.Hide;
end;

procedure TfrmLocalizarDescricaoProdutos.SelecionarTodosDados;
begin
  inherited;
  cdsDados.Close;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT d.*, CAST(d.codigo AS VARCHAR(10)) AS cc_codigo ');
  zQryDados.SQL.Add('FROM descricao_produtos d ');
  zQryDados.SQL.Add('ORDER BY d.nome');
  zQryDados.Open;
  cdsDados.Open;

  CopiarDadosDataSetExibeDados;

  FoFuncoes.FormatarValorMonetarioEmBloco(cdsExibeDados, 'VALOR');
end;

procedure TfrmLocalizarDescricaoProdutos.DefinirCampoPesquisar(psCampo: string);
begin
  if (GetCampoPesquisar = 'cc_codigo') then
    cbBxCampoLocalizar.ItemIndex := 0
  else if (GetCampoPesquisar = 'nome') then
    cbBxCampoLocalizar.ItemIndex := 1
  else
    cbBxCampoLocalizar.ItemIndex := -1;
end;

procedure TfrmLocalizarDescricaoProdutos.LocalizarRegistroParte;
begin
  inherited;
  if GetCampoPesquisar = STRING_INDEFINIDO then
  begin
    FoCdsRetornaSelecao.Filter := STRING_INDEFINIDO;
    FoCdsRetornaSelecao.Filtered := False;
    Exit;
  end;

  FoCdsRetornaSelecao.Filter := GetCampoPesquisar + ' LIKE ' + QuotedStr('%' + edLocalizar.Text + '%');
  FoCdsRetornaSelecao.Filtered := True;

  //localiza o registro de forma rápida, podendo retornar o resultado sem precisar abrir esta tela.
  if (FbLocalizarRegistroRapido) then
  begin
    if(FoCdsRetornaSelecao.RecordCount = 1)then
    begin
      RetornarSelecao;
      Close;
    end
    else if(FoCdsRetornaSelecao.RecordCount = 0)then
      Close
    else
    begin
      FbLocalizarRegistroRapido := False;
      DefinirTextoStatusBar(0, 'Descrições: ' + IntToStr(FoCdsRetornaSelecao.RecordCount));
    end;
  end
  else
  begin
    if(FoCdsRetornaSelecao.RecordCount = 0)then
    begin
      DefinirTextoStatusBar(0, 'NENHUMA DESCRIÇÃO ENCONTRADA');
      //SelecionarTodosDados;
      FoFuncoes.focarComponente(edLocalizar);
    end
    else
      DefinirTextoStatusBar(0, 'Descrições: ' + IntToStr(FoCdsRetornaSelecao.RecordCount));
  end;
end;

procedure TfrmLocalizarDescricaoProdutos.EnviarOutrosParametrosRetornarSelecao;
begin
end;

procedure TfrmLocalizarDescricaoProdutos.configurarCaracteresAceitosPesquisa;
begin
  if (GetCampoPesquisar = 'cc_codigo') then
    edLocalizar.plsCaracteresAceitos := numeros
  else if (GetCampoPesquisar = 'nome') then
    edLocalizar.plsCaracteresAceitos := todos
  else
    edLocalizar.plsCaracteresAceitos := todos
end;

procedure TfrmLocalizarDescricaoProdutos.DefinirDataSetRetornaSelecao;
begin
  FoCdsRetornaSelecao := cdsExibeDados;
end;

procedure TfrmLocalizarDescricaoProdutos.CriarDataSetExibirDados;
begin
  if cdsExibeDados.Active then
     cdsExibeDados.EmptyDataSet;

  cdsExibeDados.FieldDefs.Add('CODIGO', ftInteger, 0, True);
  cdsExibeDados.FieldDefs.Add('DATA_CADASTRO', ftString, 20, False);
  cdsExibeDados.FieldDefs.Add('NOME', ftString, 200, False);
  cdsExibeDados.FieldDefs.Add('VALOR', ftString, 20, False);
  cdsExibeDados.FieldDefs.Add('CC_CODIGO', ftInteger, 0, True);
  cdsExibeDados.CreateDataSet;
end;

procedure TfrmLocalizarDescricaoProdutos.CopiarDadosDataSetExibeDados;
begin
  cdsDados.DisableControls;
  cdsExibeDados.DisableControls;
  try
    cdsDados.First;
    while not(cdsDados.Eof) do
    begin
      cdsExibeDados.Append;
      cdsExibeDados.FieldByName('CODIGO').AsInteger := cdsDados.FieldByName('CODIGO').AsInteger;
      cdsExibeDados.FieldByName('DATA_CADASTRO').AsString := cdsDados.FieldByName('DATA_CADASTRO').AsString;
      cdsExibeDados.FieldByName('NOME').AsString := cdsDados.FieldByName('NOME').AsString;
      cdsExibeDados.FieldByName('VALOR').AsString := cdsDados.FieldByName('VALOR').AsString;
      cdsExibeDados.FieldByName('CC_CODIGO').AsInteger := cdsDados.FieldByName('CC_CODIGO').AsInteger;
      cdsExibeDados.Post;
      cdsDados.Next;
    end;
  finally
    cdsDados.EnableControls;
    cdsExibeDados.EnableControls;
  end;
end;

procedure TfrmLocalizarDescricaoProdutos.DefinirTextoStatusBar(pnPanel: integer; psTexto: string);
begin
  StatusBar.Panels.Items[pnPanel].Text := psTexto;
end;

procedure TfrmLocalizarDescricaoProdutos.cbBxCampoLocalizarChange(
  Sender: TObject);
begin
  inherited;
  case cbBxCampoLocalizar.ItemIndex of
    0: SetCampoPesquisar('cc_codigo');
    1: SetCampoPesquisar('nome');
    else SetCampoPesquisar(STRING_INDEFINIDO);
  end;
end;

procedure TfrmLocalizarDescricaoProdutos.FormCreate(Sender: TObject);
begin
  CriarDataSetExibirDados;
  inherited;
  DefinirTextoStatusBar(0, STRING_INDEFINIDO);
  FsTipoLocalizar := sLOCALIZAR_DESCRICAO_PRODUTOS;
end;

end.
