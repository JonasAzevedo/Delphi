{ *************************************************************************** }
{                                                                             }
{ Kylix and Delphi Cross-Platform Visual Component Library                    }
{                                                                             }
{ Copyright (c) 1997, 2001 Borland Software Corporation                       }
{                                                                             }
{ *************************************************************************** }


unit DBConsts;

interface

resourcestring

  SInvalidFieldSize = 'Tamanho de campo inv�lido';
  SInvalidFieldKind = 'FieldKind inv�lido';
  SInvalidFieldRegistration = 'Registro de campo inv�lido';
  SUnknownFieldType = 'Campo ''%s'' de tipo desconhecido';
  SFieldNameMissing = 'Nome do campo ausente';
  SDuplicateFieldName = 'Nome de campo duplicado ''%s''';
  SFieldNotFound = '%s: Campo ''%s'' n�o encontrado';
  SFieldAccessError = 'N�o � poss�vel acessar o campo ''%s'' do tipo %s';
  SFieldValueError = 'Valor inv�lido para o campo ''%s''';
  SFieldRangeError = '%g N�o � um valor v�lido para o campo ''%s''. A faixa permitida � de %g at� %g';
  SBcdFieldRangeError = '%s n�o � um valor v�lido para o campo ''%s''. A faixa permitida is %s para %s';
  SInvalidIntegerValue = '''%s'' n�o � um inteiro v�lido para o campo ''%s''';
  SInvalidBoolValue = '''%s'' n�o � uma valor boleano v�lido para o campo ''%s''';
  SInvalidFloatValue = '''%s'' n�o � um valor de ponto flutuante v�lido para o campo ''%s''';
  SFieldTypeMismatch = 'Campo ''%s'' n�o � do tipo esperado';
  SFieldSizeMismatch = 'Tamanho sem combina��o para campo '' %s '', esperando: %d atual: %d';
  SInvalidVarByteArray = 'Tipo ou tamanho da variante inv�lido para o campo ''%s''';
  SFieldOutOfRange = 'Valor do campo ''%s'' est� fora de faixa';
