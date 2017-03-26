object frmRetornoLocacao: TfrmRetornoLocacao
  Left = 300
  Top = 10
  Width = 743
  Height = 653
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'NOIVA LINDA --> Retorno Loca'#231#227'o'
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
  object StatusBar: TStatusBar
    Left = 0
    Top = 600
    Width = 735
    Height = 19
    Panels = <
      item
        Width = 550
      end
      item
        Width = 240
      end>
  end
  object grpBxLocacoesPendentes: TGroupBox
    Left = 0
    Top = 105
    Width = 735
    Height = 249
    Align = alTop
    Caption = 'Loca'#231#245'es Pendentes'
    TabOrder = 1
    object dbGrdLocacoes: TDBGrid
      Left = 2
      Top = 15
      Width = 731
      Height = 232
      Hint = 'Loca'#231#245'es Pendentes'
      Align = alClient
      DataSource = dsLocacoes
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = dbGrdLocacoesCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO'
          Title.Caption = 'C'#243'digo'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME'
          Title.Caption = 'Cliente'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_INICIO'
          Title.Caption = 'Data In'#237'cio'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATA_FINAL'
          Title.Caption = 'Data Final'
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_TOTAL'
          Title.Caption = 'Valor Total'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR_PAGO'
          Title.Caption = 'Valor Pago'
          Width = 60
          Visible = True
        end>
    end
  end
  object BitBtn1: TBitBtn
    Left = 601
    Top = 546
    Width = 115
    Height = 41
    Caption = 'DEVOLU'#199#195'O'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 354
    Width = 735
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PRODUTOS DA LOCA'#199#195'O'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object grpBxPesquisar: TGroupBox
    Left = 0
    Top = 0
    Width = 735
    Height = 105
    Align = alTop
    Caption = 'Pesquisar'
    TabOrder = 4
    object Label1: TLabel
      Left = 10
      Top = 20
      Width = 35
      Height = 13
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 10
      Top = 50
      Width = 71
      Height = 13
      Caption = 'Data de In'#237'cio:'
    end
    object Label3: TLabel
      Left = 10
      Top = 80
      Width = 51
      Height = 13
      Caption = 'Data Final:'
    end
    object Label4: TLabel
      Left = 220
      Top = 50
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object Label5: TLabel
      Left = 220
      Top = 80
      Width = 6
      Height = 13
      Caption = 'e'
    end
    object edCliente: TEdit
      Left = 88
      Top = 14
      Width = 250
      Height = 21
      Hint = 'Cliente para Pesquisar por Loca'#231#227'o'
      Enabled = False
      TabOrder = 0
      Text = 'edCliente'
    end
    object mEdDataFinal1: TMaskEdit
      Left = 88
      Top = 74
      Width = 115
      Height = 21
      Hint = 'Data Final da Loca'#231#227'o'
      EditMask = '99/99/9999 00:00;1;_'
      MaxLength = 16
      TabOrder = 4
      Text = '  /  /       :  '
      OnEnter = mEdDataFinal1Enter
      OnExit = mEdDataFinal1Exit
    end
    object mEdDataFinal2: TMaskEdit
      Left = 250
      Top = 74
      Width = 115
      Height = 21
      Hint = 'Data Final da Loca'#231#227'o'
      EditMask = '99/99/9999 00:00;1;_'
      MaxLength = 16
      TabOrder = 5
      Text = '  /  /       :  '
      OnEnter = mEdDataFinal2Enter
      OnExit = mEdDataFinal2Exit
    end
    object mEdDataInicio2: TMaskEdit
      Left = 250
      Top = 44
      Width = 115
      Height = 21
      Hint = 'Data de In'#237'cio da Loca'#231#227'o'
      EditMask = '99/99/9999 00:00;1;_'
      MaxLength = 16
      TabOrder = 3
      Text = '  /  /       :  '
      OnEnter = mEdDataInicio2Enter
      OnExit = mEdDataInicio2Exit
    end
    object mEdDataInicio1: TMaskEdit
      Left = 88
      Top = 44
      Width = 115
      Height = 21
      Hint = 'Data de In'#237'cio da Loca'#231#227'o'
      EditMask = '99/99/9999 00:00;1;_'
      MaxLength = 16
      TabOrder = 2
      Text = '  /  /       :  '
      OnEnter = mEdDataInicio1Enter
      OnExit = mEdDataInicio1Exit
    end
    object btBtnSelecionarCliente: TBitBtn
      Left = 340
      Top = 12
      Width = 25
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = btBtnSelecionarClienteClick
    end
    object btBtnPesquisar: TBitBtn
      Left = 376
      Top = 56
      Width = 75
      Height = 40
      Hint = 'Pesquisar por Loca'#231#227'o'
      Caption = 'Pesquisar'
      TabOrder = 6
      OnClick = btBtnPesquisarClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000894CE005AC6EF004ABDE70039B5E70029ADE70029ADE7000894
        CE000894CE00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000894CE006BD6F70073CEEF004AADCE0042B5E70029ADE70021ADE70021A5
        DE0029ADE700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000894CE008CDEF7006B7373008C6B6B006B52520039B5DE0031B5E70029AD
        E70029ADE700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000894CE008CD6E7006B5A5A007B6B63008C6B6B003994AD0039BDEF0031B5
        E70031B5E700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000894CE00A5EFFF00BDE7EF00BDADAD00BDB5B5005A524A004ABDDE0042C6
        EF0039BDEF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000894CE00A5EFFF00C6EFFF007B6B6B00DED6D6006B5A52004AA5BD004ACE
        F70042C6EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000894CE00A5EFFF00CEF7FF00B5DEEF0073848400E7E7DE0073635A006B73
        6B0052D6F700FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000894CE00A5EFFF00CEF7FF00C6EFFF00A5D6E700D6C6C600CEC6C600C6AD
        AD00634A4200FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000894CE00A5EFFF00CEF7FF00C6EFFF00ADEFFF005A949C00948C84008C7B
        7B009C8C8400AD9C9400A58C8C00B5A59C00735A5200FF00FF00FF00FF00FF00
        FF000894CE00A5EFFF00CEF7FF00C6EFFF00ADEFFF0063CEE7005A848400EFE7
        E700736B5A00EFDEDE00DECECE00EFE7E7009C8C8400FF00FF00FF00FF00FF00
        FF000894CE00A5EFFF00CEF7FF00C6EFFF00B5EFFF006BE7FF0063BDD600DECE
        CE00E7DEDE00E7DEDE00E7DEDE00EFE7E700F7F7F7005A423900FF00FF00FF00
        FF000894CE00ADEFFF00D6F7FF00C6F7FF00B5EFFF006BD6EF00526B6300F7EF
        F700EFE7E700EFE7E700F7EFEF00E7E7E700E7E7E70031211000FF00FF00FF00
        FF000894CE0039ADDE005ABDE7007BD6EF007BD6F70063CEEF006394A500F7F7
        F700F7F7F700E7E7DE00CEC6C60039291800DED6D600FF00FF00FF00FF00FF00
        FF000894CE00C6F7FF00C6F7FF00A5EFFF0094EFFF007BEFFF0073EFFF00BDB5
        AD00F7F7F700C6BDBD005239310073635A00E7DEDE00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00088CCE001094CE001094CE001094CE001094CE00FF00
        FF00524239005A4A4200948C7B007B7363005A4A3900FF00FF00}
    end
    object btBtnNovo: TBitBtn
      Left = 376
      Top = 16
      Width = 75
      Height = 40
      Caption = 'Novo'
      TabOrder = 7
      OnClick = btBtnNovoClick
    end
  end
  object dbGrdItensLocacao: TDBGrid
    Left = 0
    Top = 370
    Width = 735
    Height = 167
    Hint = 'Itens da Loca'#231#227'o'
    Align = alTop
    BiDiMode = bdLeftToRight
    DataSource = dsItensLocacao
    Options = [dgTitles, dgColumnResize, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentBiDiMode = False
    ParentColor = True
    ParentShowHint = False
    ShowHint = False
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Produto'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_TOTAL'
        Title.Caption = 'Valor Total'
        Visible = True
      end>
  end
  object rdBtnDevolverTodos: TRadioButton
    Left = 510
    Top = 550
    Width = 57
    Height = 17
    Hint = 'Devolver Todos os Produtos'
    Caption = 'Todos'
    Checked = True
    TabOrder = 6
    TabStop = True
  end
  object rdBtnDevolverSelecionar: TRadioButton
    Left = 510
    Top = 574
    Width = 82
    Height = 17
    Hint = 'Selecionar Produtos que ser'#227'o devolvidos'
    Caption = 'Selecionado'
    TabOrder = 7
  end
  object ApplicationEvents: TApplicationEvents
    OnHint = ApplicationEventsHint
    Left = 8
    Top = 240
  end
  object qryLocacoes: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      
        'SELECT l.codigo,c.nome,l.data_inicio,l.data_final,l.observacoes,' +
        'l.valor_total,l.valor_pago,l.pago'
      'FROM locacao l,cliente c'
      'WHERE l.status=0'
      'AND l.cod_cliente=c.codigo')
    SQLConnection = DM.SQLConnection
    Left = 24
    Top = 200
    object qryLocacoesCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryLocacoesNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object qryLocacoesDATA_INICIO: TSQLTimeStampField
      FieldName = 'DATA_INICIO'
    end
    object qryLocacoesDATA_FINAL: TSQLTimeStampField
      FieldName = 'DATA_FINAL'
    end
    object qryLocacoesOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object qryLocacoesVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object qryLocacoesVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      Precision = 15
      Size = 2
    end
    object qryLocacoesPAGO: TIntegerField
      FieldName = 'PAGO'
    end
  end
  object dspLocacoes: TDataSetProvider
    DataSet = qryLocacoes
    Left = 52
    Top = 200
  end
  object cdsLocacoes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspLocacoes'
    Left = 80
    Top = 200
    object cdsLocacoesCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsLocacoesNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
    object cdsLocacoesDATA_INICIO: TSQLTimeStampField
      FieldName = 'DATA_INICIO'
    end
    object cdsLocacoesDATA_FINAL: TSQLTimeStampField
      FieldName = 'DATA_FINAL'
    end
    object cdsLocacoesOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Size = 300
    end
    object cdsLocacoesVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsLocacoesVALOR_PAGO: TFMTBCDField
      FieldName = 'VALOR_PAGO'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsLocacoesPAGO: TIntegerField
      FieldName = 'PAGO'
    end
  end
  object dsLocacoes: TDataSource
    DataSet = cdsLocacoes
    Left = 110
    Top = 200
  end
  object qryItensLocacao: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT i.*,p.nome'
      'FROM Item_Locacao i, locacao l,produto p'
      'WHERE i.cod_locacao=l.codigo'
      'AND i.cod_produto=p.codigo'
      'AND l.codigo=5')
    SQLConnection = DM.SQLConnection
    Left = 8
    Top = 320
    object qryItensLocacaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object qryItensLocacaoCOD_LOCACAO: TIntegerField
      FieldName = 'COD_LOCACAO'
    end
    object qryItensLocacaoCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object qryItensLocacaoQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object qryItensLocacaoVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      Precision = 15
      Size = 2
    end
    object qryItensLocacaoVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      Precision = 15
      Size = 2
    end
    object qryItensLocacaoDATA_DEVOLUCAO: TSQLTimeStampField
      FieldName = 'DATA_DEVOLUCAO'
    end
    object qryItensLocacaoNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  object dspItensLocacao: TDataSetProvider
    DataSet = qryItensLocacao
    Left = 36
    Top = 320
  end
  object cdsItensLocacao: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspItensLocacao'
    Left = 64
    Top = 320
    object cdsItensLocacaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsItensLocacaoCOD_LOCACAO: TIntegerField
      FieldName = 'COD_LOCACAO'
    end
    object cdsItensLocacaoCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object cdsItensLocacaoQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object cdsItensLocacaoVALOR_UNITARIO: TFMTBCDField
      FieldName = 'VALOR_UNITARIO'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsItensLocacaoVALOR_TOTAL: TFMTBCDField
      FieldName = 'VALOR_TOTAL'
      DisplayFormat = '#0.00'
      Precision = 15
      Size = 2
    end
    object cdsItensLocacaoDATA_DEVOLUCAO: TSQLTimeStampField
      FieldName = 'DATA_DEVOLUCAO'
    end
    object cdsItensLocacaoNOME: TStringField
      FieldName = 'NOME'
      Size = 100
    end
  end
  object dsItensLocacao: TDataSource
    DataSet = cdsItensLocacao
    Left = 94
    Top = 320
  end
  object PopupMenu: TPopupMenu
    Left = 40
    Top = 241
    object mnMostrarTodasLocacoes: TMenuItem
      Caption = 'Mostrar Todas Loca'#231#245'es'
      OnClick = mnMostrarTodasLocacoesClick
    end
  end
end
