object Form1: TForm1
  Left = 429
  Top = 145
  Width = 533
  Height = 521
  Caption = 'TMS software extended FileControls'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 295
    Top = 16
    Width = 93
    Height = 13
    Caption = 'TFileListboxEx : '
  end
  object Label2: TLabel
    Left = 16
    Top = 17
    Width = 128
    Height = 13
    Caption = 'TDirectoryListBoxEx : '
  end
  object Label3: TLabel
    Left = 297
    Top = 248
    Width = 129
    Height = 13
    Caption = 'TCheckFileListboxEx : '
  end
  object Label4: TLabel
    Left = 17
    Top = 247
    Width = 164
    Height = 13
    Caption = 'TCheckDirectoryListBoxEx : '
  end
  object FileListBoxEx1: TFileListBoxEx
    Left = 296
    Top = 35
    Width = 209
    Height = 193
    ItemHeight = 13
    TabOrder = 0
  end
  object DirectoryListBoxEx1: TDirectoryListBoxEx
    Left = 16
    Top = 35
    Width = 249
    Height = 193
    FileList = FileListBoxEx1
    ItemHeight = 16
    TabOrder = 1
    DirectOpen = False
  end
  object CheckFileListBoxEx1: TCheckFileListBoxEx
    Left = 296
    Top = 267
    Width = 209
    Height = 193
    ItemHeight = 13
    TabOrder = 2
    Flat = True
  end
  object CheckDirectoryListBoxEx1: TCheckDirectoryListBoxEx
    Left = 16
    Top = 267
    Width = 249
    Height = 193
    FileList = CheckFileListBoxEx1
    ItemHeight = 16
    TabOrder = 3
    DirectOpen = False
    Flat = True
  end
end
