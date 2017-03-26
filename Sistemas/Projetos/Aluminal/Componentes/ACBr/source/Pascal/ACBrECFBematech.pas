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
|* 19/05/2004:  Daniel Simoes de Almeida
|*   Primeira Versao: Cria�ao e Distribui�ao da Primeira Versao
|* 21/06/2004:  Daniel Simoes de Almeida
|*   Otimizacao acesso a Variaveis do ECF (NumSerie, NumECF, NumVersao)
|*   Melhorado o suporte a Impressora Thermica MFD
|* 20/05/2005:  Daniel Simoes de Almeida
|*   Corrigido BUG em FechaCupom. Linhas de Observa��o eram impressas erradas.
|*   -  Bug reportado por: Erique Costa
|* 13/06/2005:  Daniel Simoes de Almeida
|*   Corrigido BUG em AbreCupom na MP25 / MFD. Mesmo que CPF/CNPJ n�o fosse
|*   informado era impressa a linha de CPF/CNPJ.
|*   -  Bug reportado por: Anderson Rogerio Bejatto
|* 26/10/2005:  Daniel Simoes de Almeida
|*   Corrigido BUG em CarregaFormasPagamento. Todas as formas carregadas eram
|*   convertidas para Maiusculas   Bug reportado por: Ederson Selvati 
|* 29/10/2005:  Daniel Simoes de Almeida
|*   Adcionado itens SA-Sangria e SU-suprimento em CarregaComprovantesNaoFiscais.
|*   pois esses indices sempre estar�o presentes na Bematech
|* 01/12/2005:  Daniel Simoes de Almeida
|*   Melhorado suporte a VendaItem em MFD, usando  novo comando 63
|*   (n�o imprimia a Unidade)
|* 08/12/2005:  Daniel Simoes de Almeida
|*  - VerificaFimImpressao disparava excess�o quando ECF n�o estava em linha
|*    Bug reportado por: Adriano Alves Dornelas
|*  - Diminuido tempo de alguns Sleeps de 100 para 10 a fim de agilizar a
|*    comunica�ao com o ECF (experimental)
|* 03/05/2006:  Daniel Simoes de Almeida
|*  - Adcionada a propriedade Publica IsTH, que retorna Verdadeiro se o ECF for
|*    T�rmico (mais r�pido)
|*  - Se o ECF for T�rmico imprime as Linhas do Vinculado e Gerencial em apenas
|*    um comando, (muito mais r�pido) 
|* 08/06/2006:  Daniel Simoes de Almeida
|*  - Modificado EnviaComando para tolerar 3 falhas na recep��o do ACK...Ou seja
|*    o erro s� ser� reportado se o ECF retornar ACK inv�lido 3 vezes consecutivas
|* 16/06/2006:  Daniel Simoes de Almeida
|*  - Abertura de Cupom Vinculado as vezes falha na Bematech MP20/40 se usar
|*    todos os par�metros... nesses casos de erro, ser� tentada a abertura com
|*    parametros simples antes de acusar a falha
|*  - Removida a tolerancia de 3 ACKs inv�lidos inserida em 08/06/2006.
|*    Mecanismo de espera do ACK ajustado para trabalhar junto com o TimeOut
|* 29/06/2006:  Daniel Simoes de Almeida
|*  - Aumentado o TimeOut dos comandos LeituraX e AbreRelatorioGerencial
|* 01/08/2006:  Anderson Rogerio Bejatto
|*  - Aumentado o TimeOut do comando FechaCupom
|* 01/09/2006:  Daniel Simoes de Almeida
|*  - Adicionada a verifica��o do Estado  estRequerZ  se o modelo for MFD
|* 07/11/2006:  Daniel Simoes de Almeida
|*  - Adicionada a verifica��o do modelo MP40, que possui apenas 40 colunas
|* 04/12/2006:  Daniel Simoes de Almeida
|*  - Corrigido Bug na abertura de Cupom Fiscal com CNPJ na MP20
|* 01/04/2007:  Daniel Simoes de Almeida
|*  - Implementados m�todos de Cupom N�o Fiscal
|* 04/09/2006:  Daniel Simoes de Almeida
|*  - Adicionada a verifica��o do Estado  estRequerZ  para todos os modelos,
|*    pois a vers�o 3.30 da MP20-FI2, em alguns casos, n�o mais emite a 
|*    Redu��o Z autom�ticamente
|* 11/04/2008:  Daniel Simoes de Almeida
|*  - Adicionado m�todo CortarPapel
|*  - EnviaComando_ECF melhorada para diminuir frequencia de msgs de ACK inv�lido 
|*  - VerificaFimImpressao melhorada para detectar que o ECF est� trabalhando
|*    e com isso aumentar o Tempo de estouro do TimeOut.
|*    - Com isso, n�o � necess�rio setar TimeOuts muito grandes
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFBematech ;

interface
uses ACBrECFClass, ACBrBase, ACBrUtil, ACBrCHQClass,
     Classes ;

const ErrosST1 : array[0..7] of string =
      ('N�mero de par�metros de CMD inv�lido',
       'Cupom aberto',
       'Comando inexistente',
       'Primeiro dado de CMD n�o foi ESC (27d)',
       'Impressora em erro',
       'Erro no rel�gio',
       'Pouco papel',
       'Fim de papel') ;
const ErrosST2 : array[0..7] of string =
      ('Comando n�o executado',
       'CGC/IE do propriet�rio n�o programados',
       'Cancelamento n�o permitido',
       'Capacidade de al�quotas program�veis lotada',
       'Al�quota n�o programada',
       'Erro na Mem�ria RAM CMOS n�o vol�til',
       'Mem�ria fiscal lotada',
       'Tipo de par�metro de CMD inv�lido') ;

const ETX = #03 ;

type

{ Classe filha de TACBrECFClass com implementa�ao para Bematech }
TACBrECFBematech = class( TACBrECFClass )
 private
    fsACK, fsST1, fsST2 : Integer ; { Status da Bematech }
    { Tamanho da Resposta Esperada ao comando. Necess�rio, pois a Bematech nao
      usa um Sufixo padr�o no fim da resposta da Impressora. }
    fs25MFD     : Boolean ;  // True se for MP25 ou Superior (MFD)
    fsBytesResp : Integer ;
    fsFalhasFimImpressao : Integer ;
    fsNumVersao : String ;
    fsNumECF    : String ;
    fsNumLoja   : String ;
    fsNumCRO    : String ;
    fsNumCOOInicial : String ;
    fsArredonda : Char ;
    fsTotalPago : Double ;
    fsTotalizadoresParciais : String ;
    fsNFCodCNF, fsNFCodFPG : String ;
    fsNFValor : Double ;

    fsModelosCheque : TACBrCHQModelos ;

    Function PreparaCmd( cmd : String ) : String ;
 protected
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
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
    function GetArredonda: Boolean; override ;
    function GetChequePronto: Boolean; override ;

    function GetCNPJ: String; override ;
    function GetIE: String; override ;
    function GetDataMovimento: TDateTime; override ;
    function GetGrandeTotal: Double; override ;
    function GetNumCRO: String; override ;
    function GetNumCCF: String; override ;
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

    function GetDadosUltimaReducaoZ: String; override ;

    Function VerificaFimLeitura(var Retorno:String;
       var TempoLimite: TDateTime) : Boolean ; override ;
    function VerificaFimImpressao(var TempoLimite: TDateTime) : Boolean ; override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;

    Property ACK   : Integer read fsACK ;
    Property ST1   : Integer read fsST1 ;
    Property ST2   : Integer read fsST2 ;
    property ModelosCheque : TACBrCHQModelos read fsModelosCheque
       write fsModelosCheque ;

    Property BytesResp : Integer read fsBytesResp write fsBytesResp ;
    Function EnviaComando_ECF( cmd : String ) : String ; override ;

    Procedure AbreCupom ; override ;
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D' ) ; override ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : String  = '') ; override ;
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : String = ''; ImprimeVinculado : Boolean = false) ;
       override ;
    Procedure FechaCupom( Observacao : String = '') ; override ;
    Procedure CancelaCupom ; override ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; override ;

    { Procedimentos de Cupom N�o Fiscal }
    Procedure NaoFiscalCompleto( CodCNF : String; Valor : Double;
       CodFormaPagto  : String; Obs : String ) ; override ;
    Procedure AbreNaoFiscal( CPF_CNPJ : String = '') ; override ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : String = '') ; override ;
    Procedure SubtotalizaNaoFiscal( DescontoAcrescimo : Double = 0;
       MensagemRodape: String = '') ; override ;
    Procedure EfetuaPagamentoNaoFiscal( CodFormaPagto : String; Valor : Double;
       Observacao : String = ''; ImprimeVinculado : Boolean = false) ; override ;
    Procedure FechaNaoFiscal( Observacao : String = '') ; override ;
    Procedure CancelaNaoFiscal ; override ;

    Procedure LeituraX ; override ;
    Procedure ReducaoZ(DataHora : TDateTime = 0 ) ; override ;
    Procedure AbreRelatorioGerencial ; override ;
    Procedure LinhaRelatorioGerencial( Linha : String ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : String ) ; override ;
    Procedure FechaRelatorio ; override ;

    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;

    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;
    Procedure MudaArredondamento( Arredondar : Boolean ) ; override ;
    Procedure CorrigeEstadoErro(Reducao: Boolean = True) ; override ;
    Procedure ImpactoAgulhas( NivelForca : Integer = 2) ; override ;
    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime ) ;
       override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer);
       override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       var Linhas : TStringList ) ; override ;

    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    procedure LerTotaisAliquota ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;
    function AchaICMSAliquota( var AliquotaICMS: String ):
       TACBrECFAliquota; override ;

    procedure CarregaFormasPagamento ; override ;
    procedure LerTotaisFormaPagamento ; override ;
    function AchaFPGDescricao( Descricao : String ) : TACBrECFFormaPagamento ;
       override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    procedure LerTotaisComprovanteNaoFiscal ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;

    Procedure CortaPapel( const CorteParcial : Boolean = false) ; override ;
 end ;

