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

unit DoGAVUnit ;

interface
Uses Classes, TypInfo, SysUtils, CmdUnit ;

Procedure DoGAV( Cmd : TACBrCmd ) ;

implementation
uses ACBrGAV, ACBrUtil, StrUtils,
  {$IFNDEF CONSOLE}ACBrMonitor1 {$ELSE}ACBrMonitorConsoleDM {$ENDIF} ;

Procedure DoGAV( Cmd : TACBrCmd ) ;
begin
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrGAV1  {$ELSE}dm.ACBrGAV1  {$ENDIF} do
  begin
     try
        if Cmd.Metodo = 'ativar' then  { Ativa a Gaveta }
         begin
           Ativar ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.AvaliaEstadoTsGAV ;{$ENDIF}
         end

        else if Cmd.Metodo = 'desativar' then
         begin
           Desativar ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.AvaliaEstadoTsGAV ;{$ENDIF}
         end

        else if Cmd.Metodo = 'ativo' then
           Cmd.Resposta := BoolToStr(Ativo, true)

        else if Cmd.Metodo = 'modelostr' then
           Cmd.Resposta := ModeloStr

        else if Cmd.Metodo = 'modelo' then
           Cmd.Resposta := GetEnumName(TypeInfo(TACBrGAVModelo),Integer(Modelo))

        else if Cmd.Metodo = 'porta' then
           Cmd.Resposta := Porta

        else if Cmd.Metodo = 'abregaveta' then
           AbreGaveta

        else if Cmd.Metodo = 'gavetaaberta' then
           Cmd.Resposta := BoolToStr( GavetaAberta, true )

        else if Cmd.Metodo = 'strcomando' then
           Cmd.Resposta := StrComando

        else if Cmd.Metodo = 'setstrcomando' then
         begin
           StrComando := Cmd.Params(0) ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.cbGAVStrAbre.Text := StrComando ;{$ENDIF}
         end

        else if Cmd.Metodo = 'aberturaintervalo' then
           Cmd.Resposta := IntToStr( AberturaIntervalo )

        else if Cmd.Metodo = 'setaberturaintervalo' then
         begin
           AberturaIntervalo := StrToIntDef( Cmd.Params(0), AberturaIntervalo) ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.sedGAVIntervaloAbertura.Value := AberturaIntervalo ;{$ENDIF}
         end

        ELSE
           raise Exception.Create('Comando inv�lido ('+Cmd.Comando+')') ;

     finally
        { Nada a fazer aqui por enquanto... :) }
     end ;
  end ;
end ;

end.


