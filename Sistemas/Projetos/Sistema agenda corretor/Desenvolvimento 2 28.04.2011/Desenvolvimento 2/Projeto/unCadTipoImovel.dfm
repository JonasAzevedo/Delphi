inherited frmCadTipoImovel: TfrmCadTipoImovel
  Left = 366
  Top = 209
  Caption = 'CADASTRO DE TIPO DE IM'#211'VEIS'
  ClientHeight = 134
  ClientWidth = 388
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 115
    Width = 388
    Panels = <
      item
        Width = 280
      end>
  end
  inherited grpBxDados: TGroupBox
    Width = 388
    Height = 75
    object Label1: TLabel
      Left = 5
      Top = 20
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 5
      Top = 50
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object lblCampoObrigatorio1: TLabel
      Left = 36
      Top = 44
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object plsEdCodigo: TPlsEdit
      Left = 44
      Top = 14
      Width = 71
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnEnter = plsEdCodigoEnter
      OnExit = plsEdCodigoExit
      OnKeyPress = plsEdCodigoKeyPress
      OnKeyUp = plsEdCodigoKeyUp
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object plsEdNome: TPlsEdit
      Left = 44
      Top = 44
      Width = 336
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 1
      Text = 'PLSEDNOME'
      OnEnter = plsEdNomeEnter
      OnExit = plsEdNomeExit
      OnKeyPress = plsEdNomeKeyPress
      OnKeyUp = plsEdNomeKeyUp
      plsCorRecebeFoco = clSilver
    end
  end
  inherited ToolBar: TToolBar
    Width = 388
    inherited pnlDicas: TPanel
      inherited lblDicas: TLabel
        Hint = 'Dicas do Cadastro de Tipo de Im'#243'veis'
        OnClick = lblDicasClick
      end
    end
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * FROM tipo_imovel ORDER BY nome')
    Left = 263
    Top = 35
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 60
    end
  end
  inherited dsDados: TDataSource
    Left = 350
    Top = 35
  end
  inherited dspDados: TDataSetProvider
    Left = 292
    Top = 35
  end
  inherited cdsDados: TClientDataSet
    Left = 322
    Top = 35
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 60
    end
  end
end
