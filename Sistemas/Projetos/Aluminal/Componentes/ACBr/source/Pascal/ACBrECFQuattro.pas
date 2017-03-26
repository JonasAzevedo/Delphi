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
|* 15/03/2006:  Daniel Simoes de Almeida
|*   Primeira Versao: Cria�ao e Distribui�ao da Primeira Versao
|* 15/05/2006:  Daniel Simoes de Almeida
|*   - Corrigido v�rios bugs: GetEstado, GetTotalPago, FechaRelatorio,
|*     FechaCupom
******************************************************************************}
{$I ACBr.inc}

unit ACBrECFQuattro ;

interface
uses ACBrECFClass, ACBrBase, ACBrUtil, 
     Classes
     {$IFNDEF CONSOLE}
       {$IFDEF VCL}, Dialogs , Controls , Forms {$ENDIF}
       {$IFDEF VisualCLX}, QDialogs, QControls, QForms {$ENDIF}
     {$ENDIF} ;

type
{ Classe filha de TACBrECFClass com implementa�ao para Quattro }

{ TACBrECFQuattro }

TACBrECFQuattro = class( TACBrECFClass )
 private
    fsArredonda : Char ;
    fsNumVersao : String ;
    fsNumCRO    : String ;
    fsNumECF    : String ;
    fsOldSeq     : String ;
    fsFechando   : Boolean ;
    
    fsModelosCheque : TStringList ;
    fsArqFormato_ChequeTXT: String;

    procedure CarregaFormato_ChequeTXT ;
    function GetModelosCheque: TStringList;
    procedure SetArqFormato_ChequeTXT(const Value: String);

 protected
    function GetDataHora: TDateTime; override ;
    function GetNumCCF: String; override ;
    function GetNumCupom: String; override ;
    function GetNumECF: String; override ;
    function GetNumCRO: String; override ;
    function GetNumCRZ: String; override ;
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

    Function VerificaFimLeitura(var Retorno:String;
       var TempoLimite: TDateTime) : Boolean ; override ;
    function VerificaFimImpressao(var TempoLimite: TDateTime) : Boolean ; override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;

    { Manupila�ao do Arquivo com a configura��o de cheques }
    property ArqFormato_ChequeTXT : String read fsArqFormato_ChequeTXT
       write SetArqFormato_ChequeTXT ;
    property ModelosCheque : TStringList read GetModelosCheque
       write fsModelosCheque ;
    Function AchaModeloBanco( Banco : String ) : String ;

    Function EnviaComando_ECF( cmd : String ) : String ; override ;

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
    Procedure ReducaoZ(DataHora : TDateTime = 0 ) ; override ;
    Procedure AbreRelatorioGerencial ; override ;
    Procedure LinhaRelatorioGerencial( Linha : String ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : String ) ; override ;
    Procedure FechaRelatorio ; override ;
    Procedure PulaLinhas( NumLinhas : Integer = 0 ) ; override ;

    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;
    
    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;
    Procedure MudaArredondamento( Arredondar : Boolean ) ; override ;
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
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;
    function AchaICMSAliquota( var AliquotaICMS : String ) :
       TACBrECFAliquota ;  override;

    procedure CarregaFormasPagamento ; override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    procedure ProgramaComprovanteNaoFiscal(var Descricao: string;
      Tipo: string = ''; Posicao: string = ''); override;

    procedure AbreNaoFiscal(CPF_CNPJ: string);override;
    procedure RegistraItemNaoFiscal(CodCNF: string;Valor: Double; Obs: string);override;
    procedure EfetuaPagamentoNaoFiscal(CodFormaPagto: string;Valor: Double; Observacao: string; ImprimeVinculado: Boolean);override;
    procedure FechaNaoFiscal(Observacao: string);override;


 end ;

implementation
Uses {$IFDEF COMPILER6_UP} DateUtils, StrUtils {$ELSE} ACBrD5, Windows {$ENDIF},
     SysUtils, Math ;

{ ----------------------------- TACBrECFQuattro ------------------------------ }

constructor TACBrECFQuattro.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsDTR_DSR ;
//  fpDevice.HandShake := hsRTS_CTS ;

  { Variaveis internas dessa classe }
  fsFechando    := false ;
  fsArredonda   := ' ' ; 
  fsNumVersao   := '' ;
  fsNumECF      := '' ;
  fsNumCRO      := '' ;
  fsOldSeq      := '' ;

  fsModelosCheque := TStringList.create;

  fpColunas     := 40 ;
  fpModeloStr   := 'Quattro' ;
  fpRFDID       := 'QT' ;
end;

destructor TACBrECFQuattro.Destroy;
begin
  fsModelosCheque.Free ;

  inherited Destroy ;
end;

procedure TACBrECFQuattro.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create('A impressora: '+ModeloStr+' requer'+#10+
                            'Porta Serial:  (COM1, COM2, COM3, ...)');

//  fpDevice.HandShake := hsDTR_DSR ;
  inherited Ativar ; { Abre porta serial }

  fsNumVersao   := '' ;
  fsNumECF      := '' ;
  fsNumCRO      := '' ;
  fpModeloStr   := 'Quattro' ;

  try
     fpDevice.Serial.Purge ;
     sleep(100) ;

     { Testando a comunica�ao com a porta }
     if NumVersao = '' then
        raise EACBrECFNaoInicializado.Create(
                 'Erro inicializando a impressora '+ModeloStr );
  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFQuattro.EnviaComando_ECF( cmd : String ) : String ;
Var ErroMsg : String ;
    Erro : Integer ;
    LeituraMF : Boolean ;
    Verificar : Boolean ;
    STATUS : Char ;
