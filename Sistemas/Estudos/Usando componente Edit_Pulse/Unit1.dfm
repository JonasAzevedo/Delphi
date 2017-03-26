object Form1: TForm1
  Left = 192
  Top = 110
  Width = 249
  Height = 170
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
  object Button1: TButton
    Left = 76
    Top = 82
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit_Pulse1: TEdit_Pulse
    Left = 60
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit_Pulse1'
    PLScor = clInfoBk
    onValida = Edit_Pulse1Valida
  end
end
