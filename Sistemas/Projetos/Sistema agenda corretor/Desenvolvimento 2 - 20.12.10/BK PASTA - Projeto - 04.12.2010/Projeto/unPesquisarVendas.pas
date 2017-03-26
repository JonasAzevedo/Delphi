unit unPesquisarVendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisa, DB, DBClient, Provider, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  plsComboBox, Mask, plsTMaskEdit, plsEdit, unVariaveis;

type
  TfrmPesquisarVendas = class(TfrmPesquisar)
    lblCodigo: TLabel;
    plsEdCodigo: TPlsEdit;
    pnlTipoVenda: TPanel;
    lblTipoVenda: TLabel;
    lblCampoObrigatorio5: TLabel;
    lblImovelDe: TLabel;
    Label2: TLabel;
    plsCbBxTipoVenda: TPlsComboBox;
    plsCbBxImovelDe: TPlsComboBox;
    grpBxDataVenda: TGroupBox;
    lblEntreDataVenda: TLabel;
    plsMedDataVendaInicio: TPlsMaskEdit;
    plsMedDataVendaFinal: TPlsMaskEdit;
    grpBxValorVenda: TGroupBox;
    lblEntreValorVenda: TLabel;
    plsMedValorVendaInicio: TPlsEdit;
    plsMedValorVendaFim: TPlsEdit;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_VENDA: TDateField;
    zQryDadosATIVO: TStringField;
    zQryDadosTIPO_VENDA: TStringField;
    zQryDadosIMOVEL_DE: TStringField;
    zQryDadosVENDA_MEU_AGENCIAMENTO_MEU: TStringField;
    zQryDadosVENDA_MEU_AGENCIAMENTO_COLEGAS: TStringField;
    zQryDadosVENDA_PAUTA_CONSTRUTORA: TStringField;
    zQryDadosVENDA_PAUTA_TERCEIROS: TStringField;
    zQryDadosVALOR_VENDA: TFloatField;
    zQryDadosDEDUCOES: TFloatField;
    zQryDadosVALOR_BEM_NEGOCIAVEL: TFloatField;
    zQryDadosDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField;
    zQryDadosVALOR_PARA_CALCULO_COMISSAO: TFloatField;
    zQryDadosPERCENTUAL_SOBRE_VENDA: TFloatField;
    zQryDadosVALOR_TOTAL_COMISSAO: TFloatField;
    zQryDadosPERCENTUAL_SOBRE_COMISSAO: TFloatField;
    zQryDadosOBSERVACAO: TStringField;
    zQryDadosDATA_CANCELAMENTO: TDateTimeField;
    zQryDadosNOME_CLIENTE: TStringField;
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
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_VENDA: TDateField;
    cdsDadosATIVO: TStringField;
    cdsDadosTIPO_VENDA: TStringField;
    cdsDadosIMOVEL_DE: TStringField;
    cdsDadosVENDA_MEU_AGENCIAMENTO_MEU: TStringField;
    cdsDadosVENDA_MEU_AGENCIAMENTO_COLEGAS: TStringField;
    cdsDadosVENDA_PAUTA_CONSTRUTORA: TStringField;
    cdsDadosVENDA_PAUTA_TERCEIROS: TStringField;
    cdsDadosVALOR_VENDA: TFloatField;
    cdsDadosDEDUCOES: TFloatField;
    cdsDadosVALOR_BEM_NEGOCIAVEL: TFloatField;
    cdsDadosDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField;
    cdsDadosVALOR_PARA_CALCULO_COMISSAO: TFloatField;
    cdsDadosPERCENTUAL_SOBRE_VENDA: TFloatField;
    cdsDadosVALOR_TOTAL_COMISSAO: TFloatField;
    cdsDadosPERCENTUAL_SOBRE_COMISSAO: TFloatField;
    cdsDadosOBSERVACAO: TStringField;
    cdsDadosDATA_CANCELAMENTO: TDateTimeField;
    cdsDadosNOME_CLIENTE: TStringField;
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
    procedure plsCbBxTipoVendaChange(Sender: TObject);
    procedure plsCbBxImovelDeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FoTipoVenda: TTiposVendas;
    FoTipoImovelDe: TTiposImoveisDe;
    procedure popularComboBoxImovelDe();
  public
    procedure PassarParametro(pTipo:String; pValores:OleVariant); override;
  protected
    procedure SelecionarTodosDados(); override;
    procedure Pesquisar(); override;
  end;