begin
  result    := '' ;
  ErroMsg   := '' ;
  Verificar := false ;
  LeituraMF := (cmd = '++') ;
  fpComandoEnviado   := '' ;
  fpRespostaComando  := '' ;

  { Codificando CMD de acordo com o protocolo da Quattro }
  cmd := #27 + '.' + cmd + '}' ;

  fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }

  while fpComandoEnviado = '' do
  begin
     if not LeituraMF then  {Se estiver lendo Mem.Fiscal tem dados no Buffer}
        fpDevice.Serial.Purge ;                   { Limpa a Porta }

     if not TransmiteComando( cmd ) then
        continue ;

     fpComandoEnviado := cmd ;
  end ;

  if fpDevice.HandShake = hsDTR_DSR then
     fpDevice.Serial.DTR := True ;  { Liga o DTR para ler a Resposta }

  if not fpDevice.Serial.CTS then
     fpDevice.Serial.RTS := false ;

  { Chama Rotina da Classe m�e TACBrClass para ler Resposta. Se houver
    falha na leitura LeResposta dispara Exce�ao }
  LeResposta ;
  Result := fpRespostaComando ;

  if Result = '' then
     Result := '.-0001ERRO:         98}' ;

  { Verificando por erros }
  ErroMsg := '' ;
  if (copy(Result, 1, 5) = '.-P00') and (Length(Result) = 7) then
   begin
     case Result[6] of
       '2'     : ErroMsg := 'Comando n�o foi enviado a Impressora.' ;
       '3'     : ErroMsg := 'Impressora fora de linha ou sem papel.' ;
       '4','6' : ErroMsg := 'N�o foi recebida a resposta da Impressora.' ;
     end;
     Verificar := true ;
   end

  else if copy(Result, 1, 3) = '.-P' then
   begin
     try STATUS := Result[6] except STATUS := ' ' end ;

     if STATUS = '1' then
     begin
        ErroMsg   := 'Impressora fora de linha'+sLineBreak ;
        Verificar := true ;
     end ;

     if STATUS = '5' then
     begin
        if fsOldSeq <> copy(Result,9,4) then
           DoOnMsgPoucoPapel( 'Papel acabando' )
        else
           ErroMsg := 'Impressora Sem Papel' ;
     end ;
   end
  else if copy(Result, 1, 2) = '.-' then
   begin
     Erro := StrToInt(copy(Result,Length(Result)-3,3));
     case Erro of
        02 : ErroMsg := 'O par�metro de c�digo enviado no comando n�o pode ser zero.' ;
        03 : ErroMsg := 'O par�metro de valor enviado no comando possui caracteres n�o num�ricos.' ;
        04 : ErroMsg := 'O par�metro de quantidade enviado no comando n�o pode ser zero.' ;
        05 : ErroMsg := 'O primeiro d�gito do par�metro deve ser obrigatoriamente zero.' ;
        06 : ErroMsg := 'O valor informado no comando n�o pode ser zero.' ;
        07 : ErroMsg := 'Foi detectado um byte n�o alfanum�rico.' ;
        08 : ErroMsg := 'O par�metro informado s� possui espa�os ou zeros' ;
        09 : ErroMsg := 'O c�digo de tributa��o n�o � v�lido.' ;
        10 : ErroMsg := 'O c�digo de tributa��o n�o foi programado.' ;
        11 : ErroMsg := 'No h� documento para autenticar.' ;
        12 : ErroMsg := 'O comando n�o foi terminado corretamente' ;
        13 : ErroMsg := 'O pre�o total do item n�o pode ser zero.' ;
        14 : ErroMsg := 'O cabe�alho n�o foi programado' ;
        15 : ErroMsg := 'O rel�gio n�o foi programado.' ;
        16 : ErroMsg := 'O n�mero do caixa n�o foi programado.' ;
        17 : ErroMsg := 'O cupom est� aberto.' ;
        18 : ErroMsg := 'O desconto n�o pode ser maior ou igual ao total.' ;
        19 : ErroMsg := 'A opera��o comandada n�o � permitida.' ;
        20 : ErroMsg := 'C�digo do par Contador/Totalizador � inv�lido.' ;
        23 : ErroMsg := 'C�digo de indicador inv�lido' ;
        25 : ErroMsg := 'N�mero de linhas maior que 10.' ;
        26 : ErroMsg := 'Par�metro diferente de �S�ou �N�.' ;
        27 : ErroMsg := 'A porcentagem n�o confere.' ;
        28 : ErroMsg := 'O cupom n�o est� aberto.' ;
        29 : ErroMsg := 'N�o est� em interven��o t�cnica.' ;
        31 : ErroMsg := 'Taxa n�o pode ser zero ou espa�os.' ;
        32 : ErroMsg := 'O comando deve ser terminado com 4 zeros.' ;
        33 : ErroMsg := 'A Tabela est� completa.' ;
        34 : ErroMsg := 'Primeiro caracter diferente de �T� ou �S�' ;
        35 : ErroMsg := 'C�digo de tributa��o inv�lido.' ;
        36 : ErroMsg := 'O valor n�o � v�lido.' ;
        37 : ErroMsg := 'A legenda n�o � v�lida.' ;
        38 : ErroMsg := 'O n�mero da redu��o n�o � v�lido.' ;
        39 : ErroMsg := 'Registro n�o encontrado.' ;
        40 : ErroMsg := 'N�o pode autenticar.' ;
        42 : ErroMsg := 'Comando n�o pode ser realizado neste modo de opera��o.' ;
        43 : ErroMsg := '� preciso tirar leitura X.' ;
        44 : ErroMsg := '� preciso executar redu��o Z.' ;
        45 : ErroMsg := 'N�o � poss�vel executar duas redu��es no mesmo dia.' ;
        49 : ErroMsg := 'Comando permitido somente antes da primeira venda.' ;
        50 : ErroMsg := 'N�o � permitido entrar no hor�rio de ver�o das 23 �s 24h.' ;
        51 : ErroMsg := 'N�o � permitido sair do hor�rio de ver�o das 24h � 1h.' ;
        52 : ErroMsg := 'Venda Bruta di�ria excederia 12 d�gitos ap�s o comando ou o valor total do item tem mais de 11 d�gitos.' ;
        53 : ErroMsg := 'N�mero de caracteres �mpar.' ;
        54 : ErroMsg := 'Caracteres inv�lidos.' ;
        55 : ErroMsg := 'Modalidade de pagamento n�o ativa.' ;
        56 : ErroMsg := 'Acr�scimo maior que o total.' ;
        57 : ErroMsg := 'Contador/Totalizador n�o fiscal desativado ou Tentativa de acumular em totalizadores n�o fiscais positivos e negativos no mesmo comprovante n�o fiscal.';
        58 : ErroMsg := 'N�mero de modalidades de pagamento maior que 10.' ;
        59 : ErroMsg := 'Cupom j� foi totalizado. Falta fechar.' ;
        60 : ErroMsg := 'N�o pode executar cancelamento.' ;
        61 : ErroMsg := 'O dia j� foi encerrado.' ;
        62 : ErroMsg := 'O cupom est� sendo totalizado.' ;
        63 : ErroMsg := 'A data � inv�lida.' ;
        64 : ErroMsg := 'Cupom com acumulador negativo n�o pode ser totalizado.' ;
        65 : ErroMsg := 'Comando v�lido apenas em cupom n�o fiscal.' ;
        66 : ErroMsg := 'Comando v�lido apenas em cupom fiscal.' ;
        67 : ErroMsg := 'S� � permitido um lan�amento (ESC.07) em um comprovante n�o-fiscal' ;
        68 : ErroMsg := 'Impressora sem papel.' ;
        69 : ErroMsg := 'Ocorreu falta de energia durante execu��o de comando.' ;
        70 : ErroMsg := 'A palavra TOTAL n�o � permitida.' ;
        71 : ErroMsg := 'Acerto de rel�gio no modo venda s� pode ser feita com data igual.' ;
        72 : ErroMsg := 'Acerto de rel�gio em venda s� at� 5 minutos.' ;
        73 : ErroMsg := 'Acerto de rel�gio em venda s� uma vez ap�s a redu��o.' ;
        75 : ErroMsg := 'J� se encontra no hor�rio de ver�o' ;
        76 : ErroMsg := 'J� saiu do hor�rio de ver�o' ;
        77 : ErroMsg := 'Comando n�o-definido' ;
        78 : ErroMsg := 'COO informado n�o consta na tabela' ;
        79 : ErroMsg := 'Mais de 2 minutos dentro do Comprovante Vinculado' ;
        80 : ErroMsg := '<esc>.08 n�o � aceito neste modo' ;
        81 : ErroMsg := 'Mais de 10 minutos dentro do relat�rio gerencial' ;
        83 : ErroMsg := 'Item a cancelar n�o existe' ;
        84 : ErroMsg := 'Item j� foi cancelado' ;
        85 : ErroMsg := 'Comando com tamanho errado' ;
        86 : ErroMsg := 'Tabela de Vinculados vazia' ;
        87 : ErroMsg := 'Cancelamento de item em cupom com acr�scimo / Apenas um acr�scimo por cupom / Apenas um desconto no subtotal por cupom / Nenhum item ap�s acr�scimo ou desconto no subtotal.' ;
        88 : ErroMsg := 'Comando n�o aceito em cupom vinculado' ;
        89 : ErroMsg := 'Comando n�o aceito em relat�rio gerencial' ;
        90 : ErroMsg := 'N�o h� Segunda via para imprimir' ;
        91 : ErroMsg := 'Tipo de modalidade de pagamento n�o existe/ Tipo de par�metro do comando n�o existe.' ;
        92 : ErroMsg := 'Valor do cheque n�o pode ser nulo ou valor n�o cabe no extenso.' ;
        93 : ErroMsg := 'Layout do cheque � inv�lido ou mecanismo de impress�o do cheque n�o est� dispon�vel.' ;
        94 : ErroMsg := 'N�o pode sair do hor�rio de ver�o : existe uma redu��o com menos de uma hora de diferen�a.' ;
        95 : ErroMsg := 'Segunda via do comprovante n�o fiscal vinculado j� foi impressa.' ;
        96 : ErroMsg := 'Erro na grava��o de modelo com cheque' ;
        97 : ErroMsg := 'Desconto em ISS desabilitado / Desconto maior que o valor tributado.' ;
        98 : ErroMsg := 'Impressora n�o est� respondendo.' ;
     else
        ErroMsg := copy(Result,7,Length(Result)-7) ;
     end ;
   end
  else if copy(Result, 1, 2) = '.+' then
     fsOldSeq := copy(Result,3,4) ;

  if Verificar then
  begin
     ErroMsg := ErroMsg + sLineBreak+
                'Verifique:'+sLineBreak+
                '- A impressora est� ligada ? '+sLineBreak+
                '- A tampa est� aberta ?'+sLineBreak+
                '- Os cabos est�o conectados ?' ;
  end ;

  if ErroMsg <> '' then
   begin
     ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr+
                sLineBreak + sLineBreak+
                ErroMsg ;
     raise EACBrECFSemResposta.create( ErroMsg ) ;
   end
  else
     Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }
