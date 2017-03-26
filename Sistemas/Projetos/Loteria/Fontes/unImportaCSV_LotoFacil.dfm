object frmImportaDadosLotoFacil: TfrmImportaDadosLotoFacil
  Left = 323
  Top = 125
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Loto F'#225'cil --> Importa'#231#227'o de Dados'
  ClientHeight = 244
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 40
    Width = 66
    Height = 13
    Caption = 'Arquivo .CSV:'
  end
  object bvlDivisao: TBevel
    Left = 10
    Top = 68
    Width = 319
    Height = 10
    Shape = bsBottomLine
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 225
    Width = 345
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Width = 50
      end>
  end
  object edArquivoCSV: TEdit
    Left = 110
    Top = 32
    Width = 193
    Height = 21
    Hint = 'Abrir Arquivo .CSV'
    TabOrder = 1
    Text = 'edArquivoCSV'
    OnChange = edArquivoCSVChange
  end
  object btBtnAbrirArquivoCSV: TBitBtn
    Left = 304
    Top = 31
    Width = 25
    Height = 23
    Hint = 'Abrir Arquivo .CSV'
    Caption = '...'
    TabOrder = 2
    OnClick = btBtnAbrirArquivoCSVClick
  end
  object pnlImportar: TPanel
    Left = 0
    Top = 90
    Width = 345
    Height = 135
    Align = alBottom
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 3
    object Label2: TLabel
      Left = 10
      Top = 18
      Width = 106
      Height = 13
      Caption = 'Delimitador de Campo:'
    end
    object lblTotalRegistros: TLabel
      Left = 134
      Top = 118
      Width = 110
      Height = 16
      Caption = 'lblTotalRegistros'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 10
      Top = 118
      Width = 121
      Height = 16
      Caption = 'Total de Registros:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object edDelimitador: TEdit
      Left = 128
      Top = 12
      Width = 57
      Height = 21
      Hint = 'Delimitador de Campo'
      MaxLength = 1
      TabOrder = 0
      Text = 'edDelimitador'
      OnKeyPress = edDelimitadorKeyPress
    end
    object btBtnImportar: TBitBtn
      Left = 88
      Top = 64
      Width = 169
      Height = 41
      Hint = 'Importar Dados CSV para Base de Dados da Loto F'#225'cil'
      Caption = 'Importar'
      TabOrder = 1
      OnClick = btBtnImportarClick
    end
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 300
    Top = 120
  end
  object opDlgArquivoCSV: TOpenDialog
    Filter = 'Campo Separador por V'#237'gula (.CSV)|*.csv'
    Left = 300
    Top = 148
  end
end
