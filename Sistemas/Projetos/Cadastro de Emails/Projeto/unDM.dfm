object DM: TDM
  OldCreateOrder = False
  Left = 527
  Top = 86
  Height = 392
  Width = 320
  object ZConnection: TZConnection
    Protocol = 'firebird-2.1'
    Left = 32
    Top = 8
  end
  object zQryEmail: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM email WHERE 1=2')
    Params = <>
    Left = 80
    Top = 56
    object zQryEmailCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryEmailEMAIL: TStringField
      FieldName = 'EMAIL'
      Required = True
      Size = 100
    end
    object zQryEmailSERVIDOR_DO_EMAIL: TStringField
      FieldName = 'SERVIDOR_DO_EMAIL'
      Size = 50
    end
    object zQryEmailDOMINIO_1: TStringField
      FieldName = 'DOMINIO_1'
      Size = 10
    end
    object zQryEmailDOMINIO_2: TStringField
      FieldName = 'DOMINIO_2'
      Size = 5
    end
    object zQryEmailNOME_PROPRIETARIO: TStringField
      FieldName = 'NOME_PROPRIETARIO'
      Size = 100
    end
    object zQryEmailCIDADE_PROPRIETARIO: TStringField
      FieldName = 'CIDADE_PROPRIETARIO'
      Size = 100
    end
    object zQryEmailESTADO_PROPRIETARIO: TStringField
      FieldName = 'ESTADO_PROPRIETARIO'
      Size = 5
    end
    object zQryEmailPAIS_PROPRIETARIO: TStringField
      FieldName = 'PAIS_PROPRIETARIO'
      Size = 50
    end
    object zQryEmailMEIO_CAPTACAO: TStringField
      FieldName = 'MEIO_CAPTACAO'
      Size = 200
    end
    object zQryEmailRELEVANCIA: TIntegerField
      FieldName = 'RELEVANCIA'
    end
    object zQryEmailDATA_INSERCAO: TDateTimeField
      FieldName = 'DATA_INSERCAO'
    end
  end
  object zQryAreasInteresse: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT *'
      'FROM areas_interesse'
      'WHERE 1=2')
    Params = <>
    Left = 80
    Top = 104
    object zQryAreasInteresseCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryAreasInteresseNOME: TStringField
      FieldName = 'NOME'
      Size = 30
    end
  end
  object zQryAssociaEmailAreasInteresse: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT *'
      'FROM associa_email_areas_interesse'
      'WHERE 1=2')
    Params = <>
    Left = 80
    Top = 152
    object zQryAssociaEmailAreasInteresseCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryAssociaEmailAreasInteresseCODIGO_FK_EMAIL: TIntegerField
      FieldName = 'CODIGO_FK_EMAIL'
    end
    object zQryAssociaEmailAreasInteresseCODIGO_FK_AREAS_INTERESSE: TIntegerField
      FieldName = 'CODIGO_FK_AREAS_INTERESSE'
    end
  end
  object zQryEmailRejeitado: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM email_rejeitado WHERE 1=2')
    Params = <>
    Left = 80
    Top = 200
    object zQryEmailRejeitadoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryEmailRejeitadoEMAIL: TStringField
      FieldName = 'EMAIL'
      Required = True
      Size = 100
    end
    object zQryEmailRejeitadoSERVIDOR_DO_EMAIL: TStringField
      FieldName = 'SERVIDOR_DO_EMAIL'
      Size = 50
    end
    object zQryEmailRejeitadoDOMINIO_1: TStringField
      FieldName = 'DOMINIO_1'
      Size = 10
    end
    object zQryEmailRejeitadoDOMINIO_2: TStringField
      FieldName = 'DOMINIO_2'
      Size = 5
    end
    object zQryEmailRejeitadoNOME_PROPRIETARIO: TStringField
      FieldName = 'NOME_PROPRIETARIO'
      Size = 100
    end
    object zQryEmailRejeitadoCIDADE_PROPRIETARIO: TStringField
      FieldName = 'CIDADE_PROPRIETARIO'
      Size = 100
    end
    object zQryEmailRejeitadoESTADO_PROPRIETARIO: TStringField
      FieldName = 'ESTADO_PROPRIETARIO'
      Size = 5
    end
    object zQryEmailRejeitadoPAIS_PROPRIETARIO: TStringField
      FieldName = 'PAIS_PROPRIETARIO'
      Size = 50
    end
    object zQryEmailRejeitadoMEIO_CAPTACAO: TStringField
      FieldName = 'MEIO_CAPTACAO'
      Size = 200
    end
    object zQryEmailRejeitadoRELEVANCIA: TIntegerField
      FieldName = 'RELEVANCIA'
    end
    object zQryEmailRejeitadoDATA_INSERCAO: TDateTimeField
      FieldName = 'DATA_INSERCAO'
    end
  end
  object zQryConfiguracoes: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * '
      'FROM configuracoes'
      'WHERE 1=2')
    Params = <>
    Left = 80
    Top = 244
    object zQryConfiguracoesCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryConfiguracoesPATH_BD: TStringField
      FieldName = 'PATH_BD'
      Required = True
      Size = 200
    end
    object zQryConfiguracoesUSUARIO_BD: TStringField
      FieldName = 'USUARIO_BD'
      Required = True
      Size = 30
    end
    object zQryConfiguracoesSENHA_BD: TStringField
      FieldName = 'SENHA_BD'
      Required = True
      Size = 30
    end
  end
  object zQryMelhoriasSistema: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * '
      'FROM melhorias_sistema'
      'WHERE 1=2')
    Params = <>
    Left = 80
    Top = 292
    object zQryMelhoriasSistemaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryMelhoriasSistemaDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
      Required = True
    end
    object zQryMelhoriasSistemaDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Required = True
      Size = 500
    end
    object zQryMelhoriasSistemaREPLICA: TStringField
      FieldName = 'REPLICA'
      Size = 500
    end
    object zQryMelhoriasSistemaRELEVANCIA: TIntegerField
      FieldName = 'RELEVANCIA'
      Required = True
    end
    object zQryMelhoriasSistemaSITUACAO: TIntegerField
      FieldName = 'SITUACAO'
      Required = True
    end
    object zQryMelhoriasSistemaDATA_FINALIZADA: TDateTimeField
      FieldName = 'DATA_FINALIZADA'
    end
    object zQryMelhoriasSistemaINCLUIDO_VERSAO: TStringField
      FieldName = 'INCLUIDO_VERSAO'
      Size = 10
    end
  end
  object zQryServidor: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM servidor WHERE 1=2')
    Params = <>
    Left = 232
    Top = 104
    object zQryServidorCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryServidorNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
  end
  object zQryDominio1: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM dominio_1 WHERE 1=2')
    Params = <>
    Left = 232
    Top = 152
    object zQryDominio1CODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDominio1NOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 10
    end
  end
  object zQryDominio2: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM dominio_2 WHERE 1=2')
    Params = <>
    Left = 232
    Top = 200
    object zQryDominio2CODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDominio2NOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 10
    end
  end
end
