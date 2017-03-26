{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1997,99 Inprise Corporation       }
{                                                       }
{*******************************************************}

unit Mxconsts;

{$R mxconsts.RES}

interface

const

  { DecisionCube Dialog help contexts }
  hcDDecisionCubeEditor = 30170;
  hcDDecisionCubeDimensions = 30171;
  hcDDecisionCubeMemoryControl = 30172;
  hcDDecisionCubeDesignerOptions = 30173;
  hcDDecisionCubeLimits = 30174;
  hcDDecisionQueryEditor = 30180;
  hcDDecisionQueryDimensions = 30181;
  hcDDecisionQuerySQLEditor = 30182;

resourcestring

  sRowError            = 'erro de linha';
  { Strings used in the Pivot }
  SAllValues           = 'Todos valores';
  SMovetoRow           = 'Vai para a área da linha ';
  SMovetoCol           = 'Vai para a área da coluna';
  sMakeDimOpen         = 'Abrir dimensão';
  sDrilled             = 'Perfurado dentro';
  sCouldNotOpen        = 'A informação solicitada não pode ser carregada. ';
  sNoSumsAvailable     = 'Nenhum sumário ativo foi definido';
  sNoSumsCouldBeLoaded = 'Não há endereços disponíveis para carregar um sumário . ';
  sNoDimsAvailable     = 'Nenhuma dimensão disponível foi definida';
  sNoDimsCouldBeLoaded = 'Não há espaço disponível para carregar a dimensão';

  sTemplatePrefix = 'Modelo: ';
  { Strings used in the CrossTabGrid }
  sGridCellError  = '[Erro]';
  sTotalCaption   = 'Soma';
  sActivateLabel  = 'Dimensões Inativas';
  sRowCaption     = 'R';
  sColCaption     = 'C';
  SCaptionMenu1   = 'Exibindo os dados e os subtotais';
  SCaptionMenu2   = 'Exibindo somente os dados';
  SCaptionMenu3   = 'Exibindo somente os subtotais';
  SDrillIn        = 'Perfure dentro deste valor';
  sGridMenu1      = 'Subtotais Lig/Desl';
  sGridMenu2      = 'Decision Cube Editor..';
  sGridMenu3      = 'Decision Query Editor..';
  sGridMenu4      = 'Exibir detalhes dos registros..';

  { Strings used in mxarrays }
  sUnsupportedDataType  = 'Tipo do dado %s não suportado';
  sRowOutOfRange        = 'Índice da linha fora do intervalo: %d';
  sColOutOfRange        = 'Índice da coluna fora do intervalo: %d';
  sDupeItem             = 'Ítem no array duplicado';
  sArrayIndexOutOfRange = 'Índice do array fora do intervalo: %d';
  sLowCapacityError     = 'A capacidade do DecisionCube está baixa. Por favor, desative as dimensões ou mude a série de dados';
  sQryNotInitialized    = 'Não é possível executar a Query. Verifique se a Query, SQL text, e o Database estão corretos.';
  sSortedListError      = 'Operação não suportada ao filtrar lista de strings.';
  sDuplicateString      = 'Não é permitida lista de Strings duplicadas';
  sMaxAllowedSums       = 'Foi excedido o maxímo de sumarios %d permitidos';
  sGeneralArrayError    = 'Erro geral no array';

  {String used in the DecisionSource}
  SDimIndexError = 'Índice de dimensão ilegal';

  {String used in the DecisionCube}
  SIllegalValueForBin    = 'Valor inicial não é legal para este tipo de agrupamento';
  SIllegalDimMap         = 'Mapa da dimensão não está com a dimensão correta';
  SDimMapActiveError     = 'Não é possível prosseguir com esta ação em um mapa ativo da dimensão';
  SNotAvailable          = 'Não disponível';
  SGetValueCounts        = 'A informação necessária para fazer o limite máximo da pilha não é atual. Você quer atualizá-la agora?';
  SDateBinningNotAllowed = 'Dados agrupados não são permitidos para campos deste tipo';
  sEmptyDataSet          = 'Não é possível gerar o Decision Cube com a base de dados vazia';

  { Strings use in Query UI}
  sNoDataSet          = 'A série da propriedade não foi atribuída à base de dados';
  SNoAggs             = 'Nenhum sumário foi definido';
  SNoDims             = 'Campos de dimensões não foram definidos';
  SUnknownDims        = 'Os tipos da dimensão para esta série de dados não podem ser determinados automaticamente. Você deve traçar os campos às dimensões ou os sumários com o editor do decision cube';
  SGroupsMissing      = 'Todos os campos da dimensão devem ser agrupados';
  SDecisionQueryError = 'Ou você pode necessitar traçar seus campos às dimensões ativas ou os sumários com o editor do decision cube';
  SDataSetError       = 'Os arquivos podem ser definidos incorretamente, ou você pode precisar traçar seus campos para dimensões ativas ou resumos com o Editor do Decision Cube';
  SQueryError         = 'A Query pode ser definida incorretamente, ou você pode precisar traçar seus campos para dimensões ativas ou resumos com o Editor do Decision Cube';
  SCountStar          = 'COUNTALL';
  SAddAvgWarning      = 'A média que usa soma e resumos de conta para cada campo é calculada. Os resumos necessários foram somados.';
  SAddAvgStarWarning  = 'Média que usa uma soma de campo e conta é calculada (*). Os resumos necessários foram somados.';

  { Query UI Designer strings}
  SQueryLegal           = 'A Query é legal.';
  sAddFieldExists       = 'Já existe em uma query';
  SAggTypeNotAllowed    = 'Não é um tipo de sumário permitido';
  SDimTypeNotAllowed    = 'Não é um tipo de dimensão permitida';
  SAverageRequires      = 'Resumos comuns usam Soma e Conta';
  SWantToExit           = 'Você ainda quer Sair?';
  sQueryIllegal         = 'A query que você criou não é legal. Por favor corrija antes de continuar.';
  SQueryEditIllegal     = 'A Query na qual você entrou não é legal. Por favor corrija antes de continuar';
  sRemoveFieldError     = 'Não é possível remover este campo';
  sAllFields            = 'todos Campos';
  sQueryFields          = 'Campos da Query';
  sEditDone             = '&Edição final';
  sEditQuery            = '&Editar Query';

  { Used by the query parser}
  SQParseRemovedField = 'Foram removidos um ou mais campos de um tipo que não pode ser tabulado da Query';

  { used by mxstore }
  sCubeLimitsExceeded    = 'tamanho do Decision Cube excedeu os limites';
  sMaxAllowedDims        = 'foi excedito o tamanho máximo das dimensões do %d permitidas.';
  sMaxAllowedCells       = 'Contagem total de células do %d excedeu o máximo do %d.';
  sUnsupportedFieldType  = 'Campo %s tem um tipo de dados não suportado: %s';
  sFetchValues           = 'Scaneando valores de dados fixados...';
  sUserCanceled          = 'Usuário cancelou a população do DecisionCube';
  sBinningValues         = 'Agrupando valores...';
  sCreatingIndexes       = 'Criando índice de cubo para %s ...';
  sCreateDerivedSummaryError = 'Não é possível criar sumário derivado';
  sTrue                  = 'Verdadeiro';
  sFalse                 = 'Falso';
  sBinTypeMismatch       = 'Tipo de campo não confere com o tipo de caixa';
  sFatalCacheError       = 'Ocorreu um erro fatal no cache: código: %d';
  sStringTypeNoSupported = 'Tipo de dados não suportados no sumário';
  sDataSetTooLarge       = 'Arquivo muito grande';
  sBuildingDataStore     = 'Gerando histórico de dados...';

  {String used in MXtables and mxcommon and mxqparse}
  sSumLabel           = 'Soma de %s';
  sCountLabel         = 'Contagem de %s';
  sMaxLabel           = 'Máximo de %s';
  sMinLabel           = 'Mínimo de %s';
  sAverageLabel       = 'Média of %s';
  sVarLabel           = 'Variando de %s';
  sSDLabel            = 'Divergência de %s';
  sAggLabel           = 'Sumário de %s';
  sUnsupportedVarType = 'Tipo de dado %d não suportado';
  sOtherValues        = 'Outros valores';

  sSelectFromError    = 'Query falhando na cláusula Select/From';
  sArgumentExpected   = 'Nenhum argumento providenciado para o operador ou resumo';
  sGroupOnExpressionError = 'Uma expressão não pode ser usada para um campo de agrupamento';

  SOutofBounds        = 'fora dos limites';
  SIDAPILangID        = '0009';

implementation

end.
