inherited frmCadPessoaFisica: TfrmCadPessoaFisica
  Left = 462
  Top = 100
  VertScrollBar.Range = 0
  BorderStyle = bsSingle
  Caption = 'CADASTRO DE PESSOAS F'#205'SICAS'
  ClientHeight = 599
  ClientWidth = 514
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 580
    Width = 514
    Panels = <
      item
        Width = 380
      end
      item
        Width = 50
      end>
  end
  inherited grpBxDados: TGroupBox
    Width = 514
    Height = 540
    object lblCodigo: TLabel
      Left = 5
      Top = 20
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object lblNome: TLabel
      Left = 5
      Top = 50
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object lblCPF: TLabel
      Left = 5
      Top = 80
      Width = 26
      Height = 13
      Caption = 'CPF: '
    end
    object lblIdentidade: TLabel
      Left = 157
      Top = 80
      Width = 56
      Height = 13
      Caption = 'Identidade: '
    end
    object lblDataNascimento: TLabel
      Left = 339
      Top = 80
      Width = 88
      Height = 13
      Caption = 'Data Nascimento: '
    end
    object lblEmail: TLabel
      Left = 5
      Top = 110
      Width = 32
      Height = 13
      Caption = 'E-Mail:'
    end
    object lblConjuge: TLabel
      Left = 5
      Top = 140
      Width = 45
      Height = 13
      Caption = 'C'#244'njuge: '
    end
    object lblCampoObrigatorio1: TLabel
      Left = 47
      Top = 44
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
    object plsMedCPF: TPlsMaskEdit
      Left = 54
      Top = 74
      Width = 90
      Height = 21
      CharCase = ecUpperCase
      EditMask = '999.999.999-99'
      MaxLength = 14
      TabOrder = 2
      Text = '   .   .   -  '
      OnExit = plsMedCPFExit
      OnKeyPress = plsMedCPFKeyPress
      OnKeyUp = plsMedCPFKeyUp
      plsCorRecebeFoco = clSilver
    end
    object plsEdNome: TPlsEdit
      Left = 54
      Top = 44
      Width = 447
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 1
      Text = 'PLSEDNOME'
      OnExit = plsEdNomeExit
      OnKeyPress = plsEdNomeKeyPress
      OnKeyUp = plsEdNomeKeyUp
      plsCorRecebeFoco = clSilver
    end
    object plsEdCodigo: TPlsEdit
      Left = 54
      Top = 14
      Width = 69
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnExit = plsEdCodigoExit
      OnKeyUp = plsEdCodigoKeyUp
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object plsEdIdentidade: TPlsEdit
      Left = 213
      Top = 74
      Width = 111
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 20
      TabOrder = 3
      Text = 'PLSEDIDENTIDADE'
      OnExit = plsEdIdentidadeExit
      OnKeyPress = plsEdIdentidadeKeyPress
      OnKeyUp = plsEdIdentidadeKeyUp
      plsCorRecebeFoco = clSilver
    end
    object plsMedDataNascimento: TPlsMaskEdit
      Left = 430
      Top = 74
      Width = 73
      Height = 21
      CharCase = ecUpperCase
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      plsCorRecebeFoco = clSilver
    end
    object plsEdEmail: TPlsEdit
      Left = 54
      Top = 104
      Width = 449
      Height = 21
      CharCase = ecLowerCase
      MaxLength = 100
      TabOrder = 5
      Text = 'plsedemail'
      plsCorRecebeFoco = clSilver
    end
    object grpBxTelefones: TGroupBox
      Left = 5
      Top = 194
      Width = 500
      Height = 43
      Caption = 'Telefones '
      TabOrder = 8
      object lblResidencial: TLabel
        Left = 5
        Top = 20
        Width = 61
        Height = 13
        Caption = 'Residencial: '
      end
      object lblComercial: TLabel
        Left = 182
        Top = 20
        Width = 52
        Height = 13
        Caption = 'Comercial: '
      end
      object lblCelular: TLabel
        Left = 360
        Top = 20
        Width = 38
        Height = 13
        Caption = 'Celular: '
      end
      object plsMedTelefoneResidencial: TPlsMaskEdit
        Left = 67
        Top = 14
        Width = 90
        Height = 21
        CharCase = ecUpperCase
        EditMask = '(99)9999-9999'
        MaxLength = 13
        TabOrder = 0
        Text = '(  )    -    '
        plsCorRecebeFoco = clSilver
      end
      object plsMedTelefoneComercial: TPlsMaskEdit
        Left = 234
        Top = 14
        Width = 90
        Height = 21
        CharCase = ecUpperCase
        EditMask = '(99)9999-9999'
        MaxLength = 13
        TabOrder = 1
        Text = '(  )    -    '
        plsCorRecebeFoco = clSilver
      end
      object plsMedTelefoneCelular: TPlsMaskEdit
        Left = 400
        Top = 14
        Width = 90
        Height = 21
        CharCase = ecUpperCase
        EditMask = '(99)9999-9999'
        MaxLength = 13
        TabOrder = 2
        Text = '(  )    -    '
        plsCorRecebeFoco = clSilver
      end
    end
    object grpBxEndereco: TGroupBox
      Left = 5
      Top = 243
      Width = 500
      Height = 233
      Caption = 'Endere'#231'o '
      TabOrder = 9
      object lblEstado: TLabel
        Left = 5
        Top = 20
        Width = 39
        Height = 13
        Caption = 'Estado: '
      end
      object spBtnBuscaEstado: TSpeedButton
        Left = 472
        Top = 14
        Width = 22
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
        OnClick = spBtnBuscaEstadoClick
      end
      object spBtnBuscaCidade: TSpeedButton
        Left = 472
        Top = 44
        Width = 22
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
      object lblCidade: TLabel
        Left = 5
        Top = 50
        Width = 39
        Height = 13
        Caption = 'Cidade: '
      end
      object lblBairro: TLabel
        Left = 5
        Top = 80
        Width = 33
        Height = 13
        Caption = 'Bairro: '
      end
      object lblRua: TLabel
        Left = 5
        Top = 110
        Width = 26
        Height = 13
        Caption = 'Rua: '
      end
      object lblCEP: TLabel
        Left = 5
        Top = 140
        Width = 27
        Height = 13
        Caption = 'CEP: '
      end
      object spBtnBuscaBairro: TSpeedButton
        Left = 472
        Top = 74
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
        OnClick = spBtnBuscaBairroClick
      end
      object spBtnBuscaRua: TSpeedButton
        Left = 472
        Top = 104
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
        OnClick = spBtnBuscaRuaClick
      end
      object lblComplemento: TLabel
        Left = 5
        Top = 165
        Width = 70
        Height = 13
        Caption = 'Complemento: '
      end
      object lblCampoObrigatorio4: TLabel
        Left = 39
        Top = 44
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
      object lblCampoObrigatorio3: TLabel
        Left = 39
        Top = 14
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
      object plsEdEstado: TPlsEdit
        Left = 45
        Top = 14
        Width = 428
        Height = 21
        CharCase = ecUpperCase
        MaxLength = -1
        ReadOnly = True
        TabOrder = 0
        OnClick = plsEdEstadoClick
        OnKeyPress = plsEdEstadoKeyPress
        plsCorRecebeFoco = clSilver
        plsAceitaCaractres = False
      end
      object plsEdCidade: TPlsEdit
        Left = 45
        Top = 44
        Width = 428
        Height = 21
        CharCase = ecUpperCase
        MaxLength = -1
        ReadOnly = True
        TabOrder = 1
        OnClick = plsEdCidadeClick
        OnKeyPress = plsEdCidadeKeyPress
        plsCorRecebeFoco = clSilver
        plsAceitaCaractres = False
      end
      object plsMedCEP: TPlsMaskEdit
        Left = 45
        Top = 134
        Width = 73
        Height = 21
        CharCase = ecUpperCase
        Enabled = False
        EditMask = '99999-999;1;_'
        MaxLength = 9
        TabOrder = 4
        Text = '     -   '
        plsCorRecebeFoco = clSilver
      end
      object plsEdRua: TPlsEdit
        Left = 45
        Top = 104
        Width = 428
        Height = 21
        CharCase = ecUpperCase
        MaxLength = -1
        ReadOnly = True
        TabOrder = 3
        OnClick = plsEdRuaClick
        OnKeyPress = plsEdRuaKeyPress
        plsCorRecebeFoco = clSilver
        plsAceitaCaractres = False
      end
      object plsEdBairro: TPlsEdit
        Left = 45
        Top = 74
        Width = 428
        Height = 21
        CharCase = ecUpperCase
        MaxLength = -1
        ReadOnly = True
        TabOrder = 2
        OnClick = plsEdBairroClick
        OnKeyPress = plsEdBairroKeyPress
        plsCorRecebeFoco = clSilver
        plsAceitaCaractres = False
      end
      object plsMmEnderecoComplemento: TPlsMemo
        Left = 5
        Top = 180
        Width = 487
        Height = 39
        Lines.Strings = (
          'plsMmComplemento')
        MaxLength = 500
        TabOrder = 5
        plsCorRecebeFoco = clSilver
      end
    end
    object plsEdConjuge: TPlsEdit
      Left = 54
      Top = 134
      Width = 449
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 6
      Text = 'PLSEDCONJUGE'
      plsCorRecebeFoco = clSilver
    end
    object grpBxHorarioLigacao: TGroupBox
      Left = 5
      Top = 481
      Width = 500
      Height = 47
      Caption = 'Hor'#225'rio Liga'#231#227'o '
      TabOrder = 10
      object lblPeriodo: TLabel
        Left = 5
        Top = 22
        Width = 44
        Height = 13
        Caption = 'Per'#237'odo: '
      end
      object lblDas: TLabel
        Left = 189
        Top = 22
        Width = 17
        Height = 13
        Caption = 'das'
      end
      object lblAs: TLabel
        Left = 280
        Top = 22
        Width = 11
        Height = 13
        Caption = #224's'
      end
      object plsCbBxPeriodo: TPlsComboBox
        Left = 50
        Top = 16
        Width = 127
        Height = 21
        Style = csDropDownList
        CharCase = ecUpperCase
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'MANH'#195
          'TARDE'
          'NOITE'
          'QUALQUER')
        plsCorRecebeFoco = clSilver
        plsEnterMudaCampo = True
      end
      object plsMedHoraLigacaoFinal: TPlsMaskEdit
        Left = 302
        Top = 16
        Width = 60
        Height = 21
        CharCase = ecUpperCase
        EditMask = '99:99'
        MaxLength = 5
        TabOrder = 2
        Text = '  :  '
        plsCorRecebeFoco = clSilver
      end
      object plsMedHoraLigacaoInicio: TPlsMaskEdit
        Left = 212
        Top = 16
        Width = 60
        Height = 21
        CharCase = ecUpperCase
        EditMask = '99:99'
        MaxLength = 5
        TabOrder = 1
        Text = '  :  '
        plsCorRecebeFoco = clSilver
      end
    end
    object pnlMeioCaptacao: TPanel
      Left = 4
      Top = 162
      Width = 506
      Height = 30
      BevelOuter = bvNone
      TabOrder = 7
      object lblMeioCaptacao: TLabel
        Left = 1
        Top = 10
        Width = 90
        Height = 13
        Caption = 'Meio de Capta'#231#227'o:'
      end
      object spBtnBuscaMeioCaptacao: TSpeedButton
        Left = 476
        Top = 4
        Width = 22
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
        OnClick = spBtnBuscaMeioCaptacaoClick
      end
      object lblCampoObrigatorio2: TLabel
        Left = 92
        Top = 4
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
      object plsEdMeioCaptacao: TPlsEdit
        Left = 99
        Top = 4
        Width = 376
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 20
        ReadOnly = True
        TabOrder = 0
        OnClick = plsEdMeioCaptacaoClick
        OnKeyPress = plsEdMeioCaptacaoKeyPress
        plsCorRecebeFoco = clSilver
      end
    end
  end
  inherited ToolBar: TToolBar
    Width = 514
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * FROM pessoa_fisica'
      'WHERE 1=2'
      'ORDER BY nome')
    Left = 340
    Top = 2
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object zQryDadosEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object zQryDadosCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object zQryDadosIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object zQryDadosDATA_NASCIMENTO: TDateTimeField
      FieldName = 'DATA_NASCIMENTO'
    end
    object zQryDadosCONJUGE: TStringField
      FieldName = 'CONJUGE'
      Size = 100
    end
    object zQryDadosTELEFONE_RESIDENCIAL: TStringField
      FieldName = 'TELEFONE_RESIDENCIAL'
      Size = 13
    end
    object zQryDadosTELEFONE_COMERCIAL: TStringField
      FieldName = 'TELEFONE_COMERCIAL'
      Size = 13
    end
    object zQryDadosTELEFONE_CELULAR: TStringField
      FieldName = 'TELEFONE_CELULAR'
      Size = 13
    end
    object zQryDadosCOD_FK_MEIO_CAPTACAO: TIntegerField
      FieldName = 'COD_FK_MEIO_CAPTACAO'
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
    object zQryDadosHORARIO_LIGACAO: TStringField
      FieldName = 'HORARIO_LIGACAO'
      Size = 8
    end
    object zQryDadosHORA_INICIO: TTimeField
      FieldName = 'HORA_INICIO'
    end
    object zQryDadosHORA_FINAL: TTimeField
      FieldName = 'HORA_FINAL'
    end
  end
  inherited dsDados: TDataSource
    Left = 427
    Top = 2
  end
  inherited dspDados: TDataSetProvider
    Left = 369
    Top = 2
  end
  inherited cdsDados: TClientDataSet
    Left = 399
    Top = 2
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosDATA_CADASTRO: TDateTimeField
      FieldName = 'DATA_CADASTRO'
    end
    object cdsDadosNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object cdsDadosEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object cdsDadosCPF: TStringField
      FieldName = 'CPF'
      Size = 14
    end
    object cdsDadosIDENTIDADE: TStringField
      FieldName = 'IDENTIDADE'
    end
    object cdsDadosDATA_NASCIMENTO: TDateTimeField
      FieldName = 'DATA_NASCIMENTO'
    end
    object cdsDadosCONJUGE: TStringField
      FieldName = 'CONJUGE'
      Size = 100
    end
    object cdsDadosTELEFONE_RESIDENCIAL: TStringField
      FieldName = 'TELEFONE_RESIDENCIAL'
      Size = 13
    end
    object cdsDadosTELEFONE_COMERCIAL: TStringField
      FieldName = 'TELEFONE_COMERCIAL'
      Size = 13
    end
    object cdsDadosTELEFONE_CELULAR: TStringField
      FieldName = 'TELEFONE_CELULAR'
      Size = 13
    end
    object cdsDadosCOD_FK_MEIO_CAPTACAO: TIntegerField
      FieldName = 'COD_FK_MEIO_CAPTACAO'
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
    object cdsDadosHORARIO_LIGACAO: TStringField
      FieldName = 'HORARIO_LIGACAO'
      Size = 8
    end
    object cdsDadosHORA_INICIO: TTimeField
      FieldName = 'HORA_INICIO'
    end
    object cdsDadosHORA_FINAL: TTimeField
      FieldName = 'HORA_FINAL'
    end
  end
end
