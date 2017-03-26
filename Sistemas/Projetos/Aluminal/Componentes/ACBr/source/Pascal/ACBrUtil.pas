{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Algumas fun�oes dessa Unit foram extraidas de outras Bibliotecas, veja no   }
{ cabe�alho das Fun�oes no c�digo abaixo a origem das informa�oes, e autores...}
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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 30/06/2004:  Daniel Simoes de Almeida
|*   Fun�oes auxiliares separadas do c�digo do componentes
|* 19/12/2004:  Daniel Simoes de Almeida
|*   Adcionada a procedure DeleteFiles e a Fun�ao CopyFileTo
|* 15/07/2005:  Daniel Simoes de Almeida
|*   Rotina TiraAcentos() modificada para permitir os chars #13 e #10
|* 09/12/2005:  Daniel Simoes de Almeida
|*   Fun��es StringToAsc e AscToSTring movidas de ACBrECFNaoFiscal.pas para
|*   ACBrUtil.pas
|* 09/12/2005:  Daniel Simoes de Almeida
|*   Adicionada fun��o FunctionDetect (LibName, FuncName: String;
|*                                    var LibPointer: Pointer): boolean;
|*   Fun��es InPort e OutPort agora suportam a DLL inpout32.dll, que permite
|*   acesso direto a portas no XP /NT / 98  http://www.logix4u.net/inpout32.htm
|* 05/03/2006:  Daniel Simoes de Almeida
|* +  StringToDateTime( DateTimeString : String ) : TDateTime ;
|* +  StringToDateTimeDef( DateTimeString : String ; DefaultValue : TDateTime )
|*         : TDateTime ;
|* 23/05/2006:  Daniel Simoes de Almeida
|*   - Adicionada a fun��o:  PosLast(const SubStr, S: string): Integer;
|*     que retorna a �ltima posi��o de SubStr dentro da String S, ou 0 se n�o
|*     encontrar a SubStr dentro de S
|* 27/06/2006:  Daniel Simoes de Almeida
|*   - Adicionada as fun��es: BinToInt e IntToBin (http://delphi.about.com)
|*   - Modificada TestBit para permitir Inteiros de 16 bits
|* 03/10/2006:  Daniel Simoes de Almeida
|*   - Corrigido pequeno Bug na fun��o TruncFix.
|* 21/10/2006:  Daniel Simoes de Almeida
|*   - Adicionada a fun��o  PathWithDelim( APath : String ) : String ;
|* 08/11/2006:  Daniel Simoes de Almeida
|*   - Adicionada a fun��o  DesligarMaquina(Reboot: Boolean = False) ;
|* 03/01/2007:  Nei Jos� Van Lare Junior
|*   - Adicionada a fun��o function RemoveString(sSubstr, sString: string):string;
|* 08/11/2006:  Daniel Simoes de Almeida
|*   - Declara�oes de Fun�oes revistas para maior desempenho (usando const)
|* 04/10/2006:  Rodrigo Fruhwirth
|*   - Corrigida BCDToAsc, quando valores n�o numericos
|* 01/11/2007:  Daniel Simoes de Almeida
|*   - Adiconada as fun��es HexToAscii e AsciiToHex ;
******************************************************************************}

{$I ACBr.inc}
{$ifdef FPC}
  {$DEFINE INC_FPC_D5}
{$ENDIF}
{$IFNDEF COMPILER6_UP}
  {$DEFINE INC_FPC_D5}
{$ENDIF}

{$DEFINE INC_FunctionDetect}
{$IFDEF LINUX}
   {$IFDEF FPC}
      {$UNDEF INC_FunctionDetect}
   {$ENDIF}
{$ENDIF}

unit ACBrUtil;

interface
Uses SysUtils, Math, Classes,
    {$IFDEF COMPILER6_UP} StrUtils, DateUtils, {$ELSE} ACBrD5, FileCtrl, {$ENDIF}
    {$ifdef MSWINDOWS}
      Windows, ShellAPI
    {$else}
      {$IFNDEF FPC}
        Libc
      {$else}
        unix
      {$endif}
    {$endif} ;

function TruncFix( X : Double ) : Integer ;

function TestBit(const Value: Integer; const Bit: Byte): Boolean;
function IntToBin (value: LongInt; digits: integer ): string;
function BinToInt(Value: String): LongInt;

Function BcdToAsc( const StrBCD : String) : String ;
Function AscToBcd( const ANumStr: String ; const TamanhoBCD : Byte) : String ;

Function HexToAscii(const HexStr : String) : String ;
Function AsciiToHex(const AString: string): string;

function padL(const AString : string; const nLen : Integer;
   const Caracter : Char = ' ') : String;
function padR(const AString : string; const nLen : Integer;
   const Caracter : Char = ' ') : String;
function padC(const AString : string; const nLen : Integer;
   const Caracter : Char = ' ') : String;
function padS(const AString : string; const nLen : Integer; Separador : String;
   const Caracter : Char = ' ') : String ;
function RemoveString(const sSubStr, sString: string): string;
function RandomName(const LenName : Integer = 8) : String ;

{ PosEx, retirada de StrUtils.pas do D7, para compatibilizar com o Delphi 6
  (que nao possui essa fun�ao) }
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;

{$ifdef INC_FPC_D5}
  type TRoundToRange = -37..37;
  function RoundTo(const AValue: Double; const ADigit: TRoundToRange): Double;
  function SimpleRoundTo(const AValue: Double; const ADigit: TRoundToRange = -2): Double;

  { IfThens retirada de Math.pas do D7, para compatibilizar com o Delphi 5 e FPC
  (que nao possuem essas fun�ao) }
  function IfThen(AValue: Boolean; const ATrue: Integer; const AFalse: Integer = 0): Integer; overload;
  function IfThen(AValue: Boolean; const ATrue: Int64; const AFalse: Int64 = 0): Int64; overload;
  function IfThen(AValue: Boolean; const ATrue: Double; const AFalse: Double = 0.0): Double; overload;

  { IfThens retirada de StrUtils.pas do D7, para compatibilizar com o Delphi 5 e FPC
  (que nao possuem essas fun�ao) }
  function IfThen(AValue: Boolean; const ATrue: string;
    AFalse: string = ''): string; overload;

{$endif}

function PosAt(const SubStr, S: string; Ocorrencia : Cardinal = 1): Integer;
function PosLast(const SubStr, S: string): Integer;
function CountStr(const AString, SubStr : string ) : Integer ;
Function Poem_Zeros(const Texto : String; const Tamanho : Integer) : String;
Function IntToStrZero(const NumInteiro, Tamanho : Integer) : String;

Function StringToFloat( NumString : String ) : Double ;
Function StringToFloatDef( const NumString : String ;
   const DefaultValue : Double ) : Double ;
