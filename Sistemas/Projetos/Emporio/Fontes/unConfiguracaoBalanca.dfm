object frmConfiguracaoBalanca: TfrmConfiguracaoBalanca
  Left = 448
  Top = 152
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'EMP'#211'RIO --> Configura'#231#245'es da Balan'#231'a'
  ClientHeight = 436
  ClientWidth = 356
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
  object grpBxConfiguracaoBalanca: TGroupBox
    Left = 48
    Top = 24
    Width = 249
    Height = 385
    Caption = 'Dados de Configura'#231#227'o'
    TabOrder = 0
    object Label1: TLabel
      Left = 35
      Top = 69
      Width = 42
      Height = 13
      Caption = 'Balan'#231'a:'
    end
    object Label2: TLabel
      Left = 35
      Top = 99
      Width = 57
      Height = 13
      Caption = 'Porta Serial:'
    end
    object Label3: TLabel
      Left = 35
      Top = 129
      Width = 56
      Height = 13
      Caption = 'Velocidade:'
    end
    object Label4: TLabel
      Left = 35
      Top = 159
      Width = 43
      Height = 13
      Caption = 'DataBits:'
    end
    object Label6: TLabel
      Left = 35
      Top = 189
      Width = 45
      Height = 13
      Caption = 'Paridade:'
    end
    object Label7: TLabel
      Left = 35
      Top = 219
      Width = 45
      Height = 13
      Caption = 'Stop Bits:'
    end
    object Label8: TLabel
      Left = 35
      Top = 249
      Width = 66
      Height = 13
      Caption = 'Handshaking:'
    end
    object Label9: TLabel
      Left = 35
      Top = 279
      Width = 46
      Height = 13
      Caption = 'Time Out:'
    end
    object bvlDivisa: TBevel
      Left = 10
      Top = 45
      Width = 240
      Height = 12
      Shape = bsBottomLine
    end
    object cbBxBalanca: TComboBox
      Left = 105
      Top = 63
      Width = 100
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'cbBxBalanca'
      Items.Strings = (
        'Nenhuma'
        'Filizola'
        'Toledo')
    end
    object cbBxPortaSerial: TComboBox
      Left = 105
      Top = 93
      Width = 100
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'cbBxPortaSerial'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8')
    end
    object cbBxVelocidade: TComboBox
      Left = 105
      Top = 123
      Width = 100
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Text = 'cbBxVelocidade'
      Items.Strings = (
        '110'
        '300'
        '600'
        '1200'
        '2400'
        '4800'
        '9600'
        '14400'
        '19200'
        '38400'
        '56000'
        '57600')
    end
    object cbBxDataBits: TComboBox
      Left = 105
      Top = 153
      Width = 100
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Text = 'cbBxDataBits'
      Items.Strings = (
        '5'
        '6'
        '7'
        '8')
    end
    object cbBxParidade: TComboBox
      Left = 105
      Top = 183
      Width = 100
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Text = 'cbBxParidade'
      Items.Strings = (
        'none'
        'odd'
        'even'
        'mark'
        'space')
    end
    object cbBxStopBits: TComboBox
      Left = 105
      Top = 213
      Width = 100
      Height = 21
      ItemHeight = 13
      TabOrder = 5
      Text = 'cbBxStopBits'
      Items.Strings = (
        's1'
        's1,5'
        's2')
    end
    object cbBxHandshaking: TComboBox
      Left = 105
      Top = 243
      Width = 100
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      Text = 'cbBxHandshaking'
      Items.Strings = (
        'Nenhum'
        'XON/XOFF'
        'RTS/CTS'
        'DTR/DSR')
    end
    object edTimeOut: TEdit
      Left = 105
      Top = 273
      Width = 100
      Height = 21
      TabOrder = 7
      Text = 'edTimeOut'
    end
    object btBtnGravar: TBitBtn
      Left = 33
      Top = 336
      Width = 174
      Height = 39
      Caption = 'Gravar'
      TabOrder = 8
      OnClick = btBtnGravarClick
    end
    object rdBtnAtiva: TRadioButton
      Left = 10
      Top = 16
      Width = 57
      Height = 17
      Caption = 'Ativa'
      TabOrder = 9
    end
    object rdBtnInativa: TRadioButton
      Left = 10
      Top = 32
      Width = 57
      Height = 17
      Caption = 'Inativa'
      TabOrder = 10
    end
    object ckBxMonitora: TCheckBox
      Left = 35
      Top = 309
      Width = 110
      Height = 17
      Caption = 'Monitora Balan'#231'a'
      TabOrder = 11
    end
  end
end
