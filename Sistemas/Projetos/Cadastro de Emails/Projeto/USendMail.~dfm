object frmSendMail: TfrmSendMail
  Left = 401
  Top = 110
  Width = 870
  Height = 500
  Caption = 'frmSendMail'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 176
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object IdSMTP1: TIdSMTP
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 25
    AuthenticationType = atNone
    Left = 496
    Top = 184
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    Recipients = <>
    ReplyTo = <>
    Left = 496
    Top = 208
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 504
    Top = 232
  end
  object SSLSocket: TIdSSLIOHandlerSocket
    SSLOptions.Method = sslvSSLv2
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 496
    Top = 264
  end
end