Function StringToDateTime( const DateTimeString : String ) : TDateTime ;
Function StringToDateTimeDef( const DateTimeString : String ;
   const DefaultValue : TDateTime ) : TDateTime ;

function StoD( YYYYMMDDhhnnss: String) : TDateTime;
function DtoS( ADate : TDateTime) : String;
function DTtoS( ADateTime : TDateTime) : String;

function StrIsAlpha(const S: String): Boolean;
function StrIsAlphaNum(const S: String): Boolean;
function StrIsNumber(const S: String): Boolean;
function CharIsAlpha(const C: Char): Boolean;
function CharIsAlphaNum(const C: Char): Boolean;
function CharIsNum(const C: Char): Boolean;
function OnlyNumber(const Value: string): String;
function OnlyAlpha(const Value: string): String;
function OnlyAlphaNum(const Value: string): String;
function StrIsIP(const Value: string): Boolean;

function TiraAcentos( const AString : String ) : String ;
function TiraAcento( const AChar : Char ) : Char ;
function TraduzComando( AString : String ) : String ;
Function StringToAsc( AString : String ) : String ;
Function AscToString( AString : String ) : String ;

function InPort(const PortAddr:word): byte;
procedure OutPort(const PortAddr: word; const Databyte: byte); overload ;

function StrCrypt(const AString, StrChave: string): string;
function SomaAscII(const AString : string): Integer;
function StringCrc16(AString : String ) : word;

Function FilesExists(const FileMask: string) : Boolean ;
Procedure DeleteFiles(const FileMask: string)  ;
function CopyFileTo(const AFromFileName, AToFileName : String;
   const AFailIfExists : Boolean = false) : Boolean;
Function PathWithDelim( const APath : String ) : String ;
Procedure CopyFilesToDir( FileMask : String ; ToDirName : String;
   const ForceDirectory : Boolean = False)  ;
procedure RunCommand(Command: String; Params: String = ''; Wait : Boolean = false;
   WindowState : Word = 5);
procedure OpenURL( const URL : String ) ;
{$IFDEF INC_FunctionDetect}
function FunctionDetect (LibName, FuncName: String; var LibPointer: Pointer): boolean;
{$ENDIF}
Procedure DesligarMaquina(Reboot: Boolean = False; Forcar: Boolean = False) ;
Procedure WriteToTXT( const ArqTXT, AString : String; const AppendIfExists : Boolean = True);

implementation
var Randomized : Boolean ;

{$IFDEF MSWINDOWS}
var xInp32 : function (wAddr: word): byte; stdcall;
var xOut32 : function (wAddr: word; bOut: byte): byte; stdcall;
{$ENDIF}

{-----------------------------------------------------------------------------
 Corrige, bug da fun��o Trunc.
 Deve calcular Trunc somente com variaveis e nunca com Expressoes, caso contr�-
 rio o resultado pode n�o ser o esperado.
 // Valores de Teste: Trunc(1,602 x 0,98) | 5 * 12,991 | 2,09 * 23,5 
 -----------------------------------------------------------------------------}
function TruncFix( X : Double ) : Integer ;
begin
  Result := Trunc( SimpleRoundTo( X, -9) ) ;
end ;

{-----------------------------------------------------------------------------
 *** Adaptado de JclLogic.pas  - Project JEDI Code Library (JCL) ***
 Retorna True se o nBit est� ativo (ligado) dentro do valor Value. Inicia em 0
 ---------------------------------------------------------------------------- }
function TestBit(const Value: Integer; const Bit: Byte): Boolean;
Var Base : Byte ;
begin
  Base := (Trunc(Bit/8)+1) * 8 ;
  Result := (Value and (1 shl (Bit mod Base))) <> 0;
end;

{-----------------------------------------------------------------------------
 Extraido de  http://delphi.about.com/od/mathematics/a/baseconvert.htm (Zago)
 Converte um Inteiro para uma string com a representa��o em Bin�rio
 -----------------------------------------------------------------------------}
function IntToBin ( value: LongInt; digits: integer ): string;
begin
    result := StringOfChar ( '0', digits ) ;
    while value > 0 do
    begin
      if ( value and 1 ) = 1 then
        result [ digits ] := '1';
      dec ( digits ) ;
      value := value shr 1;
    end;
end;

{-----------------------------------------------------------------------------
 Extraido de  http://delphi.about.com/od/mathematics/a/baseconvert.htm (Zago)
 converte uma String com a representa��o de Bin�rio para um Inteiro
 -----------------------------------------------------------------------------}
function BinToInt(Value: String): LongInt;
var i: Integer;
begin
  Result := 0;
  
//remove leading zeroes
  while Copy(Value,1,1)='0' do
     Value := Copy(Value,2,Length(Value)-1) ;

//do the conversion
  for i:=Length(Value) downto 1 do
     if Copy(Value,i,1)='1' then
        Result:=Result+(1 shl (i-1)) ;
end;

{-----------------------------------------------------------------------------
  Converte uma String no Formato BCD para uma String que pode ser convertida em
  Integer ou Double.  // Adaptada do manual da Bematech //   Exemplo:
  - Se uma vari�vel retornada for de 7 bytes BCD, e seu valor for R$ 1234,56 os
    7 bytes retornados em caracter (14 d�gitos BCD) ser�o:  00 00 00 00 12 34 56.
    ou chr(00) + chr(00) + chr(00) + chr(00) + chr(12) + chr(34) + chr(56).
    Nesse caso essa fun��o ir� retornar:  "00000000123456"
 ---------------------------------------------------------------------------- }
function BcdToAsc(const StrBCD: String): String;
Var A,BCD_CHAR : Integer ;
    BH,BL,ASC_CHAR : String ;
begin
  result := '' ;

  for A := 1 to Length( StrBCD ) do
  begin
     BCD_CHAR := ord( StrBCD[A] ) ;
     BH := IntToStr( Trunc(BCD_CHAR / 16) ) ;
     If ( BCD_CHAR mod 16 ) > 9 Then        // Corrigido por Rodrigo Fruhwirth
        BL := chr( 48 + BCD_CHAR mod 16 )
     Else
        BL := IntToStr( BCD_CHAR mod 16 ) ;

     ASC_CHAR := BH + BL ;
     result := result + ASC_CHAR
  end ;
end;

{-----------------------------------------------------------------------------
  Converte uma String com Numeros para uma String no Formato BCD
  - TamanhoBCD define quantos bytes a String Resultante deve ter
  - Para transformar o valor for  "123456" em 7 bytes BCD, teriamos:
    00 00 00 00 12 34 56    ou
    chr(00) + chr(00) + chr(00) + chr(00) + chr(12) + chr(34) + chr(56).
 ---------------------------------------------------------------------------- }
Function AscToBcd( const ANumStr: String ; const TamanhoBCD : Byte) : String ;
  Var StrBCD : String ;
      I      : Integer ;
