inherited frmSelecionaRegistroPessoaFisica: TfrmSelecionaRegistroPessoaFisica
  Left = 423
  Top = 282
  Caption = 'SELECIONAR PESSOA F'#205'SICA'
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
        Width = 292
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CPF'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IDENTIDADE'
        Title.Caption = 'Identidade'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_NASCIMENTO'
        Title.Caption = 'Data Nascimento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE_RESIDENCIAL'
        Title.Caption = 'Telefone Residencial'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE_COMERCIAL'
        Title.Caption = 'Telefone Comercial'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE_CELULAR'
        Title.Caption = 'Telefone Celular'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGLA_ESTADO'
        Title.Caption = 'Estado'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CIDADE'
        Title.Caption = 'Cidade'
        Width = 150
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
          'CPF'
          'Identidade'
          'Estado'
          'Cidade')
      end
    end
  end
  inherited zqrySelecionarRegistro: TZQuery
    SQL.Strings = (
      'SELECT'
      
        '  p.codigo,p.nome,p.cpf,p.identidade,p.data_nascimento,p.telefon' +
        'e_residencial,'
      '  p.telefone_comercial,p.telefone_celular,'
      '  e.sigla as sigla_estado,'
      '  c.nome as nome_cidade,'
      '  CAST(p.codigo AS VARCHAR(10))AS cc_codigo'
      'FROM pessoa_fisica p'
      'JOIN estado e ON p.cod_fk_estado=e.codigo'
      'JOIN cidade c ON p.cod_fk_cidade=c.codigo')
    UpdateMode = umUpdateAll
    object zqrySelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zqrySelecionarRegistroNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zqrySelecionarRegistroCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object zqrySelecionarRegistroIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object zqrySelecionarRegistroDATA_NASCIMENTO: TDateTimeField
      FieldName = 'DATA_NASCIMENTO'
    end
    object zqrySelecionarRegistroTELEFONE_RESIDENCIAL: TStringField
      FieldName = 'TELEFONE_RESIDENCIAL'
      Size = 13
    end
    object zqrySelecionarRegistroTELEFONE_COMERCIAL: TStringField
      FieldName = 'TELEFONE_COMERCIAL'
      Size = 13
    end
    object zqrySelecionarRegistroTELEFONE_CELULAR: TStringField
      FieldName = 'TELEFONE_CELULAR'
      Size = 13
    end
    object zqrySelecionarRegistroSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object zqrySelecionarRegistroNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
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
    object cdsSelecionarRegistroCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object cdsSelecionarRegistroIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object cdsSelecionarRegistroDATA_NASCIMENTO: TDateTimeField
      FieldName = 'DATA_NASCIMENTO'
    end
    object cdsSelecionarRegistroTELEFONE_RESIDENCIAL: TStringField
      FieldName = 'TELEFONE_RESIDENCIAL'
      Size = 13
    end
    object cdsSelecionarRegistroTELEFONE_COMERCIAL: TStringField
      FieldName = 'TELEFONE_COMERCIAL'
      Size = 13
    end
    object cdsSelecionarRegistroTELEFONE_CELULAR: TStringField
      FieldName = 'TELEFONE_CELULAR'
      Size = 13
    end
    object cdsSelecionarRegistroSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object cdsSelecionarRegistroNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object cdsSelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
  end
end
