object frmSelecionaRelatorioSaidasFinanceiras: TfrmSelecionaRelatorioSaidasFinanceiras
  Left = 417
  Top = 210
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'NOIVA LINDA --> Seleciona Relat'#243'rio - Sa'#237'das Financeiras'
  ClientHeight = 141
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblData: TLabel
    Left = 90
    Top = 41
    Width = 73
    Height = 13
    Caption = 'Data da Sa'#237'da:'
  end
  object Label5: TLabel
    Left = 310
    Top = 41
    Width = 6
    Height = 13
    Caption = 'e'
  end
  object Label6: TLabel
    Left = 186
    Top = 41
    Width = 24
    Height = 13
    Caption = 'entre'
  end
  object mEdDataSaida1: TMaskEdit
    Left = 220
    Top = 35
    Width = 75
    Height = 21
    Hint = 'Pesquisar por Data da Sa'#237'da Financeira'
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
  end
  object mEdDataSaida2: TMaskEdit
    Left = 328
    Top = 35
    Width = 73
    Height = 21
    Hint = 'Pesquisar por Data da Sa'#237'da Financeira'
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 122
    Width = 457
    Height = 19
    Panels = <
      item
        Width = 350
      end
      item
        Width = 50
      end>
  end
  object btBtnGerar: TBitBtn
    Left = 291
    Top = 71
    Width = 110
    Height = 40
    Hint = 'Gerar Relat'#243'rio'
    Caption = 'GERAR'
    Default = True
    TabOrder = 3
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
    Left = 170
    Top = 71
    Width = 110
    Height = 40
    Hint = 'Iniciar Nova Pesquisa'
    Caption = 'Nova'
    TabOrder = 4
  end
  object ckBxCompras: TCheckBox
    Left = 90
    Top = 11
    Width = 79
    Height = 17
    Hint = 'Pesquisar por Sa'#237'das Financeiras de Compras'
    Caption = 'Compras'
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 5
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 73
    Top = 49
  end
  object qryRelatorioSaidaFinanceira: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT s.*,f.razao_social'
      'FROM saida_financeira s, fornecedor f'
      'WHERE s.cod_fornecedor=f.codigo'
      'ORDER BY s.data,s.tipo')
    SQLConnection = DM.SQLConnection
    Left = 73
    Top = 82
    object qryRelatorioSaidaFinanceiraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryRelatorioSaidaFinanceiraCOD_COMPRA: TIntegerField
      FieldName = 'COD_COMPRA'
    end
    object qryRelatorioSaidaFinanceiraCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
    end
    object qryRelatorioSaidaFinanceiraTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
    object qryRelatorioSaidaFinanceiraVALOR: TFMTBCDField
      FieldName = 'VALOR'
      Precision = 15
      Size = 2
    end
    object qryRelatorioSaidaFinanceiraDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
    object qryRelatorioSaidaFinanceiraOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 300
    end
    object qryRelatorioSaidaFinanceiraRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 100
    end
  end
  object dspRelatorioSaidaFinanceira: TDataSetProvider
    DataSet = qryRelatorioSaidaFinanceira
    Left = 104
    Top = 82
  end
  object cdsRelatorioSaidaFinanceira: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspRelatorioSaidaFinanceira'
    Left = 135
    Top = 82
    object cdsRelatorioSaidaFinanceiraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsRelatorioSaidaFinanceiraCOD_COMPRA: TIntegerField
      FieldName = 'COD_COMPRA'
    end
    object cdsRelatorioSaidaFinanceiraCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
    end
    object cdsRelatorioSaidaFinanceiraTIPO: TStringField
      FieldName = 'TIPO'
      Size = 10
    end
    object cdsRelatorioSaidaFinanceiraVALOR: TFMTBCDField
      FieldName = 'VALOR'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsRelatorioSaidaFinanceiraDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
    object cdsRelatorioSaidaFinanceiraOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 300
    end
    object cdsRelatorioSaidaFinanceiraRAZAO_SOCIAL: TStringField
      FieldName = 'RAZAO_SOCIAL'
      Size = 100
    end
  end
end
