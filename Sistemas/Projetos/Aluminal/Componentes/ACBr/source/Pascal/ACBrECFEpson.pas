{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:   Eduardo Durieux Lopes                         }
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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 04/11/2007: Daniel Sim�es de Almeida e Eduardo Durieux Lopes
|* - Primeira Versao: Cria�ao e Distribui�ao da Primeira Versao
|* 04/12/2007: Andre Bohn
|* - Corrigido bug em LerTotaisFormaPagamento
|* - Implementado os m�todos: ImprimeCheque, CancelaImpressaoCheque, 
|*                            GetChequePronto, LeituraCMC7
|* 11/04/2008: Daniel Sim�es de Almeida
|* - Adicionados m�todos: CortaPapel, IdentificaConsumidor, Suprimento
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFEpson ;

interface
uses ACBrECFClass, ACBrBase, ACBrUtil,
     Classes ;

const  STX = #02  ;
       ETX = #03  ;
       ESC = #27  ;
       FLD = #28  ;
       CR  = #13  ;
       LF  = #10  ;
       ACK = 06  ;
       NACK= 21  ;

type

TACBrECFEpsonComando = class
  private
    fsComando : String ;
    fsExtensao: String ;
    fsParams  : TStringList ;
    fsSeq     : Byte ;
    fsTimeOut : Integer;

    function GetFrameEnvio: String;
    procedure SetComando(const Value: String);
    procedure SetExtensao(const Value: String);
    Function InsertEsc(const Campo: String): String ;
 public
    constructor create ;
    destructor destroy ; override ;

    property Comando     : String  write SetComando  ;
    property Extensao    : String  write SetExtensao ;
    property TimeOut     : Integer read fsTimeOut write fsTimeOut ;
    property FrameEnvio  : String  read GetFrameEnvio ;
    property Params      : TStringList read fsParams ;
    property Seq         : Byte read fsSeq  ;

    Procedure AddParam(AString  : String) ;
 end ;

TACBrECFEpsonResposta = class
  private
    fsResposta : String ;

    fsSeq: Byte;
    fsStatusPrinter: Integer;
    fsStatusFiscal : Integer;
    fsRetorno      : String ;
    fsParams       : TStringList ;
    fsChkSum       : String ;

    procedure SetResposta(const Value: String);
    Function RemoveEsc(const Campo: String): String ;
    function GetDescRetorno: String;
 public
    constructor create ;
    destructor destroy ; override ;

    property Resposta     : String      read fsResposta write SetResposta ;
    property Seq          : Byte        read fsSeq;
    property StatusPrinter: Integer     read fsStatusPrinter ;
    property StatusFiscal : Integer     read fsStatusFiscal ;
    property Retorno      : String      read fsRetorno ;
    property DescRetorno  : String      read GetDescRetorno ;
    property Params       : TStringList read fsParams ;
    property ChkSum       : String      read fsChkSum ;
 end ;

{ Classe filha de TACBrECFClass com implementa�ao para Epson }
TACBrECFEpson = class( TACBrECFClass )
 private
    fsNumVersao : String ;
    fsNumECF    : String ;
    fsNumLoja   : String ;
    fsCNPJ      : String ;
    fsIE        : String ;
    fsRet0906   : String ;
    fsRet0907   : String ;
    fsEpsonComando: TACBrECFEpsonComando;
    fsEpsonResposta: TACBrECFEpsonResposta;
    fsImprimeCheque: Boolean;
    fsLeituraCMC7  : Boolean;
    Function  PreparaCmd( cmd : String ) : String ;

    function  GetRet0906: String;
    property  Ret0906 : String read GetRet0906 ;
    function  GetRet0907: String;
    property  Ret0907 : String read GetRet0907 ;
 protected
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumCCF: String; override ;
    function GetNumECF: String; override ;
    function GetNumLoja: String; override ;
    function GetNumSerie: String; override ;
    function GetNumVersao: String; override ;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetHorarioVerao: Boolean; override ;

    function GetCNPJ: String; override ;
    function GetIE: String; override ;
    function GetDataMovimento: TDateTime; override ;
    function GetGrandeTotal: Double; override ;
    function GetNumCRO: String; override ;
    function GetNumCRZ: String; override ;
    function GetVendaBruta: Double; override ;
    function GetTotalAcrescimos: Double; override ;
    function GetTotalCancelamentos: Double; override ;
    function GetTotalDescontos: Double; override ;
    function GetTotalSubstituicaoTributaria: Double; override ;
    function GetTotalNaoTributado: Double; override ;
    function GetTotalIsencao: Double; override ;
    function GetNumCOOInicial: String; override ;
    function GetNumUltimoItem: Integer; override ;

    Function VerificaFimLeitura(var Retorno:String;
       var TempoLimite: TDateTime) : Boolean ; override ;

    function GetChequePronto: Boolean; override ;
 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;

    property EpsonComando : TACBrECFEpsonComando  read fsEpsonComando ;
    property EpsonResposta: TACBrECFEpsonResposta read fsEpsonResposta ;

    Function EnviaComando_ECF( cmd : String = '') : String ; override ;

    Procedure AbreCupom ; override ;
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D' ) ; override ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : String  = '' ) ; override ;
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : String = ''; ImprimeVinculado : Boolean = false) ;
       override ;
    Procedure FechaCupom( Observacao : String = '') ; override ;
    Procedure CancelaCupom ; override ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; override ;

    Procedure LeituraX ; override ;
    Procedure ReducaoZ(DataHora : TDateTime) ; override ;
    Procedure AbreRelatorioGerencial ; override ;
    Procedure LinhaRelatorioGerencial( Linha : String ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : String ) ; override ;
    Procedure FechaRelatorio ; override ;
    Procedure PulaLinhas( NumLinhas : Integer = 0 ) ; override ;

    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;
    Procedure CorrigeEstadoErro(Reducao: Boolean = True) ; override ;


    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime ) ;
       override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer);
       override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       var Linhas : TStringList ) ; override ;

    Procedure AbreGaveta ; override ;

    { Procedimentos de Cupom N�o Fiscal }
    Procedure AbreNaoFiscal( CPF_CNPJ : String = '') ; override ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : String = '' ) ; override ;
    Procedure SubtotalizaNaoFiscal( DescontoAcrescimo : Double = 0;
       MensagemRodape: String = '') ; override ;
    Procedure EfetuaPagamentoNaoFiscal( CodFormaPagto : String; Valor : Double;
       Observacao : String = ''; ImprimeVinculado : Boolean = false) ; override ;
    Procedure FechaNaoFiscal( Observacao : String = '') ; override ;
    Procedure CancelaNaoFiscal ; override ;
    procedure NaoFiscalCompleto(CodCNF: String; Valor: Double;
      CodFormaPagto, Obs: String); override ;

    procedure CarregaAliquotas ; override ;
    procedure LerTotaisAliquota ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;
    function AchaICMSAliquota( var AliquotaICMS : String ) :
       TACBrECFAliquota ;  override;

    procedure CarregaFormasPagamento ; override ;
    procedure LerTotaisFormaPagamento ; override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    procedure LerTotaisComprovanteNaoFiscal ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;
    procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    procedure CancelaImpressaoCheque ; override ;
    Function LeituraCMC7 : String ; override ;

    Procedure IdentificaOperador ( Nome: String); override;
    Procedure CortaPapel( const CorteParcial : Boolean = false) ; override ;
    procedure Suprimento( const Valor: Double; Obs : String;
       DescricaoCNF: String; DescricaoFPG: String) ; override ;

 end ;

function EpsonCheckSum(Dados: String): String;

implementation
Uses ACBrECF,
     {$IFDEF COMPILER6_UP}
       DateUtils, StrUtils
     {$ELSE}
       ACBrD5, Windows
     {$ENDIF},
     SysUtils, Math ;

function EpsonCheckSum(Dados: String): String;
begin
  Result := IntToHex( SomaAscII(Dados), 4);
end;

{ -------------------------  TACBrECFEpsonComando -------------------------- }
constructor TACBrECFEpsonComando.create;
begin
  inherited create ;

  fsParams := TStringList.create ;
  fsSeq    := 129 ;
end;

destructor TACBrECFEpsonComando.destroy;
begin
  fsParams.Free ;

  inherited destroy ;
end;

function TACBrECFEpsonComando.InsertEsc(const Campo: String): String;
 Var I : Integer ;
