unit unPesquisarAgenciamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisa, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Mask,
  plsTMaskEdit, plsEdit, plsComboBox, DB, DBClient, Provider,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Menus, plsMemo,
  unConjuntoDadosTipoImovel,unConjuntoDadosEstado,unConjuntoDadosCidade,
  unConjuntoDadosBairro,unConjuntoDadosRua;

  type
    TTipoImovel = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TEstado = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TCidade = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TBairro = record
      codigo: Integer;
      nome: string[100];
    end;

  type
    TRua = record
      codigo: Integer;
      nome: string[100];
      cep: string[9];
    end;

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
    lblStatus: TLabel;
    plsCbBxStatus: TPlsComboBox;
    ppMnDarBaixa: TMenuItem;
    ppMnDivisao: TMenuItem;
    mnItDetalhar: TMenuItem;
    grpBxNomePessoa: TGroupBox;
    plsEdNomePessoa: TPlsEdit;
    lblAgenciamento: TLabel;
    lblImovel: TLabel;
    pnlTipoImovel: TPanel;
    lblTipoImovel: TLabel;
    spBtnBuscaTipoImovel: TSpeedButton;
    plsEdTipoImovel: TPlsEdit;
    grpBxEndereco: TGroupBox;
    pnlEstado: TPanel;
    spBtnBuscaEstado: TSpeedButton;
    lblEstado: TLabel;
    plsEdEstado: TPlsEdit;
    pnlCidade: TPanel;
    spBtnBuscaCidade: TSpeedButton;
    lblCidade: TLabel;
    plsEdCidade: TPlsEdit;
    pnlRua: TPanel;
    spBtnBuscaRua: TSpeedButton;
    lblRua: TLabel;
    plsEdRua: TPlsEdit;
    pnlBairro: TPanel;
    lblBairro: TLabel;
    spBtnBuscaBairro: TSpeedButton;
    plsEdBairro: TPlsEdit;
    plsCbBxSituacao: TPlsComboBox;
    lblSituacao: TLabel;
    plsMmDescricao: TPlsMemo;
    lblDescricao: TLabel;
    lblNomeFiltrosUsados: TLabel;
    lblFiltrosUsados: TLabel;
    lblTotalRegistros: TLabel;
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
    procedure FormShow(Sender: TObject);
    procedure ppMnDarBaixaClick(Sender: TObject);
    procedure dbGrdDadosPesquisaDblClick(Sender: TObject);
    procedure mnItDetalharClick(Sender: TObject);
    procedure plsEdTipoImovelExit(Sender: TObject);
    procedure spBtnBuscaTipoImovelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure plsEdEstadoExit(Sender: TObject);
    procedure spBtnBuscaEstadoClick(Sender: TObject);
    procedure plsEdCidadeExit(Sender: TObject);
    procedure spBtnBuscaCidadeClick(Sender: TObject);
    procedure plsEdBairroExit(Sender: TObject);
    procedure spBtnBuscaBairroClick(Sender: TObject);
    procedure plsEdRuaExit(Sender: TObject);
    procedure spBtnBuscaRuaClick(Sender: TObject);
    procedure lblDescricaoClick(Sender: TObject);
  private
    FoConjuntoDadosTipoImovel: TConjuntoDadosTipoImovel;
    FoConjuntoDadosEstado: TConjuntoDadosEstado;
    FoConjuntoDadosCidade: TConjuntoDadosCidade;
    FoConjuntoDadosBairro: TConjuntoDadosBairro;
    FoConjuntoDadosRua: TConjuntoDadosRua;

    procedure BaixarImovelInteresse;
    procedure DetalharAgenciamento(pnCodAgenciamento:Integer);
    procedure LimparEndereco(nEnderecoChamou: String); //limpa os campos do endereço, a partir daquele que alterou
    function ValidarAcessoEndereco(nEnderecoChamou: String): boolean; //valida se o acesso ao endereço pode ser realizado

    procedure AbreTelaSelecaoTipoImovel(pnTpSelecao:Word);
    procedure VerificarTipoImovelExiste;
    procedure AbreTelaSelecaoEstado(pnTpSelecao:Word);
    procedure VerificarEstadoExiste;
    procedure AbreTelaSelecaoCidade(pnTpSelecao:Word);
    procedure VerificarCidadeExiste;
    procedure AbreTelaSelecaoBairro(pnTpSelecao:Word);
    procedure VerificarBairroExiste;
    procedure AbreTelaSelecaoRua(pnTpSelecao:Word);
    procedure VerificarRuaExiste;
  public
    FoTipoImovel: TTipoImovel;
    FoEstado: TEstado;
    FoCidade: TCidade;
    FoBairro: TBairro;
    FoRua: TRua;
    FbPodeLimparEndereco: Boolean;

    procedure PassarParametro(pTipo:String; pValores:OleVariant); override;
  protected
    procedure SelecionarTodosDados; override;
    procedure Pesquisar; override;
    procedure FormatarValores; override;
    procedure LimparTela; override;
  end;

var
  frmPesquisarAgenciamentos: TfrmPesquisarAgenciamentos;

implementation

