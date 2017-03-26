inherited frmSelecionaRegistroCidade: TfrmSelecionaRegistroCidade
  Left = 478
  Caption = 'SELECIONAR CIDADE'
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
        Title.Caption = 'Cidade'
        Width = 394
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGLA'
        Title.Caption = 'UF'
        Width = 63
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
      
        'SELECT c.codigo, c.nome, CAST(c.codigo AS VARCHAR(10)) AS cc_cod' +
        'igo,e.codigo AS cod_fk_estado,e.sigla  '
      'FROM cidade c'
      'JOIN estado e ON c.cod_fk_estado = e.codigo')
    object zqrySelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zqrySelecionarRegistroNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
    object zqrySelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object zqrySelecionarRegistroCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
      Required = True
    end
    object zqrySelecionarRegistroSIGLA: TStringField
      FieldName = 'SIGLA'
      Required = True
      Size = 2
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
      Size = 100
    end
    object cdsSelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object cdsSelecionarRegistroCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
      Required = True
    end
    object cdsSelecionarRegistroSIGLA: TStringField
      FieldName = 'SIGLA'
      Required = True
      Size = 2
    end
  end
end
