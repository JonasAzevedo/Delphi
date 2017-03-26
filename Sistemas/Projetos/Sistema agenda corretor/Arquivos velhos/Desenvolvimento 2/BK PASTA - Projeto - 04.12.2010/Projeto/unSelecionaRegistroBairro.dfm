inherited frmSelecionaRegistroBairro: TfrmSelecionaRegistroBairro
  Left = 526
  Top = 282
  Caption = 'SELECIONAR BAIRRO'
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
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
        Width = 446
        Visible = True
      end>
  end
  inherited pnlTopo: TPanel
    inherited grpBxPesquisar: TGroupBox
      inherited plsEdValorPesquisar: TPlsEdit
        CharCase = ecUpperCase
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
      'SELECT codigo, nome, CAST(codigo AS VARCHAR(10)) AS cc_codigo '
      'FROM bairro ORDER BY nome')
    object zqrySelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zqrySelecionarRegistroNOME: TStringField
      FieldName = 'NOME'
      Size = 100
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
      Size = 100
    end
    object cdsSelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
  end
end
