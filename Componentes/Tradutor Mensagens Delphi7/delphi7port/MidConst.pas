{ *************************************************************************** }
{                                                                             }
{ Kylix and Delphi Cross-Platform Visual Component Library                    }
{                                                                             }
{ Copyright (c) 1997, 2001 Borland Software Corporation                       }
{                                                                             }
{ *************************************************************************** }


unit MidConst;

interface

const
{ Do not localize }
  MIDAS_CatDesc = 'Borland DataSnap Application Servers';
  CATID_MIDASAppServer: TGUID = '{13E85B3C-9508-11D2-AB63-00C04FA35CFA}';
  MIDASInterceptor_CatDesc = 'Borland DataSnap Application Servers';
  CATID_MIDASInterceptor: TGUID = '{6BFD12F2-7004-11D4-BE3C-0001023E6E0F}';
  SCatImplBaseKey = '%s\Implemented Categories';
  SCatImplKey = SCatImplBaseKey + '\%s';
  MIDAS_DLL = 'MIDAS.DLL';
  SClsid = 'CLSID\';
  SPooled = 'Pooled';
  SMaxObjects = 'MaxObjects';
  STimeout = 'Timeout';
  SSingleton = 'Singleton';
  SSockets = 'Sockets';
  SWeb = 'Web';
  SFlagOn = '1';
  SFlagOff = '0';
  MINDATAPACKETSIZE = 8;   
{$IFDEF LINUX}
  SMidasLib = 'libmidas.so.1';
{$ENDIF}
{$IFDEF MSWINDOWS}
  SMidasLib = 'midas.dll';
{$ENDIF}
resourcestring
  { App Server }
  SProviderNotExported = 'Provedor não exportado: %s';

  { DBClient }
  SNoDataProvider = 'Provedor de dados ou base de dados perdidos';
  SInvalidDataPacket = 'Base de dados inválida';
  SRefreshError = 'É necessário aplicar as atualizações antes de atualizar os dados';
  SProviderInvalid = 'Provedor inválido. o provedor foi livrado pelo servidor de aplicação';
  SServerNameBlank = 'Não é possível conectar, %s necessita do ServerName ou ServerGUID validos';
  SRepositoryIdBlank = 'Não é possível conectar, %s necessita conter um container id válido';
  SAggsGroupingLevel = 'Nivel de agrupamento excede a contagem atual do campo do deslocamento predeterminado ';
  SAggsNoSuchLevel = 'Nível de agrupamento não definido';
  SNoCircularReference = 'Referências de provedor circulares não são permitidas';
  SErrorLoadingMidas = 'Erro carregando MIDAS.DLL';
  SCannotCreateDataSet = 'Nenhum campo definido.  Não pode criar dataset';
  SInvalidClone = 'CloneConnection inválida: descendentes ClientDataSet distintos';
  SCDSDlgOpenCaption = 'Open MyBase table';
  SNoConnectToBroker = 'Conexão não autorizada para TConnectionBroker';

  { MConnect }
  SSocketReadError = 'Erro de leitura no socket';
  SInvalidProviderName = 'Nome do provedor "%s" não foi reconhecido pelo servidor';
  SBadVariantType = 'Tipo de variante: %s não suportado';
  SInvalidAction = 'Ação recebida: %d inválida';
  SNoParentConnection = 'ParentConnection não é atribuída';
  SBlankChildName = 'ChildName não pode ser vazio';

  { Resolver }
  SInvalidResponse = 'Resposta inválida';
  SRecordNotFound = 'Registro não encontrado';
  STooManyRecordsModified = 'Atualização afetou mais de 1 registro';

  { Provider }
  SInvalidOptParamType = 'Não pode ser armazenado valores em um parâmetro opcional';
  SMissingDataSet = 'Propriedades do arquivo perdida';
  SConstraintFailed = 'Falha do registro ou do campo';
  SField = 'Campo';
  SReadOnlyProvider = 'Não é possível aplicar atualizações em um provedor somente-leitura';
  SNoKeySpecified = 'Não é possível localizar o registro.  Nenhuma chave foi especificada';
  SFieldNameTooLong = 'O nome do campo não pode ser maior que %d caracteres.  Tente' +
                      'ajustar o ObjectView para True no dataset';
  SNoDataSets = 'Não é possível resolver a série de dados ao usar séries ou referências aninhadas ';
  SRecConstFail = 'A preparação do registro de confinamento falhou com erro  "%s"';
  SFieldConstFail = 'O Confinamento padrão do campo falhou com erro "%s"';
  SDefExprFail = 'Expressão padrão preparada falhou com erro "%s"';
  SArrayElementError = 'Tipo de elementos do array %s não são suportados';
  SNoTableName = 'Impossível reconhecer registros.  Nome da tabela não encontrado.';
  SNoEditsAllowed = 'Modificações não são permitidas';
  SNoDeletesAllowed = 'Deleções não são permitidas';
  SNoInsertsAllowed = 'Inserções não são permitidas';
  SCannotChangeCommandText = 'Modificações CommandText não são permitidas';
  SAggregatesActive = 'Operação não permitida com ativos agregados';

  { ObjectBroker }
  SNoServers = 'Servidor não disponível';

  { ConnectionBroker }

  SConnectionMissing = 'Requer Conexão antes de abrir';
  SNoCircularConnection = 'Referência circular para conexão não permitida';

  { Socket Connection }
  SReturnError = 'Não foi recebido nenhum valor de retorno que era aguardado';
  SNoWinSock2 = 'WinSock 2 deve estar instalado para usar o soquete de conexão';

  { Web Connection }
  SURLRequired = 'URL required';
  SDefaultURL = 'http://server.company.com/scripts/httpsrvr.dll';
  SInvalidURL = 'URL deve ser da maneira "http://server.company.com/scripts/httpsrvr.dll"';
  SServerIsBusy = 'Servidor está ocupado';

  SObjectNotAvailable = 'Objeto não disponível: %s';

  { SuperComponents }
  SMasterNotOpen = 'Não pode abrir detalhes da tabela com master fechado';

implementation

end.
