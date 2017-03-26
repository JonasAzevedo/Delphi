program Noiva_Linda;

uses
  Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  unDM in 'unDM.pas' {DM: TDataModule},
  unLoko in 'unLoko.pas' {frmIeIe},
  unMurro in 'unMurro.pas' {frmMurro},
  unCliente in 'unCliente.pas' {frmCliente},
  unFornecedor in 'unFornecedor.pas' {frmFornecedor},
  unProduto in 'unProduto.pas' {frmProduto},
  unLocacao in 'unLocacao.pas' {frmLocacao},
  unSelecionaCliente in 'unSelecionaCliente.pas' {frmSelecionaCliente},
  unSelecionaProduto in 'unSelecionaProduto.pas' {frmSelecionaProduto},
  unValorPago in 'unValorPago.pas' {frmValorPago},
  unRetornoLocacao in 'unRetornoLocacao.pas' {frmRetornoLocacao},
  unPagarRestante in 'unPagarRestante.pas' {frmPagarRestante},
  unUsuario in 'unUsuario.pas' {frmUsuario},
  unLogin in 'unLogin.pas' {frmLogin},
  unSelecionaRelatorioOperacoes in 'unSelecionaRelatorioOperacoes.pas' {frmSelecionaRelatorioOperacoes},
  unVerLocacoesPendentesVencendo in 'unVerLocacoesPendentesVencendo.pas' {frmLocacoesPendentesVencendo},
  unReserva in 'unReserva.pas' {frmReserva},
  unVenda in 'unVenda.pas' {frmVenda},
  unContaReceber in 'unContaReceber.pas' {frmContaReceber},
  unSelecionaRelatorioEntradasFinanceiras in 'unSelecionaRelatorioEntradasFinanceiras.pas' {frmSelecionaRelatorioEntradasFinanceiras},
  unRelatorioEntradaFinanceira in 'Relatórios\unRelatorioEntradaFinanceira.pas' {qckRepEntradaFinanceira: TQuickRep},
  unCompra in 'unCompra.pas' {frmCompra},
  unItemProdutoCompra in 'unItemProdutoCompra.pas' {frmProdutoCompra},
  unSelecionaFornecedor in 'unSelecionaFornecedor.pas' {frmSelecionaFornecedor},
  unContaPagar in 'unContaPagar.pas' {frmContaPagar},
  unSelecionaRelatorioSaidasFinanceiras in 'unSelecionaRelatorioSaidasFinanceiras.pas' {frmSelecionaRelatorioSaidasFinanceiras},
  unResumoRelatorio in 'unResumoRelatorio.pas' {frmResumoRelatorio},
  unVerReservasPendentes in 'unVerReservasPendentes.pas' {frmReservasPendentes},
  unBaixaReservas in 'unBaixaReservas.pas' {frmBaixaReservas},
  unRelatorioHistoricoProduto in 'Relatórios\unRelatorioHistoricoProduto.pas' {qckRepHistoricoProduto: TQuickRep},
  unOperacoesHoje in 'unOperacoesHoje.pas' {frmOperacoesHoje},
  unSobre in 'unSobre.pas' {frmSobre},
  unConfiguracaoComisoes in 'unConfiguracaoComisoes.pas' {frmConfiguracaoComisoes},
  unTipoProduto in 'unTipoProduto.pas' {frmTipoProduto},
  unSelecionaTipoProduto in 'unSelecionaTipoProduto.pas' {frmSelecionaTipoProduto},
  unSelecionaFuncionario in 'unSelecionaFuncionario.pas' {frmSelecionaFuncionario},
  unSelecionaRelatorioCompras in 'unSelecionaRelatorioCompras.pas' {frmSelecionaRelatorioCompras},
  unRelatorioCompraResumo in 'Relatórios\unRelatorioCompraResumo.pas' {qckRepRelatorioCompraResumo: TQuickRep},
  unSelecionaRelatorioLocacoes in 'unSelecionaRelatorioLocacoes.pas' {frmSelecionaRelatorioLocacoes},
  unRelatorioLocacaoResumo in 'Relatórios\unRelatorioLocacaoResumo.pas' {qckRepRelatorioLocacaoResumo: TQuickRep},
  unSelecionaRelatorioReservas in 'unSelecionaRelatorioReservas.pas' {frmSelecionaRelatorioReservas},
  unRelatorioReservaResumo in 'Relatórios\unRelatorioReservaResumo.pas' {qckRepRelatorioReservaResumo: TQuickRep},
  unSelecionaRelatorioVendas in 'unSelecionaRelatorioVendas.pas' {frmSelecionaRelatorioVendas},
  unRelatorioVendaResumo in 'Relatórios\unRelatorioVendaResumo.pas' {qckRepRelatorioVendaResumo: TQuickRep},
  unSelecionaRelatorioComissoes in 'unSelecionaRelatorioComissoes.pas' {frmSelecionaRelatorioComissoes},
  unRelatorioComissoesResumo in 'Relatórios\unRelatorioComissoesResumo.pas' {qckRepRelatorioComissoesResumo: TQuickRep},
  unVerResumoRelatorioComissoes in 'unVerResumoRelatorioComissoes.pas' {frmVerResumoRelatorioComissoes};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MENA';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmVerResumoRelatorioComissoes, frmVerResumoRelatorioComissoes);
  Application.Run;
end.
