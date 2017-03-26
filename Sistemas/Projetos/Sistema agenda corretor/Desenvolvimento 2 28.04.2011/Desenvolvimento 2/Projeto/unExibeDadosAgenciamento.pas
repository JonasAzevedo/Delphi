unit unExibeDadosAgenciamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unExibeDados, StdCtrls, Buttons, ExtCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmExibeDadosAgenciamento = class(TfrmExibeDados)
    lblImovel: TLabel;
    lblAgenciamento: TLabel;
    pnlDadosAgenciamento: TPanel;
    pnlPagamentoFinanciado: TPanel;
    lblNomePgtoFnctoCachFinanciado: TLabel;
    lblNomePgtoFnctoCach: TLabel;
    lblNomePgtoFnctoValorBem: TLabel;
    lblNomePgtoFnctoDescricaoBem: TLabel;
    lblPgtoFnctoDescricaoBem: TLabel;
    lblPgtoFnctoValorBem: TLabel;
    lblPgtoFnctoCach: TLabel;
    lblPgtoFnctoCachFinanciado: TLabel;
    lblObservacaoAgenciamento: TLabel;
    lblNomeObservacaoAgenciamento: TLabel;
    pnlPagamentoVista: TPanel;
    lblNomePgtoVista: TLabel;
    lblPgtoVistaCach: TLabel;
    lblNomePgtoVistaValorBem: TLabel;
    lblPgtoVistaValorBem: TLabel;
    lblPgtoVistaDescricaoBem: TLabel;
    lblNomePgtoVistaDescricaoBem: TLabel;
    lblCondicaoPagamento: TLabel;
    pbpNomeCondicaoPagamento: TLabel;
    lblNomeValorTotalAgenciamento: TLabel;
    lblValorTotal: TLabel;
    lblNomePessoa: TLabel;
    lblNomeNomePessoa: TLabel;
    lblTipoPessoa: TLabel;
    lblNomeTipoPessoa: TLabel;
    lblNomeDataAgenciamento: TLabel;
    lblNomeCodigoAgenciamento: TLabel;
    lblCodigoAgenciamento: TLabel;
    lblNomeAtivo: TLabel;
    lblAtivo: TLabel;
    lblDataAgenciamento: TLabel;
    lblNomePrazoAutorizacao: TLabel;
    lblNomeNormalStandBy: TLabel;
    lblNormalStandBy: TLabel;
    lblPrazoAutorizacao: TLabel;
    lblNomeDataReagenciamento: TLabel;
    lblDataReagenciamento: TLabel;
    pnlImovel: TPanel;
    lblTipoImovel: TLabel;
    lblUF: TLabel;
    lblNomeUF: TLabel;
    lblNomeBairro: TLabel;
    lblSituacaoDesejavel: TLabel;
    lblStatus: TLabel;
    lblBairro: TLabel;
    lblNomeCidade: TLabel;
    lblNomeRua: TLabel;
    lblCEP: TLabel;
    lblRua: TLabel;
    lblNomeCEP: TLabel;
    lblNomeSituacaoDesejavel: TLabel;
    lblNomeDescricao: TLabel;
    lblDescricao: TLabel;
    lblNomeStatus: TLabel;
    lblValorImovel: TLabel;
    lblCodigoImovel: TLabel;
    lblNomeCodigoImovel: TLabel;
    lblNomeValorImovel: TLabel;
    lblNomeTipoImovel: TLabel;
    lblCidade: TLabel;
    zQryAgenciamento: TZQuery;
    zQryAgenciamentoCODIGO_AGENCIAMENTO: TIntegerField;
    zQryAgenciamentoCOD_FK_PESSOA_FISICA: TIntegerField;
    zQryAgenciamentoCOD_FK_PESSOA_JURIDICA: TIntegerField;
    zQryAgenciamentoCOD_FK_IMOVEL: TIntegerField;
    zQryAgenciamentoATIVO: TStringField;
    zQryAgenciamentoNORMAL: TStringField;
    zQryAgenciamentoSTAND_BY: TStringField;
    zQryAgenciamentoDATA_AGENCIAMENTO: TDateField;
    zQryAgenciamentoPRAZO_AUTORIZACAO: TDateField;
    zQryAgenciamentoDATA_REAGENCIAMENTO: TDateField;
    zQryAgenciamentoTIPO_PESSOA: TStringField;
    zQryAgenciamentoNOMEPESSOAFISICA: TStringField;
    zQryAgenciamentoNOMEPESSOAJURIDICA: TStringField;
    zQryAgenciamentoVALOR_TOTAL: TFloatField;
    zQryAgenciamentoCONDICAO_PAGAMENTO: TStringField;
    zQryAgenciamentoPGTO_VISTA_CACH: TFloatField;
    zQryAgenciamentoPGTO_VISTA_VALOR_BEM: TFloatField;
    zQryAgenciamentoPGTO_VISTA_DESCRICAO_BEM: TStringField;
    zQryAgenciamentoPGTO_FINCTO_CACH_FINANCIADO: TFloatField;
    zQryAgenciamentoPGTO_FINCTO_CACH: TFloatField;
    zQryAgenciamentoPGTO_FINCTO_VALOR_BEM: TFloatField;
    zQryAgenciamentoPGTO_FINCTO_DESCRICAO_BEM: TStringField;
    zQryAgenciamentoOBSERVACAO_AGENCIAMENTO: TStringField;
    zQryAgenciamentoCODIGO_IMOVEL: TIntegerField;
    zQryAgenciamentoCOD_FK_TIPO_IMOVEL: TIntegerField;
    zQryAgenciamentoCOD_FK_ESTADO: TIntegerField;
    zQryAgenciamentoCOD_FK_CIDADE: TIntegerField;
    zQryAgenciamentoCOD_FK_BAIRRO: TIntegerField;
    zQryAgenciamentoCOD_FK_RUA: TIntegerField;
    zQryAgenciamentoSTATUS: TSmallintField;
    zQryAgenciamentoSITUACAO_DESEJAVEL: TStringField;
    zQryAgenciamentoVALOR_IMOVEL: TFloatField;
    zQryAgenciamentoDESCRICAO_IMOVEL: TStringField;
    zQryAgenciamentoNOMETIPOIMOVEL: TStringField;
    zQryAgenciamentoNOMEESTADO: TStringField;
    zQryAgenciamentoSIGLA: TStringField;
    zQryAgenciamentoNOMECIDADE: TStringField;
    zQryAgenciamentoNOMEBAIRRO: TStringField;
    zQryAgenciamentoNOMERUA: TStringField;
    zQryAgenciamentoCEPRUA: TStringField;
  private
    procedure PesquisarAgenciamento(pnCodAgenciamento:Integer);
    procedure MostrarDadosAgenciamento;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); dynamic; //passando parâmetros
  end;

