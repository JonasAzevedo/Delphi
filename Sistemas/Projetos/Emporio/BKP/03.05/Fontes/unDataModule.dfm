object DM: TDM
  OldCreateOrder = False
  Left = 472
  Top = 26
  Height = 497
  Width = 368
  object SQLConnection: TSQLConnection
    ConnectionName = 'Emporio'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=C:\Emporio\BD\BD.FDB'
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
    Connected = True
    Left = 152
    Top = 24
  end
  object qryCliente: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Cliente')
    SQLConnection = SQLConnection
    Left = 72
    Top = 84
    object qryClienteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryClienteNOME: TStringField
      FieldName = 'NOME'
      Size = 80
    end
    object qryClienteENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 80
    end
    object qryClienteBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 80
    end
    object qryClienteCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 50
    end
    object qryClienteUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object qryClienteCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object qryClienteTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 14
    end
    object qryClienteCELULAR: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
    object qryClienteCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object qryClienteIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
      Size = 30
    end
    object qryClienteDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object qryClienteSEXO: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
    object qryClienteESTADO_CIVIL: TStringField
      FieldName = 'ESTADO_CIVIL'
      Size = 15
    end
    object qryClienteNATURALIDADE: TStringField
      FieldName = 'NATURALIDADE'
      Size = 50
    end
    object qryClienteDATA_FICHA: TSQLTimeStampField
      FieldName = 'DATA_FICHA'
    end
  end
  object qryFornecedor: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Fornecedor')
    SQLConnection = SQLConnection
    Left = 152
    Top = 84
    object qryFornecedorCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryFornecedorRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 80
    end
    object qryFornecedorNOME_FANTASIA: TStringField
      FieldName = 'NOME_FANTASIA'
      Size = 80
    end
    object qryFornecedorENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 80
    end
    object qryFornecedorBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 80
    end
    object qryFornecedorCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 50
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
      Size = 50
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
    object qryFornecedorCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 18
    end
    object qryFornecedorINSCRICAO_ESTADUAL: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Size = 30
    end
    object qryFornecedorREPRESENTANTE: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 80
    end
    object qryFornecedorDATA_FICHA: TSQLTimeStampField
      FieldName = 'DATA_FICHA'
    end
  end
  object dspCliente: TDataSetProvider
    DataSet = qryCliente
    Left = 72
    Top = 125
  end
  object dspFornecedor: TDataSetProvider
    DataSet = qryFornecedor
    Left = 152
    Top = 125
  end
  object cdsCliente: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCliente'
    Left = 72
    Top = 166
    object cdsClienteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsClienteNOME: TStringField
      FieldName = 'NOME'
      Size = 80
    end
    object cdsClienteENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 80
    end
    object cdsClienteBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 80
    end
    object cdsClienteCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 50
    end
    object cdsClienteUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsClienteCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsClienteTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 14
    end
    object cdsClienteCELULAR: TStringField
      FieldName = 'CELULAR'
      Size = 14
    end
    object cdsClienteCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object cdsClienteIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
      Size = 30
    end
    object cdsClienteDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object cdsClienteSEXO: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
    object cdsClienteESTADO_CIVIL: TStringField
      FieldName = 'ESTADO_CIVIL'
      Size = 15
    end
    object cdsClienteNATURALIDADE: TStringField
      FieldName = 'NATURALIDADE'
      Size = 50
    end
    object cdsClienteDATA_FICHA: TSQLTimeStampField
      FieldName = 'DATA_FICHA'
    end
  end
  object cdsFornecedor: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFornecedor'
    Left = 152
    Top = 166
    object cdsFornecedorCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsFornecedorRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 80
    end
    object cdsFornecedorNOME_FANTASIA: TStringField
      FieldName = 'NOME_FANTASIA'
      Size = 80
    end
    object cdsFornecedorENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 80
    end
    object cdsFornecedorBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 80
    end
    object cdsFornecedorCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 50
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
      Size = 50
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
    object cdsFornecedorCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 18
    end
    object cdsFornecedorINSCRICAO_ESTADUAL: TStringField
      FieldName = 'INSCRICAO_ESTADUAL'
      Size = 30
    end
    object cdsFornecedorREPRESENTANTE: TStringField
      FieldName = 'REPRESENTANTE'
      Size = 80
    end
    object cdsFornecedorDATA_FICHA: TSQLTimeStampField
      FieldName = 'DATA_FICHA'
    end
  end
  object dsCliente: TDataSource
    DataSet = cdsCliente
    Left = 72
    Top = 208
  end
  object dsFornecedor: TDataSource
    DataSet = cdsFornecedor
    Left = 152
    Top = 208
  end
  object qryProduto: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Produto')
    SQLConnection = SQLConnection
    Left = 233
    Top = 83
    object qryProdutoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryProdutoNOME: TStringField
      FieldName = 'NOME'
      Size = 80
    end
    object qryProdutoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 300
    end
    object qryProdutoVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object qryProdutoVALOR_VENDA: TFMTBCDField
      FieldName = 'VALOR_VENDA'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object qryProdutoESTOQUE: TFMTBCDField
      FieldName = 'ESTOQUE'
      Precision = 15
      Size = 3
    end
  end
  object dspProduto: TDataSetProvider
    DataSet = qryProduto
    Left = 230
    Top = 125
  end
  object cdsProduto: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProduto'
    Left = 231
    Top = 166
    object cdsProdutoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsProdutoNOME: TStringField
      FieldName = 'NOME'
      Size = 80
    end
    object cdsProdutoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 300
    end
    object cdsProdutoVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
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
    object cdsProdutoESTOQUE: TFMTBCDField
      FieldName = 'ESTOQUE'
      DisplayFormat = '#0.000'
      Precision = 15
      Size = 3
    end
  end
  object dsProduto: TDataSource
    DataSet = cdsProduto
    Left = 231
    Top = 208
  end
  object qryCompra: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Compra')
    SQLConnection = SQLConnection
    Left = 94
    Top = 267
    object qryCompraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryCompraCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object qryCompraCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
    end
    object qryCompraDATA: TDateField
      FieldName = 'DATA'
    end
    object qryCompraQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      Precision = 15
      Size = 3
    end
    object qryCompraPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object qryCompraVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object qryCompraVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object qryCompraESTOQUE: TFMTBCDField
      FieldName = 'ESTOQUE'
      Precision = 15
      Size = 3
    end
    object qryCompraVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
  end
  object dspCompra: TDataSetProvider
    DataSet = qryCompra
    Left = 94
    Top = 309
  end
  object cdsCompra: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCompra'
    Left = 94
    Top = 350
    object cdsCompraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsCompraCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object cdsCompraCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
    end
    object cdsCompraDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsCompraQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      Precision = 15
      Size = 3
    end
    object cdsCompraPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object cdsCompraVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object cdsCompraVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object cdsCompraESTOQUE: TFMTBCDField
      FieldName = 'ESTOQUE'
      Precision = 15
      Size = 3
    end
    object cdsCompraVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
  end
  object dsCompra: TDataSource
    DataSet = cdsCompra
    Left = 95
    Top = 392
  end
  object qryVenda: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Venda')
    SQLConnection = SQLConnection
    Left = 152
    Top = 267
    object qryVendaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryVendaCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object qryVendaDATA: TDateField
      FieldName = 'DATA'
    end
    object qryVendaPAGO: TIntegerField
      FieldName = 'PAGO'
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
  end
  object dspVenda: TDataSetProvider
    DataSet = qryVenda
    Left = 153
    Top = 309
  end
  object cdsVenda: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspVenda'
    Left = 152
    Top = 350
    object cdsVendaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsVendaCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
    end
    object cdsVendaDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsVendaPAGO: TIntegerField
      FieldName = 'PAGO'
    end
    object cdsVendaVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsVendaVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
  end
  object dsVenda: TDataSource
    DataSet = cdsVenda
    Left = 155
    Top = 391
  end
  object cdsItemVenda: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItemVenda'
    Left = 222
    Top = 350
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
    object cdsItemVendaQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      Precision = 15
      Size = 3
    end
    object cdsItemVendaVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
  end
  object dsItemVenda: TDataSource
    DataSet = cdsItemVenda
    Left = 226
    Top = 391
  end
  object dspItemVenda: TDataSetProvider
    DataSet = qryItemVenda
    Left = 224
    Top = 309
  end
  object qryItemVenda: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT * FROM Item_Venda')
    SQLConnection = SQLConnection
    Left = 223
    Top = 267
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
    object qryItemVendaQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      Precision = 15
      Size = 3
    end
    object qryItemVendaVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
  end
end