//  SBCDOverflow = '(Estouro da capacidade)';
  SFieldRequired = 'Campo ''%s'' deve ter um valor';
  SDataSetMissing = 'Campo ''%s'' n�o tem arquivo';
  SInvalidCalcType = 'Campo ''%s'' n�o pode ser um campo calculado ou lookup';
  SFieldReadOnly = 'Campo ''%s'' n�o pode ser modificado';
  SFieldIndexError = '�ndice de campo fora de faixa';
  SNoFieldIndexes = '�ndice corrente n�o ativo';
  SNotIndexField = 'Campo ''%s'' n�o est� indexado e n�o pode ser modificado';
  SIndexFieldMissing = 'N�o � poss�vel acessar o �ndice do campo ''%s''';
  SDuplicateIndexName = 'Nome de �ndice duplicado ''%s''';
  SNoIndexForFields = '''%s'' n�o tem �ndice para os campos ''%s''';
  SIndexNotFound = '�ndice ''%s'' n�o encontrado';
  SDuplicateName = 'Nome duplicado ''%s'' em %s';
  SCircularDataLink = 'Liga��es de dados circulares n�o s�o permitidas';
  SLookupInfoError = 'Informa��o Lookup para o campo ''%s'' est� incompleta';
  SNewLookupFieldCaption = 'Novo Campo Lookup';
  SDataSourceChange = 'DataSource n�o pode ser atualizado';
  SNoNestedMasterSource = 'Arquivos aninhados n�o podem ter uma tabela mestra';
  SDataSetOpen = 'N�o � poss�vel realizar esta opera��o em um arquivo aberto';
  SNotEditing = 'Arquivo n�o est� em modo de edi��o ou inser��o';
  SDataSetClosed = 'N�o � poss�vel realizar esta opera��o em um arquivo fechado';
  SDataSetEmpty = 'N�o � poss�vel realizar esta opera��o em um arquivo vazio';
  SDataSetReadOnly = 'N�o � poss�vel modificar um arquivo somente de leitura';
  SNestedDataSetClass = 'Arquivo aninhado t�m que herdar de %s';
  SExprTermination = 'Express�o de filtro incorretamente terminada';
  SExprNameError = 'Nome de campo n�o terminado';
  SExprStringError = 'Constante de string n�o terminada';
  SExprInvalidChar = 'Caractere inv�lido na express�o de filtro: ''%s''';
  SExprNoLParen = ''')'' esperado mas %s encontrado';
  SExprNoRParen = ''')'' esperado mas %s encontrado';
  SExprNoRParenOrComma = ''')'' ou '','' aguardado mas %s existe';
  SExprExpected = 'Express�o esperada mas %s encontrada';
  SExprBadField = 'Campo ''%s'' n�o pode ser usado em uma express�o de filtro';
  SExprBadNullTest = 'NULL somente permitido com ''='' e ''<>''';
  SExprRangeError = 'Constante fora de faixa';
  SExprNotBoolean = 'Campo ''%s'' n�o � do tipo boleano';
  SExprIncorrect = 'Express�o de filtro formada incorretamente';
  SExprNothing = 'Absolutamente';
  SExprTypeMis = 'Tipo de express�o desconhecida';
  SExprBadScope = 'Opera��o n�o pode misturar valor agregado com valor registro-variado';
  SExprNoArith = 'Filtro de express�o aritm�tica n�o suportada';
  SExprNotAgg = 'Express�o n�o � uma express�o agregada';
  SExprBadConst = 'Constante corrente n�o � do tipo %s';
  SExprNoAggFilter = 'Express�es agregadas n�o permitem filtros';
  SExprEmptyInList = 'Lista de predicados IN pode n�o estar vazia';
  SInvalidKeywordUse = 'Uso de Keyword inv�lido';
  STextFalse = 'Falso';
  STextTrue = 'Verdadeiro';
  SParameterNotFound = 'Parametro ''%s'' n�o encontrado';
  SInvalidVersion = 'N�o � poss�vel carregar par�metros da fita';
  SParamTooBig = 'Par�metro ''%s'', n�o � poss�vel salvar dados maiores que %d bytes';
  SBadFieldType = 'Campo ''%s'' � um tipo n�o suportado';
  SAggActive = 'Esta propriedade n�o pode ser modificada enquanto o agregado est� ativo';
  SProviderSQLNotSupported = 'SQL n�o � suportada: %s';
  SProviderExecuteNotSupported = 'Execu��o n�o � suportada: %s';
  SExprNoAggOnCalcs = 'Field ''%s'' is not the correct type of calculated field to be used in an aggregate, use an internalcalc';
  SRecordChanged = 'Registro foi alterado por outro usu�rio';
  SDataSetUnidirectional = 'Opera��o n�o permitida em um dataset unidirecional';
  SUnassignedVar = 'Valor variant n�o atribu�do';
  SRecordNotFound = 'Registro n�o encontrado';
  SFileNameBlank = 'Propriedade FileName n�o pode ser vazia';
  SFieldNameTooLarge = 'Nome de campo %s excede %d caracteres';

{ For FMTBcd }

  SBcdOverflow = 'BCD estouro de capacidade';
  SInvalidBcdValue = '%s n�o � uma valor BCD v�lido';
  SInvalidFormatType = 'Tipo de formato inv�lido para BCD';

{ For SqlTimSt }

  SCouldNotParseTimeStamp = 'Poderia n�o analisar string SQL TimeStamp';
  SInvalidSqlTimeStamp = 'Valores de SQL data/hota inv�lidas';

  SDeleteRecordQuestion = 'Apagar registro?';
  SDeleteMultipleRecordsQuestion = 'Apagar todos os registros selecionados?';
  STooManyColumns = 'Grid requisitou para mostrar mais do que 256 colunas';

  { For reconcile error }
  SSkip = 'Skip';
  SAbort = 'Abortar';
  SMerge = 'Mesclar';
  SCorrect = 'Corrigir';
  SCancel  = 'Cancelar';
  SRefresh = 'Atualizar';
  SModified = 'Modificado';
  SInserted = 'Inserido';
  SDeleted  = 'Apagado';
  SCaption = 'Erro de atualiza��o - %s';
  SUnchanged = '<N�o alterado>';  
  SBinary = '(Bin�rio)';                              
  SAdt = '(ADT)';   
  SArray = '(Matriz)'; 
  SFieldName = 'Nome do Campo'; 
  SOriginal = 'Valor Original'; 
  SConflict = 'Valor Conflitante';  
  SValue = ' Valor';   
  SNoData = '<Sem Registros>';
  SNew = 'Novo';    

implementation

end.
