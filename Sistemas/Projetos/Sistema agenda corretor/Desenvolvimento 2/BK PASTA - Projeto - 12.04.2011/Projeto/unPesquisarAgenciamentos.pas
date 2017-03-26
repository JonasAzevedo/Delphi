unit unPesquisarAgenciamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisa, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Mask,
  plsTMaskEdit, plsEdit, plsComboBox, DB, DBClient, Provider,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Menus;

type
  TfrmPesquisarAgenciamentos = class(TfrmPesquisar)
    lblCodigo: TLabel;
    rdGrpTipoAgenciamento: TRadioGroup;
    rdGrpTipoPessoa: TRadioGroup;
    lblCondicaoPagamento: TLabel;
    plsCbBxCondicaoPagamento: TPlsComboBox;
    plsEdCodigo: TPlsEdit;
    grpBxDataAgenciamento: TGroupBox;
    plsMedDataAgencInicio: TPlsMaskEdit;
    lblEntreDataAgenciamento: TLabel;
    plsMedDataAgencFinal: TPlsMaskEdit;
    grpBxDataBaixa: TGroupBox;
    plsMedDataBaixaInicio: TPlsMaskEdit;
    lblEntreDataBaixa: TLabel;
    plsMedDataBaixaFim: TPlsMaskEdit;
    grpBxPrazoAutorizacao: TGroupBox;
    lblEntrePrazoAutorizacao: TLabel;
    plsMedPrazoAutorizacaoInicio: TPlsMaskEdit;
    plsMedPrazoAutorizacaoFim: TPlsMaskEdit;
    grpBxValorTotal: TGroupBox;
    plsMedValorTotalInicio: TPlsEdit;
    plsMedValorTotalFim: TPlsEdit;
    lblEntreValorTotal: TLabel;
    zQryDadosCODIGO_AGENCIAMENTO: TIntegerField;
    zQryDadosDATA_AGENCIAMENTO: TDateField;
    zQryDadosATIVO_AGENCIAMENTO: TStringField;
    zQryDadosCC_CODIGO: TStringField;
    zQryDadosNORMAL: TStringField;
    zQryDadosSTAND_BY: TStringField;
    zQryDadosNORMAL_STANDBY: TStringField;
    zQryDadosTIPO_PESSOA: TStringField;
    zQryDadosNOME_TIPO_PESSOA: TStringField;
    zQryDadosCONDICAO_PAGAMENTO: TStringField;
    zQryDadosCC_VALOR_TOTAL_AGENCIAMENTO: TStringField;
    zQryDadosCC_PGTO_VISTA_CACH: TStringField;
    zQryDadosCC_PGTO_VISTA_VALOR_BEM: TStringField;
    zQryDadosCC_PGTO_VISTA_DESCRICAO_BEM: TStringField;
    zQryDadosCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField;
    zQryDadosCC_PGTO_FINCTO_CACH: TStringField;
    zQryDadosCC_PGTO_FINCTO_VALOR_BEM: TStringField;
    zQryDadosCC_PGTO_FINCTO_DESCRICAO_BEM: TStringField;
    zQryDadosOBSERVACAO_AGENCIAMENTO: TStringField;
    zQryDadosPRAZO_AUTORIZACAO: TDateField;
    zQryDadosDATA_REAGENCIAMENTO: TDateField;
    zQryDadosDATA_BAIXA: TDateField;
    zQryDadosCODIGO_PESSOA_FISICA: TIntegerField;
    zQryDadosNOME_PESSOA_FISICA: TStringField;
    zQryDadosCODIGO_PESSOA_JURIDICA: TIntegerField;
    zQryDadosNOME_PESSOA_JURIDICA: TStringField;
    zQryDadosCODIGO_IMOVEL: TIntegerField;
    zQryDadosSTATUS_IMOVEL: TSmallintField;
    zQryDadosSITUACAO_DESEJAVEL: TStringField;
    zQryDadosCC_VALOR_IMOVEL_IMOVEL: TStringField;
    zQryDadosDESCRICAO_IMOVEL: TStringField;
    zQryDadosCODIGO_TIPO_IMOVEL: TIntegerField;
    zQryDadosNOME_TIPO_IMOVEL: TStringField;
    zQryDadosCODIGO_ESTADO: TIntegerField;
    zQryDadosSIGLA_ESTADO: TStringField;
    zQryDadosCODIGO_CIDADE: TIntegerField;
    zQryDadosNOME_CIDADE: TStringField;
    zQryDadosCODIGO_BAIRRO: TIntegerField;
    zQryDadosNOME_BAIRRO: TStringField;
    zQryDadosCODIGO_RUA: TIntegerField;
    zQryDadosNOME_RUA: TStringField;
    zQryDadosCEP_RUA: TStringField;
    cdsDadosCODIGO_AGENCIAMENTO: TIntegerField;
    cdsDadosDATA_AGENCIAMENTO: TDateField;
    cdsDadosATIVO_AGENCIAMENTO: TStringField;
    cdsDadosCC_CODIGO: TStringField;
    cdsDadosNORMAL: TStringField;
    cdsDadosSTAND_BY: TStringField;
    cdsDadosNORMAL_STANDBY: TStringField;
    cdsDadosTIPO_PESSOA: TStringField;
    cdsDadosNOME_TIPO_PESSOA: TStringField;
    cdsDadosCONDICAO_PAGAMENTO: TStringField;
    cdsDadosCC_VALOR_TOTAL_AGENCIAMENTO: TStringField;
    cdsDadosCC_PGTO_VISTA_CACH: TStringField;
    cdsDadosCC_PGTO_VISTA_VALOR_BEM: TStringField;
    cdsDadosCC_PGTO_VISTA_DESCRICAO_BEM: TStringField;
    cdsDadosCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField;
    cdsDadosCC_PGTO_FINCTO_CACH: TStringField;
    cdsDadosCC_PGTO_FINCTO_VALOR_BEM: TStringField;
    cdsDadosCC_PGTO_FINCTO_DESCRICAO_BEM: TStringField;
    cdsDadosOBSERVACAO_AGENCIAMENTO: TStringField;
    cdsDadosPRAZO_AUTORIZACAO: TDateField;
    cdsDadosDATA_REAGENCIAMENTO: TDateField;
    cdsDadosDATA_BAIXA: TDateField;
    cdsDadosCODIGO_PESSOA_FISICA: TIntegerField;
    cdsDadosNOME_PESSOA_FISICA: TStringField;
    cdsDadosCODIGO_PESSOA_JURIDICA: TIntegerField;
    cdsDadosNOME_PESSOA_JURIDICA: TStringField;
    cdsDadosCODIGO_IMOVEL: TIntegerField;
    cdsDadosSTATUS_IMOVEL: TSmallintField;
    cdsDadosSITUACAO_DESEJAVEL: TStringField;
    cdsDadosCC_VALOR_IMOVEL_IMOVEL: TStringField;
    cdsDadosDESCRICAO_IMOVEL: TStringField;
    cdsDadosCODIGO_TIPO_IMOVEL: TIntegerField;
    cdsDadosNOME_TIPO_IMOVEL: TStringField;
    cdsDadosCODIGO_ESTADO: TIntegerField;
    cdsDadosSIGLA_ESTADO: TStringField;
    cdsDadosCODIGO_CIDADE: TIntegerField;
    cdsDadosNOME_CIDADE: TStringField;
    cdsDadosCODIGO_BAIRRO: TIntegerField;
    cdsDadosNOME_BAIRRO: TStringField;
    cdsDadosCODIGO_RUA: TIntegerField;
    cdsDadosNOME_RUA: TStringField;
    cdsDadosCEP_RUA: TStringField;
    lblStatus: TLabel;
    plsCbBxStatus: TPlsComboBox;
    ppMnDarBaixa: TMenuItem;
    ppMnDivisao: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure ppMnDarBaixaClick(Sender: TObject);
  private
    procedure BaixarImovelInteresse();  
  public
    procedure PassarParametro(pTipo:String; pValores:OleVariant); override;
  protected
    procedure SelecionarTodosDados(); override;
    procedure Pesquisar(); override;
    procedure FormatarValores(); override;
  end;

