inherited frmSelecionaRegistroCliente: TfrmSelecionaRegistroCliente
  Top = 302
  Caption = 'SELECIONAR PESSOA F'#205'SICA - CLIENTE'
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
        FieldName = 'EMAIL'
        Title.Caption = 'E-Mail'
        Width = 120
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
        FieldName = 'DATA_NASCIMENTO'
        Title.Caption = 'Data Nascimento'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_PROFISSAO'
        Title.Caption = 'Profiss'#227'o'
        Width = 120
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
        Width = 120
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
          'Profiss'#227'o'
          'Estado'
          'Cidade')
      end
    end
  end
  inherited zqrySelecionarRegistro: TZQuery
    SQL.Strings = (
      'SELECT'
      
        '  c.codigo,c.nome,c.email,c.telefone_residencial,c.telefone_come' +
        'rcial,'
      '  c.telefone_celular,c.cpf,c.identidade,c.data_nascimento,'
      '  p.nome as nome_profissao,'
      '  est.sigla as sigla_estado,'
      '  cid.nome as nome_cidade,'
      '  CAST(c.codigo AS VARCHAR(10))AS cc_codigo'
      'FROM cliente c'
      'JOIN profissao p ON c.cod_fk_profissao=p.codigo'
      'JOIN estado est ON c.cod_fk_estado=est.codigo'
      'JOIN cidade cid ON c.cod_fk_cidade=cid.codigo')
    object zqrySelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zqrySelecionarRegistroNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
    object zqrySelecionarRegistroEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
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
    object zqrySelecionarRegistroCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object zqrySelecionarRegistroIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object zqrySelecionarRegistroDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object zqrySelecionarRegistroNOME_PROFISSAO: TStringField
      FieldName = 'NOME_PROFISSAO'
      Size = 100
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
      Required = True
      Size = 100
    end
    object cdsSelecionarRegistroEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
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
    object cdsSelecionarRegistroCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object cdsSelecionarRegistroIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object cdsSelecionarRegistroDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object cdsSelecionarRegistroNOME_PROFISSAO: TStringField
      FieldName = 'NOME_PROFISSAO'
      Size = 100
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
