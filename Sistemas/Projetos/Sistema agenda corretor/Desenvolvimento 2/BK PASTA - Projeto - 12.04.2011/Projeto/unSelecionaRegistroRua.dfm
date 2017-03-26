inherited frmSelecionaRegistroRua: TfrmSelecionaRegistroRua
  Left = 399
  Top = 299
  Caption = 'SELECIONAR RUA'
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
        Title.Caption = 'Rua'
        Width = 219
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP'
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BAIRRO'
        Title.Caption = 'Bairro'
        Width = 188
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
          'Nome'
          'CEP')
      end
    end
  end
  inherited zqrySelecionarRegistro: TZQuery
    SQL.Strings = (
      
        'SELECT r.codigo, r.nome, r.cep, CAST(r.codigo AS VARCHAR(10)) AS' +
        ' cc_codigo,'
      'b.codigo AS cod_fk_bairro, b.nome AS bairro '
      'FROM rua r '
      'JOIN bairro b ON r.cod_fk_bairro = b.codigo '
      'WHERE 1=2'
      'ORDER BY r.nome')
    object zqrySelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zqrySelecionarRegistroNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zqrySelecionarRegistroCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object zqrySelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object zqrySelecionarRegistroCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
      Required = True
    end
    object zqrySelecionarRegistroBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Required = True
      Size = 100
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
    object cdsSelecionarRegistroCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsSelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object cdsSelecionarRegistroCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
      Required = True
    end
    object cdsSelecionarRegistroBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Required = True
      Size = 100
    end
  end
end
