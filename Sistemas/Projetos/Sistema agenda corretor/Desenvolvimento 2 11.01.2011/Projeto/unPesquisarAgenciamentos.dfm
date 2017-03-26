inherited frmPesquisarAgenciamentos: TfrmPesquisarAgenciamentos
  Left = 226
  Top = 78
  Caption = 'PESQUISAR POR AGENCIAMENTOS'
  ClientWidth = 810
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited grpBxFiltroPesquisar: TGroupBox
    Width = 810
    Height = 126
    object lblCodigo: TLabel
      Left = 10
      Top = 44
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object lblCondicaoPagamento: TLabel
      Left = 553
      Top = 23
      Width = 120
      Height = 13
      Caption = 'Condi'#231#227'o de Pagamento:'
    end
    object lblStatus: TLabel
      Left = 125
      Top = 21
      Width = 33
      Height = 13
      Caption = 'Status:'
    end
    object rdGrpTipoAgenciamento: TRadioGroup
      Left = 388
      Top = 20
      Width = 156
      Height = 40
      Caption = 'Tipo Agenciamento * '
      Columns = 2
      Items.Strings = (
        'Normal'
        'Stand By')
      TabOrder = 3
    end
    object rdGrpTipoPessoa: TRadioGroup
      Left = 234
      Top = 20
      Width = 146
      Height = 40
      Caption = 'Tipo Pessoa * '
      Columns = 2
      Items.Strings = (
        'F'#237'sica'
        'Jur'#237'dica')
      TabOrder = 2
    end
    object plsCbBxCondicaoPagamento: TPlsComboBox
      Left = 553
      Top = 39
      Width = 193
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        'VISTA'
        'ACEITA FINANCIAMENTO')
      plsCorRecebeFoco = clSilver
    end
    object plsEdCodigo: TPlsEdit
      Left = 51
      Top = 39
      Width = 66
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object grpBxDataAgenciamento: TGroupBox
      Left = 8
      Top = 66
      Width = 193
      Height = 49
      Caption = 'Data do Agenciamento '
      TabOrder = 5
      object lblEntreDataAgenciamento: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedDataAgencInicio: TPlsMaskEdit
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
      object plsMedDataAgencFinal: TPlsMaskEdit
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
    object grpBxDataBaixa: TGroupBox
      Left = 407
      Top = 66
      Width = 193
      Height = 49
      Caption = 'Data da Baixa '
      TabOrder = 7
      object lblEntreDataBaixa: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedDataBaixaInicio: TPlsMaskEdit
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
      object plsMedDataBaixaFim: TPlsMaskEdit
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
    object grpBxPrazoAutorizacao: TGroupBox
      Left = 208
      Top = 66
      Width = 193
      Height = 49
      Caption = 'Prazo Autoriza'#231#227'o'
      TabOrder = 6
      object lblEntrePrazoAutorizacao: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedPrazoAutorizacaoInicio: TPlsMaskEdit
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
      object plsMedPrazoAutorizacaoFim: TPlsMaskEdit
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
    object grpBxValorTotal: TGroupBox
      Left = 607
      Top = 66
      Width = 193
      Height = 49
      Caption = 'Valor Total '
      TabOrder = 8
      object lblEntreValorTotal: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedValorTotalInicio: TPlsEdit
        Left = 5
        Top = 20
        Width = 72
        Height = 21
        TabOrder = 0
        Text = 'plsEdValorTotal'
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario
      end
      object plsMedValorTotalFim: TPlsEdit
        Left = 113
        Top = 20
        Width = 73
        Height = 21
        TabOrder = 1
        Text = 'plsEdValorTotal'
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario
      end
    end
    object plsCbBxStatus: TPlsComboBox
      Left = 125
      Top = 39
      Width = 101
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'ATIVO'
      Items.Strings = (
        'ATIVO'
        'INATIVO'
        'TODOS')
      plsCorRecebeFoco = clSilver
    end
  end
  inherited dbGrdDadosPesquisa: TDBGrid
    Top = 126
    Width = 810
    Height = 305
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO_AGENCIAMENTO'
        Title.Caption = 'C'#243'digo'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_AGENCIAMENTO'
        Title.Caption = 'Data Agenciamento'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRAZO_AUTORIZACAO'
        Title.Caption = 'Prazo Autoriza'#231#227'o'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_REAGENCIAMENTO'
        Title.Caption = 'Data Reagenciamento'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_BAIXA'
        Title.Caption = 'Data Baixa'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATIVO_AGENCIAMENTO'
        Title.Caption = 'Ativo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NORMAL_STANDBY'
        Title.Caption = 'Normal/Stand By'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_PESSOA'
        Title.Caption = 'Tipo Pessoa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_TIPO_PESSOA'
        Title.Caption = 'Nome Pessoa'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONDICAO_PAGAMENTO'
        Title.Caption = 'Condi'#231#227'o Pagamento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_TOTAL_AGENCIAMENTO'
        Title.Caption = 'Valor Total'
        Width = 75
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
        FieldName = 'CC_PGTO_VISTA_DESCRICAO_BEM'
        Title.Caption = 'Descri'#231#227'o Bem'
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
        FieldName = 'CC_PGTO_FINCTO_DESCRICAO_BEM'
        Title.Caption = 'Fncto Descri'#231#227'o Bem'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SITUACAO_DESEJAVEL'
        Title.Caption = 'Situa'#231#227'o Desej'#225'vel'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_IMOVEL_IMOVEL'
        Title.Caption = 'Valor do Im'#243'vel'
        Width = 76
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
        FieldName = 'SIGLA_ESTADO'
        Title.Caption = 'UF'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CIDADE'
        Title.Caption = 'Cidade'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_BAIRRO'
        Title.Caption = 'Bairro'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_RUA'
        Title.Caption = 'Rua'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP_RUA'
        Title.Caption = 'CEP'
        Width = 60
        Visible = True
      end>
  end
  inherited pnlBotoes: TPanel
    Width = 810
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT'
      
        '  a.codigo AS CODIGO_AGENCIAMENTO,a.data_agenciamento,a.ativo AS' +
        ' ATIVO_AGENCIAMENTO,'
      '  CAST(a.codigo AS VARCHAR(10)) AS cc_codigo,'
      '  a.normal,a.stand_by,'
      '  CASE'
      '    WHEN a.normal = '#39'SIM'#39' THEN'
      '      '#39'NORMAL'#39
      '    ELSE'
      '      '#39'STAND BY'#39
      '  END AS NORMAL_STANDBY,'
      '  a.tipo_pessoa,'
      '  CASE'
      '    WHEN a.tipo_pessoa = '#39'F'#205'SICA'#39' THEN'
      '       pf.nome'
      '    WHEN a.tipo_pessoa = '#39'JUR'#205'DICA'#39' THEN'
      '       pj.nome'
      '    ELSE'
      '      '#39'NENHUMA'#39
      '  END AS NOME_TIPO_PESSOA,'
      '  a.condicao_pagamento,'
      
        'CAST(a.valor_total  AS VARCHAR(20)) AS CC_VALOR_TOTAL_AGENCIAMEN' +
        'TO,'
      'CAST(a.pgto_vista_cach AS VARCHAR(20)) AS CC_PGTO_VISTA_CACH, '
      
        'CAST(a.pgto_vista_valor_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_VAL' +
        'OR_BEM,'
      
        'CAST(a.pgto_vista_descricao_bem AS VARCHAR(20)) AS CC_PGTO_VISTA' +
        '_DESCRICAO_BEM,'
      
        'CAST(a.pgto_fincto_cach_financiado AS VARCHAR(20)) AS CC_PGTO_FI' +
        'NCTO_CACH_FINANCIADO,'
      'CAST(a.pgto_fincto_cach AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH,'
      
        'CAST(a.pgto_fincto_valor_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_V' +
        'ALOR_BEM,'
      
        'CAST(a.pgto_fincto_descricao_bem AS VARCHAR(20)) AS CC_PGTO_FINC' +
        'TO_DESCRICAO_BEM,'
      
        '  a.observacao AS OBSERVACAO_AGENCIAMENTO,a.prazo_autorizacao,a.' +
        'data_reagenciamento,a.data_baixa,'
      
        '  pf.codigo AS CODIGO_PESSOA_FISICA,pf.nome AS NOME_PESSOA_FISIC' +
        'A,'
      
        '  pj.codigo AS CODIGO_PESSOA_JURIDICA,pj.nome AS NOME_PESSOA_JUR' +
        'IDICA,'
      
        '  i.codigo AS CODIGO_IMOVEL,i.status AS STATUS_IMOVEL,i.situacao' +
        '_desejavel,'
      'CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL_IMOVEL,'
      'i.descricao AS DESCRICAO_IMOVEL,'
      '  ti.codigo AS CODIGO_TIPO_IMOVEL,ti.nome AS NOME_TIPO_IMOVEL,'
      '  est.codigo AS CODIGO_ESTADO,est.sigla AS SIGLA_ESTADO,'
      '  cid.codigo AS CODIGO_CIDADE,cid.nome AS NOME_CIDADE,'
      '  bai.codigo AS CODIGO_BAIRRO,bai.nome AS NOME_BAIRRO,'
      
        '  rua.codigo AS CODIGO_RUA,rua.nome AS NOME_RUA,rua.cep AS CEP_R' +
        'UA'
      'FROM agenciamentos a'
      
        'LEFT JOIN agenc_pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.' +
        'codigo'
      
        'LEFT JOIN agenc_pessoa_juridica pj ON a.cod_fk_pessoa_juridica =' +
        ' pj.codigo'
      'JOIN imovel i ON a.cod_fk_imovel = i.codigo'
      'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo'
      'JOIN estado est ON i.cod_fk_estado = est.codigo'
      'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo'
      'JOIN bairro bai ON i.cod_fk_bairro = bai.codigo'
      'JOIN rua rua ON i.cod_fk_rua = rua.codigo'
      'ORDER BY a.codigo')
    Top = 168
    object zQryDadosCODIGO_AGENCIAMENTO: TIntegerField
      FieldName = 'CODIGO_AGENCIAMENTO'
      Required = True
    end
    object zQryDadosDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
    end
    object zQryDadosATIVO_AGENCIAMENTO: TStringField
      FieldName = 'ATIVO_AGENCIAMENTO'
      Size = 3
    end
    object zQryDadosCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object zQryDadosNORMAL: TStringField
      FieldName = 'NORMAL'
      Size = 5
    end
    object zQryDadosSTAND_BY: TStringField
      FieldName = 'STAND_BY'
      Size = 5
    end
    object zQryDadosNORMAL_STANDBY: TStringField
      FieldName = 'NORMAL_STANDBY'
      ReadOnly = True
      Size = 8
    end
    object zQryDadosTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryDadosNOME_TIPO_PESSOA: TStringField
      FieldName = 'NOME_TIPO_PESSOA'
      ReadOnly = True
      Size = 100
    end
    object zQryDadosCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryDadosCC_VALOR_TOTAL_AGENCIAMENTO: TStringField
      FieldName = 'CC_VALOR_TOTAL_AGENCIAMENTO'
    end
    object zQryDadosCC_PGTO_VISTA_CACH: TStringField
      FieldName = 'CC_PGTO_VISTA_CACH'
    end
    object zQryDadosCC_PGTO_VISTA_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_VALOR_BEM'
    end
    object zQryDadosCC_PGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_DESCRICAO_BEM'
      ReadOnly = True
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
    object zQryDadosCC_PGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_DESCRICAO_BEM'
      ReadOnly = True
    end
    object zQryDadosOBSERVACAO_AGENCIAMENTO: TStringField
      FieldName = 'OBSERVACAO_AGENCIAMENTO'
      Size = 500
    end
    object zQryDadosPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object zQryDadosDATA_REAGENCIAMENTO: TDateField
      FieldName = 'DATA_REAGENCIAMENTO'
    end
    object zQryDadosDATA_BAIXA: TDateField
      FieldName = 'DATA_BAIXA'
    end
    object zQryDadosCODIGO_PESSOA_FISICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_FISICA'
      Required = True
    end
    object zQryDadosNOME_PESSOA_FISICA: TStringField
      FieldName = 'NOME_PESSOA_FISICA'
      Size = 100
    end
    object zQryDadosCODIGO_PESSOA_JURIDICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_JURIDICA'
      Required = True
    end
    object zQryDadosNOME_PESSOA_JURIDICA: TStringField
      FieldName = 'NOME_PESSOA_JURIDICA'
      Size = 100
    end
    object zQryDadosCODIGO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_IMOVEL'
      Required = True
    end
    object zQryDadosSTATUS_IMOVEL: TSmallintField
      FieldName = 'STATUS_IMOVEL'
    end
    object zQryDadosSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zQryDadosCC_VALOR_IMOVEL_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL_IMOVEL'
    end
    object zQryDadosDESCRICAO_IMOVEL: TStringField
      FieldName = 'DESCRICAO_IMOVEL'
      Size = 500
    end
    object zQryDadosCODIGO_TIPO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_TIPO_IMOVEL'
      Required = True
    end
    object zQryDadosNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object zQryDadosCODIGO_ESTADO: TIntegerField
      FieldName = 'CODIGO_ESTADO'
      Required = True
    end
    object zQryDadosSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object zQryDadosCODIGO_CIDADE: TIntegerField
      FieldName = 'CODIGO_CIDADE'
      Required = True
    end
    object zQryDadosNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object zQryDadosCODIGO_BAIRRO: TIntegerField
      FieldName = 'CODIGO_BAIRRO'
      Required = True
    end
    object zQryDadosNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
      Required = True
      Size = 100
    end
    object zQryDadosCODIGO_RUA: TIntegerField
      FieldName = 'CODIGO_RUA'
      Required = True
    end
    object zQryDadosNOME_RUA: TStringField
      FieldName = 'NOME_RUA'
      Required = True
      Size = 100
    end
    object zQryDadosCEP_RUA: TStringField
      FieldName = 'CEP_RUA'
      Size = 9
    end
  end
  inherited dspDados: TDataSetProvider
    Top = 168
  end
  inherited cdsDados: TClientDataSet
    Top = 168
    object cdsDadosCODIGO_AGENCIAMENTO: TIntegerField
      FieldName = 'CODIGO_AGENCIAMENTO'
      Required = True
    end
    object cdsDadosDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
    end
    object cdsDadosATIVO_AGENCIAMENTO: TStringField
      FieldName = 'ATIVO_AGENCIAMENTO'
      Size = 3
    end
    object cdsDadosCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object cdsDadosNORMAL: TStringField
      FieldName = 'NORMAL'
      Size = 5
    end
    object cdsDadosSTAND_BY: TStringField
      FieldName = 'STAND_BY'
      Size = 5
    end
    object cdsDadosNORMAL_STANDBY: TStringField
      FieldName = 'NORMAL_STANDBY'
      ReadOnly = True
      Size = 8
    end
    object cdsDadosTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object cdsDadosNOME_TIPO_PESSOA: TStringField
      FieldName = 'NOME_TIPO_PESSOA'
      ReadOnly = True
      Size = 100
    end
    object cdsDadosCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object cdsDadosCC_VALOR_TOTAL_AGENCIAMENTO: TStringField
      FieldName = 'CC_VALOR_TOTAL_AGENCIAMENTO'
    end
    object cdsDadosCC_PGTO_VISTA_CACH: TStringField
      FieldName = 'CC_PGTO_VISTA_CACH'
    end
    object cdsDadosCC_PGTO_VISTA_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_VALOR_BEM'
    end
    object cdsDadosCC_PGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_DESCRICAO_BEM'
      ReadOnly = True
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
    object cdsDadosCC_PGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_DESCRICAO_BEM'
      ReadOnly = True
    end
    object cdsDadosOBSERVACAO_AGENCIAMENTO: TStringField
      FieldName = 'OBSERVACAO_AGENCIAMENTO'
      Size = 500
    end
    object cdsDadosPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object cdsDadosDATA_REAGENCIAMENTO: TDateField
      FieldName = 'DATA_REAGENCIAMENTO'
    end
    object cdsDadosDATA_BAIXA: TDateField
      FieldName = 'DATA_BAIXA'
    end
    object cdsDadosCODIGO_PESSOA_FISICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_FISICA'
      Required = True
    end
    object cdsDadosNOME_PESSOA_FISICA: TStringField
      FieldName = 'NOME_PESSOA_FISICA'
      Size = 100
    end
    object cdsDadosCODIGO_PESSOA_JURIDICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_JURIDICA'
      Required = True
    end
    object cdsDadosNOME_PESSOA_JURIDICA: TStringField
      FieldName = 'NOME_PESSOA_JURIDICA'
      Size = 100
    end
    object cdsDadosCODIGO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_IMOVEL'
      Required = True
    end
    object cdsDadosSTATUS_IMOVEL: TSmallintField
      FieldName = 'STATUS_IMOVEL'
    end
    object cdsDadosSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object cdsDadosCC_VALOR_IMOVEL_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL_IMOVEL'
    end
    object cdsDadosDESCRICAO_IMOVEL: TStringField
      FieldName = 'DESCRICAO_IMOVEL'
      Size = 500
    end
    object cdsDadosCODIGO_TIPO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_TIPO_IMOVEL'
      Required = True
    end
    object cdsDadosNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object cdsDadosCODIGO_ESTADO: TIntegerField
      FieldName = 'CODIGO_ESTADO'
      Required = True
    end
    object cdsDadosSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object cdsDadosCODIGO_CIDADE: TIntegerField
      FieldName = 'CODIGO_CIDADE'
      Required = True
    end
    object cdsDadosNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object cdsDadosCODIGO_BAIRRO: TIntegerField
      FieldName = 'CODIGO_BAIRRO'
      Required = True
    end
    object cdsDadosNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
      Required = True
      Size = 100
    end
    object cdsDadosCODIGO_RUA: TIntegerField
      FieldName = 'CODIGO_RUA'
      Required = True
    end
    object cdsDadosNOME_RUA: TStringField
      FieldName = 'NOME_RUA'
      Required = True
      Size = 100
    end
    object cdsDadosCEP_RUA: TStringField
      FieldName = 'CEP_RUA'
      Size = 9
    end
  end
  inherited dsDados: TDataSource
    Top = 168
  end
  inherited ppMnPopupMenu: TPopupMenu
    Top = 206
    object ppMnDarBaixa: TMenuItem [0]
      Caption = 'Dar Baixa...'
      OnClick = ppMnDarBaixaClick
    end
    object ppMnDivisao: TMenuItem [1]
      Caption = '-'
    end
  end
end
