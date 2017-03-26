object frmVerResumoRelatorioComissoes: TfrmVerResumoRelatorioComissoes
  Left = 380
  Top = 169
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'frmVerResumoRelatorioComissoes'
  ClientHeight = 166
  ClientWidth = 746
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object strGrdComissoes: TStringGrid
    Left = 0
    Top = 0
    Width = 746
    Height = 147
    Hint = 'Funcion'#225'rio com Comiss'#245'es'
    Align = alClient
    ColCount = 4
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
    ColWidths = (
      456
      89
      89
      92)
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 147
    Width = 746
    Height = 19
    Panels = <
      item
        Width = 500
      end
      item
        Width = 50
      end>
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 15
    Top = 19
  end
end
