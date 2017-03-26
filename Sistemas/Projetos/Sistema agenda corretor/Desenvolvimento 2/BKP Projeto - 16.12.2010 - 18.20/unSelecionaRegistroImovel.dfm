inherited frmSelecionaRegistroImovel: TfrmSelecionaRegistroImovel
  Left = 579
  Top = 207
  Caption = 'SELECIONAR IM'#211'VEL'
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbGrdDados: TDBGrid
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
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CC_VALOR_IMOVEL'
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
    inherited grpBxPesquisar: TGroupBox
      inherited plsEdValorPesquisar: TPlsEdit
        OnChange = plsEdValorPesquisarChange
      end
      inherited plsCbBxCampoPesquisar: TPlsComboBox
        Items.Strings = (
          'C'#243'digo'
          'Situa'#231#227'o Desej'#225'vel'
          'Valor Im'#243'vel'
          'Tipo do Im'#243'vel'
          'Estado'
          'Cidade')
      end
      object plsCbBxValorPesquisa: TPlsComboBox
        Left = 149
        Top = 14
        Width = 145
        Height = 21
        Style = csDropDownList
        CharCase = ecUpperCase
        ItemHeight = 13
        TabOrder = 2
        OnChange = plsCbBxValorPesquisaChange
        Items.Strings = (
          'PLANTA'
          'PRONTO PARA MORAR'
          'DE TERCEIROS')
        plsCorRecebeFoco = clSilver
      end
    end
  end
  inherited zqrySelecionarRegistro: TZQuery
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
    object zqrySelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object zqrySelecionarRegistroSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object zqrySelecionarRegistroCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object zqrySelecionarRegistroCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object zqrySelecionarRegistroCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object zqrySelecionarRegistroSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object zqrySelecionarRegistroVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object zqrySelecionarRegistroNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object zqrySelecionarRegistroSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object zqrySelecionarRegistroNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object zqrySelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object zqrySelecionarRegistroCC_VALOR_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL'
    end
  end
  inherited cdsSelecionarRegistro: TClientDataSet
    AfterScroll = cdsSelecionarRegistroAfterScroll
    object cdsSelecionarRegistroCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsSelecionarRegistroSTATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object cdsSelecionarRegistroCOD_FK_TIPO_IMOVEL: TIntegerField
      FieldName = 'COD_FK_TIPO_IMOVEL'
    end
    object cdsSelecionarRegistroCOD_FK_ESTADO: TIntegerField
      FieldName = 'COD_FK_ESTADO'
    end
    object cdsSelecionarRegistroCOD_FK_CIDADE: TIntegerField
      FieldName = 'COD_FK_CIDADE'
    end
    object cdsSelecionarRegistroSITUACAO_DESEJAVEL: TStringField
      FieldName = 'SITUACAO_DESEJAVEL'
    end
    object cdsSelecionarRegistroVALOR_IMOVEL: TFloatField
      FieldName = 'VALOR_IMOVEL'
    end
    object cdsSelecionarRegistroNOME_TIPO_IMOVEL: TStringField
      FieldName = 'NOME_TIPO_IMOVEL'
      Required = True
      Size = 60
    end
    object cdsSelecionarRegistroSIGLA_ESTADO: TStringField
      FieldName = 'SIGLA_ESTADO'
      Required = True
      Size = 2
    end
    object cdsSelecionarRegistroNOME_CIDADE: TStringField
      FieldName = 'NOME_CIDADE'
      Required = True
      Size = 100
    end
    object cdsSelecionarRegistroCC_CODIGO: TStringField
      FieldName = 'CC_CODIGO'
      ReadOnly = True
      Size = 10
    end
    object cdsSelecionarRegistroCC_VALOR_IMOVEL: TStringField
      FieldName = 'CC_VALOR_IMOVEL'
    end
  end
end
