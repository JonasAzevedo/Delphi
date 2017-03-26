unit unSelecionaRegistroAgenciamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, plsComboBox, plsEdit,
  ExtCtrls, Grids, DBGrids, unFuncoes, Menus;

type
  TfrmSelecionaRegistroAgenciamento = class(TfrmSelecionaRegistro)
    plsCbBxValorPesquisa: TPlsComboBox;
    zqrySelecionarRegistroCODIGO_AGENCIAMENTO: TIntegerField;
    zqrySelecionarRegistroDATA_AGENCIAMENTO: TDateField;
    zqrySelecionarRegistroATIVO_AGENCIAMENTO: TStringField;
    zqrySelecionarRegistroCC_CODIGO: TStringField;
    zqrySelecionarRegistroNORMAL_STANDBY: TStringField;
    zqrySelecionarRegistroTIPO_PESSOA: TStringField;
    zqrySelecionarRegistroNOME_TIPO_PESSOA: TStringField;
    zqrySelecionarRegistroCONDICAO_PAGAMENTO: TStringField;
    zqrySelecionarRegistroCC_VALOR_TOTAL_AGENCIAMENTO: TStringField;
    zqrySelecionarRegistroCC_PGTO_VISTA_CACH: TStringField;
    zqrySelecionarRegistroCC_PGTO_VISTA_VALOR_BEM: TStringField;
    zqrySelecionarRegistroCC_PGTO_VISTA_DESCRICAO_BEM: TStringField;
    zqrySelecionarRegistroCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField;
    zqrySelecionarRegistroCC_PGTO_FINCTO_CACH: TStringField;
    zqrySelecionarRegistroCC_PGTO_FINCTO_VALOR_BEM: TStringField;
    zqrySelecionarRegistroCC_PGTO_FINCTO_DESCRICAO_BEM: TStringField;
    zqrySelecionarRegistroOBSERVACAO_AGENCIAMENTO: TStringField;
    zqrySelecionarRegistroPRAZO_AUTORIZACAO: TDateField;
    zqrySelecionarRegistroDATA_REAGENCIAMENTO: TDateField;
    zqrySelecionarRegistroCODIGO_PESSOA_FISICA: TIntegerField;
    zqrySelecionarRegistroNOME_PESSOA_FISICA: TStringField;
    zqrySelecionarRegistroCODIGO_PESSOA_JURIDICA: TIntegerField;
    zqrySelecionarRegistroNOME_PESSOA_JURIDICA: TStringField;
    zqrySelecionarRegistroCODIGO_IMOVEL: TIntegerField;
    zqrySelecionarRegistroSTATUS_IMOVEL: TSmallintField;
    zqrySelecionarRegistroSITUACAO_DESEJAVEL: TStringField;
    zqrySelecionarRegistroCC_VALOR_IMOVEL_IMOVEL: TStringField;
    zqrySelecionarRegistroDESCRICAO_IMOVEL: TStringField;
    zqrySelecionarRegistroCODIGO_TIPO_IMOVEL: TIntegerField;
    zqrySelecionarRegistroNOME_TIPO_IMOVEL: TStringField;
    zqrySelecionarRegistroCODIGO_ESTADO: TIntegerField;
    zqrySelecionarRegistroSIGLA_ESTADO: TStringField;
    zqrySelecionarRegistroCODIGO_CIDADE: TIntegerField;
    zqrySelecionarRegistroNOME_CIDADE: TStringField;
    zqrySelecionarRegistroCODIGO_BAIRRO: TIntegerField;
    zqrySelecionarRegistroNOME_BAIRRO: TStringField;
    zqrySelecionarRegistroCODIGO_RUA: TIntegerField;
    zqrySelecionarRegistroNOME_RUA: TStringField;
    zqrySelecionarRegistroCEP_RUA: TStringField;
    cdsSelecionarRegistroCODIGO_AGENCIAMENTO: TIntegerField;
    cdsSelecionarRegistroDATA_AGENCIAMENTO: TDateField;
    cdsSelecionarRegistroATIVO_AGENCIAMENTO: TStringField;
    cdsSelecionarRegistroCC_CODIGO: TStringField;
    cdsSelecionarRegistroNORMAL_STANDBY: TStringField;
    cdsSelecionarRegistroTIPO_PESSOA: TStringField;
    cdsSelecionarRegistroNOME_TIPO_PESSOA: TStringField;
    cdsSelecionarRegistroCONDICAO_PAGAMENTO: TStringField;
    cdsSelecionarRegistroCC_VALOR_TOTAL_AGENCIAMENTO: TStringField;
    cdsSelecionarRegistroCC_PGTO_VISTA_CACH: TStringField;
    cdsSelecionarRegistroCC_PGTO_VISTA_VALOR_BEM: TStringField;
    cdsSelecionarRegistroCC_PGTO_VISTA_DESCRICAO_BEM: TStringField;
    cdsSelecionarRegistroCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField;
    cdsSelecionarRegistroCC_PGTO_FINCTO_CACH: TStringField;
    cdsSelecionarRegistroCC_PGTO_FINCTO_VALOR_BEM: TStringField;
    cdsSelecionarRegistroCC_PGTO_FINCTO_DESCRICAO_BEM: TStringField;
    cdsSelecionarRegistroOBSERVACAO_AGENCIAMENTO: TStringField;
    cdsSelecionarRegistroPRAZO_AUTORIZACAO: TDateField;
    cdsSelecionarRegistroDATA_REAGENCIAMENTO: TDateField;
    cdsSelecionarRegistroCODIGO_PESSOA_FISICA: TIntegerField;
    cdsSelecionarRegistroNOME_PESSOA_FISICA: TStringField;
    cdsSelecionarRegistroCODIGO_PESSOA_JURIDICA: TIntegerField;
    cdsSelecionarRegistroNOME_PESSOA_JURIDICA: TStringField;
    cdsSelecionarRegistroCODIGO_IMOVEL: TIntegerField;
    cdsSelecionarRegistroSTATUS_IMOVEL: TSmallintField;
    cdsSelecionarRegistroSITUACAO_DESEJAVEL: TStringField;
    cdsSelecionarRegistroCC_VALOR_IMOVEL_IMOVEL: TStringField;
    cdsSelecionarRegistroDESCRICAO_IMOVEL: TStringField;
    cdsSelecionarRegistroCODIGO_TIPO_IMOVEL: TIntegerField;
    cdsSelecionarRegistroNOME_TIPO_IMOVEL: TStringField;
    cdsSelecionarRegistroCODIGO_ESTADO: TIntegerField;
    cdsSelecionarRegistroSIGLA_ESTADO: TStringField;
    cdsSelecionarRegistroCODIGO_CIDADE: TIntegerField;
    cdsSelecionarRegistroNOME_CIDADE: TStringField;
    cdsSelecionarRegistroCODIGO_BAIRRO: TIntegerField;
    cdsSelecionarRegistroNOME_BAIRRO: TStringField;
    cdsSelecionarRegistroCODIGO_RUA: TIntegerField;
    cdsSelecionarRegistroNOME_RUA: TStringField;
    cdsSelecionarRegistroCEP_RUA: TStringField;
    ppMnExibirDadosAgenciamento: TPopupMenu;
    mnItExibirDadosAgenciamento: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure plsEdValorPesquisarChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure plsCbBxValorPesquisaChange(Sender: TObject);
    procedure plsCbBxCampoPesquisarChange(Sender: TObject);
    procedure cdsSelecionarRegistroAfterScroll(DataSet: TDataSet);
    procedure mnItExibirDadosAgenciamentoClick(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
    FiCodigoImovel: integer;
    FsNomeImovel: string;
    FiCodigoAgenciamento: integer;
    FsNomeAgenciamento: string;
    FsCampoPesquisa: string;
    FsFiltro: string;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
  protected
    procedure selecionarTodosRegistros(); override;
    procedure formatarValores(); override;
    procedure mostrarCampoValorPesquisa(psCampo: String);
    procedure popularComboBoxValorPesquisa(psCampo: String);
    procedure filtrarPesquisa(); override;
    procedure selecionouRegistro(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
    procedure popularCampoInteiroTipoString(); override;
    procedure inserirNovoRegistro(); override;
  end;

var
  frmSelecionaRegistroAgenciamento: TfrmSelecionaRegistroAgenciamento;

const
  pCONST_CAMPO_TEXTO = 'sCampoTexto';
  pCONST_TIPO_PESSOA = 'sTipoPessoa';
  pCONST_CONDICAO_PAGAMENTO = 'sCondicaoPagamento';
  pCONST_SITUACAO_DESEJAVEL = 'sSituacaoDesejavel';

implementation

uses unConstantes, unDM, unCadVenda, unExibeDadosAgenciamento;

{$R *.dfm}

{ TfrmSelecionaRegistroAgenciamento }

(* procedimentos de controle *)

procedure TfrmSelecionaRegistroAgenciamento.passarParametro(pTipo:String; pValores:OleVariant);
var
  sCodImovelNovo: String;
begin
  inherited;

  if(pTipo = PRM_INICIAR_TELA)then
  begin
    selecionarTodosRegistros();
    plsCbBxCampoPesquisar.ItemIndex := 0;
    plsCbBxValorPesquisa.Visible := False;
    plsEdValorPesquisar.Visible := True;
    Self.FsCampoPesquisa := 'CC_CODIGO';
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros()

  else if(pTipo = PRM_DEFINE_FILTRO)then
  begin
    Self.FsFiltro := pValores;
  end;
end;

procedure TfrmSelecionaRegistroAgenciamento.filtrarPesquisa();
var
  sVlrPesquisa: String;
begin
  if((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME_TIPO_PESSOA')or
  (Self.FsCampoPesquisa = 'NOME_TIPO_IMOVEL')or(Self.FsCampoPesquisa = 'SIGLA_ESTADO')or
  (Self.FsCampoPesquisa = 'NOME_CIDADE')or(Self.FsCampoPesquisa = 'NOME_BAIRRO')or
  (Self.FsCampoPesquisa = 'NOME_RUA'))then
  begin
    if(plsEdValorPesquisar.Text <> STRING_INDEFINIDO)then
    begin
      cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
      cdsSelecionarRegistro.Filtered := True;

      if(cdsSelecionarRegistro.RecordCount=0)then
      begin
        MessageDlg('Nenhum registro encontrado.',mtInformation,[mbOK],0);
        cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
        cdsSelecionarRegistro.Filtered := True;
        plsEdValorPesquisar.Clear;
      end;
    end
    else
      limparFiltroPesquisa();    
  end

  else if((Self.FsCampoPesquisa = 'TIPO_PESSOA')or(Self.FsCampoPesquisa = 'CONDICAO_PAGAMENTO')or
   (Self.FsCampoPesquisa = 'SITUACAO_DESEJAVEL'))then
  begin
    if(plsCbBxValorPesquisa.ItemIndex <> -1)then
    begin
      cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsCbBxValorPesquisa.Text + '%');
      cdsSelecionarRegistro.Filtered := True;
      if(cdsSelecionarRegistro.RecordCount=0)then
      begin
        MessageDlg('Nenhum registro encontrado.',mtInformation,[mbOK],0);
        cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
        cdsSelecionarRegistro.Filtered := True;
        plsCbBxValorPesquisa.ItemIndex := -1;
      end;
    end;
  end;
end;

procedure TfrmSelecionaRegistroAgenciamento.selecionouRegistro();
begin
  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_VENDAS)then //TfrmCadVenda
    begin
      frmCadVenda.FoImovel.codigo := FiCodigoImovel;
      frmCadVenda.FoImovel.nome := FsNomeImovel;
      frmCadVenda.FoAgenciamento.codigo := FiCodigoAgenciamento;
      frmCadVenda.FoAgenciamento.nome := FsNomeAgenciamento;
    end;
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroAgenciamento.configurarCaracteresAceitosPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME_TIPO_PESSOA')or(Self.FsCampoPesquisa = 'NOME_TIPO_IMOVEL')or
  (Self.FsCampoPesquisa = 'SIGLA_ESTADO')or(Self.FsCampoPesquisa = 'NOME_CIDADE')or
  (Self.FsCampoPesquisa = 'NOME_BAIRRO')or(Self.FsCampoPesquisa = 'NOME_RUA'))then
    plsEdValorPesquisar.plsCaracteresAceitos := todos;

  if(Self.FsCampoPesquisa = 'CC_CODIGO')then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

