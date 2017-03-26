{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{          Rennes Moreira Pimentel - InforSystem - Valida�ao do CEP            }              
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
|* 17/08/2004: Daniel Simoes de Almeida
|*  - Primeira Versao ACBrValidador
|* 17/11/2004: Rennes Moreira Pimentel - InforSystem
|*  - Adcionado Valida�ao do CEP
|* 07/02/2005: Daniel Simoes de Almeida
|*  - Adcionado verifica�ao de CARTOES de Cr�dito, extraida do site:
|*    www.tcsystems.com.br
|*  - Adcionada a propriedade: ExibeDigitoCorreto : Boolean ( default False )
|* 24/05/2005: Daniel Simoes de Almeida
|*  - Adicionada a propriedade Publica DigitoCalculado readonly, que assim como
|*    MsgErro, ter� um valor definido apenas ap�s chamar o m�todo Validar 
|* 21/12/2005: Daniel Simoes de Almeida
|*  - Inscri��o Estadual de AL aparentemente tamb�m aceita o numero 6 no 3
|*    d�gito, apesar do site do sintegra informar o contr�rio... Corrigido
|* 30/08/2007: Carlos do Nascimento Filho
|*  - Inscri��o Estadual de TO corrigida para suportar numeros com 10 digitos
******************************************************************************}
{$I ACBr.inc}

unit ACBrValidador;

interface
uses ACBrBase, ACBrUtil, {Units da ACBr}
     SysUtils , Classes;

const
  cIgnorarChar = './-' ;

type
  TACBrValTipoDocto = (docCPF, docCNPJ, docUF, docInscEst, docNumCheque,
                       docPIS, docCEP, docCartaoCredito  ) ;

type
  TACBrCalcDigFormula = (frModulo11, frModulo10) ;

type
TACBrCalcDigito = class
   private
      fsMultIni: Integer;
      fsMultFim: Integer;
      fsFormulaDigito: TACBrCalcDigFormula;
      fsDocto: String;
      fsDigitoFinal: Integer;
      fsSomaDigitos: Integer;

   public
      constructor Create;
      Procedure Calcular ;
      Procedure CalculoPadrao ;

      Property Documento : String read fsDocto write fsDocto ;
      Property MultiplicadorInicial : Integer read fsMultIni write fsMultIni ;
      Property MultiplicadorFinal   : Integer read fsMultFim write fsMultFim ;
      Property DigitoFinal : Integer read fsDigitoFinal ;
      Property SomaDigitos : Integer read fsSomaDigitos ;
      Property FormulaDigito :  TACBrCalcDigFormula read fsFormulaDigito
         write fsFormulaDigito ;
end;

type
  TACBrValidadorMsg = procedure(Mensagem : String) of object ;

type
{ Componente ACBrValidador }
TACBrValidador = class( TACBrComponent )
  private
    { Propriedades do Componente ACBrValidador }
    fsIgnorarChar: String;
    fsDocumento: String;
    fsComplemento: String;
    fsDocto    : String;
    fsMsgErro: String;
    fsRaiseExcept: Boolean;
    fsOnMsgErro: TACBrValidadorMsg;
    fsTipoDocto: TACBrValTipoDocto;
    fsPermiteVazio: Boolean;
    fsAjustarTamanho: Boolean;
    fsModulo: TACBrCalcDigito;
    fsExibeDigitoCorreto: Boolean;
    fsDigitoCalculado: String;

    procedure SetfsDocumento(const Value: String);
    procedure SetfsComplemento(const Value: String);
    Function LimpaDocto(const AString : String) : String ;

    Procedure ValidarCPF  ;
    Procedure ValidarCNPJ ;
    Procedure ValidarUF( UF : String) ;
    Procedure ValidarIE ;
    Procedure ValidarCheque ;
    Procedure ValidarPIS  ;
    Procedure ValidarCEP ;
    procedure ValidarCartaoCredito ;
  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy  ; override ;

    Property MsgErro : String read fsMsgErro ;
    Property Modulo  : TACBrCalcDigito read fsModulo write fsModulo ;
    Property DigitoCalculado : String read fsDigitoCalculado ;

    Function Validar  : Boolean;
    Function Formatar : String ;

    Function FormatarCPF( AString : String )    : String ;
    Function FormatarCNPJ( AString : String )   : String ;
    Function FormatarCheque( AString : String ) : String ;
    Function FormatarPIS( AString : String )    : String ;
    Function FormatarCEP( AString: String )     : String ;
  published
    property TipoDocto : TACBrValTipoDocto read fsTipoDocto write fsTipoDocto
       default docCPF ;
    property Documento : String read fsDocumento write SetfsDocumento
       stored false;
    property Complemento : String read fsComplemento write SetfsComplemento
       stored false;
    property ExibeDigitoCorreto : Boolean read fsExibeDigitoCorreto
       write fsExibeDigitoCorreto default false ;
    property IgnorarChar : String read fsIgnorarChar write fsIgnorarChar ;
    property AjustarTamanho : Boolean read fsAjustarTamanho
       write fsAjustarTamanho default false ;
    property PermiteVazio : Boolean read fsPermiteVazio write fsPermiteVazio
       default false ;
    property RaiseExcept : Boolean read fsRaiseExcept write fsRaiseExcept
       default false ;
    property OnMsgErro : TACBrValidadorMsg read fsOnMsgErro write fsOnMsgErro;

