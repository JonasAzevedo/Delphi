object frmRestaurarBackup: TfrmRestaurarBackup
  Left = 347
  Top = 166
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'RESTAURAR BACKUP'
  ClientHeight = 267
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object dbGrdBackups: TDBGrid
    Left = 0
    Top = 0
    Width = 808
    Height = 225
    Align = alTop
    DataSource = dsBackup
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Title.Caption = 'Data'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PATH_BACKUP'
        Title.Caption = 'Path'
        Width = 623
        Visible = True
      end>
  end
  object pnlOpcoes: TPanel
    Left = 0
    Top = 225
    Width = 808
    Height = 42
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object btBtnRestaurar: TBitBtn
      Left = 5
      Top = 4
      Width = 171
      Height = 33
      Caption = '&RESTAURAR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btBtnRestaurarClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object zQryBackup: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT * FROM backup'
      'WHERE ativo='#39'SIM'#39
      'AND 1=2')
    Params = <>
    Left = 14
    Top = 40
    object zQryBackupCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryBackupDATA: TDateTimeField
      FieldName = 'DATA'
      Required = True
    end
    object zQryBackupPATH_BACKUP: TStringField
      FieldName = 'PATH_BACKUP'
      Required = True
      Size = 600
    end
    object zQryBackupATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      Size = 3
    end
  end
  object dspBackup: TDataSetProvider
    DataSet = zQryBackup
    Left = 43
    Top = 40
  end
  object cdsBackup: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspBackup'
    Left = 73
    Top = 40
    object cdsBackupCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsBackupDATA: TDateTimeField
      FieldName = 'DATA'
      Required = True
    end
    object cdsBackupPATH_BACKUP: TStringField
      FieldName = 'PATH_BACKUP'
      Required = True
      Size = 600
    end
    object cdsBackupATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      Size = 3
    end
  end
  object dsBackup: TDataSource
    DataSet = cdsBackup
    Left = 102
    Top = 40
  end
end
