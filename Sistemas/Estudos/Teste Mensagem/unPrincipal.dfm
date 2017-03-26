object frmPrincipal: TfrmPrincipal
  Left = 7
  Top = 123
  Width = 1259
  Height = 540
  Caption = 'frmPrincipal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lstBxMsgTodas: TListBox
    Left = 628
    Top = 17
    Width = 610
    Height = 441
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 504
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 160
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 304
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object Button2: TButton
    Left = 248
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 4
    OnClick = Button2Click
  end
  object lstBxMsgSelecao: TListBox
    Left = 88
    Top = 176
    Width = 345
    Height = 329
    ItemHeight = 13
    TabOrder = 5
  end
end