end ;

implementation
{$IFDEF COMPILER6_UP} uses Variants ; {$ENDIF} 

{ TACBrValidador }

constructor TACBrValidador.Create(AOwner: TComponent);
begin
  inherited Create( AOwner ) ;

  fsIgnorarChar        := cIgnorarChar ;
  fsDocumento          := '' ;
  fsComplemento        := '' ;
  fsDocto              := '' ;
  fsMsgErro            := '' ;
  fsDigitoCalculado    := '' ;
  fsAjustarTamanho     := false ;
  fsExibeDigitoCorreto := false ;
  fsRaiseExcept        := false ;
  fsPermiteVazio       := false ;
  fsOnMsgErro          := nil ;
  fsTipoDocto          := docCPF ;
  fsModulo             := TACBrCalcDigito.Create ;
end;

destructor TACBrValidador.Destroy;
begin
  FreeAndNil( fsModulo ) ;

  inherited Destroy ;
end;

procedure TACBrValidador.SetfsDocumento(const Value: String);
begin
  if fsDocumento = Value then exit ;

  fsDocumento := Value;
  fsMsgErro   := 'Fun��o Validar n�o foi chamada' ;
  fsDigitoCalculado := '' ;

  fsDocto := LimpaDocto( fsDocumento ) ;
end;

Function TACBrValidador.LimpaDocto(const AString : String) : String ;
Var A : Integer ;
begin
  Result := '' ;
  For A := 1 to length( AString ) do
  begin
     if pos(AString[A], fsIgnorarChar) = 0 then
        Result := Result + UpperCase(AString[A]) ;
  end ;
  Result := Trim(Result) ;
end ;

procedure TACBrValidador.SetfsComplemento(const Value: String);
begin
  fsComplemento := Value;
end;

function TACBrValidador.Validar : Boolean;
begin
  Result    := true ;
  fsMsgErro := '' ;
  fsDocto   := LimpaDocto( fsDocumento ) ;
  fsDigitoCalculado := '' ;
  
  if (fsDocto = '') then
  begin
     if fsPermiteVazio then
        exit
     else
        fsMsgErro := 'Documento n�o pode ser vazio.' ;
  end ;

  if fsMsgErro = '' then
     case fsTipoDocto of
       docCPF           : ValidarCPF  ;
       docCNPJ          : ValidarCNPJ ;
       docUF            : ValidarUF( fsDocto ) ;
       docInscEst       : ValidarIE ;
       docNumCheque     : ValidarCheque ;
       docPIS           : ValidarPIS ;
       docCEP           : ValidarCEP ;
       docCartaoCredito : ValidarCartaoCredito ;
     end;

  if fsMsgErro <> '' then
  begin
     Result := false ;
     
     if Assigned( fsOnMsgErro ) then
        fsOnMsgErro( fsMsgErro ) ;

     if fsRaiseExcept then
        raise Exception.Create( fsMsgErro );
  end ;

end;

function TACBrValidador.Formatar: String;
begin
  Result := fsDocumento  ;

  case fsTipoDocto of
    docCPF      : Result := FormatarCPF( fsDocumento )  ;
    docCNPJ     : Result := FormatarCNPJ( fsDocumento )  ;
    docNumCheque: Result := FormatarCheque( fsDocumento )  ;
    docPIS      : Result := FormatarPIS( fsDocumento )  ;
    docCEP      : Result := FormatarCEP( fsDocumento )  ;
  end;
end;

function TACBrValidador.FormatarCheque(AString: String): String;
Var S : String ;
begin
  S := padR( LimpaDocto(AString), 7, '0') ; { Prenche zeros a esquerda }
  Result := copy(S,1,6) + '-' + copy(S,7,1) ;
