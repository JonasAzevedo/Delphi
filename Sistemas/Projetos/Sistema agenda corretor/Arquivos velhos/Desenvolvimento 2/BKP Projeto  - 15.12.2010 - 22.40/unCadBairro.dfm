inherited frmCadBairro: TfrmCadBairro
  Left = 376
  Top = 204
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'CADASTRO DE BAIRROS'
  ClientHeight = 179
  ClientWidth = 377
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblCodigo: TLabel [0]
    Left = 27
    Top = 69
    Width = 36
    Height = 13
    Caption = 'C'#243'digo:'
  end
  object lblNome: TLabel [1]
    Left = 27
    Top = 80
    Width = 31
    Height = 13
    Caption = 'Nome:'
  end
  inherited StatusBar: TStatusBar
    Top = 160
    Width = 377
  end
  inherited grpBxDados: TGroupBox
    Width = 377
    Height = 120
    object Label1: TLabel
      Left = 5
      Top = 20
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 5
      Top = 88
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object lblCampoObrigatorio2: TLabel
      Left = 36
      Top = 82
      Width = 6
      Height = 13
      Caption = '*'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object plsEdCodigo: TPlsEdit
      Left = 44
      Top = 14
      Width = 71
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnExit = plsEdCodigoExit
      OnKeyUp = plsEdCodigoKeyUp
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object plsEdNome: TPlsEdit
      Left = 44
      Top = 82
      Width = 322
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 1
      Text = 'PLSEDNOME'
      OnExit = plsEdNomeExit
      OnKeyUp = plsEdNomeKeyUp
      plsCorRecebeFoco = clSilver
    end
    object pnlCidade: TPanel
      Left = 5
      Top = 40
      Width = 364
      Height = 32
      BevelOuter = bvNone
      TabOrder = 2
      object spBtnBuscaCidade: TSpeedButton
        Left = 339
        Top = 6
        Width = 23
        Height = 21
        Cursor = crHandPoint
        Flat = True
        Glyph.Data = {
          AA030000424DAA03000000000000360000002800000011000000110000000100
          18000000000074030000C40E0000C40E00000000000000000000FCFDFFF9FEFE
          FBFFFBFFFDFEFFFCFFEFF1FAD2E1EDF5FCFDFFFEFCFBFEFDF9FFFFFBFFFFFEFF
          FFFFFFFFFFFFFFFFFEFFFFFDFF00FFFBFEF6FEFCF1FFFBFEFDFEFFFFFFA5AFC9
          6E97AD9CBBC9FFFFFFFBFEFEFBFFFFFBFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFE
          FF00FFFAFEF2FFFAE7FFFAFBFFFEFFF8FF90A3C279BEDA5188A5EBF5FFFEFFFF
          FDFFFFFEFFFFFDFEFEFFFFFFFFFFFFFFFFFFFFFFFF00FFFAFDF2FFF9E2FFF8FA
          FDFDFFFEFFADC5DF73C3E34383A8C5D0E3FFFFFFFFFEFEFDFDFDFDFDFDFFFFFF
          FFFFFFFFFFFFFFFFFF00FFFAFEF5FFFAE9FFF8FAFEFDFFFCFFC4DAE980C8E463
          9EBE99A5C0FFFFFFFEFEFEFBFBFBFDFEFEFEFEFEFFFFFFFDFFFFFDFFFF00FFFB
          FFF8FFFAF4FFF6FDFEF9FFFDFFE5F8FE8DBBD0ACD0E8777E96F5F5F6FFFFFFFD
          FCFCFDFCFCFDFDFDFEFFFFFBFFFFFBFFFF00FAFDFFFCFFFCFEFFF5FFFFF6FAFE
          FBF3FFFFBCCEDC8590A2828391F4F1F3FFFEFFFFFFFFFFFEFEFEFEFEFEFFFFFB
          FFFFFAFFFF00F5FDFFFDFFFDFFFFF8FEFFF6FAFFFAFBFFFFFFFFFFB3ACB1C3BC
          BDB4AFAEADAAA7D1CCCCFEFFFFFFFFFFFEFEFEFCFEFEFAFEFE00FBFDFFFCFDFE
          FFFDFFFFFEFEFFFEFDFBF9F5C0B2A6A69281D0BFAACFD2BFD1D3C4AFAEA3C6C1
          BCFFFDFCFFFCFEFCFBFDFAFEFE00FFFEFFFCFDFFFFFDFFFFFEFFFFFFFFDBD7D2
          746557B8A591EAD7BFD9D8BFE9E9D3FAF4E4A99E96E5E0DDFFFFFFFFFCFFFAFF
          FF00FFFEFFFEFEFFFFFEFFFFFDFFFFFFFFA9A09A9F9386DFCFBCE4D3BDE1D8BC
          E5DEC5ECE2D0C2B6ACBEB2ADFFFFFFFEFEFEFAFDFD00FFFEFFFFFEFFFFFEFFFF
          FDFFFFFFFFA49D98C5B9AFF4E6D6EEDCCAE4D6B9D9CCB0E2D3BFAB9D92BBADA8
          FFFFFEFEFEFFF9FCFE00FFFDFFFFFEFFFDFEFFFDFEFFFFFFFFCCC7C4B3AAA0FD
          F0E4E4D4C1DBC8AED3C2A7C3B49F8E8175E5DDD8FFFFFFFEFCFFFBFEFF00FFFD
          FFFFFDFFFBFEFFFCFEFFFFFFFFF3F0F0988E87BEB3A8CDBEAEBCA993B29E8983
          7262B1A69BFFFFFFFFFFFFFFFEFFFCFFFF00FFFFFFFFFDFFFBFEFFFCFEFFFFFC
          FFFFFFFFF6F1EF978F877B6E63725F53806E63ACA097FFFEFCFFFFFFFDFFFFFE
          FFFFFCFFFD00FFFFFFFFFDFFFCFEFFFCFEFFFDFEFFFBFAF9FFFFFFFFFFFFEEE8
          E1EAE4DFF2ECE8FFFFFFFCFCFEFCFDFCFBFEFFFCFFFFFFFFFD00FFFFFFFFFDFF
          FCFEFFFDFEFFF9F8FAFEFDFDFFFDFBFEFDF8FFFFFAFFFFFFFFFFFFFFFDFFF9F8
          FCF9FBFDF9FDFFFDFFFFFFFFFD00}
        OnClick = spBtnBuscaCidadeClick
      end
      object lblCampoObrigatorio1: TLabel
        Left = 31
        Top = 6
        Width = 6
        Height = 13
        Caption = '*'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCidade: TLabel
        Left = 0
        Top = 12
        Width = 36
        Height = 13
        Caption = 'Cidade:'
      end
      object plsEdCidade: TPlsEdit
        Left = 39
        Top = 6
        Width = 299
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 0
        OnExit = plsEdCidadeExit
        plsCorRecebeFoco = clSilver
      end
    end
  end
  inherited ToolBar: TToolBar
    Width = 377
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * FROM bairro '
      'WHERE 1=2')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryDadosCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
      Required = True
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  inherited cdsDados: TClientDataSet
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsDadosCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
      Required = True
    end
    object cdsDadosNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
end
