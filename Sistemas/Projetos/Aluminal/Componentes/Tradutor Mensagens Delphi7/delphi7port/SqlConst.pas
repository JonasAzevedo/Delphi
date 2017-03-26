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
  CONNECTIONS_KEY = 'Conexões Instaladas';      { Do not localize }
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
  SCONNECTIONREG_SETTING = 'Conexão de Arquivo de Registro';   { Do not localize }
  szUSERNAME         = 'USUÁRIO';             { Do not localize }
  szPASSWORD         = 'SENHA';              { Do not localize }
  SLocaleCode        = 'LCID';                  { Do not localize }
  ROWSETSIZE_KEY     = 'RowsetSize';            { Do not localize }
  OSAUTHENTICATION   = 'Autenticação de OS';     { Do not localize }
  SERVERPORT         = 'Porta do Servidor';           { Do not localize }
  MULTITRANSENABLED  = 'Transações Múltiplas';  { Do not localize }
  TRIMCHAR           = 'Trim Char';             { Do not localize }
  CUSTOM_INFO        = 'String Customizada';         { Do not localize }
  CONN_TIMEOUT       = 'Tempo expirado de Conexão';    { Do not localize }
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

  SLoginError = 'Não é possível conectar com o banco de dados ''%s''';
  SMonitorActive = 'Não é possível alterar conexão em Active Monitor';
  SMissingConnection = 'Faltando propriedade SQLConnection';
  SDatabaseOpen = 'Não pode executar esta operação em uma conexão aberta';
  SDatabaseClosed = 'Não pode executar esta operação em uma conexão fechada';
  SMissingSQLConnection = 'Propriedade SQLConnection requerida para esta operação';
  SConnectionNameMissing = 'Faltando nome da conexão';
  SEmptySQLStatement = 'Nenhuma indicação do SQL disponível';
  SNoParameterValue = 'Nenhum valor para o parâmetro ''%s''';
  SNoParameterType = 'Nenhum tipo de parâmetro para o parâmetro ''%s''';
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
  SObjectNameError = 'Tabela/Procedure não encontrada';
  SSQLDataSetOpen = 'Incapaz de determinar nomes de campos para %s';
  SNoActiveTrans = 'Não existem transações ativas';
  SActiveTrans = 'Uma transação já está ativa';
  SDllLoadError = 'Incapaz de Carregar %s';
  SDllProcLoadError = 'Incapaz de achar Procedure %s';
  SConnectionEditor = '&Editar Propriedades de Conexão';
  SCommandTextEditor = '&Editar CommandText';
  SMissingDLLName = 'DLL/Shared Library Name não ajustada';
  SMissingDriverRegFile = 'Driver/Connection Registry File ''%s'' não encontrado';
  STableNameNotFound = 'Não é possível achar TableName em CommandText';
  SNoCursor = 'Cursor não retornado da Query';
  SMetaDataOpenError = 'Incapaz de abrir Metadata';
  SErrorMappingError = 'Erro no SQL: Mapeamento do erro falhou';
  SStoredProcsNotSupported = 'Stored Procedures não suportadas pelo Servidor ''%s''';
  SPackagesNotSupported = 'Pacotes não são suportados pelo Servidor ''%s''';
  SDBXUNKNOWNERROR = 'Erro no DBX: Nenhum mapeamento para o Código do Erro encontrado';
  SDBXNOCONNECTION = 'Erro no DBX: Conexão não encontrada, mensagem de erro não pode ser recuperada';
  SDBXNOMETAOBJECT = 'Erro no DBX: MetadataObject não encontrado, mensagem de erro não pode ser recuperada';
  SDBXNOCOMMAND = 'Erro no DBX: Comando não encontrado, mensagem de erro não pode ser recuperada';
  SDBXNOCURSOR = 'Erro no DBX: Cursor não encontrado, mensagem de erro não pode ser recuperada';
  SNOMEMORY = 'Erro no DBX: Memória Insuficiente para Operação';
  SINVALIDFLDTYPE = 'Erro no DBX: Tipo de Campo Inválido';
  SINVALIDHNDL = 'Erro no DBX: Handle Inválido';
  SINVALIDTIME = 'Erro no DBX: Hora Inválida';
  SNOTSUPPORTED = 'Erro no DBX: Operação Não Suportado';
  SINVALIDXLATION = 'Erro no DBX: Tradução Inválida';
  SINVALIDPARAM = 'Erro no DBX: Parâmetro Inválido';
  SOUTOFRANGE = 'Erro no DBX: Argumento fora da Faixa';
  SSQLPARAMNOTSET = 'Erro no DBX: Parâmetro não Ajustado';
  SEOF = 'Erro no DBX: Result set at EOF';
  SINVALIDUSRPASS = 'Erro no DBX: Usuário/Senha Inválido';
  SINVALIDPRECISION = 'Erro no DBX: Precisão Inválida';
  SINVALIDLEN = 'Erro no DBX: Comprimento Inválido';
  SINVALIDXISOLEVEL = 'Erro no DBX: Transação Inválida do Nível de Isolação';
  SINVALIDTXNID = 'Erro no DBX: ID da Transação Inválido';
  SDUPLICATETXNID = 'Erro no DBX: ID da Transação Duplicado';
  SDRIVERRESTRICTED = 'dbExpress: Aplicação não é licenciada para usar esta característica';
  SLOCALTRANSACTIVE = 'Erro no DBX: Transação Local já ativa';
  SMULTIPLETRANSNOTENABLED = 'Erro no dbExpress: Transações Múltiplas não Habilitadas';
  SMultiConnNotSupported = 'Múltiplas Conexões não suportadas pelo driver %s';
  SConfFileMoveError = 'Incapaz de mover %s para %s';
  SMissingConfFile = 'Arquivo de configuração %s não encontrado';
  SObjectViewNotTrue = 'ObjectView deve ser True para Tables com campos Objeto';
  SDriverNotInConfigFile = 'Driver (%s) não encontrado em arquivo Cfg (%s)';
  SObjectTypenameRequired = 'Requerido nome do tipo do objeto como um valor de parâmetro';
  SCannotCreateFile = 'Não é possível criar arquivo %s';
// used in SqlReg.pas
  SDlgOpenCaption = 'Abrir arquivo de log';
  SDlgFilterTxt = 'Arquivos Texto (*.txt)|*.txt|Todos os arquivos (*.*)|*.*';
  SLogFileFilter = 'Arquivos de Log (*.log)';
  SCircularProvider = 'Referências Circulares no provedor não permitidas.';

const

  DbxError : array[0..19] of String = ( '', SNOMEMORY, SINVALIDFLDTYPE,
                SINVALIDHNDL, SINVALIDTIME,
                SNOTSUPPORTED, SINVALIDXLATION, SINVALIDPARAM, SOUTOFRANGE,
                SSQLPARAMNOTSET, SEOF, SINVALIDUSRPASS, SINVALIDPRECISION,
                SINVALIDLEN, SINVALIDXISOLEVEL, SINVALIDTXNID, SDUPLICATETXNID,
                SDRIVERRESTRICTED, SLOCALTRANSACTIVE, SMULTIPLETRANSNOTENABLED );

implementation

end.
