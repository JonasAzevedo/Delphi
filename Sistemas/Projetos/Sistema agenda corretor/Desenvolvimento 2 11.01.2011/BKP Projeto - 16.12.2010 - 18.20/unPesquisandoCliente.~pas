(*
  cliente - pessoa física
*)
unit unPesquisandoCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, StdCtrls, plsEdit,
  ExtCtrls, Grids, DBGrids, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Provider, plsComboBox, unFuncoes;

type
  TfrmPesquisandoCliente = class(TfrmPesquisandoRegistro)
    dspPesquisando: TDataSetProvider;
    zQryPesquisando: TZQuery;
    zQryPesquisandoCODIGO: TIntegerField;
    zQryPesquisandoNOME: TStringField;
    zQryPesquisandoEMAIL: TStringField;
    zQryPesquisandoCPF: TStringField;
    zQryPesquisandoIDENTIDADE: TStringField;
    zQryPesquisandoDATA_NASCIMENTO: TDateField;
    zQryPesquisandoTELEFONE_RESIDENCIAL: TStringField;
    zQryPesquisandoTELEFONE_COMERCIAL: TStringField;
    zQryPesquisandoTELEFONE_CELULAR: TStringField;
    zQryPesquisandoCOD_FK_ESTADO: TIntegerField;
    zQryPesquisandoCOD_FK_CIDADE: TIntegerField;
    zQryPesquisandoSIGLA_ESTADO: TStringField;
    zQryPesquisandoNOME_CIDADE: TStringField;
    zQryPesquisandoCC_CODIGO: TStringField;
    cdsPesquisandoCODIGO: TIntegerField;
    cdsPesquisandoNOME: TStringField;
    cdsPesquisandoEMAIL: TStringField;
    cdsPesquisandoCPF: TStringField;
    cdsPesquisandoIDENTIDADE: TStringField;
    cdsPesquisandoDATA_NASCIMENTO: TDateField;
    cdsPesquisandoTELEFONE_RESIDENCIAL: TStringField;
    cdsPesquisandoTELEFONE_COMERCIAL: TStringField;
    cdsPesquisandoTELEFONE_CELULAR: TStringField;
    cdsPesquisandoCOD_FK_ESTADO: TIntegerField;
    cdsPesquisandoCOD_FK_CIDADE: TIntegerField;
    cdsPesquisandoSIGLA_ESTADO: TStringField;
    cdsPesquisandoNOME_CIDADE: TStringField;
    cdsPesquisandoCC_CODIGO: TStringField;
    plsCbBxCampoPesquisar: TPlsComboBox;
    procedure plsCbBxCampoPesquisarChange(Sender: TObject);
    procedure plsEdValorPesquisaChange(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
  protected
    procedure selecionarTodosRegistros();
    procedure filtrarPesquisa(); override;
    procedure selecionouRegistro(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
    procedure popularClientDataSetPesquisa(poDados: TClientDataSet); override;
    procedure atualizarPesquisando(psCampoPesquisa: string; psNomeCampo: string; psValor: string; poDados: TClientDataSet); override;
  end;

var
  frmPesquisandoCliente: TfrmPesquisandoCliente;

implementation

uses
  unConstantes, unDM, unCadCliente;

{$R *.dfm}

{ TfrmPesquisandoCliente }

(* procedimentos de controle *)

procedure TfrmPesquisandoCliente.passarParametro(pTipo:String; pValores:OleVariant);
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
      Self.configurarCaracteresAceitosPesquisa();
    end
    else if (pValores[0] = PRM_PESQUISA_NOME)then
    begin
      Self.FsCampoPesquisa := pValores[1];
      plsCbBxCampoPesquisar.ItemIndex := 1;
      plsEdValorPesquisa.Text := pValores[2];
      filtrarPesquisa();
      Self.configurarCaracteresAceitosPesquisa();
    end
    else if (pValores[0] = PRM_PESQUISA_CPF)then
    begin
      Self.FsCampoPesquisa := pValores[1];
      plsCbBxCampoPesquisar.ItemIndex := 2;
      plsEdValorPesquisa.Text := pValores[2];
      filtrarPesquisa();
      Self.configurarCaracteresAceitosPesquisa();
    end
    else if (pValores[0] = PRM_PESQUISA_IDENTIDADE)then
    begin
      Self.FsCampoPesquisa := pValores[1];
      plsCbBxCampoPesquisar.ItemIndex := 3;
      plsEdValorPesquisa.Text := pValores[2];
      filtrarPesquisa();
      Self.configurarCaracteresAceitosPesquisa();
    end;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros();
end;

procedure TfrmPesquisandoCliente.filtrarPesquisa();
var
  sVlrPesquisa: String;
begin
  if((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME')or
  (Self.FsCampoPesquisa = 'CPF')or(Self.FsCampoPesquisa = 'IDENTIDADE')or
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
end;

procedure TfrmPesquisandoCliente.selecionouRegistro();
begin
  if(cdsPesquisando.Active)then
  begin
    if(Self.FoNomeFormChamou is TfrmCadCliente)then
    begin
      (Self.FoNomeFormChamou as TfrmCadCliente).passarParametro(PRM_PESQUISOU,null);
      (Self.FoNomeFormChamou as TfrmCadCliente).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
    end;
    Self.Hide;
  end;
end;

procedure TfrmPesquisandoCliente.configurarCaracteresAceitosPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CPF')or
  (Self.FsCampoPesquisa = 'IDENTIDADE')or(Self.FsCampoPesquisa = 'SIGLA_ESTADO')or
  (Self.FsCampoPesquisa = 'NOME_CIDADE'))then
    plsEdValorPesquisa.plsCaracteresAceitos := todos;

  if((Self.FsCampoPesquisa = 'CC_CODIGO'))then
    plsEdValorPesquisa.plsCaracteresAceitos := numeros;
end;

procedure TfrmPesquisandoCliente.selecionarTodosRegistros();
var
  sql: String;
begin
  cdsPesquisando.IndexName := '';
  sql := 'SELECT c.codigo,c.nome,c.email,c.cpf,c.identidade,c.data_nascimento,';
  sql := sql  + 'c.telefone_residencial,c.telefone_comercial,c.telefone_celular,';
  sql := sql  + 'c.cod_fk_estado,c.cod_fk_cidade,est.sigla as sigla_estado,';
  sql := sql  + 'cid.nome as nome_cidade,CAST(c.codigo AS VARCHAR(10))AS cc_codigo ';
  sql := sql  + 'FROM cliente_pessoa_fisica c ';
  sql := sql  + 'JOIN estado est ON c.cod_fk_estado=est.codigo ';
  sql := sql  + 'JOIN cidade cid ON c.cod_fk_cidade=cid.codigo';
  sql := sql + Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('c');
  cdsPesquisando.Close;
  zQryPesquisando.Close;
  zQryPesquisando.SQL.Clear;
  zQryPesquisando.SQL.Add(sql);
  zQryPesquisando.Open;
  cdsPesquisando.Open;
end;

procedure TfrmPesquisandoCliente.popularClientDataSetPesquisa(poDados: TClientDataSet);
begin

end;

procedure TfrmPesquisandoCliente.atualizarPesquisando(psCampoPesquisa: string;
 psNomeCampo: string; psValor: string; poDados: TClientDataSet);
begin

end;

(* fim - procedimentos de controle *)

procedure TfrmPesquisandoCliente.plsCbBxCampoPesquisarChange(
  Sender: TObject);
begin
  inherited;

  case plsCbBxCampoPesquisar.ItemIndex of
    0:
    begin
      Self.FsCampoPesquisa := 'CC_CODIGO';
      plsEdValorPesquisa.SetFocus;
    end;
    1:
    begin
      Self.FsCampoPesquisa := 'NOME';
      plsEdValorPesquisa.SetFocus;
    end;
    2:
    begin
      Self.FsCampoPesquisa := 'CPF';
      plsEdValorPesquisa.SetFocus;
    end;
    3:
    begin
      Self.FsCampoPesquisa := 'IDENTIDADE';
      plsEdValorPesquisa.SetFocus;
    end;
    4:
    begin
      Self.FsCampoPesquisa := 'SIGLA_ESTADO';
      plsEdValorPesquisa.SetFocus;
    end;
    5:
    begin
      Self.FsCampoPesquisa := 'NOME_CIDADE';
      plsEdValorPesquisa.SetFocus;
    end;
  end;
  configurarCaracteresAceitosPesquisa();
end;

procedure TfrmPesquisandoCliente.plsEdValorPesquisaChange(Sender: TObject);
begin
  inherited;
//  filtrarPesquisa(); //herança
end;

end.
