inherited fmDescriptionEditor: TfmDescriptionEditor
  ActiveControl = edEXEDescription
  Caption = 'fmDescriptionEditor'
  OldCreateOrder = True
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 97
    Height = 16
    AutoSize = False
    Caption = 'EXE Description'
  end
  object edEXEDescription: TEdit
    Left = 120
    Top = 12
    Width = 217
    Height = 24
    TabOrder = 0
    OnExit = edEXEDescriptionExit
  end
end
