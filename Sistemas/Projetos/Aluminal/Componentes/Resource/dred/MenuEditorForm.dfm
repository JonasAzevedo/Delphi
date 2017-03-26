inherited fmMenuEditor: TfmMenuEditor
  Left = 212
  Caption = 'fmMenuEditor'
  ClientHeight = 466
  Menu = MainMenu1
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 193
    Top = 0
    Width = 3
    Height = 466
    Cursor = crHSplit
  end
  object ScrollBox1: TScrollBox
    Left = 196
    Top = 0
    Width = 579
    Height = 466
    Align = alClient
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    object MenuDesigner1: TMenuDesigner
      Left = 0
      Top = 0
      Width = 575
      Height = 57
      OnSelectedItemChange = MenuDesigner1SelectedItemChange
      Align = alTop
      AutoSize = True
      Color = clMenu
      UseDockManager = False
      ParentColor = False
      PopupMenu = pomMenu
      TabOrder = 0
      TabStop = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 466
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 68
      Height = 16
      AutoSize = False
      Caption = '&Caption'
    end
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 68
      Height = 16
      AutoSize = False
      Caption = '&Shortcut'
    end
    object Label3: TLabel
      Left = 8
      Top = 56
      Width = 68
      Height = 16
      AutoSize = False
      Caption = '&ID'
    end
    object edCaption: TEdit
      Left = 80
      Top = 4
      Width = 101
      Height = 24
      TabOrder = 0
      OnChange = edCaptionChange
      OnEnter = edCaptionEnter
      OnExit = edCaptionExit
    end
    object cbShortcut: TComboBox
      Left = 80
      Top = 28
      Width = 101
      Height = 24
      ItemHeight = 16
      TabOrder = 1
      OnChange = cbShortcutChange
    end
    object edID: TEdit
      Left = 80
      Top = 52
      Width = 101
      Height = 24
      TabOrder = 2
      OnEnter = edIDEnter
      OnExit = edIDExit
    end
    object cbEnabled: TCheckBox
      Left = 6
      Top = 80
      Width = 86
      Height = 17
      Alignment = taLeftJustify
      Caption = '&Enabled'
      TabOrder = 3
      OnClick = cbEnabledClick
    end
    object cbChecked: TCheckBox
      Left = 6
      Top = 104
      Width = 86
      Height = 17
      Alignment = taLeftJustify
      Caption = '&Checked'
      TabOrder = 4
      OnClick = cbEnabledClick
    end
  end
  object alMenuEditor: TActionList
    Left = 738
    Top = 10
    object actMenuInsertItem: TAction
      Category = 'Menu'
      Caption = 'Insert Item &Before'
      ShortCut = 45
      OnExecute = actMenuInsertItemExecute
    end
    object actMenuDeleteItem: TAction
      Category = 'Menu'
      Caption = '&Delete Item'
      ShortCut = 46
      OnExecute = actMenuDeleteItemExecute
    end
    object actMenuCreateSubMenu: TAction
      Category = 'Menu'
      Caption = '&Create Sub-Menu'
      ShortCut = 16423
      OnExecute = actMenuCreateSubMenuExecute
    end
    object actMenuInsertItemAfter: TAction
      Category = 'Menu'
      Caption = 'Insert Item &After'
      ShortCut = 16429
      OnExecute = actMenuInsertItemAfterExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 738
    Top = 42
    object mnuMenu: TMenuItem
      Caption = '&Menu'
      GroupIndex = 28
      object mnuMenuInsertItem: TMenuItem
        Action = actMenuInsertItem
      end
      object InsertItemAfter1: TMenuItem
        Action = actMenuInsertItemAfter
      end
      object mnuMenuDeleteItem: TMenuItem
        Action = actMenuDeleteItem
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuMenUCreateSubMenu: TMenuItem
        Action = actMenuCreateSubMenu
      end
    end
  end
  object pomMenu: TPopupMenu
    Left = 738
    Top = 74
    object InsertItem1: TMenuItem
      Action = actMenuInsertItem
    end
    object InsertItemAfter2: TMenuItem
      Action = actMenuInsertItemAfter
    end
    object DeleteItem1: TMenuItem
      Action = actMenuDeleteItem
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object CreateSubMenu1: TMenuItem
      Action = actMenuCreateSubMenu
    end
  end
end