begin
  Result := '' ;

  if not StrIsNumber( ANumStr ) then
     raise Exception.Create('Par�metro "ANumStr" deve conter apenas n�meros') ;

  StrBCD := PadR( ANumStr, TamanhoBCD*2, '0' );
  For I := 1 to TamanhoBCD do
     Result := Result + chr( StrToInt( copy(StrBCD, (I*2)-1, 2) ) ) ;
end ;


{-----------------------------------------------------------------------------
  Converte uma String em HexaDecimal <HexStr> pela sua representa��o em ASCII
  Ex: "C080" em Hexadecimal � igual a "+�" em ASCII que � igual a 49280 que �
      igual a "1100000010000000" em bin�rio
      Portanto se HexStr = "CO80", Result = "+�"
 ---------------------------------------------------------------------------- }
Function HexToAscii(const HexStr: String) : String ;
 Var  B : Byte ;
      Cmd : String ;
begin
  Result := '' ;
  Cmd    := Trim(HexStr) ;
  while Cmd <> '' do
  begin
     B   := StrToIntDef('$'+copy(Cmd,1,2),32) ;
     Cmd := Trim(copy(Cmd,3,Length(Cmd))) ;

     Result := Result + chr(B) ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma String pela sua representa��o em HexaDecimal
  Ex: "C080" em Hexadecimal � igual a "+�" em ASCII que � igual a 49280 que �
      igual a "1100000010000000" em bin�rio
      Portanto se AString = "+�", Result = "C080"
 ---------------------------------------------------------------------------- }
function AsciiToHex(const AString: string): string;
 Var I: Integer;
begin
  Result := '' ;
  for I := 1 to Length(AString) do
     Result := Result + IntToHex(Ord(AString[I]), 2);
end;


{-----------------------------------------------------------------------------
  Completa <AString> com <Caracter> a direita, at� o tamanho <nLen>, Alinhando
  a <AString> a Esquerda. Se <AString> for maior que <nLen>, ela ser� truncada
 ---------------------------------------------------------------------------- }
function padL(const AString : string; const nLen : Integer;
   const Caracter : Char) : String ;
begin
  Result := copy(AString,1,nLen) ;
  if Length(Result) < nLen then
     Result := Result + StringOfChar(Caracter, (nLen - Length(Result))) ;
end ;

{-----------------------------------------------------------------------------
  Completa <AString> com <Caracter> a esquerda, at� o tamanho <nLen>, Alinhando
  a <AString> a Direita. Se <AString> for maior que <nLen>, ela ser� truncada
 ---------------------------------------------------------------------------- }
function padR(const AString : string; const nLen : Integer;
   const Caracter : Char) : String ;
begin
  Result := copy(AString,1,nLen) ;
  if Length(Result) < nLen then
     Result := StringOfChar(Caracter, (nLen - Length(Result))) + Result ;
end ;

{-----------------------------------------------------------------------------
 Completa <AString> Centralizando, preenchendo com <Caracter> a esquerda e direita
 ---------------------------------------------------------------------------- }
function padC(const AString : string; const nLen : Integer;
   const Caracter : Char) : String ;
Var nCharLeft : Integer ;
    D : Double ;
begin
  Result    := copy(AString,1,nLen) ;
  D         := (nLen - Length( Result )) / 2 ;
  nCharLeft := Trunc( D ) ;
  Result    := padL( StringOfChar(Caracter, nCharLeft)+Result, nLen, Caracter) ;
end ;

{-----------------------------------------------------------------------------
  Ajusta a <AString> com o tamanho de <nLen> inserindo espa�os no meio,
  substituindo <Separador> por n X <Caracter>  (Justificado)
 ---------------------------------------------------------------------------- }
function padS(const AString : string; const nLen : Integer;
   Separador : String; const Caracter : Char = ' ') : String ;
var StuffStr : String ;
    nSep, nCharSep, nResto, nFeito, Ini : Integer ;
    D : Double ;
begin
  Result := copy(AString,1,nLen) ;
  if Separador = Caracter then  { Troca Separador, senao fica em loop infinito }
  begin
     Result   := StringReplace( Result,Separador,#255,[rfReplaceAll]) ;
     Separador:= #255 ;
  end ;

  nSep   := CountStr( Result, Separador ) ;

  if nSep < 1 then
  begin
     Result := PadL(Result, nLen, Caracter ) ;
     exit ;
  end ;

  Result   := Trim( Result ) ;
  D        := (nLen - (Length(Result)-nSep)) / nSep ;
  nCharSep := Trunc( D ) ;
  nResto   := nLen - ( (Length(Result)-nSep) + (nCharSep*nSep) ) ;
  nFeito   := nSep ;
  StuffStr := StringOfChar( Caracter, nCharSep ) ;

  Ini := Pos( Separador, Result ) ;
  while Ini > 0 do
  begin
     Result := StuffString(Result, Ini, length(Separador),
                 StuffStr + ifthen(nFeito <= nResto, Caracter, '' ) );

     nFeito := nFeito - 1 ;
     Ini := Pos( Separador, Result ) ;
  end ;
end ;

{-----------------------------------------------------------------------------
   Remove uma substring de uma string
 ---------------------------------------------------------------------------- }
function RemoveString(const sSubstr, sString: string): string;
begin
   Result := StringReplace( sString, sSubStr, '', [rfReplaceAll]) ;
end;

{-----------------------------------------------------------------------------
   Remove uma substring de uma string
 ---------------------------------------------------------------------------- }
function RandomName(const LenName : Integer ) : String ;
 Var I, N : Integer ;
     C : Char ;
begin
   if not Randomized then
   begin
      Randomize ;
      Randomized := True ;
   end ;
   
   Result := '' ;

   For I := 1 to LenName do
   begin
      N := Random( 25 ) ;
      C := char( 65 + N ) ;

      Result := Result + C ;
   end ;
end ;

{-----------------------------------------------------------------------------
  Retorna quantas ocorrencias de <SubStr> existem em <AString>
 ---------------------------------------------------------------------------- }
function CountStr(const AString, SubStr : string ) : Integer ;
Var ini : Integer ;
begin
  result := 0 ;
  if SubStr = '' then exit ;

  ini := Pos( SubStr, AString ) ;
  while ini > 0 do
  begin
     Result := Result + 1 ;
     ini    := PosEx( SubStr, AString, ini + 1 ) ;
  end ;
end ;

{$ifdef INC_FPC_D5}
function RoundTo(const AValue: Double; const ADigit: TRoundToRange): Double;
var
  LFactor: Double;
begin
  LFactor := IntPower(10, ADigit);
  Result := Round(AValue / LFactor) * LFactor;
end;

function SimpleRoundTo(const AValue: Double; const ADigit: TRoundToRange = -2): Double;
var
  LFactor: Double;
begin
  LFactor := IntPower(10, ADigit);
  Result := Trunc((AValue / LFactor) + 0.5) * LFactor;
end;

function IfThen(AValue: Boolean; const ATrue: Integer; const AFalse: Integer): Integer;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Int64; const AFalse: Int64): Int64;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: Double; const AFalse: Double): Double;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function IfThen(AValue: Boolean; const ATrue: string;
  AFalse: string = ''): string;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

