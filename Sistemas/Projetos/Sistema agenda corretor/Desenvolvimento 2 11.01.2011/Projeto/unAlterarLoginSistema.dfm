object frmAlterarLoginSistema: TfrmAlterarLoginSistema
  Left = 376
  Top = 181
  BorderStyle = bsDialog
  Caption = 'ALTERAR LOGIN SISTEMA'
  ClientHeight = 278
  ClientWidth = 295
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grpBxLoginSenhaAtuais: TGroupBox
    Left = 8
    Top = 8
    Width = 273
    Height = 81
    Caption = 'Login e Senha Atuais '
    TabOrder = 0
    object lblLoginAtual: TLabel
      Left = 10
      Top = 27
      Width = 32
      Height = 13
      Caption = 'Login: '
    end
    object lblSenhaAtual: TLabel
      Left = 10
      Top = 57
      Width = 37
      Height = 13
      Caption = 'Senha: '
    end
    object plsEdLoginAtual: TPlsEdit
      Left = 50
      Top = 21
      Width = 150
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 0
      plsCorRecebeFoco = clSilver
    end
    object btBtnConfirmarLoginSenhaAtual: TBitBtn
      Left = 204
      Top = 21
      Width = 55
      Height = 51
      Caption = 'OK'
      Default = True
      TabOrder = 2
      OnClick = btBtnConfirmarLoginSenhaAtualClick
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
    object plsMedSenhaAtual: TPlsMaskEdit
      Left = 50
      Top = 51
      Width = 150
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 1
      plsCorRecebeFoco = clSilver
    end
  end
  object grpBxLoginSenhaNovos: TGroupBox
    Left = 8
    Top = 103
    Width = 273
    Height = 158
    Caption = 'Login e Senha Atuais '
    TabOrder = 1
    Visible = False
    object lblLoginNovo: TLabel
      Left = 10
      Top = 27
      Width = 32
      Height = 13
      Caption = 'Login: '
    end
    object lblSenhaNovo: TLabel
      Left = 10
      Top = 57
      Width = 37
      Height = 13
      Caption = 'Senha: '
    end
    object Label1: TLabel
      Left = 10
      Top = 87
      Width = 47
      Height = 13
      Caption = 'Confirmar:'
    end
    object plsEdLoginNovo: TPlsEdit
      Left = 60
      Top = 21
      Width = 190
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      TabOrder = 0
      plsCorRecebeFoco = clSilver
    end
    object plsMedSenhaNovo: TPlsMaskEdit
      Left = 60
      Top = 51
      Width = 190
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 1
      plsCorRecebeFoco = clSilver
    end
    object plsMedSenhaConfirmacaoNovo: TPlsMaskEdit
      Left = 60
      Top = 81
      Width = 190
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 2
      plsCorRecebeFoco = clSilver
    end
    object btBtnSalvarLoginSenhaNovos: TBitBtn
      Left = 9
      Top = 112
      Width = 241
      Height = 34
      Caption = 'SALVAR'
      Default = True
      TabOrder = 3
      OnClick = btBtnSalvarLoginSenhaNovosClick
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
  end
end
