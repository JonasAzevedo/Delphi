inherited frmLocalizarCliente: TfrmLocalizarCliente
  Left = 506
  Top = 175
  Caption = 'Localizar Cliente'
  ClientWidth = 1084
  Constraints.MinHeight = 500
  Constraints.MinWidth = 1100
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited grpBxPesquisar: TGroupBox
    Width = 1084
    inherited cbBxCampoLocalizar: TPlsComboBox
      Left = 4
      Top = 16
      Width = 201
      OnChange = cbBxCampoLocalizarChange
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        'CPF'
        'Identidade'
        'CNPJ')
      plsCorRecebeFoco = clSilver
    end
    inherited edLocalizar: TPlsEdit
      Left = 209
      Top = 16
      Width = 869
      Anchors = [akLeft, akTop, akRight]
      plsCorRecebeFoco = clSilver
    end
  end
  inherited pnlDados: TPanel
    Width = 1084
    inherited grDados: TDBGrid
      Width = 1084
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 42
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Caption = 'Nome'
          Width = 362
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
          Width = 99
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CNPJ'
          Width = 115
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TELEFONE_1'
          Title.Caption = 'Telefone 1'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TELEFONE_2'
          Title.Caption = 'Telefone 2'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL'
          Title.Caption = 'Email'
          Width = 180
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_NASCIMENTO'
          Title.Caption = 'Data Nascimento'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PROFISSAO'
          Title.Caption = 'Profiss'#227'o'
          Width = 154
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESTADO'
          Title.Caption = 'UF'
          Width = 37
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CIDADE'
          Title.Caption = 'Cidade'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BAIRRO'
          Title.Caption = 'Bairro'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RUA'
          Title.Caption = 'Rua'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMERO'
          Title.Caption = 'N'#186
          Width = 38
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CEP'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COMPLEMENTO'
          Title.Caption = 'Complemento'
          Width = 250
          Visible = True
        end>
    end
  end
  inherited StatusBar: TStatusBar
    Width = 1084
    Panels = <
      item
        Width = 900
      end
      item
        Width = 800
      end>
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT c.*, CAST(c.codigo AS VARCHAR(10)) AS cc_codigo '
      'FROM cliente c  '
      'WHERE 1=2'
      'ORDER BY c.nome')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
    object zQryDadosCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object zQryDadosIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object zQryDadosCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 18
    end
    object zQryDadosDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object zQryDadosPROFISSAO: TStringField
      FieldName = 'PROFISSAO'
      Size = 100
    end
    object zQryDadosEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object zQryDadosTELEFONE_1: TStringField
      FieldName = 'TELEFONE_1'
      Size = 13
    end
    object zQryDadosTELEFONE_2: TStringField
      FieldName = 'TELEFONE_2'
      Size = 13
    end
    object zQryDadosESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object zQryDadosCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object zQryDadosBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object zQryDadosRUA: TStringField
      FieldName = 'RUA'
      Size = 100
    end
    object zQryDadosNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
    object zQryDadosCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object zQryDadosCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 200
    end
    object zQryDadosCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
  end
  inherited cdsDados: TClientDataSet
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
    object cdsDadosCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object cdsDadosIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object cdsDadosCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 18
    end
    object cdsDadosDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object cdsDadosPROFISSAO: TStringField
      FieldName = 'PROFISSAO'
      Size = 100
    end
    object cdsDadosEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object cdsDadosTELEFONE_1: TStringField
      FieldName = 'TELEFONE_1'
      Size = 13
    end
    object cdsDadosTELEFONE_2: TStringField
      FieldName = 'TELEFONE_2'
      Size = 13
    end
    object cdsDadosESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 2
    end
    object cdsDadosCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 100
    end
    object cdsDadosBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 100
    end
    object cdsDadosRUA: TStringField
      FieldName = 'RUA'
      Size = 100
    end
    object cdsDadosNUMERO: TIntegerField
      FieldName = 'NUMERO'
    end
    object cdsDadosCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsDadosCOMPLEMENTO: TStringField
      FieldName = 'COMPLEMENTO'
      Size = 200
    end
    object cdsDadosCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
  end
end
