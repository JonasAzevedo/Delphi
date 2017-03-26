inherited frmPesquisandoBairro: TfrmPesquisandoBairro
  Caption = 'PESQUISANDO BAIRRO'
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
        Width = 465
        Visible = True
      end>
  end
  inherited pnlTopo: TPanel
    inherited plsEdValorPesquisa: TPlsEdit
      MaxLength = 100
      plsCorRecebeFoco = clSilver
    end
  end
  inherited cdsPesquisando: TClientDataSet
    object cdsPesquisandoCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 10
    end
    object cdsPesquisandoNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object cdsPesquisandoCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      Size = 10
    end
  end
end
