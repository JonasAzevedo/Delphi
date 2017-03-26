unit unExibirImoveisInteresseParaAgenciamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, ExtCtrls, ImgList, DB,
  DBClient, ZAbstractRODataset, ZAbstractDataset, ZDataset, AppEvnts,unFuncoes;

type
    TControlaFonteGride = record
      campo: String; //campo verifica se o valor é 'igual'
      isIgual: Boolean;
    end;

type
  TfrmImoveisInteresseParaAgenciamento = class(TForm)
    grpBxAgenciamento: TGroupBox;
    lblInfNormalStandBy: TLabel;
    lblInfCodigoAgenciamento: TLabel;
    lblCodigoAgenciamento: TLabel;
    lblInfDataAgenciamento: TLabel;
    lblDataAgenciamento: TLabel;
    lblNormalStandBy: TLabel;
    lblInfValorTotal: TLabel;
    lblValorTotal: TLabel;
    lblInfAtivo: TLabel;
    lblAtivo: TLabel;
    lblNomePessoa: TLabel;
    lblInfCondicaoPagamento: TLabel;
    lblInfTipoPessoa: TLabel;
    lblCondicaoPagamento: TLabel;
    lblTipoPessoa: TLabel;
    lblInfObservacao: TLabel;
    lblObservacao: TLabel;
    pnlDivisao: TPanel;
    pnlAgenciamentos: TPanel;
    lblDescricaoTela: TLabel;
    lblAbrirExplicacaoRelevancia: TLabel;
    lblFiltrar: TLabel;
    dbGrdImoveisInteresse: TDBGrid;
    ckBxTipoImovelIgual: TCheckBox;
    ckBxSituacaoIgual: TCheckBox;
    ckBxCondPgtoIgual: TCheckBox;
    ckBxValorIgual: TCheckBox;
    ckBxCaracImovelIgual: TCheckBox;
    ckBxRegiaoLocalidadeIgual: TCheckBox;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    zQryAgenciamento: TZQuery;
    cdsImoveisInteresseFixo: TClientDataSet;
    cdsImoveisInteresse: TClientDataSet;
    dsImoveisInteresse: TDataSource;
    ImageList: TImageList;
    zQryCompletarImoveisInteresse: TZQuery;
    pnlPgtoVista: TPanel;
    lblInfVistaCach: TLabel;
    lblVistaCach: TLabel;
    lblVistaValorBem: TLabel;
    lblInfVistaValorBem: TLabel;
    lblVistaDescricaoBem: TLabel;
    lblInfVistaDescricaoBem: TLabel;
    pnlPgtoFinanciado: TPanel;
    lblInfFnctoCach: TLabel;
    lblFnctoCach: TLabel;
    lblFnctoValorBem: TLabel;
    lblInfFnctoValorBem: TLabel;
    lblFnctoDescricaoBem: TLabel;
    lblInfFnctoDescricaoBem: TLabel;
    lblFnctoCachFinanciado: TLabel;
    lblInfFnctoCachFinanciado: TLabel;
    lblInfPrazoAutorizacao: TLabel;
    lblPrazoAutorizacao: TLabel;
    lblDataReagenciamento: TLabel;
    lblInfDataReagenciamento: TLabel;
    lblInfDataBaixa: TLabel;
    lblDataBaixa: TLabel;
    lblInfImovel: TLabel;
    lblInfStatus: TLabel;
    lblStatus: TLabel;
    lblInfSituacaoDesejavel: TLabel;
    lblSituacaoDesejavel: TLabel;
    lblInfDescricao: TLabel;
    lblDescricao: TLabel;
    lblInfTipoImovel: TLabel;
    lblTipoImovel: TLabel;
    lblInfUF: TLabel;
    lblUF: TLabel;
    lblInfCidade: TLabel;
    lblCidade: TLabel;
    lblInfBairro: TLabel;
    lblBairro: TLabel;
    lblInfRua: TLabel;
    lblRua: TLabel;
    lblInfCEP: TLabel;
    lblCEP: TLabel;
    lblInfComplemento: TLabel;
    lblComplemento: TLabel;
    zQryAgenciamentoCODIGO: TIntegerField;
    zQryAgenciamentoDATA_AGENCIAMENTO: TDateField;
    zQryAgenciamentoATIVO: TStringField;
    zQryAgenciamentoNORMAL: TStringField;
    zQryAgenciamentoSTAND_BY: TStringField;
    zQryAgenciamentoTIPO_PESSOA: TStringField;
    zQryAgenciamentoNOME_TIPO_PESSOA: TStringField;
    zQryAgenciamentoCONDICAO_PAGAMENTO: TStringField;
    zQryAgenciamentoVALOR_TOTAL: TFloatField;
    zQryAgenciamentoPGTO_VISTA_CACH: TFloatField;
    zQryAgenciamentoPGTO_VISTA_VALOR_BEM: TFloatField;
    zQryAgenciamentoPGTO_VISTA_DESCRICAO_BEM: TStringField;
    zQryAgenciamentoPGTO_FINCTO_CACH: TFloatField;
    zQryAgenciamentoPGTO_FINCTO_CACH_FINANCIADO: TFloatField;
    zQryAgenciamentoPGTO_FINCTO_VALOR_BEM: TFloatField;
    zQryAgenciamentoPGTO_FINCTO_DESCRICAO_BEM: TStringField;
    zQryAgenciamentoOBSERVACAO: TStringField;
    zQryAgenciamentoPRAZO_AUTORIZACAO: TDateField;
    zQryAgenciamentoDATA_REAGENCIAMENTO: TDateField;
    zQryAgenciamentoDATA_BAIXA: TDateField;
    zQryAgenciamentoCODIGOIMOVEL: TIntegerField;
    zQryAgenciamentoSTATUS: TSmallintField;
    zQryAgenciamentoSITUACAO_DESEJAVEL: TStringField;
    zQryAgenciamentoDESCRICAO: TStringField;
    zQryAgenciamentoENDERECO_CEP: TStringField;
    zQryAgenciamentoENDERECO_COMPLEMENTO: TStringField;
    zQryAgenciamentoNOMETIPOIMOVEL: TStringField;
    zQryAgenciamentoNOMEESTADO: TStringField;
    zQryAgenciamentoSIGLAESTADO: TStringField;
    zQryAgenciamentoNOMECIDADE: TStringField;
    zQryAgenciamentoNOMEBAIRRO: TStringField;
    zQryAgenciamentoNOMERUA: TStringField;
    zQryAgenciamentoCEPRUA: TStringField;
    zQryCompletarImoveisInteresseCODIGO: TIntegerField;
    zQryCompletarImoveisInteresseCONDICAO_PAGAMENTO: TStringField;
    zQryCompletarImoveisInteresseVALOR_IMOVEL: TFloatField;
    zQryCompletarImoveisInteresseIMOVEL_DESEJAVEL: TStringField;
    zQryCompletarImoveisInteresseCARACTERISTICAS: TStringField;
    zQryCompletarImoveisInteresseNOMETIPOIMOVEL: TStringField;
    zQryCompletarRegiaoLocalidade: TZQuery;
    zQryCompletarRegiaoLocalidadeCOD_FK_IMOVEL_DE_INTERESSE: TIntegerField;
    zQryCompletarRegiaoLocalidadeNOMEREGIAOLOCALIDADE: TStringField;
    lblTotalRegistros: TLabel;
    procedure dbGrdImoveisInteresseDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbGrdImoveisInteresseDblClick(Sender: TObject);
    procedure dbGrdImoveisInteresseTitleClick(Column: TColumn);
    procedure cdsImoveisInteresseAfterScroll(DataSet: TDataSet);
    procedure lblAbrirExplicacaoRelevanciaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ckBxTipoImovelIgualClick(Sender: TObject);
    procedure ckBxSituacaoIgualClick(Sender: TObject);
    procedure ckBxCondPgtoIgualClick(Sender: TObject);
    procedure ckBxValorIgualClick(Sender: TObject);
    procedure ckBxCaracImovelIgualClick(Sender: TObject);
    procedure ckBxRegiaoLocalidadeIgualClick(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
    FnCodAgenciamento: Integer;
    FoControlaFonteGride: TControlaFonteGride;
    procedure LimparControlaFonteGride;

    procedure CriarDataSetImovelInteresse;
    procedure ExibirDetalhesImovelInteresse;
    procedure SelecionarMostrarDadosAgenciamento;
    procedure DetalharNecessidadesAtendidas;
    procedure PovoarDadosEmBracoDataSet;
    procedure FiltrarImoveisInteresse;
    procedure CriarIndiceOrdenarPeso;
    procedure MostrarTotalRegistros;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant);
  end;

