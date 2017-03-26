object Form1: TForm1
  Left = 666
  Top = 184
  Caption = 'AdvGridWorkBook and AdvGridExcelIO demo 59'
  ClientHeight = 446
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object AdvGridWorkbook1: TAdvGridWorkbook
    Left = 0
    Top = 0
    Width = 688
    Height = 405
    ActiveSheet = 0
    Sheets = <
      item
        Name = 'Sheet 1'
        Tag = 0
      end
      item
        Name = 'Sheet 2'
        Tag = 0
      end
      item
        Name = 'Sheet 3'
        Tag = 0
      end>
    TabLook.Font.Charset = DEFAULT_CHARSET
    TabLook.Font.Color = clWindowText
    TabLook.Font.Height = -11
    TabLook.Font.Name = 'MS Sans Serif'
    TabLook.Font.Style = []
    Align = alClient
    TabOrder = 0
    Version = '3.3.0.1'
    object WorkBookGrid1: TAdvStringGrid
      Left = 0
      Top = 0
      Width = 684
      Height = 380
      Cursor = crDefault
      Align = alClient
      BorderStyle = bsNone
      DefaultRowHeight = 21
      RowCount = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing]
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'MS Sans Serif'
      ActiveCellFont.Style = [fsBold]
      CellNode.TreeColor = clSilver
      Filter = <>
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = [fsBold]
      FloatFormat = '%.2f'
      PrintSettings.DateFormat = 'dd/mm/yyyy'
      PrintSettings.Font.Charset = DEFAULT_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -11
      PrintSettings.Font.Name = 'MS Sans Serif'
      PrintSettings.Font.Style = []
      PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
      PrintSettings.FixedFont.Color = clWindowText
      PrintSettings.FixedFont.Height = -11
      PrintSettings.FixedFont.Name = 'MS Sans Serif'
      PrintSettings.FixedFont.Style = []
      PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -11
      PrintSettings.HeaderFont.Name = 'MS Sans Serif'
      PrintSettings.HeaderFont.Style = []
      PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -11
      PrintSettings.FooterFont.Name = 'MS Sans Serif'
      PrintSettings.FooterFont.Style = []
      PrintSettings.PageNumSep = '/'
      ScrollWidth = 16
      SearchFooter.FindNextCaption = 'Find &next'
      SearchFooter.FindPrevCaption = 'Find &previous'
      SearchFooter.Font.Charset = DEFAULT_CHARSET
      SearchFooter.Font.Color = clWindowText
      SearchFooter.Font.Height = -11
      SearchFooter.Font.Name = 'Tahoma'
      SearchFooter.Font.Style = []
      SearchFooter.HighLightCaption = 'Highlight'
      SearchFooter.HintClose = 'Close'
      SearchFooter.HintFindNext = 'Find next occurence'
      SearchFooter.HintFindPrev = 'Find previous occurence'
      SearchFooter.HintHighlight = 'Highlight occurences'
      SearchFooter.MatchCaseCaption = 'Match case'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 405
    Width = 688
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Import 1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 104
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Import ALL'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 192
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Export 1'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 280
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Export All'
      TabOrder = 3
      OnClick = Button4Click
    end
    object ProgressBar1: TProgressBar
      Left = 366
      Top = 11
      Width = 313
      Height = 16
      TabOrder = 4
    end
  end
  object xls: TAdvGridExcelIO
    AdvGridWorkbook = AdvGridWorkbook1
    Options.ImportCellSizes = False
    Options.ExportOverwriteMessage = 'File %s already exists'#13'Ok to overwrite ?'
    UseUnicode = False
    Version = '3.0.4'
    OnProgress = xlsProgress
    Left = 80
    Top = 128
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'xls'
    Filter = 'Excel files|*.xls'
    Left = 160
    Top = 128
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'Excel Files|*.xls'
    Left = 120
    Top = 128
  end
end
