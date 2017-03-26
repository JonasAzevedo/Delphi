object Form1: TForm1
  Left = 468
  Top = 208
  Caption = 'TAdvDBLookupCombobox in TDBAdvGrid demo'
  ClientHeight = 362
  ClientWidth = 530
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBAdvGrid1: TDBAdvGrid
    Left = 17
    Top = 8
    Width = 500
    Height = 336
    Cursor = crDefault
    ColCount = 6
    DefaultRowHeight = 22
    RowCount = 206
    FixedRows = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    OnGetEditorType = DBAdvGrid1GetEditorType
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    Filter = <>
    FixedColWidth = 20
    FixedRowHeight = 22
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
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'Tahoma'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.FindNextCaption = 'Find next'
    SearchFooter.FindPrevCaption = 'Find previous'
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
    Version = '2.1.1.2'
    AutoCreateColumns = False
    AutoRemoveColumns = True
    Columns = <
      item
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'Tahoma'
        PrintFont.Style = []
        Width = 20
      end
      item
        Alignment = taRightJustify
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        FieldName = 'OrderNo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'Tahoma'
        PrintFont.Style = []
        Width = 64
      end
      item
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        FieldName = 'CompanyLookup'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'Tahoma'
        PrintFont.Style = []
        Width = 179
      end
      item
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        FieldName = 'SaleDate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'Tahoma'
        PrintFont.Style = []
        Width = 64
      end
      item
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        FieldName = 'ShipDate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'Tahoma'
        PrintFont.Style = []
        Width = 64
      end
      item
        Borders = []
        BorderPen.Color = clSilver
        CheckFalse = 'N'
        CheckTrue = 'Y'
        Color = clWindow
        FieldName = 'TaxRate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'Tahoma'
        HeaderFont.Style = []
        PrintBorders = [cbTop, cbLeft, cbRight, cbBottom]
        PrintFont.Charset = DEFAULT_CHARSET
        PrintFont.Color = clWindowText
        PrintFont.Height = -11
        PrintFont.Name = 'Tahoma'
        PrintFont.Style = []
        Width = 64
      end>
    DataSource = DataSource1
    EditPostMode = epRow
    ShowUnicode = False
    ColWidths = (
      20
      64
      179
      64
      64
      64)
  end
  object AdvDBLookupComboBox3: TAdvDBLookupComboBox
    Left = 325
    Top = 296
    Width = 193
    Height = 21
    BorderStyle = bsNone
    Enabled = True
    FilterField = 'Company'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    LabelPosition = lpRightCenter
    LabelMargin = 10
    LabelTransparent = True
    LabelAlwaysEnabled = False
    LabelFont.Charset = ANSI_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Verdana'
    LabelFont.Style = [fsBold]
    LabelWidth = 80
    LookupColumn = 0
    LookupMethod = lmRequired
    LookupLoad = llAlways
    ParentFont = False
    TabOrder = 1
    Visible = False
    Columns = <
      item
        FixedColor = clBtnFace
        FixedColorTo = clNone
        GradientDir = gdVertical
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ListField = 'Company'
        Name = 'Company'
        Title = 'My company'
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Verdana'
        TitleFont.Style = [fsBold]
      end
      item
        Color = 14417149
        FixedColor = clBtnFace
        FixedColorTo = clNone
        GradientDir = gdVertical
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        ListField = 'Contact'
        Name = 'Contact'
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Verdana'
        TitleFont.Style = [fsBold]
      end
      item
        Color = 16710110
        FixedColor = clBtnFace
        FixedColorTo = clNone
        GradientDir = gdVertical
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = [fsItalic]
        ListField = 'City'
        Name = 'City'
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Verdana'
        TitleFont.Style = [fsBold]
      end>
    DataField = 'CustNo'
    DataSource = DataSource1
    DropWidth = 340
    DropStretchColumn = -1
    DropHeight = 150
    DropFont.Charset = DEFAULT_CHARSET
    DropFont.Color = clWindowText
    DropFont.Height = -11
    DropFont.Name = 'MS Sans Serif'
    DropFont.Style = []
    KeyField = 'CustNo'
    ListSource = DataSource2
    SortColumn = 'Contact'
    SortUpGlyph.Data = {
      72020000424D720200000000000036000000280000000E0000000D0000000100
      1800000000003C020000C30E0000C30E00000000000000000000C6C6C6C6C6C6
      C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6FF6363FF6363FF6363FF6363FF3131C6C6
      C6C6C6C60000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6FF9C00FF9C00FFFF
      FFFFFFFFFF6363FF6363FF3131C6C6C60000C6C6C6C6C6C6C6C6C6C6C6C6C6C6
      C6FF9C00FFCE63FFFFFFFF6300FF3131FF3131FF3131FF3131FF31310000C6C6
      C6C6C6C6C6C6C6C6C6C6FF9C00FFCE00FFCE00FF9C00FF6300C6C6C6C6C6C6C6
      C6C6630000FF63000000C6C6C6C6C6C6C6C6C6C6C6C6FF9C00FFCE00FF9C00FF
      9C00FF6300C6C6C6C6C6C6C6C6C6C6C6C66300000000C6C6C6C6C6C6C6C6C6FF
      9C00FFFF00FFCE00FF9C00FF6300C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
      0000C6C6C6C6C6C6C6C6C6FF9C00FFFF00FFFF00FFCE00FF6300C6C6C6C6C6C6
      C6C6C6C6C6C6C6C6C6C6C6C60000000000949494949494949494FFFF00FFFF00
      FFFF00949494949494949494000000C6C6C6C6C6C6C6C6C60000C6C6C6000000
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00000000C6C6C6C6C6C6C6C6
      C6C6C6C60000C6C6C6C6C6C6000000FFFF00FFFF00FFFF00FFFF00FFFF000000
      00C6C6C6C6C6C6C6C6C6C6C6C6C6C6C60000C6C6C6C6C6C6C6C6C6000000FFFF
      00FFFF00FFFF00000000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C60000C6C6
      C6C6C6C6C6C6C6C6C6C6000000FFFF00000000C6C6C6C6C6C6C6C6C6C6C6C6C6
      C6C6C6C6C6C6C6C60000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6000000C6C6C6C6
      C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C60000}
    SortDownGlyph.Data = {
      72020000424D720200000000000036000000280000000E0000000D0000000100
      1800000000003C020000C30E0000C30E00000000000000000000C6C6C6C6C6C6
      C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6000000C6C6C6C6C6C6C6C6C6C6C6
      C6C6C6C60000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6000000FFFF
      00000000C6C6C6C6C6C6C6C6C6C6C6C60000C6C6C6C6C6C6C6C6C6C6C6C6C6C6
      C6C6C6C6000000FFFF00FFFF00FFFF00000000C6C6C6C6C6C6C6C6C60000C6C6
      C6C6C6C6C6C6C6C6C6C6C6C6C6000000FFFF00FFFF00FFFF00FFFF00FFFF0000
      0000C6C6C6C6C6C60000C6C6C6C6C6C6C6C6C6C6C6C6000000FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00000000C6C6C60000C6C6C6C6C6C6C6C6C600
      0000848484848484848484FFFF00FFFF00FFFF00FFFF00848484848484000000
      0000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6FF6300FFCE00FFFF00FFFF00
      FF9C00C6C6C6C6C6C6C6C6C60000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
      FF6300FFCE00FF9C00FFCE00FF9C00C6C6C6C6C6C6C6C6C60000C6C6C6C6C6C6
      C6C6C6C6C6C6C6C6C6FF6300FF9C00FF9C00FF9C00FF6363FF9C00C6C6C6C6C6
      C6C6C6C60000C6C6C6C6C6C6C6C6C6C6C6C6FF3131CE6300FF6300FF9C00FFCE
      00FF6363FF9C00C6C6C6C6C6C6C6C6C60000FF3131FF3131FF3131FF3131FF31
      31FF3131FF6300FFFFFFFF6363FF6363C6C6C6C6C6C6C6C6C6C6C6C60000C6C6
      C6FF3131FF6363FF6363FF6363FFFFFFFFFFFFFF6363FF6363C6C6C6C6C6C6C6
      C6C6C6C6C6C6C6C60000C6C6C6C6C6C6FF3131FF6363FF6363FF6363FF6363C6
      C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C60000}
    ShowGridTitleRow = True
    Version = '1.5.0.0'
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'orders.db'
    Left = 60
    Top = 296
    object Table1OrderNo: TFloatField
      FieldName = 'OrderNo'
    end
    object Table1CompanyLookup: TStringField
      FieldKind = fkLookup
      FieldName = 'CompanyLookup'
      LookupDataSet = Table2
      LookupKeyFields = 'CustNo'
      LookupResultField = 'Company'
      KeyFields = 'CustNo'
      Lookup = True
    end
    object Table1SaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
    object Table1ShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object Table1EmpNo: TIntegerField
      FieldName = 'EmpNo'
      Required = True
    end
    object Table1ShipToContact: TStringField
      FieldName = 'ShipToContact'
    end
    object Table1ShipToAddr1: TStringField
      FieldName = 'ShipToAddr1'
      Size = 30
    end
    object Table1ShipToAddr2: TStringField
      FieldName = 'ShipToAddr2'
      Size = 30
    end
    object Table1ShipToCity: TStringField
      FieldName = 'ShipToCity'
      Size = 15
    end
    object Table1ShipToState: TStringField
      FieldName = 'ShipToState'
    end
    object Table1ShipToZip: TStringField
      FieldName = 'ShipToZip'
      Size = 10
    end
    object Table1ShipToCountry: TStringField
      FieldName = 'ShipToCountry'
    end
    object Table1ShipToPhone: TStringField
      FieldName = 'ShipToPhone'
      Size = 15
    end
    object Table1ShipVIA: TStringField
      FieldName = 'ShipVIA'
      Size = 7
    end
    object Table1PO: TStringField
      FieldName = 'PO'
      Size = 15
    end
    object Table1Terms: TStringField
      FieldName = 'Terms'
      Size = 6
    end
    object Table1PaymentMethod: TStringField
      FieldName = 'PaymentMethod'
      Size = 7
    end
    object Table1ItemsTotal: TCurrencyField
      FieldName = 'ItemsTotal'
    end
    object Table1TaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object Table1Freight: TCurrencyField
      FieldName = 'Freight'
    end
    object Table1AmountPaid: TCurrencyField
      FieldName = 'AmountPaid'
    end
    object Table1CustNo: TFloatField
      FieldName = 'CustNo'
      Required = True
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 20
    Top = 296
  end
  object DataSource2: TDataSource
    DataSet = Table2
    Left = 100
    Top = 296
  end
  object Table2: TTable
    Active = True
    DatabaseName = 'DBDEMOS'
    TableName = 'customer.db'
    Left = 136
    Top = 296
  end
  object FormControlEditLink1: TFormControlEditLink
    Tag = 0
    AutoPopupWidth = False
    EditStyle = esInplace
    PopupWidth = 0
    PopupHeight = 0
    WantKeyLeftRight = False
    WantKeyUpDown = False
    WantKeyHomeEnd = False
    WantKeyPriorNext = False
    WantKeyReturn = False
    WantKeyEscape = False
    Control = AdvDBLookupComboBox3
    OnSetEditorValue = FormControlEditLink1SetEditorValue
    OnGetEditorValue = FormControlEditLink1GetEditorValue
    Left = 176
    Top = 296
  end
end