uses
  unConstantes, unDM, unExibeDadosAgenciamento,
  unSelecionaRegistroTipoImovel, unPrincipal, unSelecionaRegistroEstado,
  unSelecionaRegistroCidade, TypInfo, unSelecionaRegistroBairro,
  unSelecionaRegistroRua, unSelecionarCaracImovel;

const
  fnSELECIONAR_TIPO_IMOVEL_NORMAL    = 1;
  fnSELECIONAR_TIPO_IMOVEL_DIGITANDO = 2;
  fnSELECIONAR_ESTADO_NORMAL    = 1;
  fnSELECIONAR_ESTADO_DIGITANDO = 2;
  fnSELECIONAR_CIDADE_NORMAL    = 1;
  fnSELECIONAR_CIDADE_DIGITANDO = 2;
  fnSELECIONAR_BAIRRO_NORMAL    = 1;
  fnSELECIONAR_BAIRRO_DIGITANDO = 2;     
  fnSELECIONAR_RUA_NORMAL    = 1;
  fnSELECIONAR_RUA_DIGITANDO = 2;    

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmPesquisarAgenciamentos.PassarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_NAO_LIMPAR_ENDERECO)then
  begin
    FbPodeLimparEndereco := False;
  end;
end;

procedure TfrmPesquisarAgenciamentos.LimparTela;
begin
  inherited;
  plsCbBxStatus.ItemIndex := NUMERO_INDEFINIDO;
  rdGrpTipoAgenciamento.ItemIndex := -1;
  rdGrpTipoPessoa.ItemIndex := -1;
  lblFiltrosUsados.Caption := STRING_INDEFINIDO;

  FoTipoImovel.codigo := NUMERO_INDEFINIDO;
  FoTipoImovel.nome := STRING_INDEFINIDO;
  FoEstado.codigo := NUMERO_INDEFINIDO;
  FoEstado.nome := STRING_INDEFINIDO;
  FoCidade.codigo := NUMERO_INDEFINIDO;
  FoCidade.nome := STRING_INDEFINIDO;
  FoBairro.codigo := NUMERO_INDEFINIDO;
  FoBairro.nome := STRING_INDEFINIDO;
  FoRua.codigo := NUMERO_INDEFINIDO;
  FoRua.nome := STRING_INDEFINIDO;
  FoRua.cep := STRING_INDEFINIDO;
end;

procedure TfrmPesquisarAgenciamentos.SelecionarTodosDados;
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
  zQryDados.SQL.Add('CAST(a.pgto_vista_descricao_bem AS VARCHAR(500)) AS CC_PGTO_VISTA_DESCRICAO_BEM,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_cach_financiado AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH_FINANCIADO,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_cach AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_valor_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_VALOR_BEM,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_descricao_bem AS VARCHAR(500)) AS CC_PGTO_FINCTO_DESCRICAO_BEM,');
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

  lblFiltrosUsados.Caption := STRING_INDEFINIDO;
  lblTotalRegistros.Caption := 'Total de Registros: ' + IntToStr(cdsDados.RecordCount);
end;

procedure TfrmPesquisarAgenciamentos.Pesquisar;
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
  sNomePessoa: String;
  nTipoImovel: Integer;
  sSituacao: String;
  nTotDescricoes: Integer;
  sDescricao: array[1..20] of String;
  nEstado,nCidade,nBairro,nRua: Integer;
  sFiltrosUsados: String;
  nAux: Integer;

  procedure GetDescricaoImovel;
  const
    sCHAR_SEPARADOR = ';';
  var
    sDescricoes: String;
    i: Integer;
    nTotCaracteresDescricao: Integer;
    sCharAtual: String;
    sCaracteristica: String;
  begin
    sDescricoes := Trim(plsMmDescricao.Text);
    if(sDescricoes <> STRING_INDEFINIDO)then
    begin
      nTotCaracteresDescricao := length(sDescricoes);
      sCaracteristica := STRING_INDEFINIDO;
      //varre as características buscando por uma característca
      for i:=1 to nTotCaracteresDescricao do
      begin
        sCharAtual := sDescricoes[i];
        sCaracteristica := sCaracteristica + sCharAtual;
        if(sCharAtual = sCHAR_SEPARADOR)or(i >= nTotCaracteresDescricao)then
        begin
          inc(nTotDescricoes);
          sDescricao[nTotDescricoes] := sCaracteristica;
          sCaracteristica := STRING_INDEFINIDO;
        end;
      end;
    end;
  end;

  procedure CarregarValores;
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
    sNomePessoa := Trim(plsEdNomePessoa.Text);
    nTipoImovel := FoTipoImovel.codigo;
    sSituacao := plsCbBxSituacao.Text;
    GetDescricaoImovel;
    nEstado := FoEstado.codigo;
    nCidade := FoCidade.codigo;
    nBairro := FoBairro.codigo;
    nRua := FoRua.codigo;
  end;

