
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1997, 1999 Inprise Corporation    }
{                                                       }
{*******************************************************}

unit bdeconst;

interface

resourcestring

  SAutoSessionExclusive = 'N�o foi poss�vel permitir a propriedade de AutoSessionName com mais de uma sess�o em um formul�rio ou em um dado-m�dulo';
  SAutoSessionExists = 'N�o foi poss�vel adicionar uma sess�o ao formul�rio ou ao dado-m�dulo quando a sess�o '' %s'' ainda tiver AutoSessionName permitido';
  SAutoSessionActive = 'N�o foi poss�vel modificar a SessionName quando o AutoSessionName for permitido';
  SDuplicateDatabaseName = 'Nome da tabela ''%s'' duplicado';
  SDuplicateSessionName = 'Nome da se��o ''%s'' duplicado';
  SInvalidSessionName = 'Nome da se��o ''%s'' inv�lido';
  SDatabaseNameMissing = 'Nome da se��o ausente';
  SSessionNameMissing = 'Nome da se��o ausente';
  SDatabaseOpen = 'N�o � poss�vel executar esta opera��o em um banco de dados aberto';
  SDatabaseClosed = 'N�o � poss�vel executar esta opera��o em um banco de dados fechado';
  SDatabaseHandleSet = 'Handle de banco de dados pertence a uma sess�o diferente';
  SSessionActive = 'N�o � poss�vel executar esta opera��o em uma sess�o ativa';
  SHandleError = 'Erro ao criar handle do cursor';
  SInvalidFloatField = 'N�o � poss�vel converter o campo ''%s'' para um valor de ponto flutuante';
  SInvalidIntegerField = 'N�o � poss�vel converter o campo ''%s'' para um valor inteiro';
  STableMismatch = 'Tabelas fonte e destino s�o incompat�veis';
  SFieldAssignError = 'Campos ''%s'' e ''%s'' n�o s�o compat�veis para atribui��o';
  SNoReferenceTableName = 'Refer�ncia do nome da tabela n�o especificado para o campo ''%s''';
  SCompositeIndexError = 'N�o � poss�vel usar um array de valores de campos em Express�es de �ndice';
  SInvalidBatchMove = 'Par�metros inv�lidos para batch move';
  SEmptySQLStatement = 'Nenhuma declara��o SQL dispon�vel';
  SNoParameterValue = 'Nenhum valor para o par�metro ''%s''';
  SNoParameterType = 'Par�metro sem tipo: ''%s''';
  SLoginError = 'N�o � poss�vel conectar com o banco de dados ''%s''';
  SInitError = 'Um erro ocorreu durante a inicializa��o do Borland Database Engine (erro $%.4x)';
  SDatabaseEditor = 'Da&tabase Editor...';
  SExplore = 'E&xplorar';
  SLinkDetail = '''%s'' n�o pode ser aberto';
  SLinkMasterSource = 'A propriedade MasterSource do ''%s'' deve estar associado a um DataSource';
  SLinkMaster = 'Incapaz de abrir a tabela MasterSource';
  SGQBEVerb = '&Query Builder...';
  SBindVerb = 'Definir &Par�metros...';
  SIDAPILangID = '0009';
  SDisconnectDatabase = 'O banco de dados est� atualmente conectado. Desconectar e continuar ?';
  SBDEError = 'Erro do BDE $%.4x';
  SLookupSourceError = 'Incapaz de usar DataSource e LookupSource duplicados';
  SLookupTableError = 'LookupSource deve estar conectado a um componente TTable';
  SLookupIndexError = '%s deve ser um �ndice ativo da tabela lookup';
  SParameterTypes = ';Input;Output;Input/Output;Result';
  SInvalidParamFieldType = 'Deve haver um tipo de campo v�lido selecionado';
  STruncationError = 'Par�metro ''%s'' truncado na sa�da';
  SDataTypes = ';String;SmallInt;Integer;Word;Boolean;Float;Currency;BCD;Date;Time;DateTime;;;;Blob;Memo;Graphic;;;;;Cursor;';
  SResultName = 'Result';
  SDBCaption = '%s%s%s Base de Dados';
  SParamEditor = '%s%s%s Par�metros';
  SIndexFilesEditor = '%s%s%s Arquivos de �ndice';
  SNoIndexFiles = '(Nenhum)';
  SIndexDoesNotExist = '�ndice n�o existe. �ndice: %s';
  SNoTableName = 'Propriedade TableName faltando';
  SNoDataSetField = 'Propriedades dos campos do arquivo ausentes';
  SBatchExecute = 'E&xecutar';
  SNoCachedUpdates = 'N�o est� no modo cached update';
  SInvalidAliasName = 'Nome inv�lido do alias %s';
  SNoFieldAccess = 'N�o � poss�vel acessar o campo ''%s'' em um filtro';
  SUpdateSQLEditor = '&UpdateSQL Editor...';
  SNoDataSet = 'Nenhum arquivo associado';
  SUntitled = 'Aplica��o sem t�tulo';
  SUpdateWrongDB = 'N�o � poss�vel atualizar, %s n�o pertence a %s';
  SUpdateFailed = 'Atualiza��o falhou';
  SSQLGenSelect = 'Deve selecionar no m�nimo um campo chave e um campo update';
  SSQLNotGenerated = 'SQL de atualiza��o n�o foi gerada, sair de qualquer forma?';
  SSQLDataSetOpen = 'Incapaz de determinar os nomes dos campos para %s';
  SLocalTransDirty = 'O n�vel de isolamento da transa��o deve ser dirty read para os banco de dados locais';
  SMissingDataSet = 'Faltando propriedade do DataSet';
  SNoProvider = 'N�o h� provedor dispon�vel';
  SNotAQuery = 'Este arquivo n�o � uma query';

implementation

end.
