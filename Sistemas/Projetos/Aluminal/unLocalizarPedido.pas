unit unLocalizarPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unLocalizar, DB, DBClient, Provider, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ComCtrls, Grids, DBGrids, ExtCtrls, StdCtrls,
  plsEdit, plsComboBox;

type
  TfrmLocalizarPedido = class(TfrmLocalizar)
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosCOD_CLIENTE: TIntegerField;
    zQryDadosCOD_ENDERECO_ENTREGA: TIntegerField;
    zQryDadosDESCRICAO: TStringField;
    zQryDadosVALOR_TOTAL: TFloatField;
    zQryDadosCC_CODIGO: TStringField;
    zQryDadosNOME: TStringField;
    zQryDadosCIDADE: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosCOD_CLIENTE: TIntegerField;
    cdsDadosCOD_ENDERECO_ENTREGA: TIntegerField;
    cdsDadosDESCRICAO: TStringField;
    cdsDadosVALOR_TOTAL: TFloatField;
    cdsDadosCC_CODIGO: TStringField;
    cdsDadosNOME: TStringField;
    cdsDadosCIDADE: TStringField;
    zQryDadosSTATUS: TIntegerField;
    cdsDadosSTATUS: TIntegerField;
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

{ TfrmLocalizarPedido }

procedure TfrmLocalizarPedido.PassaParametro(const psParametro: string; const pvValor: OleVariant);
begin
  inherited;
end;

procedure TfrmLocalizarPedido.FecharTela;
begin
  Self.Hide;
end;

procedure TfrmLocalizarPedido.SelecionarTodosDados;
begin
  inherited;
  cdsDados.Close;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT p.*,  CAST(p.codigo AS VARCHAR(10)) AS cc_codigo, c.nome, e.cidade ');
  zQryDados.SQL.Add('FROM pedido p ');
  zQryDados.SQL.Add('JOIN cliente c ON p.cod_cliente = c.codigo ');
  zQryDados.SQL.Add('JOIN endereco e ON p.cod_endereco_entrega = e.codigo ');
  zQryDados.SQL.Add('ORDER BY p.data_cadastro DESC');
  zQryDados.Open;
  cdsDados.Open;

  CopiarDadosDataSetExibeDados;
  FoFuncoes.FormatarValorMonetarioEmBloco(cdsExibeDados, 'VALOR');    
end;

procedure TfrmLocalizarPedido.DefinirCampoPesquisar(psCampo: string);
begin
  if (GetCampoPesquisar = 'cc_codigo') then
    cbBxCampoLocalizar.ItemIndex := 0
  else if (GetCampoPesquisar = 'nome') then
    cbBxCampoLocalizar.ItemIndex := 1
  else if (GetCampoPesquisar = 'cidade') then
    cbBxCampoLocalizar.ItemIndex := 2
  else
    cbBxCampoLocalizar.ItemIndex := -1;
end;

procedure TfrmLocalizarPedido.LocalizarRegistroParte;
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

  if (FbLocalizarRegistroRapido) and (FoCdsRetornaSelecao.RecordCount = 1)then
  begin
    RetornarSelecao;
    Close;
  end
  else if(FoCdsRetornaSelecao.RecordCount = 0)then
  begin
    FbLocalizarRegistroRapido := False;
    DefinirTextoStatusBar(0, 'NENHUM PEDIDO ENCONTRADO');
    SelecionarTodosDados;
      FoFuncoes.focarComponente(edLocalizar);
  end
  else
  begin
    FbLocalizarRegistroRapido := False;
    DefinirTextoStatusBar(0, 'Pedidos: ' + IntToStr(FoCdsRetornaSelecao.RecordCount));
  end;
end;

procedure TfrmLocalizarPedido.EnviarOutrosParametrosRetornarSelecao;
begin
end;

procedure TfrmLocalizarPedido.configurarCaracteresAceitosPesquisa;
begin
  if (GetCampoPesquisar = 'cc_codigo') then
    edLocalizar.plsCaracteresAceitos := numeros
  else if (GetCampoPesquisar = 'nome') then
    edLocalizar.plsCaracteresAceitos := todos
  else if (GetCampoPesquisar = 'cidade') then
    edLocalizar.plsCaracteresAceitos := todos
  else
    edLocalizar.plsCaracteresAceitos := todos
end;

procedure TfrmLocalizarPedido.DefinirDataSetRetornaSelecao;
begin
  FoCdsRetornaSelecao := cdsExibeDados;
end;

procedure TfrmLocalizarPedido.CriarDataSetExibirDados;
begin
  if cdsExibeDados.Active then
     cdsExibeDados.EmptyDataSet;

  cdsExibeDados.FieldDefs.Add('CODIGO', ftInteger, 0, True);
  cdsExibeDados.FieldDefs.Add('CC_CODIGO', ftInteger, 0, True);
  cdsExibeDados.FieldDefs.Add('NOME', ftString, 100, False); //nome do cliente
  cdsExibeDados.FieldDefs.Add('CIDADE', ftString, 100, False);
  cdsExibeDados.FieldDefs.Add('VALOR', ftString, 20, False);
  cdsExibeDados.CreateDataSet;
end;

procedure TfrmLocalizarPedido.CopiarDadosDataSetExibeDados;
begin
  cdsDados.DisableControls;
  cdsExibeDados.DisableControls;
  try
    cdsDados.First;
    while not(cdsDados.Eof) do
    begin
      cdsExibeDados.Append;
      cdsExibeDados.FieldByName('CODIGO').AsInteger := cdsDados.FieldByName('CODIGO').AsInteger;
      cdsExibeDados.FieldByName('CC_CODIGO').AsInteger := cdsDados.FieldByName('CC_CODIGO').AsInteger;
      cdsExibeDados.FieldByName('NOME').AsString := cdsDados.FieldByName('NOME').AsString;
      cdsExibeDados.FieldByName('CIDADE').AsString := cdsDados.FieldByName('CIDADE').AsString;
      cdsExibeDados.FieldByName('VALOR').AsString := cdsDados.FieldByName('VALOR_TOTAL').AsString;
      cdsExibeDados.Post;
      cdsDados.Next;
    end;
  finally
    cdsDados.EnableControls;
    cdsExibeDados.EnableControls;
  end;
end;



procedure TfrmLocalizarPedido.DefinirTextoStatusBar(pnPanel: integer; psTexto: string);
begin
  StatusBar.Panels.Items[pnPanel].Text := psTexto;
end;

procedure TfrmLocalizarPedido.cbBxCampoLocalizarChange(Sender: TObject);
begin
  inherited;
  case cbBxCampoLocalizar.ItemIndex of
    0: SetCampoPesquisar('cc_codigo');
    1: SetCampoPesquisar('nome');
    2: SetCampoPesquisar('cidade');
    else SetCampoPesquisar(STRING_INDEFINIDO);
  end;
end;

procedure TfrmLocalizarPedido.FormCreate(Sender: TObject);
begin
  CriarDataSetExibirDados;
  inherited;
  DefinirTextoStatusBar(0, STRING_INDEFINIDO);
  FsTipoLocalizar := sLOCALIZAR_PEDIDO;
end;

end.
