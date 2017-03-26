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
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 19/05/2004: Primeira Versao
|*    Daniel Simoes de Almeida
|*    Cria�ao e Distribui�ao da Primeira Versao
|* 28/06/2004: Varias modifica�oes. Documentado em ACBrECF.pas ou
|*    ACBr-change-log.txt
|* 05/05/2006: Daniel Simoes de Almeida e Fabio Farias
|*  - Corriga a Perda de foco da aplica��o quando usando ExibeMensagem ou
|*    BloqueiaMouseTeclado  (abertura da janela ShowModal )
|* 23/05/2006:  Daniel Simoes de Almeida
|*   - M�todos "ListaRelatorioGerencial" e "ListaCupomVinculado" abstraidos
|*     pela classe TACBrECFClass... eliminando v�rias linhas de c�digo nas
|*     classes filhas
|* 03/10/2006:  Daniel Simoes de Almeida
|*   - Corrigido Bug no m�todo FormMsgDoProcedure (usado p/ bloqueio do teclado)
|*     A pilha de retorno das Exce��es n�o era executada corretamente
|* 18/12/2006:  J. Lu�s Schiavo
|*  - Corrigido Bug em DoOnMsgRetentar, Resposta com sinal invertido
|* 13/04/2007:  Daniel Simoes de Almeida
|*  - ArredondaPorQtd n�o ser� executado caso o ValorTotal com a Qtd acrescida
|*    fique superior ao Valor Arredondado pretendido. Isso pode ocorrer se o
|*    Pre�o Unit�rio � grande... nesses casos n�o h� como ajustar... :-(
|* 05/03/2008:  Daniel Simoes de Almeida / Alexsander Rosa
|*  - Metodos AchaFPGDescricao e AchaCNFDescricao fazem busca por String usando
|*    o mesmo tamanho da String informada em Descricao
******************************************************************************}

{$I ACBr.inc}

Unit ACBrECFClass ;

interface
uses ACBrBase,
     SysUtils , Classes, Contnrs
     {$IFNDEF CONSOLE}
       {$IFDEF VisualCLX},
         {$IFDEF QT3CLX} QtLibrary, QtSignalHooks {$ELSE} Qt {$ENDIF},
          QControls, QForms, QGraphics, QDialogs, QExtCtrls
       {$ENDIF}
       {$IFDEF VCL}
          , Controls, Forms, Graphics, Dialogs, ExtCtrls
       {$ENDIF}
     {$ENDIF} ;

const
  cTempoInicioMsg = 3 ;  { Tempo para iniciar a exibi�ao da mensagem
                           'Aguardando a Resposta da Impressora' }
  cMsgAguardando  = 'Aguardando a resposta da Impressora: %d segundos' ;
  cMsgTrabalhando = 'Impressora est� trabalhando' ;
  cMsgPoucoPapel  = 30 ; {Exibe alerta de Pouco Papel somente a cada 30 segundos}
  cMsgRelatorio   = 'Imprimindo %s  %d� Via ' ;
  cPausaRelatorio = 5 ;
  cMsgPausaRelatorio = 'Destaque a %d� via, <ENTER> proxima, %d seg.';
  cLinhasEntreCupons = 7 ;
  cIntervaloAposComando = 100 ; { Tempo em milisegundos a esperar apos o
                                   termino de EnviaComando }

type

EACBrECFErro            = class(Exception) ;
EACBrECFCMDInvalido     = class(EACBrECFErro) ;
EACBrECFSemResposta     = class(EACBrECFErro) ;
EACBrECFNaoInicializado = class(EACBrECFErro) ;
EACBrECFOcupado         = class(EACBrECFErro) ;

{ Definindo novo tipo para armazenar Aliquota de ICMS }
TACBrECFAliquota = class
 private
    fsIndice: String;
    fsAliquota: Double ;
    fsTipo: Char;
    fsTotal: Double;
    fsSequencia: Byte;
    procedure SetTipo(const Value: Char);
 public
    constructor create ;
    property Sequencia : Byte   read fsSequencia write fsSequencia ;
    property Indice    : String read fsIndice    write fsIndice ;
    property Aliquota  : Double read fsAliquota  write fsAliquota ;
    property Tipo      : Char read fsTipo write SetTipo ;
    property Total     : Double read fsTotal write fsTotal ;
end;

{ Lista de Objetos do tipo TACBrECFAliquota }
TACBrECFAliquotas = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrECFAliquota);
    function GetObject (Index: Integer): TACBrECFAliquota;
    procedure Insert (Index: Integer; Obj: TACBrECFAliquota);
  public
    function Add (Obj: TACBrECFAliquota): Integer;
    property Objects [Index: Integer]: TACBrECFAliquota
      read GetObject write SetObject; default;
  end;

{ Definindo novo tipo para armazenar as Formas de Pagamento }
TACBrECFFormaPagamento = class
 private
    fsIndice: String;
    fsDescricao: String;
    fsPermiteVinculado: Boolean;
    fsTotal: Double;
 public
    constructor create ;
    property Indice    : String read fsIndice    write fsIndice ;
    property Descricao : String read fsDescricao write fsDescricao ;
    property PermiteVinculado : Boolean read fsPermiteVinculado
                                       write fsPermiteVinculado ;
    property Total : Double read fsTotal write fsTotal ;
end;

{ Lista de Objetos do tipo TACBrECFFormaPagamento }
TACBrECFFormasPagamento = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrECFFormaPagamento);
    function GetObject (Index: Integer): TACBrECFFormaPagamento;
  public
    function Add (Obj: TACBrECFFormaPagamento): Integer;
    procedure Insert (Index: Integer; Obj: TACBrECFFormaPagamento);
    property Objects [Index: Integer]: TACBrECFFormaPagamento
      read GetObject write SetObject; default;
  end;

{ Definindo novo tipo para armazenar as unidades de Medida }
TACBrECFUnidadeMedida = class
 private
    fsIndice: String;
    fsDescricao: String;
 public
    constructor create ;
    property Indice    : String read fsIndice    write fsIndice ;
    property Descricao : String read fsDescricao write fsDescricao ;
end;

{ Lista de Objetos do tipo TACBrECFunidadeMedida }
TACBrECFUnidadesMedida = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrECFUnidadeMedida);
    function GetObject (Index: Integer): TACBrECFUnidadeMedida;
  public
    function Add (Obj: TACBrECFUnidadeMedida): Integer;
    procedure Insert (Index: Integer; Obj: TACBrECFUnidadeMedida);
    property Objects [Index: Integer]: TACBrECFUnidadeMedida
      read GetObject write SetObject; default;
  end;

{ Definindo novo tipo para armazenar os Comprovantes NAO Fiscais (CNF) }
TACBrECFComprovanteNaoFiscal = class
 private
    fsIndice: String;
    fsDescricao: String;
    fsPermiteVinculado: Boolean;
    fsFormaPagamento: String;
    fsTotal: Double ;
    fsContador: Integer;
 public
    constructor create ;
    property Indice    : String read fsIndice    write fsIndice ;
    property Descricao : String read fsDescricao write fsDescricao ;
    property PermiteVinculado : Boolean read fsPermiteVinculado
                                       write fsPermiteVinculado ;
    property FormaPagamento : String read fsFormaPagamento
                                    write fsFormaPagamento ;
    property Total    : Double  read fsTotal    write fsTotal ;
    property Contador : Integer read fsContador write fsContador;
 end;

TACBrECFConsumidor = class
 private
    fsNome: String;
    fsEndereco: String;
    fsDocumento: String;
    fsEnviado: Boolean;
    function GetEnviado: Boolean;
    function GetAtribuido: Boolean;
 public
    constructor create ;
    property Enviado   : Boolean read GetEnviado write fsEnviado ;
    property Nome      : String  read fsNome ;
    property Endereco  : String  read fsEndereco ;
    property Documento : String  read fsDocumento  ;
    property Atribuido : Boolean read GetAtribuido ;

    procedure AtribuiConsumidor(CPF_CNPJ, Nome, Endereco: String);
    procedure Zera;
end ;


{ Lista de Objetos do tipo TACBrECFComprovanteNaoFiscal }
TACBrECFComprovantesNaoFiscais = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrECFComprovanteNaoFiscal);
    function GetObject (Index: Integer): TACBrECFComprovanteNaoFiscal;
  public
    function Add (Obj: TACBrECFComprovanteNaoFiscal): Integer;
    procedure Insert (Index: Integer; Obj: TACBrECFComprovanteNaoFiscal);
    property Objects [Index: Integer]: TACBrECFComprovanteNaoFiscal
      read GetObject write SetObject; default;
  end;

{ Evento para o usu�rio exibir os erros encontrados pela classe TACBrECFClass.
  Se o evento OnMsgErro NAO for programado a Classe TACBrECFClass exibir� as
  Msg de erro atrav�s de Exce�oes. Se o evento OnMsgErro for programado a Classe
  nao exibe nenhuma msg de erro, que deverao ser tratados dentro deste evento }
TACBrECFExibeErroEvent = procedure(Erro : Exception) of object ;

{ Evento para enviar as msg de Aguarde para o Componente  }
TACBrECFMsgAguarde = procedure(const Mensagem : String) of object ;

{ Evento para enviar mensagem de Retentar para o Componente }
TACBrECFMsgRetentar = procedure(const Mensagem : String;
   const Situacao : String; var Result : Boolean) of object ;

{ Evento disparado quando o componente adicionar algo em MemoBobina  }
TACBrECFBobinaAdicionaLinhas = procedure(const Linhas : String;
   const Operacao : String) of object ;

TACBrFormMsgProcedure = procedure of object ;

TACBrFormMsgEstado = (fmsNenhum, fmsProcessando, fmsConcluido, fmsAbortado) ;

{ Classe generica de ECF, nao implementa nenhum modelo especifico, apenas
  declara a Classe. NAO DEVE SER INSTANCIADA. Usada apenas como base para
  as demais Classes de ECF como por exemplo a classe TACBrECFBematech  }

{ Nota sobre procimentos e fun��es VIRTUAL. Essas fun�oes/procedimentos PODEM
  ou NAO ser implementados nas Classes filhas com a clausula OVERRIDE. Se n�o
  forem implementadas nas classes filhas, a fun�ao/procedimento definida aqui
  nessa classe (TACBrECFClass) e que ser� execuada }

