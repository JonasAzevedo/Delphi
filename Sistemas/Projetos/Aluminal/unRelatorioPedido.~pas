unit unRelatorioPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unRelatorio, RLReport, DB, DBClient, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Provider, jpeg, RLSaveDialog, RLPrintDialog,
  RLPreviewForm, RLFilters, RLPDFFilter;

type
  TfrmRelatorioPedido = class(TfrmRelatorio)
    RLBand2: TRLBand;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    cdsItensPedido: TClientDataSet;
    dsItensPedido: TDataSource;
    dspItensPedido: TDataSetProvider;
    zQryItensPedido: TZQuery;
    zQryItensPedidoCODIGO: TIntegerField;
    zQryItensPedidoDATA_CADASTRO: TDateTimeField;
    zQryItensPedidoCOD_PEDIDO: TIntegerField;
    zQryItensPedidoQUANTIDADE: TIntegerField;
    zQryItensPedidoUNIDADE: TStringField;
    zQryItensPedidoDESCRICAO: TStringField;
    zQryItensPedidoVALOR_UNITARIO: TFloatField;
    zQryItensPedidoVALOR_TOTAL: TFloatField;
    zQryItensPedidoCOMPLEMENTO: TStringField;
    cdsItensPedidoCODIGO: TIntegerField;
    cdsItensPedidoDATA_CADASTRO: TDateTimeField;
    cdsItensPedidoCOD_PEDIDO: TIntegerField;
    cdsItensPedidoQUANTIDADE: TIntegerField;
    cdsItensPedidoUNIDADE: TStringField;
    cdsItensPedidoDESCRICAO: TStringField;
    cdsItensPedidoVALOR_UNITARIO: TFloatField;
    cdsItensPedidoVALOR_TOTAL: TFloatField;
    cdsItensPedidoCOMPLEMENTO: TStringField;
    RLBand1: TRLBand;
    RLPanel1: TRLPanel;
    RLLabel25: TRLLabel;
    RLLabel27: TRLLabel;
    lblNumeroPedido: TRLLabel;
    RLLabel31: TRLLabel;
    lblDataPedido: TRLLabel;
    cdsPedido: TClientDataSet;
    dsPedido: TDataSource;
    dspPedido: TDataSetProvider;
    zQryPedido: TZQuery;
    zQryPedidoCODIGO: TIntegerField;
    zQryPedidoDATA: TDateField;
    zQryPedidoDESCRICAO: TStringField;
    zQryPedidoVALOR_TOTAL: TFloatField;
    zQryPedidoNOME: TStringField;
    zQryPedidoTELEFONE: TStringField;
    zQryPedidoESTADO: TStringField;
    zQryPedidoCIDADE: TStringField;
    zQryPedidoBAIRRO: TStringField;
    zQryPedidoRUA: TStringField;
    zQryPedidoNUMERO: TIntegerField;
    zQryPedidoCEP: TStringField;
    zQryPedidoCOMPLEMENTO: TStringField;
    cdsPedidoCODIGO: TIntegerField;
    cdsPedidoDATA: TDateField;
    cdsPedidoDESCRICAO: TStringField;
    cdsPedidoVALOR_TOTAL: TFloatField;
    cdsPedidoNOME: TStringField;
    cdsPedidoTELEFONE: TStringField;
    cdsPedidoESTADO: TStringField;
    cdsPedidoCIDADE: TStringField;
    cdsPedidoBAIRRO: TStringField;
    cdsPedidoRUA: TStringField;
    cdsPedidoNUMERO: TIntegerField;
    cdsPedidoCEP: TStringField;
    cdsPedidoCOMPLEMENTO: TStringField;
    RLLabel18: TRLLabel;
    lblNomeCliente: TRLLabel;
    lblTelefoneCliente: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel21: TRLLabel;
    lblCidadeCliente: TRLLabel;
    RLLabel24: TRLLabel;
    lblBairroCliente: TRLLabel;
    RLLabel23: TRLLabel;
    lblRuaCliente: TRLLabel;
    RLLabel28: TRLLabel;
    mmComplementoCliente: TRLMemo;
    lblCEPCliente: TRLLabel;
    RLLabel29: TRLLabel;
    lblNumeroCliente: TRLLabel;
    RLLabel26: TRLLabel;
    lblEstadoCliente: TRLLabel;
    RLLabel22: TRLLabel;
    RLBand4: TRLBand;
    lblAssinaturaCliente: TRLLabel;
    RLLabel30: TRLLabel;
    lblValorTotal: TRLLabel;
    RLLabel34: TRLLabel;
    RLDraw4: TRLDraw;
    RLDraw5: TRLDraw;
    RLPDFFilter: TRLPDFFilter;
    RLPreviewSetup: TRLPreviewSetup;
    procedure FormCreate(Sender: TObject);
  private
    FnCodPedido: Integer;

    procedure CarregarDadosPedidoRelatorio;
  public
    procedure PassaParametro(const psParametro: string; const pvValor: OleVariant); override;
    function ExistemItensPedido: Boolean;
  end;