begin
  Result := '' ;

  For I := 1 to Length(Campo) do
  begin
    if Campo[I] in [#2, #3, #26 .. #31] then
       Result := Result + ESC ;

    Result := Result + Campo[I];
  end ;
end;

procedure TACBrECFEpsonComando.SetComando(const Value: String);
 Var Tamanho : Integer ;
begin
  if fsSeq >= 255 then
     fsSeq := 129
  else
     Inc( fsSeq ) ;

  Tamanho := Length(Trim(Value)) ;
  if (Tamanho <> 2) and (Tamanho <> 4) then
     raise Exception.Create('Comando Epson deve ter 4 Caracteres em Hexadecimal') ;

  { Zerando instrucoes adicionais do comando }
  fsParams.Clear ;
  fsExtensao:= #0 + #0 ;
  fsTimeOut := 0 ;

  if Tamanho = 2 then
     fsComando := Value
  else
     fsComando := InsertEsc( HexToAscii(Value) ) ;
end;

procedure TACBrECFEpsonComando.SetExtensao(const Value: String);
 Var Tamanho : Integer ;
begin
  Tamanho := Length(Trim(Value)) ;
  if (Tamanho <> 2) and (Tamanho <> 4) then
     raise Exception.Create('Extensao de Comando Epson deve ter 4 Caracteres em Hexadecimal') ;

  if Tamanho = 2 then
     fsExtensao := Value
  else
     fsExtensao := InsertEsc( HexToAscii(Value) ) ;
end;

procedure TACBrECFEpsonComando.AddParam(AString: String);
begin
  fsParams.Add( InsertEsc( AString ) ) ;
end;

function TACBrECFEpsonComando.GetFrameEnvio: String;
 Var I : Integer ;
     ParamsStr : String ;
begin
  { Montando pacote com Parametros }
  ParamsStr := '' ;
  For I := 0 to fsParams.Count-1 do
    ParamsStr := ParamsStr + FLD + fsParams[I] ;

  { Montando Pacote de Envio }
  Result := STX + chr(fsSeq) + fsComando + FLD + fsExtensao + ParamsStr + ETX ;

  { Calculando o Checksum }
  Result := Result + EpsonCheckSum( Result ) ;
end;


{ ------------------------- TACBrECFEpsonResposta -------------------------- }

constructor TACBrECFEpsonResposta.create;
begin
  inherited create ;

  fsParams        := TStringList.create ;
  fsSeq           := 0 ;
  fsStatusPrinter := 0 ;
  fsStatusFiscal  := 0 ;
  fsRetorno       := '' ;
  fsChkSum        := '' ;
  fsResposta      := '' ;
end;

destructor TACBrECFEpsonResposta.destroy;
begin
  fsParams.Free ;

  inherited destroy ;
end;

function TACBrECFEpsonResposta.RemoveEsc(const Campo: String): String;
  Var I : Integer ;
  Var Pula : Boolean ;
begin
  Result := '' ;
  I      := 1 ;
  Pula   := True ;
  while I <= Length(Campo) do
  begin
     if (Campo[I] = #27) and Pula then
        Pula := False
     else
      begin
         Result := Result + Campo[I] ;
         Pula   := True ;
      end ;

     Inc( I ) ;
  end ;
end;

procedure TACBrECFEpsonResposta.SetResposta(const Value: String);
Var Buf : String ;
    P   : Integer ;
begin
  fsParams.Clear ;
  fsSeq           := 0 ;
  fsStatusPrinter := 0 ;
  fsStatusFiscal  := 0 ;
  fsRetorno       := '' ;
  fsChkSum        := '' ;
  fsResposta      := '' ;

  if Value = '' then exit ;

  fsResposta := Value ;

  if LeftStr(fsResposta,1) <> STX then
     raise Exception.Create('Resposta inv�lida. N�o inicia com STX (02)') ;

  if copy(fsResposta,Length(fsResposta)-4,1) <> ETX then
     raise Exception.Create('Resposta inv�lida. N�o finaliza com ETX (03)') ;

  fsChkSum := RightStr(fsResposta,4) ;
  if EpsonCheckSum( copy(fsResposta,1,Length(fsResposta)-4) ) <> fsChkSum then
     raise Exception.create('Resposta inv�lida. CheckSum da Resposta n�o est� correto.') ;

  try
     fsSeq := ord(fsResposta[2]) ;
  except
     raise Exception.Create('Resposta inv�lida. Num.Sequencia inv�lido') ;
  end ;

  { Pega apenas o Frame de Dados }
  Buf := copy(fsResposta,3,Length(fsResposta)-7) ;  //  Remove STX, SEQ, ETX e CHKSUM

  { Quebrando Parametros Separados por FLD e inserindo-os em fsParams }
  while Buf <> '' do
  begin
     P := pos(FLD,Buf) ;
     if (P > 1) and (Buf[P-1] = #27) then   // Achou #27+#28 ?
        P := PosEx(FLD,Buf,P+1) ;           // Se SIM, pegue o proximo #28

     if P = 0 then
        P := Length(Buf)+1 ;

     fsParams.Add( RemoveEsc( LeftStr(Buf,P-1) ) ) ;
     Buf := copy(Buf,P+1,Length(Buf)) ;  // Pega pr�ximo bloco
  end ;

  if fsParams.Count < 4 then
     raise Exception.Create('Resposta Incompleta');

  { Removendo Status Printer de fsParams }
  try
     fsStatusPrinter := StrToInt( '$'+AsciiToHex( fsParams[0]  ) ) ;
  except
     on E : Exception do
     begin
        raise Exception.Create('Resposta Inv�lida. Erro ao calcular Status da Impressora'+sLineBreak+
                               E.Message) ;
     end ;
  end ;
  fsParams.Delete(0);

  { Removendo Status Fiscal de fsParams }
  try
     fsStatusFiscal := StrToInt( '$'+AsciiToHex( fsParams[0]  ) ) ;
  except
     on E : Exception do
     begin
        raise Exception.Create('Resposta Inv�lida. Erro ao calcular Status Fiscal'+sLineBreak+
                               E.Message) ;
     end ;
  end ;
  fsParams.Delete(0);

  fsParams.Delete(0);   // Remove da pilha Reservado 1, pois n�o � parametro

  { Removendo Cod.Retorno de fsParams }
  try
     fsRetorno := AsciiToHex( fsParams[0]  ) ;
  except
     on E : Exception do
     begin
        raise Exception.Create('Resposta Inv�lida. Erro ao calcular Cod.Retorno'+sLineBreak+
                               E.Message) ;
     end ;
  end ;
  fsParams.Delete(0);   

  if fsParams.Count > 0 then   // Possui Reservado 2 ?
     if fsParams[0] = '' then
        fsParams.Delete(0);   // Remove da pilha Reservado 2, pois n�o � parametro
end;


function TACBrECFEpsonResposta.GetDescRetorno: String;
 Var  sValorSaida : String;
      sRetorno    : String ;
begin
  sValorSaida := '';
  sRetorno    := HexToAscii(fsRetorno) ;

  Case sRetorno[1] of

    #0 : begin
            Case sRetorno[2] of
              #0 : sValorSaida := '';
              #1 : sValorSaida := 'Erro interno.';
              #2 : sValorSaida := 'Erro de inicia��o do equipamento.';
              #3 : sValorSaida := 'Erro de processo interno.';
            end;
          end;

    #1 : begin
           Case sRetorno[2] of
             #1 : sValorSaida := 'Comando inv�lido para estado atual.';
             #2 : sValorSaida := 'Comando inv�lido para documento atual.';
             #6 : sValorSaida := 'Comando aceito apenas fora de interven��o.';
             #7 : sValorSaida := 'Comando aceito apenas dentro de interven��o.';
             #8 : sValorSaida := 'Comando inv�lido durante processo de scan.';
             #9 : sValorSaida := 'Exce�o de interven��es.';
           end;
         end;

    #2 : begin
           Case sRetorno[2] of
             #1  : sValorSaida := 'Comando com Frame inv�lido.';
             #2  : sValorSaida := 'Comando inv�lido.';
             #3  : sValorSaida := 'Campos em excesso.';
             #4  : sValorSaida := 'Campos em falta.';
             #5  : sValorSaida := 'Campo n�o opcional.';
             #6  : sValorSaida := 'Campo alfanum�rico inv�lido.';
             #7  : sValorSaida := 'Campo alfab�tico inv�lido.';
             #8  : sValorSaida := 'Campo num�rico inv�lido.';
             #9  : sValorSaida := 'Campo bin�rio inv�lido.';
             #10 : sValorSaida := 'Campo imprim�vel inv�lido.';
             #11 : sValorSaida := 'Campo hexadecimal inv�lido.';
             #12 : sValorSaida := 'Campo data inv�lido.';
             #13 : sValorSaida := 'Campo hora inv�lido.';
             #14 : sValorSaida := 'Campos com atributos de impress�o inv�lido.';
             #15 : sValorSaida := 'Campo booleano inv�lido.';
             #16 : sValorSaida := 'Campo com tamanho inv�lido.';
             #17 : sValorSaida := 'Extens�o de comando inv�lida.';
             #18 : sValorSaida := 'C�digo de barras n�o permitido.';
             #19 : sValorSaida := 'Atributos de impress�o n�o permitidos.';
             #20 : sValorSaida := 'Atributos de impress�o inv�lidos.';
             #21 : sValorSaida := 'C�digo de barras incorretamente definido.';
             #22 : sValorSaida := 'Comando inv�lido para a porta selecionada.';
           end;
         end;

    #3 : begin
           Case sRetorno[2] of
             #1  : sValorSaida := 'Erro de hardware.';
             #2  : sValorSaida := 'Impressora n�o est� pronta.';
             #3  : sValorSaida := 'Erro de Impress�o.';
             #4  : sValorSaida := 'Falta de papel.';
             #5  : sValorSaida := 'Pouco papel dispon�vel.';
             #6  : sValorSaida := 'Erro em carga ou expuls�o do papel.';
             #7  : sValorSaida := 'Caracter�stica n�o suportada pela impressora.';
             #8  : sValorSaida := 'Erro de display.';
             #9  : sValorSaida := 'Sequ�ncia de scan inv�lida.';
             #10 : sValorSaida := 'N�mero de �rea de recorte inv�lido.';
             #11 : sValorSaida := 'Scanner n�o preparado.';
             #12 : sValorSaida := 'Qualidade de logotipo n�o suportado pela impressora.';
             #14 : sValorSaida := 'Erro de leitura de microc�digo.';
           end;
         end;

    #4 : begin
           Case sRetorno[2] of
             #1  : sValorSaida := 'N�mero de s�rie inv�lido.';
             #2  : sValorSaida := 'Requer dados de fiscaliza��o j� configurados.';
           end;
         end;

    #5 : begin
           Case sRetorno[2] of
             #1  : sValorSaida := 'Data / Hora n�o configurada.';
             #2  : sValorSaida := 'Data inv�lida.';
             #3  : sValorSaida := 'Data em intervalo inv�lido.';
             #4  : sValorSaida := 'Nome operador inv�lido.';
             #5  : sValorSaida := 'N�mero de caixa inv�lido.';
             #8  : sValorSaida := 'Dados de Cabe�alho ou rodap� inv�lidos.';
             #9  : sValorSaida := 'Excesso de fiscaliza��o.';
             #12 : sValorSaida := 'N�mero m�ximo de meios de pagamento j� definidos.';
             #13 : sValorSaida := 'Meio de pagamento j� definido.';
             #14 : sValorSaida := 'Meio de pagamento inv�lido.';
             #15 : sValorSaida := 'Descri��o do meio de pagamento inv�lido.';
             #16 : sValorSaida := 'Valor m�ximo de desconto inv�lido.';
             #19 : sValorSaida := 'Logotipo do usu�rio inv�lido.';
             #20 : sValorSaida := 'Seq��ncia de logotipo inv�lido.';
             #21 : sValorSaida := 'Configura��o de display inv�lida.';
             #22 : sValorSaida := 'Dados do MICR inv�lidos.';
             #23 : sValorSaida := 'Campo de endere�o inv�lido.';
             #24 : sValorSaida := 'Nome da loja n�o definido.';
             #25 : sValorSaida := 'Dados fiscais n�o definidos.';
             #26 : sValorSaida := 'N�mero seq�encial do ECF inv�lido.';
             #27 : sValorSaida := 'Simbologia do GT inv�lida, devem ser todos diferentes.';
             #28 : sValorSaida := 'N�mero de CNPJ inv�lido.';
             #29 : sValorSaida := 'Senha de fiscaliza��o inv�lida.';
             #30 : sValorSaida := '�ltimo documento deve ser uma redu��o Z.';
             #31 : sValorSaida := 'S�mbolo da moeda igual ao atualmente cadastrado.';
             #32 : sValorSaida := 'Identifica��o da al�quota n�o cadastrada.';
             #33 : sValorSaida := 'Al�quota n�o cadastrada.';
           end;
         end;

    #6 : begin
           Case sRetorno[2] of
             #1  : sValorSaida := 'Mem�ria de Fita-detalhe esgotada.';
             #5  : sValorSaida := 'N�mero de s�rie invalido para a Mem�ria de Fita-detalhe.';
             #6  : sValorSaida := 'Mem�ria de Fita-detalhe n�o iniciada.';
             #7  : sValorSaida := 'Mem�ria de Fita-detalhe n�o pode estar iniciada.';
             #8  : sValorSaida := 'N�mero de s�rie da Mem�ria de Fita-detalhe n�o confere.';
             #9  : sValorSaida := 'Erro Interno na Mem�ria de Fita-detalhe.';
           end;
         end;

    #7 : begin
           Case sRetorno[2] of
             #1  : sValorSaida := 'Valor inv�lido para o n�mero do registro.';
             #2  : sValorSaida := 'Valor inv�lido para o n�mero do item.';
             #3  : sValorSaida := 'Intervalo inv�lido para a leitura da MFD.';
             #4  : sValorSaida := 'N�mero de usu�rio inv�lido para MFD.';
           end;
         end;

    #8 : begin
           Case sRetorno[2] of
             #1  : sValorSaida := 'Comando inv�lido com jornada fiscal fechada.';
             #2  : sValorSaida := 'Comando inv�lido com jornada fiscal aberta.';
             #3  : sValorSaida := 'Mem�ria Fiscal esgotada.';
             #4  : sValorSaida := 'Jornada fiscal deve ser fechada.';
             #5  : sValorSaida := 'N�o h� meios de pagamento definidos.';
             #6  : sValorSaida := 'Excesso de meios de pagamento utilizados na jornada fiscal.';
             #7  : sValorSaida := 'Jornada fiscal sem movimento de vendas.';
             #8  : sValorSaida := 'Intervalo de jornada fiscal inv�lido.';
             #9  : sValorSaida := 'Existem mais dados para serem lidos.';
             #10  : sValorSaida := 'N�o existem mais dados para serem lidos.';
             #11  : sValorSaida := 'N�o pode abrir jornada fiscal.';
             #12  : sValorSaida := 'N�o pode fechar jornada fiscal.';
             #13  : sValorSaida := 'Limite m�ximo do per�odo fiscal atingido.';
             #14  : sValorSaida := 'Limite m�ximo do per�odo fiscal n�o atingido.';
             #15  : sValorSaida := 'Abertura da jornada fiscal n�o permitida.';
           end;
         end;

    #9 : begin
           Case sRetorno[2] of
             #1  : sValorSaida := 'Valor muito grande.';
             #2  : sValorSaida := 'Valor muito pequeno.';
             #3  : sValorSaida := 'Itens em excesso.';
             #4  : sValorSaida := 'Al�quotas em excesso.';
             #5  : sValorSaida := 'Desconto ou acr�scimos em excesso.';
             #6  : sValorSaida := 'Meios de pagamento em excesso.';
             #7  : sValorSaida := 'Item n�o encontrado.';
             #8  : sValorSaida := 'Meio de pagamento n�o encontrado.';
             #9  : sValorSaida := 'Total nulo.';
             #12  : sValorSaida := 'Tipo de pagamento n�o definido.';
             #15  : sValorSaida := 'Al�quota n�o encontrada.';
             #16  : sValorSaida := 'Al�quota inv�lida.';
             #17  : sValorSaida := 'Excesso de meios de pagamento com CDC.';
             #18  : sValorSaida := 'Meio de pagamento com CDC j� emitido.';
             #19  : sValorSaida := 'Meio de pagamento com CDC ainda n�o emitido.';
             #20  : sValorSaida := 'Leitura da Mem�ria Fiscal � intervalo CRZ inv�lido.';
             #21  : sValorSaida := 'Leitura da Mem�ria Fiscal � intervalo de data inv�lido.';
           end;
         end;

     #10: begin
            Case sRetorno[2] of
              #01 : sValorSaida := 'Opera��o n�o permitida ap�s desconto / acr�scimo.';
              #02 : sValorSaida := 'Opera��o n�o permitida ap�s registro de pagamentos.s';
              #03 : sValorSaida := 'Tipo de item inv�lido.';
              #04 : sValorSaida := 'Linha de descri��o em branco.';
              #05 : sValorSaida := 'Quantidade muito pequena.';
              #06 : sValorSaida := 'Quantidade muito grande.';
              #07 : sValorSaida := 'Total do item com valor muito alto.';
              #08 : sValorSaida := 'Opera��o n�o permitida antes do registro de pagamentos.';
              #09 : sValorSaida := 'Registro de pagamento incompleto.';
              #10 : sValorSaida := 'Registro de pagamento finalizado.';
              #11 : sValorSaida := 'Valor pago inv�lido.';
              #12 : sValorSaida := 'Valor de desconto ou acr�scimo n�o permitido.';
              #14 : sValorSaida := 'Valor n�o pode ser zero.';
              #15 : sValorSaida := 'Opera��o n�o permitida antes do registro de itens.';
              #17 : sValorSaida := 'Cancelamento de desconto e acr�scimo somente para item atual.';
              #18 : sValorSaida := 'N�o foi poss�vel cancelar �ltimo Cupom Fiscal.';
              #19 : sValorSaida := '�ltimo Cupom Fiscal n�o encontrado.';
              #20 : sValorSaida := '�ltimo Comprovante N�o-Fiscal n�o encontrado.';
              #21 : sValorSaida := 'Cancelamento de CDC necess�ria.';
              #22 : sValorSaida := 'N�mero de item em Cupom Fiscal inv�lido.';
              #23 : sValorSaida := 'Opera��o somente permitida ap�s subtotaliza��o.';
              #24 : sValorSaida := 'Opera��o somente permitida durante a venda de itens.';
              #25 : sValorSaida := 'Opera��o n�o permitida em item com desconto ou acr�scimo.';
              #26 : sValorSaida := 'D�gitos de quantidade inv�lidos.';
              #27 : sValorSaida := 'D�gitos de valor unit�rio inv�lido.';
              #28 : sValorSaida := 'N�o h� desconto ou acr�scimo a cancelar.';
              #29 : sValorSaida := 'N�o h� item para cancelar.';
              #30 : sValorSaida := 'Desconto ou acr�scimo somente no item atual.';
              #31 : sValorSaida := 'Desconto ou acr�scimo j� efetuado.';
              #32 : sValorSaida := 'Desconto ou acr�scimo nulo n�o permitido.';
              #33 : sValorSaida := 'Valor unit�rio inv�lido.';
              #34 : sValorSaida := 'Quantidade inv�lida.';
              #35 : sValorSaida := 'C�digo de item inv�lido.';
              #36 : sValorSaida := 'Descri��o inv�lida.';
              #37 : sValorSaida := 'Opera��o de desconto ou acr�scimo n�o permitida.';
              #38 : sValorSaida := 'Mensagem promocional j� impressa.';
              #39 : sValorSaida := 'Mensagem promocional n�o pode ser impressa.';
              #40 : sValorSaida := 'Dados do consumidor j� impresso.';
              #41 : sValorSaida := 'Dados do consumidor somente no fim do documento.';
              #42 : sValorSaida := 'Dados do consumidor somente no inicio do documento.';
              #43 : sValorSaida := 'Comando Inv�lido para o item.';
            end;
          end;

     #14: begin
            Case sRetorno[2] of
              #01 : sValorSaida := 'N�mero de linhas em documento excedido.';
              #02 : sValorSaida := 'N�mero do relat�rio inv�lido.';
              #03 : sValorSaida := 'Opera��o n�o permitida ap�s registro de itens.';
              #04 : sValorSaida := 'Registro de valor nulo n�o permitido.';
              #05 : sValorSaida := 'N�o h� desconto a cancelar.';
              #06 : sValorSaida := 'N�o h� acr�scimo a cancelar.';
              #07 : sValorSaida := 'Opera��o somente permitida ap�s subtotaliza��o.';
              #08 : sValorSaida := 'Opera��o somente permitida durante registro de itens.';
              #09 : sValorSaida := 'Opera��o n�o-fiscal inv�lida.';
              #10 : sValorSaida := '�ltimo comprovante N�o-Fiscal n�o encontrado.';
              #11 : sValorSaida := 'Meio de pagamento n�o encontrado.';
              #12 : sValorSaida := 'N�o foi poss�vel imprimir nova via.';
              #13 : sValorSaida := 'N�o foi poss�vel realizar reimpress�o.';
              #14 : sValorSaida := 'N�o foi poss�vel imprimir nova parcela.';
              #15 : sValorSaida := 'N�o h� mais parcelas a imprimir.';
              #16 : sValorSaida := 'Registro de item N�o-Fiscal inv�lido.';
              #17 : sValorSaida := 'Desconto ou acr�scimo j� efetuado.';
              #18 : sValorSaida := 'Valor de desconto ou acr�scimo inv�lido.';
              #19 : sValorSaida := 'N�o foi poss�vel cancelar o item.';
              #20 : sValorSaida := 'Itens em excesso.';
              #21 : sValorSaida := 'Opera��o N�o-Fiscal n�o cadastrada.';
              #22 : sValorSaida := 'Excesso de relat�rios / opera��es n�o-fiscais cadastradas.';
              #23 : sValorSaida := 'Relat�rio n�o encontrado.';
              #24 : sValorSaida := 'Comando n�o permitido.';
              #25 : sValorSaida := 'Comando n�o permitido em opera��es n�o-fiscais para movimento de monet�rio.';
              #26 : sValorSaida := 'Comando permitido apenas em opera��es n�o-fiscais para movimento de monet�rio.';
              #27 : sValorSaida := 'N�mero de parcelas inv�lido para a emiss�o de CCD';
              #28 : sValorSaida := 'Opera��o n�o fiscal j� cadastrada.';
              #29 : sValorSaida := 'Relat�rio gerencial j� cadastrado.';
              #30 : sValorSaida := 'Relat�rio Gerencial Inv�lido.';
            end;
          end;

     #18: begin
            Case sRetorno[2] of
              #01 : sValorSaida := 'Configura��o de cheque n�o registrada.';
              #02 : sValorSaida := 'Configura��o de cheque n�o encontrada.';
              #03 : sValorSaida := 'Valor do cheque j� impresso.';
              #04 : sValorSaida := 'Nominal ao cheque j� impresso.';
              #05 : sValorSaida := 'Linhas adicionais no cheque j� impresso.';
              #06 : sValorSaida := 'Autentica��o j� impressa.';
              #07 : sValorSaida := 'N�mero m�ximo de autentica��es j� impresso.';
            end;
          end;

     #255 : begin
              Case sRetorno[2] of
                #255 : sValorSaida := 'Erro desconhecido.';
              end;
            end;
  end;
  
  Result := sValorSaida;
end;



{ ----------------------------- TACBrECFEpson ----------------------------- }

constructor TACBrECFEpson.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fsEpsonComando   := TACBrECFEpsonComando.create ;
  fsEpsonResposta  := TACBrECFEpsonResposta.create ;

  fpDevice.Baud      := 38400;
  fpDevice.Parity    := pNone;
  fpDevice.Stop      := s1;
  fpDevice.Data      := 8;
  fpDevice.HandShake := hsDTR_DSR;
  fpDecimaisQtd      := 3 ;
  fpDecimaisPreco    := 2 ;

  { Variaveis internas dessa classe }
  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumLoja   := '' ;
  fsCNPJ      := '' ;
  fsIE        := '' ;
  fpModeloStr := 'Epson' ;
  fpMFD       := True ;
  fpTermica   := True ;
  fsRet0906   := '' ;
  fsRet0907   := '' ;
  fsImprimeCheque := False ;
  fsLeituraCMC7   := False ;
end;

destructor TACBrECFEpson.Destroy;
begin
  fsEpsonComando.Free ;
  fsEpsonResposta.Free ;

  inherited Destroy ;
end;

procedure TACBrECFEpson.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create('A impressora: '+ModeloStr+' requer'+sLineBreak+
                            'Porta Serial:  (COM1, COM2, COM3, ...)');

  inherited Ativar ; { Abre porta serial }

  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumLoja   := '' ;
  fsCNPJ      := '' ;
  fsIE        := '' ;
  fsRet0906   := '' ;
  fsRet0907   := '' ;

  try
     try
        EpsonComando.Comando := '0905' ;  // Obtendo o numero de colunas
        EnviaComando ;
        fpColunas := StrToIntDef( EpsonResposta.Params[0], 48 ) ;

        EpsonComando.Comando := '0585' ;  // Obtendo o numero de Decimais
        EnviaComando ;
        fpDecimaisQtd   := StrToIntDef( EpsonResposta.Params[0], fpDecimaisQtd) ;
        fpDecimaisPreco := StrToIntDef( EpsonResposta.Params[1], fpDecimaisPreco) ;

        EpsonComando.Comando := '090A' ; // Obtendo se a ECF Imprime Cheque, e Le CMC7
        EnviaComando ;
        fsImprimeCheque :=  EpsonResposta.Params[4]  = 'S';
        fsLeituraCMC7   :=  EpsonResposta.Params[14] = 'S';
     except
        raise EACBrECFNaoInicializado.Create(
                 'Erro inicializando a impressora '+ModeloStr );
     end ;
  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFEpson.EnviaComando_ECF( cmd : String = '' ) : String ;
Var ErroMsg    : String ;
    OldTimeOut : Integer ;
    ByteACK    : Byte ;
begin
  if cmd <> '' then
     cmd := PreparaCmd(cmd) ;  // Ajusta e move para Epsoncomando

  cmd := EpsonComando.FrameEnvio ;

  ByteACK := 0 ;
  Result  := '' ;
  ErroMsg := '' ;
  fpComandoEnviado   := '' ;
  fpRespostaComando  := '' ;
  EpsonResposta.Resposta := '' ;  // Zera resposta
  OldTimeOut := TimeOut ;
  TimeOut    := max(EpsonComando.TimeOut, TimeOut) ;

  try
     fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }

     while (ByteACK <> ACK) do     { Se ACK = 6 Comando foi reconhecido }
     begin
        ByteACK := 0 ;
        fpDevice.Serial.Purge ;                   { Limpa a Porta }

        if not TransmiteComando( cmd ) then
           continue ;

        if fpDevice.HandShake = hsDTR_DSR then
           fpDevice.Serial.DTR := True ;  { Liga o DTR para ler a Resposta }

        if not fpDevice.Serial.CTS then
           fpDevice.Serial.RTS := false ;

        try
           { espera ACK chegar na Porta por 1,5s  }
           try
              ByteACK := fpDevice.Serial.RecvByte( 1500 ) ;
           except
           end ;

           if ByteACK = 0 then
              raise EACBrECFSemResposta.create(
                    'Impressora '+ModeloStr+' n�o responde (ACK = 0)' )
           else if ByteACK = NACK then    { retorno em caracter 21d=15h=NACK }
              raise EACBrECFSemResposta.create(
                    'Impressora '+ModeloStr+' n�o reconheceu o Comando'+
                    sLineBreak+' (NACK)')
           else if ByteACK <> 6 then
              raise EACBrECFSemResposta.create(
                    'Erro. Resposta da Impressora '+ModeloStr+' inv�lida'+
                    sLineBreak+' (ACK = '+IntToStr(ByteACK)+')') ;
        except
           on E : EACBrECFSemResposta do
            begin
              fpDevice.Serial.Purge ;

              if not DoOnMsgRetentar( E.Message +sLineBreak+sLineBreak+
                 'Se o problema persistir, verifique os cabos, ou'+sLineBreak+
                 'experimente desligar a impressora durante 5 seg,'+sLineBreak+
                 'liga-la novamente, e repetir a opera��o...'
                 , 'LerACK') then
                 raise ;
            end ;
           else
              raise ;
        end ;

     end ;

     fpComandoEnviado := cmd ;

     { Chama Rotina da Classe m�e TACBrClass para ler Resposta. Se houver
       falha na leitura LeResposta dispara Exce�ao.
       Resposta fica gravada na v�riavel "fpRespostaComando" }
     LeResposta ;

     Try
        EpsonResposta.Resposta := fpRespostaComando ;
        if EpsonResposta.Seq <> EpsonComando.Seq then
           raise Exception.Create('Sequencia de Resposta diferente da enviada') ;

        fpDevice.Serial.SendByte(ACK);

        ErroMsg := EpsonResposta.DescRetorno ;
        if ErroMsg <> '' then
           ErroMsg := 'Erro: '+ EpsonResposta.Retorno+ ' - '+ErroMsg  ;
     except
        on E : Exception do
        begin
           fpDevice.Serial.SendByte(NACK);
           ErroMsg := E.Message ;
        end ;
     end ;

     if ErroMsg <> '' then
      begin
        ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr+#10+#10+
                   ErroMsg ;
        raise EACBrECFSemResposta.create(ErroMsg) ;
      end
     else
        Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }

  finally
     TimeOut := OldTimeOut ;
  end ;
end;

function TACBrECFEpson.PreparaCmd(cmd: String): String;
 Var Buf : String ;
     P   : Integer ;
     SL  : TStringList ;
begin
  { Quebrando Parametros Separados por FLD }
  Buf := Cmd ;
  SL  := TStringList.create;
  try
     SL.Clear ;
     while Buf <> '' do
     begin
        P := pos(FLD,Buf) ;
        if P = 0 then
           P := Length(Buf)+1 ;

        SL.Add( LeftStr(Buf,P-1) ) ;
        Buf := copy(Buf,P+1,Length(Buf)) ;  // Pega pr�ximo bloco
     end ;

     if SL.Count < 1 then
        raise Exception.create('Erro ao informar comando.  Use:'+sLineBreak+
                               'Comando(4 Hex) #28 Extensao(4 Hex) [ #28 PARAM1 [ #28 PARAM2 ... ]] '+sLineBreak+sLineBreak+
                               'Exemplo, Para emitir Leitura X use: '+sLineBreak+
                               'EnviaComando("0802" + #28 + "0000" ) ' );

     if SL.Count < 2 then
        SL.Add('0000') ;

     EpsonComando.Comando  := SL[0] ;
     EpsonComando.Extensao := SL[1] ;

     for P := 2 to SL.Count-1 do
        EpsonComando.AddParam(SL[P]);
  finally
     SL.Free ;
  end ;
end;

Function TACBrECFEpson.VerificaFimLeitura(var Retorno:String;
   var TempoLimite: TDateTime) : Boolean ;
begin
  Result := ((LeftStr(Retorno,1) = STX) and (Length(Retorno) >= 7) and
             (copy(Retorno,Length(Retorno)-4,1) = ETX) ) ;

  // � Envio de Resposta Intermedi�ria ?
  if Result and (LeftStr(Retorno,7) = #2 + #128 + #3 + '0085') then
  begin
     Retorno     := Copy(Retorno, 8, Length(Retorno));
     TempoLimite := IncSecond(now, TimeOut);
     Result      := False ;
  end ;
end;

function TACBrECFEpson.GetDataHora: TDateTime;
Var RetCmd : String ;
    OldShortDateFormat : String ;
begin
  EpsonComando.Comando := '0502' ;
  EnviaComando ;
  RetCmd := EpsonResposta.Params[0] ;
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yyyy' ;
     Result := StrToDate(copy(RetCmd, 1,2) + DateSeparator +
                         copy(RetCmd, 3,2) + DateSeparator +
                         copy(RetCmd, 5,4)) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;

  RetCmd := EpsonResposta.Params[1] ;
  Result := RecodeHour(  Result,StrToInt(copy(RetCmd,1,2))) ;
  Result := RecodeMinute(Result,StrToInt(copy(RetCmd,3,2))) ;
  Result := RecodeSecond(Result,StrToInt(copy(RetCmd,5,2))) ;
end;

function TACBrECFEpson.GetNumCupom: String;
begin
  EpsonResposta.Resposta := Ret0907 ;
  Result := EpsonResposta.Params[0] ;
end;

function TACBrECFEpson.GetNumCCF: String;
begin
  EpsonResposta.Resposta := Ret0907 ;
  Result := EpsonResposta.Params[7] ;
end;

function TACBrECFEpson.GetNumCRO: String;
begin
  EpsonResposta.Resposta := Ret0907 ;
  Result := EpsonResposta.Params[2] ;
end;

function TACBrECFEpson.GetNumLoja: String;
begin
  if fsNumLoja = '' then
  begin
     EpsonComando.Comando := '0507' ;
     EnviaComando ;

     fsCNPJ    := EpsonResposta.Params[5] ;
     fsIE      := EpsonResposta.Params[6] ;
     fsNumECF  := EpsonResposta.Params[8] ;
     fsNumLoja := EpsonResposta.Params[9] ;
  end ;

  Result := fsNumLoja ;
end;

function TACBrECFEpson.GetNumECF: String;
begin
  if fsNumECF = '' then
     GetNumLoja ;

  Result := fsNumECF ;
end;

function TACBrECFEpson.GetNumSerie: String;
begin
  EpsonComando.Comando := '0402' ;
  EnviaComando ;

  Result      := EpsonResposta.Params[0] ;
  fsNumVersao := EpsonResposta.Params[5];
end;

function TACBrECFEpson.GetNumVersao: String ;
begin
  if fsNumVersao = '' then
     GetNumSerie ;

  Result := fsNumVersao ;
end;

function TACBrECFEpson.GetTotalPago: Double;
begin
  try
     EpsonComando.Comando := '0A0A' ;
     EnviaComando ;

     Result := StrToFloatDef(EpsonResposta.Params[2],0) /100 ;
     Result := RoundTo( Result, -2) ;
  except
     on E : Exception do
     begin
        if (pos('0102',E.Message) <> 0) then
           Result := 0
        else
           raise ;
     end ;
  end ;
end;

function TACBrECFEpson.GetSubTotal: Double;
begin
  try
     EpsonComando.Comando := '0A03' ;
     EnviaComando ;

     Result := StrToFloatDef(EpsonResposta.Params[0],0) /100 ;
     Result := RoundTo( Result, -2) ;
  except
     on E : Exception do
     begin
        if (pos('0102',E.Message) <> 0) then
           Result := 0
        else
           raise ;
     end ;
  end ;
end;


function TACBrECFEpson.GetEstado: TACBrECFEstado;
  Var BitS : String ;
begin
  if (not fpAtivo) then
     fpEstado := estNaoInicializada
  else
   begin
      fpEstado := estDesconhecido ;

      EpsonComando.Comando := '0810' ;
      EnviaComando ;

      BitS := ACBrUtil.IntToBin(EpsonResposta.StatusFiscal, 16) ;

      if copy(BitS,1,2) <> '11' then  // Diferente de Modo fiscalizado ?
         fpEstado := estDesconhecido

      else if (EpsonResposta.Params[0] = '4') then
         fpEstado := estRequerZ

      else if (EpsonResposta.Params[0] = '3') then
         fpEstado := estRequerX

      else if (EpsonResposta.Params[0] = '2') then
         fpEstado := estBloqueada

      else if copy(BitS,13,4) = '0000' then
         fpEstado := estLivre

      else if copy(BitS,13,4) = '0001' then
       begin
         EpsonComando.Comando := '0A0A' ;
         EnviaComando ;

         if (EpsonResposta.Params[10] >= '2') then
            fpEstado := estPagamento
         else
            fpEstado := estVenda
       end

      else if pos(copy(BitS,13,4),'0010|0011|0100') > 0 then
         fpEstado := estRelatorio

      else if copy(BitS,13,4) = '1000' then
         fpEstado := estNaoFiscal ;

   end ;

  Result := fpEstado ;
end;

function TACBrECFEpson.GetGavetaAberta: Boolean;
begin
  EpsonComando.Comando := '0708' ;
  EnviaComando ;

  Result := (EpsonResposta.Params[0] = 'S') ;
end;

function TACBrECFEpson.GetPoucoPapel: Boolean;
begin
  EpsonComando.Comando := '0001' ;
  EnviaComando ;

  Result := TestBit(EpsonResposta.StatusPrinter,0) or
            TestBit(EpsonResposta.StatusPrinter,2) ;
end;

function TACBrECFEpson.GetHorarioVerao: Boolean;
begin
  EpsonComando.Comando := '0511' ;
  EnviaComando ;

  Result := (EpsonResposta.Params[0] = 'S') ;
end;

Procedure TACBrECFEpson.LeituraX ;
begin
  if Estado = estRequerx then
     EpsonComando.Comando := '0805'
  else
     EpsonComando.Comando := '0802' ;

  EpsonComando.TimeOut := TempoInicioMsg + 2 ;  // apenas para o bloqueio de teclado funcionar
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

Procedure TACBrECFEpson.AbreGaveta ;
begin
  EpsonComando.Comando := '0707' ;   // Gaveta 1 ??
  EpsonComando.Extensao := '0000' ;
  EnviaComando ;

  EpsonComando.Comando := '0707' ;   // Gaveta 2 ??
  EpsonComando.Extensao := '0001' ;
  EnviaComando ;
end;

Procedure TACBrECFEpson.ReducaoZ(DataHora: TDateTime) ;
begin
  EpsonComando.Comando := '0801' ;
  EpsonComando.TimeOut := TempoInicioMsg + 2 ;  // apenas para o bloqueio de teclado funcionar
  if DataHora <> 0 then
   begin
     EpsonComando.Extensao := '0001' ;
     EpsonComando.AddParam( FormatDateTime('ddmmyyyy',DataHora) ) ;
     EpsonComando.AddParam( FormatDateTime('hhnnss',DataHora) ) ;
   end
  else
   begin
     EpsonComando.AddParam( '' ) ;
     EpsonComando.AddParam( '' ) ;
   end ;

  try
     EnviaComando ;
  except
     on E : Exception do
     begin
        if (pos('0107',E.Message) <> 0) then   // Erro de Hora fora da faixa ?
           ReducaoZ(0)                         // Tenta sem DataHora
        else
           raise ;
     end ;
  end ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

Procedure TACBrECFEpson.MudaHorarioVerao ;
begin
  MudaHorarioVerao( not HorarioVerao ) ;
end;

procedure TACBrECFEpson.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  EpsonComando.Comando := '0510' ;
  EnviaComando ;
end;

procedure TACBrECFEpson.AbreCupom ;
begin
  if Consumidor.Atribuido then
  begin
     EpsonComando.Comando  := '0A20' ;
     EpsonComando.Extensao := '0001' ;
     EpsonComando.AddParam(LeftStr(Consumidor.Documento,20));
     EpsonComando.AddParam(LeftStr(Consumidor.Nome,30));
     EpsonComando.AddParam(copy(Consumidor.Endereco, 1,40));
     EpsonComando.AddParam(copy(Consumidor.Endereco,41,40));
     EnviaComando ;
  end ;

  EpsonComando.Comando := '0A01' ;
  EpsonComando.AddParam('');   // 2 Campos de entrada Reservados ;
  EpsonComando.AddParam('');
  EnviaComando ;

  Consumidor.Enviado := True ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.CancelaCupom;
  Var Erro : String ;
      CDC  : String ;
begin
  try
     // Cancelando o Cupom
     EpsonComando.Comando  := '0A18' ;
     EpsonComando.Extensao := '0008' ;
     EpsonComando.AddParam('1');   // 1 Campo de entrada N�O usado no Cancelamento de cupom ;
     EnviaComando ;
  except
     on E : Exception do
     begin
        Erro := E.Message ;

        // Verificando se motivo do Erro foi falta do cancelamento do CDC (Erro 0A15)
        if (pos('0A15',E.Message) > 0) then
         begin
           // Pega o nro do CDC a cancelar
           EpsonComando.Comando := '0907';
           EnviaComando;
           CDC := Trim(EpsonResposta.Params[0]) ;

           // Estorna o CDC para poder cancelar o cupom
           EpsonComando.Comando  := '0E30';
           EpsonComando.Extensao := '0001';
           { Passando apenas o numero do COO, os parametros iniciais n�o s�o
             necess�riospara efetuar o cancelameto de CDC }
           EpsonComando.AddParam('');
           EpsonComando.AddParam('');
           EpsonComando.AddParam('');
           EpsonComando.AddParam(CDC);
           EnviaComando;
           FechaRelatorio;   { Fecha o estorno do CDC }

           // Agora sim... Cancelando o Cupom
           EpsonComando.Comando  := '0A18' ;
           EpsonComando.Extensao := '0008' ;
           EpsonComando.AddParam('1');
           EnviaComando ;
         end
        else
           raise ;
     end ;
  end ;

  FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (s� por garantia)}

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.CancelaItemVendido(NumItem: Integer);
begin
  EpsonComando.Comando  := '0A18' ;
  EpsonComando.Extensao := '0004' ;
  EpsonComando.AddParam(IntToStr(NumItem)) ;
  EnviaComando ;
  
  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
begin
  EpsonComando.Comando  := '0A05' ;
  EpsonComando.AddParam( CodFormaPagto ) ;
  EpsonComando.AddParam( IntToStrZero(Round(Valor * 100) ,13) ) ;
  EpsonComando.AddParam( copy(Observacao, 1,40) ) ;
  EpsonComando.AddParam( copy(Observacao,41,40) ) ;
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.FechaCupom(Observacao: String);
 Var SL  : TStringList ;
     I   : Integer ;
     Obs : String ;
begin
  Obs := Observacao ;
  if not Consumidor.Enviado then
  begin
     { Removendo o Consumidor da Observa��o, pois vai usar comando pr�prio }
     Obs := StringReplace(Obs,#10+'CPF/CNPJ consumidor: '+Consumidor.Documento,'',[]) ;
     Obs := StringReplace(Obs,#10+'Nome: '+Consumidor.Nome,'',[]) ;
     Obs := StringReplace(Obs,#10+'Endereco: '+Consumidor.Endereco,'',[]) ;

     try
        EpsonComando.Comando  := '0A20' ;
        EpsonComando.Extensao := '0002' ;
        EpsonComando.AddParam(LeftStr(Consumidor.Documento,20));
        EpsonComando.AddParam(LeftStr(Consumidor.Nome,30));
        EpsonComando.AddParam(copy(Consumidor.Endereco, 1,40));
        EpsonComando.AddParam(copy(Consumidor.Endereco,41,40));
        EnviaComando ;
        
        Consumidor.Enviado := True ;
     except
        Obs := Observacao ;
     end ;
  end ;

  if Trim(Obs) <> '' then
  begin
     Obs := AjustaLinhas(Obs,50) ;
     SL := TStringList.create ;
     try
        SL.Text := Obs ;
        EpsonComando.Comando  := '0A22' ;
        For I := 0 to 7 do
           if I >= SL.Count then
              EpsonComando.AddParam('')
           else
              EpsonComando.AddParam(SL[I]) ;
        EnviaComando ;
     finally
        SL.Free ;
     end ;
  end ;

  EpsonComando.Comando  := '0A06' ;
  EpsonComando.Extensao := '0001' ;   // Corta folha
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : String);
begin
  if DescontoAcrescimo = 0 then
     exit ;

  EpsonComando.Comando  := '0A04' ;
  if DescontoAcrescimo < 0 then
     EpsonComando.Extensao := '0006'
  else
     EpsonComando.Extensao := '0007' ;
  EpsonComando.AddParam( IntToStrZero(Round(abs(DescontoAcrescimo) * 100) ,11)  );
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

Procedure TACBrECFEpson.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
begin
  with EpsonComando do
  begin
     Comando := '0A02' ;
     AddParam( LeftStr(Codigo,14) );
     AddParam( LeftStr(Descricao,233) );
     AddParam( IntToStrZero(Round(Qtd * Power(10,fpDecimaisQtd) ) ,7)  );
     AddParam( LeftStr(Unidade,3) );
     AddParam( IntToStrZero(Round(ValorUnitario * Power(10,fpDecimaisPreco) ) ,8)  );
     AddParam( AliquotaECF );
  end ;
  EnviaComando ;

  { Se o desconto � maior que zero d� o comando de desconto de item }
  if ValorDescontoAcrescimo > 0 then
  begin
     EpsonComando.Comando  := '0A04' ;
     if TipoDescontoAcrescimo = '%' then
      begin
        if DescontoAcrescimo = 'D' then
           EpsonComando.Extensao := '0000'
        else
           EpsonComando.Extensao := '0001' ;
      end
     else
      begin
        if DescontoAcrescimo = 'D' then
           EpsonComando.Extensao := '0004'
        else
           EpsonComando.Extensao := '0005' ;
      end ;
      
     EpsonComando.AddParam( IntToStrZero(Round(ValorDescontoAcrescimo * 100) ,11)  );
     EnviaComando ;
  end;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.CarregaAliquotas;
var
  A         : Integer;
  Aliquota  : TACBrECFAliquota ;
  ValAliq, TotAliq : Double ;
  IndAliq   : String ;
  iAliquotas: Integer ;
begin
  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  EpsonComando.Comando := '0542' ;
  EnviaComando ;

  iAliquotas := Trunc(EpsonResposta.Params.Count / 3);

  For A := 1 to iAliquotas do
  begin
     IndAliq  := EpsonResposta.Params[(A * 3) - 3];
     ValAliq  := RoundTo( StrToFloatDef(EpsonResposta.Params[(A * 3) - 2], 0 ) / 100, -2) ;
     TotAliq  := RoundTo( StrToFloatDef(EpsonResposta.Params[(A * 3) - 1], 0 ) / 100, -2) ;

     Aliquota := TACBrECFAliquota.create;

     Aliquota.Indice   := IndAliq ;
     Aliquota.Tipo     := IndAliq[1];
     Aliquota.Aliquota := ValAliq ;
     Aliquota.Total    := TotAliq ;

     fpAliquotas.Add(Aliquota);
  end;
end;

procedure TACBrECFEpson.LerTotaisAliquota;
begin
  CarregaAliquotas ;
end;


procedure TACBrECFEpson.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
begin
  Tipo := UpCase(Tipo) ;

  EpsonComando.Comando := '0540' ;
  if Tipo = 'S' then
     EpsonComando.Extensao := '0001' ;
  EpsonComando.Params.Add( IntToStrZero(Round(Aliquota * 100) ,4) ) ;
  EnviaComando ;

  CarregaAliquotas ;
  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

function TACBrECFEpson.AchaICMSAliquota( var AliquotaICMS: String):
   TACBrECFAliquota;
  Var AliquotaStr : String ;
begin
  AliquotaStr := '' ;
  Result      := nil ;

  if pos(copy(AliquotaICMS,1,2), 'TT,SS') > 0 then { Corrige Duplo T ou S }
     AliquotaICMS := Trim(Copy(AliquotaICMS,2,5));

  case AliquotaICMS[1] of
     'F','I','N' : AliquotaStr := AliquotaICMS[1] ;
     'T' : AliquotaICMS := 'TT'+copy(AliquotaICMS,2,2) ; {Indice}
     'S' : AliquotaICMS := 'TS'+copy(AliquotaICMS,2,2) ; {Indice}
  end ;

  if AliquotaStr = '' then
     Result := inherited AchaICMSAliquota( AliquotaICMS )
  else
     AliquotaICMS := AliquotaStr ;
end;


procedure TACBrECFEpson.CarregaFormasPagamento;
  Function SubCarregaFormasPagamento(Indice : Integer) : Boolean ;
    var FPagto : TACBrECFFormaPagamento ;
  begin
     Result := True ;
     EpsonComando.Comando := '050D' ;
     EpsonComando.AddParam( IntToStr(Indice) ) ;
     try
        EnviaComando ;

        FPagto := TACBrECFFormaPagamento.create ;
        FPagto.Indice    := IntToStr( Indice ) ;
        FPagto.Descricao := EpsonResposta.Params[0] ;
        FPagto.PermiteVinculado := ( EpsonResposta.Params[1] = 'S' ) ;

        fpFormasPagamentos.Add( FPagto ) ;
     except
        on E : Exception do
        begin
           Result := (pos('090C',E.Message) <> 0)
        end ;
     end;
  end ;
Var A    : Integer;
    Erro : Boolean ;
begin
  inherited CarregaFormasPagamento ;   { Cria fpFormasPagamentos }

  Erro := False ;
  { L� as Formas de Pagamento cadastradas na impressora }
  A := 1;
  while (A <= 20) and (not Erro) do
  begin
     Erro := not SubCarregaFormasPagamento(A);
     Inc( A )
  end ;

  if Erro then   { "niliza" para tentar carregar novamente no futuro }
  begin
     fpFormasPagamentos.Free ;
     fpFormasPagamentos := nil ;
  end ;
end;

procedure TACBrECFEpson.LerTotaisFormaPagamento;
Var A : Integer ;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  For A := 0 to FormasPagamento.Count-1 do
  begin
     EpsonComando.Comando := '0902' ;
     EpsonComando.AddParam( FormasPagamento[A].Indice );
     EnviaComando ;

     // Andre Bohn - O Total da Forma de Pagamento vem no Params[1] e n�o no
     //              Params[2], no caso da Epson TM H6000 FBII, mas
     //              pode ser o caso da TM88 tamb�m.   
     FormasPagamento[A].Total := RoundTo( StringToFloatDef(
                                        EpsonResposta.Params[1], 0) / 100, -2) ;
  end ;
end;

procedure TACBrECFEpson.ProgramaFormaPagamento( var Descricao: String;
  PermiteVinculado : Boolean; Posicao : String) ;
var  FPagto: TACBrECFFormaPagamento ;
     ProxIndice : Integer ;
begin
  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 1) or (ProxIndice > 20) then { Indice passado � v�lido ? }
  begin
     For ProxIndice := 2 to 20 do  { Procurando Lacuna }
     begin
        if AchaFPGIndice(IntToStr(ProxIndice)) = nil then
           break ;
     end ;
  end ;

  if ProxIndice > 20 then
     raise Exception.create('N�o h� espa�o para programar novas Formas de '+
                            'Pagamento');

  EpsonComando.Comando := '050C' ;
  if PermiteVinculado then
     EpsonComando.Extensao := '0001' ;
  EpsonComando.AddParam( IntToStr(ProxIndice) ) ;
  EpsonComando.AddParam( LeftStr(Descricao,15) ) ;
  EnviaComando ;

  { Adicionando nova FPG no ObjectList }
  if Assigned( fpFormasPagamentos ) then
  begin
     FPagto := TACBrECFFormaPagamento.create ;
     FPagto.Indice    := IntToStr(ProxIndice) ;
     FPagto.Descricao := LeftStr(Descricao,15) ;
     FPagto.PermiteVinculado := PermiteVinculado  ;

     fpFormasPagamentos.Add( FPagto ) ;
  end ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.CarregaComprovantesNaoFiscais;
Var A    : Integer ;
    CNF  : TACBrECFComprovanteNaoFiscal ;
    Erro : Boolean ;
begin
  inherited CarregaComprovantesNaoFiscais ;

  A    := 1 ;
  Erro := False ;
  while (A <= 20) and (not Erro) do
  begin
     EpsonComando.Comando  := '0902' ;
     EpsonComando.Extensao := '0001' ;
     EpsonComando.AddParam( IntToStr(A) ) ;
     try
        EnviaComando ;

        // Andr� Bohn - Se n�o tem comprovante cadastrado na posi��o solicitada
        // estava dando list index of bounds.
        if EpsonResposta.Params[0] <> '' then
        begin
          CNF := TACBrECFComprovanteNaoFiscal.create ;

          CNF.Indice    := IntToStr(A) ;
          CNF.Descricao := EpsonResposta.Params[0] ;
          CNF.Total     := RoundTo( StringToFloatDef(
                                          EpsonResposta.Params[1], 0) / 100, -2) ;
          CNF.Contador  := StrToIntDef( EpsonResposta.Params[2], 0) ;

          fpComprovantesNaoFiscais.Add( CNF ) ;
        end;
     except
        on E : Exception do
        begin
           Erro := (pos('0701',E.Message) = 0)
        end ;
     end;

     Inc( A ) ;
  end ;

  if Erro then   { "niliza" para tentar carregar novamente no futuro }
  begin
     fpComprovantesNaoFiscais.Free ;
     fpComprovantesNaoFiscais := nil ;
  end ;
end;

procedure TACBrECFEpson.LerTotaisComprovanteNaoFiscal;
begin
  CarregaComprovantesNaoFiscais ;
end;

procedure TACBrECFEpson.ProgramaComprovanteNaoFiscal(var Descricao : String;
   Tipo: String; Posicao : String);
begin
  EpsonComando.Comando := '0572' ;
  EpsonComando.AddParam( Descricao ) ;
  EnviaComando ;

  CarregaComprovantesNaoFiscais ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.AbreRelatorioGerencial;
begin
  EpsonComando.Comando  := '0E01' ;
  EpsonComando.Extensao := '0004' ;
  EpsonComando.AddParam( '1' ) ;
  EnviaComando ;
  
  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.LinhaRelatorioGerencial(Linha: String);
Var I  : Integer ;
    SL : TStringList ;
begin
  Linha := AjustaLinhas( Linha, Colunas );  { Formata as Linhas de acordo com "Coluna" }

  SL := TStringList.create ;
  try
     SL.Text := Linha ;
     For I := 0 to SL.Count-1 do
     begin
        EpsonComando.Comando  := '0E02' ;
        EpsonComando.AddParam(SL[I]) ;
        EnviaComando ;
     end ;
  finally
     SL.Free ;
  end ;
end;

procedure TACBrECFEpson.AbreCupomVinculado(COO, CodFormaPagto,
   CodComprovanteNaoFiscal :  String; Valor : Double ) ;
Var FPG : TACBrECFFormaPagamento ;
begin
  FPG := AchaFPGIndice( CodFormaPagto ) ;

  if FPG = nil then
     raise Exception.create( 'Forma de Pagamento: '+CodFormaPagto+
                             ' n�o foi cadastrada.' ) ;

  EpsonComando.Comando := '0E30' ;
  EpsonComando.AddParam( CodFormaPagto ) ;
  EpsonComando.AddParam( IntToStrZero(Round(Valor * 100) ,13) );
  EpsonComando.AddParam( '1' ) ;
  EpsonComando.AddParam( '' ) ;
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.LinhaCupomVinculado(Linha: String);
begin
  LinhaRelatorioGerencial( Linha );
end;

procedure TACBrECFEpson.FechaRelatorio;
begin
  if Estado = estRelatorio then
  begin
     EpsonComando.Comando  := '0E06' ;
     EpsonComando.Extensao := '0001' ;  // Corta folha
     EnviaComando ;
  end ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.PulaLinhas(NumLinhas: Integer);
begin
  if NumLinhas = 0 then
     NumLinhas := LinhasEntreCupons ;

  EpsonComando.Comando := '0701' ;
  EpsonComando.AddParam( IntToStr(NumLinhas) );
  EnviaComando ;
end;

procedure TACBrECFEpson.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal : Integer);
begin
  with EpsonComando do
  begin
     Comando  := '0910' ;
     Extensao := '0000' ;
     AddParam( IntToStr(ReducaoInicial) ) ;
     AddParam( IntToStr(ReducaoFinal) ) ;
     AddParam( '' ) ;
     AddParam( '' ) ;
  end ;
  EnviaComando ;
end;

procedure TACBrECFEpson.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime);
begin
  with EpsonComando do
  begin
     Comando  := '0910' ;
     Extensao := '0001' ;
     AddParam( '' ) ;
     AddParam( '' ) ;
     AddParam( FormatDateTime('ddmmyyyy',DataInicial) ) ;
     AddParam( FormatDateTime('ddmmyyyy',DataFinal) ) ;
  end ;
  EnviaComando ;
