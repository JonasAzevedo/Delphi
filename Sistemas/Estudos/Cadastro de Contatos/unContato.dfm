object Form2: TForm2
  Left = 145
  Top = 321
  Width = 783
  Height = 540
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblCodigo: TLabel
    Left = 24
    Top = 28
    Width = 39
    Height = 13
    Caption = 'C�digo :'
  end
  object lblNome: TLabel
    Left = 22
    Top = 66
    Width = 34
    Height = 13
    Caption = 'Nome :'
  end
  object lblDataNascimento: TLabel
    Left = 26
    Top = 100
    Width = 88
    Height = 13
    Caption = 'Data Nascimento :'
  end
  object lblProfissao: TLabel
    Left = 24
    Top = 134
    Width = 49
    Height = 13
    Caption = 'Profiss�o :'
  end
  object lblEmpresa: TLabel
    Left = 28
    Top = 170
    Width = 47
    Height = 13
    Caption = 'Empresa :'
  end
  object lblDescricao: TLabel
    Left = 26
    Top = 206
    Width = 54
    Height = 13
    Caption = 'Descri��o :'
  end
  object lblDataCadastro: TLabel
    Left = 176
    Top = 26
    Width = 89
    Height = 13
    Caption = 'Data do Cadastro :'
  end
  object plsEdCodigo: TPlsEdit
    Left = 76
    Top = 18
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'plsEdCodigo'
  end
  object plsEdNome: TPlsEdit
    Left = 76
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'plsEdNome'
  end
  object plsEdProfissao: TPlsEdit
    Left = 80
    Top = 124
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'plsEdProfissao'
  end
  object plsEdEmpresa: TPlsEdit
    Left = 86
    Top = 160
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'plsEdEmpresa'
  end
  object plsMmDescricao: TPlsMemo
    Left = 92
    Top = 202
    Width = 185
    Height = 89
    Lines.Strings = (
      'PlsMemo1')
    TabOrder = 4
  end
  object plsMedDataCadastro: TPlsMaskEdit
    Left = 284
    Top = 12
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'plsMedDataCadastro'
  end
  object plsMedDataNascimento: TPlsMaskEdit
    Left = 124
    Top = 92
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'plsMedDataNascimento'
  end
end