var
  frmPesquisarAgenciamentos: TfrmPesquisarAgenciamentos;

implementation

uses
  unConstantes, unDM;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmPesquisarAgenciamentos.PassarParametro(pTipo:String; pValores:OleVariant);
begin

end;

procedure TfrmPesquisarAgenciamentos.SelecionarTodosDados();
begin
  cdsDados.Close;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT a.codigo AS CODIGO_AGENCIAMENTO,a.data_agenciamento,');
  zQryDados.SQL.Add('a.ativo AS ATIVO_AGENCIAMENTO,CAST(a.codigo AS VARCHAR(10)) AS cc_codigo,');
  zQryDados.SQL.Add('a.normal,a.stand_by,');
  zQryDados.SQL.Add('CASE WHEN a.normal = ''SIM'' THEN ''NORMAL'' ELSE ''STAND BY'' ');
  zQryDados.SQL.Add('END AS NORMAL_STANDBY,a.tipo_pessoa,');
  zQryDados.SQL.Add('CASE WHEN a.tipo_pessoa = ''FÍSICA'' THEN pf.nome ');
  zQryDados.SQL.Add('WHEN a.tipo_pessoa = ''JURÍDICA'' THEN pj.nome ');
  zQryDados.SQL.Add('ELSE ''NENHUMA'' END AS NOME_TIPO_PESSOA,');
  zQryDados.SQL.Add('a.condicao_pagamento,CAST(a.valor_total  AS VARCHAR(20)) AS CC_VALOR_TOTAL_AGENCIAMENTO,');
  zQryDados.SQL.Add('CAST(a.pgto_vista_cach AS VARCHAR(20)) AS CC_PGTO_VISTA_CACH,');
  zQryDados.SQL.Add('CAST(a.pgto_vista_valor_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_VALOR_BEM,');
  zQryDados.SQL.Add('CAST(a.pgto_vista_descricao_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_DESCRICAO_BEM,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_cach_financiado AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH_FINANCIADO,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_cach AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_valor_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_VALOR_BEM,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_descricao_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_DESCRICAO_BEM,');
  zQryDados.SQL.Add('a.observacao AS OBSERVACAO_AGENCIAMENTO,a.prazo_autorizacao,a.data_reagenciamento,a.data_baixa,');
  zQryDados.SQL.Add('pf.codigo AS CODIGO_PESSOA_FISICA,pf.nome AS NOME_PESSOA_FISICA,');
  zQryDados.SQL.Add('pj.codigo AS CODIGO_PESSOA_JURIDICA,pj.nome AS NOME_PESSOA_JURIDICA,');
  zQryDados.SQL.Add('i.codigo AS CODIGO_IMOVEL,i.status AS STATUS_IMOVEL,i.situacao_desejavel,');
  zQryDados.SQL.Add('CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL_IMOVEL,');
  zQryDados.SQL.Add('i.descricao AS DESCRICAO_IMOVEL, ti.codigo AS CODIGO_TIPO_IMOVEL,');
  zQryDados.SQL.Add('ti.nome AS NOME_TIPO_IMOVEL,est.codigo AS CODIGO_ESTADO,est.sigla AS SIGLA_ESTADO,');
  zQryDados.SQL.Add('cid.codigo AS CODIGO_CIDADE,cid.nome AS NOME_CIDADE,bai.codigo AS CODIGO_BAIRRO,');
  zQryDados.SQL.Add('bai.nome AS NOME_BAIRRO,rua.codigo AS CODIGO_RUA,rua.nome AS NOME_RUA,');
  zQryDados.SQL.Add('rua.cep AS CEP_RUA ');
  zQryDados.SQL.Add('FROM agenciamentos a ');
  zQryDados.SQL.Add('LEFT JOIN agenc_pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo ');
  zQryDados.SQL.Add('LEFT JOIN agenc_pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo ');
  zQryDados.SQL.Add('JOIN imovel i ON a.cod_fk_imovel = i.codigo ');
  zQryDados.SQL.Add('JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ');
  zQryDados.SQL.Add('JOIN estado est ON i.cod_fk_estado = est.codigo ');
  zQryDados.SQL.Add('JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ');
  zQryDados.SQL.Add('JOIN bairro bai ON i.cod_fk_bairro = bai.codigo ');
  zQryDados.SQL.Add('JOIN rua rua ON i.cod_fk_rua = rua.codigo ');
  zQryDados.SQL.Add(Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('a'));
  zQryDados.SQL.Add('AND a.ativo = :ativo');
  zQryDados.ParamByName('ativo').AsString := VLR_SIM;
  zQryDados.SQL.Add('ORDER BY a.codigo');
  zQryDados.Open;
  cdsDados.Open;
