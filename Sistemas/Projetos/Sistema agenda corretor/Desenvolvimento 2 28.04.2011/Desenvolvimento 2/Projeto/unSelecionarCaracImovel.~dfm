object frmSelecionarCaracImovel: TfrmSelecionarCaracImovel
  Left = 546
  Top = 207
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'SELECIONAR CARACTER'#205'STICAS DO IM'#211'VEL'
  ClientHeight = 388
  ClientWidth = 356
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
  DesignSize = (
    356
    388)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlSelecionar: TPanel
    Left = 0
    Top = 353
    Width = 356
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
  end
  object btBtnSelecionar: TBitBtn
    Left = 242
    Top = 358
    Width = 113
    Height = 29
    Anchors = [akTop, akRight, akBottom]
    TabOrder = 1
    OnClick = btBtnSelecionarClick
    Kind = bkOK
  end
  object cdsCaracteristicas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspCaracteristicas'
    Left = 64
    Top = 8
    object cdsCaracteristicasCODIGO_GRUPO: TIntegerField
      FieldName = 'CODIGO_GRUPO'
      Required = True
    end
    object cdsCaracteristicasNOME_GRUPO: TStringField
      FieldName = 'NOME_GRUPO'
      Required = True
      Size = 50
    end
    object cdsCaracteristicasCODIGO_SUB_GRUPO: TIntegerField
      FieldName = 'CODIGO_SUB_GRUPO'
      Required = True
    end
    object cdsCaracteristicasNOME_SUB_GRUPO: TStringField
      FieldName = 'NOME_SUB_GRUPO'
      Required = True
      Size = 50
    end
  end
  object dspCaracteristicas: TDataSetProvider
    DataSet = zQryCaracteristicas
    Left = 36
    Top = 8
  end
  object zQryCaracteristicas: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT g.codigo AS codigo_grupo,g.nome AS nome_grupo,'
      '       s.codigo AS codigo_sub_grupo,s.nome AS nome_sub_grupo'
      'FROM grupo_configuracao_imovel g'
      'JOIN sub_grupo_conf_imovel s ON g.codigo = s.cod_fk_grupo'
      'WHERE 1=2')
    Params = <>
    Left = 8
    Top = 8
    object zQryCaracteristicasCODIGO_GRUPO: TIntegerField
      FieldName = 'CODIGO_GRUPO'
      Required = True
    end
    object zQryCaracteristicasNOME_GRUPO: TStringField
      FieldName = 'NOME_GRUPO'
      Required = True
      Size = 50
    end
    object zQryCaracteristicasCODIGO_SUB_GRUPO: TIntegerField
      FieldName = 'CODIGO_SUB_GRUPO'
      Required = True
    end
    object zQryCaracteristicasNOME_SUB_GRUPO: TStringField
      FieldName = 'NOME_SUB_GRUPO'
      Required = True
      Size = 50
    end
  end
end
