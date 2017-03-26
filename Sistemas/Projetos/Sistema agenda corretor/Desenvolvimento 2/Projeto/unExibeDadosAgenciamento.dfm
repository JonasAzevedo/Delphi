inherited frmExibeDadosAgenciamento: TfrmExibeDadosAgenciamento
  Left = 429
  Top = 7
  Caption = 'EXIBIR DADOS DO AGENCIAMENTO'
  ClientHeight = 690
  ClientWidth = 750
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 649
    Width = 750
  end
  inherited pnlDados: TPanel
    Width = 750
    Height = 649
    object lblImovel: TLabel
      Left = 2
      Top = 308
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
    object lblAgenciamento: TLabel
      Left = 2
      Top = 6
      Width = 104
      Height = 16
      Caption = 'AGENCIAMENTO'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object pnlDadosAgenciamento: TPanel
      Left = 2
      Top = 24
      Width = 743
      Height = 279
      BevelOuter = bvNone
      TabOrder = 0
      object lblObservacaoAgenciamento: TLabel
        Left = 5
        Top = 132
        Width = 649
        Height = 41
        AutoSize = False
        Caption = 'lblObservacaoAgenciamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeObservacaoAgenciamento: TLabel
        Left = 5
        Top = 229
        Width = 71
        Height = 14
        Caption = 'Observa'#231#227'o: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCondicaoPagamento: TLabel
        Left = 310
        Top = 110
        Width = 289
        Height = 13
        AutoSize = False
        Caption = 'lblCondicaoPagamento'
      end
      object pbpNomeCondicaoPagamento: TLabel
        Left = 186
        Top = 110
        Width = 119
        Height = 14
        Caption = 'Condi'#231#227'o Pagamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeValorTotalAgenciamento: TLabel
        Left = 5
        Top = 110
        Width = 65
        Height = 14
        Caption = 'Valor Total: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValorTotal: TLabel
        Left = 72
        Top = 110
        Width = 109
        Height = 13
        AutoSize = False
        Caption = 'lblValorTotal'
      end
      object lblNomePessoa: TLabel
        Left = 308
        Top = 80
        Width = 442
        Height = 13
        AutoSize = False
        Caption = 'lblNomePessoa'
      end
      object lblNomeNomePessoa: TLabel
        Left = 186
        Top = 80
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
      object lblTipoPessoa: TLabel
        Left = 96
        Top = 80
        Width = 77
        Height = 13
        AutoSize = False
        Caption = 'lblTipoPessoa'
      end
      object lblNomeTipoPessoa: TLabel
        Left = 5
        Top = 80
        Width = 90
        Height = 14
        Caption = 'Tipo da Pessoa: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeDataAgenciamento: TLabel
        Left = 5
        Top = 50
        Width = 129
        Height = 14
        Caption = 'Data do Agenciamento: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeCodigoAgenciamento: TLabel
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
      object lblCodigoAgenciamento: TLabel
        Left = 54
        Top = 20
        Width = 73
        Height = 13
        AutoSize = False
        Caption = 'lblCodigoAgenciamento'
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
      object lblDataAgenciamento: TLabel
        Left = 135
        Top = 50
        Width = 110
        Height = 13
        AutoSize = False
        Caption = 'lblDataAgenciamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomePrazoAutorizacao: TLabel
        Left = 250
        Top = 50
        Width = 105
        Height = 14
        Caption = 'Prazo Autoriza'#231#227'o: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNomeNormalStandBy: TLabel
        Left = 250
        Top = 20
        Width = 92
        Height = 14
        Caption = 'Normal/StandBy: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNormalStandBy: TLabel
        Left = 345
        Top = 20
        Width = 83
        Height = 13
        AutoSize = False
        Caption = 'lblNormalStandBy'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblPrazoAutorizacao: TLabel
        Left = 355
        Top = 50
        Width = 106
        Height = 13
        AutoSize = False
        Caption = 'lblPrazoAutorizacao'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblNomeDataReagenciamento: TLabel
        Left = 464
        Top = 50
        Width = 141
        Height = 14
        Caption = 'Data do Reagenciamento: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDataReagenciamento: TLabel
        Left = 607
        Top = 50
        Width = 110
        Height = 13
        AutoSize = False
        Caption = 'lblDataReagenciamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object pnlPagamentoFinanciado: TPanel
        Left = 5
        Top = 132
        Width = 735
        Height = 88
        BevelOuter = bvNone
        TabOrder = 0
        object lblNomePgtoFnctoCachFinanciado: TLabel
          Left = 158
          Top = 6
          Width = 91
          Height = 14
          Caption = 'Cach Financiado:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNomePgtoFnctoCach: TLabel
          Left = 2
          Top = 6
          Width = 33
          Height = 14
          Caption = 'Cach: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNomePgtoFnctoValorBem: TLabel
          Left = 2
          Top = 36
          Width = 63
          Height = 14
          Caption = 'Valor Bem: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblNomePgtoFnctoDescricaoBem: TLabel
          Left = 2
          Top = 66
          Width = 105
          Height = 14
          Caption = 'Descri'#231#227'o do Bem: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblPgtoFnctoDescricaoBem: TLabel
          Left = 108
          Top = 66
          Width = 613
          Height = 13
          AutoSize = False
          Caption = 'lblPgtoFnctoDescricaoBem'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object lblPgtoFnctoValorBem: TLabel
          Left = 108
          Top = 36
          Width = 110
          Height = 13
          AutoSize = False
          Caption = 'lblPgtoFnctoValorBem'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblPgtoFnctoCach: TLabel
          Left = 42
          Top = 6
          Width = 110
          Height = 13
          AutoSize = False
          Caption = 'lblPgtoFnctoCach'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblPgtoFnctoCachFinanciado: TLabel
          Left = 264
          Top = 6
          Width = 110
          Height = 13
          AutoSize = False
          Caption = 'lblPgtoFnctoCachFinanciado'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object pnlPagamentoVista: TPanel
        Left = 61
        Top = 220
        Width = 735
        Height = 88
        BevelOuter = bvNone
        TabOrder = 1
        object lblNomePgtoVista: TLabel
          Left = 2
          Top = 6
          Width = 33
          Height = 14
          Caption = 'Cach: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblPgtoVistaCach: TLabel
          Left = 108
          Top = 6
          Width = 110
          Height = 13
          AutoSize = False
          Caption = 'lblPgtoVistaCach'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblNomePgtoVistaValorBem: TLabel
          Left = 2
          Top = 36
          Width = 63
          Height = 14
          Caption = 'Valor Bem: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblPgtoVistaValorBem: TLabel
          Left = 108
          Top = 36
          Width = 110
          Height = 13
          AutoSize = False
          Caption = 'lblPgtoVistaValorBem'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblPgtoVistaDescricaoBem: TLabel
          Left = 108
          Top = 66
          Width = 613
          Height = 13
          AutoSize = False
          Caption = 'lblPgtoVistaDescricaoBem'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object lblNomePgtoVistaDescricaoBem: TLabel
          Left = 2
          Top = 66
          Width = 105
          Height = 14
          Caption = 'Descri'#231#227'o do Bem: '
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object pnlImovel: TPanel
      Left = 2
      Top = 328
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
  object zQryAgenciamento: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      
        'SELECT a.codigo AS codigo_agenciamento,a.cod_fk_pessoa_fisica,a.' +
        'cod_fk_pessoa_juridica,a.cod_fk_imovel,'
      
        '       a.ativo,a.normal,a.stand_by,a.data_agenciamento,a.prazo_a' +
        'utorizacao,'
      '       a.data_reagenciamento,a.tipo_pessoa,'
      '       pf.nome AS nomePessoaFisica,'
      '       pj.nome AS nomePessoaJuridica,'
      '       a.valor_total,a.condicao_pagamento,'
      
        '       a.pgto_vista_cach,a.pgto_vista_valor_bem,a.pgto_vista_des' +
        'cricao_bem,'
      
        '       a.pgto_fincto_cach_financiado,a.pgto_fincto_cach,a.pgto_f' +
        'incto_valor_bem,a.pgto_fincto_descricao_bem,'
      '       a.observacao AS observacao_agenciamento,'
      
        '       i.codigo AS codigo_imovel,i.cod_fk_tipo_imovel,i.cod_fk_e' +
        'stado,i.cod_fk_cidade,i.cod_fk_bairro,i.cod_fk_rua,'
      
        '       i.status,i.situacao_desejavel,i.valor_imovel,i.descricao ' +
        'AS descricao_imovel,'
      '       ti.nome AS nomeTipoImovel,'
      '       est.nome AS nomeEstado,est.sigla,'
      '       cid.nome AS nomeCidade,'
      '       bai.nome AS nomeBairro,'
      '       rua.nome AS nomeRua,'
      '       rua.cep AS cepRua'
      'FROM agenciamentos a'
      
        'JOIN agenc_pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codig' +
        'o'
      
        'JOIN agenc_pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.c' +
        'odigo'
      'JOIN imovel i ON a.cod_fk_imovel = i.codigo'
      'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo'
      'JOIN estado est ON i.cod_fk_estado = est.codigo'
      'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo'
      'JOIN bairro bai ON i.cod_fk_bairro = bai.codigo'
      'JOIN rua rua ON i.cod_fk_rua = rua.codigo'
      'WHERE 1=2')
    Params = <>
    Left = 714
    Top = 8
    object zQryAgenciamentoCODIGO_AGENCIAMENTO: TIntegerField
      FieldName = 'CODIGO_AGENCIAMENTO'
      Required = True
    end
    object zQryAgenciamentoCOD_FK_PESSOA_FISICA: TIntegerField
      FieldName = 'COD_FK_PESSOA_FISICA'
    end
    object zQryAgenciamentoCOD_FK_PESSOA_JURIDICA: TIntegerField
      FieldName = 'COD_FK_PESSOA_JURIDICA'
    end
    object zQryAgenciamentoCOD_FK_IMOVEL: TIntegerField
      FieldName = 'COD_FK_IMOVEL'
    end
    object zQryAgenciamentoATIVO: TStringField
      FieldName = 'ATIVO'
      Size = 3
    end
    object zQryAgenciamentoNORMAL: TStringField
      FieldName = 'NORMAL'
      Size = 5
    end
    object zQryAgenciamentoSTAND_BY: TStringField
      FieldName = 'STAND_BY'
      Size = 5
    end
    object zQryAgenciamentoDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
    end
    object zQryAgenciamentoPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object zQryAgenciamentoDATA_REAGENCIAMENTO: TDateField
      FieldName = 'DATA_REAGENCIAMENTO'
    end
    object zQryAgenciamentoTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryAgenciamentoNOMEPESSOAFISICA: TStringField
      FieldName = 'NOMEPESSOAFISICA'
      Size = 100
    end
    object zQryAgenciamentoNOMEPESSOAJURIDICA: TStringField
      FieldName = 'NOMEPESSOAJURIDICA'
      Size = 100
    end
    object zQryAgenciamentoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
    object zQryAgenciamentoCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryAgenciamentoPGTO_VISTA_CACH: TFloatField
      FieldName = 'PGTO_VISTA_CACH'
    end
    object zQryAgenciamentoPGTO_VISTA_VALOR_BEM: TFloatField
      FieldName = 'PGTO_VISTA_VALOR_BEM'
    end
    object zQryAgenciamentoPGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_VISTA_DESCRICAO_BEM'
      Size = 500
    end
    object zQryAgenciamentoPGTO_FINCTO_CACH_FINANCIADO: TFloatField
      FieldName = 'PGTO_FINCTO_CACH_FINANCIADO'
    end
    object zQryAgenciamentoPGTO_FINCTO_CACH: TFloatField
      FieldName = 'PGTO_FINCTO_CACH'
    end
    object zQryAgenciamentoPGTO_FINCTO_VALOR_BEM: TFloatField
      FieldName = 'PGTO_FINCTO_VALOR_BEM'
    end
    object zQryAgenciamentoPGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_FINCTO_DESCRICAO_BEM'
      Size = 500
    end
    object zQryAgenciamentoOBSERVACAO_AGENCIAMENTO: TStringField
      FieldName = 'OBSERVACAO_AGENCIAMENTO'
      Size = 500
    end
    object zQryAgenciamentoCODIGO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_IMOVEL'
      Required = True
    end
    object zQryAgenciamentoCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object zQryAgenciamentoCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zQryAgenciamentoCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zQryAgenciamentoCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
    end
    object zQryAgenciamentoCOD_FK_RUA: TIntegerField
      FieldName = 'COD_FK_RUA'
    end
    object zQryAgenciamentoSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object zQryAgenciamentoSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zQryAgenciamentoVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object zQryAgenciamentoDESCRICAO_IMOVEL: TStringField
      FieldName = 'DESCRICAO_IMOVEL'
      Size = 500
    end
    object zQryAgenciamentoNOMETIPOIMOVEL: TStringField
      FieldName = 'NOMETIPOIMOVEL'
      Required = True
      Size = 60
    end
    object zQryAgenciamentoNOMEESTADO: TStringField
      FieldName = 'NOMEESTADO'
      Required = True
      Size = 50
    end
    object zQryAgenciamentoSIGLA: TStringField
      FieldName = 'SIGLA'
      Required = True
      Size = 2
    end
    object zQryAgenciamentoNOMECIDADE: TStringField
      FieldName = 'NOMECIDADE'
      Required = True
      Size = 100
    end
    object zQryAgenciamentoNOMEBAIRRO: TStringField
      FieldName = 'NOMEBAIRRO'
      Required = True
      Size = 100
    end
    object zQryAgenciamentoNOMERUA: TStringField
      FieldName = 'NOMERUA'
      Required = True
      Size = 100
    end
    object zQryAgenciamentoCEPRUA: TStringField
      FieldName = 'CEPRUA'
      Size = 9
    end
  end
end
