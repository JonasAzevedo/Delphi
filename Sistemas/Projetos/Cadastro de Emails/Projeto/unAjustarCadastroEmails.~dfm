object frmAjustarCadastroEmails: TfrmAjustarCadastroEmails
  Left = 324
  Top = 110
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'AJUSTAR CADASTRO DE EMAIL'#39'S'
  ClientHeight = 572
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grpBxRetirarDominio2: TGroupBox
    Left = 8
    Top = 24
    Width = 249
    Height = 537
    Caption = 'Retirar Domin'#237'o 2 '
    TabOrder = 0
    object lblTexto1: TLabel
      Left = 10
      Top = 20
      Width = 215
      Height = 13
      Caption = 'Retira o dom'#237'nio 2, quando este n'#227'o deve ter'
    end
    object lblTexto2: TLabel
      Left = 10
      Top = 40
      Width = 137
      Height = 13
      Caption = 'Exemplo: email@hotmail.com'
    end
    object lblTituloTotal: TLabel
      Left = 8
      Top = 512
      Width = 27
      Height = 13
      Caption = 'Total:'
    end
    object lblTotal: TLabel
      Left = 40
      Top = 512
      Width = 3
      Height = 13
    end
    object btBtnPesquisarRetirarDominio2: TBitBtn
      Left = 8
      Top = 64
      Width = 217
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 0
      OnClick = btBtnPesquisarRetirarDominio2Click
    end
  end
  object lstBxRetirarDominio2: TListBox
    Left = 16
    Top = 120
    Width = 225
    Height = 409
    ItemHeight = 13
    TabOrder = 1
  end
  object btBtnAtualizarRetirarDominio2: TBitBtn
    Left = 167
    Top = 531
    Width = 75
    Height = 25
    Caption = 'Atualizar'
    TabOrder = 2
    OnClick = btBtnAtualizarRetirarDominio2Click
  end
  object zQryPesquisa: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT * FROM email'
      'WHERE 1=2')
    Params = <>
    Left = 264
    Top = 32
    object zQryPesquisaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryPesquisaEMAIL: TStringField
      FieldName = 'EMAIL'
      Required = True
      Size = 100
    end
    object zQryPesquisaSERVIDOR_DO_EMAIL: TStringField
      FieldName = 'SERVIDOR_DO_EMAIL'
      Size = 50
    end
    object zQryPesquisaDOMINIO_1: TStringField
      FieldName = 'DOMINIO_1'
      Size = 10
    end
    object zQryPesquisaDOMINIO_2: TStringField
      FieldName = 'DOMINIO_2'
      Size = 5
    end
    object zQryPesquisaNOME_PROPRIETARIO: TStringField
      FieldName = 'NOME_PROPRIETARIO'
      Size = 100
    end
    object zQryPesquisaCIDADE_PROPRIETARIO: TStringField
      FieldName = 'CIDADE_PROPRIETARIO'
      Size = 100
    end
    object zQryPesquisaESTADO_PROPRIETARIO: TStringField
      FieldName = 'ESTADO_PROPRIETARIO'
      Size = 5
    end
    object zQryPesquisaPAIS_PROPRIETARIO: TStringField
      FieldName = 'PAIS_PROPRIETARIO'
      Size = 50
    end
    object zQryPesquisaMEIO_CAPTACAO: TStringField
      FieldName = 'MEIO_CAPTACAO'
      Size = 200
    end
    object zQryPesquisaRELEVANCIA: TIntegerField
      FieldName = 'RELEVANCIA'
    end
    object zQryPesquisaDATA_INSERCAO: TDateTimeField
      FieldName = 'DATA_INSERCAO'
    end
  end
end
