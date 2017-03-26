object frmBaixaReservas: TfrmBaixaReservas
  Left = 264
  Top = 172
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'NOIVA LINDA --> Baixa nas Reservas n'#227'o Realizadas'
  ClientHeight = 466
  ClientWidth = 686
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
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 447
    Width = 686
    Height = 19
    Panels = <
      item
        Width = 550
      end
      item
        Width = 240
      end>
  end
  object dbGrdReservasVencidas: TDBGrid
    Left = 0
    Top = 0
    Width = 686
    Height = 392
    Hint = 'Reservas j'#225' Vencidas'
    Align = alClient
    DataSource = frmPrincipal.dsBaixaReserva
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Cliente'
        Width = 200
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
      end
      item
        Expanded = False
        FieldName = 'VALOR_PAGO'
        Title.Caption = 'Valor Pago'
        Width = 80
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 392
    Width = 686
    Height = 55
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btBtnBaixarReserva: TBitBtn
      Left = 264
      Top = 11
      Width = 145
      Height = 41
      Hint = 'Realizar Baixa na Reserva'
      Caption = 'BAIXAR RESERVA'
      Default = True
      TabOrder = 0
      OnClick = btBtnBaixarReservaClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 8
    Top = 40
  end
  object qryTmpReserva: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT i.codigo FROM Item_Reserva i, reserva r'
      ''
      'WHERE i.cod_produto=1'
      'AND i.cod_reserva=r.codigo'
      'AND r.status=0')
    SQLConnection = DM.SQLConnection
    Left = 8
    Top = 73
  end
  object dspTmpReserva: TDataSetProvider
    DataSet = qryTmpReserva
    Left = 38
    Top = 73
  end
  object cdsTmpReserva: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTmpReserva'
    Left = 68
    Top = 73
    object cdsTmpReservaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
  end
end
