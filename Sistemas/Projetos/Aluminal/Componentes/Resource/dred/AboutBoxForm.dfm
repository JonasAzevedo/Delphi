object fmNTAboutBox: TfmNTAboutBox
  Left = 475
  Top = 365
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 256
  ClientWidth = 404
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object icoProduct: TImage
    Left = 8
    Top = 8
    Width = 65
    Height = 65
    Stretch = True
  end
  object stProduct: TLabel
    Left = 80
    Top = 16
    Width = 281
    Height = 16
    AutoSize = False
    Caption = 'stProduct'
    ShowAccelChar = False
  end
  object stVersion: TLabel
    Left = 80
    Top = 32
    Width = 281
    Height = 16
    AutoSize = False
    Caption = 'stVersion'
    ShowAccelChar = False
  end
  object stCopyright: TLabel
    Left = 80
    Top = 48
    Width = 305
    Height = 16
    Caption = 'Copyright © Colin Wilson 2000.  All Rights Reserved'
    ShowAccelChar = False
  end
  object Label1: TLabel
    Left = 80
    Top = 96
    Width = 281
    Height = 16
    AutoSize = False
    Caption = 'This product is licensed to:'
  end
  object stLicense1: TLabel
    Left = 80
    Top = 112
    Width = 281
    Height = 16
    AutoSize = False
    Caption = 'stLicense1'
    ShowAccelChar = False
  end
  object stLicense2: TLabel
    Left = 80
    Top = 128
    Width = 64
    Height = 16
    Caption = 'stLicense2'
    ShowAccelChar = False
  end
  object Bevel1: TBevel
    Left = 80
    Top = 152
    Width = 308
    Height = 2
    Shape = bsBottomLine
  end
  object stMemAvail: TLabel
    Left = 80
    Top = 160
    Width = 308
    Height = 16
    AutoSize = False
    Caption = 'Physical Memory Available to Windows:'
  end
  object OKBtn: TButton
    Left = 310
    Top = 220
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
end
