{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Eduardo Durieux Lopes                  }
{                                                                              }
{ Colaboradores nesse arquivo:  Daniel Simoes de Almeida                       }
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
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrECFEpson ;

interface
uses ACBrECFClass, ACBrUtil, ACBrCHQClass,
     Classes
     {$IFNDEF CONSOLE}
       {$IFDEF VisualCLX}, QDialogs, QControls, QForms {$ENDIF}
       {$IFDEF VCL}, Dialogs, Controls, Forms {$ENDIF}
     {$ENDIF} ;

const ETX = #03 ;

type

{ Classe filha de TACBrECFClass com implementaçao para Bematech }
TACBrECFEpson = class( TACBrECFClass )
 private
    SEQ : Integer;

    fsACK : Integer ; { Status da Bematech }

    FbCupomAberto       : Boolean;

    FsPacoteRespostaIncompleto : String;

    FsStatusPrinter     : String;
    FsStatusFiscal      : String;
    FsRetornoDevolvido  : String;

    { Tamanho da Resposta Esperada ao comando. Necessário, pois a Bematech nao
      usa um Sufixo padrão no fim da resposta da Impressora. }
    fsBytesResp : Integer ;
    fsNumVersao : String ;
    fsNumECF    : String ;
    fsNumLoja   : String ;
    fsNumCRO    : String ;
    fsArredonda : Char ;
    fsTotalPago : Double ;

    fsNumCRZ    : String ;
    FGtAtual    : Currency;
    FGTInicial  : Currency;
    //F : Currency;
    FDocAberto  : Boolean;
    FVendaBrutaUltimaReducaoZ: Currency;

    FsSequenciaEnviada     : String;
    FsNucleoComandoEnviado : String;

    fsModelosCheque                : TACBrCHQModelos ;
    fUmaStringListLinhasVinculado  : TStringList;
    FumaStringListCamposRetornados : TStringList;


    //******************************************************
    // Novas rotinas
    //******************************************************

    // Nesta lista ficam os parametros que foram passados para o comando
    FumaStringListParametros          : TStringList;
    // ESta stringlist contém os mesmos parametros da anterior, porém estão com
    // os caracteres de controle identificados. Esta será utilizada para
    // efetivamente montar o comando
    FumaStringListParametrosProntos   : TStringList;

    FumaStringListCamposExtras        : TStringList;

    Procedure PreparaParametros;

    Function CaracterReservado(psCaracter : Char)         : boolean;
    Function MontaFrameDeDados(psComandoEntrada : String) : String;
    Function Coloca27(psValorEntrada : String)            : String;
    Function PreparaCmd( cmd : String )                   : String ;
    Function CheckSum(psComando : String)                 : String;

    Procedure SeparaCamposRetorno(psValorEntrada : String);
    // InterpretaErros recebe o retorno do ecf e retira os erros do Controle inicial
    Function InterpretaCampoRetorno(psValorEntrada : String) : String;
    // InterpretaRetorno, retira do retorno do ecf, os parâmetros que porventura
    // tenham vindo junto
    Procedure InterpretaRetorno(psValorEntrada : String);
    Procedure InterpretaStatusFiscal;

    procedure setFsNucleoComandoEnviado(const Value: String);
    procedure setFsSequenciaEnviada(const Value: String);

 protected
    Property sSequenciaEnviada     : String read FsSequenciaEnviada write
      setFsSequenciaEnviada;
    Property sNucleoComandoEnviado : String read FsNucleoComandoEnviado write
      setFsNucleoComandoEnviado;

    Property sStatusPrinter     : String read FsStatusPrinter;
    Property sStatusFiscal      : String read FsStatusFiscal;
    Property sRetornoDevolvido  : String read FsRetornoDevolvido;

    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumECF: String; override ;
    function GetNumCRO: String; override ;
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

    function GetModeloStr: String; override ;
    function GetCNPJ: String; override;
    function GetNumCRZ: String; override ;
    function GetGTInicial: Currency; override;
    function GetGTAtual: Currency; override;
    function GetVendaBrutaUltimaReducaoZ: Currency; override;
    function GetDocAberto: Boolean; override;
    function GetVendaBruta: Currency; override;
    function GetDataMovimento: TDateTime; override;
    function GetEnderecoProprietario: String; override;
    function GetRazaoSocialProprietario: String; override;

    Function VerificaFimLeitura(Retorno : String;
                                var pdtTempoLimite : TDateTime) : Boolean ; override; //overload; override;
    Function VerificaFimImpressao : Boolean ; override ;

    Procedure AcionaGuilhotina;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar; override ;

    Property ACK   : Integer read fsACK ;

    property ModelosCheque : TACBrCHQModelos read fsModelosCheque
       write fsModelosCheque ;

    Property BytesResp : Integer read fsBytesResp write fsBytesResp ;
    Function EnviaComando( cmd : String ) : String ; override ;

    Procedure AbreCupom( CPF_CNPJ : String = '') ; override ;

    // Este eh o vendeItem que sempre acaba sendo executado. onde o desconto esta
    // no formato string e em valor
    Procedure VendeItem( Codigo, Descricao : String; AliquotaICMS : String;
       Qtd : Double ; ValorUnitario : Double; psValorDescontoPorItem,
       psValorAcrescimoUnitario : String; Unidade : String = '') ; overload; override ;

    // Este vende item recebe o desconto em percentual calcula qual sera o valor
    // do desconto e chama o outro vendeItem onde o parametro eh o desconto em
    // valor e no formato String.
    Procedure VendeItem( Codigo, Descricao : String; AliquotaICMS : String;
       Qtd : Double ; ValorUnitario : Double; DescontoPorc : Double = 0;
       AcrescimoPorc : Double = 0;Unidade : String = '') ; overload; override ;

    //Este vendeItem recebe o desconto em valor transforma para string e chama o
    // vende item que passa o desconto por String
    Procedure VendeItem( Codigo, Descricao : String; AliquotaICMS : String;
       Unidade : String; Qtd : Double ; ValorUnitario : Double;
       ValorDesconto : Double = 0; ValorAcrescimo : Double = 0) ; overload; override ;

    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : String  = '') ; override ;
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : String = ''; ImprimeVinculado : Boolean = false) ;
       override ;
    Procedure FechaCupom( Observacao : String = '') ; override ;
    Procedure CancelaCupom ; override ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; override ;

    Procedure LeituraX ; override ;

    Procedure LeituraXSerial(var psRetorno : String); override ;

    Procedure ReducaoZ(DataHora : TDateTime = 0 ) ; override ;
    Procedure AbreRelatorioGerencial ; override ;
    Procedure LinhaRelatorioGerencial( Linha : String; pbImprimir : Boolean = True) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : String; pbImprimir : Boolean = True ) ; override ;
    Procedure FechaRelatorio ; override ;

    Procedure EstornoComprovanteCreditoDebito(pcdFinalizador : integer;
                                              pnValor : Currency); override;

    //Procedure EmiteLinhasDaStingList(psLinha : String; psCMD : CHAR);

    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;

    Procedure MudaHorarioVerao  ; overload ; override ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; override ;
    Procedure MudaArredondamento( Arredondar : Boolean ) ; override ;
    Procedure CorrigeEstadoErro ; override ;
    Procedure ImpactoAgulhas( NivelForca : Integer = 2) ; override ;
    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime ) ;
       overload ; override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer);
       overload ; override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList ) ; overload ; override ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       var Linhas : TStringList ) ; overload ; override ;

    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;

    procedure CarregaFormasPagamento ; override ;
    function AchaFPGDescricao( Descricao : String ) : TACBrECFFormaPagamento ;
       override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;

    Procedure CorrigeVelocidade; override;

 end ;

implementation
Uses ACBrBase,
     SysUtils,
   {$IFDEF Delphi6_UP} DateUtils, StrUtils, {$ELSE} ACBrD5, Windows,{$ENDIF}
     Math ;

{ ----------------------------- TACBrECFBematech ------------------------------ }

constructor TACBrECFEpson.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.Baud      := 38400;
  fpDevice.Parity    := pNone;
  fpDevice.Stop      := s1;
  fpDevice.Data      := 8;
  fpDevice.HandShake := hsNenhum;

  FbCupomAberto := False;

  Randomize;
  SEQ := RandomRange(129, 255);

  { Variaveis internas dessa classe }
  fsACK       := 0 ;

  fsBytesResp := 0 ;

  fsTotalPago := 0 ;
  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumLoja   := '' ;
  fsNumCRO    := '' ;
  fsArredonda := ' ';
  fpModeloStr := 'Epson Série 81' ;

  fsNumCRZ    := '' ;

  fsModelosCheque := TACBrCHQModelos.create( true );

  FumaStringListLinhasVinculado  := TStringList.Create;
  FumaStringListCamposRetornados := TStringList.Create;

  FumaStringListParametros        := TStringList.Create;
  FumaStringListParametrosProntos := TStringList.Create;
  FumaStringListCamposExtras      := TStringList.Create;
end;

destructor TACBrECFEpson.Destroy;
begin
  fsModelosCheque.Free ;

  FreeAndNil(FumaStringListCamposRetornados);
  FreeAndNil(FumaStringListParametros);
  FreeAndNil(FumaStringListParametrosProntos);
  FreeAndNil(FumaStringListCamposExtras);

  inherited Destroy ;
end;

