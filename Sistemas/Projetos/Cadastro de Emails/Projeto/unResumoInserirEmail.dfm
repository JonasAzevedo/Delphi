object frmResumoInseriuEmail: TfrmResumoInseriuEmail
  Left = 380
  Top = 102
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'RESUMO'
  ClientHeight = 448
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 14
  object lblAuxEmailsInseridos: TLabel
    Left = 10
    Top = 20
    Width = 101
    Height = 14
    Caption = 'Email'#39's  Inseridos:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAuxEmailRejeitados: TLabel
    Left = 470
    Top = 20
    Width = 103
    Height = 14
    Caption = 'Email'#39's Rejeitados:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalEmailsRejeitados: TLabel
    Left = 579
    Top = 20
    Width = 134
    Height = 14
    Caption = 'lblTotalEmailsRejeitados'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalEmailsInseridos: TLabel
    Left = 117
    Top = 20
    Width = 129
    Height = 14
    Caption = 'lblTotalEmailsInseridos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalEmailsRepetidos: TLabel
    Left = 345
    Top = 20
    Width = 132
    Height = 14
    Caption = 'lblTotalEmailsRepetidos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAuxEmailsRepetidos: TLabel
    Left = 240
    Top = 20
    Width = 101
    Height = 14
    Caption = 'Email'#39's Repetidos:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalEmails: TLabel
    Left = 593
    Top = 426
    Width = 76
    Height = 14
    Caption = 'lblTotalEmails'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lstBxEmailsInseridos: TListBox
    Left = 10
    Top = 40
    Width = 200
    Height = 370
    ItemHeight = 14
    TabOrder = 0
  end
  object lstBxEmailsRepetidos: TListBox
    Left = 240
    Top = 40
    Width = 200
    Height = 370
    ItemHeight = 14
    TabOrder = 1
  end
  object lstBxEmailsRejeitados: TListBox
    Left = 469
    Top = 40
    Width = 200
    Height = 370
    ItemHeight = 14
    TabOrder = 2
  end
end
