object Form2: TForm2
  Left = 333
  Top = 150
  Width = 325
  Height = 215
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 8
    Top = 48
    Width = 161
    Height = 121
    Caption = 'Panel1'
    TabOrder = 1
    object SpeedButton1: TSpeedButton
      Left = 24
      Top = 40
      Width = 57
      Height = 33
      Caption = '1111'
    end
    object Edit1: TEdit
      Left = 16
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
    object CheckBox1: TCheckBox
      Left = 32
      Top = 80
      Width = 97
      Height = 17
      Caption = 'CheckBox1'
      TabOrder = 1
    end
  end
  object ListBox1: TListBox
    Left = 184
    Top = 16
    Width = 105
    Height = 153
    ItemHeight = 13
    TabOrder = 2
  end
end