procedure TfrmSelecionaRegistroAgenciamento.selecionarTodosRegistros();
var
  sSQL: String;

  procedure montarSQL();
  begin
    sSQL := 'SELECT a.codigo AS CODIGO_AGENCIAMENTO,a.data_agenciamento,';
    sSQL := sSQL + 'a.ativo AS ATIVO_AGENCIAMENTO,CAST(a.codigo AS VARCHAR(10)) AS cc_codigo,';
    sSQL := sSQL + 'CASE WHEN a.normal = ''SIM'' THEN ''NORMAL'' ELSE ''STAND BY'' ';
    sSQL := sSQL + 'END AS NORMAL_STANDBY,a.tipo_pessoa,';
    sSQL := sSQL + 'CASE WHEN a.tipo_pessoa = ''FÍSICA'' THEN pf.nome ';
    sSQL := sSQL + 'WHEN a.tipo_pessoa = ''JURÍDICA'' THEN pj.nome ELSE ''NENHUMA'' ';
    sSQL := sSQL + 'END AS NOME_TIPO_PESSOA,';
    sSQL := sSQL + 'a.condicao_pagamento,';
    sSQL := sSQL + 'CAST(a.valor_total  AS VARCHAR(20)) AS CC_VALOR_TOTAL_AGENCIAMENTO,';
    sSQL := sSQL + 'CAST(a.pgto_vista_cach AS VARCHAR(20)) AS CC_PGTO_VISTA_CACH,';
    sSQL := sSQL + 'CAST(a.pgto_vista_valor_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_VALOR_BEM,';
    sSQL := sSQL + 'CAST(a.pgto_vista_descricao_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_DESCRICAO_BEM,';
    sSQL := sSQL + 'CAST(a.pgto_fincto_cach_financiado AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH_FINANCIADO,';
    sSQL := sSQL + 'CAST(a.pgto_fincto_cach AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH,';
    sSQL := sSQL + 'CAST(a.pgto_fincto_valor_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_VALOR_BEM,';
    sSQL := sSQL + 'CAST(a.pgto_fincto_descricao_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_DESCRICAO_BEM,';
    sSQL := sSQL + 'a.observacao AS OBSERVACAO_AGENCIAMENTO,';
    sSQL := sSQL + 'a.prazo_autorizacao,a.data_reagenciamento,';
    sSQL := sSQL + 'pf.codigo AS CODIGO_PESSOA_FISICA,pf.nome AS NOME_PESSOA_FISICA,';
    sSQL := sSQL + 'pj.codigo AS CODIGO_PESSOA_JURIDICA,pj.nome AS NOME_PESSOA_JURIDICA,';
    sSQL := sSQL + 'i.codigo AS CODIGO_IMOVEL,i.status AS STATUS_IMOVEL,i.situacao_desejavel,';
    sSQL := sSQL + 'CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL_IMOVEL,';
    sSQL := sSQL + 'i.descricao AS DESCRICAO_IMOVEL,';
    sSQL := sSQL + 'ti.codigo AS CODIGO_TIPO_IMOVEL,ti.nome AS NOME_TIPO_IMOVEL,';
    sSQL := sSQL + 'est.codigo AS CODIGO_ESTADO,est.sigla AS SIGLA_ESTADO,';
    sSQL := sSQL + 'cid.codigo AS CODIGO_CIDADE,cid.nome AS NOME_CIDADE,';
    sSQL := sSQL + 'bai.codigo AS CODIGO_BAIRRO,bai.nome AS NOME_BAIRRO,';
    sSQL := sSQL + 'rua.codigo AS CODIGO_RUA,rua.nome AS NOME_RUA,rua.cep AS CEP_RUA ';
    sSQL := sSQL + 'FROM agenciamentos a ';
    sSQL := sSQL + 'JOIN pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo ';
    sSQL := sSQL + 'JOIN pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo ';
    sSQL := sSQL + 'JOIN imovel i ON a.cod_fk_imovel = i.codigo ';
    sSQL := sSQL + 'JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ';
    sSQL := sSQL + 'JOIN estado est ON i.cod_fk_estado = est.codigo ';
    sSQL := sSQL + 'JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ';
    sSQL := sSQL + 'JOIN bairro bai ON i.cod_fk_bairro = bai.codigo ';
    sSQL := sSQL + 'JOIN rua rua ON i.cod_fk_rua = rua.codigo ';
    sSQL := sSQL + FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('a');
    if(Self.FsFiltro <> STRING_INDEFINIDO)then
      sSQL := sSQL + 'AND ' + Self.FsFiltro;
    sSQL := sSQL + 'ORDER BY a.codigo';
  end;

