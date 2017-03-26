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
|* 02/07/2004:  Daniel Simoes de Almeida
|*   Inicio do desenvolvimento  baseada na Bematech
|* 06/06/2006:  Carlos do Nascimento Filho
|*   Diversos m�todos implementados... Agora a classe da Yanco est� operacional
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFYanco ;

interface
uses ACBrECFClass, ACBrBase, ACBrUtil,
     Classes ;

const STX = #02 ;
      ETX = #03 ;
       
type

{ Classe filha de TACBrECFClass com implementa�ao para Yanco }
TACBrECFYanco = class( TACBrECFClass )
 private
    { Tamanho da Resposta Esperada ao comando. Necess�rio, pois a Yanco nao
      usa um Sufixo padr�o no fim da resposta da Impressora. }
    fsNumVersao : String ;
    fsNumECF    : String ;
    fsEmPagamento : Boolean ;
    fsTotalAPagar : Double ;    
    fsSEQ       : Integer ;

    Function PreparaCmd( cmd : String ) : String ;
 protected
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumECF: String; override ;
    function GetNumSerie: String; override ;
    function GetNumVersao: String; override ;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetChequePronto: Boolean; override ;

    Function VerificaFimLeitura(var Retorno:String;
       var TempoLimite: TDateTime) : Boolean ; override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;
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
    Procedure ReducaoZ(DataHora : TDateTime) ; override ;
    Procedure AbreRelatorioGerencial ; override ;
    Procedure LinhaRelatorioGerencial( Linha : String ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : String ) ; override ;
    Procedure FechaRelatorio ; override ;

//  Procedure ComprovanteNaoFiscaisNaoVinculado( TIPO ,INDICE:string; Valor:double); override;

    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime ) ;
       override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer);
       override ;
//    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
//       var Linhas : TStringList ) ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       var Linhas : TStringList ) ; override ;


    Procedure CancelaImpressaoCheque ; override ;

    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;

    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    function AchaICMSAliquota( var AliquotaICMS : String ) :
       TACBrECFAliquota ;  override;
       
    procedure CarregaFormasPagamento ; override ;

    Procedure IdentificaOperador ( Nome: String); override;
 end ;

implementation
Uses SysUtils, Math,
    {$IFDEF COMPILER6_UP} DateUtils, StrUtils {$ELSE} ACBrD5, Windows{$ENDIF} ;

{ ----------------------------- TDJECFYanco ------------------------------ }

constructor TACBrECFYanco.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsRTS_CTS ;
  fpDevice.HardFlow  :=true;
  { Variaveis internas dessa classe }
  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsSEQ       := 0 ;

  fpModeloStr := 'Yanco' ;
  fpRFDID     := 'YA' ;
end;

destructor TACBrECFYanco.Destroy;
begin
  inherited Destroy ;
end;

procedure TACBrECFYanco.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create('Esse modelo de impressora requer'+#10+
                            'Porta Serial:  (COM1, COM2, COM3, ...)');

  fpDevice.HandShake := hsRTS_CTS ;
  inherited Ativar ; { Abre porta serial }

  fsNumVersao := '' ;
  fsNumECF    := '' ;

  try
     if EnviaComando('1FACBR') <> 'ACBR' then { 1F = Eco }
        raise EACBrECFNaoInicializado.Create(
                 'Erro inicializando a impressora '+ModeloStr );

  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFYanco.EnviaComando_ECF( cmd : String ) : String ;
Var ErroMsg : String ;
    ACK : Byte ;
    Erro : String ;
    TempoFinal : TDateTime ;
