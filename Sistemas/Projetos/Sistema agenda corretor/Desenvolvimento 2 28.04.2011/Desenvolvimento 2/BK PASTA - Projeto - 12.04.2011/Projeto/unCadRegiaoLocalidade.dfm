inherited frmCadRegiaoLocalidade: TfrmCadRegiaoLocalidade
  Left = 429
  Top = 217
  Caption = 'CADASTRO DE REGI'#213'ES DE LOCALIDADES'
  ClientHeight = 276
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 257
  end
  inherited grpBxDados: TGroupBox
    Height = 217
    object Label1: TLabel
      Left = 5
      Top = 20
      Width = 36
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 5
      Top = 50
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object lblCampoObrigatorio2: TLabel
      Left = 36
      Top = 46
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
      OnEnter = plsEdCodigoEnter
      OnExit = plsEdCodigoExit
      OnKeyPress = plsEdCodigoKeyPress
      OnKeyUp = plsEdCodigoKeyUp
      plsCorRecebeFoco = clSilver
      plsCaracteresAceitos = numeros
    end
    object plsEdNome: TPlsEdit
      Left = 44
      Top = 44
      Width = 337
      Height = 21
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 1
      Text = 'PLSEDNOME'
      OnEnter = plsEdNomeEnter
      OnExit = plsEdNomeExit
      OnKeyPress = plsEdNomeKeyPress
      OnKeyUp = plsEdNomeKeyUp
      plsCorRecebeFoco = clSilver
    end
    object dbGrdBairros: TDBGrid
      Left = 8
      Top = 80
      Width = 345
      Height = 120
      Hint = 'Bairros da Regi'#227'o Localidade'
      DataSource = dsBairros
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NOME_BAIRRO'
          Title.Caption = 'Bairro(s)'
          Width = 327
          Visible = True
        end>
    end
    object pnlAddDeleteBairros: TPanel
      Left = 352
      Top = 78
      Width = 33
      Height = 54
      BevelOuter = bvNone
      Enabled = False
      TabOrder = 3
      object btBtnDeletarBairro: TBitBtn
        Left = 2
        Top = 28
        Width = 30
        Height = 25
        Hint = 'Deletar Bairro'
        Caption = '-'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btBtnDeletarBairroClick
      end
      object btBtnAdicionarBairro: TBitBtn
        Left = 2
        Top = 3
        Width = 30
        Height = 25
        Hint = 'Adicionar Bairro'
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btBtnAdicionarBairroClick
      end
    end
  end
  inherited ToolBar: TToolBar
    inherited pnlDicas: TPanel
      inherited lblDicas: TLabel
        OnClick = lblDicasClick
      end
    end
  end
  inherited zQryDados: TZQuery
    SQL.Strings = (
      'SELECT * '
      'FROM regiao_localidade'
      'WHERE 1=2'
      'ORDER BY nome')
    object zQryDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
  end
  inherited cdsDados: TClientDataSet
    object cdsDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 50
    end
  end
  object cdsBairros: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 20
    Top = 190
  end
  object dsBairros: TDataSource
    DataSet = cdsBairros
    Left = 48
    Top = 190
  end
  object zQryBairros: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      
        'SELECT r.codigo, r.cod_fk_regiao_localidade, r.cod_fk_bairro, b.' +
        'nome'
      'FROM regiao_localidade_bairro r'
      'JOIN bairro b ON r.cod_fk_bairro=b.codigo'
      'WHERE r.cod_fk_regiao_localidade = 5'
      'AND 1=2')
    Params = <>
    Left = 20
    Top = 159
    object zQryBairrosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryBairrosCOD_FK_REGIAO_LOCALIDADE: TIntegerField
      FieldName = 'COD_FK_REGIAO_LOCALIDADE'
      Required = True
    end
    object zQryBairrosCOD_FK_BAIRRO: TIntegerField
      FieldName = 'COD_FK_BAIRRO'
      Required = True
    end
    object zQryBairrosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 100
    end
  end
end
