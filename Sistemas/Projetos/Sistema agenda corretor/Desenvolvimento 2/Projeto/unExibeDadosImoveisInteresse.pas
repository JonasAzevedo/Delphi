unit unExibeDadosImoveisInteresse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unExibeDados, StdCtrls, Buttons, ExtCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmExibeDadosImoveisInteresse = class(TfrmExibeDados)
    pnlDadosImovelInteresse: TPanel;
    lblObservacao: TLabel;
    lblNomeObservacao: TLabel;
    lblCondicaoPagamento: TLabel;
    pbpNomeCondicaoPagamento: TLabel;
    lblNomeValorImovel: TLabel;
    lblValorImovel: TLabel;
    lblNomePessoa: TLabel;
    lblNomeNomePessoa: TLabel;
    lblTipoPessoa: TLabel;
    lblNomeTipoPessoa: TLabel;
    lblNomeCodigoImovelInteresse: TLabel;
    lblCodigoImovelInteresse: TLabel;
    lblNomeAtivo: TLabel;
    lblAtivo: TLabel;
    lblNomeDataCadastro: TLabel;
    lblDataCadastro: TLabel;
    lblDataCaptacao: TLabel;
    lblNomeDataCaptacao: TLabel;
    lblNomeTipoImovel: TLabel;
    lblTipoImovel: TLabel;
    lblFinalidadeImovel: TLabel;
    lblNomeFinalidadeImovel: TLabel;
    lblNomeDesejavel: TLabel;
    lblDesejavel: TLabel;
    lblNomeDataBaixa: TLabel;
    lblDataBaixa: TLabel;
    lblCaracteristicas: TLabel;
    lblNomeCaracteristicas: TLabel;
    lblRegioesLocalidades: TLabel;
    lblNomeRegioesLocalidades: TLabel;
    pnlPagamentoFinanciado: TPanel;
    lblNomePgtoFnctoCachFinanciado: TLabel;
    lblNomePgtoFnctoCach: TLabel;
    lblNomePgtoFnctoValorBem: TLabel;
    lblNomePgtoFnctoDescricaoBem: TLabel;
    lblPgtoFnctoDescricaoBem: TLabel;
    lblPgtoFnctoValorBem: TLabel;
    lblPgtoFnctoCach: TLabel;
    lblPgtoFnctoCachFinanciado: TLabel;
    pnlPagamentoVista: TPanel;
    lblNomePgtoVista: TLabel;
    lblPgtoVistaCach: TLabel;
    lblNomePgtoVistaValorBem: TLabel;
    lblPgtoVistaValorBem: TLabel;
    lblPgtoVistaDescricaoBem: TLabel;
    lblNomePgtoVistaDescricaoBem: TLabel;
    lblAgenciamento: TLabel;
    lblImovelInteresse: TLabel;
    zQryImovelInteresse: TZQuery;
    zQryRegiaoLocalidade: TZQuery;
    zQryRegiaoLocalidadeCODIGO: TIntegerField;
    zQryRegiaoLocalidadeCOD_FK_IMOVEL_DE_INTERESSE: TIntegerField;
    zQryRegiaoLocalidadeCOD_FK_REGIAO_LOCALIDADE: TIntegerField;
    zQryRegiaoLocalidadeNOMEREGIAOLOCALIDADE: TStringField;
    zQryImovelInteresseCODIMOVINTERESSE: TIntegerField;
    zQryImovelInteresseATIVO: TStringField;
    zQryImovelInteresseDATA_CADASTRO: TDateField;
    zQryImovelInteresseDATA_CAPTACAO: TDateField;
    zQryImovelInteresseDATA_BAIXA: TDateTimeField;
    zQryImovelInteresseTIPO_PESSOA: TStringField;
    zQryImovelInteresseNOME_TIPO_PESSOA: TStringField;
    zQryImovelInteresseNOMETIPOIMOVEL: TStringField;
    zQryImovelInteresseFINALIDADE_IMOVEL: TStringField;
    zQryImovelInteresseIMOVEL_DESEJAVEL: TStringField;
    zQryImovelInteresseVALOR_IMOVEL: TFloatField;
    zQryImovelInteresseCONDICAO_PAGAMENTO: TStringField;
    zQryImovelInteressePGTO_VISTA_CACH: TFloatField;
    zQryImovelInteressePGTO_VISTA_VALOR_BEM: TFloatField;
    zQryImovelInteressePGTO_VISTA_DESCRICAO_BEM: TStringField;
    zQryImovelInteressePGTO_FINCTO_CACH: TFloatField;
    zQryImovelInteressePGTO_FINCTO_CACH_FINANCIADO: TFloatField;
    zQryImovelInteressePGTO_FINCTO_VALOR_BEM: TFloatField;
    zQryImovelInteressePGTO_FINCTO_DESCRICAO_BEM: TStringField;
    zQryImovelInteresseOBSERVACAO: TStringField;
    zQryImovelInteresseCARACTERISTICAS: TStringField;
  private
    procedure PesquisarImovelInteresse(pnCodImovelInteresse:Integer);
    procedure MostrarDadosImovelInteresse;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); dynamic; //passando parâmetros
  end;

