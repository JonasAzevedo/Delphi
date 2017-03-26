object frmContasPagar: TfrmContasPagar
  Left = 299
  Top = 74
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'EMP'#211'RIO --> Contas '#224' Pagar'
  ClientHeight = 536
  ClientWidth = 755
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 300
    Width = 57
    Height = 13
    Caption = 'Fornecedor:'
  end
  object Label2: TLabel
    Left = 10
    Top = 270
    Width = 40
    Height = 13
    Caption = 'Produto:'
  end
  object Label3: TLabel
    Left = 10
    Top = 420
    Width = 55
    Height = 13
    Caption = 'Valor Pago:'
  end
  object Label4: TLabel
    Left = 10
    Top = 330
    Width = 26
    Height = 13
    Caption = 'Data:'
  end
  object Label5: TLabel
    Left = 10
    Top = 390
    Width = 54
    Height = 13
    Caption = 'Valor Total:'
  end
  object Label6: TLabel
    Left = 10
    Top = 360
    Width = 58
    Height = 13
    Caption = 'Quantidade:'
  end
  object Label7: TLabel
    Left = 10
    Top = 240
    Width = 36
    Height = 13
    Caption = 'C'#243'digo:'
  end
  object lblCodigo: TLabel
    Left = 80
    Top = 240
    Width = 43
    Height = 13
    Caption = 'lblCodigo'
  end
  object lblProduto: TLabel
    Left = 80
    Top = 270
    Width = 47
    Height = 13
    Caption = 'lblProduto'
  end
  object lblFornecedor: TLabel
    Left = 80
    Top = 300
    Width = 64
    Height = 13
    Caption = 'lblFornecedor'
  end
  object lblData: TLabel
    Left = 80
    Top = 330
    Width = 33
    Height = 13
    Caption = 'lblData'
  end
  object lblQuantidade: TLabel
    Left = 80
    Top = 360
    Width = 65
    Height = 13
    Caption = 'lblQuantidade'
  end
  object lblValorTotal: TLabel
    Left = 80
    Top = 390
    Width = 58
    Height = 13
    Caption = 'lblValorTotal'
  end
  object lblValorPago: TLabel
    Left = 80
    Top = 420
    Width = 59
    Height = 13
    Caption = 'lblValorPago'
  end
  object Label8: TLabel
    Left = 10
    Top = 490
    Width = 85
    Height = 13
    Caption = 'Valor a Dar Baixa:'
  end
  object bvlDivisao: TBevel
    Left = 8
    Top = 450
    Width = 265
    Height = 4
    Shape = bsBottomLine
    Style = bsRaised
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 517
    Width = 755
    Height = 19
    Panels = <
      item
        Width = 550
      end
      item
        Width = 240
      end>
  end
  object grpBxContasPagar: TGroupBox
    Left = 0
    Top = 89
    Width = 755
    Height = 128
    Align = alTop
    Caption = 'Contas '#224' Pagar'
    TabOrder = 1
    object dbGrdContasPagar: TDBGrid
      Left = 2
      Top = 15
      Width = 751
      Height = 111
      Hint = 'Contas '#224' Pagar'
      Align = alClient
      DataSource = dsContasPagar
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = dbGrdContasPagarCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRODUTO'
          Title.Caption = 'Produto'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FORNECEDOR'
          Title.Caption = 'Fornecedor'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA'
          Title.Caption = 'Data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Caption = 'Quantidade'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Title.Caption = 'Valor Total'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_PAGO'
          Title.Caption = 'Valor Pago'
          Width = 60
          Visible = True
        end>
    end
  end
  object grpBxPesquisa: TGroupBox
    Left = 0
    Top = 0
    Width = 755
    Height = 73
    Align = alTop
    Caption = 'Pesquisar'
    TabOrder = 2
    object rdBtnCodigo: TRadioButton
      Left = 8
      Top = 20
      Width = 57
      Height = 17
      Hint = 'Pesquisar por C'#243'digo da Conta'
      Caption = 'C'#243'digo'
      TabOrder = 0
      OnClick = rdBtnCodigoClick
    end
    object rdBtnProduto: TRadioButton
      Left = 8
      Top = 35
      Width = 83
      Height = 17
      Hint = 'Pesquisar por Nome do Produto'
      Caption = 'Produto'
      TabOrder = 1
      OnClick = rdBtnProdutoClick
    end
    object edPesquisa: TEdit
      Left = 96
      Top = 24
      Width = 577
      Height = 21
      Hint = 'Valor a ser Pesquisado'
      CharCase = ecUpperCase
      TabOrder = 2
      OnChange = edPesquisaChange
      OnKeyPress = edPesquisaKeyPress
    end
    object btBtnPesquisar: TBitBtn
      Left = 680
      Top = 17
      Width = 57
      Height = 33
      Hint = 'Pesquisar por Conta'
      BiDiMode = bdLeftToRight
      Caption = 'OK'
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 3
      OnClick = btBtnPesquisarClick
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FF3F4E5A
        4D5C73FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF778A953184D51169CC556782FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0E90C90E90C90E90C90E90C90E90C90E90C90E90C90E90C9FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF3BABFF2B92FF0E67C9536681FF00FFFF00FFFF
        00FFFF00FF0E90C90E90C959C1E955C0E948BAE73CB5E531B0E22AACE128ABE0
        2AADE10E90C90E90C9FF00FFFF00FFFF00FFFF00FFFF00FF3DA9FF2A92FF0F67
        C75E687FFF00FFFF00FF0E90C958CEF26DD1F072CCEF63C6EB51BFE941B7E633
        B2E32AADE126AAE024A7DE24A7DE2CADE20E90C9FF00FFFF00FFFF00FFFF00FF
        FF00FF3DA9FF2991FF0F64C05B6B84FF00FF0E90C966D8F67BD7F486D4F278CF
        F066C7EE52C0EA3FBAE732B4E52DAFE228ABE125A7DE29ACE10E90C9FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF3DA9FF238EFF25629D5B6B84257EA5899AA1
        ADA19DBAA7A3AAABB286B8D063C9EE4AC1EB39BAE934B5E62EB1E329ACE12CAF
        E20E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF3DA9FFB7A8C080
        6465BDA389F6F0C6FFFFCFFFFFCFFAF4CAD7BBA48B9CA957C9EF41C1ED3BBCEA
        35B7E730B2E530B2E50E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF989EA3E2C29AFFF4B8FFFFCEFFFFCFFFFFD3FFFFDAFFFFFFE2D3D077
        9EAF4CC9F044C4EE3FBFEB38B8E936B8E70E90C9FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF698493D19494FCDC9DF6D79EFFFECBFFFFD0FFFFE0FFFF
        F3FFFFFFFFFFFAAA968A7F9EA74DCBF247C6EF41C1ED3EBDEA0E90C9FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFB8807EE7CA9FF4C586F2C78FFFFBC9
        FFFFD1FFFFE5FFFFFBFFFFF3FFFFE0D5CBABC5A79E56D1F650CEF349C9F045C4
        EE0E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB8807EF0D7A5F2
        BC7EEDB478FBEBB6FFFFD1FFFFD8FFFFE5FFFFE0FFFFD4E7E6C1B49E8E5ED8F8
        59D4F653CFF44DCBF20E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFB8807EEDD0A4F7CA8AEAA96AF3CB91FCF3C1FFFFD1FFFFD3FFFFD0FFFFD3DD
        D4B1C5A79E66DEFB60DAFA5BD7F855D0F40E90C9FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF698493D5A795FFF0B7F6DAAFF0C48AF2CA90F8E5AFFCF4
        C1FEF8C6FFFFCFE6C99F7F9EA76AE2FE68E0FC64DDFB5CD7F70E90C9FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF698493EBDCC2FFFFFFFAE3BF
        EDB475EBB075F3C98EFFEAADEAD8AA8F9FA76CE2FE6BE2FE6BE2FE6AE2FE63DC
        FA0E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB8
        807ED9CAC0FEF4C9FFE6A5FCDE9EFCE2A5E6C99FAB99998BE2F76CE2FE6BE2FE
        6BE2FE6CE3FF67DEFC0E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF3A738EA19088CAAD96D3B29CCAA99EB8B7BFAFEAFC8B
        E7FE6CE2FE6BE2FE6BE2FE6CE3FF68E0FC0E90C9FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C978E3FCA3EBFFC9F0FFCBF0
        FFC2EFFFAFEDFF8BE7FE6CE2FE6BE2FE6BE2FE6CE3FF68E0FC0E90C9FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C978E3FC
        A3EBFFC9F0FFCCF0FFC4EFFFB0EDFF8CE7FE6DE2FE6BE2FE6BE2FE6CE3FF68E0
        FC0E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF0E90C979E5FCAAEFFFD7F7FFD5F4FFC6F0FFB0EEFF8CE9FE6EE3FF70E6FF
        72E7FF70E6FF69E1FC0E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF0E90C974E1FB72D1F05EBFE34EB6DE43B1DC3CAFDC34
        ADDA2DADDC30B1DE38B8E351CEF066DDFB0E90C9FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C925A4D43FADDA5CBFE26DC9
        EA79D0EE7AD1F074D1EF66CCED4EC2E739B7E227AAD920A3D50E90C9FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C98CD8F2
        C7F6FFC2F7FFB1F3FFA0EFFF90EBFF82EAFF7AE9FF77EAFF78EDFF75EAFF4ECB
        EF0E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF0E90C90E90C960CEEF64D5F464DAF864DDFA62DDFB5ED9F857D3F4
        4BC9ED0E90C90E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C8FC90F92CA1193CB1295CB12
        95CB1193CB1092CA0D8FC7FF00FFFF00FFFF00FFFF00FFFF00FF}
    end
    object rdBtnFornecedor: TRadioButton
      Left = 8
      Top = 50
      Width = 83
      Height = 17
      Hint = 'Pesquisar por Raz'#227'o Social do Fornecedor'
      Caption = 'Fornecedor'
      TabOrder = 4
      OnClick = rdBtnFornecedorClick
    end
  end
  object pnlDivisao: TPanel
    Left = 0
    Top = 73
    Width = 755
    Height = 16
    Align = alTop
    BevelInner = bvLowered
    Color = clMoneyGreen
    TabOrder = 3
  end
  object edValorBaixa: TEdit
    Left = 104
    Top = 484
    Width = 89
    Height = 21
    Hint = 'Valor a ser Pago da Conta'
    TabOrder = 4
    Text = 'edValorBaixa'
    OnEnter = edValorBaixaEnter
    OnExit = edValorBaixaExit
    OnKeyPress = edValorBaixaKeyPress
  end
  object btBtnPagar: TBitBtn
    Left = 200
    Top = 472
    Width = 73
    Height = 33
    Hint = 'Pagar Conta'
    Caption = 'Pagar'
    TabOrder = 5
    OnClick = btBtnPagarClick
  end
  object qryContasPagar: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'SELECT c.codigo,p.nome AS Produto,f.razao_social AS Fornecedor,c' +
        '.data,c.quantidade,c.valor_total,c.valor_pago FROM Compra c, Pro' +
        'duto p, Fornecedor f'
      'WHERE c.pago = 2'
      'AND c.cod_produto = p.codigo'
      'AND c.cod_fornecedor = f.codigo')
    SQLConnection = DM.SQLConnection
    Left = 16
    Top = 152
    object qryContasPagarCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryContasPagarPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 80
    end
    object qryContasPagarFORNECEDOR: TStringField
      FieldName = 'FORNECEDOR'
      Size = 80
    end
    object qryContasPagarDATA: TDateField
      FieldName = 'DATA'
    end
    object qryContasPagarQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      Precision = 15
      Size = 3
    end
    object qryContasPagarVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object qryContasPagarVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
  end
  object dspContasPagar: TDataSetProvider
    DataSet = qryContasPagar
    Left = 46
    Top = 152
  end
  object cdsContasPagar: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspContasPagar'
    Left = 73
    Top = 152
    object cdsContasPagarCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsContasPagarPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 80
    end
    object cdsContasPagarFORNECEDOR: TStringField
      FieldName = 'FORNECEDOR'
      Size = 80
    end
    object cdsContasPagarDATA: TDateField
      FieldName = 'DATA'
    end
    object cdsContasPagarQUANTIDADE: TFMTBCDField
      FieldName = 'QUANTIDADE'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 3
    end
    object cdsContasPagarVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsContasPagarVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
  end
  object dsContasPagar: TDataSource
    DataSet = cdsContasPagar
    Left = 103
    Top = 152
  end
  object PopupMenu: TPopupMenu
    Left = 551
    Top = 45
    object ppMnMostrarTodasContasPagar: TMenuItem
      Caption = 'Mostrar Todas Contas '#224' Pagar'
      Hint = 'Mostrar Todas as Contas '#224' Pagar'
      OnClick = ppMnMostrarTodasContasPagarClick
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 584
    Top = 44
  end
end
