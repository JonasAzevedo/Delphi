unit unDM;

interface

uses
  SysUtils, Classes, ZConnection, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, DBClient, Provider;

type
  TDM = class(TDataModule)
    ZConnection: TZConnection;
    zQryCliente: TZQuery;
    zQryExiste: TZQuery;
    dspCliente: TDataSetProvider;
    cdsCliente: TClientDataSet;
    zQryClienteCODIGO: TIntegerField;
    zQryClienteDATA_CADASTRO: TDateTimeField;
    zQryClienteNOME: TStringField;
    zQryClienteCPF: TStringField;
    zQryClienteIDENTIDADE: TStringField;
    zQryClienteCNPJ: TStringField;
    zQryClienteDATA_NASCIMENTO: TDateField;
    zQryClientePROFISSAO: TStringField;
    zQryClienteEMAIL: TStringField;
    zQryClienteTELEFONE_1: TStringField;
    zQryClienteTELEFONE_2: TStringField;
    zQryClienteESTADO: TStringField;
    zQryClienteCIDADE: TStringField;
    zQryClienteBAIRRO: TStringField;
    zQryClienteRUA: TStringField;
    zQryClienteNUMERO: TIntegerField;
    zQryClienteCEP: TStringField;
    zQryClienteCOMPLEMENTO: TStringField;
    cdsClienteCODIGO: TIntegerField;
    cdsClienteDATA_CADASTRO: TDateTimeField;
    cdsClienteNOME: TStringField;
    cdsClienteCPF: TStringField;
    cdsClienteIDENTIDADE: TStringField;
    cdsClienteCNPJ: TStringField;
    cdsClienteDATA_NASCIMENTO: TDateField;
    cdsClientePROFISSAO: TStringField;
    cdsClienteEMAIL: TStringField;
    cdsClienteTELEFONE_1: TStringField;
    cdsClienteTELEFONE_2: TStringField;
    cdsClienteESTADO: TStringField;
    cdsClienteCIDADE: TStringField;
    cdsClienteBAIRRO: TStringField;
    cdsClienteRUA: TStringField;
    cdsClienteNUMERO: TIntegerField;
    cdsClienteCEP: TStringField;
    cdsClienteCOMPLEMENTO: TStringField;
    zQryPedido: TZQuery;
    dspPedido: TDataSetProvider;
    cdsPedido: TClientDataSet;
    zQryPedidoCODIGO: TIntegerField;
    zQryPedidoCOD_CLIENTE: TIntegerField;
    zQryPedidoCOD_ENDERECO_ENTREGA: TIntegerField;
    zQryPedidoDATA_CADASTRO: TDateTimeField;
    zQryPedidoDESCRICAO: TStringField;
    zQryPedidoVALOR_TOTAL: TFloatField;
    cdsPedidoCODIGO: TIntegerField;
    cdsPedidoCOD_CLIENTE: TIntegerField;
    cdsPedidoCOD_ENDERECO_ENTREGA: TIntegerField;
    cdsPedidoDATA_CADASTRO: TDateTimeField;
    cdsPedidoDESCRICAO: TStringField;
    cdsPedidoVALOR_TOTAL: TFloatField;
    zQryItemPedido: TZQuery;
    dspItemPedido: TDataSetProvider;
    cdsItemPedido: TClientDataSet;
    zQryItemPedidoCODIGO: TIntegerField;
    zQryItemPedidoCOD_PEDIDO: TIntegerField;
    zQryItemPedidoDATA_CADASTRO: TDateTimeField;
    zQryItemPedidoQUANTIDADE: TIntegerField;
    zQryItemPedidoUNIDADE: TStringField;
    zQryItemPedidoDESCRICAO: TStringField;
    zQryItemPedidoVALOR_UNITARIO: TFloatField;
    zQryItemPedidoVALOR_TOTAL: TFloatField;
    zQryItemPedidoCOMPLEMENTO: TStringField;
    cdsItemPedidoCODIGO: TIntegerField;
    cdsItemPedidoCOD_PEDIDO: TIntegerField;
    cdsItemPedidoDATA_CADASTRO: TDateTimeField;
    cdsItemPedidoQUANTIDADE: TIntegerField;
    cdsItemPedidoUNIDADE: TStringField;
    cdsItemPedidoDESCRICAO: TStringField;
    cdsItemPedidoVALOR_UNITARIO: TFloatField;
    cdsItemPedidoVALOR_TOTAL: TFloatField;
    cdsItemPedidoCOMPLEMENTO: TStringField;
    zQryEndereco: TZQuery;
    dspEndereco: TDataSetProvider;
    cdsEndereco: TClientDataSet;
    zQryEnderecoCODIGO: TIntegerField;
    zQryEnderecoDATA_CADASTRO: TDateTimeField;
    zQryEnderecoESTADO: TStringField;
    zQryEnderecoCIDADE: TStringField;
    zQryEnderecoBAIRRO: TStringField;
    zQryEnderecoRUA: TStringField;
    zQryEnderecoNUMERO: TIntegerField;
    zQryEnderecoCEP: TStringField;
    zQryEnderecoCOMPLEMENTO: TStringField;
    cdsEnderecoCODIGO: TIntegerField;
    cdsEnderecoDATA_CADASTRO: TDateTimeField;
    cdsEnderecoESTADO: TStringField;
    cdsEnderecoCIDADE: TStringField;
    cdsEnderecoBAIRRO: TStringField;
    cdsEnderecoRUA: TStringField;
    cdsEnderecoNUMERO: TIntegerField;
    cdsEnderecoCEP: TStringField;
    cdsEnderecoCOMPLEMENTO: TStringField;
    zQryDescricaoProdutos: TZQuery;
    dspDescricaoProdutos: TDataSetProvider;
    cdsDescricaoProdutos: TClientDataSet;
    zQryDescricaoProdutosCODIGO: TIntegerField;
    zQryDescricaoProdutosDATA_CADASTRO: TDateTimeField;
    zQryDescricaoProdutosNOME: TStringField;
    cdsDescricaoProdutosCODIGO: TIntegerField;
    cdsDescricaoProdutosDATA_CADASTRO: TDateTimeField;
    cdsDescricaoProdutosNOME: TStringField;
    zQryCarregarPedido: TZQuery;
    dspCarregarPedido: TDataSetProvider;
    cdsCarregarPedido: TClientDataSet;
    zQryCarregarPedidoCODIGO: TIntegerField;
    zQryCarregarPedidoDATA_CADASTRO: TDateTimeField;
    zQryCarregarPedidoCOD_CLIENTE: TIntegerField;
    zQryCarregarPedidoCOD_ENDERECO_ENTREGA: TIntegerField;
    zQryCarregarPedidoDESCRICAO: TStringField;
    zQryCarregarPedidoVALOR_TOTAL: TFloatField;
    zQryCarregarPedidoNOME: TStringField;
    zQryCarregarPedidoESTADO: TStringField;
    zQryCarregarPedidoCIDADE: TStringField;
    zQryCarregarPedidoBAIRRO: TStringField;
    zQryCarregarPedidoRUA: TStringField;
    zQryCarregarPedidoNUMERO: TIntegerField;
    zQryCarregarPedidoCEP: TStringField;
    zQryCarregarPedidoCOMPLEMENTO: TStringField;
    cdsCarregarPedidoCODIGO: TIntegerField;
    cdsCarregarPedidoDATA_CADASTRO: TDateTimeField;
    cdsCarregarPedidoCOD_CLIENTE: TIntegerField;
    cdsCarregarPedidoCOD_ENDERECO_ENTREGA: TIntegerField;
    cdsCarregarPedidoDESCRICAO: TStringField;
    cdsCarregarPedidoVALOR_TOTAL: TFloatField;
    cdsCarregarPedidoNOME: TStringField;
    cdsCarregarPedidoESTADO: TStringField;
    cdsCarregarPedidoCIDADE: TStringField;
    cdsCarregarPedidoBAIRRO: TStringField;
    cdsCarregarPedidoRUA: TStringField;
    cdsCarregarPedidoNUMERO: TIntegerField;
    cdsCarregarPedidoCEP: TStringField;
    cdsCarregarPedidoCOMPLEMENTO: TStringField;
    zQryCarregarItemPedido: TZQuery;
    dspCarregarItemPedido: TDataSetProvider;
    cdsCarregarItemPedido: TClientDataSet;
    zQryCarregarItemPedidoQUANTIDADE: TIntegerField;
    zQryCarregarItemPedidoUNIDADE: TStringField;
    zQryCarregarItemPedidoDESCRICAO: TStringField;
    zQryCarregarItemPedidoVALOR_UNITARIO: TFloatField;
    zQryCarregarItemPedidoVALOR_TOTAL: TFloatField;
    zQryCarregarItemPedidoCOMPLEMENTO: TStringField;
    zQryCarregarItemPedidoUNIDADECOMBO: TStringField;
    cdsCarregarItemPedidoQUANTIDADE: TIntegerField;
    cdsCarregarItemPedidoUNIDADE: TStringField;
    cdsCarregarItemPedidoDESCRICAO: TStringField;
    cdsCarregarItemPedidoVALOR_UNITARIO: TFloatField;
    cdsCarregarItemPedidoVALOR_TOTAL: TFloatField;
    cdsCarregarItemPedidoCOMPLEMENTO: TStringField;
    cdsCarregarItemPedidoUNIDADECOMBO: TStringField;
    zQryPedidoSTATUS: TIntegerField;
    cdsPedidoSTATUS: TIntegerField;
    zQryCarregarPedidoSTATUS: TIntegerField;
    cdsCarregarPedidoSTATUS: TIntegerField;
    zQryPedidoCONDICAO_PAGAMENTO: TIntegerField;
    cdsPedidoCONDICAO_PAGAMENTO: TIntegerField;
    zQryPagamentoPedido: TZQuery;
    dspPagamentoPedido: TDataSetProvider;
    cdsPagamentoPedido: TClientDataSet;
    zQryPagamentoPedidoCODIGO: TIntegerField;
    zQryPagamentoPedidoDATA_CADASTRO: TDateTimeField;
    zQryPagamentoPedidoCOD_PEDIDO: TIntegerField;
    zQryPagamentoPedidoVALOR_TOTAL: TFloatField;
    zQryPagamentoPedidoVALOR_PARCELA: TFloatField;
    zQryPagamentoPedidoDATA_VCTO: TDateField;
    zQryPagamentoPedidoDATA_PGTO: TDateField;
    zQryPagamentoPedidoDESCRICAO: TStringField;
    cdsPagamentoPedidoCODIGO: TIntegerField;
    cdsPagamentoPedidoDATA_CADASTRO: TDateTimeField;
    cdsPagamentoPedidoCOD_PEDIDO: TIntegerField;
    cdsPagamentoPedidoVALOR_TOTAL: TFloatField;
    cdsPagamentoPedidoVALOR_PARCELA: TFloatField;
    cdsPagamentoPedidoDATA_VCTO: TDateField;
    cdsPagamentoPedidoDATA_PGTO: TDateField;
    cdsPagamentoPedidoDESCRICAO: TStringField;
    zQryAux: TZQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

end.
