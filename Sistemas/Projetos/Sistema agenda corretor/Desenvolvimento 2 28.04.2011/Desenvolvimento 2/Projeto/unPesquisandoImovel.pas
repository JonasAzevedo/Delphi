unit unPesquisandoImovel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, StdCtrls, plsEdit,
  ExtCtrls, Grids, DBGrids, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Provider, plsComboBox, unFuncoes;

type
  TfrmPesquisandoImovel = class(TfrmPesquisandoRegistro)
    zQryPesquisando: TZQuery;
    dspPesquisando: TDataSetProvider;
    plsCbBxCampoPesquisar: TPlsComboBox;
    zQryPesquisandoCODIGO: TIntegerField;
    zQryPesquisandoSTATUS: TSmallintField;
    zQryPesquisandoCOD_FK_TIPO_IMOVEL: TIntegerField;
    zQryPesquisandoCOD_FK_ESTADO: TIntegerField;
    zQryPesquisandoCOD_FK_CIDADE: TIntegerField;
    zQryPesquisandoSITUACAO_DESEJAVEL: TStringField;
    zQryPesquisandoVALOR_IMOVEL: TFloatField;
    zQryPesquisandoNOME_TIPO_IMOVEL: TStringField;
    zQryPesquisandoSIGLA_ESTADO: TStringField;
    zQryPesquisandoNOME_CIDADE: TStringField;
    zQryPesquisandoCC_CODIGO: TStringField;
    zQryPesquisandoCC_VALOR_IMOVEL: TStringField;
    cdsPesquisandoCODIGO: TIntegerField;
    cdsPesquisandoSTATUS: TSmallintField;
    cdsPesquisandoCOD_FK_TIPO_IMOVEL: TIntegerField;
    cdsPesquisandoCOD_FK_ESTADO: TIntegerField;
    cdsPesquisandoCOD_FK_CIDADE: TIntegerField;
    cdsPesquisandoSITUACAO_DESEJAVEL: TStringField;
    cdsPesquisandoVALOR_IMOVEL: TFloatField;
    cdsPesquisandoNOME_TIPO_IMOVEL: TStringField;
    cdsPesquisandoSIGLA_ESTADO: TStringField;
    cdsPesquisandoNOME_CIDADE: TStringField;
    cdsPesquisandoCC_CODIGO: TStringField;
    cdsPesquisandoCC_VALOR_IMOVEL: TStringField;
    plsCbBxValorPesquisa: TPlsComboBox;

    procedure plsCbBxCampoPesquisarChange(Sender: TObject);
    procedure plsCbBxValorPesquisaChange(Sender: TObject);
    procedure plsEdValorPesquisaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
  protected
    procedure selecionarTodosRegistros();
    procedure mostrarCampoValorPesquisa(psCampo: String);
    procedure popularComboBoxValorPesquisa(psCampo: String);
    procedure filtrarPesquisa(); override;
    procedure selecionouRegistro(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
  end;

var
  frmPesquisandoImovel: TfrmPesquisandoImovel;

const
  pCONST_CAMPO_TEXTO = 'sCampoTexto';
  pCONST_SITUACAO_DESEJAVEL = 'sSituacaoDesejavel';
  pCONST_SIM_NAO = 'sSimNao';

implementation

uses unCadImoveis, unConstantes, unDM;

{$R *.dfm}

{ TfrmPesquisandoImovel }

(* procedimentos de controle *)

procedure TfrmPesquisandoImovel.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_INICIAR_TELA)then
    selecionarTodosRegistros()

  else if(pTipo = PRM_PESQUISAR_REGISTRO)then
  begin
    {pValores[0] = parâmetro do campo da pesquisa
    pValores[1] = campo da pesquisa
    pValores[1] = valor da pesquisa
    }
    if (pValores[0] = PRM_PESQUISA_CODIGO)then
    begin
      Self.FsCampoPesquisa := pValores[1];
      plsCbBxCampoPesquisar.ItemIndex := 0;
      plsEdValorPesquisa.Text := pValores[2];
      filtrarPesquisa();
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      Self.configurarCaracteresAceitosPesquisa();
    end;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros();
end;

procedure TfrmPesquisandoImovel.filtrarPesquisa();
var
  sVlrPesquisa: String;
