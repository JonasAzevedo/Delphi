object frmSelecionaEmailSite: TfrmSelecionaEmailSite
  Left = 583
  Top = 175
  BorderStyle = bsSingle
  Caption = 'UTOPIA MACI'#199'A --> Selecionando E-Mail'#39's'
  ClientHeight = 291
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 272
    Width = 641
    Height = 19
    Panels = <
      item
        Width = 450
      end
      item
        Width = 50
      end>
  end
  object pnlSite: TPanel
    Left = 0
    Top = 0
    Width = 641
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 1
    object lblSite: TLabel
      Left = 16
      Top = 16
      Width = 3
      Height = 13
    end
  end
  object TDBGrid
    Left = 0
    Top = 41
    Width = 641
    Height = 231
    Hint = 'E-Mail'#39's Cadastrados'
    Align = alClient
    DataSource = DM.dsEnviaEmail
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'EMAIL_PARA'
        Title.Caption = 'E-Mail Destino'
        Visible = True
      end>
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 16
    Top = 84
  end
end
