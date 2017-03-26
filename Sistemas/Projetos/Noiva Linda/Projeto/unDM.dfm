object DM: TDM
  OldCreateOrder = False
  Left = 170
  Height = 762
  Width = 1110
  object SQLConnection: TSQLConnection
    ConnectionName = 'NoivaLinda'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=c:\Noiva Linda\BD\BD.FDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'C:\WINDOWS\system32\FBCLIENT.DLL'
    Left = 424
    Top = 8
  end
  object qryCliente: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Cliente')
    SQLConnection = SQLConnection
    Left = 110
    Top = 69
    object qryClienteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryClienteNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object qryClienteRUA: TStringField
      FieldName = 'RUA'
      Size = 100
    end
    object qryClienteNUMERO_CASA: TIntegerField
      FieldName = 'NUMERO_CASA'
    end
    object qryClienteBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object qryClienteCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object qryClienteUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object qryClienteCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object qryClienteCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object qryClienteTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 14
    end
    object qryClienteCELULAR: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
    object qryClienteSEXO: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
    object qryClienteESTADO_CIVIL: TStringField
      FieldName = 'ESTADO_CIVIL'
      Size = 15
    end
    object qryClienteLOCAL_TRABALHO: TStringField
      FieldName = 'LOCAL_TRABALHO'
      Size = 100
    end
    object qryClienteDATA_FICHA: TDateField
      FieldName = 'DATA_FICHA'
    end
  end
  object qryFornecedor: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Fornecedor')
    SQLConnection = SQLConnection
    Left = 190
    Top = 69
    object qryFornecedorCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryFornecedorRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 100
    end
    object qryFornecedorNOME_FANTASIA: TStringField
      FieldName = 'NOME_FANTASIA'
      Size = 100
    end
    object qryFornecedorCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 30
    end
    object qryFornecedorINSCRICAO_ESTADUAL: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Size = 30
    end
    object qryFornecedorENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 100
    end
    object qryFornecedorBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object qryFornecedorCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object qryFornecedorUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object qryFornecedorCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object qryFornecedorE_MAIL: TStringField
      FieldName = 'E_MAIL'
      Size = 80
    end
    object qryFornecedorHOME_PAGE: TStringField
      FieldName = 'HOME_PAGE'
      Size = 80
    end
    object qryFornecedorTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 14
    end
    object qryFornecedorCELULAR: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
    object qryFornecedorREPRESENTANTE: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 100
    end
    object qryFornecedorDATA_FICHA: TDateField
      FieldName = 'DATA_FICHA'
    end
  end
  object qryProduto: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Produto')
    SQLConnection = SQLConnection
    Left = 288
    Top = 70
    object qryProdutoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryProdutoCODIGO2: TStringField
      FieldName = 'CODIGO2'
      Size = 5
    end
    object qryProdutoCOD_TIPO_PRODUTO: TIntegerField
      FieldName = 'COD_TIPO_PRODUTO'
    end
    object qryProdutoNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object qryProdutoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 300
    end
    object qryProdutoVALOR_LOCACAO: TFMTBCDField
      FieldName = 'VALOR_LOCACAO'
      Precision = 15
      Size = 2
    end
    object qryProdutoVALOR_VENDA: TFMTBCDField
      FieldName = 'VALOR_VENDA'
      Precision = 15
      Size = 2
    end
    object qryProdutoVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object qryProdutoMARCA: TStringField
      FieldName = 'MARCA'
      Size = 50
    end
    object qryProdutoTAMANHO: TIntegerField
      FieldName = 'TAMANHO'
    end
    object qryProdutoSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
    object qryProdutoDATA_VENDA: TSQLTimeStampField
      FieldName = 'DATA_VENDA'
    end
  end
  object qryCompra: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Compra')
    SQLConnection = SQLConnection
    Left = 409
    Top = 312
    object qryCompraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryCompraCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
    end
    object qryCompraDATA_COMPRA: TDateField
      FieldName = 'DATA_COMPRA'
    end
    object qryCompraOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object qryCompraVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 9
      Size = 2
    end
    object qryCompraVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object qryCompraPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object qryCompraVENCIMENTO: TDateField
      FieldName = 'VENCIMENTO'
    end
  end
  object qryItemCompra: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Item_Compra')
    SQLConnection = SQLConnection
    Left = 489
    Top = 312
    object qryItemCompraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryItemCompraCOD_COMPRA: TIntegerField
      FieldName = 'COD_COMPRA'
    end
    object qryItemCompraCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object qryItemCompraVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
  end
  object qryLocacao: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Locacao')
    SQLConnection = SQLConnection
    Left = 222
    Top = 320
    object qryLocacaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryLocacaoDATA_LOCACAO: TSQLTimeStampField
      FieldName = 'DATA_LOCACAO'
    end
    object qryLocacaoCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object qryLocacaoCOD_FUNCIONARIO: TIntegerField
      FieldName = 'COD_FUNCIONARIO'
    end
    object qryLocacaoSEXO: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
    object qryLocacaoDATA_INICIO: TSQLTimeStampField
      FieldName = 'DATA_INICIO'
    end
    object qryLocacaoDATA_FINAL: TSQLTimeStampField
      FieldName = 'DATA_FINAL'
    end
    object qryLocacaoOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object qryLocacaoVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object qryLocacaoVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object qryLocacaoPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object qryLocacaoSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
    object qryLocacaoFINALIZACAO: TSQLTimeStampField
      FieldName = 'FINALIZACAO'
    end
  end
  object qryItemLocacao: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Item_Locacao')
    SQLConnection = SQLConnection
    Left = 311
    Top = 316
    object qryItemLocacaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryItemLocacaoCOD_LOCACAO: TIntegerField
      FieldName = 'COD_LOCACAO'
    end
    object qryItemLocacaoCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object qryItemLocacaoQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object qryItemLocacaoVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object qryItemLocacaoVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object qryItemLocacaoDATA_DEVOLUCAO: TSQLTimeStampField
      FieldName = 'DATA_DEVOLUCAO'
    end
  end
  object qryReserva: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Reserva')
    SQLConnection = SQLConnection
    Left = 40
    Top = 315
    object qryReservaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryReservaDATA_RESERVA: TSQLTimeStampField
      FieldName = 'DATA_RESERVA'
    end
    object qryReservaCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object qryReservaSEXO: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
    object qryReservaDATA_INICIO: TSQLTimeStampField
      FieldName = 'DATA_INICIO'
    end
    object qryReservaDATA_FINAL: TSQLTimeStampField
      FieldName = 'DATA_FINAL'
    end
    object qryReservaOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object qryReservaVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object qryReservaVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object qryReservaPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object qryReservaSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
  end
  object qryItemReserva: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Item_Reserva')
    SQLConnection = SQLConnection
    Left = 120
    Top = 316
    object qryItemReservaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryItemReservaCOD_RESERVA: TIntegerField
      FieldName = 'COD_RESERVA'
    end
    object qryItemReservaCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object qryItemReservaQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object qryItemReservaVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object qryItemReservaVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
  end
  object qryVenda: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Venda')
    SQLConnection = SQLConnection
    Left = 587
    Top = 312
    object qryVendaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryVendaCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object qryVendaCOD_FUNCIONARIO: TIntegerField
      FieldName = 'COD_FUNCIONARIO'
    end
    object qryVendaDATA_VENDA: TSQLTimeStampField
      FieldName = 'DATA_VENDA'
    end
    object qryVendaOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object qryVendaVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object qryVendaVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object qryVendaPAGO: TIntegerField
      FieldName = 'PAGO'
    end
  end
  object qryItemVenda: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Item_Venda')
    SQLConnection = SQLConnection
    Left = 671
    Top = 312
    object qryItemVendaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryItemVendaCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
    end
    object qryItemVendaCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object qryItemVendaQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object qryItemVendaVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object qryItemVendaVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
  end
  object dspItemLocacao: TDataSetProvider
    DataSet = qryItemLocacao
    Left = 311
    Top = 364
  end
  object dspCliente: TDataSetProvider
    DataSet = qryCliente
    Left = 110
    Top = 117
  end
  object dspFornecedor: TDataSetProvider
    DataSet = qryFornecedor
    Left = 190
    Top = 117
  end
  object dspProduto: TDataSetProvider
    DataSet = qryProduto
    Left = 288
    Top = 117
  end
  object dspCompra: TDataSetProvider
    DataSet = qryCompra
    Left = 409
    Top = 360
  end
  object dspItemCompra: TDataSetProvider
    DataSet = qryItemCompra
    Left = 489
    Top = 360
  end
  object dspLocacao: TDataSetProvider
    DataSet = qryLocacao
    Left = 222
    Top = 364
  end
  object dspItemVenda: TDataSetProvider
    DataSet = qryItemVenda
    Left = 674
    Top = 358
  end
  object dspVenda: TDataSetProvider
    DataSet = qryVenda
    Left = 587
    Top = 360
  end
  object dspItemReserva: TDataSetProvider
    DataSet = qryItemReserva
    Left = 120
    Top = 362
  end
  object dspReserva: TDataSetProvider
    DataSet = qryReserva
    Left = 40
    Top = 362
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCliente'
    Left = 110
    Top = 165
    object cdsClienteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsClienteNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object cdsClienteRUA: TStringField
      FieldName = 'RUA'
      Size = 100
    end
    object cdsClienteNUMERO_CASA: TIntegerField
      FieldName = 'NUMERO_CASA'
    end
    object cdsClienteBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object cdsClienteCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object cdsClienteUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsClienteCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsClienteCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object cdsClienteTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 14
    end
    object cdsClienteCELULAR: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
    object cdsClienteSEXO: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
    object cdsClienteESTADO_CIVIL: TStringField
      FieldName = 'ESTADO_CIVIL'
      Size = 15
    end
    object cdsClienteLOCAL_TRABALHO: TStringField
      FieldName = 'LOCAL_TRABALHO'
      Size = 100
    end
    object cdsClienteDATA_FICHA: TDateField
      FieldName = 'DATA_FICHA'
    end
  end
  object cdsFornecedor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFornecedor'
    Left = 190
    Top = 165
    object cdsFornecedorCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsFornecedorRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 100
    end
    object cdsFornecedorNOME_FANTASIA: TStringField
      FieldName = 'NOME_FANTASIA'
      Size = 100
    end
    object cdsFornecedorCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 30
    end
    object cdsFornecedorINSCRICAO_ESTADUAL: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Size = 30
    end
    object cdsFornecedorENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 100
    end
    object cdsFornecedorBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object cdsFornecedorCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object cdsFornecedorUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsFornecedorCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsFornecedorE_MAIL: TStringField
      FieldName = 'E_MAIL'
      Size = 80
    end
    object cdsFornecedorHOME_PAGE: TStringField
      FieldName = 'HOME_PAGE'
      Size = 80
    end
    object cdsFornecedorTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 14
    end
    object cdsFornecedorCELULAR: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
    object cdsFornecedorREPRESENTANTE: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 100
    end
    object cdsFornecedorDATA_FICHA: TDateField
      FieldName = 'DATA_FICHA'
    end
  end
  object cdsCompra: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCompra'
    Left = 409
    Top = 408
    object cdsCompraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsCompraCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
    end
    object cdsCompraDATA_COMPRA: TDateField
      FieldName = 'DATA_COMPRA'
    end
    object cdsCompraOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object cdsCompraVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 9
      Size = 2
    end
    object cdsCompraVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object cdsCompraPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object cdsCompraVENCIMENTO: TDateField
      FieldName = 'VENCIMENTO'
    end
  end
  object cdsItemCompra: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItemCompra'
    Left = 489
    Top = 408
    object cdsItemCompraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsItemCompraCOD_COMPRA: TIntegerField
      FieldName = 'COD_COMPRA'
    end
    object cdsItemCompraCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object cdsItemCompraVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
  end
  object cdsLocacao: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLocacao'
    Left = 222
    Top = 412
    object cdsLocacaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsLocacaoDATA_LOCACAO: TSQLTimeStampField
      FieldName = 'DATA_LOCACAO'
    end
    object cdsLocacaoCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object cdsLocacaoCOD_FUNCIONARIO: TIntegerField
      FieldName = 'COD_FUNCIONARIO'
    end
    object cdsLocacaoSEXO: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
    object cdsLocacaoDATA_INICIO: TSQLTimeStampField
      FieldName = 'DATA_INICIO'
    end
    object cdsLocacaoDATA_FINAL: TSQLTimeStampField
      FieldName = 'DATA_FINAL'
    end
    object cdsLocacaoOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object cdsLocacaoVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object cdsLocacaoVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object cdsLocacaoPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object cdsLocacaoSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
    object cdsLocacaoFINALIZACAO: TSQLTimeStampField
      FieldName = 'FINALIZACAO'
    end
  end
  object cdsItemLocacao: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItemLocacao'
    Left = 310
    Top = 412
    object cdsItemLocacaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsItemLocacaoCOD_LOCACAO: TIntegerField
      FieldName = 'COD_LOCACAO'
    end
    object cdsItemLocacaoCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object cdsItemLocacaoQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object cdsItemLocacaoVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object cdsItemLocacaoVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object cdsItemLocacaoDATA_DEVOLUCAO: TSQLTimeStampField
      FieldName = 'DATA_DEVOLUCAO'
    end
  end
  object cdsItemVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItemVenda'
    Left = 675
    Top = 406
    object cdsItemVendaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsItemVendaCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
    end
    object cdsItemVendaCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object cdsItemVendaQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object cdsItemVendaVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object cdsItemVendaVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
  end
  object cdsVenda: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspVenda'
    Left = 590
    Top = 408
    object cdsVendaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsVendaCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object cdsVendaCOD_FUNCIONARIO: TIntegerField
      FieldName = 'COD_FUNCIONARIO'
    end
    object cdsVendaDATA_VENDA: TSQLTimeStampField
      FieldName = 'DATA_VENDA'
    end
    object cdsVendaOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object cdsVendaVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object cdsVendaVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object cdsVendaPAGO: TIntegerField
      FieldName = 'PAGO'
    end
  end
  object cdsItemReserva: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItemReserva'
    Left = 120
    Top = 411
    object cdsItemReservaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsItemReservaCOD_RESERVA: TIntegerField
      FieldName = 'COD_RESERVA'
    end
    object cdsItemReservaCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object cdsItemReservaQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object cdsItemReservaVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object cdsItemReservaVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
  end
  object cdsReserva: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspReserva'
    Left = 40
    Top = 411
    object cdsReservaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsReservaDATA_RESERVA: TSQLTimeStampField
      FieldName = 'DATA_RESERVA'
    end
    object cdsReservaCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object cdsReservaSEXO: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
    object cdsReservaDATA_INICIO: TSQLTimeStampField
      FieldName = 'DATA_INICIO'
    end
    object cdsReservaDATA_FINAL: TSQLTimeStampField
      FieldName = 'DATA_FINAL'
    end
    object cdsReservaOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object cdsReservaVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object cdsReservaVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object cdsReservaPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object cdsReservaSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
  end
  object dsCliente: TDataSource
    DataSet = cdsCliente
    Left = 110
    Top = 213
  end
  object dsFornecedor: TDataSource
    DataSet = cdsFornecedor
    Left = 190
    Top = 213
  end
  object dsProduto: TDataSource
    DataSet = cdsProduto
    Left = 288
    Top = 213
  end
  object dsCompra: TDataSource
    DataSet = cdsCompra
    Left = 409
    Top = 456
  end
  object dsItemCompra: TDataSource
    DataSet = cdsItemCompra
    Left = 489
    Top = 456
  end
  object dsLocacao: TDataSource
    DataSet = cdsLocacao
    Left = 222
    Top = 460
  end
  object dsItemLocacao: TDataSource
    DataSet = cdsItemLocacao
    Left = 310
    Top = 460
  end
  object dsItemVenda: TDataSource
    DataSet = cdsItemVenda
    Left = 673
    Top = 454
  end
  object dsVenda: TDataSource
    DataSet = cdsVenda
    Left = 592
    Top = 456
  end
  object dsItemReserva: TDataSource
    DataSet = cdsItemReserva
    Left = 120
    Top = 460
  end
  object dsReserva: TDataSource
    DataSet = cdsReserva
    Left = 37
    Top = 460
  end
  object qryUsuario: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Usuario')
    SQLConnection = SQLConnection
    Left = 22
    Top = 72
    object qryUsuarioCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryUsuarioNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object qryUsuarioLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 10
    end
    object qryUsuarioSENHA: TStringField
      FieldName = 'SENHA'
      Size = 10
    end
  end
  object dspUsuario: TDataSetProvider
    DataSet = qryUsuario
    Left = 22
    Top = 120
  end
  object cdsUsuario: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUsuario'
    Left = 22
    Top = 168
    object cdsUsuarioCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsUsuarioNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object cdsUsuarioLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 10
    end
    object cdsUsuarioSENHA: TStringField
      FieldName = 'SENHA'
      Size = 10
    end
  end
  object dsUsuario: TDataSource
    DataSet = cdsUsuario
    Left = 22
    Top = 216
  end
  object qryContaPagar: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Conta_Pagar')
    SQLConnection = SQLConnection
    Left = 568
    Top = 72
    object qryContaPagarCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryContaPagarCOD_COMPRA: TIntegerField
      FieldName = 'COD_COMPRA'
    end
    object qryContaPagarCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
    end
    object qryContaPagarVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object qryContaPagarVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object qryContaPagarPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object qryContaPagarOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object qryContaPagarTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
    object qryContaPagarVENCIMENTO: TDateField
      FieldName = 'VENCIMENTO'
    end
  end
  object qryContaReceber: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Conta_Receber')
    SQLConnection = SQLConnection
    Left = 664
    Top = 71
    object qryContaReceberCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryContaReceberCOD_LOCACAO: TIntegerField
      FieldName = 'COD_LOCACAO'
    end
    object qryContaReceberCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
    end
    object qryContaReceberCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object qryContaReceberVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object qryContaReceberVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object qryContaReceberPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object qryContaReceberTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
  end
  object dspContaPagar: TDataSetProvider
    DataSet = qryContaPagar
    Left = 568
    Top = 116
  end
  object dspContaReceber: TDataSetProvider
    DataSet = qryContaReceber
    Left = 664
    Top = 115
  end
  object cdsContaPagar: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspContaPagar'
    Left = 568
    Top = 160
    object cdsContaPagarCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsContaPagarCOD_COMPRA: TIntegerField
      FieldName = 'COD_COMPRA'
    end
    object cdsContaPagarCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
    end
    object cdsContaPagarVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object cdsContaPagarVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object cdsContaPagarPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object cdsContaPagarOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object cdsContaPagarTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
    object cdsContaPagarVENCIMENTO: TDateField
      FieldName = 'VENCIMENTO'
    end
  end
  object cdsContaReceber: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspContaReceber'
    Left = 664
    Top = 160
    object cdsContaReceberCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsContaReceberCOD_LOCACAO: TIntegerField
      FieldName = 'COD_LOCACAO'
    end
    object cdsContaReceberCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
    end
    object cdsContaReceberCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object cdsContaReceberVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object cdsContaReceberVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object cdsContaReceberPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object cdsContaReceberTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
  end
  object dsContaPagar: TDataSource
    DataSet = cdsContaPagar
    Left = 568
    Top = 208
  end
  object dsContaReceber: TDataSource
    DataSet = cdsContaReceber
    Left = 664
    Top = 208
  end
  object qryEntradaFinanceira: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Entrada_Financeira')
    SQLConnection = SQLConnection
    Left = 784
    Top = 69
    object qryEntradaFinanceiraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryEntradaFinanceiraCOD_LOCACAO: TIntegerField
      FieldName = 'COD_LOCACAO'
    end
    object qryEntradaFinanceiraCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
    end
    object qryEntradaFinanceiraCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object qryEntradaFinanceiraTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
    object qryEntradaFinanceiraVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object qryEntradaFinanceiraDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
  end
  object dspEntradaFinanceira: TDataSetProvider
    DataSet = qryEntradaFinanceira
    Left = 785
    Top = 114
  end
  object cdsEntradaFinanceira: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspEntradaFinanceira'
    Left = 785
    Top = 159
    object cdsEntradaFinanceiraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsEntradaFinanceiraCOD_LOCACAO: TIntegerField
      FieldName = 'COD_LOCACAO'
    end
    object cdsEntradaFinanceiraCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
    end
    object cdsEntradaFinanceiraCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object cdsEntradaFinanceiraTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
    object cdsEntradaFinanceiraVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object cdsEntradaFinanceiraDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
  end
  object dsEntradaFinanceira: TDataSource
    DataSet = cdsEntradaFinanceira
    Left = 786
    Top = 207
  end
  object qrySaidaFinanceira: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Saida_Financeira')
    SQLConnection = SQLConnection
    Left = 888
    Top = 69
    object qrySaidaFinanceiraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qrySaidaFinanceiraCOD_COMPRA: TIntegerField
      FieldName = 'COD_COMPRA'
    end
    object qrySaidaFinanceiraCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
    end
    object qrySaidaFinanceiraTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
    object qrySaidaFinanceiraVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object qrySaidaFinanceiraDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
    object qrySaidaFinanceiraOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 300
    end
  end
  object dspSaidaFinanceira: TDataSetProvider
    DataSet = qrySaidaFinanceira
    Left = 889
    Top = 114
  end
  object cdsSaidaFinanceira: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSaidaFinanceira'
    Left = 889
    Top = 159
    object cdsSaidaFinanceiraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsSaidaFinanceiraCOD_COMPRA: TIntegerField
      FieldName = 'COD_COMPRA'
    end
    object cdsSaidaFinanceiraCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
    end
    object cdsSaidaFinanceiraTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
    object cdsSaidaFinanceiraVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object cdsSaidaFinanceiraDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
    object cdsSaidaFinanceiraOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 300
    end
  end
  object dsSaidaFinanceira: TDataSource
    DataSet = cdsSaidaFinanceira
    Left = 890
    Top = 207
  end
  object cdsProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProduto'
    Left = 290
    Top = 164
    object cdsProdutoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsProdutoCODIGO2: TStringField
      FieldName = 'CODIGO2'
      Size = 5
    end
    object cdsProdutoCOD_TIPO_PRODUTO: TIntegerField
      FieldName = 'COD_TIPO_PRODUTO'
    end
    object cdsProdutoNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object cdsProdutoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 300
    end
    object cdsProdutoVALOR_LOCACAO: TFMTBCDField
      FieldName = 'VALOR_LOCACAO'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsProdutoVALOR_VENDA: TFMTBCDField
      FieldName = 'VALOR_VENDA'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsProdutoVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsProdutoMARCA: TStringField
      FieldName = 'MARCA'
      Size = 50
    end
    object cdsProdutoTAMANHO: TIntegerField
      FieldName = 'TAMANHO'
    end
    object cdsProdutoSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
    object cdsProdutoDATA_VENDA: TSQLTimeStampField
      FieldName = 'DATA_VENDA'
    end
  end
  object qryConfiguracaoComissao: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Configuracoes_Comissao')
    SQLConnection = SQLConnection
    Left = 824
    Top = 312
    object qryConfiguracaoComissaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryConfiguracaoComissaoCOMISSAO_LOC_HC_SEG_SEX: TFMTBCDField
      FieldName = 'COMISSAO_LOC_HC_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoCOMISSAO_LOC_HE_SEG_SEX: TFMTBCDField
      FieldName = 'COMISSAO_LOC_HE_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoCOMISSAO_LOC_HC_SAB: TFMTBCDField
      FieldName = 'COMISSAO_LOC_HC_SAB'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoCOMISSAO_LOC_HE_SAB: TFMTBCDField
      FieldName = 'COMISSAO_LOC_HE_SAB'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoCOMISSAO_VEN_HC_SEG_SEX: TFMTBCDField
      FieldName = 'COMISSAO_VEN_HC_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoCOMISSAO_VEN_HE_SEG_SEX: TFMTBCDField
      FieldName = 'COMISSAO_VEN_HE_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoCOMISSAO_VEN_HC_SAB: TFMTBCDField
      FieldName = 'COMISSAO_VEN_HC_SAB'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoCOMISSAO_VEN_HE_SAB: TFMTBCDField
      FieldName = 'COMISSAO_VEN_HE_SAB'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoBONIFICACAO_LOC_HC_SEG_SEX: TFMTBCDField
      FieldName = 'BONIFICACAO_LOC_HC_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoBONIFICACAO_LOC_HE_SEG_SEX: TFMTBCDField
      FieldName = 'BONIFICACAO_LOC_HE_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoBONIFICACAO_LOC_HC_SAB: TFMTBCDField
      FieldName = 'BONIFICACAO_LOC_HC_SAB'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoBONIFICACAO_LOC_HE_SAB: TFMTBCDField
      FieldName = 'BONIFICACAO_LOC_HE_SAB'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoBONIFICACAO_VEN_HC_SEG_SEX: TFMTBCDField
      FieldName = 'BONIFICACAO_VEN_HC_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoBONIFICACAO_VEN_HE_SEG_SEX: TFMTBCDField
      FieldName = 'BONIFICACAO_VEN_HE_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoBONIFICACAO_VEN_HC_SAB: TFMTBCDField
      FieldName = 'BONIFICACAO_VEN_HC_SAB'
      Precision = 15
      Size = 2
    end
    object qryConfiguracaoComissaoBONIFICACAO_VEN_HE_SAB: TFMTBCDField
      FieldName = 'BONIFICACAO_VEN_HE_SAB'
      Precision = 15
      Size = 2
    end
  end
  object dspConfiguracaoComissao: TDataSetProvider
    DataSet = qryConfiguracaoComissao
    Left = 824
    Top = 358
  end
  object cdsConfiguracaoComissao: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConfiguracaoComissao'
    Left = 824
    Top = 406
    object cdsConfiguracaoComissaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsConfiguracaoComissaoCOMISSAO_LOC_HC_SEG_SEX: TFMTBCDField
      FieldName = 'COMISSAO_LOC_HC_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoCOMISSAO_LOC_HE_SEG_SEX: TFMTBCDField
      FieldName = 'COMISSAO_LOC_HE_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoCOMISSAO_LOC_HC_SAB: TFMTBCDField
      FieldName = 'COMISSAO_LOC_HC_SAB'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoCOMISSAO_LOC_HE_SAB: TFMTBCDField
      FieldName = 'COMISSAO_LOC_HE_SAB'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoCOMISSAO_VEN_HC_SEG_SEX: TFMTBCDField
      FieldName = 'COMISSAO_VEN_HC_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoCOMISSAO_VEN_HE_SEG_SEX: TFMTBCDField
      FieldName = 'COMISSAO_VEN_HE_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoCOMISSAO_VEN_HC_SAB: TFMTBCDField
      FieldName = 'COMISSAO_VEN_HC_SAB'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoCOMISSAO_VEN_HE_SAB: TFMTBCDField
      FieldName = 'COMISSAO_VEN_HE_SAB'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoBONIFICACAO_LOC_HC_SEG_SEX: TFMTBCDField
      FieldName = 'BONIFICACAO_LOC_HC_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoBONIFICACAO_LOC_HE_SEG_SEX: TFMTBCDField
      FieldName = 'BONIFICACAO_LOC_HE_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoBONIFICACAO_LOC_HC_SAB: TFMTBCDField
      FieldName = 'BONIFICACAO_LOC_HC_SAB'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoBONIFICACAO_LOC_HE_SAB: TFMTBCDField
      FieldName = 'BONIFICACAO_LOC_HE_SAB'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoBONIFICACAO_VEN_HC_SEG_SEX: TFMTBCDField
      FieldName = 'BONIFICACAO_VEN_HC_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoBONIFICACAO_VEN_HE_SEG_SEX: TFMTBCDField
      FieldName = 'BONIFICACAO_VEN_HE_SEG_SEX'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoBONIFICACAO_VEN_HC_SAB: TFMTBCDField
      FieldName = 'BONIFICACAO_VEN_HC_SAB'
      Precision = 15
      Size = 2
    end
    object cdsConfiguracaoComissaoBONIFICACAO_VEN_HE_SAB: TFMTBCDField
      FieldName = 'BONIFICACAO_VEN_HE_SAB'
      Precision = 15
      Size = 2
    end
  end
  object dsConfiguracaoComissao: TDataSource
    DataSet = cdsConfiguracaoComissao
    Left = 824
    Top = 454
  end
  object qryTipoProduto: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Tipo_Produto')
    SQLConnection = SQLConnection
    Left = 368
    Top = 70
    object qryTipoProdutoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryTipoProdutoTIPO: TStringField
      FieldName = 'TIPO'
      Size = 30
    end
    object qryTipoProdutoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
  end
  object dspTipoProduto: TDataSetProvider
    DataSet = qryTipoProduto
    Left = 368
    Top = 117
  end
  object dsTipoProduto: TDataSource
    DataSet = cdsTipoProduto
    Left = 368
    Top = 213
  end
  object cdsTipoProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTipoProduto'
    Left = 370
    Top = 164
    object cdsTipoProdutoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsTipoProdutoTIPO: TStringField
      FieldName = 'TIPO'
      Size = 30
    end
    object cdsTipoProdutoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
  end
  object qryCodigoProduto: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Codigo_Produto')
    SQLConnection = SQLConnection
    Left = 465
    Top = 70
    object qryCodigoProdutoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryCodigoProdutoA: TIntegerField
      FieldName = 'A'
    end
    object qryCodigoProdutoB: TIntegerField
      FieldName = 'B'
    end
    object qryCodigoProdutoC: TIntegerField
      FieldName = 'C'
    end
    object qryCodigoProdutoD: TIntegerField
      FieldName = 'D'
    end
    object qryCodigoProdutoE: TIntegerField
      FieldName = 'E'
    end
    object qryCodigoProdutoF: TIntegerField
      FieldName = 'F'
    end
    object qryCodigoProdutoG: TIntegerField
      FieldName = 'G'
    end
    object qryCodigoProdutoH: TIntegerField
      FieldName = 'H'
    end
    object qryCodigoProdutoI: TIntegerField
      FieldName = 'I'
    end
    object qryCodigoProdutoJ: TIntegerField
      FieldName = 'J'
    end
    object qryCodigoProdutoL: TIntegerField
      FieldName = 'L'
    end
    object qryCodigoProdutoM: TIntegerField
      FieldName = 'M'
    end
    object qryCodigoProdutoN: TIntegerField
      FieldName = 'N'
    end
    object qryCodigoProdutoO: TIntegerField
      FieldName = 'O'
    end
    object qryCodigoProdutoP: TIntegerField
      FieldName = 'P'
    end
    object qryCodigoProdutoQ: TIntegerField
      FieldName = 'Q'
    end
    object qryCodigoProdutoR: TIntegerField
      FieldName = 'R'
    end
    object qryCodigoProdutoS: TIntegerField
      FieldName = 'S'
    end
    object qryCodigoProdutoT: TIntegerField
      FieldName = 'T'
    end
    object qryCodigoProdutoU: TIntegerField
      FieldName = 'U'
    end
    object qryCodigoProdutoV: TIntegerField
      FieldName = 'V'
    end
    object qryCodigoProdutoX: TIntegerField
      FieldName = 'X'
    end
    object qryCodigoProdutoZ: TIntegerField
      FieldName = 'Z'
    end
    object qryCodigoProdutoY: TIntegerField
      FieldName = 'Y'
    end
    object qryCodigoProdutoW: TIntegerField
      FieldName = 'W'
    end
    object qryCodigoProdutoK: TIntegerField
      FieldName = 'K'
    end
  end
  object dspCodigoProduto: TDataSetProvider
    DataSet = qryCodigoProduto
    Left = 465
    Top = 117
  end
  object dsCodigoProduto: TDataSource
    DataSet = cdsCodigoProduto
    Left = 465
    Top = 213
  end
  object cdsCodigoProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCodigoProduto'
    Left = 467
    Top = 164
    object cdsCodigoProdutoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsCodigoProdutoA: TIntegerField
      FieldName = 'A'
    end
    object cdsCodigoProdutoB: TIntegerField
      FieldName = 'B'
    end
    object cdsCodigoProdutoC: TIntegerField
      FieldName = 'C'
    end
    object cdsCodigoProdutoD: TIntegerField
      FieldName = 'D'
    end
    object cdsCodigoProdutoE: TIntegerField
      FieldName = 'E'
    end
    object cdsCodigoProdutoF: TIntegerField
      FieldName = 'F'
    end
    object cdsCodigoProdutoG: TIntegerField
      FieldName = 'G'
    end
    object cdsCodigoProdutoH: TIntegerField
      FieldName = 'H'
    end
    object cdsCodigoProdutoI: TIntegerField
      FieldName = 'I'
    end
    object cdsCodigoProdutoJ: TIntegerField
      FieldName = 'J'
    end
    object cdsCodigoProdutoL: TIntegerField
      FieldName = 'L'
    end
    object cdsCodigoProdutoM: TIntegerField
      FieldName = 'M'
    end
    object cdsCodigoProdutoN: TIntegerField
      FieldName = 'N'
    end
    object cdsCodigoProdutoO: TIntegerField
      FieldName = 'O'
    end
    object cdsCodigoProdutoP: TIntegerField
      FieldName = 'P'
    end
    object cdsCodigoProdutoQ: TIntegerField
      FieldName = 'Q'
    end
    object cdsCodigoProdutoR: TIntegerField
      FieldName = 'R'
    end
    object cdsCodigoProdutoS: TIntegerField
      FieldName = 'S'
    end
    object cdsCodigoProdutoT: TIntegerField
      FieldName = 'T'
    end
    object cdsCodigoProdutoU: TIntegerField
      FieldName = 'U'
    end
    object cdsCodigoProdutoV: TIntegerField
      FieldName = 'V'
    end
    object cdsCodigoProdutoX: TIntegerField
      FieldName = 'X'
    end
    object cdsCodigoProdutoZ: TIntegerField
      FieldName = 'Z'
    end
    object cdsCodigoProdutoY: TIntegerField
      FieldName = 'Y'
    end
    object cdsCodigoProdutoW: TIntegerField
      FieldName = 'W'
    end
    object cdsCodigoProdutoK: TIntegerField
      FieldName = 'K'
    end
  end
  object qryComissaoFuncionario: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Comissao_Funcionario')
    SQLConnection = SQLConnection
    Left = 952
    Top = 312
    object qryComissaoFuncionarioCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryComissaoFuncionarioCOD_FUNCIONARIO: TIntegerField
      FieldName = 'COD_FUNCIONARIO'
    end
    object qryComissaoFuncionarioCOD_LOCACAO: TIntegerField
      FieldName = 'COD_LOCACAO'
    end
    object qryComissaoFuncionarioCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
    end
    object qryComissaoFuncionarioVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object qryComissaoFuncionarioDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
  end
  object dspComissaoFuncionario: TDataSetProvider
    DataSet = qryComissaoFuncionario
    Left = 952
    Top = 358
  end
  object cdsComissaoFuncionario: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspComissaoFuncionario'
    Left = 952
    Top = 406
    object cdsComissaoFuncionarioCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsComissaoFuncionarioCOD_FUNCIONARIO: TIntegerField
      FieldName = 'COD_FUNCIONARIO'
    end
    object cdsComissaoFuncionarioCOD_LOCACAO: TIntegerField
      FieldName = 'COD_LOCACAO'
    end
    object cdsComissaoFuncionarioCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
    end
    object cdsComissaoFuncionarioVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object cdsComissaoFuncionarioDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
  end
  object dsComissaoFuncionario: TDataSource
    DataSet = cdsComissaoFuncionario
    Left = 952
    Top = 454
  end
  object qryPesquisaCliente: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Cliente')
    SQLConnection = SQLConnection
    Left = 38
    Top = 533
    object IntegerField1: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object StringField2: TStringField
      FieldName = 'RUA'
      Size = 100
    end
    object IntegerField2: TIntegerField
      FieldName = 'NUMERO_CASA'
    end
    object StringField3: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object StringField4: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object StringField5: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object StringField6: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object StringField7: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object StringField8: TStringField
      FieldName = 'TELEFONE'
      Size = 14
    end
    object StringField9: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
    object StringField10: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
    object StringField11: TStringField
      FieldName = 'ESTADO_CIVIL'
      Size = 15
    end
    object StringField12: TStringField
      FieldName = 'LOCAL_TRABALHO'
      Size = 100
    end
    object DateField1: TDateField
      FieldName = 'DATA_FICHA'
    end
  end
  object dspPesquisaCliente: TDataSetProvider
    DataSet = qryPesquisaCliente
    Left = 38
    Top = 581
  end
  object cdsPesquisaCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPesquisaCliente'
    Left = 38
    Top = 629
    object IntegerField3: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object StringField13: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object StringField14: TStringField
      FieldName = 'RUA'
      Size = 100
    end
    object IntegerField4: TIntegerField
      FieldName = 'NUMERO_CASA'
    end
    object StringField15: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object StringField16: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object StringField17: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object StringField18: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object StringField19: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object StringField20: TStringField
      FieldName = 'TELEFONE'
      Size = 14
    end
    object StringField21: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
    object StringField22: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
    object StringField23: TStringField
      FieldName = 'ESTADO_CIVIL'
      Size = 15
    end
    object StringField24: TStringField
      FieldName = 'LOCAL_TRABALHO'
      Size = 100
    end
    object DateField2: TDateField
      FieldName = 'DATA_FICHA'
    end
  end
  object dsPesquisaCliente: TDataSource
    DataSet = cdsPesquisaCliente
    Left = 38
    Top = 677
  end
  object qryPesquisaFornecedor: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Fornecedor')
    SQLConnection = SQLConnection
    Left = 166
    Top = 534
    object IntegerField5: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object StringField25: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 100
    end
    object StringField26: TStringField
      FieldName = 'NOME_FANTASIA'
      Size = 100
    end
    object StringField27: TStringField
      FieldName = 'CNPJ'
      Size = 30
    end
    object StringField28: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Size = 30
    end
    object StringField29: TStringField
      FieldName = 'ENDERECO'
      Size = 100
    end
    object StringField30: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object StringField31: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object StringField32: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object StringField33: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object StringField34: TStringField
      FieldName = 'E_MAIL'
      Size = 80
    end
    object StringField35: TStringField
      FieldName = 'HOME_PAGE'
      Size = 80
    end
    object StringField36: TStringField
      FieldName = 'TELEFONE'
      Size = 14
    end
    object StringField37: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
    object StringField38: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 100
    end
    object DateField3: TDateField
      FieldName = 'DATA_FICHA'
    end
  end
  object dspPesquisaFornecedor: TDataSetProvider
    DataSet = qryPesquisaFornecedor
    Left = 166
    Top = 582
  end
  object cdsPesquisaFornecedor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPesquisaFornecedor'
    Left = 166
    Top = 630
    object IntegerField6: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object StringField39: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 100
    end
    object StringField40: TStringField
      FieldName = 'NOME_FANTASIA'
      Size = 100
    end
    object StringField41: TStringField
      FieldName = 'CNPJ'
      Size = 30
    end
    object StringField42: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Size = 30
    end
    object StringField43: TStringField
      FieldName = 'ENDERECO'
      Size = 100
    end
    object StringField44: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object StringField45: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object StringField46: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object StringField47: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object StringField48: TStringField
      FieldName = 'E_MAIL'
      Size = 80
    end
    object StringField49: TStringField
      FieldName = 'HOME_PAGE'
      Size = 80
    end
    object StringField50: TStringField
      FieldName = 'TELEFONE'
      Size = 14
    end
    object StringField51: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
    object StringField52: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 100
    end
    object DateField4: TDateField
      FieldName = 'DATA_FICHA'
    end
  end
  object dsPesquisaFornecedor: TDataSource
    DataSet = cdsPesquisaFornecedor
    Left = 166
    Top = 678
  end
  object qryPesquisaProduto: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Produto')
    SQLConnection = SQLConnection
    Left = 320
    Top = 534
    object IntegerField7: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object StringField53: TStringField
      FieldName = 'CODIGO2'
      Size = 5
    end
    object IntegerField8: TIntegerField
      FieldName = 'COD_TIPO_PRODUTO'
    end
    object StringField54: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object StringField55: TStringField
      FieldName = 'DESCRICAO'
      Size = 300
    end
    object FMTBCDField1: TFMTBCDField
      FieldName = 'VALOR_LOCACAO'
      Precision = 15
      Size = 2
    end
    object FMTBCDField2: TFMTBCDField
      FieldName = 'VALOR_VENDA'
      Precision = 15
      Size = 2
    end
    object FMTBCDField3: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object StringField56: TStringField
      FieldName = 'MARCA'
      Size = 50
    end
    object IntegerField9: TIntegerField
      FieldName = 'TAMANHO'
    end
    object IntegerField10: TIntegerField
      FieldName = 'STATUS'
    end
    object SQLTimeStampField1: TSQLTimeStampField
      FieldName = 'DATA_VENDA'
    end
  end
  object dspPesquisaProduto: TDataSetProvider
    DataSet = qryPesquisaProduto
    Left = 320
    Top = 581
  end
  object dsPesquisaProduto: TDataSource
    DataSet = cdsPesquisaProduto
    Left = 320
    Top = 677
  end
  object cdsPesquisaProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPesquisaProduto'
    Left = 322
    Top = 628
    object IntegerField11: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object StringField57: TStringField
      FieldName = 'CODIGO2'
      Size = 5
    end
    object IntegerField12: TIntegerField
      FieldName = 'COD_TIPO_PRODUTO'
    end
    object StringField58: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object StringField59: TStringField
      FieldName = 'DESCRICAO'
      Size = 300
    end
    object FMTBCDField4: TFMTBCDField
      FieldName = 'VALOR_LOCACAO'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object FMTBCDField5: TFMTBCDField
      FieldName = 'VALOR_VENDA'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object FMTBCDField6: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object StringField60: TStringField
      FieldName = 'MARCA'
      Size = 50
    end
    object IntegerField13: TIntegerField
      FieldName = 'TAMANHO'
    end
    object IntegerField14: TIntegerField
      FieldName = 'STATUS'
    end
    object SQLTimeStampField2: TSQLTimeStampField
      FieldName = 'DATA_VENDA'
    end
  end
  object qryPesquisaTipoProduto: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Tipo_Produto')
    SQLConnection = SQLConnection
    Left = 472
    Top = 531
    object IntegerField15: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object StringField61: TStringField
      FieldName = 'TIPO'
      Size = 30
    end
    object StringField62: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
  end
  object dspPesquisaTipoProduto: TDataSetProvider
    DataSet = qryPesquisaTipoProduto
    Left = 472
    Top = 578
  end
  object dsPesquisaTipoProduto: TDataSource
    DataSet = cdsPesquisaTipoProduto
    Left = 472
    Top = 674
  end
  object cdsPesquisaTipoProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPesquisaTipoProduto'
    Left = 474
    Top = 625
    object IntegerField16: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object StringField63: TStringField
      FieldName = 'TIPO'
      Size = 30
    end
    object StringField64: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
  end
end
