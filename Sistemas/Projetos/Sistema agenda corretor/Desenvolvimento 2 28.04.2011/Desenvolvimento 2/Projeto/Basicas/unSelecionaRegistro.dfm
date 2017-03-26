object frmSelecionaRegistro: TfrmSelecionaRegistro
  Left = 497
  Top = 231
  BorderStyle = bsDialog
  Caption = 'frmSelecionaRegistro'
  ClientHeight = 247
  ClientWidth = 560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbGrdDados: TDBGrid
    Left = 0
    Top = 41
    Width = 560
    Height = 206
    Align = alClient
    DataSource = dsSelecionarRegistro
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbGrdDadosDblClick
    OnTitleClick = dbGrdDadosTitleClick
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 560
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object grpBxPesquisar: TGroupBox
      Left = 0
      Top = 0
      Width = 446
      Height = 41
      Align = alLeft
      Caption = 'Pequisar'
      TabOrder = 0
      object plsEdValorPesquisar: TPlsEdit
        Left = 149
        Top = 14
        Width = 293
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
        plsCorRecebeFoco = clSilver
      end
      object plsCbBxCampoPesquisar: TPlsComboBox
        Left = 3
        Top = 14
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = plsCbBxCampoPesquisarChange
        plsCorRecebeFoco = clSilver
      end
    end
    object btBtnNovo: TBitBtn
      Left = 447
      Top = 5
      Width = 109
      Height = 35
      Caption = 'Novo'
      TabOrder = 1
      OnClick = btBtnNovoClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF000000390000003900000039000000
        3900FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000009C0000009C0000008400182194004A52A5004A52A5001010
        6B00000042000000420000003900FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000A5000008AD00BDBDEF00FFFFFF00FFFFFF00FFFFFF00F7F7
        FF009CA5CE000000420000003100FF00FF00FF00FF00FF00FF00FF00FF000008
        C6000000BD00FFFFFF00FFFFFF00FFFFFF008C94DE0029299C0029299C00ADB5
        E700FFFFFF00FFFFFF00D6D6EF000000310000004A00FF00FF00FF00FF000000
        C6001829D600FFFFFF00FFFFFF001821AD000000840000006B00000063000000
        6B0031319C00FFFFFF00FFFFFF0000004A0000004200FF00FF00FF00FF002131
        DE00FFFFFF00E7E7F7000818C6000000AD0000009400FFFFFF00FFFFFF000000
        6B0000006B0018189400F7F7FF00CECEE70000005200FF00FF000008EF00637B
        F700FFFFFF004A63E7000000C6000000B5000000A500FFFFFF00FFFFFF000000
        73000000730000006B007B7BC600FFFFFF0031318400000052000008FF00E7EF
        FF00FFFFFF000010EF000008E700EFEFFF00E7E7FF00FFFFFF00FFFFFF00E7E7
        F700E7E7F7000000730000007B00FFFFFF00A5A5DE00000042000010FF00F7F7
        FF00FFFFFF000010FF000008EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000007B0000008400FFFFFF00ADB5E70000007B001839FF00E7EF
        FF00FFFFFF000821FF000008FF000010F7000008E700FFFFFF00FFFFFF000000
        B5000000AD00000094002129B500FFFFFF00737BD600000084000010FF00CEDE
        FF00FFFFFF00637BFF000008FF000010FF000008F700FFFFFF00FFFFFF000000
        C6000000BD000000A5008C94DE00FFFFFF002931C600FF00FF00FF00FF006B84
        FF00FFFFFF00FFFFFF00CED6FF000008FF000008FF000018FF000010F7000008
        DE000000CE00EFEFFF00FFFFFF004252CE0000009C00FF00FF00FF00FF003152
        FF00CEDEFF00FFFFFF00FFFFFF003952FF000010FF000008FF000008FF000018
        EF00526BEF00FFFFFF00FFFFFF000008AD000000A500FF00FF00FF00FF00FF00
        FF004263FF00EFF7FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0094A5F7000810CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF005273FF00B5C6FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00ADB5FF000008D6000000C600FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00526BFF003152FF00395AFF00294AFF001029
        F7001029EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
  end
  object dsSelecionarRegistro: TDataSource
    DataSet = cdsSelecionarRegistro
    Left = 87
    Top = 72
  end
  object zqrySelecionarRegistro: TZQuery
    Connection = DM.ZConnection
    Params = <>
    Top = 72
  end
  object dspSelecionarRegistro: TDataSetProvider
    DataSet = zqrySelecionarRegistro
    Left = 29
    Top = 72
  end
  object cdsSelecionarRegistro: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspSelecionarRegistro'
    Left = 58
    Top = 72
  end
end
