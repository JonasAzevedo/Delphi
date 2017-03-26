inherited frmPesquisarImoveisInteresse: TfrmPesquisarImoveisInteresse
  Left = 203
  Top = 217
  Caption = 'PESQUISAR POR IM'#211'VEIS DE INTERESSE'
  ClientWidth = 903
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited grpBxFiltroPesquisar: TGroupBox
    Width = 903
    Height = 193
    object lblCodigo: TLabel
      Left = 10
      Top = 44
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object lblFinalidade: TLabel
      Left = 572
      Top = 76
      Width = 51
      Height = 13
      Caption = 'Finalidade:'
    end
    object lblSituacao: TLabel
      Left = 722
      Top = 76
      Width = 45
      Height = 13
      Caption = 'Situa'#231#227'o:'
    end
    object lblCondicaoPagamento: TLabel
      Left = 10
      Top = 74
      Width = 120
      Height = 13
      Caption = 'Condi'#231#227'o de Pagamento:'
    end
    object lblStatus: TLabel
      Left = 136
      Top = 22
      Width = 33
      Height = 13
      Caption = 'Status:'
    end
    object lblCaracteristica: TLabel
      Left = 557
      Top = 137
      Width = 75
      Height = 13
      Cursor = crHandPoint
      Caption = 'Caracter'#237'stica:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic, fsUnderline]
      ParentFont = False
      OnClick = lblCaracteristicaClick
    end
    object lblFiltrosUsados: TLabel
      Left = 84
      Top = 175
      Width = 3
      Height = 13
    end
    object lblNomeFiltrosUsados: TLabel
      Left = 6
      Top = 175
      Width = 69
      Height = 13
      Caption = 'Filtros Usados:'
    end
    object plsEdCodigo: TPlsEdit
      Left = 54
      Top = 39
      Width = 66
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object plsCbBxFinalidade: TPlsComboBox
      Left = 572
      Top = 93
      Width = 141
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 7
      Items.Strings = (
        'MORAR'
        'INVESTIR')
      plsCorRecebeFoco = clSilver
    end
    object plsCbBxSituacao: TPlsComboBox
      Left = 722
      Top = 93
      Width = 173
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 8
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
      Left = 368
      Top = 65
      Width = 193
      Height = 49
      Caption = 'Data da Capta'#231#227'o '
      TabOrder = 6
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
      Top = 65
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
    object plsCbBxStatus: TPlsComboBox
      Left = 136
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
    object rdGrpTipoPessoa: TRadioGroup
      Left = 252
      Top = 20
      Width = 146
      Height = 40
      Caption = 'Tipo Pessoa '
      Columns = 2
      Items.Strings = (
        'F'#237'sica'
        'Jur'#237'dica')
      TabOrder = 2
    end
    object grpBxNomePessoa: TGroupBox
      Left = 404
      Top = 20
      Width = 492
      Height = 40
      Caption = 'Nome Pessoa '
      TabOrder = 3
      object plsEdNomePessoa: TPlsEdit
        Left = 7
        Top = 14
        Width = 478
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
        Text = 'PLSEDNOMEPESSOA'
        plsCorRecebeFoco = clSilver
      end
    end
    object pnlTipoImovel: TPanel
      Left = 9
      Top = 128
      Width = 257
      Height = 27
      BevelOuter = bvNone
      TabOrder = 9
      object lblTipoImovel: TLabel
        Left = 1
        Top = 10
        Width = 73
        Height = 13
        Caption = 'Tipo de Im'#243'vel:'
      end
      object spBtnBuscaTipoImovel: TSpeedButton
        Left = 232
        Top = 2
        Width = 22
        Height = 21
        Cursor = crHandPoint
        Hint = 'Selecionar Tipo de Im'#243'vel'
        Flat = True
        Glyph.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          18000000000074030000C40E0000C40E00000000000000000000FCFDFFF9FEFE
          FBFFFBFFFDFEFFFCFFEFF1FAD2E1EDF5FCFDFFFEFCFBFEFDF9FFFFFBFFFFFEFF
          FFFFFFFFFFFFFFFFFEFFFFFDFF00FFFBFEF6FEFCF1FFFBFEFDFEFFFFFFA5AFC9
          6E97AD9CBBC9FFFFFFFBFEFEFBFFFFFBFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFE
          FF00FFFAFEF2FFFAE7FFFAFBFFFEFFF8FF90A3C279BEDA5188A5EBF5FFFEFFFF
          FDFFFFFEFFFFFDFEFEFFFFFFFFFFFFFFFFFFFFFFFF00FFFAFDF2FFF9E2FFF8FA
          FDFDFFFEFFADC5DF73C3E34383A8C5D0E3FFFFFFFFFEFEFDFDFDFDFDFDFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFAFEF5FFFAE9FFF8FAFEFDFFFCFFC4DAE980C8E463
          9EBE99A5C0FFFFFFFEFEFEFBFBFBFDFEFEFEFEFEFFFFFFFDFFFFFDFFFF00FFFB
          FFF8FFFAF4FFF6FDFEF9FFFDFFE5F8FE8DBBD0ACD0E8777E96F5F5F6FFFFFFFD
          FCFCFDFCFCFDFDFDFEFFFFFBFFFFFBFFFF00FAFDFFFCFFFCFEFFF5FFFFF6FAFE
          FBF3FFFFBCCEDC8590A2828391F4F1F3FFFEFFFFFFFFFFFEFEFEFEFEFEFFFFFB
          FFFFFAFFFF00F5FDFFFDFFFDFFFFF8FEFFF6FAFFFAFBFFFFFFFFFFB3ACB1C3BC
          BDB4AFAEADAAA7D1CCCCFEFFFFFFFFFFFEFEFEFCFEFEFAFEFE00FBFDFFFCFDFE
          FFFDFFFFFEFEFFFEFDFBF9F5C0B2A6A69281D0BFAACFD2BFD1D3C4AFAEA3C6C1
          BCFFFDFCFFFCFEFCFBFDFAFEFE00FFFEFFFCFDFFFFFDFFFFFEFFFFFFFFDBD7D2
          746557B8A591EAD7BFD9D8BFE9E9D3FAF4E4A99E96E5E0DDFFFFFFFFFCFFFAFF
          FF00FFFEFFFEFEFFFFFEFFFFFDFFFFFFFFA9A09A9F9386DFCFBCE4D3BDE1D8BC
          E5DEC5ECE2D0C2B6ACBEB2ADFFFFFFFEFEFEFAFDFD00FFFEFFFFFEFFFFFEFFFF
          FDFFFFFFFFA49D98C5B9AFF4E6D6EEDCCAE4D6B9D9CCB0E2D3BFAB9D92BBADA8
          FFFFFEFEFEFFF9FCFE00FFFDFFFFFEFFFDFEFFFDFEFFFFFFFFCCC7C4B3AAA0FD
          F0E4E4D4C1DBC8AED3C2A7C3B49F8E8175E5DDD8FFFFFFFEFCFFFBFEFF00FFFD
          FFFFFDFFFBFEFFFCFEFFFFFFFFF3F0F0988E87BEB3A8CDBEAEBCA993B29E8983
          7262B1A69BFFFFFFFFFFFFFFFEFFFCFFFF00FFFFFFFFFDFFFBFEFFFCFEFFFFFC
          FFFFFFFFF6F1EF978F877B6E63725F53806E63ACA097FFFEFCFFFFFFFDFFFFFE
          FFFFFCFFFD00FFFFFFFFFDFFFCFEFFFCFEFFFDFEFFFBFAF9FFFFFFFFFFFFEEE8
          E1EAE4DFF2ECE8FFFFFFFCFCFEFCFDFCFBFEFFFCFFFFFFFFFD00FFFFFFFFFDFF
          FCFEFFFDFEFFF9F8FAFEFDFDFFFDFBFEFDF8FFFFFAFFFFFFFFFFFFFFFDFFF9F8
          FCF9FBFDF9FDFFFDFFFFFFFFFD00}
        OnClick = spBtnBuscaTipoImovelClick
      end
      object plsEdTipoImovel: TPlsEdit
        Left = 80
        Top = 2
        Width = 153
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 60
        TabOrder = 0
        OnExit = plsEdTipoImovelExit
        plsCorRecebeFoco = clSilver
      end
    end
    object plsMmCaracteristica: TPlsMemo
      Left = 632
      Top = 123
      Width = 261
      Height = 27
      Lines.Strings = (
        'plsMmCaracteristica')
      MaxLength = 500
      TabOrder = 11
      plsCorRecebeFoco = clSilver
    end
    object pnlRegiaoLocalidade: TPanel
      Left = 268
      Top = 128
      Width = 283
      Height = 27
      BevelOuter = bvNone
      TabOrder = 10
      object lblRegiaoLocalidade: TLabel
        Left = 1
        Top = 10
        Width = 92
        Height = 13
        Caption = 'Regi'#227'o Localidade:'
      end
      object spBtnBuscaRegiaoLocalidade: TSpeedButton
        Left = 257
        Top = 2
        Width = 22
        Height = 21
        Cursor = crHandPoint
        Hint = 'Selecionar Regi'#227'o Localidade'
        Flat = True
        Glyph.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          18000000000074030000C40E0000C40E00000000000000000000FCFDFFF9FEFE
          FBFFFBFFFDFEFFFCFFEFF1FAD2E1EDF5FCFDFFFEFCFBFEFDF9FFFFFBFFFFFEFF
          FFFFFFFFFFFFFFFFFEFFFFFDFF00FFFBFEF6FEFCF1FFFBFEFDFEFFFFFFA5AFC9
          6E97AD9CBBC9FFFFFFFBFEFEFBFFFFFBFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFE
          FF00FFFAFEF2FFFAE7FFFAFBFFFEFFF8FF90A3C279BEDA5188A5EBF5FFFEFFFF
          FDFFFFFEFFFFFDFEFEFFFFFFFFFFFFFFFFFFFFFFFF00FFFAFDF2FFF9E2FFF8FA
          FDFDFFFEFFADC5DF73C3E34383A8C5D0E3FFFFFFFFFEFEFDFDFDFDFDFDFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFAFEF5FFFAE9FFF8FAFEFDFFFCFFC4DAE980C8E463
          9EBE99A5C0FFFFFFFEFEFEFBFBFBFDFEFEFEFEFEFFFFFFFDFFFFFDFFFF00FFFB
          FFF8FFFAF4FFF6FDFEF9FFFDFFE5F8FE8DBBD0ACD0E8777E96F5F5F6FFFFFFFD
          FCFCFDFCFCFDFDFDFEFFFFFBFFFFFBFFFF00FAFDFFFCFFFCFEFFF5FFFFF6FAFE
          FBF3FFFFBCCEDC8590A2828391F4F1F3FFFEFFFFFFFFFFFEFEFEFEFEFEFFFFFB
          FFFFFAFFFF00F5FDFFFDFFFDFFFFF8FEFFF6FAFFFAFBFFFFFFFFFFB3ACB1C3BC
          BDB4AFAEADAAA7D1CCCCFEFFFFFFFFFFFEFEFEFCFEFEFAFEFE00FBFDFFFCFDFE
          FFFDFFFFFEFEFFFEFDFBF9F5C0B2A6A69281D0BFAACFD2BFD1D3C4AFAEA3C6C1
          BCFFFDFCFFFCFEFCFBFDFAFEFE00FFFEFFFCFDFFFFFDFFFFFEFFFFFFFFDBD7D2
          746557B8A591EAD7BFD9D8BFE9E9D3FAF4E4A99E96E5E0DDFFFFFFFFFCFFFAFF
          FF00FFFEFFFEFEFFFFFEFFFFFDFFFFFFFFA9A09A9F9386DFCFBCE4D3BDE1D8BC
          E5DEC5ECE2D0C2B6ACBEB2ADFFFFFFFEFEFEFAFDFD00FFFEFFFFFEFFFFFEFFFF
          FDFFFFFFFFA49D98C5B9AFF4E6D6EEDCCAE4D6B9D9CCB0E2D3BFAB9D92BBADA8
          FFFFFEFEFEFFF9FCFE00FFFDFFFFFEFFFDFEFFFDFEFFFFFFFFCCC7C4B3AAA0FD
          F0E4E4D4C1DBC8AED3C2A7C3B49F8E8175E5DDD8FFFFFFFEFCFFFBFEFF00FFFD
          FFFFFDFFFBFEFFFCFEFFFFFFFFF3F0F0988E87BEB3A8CDBEAEBCA993B29E8983
          7262B1A69BFFFFFFFFFFFFFFFEFFFCFFFF00FFFFFFFFFDFFFBFEFFFCFEFFFFFC
          FFFFFFFFF6F1EF978F877B6E63725F53806E63ACA097FFFEFCFFFFFFFDFFFFFE
          FFFFFCFFFD00FFFFFFFFFDFFFCFEFFFCFEFFFDFEFFFBFAF9FFFFFFFFFFFFEEE8
          E1EAE4DFF2ECE8FFFFFFFCFCFEFCFDFCFBFEFFFCFFFFFFFFFD00FFFFFFFFFDFF
          FCFEFFFDFEFFF9F8FAFEFDFDFFFDFBFEFDF8FFFFFAFFFFFFFFFFFFFFFDFFF9F8
          FCF9FBFDF9FDFFFDFFFFFFFFFD00}
        OnClick = spBtnBuscaRegiaoLocalidadeClick
      end
      object plsEdRegiaoLocalidade: TPlsEdit
        Left = 97
        Top = 2
        Width = 160
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 60
        TabOrder = 0
        OnExit = plsEdRegiaoLocalidadeExit
        plsCorRecebeFoco = clSilver
      end
    end
  end
  inherited dbGrdDadosPesquisa: TDBGrid
    Top = 193
    Width = 903
    Height = 238
    OnDblClick = dbGrdDadosPesquisaDblClick
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
    Width = 903
    object lblTotalRegistros: TLabel [0]
      Left = 819
      Top = 10
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = 'lblTotalRegistros'
    end
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT'
      '  DISTINCT(i.codigo) AS CODIGO_IMOVEL_INTERESSE,'
      '  i.ativo,i.data_captacao,'
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
      '  i.observacao,i.data_baixa,i.caracteristicas,'
      '  t.nome AS NOME_TIPO_IMOVEL,'
      '  i.tipo_pessoa,'
      '  CASE'
      '    WHEN i.tipo_pessoa = '#39'F'#205'SICA'#39' THEN'
      '       pf.nome'
      '    WHEN i.tipo_pessoa = '#39'JUR'#205'DICA'#39' THEN'
      '       pj.nome'
      '    ELSE'
      '      '#39'NENHUMA'#39
      '  END AS NOME_CLIENTE'
      ''
      'FROM imovel_de_interesse i'
      'JOIN tipo_imovel t ON i.cod_fk_tipo_imovel = t.codigo'
      
        'LEFT JOIN cliente_pessoa_fisica pf ON i.cod_fk_cliente_pessoa_fi' +
        'sica = pf.codigo'
      
        'LEFT JOIN cliente_pessoa_juridica pj ON i.cod_fk_cliente_pessoa_' +
        'juridica = pj.codigo'
      
        'LEFT JOIN imov_interesse_regiao_local iirl ON i.codigo = iirl.co' +
        'd_fk_imovel_de_interesse'
      ''
      'ORDER BY i.codigo')
    Left = 242
    Top = 162
    object zQryDadosCODIGO_IMOVEL_INTERESSE: TIntegerField
      FieldName = 'CODIGO_IMOVEL_INTERESSE'
      ReadOnly = True
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
    object zQryDadosNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object zQryDadosTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryDadosNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      ReadOnly = True
      Size = 100
    end
  end
  inherited dspDados: TDataSetProvider
    Left = 271
    Top = 162
  end
  inherited cdsDados: TClientDataSet
    Left = 301
    Top = 162
    object cdsDadosCODIGO_IMOVEL_INTERESSE: TIntegerField
      FieldName = 'CODIGO_IMOVEL_INTERESSE'
      ReadOnly = True
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
    object cdsDadosNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object cdsDadosTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object cdsDadosNOME_CLIENTE: TStringField
      FieldName = 'NOME_CLIENTE'
      ReadOnly = True
      Size = 100
    end
  end
  inherited dsDados: TDataSource
    Left = 329
    Top = 162
  end
  inherited ppMnPopupMenu: TPopupMenu
    Top = 231
    object ppMnDarBaixa: TMenuItem [0]
      Caption = 'Dar Baixa...'
      OnClick = ppMnDarBaixaClick
    end
    object ppMnDivisao: TMenuItem [1]
      Caption = '-'
    end
    object mnItDetalhar: TMenuItem [2]
      Caption = 'Detalhar...'
      OnClick = mnItDetalharClick
    end
  end
end
