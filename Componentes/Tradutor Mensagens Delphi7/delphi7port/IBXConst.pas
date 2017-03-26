{************************************************************************}
{                                                                        }
{       Borland Delphi Visual Component Library                          }
{       InterBase Express core components                                }
{                                                                        }
{       Copyright (c) 1998-2001 Borland Software Corporation             }
{                                                                        }
{    InterBase Express is based in part on the product                   }
{    Free IB Components, written by Gregory H. Deatz for                 }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.                     }
{    Free IB Components is used under license.                           }
{                                                                        }
{    The contents of this file are subject to the InterBase              }
{    Public License Version 1.0 (the "License"); you may not             }
{    use this file except in compliance with the License. You may obtain }
{    a copy of the License at http://www.borland.com/interbase/IPL.html  }
{    Software distributed under the License is distributed on            }
{    an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either              }
{    express or implied. See the License for the specific language       }
{    governing rights and limitations under the License.                 }
{    The Original Code was created by InterBase Software Corporation     }
{       and its successors.                                              }
{    Portions created by Borland Software Corporation are Copyright      }
{       (C) Borland Software Corporation. All Rights Reserved.           }
{    Contributor(s): Jeff Overcash                                       }
{                                                                        }
{************************************************************************}

unit IBXConst;

interface

uses IBUtils;

const
  IBX_Version = 7.04;

resourcestring

{ strings gen�ricas utilizadas no c�digo }
  SIBDatabaseEditor = 'Edi&tor de Banco de Dados...';
  SIBTransactionEditor = 'Edi&tor de Transa��o...';
  SDatabaseFilter = 'Arquivos de Banco de Dados (*.gdb)|*.gdb|Todos os arquivos (*.*)|*.*';
  SDisconnectDatabase = 'Banco de Dados est� atualmente conectado. Desconectar e continuar?';
  SCommitTransaction = 'Transa��o est� atualmente ativa. Desfazer e continuar?';
  SExecute = 'E&xecutar';
  SNoDataSet = 'Nenhuma associa��o de dataset';
  SSQLGenSelect = 'Deve selecionar pelo menos um campo chave e um campo update';
  SSQLNotGenerated = 'Indica��es de atualiza��o do SQL n�o geradas, sair mesmo assim?';
  SIBUpdateSQLEditor = 'Editor do &UpdateSQL...';
  SIBDataSetEditor = 'Editor do &Dataset...';
  SSQLDataSetOpen = 'Incapaz de determinar noms de campo para %s';
  SDefaultTransaction = '%s, Padr�o';

{ strings usadas em mensagens de erro }
  SUnknownError = 'Unknown error';
{$IFDEF MSWINDOWS}
  SInterBaseMissing = 'Biblioteca gds32.dll do InterBase n�o encontrada no caminho. Favor instalar InterBase para usar esta funcionalidade';
{$ENDIF}
{$IFDEF LINUX}
  SInterBaseMissing = 'Biblioteca gds.so.0 do InterBase n�o encontrada no caminho. Favor instalar InterBase para usar esta funcionalidade';
{$ENDIF}
  SInterBaseInstallMissing = 'Instalador DLL ibinstall.dll do InterBase n�o encontrado no caminho. Favor instalar InterBase 6 para usar esta funcionalidade';
  SIB60feature = '%s � uma fun��o do InterBase 6. Favor atualizar InterBase 6 para usar esta funcionalidade';
  SNotSupported = 'Caracter�stica n�o suportada';
  SNotPermitted = 'N�o permitido';
  SFileAccessError = 'Erro no acesso ao arquivo tempor�rio';
  SConnectionTimeout = 'Tempo de conex�o com Banco de Dados expirou';
  SCannotSetDatabase = 'N�o � poss�vel ajustar banco de dados';
  SCannotSetTransaction = 'N�o � poss�vel ajustar transa��o';
  SOperationCancelled = 'Opera��o cancelada em requisi��o do usu�rio';
  SDPBConstantNotSupported = 'Constante DPB (isc_dpb_%s) n�o � suportada';
  SDPBConstantUnknown = 'Constante DPB (%d) n�o � conhecida';
  STPBConstantNotSupported = 'Constante TPB (isc_tpb_%s) n�o � suportada';
  STPBConstantUnknown = 'Constante TPB (%d) n�o � conhecida';
  SDatabaseClosed = 'N�o � poss�vel executar opera��o -- DB n�o est� aberto';
  SDatabaseOpen = 'N�o � poss�vel executar opera��o -- DB est� atualmente aberto';
  SDatabaseNameMissing = 'Faltando nome do Banco de Dados';
  SNotInTransaction = 'Transa��o n�o est� ativa';
  SInTransaction = 'Transa��o est� ativa';
  STimeoutNegative = 'Valor de Timeout n�o pode ser negativo';
  SNoDatabasesInTransaction = 'Nenhum banco de dados est� listado no componente da transa��o';
  SUpdateWrongDB = 'Atualizando banco de dados errado';
  SUpdateWrongTR = 'Atualizando transa��o errada. Transa��o �nica esperada no ajuste';
  SDatabaseNotAssigned = 'Banco de dados n�o atribu�do';
  STransactionNotAssigned = 'Transa��o n�o atribu�da';
  SXSQLDAIndexOutOfRange = '�ndice XSQLDA fora da faixa';
  SXSQLDANameDoesNotExist = 'Nome do XSQLDA n�o existe(%s)';
  SEOF = 'Fim do arquivo';
  SBOF = 'In�cio do arquivo';
  SInvalidStatementHandle = 'Indica��o de Handle inv�lida';
  SSQLOpen = 'IBSQL Aberto';
  SSQLClosed = 'IBSQL Fechado';
  SDatasetOpen = 'Dataset aberto';
  SDatasetClosed = 'Dataset fechado';
  SUnknownSQLDataType = 'Tipo de Dados SQL desconhecido (%d)';
  SInvalidColumnIndex = '�ndice da coluna inv�lido (�ndice excedeu a faixa permitida)';
  SInvalidParamColumnIndex = 'Par�metro de �ndice inv�lido (�ndice excedeu a faixa permitida)';
  SInvalidDataConversion = 'Coners�o de dados inv�lida';
  SColumnIsNotNullable = 'Coluna n�o pode ser ajustada para nulo (%s)';
  SBlobCannotBeRead = 'Blob stream n�o p�de ser lido';
  SBlobCannotBeWritten = 'Blob stream n�o p�de ser escrito';
  SEmptyQuery = 'Query vazia';
  SCannotOpenNonSQLSelect = 'N�o � poss�velt "abrir" uma indica��o n�o selecionada. Use ExecQuery';
  SNoFieldAccess = 'Sem acesso ao campo "%s"';
  SFieldReadOnly = 'Campo "%s" est� somente leitura';
  SFieldNotFound = 'Campo "%s" n�o encontrado';
  SNotEditing = 'N�o em modo de edi��o';
  SCannotInsert = 'N�o � poss�vel inserir dentro do dataset. (Nenhuma Query de insert)';
  SCannotPost = 'N�o � poss�vel salvar. (Nenhuma Query de update/insert)';
  SCannotUpdate = 'N�o � poss�vel atualizar. (Nenhuma Query de update)';
  SCannotDelete = 'N�o � poss�vel apagar do dataset. (Nenhuma Query de delete)';
  SCannotRefresh = 'N�o � poss�vel atualizar linha. (Nenhuma Query de refresh)';
  SBufferNotSet = 'Buffer n�o ajustado';
  SCircularReference = 'Refer�ncias circulares n�o permitidas';
  SSQLParseError = 'Erro na an�lise do SQL:' + CRLF + CRLF + '%s';
  SUserAbort = 'Usu�rio cancelou';
  SDataSetUniDirectional = 'Dados ajustado � uni-direcional';
  SCannotCreateSharedResource = 'N�o � poss�vel criar recursos compartilhados. (Erro do Windows %d)';
  SWindowsAPIError = 'Erro na API do Windows. (Erro do Windows %d [$%.8x])';
  SColumnListsDontMatch = 'As listas da coluna n�o combinam';
  SColumnTypesDontMatch = 'Os tipos da coluna n�o combinam. (Do �ndice: %d; Para �ndice: %d)';
  SCantEndSharedTransaction = 'N�o pode terminar uma transa��o compartilhada a menos que for for�ada e igual ' +
                             'para a TimeoutAction da transa��o';
  SFieldUnsupportedType = 'Tipo de Campo n�o Suportado';
  SCircularDataLink = 'Refer�ncia do DataLink Circular';
  SEmptySQLStatement = 'Indica��o do SQL vazia';
  SIsASelectStatement = 'use Open para uma Select Statement';
  SRequiredParamNotSet = 'Valor do Par�metro Requirido n�o ajustado';
  SNoStoredProcName = 'Nenhum Nome de Stored Procedure Name atribu�do';
  SIsAExecuteProcedure = 'use ExecProc para Procedure; use TQuery para Select procedures';
  SUpdateFailed = 'Atualiza��o Falhou';
  SNotCachedUpdates = 'CachedUpdates n�o abilitados';
  SNotLiveRequest = 'Requisi��o n�o est� ativa - n�o � poss�vel modificar';
  SNoProvider = 'Nenhum Provedor';
  SNoRecordsAffected = 'Nenhum Registro Afetado';
  SNoTableName = 'Nenhum Nome de Tabela atribu�do';
  SCannotCreatePrimaryIndex = 'N�o � poss�vel criar �ndice Prim�rio; s�o criados automaticamente';
  SCannotDropSystemIndex = 'N�o � poss�vel "Dropar" �ndice de Sistema';
  STableNameMismatch = 'Nome da Tabela n�o Combina';
  SIndexFieldMissing = 'Faltando Campo de �ndice';
  SInvalidCancellation = 'N�o � poss�vel cancelar eventos enquanto est� processando';
  SInvalidEvent = 'Evento Inv�lido';
  SMaximumEvents = 'Limite M�ximo de Eventos Ultrapassado';
  SNoEventsRegistered = 'Nenhum Evento Registrado';
  SInvalidQueueing = 'Queueing Inv�lido';
  SInvalidRegistration = 'Registro Inv�lido';
  SInvalidBatchMove = 'Batch Move Inv�lido';
  SSQLDialectInvalid = 'SQL Dialect Inv�lido';
  SSPBConstantNotSupported = 'Constante SPB n�o suportada';
  SSPBConstantUnknown = 'Constante SPB Desconhecida';
  SServiceActive = 'N�o � poss�vel executar opera��o -- servi�o n�o est� anexado';
  SServiceInActive = 'N�o � poss�vel executar opera��o -- servi�o est� anexado';
  SServerNameMissing = 'Faltando Nome do Servidor';
  SQueryParamsError = 'Par�metros da Query faltando ou incorreto';
  SStartParamsError = 'in�cio de Par�metros faltando ou incorreto';
  SOutputParsingError = 'Valor de Output buffer n�o esperado';
  SUseSpecificProcedures = 'ServiceStart Gen�rico n�o aplic�vel: Use Procedures Espec�ficas para ajustar os par�metros da configura��o';
  SSQLMonitorAlreadyPresent = 'Inst�ncia do SQL Monitor j� est� presente';
  SCantPrintValue = 'N�o � poss�vel imprimir valor';
  SEOFReached = 'SEOFReached';
  SEOFInComment = 'Fim do coment�rio detectado';
  SEOFInString = 'Fim da string detectada';
  SParamNameExpected = 'Nome do par�metro esperado';
  SSuccess = 'Execu��o bem sucedida';
  SDelphiException = 'DelphiException %s';
  SNoOptionsSet = 'Nenhuma Op��o de Instala��o selecionada';
  SNoDestinationDirectory = 'Faltando DestinationDirectory';
  SNosourceDirectory = 'Faltando SourceDirectory';
  SNoUninstallFile = 'Faltando Nome do Arquivo de Desinstala��o';
  SOptionNeedsClient = '%s o componente requer o cliente para funcionar corretamente';
  SOptionNeedsServer = '%s o componente requer o servidor para funcionar corretamente';
  SInvalidOption = 'Op��o especificada inv�lida';
  SInvalidOnErrorResult = 'Retorno do valor onError n�o esperado';
  SInvalidOnStatusResult = 'Retorno do valor onStatus n�o esperado';

  SInterbaseExpressVersion = 'InterbaseExpress 4.3';
  SEditSQL = 'Editar SQL';
  SDPBConstantUnknownEx = 'Constante DPB (%s) � desconhecida';
  STPBConstantUnknownEx = 'Constante TPB (%s) � desconhecida';
  SInterbaseExpressVersionEx = 'InterbaseExpress %g';
  SUnknownPlan = 'Erro Desconhecido - N�o � poss�vel recuperar o mapeamento';
  SFieldSizeMismatch = 'Tamanho N�o Combina - Tamanho do Campo %s � muito pequeno para o dado';
  SEventAlreadyRegistered   = 'Eventos j� registrados';
  SStringTooLarge = 'Tentando armazenar uma string de comprimento %d dentro de uma campo que pode somente conter %d';
  SIBServiceEditor = 'Editor de &Service ...';
  SIBSuccessConnect = 'Conex�o Bem Sucedida';
  SNoTimers = 'Temporizadores dispon�veis n�o bastam';
  SIB65feature = '%s � uma fun��o do InterBase 6.5. Por favor atualize para o InterBase 6.5 para usar esta fun��o.';
  SLoginPromptFailure = 'N�o pode achar o login default no caixa de di�logo.  Por favor adicione DBLogDlg na se��o uses de seu arquivo principal.';
  SIBMemoryError = 'Erro de mem�ria';
  SIBInvalidStatement = 'Declara��o inv�lida';
  SIBInvalidComment = 'Coment�rio inv�lido';
  SIBBrokerOpen = 'Abrindo a conex�o ';
  SIBBrokerVersion = 'Iniciando IBConnectionBroker vers�o 1.0.1:';
  SIBBrokerDatabase = 'Nome do banco de dados = ';
  SIBBrokerUser = 'Nome do usu�rio = ';
  SIBBrokerMinConnections = 'Min Conex�es = ';
  SIBBrokerMaxConnections = 'Max Conex�es = ';
  SIBBrokerIdleTimer = 'IdleTimer = ';
  SIBBrokerGiveOut = 'Conex�o finalizada';
  SIBBrokerUnavailable = 'Impossibilitado de criar nova conex�o: ';
  SIBBrokerExhausted = '-----> Conex�es excedidas!  Espere e tente novamente em seguida';
  SIBBrokerNilError = 'Tentativa de ocorr�ncia em base de dados vazia';
  SIBBrokerRelease = 'Liberando conex�o';
  SIBDatabaseINISection = 'Par�metros do banco de dados';
  SIBDatabaseINISectionEmpty = 'O nome da se��o n�o pode ser vazia';
implementation

end.
 