implementation

uses unDM, unConstantes;

{$R *.dfm}

{ TfrmRelatorioPedido }

procedure TfrmRelatorioPedido.PassaParametro(const psParametro: string; const pvValor: OleVariant);
begin
  inherited;

  if (psParametro = sPRM_CODIGO_PEDIDO) then
    FnCodPedido := pvValor

  else if (psParametro = sPRM_BUSCAR_PEDIDO) then
  begin
    cdsPedido.Close;
    zQryPedido.Close;
    zQryPedido.SQL.Clear;
    zQryPedido.SQL.Add('SELECT p.codigo, CAST (p.data_cadastro AS DATE) AS data, p.descricao, p.valor_total, ');
    zQryPedido.SQL.Add('c.nome, c.telefone_1 || ''  '' || c.telefone_2 AS telefone, ');
    zQryPedido.SQL.Add('e.estado, e.cidade, e.bairro, e.rua, e.numero, e.cep, e.complemento ');
    zQryPedido.SQL.Add('FROM pedido p ');
    zQryPedido.SQL.Add('JOIN cliente c ON p.cod_cliente = c.codigo ');
    zQryPedido.SQL.Add('JOIN endereco e ON p.cod_endereco_entrega = e.codigo ');
    zQryPedido.SQL.Add('WHERE p.codigo = :codigo');
    zQryPedido.ParamByName('codigo').AsInteger := FnCodPedido;
    zQryPedido.Open;
    cdsPedido.Open;

    CarregarDadosPedidoRelatorio;
  end

  else if (psParametro = sPRM_BUSCAR_ITENS_PEDIDO) then
  begin
    cdsItensPedido.Close;
    zQryItensPedido.Close;
    zQryItensPedido.SQL.Clear;
    zQryItensPedido.SQL.Add('SELECT * FROM item_pedido WHERE cod_pedido = :cod_pedido');
    zQryItensPedido.ParamByName('cod_pedido').AsInteger := FnCodPedido;
    zQryItensPedido.Open;
    cdsItensPedido.Open;
  end;
end;

procedure TfrmRelatorioPedido.CarregarDadosPedidoRelatorio;
begin
  //limpando os dados do pedido.
  lblNumeroPedido.Caption := STRING_INDEFINIDO;
  lblDataPedido.Caption := STRING_INDEFINIDO;
  lblNomeCliente.Caption := STRING_INDEFINIDO;
  lblTelefoneCliente.Caption := STRING_INDEFINIDO;
  lblCidadeCliente.Caption := STRING_INDEFINIDO;
  lblEstadoCliente.Caption := STRING_INDEFINIDO;
  lblBairroCliente.Caption := STRING_INDEFINIDO;
  lblRuaCliente.Caption := STRING_INDEFINIDO;
  lblNumeroCliente.Caption := STRING_INDEFINIDO;
  lblCEPCliente.Caption := STRING_INDEFINIDO;
  mmComplementoCliente.Lines.Text := STRING_INDEFINIDO;
  lblValorTotal.Caption := STRING_INDEFINIDO;
  lblAssinaturaCliente.Caption := STRING_INDEFINIDO;

  //carrega os dados do pedido.
  if (cdsPedido.RecordCount = 1) then
  begin
    lblNumeroPedido.Caption := cdsPedido.FieldByName('codigo').AsString;
    lblDataPedido.Caption := cdsPedido.FieldByName('data').AsString;
    lblNomeCliente.Caption := cdsPedido.FieldByName('nome').AsString;
    lblTelefoneCliente.Caption := cdsPedido.FieldByName('telefone').AsString;
    lblCidadeCliente.Caption := cdsPedido.FieldByName('cidade').AsString;
    lblEstadoCliente.Caption := cdsPedido.FieldByName('estado').AsString;
    lblBairroCliente.Caption := cdsPedido.FieldByName('bairro').AsString;
    lblRuaCliente.Caption := cdsPedido.FieldByName('rua').AsString;
    lblNumeroCliente.Caption := cdsPedido.FieldByName('numero').AsString;
    lblCEPCliente.Caption := cdsPedido.FieldByName('cep').AsString;
    mmComplementoCliente.Lines.Text := cdsPedido.FieldByName('complemento').AsString;
    lblValorTotal.Caption := FoFuncoes.formatarValorMonetario(cdsPedido.FieldByName('valor_total').AsString);
    lblAssinaturaCliente.Caption := cdsPedido.FieldByName('nome').AsString;
  end;
end;

function TfrmRelatorioPedido.ExistemItensPedido: Boolean;
begin
  Result := (cdsItensPedido.Active) and (not(cdsItensPedido.IsEmpty));
end;

procedure TfrmRelatorioPedido.FormCreate(Sender: TObject);
begin
  inherited;
  FnCodPedido := NUMERO_INDEFINIDO;
end;

end.