end;

Function TACBrECFQuattro.VerificaFimLeitura(var Retorno:String;
   var TempoLimite: TDateTime) : Boolean ;
begin
  { Nota sobre o VerificaFimLeitura: A Quattro responde muito antes da
    Impressao terminar, o que pode causar problemas com comandos enviados logo
    ap�s impressoes demoradas como a Leitura X (por exemplo). Para esses casos,
    � necess�rio ativar a propriedade "AguardaImpressao := True" }
  Result := (RightStr(Retorno,1) = '}') and (Length(Retorno) >= 3) ;
end;


function TACBrECFQuattro.VerificaFimImpressao(var TempoLimite: TDateTime): Boolean;
Var RetCmd : String ;
    I : Integer ;
    DT : TDateTime ;
begin
  { Essa fun��o s� � chamada se AguardaImpressao = True,
    Como essa fun��o � executada dentro da "LeResposta", que por sua vez foi
    chamada por "EnviaComando", n�o podemos usar o m�todo "EnviaComando" (ou
    teriamos uma chamada recursiva infinita), por isso o Loop abaixo envia o
    comando .23 diretamente para a Serial, e aguarda por 1 segundo a resposta...
     Se a Quattro consegir responder, significa que a Impress�o Terminou }
  Result := false ;
  DT     := 0 ;
  if not EmLinha() then
     Sleep(100)
  else
   begin
     RetCmd := '' ;
     I      := 0 ;
     try
        fpDevice.Serial.Purge ;  { Limpa buffer de Entrada e Saida }
        fpDevice.Serial.SendString( #27 + '.23}' );   { Pede Status }
        Sleep(20) ;
     except
     end ;

     while (not VerificaFimLeitura( RetCmd, DT ) ) and (I < 10) do
     begin
        try
           RetCmd := RetCmd + fpDevice.Serial.RecvPacket(100) ;
        except
        end ;
        Inc( I ) ;
     end ;

     Result := VerificaFimLeitura(RetCmd, DT) ;
     if Result then
        Result := (copy(RetCmd,6,1) = '0')
   end ;
end;

function TACBrECFQuattro.GetDataHora: TDateTime;
Var RetCmd : String ;
    OldShortDateFormat : String ;
    P : Integer ;
begin
  RetCmd := EnviaComando( '28' ) ;
  P      := pos('!',RetCmd) ;
  Result := 0 ;
  if P > 0 then
  begin
     OldShortDateFormat := ShortDateFormat ;
     try
        ShortDateFormat := 'dd/mm/yy' ;
        result := StrToDate(copy(RetCmd,P+1,2)+ DateSeparator +
                            copy(RetCmd,P+3,2)+ DateSeparator +
                            copy(RetCmd,P+5,2)) ;
        result := RecodeHour(  result,StrToIntDef(copy(RetCmd,P+7,2),0)) ;
        result := RecodeMinute(result,StrToIntDef(copy(RetCmd,P+9,2),0)) ;
        { Obs.: Quattro nao retorna os Segundos }
     finally
        ShortDateFormat := OldShortDateFormat ;
     end ;
  end ;
end;

function TACBrECFQuattro.GetNumCupom: String;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( '56'+'09' ) ;
  Result := '      ' ;

  if LeftStr(RetCmd, 4) = '.+09' then
     Result := IntToStrZero( StrToIntDef( copy(RetCmd,5,4), 0), 6) ;
end;

function TACBrECFQuattro.GetNumCCF: String;
Var RetCmd : String ;
begin
  Result := '' ;
  RetCmd := EnviaComando( '27'+'1' ) ;

  if LeftStr(RetCmd, 3) = '.+C' then
     Result := IntToStrZero( StrToIntDef( copy(RetCmd,121,4), 0), 6) ;
end;

function TACBrECFQuattro.GetNumCRO: String;
Var RetCmd : String ;
begin
  if Trim(fsNumCRO) = '' then
  begin
     RetCmd := EnviaComando( '56'+'02' ) ;
     if LeftStr(RetCmd, 4) = '.+02' then
        fsNumCRO := IntToStrZero( StrToIntDef(copy(RetCmd,5,4),0),4) ;
  end ;

  Result := fsNumCRO ;
end;

function TACBrECFQuattro.GetNumECF: String;
Var RetCmd : String ;
begin
  if Trim(fsNumECF) = '' then
  begin
     RetCmd := EnviaComando( '27' ) ;  { F � o menor, mais rapido de ler }
        
     if LeftStr(RetCmd, 3) = '.+C' then
        fsNumECF := IntToStrZero( StrToIntDef(copy(RetCmd,4,3),0),4) ;
  end ;

  Result := fsNumECF ;
end;

function TACBrECFQuattro.GetNumSerie: String;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( '56'+'03' ) ;
  Result := '' ;
  if LeftStr(RetCmd, 4) = '.+03' then
     Result := Trim(Copy(RetCmd,5,6)) ;
end;

function TACBrECFQuattro.GetNumVersao: String ;
Var RetCmd : String ;
begin
  if fsNumVersao = '' then
  begin
     RetCmd := EnviaComando( '56'+'04' ) ;
     if (LeftStr(RetCmd, 4) = '.+04') then
        fsNumVersao := copy(RetCmd,5,5) ;
  end ;

  Result := fsNumVersao ;
end;

function TACBrECFQuattro.GetTotalPago: Double;
Var RetCmd : String ;
    SubTot, Falta : Double ;
    P : Integer ;
begin
  Result := 0 ;

  RetCmd := EnviaComando( '56'+'08' ) ;
  if pos('S', copy(RetCmd,5,2)) > 0 then   // Verificando se o Estado � Pagamento 
  begin
     RetCmd := EnviaComando('28') ;
     P      := pos('!',RetCmd) ;
     if P > 0 then
     begin
        SubTot := StrToFloatDef(copy(RetCmd,19,12),0) / 100;
        SubTot := RoundTo(SubTot, -2) ;
        Falta  := StrToFloatDef(copy(RetCmd,100,12),0) / 100 ;
        Falta  := RoundTo(Falta, -2) ;
        Result := max( RoundTo(SubTot - Falta,-2) ,0) ; { evitar negativo }
     end ;
  end ;
end;

function TACBrECFQuattro.GetSubTotal: Double;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando('28') ;
  Result := 0 ;
  if pos('!',RetCmd) > 0 then
     Result := RoundTo(StrToFloatDef(copy(RetCmd,19,12),0) / 100, -2) ;
end;

function TACBrECFQuattro.GetEstado: TACBrECFEstado;
Var RetCmd, Status, Transacao : String ;
    FlagZ, FlagX : Char ;
begin
  if (not fpAtivo) then
     fpEstado := estNaoInicializada
  else
   begin
     RetCmd := EnviaComando( '28' ) ;
     if pos('!',RetCmd) > 0 then
     begin
        try FlagX := RetCmd[124] except FlagX := ' ' end ;
        try FlagZ := RetCmd[18]  except FlagZ := ' ' end ;

        { Status pode ser: C - concluida, P - Pendente, E - Erro no Comando }
        Status    := UpperCase(copy(RetCmd,7,1)) ;
        Transacao := UpperCase(Trim(copy(RetCmd,8,8))) ;

        fpEstado := estDesconhecido ;

        if FlagZ = 'F' then
           fpEstado := estRequerZ
        else if FlagX = 'N' then
           fpEstado := estRequerX
        else if FlagZ = 'S' then
           fpEstado := estBloqueada
        else if fsFechando then
           fpEstado := estPagamento ;

        if fpEstado = estDesconhecido then
        begin
           RetCmd := EnviaComando( '56'+'08' ) ;

           if pos('S', copy(RetCmd,5,2)) > 0 then
              fpEstado := estPagamento ;
        end ;

        if fpEstado = estDesconhecido then
        begin
           RetCmd := EnviaComando( '56'+'06' ) ;

           if (LeftStr(RetCmd, 5) = '.+06S') then
           begin
              if copy(RetCmd,6,1) = 'S' then        // Cupom Fiscal Aberto
                 fpEstado := estVenda
              else if copy(RetCmd,7,1) = 'S' then   // Cupom Vinculado Aberto
                 fpEstado := estRelatorio ;
           end ;
        end ;

        if fpEstado = estDesconhecido then
        begin
           RetCmd := EnviaComando( '56'+'05' ) ;

           if (LeftStr(RetCmd, 5) = '.+05S') then
              fpEstado := estRelatorio ;
        end ;

        if fpEstado = estDesconhecido then
           fpEstado := estLivre ;
     end ;
   end ;

  Result := fpEstado ;
end;

function TACBrECFQuattro.GetGavetaAberta: Boolean;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando('22') ;
  Result := (copy(RetCmd,1,6) <> '.+G000')
end;

function TACBrECFQuattro.GetPoucoPapel: Boolean;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( '23' ) ;
  Result := (copy( RetCmd, 6,1) = '5') ;
end;

function TACBrECFQuattro.GetHorarioVerao: Boolean;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( '28' ) ;
  Result := False ;
  if pos('!',RetCmd) > 0 then
     Result := (copy(RetCmd,54,1) = 'S') ;
end;

function TACBrECFQuattro.GetArredonda: Boolean;
Var RetCmd : String ;
begin
  if fsArredonda = ' ' then
  begin
     RetCmd := EnviaComando( '56'+'10' , 6) ;
     if (LeftStr(RetCmd, 4) = '.+10') then
        fsArredonda := RetCmd[5] ;
  end ;

  Result := (fsArredonda = 'S') ;
end;

Procedure TACBrECFQuattro.LeituraX ;
begin
  AguardaImpressao := True ;
  EnviaComando('13N' , 45 ) ;
end;

Procedure TACBrECFQuattro.ReducaoZ(DataHora: TDateTime) ;
begin
  AguardaImpressao := true ;
  EnviaComando( '14N', 50 ) ;

  if DataHora <> 0 then
     try
        EnviaComando('35'+FormatDateTime('hhnnssddmmyy',DataHora) );
     except
     end ;
end;

Procedure TACBrECFQuattro.AbreGaveta ;
begin
  EnviaComando('21',7) ;
end;

Procedure TACBrECFQuattro.MudaHorarioVerao ;
begin
  MudaHorarioVerao( not HorarioVerao );
end;

procedure TACBrECFQuattro.MudaHorarioVerao(EHorarioVerao: Boolean);
Var Cmd  : String ;
begin
  If EHorarioVerao then Cmd := 'S' else Cmd := 'N' ;

  EnviaComando( '36' + Cmd, 3 ) ;
end;

procedure TACBrECFQuattro.MudaArredondamento(Arredondar: Boolean);
Var Cmd  : String ;
begin
  If Arredondar then Cmd := 'S' else Cmd := 'N' ;

  EnviaComando( '57' + '01' + Cmd, 3 ) ;
  fsArredonda := ' ' ;
end;

procedure TACBrECFQuattro.AbreCupom ;
Var CPF_CNPJ : String ;
begin
  fpUltimaMsgPoucoPapel := 0 ;  { Zera tempo pra msg de pouco papel }
//  if Estado = estRequerX then
//     raise Exception.create('Leitura X inicial ainda n�o foi emitida');

  CPF_CNPJ := '' ;
  if (Consumidor.Documento <> '') then
     CPF_CNPJ := padL(Consumidor.Documento,20) ;

  AguardaImpressao := True ;
  EnviaComando('17'+CPF_CNPJ, 10) ;
  fsFechando := false ;
  Consumidor.Enviado := (CPF_CNPJ <> '') and
                        (Trim(Consumidor.Nome)+Trim(Consumidor.Endereco)='')
end;

procedure TACBrECFQuattro.CancelaCupom;
Var RetCmd   : String ;
    Cancelou : Boolean ;
    SubTot   : Double ;
begin
  AguardaImpressao := True ;
  RetCmd   := EnviaComando( '05' ,25) ;
  Cancelou := (copy(RetCmd,1,2) = '.+') ;

  if (not Cancelou) and (Estado = estPagamento) then { Pagamento aberto, Efetua Pagamento, Fecha e Cancela }
  begin
     SubTot := Subtotal ;
     EnviaComando('10'+'01'+IntToStrZero( Round(SubTot*100) ,12) ) ; { 10-Paga }

     EnviaComando('12', 10 ) ;   { 12-Fecha }
     EnviaComando('05' ,25) ;    { 05-Cancela }
  end ;

  FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (s� por garantia)}
