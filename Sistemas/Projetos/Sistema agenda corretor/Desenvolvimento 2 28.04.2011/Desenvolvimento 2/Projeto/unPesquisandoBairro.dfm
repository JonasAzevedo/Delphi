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
        Width = 252
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CIDADE'
        Title.Caption = 'Cidade'
        Width = 100
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
    Top = 63
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
    object cdsPesquisandoNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Size = 100
    end
  end
  inherited dsPesquisando: TDataSource
    Top = 63
  end
  object zQryCidade: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT *'
      'FROM cidade'
      'WHERE 1=2')
    Params = <>
    Left = 335
    Top = 63
    object zQryCidadeCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryCidadeDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryCidadeCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
      Required = True
    end
    object zQryCidadeNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
  end
end
