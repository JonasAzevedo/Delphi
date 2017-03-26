object fmNewImage: TfmNewImage
  Left = 603
  Top = 203
  HelpContext = 1001
  BorderStyle = bsDialog
  Caption = 'New Image'
  ClientHeight = 127
  ClientWidth = 246
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 65
    Height = 16
    AutoSize = False
    Caption = 'Width'
  end
  object Label2: TLabel
    Left = 8
    Top = 33
    Width = 65
    Height = 16
    AutoSize = False
    Caption = 'Height'
  end
  object Label3: TLabel
    Left = 8
    Top = 55
    Width = 65
    Height = 16
    AutoSize = False
    Caption = 'Colours'
  end
  object edWidth: TEdit
    Left = 74
    Top = 7
    Width = 45
    Height = 24
    TabOrder = 0
    Text = '32'
  end
  object edHeight: TEdit
    Left = 74
    Top = 29
    Width = 45
    Height = 24
    TabOrder = 1
    Text = '32'
  end
  object cbColors: TComboBox
    Left = 74
    Top = 52
    Width = 81
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 2
    Items.Strings = (
      '2'
      '16'
      '256')
  end
  object btnOK: TButton
    Left = 8
    Top = 88
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 88
    Top = 88
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object btnHelp: TButton
    Left = 168
    Top = 88
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 5
    OnClick = btnHelpClick
  end
end
