inherited frmSelecionaRegistroTipoImovel: TfrmSelecionaRegistroTipoImovel
  Left = 478
  Top = 303
  Caption = 'SELECIONAR TIPO DE IM'#211'VEL'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbGrdDados: TDBGrid
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
        Width = 460
        Visible = True
      end>
  end
  inherited pnlTopo: TPanel
    inherited grpBxPesquisar: TGroupBox
      inherited plsEdValorPesquisar: TPlsEdit
        MaxLength = 100
        OnChange = plsEdValorPesquisarChange
      end
      inherited plsCbBxCampoPesquisar: TPlsComboBox
        Items.Strings = (
          'C'#243'digo'
          'Nome')
      end
    end
  end
  inherited zqrySelecionarRegistro: TZQuery
    SQL.Strings = (
      'SELECT codigo, nome, CAST(codigo AS VARCHAR(10)) AS cc_codigo'
      'FROM tipo_imovel ORDER BY nome')
    object zqrySelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zqrySelecionarRegistroNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 60
    end
    object zqrySelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
  end
  inherited cdsSelecionarRegistro: TClientDataSet
    AfterScroll = cdsSelecionarRegistroAfterScroll
    object cdsSelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsSelecionarRegistroNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 60
    end
    object cdsSelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
  end
end