end;

procedure TfrmPesquisarAgenciamentos.Pesquisar();
var
  nCodigo: Integer;
  sAtivo: String;
  dtDataAgenciamentoInicio,dtDataAgenciamentoFim: TDate;
  dtPrazoAutorizacaoInicio,dtPrazoAutorizacaoFim: TDate;
  dtDataBaixaInicio,dtDataBaixaFim: TDate;
  sTipoPessoa: String;
  sNormal,sStandBy: String;
  sCondicaoPagamento: String;
  dValorTotalInicio,dValorTotalFim: Currency;

  procedure CarregarValores();
  begin
    nCodigo := FoFuncoes.formatarValorInteiro(plsEdCodigo.Text);

    case plsCbBxStatus.ItemIndex of
      0: sAtivo := VLR_SIM;
      1: sAtivo := VLR_NAO;
      2: sAtivo := STRING_INDEFINIDO;
    else
       sAtivo := STRING_INDEFINIDO;
    end;

    dtDataAgenciamentoInicio := FoFuncoes.formatarData(plsMedDataAgencInicio.Text);
    dtDataAgenciamentoFim := FoFuncoes.formatarData(plsMedDataAgencFinal.Text);
    dtPrazoAutorizacaoInicio := FoFuncoes.formatarData(plsMedPrazoAutorizacaoInicio.Text);
    dtPrazoAutorizacaoFim := FoFuncoes.formatarData(plsMedPrazoAutorizacaoFim.Text);
    dtDataBaixaInicio := FoFuncoes.formatarData(plsMedDataBaixaInicio.Text);
    dtDataBaixaFim := FoFuncoes.formatarData(plsMedDataBaixaFim.Text);
    case rdGrpTipoPessoa.ItemIndex of
      0: sTipoPessoa := VLR_TP_PESSOA_FISICA;
      1: sTipoPessoa := VLR_TP_PESSOA_JURIDICA;
    else
      sTipoPessoa := STRING_INDEFINIDO;
    end;

    sNormal := STRING_INDEFINIDO;
    sStandBy := STRING_INDEFINIDO;
    case rdGrpTipoAgenciamento.ItemIndex of
      0:
      begin
        sNormal := VLR_SIM;
        sStandBy := VLR_NAO;
      end;
      1:
      begin
        sNormal := VLR_NAO;
        sStandBy := VLR_SIM;
      end;
    end;

    case plsCbBxCondicaoPagamento.ItemIndex of
      0: sCondicaoPagamento := VLR_CD_PAGAMENTO_VISTA;
      1: sCondicaoPagamento := VLR_CD_PAGAMENTO_ACEITA_FINANCIAMENTO;
    else
      sCondicaoPagamento := STRING_INDEFINIDO;
    end;

    dValorTotalInicio := FoFuncoes.formatarValorCurrency(plsMedValorTotalInicio.Text,True);
    dValorTotalFim := FoFuncoes.formatarValorCurrency(plsMedValorTotalFim.Text,True);
  end;

