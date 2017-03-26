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
  SProviderNotExported = 'Provedor n�o exportado: %s';

  { DBClient }
  SNoDataProvider = 'Provedor de dados ou base de dados perdidos';
  SInvalidDataPacket = 'Base de dados inv�lida';
  SRefreshError = '� necess�rio aplicar as atualiza��es antes de atualizar os dados';
  SProviderInvalid = 'Provedor inv�lido. o provedor foi livrado pelo servidor de aplica��o';
  SServerNameBlank = 'N�o � poss�vel conectar, %s necessita do ServerName ou ServerGUID validos';
  SRepositoryIdBlank = 'N�o � poss�vel conectar, %s necessita conter um container id v�lido';
  SAggsGroupingLevel = 'Nivel de agrupamento excede a contagem atual do campo do deslocamento predeterminado ';
  SAggsNoSuchLevel = 'N�vel de agrupamento n�o definido';
  SNoCircularReference = 'Refer�ncias de provedor circulares n�o s�o permitidas';
  SErrorLoadingMidas = 'Erro carregando MIDAS.DLL';
  SCannotCreateDataSet = 'Nenhum campo definido.  N�o pode criar dataset';
  SInvalidClone = 'CloneConnection inv�lida: descendentes ClientDataSet distintos';
  SCDSDlgOpenCaption = 'Open MyBase table';
  SNoConnectToBroker = 'Conex�o n�o autorizada para TConnectionBroker';

  { MConnect }
  SSocketReadError = 'Erro de leitura no socket';
  SInvalidProviderName = 'Nome do provedor "%s" n�o foi reconhecido pelo servidor';
  SBadVariantType = 'Tipo de variante: %s n�o suportado';
  SInvalidAction = 'A��o recebida: %d inv�lida';
  SNoParentConnection = 'ParentConnection n�o � atribu�da';
  SBlankChildName = 'ChildName n�o pode ser vazio';

  { Resolver }
  SInvalidResponse = 'Resposta inv�lida';
  SRecordNotFound = 'Registro n�o encontrado';
  STooManyRecordsModified = 'Atualiza��o afetou mais de 1 registro';

  { Provider }
  SInvalidOptParamType = 'N�o pode ser armazenado valores em um par�metro opcional';
  SMissingDataSet = 'Propriedades do arquivo perdida';
  SConstraintFailed = 'Falha do registro ou do campo';
  SField = 'Campo';
  SReadOnlyProvider = 'N�o � poss�vel aplicar atualiza��es em um provedor somente-leitura';
  SNoKeySpecified = 'N�o � poss�vel localizar o registro.  Nenhuma chave foi especificada';
  SFieldNameTooLong = 'O nome do campo n�o pode ser maior que %d caracteres.  Tente' +
                      'ajustar o ObjectView para True no dataset';
  SNoDataSets = 'N�o � poss�vel resolver a s�rie de dados ao usar s�ries ou refer�ncias aninhadas ';
  SRecConstFail = 'A prepara��o do registro de confinamento falhou com erro  "%s"';
  SFieldConstFail = 'O Confinamento padr�o do campo falhou com erro "%s"';
  SDefExprFail = 'Express�o padr�o preparada falhou com erro "%s"';
  SArrayElementError = 'Tipo de elementos do array %s n�o s�o suportados';
  SNoTableName = 'Imposs�vel reconhecer registros.  Nome da tabela n�o encontrado.';
  SNoEditsAllowed = 'Modifica��es n�o s�o permitidas';
  SNoDeletesAllowed = 'Dele��es n�o s�o permitidas';
  SNoInsertsAllowed = 'Inser��es n�o s�o permitidas';
  SCannotChangeCommandText = 'Modifica��es CommandText n�o s�o permitidas';
  SAggregatesActive = 'Opera��o n�o permitida com ativos agregados';

  { ObjectBroker }
  SNoServers = 'Servidor n�o dispon�vel';

  { ConnectionBroker }

  SConnectionMissing = 'Requer Conex�o antes de abrir';
  SNoCircularConnection = 'Refer�ncia circular para conex�o n�o permitida';

  { Socket Connection }
  SReturnError = 'N�o foi recebido nenhum valor de retorno que era aguardado';
  SNoWinSock2 = 'WinSock 2 deve estar instalado para usar o soquete de conex�o';

  { Web Connection }
  SURLRequired = 'URL required';
  SDefaultURL = 'http://server.company.com/scripts/httpsrvr.dll';
  SInvalidURL = 'URL deve ser da maneira "http://server.company.com/scripts/httpsrvr.dll"';
  SServerIsBusy = 'Servidor est� ocupado';

  SObjectNotAvailable = 'Objeto n�o dispon�vel: %s';

  { SuperComponents }
  SMasterNotOpen = 'N�o pode abrir detalhes da tabela com master fechado';

implementation

end.
