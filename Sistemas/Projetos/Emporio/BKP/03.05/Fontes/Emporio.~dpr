program Emporio;

uses
  Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  unDataModule in 'unDataModule.pas' {DM: TDataModule},
  unCliente in 'unCliente.pas' {frmCliente},
  unFornecedor in 'unFornecedor.pas' {frmFornecedor},
  unProduto in 'unProduto.pas' {frmProduto},
  unCompra in 'unCompra.pas' {frmCompra},
  unSelecionaFornecedor in 'unSelecionaFornecedor.pas' {frmSelecionaFornecedor},
  unSelecionaProduto in 'unSelecionaProduto.pas' {frmSelecionaProduto},
  unContasPagar in 'unContasPagar.pas' {frmContasPagar},
  unRelatorioContasPagar in 'unRelatorioContasPagar.pas' {relatorioContasPagar: TQuickRep},
  unSelecionaContaPagar in 'unSelecionaContaPagar.pas' {frmSelecionaContaPagar},
  unVenda in 'unVenda.pas' {frmVenda},
  unSelecionaCliente in 'unSelecionaCliente.pas' {frmSelecionaCliente},
  unItemVenda in 'unItemVenda.pas' {frmItemVenda};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Empório';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmCliente, frmCliente);
  Application.CreateForm(TfrmFornecedor, frmFornecedor);
  Application.CreateForm(TfrmProduto, frmProduto);
  Application.CreateForm(TfrmCompra, frmCompra);
  Application.CreateForm(TfrmSelecionaFornecedor, frmSelecionaFornecedor);
  Application.CreateForm(TfrmSelecionaProduto, frmSelecionaProduto);
  Application.CreateForm(TfrmContasPagar, frmContasPagar);
  Application.CreateForm(TrelatorioContasPagar, relatorioContasPagar);
  Application.CreateForm(TfrmSelecionaContaPagar, frmSelecionaContaPagar);
  Application.CreateForm(TfrmVenda, frmVenda);
  Application.CreateForm(TfrmSelecionaCliente, frmSelecionaCliente);
  Application.CreateForm(TfrmItemVenda, frmItemVenda);
  Application.Run;
end.
