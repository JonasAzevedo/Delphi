object Form1: TForm1
  Left = 442
  Top = 192
  Width = 544
  Height = 370
  Caption = 'OutlookGroup functions'
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
  object Button1: TButton
    Left = 448
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Add items'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 448
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Change item'
    TabOrder = 1
    OnClick = Button2Click
  end
  object AdvOutlookList1: TAdvOutlookList
    Left = 16
    Top = 8
    Width = 425
    Height = 300
    BorderStyle = bsSingle
    Columns = <
      item
        Caption = 'Group Column'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
      end
      item
        Caption = 'Size'
        Width = 60
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Alignment = taRightJustify
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        HeaderAlignment = taLeftJustify
        SortType = stNumeric
      end
      item
        Caption = 'Date'
        Width = 60
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        HeaderAlignment = taLeftJustify
        SortType = stDate
      end
      item
        Caption = 'Subject'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        HeaderAlignment = taLeftJustify
      end>
    Color = clWhite
    HeaderHeight = 25
    PreviewSettings.Font.Charset = DEFAULT_CHARSET
    PreviewSettings.Font.Color = clBlue
    PreviewSettings.Font.Height = -11
    PreviewSettings.Font.Name = 'MS Sans Serif'
    PreviewSettings.Font.Style = []
    ShowHint = True
    TabOrder = 2
    URLSettings.FontStyle = [fsUnderline]
    Version = '1.0.0.0'
  end
  object Button3: TButton
    Left = 448
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Insert item'
    TabOrder = 3
    OnClick = Button3Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 317
    Width = 536
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Button4: TButton
    Left = 448
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Remove item'
    TabOrder = 5
    OnClick = Button4Click
  end
end