{$endif}

{-----------------------------------------------------------------------------
 *** PosEx, retirada de StrUtils.pas do Borland Delphi ***
  para compatibilizar com o Delphi 6  (que nao possui essa fun�ao)
 ---------------------------------------------------------------------------- }
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

{-----------------------------------------------------------------------------
  Acha a e-nesima "Ocorrencia" de "SubStr" em "S"
 ---------------------------------------------------------------------------- }
function PosAt(const SubStr, S: string; Ocorrencia : Cardinal = 1): Integer;
Var Count : Cardinal ;
begin
  Result := Pos( SubStr, S) ;
  Count  := 1 ;
  while (Count < Ocorrencia) and (Result > 0) do
  begin
     Result := PosEx( SubStr, S, Result+1) ;
     Count  := Count + 1 ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Acha a Ultima "Ocorrencia" de "SubStr" em "S"
 ---------------------------------------------------------------------------- }
function PosLast(const SubStr, S: string ): Integer;
Var P : Integer ;
begin
  Result := 0 ;
  P := Pos( SubStr, S) ;
  while P <> 0 do
  begin
     Result := P ;
     P := PosEx( SubStr, S, P+1) ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Insere ZEROS (0) a esquerda de <Texto> at� completar <Tamanho> 
 ---------------------------------------------------------------------------- }
Function Poem_Zeros(const Texto : String; const Tamanho : Integer) : String;
begin
  Result := PadR(Trim(Texto),Tamanho,'0') ;
end ;

{-----------------------------------------------------------------------------
  Transforma <NumInteiro> em String, preenchendo com Zeros a Esquerda at�
  atingiros digitos de <Tamnho>
 ---------------------------------------------------------------------------- }
Function IntToStrZero(const NumInteiro, Tamanho : Integer) : String;
begin
  Result := '' ;
  try
     Result := IntToStr( NumInteiro ) ;
     Result := Poem_Zeros( Result, Tamanho) ;
  except
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma <NumString> para Double, semelhante ao StrToFloatDef, mas
  verifica se a virgula � '.' ou ',' efetuando a convers�o se necess�rio
  Se n�o for possivel converter, retorna <DefaultValue>
 ---------------------------------------------------------------------------- }
Function StringToFloatDef( const NumString : String ;
   const DefaultValue : Double ) : Double ;
begin
  try
     Result := StringToFloat( NumString ) ;
  except
     Result := DefaultValue ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma <NumString> para Double, semelhante ao StrToFloat, mas
  verifica se a virgula � '.' ou ',' efetuando a convers�o se necess�rio
  Se n�o for possivel converter, retorna <DefaultValue>
 ---------------------------------------------------------------------------- }
Function StringToFloat( NumString : String ) : Double ;
begin
  NumString := Trim( NumString ) ;
  
  if DecimalSeparator <> '.' then
     NumString := StringReplace(NumString,'.',DecimalSeparator,[rfReplaceAll]) ;

  if DecimalSeparator <> ',' then
     NumString := StringReplace(NumString,',',DecimalSeparator,[rfReplaceAll]) ;

  Result := StrToFloat(NumString)
end ;

{-----------------------------------------------------------------------------
  Converte uma <DateTimeString> para TDateTime, semelhante ao StrToDateTimeDef,
  mas verifica se o seprador da Data � compativo com o S.O., efetuando a
  convers�o se necess�rio. Se n�o for possivel converter, retorna <DefaultValue>
 ---------------------------------------------------------------------------- }
Function StringToDateTimeDef( const DateTimeString : String ;
   const DefaultValue : TDateTime ) : TDateTime ;
begin
  try
     Result := StringToDateTime( DateTimeString ) ;
  except
     Result := DefaultValue ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma <DateTimeString> para TDateTime, semelhante ao StrToDateTimeDef,
  mas verifica se o seprador da Data � compativo com o S.O., efetuando a
  convers�o se necess�rio. Se n�o for possivel converter, retorna <DefaultValue>
 ---------------------------------------------------------------------------- }
Function StringToDateTime( const DateTimeString : String ) : TDateTime ;
begin
   Result := StrToDateTime( Trim(
                StringReplace(DateTimeString,'/',DateSeparator, [rfReplaceAll])) )
end ;

{-----------------------------------------------------------------------------
  Converte uma String no formato YYYYMMDDhhnnss  para TDateTime
 ---------------------------------------------------------------------------- }
function StoD( YYYYMMDDhhnnss: String) : TDateTime;
  Var OldShortDateFormat : String ;
begin
  YYYYMMDDhhnnss := trim( YYYYMMDDhhnnss ) ;
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'yyyy/mm/dd' ;
     Result := StrToDate(copy(YYYYMMDDhhnnss, 1,4) + DateSeparator +
                         copy(YYYYMMDDhhnnss, 5,2) + DateSeparator +
                         copy(YYYYMMDDhhnnss, 7,2)) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
  if Length( YYYYMMDDhhnnss ) > 8 then  { Informou Hora:minuto:segundos ? }
  begin
     Result := RecodeHour(  Result, StrToIntDef(copy(YYYYMMDDhhnnss, 9,2),0) ) ;
     Result := RecodeMinute(result, StrToIntDef(copy(YYYYMMDDhhnnss,11,2),0) ) ;
     Result := RecodeSecond(result, StrToIntDef(copy(YYYYMMDDhhnnss,13,2),0) ) ;
  end ;

end;

{-----------------------------------------------------------------------------
  Converte um TDateTime para uma String no formato YYYYMMDD
 ---------------------------------------------------------------------------- }
function DtoS( ADate : TDateTime) : String;
begin
  Result := FormatDateTime('yyyymmdd', ADate ) ;
end ;

{-----------------------------------------------------------------------------
  Converte um TDateTime para uma String no formato YYYYMMDDhhnnss
 ---------------------------------------------------------------------------- }
function DTtoS( ADateTime : TDateTime) : String;
begin
  Result := FormatDateTime('yyyymmddhhnnss', ADateTime ) ;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <S> contem apenas caracteres Alpha maiusculo/minuscula
 ---------------------------------------------------------------------------- }
