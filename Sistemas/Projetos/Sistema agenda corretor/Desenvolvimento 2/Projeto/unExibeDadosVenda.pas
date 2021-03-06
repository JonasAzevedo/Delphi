unit unExibeDadosVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unExibeDados, StdCtrls, Buttons, ExtCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmExibeDadosVenda = class(TfrmExibeDados)
    lblVenda: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblImovel: TLabel;
    pnlVenda: TPanel;
    lblObservacao: TLabel;
    lblNomeObservacao: TLabel;
    lblNomePercentualSobreComissao: TLabel;
    lblNomeValorTotalComissao: TLabel;
    lblNomePercentualSobreVenda: TLabel;
    lblPercentualSobreVenda: TLabel;
    lblValorTotalComissao: TLabel;
    lblPercentualSobreComissao: TLabel;
    lblValorCalculoComissao: TLabel;
    lblNomeValorCalculoComissao: TLabel;
    lblTipoCalculoComissao: TLabel;
    lblNomeTipoCalculoComissao: TLabel;
    lblNomeValorBemNegociavel: TLabel;
    lblValorBemNegociavel: TLabel;
    lblDeduziuBemNegociavelValorVenda: TLabel;
    lblDeducoes: TLabel;
    lblNomeDeducoes: TLabel;
    lblNomeValorVenda: TLabel;
    lblValorVenda: TLabel;
    lblTipoVenda: TLabel;
    lblNomeTipoVenda: TLabel;
    lblNomeTipoPessoa: TLabel;
    lblNomeCodigoVenda: TLabel;
    lblCodigoVenda: TLabel;
    lblTipoPessoa: TLabel;
    lblNomeAtivo: TLabel;
    lblAtivo: TLabel;
    lblNomeNomePessoa: TLabel;
    lblNomePessoa: TLabel;
    lblDataCancelamento: TLabel;
    lblNomeDataCancelamento: TLabel;
    lblDataVenda: TLabel;
    lblNomeDataVenda: TLabel;
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
    zQryVenda: TZQuery;
    zQryVendaCODIGO_VENDA: TIntegerField;
    zQryVendaATIVO: TStringField;
    zQryVendaDATA_VENDA: TDateField;
    zQryVendaDATA_CANCELAMENTO: TDateTimeField;
    zQryVendaTIPO_PESSOA: TStringField;
    zQryVendaNOME_TIPO_PESSOA: TStringField;
    zQryVendaTIPO_VENDA: TStringField;
    zQryVendaCOD_FK_AGENCIAMENTO: TIntegerField;
    zQryVendaNOME_CONSTRUTORA: TStringField;
    zQryVendaVALOR_VENDA: TFloatField;
    zQryVendaDEDUCOES: TFloatField;
    zQryVendaVALOR_BEM_NEGOCIAVEL: TFloatField;
    zQryVendaDEDUZIR_BEM_NEGOC_VALOR_VENDA: TStringField;
    zQryVendaTIPO_CALCULO_COMISSAO: TStringField;
    zQryVendaVALOR_PARA_CALCULO_COMISSAO: TFloatField;
    zQryVendaPERCENTUAL_SOBRE_VENDA: TFloatField;
    zQryVendaPERCENTUAL_SOBRE_COMISSAO: TFloatField;
    zQryVendaVALOR_TOTAL_COMISSAO: TFloatField;
    zQryVendaOBSERVACAO: TStringField;
    zQryVendaCODIGO_IMOVEL: TIntegerField;
    zQryVendaSTATUS: TSmallintField;
    zQryVendaSITUACAO_DESEJAVEL: TStringField;
    zQryVendaNOME_TIPO_IMOVEL: TStringField;
    zQryVendaVALOR_IMOVEL: TFloatField;
    zQryVendaDESCRICAO: TStringField;
    zQryVendaSIGLA: TStringField;
    zQryVendaNOME_CIDADE: TStringField;
    zQryVendaNOME_BAIRRO: TStringField;
    zQryVendaNOME_RUA: TStringField;
    zQryVendaCEP: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure lblTipoVendaClick(Sender: TObject);
  private
    FnAgenciamento: Integer; //exibir dados do agenciamento vendido
    procedure PesquisarVenda(pnCodVenda:Integer);
    procedure MostrarDadosVenda;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); dynamic; //passando par�metros
  end;

var
  frmExibeDadosVenda: TfrmExibeDadosVenda;

implementation