end;

procedure TACBrECFQuattro.CancelaItemVendido(NumItem: Integer);
begin
  EnviaComando( '04' + IntToStrZero(NumItem,3) ) ;
end;

procedure TACBrECFQuattro.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
begin
  Observacao := '{' + copy(Observacao,1,80) ;

  EnviaComando('10' + CodFormaPagto + IntToStrZero( Round(Valor*100) ,12) +
                     Observacao , 5, 5) ;

  fsFechando := true ;
end;

procedure TACBrECFQuattro.FechaCupom(Observacao: String);
Var Linhas : TStringList ;
    I      : Integer ;
    Obs    : String ;
begin
  Observacao := AjustaLinhas( Observacao, Colunas, 8 );
  Obs        := '' ;

  Linhas := TStringList.Create ;
  try
     Linhas.Text := Observacao ;

     for I := 0 to min(Linhas.Count-1 ,8) do
        Obs := Obs + '0' + padL( Linhas[I] , Colunas) ;
  finally
     Linhas.Free ;
  end ;

  { Fecha cupom }
  AguardaImpressao := True ;
  EnviaComando( '12' + Obs, 10 ) ;

  fsFechando := false ;
end;

procedure TACBrECFQuattro.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : String );
begin
  if DescontoAcrescimo < 0 then
   begin
     DescontoAcrescimo := abs(DescontoAcrescimo) ;
     EnviaComando('03' + StringofChar(' ',10) +
                  IntToStrZero(Round(DescontoAcrescimo*100),12), 3) ;
   end
  else if DescontoAcrescimo > 0 then
      EnviaComando('11' + '  ' + '0000' +
                  IntToStrZero(Round(DescontoAcrescimo*100),11), 3) ;

  { Inicia fechamento com formas de Pagamento }
