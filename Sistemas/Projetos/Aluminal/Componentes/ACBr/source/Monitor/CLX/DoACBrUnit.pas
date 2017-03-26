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

{$DEFINE VisualCLX}
{$I ACBr.inc}

unit DoACBrUnit ;

interface
Uses Classes, TypInfo, SysUtils, CmdUnit, Types ;
{$IFDEF MSWINDOWS}
  function BlockInput (fBlockInput: boolean): dword; stdcall; external 'user32.dll';
{$ENDIF}

Procedure DoACBr( Cmd : TACBrCmd ) ;

implementation
Uses ACBrUtil, StrUtils, DateUtils,
  {$IFDEF MSWINDOWS}sndkey32, {$ENDIF}
  {$IFNDEF CONSOLE}QForms, ACBrMonitor1 {$ELSE}ACBrMonitorConsoleDM {$ENDIF} ;

Procedure DoACBr( Cmd : TACBrCmd ) ;
Var AltTab : Boolean ;
    Memo   : TStringList ;
    dtFim  : TDateTime ;
    nWait  : Integer ;
begin
  with {$IFNDEF CONSOLE}FrmACBrMonitor{$ELSE}dm{$ENDIF} do
  begin
     try
        if Cmd.Metodo = 'run' then
         begin
           {$IFNDEF CONSOLE}
             if not cbComandos.Checked then
           {$ELSE}
             if not PermiteComandos then
           {$ENDIF}
              raise Exception.Create('Comandos Remotos n�o s�o permitidos');

           if Cmd.Params(0) = '' then
              raise Exception.Create('Linha de comando n�o informada');

           AltTab := StrToBoolDef(Cmd.Params(4),False) ; { Envia ALT-TAB quando Terminar ?}
           RunCommand( Cmd.Params(0),                       { Linha de comando }
                       Cmd.Params(1),                       { Parametros adicionais }
                       StrToBoolDef(Cmd.Params(2),False) or AltTab , { Aguarda termino execu�ao ? }
                       StrToIntDef(Cmd.Params(3),1));
           {$IFDEF MSWINDOWS}
           if AltTab then
              SendKeys(pchar('%{TAB}'), False);
           {$ENDIF}
         end

        {$IFNDEF CONSOLE}
          else if Cmd.Metodo = 'restaurar' then
             Restaurar1Click( FrmACBrMonitor )

          else if Cmd.Metodo = 'ocultar' then
             Ocultar1Click( FrmACBrMonitor )

          else if Cmd.Metodo = 'encerrarmonitor' then
             Application.Terminate
        {$ENDIF}

        else if Cmd.Metodo = 'savetofile' then
         begin
           {$IFNDEF CONSOLE}
             if not cbComandos.Checked then
           {$ELSE}
             if not PermiteComandos then
           {$ENDIF}
              raise Exception.Create('Comandos Remotos n�o s�o permitidos');

           Memo := TStringList.Create ;
           try
              Memo.Clear ;
              Memo.Text := cmd.Params(1);
              Memo.SaveToFile(Cmd.Params(0));
           finally
              Memo.Free ;
           end ;
         end

        {$IFDEF MSWINDOWS}
         else if Cmd.Metodo = 'appactivate' then
          begin
            nWait := StrToInt( Cmd.Params(1) ) ;
            if nWait > 0 then
               Sleep(nWait);
            AppActivate( PChar(Cmd.Params(0)) ) ;
          end

         else if Cmd.Metodo = 'blockinput' then
           BlockInput( StrToBool(Cmd.Params(0)) )
        {$ENDIF}

        else if Cmd.Metodo = 'loadfromfile' then
         begin
           {$IFNDEF CONSOLE}
             if not cbComandos.Checked then
           {$ELSE}
             if not PermiteComandos then
           {$ENDIF}
              raise Exception.Create('Comandos Remotos n�o s�o permitidos');

           dtFim := IncSecond(now, StrToIntDef(Cmd.Params(1),1) ) ;
           while now <= dtFim do
           begin
              if FileExists( Cmd.Params(0) ) then
              begin
                 Memo  := TStringList.Create ;
                 try
                    Memo.Clear ;
                    Memo.LoadFromFile( Cmd.Params(0) ) ;
                    Cmd.Resposta := Memo.Text ;
                    Break ;
                 finally
                    Memo.Free ;
                 end ;
              end ;

              sleep(50) ;
           end ;

           if not FileExists( Cmd.Params(0) ) then
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' n�o encontrado')
         end

        else if Cmd.Metodo = 'deletefiles' then
         begin
           {$IFNDEF CONSOLE}
             if not cbComandos.Checked then
           {$ELSE}
             if not PermiteComandos then
           {$ENDIF}
              raise Exception.Create('Comandos Remotos n�o s�o permitidos');

           DeleteFiles( Cmd.Params(0) ) ;
         end

        else if pos('|'+Cmd.Metodo+'|', '|exit|bye|fim|sair|') > 0 then {fecha conexao}
         begin
           Cmd.Resposta := 'Obrigado por usar o ACBrMonitor' ;
           {$IFNDEF CONSOLE}
             mCmd.Lines.Clear;
           {$ELSE}
             WriteLn( 'Obrigado por usar o ACBrMonitorConsole' ) ;
           {$ENDIF}

           if Assigned( Conexao ) then
              if Assigned( Conexao.Connection ) then
                 Conexao.Connection.Disconnect ;
         end

        ELSE
           raise Exception.Create('Comando inv�lido ('+ copy(Cmd.Comando,6,length(Cmd.Comando))+')') ;

     finally
        { Nada a fazer aqui por enquanto... :) }
     end ;
  end ;
end ;

end.


