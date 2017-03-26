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

unit DoBALUnit ;

interface
Uses Classes, TypInfo, SysUtils, CmdUnit ;

Procedure DoBAL( Cmd : TACBrCmd ) ;

implementation
uses ACBrBAL, ACBrUtil, StrUtils,
  {$IFNDEF CONSOLE}ACBrMonitor1 {$ELSE}ACBrMonitorConsoleDM {$ENDIF} ;

Procedure DoBAL( Cmd : TACBrCmd ) ;
begin
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrBAL1 {$ELSE}dm.ACBrBAL1 {$ENDIF} do
  begin
     try
        if Cmd.Metodo = 'ativar' then begin { Ativa a Balan�a }
           Ativar ;

           LePeso ;
           if UltimaResposta = '' then begin
              Desativar ;
              raise Exception.Create('Balan�a n�o responde!') ;
           end ;
        end

        else if Cmd.Metodo = 'desativar' then
           Desativar

        else if Cmd.Metodo = 'ativo' then
           Cmd.Resposta := BoolToStr(Ativo, true)

        else if Cmd.Metodo = 'porta' then
           Cmd.Resposta := Porta

        else if Cmd.Metodo = 'intervalo' then
           Cmd.Resposta := IntToStr( Intervalo )

        else if Cmd.Metodo = 'setintervalo' then
           Intervalo := StrToInt( Cmd.Params(0) )

        else if Cmd.Metodo = 'lepeso' then begin
           LePeso;
           if UltimaResposta <> '' then
              Cmd.Resposta := Format('%f', [UltimoPesoLido])
           else
              raise Exception.Create('Timeout');
        end

        else if Cmd.Metodo = 'ultimopesolido' then
           Cmd.Resposta := Format('%f', [UltimoPesoLido])

        ELSE
           raise Exception.Create('Comando inv�lido ('+Cmd.Comando+')') ;

     finally
        { Nada a fazer aqui por enquanto... :) }
     end ;
  end ;
end ;

end.