var
  frmExibeDadosAgenciamento: TfrmExibeDadosAgenciamento;

implementation

uses
  unConstantes, unDM;

{$R *.dfm}

procedure TfrmExibeDadosAgenciamento.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_EXIBE_DADOS_AGENCIAMENTO)then
  begin
    lblCodigoAgenciamento.Caption := pValores[0];
    lblAtivo.Caption := pValores[1];
    lblNormalStandBy.Caption := pValores[2];
    lblDataAgenciamento.Caption := pValores[3];
    lblPrazoAutorizacao.Caption := pValores[4];
    lblDataReagenciamento.Caption := pValores[5];
    lblTipoPessoa.Caption := pValores[6];
    lblNomePessoa.Caption := pValores[7];
    lblValorTotal.Caption := Self.FoFuncoes.formatarValorMonetario(pValores[8]);
    lblCondicaoPagamento.Caption := pValores[9];
    if(pValores[9] = 'VISTA')then
    begin
      pnlPagamentoVista.Visible := True;
      pnlPagamentoVista.Left := 5;
      pnlPagamentoVista.Top := 132;
      pnlPagamentoFinanciado.Visible := False;
      lblPgtoVistaCach.Caption := Self.FoFuncoes.formatarValorMonetario(pValores[10]);
      lblPgtoVistaValorBem.Caption := Self.FoFuncoes.formatarValorMonetario(pValores[11]);
      lblPgtoVistaDescricaoBem.Caption := pValores[12];
    end
    else if(pValores[9] = 'ACEITA FINANCIAMENTO')then
    begin
      pnlPagamentoFinanciado.Visible := True;
      pnlPagamentoFinanciado.Left := 5;
      pnlPagamentoFinanciado.Top := 132;
      pnlPagamentoVista.Visible := False;
      lblPgtoFnctoCachFinanciado.Caption := Self.FoFuncoes.formatarValorMonetario(pValores[13]);
      lblPgtoFnctoCach.Caption := Self.FoFuncoes.formatarValorMonetario(pValores[14]);
      lblPgtoFnctoValorBem.Caption := Self.FoFuncoes.formatarValorMonetario(pValores[15]);
      lblPgtoFnctoDescricaoBem.Caption := pValores[16];
    end;
    lblObservacaoAgenciamento.Caption := pValores[17];

    lblCodigoImovel.Caption := pValores[18];
    lblStatus.Caption := pValores[19];
    lblSituacaoDesejavel.Caption := pValores[20];
    lblTipoImovel.Caption := pValores[21];
    lblValorImovel.Caption := Self.FoFuncoes.formatarValorMonetario(pValores[22]);
    lblDescricao.Caption := pValores[23];
    lblUF.Caption := pValores[24];
    lblCidade.Caption := pValores[25];
    lblBairro.Caption := pValores[26];
    lblRua.Caption := pValores[27];
    lblCEP.Caption := pValores[28];
  end

  else if(pTipo = PRM_PESQUISAR_AGENCIAMENTO)then
  begin
    if(VarIsNumeric(pValores))then
      PesquisarAgenciamento(pValores);
  end;
