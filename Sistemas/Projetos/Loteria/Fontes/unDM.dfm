object DM: TDM
  OldCreateOrder = False
  Left = 193
  Top = 153
  Height = 262
  Width = 218
  object ZConnection: TZConnection
    Protocol = 'firebird-2.1'
    Database = 
      'E:\- Arquivos Organizados -\Programa'#231#227'o\Delphi\Sistemas\Meus Sis' +
      'temas\Loteria\BD\BD.FDB'
    Connected = True
    Left = 88
    Top = 32
  end
  object zQryLotoFacil: TZQuery
    Connection = ZConnection
    SQL.Strings = (
      'SELECT * FROM LotoFacil l ORDER BY l.sorteio')
    Params = <>
    Left = 88
    Top = 96
    object zQryLotoFacilSORTEIO: TIntegerField
      FieldName = 'SORTEIO'
      Required = True
    end
    object zQryLotoFacilDATA: TDateField
      FieldName = 'DATA'
    end
    object zQryLotoFacilN1: TIntegerField
      FieldName = 'N1'
    end
    object zQryLotoFacilN2: TIntegerField
      FieldName = 'N2'
    end
    object zQryLotoFacilN3: TIntegerField
      FieldName = 'N3'
    end
    object zQryLotoFacilN4: TIntegerField
      FieldName = 'N4'
    end
    object zQryLotoFacilN5: TIntegerField
      FieldName = 'N5'
    end
    object zQryLotoFacilN6: TIntegerField
      FieldName = 'N6'
    end
    object zQryLotoFacilN7: TIntegerField
      FieldName = 'N7'
    end
    object zQryLotoFacilN8: TIntegerField
      FieldName = 'N8'
    end
    object zQryLotoFacilN9: TIntegerField
      FieldName = 'N9'
    end
    object zQryLotoFacilN10: TIntegerField
      FieldName = 'N10'
    end
    object zQryLotoFacilN11: TIntegerField
      FieldName = 'N11'
    end
    object zQryLotoFacilN12: TIntegerField
      FieldName = 'N12'
    end
    object zQryLotoFacilN13: TIntegerField
      FieldName = 'N13'
    end
    object zQryLotoFacilN14: TIntegerField
      FieldName = 'N14'
    end
    object zQryLotoFacilN15: TIntegerField
      FieldName = 'N15'
    end
    object zQryLotoFacilACERTO15: TIntegerField
      FieldName = 'ACERTO15'
    end
    object zQryLotoFacilACERTO14: TIntegerField
      FieldName = 'ACERTO14'
    end
    object zQryLotoFacilACERTO13: TIntegerField
      FieldName = 'ACERTO13'
    end
    object zQryLotoFacilACERTO12: TIntegerField
      FieldName = 'ACERTO12'
    end
    object zQryLotoFacilACERTO11: TIntegerField
      FieldName = 'ACERTO11'
    end
    object zQryLotoFacilPREMIO_ACERTO15: TFloatField
      FieldName = 'PREMIO_ACERTO15'
    end
    object zQryLotoFacilPREMIO_ACERTO14: TFloatField
      FieldName = 'PREMIO_ACERTO14'
    end
    object zQryLotoFacilPREMIO_ACERTO13: TFloatField
      FieldName = 'PREMIO_ACERTO13'
    end
    object zQryLotoFacilPREMIO_ACERTO12: TFloatField
      FieldName = 'PREMIO_ACERTO12'
    end
    object zQryLotoFacilPREMIO_ACERTO11: TFloatField
      FieldName = 'PREMIO_ACERTO11'
    end
  end
  object dsZqryLotoFacil: TDataSource
    DataSet = zQryLotoFacil
    Left = 88
    Top = 144
  end
end
