{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:    Alexandre Rocha Lima e Marcondes             }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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
|* 26/05/2004: Primeira Versao
|*    Daniel Simoes de Almeida
|*    Criaçao do componente ACBrDevice, que implementa comunicaçao com portas
|*    Seriais e Paralela e deverá ser usado por outros componentes ACBr*
|* 26/09/2004: Criaçao da classe: TACBrThreadTimer
|*    Daniel e Alexandre
|*    Essa classe emula um TTimer, porem em uma Thread, evitando sobrecarregar
|*    o Application. Usada por ACBrLCB e ACBrDIS
|* 01/02/2005: Criaçao da classe: TACBrThreadEnviaLPT
|*    Daniel Simoes de Almeida
|*    Essa classe é usada pela funçao EnviaStrThread para detectar se os Dados
|*    estao sendo "gravados" com sucesso na porta paralela ou arquivo.
|* 07/10/2005: Removido o TACBrThreadTimer,  Daniel Simões de Almeida
|*    Não apresenta vantagens em relação ao TTimer (Delphi), problemas quando
|*    o componente está dentro de DLLs
|* 27/10/2005: Daniel Simoes de Almeida
|*    Desativada a TACBrThreadEnviaLPT, comentando o  $DEFINE ThreadEnviaLPT
|*    devido a Problemas como "Erro gravando em LPTx"....  TODO: Corrigir...
|* 22/11/2005: Daniel Simoes de Almeida
|*    modificado gravação em Arquivos Texto para verificar se o arquivo já
|*    existe e adcionar dados no final, ao inves de sempre sobrescreve-lo
|* 13/03/2006: Daniel Simoes de Almeida
|* - Permite modificar alguns parametros da porta serial mesmo com ela aberta.
|* - Modificaçoes em run-time nos parametros da serial não eram efetivadas na
|*   Synaser
******************************************************************************}

{$I ACBr.inc}

//{$DEFINE ThreadEnviaLPT}  { Use // no inicio dessa linha para desabilitar a Thread}

{$IFDEF LINUX}
   { Thread TACBrThreadEnviaLPT não funciona muito bem no Linux }
   { infelizmente, Strings grandes nao funcionam bem no LINUX usando a Thread}
  {$UNDEF ThreadEnviaLPT}
{$ENDIF}

Unit ACBrBase ;

interface
uses synaser,  {Units da ACBr}
     SysUtils,
     {$IFDEF COMPILER6_UP}
        DateUtils, Types, StrUtils,
     {$ELSE}
        Windows, ACBrD5,
     {$ENDIF}
     {$IFNDEF CONSOLE}
       {$IFDEF VisualCLX}
          QForms, QDialogs, QPrinters,
       {$ELSE}
          Forms, Dialogs, Printers, 
       {$ENDIF}
     {$ENDIF}
     Classes ;


const
  ACBR_VERSAO = '0.8.7b';
  CR = #13 ; { Carriage Return, retorno de carro }
  LF = #10 ; { Line Feed, Pulo de Linha }
  FF = #12 ; { Form Feed, Pulo de Pagina }
  cTimeout = 3 ;  { Tempo PADRAO para msg de falha de comunicacao }

  {$IFNDEF COMPILER6_UP}
  sLineBreak = {$IFDEF LINUX} #10 {$ENDIF} {$IFDEF MSWINDOWS} #13#10 {$ENDIF};
  {$ENDIF}
type

TACBrAboutInfo = (ACBrAbout);

TACBrECFEstado = (estNaoInicializada, { Porta Serial ainda nao foi aberta }
                  estDesconhecido, {Porta aberta, mas estado ainda nao definido}
                  estLivre, { Impressora Livre, sem nenhum cupom aberto,
                              pronta para nova venda, Reducao Z e Leitura X ok,
                              pode ou nao já ter ocorrido 1ª venda no dia...}
                  estVenda, { Cupom de Venda Aberto com ou sem venda do 1º Item}
                  estPagamento, { Iniciado Fechamento de Cupom com Formas Pagto
                                  pode ou não ter efetuado o 1º pagto. Nao pode
                                  mais vender itens, ou alterar Subtotal}
                  estRelatorio, { Imprimindo Cupom Fiscal Vinculado ou
                                  Relatorio Gerencial }
                  estBloqueada, { Reduçao Z já emitida, bloqueada até as 00:00 }
                  estRequerZ, {Reducao Z dia anterior nao emitida. Emita agora }
                  estRequerX,  {Esta impressora requer Leitura X todo inicio de
                               dia. Imprima uma Leitura X para poder vender}
                  estNaoFiscal  { Comprovante Nao Fiscal Aberto }
                  ) ;