end;

function TACBrValidador.FormatarCEP(AString: String): String;
Var S : String ;
begin
  S := padL( LimpaDocto(AString), 8, '0') ; { Prenche zeros a direita }
  Result := copy(S,1,5) + '-' + copy(S,6,3) ;
end;

Procedure TACBrValidador.ValidarCheque ;
begin
  if not StrIsNumber( fsDocto ) then
  begin
     fsMsgErro := 'Digite apenas os n�meros do Cheque' ;
     exit ;
  end ;

  Modulo.CalculoPadrao ;
  Modulo.Documento := copy(fsDocto, 1, length(fsDocto)-1) ;
  Modulo.Calcular ;
  fsDigitoCalculado := IntToStr( Modulo.DigitoFinal ) ;

  if fsDigitoCalculado <> copy(fsDocto, length(fsDocto), 1) then
  begin
     fsMsgErro := 'N�mero de Cheque inv�lido.' ;

     if fsExibeDigitoCorreto then
        fsMsgErro := fsMsgErro + '.. Digito correto: '+fsDigitoCalculado ;
  end ;
end;

function TACBrValidador.FormatarCNPJ(AString: String): String;
Var S : String ;
begin
  S := padR( LimpaDocto(AString), 14, '0') ;
  Result := copy(S,1,2) + '.' + copy(S,3,3) + '.' +
            copy(S,6,3) + '/' + copy(S,9,4) + '-' + copy(S,13,2) ;
end;

Procedure TACBrValidador.ValidarCNPJ ;
Var DV1, DV2 : String ;
begin
  if fsAjustarTamanho then
     fsDocto := padR( fsDocto, 14, '0') ;

  if (Length( fsDocto ) <> 14) or ( not StrIsNumber( fsDocto ) ) then
  begin
     fsMsgErro := 'CNPJ deve ter 14 digitos. (Apenas numeros)' ;
     exit
  end ;

  Modulo.CalculoPadrao ;
  Modulo.Documento := copy(fsDocto, 1, 12) ;
  Modulo.Calcular ;
  DV1 := IntToStr( Modulo.DigitoFinal ) ;

  Modulo.Documento := copy(fsDocto, 1, 12)+DV1 ;
  Modulo.Calcular ;
  DV2 := IntToStr( Modulo.DigitoFinal ) ;

  fsDigitoCalculado := DV1+DV2 ;

  if (DV1 <> fsDocto[13]) or (DV2 <> fsDocto[14]) then
  begin
     fsMsgErro := 'CNPJ inv�lido.' ;

     if fsExibeDigitoCorreto then
        fsMsgErro := fsMsgErro +  '.. Digito calculado: '+fsDigitoCalculado ;
  end ;
end;

function TACBrValidador.FormatarCPF(AString: String): String;
Var S : String ;
begin
  S := padR( LimpaDocto(AString), 11, '0') ;
  Result := copy(S,1,3) + '.' + copy(S,4 ,3) + '.' +
            copy(S,7,3) + '-' + copy(S,10,2) ;
end;

Procedure TACBrValidador.ValidarCPF ;
Var DV1, DV2 : String ;
begin
  if fsAjustarTamanho then
     fsDocto := padR( fsDocto, 11, '0') ;

  if (Length( fsDocto ) <> 11) or ( not StrIsNumber( fsDocto ) ) then
  begin
     fsMsgErro := 'CPF deve ter 11 digitos. (Apenas numeros)' ;
     exit
  end ;

  if pos(fsDocto,'11111111111.22222222222.33333333333.44444444444.55555555555.'+
         '66666666666.77777777777.88888888888.99999999999.00000000000') > 0 then
  begin
     fsMsgErro := 'CPF inv�lido !' ;
     exit ;
  end ;

  Modulo.MultiplicadorInicial := 2  ;
  Modulo.MultiplicadorFinal   := 11 ;
  Modulo.FormulaDigito        := frModulo11 ;
  Modulo.Documento := copy(fsDocto, 1, 9) ;
  Modulo.Calcular ;
  DV1 := IntToStr( Modulo.DigitoFinal ) ;

  Modulo.Documento := copy(fsDocto, 1, 9)+DV1 ;
  Modulo.Calcular ;
  DV2 := IntToStr( Modulo.DigitoFinal ) ;

  fsDigitoCalculado := DV1+DV2 ;

  if (DV1 <> fsDocto[10]) or (DV2 <> fsDocto[11]) then
  begin
     fsMsgErro := 'CPF inv�lido.' ;

     if fsExibeDigitoCorreto then
        fsMsgErro := fsMsgErro + '.. Digito calculado: '+fsDigitoCalculado ;
  end ;