var
  frmImoveisInteresseParaAgenciamento: TfrmImoveisInteresseParaAgenciamento;

implementation

uses unConstantes, unDM, unExplicacao, unExibeDadosImoveisInteresse;

{$R *.dfm}

{ TfrmImoveisInteresseParaAgenciamento }

(* procedimentos de controle *)

procedure TfrmImoveisInteresseParaAgenciamento.passarParametro(
  pTipo: String; pValores: OleVariant);
var
  cdsAux: TClientDataSet;
begin
  if(pTipo = PRM_PASSAR_CODIGO_AGENCIAMENTO)then
  begin
    if(VarIsNumeric(pValores))then
      FnCodAgenciamento := pValores
    else
      FnCodAgenciamento := NUMERO_INDEFINIDO;
    SelecionarMostrarDadosAgenciamento;
  end

  else if(pTipo = PRM_PASSAR_DATA_SET)then
  begin
    try
      cdsAux := TClientDataSet.Create(nil);
      cdsAux.Data := pValores;
      CriarDataSetImovelInteresse;
      if(cdsAux.Active)and(cdsAux.RecordCount > NUMERO_INDEFINIDO)then
      begin
        cdsAux.First;
        while not(cdsAux.Eof)do
        begin
          cdsImoveisInteresse.Append;
          cdsImoveisInteresse.FieldByName('CODIGO').AsInteger := cdsAux.FieldByName('CODIGO').AsInteger;
          cdsImoveisInteresse.FieldByName('IGUAL_TIPO_IMOVEL').AsInteger := cdsAux.FieldByName('IGUAL_TIPO_IMOVEL').AsInteger;
          cdsImoveisInteresse.FieldByName('VALOR_TIPO_IMOVEL').AsString := cdsAux.FieldByName('VALOR_TIPO_IMOVEL').AsString;
          cdsImoveisInteresse.FieldByName('IGUAL_SITUACAO').AsInteger := cdsAux.FieldByName('IGUAL_SITUACAO').AsInteger;
          cdsImoveisInteresse.FieldByName('VALOR_SITUACAO').AsString := cdsAux.FieldByName('VALOR_SITUACAO').AsString;
          cdsImoveisInteresse.FieldByName('IGUAL_CONDICAO_PAGAMENTO').AsInteger := cdsAux.FieldByName('IGUAL_CONDICAO_PAGAMENTO').AsInteger;
          cdsImoveisInteresse.FieldByName('VALOR_CONDICAO_PAGAMENTO').AsString := cdsAux.FieldByName('VALOR_CONDICAO_PAGAMENTO').AsString;
          cdsImoveisInteresse.FieldByName('IGUAL_VALOR').AsInteger := cdsAux.FieldByName('IGUAL_VALOR').AsInteger;
          cdsImoveisInteresse.FieldByName('VALOR_VALOR').AsString := cdsAux.FieldByName('VALOR_VALOR').AsString;
          cdsImoveisInteresse.FieldByName('IGUAL_CARACTERISTICAS_IMOVEL').AsInteger := cdsAux.FieldByName('IGUAL_CARACTERISTICAS_IMOVEL').AsInteger;
          cdsImoveisInteresse.FieldByName('VALOR_CARACTERISTICAS_IMOVEL').AsString := cdsAux.FieldByName('VALOR_CARACTERISTICAS_IMOVEL').AsString;
          cdsImoveisInteresse.FieldByName('IGUAL_REGIAO_LOCALIDADE').AsInteger := cdsAux.FieldByName('IGUAL_REGIAO_LOCALIDADE').AsInteger;
          cdsImoveisInteresse.FieldByName('VALOR_REGIAO_LOCALIDADE').AsString := cdsAux.FieldByName('VALOR_REGIAO_LOCALIDADE').AsString;
          cdsImoveisInteresse.FieldByName('PESO').AsInteger := cdsAux.FieldByName('PESO').AsInteger;
          cdsImoveisInteresse.Post;
          cdsAux.Next;
        end;
        PovoarDadosEmBracoDataSet;
        FoFuncoes.FormatarValorMonetarioEmBloco(cdsImoveisInteresse,'VALOR_VALOR');
        //FoFuncoes.AjustarLarguraColunasTDBGrid(dbGrdAgenciamento);
        cdsImoveisInteresseFixo.Data := cdsImoveisInteresse.Data;
        CriarIndiceOrdenarPeso;
        MostrarTotalRegistros;
        cdsImoveisInteresse.First;
      end;
    finally
      FreeAndNil(cdsAux);
    end;
  end;
