unit unPesquisarImoveisInteresse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisa, DB, DBClient, Provider, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  Mask, plsTMaskEdit, plsComboBox, plsEdit, Menus;

type
  TfrmPesquisarImoveisInteresse = class(TfrmPesquisar)
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    lblFinalidade: TLabel;
    plsCbBxFinalidade: TPlsComboBox;
    lblSituacao: TLabel;
    plsCbBxSituacao: TPlsComboBox;
    plsCbBxCondicaoPagamento: TPlsComboBox;
    lblCondicaoPagamento: TLabel;
    grpBxDataCaptacao: TGroupBox;
    lblEntreDataCaptacao: TLabel;
    plsMedDataCaptacaoInicio: TPlsMaskEdit;
    plsMedDataCaptacaoFinal: TPlsMaskEdit;
    grpBxValorImovel: TGroupBox;
    lblEntreValorImovel: TLabel;
    plsEdValorImovelInicio: TPlsEdit;
    plsEdValorImovelFim: TPlsEdit;
    zQryDadosCODIGO_IMOVEL_INTERESSE: TIntegerField;
    zQryDadosATIVO: TStringField;
    zQryDadosDATA_CAPTACAO: TDateField;
    zQryDadosFINALIDADE_IMOVEL: TStringField;
    zQryDadosIMOVEL_DESEJAVEL: TStringField;
    zQryDadosCC_VALOR_IMOVEL: TStringField;
    zQryDadosCONDICAO_PAGAMENTO: TStringField;
    zQryDadosCC_PGTO_VISTA_CACH: TStringField;
    zQryDadosCC_PGTO_VISTA_VALOR_BEM: TStringField;
    zQryDadosPGTO_VISTA_DESCRICAO_BEM: TStringField;
    zQryDadosCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField;
    zQryDadosCC_PGTO_FINCTO_CACH: TStringField;
    zQryDadosCC_PGTO_FINCTO_VALOR_BEM: TStringField;
    zQryDadosPGTO_FINCTO_DESCRICAO_BEM: TStringField;
    zQryDadosOBSERVACAO: TStringField;
    zQryDadosDATA_BAIXA: TDateTimeField;
    zQryDadosCARACTERISTICAS: TStringField;
    zQryDadosNOME_CLIENTE: TStringField;
    zQryDadosNOME_TIPO_IMOVEL: TStringField;
    cdsDadosCODIGO_IMOVEL_INTERESSE: TIntegerField;
    cdsDadosATIVO: TStringField;
    cdsDadosDATA_CAPTACAO: TDateField;
    cdsDadosFINALIDADE_IMOVEL: TStringField;
    cdsDadosIMOVEL_DESEJAVEL: TStringField;
    cdsDadosCC_VALOR_IMOVEL: TStringField;
    cdsDadosCONDICAO_PAGAMENTO: TStringField;
    cdsDadosCC_PGTO_VISTA_CACH: TStringField;
    cdsDadosCC_PGTO_VISTA_VALOR_BEM: TStringField;
    cdsDadosPGTO_VISTA_DESCRICAO_BEM: TStringField;
    cdsDadosCC_PGTO_FINCTO_CACH_FINANCIADO: TStringField;
    cdsDadosCC_PGTO_FINCTO_CACH: TStringField;
    cdsDadosCC_PGTO_FINCTO_VALOR_BEM: TStringField;
    cdsDadosPGTO_FINCTO_DESCRICAO_BEM: TStringField;
    cdsDadosOBSERVACAO: TStringField;
    cdsDadosDATA_BAIXA: TDateTimeField;
    cdsDadosCARACTERISTICAS: TStringField;
    cdsDadosNOME_CLIENTE: TStringField;
    cdsDadosNOME_TIPO_IMOVEL: TStringField;
    ppMnDivisao: TMenuItem;
    ppMnDarBaixa: TMenuItem;
    lblStatus: TLabel;
    plsCbBxStatus: TPlsComboBox;
    procedure ppMnDarBaixaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  frmPesquisarImoveisInteresse: TfrmPesquisarImoveisInteresse;