end;

procedure TfrmExibeDadosAgenciamento.PesquisarAgenciamento(pnCodAgenciamento:Integer);
begin
  zQryAgenciamento.Close;
  zQryAgenciamento.SQL.Clear;
  zQryAgenciamento.SQL.Add('SELECT a.codigo AS codigo_agenciamento,a.cod_fk_pessoa_fisica,');
  zQryAgenciamento.SQL.Add('a.cod_fk_pessoa_juridica,a.cod_fk_imovel,a.ativo,a.normal,a.stand_by,');
  zQryAgenciamento.SQL.Add('a.data_agenciamento,a.prazo_autorizacao,a.data_reagenciamento,a.tipo_pessoa,');
  zQryAgenciamento.SQL.Add('pf.nome AS nomePessoaFisica,pj.nome AS nomePessoaJuridica,a.valor_total,');
  zQryAgenciamento.SQL.Add('a.condicao_pagamento,a.pgto_vista_cach,a.pgto_vista_valor_bem,a.pgto_vista_descricao_bem,');
  zQryAgenciamento.SQL.Add('a.pgto_fincto_cach_financiado,a.pgto_fincto_cach,a.pgto_fincto_valor_bem,');
  zQryAgenciamento.SQL.Add('a.pgto_fincto_descricao_bem,a.observacao AS observacao_agenciamento,');
  zQryAgenciamento.SQL.Add('i.codigo AS codigo_imovel,i.cod_fk_tipo_imovel,i.cod_fk_estado,i.cod_fk_cidade,');
  zQryAgenciamento.SQL.Add('i.cod_fk_bairro,i.cod_fk_rua,i.status,i.situacao_desejavel,i.valor_imovel,');
  zQryAgenciamento.SQL.Add('i.descricao AS descricao_imovel,ti.nome AS nomeTipoImovel,est.nome AS nomeEstado,est.sigla,');
  zQryAgenciamento.SQL.Add('cid.nome AS nomeCidade,bai.nome AS nomeBairro,rua.nome AS nomeRua,rua.cep AS cepRua ');
  zQryAgenciamento.SQL.Add('FROM agenciamentos a ');
  zQryAgenciamento.SQL.Add('JOIN agenc_pessoa_fisica pf ON a.cod_fk_pessoa_fisica = pf.codigo ');
  zQryAgenciamento.SQL.Add('JOIN agenc_pessoa_juridica pj ON a.cod_fk_pessoa_juridica = pj.codigo ');
  zQryAgenciamento.SQL.Add('JOIN imovel i ON a.cod_fk_imovel = i.codigo ');
  zQryAgenciamento.SQL.Add('JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ');
  zQryAgenciamento.SQL.Add('JOIN estado est ON i.cod_fk_estado = est.codigo ');
  zQryAgenciamento.SQL.Add('JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ');
  zQryAgenciamento.SQL.Add('JOIN bairro bai ON i.cod_fk_bairro = bai.codigo ');
  zQryAgenciamento.SQL.Add('JOIN rua rua ON i.cod_fk_rua = rua.codigo ');
  zQryAgenciamento.SQL.Add('WHERE a.codigo =:codigo');
  zQryAgenciamento.ParamByName('codigo').AsInteger := pnCodAgenciamento;
  zQryAgenciamento.Open;
  if(zQryAgenciamento.Active)and(zQryAgenciamento.RecordCount=1)then
    MostrarDadosAgenciamento
  else
  begin
    MessageDlg('Agenciamento não encontrado.',mtInformation,[mbOK],0);
    //Self.Close;
  end;
end;