end;

procedure TfrmImoveisInteresseParaAgenciamento.LimparControlaFonteGride;
begin
  FoControlaFonteGride.campo := STRING_INDEFINIDO;
  FoControlaFonteGride.isIgual := False;
end;

procedure TfrmImoveisInteresseParaAgenciamento.CriarDataSetImovelInteresse;
begin
  if cdsImoveisInteresse.Active then
    cdsImoveisInteresse.EmptyDataSet;
  cdsImoveisInteresse.FieldDefs.Add('CODIGO', ftInteger, 0, True); //código do agenciamento
  cdsImoveisInteresse.FieldDefs.Add('IGUAL_TIPO_IMOVEL', ftInteger, 0, False); //tipo do imóvel igual
  cdsImoveisInteresse.FieldDefs.Add('VALOR_TIPO_IMOVEL', ftString, 60, False); //valor do tipo do imóvel
  cdsImoveisInteresse.FieldDefs.Add('IGUAL_SITUACAO', ftInteger, 0, False); //situação do imóvel igual
  cdsImoveisInteresse.FieldDefs.Add('VALOR_SITUACAO', ftString, 20, False); //valor da situação
  cdsImoveisInteresse.FieldDefs.Add('IGUAL_CONDICAO_PAGAMENTO', ftInteger, 0, False); //condição de pagamento igual
  cdsImoveisInteresse.FieldDefs.Add('VALOR_CONDICAO_PAGAMENTO', ftString, 20, False); //valor da condição de pagamento
  cdsImoveisInteresse.FieldDefs.Add('IGUAL_VALOR', ftInteger, 0, False); //valor igual
  cdsImoveisInteresse.FieldDefs.Add('VALOR_VALOR', ftString, 20, False); //valor do valor
  cdsImoveisInteresse.FieldDefs.Add('IGUAL_CARACTERISTICAS_IMOVEL', ftInteger, 0, False); //características do imóvel igual
  cdsImoveisInteresse.FieldDefs.Add('VALOR_CARACTERISTICAS_IMOVEL', ftString, 500, False); //valor das características do imóvel
  cdsImoveisInteresse.FieldDefs.Add('IGUAL_REGIAO_LOCALIDADE', ftInteger, 0, False); //região localidade do imóvel igual
  cdsImoveisInteresse.FieldDefs.Add('VALOR_REGIAO_LOCALIDADE', ftString, 500, False); //valor das regiões localidades do imóvel
  cdsImoveisInteresse.FieldDefs.Add('PESO', ftInteger, 0, False); //peso do agenciamento
  cdsImoveisInteresse.CreateDataSet;
end;

procedure TfrmImoveisInteresseParaAgenciamento.ExibirDetalhesImovelInteresse;
begin
  try
    Application.CreateForm(TfrmExibeDadosImoveisInteresse,frmExibeDadosImoveisInteresse);
    frmExibeDadosImoveisInteresse.passarParametro(PRM_PESQUISAR_IMOVEL_INTERESSE,cdsImoveisInteresse.FieldByName('CODIGO').AsInteger);
    frmExibeDadosImoveisInteresse.ShowModal;
  finally
    FreeAndNil(frmExibeDadosImoveisInteresse);
  end;
end;

procedure TfrmImoveisInteresseParaAgenciamento.SelecionarMostrarDadosAgenciamento;

  function GetNormalStandBy: String;
  begin
    if zQryAgenciamentoNORMAL.AsString = VLR_SIM then
      Result := 'NORMAL'
    else if zQryAgenciamentoSTAND_BY.AsString = VLR_SIM then
      Result := 'STAND BY'
    else
      Result := STRING_INDEFINIDO;
  end;