end;

procedure TACBrECFEpson.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas : TStringList);
  Var I : Integer ;
begin
  with EpsonComando do
  begin
     Comando  := '0910' ;
     Extensao := '0008' ;
     AddParam( IntToStr(ReducaoInicial) ) ;
     AddParam( IntToStr(ReducaoFinal) ) ;
     AddParam( '' ) ;
     AddParam( '' ) ;
  end ;
  EnviaComando ;
  Sleep(200);

  Linhas.Clear ;
  while (EpsonResposta.Params.Count > 1) do
  begin
     For I := 0 to EpsonResposta.Params.Count-2 do
        Linhas.Add( EpsonResposta.Params[I] ) ;

     if EpsonResposta.Params[EpsonResposta.Params.Count-1] <> 'S' then
        break ;

     with EpsonComando do
     begin
        Comando  := '0910' ;
        Extensao := '000C' ;
        AddParam( IntToStr(ReducaoInicial) ) ;
        AddParam( IntToStr(ReducaoFinal) ) ;
        AddParam( '' ) ;
        AddParam( '' ) ;
     end ;
     try
        EnviaComando ;
     except
        break ;
     end ;
  end ;
end;

procedure TACBrECFEpson.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; var Linhas : TStringList);
  Var I : Integer ;
begin
  with EpsonComando do
  begin
     Comando  := '0910' ;
     Extensao := '0009' ;
     AddParam( '' ) ;
     AddParam( '' ) ;
     AddParam( FormatDateTime('ddmmyyyy',DataInicial) ) ;
     AddParam( FormatDateTime('ddmmyyyy',DataFinal) ) ;
  end ;
  EnviaComando ;
  Sleep(200);

  Linhas.Clear ;
  while (EpsonResposta.Params.Count > 1) do
  begin
     For I := 0 to EpsonResposta.Params.Count-2 do
        Linhas.Add( EpsonResposta.Params[I] ) ;

     if EpsonResposta.Params[EpsonResposta.Params.Count-1] <> 'S' then
        break ;

     with EpsonComando do
     begin
        Comando  := '0910' ;
        Extensao := '000D' ;
        AddParam( '' ) ;
        AddParam( '' ) ;
        AddParam( FormatDateTime('ddmmyyyy',DataInicial) ) ;
        AddParam( FormatDateTime('ddmmyyyy',DataFinal) ) ;
     end ;
     try
        EnviaComando ;
     except
        break ;
     end ;
  end ;
