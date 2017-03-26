object frmSC: TfrmSC
  OldCreateOrder = False
  Height = 271
  Width = 415
  object DSServer1: TDSServer
    Left = 96
    Top = 11
  end
  object DSAuthenticationManager1: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManager1UserAuthenticate
    OnUserAuthorize = DSAuthenticationManager1UserAuthorize
    Roles = <>
    Left = 98
    Top = 197
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 200
    Top = 11
  end
  object scMinhaClasseMetodos: TDSServerClass
    OnGetClass = scMinhaClasseMetodosGetClass
    Server = DSServer1
    Left = 200
    Top = 88
  end
end
