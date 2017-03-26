inherited frmCadImoveis: TfrmCadImoveis
  Left = 357
  Top = 181
  Caption = 'CADASTRO DE IM'#211'VEIS'
  ClientHeight = 477
  ClientWidth = 474
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 458
    Width = 474
    Panels = <
      item
        Width = 360
      end>
  end
  inherited grpBxDados: TGroupBox
    Width = 474
    Height = 418
    object lblCodigo: TLabel
      Left = 5
      Top = 20
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object lblDescricao: TLabel
      Left = 5
      Top = 353
      Width = 57
      Height = 13
      Cursor = crHandPoint
      Hint = 'Selecionar a Descri'#231#227'o do Im'#243'vel'
      Caption = 'Descri'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic, fsUnderline]
      ParentFont = False
      OnClick = lblDescricaoClick
      OnMouseDown = lblDescricaoMouseDown
    end
    object plsEdCodigo: TPlsEdit
      Left = 44
      Top = 14
      Width = 68
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnExit = plsEdCodigoExit
      OnKeyUp = plsEdCodigoKeyUp
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object plsMmDescricao: TPlsMemo
      Left = 66
      Top = 353
      Width = 398
      Height = 50
      Lines.Strings = (
        'plsMmDescricao')
      MaxLength = 500
      TabOrder = 4
      OnEnter = plsMmDescricaoEnter
      OnKeyPress = plsMmDescricaoKeyPress
      plsCorRecebeFoco = clSilver
    end
    object grpBxEndereco: TGroupBox
      Left = 4
      Top = 75
      Width = 462
      Height = 230
      Caption = 'Endere'#231'o '
      TabOrder = 2
      object lblCEP: TLabel
        Left = 5
        Top = 141
        Width = 27
        Height = 13
        Caption = 'CEP: '
      end
      object lblComplemento: TLabel
        Left = 5
        Top = 163
        Width = 70
        Height = 13
        Caption = 'Complemento: '
      end
      object plsMedEnderecoCEP: TPlsMaskEdit
        Left = 45
        Top = 135
        Width = 73
        Height = 21
        Enabled = False
        EditMask = '99999-999;1;_'
        MaxLength = 9
        TabOrder = 4
        Text = '     -   '
        OnEnter = plsMedEnderecoCEPEnter
        OnKeyPress = plsMedEnderecoCEPKeyPress
        plsCorRecebeFoco = clSilver
      end
      object plsMmEnderecoComplemento: TPlsMemo
        Left = 5
        Top = 178
        Width = 450
        Height = 39
        Lines.Strings = (
          'plsMmComplemento')
        MaxLength = 500
        TabOrder = 5
        OnEnter = plsMmEnderecoComplementoEnter
        OnKeyPress = plsMmEnderecoComplementoKeyPress
        plsCorRecebeFoco = clSilver
      end
      object pnlEstado: TPanel
        Left = 2
        Top = 15
        Width = 457
        Height = 27
        BevelOuter = bvNone
        TabOrder = 0
        object spBtnBuscaEstado: TSpeedButton
          Left = 433
          Top = 3
          Width = 22
          Height = 21
          Cursor = crHandPoint
          Hint = 'Selecionar Estado'
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
          OnClick = spBtnBuscaEstadoClick
        end
        object lblCampoObrigatorio2: TLabel
          Left = 38
          Top = 3
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
        object lblEstado: TLabel
          Left = 5
          Top = 9
          Width = 39
          Height = 13
          Caption = 'Estado: '
        end
        object plsEdEstado: TPlsEdit
          Left = 45
          Top = 3
          Width = 389
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 50
          TabOrder = 0
          OnEnter = plsEdEstadoEnter
          OnExit = plsEdEstadoExit
          OnKeyPress = plsEdEstadoKeyPress
          plsCorRecebeFoco = clSilver
        end
      end
      object pnlCidade: TPanel
        Left = 2
        Top = 45
        Width = 457
        Height = 27
        BevelOuter = bvNone
        TabOrder = 1
        object spBtnBuscaCidade: TSpeedButton
          Left = 433
          Top = 3
          Width = 22
          Height = 21
          Cursor = crHandPoint
          Hint = 'Selecionar Cidade'
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
        object lblCampoObrigatorio3: TLabel
          Left = 38
          Top = 3
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
          Left = 5
          Top = 9
          Width = 39
          Height = 13
          Caption = 'Cidade: '
        end
        object plsEdCidade: TPlsEdit
          Left = 45
          Top = 3
          Width = 389
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 100
          TabOrder = 0
          OnEnter = plsEdCidadeEnter
          OnExit = plsEdCidadeExit
          OnKeyPress = plsEdCidadeKeyPress
          plsCorRecebeFoco = clSilver
        end
      end
      object pnlRua: TPanel
        Left = 2
        Top = 105
        Width = 457
        Height = 27
        BevelOuter = bvNone
        TabOrder = 3
        object spBtnBuscaRua: TSpeedButton
          Left = 432
          Top = 3
          Width = 23
          Height = 21
          Cursor = crHandPoint
          Hint = 'Selecionar Rua'
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
          OnClick = spBtnBuscaRuaClick
        end
        object lblRua: TLabel
          Left = 5
          Top = 9
          Width = 26
          Height = 13
          Caption = 'Rua: '
        end
        object plsEdRua: TPlsEdit
          Left = 45
          Top = 3
          Width = 389
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 100
          TabOrder = 0
          OnEnter = plsEdRuaEnter
          OnExit = plsEdRuaExit
          OnKeyPress = plsEdRuaKeyPress
          plsCorRecebeFoco = clSilver
        end
      end
      object pnlBairro: TPanel
        Left = 2
        Top = 75
        Width = 457
        Height = 27
        BevelOuter = bvNone
        TabOrder = 2
        object lblBairro: TLabel
          Left = 5
          Top = 9
          Width = 33
          Height = 13
          Caption = 'Bairro: '
        end
        object spBtnBuscaBairro: TSpeedButton
          Left = 432
          Top = 3
          Width = 23
          Height = 21
          Cursor = crHandPoint
          Hint = 'Selecionar Bairro'
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
          OnClick = spBtnBuscaBairroClick
        end
        object plsEdBairro: TPlsEdit
          Left = 45
          Top = 3
          Width = 389
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 100
          TabOrder = 0
          OnEnter = plsEdBairroEnter
          OnExit = plsEdBairroExit
          OnKeyPress = plsEdBairroKeyPress
          plsCorRecebeFoco = clSilver
        end
      end
    end
    object pnlTipoImovel: TPanel
      Left = 4
      Top = 42
      Width = 460
      Height = 27
      BevelOuter = bvNone
      TabOrder = 1
      object lblTipoImovel: TLabel
        Left = 1
        Top = 10
        Width = 73
        Height = 13
        Caption = 'Tipo de Im'#243'vel:'
      end
      object spBtnBuscaTipoImovel: TSpeedButton
        Left = 436
        Top = 2
        Width = 22
        Height = 21
        Cursor = crHandPoint
        Hint = 'Selecionar Tipo de Im'#243'vel'
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
        OnClick = spBtnBuscaTipoImovelClick
      end
      object lblCampoObrigatorio1: TLabel
        Left = 74
        Top = 2
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
      object plsEdTipoImovel: TPlsEdit
        Left = 80
        Top = 2
        Width = 356
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 60
        TabOrder = 0
        OnEnter = plsEdTipoImovelEnter
        OnExit = plsEdTipoImovelExit
        OnKeyPress = plsEdTipoImovelKeyPress
        plsCorRecebeFoco = clSilver
      end
    end
    object pnlSituacaoValor: TPanel
      Left = 4
      Top = 313
      Width = 465
      Height = 31
      BevelOuter = bvNone
      TabOrder = 3
      object lblSituacao: TLabel
        Left = 1
        Top = 11
        Width = 45
        Height = 13
        Caption = 'Situa'#231#227'o:'
      end
      object Label1: TLabel
        Left = 56
        Top = 3
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
      object lblValor: TLabel
        Left = 320
        Top = 11
        Width = 30
        Height = 13
        Caption = 'Valor: '
      end
      object plsEdValor: TPlsEdit
        Left = 362
        Top = 4
        Width = 100
        Height = 21
        TabOrder = 1
        Text = 'plsEdValor'
        OnEnter = plsEdValorEnter
        OnKeyPress = plsEdValorKeyPress
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario2
      end
      object plsCbBxSituacao: TPlsComboBox
        Left = 63
        Top = 3
        Width = 201
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnEnter = plsCbBxSituacaoEnter
        OnKeyPress = plsCbBxSituacaoKeyPress
        Items.Strings = (
          'PLANTA'
          'PRONTO PARA MORAR'
          'DE TERCEIROS')
        plsCorRecebeFoco = clSilver
      end
    end
    object pnlStatus: TPanel
      Left = 304
      Top = 12
      Width = 158
      Height = 24
      BevelOuter = bvNone
      TabOrder = 5
      object lblTituloStatus: TLabel
        Left = 2
        Top = 10
        Width = 33
        Height = 13
        Caption = 'Status:'
      end
      object lblStatus: TLabel
        Left = 38
        Top = 10
        Width = 88
        Height = 13
        Hint = 'Status do Im'#243'vel'
        Caption = '[VALOR STATUS]'
      end
    end
  end
  inherited ToolBar: TToolBar
    Width = 474
    inherited pnlDicas: TPanel
      Width = 220
      inherited lblDicas: TLabel
        Left = 186
        Hint = 'Dicas do Cadastro de Im'#243'veis'
        OnClick = lblDicasClick
      end
    end
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * FROM imovel'
      'WHERE 1=2'
      'ORDER BY codigo')
    Left = 252
    Top = 22
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryDadosSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object zQryDadosCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object zQryDadosCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zQryDadosCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zQryDadosCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
    end
    object zQryDadosCOD_FK_RUA: TIntegerField
      FieldName = 'COD_FK_RUA'
    end
    object zQryDadosENDERECO_CEP: TStringField
      FieldName = 'ENDERECO_CEP'
      Size = 9
    end
    object zQryDadosENDERECO_COMPLEMENTO: TStringField
      FieldName = 'ENDERECO_COMPLEMENTO'
      Size = 500
    end
    object zQryDadosSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zQryDadosVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object zQryDadosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 500
    end
  end
  inherited dsDados: TDataSource
    Left = 339
    Top = 22
  end
  inherited dspDados: TDataSetProvider
    Left = 281
    Top = 22
  end
  inherited cdsDados: TClientDataSet
    Left = 311
    Top = 22
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsDadosSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object cdsDadosCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object cdsDadosCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object cdsDadosCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object cdsDadosCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
    end
    object cdsDadosCOD_FK_RUA: TIntegerField
      FieldName = 'COD_FK_RUA'
    end
    object cdsDadosENDERECO_CEP: TStringField
      FieldName = 'ENDERECO_CEP'
      Size = 9
    end
    object cdsDadosENDERECO_COMPLEMENTO: TStringField
      FieldName = 'ENDERECO_COMPLEMENTO'
      Size = 500
    end
    object cdsDadosSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object cdsDadosVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object cdsDadosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 500
    end
  end
end
