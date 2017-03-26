object frmPrincipal: TfrmPrincipal
  Left = 324
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'PONTEIRO DE METODO'
  ClientHeight = 94
  ClientWidth = 338
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
  object edMensagem: TEdit
    Left = 8
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'mensagem'
  end
  object btnMostrarMensagem: TButton
    Left = 9
    Top = 41
    Width = 121
    Height = 25
    Caption = 'Mostrar Mensagem'
    TabOrder = 1
    OnClick = btnMostrarMensagemClick
  end
  object btnAssociarPonteiroMetodo: TButton
    Left = 168
    Top = 16
    Width = 145
    Height = 25
    Caption = 'Associar Ponteiro de Metodo'
    TabOrder = 2
    OnClick = btnAssociarPonteiroMetodoClick
  end
  object btnChamarPonteiroMetodo: TButton
    Left = 168
    Top = 48
    Width = 145
    Height = 25
    Caption = 'Chamar Ponteiro de Metodo'
    TabOrder = 3
    OnClick = btnChamarPonteiroMetodoClick
  end
end
