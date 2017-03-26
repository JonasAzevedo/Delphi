inherited frmSelecionaRegistroAgenciamento: TfrmSelecionaRegistroAgenciamento
  Left = 421
  Top = 182
  Caption = 'SELECIONAR AGENCIAMENTO'
  ClientWidth = 562
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbGrdDados: TDBGrid
    Width = 562
    PopupMenu = ppMnExibirDadosAgenciamento
    Columns = <
      item
        Expanded = False
        FieldName = 'PRAZO_AUTORIZACAO'
        Title.Caption = 'Prazo de Autoriza'#231#227'o'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_AGENCIAMENTO'
        Title.Caption = 'Data do Agenciamento'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_PESSOA'
        Title.Caption = 'Tipo Pessoa'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_TIPO_PESSOA'
        Title.Caption = 'Nome da Pessoa'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONDICAO_PAGAMENTO'
        Title.Caption = 'Condi'#231#227'o de Pagamento'
        Width = 135
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_TOTAL_AGENCIAMENTO'
        Title.Caption = 'Valor Total Agenciamento'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_IMOVEL_IMOVEL'
        Title.Caption = 'Valor do Im'#243'vel'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_TIPO_IMOVEL'
        Title.Caption = 'Tipo do Im'#243'vel'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SITUACAO_DESEJAVEL'
        Title.Caption = 'Situa'#231#227'o Desej'#225'vel'
        Width = 130
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
        Width = 100
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
        Width = 150
        Visible = True
      end>
  end
  inherited pnlTopo: TPanel
    Width = 562
    inherited grpBxPesquisar: TGroupBox
      Width = 561
      inherited plsEdValorPesquisar: TPlsEdit
        Width = 406
        OnChange = plsEdValorPesquisarChange
      end
      inherited plsCbBxCampoPesquisar: TPlsComboBox
        Items.Strings = (
          'C'#243'digo'
          'Tipo da Pessoa'
          'Nome da Pessoa'
          'Condi'#231#227'o de Pagamento'
          'Tipo do Im'#243'vel'
          'Situa'#231#227'o Desej'#225'vel'
          'Estado'
          'Cidade'
          'Bairro'
          'Rua')
      end
      object plsCbBxValorPesquisa: TPlsComboBox
        Left = 149
        Top = 14
        Width = 145
        Height = 21
        Style = csDropDownList
        CharCase = ecUpperCase
        ItemHeight = 13
        TabOrder = 2
        OnChange = plsCbBxValorPesquisaChange
        Items.Strings = (
          'PLANTA'
          'PRONTO PARA MORAR'
          'DE TERCEIROS')
        plsCorRecebeFoco = clSilver
      end
    end
    inherited btBtnNovo: TBitBtn
      Visible = False
    end
  end
  inherited dsSelecionarRegistro: TDataSource
    Left = 98
    Top = 79
  end
  inherited zqrySelecionarRegistro: TZQuery
    SQL.Strings = (
      'SELECT'
      
        '  a.codigo AS CODIGO_AGENCIAMENTO,a.data_agenciamento,a.ativo AS' +
        ' ATIVO_AGENCIAMENTO,'
      '  CAST(a.codigo AS VARCHAR(10)) AS cc_codigo,'
      '  CASE'
      '    WHEN a.normal = '#39'SIM'#39' THEN'
      '      '#39'NORMAL '#39
      '    ELSE'
      '      '#39'STAND BY '#39
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
        'data_reagenciamento,'
      
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
      'JOIN pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo'
      'JOIN pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo'
      'JOIN imovel i ON a.cod_fk_imovel = i.codigo'
      'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo'
      'JOIN estado est ON i.cod_fk_estado = est.codigo'
      'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo'
      'JOIN bairro bai ON i.cod_fk_bairro = bai.codigo'
      'JOIN rua rua ON i.cod_fk_rua = rua.codigo'
      ''
      ''
      'ORDER BY a.CODIGO')
    Left = 14
    Top = 79
    object zqrySelecionarRegistroCODIGO_AGENCIAMENTO: TIntegerField
      FieldName = 'CODIGO_AGENCIAMENTO'
      Required = True
    end
    object zqrySelecionarRegistroDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
    end
    object zqrySelecionarRegistroATIVO_AGENCIAMENTO: TStringField
      FieldName = 'ATIVO_AGENCIAMENTO'
      Size = 3
    end
    object zqrySelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object zqrySelecionarRegistroNORMAL_STANDBY: TStringField
      FieldName = 'NORMAL_STANDBY'
      ReadOnly = True
      Size = 9
    end
    object zqrySelecionarRegistroTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zqrySelecionarRegistroNOME_TIPO_PESSOA: TStringField
      FieldName = 'NOME_TIPO_PESSOA'
      ReadOnly = True
      Size = 100
    end
    object zqrySelecionarRegistroCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zqrySelecionarRegistroCC_VALOR_TOTAL_AGENCIAMENTO: TStringField
      FieldName = 'CC_VALOR_TOTAL_AGENCIAMENTO'
    end
    object zqrySelecionarRegistroCC_PGTO_VISTA_CACH: TStringField
      FieldName = 'CC_PGTO_VISTA_CACH'
    end
    object zqrySelecionarRegistroCC_PGTO_VISTA_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_VALOR_BEM'
    end
    object zqrySelecionarRegistroCC_PGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_DESCRICAO_BEM'
    end
    object zqrySelecionarRegistroCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH_FINANCIADO'
    end
    object zqrySelecionarRegistroCC_PGTO_FINCTO_CACH: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH'
    end
    object zqrySelecionarRegistroCC_PGTO_FINCTO_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_VALOR_BEM'
    end
    object zqrySelecionarRegistroCC_PGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_DESCRICAO_BEM'
    end
    object zqrySelecionarRegistroOBSERVACAO_AGENCIAMENTO: TStringField
      FieldName = 'OBSERVACAO_AGENCIAMENTO'
      Size = 500
    end
    object zqrySelecionarRegistroPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object zqrySelecionarRegistroDATA_REAGENCIAMENTO: TDateField
      FieldName = 'DATA_REAGENCIAMENTO'
    end
    object zqrySelecionarRegistroCODIGO_PESSOA_FISICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_FISICA'
      Required = True
    end
    object zqrySelecionarRegistroNOME_PESSOA_FISICA: TStringField
      FieldName = 'NOME_PESSOA_FISICA'
      Size = 100
    end
    object zqrySelecionarRegistroCODIGO_PESSOA_JURIDICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_JURIDICA'
      Required = True
    end
    object zqrySelecionarRegistroNOME_PESSOA_JURIDICA: TStringField
      FieldName = 'NOME_PESSOA_JURIDICA'
      Size = 100
    end
    object zqrySelecionarRegistroCODIGO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_IMOVEL'
      Required = True
    end
    object zqrySelecionarRegistroSTATUS_IMOVEL: TSmallintField
      FieldName = 'STATUS_IMOVEL'
    end
    object zqrySelecionarRegistroSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zqrySelecionarRegistroCC_VALOR_IMOVEL_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL_IMOVEL'
    end
    object zqrySelecionarRegistroDESCRICAO_IMOVEL: TStringField
      FieldName = 'DESCRICAO_IMOVEL'
      Size = 500
    end
    object zqrySelecionarRegistroCODIGO_TIPO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_TIPO_IMOVEL'
      Required = True
    end
    object zqrySelecionarRegistroNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object zqrySelecionarRegistroCODIGO_ESTADO: TIntegerField
      FieldName = 'CODIGO_ESTADO'
      Required = True
    end
    object zqrySelecionarRegistroSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object zqrySelecionarRegistroCODIGO_CIDADE: TIntegerField
      FieldName = 'CODIGO_CIDADE'
      Required = True
    end
    object zqrySelecionarRegistroNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object zqrySelecionarRegistroCODIGO_BAIRRO: TIntegerField
      FieldName = 'CODIGO_BAIRRO'
      Required = True
    end
    object zqrySelecionarRegistroNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
      Required = True
      Size = 100
    end
    object zqrySelecionarRegistroCODIGO_RUA: TIntegerField
      FieldName = 'CODIGO_RUA'
      Required = True
    end
    object zqrySelecionarRegistroNOME_RUA: TStringField
      FieldName = 'NOME_RUA'
      Required = True
      Size = 100
    end
    object zqrySelecionarRegistroCEP_RUA: TStringField
      FieldName = 'CEP_RUA'
      Size = 9
    end
  end
  inherited dspSelecionarRegistro: TDataSetProvider
    Left = 42
    Top = 79
  end
  inherited cdsSelecionarRegistro: TClientDataSet
    AfterScroll = cdsSelecionarRegistroAfterScroll
    Left = 70
    Top = 79
    object cdsSelecionarRegistroCODIGO_AGENCIAMENTO: TIntegerField
      FieldName = 'CODIGO_AGENCIAMENTO'
      Required = True
    end
    object cdsSelecionarRegistroDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
    end
    object cdsSelecionarRegistroATIVO_AGENCIAMENTO: TStringField
      FieldName = 'ATIVO_AGENCIAMENTO'
      Size = 3
    end
    object cdsSelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object cdsSelecionarRegistroNORMAL_STANDBY: TStringField
      FieldName = 'NORMAL_STANDBY'
      ReadOnly = True
      Size = 9
    end
    object cdsSelecionarRegistroTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object cdsSelecionarRegistroNOME_TIPO_PESSOA: TStringField
      FieldName = 'NOME_TIPO_PESSOA'
      ReadOnly = True
      Size = 100
    end
    object cdsSelecionarRegistroCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object cdsSelecionarRegistroCC_VALOR_TOTAL_AGENCIAMENTO: TStringField
      FieldName = 'CC_VALOR_TOTAL_AGENCIAMENTO'
    end
    object cdsSelecionarRegistroCC_PGTO_VISTA_CACH: TStringField
      FieldName = 'CC_PGTO_VISTA_CACH'
    end
    object cdsSelecionarRegistroCC_PGTO_VISTA_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_VALOR_BEM'
    end
    object cdsSelecionarRegistroCC_PGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_DESCRICAO_BEM'
    end
    object cdsSelecionarRegistroCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH_FINANCIADO'
    end
    object cdsSelecionarRegistroCC_PGTO_FINCTO_CACH: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH'
    end
    object cdsSelecionarRegistroCC_PGTO_FINCTO_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_VALOR_BEM'
    end
    object cdsSelecionarRegistroCC_PGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_DESCRICAO_BEM'
    end
    object cdsSelecionarRegistroOBSERVACAO_AGENCIAMENTO: TStringField
      FieldName = 'OBSERVACAO_AGENCIAMENTO'
      Size = 500
    end
    object cdsSelecionarRegistroPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object cdsSelecionarRegistroDATA_REAGENCIAMENTO: TDateField
      FieldName = 'DATA_REAGENCIAMENTO'
    end
    object cdsSelecionarRegistroCODIGO_PESSOA_FISICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_FISICA'
      Required = True
    end
    object cdsSelecionarRegistroNOME_PESSOA_FISICA: TStringField
      FieldName = 'NOME_PESSOA_FISICA'
      Size = 100
    end
    object cdsSelecionarRegistroCODIGO_PESSOA_JURIDICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_JURIDICA'
      Required = True
    end
    object cdsSelecionarRegistroNOME_PESSOA_JURIDICA: TStringField
      FieldName = 'NOME_PESSOA_JURIDICA'
      Size = 100
    end
    object cdsSelecionarRegistroCODIGO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_IMOVEL'
      Required = True
    end
    object cdsSelecionarRegistroSTATUS_IMOVEL: TSmallintField
      FieldName = 'STATUS_IMOVEL'
    end
    object cdsSelecionarRegistroSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object cdsSelecionarRegistroCC_VALOR_IMOVEL_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL_IMOVEL'
    end
    object cdsSelecionarRegistroDESCRICAO_IMOVEL: TStringField
      FieldName = 'DESCRICAO_IMOVEL'
      Size = 500
    end
    object cdsSelecionarRegistroCODIGO_TIPO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_TIPO_IMOVEL'
      Required = True
    end
    object cdsSelecionarRegistroNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object cdsSelecionarRegistroCODIGO_ESTADO: TIntegerField
      FieldName = 'CODIGO_ESTADO'
      Required = True
    end
    object cdsSelecionarRegistroSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object cdsSelecionarRegistroCODIGO_CIDADE: TIntegerField
      FieldName = 'CODIGO_CIDADE'
      Required = True
    end
    object cdsSelecionarRegistroNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object cdsSelecionarRegistroCODIGO_BAIRRO: TIntegerField
      FieldName = 'CODIGO_BAIRRO'
      Required = True
    end
    object cdsSelecionarRegistroNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
      Required = True
      Size = 100
    end
    object cdsSelecionarRegistroCODIGO_RUA: TIntegerField
      FieldName = 'CODIGO_RUA'
      Required = True
    end
    object cdsSelecionarRegistroNOME_RUA: TStringField
      FieldName = 'NOME_RUA'
      Required = True
      Size = 100
    end
    object cdsSelecionarRegistroCEP_RUA: TStringField
      FieldName = 'CEP_RUA'
      Size = 9
    end
  end
  object ppMnExibirDadosAgenciamento: TPopupMenu
    Left = 14
    Top = 110
    object mnItExibirDadosAgenciamento: TMenuItem
      Caption = 'Exibir Dados Agenciamento...'
      OnClick = mnItExibirDadosAgenciamentoClick
    end
  end
end
