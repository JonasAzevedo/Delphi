inherited frmLocalizarDescricaoProdutos: TfrmLocalizarDescricaoProdutos
  Left = 926
  Top = 199
  Caption = 'Localizar Descri'#231#227'o Produtos'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited grpBxPesquisar: TGroupBox
    inherited cbBxCampoLocalizar: TPlsComboBox
      OnChange = cbBxCampoLocalizarChange
      Items.Strings = (
        'C'#243'digo'
        'Nome')
      plsCorRecebeFoco = clSilver
    end
    inherited edLocalizar: TPlsEdit
      plsCorRecebeFoco = clSilver
    end
  end
  inherited pnlDados: TPanel
    inherited grDados: TDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Caption = 'Nome'
          Width = 631
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VALOR'
          Title.Caption = 'Valor Unit'#225'rio'
          Width = 115
          Visible = True
        end>
    end
  end
  inherited StatusBar: TStatusBar
    Panels = <
      item
        Width = 700
      end
      item
        Width = 50
      end>
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT d.*, CAST(d.codigo AS VARCHAR(10)) AS cc_codigo'
      'FROM descricao_produtos d'
      'WHERE 1=2'
      'ORDER BY d.nome'
      '')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object zQryDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 1000
    end
    object zQryDadosVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object zQryDadosCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
  end
  inherited cdsDados: TClientDataSet
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
    object cdsDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 1000
    end
    object cdsDadosVALOR: TFloatField
      FieldName = 'VALOR'
    end
    object cdsDadosCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
  end
  inherited dsDados: TDataSource
    DataSet = cdsExibeDados
    Left = 49
    Top = 155
  end
  object cdsExibeDados: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 20
    Top = 155
  end
end
