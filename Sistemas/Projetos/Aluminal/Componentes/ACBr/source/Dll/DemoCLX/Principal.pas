unit Principal;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, QButtons;

type
  TfrPrincipal = class(TForm)
    cbxModelo: TComboBox;
    cbxPorta: TComboBox;
    seTimeOut: TEdit;
    bAtivar: TBitBtn;
    bReducao: TBitBtn;
    bLeituraX: TBitBtn;
    bAbreCupom: TBitBtn;
    bVendeItem: TBitBtn;
    bSubtotaliza: TBitBtn;
    bPagamento: TBitBtn;
    bFechaCupom: TBitBtn;
    bCancelaItem: TBitBtn;
    bCancelaCupom: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure bAtivarClick(Sender: TObject);
    procedure bReducaoClick(Sender: TObject);
    procedure bLeituraXClick(Sender: TObject);
    procedure bAbreCupomClick(Sender: TObject);
    procedure bVendeItemClick(Sender: TObject);
    procedure bSubtotalizaClick(Sender: TObject);
    procedure bPagamentoClick(Sender: TObject);
    procedure bFechaCupomClick(Sender: TObject);
    procedure bCancelaItemClick(Sender: TObject);
    procedure bCancelaCupomClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frPrincipal: TfrPrincipal;

implementation

uses UnitDeclaracao;

{$R *.xfm}

procedure TfrPrincipal.bAtivarClick(Sender: TObject);
begin
 if DefineModelo(cbxModelo.Text , cbxPorta.Text, StrToInt(seTimeOut.Text) ) then
    ShowMessage('Ativado com Sucesso')
 else
    ShowMessage('N�o foi poss�vel ativar o ECF');
end;

procedure TfrPrincipal.bReducaoClick(Sender: TObject);
var Retorno : Integer ;
begin
  Retorno := ReducaoZ(Now) ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bLeituraXClick(Sender: TObject);
var Retorno : Integer ;
begin
  Retorno := LeituraX ;
  ShowMessage(IntToStr(Retorno));
end;


procedure TfrPrincipal.bAbreCupomClick(Sender: TObject);
var Retorno : Integer ;
begin
  Retorno := AbreCupom() ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bVendeItemClick(Sender: TObject);
var Retorno  : Integer ;
    Codigo, Descricao, AliquotaICMS, Unidade, TipoDescontoAcrescimo : String;
    Qtd, ValorUnitario, DescontoPorc : Double ;
begin
  Codigo    := InputBox('Vende Item','Digite a C�digo do Produto:', '123456' );
  Descricao := InputBox('Vende Item','Digite a Descri��o do Produto:', 'Teste de Produto' );
  AliquotaICMS    := InputBox('Vende Item','Digite a Al�quota do Produto:', 'II' );
  Unidade   := InputBox('Vende Item','Digite a Unidade do Produto:', 'UN' );
  TipoDescontoAcrescimo    := InputBox('Vende Item','Digite o Tipo de Desconto do Produto:', '%' );
  Qtd := StrToFloatDef(InputBox('Vende Item','Digite a Quantidade:', '1' ),0);
  ValorUnitario := StrToFloatDef(InputBox('Vende Item','Digite o Valor Unit�rio:', '1' ),0);
  DescontoPorc := StrToFloatDef(InputBox('Vende Item','Digite o Desconto:', '0' ),0);

  Retorno := VendeItem( Codigo, Descricao, AliquotaICMS, Qtd, ValorUnitario, DescontoPorc, Unidade, TipoDescontoAcrescimo ) ;

  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bSubtotalizaClick(Sender: TObject);
var Retorno : Integer ;
    Obs : String ;
    Desconto : Real ;
begin
  Desconto := StrToFloatDef(InputBox('SubTotal','Digite o Desconto/Acr�scimo:', '' ),0);
  Obs      := InputBox('SubTotal','Digite a Observa��o:', '' );
  Retorno := SubtotalizaCupom( Desconto, Obs ) ;
  ShowMessage(IntToStr(Retorno));
end;
procedure TfrPrincipal.bPagamentoClick(Sender: TObject);
var Retorno : Integer ;
    CodForma, Obs : String ;
    Valor : Real ;
begin
  CodForma := InputBox('Pagamento','Digite o c�digo da forma:', '' );
  Valor    := StrToFloatDef(InputBox('Pagamento','Digite o Valor:', '' ),0);
  Obs      := InputBox('Pagamento','Digite a Observa��o:', '' );
  Retorno := EfetuaPagamento( CodForma, Valor, Obs ) ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bFechaCupomClick(Sender: TObject);
var Retorno : Integer ;
    Obs : String ;
begin
  Obs := InputBox('Fechamento','Digite a Observa��o Final:', '' );
  Retorno := FechaCupom( Obs ) ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bCancelaItemClick(Sender: TObject);
var Retorno : Integer ;
    Item    : Integer ;
begin
  Item := StrToInt(InputBox('Cancela Item','Digite a N�mero do Item:', '' ));
  Retorno := CancelaItemVendido( Item ) ;
  ShowMessage(IntToStr(Retorno));
end;

procedure TfrPrincipal.bCancelaCupomClick(Sender: TObject);
var Retorno : Integer ;
begin
  Retorno := CancelaCupom ;
  ShowMessage(IntToStr(Retorno));
end;


end.
