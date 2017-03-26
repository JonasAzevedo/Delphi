object frmImoveisInteresseParaAgenciamento: TfrmImoveisInteresseParaAgenciamento
  Left = 213
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'IM'#211'VEIS DE INTERESSE PARA AGENCIAMENTO'
  ClientHeight = 706
  ClientWidth = 990
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object grpBxAgenciamento: TGroupBox
    Left = 0
    Top = 0
    Width = 990
    Height = 356
    Align = alTop
    Caption = 'Agenciamento '
    TabOrder = 0
    object lblInfNormalStandBy: TLabel
      Left = 347
      Top = 20
      Width = 87
      Height = 13
      Caption = 'Normal/Stand By: '
    end
    object lblInfCodigoAgenciamento: TLabel
      Left = 8
      Top = 20
      Width = 39
      Height = 13
      Caption = 'C'#243'digo: '
    end
    object lblCodigoAgenciamento: TLabel
      Left = 104
      Top = 20
      Width = 108
      Height = 13
      AutoSize = False
      Caption = 'lblCodigoAgenciamento'
    end
    object lblInfDataAgenciamento: TLabel
      Left = 8
      Top = 35
      Width = 100
      Height = 13
      Caption = 'Data Agenciamento: '
    end
    object lblDataAgenciamento: TLabel
      Left = 105
      Top = 35
      Width = 110
      Height = 13
      AutoSize = False
      Caption = 'lblDataAgenciamento'
    end
    object lblNormalStandBy: TLabel
      Left = 436
      Top = 20
      Width = 97
      Height = 13
      AutoSize = False
      Caption = 'lblNormalStandBy'
    end
    object lblInfValorTotal: TLabel
      Left = 254
      Top = 65
      Width = 57
      Height = 13
      Caption = 'Valor Total: '
    end
    object lblValorTotal: TLabel
      Left = 312
      Top = 65
      Width = 138
      Height = 13
      AutoSize = False
      Caption = 'lblValorTotal'
    end
    object lblInfAtivo: TLabel
      Left = 254
      Top = 20
      Width = 30
      Height = 13
      Caption = 'Ativo: '
    end
    object lblAtivo: TLabel
      Left = 284
      Top = 20
      Width = 59
      Height = 13
      AutoSize = False
      Caption = 'lblAtivo'
    end
    object lblNomePessoa: TLabel
      Left = 254
      Top = 50
      Width = 761
      Height = 13
      AutoSize = False
      Caption = 'lblNomePessoa'
    end
    object lblInfCondicaoPagamento: TLabel
      Left = 8
      Top = 65
      Width = 56
      Height = 13
      Caption = 'Cond Pgto: '
    end
    object lblInfTipoPessoa: TLabel
      Left = 8
      Top = 50
      Width = 65
      Height = 13
      Caption = 'Tipo Pessoa: '
    end
    object lblCondicaoPagamento: TLabel
      Left = 104
      Top = 65
      Width = 109
      Height = 13
      AutoSize = False
      Caption = 'lblCondicaoPagamento'
    end
    object lblTipoPessoa: TLabel
      Left = 104
      Top = 50
      Width = 66
      Height = 13
      AutoSize = False
      Caption = 'lblTipoPessoa'
    end
    object lblInfObservacao: TLabel
      Left = 8
      Top = 165
      Width = 64
      Height = 13
      Caption = 'Observa'#231#227'o: '
    end
    object lblObservacao: TLabel
      Left = 74
      Top = 165
      Width = 908
      Height = 44
      AutoSize = False
      Caption = 'lblObservacao'
      WordWrap = True
    end
    object lblInfPrazoAutorizacao: TLabel
      Left = 254
      Top = 35
      Width = 92
      Height = 13
      Caption = 'Prazo Autoriza'#231#227'o: '
    end
    object lblPrazoAutorizacao: TLabel
      Left = 347
      Top = 35
      Width = 110
      Height = 13
      AutoSize = False
      Caption = 'lblPrazoAutorizacao'
    end
    object lblDataReagenciamento: TLabel
      Left = 575
      Top = 35
      Width = 110
      Height = 13
      AutoSize = False
      Caption = 'lblDataReagenciamento'
    end
    object lblInfDataReagenciamento: TLabel
      Left = 461
      Top = 35
      Width = 113
      Height = 13
      Caption = 'Data Reagenciamento: '
    end
    object lblInfDataBaixa: TLabel
      Left = 693
      Top = 35
      Width = 58
      Height = 13
      Caption = 'Data Baixa: '
    end
    object lblDataBaixa: TLabel
      Left = 753
      Top = 35
      Width = 110
      Height = 13
      AutoSize = False
      Caption = 'lblDataBaixa'
    end
    object lblInfImovel: TLabel
      Left = 8
      Top = 194
      Width = 38
      Height = 13
      Caption = 'Im'#243'vel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblInfStatus: TLabel
      Left = 8
      Top = 215
      Width = 36
      Height = 13
      Caption = 'Status: '
    end
    object lblStatus: TLabel
      Left = 47
      Top = 215
      Width = 107
      Height = 13
      AutoSize = False
      Caption = 'lblStatus'
    end
    object lblInfSituacaoDesejavel: TLabel
      Left = 416
      Top = 215
      Width = 98
      Height = 13
      Caption = 'Situa'#231#227'o Desej'#225'vel: '
    end
    object lblSituacaoDesejavel: TLabel
      Left = 515
      Top = 215
      Width = 326
      Height = 13
      AutoSize = False
      Caption = 'lblSituacaoDesejavel'
    end
    object lblInfDescricao: TLabel
      Left = 8
      Top = 230
      Width = 54
      Height = 13
      Caption = 'Descri'#231#227'o: '
    end
    object lblDescricao: TLabel
      Left = 63
      Top = 230
      Width = 921
      Height = 29
      AutoSize = False
      Caption = 'lblDescricao'
    end
    object lblInfTipoImovel: TLabel
      Left = 156
      Top = 215
      Width = 76
      Height = 13
      Caption = 'Tipo de Im'#243'vel: '
    end
    object lblTipoImovel: TLabel
      Left = 233
      Top = 215
      Width = 181
      Height = 13
      AutoSize = False
      Caption = 'lblTipoImovel'
    end
    object lblInfUF: TLabel
      Left = 8
      Top = 260
      Width = 20
      Height = 13
      Caption = 'UF: '
    end
    object lblUF: TLabel
      Left = 42
      Top = 260
      Width = 51
      Height = 13
      AutoSize = False
      Caption = 'lblUF'
    end
    object lblInfCidade: TLabel
      Left = 96
      Top = 260
      Width = 39
      Height = 13
      Caption = 'Cidade: '
    end
    object lblCidade: TLabel
      Left = 136
      Top = 260
      Width = 841
      Height = 13
      AutoSize = False
      Caption = 'lblCidade'
    end
    object lblInfBairro: TLabel
      Left = 8
      Top = 275
      Width = 33
      Height = 13
      Caption = 'Bairro: '
    end
    object lblBairro: TLabel
      Left = 42
      Top = 275
      Width = 935
      Height = 13
      AutoSize = False
      Caption = 'lblBairro'
    end
    object lblInfRua: TLabel
      Left = 8
      Top = 290
      Width = 26
      Height = 13
      Caption = 'Rua: '
    end
    object lblRua: TLabel
      Left = 42
      Top = 290
      Width = 935
      Height = 13
      AutoSize = False
      Caption = 'lblRua'
    end
    object lblInfCEP: TLabel
      Left = 8
      Top = 305
      Width = 27
      Height = 13
      Caption = 'CEP: '
    end
    object lblCEP: TLabel
      Left = 42
      Top = 305
      Width = 167
      Height = 13
      AutoSize = False
      Caption = 'lblCEP'
    end
    object lblInfComplemento: TLabel
      Left = 8
      Top = 320
      Width = 70
      Height = 13
      Caption = 'Complemento: '
    end
    object lblComplemento: TLabel
      Left = 79
      Top = 320
      Width = 900
      Height = 30
      AutoSize = False
      Caption = 'lblComplemento'
      WordWrap = True
    end
    object pnlPgtoVista: TPanel
      Left = 8
      Top = 90
      Width = 977
      Height = 72
      BevelOuter = bvNone
      TabOrder = 0
      object lblInfVistaCach: TLabel
        Left = 5
        Top = 2
        Width = 31
        Height = 13
        Caption = 'Cach: '
      end
      object lblVistaCach: TLabel
        Left = 41
        Top = 2
        Width = 100
        Height = 13
        AutoSize = False
        Caption = 'lblVistaCach'
      end
      object lblVistaValorBem: TLabel
        Left = 200
        Top = 2
        Width = 100
        Height = 13
        AutoSize = False
        Caption = 'lblVistaValorBem'
      end
      object lblInfVistaValorBem: TLabel
        Left = 143
        Top = 2
        Width = 54
        Height = 13
        Caption = 'Valor Bem: '
      end
      object lblVistaDescricaoBem: TLabel
        Left = 89
        Top = 32
        Width = 884
        Height = 35
        AutoSize = False
        Caption = 'lblVistaDescricaoBem'
      end
      object lblInfVistaDescricaoBem: TLabel
        Left = 5
        Top = 32
        Width = 78
        Height = 13
        Caption = 'Descri'#231#227'o Bem: '
      end
    end
    object pnlPgtoFinanciado: TPanel
      Left = 8
      Top = 80
      Width = 977
      Height = 72
      BevelOuter = bvNone
      TabOrder = 1
      object lblInfFnctoCach: TLabel
        Left = 5
        Top = 2
        Width = 31
        Height = 13
        Caption = 'Cach: '
      end
      object lblFnctoCach: TLabel
        Left = 41
        Top = 2
        Width = 100
        Height = 13
        AutoSize = False
        Caption = 'lblFnctoCach'
      end
      object lblFnctoValorBem: TLabel
        Left = 394
        Top = 2
        Width = 100
        Height = 13
        AutoSize = False
        Caption = 'lblFnctoValorBem'
      end
      object lblInfFnctoValorBem: TLabel
        Left = 338
        Top = 2
        Width = 54
        Height = 13
        Caption = 'Valor Bem: '
      end
      object lblFnctoDescricaoBem: TLabel
        Left = 89
        Top = 32
        Width = 884
        Height = 35
        AutoSize = False
        Caption = 'lblFnctoDescricaoBem'
        WordWrap = True
      end
      object lblInfFnctoDescricaoBem: TLabel
        Left = 5
        Top = 32
        Width = 78
        Height = 13
        Caption = 'Descri'#231#227'o Bem: '
      end
      object lblFnctoCachFinanciado: TLabel
        Left = 230
        Top = 2
        Width = 100
        Height = 13
        AutoSize = False
        Caption = 'lblFnctoCachFinanciado'
      end
      object lblInfFnctoCachFinanciado: TLabel
        Left = 143
        Top = 2
        Width = 86
        Height = 13
        Caption = 'Cach Financiado: '
      end
    end
  end
  object pnlDivisao: TPanel
    Left = 0
    Top = 356
    Width = 990
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
  object pnlAgenciamentos: TPanel
    Left = 0
    Top = 372
    Width = 990
    Height = 334
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object lblDescricaoTela: TLabel
      Left = 8
      Top = 8
      Width = 533
      Height = 16
      Caption = 
        'Im'#243'veie de Interesse que podem atender as necessidades do Agenci' +
        'amento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAbrirExplicacaoRelevancia: TLabel
      Left = 914
      Top = 28
      Width = 58
      Height = 13
      Cursor = crHandPoint
      Caption = 'relev'#226'ncia ?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lblAbrirExplicacaoRelevanciaClick
    end
    object lblFiltrar: TLabel
      Left = 6
      Top = 28
      Width = 28
      Height = 13
      Caption = 'Filtrar:'
    end
    object lblTotalRegistros: TLabel
      Left = 890
      Top = 8
      Width = 96
      Height = 13
      Alignment = taRightJustify
      Caption = 'lblTotalRegistros'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbGrdImoveisInteresse: TDBGrid
      Left = 3
      Top = 46
      Width = 987
      Height = 327
      Hint = 'Im'#243'veis de Interesse que podem satisfazer o agenciamento'
      DataSource = dsImoveisInteresse
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = dbGrdImoveisInteresseDrawColumnCell
      OnDblClick = dbGrdImoveisInteresseDblClick
      OnTitleClick = dbGrdImoveisInteresseTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 37
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IGUAL_TIPO_IMOVEL'
          Title.Caption = 'Tipo Im'#243'vel'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TIPO_IMOVEL'
          Title.Caption = 'Tipo Im'#243'vel'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IGUAL_SITUACAO'
          Title.Caption = 'Situa'#231#227'o'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_SITUACAO'
          Title.Caption = 'Situa'#231#227'o'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IGUAL_CONDICAO_PAGAMENTO'
          Title.Caption = 'Cond. Pgto'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_CONDICAO_PAGAMENTO'
          Title.Caption = 'Cond. Pgto'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IGUAL_VALOR'
          Title.Caption = 'Valor'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_VALOR'
          Title.Caption = 'Valor'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IGUAL_CARACTERISTICAS_IMOVEL'
          Title.Caption = 'Carac. Im'#243'vel'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_CARACTERISTICAS_IMOVEL'
          Title.Caption = 'Carac. Im'#243'vel'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'IGUAL_REGIAO_LOCALIDADE'
          Title.Caption = 'Regi'#227'o Localidade'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_REGIAO_LOCALIDADE'
          Title.Caption = 'Regi'#227'o Localidade'
          Width = 80
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'PESO'
          Title.Caption = 'Relev'#226'ncia'
          Width = 60
          Visible = True
        end>
    end
    object ckBxTipoImovelIgual: TCheckBox
      Left = 67
      Top = 28
      Width = 92
      Height = 17
      Caption = 'Tipo do Im'#243'vel'
      TabOrder = 1
      OnClick = ckBxTipoImovelIgualClick
    end
    object ckBxSituacaoIgual: TCheckBox
      Left = 212
      Top = 28
      Width = 64
      Height = 17
      Caption = 'Situa'#231#227'o'
      TabOrder = 2
      OnClick = ckBxSituacaoIgualClick
    end
    object ckBxCondPgtoIgual: TCheckBox
      Left = 340
      Top = 28
      Width = 125
      Height = 17
      Caption = 'Condi'#231#227'o Pagamento'
      TabOrder = 3
      OnClick = ckBxCondPgtoIgualClick
    end
    object ckBxValorIgual: TCheckBox
      Left = 507
      Top = 28
      Width = 73
      Height = 17
      Caption = 'Valor Igual'
      TabOrder = 4
      OnClick = ckBxValorIgualClick
    end
    object ckBxCaracImovelIgual: TCheckBox
      Left = 622
      Top = 28
      Width = 142
      Height = 17
      Caption = 'Caracter'#237'sticas do Im'#243'vel'
      TabOrder = 5
      OnClick = ckBxCaracImovelIgualClick
    end
    object ckBxRegiaoLocalidadeIgual: TCheckBox
      Left = 792
      Top = 28
      Width = 112
      Height = 17
      Caption = 'Regi'#227'o Localidade'
      TabOrder = 6
      OnClick = ckBxRegiaoLocalidadeIgualClick
    end
    object StatusBar: TStatusBar
      Left = 0
      Top = 315
      Width = 990
      Height = 19
      Panels = <
        item
          Width = 50
        end>
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 944
    Top = 12
  end
  object zQryAgenciamento: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT a.codigo,a.data_agenciamento,a.ativo,a.normal,a.stand_by,'
      '       a.tipo_pessoa,'
      '       CASE WHEN a.tipo_pessoa ='#39'F'#205'SICA'#39' THEN apf.nome'
      '            WHEN a.tipo_pessoa = '#39'JUR'#205'DICA'#39' THEN apj.nome'
      '            ELSE '#39'NENHUMA'#39' END AS NOME_TIPO_PESSOA,'
      '       a.condicao_pagamento,a.valor_total,'
      
        '       a.pgto_vista_cach,a.pgto_vista_valor_bem,a.pgto_vista_des' +
        'cricao_bem,'
      
        '       a.pgto_fincto_cach,a.pgto_fincto_cach_financiado,a.pgto_f' +
        'incto_valor_bem,a.pgto_fincto_descricao_bem,'
      
        '       a.observacao,a.prazo_autorizacao,a.data_reagenciamento,a.' +
        'data_baixa,'
      '       i.codigo AS codigoImovel,'
      '       i.status,i.situacao_desejavel,i.descricao,'
      '       i.endereco_cep,i.endereco_complemento,'
      '       ti.nome AS nomeTipoImovel,'
      '       e.nome AS nomeEstado,e.sigla AS siglaEstado,'
      '       c.nome AS nomeCidade,'
      '       b.nome AS nomeBairro,'
      '       r.nome AS nomeRua,r.cep AS cepRua'
      'FROM agenciamentos a'
      
        'LEFT JOIN agenc_pessoa_fisica apf ON a.cod_fk_pessoa_fisica=apf.' +
        'codigo'
      
        'LEFT JOIN agenc_pessoa_juridica apj ON a.cod_fk_pessoa_juridica=' +
        'apj.codigo'
      'JOIN imovel i ON a.cod_fk_imovel=i.codigo'
      'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel=ti.codigo'
      'JOIN estado e ON i.cod_fk_estado=e.codigo'
      'JOIN cidade c ON i.cod_fk_cidade=c.codigo'
      'JOIN bairro b ON i.cod_fk_bairro=b.codigo'
      'JOIN rua r ON i.cod_fk_rua=r.codigo'
      'WHERE a.codigo=1'
      'AND 1=2')
    Params = <>
    Left = 216
    Top = 24
    object zQryAgenciamentoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryAgenciamentoDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
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
    object zQryAgenciamentoTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryAgenciamentoNOME_TIPO_PESSOA: TStringField
      FieldName = 'NOME_TIPO_PESSOA'
      ReadOnly = True
      Size = 100
    end
    object zQryAgenciamentoCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryAgenciamentoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
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
    object zQryAgenciamentoPGTO_FINCTO_CACH: TFloatField
      FieldName = 'PGTO_FINCTO_CACH'
    end
    object zQryAgenciamentoPGTO_FINCTO_CACH_FINANCIADO: TFloatField
      FieldName = 'PGTO_FINCTO_CACH_FINANCIADO'
    end
    object zQryAgenciamentoPGTO_FINCTO_VALOR_BEM: TFloatField
      FieldName = 'PGTO_FINCTO_VALOR_BEM'
    end
    object zQryAgenciamentoPGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_FINCTO_DESCRICAO_BEM'
      Size = 500
    end
    object zQryAgenciamentoOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object zQryAgenciamentoPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object zQryAgenciamentoDATA_REAGENCIAMENTO: TDateField
      FieldName = 'DATA_REAGENCIAMENTO'
    end
    object zQryAgenciamentoDATA_BAIXA: TDateField
      FieldName = 'DATA_BAIXA'
    end
    object zQryAgenciamentoCODIGOIMOVEL: TIntegerField
      FieldName = 'CODIGOIMOVEL'
      Required = True
    end
    object zQryAgenciamentoSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object zQryAgenciamentoSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zQryAgenciamentoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 500
    end
    object zQryAgenciamentoENDERECO_CEP: TStringField
      FieldName = 'ENDERECO_CEP'
      Size = 9
    end
    object zQryAgenciamentoENDERECO_COMPLEMENTO: TStringField
      FieldName = 'ENDERECO_COMPLEMENTO'
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
    object zQryAgenciamentoSIGLAESTADO: TStringField
      FieldName = 'SIGLAESTADO'
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
  object cdsImoveisInteresseFixo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 14
    Top = 467
  end
  object cdsImoveisInteresse: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = cdsImoveisInteresseAfterScroll
    Left = 14
    Top = 495
  end
  object dsImoveisInteresse: TDataSource
    DataSet = cdsImoveisInteresse
    Left = 43
    Top = 495
  end
  object ImageList: TImageList
    Left = 14
    Top = 525
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000F6FFF2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0000000000D8E9
      EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9EC00D8E9
      EC00D8E9EC00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000178F2A0018742500C6C9C70000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF0000000000000000000000000000000000000000000000
      000000000000358F4E00009607000087050058A56B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF0000000000000000000000000000000000000000000000
      000088B79D001483330000840100008C0700078A230000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF00000000000000000000000000000000000000000088B7
      9D0014833300008401000000000045AD58000074070077AF8400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF0000000000000000000000000000000000000000002163
      320014712C00000000000000000000000000238B2C002B713C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000088060040A756000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000148F2F001C7E32008FCD
      9F00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000148F2F001C7E
      32008FCD9F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000148F
      2F001C7E32008FCD9F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D8E9EC00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000148F2F001C7E32008FCD9F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D8E9EC00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000166E2C0019802F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099A8AC0099A8AC0099A8
      AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8AC0099A8
      AC0099A8AC000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000C8A2600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000D7B22000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFFFF00000000
      C003FEFF000000008003FC7F000000008003F87F000000008003F07F00000000
      8003E23F000000008003E73F000000008003FF9F000000008003FF8F00000000
      8003FFC7000000008003FFE3000000008003FFF1000000008003FFF900000000
      8007FFFD00000000FFFFFFFE0000000000000000000000000000000000000000
      000000000000}
  end
  object zQryCompletarImoveisInteresse: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT ii.codigo,ii.condicao_pagamento,ii.valor_imovel,'
      
        '       ii.imovel_desejavel,ii.caracteristicas,t.nome AS nomeTipo' +
        'Imovel'
      'FROM imovel_de_interesse ii'
      'JOIN tipo_imovel t ON ii.cod_fk_tipo_imovel=t.codigo'
      'WHERE ii.codigo = 1'
      'AND 1=2')
    Params = <>
    Left = 14
    Top = 553
    object zQryCompletarImoveisInteresseCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryCompletarImoveisInteresseCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryCompletarImoveisInteresseVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object zQryCompletarImoveisInteresseIMOVEL_DESEJAVEL: TStringField
      FieldName = 'IMOVEL_DESEJAVEL'
    end
    object zQryCompletarImoveisInteresseCARACTERISTICAS: TStringField
      FieldName = 'CARACTERISTICAS'
      Size = 500
    end
    object zQryCompletarImoveisInteresseNOMETIPOIMOVEL: TStringField
      FieldName = 'NOMETIPOIMOVEL'
      Required = True
      Size = 60
    end
  end
  object zQryCompletarRegiaoLocalidade: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      
        'SELECT iirl.cod_fk_imovel_de_interesse, rl.nome as nomeRegiaoLoc' +
        'alidade'
      'FROM regiao_localidade rl'
      
        'JOIN imov_interesse_regiao_local iirl ON iirl.cod_fk_regiao_loca' +
        'lidade=rl.codigo'
      'WHERE iirl.cod_fk_imovel_de_interesse IN (1,2,3)'
      'AND 1=2')
    Params = <>
    Left = 43
    Top = 553
    object zQryCompletarRegiaoLocalidadeCOD_FK_IMOVEL_DE_INTERESSE: TIntegerField
      FieldName = 'COD_FK_IMOVEL_DE_INTERESSE'
      Required = True
    end
    object zQryCompletarRegiaoLocalidadeNOMEREGIAOLOCALIDADE: TStringField
      FieldName = 'NOMEREGIAOLOCALIDADE'
      Required = True
      Size = 50
    end
  end
end