begin
  if(FnCodAgenciamento <> NUMERO_INDEFINIDO)then
  begin
    //dados do agenciamento
    zQryAgenciamento.Close;
    zQryAgenciamento.SQL.Clear;
    zQryAgenciamento.SQL.Add('SELECT a.codigo,a.data_agenciamento,a.ativo,a.normal,a.stand_by,');
    zQryAgenciamento.SQL.Add('a.tipo_pessoa,');
    zQryAgenciamento.SQL.Add('CASE WHEN a.tipo_pessoa =''FÍSICA'' THEN apf.nome ');
    zQryAgenciamento.SQL.Add('WHEN a.tipo_pessoa = ''JURÍDICA'' THEN apj.nome ');
    zQryAgenciamento.SQL.Add('ELSE ''NENHUMA'' END AS NOME_TIPO_PESSOA,');
    zQryAgenciamento.SQL.Add('a.condicao_pagamento,a.valor_total,');
    zQryAgenciamento.SQL.Add('a.pgto_vista_cach,a.pgto_vista_valor_bem,a.pgto_vista_descricao_bem,');
    zQryAgenciamento.SQL.Add('a.pgto_fincto_cach,a.pgto_fincto_cach_financiado,a.pgto_fincto_valor_bem,a.pgto_fincto_descricao_bem,');
    zQryAgenciamento.SQL.Add('a.observacao,a.prazo_autorizacao,a.data_reagenciamento,a.data_baixa,');
    zQryAgenciamento.SQL.Add('i.codigo AS codigoImovel,');
    zQryAgenciamento.SQL.Add('i.status,i.situacao_desejavel,i.descricao,');
    zQryAgenciamento.SQL.Add('i.endereco_cep,i.endereco_complemento,');
    zQryAgenciamento.SQL.Add('ti.nome AS nomeTipoImovel,');
    zQryAgenciamento.SQL.Add('e.nome AS nomeEstado,e.sigla AS siglaEstado,');
    zQryAgenciamento.SQL.Add('c.nome AS nomeCidade,');
    zQryAgenciamento.SQL.Add('b.nome AS nomeBairro,');
    zQryAgenciamento.SQL.Add('r.nome AS nomeRua,r.cep AS cepRua');
    zQryAgenciamento.SQL.Add('FROM agenciamentos a ');
    zQryAgenciamento.SQL.Add('LEFT JOIN agenc_pessoa_fisica apf ON a.cod_fk_pessoa_fisica=apf.codigo ');
    zQryAgenciamento.SQL.Add('LEFT JOIN agenc_pessoa_juridica apj ON a.cod_fk_pessoa_juridica=apj.codigo ');
    zQryAgenciamento.SQL.Add('JOIN imovel i ON a.cod_fk_imovel=i.codigo ');
    zQryAgenciamento.SQL.Add('JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel=ti.codigo ');
    zQryAgenciamento.SQL.Add('JOIN estado e ON i.cod_fk_estado=e.codigo ');
    zQryAgenciamento.SQL.Add('JOIN cidade c ON i.cod_fk_cidade=c.codigo ');
    zQryAgenciamento.SQL.Add('JOIN bairro b ON i.cod_fk_bairro=b.codigo ');
    zQryAgenciamento.SQL.Add('JOIN rua r ON i.cod_fk_rua=r.codigo ');
    zQryAgenciamento.SQL.Add('WHERE a.codigo=:codigo');
    zQryAgenciamento.ParamByName('codigo').AsInteger := FnCodAgenciamento;
    zQryAgenciamento.Open;
    if(zQryAgenciamento.Active)and(zQryAgenciamento.RecordCount = 1)then
    begin
      lblCodigoAgenciamento.Caption := zQryAgenciamentoCODIGO.AsString;
      lblAtivo.Caption := zQryAgenciamentoATIVO.AsString;
      lblNormalStandBy.Caption := GetNormalStandBy;
      lblDataAgenciamento.Caption := zQryAgenciamentoDATA_AGENCIAMENTO.AsString;
      lblPrazoAutorizacao.Caption := zQryAgenciamentoPRAZO_AUTORIZACAO.AsString;
      lblDataReagenciamento.Caption := zQryAgenciamentoDATA_REAGENCIAMENTO.AsString;
      lblDataBaixa.Caption := zQryAgenciamentoDATA_BAIXA.AsString;
      lblTipoPessoa.Caption := zQryAgenciamentoTIPO_PESSOA.AsString;
      lblNomePessoa.Caption := zQryAgenciamentoNOME_TIPO_PESSOA.AsString;
      lblCondicaoPagamento.Caption := zQryAgenciamentoCONDICAO_PAGAMENTO.AsString;
      lblValorTotal.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoVALOR_TOTAL.AsString);
      if zQryAgenciamentoCONDICAO_PAGAMENTO.AsString = VLR_CD_PAGAMENTO_VISTA then
      begin
        pnlPgtoVista.Visible := True;
        pnlPgtoFinanciado.Visible := False;
        lblVistaCach.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoPGTO_VISTA_CACH.AsString);
        lblVistaValorBem.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoPGTO_VISTA_VALOR_BEM.AsString);
        lblVistaDescricaoBem.Caption := zQryAgenciamentoPGTO_VISTA_DESCRICAO_BEM.AsString;

      end
      else if zQryAgenciamentoCONDICAO_PAGAMENTO.AsString = VLR_CD_PAGAMENTO_ACEITA_FINANCIAMENTO then
      begin
        pnlPgtoVista.Visible := True;
        pnlPgtoFinanciado.Visible := False;
        lblFnctoCach.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoPGTO_FINCTO_CACH.AsString);
        lblFnctoCachFinanciado.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoPGTO_FINCTO_CACH_FINANCIADO.AsString);
        lblFnctoValorBem.Caption := FoFuncoes.formatarValorMonetario(zQryAgenciamentoPGTO_FINCTO_VALOR_BEM.AsString);
        lblFnctoDescricaoBem.Caption := zQryAgenciamentoPGTO_FINCTO_DESCRICAO_BEM.AsString;
      end
      else
      begin
        pnlPgtoVista.Visible := False;
        pnlPgtoFinanciado.Visible := False;
      end;
      lblObservacao.Caption := zQryAgenciamentoOBSERVACAO.AsString;
      //imóvel
      lblStatus.Caption := zQryAgenciamentoSTATUS.AsString;
      lblSituacaoDesejavel.Caption := zQryAgenciamentoSITUACAO_DESEJAVEL.AsString;
      lblDescricao.Caption := zQryAgenciamentoDESCRICAO.AsString;
      lblTipoImovel.Caption := zQryAgenciamentoNOMETIPOIMOVEL.AsString;
      lblUF.Caption := zQryAgenciamentoSIGLAESTADO.AsString;
      lblCidade.Caption := zQryAgenciamentoNOMECIDADE.AsString;
      lblBairro.Caption := zQryAgenciamentoNOMEBAIRRO.AsString;
      lblRua.Caption := zQryAgenciamentoNOMERUA.AsString;
      lblCEP.Caption := zQryAgenciamentoCEPRUA.AsString;
      lblComplemento.Caption := zQryAgenciamentoENDERECO_COMPLEMENTO.AsString;
    end;
  end;