implementation

uses
  unConstantes, unDM;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmPesquisarImoveisInteresse.PassarParametro(pTipo:String; pValores:OleVariant);
begin

end;

procedure TfrmPesquisarImoveisInteresse.SelecionarTodosDados();
begin
  cdsDados.Close;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT i.codigo AS CODIGO_IMOVEL_INTERESSE,i.ativo,i.data_captacao,');
  zQryDados.SQL.Add('i.finalidade_imovel,i.imovel_desejavel,');
  zQryDados.SQL.Add('CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL,i.condicao_pagamento,');
  zQryDados.SQL.Add('CAST(i.pgto_vista_cach AS VARCHAR(20)) AS CC_PGTO_VISTA_CACH,');
  zQryDados.SQL.Add('CAST(i.pgto_vista_valor_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_VALOR_BEM,');
  zQryDados.SQL.Add('i.pgto_vista_descricao_bem,');
  zQryDados.SQL.Add('CAST(i.pgto_fincto_cach_financiado AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH_FINANCIADO,');
  zQryDados.SQL.Add('CAST(i.pgto_fincto_cach AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH,');
  zQryDados.SQL.Add('CAST(i.pgto_fincto_valor_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_VALOR_BEM,');
  zQryDados.SQL.Add('i.pgto_fincto_descricao_bem,');
  zQryDados.SQL.Add('i.observacao,i.data_baixa,i.caracteristicas,');
  zQryDados.SQL.Add('t.nome AS NOME_TIPO_IMOVEL,');
  zQryDados.SQL.Add('i.tipo_pessoa,');
  zQryDados.SQL.Add('CASE WHEN i.tipo_pessoa = ''FÍSICA'' THEN pf.nome ');
  zQryDados.SQL.Add('WHEN i.tipo_pessoa = ''JURÍDICA'' THEN pj.nome ');
  zQryDados.SQL.Add('ELSE ''NENHUMA'' END AS NOME_CLIENTE ');
  zQryDados.SQL.Add('FROM imovel_de_interesse i ');
  zQryDados.SQL.Add('JOIN tipo_imovel t ON i.cod_fk_tipo_imovel = t.codigo ');
  zQryDados.SQL.Add('LEFT JOIN cliente_pessoa_fisica pf ON i.cod_fk_cliente_pessoa_fisica = pf.codigo ');
  zQryDados.SQL.Add('LEFT JOIN cliente_pessoa_juridica pj ON i.cod_fk_cliente_pessoa_juridica = pj.codigo ');
  zQryDados.SQL.Add(Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('i'));
  zQryDados.SQL.Add('AND i.ativo = :ativo');
  zQryDados.ParamByName('ativo').AsString := VLR_SIM;
  zQryDados.SQL.Add('ORDER BY i.codigo');
  zQryDados.Open;
  cdsDados.Open;
end;

procedure TfrmPesquisarImoveisInteresse.Pesquisar();
var
  nCodigo: Integer;
  sAtivo: String;
  dtDataCaptacaoInicio,dtDataCaptacaoFim: TDate;
  sFinalidade: String;
  sSituacao: String;
  sCondicaoPagamento: String;
  dValorImovelInicio,dValorImovelFim: Currency;

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

    dtDataCaptacaoInicio := FoFuncoes.formatarData(plsMedDataCaptacaoInicio.Text);
    dtDataCaptacaoFim := FoFuncoes.formatarData(plsMedDataCaptacaoFinal.Text);

    case plsCbBxFinalidade.ItemIndex of
      0: sFinalidade := VLR_FINALIDADE_MORAR;
      1: sFinalidade := VLR_FINALIDADE_INVESTIR;
    else
      sFinalidade := STRING_INDEFINIDO;
    end;

    case plsCbBxSituacao.ItemIndex of
      0: sSituacao := VLR_SITUACAO_PLANTA;
      1: sSituacao := VLR_SITUACAO_PRONTO_PARA_MORAR;
      2: sSituacao := VLR_SITUACAO_DE_TERCEIROS;
    else
      sSituacao := STRING_INDEFINIDO;
    end;

    case plsCbBxCondicaoPagamento.ItemIndex of
      0: sCondicaoPagamento := VLR_CD_PAGAMENTO_VISTA;
      1: sCondicaoPagamento := VLR_CD_PAGAMENTO_ACEITA_FINANCIAMENTO;
    else
      sCondicaoPagamento := STRING_INDEFINIDO;
    end;

    dValorImovelInicio := FoFuncoes.formatarValorCurrency(plsEdValorImovelInicio.Text,True);
    dValorImovelFim := FoFuncoes.formatarValorCurrency(plsEdValorImovelFim.Text,True);
  end;

