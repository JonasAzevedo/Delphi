inherited frmPesquisandoImovel: TfrmPesquisandoImovel
  Left = 492
  Top = 267
  Caption = 'PESQUISANDO IM'#211'VEL'
  OldCreateOrder = True
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbGrdRegistros: TDBGrid
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SITUACAO_DESEJAVEL'
        Title.Caption = 'Situa'#231#227'o Desej'#225'vel'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR_IMOVEL'
        Title.Caption = 'Valor Im'#243'vel'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_TIPO_IMOVEL'
        Title.Caption = 'Tipo de Im'#243'vel'
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGLA_ESTADO'
        Title.Caption = 'Estado'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_CIDADE'
        Title.Caption = 'Cidade'
        Width = 150
        Visible = True
      end>
  end
  inherited pnlTopo: TPanel
    inherited plsEdValorPesquisa: TPlsEdit
      Left = 150
      Top = 3
      Width = 400
      MaxLength = 100
      plsCorRecebeFoco = clSilver
    end
    object plsCbBxCampoPesquisar: TPlsComboBox
      Left = 0
      Top = 3
      Width = 145
      Height = 21
      Style = csDropDownList
      CharCase = ecUpperCase
      ItemHeight = 13
      TabOrder = 1
      OnChange = plsCbBxCampoPesquisarChange
      Items.Strings = (
        'C'#211'DIGO'
        'SITUA'#199#195'O DESEJ'#193'VEL'
        'VALOR IM'#211'VEL'
        'TIPO DO IM'#211'VEL'
        'ESTADO'
        'CIDADE')
      plsCorRecebeFoco = clSilver
    end
  end
  object plsCbBxValorPesquisa: TPlsComboBox [2]
    Left = 150
    Top = 3
    Width = 145
    Height = 21
    Style = csDropDownList
    CharCase = ecUpperCase
    ItemHeight = 13
    TabOrder = 2
    OnChange = plsCbBxValorPesquisaChange
    plsCorRecebeFoco = clSilver
  end
  inherited cdsPesquisando: TClientDataSet
    ProviderName = 'dspPesquisando'
    Left = 67
    Top = 63
    object cdsPesquisandoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsPesquisandoSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object cdsPesquisandoCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object cdsPesquisandoCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object cdsPesquisandoCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object cdsPesquisandoSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object cdsPesquisandoVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object cdsPesquisandoNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object cdsPesquisandoSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object cdsPesquisandoNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object cdsPesquisandoCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object cdsPesquisandoCC_VALOR_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL'
      ReadOnly = True
    end
  end
  inherited dsPesquisando: TDataSource
    Left = 95
    Top = 63
  end
  object zQryPesquisando: TZQuery
    Connection = DM.ZConnection
    SQL.Strings = (
      'SELECT'
      
        '  i.codigo,i.status,i.cod_fk_tipo_imovel,i.cod_fk_estado,i.cod_f' +
        'k_cidade,i.situacao_desejavel,'
      '  i.valor_imovel,'
      '  t_i.nome as nome_tipo_imovel,'
      '  e.sigla as sigla_estado,'
      '  c.nome as nome_cidade,'
      '  CAST(i.codigo AS VARCHAR(10))AS cc_codigo,'
      '  CAST(i.valor_imovel AS VARCHAR(20))AS cc_valor_imovel'
      'FROM imovel i'
      'JOIN tipo_imovel t_i ON i.cod_fk_tipo_imovel=t_i.codigo'
      'JOIN estado e ON i.cod_fk_estado=e.codigo'
      'JOIN cidade c ON i.cod_fk_cidade=c.codigo'
      '')
    Params = <>
    Left = 10
    Top = 63
    object zQryPesquisandoCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zQryPesquisandoSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object zQryPesquisandoCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object zQryPesquisandoCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zQryPesquisandoCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zQryPesquisandoSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zQryPesquisandoVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object zQryPesquisandoNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object zQryPesquisandoSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object zQryPesquisandoNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object zQryPesquisandoCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object zQryPesquisandoCC_VALOR_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL'
      ReadOnly = True
    end
  end
  object dspPesquisando: TDataSetProvider
    DataSet = zQryPesquisando
    Left = 38
    Top = 63
  end
end