end;

procedure TfrmImoveisInteresseParaAgenciamento.DetalharNecessidadesAtendidas;

  function GetColor(sCampo:String): TColor;
  begin
    Result := clBlack; //default
    if(cdsImoveisInteresse.FieldByName(sCampo).AsString = '1')then
      Result := clRed;
  end;

  function GetFontStyle(sCampo:string): TFontStyle;
  begin
//    Result := ; //default
    if(cdsImoveisInteresse.FieldByName(sCampo).AsString = '1')then
      Result := fsBold;
  end;

begin
  lblTipoImovel.Font.Color := GetColor('IGUAL_TIPO_IMOVEL');
  lblTipoImovel.Font.Style := [GetFontStyle('IGUAL_TIPO_IMOVEL')];

  lblSituacaoDesejavel.Font.Color := GetColor('IGUAL_SITUACAO');
  lblSituacaoDesejavel.Font.Style := [GetFontStyle('IGUAL_SITUACAO')];

  lblCondicaoPagamento.Font.Color := GetColor('IGUAL_CONDICAO_PAGAMENTO');
  lblCondicaoPagamento.Font.Style := [GetFontStyle('IGUAL_CONDICAO_PAGAMENTO')];

  lblValorTotal.Font.Color := GetColor('IGUAL_VALOR');
  lblValorTotal.Font.Style := [GetFontStyle('IGUAL_VALOR')];

  lblDescricao.Font.Color := GetColor('IGUAL_CARACTERISTICAS_IMOVEL');
  lblDescricao.Font.Style := [GetFontStyle('IGUAL_CARACTERISTICAS_IMOVEL')];

  lblUF.Font.Color := GetColor('IGUAL_REGIAO_LOCALIDADE');
  lblUF.Font.Style := [GetFontStyle('IGUAL_REGIAO_LOCALIDADE')];
  lblCidade.Font.Color := lblUF.Font.Color;
  lblCidade.Font.Style := lblUF.Font.Style;
  lblBairro.Font.Color := lblUF.Font.Color;
  lblBairro.Font.Style := lblUF.Font.Style;
  lblRua.Font.Color := lblUF.Font.Color;
  lblRua.Font.Style := lblUF.Font.Style;
  lblCEP.Font.Color := lblUF.Font.Color;
  lblCEP.Font.Style := lblUF.Font.Style;
  lblComplemento.Font.Color := lblUF.Font.Color;
  lblComplemento.Font.Style := lblUF.Font.Style;
end;

procedure TfrmImoveisInteresseParaAgenciamento.PovoarDadosEmBracoDataSet;
var
  sCodImoveisInteresse: String;
  sCondicaoImovelInteresse: String;

  function GetRegiaoLocalidade(pnCodImovelInteresse:Integer):String;
  var
    sRetorno: String;
    sFiltro: String;
  begin
    sRetorno := STRING_INDEFINIDO;
    if(zQryCompletarRegiaoLocalidade.Active)and(zQryCompletarRegiaoLocalidade.RecordCount > NUMERO_INDEFINIDO)then
    begin
      zQryCompletarRegiaoLocalidade.First;
      sFiltro := 'COD_FK_IMOVEL_DE_INTERESSE = ' + IntToStr(pnCodImovelInteresse);
      zQryCompletarRegiaoLocalidade.Filter := sFiltro;
      zQryCompletarRegiaoLocalidade.Filtered := True;
      if(zQryCompletarRegiaoLocalidade.Active)and(zQryCompletarRegiaoLocalidade.RecordCount > NUMERO_INDEFINIDO)then
      begin
        zQryCompletarRegiaoLocalidade.First;
        while not(zQryCompletarRegiaoLocalidade.Eof)do
        begin
          if (sRetorno <> STRING_INDEFINIDO)then
            sRetorno := sRetorno + ', ';
          sRetorno := sRetorno +  zQryCompletarRegiaoLocalidadeNOMEREGIAOLOCALIDADE.AsString;
          zQryCompletarRegiaoLocalidade.Next;
        end;
      end;
    end;
    Result := sRetorno;
  end;

