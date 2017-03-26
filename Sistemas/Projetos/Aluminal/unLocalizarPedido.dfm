inherited frmLocalizarPedido: TfrmLocalizarPedido
  Left = 702
  Top = 327
  Caption = 'Localizar Pedido'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited grpBxPesquisar: TGroupBox
    inherited cbBxCampoLocalizar: TPlsComboBox
      OnChange = cbBxCampoLocalizarChange
      Items.Strings = (
        'Codigo'
        'Cliente'
        'Cidade')
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
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Caption = 'Cliente'
          Width = 310
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CIDADE'
          Title.Caption = 'Cidade'
          Width = 320
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'VALOR'
          Title.Caption = 'Valor Total'
          Width = 133
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
      
        'SELECT p.*,  CAST(p.codigo AS VARCHAR(10)) AS cc_codigo, c.nome,' +
        ' e.cidade'
      'FROM pedido p'
      'JOIN cliente c ON p.cod_cliente = c.codigo'
      'JOIN endereco e ON p.cod_endereco_entrega = e.codigo'
      'WHERE 1=2'
      'ORDER BY p.data_cadastro DESC')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryDadosCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
      Required = True
    end
    object zQryDadosCOD_ENDERECO_ENTREGA: TIntegerField
      FieldName = 'COD_ENDERECO_ENTREGA'
      Required = True
    end
    object zQryDadosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 1000
    end
    object zQryDadosVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      Required = True
    end
    object zQryDadosCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
    object zQryDadosCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object zQryDadosSTATUS: TIntegerField
      FieldName = 'STATUS'
      Required = True
    end
  end
  inherited cdsDados: TClientDataSet
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsDadosCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
      Required = True
    end
    object cdsDadosCOD_ENDERECO_ENTREGA: TIntegerField
      FieldName = 'COD_ENDERECO_ENTREGA'
      Required = True
    end
    object cdsDadosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 1000
    end
    object cdsDadosVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      Required = True
    end
    object cdsDadosCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object cdsDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
    object cdsDadosCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object cdsDadosSTATUS: TIntegerField
      FieldName = 'STATUS'
      Required = True
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
