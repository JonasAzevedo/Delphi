unit unDM;

interface             

uses
  SysUtils, Classes, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZConnection, Provider, DBClient;

type
  TDM = class(TDataModule)
    ZConnection: TZConnection;
    zQryEmail: TZQuery;
    zQryEmailCODIGO: TIntegerField;
    zQryEmailEMAIL: TStringField;
    zQryEmailSERVIDOR_DO_EMAIL: TStringField;
    zQryEmailDOMINIO_1: TStringField;
    zQryEmailDOMINIO_2: TStringField;
    zQryEmailNOME_PROPRIETARIO: TStringField;
    zQryEmailCIDADE_PROPRIETARIO: TStringField;
    zQryEmailESTADO_PROPRIETARIO: TStringField;
    zQryEmailPAIS_PROPRIETARIO: TStringField;
    zQryEmailMEIO_CAPTACAO: TStringField;
    zQryEmailRELEVANCIA: TIntegerField;
    zQryAreasInteresse: TZQuery;
    zQryAreasInteresseCODIGO: TIntegerField;
    zQryAreasInteresseNOME: TStringField;
    zQryAssociaEmailAreasInteresse: TZQuery;
    zQryAssociaEmailAreasInteresseCODIGO: TIntegerField;
    zQryAssociaEmailAreasInteresseCODIGO_FK_EMAIL: TIntegerField;
    zQryAssociaEmailAreasInteresseCODIGO_FK_AREAS_INTERESSE: TIntegerField;
    zQryEmailDATA_INSERCAO: TDateTimeField;
    zQryEmailRejeitado: TZQuery;
    zQryEmailRejeitadoCODIGO: TIntegerField;
    zQryEmailRejeitadoEMAIL: TStringField;
    zQryEmailRejeitadoSERVIDOR_DO_EMAIL: TStringField;
    zQryEmailRejeitadoDOMINIO_1: TStringField;
    zQryEmailRejeitadoDOMINIO_2: TStringField;
    zQryEmailRejeitadoNOME_PROPRIETARIO: TStringField;
    zQryEmailRejeitadoCIDADE_PROPRIETARIO: TStringField;
    zQryEmailRejeitadoESTADO_PROPRIETARIO: TStringField;
    zQryEmailRejeitadoPAIS_PROPRIETARIO: TStringField;
    zQryEmailRejeitadoMEIO_CAPTACAO: TStringField;
    zQryEmailRejeitadoRELEVANCIA: TIntegerField;
    zQryEmailRejeitadoDATA_INSERCAO: TDateTimeField;
    zQryConfiguracoes: TZQuery;
    zQryConfiguracoesCODIGO: TIntegerField;
    zQryConfiguracoesPATH_BD: TStringField;
    zQryConfiguracoesUSUARIO_BD: TStringField;
    zQryConfiguracoesSENHA_BD: TStringField;
    zQryMelhoriasSistema: TZQuery;
    zQryMelhoriasSistemaCODIGO: TIntegerField;
    zQryMelhoriasSistemaDATA_CADASTRO: TDateTimeField;
    zQryMelhoriasSistemaDESCRICAO: TStringField;
    zQryMelhoriasSistemaREPLICA: TStringField;
    zQryMelhoriasSistemaRELEVANCIA: TIntegerField;
    zQryMelhoriasSistemaSITUACAO: TIntegerField;
    zQryMelhoriasSistemaDATA_FINALIZADA: TDateTimeField;
    zQryMelhoriasSistemaINCLUIDO_VERSAO: TStringField;
    zQryServidor: TZQuery;
    zQryServidorCODIGO: TIntegerField;
    zQryServidorNOME: TStringField;
    zQryDominio1: TZQuery;
    zQryDominio1CODIGO: TIntegerField;
    zQryDominio1NOME: TStringField;
    zQryDominio2: TZQuery;
    zQryDominio2CODIGO: TIntegerField;
    zQryDominio2NOME: TStringField;
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