begin
  sCodImoveisInteresse := STRING_INDEFINIDO;
  sCondicaoImovelInteresse := STRING_INDEFINIDO;

  if(cdsImoveisInteresse.Active)and(cdsImoveisInteresse.RecordCount > NUMERO_INDEFINIDO)then
  begin
    //pegando código dos imóveis de interesse
    cdsImoveisInteresse.First;
    while not(cdsImoveisInteresse.Eof)do
    begin
      if(sCodImoveisInteresse <> STRING_INDEFINIDO)then
        sCodImoveisInteresse := sCodImoveisInteresse + ',';
      sCodImoveisInteresse := sCodImoveisInteresse + cdsImoveisInteresse.FieldByName('CODIGO').AsString;
      cdsImoveisInteresse.Next;
    end;

    //selecionando imóveis de interesse
    sCondicaoImovelInteresse := 'WHERE ii.codigo IN (' +sCodImoveisInteresse+ ')';
    zQryCompletarImoveisInteresse.Close;
    zQryCompletarImoveisInteresse.SQL.Clear;
    zQryCompletarImoveisInteresse.SQL.Add('SELECT ii.codigo,ii.condicao_pagamento,ii.valor_imovel,');
    zQryCompletarImoveisInteresse.SQL.Add('ii.imovel_desejavel,ii.caracteristicas,t.nome AS nomeTipoImovel ');
    zQryCompletarImoveisInteresse.SQL.Add('FROM imovel_de_interesse ii ');
    zQryCompletarImoveisInteresse.SQL.Add('JOIN tipo_imovel t ON ii.cod_fk_tipo_imovel=t.codigo ');
    zQryCompletarImoveisInteresse.SQL.Add(sCondicaoImovelInteresse);
    zQryCompletarImoveisInteresse.Open;

    //selecionando regiões localidade
    sCondicaoImovelInteresse := 'WHERE iirl.cod_fk_imovel_de_interesse IN (' +sCodImoveisInteresse+ ')';
    zQryCompletarRegiaoLocalidade.Close;
    zQryCompletarRegiaoLocalidade.SQL.Clear;
    zQryCompletarRegiaoLocalidade.SQL.Add('SELECT iirl.cod_fk_imovel_de_interesse, rl.nome as nomeRegiaoLocalidade ');
    zQryCompletarRegiaoLocalidade.SQL.Add('FROM regiao_localidade rl ');
    zQryCompletarRegiaoLocalidade.SQL.Add('JOIN imov_interesse_regiao_local iirl ON iirl.cod_fk_regiao_localidade=rl.codigo ');
    zQryCompletarRegiaoLocalidade.SQL.Add(sCondicaoImovelInteresse);
    zQryCompletarRegiaoLocalidade.Open;

    //povoando o clientDataSet cdsImoveisInteresse
    if(zQryCompletarImoveisInteresse.Active)and(zQryCompletarImoveisInteresse.RecordCount > NUMERO_INDEFINIDO)then
    begin
      zQryCompletarImoveisInteresse.First;
      while not(zQryCompletarImoveisInteresse.Eof)do
      begin
        cdsImoveisInteresse.First;
        if(cdsImoveisInteresse.Locate('CODIGO',zQryCompletarImoveisInteresseCODIGO.AsInteger,[]))then
        begin
          cdsImoveisInteresse.Edit;
          if(cdsImoveisInteresse.FieldByName('IGUAL_TIPO_IMOVEL').AsInteger = VLR_DESLIGADO)then
            cdsImoveisInteresse.FieldByName('VALOR_TIPO_IMOVEL').AsString := zQryCompletarImoveisInteresseNOMETIPOIMOVEL.AsString;
          if(cdsImoveisInteresse.FieldByName('IGUAL_SITUACAO').AsInteger = VLR_DESLIGADO)then
            cdsImoveisInteresse.FieldByName('VALOR_SITUACAO').AsString := zQryCompletarImoveisInteresseIMOVEL_DESEJAVEL.AsString;
          if(cdsImoveisInteresse.FieldByName('IGUAL_CONDICAO_PAGAMENTO').AsInteger = VLR_DESLIGADO)then
            cdsImoveisInteresse.FieldByName('VALOR_CONDICAO_PAGAMENTO').AsString := zQryCompletarImoveisInteresseCONDICAO_PAGAMENTO.AsString;
          if(cdsImoveisInteresse.FieldByName('IGUAL_VALOR').AsInteger = VLR_DESLIGADO)then
            cdsImoveisInteresse.FieldByName('VALOR_VALOR').AsString := zQryCompletarImoveisInteresseVALOR_IMOVEL.AsString;
          if(cdsImoveisInteresse.FieldByName('IGUAL_CARACTERISTICAS_IMOVEL').AsInteger = VLR_DESLIGADO)then
            cdsImoveisInteresse.FieldByName('VALOR_CARACTERISTICAS_IMOVEL').AsString := zQryCompletarImoveisInteresseCARACTERISTICAS.AsString;
          if(cdsImoveisInteresse.FieldByName('IGUAL_REGIAO_LOCALIDADE').AsInteger = VLR_DESLIGADO)then
            cdsImoveisInteresse.FieldByName('VALOR_REGIAO_LOCALIDADE').AsString := GetRegiaoLocalidade(zQryCompletarImoveisInteresseCODIGO.AsInteger);
          cdsImoveisInteresse.Post;
        end;
        zQryCompletarImoveisInteresse.Next;
      end;
    end;
  end;
