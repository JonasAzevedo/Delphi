unit unDataModule;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, FMTBcd, DBClient, Provider;

type
  TDM = class(TDataModule)
    SQLConnection: TSQLConnection;
    qryCliente: TSQLQuery;
    qryFornecedor: TSQLQuery;
    qryClienteCODIGO: TIntegerField;
    qryClienteNOME: TStringField;
    qryClienteENDERECO: TStringField;
    qryClienteBAIRRO: TStringField;
    qryClienteCIDADE: TStringField;
    qryClienteUF: TStringField;
    qryClienteCEP: TStringField;
    qryClienteTELEFONE: TStringField;
    qryClienteCELULAR: TStringField;
    qryClienteCPF: TStringField;
    qryClienteIDENTIDADE: TStringField;
    qryClienteDATA_NASCIMENTO: TDateField;
    qryClienteSEXO: TStringField;
    qryClienteESTADO_CIVIL: TStringField;
    qryClienteNATURALIDADE: TStringField;
    qryClienteDATA_FICHA: TSQLTimeStampField;
    qryFornecedorCODIGO: TIntegerField;
    qryFornecedorRAZAO_SOCIAL: TStringField;
    qryFornecedorNOME_FANTASIA: TStringField;
    qryFornecedorENDERECO: TStringField;
    qryFornecedorBAIRRO: TStringField;
    qryFornecedorCIDADE: TStringField;
    qryFornecedorUF: TStringField;
    qryFornecedorCEP: TStringField;
    qryFornecedorE_MAIL: TStringField;
    qryFornecedorHOME_PAGE: TStringField;
    qryFornecedorTELEFONE: TStringField;
    qryFornecedorCELULAR: TStringField;
    qryFornecedorCNPJ: TStringField;
    qryFornecedorINSCRICAO_ESTADUAL: TStringField;
    qryFornecedorREPRESENTANTE: TStringField;
    qryFornecedorDATA_FICHA: TSQLTimeStampField;
    dspCliente: TDataSetProvider;
    dspFornecedor: TDataSetProvider;
    cdsCliente: TClientDataSet;
    cdsFornecedor: TClientDataSet;
    dsCliente: TDataSource;
    dsFornecedor: TDataSource;
    cdsClienteCODIGO: TIntegerField;
    cdsClienteNOME: TStringField;
    cdsClienteENDERECO: TStringField;
    cdsClienteBAIRRO: TStringField;
    cdsClienteCIDADE: TStringField;
    cdsClienteUF: TStringField;
    cdsClienteCEP: TStringField;
    cdsClienteTELEFONE: TStringField;
    cdsClienteCELULAR: TStringField;
    cdsClienteCPF: TStringField;
    cdsClienteIDENTIDADE: TStringField;
    cdsClienteDATA_NASCIMENTO: TDateField;
    cdsClienteSEXO: TStringField;
    cdsClienteESTADO_CIVIL: TStringField;
    cdsClienteNATURALIDADE: TStringField;
    cdsClienteDATA_FICHA: TSQLTimeStampField;
    cdsFornecedorCODIGO: TIntegerField;
    cdsFornecedorRAZAO_SOCIAL: TStringField;
    cdsFornecedorNOME_FANTASIA: TStringField;
    cdsFornecedorENDERECO: TStringField;
    cdsFornecedorBAIRRO: TStringField;
    cdsFornecedorCIDADE: TStringField;
    cdsFornecedorUF: TStringField;
    cdsFornecedorCEP: TStringField;
    cdsFornecedorE_MAIL: TStringField;
    cdsFornecedorHOME_PAGE: TStringField;
    cdsFornecedorTELEFONE: TStringField;
    cdsFornecedorCELULAR: TStringField;
    cdsFornecedorCNPJ: TStringField;
    cdsFornecedorINSCRICAO_ESTADUAL: TStringField;
    cdsFornecedorREPRESENTANTE: TStringField;
    cdsFornecedorDATA_FICHA: TSQLTimeStampField;
    qryProduto: TSQLQuery;
    qryProdutoCODIGO: TIntegerField;
    qryProdutoNOME: TStringField;
    qryProdutoDESCRICAO: TStringField;
    qryProdutoVALOR_PAGO: TFMTBCDField;
    qryProdutoVALOR_VENDA: TFMTBCDField;
    dspProduto: TDataSetProvider;
    cdsProduto: TClientDataSet;
    cdsProdutoCODIGO: TIntegerField;
    cdsProdutoNOME: TStringField;
    cdsProdutoDESCRICAO: TStringField;
    cdsProdutoVALOR_PAGO: TFMTBCDField;
    cdsProdutoVALOR_VENDA: TFMTBCDField;
    dsProduto: TDataSource;
    qryProdutoESTOQUE: TFMTBCDField;
    cdsProdutoESTOQUE: TFMTBCDField;
    qryCompra: TSQLQuery;
    qryCompraCODIGO: TIntegerField;
    qryCompraCOD_PRODUTO: TIntegerField;
    qryCompraCOD_FORNECEDOR: TIntegerField;
    qryCompraDATA: TDateField;
    qryCompraQUANTIDADE: TFMTBCDField;
    qryCompraPAGO: TIntegerField;
    qryCompraVALOR_UNITARIO: TFMTBCDField;
    qryCompraVALOR_TOTAL: TFMTBCDField;
    qryCompraESTOQUE: TFMTBCDField;
    dspCompra: TDataSetProvider;
    cdsCompra: TClientDataSet;
    cdsCompraCODIGO: TIntegerField;
    cdsCompraCOD_PRODUTO: TIntegerField;
    cdsCompraCOD_FORNECEDOR: TIntegerField;
    cdsCompraDATA: TDateField;
    cdsCompraQUANTIDADE: TFMTBCDField;
    cdsCompraPAGO: TIntegerField;
    cdsCompraVALOR_UNITARIO: TFMTBCDField;
    cdsCompraVALOR_TOTAL: TFMTBCDField;
    cdsCompraESTOQUE: TFMTBCDField;
    dsCompra: TDataSource;
    qryCompraVALOR_PAGO: TFMTBCDField;
    cdsCompraVALOR_PAGO: TFMTBCDField;
    qryVenda: TSQLQuery;
    dspVenda: TDataSetProvider;
    cdsVenda: TClientDataSet;
    dsVenda: TDataSource;
    cdsItemVenda: TClientDataSet;
    dsItemVenda: TDataSource;
    dspItemVenda: TDataSetProvider;
    qryItemVenda: TSQLQuery;
    qryItemVendaCODIGO: TIntegerField;
    qryItemVendaCOD_VENDA: TIntegerField;
    qryItemVendaCOD_PRODUTO: TIntegerField;
    qryItemVendaQUANTIDADE: TFMTBCDField;
    qryItemVendaVALOR: TFMTBCDField;
    cdsItemVendaCODIGO: TIntegerField;
    cdsItemVendaCOD_VENDA: TIntegerField;
    cdsItemVendaCOD_PRODUTO: TIntegerField;
    cdsItemVendaQUANTIDADE: TFMTBCDField;
    cdsItemVendaVALOR: TFMTBCDField;
    qryVendaCODIGO: TIntegerField;
    qryVendaCOD_CLIENTE: TIntegerField;
    qryVendaDATA: TDateField;
    qryVendaPAGO: TIntegerField;
    qryVendaVALOR_TOTAL: TFMTBCDField;
    qryVendaVALOR_PAGO: TFMTBCDField;
    cdsVendaCODIGO: TIntegerField;
    cdsVendaCOD_CLIENTE: TIntegerField;
    cdsVendaDATA: TDateField;
    cdsVendaPAGO: TIntegerField;
    cdsVendaVALOR_TOTAL: TFMTBCDField;
    cdsVendaVALOR_PAGO: TFMTBCDField;
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
