object Form1: TForm1
  Left = 306
  Top = 110
  Width = 870
  Height = 500
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblTotal: TLabel
    Left = 208
    Top = 216
    Width = 34
    Height = 13
    Caption = 'lblTotal'
  end
  object DBGrid1: TDBGrid
    Left = 288
    Top = 88
    Width = 481
    Height = 305
    DataSource = dsBusca
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 192
    Top = 184
    Width = 75
    Height = 25
    Caption = 'IEIE'
    TabOrder = 1
    OnClick = Button1Click
  end
  object zCon: TZConnection
    Protocol = 'mysql-5'
    HostName = 'localhost'
    Port = 3306
    Database = 'misty'
    User = 'root'
    Connected = True
    Left = 296
    Top = 40
  end
  object zQryBusca: TZQuery
    Connection = zCon
    Active = True
    SQL.Strings = (
      'SELECT * FROM circuitos')
    Params = <>
    Left = 240
    Top = 104
    object zQryBuscacodigo: TIntegerField
      FieldName = 'codigo'
      Required = True
    end
    object zQryBuscafacilityCircuitType: TStringField
      FieldName = 'facilityCircuitType'
      Size = 10
    end
    object zQryBuscaobjectID: TStringField
      FieldName = 'objectID'
      Size = 11
    end
    object zQryBuscaidentificadorFacilidade: TStringField
      FieldName = 'identificadorFacilidade'
      Size = 50
    end
    object zQryBuscaidentificadorLegado: TStringField
      FieldName = 'identificadorLegado'
      Size = 50
    end
    object zQryBuscaidentificadorCircuitoCRM: TStringField
      FieldName = 'identificadorCircuitoCRM'
      Required = True
      Size = 50
    end
    object zQryBuscastatus: TStringField
      FieldName = 'status'
      Size = 15
    end
    object zQryBuscacriadoPor: TStringField
      FieldName = 'criadoPor'
      Size = 15
    end
    object zQryBuscadataCriacao: TStringField
      FieldName = 'dataCriacao'
    end
    object zQryBuscacomentarios: TStringField
      FieldName = 'comentarios'
      Size = 100
    end
    object zQryBuscaservico: TStringField
      FieldName = 'servico'
    end
    object zQryBuscacircuitoCompleto: TStringField
      FieldName = 'circuitoCompleto'
      Size = 50
    end
    object zQryBuscaportaLogicaCircuitoTDM: TStringField
      FieldName = 'portaLogicaCircuitoTDM'
      Size = 11
    end
    object zQryBuscaultimaAtualizacaoPorUsuario: TStringField
      FieldName = 'ultimaAtualizacaoPorUsuario'
      Size = 15
    end
    object zQryBuscaultimaAtualizacao: TStringField
      FieldName = 'ultimaAtualizacao'
    end
    object zQryBuscafilial: TStringField
      FieldName = 'filial'
      Required = True
      Size = 10
    end
    object zQryBuscaprocesso: TLargeintField
      FieldName = 'processo'
      Required = True
    end
    object zQryBuscadataImportacao: TDateTimeField
      FieldName = 'dataImportacao'
      Required = True
    end
    object zQryBuscastatusSAC: TStringField
      FieldName = 'statusSAC'
      Required = True
    end
    object zQryBuscatitularSAC: TStringField
      FieldName = 'titularSAC'
      Required = True
      Size = 100
    end
    object zQryBuscatipoCircuitoSAC: TStringField
      FieldName = 'tipoCircuitoSAC'
      Required = True
      Size = 30
    end
    object zQryBuscavelocidadeSAC: TStringField
      FieldName = 'velocidadeSAC'
      Required = True
    end
    object zQryBuscadataCriacaoSAC: TDateTimeField
      FieldName = 'dataCriacaoSAC'
    end
  end
  object dsBusca: TDataSource
    DataSet = zQryBusca
    Left = 240
    Top = 136
  end
  object zQryAtualiza: TZQuery
    Connection = zCon
    Active = True
    SQL.Strings = (
      'SELECT * FROM circuitos')
    Params = <>
    Left = 184
    Top = 104
    object zQryAtualizacodigo: TIntegerField
      FieldName = 'codigo'
      Required = True
    end
    object zQryAtualizafacilityCircuitType: TStringField
      FieldName = 'facilityCircuitType'
      Size = 10
    end
    object zQryAtualizaobjectID: TStringField
      FieldName = 'objectID'
      Size = 11
    end
    object zQryAtualizaidentificadorFacilidade: TStringField
      FieldName = 'identificadorFacilidade'
      Size = 50
    end
    object zQryAtualizaidentificadorLegado: TStringField
      FieldName = 'identificadorLegado'
      Size = 50
    end
    object zQryAtualizaidentificadorCircuitoCRM: TStringField
      FieldName = 'identificadorCircuitoCRM'
      Required = True
      Size = 50
    end
    object zQryAtualizastatus: TStringField
      FieldName = 'status'
      Size = 15
    end
    object zQryAtualizacriadoPor: TStringField
      FieldName = 'criadoPor'
      Size = 15
    end
    object zQryAtualizadataCriacao: TStringField
      FieldName = 'dataCriacao'
    end
    object zQryAtualizacomentarios: TStringField
      FieldName = 'comentarios'
      Size = 100
    end
    object zQryAtualizaservico: TStringField
      FieldName = 'servico'
    end
    object zQryAtualizacircuitoCompleto: TStringField
      FieldName = 'circuitoCompleto'
      Size = 50
    end
    object zQryAtualizaportaLogicaCircuitoTDM: TStringField
      FieldName = 'portaLogicaCircuitoTDM'
      Size = 11
    end
    object zQryAtualizaultimaAtualizacaoPorUsuario: TStringField
      FieldName = 'ultimaAtualizacaoPorUsuario'
      Size = 15
    end
    object zQryAtualizaultimaAtualizacao: TStringField
      FieldName = 'ultimaAtualizacao'
    end
    object zQryAtualizafilial: TStringField
      FieldName = 'filial'
      Required = True
      Size = 10
    end
    object zQryAtualizaprocesso: TLargeintField
      FieldName = 'processo'
      Required = True
    end
    object zQryAtualizadataImportacao: TDateTimeField
      FieldName = 'dataImportacao'
      Required = True
    end
    object zQryAtualizastatusSAC: TStringField
      FieldName = 'statusSAC'
      Required = True
    end
    object zQryAtualizatitularSAC: TStringField
      FieldName = 'titularSAC'
      Required = True
      Size = 100
    end
    object zQryAtualizatipoCircuitoSAC: TStringField
      FieldName = 'tipoCircuitoSAC'
      Required = True
      Size = 30
    end
    object zQryAtualizavelocidadeSAC: TStringField
      FieldName = 'velocidadeSAC'
      Required = True
    end
    object zQryAtualizadataCriacaoSAC: TDateTimeField
      FieldName = 'dataCriacaoSAC'
    end
  end
end