begin
  CarregarValores();

  cdsDados.Close;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT a.codigo AS CODIGO_AGENCIAMENTO,a.data_agenciamento,');
  zQryDados.SQL.Add('a.ativo AS ATIVO_AGENCIAMENTO,CAST(a.codigo AS VARCHAR(10)) AS cc_codigo,');
  zQryDados.SQL.Add('a.normal,a.stand_by,');
  zQryDados.SQL.Add('CASE WHEN a.normal = ''SIM'' THEN ''NORMAL'' ELSE ''STAND BY'' ');
  zQryDados.SQL.Add('END AS NORMAL_STANDBY,a.tipo_pessoa,');
  zQryDados.SQL.Add('CASE WHEN a.tipo_pessoa = ''FÍSICA'' THEN pf.nome ');
  zQryDados.SQL.Add('WHEN a.tipo_pessoa = ''JURÍDICA'' THEN pj.nome ');
  zQryDados.SQL.Add('ELSE ''NENHUMA'' END AS NOME_TIPO_PESSOA,');
  zQryDados.SQL.Add('a.condicao_pagamento,CAST(a.valor_total  AS VARCHAR(20)) AS CC_VALOR_TOTAL_AGENCIAMENTO,');
  zQryDados.SQL.Add('CAST(a.pgto_vista_cach AS VARCHAR(20)) AS CC_PGTO_VISTA_CACH,');
  zQryDados.SQL.Add('CAST(a.pgto_vista_valor_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_VALOR_BEM,');
  zQryDados.SQL.Add('CAST(a.pgto_vista_descricao_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_DESCRICAO_BEM,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_cach_financiado AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH_FINANCIADO,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_cach AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_valor_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_VALOR_BEM,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_descricao_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_DESCRICAO_BEM,');
  zQryDados.SQL.Add('a.observacao AS OBSERVACAO_AGENCIAMENTO,a.prazo_autorizacao,a.data_reagenciamento,a.data_baixa,');
  zQryDados.SQL.Add('pf.codigo AS CODIGO_PESSOA_FISICA,pf.nome AS NOME_PESSOA_FISICA,');
  zQryDados.SQL.Add('pj.codigo AS CODIGO_PESSOA_JURIDICA,pj.nome AS NOME_PESSOA_JURIDICA,');
  zQryDados.SQL.Add('i.codigo AS CODIGO_IMOVEL,i.status AS STATUS_IMOVEL,i.situacao_desejavel,');
  zQryDados.SQL.Add('CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL_IMOVEL,');
  zQryDados.SQL.Add('i.descricao AS DESCRICAO_IMOVEL, ti.codigo AS CODIGO_TIPO_IMOVEL,');
  zQryDados.SQL.Add('ti.nome AS NOME_TIPO_IMOVEL,est.codigo AS CODIGO_ESTADO,est.sigla AS SIGLA_ESTADO,');
  zQryDados.SQL.Add('cid.codigo AS CODIGO_CIDADE,cid.nome AS NOME_CIDADE,bai.codigo AS CODIGO_BAIRRO,');
  zQryDados.SQL.Add('bai.nome AS NOME_BAIRRO,rua.codigo AS CODIGO_RUA,rua.nome AS NOME_RUA,');
  zQryDados.SQL.Add('rua.cep AS CEP_RUA ');
  zQryDados.SQL.Add('FROM agenciamentos a ');
  zQryDados.SQL.Add('LEFT JOIN agenc_pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo ');
  zQryDados.SQL.Add('LEFT JOIN agenc_pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo ');
  zQryDados.SQL.Add('JOIN imovel i ON a.cod_fk_imovel = i.codigo ');
  zQryDados.SQL.Add('JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ');
  zQryDados.SQL.Add('JOIN estado est ON i.cod_fk_estado = est.codigo ');
  zQryDados.SQL.Add('JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ');
  zQryDados.SQL.Add('JOIN bairro bai ON i.cod_fk_bairro = bai.codigo ');
  zQryDados.SQL.Add('JOIN rua rua ON i.cod_fk_rua = rua.codigo ');
  zQryDados.SQL.Add(Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('a'));
  if(nCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.codigo = :codigo ');
    zQryDados.ParamByName('codigo').AsInteger := nCodigo;
  end;

  if(sAtivo <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.ativo = :ativo ');
    zQryDados.ParamByName('ativo').AsString := sAtivo;
  end;

  if(dtDataAgenciamentoInicio <> NUMERO_INDEFINIDO)and(dtDataAgenciamentoFim <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.data_agenciamento BETWEEN :dtAgencInicio AND :dtAgencFim ');
    zQryDados.ParamByName('dtAgencInicio').AsDate := dtDataAgenciamentoInicio;
    zQryDados.ParamByName('dtAgencFim').AsDate := dtDataAgenciamentoFim;
  end;

  if(dtPrazoAutorizacaoInicio <> NUMERO_INDEFINIDO)and(dtPrazoAutorizacaoFim <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.prazo_autorizacao BETWEEN :dtPrazoAutInicio AND :dtPrazoAutFim ');
    zQryDados.ParamByName('dtPrazoAutInicio').AsDate := dtPrazoAutorizacaoInicio;
    zQryDados.ParamByName('dtPrazoAut').AsDate := dtPrazoAutorizacaoFim;
  end;

  if(dtDataBaixaInicio <> NUMERO_INDEFINIDO)and(dtDataBaixaFim <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.data_baixa BETWEEN :dtDataBaixaInicio AND :dtDataBaixaFim ');
    zQryDados.ParamByName('dtDataBaixaInicio').AsDate := dtDataBaixaFim;
    zQryDados.ParamByName('dtDataBaixaFim').AsDate := dtDataBaixaFim;
  end;

  if(sTipoPessoa <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.tipo_pessoa = :tipo_pessoa ');
    zQryDados.ParamByName('tipo_pessoa').AsString := sTipoPessoa;
  end;

  if(sNormal <> STRING_INDEFINIDO)and(sStandBy <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.normal = :normal AND stand_by =:stand_by ');
    zQryDados.ParamByName('normal').AsString := sNormal;
    zQryDados.ParamByName('stand_by').AsString := sStandBy;
  end;

  if(sCondicaoPagamento <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.condicao_pagamento =:condicao_pagamento ');
    zQryDados.ParamByName('condicao_pagamento').AsString := sCondicaoPagamento;
  end;

  if(dValorTotalInicio <> NUMERO_INDEFINIDO)and(dValorTotalFim <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.valor_total BETWEEN :valorTotalInicio AND :valorTotalFim ');
    zQryDados.ParamByName('valorTotalInicio').AsCurrency := dValorTotalInicio;
    zQryDados.ParamByName('valorTotalFim').AsCurrency := dValorTotalFim;
  end;

  zQryDados.SQL.Add('ORDER BY a.codigo');
  zQryDados.Open;
  cdsDados.Open;

  VerificaEncontrouRegistros();
end;

procedure TfrmPesquisarAgenciamentos.FormatarValores();
var
  sValorMonetario: String;
begin
  if((cdsDados.Active)and(cdsDados.RecordCount>0))then
  begin
    cdsDados.First;
    while(not(cdsDados.Eof))do
    begin
      cdsDados.Edit;

      sValorMonetario :=  cdsDadosCC_VALOR_TOTAL_AGENCIAMENTO.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsDadosCC_VALOR_TOTAL_AGENCIAMENTO.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsDadosCC_PGTO_VISTA_CACH.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsDadosCC_PGTO_VISTA_CACH.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsDadosCC_PGTO_VISTA_VALOR_BEM.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsDadosCC_PGTO_VISTA_VALOR_BEM.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsDadosCC_PGTO_FINCTO_CACH_FINANCIADO.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsDadosCC_PGTO_FINCTO_CACH_FINANCIADO.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsDadosCC_PGTO_FINCTO_CACH.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsDadosCC_PGTO_FINCTO_CACH.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsDadosCC_PGTO_FINCTO_VALOR_BEM.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsDadosCC_PGTO_FINCTO_VALOR_BEM.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      sValorMonetario :=  cdsDadosCC_VALOR_IMOVEL_IMOVEL.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsDadosCC_VALOR_IMOVEL_IMOVEL.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

      if(Self.FoFuncoes.verificaCEP_EhVazio(cdsDadosCEP_RUA.AsString))then
        cdsDadosCEP_RUA.AsString := STRING_INDEFINIDO;

      cdsDados.Post;

      cdsDados.Next;
    end;
  end;
end;

procedure TfrmPesquisarAgenciamentos.BaixarImovelInteresse();
var
  nCodigo: Integer;
  sPessoa: String;
begin
  try
    nCodigo := cdsDados.FieldByName('CODIGO_AGENCIAMENTO').AsInteger;
    sPessoa := cdsDados.FieldByName('NOME_TIPO_PESSOA').AsString;
  except
    nCodigo := NUMERO_INDEFINIDO;
  end;

  if(nCodigo <> NUMERO_INDEFINIDO)and(nCodigo <> REGISTRO_NULO)then
  begin
    if(MessageDlg('Deseja baixar o agenciamento da pessoa ' + sPessoa + ' ?',
      mtConfirmation, [mbYes,mbNo], 0)=mrYes)then
    begin
      try
        DM.ZConnection.StartTransaction;
        DM.zQryAgenciamentos.Close;
        DM.zQryAgenciamentos.SQL.Clear;
        DM.zQryAgenciamentos.SQL.Add('UPDATE agenciamentos ');
        DM.zQryAgenciamentos.SQL.Add('SET ativo = :ativo ');
        DM.zQryAgenciamentos.SQL.Add('WHERE codigo = :codigo');
        DM.zQryAgenciamentos.ParamByName('ativo').AsString := VLR_NAO;
        DM.zQryAgenciamentos.ParamByName('codigo').AsInteger := nCodigo;
        DM.zQryAgenciamentos.ExecSQL();
        DM.ZConnection.Commit;
      except
        DM.ZConnection.Rollback;
      end;
      Pesquisar();
    end;
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmPesquisarAgenciamentos.FormShow(Sender: TObject);
begin
  inherited;
  plsCbBxStatus.ItemIndex := 0;
end;

procedure TfrmPesquisarAgenciamentos.ppMnDarBaixaClick(Sender: TObject);
begin
  inherited;
  BaixarImovelInteresse();
end;

end.
