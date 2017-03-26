object frmResumoServidorDominiosNaoCadastrados: TfrmResumoServidorDominiosNaoCadastrados
  Left = 323
  Top = 45
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'SERVIDOR / DOM'#205'NIOS DESCONHECIDOS'
  ClientHeight = 651
  ClientWidth = 786
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lblAuxEmailsServidorDesconhecido: TLabel
    Left = 10
    Top = 20
    Width = 50
    Height = 14
    Caption = 'Servidor:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAuxEmailsDominio2Desconhecido: TLabel
    Left = 470
    Top = 20
    Width = 57
    Height = 14
    Caption = 'Dom'#237'nio 2:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalEmailsDominio2Desconhecido: TLabel
    Left = 533
    Top = 20
    Width = 205
    Height = 14
    Caption = 'lblTotalEmailsDominio2Desconhecido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAuxTotal: TLabel
    Left = 16
    Top = 465
    Width = 36
    Height = 16
    Caption = 'Total:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalEmailsServidorDesconhecido: TLabel
    Left = 66
    Top = 20
    Width = 201
    Height = 14
    Caption = 'lblTotalEmailsServidorDesconhecido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalEmailsDominio1Desconhecido: TLabel
    Left = 303
    Top = 20
    Width = 205
    Height = 14
    Caption = 'lblTotalEmailsDominio1Desconhecido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAuxEmailsDominio1Desconhecido: TLabel
    Left = 240
    Top = 20
    Width = 57
    Height = 14
    Caption = 'Dom'#237'nio 1:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalEmails: TLabel
    Left = 57
    Top = 465
    Width = 90
    Height = 16
    Caption = 'lblTotalEmails'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lstBxEmailsServidorDesconhecido: TListBox
    Left = 10
    Top = 48
    Width = 151
    Height = 150
    ItemHeight = 14
    MultiSelect = True
    TabOrder = 0
  end
  object lstBxEmailsDominio1Desconhecido: TListBox
    Left = 240
    Top = 48
    Width = 200
    Height = 150
    ItemHeight = 14
    MultiSelect = True
    TabOrder = 1
  end
  object lstBxEmailsDominio2Desconhecido: TListBox
    Left = 494
    Top = 48
    Width = 200
    Height = 150
    ItemHeight = 14
    MultiSelect = True
    TabOrder = 2
  end
  object btBtnVerificar: TBitBtn
    Left = 392
    Top = 455
    Width = 120
    Height = 30
    Caption = 'Verificar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btBtnVerificarClick
    Glyph.Data = {
      AA030000424DAA03000000000000360000002800000011000000110000000100
      18000000000074030000C40E0000C40E00000000000000000000FCFDFFF9FEFE
      FBFFFBFFFDFEFFFCFFEFF1FAD2E1EDF5FCFDFFFEFCFBFEFDF9FFFFFBFFFFFEFF
      FFFFFFFFFFFFFFFFFEFFFFFDFF00FFFBFEF6FEFCF1FFFBFEFDFEFFFFFFA5AFC9
      6E97AD9CBBC9FFFFFFFBFEFEFBFFFFFBFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFE
      FF00FFFAFEF2FFFAE7FFFAFBFFFEFFF8FF90A3C279BEDA5188A5EBF5FFFEFFFF
      FDFFFFFEFFFFFDFEFEFFFFFFFFFFFFFFFFFFFFFFFF00FFFAFDF2FFF9E2FFF8FA
      FDFDFFFEFFADC5DF73C3E34383A8C5D0E3FFFFFFFFFEFEFDFDFDFDFDFDFFFFFF
      FFFFFFFFFFFFFFFFFF00FFFAFEF5FFFAE9FFF8FAFEFDFFFCFFC4DAE980C8E463
      9EBE99A5C0FFFFFFFEFEFEFBFBFBFDFEFEFEFEFEFFFFFFFDFFFFFDFFFF00FFFB
      FFF8FFFAF4FFF6FDFEF9FFFDFFE5F8FE8DBBD0ACD0E8777E96F5F5F6FFFFFFFD
      FCFCFDFCFCFDFDFDFEFFFFFBFFFFFBFFFF00FAFDFFFCFFFCFEFFF5FFFFF6FAFE
      FBF3FFFFBCCEDC8590A2828391F4F1F3FFFEFFFFFFFFFFFEFEFEFEFEFEFFFFFB
      FFFFFAFFFF00F5FDFFFDFFFDFFFFF8FEFFF6FAFFFAFBFFFFFFFFFFB3ACB1C3BC
      BDB4AFAEADAAA7D1CCCCFEFFFFFFFFFFFEFEFEFCFEFEFAFEFE00FBFDFFFCFDFE
      FFFDFFFFFEFEFFFEFDFBF9F5C0B2A6A69281D0BFAACFD2BFD1D3C4AFAEA3C6C1
      BCFFFDFCFFFCFEFCFBFDFAFEFE00FFFEFFFCFDFFFFFDFFFFFEFFFFFFFFDBD7D2
      746557B8A591EAD7BFD9D8BFE9E9D3FAF4E4A99E96E5E0DDFFFFFFFFFCFFFAFF
      FF00FFFEFFFEFEFFFFFEFFFFFDFFFFFFFFA9A09A9F9386DFCFBCE4D3BDE1D8BC
      E5DEC5ECE2D0C2B6ACBEB2ADFFFFFFFEFEFEFAFDFD00FFFEFFFFFEFFFFFEFFFF
      FDFFFFFFFFA49D98C5B9AFF4E6D6EEDCCAE4D6B9D9CCB0E2D3BFAB9D92BBADA8
      FFFFFEFEFEFFF9FCFE00FFFDFFFFFEFFFDFEFFFDFEFFFFFFFFCCC7C4B3AAA0FD
      F0E4E4D4C1DBC8AED3C2A7C3B49F8E8175E5DDD8FFFFFFFEFCFFFBFEFF00FFFD
      FFFFFDFFFBFEFFFCFEFFFFFFFFF3F0F0988E87BEB3A8CDBEAEBCA993B29E8983
      7262B1A69BFFFFFFFFFFFFFFFEFFFCFFFF00FFFFFFFFFDFFFBFEFFFCFEFFFFFC
      FFFFFFFFF6F1EF978F877B6E63725F53806E63ACA097FFFEFCFFFFFFFDFFFFFE
      FFFFFCFFFD00FFFFFFFFFDFFFCFEFFFCFEFFFDFEFFFBFAF9FFFFFFFFFFFFEEE8
      E1EAE4DFF2ECE8FFFFFFFCFCFEFCFDFCFBFEFFFCFFFFFFFFFD00FFFFFFFFFDFF
      FCFEFFFDFEFFF9F8FAFEFDFDFFFDFBFEFDF8FFFFFAFFFFFFFFFFFFFFFDFFF9F8
      FCF9FBFDF9FDFFFDFFFFFFFFFD00}
  end
  object pnlOpcSelecionar: TPanel
    Left = 13
    Top = 410
    Width = 657
    Height = 20
    BevelOuter = bvNone
    TabOrder = 4
    object rdBtnServidor: TRadioButton
      Left = 55
      Top = 2
      Width = 80
      Height = 17
      Caption = 'Servidor'
      TabOrder = 0
      OnClick = rdBtnServidorClick
    end
    object rdBtnDominio1: TRadioButton
      Left = 287
      Top = 2
      Width = 80
      Height = 17
      Caption = 'Dom'#237'nio 1'
      TabOrder = 1
      OnClick = rdBtnDominio1Click
    end
    object rdBtnDominio2: TRadioButton
      Left = 521
      Top = 2
      Width = 80
      Height = 17
      Caption = 'Dom'#237'nio 2'
      TabOrder = 2
      OnClick = rdBtnDominio2Click
    end
  end
  object btBtnLimpar: TBitBtn
    Left = 264
    Top = 455
    Width = 120
    Height = 30
    Caption = 'Limpar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = btBtnLimparClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFEFFE0E5B2
      FFFEFFF8F8F9FBFBF6FBFBF8FBFBF8FBFBF8FBFBF8FBFBF8FBFBF8FBFBF8FAFB
      F8F7FBF7FAF6F3FAFCF7FDFBF8FBF7FFF7F5EFF5F5EFF5F5F3F4F4F1F4F4F1F5
      F5F2F5F5F2F5F5F2F5F5F2F5F5F2F5F4F2F9F7F1EEF0EBFAF9F6FAFDFAF0F0EF
      FCFCF6F9F8F3F7FAF6F9F7F6F9F9F6F8FAF5FAF8F7F8F8F5F7FAF7F8FAF8FAF7
      F6FAFAF7F3F5F1FEFDFBFBFCF7EFEFEAF7F7F4F3F5F1F6F5F2F5F5F2F5F5F2F6
      F5F2F4F6F2F4F5F2F6F5F2F6F5F2F5F4EFF7F7F3EFEFEEFAFAF8FCFAF8F2F3EE
      F8F8F5F6F5F1F7F7F3F6F7F3F6F7F2F7F7F4F6F8F4F6F7F4F7F7F4F8F7F4F4F6
      F2F9F9F5F0F2EDFBFBF8FDFBFBEEF2ECF9F9F6F7F5F2F9F7F3F7F7F2F8F6F2F6
      F7F4F7F7F4F8F8F4F7F7F5F7F8F6F6F8F4F9FCF7F1F2EFFBFCF8FCFCF9EEF1EB
      F9FAF6F8F7F3F8F7F3F6F6F2F7F6F2F6F7F3F7F7F4F6F6F3F6F7F4F7F8F5F6F8
      F4F9FBF5F1EFF0FAFCF7FAFDF7EFF0EEF9F9F5F6F7F2F7F7F4F5F6F3F5F5F3F5
      F6F2F7F7F5F5F7F3F5F7F4F7F8F4F6F7F3F9FAF6F2F2F0FAFBF6FBFDF7EFEFEF
      F8F8F5F4F6F1F7F7F4F5F7F4F5F5F3F6F6F3F6F8F4F6F7F2F5F7F4F7F8F5F5F7
      F2F8F9F6F1F1EFFAFBF8FCFBF7EEF1EEFAF9F6F6F5F3F8F8F4F7F8F4F7F6F3F6
      F7F4F7F8F3F7F7F4F6F6F4F7F7F5F6F7F2F8F9F6F1F2F0FAFBF8FCFCF9EDF1EC
      FBF9F4F8F6F3F8F7F3F8F7F3F8F6F3F6F6F3F7F8F2F7F6F3F7F6F3F8F7F5F8F8
      F4F9FBF7F2F3F0FBFCF8FBFDF9F2F3F0FAFBF7F7F6F4F8F7F5F8F7F5F7F7F5F7
      F7F5F6F9F4F6F7F3F8F6F5F7F8F5F6F7F4F9FAF7F3F3F0FCFDF8FCFDF7EBEBEC
      F8F8F4F3F4F1F5F6F3F3F5F3F4F5F3F4F6F3F5F8F3F4F7F1F4F5F3F6F7F3F3F5
      F1F9F8F6EEF1EAFAFBF8FBFCF8F2F4F1F9F9F6F7F7F4FAF9F7FBF7F6FAF9F6F7
      FBF7F9F9F7FBF8F7F9F8F7F9F9F7F8F7F6FBF9F8F4F4F3FCFDFAFBF9F7F1EFEC
      F7F7F5F4F4F1F4F7EEF4F8EDF4F6EDF4F5ECF4F5EBF4F6ECF4F6EDF4F6EEF4F5
      EDF4F8EFEDEDE5FAFEF4FDFAF6F6F1EDFAF8F4F8FAF5FCF8FCFDF8FCFDFAFCFD
      FBFCFDFBFDFDFAFDFDF8FDFDFAFDFDF8FDFDFAFDF8FCFBFDF9FD}
  end
  object lstBxEmailsServidor: TListBox
    Left = 10
    Top = 247
    Width = 200
    Height = 150
    ItemHeight = 14
    MultiSelect = True
    TabOrder = 6
  end
  object lstBxEmailsDominio1: TListBox
    Left = 240
    Top = 247
    Width = 200
    Height = 150
    ItemHeight = 14
    MultiSelect = True
    TabOrder = 7
  end
  object lstBxEmailsDominio2: TListBox
    Left = 470
    Top = 247
    Width = 200
    Height = 150
    ItemHeight = 14
    MultiSelect = True
    TabOrder = 8
  end
  object btBtnDeletar: TBitBtn
    Left = 528
    Top = 455
    Width = 120
    Height = 30
    Caption = 'Deletar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = btBtnDeletarClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000390000003900000039000000
      3900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF0000009C0000009C0000008400182194004A52A5004A52A5001010
      6B00000042000000420000003900FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000A5000008AD00BDBDEF00FFFFFF00FFFFFF00FFFFFF00F7F7
      FF009CA5CE000000420000003100FF00FF00FF00FF00FF00FF00FF00FF000008
      C6000000BD00FFFFFF00FFFFFF00FFFFFF008C94DE0029299C0029299C00ADB5
      E700FFFFFF00FFFFFF00D6D6EF000000310000004A00FF00FF00FF00FF000000
      C6001829D600FFFFFF00FFFFFF001821AD0000008C0000008C0000007B000000
      7B0031319C00FFFFFF00FFFFFF0000004A0000004200FF00FF00FF00FF002131
      DE00FFFFFF00E7E7F7000818C6000000AD000000A50000089C0008088C000000
      7B000000730018189400F7F7FF00CECEE70000005200FF00FF000008EF00637B
      F700FFFFFF004A63E7000000C6000000B5000000AD0000089C0008088C000000
      73000000730000006B007B7BC600FFFFFF0031318400000052000008FF00E7EF
      FF00FFFFFF000010EF000008E700E7EFFF00D6D6FF00CECEEF00C6C6EF00DEDE
      F700E7E7F7000000730000007B00FFFFFF00A5A5DE00000042000010FF00F7F7
      FF00FFFFFF000010FF000008EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000007B0000008400FFFFFF00ADB5E70000007B001839FF00E7EF
      FF00FFFFFF000821FF000008FF000010F7000008E7000810C6000810C6000000
      B5000000AD00000094002129B500FFFFFF00737BD600000084000010FF00CEDE
      FF00FFFFFF00637BFF000008FF000010FF000008F7000018E7000000CE000000
      BD000000BD000000A5008C94DE00FFFFFF002931C600FF00FF00FF00FF006B84
      FF00FFFFFF00FFFFFF00CED6FF000008FF000010FF000018FF000010E7000008
      DE000000CE00EFEFFF00FFFFFF004252CE0000009C00FF00FF00FF00FF003152
      FF00CEDEFF00FFFFFF00FFFFFF00395AFF000018FF000008FF000008FF000018
      EF00526BEF00FFFFFF00FFFFFF000008AD000000A500FF00FF00FF00FF00FF00
      FF004263FF00EFF7FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0094A5F7000810CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF005273FF00B5C6FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00ADB5FF000008D6000000C600FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00526BFF003152FF00395AFF00294AFF001029
      F7001029EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
  end
  object btBtnValidarServidor: TBitBtn
    Left = 8
    Top = 200
    Width = 57
    Height = 25
    Caption = 'Validar'
    TabOrder = 10
    OnClick = btBtnValidarServidorClick
  end
  object Memo1: TMemo
    Left = 24
    Top = 512
    Width = 529
    Height = 89
    Lines.Strings = (
      'Fun'#231#245'es gerais para servidor, dom'#237'nio 1 e dom'#237'nio 2:'
      
        '-> Para torn'#225'-los v'#225'lidos, selecione um ou mais na caixa acima, ' +
        'e clique no bot'#227'o "Validar" logo ao lado.'
      
        '-> Para pesquisar, selecione um ou mais na caixa acima, e clique' +
        ' no bot'#227'o "Pesquisar".'
      '-> Para')
    TabOrder = 11
  end
  object BitBtn1: TBitBtn
    Left = 240
    Top = 200
    Width = 57
    Height = 25
    Caption = 'Validar'
    TabOrder = 12
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 504
    Top = 200
    Width = 57
    Height = 25
    Caption = 'Validar'
    TabOrder = 13
    OnClick = BitBtn2Click
  end
  object zQryVerificar: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT *'
      'FROM email e'
      'WHERE 1=2')
    Params = <>
    Left = 440
    Top = 423
    object zQryVerificarCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryVerificarEMAIL: TStringField
      FieldName = 'EMAIL'
      Required = True
      Size = 100
    end
    object zQryVerificarSERVIDOR_DO_EMAIL: TStringField
      FieldName = 'SERVIDOR_DO_EMAIL'
      Size = 50
    end
    object zQryVerificarDOMINIO_1: TStringField
      FieldName = 'DOMINIO_1'
      Size = 10
    end
    object zQryVerificarDOMINIO_2: TStringField
      FieldName = 'DOMINIO_2'
      Size = 5
    end
    object zQryVerificarNOME_PROPRIETARIO: TStringField
      FieldName = 'NOME_PROPRIETARIO'
      Size = 100
    end
    object zQryVerificarCIDADE_PROPRIETARIO: TStringField
      FieldName = 'CIDADE_PROPRIETARIO'
      Size = 100
    end
    object zQryVerificarESTADO_PROPRIETARIO: TStringField
      FieldName = 'ESTADO_PROPRIETARIO'
      Size = 5
    end
    object zQryVerificarPAIS_PROPRIETARIO: TStringField
      FieldName = 'PAIS_PROPRIETARIO'
      Size = 50
    end
    object zQryVerificarMEIO_CAPTACAO: TStringField
      FieldName = 'MEIO_CAPTACAO'
      Size = 200
    end
    object zQryVerificarRELEVANCIA: TIntegerField
      FieldName = 'RELEVANCIA'
    end
    object zQryVerificarDATA_INSERCAO: TDateTimeField
      FieldName = 'DATA_INSERCAO'
    end
  end
end
