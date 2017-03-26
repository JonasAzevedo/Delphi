inherited frmCadDica: TfrmCadDica
  Caption = 'CADASTRO DE DICAS'
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Panels = <
      item
        Width = 280
      end>
  end
  inherited grpBxDados: TGroupBox
    object lblCodigo: TLabel
      Left = 5
      Top = 20
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object lblDica: TLabel
      Left = 5
      Top = 110
      Width = 28
      Height = 13
      Caption = 'Dica: '
    end
    object lblCampoObrigatorio2: TLabel
      Left = 42
      Top = 112
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
    object lblUsuario: TLabel
      Left = 5
      Top = 50
      Width = 45
      Height = 13
      Caption = 'Usu'#225'rio:  '
    end
    object lblNomeUsuario: TLabel
      Left = 50
      Top = 50
      Width = 3
      Height = 13
    end
    object lblTela: TLabel
      Left = 5
      Top = 80
      Width = 27
      Height = 13
      Caption = 'Tela: '
    end
    object lblCampoObrigatorio1: TLabel
      Left = 42
      Top = 75
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
      Left = 50
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
    object plsMmDica: TPlsMemo
      Left = 50
      Top = 110
      Width = 327
      Height = 65
      Lines.Strings = (
        'plsMmDica')
      MaxLength = 500
      TabOrder = 1
      OnEnter = plsMmDicaEnter
      OnExit = plsMmDicaExit
      OnKeyPress = plsMmDicaKeyPress
      OnKeyUp = plsMmDicaKeyUp
      plsCorRecebeFoco = clSilver
      plsCaractresMaiusculo = True
    end
    object plsCbBxTela: TPlsComboBox
      Left = 50
      Top = 74
      Width = 327
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnEnter = plsCbBxTelaEnter
      OnExit = plsCbBxTelaExit
      OnKeyPress = plsCbBxTelaKeyPress
      Items.Strings = (
        'ESTADO'
        'CIDADE'
        'BAIRRO'
        'RUA'
        'REGIAO LOCALIDADE'
        'CONSTRUTORA'
        'PROFISS'#195'O'
        'MEIO DE CAPTA'#199#195'O'
        'GRUPO DE CONFIGURA'#199#195'O DO IM'#211'VEL'
        'SUB-GRUPO DE CONFIGURA'#199#195'O DO IM'#211'VEL'
        'GRUPO DE CONFIGURA'#199#195'O DE BEM NEGOCI'#193'VEL'
        'SUB-GRUPO DE CONFIGURA'#199#195'O DE BEM NEGOCI'#193'VEL'
        'AGENCIADOR - PESSOA F'#205'SICA'
        'AGENCIADOR - PESSOA JUR'#205'DICA'
        'CLIENTE - PESSOA F'#205'SICA'
        'CLIENTE - PESSOA JUR'#205'DICA'
        'IM'#211'VEL'
        'TIPO DE IM'#211'VEL'
        'AGENCIAMENTO'
        'IM'#211'VEL DE INTERESSE'
        'VENDA')
      plsCorRecebeFoco = clSilver
    end
  end
  inherited ToolBar: TToolBar
    inherited pnlDicas: TPanel
      inherited lblDicas: TLabel
        Visible = False
      end
    end
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * '
      'FROM dicas'
      'WHERE 1=2'
      'ORDER BY codigo')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosCOD_FK_USUARIO: TIntegerField
      FieldName = 'COD_FK_USUARIO'
      Required = True
    end
    object zQryDadosTELA: TStringField
      FieldName = 'TELA'
      Required = True
      Size = 50
    end
    object zQryDadosDICA: TStringField
      FieldName = 'DICA'
      Required = True
      Size = 500
    end
    object zQryDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
      Required = True
    end
  end
  inherited cdsDados: TClientDataSet
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosCOD_FK_USUARIO: TIntegerField
      FieldName = 'COD_FK_USUARIO'
      Required = True
    end
    object cdsDadosTELA: TStringField
      FieldName = 'TELA'
      Required = True
      Size = 50
    end
    object cdsDadosDICA: TStringField
      FieldName = 'DICA'
      Required = True
      Size = 500
    end
    object cdsDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
      Required = True
    end
  end
end