TACBrECFEstadoSet = set of TACBrECFEstado ;

TACBrGAVAberturaAntecipada = ( aaIgnorar , aaException, aaAguardar ) ;

TACBrETQOrientacao = (orNormal, or270, or180, or90);

{ ACBrComponente contém apenas a propriedade ACBrAbout }
TACBrComponent = class( TComponent )
  private
    fsAbout: TACBrAboutInfo;
  published
     property AboutACBr : TACBrAboutInfo read fsAbout write fsAbout
                           stored false ;
  end ;

TACBrSerialParity = (pNone, pOdd, pEven, pMark, pSpace) ;
TACBrSerialStop   = (s1, s1eMeio, s2) ;
TACBrHandShake    = (hsNenhum, hsXON_XOFF, hsRTS_CTS, hsDTR_DSR) ;

{ ACBrDevice é um componente apenas para usarmos o recurso de AutoExpand do
  ObjectInspector para SubComponentes, poderia ser uma Classe }
TACBrDevice = class( TComponent )
  private
    fsHardFlow: Boolean;
    fsSoftFlow: Boolean;
    fsParity: Char ;
    fsData : Integer;
    fsBaud: Integer;
    fsStop: Integer ;
    fsPorta: String;
    fsTimeOut: Integer ;
    fsAtivo: Boolean;

    fsHandShake: TACBrHandShake;

    procedure ConfiguraSerial ;
    {$IFDEF ThreadEnviaLPT}
    procedure EnviaStrThread( AString : String ) ;
    {$ENDIF}

    procedure SetBaud(const Value: Integer);
    procedure SetData(const Value: Integer);
    procedure SetHardFlow(const Value: Boolean);
    function GetParity: TACBrSerialParity;
    procedure SetParity(const Value: TACBrSerialParity);
    procedure SetSoftFlow(const Value: Boolean);
    function GetStop: TACBrSerialStop;
    procedure SetStop(const Value: TACBrSerialStop);
    procedure SetPorta(const Value: String);
    procedure SetTimeOut(const Value: Integer);
    procedure SetOnStatus(const Value: THookSerialStatus);
    function GetOnStatus: THookSerialStatus;
    procedure SetAtivo(const Value: Boolean);
    procedure SetHandShake(const Value: TACBrHandShake);
    function GetParamsString: String;
    procedure SetParamsString(const Value: String);
  public
    Serial : TBlockSerial ;
    PosImp : TPoint;

    property Ativo : Boolean read fsAtivo write SetAtivo ;

    property Porta   : String  read fsPorta write SetPorta ;
    property TimeOut : Integer read fsTimeOut write SetTimeOut ;
    Function EmLinha( lTimeOut : Integer = 1) : Boolean  ;

    property ParamsString : String read GetParamsString write SetParamsString ;

    constructor Create(AOwner: TComponent); override ;
    destructor Destroy ; override ;

    procedure Ativar ;
    procedure Desativar ;
    Procedure EnviaString( AString : String ) ;

    Procedure ImprimePos(Linha, Coluna : Integer; AString: String) ;
    Procedure Eject ;

    Procedure SetDefaultValues ;
    Function IsSerialPort : Boolean ;
    Function IsTXTFilePort: Boolean ;

  published
     property Baud     : Integer read fsBaud write SetBaud default 9600 ;
     property Data     : Integer read fsData write SetData default 8 ;
     property Parity   : TACBrSerialParity read GetParity write SetParity
                         default pNone ;
     property Stop     : TACBrSerialStop read GetStop write SetStop
                         default s1 ;
     property HandShake : TACBrHandShake read fsHandShake write SetHandShake
                         default hsNenhum ;
     property SoftFlow : Boolean read fsSoftFlow write SetSoftFlow
                         default false ;
     property HardFlow : Boolean read fsHardFlow write SetHardFlow
                         default false ;
     property OnStatus : THookSerialStatus read GetOnStatus write SetOnStatus ;
end ;