var
  frmExibeDadosImoveisInteresse: TfrmExibeDadosImoveisInteresse;

implementation

uses
  unConstantes, unDM;

{$R *.dfm}

procedure TfrmExibeDadosImoveisInteresse.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_PESQUISAR_IMOVEL_INTERESSE)then
  begin
    if(VarIsNumeric(pValores))then
      PesquisarImovelInteresse(pValores);
  end;
end;

procedure TfrmExibeDadosImoveisInteresse.PesquisarImovelInteresse(pnCodImovelInteresse:Integer);

  procedure PesquisarRegioesLocalidades;
  begin
    zQryRegiaoLocalidade.Close;
    zQryRegiaoLocalidade.SQL.Clear;
    zQryRegiaoLocalidade.SQL.Add('SELECT iirl.codigo,iirl.cod_fk_imovel_de_interesse,iirl.cod_fk_regiao_localidade,');
    zQryRegiaoLocalidade.SQL.Add('rl.nome AS nomeRegiaoLocalidade ');
    zQryRegiaoLocalidade.SQL.Add('FROM imov_interesse_regiao_local iirl ');
    zQryRegiaoLocalidade.SQL.Add('JOIN regiao_localidade rl ON iirl.cod_fk_regiao_localidade=rl.codigo ');
    zQryRegiaoLocalidade.SQL.Add('WHERE iirl.cod_fk_imovel_de_interesse=:cod_fk_imovel_de_interesse');
    zQryRegiaoLocalidade.ParamByName('cod_fk_imovel_de_interesse').AsInteger := pnCodImovelInteresse;
    zQryRegiaoLocalidade.Open;
  end;

begin
  zQryImovelInteresse.Close;
  zQryImovelInteresse.SQL.Clear;
  zQryImovelInteresse.SQL.Add('SELECT ii.codigo AS codImovInteresse,ii.ativo,');
  zQryImovelInteresse.SQL.Add('CAST(ii.data_cadastro AS DATE) AS data_cadastro,ii.data_captacao,ii.data_baixa,');
  zQryImovelInteresse.SQL.Add('ii.tipo_pessoa,');
  zQryImovelInteresse.SQL.Add('CASE WHEN ii.tipo_pessoa =''FÍSICA'' THEN pf.nome ');
  zQryImovelInteresse.SQL.Add('WHEN ii.tipo_pessoa = ''JURÍDICA'' THEN pj.nome ');
  zQryImovelInteresse.SQL.Add('ELSE ''NENHUMA'' END AS NOME_TIPO_PESSOA,');
  zQryImovelInteresse.SQL.Add('t.nome AS nomeTipoImovel,');
  zQryImovelInteresse.SQL.Add('ii.finalidade_imovel,ii.imovel_desejavel,');
  zQryImovelInteresse.SQL.Add('ii.valor_imovel,ii.condicao_pagamento,');
  zQryImovelInteresse.SQL.Add('ii.pgto_vista_cach,ii.pgto_vista_valor_bem,ii.pgto_vista_descricao_bem,');
  zQryImovelInteresse.SQL.Add('ii.pgto_fincto_cach,ii.pgto_fincto_cach_financiado,ii.pgto_fincto_valor_bem,ii.pgto_fincto_descricao_bem,');
  zQryImovelInteresse.SQL.Add('ii.observacao,ii.caracteristicas ');
  zQryImovelInteresse.SQL.Add('FROM imovel_de_interesse ii ');
  zQryImovelInteresse.SQL.Add('JOIN tipo_imovel t ON ii.cod_fk_tipo_imovel=t.codigo ');
  zQryImovelInteresse.SQL.Add('LEFT JOIN agenc_pessoa_fisica pf ON ii.cod_fk_cliente_pessoa_fisica = pf.codigo ');
  zQryImovelInteresse.SQL.Add('LEFT JOIN agenc_pessoa_juridica pj ON ii.cod_fk_cliente_pessoa_juridica = pj.codigo ');
  zQryImovelInteresse.SQL.Add('WHERE ii.codigo=:codigo');
  zQryImovelInteresse.ParamByName('codigo').AsInteger := pnCodImovelInteresse;
  zQryImovelInteresse.Open;
  if(zQryImovelInteresse.Active)and(zQryImovelInteresse.RecordCount=1)then
  begin
    PesquisarRegioesLocalidades;
    MostrarDadosImovelInteresse;
  end
  else
  begin
    MessageDlg('Imóvel de Interesse não encontrado.',mtInformation,[mbOK],0);
    //Self.Close;
  end;
