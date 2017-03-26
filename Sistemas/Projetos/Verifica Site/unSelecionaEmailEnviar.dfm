object frmSelecionaEmailEnviar: TfrmSelecionaEmailEnviar
  Left = 281
  Top = 173
  BorderStyle = bsSingle
  Caption = 'UTOPIA MACI'#199'A --> Enviar Email Para Site'
  ClientHeight = 318
  ClientWidth = 644
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 644
    Height = 41
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    TabOrder = 0
    object lblSite: TLabel
      Left = 19
      Top = 16
      Width = 597
      Height = 13
      AutoSize = False
    end
  end
  object dbGrdEmails: TDBGrid
    Left = 0
    Top = 41
    Width = 644
    Height = 277
    Align = alClient
    DataSource = DM.dsEnviaEmail
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbGrdEmailsDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'EMAIL_PARA'
        Title.Caption = 'E-mail'
        Visible = True
      end>
  end
end