//  EnviaComando('10') ;

  fsFechando  := true ;
end;

Procedure TACBrECFQuattro.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
Var QtdStr, ValorStr, Descr2 : String ;
    ValDesc, ValTotal : Double ;
begin
  { Obs.: Quattro nao usa parametro Unidade }
  if Qtd > 9999 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser inferior a 9999.');

  { Quattro n�o permite Acrescimo por Item }
  if (ValorDescontoAcrescimo > 0) and (DescontoAcrescimo = 'A') then
     raise EACBrECFCMDInvalido.Create(
           'ECF '+ModeloStr+' n�o permite Acr�scimo por Item');

  Codigo  := padL(Codigo,13) ;    { Ajustando Tamanhos }
  if Unidade <> '' then
     Descricao := Descricao + ' ' + padL(Unidade,2);

  Descr2  := '' ;                 { Usa descri�ao Grande ? }
  if DescricaoGrande Then
     Descr2 := copy(Descricao,24, Length(Descricao)) ;

  Descr2 := Trim(Descr2) ;
  if Length(Descr2) > 0 then
     Descr2 := padL(Descr2, min(Trunc(Length(Descr2)/40)+1,4)*40 ) ;

  Descricao   := padL(Descricao,23) ; {23 e nao 24 porque adiciona o campo Sinal}
  QtdStr      := IntToStrZero( Round( Qtd*1000 ) ,7) ;
  ValorStr    := IntToStrZero( Round( ValorUnitario*1000 ) ,9) ;

  if Arredonda then
     ValTotal := RoundTo( Qtd*ValorUnitario, -2 )
  else
     ValTotal := RoundTo(TruncFix(Qtd*ValorUnitario*100)/100,-2) ;
     
  EnviaComando( '01' + Codigo + QtdStr + ValorStr + StringOfChar(' ',12) + '~' +
                Descricao + AliquotaECF + Descr2 ) ;
  fsFechando := false ;

  if ValorDescontoAcrescimo > 0 then
  begin
     if TipoDescontoAcrescimo = '%' then
        ValDesc := RoundTo( ValTotal * (ValorDescontoAcrescimo / 100), -2)
     else
        ValDesc := ValorDescontoAcrescimo ;
        
     EnviaComando('02' + StringOfChar(' ',10) +
                         IntToStrZero( Round(ValDesc*100) ,12) ) ;
  end ;
end;

procedure TACBrECFQuattro.CarregaAliquotas;
Var RetCmd, AliquotasStr, AliqStr : String ;
    Aliquota : TACBrECFAliquota ;
    ValAliq : Double ;
    A : Integer ;
begin
  AliquotasStr := '' ;
  AliqStr      := '' ;

  RetCmd := EnviaComando('29'+'3') ;
  if copy(RetCmd,1,3) = '.+T' then
  begin
     AliquotasStr := AliquotasStr + copy(RetCmd,49,64) ;

     RetCmd := EnviaComando('29'+'4') ;
     if copy(RetCmd,1,3) = '.+T' then
     begin
        AliquotasStr := AliquotasStr + copy(RetCmd,8,112) ;

        RetCmd := EnviaComando('29'+'5') ;
        if copy(RetCmd,1,3) = '.+T' then
           AliquotasStr := AliquotasStr + copy(RetCmd,8,64) ;
     end ;
  end ;

  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  for A := 1 to 15 do
  begin
     AliqStr := copy(AliquotasStr,((A-1) * 16) + 1,16) ;
     ValAliq := StrToIntDef(copy(AliqStr,9,4),0) / 100 ;
     if (StrToIntDef( copy(AliqStr,2,2) ,0) > 0) and
        (pos(copy(AliqStr,1,1),'TS') > 0)        then
     begin
        Aliquota := TACBrECFAliquota.create ;

        Aliquota.Indice   := copy(AliqStr,1,3) ;
        Aliquota.Aliquota := ValAliq ;
        if copy(AliqStr,1,1) = 'S' then
           Aliquota.Tipo := 'S' ;

        fpAliquotas.Add( Aliquota ) ;
     end ;
  end ;