begin
  montarSQL();
  cdsSelecionarRegistro.DisableControls;
  cdsSelecionarRegistro.Close;
  zqrySelecionarRegistro.Close;
  zqrySelecionarRegistro.SQL.Clear;
  zqrySelecionarRegistro.SQL.Add(sSQL);
  zqrySelecionarRegistro.Open;
  cdsSelecionarRegistro.Open;
  Self.formatarValores();
  cdsSelecionarRegistro.EnableControls;
end;

procedure TfrmSelecionaRegistroAgenciamento.formatarValores();
var
  sValorMonetario: String;
begin
  if((cdsSelecionarRegistro.Active)and(cdsSelecionarRegistro.RecordCount>0))then
  begin
    cdsSelecionarRegistro.First;
    while(not(cdsSelecionarRegistro.Eof))do
    begin
      cdsSelecionarRegistro.Edit;

      sValorMonetario :=  cdsSelecionarRegistroCC_VALOR_TOTAL_AGENCIAMENTO.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsSelecionarRegistroCC_VALOR_TOTAL_AGENCIAMENTO.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsSelecionarRegistroCC_PGTO_VISTA_CACH.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsSelecionarRegistroCC_PGTO_VISTA_CACH.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsSelecionarRegistroCC_PGTO_VISTA_VALOR_BEM.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsSelecionarRegistroCC_PGTO_VISTA_VALOR_BEM.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsSelecionarRegistroCC_PGTO_VISTA_DESCRICAO_BEM.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsSelecionarRegistroCC_PGTO_VISTA_DESCRICAO_BEM.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsSelecionarRegistroCC_PGTO_FINCTO_CACH_FINANCIADO.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsSelecionarRegistroCC_PGTO_FINCTO_CACH_FINANCIADO.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsSelecionarRegistroCC_PGTO_FINCTO_CACH.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsSelecionarRegistroCC_PGTO_FINCTO_CACH.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsSelecionarRegistroCC_PGTO_FINCTO_VALOR_BEM.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsSelecionarRegistroCC_PGTO_FINCTO_VALOR_BEM.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsSelecionarRegistroCC_PGTO_FINCTO_DESCRICAO_BEM.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsSelecionarRegistroCC_PGTO_FINCTO_DESCRICAO_BEM.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsSelecionarRegistroCC_VALOR_IMOVEL_IMOVEL.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsSelecionarRegistroCC_VALOR_IMOVEL_IMOVEL.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      cdsSelecionarRegistro.Post;
      cdsSelecionarRegistro.Next;
    end;
  end;  
