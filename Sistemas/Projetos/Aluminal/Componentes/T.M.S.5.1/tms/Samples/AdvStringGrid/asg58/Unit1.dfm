object Form1: TForm1
  Left = 427
  Top = 186
  Caption = 'TAdvGridWorkbook demo 58'
  ClientHeight = 467
  ClientWidth = 801
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
    Top = 41
    Width = 801
    Height = 426
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
    ExplicitLeft = 8
    ExplicitTop = 56
    ExplicitHeight = 383
    object WorkBookGrid3: TAdvStringGrid
      Left = 0
      Top = 0
      Width = 797
      Height = 401
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
      FilterDropDown.Font.Charset = DEFAULT_CHARSET
      FilterDropDown.Font.Color = clWindowText
      FilterDropDown.Font.Height = -11
      FilterDropDown.Font.Name = 'Tahoma'
      FilterDropDown.Font.Style = []
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
      SortSettings.Show = True
      ExplicitHeight = 358
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 801
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 3
    ExplicitTop = 32
    ExplicitWidth = 797
    object Button1: TButton
      Left = 8
      Top = 9
      Width = 129
      Height = 25
      Caption = 'Load files'
      TabOrder = 0
      OnClick = Loadfiles2Click
    end
    object Button2: TButton
      Left = 143
      Top = 9
      Width = 130
      Height = 25
      Caption = 'Sort grid'
      TabOrder = 1
      OnClick = Sortgrid1Click
    end
  end
end
