{ *************************************************************************** }
{                                                                             }
{ Kylix and Delphi Cross-Platform Visual Component Library                    }
{                                                                             }
{ Copyright (c) 1997, 2001 Borland Software Corporation                       }
{                                                                             }
{ *************************************************************************** }


unit SqlConst;

interface

const

  DRIVERS_KEY = 'Drivers Instalados';           { Do not localize }
  CONNECTIONS_KEY = 'Conex�es Instaladas';      { Do not localize }
  DRIVERNAME_KEY = 'DriverName';                { Do not localize }
  HOSTNAME_KEY = 'HostName';                    { Do not localize }
  ROLENAME_KEY = 'RoleName';                    { Do not localize }
  DATABASENAME_KEY = 'Database';                { Do not localize }
  MAXBLOBSIZE_KEY = 'BlobSize';                 { Do not localize }
  VENDORLIB_KEY = 'VendorLib';                  { Do not localize }
  DLLLIB_KEY = 'LibraryName';                   { Do not localize }
  GETDRIVERFUNC_KEY = 'GetDriverFunc';          { Do not localize }
  AUTOCOMMIT_KEY = 'AutoCommit';                { Do not localize }
  BLOCKINGMODE_KEY = 'BlockingMode';            { Do not localize }
  WAITONLOCKS_KEY= 'WaitOnLocks';               { Do not localize }
  COMMITRETAIN_KEY = 'CommitRetain';            { Do not localize }
  TRANSISOLATION_KEY = '%s TransIsolation';     { Do not localize }
  SQLDIALECT_KEY = 'SqlDialect';                { Do not localize }
  SQLLOCALE_CODE_KEY = 'LocaleCode';            { Do not localize }
  ERROR_RESOURCE_KEY = 'ErrorResourceFile';     { Do not localize }
  SQLSERVER_CHARSET_KEY = 'ServerCharSet';      { Do not localize }
  SREADCOMMITTED = 'readcommited';              { Do not localize }
  SREPEATREAD = 'repeatableread';               { Do not localize }
  SDIRTYREAD = 'dirtyread';                     { Do not localize }
  SDRIVERREG_SETTING = 'Driver de Arquivo de Registro';           { Do not localize }
  SCONNECTIONREG_SETTING = 'Conex�o de Arquivo de Registro';   { Do not localize }
  szUSERNAME         = 'USU�RIO';             { Do not localize }
  szPASSWORD         = 'SENHA';              { Do not localize }
  SLocaleCode        = 'LCID';                  { Do not localize }
  ROWSETSIZE_KEY     = 'RowsetSize';            { Do not localize }
  OSAUTHENTICATION   = 'Autentica��o de OS';     { Do not localize }
  SERVERPORT         = 'Porta do Servidor';           { Do not localize }
  MULTITRANSENABLED  = 'Transa��es M�ltiplas';  { Do not localize }
  TRIMCHAR           = 'Trim Char';             { Do not localize }
  CUSTOM_INFO        = 'String Customizada';         { Do not localize }
  CONN_TIMEOUT       = 'Tempo expirado de Conex�o';    { Do not localize }
{$IFDEF MSWINDOWS}
  SDriverConfigFile = 'dbxdrivers.ini';            { Do not localize }
  SConnectionConfigFile = 'dbxconnections.ini';    { Do not localize }
  SDBEXPRESSREG_SETTING = '\Software\Borland\DBExpress'; { Do not localize }
{$ENDIF}
{$IFDEF LINUX}
  SDBEXPRESSREG_USERPATH = '/.borland/';          { Do not localize }
  SDBEXPRESSREG_GLOBALPATH = '/usr/local/etc/';   { Do not localize }
  SDriverConfigFile = 'dbxdrivers';                  { Do not localize }
  SConnectionConfigFile = 'dbxconnections';          { Do not localize }
  SConfExtension = '.conf';                       { Do not localize }
{$ENDIF}

