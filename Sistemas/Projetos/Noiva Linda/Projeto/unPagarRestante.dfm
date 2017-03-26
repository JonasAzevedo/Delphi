object frmPagarRestante: TfrmPagarRestante
  Left = 348
  Top = 148
  Width = 281
  Height = 274
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'NOIVA LINDA --> Pagar'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 42
    Top = 72
    Width = 54
    Height = 13
    Caption = 'Valor Total:'
  end
  object Label2: TLabel
    Left = 42
    Top = 132
    Width = 55
    Height = 13
    Caption = 'Valor Pago:'
  end
  object bvlDivisao: TBevel
    Left = 1
    Top = 42
    Width = 271
    Height = 10
    Shape = bsBottomLine
  end
  object Label3: TLabel
    Left = 8
    Top = 15
    Width = 90
    Height = 20
    Caption = 'LOCA'#199#195'O:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblLocacao: TLabel
    Left = 106
    Top = 15
    Width = 87
    Height = 20
    Caption = 'lblLocacao'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblValorTotal: TLabel
    Left = 120
    Top = 72
    Width = 58
    Height = 13
    Hint = 'Valor Total'
    Caption = 'lblValorTotal'
  end
  object Label5: TLabel
    Left = 42
    Top = 102
    Width = 55
    Height = 13
    Caption = 'Valor Pago:'
  end
  object lblValorPago: TLabel
    Left = 120
    Top = 102
    Width = 59
    Height = 13
    Hint = 'Valor J'#225' Pago'
    Caption = 'lblValorPago'
  end
  object edValorPago: TEdit
    Left = 120
    Top = 124
    Width = 121
    Height = 21
    Hint = 'Valor Pago'
    TabOrder = 0
    OnEnter = edValorPagoEnter
    OnExit = edValorPagoExit
    OnKeyPress = edValorPagoKeyPress
  end
  object BitBtn1: TBitBtn
    Left = 15
    Top = 162
    Width = 240
    Height = 48
    Hint = 'Salvar  Pagamento'
    Caption = 'SALVAR'
    Default = True
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 221
    Width = 273
    Height = 19
    Panels = <
      item
        Width = 180
      end
      item
        Width = 50
      end>
  end
  object ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    Left = 8
    Top = 4
  end
end