begin
  if((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME_TIPO_IMOVEL')or
  (Self.FsCampoPesquisa = 'SIGLA_ESTADO')or(Self.FsCampoPesquisa = 'NOME_CIDADE'))then
  begin
    if(plsEdValorPesquisa.Text <> STRING_INDEFINIDO)then
    begin
      cdsPesquisando.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisa.Text + '%');
      cdsPesquisando.Filtered := True;

      if(cdsPesquisando.RecordCount=0)then
      begin
        MessageDlg('Nenhum registro encontrado.',mtInformation,[mbOK],0);
        cdsPesquisando.Filter := STRING_INDEFINIDO;
        cdsPesquisando.Filtered := True;
        plsEdValorPesquisa.Clear;
      end;
    end;
  end
  else if(Self.FsCampoPesquisa = 'SITUACAO_DESEJAVEL')then
  begin
    if(plsCbBxValorPesquisa.ItemIndex <> -1)then
    begin
      cdsPesquisando.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsCbBxValorPesquisa.Text + '%');
      cdsPesquisando.Filtered := True;
      if(cdsPesquisando.RecordCount=0)then
      begin
        MessageDlg('Nenhum registro encontrado.',mtInformation,[mbOK],0);
        cdsPesquisando.Filter := STRING_INDEFINIDO;
        cdsPesquisando.Filtered := True;
        plsCbBxValorPesquisa.ItemIndex := -1;
      end;
    end;
  end
  else if(Self.FsCampoPesquisa = 'CC_VALOR_IMOVEL')then
  begin
    if(plsEdValorPesquisa.Text <> STRING_INDEFINIDO)then
    begin
      sVlrPesquisa := Self.FoFuncoes.retirarCaracteres(plsEdValorPesquisa.Text,',.');
      cdsPesquisando.Filter := Self.FsCampoPesquisa + ' LIKE ''%' + sVlrPesquisa + '%''';
      cdsPesquisando.Filtered := True;

      if(cdsPesquisando.RecordCount=0)then
      begin
        MessageDlg('Nenhum registro encontrado.',mtInformation,[mbOK],0);
        cdsPesquisando.Filter := STRING_INDEFINIDO;
        cdsPesquisando.Filtered := True;
        plsEdValorPesquisa.Clear;
      end;
    end;
  end
end;

procedure TfrmPesquisandoImovel.selecionouRegistro();
begin
  if(cdsPesquisando.Active)then
  begin
    if(Self.FoNomeFormChamou is TfrmCadImoveis)then
    begin
      (Self.FoNomeFormChamou as TfrmCadImoveis).passarParametro(PRM_PESQUISOU,null);
      (Self.FoNomeFormChamou as TfrmCadImoveis).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
    end;
    Self.Hide;
  end;
end;

procedure TfrmPesquisandoImovel.configurarCaracteresAceitosPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME_TIPO_IMOVEL')or(Self.FsCampoPesquisa = 'NOME_TIPO_IMOVEL')or
  (Self.FsCampoPesquisa = 'SIGLA_ESTADO')or(Self.FsCampoPesquisa = 'NOME_CIDADE'))then
    plsEdValorPesquisa.plsCaracteresAceitos := todos;

  if(Self.FsCampoPesquisa = 'CC_CODIGO')then
    plsEdValorPesquisa.plsCaracteresAceitos := numeros;

  if(Self.FsCampoPesquisa = 'CC_VALOR_IMOVEL') then
    plsEdValorPesquisa.plsCaracteresAceitos := monetario;
end;

procedure TfrmPesquisandoImovel.selecionarTodosRegistros();
  function inserirColunas(): String;
  var
    sql: String;
  begin
    sql := 'SELECT i.codigo,i.status,i.cod_fk_tipo_imovel,i.cod_fk_estado,';
    sql := sql + 'i.cod_fk_cidade,i.situacao_desejavel,i.valor_imovel,';
    sql := sql + 't_i.nome as nome_tipo_imovel,e.sigla as sigla_estado,c.nome as nome_cidade,';
    sql := sql + 'CAST(i.codigo AS VARCHAR(10))AS cc_codigo,';
    sql := sql + 'CAST(i.valor_imovel AS VARCHAR(20))AS cc_valor_imovel ';
    Result := sql;
  end;

  function inserirTabelas(): String;
  var
    sql: String;
  begin
    sql := sql + 'FROM imovel i ';
    Result := sql;
  end;

  function inserirCondicoes(): String;
  var
    sql: String;
  begin
    //JOIN poderia ser trocado por WHERE, para inserir table no inserirTabelas()
    sql := 'JOIN tipo_imovel t_i ON i.cod_fk_tipo_imovel=t_i.codigo ';
    sql := sql + 'JOIN estado e ON i.cod_fk_estado=e.codigo ';
    sql := sql + 'JOIN cidade c ON i.cod_fk_cidade=c.codigo ';
    sql := sql + Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('i');    
    Result := sql;
  end;

