object frmPrincipal: TfrmPrincipal
  Left = 65
  Top = 92
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TIME MONEY'
  ClientHeight = 640
  ClientWidth = 1139
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgCtrl: TPageControl
    Left = 0
    Top = 0
    Width = 1139
    Height = 621
    ActivePage = tbShtLotoFacil
    Align = alClient
    TabOrder = 0
    object tbShtLotoFacil: TTabSheet
      Caption = 'Loto F'#225'cil'
      object grpBxEstatisticas: TGroupBox
        Left = 0
        Top = 49
        Width = 1131
        Height = 544
        Align = alClient
        Caption = 'Estatisticas'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 215
          Height = 16
          Caption = 'N'#218'MEROS MAIS SORTEADOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 40
          Top = 45
          Width = 37
          Height = 13
          Caption = 'Ordem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 88
          Top = 45
          Width = 97
          Height = 13
          Caption = 'N'#186' / Ocorr'#234'ncias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 50
          Top = 458
          Width = 119
          Height = 13
          Caption = 'Sugest'#227'o de Aposta:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 246
          Top = 24
          Width = 182
          Height = 16
          Caption = 'CONCURSO FINAL 5 OU 0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 261
          Top = 45
          Width = 37
          Height = 13
          Caption = 'Ordem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 309
          Top = 45
          Width = 97
          Height = 13
          Caption = 'N'#186' / Ocorr'#234'ncias'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 269
          Top = 458
          Width = 119
          Height = 13
          Caption = 'Sugest'#227'o de Aposta:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 456
          Top = 24
          Width = 281
          Height = 16
          Caption = 'OCORR'#202'NCIAS '#218'LTIMOS 10 SORTEIOS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 928
          Top = 24
          Width = 164
          Height = 16
          Caption = 'N'#195'O '#218'LTIMO SORTEIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 768
          Top = 24
          Width = 128
          Height = 16
          Caption = #218'LTIMO SORTEIO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblSelecaoSugestao9: TLabel
          Left = 828
          Top = 310
          Width = 100
          Height = 13
          Caption = 'lblSelecaoSugestao9'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblSelecaoSugestao6: TLabel
          Left = 1023
          Top = 310
          Width = 100
          Height = 13
          Caption = 'lblSelecaoSugestao6'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object bvlDivisao1: TBevel
          Left = 233
          Top = 24
          Width = 15
          Height = 465
          Shape = bsLeftLine
        end
        object bvlDivisao2: TBevel
          Left = 441
          Top = 24
          Width = 15
          Height = 465
          Shape = bsLeftLine
        end
        object Label12: TLabel
          Left = 768
          Top = 290
          Width = 110
          Height = 13
          Caption = 'Sugest'#227'o - Total 9:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 953
          Top = 290
          Width = 110
          Height = 13
          Caption = 'Sugest'#227'o - Total 6:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label14: TLabel
          Left = 768
          Top = 310
          Width = 39
          Height = 13
          Caption = 'Apostar:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 953
          Top = 310
          Width = 39
          Height = 13
          Caption = 'Apostar:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object advMmNrosMaisAparacem: TAdvMemo
          Left = 42
          Top = 60
          Width = 150
          Height = 385
          Cursor = crIBeam
          ActiveLineSettings.ShowActiveLine = False
          ActiveLineSettings.ShowActiveLineIndicator = False
          AutoCompletion.Font.Charset = DEFAULT_CHARSET
          AutoCompletion.Font.Color = clWindowText
          AutoCompletion.Font.Height = -11
          AutoCompletion.Font.Name = 'MS Sans Serif'
          AutoCompletion.Font.Style = []
          AutoCorrect.Active = True
          AutoHintParameterPosition = hpBelowCode
          BkColor = clBtnFace
          BorderStyle = bsSingle
          CodeFolding.Enabled = False
          CodeFolding.LineColor = clGray
          Ctl3D = False
          DelErase = True
          EnhancedHomeKey = False
          Gutter.DigitCount = 4
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -13
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Gutter.GutterWidth = 30
          Gutter.GutterColorTo = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          HiddenCaret = False
          Lines.Strings = (
            '')
          MarkerList.UseDefaultMarkerImageIndex = False
          MarkerList.DefaultMarkerImageIndex = -1
          MarkerList.ImageTransparentColor = 33554432
          PrintOptions.MarginLeft = 0
          PrintOptions.MarginRight = 0
          PrintOptions.MarginTop = 0
          PrintOptions.MarginBottom = 0
          PrintOptions.PageNr = False
          PrintOptions.PrintLineNumbers = False
          ReadOnly = True
          RightMarginColor = 14869218
          ScrollHint = False
          SelColor = clWhite
          SelBkColor = clNavy
          ShowRightMargin = True
          SmartTabs = False
          TabOrder = 0
          TabSize = 4
          TabStop = True
          TrimTrailingSpaces = False
          UndoLimit = 100
          UrlStyle.TextColor = clBlue
          UrlStyle.BkColor = clWhite
          UrlStyle.Style = [fsUnderline]
          UseStyler = True
          Version = '2.1.7.11'
          WordWrap = wwNone
        end
        object advMmNrosMaisAparacemSorteio5ou0: TAdvMemo
          Left = 261
          Top = 60
          Width = 150
          Height = 385
          Cursor = crIBeam
          ActiveLineSettings.ShowActiveLine = False
          ActiveLineSettings.ShowActiveLineIndicator = False
          AutoCompletion.Font.Charset = DEFAULT_CHARSET
          AutoCompletion.Font.Color = clWindowText
          AutoCompletion.Font.Height = -11
          AutoCompletion.Font.Name = 'MS Sans Serif'
          AutoCompletion.Font.Style = []
          AutoCorrect.Active = True
          AutoHintParameterPosition = hpBelowCode
          BkColor = clBtnFace
          BorderStyle = bsSingle
          CodeFolding.Enabled = False
          CodeFolding.LineColor = clGray
          Ctl3D = False
          DelErase = True
          EnhancedHomeKey = False
          Gutter.DigitCount = 4
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -13
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Gutter.GutterColorTo = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          HiddenCaret = False
          Lines.Strings = (
            '')
          MarkerList.UseDefaultMarkerImageIndex = False
          MarkerList.DefaultMarkerImageIndex = -1
          MarkerList.ImageTransparentColor = 33554432
          PrintOptions.MarginLeft = 0
          PrintOptions.MarginRight = 0
          PrintOptions.MarginTop = 0
          PrintOptions.MarginBottom = 0
          PrintOptions.PageNr = False
          PrintOptions.PrintLineNumbers = False
          RightMarginColor = 14869218
          ScrollHint = False
          SelColor = clWhite
          SelBkColor = clNavy
          ShowRightMargin = True
          SmartTabs = False
          TabOrder = 1
          TabSize = 4
          TabStop = True
          TrimTrailingSpaces = False
          UndoLimit = 100
          UrlStyle.TextColor = clBlue
          UrlStyle.BkColor = clWhite
          UrlStyle.Style = [fsUnderline]
          UseStyler = True
          Version = '2.1.7.11'
          WordWrap = wwNone
        end
        object mmSugestaoNrosMaisAparacem: TMemo
          Left = 42
          Top = 472
          Width = 153
          Height = 65
          BorderStyle = bsNone
          Color = clBtnFace
          TabOrder = 2
        end
        object mmSugestaoNrosMaisAparacemSorteio5ou0: TMemo
          Left = 261
          Top = 472
          Width = 153
          Height = 65
          BorderStyle = bsNone
          Color = clBtnFace
          TabOrder = 3
        end
        object advMmOcorrenciaUltimos10Sorteios: TAdvMemo
          Left = 496
          Top = 60
          Width = 149
          Height = 385
          Cursor = crIBeam
          ActiveLineSettings.ShowActiveLine = False
          ActiveLineSettings.ShowActiveLineIndicator = False
          AutoCompletion.Font.Charset = DEFAULT_CHARSET
          AutoCompletion.Font.Color = clWindowText
          AutoCompletion.Font.Height = -11
          AutoCompletion.Font.Name = 'MS Sans Serif'
          AutoCompletion.Font.Style = []
          AutoCorrect.Active = True
          AutoHintParameterPosition = hpBelowCode
          BkColor = clBtnFace
          BorderStyle = bsSingle
          CodeFolding.Enabled = False
          CodeFolding.LineColor = clGray
          Ctl3D = False
          DelErase = True
          EnhancedHomeKey = False
          Gutter.DigitCount = 4
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -13
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Gutter.GutterColorTo = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          HiddenCaret = False
          Lines.Strings = (
            '')
          MarkerList.UseDefaultMarkerImageIndex = False
          MarkerList.DefaultMarkerImageIndex = -1
          MarkerList.ImageTransparentColor = 33554432
          PrintOptions.MarginLeft = 0
          PrintOptions.MarginRight = 0
          PrintOptions.MarginTop = 0
          PrintOptions.MarginBottom = 0
          PrintOptions.PageNr = False
          PrintOptions.PrintLineNumbers = False
          RightMarginColor = 14869218
          ScrollHint = False
          SelColor = clWhite
          SelBkColor = clNavy
          ShowRightMargin = True
          SmartTabs = False
          TabOrder = 4
          TabSize = 4
          TabStop = True
          TrimTrailingSpaces = False
          UndoLimit = 100
          UrlStyle.TextColor = clBlue
          UrlStyle.BkColor = clWhite
          UrlStyle.Style = [fsUnderline]
          UseStyler = True
          Version = '2.1.7.11'
          WordWrap = wwNone
        end
        object advMmUltimoSorteio: TAdvMemo
          Left = 768
          Top = 50
          Width = 120
          Height = 230
          Cursor = crIBeam
          ActiveLineSettings.ShowActiveLine = False
          ActiveLineSettings.ShowActiveLineIndicator = False
          AutoCompletion.Font.Charset = DEFAULT_CHARSET
          AutoCompletion.Font.Color = clWindowText
          AutoCompletion.Font.Height = -11
          AutoCompletion.Font.Name = 'MS Sans Serif'
          AutoCompletion.Font.Style = []
          AutoCorrect.Active = True
          AutoHintParameterPosition = hpBelowCode
          BkColor = clBtnFace
          BorderStyle = bsSingle
          CodeFolding.Enabled = False
          CodeFolding.LineColor = clGray
          Ctl3D = False
          DelErase = True
          EnhancedHomeKey = False
          Gutter.DigitCount = 4
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -13
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Gutter.GutterColorTo = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          HiddenCaret = False
          Lines.Strings = (
            '')
          MarkerList.UseDefaultMarkerImageIndex = False
          MarkerList.DefaultMarkerImageIndex = -1
          MarkerList.ImageTransparentColor = 33554432
          PrintOptions.MarginLeft = 0
          PrintOptions.MarginRight = 0
          PrintOptions.MarginTop = 0
          PrintOptions.MarginBottom = 0
          PrintOptions.PageNr = False
          PrintOptions.PrintLineNumbers = False
          RightMarginColor = 14869218
          ScrollHint = False
          SelColor = clWhite
          SelBkColor = clNavy
          ShowRightMargin = True
          SmartTabs = False
          TabOrder = 5
          TabSize = 4
          TabStop = True
          TrimTrailingSpaces = False
          UndoLimit = 100
          UrlStyle.TextColor = clBlue
          UrlStyle.BkColor = clWhite
          UrlStyle.Style = [fsUnderline]
          UseStyler = True
          Version = '2.1.7.11'
          WordWrap = wwNone
        end
        object advMmNaoUltimoSorteio: TAdvMemo
          Left = 945
          Top = 50
          Width = 120
          Height = 230
          Cursor = crIBeam
          ActiveLineSettings.ShowActiveLine = False
          ActiveLineSettings.ShowActiveLineIndicator = False
          AutoCompletion.Font.Charset = DEFAULT_CHARSET
          AutoCompletion.Font.Color = clWindowText
          AutoCompletion.Font.Height = -11
          AutoCompletion.Font.Name = 'MS Sans Serif'
          AutoCompletion.Font.Style = []
          AutoCorrect.Active = True
          AutoHintParameterPosition = hpBelowCode
          BkColor = clBtnFace
          BorderStyle = bsSingle
          CodeFolding.Enabled = False
          CodeFolding.LineColor = clGray
          Ctl3D = False
          DelErase = True
          EnhancedHomeKey = False
          Gutter.DigitCount = 4
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -13
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Gutter.GutterColorTo = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          HiddenCaret = False
          Lines.Strings = (
            '')
          MarkerList.UseDefaultMarkerImageIndex = False
          MarkerList.DefaultMarkerImageIndex = -1
          MarkerList.ImageTransparentColor = 33554432
          PrintOptions.MarginLeft = 0
          PrintOptions.MarginRight = 0
          PrintOptions.MarginTop = 0
          PrintOptions.MarginBottom = 0
          PrintOptions.PageNr = False
          PrintOptions.PrintLineNumbers = False
          RightMarginColor = 14869218
          ScrollHint = False
          SelColor = clWhite
          SelBkColor = clNavy
          ShowRightMargin = True
          SmartTabs = False
          TabOrder = 6
          TabSize = 4
          TabStop = True
          TrimTrailingSpaces = False
          UndoLimit = 100
          UrlStyle.TextColor = clBlue
          UrlStyle.BkColor = clWhite
          UrlStyle.Style = [fsUnderline]
          UseStyler = True
          Version = '2.1.7.11'
          WordWrap = wwNone
        end
        object mmApostar9: TMemo
          Left = 768
          Top = 328
          Width = 50
          Height = 190
          BorderStyle = bsNone
          Color = clBtnFace
          TabOrder = 7
        end
        object mmApostar6: TMemo
          Left = 953
          Top = 328
          Width = 50
          Height = 190
          BorderStyle = bsNone
          Color = clBtnFace
          TabOrder = 8
        end
        object mmSelecaoIgualdade9: TMemo
          Left = 828
          Top = 328
          Width = 50
          Height = 190
          BorderStyle = bsNone
          Color = clBtnFace
          TabOrder = 9
        end
        object mmSelecaoIgualdade6: TMemo
          Left = 1023
          Top = 328
          Width = 50
          Height = 190
          BorderStyle = bsNone
          Color = clBtnFace
          TabOrder = 10
        end
      end
      object pnlOpcoes: TPanel
        Left = 0
        Top = 0
        Width = 1131
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label16: TLabel
          Left = 1095
          Top = 5
          Width = 34
          Height = 13
          Cursor = crHandPoint
          Hint = 'Sobre o Sistema'
          Caption = 'Sobre'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = Label16Click
        end
        object AdvGlwBtnSorteio: TAdvGlowButton
          Left = 8
          Top = 8
          Width = 97
          Height = 33
          Hint = 'Cadastrar Sorteio da Loto F'#225'cil'
          Caption = 'Sorteio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = AdvGlwBtnSorteioClick
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = 16367008
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 16111818
          Appearance.ColorDownTo = 16367008
          Appearance.ColorHot = 16117985
          Appearance.ColorHotTo = 16372402
          Appearance.ColorMirrorHot = 16107693
          Appearance.ColorMirrorHotTo = 16775412
          Appearance.ColorMirrorDown = 16102556
          Appearance.ColorMirrorDownTo = 16768988
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = 16768988
          Appearance.ColorMirrorDisabled = 11974326
          Appearance.ColorMirrorDisabledTo = 15921906
        end
        object advGlwBtnOcorrenciasRepeticoes: TAdvGlowButton
          Left = 120
          Top = 8
          Width = 97
          Height = 33
          Hint = 'Ocorr'#234'ncias Repeti'#231#245'es'
          Caption = 'Ocorr'#234'ncias - Repeti'#231#245'es'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = advGlwBtnOcorrenciasRepeticoesClick
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = 16367008
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 16111818
          Appearance.ColorDownTo = 16367008
          Appearance.ColorHot = 16117985
          Appearance.ColorHotTo = 16372402
          Appearance.ColorMirrorHot = 16107693
          Appearance.ColorMirrorHotTo = 16775412
          Appearance.ColorMirrorDown = 16102556
          Appearance.ColorMirrorDownTo = 16768988
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = 16768988
          Appearance.ColorMirrorDisabled = 11974326
          Appearance.ColorMirrorDisabledTo = 15921906
        end
        object advGlwBtnPesquisarNumerosSorteados: TAdvGlowButton
          Left = 232
          Top = 8
          Width = 97
          Height = 33
          Hint = 'Pesquisa por Ocorr'#234'ncia dos N'#250'meros Soorteados'
          Caption = 'Pequisar N'#186's Sorteio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = advGlwBtnPesquisarNumerosSorteadosClick
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = 16367008
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 16111818
          Appearance.ColorDownTo = 16367008
          Appearance.ColorHot = 16117985
          Appearance.ColorHotTo = 16372402
          Appearance.ColorMirrorHot = 16107693
          Appearance.ColorMirrorHotTo = 16775412
          Appearance.ColorMirrorDown = 16102556
          Appearance.ColorMirrorDownTo = 16768988
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = 16768988
          Appearance.ColorMirrorDisabled = 11974326
          Appearance.ColorMirrorDisabledTo = 15921906
        end
        object advGlwBtnOcorrenciasSorteios: TAdvGlowButton
          Left = 336
          Top = 8
          Width = 97
          Height = 33
          Hint = 'Ocorr'#234'ncias Sorteios'
          Caption = 'Ocorr'#234'ncias - Sorteios'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = advGlwBtnOcorrenciasSorteiosClick
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = 16367008
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 16111818
          Appearance.ColorDownTo = 16367008
          Appearance.ColorHot = 16117985
          Appearance.ColorHotTo = 16372402
          Appearance.ColorMirrorHot = 16107693
          Appearance.ColorMirrorHotTo = 16775412
          Appearance.ColorMirrorDown = 16102556
          Appearance.ColorMirrorDownTo = 16768988
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = 16768988
          Appearance.ColorMirrorDisabled = 11974326
          Appearance.ColorMirrorDisabledTo = 15921906
        end
        object btnImportarCSV: TButton
          Left = 560
          Top = 16
          Width = 75
          Height = 25
          Hint = 'Importar base de dados no formato .CSV'
          Caption = 'Importar CSV'
          TabOrder = 4
          OnClick = btnImportarCSVClick
        end
        object advGlwBtnApostar: TAdvGlowButton
          Left = 448
          Top = 8
          Width = 97
          Height = 33
          Hint = 'Apostar'
          Caption = 'Apostar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = advGlwBtnApostarClick
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = 16367008
          Appearance.ColorDisabled = 15921906
          Appearance.ColorDisabledTo = 15921906
          Appearance.ColorDown = 16111818
          Appearance.ColorDownTo = 16367008
          Appearance.ColorHot = 16117985
          Appearance.ColorHotTo = 16372402
          Appearance.ColorMirrorHot = 16107693
          Appearance.ColorMirrorHotTo = 16775412
          Appearance.ColorMirrorDown = 16102556
          Appearance.ColorMirrorDownTo = 16768988
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = 16768988
          Appearance.ColorMirrorDisabled = 11974326
          Appearance.ColorMirrorDisabledTo = 15921906
        end
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 621
    Width = 1139
    Height = 19
    Panels = <>
  end
  object PopupMenu: TPopupMenu
    Left = 11
    Top = 132
    object mnItReprocessarPagina: TMenuItem
      Caption = 'Reprocessar P'#225'gina'
      Hint = 'Reprocessar P'#225'gina'
      OnClick = mnItReprocessarPaginaClick
    end
  end
end
