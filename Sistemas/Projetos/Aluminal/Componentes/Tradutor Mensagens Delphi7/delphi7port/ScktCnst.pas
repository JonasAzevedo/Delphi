
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{       Copyright (c) 1997,99 Inprise Corporation       }
{                                                       }
{*******************************************************}

unit ScktCnst;

interface

const
  //Do not localize
  KEY_SOCKETSERVER  = '\SOFTWARE\Borland\Socket Server';
  KEY_IE            = 'SOFTWARE\Microsoft\Internet Explorer';
  csSettings        = 'Settings';
  ckPort            = 'Port';
  ckThreadCacheSize = 'ThreadCacheSize';
  ckInterceptGUID   = 'InterceptGUID';
  ckShowHost        = 'ShowHost';
  ckTimeout         = 'Timeout';
  ckRegistered      = 'RegisteredOnly';
  SServiceName      = 'SocketServer';
  SApplicationName  = 'Borland Socket Server';

resourcestring

  SServiceOnly = 'O servidor do soquete pode somente ser executado como um servi�o no NT 3.51 ou anterior';
  SErrClose = 'N�o pode sair enquanto existirem conex�es ativas. Fechar as conex�es?';
  SErrChangeSettings = 'N�o pode mudar ajustes enquanto houverem conex�es ativas. Fechar as conex�es?';
  SQueryDisconnect = 'Desconectar clientes pode causar erros da aplica��o. Continuar?';
  SOpenError = 'Erro abrindo porta %d com erro: %s';
  SHostUnknown = '(Desconhecido)';
  SNotShown = '(N�o Mostrado)';
  SNoWinSock2 = 'WinSock 2 deve estar instalado para usar o soquete de conex�o';
  SStatusline = '%d conex�es correntes';
  SAlreadyRunning = 'O Servidor do Soquete j� est� executando';
  SNotUntilRestart = 'Esta altera��o n�o tera efeito at� que o Servidor do Soquete seja reiniciado';

implementation

end.
 