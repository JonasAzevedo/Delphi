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

unit DoCHQUnit ;

interface
Uses Classes, TypInfo, SysUtils, CmdUnit ;

Procedure DoCHQ( Cmd : TACBrCmd ) ;

implementation
uses ACBrCHQ, ACBrUtil, StrUtils, DoECFUnit,
  {$IFNDEF CONSOLE}ACBrMonitor1 {$ELSE}ACBrMonitorConsoleDM {$ENDIF} ;

Procedure DoCHQ( Cmd : TACBrCmd ) ;
Var Linhas : TStringList ;

begin
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrCHQ1 {$ELSE}dm.ACBrCHQ1 {$ENDIF} do
  begin
     try
        if Cmd.Metodo = 'ativar' then  { Ativa a Impress.Cheque }
           Ativar

        else if Cmd.Metodo = 'desativar' then
           Desativar 

        else if Cmd.Metodo = 'ativo' then
           Cmd.Resposta := BoolToStr(Ativo, true)

        else if Cmd.Metodo = 'modelostr' then
           Cmd.Resposta := ModeloStr

        else if Cmd.Metodo = 'modelo' then
           Cmd.Resposta := GetEnumName(TypeInfo(TACBrCHQModelo),Integer(Modelo))

        else if Cmd.Metodo = 'porta' then
           Cmd.Resposta := Porta

        else if Cmd.Metodo = 'chequepronto' then
           Cmd.Resposta := BoolToStr(ChequePronto, true)

        else if Cmd.Metodo = 'banco' then
           Cmd.Resposta := Banco

        else if Cmd.Metodo = 'setbanco' then
           Banco := Cmd.Params(0)

        else if Cmd.Metodo = 'cidade' then
           Cmd.Resposta := Cidade

        else if Cmd.Metodo = 'setcidade' then
         begin
           Cidade := Cmd.Params(0) ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.edCHQCidade.Text := Cidade ;{$ENDIF}
         end

        else if Cmd.Metodo = 'favorecido' then
           Cmd.Resposta := Favorecido

        else if Cmd.Metodo = 'setfavorecido' then
         begin
           Favorecido := Cmd.Params(0) ;
           {$IFNDEF CONSOLE}FrmACBrMonitor.edCHQFavorecido.Text := Favorecido ;{$ENDIF}
         end

        else if Cmd.Metodo = 'observacao' then
           Cmd.Resposta := Observacao

        else if Cmd.Metodo = 'setobservacao' then
           Observacao := Cmd.Params(0)

        else if Cmd.Metodo = 'valor' then
           Cmd.Resposta := FloatToStr(Valor) 

        else if Cmd.Metodo = 'setvalor' then
           Valor := StringToFloat( Cmd.Params(0) )

        else if Cmd.Metodo = 'data' then
           Cmd.Resposta := FormatDateTime('dd/mm/yy', Data )

        else if Cmd.Metodo = 'setdata' then
           Data := StringToDateTime( Cmd.Params(0) )

        else if Cmd.Metodo = 'imprimircheque' then
         begin
           {$IFNDEF CONSOLE}
             if FrmACBrMonitor.chCHQVerForm.Checked and (not ChequePronto) then
           {$ELSE}
             if dm.VerificaCheque then
           {$ENDIF}
              raise Exception.Create('Formul�rio de Cheque n�o posicionado');
              
           ImprimirCheque ;
         end

        else if Cmd.Metodo = 'travarcheque' then
           TravarCheque

        else if Cmd.Metodo = 'destravarcheque' then
           DestravarCheque

        else if Cmd.Metodo = 'imprimirlinha' then
           ImprimirLinha( Cmd.Params(0) )

        else if Cmd.Metodo = 'imprimirverso' then
         begin
           Linhas := TStringList.Create ;
           try
              StringToMemo( Cmd.Params(0), Linhas ); {Linha separadas por | (pipe)}
              ImprimirVerso( Linhas );
           finally
              Linhas.Free ;
           end ;
         end
         
        ELSE
           raise Exception.Create('Comando inv�lido ('+Cmd.Comando+')') ;

     finally
        { Nada a fazer aqui por enquanto... :) }
     end ;
  end ;
end ;

end.

