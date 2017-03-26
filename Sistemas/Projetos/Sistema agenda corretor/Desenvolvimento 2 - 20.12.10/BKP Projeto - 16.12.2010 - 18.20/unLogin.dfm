object frmLogin: TfrmLogin
  Left = 324
  Top = 110
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 198
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSenha: TLabel
    Left = 16
    Top = 99
    Width = 49
    Height = 16
    Caption = 'Senha:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblUsuario: TLabel
    Left = 16
    Top = 69
    Width = 63
    Height = 16
    Caption = 'Usu'#225'rio: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVersao: TLabel
    Left = 152
    Top = 28
    Width = 51
    Height = 16
    Alignment = taRightJustify
    Caption = 'Versao'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object lblSistema: TLabel
    Left = 15
    Top = 6
    Width = 188
    Height = 20
    Caption = ' SISTEMA CORRETOR'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object plsEdUsuario: TPlsEdit
    Left = 86
    Top = 63
    Width = 142
    Height = 21
    Hint = 'Digite o usu'#225'rio.'
    CharCase = ecUpperCase
    MaxLength = 10
    TabOrder = 0
    OnKeyPress = plsEdUsuarioKeyPress
    plsCorRecebeFoco = clMedGray
    plsEnterMudaCampo = True
  end
  object plsMedSenha: TPlsMaskEdit
    Left = 86
    Top = 93
    Width = 142
    Height = 21
    Hint = 'Digite a senha do usu'#225'rio.'
    CharCase = ecUpperCase
    MaxLength = 10
    PasswordChar = '*'
    TabOrder = 1
    Text = 'PLSMEDSENHA'
    OnKeyPress = plsMedSenhaKeyPress
    plsCorRecebeFoco = clMedGray
    plsEnterMudaCampo = True
  end
  object btBtnLogin: TBitBtn
    Left = 16
    Top = 125
    Width = 120
    Height = 40
    Hint = 'Realizar login no sistema.'
    Caption = 'LOGIN'
    TabOrder = 2
    OnClick = btBtnLoginClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btBtnFinalizar: TBitBtn
    Left = 145
    Top = 125
    Width = 120
    Height = 40
    Hint = 'Finalizar sistema.'
    Caption = 'Finalizar'
    TabOrder = 3
    OnClick = btBtnFinalizarClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
      F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
      000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
      338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
      45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
      3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
      F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
      000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
      338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
      4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
      8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
      333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
      0000}
    NumGlyphs = 2
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 179
    Width = 313
    Height = 19
    Panels = <
      item
        Width = 190
      end
      item
        Alignment = taCenter
        Width = 50
      end>
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 238
    Top = 64
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 266
    Top = 64
  end
end
