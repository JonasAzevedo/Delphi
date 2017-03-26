
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

  SServiceOnly = 'O servidor do soquete pode somente ser executado como um serviço no NT 3.51 ou anterior';
  SErrClose = 'Não pode sair enquanto existirem conexões ativas. Fechar as conexões?';
  SErrChangeSettings = 'Não pode mudar ajustes enquanto houverem conexões ativas. Fechar as conexões?';
  SQueryDisconnect = 'Desconectar clientes pode causar erros da aplicação. Continuar?';
  SOpenError = 'Erro abrindo porta %d com erro: %s';
  SHostUnknown = '(Desconhecido)';
  SNotShown = '(Não Mostrado)';
  SNoWinSock2 = 'WinSock 2 deve estar instalado para usar o soquete de conexão';
  SStatusline = '%d conexões correntes';
  SAlreadyRunning = 'O Servidor do Soquete já está executando';
  SNotUntilRestart = 'Esta alteração não tera efeito até que o Servidor do Soquete seja reiniciado';

implementation

end.
 