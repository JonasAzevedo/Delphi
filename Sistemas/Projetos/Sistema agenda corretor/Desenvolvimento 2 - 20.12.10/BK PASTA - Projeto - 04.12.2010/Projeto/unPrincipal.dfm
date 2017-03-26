object frmPrincipal: TfrmPrincipal
  Left = -7
  Top = -7
  Width = 1292
  Height = 751
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'GICI - Gerenciamento de Informa'#231#245'es para Corretor Imobili'#225'rio'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = mainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 678
    Width = 1284
    Height = 19
    Panels = <>
  end
  object pnlInformacoesLadoEsquerdo: TPanel
    Left = 1099
    Top = 0
    Width = 185
    Height = 678
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object grpBxCompromissosAgenda: TGroupBox
      Left = 0
      Top = 0
      Width = 185
      Height = 130
      Align = alTop
      Caption = 'Compromissos '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object lblCompromissosHoje: TLabel
        Left = 2
        Top = 32
        Width = 38
        Height = 16
        Caption = 'Hoje:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCompromissoProximos7Dias: TLabel
        Left = 2
        Top = 62
        Width = 117
        Height = 16
        Caption = 'Pr'#243'ximos 7 Dias:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalCompromissosEmAberto: TLabel
        Left = 2
        Top = 92
        Width = 77
        Height = 16
        Caption = 'Em Aberto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotCompromissosHoje: TLabel
        Left = 133
        Top = 32
        Width = 177
        Height = 16
        Cursor = crHandPoint
        Caption = 'lblTotCompromissosHoje'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = lblTotCompromissosHojeClick
      end
      object lblTotCompromissoProximos7Dias: TLabel
        Left = 133
        Top = 62
        Width = 240
        Height = 16
        Cursor = crHandPoint
        Caption = 'lblTotCompromissoProximos7Dias'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = lblTotCompromissoProximos7DiasClick
      end
      object lblTotTotalCompromissosEmAberto: TLabel
        Left = 133
        Top = 92
        Width = 248
        Height = 16
        Cursor = crHandPoint
        Caption = 'lblTotTotalCompromissosEmAberto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = lblTotTotalCompromissosEmAbertoClick
      end
      object lblMaisCompromissos: TLabel
        Left = 170
        Top = 8
        Width = 11
        Height = 20
        Cursor = crHandPoint
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlBottom
        Visible = False
        OnClick = lblMaisCompromissosClick
      end
      object lblMenosCompromissos: TLabel
        Left = 170
        Top = 108
        Width = 7
        Height = 20
        Cursor = crHandPoint
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlBottom
        OnClick = lblMenosCompromissosClick
      end
    end
    object pnlDivisao1: TPanel
      Left = 0
      Top = 130
      Width = 185
      Height = 10
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
    end
    object grpBxAgenciamentosStandBy: TGroupBox
      Left = 0
      Top = 140
      Width = 185
      Height = 235
      Align = alTop
      Caption = 'Agenciamentos - StandBy '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object lblTituloTotalAgenciamentosStandBy: TLabel
        Left = 8
        Top = 200
        Width = 30
        Height = 13
        Caption = 'Total: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTotalAgenciamentosStandBy: TLabel
        Left = 41
        Top = 200
        Width = 51
        Height = 13
        Caption = '                 '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblMenosAgenciamentosStandBy: TLabel
        Left = 170
        Top = 205
        Width = 7
        Height = 20
        Cursor = crHandPoint
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlBottom
        OnClick = lblMenosAgenciamentosStandByClick
      end
      object lblMaisAgenciamentosStandBy: TLabel
        Left = 170
        Top = 8
        Width = 11
        Height = 20
        Cursor = crHandPoint
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlBottom
        Visible = False
        OnClick = lblMaisAgenciamentosStandByClick
      end
      object lblVerDetalhesAgenciamentosStandBy: TLabel
        Left = 8
        Top = 216
        Width = 61
        Height = 13
        Cursor = crHandPoint
        Caption = 'Ver Detalhes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = lblVerDetalhesAgenciamentosStandByClick
      end
      object dbGrdAgenciamentosStandBy: TDBGrid
        Left = 8
        Top = 32
        Width = 169
        Height = 161
        DataSource = dsAgenciamentosStandBy
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        PopupMenu = ppMnAgenciamentosStandBy
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        OnDblClick = mnItFinalizarCadastroClick
        Columns = <
          item
            Expanded = False
            FieldName = 'DATA_AGENCIAMENTO'
            Title.Caption = 'Data Agenciamento'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 97
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TIPO_PESSOA'
            Title.Caption = 'Tipo Pessoa'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONDICAO_PAGAMENTO'
            Title.Caption = 'Pagamento'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMETIPOIMOVEL'
            Title.Caption = 'Tipo Im'#243'vel'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SIGLA'
            Title.Caption = 'UF'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 22
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMECIDADE'
            Title.Caption = 'Cidade'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 120
            Visible = True
          end>
      end
    end
    object pnlDivisao2: TPanel
      Left = 0
      Top = 375
      Width = 185
      Height = 10
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
    end
    object grpBxAgenciamentosExpirando: TGroupBox
      Left = 0
      Top = 385
      Width = 185
      Height = 235
      Align = alTop
      Caption = 'Agenciamentos - Expirando'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object lblMaisAgenciamentosExpirando: TLabel
        Left = 170
        Top = 8
        Width = 11
        Height = 20
        Cursor = crHandPoint
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlBottom
        Visible = False
        OnClick = lblMaisAgenciamentosExpirandoClick
      end
      object lblTituloTotalAgenciamentosExpirando: TLabel
        Left = 8
        Top = 200
        Width = 30
        Height = 13
        Caption = 'Total: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblVerDetalhesAgenciamentosExpirando: TLabel
        Left = 8
        Top = 216
        Width = 61
        Height = 13
        Cursor = crHandPoint
        Caption = 'Ver Detalhes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = lblVerDetalhesAgenciamentosStandByClick
      end
      object lblMenosAgenciamentosExpirando: TLabel
        Left = 170
        Top = 205
        Width = 7
        Height = 20
        Cursor = crHandPoint
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlBottom
        OnClick = lblMenosAgenciamentosExpirandoClick
      end
      object lblTotalAgenciamentosExpirando: TLabel
        Left = 41
        Top = 200
        Width = 51
        Height = 13
        Caption = '                 '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dbGrdAgenciamentosExpirando: TDBGrid
        Left = 8
        Top = 32
        Width = 169
        Height = 161
        DataSource = dsAgenciamentosExpirando
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        PopupMenu = ppMnAgenciamentosExpirando
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        OnDblClick = mnItEditarAgenciamentoExpirandoClick
        Columns = <
          item
            Expanded = False
            FieldName = 'DATA_AGENCIAMENTO'
            Title.Caption = 'Data Agenciamento'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 97
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRAZO_AUTORIZACAO'
            Title.Caption = 'Prazo Autoriza'#231#227'o'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 97
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TIPO_PESSOA'
            Title.Caption = 'Tipo Pessoa'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CONDICAO_PAGAMENTO'
            Title.Caption = 'Pagamento'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMETIPOIMOVEL'
            Title.Caption = 'Tipo Im'#243'vel'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SIGLA'
            Title.Caption = 'UF'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 22
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMECIDADE'
            Title.Caption = 'Cidade'
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clWindowText
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 120
            Visible = True
          end>
      end
    end
  end
  object pnlDetalheAgenciamentosStandBy: TPanel
    Left = 104
    Top = 32
    Width = 921
    Height = 521
    TabOrder = 2
    Visible = False
    object pnlBarraDetalhesAgenciamentosStandBy: TPanel
      Left = 1
      Top = 502
      Width = 919
      Height = 18
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object lblEsconderDetalhesAgenciamentosStandBy: TLabel
        Left = 869
        Top = 3
        Width = 45
        Height = 13
        Cursor = crHandPoint
        Caption = 'Esconder'
        OnClick = lblEsconderDetalhesAgenciamentosStandByClick
      end
    end
    object dbGrdDetalheAgenciamentosStandBy: TDBGrid
      Left = 1
      Top = 1
      Width = 919
      Height = 501
      Align = alClient
      DataSource = dsAgenciamentosStandBy
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = ppMnAgenciamentosStandBy2
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'DATA_AGENCIAMENTO'
          Title.Caption = 'Data Agenciamento'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPO_PESSOA'
          Title.Caption = 'Tipo Pessoa'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CONDICAO_PAGAMENTO'
          Title.Caption = 'Pagamento'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Title.Caption = 'Valor Total'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRAZO_AUTORIZACAO'
          Title.Caption = 'Prazo Autoriza'#231#227'o'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SITUACAO_DESEJAVEL'
          Title.Caption = 'Situa'#231#227'o Desej'#225'vel'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMETIPOIMOVEL'
          Title.Caption = 'Tipo do Im'#243'vel'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SIGLA'
          Title.Caption = 'UF'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMECIDADE'
          Title.Caption = 'Cidade'
          Width = 120
          Visible = True
        end>
    end
  end
  object mainMenu: TMainMenu
    Left = 24
    Top = 16
    object menuCadastro: TMenuItem
      Caption = 'Cadastro'
      object mnItCidades: TMenuItem
        Caption = 'Cidades...'
        OnClick = mnItCidadesClick
      end
      object mnItBairros: TMenuItem
        Caption = 'Bairros...'
        OnClick = mnItBairrosClick
      end
      object mnItRuas: TMenuItem
        Caption = 'Ruas...'
        OnClick = mnItRuasClick
      end
      object mnItDivisao1: TMenuItem
        Caption = '-'
      end
      object mnItConstrutoras: TMenuItem
        Caption = 'Construtoras...'
        OnClick = mnItConstrutorasClick
      end
      object mnItProfissoes: TMenuItem
        Caption = 'Profiss'#245'es...'
        OnClick = mnItProfissoesClick
      end
      object mnItMeioCaptacao: TMenuItem
        Caption = 'Meio de Capta'#231#227'o...'
        OnClick = mnItMeioCaptacaoClick
      end
      object mnItDivisao2: TMenuItem
        Caption = '-'
      end
      object mnItClientes: TMenuItem
        Caption = 'Clientes..'
        OnClick = mnItClientesClick
      end
      object mnItPessoaFisica: TMenuItem
        Caption = 'Pessoa F'#237'sica...'
        OnClick = mnItPessoaFisicaClick
      end
      object mnItPessoaJuridica: TMenuItem
        Caption = 'Pessoa Jur'#237'dica...'
        OnClick = mnItPessoaJuridicaClick
      end
    end
    object menuImovel: TMenuItem
      Caption = 'Im'#243'vel'
      object mnItTipoImovel: TMenuItem
        Caption = 'Tipo de Im'#243'vel...'
        OnClick = mnItTipoImovelClick
      end
      object mnItImovel: TMenuItem
        Caption = 'Im'#243'vel...'
        OnClick = mnItImovelClick
      end
      object mnItAgenciamentos: TMenuItem
        Caption = 'Agenciamentos...'
        OnClick = mnItAgenciamentosClick
      end
      object mnItImovelDeInteresse: TMenuItem
        Caption = 'Im'#243'vel de Interesse...'
        OnClick = mnItImovelDeInteresseClick
      end
      object mnItVendas: TMenuItem
        Caption = 'Vendas...'
        OnClick = mnItVendasClick
      end
    end
    object mnItConsultar: TMenuItem
      Caption = 'Consultar'
      object mnItPesquisarAgenciamentos: TMenuItem
        Caption = 'Agenciamentos...'
        OnClick = mnItPesquisarAgenciamentosClick
      end
      object mnItPesquisarImoveisdeInteresse: TMenuItem
        Caption = 'Im'#243'veis de Interesse...'
        OnClick = mnItPesquisarImoveisdeInteresseClick
      end
      object mnItPesquisarVendas: TMenuItem
        Caption = 'Vendas...'
        OnClick = mnItPesquisarVendasClick
      end
    end
    object mnItAgenda: TMenuItem
      Caption = 'Agenda'
      object mnItNovoCompromisso: TMenuItem
        Caption = 'Novo Compromisso...'
        OnClick = mnItNovoCompromissoClick
      end
      object mnItConsultaCompromisso: TMenuItem
        Caption = 'Consulta...'
        OnClick = mnItConsultaCompromissoClick
      end
    end
    object mnItConfiguracoes: TMenuItem
      Caption = 'Configura'#231#245'es'
      object mnItAlterarSenha: TMenuItem
        Caption = 'Alterar Senha...'
        OnClick = mnItAlterarSenhaClick
      end
    end
    object mnItAjuda: TMenuItem
      Caption = 'Ajuda'
      object mnItSobre: TMenuItem
        Caption = 'Sobre...'
        OnClick = mnItSobreClick
      end
    end
  end
  object zQryAgenda: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT COUNT(codigo) AS total'
      'FROM agenda'
      'WHERE 1=2')
    Params = <>
    Left = 1152
    Top = 16
    object zQryAgendaTOTAL: TIntegerField
      FieldName = 'TOTAL'
      ReadOnly = True
    end
  end
  object tmrCompromissosAgenda: TTimer
    Enabled = False
    Interval = 600000
    OnTimer = tmrCompromissosAgendaTimer
    Left = 1181
    Top = 16
  end
  object zQryAgenciamentosStandBy: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT a.codigo,a.data_agenciamento,a.stand_by,a.tipo_pessoa,'
      
        '       a.cod_fk_pessoa_fisica,a.cod_fk_pessoa_juridica,a.cod_fk_' +
        'imovel,'
      '       a.condicao_pagamento,a.valor_total,a.prazo_autorizacao,'
      '       pf.nome AS nomePessoaFisica,'
      '       pj.nome AS nomePessoaJuridica,'
      
        '       i.cod_fk_tipo_imovel,i.cod_fk_estado,i.cod_fk_cidade,i.si' +
        'tuacao_desejavel,i.valor_imovel,'
      '       ti.nome AS nomeTipoImovel,'
      '       est.nome AS nomeEstado,est.sigla,'
      '       cid.nome AS nomeCidade'
      ''
      'FROM agenciamentos a'
      'JOIN pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo'
      'JOIN pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo'
      'JOIN imovel i ON a.cod_fk_imovel = i.codigo'
      'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo'
      'JOIN estado est ON i.cod_fk_estado = est.codigo'
      'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo'
      ''
      'WHERE a.stand_by = '#39'SIM'#39)
    Params = <>
    Left = 1120
    Top = 216
    object zQryAgenciamentosStandByCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryAgenciamentosStandByDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
    end
    object zQryAgenciamentosStandBySTAND_BY: TStringField
      FieldName = 'STAND_BY'
      Size = 5
    end
    object zQryAgenciamentosStandByTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryAgenciamentosStandByCOD_FK_PESSOA_FISICA: TIntegerField
      FieldName = 'COD_FK_PESSOA_FISICA'
    end
    object zQryAgenciamentosStandByCOD_FK_PESSOA_JURIDICA: TIntegerField
      FieldName = 'COD_FK_PESSOA_JURIDICA'
    end
    object zQryAgenciamentosStandByCOD_FK_IMOVEL: TIntegerField
      FieldName = 'COD_FK_IMOVEL'
    end
    object zQryAgenciamentosStandByCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryAgenciamentosStandByVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
    object zQryAgenciamentosStandByPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object zQryAgenciamentosStandByNOMEPESSOAFISICA: TStringField
      FieldName = 'NOMEPESSOAFISICA'
      Size = 100
    end
    object zQryAgenciamentosStandByNOMEPESSOAJURIDICA: TStringField
      FieldName = 'NOMEPESSOAJURIDICA'
      Size = 100
    end
    object zQryAgenciamentosStandByCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object zQryAgenciamentosStandByCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zQryAgenciamentosStandByCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zQryAgenciamentosStandBySITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zQryAgenciamentosStandByVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object zQryAgenciamentosStandByNOMETIPOIMOVEL: TStringField
      FieldName = 'NOMETIPOIMOVEL'
      Required = True
      Size = 60
    end
    object zQryAgenciamentosStandByNOMEESTADO: TStringField
      FieldName = 'NOMEESTADO'
      Required = True
      Size = 50
    end
    object zQryAgenciamentosStandBySIGLA: TStringField
      FieldName = 'SIGLA'
      Required = True
      Size = 2
    end
    object zQryAgenciamentosStandByNOMECIDADE: TStringField
      FieldName = 'NOMECIDADE'
      Required = True
      Size = 100
    end
  end
  object dsAgenciamentosStandBy: TDataSource
    DataSet = zQryAgenciamentosStandBy
    Left = 1148
    Top = 216
  end
  object ppMnAgenciamentosStandBy: TPopupMenu
    Left = 1120
    Top = 245
    object mnItFinalizarCadastro: TMenuItem
      Caption = 'Finalizar Cadastro...'
      OnClick = mnItFinalizarCadastroClick
    end
  end
  object ppMnAgenciamentosStandBy2: TPopupMenu
    Left = 120
    Top = 80
    object mnItFinalizarCadastro2: TMenuItem
      Caption = 'Finalizar Cadastro...'
    end
  end
  object zQryAgenciamentosExpirando: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT a.codigo,a.data_agenciamento,a.stand_by,a.tipo_pessoa,'
      
        '       a.cod_fk_pessoa_fisica,a.cod_fk_pessoa_juridica,a.cod_fk_' +
        'imovel,'
      '       a.condicao_pagamento,a.valor_total,a.prazo_autorizacao,'
      '       pf.nome AS nomePessoaFisica,'
      '       pj.nome AS nomePessoaJuridica,'
      
        '       i.cod_fk_tipo_imovel,i.cod_fk_estado,i.cod_fk_cidade,i.si' +
        'tuacao_desejavel,i.valor_imovel,'
      '       ti.nome AS nomeTipoImovel,'
      '       est.nome AS nomeEstado,est.sigla,'
      '       cid.nome AS nomeCidade'
      'FROM agenciamentos a'
      'JOIN pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo'
      'JOIN pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo'
      'JOIN imovel i ON a.cod_fk_imovel = i.codigo'
      'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo'
      'JOIN estado est ON i.cod_fk_estado = est.codigo'
      'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo'
      ''
      'WHERE a.ativo = '#39'SIM'#39
      'AND a.data_baixa < current_timestamp')
    Params = <>
    Left = 1120
    Top = 457
    object zQryAgenciamentosExpirandoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryAgenciamentosExpirandoDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
    end
    object zQryAgenciamentosExpirandoSTAND_BY: TStringField
      FieldName = 'STAND_BY'
      Size = 5
    end
    object zQryAgenciamentosExpirandoTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryAgenciamentosExpirandoCOD_FK_PESSOA_FISICA: TIntegerField
      FieldName = 'COD_FK_PESSOA_FISICA'
    end
    object zQryAgenciamentosExpirandoCOD_FK_PESSOA_JURIDICA: TIntegerField
      FieldName = 'COD_FK_PESSOA_JURIDICA'
    end
    object zQryAgenciamentosExpirandoCOD_FK_IMOVEL: TIntegerField
      FieldName = 'COD_FK_IMOVEL'
    end
    object zQryAgenciamentosExpirandoCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryAgenciamentosExpirandoVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
    object zQryAgenciamentosExpirandoPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object zQryAgenciamentosExpirandoNOMEPESSOAFISICA: TStringField
      FieldName = 'NOMEPESSOAFISICA'
      Size = 100
    end
    object zQryAgenciamentosExpirandoNOMEPESSOAJURIDICA: TStringField
      FieldName = 'NOMEPESSOAJURIDICA'
      Size = 100
    end
    object zQryAgenciamentosExpirandoCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object zQryAgenciamentosExpirandoCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zQryAgenciamentosExpirandoCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zQryAgenciamentosExpirandoSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zQryAgenciamentosExpirandoVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object zQryAgenciamentosExpirandoNOMETIPOIMOVEL: TStringField
      FieldName = 'NOMETIPOIMOVEL'
      Required = True
      Size = 60
    end
    object zQryAgenciamentosExpirandoNOMEESTADO: TStringField
      FieldName = 'NOMEESTADO'
      Required = True
      Size = 50
    end
    object zQryAgenciamentosExpirandoSIGLA: TStringField
      FieldName = 'SIGLA'
      Required = True
      Size = 2
    end
    object zQryAgenciamentosExpirandoNOMECIDADE: TStringField
      FieldName = 'NOMECIDADE'
      Required = True
      Size = 100
    end
  end
  object dsAgenciamentosExpirando: TDataSource
    DataSet = zQryAgenciamentosExpirando
    Left = 1148
    Top = 457
  end
  object ppMnAgenciamentosExpirando: TPopupMenu
    Left = 1122
    Top = 487
    object mnItEditarAgenciamentoExpirando: TMenuItem
      Caption = 'Editar'
      OnClick = mnItEditarAgenciamentoExpirandoClick
    end
  end
end
