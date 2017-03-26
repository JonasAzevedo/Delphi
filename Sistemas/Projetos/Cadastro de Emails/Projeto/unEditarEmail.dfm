object frmEditarEmail: TfrmEditarEmail
  Left = 361
  Top = 117
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'EDITAR E-MAIL'
  ClientHeight = 522
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 14
  object lblRelevancia: TLabel
    Left = 5
    Top = 436
    Width = 56
    Height = 14
    Caption = 'Relev'#226'ncia:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblMeioCaptacao: TLabel
    Left = 5
    Top = 366
    Width = 49
    Height = 28
    Caption = 'Meio Capta'#231#227'o:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object lblDadosOrigem: TLabel
    Left = 67
    Top = 336
    Width = 110
    Height = 16
    Caption = 'Dados de Origem'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblEstado: TLabel
    Left = 5
    Top = 306
    Width = 36
    Height = 14
    Caption = 'Estado:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblCidade: TLabel
    Left = 5
    Top = 276
    Width = 36
    Height = 14
    Caption = 'Cidade:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblNome: TLabel
    Left = 5
    Top = 216
    Width = 30
    Height = 14
    Caption = 'Nome:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblPais: TLabel
    Left = 5
    Top = 246
    Width = 23
    Height = 14
    Caption = 'Pais:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblDominio2: TLabel
    Left = 5
    Top = 156
    Width = 49
    Height = 14
    Caption = 'Dom'#237'nio 2:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblDominio1: TLabel
    Left = 5
    Top = 126
    Width = 49
    Height = 14
    Caption = 'Dom'#237'nio 1:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblServidor: TLabel
    Left = 5
    Top = 96
    Width = 44
    Height = 14
    Caption = 'Servidor:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblEmail: TLabel
    Left = 5
    Top = 66
    Width = 31
    Height = 14
    Caption = 'E-Mail:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object lblDadosProprietario: TLabel
    Left = 67
    Top = 186
    Width = 139
    Height = 16
    Caption = 'Dados do Propriet'#225'rio'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDadosEmail: TLabel
    Left = 67
    Top = 7
    Width = 99
    Height = 16
    Caption = 'Dados do Email'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object bvlDivisao: TBevel
    Left = 4
    Top = 455
    Width = 459
    Height = 11
    Shape = bsBottomLine
  end
  object lblCodigo: TLabel
    Left = 5
    Top = 36
    Width = 39
    Height = 14
    Caption = 'C'#243'digo: '
  end
  object lblVlrCodigo: TLabel
    Left = 65
    Top = 36
    Width = 57
    Height = 14
    Caption = 'lblVlrCodigo'
  end
  object cbBxRelevancia: TPlsComboBox
    Left = 65
    Top = 430
    Width = 57
    Height = 22
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 10
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10')
    plsCorRecebeFoco = clSilver
  end
  object mmMeioCaptacao: TPlsMemo
    Left = 65
    Top = 366
    Width = 344
    Height = 49
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Lines.Strings = (
      'mmMeioCaptacao')
    MaxLength = 200
    ParentFont = False
    TabOrder = 8
    plsCorRecebeFoco = clSilver
  end
  object edEstado: TPlsEdit
    Left = 65
    Top = 300
    Width = 67
    Height = 22
    CharCase = ecUpperCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 7
    Text = 'EDESTADO'
    plsCorRecebeFoco = clSilver
  end
  object edCidade: TPlsEdit
    Left = 65
    Top = 270
    Width = 260
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 100
    ParentFont = False
    TabOrder = 6
    Text = 'edCidade'
    plsCorRecebeFoco = clSilver
  end
  object edPais: TPlsEdit
    Left = 65
    Top = 240
    Width = 260
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 50
    ParentFont = False
    TabOrder = 5
    Text = 'edPais'
    plsCorRecebeFoco = clSilver
  end
  object edNome: TPlsEdit
    Left = 65
    Top = 210
    Width = 363
    Height = 22
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 100
    ParentFont = False
    TabOrder = 4
    Text = 'edNome'
    plsCorRecebeFoco = clSilver
  end
  object edDominio2: TPlsEdit
    Left = 65
    Top = 150
    Width = 121
    Height = 22
    CharCase = ecLowerCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 3
    Text = 'eddominio2'
    plsCorRecebeFoco = clSilver
  end
  object edDominio1: TPlsEdit
    Left = 65
    Top = 120
    Width = 121
    Height = 22
    CharCase = ecLowerCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 10
    ParentFont = False
    TabOrder = 2
    Text = 'eddominio1'
    plsCorRecebeFoco = clSilver
  end
  object edEmail: TPlsEdit
    Left = 65
    Top = 60
    Width = 363
    Height = 22
    CharCase = ecLowerCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 100
    ParentFont = False
    TabOrder = 0
    Text = 'edemail'
    plsCorRecebeFoco = clSilver
  end
  object edServidor: TPlsEdit
    Left = 65
    Top = 90
    Width = 179
    Height = 22
    CharCase = ecLowerCase
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MaxLength = 50
    ParentFont = False
    TabOrder = 1
    Text = 'edservidor'
    plsCorRecebeFoco = clSilver
  end
  object btBtnSalvar: TBitBtn
    Left = 347
    Top = 474
    Width = 89
    Height = 33
    Caption = 'Salvar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    OnClick = btBtnSalvarClick
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000031940000319400003194000031
      9400FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000063FF00005AF700106BE7004A94E7008CBDEF008CBDEF004284
      D600085ABD0000297B0000216300FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00005AFF00187BFF00F7F7FF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E7EFFF00105ABD0000319400FF00FF00FF00FF00FF00FF00FF00FF00006B
      FF00006BFF00FFFFFF00FFFFFF00DEEFFF0073B5FF002984EF00217BEF0084B5
      F700EFF7FF00FFFFFF00FFFFFF000031940000216300FF00FF00FF00FF000063
      FF0063ADFF00FFFFFF00FFFFFF00086BFF000052F700B5D6FF001073EF000052
      E700106BE700FFFFFF00FFFFFF001863BD0000318C00FF00FF00FF00FF005AAD
      FF00FFFFFF00B5DEFF00006BFF003994FF00EFF7FF00FFFFFF00BDDEFF00005A
      E700005AE7000863E700D6E7FF00FFFFFF00296BC600FF00FF000873FF00B5DE
      FF00FFFFFF004294FF000063FF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00005A
      EF00005AE700004ADE00529CF700FFFFFF007BADE700003994000873FF00FFFF
      FF00FFFFFF00107BFF00C6DEFF00F7FFFF0063ADFF00006BFF00D6E7FF00006B
      FF00005AFF00005AEF00005AE700FFFFFF00E7EFFF00005AE700107BFF00FFFF
      FF00FFFFFF00107BFF00318CFF004A9CFF00006BFF00006BFF004294FF003994
      FF00005AFF00005AF700005AEF00FFFFFF00EFF7FF00005AEF00187BFF00FFFF
      FF00FFFFFF002184FF00187BFF00187BFF00107BFF001073FF00086BFF00D6EF
      FF002184FF000063FF00107BFF00FFFFFF00B5DEFF00005AF7003994FF00EFF7
      FF00FFFFFF005AADFF00107BFF001884FF00187BFF00107BFF001073FF0052A5
      FF0084BDFF00005AFF006BADFF00FFFFFF0073B5FF00005AF700FF00FF0094CE
      FF00FFFFFF00FFFFFF00ADD6FF00107BFF00187BFF00187BFF00187BFF000873
      FF000873FF00BDDEFF00FFFFFF0094CEFF000063FF00FF00FF00FF00FF0052A5
      FF00E7F7FF00FFFFFF00FFFFFF004294FF00187BFF00107BFF00107BFF00107B
      FF00429CFF00FFFFFF00FFFFFF00107BFF000063FF00FF00FF00FF00FF00FF00
      FF005AA5FF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D6E7FF00429CFF00006BFF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF007BBDFF00D6E7FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E7F7FF001884FF00006BFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF005AA5FF005AA5FF0063ADFF0052A5FF00298C
      FF00187BFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
  end
  object btBtnSelecionarMeioCaptacao: TBitBtn
    Left = 410
    Top = 366
    Width = 25
    Height = 49
    Caption = '>>>'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object zQryPesquisa: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT * '
      'FROM email'
      'WHERE 1=2')
    Params = <>
    Left = 440
    Top = 8
    object zQryPesquisaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryPesquisaEMAIL: TStringField
      FieldName = 'EMAIL'
      Required = True
      Size = 100
    end
    object zQryPesquisaSERVIDOR_DO_EMAIL: TStringField
      FieldName = 'SERVIDOR_DO_EMAIL'
      Size = 50
    end
    object zQryPesquisaDOMINIO_1: TStringField
      FieldName = 'DOMINIO_1'
      Size = 10
    end
    object zQryPesquisaDOMINIO_2: TStringField
      FieldName = 'DOMINIO_2'
      Size = 5
    end
    object zQryPesquisaNOME_PROPRIETARIO: TStringField
      FieldName = 'NOME_PROPRIETARIO'
      Size = 100
    end
    object zQryPesquisaCIDADE_PROPRIETARIO: TStringField
      FieldName = 'CIDADE_PROPRIETARIO'
      Size = 100
    end
    object zQryPesquisaESTADO_PROPRIETARIO: TStringField
      FieldName = 'ESTADO_PROPRIETARIO'
      Size = 5
    end
    object zQryPesquisaPAIS_PROPRIETARIO: TStringField
      FieldName = 'PAIS_PROPRIETARIO'
      Size = 50
    end
    object zQryPesquisaMEIO_CAPTACAO: TStringField
      FieldName = 'MEIO_CAPTACAO'
      Size = 200
    end
    object zQryPesquisaRELEVANCIA: TIntegerField
      FieldName = 'RELEVANCIA'
    end
    object zQryPesquisaDATA_INSERCAO: TDateTimeField
      FieldName = 'DATA_INSERCAO'
    end
  end
end