procedure TfrmExibeDadosAgenciamento.MostrarDadosAgenciamento;

  function GetNormalStandBy:String;
  begin
    if(zQryAgenciamentoNORMAL.AsString=VLR_SIM)then
      Result := 'NORMAL'
    else if(zQryAgenciamentoSTAND_BY.AsString=VLR_SIM)then
      Result := 'STAND BY'
    else
      Result := STRING_INDEFINIDO;
  end;

  function GetNomePessoa:String;
  begin
    if(zQryAgenciamentoTIPO_PESSOA.AsString=VLR_TP_PESSOA_FISICA)then
      Result := zQryAgenciamentoNOMEPESSOAFISICA.AsString
    else if(zQryAgenciamentoTIPO_PESSOA.AsString=VLR_TP_PESSOA_JURIDICA)then
      Result := zQryAgenciamentoNOMEPESSOAJURIDICA.AsString
    else
      Result := STRING_INDEFINIDO;
  end;

begin
  lblCodigoAgenciamento.Caption := zQryAgenciamentoCODIGO_AGENCIAMENTO.AsString;
  lblAtivo.Caption := zQryAgenciamentoATIVO.AsString;
  lblNormalStandBy.Caption := GetNormalStandBy;
  lblDataAgenciamento.Caption := zQryAgenciamentoDATA_AGENCIAMENTO.AsString;
  lblPrazoAutorizacao.Caption := zQryAgenciamentoPRAZO_AUTORIZACAO.AsString;
  lblDataReagenciamento.Caption := zQryAgenciamentoDATA_REAGENCIAMENTO.AsString;
  lblTipoPessoa.Caption := zQryAgenciamentoTIPO_PESSOA.AsString;
  lblNomePessoa.Caption := GetNomePessoa;
  lblValorTotal.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoVALOR_TOTAL.AsString);
  lblCondicaoPagamento.Caption := zQryAgenciamentoCONDICAO_PAGAMENTO.AsString;
  if(zQryAgenciamentoCONDICAO_PAGAMENTO.AsString = 'VISTA')then
  begin
    pnlPagamentoVista.Visible := True;
    pnlPagamentoVista.Left := 5;
    pnlPagamentoVista.Top := 132;
    pnlPagamentoFinanciado.Visible := False;
    lblPgtoVistaCach.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoPGTO_VISTA_CACH.AsString);
    lblPgtoVistaValorBem.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoPGTO_VISTA_VALOR_BEM.AsString);
    lblPgtoVistaDescricaoBem.Caption := zQryAgenciamentoPGTO_VISTA_DESCRICAO_BEM.AsString;
  end
  else if(zQryAgenciamentoCONDICAO_PAGAMENTO.AsString = 'ACEITA FINANCIAMENTO')then
  begin
    pnlPagamentoFinanciado.Visible := True;
    pnlPagamentoFinanciado.Left := 5;
    pnlPagamentoFinanciado.Top := 132;
    pnlPagamentoVista.Visible := False;
    lblPgtoFnctoCachFinanciado.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoPGTO_FINCTO_CACH_FINANCIADO.AsString);
    lblPgtoFnctoCach.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoPGTO_FINCTO_CACH.AsString);
    lblPgtoFnctoValorBem.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoPGTO_FINCTO_VALOR_BEM.AsString);
    lblPgtoFnctoDescricaoBem.Caption := zQryAgenciamentoPGTO_FINCTO_DESCRICAO_BEM.AsString;
  end;
  lblObservacaoAgenciamento.Caption := zQryAgenciamentoOBSERVACAO_AGENCIAMENTO.AsString;

  lblCodigoImovel.Caption := zQryAgenciamentoCOD_FK_IMOVEL.AsString;
  lblStatus.Caption := zQryAgenciamentoSTATUS.AsString;
  lblSituacaoDesejavel.Caption := zQryAgenciamentoSITUACAO_DESEJAVEL.AsString;
  lblTipoImovel.Caption := zQryAgenciamentoNOMETIPOIMOVEL.AsString;
  lblValorImovel.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoVALOR_IMOVEL.AsString);
  lblDescricao.Caption := zQryAgenciamentoDESCRICAO_IMOVEL.AsString;
  lblUF.Caption := zQryAgenciamentoSIGLA.AsString;
  lblCidade.Caption := zQryAgenciamentoNOMECIDADE.AsString;
  lblBairro.Caption := zQryAgenciamentoNOMEBAIRRO.AsString;
  lblRua.Caption := zQryAgenciamentoNOMERUA.AsString;
  lblCEP.Caption := zQryAgenciamentoCEPRUA.AsString;
end;

end.
