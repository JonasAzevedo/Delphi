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
        Title.Caption = 'Bairro'
        Width = 255
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CIDADE'
        Title.Caption = 'Cidade'
        Width = 203
        Visible = True
      end>
  end
  inherited pnlTopo: TPanel
    inherited grpBxPesquisar: TGroupBox
      inherited plsEdValorPesquisar: TPlsEdit
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
      
        'SELECT b.codigo, b.nome,  CAST(b.codigo AS VARCHAR(10)) AS cc_co' +
        'digo,'
      'c.codigo AS cod_fk_cidade,c.nome AS cidade'
      'FROM bairro b'
      'JOIN cidade c ON b.cod_fk_cidade = c.codigo'
      'WHERE 1=2')
    object zqrySelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zqrySelecionarRegistroNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zqrySelecionarRegistroCIDADE: TStringField
      FieldName = 'CIDADE'
      Required = True
      Size = 100
    end
    object zqrySelecionarRegistroCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
      Required = True
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
    object cdsSelecionarRegistroCIDADE: TStringField
      FieldName = 'CIDADE'
      Required = True
      Size = 100
    end
    object cdsSelecionarRegistroCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
      Required = True
    end
    object cdsSelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
  end
end
