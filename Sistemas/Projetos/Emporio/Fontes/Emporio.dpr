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
  unItemVenda in 'unItemVenda.pas' {frmItemVenda},
  unContasReceber in 'unContasReceber.pas' {frmContasReceber},
  unSobre in 'unSobre.pas' {frmSobre},
  unConfiguracaoBalanca in 'unConfiguracaoBalanca.pas' {frmConfiguracaoBalanca},
  unSelecionaContaReceber in 'unSelecionaContaReceber.pas' {frmSelecionaContaReceber},
  unRelatorioContasReceber in 'unRelatorioContasReceber.pas' {relatorioContasReceber: TQuickRep},
  unSelecionaEntradas in 'unSelecionaEntradas.pas' {frmSelecionaEntrada},
  unSelecionaVenda in 'unSelecionaVenda.pas' {frmSelecionaVenda},
  unRelatorioEntrada in 'unRelatorioEntrada.pas' {relatorioEntrada: TQuickRep},
  unSelecionaSaida in 'unSelecionaSaida.pas' {frmSelecionaSaida},
  unSelecionaCompra in 'unSelecionaCompra.pas' {frmSelecionaCompra},
  unRelatorioSaida in 'unRelatorioSaida.pas' {relatorioSaida: TQuickRep};

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
  Application.CreateForm(TfrmContasReceber, frmContasReceber);
  Application.CreateForm(TfrmSobre, frmSobre);
  Application.CreateForm(TfrmConfiguracaoBalanca, frmConfiguracaoBalanca);
  Application.CreateForm(TfrmSelecionaContaReceber, frmSelecionaContaReceber);
  Application.CreateForm(TrelatorioContasReceber, relatorioContasReceber);
  Application.CreateForm(TfrmSelecionaEntrada, frmSelecionaEntrada);
  Application.CreateForm(TfrmSelecionaVenda, frmSelecionaVenda);
  Application.CreateForm(TrelatorioEntrada, relatorioEntrada);
  Application.CreateForm(TfrmSelecionaSaida, frmSelecionaSaida);
  Application.CreateForm(TfrmSelecionaCompra, frmSelecionaCompra);
  Application.CreateForm(TrelatorioSaida, relatorioSaida);
  Application.Run;
end.