begin
  sFiltrosUsados := STRING_INDEFINIDO;
  nTotDescricoes := NUMERO_INDEFINIDO;
  CarregarValores;

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
  zQryDados.SQL.Add('CAST(a.pgto_vista_descricao_bem AS VARCHAR(500)) AS CC_PGTO_VISTA_DESCRICAO_BEM,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_cach_financiado AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH_FINANCIADO,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_cach AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_valor_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_VALOR_BEM,');
  zQryDados.SQL.Add('CAST(a.pgto_fincto_descricao_bem AS VARCHAR(500)) AS CC_PGTO_FINCTO_DESCRICAO_BEM,');
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
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Código');
  end;

  if(sAtivo <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.ativo = :ativo ');
    zQryDados.ParamByName('ativo').AsString := sAtivo;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Ativo');
  end;

  if(dtDataAgenciamentoInicio <> NUMERO_INDEFINIDO)and(dtDataAgenciamentoFim <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.data_agenciamento BETWEEN :dtAgencInicio AND :dtAgencFim ');
    zQryDados.ParamByName('dtAgencInicio').AsDate := dtDataAgenciamentoInicio;
    zQryDados.ParamByName('dtAgencFim').AsDate := dtDataAgenciamentoFim;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Data Agenciamento');
  end;

  if(dtPrazoAutorizacaoInicio <> NUMERO_INDEFINIDO)and(dtPrazoAutorizacaoFim <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.prazo_autorizacao BETWEEN :dtPrazoAutInicio AND :dtPrazoAutFim ');
    zQryDados.ParamByName('dtPrazoAutInicio').AsDate := dtPrazoAutorizacaoInicio;
    zQryDados.ParamByName('dtPrazoAutFim').AsDate := dtPrazoAutorizacaoFim;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Prazo Autorização');
  end;

  if(dtDataBaixaInicio <> NUMERO_INDEFINIDO)and(dtDataBaixaFim <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.data_baixa BETWEEN :dtDataBaixaInicio AND :dtDataBaixaFim ');
    zQryDados.ParamByName('dtDataBaixaInicio').AsDate := dtDataBaixaFim;
    zQryDados.ParamByName('dtDataBaixaFim').AsDate := dtDataBaixaFim;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Data Baixa');
  end;

  if(sTipoPessoa <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.tipo_pessoa = :tipo_pessoa ');
    zQryDados.ParamByName('tipo_pessoa').AsString := sTipoPessoa;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Tipo Pessoa');
  end;

  if(sNormal <> STRING_INDEFINIDO)and(sStandBy <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.normal = :normal AND stand_by =:stand_by ');
    zQryDados.ParamByName('normal').AsString := sNormal;
    zQryDados.ParamByName('stand_by').AsString := sStandBy;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Tipo Agenciamento');
  end;

  if(sCondicaoPagamento <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.condicao_pagamento =:condicao_pagamento ');
    zQryDados.ParamByName('condicao_pagamento').AsString := sCondicaoPagamento;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Condição Pagamento');
  end;

  if(dValorTotalInicio <> NUMERO_INDEFINIDO)and(dValorTotalFim <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND a.valor_total BETWEEN :valorTotalInicio AND :valorTotalFim ');
    zQryDados.ParamByName('valorTotalInicio').AsCurrency := dValorTotalInicio;
    zQryDados.ParamByName('valorTotalFim').AsCurrency := dValorTotalFim;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Valor Total');
  end;

  if(sNomePessoa <> STRING_INDEFINIDO)and(
    (sTipoPessoa=VLR_TP_PESSOA_FISICA)or(sTipoPessoa=VLR_TP_PESSOA_JURIDICA))then
  begin
    if(sTipoPessoa=VLR_TP_PESSOA_FISICA)then
      zQryDados.SQL.Add('AND pf.nome=:nomePessoa ')
    else if(sTipoPessoa=VLR_TP_PESSOA_JURIDICA)then
      zQryDados.SQL.Add('AND pj.nome=:nomePessoa ');
    zQryDados.ParamByName('nomePessoa').AsString := sNomePessoa;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Nome da Pessoa');
  end;

  if(nTipoImovel <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND ti.codigo =:codigoTipoImovel ');
    zQryDados.ParamByName('codigoTipoImovel').AsInteger := nTipoImovel;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Tipo de Imóvel');
  end;

  if(sSituacao <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND i.situacao_desejavel=:situacao_desejavel ');
    zQryDados.ParamByName('situacao_desejavel').AsString := sSituacao;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Situação');
  end;

  if(nTotDescricoes > NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND (');
    for nAux:=1 to nTotDescricoes do
    begin
      if(nAux=1)then
        zQryDados.SQL.Add('i.descricao LIKE ' +QuotedStr('%' +sDescricao[nAux]+ '%'))
      else
        zQryDados.SQL.Add('AND i.descricao LIKE ' +QuotedStr('%' +sDescricao[nAux]+ '%'));
    end;
    zQryDados.SQL.Add(')');
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Descrição do Imóvel');
  end;

  if(nEstado <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND est.codigo =:codigoEstado ');
    zQryDados.ParamByName('codigoEstado').AsInteger := nEstado;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Estado');
  end;

  if(nCidade <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND cid.codigo =:codigoCidade ');
    zQryDados.ParamByName('codigoCidade').AsInteger := nCidade;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Cidade');
  end;

  if(nBairro <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND bai.codigo =:codigoBairro ');
    zQryDados.ParamByName('codigoBairro').AsInteger := nBairro;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Bairro');
  end;

  if(nRua <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND rua.codigo =:codigoRua ');
    zQryDados.ParamByName('codigoRua').AsInteger := nRua;
    FoFuncoes.AdicionarInformacao(sFiltrosUsados,'Rua');
  end;

  zQryDados.SQL.Add('ORDER BY a.codigo');
  zQryDados.Open;
  cdsDados.Open;

  lblFiltrosUsados.Caption := sFiltrosUsados;
  lblTotalRegistros.Caption := 'Total de Registros: ' + IntToStr(cdsDados.RecordCount);  
  VerificaEncontrouRegistros;
end;

procedure TfrmPesquisarAgenciamentos.FormatarValores;
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

      if(FoFuncoes.verificaCEP_EhVazio(cdsDadosCEP_RUA.AsString))then
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

procedure TfrmPesquisarAgenciamentos.DetalharAgenciamento(pnCodAgenciamento:Integer);
begin
  try
    Application.CreateForm(TfrmExibeDadosAgenciamento,frmExibeDadosAgenciamento);
    frmExibeDadosAgenciamento.passarParametro(PRM_PESQUISAR_AGENCIAMENTO,pnCodAgenciamento);
    frmExibeDadosAgenciamento.ShowModal;
  finally
    FreeAndNil(frmExibeDadosAgenciamento);
  end;
end;

procedure TfrmPesquisarAgenciamentos.LimparEndereco(nEnderecoChamou: String);
  procedure limparEstado();
  begin
    plsEdEstado.Clear;
    Self.FoEstado.codigo := NUMERO_INDEFINIDO;
    Self.FoEstado.nome := STRING_INDEFINIDO;
  end;
  procedure limparCidade();
  begin
    plsEdCidade.Clear;
    Self.FoCidade.codigo := NUMERO_INDEFINIDO;
    Self.FoCidade.nome := STRING_INDEFINIDO;
  end;
  procedure limparBairro();
  begin
    plsEdBairro.Clear;
    Self.FoBairro.codigo := NUMERO_INDEFINIDO;
    Self.FoBairro.nome := STRING_INDEFINIDO;
  end;
  procedure limparRua();
  begin
    plsEdRua.Clear;
    Self.FoRua.codigo := NUMERO_INDEFINIDO;
    Self.FoRua.nome := STRING_INDEFINIDO;
    Self.FoRua.cep := STRING_INDEFINIDO;
  end;

begin
    if(Self.FbPodeLimparEndereco)then
  begin
    if(nEnderecoChamou = 'ESTADO')then
    begin
      limparEstado();
      limparCidade();
      limparBairro();
      limparRua();
    end
    else if(nEnderecoChamou = 'CIDADE')then
    begin
      limparCidade();
      limparBairro();
      limparRua();
    end
    else if(nEnderecoChamou = 'BAIRRO')then
    begin
      limparBairro();
      limparRua();
    end
    else if(nEnderecoChamou = 'RUA')then
    begin
      limparRua();
    end;
  end;

  Self.FbPodeLimparEndereco := True;
end;

function TfrmPesquisarAgenciamentos.ValidarAcessoEndereco(nEnderecoChamou: String): boolean;
var
  bAcesso: Boolean;
begin
  bAcesso := False;

  if(nEnderecoChamou = 'CIDADE')then
  begin
    if(FoEstado.codigo <> NUMERO_INDEFINIDO)then
      bAcesso := True;
  end
  else if(nEnderecoChamou = 'BAIRRO')then
  begin
    if(FoEstado.codigo <> NUMERO_INDEFINIDO)and(FoCidade.codigo <> NUMERO_INDEFINIDO)then
      bAcesso := True;
  end
  else if(nEnderecoChamou = 'RUA')then
  begin
    if(FoEstado.codigo <> NUMERO_INDEFINIDO)and(FoCidade.codigo <> NUMERO_INDEFINIDO)and
      (FoBairro.codigo <> NUMERO_INDEFINIDO)then
      bAcesso := True;
  end;

  Result := bAcesso;
end;


procedure TfrmPesquisarAgenciamentos.AbreTelaSelecaoTipoImovel(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdTipoImovel.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_TIPO_IMOVEL_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroTipoImovel, frmSelecionaRegistroTipoImovel);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_TELA_CHAMOU,FORM_PESQUISAR_AGENCIAMENTO);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdTipoImovel.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroTipoImovel.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_VISIBLE_FALSE_BOTAO_NOVO_FORM_SELECAO,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmPesquisarAgenciamentos,frmSelecionaRegistroTipoImovel,pnlTipoImovel);
        frmSelecionaRegistroTipoImovel.ShowModal;
      finally
        if(Self.FoTipoImovel.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdTipoImovel.Text := Self.FoTipoImovel.nome;
          FoFuncoes.focarComponente(plsCbBxSituacao);
        end;
        FreeAndNil(frmSelecionaRegistroTipoImovel);
      end;
    end;

    fnSELECIONAR_TIPO_IMOVEL_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroTipoImovel, frmSelecionaRegistroTipoImovel);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_TELA_CHAMOU,FORM_PESQUISAR_AGENCIAMENTO);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        frmSelecionaRegistroTipoImovel.passarParametro(PRM_VISIBLE_FALSE_BOTAO_NOVO_FORM_SELECAO,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmPesquisarAgenciamentos,frmSelecionaRegistroTipoImovel,pnlTipoImovel);
        frmSelecionaRegistroTipoImovel.ShowModal;
      finally
        if(Self.FoTipoImovel.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdTipoImovel.Text := Self.FoTipoImovel.nome;
          FoFuncoes.focarComponente(plsEdEstado);
        end;
        FreeAndNil(frmSelecionaRegistroTipoImovel);
      end;
    end;
  end;
end;

procedure TfrmPesquisarAgenciamentos.VerificarTipoImovelExiste();
begin
  if(plsEdTipoImovel.Text <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosTipoImovel.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdTipoImovel.Text + '%'));
    FoConjuntoDadosTipoImovel.ExecutarFiltrar;

    if(FoConjuntoDadosTipoImovel.TotalRegistros = 1)then
    begin
      FoTipoImovel.codigo := FoConjuntoDadosTipoImovel.GetCodigo;
      FoTipoImovel.nome := FoConjuntoDadosTipoImovel.GetNome;
      plsEdTipoImovel.Text := FoTipoImovel.nome;
    end
    else if(FoConjuntoDadosTipoImovel.TotalRegistros > 1)then
      AbreTelaSelecaoTipoImovel(fnSELECIONAR_TIPO_IMOVEL_DIGITANDO)
    else
    begin
      MessageDlg('Tipo de Imóvel não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdTipoImovel);
    end;
  end;
end;

procedure TfrmPesquisarAgenciamentos.AbreTelaSelecaoEstado(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdEstado.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_ESTADO_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroEstado, frmSelecionaRegistroEstado);
        frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_PESQUISAR_AGENCIAMENTO);
        frmSelecionaRegistroEstado.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdEstado.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroEstado.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroEstado.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        frmSelecionaRegistroEstado.passarParametro(PRM_VISIBLE_FALSE_BOTAO_NOVO_FORM_SELECAO,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmPesquisarAgenciamentos,frmSelecionaRegistroEstado,pnlEstado,nil,nil,180);
        frmSelecionaRegistroEstado.ShowModal;
      finally
        if(FoEstado.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdEstado.Text := FoEstado.nome;
          limparEndereco('CIDADE');
          FoFuncoes.focarComponente(plsEdCidade);
        end;
        FreeAndNil(frmSelecionaRegistroEstado);
      end;
    end;

    fnSELECIONAR_ESTADO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroEstado, frmSelecionaRegistroEstado);
        frmSelecionaRegistroEstado.passarParametro(PRM_TELA_CHAMOU, FORM_PESQUISAR_AGENCIAMENTO);
        frmSelecionaRegistroEstado.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroEstado.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroEstado.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        frmSelecionaRegistroEstado.passarParametro(PRM_VISIBLE_FALSE_BOTAO_NOVO_FORM_SELECAO,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmPesquisarAgenciamentos,frmSelecionaRegistroEstado,pnlEstado,nil,nil,180);
        frmSelecionaRegistroEstado.ShowModal;
      finally
        if(FoEstado.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdEstado.Text := FoEstado.nome;
          limparEndereco('CIDADE');
          FoFuncoes.focarComponente(plsEdCidade);
        end
        else
          plsEdEstado.Clear;
        FreeAndNil(frmSelecionaRegistroEstado);
      end;
    end;
  end;
end;


procedure TfrmPesquisarAgenciamentos.VerificarEstadoExiste;
begin
  if(Trim(plsEdEstado.Text) <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosEstado.SetFiltro('nome ' + ' LIKE ' + QuotedStr('%' + plsEdEstado.Text + '%'));
    FoConjuntoDadosEstado.ExecutarFiltrar;

    if(FoConjuntoDadosEstado.TotalRegistros = 1)then
    begin
      FoEstado.codigo := FoConjuntoDadosEstado.GetCodigo;
      FoEstado.nome := FoConjuntoDadosEstado.GetNome;
      plsEdEstado.Text := FoEstado.nome;
    end
    else if(FoConjuntoDadosEstado.TotalRegistros > 1)then
      AbreTelaSelecaoEstado(fnSELECIONAR_ESTADO_DIGITANDO)
    else
    begin
      MessageDlg('Estado não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdEstado);
    end;
  end
  else
    limparEndereco('ESTADO');
end;

procedure TfrmPesquisarAgenciamentos.AbreTelaSelecaoCidade(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdCidade.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_CIDADE_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroCidade, frmSelecionaRegistroCidade);
        frmSelecionaRegistroCidade.passarParametro(PRM_TELA_CHAMOU, FORM_PESQUISAR_AGENCIAMENTO);
        frmSelecionaRegistroCidade.passarParametro('FK_COD_ESTADO', FoEstado.codigo);
        frmSelecionaRegistroCidade.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroCidade.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroCidade.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmPesquisarAgenciamentos,frmSelecionaRegistroCidade,pnlCidade,nil,nil,180);
        frmSelecionaRegistroCidade.passarParametro(PRM_VISIBLE_FALSE_BOTAO_NOVO_FORM_SELECAO,null);
        frmSelecionaRegistroCidade.ShowModal;
      finally
        if(FoCidade.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdCidade.Text := FoCidade.nome;
          limparEndereco('BAIRRO');
          FoFuncoes.focarComponente(plsEdBairro);
        end;
        FreeAndNil(frmSelecionaRegistroCidade);
      end;
    end;

    fnSELECIONAR_CIDADE_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroCidade, frmSelecionaRegistroCidade);
        frmSelecionaRegistroCidade.passarParametro(PRM_TELA_CHAMOU, FORM_PESQUISAR_AGENCIAMENTO);
        frmSelecionaRegistroCidade.passarParametro('FK_COD_ESTADO', FoEstado.codigo);
        frmSelecionaRegistroCidade.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroCidade.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroCidade.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmPesquisarAgenciamentos,frmSelecionaRegistroCidade,pnlCidade,nil,nil,180);
        frmSelecionaRegistroCidade.passarParametro(PRM_VISIBLE_FALSE_BOTAO_NOVO_FORM_SELECAO,null);
        frmSelecionaRegistroCidade.ShowModal;
      finally
        if(FoCidade.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdCidade.Text := Self.FoCidade.nome;
          limparEndereco('BAIRRO');
          FoFuncoes.focarComponente(plsEdBairro);
        end
        else
          plsEdCidade.Clear;
        FreeAndNil(frmSelecionaRegistroCidade);
      end;
    end;
  end;
end;

procedure TfrmPesquisarAgenciamentos.VerificarCidadeExiste();
var
  sFiltro: String;
begin
  sFiltro := '(nome ' + ' LIKE ' + QuotedStr('%' + plsEdCidade.Text + '%') + ')';
  sFiltro := sFiltro + ' AND cod_fk_estado = ' + QuotedStr(IntToStr(FoEstado.codigo));
  if(plsEdCidade.Text <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosCidade.SetFiltro(sFiltro);
    FoConjuntoDadosCidade.ExecutarFiltrar;

    if(FoConjuntoDadosCidade.TotalRegistros = 1)then
    begin
      FoCidade.codigo := FoConjuntoDadosCidade.GetCodigo;
      FoCidade.nome := FoConjuntoDadosCidade.GetNome;
      plsEdCidade.Text := FoCidade.nome;
    end
    else if(FoConjuntoDadosCidade.TotalRegistros > 1)then
      AbreTelaSelecaoCidade(fnSELECIONAR_CIDADE_DIGITANDO)
    else
    begin
      MessageDlg('Cidade não encontrada.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdCidade);
    end;
  end
  else
    limparEndereco('CIDADE');
end;

procedure TfrmPesquisarAgenciamentos.AbreTelaSelecaoBairro(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdBairro.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_BAIRRO_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
        frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_PESQUISAR_AGENCIAMENTO);
        frmSelecionaRegistroBairro.passarParametro('FK_COD_CIDADE', FoCidade.codigo);
        frmSelecionaRegistroBairro.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdBairro.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroBairro.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroBairro.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        frmSelecionaRegistroBairro.passarParametro(PRM_VISIBLE_FALSE_BOTAO_NOVO_FORM_SELECAO,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmPesquisarAgenciamentos,frmSelecionaRegistroBairro,pnlBairro,nil,nil,180);
        frmSelecionaRegistroBairro.ShowModal;
      finally
        if(FoBairro.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdBairro.Text := FoBairro.nome;
          limparEndereco('RUA');
          Self.FoFuncoes.focarComponente(plsEdRua);
        end;
        FreeAndNil(frmSelecionaRegistroBairro);
      end;
    end;

    fnSELECIONAR_BAIRRO_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroBairro, frmSelecionaRegistroBairro);
        frmSelecionaRegistroBairro.passarParametro(PRM_TELA_CHAMOU, FORM_PESQUISAR_AGENCIAMENTO);
        frmSelecionaRegistroBairro.passarParametro('FK_COD_CIDADE', Self.FoCidade.codigo);
        frmSelecionaRegistroBairro.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroBairro.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroBairro.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        frmSelecionaRegistroBairro.passarParametro(PRM_VISIBLE_FALSE_BOTAO_NOVO_FORM_SELECAO,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmPesquisarAgenciamentos,frmSelecionaRegistroBairro,pnlBairro,nil,nil,180);
        frmSelecionaRegistroBairro.ShowModal;
      finally
        if(Self.FoBairro.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdBairro.Text := Self.FoBairro.nome;
          limparEndereco('RUA');
          Self.FoFuncoes.focarComponente(plsEdRua);
        end
        else
          plsEdBairro.Clear;
        FreeAndNil(frmSelecionaRegistroBairro);
      end;
    end;
  end;
end;

procedure TfrmPesquisarAgenciamentos.VerificarBairroExiste;
var
  sFiltro: String;
begin
  sFiltro := '(nome ' + ' LIKE ' + QuotedStr('%' + plsEdBairro.Text + '%') + ')';
  sFiltro := sFiltro + ' AND cod_fk_cidade = ' + QuotedStr(IntToStr(FoCidade.codigo));
  if(plsEdBairro.Text <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosBairro.SetFiltro(sFiltro);
    FoConjuntoDadosBairro.ExecutarFiltrar;

    if(FoConjuntoDadosBairro.TotalRegistros = 1)then
    begin
      FoBairro.codigo := FoConjuntoDadosBairro.GetCodigo;
      FoBairro.nome := FoConjuntoDadosBairro.GetNome;
      plsEdBairro.Text := FoBairro.nome;
    end
    else if(FoConjuntoDadosBairro.TotalRegistros > 1)then
      AbreTelaSelecaoBairro(fnSELECIONAR_BAIRRO_DIGITANDO)
    else
    begin
      MessageDlg('Bairro não encontrado.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdBairro);
    end;
  end
  else
    limparEndereco('BAIRRO');
end;

procedure TfrmPesquisarAgenciamentos.AbreTelaSelecaoRua(pnTpSelecao:Word);
var
  vParametros: Variant;
begin
  vParametros := VarArrayCreate([0,2],varVariant);
  vParametros[0] := PRM_PESQUISA_NOME;
  vParametros[1] := plsEdRua.Text;
  vParametros[2] := False;

  case pnTpSelecao of

    fnSELECIONAR_RUA_NORMAL:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroRua, frmSelecionaRegistroRua);
        frmSelecionaRegistroRua.passarParametro(PRM_TELA_CHAMOU, FORM_PESQUISAR_AGENCIAMENTO);
        frmSelecionaRegistroRua.passarParametro('FK_COD_BAIRRO', Self.FoBairro.codigo);
        frmSelecionaRegistroRua.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        if(plsEdRua.Text <> STRING_INDEFINIDO)then
          frmSelecionaRegistroRua.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroRua.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        frmSelecionaRegistroRua.passarParametro(PRM_VISIBLE_FALSE_BOTAO_NOVO_FORM_SELECAO,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmPesquisarAgenciamentos,frmSelecionaRegistroRua,pnlRua,nil,nil,180);
        frmSelecionaRegistroRua.ShowModal;
      finally
        if(FoRua.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdRua.Text := FoRua.nome;
          Self.FoFuncoes.focarComponente(btBtnPesquisar);
        end;
        FreeAndNil(frmSelecionaRegistroRua);
      end;
    end;

    fnSELECIONAR_RUA_DIGITANDO:
    begin
      try
        Application.CreateForm(TfrmSelecionaRegistroRua, frmSelecionaRegistroRua);
        frmSelecionaRegistroRua.passarParametro(PRM_TELA_CHAMOU, FORM_PESQUISAR_AGENCIAMENTO);
        frmSelecionaRegistroRua.passarParametro('FK_COD_BAIRRO', Self.FoBairro.codigo);
        frmSelecionaRegistroRua.passarParametro(PRM_DEFINE_FILTRO_PADRAO_TELA_SELECAO, null);
        frmSelecionaRegistroRua.passarParametro(PRM_ENVIA_FILTRO_PESQUISA, vParametros);
        frmSelecionaRegistroRua.passarParametro(PRM_AJUSTAR_LARGURA_GRIDE,null);
        frmSelecionaRegistroRua.passarParametro(PRM_VISIBLE_FALSE_BOTAO_NOVO_FORM_SELECAO,null);
        FoFuncoes.AjustarPosicaoFormCadastroSelecaoRegistro(frmPrincipal,
         frmPesquisarAgenciamentos,frmSelecionaRegistroRua,pnlRua,nil,nil,180);
        frmSelecionaRegistroRua.ShowModal;
      finally
        if(FoRua.codigo <> NUMERO_INDEFINIDO)then
        begin
          plsEdRua.Text := FoRua.nome;
          Self.FoFuncoes.focarComponente(btBtnPesquisar);
        end
        else
          plsEdRua.Clear;
        FreeAndNil(frmSelecionaRegistroRua);
      end;
    end;
  end;
end;

procedure TfrmPesquisarAgenciamentos.VerificarRuaExiste;
var
  sFiltro: String;
begin
  sFiltro := '(nome ' + ' LIKE ' + QuotedStr('%' + plsEdRua.Text + '%') + ')';
  sFiltro := sFiltro + ' AND cod_fk_bairro = ' + QuotedStr(IntToStr(FoBairro.codigo));

  if(plsEdRua.Text <> STRING_INDEFINIDO)then
  begin
    FoConjuntoDadosRua.SetFiltro(sFiltro);
    FoConjuntoDadosRua.ExecutarFiltrar;

    if(FoConjuntoDadosRua.TotalRegistros = 1)then
    begin
      FoRua.codigo := FoConjuntoDadosRua.GetCodigo;
      FoRua.nome := FoConjuntoDadosRua.GetNome;
      FoRua.cep := FoConjuntoDadosRua.GetCEP;
      plsEdRua.Text := FoRua.nome;
    end
    else if(FoConjuntoDadosRua.TotalRegistros > 1)then
      AbreTelaSelecaoRua(fnSELECIONAR_RUA_DIGITANDO)
    else
    begin
      MessageDlg('Rua não encontrada.', mtInformation, [mbOK], 0);
      FoFuncoes.focarComponente(plsEdRua);
    end;
  end
  else
    limparEndereco('RUA');
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

procedure TfrmPesquisarAgenciamentos.dbGrdDadosPesquisaDblClick(
  Sender: TObject);
begin
  inherited;
  if(cdsDados.Active)and(cdsDados.RecordCount > NUMERO_INDEFINIDO)then
    DetalharAgenciamento(cdsDadosCODIGO_AGENCIAMENTO.AsInteger);
end;

procedure TfrmPesquisarAgenciamentos.mnItDetalharClick(Sender: TObject);
begin
  inherited;
  if(cdsDados.Active)and(cdsDados.RecordCount > NUMERO_INDEFINIDO)then
    DetalharAgenciamento(cdsDadosCODIGO_AGENCIAMENTO.AsInteger);
end;

procedure TfrmPesquisarAgenciamentos.plsEdTipoImovelExit(Sender: TObject);
begin
  inherited;
  VerificarTipoImovelExiste;
end;

procedure TfrmPesquisarAgenciamentos.spBtnBuscaTipoImovelClick(
  Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoTipoImovel(fnSELECIONAR_TIPO_IMOVEL_NORMAL);
end;

procedure TfrmPesquisarAgenciamentos.FormCreate(Sender: TObject);
begin
  inherited;
  FoConjuntoDadosTipoImovel := TConjuntoDadosTipoImovel.CriaObjeto;
  FoConjuntoDadosEstado := TConjuntoDadosEstado.CriaObjeto;
  FoConjuntoDadosCidade := TConjuntoDadosCidade.CriaObjeto;
  FoConjuntoDadosBairro := TConjuntoDadosBairro.CriaObjeto;
  FoConjuntoDadosRua := TConjuntoDadosRua.CriaObjeto;
  FbPodeLimparEndereco := True;
end;

procedure TfrmPesquisarAgenciamentos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FoConjuntoDadosTipoImovel);
  FreeAndNil(FoConjuntoDadosEstado);
  FreeAndNil(FoConjuntoDadosCidade);
  FreeAndNil(FoConjuntoDadosBairro);
  FreeAndNil(FoConjuntoDadosRua);
end;

procedure TfrmPesquisarAgenciamentos.plsEdEstadoExit(Sender: TObject);
begin
  inherited;
  VerificarEstadoExiste;
end;

procedure TfrmPesquisarAgenciamentos.spBtnBuscaEstadoClick(
  Sender: TObject);
begin
  inherited;
  AbreTelaSelecaoEstado(fnSELECIONAR_ESTADO_NORMAL);
end;

procedure TfrmPesquisarAgenciamentos.plsEdCidadeExit(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('CIDADE'))then
  begin
    if(Trim(plsEdCidade.Text) <> STRING_INDEFINIDO)then
    begin
      MessageDlg('Um estado deve estar selecionado.', mtInformation, [mbOK], 0);
      plsEdCidade.Clear;
      FoFuncoes.focarComponente(plsEdEstado);
    end;
  end
  else
    VerificarCidadeExiste;
end;

procedure TfrmPesquisarAgenciamentos.spBtnBuscaCidadeClick(
  Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('CIDADE'))then
  begin
    MessageDlg('Um estado deve estar selecionado.', mtInformation, [mbOK], 0);
    FoFuncoes.focarComponente(plsEdEstado);
  end
  else
    AbreTelaSelecaoCidade(fnSELECIONAR_CIDADE_NORMAL);
end;

procedure TfrmPesquisarAgenciamentos.plsEdBairroExit(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('BAIRRO'))then
  begin
    if(Trim(plsEdBairro.Text) <> STRING_INDEFINIDO)then
    begin
      MessageDlg('Uma cidade deve estar selecionada.', mtInformation, [mbOK], 0);
      plsEdBairro.Clear;
      FoFuncoes.focarComponente(plsEdCidade);
    end;
  end
  else
    VerificarBairroExiste;
end;

procedure TfrmPesquisarAgenciamentos.spBtnBuscaBairroClick(
  Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('BAIRRO'))then
  begin
    MessageDlg('Uma cidade deve estar selecionada.', mtInformation, [mbOK], 0);
    FoFuncoes.focarComponente(plsEdCidade);
  end
  else
    AbreTelaSelecaoBairro(fnSELECIONAR_BAIRRO_NORMAL);
end;

procedure TfrmPesquisarAgenciamentos.plsEdRuaExit(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('RUA'))then
  begin
    if(Trim(plsEdRua.Text) <> STRING_INDEFINIDO)then
    begin
      MessageDlg('Um bairro deve estar selecionado.', mtInformation, [mbOK], 0);
      plsEdRua.Clear;
      FoFuncoes.focarComponente(plsEdBairro);
    end;
  end
  else
    VerificarRuaExiste;
end;

procedure TfrmPesquisarAgenciamentos.spBtnBuscaRuaClick(Sender: TObject);
begin
  inherited;
  if not(validarAcessoEndereco('RUA'))then
  begin
    MessageDlg('Um bairro deve estar selecionado.', mtInformation, [mbOK], 0);
    FoFuncoes.focarComponente(plsEdBairro);
  end
  else
    AbreTelaSelecaoRua(fnSELECIONAR_RUA_NORMAL);
end;

procedure TfrmPesquisarAgenciamentos.lblDescricaoClick(Sender: TObject);
var
  vParametros: OleVariant;
begin
  vParametros := VarArrayCreate([0,0], varVariant);
  vParametros[0] := nRECEBER_CARAC_PESQUISAR_AGENCIAMENTO_DESCRICAO;

  Application.CreateForm(TfrmSelecionarCaracImovel, frmSelecionarCaracImovel);
  frmSelecionarCaracImovel.passarParametro(PRM_DEFINE_QUEM_RECEBE_CARACTERISTICAS_IMOVEL, vParametros);
  frmSelecionarCaracImovel.Show;
end;

end.
