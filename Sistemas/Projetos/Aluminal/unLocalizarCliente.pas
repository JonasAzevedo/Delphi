unit unLocalizarCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unLocalizar, Grids, BaseGrid, AdvGrid, DBAdvGrid, ExtCtrls,
  StdCtrls, plsEdit, plsComboBox, DB, DBClient, Provider,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ComCtrls, DBGrids;

type
  TfrmLocalizarCliente = class(TfrmLocalizar)
    zQryDadosCODIGO: TIntegerField;
    zQryDadosDATA_CADASTRO: TDateTimeField;
    zQryDadosNOME: TStringField;
    zQryDadosCPF: TStringField;
    zQryDadosIDENTIDADE: TStringField;
    zQryDadosCNPJ: TStringField;
    zQryDadosDATA_NASCIMENTO: TDateField;
    zQryDadosPROFISSAO: TStringField;
    zQryDadosEMAIL: TStringField;
    zQryDadosTELEFONE_1: TStringField;
    zQryDadosTELEFONE_2: TStringField;
    zQryDadosESTADO: TStringField;
    zQryDadosCIDADE: TStringField;
    zQryDadosBAIRRO: TStringField;
    zQryDadosRUA: TStringField;
    zQryDadosNUMERO: TIntegerField;
    zQryDadosCEP: TStringField;
    zQryDadosCOMPLEMENTO: TStringField;
    zQryDadosCC_CODIGO: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosDATA_CADASTRO: TDateTimeField;
    cdsDadosNOME: TStringField;
    cdsDadosCPF: TStringField;
    cdsDadosIDENTIDADE: TStringField;
    cdsDadosCNPJ: TStringField;
    cdsDadosDATA_NASCIMENTO: TDateField;
    cdsDadosPROFISSAO: TStringField;
    cdsDadosEMAIL: TStringField;
    cdsDadosTELEFONE_1: TStringField;
    cdsDadosTELEFONE_2: TStringField;
    cdsDadosESTADO: TStringField;
    cdsDadosCIDADE: TStringField;
    cdsDadosBAIRRO: TStringField;
    cdsDadosRUA: TStringField;
    cdsDadosNUMERO: TIntegerField;
    cdsDadosCEP: TStringField;
    cdsDadosCOMPLEMENTO: TStringField;
    cdsDadosCC_CODIGO: TStringField;
    procedure cbBxCampoLocalizarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure FecharTela; override;
    procedure SelecionarTodosDados; override;
    procedure DefinirCampoPesquisar(psCampo: string); override;
    procedure LocalizarRegistroParte; override;
    procedure DefinirTextoStatusBar(pnPanel: integer; psTexto: string); override;
    procedure EnviarOutrosParametrosRetornarSelecao; override;
    procedure configurarCaracteresAceitosPesquisa; override;
    procedure DefinirDataSetRetornaSelecao; override;
  public
    procedure PassaParametro(const psParametro: string; const pvValor: OleVariant); override;  
  end;

implementation

uses unDM, unConstantes, unFrmBasico;

{$R *.dfm}

{ TfrmLocalizarCliente }

procedure TfrmLocalizarCliente.FecharTela;
begin
  Self.Hide;
end;

procedure TfrmLocalizarCliente.SelecionarTodosDados;
begin
  inherited;
  cdsDados.Close;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT c.*, CAST(c.codigo AS VARCHAR(10)) AS cc_codigo ');
  zQryDados.SQL.Add('FROM cliente c ');
  zQryDados.SQL.Add('ORDER BY c.nome');
  zQryDados.Open;
  cdsDados.Open;
end;

