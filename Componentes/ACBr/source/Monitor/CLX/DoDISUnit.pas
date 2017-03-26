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

unit DoDISUnit ;

interface
Uses Classes, TypInfo, SysUtils, CmdUnit,
  {$IFNDEF CONSOLE}ACBrMonitor1 {$ELSE}ACBrMonitorConsoleDM {$ENDIF} ;


Procedure DoDIS( Cmd : TACBrCmd ) ;

implementation
uses ACBrDIS, ACBrUtil, StrUtils;

Procedure DoDIS( Cmd : TACBrCmd ) ;
begin
  with {$IFNDEF CONSOLE}FrmACBrMonitor.ACBrDIS1 {$ELSE}dm.ACBrDIS1 {$ENDIF} do
  begin
     {$IFNDEF CONSOLE}FrmACBrMonitor.{$ELSE}dm.{$ENDIF}DISWorking := True ;
     try
        if Cmd.Metodo = 'ativar' then  { Ativa o Display }
           Ativar

        else if Cmd.Metodo = 'desativar' then
           Desativar 

        else if Cmd.Metodo = 'ativo' then
           Cmd.Resposta := BoolToStr(Ativo, true)

        else if Cmd.Metodo = 'modelostr' then
           Cmd.Resposta := ModeloStr

        else if Cmd.Metodo = 'modelo' then
           Cmd.Resposta := GetEnumName(TypeInfo(TACBrDISModelo),Integer(Modelo))

        else if Cmd.Metodo = 'porta' then
           Cmd.Resposta := Porta

        else if Cmd.Metodo = 'trabalhando' then
           Cmd.Resposta := BoolToStr( Trabalhando, true )

        else if Cmd.Metodo = 'linhascount' then
           Cmd.Resposta := IntToStr( LinhasCount )

        else if Cmd.Metodo = 'setlinhascount' then
           LinhasCount := StrToInt( Cmd.Params(0) )

        else if Cmd.Metodo = 'colunas' then
           Cmd.Resposta := IntToStr( Colunas )

        else if Cmd.Metodo = 'setcolunas' then
           Colunas := StrToInt( Cmd.Params(0) )

        else if Cmd.Metodo = 'alinhamento' then
           Cmd.Resposta := GetEnumName(TypeInfo(TACBrDISAlinhamento),Integer(Alinhamento))

        else if Cmd.Metodo = 'setalinhamento' then
           Alinhamento := TACBrDISAlinhamento( GetEnumValue(
                                  TypeInfo(TACBrDISAlinhamento),Cmd.Params(0)))

        else if Cmd.Metodo = 'intervalo' then
           Cmd.Resposta := IntToStr( Intervalo )

        else if Cmd.Metodo = 'setintervalo' then
           Intervalo := StrToInt( Cmd.Params(0) )

        else if Cmd.Metodo = 'passos' then
           Cmd.Resposta := IntToStr( Passos )

        else if Cmd.Metodo = 'setpassos' then
           Passos := StrToInt( Cmd.Params(0) )

        else if Cmd.Metodo = 'limpardisplay' then
           LimparDisplay

        else if Cmd.Metodo = 'escrever' then
           Escrever( Cmd.Params(0) )                                   { AText }

        else if Cmd.Metodo = 'posicionarcursor' then
           PosicionarCursor( StrToInt( Cmd.Params(0) ),                { Linha }
                             StrToInt( Cmd.Params(1) ) )              { Coluna }

        else if Cmd.Metodo = 'parar' then
           Parar

        else if Cmd.Metodo = 'continuar' then
           Continuar

        else if Cmd.Metodo = 'pararlinha' then
           PararLinha( StrToInt(Cmd.Params(0)) )

        else if Cmd.Metodo = 'continuarlinha' then
           ContinuarLinha( StrToInt(Cmd.Params(0)) )

        else if Cmd.Metodo = 'exibirlinha' then
         begin
           if Cmd.Params(2) <> '' then                     // Tem 3 Parametros ?
            begin
              if LowerCase(copy(Cmd.Params(2),1,3)) = 'efe' then     // Efeito ?
                 ExibirLinha( StrToInt(Cmd.Params(0)) ,                { Linha }
                              Cmd.Params(1),                           { AText }
                   TACBrDISEfeitoExibir( GetEnumValue(
                                TypeInfo(TACBrDISEfeitoExibir),Cmd.Params(2))))
              else                                                // Alinhamento
                 ExibirLinha( StrToInt(Cmd.Params(0)) ,                { Linha }
                              Cmd.Params(1),                           { AText }
                   TACBrDISAlinhamento( GetEnumValue(
                                  TypeInfo(TACBrDISAlinhamento),Cmd.Params(2))))
            end
           else
              ExibirLinha( StrToInt(Cmd.Params(0)) ,                   { Linha }
                           Cmd.Params(1))                              { AText }
         end

        else if Cmd.Metodo = 'rolarlinha' then
           RolarLinha( StrToInt(Cmd.Params(0)) ,                       { Linha }
              TACBrDISEfeitoRolar( GetEnumValue(TypeInfo(TACBrDISEfeitoRolar),
                                   Cmd.Params(1) )) )
        ELSE
           raise Exception.Create('Comando inv�lido ('+Cmd.Comando+')') ;

     finally
     {$IFNDEF CONSOLE}FrmACBrMonitor.{$ELSE}dm.{$ENDIF}DISWorking := False ;
     end ;
  end ;
end ;

end.

