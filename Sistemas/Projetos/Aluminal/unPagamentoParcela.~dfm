object frmPagamentoParcela: TfrmPagamentoParcela
  Left = 583
  Top = 249
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'PAGAMENTO DA PARCELA'
  ClientHeight = 581
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grpBxPedido: TGroupBox
    Left = 0
    Top = 0
    Width = 616
    Height = 129
    Align = alTop
    Caption = 'Pedido '
    TabOrder = 0
    object lblInfCliente: TLabel
      Left = 10
      Top = 48
      Width = 38
      Height = 13
      Caption = 'Cliente: '
    end
    object lblCliente: TLabel
      Left = 70
      Top = 48
      Width = 42
      Height = 13
      Caption = 'lblCliente'
    end
    object lblInfValorTotal: TLabel
      Left = 10
      Top = 72
      Width = 54
      Height = 13
      Caption = 'Valor Total:'
    end
    object lblValorTotal: TLabel
      Left = 70
      Top = 72
      Width = 58
      Height = 13
      Caption = 'lblValorTotal'
    end
    object lblInfDescricaoPedido: TLabel
      Left = 10
      Top = 96
      Width = 51
      Height = 13
      Caption = 'Descri'#231#227'o:'
    end
    object lblDescricaoPedido: TLabel
      Left = 70
      Top = 96
      Width = 91
      Height = 13
      Caption = 'lblDescricaoPedido'
    end
    object lblNroPedido: TLabel
      Left = 70
      Top = 24
      Width = 60
      Height = 13
      Caption = 'lblNroPedido'
    end
    object lblInfNroPedido: TLabel
      Left = 10
      Top = 24
      Width = 54
      Height = 13
      Caption = 'N '#186' Pedido:'
    end
  end
  object grpBxParcelas: TGroupBox
    Left = 0
    Top = 129
    Width = 616
    Height = 238
    Align = alTop
    Caption = 'Parcelas '
    TabOrder = 1
    object grParcelas: TDBGrid
      Left = 2
      Top = 15
      Width = 612
      Height = 221
      Align = alClient
      DataSource = dsDados
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = grParcelasDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'VALOR_PARCELA'
          Title.Caption = 'Valor da Parcela'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_VCTO'
          Title.Caption = 'Dt. Vcto'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_PGTO'
          Title.Caption = 'Dt. Pgto'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 234
          Visible = True
        end>
    end
  end
  object pnlPagar: TPanel
    Left = 0
    Top = 367
    Width = 616
    Height = 157
    Align = alClient
    TabOrder = 2
    object lblValorPago: TLabel
      Left = 7
      Top = 18
      Width = 54
      Height = 13
      Caption = 'Valor pago:'
    end
    object lblDescricao: TLabel
      Left = 7
      Top = 50
      Width = 51
      Height = 13
      Caption = 'Descri'#231#227'o:'
    end
    object edValorPago: TPlsEdit
      Left = 66
      Top = 12
      Width = 121
      Height = 21
      TabOrder = 0
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = monetario2
    end
    object btnPagar: TBitBtn
      Left = 464
      Top = 112
      Width = 137
      Height = 33
      Caption = 'Pagar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnPagarClick
    end
    object ckBxEmitirRecibo: TCheckBox
      Left = 368
      Top = 128
      Width = 81
      Height = 17
      Caption = 'Emitir recibo'
      TabOrder = 2
    end
    object mmDescricao: TPlsMemo
      Left = 66
      Top = 50
      Width = 539
      Height = 47
      TabOrder = 3
      plsCorRecebeFoco = clSilver
    end
  end
  object grpBxLegenda: TGroupBox
    Left = 0
    Top = 524
    Width = 616
    Height = 57
    Align = alBottom
    Caption = 'Legenda '
    TabOrder = 3
    object shpLegendaParcelaPaga: TShape
      Left = 24
      Top = 22
      Width = 20
      Height = 20
      Brush.Color = clAqua
      Pen.Color = clAqua
      Shape = stCircle
    end
    object lblLegendaParcelaPaga: TLabel
      Left = 47
      Top = 26
      Width = 82
      Height = 16
      Caption = 'Parcela paga'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblLegendaParcelaVencida: TLabel
      Left = 183
      Top = 26
      Width = 98
      Height = 16
      Caption = 'Parcela vencida'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object shpLegendaParcelaVencida: TShape
      Left = 158
      Top = 22
      Width = 20
      Height = 20
      Brush.Color = clRed
      Pen.Color = clRed
      Shape = stCircle
    end
    object lblLegendaParcelaNoPrazo: TLabel
      Left = 503
      Top = 26
      Width = 102
      Height = 16
      Caption = 'Parcela no prazo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object shpLegendaParcelaNoPrazo: TShape
      Left = 478
      Top = 22
      Width = 20
      Height = 20
      Brush.Color = clSilver
      Pen.Color = clYellow
      Shape = stCircle
    end
    object lblLegendaParcelaVenceHoje: TLabel
      Left = 337
      Top = 26
      Width = 116
      Height = 16
      Caption = 'Parcela vence hoje'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object shpLegendaParcelaVenceHoje: TShape
      Left = 312
      Top = 22
      Width = 20
      Height = 20
      Brush.Color = clYellow
      Pen.Color = clYellow
      Shape = stCircle
    end
  end
  object zQryPedido: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT'
      
        '    ped.codigo, ped.descricao, ped.valor_total, ped.status, ped.' +
        'condicao_pagamento,'
      '    c.nome'
      'FROM pedido ped'
      'JOIN cliente c ON ped.cod_cliente = c.codigo'
      'JOIN pagamento_pedido pp ON ped.codigo = pp.cod_pedido'
      'WHERE 1=2')
    Params = <>
    Left = 16
    Top = 184
    object zQryPedidoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryPedidoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 1000
    end
    object zQryPedidoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      Required = True
    end
    object zQryPedidoSTATUS: TIntegerField
      FieldName = 'STATUS'
      Required = True
    end
    object zQryPedidoCONDICAO_PAGAMENTO: TIntegerField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryPedidoNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
  end
  object dspPedido: TDataSetProvider
    DataSet = zQryPedido
    Left = 46
    Top = 184
  end
  object cdsPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedido'
    Left = 75
    Top = 184
    object cdsPedidoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsPedidoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 1000
    end
    object cdsPedidoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      Required = True
    end
    object cdsPedidoSTATUS: TIntegerField
      FieldName = 'STATUS'
      Required = True
    end
    object cdsPedidoCONDICAO_PAGAMENTO: TIntegerField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object cdsPedidoNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
  end
  object zQryParcelasPedido: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT'
      
        '    pp.codigo, pp.valor_parcela, pp.data_vcto, pp.data_pgto, pp.' +
        'descricao,'
      '    ped.codigo AS codigoPedido,'
      '    pp.numero_parcela,'
      '    ped.cod_cliente AS codigoCliente'
      'FROM pagamento_pedido pp'
      'JOIN pedido ped ON pp.cod_pedido = ped.codigo'
      'WHERE 1=2'
      'ORDER BY pp.data_pgto, pp.data_vcto')
    Params = <>
    Left = 16
    Top = 216
    object zQryParcelasPedidoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryParcelasPedidoVALOR_PARCELA: TFloatField
      FieldName = 'VALOR_PARCELA'
      Required = True
    end
    object zQryParcelasPedidoDATA_VCTO: TDateField
      FieldName = 'DATA_VCTO'
    end
    object zQryParcelasPedidoDATA_PGTO: TDateField
      FieldName = 'DATA_PGTO'
    end
    object zQryParcelasPedidoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 500
    end
    object zQryParcelasPedidoCODIGOPEDIDO: TIntegerField
      FieldName = 'CODIGOPEDIDO'
      Required = True
    end
    object zQryParcelasPedidoCODIGOCLIENTE: TIntegerField
      FieldName = 'CODIGOCLIENTE'
      Required = True
    end
    object zQryParcelasPedidoNUMERO_PARCELA: TIntegerField
      FieldName = 'NUMERO_PARCELA'
      Required = True
    end
  end
  object dspParcelasPedido: TDataSetProvider
    DataSet = zQryParcelasPedido
    Left = 46
    Top = 216
  end
  object cdsParcelasPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspParcelasPedido'
    Left = 75
    Top = 216
    object cdsParcelasPedidoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsParcelasPedidoVALOR_PARCELA: TFloatField
      FieldName = 'VALOR_PARCELA'
      Required = True
    end
    object cdsParcelasPedidoDATA_VCTO: TDateField
      FieldName = 'DATA_VCTO'
    end
    object cdsParcelasPedidoDATA_PGTO: TDateField
      DisplayLabel = 'Data Pgto'
      FieldName = 'DATA_PGTO'
    end
    object cdsParcelasPedidoDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 500
    end
    object cdsParcelasPedidoCODIGOPEDIDO: TIntegerField
      FieldName = 'CODIGOPEDIDO'
      Required = True
    end
    object cdsParcelasPedidoCODIGOCLIENTE: TIntegerField
      FieldName = 'CODIGOCLIENTE'
      Required = True
    end
    object cdsParcelasPedidoNUMERO_PARCELA: TIntegerField
      FieldName = 'NUMERO_PARCELA'
      Required = True
    end
  end
  object dsParcelasPedido: TDataSource
    DataSet = cdsParcelasPedido
    Left = 104
    Top = 216
  end
  object dsDados: TDataSource
    DataSet = cdsExibeDados
    Left = 45
    Top = 248
  end
  object cdsExibeDados: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsExibeDadosAfterScroll
    Left = 17
    Top = 248
  end
end