end;


procedure TACBrECFEpson.CorrigeEstadoErro(Reducao: Boolean);
begin
  inherited CorrigeEstadoErro(Reducao) ;

  if Estado <> estLivre then
     try
        EpsonComando.Comando := '0210' ;
        EnviaComando ;
        sleep(500) ;
     except
     end ;
  
  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

function TACBrECFEpson.GetCNPJ: String;
begin
  if fsCNPJ = '' then
     GetNumLoja ;

  Result := fsCNPJ ;
end;

function TACBrECFEpson.GetIE: String;
begin
  if fsIE = '' then
     GetNumLoja ;

  Result := fsIE ;
end;

function TACBrECFEpson.GetDataMovimento: TDateTime;
Var RetCmd : String ;
    OldShortDateFormat : String ;
begin
  EpsonComando.Comando := '080A' ;
  EnviaComando ;
  RetCmd := EpsonResposta.Params[0] ;
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yyyy' ;
     Result := StrToDate(copy(RetCmd, 1,2) + DateSeparator +
                         copy(RetCmd, 3,2) + DateSeparator +
                         copy(RetCmd, 5,4)) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;

  RetCmd := EpsonResposta.Params[1] ;
  Result := RecodeHour(  Result,StrToInt(copy(RetCmd,1,2))) ;
  Result := RecodeMinute(Result,StrToInt(copy(RetCmd,3,2))) ;
  Result := RecodeSecond(Result,StrToInt(copy(RetCmd,5,2))) ;