begin
  CarregarValores();

  cdsDados.Close;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT i.codigo AS CODIGO_IMOVEL_INTERESSE,i.ativo,i.data_captacao,');
  zQryDados.SQL.Add('i.finalidade_imovel,i.imovel_desejavel,');
  zQryDados.SQL.Add('CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL,i.condicao_pagamento,');
  zQryDados.SQL.Add('CAST(i.pgto_vista_cach AS VARCHAR(20)) AS CC_PGTO_VISTA_CACH,');
  zQryDados.SQL.Add('CAST(i.pgto_vista_valor_bem AS VARCHAR(20)) AS CC_PGTO_VISTA_VALOR_BEM,');
  zQryDados.SQL.Add('i.pgto_vista_descricao_bem,');
  zQryDados.SQL.Add('CAST(i.pgto_fincto_cach_financiado AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH_FINANCIADO,');
  zQryDados.SQL.Add('CAST(i.pgto_fincto_cach AS VARCHAR(20)) AS CC_PGTO_FINCTO_CACH,');
  zQryDados.SQL.Add('CAST(i.pgto_fincto_valor_bem AS VARCHAR(20)) AS CC_PGTO_FINCTO_VALOR_BEM,');
  zQryDados.SQL.Add('i.pgto_fincto_descricao_bem,');
  zQryDados.SQL.Add('i.observacao,i.data_baixa,i.caracteristicas,');
  zQryDados.SQL.Add('t.nome AS NOME_TIPO_IMOVEL,');
  zQryDados.SQL.Add('i.tipo_pessoa,');
  zQryDados.SQL.Add('CASE WHEN i.tipo_pessoa = ''FÍSICA'' THEN pf.nome ');
  zQryDados.SQL.Add('WHEN i.tipo_pessoa = ''JURÍDICA'' THEN pj.nome ');
  zQryDados.SQL.Add('ELSE ''NENHUMA'' END AS NOME_CLIENTE');
  zQryDados.SQL.Add('FROM imovel_de_interesse i ');
  zQryDados.SQL.Add('JOIN tipo_imovel t ON i.cod_fk_tipo_imovel = t.codigo ');
  zQryDados.SQL.Add('LEFT JOIN cliente_pessoa_fisica pf ON i.cod_fk_cliente_pessoa_fisica = pf.codigo ');
  zQryDados.SQL.Add('LEFT JOIN cliente_pessoa_juridica pj ON i.cod_fk_cliente_pessoa_juridica = pj.codigo ');
  zQryDados.SQL.Add(Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('i'));

  if(sAtivo <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND i.ativo = :ativo ');
    zQryDados.ParamByName('ativo').AsString := sAtivo;
  end;

  if(nCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND i.codigo = :codigo ');
    zQryDados.ParamByName('codigo').AsInteger := nCodigo;
  end;

  if(dtDataCaptacaoInicio <> NUMERO_INDEFINIDO)and(dtDataCaptacaoFim <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND i.data_captacao BETWEEN :dtDataCapInicio AND :dtDataCapFim ');
    zQryDados.ParamByName('dtDataCapInicio').AsDate := dtDataCaptacaoInicio;
    zQryDados.ParamByName('dtDataCapFim').AsDate := dtDataCaptacaoFim;
  end;

  if(sFinalidade <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND i.finalidade_imovel = :finalidade_imovel ');
    zQryDados.ParamByName('finalidade_imovel').AsString := sFinalidade;
  end;

  if(sSituacao <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND i.imovel_desejavel = :imovel_desejavel ');
    zQryDados.ParamByName('imovel_desejavel').AsString := sSituacao;
  end;

  if(sCondicaoPagamento <> STRING_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND i.condicao_pagamento =:condicao_pagamento ');
    zQryDados.ParamByName('condicao_pagamento').AsString := sCondicaoPagamento;
  end;

  if(dValorImovelInicio <> NUMERO_INDEFINIDO)and(dValorImovelFim <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('AND i.valor_imovel BETWEEN :valorImovelInicio AND :valorImovelFim ');
    zQryDados.ParamByName('valorImovelInicio').AsCurrency := dValorImovelInicio;
    zQryDados.ParamByName('valorImovelFim').AsCurrency := dValorImovelFim;
  end;

  zQryDados.SQL.Add('ORDER BY i.codigo');
  zQryDados.Open;
  cdsDados.Open;

  VerificaEncontrouRegistros();
end;

procedure TfrmPesquisarImoveisInteresse.FormatarValores();
var
  sValorMonetario: String;
begin
  if((cdsDados.Active)and(cdsDados.RecordCount>0))then
  begin
    cdsDados.First;
    while(not(cdsDados.Eof))do
    begin
      cdsDados.Edit;

      sValorMonetario :=  cdsDadosCC_VALOR_IMOVEL.AsString;
      sValorMonetario := StringReplace(sValorMonetario, '.', ',', [rfReplaceAll, rfIgnoreCase]);
      if(sValorMonetario <> STRING_INDEFINIDO)then
        cdsDadosCC_VALOR_IMOVEL.AsString := Self.FoFuncoes.formatarValorMonetario(sValorMonetario);

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

      cdsDados.Post;

      cdsDados.Next;
    end;
  end;
end;

procedure TfrmPesquisarImoveisInteresse.BaixarImovelInteresse();
var
  nCodigo: Integer;
  sCliente: String;
begin
  try
    nCodigo := cdsDados.FieldByName('CODIGO_IMOVEL_INTERESSE').AsInteger;
    sCliente := cdsDados.FieldByName('NOME_CLIENTE').AsString;
  except
    nCodigo := NUMERO_INDEFINIDO;
  end;

  if(nCodigo <> NUMERO_INDEFINIDO)and(nCodigo <> REGISTRO_NULO)then
  begin
    if(MessageDlg('Deseja baixar o imóvel do cliente ' + sCliente + ' ?',
      mtConfirmation, [mbYes,mbNo], 0)=mrYes)then
    begin
      try
        DM.ZConnection.StartTransaction;
        DM.zQryImovelDeInteresse.Close;
        DM.zQryImovelDeInteresse.SQL.Clear;
        DM.zQryImovelDeInteresse.SQL.Add('UPDATE imovel_de_interesse ');
        DM.zQryImovelDeInteresse.SQL.Add('SET ativo = :ativo ');
        DM.zQryImovelDeInteresse.SQL.Add('WHERE codigo = :codigo');
        DM.zQryImovelDeInteresse.ParamByName('ativo').AsString := VLR_NAO;
        DM.zQryImovelDeInteresse.ParamByName('codigo').AsInteger := nCodigo;
        DM.zQryImovelDeInteresse.ExecSQL();
        DM.ZConnection.Commit;
      except
        DM.ZConnection.Rollback;
      end;
      Pesquisar();
    end;
  end;
end;

(* fim - procedimentos de controle *)
      
procedure TfrmPesquisarImoveisInteresse.ppMnDarBaixaClick(Sender: TObject);
begin
  inherited;
  BaixarImovelInteresse();
end;

procedure TfrmPesquisarImoveisInteresse.FormShow(Sender: TObject);
begin
  inherited;
  plsCbBxStatus.ItemIndex := 0;
end;

end.
