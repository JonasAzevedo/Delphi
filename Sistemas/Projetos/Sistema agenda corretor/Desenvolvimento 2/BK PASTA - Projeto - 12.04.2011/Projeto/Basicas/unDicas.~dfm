object frmDicas: TfrmDicas
  Left = 395
  Top = 242
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'DICAS -->'
  ClientHeight = 265
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblTituloCadastroPor: TLabel
    Left = 3
    Top = 208
    Width = 66
    Height = 13
    Caption = 'Cadastro por: '
  end
  object lblCadastradoPor: TLabel
    Left = 78
    Top = 208
    Width = 3
    Height = 13
  end
  object lblCountDicas: TLabel
    Left = 357
    Top = 248
    Width = 11
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object plsMmDicas: TPlsMemo
    Left = 0
    Top = 0
    Width = 437
    Height = 201
    Align = alTop
    ReadOnly = True
    TabOrder = 0
    plsCorRecebeFoco = clWindow
  end
  object btBtnProximo: TBitBtn
    Left = 384
    Top = 220
    Width = 50
    Height = 25
    Caption = '>>>'
    TabOrder = 1
    OnClick = btBtnProximoClick
  end
  object btBtnAnterior: TBitBtn
    Left = 328
    Top = 220
    Width = 50
    Height = 25
    Caption = '<<<'
    TabOrder = 2
    OnClick = btBtnAnteriorClick
  end
  object zQryDicas: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT d.codigo,d.cod_fk_usuario,d.tela,d.dica,d.data_cadastro,'
      '       u.nome'
      'FROM dicas d'
      'JOIN usuario u ON d.cod_fk_usuario=u.codigo'
      'WHERE 1=2')
    Params = <>
    Left = 336
    Top = 160
    object zQryDicasCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDicasCOD_FK_USUARIO: TIntegerField
      FieldName = 'COD_FK_USUARIO'
      Required = True
    end
    object zQryDicasTELA: TStringField
      FieldName = 'TELA'
      Required = True
      Size = 30
    end
    object zQryDicasDICA: TStringField
      FieldName = 'DICA'
      Required = True
      Size = 500
    end
    object zQryDicasDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
      Required = True
    end
    object zQryDicasNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  object cdsDicas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspDicas'
    Left = 395
    Top = 160
    object cdsDicasCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDicasCOD_FK_USUARIO: TIntegerField
      FieldName = 'COD_FK_USUARIO'
      Required = True
    end
    object cdsDicasTELA: TStringField
      FieldName = 'TELA'
      Required = True
      Size = 30
    end
    object cdsDicasDICA: TStringField
      FieldName = 'DICA'
      Required = True
      Size = 500
    end
    object cdsDicasDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
      Required = True
    end
    object cdsDicasNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  object dspDicas: TDataSetProvider
    DataSet = zQryDicas
    Left = 365
    Top = 160
  end
end
