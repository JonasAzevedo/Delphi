object Form2: TForm2
  Left = 346
  Top = 229
  Width = 335
  Height = 247
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 40
    Top = 40
    Width = 225
    Height = 89
    Lines.Strings = (
      'This form was skinned automatically using '
      'skinfile in sd1.')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 104
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
end
