inherited frmPesquisandoRua: TfrmPesquisandoRua
  Caption = 'PESQUISANDO RUA'
  ClientWidth = 666
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbGrdRegistros: TDBGrid
    Width = 666
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
        Width = 223
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_BAIRRO'
        Title.Caption = 'Bairro'
        Width = 120
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
    Width = 666
    inherited plsEdValorPesquisa: TPlsEdit
      Width = 601
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
    object cdsPesquisandoCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsPesquisandoCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      Size = 10
    end
    object cdsPesquisandoNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
      Size = 100
    end
    object cdsPesquisandoNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Size = 100
    end
  end
  object zQryCidade: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT b.nome AS nome_bairro,c.nome AS nome_cidade'
      'FROM bairro b'
      'JOIN cidade c ON b.cod_fk_cidade=c.codigo'
      'WHERE 1=2')
    Params = <>
    Left = 391
    Top = 63
    object zQryCidadeNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
      Required = True
      Size = 100
    end
    object zQryCidadeNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
  end
end