uses
  unConstantes, unDM, unExibeDadosAgenciamento;

{$R *.dfm}

procedure TfrmExibeDadosVenda.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_PESQUISAR_VENDA)then
  begin
    if(VarIsNumeric(pValores))then
      PesquisarVenda(pValores);
  end;
end;

procedure TfrmExibeDadosVenda.PesquisarVenda(pnCodVenda:Integer);
begin
  zQryVenda.Close;
  zQryVenda.SQL.Clear;
  zQryVenda.SQL.Add('SELECT v.codigo AS CODIGO_VENDA,v.ativo,v.data_venda,v.data_cancelamento,');
  zQryVenda.SQL.Add('v.tipo_pessoa,');
  zQryVenda.SQL.Add('CASE WHEN v.tipo_pessoa = ''F�SICA'' THEN pf.nome ');
  zQryVenda.SQL.Add('WHEN v.tipo_pessoa = ''JUR�DICA'' THEN pj.nome ');
  zQryVenda.SQL.Add('ELSE '''' END AS NOME_TIPO_PESSOA,');
  zQryVenda.SQL.Add('v.tipo_venda,v.cod_fk_agenciamento,const.nome AS NOME_CONSTRUTORA,');
  zQryVenda.SQL.Add('v.valor_venda,v.deducoes,');
  zQryVenda.SQL.Add('v.valor_bem_negociavel,v.deduzir_bem_negoc_valor_venda,');
  zQryVenda.SQL.Add('v.tipo_calculo_comissao,v.valor_para_calculo_comissao,');
  zQryVenda.SQL.Add('v.percentual_sobre_venda,v.percentual_sobre_comissao,v.valor_total_comissao,');
  zQryVenda.SQL.Add('v.observacao,');
  zQryVenda.SQL.Add('i.codigo AS CODIGO_IMOVEL,i.status,');
  zQryVenda.SQL.Add('i.situacao_desejavel,');
  zQryVenda.SQL.Add('ti.nome AS NOME_TIPO_IMOVEL,');
  zQryVenda.SQL.Add('i.valor_imovel,');
  zQryVenda.SQL.Add('i.descricao,');
  zQryVenda.SQL.Add('est.sigla,');
  zQryVenda.SQL.Add('cid.nome AS NOME_CIDADE,');
  zQryVenda.SQL.Add('bai.nome AS NOME_BAIRRO,');
  zQryVenda.SQL.Add('rua.nome AS NOME_RUA,');
  zQryVenda.SQL.Add('rua.cep');
  zQryVenda.SQL.Add('FROM vendas v ');
  zQryVenda.SQL.Add('LEFT JOIN cliente_pessoa_fisica pf ON v.cod_fk_cliente_pessoa_fisica = pf.codigo ');
  zQryVenda.SQL.Add('LEFT JOIN cliente_pessoa_juridica pj ON v.cod_fk_cliente_pessoa_juridica = pj.codigo ');
  zQryVenda.SQL.Add('LEFT JOIN construtora const ON v.cod_fk_tp_vnd_construtora = const.codigo ');
  zQryVenda.SQL.Add('JOIN imovel i ON v.cod_fk_imovel = i.codigo ');
  zQryVenda.SQL.Add('JOIN tipo_imovel ti ON i.cod_fk_tipo_imovel = ti.codigo ');
  zQryVenda.SQL.Add('JOIN estado est ON i.cod_fk_estado = est.codigo ');
  zQryVenda.SQL.Add('JOIN cidade cid ON i.cod_fk_cidade = cid.codigo ');
  zQryVenda.SQL.Add('JOIN bairro bai ON i.cod_fk_bairro = bai.codigo ');
  zQryVenda.SQL.Add('JOIN rua rua ON i.cod_fk_rua = rua.codigo ');
  zQryVenda.SQL.Add('WHERE v.codigo = :codigo');
  zQryVenda.ParamByName('codigo').AsInteger := pnCodVenda;
  zQryVenda.Open;
  if(zQryVenda.Active)and(zQryVenda.RecordCount=1)then
    MostrarDadosVenda
  else
  begin
    MessageDlg('Venda n�o encontrada.',mtInformation,[mbOK],0);
    //Self.Close;
  end;
end;

procedure TfrmExibeDadosVenda.MostrarDadosVenda;

  function GetDeduziuBemNegociavelValorVenda: Boolean;
  begin
    if(zQryVendaDEDUZIR_BEM_NEGOC_VALOR_VENDA.AsString = VLR_SIM)then
      Result := True
    else
      Result := False;
  end;

  procedure VerificarTipoVendaMeuAgenciamento;
  begin
    if(zQryVendaTIPO_VENDA.AsString = 'MEU AGENCIAMENTO')then
    begin
      lblTipoVenda.Cursor := crHandPoint;
      lblTipoVenda.Font.Style :=  [fsUnderline];
      FnAgenciamento := zQryVendaCOD_FK_AGENCIAMENTO.AsInteger;
    end;
  end;

begin
  lblCodigoVenda.Caption := zQryVendaCODIGO_VENDA.AsString;
  lblAtivo.Caption := zQryVendaATIVO.AsString;
  lblDataVenda.Caption := zQryVendaDATA_VENDA.AsString;
  lblDataCancelamento.Caption := zQryVendaDATA_CANCELAMENTO.AsString;
  lblTipoPessoa.Caption := zQryVendaTIPO_PESSOA.AsString;
  lblNomePessoa.Caption := zQryVendaNOME_TIPO_PESSOA.AsString;
  lblTipoVenda.Caption := zQryVendaTIPO_VENDA.AsString;
  VerificarTipoVendaMeuAgenciamento;
  lblValorVenda.Caption := FoFuncoes.formatarValorMonetario(zQryVendaVALOR_VENDA.AsString);
  lblDeducoes.Caption := FoFuncoes.formatarValorMonetario(zQryVendaDEDUCOES.AsString);
  lblValorBemNegociavel.Caption := FoFuncoes.formatarValorMonetario(zQryVendaVALOR_BEM_NEGOCIAVEL.AsString);
  lblDeduziuBemNegociavelValorVenda.Visible := GetDeduziuBemNegociavelValorVenda;
  lblTipoCalculoComissao.Caption := zQryVendaTIPO_CALCULO_COMISSAO.AsString;
  lblValorCalculoComissao.Caption := FoFuncoes.formatarValorMonetario(zQryVendaVALOR_PARA_CALCULO_COMISSAO.AsString);
  lblPercentualSobreVenda.Caption := FoFuncoes.formatarValorMonetario(zQryVendaPERCENTUAL_SOBRE_VENDA.AsString);
  lblPercentualSobreComissao.Caption := FoFuncoes.formatarValorMonetario(zQryVendaPERCENTUAL_SOBRE_COMISSAO.AsString);
  lblValorTotalComissao.Caption := FoFuncoes.formatarValorMonetario(zQryVendaVALOR_TOTAL_COMISSAO.AsString);
  lblObservacao.Caption := zQryVendaOBSERVACAO.AsString;

  lblCodigoImovel.Caption := zQryVendaCODIGO_IMOVEL.AsString;
  lblStatus.Caption := zQryVendaSTATUS.AsString;
  lblSituacaoDesejavel.Caption := zQryVendaSITUACAO_DESEJAVEL.AsString;
  lblTipoImovel.Caption := zQryVendaNOME_TIPO_IMOVEL.AsString;
  lblValorImovel.Caption := FoFuncoes.formatarValorMonetario(zQryVendaVALOR_IMOVEL.AsString);
  lblDescricao.Caption := zQryVendaDESCRICAO.AsString;
  lblUF.Caption := zQryVendaSIGLA.AsString;
  lblCidade.Caption := zQryVendaNOME_CIDADE.AsString;
  lblBairro.Caption := zQryVendaNOME_BAIRRO.AsString;
  lblRua.Caption := zQryVendaNOME_RUA.AsString;
  lblCEP.Caption := zQryVendaCEP.AsString;
end;

procedure TfrmExibeDadosVenda.FormCreate(Sender: TObject);
begin
  inherited;
  FnAgenciamento := NUMERO_INDEFINIDO;
end;

procedure TfrmExibeDadosVenda.lblTipoVendaClick(Sender: TObject);
begin
  inherited;
  if(FnAgenciamento <> NUMERO_INDEFINIDO)then
  begin
    try
      Application.CreateForm(TfrmExibeDadosAgenciamento,frmExibeDadosAgenciamento);
      frmExibeDadosAgenciamento.passarParametro(PRM_PESQUISAR_AGENCIAMENTO,FnAgenciamento);
      frmExibeDadosAgenciamento.ShowModal;
    finally
      FreeAndNil(frmExibeDadosAgenciamento);
    end;
  end;
end;

end.