TACBrECFClass = class
 private
    fsRetentar     : Boolean;

    fsBloqueiaMouseTeclado: Boolean;
    fsExibeMensagem: Boolean;
    fsTempoInicioMsg: Integer;
    fsIntervaloAposComando: Integer ;
    fsMsgAguarde: String;
    fsMsgTrabalhando: String;
    fsMsgRelatorio : String;
    fsPausaRelatorio : Integer ;
    fsLinhasEntreCupons : Integer ;
    fsMsgPausaRelatorio : String ;
    fsMsgPoucoPapel: Integer;
    fsDescricaoGrande: Boolean;
    fsOnMsgErro    : TACBrECFExibeErroEvent ;
    fsOnMsgAguarde : TACBrECFMsgAguarde ;
    fsAguardandoResposta: Boolean;
    fsOnAguardandoRespostaChange: TNotifyEvent;
    fsOnMsgPoucoPapel: TNotifyEvent;
    fsOnMsgRetentar : TACBrECFMsgRetentar ;
    fsOperador: String;
    fsBytesRec : Integer ;
    fsAguardaImpressao: Boolean;

    {$IFNDEF CONSOLE}
      fsFormMsg: TForm ;           { Form para exibir Msgs de Aguarde... }
      fsFormMsgFont  : TFont ;
      fsFormMsgColor : TColor ;
      fsFormMsgProcedureAExecutar : TACBrFormMsgProcedure ;
      fsFormMsgTeclaParaFechar    : Word ;
      fsFormMsgEstado             : TACBrFormMsgEstado ;
      fsFormMsgControla : Boolean ;
      fsFormMsgException: String  ;
    {$ENDIF}

    fsRelatorio : TStrings ;
    fsVias      : Word ;

    procedure SetAtivo(const Value: Boolean);
    procedure SetTimeOut(const Value: Integer);
    function GetTimeOut: Integer;

    procedure ErroAbstract( NomeProcedure : String ) ;
    function GetAliquotas: TACBrECFAliquotas;
    function GetFormasPagamentos: TACBrECFFormasPagamento;
    procedure SetAguardandoResposta(const Value: Boolean);
    function GetComprovantesNaoFiscais: TACBrECFComprovantesNaoFiscais;
    function GetUnidadesMedida: TACBrECFUnidadesMedida;

    {$IFNDEF CONSOLE}
      procedure FormMsgTimer(Sender: TObject);
      procedure FormMsgCloseQuery(Sender: TObject; var CanClose: Boolean);
      procedure FormMsgKeyPress(Sender: TObject; var Key: Char);

      {$IFDEF VisualCLX}
       procedure FormMsgEvent(Sender: QObjectH; Event: QEventH;
         var Handled: Boolean);
      {$ENDIF}
      {$IFDEF LINUX}
       {$IFNDEF FPC}
        procedure FormShow(Sender: TObject);
       {$ENDIF}
      {$ENDIF}
      function FormMsgExibe : Boolean;
    {$ENDIF}

    procedure DoLeResposta ;
    procedure DoRelatorioGerencial ;
    procedure DoCupomVinculado ;

 Protected
    fpDevice : TACBrDevice ;
    fpOwner  : TComponent ;   { Componente ACBrECF }
    fpAtivo  : Boolean ;
    fpColunas: Integer;
    fpRFDID  : String;
    fpModeloStr: String;
    fpComandoEnviado: String;
    fpRespostaComando: String;
    fpUltimaMsgPoucoPapel : TDateTime ;
    fpEstado: TACBrECFEstado;
    fpArredondaPorQtd: Boolean;
    fpDecimaisPreco: Integer;
    fpDecimaisQtd: Integer;
    fpArqLOG: String;
    fpComandoLOG: String;
    fpMFD: Boolean;
    fpTermica: Boolean;

    { Cole�ao de objetos TACBrECFAliquota }
    fpAliquotas: TACBrECFAliquotas;
    { Cole�ao de objetos TACBrECFFormasPagamento }
    fpFormasPagamentos : TACBrECFFormasPagamento;
    { Cole�ao de objetos TACBrECFFormasPagamento }
    fpComprovantesNaoFiscais : TACBrECFComprovantesNaoFiscais;
    { Cole�ao de objetos TACBrECFUnidadesMedida}
    fpUnidadesMedida : TACBrECFUnidadesMedida;

    fpConsumidor : TACBrECFConsumidor ;

    procedure GeraErro( E : Exception ) ;

    function GetModeloStr: String; virtual ;
    function GetDataHora: TDateTime; virtual ;
    function GetNumCupom: String; virtual ;
    function GetNumECF: String; virtual ;
    function GetNumLoja: String; virtual ;
    function GetNumSerie: String; virtual ;
    function GetNumVersao: String ; virtual ;
    function GetSubTotal: Double; virtual ;
    function GetTotalPago: Double; virtual ;

    function GetCNPJ: String; virtual ;
    function GetIE: String; virtual ;
    function GetDataMovimento: TDateTime; virtual ;
    function GetGrandeTotal: Double; virtual ;
    function GetNumCRO: String; virtual ;
    function GetNumCCF: String; virtual ;
    function GetNumGNF: String; virtual ;
    function GetNumGRG: String; virtual ;
    function GetNumCDC: String; virtual ;
    function GetNumCRZ: String; virtual ;
    function GetVendaBruta: Double; virtual ;
    function GetTotalAcrescimos: Double; virtual ;
    function GetTotalCancelamentos: Double; virtual ;
    function GetTotalDescontos: Double; virtual ;
    function GetTotalSubstituicaoTributaria: Double; virtual ;
    function GetTotalNaoTributado: Double; virtual ;
    function GetTotalIsencao: Double; virtual ;
    function GetTotalNaoFiscal: Double; virtual ;
    function GetNumCOOInicial: String; virtual ;
    function GetNumUltimoItem: Integer; virtual ;

    function GetDadosUltimaReducaoZ: String; Virtual ;

    function GetEstado: TACBrECFEstado; virtual ;
    function GetGavetaAberta: Boolean; virtual ;
    function GetPoucoPapel : Boolean; virtual ;
    function GetHorarioVerao: Boolean; virtual ;
    function GetArredonda: Boolean; virtual ;
    function GetChequePronto: Boolean; virtual ;

    Function EnviaComando_ECF( cmd : String ) : String ; virtual ;

    procedure LeResposta ; virtual ;
    function TransmiteComando( Cmd : String ) : Boolean ; virtual ;

    function VerificaFimLeitura(var Retorno:String; var TempoLimite: TDateTime) : Boolean ; virtual ;
    function VerificaFimImpressao(var TempoLimite: TDateTime) : Boolean ; virtual ;
    Procedure VerificaEmLinha( TimeOut : Integer = 3) ; virtual ;

    procedure ListaRelatorioGerencial(Relatorio : TStrings; Vias : Integer = 1);
       virtual ;
    Procedure ListaCupomVinculado( Relatorio : TStrings; Vias : Integer = 1) ;
       virtual ;
    procedure PausarRelatorio( Via : Integer) ;

    procedure DoOnMsgPoucoPapel( Mensagem : String = '') ;
    Function DoOnMsgRetentar( const Mensagem : String;
       const Situacao : String = '') : Boolean ;

    procedure ImprimirLinhaALinha( Texto, Cmd : String ) ;
    procedure GravaLog(AString: String; Traduz :Boolean = False);
 public
    Constructor create( AOwner : TComponent ) ;
    Destructor Destroy  ; override ;

    Property Ativo  : Boolean read fpAtivo write SetAtivo ;
    procedure Ativar ; virtual ;
    procedure Desativar ; virtual ;

    property ArredondaPorQtd : Boolean read fpArredondaPorQtd
       write fpArredondaPorQtd ;
    property DecimaisPreco : Integer read fpDecimaisPreco
       write fpDecimaisPreco default 3 ;
    property DecimaisQtd : Integer read fpDecimaisQtd
       write fpDecimaisQtd default 3 ;
    property ArqLOG : String read fpArqLOG write fpArqLOG ;
    property ComandoLOG : String read fpComandoLOG write fpComandoLOG ;
    property AguardaImpressao : Boolean read fsAguardaImpressao
       write fsAguardaImpressao ;

    {$IFNDEF CONSOLE}
      function FormMsgDoProcedure( AProcedure : TACBrFormMsgProcedure;
         TeclaParaFechar : Word) : Boolean ;
      procedure FormMsgPinta( Texto : String ) ;
      property FormMsgEstado   : TACBrFormMsgEstado read fsFormMsgEstado ;
      property FormMsgControla : Boolean read fsFormMsgControla write fsFormMsgControla ;
    {$ENDIF}
    
    { Proriedades de uso interno, configurando o funcionamento da classe,
      atribuidas pelo Objeto TACBrECF dono dessa classe }
