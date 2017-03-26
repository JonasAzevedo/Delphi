object frmOperacoesHoje: TfrmOperacoesHoje
  Left = 917
  Top = 281
  BorderStyle = bsDialog
  Caption = 'NOIVA LINDA --> Opera'#231#245'es Para Hoje'
  ClientHeight = 631
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 2
    Width = 144
    Height = 13
    Cursor = crHandPoint
    Caption = 'RESERVAS PARA HOJE:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblTotalReservas: TLabel
    Left = 171
    Top = 2
    Width = 102
    Height = 13
    Caption = 'lblTotalReservas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 10
    Top = 322
    Width = 186
    Height = 13
    Cursor = crHandPoint
    Caption = 'LOCA'#199#213'ES PARA DEVOLU'#199#195'O:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblTotalLocacoes: TLabel
    Left = 211
    Top = 322
    Width = 104
    Height = 13
    Caption = 'lblTotalLocacoes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object mmReservasHoje: TMemo
    Left = 10
    Top = 22
    Width = 319
    Height = 283
    Hint = 'Reservas para hoje'
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object mmLocacoesDevolucao: TMemo
    Left = 10
    Top = 342
    Width = 319
    Height = 281
    Hint = 'Loca'#231#245'es para serem devolvidas hoje'
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
