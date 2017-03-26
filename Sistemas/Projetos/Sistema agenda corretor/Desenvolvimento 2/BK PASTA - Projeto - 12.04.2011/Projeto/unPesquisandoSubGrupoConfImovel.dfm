inherited frmPesquisandoSubGrupoConfImovel: TfrmPesquisandoSubGrupoConfImovel
  Top = 342
  Caption = 'PESQUISANDO SUB-GRUPO DE CONIGURA'#199#195'O DE IM'#211'VEL'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbGrdRegistros: TDBGrid
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Width = 238
        Visible = True
      end>
  end
  inherited pnlTopo: TPanel
    inherited plsEdValorPesquisa: TPlsEdit
      plsCorRecebeFoco = clSilver
    end
  end
  inherited cdsPesquisando: TClientDataSet
    ProviderName = 'dspPesquisando'
    Left = 10
    Top = 90
    object cdsPesquisandoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsPesquisandoNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
    object cdsPesquisandoCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
    end
  end
  inherited dsPesquisando: TDataSource
    Left = 38
    Top = 90
  end
  object dspPesquisando: TDataSetProvider
    DataSet = zQryPesquisando
    Left = 38
    Top = 63
  end
  object zQryPesquisando: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT'
      '  codigo,nome,'
      '  CAST(codigo AS VARCHAR(20))AS cc_codigo'
      'FROM sub_grupo_conf_imovel'
      'ORDER BY codigo')
    Params = <>
    Left = 10
    Top = 63
    object zQryPesquisandoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryPesquisandoNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
    object zQryPesquisandoCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
    end
  end
end
