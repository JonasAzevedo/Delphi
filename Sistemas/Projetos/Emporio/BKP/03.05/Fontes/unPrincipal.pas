unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, jpeg, ExtCtrls;

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
    ContasPagar1: TMenuItem;
    mnItVenda: TMenuItem;
    procedure mnItClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Fornecedor1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure mnItCompraClick(Sender: TObject);
    procedure mnItContasPagarClick(Sender: TObject);
    procedure ContasPagar1Click(Sender: TObject);
    procedure mnItVendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses unCliente, unFornecedor, unProduto, unCompra, unContasPagar,
  unSelecionaContaPagar, unVenda;

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

procedure TfrmPrincipal.ContasPagar1Click(Sender: TObject);
begin
  frmSelecionaContaPagar.ShowModal;
end;

procedure TfrmPrincipal.mnItVendaClick(Sender: TObject);
begin
  frmVenda.ShowModal;
end;

end.
