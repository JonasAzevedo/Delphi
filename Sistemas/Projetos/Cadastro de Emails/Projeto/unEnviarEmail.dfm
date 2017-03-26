object frmEnviarEmail: TfrmEnviarEmail
  Left = 324
  Top = 110
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'ENVIAR EMAIL'
  ClientHeight = 466
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object grpBxListaEmails: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 466
    Align = alLeft
    Caption = 'Lista de Email'#39's '
    TabOrder = 0
    object lstBxListaEmails: TListBox
      Left = 2
      Top = 43
      Width = 181
      Height = 421
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
    end
    object pnlBotaoLimparLista: TPanel
      Left = 2
      Top = 15
      Width = 181
      Height = 28
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lblTotalEmails: TLabel
        Left = 147
        Top = 10
        Width = 3
        Height = 13
      end
      object lblTituloTotalEmails: TLabel
        Left = 80
        Top = 10
        Width = 62
        Height = 13
        Caption = 'Total Email'#39's:'
      end
      object btBtnListarLista: TBitBtn
        Left = 0
        Top = 2
        Width = 75
        Height = 25
        Caption = 'Limpar Lista'
        TabOrder = 0
        OnClick = btBtnListarListaClick
      end
    end
  end
  object Button1: TButton
    Left = 296
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
end