end;

procedure TfrmExibeDadosImoveisInteresse.MostrarDadosImovelInteresse;

  function GetRegioesLocalidades:String;
  var
    sRetorno: String;
  begin
    sRetorno := STRING_INDEFINIDO;
    if(zQryRegiaoLocalidade.Active)and(zQryRegiaoLocalidade.RecordCount > NUMERO_INDEFINIDO)then
    begin
      zQryRegiaoLocalidade.First;
      while not(zQryRegiaoLocalidade.Eof)do
      begin
        if(sRetorno <> STRING_INDEFINIDO)then
          sRetorno := sRetorno + ', ';
        sRetorno := sRetorno + zQryRegiaoLocalidadeNOMEREGIAOLOCALIDADE.AsString;
        zQryRegiaoLocalidade.Next;
      end;
    end;
    Result := sRetorno;
  end;

begin
  lblCodigoImovelInteresse.Caption := zQryImovelInteresseCODIMOVINTERESSE.AsString;
  lblAtivo.Caption := zQryImovelInteresseATIVO.AsString;
  lblDataCadastro.Caption := zQryImovelInteresseDATA_CADASTRO.AsString;
  lblDataCaptacao.Caption := zQryImovelInteresseDATA_CAPTACAO.AsString;
  lblDataBaixa.Caption := zQryImovelInteresseDATA_BAIXA.AsString;
  lblTipoPessoa.Caption := zQryImovelInteresseTIPO_PESSOA.AsString;
  lblNomePessoa.Caption := zQryImovelInteresseNOME_TIPO_PESSOA.AsString;
  lblTipoImovel.Caption := zQryImovelInteresseNOMETIPOIMOVEL.AsString;
  lblFinalidadeImovel.Caption := zQryImovelInteresseFINALIDADE_IMOVEL.AsString;
  lblDesejavel.Caption := zQryImovelInteresseIMOVEL_DESEJAVEL.AsString;
  lblValorImovel.Caption := FoFuncoes.formatarValorMonetario(zQryImovelInteresseVALOR_IMOVEL.AsString);
  lblCondicaoPagamento.Caption := zQryImovelInteresseCONDICAO_PAGAMENTO.AsString;
  if(zQryImovelInteresseCONDICAO_PAGAMENTO.AsString = 'VISTA')then
  begin
    pnlPagamentoVista.Visible := True;
    pnlPagamentoFinanciado.Visible := False;
    lblPgtoVistaCach.Caption := FoFuncoes.formatarValorMonetario(zQryImovelInteressePGTO_VISTA_CACH.AsString);
    lblPgtoVistaValorBem.Caption := FoFuncoes.formatarValorMonetario(zQryImovelInteressePGTO_VISTA_VALOR_BEM.AsString);
    lblPgtoVistaDescricaoBem.Caption := zQryImovelInteressePGTO_VISTA_DESCRICAO_BEM.AsString;
  end
  else if(zQryImovelInteresseCONDICAO_PAGAMENTO.AsString = 'ACEITA FINANCIAMENTO')then
  begin
    pnlPagamentoFinanciado.Visible := True;
    pnlPagamentoVista.Visible := False;
    lblPgtoFnctoCach.Caption := FoFuncoes.formatarValorMonetario(zQryImovelInteressePGTO_FINCTO_CACH.AsString);
    lblPgtoFnctoCachFinanciado.Caption := FoFuncoes.formatarValorMonetario(zQryImovelInteressePGTO_FINCTO_CACH_FINANCIADO.AsString);
    lblPgtoFnctoValorBem.Caption := FoFuncoes.formatarValorMonetario(zQryImovelInteressePGTO_FINCTO_VALOR_BEM.AsString);
    lblPgtoFnctoDescricaoBem.Caption := zQryImovelInteressePGTO_FINCTO_DESCRICAO_BEM.AsString;
  end;
  lblObservacao.Caption := zQryImovelInteresseOBSERVACAO.AsString;
  lblCaracteristicas.Caption := zQryImovelInteresseCARACTERISTICAS.AsString;
  lblRegioesLocalidades.Caption := GetRegioesLocalidades;
end;


end.