end;

Procedure TACBrValidador.ValidarCEP ;
begin
  if fsAjustarTamanho then
     fsDocto := padL( fsDocto, 8, '0') ;

  if (Length( fsDocto ) <> 8) or ( not StrIsNumber( fsDocto ) ) then
  begin
     fsMsgErro := 'CEP deve ter 8 digitos. (Apenas numeros)' ;
     exit
  end ;

  { Passou o UF em Complemento ? Se SIM, verifica o UF }
  fsComplemento := trim(fsComplemento) ;
  if fsComplemento <> '' then
  begin
     ValidarUF( fsComplemento ) ;
     if fsMsgErro <> '' then
        exit ;
   end ;

  if ((fsDocto >= '01000000') and (fsDocto <= '19999999')) and { SP }
     ((fsComplemento = 'SP')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '20000000') and (fsDocto <= '28999999')) and { RJ }
     ((fsComplemento = 'RJ')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '29000000') and (fsDocto <= '29999999')) and { ES }
     ((fsComplemento = 'RJ')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '30000000') and (fsDocto <= '39999999')) and { MG }
     ((fsComplemento = 'RJ')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '40000000') and (fsDocto <= '48999999')) and { BA }
     ((fsComplemento = 'BA')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '49000000') and (fsDocto <= '49999999')) and { SE }
     ((fsComplemento = 'SE')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '50000000') and (fsDocto <= '56999999')) and { PE }
     ((fsComplemento = 'PE')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '57000000') and (fsDocto <= '57999999')) and { AL }
     ((fsComplemento = 'AL')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '58000000') and (fsDocto <= '58999999')) and { PB }
     ((fsComplemento = 'PB')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '59000000') and (fsDocto <= '59999999')) and { RN }
     ((fsComplemento = 'RN')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '60000000') and (fsDocto <= '63999999')) and { CE }
     ((fsComplemento = 'CE')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '64000000') and (fsDocto <= '64999999')) and { PI }
     ((fsComplemento = 'PI')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '65000000') and (fsDocto <= '65999999')) and { MA }
     ((fsComplemento = 'MA')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '66000000') and (fsDocto <= '68899999')) and { PA }
     ((fsComplemento = 'PA')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '68900000') and (fsDocto <= '68999999')) and { AP }
     ((fsComplemento = 'AP')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '69000000') and (fsDocto <= '69299999')) and { AM }
     ((fsComplemento = 'AM')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '69300000') and (fsDocto <= '69399999')) and { RR }
     ((fsComplemento = 'RR')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '69400000') and (fsDocto <= '69899999')) and { AM }
     ((fsComplemento = 'AM')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '69900000') and (fsDocto <= '69999999')) and { AC }
     ((fsComplemento = 'AC')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '70000000') and (fsDocto <= '72799999')) and { DF }
     ((fsComplemento = 'DF')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '72800000') and (fsDocto <= '72999999')) and { GO }
     ((fsComplemento = 'GO')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '73000000') and (fsDocto <= '73699999')) and { DF }
     ((fsComplemento = 'DF')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '73700000') and (fsDocto <= '76799999')) and { GO }
     ((fsComplemento = 'GO')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '77000000') and (fsDocto <= '77999999')) and { TO }
     ((fsComplemento = 'TO')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '78000000') and (fsDocto <= '78899999')) and { MT }
     ((fsComplemento = 'MT')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '78900000') and (fsDocto <= '78999999')) and { RO }
     ((fsComplemento = 'RO')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '79000000') and (fsDocto <= '79999999')) and { MS }
     ((fsComplemento = 'MS')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '80000000') and (fsDocto <= '87999999')) and { PR }
     ((fsComplemento = 'PR')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '88000000') and (fsDocto <= '89999999')) and { SC }
     ((fsComplemento = 'SC')  or  (fsComplemento = '')) then exit ;

  if ((fsDocto >= '90000000') and (fsDocto <= '99999999')) and { RS }
     ((fsComplemento = 'RS')  or  (fsComplemento = '')) then exit ;

  if fsComplemento <> '' then
     fsMsgErro := 'CEP inv�lido para '+fsComplemento+' !' 
  else
     fsMsgErro := 'CEP inv�lido !' ;

end;