function StrIsAlpha(const S: String): Boolean;
Var A : Integer ;
begin
  Result := true ;
  A      := 1 ;
  while Result and ( A <= Length( S ) )  do
  begin
     Result := CharIsAlpha( S[A] ) ;
     Inc(A) ;
  end;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <S> contem apenas caracteres Numericos
 ---------------------------------------------------------------------------- }
function StrIsNumber(const S: String): Boolean;
Var A : Integer ;
begin
  Result := true ;
  A      := 1 ;
  while Result and ( A <= Length( S ) )  do
  begin
     Result := CharIsNum( S[A] ) ;
     Inc(A) ;
  end;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <S> contem apenas caracteres Alpha maiusculo/minuscula
  ou Numericos
 ---------------------------------------------------------------------------- }
function StrIsAlphaNum(const S: String): Boolean;
Var A : Integer ;
begin
  Result := true ;
  A      := 1 ;
  while Result and ( A <= Length( S ) )  do
  begin
     Result := CharIsAlphaNum( S[A] ) ;
     Inc(A) ;
  end;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <C> � Alpha maiusculo/minusculo 
 ---------------------------------------------------------------------------- }
function CharIsAlpha(const C: Char): Boolean;
begin
  Result := ( C in ['A'..'Z','a'..'z'] ) ;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <C> � N�merico 
 ---------------------------------------------------------------------------- }
function CharIsNum(const C: Char): Boolean;
begin
  Result := ( C in ['0'..'9'] ) ;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <C> � Alpha maiusculo/minusculo ou Numerico
 ---------------------------------------------------------------------------- }
function CharIsAlphaNum(const C: Char): Boolean;
begin
  Result := ( CharIsAlpha( C ) or CharIsNum( C ) );
end ;

{-----------------------------------------------------------------------------
  Retorna uma String apenas com os char Numericos contidos em <Value>
 ---------------------------------------------------------------------------- }
function OnlyNumber(const Value: string): String;
Var I : Integer ;
begin
  Result := '' ;
  For I := 1 to Length( Value ) do
  begin
     if CharIsNum( Value[I] ) then
        Result := Result + Value[I] ;
  end;
end ;

{-----------------------------------------------------------------------------
  Retorna uma String apenas com os char Alpha contidos em <Value>
 ---------------------------------------------------------------------------- }
function OnlyAlpha(const Value: string): String;
Var I : Integer ;
begin
  Result := '' ;
  For I := 1 to Length( Value ) do
  begin
     if CharIsAlpha( Value[I] ) then
        Result := Result + Value[I] ;
  end;
end ;
{-----------------------------------------------------------------------------
  Retorna uma String apenas com os char Alpha-Numericos contidos em <Value>
 ---------------------------------------------------------------------------- }
function OnlyAlphaNum(const Value: string): String;
Var I : Integer ;
begin
  Result := '' ;
  For I := 1 to Length( Value ) do
  begin
     if CharIsAlphaNum( Value[I] ) then
        Result := Result + Value[I] ;
  end;
end ;

{-----------------------------------------------------------------------------
 ** Baseada em "IsIp" de synautil.pas - Synapse http://www.ararat.cz/synapse/ **
  Retorna <True> se <Value> � um IP Valido
 ---------------------------------------------------------------------------- }
function StrIsIP(const Value: string): Boolean;
var
  TempIP : string;
  function ByteIsOk(const Value: string): Boolean;
  var
    x: integer;
  begin
    x := StrToIntDef(Value, -1);
    Result := (x >= 0) and (x < 256);
    // X may be in correct range, but value still may not be correct value!
    // i.e. "$80"
    if Result then
       Result := StrIsNumber( Value ) ;
  end;

  function Fetch(var Value: string; const Delimiter: string): string;
  var
    p : Integer ;
  begin
    p := pos(Delimiter,Value) ;
    Result := copy(Value, 1, p-1);
    Value  := copy(Value, p+1, Length(Value)); 
  end;
begin
  TempIP := Value;
  Result := False;
  if not ByteIsOk(Fetch(TempIP, '.')) then
    Exit;
  if not ByteIsOk(Fetch(TempIP, '.')) then
    Exit;
  if not ByteIsOk(Fetch(TempIP, '.')) then
    Exit;
  if ByteIsOk(TempIP) then
    Result := True;
end;

{-----------------------------------------------------------------------------
  Substitui todos os caracteres acentuados por compativeis.  
 ---------------------------------------------------------------------------- }
function TiraAcentos( const AString : String ) : String ;
Var A : Integer ;
    Letra : Char ;
