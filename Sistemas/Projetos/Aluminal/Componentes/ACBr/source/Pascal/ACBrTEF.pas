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

unit ACBrTEF;

interface
uses ACBrBase, ACBrTEFClass, ACBrECF, {Units da ACBr}
     SysUtils , Classes;

type

TACBrTEFRede = (tefNenhum, tefDIAL, tefDISC ) ;

{ Componente ACBrTEF }
TACBrTEF = class( TACBrComponent )
  private
    { Propriedades do Componente ACBrTEF }
    fsAtivo  : Boolean;
    fsRede   : TACBrTEFRede;
    fsTEF    : TACBrTEFClass ;   { Classe com instancia do TEF de fsRede }
    fsECF    : TACBrECF;
    fsDevice: TACBrDevice;

    procedure SetRede(const Value: TACBrTEFRede);
    procedure SetAtivo(const Value: Boolean);

    procedure SetECF(const Value: TACBrECF);
    function GetRedeStrClass: String;
  protected

  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy  ; override ;

    procedure Ativar ;
    procedure Desativar ;
    property Ativo : Boolean read fsAtivo write SetAtivo ;

    property TEF : TACBrTEFClass read fsTEF ;

    Property RedeStr : String read GetRedeStrClass;

    procedure ADM ;
    procedure CRT ;
    procedure CHQ ;
    procedure CNC ;
    procedure NCN ;

    procedure EnviaArquivo ;
  published
     property Rede : TACBrTEFRede read fsRede write SetRede
                 default tefNenhum ;

     property ECF    : TACBrECF    read fsECF write SetECF ;

     Property ArqReq  : String read GetArqReqClass  write SetArqReqClass ;
     Property ArqResp : String read GetArqRespClass write SetArqRespClass ;
     Property ArqSts  : String read GetArqStsClass  write SetArqStsClass ;
     Property ArqTemp : String read GetArqTempClass write SetArqTempClass ;
     Property Executavel : String read fpExecutavel write fpArqTemp ;

end ;

implementation
//Uses ACBrTEFDial, ACBrTEFDisc ;

{ TACBrTEF }

constructor TACBrTEF.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  fsAtivo := false ;
  fsRede  := TEFNenhuma ;

  { Instanciando fsTEF com Rede Generico (TEFClass) }
  fsTEF := TACBrTEFClass.create( self ) ;
end;

destructor TACBrTEF.Destroy;
begin
  Ativo := false ;

  if Assigned( fsTEF ) then
     FreeAndNil( fsTEF ) ;

  inherited Destroy;
end;

procedure TACBrTEF.SetRede(const Value: TACBrTEFRede);
begin
  if fsRede = Value then exit ;

  if fsAtivo then
     raise Exception.Create('Não é possível mudar a Rede com ACBrTEF Ativo');

  FreeAndNil( fsTEF ) ;

  { Instanciando uma nova classe de acordo com fsRede }
  case Value of
//     tefDIAL : fsTEF := TACBrTEFDIAL.create( Self ) ;
//     tefDISC : fsTEF := TACBrTEFDISC.create( Self ) ;
  else
     fsTEF := TACBrTEFClass.create( Self ) ;
  end;

  fsRede := Value;
end;

procedure TACBrTEF.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrTEF.Ativar;
begin
  if fsAtivo then exit ;

  if fsRede = tefNenhum then
     raise Exception.Create('Rede não definida');

  fsTEF.Ativar ;

  fsAtivo := true ;
end;

procedure TACBrTEF.Desativar;
begin
  if not fsAtivo then exit ;

  fsTEF.Desativar ;
  fsAtivo := false;
end;

function TACBrTEF.GetRedeStrClass: String;
begin
  Result := fsTEF.RedeStr ;
end;

procedure TACBrTEF.SetECF(const Value: TACBrECF);
begin
  fsECF     := Value;
  fsTEF.ECF := Value ;
end;

end.
