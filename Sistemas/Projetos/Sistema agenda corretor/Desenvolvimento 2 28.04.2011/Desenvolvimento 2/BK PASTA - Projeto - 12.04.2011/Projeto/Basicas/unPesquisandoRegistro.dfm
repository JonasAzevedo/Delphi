object frmPesquisandoRegistro: TfrmPesquisandoRegistro
  Left = 454
  Top = 298
  BorderStyle = bsDialog
  Caption = 'PESQUISANDO SUB-GRUPO DE CONFIGURA'#199#195'O DE IM'#211'VEL'
  ClientHeight = 173
  ClientWidth = 554
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
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbGrdRegistros: TDBGrid
    Left = 0
    Top = 25
    Width = 554
    Height = 148
    Align = alClient
    DataSource = dsPesquisando
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbGrdRegistrosDblClick
    OnTitleClick = dbGrdRegistrosTitleClick
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblCampo: TLabel
      Left = 0
      Top = 8
      Width = 36
      Height = 13
      Caption = 'Campo:'
    end
    object plsEdValorPesquisa: TPlsEdit
      Left = 64
      Top = 1
      Width = 489
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      Text = 'PLSEDVALORPESQUISA'
      OnChange = plsEdValorPesquisaChange
    end
  end
  object cdsPesquisando: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 3
    Top = 40
  end
  object dsPesquisando: TDataSource
    DataSet = cdsPesquisando
    Left = 31
    Top = 40
  end
end
