inherited frmPesquisandoSubGrupoBemNegociavel: TfrmPesquisandoSubGrupoBemNegociavel
  Caption = 'PESQUISANDO SUB-GRUPO DE BEM NEGOCI'#193'VEL'
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
        Width = 258
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_GRUPO'
        Title.Caption = 'Grupo'
        Width = 167
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
    Top = 91
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
    object cdsPesquisandoNOME_GRUPO: TStringField
      FieldName = 'NOME_GRUPO'
      Required = True
      Size = 50
    end
  end
  inherited dsPesquisando: TDataSource
    Left = 38
    Top = 91
  end
  object zQryPesquisando: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT'
      '  s.codigo, s.nome,'
      '  CAST(s.codigo AS VARCHAR(20))AS cc_codigo,'
      '  g.nome AS nome_grupo'
      'FROM sub_grupo_bem_negociavel s'
      'JOIN grupo_bem_negociavel g ON s.cod_fk_grupo=g.codigo'
      'WHERE 1=2'
      'ORDER BY s.codigo')
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
    object zQryPesquisandoNOME_GRUPO: TStringField
      FieldName = 'NOME_GRUPO'
      Required = True
      Size = 50
    end
  end
  object dspPesquisando: TDataSetProvider
    DataSet = zQryPesquisando
    Left = 38
    Top = 63
  end
  object zQryGrupo: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT *'
      'FROM grupo_bem_negociavel'
      'WHERE 1=2')
    Params = <>
    Left = 338
    Top = 63
    object zQryGrupoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryGrupoNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
  end
end
