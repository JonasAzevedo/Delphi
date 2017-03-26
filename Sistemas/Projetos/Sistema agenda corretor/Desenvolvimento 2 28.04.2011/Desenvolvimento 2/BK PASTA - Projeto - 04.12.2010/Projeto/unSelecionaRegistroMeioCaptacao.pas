unit unSelecionaRegistroMeioCaptacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, plsComboBox, plsEdit,
  ExtCtrls, Grids, DBGrids, unFuncoes;

type
  TfrmSelecionaRegistroMeioCaptacao = class(TfrmSelecionaRegistro)
    zqrySelecionarRegistroCODIGO: TIntegerField;
    zqrySelecionarRegistroNOME: TStringField;
    zqrySelecionarRegistroCC_CODIGO: TStringField;
    cdsSelecionarRegistroCODIGO: TIntegerField;
    cdsSelecionarRegistroNOME: TStringField;
    cdsSelecionarRegistroCC_CODIGO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure plsCbBxCampoPesquisarChange(Sender: TObject);
    procedure cdsSelecionarRegistroAfterScroll(DataSet: TDataSet);
    procedure plsEdValorPesquisarChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
    FiCodigo: integer;
    FsNome: string;
    FsCampoPesquisa: string;
  public
    procedure passarParametro(pTipo: String; pValores: OleVariant); override;
    procedure selecionarTodosRegistros(); override;
    procedure selecionouRegistro(); override;
    procedure filtrarPesquisa(); override;
    procedure configurarCaracteresAceitosPesquisa(); override;
    procedure inserirNovoRegistro(); override;    
  end;

var
  frmSelecionaRegistroMeioCaptacao: TfrmSelecionaRegistroMeioCaptacao;

implementation

uses unCadAgenciamento, unConstantes, unCadMeioCaptacao, unCadCliente,
  unCadPessoaJuridica, unCadPessoaFisica;

{$R *.dfm}

{ TfrmSelecionaRegistroMeioCaptacao }

{***** Minhas Procedures - inicio *****}

procedure TfrmSelecionaRegistroMeioCaptacao.passarParametro(pTipo: String; pValores: OleVariant);
var
  sCodMeioCaptacaoNovo: String;