end;

procedure TACBrECFQuattro.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
Var ProxIndice : Integer ;
    ValStr : String ;
    Aliq : TACBrECFAliquota ;    
begin
  ValStr := IntToStrZero( Round(Aliquota * 100) ,4) ;
  Tipo := UpCase(Tipo) ;
  if Tipo <> 'S' then
     Tipo := 'T' ;

  CarregaAliquotas ;

  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 1) or (ProxIndice > 15) then { Indice passado � v�lido ? }
  begin
     For ProxIndice := 1 to 16 do  { Procurando Lacuna }
     begin
        if (AchaICMSIndice('T'+IntToStrZero(ProxIndice,2)) = nil) and
           (AchaICMSIndice('S'+IntToStrZero(ProxIndice,2)) = nil) then
           break ;
     end ;
  end ;

  if ProxIndice > 15 then
     raise Exception.create('N�o h� espa�o para programar novas Aliquotas');

  EnviaComando( '33' + Tipo + IntToStrZero(ProxIndice,2) + ValStr ) ;

  { Adcionanodo nova Aliquota no ObjectList }
  Aliq := TACBrECFAliquota.create ;
  Aliq.Indice   := Tipo + IntToStrZero(ProxIndice,2) ;
  Aliq.Aliquota := Aliquota ;
  Aliq.Tipo     := Tipo ;
  fpAliquotas.Add( Aliq ) ;
end;


function TACBrECFQuattro.AchaICMSAliquota( var AliquotaICMS: String):
  TACBrECFAliquota;
  Var AliquotaStr : String ;
begin
  AliquotaStr := '' ;
  Result      := nil ;

  {Por indice, permite T01, TT01 ou T1 => todas devem ser indice = T01 }
  
  if pos(copy(AliquotaICMS,1,2), 'TT,SS') > 0 then { Corrige Duplo T ou S }
     AliquotaICMS := copy(AliquotaICMS,2,5) ;

  case AliquotaICMS[1] of
    'I' : AliquotaStr := 'I  ' ;
    'N' : AliquotaStr := 'N  ' ;
    'F' : AliquotaStr := 'F  ' ;
    'T' : AliquotaICMS := 'TT'+padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
    'S' : AliquotaICMS := 'TS'+padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
  end ;

  if AliquotaStr = '' then
     Result := inherited AchaICMSAliquota( AliquotaICMS )
  else
     AliquotaICMS := AliquotaStr ;
end;

procedure TACBrECFQuattro.CarregaFormasPagamento;
Var RetCmd, Str, Descricao : String ;
    Cont : Integer ;
    FPagto : TACBrECFFormaPagamento ;
begin
  Str := '' ;
  RetCmd := EnviaComando('29' + '5') ;
  if copy(RetCmd,1,3) = '.+T' then
  begin
     Str := Str + copy(RetCmd, 72, 45) ;

     RetCmd := EnviaComando('29' + '6') ;
     if copy(RetCmd,1,3) = '.+T' then
        Str := Str + copy(RetCmd, 8, 105) ;
  end ;

  inherited CarregaFormasPagamento ;       {Inicializa fpFormasPagamentos}

  for Cont := 1 to 10 do
  begin
    Descricao   := TrimRight( copy(Str, (Cont * 15) - 14, 15) ) ;

    if Descricao <> '' then
    begin
       FPagto := TACBrECFFormaPagamento.create ;

       FPagto.Indice    := IntToStrZero(Cont,2) ;
       FPagto.Descricao := Descricao ;
       FPagto.PermiteVinculado := (Descricao[1] = '$') ;

       fpFormasPagamentos.Add( FPagto ) ;
    end ;
  end
end;

procedure TACBrECFQuattro.ProgramaFormaPagamento(var Descricao: String;
  PermiteVinculado: Boolean; Posicao : String);
Var FPagto : TACBrECFFormaPagamento ;
begin
  If PermiteVinculado then
     Descricao := '$'+Descricao ;

  Descricao := padL(Descricao,15) ;

  EnviaComando( '37' + Descricao ) ;

  { Adcionanodo nova FPG no ObjectList }
  FPagto := TACBrECFFormaPagamento.create ;
  FPagto.Indice    := IntToStrZero(FormasPagamento.Count,2) ;
  FPagto.Descricao := Descricao ;
  FPagto.PermiteVinculado := PermiteVinculado ;
  fpFormasPagamentos.Add( FPagto ) ;
end;

procedure TACBrECFQuattro.CarregaComprovantesNaoFiscais;
Var RetCmd, Str, Descricao : String ;
    Cont : Integer ;
    CNF : TACBrECFComprovanteNaoFiscal ;
begin
  RetCmd := EnviaComando('29' + '7') ;
  if copy(RetCmd,1,3) <> '.+T' then exit ;
  Str := Str + copy(RetCmd, 8, 120) ;

  RetCmd := EnviaComando('29' + '8') ;
  if copy(RetCmd,1,3) <> '.+T' then exit ;
  Str := Str + copy(RetCmd, 8, 120) ;

  RetCmd := EnviaComando('29' + '9') ;
  if copy(RetCmd,1,3) <> '.+T' then exit ;
  Str := Str + copy(RetCmd, 8, 60) ;

  inherited CarregaComprovantesNaoFiscais ;{Inicializa fpComprovantesNaoFiscais}

  for Cont := 1 to 20 do
  begin
    Descricao := Trim( copy(Str, (Cont * 15) - 14, 15) ) ;

    if (Descricao <> '') and
       (Descricao <> StringOfChar('-',15)) then
    begin
       CNF := TACBrECFComprovanteNaoFiscal.create ;
       CNF.Indice := IntToStrZero(Cont+10,2) ;
       CNF.Descricao := Descricao ;

       fpComprovantesNaoFiscais.Add( CNF ) ;
    end
  end ;
end;

procedure TACBrECFQuattro.ProgramaComprovanteNaoFiscal(var Descricao: String;
  Tipo: String; Posicao : String);
Var CNF : TACBrECFComprovanteNaoFiscal ;
begin
  if Trim(Tipo) = '' then
     Tipo := '+' ;

  if (pos(Tipo,'&+-') = 0) or (Length(Tipo) > 1) then
     raise Exception.Create('Os Tipos v�lidos para Quattro s�o:'+sLineBreak+
                            '&  Cria�ao de um novo Grupo (Titulo)'+sLineBreak+
                            '+  Entrada de Recursos'+sLineBreak+
                            '-  Saida de Recursos'+sLineBreak+sLineBreak ) ;

  EnviaComando( '38' + 'N' + padL(Tipo + Descricao,15) ) ;

  { Adcionanodo novo CNF no ObjectList }
  CNF := TACBrECFComprovanteNaoFiscal.create ;
  CNF.Indice    := IntToStrZero(ComprovantesNaoFiscais.Count,2) ;
  CNF.Descricao := Descricao ;
  fpComprovantesNaoFiscais.Add( CNF ) ;
