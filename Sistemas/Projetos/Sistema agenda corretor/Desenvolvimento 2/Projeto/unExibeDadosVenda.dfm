inherited frmExibeDadosVenda: TfrmExibeDadosVenda
  Left = 404
  Top = 50
  Caption = 'EXIBIR DADOS DA VENDA'
  ClientHeight = 682
  ClientWidth = 842
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel [0]
    Left = 5
    Top = 74
    Width = 82
    Height = 14
    Caption = 'Tipo de Venda:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel [1]
    Left = 135
    Top = 74
    Width = 110
    Height = 13
    AutoSize = False
    Caption = 'lblTipoVenda'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  inherited pnlBotoes: TPanel
    Top = 641
    Width = 842
  end
  inherited pnlDados: TPanel
    Width = 842
    Height = 641
    object lblVenda: TLabel
      Left = 2
      Top = 6
      Width = 44
      Height = 16
      Caption = 'VENDA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lblImovel: TLabel
      Left = 2
      Top = 303
      Width = 50
      Height = 16
      Caption = 'IM'#211'VEL'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object pnlVenda: TPanel
      Left = 0
      Top = 21
      Width = 842
      Height = 279
      BevelOuter = bvNone
      TabOrder = 0
      object lblObservacao: TLabel
        Left = 82
        Top = 230
        Width = 647
        Height = 43
        AutoSize = False
        Caption = 'lblObservacao'
        WordWrap = True
      end
      object lblNomeObservacao: TLabel
        Left = 5
        Top = 230
        Width = 68
        Height = 14
        Caption = 'Observa'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomePercentualSobreComissao: TLabel
        Left = 236
        Top = 200
        Width = 107
        Height = 14
        Caption = '% Sobre Comiss'#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeValorTotalComissao: TLabel
        Left = 502
        Top = 200
        Width = 121
        Height = 14
        Caption = 'Valor Total Comiss'#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomePercentualSobreVenda: TLabel
        Left = 5
        Top = 200
        Width = 86
        Height = 14
        Caption = '% Sobre Venda:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPercentualSobreVenda: TLabel
        Left = 97
        Top = 200
        Width = 130
        Height = 13
        AutoSize = False
        Caption = 'lblPercentualSobreVenda'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblValorTotalComissao: TLabel
        Left = 627
        Top = 200
        Width = 130
        Height = 13
        AutoSize = False
        Caption = 'lblValorTotalComissao'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblPercentualSobreComissao: TLabel
        Left = 348
        Top = 200
        Width = 130
        Height = 13
        AutoSize = False
        Caption = 'lblPercentualSobreComissao'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblValorCalculoComissao: TLabel
        Left = 482
        Top = 170
        Width = 130
        Height = 13
        AutoSize = False
        Caption = 'lblValorCalculoComissao'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeValorCalculoComissao: TLabel
        Left = 301
        Top = 170
        Width = 177
        Height = 14
        Caption = 'Valor para C'#225'lculo da Comiss'#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTipoCalculoComissao: TLabel
        Left = 171
        Top = 170
        Width = 125
        Height = 13
        AutoSize = False
        Caption = 'lblTipoCalculoComissao'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeTipoCalculoComissao: TLabel
        Left = 5
        Top = 170
        Width = 162
        Height = 14
        Caption = 'Tipo do C'#225'lculo da Comiss'#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeValorBemNegociavel: TLabel
        Left = 5
        Top = 140
        Width = 139
        Height = 14
        Caption = 'Valor do Bem Negoci'#225'vel:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValorBemNegociavel: TLabel
        Left = 149
        Top = 140
        Width = 130
        Height = 13
        AutoSize = False
        Caption = 'lblValorBemNegociavel'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblDeduziuBemNegociavelValorVenda: TLabel
        Left = 280
        Top = 140
        Width = 204
        Height = 13
        Caption = 'deduziu bem negoci'#225'vel do valor da venda'
      end
      object lblDeducoes: TLabel
        Left = 301
        Top = 110
        Width = 130
        Height = 13
        AutoSize = False
        Caption = 'lblDeducoes'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeDeducoes: TLabel
        Left = 235
        Top = 110
        Width = 58
        Height = 14
        Caption = 'Dedu'#231#245'es:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeValorVenda: TLabel
        Left = 5
        Top = 110
        Width = 86
        Height = 14
        Caption = 'Valor da Venda:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValorVenda: TLabel
        Left = 98
        Top = 110
        Width = 130
        Height = 13
        AutoSize = False
        Caption = 'lblValorVenda'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblTipoVenda: TLabel
        Left = 98
        Top = 80
        Width = 199
        Height = 13
        AutoSize = False
        Caption = 'lblTipoVenda'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        OnClick = lblTipoVendaClick
      end
      object lblNomeTipoVenda: TLabel
        Left = 5
        Top = 80
        Width = 82
        Height = 14
        Caption = 'Tipo de Venda:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeTipoPessoa: TLabel
        Left = 5
        Top = 50
        Width = 88
        Height = 14
        Caption = 'Tipo de Pessoa:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeCodigoVenda: TLabel
        Left = 5
        Top = 20
        Width = 48
        Height = 14
        Caption = 'C'#243'digo:  '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCodigoVenda: TLabel
        Left = 54
        Top = 20
        Width = 73
        Height = 13
        AutoSize = False
        Caption = 'lblCodigoVenda'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblTipoPessoa: TLabel
        Left = 98
        Top = 50
        Width = 112
        Height = 13
        AutoSize = False
        Caption = 'lblTipoPessoa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeAtivo: TLabel
        Left = 144
        Top = 20
        Width = 34
        Height = 14
        Caption = 'Ativo: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblAtivo: TLabel
        Left = 178
        Top = 20
        Width = 69
        Height = 13
        AutoSize = False
        Caption = 'lblAtivo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeNomePessoa: TLabel
        Left = 216
        Top = 50
        Width = 98
        Height = 14
        Caption = 'Nome da Pessoa: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomePessoa: TLabel
        Left = 316
        Top = 50
        Width = 519
        Height = 13
        AutoSize = False
        Caption = 'lblNomePessoa'
      end
      object lblDataCancelamento: TLabel
        Left = 565
        Top = 20
        Width = 125
        Height = 13
        AutoSize = False
        Caption = 'lblDataCancelamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeDataCancelamento: TLabel
        Left = 434
        Top = 20
        Width = 125
        Height = 14
        Caption = 'Data do Cancelamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDataVenda: TLabel
        Left = 334
        Top = 20
        Width = 97
        Height = 13
        AutoSize = False
        Caption = 'lblDataVenda'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeDataVenda: TLabel
        Left = 250
        Top = 20
        Width = 80
        Height = 14
        Caption = 'Data da Venda:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlImovel: TPanel
      Left = 2
      Top = 320
      Width = 743
      Height = 321
      BevelOuter = bvNone
      TabOrder = 1
      object lblTipoImovel: TLabel
        Left = 114
        Top = 80
        Width = 615
        Height = 13
        AutoSize = False
        Caption = 'lblTipoImovel'
      end
      object lblUF: TLabel
        Left = 114
        Top = 205
        Width = 615
        Height = 14
        AutoSize = False
        Caption = 'lblUF'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeUF: TLabel
        Left = 5
        Top = 205
        Width = 19
        Height = 14
        Caption = 'UF: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeBairro: TLabel
        Left = 5
        Top = 265
        Width = 39
        Height = 14
        Caption = 'Bairro: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblSituacaoDesejavel: TLabel
        Left = 114
        Top = 50
        Width = 615
        Height = 14
        AutoSize = False
        Caption = 'lblSituacaoDesejavel'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblStatus: TLabel
        Left = 178
        Top = 20
        Width = 127
        Height = 13
        AutoSize = False
        Caption = 'lblStatus'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblBairro: TLabel
        Left = 114
        Top = 265
        Width = 615
        Height = 14
        AutoSize = False
        Caption = 'lblBairro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeCidade: TLabel
        Left = 5
        Top = 235
        Width = 44
        Height = 14
        Caption = 'Cidade: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeRua: TLabel
        Left = 5
        Top = 295
        Width = 26
        Height = 14
        Caption = 'Rua: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCEP: TLabel
        Left = 601
        Top = 297
        Width = 134
        Height = 14
        AutoSize = False
        Caption = 'lblCEP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblRua: TLabel
        Left = 114
        Top = 295
        Width = 442
        Height = 14
        AutoSize = False
        Caption = 'lblRua'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeCEP: TLabel
        Left = 561
        Top = 297
        Width = 27
        Height = 14
        Caption = 'CEP: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeSituacaoDesejavel: TLabel
        Left = 5
        Top = 50
        Width = 108
        Height = 14
        Caption = 'Situa'#231#227'o Desej'#225'vel: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeDescricao: TLabel
        Left = 5
        Top = 140
        Width = 60
        Height = 14
        Caption = 'Descri'#231#227'o: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDescricao: TLabel
        Left = 114
        Top = 140
        Width = 615
        Height = 59
        AutoSize = False
        Caption = 'lblDescricao'
        WordWrap = True
      end
      object lblNomeStatus: TLabel
        Left = 114
        Top = 20
        Width = 41
        Height = 14
        Caption = 'Status: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValorImovel: TLabel
        Left = 114
        Top = 110
        Width = 615
        Height = 14
        AutoSize = False
        Caption = 'lblValorImovel'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblCodigoImovel: TLabel
        Left = 52
        Top = 20
        Width = 56
        Height = 13
        AutoSize = False
        Caption = 'lblCodigo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeCodigoImovel: TLabel
        Left = 5
        Top = 20
        Width = 48
        Height = 14
        Caption = 'C'#243'digo:  '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeValorImovel: TLabel
        Left = 5
        Top = 110
        Width = 92
        Height = 14
        Caption = 'Valor do Im'#243'vel: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeTipoImovel: TLabel
        Left = 5
        Top = 80
        Width = 87
        Height = 14
        Caption = 'Tipo do Im'#243'vel: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCidade: TLabel
        Left = 114
        Top = 235
        Width = 615
        Height = 14
        AutoSize = False
        Caption = 'lblCidade'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object zQryVenda: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT'
      
        '    v.codigo AS CODIGO_VENDA,v.ativo,v.data_venda,v.data_cancela' +
        'mento,'
      '    v.tipo_pessoa,'
      '    CASE WHEN v.tipo_pessoa = '#39'F'#205'SICA'#39' THEN pf.nome'
      '         WHEN v.tipo_pessoa = '#39'JUR'#205'DICA'#39' THEN pj.nome'
      '    ELSE '#39#39
      '    END AS NOME_TIPO_PESSOA,'
      
        '    v.tipo_venda,v.cod_fk_agenciamento,const.nome AS NOME_CONSTR' +
        'UTORA,'
      '    v.valor_venda,v.deducoes,'
      '    v.valor_bem_negociavel,v.deduzir_bem_negoc_valor_venda,'
      '    v.tipo_calculo_comissao,v.valor_para_calculo_comissao,'
      
        '    v.percentual_sobre_venda,v.percentual_sobre_comissao,v.valor' +
        '_total_comissao,'
      '    v.observacao,'
      '    i.codigo AS CODIGO_IMOVEL,i.status,'
      '    i.situacao_desejavel,'
      '    ti.nome AS NOME_TIPO_IMOVEL,'
      '    i.valor_imovel,'
      '    i.descricao,'
      '    est.sigla,'
      '    cid.nome AS NOME_CIDADE,'
      '    bai.nome AS NOME_BAIRRO,'
      '    rua.nome AS NOME_RUA,'
      '    rua.cep'
      'FROM vendas v'
      
        'LEFT JOIN cliente_pessoa_fisica pf ON v.cod_fk_cliente_pessoa_fi' +
        'sica = pf.codigo'
      
        'LEFT JOIN cliente_pessoa_juridica pj ON v.cod_fk_cliente_pessoa_' +
        'juridica = pj.codigo'
      
        'LEFT JOIN construtora const ON v.cod_fk_tp_vnd_construtora = con' +
        'st.codigo'
      'JOIN imovel i ON v.cod_fk_imovel = i.codigo'
      'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo'
      'JOIN estado est ON i.cod_fk_estado = est.codigo'
      'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo'
      'JOIN bairro bai ON i.cod_fk_bairro = bai.codigo'
      'JOIN rua rua ON i.cod_fk_rua = rua.codigo'
      'WHERE v.codigo = 1'
      'AND 1=2')
    Params = <>
    Left = 802
    Top = 8
    object zQryVendaCODIGO_VENDA: TIntegerField
      FieldName = 'CODIGO_VENDA'
      Required = True
    end
    object zQryVendaATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      Size = 3
    end
    object zQryVendaDATA_VENDA: TDateField
      FieldName = 'DATA_VENDA'
    end
    object zQryVendaDATA_CANCELAMENTO: TDateTimeField
      FieldName = 'DATA_CANCELAMENTO'
    end
    object zQryVendaTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryVendaNOME_TIPO_PESSOA: TStringField
      FieldName = 'NOME_TIPO_PESSOA'
      ReadOnly = True
      Size = 100
    end
    object zQryVendaTIPO_VENDA: TStringField
      FieldName = 'TIPO_VENDA'
      Required = True
      Size = 16
    end
    object zQryVendaCOD_FK_AGENCIAMENTO: TIntegerField
      FieldName = 'COD_FK_AGENCIAMENTO'
    end
    object zQryVendaNOME_CONSTRUTORA: TStringField
      FieldName = 'NOME_CONSTRUTORA'
      Size = 100
    end
    object zQryVendaVALOR_VENDA: TFloatField
      FieldName = 'VALOR_VENDA'
      Required = True
    end
    object zQryVendaDEDUCOES: TFloatField
      FieldName = 'DEDUCOES'
    end
    object zQryVendaVALOR_BEM_NEGOCIAVEL: TFloatField
      FieldName = 'VALOR_BEM_NEGOCIAVEL'
    end
    object zQryVendaDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField
      FieldName = 'DEDUZIR_BEM_NEGOC_VALOR_VENDA'
      Size = 3
    end
    object zQryVendaTIPO_CALCULO_COMISSAO: TStringField
      FieldName = 'TIPO_CALCULO_COMISSAO'
      Size = 8
    end
    object zQryVendaVALOR_PARA_CALCULO_COMISSAO: TFloatField
      FieldName = 'VALOR_PARA_CALCULO_COMISSAO'
    end
    object zQryVendaPERCENTUAL_SOBRE_VENDA: TFloatField
      FieldName = 'PERCENTUAL_SOBRE_VENDA'
    end
    object zQryVendaPERCENTUAL_SOBRE_COMISSAO: TFloatField
      FieldName = 'PERCENTUAL_SOBRE_COMISSAO'
    end
    object zQryVendaVALOR_TOTAL_COMISSAO: TFloatField
      FieldName = 'VALOR_TOTAL_COMISSAO'
    end
    object zQryVendaOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object zQryVendaCODIGO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_IMOVEL'
      Required = True
    end
    object zQryVendaSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object zQryVendaSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zQryVendaNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object zQryVendaVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object zQryVendaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 500
    end
    object zQryVendaSIGLA: TStringField
      FieldName = 'SIGLA'
      Required = True
      Size = 2
    end
    object zQryVendaNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object zQryVendaNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
      Required = True
      Size = 100
    end
    object zQryVendaNOME_RUA: TStringField
      FieldName = 'NOME_RUA'
      Required = True
      Size = 100
    end
    object zQryVendaCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
  end
end