begin
  Erro    := '00' ;
  result  := '' ;
  ErroMsg := '' ;
  ACK     := 0 ;
  fpComandoEnviado   := '' ;
  fpRespostaComando  := '' ;

  { Codificando CMD de acordo com o protocolo da Yanco }
  cmd := PreparaCmd( cmd ) ;

  fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }
  fpDevice.Serial.Purge ;                   { Limpa a Porta }
  TempoFinal := IncSecond( now, min(TimeOut,5) ) ;

  while (ACK <> 20) do     { Se ACK = 20 Comando foi reconhecido }
  begin
     ACK := 0 ;

     if not TransmiteComando( cmd ) then
        continue ;

     { espera ACK chegar na Porta por 1,5 seg }
     try
        { espera ACK chegar na Porta (at� 5 segundos)  }
        while (ACK = 0) and (now < TempoFinal) do
        begin
           try
              ACK := fpDevice.Serial.RecvByte( 1500 ) ;
           except
           end ;
        end ;

        if ACK = 0 then
           raise EACBrECFSemResposta.create(
                    'Impressora '+ModeloStr+' n�o responde (ACK = 0)')
        else if ACK = 21 then    { retorno em caracter 21d=15h=NAK }
           raise EACBrECFSemResposta.create(
                 'Impressora '+ModeloStr+' n�o reconheceu o Comando')
        else if ACK <> 20 then
           raise EACBrECFSemResposta.create(
                 'Erro. Resposta da Impressora '+ModeloStr+' inv�lida') ;
     except
        on E : EACBrECFSemResposta do
         begin
           fpDevice.Serial.Purge ;

           if not DoOnMsgRetentar( E.Message +sLineBreak+sLineBreak+
              'Se o problema persistir, verifique os cabos, ou'+sLineBreak+
              'experimente desligar a impressora durante 5 seg,'+sLineBreak+
              'liga-la novamente, e repetir a opera��o...'
              ,'LerACK') then
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
  Result := copy(fpRespostaComando, 8, Length(fpRespostaComando)-10 ) ;
  if copy(fpRespostaComando,1,5) <> copy(cmd,1,5) then
     Erro := 'EE'
  else
     if Length( Result ) = 2 then
        Erro := Result ;

  { Verificando por erros em Retorno }
  if Erro = '00' then
     ErroMsg := ''
  else if erro = '10' then
     erroMsg := 'Fim de Papel'
  else if erro = '31' then
     erroMsg := 'Fun��o n�o permitida ap�s totaliza��o'
  else if erro = '32' then
     erroMsg := 'Fun��o n�o permitida sem totaliza��o'
  else if erro = '34' then
     erroMsg := 'Situa��o tribut�ria inv�lida'
  else if erro = '35' then
     erroMsg := 'Campo num�rico inv�lido'
  else if erro = '36' then
     erroMsg := 'N�meros n�o permitidos neste campo'
  else if erro = '37' then
     erroMsg := 'Mensagem inv�lida'
  else if erro = '38' then
     erroMsg := 'Tamanho M�ximo do Valor Inv�lido'
  else if erro = '39' then
     erroMsg := 'Campo deve conter, no m�nimo, um caractere'
  else if erro = '40' then
     erroMsg := 'Fun��o inexistente'
  else if erro = '41' then
     erroMsg := 'Fun��o n�o permitida sem inicio de opera��o Fiscal'
  else if erro = '42' then
     erroMsg := 'Fun��o n�o permitida sem in�cio de opera��o N�o Fiscal'
  else if erro = '43' then
     erroMsg := 'Fun��o n�o permitida durante opera��o Fiscal ou N�o Fiscal'
  else if erro = '44' then
     erroMsg := 'Fun��o n�o permitida sem in�cio do Dia'
  else if erro = '45' then
     erroMsg := 'Fun��o n�o permitida sem status de interven��o ou durante opera��o Fiscal ou N�o-Fiscal'
  else if erro = '46' then
     erroMsg := 'Fun��o n�o permitida com status de interven��o'
  else if erro = '47' then
     erroMsg := 'Fun��o n�o permitida ap�s o In�cio do Dia'
  else if erro = '48' then
     erroMsg := 'N�o s�o permitidos mais coment�rios'
  else if erro = '49' then
     erroMsg := 'N�o � permitido o Inicio do Dia ap�s Redu��o Z'
  else if erro = '50' then
     erroMsg := 'Necessita Redu��o Z'
  else if erro = '51' then
     erroMsg := 'Hora / Data inv�lida'
  else if erro = '52' then
     erroMsg := 'Data menor que a da Mem�ria Fiscal'
  else if erro = '53' then
     erroMsg := '�ltima fun��o n�o permite a execu��o deste comando'
  else if erro = '54' then
     erroMsg := 'Cupom aberto mas n�o finalizado'
  else if erro = '55' then
     erroMsg := 'Fun��o n�o permitida sem abertura de Relat�rio X ou Z'
  else if erro = '56' then
     erroMsg := '� permitido apenas quatro valida��es'
  else if erro = '57' then
     erroMsg := 'Tempo esgotado para este comando'
  else if erro = '62' then
     erroMsg := 'Mem�ria Fiscal Esgotada'
  else if erro = '63' then
     erroMsg := 'Mem�ria fiscal n�o dispon�vel ou erro de leitura/grava��o'
  else if erro = '64' then
     erroMsg := 'Equipamento necessita Interven��o T�cnica'
  else if erro = '65' then
     erroMsg := 'Palavra de uso exclusivo do firmware fiscal'
  else if erro = '67' then
     erroMsg := 'Leitura da Mem�ria Fiscal chegou ao fim'
  else if erro = '68' then
     erroMsg := 'Mem�ria Fiscal n�o est� esgotada'
  else if erro = '69' then
     erroMsg := 'Impressora de cheque n�o est� pronta'
  else if erro = '70' then
     erroMsg := 'Imposs�vel cancelar item'
  else if erro = '71' then
     erroMsg := 'Excedido limite de cupons n�o fiscais vinculados'
  else if Erro = 'EE' then
     ErroMsg := 'Retorno da Impressora inv�lido.'
  else
     ErroMsg := 'Erro C�digo ('+Erro+')' ;

  { Yanco nao tem erro de "Pouco Papel" }

  if ErroMsg <> '' then
   begin
     ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr+#10+#10+
                ErroMsg ;
     raise EACBrECFSemResposta.create(ErroMsg) ;
   end
  else
     Sleep( IntervaloAposComando ) ;  { Pequena pausa entre comandos }