end;

procedure TfrmImoveisInteresseParaAgenciamento.FiltrarImoveisInteresse;
var
  bTipoImovel,bSituacao,bCondPgto,bValor,bCaracImovel,bRegiaoLocal: Boolean;

  function Filtrar:Boolean;
  begin
    (*if(bTipoImovel)or(bSituacao)or(bCondPgto)or(bValor)or(bCaracImovel)or(bRegiaoLocal)then
      Result := True
    else
      Result := False;
    *)
    Result := True;
  end;

begin
  dbGrdImoveisInteresse.DataSource := nil;
  bTipoImovel := ckBxTipoImovelIgual.Checked;
  bSituacao := ckBxSituacaoIgual.Checked;
  bCondPgto := ckBxCondPgtoIgual.Checked;
  bValor := ckBxValorIgual.Checked;
  bCaracImovel := ckBxCaracImovelIgual.Checked;
  bRegiaoLocal := ckBxRegiaoLocalidadeIgual.Checked;

  if Filtrar then
  begin
    cdsImoveisInteresse.DisableControls;
    cdsImoveisInteresse.IndexDefs.Clear;
    cdsImoveisInteresse.IndexName := STRING_INDEFINIDO;
    cdsImoveisInteresse.Close;

    cdsImoveisInteresse.Data := cdsImoveisInteresseFixo.Data;
    cdsImoveisInteresse.First;
    while not(cdsImoveisInteresse.Eof)do
    begin
      if(bTipoImovel)then
      begin
        if(cdsImoveisInteresse.FieldByName('IGUAL_TIPO_IMOVEL').AsInteger = VLR_DESLIGADO)then
        begin
          cdsImoveisInteresse.Delete;
          Continue;
        end;
      end;
      if(bSituacao)then
      begin
        if(cdsImoveisInteresse.FieldByName('IGUAL_SITUACAO').AsInteger = VLR_DESLIGADO)then
        begin
          cdsImoveisInteresse.Delete;
          Continue;
        end;
      end;
      if(bCondPgto)then
      begin
        if(cdsImoveisInteresse.FieldByName('IGUAL_CONDICAO_PAGAMENTO').AsInteger = VLR_DESLIGADO)then
        begin
          cdsImoveisInteresse.Delete;
          Continue;
        end;
      end;
      if(bValor)then
      begin
        if(cdsImoveisInteresse.FieldByName('IGUAL_VALOR').AsInteger = VLR_DESLIGADO)then
        begin
          cdsImoveisInteresse.Delete;
          Continue;
        end;
      end;
      if(bCaracImovel)then
      begin
        if(cdsImoveisInteresse.FieldByName('IGUAL_CARACTERISTICAS_IMOVEL').AsInteger = VLR_DESLIGADO)then
        begin
          cdsImoveisInteresse.Delete;
          Continue;
        end;
      end;
      if(bRegiaoLocal)then
      begin
        if(cdsImoveisInteresse.FieldByName('IGUAL_REGIAO_LOCALIDADE').AsInteger = VLR_DESLIGADO)then
        begin
          cdsImoveisInteresse.Delete;
          Continue;
        end;
      end;
      cdsImoveisInteresse.Next;
    end;
    cdsImoveisInteresse.EnableControls;
    CriarIndiceOrdenarPeso;
    MostrarTotalRegistros;
  end;
  dbGrdImoveisInteresse.DataSource := dsImoveisInteresse;
end;

//criando o índice para ordenar os dados pelo PESO
//cdsAgenciamentos.IndexFieldNames := 'PESO';
procedure TfrmImoveisInteresseParaAgenciamento.CriarIndiceOrdenarPeso;
var
  sIndexName: String;
  options: TIndexOptions;
begin
  sIndexName := 'PESO_DESC';
  options := [ixDescending];
  cdsImoveisInteresse.IndexDefs.Update;
  cdsImoveisInteresse.AddIndex(sIndexName, 'PESO', options);
  cdsImoveisInteresse.IndexName := sIndexName;
  //cdsImoveisInteresseFixo.IndexDefs.Update;
  //cdsImoveisInteresseFixo.AddIndex(sIndexName, 'PESO', options);
  //cdsImoveisInteresseFixo.IndexName := sIndexName;
end;