end;

procedure TfrmSelecionaRegistroAgenciamento.mostrarCampoValorPesquisa(psCampo: String);
begin
  if(psCampo = pCONST_CAMPO_TEXTO)then
  begin
    plsEdValorPesquisar.Visible := True;
    plsCbBxValorPesquisa.Visible := False;
    plsEdValorPesquisar.Clear;
  end
  else if(psCampo = pCONST_TIPO_PESSOA)or(psCampo = pCONST_CONDICAO_PAGAMENTO)or
    (psCampo = pCONST_SITUACAO_DESEJAVEL)then
  begin
    plsEdValorPesquisar.Visible := False;
    plsCbBxValorPesquisa.Visible := True;
    popularComboBoxValorPesquisa(psCampo);
    plsCbBxValorPesquisa.ItemIndex := -1;
  end;

end;

procedure TfrmSelecionaRegistroAgenciamento.popularComboBoxValorPesquisa(psCampo: String);
begin
  plsCbBxValorPesquisa.Items.Clear;
  if(psCampo = pCONST_TIPO_PESSOA)then
  begin
    plsCbBxValorPesquisa.Items.Add('FÍSICA');
    plsCbBxValorPesquisa.Items.Add('JURÍDICA');
  end
  else if(psCampo = pCONST_CONDICAO_PAGAMENTO)then
  begin
    plsCbBxValorPesquisa.Items.Add('VISTA');
    plsCbBxValorPesquisa.Items.Add('ACEITA FINANCIAMENTO');
  end
  else if(psCampo = pCONST_SITUACAO_DESEJAVEL)then
  begin
    plsCbBxValorPesquisa.Items.Add('PLANTA');
    plsCbBxValorPesquisa.Items.Add('PRONTO PARA MORAR');
    plsCbBxValorPesquisa.Items.Add('DE TERCEIROS');
  end;
