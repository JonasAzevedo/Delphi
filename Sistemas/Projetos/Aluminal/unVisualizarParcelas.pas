unit unVisualizarParcelas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unFrmBasico, DBClient, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Provider, ExtCtrls, AdvPanel, unConstantes, Grids, BaseGrid,
  AdvGrid, DBAdvGrid;

type
  TfrmVisualizarParcelas = class(TFrmBasico)
    zQryPagamentoPedido: TZQuery;
    cdsPagamentoPedido: TClientDataSet;
    dspPagamentoPedido: TDataSetProvider;
    AdvPanel1: TAdvPanel;
    zQryPagamentoPedidoCODIGOPAGAMETOPEDIDO: TIntegerField;
    zQryPagamentoPedidoDATA_CADASTRO: TDateTimeField;
    zQryPagamentoPedidoVALORTOTALPAGAMETOPEDIDO: TFloatField;
    zQryPagamentoPedidoVALOR_PARCELA: TFloatField;
    zQryPagamentoPedidoDATA_VCTO: TDateField;
    zQryPagamentoPedidoDATA_PGTO: TDateField;
    zQryPagamentoPedidoDESCRICAOPAGAMENTOPEDIDO: TStringField;
    zQryPagamentoPedidoCODIGOPEDIDO: TIntegerField;
    zQryPagamentoPedidoDESCRICAOPEDIDO: TStringField;
    zQryPagamentoPedidoVALORTOTALPEDIDO: TFloatField;
    zQryPagamentoPedidoSTATUS: TIntegerField;
    zQryPagamentoPedidoCONDICAO_PAGAMENTO: TIntegerField;
    zQryPagamentoPedidoCODIGOCLIENTE: TIntegerField;
    zQryPagamentoPedidoNOMECLIENTE: TStringField;
    cdsPagamentoPedidoCODIGOPAGAMETOPEDIDO: TIntegerField;
    cdsPagamentoPedidoDATA_CADASTRO: TDateTimeField;
    cdsPagamentoPedidoVALORTOTALPAGAMETOPEDIDO: TFloatField;
    cdsPagamentoPedidoVALOR_PARCELA: TFloatField;
    cdsPagamentoPedidoDATA_VCTO: TDateField;
    cdsPagamentoPedidoDATA_PGTO: TDateField;
    DBAdvGrid1: TDBAdvGrid;
    dsPagamentoPedido: TDataSource;
    cdsPagamentoPedidoDESCRICAOPAGAMENTOPEDIDO: TStringField;
    cdsPagamentoPedidoCODIGOPEDIDO: TIntegerField;
    cdsPagamentoPedidoDESCRICAOPEDIDO: TStringField;
    cdsPagamentoPedidoVALORTOTALPEDIDO: TFloatField;
    cdsPagamentoPedidoSTATUS: TIntegerField;
    cdsPagamentoPedidoCONDICAO_PAGAMENTO: TIntegerField;
    cdsPagamentoPedidoCODIGOCLIENTE: TIntegerField;
    cdsPagamentoPedidoNOMECLIENTE: TStringField;
  private
    function RetornarProjecaoPagamentoPedido: String;
    procedure PesquisarParcelas(const psLstCodigos: string = STRING_INDEFINIDO);
  protected
    procedure HabilitarTela(pnStatus: Integer); override;
  public
    procedure PassaParametro(const psParametro: string; const pvValor: OleVariant); override;
  end;

implementation

uses unDM;

{$R *.dfm}

{ TfrmVisualizarParcelas }

procedure TfrmVisualizarParcelas.PassaParametro(const psParametro: string; const pvValor: OleVariant);
begin
  inherited;

  if (psParametro = sPRM_PESQUISAR_PARCELAS_PARAMETRO) and (not VarIsNull(pvValor)) then
    PesquisarParcelas(pvValor);
end;

function TfrmVisualizarParcelas.RetornarProjecaoPagamentoPedido: String;
begin
  Result := 'pp.codigo AS codigoPagametoPedido,pp.data_cadastro,' +
    'pp.valor_total AS valorTotalPagametoPedido,pp.valor_parcela,pp.data_vcto,' +
    'pp.data_pgto,pp.descricao AS descricaoPagamentoPedido,' +
    'ped.codigo AS codigoPedido,ped.descricao AS descricaoPedido,' +
    'ped.valor_total AS valorTotalPedido,ped.status,ped.condicao_pagamento,' +
    'c.codigo AS codigoCliente,c.nome AS nomeCliente ';
end;

procedure TfrmVisualizarParcelas.PesquisarParcelas(const psLstCodigos: string = STRING_INDEFINIDO);
begin
  cdsPagamentoPedido.Close;
  zQryPagamentoPedido.Close;
  zQryPagamentoPedido.SQL.Clear;
  zQryPagamentoPedido.SQL.Add('SELECT ');
  zQryPagamentoPedido.SQL.Add(RetornarProjecaoPagamentoPedido);
  zQryPagamentoPedido.SQL.Add('FROM pagamento_pedido pp ');
  zQryPagamentoPedido.SQL.Add('JOIN pedido ped ON pp.cod_pedido = ped.codigo ');
  zQryPagamentoPedido.SQL.Add('JOIN cliente c ON ped.cod_cliente = c.codigo ');
  zQryPagamentoPedido.SQL.Add('WHERE pp.data_pgto IS NULL ');
  if (psLstCodigos <> STRING_INDEFINIDO) then
    zQryPagamentoPedido.SQL.Add('AND pp.codigo IN (' + psLstCodigos + ')');
  zQryPagamentoPedido.SQL.Add('ORDER BY pp.data_vcto');
  zQryPagamentoPedido.Open;
  cdsPagamentoPedido.Open;
end;

procedure TfrmVisualizarParcelas.HabilitarTela(pnStatus: Integer);
begin
end;

end.