end;

function TACBrECFEpson.GetGrandeTotal: Double;
begin
  EpsonResposta.Resposta := Ret0906 ;
  Result := RoundTo( StrToFloatDef(EpsonResposta.Params[0],0) /100, -2) ;
end;

function TACBrECFEpson.GetNumCRZ: String;
begin
  EpsonResposta.Resposta := Ret0907 ;
  Result := EpsonResposta.Params[1] ;
end;

function TACBrECFEpson.GetTotalAcrescimos: Double;
begin
  EpsonResposta.Resposta := Ret0906 ;
  Result := RoundTo( StrToFloatDef(EpsonResposta.Params[8],0) /100, -2) ;
  Result := Result + RoundTo( StrToFloatDef(EpsonResposta.Params[9],0) /100, -2) ;
end;

function TACBrECFEpson.GetTotalCancelamentos: Double;
begin
  EpsonResposta.Resposta := Ret0906 ;
  Result := RoundTo( StrToFloatDef(EpsonResposta.Params[2],0) /100, -2) ;
  Result := Result + RoundTo( StrToFloatDef(EpsonResposta.Params[5],0) /100, -2) ;
end;

function TACBrECFEpson.GetTotalDescontos: Double;
begin
  EpsonResposta.Resposta := Ret0906 ;
  Result := RoundTo( StrToFloatDef(EpsonResposta.Params[3],0) /100, -2) ;
  Result := Result + RoundTo( StrToFloatDef(EpsonResposta.Params[6],0) /100, -2) ;
