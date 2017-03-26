unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, jpeg, ExtCtrls, ComCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu: TMainMenu;
    mnItCadastro: TMenuItem;
    mnItCliente: TMenuItem;
    Fornecedor1: TMenuItem;
    Produto1: TMenuItem;
    mnItEntradaSaida: TMenuItem;
    mnItCompra: TMenuItem;
    mnItContas: TMenuItem;
    mnItContasPagar: TMenuItem;
    mnItRelatorios: TMenuItem;
    imgFundo: TImage;
    mnItRelatorioContasPagar: TMenuItem;
    mnItVenda: TMenuItem;
    mnItContasReceber: TMenuItem;
    mnItSobre: TMenuItem;
    mnItConfiguracoes: TMenuItem;
    mnItBalanca: TMenuItem;
    mnItRelatorioContasReceber: TMenuItem;
    mnItDivisaoRelatorios: TMenuItem;
    mnItRelatorioVendas: TMenuItem;
    mnItRelatorioCompras: TMenuItem;
    StatusBar: TStatusBar;
    Timer: TTimer;
    procedure mnItClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Fornecedor1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure mnItCompraClick(Sender: TObject);
    procedure mnItContasPagarClick(Sender: TObject);
    procedure mnItRelatorioContasPagarClick(Sender: TObject);
    procedure mnItVendaClick(Sender: TObject);
    procedure mnItContasReceberClick(Sender: TObject);
    procedure mnItSobreClick(Sender: TObject);
    procedure mnItBalancaClick(Sender: TObject);
    procedure mnItRelatorioContasReceberClick(Sender: TObject);
    procedure mnItRelatorioVendasClick(Sender: TObject);
    procedure mnItRelatorioComprasClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses unCliente, unFornecedor, unProduto, unCompra, unContasPagar,
  unSelecionaContaPagar, unVenda, unContasReceber, unSobre,
  unConfiguracaoBalanca, unSelecionaContaReceber, unSelecionaEntradas,
  unSelecionaSaida;

{$R *.dfm}

procedure TfrmPrincipal.mnItClienteClick(Sender: TObject);
begin
  frmCliente.ShowModal;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  ShortDateFormat := 'dd/mm/yyyy';
  LongDateFormat := 'dd/mm/yyyy';
  DateSeparator := '/';
  ShortTimeFormat := 'hh:mm:ss';
  LongTimeFormat := 'hh:mm:ss';
  TimeSeparator := ':';
end;

procedure TfrmPrincipal.Fornecedor1Click(Sender: TObject);
begin
  frmFornecedor.ShowModal;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  frmProduto.ShowModal;
end;

procedure TfrmPrincipal.mnItCompraClick(Sender: TObject);
begin
  frmCompra.ShowModal;
end;

procedure TfrmPrincipal.mnItContasPagarClick(Sender: TObject);
begin
  frmContasPagar.ShowModal;  
end;

procedure TfrmPrincipal.mnItRelatorioContasPagarClick(Sender: TObject);
begin
  frmSelecionaContaPagar.ShowModal;
end;

procedure TfrmPrincipal.mnItVendaClick(Sender: TObject);
begin
  frmVenda.ShowModal;
end;

procedure TfrmPrincipal.mnItContasReceberClick(Sender: TObject);
begin
  frmContasReceber.ShowModal;
end;

procedure TfrmPrincipal.mnItSobreClick(Sender: TObject);
begin
  frmSobre.ShowModal;
end;

procedure TfrmPrincipal.mnItBalancaClick(Sender: TObject);
begin
  frmConfiguracaoBalanca.ShowModal;
end;

procedure TfrmPrincipal.mnItRelatorioContasReceberClick(Sender: TObject);
begin
  frmSelecionaContaReceber.ShowModal;
end;

procedure TfrmPrincipal.mnItRelatorioVendasClick(Sender: TObject);
begin
  frmSelecionaEntrada.ShowModal;
end;

procedure TfrmPrincipal.mnItRelatorioComprasClick(Sender: TObject);
begin
  frmSelecionaSaida.ShowModal;
end;

procedure TfrmPrincipal.TimerTimer(Sender: TObject);
begin
  StatusBar.Panels[1].Text := DateToStr(Date)+' - '+TimeToStr(Now);
end;

end.