var
  frmPesquisarVendas: TfrmPesquisarVendas;

implementation

uses
  unConstantes;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmPesquisarVendas.PassarParametro(pTipo:String; pValores:OleVariant);
begin

end;

procedure TfrmPesquisarVendas.SelecionarTodosDados();
begin
  cdsDados.Close;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT v.codigo,v.data_venda,v.ativo,v.tipo_venda,');
  zQryDados.SQL.Add('CASE WHEN v.venda_meu_agenciamento_meu = ''SIM'' THEN ''MEU'' ');
  zQryDados.SQL.Add('WHEN v.venda_meu_agenciamento_colegas = ''SIM'' THEN ''COLEGAS'' ');
  zQryDados.SQL.Add('WHEN v.venda_pauta_construtora = ''SIM'' THEN ''CONSTRUTORA'' ');
  zQryDados.SQL.Add('WHEN v.venda_pauta_terceiros = ''SIM'' THEN ''TERCEIROS'' ');
  zQryDados.SQL.Add('ELSE '''' END AS IMOVEL_DE,');
  zQryDados.SQL.Add('v.venda_meu_agenciamento_meu,v.venda_meu_agenciamento_colegas,');
  zQryDados.SQL.Add('v.venda_pauta_construtora,v.venda_pauta_terceiros,');
  zQryDados.SQL.Add('v.valor_venda,v.deducoes,v.valor_bem_negociavel,v.deduzir_bem_negoc_valor_venda,');
  zQryDados.SQL.Add('v.valor_para_calculo_comissao,v.percentual_sobre_venda,v.valor_total_comissao,');
  zQryDados.SQL.Add('v.percentual_sobre_comissao,v.observacao,v.data_cancelamento,');
  zQryDados.SQL.Add('c.nome AS NOME_CLIENTE,');
  zQryDados.SQL.Add('i.codigo AS CODIGO_IMOVEL,i.status AS STATUS_IMOVEL,i.situacao_desejavel,');
  zQryDados.SQL.Add('CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL_IMOVEL,');
  zQryDados.SQL.Add('i.descricao AS DESCRICAO_IMOVEL,');
  zQryDados.SQL.Add('ti.codigo AS CODIGO_TIPO_IMOVEL,ti.nome AS NOME_TIPO_IMOVEL,');
  zQryDados.SQL.Add('est.codigo AS CODIGO_ESTADO,est.sigla AS SIGLA_ESTADO,');
  zQryDados.SQL.Add('cid.codigo AS CODIGO_CIDADE,cid.nome AS NOME_CIDADE,');
  zQryDados.SQL.Add('bai.codigo AS CODIGO_BAIRRO,bai.nome AS NOME_BAIRRO,');
  zQryDados.SQL.Add('rua.codigo AS CODIGO_RUA,rua.nome AS NOME_RUA,rua.cep AS CEP_RUA ');
  zQryDados.SQL.Add('FROM vendas v ');
  zQryDados.SQL.Add('JOIN cliente c ON v.cod_fk_cliente = c.codigo ');
  zQryDados.SQL.Add('JOIN imovel i ON v.cod_fk_imovel = i.codigo ');
  zQryDados.SQL.Add('JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ');
  zQryDados.SQL.Add('JOIN estado est ON i.cod_fk_estado = est.codigo ');
  zQryDados.SQL.Add('JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ');
  zQryDados.SQL.Add('JOIN bairro bai ON i.cod_fk_bairro = bai.codigo ');
  zQryDados.SQL.Add('JOIN rua rua ON i.cod_fk_rua = rua.codigo ');
  zQryDados.SQL.Add('ORDER BY v.codigo');
  zQryDados.Open;
  cdsDados.Open;
end;

procedure TfrmPesquisarVendas.Pesquisar();
var
  nCodigo: Integer;
  dtDataVendaInicio,dtDataVendaFim: TDate;
  dValorTotalInicio,dValorTotalFim: Currency;
  sTipoVenda: String;
  sImovelDeMeuAgenciamentoMeu,sImovelDeMeuAgenciamentoColegas: String;
  sImovelDePautaConstrutora,sImovelDePautaTerceiros: String;

  bUsouWhere: Boolean;

  procedure CarregarValores();
  begin
    nCodigo := FoFuncoes.formatarValorInteiro(plsEdCodigo.Text);
    dtDataVendaInicio := FoFuncoes.formatarData(plsMedDataVendaInicio.Text);
    dtDataVendaFim := FoFuncoes.formatarData(plsMedDataVendaFinal.Text);
    dValorTotalInicio := FoFuncoes.formatarValorCurrency(plsMedValorVendaInicio.Text,True);
    dValorTotalFim := FoFuncoes.formatarValorCurrency(plsMedValorVendaFim.Text,True);

    case plsCbBxTipoVenda.ItemIndex of
      0: sTipoVenda := TIPO_VENDA_MEU_AGENCIAMENTO;
      1: sTipoVenda := TIPO_VENDA_PAUTA;
    else
      sTipoVenda := STRING_INDEFINIDO;
    end;


    sImovelDeMeuAgenciamentoMeu := VLR_NAO;
    sImovelDeMeuAgenciamentoColegas := VLR_NAO;
    sImovelDePautaConstrutora := VLR_NAO;
    sImovelDePautaTerceiros := VLR_NAO;

    case plsCbBxImovelDe.ItemIndex of
      0:
      begin
        case plsCbBxTipoVenda.ItemIndex of
          0: sImovelDeMeuAgenciamentoMeu := VLR_SIM; //tipo venda = meu agenciamento, imóvel de = meu
          1: sImovelDePautaConstrutora := VLR_SIM; //tipo venda = pauta, imóvel de = construtora
        end;
      end;
      1:
      begin
        case plsCbBxTipoVenda.ItemIndex of
          0: sImovelDeMeuAgenciamentoColegas := VLR_SIM; //tipo venda = meu agenciamento, imóvel de = colegas
          1: sImovelDePautaTerceiros := VLR_SIM; //tipo venda = pauta, imóvel de = terceiros
        end;
      end;
    end;
  end;

begin
  CarregarValores();
  bUsouWhere := False;

  cdsDados.Close;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT v.codigo,v.data_venda,v.ativo,v.tipo_venda,');
  zQryDados.SQL.Add('CASE WHEN v.venda_meu_agenciamento_meu = ''SIM'' THEN ''MEU'' ');
  zQryDados.SQL.Add('WHEN v.venda_meu_agenciamento_colegas = ''SIM'' THEN ''COLEGAS'' ');
  zQryDados.SQL.Add('WHEN v.venda_pauta_construtora = ''SIM'' THEN ''CONSTRUTORA'' ');
  zQryDados.SQL.Add('WHEN v.venda_pauta_terceiros = ''SIM'' THEN ''TERCEIROS'' ');
  zQryDados.SQL.Add('ELSE '''' END AS IMOVEL_DE,');
  zQryDados.SQL.Add('v.venda_meu_agenciamento_meu,v.venda_meu_agenciamento_colegas,');
  zQryDados.SQL.Add('v.venda_pauta_construtora,v.venda_pauta_terceiros,');
  zQryDados.SQL.Add('v.valor_venda,v.deducoes,v.valor_bem_negociavel,v.deduzir_bem_negoc_valor_venda,');
  zQryDados.SQL.Add('v.valor_para_calculo_comissao,v.percentual_sobre_venda,v.valor_total_comissao,');
  zQryDados.SQL.Add('v.percentual_sobre_comissao,v.observacao,v.data_cancelamento,');
  zQryDados.SQL.Add('c.nome AS NOME_CLIENTE,');
  zQryDados.SQL.Add('i.codigo AS CODIGO_IMOVEL,i.status AS STATUS_IMOVEL,i.situacao_desejavel,');
  zQryDados.SQL.Add('CAST(i.valor_imovel AS VARCHAR(20)) AS CC_VALOR_IMOVEL_IMOVEL,');
  zQryDados.SQL.Add('i.descricao AS DESCRICAO_IMOVEL,');
  zQryDados.SQL.Add('ti.codigo AS CODIGO_TIPO_IMOVEL,ti.nome AS NOME_TIPO_IMOVEL,');
  zQryDados.SQL.Add('est.codigo AS CODIGO_ESTADO,est.sigla AS SIGLA_ESTADO,');
  zQryDados.SQL.Add('cid.codigo AS CODIGO_CIDADE,cid.nome AS NOME_CIDADE,');
  zQryDados.SQL.Add('bai.codigo AS CODIGO_BAIRRO,bai.nome AS NOME_BAIRRO,');
  zQryDados.SQL.Add('rua.codigo AS CODIGO_RUA,rua.nome AS NOME_RUA,rua.cep AS CEP_RUA ');
  zQryDados.SQL.Add('FROM vendas v ');
  zQryDados.SQL.Add('JOIN cliente c ON v.cod_fk_cliente = c.codigo ');
  zQryDados.SQL.Add('JOIN imovel i ON v.cod_fk_imovel = i.codigo ');
  zQryDados.SQL.Add('JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ');
  zQryDados.SQL.Add('JOIN estado est ON i.cod_fk_estado = est.codigo ');
  zQryDados.SQL.Add('JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ');
  zQryDados.SQL.Add('JOIN bairro bai ON i.cod_fk_bairro = bai.codigo ');
  zQryDados.SQL.Add('JOIN rua rua ON i.cod_fk_rua = rua.codigo ');

  if(nCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add('WHERE v.codigo = :codigo ');
    zQryDados.ParamByName('codigo').AsInteger := nCodigo;
    bUsouWhere := True;
  end;
  
  if(dtDataVendaInicio <> NUMERO_INDEFINIDO)and(dtDataVendaFim <> NUMERO_INDEFINIDO)then
  begin
    if(not(bUsouWhere))then
      zQryDados.SQL.Add('WHERE v.data_venda BETWEEN :dtVendaInicio AND :dtVendaFim ')
    else
      zQryDados.SQL.Add('AND v.data_venda BETWEEN :dtVendaInicio AND :dtVendaFim ');

    zQryDados.ParamByName('dtVendaInicio').AsDate := dtDataVendaInicio;
    zQryDados.ParamByName('dtVendaFim').AsDate := dtDataVendaFim;
    bUsouWhere := True;
  end;

  if(dValorTotalInicio <> NUMERO_INDEFINIDO)and(dValorTotalInicio <> NUMERO_INDEFINIDO)then
  begin
    if(not(bUsouWhere))then
      zQryDados.SQL.Add('WHERE v.valor_venda BETWEEN :valorVendaInicio AND :valorVendaFim ')
    else
      zQryDados.SQL.Add('AND v.valor_venda BETWEEN :valorVendaInicio AND :valorVendaFim ');

    zQryDados.ParamByName('valorVendaInicio').AsCurrency := dValorTotalInicio;
    zQryDados.ParamByName('valorVendaFim').AsCurrency := dValorTotalFim;
    bUsouWhere := True;
  end;

  if(sTipoVenda <> STRING_INDEFINIDO)then
  begin
    if(not(bUsouWhere))then
      zQryDados.SQL.Add('WHERE v.tipo_venda = :tipo_venda ')
    else
      zQryDados.SQL.Add('AND v.tipo_venda = :tipo_venda ');

    zQryDados.ParamByName('tipo_venda').AsString := sTipoVenda;
    bUsouWhere := True;
  end;

  if(sImovelDeMeuAgenciamentoMeu = VLR_SIM)then
  begin
    if(not(bUsouWhere))then
      zQryDados.SQL.Add('WHERE v.venda_meu_agenciamento_meu = :venda_meu_agenciamento_meu ')
    else
      zQryDados.SQL.Add('AND v.venda_meu_agenciamento_meu = :venda_meu_agenciamento_meu ');

    zQryDados.ParamByName('venda_meu_agenciamento_meu').AsString := VLR_SIM;
    bUsouWhere := True;
  end;

  if(sImovelDeMeuAgenciamentoColegas = VLR_SIM)then
  begin
    if(not(bUsouWhere))then
      zQryDados.SQL.Add('WHERE v.venda_meu_agenciamento_colegas = :venda_meu_agenciamento_colegas ')
    else
      zQryDados.SQL.Add('AND v.venda_meu_agenciamento_colegas = :venda_meu_agenciamento_colegas ');

    zQryDados.ParamByName('venda_meu_agenciamento_colegas').AsString := VLR_SIM;
    bUsouWhere := True;
  end;

  if(sImovelDePautaConstrutora = VLR_SIM)then
  begin
    if(not(bUsouWhere))then
      zQryDados.SQL.Add('WHERE v.venda_pauta_construtora = :venda_pauta_construtora ')
    else
      zQryDados.SQL.Add('AND v.venda_pauta_construtora = :venda_pauta_construtora ');

    zQryDados.ParamByName('venda_pauta_construtora').AsString := VLR_SIM;
    bUsouWhere := True;
  end;

  if(sImovelDePautaTerceiros = VLR_SIM)then
  begin
    if(not(bUsouWhere))then
      zQryDados.SQL.Add('WHERE v.venda_pauta_terceiros = :venda_pauta_terceiros ')
    else
      zQryDados.SQL.Add('AND v.venda_pauta_terceiros = :venda_pauta_terceiros ');

    zQryDados.ParamByName('venda_pauta_terceiros').AsString := VLR_SIM;
    bUsouWhere := True;
  end;


  zQryDados.SQL.Add('ORDER BY v.codigo');
  zQryDados.Open;
  cdsDados.Open;

  VerificaEncontrouRegistros();
end;

procedure TfrmPesquisarVendas.popularComboBoxImovelDe();
begin
  if(Self.FoTipoVenda = [meu_agenciamento])then
  begin
    plsCbBxImovelDe.Clear;
    plsCbBxImovelDe.Items.Add('MEU');
    plsCbBxImovelDe.Items.Add('COLEGAS');
  end
  else if(Self.FoTipoVenda = [pauta])then
  begin
    plsCbBxImovelDe.Clear;
    plsCbBxImovelDe.Items.Add('CONTRUTORA');
    plsCbBxImovelDe.Items.Add('TERCEIROS');
  end;
  plsCbBxImovelDe.ItemIndex := -1;
end;

(* fim - procedimentos de controle *)

procedure TfrmPesquisarVendas.plsCbBxTipoVendaChange(Sender: TObject);
begin
  inherited;
  case plsCbBxTipoVenda.ItemIndex of
    0: Self.FoTipoVenda := [meu_agenciamento];
    1: Self.FoTipoVenda := [pauta];
    else
      Self.FoTipoVenda := [];
  end;
  popularComboBoxImovelDe();
end;

procedure TfrmPesquisarVendas.plsCbBxImovelDeChange(Sender: TObject);
begin
  inherited;
  Self.FoTipoImovelDe := [];
  case plsCbBxImovelDe.ItemIndex of
    0:
    begin
      case plsCbBxTipoVenda.ItemIndex of
        0: Self.FoTipoImovelDe := [meu]; //tipo venda = meu agenciamento, imóvel de = meu
        1: Self.FoTipoImovelDe := [construtora]; //tipo venda = pauta, imóvel de = construtora
      end;
    end;
    1:
    begin
      case plsCbBxTipoVenda.ItemIndex of
        0: Self.FoTipoImovelDe := [colegas]; //tipo venda = meu agenciamento, imóvel de = colegas
        1: Self.FoTipoImovelDe := [terceiros]; //tipo venda = pauta, imóvel de = terceiros
      end;
    end;
  end;

end;

procedure TfrmPesquisarVendas.FormCreate(Sender: TObject);
begin
  inherited;
  FoTipoVenda := [];
  FoTipoImovelDe := [];
end;

end.