end;

procedure TfrmSelecionaRegistroAgenciamento.popularCampoInteiroTipoString();
begin
end;

procedure TfrmSelecionaRegistroAgenciamento.inserirNovoRegistro();
begin
end;

(* fim - procedimentos de controle *)

procedure TfrmSelecionaRegistroAgenciamento.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoFuncoes := TFuncoes.Create;
  Self.FsFiltro := STRING_INDEFINIDO;
end;

procedure TfrmSelecionaRegistroAgenciamento.plsEdValorPesquisarChange(
  Sender: TObject);
begin
  inherited;
  filtrarPesquisa();
end;

procedure TfrmSelecionaRegistroAgenciamento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoFuncoes);
end;

procedure TfrmSelecionaRegistroAgenciamento.plsCbBxValorPesquisaChange(
  Sender: TObject);
begin
  inherited;
  filtrarPesquisa();
end;

procedure TfrmSelecionaRegistroAgenciamento.plsCbBxCampoPesquisarChange(
  Sender: TObject);
begin
  inherited;

  case plsCbBxCampoPesquisar.ItemIndex of
    0:
    begin
      Self.FsCampoPesquisa := 'CC_CODIGO';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisar.SetFocus;
    end;
    1:
    begin
      Self.FsCampoPesquisa := 'TIPO_PESSOA';
      mostrarCampoValorPesquisa(pCONST_TIPO_PESSOA);
      plsCbBxValorPesquisa.SetFocus;
    end;
    2:
    begin
      Self.FsCampoPesquisa := 'NOME_TIPO_PESSOA';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisar.SetFocus;
    end;
    3:
    begin
      Self.FsCampoPesquisa := 'CONDICAO_PAGAMENTO';
      mostrarCampoValorPesquisa(pCONST_CONDICAO_PAGAMENTO);
      plsCbBxValorPesquisa.SetFocus;
    end;
    4:
    begin
      Self.FsCampoPesquisa := 'NOME_TIPO_IMOVEL';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisar.SetFocus;
    end;
    5:
    begin
      Self.FsCampoPesquisa := 'SITUACAO_DESEJAVEL';
      mostrarCampoValorPesquisa(pCONST_SITUACAO_DESEJAVEL);
      plsCbBxValorPesquisa.SetFocus;
    end;
    6:
    begin
      Self.FsCampoPesquisa := 'SIGLA_ESTADO';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisar.SetFocus;
    end;
    7:
    begin
      Self.FsCampoPesquisa := 'NOME_CIDADE';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisar.SetFocus;
    end;
    8:
    begin
      Self.FsCampoPesquisa := 'NOME_BAIRRO';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisar.SetFocus;
    end;
    9:
    begin
      Self.FsCampoPesquisa := 'NOME_RUA';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisar.SetFocus;
    end;
  end;
  configurarCaracteresAceitosPesquisa();