end;


procedure TACBrECFQuattro.AbreRelatorioGerencial;
begin
  AguardaImpressao := True ;
  EnviaComando( '13' + 'S' ,50 );
end;

procedure TACBrECFQuattro.LinhaRelatorioGerencial(Linha: String);
begin
  ImprimirLinhaALinha( Linha, '080' );
end;

procedure TACBrECFQuattro.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
begin
  COO := IntToStrZero(StrToInt(COO),4) ;

  AguardaImpressao := True ;
  EnviaComando( '1900' + COO + CodFormaPagto ,10 ) ;
end;

procedure TACBrECFQuattro.LinhaCupomVinculado(Linha: String);
begin
  LinhaRelatorioGerencial( Linha ) ;
end;

procedure TACBrECFQuattro.FechaRelatorio;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( '56'+'05' ) ;
  if (LeftStr(RetCmd, 5) = '.+05S') then  // Relatorio Gerencial ? //
  begin
     AguardaImpressao := True ;
     EnviaComando('08', 10) ;
  end ;

  RetCmd := EnviaComando( '56'+'06' ) ;
  if (LeftStr(RetCmd, 5) = '.+06S') then  // Relatorio Gerencial ? //
  begin
     AguardaImpressao := True ;
     EnviaComando( '12', 10 ) ;
   end ;
end;

procedure TACBrECFQuattro.PulaLinhas(NumLinhas: Integer);
begin
  if NumLinhas = 0 then
     NumLinhas := LinhasEntreCupons ;

  NumLinhas := min(NumLinhas,9) ;

  EnviaComando('089'+IntToStrZero(NumLinhas,1)) ;
end;

procedure TACBrECFQuattro.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal: Integer);
Var Espera : Integer ;
begin
  Espera := 20 + (ReducaoFinal - ReducaoInicial) ;
  AguardaImpressao := True ;
  EnviaComando( '15' + IntToStrZero(ReducaoInicial,4) +
                       IntToStrZero(ReducaoFinal  ,4) , Espera ) ;
end;

procedure TACBrECFQuattro.LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime);
Var Espera : Integer ;
begin
  Espera := 20 + DaysBetween(DataInicial,DataFinal) ;
  AguardaImpressao := True ;
  EnviaComando('16' + FormatDateTime('ddmmyy',DataInicial) +
                      FormatDateTime('ddmmyy',DataFinal  ) ,  Espera ) ;
end;

procedure TACBrECFQuattro.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas : TStringList);
Var Ret,Resp,Linha : String ;
    P1,P2 : Integer ;
    wTempoInicioMsg : Integer ;
    wRetentar : Boolean ;
begin
  Linhas.Clear ;
  wRetentar := Retentar ;
  wTempoInicioMsg := TempoInicioMsg ;
  try
     Retentar       := false ;
     TempoInicioMsg := 10 ;
     Resp := EnviaComando( '15' + IntToStrZero(ReducaoInicial,4) +
                                  IntToStrZero(ReducaoFinal  ,4) + '|', 15) ;
     Repeat
        try
           Ret := EnviaComando('++') ;
        except
           break ;
        end ;

        Resp := Resp  + Ret ;
     Until (Pos('.]}',Ret) > 0) ;

     Resp := StringReplace(Resp,'.]}','',[rfReplaceAll]) ;
     while Resp <> '' do
     begin
        P2 := pos('}',Resp) ;
        if P2 = 0 then P2 := Length(Resp) ;
        P1 := pos('.+',Resp) ;
        if (P1 = 0) or (P1 > P2) then P1 := -5 ;

        Linha := Copy(Resp,P1+6, P2-P1-6) ;
        Linhas.Add( Linha ) ;
        Resp := copy(Resp,P2+1,Length(Resp)) ;
     end ;
  finally
     Retentar       := wRetentar ;
     TempoInicioMsg := wTempoInicioMsg ;
  end ;
end;

procedure TACBrECFQuattro.LeituraMemoriaFiscalSerial(DataInicial,
  DataFinal: TDateTime; var Linhas : TStringList);
Var Ret,Resp,Linha : String ;
    P1,P2 : Integer ;
    wTempoInicioMsg : Integer ;
    wRetentar : Boolean ;
begin
  Linhas.Clear ;
  wRetentar := Retentar ;
  wTempoInicioMsg := TempoInicioMsg ;
  try
     Retentar       := false ;
     TempoInicioMsg := 10 ;
     Resp := EnviaComando( '16' + FormatDateTime('ddmmyy',DataInicial)+
                                  FormatDateTime('ddmmyy',DataFinal)  + '|',15 );
     Repeat
        try
           Ret := EnviaComando('++') ;
        except
           break ;
        end ;

        Resp := Resp  + Ret ;
     Until (Pos('.]}',Ret) > 0) ;

     Resp := StringReplace(Resp,'.]}','',[rfReplaceAll]) ;
     while Resp <> '' do
     begin
        P2 := pos('}',Resp) ;
        if P2 = 0 then P2 := Length(Resp) ;
        P1 := pos('.+',Resp) ;
        if (P1 = 0) or (P1 > P2) then P1 := -5 ;

        Linha := Copy(Resp,P1+6, P2-P1-6) ;
        Linhas.Add( Linha ) ;
        Resp := copy(Resp,P2+1,Length(Resp)) ;
     end ;
  finally
     Retentar       := wRetentar ;
     TempoInicioMsg := wTempoInicioMsg ;
  end ;
end;

function TACBrECFQuattro.GetChequePronto: Boolean;
//Var RetCmd : String ;
begin
//  RetCmd := EnviaComando('23') ;
//  Result := (copy( RetCmd, 5,1) = '0') ;
  Result := True ;
end;

procedure TACBrECFQuattro.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
Var Dia,Mes,Ano   : String ;
    Formato, Obs1, Obs2 : String ;
begin
  if fsModelosCheque.Count = 0 then
     CarregaFormato_ChequeTXT ;

  EnviaComando('59' + '01' + LeftStr(Favorecido,65) ) ;
  EnviaComando('59' + '02' + LeftStr(Cidade,30) ) ;

  Dia        := IntToStrZero(  DayOf(Data),2) ;
  Mes        := IntToStrZero(MonthOf(Data),2) ;
  Ano        := RightStr(IntToStrZero( YearOf(Data),4),2) ;
  EnviaComando('59' + '03' + Dia + Mes + Ano ) ;

  EnviaComando('59' + '04' + IntToStrZero(Round(Valor * 100),12) ) ;

  Obs1 := copy(Observacao, 1,60) ;
  Obs2 := copy(Observacao,61,60) ;
  EnviaComando('59' + '05' + Obs1) ;
  EnviaComando('59' + '06' + Obs2) ;

  EnviaComando('59' + '07' + 'Real') ;
  EnviaComando('59' + '08' + 'Reais') ;

  Banco   := IntToStrZero(StrToIntDef(Banco,1),3) ;
  Formato := AchaModeloBanco( Banco ) ;
  AguardaImpressao := True;
  EnviaComando('59' + '09' + Banco + 'S' + Formato, 30 ) ;
