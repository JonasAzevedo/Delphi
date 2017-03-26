unit unPesquisandoPessoaJuridica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unPesquisandoRegistro, DB, DBClient, StdCtrls, plsEdit,
  ExtCtrls, Grids, DBGrids, unFuncoes, plsComboBox, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Provider;

type
  TfrmPesquisandoPessoaJuridica = class(TfrmPesquisandoRegistro)
    dspPesquisando: TDataSetProvider;
    zQryPesquisando: TZQuery;
    zQryPesquisandoCODIGO: TIntegerField;
    zQryPesquisandoNOME: TStringField;
    zQryPesquisandoEMAIL: TStringField;
    zQryPesquisandoCNPJ: TStringField;
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
    cdsPesquisandoCNPJ: TStringField;
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
  frmPesquisandoPessoaJuridica: TfrmPesquisandoPessoaJuridica;

implementation

uses unConstantes, unDM, unCadPessoaJuridica;

{$R *.dfm}

{ TfrmPesquisandoPessoaJuridica }

(* procedimentos de controle *)

procedure TfrmPesquisandoPessoaJuridica.passarParametro(pTipo:String; pValores:OleVariant);
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
    else if (pValores[0] = PRM_PESQUISA_CNPJ)then
    begin
      Self.FsCampoPesquisa := pValores[1];
      plsCbBxCampoPesquisar.ItemIndex := 2;
      plsEdValorPesquisa.Text := pValores[2];
      filtrarPesquisa();
      Self.configurarCaracteresAceitosPesquisa();
    end;
  end

  else if(pTipo = PRM_SELECIONAR_TODOS_REGISTROS)then
    Self.selecionarTodosRegistros();
end;

procedure TfrmPesquisandoPessoaJuridica.filtrarPesquisa();
var
  sVlrPesquisa: String;
begin
  if((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME')or
  (Self.FsCampoPesquisa = 'CNPJ'))then
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

procedure TfrmPesquisandoPessoaJuridica.selecionouRegistro();
begin
  if(cdsPesquisando.Active)then
  begin
    if(Self.FoNomeFormChamou is TfrmCadPessoaJuridica)then
      (Self.FoNomeFormChamou as TfrmCadPessoaJuridica).realizouPesquisa(cdsPesquisandoCODIGO.AsInteger);
    Self.Hide;
  end;
end;

procedure TfrmPesquisandoPessoaJuridica.configurarCaracteresAceitosPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CNPJ'))then
    plsEdValorPesquisa.plsCaracteresAceitos := todos;

  if((Self.FsCampoPesquisa = 'CC_CODIGO'))then
    plsEdValorPesquisa.plsCaracteresAceitos := numeros;
end;

procedure TfrmPesquisandoPessoaJuridica.selecionarTodosRegistros();
var
  sql: String;
begin
  cdsPesquisando.IndexName := '';
  sql := 'SELECT p.codigo,p.nome,p.email,p.cnpj,p.telefone_residencial,';
  sql := sql + 'p.telefone_comercial,p.telefone_celular,p.cod_fk_estado,';
  sql := sql + 'p.cod_fk_cidade,e.sigla as sigla_estado,c.nome as nome_cidade,';
  sql := sql + 'CAST(p.codigo AS VARCHAR(10))AS cc_codigo ';
  sql := sql + 'FROM pessoa_juridica p ';
  sql := sql + 'JOIN estado e ON p.cod_fk_estado=e.codigo ';
  sql := sql + 'JOIN cidade c ON p.cod_fk_cidade=c.codigo';
  sql := sql + Self.FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo('p');  
  cdsPesquisando.Close;
  zQryPesquisando.Close;
  zQryPesquisando.SQL.Clear;
  zQryPesquisando.SQL.Add(sql);
  zQryPesquisando.Open;
  cdsPesquisando.Open;
end;

procedure TfrmPesquisandoPessoaJuridica.popularClientDataSetPesquisa(poDados: TClientDataSet);
begin

end;

procedure TfrmPesquisandoPessoaJuridica.atualizarPesquisando(psCampoPesquisa: string;
 psNomeCampo: string; psValor: string; poDados: TClientDataSet);
begin

end;

(* fim - procedimentos de controle *)

procedure TfrmPesquisandoPessoaJuridica.plsCbBxCampoPesquisarChange(
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
      Self.FsCampoPesquisa := 'CNPJ';
      plsEdValorPesquisa.SetFocus;
    end;
    3:
    begin
      Self.FsCampoPesquisa := 'SIGLA_ESTADO';
      plsEdValorPesquisa.SetFocus;
    end;
    4:
    begin
      Self.FsCampoPesquisa := 'NOME_CIDADE';
      plsEdValorPesquisa.SetFocus;
    end;
  end;
  configurarCaracteresAceitosPesquisa();
end;


procedure TfrmPesquisandoPessoaJuridica.plsEdValorPesquisaChange(
  Sender: TObject);
begin
  inherited;
  //filtrarPesquisa(); //herança
end;

end.