end;

function TACBrECFEpson.GetTotalSubstituicaoTributaria: Double;
begin
  EpsonResposta.Resposta := Ret0906 ;
  Result := RoundTo( StrToFloatDef(EpsonResposta.Params[15],0) /100, -2) ;
  Result := Result + RoundTo( StrToFloatDef(EpsonResposta.Params[18],0) /100, -2) ;
end;

function TACBrECFEpson.GetTotalIsencao: Double;
begin
  EpsonResposta.Resposta := Ret0906 ;
  Result := RoundTo( StrToFloatDef(EpsonResposta.Params[16],0) /100, -2) ;
  Result := Result + RoundTo( StrToFloatDef(EpsonResposta.Params[19],0) /100, -2) ;
end;

function TACBrECFEpson.GetTotalNaoTributado: Double;
begin
  EpsonResposta.Resposta := Ret0906 ;
  Result := RoundTo( StrToFloatDef(EpsonResposta.Params[17],0) /100, -2) ;
  Result := Result + RoundTo( StrToFloatDef(EpsonResposta.Params[20],0) /100, -2) ;
end;

function TACBrECFEpson.GetVendaBruta: Double;
begin
  EpsonResposta.Resposta := Ret0906 ;
  Result := RoundTo( StrToFloatDef(EpsonResposta.Params[1],0) /100, -2) ;