Procedure TACBrValidador.ValidarIE ;
Const
   c0_9 : String = '0-9' ;
   cPesos : array[1..13] of array[1..14] of Integer =
      ((0 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,2 ,3 ,4 ,5 ,6 ),
       (0 ,0 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,2 ,3 ,4 ,5 ),
       (2 ,0 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,2 ,3 ,4 ,5 ,6 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ),
       (0 ,8 ,7 ,6 ,5 ,4 ,3 ,2 ,1 ,0 ,0 ,0 ,0 ,0 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,7 ,0 ,0 ,8 ,9 ,0 ,0 ,0 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,1 ,2 ,3 ,4 ,5 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,7 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ),
       (0 ,0 ,2 ,3 ,4 ,5 ,6 ,7 ,2 ,3 ,4 ,5 ,6 ,7 ),
       (0 ,0 ,2 ,1 ,2 ,1 ,2 ,1 ,2 ,1 ,1 ,2 ,1 ,0 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10,11,2 ,3 ,0 ),
       (0 ,0 ,0 ,0 ,10,8 ,7 ,6 ,5 ,4 ,3 ,1 ,0 ,0 ),
       (0 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10,2 ,3 ,0, 0 ) ) ;

Var
   vDigitos : array of String ;
   xROT, yROT :  String ;
   Tamanho, FatorF, FatorG, I, xMD, xTP, yMD, yTP, DV, DVX, DVY : Integer ;
   SOMA, SOMAq, nD, M : Integer ;
   OK : Boolean ;
   Passo, D : Char ;

