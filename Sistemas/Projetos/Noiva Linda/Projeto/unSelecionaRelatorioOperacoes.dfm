object frmSelecionaRelatorioOperacoes: TfrmSelecionaRelatorioOperacoes
  Left = 354
  Top = 115
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'NOIVA LINDA --> Seleciona Relat'#243'rio'
  ClientHeight = 616
  ClientWidth = 823
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 597
    Width = 823
    Height = 19
    Panels = <
      item
        Width = 350
      end
      item
        Width = 50
      end>
  end
  object pnlReservaLocacao: TPanel
    Left = 168
    Top = 360
    Width = 423
    Height = 279
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 10
      Top = 22
      Width = 35
      Height = 13
      Caption = 'Cliente:'
    end
    object lblDataInicio: TLabel
      Left = 10
      Top = 52
      Width = 71
      Height = 13
      Caption = 'Data de In'#237'cio:'
    end
    object lblDataFinal: TLabel
      Left = 10
      Top = 82
      Width = 51
      Height = 13
      Caption = 'Data Final:'
    end
    object Label2: TLabel
      Left = 10
      Top = 112
      Width = 54
      Height = 13
      Caption = 'Valor Total:'
    end
    object Label4: TLabel
      Left = 270
      Top = 112
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object Label5: TLabel
      Left = 270
      Top = 52
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object Label6: TLabel
      Left = 90
      Top = 52
      Width = 24
      Height = 13
      Caption = 'entre'
    end
    object Label7: TLabel
      Left = 90
      Top = 82
      Width = 24
      Height = 13
      Caption = 'entre'
    end
    object Label8: TLabel
      Left = 270
      Top = 82
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object Label9: TLabel
      Left = 90
      Top = 112
      Width = 24
      Height = 13
      Caption = 'entre'
    end
    object edCliente: TEdit
      Left = 90
      Top = 16
      Width = 268
      Height = 21
      Hint = 'Nome do Cliente'
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 80
      TabOrder = 0
      Text = 'EDCLIENTE'
      OnEnter = edClienteEnter
      OnExit = edClienteExit
    end
    object btBtnAbreCliente: TBitBtn
      Left = 365
      Top = 14
      Width = 39
      Height = 25
      Hint = 'Abre Cliente para Sele'#231#227'o de Relat'#243'rio'
      Caption = '...'
      TabOrder = 1
      OnClick = btBtnAbreClienteClick
    end
    object mEdDataInicio1: TMaskEdit
      Left = 140
      Top = 46
      Width = 111
      Height = 21
      Hint = 'Data de In'#237'cio'
      EditMask = '99/99/9999 00:00;1;_'
      MaxLength = 16
      TabOrder = 2
      Text = '  /  /       :  '
      OnEnter = mEdDataInicio1Enter
      OnExit = mEdDataInicio1Exit
    end
    object mEdDataFinal1: TMaskEdit
      Left = 140
      Top = 78
      Width = 113
      Height = 21
      Hint = 'Data Final'
      EditMask = '99/99/9999 00:00;1;_'
      MaxLength = 16
      TabOrder = 3
      Text = '  /  /       :  '
      OnEnter = mEdDataFinal1Enter
      OnExit = mEdDataFinal1Exit
    end
    object edValorTotal1: TEdit
      Left = 140
      Top = 108
      Width = 112
      Height = 21
      Hint = 'Valor Total'
      TabOrder = 4
      Text = 'edValorTotal1'
      OnEnter = edValorTotal1Enter
      OnExit = edValorTotal1Exit
      OnKeyPress = edValorTotal1KeyPress
    end
    object mEdDataInicio2: TMaskEdit
      Left = 294
      Top = 46
      Width = 113
      Height = 21
      Hint = 'Data de In'#237'cio'
      EditMask = '99/99/9999 00:00;1;_'
      MaxLength = 16
      TabOrder = 5
      Text = '  /  /       :  '
      OnEnter = mEdDataInicio2Enter
      OnExit = mEdDataInicio2Exit
    end
    object mEdDataFinal2: TMaskEdit
      Left = 294
      Top = 78
      Width = 115
      Height = 21
      Hint = 'Data Final'
      EditMask = '99/99/9999 00:00;1;_'
      MaxLength = 16
      TabOrder = 6
      Text = '  /  /       :  '
      OnEnter = mEdDataFinal2Enter
      OnExit = mEdDataFinal2Exit
    end
    object edValorTotal2: TEdit
      Left = 294
      Top = 108
      Width = 114
      Height = 21
      Hint = 'Valor Total'
      TabOrder = 7
      Text = 'edValorTotal'
      OnEnter = edValorTotal2Enter
      OnExit = edValorTotal2Exit
      OnKeyPress = edValorTotal2KeyPress
    end
    object btBtnGerar: TBitBtn
      Left = 298
      Top = 135
      Width = 110
      Height = 40
      Hint = 'Gerar Relat'#243'rio'
      Caption = 'GERAR'
      Default = True
      TabOrder = 8
      OnClick = btBtnGerarClick
      Glyph.Data = {
        2E060000424D2E06000000000000360400002800000015000000150000000100
        080000000000F801000000000000000000000001000000000000FFFFFA009997
        9400E9E6B600FFFFFC00ECECEC00B2BAA100F9FAFF00D6DBCA00F8FCEC00F7F9
        F100FFFCFF00FFFEEC00E5E5E500C8C98900FBF7F200FFFEE900F7F7F700FEF6
        FF00C9C9C900F4F4EE00FBF9F500C6D1B100FCFFDD00ABA77F00BCC34F00DED9
        EE00B1B1B100D6D6D600E2E3DC00FAFEF900FCF8F300F9F6FE00F4F4F400FAFF
        ED00F2ECC700FFEBFF00A2A06700C6C6C600EAEAEA00FFFFF800F6F2EE00FEFF
        E200ADADAD00DCE6BA00DEDDDD00A9A9A900FCFDD400DBEDA500BBBC5800F2F2
        F200837C9C00FAFAC500E4DFEA00FDF7EA00B6D31E00FCFEFF00FEFAFA00FFF3
        FF00DADADA00F6F4FE00DFD5D200A1A0A000C3C85B00FEFFE400AAA4C100FFFC
        F70086985600B9B8B800A4A4A400FFFAFF00AFAEA900D9CC9800F5F5F500F4F3
        E500F9F9F200FAF1FE00B1B56B00F1FCFD00ADC9320067617900EFEEEE00BFBA
        B500F0F2EE00F9FFEA00B0AFAE00FAFFFE00F4F2F900BDBDBD00FFFFF600ACAB
        A500F9F8EE00F1F4FA00B5B4B200ECEAE9009D9D9C00FFFFEF00C1BEBC00FEFD
        F900FDFCF800E1DDDA00FDFFFA00FCFEF700FFFFF500C3C2C200C2CAAB00FAFE
        F000FFF2FA00B3BA4400E0E0E000A8A6A600D1D1D100E7E7E000ABAD6E00FFF7
        FF00FAFCF500FCFAF700A9B87D00F3F0F900FDFFF800F6FEFB00F9FBF900AFAB
        B200FAFFFC00FAFCFF00FBFDFD00FDFDFB00FFFFF200FEFDF600FEFBF600F5F8
        FE00F9F7FB00F4FEFE00FEFBFF00FCFBFD00FDFDF300F5F8F800FBF8F400FFFF
        FE00FCFCFC00FBFBFB00FAFAFA00F9F9F900F8F8F800FDFAF400FDFFFF00FFFC
        FC00FEFAF500FFFDFF00F0EAFF007A767100F5F7EB00BECD4300EFEAF300FCE6
        FB00B6BB7A00F8FFE600F7F9F700C4C4C400C3C3AA00FEFFFE00E6DAA000A9B1
        6100FEFEFD00413D38003F414F00DDE0C700C8C5C000C7C9C300C1C4C800BEE1
        4A0042434E004C496200EDF4E000949D800084849300CEDE7400DAF18700E9EC
        E900B2B93E00A9A94500B2AD5F00D7CABD00C6DB8B00A2C02900B3CB2400C5BC
        D500BEDE2900B9CA3500B9B6CB00BFB6D600F4F0EC00EFF2FF00786F8B00E6E3
        E900FCEBD700F7F4EF00F3F0FF00F4F6FE00ABAAAB009593A8009AA97200E8E8
        E700C7D84B00BEC07700D3DF5A00DDD9BE00FEEEF800FEFDF400F8F9FA00FEFF
        F500CFCDCB00F9FAFC00FBF9FA00F0FAFA00F4F7EE00B1BF8000FBFDE300EFFD
        CD00F8FBE500AEB1AB00FFFBE600F0F5F400C2D06500CEC97C00D1CA7500D6D3
        CE00E3E2E200FCF9FD00FFF9FD00B9B7B600FFFBFD00E0DA9F00FCF9FF00B7B6
        B70060646600F7FFDA00736E7500B9C3A400F2E2E000F1E2EC00BCBBBB00FFF8
        F400ECEBEB00F8FCFE00FEFEFB00C4C3C200A4A2A200E8E6EA00E6D8BB00C7C1
        BC00C8C0AF00C8C9AF00FFFEFF00FDFDFD00FEFEFE00FFFFFF00FFFFFF2E99FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFD247D2
        FFFFFFFFFFFFFF000000FFFFFFFFFFFF99D240014047190199FFFFFFFFFFFF00
        0000FFFFFF19470147BC2ED5FFFFFF402EFFFFFFFFFFFF00000099FFFFD219FF
        FF2E992EFF2EFFD2D2FF99FFFFFFFF000000FFFFFFD5FFD5FFFFFFFFFF01FFD2
        47FFFFFFFFFFFF000000FF2EFF2EFFFFFF2EFFFF19EAFF2E01FFFFFFFFFFFF00
        0000FFFFFFFFFFD5FF2EFFFFEAD5FFFF0519FFFFFFFFFF000000FFFFFF2E99FF
        FF2E99D232FF99FF40D2FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFC0FFD5FFFF
        2E40FFFFFFFFFF000000FFFFFFFFFFFFFFFF1901FFFFFFFF9901FFFFFFFFFF00
        0000FFFFFFFFFFFFFFFF95D5FFFFFFFFFF01FFFFFFFFFF000000FFFFFFFF99FF
        FF2EBDFFFF2EFFFFFF4719FFFFFFFF000000FFFFFFFFFFD5FFD5FFD5FFFFFFFF
        FF1947FFFFFFFF000000FFFFFFFFFFFFFFFFFF2EFFFFFF2EFF2E01FFFFFFFF00
        0000FFFFFFFFFFD5FFFFFFFF2ED2A001A1FF47D5FFFFFF000000FFFFFFFFFFFF
        FF2F47BBB3BBDECC192E99FFFFFFFF000000FFFFFFFFFFFFFFA1DE2FDE24A0FF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFEEB301FFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFF2EA12FFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FF2E99FFFF2EFFFFFFFFFFFFFFFF99000000}
    end
    object btBtnNova: TBitBtn
      Left = 178
      Top = 135
      Width = 110
      Height = 40
      Hint = 'Iniciar Nova Pesquisa'
      Caption = 'Nova'
      TabOrder = 9
      OnClick = btBtnNovaClick
    end
    object BitBtn1: TBitBtn
      Left = 48
      Top = 224
      Width = 75
      Height = 25
      Caption = 'BitBtn1'
      TabOrder = 10
      OnClick = BitBtn1Click
    end
  end
  object pnlVenda: TPanel
    Left = 168
    Top = 16
    Width = 385
    Height = 225
    BevelOuter = bvNone
    TabOrder = 2
    object Label3: TLabel
      Left = 10
      Top = 50
      Width = 57
      Height = 13
      Caption = 'Fornecedor:'
    end
    object Label10: TLabel
      Left = 10
      Top = 80
      Width = 65
      Height = 13
      Caption = 'Data Compra:'
    end
    object Label15: TLabel
      Left = 114
      Top = 80
      Width = 24
      Height = 13
      Caption = 'entre'
    end
    object Label18: TLabel
      Left = 114
      Top = 140
      Width = 24
      Height = 13
      Caption = 'entre'
    end
    object Label12: TLabel
      Left = 10
      Top = 140
      Width = 54
      Height = 13
      Caption = 'Valor Total:'
    end
    object Label14: TLabel
      Left = 261
      Top = 80
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object Label13: TLabel
      Left = 261
      Top = 140
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object Label11: TLabel
      Left = 10
      Top = 2
      Width = 70
      Height = 16
      Caption = 'Compras'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 10
      Top = 18
      Width = 73
      Height = 9
      Shape = bsBottomLine
    end
    object Label16: TLabel
      Left = 10
      Top = 110
      Width = 85
      Height = 13
      Caption = 'Data Vencimento:'
    end
    object Label17: TLabel
      Left = 114
      Top = 110
      Width = 24
      Height = 13
      Caption = 'entre'
    end
    object Label19: TLabel
      Left = 261
      Top = 110
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object BitBtn5: TBitBtn
      Left = 8
      Top = 168
      Width = 75
      Height = 25
      Caption = 'BitBtn1'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object edFornecedor: TEdit
      Left = 114
      Top = 44
      Width = 217
      Height = 21
      Hint = 'Fornecedor da Compra'
      CharCase = ecUpperCase
      Enabled = False
      MaxLength = 80
      TabOrder = 1
      OnEnter = edFornecedorEnter
      OnExit = edFornecedorExit
    end
    object BitBtn4: TBitBtn
      Left = 146
      Top = 169
      Width = 108
      Height = 40
      Hint = 'Iniciar Nova Pesquisa'
      Caption = 'Nova'
      TabOrder = 2
      OnClick = btBtnNovaClick
    end
    object edValorTotalCompra1: TEdit
      Left = 158
      Top = 134
      Width = 76
      Height = 21
      Hint = 'Valor Total da Compra'
      TabOrder = 3
      OnEnter = edValorTotalCompra1Enter
      OnExit = edValorTotalCompra1Exit
      OnKeyPress = edValorTotalCompra1KeyPress
    end
    object mEdDataCompra1: TMaskEdit
      Left = 158
      Top = 74
      Width = 76
      Height = 21
      Hint = 'Data da Compra'
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      OnEnter = mEdDataCompra1Enter
      OnExit = mEdDataCompra1Exit
    end
    object BitBtn3: TBitBtn
      Left = 266
      Top = 169
      Width = 109
      Height = 40
      Hint = 'Gerar Relat'#243'rio'
      Caption = 'GERAR'
      Default = True
      TabOrder = 5
      OnClick = BitBtn3Click
      Glyph.Data = {
        2E060000424D2E06000000000000360400002800000015000000150000000100
        080000000000F801000000000000000000000001000000000000FFFFFA009997
        9400E9E6B600FFFFFC00ECECEC00B2BAA100F9FAFF00D6DBCA00F8FCEC00F7F9
        F100FFFCFF00FFFEEC00E5E5E500C8C98900FBF7F200FFFEE900F7F7F700FEF6
        FF00C9C9C900F4F4EE00FBF9F500C6D1B100FCFFDD00ABA77F00BCC34F00DED9
        EE00B1B1B100D6D6D600E2E3DC00FAFEF900FCF8F300F9F6FE00F4F4F400FAFF
        ED00F2ECC700FFEBFF00A2A06700C6C6C600EAEAEA00FFFFF800F6F2EE00FEFF
        E200ADADAD00DCE6BA00DEDDDD00A9A9A900FCFDD400DBEDA500BBBC5800F2F2
        F200837C9C00FAFAC500E4DFEA00FDF7EA00B6D31E00FCFEFF00FEFAFA00FFF3
        FF00DADADA00F6F4FE00DFD5D200A1A0A000C3C85B00FEFFE400AAA4C100FFFC
        F70086985600B9B8B800A4A4A400FFFAFF00AFAEA900D9CC9800F5F5F500F4F3
        E500F9F9F200FAF1FE00B1B56B00F1FCFD00ADC9320067617900EFEEEE00BFBA
        B500F0F2EE00F9FFEA00B0AFAE00FAFFFE00F4F2F900BDBDBD00FFFFF600ACAB
        A500F9F8EE00F1F4FA00B5B4B200ECEAE9009D9D9C00FFFFEF00C1BEBC00FEFD
        F900FDFCF800E1DDDA00FDFFFA00FCFEF700FFFFF500C3C2C200C2CAAB00FAFE
        F000FFF2FA00B3BA4400E0E0E000A8A6A600D1D1D100E7E7E000ABAD6E00FFF7
        FF00FAFCF500FCFAF700A9B87D00F3F0F900FDFFF800F6FEFB00F9FBF900AFAB
        B200FAFFFC00FAFCFF00FBFDFD00FDFDFB00FFFFF200FEFDF600FEFBF600F5F8
        FE00F9F7FB00F4FEFE00FEFBFF00FCFBFD00FDFDF300F5F8F800FBF8F400FFFF
        FE00FCFCFC00FBFBFB00FAFAFA00F9F9F900F8F8F800FDFAF400FDFFFF00FFFC
        FC00FEFAF500FFFDFF00F0EAFF007A767100F5F7EB00BECD4300EFEAF300FCE6
        FB00B6BB7A00F8FFE600F7F9F700C4C4C400C3C3AA00FEFFFE00E6DAA000A9B1
        6100FEFEFD00413D38003F414F00DDE0C700C8C5C000C7C9C300C1C4C800BEE1
        4A0042434E004C496200EDF4E000949D800084849300CEDE7400DAF18700E9EC
        E900B2B93E00A9A94500B2AD5F00D7CABD00C6DB8B00A2C02900B3CB2400C5BC
        D500BEDE2900B9CA3500B9B6CB00BFB6D600F4F0EC00EFF2FF00786F8B00E6E3
        E900FCEBD700F7F4EF00F3F0FF00F4F6FE00ABAAAB009593A8009AA97200E8E8
        E700C7D84B00BEC07700D3DF5A00DDD9BE00FEEEF800FEFDF400F8F9FA00FEFF
        F500CFCDCB00F9FAFC00FBF9FA00F0FAFA00F4F7EE00B1BF8000FBFDE300EFFD
        CD00F8FBE500AEB1AB00FFFBE600F0F5F400C2D06500CEC97C00D1CA7500D6D3
        CE00E3E2E200FCF9FD00FFF9FD00B9B7B600FFFBFD00E0DA9F00FCF9FF00B7B6
        B70060646600F7FFDA00736E7500B9C3A400F2E2E000F1E2EC00BCBBBB00FFF8
        F400ECEBEB00F8FCFE00FEFEFB00C4C3C200A4A2A200E8E6EA00E6D8BB00C7C1
        BC00C8C0AF00C8C9AF00FFFEFF00FDFDFD00FEFEFE00FFFFFF00FFFFFF2E99FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFD247D2
        FFFFFFFFFFFFFF000000FFFFFFFFFFFF99D240014047190199FFFFFFFFFFFF00
        0000FFFFFF19470147BC2ED5FFFFFF402EFFFFFFFFFFFF00000099FFFFD219FF
        FF2E992EFF2EFFD2D2FF99FFFFFFFF000000FFFFFFD5FFD5FFFFFFFFFF01FFD2
        47FFFFFFFFFFFF000000FF2EFF2EFFFFFF2EFFFF19EAFF2E01FFFFFFFFFFFF00
        0000FFFFFFFFFFD5FF2EFFFFEAD5FFFF0519FFFFFFFFFF000000FFFFFF2E99FF
        FF2E99D232FF99FF40D2FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFC0FFD5FFFF
        2E40FFFFFFFFFF000000FFFFFFFFFFFFFFFF1901FFFFFFFF9901FFFFFFFFFF00
        0000FFFFFFFFFFFFFFFF95D5FFFFFFFFFF01FFFFFFFFFF000000FFFFFFFF99FF
        FF2EBDFFFF2EFFFFFF4719FFFFFFFF000000FFFFFFFFFFD5FFD5FFD5FFFFFFFF
        FF1947FFFFFFFF000000FFFFFFFFFFFFFFFFFF2EFFFFFF2EFF2E01FFFFFFFF00
        0000FFFFFFFFFFD5FFFFFFFF2ED2A001A1FF47D5FFFFFF000000FFFFFFFFFFFF
        FF2F47BBB3BBDECC192E99FFFFFFFF000000FFFFFFFFFFFFFFA1DE2FDE24A0FF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFEEB301FFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFF2EA12FFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FF2E99FFFF2EFFFFFFFFFFFFFFFF99000000}
    end
    object edValorTotalCompra2: TEdit
      Left = 294
      Top = 134
      Width = 76
      Height = 21
      Hint = 'Valor Total da Compra'
      TabOrder = 6
      OnEnter = edValorTotalCompra2Enter
      OnExit = edValorTotalCompra2Exit
      OnKeyPress = edValorTotalCompra2KeyPress
    end
    object mEdDataCompra2: TMaskEdit
      Left = 294
      Top = 74
      Width = 76
      Height = 21
      Hint = 'Data da Compra'
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 7
      Text = '  /  /    '
      OnEnter = mEdDataCompra2Enter
      OnExit = mEdDataCompra2Exit
    end
    object btBtnAbreFornecedor: TBitBtn
      Left = 331
      Top = 42
      Width = 39
      Height = 25
      Hint = 'Abre Fornecedor Para Sele'#231#227'o de Relat'#243'rio de Compra'
      Caption = '...'
      TabOrder = 8
      OnClick = btBtnAbreClienteClick
    end
    object rdBtnComprasResumo: TRadioButton
      Left = 120
      Top = 2
      Width = 65
      Height = 17
      Hint = 'Exibe Relat'#243'rio de Compras de Forma Resumida'
      Caption = 'Resumo'
      Checked = True
      TabOrder = 9
      TabStop = True
    end
    object rdBtnComprasDetalhado: TRadioButton
      Left = 192
      Top = 2
      Width = 81
      Height = 17
      Hint = 'Exibe Relat'#243'rio de Compras de Forma Detalhado'
      Caption = 'Detalhado'
      TabOrder = 10
    end
    object mEdDataVencimento1: TMaskEdit
      Left = 158
      Top = 104
      Width = 76
      Height = 21
      Hint = 'Data de Vencimento'
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 11
      Text = '  /  /    '
      OnEnter = mEdDataVencimento1Enter
      OnExit = mEdDataVencimento1Exit
    end
    object mEdDataVencimento2: TMaskEdit
      Left = 294
      Top = 104
      Width = 76
      Height = 21
      Hint = 'Data de Vencimento'
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 12
      Text = '  /  /    '
      OnEnter = mEdDataVencimento2Enter
      OnExit = mEdDataVencimento2Exit
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 8
    Top = 100
  end
  object RvProject: TRvProject
    Engine = RvSystem
    Left = 8
    Top = 352
  end
  object RvSystem: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 40
    Top = 352
  end
  object RvDtStConProdutos: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    Left = 8
    Top = 384
  end
  object RvDtStConCompras: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    Left = 8
    Top = 416
  end
  object qryCompraResumo: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'SELECT c.codigo,c.data_compra,c.vencimento,c.observacoes,c.valor' +
        '_total,c.valor_pago,'
      
        '       (c.valor_total-c.valor_pago) AS "Valor_Resta", f.razao_so' +
        'cial'
      'FROM compra c,fornecedor f'
      'WHERE c.cod_fornecedor=f.codigo')
    SQLConnection = DM.SQLConnection
    Left = 456
    Top = 16
    object qryCompraResumoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryCompraResumoDATA_COMPRA: TDateField
      FieldName = 'DATA_COMPRA'
    end
    object qryCompraResumoVENCIMENTO: TDateField
      FieldName = 'VENCIMENTO'
    end
    object qryCompraResumoOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object qryCompraResumoVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 9
      Size = 2
    end
    object qryCompraResumoVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object qryCompraResumoValor_Resta: TFMTBCDField
      FieldName = 'Valor_Resta'
      Precision = 15
      Size = 2
    end
    object qryCompraResumoRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 100
    end
  end
  object dspCompraResumo: TDataSetProvider
    DataSet = qryCompraResumo
    Left = 484
    Top = 16
  end
  object cdsCompraResumo: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCompraResumo'
    Left = 513
    Top = 16
    object cdsCompraResumoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsCompraResumoDATA_COMPRA: TDateField
      FieldName = 'DATA_COMPRA'
    end
    object cdsCompraResumoVENCIMENTO: TDateField
      FieldName = 'VENCIMENTO'
    end
    object cdsCompraResumoOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object cdsCompraResumoVALOR_TOTAL: TBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 9
      Size = 2
    end
    object cdsCompraResumoVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object cdsCompraResumoValor_Resta: TFMTBCDField
      FieldName = 'Valor_Resta'
      Precision = 15
      Size = 2
    end
    object cdsCompraResumoRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 100
    end
  end
end
