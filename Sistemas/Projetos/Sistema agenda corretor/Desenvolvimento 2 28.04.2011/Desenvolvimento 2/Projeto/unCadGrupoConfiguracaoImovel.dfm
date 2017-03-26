inherited frmCadGrupoConfiguracaoImovel: TfrmCadGrupoConfiguracaoImovel
  Left = 446
  Top = 369
  Caption = 'CADASTRO  DE GRUPO DE CONFIGURA'#199#195'O DE IM'#211'VEL'
  ClientHeight = 135
  ClientWidth = 425
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 116
    Width = 425
  end
  inherited grpBxDados: TGroupBox
    Width = 425
    Height = 76
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
    object lblCampoObrigatorio1: TLabel
      Left = 36
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
      Left = 44
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
      Left = 44
      Top = 44
      Width = 373
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
  end
  inherited ToolBar: TToolBar
    Width = 425
    inherited pnlDicas: TPanel
      Width = 171
      inherited lblDicas: TLabel
        Left = 137
        Hint = 'Dicas do Cadastro de Grupo de Configura'#231#227'o do Im'#243'vel'
        OnClick = lblDicasClick
      end
    end
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * '
      'FROM grupo_configuracao_imovel'
      'WHERE 1=2'
      'ORDER BY nome')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
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
  end
end
