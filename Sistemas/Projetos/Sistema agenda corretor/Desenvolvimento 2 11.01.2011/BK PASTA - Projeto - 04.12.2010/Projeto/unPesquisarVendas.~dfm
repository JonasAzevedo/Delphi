inherited frmPesquisarVendas: TfrmPesquisarVendas
  Caption = 'PESQUISAR POR VENDAS'
  ClientWidth = 579
  PixelsPerInch = 96
  TextHeight = 13
  inherited grpBxFiltroPesquisar: TGroupBox
    Width = 579
    Height = 113
    object lblCodigo: TLabel
      Left = 5
      Top = 44
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
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
    object pnlTipoVenda: TPanel
      Left = 2
      Top = 71
      Width = 489
      Height = 29
      BevelOuter = bvNone
      TabOrder = 1
      object lblTipoVenda: TLabel
        Left = 2
        Top = 9
        Width = 76
        Height = 13
        Caption = 'Tipo de Venda: '
      end
      object lblCampoObrigatorio5: TLabel
        Left = 78
        Top = 3
        Width = 6
        Height = 13
        Caption = '*'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblImovelDe: TLabel
        Left = 288
        Top = 8
        Width = 51
        Height = 13
        Caption = 'Im'#243'vel De:'
      end
      object Label2: TLabel
        Left = 342
        Top = 3
        Width = 6
        Height = 13
        Caption = '*'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object plsCbBxTipoVenda: TPlsComboBox
        Left = 87
        Top = 3
        Width = 164
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = plsCbBxTipoVendaChange
        Items.Strings = (
          'MEU AGENCIAMENTO'
          'PAUTA')
        plsCorRecebeFoco = clSilver
      end
      object plsCbBxImovelDe: TPlsComboBox
        Left = 352
        Top = 4
        Width = 135
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = plsCbBxImovelDeChange
        plsCorRecebeFoco = clSilver
      end
    end
    object grpBxDataVenda: TGroupBox
      Left = 151
      Top = 13
      Width = 193
      Height = 49
      Caption = 'Data da Venda '
      TabOrder = 2
      object lblEntreDataVenda: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedDataVendaInicio: TPlsMaskEdit
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
      object plsMedDataVendaFinal: TPlsMaskEdit
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
    object grpBxValorVenda: TGroupBox
      Left = 354
      Top = 13
      Width = 193
      Height = 49
      Caption = 'Valor da Venda '
      TabOrder = 3
      object lblEntreValorVenda: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedValorVendaInicio: TPlsEdit
        Left = 5
        Top = 20
        Width = 72
        Height = 21
        TabOrder = 0
        Text = 'plsMedValorVenda'
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario
      end
      object plsMedValorVendaFim: TPlsEdit
        Left = 113
        Top = 20
        Width = 73
        Height = 21
        TabOrder = 1
        Text = 'plsMedValorVendaFim'
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario
      end
    end
  end
  inherited dbGrdDadosPesquisa: TDBGrid
    Top = 113
    Width = 579
    Height = 318
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_VENDA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATIVO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_VENDA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IMOVEL_DE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VENDA_MEU_AGENCIAMENTO_MEU'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VENDA_MEU_AGENCIAMENTO_COLEGAS'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VENDA_PAUTA_CONSTRUTORA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VENDA_PAUTA_TERCEIROS'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_VENDA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEDUCOES'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_BEM_NEGOCIAVEL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEDUZIR_BEM_NEGOC_VALOR_VENDA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_PARA_CALCULO_COMISSAO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERCENTUAL_SOBRE_VENDA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_TOTAL_COMISSAO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERCENTUAL_SOBRE_COMISSAO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBSERVACAO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_CANCELAMENTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CLIENTE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_IMOVEL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS_IMOVEL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SITUACAO_DESEJAVEL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_IMOVEL_IMOVEL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_IMOVEL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_TIPO_IMOVEL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_TIPO_IMOVEL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_ESTADO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGLA_ESTADO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_CIDADE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CIDADE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_BAIRRO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_BAIRRO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODIGO_RUA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_RUA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP_RUA'
        Visible = True
      end>
  end
  inherited pnlBotoes: TPanel
    Width = 579
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT'
      '    v.codigo,v.data_venda,v.ativo,v.tipo_venda,'
      '    CASE WHEN v.venda_meu_agenciamento_meu = '#39'SIM'#39' THEN '#39'MEU'#39
      
        '         WHEN v.venda_meu_agenciamento_colegas = '#39'SIM'#39' THEN '#39'COL' +
        'EGAS'#39
      
        '         WHEN v.venda_pauta_construtora = '#39'SIM'#39' THEN '#39'CONSTRUTOR' +
        'A'#39
      '         WHEN v.venda_pauta_terceiros = '#39'SIM'#39' THEN '#39'TERCEIROS'#39
      '         ELSE '#39#39
      '    END AS IMOVEL_DE,'
      
        '    v.venda_meu_agenciamento_meu,v.venda_meu_agenciamento_colega' +
        's,'
      '    v.venda_pauta_construtora,v.venda_pauta_terceiros,'
      
        '    v.valor_venda,v.deducoes,v.valor_bem_negociavel,v.deduzir_be' +
        'm_negoc_valor_venda,'
      
        '    v.valor_para_calculo_comissao,v.percentual_sobre_venda,v.val' +
        'or_total_comissao,'
      
        '    v.percentual_sobre_comissao,v.observacao,v.data_cancelamento' +
        ','
      '    c.nome AS NOME_CLIENTE,'
      
        '    i.codigo AS CODIGO_IMOVEL,i.status AS STATUS_IMOVEL,i.situac' +
        'ao_desejavel,'
      
        '    CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL_IMOVE' +
        'L,'
      '    i.descricao AS DESCRICAO_IMOVEL,'
      '    ti.codigo AS CODIGO_TIPO_IMOVEL,ti.nome AS NOME_TIPO_IMOVEL,'
      '    est.codigo AS CODIGO_ESTADO,est.sigla AS SIGLA_ESTADO,'
      '    cid.codigo AS CODIGO_CIDADE,cid.nome AS NOME_CIDADE,'
      '    bai.codigo AS CODIGO_BAIRRO,bai.nome AS NOME_BAIRRO,'
      
        '    rua.codigo AS CODIGO_RUA,rua.nome AS NOME_RUA,rua.cep AS CEP' +
        '_RUA'
      'FROM vendas v'
      'JOIN cliente c ON v.cod_fk_cliente = c.codigo'
      'JOIN imovel i ON v.cod_fk_imovel = i.codigo'
      'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo'
      'JOIN estado est ON i.cod_fk_estado = est.codigo'
      'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo'
      'JOIN bairro bai ON i.cod_fk_bairro = bai.codigo'
      'JOIN rua rua ON i.cod_fk_rua = rua.codigo'
      'ORDER BY v.codigo')
    Top = 153
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosDATA_VENDA: TDateField
      FieldName = 'DATA_VENDA'
    end
    object zQryDadosATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      Size = 3
    end
    object zQryDadosTIPO_VENDA: TStringField
      FieldName = 'TIPO_VENDA'
      Required = True
      Size = 16
    end
    object zQryDadosIMOVEL_DE: TStringField
      FieldName = 'IMOVEL_DE'
      ReadOnly = True
      Size = 11
    end
    object zQryDadosVENDA_MEU_AGENCIAMENTO_MEU: TStringField
      FieldName = 'VENDA_MEU_AGENCIAMENTO_MEU'
      Required = True
      Size = 3
    end
    object zQryDadosVENDA_MEU_AGENCIAMENTO_COLEGAS: TStringField
      FieldName = 'VENDA_MEU_AGENCIAMENTO_COLEGAS'
      Size = 3
    end
    object zQryDadosVENDA_PAUTA_CONSTRUTORA: TStringField
      FieldName = 'VENDA_PAUTA_CONSTRUTORA'
      Required = True
      Size = 3
    end
    object zQryDadosVENDA_PAUTA_TERCEIROS: TStringField
      FieldName = 'VENDA_PAUTA_TERCEIROS'
      Size = 3
    end
    object zQryDadosVALOR_VENDA: TFloatField
      FieldName = 'VALOR_VENDA'
      Required = True
    end
    object zQryDadosDEDUCOES: TFloatField
      FieldName = 'DEDUCOES'
    end
    object zQryDadosVALOR_BEM_NEGOCIAVEL: TFloatField
      FieldName = 'VALOR_BEM_NEGOCIAVEL'
    end
    object zQryDadosDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField
      FieldName = 'DEDUZIR_BEM_NEGOC_VALOR_VENDA'
      Size = 3
    end
    object zQryDadosVALOR_PARA_CALCULO_COMISSAO: TFloatField
      FieldName = 'VALOR_PARA_CALCULO_COMISSAO'
    end
    object zQryDadosPERCENTUAL_SOBRE_VENDA: TFloatField
      FieldName = 'PERCENTUAL_SOBRE_VENDA'
    end
    object zQryDadosVALOR_TOTAL_COMISSAO: TFloatField
      FieldName = 'VALOR_TOTAL_COMISSAO'
    end
    object zQryDadosPERCENTUAL_SOBRE_COMISSAO: TFloatField
      FieldName = 'PERCENTUAL_SOBRE_COMISSAO'
    end
    object zQryDadosOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object zQryDadosDATA_CANCELAMENTO: TDateTimeField
      FieldName = 'DATA_CANCELAMENTO'
    end
    object zQryDadosNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Required = True
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
      ReadOnly = True
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
    Top = 153
  end
  inherited cdsDados: TClientDataSet
    Top = 153
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosDATA_VENDA: TDateField
      FieldName = 'DATA_VENDA'
    end
    object cdsDadosATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      Size = 3
    end
    object cdsDadosTIPO_VENDA: TStringField
      FieldName = 'TIPO_VENDA'
      Required = True
      Size = 16
    end
    object cdsDadosIMOVEL_DE: TStringField
      FieldName = 'IMOVEL_DE'
      ReadOnly = True
      Size = 11
    end
    object cdsDadosVENDA_MEU_AGENCIAMENTO_MEU: TStringField
      FieldName = 'VENDA_MEU_AGENCIAMENTO_MEU'
      Required = True
      Size = 3
    end
    object cdsDadosVENDA_MEU_AGENCIAMENTO_COLEGAS: TStringField
      FieldName = 'VENDA_MEU_AGENCIAMENTO_COLEGAS'
      Size = 3
    end
    object cdsDadosVENDA_PAUTA_CONSTRUTORA: TStringField
      FieldName = 'VENDA_PAUTA_CONSTRUTORA'
      Required = True
      Size = 3
    end
    object cdsDadosVENDA_PAUTA_TERCEIROS: TStringField
      FieldName = 'VENDA_PAUTA_TERCEIROS'
      Size = 3
    end
    object cdsDadosVALOR_VENDA: TFloatField
      FieldName = 'VALOR_VENDA'
      Required = True
    end
    object cdsDadosDEDUCOES: TFloatField
      FieldName = 'DEDUCOES'
    end
    object cdsDadosVALOR_BEM_NEGOCIAVEL: TFloatField
      FieldName = 'VALOR_BEM_NEGOCIAVEL'
    end
    object cdsDadosDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField
      FieldName = 'DEDUZIR_BEM_NEGOC_VALOR_VENDA'
      Size = 3
    end
    object cdsDadosVALOR_PARA_CALCULO_COMISSAO: TFloatField
      FieldName = 'VALOR_PARA_CALCULO_COMISSAO'
    end
    object cdsDadosPERCENTUAL_SOBRE_VENDA: TFloatField
      FieldName = 'PERCENTUAL_SOBRE_VENDA'
    end
    object cdsDadosVALOR_TOTAL_COMISSAO: TFloatField
      FieldName = 'VALOR_TOTAL_COMISSAO'
    end
    object cdsDadosPERCENTUAL_SOBRE_COMISSAO: TFloatField
      FieldName = 'PERCENTUAL_SOBRE_COMISSAO'
    end
    object cdsDadosOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object cdsDadosDATA_CANCELAMENTO: TDateTimeField
      FieldName = 'DATA_CANCELAMENTO'
    end
    object cdsDadosNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      Required = True
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
      ReadOnly = True
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
    Top = 153
  end
end
