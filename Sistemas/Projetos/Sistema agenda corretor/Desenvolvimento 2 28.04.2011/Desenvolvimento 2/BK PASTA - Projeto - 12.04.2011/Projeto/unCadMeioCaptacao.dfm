inherited frmCadMeioCaptacao: TfrmCadMeioCaptacao
  Left = 401
  Top = 269
  Caption = 'CADASTRO DE MEIOS DE CAPTA'#199#195'O'
  ClientHeight = 206
  ClientWidth = 392
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 187
    Width = 392
  end
  inherited grpBxDados: TGroupBox
    Width = 392
    Height = 147
    object lblCodigo: TLabel
      Left = 5
      Top = 20
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object lblNome: TLabel
      Left = 5
      Top = 50
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object lblDescricao: TLabel
      Left = 5
      Top = 80
      Width = 51
      Height = 13
      Caption = 'Descri'#231#227'o:'
    end
    object lblCampoObrigatorio1: TLabel
      Left = 50
      Top = 45
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
      Left = 58
      Top = 14
      Width = 71
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      Text = 'PLSEDCODIGO'
      OnEnter = plsEdCodigoEnter
      OnExit = plsEdCodigoExit
      OnKeyPress = plsEdCodigoKeyPress
      OnKeyUp = plsEdCodigoKeyUp
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object plsEdNome: TPlsEdit
      Left = 58
      Top = 44
      Width = 329
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      Text = 'PLSEDNOME'
      OnEnter = plsEdNomeEnter
      OnExit = plsEdNomeExit
      OnKeyPress = plsEdNomeKeyPress
      OnKeyUp = plsEdNomeKeyUp
      plsCorRecebeFoco = clSilver
    end
    object plsMmDescricao: TPlsMemo
      Left = 58
      Top = 80
      Width = 327
      Height = 57
      Lines.Strings = (
        'plsMmDescricao')
      MaxLength = 200
      TabOrder = 2
      OnEnter = plsMmDescricaoEnter
      OnKeyPress = plsMmDescricaoKeyPress
      plsCorRecebeFoco = clSilver
    end
  end
  inherited ToolBar: TToolBar
    Width = 392
    inherited pnlDicas: TPanel
      inherited lblDicas: TLabel
        OnClick = lblDicasClick
      end
    end
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * FROM meio_captacao ORDER BY nome')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
    object zQryDadosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
  end
  inherited cdsDados: TClientDataSet
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
    object cdsDadosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
  end
end
