{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2007                                        }
{                                   Valdir Stiebe Junior - valdir@dype.com.br  }
{                                   Daniel Simoes de Almeida                   }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
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
  RS_INACTIVETEF = 'O gerenciador padrão (TEF) não está ativo!';

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
  fpModeloStr := 'Não Definida' ;
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
