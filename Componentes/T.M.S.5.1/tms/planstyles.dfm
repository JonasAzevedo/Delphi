object PlanStyleForm: TPlanStyleForm
  Left = 133
  Top = 267
  BorderStyle = bsDialog
  Caption = 'Planner styles'
  ClientHeight = 280
  ClientWidth = 192
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
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 4
    Width = 161
    Height = 237
    ItemIndex = 0
    Items.Strings = (
      'Windows XP'
      'Office 2002'
      'Office 2003 (Blue)'
      'Office 2003 (Olive)'
      'Office 2003 (Silver)'
      'Office 2003 (Classic)'
      'Flat style'
      'Avantgarde'
      'Whidbey'
      'Office 2007 (Blue)'
      'Office 2007 (Black)'
      'Office 2007 (Silver)')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 16
    Top = 247
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 100
    Top = 247
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
