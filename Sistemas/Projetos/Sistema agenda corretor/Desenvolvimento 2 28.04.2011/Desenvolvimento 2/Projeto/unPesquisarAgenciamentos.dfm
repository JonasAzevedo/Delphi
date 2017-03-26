inherited frmPesquisarAgenciamentos: TfrmPesquisarAgenciamentos
  Left = 268
  Top = 27
  Caption = 'PESQUISAR POR AGENCIAMENTOS'
  ClientHeight = 609
  ClientWidth = 1004
  OldCreateOrder = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited grpBxFiltroPesquisar: TGroupBox
    Width = 1004
    Height = 257
    object lblCodigo: TLabel
      Left = 10
      Top = 44
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object lblCondicaoPagamento: TLabel
      Left = 9
      Top = 74
      Width = 120
      Height = 13
      Caption = 'Condi'#231#227'o de Pagamento:'
    end
    object lblStatus: TLabel
      Left = 125
      Top = 21
      Width = 33
      Height = 13
      Caption = 'Status:'
    end
    object lblAgenciamento: TLabel
      Left = 10
      Top = 20
      Width = 74
      Height = 13
      Caption = 'Agenciamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic, fsUnderline]
      ParentFont = False
    end
    object lblImovel: TLabel
      Left = 10
      Top = 116
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
    object lblSituacao: TLabel
      Left = 296
      Top = 122
      Width = 45
      Height = 13
      Caption = 'Situa'#231#227'o:'
    end
    object lblDescricao: TLabel
      Left = 557
      Top = 147
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
    end
    object lblNomeFiltrosUsados: TLabel
      Left = 6
      Top = 234
      Width = 69
      Height = 13
      Caption = 'Filtros Usados:'
    end
    object lblFiltrosUsados: TLabel
      Left = 84
      Top = 234
      Width = 3
      Height = 13
    end
    object rdGrpTipoAgenciamento: TRadioGroup
      Left = 235
      Top = 20
      Width = 156
      Height = 40
      Caption = 'Tipo Agenciamento '
      Columns = 2
      Items.Strings = (
        'Normal'
        'Stand By')
      TabOrder = 2
    end
    object rdGrpTipoPessoa: TRadioGroup
      Left = 399
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
    object plsCbBxCondicaoPagamento: TPlsComboBox
      Left = 9
      Top = 91
      Width = 193
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      Items.Strings = (
        'VISTA'
        'ACEITA FINANCIAMENTO')
      plsCorRecebeFoco = clSilver
    end
    object plsEdCodigo: TPlsEdit
      Left = 51
      Top = 39
      Width = 66
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object grpBxDataAgenciamento: TGroupBox
      Left = 403
      Top = 66
      Width = 193
      Height = 49
      Caption = 'Data do Agenciamento '
      TabOrder = 7
      object lblEntreDataAgenciamento: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedDataAgencInicio: TPlsMaskEdit
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
      object plsMedDataAgencFinal: TPlsMaskEdit
        Left = 113
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
    object grpBxDataBaixa: TGroupBox
      Left = 799
      Top = 66
      Width = 193
      Height = 49
      Caption = 'Data da Baixa '
      TabOrder = 9
      object lblEntreDataBaixa: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedDataBaixaInicio: TPlsMaskEdit
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
      object plsMedDataBaixaFim: TPlsMaskEdit
        Left = 113
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
    object grpBxPrazoAutorizacao: TGroupBox
      Left = 602
      Top = 66
      Width = 193
      Height = 49
      Caption = 'Prazo Autoriza'#231#227'o'
      TabOrder = 8
      object lblEntrePrazoAutorizacao: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedPrazoAutorizacaoInicio: TPlsMaskEdit
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
      object plsMedPrazoAutorizacaoFim: TPlsMaskEdit
        Left = 113
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
    object grpBxValorTotal: TGroupBox
      Left = 205
      Top = 66
      Width = 193
      Height = 49
      Caption = 'Valor Total '
      TabOrder = 6
      object lblEntreValorTotal: TLabel
        Left = 84
        Top = 22
        Width = 24
        Height = 13
        Caption = 'entre'
      end
      object plsMedValorTotalInicio: TPlsEdit
        Left = 5
        Top = 20
        Width = 72
        Height = 21
        TabOrder = 0
        Text = 'plsEdValorTotal'
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario2
      end
      object plsMedValorTotalFim: TPlsEdit
        Left = 113
        Top = 20
        Width = 73
        Height = 21
        TabOrder = 1
        Text = 'plsEdValorTotal'
        plsCorRecebeFoco = clSilver
        plsEntraCaracteres = direitaEsquerda
        plsCaracteresAceitos = monetario2
      end
    end
    object plsCbBxStatus: TPlsComboBox
      Left = 125
      Top = 39
      Width = 101
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = 'ATIVO'
      Items.Strings = (
        'ATIVO'
        'INATIVO'
        'TODOS')
      plsCorRecebeFoco = clSilver
    end
    object grpBxNomePessoa: TGroupBox
      Left = 552
      Top = 20
      Width = 441
      Height = 40
      Caption = 'Nome Pessoa '
      TabOrder = 4
      object plsEdNomePessoa: TPlsEdit
        Left = 7
        Top = 14
        Width = 429
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
        Text = 'PLSEDNOMEPESSOA'
        plsCorRecebeFoco = clSilver
      end
    end
    object pnlTipoImovel: TPanel
      Left = 4
      Top = 138
      Width = 283
      Height = 27
      BevelOuter = bvNone
      TabOrder = 10
      object lblTipoImovel: TLabel
        Left = 1
        Top = 10
        Width = 73
        Height = 13
        Caption = 'Tipo de Im'#243'vel:'
      end
      object spBtnBuscaTipoImovel: TSpeedButton
        Left = 257
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
        Width = 177
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 60
        TabOrder = 0
        OnExit = plsEdTipoImovelExit
        plsCorRecebeFoco = clSilver
      end
    end
    object grpBxEndereco: TGroupBox
      Left = 4
      Top = 171
      Width = 987
      Height = 54
      Caption = 'Endere'#231'o '
      TabOrder = 13
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
    object plsCbBxSituacao: TPlsComboBox
      Left = 296
      Top = 139
      Width = 249
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 11
      Items.Strings = (
        'PLANTA'
        'PRONTO PARA MORAR'
        'DE TERCEIROS')
      plsCorRecebeFoco = clSilver
    end
    object plsMmDescricao: TPlsMemo
      Left = 616
      Top = 127
      Width = 376
      Height = 33
      Lines.Strings = (
        'plsMmDescricao')
      MaxLength = 500
      TabOrder = 12
      plsCorRecebeFoco = clSilver
    end
  end
  inherited dbGrdDadosPesquisa: TDBGrid
    Top = 257
    Width = 1004
    Height = 317
    OnDblClick = dbGrdDadosPesquisaDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO_AGENCIAMENTO'
        Title.Caption = 'C'#243'digo'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_AGENCIAMENTO'
        Title.Caption = 'Data Agenciamento'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRAZO_AUTORIZACAO'
        Title.Caption = 'Prazo Autoriza'#231#227'o'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_REAGENCIAMENTO'
        Title.Caption = 'Data Reagenciamento'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_BAIXA'
        Title.Caption = 'Data Baixa'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATIVO_AGENCIAMENTO'
        Title.Caption = 'Ativo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NORMAL_STANDBY'
        Title.Caption = 'Normal/Stand By'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_PESSOA'
        Title.Caption = 'Tipo Pessoa'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_TIPO_PESSOA'
        Title.Caption = 'Nome Pessoa'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONDICAO_PAGAMENTO'
        Title.Caption = 'Condi'#231#227'o Pagamento'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_TOTAL_AGENCIAMENTO'
        Title.Caption = 'Valor Total'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_VISTA_CACH'
        Title.Caption = 'Vista Cach'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_VISTA_VALOR_BEM'
        Title.Caption = 'Vista Valor Bem'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_VISTA_DESCRICAO_BEM'
        Title.Caption = 'Descri'#231#227'o Bem'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_FINCTO_CACH_FINANCIADO'
        Title.Caption = 'Fncto Cach Financiado'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_FINCTO_CACH'
        Title.Caption = 'Fncto Cach'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_FINCTO_VALOR_BEM'
        Title.Caption = 'Fncto Valor Bem'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_PGTO_FINCTO_DESCRICAO_BEM'
        Title.Caption = 'Fncto Descri'#231#227'o Bem'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SITUACAO_DESEJAVEL'
        Title.Caption = 'Situa'#231#227'o Desej'#225'vel'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CC_VALOR_IMOVEL_IMOVEL'
        Title.Caption = 'Valor do Im'#243'vel'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_TIPO_IMOVEL'
        Title.Caption = 'Tipo do Im'#243'vel'
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
    Top = 574
    Width = 1004
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
    SQL.Strings = (
      'SELECT'
      
        '  a.codigo AS CODIGO_AGENCIAMENTO,a.data_agenciamento,a.ativo AS' +
        ' ATIVO_AGENCIAMENTO,'
      '  CAST(a.codigo AS VARCHAR(10)) AS cc_codigo,'
      '  a.normal,a.stand_by,'
      '  CASE'
      '    WHEN a.normal = '#39'SIM'#39' THEN'
      '      '#39'NORMAL'#39
      '    ELSE'
      '      '#39'STAND BY'#39
      '  END AS NORMAL_STANDBY,'
      '  a.tipo_pessoa,'
      '  CASE'
      '    WHEN a.tipo_pessoa = '#39'F'#205'SICA'#39' THEN'
      '       pf.nome'
      '    WHEN a.tipo_pessoa = '#39'JUR'#205'DICA'#39' THEN'
      '       pj.nome'
      '    ELSE'
      '      '#39'NENHUMA'#39
      '  END AS NOME_TIPO_PESSOA,'
      '  a.condicao_pagamento,'
      
        'CAST(a.valor_total  AS VARCHAR(20)) AS CC_VALOR_TOTAL_AGENCIAMEN' +
        'TO,'
      'CAST(a.pgto_vista_cach AS VARCHAR(20)) AS CC_PGTO_VISTA_CACH, '
      
        'CAST(a.pgto_vista_valor_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_VAL' +
        'OR_BEM,'
      
        'CAST(a.pgto_vista_descricao_bem AS VARCHAR(500)) AS CC_PGTO_VIST' +
        'A_DESCRICAO_BEM,'
      
        'CAST(a.pgto_fincto_cach_financiado AS VARCHAR(20)) AS CC_PGTO_FI' +
        'NCTO_CACH_FINANCIADO,'
      'CAST(a.pgto_fincto_cach AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH,'
      
        'CAST(a.pgto_fincto_valor_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_V' +
        'ALOR_BEM,'
      
        'CAST(a.pgto_fincto_descricao_bem AS VARCHAR(500)) AS CC_PGTO_FIN' +
        'CTO_DESCRICAO_BEM,'
      
        '  a.observacao AS OBSERVACAO_AGENCIAMENTO,a.prazo_autorizacao,a.' +
        'data_reagenciamento,a.data_baixa,'
      
        '  pf.codigo AS CODIGO_PESSOA_FISICA,pf.nome AS NOME_PESSOA_FISIC' +
        'A,'
      
        '  pj.codigo AS CODIGO_PESSOA_JURIDICA,pj.nome AS NOME_PESSOA_JUR' +
        'IDICA,'
      
        '  i.codigo AS CODIGO_IMOVEL,i.status AS STATUS_IMOVEL,i.situacao' +
        '_desejavel,'
      'CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL_IMOVEL,'
      'i.descricao AS DESCRICAO_IMOVEL,'
      '  ti.codigo AS CODIGO_TIPO_IMOVEL,ti.nome AS NOME_TIPO_IMOVEL,'
      '  est.codigo AS CODIGO_ESTADO,est.sigla AS SIGLA_ESTADO,'
      '  cid.codigo AS CODIGO_CIDADE,cid.nome AS NOME_CIDADE,'
      '  bai.codigo AS CODIGO_BAIRRO,bai.nome AS NOME_BAIRRO,'
      
        '  rua.codigo AS CODIGO_RUA,rua.nome AS NOME_RUA,rua.cep AS CEP_R' +
        'UA'
      'FROM agenciamentos a'
      
        'LEFT JOIN agenc_pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.' +
        'codigo'
      
        'LEFT JOIN agenc_pessoa_juridica pj ON a.cod_fk_pessoa_juridica =' +
        ' pj.codigo'
      'JOIN imovel i ON a.cod_fk_imovel = i.codigo'
      'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo'
      'JOIN estado est ON i.cod_fk_estado = est.codigo'
      'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo'
      'JOIN bairro bai ON i.cod_fk_bairro = bai.codigo'
      'JOIN rua rua ON i.cod_fk_rua = rua.codigo'
      'WHERE 1=2'
      'ORDER BY a.codigo')
    Left = 156
    Top = 224
    object zQryDadosCODIGO_AGENCIAMENTO: TIntegerField
      FieldName = 'CODIGO_AGENCIAMENTO'
      Required = True
    end
    object zQryDadosDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
    end
    object zQryDadosATIVO_AGENCIAMENTO: TStringField
      FieldName = 'ATIVO_AGENCIAMENTO'
      Size = 3
    end
    object zQryDadosCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object zQryDadosNORMAL: TStringField
      FieldName = 'NORMAL'
      Size = 5
    end
    object zQryDadosSTAND_BY: TStringField
      FieldName = 'STAND_BY'
      Size = 5
    end
    object zQryDadosNORMAL_STANDBY: TStringField
      FieldName = 'NORMAL_STANDBY'
      ReadOnly = True
      Size = 8
    end
    object zQryDadosTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object zQryDadosNOME_TIPO_PESSOA: TStringField
      FieldName = 'NOME_TIPO_PESSOA'
      ReadOnly = True
      Size = 100
    end
    object zQryDadosCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object zQryDadosCC_VALOR_TOTAL_AGENCIAMENTO: TStringField
      FieldName = 'CC_VALOR_TOTAL_AGENCIAMENTO'
    end
    object zQryDadosCC_PGTO_VISTA_CACH: TStringField
      FieldName = 'CC_PGTO_VISTA_CACH'
    end
    object zQryDadosCC_PGTO_VISTA_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_VALOR_BEM'
    end
    object zQryDadosCC_PGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_DESCRICAO_BEM'
      Size = 500
    end
    object zQryDadosCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH_FINANCIADO'
    end
    object zQryDadosCC_PGTO_FINCTO_CACH: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH'
    end
    object zQryDadosCC_PGTO_FINCTO_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_VALOR_BEM'
    end
    object zQryDadosCC_PGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_DESCRICAO_BEM'
      Size = 500
    end
    object zQryDadosOBSERVACAO_AGENCIAMENTO: TStringField
      FieldName = 'OBSERVACAO_AGENCIAMENTO'
      Size = 500
    end
    object zQryDadosPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object zQryDadosDATA_REAGENCIAMENTO: TDateField
      FieldName = 'DATA_REAGENCIAMENTO'
    end
    object zQryDadosDATA_BAIXA: TDateField
      FieldName = 'DATA_BAIXA'
    end
    object zQryDadosCODIGO_PESSOA_FISICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_FISICA'
      Required = True
    end
    object zQryDadosNOME_PESSOA_FISICA: TStringField
      FieldName = 'NOME_PESSOA_FISICA'
      Size = 100
    end
    object zQryDadosCODIGO_PESSOA_JURIDICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_JURIDICA'
      Required = True
    end
    object zQryDadosNOME_PESSOA_JURIDICA: TStringField
      FieldName = 'NOME_PESSOA_JURIDICA'
      Size = 100
    end
    object zQryDadosCODIGO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_IMOVEL'
      Required = True
    end
    object zQryDadosSTATUS_IMOVEL: TSmallintField
      FieldName = 'STATUS_IMOVEL'
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
  end
  inherited dspDados: TDataSetProvider
    Left = 185
    Top = 224
  end
  inherited cdsDados: TClientDataSet
    Left = 215
    Top = 224
    object cdsDadosCODIGO_AGENCIAMENTO: TIntegerField
      FieldName = 'CODIGO_AGENCIAMENTO'
      Required = True
    end
    object cdsDadosDATA_AGENCIAMENTO: TDateField
      FieldName = 'DATA_AGENCIAMENTO'
      Required = True
    end
    object cdsDadosATIVO_AGENCIAMENTO: TStringField
      FieldName = 'ATIVO_AGENCIAMENTO'
      Size = 3
    end
    object cdsDadosCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object cdsDadosNORMAL: TStringField
      FieldName = 'NORMAL'
      Size = 5
    end
    object cdsDadosSTAND_BY: TStringField
      FieldName = 'STAND_BY'
      Size = 5
    end
    object cdsDadosNORMAL_STANDBY: TStringField
      FieldName = 'NORMAL_STANDBY'
      ReadOnly = True
      Size = 8
    end
    object cdsDadosTIPO_PESSOA: TStringField
      FieldName = 'TIPO_PESSOA'
      Size = 8
    end
    object cdsDadosNOME_TIPO_PESSOA: TStringField
      FieldName = 'NOME_TIPO_PESSOA'
      ReadOnly = True
      Size = 100
    end
    object cdsDadosCONDICAO_PAGAMENTO: TStringField
      FieldName = 'CONDICAO_PAGAMENTO'
    end
    object cdsDadosCC_VALOR_TOTAL_AGENCIAMENTO: TStringField
      FieldName = 'CC_VALOR_TOTAL_AGENCIAMENTO'
    end
    object cdsDadosCC_PGTO_VISTA_CACH: TStringField
      FieldName = 'CC_PGTO_VISTA_CACH'
    end
    object cdsDadosCC_PGTO_VISTA_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_VALOR_BEM'
    end
    object cdsDadosCC_PGTO_VISTA_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_VISTA_DESCRICAO_BEM'
    end
    object cdsDadosCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH_FINANCIADO'
    end
    object cdsDadosCC_PGTO_FINCTO_CACH: TStringField
      FieldName = 'CC_PGTO_FINCTO_CACH'
    end
    object cdsDadosCC_PGTO_FINCTO_VALOR_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_VALOR_BEM'
    end
    object cdsDadosCC_PGTO_FINCTO_DESCRICAO_BEM: TStringField
      FieldName = 'CC_PGTO_FINCTO_DESCRICAO_BEM'
    end
    object cdsDadosOBSERVACAO_AGENCIAMENTO: TStringField
      FieldName = 'OBSERVACAO_AGENCIAMENTO'
      Size = 500
    end
    object cdsDadosPRAZO_AUTORIZACAO: TDateField
      FieldName = 'PRAZO_AUTORIZACAO'
    end
    object cdsDadosDATA_REAGENCIAMENTO: TDateField
      FieldName = 'DATA_REAGENCIAMENTO'
    end
    object cdsDadosDATA_BAIXA: TDateField
      FieldName = 'DATA_BAIXA'
    end
    object cdsDadosCODIGO_PESSOA_FISICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_FISICA'
      Required = True
    end
    object cdsDadosNOME_PESSOA_FISICA: TStringField
      FieldName = 'NOME_PESSOA_FISICA'
      Size = 100
    end
    object cdsDadosCODIGO_PESSOA_JURIDICA: TIntegerField
      FieldName = 'CODIGO_PESSOA_JURIDICA'
      Required = True
    end
    object cdsDadosNOME_PESSOA_JURIDICA: TStringField
      FieldName = 'NOME_PESSOA_JURIDICA'
      Size = 100
    end
    object cdsDadosCODIGO_IMOVEL: TIntegerField
      FieldName = 'CODIGO_IMOVEL'
      Required = True
    end
    object cdsDadosSTATUS_IMOVEL: TSmallintField
      FieldName = 'STATUS_IMOVEL'
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
  end
  inherited dsDados: TDataSource
    Left = 243
    Top = 224
  end
  inherited ppMnPopupMenu: TPopupMenu
    Top = 296
    object ppMnDarBaixa: TMenuItem [0]
      Caption = 'Dar Baixa...'
      OnClick = ppMnDarBaixaClick
    end
    object ppMnDivisao: TMenuItem [1]
      Caption = '-'
    end
    object mnItDetalhar: TMenuItem [2]
      Caption = 'Detalhar...'
      OnClick = mnItDetalharClick
    end
  end
end