begin
  Result := '' ;
  For A := 1 to Length( AString ) do
  begin
     Letra := TiraAcento( AString[A] ) ;
     if not (Letra in [#32..#126,#13,#10]) then    {Letras / numeros / pontos / sinais}
        Letra := ' ' ;
     Result := Result + Letra ;
  end
end ;

{-----------------------------------------------------------------------------
  Substitui caracter acentuado por compativel
 ---------------------------------------------------------------------------- }
function TiraAcento( const AChar : Char ) : Char ;
begin
  case AChar of
    '�','�','�','�','�' : Result := 'a' ;
    '�','�','�','�','�' : Result := 'A' ;
    '�','�',    '�','�' : Result := 'e' ;
    '�','�',    '�','�' : Result := 'E' ;
    '�','�',    '�','�' : Result := 'i' ;
    '�','�',    '�','�' : Result := 'I' ;
    '�','�','�','�','�' : Result := 'o' ;
    '�','�','�','�','�' : Result := 'O' ;
    '�','�',    '�','�' : Result := 'u' ;
    '�','�',    '�','�' : Result := 'U' ;
    '�'                 : Result := 'c' ;
    '�'                 : Result := 'C' ;
    '�'                 : Result := 'n' ;
    '�'                 : Result := 'N' ;
  else
    Result := AChar ;
  end;
end ;

{-----------------------------------------------------------------------------
  Traduz Strings do Tipo '#13,v,#10', substituindo #nn por chr(nn). Ignora todo
   texto apos a String ' | '
 ---------------------------------------------------------------------------- }
function TraduzComando( AString : String ) : String ;
Var A : Integer ;
begin
  A := pos(' | ',AString) ;
  if A > 0 then
     AString := copy(AString,1,A-1) ;   { removendo texto apos ' | ' }

  Result := AscToString( AString ) ;
end ;

{-----------------------------------------------------------------------------
  Traduz Strings do Tipo chr(13)+chr(10) para uma representa��o que possa ser
   lida por AscToString Ex: '#13,#10'
 ---------------------------------------------------------------------------- }
function StringToAsc( AString: String): String;
Var A : Integer ;
begin
  Result := '' ;
  For A := 1 to Length( AString ) do
     Result := Result + '#'+IntToStr( Ord( AString[A] ) )+',' ;

  Result := copy(Result,1, Length( Result )-1 ) ;
end;

{-----------------------------------------------------------------------------
  Traduz Strings do Tipo '#13,v,#10', substituindo #nn por chr(nn).
  Usar , para separar um campo do outro... No exemplo acima o resultado seria
  chr(13)+'v'+chr(10) 
 ---------------------------------------------------------------------------- }
function AscToString(AString: String): String;
Var A : Integer ;
    Token : String ;
    C : Char ;
begin
  AString := Trim( AString ) ;
  Result  := '' ;
  A       := 1  ;
  Token   := '' ;

  while A <= length( AString ) + 1 do
  begin
     if A > length( AString ) then
        C := ','
     else
        C := AString[A] ;

     if (C = ',') and (Length( Token ) >= 1) then
      begin
        if Token[1] = '#' then
        try
           Token := chr( StrToInt( copy(Token,2,length(Token)) ) ) ;
        except
        end ;

        Result := Result + Token ;
        Token := '' ;
      end
     else
        Token := Token + C ;

     A := A + 1 ;
  end ;
end;

{-----------------------------------------------------------------------------
 Retorna a String <AString> encriptada por <StrChave>.
 Use a mesma chave para Encriptar e Desencriptar
 ---------------------------------------------------------------------------- }
function StrCrypt(const AString, StrChave: string): string;
var
  i, TamanhoString, pos, PosLetra, TamanhoChave: Integer;
begin
  Result        := AString;
  TamanhoString := Length(AString);
  TamanhoChave  := Length(StrChave);

  for i := 1 to TamanhoString do
  begin
     pos := (i mod TamanhoChave);
     if pos = 0 then
        pos := TamanhoChave;

     posLetra := ord(Result[i]) xor ord(StrChave[pos]);
     if posLetra = 0 then
        posLetra := ord(Result[i]);

     Result[i] := chr(posLetra);
  end;
end ;

{-----------------------------------------------------------------------------
 Retorna a soma dos Valores ASCII de todos os char de <AString>
 -----------------------------------------------------------------------------}
function SomaAscII(const AString : string): Integer;
Var A , TamanhoString : Integer ;
begin
  Result        := 0 ;
  TamanhoString := Length(AString);

  For A := 1 to TamanhoString do
     Result := Result + ord( AString[A] ) ;
end ;

{-----------------------------------------------------------------------------
 Retorna valor de CRC16 de <AString>    http://www.ibrtses.com/delphi/dcrc.html
 -----------------------------------------------------------------------------}
function StringCrc16(AString : String ):word;

  procedure ByteCrc(data:byte;var crc:word);
   Var i : Byte;
  begin
    For i := 0 to 7 do
    begin
       if ((data and $01) xor (crc and $0001)<>0) then
        begin
          crc := crc shr 1;
          crc := crc xor $A001;
        end
       else
          crc := crc shr 1;

       data := data shr 1; // this line is not ELSE and executed anyway.
    end;
  end;

  var len,i : integer;
begin
 len    := length(AString);
 Result := 0;

 for i := 1 to len do
    bytecrc( ord( AString[i] ), Result);
end;


{-----------------------------------------------------------------------------
 L� 1 byte de uma porta de Hardware
 Nota: - Essa fun�ao funciona normalmente em Win9x,
        - XP /NT /2000, deve-se usar um device driver que permita acesso direto
          a porta do Hardware a ser acessado (consulte o fabricante do Hardware)
        - Linux: � necess�rio ser ROOT para acessar man man
          (use: su  ou  chmod u+s SeuPrograma )
 ---------------------------------------------------------------------------- }
{$WARNINGS OFF}
function InPort(const PortAddr:word): byte;
{$IFDEF LINUX}
var Buffer : Pointer ;
    FDevice : String ;
    N : Integer ;
    FHandle : Integer ;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if Assigned( xInp32 ) then
     Result := xInp32(PortAddr)
  else
    asm
        mov dx,PortAddr ;
        in al,dx
        mov Result,al
     end;
{$ELSE}
  FDevice := '/dev/port' ;
  Buffer  := @Result ;

  FHandle := FileOpen(FDevice, fmOpenRead);
  if FHandle <= 0 then
     raise Exception.Create('Erro abrindo:  '+FDevice+#10+#10+
                            'Voc� deve ter direito de Leitura nesse diret�rio.');
  try
     N := FileSeek( FHandle, PortAddr, 0 )  ;
     if N <= 0 then
        raise Exception.Create('Erro ao acessar a porta: '+IntToStr(PortAddr));


     N := FileRead(FHandle, Buffer^, 1) ;
     if N <= 0 then
        raise Exception.Create('Erro ao ler a porta: '+IntToStr(PortAddr));
  finally
     FileClose( FHandle );
  end ;
{$ENDIF}
end ;
{$WARNINGS ON}

{-----------------------------------------------------------------------------
 Envia 1 byte para uma porta de Hardware 
 Nota: - Essa fun�ao funciona normalmente em Win9x,
        - XP /NT /2000, deve-se usar um device driver que permita acesso direto
          a porta do Hardware a ser acessado (consulte o fabricante do Hardware)
        - Linux: � necess�rio ser ROOT para acessar /dev/port
          (use: su  ou  chmod u+s SeuPrograma ) 
 ---------------------------------------------------------------------------- }
procedure OutPort(const PortAddr: word; const Databyte: byte);
{$IFDEF LINUX}
var Buffer : Pointer ;
    FDevice : String ;
    N : Integer ;
    FHandle : Integer ;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  if Assigned( xOut32 ) then
     xOut32(PortAddr, Databyte)
  else
     asm
        mov al, Databyte
        mov dx,PortAddr
        out dx,al
     end;
{$ELSE}
  Buffer := @Databyte ;
  FDevice := '/dev/port' ;

  FHandle := FileOpen(FDevice, fmOpenWrite);
  if FHandle <= 0 then
     raise Exception.Create('Erro abrindo:  '+FDevice+#10+#10+
                            'Voc� deve ter direito de Escrita nesse diret�rio.');
  try
     N := FileSeek( FHandle, PortAddr, 0 )  ;
     if N <= 0 then
        raise Exception.Create('Erro ao acessar a porta: '+IntToStr(PortAddr));

     N := FileWrite(Fhandle, Buffer^, 1) ;
     if N <= 0 then
        raise Exception.Create('Erro ao escrever na porta: '+IntToStr(PortAddr));
  finally
     FileClose( FHandle );
  end ;
//sleep(2)
{$ENDIF}
end ;

{-----------------------------------------------------------------------------
  Semelhante a FileExists, mas permite uso de mascaras Ex:(*.BAK, TEST*.PX, etc)
 ---------------------------------------------------------------------------- }
Function FilesExists(const FileMask: string) : Boolean ;
var SearchRec : TSearchRec ;
    RetFind   : Integer ;
    LastFile  : string ;
begin
  LastFile := '' ;
  Result   := false ;
  RetFind  := SysUtils.FindFirst(FileMask, faAnyFile, SearchRec) ;
  try
     while (not Result) and (RetFind = 0) and (LastFile <> SearchRec.Name) do
     begin
        LastFile := SearchRec.Name ;
        Result   := (pos(LastFile, '..') = 0) ;   { ignora . e .. }
        SysUtils.FindNext(SearchRec) ;
     end ;
  finally
     SysUtils.FindClose(SearchRec) ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Semelhante a DeleteFile, mas permite uso de mascaras Ex:(*.BAK, TEST*.PX, etc)
  Gera Exce��o se n�o conseguir apagar algum dos arquivos.
 ---------------------------------------------------------------------------- }
Procedure DeleteFiles(const FileMask: string)  ;
var SearchRec : TSearchRec ;
    RetFind   : Integer ;
    LastFile  : string ;
    Path      : String ;
begin
  LastFile := '' ;
  Path     := ExtractFilePath(FileMask) ;
  RetFind  := SysUtils.FindFirst(FileMask, faAnyFile, SearchRec);
  try
     while (RetFind = 0) and (LastFile <> SearchRec.Name) do
     begin
        LastFile := SearchRec.Name ;

        if pos(LastFile, '..') = 0 then    { ignora . e .. }
        begin
           if not SysUtils.DeleteFile(Path + LastFile) then
             raise Exception.Create('Erro ao apagar: ' + Path + LastFile);
        end ;

        SysUtils.FindNext(SearchRec) ;
     end ;
  finally
     SysUtils.FindClose(SearchRec) ;
  end ;
end ;

{-----------------------------------------------------------------------------
 *** CopyFileTo Extraida de idGlobals.pas - INDY ***
 Copia arquivo "AFromFilename" para "AToFilename".  Retorna true se OK
 Nao copia, e retorna false se o destino "AToFilename" j� existir e
   "AFailIfExists"  for true
 ---------------------------------------------------------------------------- }
function CopyFileTo(const AFromFileName, AToFileName : String;
   const AFailIfExists : Boolean) : Boolean;
{$IFNDEF MSWINDOWS}
var LStream : TStream;
{$ENDIF}
begin
  {$IFDEF MSWINDOWS}
    Result := CopyFile(PChar(AFromFileName), PChar(AToFileName), AFailIfExists);
  {$ELSE}
    if FileExists(AToFileName) and AFailIfExists then
       Result := False
    else
     begin
       LStream := TFileStream.Create(AFromFileName, fmOpenRead or fmShareDenyWrite);
       try
          with TFileStream.Create(AToFileName, fmCreate) do
             try
                CopyFrom(LStream, 0);
             finally
                Free;
             end;
       finally
          FreeAndNil(LStream);
       end;
       Result := True;
     end;
  {$ENDIF}
end;

{-----------------------------------------------------------------------------
  Verifica se <APath> possui "PathDelim" no final. Retorna String com o Path
  j� ajustado
 ---------------------------------------------------------------------------- }
Function PathWithDelim( const APath : String ) : String ;
begin
  Result := Trim(APath) ;
  if Result <> '' then
     if RightStr(Result,1) <> PathDelim then   { Tem delimitador no final ? }
        Result := Result + PathDelim ;
end ;

{-----------------------------------------------------------------------------
  Copia todos os arquivos especificados na mascara <FileMask> para o diret�rio
  <ToDirName>   Gera Exce��o se n�o conseguir copiar algum dos arquivos.
 ---------------------------------------------------------------------------- }
Procedure CopyFilesToDir(FileMask: string; ToDirName : String;
   const ForceDirectory : Boolean)  ;
var SearchRec : TSearchRec ;
    RetFind   : Integer ;
    LastFile  : string ;
    Path      : String ;
begin
  ToDirName := PathWithDelim(ToDirName) ;
  FileMask  := Trim(FileMask) ;

  if ToDirName = '' then
     raise Exception.Create('Diret�rio destino n�o especificado') ;

  if not DirectoryExists(ToDirName) then
  begin
     if not ForceDirectory then
        raise Exception.Create('Diret�rio ('+ToDirName+') n�o existente.')
     else
      begin
        ForceDirectories( ToDirName ) ;  { Tenta criar o diret�rio }
        if not DirectoryExists( ToDirName ) then
           raise Exception.Create( 'N�o foi possivel criar o diret�rio' + sLineBreak +
                                   ToDirName);
      end ;
  end ;

  LastFile := '' ;
  Path     := ExtractFilePath(FileMask) ;
  RetFind  := SysUtils.FindFirst(FileMask, faAnyFile, SearchRec);
  try
     while (RetFind = 0) and (LastFile <> SearchRec.Name) do
     begin
        LastFile := SearchRec.Name ;

        if pos(LastFile, '..') = 0 then    { ignora . e .. }
        begin
           if not CopyFileTo(Path + LastFile, ToDirName + LastFile) then
             raise Exception.Create('Erro ao Copiar o arquivo ('+
                  Path + LastFile + ') para o diret�rio ('+ToDirName+')') ;
        end ;

        SysUtils.FindNext(SearchRec) ;
     end ;
  finally
     SysUtils.FindClose(SearchRec) ;
  end ;
end ;

{-----------------------------------------------------------------------------
 - Executa programa Externo descrito em "Command", adcionando os Parametros
   "Params" na linha de comando
 - Se "Wait" for true para a execu��o da aplica��o para esperar a conclusao do
   programa externo executado por "Command"
 - WindowState apenas � utilizado na plataforma Windows
 ---------------------------------------------------------------------------- }
procedure RunCommand(Command: String; Params: String; Wait : Boolean;
   WindowState : Word);
var
  {$ifdef MSWINDOWS}
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  Executed : Boolean ;
  PCharStr : PChar ;
  {$endif}
  ConnectCommand : PChar;
begin
  {$ifdef LINUX}
     Command := Trim(Command + ' ' + Params) ;
     if not Wait then
        Command := Command + ' &' ;  { & = Rodar em BackGround }
     {$IFNDEF FPC}
       ConnectCommand := PChar(Command);
       Libc.system(ConnectCommand);
     {$ELSE}
       Shell(Command)
     {$ENDIF}
  {$endif}
  {$ifdef MSWINDOWS}
     Command  := Trim(Command) ;
     PCharStr := PChar(Trim(Params)) ;
     if Length(PCharStr) = 0 then
        PCharStr := nil ;

     if not Wait then
        ShellExecute(0,'open',PChar(Command),PCharStr, nil, WindowState )
//        winexec(ConnectCommand, WindowState)
     else
      begin
        ConnectCommand := PChar(Trim(Command + ' ' + Params));
        PCharStr := PChar(ExtractFilePath(Command)) ;
        if Length(PCharStr) = 0 then
           PCharStr := nil ;
        FillChar(SUInfo, SizeOf(SUInfo), #0);
        with SUInfo do
        begin
           cb          := SizeOf(SUInfo);
           dwFlags     := STARTF_USESHOWWINDOW;
           wShowWindow := WindowState;
        end;

        Executed := CreateProcess(nil, ConnectCommand, nil, nil, false,
                    CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                    PCharStr, SUInfo, ProcInfo);

        try
           { Aguarda at� ser finalizado }
           if Executed then
              WaitForSingleObject(ProcInfo.hProcess, INFINITE);
        finally
           { Libera os Handles }
           CloseHandle(ProcInfo.hProcess);
           CloseHandle(ProcInfo.hThread);
        end;
      end;
  {$endif}
end;

procedure OpenURL( const URL : String ) ;
{$IFDEF LINUX}
  Var BrowserName : String ;
{$ENDIF}
begin
 {$IFDEF MSWINDOWS}
   RunCommand(URL);
 {$ENDIF}
 {$IFDEF LINUX}
   BrowserName := GetEnvironmentVariable('BROWSER') ;
   if BrowserName = '' then
      BrowserName := 'konqueror' ;

   RunCommand(BrowserName, URL);
 {$ENDIF}
end ;

{-----------------------------------------------------------------------------
 - Tenta desligar a Maquina.
 - Se "Reboot" for true Reinicializa
 *** Vers�o Windows extraida do www.forumweb.com.br/forum  por: Rafael Luiz ***
 ---------------------------------------------------------------------------- }
Procedure DesligarMaquina(Reboot: Boolean = False; Forcar: Boolean = False) ;

{$IFDEF MSWINDOWS}
   function WindowsNT: Boolean;
   var
     osVersao : TOSVersionInfo;
   begin
     osVersao.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
     GetVersionEx(osVersao);
     Result := osVersao.dwPlatformID = VER_PLATFORM_WIN32_NT;
   end;

   procedure ObtemPrivilegios;
   var
     tmpLUID : TLargeInteger;
     hdlProc, hdlToken : THandle;
     tkpNovo, tkpIgnore : TTokenPrivileges;
     dwBuffer, dwIgnoreBuffer : DWord;
   begin
     // Abrir token do processo para ajustar privil�gios
     hdlProc := GetCurrentProcess;
     OpenProcessToken(hdlProc, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
         hdlToken);

     // Obter o identificador �nico do privil�gio de shutdown
     LookupPrivilegeValue('', 'SeShutdownPrivilege', tmpLUID);

     // Habilita o privil�gio de shutdown em novo token
     tkpNovo.PrivilegeCount := 1;
     tkpNovo.Privileges[0].Luid := tmpLUID;
     tkpNovo.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
     dwBuffer := SizeOf(TTokenPrivileges);

     // Ajusta o privil�gio com o novo token
     AdjustTokenPrivileges(hdlToken, False, tkpNovo,
         dwbuffer, tkpIgnore, dwIgnoreBuffer);
   end;


    Var RebootParam : Longword ;
   begin
      if WindowsNT then
         ObtemPrivilegios;

      if Reboot then
         RebootParam := EWX_REBOOT
      else
         RebootParam := EWX_SHUTDOWN  ;

      if Forcar then
         RebootParam := RebootParam or EWX_FORCE ;

      ExitWindowsEx(RebootParam, 0);
   end;

{$ELSE}
   begin
      // Precisa ser o ROOT ou a
      // aplica��o ter provilegios de ROOT  (use: su  ,  chmod u+s SeuPrograma )
      if Reboot then
         RunCommand('reboot')
      else
         RunCommand('halt') ;
   end ;
{$ENDIF}

{-----------------------------------------------------------------------------
 - Grava conteudo de "AString" no arquivo "ArqTXT".
 - Se arquivo "ArqTXT" n�o existir, ser� criado.  Se "ArqTXT" j� existir e
   "Append" for verdadeiro adiciona "AString" no final do arquivo
 ---------------------------------------------------------------------------- }
Procedure WriteToTXT( const ArqTXT, AString : String;
   const AppendIfExists : Boolean = True);
var
  Arq : textfile;
  Existe : Boolean ;
  Tentativas : Integer ;
begin
  Existe     := AppendIfExists and FileExists(ArqTXT) ;
  Tentativas := 0 ;

  repeat
     try
        try
           Inc(Tentativas) ;
           AssignFile( Arq, ArqTXT) ;
           if not Existe then
              Rewrite( Arq )
           else
              Append( Arq ) ;

           Writeln( Arq, AString ) ;
           Tentativas := 2 ;  { Tudo OK, saia do loop }
        finally
           {$I-}
             CloseFile( Arq ) ;
           {$I+}
        end ;
     except
     end ;
   until Tentativas > 1
end;

{$IFDEF INC_FunctionDetect}
{-----------------------------------------------------------------------------
  Tenta carregar a Biblioteca (DLL) <LibName> e veirica se a fun��o <FuncName>
  existe na DLL. Se existir, retorna ponteiro para a DLL em <LibPointer>
  Veja Exempo de uso em InPort e OutPort (logo acima)
  ( Fun��o encontrada na Internet - Autor desconhecido )
 -----------------------------------------------------------------------------}
function FunctionDetect (LibName, FuncName: String; var LibPointer: Pointer): boolean;
var LibHandle: tHandle;
begin
 Result := false;
 LibPointer := NIL;
  if LoadLibrary(PChar(LibName)) = 0 then
     exit;                                 { n�o consegiu ler a DLL }

  LibHandle := GetModuleHandle(PChar(LibName));  { Pega o handle da DLL }
  if LibHandle <> 0 then                    { Se 0 n�o pegou o Handle, falhou }
  begin
     LibPointer := GetProcAddress(LibHandle, PChar(FuncName));{Procura a fun��o}
     if LibPointer <> NIL then
        Result := true;
  end;
end;
{$ENDIF}

(*  *** Exemplo de complo bloquear Mouse / Teclado com a FunctionDetect ***

procedure TForm1.Button1Click(Sender: TObject);
var xBlockInput : function (Block: BOOL): BOOL; stdcall;
begin
 if FunctionDetect ('USER32.DLL', 'BlockInput', @xBlockInput) then
 begin
  xBlockInput (True);  // Disable Keyboard & mouse
   Sleep(10000);       // Wait for for 10 Secounds
  xBlockInput (False); // Enable  Keyboard & mouse
 end;
end;
*)

initialization
{$IFDEF MSWINDOWS}
  if not FunctionDetect('inpout32.dll','Inp32',@xInp32) then
     xInp32 := NIL ;

  if not FunctionDetect('inpout32.dll','Out32',@xOut32) then
     xOut32 := NIL ;
{$ENDIF}

  Randomized := False ;
end.


