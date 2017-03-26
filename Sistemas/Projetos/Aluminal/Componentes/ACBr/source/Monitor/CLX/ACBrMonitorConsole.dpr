{******************************************************************************}
{ Projeto: ACBr Monitor                                                        }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para }
{ criar uma interface de comunica��o com equipamentos de automacao comercial.  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2006 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na p�gina do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Este programa � software livre; voc� pode redistribu�-lo e/ou modific�-lo   }
{ sob os termos da Licen�a P�blica Geral GNU, conforme publicada pela Free     }
{ Software Foundation; tanto a vers�o 2 da Licen�a como (a seu crit�rio)       }
{ qualquer vers�o mais nova.                                                   }
{                                                                              }
{  Este programa � distribu�do na expectativa de ser �til, mas SEM NENHUMA     }
{ GARANTIA; nem mesmo a garantia impl�cita de COMERCIALIZA��O OU DE ADEQUA��O A}
{ QUALQUER PROP�SITO EM PARTICULAR. Consulte a Licen�a P�blica Geral GNU para  }
{ obter mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)                    }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral GNU junto com este}
{ programa; se n�o, escreva para a Free Software Foundation, Inc., 59 Temple   }
{ Place, Suite 330, Boston, MA 02111-1307, USA. Voc� tamb�m pode obter uma     }
{ copia da licen�a em:  http://www.opensource.org/licenses/gpl-license.php     }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}
program ACBrMonitorConsole;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes, IniFiles,
  {$IFDEF LINUX} Libc, {$ENDIF}
  ACBrBase, ACBrUtil, ACBrECF, ACBrECFNaoFiscal, UtilUnit,
  DoECFBemafi32, DoECFObserver, // Units de tradu��o dos comandos
  IdStack,
  ACBrMonitorConsoleDM in 'ACBrMonitorConsoleDM.pas' {dm: TDataModule};

Var I : Integer;
    ArqINI : String ;
    Ini    : TIniFile ;

{$IFDEF LINUX}
procedure SignalProc(SigNum: Integer); cdecl;
 Var LogMsg : String ;
begin
  LogMsg := 'Sinal: ' ;

  case SigNum of
     SIGINT  :
        LogMsg := LogMsg + 'SIGINT' ;
     SIGSTOP :
        LogMsg := LogMsg + 'SIGSTOP' ;
     SIGTSTP :
        LogMsg := LogMsg + 'SIGTSTP' ;
     SIGQUIT :
        LogMsg := LogMsg + 'SIGQUIT' ;
  else
     LogMsg := LogMsg + IntToStr(SigNum) ;
  end;

  WriteLn( LogMsg );
  if dm.GravarLog then
      WriteToTXT(dm.ArqLogTXT, LogMsg );
end;
{$ENDIF}

begin
  {$IFDEF LINUX}
   signal(SIGINT , SignalProc); // catch the signal SIGINT  to procedure SignalProc
   signal(SIGSTOP, SignalProc); // catch the signal SIGSTOP to procedure SignalProc
   signal(SIGTSTP, SignalProc); // catch the signal SIGTSTP to procedure SignalProc
   signal(SIGQUIT, SignalProc); // catch the signal SIGQUIT to procedure SignalProc

   umask( 0 ) ;
  {$ENDIF}

  { Definindo constantes de Verdadeiro para TrueBoolsStrs }
  SetLength( TrueBoolStrs, 5 ) ;
  TrueBoolStrs[0] := DefaultTrueBoolStr;
  TrueBoolStrs[1] := 'T' ;
  TrueBoolStrs[2] := 'Verdadeiro' ;
  TrueBoolStrs[3] := 'V' ;
  TrueBoolStrs[4] := 'Ok' ;

  { Definindo constantes de Falso para FalseBoolStrs }
  SetLength(FalseBoolStrs, 3);
  FalseBoolStrs[0] := DefaultFalseBoolStr;
  FalseBoolStrs[1] := 'F' ;
  FalseBoolStrs[2] := 'Falso' ;

  { ---------------- Inicializando as variaveis ---------------- }
  TRY
    dm := Tdm.Create(nil);

    writeln('Bem vindo ao ACBrMonitorConsole '+Versao+' - ACBr: '+ACBR_VERSAO ) ;
    writeln('') ;

    try
       { Lendo o arquivo INI. Se houver erro, dispara exception }
       dm.LerIni ;

       { Ajustando o tamanho do arquivo de LOG }
       try
          dm.AjustaLinhasLog ;
       except
          on E : Exception do
             WriteLn( E.Message ) ;
       end ;

       { Ativando comunicacao TCP/IP } 
       dm.TcpServer.Active := dm.IsTCP ;
       WriteLn('ACBr Monitor Ver.'+Versao);
       WriteLn('Aguardando comandos ACBr');

       { Exibindo estado atual e finalizando a inicializacao }
       try
          if dm.IsTCP then
           begin
             if dm.TcpServer.Active then
             begin
                try
                   WriteLn( 'Endere�o: '+dm.TcpServer.LocalName ) ;
                   For I := 0 to IdStack.GStack.LocalAddresses.Count-1 do
                      WriteLn( IdStack.GStack.LocalAddresses[I] ) ;
                except
                end ;
                WriteLn( 'Porta: ['+IntToStr(dm.TcpServer.DefaultPort)+']') ;
             end ;
           end
          else
           begin
             WriteLn( 'Monitorando TXT em: '+dm.ArqEntTXT);
             WriteLn( 'Respostas gravadas em:'+dm.ArqSaiTXT);
           end ;

          if dm.GravarLog then
             WriteLn( 'Log de comandos ser� gravado em: '+dm.ArqLogTXT) ;

          { Se for NAO fiscal, desliga o AVISO antes de ativar }
          if dm.ACBrECF1.Modelo = ecfNaoFiscal then
          begin
             ArqIni := (dm.ACBrECF1.ECF as TACBrECFNaoFiscal).NomeArqINI ;
             if FileExists( ArqIni ) then
             begin
                Ini := TIniFile.Create( ArqIni ) ;
                try
                  Ini.WriteString('Variaveis','Aviso_Legal','NAO');
               finally
                  Ini.Free ;
               end ;
             end ;
          end ;
       except
          on E : Exception do
             WriteLn( E.Message ) ;
       end ;

       { Loop INFINITO, esperando arquivo TXT }
       repeat
          if FileExists( dm.ArqEntTXT ) then  { Existe arquivo para ler ? }
          begin
             try
               dm.TipoCMD := 'A' ;
               if ( UpperCase(ExtractFileName( dm.ArqEntTXT )) = 'BEMAFI32.CMD' ) then
                  dm.TipoCMD := 'B'
               else if ( UpperCase(ExtractFileName( dm.ArqEntTXT )) = 'DARUMA.CMD' ) then
                  dm.TipoCMD := 'D' ;

               dm.ComandosAProcessar.LoadFromFile( dm.ArqEntTXT );
               DeleteFile( dm.ArqEntTXT );

               if dm.TipoCMD = 'B' then
                  dm.ComandosAProcessar.Text := TraduzBemafi( dm.ComandosAProcessar.Text )
               else if dm.TipoCMD = 'D' then
                  dm.ComandosAProcessar.Text := TraduzObserver( dm.ComandosAProcessar.Text ) ;

             except
               { Ignora Exce�oes na Tentativa de Leitura o Dele�ao }
             end ;

             dm.Processar ;
          end;

          Sleep( dm.Intervalo ) ;
          
       until False ;

    finally
       dm.ACBrECF1.Desativar ;
       dm.ACBrCHQ1.Desativar ;
       dm.ACBrGAV1.Desativar ;
       dm.ACBrDIS1.Desativar ;
       dm.ACBrLCB1.Desativar ;

       dm.TcpServer.OnDisconnect := nil ;
       dm.TCPServer.Active       := False ;    { Desliga TCP }

       dm.Free ;
    end ;
  EXCEPT
    On E : Exception do
    begin
       if dm.GravarLog then
          WriteToTXT(dm.ArqLogTXT, 'Exception: ' + E.Message);

       raise ;
    end ;
  END ;

end.

