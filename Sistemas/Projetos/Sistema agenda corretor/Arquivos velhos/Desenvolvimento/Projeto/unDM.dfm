object DM: TDM
  OldCreateOrder = False
  Left = 297
  Top = 136
  Height = 378
  Width = 867
  object ZConnection: TZConnection
    Protocol = 'firebird-2.1'
    Database = 'D:\Jonas\= Sistemas =\Desenvolvimento 2\BD\BD.FDB'
    Connected = True
    Left = 320
    Top = 16
  end
  object zQryEstado: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM estado'
      'WHERE 1=2')
    Params = <>
    Left = 66
    Top = 103
    object zQryEstadoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryEstadoNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
    object zQryEstadoSIGLA: TStringField
      FieldName = 'SIGLA'
      Required = True
      Size = 2
    end
  end
  object zQrySistema_Diversos: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM sistema_diversos'
      'WHERE 1=2')
    Params = <>
    Left = 458
    Top = 16
    object zQrySistema_DiversosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQrySistema_DiversosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQrySistema_DiversosDESCRICAO: TBlobField
      FieldName = 'DESCRICAO'
    end
    object zQrySistema_DiversosTIPO: TStringField
      FieldName = 'TIPO'
      Size = 100
    end
  end
  object zQryCidade: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM cidade'
      'WHERE 1=2')
    Params = <>
    Left = 66
    Top = 147
    object zQryCidadeCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryCidadeDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryCidadeCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
      Required = True
    end
    object zQryCidadeNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  object zQryBairro: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM bairro'
      'WHERE 1=2')
    Params = <>
    Left = 66
    Top = 190
    object zQryBairroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryBairroDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryBairroCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
      Required = True
    end
    object zQryBairroNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  object zQryRua: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM rua'
      'WHERE 1=2')
    Params = <>
    Left = 66
    Top = 233
    object zQryRuaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryRuaDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryRuaCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
    end
    object zQryRuaNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zQryRuaCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
  end
  object zQryConstrutora: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM construtora'
      'WHERE 1=2')
    Params = <>
    Left = 578
    Top = 147
    object zQryConstrutoraCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryConstrutoraDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryConstrutoraNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zQryConstrutoraTELEFONE_1: TStringField
      FieldName = 'TELEFONE_1'
      Size = 13
    end
    object zQryConstrutoraTELEFONE_2: TStringField
      FieldName = 'TELEFONE_2'
      Size = 13
    end
  end
  object zQryProfissao: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM profissao'
      'WHERE 1=2')
    Params = <>
    Left = 578
    Top = 103
    object zQryProfissaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryProfissaoDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryProfissaoNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  object zQryClientePessoaFisica: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM cliente_pessoa_fisica'
      'WHERE 1=2')
    Params = <>
    Left = 191
    Top = 103
    object zQryClientePessoaFisicaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryClientePessoaFisicaDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryClientePessoaFisicaDATA_CAPTACAO: TDateField
      FieldName = 'DATA_CAPTACAO'
    end
    object zQryClientePessoaFisicaCOD_FK_PROFISSAO: TIntegerField
      FieldName = 'COD_FK_PROFISSAO'
    end
    object zQryClientePessoaFisicaCOD_FK_MEIO_CAPTACAO: TIntegerField
      FieldName = 'COD_FK_MEIO_CAPTACAO'
    end
    object zQryClientePessoaFisicaCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zQryClientePessoaFisicaCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zQryClientePessoaFisicaCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
    end
    object zQryClientePessoaFisicaCOD_FK_RUA: TIntegerField
      FieldName = 'COD_FK_RUA'
    end
    object zQryClientePessoaFisicaENDERECO_CEP: TStringField
      FieldName = 'ENDERECO_CEP'
      Size = 9
    end
    object zQryClientePessoaFisicaENDERECO_COMPLEMENTO: TStringField
      FieldName = 'ENDERECO_COMPLEMENTO'
      Size = 500
    end
    object zQryClientePessoaFisicaNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zQryClientePessoaFisicaEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object zQryClientePessoaFisicaTELEFONE_RESIDENCIAL: TStringField
      FieldName = 'TELEFONE_RESIDENCIAL'
      Size = 13
    end
    object zQryClientePessoaFisicaTELEFONE_COMERCIAL: TStringField
      FieldName = 'TELEFONE_COMERCIAL'
      Size = 13
    end
    object zQryClientePessoaFisicaTELEFONE_CELULAR: TStringField
      FieldName = 'TELEFONE_CELULAR'
      Size = 13
    end
    object zQryClientePessoaFisicaCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object zQryClientePessoaFisicaIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object zQryClientePessoaFisicaDATA_NASCIMENTO: TDateField
      FieldName = 'DATA_NASCIMENTO'
    end
    object zQryClientePessoaFisicaHORARIO_LIGACAO: TStringField
      FieldName = 'HORARIO_LIGACAO'
      Size = 8
    end
    object zQryClientePessoaFisicaHORA_INICIO: TTimeField
      FieldName = 'HORA_INICIO'
    end
    object zQryClientePessoaFisicaHORA_FINAL: TTimeField
      FieldName = 'HORA_FINAL'
    end
    object zQryClientePessoaFisicaRENDIMENTO: TFloatField
      FieldName = 'RENDIMENTO'
    end
  end
  object zQryTipoImovel: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM tipo_imovel'
      'WHERE 1=2')
    Params = <>
    Left = 322
    Top = 103
    object zQryTipoImovelCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryTipoImovelDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryTipoImovelNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 60
    end
  end
  object zQryAgencPessoaFisica: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM agenc_pessoa_fisica'
      'WHERE 1=2')
    Params = <>
    Left = 191
    Top = 190
    object zQryAgencPessoaFisicaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryAgencPessoaFisicaDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryAgencPessoaFisicaNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zQryAgencPessoaFisicaEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object zQryAgencPessoaFisicaCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object zQryAgencPessoaFisicaIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object zQryAgencPessoaFisicaDATA_NASCIMENTO: TDateTimeField
      FieldName = 'DATA_NASCIMENTO'
    end
    object zQryAgencPessoaFisicaCONJUGE: TStringField
      FieldName = 'CONJUGE'
      Size = 100
    end
    object zQryAgencPessoaFisicaTELEFONE_RESIDENCIAL: TStringField
      FieldName = 'TELEFONE_RESIDENCIAL'
      Size = 13
    end
    object zQryAgencPessoaFisicaTELEFONE_COMERCIAL: TStringField
      FieldName = 'TELEFONE_COMERCIAL'
      Size = 13
    end
    object zQryAgencPessoaFisicaTELEFONE_CELULAR: TStringField
      FieldName = 'TELEFONE_CELULAR'
      Size = 13
    end
    object zQryAgencPessoaFisicaCOD_FK_MEIO_CAPTACAO: TIntegerField
      FieldName = 'COD_FK_MEIO_CAPTACAO'
    end
    object zQryAgencPessoaFisicaCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zQryAgencPessoaFisicaCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zQryAgencPessoaFisicaCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
    end
    object zQryAgencPessoaFisicaCOD_FK_RUA: TIntegerField
      FieldName = 'COD_FK_RUA'
    end
    object zQryAgencPessoaFisicaENDERECO_CEP: TStringField
      FieldName = 'ENDERECO_CEP'
      Size = 9
    end
    object zQryAgencPessoaFisicaENDERECO_COMPLEMENTO: TStringField
      FieldName = 'ENDERECO_COMPLEMENTO'
      Size = 500
    end
    object zQryAgencPessoaFisicaHORARIO_LIGACAO: TStringField
      FieldName = 'HORARIO_LIGACAO'
      Size = 8
    end
    object zQryAgencPessoaFisicaHORA_INICIO: TTimeField
      FieldName = 'HORA_INICIO'
    end
    object zQryAgencPessoaFisicaHORA_FINAL: TTimeField
      FieldName = 'HORA_FINAL'
    end
  end
  object zQryAgencPessoaJuridica: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM agenc_pessoa_juridica'
      'WHERE 1=2')
    Params = <>
    Left = 191
    Top = 233
    object zQryAgencPessoaJuridicaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryAgencPessoaJuridicaDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryAgencPessoaJuridicaNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zQryAgencPessoaJuridicaEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object zQryAgencPessoaJuridicaCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 30
    end
    object zQryAgencPessoaJuridicaTELEFONE_RESIDENCIAL: TStringField
      FieldName = 'TELEFONE_RESIDENCIAL'
      Size = 13
    end
    object zQryAgencPessoaJuridicaTELEFONE_COMERCIAL: TStringField
      FieldName = 'TELEFONE_COMERCIAL'
      Size = 13
    end
    object zQryAgencPessoaJuridicaTELEFONE_CELULAR: TStringField
      FieldName = 'TELEFONE_CELULAR'
      Size = 13
    end
    object zQryAgencPessoaJuridicaCOD_FK_MEIO_CAPTACAO: TIntegerField
      FieldName = 'COD_FK_MEIO_CAPTACAO'
    end
    object zQryAgencPessoaJuridicaCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zQryAgencPessoaJuridicaCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zQryAgencPessoaJuridicaCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
    end
    object zQryAgencPessoaJuridicaCOD_FK_RUA: TIntegerField
      FieldName = 'COD_FK_RUA'
    end
    object zQryAgencPessoaJuridicaENDERECO_CEP: TStringField
      FieldName = 'ENDERECO_CEP'
      Size = 9
    end
    object zQryAgencPessoaJuridicaENDERECO_COMPLEMENTO: TStringField
      FieldName = 'ENDERECO_COMPLEMENTO'
      Size = 500
    end
    object zQryAgencPessoaJuridicaHORARIO_LIGACAO: TStringField
      FieldName = 'HORARIO_LIGACAO'
      Size = 8
    end
    object zQryAgencPessoaJuridicaHORA_INICIO: TTimeField
      FieldName = 'HORA_INICIO'
    end
    object zQryAgencPessoaJuridicaHORA_FINAL: TTimeField
      FieldName = 'HORA_FINAL'
    end
  end
  object zQryImovelDeInteresse: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM imovel_de_interesse'
      'WHERE 1=2')
    Params = <>
    Left = 450
    Top = 103
    object zQryImovelDeInteresseCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryImovelDeInteresseDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryImovelDeInteresseATIVO: TStringField
      FieldName = 'ATIVO'
      Size = 3
    end
    object zQryImovelDeInteresseDATA_CAPTACAO: TDateField
      FieldName = 'DATA_CAPTACAO'
    end
    object zQryImovelDeInteresseTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryImovelDeInteresseCOD_FK_CLIENTE_PESSOA_FISICA: TIntegerField
      FieldName = 'COD_FK_CLIENTE_PESSOA_FISICA'
    end
    object zQryImovelDeInteresseCOD_FK_CLIENTE_PESSOA_JURIDICA: TIntegerField
      FieldName = 'COD_FK_CLIENTE_PESSOA_JURIDICA'
    end
    object zQryImovelDeInteresseCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object zQryImovelDeInteresseFINALIDADE_IMOVEL: TStringField
      FieldName = 'FINALIDADE_IMOVEL'
      Size = 10
    end
    object zQryImovelDeInteresseIMOVEL_DESEJAVEL: TStringField
      FieldName = 'IMOVEL_DESEJAVEL'
    end
    object zQryImovelDeInteresseVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object zQryImovelDeInteresseCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryImovelDeInteressePGTO_VISTA_CACH: TFloatField
      FieldName = 'PGTO_VISTA_CACH'
    end
    object zQryImovelDeInteressePGTO_VISTA_VALOR_BEM: TFloatField
      FieldName = 'PGTO_VISTA_VALOR_BEM'
    end
    object zQryImovelDeInteressePGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_VISTA_DESCRICAO_BEM'
      Size = 500
    end
    object zQryImovelDeInteressePGTO_FINCTO_CACH_FINANCIADO: TFloatField
      FieldName = 'PGTO_FINCTO_CACH_FINANCIADO'
    end
    object zQryImovelDeInteressePGTO_FINCTO_CACH: TFloatField
      FieldName = 'PGTO_FINCTO_CACH'
    end
    object zQryImovelDeInteressePGTO_FINCTO_VALOR_BEM: TFloatField
      FieldName = 'PGTO_FINCTO_VALOR_BEM'
    end
    object zQryImovelDeInteressePGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_FINCTO_DESCRICAO_BEM'
      Size = 500
    end
    object zQryImovelDeInteresseOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object zQryImovelDeInteresseDATA_BAIXA: TDateTimeField
      FieldName = 'DATA_BAIXA'
    end
    object zQryImovelDeInteresseCARACTERISTICAS: TStringField
      FieldName = 'CARACTERISTICAS'
      Size = 500
    end
  end
  object zQryAgenciamentos: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM agenciamentos'
      'WHERE 1=2')
    Params = <>
    Left = 450
    Top = 147
    object zQryAgenciamentosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryAgenciamentosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryAgenciamentosDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
    end
    object zQryAgenciamentosATIVO: TStringField
      FieldName = 'ATIVO'
      Size = 3
    end
    object zQryAgenciamentosNORMAL: TStringField
      FieldName = 'NORMAL'
      Size = 5
    end
    object zQryAgenciamentosSTAND_BY: TStringField
      FieldName = 'STAND_BY'
      Size = 5
    end
    object zQryAgenciamentosTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryAgenciamentosCOD_FK_PESSOA_FISICA: TIntegerField
      FieldName = 'COD_FK_PESSOA_FISICA'
    end
    object zQryAgenciamentosCOD_FK_PESSOA_JURIDICA: TIntegerField
      FieldName = 'COD_FK_PESSOA_JURIDICA'
    end
    object zQryAgenciamentosCOD_FK_IMOVEL: TIntegerField
      FieldName = 'COD_FK_IMOVEL'
    end
    object zQryAgenciamentosCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryAgenciamentosVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
    end
    object zQryAgenciamentosVLR_MONETARIO: TFloatField
      FieldName = 'VLR_MONETARIO'
    end
    object zQryAgenciamentosPGTO_VISTA_VALOR_BEM: TFloatField
      FieldName = 'PGTO_VISTA_VALOR_BEM'
    end
    object zQryAgenciamentosPGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_VISTA_DESCRICAO_BEM'
      Size = 500
    end
    object zQryAgenciamentosPGTO_FINCTO_CACH_FINANCIADO: TFloatField
      FieldName = 'PGTO_FINCTO_CACH_FINANCIADO'
    end
    object zQryAgenciamentosPGTO_FINCTO_CACH: TFloatField
      FieldName = 'PGTO_FINCTO_CACH'
    end
    object zQryAgenciamentosPGTO_FINCTO_VALOR_BEM: TFloatField
      FieldName = 'PGTO_FINCTO_VALOR_BEM'
    end
    object zQryAgenciamentosPGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'PGTO_FINCTO_DESCRICAO_BEM'
      Size = 500
    end
    object zQryAgenciamentosOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object zQryAgenciamentosPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object zQryAgenciamentosDATA_REAGENCIAMENTO: TDateField
      FieldName = 'DATA_REAGENCIAMENTO'
    end
    object zQryAgenciamentosDATA_BAIXA: TDateField
      FieldName = 'DATA_BAIXA'
    end
  end
  object zQryImovel: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM imovel'
      'WHERE 1=2')
    Params = <>
    Left = 322
    Top = 147
    object zQryImovelCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryImovelDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryImovelSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object zQryImovelCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object zQryImovelCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zQryImovelCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zQryImovelCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
    end
    object zQryImovelCOD_FK_RUA: TIntegerField
      FieldName = 'COD_FK_RUA'
    end
    object zQryImovelENDERECO_CEP: TStringField
      FieldName = 'ENDERECO_CEP'
      Size = 9
    end
    object zQryImovelENDERECO_COMPLEMENTO: TStringField
      FieldName = 'ENDERECO_COMPLEMENTO'
      Size = 500
    end
    object zQryImovelSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zQryImovelVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object zQryImovelDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 500
    end
  end
  object zQryAgenda: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM agenda'
      'WHERE 1=2')
    Params = <>
    Left = 550
    Top = 16
    object zQryAgendaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryAgendaDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryAgendaDATA_AVISO: TDateField
      FieldName = 'DATA_AVISO'
      Required = True
    end
    object zQryAgendaHORA_AVISO: TTimeField
      FieldName = 'HORA_AVISO'
      Required = True
    end
    object zQryAgendaCOMPROMISSO: TStringField
      FieldName = 'COMPROMISSO'
      Size = 300
    end
    object zQryAgendaDATA_HORA_AUX: TDateTimeField
      FieldName = 'DATA_HORA_AUX'
    end
    object zQryAgendaSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
  end
  object zQryParametrosSistema: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM parametros_sistema'
      'WHERE 1=2')
    Params = <>
    Left = 647
    Top = 16
    object zQryParametrosSistemaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryParametrosSistemaTEMPO_AVISO_AGENDA: TIntegerField
      FieldName = 'TEMPO_AVISO_AGENDA'
    end
  end
  object zQryLog: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM log')
    Params = <>
    Left = 736
    Top = 16
    object zQryLogCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryLogDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryLogCOD_FK_USUARIO: TIntegerField
      FieldName = 'COD_FK_USUARIO'
    end
    object zQryLogDATA_LOGIN: TDateTimeField
      FieldName = 'DATA_LOGIN'
    end
    object zQryLogDATA_LOGOFF: TDateTimeField
      FieldName = 'DATA_LOGOFF'
    end
  end
  object zQryUsuario: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM usuario')
    Params = <>
    Left = 797
    Top = 16
    object zQryUsuarioCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryUsuarioDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryUsuarioNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zQryUsuarioLOGIN: TStringField
      FieldName = 'LOGIN'
      Size = 10
    end
    object zQryUsuarioSENHA: TStringField
      FieldName = 'SENHA'
      Size = 10
    end
  end
  object zQryAux: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT i.codigo,i.valor_imovel,e.sigla,c.nome '
      'FROM imovel i '
      'JOIN estado e ON i.cod_fk_estado = e.codigo '
      'JOIN cidade c ON i.cod_fk_cidade = c.codigo '
      'ORDER BY i.codigo DESC ROWS 1')
    Params = <>
    Left = 728
    Top = 103
  end
  object zQryMeioCaptacao: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM meio_captacao'
      'WHERE 1=2')
    Params = <>
    Left = 322
    Top = 190
    object zQryMeioCaptacaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryMeioCaptacaoNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
    object zQryMeioCaptacaoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
  end
  object zQryVendas: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * '
      'FROM vendas'
      'WHERE 1=2')
    Params = <>
    Left = 450
    Top = 190
    object zQryVendasCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryVendasDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryVendasDATA_VENDA: TDateField
      FieldName = 'DATA_VENDA'
    end
    object zQryVendasATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      Size = 3
    end
    object zQryVendasTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryVendasCOD_FK_CLIENTE_PESSOA_FISICA: TIntegerField
      FieldName = 'COD_FK_CLIENTE_PESSOA_FISICA'
    end
    object zQryVendasCOD_FK_CLIENTE_PESSOA_JURIDICA: TIntegerField
      FieldName = 'COD_FK_CLIENTE_PESSOA_JURIDICA'
    end
    object zQryVendasCOD_FK_IMOVEL: TIntegerField
      FieldName = 'COD_FK_IMOVEL'
      Required = True
    end
    object zQryVendasCOD_FK_AGENCIAMENTO: TIntegerField
      FieldName = 'COD_FK_AGENCIAMENTO'
    end
    object zQryVendasTIPO_VENDA: TStringField
      FieldName = 'TIPO_VENDA'
      Required = True
      Size = 16
    end
    object zQryVendasVENDA_MEU_AGENCIAMENTO_MEU: TStringField
      FieldName = 'VENDA_MEU_AGENCIAMENTO_MEU'
      Size = 3
    end
    object zQryVendasVENDA_MEU_AGENCIAMENTO_COLEGAS: TStringField
      FieldName = 'VENDA_MEU_AGENCIAMENTO_COLEGAS'
      Size = 3
    end
    object zQryVendasVENDA_PAUTA_CONSTRUTORA: TStringField
      FieldName = 'VENDA_PAUTA_CONSTRUTORA'
      Size = 3
    end
    object zQryVendasVENDA_PAUTA_TERCEIROS: TStringField
      FieldName = 'VENDA_PAUTA_TERCEIROS'
      Size = 3
    end
    object zQryVendasCOD_FK_TP_VND_CONSTRUTORA: TIntegerField
      FieldName = 'COD_FK_TP_VND_CONSTRUTORA'
    end
    object zQryVendasVALOR_VENDA: TFloatField
      FieldName = 'VALOR_VENDA'
      Required = True
    end
    object zQryVendasDEDUCOES: TFloatField
      FieldName = 'DEDUCOES'
    end
    object zQryVendasVALOR_BEM_NEGOCIAVEL: TFloatField
      FieldName = 'VALOR_BEM_NEGOCIAVEL'
    end
    object zQryVendasDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField
      FieldName = 'DEDUZIR_BEM_NEGOC_VALOR_VENDA'
      Size = 3
    end
    object zQryVendasVALOR_PARA_CALCULO_COMISSAO: TFloatField
      FieldName = 'VALOR_PARA_CALCULO_COMISSAO'
    end
    object zQryVendasPERCENTUAL_SOBRE_VENDA: TFloatField
      FieldName = 'PERCENTUAL_SOBRE_VENDA'
    end
    object zQryVendasVALOR_TOTAL_COMISSAO: TFloatField
      FieldName = 'VALOR_TOTAL_COMISSAO'
    end
    object zQryVendasPERCENTUAL_SOBRE_COMISSAO: TFloatField
      FieldName = 'PERCENTUAL_SOBRE_COMISSAO'
    end
    object zQryVendasOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object zQryVendasDATA_CANCELAMENTO: TDateTimeField
      FieldName = 'DATA_CANCELAMENTO'
    end
  end
  object zQryClientePessoaJuridica: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM cliente_pessoa_juridica'
      'WHERE 1=2'
      '')
    Params = <>
    Left = 191
    Top = 147
    object zQryClientePessoaJuridicaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryClientePessoaJuridicaDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryClientePessoaJuridicaDATA_CAPTACAO: TDateField
      FieldName = 'DATA_CAPTACAO'
    end
    object zQryClientePessoaJuridicaNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zQryClientePessoaJuridicaEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object zQryClientePessoaJuridicaCNPJ: TStringField
      FieldName = 'CNPJ'
      Size = 30
    end
    object zQryClientePessoaJuridicaTELEFONE_RESIDENCIAL: TStringField
      FieldName = 'TELEFONE_RESIDENCIAL'
      Size = 13
    end
    object zQryClientePessoaJuridicaTELEFONE_COMERCIAL: TStringField
      FieldName = 'TELEFONE_COMERCIAL'
      Size = 13
    end
    object zQryClientePessoaJuridicaTELEFONE_CELULAR: TStringField
      FieldName = 'TELEFONE_CELULAR'
      Size = 13
    end
    object zQryClientePessoaJuridicaCOD_FK_MEIO_CAPTACAO: TIntegerField
      FieldName = 'COD_FK_MEIO_CAPTACAO'
    end
    object zQryClientePessoaJuridicaCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zQryClientePessoaJuridicaCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zQryClientePessoaJuridicaCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
    end
    object zQryClientePessoaJuridicaCOD_FK_RUA: TIntegerField
      FieldName = 'COD_FK_RUA'
    end
    object zQryClientePessoaJuridicaENDERECO_CEP: TStringField
      FieldName = 'ENDERECO_CEP'
      Size = 9
    end
    object zQryClientePessoaJuridicaENDERECO_COMPLEMENTO: TStringField
      FieldName = 'ENDERECO_COMPLEMENTO'
      Size = 500
    end
    object zQryClientePessoaJuridicaHORARIO_LIGACAO: TStringField
      FieldName = 'HORARIO_LIGACAO'
      Size = 8
    end
    object zQryClientePessoaJuridicaHORA_INICIO: TTimeField
      FieldName = 'HORA_INICIO'
    end
    object zQryClientePessoaJuridicaHORA_FINAL: TTimeField
      FieldName = 'HORA_FINAL'
    end
    object zQryClientePessoaJuridicaRENDIMENTO: TFloatField
      FieldName = 'RENDIMENTO'
    end
  end
end
