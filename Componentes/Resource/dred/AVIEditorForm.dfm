inherited fmAVIEditor: TfmAVIEditor
  Caption = 'fmAVIEditor'
  ClientHeight = 227
  ClientWidth = 537
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 145
    Top = 0
    Width = 3
    Height = 227
    Cursor = crHSplit
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 145
    Height = 227
    Align = alLeft
    BevelInner = bvLowered
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 148
    Top = 0
    Width = 389
    Height = 227
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 33
      Width = 387
      Height = 193
      Align = alClient
      BevelOuter = bvLowered
      Color = clWindow
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 387
      Height = 32
      Align = alTop
      TabOrder = 1
      object Panel5: TPanel
        Left = 189
        Top = 1
        Width = 197
        Height = 30
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object MediaPlayer1: TMediaPlayer
          Left = 0
          Top = 0
          Width = 197
          Height = 30
          ColoredButtons = []
          VisibleButtons = [btPlay, btPause, btStop, btNext, btPrev, btStep, btBack]
          DeviceType = dtAVIVideo
          Display = Panel3
          FileName = 'dred.drd+'
          TabOrder = 0
        end
      end
    end
  end
  object MediaPlayerMemoryFile1: TMediaPlayerMemoryFile
    FileName = 'dred.drd'
    Left = 200
    Top = 16
  end
end
