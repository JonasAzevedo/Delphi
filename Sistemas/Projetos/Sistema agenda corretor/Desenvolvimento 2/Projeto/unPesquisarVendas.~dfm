inherited frmPesquisarVendas: TfrmPesquisarVendas
  Left = 228
  Top = 130
  Caption = 'PESQUISAR POR VENDAS'
  ClientHeight = 528
  ClientWidth = 1003
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited grpBxFiltroPesquisar: TGroupBox
    Width = 1003
    Height = 233
    object lblCodigo: TLabel
      Left = 5
      Top = 44
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object lblImovel: TLabel
      Left = 7
      Top = 107
      Width = 37
      Height = 13
      Caption = 'Im'#243'vel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic, fsUnderline]
      ParentFont = False
    end
    object lblFiltrosUsados: TLabel
      Left = 84
      Top = 214
      Width = 3
      Height = 13
    end
    object lblNomeFiltrosUsados: TLabel
      Left = 6
      Top = 214
      Width = 69
      Height = 13
      Caption = 'Filtros Usados:'
    end
    object plsEdCodigo: TPlsEdit
      Left = 45
      Top = 38
      Width = 66
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object pnlTipoVenda: TPanel
      Left = 3
      Top = 71
      Width = 491
      Height = 29
      BevelOuter = bvNone
      TabOrder = 5
      object lblTipoVenda: TLabel
        Left = 2
        Top = 9
        Width = 76
        Height = 13
        Caption = 'Tipo de Venda: '
      end
      object lblImovelDe: TLabel
        Left = 262
        Top = 8
        Width = 51
        Height = 13
        Caption = 'Im'#243'vel De:'
      end
      object plsCbBxTipoVenda: TPlsComboBox
        Left = 87
        Top = 3
        Width = 164
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = plsCbBxTipoVendaChange
        Items.Strings = (
          'MEU AGENCIAMENTO'
          'PAUTA')
        plsCorRecebeFoco = clSilver
      end
      object plsCbBxImovelDe: TPlsComboBox
        Left = 316
        Top = 4
        Width = 173
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = plsCbBxImovelDeChange
        plsCorRecebeFoco = clSilver
      end
    end
    object grpBxDataVenda: TGroupBox
      Left = 117
      Top = 13
      Width = 187
      Height = 49
      Caption = 'Data da Venda '
      TabOrder = 1
      object lblEntreDataVenda: TLabel
        Left = 80
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedDataVendaInicio: TPlsMaskEdit
        Left = 5
        Top = 20
        Width = 72
        Height = 21
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
        plsCorRecebeFoco = clSilver
      end
      object plsMedDataVendaFinal: TPlsMaskEdit
        Left = 108
        Top = 20
        Width = 73
        Height = 21
        EditMask = '99/99/9999'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        plsCorRecebeFoco = clSilver
      end
    end
    object grpBxValorVenda: TGroupBox
      Left = 306
      Top = 13
      Width = 188
      Height = 49
      Caption = 'Valor da Venda '
      TabOrder = 2
      object lblEntreValorVenda: TLabel
        Left = 81
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedValorVendaInicio: TPlsEdit
        Left = 5
        Top = 20
        Width = 72
        Height = 21
        TabOrder = 0
        Text = 'plsMedValorVenda'
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario
      end
      object plsMedValorVendaFim: TPlsEdit
        Left = 109
        Top = 20
        Width = 73
        Height = 21
        TabOrder = 1
        Text = 'plsMedValorVendaFim'
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario
      end
    end
    object rdGrpTipoPessoa: TRadioGroup
      Left = 499
      Top = 20
      Width = 146
      Height = 40
      Caption = 'Tipo Pessoa '
      Columns = 2
      Items.Strings = (
        'F'#237'sica'
        'Jur'#237'dica')
      TabOrder = 3
    end
    object grpBxNomePessoa: TGroupBox
      Left = 652
      Top = 20
      Width = 342
      Height = 40
      Caption = 'Nome da Pessoa '
      TabOrder = 4
      object plsEdNomePessoa: TPlsEdit
        Left = 7
        Top = 14
        Width = 330
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
        Text = 'PLSEDNOMEPESSOA'
        plsCorRecebeFoco = clSilver
      end
    end
    object pnlConstrutora: TPanel
      Left = 496
      Top = 72
      Width = 369
      Height = 27
      BevelOuter = bvNone
      TabOrder = 6
      Visible = False
      object lblConstrutora: TLabel
        Left = 3
        Top = 10
        Width = 57
        Height = 13
        Caption = 'Construtora:'
      end
      object spBtnBuscaConstrutora: TSpeedButton
        Left = 344
        Top = 2
        Width = 22
        Height = 21
        Cursor = crHandPoint
        Hint = 'Selecionar Construtora'
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
        OnClick = spBtnBuscaConstrutoraClick
      end
      object plsEdConstrutora: TPlsEdit
        Left = 63
        Top = 2
        Width = 281
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 60
        TabOrder = 0
        OnExit = plsEdConstrutoraExit
        plsCorRecebeFoco = clSilver
      end
    end
    object pnlTipoImovel: TPanel
      Left = 4
      Top = 123
      Width = 329
      Height = 27
      BevelOuter = bvNone
      TabOrder = 7
      object lblTipoImovel: TLabel
        Left = 1
        Top = 10
        Width = 73
        Height = 13
        Caption = 'Tipo de Im'#243'vel:'
      end
      object spBtnBuscaTipoImovel: TSpeedButton
        Left = 304
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
      object plsEdTipoImovel: TPlsEdit
        Left = 80
        Top = 2
        Width = 224
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 60
        TabOrder = 0
        OnExit = plsEdTipoImovelExit
        plsCorRecebeFoco = clSilver
      end
    end
    object grpBxEndereco: TGroupBox
      Left = 5
      Top = 153
      Width = 987
      Height = 54
      Caption = 'Endere'#231'o '
      TabOrder = 8
      object pnlEstado: TPanel
        Left = 9
        Top = 20
        Width = 240
        Height = 27
        BevelOuter = bvNone
        TabOrder = 0
        object spBtnBuscaEstado: TSpeedButton
          Left = 216
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
          Width = 170
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 50
          TabOrder = 0
          OnExit = plsEdEstadoExit
          plsCorRecebeFoco = clSilver
        end
      end
      object pnlCidade: TPanel
        Left = 252
        Top = 20
        Width = 240
        Height = 27
        BevelOuter = bvNone
        TabOrder = 1
        object spBtnBuscaCidade: TSpeedButton
          Left = 216
          Top = 3
          Width = 22
          Height = 22
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
          Width = 170
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 100
          TabOrder = 0
          OnExit = plsEdCidadeExit
          plsCorRecebeFoco = clSilver
        end
      end
      object pnlRua: TPanel
        Left = 738
        Top = 20
        Width = 240
        Height = 27
        BevelOuter = bvNone
        TabOrder = 3
        object spBtnBuscaRua: TSpeedButton
          Left = 216
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
          Width = 170
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 100
          TabOrder = 0
          OnExit = plsEdRuaExit
          plsCorRecebeFoco = clSilver
        end
      end
      object pnlBairro: TPanel
        Left = 496
        Top = 20
        Width = 240
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
          Left = 216
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
          Width = 170
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 100
          TabOrder = 0
          OnExit = plsEdBairroExit
          plsCorRecebeFoco = clSilver
        end
      end
    end
  end
  inherited dbGrdDadosPesquisa: TDBGrid
    Top = 233
    Width = 1003
    Height = 260
    OnDblClick = dbGrdDadosPesquisaDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA_VENDA'
        Title.Caption = 'Data da Venda'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_CANCELAMENTO'
        Title.Caption = 'Data Cancelamento'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATIVO'
        Title.Caption = 'Ativo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_VENDA'
        Title.Caption = 'Tipo da Venda'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IMOVEL_DE'
        Title.Caption = 'Im'#243'vel De'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CLIENTE'
        Title.Caption = 'Cliente'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_VENDA'
        Title.Caption = 'Valor da Venda'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_DEDUCOES'
        Title.Caption = 'Dedu'#231#245'es'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_BEM_NEGOCIAVEL'
        Title.Caption = 'Valor Bem Negoci'#225'vel'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEDUZIR_BEM_NEGOC_VALOR_VENDA'
        Title.Caption = 'Deduzir Bem Neg.'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_PARA_CALCULO_COMISSAO'
        Title.Caption = 'Valor C'#225'lculo Comiss'#227'o'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PERCENTUAL_SOBRE_VENDA'
        Title.Caption = '% Sobre Venda'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_TOTAL_COMISSAO'
        Title.Caption = 'Valor Total Comiss'#227'o'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PERCENTUAL_SOBRE_COMISSAO'
        Title.Caption = '% Sobre Comiss'#227'o'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBSERVACAO'
        Title.Caption = 'Observa'#231#227'o'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO_IMOVEL'
        Title.Caption = 'Descri'#231#227'o Im'#243'vel'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_TIPO_IMOVEL'
        Title.Caption = 'Tipo Im'#243'vel'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGLA_ESTADO'
        Title.Caption = 'UF'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CIDADE'
        Title.Caption = 'Cidade'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_BAIRRO'
        Title.Caption = 'Bairro'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_RUA'
        Title.Caption = 'Rua'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP_RUA'
        Title.Caption = 'CEP'
        Width = 60
        Visible = True
      end>
  end
  inherited pnlBotoes: TPanel
    Top = 493
    Width = 1003
    object lblTotalRegistros: TLabel [0]
      Left = 920
      Top = 10
      Width = 78
      Height = 13
      Alignment = taRightJustify
      Caption = 'lblTotalRegistros'
    end
  end
  inherited zQryDados: TZQuery
    Active = True
    SQL.Strings = (
      'SELECT'
      '    v.codigo,v.data_venda,v.ativo,'
      '    v.tipo_pessoa,'
      '    CASE WHEN v.tipo_pessoa = '#39'F'#205'SICA'#39' THEN pf.nome'
      '         WHEN v.tipo_pessoa = '#39'JUR'#205'DICA'#39' THEN pj.nome'
      '    ELSE '#39#39
      '    END AS NOME_TIPO_PESSOA,'
      '    v.tipo_venda,'
      '    CASE WHEN v.venda_meu_agenciamento_meu = '#39'SIM'#39' THEN '#39'MEU'#39
      
        '         WHEN v.venda_meu_agenciamento_colegas = '#39'SIM'#39' THEN '#39'COL' +
        'EGAS'#39
      
        '         WHEN v.venda_pauta_construtora = '#39'SIM'#39' THEN '#39'CONSTRUTOR' +
        'A'#39
      '         WHEN v.venda_pauta_terceiros = '#39'SIM'#39' THEN '#39'TERCEIROS'#39
      '         ELSE '#39#39
      '    END AS IMOVEL_DE,'
      '    CAST(v.valor_venda AS VARCHAR(20)) AS CC_VALOR_VENDA,'
      '    CAST(v.deducoes AS VARCHAR(20)) AS CC_DEDUCOES,'
      
        '    CAST(v.valor_bem_negociavel AS VARCHAR(20)) AS CC_VALOR_BEM_' +
        'NEGOCIAVEL,'
      '    v.deduzir_bem_negoc_valor_venda,v.tipo_calculo_comissao,'
      
        '    CAST(v.valor_para_calculo_comissao AS VARCHAR(20)) AS CC_VAL' +
        'OR_PARA_CALCULO_COMISSAO,'
      
        '    CAST(v.percentual_sobre_venda AS VARCHAR(20)) AS CC_PERCENTU' +
        'AL_SOBRE_VENDA,'
      
        '    CAST(v.valor_total_comissao AS VARCHAR(20)) AS CC_VALOR_TOTA' +
        'L_COMISSAO,'
      
        '    CAST(v.percentual_sobre_comissao AS VARCHAR(20)) AS CC_PERCE' +
        'NTUAL_SOBRE_COMISSAO,'
      '    v.observacao,v.data_cancelamento,'
      '    const.nome AS NOME_CONSTRUTORA,'
      '    i.codigo AS CODIGO_IMOVEL,i.status AS STATUS_IMOVEL,'
      '    ti.codigo AS CODIGO_TIPO_IMOVEL,ti.nome AS NOME_TIPO_IMOVEL,'
      '    est.codigo AS CODIGO_ESTADO,est.sigla AS SIGLA_ESTADO,'
      '    cid.codigo AS CODIGO_CIDADE,cid.nome AS NOME_CIDADE,'
      '    bai.codigo AS CODIGO_BAIRRO,bai.nome AS NOME_BAIRRO,'
      
        '    rua.codigo AS CODIGO_RUA,rua.nome AS NOME_RUA,rua.cep AS CEP' +
        '_RUA,'
      '    i.situacao_desejavel,'
      
        '    CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL_IMOVE' +
        'L,'
      '    i.descricao AS DESCRICAO_IMOVEL'
      'FROM vendas v'
      
        'LEFT JOIN cliente_pessoa_fisica pf ON v.cod_fk_cliente_pessoa_fi' +
        'sica = pf.codigo'
      
        'LEFT JOIN cliente_pessoa_juridica pj ON v.cod_fk_cliente_pessoa_' +
        'juridica = pj.codigo'
      
        'LEFT JOIN construtora const ON v.cod_fk_tp_vnd_construtora = con' +
        'st.codigo'
      'JOIN imovel i ON v.cod_fk_imovel = i.codigo'
      'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo'
      'JOIN estado est ON i.cod_fk_estado = est.codigo'
      'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo'
      'JOIN bairro bai ON i.cod_fk_bairro = bai.codigo'
      'JOIN rua rua ON i.cod_fk_rua = rua.codigo'
      'WHERE v.codigo <> -99999'
      'AND 1=2'
      'ORDER BY v.codigo')
    Left = 164
    Top = 201
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosDATA_VENDA: TDateField
      FieldName = 'DATA_VENDA'
    end
    object zQryDadosATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      Size = 3
    end
    object zQryDadosTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryDadosNOME_TIPO_PESSOA: TStringField
      FieldName = 'NOME_TIPO_PESSOA'
      Size = 100
    end
    object zQryDadosTIPO_VENDA: TStringField
      FieldName = 'TIPO_VENDA'
      Required = True
      Size = 16
    end
    object zQryDadosIMOVEL_DE: TStringField
      FieldName = 'IMOVEL_DE'
      Size = 11
    end
    object zQryDadosCC_VALOR_VENDA: TStringField
      FieldName = 'CC_VALOR_VENDA'
    end
    object zQryDadosCC_DEDUCOES: TStringField
      FieldName = 'CC_DEDUCOES'
    end
    object zQryDadosCC_VALOR_BEM_NEGOCIAVEL: TStringField
      FieldName = 'CC_VALOR_BEM_NEGOCIAVEL'
    end
    object zQryDadosDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField
      FieldName = 'DEDUZIR_BEM_NEGOC_VALOR_VENDA'
      Size = 3
    end
    object zQryDadosTIPO_CALCULO_COMISSAO: TStringField
      FieldName = 'TIPO_CALCULO_COMISSAO'
      Size = 8
    end
    object zQryDadosCC_VALOR_PARA_CALCULO_COMISSAO: TStringField
      FieldName = 'CC_VALOR_PARA_CALCULO_COMISSAO'
    end
    object zQryDadosCC_PERCENTUAL_SOBRE_VENDA: TStringField
      FieldName = 'CC_PERCENTUAL_SOBRE_VENDA'
    end
    object zQryDadosCC_VALOR_TOTAL_COMISSAO: TStringField
      FieldName = 'CC_VALOR_TOTAL_COMISSAO'
    end
    object zQryDadosCC_PERCENTUAL_SOBRE_COMISSAO: TStringField
      FieldName = 'CC_PERCENTUAL_SOBRE_COMISSAO'
    end
    object zQryDadosOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object zQryDadosDATA_CANCELAMENTO: TDateTimeField
      FieldName = 'DATA_CANCELAMENTO'
    end
    object zQryDadosNOME_CONSTRUTORA: TStringField
      FieldName = 'NOME_CONSTRUTORA'
      Size = 100
    end
    object zQryDadosCODIGO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_IMOVEL'
      Required = True
    end
    object zQryDadosSTATUS_IMOVEL: TSmallintField
      FieldName = 'STATUS_IMOVEL'
    end
    object zQryDadosCODIGO_TIPO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_TIPO_IMOVEL'
      Required = True
    end
    object zQryDadosNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object zQryDadosCODIGO_ESTADO: TIntegerField
      FieldName = 'CODIGO_ESTADO'
      Required = True
    end
    object zQryDadosSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object zQryDadosCODIGO_CIDADE: TIntegerField
      FieldName = 'CODIGO_CIDADE'
      Required = True
    end
    object zQryDadosNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object zQryDadosCODIGO_BAIRRO: TIntegerField
      FieldName = 'CODIGO_BAIRRO'
      Required = True
    end
    object zQryDadosNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
      Required = True
      Size = 100
    end
    object zQryDadosCODIGO_RUA: TIntegerField
      FieldName = 'CODIGO_RUA'
      Required = True
    end
    object zQryDadosNOME_RUA: TStringField
      FieldName = 'NOME_RUA'
      Required = True
      Size = 100
    end
    object zQryDadosCEP_RUA: TStringField
      FieldName = 'CEP_RUA'
      Size = 9
    end
    object zQryDadosSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zQryDadosCC_VALOR_IMOVEL_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL_IMOVEL'
    end
    object zQryDadosDESCRICAO_IMOVEL: TStringField
      FieldName = 'DESCRICAO_IMOVEL'
      Size = 500
    end
  end
  inherited dspDados: TDataSetProvider
    Left = 193
    Top = 201
  end
  inherited cdsDados: TClientDataSet
    Left = 223
    Top = 201
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosDATA_VENDA: TDateField
      FieldName = 'DATA_VENDA'
    end
    object cdsDadosATIVO: TStringField
      FieldName = 'ATIVO'
      Required = True
      Size = 3
    end
    object cdsDadosTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object cdsDadosNOME_TIPO_PESSOA: TStringField
      FieldName = 'NOME_TIPO_PESSOA'
      Size = 100
    end
    object cdsDadosTIPO_VENDA: TStringField
      FieldName = 'TIPO_VENDA'
      Required = True
      Size = 16
    end
    object cdsDadosIMOVEL_DE: TStringField
      FieldName = 'IMOVEL_DE'
      Size = 11
    end
    object cdsDadosCC_VALOR_VENDA: TStringField
      FieldName = 'CC_VALOR_VENDA'
    end
    object cdsDadosCC_DEDUCOES: TStringField
      FieldName = 'CC_DEDUCOES'
    end
    object cdsDadosCC_VALOR_BEM_NEGOCIAVEL: TStringField
      FieldName = 'CC_VALOR_BEM_NEGOCIAVEL'
    end
    object cdsDadosDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField
      FieldName = 'DEDUZIR_BEM_NEGOC_VALOR_VENDA'
      Size = 3
    end
    object cdsDadosTIPO_CALCULO_COMISSAO: TStringField
      FieldName = 'TIPO_CALCULO_COMISSAO'
      Size = 8
    end
    object cdsDadosCC_VALOR_PARA_CALCULO_COMISSAO: TStringField
      FieldName = 'CC_VALOR_PARA_CALCULO_COMISSAO'
    end
    object cdsDadosCC_PERCENTUAL_SOBRE_VENDA: TStringField
      FieldName = 'CC_PERCENTUAL_SOBRE_VENDA'
    end
    object cdsDadosCC_VALOR_TOTAL_COMISSAO: TStringField
      FieldName = 'CC_VALOR_TOTAL_COMISSAO'
    end
    object cdsDadosCC_PERCENTUAL_SOBRE_COMISSAO: TStringField
      FieldName = 'CC_PERCENTUAL_SOBRE_COMISSAO'
    end
    object cdsDadosOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 500
    end
    object cdsDadosDATA_CANCELAMENTO: TDateTimeField
      FieldName = 'DATA_CANCELAMENTO'
    end
    object cdsDadosNOME_CONSTRUTORA: TStringField
      FieldName = 'NOME_CONSTRUTORA'
      Size = 100
    end
    object cdsDadosCODIGO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_IMOVEL'
      Required = True
    end
    object cdsDadosSTATUS_IMOVEL: TSmallintField
      FieldName = 'STATUS_IMOVEL'
    end
    object cdsDadosCODIGO_TIPO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_TIPO_IMOVEL'
      Required = True
    end
    object cdsDadosNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object cdsDadosCODIGO_ESTADO: TIntegerField
      FieldName = 'CODIGO_ESTADO'
      Required = True
    end
    object cdsDadosSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object cdsDadosCODIGO_CIDADE: TIntegerField
      FieldName = 'CODIGO_CIDADE'
      Required = True
    end
    object cdsDadosNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object cdsDadosCODIGO_BAIRRO: TIntegerField
      FieldName = 'CODIGO_BAIRRO'
      Required = True
    end
    object cdsDadosNOME_BAIRRO: TStringField
      FieldName = 'NOME_BAIRRO'
      Required = True
      Size = 100
    end
    object cdsDadosCODIGO_RUA: TIntegerField
      FieldName = 'CODIGO_RUA'
      Required = True
    end
    object cdsDadosNOME_RUA: TStringField
      FieldName = 'NOME_RUA'
      Required = True
      Size = 100
    end
    object cdsDadosCEP_RUA: TStringField
      FieldName = 'CEP_RUA'
      Size = 9
    end
    object cdsDadosSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object cdsDadosCC_VALOR_IMOVEL_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL_IMOVEL'
    end
    object cdsDadosDESCRICAO_IMOVEL: TStringField
      FieldName = 'DESCRICAO_IMOVEL'
      Size = 500
    end
  end
  inherited dsDados: TDataSource
    Left = 251
    Top = 201
  end
  inherited ppMnPopupMenu: TPopupMenu
    Left = 14
    Top = 273
    object mnItDetalhar: TMenuItem [0]
      Caption = 'Detalhar...'
      OnClick = mnItDetalharClick
    end
  end
end
