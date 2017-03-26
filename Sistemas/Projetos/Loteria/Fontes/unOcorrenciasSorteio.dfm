object frmOcorrenciasSorteio: TfrmOcorrenciasSorteio
  Left = 288
  Top = 110
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TIME MONEY -> Ocorr'#234'ncias Sorteio'
  ClientHeight = 404
  ClientWidth = 329
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
  object Label2: TLabel
    Left = 62
    Top = 57
    Width = 9
    Height = 13
    Caption = '5:'
  end
  object Label3: TLabel
    Left = 62
    Top = 81
    Width = 9
    Height = 13
    Caption = '6:'
  end
  object Label4: TLabel
    Left = 62
    Top = 105
    Width = 9
    Height = 13
    Caption = '7:'
  end
  object Label5: TLabel
    Left = 62
    Top = 129
    Width = 9
    Height = 13
    Caption = '8:'
  end
  object Label6: TLabel
    Left = 62
    Top = 153
    Width = 9
    Height = 13
    Caption = '9:'
  end
  object Label7: TLabel
    Left = 62
    Top = 177
    Width = 15
    Height = 13
    Caption = '10:'
  end
  object Label8: TLabel
    Left = 62
    Top = 201
    Width = 15
    Height = 13
    Caption = '11:'
  end
  object Label9: TLabel
    Left = 62
    Top = 225
    Width = 15
    Height = 13
    Caption = '12:'
  end
  object Label10: TLabel
    Left = 62
    Top = 249
    Width = 15
    Height = 13
    Caption = '13:'
  end
  object Label11: TLabel
    Left = 62
    Top = 273
    Width = 15
    Height = 13
    Caption = '14:'
  end
  object Label12: TLabel
    Left = 62
    Top = 297
    Width = 15
    Height = 13
    Caption = '15:'
  end
  object Label1: TLabel
    Left = 8
    Top = 328
    Width = 102
    Height = 13
    Caption = 'Total de Sorteios:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTotalSorteios: TLabel
    Left = 119
    Top = 328
    Width = 3
    Height = 13
  end
  object lblNro1: TLabel
    Left = 250
    Top = 64
    Width = 3
    Height = 13
  end
  object lblNro2: TLabel
    Left = 250
    Top = 79
    Width = 3
    Height = 13
  end
  object lblNro3: TLabel
    Left = 250
    Top = 94
    Width = 3
    Height = 13
  end
  object lblNro4: TLabel
    Left = 250
    Top = 109
    Width = 3
    Height = 13
  end
  object lblNro5: TLabel
    Left = 250
    Top = 124
    Width = 3
    Height = 13
  end
  object lblNro6: TLabel
    Left = 250
    Top = 139
    Width = 3
    Height = 13
  end
  object lblNro7: TLabel
    Left = 250
    Top = 154
    Width = 3
    Height = 13
  end
  object lblNro8: TLabel
    Left = 250
    Top = 169
    Width = 3
    Height = 13
  end
  object lblNro9: TLabel
    Left = 250
    Top = 184
    Width = 3
    Height = 13
  end
  object lblNro10: TLabel
    Left = 250
    Top = 199
    Width = 3
    Height = 13
  end
  object lblNro11: TLabel
    Left = 250
    Top = 214
    Width = 3
    Height = 13
  end
  object lblNro12: TLabel
    Left = 250
    Top = 229
    Width = 3
    Height = 13
  end
  object lblNro13: TLabel
    Left = 250
    Top = 244
    Width = 3
    Height = 13
  end
  object lblNro14: TLabel
    Left = 250
    Top = 259
    Width = 3
    Height = 13
  end
  object lblNro15: TLabel
    Left = 250
    Top = 274
    Width = 3
    Height = 13
  end
  object Label13: TLabel
    Left = 199
    Top = 24
    Width = 118
    Height = 13
    Caption = 'N'#186's PROCESSANDO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 16
    Top = 24
    Width = 159
    Height = 13
    Caption = 'POSS'#205'VEIS OCORR'#202'NCIAS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object advGlwBtnProcessar: TAdvGlowButton
    Left = 16
    Top = 352
    Width = 257
    Height = 33
    Hint = 'Processar'
    Caption = 'Processar'
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    TabOrder = 0
    OnClick = advGlwBtnProcessarClick
    Appearance.ColorChecked = 16111818
    Appearance.ColorCheckedTo = 16367008
    Appearance.ColorDisabled = 15921906
    Appearance.ColorDisabledTo = 15921906
    Appearance.ColorDown = 16111818
    Appearance.ColorDownTo = 16367008
    Appearance.ColorHot = 16117985
    Appearance.ColorHotTo = 16372402
    Appearance.ColorMirrorHot = 16107693
    Appearance.ColorMirrorHotTo = 16775412
    Appearance.ColorMirrorDown = 16102556
    Appearance.ColorMirrorDownTo = 16768988
    Appearance.ColorMirrorChecked = 16102556
    Appearance.ColorMirrorCheckedTo = 16768988
    Appearance.ColorMirrorDisabled = 11974326
    Appearance.ColorMirrorDisabledTo = 15921906
  end
  object edQtdeAcertos5: TEdit
    Left = 80
    Top = 51
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 1
    Text = '0'
  end
  object edQtdeAcertos6: TEdit
    Left = 80
    Top = 75
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 2
    Text = '0'
  end
  object edQtdeAcertos7: TEdit
    Left = 80
    Top = 99
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 3
    Text = '0'
  end
  object edQtdeAcertos8: TEdit
    Left = 80
    Top = 123
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 4
    Text = '0'
  end
  object edQtdeAcertos9: TEdit
    Left = 80
    Top = 147
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 5
    Text = '0'
  end
  object edQtdeAcertos10: TEdit
    Left = 80
    Top = 171
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 6
    Text = '0'
  end
  object edQtdeAcertos11: TEdit
    Left = 80
    Top = 195
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 7
    Text = '0'
  end
  object edQtdeAcertos12: TEdit
    Left = 80
    Top = 219
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 8
    Text = '0'
  end
  object edQtdeAcertos13: TEdit
    Left = 80
    Top = 243
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 9
    Text = '0'
  end
  object edQtdeAcertos14: TEdit
    Left = 80
    Top = 267
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 10
    Text = '0'
  end
  object edQtdeAcertos15: TEdit
    Left = 80
    Top = 291
    Width = 50
    Height = 21
    ReadOnly = True
    TabOrder = 11
    Text = '0'
  end
end
