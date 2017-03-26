object frmRelRecibo: TfrmRelRecibo
  Left = 182
  Top = 124
  Width = 1245
  Height = 675
  Caption = 'frmRelRecibo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object relRecibo: TRLReport
    Left = 8
    Top = 8
    Width = 1123
    Height = 794
    DataSource = dsCliente
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    PageSetup.Orientation = poLandscape
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 1047
      Height = 715
      object RLLabel1: TRLLabel
        Left = 872
        Top = 24
        Width = 86
        Height = 24
        Caption = 'RECIBO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlMmTexto: TRLMemo
        Left = 12
        Top = 194
        Width = 1009
        Height = 117
        Behavior = [beSiteExpander]
      end
      object rlCidade: TRLLabel
        Left = 8
        Top = 373
        Width = 118
        Height = 18
        Caption = 'S'#227'o Jos'#233' / SC, '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object rlData: TRLLabel
        Left = 133
        Top = 373
        Width = 49
        Height = 18
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object rlAssinatura: TRLLabel
        Left = 192
        Top = 416
        Width = 550
        Height = 16
        Caption = 
          '________________________________________________________________' +
          '______________'
      end
      object rlValor: TRLLabel
        Left = 965
        Top = 24
        Width = 70
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw3: TRLDraw
        Left = 12
        Top = 98
        Width = 1004
        Height = 6
        DrawKind = dkLine
      end
      object RLLabel11: TRLLabel
        Left = 12
        Top = 72
        Width = 441
        Height = 19
        Caption = '(48) 3343-2123    Cel.: (48) 9136-6863    Cel.: (48) 8436-2123'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel8: TRLLabel
        Left = 12
        Top = 44
        Width = 347
        Height = 18
        Caption = 'Esquadrias de Alum'#237'nio e Vidros Temperados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object RLLabel10: TRLLabel
        Left = 122
        Top = 9
        Width = 23
        Height = 32
        Caption = 'L'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 35
        Top = 36
        Width = 94
        Height = 6
        DrawKind = dkLine
      end
      object RLLabel9: TRLLabel
        Left = 11
        Top = 9
        Width = 26
        Height = 32
        Caption = 'A'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel3: TRLLabel
        Left = 32
        Top = 12
        Width = 94
        Height = 27
        Caption = 'LUMINA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLDraw2: TRLDraw
        Left = 35
        Top = 10
        Width = 94
        Height = 4
        DrawKind = dkLine
      end
      object RLLabel2: TRLLabel
        Left = 576
        Top = 630
        Width = 470
        Height = 16
        Caption = 
          'Empresa inscrita sob CNPJ: 04.980.898/0001-62 e Inscr. Estadual:' +
          ' 254.456.901'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
      end
    end
  end
  object zQryCliente: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT *'
      'FROM cliente'
      'WHERE 1=2')
    Params = <>
    Left = 200
    Top = 56
    object zQryClienteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryClienteDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryClienteNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
    object zQryClienteCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object zQryClienteIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object zQryClienteCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 18
    end
    object zQryClienteDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object zQryClientePROFISSAO: TStringField
      FieldName = 'PROFISSAO'
      Size = 100
    end
    object zQryClienteEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object zQryClienteTELEFONE_1: TStringField
      FieldName = 'TELEFONE_1'
      Size = 13
    end
    object zQryClienteTELEFONE_2: TStringField
      FieldName = 'TELEFONE_2'
      Size = 13
    end
    object zQryClienteESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object zQryClienteCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object zQryClienteBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object zQryClienteRUA: TStringField
      FieldName = 'RUA'
      Size = 100
    end
    object zQryClienteNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
    object zQryClienteCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object zQryClienteCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 200
    end
    object zQryClienteSEXO: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
  end
  object dspCliente: TDataSetProvider
    DataSet = zQryCliente
    Left = 228
    Top = 56
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCliente'
    Left = 257
    Top = 56
    object cdsClienteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsClienteDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsClienteNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
    object cdsClienteCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object cdsClienteIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object cdsClienteCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 18
    end
    object cdsClienteDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object cdsClientePROFISSAO: TStringField
      FieldName = 'PROFISSAO'
      Size = 100
    end
    object cdsClienteEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object cdsClienteTELEFONE_1: TStringField
      FieldName = 'TELEFONE_1'
      Size = 13
    end
    object cdsClienteTELEFONE_2: TStringField
      FieldName = 'TELEFONE_2'
      Size = 13
    end
    object cdsClienteESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object cdsClienteCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object cdsClienteBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object cdsClienteRUA: TStringField
      FieldName = 'RUA'
      Size = 100
    end
    object cdsClienteNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
    object cdsClienteCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsClienteCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 200
    end
    object cdsClienteSEXO: TStringField
      FieldName = 'SEXO'
      Size = 9
    end
  end
  object dsCliente: TDataSource
    DataSet = cdsCliente
    Left = 286
    Top = 56
  end
  object RLPDFFilter: TRLPDFFilter
    DisplayName = 'Documento PDF'
    Left = 16
    Top = 24
  end
end
