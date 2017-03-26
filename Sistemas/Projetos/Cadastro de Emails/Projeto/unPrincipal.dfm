object frmCadastroEmails: TfrmCadastroEmails
  Left = 25
  Top = 79
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Emails'
  ClientHeight = 551
  ClientWidth = 1187
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 14
  object grpBxCadastroLoteEmail: TGroupBox
    Left = 0
    Top = 0
    Width = 1187
    Height = 245
    Align = alTop
    Caption = 'Cadastro de Email'#39's em Lote '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lblSeparadorEmailsLote: TLabel
      Left = 10
      Top = 185
      Width = 98
      Height = 14
      Caption = 'Caracter separador:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblRelevancia: TLabel
      Left = 10
      Top = 224
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
    object mmLoteEmails: TMemo
      Left = 8
      Top = 22
      Width = 1169
      Height = 151
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Lines.Strings = (
        'mmLoteEmails')
      ParentFont = False
      TabOrder = 0
      OnChange = mmLoteEmailsChange
      OnExit = mmLoteEmailsExit
    end
    object btBtnSalvarImportacaoLote: TBitBtn
      Left = 1072
      Top = 195
      Width = 108
      Height = 41
      Caption = 'Cadastrar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = btBtnSalvarImportacaoLoteClick
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
    object ckBxVerificarEmailNomeProprietario: TCheckBox
      Left = 523
      Top = 173
      Width = 217
      Height = 20
      Caption = 'Verificar email com nome do propriet'#225'rio'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 4
      OnClick = ckBxVerificarEmailNomeProprietarioClick
    end
    object cbBxRelevancia: TPlsComboBox
      Left = 110
      Top = 214
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
      TabOrder = 2
      OnChange = cbBxRelevanciaChange
      OnExit = cbBxRelevanciaExit
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
    object ckBxConfirmarServidorDominios: TCheckBox
      Left = 826
      Top = 218
      Width = 167
      Height = 17
      Caption = 'Confirmar Servidor e Dom'#237'nios'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object pnlMeioCaptacao: TPanel
      Left = 176
      Top = 199
      Width = 333
      Height = 38
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object lblMeioCaptacao: TLabel
        Left = 2
        Top = 20
        Width = 74
        Height = 14
        Caption = 'Meio Capta'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object mmMeioCaptacao: TPlsMemo
        Left = 86
        Top = 4
        Width = 219
        Height = 32
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        Lines.Strings = (
          'mmMeioCaptacao')
        MaxLength = 200
        ParentFont = False
        TabOrder = 0
        OnChange = mmMeioCaptacaoChange
        OnExit = mmMeioCaptacaoExit
        plsCorRecebeFoco = clSilver
      end
      object btBtnSelecionarMeioCaptacao: TBitBtn
        Left = 304
        Top = 4
        Width = 25
        Height = 32
        Caption = '>>>'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btBtnSelecionarMeioCaptacaoClick
      end
    end
    object rdGrpSeparacaoEmailNomeProprietario: TRadioGroup
      Left = 523
      Top = 188
      Width = 289
      Height = 50
      Columns = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'nome <email>'
        'email <nome>'
        'nome (email)'
        'email (nome)')
      ParentFont = False
      TabOrder = 5
      OnClick = rdGrpSeparacaoEmailNomeProprietarioClick
    end
    object cbBxCaracterSeparador: TPlsComboBox
      Left = 110
      Top = 179
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
      TabOrder = 1
      OnChange = cbBxCaracterSeparadorChange
      OnExit = cbBxCaracterSeparadorExit
      Items.Strings = (
        ','
        ';')
      plsCorRecebeFoco = clSilver
    end
    object ckBxPegarNomeProprietarioEmail: TCheckBox
      Left = 826
      Top = 200
      Width = 194
      Height = 16
      Caption = 'Pegar Nome do Propriet'#225'rio do Email'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 6
    end
  end
  object pnlOutrosDadosCadastro: TPanel
    Left = 0
    Top = 245
    Width = 1187
    Height = 164
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object grpBxDadosEmail: TGroupBox
      Left = 0
      Top = 0
      Width = 873
      Height = 164
      Align = alLeft
      Caption = 'Dados de Cadastro do Email '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object lblEmail: TLabel
        Left = 8
        Top = 79
        Width = 31
        Height = 14
        Caption = 'E-Mail:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNome: TLabel
        Left = 8
        Top = 49
        Width = 30
        Height = 14
        Caption = 'Nome:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblCidade: TLabel
        Left = 497
        Top = 109
        Width = 36
        Height = 14
        Caption = 'Cidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblEstado: TLabel
        Left = 497
        Top = 139
        Width = 36
        Height = 14
        Caption = 'Estado:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblServidor: TLabel
        Left = 8
        Top = 109
        Width = 44
        Height = 14
        Caption = 'Servidor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblDominio1: TLabel
        Left = 8
        Top = 139
        Width = 49
        Height = 14
        Caption = 'Dom'#237'nio 1:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblDominio2: TLabel
        Left = 250
        Top = 139
        Width = 49
        Height = 14
        Caption = 'Dom'#237'nio 2:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblPais: TLabel
        Left = 497
        Top = 79
        Width = 23
        Height = 14
        Caption = 'Pais:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblDadosEmail: TLabel
        Left = 72
        Top = 21
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
      object lblDadosProprietario: TLabel
        Left = 541
        Top = 19
        Width = 139
        Height = 16
        Caption = 'Dados do Propriet'#225'rio'
      end
      object Label1: TLabel
        Left = 509
        Top = 49
        Width = 271
        Height = 14
        Caption = 'Pa'#237's, Cidade e Estado ser'#227'o repetidos para todo o lote.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
      end
      object edEmail: TPlsEdit
        Left = 68
        Top = 73
        Width = 363
        Height = 22
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        CharCase = ecLowerCase
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 100
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        Text = 'edemail'
        OnExit = edEmailExit
        plsCorRecebeFoco = clSilver
      end
      object edServidor: TPlsEdit
        Left = 68
        Top = 103
        Width = 179
        Height = 22
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        CharCase = ecLowerCase
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 50
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = 'edservidor'
        plsCorRecebeFoco = clSilver
      end
      object edDominio1: TPlsEdit
        Left = 68
        Top = 133
        Width = 121
        Height = 22
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        CharCase = ecLowerCase
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        Text = 'eddominio1'
        plsCorRecebeFoco = clSilver
      end
      object edDominio2: TPlsEdit
        Left = 310
        Top = 133
        Width = 121
        Height = 22
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        CharCase = ecLowerCase
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        Text = 'eddominio2'
        plsCorRecebeFoco = clSilver
      end
      object edNome: TPlsEdit
        Left = 68
        Top = 43
        Width = 363
        Height = 22
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 100
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = 'edNome'
        plsCorRecebeFoco = clSilver
      end
      object edCidade: TPlsEdit
        Left = 539
        Top = 103
        Width = 260
        Height = 22
        Font.Charset = DEFAULT_CHARSET
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
      object edEstado: TPlsEdit
        Left = 539
        Top = 133
        Width = 67
        Height = 22
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
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
      object edPais: TPlsEdit
        Left = 539
        Top = 73
        Width = 260
        Height = 22
        Font.Charset = DEFAULT_CHARSET
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
      object btBtnSalvarCadastroSimples: TBitBtn
        Left = 643
        Top = 127
        Width = 83
        Height = 33
        Caption = 'Salvar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        Visible = False
        OnClick = btBtnSalvarCadastroSimplesClick
      end
    end
    object grpBxAreasInteresse: TGroupBox
      Left = 872
      Top = 0
      Width = 315
      Height = 164
      Align = alRight
      Caption = #193'reas de Interesse '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object ScrollBar1: TScrollBar
        Left = 296
        Top = 18
        Width = 17
        Height = 144
        Align = alRight
        Kind = sbVertical
        Max = 1000
        PageSize = 0
        TabOrder = 0
      end
    end
  end
  object grpBxAcompanhamentoProcesso: TGroupBox
    Left = 0
    Top = 409
    Width = 1187
    Height = 104
    Align = alTop
    Caption = 'Acompanhamento do Processo '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object lblInfTotalEmails: TLabel
      Left = 10
      Top = 20
      Width = 61
      Height = 14
      Caption = 'Total Email'#39's:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalEmails: TLabel
      Left = 78
      Top = 20
      Width = 63
      Height = 14
      Caption = 'lblTotalEmails'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblInfEmailsInseridos: TLabel
      Left = 10
      Top = 40
      Width = 47
      Height = 14
      Caption = 'Inseridos:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalEmailsInseridos: TLabel
      Left = 78
      Top = 40
      Width = 107
      Height = 14
      Caption = 'lblTotalEmailsInseridos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblInfEmailsRepetidos: TLabel
      Left = 10
      Top = 60
      Width = 51
      Height = 14
      Caption = 'Repetidos:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblInfEmailsRejeitados: TLabel
      Left = 10
      Top = 80
      Width = 53
      Height = 14
      Caption = 'Rejeitados:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalEmailsRepetidos: TLabel
      Left = 78
      Top = 60
      Width = 111
      Height = 14
      Caption = 'lblTotalEmailsRepetidos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalEmailsRejeitados: TLabel
      Left = 78
      Top = 80
      Width = 113
      Height = 14
      Caption = 'lblTotalEmailsRejeitados'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object lblAcompanhamentoProcesso: TLabel
      Left = 512
      Top = 52
      Width = 174
      Height = 16
      Caption = 'Acompanhamento cadastro'
    end
    object prgBarAcompanhamentoProcesso: TProgressBar
      Left = 146
      Top = 21
      Width = 13
      Height = 72
      Orientation = pbVertical
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 257
      Top = 12
      Width = 248
      Height = 83
      Caption = 'Servidor / Dom'#237'nio Desconhecidos '
      TabOrder = 1
      object lblInfServidorDesconhecido: TLabel
        Left = 10
        Top = 20
        Width = 44
        Height = 14
        Caption = 'Servidor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblTotalServidorDesconhecido: TLabel
        Left = 80
        Top = 20
        Width = 143
        Height = 14
        Caption = 'lblTotalServidorDesconhecido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblInfDominio1Desconhecido: TLabel
        Left = 10
        Top = 40
        Width = 49
        Height = 14
        Caption = 'Dom'#237'nio 1:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblTotalDominio1Desconhecido: TLabel
        Left = 80
        Top = 40
        Width = 145
        Height = 14
        Caption = 'lblTotalDominio1Desconhecido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblInfDominio2Desconhecido: TLabel
        Left = 10
        Top = 60
        Width = 49
        Height = 14
        Caption = 'Dom'#237'nio 2:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblTotalDominio2Desconhecido: TLabel
        Left = 80
        Top = 60
        Width = 145
        Height = 14
        Caption = 'lblTotalDominio2Desconhecido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object pnlVerificarCampoValido: TPanel
    Left = 512
    Top = 477
    Width = 657
    Height = 25
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object ckBxOkEmails: TCheckBox
      Left = 2
      Top = 6
      Width = 74
      Height = 17
      Caption = 'Email(s)'
      TabOrder = 0
    end
    object ckBxOkCaracSeparador: TCheckBox
      Left = 92
      Top = 6
      Width = 133
      Height = 17
      Caption = 'Caracter separador'
      TabOrder = 1
    end
    object ckBxOkRelevancia: TCheckBox
      Left = 244
      Top = 6
      Width = 85
      Height = 17
      Caption = 'Relev'#226'ncia'
      TabOrder = 2
    end
    object ckBxOkMeioCaptacao: TCheckBox
      Left = 346
      Top = 6
      Width = 128
      Height = 17
      Caption = 'Meio de Capta'#231#227'o'
      TabOrder = 3
    end
    object ckBxOkVerificarEmailNome: TCheckBox
      Left = 489
      Top = 6
      Width = 145
      Height = 17
      Caption = 'Verificar Email/Nome'
      TabOrder = 4
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 532
    Width = 1187
    Height = 19
    Panels = <>
  end
  object MainMenu1: TMainMenu
    Left = 13
    Top = 34
    object mnItArquivo: TMenuItem
      Caption = 'Arquivo'
      object mnItSair: TMenuItem
        Caption = 'Sair'
        OnClick = mnItSairClick
      end
    end
    object mnItOpcoes: TMenuItem
      Caption = 'Op'#231#245'es'
      object mnItLimpar: TMenuItem
        Caption = 'Limpar'
        OnClick = mnItLimparClick
      end
    end
    object Atalhos1: TMenuItem
      Caption = 'Atalhos'
      object mnItFocoLoteEmails: TMenuItem
        Caption = 'Foco no lote de email'#39's'
        ShortCut = 116
        OnClick = mnItFocoLoteEmailsClick
      end
      object mnItFocoCaracterSeparador: TMenuItem
        Caption = 'Foco no caracter separador'
        ShortCut = 117
        OnClick = mnItFocoCaracterSeparadorClick
      end
      object mnItSelecaoMeioCaptacao: TMenuItem
        Caption = 'Sele'#231#227'o do meio de capta'#231#227'o'
        ShortCut = 118
        OnClick = mnItSelecaoMeioCaptacaoClick
      end
      object mnItImportaoLote: TMenuItem
        Caption = 'Importa'#231#227'o do lote'
        ShortCut = 119
        OnClick = mnItImportaoLoteClick
      end
    end
  end
  object cdsServidores: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'SERVIDOR_DO_EMAIL'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 384
    Top = 204
  end
  object cdsDominios_1: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DOMINIO_1'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 384
    Top = 232
  end
  object cdsDominios_2: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DOMINIO_2'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 384
    Top = 260
  end
  object zQryBuscarDistinct: TZQuery
    Connection = DM.ZConnection
    Params = <>
    Left = 352
    Top = 232
  end
end