implementation
Uses ACBrECF, 
     SysUtils,
   {$IFDEF COMPILER6_UP} DateUtils, StrUtils, {$ELSE} ACBrD5, Windows,{$ENDIF}
     Math , synaser;

{ ----------------------------- TACBrECFBematech ------------------------------ }

constructor TACBrECFBematech.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsRTS_CTS ;
  { Variaveis internas dessa classe }
  fsST1       := 0 ;
  fsST2       := 0 ;
  fsACK       := 0 ;
  fsBytesResp := 0 ;
  fsTotalPago := 0 ;
  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumLoja   := '' ;
  fsNumCRO    := '' ;
  fsArredonda := ' ';
  fsTotalizadoresParciais := '' ;
  fsFalhasFimImpressao    := 0 ;
  fsNumCOOInicial := '' ;
  fsNFCodCNF := '' ;
  fsNFCodFPG := '' ;
  fsNFValor  := 0 ;

  fsModelosCheque := TACBrCHQModelos.create( true );

  fpModeloStr := 'Bematech' ;
  fpRFDID     := 'BE' ;
end;

destructor TACBrECFBematech.Destroy;
begin
  fsModelosCheque.Free ;

  inherited Destroy ;
end;

procedure TACBrECFBematech.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create('A impressora: '+ModeloStr+' requer'+sLineBreak+
                            'Porta Serial:  (COM1, COM2, COM3, ...)');

  fpDevice.HandShake := hsRTS_CTS ;
  inherited Ativar ; { Abre porta serial }

  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumLoja   := '' ;
  fsNumCRO    := '' ;
  fpMFD       := false ;
  fpTermica   := false ;
  fsArredonda := ' ';
  fsTotalizadoresParciais := '' ;
  fsNumCOOInicial := '' ;
  fsNFCodCNF := '' ;
  fsNFCodFPG := '' ;
  fsNFValor  := 0 ;
  fs25MFD    := false ;

  try
     { Testando a comunica�ao com a porta }
     EnviaComando( #19 ) ;    { Pede Status }

     if (fsACK = 21) or (fsACK <> 6) then
        raise EACBrECFNaoInicializado.Create(
                 'Erro inicializando a impressora '+ModeloStr );

     NumVersao ;   { Inicializa fpMFD, fsNumVersao e fpTermica }

     { Verificando se � MP40. Se for MP40 tem apenas 40 colunas e n�o 48 colunas
       Se os 4 primeiros d�gitos do Numero de s�rie forem 4708, corresponde
       ao modelo MP-20. Se os 4 d�gitos forem 5708, corresponde ao modelo MP-40 }
     if copy(NumSerie,1,4) = '5708' then
        fpColunas := 40 ;
  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFBematech.EnviaComando_ECF( cmd : String ) : String ;
Var ErroMsg : String ;
    B : Byte ;
    PediuStatus : Boolean ;
    FalhasACK   : Integer;
begin
  fsACK   := 0  ;
  fsST1   := 0  ;
  fsST2   := 0  ;
  Result  := '' ;
  ErroMsg := '' ;
  fpComandoEnviado     := '' ;
  fpRespostaComando    := '' ;
  fsFalhasFimImpressao := 0 ;

  PediuStatus := ( cmd = #19 ) ; { quando pede Status nao deve disparar
                                   exce�ao com erros "Pouco Papel" ou "Cupom Aberto" }
  try
     { Codificando CMD de acordo com o protocolo da Bematech }
     cmd := PreparaCmd( cmd ) ;

     fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }
     FalhasACK := 0 ;

     while (fsACK <> 6) do     { Se ACK = 6 Comando foi reconhecido }
     begin
        fsACK := 0 ;
        fpDevice.Serial.Purge ;                   { Limpa a Porta }

        if not TransmiteComando( cmd ) then
           continue ;

        try
           { espera ACK chegar na Porta por 1,5s }
           try
              fsACK := fpDevice.Serial.RecvByte( 1500 ) ;
           except
           end ;

           if fsACK = 0 then
              raise EACBrECFSemResposta.create(
                       'Impressora '+ModeloStr+' n�o responde (ACK = 0)')
           else if fsACK = 21 then    { retorno em caracter 21d=15h=NAK }
              raise EACBrECFSemResposta.create(
                    'Impressora '+ModeloStr+' n�o reconheceu o Comando'+
                    sLineBreak+' (ACK = 21)')
           else if fsACK <> 6 then
              raise EACBrECFSemResposta.create(
                    'Erro. Resposta da Impressora '+ModeloStr+' inv�lida'+
                    sLineBreak+' (ACK = '+IntToStr(fsACK)+')') ;
        except
           on E : EACBrECFSemResposta do
            begin
              fpDevice.Serial.Purge ;

              Inc( FalhasACK ) ;
              if FalhasACK < 3 then
                 Sleep(100)
              else
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
       falha na leitura LeResposta dispara Exce�ao }
     LeResposta ;

     { Separando o Retorno }
     if BytesResp >= 0 then
      begin
        fsST1  := ord( fpRespostaComando[ BytesResp+1 ] ) ;
        fsST2  := ord( fpRespostaComando[ BytesResp+2 ] ) ;
        Result := copy(fpRespostaComando, 1, BytesResp) ;
      end
     else  { Quando BytesResp < 0 espera por ETX no final }
      begin
        fsST1  := ord( fpRespostaComando[ 1 ] ) ;
        fsST2  := ord( fpRespostaComando[ 2 ] ) ;
        Result := copy(fpRespostaComando, 3, Length(fpRespostaComando)-3 ) ;
      end ;

     { Verificando por erros em ST1 e ST2 }
     ErroMsg := '' ;
     For B := 0 to 7 do
     begin
        if TestBit( ST1, B) then
           if (not PediuStatus) or ((B <> 1) and (B <> 6)) then
              ErroMsg := ErroMsg + ErrosST1[ B ] + sLineBreak ;

        if TestBit( ST2, B) then
           ErroMsg := ErroMsg + ErrosST2[ B ] + sLineBreak ;
     end ;

     { Verifica se possui erro "Pouco Papel" = ErrosST1[ 6 ] }
     if pos(ErrosST1[ 6 ] + sLineBreak, ErroMsg) > 0 then
     begin
        DoOnMsgPoucoPapel ;
        { Remove da lista de erros para nao gerar Exce��o }
        ErroMsg := StringReplace(ErroMsg,ErrosST1[ 6 ] + sLineBreak,'',
                                         [rfReplaceAll,rfIgnoreCase]) ;
     end ;

     if ErroMsg <> '' then
      begin
        ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr+sLineBreak+
                   sLineBreak+ErroMsg ;
        raise EACBrECFSemResposta.create(ErroMsg) ;
      end
     else
        Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }

  finally
     BytesResp  := 0 ;
  end ;

end;


function TACBrECFBematech.VerificaFimLeitura(var Retorno:String;
   var TempoLimite: TDateTime) : Boolean ;
 Var LenRet : Integer ;
begin
  LenRet := Length(Retorno) ;

  { L� at� atingir todos os Bytes esperados (BytesResp) e ECF entra EmLinha}
  { BytesResp � necess�rio, pois a Bematech nao usa um Sufixo padr�o no fim
    da resposta da Impressora. }
  { Somei + 2 em BytesResp pois a Bematech tambem envia ST1 e ST2 no final
    de cada comando }
  if BytesResp >= 0 then
     Result := (LenRet >= (BytesResp + 2) )
  else
     Result := (pos(ETX, RightStr(Retorno,4)) > 0) ;

  { Nota sobre o VerificaFimLeitura: A Bematech responde muito antes da
    Impressao terminar, o que pode causar problemas com comandos enviados logo
    ap�s impressoes demoradas como a Leitura X (por exemplo). Para esses casos,
    � necess�rio ativar a propriedade "AguardaImpressao := True" }
end;

function TACBrECFBematech.VerificaFimImpressao(var TempoLimite: TDateTime): Boolean;
Var Cmd , RetCmd : String ;
    wACK : Byte ;
