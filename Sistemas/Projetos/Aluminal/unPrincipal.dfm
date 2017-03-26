object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Width = 1280
  Height = 770
  Caption = 'Aluminal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  Menu = mmMenu
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object tlBtnPrincipal: TToolBar
    Left = 0
    Top = 0
    Width = 1272
    Height = 41
    ButtonHeight = 36
    ButtonWidth = 40
    Caption = 'tlBtnPrincipal'
    Images = imgPrincipal
    ShowCaptions = True
    TabOrder = 1
    object tlBtnFechar: TToolButton
      Left = 0
      Top = 2
      Caption = 'Fechar'
      ImageIndex = 0
      OnClick = tlBtnFecharClick
    end
    object tlBtnPedido: TToolButton
      Left = 40
      Top = 2
      Caption = 'Pedido'
      ImageIndex = 1
      OnClick = mmPedidoClick
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 697
    Width = 1272
    Height = 19
    Panels = <
      item
        Width = 1000
      end
      item
        Width = 500
      end
      item
        Alignment = taCenter
        Width = 50
      end>
  end
  object pnlHistorico: TAdvPanel
    Left = 926
    Top = 41
    Width = 346
    Height = 656
    Align = alRight
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clSkyBlue
    TabOrder = 2
    UseDockManager = True
    Version = '1.9.0.3'
    BorderColor = clSkyBlue
    BorderShadow = True
    Caption.Color = clHighlight
    Caption.ColorTo = clBlue
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.Indent = 2
    CollapsColor = clBtnFace
    CollapsDelay = 0
    ColorTo = 14938354
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = clSilver
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clBlack
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 14938354
    StatusBar.ColorTo = clWhite
    Styler = pnlStyler
    FullHeight = 0
    object lblTotalParcelaPedido: TLabel
      Left = 110
      Top = 296
      Width = 103
      Height = 13
      Cursor = crHandPoint
      Caption = 'lblTotalParcelaPedido'
      Transparent = True
      OnClick = lblTotalParcelaPedidoClick
    end
    object lblInfParcelaPedido: TLabel
      Left = 0
      Top = 296
      Width = 105
      Height = 13
      Caption = 'Parcelas (Pedido):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object calendario: TPlannerCalendar
      Left = 0
      Top = 39
      Width = 342
      Height = 180
      EventDayColor = clBlack
      EventMarkerColor = clYellow
      EventMarkerShape = evsCircle
      Align = alTop
      BackgroundPosition = bpTiled
      BevelOuter = bvNone
      BorderWidth = 1
      Look = lookFlat
      DateDownColor = clNone
      DateHoverColor = clNone
      DayFont.Charset = DEFAULT_CHARSET
      DayFont.Color = clWindowText
      DayFont.Height = -11
      DayFont.Name = 'MS Sans Serif'
      DayFont.Style = []
      WeekFont.Charset = DEFAULT_CHARSET
      WeekFont.Color = clWindowText
      WeekFont.Height = -11
      WeekFont.Name = 'MS Sans Serif'
      WeekFont.Style = []
      WeekName = 'Wk'
      TextColor = clBlack
      SelectColor = clTeal
      SelectFontColor = clWhite
      InActiveColor = clGray
      HeaderColor = clNone
      FocusColor = clHighlight
      InversColor = clTeal
      WeekendColor = clRed
      NameOfDays.Monday = 'seg'
      NameOfDays.Tuesday = 'ter'
      NameOfDays.Wednesday = 'qua'
      NameOfDays.Thursday = 'qui'
      NameOfDays.Friday = 'sex'
      NameOfDays.Saturday = 's'#225'b'
      NameOfDays.Sunday = 'dom'
      NameOfMonths.January = 'jan'
      NameOfMonths.February = 'fev'
      NameOfMonths.March = 'mar'
      NameOfMonths.April = 'abr'
      NameOfMonths.May = 'mai'
      NameOfMonths.June = 'jun'
      NameOfMonths.July = 'jul'
      NameOfMonths.August = 'ago'
      NameOfMonths.September = 'set'
      NameOfMonths.October = 'out'
      NameOfMonths.November = 'nov'
      NameOfMonths.December = 'dez'
      NameOfMonths.UseIntlNames = True
      StartDay = 7
      TodayFormat = '"Today" DDD/mm, YYYY'
      Day = 22
      Month = 7
      Year = 2012
      TabOrder = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      CaptionColor = clNone
      CaptionTextColor = clBlack
      LineColor = clGray
      Line3D = True
      GradientStartColor = clWhite
      GradientEndColor = clBtnFace
      GradientDirection = gdVertical
      MonthGradientStartColor = clNone
      MonthGradientEndColor = clNone
      MonthGradientDirection = gdHorizontal
      HintPrevYear = 'Previous Year'
      HintPrevMonth = 'Previous Month'
      HintNextMonth = 'Next Month'
      HintNextYear = 'Next Year'
      Version = '1.8.0.1'
    end
    object btnListarHistorico: TAdvGlowButton
      Left = 0
      Top = 219
      Width = 342
      Height = 38
      Align = alTop
      Caption = 'Listar Hist'#243'rico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnListarHistoricoClick
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
    object pnlPesquisa: TPanel
      Left = 0
      Top = 0
      Width = 342
      Height = 39
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblIntervaloPesquisa: TLabel
        Left = 152
        Top = 16
        Width = 6
        Height = 13
        Caption = #224
      end
      object lblPesquisar: TLabel
        Left = 6
        Top = 16
        Width = 60
        Height = 13
        Caption = 'Pesquisar:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edDataInicioPesquisa: TPlsMaskEdit
        Left = 72
        Top = 10
        Width = 73
        Height = 21
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        plsCorRecebeFoco = clSilver
      end
      object edDataFinalPesquisa: TPlsMaskEdit
        Left = 168
        Top = 10
        Width = 73
        Height = 21
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 2
        Text = '  /  /    '
        plsCorRecebeFoco = clSilver
      end
      object btnPesquisar: TAdvGlowButton
        Left = 251
        Top = 3
        Width = 89
        Height = 30
        Caption = 'Pesquisar'
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        TabOrder = 0
        OnClick = btnPesquisarClick
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
  object mmMenu: TAdvMainMenu
    Version = '2.5.3.0'
    Left = 56
    Top = 96
    object mmCadastro: TMenuItem
      Caption = 'Cadastro'
      object mmPedido: TMenuItem
        Caption = 'Pedido...'
        ShortCut = 112
        OnClick = mmPedidoClick
      end
      object mmDescricaoProdutos: TMenuItem
        Caption = 'Descri'#231#227'o dos Produtos...'
        ShortCut = 114
        OnClick = mmDescricaoProdutosClick
      end
    end
    object mmSobre: TMenuItem
      Caption = 'Sobre'
      object mmSobre2: TMenuItem
        Caption = 'Sobre...'
        OnClick = mmSobre2Click
      end
    end
  end
  object imgPrincipal: TImageList
    Left = 60
    Top = 56
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000030000001C0000001300000005000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000959595DFB8B8B8FFC8C8C2FFA7A7CCFFC6C6D6FFEAEAE1FFF3F3F3FF0606
      062D000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CACA
      CAFF2F2FBBFF0D0DBEFF1212C4FF1818CBFF1F1FD3FF2727DCFF2828E5FFFFFF
      F6FFDEDEDEF60000000100000000000000000000000000000000000000000000
      0000FFFFFF008080800080808000808080008080800080808000808080008080
      800080808000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D3D3D3FF0000
      B5FF0909BAFF0D0DBFFF1313C5FF1919CCFF2121D4FF2929DEFF3333E9FF3E3E
      F5FFC9C9FCFFDBDBDBF600000000000000000000000000000000FFFF0000FFFF
      0000FFFFFF008080800080808000808080008080800080808000808080008080
      800080808000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E7E7E7FF0000B1FF0505
      B6FF0E0EBAFFF5F5E8FF1313C4FF1818CBFF1F1FD3FF3636DEFFFFFFFCFF3939
      EFFF3B3BF2FFFFFFF5FF0505052D000000000000000000000000808000008080
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000004E1E1E0FF0303B3FF0303
      B4FFD1D1D1FFC1C1C1FFF5F5EAFF1717C9FF2626D1FFF2F2F2FFFBFBFBFFFFFF
      FBFF3131E6FF2525E2FFF2F2F2FF0000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00808080008080800080808000808080008080800080808000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C5C5C5EF0000AEFF0202B2FF0404
      B5FFF3F3E9FFC4C4C4FFC3C3C3FFF1F1ECFFDFDFDFFFEBEBEBFFF1F1F1FF2F2F
      DCFF2727DBFF2525D9FFE9E9E0FF000000050000000000000000000000000000
      0000FFFFFF00808080008080800080808000808080008080800080808000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9F9F9FF4343C6FF0000B1FF0303
      B4FF0606B6FFF2F2E8FFBCBCBCFFCACACAFFD6D6D6FFDFDFDFFF2525D1FF1E1E
      D1FF1E1ED2FF1D1DD0FFC5C5D6FF000000130000000000000000FFFFFF008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFCFF4949C7FF4242C5FF2626
      BEFF0404B5FF1212BAFFC4C4C4FFBEBEBEFFC9C9C9FFF0F0ECFF1616C8FF1717
      CAFF1717CAFF1616C9FFA6A6CBFF0101011C0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F9F9F9FF3838C2FF4545C6FF3F3F
      C4FF4848C7FFDEDEDEFFD0D0D0FFC5C5C5FFBCBCBCFFC0C0C0FFF4F4E9FF1111
      C3FF1111C3FF1111C3FFC8C8C1FF000000030000000000000000000000008080
      80008080800080808000808080008080800080808000FFFFFF00FFFFFF000000
      0000808000008080000080800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006060607A5C5CCAFF4848C6FF4040
      C4FFF7F7F7FFEDEDEDFFE4E4E4FF3E3EC7FFF3F3EAFFCACACAFFC5C5C5FFF6F6
      E9FF1111BFFF1C1CC1FFB8B8B8FF000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00000000000000
      0000000000008080000080800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFBFF4E4EC8FF4747
      C6FFF8F8EFFFF8F8F8FF4747C7FF3939C4FF3737C4FFF6F6EEFFDCDCDCFF3636
      C6FF3333C5FF3232BBFF979797E3000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000080800000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080809DCECEEDFF4C4C
      C8FF4747C6FF4040C4FF3F3FC4FF3D3DC4FF3939C4FF3939C4FF3333C3FF3737
      C4FF3030C3FFCACACBFF00000001000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EDEDEDFFCDCD
      EDFF4E4EC8FF4848C6FF4545C6FF4242C5FF3F3FC4FF3E3EC4FF3D3DC4FF2323
      BFFFD4D4D4FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      809BFEFEFCFF6565CDFF4141C4FF4949C7FF4646C6FF2929BEFFDFDFE0FFE7E7
      E7FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000062626277FAFAFAFFFDFDFDFFF9F9F9FFC6C6C6ED000000020000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FC3FF01300000000F00FF00300000000
      E003C00300000000C00380030000000080018003000000000001000300000000
      000000010000000000008000000000000000F000000000000000E00000000000
      0001FF10000000008001FF08000000008001E01C00000000C007F00F00000000
      E00FF80700000000F81FFC030000000000000000000000000000000000000000
      000000000000}
  end
  object ApplicationEvents: TApplicationEvents
    Left = 32
    Top = 56
  end
  object zQryHistoricoParcelaPedido: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT p.*'
      'FROM pagamento_pedido p'
      'WHERE 1=2')
    Params = <>
    Left = 1612
    Top = 184
    object zQryHistoricoParcelaPedidoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryHistoricoParcelaPedidoDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryHistoricoParcelaPedidoCOD_PEDIDO: TIntegerField
      FieldName = 'COD_PEDIDO'
      Required = True
    end
    object zQryHistoricoParcelaPedidoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      Required = True
    end
    object zQryHistoricoParcelaPedidoVALOR_PARCELA: TFloatField
      FieldName = 'VALOR_PARCELA'
      Required = True
    end
    object zQryHistoricoParcelaPedidoDATA_VCTO: TDateField
      FieldName = 'DATA_VCTO'
    end
    object zQryHistoricoParcelaPedidoDATA_PGTO: TDateField
      FieldName = 'DATA_PGTO'
    end
    object zQryHistoricoParcelaPedidoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 500
    end
  end
  object dspHistoricoParcelaPedido: TDataSetProvider
    DataSet = zQryHistoricoParcelaPedido
    Left = 1616
    Top = 232
  end
  object cdsHistoricoParcelaPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspHistoricoParcelaPedido'
    Left = 1616
    Top = 280
    object cdsHistoricoParcelaPedidoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsHistoricoParcelaPedidoDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsHistoricoParcelaPedidoCOD_PEDIDO: TIntegerField
      FieldName = 'COD_PEDIDO'
      Required = True
    end
    object cdsHistoricoParcelaPedidoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      Required = True
    end
    object cdsHistoricoParcelaPedidoVALOR_PARCELA: TFloatField
      FieldName = 'VALOR_PARCELA'
      Required = True
    end
    object cdsHistoricoParcelaPedidoDATA_VCTO: TDateField
      FieldName = 'DATA_VCTO'
    end
    object cdsHistoricoParcelaPedidoDATA_PGTO: TDateField
      FieldName = 'DATA_PGTO'
    end
    object cdsHistoricoParcelaPedidoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 500
    end
  end
  object pnlStyler: TAdvPanelStyler
    Tag = 0
    Settings.AnchorHint = False
    Settings.BevelInner = bvNone
    Settings.BevelOuter = bvNone
    Settings.BevelWidth = 1
    Settings.BorderColor = clSkyBlue
    Settings.BorderShadow = True
    Settings.BorderStyle = bsSingle
    Settings.BorderWidth = 0
    Settings.CanMove = False
    Settings.CanSize = False
    Settings.Caption.Color = clHighlight
    Settings.Caption.ColorTo = clBlue
    Settings.Caption.Font.Charset = DEFAULT_CHARSET
    Settings.Caption.Font.Color = clHighlightText
    Settings.Caption.Font.Height = -11
    Settings.Caption.Font.Name = 'MS Sans Serif'
    Settings.Caption.Font.Style = []
    Settings.Caption.Indent = 2
    Settings.Collaps = False
    Settings.CollapsColor = clBtnFace
    Settings.CollapsDelay = 0
    Settings.CollapsSteps = 0
    Settings.Color = clSkyBlue
    Settings.ColorTo = 14938354
    Settings.ColorMirror = clNone
    Settings.ColorMirrorTo = clNone
    Settings.Cursor = crDefault
    Settings.Font.Charset = DEFAULT_CHARSET
    Settings.Font.Color = clWindowText
    Settings.Font.Height = -11
    Settings.Font.Name = 'MS Sans Serif'
    Settings.Font.Style = []
    Settings.FixedTop = False
    Settings.FixedLeft = False
    Settings.FixedHeight = False
    Settings.FixedWidth = False
    Settings.Height = 120
    Settings.Hover = False
    Settings.HoverColor = clNone
    Settings.HoverFontColor = clNone
    Settings.Indent = 0
    Settings.ShadowColor = clBlack
    Settings.ShadowOffset = 0
    Settings.ShowHint = False
    Settings.ShowMoveCursor = False
    Settings.StatusBar.BorderColor = clSilver
    Settings.StatusBar.BorderStyle = bsSingle
    Settings.StatusBar.Font.Charset = DEFAULT_CHARSET
    Settings.StatusBar.Font.Color = clBlack
    Settings.StatusBar.Font.Height = -11
    Settings.StatusBar.Font.Name = 'Tahoma'
    Settings.StatusBar.Font.Style = []
    Settings.StatusBar.Color = 14938354
    Settings.StatusBar.ColorTo = clWhite
    Settings.TextVAlign = tvaTop
    Settings.TopIndent = 0
    Settings.URLColor = clBlue
    Settings.Width = 0
    Left = 56
    Top = 128
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 1288
    Top = 328
  end
end