//    property OnMsgErro : TACBrECFExibeErroEvent read  fpOnMsgErro
//                write fpOnMsgErro ;
    property OnMsgAguarde : TACBrECFMsgAguarde
        read  fsOnMsgAguarde write fsOnMsgAguarde ;
    property OnAguardandoRespostaChange : TNotifyEvent
        read fsOnAguardandoRespostaChange write fsOnAguardandoRespostaChange ;
    property OnMsgPoucoPapel : TNotifyEvent
        read fsOnMsgPoucoPapel write fsOnMsgPoucoPapel ;
    property OnMsgRetentar : TACBrECFMsgRetentar
        read  fsOnMsgRetentar write fsOnMsgRetentar ;

    Property TimeOut  : Integer read GetTimeOut write SetTimeOut ;
    Property Retentar : Boolean read fsRetentar write fsRetentar ;

    property BloqueiaMouseTeclado : Boolean read  fsBloqueiaMouseTeclado
                                            write fsBloqueiaMouseTeclado ;
    property Operador   : String  read fsOperador   write fsOperador ;
    property MsgAguarde : String  read fsMsgAguarde write fsMsgAguarde ;
    property MsgTrabalhando : String read fsMsgTrabalhando write fsMsgTrabalhando ;
    property MsgRelatorio : String  read fsMsgRelatorio write fsMsgRelatorio ;
    property PausaRelatorio : Integer read fsPausaRelatorio
                write fsPausaRelatorio ;
    property LinhasEntreCupons : Integer read fsLinhasEntreCupons
                write fsLinhasEntreCupons ;
    property MsgPausaRelatorio : String  read fsMsgPausaRelatorio
                write fsMsgPausaRelatorio ;
    property ExibeMensagem : Boolean read fsExibeMensagem write fsExibeMensagem ;
    property TempoInicioMsg : Integer read  fsTempoInicioMsg
                                      write fsTempoInicioMsg ;
    Property IntervaloAposComando : Integer read  fsIntervaloAposComando
                                            write fsIntervaloAposComando ;
    property MsgPoucoPapel : Integer read  fsMsgPoucoPapel
                                     write fsMsgPoucoPapel  ;
    property DescricaoGrande : Boolean read fsDescricaoGrande
                                      write fsDescricaoGrande ;

    { Proriedades ReadOnly }
    Property Colunas  : Integer read fpColunas  ;
    Property ModeloStr: String  read GetModeloStr ;
    Property RFDID    : String  read fpRFDID ;
    Property AguardandoResposta : Boolean read fsAguardandoResposta
       write SetAguardandoResposta ;
    { String com Comando exatamente como foi enviado para impressora }
    Property ComandoEnviado : String read fpComandoEnviado
       write fpComandoEnviado ;
    { String com a Resposta Completa da Impressora (sem tratamentos) }
    Property RespostaComando : String read fpRespostaComando
       write fpRespostaComando ;
    
    { Propriedades relacionadas aos dados do ECF }
    { ECF - Variaveis }
    Property DataHora  : TDateTime read GetDataHora  ;
    Property NumCupom  : String    read GetNumCupom  ;
    Property NumLoja   : String    read GetNumLoja   ;
    Property NumECF    : String    read GetNumECF    ;
    Property NumSerie  : String    read GetNumSerie  ;
    Property NumVersao : String    read GetNumVersao ;

    { Dados da Reducao Z - Registro 60M }
    Property DataMovimento      : TDateTime  read GetDataMovimento ;
    Property CNPJ               : String     read GetCNPJ ;
    Property IE                 : String     read GetIE ;
    Property NumCRZ             : String     read GetNumCRZ ;
    Property NumCRO             : String     read GetNumCRO ;
    Property NumCCF             : String     read GetNumCCF ;
    Property NumGNF             : String     read GetNumGNF ;
    Property NumGRG             : String     read GetNumGRG ;
    Property NumCDC             : String     read GetNumCDC ;
    Property NumCOOInicial      : String     read GetNumCOOInicial ;
    Property VendaBruta         : Double     read GetVendaBruta ;
    Property GrandeTotal        : Double     read GetGrandeTotal ;
    Property TotalCancelamentos : Double     read GetTotalCancelamentos ;
    Property TotalDescontos     : Double     read GetTotalDescontos ;
    Property TotalAcrescimos    : Double     read GetTotalAcrescimos ;
    Property TotalSubstituicaoTributaria : Double
       read GetTotalSubstituicaoTributaria ;
    Property TotalNaoTributado  : Double     read GetTotalNaoTributado ;
    Property TotalIsencao       : Double     read GetTotalIsencao ;
    Property NumUltItem         : Integer    read GetNumUltimoItem ;
    Property TotalNaoFiscal     : Double     read GetTotalNaoFiscal ;

    Property DadosUltimaReducaoZ : String    read GetDadosUltimaReducaoZ ;

    { Aliquotas de ICMS }
    procedure CarregaAliquotas ; virtual ;
    procedure LerTotaisAliquota ; virtual ;
    Property Aliquotas : TACBrECFAliquotas read GetAliquotas ;
    function AchaICMSAliquota( Aliquota : Double; Tipo : Char = ' ' ) :
       TACBrECFAliquota ;  overload ; virtual;
    function AchaICMSAliquota( var AliquotaICMS : String ) :
       TACBrECFAliquota ;  overload ; virtual;
    function AchaICMSIndice( Indice : String ) : TACBrECFAliquota ; virtual ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; virtual ;

    { Formas de Pagamento }
    procedure CarregaFormasPagamento ; virtual ;
    procedure LerTotaisFormaPagamento ; virtual ;
    Property FormasPagamento : TACBrECFFormasPagamento read GetFormasPagamentos;
    function AchaFPGDescricao( Descricao : String ) : TACBrECFFormaPagamento ;
       virtual ;
    function AchaFPGIndice( Indice : String ) : TACBrECFFormaPagamento ;
       virtual ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; virtual ;

    { Comprovantes Nao Fiscais (CNF) }
    procedure CarregaComprovantesNaoFiscais ; virtual ;
    procedure LerTotaisComprovanteNaoFiscal ; virtual ;
    Property ComprovantesNaoFiscais : TACBrECFComprovantesNaoFiscais
       read GetComprovantesNaoFiscais ;
    function AchaCNFDescricao( Descricao : String ) :
       TACBrECFComprovanteNaoFiscal ; virtual ;
    function AchaCNFIndice( Indice : String ) : TACBrECFComprovanteNaoFiscal ;
       virtual ;
    function AchaCNFFormaPagamento( CodFPG : String ) :
       TACBrECFComprovanteNaoFiscal ; virtual ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; virtual ;

    { Unidades de Medida (UMD) }
    procedure CarregaUnidadesMedida ; virtual ;
    Property UnidadesMedida : TACBrECFUnidadesMedida read GetUnidadesMedida;
    function AchaUMDDescricao( Descricao : String ) : TACBrECFUnidadeMedida ;
       virtual ;
    function AchaUMDIndice( Indice : String ) : TACBrECFUnidadeMedida ;
       virtual ;
    Procedure ProgramaUnidadeMedida( var Descricao: String) ; virtual ;

    { ECF - Flags }
    Function EmLinha( lTimeOut : Integer = 1) : Boolean ; virtual ;
    Property PoucoPapel   : Boolean read GetPoucoPapel ;
    Property Estado       : TACBrECFEstado read GetEstado ;
    Property HorarioVerao : Boolean read GetHorarioVerao ;
    Property Arredonda    : Boolean read GetArredonda ;
    Property Termica      : Boolean read fpTermica ;
    Property MFD          : Boolean read fpMFD ;

    { Procedimentos de Cupom Fiscal }
    property Consumidor : TACBrECFConsumidor read fpConsumidor ;
    Procedure AbreCupom ; virtual ;
    Procedure VendeItem( Codigo, Descricao : String; AliquotaECF : String;
       Qtd : Double ; ValorUnitario : Double; ValorDescontoAcrescimo : Double = 0;
       Unidade : String = ''; TipoDescontoAcrescimo : String = '%';
       DescontoAcrescimo : String = 'D' ) ; virtual ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0;
       MensagemRodape : String = '' ) ;
       virtual ;
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : String = ''; ImprimeVinculado : Boolean = false) ;
       virtual ; 
    { Para quebrar linhas nos parametros Observacao use #10 ou chr(10),
      Geralmente o ECF aceita no m�ximo 8 linhas }
    Procedure FechaCupom( Observacao : String = '') ; virtual ;
    Procedure CancelaCupom ; virtual ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; virtual ;
    Property Subtotal  : Double read GetSubTotal ;
    Property TotalPago : Double read GetTotalPago ;

    { Procedimentos de Cupom N�o Fiscal }
    Procedure NaoFiscalCompleto( CodCNF : String; Valor : Double;
       CodFormaPagto  : String; Obs : String ) ; virtual ;
    Procedure AbreNaoFiscal( CPF_CNPJ : String = '') ; virtual ;
    Procedure RegistraItemNaoFiscal( CodCNF : String; Valor : Double;
       Obs : String = '') ; virtual ;
    Procedure SubtotalizaNaoFiscal( DescontoAcrescimo : Double = 0;
       MensagemRodape: String = '') ; virtual ;
    Procedure EfetuaPagamentoNaoFiscal( CodFormaPagto : String; Valor : Double;
       Observacao : String = ''; ImprimeVinculado : Boolean = false) ; virtual ;
    Procedure FechaNaoFiscal( Observacao : String = '') ; virtual ;
    Procedure CancelaNaoFiscal ; virtual ;

    procedure Sangria( const Valor: Double;  Obs : String;
       DescricaoCNF: String; DescricaoFPG: String ) ; virtual ;
    procedure Suprimento( const Valor: Double; Obs : String;
       DescricaoCNF: String; DescricaoFPG: String) ; virtual ;

    { Gaveta de dinheiro }
    Procedure AbreGaveta  ; virtual ;
    Property GavetaAberta : Boolean read GetGavetaAberta ;

    { Relatorios }
    Procedure LeituraX ; virtual ;
    Procedure ReducaoZ( DataHora : TDateTime = 0 ) ; virtual ;
    Procedure RelatorioGerencial(Relatorio : TStrings; Vias : Integer = 1) ;
    Procedure AbreRelatorioGerencial ; virtual ;
    Procedure LinhaRelatorioGerencial( Linha : String ) ; virtual ;

    Procedure CupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double;  Relatorio : TStrings;
       Vias : Integer = 1) ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; virtual ; 
    Procedure LinhaCupomVinculado( Linha : String ) ; virtual ;

    Procedure FechaRelatorio ; virtual ;
    Procedure PulaLinhas( NumLinhas : Integer = 0 ) ; virtual ;
    Procedure CortaPapel( const CorteParcial : Boolean = false) ; virtual ;

    { Cheques }
    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; virtual ;
    Procedure CancelaImpressaoCheque ; virtual ;
    Function LeituraCMC7 : String ; virtual ;
    Property ChequePronto : Boolean read GetChequePronto ;

    { Utilitarios e Diversos }
    Procedure MudaHorarioVerao ; overload ; virtual ;
    Procedure MudaHorarioVerao( EHorarioVerao : Boolean ) ; overload ; virtual ;
    Procedure MudaArredondamento( Arredondar : Boolean ) ; virtual ;
    Procedure PreparaTEF ; virtual ; { Carrega as Formas, de Pagamento e CNF,
                            verifica por Vinculos, etc Particular de cada ECF }
    Procedure CorrigeEstadoErro( Reducao: Boolean = True ) ; virtual ; { Verifica o estado da impressora e
                                              tenta deixar em estado Livre }
    Procedure ImpactoAgulhas( NivelForca : Integer = 2) ; virtual ;
    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime ) ;
       overload ; virtual ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer);
       overload ; virtual ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList ) ; overload ; virtual ;
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal: Integer;
       var Linhas : TStringList ) ; overload ; virtual ;
    Procedure LeituraMFDSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList ) ; overload ; virtual ;
    Procedure LeituraMFDSerial( COOInicial, COOFinal : Integer;
       var Linhas : TStringList ) ; overload ; virtual ;
    Procedure IdentificaOperador(Nome : String); virtual;

    { Retorna a Resposta do ECF }
    Function EnviaComando( cmd : String = '') : String ; overload ;
    { Versao que Permite mudar o TimeOut padrao }
    Function EnviaComando( cmd : String; lTimeOut : Integer): String; overload ;
    { Versao que Permite mudar o TimeOut padrao e o TempoInicioMsg }
    Function EnviaComando( cmd : String; lTimeOut, lTempoInicioMsg : Integer):
       String; overload ; 

    { Gera erro se nao puder abrir Cupom, informando o motivo }
    Function TestaPodeAbrirCupom : Boolean ; virtual ;

end ;

function AjustaLinhas(Texto: String; Colunas: Integer ;
   NumMaxLinhas: Integer = 0; PadLinhas: Boolean = False): String;

implementation
Uses ACBrECF, ACBrUtil, Math,
     {$IFDEF COMPILER6_UP} DateUtils, StrUtils {$ELSE} ACBrD5, QForms, QForms, QForms, QForms, Windows {$ENDIF},
     TypInfo ;

function AjustaLinhas(Texto: String; Colunas: Integer ;
   NumMaxLinhas: Integer = 0; PadLinhas: Boolean = False): String;
Var Count,P : Integer ;
    Linha : String ;
