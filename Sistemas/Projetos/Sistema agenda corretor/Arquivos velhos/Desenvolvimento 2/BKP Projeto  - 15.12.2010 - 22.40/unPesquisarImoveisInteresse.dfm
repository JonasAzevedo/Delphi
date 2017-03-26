inherited frmPesquisarImoveisInteresse: TfrmPesquisarImoveisInteresse
  Left = 410
  Top = 190
  Caption = 'PESQUISAR POR IM'#211'VEIS DE INTERESSE'
  ClientWidth = 668
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited grpBxFiltroPesquisar: TGroupBox
    Width = 668
    Height = 126
    object lblCodigo: TLabel
      Left = 10
      Top = 44
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object lblFinalidade: TLabel
      Left = 332
      Top = 22
      Width = 51
      Height = 13
      Caption = 'Finalidade:'
    end
    object lblSituacao: TLabel
      Left = 487
      Top = 22
      Width = 45
      Height = 13
      Caption = 'Situa'#231#227'o:'
    end
    object lblCondicaoPagamento: TLabel
      Left = 10
      Top = 76
      Width = 120
      Height = 13
      Caption = 'Condi'#231#227'o de Pagamento:'
    end
    object plsEdCodigo: TPlsEdit
      Left = 54
      Top = 38
      Width = 66
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object plsCbBxFinalidade: TPlsComboBox
      Left = 332
      Top = 38
      Width = 141
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        'MORAR'
        'INVESTIR')
      plsCorRecebeFoco = clSilver
    end
    object plsCbBxSituacao: TPlsComboBox
      Left = 487
      Top = 38
      Width = 173
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        'PLANTA'
        'PRONTO PARA MORAR'
        'DE TERCEIROS')
      plsCorRecebeFoco = clSilver
    end
    object plsCbBxCondicaoPagamento: TPlsComboBox
      Left = 10
      Top = 93
      Width = 148
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        'VISTA'
        'ACEITA FINANCIAMENTO')
      plsCorRecebeFoco = clSilver
    end
    object grpBxDataCaptacao: TGroupBox
      Left = 128
      Top = 13
      Width = 193
      Height = 49
      Caption = 'Data da Capta'#231#227'o '
      TabOrder = 1
      object lblEntreDataCaptacao: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedDataCaptacaoInicio: TPlsMaskEdit
        Left = 5
        Top = 20
        Width = 72
        Height = 21
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
        plsCorRecebeFoco = clSilver
      end
      object plsMedDataCaptacaoFinal: TPlsMaskEdit
        Left = 113
        Top = 20
        Width = 73
        Height = 21
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        plsCorRecebeFoco = clSilver
      end
    end
    object grpBxValorImovel: TGroupBox
      Left = 167
      Top = 66
      Width = 193
      Height = 49
      Caption = 'Valor Total '
      TabOrder = 5
      object lblEntreValorImovel: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsEdValorImovelInicio: TPlsEdit
        Left = 5
        Top = 20
        Width = 72
        Height = 21
        TabOrder = 0
        Text = 'plsEdValorImovelInicio'
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario
      end
      object plsEdValorImovelFim: TPlsEdit
        Left = 113
        Top = 20
        Width = 73
        Height = 21
        TabOrder = 1
        Text = 'plsEdValorImovelFim'
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario
      end
    end
  end
  inherited dbGrdDadosPesquisa: TDBGrid
    Top = 126
    Width = 668
    Height = 305
    Columns = <
      item
        Expanded = False
        FieldName = 'ATIVO'
        Title.Caption = 'Ativo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_CAPTACAO'
        Title.Caption = 'Data Capta'#231#227'o'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_BAIXA'
        Title.Caption = 'Data Baixa'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CLIENTE'
        Title.Caption = 'Cliente'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_TIPO_IMOVEL'
        Title.Caption = 'Tipo do Im'#243'vel'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FINALIDADE_IMOVEL'
        Title.Caption = 'Finalidade'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IMOVEL_DESEJAVEL'
        Title.Caption = 'Desej'#225'vel'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_IMOVEL'
        Title.Caption = 'Valor Im'#243'vel'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONDICAO_PAGAMENTO'
        Title.Caption = 'Condi'#231#227'o Pagamento'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_VISTA_CACH'
        Title.Caption = 'Vista Cach'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_VISTA_VALOR_BEM'
        Title.Caption = 'Vista Valor Bem'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PGTO_VISTA_DESCRICAO_BEM'
        Title.Caption = 'Vista Descri'#231#227'o Bem'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_FINCTO_CACH_FINANCIADO'
        Title.Caption = 'Fncto Cach Financiado'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_FINCTO_CACH'
        Title.Caption = 'Fncto Cach'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_FINCTO_VALOR_BEM'
        Title.Caption = 'Fncto Valor Bem'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PGTO_FINCTO_DESCRICAO_BEM'
        Title.Caption = 'Fncto Descri'#231#227'o Bem'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_RENDIMENTO'
        Title.Caption = 'Rendimento'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBSERVACAO'
        Title.Caption = 'Observa'#231#227'o'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CARACTERISTICAS'
        Title.Caption = 'Caracter'#237'sticas'
        Width = 120
        Visible = True
      end>
  end
  inherited pnlBotoes: TPanel
    Width = 668
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT'
      '  i.codigo AS CODIGO_IMOVEL_INTERESSE,i.ativo,i.data_captacao,'
      '  i.finalidade_imovel,i.imovel_desejavel,'
      
        '  CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL,i.condi' +
        'cao_pagamento,'
      '  CAST(i.pgto_vista_cach AS VARCHAR(20)) AS CC_PGTO_VISTA_CACH,'
      
        '  CAST(i.pgto_vista_valor_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_V' +
        'ALOR_BEM,'
      '  i.pgto_vista_descricao_bem,'
      
        '  CAST(i.pgto_fincto_cach_financiado AS VARCHAR(20)) AS CC_PGTO_' +
        'FINCTO_CACH_FINANCIADO,'
      
        '  CAST(i.pgto_fincto_cach AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH' +
        ','
      
        '  CAST(i.pgto_fincto_valor_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO' +
        '_VALOR_BEM,'
      '  i.pgto_fincto_descricao_bem,'
      '  CAST(i.rendimento AS VARCHAR(20)) AS CC_RENDIMENTO,'
      '  i.observacao,i.data_baixa,i.caracteristicas,'
      '  c.nome AS NOME_CLIENTE,'
      '  t.nome AS NOME_TIPO_IMOVEL'
      'FROM imovel_de_interesse i'
      'JOIN cliente c ON i.cod_fk_cliente = c.codigo'
      'JOIN tipo_imovel t ON i.cod_fk_tipo_imovel = t.codigo'
      'ORDER BY i.codigo')
    object zQryDadosCODIGO_IMOVEL_INTERESSE: TIntegerField
      FieldName = 'CODIGO_IMOVEL_INTERESSE'
      Required = True
    end
    object zQryDadosATIVO: TStringField
      FieldName = 'ATIVO'
      Size = 3
    end
    object zQryDadosDATA_CAPTACAO: TDateField
      FieldName = 'DATA_CAPTACAO'
    end
    object zQryDadosFINALIDADE_IMOVEL: TStringField
      FieldName = 'FINALIDADE_IMOVEL'
      Size = 10
    end
    object zQryDadosIMOVEL_DESEJAVEL: TStringField
      FieldName = 'IMOVEL_DESEJAVEL'
    end
    object zQryDadosCC_VALOR_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL'
    end
    object zQryDadosCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryDadosCC_PGTO_VISTA_CACH: TStringField
      FieldName = 'CC_PGTO_VISTA_CACH'
    end
    object zQryDadosCC_PGTO_VISTA_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_VALOR_BEM'
    end
    object zQryDadosPGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_VISTA_DESCRICAO_BEM'
      Size = 500
    end
    object zQryDadosCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH_FINANCIADO'
    end
    object zQryDadosCC_PGTO_FINCTO_CACH: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH'
    end
    object zQryDadosCC_PGTO_FINCTO_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_VALOR_BEM'
    end
    object zQryDadosPGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_FINCTO_DESCRICAO_BEM'
      Size = 500
    end
    object zQryDadosCC_RENDIMENTO: TStringField
      FieldName = 'CC_RENDIMENTO'
    end
    object zQryDadosOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object zQryDadosDATA_BAIXA: TDateTimeField
      FieldName = 'DATA_BAIXA'
    end
    object zQryDadosCARACTERISTICAS: TStringField
      FieldName = 'CARACTERISTICAS'
      Size = 500
    end
    object zQryDadosNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Required = True
      Size = 100
    end
    object zQryDadosNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
  end
  inherited cdsDados: TClientDataSet
    object cdsDadosCODIGO_IMOVEL_INTERESSE: TIntegerField
      FieldName = 'CODIGO_IMOVEL_INTERESSE'
      Required = True
    end
    object cdsDadosATIVO: TStringField
      FieldName = 'ATIVO'
      Size = 3
    end
    object cdsDadosDATA_CAPTACAO: TDateField
      FieldName = 'DATA_CAPTACAO'
    end
    object cdsDadosFINALIDADE_IMOVEL: TStringField
      FieldName = 'FINALIDADE_IMOVEL'
      Size = 10
    end
    object cdsDadosIMOVEL_DESEJAVEL: TStringField
      FieldName = 'IMOVEL_DESEJAVEL'
    end
    object cdsDadosCC_VALOR_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL'
    end
    object cdsDadosCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object cdsDadosCC_PGTO_VISTA_CACH: TStringField
      FieldName = 'CC_PGTO_VISTA_CACH'
    end
    object cdsDadosCC_PGTO_VISTA_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_VALOR_BEM'
    end
    object cdsDadosPGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_VISTA_DESCRICAO_BEM'
      Size = 500
    end
    object cdsDadosCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH_FINANCIADO'
    end
    object cdsDadosCC_PGTO_FINCTO_CACH: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH'
    end
    object cdsDadosCC_PGTO_FINCTO_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_VALOR_BEM'
    end
    object cdsDadosPGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_FINCTO_DESCRICAO_BEM'
      Size = 500
    end
    object cdsDadosCC_RENDIMENTO: TStringField
      FieldName = 'CC_RENDIMENTO'
    end
    object cdsDadosOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object cdsDadosDATA_BAIXA: TDateTimeField
      FieldName = 'DATA_BAIXA'
    end
    object cdsDadosCARACTERISTICAS: TStringField
      FieldName = 'CARACTERISTICAS'
      Size = 500
    end
    object cdsDadosNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Required = True
      Size = 100
    end
    object cdsDadosNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
  end
end
