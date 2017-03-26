inherited frmPesquisandoDica: TfrmPesquisandoDica
  Caption = 'PESQUISANDO DICA'
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
        FieldName = 'TELA'
        Title.Caption = 'Tela'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DICA'
        Title.Caption = 'Dica'
        Width = 352
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
    Top = 89
    object cdsPesquisandoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsPesquisandoTELA: TStringField
      FieldName = 'TELA'
      Required = True
      Size = 30
    end
    object cdsPesquisandoDICA: TStringField
      FieldName = 'DICA'
      Required = True
      Size = 500
    end
    object cdsPesquisandoCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
    end
  end
  inherited dsPesquisando: TDataSource
    Left = 38
    Top = 89
  end
  object zQryPesquisando: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT'
      '  codigo,tela,dica,'
      '  CAST(codigo AS VARCHAR(20))AS cc_codigo'
      'FROM dicas'
      'ORDER BY codigo')
    Params = <>
    Left = 10
    Top = 63
    object zQryPesquisandoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryPesquisandoTELA: TStringField
      FieldName = 'TELA'
      Required = True
      Size = 30
    end
    object zQryPesquisandoDICA: TStringField
      FieldName = 'DICA'
      Required = True
      Size = 500
    end
    object zQryPesquisandoCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
    end
  end
  object dspPesquisando: TDataSetProvider
    DataSet = zQryPesquisando
    Left = 38
    Top = 63
  end
end