end;

procedure TfrmSelecionaRegistroAgenciamento.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigoAgenciamento := cdsSelecionarRegistroCODIGO_AGENCIAMENTO.AsInteger;;
  Self.FiCodigoImovel := cdsSelecionarRegistroCODIGO_IMOVEL.AsInteger;
  Self.FsNomeImovel := cdsSelecionarRegistroNOME_TIPO_PESSOA.AsString + ' - ' +
   cdsSelecionarRegistroSIGLA_ESTADO.AsString + ' - ' +
   cdsSelecionarRegistroNOME_CIDADE.AsString;
   if(cdsSelecionarRegistroCC_VALOR_TOTAL_AGENCIAMENTO.AsString <> STRING_INDEFINIDO)then
   begin
     Self.FsNomeImovel := Self.FsNomeImovel + ' - Valor: ' +
     Self.FoFuncoes.formatarValorMonetario(cdsSelecionarRegistroCC_VALOR_TOTAL_AGENCIAMENTO.AsString);
   end;
  Self.FsNomeAgenciamento := Self.FsNomeImovel;
end;

procedure TfrmSelecionaRegistroAgenciamento.mnItExibirDadosAgenciamentoClick(
  Sender: TObject);
var
  vParametros: Variant;

  procedure CarregaDadosAgenciamento();
  begin
    vParametros[0] := cdsSelecionarRegistroCODIGO_AGENCIAMENTO.AsString;
    vParametros[1] := cdsSelecionarRegistroATIVO_AGENCIAMENTO.AsString;
    vParametros[2] := cdsSelecionarRegistroNORMAL_STANDBY.AsString;
    vParametros[3] := cdsSelecionarRegistroDATA_AGENCIAMENTO.AsString;
    vParametros[4] := cdsSelecionarRegistroPRAZO_AUTORIZACAO.AsString;
    vParametros[5] := cdsSelecionarRegistroDATA_REAGENCIAMENTO.AsString;
    vParametros[6] := cdsSelecionarRegistroTIPO_PESSOA.AsString;
    if(cdsSelecionarRegistroTIPO_PESSOA.AsString = 'FÍSICA')then
      vParametros[7] := cdsSelecionarRegistroNOME_PESSOA_FISICA.AsString
    else if(cdsSelecionarRegistroTIPO_PESSOA.AsString = 'JURÍDICA')then
      vParametros[7] := cdsSelecionarRegistroNOME_PESSOA_JURIDICA.AsString;
    vParametros[8] := cdsSelecionarRegistroCC_VALOR_TOTAL_AGENCIAMENTO.AsString;
    vParametros[9] := cdsSelecionarRegistroCONDICAO_PAGAMENTO.AsString;
    vParametros[10] := cdsSelecionarRegistroCC_PGTO_VISTA_CACH.AsString;
    vParametros[11] := cdsSelecionarRegistroCC_PGTO_VISTA_VALOR_BEM.AsString;
    vParametros[12] := cdsSelecionarRegistroCC_PGTO_VISTA_DESCRICAO_BEM.AsString;
    vParametros[13] := cdsSelecionarRegistroCC_PGTO_FINCTO_CACH_FINANCIADO.AsString;
    vParametros[14] := cdsSelecionarRegistroCC_PGTO_FINCTO_CACH.AsString;
    vParametros[15] := cdsSelecionarRegistroCC_PGTO_FINCTO_VALOR_BEM.AsString;
    vParametros[16] := cdsSelecionarRegistroCC_PGTO_FINCTO_DESCRICAO_BEM.AsString;
    vParametros[17] := cdsSelecionarRegistroOBSERVACAO_AGENCIAMENTO.AsString;
    vParametros[18] := cdsSelecionarRegistroCODIGO_IMOVEL.AsString;
    vParametros[19] := cdsSelecionarRegistroSTATUS_IMOVEL.AsString;
    vParametros[20] := cdsSelecionarRegistroSITUACAO_DESEJAVEL.AsString;
    vParametros[21] := cdsSelecionarRegistroNOME_TIPO_IMOVEL.AsString;
    vParametros[22] := cdsSelecionarRegistroCC_VALOR_IMOVEL_IMOVEL.AsString;
    vParametros[23] := cdsSelecionarRegistroDESCRICAO_IMOVEL.AsString;
    vParametros[24] := cdsSelecionarRegistroSIGLA_ESTADO.AsString;
    vParametros[25] := cdsSelecionarRegistroNOME_CIDADE.AsString;
    vParametros[26] := cdsSelecionarRegistroNOME_BAIRRO.AsString;
    vParametros[27] := cdsSelecionarRegistroNOME_RUA.AsString;
    vParametros[28] := cdsSelecionarRegistroCEP_RUA.AsString;
  end;

begin
  inherited;

  vParametros := VarArrayCreate([0,28],varVariant);
  CarregaDadosAgenciamento();
  try
    Application.CreateForm(TfrmExibeDadosAgenciamento, frmExibeDadosAgenciamento);
    frmExibeDadosAgenciamento.passarParametro(PRM_EXIBE_DADOS_AGENCIAMENTO,vParametros);
    frmExibeDadosAgenciamento.ShowModal;
  finally
    FreeAndNil(frmExibeDadosAgenciamento);
  end;
end;

end.