begin
  cdsPesquisando.Close;
  zQryPesquisando.Close;
  zQryPesquisando.SQL.Clear;
  zQryPesquisando.SQL.Add(inserirColunas);
  zQryPesquisando.SQL.Add(inserirTabelas);
  zQryPesquisando.SQL.Add(inserirCondicoes);
  zQryPesquisando.Open;
  cdsPesquisando.Open;
end;

procedure TfrmPesquisandoImovel.mostrarCampoValorPesquisa(psCampo: String);
begin
  if(psCampo = pCONST_CAMPO_TEXTO)then
  begin
    plsEdValorPesquisa.Visible := True;
    plsCbBxValorPesquisa.Visible := False;
    plsEdValorPesquisa.Clear;
  end
  else if(psCampo = pCONST_SITUACAO_DESEJAVEL)then
  begin
    plsEdValorPesquisa.Visible := False;
    plsCbBxValorPesquisa.Visible := True;
    popularComboBoxValorPesquisa(psCampo);
    plsCbBxValorPesquisa.ItemIndex := -1;
  end
  else if(psCampo = pCONST_SIM_NAO)then
  begin
    plsEdValorPesquisa.Visible := False;
    plsCbBxValorPesquisa.Visible := True;
    popularComboBoxValorPesquisa(psCampo);
    plsCbBxValorPesquisa.ItemIndex := -1;
  end;
end;

procedure TfrmPesquisandoImovel.popularComboBoxValorPesquisa(psCampo: String);
begin
  plsCbBxValorPesquisa.Items.Clear;
  if(psCampo = pCONST_SITUACAO_DESEJAVEL)then
  begin
    plsCbBxValorPesquisa.Items.Add('PLANTA');
    plsCbBxValorPesquisa.Items.Add('PRONTO PARA MORAR');
    plsCbBxValorPesquisa.Items.Add('DE TERCEIROS');
  end
  else if(psCampo = pCONST_SIM_NAO)then
  begin
    plsCbBxValorPesquisa.Items.Add('NÃO');
    plsCbBxValorPesquisa.Items.Add('SIM');
  end;
  //plsCbBxValorPesquisa
end;

(* fim - procedimentos de controle *)

procedure TfrmPesquisandoImovel.plsCbBxCampoPesquisarChange(
  Sender: TObject);
begin
  inherited;

  case plsCbBxCampoPesquisar.ItemIndex of
    0:
    begin
      Self.FsCampoPesquisa := 'CC_CODIGO';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisa.SetFocus;
    end;
    1:
    begin
      Self.FsCampoPesquisa := 'SITUACAO_DESEJAVEL';
      mostrarCampoValorPesquisa(pCONST_SITUACAO_DESEJAVEL);
      plsCbBxValorPesquisa.SetFocus;
    end;
    2:
    begin
      Self.FsCampoPesquisa := 'CC_VALOR_IMOVEL';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisa.SetFocus;
    end;
    3:
    begin
      Self.FsCampoPesquisa := 'NOME_TIPO_IMOVEL';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisa.SetFocus;
    end;
    4:
    begin
      Self.FsCampoPesquisa := 'SIGLA_ESTADO';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisa.SetFocus;
    end;
    5:
    begin
      Self.FsCampoPesquisa := 'NOME_CIDADE';
      mostrarCampoValorPesquisa(pCONST_CAMPO_TEXTO);
      plsEdValorPesquisa.SetFocus;
    end;
  end;
  configurarCaracteresAceitosPesquisa();
end;

procedure TfrmPesquisandoImovel.plsCbBxValorPesquisaChange(
  Sender: TObject);
begin
  inherited;
  //filtrarPesquisa();
end;

procedure TfrmPesquisandoImovel.plsEdValorPesquisaChange(Sender: TObject);
begin
  inherited;
  //filtrarPesquisa();
end;

procedure TfrmPesquisandoImovel.FormCreate(Sender: TObject);
begin
  inherited;
  FoFuncoes := TFuncoes.Create;
end;

procedure TfrmPesquisandoImovel.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FoFuncoes);
end;

end.


