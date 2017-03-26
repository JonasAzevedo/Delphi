object frmVisualizarParcelas: TfrmVisualizarParcelas
  Left = 128
  Top = 158
  Width = 1088
  Height = 563
  Caption = 'Pesquisar Parcelas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 1080
    Height = 73
    Align = alTop
    TabOrder = 0
    UseDockManager = True
    Version = '1.9.0.3'
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWindowText
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    FullHeight = 0
  end
  object DBAdvGrid1: TDBAdvGrid
    Left = 8
    Top = 80
    Width = 1025
    Height = 425
    Cursor = crDefault
    ColCount = 5
    RowCount = 2
    FixedRows = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'MS Sans Serif'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'MS Sans Serif'
    FilterDropDown.Font.Style = []
    FilterDropDownClear = '(All)'
    FixedColWidth = 20
    FixedRowHeight = 22
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'MS Sans Serif'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'MS Sans Serif'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'MS Sans Serif'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'MS Sans Serif'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'MS Sans Serif'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurence'
    SearchFooter.HintFindPrev = 'Find previous occurence'
    SearchFooter.HintHighlight = 'Highlight occurences'
    SearchFooter.MatchCaseCaption = 'Match case'
    Version = '2.1.11.0'
    AutoCreateColumns = True
    AutoRemoveColumns = True
    Columns = <
      item
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'MS Sans Serif'
        PrintFont.Style = []
        Width = 20
      end
      item
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        FieldName = 'NOMECLIENTE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'Tahoma'
        PrintFont.Style = []
        Width = 64
      end
      item
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        FieldName = 'VALORTOTALPEDIDO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'Tahoma'
        PrintFont.Style = []
        Width = 64
      end
      item
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        FieldName = 'VALOR_PARCELA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'Tahoma'
        PrintFont.Style = []
        Width = 64
      end
      item
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        FieldName = 'DATA_VCTO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'Tahoma'
        PrintFont.Style = []
        Width = 64
      end>
    DataSource = dsPagamentoPedido
    InvalidPicture.Data = {
      055449636F6E0000010001002020040000000000E80200001600000028000000
      2000000040000000010004000000000000020000000000000000000000000000
      0000000000000000000080000080000000808000800000008000800080800000
      80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
      FFFFFF0000000000000000000000000000000000000000000001111111100000
      0000000000000000011111111111100000000000000000011111111111111110
      0000000000000111111111111111111110000000000011111111111111111111
      1100000000011111111111111111111111100000001111117711111111117111
      1110000000111111FF7111111117FF111111000001111118FFF91111117FFFF1
      1111100001111178FFFF711117FFFFF711111000911111178FFFF9117FFFF871
      111110001111199178FFFF97FFFF87111111110011119999178FFFFFFFFF7191
      11111100111999999178FFFFFFF7199911111100119999999997FFFFFF899999
      91111100199999999997FFFFFF9999999911110099999999999FFFFFFFF99999
      999111009999999999FFFFFFFFFF999999911100999999999FFFFF778FFFF999
      99911100999999998FFF879978FFFF999999910099999978FFF87999978FFFF7
      9999910009999978FF8799999978FF8799999000099999978879999999978879
      9999100000999999779999999999779999990000009999977799999999999999
      9991000000099997888879999999999999100000000099978888888888779999
      9900000000000999788888888887999990000000000000999788888888799991
      0000000000000000999788888799991000000000000000000099999999999000
      00000000FF8000FFFF00007FFE00001FF800000FF0000007F0000007E0000003
      C0000001C0000001800000018000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000180000001
      80000003C0000003C0000007E000000FF000001FF800003FFC0000FFFF0001FF
      FFC007FF}
    ShowUnicode = False
    ColWidths = (
      20
      64
      64
      64
      64)
  end
  object zQryPagamentoPedido: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT'
      
        'pp.codigo AS codigoPagametoPedido,pp.data_cadastro,pp.valor_tota' +
        'l AS valorTotalPagametoPedido,pp.valor_parcela,pp.data_vcto,pp.d' +
        'ata_pgto,pp.descricao AS descricaoPagamentoPedido,'
      
        'ped.codigo AS codigoPedido,ped.descricao AS descricaoPedido,ped.' +
        'valor_total AS valorTotalPedido,ped.status,ped.condicao_pagament' +
        'o,'
      'c.codigo AS codigoCliente,c.nome AS nomeCliente'
      'FROM pagamento_pedido pp'
      'JOIN pedido ped ON pp.cod_pedido = ped.codigo'
      'JOIN cliente c ON ped.cod_cliente = c.codigo'
      'WHERE pp.data_pgto IS NULL'
      'AND 1=2')
    Params = <>
    Left = 16
    Top = 160
    object zQryPagamentoPedidoCODIGOPAGAMETOPEDIDO: TIntegerField
      FieldName = 'CODIGOPAGAMETOPEDIDO'
      Required = True
    end
    object zQryPagamentoPedidoDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryPagamentoPedidoVALORTOTALPAGAMETOPEDIDO: TFloatField
      FieldName = 'VALORTOTALPAGAMETOPEDIDO'
      Required = True
    end
    object zQryPagamentoPedidoVALOR_PARCELA: TFloatField
      FieldName = 'VALOR_PARCELA'
      Required = True
    end
    object zQryPagamentoPedidoDATA_VCTO: TDateField
      FieldName = 'DATA_VCTO'
    end
    object zQryPagamentoPedidoDATA_PGTO: TDateField
      FieldName = 'DATA_PGTO'
    end
    object zQryPagamentoPedidoDESCRICAOPAGAMENTOPEDIDO: TStringField
      FieldName = 'DESCRICAOPAGAMENTOPEDIDO'
      Size = 500
    end
    object zQryPagamentoPedidoCODIGOPEDIDO: TIntegerField
      FieldName = 'CODIGOPEDIDO'
      Required = True
    end
    object zQryPagamentoPedidoDESCRICAOPEDIDO: TStringField
      FieldName = 'DESCRICAOPEDIDO'
      Size = 1000
    end
    object zQryPagamentoPedidoVALORTOTALPEDIDO: TFloatField
      FieldName = 'VALORTOTALPEDIDO'
      Required = True
    end
    object zQryPagamentoPedidoSTATUS: TIntegerField
      FieldName = 'STATUS'
      Required = True
    end
    object zQryPagamentoPedidoCONDICAO_PAGAMENTO: TIntegerField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryPagamentoPedidoCODIGOCLIENTE: TIntegerField
      FieldName = 'CODIGOCLIENTE'
      Required = True
    end
    object zQryPagamentoPedidoNOMECLIENTE: TStringField
      FieldName = 'NOMECLIENTE'
      Required = True
      Size = 100
    end
  end
  object cdsPagamentoPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPagamentoPedido'
    Left = 16
    Top = 224
    object cdsPagamentoPedidoCODIGOPAGAMETOPEDIDO: TIntegerField
      FieldName = 'CODIGOPAGAMETOPEDIDO'
      Required = True
    end
    object cdsPagamentoPedidoDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsPagamentoPedidoVALORTOTALPAGAMETOPEDIDO: TFloatField
      FieldName = 'VALORTOTALPAGAMETOPEDIDO'
      Required = True
    end
    object cdsPagamentoPedidoVALOR_PARCELA: TFloatField
      FieldName = 'VALOR_PARCELA'
      Required = True
    end
    object cdsPagamentoPedidoDATA_VCTO: TDateField
      FieldName = 'DATA_VCTO'
    end
    object cdsPagamentoPedidoDATA_PGTO: TDateField
      FieldName = 'DATA_PGTO'
    end
    object cdsPagamentoPedidoDESCRICAOPAGAMENTOPEDIDO: TStringField
      FieldName = 'DESCRICAOPAGAMENTOPEDIDO'
      Size = 500
    end
    object cdsPagamentoPedidoCODIGOPEDIDO: TIntegerField
      FieldName = 'CODIGOPEDIDO'
      Required = True
    end
    object cdsPagamentoPedidoDESCRICAOPEDIDO: TStringField
      FieldName = 'DESCRICAOPEDIDO'
      Size = 1000
    end
    object cdsPagamentoPedidoVALORTOTALPEDIDO: TFloatField
      FieldName = 'VALORTOTALPEDIDO'
      Required = True
    end
    object cdsPagamentoPedidoSTATUS: TIntegerField
      FieldName = 'STATUS'
      Required = True
    end
    object cdsPagamentoPedidoCONDICAO_PAGAMENTO: TIntegerField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object cdsPagamentoPedidoCODIGOCLIENTE: TIntegerField
      FieldName = 'CODIGOCLIENTE'
      Required = True
    end
    object cdsPagamentoPedidoNOMECLIENTE: TStringField
      FieldName = 'NOMECLIENTE'
      Required = True
      Size = 100
    end
  end
  object dspPagamentoPedido: TDataSetProvider
    DataSet = zQryPagamentoPedido
    Left = 16
    Top = 192
  end
  object dsPagamentoPedido: TDataSource
    DataSet = cdsPagamentoPedido
    Left = 16
    Top = 256
  end
end