{ Essa classe é usada pela funçao EnviaStrThread para detectar se os Dados
  estao sendo "gravados" com sucesso na porta paralela ou arquivo. }
TACBrThreadEnviaLPT = class(TThread)
  private
    { Private declarations }
    fsTextoAEnviar : String ;
    fsLinhaAtual: Integer;
    fsOwner : TObject ;
  protected
    procedure Execute ; override;
  public
    constructor Create(AOwner : TObject; AString : String) ;
    property LinhaAtual : Integer read fsLinhaAtual ;
  end;

{ Essa classe emula um TTimer, porem em uma Thread, evitando sobrecarregar
  o Application. Usada por ACBrLCB e ACBrDIS }
TACBrThreadTimer = class(TThread)
  private
    fsOnTimer : TNotifyEvent;
    fsEnabled: Boolean;
    fsInterval: Integer;
    procedure SetEnabled(const Value: Boolean);
    procedure SetInterval(const Value: Integer);
  protected
    procedure ChamarEvento;
    procedure Execute; override;
  public
    constructor Create ;
  published
    property OnTimer  : TNotifyEvent read fsOnTimer write fsOnTimer ;
    property Interval : Integer read fsInterval write SetInterval ;
    property Enabled : Boolean read fsEnabled write SetEnabled ;
  end;

procedure ACBrAboutDialog ;

implementation
Uses ACBrUtil ;

procedure ACBrAboutDialog ;
var Msg : String ;
begin
  {$IFDEF CONSOLE}
      Msg := 'Componentes ACBr CONSOLE'+sLineBreak+
             'Automação Comercial Brasil'+sLineBreak+
             'http://acbr.sourceforge.net'+sLineBreak+
             'Versão: '+ACBR_VERSAO ;
      writeln( Msg )
  {$ELSE}
    {$IFDEF VisualCLX}
      Msg := 'Componentes <b>ACBr CLX</b><BR>'+
              'Automação Comercial Brasil<BR><BR>'+
              '<A HREF="http://acbr.sourceforge.net">'+
              'http://acbr.sourceforge.net</A><BR><BR>'+
              'Versão: <b>'+ACBR_VERSAO+'</b>' ;
    {$ELSE}
      Msg := 'Componentes ACBr VCL'+#10+
             'Automação Comercial Brasil'+#10+#10+
             'http://acbr.sourceforge.net'+#10+#10+
             'Versão: '+ACBR_VERSAO ;
    {$ENDIF}

     MessageDlg(Msg ,mtInformation ,[mbOk],0) ;
 {$ENDIF}
end;


{ TACBrDevice }
constructor TACBrDevice.create( AOwner : TComponent );
begin
  inherited Create( AOwner ) ;

  { Classe SynaSer para acesso direto a Serial }
  Serial := TBlockSerial.Create ;
  Serial.RaiseExcept := true ;

  { Variaveis Internas }
  fsPorta   := '' ;
  fsTimeOut := cTimeout ;
  
  SetDefaultValues ;
end;

destructor TACBrDevice.Destroy;
begin
  Serial.Free ;
  IOResult ;

  inherited Destroy ;
end;

procedure TACBrDevice.SetDefaultValues;
begin
  fsHardFlow := false ;
  fsSoftFlow := false ;
  fsHandShake:= hsNenhum ;
  fsParity   := 'N' ;
  fsData     := 8 ;
  fsBaud     := 9600 ;
  fsStop     := 0 ;

  PosImp.X   := 0 ;
  PosImp.Y   := 0 ;
end;


procedure TACBrDevice.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrDevice.Ativar;
Var ArqPrn : TextFile ;
begin
  if fsAtivo then exit ;

  if fsPorta = '' then
     raise Exception.Create('Porta não definida');

  if IsSerialPort then
   begin
     try
        Serial.CloseSocket ;  { Fecha se ficou algo aberto }
        Serial.DeadlockTimeout := (TimeOut * 1000) ;
        Serial.Connect( fsPorta ) ;
        ConfiguraSerial ;

        Serial.Purge ;  { Limpa Buffer de envio e recepção }
     except
        try
           Serial.RaiseExcept := false ;
           Serial.CloseSocket ;
        finally
           Serial.RaiseExcept := true ;
        end ;
        raise ;
     end ;
   end
  else
   begin{ Tenta Abrir Arquivo/Porta para ver se está existe e está disponivel}
      try
         try
            try    { Tenta 2x pois as vezes o handle não fica livre }
               AssignFile( ArqPrn, Porta );
               Rewrite( ArqPrn ) ;
            except
               {$I-} {$IFNDEF FPC}System.{$ENDIF}CloseFile( ArqPrn ) ; {$I+}
               AssignFile( ArqPrn, Porta );
               Rewrite( ArqPrn ) ;
            end ;
         finally
            {$I-} {$IFNDEF FPC}System.{$ENDIF}CloseFile( ArqPrn ) ; {$I+}
         end ;
      except
         on E : Exception do
         begin
            raise Exception.Create( 'Erro abrindo: '+Porta + sLineBreak +
                                    E.Message) ;
         end ;
      end ;
   end ;

  fsAtivo := true ;