end;

procedure TACBrECFQuattro.CancelaImpressaoCheque;
begin
   { Quattro n�o possui comando para cancelar a impress�o de cheques}
   raise Exception.Create('Impressora '+ModeloStr+ ' n�o possui comando para '+
                          'cancelar a impress�o de cheques. ' + sLineBreak +
                          'Por favor desligue e ligue a impressora ou insira '+
                          'um documento.');
end;

function TACBrECFQuattro.AchaModeloBanco(Banco: String): String;
Var I : Integer ;
begin
  Result := '' ;
  Banco  := Poem_Zeros(Trim(Banco),3) ;

  if fsModelosCheque.Count = 0 then
     CarregaFormato_ChequeTXT ;

  For I := 0 to fsModelosCheque.Count -1 do
  begin
     if Banco = Copy(fsModelosCheque[I],1,3) then
     begin
        Result := OnlyNumber(
                    Copy(fsModelosCheque[I],4,Length(fsModelosCheque[I])) ) ;
        Break ;
     end ;
  end ;
end;

procedure TACBrECFQuattro.CarregaFormato_ChequeTXT;
Var ArqTemp : String ;
begin
  { Verificando se o arquivo � v�lido }
  if (fsArqFormato_ChequeTXT <> '') and
     (not FileExists( fsArqFormato_ChequeTXT )) then
  begin
     {$IFNDEF CONSOLE}
       MessageDlg('Arquivo '+fsArqFormato_ChequeTXT+' n�o encontrado. '+
                  'Valores padr�es ser�o utilizados.',mtWarning,[mbOk],0);
     {$ELSE}
       writeln('Arquivo '+fsArqFormato_ChequeTXT+' n�o encontrado. '+
                  'Valores padr�es ser�o utilizados.');
     {$ENDIF}

     fsArqFormato_ChequeTXT := '' ;
  end ;

  if fsArqFormato_ChequeTXT = '' then
     ArqTemp := ExtractFilePath(
         {$IFNDEF CONSOLE} Application.ExeName {$ELSE} ParamStr(0) {$ENDIF}
                                 )+'Formato_cheque.txt'
  else
     ArqTemp := fsArqFormato_ChequeTXT ;

  fsModelosCheque.Clear ;
  { Adcionando valores default }
  if (not FileExists( ArqTemp )) then
   begin
     with fsModelosCheque do
     begin
        Add('00108080607071005') ;
        Add('00308080707061005') ;
        Add('00408080707071005') ;
        Add('00808080607061005') ;
        Add('02108080706071005') ;
        Add('02208080607071005') ;
        Add('02408080607071005') ;
        Add('02708080707061005') ;
        Add('02908120607081005') ;
        Add('03108080706071005') ;
        Add('03208070607081005') ;
        Add('03308080608071005') ;
        Add('03408070607071005') ;
        Add('03608070707061005') ;
        Add('03708080706071005') ;
        Add('03808110707061005') ;
        Add('04108070708071005') ;
        Add('04808080606061005') ;
        Add('07008080707071005') ;
        Add('10408080708091005') ;
        Add('15110070607071005') ;
        Add('15308080608061005') ;
        Add('18408080707071005') ;
        Add('20108090706061005') ;
        Add('21408080808081005') ;
        Add('23008080805091005') ;
        Add('23108080706081005') ;
        Add('23308080707061005') ;
        Add('23709090706071005') ;
        Add('24408080607071005') ;
        Add('25808100607061005') ;
        Add('26708080808061005') ;
        Add('29108060706071005') ;
        Add('29408080607071005') ;
        Add('30808080607071005') ;
        Add('32008080707081005') ;
        Add('34108100808081005') ;
        Add('34708090607081005') ;
        Add('35108080606081005') ;
        Add('35308080606061005') ;
        Add('35608110506061005') ;
        Add('35609100605071005') ;
        Add('36608090607061005') ;
        Add('36908090607061005') ;
        Add('37008070707061005') ;
        Add('37208080706081005') ;
        Add('37608100808081005') ;
        Add('38908100807081005') ;
        Add('39208070807071005') ;
        Add('39408060707091005') ;
        Add('39908080707071005') ;
        Add('40909090706061005') ;
        Add('42008070706071005') ;
        Add('42208080707071005') ;
        Add('42408100706071005') ;
        Add('47208060707081005') ;
        Add('47908100607061005') ;
        Add('48708080607071005') ;
        Add('48908070707071005') ;
        Add('49908070707071005') ;
        Add('61108080707061005') ;
        Add('74514070706071005') ;
        Add('90005050505050505') ;
     end ;
   end
  else
     fsModelosCheque.LoadFromFile( ArqTemp );
end;

function TACBrECFQuattro.GetModelosCheque: TStringList;
begin
  if fsModelosCheque.Count = 0 then
     CarregaFormato_ChequeTXT ;

  Result := fsModelosCheque;
end;

procedure TACBrECFQuattro.SetArqFormato_ChequeTXT(const Value: String);
begin
  fsArqFormato_ChequeTXT := Value;
  CarregaFormato_ChequeTXT ;
end;

procedure TACBrECFQuattro.AbreNaoFiscal(CPF_CNPJ: string);
begin
  EnviaComando('19',5);
end;

procedure TACBrECFQuattro.RegistraItemNaoFiscal(CodCNF: string;Valor: Double;
    Obs: string);
begin
  EnviaComando('07' + CodCNF + IntToStrZero(Round(Valor * 100), 12),3);
end;

procedure TACBrECFQuattro.EfetuaPagamentoNaoFiscal(CodFormaPagto: string;
   Valor: Double; Observacao: string; ImprimeVinculado: Boolean);
begin
  Observacao := '{' + copy(Observacao,1,80) ;

  EnviaComando('10' + CodFormaPagto + IntToStrZero( Round(Valor*100) ,12) +
                     Observacao , 5, 5) ;
end;

procedure TACBrECFQuattro.FechaNaoFiscal(Observacao: string);
begin
  EnviaComando('12', 10); { 12-Fecha N�o fiscla }
end;

function TACBrECFQuattro.GetNumCRZ: String;   // Maicon da Silva Evangelista
 Var RetCmd : String ;
begin
  RetCmd := EnviaComando( '56'+'01' ) ;

  if LeftStr(RetCmd, 4) = '.+01' then
     Result := IntToStrZero( StrToIntDef(copy(RetCmd,5,4),0),4) ;
end;

end.

