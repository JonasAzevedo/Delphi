inherited frmSelecionaRegistroEstado: TfrmSelecionaRegistroEstado
  Left = 506
  Top = 211
  Caption = 'SELECIONAR ESTADO'
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
        Width = 404
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGLA'
        Title.Caption = 'Sigla'
        Width = 55
        Visible = True
      end>
  end
  inherited pnlTopo: TPanel
    inherited grpBxPesquisar: TGroupBox
      Width = 556
      inherited plsEdValorPesquisar: TPlsEdit
        Width = 404
        MaxLength = 100
        OnChange = plsEdValorPesquisarChange
      end
      inherited plsCbBxCampoPesquisar: TPlsComboBox
        Items.Strings = (
          'C'#243'digo'
          'Nome'
          'Sigla')
      end
    end
    inherited btBtnNovo: TBitBtn
      Visible = False
    end
  end
  inherited zqrySelecionarRegistro: TZQuery
    SQL.Strings = (
      
        'SELECT codigo, nome, sigla, CAST(codigo AS VARCHAR(10))AS cc_cod' +
        'igo'
      'FROM estado '
      'ORDER BY nome')
    object zqrySelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zqrySelecionarRegistroNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
    object zqrySelecionarRegistroSIGLA: TStringField
      FieldName = 'SIGLA'
      Required = True
      Size = 2
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
      Size = 50
    end
    object cdsSelecionarRegistroSIGLA: TStringField
      FieldName = 'SIGLA'
      Required = True
      Size = 2
    end
    object cdsSelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
  end
end
