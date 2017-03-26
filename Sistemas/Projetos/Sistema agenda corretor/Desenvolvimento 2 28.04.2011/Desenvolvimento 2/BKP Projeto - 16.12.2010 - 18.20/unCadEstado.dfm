inherited frmCadEstado: TfrmCadEstado
  Left = 401
  Top = 232
  Height = 200
  Caption = 'CADASTRO DE ESTADOS'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 147
  end
  inherited grpBxDados: TGroupBox
    Height = 107
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
    object lblSigla: TLabel
      Left = 5
      Top = 80
      Width = 26
      Height = 13
      Caption = 'Sigla:'
    end
    object plsEdCodigo: TPlsEdit
      Left = 50
      Top = 14
      Width = 71
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = 'plsEdCodigo'
      plsCaracteresAceitos = numeros
    end
    object plsEdNome: TPlsEdit
      Left = 50
      Top = 44
      Width = 287
      Height = 21
      MaxLength = 50
      TabOrder = 1
      Text = 'plsEdNome'
      plsCaracteresAceitos = letras
    end
    object plsEdSigla: TPlsEdit
      Left = 50
      Top = 74
      Width = 65
      Height = 21
      MaxLength = 2
      TabOrder = 2
      Text = 'plsEdSigla'
      plsCaracteresAceitos = letras
    end
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * FROM estado')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
    object zQryDadosSIGLA: TStringField
      FieldName = 'SIGLA'
      Required = True
      Size = 2
    end
  end
end