begin
  inherited;

  if(pTipo = PRM_INSERIU_REGISTRO_AO_ESTAR_SELECIONANDO)then
  begin
    Self.selecionarTodosRegistros();
    if(MessageDlg('Selecionar o meio de captação que foi cadastrado?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
      sCodMeioCaptacaoNovo := pValores;
      cdsSelecionarRegistro.Locate('CODIGO', sCodMeioCaptacaoNovo, []);
      dbGrdDadosDblClick(Self);
    end;
  end;
end;

procedure TfrmSelecionaRegistroMeioCaptacao.filtrarPesquisa();
begin
  if((Self.FsCampoPesquisa = 'NOME')or(Self.FsCampoPesquisa = 'CC_CODIGO')) then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := true;
  end;

  if(cdsSelecionarRegistro.RecordCount=0)then
  begin
    MessageDlg('Nenhum registro encontrado.',mtInformation,[mbOK],0);
    cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
    cdsSelecionarRegistro.Filtered := true;
    plsEdValorPesquisar.Clear;
  end;
end;

procedure TfrmSelecionaRegistroMeioCaptacao.selecionarTodosRegistros();
begin
  cdsSelecionarRegistro.Filter := '';
  cdsSelecionarRegistro.Filtered := False;
  cdsSelecionarRegistro.Close;

  zQrySelecionarRegistro.Close;
  zQrySelecionarRegistro.SQL.Clear;
  zQrySelecionarRegistro.SQL.Add('SELECT codigo, nome, CAST(codigo AS VARCHAR(10)) AS cc_codigo ');
  zQrySelecionarRegistro.SQL.Add('FROM meio_captacao ');
  zQrySelecionarRegistro.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQrySelecionarRegistro.SQL.Add('ORDER BY nome');
  zQrySelecionarRegistro.Open;
  cdsSelecionarRegistro.Open;
  cdsSelecionarRegistro.First;
end;

procedure TfrmSelecionaRegistroMeioCaptacao.selecionouRegistro();
begin

  if(cdsSelecionarRegistro.Active)then
  begin
    if(Self.FiTelaChamou = FORM_CAD_CLIENTE)then //TfrmCadCliente
    begin
      frmCadCliente.FoMeioCaptacao.codigo := FiCodigo;
      frmCadCliente.FoMeioCaptacao.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_PESSOA_JURIDICA)then //TfrmCadPessoaJuridica
    begin
      frmCadPessoaJuridica.FoMeioCaptacao.codigo := FiCodigo;
      frmCadPessoaJuridica.FoMeioCaptacao.nome := FsNome;
    end
    else if(Self.FiTelaChamou = FORM_CAD_PESSOA_FISICA)then //TfrmCadPessoaFisica
    begin
      frmCadPessoaFisica.FoMeioCaptacao.codigo := FiCodigo;
      frmCadPessoaFisica.FoMeioCaptacao.nome := FsNome;
    end;
  end;

  inherited;
end;

procedure TfrmSelecionaRegistroMeioCaptacao.configurarCaracteresAceitosPesquisa();
begin
  if(Self.FsCampoPesquisa = 'NOME')then
    plsEdValorPesquisar.plsCaracteresAceitos := todos
  else if(Self.FsCampoPesquisa = 'CC_CODIGO') then
    plsEdValorPesquisar.plsCaracteresAceitos := numeros;
end;

procedure TfrmSelecionaRegistroMeioCaptacao.inserirNovoRegistro();
begin
  try
    Application.CreateForm(TfrmCadMeioCaptacao,frmCadMeioCaptacao);
    frmCadMeioCaptacao.iniciarTela(frmCadMeioCaptacao);
    frmCadMeioCaptacao.passarParametro(PRM_INSERE_REGISTRO_AO_ESTAR_SELECIONANDO, FORM_SELECIONA_REGISTRO_MEIO_CAPTACAO);
    frmCadMeioCaptacao.ShowModal;
  finally
    frmCadMeioCaptacao.Free;
  end;
end;

{***** Minhas Procedures - fim *****}

procedure TfrmSelecionaRegistroMeioCaptacao.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FiCodigo := NUMERO_INDEFINIDO;
  Self.FsNome := STRING_INDEFINIDO;
  Self.FoFuncoes := TFuncoes.Create;
  selecionarTodosRegistros();
end;

procedure TfrmSelecionaRegistroMeioCaptacao.plsCbBxCampoPesquisarChange(
  Sender: TObject);
begin
  inherited;
  Self.FsCampoPesquisa := STRING_INDEFINIDO; //default
  case plsCbBxCampoPesquisar.ItemIndex of
    0: Self.FsCampoPesquisa := 'CC_CODIGO';
    1: Self.FsCampoPesquisa := 'NOME';
  end;

  plsEdValorPesquisar.Clear;
  plsEdValorPesquisar.SetFocus;

  if(plsCbBxCampoPesquisar.ItemIndex = 0)then //código
    plsEdValorPesquisar.plsCaracteresAceitos := numeros
  else if(plsCbBxCampoPesquisar.ItemIndex = 1)then //nome
    plsEdValorPesquisar.plsCaracteresAceitos := todos;
end;

procedure TfrmSelecionaRegistroMeioCaptacao.cdsSelecionarRegistroAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  Self.FiCodigo := cdsSelecionarRegistroCODIGO.AsInteger;
  Self.FsNome := cdsSelecionarRegistroNOME.AsString;
end;

procedure TfrmSelecionaRegistroMeioCaptacao.plsEdValorPesquisarChange(
  Sender: TObject);
begin
  inherited;
  if ((Self.FsCampoPesquisa = 'CC_CODIGO')or(Self.FsCampoPesquisa = 'NOME'))then
  begin
    cdsSelecionarRegistro.Filter := Self.FsCampoPesquisa + ' LIKE ' + QuotedStr('%' + plsEdValorPesquisar.Text + '%');
    cdsSelecionarRegistro.Filtered := True;
    if(cdsSelecionarRegistro.RecordCount=0)then
    begin
      MessageDlg('Nenhum meio de captação encontrado.',mtInformation,[mbOK],0);
      selecionarTodosRegistros();
      plsEdValorPesquisar.Clear;
    end;
  end
  else
  //retira os filtro
  begin
    cdsSelecionarRegistro.Filter := STRING_INDEFINIDO;
    cdsSelecionarRegistro.Filtered := False;
  end;
end;

procedure TfrmSelecionaRegistroMeioCaptacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoFuncoes);
end;

end.
