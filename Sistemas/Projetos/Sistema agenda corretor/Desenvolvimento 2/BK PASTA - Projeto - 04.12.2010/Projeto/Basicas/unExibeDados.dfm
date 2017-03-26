object frmExibeDados: TfrmExibeDados
  Left = 259
  Top = 91
  BorderStyle = bsDialog
  Caption = 'EXIBIR DADOS'
  ClientHeight = 466
  ClientWidth = 676
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 0
    Top = 425
    Width = 676
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btBtnFechar: TBitBtn
      Left = 2
      Top = 2
      Width = 101
      Height = 38
      Caption = '&Fechar'
      TabOrder = 0
      OnClick = btBtnFecharClick
      Kind = bkClose
    end
  end
  object pnlDados: TPanel
    Left = 0
    Top = 0
    Width = 676
    Height = 425
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
  end
end