begin
  { Trocando todos os #13+#10 por #10 }
  Texto := StringReplace(Texto,CR+LF,#10,[rfReplaceAll]) ;
  Texto := StringReplace(Texto,sLineBreak,#10,[rfReplaceAll]) ;

  { Ajustando a largura das Linhas para o m�ximo permitido em  "Colunas"
    e limitando em "NumMaxLinhas" o total de Linhas}
  Count  := 0 ;
  Result := '' ;
  while ((Count < NumMaxLinhas) or (NumMaxLinhas = 0)) and
        (Length(Texto) > 0) do
  begin
     P := pos(#10, Texto) ;
     if P > (Colunas + 1) then
        P := Colunas ;
        
     if P = 0 then
        P := min( Length( Texto ), Colunas ) ;

     Linha := TrimRight( copy(Texto,1,P) ) ;  // Remove #10 (se hover)

     if PadLinhas then
        Result := Result + padL( Linha, Colunas) + #10
     else
        Result := Result + Linha + #10 ;

     Inc(Count) ;
     Texto := copy(Texto, P+1, Length(Texto) ) ;
  end ;
end;

{ ---------------------------- TACBrECFAliquotas -------------------------- }

{ TACBrECFAliquota }
constructor TACBrECFAliquota.create;
begin
  fsSequencia:= 0 ;
  fsIndice   := ''  ;
  fsAliquota := 0   ;
  fsTipo     := 'T' ;
  fsTotal    := 0 ;
end;

procedure TACBrECFAliquota.SetTipo(const Value: Char);
  Var NewVar : Char ;
begin
  NewVar := UpCase(Value) ;
  if NewVar = ' ' then
     NewVar := 'T' ;
     
  if not (NewVar in ['T','S']) then
     raise Exception.create('Valores v�lidos para TACBrECFAliquota.Tipo:'+
                            '"T" - ICMS ou "S" - ISS') ;
  fsTipo := Value;
end;

function TACBrECFAliquotas.Add(Obj: TACBrECFAliquota): Integer;
begin
  Result := inherited Add(Obj) ;
  Obj.Sequencia := Count ;
end;

function TACBrECFAliquotas.GetObject(Index: Integer): TACBrECFAliquota;
begin
  Result := inherited GetItem(Index) as TACBrECFAliquota ;
end;

procedure TACBrECFAliquotas.Insert(Index: Integer; Obj: TACBrECFAliquota);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFAliquotas.SetObject(Index: Integer; Item: TACBrECFAliquota);
begin
  inherited SetItem (Index, Item) ;
end;


{ --------------------------- TACBrECFFormasPagamento ---------------------- }

{ TACBrECFFormaPagamento }
constructor TACBrECFFormaPagamento.create;
begin
  fsIndice           := '' ;
  fsDescricao        := '' ;
  fsPermiteVinculado := true ;
  fsTotal            := 0 ;
end;

function TACBrECFFormasPagamento.Add(Obj: TACBrECFFormaPagamento): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrECFFormasPagamento.GetObject( Index: Integer):
   TACBrECFFormaPagamento;
begin
  Result := inherited GetItem(Index) as TACBrECFFormaPagamento ;
end;

procedure TACBrECFFormasPagamento.Insert(Index: Integer;
  Obj: TACBrECFFormaPagamento);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFFormasPagamento.SetObject(Index: Integer;
  Item: TACBrECFFormaPagamento);
begin
  inherited SetItem (Index, Item) ;
end;

{ ----------------------------- TACBrECFConsumidor -------------------------- }
constructor TACBrECFConsumidor.create;
begin
   Zera ;
end;

procedure TACBrECFConsumidor.Zera ;
begin
  fsNome      := '' ;
  fsEndereco  := '' ;
  fsDocumento := '' ;
  fsEnviado   := False ;
end ;

procedure TACBrECFConsumidor.AtribuiConsumidor(CPF_CNPJ, Nome, Endereco: String);
begin
  CPF_CNPJ  := Trim( CPF_CNPJ );
  Nome      := Trim( Nome );
  Endereco  := Trim( Endereco );

  if CPF_CNPJ = '' then
     raise Exception.Create('CPF/CNPJ N�o informado' ) ;

  if (Nome = '') and (Endereco <> '') then
     raise Exception.Create('Para informar o Endere�o � necess�rio informar o Nome' ) ;

  fsDocumento := CPF_CNPJ ;
  fsNome      := TiraAcentos( Nome );
  fsEndereco  := TiraAcentos( Endereco );
  fsEnviado   := False ;
end;

function TACBrECFConsumidor.GetEnviado: Boolean;
begin
  Result := fsEnviado or (not Atribuido) ;
end;

function TACBrECFConsumidor.GetAtribuido: Boolean;
begin
  Result := (fsNome <> '') or (fsEndereco <> '') or (fsDocumento <> '') ;
end;


{ ---------------------- TACBrECFComprovantesNaoFiscais --------------------- }

{ TACBrECFComprovanteNaoFiscal }
constructor TACBrECFComprovanteNaoFiscal.create;
begin
  fsIndice           := '' ;
  fsDescricao        := '' ;
  fsPermiteVinculado := true ;
  fsFormaPagamento   := '' ;
  fsTotal            := 0 ;
  fsContador         := 0 ;
end;

function TACBrECFComprovantesNaoFiscais.Add(
  Obj: TACBrECFComprovanteNaoFiscal): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrECFComprovantesNaoFiscais.GetObject(
  Index: Integer): TACBrECFComprovanteNaoFiscal;
begin
  Result := inherited GetItem(Index) as TACBrECFComprovanteNaoFiscal ;
end;

procedure TACBrECFComprovantesNaoFiscais.Insert(Index: Integer;
  Obj: TACBrECFComprovanteNaoFiscal);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFComprovantesNaoFiscais.SetObject(Index: Integer;
  Item: TACBrECFComprovanteNaoFiscal);
begin
  inherited SetItem (Index, Item) ;
end;

{-------------------------- TACBrECFUnidadesMedida ---------------------------}
Constructor TACBrECFUnidadeMedida.create;
begin
  fsIndice           := '' ;
  fsDescricao        := '' ;
end;

function TACBrECFUnidadesMedida.Add(Obj: TACBrECFUnidadeMedida): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrECFUnidadesMedida.GetObject(
  Index: Integer): TACBrECFUnidadeMedida;
begin
  Result := inherited GetItem(Index) as TACBrECFUnidadeMedida ;
end;

procedure TACBrECFUnidadesMedida.Insert(Index: Integer;
  Obj: TACBrECFUnidadeMedida);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrECFUnidadesMedida.SetObject(Index: Integer;
  Item: TACBrECFUnidadeMedida);
begin
  inherited SetItem (Index, Item) ;
end;

{ ---------------------------- TACBrECFClass ------------------------------ }

constructor TACBrECFClass.create( AOwner : TComponent ) ;
begin
  if not (AOwner is TACBrECF) then
     raise Exception.create('Essa Classe deve ser instanciada por TACBrECF');

  fpOwner := AOwner ;
  
  { Criando ponteiro interno para as Propriedade SERIAL e FORMMSG de ACBrECF,
    para permitir as Classes Filhas o acesso a essas propriedades do Componente}
  fpDevice := (AOwner as TACBrECF).Device ;
  fpDevice.SetDefaultValues ;

  { Criando ponteiro para as propriedade de FormMsg ficarem visiveis nessa Unit }
  {$IFNDEF CONSOLE}
    with (AOwner as TACBrECF) do
    begin
       fsFormMsgFont  := FormMsgFonte ;
       fsFormMsgColor := FormMsgColor ;
    end ;
  {$ENDIF}
  
  { Ajustando variaveis Internas }
  fsRetentar             := true ;
  fsOperador             := '' ;
  fsMsgAguarde           := cMsgAguardando ;
  fsMsgTrabalhando       := cMsgTrabalhando ;
  fsMsgRelatorio         := cMsgRelatorio ;
  fsPausaRelatorio       := cPausaRelatorio ;
  fsLinhasEntreCupons    := cLinhasEntreCupons ;
  fsMsgPausaRelatorio    := cMsgPausaRelatorio ;
  fsTempoInicioMsg       := cTempoInicioMsg ;
  fsIntervaloAposComando := cIntervaloAposComando ;
  fsExibeMensagem        := true ;
  fsBloqueiaMouseTeclado := true ;
  fsMsgPoucoPapel        := cMsgPoucoPapel ;
  fsDescricaoGrande      := false ;
  fsVias                 := 0 ;
  fsRelatorio            := nil ;
  fsBytesRec             := 0 ;
  fsOnAguardandoRespostaChange := nil ;
  fsOnMsgPoucoPapel            := nil ;
  fsAguardandoResposta         := false ;
  fsOnMsgErro                  := nil ;
  fsOnMsgAguarde               := nil ;
  fsOnMsgRetentar              := nil ;

  { Variaveis Protected fp___ acessiveis pelas Classes filhas }
  fpAtivo                 := false ;
  fpEstado                := estNaoInicializada ;
  fpColunas               := 48 ;
  fpRFDID                 := '' ;
  fpModeloStr             := 'N�o Definido' ;
  fpComandoEnviado        := '' ;
  fpRespostaComando       := '' ;
  fpUltimaMsgPoucoPapel   := 0 ;
  fpArredondaPorQtd       := false ;
  fpDecimaisPreco         := 3 ;
  fpDecimaisQtd           := 3 ;
  fpAliquotas             := nil ;
  fpFormasPagamentos      := nil ;
  fpComprovantesNaoFiscais:= nil ;
  fpTermica               := False ;
  fpMFD                   := False ;
  fpArqLOG                := '' ;
  fpComandoLOG            := '' ;

  fpConsumidor := TACBrECFConsumidor.create ;
  
  {$IFNDEF CONSOLE}
    fsFormMsg                   := nil ;
    fsFormMsgProcedureAExecutar := nil ;
    fsFormMsgTeclaParaFechar    := 0 ;
    fsFormMsgEstado             := fmsNenhum ;
    fsFormMsgControla           := true ;
  {$ENDIF}
end;

destructor TACBrECFClass.Destroy;
begin
  Desativar ;
  fpDevice  := nil ; { Apenas remove referencia (ponteiros internos) }

  if Assigned( fpAliquotas ) then
     fpAliquotas.Free ;

  if Assigned( fpFormasPagamentos ) then
     fpFormasPagamentos.Free ;

  if Assigned( fpComprovantesNaoFiscais ) then
     fpComprovantesNaoFiscais.Free ;

 if Assigned( fpUnidadesMedida ) then
    fpUnidadesMedida.Free; 

  fpConsumidor.Free ;

  {$IFNDEF CONSOLE}
    if Assigned( fsFormMsg ) then
       FreeAndNil( fsFormMsg ) ;
  {$ENDIF}

  inherited Destroy ;
end;

procedure TACBrECFClass.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrECFClass.Ativar;
begin
  if fpAtivo then exit ;

  fpDevice.Ativar ;

  fpEstado := estDesconhecido ;
  fpAtivo  := true ;
end;

procedure TACBrECFClass.Desativar;
begin
  if not fpAtivo then exit ;

  fpDevice.Desativar ;

  fpEstado := estNaoInicializada ;
  fpAtivo  := false ;
end;


{------------------------------------------------------------------------------}
function TACBrECFClass.EnviaComando(cmd: String; lTimeOut: Integer): String;
Var wTimeOut : Integer ;
begin
  wTimeOut := TimeOut ;                      { Salvando os valores antigos }
  TimeOut  := max(lTimeOut,wTimeOut) ;       { Novo Valor recebido pelo metodo }

  try
     result := EnviaComando( cmd ) ;
  finally
     TimeOut := wTimeOut ;     { Restaurando valor antigo }
  end ;
end;

function TACBrECFClass.EnviaComando(cmd: String; lTimeOut,
  lTempoInicioMsg: Integer): String;
Var wTimeOut, wTempoInicioMsg : Integer ;
begin
  wTimeOut        := TimeOut ;          { Salvando os valores antigos }
  wTempoInicioMsg := TempoInicioMsg ;

  TimeOut         := max(lTimeOut,wTimeOut) ;   { Novos Valores recebidos pelo metodo }
  TempoInicioMsg  := max(lTempoInicioMsg,wTempoInicioMsg) ;

  try
     result := EnviaComando( cmd ) ;
  finally
     TimeOut        := wTimeOut ;      { Restaurando valores antigos }
     TempoInicioMsg := wTempoInicioMsg ;
  end ;
end;


function TACBrECFClass.EnviaComando(cmd: String = ''): String;
begin
  if (not fpDevice.Ativo) then
     raise EACBrECFNaoInicializado.create(
              'Componente ACBrECF n�o est� Ativo');

  if AguardandoResposta then
     raise EACBrECFOcupado.create('Componente ACBrECF ocupado'+sLineBreak+
                                  '(Aguardando resposta do comando anterior)');
  VerificaEmLinha ;

  try
     fsBytesRec         := 0 ;
     AguardandoResposta := True ;
     try
        GravaLog('-- '+FormatDateTime('hh:nn:ss',now)+' '+fpComandoLOG,True );
        Result := EnviaComando_ECF( Cmd ) ;
     finally
        AguardandoResposta := False ;
        fpComandoLOG       := '' ;
        GravaLog('            TX -> '+fpComandoEnviado, True);
        GravaLog('   '+FormatDateTime('hh:nn:ss',now)+' RX <- '+fpRespostaComando, True);
     end ;
  except
     On E: Exception do
     begin
        GravaLog('----------------- ERRO -----------------' + sLineBreak + 
                 E.Message + sLineBreak +
                 '----------------------------------------' + sLineBreak );
        raise ;
     end ;
  end ;
end;

Procedure TACBrECFClass.GravaLog(AString: String; Traduz :Boolean = False);
Var Buf, Ch : String ;
    I   : Integer ;
    ASC : Byte ;
begin
  if fpArqLOG = '' then
     exit ;

  if not Traduz then
     Buf := AString
  else
   begin
     Buf := '' ;
     For I := 1 to Length(AString) do
     begin
        ASC := Ord(AString[I]) ;

        case ASC of
           2   : Ch := '[STX]' ;
           3   : Ch := '[ETX]' ;
           6   : Ch := '[ACK]' ;
           10  : Ch := '[LF]' ;
           13  : Ch := '[CR]' ;
           27  : Ch := '[ESC]' ;
           255 : Ch := '[FF]' ;
           32..127 : Ch := AString[I] ;
        else ;
          Ch := '['+IntToStr(ASC)+']'
        end;

        Buf := Buf + Ch ;
     end ;
   end ;

  try
     WriteToTXT(fpArqLOG, Buf, True);
  except
  end ;
end ;

function TACBrECFClass.EnviaComando_ECF(cmd: String): String;
begin
  ErroAbstract( 'EnviaComando_ECF' );
end;

{- LE RESPOSTA - Rotina de Leitura da Resposta do ECF com Bloqueio de Teclado -}
procedure TACBrECFClass.LeResposta;
begin
  {$IFNDEF CONSOLE}
    if FormMsgExibe then
       FormMsgDoProcedure( DoLeResposta, 0 )
    else
  {$ENDIF}
     DoLeResposta ;

  if fpRespostaComando = 'ACBrErro' then
  begin
     fpRespostaComando := '' ;
     raise EACBrECFSemResposta.create(
                           'Impressora '+ModeloStr+' n�o est� respondendo') ;
  end ;
end;

procedure TACBrECFClass.DoLeResposta;
Var Fim : Boolean ;
    TempoInicio, TempoLimite : TDateTime ;
    TempoRestante, LenResp : Integer ;
    Texto : String ;
    ProcessaFormMsg : Boolean ;
begin
  try
     fpRespostaComando := '' ;
     {$IFNDEF CONSOLE}
       ProcessaFormMsg := (Assigned( fsFormMsg ) and fsFormMsgControla) ;
     {$ENDIF}
     
     { Calcula Tempo Limite. Espera resposta at� Tempo Limite. Se a resposta
       for Lida antes, j� encerra. Se nao chegar at� TempoLimite, gera erro.}
     TempoLimite := IncSecond( now, TimeOut) ;
     TempoInicio := IncSecond( now, TempoInicioMsg) ;
     Fim := True ;

     { - Le at� atingir a condi�ao descrita na fun�ao VerificaFimLeitura que
         � particular de cada Classe Filha (override)
       - VerificaFimImpressao � necess�rio apenas nos ECFs que respondem
         antes do termino da impressao (Sweda, Bematech, Daruma) }
     repeat
        { Atualizando a Msg no Form }
        {$IFNDEF CONSOLE}
          if ProcessaFormMsg and (now >= TempoInicio) then
          begin
             TempoRestante := SecondsBetween( now, TempoLimite) ;
             
             if (TimeOut - TempoRestante) > 1 then
              begin
                try
                   Texto := Format(MsgAguarde, [ TempoRestante ]) ;
                except
                   Texto := MsgAguarde ;
                end ;
              end
             else
                Texto := MsgTrabalhando ;

             FormMsgPinta( Texto );
          end ;
        {$ENDIF}

        if now > TempoLimite then       { TimeOut }
        begin
           {$IFNDEF CONSOLE}
             if Retentar then
             begin
                if ProcessaFormMsg then
                begin
                   fsFormMsg.Width  := 0 ;  { Escondendo o Form da Msg }
                   fsFormMsg.Height := 0 ;
                end ;

                if DoOnMsgRetentar('A impressora '+ModeloStr+' n�o est� repondendo.',
                    'LerResposta') then
                   TempoLimite := IncSecond( now, TimeOut)  ;
             end ;
           {$ENDIF}

           if now > TempoLimite then      { Respondeu Nao a Retentar }
           begin
              fpRespostaComando := 'ACBrErro' ;
              break ;
           end ;
        end ;

        Fim := True ;
        if not VerificaFimLeitura(fpRespostaComando, TempoLimite) then
         begin
           Fim := False ;
           try
              fpRespostaComando := fpRespostaComando + { Le conteudo da porta }
                                   fpDevice.Serial.RecvPacket(100) ;

              LenResp := Length( fpRespostaComando ) ;
              if LenResp > fsBytesRec then
              begin
                 // ECF est� respondendo, portanto est� trabalhando //
                 TempoLimite := IncSecond(now, TimeOut);
                 fsBytesRec  := LenResp ;
              end ;
           except
              sleep(10) ;
           end ;
         end
        else
           if AguardaImpressao then
           begin
              Fim := VerificaFimImpressao( TempoLimite ) ;

              if not Fim then
                 sleep(200) ;
           end ;

        {$IFNDEF CONSOLE}
          Application.ProcessMessages ;
        {$ENDIF}
     until Fim ;
  finally
     AguardaImpressao := False ;
     if Assigned( fsOnMsgAguarde ) then
        fsOnMsgAguarde( '' ) ;
  end ;
end;

{ Essa fun��o PODE ser override por cada Classe Filha criada
 - Transmite a string do Comando.
   - Se conseguiu retorna True.
   - Se n�o conseguiu e a propriedade Retentar, estiver ligada retorna False,
   - Se Retentar estiver desligada ou respondeu NAO ao Retentar, dispara Excecao}
function TACBrECFClass.TransmiteComando(Cmd: String): Boolean;
begin
  Result := True ;

  try
     fpDevice.Serial.SendString( cmd );   { Eviando o comando }
  except
     if not DoOnMsgRetentar(
       'Comandos n�o est�o sendo enviados para Impressora '+ModeloStr ,
       'TransmitirComando') then
       raise EACBrECFSemResposta.create(
          'Erro ao enviar comandos para a Impressora '+ModeloStr)
     else
        Result := False ;
  end ;
end;


{ Essa fun��o DEVE ser override por cada Classe Filha criada }
function TACBrECFClass.VerificaFimLeitura(var Retorno:String;
   var TempoLimite: TDateTime) : Boolean ;
begin
  raise Exception.Create(
    'Erro Function VerificaFimLeitura n�o implementada em '+ModeloStr);
end;

function TACBrECFClass.VerificaFimImpressao(var TempoLimite: TDateTime): Boolean;
begin
{ Essa fun��o PODE ser override por cada Classe Filha criada
  - Ela � necess�ria apenas para ECFs que respondem antes do termino da
    Impressao como a Sweda, Bematech, Daruma, etc.
  - Substitui a antiga fun��o "EnviaComandoEspera"
  - Para usa-la ative a Propriedade "AguardarImpressao" entes de chamar
    "EnviaComando"
  - IMPORTANTE: N�o � permitido o uso de chamadas EnviaComando dentra dessa
    fun��o, caso constr�rio ela entrar� em chamada Recursiva Infinita }

  Result := EmLinha(1) ;  //  Result := True ;
end;

Procedure TACBrECFClass.VerificaEmLinha( TimeOut : Integer = 3) ;
begin
  while not EmLinha( TimeOut ) do  { Impressora est� em-linha ? }
  begin
     {$IFNDEF CONSOLE}
       if Retentar and
          DoOnMsgRetentar('A impressora '+ModeloStr+' n�o est� pronta.',
                          'VerEmLinha') then
          Continue ;
     {$ENDIF}

     raise EACBrECFSemResposta.create(
             'Impressora '+ModeloStr+' n�o est� em linha') ;
  end ;
end;


function TACBrECFClass.GetTimeOut: Integer;
begin
  Result := fpDevice.TimeOut ;
end;

procedure TACBrECFClass.SetTimeOut(const Value: Integer);
begin
  fpDevice.TimeOut := Value ;
end;

{ Essa fun��o PODE ser override por cada Classe Filha criada }
Function TACBrECFClass.TestaPodeAbrirCupom : Boolean ;
Var Msg : String ;
    Est : TACBrECFEstado ;
begin
  Result := true ;
  Est    := Estado ;

  case Est of
     estRequerX :
        Msg := 'A impressora '+ModeloStr+
               ' requer Leitura X todo inicio de dia.'+#10+
               ' Imprima uma Leitura X para poder vender'  ;
     estRequerZ :
        Msg := 'Redu��o Z de dia anterior n�o emitida.'+#10+
               ' Imprima uma Redu��o Z para poder vender' ;
     estBloqueada :
        Msg := 'Redu�ao Z de hoje j� emitida, ECF bloqueado at� as 00:00' ;
     estVenda :
        Msg := 'Cupom Fiscal aberto' ;
     estNaoInicializada :
        Msg := 'Impressora nao foi Inicializada (Ativo = false)' ;
     estLivre :
        Msg := '' ;
  else ;
     Msg := 'Estado da impressora '+ModeloStr+' � '+sLineBreak+
            GetEnumName(TypeInfo(TACBrECFEstado), integer( Est ) )+
            ' (n�o � Livre)' ;
  end;

  if Msg <> '' then
  begin
     result := false ;
     GeraErro( EACBrECFCMDInvalido.Create( Msg ) );
  end ;
end;

procedure TACBrECFClass.SetAguardandoResposta(const Value: Boolean);
begin
  if Value = fsAguardandoResposta then exit ;

  fsAguardandoResposta := Value;
  if Assigned( fsOnAguardandoRespostaChange ) then
     fsOnAguardandoRespostaChange( self ) ;
end;

procedure TACBrECFClass.GeraErro( E : Exception ) ;
begin
  if Assigned( fsOnMsgErro ) then
     fsOnMsgErro( E )
  else
     raise E ;
end;

function TACBrECFClass.EmLinha( lTimeOut: Integer): Boolean;
begin
  Result := fpDevice.EmLinha( lTimeOut ) ;
end;

function TACBrECFClass.GetDataHora: TDateTime;
begin
  Result := now ;
end;

function TACBrECFClass.GetNumECF: String;
begin
  Result := '001' ;
end;

function TACBrECFClass.GetNumCRO: String;
begin
  Result := '001' ;
end;

function TACBrECFClass.GetNumCCF: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetNumGNF: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetNumGRG: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetNumCDC: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetNumLoja: String;
begin
  Result := '001' ;
end;

function TACBrECFClass.GetNumSerie: String;
begin
  Result := '' ;
end;


{ Essa fun��o DEVE ser override por cada Classe Filha criada }
Procedure TACBrECFClass.AbreGaveta ;
begin
  GeraErro( EACBrECFCMDInvalido.Create(
            'A Impressora '+ModeloStr+' n�o manipula Gavetas'));
end;

{ Essa fun��o DEVE ser override por cada Classe Filha criada }
function TACBrECFClass.GetEstado: TACBrECFEstado;
begin
  Result := fpEstado ;
end;

{ Essa fun��o PODE ser override por cada Classe Filha criada }
function TACBrECFClass.GetGavetaAberta: Boolean;
begin
  Result := false ;
end;

{ Essa fun��o DEVE ser override por cada Classe Filha criada }
function TACBrECFClass.GetPoucoPapel: Boolean;
begin
  Result := false ;
end;

{ Essa fun��o DEVE ser override por cada Classe Filha criada }
function TACBrECFClass.GetArredonda: Boolean;
begin
  Result := false ;
end;

{ Essa fun��o DEVE ser override por cada Classe Filha criada }
function TACBrECFClass.GetHorarioVerao: Boolean;
begin
  Result := false ;
end;

{ Essa fun��o PODE ser override por cada Classe Filha criada }
procedure TACBrECFClass.ImpactoAgulhas( NivelForca : Integer = 2);
begin
  GeraErro( EACBrECFCMDInvalido.Create(
      'A Impressora '+ModeloStr+' n�o permite ajustar o Impacto das Agulhas') );
end;

{ Essa fun��o PODE ser override por cada Classe Filha criada }
procedure TACBrECFClass.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal: Integer);
begin
  ErroAbstract('LeituraMemoriaFiscal');
end;

procedure TACBrECFClass.LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime);
begin
  ErroAbstract('LeituraMemoriaFiscal');
end;

procedure TACBrECFClass.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas : TStringList);
begin
  ErroAbstract('LeituraMemoriaFiscalSerial');
end;

procedure TACBrECFClass.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; var Linhas : TStringList);
begin
  ErroAbstract('LeituraMemoriaFiscalSerial');
