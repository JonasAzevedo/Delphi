{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2007                                        }
{                                   Valdir Stiebe Junior - valdir@dype.com.br  }
{                                   Daniel Simoes de Almeida                   }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 22/01/2007: Valdir Stiebe Junior e Daniel Simoes de Almeida
|*  - Primeira Versao ACBrTEF
******************************************************************************}

{$I ACBr.inc}

unit ACBrTEFClass;

interface
uses ACBrBase, ACBrTEF,
     Classes
     {$IFNDEF CONSOLE}
       {$IFDEF VisualCLX}, QForms {$ENDIF}
       {$IFDEF VCL}, Forms {$ENDIF}
     {$ENDIF} ;

resourcestring
  RS_INACTIVETEF = 'O gerenciador padr�o (TEF) n�o est� ativo!';

type

{ Classe generica de Gaveta, nao implementa nenhum modelo especifico, apenas
  declara a Classe. NAO DEVE SER INSTANCIADA. Usada apenas como base para
  as demais Classes de Gavetas como por exemplo a classe TACBrTEFMenno }

TACBrTEFResposta = class
  private
    FResposta: TStringList;
    FImagemCupom: TStringList;
    FTipoImpressao: TTipoImpressao;
  public
    constructor Create(TextoResposta, ImagemCupom: string; AtipoImpressao: TTipoImpressao);
    destructor Destroy; override;
    property ImagemCupom: TStringList read FImagemCupom;
    property Resposta: TStringList read FResposta;
    property TipoImpressao: TTipoImpressao read FTipoImpressao write FTipoImpressao;
  end;


TACBrTEFClass = class
  private
    procedure SetAtivo(const Value: Boolean);

  protected
    fpECF     : TACBrECF ;
    fpAtivo   : Boolean ;

    fpArqResp: String;
    fpArqReq: String;
    fpArqTemp: String;
    fpArqSts: String;

  public
    constructor Create(AOwner: TComponent);
    Destructor Destroy  ; override ;

    Property Ativo  : Boolean read fpAtivo write SetAtivo ;
    procedure Ativar ; virtual ;
    procedure Desativar ; virtual ;

    Property ArqReq  : String read fpArqReq  write fpArqReq  ;
    Property ArqResp : String read fpArqResp write fpArqResp ;
    Property ArqSts  : String read fpArqSts  write fpArqSts  ;
    Property ArqTemp : String read fpArqTemp write fpArqTemp ;
    Property Executavel : String read fpExecutavel write fpArqTemp ;

    Property ECF : TACBrECF read fpECF write fpECF ;


end ;

implementation
Uses ACBrTEF,
     SysUtils,
     {$IFDEF Delphi6_UP} DateUtils {$ELSE} ACBrD5, Windows {$ENDIF} ;

{ TACBrTEFClass }

constructor TACBrTEFClass.Create(AOwner: TComponent);
begin
  if not (AOwner is TACBrTEF) then
     raise Exception.create('Essa Classe deve ser instanciada por TACBrTEF');

  { Criando ponteiro interno para as Propriedade SERIAL de ACBrTEF,
    para permitir as Classes Filhas o acesso a essas propriedades do Componente}

  fpDevice    := (AOwner as TACBrTEF).Device ;
  fpECF       := (AOwner as TACBrTEF).ECF ;
  fpDevice.SetDefaultValues ;

  fpAtivo     := false ;
  fpModeloStr := 'N�o Definida' ;
  fpAberturaIntervalo := cAberturaIntervalo ;
  fpProximaAbertura   := 0 ;
  fpAberturaAntecipada:= aaAguardar ; 
end;

destructor TACBrTEFClass.Destroy;
begin
  fpDevice := nil ; { Apenas remove referencia (ponteiros internos) }
  fpECF    := nil ;

  inherited Destroy;
end;

procedure TACBrTEFClass.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrTEFClass.Ativar;
begin
  if fpAtivo then exit ;

  if fpDevice.Porta <> '' then
     fpDevice.Ativar ;

  fpAtivo := true ;
end;

procedure TACBrTEFClass.Desativar;
begin
  if not fpAtivo then exit ;

  if fpDevice.Porta <> '' then
     fpDevice.Desativar ;

  fpAtivo := false ;
end;

end.