procedure TfrmImoveisInteresseParaAgenciamento.MostrarTotalRegistros;
begin
  if(cdsImoveisInteresse.Active)then
  begin
    lblTotalRegistros.Visible := True;
    lblTotalRegistros.Caption := 'Total Registros: ' + IntToStr(cdsImoveisInteresse.RecordCount);
  end
  else
  begin
    lblTotalRegistros.Visible := False;
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmImoveisInteresseParaAgenciamento.dbGrdImoveisInteresseDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  sColuna: String;

  function GetColunaIgual: String;
  begin
    if Column.FieldName='IGUAL_TIPO_IMOVEL' then
      Result := 'IGUAL_TIPO_IMOVEL'
    else if Column.FieldName='IGUAL_SITUACAO' then
      Result := 'IGUAL_SITUACAO'
    else if Column.FieldName='IGUAL_CONDICAO_PAGAMENTO' then
      Result := 'IGUAL_CONDICAO_PAGAMENTO'
    else if Column.FieldName='IGUAL_VALOR' then
      Result := 'IGUAL_VALOR'
    else if Column.FieldName='IGUAL_CARACTERISTICAS_IMOVEL' then
      Result := 'IGUAL_CARACTERISTICAS_IMOVEL'
    else if Column.FieldName='IGUAL_REGIAO_LOCALIDADE' then
      Result := 'IGUAL_REGIAO_LOCALIDADE'
    else
      Result := STRING_INDEFINIDO;
  end;

  function GetColunaValor: Boolean;
  var
    bRetorno: Boolean;
  begin
    bRetorno := False;
    if (Column.FieldName='VALOR_TIPO_IMOVEL')and(FoControlaFonteGride.campo='IGUAL_TIPO_IMOVEL') then
      bRetorno := True
    else if (Column.FieldName='VALOR_SITUACAO')and(FoControlaFonteGride.campo='IGUAL_SITUACAO') then
      bRetorno := True
    else if (Column.FieldName='VALOR_CONDICAO_PAGAMENTO')and(FoControlaFonteGride.campo='IGUAL_CONDICAO_PAGAMENTO') then
      bRetorno := True
    else if (Column.FieldName='VALOR_VALOR')and(FoControlaFonteGride.campo='IGUAL_VALOR') then
      bRetorno := True
    else if (Column.FieldName='VALOR_CARACTERISTICAS_IMOVEL')and(FoControlaFonteGride.campo='IGUAL_CARACTERISTICAS_IMOVEL') then
      bRetorno := True
    else if (Column.FieldName='VALOR_REGIAO_LOCALIDADE')and(FoControlaFonteGride.campo='IGUAL_REGIAO_LOCALIDADE') then
      bRetorno := True;

    Result := bRetorno;
  end;

begin
  sColuna := GetColunaIgual;
  if sColuna <> STRING_INDEFINIDO then //tenta tratar 1º a coluna do campo igual
  begin
    dbGrdImoveisInteresse.Canvas.FillRect(Rect);
    //desenha o quadrado
    ImageList.Draw(dbGrdImoveisInteresse.Canvas,Rect.Left+10,Rect.Top+1,0);
    //desenha o check sobre o quadrado quando ativo
    if (cdsImoveisInteresse.FieldByName(sColuna).AsString=IntToStr(VLR_LIGADO)) then //cadastro está ativo
    begin
      ImageList.Draw(dbGrdImoveisInteresse.Canvas,Rect.Left+10,Rect.Top+1,1);
      FoControlaFonteGride.isIgual := True;
    end;
    FoControlaFonteGride.campo := sColuna; //controla a fonte do valor do campo
  end

  else //trata a coluna do campo do valor
  begin
    if GetColunaValor then
    begin
      if FoControlaFonteGride.isIgual = True then
        FoFuncoes.PintarCelulaGride(dbGrdImoveisInteresse,Rect,DataCol,Column,State,clNone,clGreen,True);
    end;
    LimparControlaFonteGride;
  end;
end;

procedure TfrmImoveisInteresseParaAgenciamento.ApplicationEventsHint(
  Sender: TObject);
begin
  Self.StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmImoveisInteresseParaAgenciamento.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  FnCodAgenciamento := NUMERO_INDEFINIDO;
  LimparControlaFonteGride;
end;

procedure TfrmImoveisInteresseParaAgenciamento.FormDestroy(
  Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

procedure TfrmImoveisInteresseParaAgenciamento.dbGrdImoveisInteresseDblClick(
  Sender: TObject);
begin
  if(cdsImoveisInteresse.Active)and(cdsImoveisInteresse.RecordCount > NUMERO_INDEFINIDO)then
    ExibirDetalhesImovelInteresse;
end;

procedure TfrmImoveisInteresseParaAgenciamento.dbGrdImoveisInteresseTitleClick(
  Column: TColumn);
begin
  FoFuncoes.CriarIndiceOrdenarDadosColuna(cdsImoveisInteresse,Column);
end;

procedure TfrmImoveisInteresseParaAgenciamento.cdsImoveisInteresseAfterScroll(
  DataSet: TDataSet);
begin
  DetalharNecessidadesAtendidas;
end;

procedure TfrmImoveisInteresseParaAgenciamento.lblAbrirExplicacaoRelevanciaClick(
  Sender: TObject);
var
  oForm: TfrmExplicacao;
begin
  try
    Application.CreateForm(TfrmExplicacao,oForm);
    oForm.passarParametro(PRM_ABRIR_EXPLICACAO_PESO_IMOVEL_INTERESSE_ENCONTRADO,null);
    oForm.ShowModal;
  finally
    FreeAndNil(oForm);
  end;
end;

procedure TfrmImoveisInteresseParaAgenciamento.FormKeyPress(
  Sender: TObject; var Key: Char);
begin
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmImoveisInteresseParaAgenciamento.ckBxTipoImovelIgualClick(
  Sender: TObject);
begin
  FiltrarImoveisInteresse;
end;

procedure TfrmImoveisInteresseParaAgenciamento.ckBxSituacaoIgualClick(
  Sender: TObject);
begin
  FiltrarImoveisInteresse;
end;

procedure TfrmImoveisInteresseParaAgenciamento.ckBxCondPgtoIgualClick(
  Sender: TObject);
begin
  FiltrarImoveisInteresse;
end;

procedure TfrmImoveisInteresseParaAgenciamento.ckBxValorIgualClick(
  Sender: TObject);
begin
  FiltrarImoveisInteresse;
end;

procedure TfrmImoveisInteresseParaAgenciamento.ckBxCaracImovelIgualClick(
  Sender: TObject);
begin
  FiltrarImoveisInteresse;
end;

procedure TfrmImoveisInteresseParaAgenciamento.ckBxRegiaoLocalidadeIgualClick(
  Sender: TObject);
begin
  FiltrarImoveisInteresse;
end;

end.