end;

Function TACBrECFYanco.VerificaFimLeitura(var Retorno:String;
   var TempoLimite: TDateTime) : Boolean ;
begin
  result := // fpDevice.Serial.CTS and
           (length(Retorno) > 10) and
           (copy(  Retorno, length(fpRespostaComando)-2,1) = ETX) ;
end;

Function TACBrECFYanco.PreparaCmd( cmd : String ) : String ;
Var A, iSoma   : Integer ;
    CKS1, CKS2 : String ;
begin

  result := '' ;
  if cmd = '' then exit ;

  fsSEQ := fsSEQ + 1 ;
  if fsSEQ > 9999 then fsSEQ := 1 ;

  cmd   := STX + IntToStrZero( fsSEQ, 4 ) + cmd + ETX ;

  { Calculando a Soma dos caracteres ASC }
  iSoma := 0 ;
  For A := 1 to Length(cmd) do
     iSoma := iSoma + ord( cmd[A] ) ;

  if iSoma > 65536 then
     iSoma := iSoma mod 65536 ;

  { Calculando os d�gitos }
  CKS1 := chr( Trunc( iSoma div 256 ) ) ;
  CKS2 := chr( iSoma mod 256 ) ;

  result := cmd + CKS1 + CKS2 ;
end ;


function TACBrECFYanco.GetDataHora: TDateTime;
Var RetCmd : String ;
    OldShortDateFormat : String ;
    Pos1 : Integer ;
