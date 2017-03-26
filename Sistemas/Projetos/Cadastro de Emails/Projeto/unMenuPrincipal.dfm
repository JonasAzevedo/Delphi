object frmPrincipal: TfrmPrincipal
  Left = 226
  Top = 209
  BorderStyle = bsSingle
  Caption = 'CADASTRO DE EMAIL'#39'S'
  ClientHeight = 123
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblVersao: TLabel
    Left = 548
    Top = 88
    Width = 51
    Height = 13
    Caption = 'Vers'#227'o 1.0'
  end
  object btBtnPesquisaEmails: TBitBtn
    Left = 167
    Top = 24
    Width = 130
    Height = 42
    Caption = 'Pesquisa Email'#39's'
    TabOrder = 1
    OnClick = btBtnPesquisaEmailsClick
  end
  object btBtnCadastrarEmails: TBitBtn
    Left = 15
    Top = 24
    Width = 130
    Height = 42
    Caption = 'Cadastrar Email'#39's'
    TabOrder = 0
    OnClick = btBtnCadastrarEmailsClick
  end
  object btBtnEnviarEmail: TBitBtn
    Left = 319
    Top = 24
    Width = 130
    Height = 42
    Caption = 'Enviar Email'
    TabOrder = 2
    OnClick = btBtnEnviarEmailClick
  end
  object btBtnAreasInteresse: TBitBtn
    Left = 472
    Top = 24
    Width = 130
    Height = 42
    Caption = #193'reas de Interesse'
    TabOrder = 3
    OnClick = btBtnAreasInteresseClick
  end
  object btBtnAjustarEmails: TBitBtn
    Left = 608
    Top = 24
    Width = 130
    Height = 42
    Caption = 'Ajustar Email'#39's'
    TabOrder = 4
    OnClick = btBtnAjustarEmailsClick
  end
  object btBtnConfiguracoes: TBitBtn
    Left = 608
    Top = 72
    Width = 130
    Height = 42
    Caption = 'Configura'#231#245'es'
    TabOrder = 5
    OnClick = btBtnConfiguracoesClick
  end
end
