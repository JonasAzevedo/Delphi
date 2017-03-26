object DM: TDM
  OldCreateOrder = False
  Left = 361
  Top = 154
  Height = 250
  Width = 521
  object ZConnection: TZConnection
    Protocol = 'firebird-2.1'
    Database = 
      'E:\=ORGANIZA'#199#195'O DE ARQUIVOS=\Programa'#231#227'o\Delphi\Meus Softwares e' +
      'm Delphi\Particular\Verifica Site\BD\BD.FDB'
    User = 'SYSDBA'
    Password = 'masterkey'
    Connected = True
    Left = 216
    Top = 16
  end
  object zQryEnviaEmail: TZQuery
    Connection = ZConnection
    Active = True
    SQL.Strings = (
      'SELECT * FROM Envia_Email e')
    Params = <>
    Left = 64
    Top = 80
    object zQryEnviaEmailCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryEnviaEmailHOST: TStringField
      FieldName = 'HOST'
      Size = 100
    end
    object zQryEnviaEmailPORTA: TIntegerField
      FieldName = 'PORTA'
    end
    object zQryEnviaEmailEMAIL_PARA: TStringField
      FieldName = 'EMAIL_PARA'
      Size = 100
    end
    object zQryEnviaEmailEMAIL_DE: TStringField
      FieldName = 'EMAIL_DE'
      Size = 100
    end
    object zQryEnviaEmailNOME_DE: TStringField
      FieldName = 'NOME_DE'
      Size = 100
    end
    object zQryEnviaEmailSENHA_DE: TStringField
      FieldName = 'SENHA_DE'
    end
  end
  object zQryEnviaEmailSite: TZQuery
    Connection = ZConnection
    Active = True
    SQL.Strings = (
      'SELECT * FROM Envia_Email_Site e')
    Params = <>
    Left = 160
    Top = 80
    object zQryEnviaEmailSiteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryEnviaEmailSiteCOD_SITE: TIntegerField
      FieldName = 'COD_SITE'
    end
    object zQryEnviaEmailSiteCOD_ENVIA_EMAIL: TIntegerField
      FieldName = 'COD_ENVIA_EMAIL'
    end
  end
  object zQrySite: TZQuery
    Connection = ZConnection
    Active = True
    SQL.Strings = (
      'SELECT * FROM site')
    Params = <>
    Left = 256
    Top = 80
    object zQrySiteCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQrySiteSITE: TStringField
      FieldName = 'SITE'
      Size = 100
    end
    object zQrySiteDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object zQrySiteSTATUS: TIntegerField
      FieldName = 'STATUS'
    end
    object zQrySiteDATA_ATIVACAO: TDateTimeField
      FieldName = 'DATA_ATIVACAO'
    end
  end
  object zQryUsuario: TZQuery
    Connection = ZConnection
    Active = True
    SQL.Strings = (
      'SELECT * FROM usuario u')
    Params = <>
    Left = 344
    Top = 80
    object zQryUsuarioCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryUsuarioNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zQryUsuarioLOGIN: TStringField
      FieldName = 'LOGIN'
    end
    object zQryUsuarioSENHA: TStringField
      FieldName = 'SENHA'
    end
  end
  object dsEnviaEmail: TDataSource
    DataSet = zQryEnviaEmail
    Left = 64
    Top = 136
  end
  object dsEnviaEmailSite: TDataSource
    DataSet = zQryEnviaEmailSite
    Left = 160
    Top = 136
  end
  object dsSite: TDataSource
    DataSet = zQrySite
    Left = 256
    Top = 136
  end
  object dsUsuario: TDataSource
    DataSet = zQryUsuario
    Left = 344
    Top = 136
  end
  object zQryAtualizaSite: TZQuery
    Connection = ZConnection
    Active = True
    SQL.Strings = (
      'SELECT * FROM site')
    Params = <>
    Left = 432
    Top = 80
    object IntegerField1: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'SITE'
      Size = 100
    end
    object StringField2: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object IntegerField2: TIntegerField
      FieldName = 'STATUS'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DATA_ATIVACAO'
    end
  end
  object dsAtualizaSite: TDataSource
    DataSet = zQryAtualizaSite
    Left = 432
    Top = 136
  end
end
