object Form1: TForm1
  Left = 192
  Top = 149
  Width = 447
  Height = 148
  Caption = 'TMS software TAdvCombo demo application'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object AdvComboBox1: TAdvComboBox
    Left = 16
    Top = 16
    Width = 145
    Height = 21
    Color = clWindow
    AutoFocus = False
    ButtonWidth = 19
    Flat = True
    FlatLineColor = clBlack
    FlatParentColor = True
    Etched = False
    FocusBorder = False
    DropWidth = 0
    Enabled = True
    ItemHeight = 13
    Items.Strings = (
      'Audi'
      'BMW'
      'Bugatti'
      'Ferrari'
      'Lamborghini'
      'Mercedes')
    LabelPosition = lpLeftTop
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = False
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Sorted = True
    TabOrder = 0
  end
  object AdvComboBox2: TAdvComboBox
    Left = 240
    Top = 16
    Width = 145
    Height = 21
    Color = clBtnFace
    AutoFocus = False
    ButtonWidth = 19
    Flat = True
    FlatLineColor = clBlack
    FlatParentColor = True
    Etched = False
    FocusBorder = False
    Ctl3D = False
    DropWidth = 0
    Enabled = True
    ItemHeight = 13
    Items.Strings = (
      'BMW'
      'Mercedes'
      'Ferrari'
      'Porsche'
      'Audi'
      'Bugatti')
    LabelCaption = 'Label :'
    LabelPosition = lpLeftCenter
    LabelMargin = 4
    LabelTransparent = False
    LabelAlwaysEnabled = False
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    ParentCtl3D = False
    TabOrder = 1
  end
end
