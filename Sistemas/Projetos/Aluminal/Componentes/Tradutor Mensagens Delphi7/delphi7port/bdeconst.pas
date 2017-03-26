
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

  SAutoSessionExclusive = 'Não foi possível permitir a propriedade de AutoSessionName com mais de uma sessão em um formulário ou em um dado-módulo';
  SAutoSessionExists = 'Não foi possível adicionar uma sessão ao formulário ou ao dado-módulo quando a sessão '' %s'' ainda tiver AutoSessionName permitido';
  SAutoSessionActive = 'Não foi possível modificar a SessionName quando o AutoSessionName for permitido';
  SDuplicateDatabaseName = 'Nome da tabela ''%s'' duplicado';
  SDuplicateSessionName = 'Nome da seção ''%s'' duplicado';
  SInvalidSessionName = 'Nome da seção ''%s'' inválido';
  SDatabaseNameMissing = 'Nome da seção ausente';
  SSessionNameMissing = 'Nome da seção ausente';
  SDatabaseOpen = 'Não é possível executar esta operação em um banco de dados aberto';
  SDatabaseClosed = 'Não é possível executar esta operação em um banco de dados fechado';
  SDatabaseHandleSet = 'Handle de banco de dados pertence a uma sessão diferente';
  SSessionActive = 'Não é possível executar esta operação em uma sessão ativa';
  SHandleError = 'Erro ao criar handle do cursor';
  SInvalidFloatField = 'Não é possível converter o campo ''%s'' para um valor de ponto flutuante';
  SInvalidIntegerField = 'Não é possível converter o campo ''%s'' para um valor inteiro';
  STableMismatch = 'Tabelas fonte e destino são incompatíveis';
  SFieldAssignError = 'Campos ''%s'' e ''%s'' não são compatíveis para atribuição';
  SNoReferenceTableName = 'Referência do nome da tabela não especificado para o campo ''%s''';
  SCompositeIndexError = 'Não é possível usar um array de valores de campos em Expressões de Índice';
  SInvalidBatchMove = 'Parâmetros inválidos para batch move';
  SEmptySQLStatement = 'Nenhuma declaração SQL disponível';
  SNoParameterValue = 'Nenhum valor para o parâmetro ''%s''';
  SNoParameterType = 'Parâmetro sem tipo: ''%s''';
  SLoginError = 'Não é possível conectar com o banco de dados ''%s''';
  SInitError = 'Um erro ocorreu durante a inicialização do Borland Database Engine (erro $%.4x)';
  SDatabaseEditor = 'Da&tabase Editor...';
  SExplore = 'E&xplorar';
  SLinkDetail = '''%s'' não pode ser aberto';
  SLinkMasterSource = 'A propriedade MasterSource do ''%s'' deve estar associado a um DataSource';
  SLinkMaster = 'Incapaz de abrir a tabela MasterSource';
  SGQBEVerb = '&Query Builder...';
  SBindVerb = 'Definir &Parâmetros...';
  SIDAPILangID = '0009';
  SDisconnectDatabase = 'O banco de dados está atualmente conectado. Desconectar e continuar ?';
  SBDEError = 'Erro do BDE $%.4x';
  SLookupSourceError = 'Incapaz de usar DataSource e LookupSource duplicados';
  SLookupTableError = 'LookupSource deve estar conectado a um componente TTable';
  SLookupIndexError = '%s deve ser um índice ativo da tabela lookup';
  SParameterTypes = ';Input;Output;Input/Output;Result';
  SInvalidParamFieldType = 'Deve haver um tipo de campo válido selecionado';
  STruncationError = 'Parâmetro ''%s'' truncado na saída';
  SDataTypes = ';String;SmallInt;Integer;Word;Boolean;Float;Currency;BCD;Date;Time;DateTime;;;;Blob;Memo;Graphic;;;;;Cursor;';
  SResultName = 'Result';
  SDBCaption = '%s%s%s Base de Dados';
  SParamEditor = '%s%s%s Parâmetros';
  SIndexFilesEditor = '%s%s%s Arquivos de Índice';
  SNoIndexFiles = '(Nenhum)';
  SIndexDoesNotExist = 'Índice não existe. Índice: %s';
  SNoTableName = 'Propriedade TableName faltando';
  SNoDataSetField = 'Propriedades dos campos do arquivo ausentes';
  SBatchExecute = 'E&xecutar';
  SNoCachedUpdates = 'Não está no modo cached update';
  SInvalidAliasName = 'Nome inválido do alias %s';
  SNoFieldAccess = 'Não é possível acessar o campo ''%s'' em um filtro';
  SUpdateSQLEditor = '&UpdateSQL Editor...';
  SNoDataSet = 'Nenhum arquivo associado';
  SUntitled = 'Aplicação sem título';
  SUpdateWrongDB = 'Não é possível atualizar, %s não pertence a %s';
  SUpdateFailed = 'Atualização falhou';
  SSQLGenSelect = 'Deve selecionar no mínimo um campo chave e um campo update';
  SSQLNotGenerated = 'SQL de atualização não foi gerada, sair de qualquer forma?';
  SSQLDataSetOpen = 'Incapaz de determinar os nomes dos campos para %s';
  SLocalTransDirty = 'O nível de isolamento da transação deve ser dirty read para os banco de dados locais';
  SMissingDataSet = 'Faltando propriedade do DataSet';
  SNoProvider = 'Não há provedor disponível';
  SNotAQuery = 'Este arquivo não é uma query';

implementation

end.
