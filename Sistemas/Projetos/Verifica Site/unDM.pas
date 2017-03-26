unit unDM;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZConnection;

type
  TDM = class(TDataModule)
    ZConnection: TZConnection;
    zQryEnviaEmail: TZQuery;
    zQryEnviaEmailSite: TZQuery;
    zQrySite: TZQuery;
    zQryUsuario: TZQuery;
    zQryEnviaEmailCODIGO: TIntegerField;
    zQryEnviaEmailHOST: TStringField;
    zQryEnviaEmailPORTA: TIntegerField;
    zQryEnviaEmailEMAIL_PARA: TStringField;
    zQryEnviaEmailEMAIL_DE: TStringField;
    zQryEnviaEmailNOME_DE: TStringField;
    zQryEnviaEmailSENHA_DE: TStringField;
    zQrySiteCODIGO: TIntegerField;
    zQrySiteSITE: TStringField;
    zQrySiteDESCRICAO: TStringField;
    zQrySiteSTATUS: TIntegerField;
    zQrySiteDATA_ATIVACAO: TDateTimeField;
    dsEnviaEmail: TDataSource;
    dsEnviaEmailSite: TDataSource;
    dsSite: TDataSource;
    dsUsuario: TDataSource;
    zQryUsuarioCODIGO: TIntegerField;
    zQryUsuarioNOME: TStringField;
    zQryUsuarioLOGIN: TStringField;
    zQryUsuarioSENHA: TStringField;
    zQryAtualizaSite: TZQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    IntegerField2: TIntegerField;
    DateTimeField1: TDateTimeField;
    dsAtualizaSite: TDataSource;
    zQryEnviaEmailSiteCODIGO: TIntegerField;
    zQryEnviaEmailSiteCOD_SITE: TIntegerField;
    zQryEnviaEmailSiteCOD_ENVIA_EMAIL: TIntegerField;
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