end;


procedure TACBrECFClass.LeituraMFDSerial(DataInicial, DataFinal: TDateTime;
  var Linhas: TStringList);
begin
  ErroAbstract('LeituraMFDSerial');
end;

procedure TACBrECFClass.LeituraMFDSerial(COOInicial,
  COOFinal: Integer; var Linhas: TStringList);
begin
  ErroAbstract('LeituraMFDSerial');
end;

{ Essa fun��o PODE ser override por cada Classe Filha criada }
procedure TACBrECFClass.ImprimeCheque(Banco: String; Valor: Double; Favorecido,
  Cidade: String; Data: TDateTime; Observacao: String);
begin
  GeraErro( EACBrECFCMDInvalido.Create(
               'Rotina de Impress�o de Cheques n�o implementada para '+
               'Impressora '+ModeloStr ) );
end;

{ Essa fun��o PODE ser override por cada Classe Filha criada }
Function TACBrECFClass.LeituraCMC7 : String ; 
begin
  GeraErro( EACBrECFCMDInvalido.Create(
               'Rotina de Leitura de CMC7 de Cheques n�o implementada para '+
               'Impressora '+ModeloStr ) );
end;

{ Essa fun��o PODE ser override por cada Classe Filha criada }
procedure TACBrECFClass.CancelaImpressaoCheque;
begin
  ErroAbstract('CancelaImpressaoCheque');
end;

{ Essa fun��o PODE ser override por cada Classe Filha criada }
function TACBrECFClass.GetChequePronto: Boolean;
begin
  result := True ;
end;

procedure TACBrECFClass.CorrigeEstadoErro( Reducao: Boolean );
begin
  case Estado of
     estRequerX : LeituraX ;

     estRequerZ :
       if Reducao then
         try
           ReducaoZ(now);
         except
           try
             CancelaCupom;
             ReducaoZ(now);
           except
           end;
         end;

     estRelatorio : FechaRelatorio ;

     estVenda, estPagamento :  CancelaCupom ;

     estNaoFiscal : CancelaNaoFiscal ;

     estBloqueada : GeraErro( EACBrECFCMDInvalido.Create(
              'Redu�ao Z de hoje j� emitida, ECF bloqueado at� as 00:00' ) );
  end;

  if Estado <> estLivre then
     try
        FechaNaoFiscal ;
     except
     end
  else
     exit ;

  if Estado <> estLivre then
     try
        CancelaNaoFiscal ;
     except
     end 
  else
     exit ;

  if Estado <> estLivre then
     try
        FechaRelatorio ;
     except
     end ;
end;

procedure TACBrECFClass.AbreCupom ;
begin
  ErroAbstract('AbreCupom');
end;

