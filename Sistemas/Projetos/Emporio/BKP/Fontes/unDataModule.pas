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