begin

  if fsComplemento = '' then
  begin
     fsMsgErro := 'Informe a UF no campo Complemento' ;
     exit ;
  end ;

  ValidarUF( fsComplemento ) ;
  if fsMsgErro <> '' then
     exit ;

  { Somente digitos ou letra P na primeira posicao }
  { P � usado pela Insc.Estadual de Produtor Rural de SP }
  if ( not StrIsNumber( copy(fsDocto,2,length(fsDocto) ))) or
     ( not CharIsNum(fsDocto[1]) and (fsDocto[1] <> 'P')) then
  begin
     fsMsgErro := 'Caracteres inv�lidos na Inscri��o Estadual' ;
     exit
  end ;

  Tamanho := 0  ;
  xROT    := 'E';
  xMD     := 11 ;
  xTP     := 1  ;
  yROT    := '' ;
  yMD     := 0  ;
  yTP     := 0  ;
  FatorF  := 0  ;
  FatorG  := 0  ;

  SetLength( vDigitos, 13);
  vDigitos := VarArrayOf(['','','','','','','','','','','','','','']) ;

  if fsComplemento = 'AC' then
  begin
     if Length(fsDocto) = 9 then
      begin
        Tamanho := 9 ;
        vDigitos := VarArrayOf(
           ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1','0','','','','',''] ) ;
      end
     else
      if Length(fsDocto) = 13 then
      begin
        Tamanho := 13 ;
        xTP := 2   ;   yROT := 'E'   ;   yMD  := 11   ;   yTP  := 1 ;
        vDigitos := VarArrayOf(
          ['DVY','DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1','0','']);
      end ;
  end ;

  if fsComplemento = 'AL' then
  begin
     Tamanho := 9 ;
     xROT := 'BD' ;
     vDigitos   := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,'0,3,6,5,7,8','4','2','','','','',''] ) ;
  end ;

  if fsComplemento = 'AP' then
  begin
     if Length(fsDocto) = 9 then
      begin
        Tamanho := 9 ;
        xROT := 'CE' ;
        vDigitos   := VarArrayOf(
           ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'3','0','','','','',''] ) ;

        if (fsDocto >= '030170010') and (fsDocto <= '030190229') then
           FatorF := 1
        else if fsDocto >= '030190230' then
           xROT := 'E' ;
      end ;
  end ;

  if fsComplemento = 'AM' then
  begin
     Tamanho := 9 ;
     vDigitos  := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'4,7','0','','','','',''] ) ;
  end ;

  if fsComplemento = 'BA' then
  begin
     Tamanho := 8 ;
     xTP := 2   ;   yTP  := 3   ;   yROT := 'E' ;
     vDigitos := VarArrayOf(
        ['DVX','DVY',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','','','','',''] ) ;

     if pos(fsDocto[1],'0123458') > 0 then
      begin
        xMD := 10   ;   yMD := 10 ;
      end
     else
      begin
        xMD := 11   ;   yMD := 11 ;
      end ;
  end ;

  if fsComplemento = 'CE' then
  begin
     Tamanho := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'0','','','','',''] ) ;
  end ;

  if fsComplemento = 'DF' then
  begin
     Tamanho := 13 ;
     xTP := 2   ;   yROT := 'E'  ;   yMD  := 11   ;   yTP  := 1 ;
     vDigitos  := VarArrayOf(
        ['DVY','DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'3,4','7','0','']);
  end ;

  if fsComplemento = 'ES' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'0,8','0','','','','',''] ) ;
  end ;

  if fsComplemento = 'GO' then
  begin
     if Length(fsDocto) = 9 then
     begin
        Tamanho  := 9 ;
        vDigitos := VarArrayOf(
           [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'0,1,5','1','','','','',''] ) ;

        if (fsDocto >= '101031050') and (fsDocto <= '101199979') then
           FatorG := 1 ;
     end ;
  end ;

  if fsComplemento = 'MA' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'2','1','','','','',''] ) ;
  end ;

  if fsComplemento = 'MT' then
  begin
     Tamanho := 11 ;
     vDigitos := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','',''] ) ;
  end ;

  if fsComplemento = 'MS' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'8','2','','','','',''] ) ;
  end ;

  if fsComplemento = 'MG' then
  begin
     Tamanho  := 13 ;
     xROT := 'AE'    ;   xMD := 10   ;   xTP := 10 ;
     yROT := 'E'     ;   yMD := 11   ;   yTP := 11 ;
     vDigitos := VarArrayOf(
       ['DVY','DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'']);
  end ;

  if fsComplemento = 'PA' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'5','1','','','','',''] ) ;
  end ;

  if fsComplemento = 'PB' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'6','1','','','','',''] ) ;
  end ;

  if fsComplemento = 'PR' then
  begin
     Tamanho := 10 ;
     xTP := 9   ;   yROT := 'E'   ;   yMD := 11   ;   yTP := 8 ;
     vDigitos := VarArrayOf(
        [ 'DVY','DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','','',''] ) ;
  end ;

  if fsComplemento = 'PE' then
  begin
     Tamanho := 14 ;
     xTP := 7   ;   FatorF := 1 ;
     vDigitos := VarArrayOf(
       ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1-9','8','1']);
  end ;

  if fsComplemento = 'PI' then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'9','1','','','','',''] ) ;
  end ;

  if fsComplemento = 'RJ' then
  begin
     Tamanho := 8 ;
     xTP := 8 ;
     vDigitos := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1,7,8,9','','','','','',''] ) ;
  end ;

  if fsComplemento = 'RN' then
  begin
     Tamanho := 9 ;
     xROT := 'BD' ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,'0-3','0','2','','','','',''] ) ;
  end ;

  if fsComplemento = 'RS' then
  begin
     Tamanho := 10 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'0-4','','','',''] ) ;
  end ;

  if fsComplemento = 'RO' then
  begin
     FatorF := 1 ;
     if Length(fsDocto) = 9 then
     begin
        Tamanho := 9 ;
        xTP := 4 ;
        vDigitos := VarArrayOf(
          [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1-9','','','','',''] ) ;
     end ;

     if Length(fsDocto) = 14 then
     begin
        Tamanho  := 14 ;
        vDigitos := VarArrayOf(
        ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9]);
     end ;
  end ;
  
  if fsComplemento = 'RR' then
  begin
     Tamanho  := 9 ;
     xROT := 'D'   ;   xMD := 9   ;   xTP := 5 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'4','2','','','','',''] ) ;
  end ;

  if (fsComplemento = 'SC') or (fsComplemento = 'SE') then
  begin
     Tamanho  := 9 ;
     vDigitos := VarArrayOf(
        [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','','','',''] ) ;
  end;

  if fsComplemento = 'SP' then
  begin
     xROT := 'D'   ;   xTP := 12 ;
     if fsDocto[1] = 'P' then
      begin
        Tamanho  := 13 ;
        vDigitos := VarArrayOf(
         [c0_9,c0_9,c0_9,'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'P','']);
      end
     else
      begin
        Tamanho  := 12 ;
        yROT := 'D'   ;   yMD := 11   ;   yTP := 13 ;
        vDigitos := VarArrayOf(
         ['DVY',c0_9,c0_9,'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'','']);
      end ;
  end ;

  if fsComplemento = 'TO' then
  begin
     if Length(fsDocto)=11 then
      begin
        Tamanho := 11 ;
        xTP := 6 ;
        vDigitos := VarArrayOf(
          ['DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'1,2,3,9','0,9','9','2','','','']);
      end
     else
      begin
        Tamanho := 10 ;
        vDigitos := VarArrayOf(
          [ 'DVX',c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,c0_9,'0-4','','','',''] ) ;
      end;
  end ;

  { Verificando se o tamanho Total est� correto }
  if fsAjustarTamanho then
     fsDocto := padR( fsDocto, Tamanho, '0') ;

  OK := (Tamanho > 0) and (Length(fsDocto) = Tamanho) ;
  if not OK then
     fsMsgErro := 'Tamanho Inv�lido' ;

  { Verificando os digitos nas posicoes s�o permitidos }
  fsDocto := padR(fsDocto,14) ;
  DVX := 0  ;
  DVY := 0  ;
  I   := 13 ;
  while OK and (I >= 0) do
  begin
     D := fsDocto[14-I] ;

     if vDigitos[I] = '' then
        OK := (D = ' ')

     else if (vDigitos[I] = 'DVX') or (vDigitos[I] = 'DVY') or
             (vDigitos[I] = c0_9) then
      begin
        OK := CharIsNum( D ) ;

        if vDigitos[I] = 'DVX' then
           DVX := StrToIntDef( D, 0 )
        else
           if vDigitos[I] = 'DVY' then
              DVY := StrToIntDef( D, 0 ) ;
      end

     else if pos(',',vDigitos[I]) > 0 then   { Ex: '2,5,7,8' Apenas os da lista}
        OK := (pos( D, vDigitos[I] ) > 0)

     else if pos('-',vDigitos[I]) > 0 then
        OK := ( (D >= copy(vDigitos[I],1,1)) and (D <= copy(vDigitos[I],3,1)) )

     else
        OK := ( D = vDigitos[I] ) ;

     if not OK then
        fsMsgErro := Format('Digito %d deveria ser %s ',
         [14-I-(14-Tamanho), vDigitos[I]]) ;

     I := I - 1 ;
  end ;

  Passo := 'X' ;
  while OK and (xTP > 0) do
  begin
     SOMA := 0  ;
     SOMAq:= 0  ;
     I    := 14 ;

     while OK and (I > 0) do
     begin
        D := fsDocto[15-I] ;

        if CharIsNum(D) then
        begin
           nD := StrToIntDef(D,0) ;
           M  := nD * cPesos[xTP,I] ;
           SOMA := SOMA + M ;

           if pos('A',xROT) > 0 then
              SOMAq := SOMAq + Trunc(M / 10) ;
        end ;

        I := I - 1 ;
     end ;

     if pos('A',xROT) > 0 then
        SOMA := SOMA + SOMAq

     else if pos('B',xROT) > 0 then
        SOMA := SOMA * 10

     else if pos('C',xROT) > 0 then
        SOMA := SOMA + (5 + (4 * FatorF) ) ;

     { Calculando digito verificador }
     DV := Trunc(SOMA mod xMD) ;
     if pos('E',xROT) > 0 then
        DV := Trunc(xMD - DV) ;

     if DV = 10 then
        DV := FatorG   { Apenas GO modifica o FatorG para diferente de 0 }
     else if DV = 11 then
        DV := FatorF ;

     if Passo = 'X' then
        OK := (DVX = DV)
     else
        OK := (DVY = DV) ;

     fsDigitoCalculado := IntToStr(DV) ;
     if not OK then
     begin
        fsMsgErro := 'Digito verificador inv�lido.' ;

        if fsExibeDigitoCorreto then
           fsMsgErro := fsMsgErro + '.. Calculado: '+fsDigitoCalculado ;
     end ;

     if PASSO = 'X' then
      begin
        PASSO := 'Y'  ;
        xROT  := yROT ;
        xMD   := yMD  ;
        xTP   := yTP  ;
      end
     else
        break ;
  end ;

  fsDocto := Trim( fsDocto ) ;
  if (fsMsgErro <> '') then
     fsMsgErro := 'Insc.Estadual inv�lida para '+fsComplemento +' '+ fsMsgErro ;

end;

Procedure TACBrValidador.ValidarUF(UF: String) ;
begin
 if pos( ','+UF+',', ',AC,AL,AP,AM,BA,CE,DF,ES,GO,MA,MT,MS,MG,PA,PB,PR,PE,PI,'+
                     'RJ,RN,RS,RO,RR,SC,SP,SE,TO,') = 0 then
    fsMsgErro := 'UF inv�lido: '+UF ;
end;

function TACBrValidador.FormatarPIS(AString: String): String;
Var S : String ;
begin
  S := padR( LimpaDocto(AString), 11, '0') ;
  Result := copy(S,1,2) + '.' + copy(S,3,5) + '.' +
            copy(S,8,3) + '.' + copy(S,11,1)
end;

procedure TACBrValidador.ValidarPIS;
begin
  if fsAjustarTamanho then
     fsDocto := padR( fsDocto, 11, '0') ;

  if (Length( fsDocto ) <> 11) or ( not StrIsNumber( fsDocto ) ) then
  begin
     fsMsgErro := 'PIS deve ter 11 digitos. (Apenas numeros)' ;
     exit
  end ;

  Modulo.CalculoPadrao ;
  Modulo.FormulaDigito := frModulo10 ;
  Modulo.Documento     := copy(fsDocto, 1, 10) ;
  Modulo.Calcular ;
  fsDigitoCalculado := IntToStr( Modulo.DigitoFinal ) ;

  if (fsDigitoCalculado <> fsDocto[11]) then
  begin
     fsMsgErro := 'PIS inv�lido.' ;

     if fsExibeDigitoCorreto then
        fsMsgErro := fsMsgErro + '.. Digito calculado: '+fsDigitoCalculado ;
  end ;
end;


{ Rotina extraida do site:   www.tcsystems.com.br   }
Procedure TACBrValidador.ValidarCartaoCredito ;
Var Valor, Soma, Multiplicador, Tamanho, i : Integer;
begin
  if not StrIsNumber( fsDocto ) then
  begin
     fsMsgErro := 'Cart�o deve ter apenas N�meros' ;
     exit
  end ;

  Multiplicador := 2;
  Soma          := 0;
  Tamanho       := Length(fsDocto) ;

  For i := 1 to Tamanho - 1 do
  begin
    Try
      Valor := StrToInt (Copy (fsDocto, i, 1)) * Multiplicador;
    Except
      Valor := 0;
    End;

    Soma := Soma + (Valor DIV 10) + (Valor mod 10);
    if Multiplicador = 1 Then
       Multiplicador := 2
    else
       Multiplicador := 1;
  end;

  fsDigitoCalculado := IntToStr((10 - (Soma mod 10)) mod 10) ;
  if fsDigitoCalculado <> Copy (fsDocto, Tamanho, 1) Then
  begin
     fsMsgErro := 'Numero do Cart�o Inv�lido.' ;

     if fsExibeDigitoCorreto then
        fsMsgErro := fsMsgErro + '.. Digito calculado: '+fsDigitoCalculado ;
  end ;
end;

{------------------------------ TACBrCalcDigito ------------------------------}
constructor TACBrCalcDigito.Create;
begin
  fsDocto         := '' ;
  fsDigitoFinal   := 0 ;
  fsSomaDigitos   := 0 ;
  fsMultIni       := 2 ;
  fsMultFim       := 9 ;
  fsFormulaDigito := frModulo11 ;
end;

procedure TACBrCalcDigito.Calcular;
Var A,N,Base,Tamanho : Integer ;
begin
  fsDocto       := Trim(fsDocto) ;
  fsSomaDigitos := 0 ;
  fsDigitoFinal := 0 ;
  Base          := fsMultIni ;
  Tamanho       := Length(fsDocto) ;

  { Calculando a Soma dos digitos de traz para diante, multiplicadas por BASE }
  For A := 1 to Tamanho do
  begin
     N := StrToIntDef( fsDocto[ Tamanho - A + 1 ], 0 ) ;
     fsSomaDigitos := fsSomaDigitos + (N * Base) ;

     Inc( Base ) ;
     if Base > fsMultFim then
        Base := fsMultIni ;
  end ;

  case fsFormulaDigito of
    frModulo11 :
      begin
        fsDigitoFinal := fsSomaDigitos mod 11 ;

        if fsDigitoFinal < 2 then
           fsDigitoFinal := 0
        else
           fsDigitoFinal := 11 - fsDigitoFinal ;
      end ;

    frModulo10 :
      begin
        fsDigitoFinal := 11 - (fsSomaDigitos mod 11);

        if (fsDigitoFinal >= 10) then
           fsDigitoFinal := 0;
      end ;
  end;
end;

procedure TACBrCalcDigito.CalculoPadrao;
begin
  fsMultIni       := 2 ;
  fsMultFim       := 9 ;
  fsFormulaDigito := frModulo11 ;
end;

end.



