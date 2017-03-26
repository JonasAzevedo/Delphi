inherited frmCadProfissao: TfrmCadProfissao
  Caption = 'CADASTRO DE PROFISS'#213'ES'
  ClientHeight = 136
  ClientWidth = 388
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 117
    Width = 388
  end
  inherited grpBxDados: TGroupBox
    Width = 388
    Height = 77
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
      Left = 42
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
      Left = 42
      Top = 44
      Width = 338
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
        OnClick = lblDicasClick
      end
    end
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * FROM profissao ORDER BY nome')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  inherited cdsDados: TClientDataSet
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
end
