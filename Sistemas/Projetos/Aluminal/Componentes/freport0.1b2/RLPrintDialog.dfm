object RLPrintDialog: TRLPrintDialog
  Left = 695
  Top = 90
  Width = 438
  Height = 305
  HorzScrollBar.Range = 421
  VertScrollBar.Range = 237
  ActiveControl = ComboBoxPrinterNames
  AutoScroll = False
  Caption = 'Imprimir'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = 11
  Font.Name = 'MS Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxPrinter: TGroupBox
    Left = 8
    Top = 4
    Width = 413
    Height = 113
    Caption = ' Impressora '
    TabOrder = 0
    object LabelPrinterName: TLabel
      Left = 12
      Top = 24
      Width = 31
      Height = 13
      Caption = '&Nome:'
      FocusControl = ComboBoxPrinterNames
    end
    object LabelFilterName: TLabel
      Left = 12
      Top = 48
      Width = 47
      Height = 13
      Caption = 'Usar &filtro:'
      FocusControl = ComboBoxPrinterNames
    end
    object LabelOptions: TLabel
      Left = 264
      Top = 48
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Opções:'
      FocusControl = ComboBoxOptions
    end
    object ComboBoxPrinterNames: TComboBox
      Left = 68
      Top = 20
      Width = 329
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object CheckBoxPrintToFile: TCheckBox
      Left = 12
      Top = 68
      Width = 325
      Height = 17
      Caption = 'Imprimir em arquivo'
      TabOrder = 3
    end
    object ComboBoxFilters: TComboBox
      Left = 68
      Top = 44
      Width = 177
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = ComboBoxFiltersChange
    end
    object ComboBoxOptions: TComboBox
      Left = 308
      Top = 44
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
    end
    object CheckBoxPrintInBackground: TCheckBox
      Left = 12
      Top = 88
      Width = 325
      Height = 17
      Caption = 'Imprimir em segundo plano'
      TabOrder = 4
    end
  end
  object GroupBoxPages: TGroupBox
    Left = 8
    Top = 120
    Width = 217
    Height = 101
    Caption = ' Intervalo de impressão '
    TabOrder = 1
    object LabelFromPage: TLabel
      Left = 72
      Top = 49
      Width = 15
      Height = 13
      Caption = '&de:'
      FocusControl = EditFromPage
    end
    object LabelToPage: TLabel
      Left = 140
      Top = 49
      Width = 18
      Height = 13
      Caption = '&até:'
      FocusControl = EditToPage
    end
    object RadioButtonPagesAll: TRadioButton
      Left = 12
      Top = 24
      Width = 113
      Height = 17
      Caption = '&Tudo'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButtonPagesInterval: TRadioButton
      Left = 12
      Top = 48
      Width = 61
      Height = 17
      Caption = 'Páginas'
      TabOrder = 1
    end
    object RadioButtonPagesSelect: TRadioButton
      Left = 12
      Top = 72
      Width = 73
      Height = 17
      Caption = '&Seleção'
      TabOrder = 2
    end
    object EditFromPage: TEdit
      Left = 92
      Top = 44
      Width = 41
      Height = 21
      TabStop = False
      TabOrder = 3
      Text = '1'
      OnChange = EditFromPageChange
    end
    object EditToPage: TEdit
      Left = 164
      Top = 44
      Width = 41
      Height = 21
      TabStop = False
      TabOrder = 4
      OnChange = EditFromPageChange
    end
  end
  object GroupBoxCopies: TGroupBox
    Left = 236
    Top = 120
    Width = 185
    Height = 101
    Caption = ' Cópias '
    TabOrder = 2
    object LabelCopies: TLabel
      Left = 12
      Top = 24
      Width = 89
      Height = 13
      Caption = 'Número de &cópias:'
    end
    object EditCopies: TEdit
      Left = 108
      Top = 20
      Width = 49
      Height = 21
      TabOrder = 0
      Text = '1'
    end
  end
  object ButtonOk: TButton
    Left = 260
    Top = 232
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object ButtonCancel: TButton
    Left = 344
    Top = 232
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 4
  end
end