resourcestring

  SLoginError = 'N�o � poss�vel conectar com o banco de dados ''%s''';
  SMonitorActive = 'N�o � poss�vel alterar conex�o em Active Monitor';
  SMissingConnection = 'Faltando propriedade SQLConnection';
  SDatabaseOpen = 'N�o pode executar esta opera��o em uma conex�o aberta';
  SDatabaseClosed = 'N�o pode executar esta opera��o em uma conex�o fechada';
  SMissingSQLConnection = 'Propriedade SQLConnection requerida para esta opera��o';
  SConnectionNameMissing = 'Faltando nome da conex�o';
  SEmptySQLStatement = 'Nenhuma indica��o do SQL dispon�vel';
  SNoParameterValue = 'Nenhum valor para o par�metro ''%s''';
  SNoParameterType = 'Nenhum tipo de par�metro para o par�metro ''%s''';
  SParameterTypes = ';Input;Output;Input/Output;Result';
  SDataTypes = ';String;SmallInt;Integer;Word;Boolean;Float;Currency;BCD;Date;Time;DateTime;;;;Blob;Memo;Graphic;;;;;Cursor;';
  SResultName = 'Result';
  SNoTableName = 'Faltando propriedade TableName';
  SNoSqlStatement = 'Faltando query, table name ou procedure name';
  SNoDataSetField = 'Faltando propriedade DataSetField';
  SNoCachedUpdates = 'Not in cached update mode';
  SMissingDataBaseName = 'Faltando propriedade Database';
  SMissingDataSet = 'Faltando propriedade DataSet';
  SMissingDriverName = 'Faltando propriedade DriverName';
  SPrepareError = 'Incapaz de executar Query';
  SObjectNameError = 'Tabela/Procedure n�o encontrada';
  SSQLDataSetOpen = 'Incapaz de determinar nomes de campos para %s';
  SNoActiveTrans = 'N�o existem transa��es ativas';
  SActiveTrans = 'Uma transa��o j� est� ativa';
  SDllLoadError = 'Incapaz de Carregar %s';
  SDllProcLoadError = 'Incapaz de achar Procedure %s';
  SConnectionEditor = '&Editar Propriedades de Conex�o';
  SCommandTextEditor = '&Editar CommandText';
  SMissingDLLName = 'DLL/Shared Library Name n�o ajustada';
  SMissingDriverRegFile = 'Driver/Connection Registry File ''%s'' n�o encontrado';
  STableNameNotFound = 'N�o � poss�vel achar TableName em CommandText';
  SNoCursor = 'Cursor n�o retornado da Query';
  SMetaDataOpenError = 'Incapaz de abrir Metadata';
  SErrorMappingError = 'Erro no SQL: Mapeamento do erro falhou';
  SStoredProcsNotSupported = 'Stored Procedures n�o suportadas pelo Servidor ''%s''';
  SPackagesNotSupported = 'Pacotes n�o s�o suportados pelo Servidor ''%s''';
  SDBXUNKNOWNERROR = 'Erro no DBX: Nenhum mapeamento para o C�digo do Erro encontrado';
  SDBXNOCONNECTION = 'Erro no DBX: Conex�o n�o encontrada, mensagem de erro n�o pode ser recuperada';
  SDBXNOMETAOBJECT = 'Erro no DBX: MetadataObject n�o encontrado, mensagem de erro n�o pode ser recuperada';
  SDBXNOCOMMAND = 'Erro no DBX: Comando n�o encontrado, mensagem de erro n�o pode ser recuperada';
  SDBXNOCURSOR = 'Erro no DBX: Cursor n�o encontrado, mensagem de erro n�o pode ser recuperada';
  SNOMEMORY = 'Erro no DBX: Mem�ria Insuficiente para Opera��o';
  SINVALIDFLDTYPE = 'Erro no DBX: Tipo de Campo Inv�lido';
  SINVALIDHNDL = 'Erro no DBX: Handle Inv�lido';
  SINVALIDTIME = 'Erro no DBX: Hora Inv�lida';
  SNOTSUPPORTED = 'Erro no DBX: Opera��o N�o Suportado';
  SINVALIDXLATION = 'Erro no DBX: Tradu��o Inv�lida';
  SINVALIDPARAM = 'Erro no DBX: Par�metro Inv�lido';
  SOUTOFRANGE = 'Erro no DBX: Argumento fora da Faixa';
  SSQLPARAMNOTSET = 'Erro no DBX: Par�metro n�o Ajustado';
  SEOF = 'Erro no DBX: Result set at EOF';
  SINVALIDUSRPASS = 'Erro no DBX: Usu�rio/Senha Inv�lido';
  SINVALIDPRECISION = 'Erro no DBX: Precis�o Inv�lida';
  SINVALIDLEN = 'Erro no DBX: Comprimento Inv�lido';
  SINVALIDXISOLEVEL = 'Erro no DBX: Transa��o Inv�lida do N�vel de Isola��o';
  SINVALIDTXNID = 'Erro no DBX: ID da Transa��o Inv�lido';
  SDUPLICATETXNID = 'Erro no DBX: ID da Transa��o Duplicado';
  SDRIVERRESTRICTED = 'dbExpress: Aplica��o n�o � licenciada para usar esta caracter�stica';
  SLOCALTRANSACTIVE = 'Erro no DBX: Transa��o Local j� ativa';
  SMULTIPLETRANSNOTENABLED = 'Erro no dbExpress: Transa��es M�ltiplas n�o Habilitadas';
  SMultiConnNotSupported = 'M�ltiplas Conex�es n�o suportadas pelo driver %s';
  SConfFileMoveError = 'Incapaz de mover %s para %s';
  SMissingConfFile = 'Arquivo de configura��o %s n�o encontrado';
  SObjectViewNotTrue = 'ObjectView deve ser True para Tables com campos Objeto';
  SDriverNotInConfigFile = 'Driver (%s) n�o encontrado em arquivo Cfg (%s)';
  SObjectTypenameRequired = 'Requerido nome do tipo do objeto como um valor de par�metro';
  SCannotCreateFile = 'N�o � poss�vel criar arquivo %s';
// used in SqlReg.pas
  SDlgOpenCaption = 'Abrir arquivo de log';
  SDlgFilterTxt = 'Arquivos Texto (*.txt)|*.txt|Todos os arquivos (*.*)|*.*';
  SLogFileFilter = 'Arquivos de Log (*.log)';
  SCircularProvider = 'Refer�ncias Circulares no provedor n�o permitidas.';

const

  DbxError : array[0..19] of String = ( '', SNOMEMORY, SINVALIDFLDTYPE,
                SINVALIDHNDL, SINVALIDTIME,
                SNOTSUPPORTED, SINVALIDXLATION, SINVALIDPARAM, SOUTOFRANGE,
                SSQLPARAMNOTSET, SEOF, SINVALIDUSRPASS, SINVALIDPRECISION,
                SINVALIDLEN, SINVALIDXISOLEVEL, SINVALIDTXNID, SDUPLICATETXNID,
                SDRIVERRESTRICTED, SLOCALTRANSACTIVE, SMULTIPLETRANSNOTENABLED );

implementation

end.
