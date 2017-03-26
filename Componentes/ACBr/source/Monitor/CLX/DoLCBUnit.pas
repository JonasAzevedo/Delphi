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

unit DoLCBUnit ;

interface
Uses Classes, TypInfo, SysUtils, CmdUnit ;

Procedure DoLCB( Cmd : TACBrCmd ) ;

implementation
uses ACBrLCB, ACBrUtil, StrUtils,
  {$IFNDEF CONSOLE}ACBrMonitor1 {$ELSE}ACBrMonitorConsoleDM {$ENDIF} ;

Procedure DoLCB( Cmd : TACBrCmd ) ;
begin
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrLCB1 {$ELSE}dm.ACBrLCB1 {$ENDIF} do
  begin
     try
        if Cmd.Metodo = 'ativar' then  { Ativa o Leitor }
           Ativar

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

        else if Cmd.Metodo = 'lerfila' then
           Cmd.Resposta := LerFila

        else if Cmd.Metodo = 'apagarfila' then
           ApagarFila

        else if Cmd.Metodo = 'filacount' then
           Cmd.Resposta := IntToStr( FilaCount )

        else if Cmd.Metodo = 'prefixoaexcluir' then
           Cmd.Resposta := PrefixoAExcluir

        else if Cmd.Metodo = 'setprefixoaexcluir' then
         begin
           PrefixoAExcluir := Cmd.Params(0) ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.edLCBPreExcluir.Text := PrefixoAExcluir ;{$ENDIF}
         end

        else if Cmd.Metodo = 'sufixo' then
           Cmd.Resposta := Sufixo

        else if Cmd.Metodo = 'setsufixo' then
         begin
           Sufixo := Cmd.Params(0) ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.cbLCBSufixoLeitor.Text := Sufixo ;{$ENDIF}
         end

        else if Cmd.Metodo = 'excluirsufixo' then
           Cmd.Resposta := BoolToStr( ExcluirSufixo )

        else if Cmd.Metodo = 'setexcluirsufixo' then
         begin
           ExcluirSufixo := StrToBool( Cmd.Params(0) ) ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.chLCBExcluirSufixo.Checked := ExcluirSufixo ;{$ENDIF}
         end

        else if Cmd.Metodo = 'usarfila' then
           Cmd.Resposta := BoolToStr( UsarFila )

        else if Cmd.Metodo = 'setusarfila ' then
         begin
           UsarFila := StrToBool( Cmd.Params(0) ) ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.rbLCBFila.Checked := UsarFila ;{$ENDIF}
         end

        else if Cmd.Metodo = 'filamaxitens' then
           Cmd.Resposta := IntToStr( FilaMaxItens )

        else if Cmd.Metodo = 'setfilamaxitens' then
         begin
            FilaMaxItens := StrToInt( Cmd.Params(0) ) ;
//          FrmACBrMonitor.sedLCBFilaMaxItens.Value := FilaMaxItens ;
         end

        else if Cmd.Metodo = 'ultimaleitura' then
           Cmd.Resposta := UltimaLeitura

        else if Cmd.Metodo = 'ultimocodigo' then
           Cmd.Resposta := UltimoCodigo

        else if Cmd.Metodo = 'enviarstring' then
            EnviarString( Cmd.Params(0) )

        else if Cmd.Metodo = 'lerstring' then
           Cmd.Resposta := LerString 

        ELSE
           raise Exception.Create('Comando inv�lido ('+Cmd.Comando+')') ;

     finally
        { Nada a fazer aqui por enquanto... :) }
     end ;
  end ;
end ;

end.

