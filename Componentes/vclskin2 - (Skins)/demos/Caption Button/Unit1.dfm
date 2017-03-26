object Form1: TForm1
  Left = 230
  Top = 109
  Width = 477
  Height = 309
  Caption = 'Form1'
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
  object Memo1: TMemo
    Left = 24
    Top = 16
    Width = 417
    Height = 185
    Lines.Strings = (
      'Custom Caption Button'
      ''
      'Vclskin support custom caption button.'
      ''
      
        '1 open skin file in skin builder, click "Add caption button" but' +
        'ton in toolbar.'
      '2 import button bitmap .'
      '3 set "Button Action Code" to (200~2000).'
      '4 capture "cn_captionBtnClick" in your application.'
      
        '5 if "Button Visible1" is (1000~2000), you can set it visible at' +
        ' runtime using '
      '  "cn_captionvisible" message. '
      ''
      
        'Please click Green caption button to try. it only show in mainfo' +
        'rm.')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 184
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 296
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Open Form2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object SkinData1: TSkinData
    Active = True
    DisableTag = 99
    SkinControls = [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo, xcCheckBox, xcRadioButton, xcProgress, xcScrollbar, xcEdit, xcButton, xcBitBtn, xcSpeedButton, xcPanel, xcGroupBox, xcStatusBar, xcTab, xcSystemMenu]
    Options = []
    Skin3rd.Strings = (
      'TTBDock=Panel'
      'TTBToolbar=Panel'
      'TImageEnMView=scrollbar'
      'TImageEnView=scrollbar'
      'TAdvMemo=scrollbar'
      'TDBAdvMemo=scrollbar'
      'TRzButton=button'
      'TRzBitbtn=bitbtn'
      'TRzMenuButton=bitbtn'
      'TRzCheckGroup=CheckGroup'
      'TRzRadioGroup=Radiogroup'
      'TRzRadioButton=Radiobutton'
      'TRzCheckBox=Checkbox'
      'TRzButtonEdit=Edit'
      'TRzDBRadioGroup=Radiogroup'
      'TRzDBRadioButton=Radiobutton'
      'TRzDBCheckBox=Checkbox'
      'TRzDateTimeEdit=combobox'
      'TRzColorEdit=combobox'
      'TRzDateTimePicker=combobox'
      'TRzDBDateTimeEdit=combobox'
      'TRzDbColorEdit=combobox'
      'TRzDBDateTimePicker=combobox'
      'TLMDGroupBox=Groupbox'
      'TDBCheckboxEh=Checkbox'
      'TDBCheckboxEh=Checkbox'
      'TLMDCHECKBOX=Checkbox'
      'TLMDDBCHECKBOX=Checkbox'
      'TLMDRadiobutton=Radiobutton'
      'TLMDCalculator=panel'
      'TLMDGROUPBOX=Panel'
      'TLMDSIMPLEPANEL=Panel'
      'TLMDDBCalendar=Panel'
      'TLMDButtonPanel=Panel'
      'TLMDLMDCalculator=Panel'
      'TLMDHeaderPanel=Panel'
      'TLMDTechnicalLine=Panel'
      'TLMDLMDClock=Panel'
      'TLMDTrackbar=panel'
      'TLMDListCombobox=combobox'
      'TLMDCheckListCombobox=combobox'
      'TLMDHeaderListCombobox=combobox'
      'TLMDImageCombobox=combobox'
      'TLMDColorCombobox=combobox'
      'TLMDFontCombobox=combobox'
      'TLMDFontSizeCombobox=combobox'
      'TLMDFontSizeCombobox=combobox'
      'TLMDPrinterCombobox=combobox'
      'TLMDDriveCombobox=combobox'
      'TLMDCalculatorComboBox=combobox'
      'TLMDTrackBarComboBox=combobox'
      'TLMDCalendarComboBox=combobox'
      'TLMDTreeComboBox=combobox'
      'TLMDRADIOGROUP=radiogroup'
      'TLMDCheckGroup=CheckGroup'
      'TLMDDBRADIOGROUP=radiogroup'
      'TLMDDBCheckGroup=CheckGroup'
      'TLMDCalculatorEdit=edit'
      'TLMDEDIT=Edit'
      'TLMDMASKEDIT=Edit'
      'TLMDBROWSEEDIT=Edit'
      'TLMDEXTSPINEDIT=Edit'
      'TLMDCALENDAREDIT=Edit'
      'TLMDFILEOPENEDIT=Edit'
      'TLMDFILESAVEEDIT=Edit'
      'TLMDCOLOREDIT=Edit'
      'TLMDDBEDIT=Edit'
      'TLMDDBMASKEDIT=Edit'
      'TLMDDBEXTSPINEDIT=Edit'
      'TLMDDBSPINEDIT=Edit'
      'TLMDDBEDITDBLookup=Edit'
      'TLMDEDITDBLookup=Edit'
      'TDBLookupCombobox=Combobox'
      'TWWDBCombobox=Combobox'
      'TWWDBLookupCombo=Combobox'
      'TWWDBCombobox=Combobox'
      'TWWKeyCombo=Combobox'
      'TWWTempKeyCombo=combobox'
      'TWWDBDateTimePicker=Combobox'
      'TWWRADIOGROUP=radiogroup'
      'TWWDBEDIT=Edit'
      'TcxButton=bitbtn'
      'TcxDBCheckBox=checkbox'
      'TcxDBRadioGroup=radiogroup'
      'TcxRadioGroup=radiogroup'
      'TcxCheckBox=checkbox'
      'TOVCPICTUREFIELD=Edit'
      'TOVCDBPICTUREFIELD=Edit'
      'TOVCSLIDEREDIT=Edit'
      'TOVCDBSLIDEREDIT=Edit'
      'TOVCSIMPLEFIELD=Edit'
      'TOVCDBSIMPLEFIELD=Edit'
      'TO32DBFLEXEDIT=Edit'
      'TOVCNUMERICFIELD=Edit'
      'TOVCDBNUMERICFIELD=Edit')
    SkinFile = 'macos.skn'
    SkinStore = '(none)'
    SkinFormtype = sfMainform
    Version = '3.02.03.07'
    MenuUpdate = True
    MenuMerge = False
    Left = 48
    Top = 224
    SkinStream = {00000000}
  end
end