procedure TfrmLocalizarCliente.DefinirCampoPesquisar(psCampo: string);
begin
  if (GetCampoPesquisar = 'cc_codigo') then
    cbBxCampoLocalizar.ItemIndex := 0
  else if (GetCampoPesquisar = 'nome') then
    cbBxCampoLocalizar.ItemIndex := 1
  else if (GetCampoPesquisar = 'cpf') then
    cbBxCampoLocalizar.ItemIndex := 2
  else if (GetCampoPesquisar = 'identidade') then
    cbBxCampoLocalizar.ItemIndex := 3
  else if (GetCampoPesquisar = 'cnpj') then
    cbBxCampoLocalizar.ItemIndex := 4
  else
    cbBxCampoLocalizar.ItemIndex := -1;
end;

procedure TfrmLocalizarCliente.LocalizarRegistroParte;
begin
  inherited;
  if GetCampoPesquisar = STRING_INDEFINIDO then
  begin
    FoCdsRetornaSelecao.Filter := STRING_INDEFINIDO;
    FoCdsRetornaSelecao.Filtered := False;
    Exit;
  end;

  FoCdsRetornaSelecao.Filter := GetCampoPesquisar + ' LIKE ' + QuotedStr('%' + edLocalizar.Text + '%');
  FoCdsRetornaSelecao.Filtered := True;


  if (FbLocalizarRegistroRapido) and (FoCdsRetornaSelecao.RecordCount = 1)then
  begin
    RetornarSelecao;
    Close;
  end
  else if(FoCdsRetornaSelecao.RecordCount = 0)then
  begin
    FbLocalizarRegistroRapido := False;
    DefinirTextoStatusBar(0, 'NENHUM CLIENTE ENCONTRADO');
    SelecionarTodosDados;
      FoFuncoes.focarComponente(edLocalizar);
  end
  else
  begin
    FbLocalizarRegistroRapido := False;
    DefinirTextoStatusBar(0, 'Clientes: ' + IntToStr(FoCdsRetornaSelecao.RecordCount));
  end;
end;

procedure TfrmLocalizarCliente.DefinirTextoStatusBar(pnPanel: integer; psTexto: string); 
begin
  StatusBar.Panels.Items[pnPanel].Text := psTexto;
end;

procedure TfrmLocalizarCliente.EnviarOutrosParametrosRetornarSelecao;
begin
end;

procedure TfrmLocalizarCliente.configurarCaracteresAceitosPesquisa;
begin
  if (GetCampoPesquisar = 'cc_codigo') then
    edLocalizar.plsCaracteresAceitos := numeros
  else if (GetCampoPesquisar = 'nome') then
    edLocalizar.plsCaracteresAceitos := todos
  else if (GetCampoPesquisar = 'cpf') then
    edLocalizar.plsCaracteresAceitos := todos
  else if (GetCampoPesquisar = 'identidade') then
    edLocalizar.plsCaracteresAceitos := todos
  else if (GetCampoPesquisar = 'cnpj') then
    edLocalizar.plsCaracteresAceitos := todos
  else
    edLocalizar.plsCaracteresAceitos := todos
end;

procedure TfrmLocalizarCliente.DefinirDataSetRetornaSelecao;
begin
  FoCdsRetornaSelecao := cdsDados;
end;

procedure TfrmLocalizarCliente.cbBxCampoLocalizarChange(Sender: TObject);
begin
  inherited;

  case cbBxCampoLocalizar.ItemIndex of
    0: SetCampoPesquisar('cc_codigo');
    1: SetCampoPesquisar('nome');
    2: SetCampoPesquisar('cpf');
    3: SetCampoPesquisar('identidade');
    4: SetCampoPesquisar('cnpj');
    else SetCampoPesquisar(STRING_INDEFINIDO);
  end;
end;

procedure TfrmLocalizarCliente.FormCreate(Sender: TObject);
begin
  inherited;
  DefinirTextoStatusBar(0, STRING_INDEFINIDO);
  FsTipoLocalizar := sLOCALIZAR_CLIENTE;
end;

procedure TfrmLocalizarCliente.PassaParametro(const psParametro: string; const pvValor: OleVariant);
begin
  inherited;
end;

end.
