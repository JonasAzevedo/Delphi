object frmPesquisar: TfrmPesquisar
  Left = 396
  Top = 188
  BorderStyle = bsSingle
  Caption = 'PESQUISAR'
  ClientHeight = 466
  ClientWidth = 505
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
  object grpBxFiltroPesquisar: TGroupBox
    Left = 0
    Top = 0
    Width = 505
    Height = 97
    Align = alTop
    Caption = 'Filtros da Pesquisa '
    TabOrder = 0
  end
  object dbGrdDadosPesquisa: TDBGrid
    Left = 0
    Top = 97
    Width = 505
    Height = 334
    Align = alClient
    DataSource = dsDados
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 431
    Width = 505
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btBtnLimpar: TBitBtn
      Left = 2
      Top = 0
      Width = 75
      Height = 35
      Caption = 'Limpar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btBtnLimparClick
    end
    object btBtnPesquisar: TBitBtn
      Left = 76
      Top = 0
      Width = 75
      Height = 35
      Caption = 'Pesquisar'
      Default = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btBtnPesquisarClick
    end
  end
  object zQryDados: TZQuery
    Connection = DM.ZConnection
    Params = <>
    Left = 12
    Top = 142
  end
  object dspDados: TDataSetProvider
    DataSet = zQryDados
    Left = 41
    Top = 142
  end
  object cdsDados: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDados'
    Left = 71
    Top = 142
  end
  object dsDados: TDataSource
    DataSet = cdsDados
    Left = 99
    Top = 142
  end
end
