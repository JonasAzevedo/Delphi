inherited frmCadConstrutora: TfrmCadConstrutora
  Left = 388
  Top = 210
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'CADASTRO DE CONSTRUTORAS'
  ClientHeight = 164
  ClientWidth = 384
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 145
    Width = 384
  end
  inherited grpBxDados: TGroupBox
    Width = 384
    Height = 105
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
    object lblTelefone1: TLabel
      Left = 5
      Top = 80
      Width = 57
      Height = 13
      Caption = 'Telefone 1: '
    end
    object lblTelefone2: TLabel
      Left = 160
      Top = 80
      Width = 63
      Height = 13
      Caption = 'Telefone (2): '
    end
    object lblCampoObrigatorio1: TLabel
      Left = 40
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
      Left = 49
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
      Left = 49
      Top = 44
      Width = 327
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 1
      Text = 'PLSEDNOME'
      OnExit = plsEdNomeExit
      OnKeyUp = plsEdNomeKeyUp
      plsCorRecebeFoco = clSilver
    end
    object plsMedTelefone1: TPlsMaskEdit
      Left = 66
      Top = 74
      Width = 79
      Height = 21
      EditMask = '(99)9999-9999;1;_'
      MaxLength = 13
      TabOrder = 2
      Text = '(  )    -    '
      plsCorRecebeFoco = clSilver
    end
    object plsMedTelefone2: TPlsMaskEdit
      Left = 224
      Top = 74
      Width = 79
      Height = 21
      EditMask = '(99)9999-9999;1;_'
      MaxLength = 13
      TabOrder = 3
      Text = '(  )    -    '
      plsCorRecebeFoco = clSilver
    end
  end
  inherited ToolBar: TToolBar
    Width = 384
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * FROM construtora ORDER BY nome')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zQryDadosTELEFONE_1: TStringField
      FieldName = 'TELEFONE_1'
      Size = 13
    end
    object zQryDadosTELEFONE_2: TStringField
      FieldName = 'TELEFONE_2'
      Size = 13
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
    object cdsDadosTELEFONE_1: TStringField
      FieldName = 'TELEFONE_1'
      Size = 13
    end
    object cdsDadosTELEFONE_2: TStringField
      FieldName = 'TELEFONE_2'
      Size = 13
    end
  end
end