procedure TACBrECFClass.CancelaCupom;
begin
  ErroAbstract('CancelaCupom');
end;

procedure TACBrECFClass.CancelaItemVendido(NumItem: Integer);
begin
  ErroAbstract('CancelaItemVendido');
end;

procedure TACBrECFClass.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
begin
  ErroAbstract('EfetuaPagamento');
end;

procedure TACBrECFClass.FechaCupom(Observacao: String);
begin
  ErroAbstract('FechaCupom');
end;

procedure TACBrECFClass.FechaRelatorio;
begin
  ErroAbstract('FechaRelatorio');
end;

procedure TACBrECFClass.AbreNaoFiscal(CPF_CNPJ: String);
begin
  ErroAbstract('AbreNaoFiscal');
end;

procedure TACBrECFClass.CancelaNaoFiscal;
begin
  CancelaCupom ;
end;

procedure TACBrECFClass.EfetuaPagamentoNaoFiscal(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
begin
  EfetuaPagamento( CodFormaPagto, Valor, Observacao, ImprimeVinculado );
end;

procedure TACBrECFClass.FechaNaoFiscal(Observacao: String);
begin
  FechaCupom(Observacao);
end;

procedure TACBrECFClass.NaoFiscalCompleto(CodCNF: String; Valor: Double;
  CodFormaPagto, Obs: String);
begin
  { Chama rotinas da classe Pai (fpOwner) para atualizar os Memos }
  with TACBrECF(fpOwner) do
  begin
     AbreNaoFiscal ;
     try
        RegistraItemNaoFiscal(CodCNF, Valor);
        SubtotalizaNaoFiscal(0);
        EfetuaPagamentoNaoFiscal(CodFormaPagto, Valor );
        FechaNaoFiscal( Obs );
     except
        try
           CancelaNaoFiscal
        except
        end;

        raise ;
     end ;
  end ;
end;

procedure TACBrECFClass.RegistraItemNaoFiscal(CodCNF: String;
  Valor: Double; Obs: String = '');
begin
  ErroAbstract('RegistraItemNaoFiscal');
end;

procedure TACBrECFClass.SubtotalizaNaoFiscal(DescontoAcrescimo: Double;
   MensagemRodape: String);
begin
  SubtotalizaCupom(DescontoAcrescimo, MensagemRodape);
end;

procedure TACBrECFClass.Sangria( const Valor: Double; Obs,
   DescricaoCNF, DescricaoFPG: String ) ;
 Var CNF : TACBrECFComprovanteNaoFiscal ;
     FPG : TACBrECFFormaPagamento ;
begin
  CNF := AchaCNFDescricao(DescricaoCNF) ;
  if CNF = nil then
     raise Exception.Create('N�o existe nenhum Comprovante N�o Fiscal '+
                            'cadastrado como: "'+DescricaoCNF+'"') ;

  FPG := AchaFPGDescricao(DescricaoFPG) ;
  if FPG = nil then
     raise Exception.Create('N�o existe nenhuma Forma de Pagamento '+
                            'cadastrada como: "'+DescricaoFPG+'"') ;

  NaoFiscalCompleto( CNF.Indice, Valor, FPG.Indice, Obs);
end;

procedure TACBrECFClass.Suprimento( const Valor: Double; Obs,
   DescricaoCNF, DescricaoFPG: String ) ;
begin
  Sangria( Valor, Obs, DescricaoCNF, DescricaoFPG);
end;


procedure TACBrECFClass.PulaLinhas(NumLinhas: Integer);
begin
  if NumLinhas = 0 then
     NumLinhas := LinhasEntreCupons ;

  LinhaRelatorioGerencial( StringOfChar(#10, NumLinhas ) ) ;
end;

procedure TACBrECFClass.CortaPapel(const CorteParcial : Boolean ) ;
begin
  LinhaRelatorioGerencial( #10+#10+#10 ) ;
end;

function TACBrECFClass.GetNumCupom: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetNumVersao: String ;
begin
  Result := ''
end;

function TACBrECFClass.GetSubTotal: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalPago: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetCNPJ: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetIE: String;
begin
  Result := '' ;
end;

function TACBrECFClass.GetDataMovimento: TDateTime;
begin
  Result := now ;
end;

function TACBrECFClass.GetGrandeTotal: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetNumCRZ: String ;
begin
  Result := '00000'
end;

function TACBrECFClass.GetTotalAcrescimos: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalCancelamentos: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalDescontos: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalSubstituicaoTributaria: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalIsencao: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalNaoFiscal: Double;
  Var I : Integer ;
begin
  Result := 0 ;
  try
     LerTotaisComprovanteNaoFiscal ;

     For I := 0 to ComprovantesNaoFiscais.Count-1 do
        Result := Result + ComprovantesNaoFiscais[I].Total ;
  except
  end ;
end;

function TACBrECFClass.GetNumUltimoItem: Integer;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetTotalNaoTributado: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetVendaBruta: Double;
begin
  Result := 0 ;
end;

function TACBrECFClass.GetNumCOOInicial: String;
begin
  Result := ''
end;

function TACBrECFClass.GetDadosUltimaReducaoZ: String;
begin
  ErroAbstract('DadosUltimaReducaoZ');
end;

procedure TACBrECFClass.LeituraX;
begin
  ErroAbstract('LeituraX');
end;

procedure TACBrECFClass.MudaHorarioVerao;
begin
  ErroAbstract('MudaHorarioVerao');
end;

procedure TACBrECFClass.MudaHorarioVerao(EHorarioVerao: Boolean);
begin
  ErroAbstract('MudaHorarioVerao(EHorarioVerao: Boolean)');
end;

procedure TACBrECFClass.MudaArredondamento(Arredondar: Boolean);
begin
  ErroAbstract('MudaArredondamento');
end;

procedure TACBrECFClass.IdentificaOperador(Nome: String);
begin
//  ErroAbstract('IdentificaOperador');
end;


procedure TACBrECFClass.PreparaTEF;
begin
  try
     FechaRelatorio ;
  except
  end ;

  CarregaAliquotas ;
  CarregaFormasPagamento ;
  CarregaComprovantesNaoFiscais ;
end;

procedure TACBrECFClass.ReducaoZ(DataHora: TDateTime);
begin
  ErroAbstract('ReducaoZ');
end;

procedure TACBrECFClass.SubtotalizaCupom(DescontoAcrescimo: Double;
       MensagemRodape : String);
begin
  ErroAbstract('SubtotalizaCupom');
end;

Procedure TACBrECFClass.VendeItem( Codigo, Descricao : String;
  AliquotaECF : String; Qtd : Double ; ValorUnitario : Double;
  ValorDescontoAcrescimo : Double; Unidade : String;
  TipoDescontoAcrescimo : String; DescontoAcrescimo : String) ;
begin
  ErroAbstract('VendeItem');
end;

procedure TACBrECFClass.ErroAbstract(NomeProcedure: String);
begin
  raise EACBrECFCMDInvalido.create('Procedure: '+NomeProcedure + sLineBreak +
        ' n�o implementada para a Impressora: '+ModeloStr +sLineBreak + sLineBreak +
        'Ajude no desenvolvimento do ACBrECF. '+ sLineBreak+
        'Acesse nosso Forum em: http://acbr.sf.net/'  ) ;
end;

function TACBrECFClass.GetModeloStr: String;
begin
  Result := fpModeloStr ;
  if fpMFD then
     Result := Result + ' MFD' ;
end;

procedure TACBrECFClass.DoOnMsgPoucoPapel( Mensagem : String ) ;
begin
  if now > IncSecond(fpUltimaMsgPoucoPapel, MsgPoucoPapel) then { Avisa ? }
  begin
     if Assigned( fsOnMsgPoucoPapel ) then
        fsOnMsgPoucoPapel( self )
     else
      begin
        if Mensagem = '' then
           Mensagem := 'Detectado pouco papel' ;

        {$IFNDEF CONSOLE}
          MessageDlg(Mensagem,mtError,[mbOk],0)  ;
        {$ELSE}
          writeln( Mensagem ) ;
        {$ENDIF}
      end ;

     fpUltimaMsgPoucoPapel := now ;
  end ;
end;

function TACBrECFClass.DoOnMsgRetentar( const Mensagem : String;
   const Situacao : String = ''): Boolean;
begin
  Result := False ;

  if Assigned( fsOnMsgRetentar ) then
     fsOnMsgRetentar( Mensagem, Situacao, Result )
  else
   begin
     {$IFNDEF CONSOLE}
      if Retentar and
        (MessageDlg( Mensagem+sLineBreak+sLineBreak+'Deseja tentar novamente ?',
                     mtConfirmation,[mbYes,mbNo],0) = mrYes) then
        Result := True ;
     {$ENDIF}
   end ;
end;

{ Esta rotina � usada por Impressoras que n�o permitem enviar v�rias
  linhas de uma s� vez }
procedure TACBrECFClass.ImprimirLinhaALinha(Texto, Cmd: String );
Var Linhas : TStringList ;
    I : Integer ;
begin
  if Texto = '' then
     Texto := padL(Texto,Colunas) ;

  Texto := AjustaLinhas( Texto, Colunas );

  Linhas := TStringList.Create ;
  try
     Linhas.Text := Texto ;

     for I := 0 to Linhas.Count-1 do
     begin
        EnviaComando( Cmd + padL( Linhas[I], Colunas), 6 ) ;
        if not fpTermica then
           sleep(100) ;

        { Aguarda 1 segundo ou at� o ECF ficar Em linha novamente }
        { Semelhante ao "AguardaImpressao := True", por�m � mais r�pido, pois no
          m�todo "VerificaFimImpressao" alem de verificado o "EmLinha" tamb�m �
          solicitado o Status do ECF }
        try
           EmLinha( 1 ) ;
        except
        end ;
     end ;
  finally
     Linhas.Free ;
  end ;
end;

{-------------------------------- ALIQUOTAS ----------------------------------}
procedure TACBrECFClass.CarregaAliquotas;
begin
  { Apenas instancia um ObjectList de Aliquotas (TACBrECFAliquotas) vazia }
  if Assigned( fpAliquotas ) then
     fpAliquotas.Free ;

  fpAliquotas := TACBrECFAliquotas.create( true ) ;
end;

procedure TACBrECFClass.LerTotaisAliquota;
begin
  ErroAbstract('LerTotaisAliquota');
end;

procedure TACBrECFClass.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
begin
  ErroAbstract('ProgramaAliquota');
end;

function TACBrECFClass.GetAliquotas: TACBrECFAliquotas;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  result := fpAliquotas ;
end;

function TACBrECFClass.AchaICMSAliquota( var AliquotaICMS: String):
   TACBrECFAliquota;
{   AliquotaICMS, Formatos v�lidos:
  - Por Valor da aliquota, Ex: '18', '12,00' '2,56'
  - Por Valor da Aliquota especificando o Tipo como sufixo
    (T = ICMS, ou S = ISS),      Ex: '18T',  '2,5S'
  - Por Indice, adicione o prefixo 'T', Ex: 'T01', 'T03', 'TA', 'TT01'
    ( o indice deve ser no mesmo formato retornado pela propriedade
      "Aliquotas[n].Indice" (que varia para cada modelo de ECF) )
}
   procedure VerificaTipoAliquota(var AliquotaICMS: String;
     var Tipo: char);
   Var UltDigito : String ;
   begin
     UltDigito := RightStr(AliquotaICMS,1) ;
     case UltDigito[1] of
        'T','S' :
          begin
            Tipo := UltDigito[1] ;
            AliquotaICMS := copy( AliquotaICMS,1,Length(AliquotaICMS)-1 ) ;
          end ;
     else
        Tipo := ' ' ;
     end ;
   end;

   Var AliquotaStr : String ;
       Tipo        : Char ;
       ValAliquota : Double ;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  Result := nil ;

  AliquotaICMS := UpperCase( TrimLeft( AliquotaICMS ) ) ;
  case AliquotaICMS[1] of
    'I' : AliquotaICMS := 'II' ;
    'N' : AliquotaICMS := 'NN' ;
    'F' : AliquotaICMS := 'FF' ;
  else 
     begin
        if AliquotaICMS[1] = 'T' then  { Informou por Indice ? }
         begin
            AliquotaICMS := copy(AliquotaICMS,2,Length(AliquotaICMS)) ; {Remove o "T"}
            Result := AchaICMSIndice( AliquotaICMS ) ;
         end
        else      { Informou por valor }
         begin
           { Verificando se informou T ou S no final da Aliquota (Tipo) }
           AliquotaStr := AliquotaICMS ;
           Tipo        := ' ' ;
           VerificaTipoAliquota( AliquotaStr, Tipo) ;

           try
              ValAliquota := StringToFloat( AliquotaStr ) ;
           except
              raise EACBrECFCMDInvalido.Create('Aliquota inv�lida: '+AliquotaICMS);
           end ;

           Result := AchaICMSAliquota( ValAliquota, Tipo ) ;
         end ;

        if Result = nil then
           raise EACBrECFCMDInvalido.Create('Aliquota n�o encontrada: '+AliquotaICMS)
     end ;
  end ;

  if Result <> nil then
     AliquotaICMS := Result.Indice ;
end;

function TACBrECFClass.AchaICMSAliquota( Aliquota: Double; Tipo : Char ) :
   TACBrECFAliquota;
var A : Integer ;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  if not (Tipo in ['S','T']) then
     Tipo := ' ' ;

  Aliquota := SimpleRoundTo(Aliquota,-2) ; 
  Result   := nil ;
  
  with fpAliquotas do
  begin
     For A := 0 to Count -1 do
     begin
        if ( SimpleRoundTo(Objects[A].Aliquota,-2) = Aliquota) and
           ((Tipo = ' ') or (Tipo = Objects[A].Tipo) ) then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaICMSIndice(Indice: String): TACBrECFAliquota;
var A : Integer ;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  Result := nil ;
  Indice := UpperCase(Indice) ;

  with fpAliquotas do
  begin
     For A := 0 to Count -1 do
     begin
        if UpperCase( Objects[A].Indice ) = Indice then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

{--------------------------- FORMAS DE PAGAMENTO ------------------------------}
procedure TACBrECFClass.CarregaFormasPagamento;
begin
  if Assigned( fpFormasPagamentos ) then
     fpFormasPagamentos.Free ;

  fpFormasPagamentos := TACBrECFFormasPagamento.Create( true ) ;
end;

procedure TACBrECFClass.LerTotaisFormaPagamento;
begin
  ErroAbstract('LerTotaisFormaPagamento');
end;

procedure TACBrECFClass.ProgramaFormaPagamento(var Descricao: String;
  PermiteVinculado: Boolean; Posicao : String);
begin
  ErroAbstract('ProgramaFormaPagamento');
end;

function TACBrECFClass.GetFormasPagamentos: TACBrECFFormasPagamento;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  result := fpFormasPagamentos ;
end;

function TACBrECFClass.AchaFPGDescricao(Descricao: String) :
   TACBrECFFormaPagamento;
 var Tamanho, A : Integer ;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  result := nil ;
  with fpFormasPagamentos do
  begin
     Descricao := Trim(UpperCase( Descricao )) ;
     Tamanho   := Length( Descricao ) ;
     For A := 0 to Count -1 do
     begin
        if LeftStr( UpperCase(Objects[A].Descricao), Tamanho) = Descricao then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaFPGIndice( Indice: String) :
   TACBrECFFormaPagamento;
var A : Integer ;
begin
  if not Assigned( fpFormasPagamentos ) then
     CarregaFormasPagamento ;

  result := nil ;
  with fpFormasPagamentos do
  begin
     For A := 0 to Count -1 do
     begin
        if Objects[A].Indice = Indice then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

{------------------------- COMPROVANTES NAO FISCAIS ---------------------------}
procedure TACBrECFClass.CarregaComprovantesNaoFiscais;
begin
  if Assigned( fpComprovantesNaoFiscais ) then
     fpComprovantesNaoFiscais.Free ;

  fpComprovantesNaoFiscais := TACBrECFComprovantesNaoFiscais.Create( true ) ;
end;

procedure TACBrECFClass.LerTotaisComprovanteNaoFiscal;
begin
  ErroAbstract('LerTotaisComprovanteNaoFiscal');
end;

procedure TACBrECFClass.ProgramaComprovanteNaoFiscal(var Descricao: String;
  Tipo: String; Posicao : String);
begin
  ErroAbstract('ProgramaComprovanteNaoFiscal');
end;

function TACBrECFClass.GetComprovantesNaoFiscais: TACBrECFComprovantesNaoFiscais;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  result := fpComprovantesNaoFiscais ;
end;

function TACBrECFClass.AchaCNFDescricao(
  Descricao: String): TACBrECFComprovanteNaoFiscal;
 var Tamanho, A : Integer ;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  result := nil ;
  with fpComprovantesNaoFiscais do
  begin
     Descricao := Trim(UpperCase( Descricao )) ;
     Tamanho   := Length( Descricao ) ;
     For A := 0 to Count -1 do
     begin
        if LeftStr( UpperCase(Objects[A].Descricao), Tamanho) = Descricao then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaCNFIndice(
  Indice: String): TACBrECFComprovanteNaoFiscal;
var A : Integer ;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  result := nil ;
  with fpComprovantesNaoFiscais do
  begin
     For A := 0 to Count -1 do
     begin
        if Objects[A].Indice = Indice then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaCNFFormaPagamento(
  CodFPG: String): TACBrECFComprovanteNaoFiscal;
var A : Integer ;
begin
  if not Assigned( fpComprovantesNaoFiscais ) then
     CarregaComprovantesNaoFiscais ;

  result := nil ;
  with fpComprovantesNaoFiscais do
  begin
     For A := 0 to Count -1 do
     begin
        if Objects[A].FormaPagamento = CodFPG then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

{---------------------------- UNIDADES DE MEDIDA ------------------------------}
procedure TACBrECFClass.CarregaUnidadesMedida;
begin
  if Assigned( fpUnidadesMedida ) then
     fpUnidadesMedida.Free ;

  fpUnidadesMedida := TACBrECFUnidadesMedida.Create( true ) ;
end;

procedure TACBrECFClass.ProgramaUnidadeMedida(var Descricao: String);
begin
  ErroAbstract('ProgramaUnidadeMedida');
end;

function TACBrECFClass.GetUnidadesMedida: TACBrECFUnidadesMedida;
begin
  if not Assigned( fpUnidadesMedida ) then
     CarregaUnidadesMedida ;

  result := fpUnidadesMedida ;
end;

function TACBrECFClass.AchaUMDDescricao(
  Descricao: String): TACBrECFUnidadeMedida;
var A : Integer ;
begin
  if not Assigned( fpUnidadesMedida ) then
     CarregaUnidadesMedida ;

  result := nil ;
  with fpUnidadesMedida do
  begin
     Descricao := Trim(UpperCase( Descricao )) ;
     For A := 0 to Count -1 do
     begin
        if Trim(UpperCase( Objects[A].Descricao )) = Descricao then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

function TACBrECFClass.AchaUMDIndice( Indice: String): TACBrECFUnidadeMedida;
var A : Integer ;
begin
  if not Assigned( fpUnidadesMedida ) then
     CarregaUnidadesMedida ;

  result := nil ;
  with fpUnidadesMedida do
  begin
     For A := 0 to Count -1 do
     begin
        if Objects[A].Indice = Indice then
        begin
           result := Objects[A] ;
           Break ;
        end ;
     end ;
  end ;
end;

{ ------------------------------ Cupom Vinculado -----------------------------}
procedure TACBrECFClass.CupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double; Relatorio: TStrings;
  Vias: Integer);
Var wRetentar : Boolean ;
begin
  { Chama rotinas da classe Pai (fpOwner) para atualizar os Memos }
  TACBrECF(fpOwner).AbreCupomVinculado( COO, CodFormaPagto, CodComprovanteNaoFiscal, Valor) ;

  wRetentar := Retentar ;
  try
     Retentar    := false ;
     fsVias      := Vias ;
     fsRelatorio := Relatorio ;

     {$IFNDEF CONSOLE}
       if not ExibeMensagem  then
          DoCupomVinculado
       else
        begin
          { Isso far� a procedure LeResposta nao pintar o FormMsgAguarde }
          fsFormMsgControla := false ;
          FormMsgDoProcedure( DoCupomVinculado, 0)
        end ;
     {$ELSE}
       DoCupomVinculado
     {$ENDIF}
  finally
     {$IFNDEF CONSOLE}
       fsFormMsgControla := true ;
     {$ENDIF}
     Retentar := wRetentar ;
  end ;
end;

procedure TACBrECFClass.DoCupomVinculado;
begin
  ListaCupomVinculado( fsRelatorio, fsVias );
end;

procedure TACBrECFClass.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
begin
  ErroAbstract('AbreCupomVinculado');
end;

procedure TACBrECFClass.LinhaCupomVinculado(Linha: String);
begin
  ErroAbstract('LinhaCupomVinculado');
end;

procedure TACBrECFClass.ListaCupomVinculado( Relatorio: TStrings;
  Vias: Integer);
Var Imp   : Integer ;
    Texto : String ;
begin
  Imp := 0 ;

  while Imp < Vias do
  begin
     {$IFNDEF CONSOLE}
       try
          Texto := Format(MsgRelatorio,['Cupom Vinculado',Imp+1 ]) ;
       except
          Texto := MsgRelatorio ;
       end ;

       FormMsgPinta( Texto );
     {$ENDIF}
     TACBrECF(fpOwner).LinhaCupomVinculado( Relatorio.Text ) ;

     Inc(Imp) ;
     if Imp < Vias then
     begin
        TACBrECF(fpOwner).PulaLinhas  ;
        TACBrECF(fpOwner).CortaPapel  ;
        PausarRelatorio( Imp ) ;
     end ;
  end ;

  {$IFNDEF CONSOLE}
    FormMsgPinta( 'Fechando Cupom Vinculado' );
  {$ENDIF}
  TACBrECF(fpOwner).FechaRelatorio ;
end;

{ ------------------------------ Relatorio Gerencial -------------------------}
procedure TACBrECFClass.RelatorioGerencial(Relatorio: TStrings; Vias: Integer);
Var wMsgAguarde : String ;
    wRetentar : Boolean ;
begin
  { Chama rotinas da classe Pai (fpOwner) para atualizar os Memos }
  try
     TACBrECF(fpOwner).FechaRelatorio ; { Fecha se ficou algum aberto }
  Except
  end ;

  wMsgAguarde := MsgAguarde ;
  MsgAguarde  := 'Abrindo Relat�rio Gerencial, aguarde %d seg' ;
  try
     TACBrECF(fpOwner).AbreRelatorioGerencial ;
  finally
     MsgAguarde := wMsgAguarde ;
  end ;

  wRetentar := Retentar ;
  try
     Retentar    := false ;
     fsVias      := Vias ;
     fsRelatorio := Relatorio ;

     {$IFNDEF CONSOLE}
       if not ExibeMensagem  then
         DoRelatorioGerencial
       else
        begin
          { Isso far� a procedure LeResposta nao pintar o FormMsgAguarde }
          fsFormMsgControla := false ;
          FormMsgDoProcedure(DoRelatorioGerencial,0) ;
        end ;
     {$ELSE}
       DoRelatorioGerencial ;
     {$ENDIF}
  finally
     {$IFNDEF CONSOLE}
       fsFormMsgControla := true ;
     {$ENDIF}
     Retentar := wRetentar ;
  end ;
end;

procedure TACBrECFClass.DoRelatorioGerencial;
begin
   ListaRelatorioGerencial( fsRelatorio, fsVias )
end;

procedure TACBrECFClass.AbreRelatorioGerencial;
begin
  ErroAbstract('AbreRelatorioGerencial');
end;

procedure TACBrECFClass.LinhaRelatorioGerencial(Linha: String);
begin
  ErroAbstract('LinhaRelatorioGerencial');
end;

procedure TACBrECFClass.ListaRelatorioGerencial(Relatorio: TStrings;
  Vias: Integer);
Var Imp   : Integer ;
    Texto : String ;
begin
  Imp := 0 ;

  while Imp < Vias do
  begin
     try
        Texto := Format(MsgRelatorio,['Relat�rio Ger�ncial',Imp+1 ]) ;
     except
        Texto := MsgRelatorio ;
     end ;

     {$IFNDEF CONSOLE}
       FormMsgPinta( Texto );
     {$ENDIF}
     TACBrECF(fpOwner).LinhaRelatorioGerencial( Relatorio.Text ) ;

     Inc(Imp) ;
     if Imp < Vias then
     begin
        TACBrECF(fpOwner).PulaLinhas ;
        TACBrECF(fpOwner).CortaPapel ;
        PausarRelatorio( Imp ) ;
     end ;
  end ;

  {$IFNDEF CONSOLE}
    FormMsgPinta( 'Fechando Relat�rio Gerencial' );
  {$ENDIF}
  TACBrECF(fpOwner).FechaRelatorio ;
end;

{ ------------------------------ Pausar Relatorios -------------------------}
procedure TACBrECFClass.PausarRelatorio( Via : Integer );
Var Texto : String ;
    SecRest, SecAnt : Integer ;
    FimPausa : TDateTime ;
begin

  Try
     FimPausa := IncSecond( now, PausaRelatorio ) ;
     SecAnt := 0 ;
     {$IFNDEF CONSOLE}
       fsFormMsgTeclaParaFechar := 13 ;
     {$ENDIF}

     while (now < FimPausa) do
     begin
       {$IFNDEF CONSOLE}
         if not (fsFormMsgEstado = fmsProcessando) then
            Break ;

          SecRest := SecondsBetween(now,  FimPausa) ;
          if SecAnt <> SecRest then  { Verifica se mudou os segundos }
          begin
             SecAnt := SecRest ;

             try
                Texto := Format(MsgPausaRelatorio, [Via, SecRest]) ;
             except
                Texto := MsgPausaRelatorio ;
             end ;

             FormMsgPinta( Texto );
          end ;

          Application.ProcessMessages ;
       {$ELSE}
          sleep(100) ;
       {$ENDIF}
     end ;
  finally
     {$IFNDEF CONSOLE}
       fsFormMsgTeclaParaFechar := 0 ;
       fsFormMsgEstado := fmsProcessando ;
     {$ENDIF}
  end ;
end;





{$IFNDEF CONSOLE}
  function TACBrECFClass.FormMsgDoProcedure(AProcedure: TACBrFormMsgProcedure;
    TeclaParaFechar: Word): Boolean;
  Var Timer : TTimer ;
      {$IFDEF VisualCLX}
      OldOnEvent : TEventEvent;
      OldCursor  : TCursor ;
      {$ENDIF}
  begin
    Result := true ;
    {$IFDEF VisualCLX}
    OldOnEvent := Application.OnEvent ;
    OldCursor  := Screen.Cursor ;
    {$ENDIF}

    if Assigned(fsFormMsg) then
       Raise Exception.Create('Erro. Chamada recurssiva de FormMsgDoProcedure') ;

    fsFormMsg  := TForm.create( Application ) ;

    try
       {$IFDEF VisualCLX}
       Application.OnEvent := FormMsgEvent ;
       {$ENDIF}
       fsFormMsgProcedureAExecutar := AProcedure ;
       fsFormMsgTeclaParaFechar    := TeclaParaFechar ;
       fsFormMsgEstado             := fmsProcessando ;

       fsFormMsg.KeyPreview   := true ;
       fsFormMsg.OnKeyPress   := FormMsgKeyPress ;
       fsFormMsg.OnCloseQuery := FormMsgCloseQuery ;
       fsFormMsg.Color        := fsFormMsgColor ;
       fsFormMsg.Font         := fsFormMsgFont ;
       fsFormMsg.BorderIcons  := [] ;
       fsFormMsg.BorderStyle  := {$IFDEF VisualCLX} fbsNone {$ELSE} bsNone {$ENDIF};
       fsFormMsg.Position     := poMainFormCenter ;
       fsFormMsg.FormStyle    := fsStayOnTop ;
       fsFormMsg.Width        := 0 ;   { Cria o form escondido }
       fsFormMsg.Height       := 0 ;
       fsFormMsgException     := '' ;
       {$IFDEF LINUX}
        {$IFNDEF FPC}
         fsFormMsg.OnShow     := FormShow ;
        {$ENDIF}
       {$ENDIF}

       if BloqueiaMouseTeclado then
        begin
          { Quando o Timer for ativado, a procedure em fsFormMsgProcedureAExecutar
            ser� executada... Ao fim da Procurede o fsFormMsg � fechado }
          { O objeto Timer ser� destruido no proprio evento FormMsgTimer }

          Timer := TTimer.Create(fsFormMsg);
          Timer.Enabled  := false ;
          Timer.OnTimer  := FormMsgTimer ;
          Timer.Interval := 3 ;
          Timer.Enabled  := True ;

          fsFormMsg.ShowModal ;
        end
       else
        begin
          fsFormMsg.Show ;
          FormMsgTimer(Self);
        end ;

       if fsFormMsgException <> '' then
          raise Exception.Create( fsFormMsgException ) ;
    finally
       {$IFDEF VisualCLX}
       Application.OnEvent := OldOnEvent;
       Screen.Cursor       := OldCursor ;
       {$ENDIF}
       FreeAndNil(fsFormMsg) ;
    end
  end;

  procedure TACBrECFClass.FormMsgTimer(Sender: TObject);
  begin
    if Sender is TTimer then
    begin
       TTimer(Sender).Enabled := false ;
       FreeAndNil( Sender ) ;
    end ;

    try
       try
          if Assigned( fsFormMsgProcedureAExecutar ) then
             fsFormMsgProcedureAExecutar  ;
       finally
          if Assigned( fsOnMsgAguarde ) then
             fsOnMsgAguarde( '' ) ;

          if fsFormMsgEstado = fmsProcessando then
             fsFormMsgEstado := fmsConcluido
          else
             fsFormMsgEstado := fmsAbortado ;

          fsFormMsg.Close ;
          //{$IFNDEF COMPLIB_CLX}
          Application.BringToFront ;
          //{$ENDIF}
       end ;
    except
      { N�o dispra a exce��o dentro do Envento do Timer para a ordem da Pilha
        de Exce��es ficar correta }
      on E : Exception
      do begin
         fsFormMsgException := E.Message ;
      end ;
    end ;
  end;

  procedure TACBrECFClass.FormMsgKeyPress(Sender: TObject; var Key: Char);
  begin
    if (fsFormMsgTeclaParaFechar <> 0)  and
       (UpCase( Key ) = chr(fsFormMsgTeclaParaFechar)) and
       (fsFormMsgEstado <> fmsAbortado) then
       fsFormMsgEstado := fmsAbortado
    else
       Key := chr(0) ;
  end;

  procedure TACBrECFClass.FormMsgCloseQuery(Sender: TObject;
    var CanClose: Boolean);
  begin
    CanClose := (fsFormMsgEstado <> fmsProcessando) ;
  end;
  {$D-}
  {$IFDEF VisualCLX}
    procedure TACBrECFClass.FormMsgEvent(Sender: QObjectH; Event: QEventH;
      var Handled: Boolean);
    {$IFDEF QT3CLX}
    Var  EventType: QEventH;
    {$ELSE}
    Var  EventType: QEventType;
    {$ENDIF}
    begin
      {$IFDEF QT3CLX}
      EventType := Event;
      {$ELSE}
      EventType := QEvent_type(Event);
      {$ENDIF}

      {$IFDEF LINUX}
      { No Linux o Formulario pode ser Minimizado ou arrastado mesmo com um
        ShowModal sobrepondo a aplica��o... Portanto vamos esconder o cursor e n�o
        permitir que ele se mova }
         if Assigned(fsFormMsg) then
         begin
            {$IFDEF QT3CLX}
            if EventType.type_ in [QEvent_Type_Close, QEvent_Type_Hide, QEvent_Type_Quit,
                             QEvent_Type_ShowMinimized, QEvent_Type_WindowDeActivate,
                             QEvent_Type_MouseMove, QEvent_Type_MouseButtonPress,
                             QEvent_Type_MouseButtonRelease,
                             QEvent_Type_MouseButtonDblClick,
                             QEvent_Type_DragMove,
                             QEvent_Type_Leave, QEvent_Type_Enter] then
            {$ELSE}
            if EventType in [QEventType_Close, QEventType_Hide, QEventType_Quit,
                             QEventType_ShowMinimized, QEventType_WindowDeActivate,
                             QEventType_MouseMove, QEventType_MouseButtonPress,
                             QEventType_MouseButtonRelease,
                             QEventType_MouseButtonDblClick,
                             QEventType_DragMove,
                             QEventType_Leave, QEventType_Enter] then
            {$ENDIF}                 
            begin
               Handled := true ;
               fsFormMsg.SetFocus ;
            end ;

            if fsFormMsg.Visible then
            begin
               Mouse.CursorPos := Point(fsFormMsg.Left,fsFormMsg.Top) ;
               Screen.Cursor   := crNone ;
            end ;
         end ;
      {$ENDIF}

      {$IFDEF QT3CLX}
      if EventType.type_ = QEvent_Type_Close then
         Handled := true

      else if ((EventType.type_ in [QEvent_Type_KeyPress]) and (fsFormMsgTeclaParaFechar = 0)) or
               ( EventType.type_ = QEvent_Type_MouseButtonPress) then
         Handled := true ;
      {$ELSE}
      if EventType = QEventType_Close then
         Handled := true

      else if ((EventType in [QEventType_KeyPress]) and (fsFormMsgTeclaParaFechar = 0)) or
               ( EventType = QEventType_MouseButtonPress) then
         Handled := true ;
      {$ENDIF}
    end;
  {$ENDIF}
  {$D+}
  procedure TACBrECFClass.FormMsgPinta( Texto : String );
  Var H, W, X, Y : Integer ;
  begin
    if Assigned( fsOnMsgAguarde ) then
       fsOnMsgAguarde( Texto ) ;

    if not Assigned( fsFormMsg ) then
       exit ;

    if fsFormMsg.Visible and ExibeMensagem then
    begin
       fsFormMsg.BringToFront ;
       fsFormMsg.SetFocus ;

       with fsFormMsg.Canvas do      { Pintando <Texto> no Canvas do fpFormMsg }
       begin
          H := TextHeight(Texto) + 10 ;    { Calcula o tamanho do Texto }
          W := TextWidth (Texto) + 20 ;

          { Ajusta o Form para caber o Texto }
          if (abs(W - fsFormMsg.Width ) > 4) or
             (abs(H - fsFormMsg.Height) > 4) then
          begin
             fsFormMsg.Width  := W ;
             fsFormMsg.Height := H ;
             {$IFDEF FPC}
             fsFormMsg.Position := poDesktopCenter ;
             {$ELSE}
             fsFormMsg.Position := poMainFormCenter ;
             {$ENDIF}
          end ;

          Brush.Color := fsFormMsg.Color ;
          Font.Color  := fsFormMsg.Font.Color ;
          Pen.Color   := fsFormMsg.Font.Color ;
          Rectangle(fsFormMsg.ClientRect);
         {$IFDEF VisualCLX}
          X := 0 ;
          Y := 0 ;
          TextRect(fsFormMsg.ClientRect,X,Y, Texto, 36 ) ; { 36 = No Centro }
         {$ELSE}
          { Na VCL nao tem como centralizar no Form nem quebra de Linhas }
          Texto := StringReplace( Texto, #10, ' ', [rfReplaceAll,rfIgnoreCase] ) ;
          X := 10 ;
          Y := 5 ;
          TextRect(fsFormMsg.ClientRect,X,Y, Texto ) ;
         {$ENDIF}
       end ;
       Application.ProcessMessages ;
    end ;
  end;

  function TACBrECFClass.FormMsgExibe : Boolean;
  begin
    result := (ExibeMensagem or BloqueiaMouseTeclado) and
              ((TimeOut - TempoInicioMsg) > 1) and
              FormMsgControla and
              Application.ShowMainForm ;
  end;

  {$IFDEF LINUX}
   {$IFNDEF FPC}
    procedure TACBrECFClass.FormShow(Sender: TObject);
    begin
     {$IFDEF QT3CLX}
      fsFormMsg.Handle.grabKeyboard;
      fsFormMsg.Handle.releaseKeyboard;
     {$ELSE}
      QWidget_grabKeyboard(fsFormMsg.Handle);
      QWidget_releaseKeyboard(fsFormMsg.Handle);
     {$ENDIF}
    end;
   {$ENDIF}
  {$ENDIF}
{$ENDIF}

end.