end;

procedure TACBrDevice.ConfiguraSerial ;
begin
  if not Serial.InstanceActive then exit ;
  
  Serial.Config( fsBaud, fsData, fsParity, fsStop, fsSoftFlow, fsHardFlow);

  if HandShake = hsRTS_CTS then
     Serial.RTS := true
  else if HandShake = hsDTR_DSR then
     Serial.DTR := true ;
end ;

procedure TACBrDevice.Desativar;
begin
  if not fsAtivo then exit ;

  if IsSerialPort then
  begin
     try
        Serial.RaiseExcept := false ;
        Serial.CloseSocket ;
     finally
        Serial.RaiseExcept := true ;
     end ;
  end ;

  fsAtivo := false ;
end;

function TACBrDevice.GetOnStatus: THookSerialStatus;
begin
  result := Serial.OnStatus ;
end;

procedure TACBrDevice.SetOnStatus(const Value: THookSerialStatus);
begin
  Serial.OnStatus := Value ;
end;

procedure TACBrDevice.SetBaud(const Value: Integer);
begin
  if fsBaud = Value then exit ;

  if (Value < 50) or (Value > 4000000) then
     raise Exception.Create('Valor deve estar na faixa de 50 a 4000000.'+#10+
           'Normalmente os equipamentos Seriais utilizam: 9600') ;

  fsBaud := Value ;
  ConfiguraSerial ;
end;

procedure TACBrDevice.SetData(const Value: Integer);
begin
  if fsData = Value then exit ;

  if (Value < 5) or (Value > 8) then
     raise Exception.Create('Valor deve estar na faixa de 5 a 8.'+#10+
           'Normalmente os equipamentos Seriais utilizam: 7 ou 8') ;

   fsData := Value ;
   ConfiguraSerial ;
end;

function TACBrDevice.GetParity: TACBrSerialParity;
begin
  case fsParity of
     'O' : result := pOdd   ;
     'E' : result := pEven  ;
     'M' : result := pMark  ;
     'S' : result := pSpace ;
  else
     result := pNone ;
  end;
end;

procedure TACBrDevice.SetParity(const Value: TACBrSerialParity);
begin
  if Parity = Value then exit ;

  case Value of
     pOdd   : fsParity := 'O' ;
     pEven  : fsParity := 'E' ;
     pMark  : fsParity := 'M' ;
     pSpace : fsParity := 'S' ;
  else
     fsParity := 'N' ;
  end;
  ConfiguraSerial ;
end;

function TACBrDevice.GetStop: TACBrSerialStop;
begin
  case fsStop of
     1 : result := s1eMeio ;
     2 : result := s2      ;
  else
     result := s1 ;
  end;
end;

procedure TACBrDevice.SetStop(const Value: TACBrSerialStop );
begin
  if Stop = Value then exit ;

  case Value of
     s1eMeio : fsStop := 1 ;
     s2      : fsStop := 2 ;
  else
     fsStop  := 0 ;
  end;
  ConfiguraSerial ;
end;

procedure TACBrDevice.SetHardFlow(const Value: Boolean);
begin
  if Value then
     HandShake := hsRTS_CTS 
  else
     if HandShake = hsRTS_CTS then
        HandShake := hsNenhum ;
end;

procedure TACBrDevice.SetSoftFlow(const Value: Boolean);
begin
  if Value then
     HandShake := hsXON_XOFF
  else
     if HandShake = hsXON_XOFF then
        HandShake := hsNenhum ;
end;

