object frmReservasPendentes: TfrmReservasPendentes
  Left = 475
  Top = 208
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'NOIVA LINDA --> Reservas Pendentes'
  ClientHeight = 351
  ClientWidth = 702
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 332
    Width = 702
    Height = 19
    Panels = <
      item
        Width = 550
      end
      item
        Width = 240
      end>
  end
  object dbGrdLocacoesPendentesVencendo: TDBGrid
    Left = 0
    Top = 0
    Width = 702
    Height = 137
    Hint = 'Reservas Pendentes'
    Align = alTop
    DataSource = frmPrincipal.dsReservasPendentes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = ppMnRealizarReserva
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = dbGrdLocacoesPendentesVencendoCellClick
    OnDblClick = dbGrdLocacoesPendentesVencendoDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIENTE'
        Title.Caption = 'Cliente'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_INICIO'
        Title.Caption = 'Data de In'#237'cio'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_FINAL'
        Title.Caption = 'Data Final'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_TOTAL'
        Title.Caption = 'Valor Total'
        Width = 80
        Visible = True
      end>
  end
  object pnlDivisao: TPanel
    Left = 0
    Top = 137
    Width = 702
    Height = 25
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = '   ITENS DA RESERVA'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object dbGrdItensReserva: TDBGrid
    Left = 0
    Top = 162
    Width = 702
    Height = 170
    Hint = 'Itens da Reserva'
    Align = alClient
    DataSource = dsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Produto'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MARCA'
        Title.Caption = 'Marca'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TAMANHO'
        Title.Caption = 'Tamanho'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_TOTAL'
        Title.Caption = 'Valor Total'
        Visible = True
      end>
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 216
    Top = 8
  end
  object qryItens: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'SELECT p.codigo, p.nome,p.marca,p.tamanho,i.quantidade,i.valor_u' +
        'nitario,i.valor_total'
      'FROM item_reserva i,produto p'
      'WHERE i.cod_reserva=1'
      'AND i.cod_produto=p.codigo')
    SQLConnection = DM.SQLConnection
    Left = 16
    Top = 72
    object qryItensCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryItensNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object qryItensMARCA: TStringField
      FieldName = 'MARCA'
      Size = 50
    end
    object qryItensTAMANHO: TIntegerField
      FieldName = 'TAMANHO'
    end
    object qryItensQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object qryItensVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object qryItensVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
  end
  object dspItens: TDataSetProvider
    DataSet = qryItens
    Left = 44
    Top = 72
  end
  object cdsItens: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItens'
    Left = 73
    Top = 72
    object cdsItensCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsItensNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object cdsItensMARCA: TStringField
      FieldName = 'MARCA'
      Size = 50
    end
    object cdsItensTAMANHO: TIntegerField
      FieldName = 'TAMANHO'
    end
    object cdsItensQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object cdsItensVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsItensVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 101
    Top = 72
  end
  object ppMnRealizarReserva: TPopupMenu
    Left = 248
    Top = 8
    object ppMnDeletarReserva: TMenuItem
      Caption = 'Deletar Reserva'
      OnClick = ppMnDeletarReservaClick
    end
    object RealizarReserva1: TMenuItem
      Caption = 'Realizar Reserva'
      OnClick = dbGrdLocacoesPendentesVencendoDblClick
    end
  end
  object cdsTmpReserva: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTmpReserva'
    Left = 76
    Top = 113
    object cdsTmpReservaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
  end
  object dspTmpReserva: TDataSetProvider
    DataSet = qryTmpReserva
    Left = 46
    Top = 113
  end
  object qryTmpReserva: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT i.codigo FROM Item_Reserva i, reserva r'
      'WHERE i.cod_produto=1'
      'AND i.cod_reserva=r.codigo'
      'AND r.status=0')
    SQLConnection = DM.SQLConnection
    Left = 16
    Top = 113
  end
end