begin
  RetCmd := EnviaComando( '34071' );  { Data }

  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yy' ;
     result := StrToDate( StringReplace(Copy(RetCmd,1,8),'/',DateSeparator,
                          [rfReplaceAll] ) ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
  RetCmd := EnviaComando( '34070' );  { Hora }
  Pos1   := pos(':',RetCmd) ;
  result := RecodeHour(  result,StrToIntDef(copy(RetCmd,1,Pos1-1),0)) ;
  result := RecodeMinute(result,StrToIntDef(copy(RetCmd,Pos1+1,2),0)) ;
end;

function TACBrECFYanco.GetNumCupom: String;
begin
  result := EnviaComando( '34077' ) ;
end;

function TACBrECFYanco.GetNumECF: String;
begin
  if fsNumECF = '' then
  begin
     fsNumECF := EnviaComando( '34076' ) ;
  end ;

  Result := fsNumECF
end;

function TACBrECFYanco.GetNumSerie: String;
begin
  Result := copy(EnviaComando( '2D0' ), 8, 10) ;
end;

function TACBrECFYanco.GetNumVersao: String ;
begin
  if fsNumVersao = '' then
  begin
     fsNumVersao := copy(EnviaComando( '2D0' ), 18, 2) ;
  end ;

  Result := fsNumVersao ;
end;

function TACBrECFYanco.GetTotalPago: Double;
begin
  result := 0 ;   // TODO
end;

function TACBrECFYanco.GetSubTotal: Double;
var RetCmd : string;
begin
  RetCmd := EnviaComando('34072');
  Result := RoundTo( StrToFloatDef(RetCmd,0) / 100,-2) ;
end;


function TACBrECFYanco.GetEstado: TACBrECFEstado;
var RetCmd : string;
begin
 if (not fpAtivo) then
     fpEstado := estNaoInicializada
  else
   begin
     fpEstado := estDesconhecido ;

     RetCmd := EnviaComando('25') ;

     if copy(RetCmd,3,1)='3' then
         fpEstado := estRequerX
     else if copy(RetCmd,3,1)='4' then
         fpEstado := estBloqueada
     else if copy(RetCmd,3,1)='2' then
         fpEstado := estLivre;
         
     if copy(RetCmd,11,1)='2' then
         fpEstado := estVenda
     else if copy(RetCmd,11,1)='4' then
         fpEstado :=estPagamento;
   end;
   
   Result := fpEstado ;
end;

function TACBrECFYanco.GetGavetaAberta: Boolean;
begin
  result := false ;   // TODO
end;

function TACBrECFYanco.GetPoucoPapel: Boolean;
begin
  result := false ;   // TODO
end;

Procedure TACBrECFYanco.LeituraX ;
var RetCmd : string;
begin
  RetCmd := EnviaComando('25');
  
  if copy(RetCmd,3,1) = '3' then
     EnviaComando( '121',40)
  else
     EnviaComando( '241'+PadL(Operador,13),40) ;
end;

Procedure TACBrECFYanco.AbreGaveta ;
begin
  EnviaComando('26') ;
  sleep(100) ;
end;

Procedure TACBrECFYanco.ReducaoZ(DataHora: TDateTime) ;
begin
  EnviaComando( '221'+PadL(Operador,13),40) ;  
end;

Procedure TACBrECFYanco.MudaHorarioVerao ;
begin
end;

procedure TACBrECFYanco.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  if EHorarioVerao <> HorarioVerao then
     MudaHorarioVerao ;
end;

procedure TACBrECFYanco.AbreCupom ;
begin
  EnviaComando('130',40);
end;

procedure TACBrECFYanco.CancelaCupom;
var RetCmd : string;
begin
  RetCmd := EnviaComando('25');
  if copy(RetCmd,11,1) = '1' then
     EnviaComando('1E',40)
  else
     EnviaComando('1D',40);
end;

procedure TACBrECFYanco.CancelaItemVendido(NumItem: Integer);
begin
  EnviaComando('35'+ IntToStrZero( NumItem ,3)+'                    ')
end;

procedure TACBrECFYanco.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
begin
  EnviaComando('15'+CodFormaPagto+IntToStrZero( Round( Valor * 1000),13),10);

  fsEmPagamento := true ;
end;

procedure TACBrECFYanco.FechaCupom(Observacao: String);
begin
  Observacao := StringReplace(Observacao,#10,'',[rfReplaceAll]) ;
  Observacao := padl(Observacao,168);
  EnviaComando('1600'+Observacao,40);
  
  fpDevice.Serial.Purge;
end;

procedure TACBrECFYanco.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : String);
var RetCmd, Flag : string;
begin
  if DescontoAcrescimo < 0 then
     Flag := '0'
  else
     Flag := '2' ;

  DescontoAcrescimo := abs(DescontoAcrescimo) ;

  RetCmd := EnviaComando( '1B' + IntToStrZero( Round( DescontoAcrescimo * 1000),13) +
                          '0000' + Flag);

  fsTotalAPagar := RoundTo( StrToFloatDef(RetCmd,0) / 100,-2) ;
  fsEmPagamento := true ;
end;

Procedure TACBrECFYanco.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
Var QtdStr, ValorStr, DescontoStr : String ;
    Total : Double ;
    TotalStr: String;
begin
  if Qtd > 9999 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser inferior a 9999.');

  Codigo    := padL(Codigo,13) ;    { Ajustando Tamanhos }
  Descricao := PadL(Copy(Descricao, 1, 30),30) ;

  QtdStr := IntToStrZero(Round(Qtd * 1000), 7);
  ValorStr := IntToStrZero( Round(ValorUnitario * 1000 ), 9) ;
  Total:=ValorUnitario*Qtd;
  TotalStr:=IntToStrZero( Round(Total * 1000 ), 12) ;
  EnviaComando('14' + Codigo + Descricao +ValorStr+QtdStr+TotalStr+AliquotaECF+'0',12);

  { Se o desconto � maior que zero d� o comando de desconto de item }
  if ValorDescontoAcrescimo > 0 then
  begin
     if TipoDescontoAcrescimo='%' then
      begin
        DescontoStr := StringOfChar('0',12) +
                       IntToStrZero( Round(ValorDescontoAcrescimo*100), 4) ;
        if DescontoAcrescimo = 'D' then
           DescontoStr := DescontoStr + '1'
        else
           DescontoStr := DescontoStr + '3' ;
      end
     else
      begin
        DescontoStr := IntToStrZero( Round(ValorDescontoAcrescimo*1000), 12) +
                       '0000' ;
        if DescontoAcrescimo = 'D' then
           DescontoStr := DescontoStr + '0'
        else
           DescontoStr := DescontoStr + '2' ;
      end ;

     EnviaComando('18' + DescontoStr);
  end;
end;

procedure TACBrECFYanco.CarregaAliquotas;
begin
  inherited CarregaAliquotas ;   { Cria fpAliquotas }

end;

function TACBrECFYanco.AchaICMSAliquota( var AliquotaICMS: String):
   TACBrECFAliquota;
  Var AliquotaStr : String ;
begin
  AliquotaStr := '' ;
  Result      := nil ;

  case AliquotaICMS[1] of
    'F' : AliquotaStr := '14' ;
    'I' : AliquotaStr := '15' ;
    'N' : AliquotaStr := '16' ;
(*  'T' : AliquotaICMS := 'T'+padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
    CarregaAliquotas ainda n�o implementado na Yanco, use apenas Tnn *)
    
    'T' : AliquotaStr := padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
  end ;

  if AliquotaStr = '' then
     Result := inherited AchaICMSAliquota( AliquotaICMS )
  else
     AliquotaICMS := AliquotaStr ;
end;


procedure TACBrECFYanco.CarregaFormasPagamento;  { fun�ao Lenta +- 3 sec. }
Var RetCmd, StrFPG, Descricao : String ;
    Cont   : Integer ;
    FPagto : TACBrECFFormaPagamento ;
begin
  RetCmd := EnviaComando('2E');
  StrFPG := copy(retcmd,98,length(RetCmd));

  inherited CarregaFormasPagamento ;   { Cria fpFormasPagamentos }

  for Cont := 1 to 30 do
  begin
    Descricao := copy(StrFPG, (Cont * 15) - 14, 15) ;

    if Descricao <> '' then
    begin
       FPagto := TACBrECFFormaPagamento.create ;

       FPagto.Indice    := IntToStrZero(Cont,2) ;
       FPagto.Descricao := Descricao ;
       fpFormasPagamentos.Add( FPagto ) ;
    end ;
  end
end;

procedure TACBrECFYanco.CancelaImpressaoCheque;
begin
end;

function TACBrECFYanco.GetChequePronto: Boolean;
begin
  result := false ;    // TODO
end;

procedure TACBrECFYanco.AbreRelatorioGerencial;
var RetCmd : string;
begin
  RetCmd := EnviaComando('25');
  
  if copy(RetCmd,3,1) = '3' then
     EnviaComando( '120',40)
  else
     EnviaComando( '240             ',40) ;
end;

procedure TACBrECFYanco.LinhaRelatorioGerencial(Linha: String);
begin
   EnviaComando( '2A0'+padL(linha,46));
end;

procedure TACBrECFYanco.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
Var FPG : TACBrECFFormaPagamento ;
    FPGDesc : String ;
begin
  FPG := AchaFPGIndice( CodFormaPagto ) ;

  if FPG = nil then
     raise Exception.create( 'Forma de Pagamento: '+CodFormaPagto+
                             ' n�o foi cadastrada.' ) ;

  COO       := Poem_Zeros( trim(COO) ,6) ;
  FPGDesc   := padL( FPG.Descricao, 16 ) ;

   EnviaComando('132',40);
end;

procedure TACBrECFYanco.LinhaCupomVinculado(Linha: String);
begin
  EnviaComando('2B0'+padL(linha,46));
end;

procedure TACBrECFYanco.FechaRelatorio;
var RetCmd : string;
begin
  RetCmd := EnviaComando('25') ;
  
  if copy(RetCmd,11,1) = '2' then
     EnviaComando('1600'+padl('',168),40)
  else
     EnviaComando( '2C',40) ;
end;

procedure TACBrECFyanco.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal: Integer);
Var Espera : Integer ;
begin
  Espera := 10 + (ReducaoFinal - ReducaoInicial) ;
  EnviaComando('28000000000000'+IntToStrZero(ReducaoInicial,4)+IntToStrZero(ReducaoFinal  ,4)+'1',espera);
end;

procedure TACBrECFYanco.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime);
Var Espera : Integer ;
begin
  Espera := 10 + DaysBetween(DataInicial,DataFinal) ;
  EnviaComando('28'+FormatDateTime('ddmmyy',DataInicial)+FormatDateTime('ddmmyy',DataFinal)+'00000000'+'0',espera);
end;

procedure TACBrECFYanco.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas: TStringList);
Var Espera : Integer ;
begin
  Espera := Trunc(TimeOut + ((ReducaoFinal - ReducaoInicial)/5) ) ;
  Linhas.Clear ;
  Linhas.Text := EnviaComando('2F', Espera ) ;
end;

(*
Procedure TACBrECFYanco.ComprovanteNaoFiscaisNaoVinculado(tipo,indice:string; Valor:double);
begin
 EnviaComando('29'+padR(tipo,2)+indice+IntToStrZero( Round( Valor * 1000),13),20);
end;
*)
procedure TACBrECFYanco.IdentificaOperador(Nome: String);
begin
  EnviaComando('11'+PadL(Nome,13)) ;
end;

end.