end;

function TACBrECFEpson.GetNumCOOInicial: String;
begin
  EpsonComando.Comando := '080A' ;
  EnviaComando ;

  Result := EpsonResposta.Params[4] ;
end;

function TACBrECFEpson.GetNumUltimoItem: Integer;
begin
  try
     EpsonComando.Comando := '0903' ;
     EnviaComando ;

     Result := StrToIntDef( EpsonResposta.Params[0],0 ) ;
  except
     on E : Exception do
     begin
        if (pos('0102',E.Message) <> 0) then
           Result := 0
        else
           raise ;
     end ;
  end ;
end;

procedure TACBrECFEpson.AbreNaoFiscal(CPF_CNPJ: String);
begin
  if Trim(CPF_CNPJ) <> '' then
     Consumidor.AtribuiConsumidor(CPF_CNPJ,'','');
     
  if Consumidor.Atribuido then
  begin
     EpsonComando.Comando  := '0A20' ;
     EpsonComando.Extensao := '0001' ;
     EpsonComando.AddParam(LeftStr(Consumidor.Documento,20));
     EpsonComando.AddParam(LeftStr(Consumidor.Nome,30));
     EpsonComando.AddParam(copy(Consumidor.Endereco, 1,40));
     EpsonComando.AddParam(copy(Consumidor.Endereco,41,40));
     EnviaComando ;
  end ;

  EpsonComando.Comando := '0E01' ;
  EpsonComando.AddParam( '' );
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.CancelaNaoFiscal;
begin
  EpsonComando.Comando  := '0E18' ;
  EpsonComando.Extensao := '0008' ;
  EpsonComando.AddParam('1');   // 1 Campo de entrada N�O usado no Cancelamento de cupom ;
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: String);
begin
  EpsonComando.Comando := '0E15' ;
  EpsonComando.AddParam( CodCNF );
  EpsonComando.AddParam( IntToStrZero(Round(Valor * 100) ,11) );
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: String);
begin
  if DescontoAcrescimo = 0 then
     exit ;

  EpsonComando.Comando := '0E16' ;
  if DescontoAcrescimo < 0 then
     EpsonComando.Extensao := '0006'
  else
     EpsonComando.Extensao := '0007' ;
  EpsonComando.AddParam( IntToStrZero(Round(abs(DescontoAcrescimo) * 100) ,11)  );
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
begin
  EpsonComando.Comando  := '0E1A' ;
  EpsonComando.AddParam( CodFormaPagto ) ;
  EpsonComando.AddParam( IntToStrZero(Round(Valor * 100) ,13) ) ;
  EpsonComando.AddParam( copy(Observacao, 1,40) ) ;
  EpsonComando.AddParam( copy(Observacao,41,40) ) ;
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.FechaNaoFiscal(Observacao: String);
  Var SL : TStringList ;
      I  : Integer ;