begin
  { Essa fun��o s� � chamada se AguardaImpressao = True,
    Como essa fun��o � executada dentro da "LeResposta", que por sua vez foi
    chamada por "EnviaComando", n�o podemos usar o m�todo "EnviaComando" (ou
    teriamos uma chamada recursiva infinita), por isso o Loop abaixo envia o
    comando #19 diretamente para a Serial, e aguarda por 1 segundo a resposta...
     Se a Bematech conseguir responder, significa que a Impress�o Terminou }
  wACK   := 0 ;
  Result := false ;
  if not EmLinha() then
   begin
     Sleep(100) ;
     GravaLog('Bematech VerificaFimImpressao: ECF fora de linha') ;
   end
  else
   begin
     RetCmd := '' ;
     Cmd    := PreparaCmd( #19 ) ;           // Pede Status //

     try
        GravaLog('Bematech VerificaFimImpressao: Pedindo o Status') ;
        
        fpDevice.Serial.Purge ;              // Limpa buffer de Entrada e Saida //
        fpDevice.Serial.SendString( Cmd );   // Envia comando //}

        // espera ACK chegar na Porta por 1,5s //
        wACK := fpDevice.Serial.RecvByte( 1500 ) ;

        if wACK = 6 then   // ECF Respondeu corretamente, portanto est� trabalhando //
         begin
           GravaLog('Bematech VerificaFimImpressao: ACK = 6, OK... Aguardando ST1 e ST2') ;
           TempoLimite := IncSecond(now, TimeOut);
           fsFalhasFimImpressao := 0 ;

           // Aguarda ST1 e ST2 por mais 2 segundos //
           RetCmd := fpDevice.Serial.RecvBufferStr(2,2000) ;
           Result := (Length( RetCmd ) >= 2) ;
         end
        else
           raise Exception.Create('ACK diferente de 6');
     except
       On E: Exception do
       begin
          if wACK <> 6 then
             Inc( fsFalhasFimImpressao ) ;
          GravaLog('Bematech VerificaFimImpressao: ACK = '+IntToStr(wACK)+
                   ' - Falhas = '+IntToStr(fsFalhasFimImpressao)+
                   ' - Erro: ' + E.Message,True) ;
       end ;
     end ;
   end ;

   if fsFalhasFimImpressao > 4 then
      raise EACBrECFSemResposta.create(
             'Impressora '+ModeloStr+' n�o est� em linha') ;

end;

Function TACBrECFBematech.PreparaCmd( cmd : String ) : String ;  // Adaptada do manual da Bematech //
Var A, iSoma, LenCmd : Integer ;
    STX, NBL, NBH, CSL, CSH : String ;
begin

  result := '' ;
  if cmd = '' then exit ;

  cmd := #27 + cmd ;   { Prefixo ESC }

  { Calculando a Soma dos caracteres ASC }
  iSoma := 0 ;
  For A := 1 to Length(cmd) do
     iSoma := iSoma + ord( cmd[A] ) ;

  { Calculando os d�gitos }
  LenCmd := Length( CMD ) + 2  ;    { + 2 = CSL + CSH }
  STX    := #2 ;
  NBL    := chr( LenCmd mod 256 ) ;
  NBH    := chr( Trunc( LenCmd / 256 ) ) ;
  CSL    := chr( iSoma mod 256 ) ;
  CSH    := chr( Trunc(iSoma / 256 ) ) ;

  result := STX + NBL + NBH + CMD + CSL + CSH
end ;


function TACBrECFBematech.GetDataHora: TDateTime;
Var RetCmd : String ;
    OldShortDateFormat : String ;
begin
  BytesResp := 6 ;
  RetCmd := BcdToAsc( EnviaComando( #35 + #23 ) );
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yy' ;
     result := StrToDate(copy(RetCmd, 1,2) + DateSeparator +
                         copy(RetCmd, 3,2) + DateSeparator +
                         copy(RetCmd, 5,2)) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
  result := RecodeHour(  result,StrToInt(copy(RetCmd, 7,2))) ;
  result := RecodeMinute(result,StrToInt(copy(RetCmd, 9,2))) ;
  result := RecodeSecond(result,StrToInt(copy(RetCmd,11,2))) ;
end;

function TACBrECFBematech.GetNumCupom: String;
begin
  BytesResp := 3 ;
  Result := Trim( BcdToAsc( EnviaComando( #30 ) ) ) ;
end;

function TACBrECFBematech.GetNumCRO: String;
begin
  if fsNumCRO = '' then
  begin
     BytesResp := 2 ;
     fsNumCRO := Trim( BcdToAsc( EnviaComando( #35+#10 ) )) ;
  end ;

  Result := fsNumCRO ;
end;

function TACBrECFBematech.GetNumCCF: String;
begin
  Result := '' ;
  if fpMFD then
  begin
     try
        { Comando disponivel apenas a partir da MP2100 }
        BytesResp := 3 ;
        Result := Trim( BcdToAsc( EnviaComando( #35+#55, 1 ) )) ;
     except
     end ;
  end ;
end;

function TACBrECFBematech.GetNumLoja: String;
begin
  if fsNumLoja = '' then
  begin
     BytesResp := 2 ;
     fsNumLoja := Trim( BcdToAsc( EnviaComando( #35+#15 ) )) ;
  end ;

  Result := fsNumLoja ;
end;

function TACBrECFBematech.GetNumECF: String;
begin
  if fsNumECF = '' then
  begin
     BytesResp := 2 ;
     fsNumECF  := Trim( BcdToAsc( EnviaComando( #35+#14 ) )) ;
  end ;

  Result := fsNumECF ;
end;

function TACBrECFBematech.GetNumSerie: String;
var wRetentar : Boolean ;
begin
  BytesResp := 15 ;
  Result    := '' ;
  wRetentar := Retentar ;

  if fs25MFD then
  begin
     Retentar := false ;
     try
        try
           BytesResp  := 20 ;
           Result     := Trim( EnviaComando( #35+#40 ) ) ;
        except
           BytesResp := 15
        end ;
     finally
        Retentar := wRetentar ;
     end ;
  end ;

  if BytesResp = 15 then
     Result := Trim( EnviaComando( #35+#00 ) ) ;
end;

function TACBrECFBematech.GetNumVersao: String ;
var wRetentar : Boolean ;
    wTimeOut  : Integer ;
    RetCmd    : String ;
begin
  if fsNumVersao = '' then
  begin
     try
        wRetentar := Retentar ;
        wTimeOut  := TimeOut ;
        try
           Retentar    := false ;
           TimeOut     := 1 ;
           BytesResp   := 3 ;      { #35+#41 s� existe na MP2000 Termica }
           fsNumVersao := Trim( BcdToAsc( EnviaComando( #35+#41 ))) ;
           fs25MFD     := True ;
           try
              BytesResp := 42 ;
              RetCmd    := Trim( EnviaComando( #35+#60 )) ;
              fpTermica := (Pos('TH ',RetCmd) > 0) ;
              fpMFD     := fpTermica ;
           except
           end ;
        finally
           Retentar := wRetentar ;
           TimeOut  := wTimeOut ;
        end ;
     except
        fpMFD       := False ;
        BytesResp   := 2 ;
        fsNumVersao := Trim( BcdToAsc( EnviaComando( #35+#01 )))  ;
     end ;
  end ;

  Result := fsNumVersao ;
end;

function TACBrECFBematech.GetTotalPago: Double;
begin
 { O Bug no comando 35 + 22 ainda persiste na versao 010101... Enquanto nao
   obter uma corre��o da Bematech vou ignorar o uso do 35+22 na MPTH e MP25 }
  if fs25MFD then   //  if NumVersao = '010000' then
     Result := fsTotalPago
  else
   begin
     BytesResp := 7 ;
     Result    := StrToFloatDef( BcdToAsc( EnviaComando( #35+#22 ) ),0 ) / 100 ;
   end ;
end;

function TACBrECFBematech.GetSubTotal: Double;
Var RetCmd : String ;
begin
  BytesResp := 7 ;
  RetCmd    := EnviaComando( #29 ) ;
  Result    := StrToFloatDef( BcdToAsc( RetCmd ), 0) / 100 ;
end;

function TACBrECFBematech.GetEstado: TACBrECFEstado;
Var RetCmd : String ;
    DataMov, DataHora : String ;
    B : Byte ;
begin
  if (not fpAtivo) then
     fpEstado := estNaoInicializada
  else
   begin
      BytesResp := 1 ;
      RetCmd    := EnviaComando( #35+#17 ) ;
      try B := ord( RetCmd[1] ) except B := 0 end ;

      fpEstado  := estLivre ;

      if TestBit( B ,3) then
        fpEstado := estBloqueada
      else if TestBit( B ,1) then
        fpEstado := estPagamento
      else if TestBit( B ,0) then
        fpEstado := estVenda ;

      if {fs25MFD and} (fpEstado = estLivre) then
      begin
         BytesResp := 3 ;
         DataMov   := BcdToAsc( EnviaComando( #35 + #27 ) ) ;

         if DataMov = '000000' then
//          fpEstado := estRequerX
            { OBS.: comentado pois a Leitura X na Bematech n�o abre o Movimento,
              apenas a abertura de cupom, inicializa a DataMov }
         else
          begin
            BytesResp := 6 ;
            DataHora  := BcdToAsc( EnviaComando( #35 + #23 ) ) ;

            if DataMov <> copy(DataHora,1,6) then
               fpEstado := estRequerZ ;
          end ;
      end ;

      if fpMFD and fpTermica and (fpEstado = estLivre) then
      begin
         try
            BytesResp := 1 ;
            RetCmd    := EnviaComando( #35+#65 ) ;
            try B := ord( RetCmd[1] ) except B := 0 end ;

            if TestBit( B ,0) then
              fpEstado := estNaoFiscal
            else if TestBit( B ,1) then
              fpEstado := estRelatorio
            else if TestBit( B ,2) then
              fpEstado := estRelatorio ;
         except
         end ;
      end ;
   end ;

  Result := fpEstado ;
  { Bematech Matricial, nao possui Flag para inidicar se est� Imprimindo
    Relat�rio (Cupom Fiscal Vinculado ou Relatorio Gerencial) }
end;

function TACBrECFBematech.GetGavetaAberta: Boolean;
Var B : Byte ;
    Resp : String ;
begin
  BytesResp := 1 ;
  Resp := EnviaComando( #23 ) ;
  B := ord( Resp[1] ) ;
  Result := (B <> 0) ;
end;

function TACBrECFBematech.GetPoucoPapel: Boolean;
begin
  Result := TestBit(fsST1, 6) ;
end;

function TACBrECFBematech.GetHorarioVerao: Boolean;
Var RetCmd : String ;
    B : Byte ;
begin
   BytesResp := 1 ;
   RetCmd    := EnviaComando( #35+#17 ) ;
   try B := ord( RetCmd[1] ) except B := 0 end ;

   Result := TestBit( B ,2)
end;

function TACBrECFBematech.GetArredonda: Boolean;
Var RetCmd : String ;
    B : Byte ;
begin
  if fsArredonda = ' ' then
  begin
     BytesResp := 1 ;
     RetCmd    := EnviaComando( #35+#28 ) ;
     try B := ord( RetCmd[1] ) except B := 0 end ;

     if (B <> 0) then
        fsArredonda := 'S'
     else
        fsArredonda := 'N' ;
  end ;

  Result := (fsArredonda = 'S') ;
end;

Procedure TACBrECFBematech.LeituraX ;
 Var Espera : Integer ;
begin
  Espera := 40 ;
  if fpMFD then
     Espera := 20 ;

  BytesResp := 0 ;
  AguardaImpressao := True ;
  EnviaComando( #06, Espera ) ;
end;

Procedure TACBrECFBematech.AbreGaveta ;
begin
  BytesResp := 0 ;
  EnviaComando( #22 + #100 ) ;
  sleep(100) ;
end;

Procedure TACBrECFBematech.ReducaoZ(DataHora: TDateTime) ;
var
  DataStr: string;
  Espera : Integer ;
begin
  Espera := 40 ;
  if fpMFD then
     Espera := 30 ;

  BytesResp := 0 ;

  DataStr := '' ;
  if DataHora <> 0 then
     DataStr := FormatDateTime('ddmmyyhhnnss',DataHora) ;

  AguardaImpressao := True ;
  EnviaComando( #05 + DataStr, Espera );
end;

Procedure TACBrECFBematech.MudaHorarioVerao ;
begin
  BytesResp := 0 ;
  EnviaComando( #18 ) ;
end;

procedure TACBrECFBematech.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  if EHorarioVerao <> HorarioVerao then
     MudaHorarioVerao ;
end;
 
procedure TACBrECFBematech.MudaArredondamento(Arredondar: Boolean);
var
  Valor: Byte;
begin
  BytesResp := 0 ;

  if ( Arredondar ) then
    Valor := 1
  else
    Valor := 0;

  EnviaComando( #39 + chr( Valor ) ) ;
end;

procedure TACBrECFBematech.AbreCupom  ;
Var StrConsumidor : String ;
begin
  StrConsumidor := '' ;
  if Trim(Consumidor.Documento) <> '' then    { Tem Docto ? }
  begin
     StrConsumidor := padL(Consumidor.Documento ,29) ;

     if fs25MFD then
     begin
        if Trim(Consumidor.Nome) <> '' then      { Tem Nome ? }
        begin
           StrConsumidor := StrConsumidor + padL(Consumidor.Nome ,30) ;

           if Trim(Consumidor.Endereco) <> '' then  { Tem endere�o ? }
              StrConsumidor := StrConsumidor + padL(Consumidor.Endereco ,80) ;
        end ;
     end ;
  end ;


  fpUltimaMsgPoucoPapel := 0 ;  { Zera tempo pra msg de pouco papel }
  BytesResp := 0 ;
  AguardaImpressao := True ;
  EnviaComando( #00 + StrConsumidor, 10) ;

  Consumidor.Enviado := ( StrConsumidor <> '' ) ;
  fsTotalPago := 0 ;
end;

procedure TACBrECFBematech.CancelaCupom;
 Var RetCmd : String ;
     B      : Byte ;
     TemRel : Boolean ;
begin
  BytesResp := 1 ;
  RetCmd := EnviaComando( #35+#17 ) ;
  try B := ord( RetCmd[1] ) except B := 0 end ;

  if not TestBit(B, 5) then         { N�o Permite cancelar cupom fiscal ?? }
  begin
     if not fs25MFD then            { � MP20 ?? }
      begin
        if TestBit( B ,0) then      { Abriu Cupom ?? }
        begin
           { Deve Vender 1 Item para conseguir cancelar }
           VendeItem('00000','CUPOM SERA CANCELADO','NN',1,0.01,0,'') ;
        end ;
      end
     else                           { � MP25 ou MFD ? }
      begin
        { Vamos verificar se o �ltimo documento � Vinculado (CDC) }
        try
           BytesResp := 1 ;
           RetCmd := EnviaComando( #35+#65 ) ;
           B := ord( RetCmd[1] )
        except
           B := 0
        end ;

        if TestBit(B, 6) then             // Pode cancelar CDC ?
        begin
           try
              AguardaImpressao := True ;
              BytesResp := 0 ;
              EnviaComando( #102 , 5) ;   // Cancelando o CDC
           except
           end ;
        end ;
     end ;
  end ;

  BytesResp := 0 ;
  AguardaImpressao := True ;
  EnviaComando( #14 , 15) ;
  fsTotalPago := 0 ;
  fsTotalizadoresParciais := '' ;

  if fpMFD then
     TemRel := (Estado = estRelatorio)  // MFD sinaliza estado Relatorio //
  else
     TemRel := True ;                   // Nao MFD n�o h� flag para sinalizar Relatorio Aberto

  if TemRel then
  begin
     try
       FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (s� por garantia)}
     except   // Exce�ao silenciosa, pois a Impressora pode nao estar em Estado
     end ;    // de Relatorio.
  end ;
end;

procedure TACBrECFBematech.CancelaItemVendido(NumItem: Integer);
begin
  BytesResp := 0 ;
  EnviaComando( #31 + IntToStrZero(NumItem ,4) ) ;
end;

procedure TACBrECFBematech.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
begin
  Observacao := copy(Observacao,1,80) ;
  BytesResp  := 0 ;
  EnviaComando( #72 + CodFormaPagto +
                IntToStrZero( Round(Valor * 100) ,14) +
                Observacao ) ;
  fsTotalPago := fsTotalPago + RoundTo(Valor,-2) ;
end;

procedure TACBrECFBematech.FechaCupom(Observacao: String);
begin
  Observacao := TrimRight( Observacao ) ;
  if Copy( Observacao, length( Observacao ), 1) <> #10 then
     Observacao := Observacao + #10 ;

  Observacao := copy(Observacao,1, 492) ; { Limite da Bematech }
  BytesResp  := 0 ;
  AguardaImpressao := True ;
  EnviaComando( #34 + Observacao, 15 ) ;
  fsTotalPago := 0 ;
end;

procedure TACBrECFBematech.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : String);
Var A_D : Char ;
begin
  if DescontoAcrescimo < 0 then
     A_D := 'd'
  else
     A_D := 'a' ;

  DescontoAcrescimo := abs(DescontoAcrescimo) ;

  { Inicia fechamento com formas de Pagamento }
  BytesResp  := 0 ;
  EnviaComando( #32 + A_D +
                IntToStrZero( Round( DescontoAcrescimo * 100),14) );
  fsTotalPago := 0 ;
end;

Procedure TACBrECFBematech.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
Var QtdStr, ValorStr, AcrescimoStr, DescontoStr : String ;
    CMD : Byte ;
begin
  if Qtd > 9999 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser inferior a 9999.');

  Descricao := trim(Descricao) ;
  Unidade   := padL(Unidade,2) ;

  if fs25MFD or
     ((DescontoAcrescimo <> 'D') and (ValorDescontoAcrescimo > 0)) then   // Tem acrescimo ?
   begin
     BytesResp   := 0 ;
     Codigo      := Trim(Codigo) + #0 ;
     Descricao   := Descricao + #0 ;
     ValorStr    := IntToStrZero( Round( ValorUnitario * 1000), 9) ;
     QtdStr      := IntToStrZero( Round( Qtd * 1000), 7) ;
     AcrescimoStr:= StringOfChar('0',10) ;

     if TipoDescontoAcrescimo='%' then
        DescontoStr := IntToStrZero( Round( RoundTo(ValorUnitario*Qtd,-2) *
                                     ValorDescontoAcrescimo), 10 )
     else
        DescontoStr := IntToStrZero(Round(ValorDescontoAcrescimo*100),10);

     if DescontoAcrescimo <> 'D' then // � acrescimo ?
     begin
        AcrescimoStr := DescontoStr ;
        DescontoStr  := StringOfChar('0',10) ;
     end ;

     EnviaComando(#63 + AliquotaECF + ValorStr + QtdStr + DescontoStr +
                        AcrescimoStr + StringofChar('0',22) + Unidade + Codigo +
                        Descricao ) ;
   end
  else
   begin
     Codigo := padL(Codigo,13) ;  
     if Round( Qtd ) = Qtd then
        QtdStr := IntToStrZero( Round( Qtd ), 4)
     else
        QtdStr := IntToStrZero( Round(Qtd * 1000), 7) ;

     if RoundTo( ValorUnitario, -2 ) = ValorUnitario then
      begin
        ValorStr := IntToStrZero( Round(ValorUnitario * 100), 8) ;
        CMD := 09 ;
      end
     else
      begin
        ValorStr := IntToStrZero( Round(ValorUnitario * 1000), 8) ;
        CMD := 56 ;
      end ;

     if TipoDescontoAcrescimo='%' then
        DescontoStr := IntToStrZero( Round(ValorDescontoAcrescimo * 100), 4)
      else
        DescontoStr := IntToStrZero( Round(ValorDescontoAcrescimo * 100), 8) ;

     if ( StrToIntDef( NumVersao,0 ) >= 300) and (Trim(Unidade) <> '') then
     begin
        BytesResp := 0 ;
        EnviaComando( #62+#51 + Unidade ) ;            { Programando a UN }
     end ;

     if DescricaoGrande then
        if Length( Descricao ) > 29 then       { Programando aumento de Descricao }
           if (StrToIntDef( NumVersao,0 ) >= 300) then
              EnviaComando( #62+#52 + copy(Descricao,1,200) ) ;

     Descricao := padL(Descricao,29) ;
     BytesResp := 0 ;
     EnviaComando(chr(CMD) + Codigo + Descricao + AliquotaECF + QtdStr +
               ValorStr + DescontoStr ) ;
   end ;

  fsTotalPago := 0 ;
  fsTotalizadoresParciais := '' ;
end;

procedure TACBrECFBematech.CarregaAliquotas;
Var StrRet : String ;
    Cont : Integer ;
    Aliquota : TACBrECFAliquota ;
    ValAliq : Double ;
    ByteISS1,ByteISS2 : Byte ;
begin
  BytesResp := 2 ;
  StrRet    := EnviaComando( #35 + #29 ) ;
  try ByteISS1 := Ord(StrRet[1]) ; except ByteISS1 := 0 ; end ;
  try ByteISS2 := Ord(StrRet[2]) ; except ByteISS2 := 0 ; end ;

  BytesResp := 33 ;
  StrRet := EnviaComando( #26 ) ;
  StrRet := BcdToAsc( copy( StrRet,2, Length(StrRet)) ) ;  { 1o Byte nao � BCD }

  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  for Cont := 1 to 16 do
  begin
    ValAliq  := RoundTo( StrToIntDef(copy(StrRet,((Cont-1)*4)+1,4),0)/100,-2);

    if ValAliq > 0 then
    begin
       Aliquota := TACBrECFAliquota.create ;

       Aliquota.Indice   := IntToStrZero(Cont,2) ;
       Aliquota.Aliquota := ValAliq ;

       if Cont < 9 then
        begin
          if TestBit( ByteISS1, 8 -Cont) then
             Aliquota.Tipo := 'S' ;
        end
       else
          if TestBit( ByteISS2, 16-Cont) then
             Aliquota.Tipo := 'S' ;

       fpAliquotas.Add( Aliquota ) ;
    end ;
  end ;
end;

procedure TACBrECFBematech.LerTotaisAliquota;
Var A : Integer ;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  GetTotalIsencao ;

  For A := 0 to fpAliquotas.Count-1 do
  begin
     fpAliquotas[A].Total := RoundTo( StrToFloatDef( BcdToAsc(
                      copy(fsTotalizadoresParciais,(A*7)+1,7)),0) / 100, -2) ;
  end ;
end;


procedure TACBrECFBematech.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
Var ValStr : String ;
begin
  { Impressora Bematech n�o usa o par�metro Posicao }
  ValStr := IntToStrZero( Round(Aliquota * 100) ,4) ;
  Tipo   := UpCase(Tipo) ;
  if Tipo = 'S' then
     Tipo := '1'
  else
     Tipo := '0' ;

  BytesResp := 0 ;
  EnviaComando( #07 + ValStr + Tipo ) ;
  CarregaAliquotas ;
end;

function TACBrECFBematech.AchaICMSAliquota( var AliquotaICMS: String):
   TACBrECFAliquota;
  Var AliquotaStr : String ;
begin
  Result      := nil ;
  AliquotaStr := ''  ;

  AliquotaICMS := UpperCase( Trim( AliquotaICMS ) ) ;
  case AliquotaICMS[1] of
    'I' : AliquotaStr := 'II' ;
    'N' : AliquotaStr := 'NN' ;
    'F' : AliquotaStr := 'FF' ;
    'T' : AliquotaICMS := 'T'+padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
  end;

  if AliquotaStr = '' then
     Result := inherited AchaICMSAliquota( AliquotaICMS )
  else
     AliquotaICMS := AliquotaStr ;
end;


procedure TACBrECFBematech.CarregaFormasPagamento;  { fun�ao Lenta +- 3 sec. }
Var StrRet : String ;
    Cont : Integer ;
    FPagto : TACBrECFFormaPagamento ;
    Descr : String ;
begin
  BytesResp := 1925 ;
  StrRet := EnviaComando( #35+#32, 8 ) ;
  //  1 + (52 * 16) + (52 * 10) + (52 * 10) + (52 * 1)
  //  1 + 832 + 520 + 520 + 52 = 1925

  inherited CarregaFormasPagamento ;   { Cria fpFormasPagamentos }

  For Cont := 1 to 50 do
  begin
    Descr := trim( copy( StrRet, (Cont * 16) - 15 + 1, 16) ) ;
    if Descr <> '' then
    begin
       FPagto := TACBrECFFormaPagamento.create ;

       FPagto.Indice    := IntToStrZero(Cont,2) ;
       FPagto.Descricao := Descr ;
       FPagto.PermiteVinculado := (Cont > 1); {Apenas 1-Dinheiro nao permite}
       FPagto.Total := RoundTo( StrToFloatDef( BcdToAsc(
                           copy(StrRet,(Cont*10) - 9 + 833,10) ),0) / 10000, -4) ;

       fpFormasPagamentos.Add( FPagto ) ;
    end ;
  end ;
end;

procedure TACBrECFBematech.LerTotaisFormaPagamento;
begin
  CarregaFormasPagamento ;
end;


function TACBrECFBematech.AchaFPGDescricao( Descricao: String):
  TACBrECFFormaPagamento;
begin
  { A Bematech permite programas as Formas de Pagamento din�micamente.
    Na MP20 A cada Redu�ao Z as Formas programadas din�micamente sao zeradas.
    O comando abaixo tenta programar novamente a FPG para garantir que ela
    exista... Caso ela j� exista a Bematech retorna o INDICE atual...
    - Isso � necessario pois pode haver situacoes que as Formas de Pagamento
      que constam na memoria do ACBr em "fpFormasPagamentos" j� n�o existem mais
      pois uma Reducao Z foi impressa autom�tica pelo ECF }
  { Nas novas MP25 e MPTH as Formas de Pagamento, nao s�o zeradas na Reducao Z,
    por isso n�o ser� utilizado a programa��o din�mica }
  if (not fs25MFD) then
     ProgramaFormaPagamento( Descricao ) ;

  result := inherited AchaFPGDescricao(Descricao) ;
end;

procedure TACBrECFBematech.ProgramaFormaPagamento( var Descricao: String;
  PermiteVinculado : Boolean; Posicao : String) ;
Var StrRet : String ;
    FPagto : TACBrECFFormaPagamento ;
    VincStr: String ;
begin
  { Impressora Bematech n�o usa o par�metro Posicao }

//{ Bematech recomenda programar 1� Maiuscula e restante Minusculas }
//  Descricao := UpperCase(copy(Descricao,1,1)) + LowerCase(copy(Descricao,2,16));
  { Bematech recomenda nao haver espa�os em Branco na Descricao }
//  Descricao := StringReplace(Descricao,' ','',[rfReplaceAll,rfIgnoreCase]) ;

  Descricao := padL(Descricao,16) ;         { Ajustando tamanho final }
  VincStr   := '' ;
  if fs25MFD then
   begin
     if PermiteVinculado then
        VincStr := '1'
     else
        VincStr := '2' ;
   end
  else
     { Obs: Bematech MP20 nao usa PermiteVinculado. Apenas Fpagto 01-Dinheiro
           (fixa, sempre existente) nao permite Vinculado }
     PermiteVinculado := True ;

  BytesResp := 2 ;
  StrRet := BcdToAsc( EnviaComando( #71 + Descricao + VincStr ) ) ;
  StrRet := copy(StrRet,2,1)+copy(StrRet,4,1) ;

  { Adicionando nova Forma no ObjectList }
  if (StrToIntDef( StrRet, 0 ) > 0) then
  begin
     if Assigned( fpFormasPagamentos ) then
     begin
        { Bematech retorna o mesmo indice se j� existir, verificando se � nova }
        FPagto := AchaFPGIndice(StrRet) ;
        if FPagto = nil then
        begin
           FPagto := TACBrECFFormaPagamento.create ;
           FPagto.Indice    := StrRet ;
           FPagto.Descricao := Trim(Descricao) ;
           FPagto.PermiteVinculado := PermiteVinculado ;
           fpFormasPagamentos.Add( FPagto ) ;
        end ;
        Descricao := FPagto.Descricao ;
     end ;
  end ;
end;

procedure TACBrECFBematech.CarregaComprovantesNaoFiscais;
Var RetCmd, S: String ;
    Cont  : Integer ;
    CNF   : TACBrECFComprovanteNaoFiscal ;
    Descr : String ;
begin
  Cont      := 1 ;
  BytesResp := 1550 ;
  RetCmd    := EnviaComando( #35 + #33, 8 ) ;
  // ( 2 * 50 ) + (10 * 50) + (19 * 50)
  //     100    +    500    +   950    = 1550

  inherited CarregaComprovantesNaoFiscais ;

  S := RetCmd ;
  while Length(S) > 0 do
  begin
    Descr  := trim( copy(S, 13,19) ) ;

    if Descr <> '' then
    begin
       CNF := TACBrECFComprovanteNaoFiscal.create ;

       CNF.Indice    := IntToStrZero(Cont,2) ;
       CNF.Descricao := Descr ;
       CNF.Total     := RoundTo( StrToFloatDef(
                                 BcdToAsc(copy(S,3,10)),0) / 10000, -4) ;
       CNF.Contador  := StrToIntDef( BcdToAsc(copy(S,1,2)),0) ;

       fpComprovantesNaoFiscais.Add( CNF ) ;
    end ;

    S    := copy(S, 32, Length(S) ) ;
    Cont := Cont + 1 ;
  end ;

 { Adicionando SA-Sangria e SU-Suprimento que sempre estar�o presentes na Bematech}
  CNF := TACBrECFComprovanteNaoFiscal.create ;
  CNF.Indice    := 'SA' ;
  CNF.Descricao := 'Sangria' ;
  fpComprovantesNaoFiscais.Insert(0, CNF ) ;

  CNF := TACBrECFComprovanteNaoFiscal.create ;
  CNF.Indice    := 'SU' ;
  CNF.Descricao := 'Suprimento' ;
  fpComprovantesNaoFiscais.Insert(1, CNF ) ;
end;

procedure TACBrECFBematech.LerTotaisComprovanteNaoFiscal;
begin
  CarregaComprovantesNaoFiscais ;
end;

procedure TACBrECFBematech.ProgramaComprovanteNaoFiscal(var Descricao : String;
   Tipo: String; Posicao : String);
Var ProxIndice : Integer ;
    CNF    : TACBrECFComprovanteNaoFiscal ;
begin
  { Obs: Bematech nao usa Tipo }
  Descricao := padL(Descricao,19) ;

  CarregaComprovantesNaoFiscais ;

  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 1) or (ProxIndice > 50) then { Indice passado � v�lido ? }
     ProxIndice := ComprovantesNaoFiscais.Count + 1 ;

  if ProxIndice > 50 then
     raise Exception.create('N�o h� espa�o para programar novos Comprovantes'+
                            ' n�o Fiscais');

  BytesResp := 0 ;
  EnviaComando( #40 + IntToStrZero(ProxIndice,2) + Descricao ) ;

  { Adcionanodo novo CNF no ObjectList }
  CNF := TACBrECFComprovanteNaoFiscal.create ;
  CNF.Indice    := IntToStrZero(ProxIndice,2) ;
  CNF.Descricao := Descricao ;
  fpComprovantesNaoFiscais.Add( CNF ) ;
end;


procedure TACBrECFBematech.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
Var ValStr, DataStr : String ;
    Modelo  : TACBrCHQModelo ;
begin

  Banco      := IntToStrZero( StrToInt(Banco), 3) ;
  Favorecido := padL(Favorecido,45) ;
  Cidade     := padR(trim(Cidade),27) ;
  Observacao := copy(Observacao,1,120) ;
  DataStr    := FormatDateTime('ddmmyyyy',Data) ;
  ValStr     := IntToStrZero( Round(abs(Valor)*100),14) ;

  Modelo := fsModelosCheque.AchaModeloBanco( Banco ) ;
  if Modelo = nil then
     raise Exception.create('Modelo de cheque do Banco: '+Banco+
                            ' n�o encontrado');
  BytesResp := 0 ;
  with Modelo do
     EnviaComando( #57 + ValStr + Favorecido + Cidade + DataStr +
                   chr( ColunaValor    ) + chr( ColunaExtenso1   ) +
                   chr( ColunaExtenso2 ) + chr( ColunaFavorecido ) +
                   chr( ColunaLocal    ) +
                   chr( ColunaDia ) + chr( ColunaMes ) + chr( ColunaAno ) +
                   chr( LinhaValor    ) + chr( LinhaExtenso1   ) +
                   chr( LinhaExtenso2 ) + chr( LinhaFavorecido ) +
                   chr( LinhaLocal ) + Observacao )
end;

procedure TACBrECFBematech.CancelaImpressaoCheque;
begin
  BytesResp := 0 ;
  EnviaComando( #62 + #49 ) ;
end;

function TACBrECFBematech.GetChequePronto: Boolean;
Var B : Byte ;
    Resp : String ;
begin
  BytesResp := 1 ;
  Resp := EnviaComando( #62 + #48 ) ;
  B := ord( Resp[1] ) ;
  Result := not TestBit(B,5) ;
end;

procedure TACBrECFBematech.ImpactoAgulhas( NivelForca : Integer = 2);
Var Value : Integer ;
begin
  if fs25MFD or ( StrToIntDef( NumVersao,0 ) < 310) then
     raise Exception.Create('Comando para aumentar o impacto das agulhas '+
                            'n�o dispon�vel neste modelo de ECF.') ;

  Value := min(max(NivelForca,3),1) ;
  EnviaComando( #124 + IntToStr( Value ) ) ;
end;

procedure TACBrECFBematech.AbreRelatorioGerencial;
 Var Espera : Integer ;
begin
  Espera := 30 ;
  if fpMFD then
     Espera := 10 ;

  BytesResp := 0 ;
  AguardaImpressao := True ;
  EnviaComando( #20, Espera) ;
end;

procedure TACBrECFBematech.LinhaRelatorioGerencial(Linha: String);
Var P, Espera : Integer ;
    Buffer : String ;
    MaxChars : Integer ;
begin
  Linha := AjustaLinhas( Linha, Colunas );  { Formata as Linhas de acordo com "Coluna" }
  MaxChars := 620 ;  { Bematech aceita no m�ximo 620 caract. por comando }

  if not fpTermica then   { Se n�o � Termica, Imprime Linha a Linha }
     ImprimirLinhaALinha( Linha, #20 )
  else
     while Length( Linha ) > 0 do
     begin
        P := Length( Linha ) ;
        if P > MaxChars then    { Acha o fim de Linha mais pr�ximo do limite m�ximo }
           P := PosLast(#10, LeftStr(Linha,MaxChars) ) ;

        if P = 0 then
           P := Colunas ;

        Buffer := copy( Linha, 1, P)  ;
        Espera := Trunc( CountStr( Buffer, #10 ) / 4) ;

        AguardaImpressao := (Espera > 3) ;
        EnviaComando( #20 + Buffer, Espera ) ;

        { ficou apenas um LF sozinho ? }
        if (P = Colunas) and (RightStr( Buffer, 1) <> #10) and
           (copy( Linha, P+1, 1) = #10) then
           P := P + 1 ;

        Linha  := copy( Linha, P+1, Length(Linha) ) ;   // O Restante
     end ;
end;

procedure TACBrECFBematech.AbreCupomVinculado(COO, CodFormaPagto,
   CodComprovanteNaoFiscal :  String; Valor : Double ) ;
Var FPG : TACBrECFFormaPagamento ;
    StrValor, FPGDesc : String ;
    ComandoCompleto : Boolean ;
begin
  FPG := AchaFPGIndice( CodFormaPagto ) ;

  if FPG = nil then
     raise Exception.create( 'Forma de Pagamento: '+CodFormaPagto+
                             ' n�o foi cadastrada.' ) ;

  COO       := Poem_Zeros( trim(COO) ,6) ;
  FPGDesc   := padL( FPG.Descricao, 16 ) ;
//FPGDesc   := UpperCase(copy(FPGDesc,1,1))+LowerCase(copy(FPGDesc,2,16)) ;
  BytesResp := 0 ;
  ComandoCompleto  := ((Valor > 0) and (fs25MFD or (StrToIntDef( NumVersao,0 ) >= 310) )) ;
  StrValor := IntToStrZero( Round(Valor * 100) ,14) ;

  if ComandoCompleto then
    try
       AguardaImpressao := True ;
       EnviaComando( #66 + FPGDesc + StrValor + COO, 10) ;
    except
       ComandoCompleto := False ;
    end ;

  if not ComandoCompleto then
  begin
     AguardaImpressao := True ;
     EnviaComando( #66 + FPGDesc, 10) ;
  end ;
end;

procedure TACBrECFBematech.LinhaCupomVinculado(Linha: String);
Var P, Espera : Integer ;
    Buffer : String ;
    MaxChars : Integer ;
begin
  Linha := AjustaLinhas( Linha, Colunas );  { Formata as Linhas de acordo com "Coluna" }
  MaxChars := 620 ;  { Bematech aceita no m�ximo 620 caract. por comando }

  if not fpTermica then   { Se n�o � Termica, Imprime Linha a Linha }
     ImprimirLinhaALinha( Linha, #67 )
  else
     while Length( Linha ) > 0 do
     begin
        P := Length( Linha ) ;
        if P > MaxChars then    { Acha o fim de Linha mais pr�ximo do limite m�ximo }
           P := PosLast(#10, LeftStr(Linha,MaxChars) ) ;

        Buffer := copy( Linha, 1, P)  ;
        Espera := Trunc( CountStr( Buffer, #10 ) / 4) ;

        AguardaImpressao := (Espera > 3) ;
        EnviaComando( #67 + Buffer, Espera ) ;

        Linha  := copy( Linha, P+1, Length(Linha) ) ;   // O Restante
     end ;
end;

procedure TACBrECFBematech.FechaRelatorio;
begin
  BytesResp := 0 ;
  AguardaImpressao := True ;
  EnviaComando( #21, 10 ) ;  { Fecha o relatorio Gerencial ou Vinculado }
end;

procedure TACBrECFBematech.CorrigeEstadoErro(Reducao: Boolean) ;
begin
  try
     EnviaComando( #70 ) ;
     sleep(200) ;
  except
  end ;

  inherited CorrigeEstadoErro(Reducao) ;

  { Algumas vers�es da Bematech MP20 as vezes, cancelam o Cupom, mas
    permanecem em estado de Pagamento... Geralmente isso ocorre com o termino
    da bobina durante o cancelamento }
  if Estado in [estVenda, estPagamento] then
  begin
     try AbreCupom except end ;
     try CancelaCupom except end ;
  end;
end;

procedure TACBrECFBematech.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal : Integer);
Var Espera : Integer ;
begin
  Espera := 10 + (ReducaoFinal - ReducaoInicial) ;
  AguardaImpressao := True ;
  EnviaComando( #8 + IntToStrZero(ReducaoInicial,6) +
                      IntToStrZero(ReducaoFinal  ,6) + 'I' , Espera ) ;

end;

procedure TACBrECFBematech.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime);
Var Espera : Integer ;
begin
  Espera := 10 + DaysBetween(DataInicial,DataFinal) ;
  AguardaImpressao := True ;
  EnviaComando( #8 + FormatDateTime('ddmmyy',DataInicial) +
                      FormatDateTime('ddmmyy',DataFinal)   + 'I' ,   Espera ) ;

end;

procedure TACBrECFBematech.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas : TStringList);
Var Espera : Integer ;
begin
  BytesResp := -1 ; { espera por ETX }
  Espera := Trunc(10 + ((ReducaoFinal - ReducaoInicial)/2) ) ;
  Linhas.Clear ;
  Linhas.Text := EnviaComando( #8 + IntToStrZero(ReducaoInicial,6)+
                                   IntToStrZero(ReducaoFinal  ,6)+'R', Espera ) ;
end;

procedure TACBrECFBematech.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; var Linhas : TStringList);
Var Espera : Integer ;
begin
  BytesResp := -1 ; { espera por ETX }
  Espera := Trunc(10 + (DaysBetween(DataInicial,DataFinal)/2) ) ;
  Linhas.Clear ;
  Linhas.Text := EnviaComando( #8+FormatDateTime('ddmmyy',DataInicial)+
                                 FormatDateTime('ddmmyy',DataFinal)+'R',Espera);
end;

function TACBrECFBematech.GetCNPJ: String;
begin
  if fs25MFD then
   begin
     BytesResp  := 20 ;
     Result     := Trim( EnviaComando( #35+#42 ) ) ;
   end
  else
   begin
     BytesResp  := 33 ;
     Result     := copy(Trim( EnviaComando( #35+#02 ) ),1,18) ;
   end ;
end;

function TACBrECFBematech.GetIE: String;
begin
  if fs25MFD then
   begin
     BytesResp  := 20 ;
     Result     := Trim( EnviaComando( #35+#43 ) ) ;
   end
  else
   begin
     BytesResp  := 33 ;
     Result     := copy(Trim( EnviaComando( #35+#02 ) ),19,18) ;
   end ;
end;

function TACBrECFBematech.GetDataMovimento: TDateTime;
Var RetCmd : String ;
    OldShortDateFormat : String ;
begin
   BytesResp := 3 ;
   RetCmd    := BcdToAsc( EnviaComando( #35 + #27 ) ) ;

   if RetCmd = '000000' then
      Result := DataHora 
   else
    begin
      OldShortDateFormat := ShortDateFormat ;
      try
         ShortDateFormat := 'dd/mm/yy' ;
         result := StrToDate(copy(RetCmd, 1,2) + DateSeparator +
                             copy(RetCmd, 3,2) + DateSeparator +
                             copy(RetCmd, 5,2)) ;
      finally
         ShortDateFormat := OldShortDateFormat ;
      end ;
    end ;
end;

function TACBrECFBematech.GetGrandeTotal: Double;
Var RetCmd : String ;
begin
  BytesResp := 9 ;
  RetCmd    := EnviaComando( #35 + #03 ) ;
  Result := StrToFloatDef( BcdToAsc( RetCmd ) ,0) / 100 ;
  Result := RoundTo( Result, -2) ;
end;

function TACBrECFBematech.GetNumCRZ: String;
begin
  BytesResp := 2 ;
  Result    := Trim( BcdToAsc( EnviaComando( #35+#09 ) )) ;
end;

function TACBrECFBematech.GetTotalAcrescimos: Double;
Var RetCmd : String ;
begin
  BytesResp := 7 ;
  RetCmd    := EnviaComando( #35 + #30 ) ;
  Result := StrToFloatDef( BcdToAsc( RetCmd ) ,0) / 100 ;
end;

function TACBrECFBematech.GetTotalCancelamentos: Double;
Var RetCmd : String ;
begin
  BytesResp := 7 ;
  RetCmd    := EnviaComando( #35 + #04 ) ;
  Result := StrToFloatDef( BcdToAsc( RetCmd ) ,0) / 100 ;
end;

function TACBrECFBematech.GetTotalDescontos: Double;
Var RetCmd : String ;
begin
  BytesResp := 7 ;
  RetCmd    := EnviaComando( #35 + #05 ) ;
  Result := StrToFloatDef( BcdToAsc( RetCmd ) ,0 ) / 100 ;
end;

function TACBrECFBematech.GetTotalIsencao: Double;
begin
  if fsTotalizadoresParciais = '' then
  begin
    BytesResp := 219 ;
    fsTotalizadoresParciais := EnviaComando( #27, 5 ) ;
  end ;

  Result := StrToFloatDef( BcdToAsc( copy(fsTotalizadoresParciais,113,7) ),0) / 100 ;
end;

function TACBrECFBematech.GetTotalNaoTributado: Double;
begin
  GetTotalIsencao ;

  Result := StrToFloatDef( BcdToAsc( copy(fsTotalizadoresParciais,120,7) ),0) / 100 ;
end;

function TACBrECFBematech.GetTotalSubstituicaoTributaria: Double;
begin
  GetTotalIsencao ;

  Result := StrToFloatDef( BcdToAsc( copy(fsTotalizadoresParciais,127,7) ),0) / 100 ;
end;

function TACBrECFBematech.GetNumUltimoItem: Integer;
Var RetCmd : String ;
begin
  BytesResp := 2 ;
  RetCmd    := EnviaComando( #35 + #12 ) ;
  Result    := StrToIntDef( BcdToAsc( RetCmd ), 0)  ;
end;

function TACBrECFBematech.GetVendaBruta: Double;
Var RetCmd : String ;
begin
  try
     BytesResp := 308 ;
     RetCmd    := BcdToAsc(EnviaComando( #62 + #55, 5 )) ;
     Result    := StrToFloatDef(copy(RetCmd,3,18),0) / 100;

     fsNumCOOInicial := IntToStr(StrToIntDef(copy(RetCmd,569,6),0)+1);
  except
     Result := 0 ;
  end ;

  Result :=  RoundTo( GrandeTotal - Result, -2) ;
end;

function TACBrECFBematech.GetNumCOOInicial: String;
Var Erro : Boolean ;
    RetCmd : String ;
begin
  Erro := False ;
  
  if fpMFD then
  begin
     try
        BytesResp := 6 ;
        { Comando disponivel epenas a partir da MP2100 }
        RetCmd    := EnviaComando( #35 + #72 ) ;
        fsNumCOOInicial := copy( BcdToAsc( RetCmd ) ,1,6) ;
     except
        Erro := True ;
     end ;
  end ;

  if Erro or (fsNumCOOInicial = '') then
     GetVendaBruta ;

  Result := fsNumCOOInicial ;
end ;

procedure TACBrECFBematech.NaoFiscalCompleto(CodCNF: String; Valor: Double;
  CodFormaPagto, Obs: String);
  Var FPG : TACBrECFFormaPagamento ;
begin
  if fs25MFD then
     inherited NaoFiscalCompleto(CodCNF, Valor, CodFormaPagto, Obs)
     
  else
   begin
     FPG := AchaFPGIndice(CodFormaPagto) ;
     if FPG = nil then
        raise Exception.create( 'Forma de pagamento: '+CodFormaPagto+
                                ' n�o encontrada');

     AguardaImpressao := True ;
     EnviaComando( #25 + CodCNF + IntToStrZero(Round(Valor * 100) ,14) +
                         padL(FPG.Descricao,16), 13 ) ;
   end ;
end;

procedure TACBrECFBematech.AbreNaoFiscal(CPF_CNPJ: String);
begin
  if fs25MFD then
  begin
     AguardaImpressao := True ;
     CPF_CNPJ := TrimRight(CPF_CNPJ) ;
     if CPF_CNPJ <> '' then
        padL(CPF_CNPJ,28) ;
        
     EnviaComando( #77 + CPF_CNPJ , 5 ) ;
  end ;

  { Linhas acrescentadas por Marciano Lizzoni }
  fsNFValor  := 0;
  fsNFCodCNF := '';
end;

procedure TACBrECFBematech.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: String = '');
begin
  if fs25MFD then
   begin
     if CodCNF = 'SA' then
        CodCNF := '29'
     else if CodCNF = 'SU' then
        CodCNF := '30' ;

     EnviaComando( #78 + CodCNF + IntToStrZero(Round(Valor * 100) ,14)) ;
     fsNFValor  := 0 ;
     fsNFCodCNF := '' ;
   end
  else
   begin
     if fsNFCodCNF <> '' then
        raise Exception.Create('Essa vers�o de ECF apenas permite o registro '+
                               'de 1 Item n�o Fiscal'); 

     fsNFCodCNF := CodCNF ;
     fsNFValor  := Valor ;
   end ;
end;

procedure TACBrECFBematech.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
begin
  fsNFCodFPG := '' ;
  if fs25MFD then
     EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado)
  else
     fsNFCodFPG := CodFormaPagto ;
end;

procedure TACBrECFBematech.SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: String);
  Var A_D : Char ;
begin
  if not fs25MFD then
  begin
     fsNFValor := max( fsNFValor + DescontoAcrescimo, 0) ;
     exit ;
  end ;
     
  if DescontoAcrescimo < 0 then
     A_D := 'd'
  else
     A_D := 'a' ;

  DescontoAcrescimo := abs(DescontoAcrescimo) ;

  { Inicia fechamento com formas de Pagamento }
  BytesResp  := 0 ;
  EnviaComando( #79 + A_D +
                IntToStrZero( Round( DescontoAcrescimo * 100),14) );
end;

procedure TACBrECFBematech.FechaNaoFiscal(Observacao: String);
begin
  if fs25MFD then
     FechaCupom(Observacao)
  else
     if (fsNFCodFPG <> '') and (fsNFCodCNF <> '') and (fsNFValor > 0) then
        NaoFiscalCompleto(fsNFCodCNF, fsNFValor, fsNFCodFPG, Observacao );
end;

procedure TACBrECFBematech.CancelaNaoFiscal;
begin
  if fs25MFD then
     EnviaComando( #81 ) ;
end;

function TACBrECFBematech.GetDadosUltimaReducaoZ: String;
 Var RetCmd, S : String ;
     I : Integer ;
     VBruta, TOPNF, V : Double ;
begin
  try
     BytesResp := 308 ;
     RetCmd    := BcdToAsc(EnviaComando( #62 + #55, 5 )) ;
  except
     Result := '' ;
     exit ;
  end ;

{ ESC 62 55 - Tamanho de Retorno 616 d�gitos BCD (308 bytes),
              com a seguinte estrutura.
  2 RZAUT Se 00 redu��o por comando, caso contr�rio autom�tica.
 18 GTDA GT no momento da �ltima redu��o.
 14 CANCEL Cancelamentos
 14 DESCON Descontos
 64 TR Tributos
266 TP Totalizadores Parciais Tributados
 14 SANGRIA Sangria
 14 SUPRIMENTOS Suprimentos
126 NSI Totalizadores n�o Sujeitos ao ICMS
 36 CNSI Contadores dos TP�s n�o Sujeitos ao ICMS
  6 COO Contador de Ordem de Opera��o
  6 CNS Contador de Opera��es n�o Sujeitas ao ICMS
  2 AL N�mero de Al�quotas Cadastradas
  6 DATA_PC Data do Movimento
 14 ACRESC Acr�scimo
 14 ACRFIN Acr�scimo Financeiro

RRGGGGGGGGGGGGGGGGGGCCCCCCCCCCCCCCDDDDDDDDDDDDDDT001T002T003T004T005T006T007T008T009T010T011T012T013T014T015T016TPT00000000001TPT00000000002TPT00000000003TPT00000000004TPT00000000005TPT00000000006TPT00000000007TPT00000000008TPT00000000009TPT00000000010TPT00000000011TPT00000000012TPT00000000013TPT00000000014TPT00000000015TPT00000000016IIIIIIIIIIIIIINNNNNNNNNNNNNNFFFFFFFFFFFFFFAAAAAAAAAAAAAAUUUUUUUUUUUUUUTNS00000000001TNS00000000002TNS00000000003TNS00000000004TNS00000000005TNS00000000006TNS00000000007TNS00000000008TNS00000000009CN01CN02CN03CN04CN05CN06CN07CN08CN09COOCOOCNSCNSALDTMOVTAAAAAAAAAAAAAAFFFFFFFFFFFFFF
0000000000000014231000000000000000000000000000001800021605001200050025000250180013001600170002110200100006000100000000000001000000000000020000000000000300000000000004010000000000050100000000000601000000000007010000000000080100000000000901000000000010010000000000110200000000001202000000000013020000000000140200000000001502000000000016020000000001001400000000010114000000000408640000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000162000019161708070000000000011100000000000000
....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+.
}

  Result := '[ECF]'+sLineBreak ;
  try
     Result := Result + 'DataMovimento = ' +
               copy(RetCmd,583,2)+DateSeparator+
               copy(RetCmd,585,2)+DateSeparator+
               copy(RetCmd,587,2)+sLineBreak ;
  except
  end ;

  try
     Result := Result + 'NumSerie = ' + NumSerie + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'NumLoja = ' + NumLoja + sLineBreak ;
     Result := Result + 'NumECF = ' + NumECF + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'NumCOO = ' + copy(RetCmd,569,6) + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'NumCRZ = ' + NumCRZ + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'NumCRO = ' + NumCRO + sLineBreak ;
  except
  end ;

  VBruta := 0 ;
  TOPNF  := 0 ;

  try
     Result := Result + sLineBreak + '[Aliquotas]'+sLineBreak ;
     
     if not Assigned( fpAliquotas ) then
        CarregaAliquotas ;

     S := copy(RetCmd,113,224) ;
     For I := 0 to Aliquotas.Count-1 do
     begin
        V := RoundTo( StrToFloatDef( copy(S,(I*14)+1,14),0) / 100, -2) ;
        Result := Result + padL(Aliquotas[I].Indice,2) +
                           Aliquotas[I].Tipo +
                           IntToStrZero(Trunc(Aliquotas[I].Aliquota*100),4) + ' = '+
                           FloatToStr( V ) + sLineBreak ;
        VBruta := VBruta + V ;
     end ;
  except
  end ;

  try
     Result := Result + sLineBreak + '[OutrasICMS]'+sLineBreak ;
     V := RoundTo( StrToFloatDef( copy(RetCmd,365,14),0) / 100, -2) ;
     Result := Result + 'TotalSubstituicaoTributaria = ' + FloatToStr(V) + sLineBreak ;
     VBruta := VBruta + V ;

     V := RoundTo( StrToFloatDef( copy(RetCmd,351,14),0) / 100, -2) ;
     Result := Result + 'TotalNaoTributado = ' + FloatToStr(V) + sLineBreak ;
     VBruta := VBruta + V ;

     V := RoundTo( StrToFloatDef( copy(RetCmd,337,14),0) / 100, -2) ;
     Result := Result + 'TotalIsencao = ' + FloatToStr(V) + sLineBreak ;
     VBruta := VBruta + V ;
  except
  end ;

  try
     Result := Result + sLineBreak + '[NaoFiscais]'+sLineBreak ;

     if not Assigned( fpComprovantesNaoFiscais ) then
        CarregaComprovantesNaoFiscais ;

     S := copy(RetCmd,379,126) ;

     For I := 0 to min(ComprovantesNaoFiscais.Count-1,11) do
     begin
        V := RoundTo( StrToFloatDef( copy(S,(I*14)+1,14),0) / 100, -2) ;
        Result := Result + padL(ComprovantesNaoFiscais[I].Indice,2) + '_' +
                           ComprovantesNaoFiscais[I].Descricao +' = '+
                           FloatToStr(V) + sLineBreak ;
        TOPNF := TOPNF + V ;
     end ;
  except
  end ;

  Result := Result + sLineBreak + '[Totalizadores]'+sLineBreak;

  try
     V := RoundTo( StrToFloatDef( copy(RetCmd,35,14),0) / 100, -2)  ;
     Result := Result + 'TotalDescontos = ' + FloatToStr( V )  + sLineBreak ;
     VBruta := VBruta + V ;
  except
  end ;

  try
     Result := Result + 'TotalCancelamentos = ' + FloatToStr(
         RoundTo( StrToFloatDef( copy(RetCmd,21,14),0) / 100, -2) )  + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'TotalAcrescimos = ' + FloatToStr(
         RoundTo( StrToFloatDef( copy(RetCmd,589,14),0) / 100, -2) )  + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'TotalNaoFiscal = ' + FloatToStr(TOPNF) + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'VendaBruta = ' + FloatToStr(VBruta) + sLineBreak ;
  except
  end ;

  try
     Result := Result + 'GrandeTotal = ' + FloatToStr(
         RoundTo( StrToFloatDef( copy(RetCmd,3,18),0) / 100, -2) )  + sLineBreak ;
  except
  end ;

end;

procedure TACBrECFBematech.CortaPapel(const CorteParcial: Boolean);
 Var RetCmd : String ;
begin
  if not fpMFD then
     inherited CortaPapel
  else
   begin
     if Estado = estRelatorio then
     begin
        try
           BytesResp := 1 ;
           // 74 Flag de ativa��o do corte do pr�ximo documento //
           RetCmd := EnviaComando( #35+#74 ) ;
        except
           RetCmd := '1' ;
        end ;

        if RetCmd = '0' then
         begin
           if CorteParcial then
              LinhaRelatorioGerencial( #27 + #109 )
           else
               LinhaRelatorioGerencial( #27 + #119 );
         end
        else
           inherited CortaPapel ;
     end ;
   end ;
end;

end.


