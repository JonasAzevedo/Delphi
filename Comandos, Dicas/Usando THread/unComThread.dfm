object Form1: TForm1
  Left = 207
  Top = 56
  Width = 870
  Height = 500
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 32
    Width = 57
    Height = 13
    Caption = 'Andamento:'
  end
  object Button1: TButton
    Left = 48
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Iniciar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 48
    Top = 56
    Width = 150
    Height = 17
    TabOrder = 1
  end
end