begin
  if Trim(Observacao) <> '' then
  begin
     Observacao := AjustaLinhas(Observacao,50) ;
     SL := TStringList.create ;
     try
        SL.Text := Observacao ;
        EpsonComando.Comando  := '0A22' ;
        For I := 0 to 7 do
           if I >= SL.Count then
              EpsonComando.AddParam('')
           else
              EpsonComando.AddParam(SL[I]) ;
        EnviaComando ;
     finally
        SL.Free ;
     end ;
  end ;

  EpsonComando.Comando  := '0E06' ;
  EpsonComando.Extensao := '0001' ;
  EnviaComando ;

  fsRet0906 := '' ;
  fsRet0907 := '' ;
end;

procedure TACBrECFEpson.NaoFiscalCompleto(CodCNF: String; Valor: Double;
  CodFormaPagto, Obs: String);
begin
  { Chama rotinas da classe Pai (fpOwner) para atualizar os Memos }
  with TACBrECF(fpOwner) do
  begin
     AbreNaoFiscal ;
     try
        RegistraItemNaoFiscal(CodCNF, Valor);
        try
           SubtotalizaNaoFiscal(0);
           EfetuaPagamentoNaoFiscal(CodFormaPagto, Valor );
        except
        end ;

        try
           FechaNaoFiscal( Obs );
        except
           on E : Exception do
           begin
              if (pos('0A27',E.Message) <> 0) then   // Erro: "Mensagem promocional n�o pode ser impressa"
                 FechaNaoFiscal                      // Tenta sem Obs
              else
                 raise ;
           end ;
        end ;
     except
        try
           CancelaNaoFiscal
        except
        end;

        raise ;
     end ;
  end ;
end;


function TACBrECFEpson.GetRet0906: String;
begin
  if fsRet0906 = '' then
  begin
     EpsonComando.Comando := '0906' ;
     EnviaComando ;

     fsRet0906 := EpsonResposta.Resposta ;
  end ;

  Result := fsRet0906 ;
end;

function TACBrECFEpson.GetRet0907: String;
begin
  if fsRet0907 = '' then
  begin
     EpsonComando.Comando := '0907' ;
     EnviaComando ;

     fsRet0907 := EpsonResposta.Resposta ;
  end ;

  Result := fsRet0907 ;
end;

// Andre Bohn - Comando para cancelar impress�o do cheque
procedure TACBrECFEpson.CancelaImpressaoCheque;
begin
  if fsImprimeCheque then
  begin
    EpsonComando.Comando := 'EE12' ;
    EnviaComando ;

    fsRet0906 := '' ;
    fsRet0907 := '' ;
  end;
end;

// Andre Bohn - Segundo suporte da epson � mais seguro imprimir o cheque com
// o cupom fechado, eu fiz um teste com o cupom aberto e tive que trocar a MFD.
// Ele disse que futuramente v�o preparar a impress�o do cheque para ter
// o mesmo funcionamento das outras ECFs.
procedure TACBrECFEpson.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
begin
  if fsImprimeCheque then
  begin
    with EpsonComando do
    begin
       Comando := 'EE10' ;
       AddParam( LeftStr(Banco,2) ) ;
       AddParam( IntToStrZero(Round(Valor * Power(10,fpDecimaisQtd) ) ,13)  ) ;
       AddParam( LeftStr(Favorecido,40) ) ;
       AddParam( LeftStr(Cidade,30) ) ;
       AddParam( Observacao ) ;
       AddParam( '' ) ;
       AddParam( FormatDateTime('ddmmyyyy',Data) ) ;
    end ;
    EnviaComando ;         // Envia comando para imprimir o Cheque

    EpsonComando.Comando := '0001' ;
    EnviaComando ;
    while TestBit(EpsonResposta.StatusPrinter,9) and
          (not TestBit(EpsonResposta.StatusPrinter,10)) do // Aguarda a Impress�o e retirar o cheque
    begin
      Sleep(300) ;
      EpsonComando.Comando := '0001' ;
      EnviaComando ;
      
      if (not TestBit(EpsonResposta.StatusPrinter,5)) and
         (not TestBit(EpsonResposta.StatusPrinter,6)) then
         break ;
    end ;
  end ;
end;

// Andre Bohn - Comando para fazer a leitura do CMC7
Function TACBrECFEpson.LeituraCMC7 : String;
begin
  Result :=  '';
  if fsLeituraCMC7 then
  begin
    with EpsonComando do
    begin
       Comando := '0721' ;
       AddParam( '1' ) ;  // Formato '0' = E13B ou '1' - CMC7
       AddParam( 'N' ) ;  // Recebe Informa��es Extendidas (S/N)
       AddParam( 'N' ) ;  // Substituir caracteres n�o reconhecidos por '?' (S/N)
    end ;
    EnviaComando ;       // Envia o comando para Ler o CMC7

    EpsonComando.Comando := '0001' ;
    EnviaComando ;       // Envia comando para verificar se o cheque foi inserido

    while TestBit(EpsonResposta.StatusPrinter, 9) and TestBit(EpsonResposta.StatusPrinter, 10) do // Aguarda leitura do CMC7
    begin
      EpsonComando.Comando := '0001' ;
      EnviaComando ;

      if TestBit(EpsonResposta.StatusPrinter, 4) then
         break ;
    end ;

    EpsonComando.Comando := '0724' ;
    EnviaComando ;       // Busca o CMC7 lido na ECF

    Result := EpsonResposta.Params[0] ;

    EpsonComando.Comando := '0722' ;
    EnviaComando ;       // Ejeta Cheque
  end;
end;

function TACBrECFEpson.GetChequePronto: Boolean;
begin
  EpsonComando.Comando := '0001' ;
  EnviaComando ;         // Obtem o Estado da ECF

  Result := TestBit(EpsonResposta.StatusPrinter, 6) and
            TestBit(EpsonResposta.StatusPrinter, 5) ; // Estado do Sensor de cheque
end;

procedure TACBrECFEpson.IdentificaOperador(Nome: String);
 Var RetCmd : String ;
begin
  // Lendo Operador atual //
  try
     EpsonComando.Comando  := '0551' ;
     Enviacomando ;
     RetCmd := UpperCase(Trim(EpsonResposta.Params[0])) ;
  except
     RetCmd := '' ;
  end ;

  if UpperCase(Trim(Nome)) <> RetCmd then   // Operador � diferente ? //
  begin
     try
        EpsonComando.Comando  := '0550' ;
        EpsonComando.AddParam(LeftStr(Nome,20));
        EnviaComando ;

        RetCmd := '' ;
        repeat
           Sleep(100) ;
           try
              RetCmd := NumCupom ;
           except
           end ;
        until RetCmd <> '' ;
     except
     end ;
  end ;
end;

procedure TACBrECFEpson.CortaPapel(const CorteParcial: Boolean);
begin
  EpsonComando.Comando  := '0702' ;
  EnviaComando ;
end;

procedure TACBrECFEpson.Suprimento(const Valor: Double; Obs, DescricaoCNF,
  DescricaoFPG: String);
begin
  if UpperCase(Trim(DescricaoCNF)) = 'SUPRIMENTO' then
     DescricaoCNF := 'FUNDO DE TROCO' ;

  inherited Suprimento(Valor, Obs, DescricaoCNF, DescricaoFPG);
end;

end.