procedure TACBrECFEpson.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create('A impressora: '+ModeloStr+' requer'+sLineBreak+
                            'Porta Serial:  (COM1, COM2, COM3, ...)');

  inherited Ativar ;

  fsNumVersao := '' ;
  fsNumECF    := '' ;
  fsNumLoja   := '' ;
  fsNumCRO    := '' ;
  fpMFD       := True;
  fpTermica   := True;
  fsArredonda := ' ';

  try
     // Testando a comunicaçao com a porta
     FumaStringListCamposExtras.Add(#0);
     FumaStringListCamposExtras.Add(#0);

     EnviaComando(#00 + #01 , 10) ;

     if (fsACK <> 6) then
        raise EACBrECFNaoInicializado.Create('Erro inicializando a impressora ' +
                                             ModeloStr);

  except
     Desativar;

     raise;
  end ;
end;


Function TACBrECFEpson.EnviaComando( cmd : String ) : String ;
Var
    ErroMsg : String ;
    B : Byte ;
    PediuStatus : Boolean ;
    TempoFinal  : TDateTime ;

    sPrimeiroByte       : Char;
    sSequenciaDevolvida : Char;
    sRetorno            : String;
    sChkSumRecebido     : String;
    sParteSemChecksum   : String;
    sByteRecebido       : Integer;
    iIndice             : Integer;

    sCaracterEnviar     : Integer;
begin
  fsACK   := 0  ;

  Result  := '' ;
  ErroMsg := '' ;

  fpComandoEnviado   := '' ;
  fpRespostaComando  := '' ;
  AguardandoResposta := true ;

  FumaStringListCamposRetornados.Clear;

  PediuStatus := ( cmd = #00 + #01) ; { quando pede Status nao deve disparar
                            exceçao com erros "Pouco Papel" ou "Cupom Aberto" }
  try
     if (not fpDevice.Ativo) then
        raise EACBrECFNaoInicializado.create(
                 'Componente ACBrECF não está Ativo');

     // Codificando CMD de acordo com o protocolo da Epson
     cmd := Coloca27(cmd);

     if FumaStringListParametros.Count > 0 then
     PreparaParametros;

     // Monta a parte "baixo nível" do protocolo
     cmd := PreparaCmd( cmd ) ;

     VerificaEmLinha ;

     fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }
     //TempoFinal := IncSecond( now, IfThen(PediuStatus, TimeOut, min(TimeOut,5)) ) ;
     TempoFinal := IncSecond( now, TimeOut);

     while (fsACK <> 6) do     // Se ACK = 6 Comando foi reconhecido
     begin
        fsACK := 0 ;
        fpDevice.Serial.Purge ;                   //Limpa a Porta

        FsPacoteRespostaIncompleto := '';

        if not TransmiteComando( cmd ) then
          continue ;

         try
           // espera ACK chegar na Porta (até o TimeOut segundos)
           while (fsACK = 0) and (now < TempoFinal) do begin
             try

               fsACK := fpDevice.Serial.RecvByte( 1500 ) ;
             except

             end ;
           end ;

           if fsACK = 0 then
              raise EACBrECFSemResposta.create(
                       'Impressora '+ModeloStr+' não responde (ACK = 0)')
           else if fsACK = 21 then    // retorno em caracter 21d=15h=NAK
              raise EACBrECFSemResposta.create(
                    'Impressora '+ModeloStr+' não reconheceu o Comando'+
                    sLineBreak+' (ACK = 21)')
           else if fsACK <> 6 then
               raise EACBrECFSemResposta.create(
                    'Erro. Resposta da Impressora '+ModeloStr+' inválida'+
                    sLineBreak+' (ACK = '+IntToStr(fsACK)+')') ;
        except
           on E : EACBrECFSemResposta do
            begin
              fpDevice.Serial.Purge ;

              if not DoOnMsgRetentar( E.Message +sLineBreak+sLineBreak+
                 'Se o problema persistir, verifique os cabos, ou'+sLineBreak+
                 'experimente desligar a impressora durante 5 seg,'+sLineBreak+
                 'liga-la novamente, e repetir a operação...'
                 , 'LerACK') then
                 raise ;
            end ;
           else
              raise ;
        end ;
     end ;

     fpComandoEnviado := cmd ;

     // Chama Rotina da Classe mãe TACBrClass para ler Resposta. Se houver
     // falha na leitura LeResposta dispara Exceçao
     LeResposta;

     (*sPrimeiroByte        := fpRespostaComando[1];
     sSequenciaDevolvida  := fpRespostaComando[2];

     sChkSumRecebido      := Copy(fpRespostaComando,
                                  length(fpRespostaComando) - 3,
                                  4);
     sParteSemChecksum    := Copy(fpRespostaComando, 1,
                                  length(fpRespostaComando) - 4);
       *)
     Result := fpRespostaComando;
     InterpretaRetorno(fpRespostaComando);
     ErroMsg := InterpretaCampoRetorno(sRetornoDevolvido);
     InterpretaStatusFiscal;

     if ErroMsg <> '' then
      begin
        ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr+sLineBreak+
                   sLineBreak+ErroMsg ;
              raise EACBrECFSemResposta.create(ErroMsg) ;
      end;

  finally
    BytesResp := 0 ;
      AguardandoResposta := false ;
  end ;

end;

function TACBrECFEpson.VerificaFimLeitura(Retorno:String; var pdtTempoLimite : TDateTime) : Boolean;
var
  sChkSumRecebido   : String;
  sParteSemCheckSum : String;

  iPosicaoCaracter  : Integer;
  iAchouCaracter27   : Integer;
begin
  if fpRespostaComando = '' then begin
    Result := False;
  end else begin
    if FsPacoteRespostaIncompleto <> '' then
      fpRespostaComando := FsPacoteRespostaIncompleto + fpRespostaComando;

    FsPacoteRespostaIncompleto := '';

    While Pos(#2 + #128 + #3 + '0085', fpRespostaComando) > 0 do begin
      fpRespostaComando := Copy(fpRespostaComando, 8, Length(fpRespostaComando) - 7);
      pdtTempoLimite := IncSecond(now, TimeOut);
    end;

    if length(fpRespostaComando) > 7 then begin
      sChkSumRecebido      := Copy(fpRespostaComando,
                                  length(fpRespostaComando) - 3,
                                  4);
      sParteSemChecksum    := Copy(fpRespostaComando, 1,
                                   length(fpRespostaComando) - 4);

      iPosicaoCaracter := length(fpRespostaComando) - 4;
      iAchouCaracter27  := 0;

      if fpRespostaComando[iPosicaoCaracter] = #3 then begin

        While (iPosicaoCaracter > 2) AND
              (fpRespostaComando[iPosicaoCaracter - 1] = #27) do begin
          DEC(iPosicaoCaracter);
          INC(iAchouCaracter27);
        end;

        Result := (
                  (fpRespostaComando[1] = #2) AND
                  (sSequenciaEnviada = fpRespostaComando[2]) AND
                  (iAchouCaracter27 mod 2 = 0) AND
                  (sChkSumRecebido = CheckSum(sParteSemCheckSum))
                  );

        // neste caso se result false pacote veio completo mas com erro
        // limpar o pacote
        if Result then begin
          fpDevice.Serial.SendByte(fsACK);
        end else begin
          fpDevice.Serial.SendByte(21);
        end;                       

      end else begin
        Result := False;   // comando nao completo pois 5 ultimo nao eh 3
        FsPacoteRespostaIncompleto := fpRespostaComando;
      end;
    end else begin
      Result := False; // cmd nao compoleto pois tamanho minimo nao foi atingido
      FsPacoteRespostaIncompleto := fpRespostaComando;
    end;
  end;

end;

function TACBrECFEpson.VerificaFimImpressao: Boolean;
begin
(*  sSequenciaDevolvida  := fpRespostaComando[2];
  Result := (ORD(sSequenciaDevolvida) <> 128);
*)
end;

Function TACBrECFEpson.PreparaCmd( cmd : String ) : String ;  // Adaptada do manual da Epson //
Var
  ETX, STX      : String ;

  ComandoPronto : String;
  iContador     : integer;

  sHexa : String;
begin
  result := '' ;
  if cmd = '' then exit ;

  STX    := #2 ;
  ETX    := #3;
  SEQ    := SEQ + 1;

  if SEQ = 256 then
    SEQ := 129;

  cmd := MontaFrameDeDados(cmd);

  ComandoPronto := STX + CHR(SEQ) + cmd + ETX;

  sSequenciaEnviada := CHR(SEQ);

  Result := ComandoPronto + CheckSum(ComandoPronto);
end ;

function TACBrECFEpson.GetDataHora: TDateTime;
Var
  sRetornoComando : String ;
  sRetorno        : String ;
  sHora           : String ;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  EnviaComando( #05 + #02, 5) ;

  sRetorno := FumaStringListCamposRetornados.Strings[0];
  sHora    := FumaStringListCamposRetornados.Strings[1];

  result := StrToDate(copy(sRetorno, 1,2) + DateSeparator +
                      copy(sRetorno, 3,2) + DateSeparator +
                      copy(sRetorno, 5,4)) ;

  result := RecodeHour(  result,StrToInt(copy(sHora, 1,2))) ;
  result := RecodeMinute(result,StrToInt(copy(sHora, 3,2))) ;
  result := RecodeSecond(result,StrToInt(copy(sHora,5,4))) ;
end;

function TACBrECFEpson.GetNumCupom: String;
var
  sRetornoComando : String;       // usar rotina obter contadores
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  EnviaComando( #09 + #07, 5) ;

  Result := FumaStringListCamposRetornados.Strings[0];
end;

function TACBrECFEpson.GetNumCRO: String;
var
  sRetorno : String;
begin
  if fsNumCRO = '' then
  begin
    FumaStringListCamposExtras.Add(#0);
    FumaStringListCamposExtras.Add(#0);

    EnviaComando( #09 + #07, 5) ;

    FsNumCRO := FumaStringListCamposRetornados.Strings[2];
  end ;

  Result := fsNumCRO ;
end;

function TACBrECFEpson.GetNumLoja: String;
var
  sRetornoComando : String;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  EnviaComando( #05 + #07, 5) ;

  Result := FumaStringListCamposRetornados.Strings[9];
end;

function TACBrECFEpson.GetNumECF: String;
var
  sRetornoComando : String;
begin
  if FsNumECF = '' then begin
    FumaStringListCamposExtras.Add(#0);
    FumaStringListCamposExtras.Add(#0);

    EnviaComando( #05 + #07, 5) ;

    FsNumECF := FumaStringListCamposRetornados.Strings[8];
  end;
  Result := fsNumECF ;
end;

function TACBrECFEpson.GetNumSerie: String;
var
  sRetornoComando : String;

begin
    FumaStringListCamposExtras.Add(#0);
    FumaStringListCamposExtras.Add(#0);

    EnviaComando( #04 + #02, 5) ;

    Result := FumaStringListCamposRetornados.Strings[0];
end;

function TACBrECFEpson.GetNumVersao: String ;
var
  sRetornoComando    : String ;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  EnviaComando( #04 + #02, 5) ;

  fsNumVersao := FumaStringListCamposRetornados.Strings[5];

  Result := fsNumVersao ;
end;

function TACBrECFEpson.GetTotalPago: Double;
begin
  //Result := StrToInt( BcdToAsc( EnviaComando( #35 + #22 ))) / 100 ;
  //Result := RoundTo( Result, -2) ;
  Result := 0;
end;

function TACBrECFEpson.GetSubTotal: Double;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);
  EnviaComando(#10 + #03, 10);

  Result := StrToFloat(FumaStringListCamposRetornados.Strings[0]) / 100;

  Result := RoundTo(Result * 100, -2) / 100;
end;

function TACBrECFEpson.GetEstado: TACBrECFEstado;
Var
  RetCmd, sRetorno  : String ;
  iRetorno : Integer;
begin
  if (not fpAtivo) then
    fpEstado := estNaoInicializada
  else begin
    FumaStringListCamposExtras.Add(#0);
    FumaStringListCamposExtras.Add(#0);

    AguardaImpressao := False;

    EnviaComando( #08 + #16, 10);

    iRetorno := StrToInt(FumaStringListCamposRetornados.Strings[0]);

    Case iRetorno of

      1 : if FbCupomAberto then begin
            fpEstado := estVenda;
          end else begin
            fpEstado := estLivre;
          end;

      2 : fpEstado := estBloqueada;

      3 : fpEstado := estRequerX;

      4 : fpEstado := estRequerZ;

    end;
   end;

   Result := fpEstado;
end;

function TACBrECFEpson.GetGavetaAberta: Boolean;
Var B : Byte ;
    Resp : String ;
begin
  (*BytesResp := 1 ;
  Resp := EnviaComando( #23 ) ;
  B := ord( Resp[1] ) ;
  Result := (B <> 0) ;*)
end;

function TACBrECFEpson.GetPoucoPapel: Boolean;
begin
  (*Result := TestBit(ORD(FsStatusFiscal[2]), 1) AND
            TestBit(ORD(FsStatusFiscal[0]), 1);
  *)
end;

function TACBrECFEpson.GetHorarioVerao: Boolean;
Var RetCmd : String ;
    B : Byte ;
begin
   BytesResp := 1 ;
   RetCmd    := EnviaComando( #35 + #17 ) ;
   try B := ord( RetCmd[1] ) except B := 0 end ;

   Result := TestBit( B ,2)
end;

function TACBrECFEpson.GetArredonda: Boolean;
Var RetCmd : String ;
    B : Byte ;
begin
  //FumaStringListCamposExtras.Add(#0);
  //FumaStringListCamposExtras.Add(#0);

  //sRetorno := EnviaComando( #09 + #07, 5) ;

  //InterpretaRetorno(sRetorno);

  //fsNumCRZ := FumaStringListCamposRetornados.Strings[1];

  Result := False;

(*  if fsArredonda = ' ' then
  begin
     BytesResp := 1 ;
     RetCmd    := EnviaComando( #35 + #28 ) ;
     try B := ord( RetCmd[1] ) except B := 0 end ;

     if (B <> 0) then
        fsArredonda := 'S'
     else
        fsArredonda := 'N' ;
  end ;

  Result := (fsArredonda = 'S') ;
*)
end;

Procedure TACBrECFEpson.LeituraX ;
var
  sComando : String;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  if fpEstado = estRequerx then begin
    EnviaComando( #08 + #05, 2) ;
  end else begin
    EnviaComando( #08 + #02, 2) ;
  end;
end;

Procedure TACBrECFEpson.AbreGaveta ;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  EnviaComando( #07 + #07, 2);
end;

Procedure TACBrECFEpson.ReducaoZ(DataHora: TDateTime) ;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  FumaStringListParametros.Add('');
  FumaStringListParametros.Add('');

  EnviaComando( #08 + #01, 2);
end;

Procedure TACBrECFEpson.MudaHorarioVerao ;
begin
  //BytesResp := 0 ;
  //EnviaComando( #18 ) ;
end;

procedure TACBrECFEpson.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  if EHorarioVerao <> HorarioVerao then
     MudaHorarioVerao ;
end;

procedure TACBrECFEpson.MudaArredondamento(Arredondar: Boolean);
begin
  //BytesResp := 0 ;
  //EnviaComando( #39 + chr( IfThen(Arredondar,1,0) ) ) ;
end;

procedure TACBrECFEpson.AbreCupom(CPF_CNPJ: String);
Var
  sRetornoComando : String ;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  FumaStringListParametros.Add('');
  FumaStringListParametros.Add('');

  sRetornoComando := EnviaComando( #10 + #01, 5) ;

  fsTotalPago := 0;
end;

procedure TACBrECFEpson.CancelaCupom;
var
  sRetornoComando : String;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#8);

  FumaStringListParametros.Add('');

  sRetornoComando := EnviaComando(#10 + #24, 2);
end;

procedure TACBrECFEpson.CancelaItemVendido(NumItem: Integer);
  var
  sRetornoComando : String;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#4);

  FumaStringListParametros.Add(IntToStr(NumItem));

  sRetornoComando := EnviaComando(#10 + #24, 2);
end;

procedure TACBrECFEpson.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
var
  sValor : String;
begin
  try
    inherited EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado);

    AguardaImpressao := False;


    sValor := IntToStrZero(Round(Valor * 100) ,13);

    FumaStringListCamposExtras.Add(#0);
    FumaStringListCamposExtras.Add(#0);

    FumaStringListParametros.Add(CodFormaPagto);



    FumaStringListParametros.Add(sValor);
    FumaStringListParametros.Add('');
    FumaStringListParametros.Add('');

    EnviaComando( #10 + #05, 2);

    (* + CodFormaPagto +
                  IntToStrZero( Round(Valor * 100), 14) +
                  Observacao ) ; *)
    fsTotalPago := fsTotalPago + RoundTo(Valor, -2) ;
  except
    if (Valor > Subtotal) AND (FGTInicial = FGTAtual) then begin
      raise Exception.Create('Finalizadora não aceita pelo ECF. A causa mais ' +
                             'provável para este erro é falta de troco.' +
                             'Favor efetuar função de suprimento');

    end;
  end;
end;

procedure TACBrECFEpson.FechaCupom(Observacao: String);
var
  sRetorno                      : String;
  FumaStringListDadosConsumidor : TStringList;
  //iContadorListaDados           : Integer;
begin
  AguardaImpressao := False;

  (*if Trim(Observacao) <> '' then begin
    FumaStringListCamposExtras.Add(#0);
    FumaStringListCamposExtras.Add(#2);

    FumaStringListDadosConsumidor := TStringList.Create;
    While Pos(#10 + #13, Observacao) > 0 do begin
      FumaStringListDadosConsumidor.Add(Copy(Observacao, 1, Pos(#10 + #13, Observacao)));
      Observacao := Copy(Observacao,
                         Pos(#10 + #13, Observacao) + 2,
                         Length(Observacao) - Pos(#10 + #13, Observacao) + 2
                        );
    end;

    if Trim(Observacao) <> '' then begin
      FumaStringListDadosConsumidor.Add(Observacao);
    end;

    For iContadorListaDados := 0 to FumaStringListDadosConsumidor.Count - 1 do begin
      FumaStringListParametros.Add(FumaStringListDadosConsumidor.Strings[iContadorListaDados]);
    end;

    sRetorno := EnviaComando(#10 + #32, 2);
  end;*)

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);
  EnviaComando(#10 + #06, 2);

  FsTotalPago := 0 ;

  AcionaGuilhotina;
end;

procedure TACBrECFEpson.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : String);
var
  sRetornoComando : String;
  sValor   : String;
begin
  if DescontoAcrescimo <> 0 then begin
    sValor := OnlyNumber(Format('%8.2f', [DescontoAcrescimo]));

    FumaStringListCamposExtras.Add(#0);

    if DescontoAcrescimo < 0 then begin
      FumaStringListCamposExtras.Add(#6);
    end else begin
      FumaStringListCamposExtras.Add(#7);
    end;

    FumaStringListParametros.Add(sValor);
    sRetornoComando := EnviaComando( #10 + #04, 2) ;
  end;
end;

procedure TACBrECFEpson.VendeItem(Codigo, Descricao: String;
  AliquotaICMS : String; Qtd: Double; ValorUnitario: Double;
  DescontoPorc, AcrescimoPorc: Double; Unidade: String);

Var
  sValorDescontoUnitario  : String;
  sValorAcrescimoUnitario : String;
begin
  if fpMFD then begin
   sValorDescontoUnitario  := IntToStrZero(Round(ValorUnitario * DescontoPorc), 10);
   sValorAcrescimoUnitario := IntToStrZero(Round(ValorUnitario * AcrescimoPorc), 10);
  end else begin
    sValorDescontoUnitario  := IntToStrZero(Round(ValorUnitario * DescontoPorc * 100), 4) ;
    sValorAcrescimoUnitario := IntToStrZero(Round(ValorUnitario * AcrescimoPorc * 100), 4) ;
  end ;

  VendeItem(Codigo,
            Descricao,
            AliquotaICMS,
            Qtd,
            ValorUnitario,
            sValorDescontoUnitario,
            sValorAcrescimoUnitario,
            Unidade
           );
end;

procedure TACBrECFEpson.CarregaAliquotas;
Var
  sRetornoComando : String;
  sRetorno1       : String;
  sRetorno2       : String;
  sTipo           : String;
  nValorAliq      : Double;

  iIndiceListaRetornos : integer;
  iAliquotas           : integer;
  Aliquota             : TACBrECFAliquota;
begin
  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  sRetornoComando := EnviaComando(#05 + #66, 2) ;

  iAliquotas := Trunc((FumaStringListCamposRetornados.Count + 1) / 3);

  For iIndiceListaRetornos := 0 to (iAliquotas - 1) do begin
    sTipo      := FumaStringListCamposRetornados.Strings[((iIndiceListaRetornos + 1) * 3) - 3];
    nValorAliq := StrToFloat(FumaStringListCamposRetornados.Strings[((iIndiceListaRetornos + 1) * 3) - 2]);

    if nValorAliq > 0 then
    begin
       Aliquota := TACBrECFAliquota.create;

       Aliquota.Indice   := 'T' + CHAR(iIndiceListaRetornos + 97);
       Aliquota.Aliquota := nValorAliq;

       Aliquota.Tipo     := sTipo[1];

       fpAliquotas.Add(Aliquota);
    end ;
  end;
end;

procedure TACBrECFEpson.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
Var
  ValStr            : String ;
  sRetornoComando   : String ;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  if UpperCase(Tipo) = 'T' then
    FumaStringListCamposExtras.Add(#0)
  else
    FumaStringListCamposExtras.Add(#1);

  ValStr := IntToStrZero(Round(Aliquota * 100) ,4);
  FumaStringListParametros.Add(ValStr);
  sRetornoComando := EnviaComando( #05 + #64, 5) ;

  CarregaAliquotas ;
end;


procedure TACBrECFEpson.CarregaFormasPagamento;  { funçao Lenta +- 3 sec. }
Var
  iContadorPagamentosCadastrados          : Integer;
  FPagto                                  : TACBrECFFormaPagamento;
  sRetorno                                : String;
  sRetornoComando, sFormaPgtoEncontrado   : String;
  sComando                                : String ;
  sPermiteVinculado                       : String;
begin
  inherited CarregaFormasPagamento ;   // Cria fpFormasPagamentos

  For iContadorPagamentosCadastrados := 1 to 20 do begin

    FumaStringListCamposExtras.Add(#0);
    FumaStringListCamposExtras.Add(#0);
    FumaStringListParametros.Add(intToStr(iContadorPagamentosCadastrados));

    try
      sRetornoComando := EnviaComando(#05 + #13, 5) ;
    except

      Exit;
    end;

    //InterpretaRetorno(sRetornoComando);

    if FumaStringListCamposRetornados.Count < 1 then
      break;

    sFormaPgtoEncontrado  := FumaStringListCamposRetornados.Strings[0];
    sPermiteVinculado     := FumaStringListCamposRetornados.Strings[1];

    FPagto := TACBrECFFormaPagamento.create;

    FPagto.Indice           := IntToStrZero(iContadorPagamentosCadastrados, 2);
    FPagto.Descricao        := sFormaPgtoEncontrado;
    FPagto.PermiteVinculado := UpperCase(sPermiteVinculado) = 'S';

    fpFormasPagamentos.Add(FPagto);
  end;

(*For Cont := 1 to 16 do
  begin
    Descr := trim( copy( StrRet, (Cont * 16) - 15, 16) ) ;
    if Descr <> '' then
    begin
       FPagto := TACBrECFFormaPagamento.create ;

       FPagto.Indice    := IntToStrZero(Cont,2) ;
       FPagto.Descricao := Descr ;
       FPagto.PermiteVinculado := (Cont > 1); {Apenas 1-Dinheiro nao permite}

       fpFormasPagamentos.Add( FPagto ) ;
    end ;
  end ;*)
end;

function TACBrECFEpson.AchaFPGDescricao( Descricao: String):
  TACBrECFFormaPagamento;
begin
  { A Bematech permite programas as Formas de Pagamento dinâmicamente.
    Na MP20 A cada Reduçao Z as Formas programadas dinâmicamente sao zeradas.
    O comando abaixo tenta programar novamente a FPG para garantir que ela
    exista... Caso ela já exista a Bematech retorna o INDICE atual...
    - Isso é necessario pois pode haver situacoes que as Formas de Pagamento
      que constam na memoria do ACBr em "fpFormasPagamentos" já não existem mais
      pois uma Reducao Z foi impressa automática pelo ECF }
  { Nas novas MP25 e MPTH as Formas de Pagamento, nao são zeradas na Reducao Z,
    por isso não será utilizado a programação dinâmica }
  if (not fpMFD) then
     ProgramaFormaPagamento( Descricao ) ;

  result := inherited AchaFPGDescricao(Descricao) ;
end;

procedure TACBrECFEpson.ProgramaFormaPagamento( var Descricao: String;
  PermiteVinculado : Boolean; Posicao : String) ;
Var
  StrRet          : String;
  sRetornoComando : String;
  FPagto          : TACBrECFFormaPagamento;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);

  if PermiteVinculado then
    FumaStringListCamposExtras.Add(#1)
  else
    FumaStringListCamposExtras.Add(#0);

  Descricao := Copy(Descricao, 1, 15);

  FumaStringListParametros.Add(Posicao);
  FumaStringListParametros.Add(Descricao);

  sRetornoComando := EnviaComando( #05 + #12, 2) ;

  CarregaFormasPagamento;
end;

procedure TACBrECFEpson.CarregaComprovantesNaoFiscais;
Var StrRet : String ;
    Cont   : Integer ;
    CNF    : TACBrECFComprovanteNaoFiscal ;
    Descr  : String ;
begin
  inherited CarregaComprovantesNaoFiscais ;

  (*
  Cont      := 1 ;
  BytesResp := 1550 ;
  StrRet    := EnviaComando( #35 + #33, 5 ) ;

  while Length(StrRet) > 0 do
  begin
    Descr  := trim( copy(StrRet, 13,19) ) ;

    if Descr <> '' then
    begin
       CNF := TACBrECFComprovanteNaoFiscal.create ;

       CNF.Indice    := IntToStrZero(Cont,2) ;
       CNF.Descricao := Descr ;

       fpComprovantesNaoFiscais.Add( CNF ) ;
    end ;

    StrRet := copy(StrRet, 32, Length(StrRet) ) ;
    Cont   := Cont + 1 ;
  end ;

{ Adcionando SA-Sangria e SU-Suprimento que sempre estarão presentes na Bematech}
  CNF := TACBrECFComprovanteNaoFiscal.create ;
  CNF.Indice    := 'SA' ;
  CNF.Descricao := 'Sangria' ;
  fpComprovantesNaoFiscais.Insert(0, CNF ) ;

  CNF := TACBrECFComprovanteNaoFiscal.create ;
  CNF.Indice    := 'SU' ;
  CNF.Descricao := 'Suprimento' ;
  fpComprovantesNaoFiscais.Insert(1, CNF ) ;
*)
end;

procedure TACBrECFEpson.ProgramaComprovanteNaoFiscal(var Descricao : String;
   Tipo: String; Posicao : String);
Var ProxIndice : Integer ;
    CNF    : TACBrECFComprovanteNaoFiscal ;
begin
  { Obs: Bematech nao usa Tipo }
  Descricao := padL(Descricao,19) ;

  CarregaComprovantesNaoFiscais ;

  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 1) or (ProxIndice > 50) then { Indice passado é válido ? }
     ProxIndice := ComprovantesNaoFiscais.Count + 1 ;

  if ProxIndice > 50 then
     raise Exception.create('Não há espaço para programar novos Comprovantes'+
                            ' não Fiscais');

  BytesResp := 0 ;
  EnviaComando( #40 + IntToStrZero(ProxIndice,2) + Descricao ) ;

  { Adcionanodo novo CNF no ObjectList }
  CNF := TACBrECFComprovanteNaoFiscal.create ;
  CNF.Indice    := IntToStrZero(ProxIndice,2) ;
  CNF.Descricao := Descricao ;
  fpComprovantesNaoFiscais.Add( CNF ) ;
end;


procedure TACBrECFEpson.ImprimeCheque(Banco: String; Valor: Double;
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
                            ' não encontrado');
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

procedure TACBrECFEpson.CancelaImpressaoCheque;
begin
  //BytesResp := 0 ;
  //EnviaComando( #62 + #49 ) ;
end;

function TACBrECFEpson.GetChequePronto: Boolean;
Var B : Byte ;
    Resp : String ;
begin
  (*BytesResp := 1 ;
  Resp := EnviaComando( #62 + #48 ) ;
  B := ord( Resp[1] ) ;
  Result := not TestBit(B,5) ;
*)
end;

procedure TACBrECFEpson.ImpactoAgulhas( NivelForca : Integer = 2);
Var Value : Integer ;
begin
  if fpMFD or ( StrToIntDef( NumVersao,0 ) < 310) then
     raise Exception.Create('Comando para aumentar o impacto das agulhas '+
                            'não disponível neste modelo de ECF.') ;

  Value := min(max(NivelForca,3),1) ;
  EnviaComando( #124 + IntToStr( Value ) ) ;
end;

function TACBrECFEpson.GetModeloStr: String;
begin
  Result := fpModeloStr ;

//  Em 20070305 Eduardo Durieux Lopes
// Agora este controle passou para a rotina que verifica o numVersao, la ele
// testa  e verifica se é MFD
//  if fpMFD then
//    Result := Result + ' MFD' ;
end;


procedure TACBrECFEpson.AbreRelatorioGerencial;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#4);

  FumaStringListParametros.Add('1');

  EnviaComando( #14 + #01, 2) ;
end;

procedure TACBrECFEpson.LinhaRelatorioGerencial(Linha: String;
                                                   pbImprimir : Boolean = True);
Var
  iIndiceLista : Integer;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  FumaStringListParametros.Add(Linha);

  EnviaComando(#14 + #02, 2);

end;

procedure TACBrECFEpson.AbreCupomVinculado(COO, CodFormaPagto,
                                           CodComprovanteNaoFiscal :  String;
                                           Valor : Double) ;
Var
  FPG             : TACBrECFFormaPagamento ;
  sValor, FPGDesc : String ;
  sRetorno        : String ;
  ComandoCompleto : Boolean ;
begin
  AguardaImpressao := False;
  sValor := OnlyNumber(Format('%8.2f', [Valor]));

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  FumaStringListParametros.Add(CodFormaPagto);
  FumaStringListParametros.Add(sValor);
  FumaStringListParametros.Add('1');
  FumaStringListParametros.Add('');

  sRetorno := EnviaComando( #14 + #48, 2);
end;

procedure TACBrECFEpson.LinhaCupomVinculado(Linha: String;
                                            pbImprimir : Boolean = True);
Var
  iIndiceLista : Integer;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  FumaStringListParametros.Add(Linha);

  EnviaComando(#14 + #02, 2);

end;

procedure TACBrECFEpson.FechaRelatorio;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#1);

  EnviaComando(#14 + #06, 2);
end;

procedure TACBrECFEpson.CorrigeEstadoErro;
begin
  (*try
     EnviaComando( #70 ) ;
     sleep(200) ;
  except
  end ;*)

  inherited CorrigeEstadoErro ;

  if Estado in [estVenda, estPagamento] then begin
     try
       AbreCupom

     except

     end ;

     try
       CancelaCupom

     except

     end ;
  end;
end;

procedure TACBrECFEpson.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal : Integer);
Var Espera : Integer ;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  FumaStringListParametros.Add(IntToStr(ReducaoInicial));
  FumaStringListParametros.Add(IntToStr(ReducaoFinal));
  FumaStringListParametros.Add('');
  FumaStringListParametros.Add('');

  EnviaComando(#09 + #16, 2);
end;

procedure TACBrECFEpson.LeituraMemoriaFiscal(DataInicial,
                                             DataFinal: TDateTime);
begin

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#1);

  FumaStringListParametros.Add('');
  FumaStringListParametros.Add('');
  FumaStringListParametros.Add(FormatDateTime('ddmmyyyy',DataInicial));
  FumaStringListParametros.Add(FormatDateTime('ddmmyyyy',DataFinal));

  EnviaComando(#09 + #16, 2);
end;

procedure TACBrECFEpson.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas : TStringList);
Var Espera : Integer ;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#12);

  FumaStringListParametros.Add(IntToStr(ReducaoInicial));
  FumaStringListParametros.Add(IntToStr(ReducaoFinal));
  FumaStringListParametros.Add('');
  FumaStringListParametros.Add('');

  EnviaComando(#09 + #16, 2);
end;

procedure TACBrECFEpson.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; var Linhas : TStringList);
Var Espera : Integer ;
begin
FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#9);

  FumaStringListParametros.Add('');
  FumaStringListParametros.Add('');
  FumaStringListParametros.Add(FormatDateTime('ddmmyyyy',DataInicial));
  FumaStringListParametros.Add(FormatDateTime('ddmmyyyy',DataFinal));

  EnviaComando(#09 + #16, 2);
end;

function TACBrECFEpson.GetCNPJ: String;
var
  sRetornoComando : String;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  sRetornoComando := EnviaComando(#05 + #07, 5) ;
  //InterpretaRetorno(sRetornoComando);

  Result := FumaStringListCamposRetornados.Strings[5];
end;

function TACBrECFEpson.GetDataMovimento: TDateTime;
var
  sRetorno           : String;
  sDataRetornada     : String;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  sRetorno := EnviaComando( #08 + #10, 10) ;

  //InterpretaRetorno(sRetorno);

  sDataRetornada := FumaStringListCamposRetornados.Strings[0];

  result := StrToDate(copy(sDataRetornada, 1,2) + DateSeparator +
                      copy(sDataRetornada, 3,2) + DateSeparator +
                      copy(sDataRetornada, 5,4)) ;

end;

function TACBrECFEpson.GetDocAberto: Boolean;
begin
  //
end;

function TACBrECFEpson.GetGTAtual: Currency;
var
  sGtAtual : String;
  sRetorno : String;
begin   
  try
    FumaStringListCamposExtras.Add(#0);
    FumaStringListCamposExtras.Add(#0);

    sRetorno := EnviaComando( #09 + #06, 5) ;

    sGtAtual := FumaStringListCamposRetornados.Strings[0];

    FGTAtual := StrToCurr(sGTAtual);

    result := FGtAtual;
  except
    on E:Exception do begin
      raise Exception.Create('Não foi possível ler o GT Atual do ECF.');

    end;
  end;
end;

function TACBrECFEpson.GetGTInicial: Currency;
begin
  Result := 0;
end;

function TACBrECFEpson.GetNumCRZ: String;
var
  sRetorno : String;
begin
  if fsNumCRZ = '' then
  begin
    FumaStringListCamposExtras.Add(#0);
    FumaStringListCamposExtras.Add(#0);

    sRetorno := EnviaComando( #09 + #07, 5) ;

    fsNumCRZ := FumaStringListCamposRetornados.Strings[1];
  end ;

  Result := fsNumCRZ;
end;

function TACBrECFEpson.GetVendaBruta: Currency;
var
  sRetorno    : String;
  sVendaBruta : String;
begin
  try
    FumaStringListCamposExtras.Add(#0);
    FumaStringListCamposExtras.Add(#0);

    sRetorno := EnviaComando( #09 + #06, 5) ;

    sVendaBruta := FumaStringListCamposRetornados.Strings[1];

    Result := StrToCurr(sVendaBruta);
  except
    on E:Exception do begin
      raise Exception.Create('Não foi possível ler a Venda Bruta do ECF.');

    end;
  end;
end;

function TACBrECFEpson.GetVendaBrutaUltimaReducaoZ: Currency;
var
  sVendaBruta : String;
  sRetorno    : String;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);
  sRetorno := EnviaComando( #09 + #06, 5) ;

  sVendaBruta := FumaStringListCamposRetornados.Strings[1];

  FVendaBrutaUltimaReducaoZ := StrToCurr(sVendaBruta);

  result := FVendaBrutaUltimaReducaoZ;
end;

procedure TACBrECFEpson.VendeItem(Codigo, Descricao, AliquotaICMS,
  Unidade: String; Qtd, ValorUnitario, ValorDesconto, ValorAcrescimo : Double);
var
  DescontoStr  : String;
  AcrescimoStr : String;
begin
  DescontoStr  := intToStrZero(Round(ValorDesconto * 100), 11);
  AcrescimoStr := intToStrZero(Round(ValorAcrescimo * 100), 11);

  VendeItem(Codigo, Descricao, AliquotaICMS, Qtd, ValorUnitario, DescontoStr,
            AcrescimoStr, Unidade);
end;

procedure TACBrECFEpson.VendeItem(Codigo, Descricao,
  AliquotaICMS: String; Qtd, ValorUnitario: Double; psValorDescontoPorItem,
  psValorAcrescimoUnitario, Unidade: String);
Var
    AliquotaStr, sQtde, sValorUnit : String ;
    descontoStr                    : String;
    AcrescimoStr                   : String;
    sRetornoComando                : String;
    sValor                         : String;
    ValAliquota                    : Double ;
    Aliquota                       : TACBrECFAliquota ;
    CMD                            : Byte ;
    Tipo                           : Char ;
begin

  // Descobre a aliquota e seu tipo de acordo com o valor passado
  case AliquotaICMS[1] of
    'I'      : AliquotaStr := 'II' ;
    'N'      : AliquotaStr := 'NN' ;
    'F'      : AliquotaStr := 'FF' ;
  else
   begin
     AliquotaICMS := OnlyNumber(AliquotaICMS);
     VerificaTipoAliquota( AliquotaICMS, Tipo) ;

     try
        ValAliquota := StringToFloat( AliquotaICMS ) ;
     except
        raise EACBrECFCMDInvalido.Create('Aliquota inválida: '+AliquotaICMS);
     end ;

     Aliquota := AchaICMSAliquota( ValAliquota, Tipo ) ;
     if Aliquota <> nil then
        AliquotaStr := Aliquota.Indice
     else
        raise EACBrECFCMDInvalido.Create(
              'Aliquota nao encontrada: '+AliquotaICMS + Tipo);
   end;
  end;

  Codigo     := Trim(Codigo);
  sValorUnit := IntToStrZero( Round( ValorUnitario * 100), 8);
  sQtde      := IntToStrZero( Round( Qtd * 1000), 7) ;
  Descricao  := trim(Descricao);
  Unidade    := padL(Unidade,2);

  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  FumaStringListParametros.Add(Codigo);  // codigo                 12345678911111
  FumaStringListParametros.Add(Descricao);  // descricao              texto livre
  FumaStringListParametros.Add(sQtde);  // qtde                   10000
  FumaStringListParametros.Add(Unidade);  // unidade                UN
  FumaStringListParametros.Add(sValorUnit);  // valor uitario          17000
  FumaStringListParametros.Add(AliquotaStr);  // sit tributaruia        Ta

  sRetornoComando := EnviaComando( #10 + #02, 5) ;

  psValorDescontoPorItem   := OnlyNumber(psValorDescontoPorItem);
  psValorAcrescimoUnitario := OnlyNumber(psValorAcrescimoUnitario);

  if (StrToInt(psValorDescontoPorItem) <> 0) or
     (StrToInt(psValorAcrescimoUnitario) <> 0) then begin
    if (StrToInt(psValorDescontoPorItem) <> 0) then begin
      FumaStringListCamposExtras.Add(#0);
      FumaStringListCamposExtras.Add(#4);
      sValor := Poem_Zeros(psValorDescontoPorItem, 11) ;
    end else begin
      if (StrToInt(psValorAcrescimoUnitario) <> 0) then begin
        FumaStringListCamposExtras.Add(#0);
        FumaStringListCamposExtras.Add(#5);
        sValor := Poem_Zeros(psValorAcrescimoUnitario, 11);
      end;
    end;

    FumaStringListParametros.Add(sValor);
    sRetornoComando := EnviaComando( #10 + #04, 5) ;
  end;
end;

Procedure TACBrECFEpson.LeituraXSerial(var psRetorno : String);
begin
  //
end;


procedure TACBrECFEpson.EstornoComprovanteCreditoDebito(pcdFinalizador : integer;
                                                        pnValor : Currency);
var
  sValor   : String;
  sRetorno : String;
begin
  AguardaImpressao := False;
  sValor := OnlyNumber(Format('%8.2f', [pnValor]));

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#1);

  FumaStringListParametros.Add(intToStr(pcdFinalizador));
  FumaStringListParametros.Add(sValor);
  FumaStringListParametros.Add('');
  FumaStringListParametros.Add('');

  sRetorno := EnviaComando(#14 + #48, 2);


  FechaRelatorio;
end;

function TACBrECFEpson.GetEnderecoProprietario: String;
var
  sRetornoComando : String;
begin

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  sRetornoComando := EnviaComando(#05 + #07, 5) ;

  Result := FumaStringListCamposRetornados.Strings[2];
end;

function TACBrECFEpson.GetRazaoSocialProprietario: String;
var
  sRetornoComando : String;
begin
  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  sRetornoComando := EnviaComando(#05 + #07, 5) ;

  Result := FumaStringListCamposRetornados.Strings[0];
end;


function TACBrECFEpson.CheckSum(psComando: String): String;
var
  iSoma         : integer;
  iContador     : integer;
begin
  iSoma := 0;

  For iContador := 1 to Length(psComando) do
    iSoma := iSoma + ord( psComando[iContador] ) ;

  Result := IntToHex(iSoma, 4);
end;

function TACBrECFEpson.Coloca27(psValorEntrada: String): String;
var
  iContador : integer;
  sSaida    : String;
begin
  sSaida := '';

  For iContador := 1 to length(psValorEntrada) do begin
    Case psValorEntrada[iContador] of

      #2, #3, #26, #27, #28, #29, #30, #31  : sSaida := sSaida + #27;

    end;

    sSaida := sSaida + psValorEntrada[iContador];
  end;

  Result := sSaida;
end;

procedure TACBrECFEpson.setFsNucleoComandoEnviado(const Value: String);
begin
  FsNucleoComandoEnviado := Value;
end;

procedure TACBrECFEpson.setFsSequenciaEnviada(const Value: String);
begin
  FsSequenciaEnviada := Value;
end;

function TACBrECFEpson.InterpretaCampoRetorno(psValorEntrada: String): String;
var
  sValorSaida : String;
begin
  sValorSaida := '';

  Case psValorEntrada[1] of

    #0 : begin
            Case psValorEntrada[2] of
              #0 : sValorSaida := '';
              #1 : sValorSaida := 'Erro interno.';
              #2 : sValorSaida := 'Erro de iniciação do equipamento.';
              #3 : sValorSaida := 'Erro de processo interno.';
            end;
          end;

    #1 : begin
           Case psValorEntrada[2] of
             #1 : sValorSaida := 'Comando inválido para estado atual.';
             #2 : sValorSaida := 'Comando inválido para documento atual.';
             #6 : sValorSaida := 'Comando aceito apenas fora de intervenção.';
             #7 : sValorSaida := 'Comando aceito apenas dentro de intervenção.';
             #8 : sValorSaida := 'Comando inválido durante processo de scan.';
             #9 : sValorSaida := 'Exceço de intervenções.';
           end;
         end;

    #2 : begin
           Case psValorEntrada[2] of
             #1  : sValorSaida := 'Comando com Frame inválido.';
             #2  : sValorSaida := 'Comando inválido.';
             #3  : sValorSaida := 'Campos em excesso.';
             #4  : sValorSaida := 'Campos em falta.';
             #5  : sValorSaida := 'Campo não opcional.';
             #6  : sValorSaida := 'Campo alfanumérico inválido.';
             #7  : sValorSaida := 'Campo alfabético inválido.';
             #8  : sValorSaida := 'Campo numérico inválido.';
             #9  : sValorSaida := 'Campo binário inválido.';
             #10 : sValorSaida := 'Campo imprimível inválido.';
             #11 : sValorSaida := 'Campo hexadecimal inválido.';
             #12 : sValorSaida := 'Campo data inválido.';
             #13 : sValorSaida := 'Campo hora inválido.';
             #14 : sValorSaida := 'Campos com atributos de impressão inválido.';
             #15 : sValorSaida := 'Campo booleano inválido.';
             #16 : sValorSaida := 'Campo com tamanho inválido.';
             #17 : sValorSaida := 'Extensão de comando inválida.';
             #18 : sValorSaida := 'Código de barras não permitido.';
             #19 : sValorSaida := 'Atributos de impressão não permitidos.';
             #20 : sValorSaida := 'Atributos de impressão inválidos.';
             #21 : sValorSaida := 'Código de barras incorretamente definido.';
             #22 : sValorSaida := 'Comando inválido para a porta selecionada.';
           end;
         end;

    #3 : begin
           Case psValorEntrada[2] of
             #1  : sValorSaida := 'Erro de hardware.';
             #2  : sValorSaida := 'Impressora não está pronta.';
             #3  : sValorSaida := 'Erro de Impressão.';
             #4  : sValorSaida := 'Falta de papel.';
             #5  : sValorSaida := 'Pouco papel disponível.';
             #6  : sValorSaida := 'Erro em carga ou expulsão do papel.';
             #7  : sValorSaida := 'Característica não suportada pela impressora.';
             #8  : sValorSaida := 'Erro de display.';
             #9  : sValorSaida := 'Sequência de scan inválida.';
             #10 : sValorSaida := 'Número de área de recorte inválido.';
             #11 : sValorSaida := 'Scanner não preparado.';
             #12 : sValorSaida := 'Qualidade de logotipo não suportado pela impressora.';
             #14 : sValorSaida := 'Erro de leitura de microcódigo.';
           end;
         end;

    #4 : begin
           Case psValorEntrada[2] of
             #1  : sValorSaida := 'Número de série inválido.';
             #2  : sValorSaida := 'Requer dados de fiscalização já configurados.';
           end;
         end;

    #5 : begin
           Case psValorEntrada[2] of
             #1  : sValorSaida := 'Data / Hora não configurada.';
             #2  : sValorSaida := 'Data inválida.';
             #3  : sValorSaida := 'Data em intervalo inválido.';
             #4  : sValorSaida := 'Nome operador inválido.';
             #5  : sValorSaida := 'Número de caixa inválido.';
             #8  : sValorSaida := 'Dados de Cabeçalho ou rodapé inválidos.';
             #9  : sValorSaida := 'Excesso de fiscalização.';
             #12 : sValorSaida := 'Número máximo de meios de pagamento já definidos.';
             #13 : sValorSaida := 'Meio de pagamento já definido.';
             #14 : sValorSaida := 'Meio de pagamento inválido.';
             #15 : sValorSaida := 'Descrição do meio de pagamento inválido.';
             #16 : sValorSaida := 'Valor máximo de desconto inválido.';
             #19 : sValorSaida := 'Logotipo do usuário inválido.';
             #20 : sValorSaida := 'Seqüência de logotipo inválido.';
             #21 : sValorSaida := 'Configuração de display inválida.';
             #22 : sValorSaida := 'Dados do MICR inválidos.';
             #23 : sValorSaida := 'Campo de endereço inválido.';
             #24 : sValorSaida := 'Nome da loja não definido.';
             #25 : sValorSaida := 'Dados fiscais não definidos.';
             #26 : sValorSaida := 'Número seqüencial do ECF inválido.';
             #27 : sValorSaida := 'Simbologia do GT inválida, devem ser todos diferentes.';
             #28 : sValorSaida := 'Número de CNPJ inválido.';
             #29 : sValorSaida := 'Senha de fiscalização inválida.';
             #30 : sValorSaida := 'Último documento deve ser uma redução Z.';
             #31 : sValorSaida := 'Símbolo da moeda igual ao atualmente cadastrado.';
             #32 : sValorSaida := 'Identificação da alíquota não cadastrada.';
             #33 : sValorSaida := 'Alíquota não cadastrada.';
           end;
         end;

    #6 : begin
           Case psValorEntrada[2] of
             #1  : sValorSaida := 'Memória de Fita-detalhe esgotada.';
             #5  : sValorSaida := 'Número de série invalido para a Memória de Fita-detalhe.';
             #6  : sValorSaida := 'Memória de Fita-detalhe não iniciada.';
             #7  : sValorSaida := 'Memória de Fita-detalhe não pode estar iniciada.';
             #8  : sValorSaida := 'Número de série da Memória de Fita-detalhe não confere.';
             #9  : sValorSaida := 'Erro Interno na Memória de Fita-detalhe.';
           end;
         end;

    #7 : begin
           Case psValorEntrada[2] of
             #1  : sValorSaida := 'Valor inválido para o número do registro.';
             #2  : sValorSaida := 'Valor inválido para o número do item.';
             #3  : sValorSaida := 'Intervalo inválido para a leitura da MFD.';
             #4  : sValorSaida := 'Número de usuário inválido para MFD.';
           end;
         end;

    #8 : begin
           Case psValorEntrada[2] of
             #1  : sValorSaida := 'Comando inválido com jornada fiscal fechada.';
             #2  : sValorSaida := 'Comando inválido com jornada fiscal aberta.';
             #3  : sValorSaida := 'Memória Fiscal esgotada.';
             #4  : sValorSaida := 'Jornada fiscal deve ser fechada.';
             #5  : sValorSaida := 'Não há meios de pagamento definidos.';
             #6  : sValorSaida := 'Excesso de meios de pagamento utilizados na jornada fiscal.';
             #7  : sValorSaida := 'Jornada fiscal sem movimento de vendas.';
             #8  : sValorSaida := 'Intervalo de jornada fiscal inválido.';
             #9  : sValorSaida := 'Existem mais dados para serem lidos.';
             #10  : sValorSaida := 'Não existem mais dados para serem lidos.';
             #11  : sValorSaida := 'Não pode abrir jornada fiscal.';
             #12  : sValorSaida := 'Não pode fechar jornada fiscal.';
             #13  : sValorSaida := 'Limite máximo do período fiscal atingido.';
             #14  : sValorSaida := 'Limite máximo do período fiscal não atingido.';
             #15  : sValorSaida := 'Abertura da jornada fiscal não permitida.';
           end;
         end;

    #9 : begin
           Case psValorEntrada[2] of
             #1  : sValorSaida := 'Valor muito grande.';
             #2  : sValorSaida := 'Valor muito pequeno.';
             #3  : sValorSaida := 'Itens em excesso.';
             #4  : sValorSaida := 'Alíquotas em excesso.';
             #5  : sValorSaida := 'Desconto ou acréscimos em excesso.';
             #6  : sValorSaida := 'Meios de pagamento em excesso.';
             #7  : sValorSaida := 'Item não encontrado.';
             #8  : sValorSaida := 'Meio de pagamento não encontrado.';
             #9  : sValorSaida := 'Total nulo.';
             #12  : sValorSaida := 'Tipo de pagamento não definido.';
             #15  : sValorSaida := 'Alíquota não encontrada.';
             #16  : sValorSaida := 'Alíquota inválida.';
             #17  : sValorSaida := 'Excesso de meios de pagamento com CDC.';
             #18  : sValorSaida := 'Meio de pagamento com CDC já emitido.';
             #19  : sValorSaida := 'Meio de pagamento com CDC ainda não emitido.';
             #20  : sValorSaida := 'Leitura da Memória Fiscal – intervalo CRZ inválido.';
             #21  : sValorSaida := 'Leitura da Memória Fiscal – intervalo de data inválido.';
           end;
         end;

     #10: begin
            Case psValorEntrada[2] of
              #01 : sValorSaida := 'Operação não permitida após desconto / acréscimo.';
              #02 : sValorSaida := 'Operação não permitida após registro de pagamentos.s';
              #03 : sValorSaida := 'Tipo de item inválido.';
              #04 : sValorSaida := 'Linha de descrição em branco.';
              #05 : sValorSaida := 'Quantidade muito pequena.';
              #06 : sValorSaida := 'Quantidade muito grande.';
              #07 : sValorSaida := 'Total do item com valor muito alto.';
              #08 : sValorSaida := 'Operação não permitida antes do registro de pagamentos.';
              #09 : sValorSaida := 'Registro de pagamento incompleto.';
              #10 : sValorSaida := 'Registro de pagamento finalizado.';
              #11 : sValorSaida := 'Valor pago inválido.';
              #12 : sValorSaida := 'Valor de desconto ou acréscimo não permitido.';
              #14 : sValorSaida := 'Valor não pode ser zero.';
              #15 : sValorSaida := 'Operação não permitida antes do registro de itens.';
              #17 : sValorSaida := 'Cancelamento de desconto e acréscimo somente para item atual.';
              #18 : sValorSaida := 'Não foi possível cancelar último Cupom Fiscal.';
              #19 : sValorSaida := 'Último Cupom Fiscal não encontrado.';
              #20 : sValorSaida := 'Último Comprovante Não-Fiscal não encontrado.';
              #21 : sValorSaida := 'Cancelamento de CDC necessária.';
              #22 : sValorSaida := 'Número de item em Cupom Fiscal inválido.';
              #23 : sValorSaida := 'Operação somente permitida após subtotalização.';
              #24 : sValorSaida := 'Operação somente permitida durante a venda de itens.';
              #25 : sValorSaida := 'Operação não permitida em item com desconto ou acréscimo.';
              #26 : sValorSaida := 'Dígitos de quantidade inválidos.';
              #27 : sValorSaida := 'Dígitos de valor unitário inválido.';
              #28 : sValorSaida := 'Não há desconto ou acréscimo a cancelar.';
              #29 : sValorSaida := 'Não há item para cancelar.';
              #30 : sValorSaida := 'Desconto ou acréscimo somente no item atual.';
              #31 : sValorSaida := 'Desconto ou acréscimo já efetuado.';
              #32 : sValorSaida := 'Desconto ou acréscimo nulo não permitido.';
              #33 : sValorSaida := 'Valor unitário inválido.';
              #34 : sValorSaida := 'Quantidade inválida.';
              #35 : sValorSaida := 'Código de item inválido.';
              #36 : sValorSaida := 'Descrição inválida.';
              #37 : sValorSaida := 'Operação de desconto ou acréscimo não permitida.';
              #38 : sValorSaida := 'Mensagem promocional já impressa.';
              #39 : sValorSaida := 'Mensagem promocional não pode ser impressa.';
              #40 : sValorSaida := 'Dados do consumidor já impresso.';
              #41 : sValorSaida := 'Dados do consumidor somente no fim do documento.';
              #42 : sValorSaida := 'Dados do consumidor somente no inicio do documento.';
              #43 : sValorSaida := 'Comando Inválido para o item.';
            end;
          end;

     #14: begin
            Case psValorEntrada[2] of
              #01 : sValorSaida := 'Número de linhas em documento excedido.';
              #02 : sValorSaida := 'Número do relatório inválido.';
              #03 : sValorSaida := 'Operação não permitida após registro de itens.';
              #04 : sValorSaida := 'Registro de valor nulo não permitido.';
              #05 : sValorSaida := 'Não há desconto a cancelar.';
              #06 : sValorSaida := 'Não há acréscimo a cancelar.';
              #07 : sValorSaida := 'Operação somente permitida após subtotalização.';
              #08 : sValorSaida := 'Operação somente permitida durante registro de itens.';
              #09 : sValorSaida := 'Operação não-fiscal inválida.';
              #10 : sValorSaida := 'Último comprovante Não-Fiscal não encontrado.';
              #11 : sValorSaida := 'Meio de pagamento não encontrado.';
              #12 : sValorSaida := 'Não foi possível imprimir nova via.';
              #13 : sValorSaida := 'Não foi possível realizar reimpressão.';
              #14 : sValorSaida := 'Não foi possível imprimir nova parcela.';
              #15 : sValorSaida := 'Não há mais parcelas a imprimir.';
              #16 : sValorSaida := 'Registro de item Não-Fiscal inválido.';
              #17 : sValorSaida := 'Desconto ou acréscimo já efetuado.';
              #18 : sValorSaida := 'Valor de desconto ou acréscimo inválido.';
              #19 : sValorSaida := 'Não foi possível cancelar o item.';
              #20 : sValorSaida := 'Itens em excesso.';
              #21 : sValorSaida := 'Operação Não-Fiscal não cadastrada.';
              #22 : sValorSaida := 'Excesso de relatórios / operações não-fiscais cadastradas.';
              #23 : sValorSaida := 'Relatório não encontrado.';
              #24 : sValorSaida := 'Comando não permitido.';
              #25 : sValorSaida := 'Comando não permitido em operações não-fiscais para movimento de monetário.';
              #26 : sValorSaida := 'Comando permitido apenas em operações não-fiscais para movimento de monetário.';
              #27 : sValorSaida := 'Número de parcelas inválido para a emissão de CCD';
              #28 : sValorSaida := 'Operação não fiscal já cadastrada.';
              #29 : sValorSaida := 'Relatório gerencial já cadastrado.';
              #30 : sValorSaida := 'Relatório Gerencial Inválido.';
            end;
          end;

     #18: begin
            Case psValorEntrada[2] of
              #01 : sValorSaida := 'Configuração de cheque não registrada.';
              #02 : sValorSaida := 'Configuração de cheque não encontrada.';
              #03 : sValorSaida := 'Valor do cheque já impresso.';
              #04 : sValorSaida := 'Nominal ao cheque já impresso.';
              #05 : sValorSaida := 'Linhas adicionais no cheque já impresso.';
              #06 : sValorSaida := 'Autenticação já impressa.';
              #07 : sValorSaida := 'Número máximo de autenticações já impresso.';
            end;
          end;

     #255 : begin
              Case psValorEntrada[2] of
                #255 : sValorSaida := 'Erro desconhecido.';
              end;
            end;
  end;
  Result := sValorSaida;
end;

Procedure TACBrECFEpson.InterpretaRetorno(psValorEntrada: String);
var
  sFrameDados          : String;
  iIndiceStringRetorno : integer;

begin
  sFrameDados := Copy(psValorEntrada, 3, length(psValorEntrada) - 7);
  SeparaCamposRetorno(sFrameDados);
end;

procedure TACBrECFEpson.SeparaCamposRetorno(psValorEntrada: String);
var
  iIndice   : integer;
  iContador : integer;
  sCampo    : String;
  bPularProximo : Boolean;
begin
  iIndice := 0;
  // Limpa a StringList com os campos retornados
  FumaStringListCamposRetornados.Clear;
  bPularProximo := False;

  For iContador := 1 to length(psValorEntrada) do begin
    if bPularProximo then begin
      bPularProximo := False;
    end else begin
      if psValorEntrada[iContador] = #27 then begin
        sCampo := sCampo + psValorEntrada[iContador + 1];
        bPularProximo := True;
      end else begin
        if psValorEntrada[iContador] = #28 then begin
          if iIndice = 0 then begin
            FsStatusPrinter := sCampo;
          end else begin
            if iIndice = 1 then begin
              FsStatusFiscal := sCampo;
            end else begin
               if iIndice = 2 then begin
                 Application.ProcessMessages;
                 // Este campo eh reservado, portanto deve ser desconsiderado;
               end else begin
                 if iIndice = 3 then begin
                   FsRetornoDevolvido := sCampo;
                 end else begin
                   if iIndice = 4 then begin
                     Application.ProcessMessages;
                     // Este campo eh reservado, portanto deve ser desconsiderado;
                   end else begin
                     FumaStringListCamposRetornados.Add(sCampo);
                   end;
                 end;
               end;
            end;
          end;
          INC(iIndice);
          sCampo := '';
        end else begin
          sCampo := sCampo + psValorEntrada[iContador];
        end;
      end;
    end;
  end;

  if sCampo <> '' then begin
    FumaStringListCamposRetornados.Add(sCampo);
  end;
end;

function TACBrECFEpson.CaracterReservado(psCaracter: Char): boolean;
begin
  Result := psCaracter in [#2, #3, #26, #27, #28, #29, #30, #31];
end;

procedure TACBrECFEpson.PreparaParametros;
var
  iContador      : integer;
  sParametro     : String;

  sNovoParametro : String;
begin
  try
    FumaStringListParametrosProntos.Clear;
    For iContador := 0 to FumaStringListParametros.Count - 1 do begin
      sNovoParametro := Coloca27(FumaStringListParametros.Strings[iContador]);
      FumaStringListParametrosProntos.Add(sNovoParametro);
    end;
  finally
    FumaStringListParametros.Clear;
  end;
end;

function TACBrECFEpson.MontaFrameDeDados(psComandoEntrada: String): String;
var
  sValorSaida : String;

  iContadorParametros : integer;
begin
  sValorSaida := psComandoEntrada + #28; // + #00 + #00;

  For iContadorParametros := 0 to FumaStringListCamposExtras.Count - 1 do begin
    sValorSaida := sValorSaida +
                   FumaStringListCamposExtras.Strings[iContadorParametros];
  end;
  FumaStringListCamposExtras.Clear;

  For iContadorParametros := 0 to FumaStringListParametrosProntos.Count - 1 do begin
    sValorSaida := sValorSaida +
                   #28 +
                   FumaStringListParametrosProntos.Strings[iContadorParametros];
  end;
  FumaStringListParametrosProntos.Clear;

  Result := sValorSaida;
end;

procedure TACBrECFEpson.InterpretaStatusFiscal;
begin
  FbCupomAberto := ((ORD(FsStatusFiscal[2]) and (1 shl 0)) > 0) AND
                   not((ORD(FsStatusFiscal[2]) and (1 shl 1)) > 0) AND
                   not((ORD(FsStatusFiscal[2]) and (1 shl 2)) > 0) AND
                   not((ORD(FsStatusFiscal[2]) and (1 shl 3)) > 0);

  //TestBit(0, ORD(FsStatusFiscal[1]));

(*
  FbCupomAberto := not (TestBit(0, ORD(FsStatusFiscal[1])) AND
               TestBit(0, ORD(FsStatusFiscal[2])) AND
               TestBit(0, ORD(FsStatusFiscal[3])) AND
               TestBit(0, ORD(FsStatusFiscal[4])));
  *)
  //PoucoPapel := TestBit(ORD(FsStatusFiscal[2], 1) AND
  //              TestBit(ORD(FsStatusFiscal[0], 1);
                                             

  (*if TestBit(ORD(FsStatusFiscal[1]), 7) then
    ShowMessage('Período Vendas aberto')
  else
    ShowMessage('Período Vendas aberto');

  if TestBit(ORD(FsStatusFiscal[1]), 15) then
    ShowMessage('ECF OFFLINE');*)
end;

procedure TACBrECFEpson.CorrigeVelocidade;
var
  sRetornoComando : String;
begin
  inherited;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#2);

  sRetornoComando := EnviaComando( #00 + #10, 5) ;

end;


procedure TACBrECFEpson.AcionaGuilhotina;
var
  sRetornoComando : String;
begin
  AguardaImpressao := False;

  FumaStringListCamposExtras.Add(#0);
  FumaStringListCamposExtras.Add(#0);

  sRetornoComando := EnviaComando(#07 + #02, 2);
end;

end.


Leitura x
PC   --> 02 D9 08 1B 02 1C 00 00 03 30 31 31 46 
FP   --> 02 D9 00 01 1C C0 00 1C 1C 00 00 1C 1C 34 34 03 30 32 39 33 
PC   --> 06 

Data / Hora
PC   --> 02 DA 05 1B 02 1C 00 00 03 30 31 31 44
FP   --> 02 DA 00 01 1C C0 00 1C 1C 00 00 1C 1C 30 31 31 31 32 30 30 37 1C 31 30 34 34 31 38 03 30 35 30 36
PC   --> 06

Abre Jornada Fiscal
PC   --> 06
PC   --> 02 DD 08 05 1C 00 00 03 30 31 30 42
FP   --> 02 DD 00 01 1C C0 80 1C 1C 00 00 1C 03 30 32 39 33
PC   --> 06

Abre Cupom
PC   --> 02 DE 0A 01 1C 00 00 1C 1C 03 30 31 34 32
FP   --> 02 DE 00 01 1C C0 81 1C 1C 00 00 1C 03 30 32 39 35
PC   --> 06

Vende Item                          7890000001234                             Texto de descricao                                                      U  N     1000              Ta   ETX --CHECKSUM-
PC   --> 02 DF 0A 1B 02 1C 00 00 1C 37 38 39 30 30 30 30 30 30 31 32 33 34 1C 54 65 78 74 6F 20 64 65 20 64 65 73 63 72 69 63 61 6F 1C 31 30 30 30 1C 55 4E 1C 31 37 30 30 30 1C 54 61 03 30 45 33 43
FP   --> 02 DF 00 01 1C C0 81 1C 1C 00 00 1C 1C 31 03 30 32 45 33
PC   --> 06

Cancela Cupom
PC   --> 02 E0 0A 18 1C 00 08 1C 31 03 30 31 37 38
FP   --> 02 E0 00 01 1C C0 80 1C 1C 00 00 1C 1C 30 1C 31 37 30 30 30 03 30 33 46 36
PC   --> 06

Obter Taxas
PC   --> 02 E2 05 42 1C 00 00 03 30 31 34 41
         STXSEQ-STP-    -STF-   R   -RET-   R   T  a     1  8  0  0     0  0  0  0     T  b     1  2  0  0     0  0  0  0     T  c     1  5  0  0     0  0  0  0     T  d     1  9  0  0     0  0  0  0     S  a     0  5  0  0     0  0  0  0 ETX --CHECKSUM-
FP   --> 02 E2 00 01 1C C0 80 1C 1C 00 00 1C 1C 54 61 1C 31 38 30 30 1C 30 30 30 30 1C 54 62 1C 31 32 30 30 1C 30 30 30 30 1C 54 63 1C 30 35 30 30 1C 30 30 30 30 1C 54 64 1C 31 39 30 30 1C 30 30 30 30 1C 53 61 1C 30 35 30 30 1C 30 30 30 30 03 30 46 36 41
PC   --> 06

Reservados:
#2, #3, #26 - #31

+Ç = C080 = 49280 =
1100000010000000
