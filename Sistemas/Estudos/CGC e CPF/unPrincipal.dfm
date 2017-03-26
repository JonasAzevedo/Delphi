object frmPrincipal: TfrmPrincipal
  Left = 193
  Top = 156
  Width = 475
  Height = 199
  Caption = 'VERIFICAR CPF e CGC'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 49
    Width = 26
    Height = 13
    Caption = 'CPF :'
  end
  object Label2: TLabel
    Left = 14
    Top = 79
    Width = 28
    Height = 13
    Caption = 'CGC :'
  end
  object lblTotal: TLabel
    Left = 439
    Top = 144
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object edCPF: TEdit
    Left = 48
    Top = 40
    Width = 180
    Height = 21
    TabOrder = 0
  end
  object edCGC: TEdit
    Left = 48
    Top = 70
    Width = 180
    Height = 21
    TabOrder = 1
  end
  object btnCPF: TButton
    Left = 48
    Top = 106
    Width = 75
    Height = 25
    Caption = 'CPF'
    TabOrder = 2
    OnClick = btnCPFClick
  end
  object btnCGC: TButton
    Left = 152
    Top = 106
    Width = 75
    Height = 25
    Caption = 'CGC'
    TabOrder = 3
    OnClick = btnCGCClick
  end
  object lstBxValidos: TListBox
    Left = 265
    Top = 44
    Width = 177
    Height = 97
    ItemHeight = 13
    TabOrder = 4
  end
  object btnSuspender: TButton
    Left = 345
    Top = 12
    Width = 97
    Height = 25
    Caption = 'Suspender'
    TabOrder = 5
    OnClick = btnSuspenderClick
  end
  object btnProcuraCPFs: TButton
    Left = 265
    Top = 12
    Width = 75
    Height = 25
    Caption = 'Procura CPF'#39's'
    TabOrder = 6
    OnClick = btnProcuraCPFsClick
  end
end
