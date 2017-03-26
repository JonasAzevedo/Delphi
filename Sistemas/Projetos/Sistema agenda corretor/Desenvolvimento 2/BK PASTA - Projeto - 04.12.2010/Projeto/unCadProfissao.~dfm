inherited frmCadProfissao: TfrmCadProfissao
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'CADASTRO DE PROFISS'#213'ES'
  ClientHeight = 136
  ClientWidth = 377
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 117
    Width = 377
  end
  inherited grpBxDados: TGroupBox
    Width = 377
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
      OnExit = plsEdCodigoExit
      OnKeyUp = plsEdCodigoKeyUp
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object plsEdNome: TPlsEdit
      Left = 42
      Top = 44
      Width = 329
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 1
      Text = 'PLSEDNOME'
      OnExit = plsEdNomeExit
      OnKeyUp = plsEdNomeKeyUp
      plsCorRecebeFoco = clSilver
    end
  end
  inherited ToolBar: TToolBar
    Width = 377
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