procedure TACBrDevice.SetHandShake(const Value: TACBrHandShake);
begin
  fsHardFlow  := (Value = hsRTS_CTS);
  fsSoftFlow  := (Value = hsXON_XOFF);

  fsHandShake := Value;
  ConfiguraSerial ;
end;

procedure TACBrDevice.SetPorta(const Value: String);
Var StrTemp : String ;
begin
  if fsPorta = Value then exit ;

  if Ativo then
     raise Exception.Create('Não é possível mudar a Porta com o'+
                            ' Dispositivo Ativo');

  StrTemp := UpperCase( Value ) ;
  if (pos('LPT',StrTemp) = 1) or (pos('COM',StrTemp) = 1) then
     fsPorta := StrTemp
  else
     fsPorta := Value ;
end;

procedure TACBrDevice.SetTimeOut(const Value: Integer);
begin
  if Value = fsTimeOut then
     exit ;

  if Value < 1 then
     fsTimeOut := 1
  else
     fsTimeOut := Value ;

  if IsSerialPort then
     Serial.DeadlockTimeout := (TimeOut * 1000) ;
end;

function TACBrDevice.EmLinha( lTimeOut : Integer) : Boolean;
var TempoLimite : TDateTime ;
begin
  if not IsSerialPort then
  begin
     try
        {$IFDEF ThreadEnviaLPT}
        EnviaStrThread(#0);  { Tenta escrever algo (#0) na Porta/Arquivo }
        {$ENDIF}
        Result := true ;
     except
        Result := false ;
     end ;
     
     exit ;
  end ;

  result := false ;
  if lTimeout < 1 then
     lTimeOut := 1 ;

  if not Serial.InstanceActive then
     exit ;

  TempoLimite := IncSecond( now, lTimeOut)  ;
  while (not result) and (now < TempoLimite) do
  begin
     case HandShake of
       hsRTS_CTS :
          Result := Serial.CTS ;

       hsDTR_DSR :
          Result := Serial.DSR ;
     else ;
        Result := true ;    { Nao há sinal de HandShake para verificar }
     end;

     if not result then
     begin
        {$IFNDEF CONSOLE}
          Application.ProcessMessages ;  { para redesenhar a tela do programa }
        {$ENDIF}
        sleep(10) ;
     end ;
  end ;
end;

function TACBrDevice.IsSerialPort: Boolean;
begin
   Result := (pos('COM', fsPorta) =  1)
             {$IFDEF LINUX}
               or (pos('/dev/tty', fsPorta) =  1)
             {$ELSE}
               or (copy(fsPorta,1,4) = '\\.\')
             {$ENDIF}
end;

function TACBrDevice.IsTXTFilePort: Boolean;
begin
  Result := UpperCase(RightStr(fsPorta,4)) = '.TXT' ;
end;

function TACBrDevice.GetParamsString: String;
Var sStop, sHandShake : String ;
begin
  Result := '' ;

  if fsBaud <> 9600 then
     Result := Result + ' BAUD='+IntToStr(fsBaud) ;

  if fsData <> 8 then
     Result := Result + ' DATA='+IntToStr(fsData) ;

  if fsParity <> 'N' then
     Result := Result + ' PARITY='+fsParity ;

  if fsStop <> 0 then
  begin
     if fsStop = 2 then
        sStop := '2'
     else if fsStop = 1 then
        sStop := '1,5'
     else
        sStop := '1' ;

     Result := Result + ' STOP='+sStop ;
  end ;

  if fsHandShake <> hsNenhum then
  begin
     if fsHandShake = hsXON_XOFF then
        sHandShake := 'XON/XOFF'
     else if fsHandShake = hsDTR_DSR then
        sHandShake := 'DTR/DSR'
     else if fsHandShake = hsRTS_CTS then
        sHandShake := 'RTS/CTS' ;

     Result := Result +  ' HANDSHAKE='+sHandShake ;
  end ;

  if fsHardFlow then
     Result := Result + ' HARDFLOW' ;

  if fsSoftFlow then
     Result := Result + ' SOFTFLOW' ;

  Result := Trim(Result) ;
end;

procedure TACBrDevice.SetParamsString(const Value: String);
Var S, Linha   : String ;
  Function GetValue( LinhaParametros, Parametro : String ) : String ;
    Var P   : Integer ;
        Sub : String ;
  begin
    Result := '' ;
    P := pos(Parametro,LinhaParametros) ;

    if P > 0 then
    begin
      Sub := Trim(copy(LinhaParametros, P + Length(Parametro) ,200)) ;
      if copy(Sub,1,1) = '=' then
         Sub := Trim(copy(Sub,2,200)) ;

      P := pos(' ',Sub) ;
      if P = 0 then
         P := Length(Sub) ;

      Result := Trim(copy(Sub,1,P)) ;
    end ;
  end ;
begin
  SetDefaultValues ;
  
  Linha := Trim(UpperCase(Value)) ;

  Baud := StrToIntDef(GetValue(Linha,'BAUD'),Baud) ;

  S := GetValue(Linha,'PARITY') ;
  if S <> '' then
     if S[1] in ['O','E','M','S','N'] then
        fsParity := S[1] ;

  Data := StrToIntDef(GetValue(Linha,'DATA'),Data) ;

  S := GetValue(Linha,'STOP') ;
  if S = '1' then
    Stop := s1
  else if S = '1,5' then
    Stop := s1eMeio
  else if S = '2' then
    Stop := s2 ;

  HardFlow := (pos('HARDFLOW',Linha) > 0) ;
  SoftFlow := (pos('SOFTFLOW',Linha) > 0) ;

  S := GetValue(Linha,'HANDSHAKE') ;
  if S = 'XON/XOFF' then
     HandShake := hsXON_XOFF
  else if S = 'DTR/DSR' then
     HandShake := hsDTR_DSR
  else if S = 'RTS/CTS' then
     HandShake := hsRTS_CTS ;
end;


procedure TACBrDevice.EnviaString(AString: String);
{$IFNDEF ThreadEnviaLPT}
   Var ArqPrn : TextFile ;
{$ENDIF}
begin
  if IsSerialPort then
     Serial.SendString( AString )     { Envia para Porta Serial }
  else
   begin
     {$IFNDEF ThreadEnviaLPT} 
        AssignFile( ArqPrn, Porta );
        try
           if IsTXTFilePort and FileExists(Porta) then
              Append( ArqPrn )
           else
              Rewrite( ArqPrn ) ;

           Write( ArqPrn, AString ) ;
           Flush( ArqPrn ) ;
        finally
           {$I+}
           {$IFNDEF FPC}System.{$ENDIF}CloseFile( ArqPrn ) ;
           {$I+}
        end ;

        if not IsTXTFilePort then
           Sleep(10) ;
     {$ELSE}
        EnviaStrThread( AString );
     {$ENDIF}
   end ;
end;

{$IFDEF ThreadEnviaLPT}
{ A ideia dessa Thread é testar se os dados estão sendo gravados com sucesso na
  Porta Paralela (ou arquivo). É criada uma Thread para "gravar" os dados em
  segundo plano, enquanto o programa monitora se as linhas estão sendo enviadas.
  Caso a Thread nao consiga enviar uma linha dentro do Timeout definido a Thread
  é cancelada e é gerado um TIMEOUT. Isso evita o "travamento" do programa
  quando a porta ou arquivo não estão prontos para a gravaçao com o comando
  Write() }
procedure TACBrDevice.EnviaStrThread(AString: String);
Var IsTimeOut  : Boolean ;
    TempoFinal : TDateTime ;
    UltimaLinhaImpressa : Integer ;
    ThreadEnviaLPT : TACBrThreadEnviaLPT ;
begin
  { Criando Thread para monitorar o envio de dados a Porta Paralela }
  IsTimeOut           := false ;
  UltimaLinhaImpressa := -1 ;
  TempoFinal          := -1 ;
  ThreadEnviaLPT      := TACBrThreadEnviaLPT.Create( Self, AString ) ;
  try
     while not ThreadEnviaLPT.Terminated do
     begin
        if UltimaLinhaImpressa <> ThreadEnviaLPT.LinhaAtual then
        begin
           TempoFinal := IncSecond(now,TimeOut) ;
           UltimaLinhaImpressa := ThreadEnviaLPT.LinhaAtual ;
        end ;

        {$IFNDEF CONSOLE}
          Application.ProcessMessages ;
        {$ENDIF}  
        IsTimeOut := (now > TempoFinal) ; {Verifica se estourou o tempo TIMEOUT}
        if IsTimeOut then
           Break ;

        sleep(200) ;
     end ;
  finally
     ThreadEnviaLPT.Terminate ;

     if IsTimeOut then
        raise Exception.Create( 'Erro gravando em: '+Porta) ;
  end ;
end;
{$ENDIF}

procedure TACBrDevice.ImprimePos(Linha, Coluna : Integer; AString: String);
Var Cmd : String ;
begin
  if (AString = '') or
     (Linha < 0)    or
     (Coluna < 0) then
     exit ;

  Cmd := '' ;

  if Linha < PosImp.X then
     Eject ;

  if Linha > PosImp.X then
  begin
     Cmd := StringOfChar( LF, (Linha - PosImp.X) ) ;
     PosImp.X := Linha ;
  end ;

  if Coluna < PosImp.Y then
  begin
     Cmd := Cmd + CR ;
     PosImp.Y := 0 ;
  end ;

  if Coluna > PosImp.Y then
  begin
     Cmd := Cmd + StringOfChar( ' ', (Coluna - PosImp.Y) ) ;
     PosImp.Y := Coluna ;
  end ;

  EnviaString( Cmd + AString ) ;
  PosImp.Y := PosImp.Y + Length( AString );

end;

procedure TACBrDevice.Eject;
begin
  EnviaString( FF );
  PosImp.X := 0 ;
end;

{---------------------------- TACBrThreadEnviaLPT -----------------------------}
constructor TACBrThreadEnviaLPT.Create(AOwner : TObject; AString: String ) ;
begin
  if not (AOwner is TACBrDevice) then
     raise Exception.Create('Uso Inválido da TACBrThreadEnviaLPT');

  inherited Create( false ) ; { Rodar Imediatemanete }
  FreeOnTerminate := true ;
  
  fsOwner        := AOwner  ;
  fsTextoAEnviar := AString ;
end;

procedure TACBrThreadEnviaLPT.Execute;
Var ArqPrn : TextFile;
    Linha  : String ;
    P      : Integer ;
begin
  if fsTextoAEnviar <> '' then
  begin
     fsLinhaAtual := 0 ;
     with TACBrDevice(fsOwner) do
     begin
        AssignFile( ArqPrn, Porta);
        try
           if IsTXTFilePort and FileExists(Porta) then
              Append( ArqPrn )
           else
              Rewrite( ArqPrn ) ;

           while (fsTextoAEnviar <> '') and (not Terminated) do
           begin
              P := pos(CRLF,fsTextoAEnviar) ;
              if P = 0 then
                 P := Length( fsTextoAEnviar ) ;

              Linha          := copy(fsTextoAEnviar,1,P+1) ; { +1 = CRLF }
              fsTextoAEnviar := copy(fsTextoAEnviar,P+2,Length(fsTextoAEnviar)) ;
              fsLinhaAtual   := fsLinhaAtual + 1 ;

              Write( ArqPrn, Linha ) ;
           end ;
           Flush( ArqPrn ) ;
        finally
           {$I-}
           {$IFNDEF FPC}System.{$ENDIF}CloseFile( ArqPrn ) ;
           {$I+}
        end ;
     end ;
  end ;
  
  Terminate ;
end;


{------------------------------ TACBrThreadTimer ------------------------------}
constructor TACBrThreadTimer.Create ;
begin
  inherited Create( true );   { CreateSuspended }

  fsInterval := 0 ;
  fsEnabled  := false ;
  fsOnTimer  := nil ;
end;

procedure TACBrThreadTimer.Execute;
begin                              
  while not Terminated do
  begin
     Sleep( fsInterval );

     if fsEnabled and Assigned( fsOntimer ) then
      {$IFNDEF CONSOLE}
        Synchronize( ChamarEvento ) 
      {$ELSE}
        fsOnTimer( self )
      {$ENDIF}
     else
        Sleep( 100 );
  end ;
end;

procedure TACBrThreadTimer.ChamarEvento;
begin
  fsOnTimer( self ) ;
end;

procedure TACBrThreadTimer.SetEnabled(const Value: Boolean);
begin
  if fsEnabled = Value then exit ;

  fsEnabled := Value;

  if Value then
   begin
     if Suspended then Resume ;
   end
  else
    {$IFNDEF CONSOLE}
     if not Suspended then Suspend ;
    {$ENDIF}
end;

procedure TACBrThreadTimer.SetInterval(const Value: Integer);
begin
  fsInterval := Value;
  if Value = 0 then
     Enabled := false ;
end;

end.

