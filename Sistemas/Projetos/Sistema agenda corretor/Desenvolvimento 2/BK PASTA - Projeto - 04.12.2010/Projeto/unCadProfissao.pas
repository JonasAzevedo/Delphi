unit unCadProfissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, AppEvnts, ImgList, ComCtrls, ToolWin,
  StdCtrls, plsEdit, unObjProfissao;

type
  TfrmCadProfissao = class(TfrmCadastroBasico)
    zQryDadosCODIGO: TIntegerField;
    zQryDadosNOME: TStringField;
    cdsDadosCODIGO: TIntegerField;
    cdsDadosNOME: TStringField;
    plsEdCodigo: TPlsEdit;
    Label1: TLabel;
    Label2: TLabel;
    plsEdNome: TPlsEdit;
    lblCampoObrigatorio1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure plsEdCodigoExit(Sender: TObject);
    procedure plsEdNomeExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure plsEdNomeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FoProfissao: TObjProfissao;

    procedure carregarObjeto(); override;
    procedure carregarComponentesApresentacao(); override;
    procedure selecionarTodosDados(); override;
    procedure limparObjeto(); override;
    procedure limparTela(poForm: TForm); override;
    function verificarHouveAlteracoes(): boolean; override;
    function verificarCamposObrigatorios(): boolean; override;
    function verificarRegistroJaExiste(): boolean; override;
    function verificarPodeDeletar(): boolean; override;
    procedure visibilidade(pnVisib: Integer); override;
    procedure novo(); override;
    function salvar(): Boolean; override;
    function excluir(): Boolean; override;
  public
    procedure iniciarTela(poForm: TForm); override;
    procedure realizouPesquisa(piCodigo: Integer); override;
  end;

var
  frmCadProfissao: TfrmCadProfissao;

implementation

uses unConstantes, unPesquisandoProfissao, unDM;

{$R *.dfm}

{ TfrmCadProfissao }

(* procedimentos de controle *)

procedure TfrmCadProfissao.iniciarTela(poForm: TForm);
begin
  inherited;
  Application.CreateForm(TfrmPesquisandoProfissao, Self.FoPesquisa);
  Self.FoPesquisa.iniciarTela(frmCadProfissao);
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadProfissao.limparObjeto();
begin
  if (Assigned(Self.FoProfissao)) then
  begin
    Self.FoProfissao.setCodigo(NUMERO_INDEFINIDO);
    Self.FoProfissao.setNome(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadProfissao.limparTela(poForm: TForm);
begin
  inherited;              
end;

procedure TfrmCadProfissao.carregarObjeto();
begin
  if ((cdsDados.Active) and (Assigned(Self.FoProfissao))) then
  begin
    Self.FoProfissao.setCodigo(cdsDadosCODIGO.AsInteger);
    Self.FoProfissao.setNome(cdsDadosNOME.AsString);
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadProfissao.carregarObjeto();','Acesso Indisponível');
  end;
end;

procedure TfrmCadProfissao.carregarComponentesApresentacao();
begin
  if(Assigned(Self.FoProfissao))then
  begin
    if(Self.FoProfissao.getCodigo <> 0)then
      plsEdCodigo.Text := IntToStr(Self.FoProfissao.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdNome.Text := Self.FoProfissao.getNome;
  end;
end;

procedure TfrmCadProfissao.selecionarTodosDados();
begin
  cdsDados.Filter := '';
  cdsDados.Filtered := False;
  cdsDados.Close;
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM profissao ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY nome');
  zQryDados.Open;
  cdsDados.Open;
  cdsDados.First;
end;

function TfrmCadProfissao.verificarHouveAlteracoes(): boolean;
var
  sNome: String;
  bAlteracao: Boolean;
begin
  sNome := Trim(plsEdNome.Text);
  try
    bAlteracao := Self.FoProfissao.verificarDiferencaCadastro(sNome);
  except
    bAlteracao := True;
  end;

  Result := bAlteracao;
end;

function TfrmCadProfissao.verificarCamposObrigatorios(): boolean;
var
  bRetorno: Boolean;
  compFoco: TWinControl;
  campos: string;
  sAux: string;
begin
  bRetorno := True;
  compFoco := nil;
  campos := '';
  sAux := '';

  if(Trim(plsEdNome.Text) = '')then
  begin
    campos := 'Nome';
    compFoco := plsEdNome;
  end;

  if(campos <> '')then
  begin
    MessageDlg('Antes de salvar, verifique os campos: ' + campos + '.', mtInformation, [mbOK], 0);
    bRetorno := False;
  end;

  //setar foco no componente que não foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;

function TfrmCadProfissao.verificarRegistroJaExiste(): boolean;
begin
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM profissao WHERE nome=:nom');
  //se estiver editando, pode salvar com os mesmos dados
  if(Self.FoProfissao.getCodigo <> NUMERO_INDEFINIDO)then
  begin
    zQryDados.SQL.Add(' AND codigo <> :cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoProfissao.getCodigo;
  end;
  zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
  zQryDados.Open;
  if(zQryDados.RecordCount <> 0)then
  begin
    Result := True;
    MessageDlg('Profissão já cadastrada.', mtWarning, [mbOK], 0);
    plsEdNome.SetFocus;
  end
  else
    Result := False;
end;

function TfrmCadProfissao.verificarPodeDeletar(): boolean;
var
  bPodeDeletar: Boolean;
begin
  bPodeDeletar := True;

  Result := bPodeDeletar;
end;      

procedure TfrmCadProfissao.visibilidade(pnVisib: Integer);
begin
  inherited;
  case pnVisib of
    OPC_TELA_INICIO: begin
                       plsEdCodigo.Enabled := True;
                       plsEdNome.Enabled := True;
                       plsEdCodigo.SetFocus;
                     end;
    OPC_NOVO:        begin
                       plsEdCodigo.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsEdNome.SetFocus;
                     end;
    OPC_EDITAR:      begin
                       plsEdCodigo.Enabled := False;
                       plsEdNome.Enabled := True;
                       plsEdNome.SetFocus;
                     end;
    OPC_SALVAR:      begin

                     end;
    OPC_EXCLUIR:     begin

                     end;
    OPC_CANCELAR:    begin

                     end;
    OPC_PESQUISOU:   begin
                       plsEdCodigo.Enabled := True;
                       plsEdNome.Enabled := True;
                     end;
  end; //fim - case

end;

procedure TfrmCadProfissao.novo();
begin
  inherited;
  limparObjeto();
  limparTela(frmCadProfissao);
  visibilidade(OPC_NOVO);
end;

function TfrmCadProfissao.salvar(): boolean;
var
  bSalvou: boolean;
begin
  bSalvou := False;

  if(Self.FiFuncaoRegistro in [FUNCAO_REGISTRO_EDITAR, FUNCAO_REGISTRO_NOVO]) then
  begin
    inherited;
    if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR) then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('UPDATE profissao SET nome=:nom ');
        zQryDados.SQL.Add('WHERE codigo=:cod');
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ParamByName('cod').AsInteger := Self.FoProfissao.getCodigo();
        zQryDados.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
      except
        DM.ZConnection.Rollback;
      end;

    end
    else if (Self.FiFuncaoRegistro = FUNCAO_REGISTRO_NOVO) then
    begin
      try
        DM.ZConnection.StartTransaction;
        zQryDados.Close;
        zQryDados.SQL.Clear;
        zQryDados.SQL.Add('INSERT INTO profissao (nome) ');
        zQryDados.SQL.Add('VALUES (:nom)');
        zQryDados.ParamByName('nom').AsString := Trim(plsEdNome.Text);
        zQryDados.ExecSQL();
        DM.ZConnection.Commit;
        bSalvou := True;
      except
        DM.ZConnection.Rollback;
      end;
    end;
  end;

  Result := bSalvou;
end;

function TfrmCadProfissao.excluir(): Boolean;
var
  bDeletou: boolean;
begin
  bDeletou := False;

  try
    DM.ZConnection.StartTransaction;
    zQryDados.Close;
    zQryDados.SQL.Clear;
    zQryDados.SQL.Add('DELETE FROM profissao WHERE codigo=:cod');
    zQryDados.ParamByName('cod').AsInteger := Self.FoProfissao.getCodigo();
    zQryDados.ExecSQL();
    DM.ZConnection.Commit;
    bDeletou := True;
  except
    DM.ZConnection.Rollback;
  end;

  Result := bDeletou;
end;

procedure TfrmCadProfissao.realizouPesquisa(piCodigo: Integer);
begin
  if(cdsDados.Locate('codigo',piCodigo,[]))then
  begin
    visibilidade(OPC_PESQUISOU); //poderia ser na tela pai
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadProfissao.FormCreate(Sender: TObject);
begin
  inherited;
  Self.FoProfissao := TObjProfissao.Create;
end;

procedure TfrmCadProfissao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self.FoProfissao);
end;

procedure TfrmCadProfissao.tlBtnNovoClick(Sender: TObject);
begin
  inherited;
  //Self.novo;
end;

procedure TfrmCadProfissao.tlBtnEditarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_EDITAR);
end;

procedure TfrmCadProfissao.tlBtnSalvarClick(Sender: TObject);
begin
  inherited;
  // Self.salvar();
end;

procedure TfrmCadProfissao.tlBtnExcluirClick(Sender: TObject);
begin
  inherited;
  // Self.excluir();
end;

procedure TfrmCadProfissao.tlBtnCancelarClick(Sender: TObject);
begin
  inherited;
  // visibilidade(OPC_CANCELAR);
end;

procedure TfrmCadProfissao.plsEdCodigoExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadProfissao.plsEdNomeExit(Sender: TObject);
begin
  inherited;
  if(Assigned(Self.FoPesquisa))then
    Self.FoPesquisa.Hide;
end;

procedure TfrmCadProfissao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmCadProfissao.plsEdCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sValor: string;
begin
  inherited;
  if (Key in[48,49,50,51,52,53,54,55,56,57,8])then //48..57 = números - 8 = backspace
  begin
    if (Self.FbPodePesquisar) then
    begin
      if(Key=27)then //esc
      begin
        if(Assigned(Self.FoPesquisa))then
          Self.FoPesquisa.Hide;
      end
      else
      begin
        sValor := plsEdCodigo.Text;
        Self.FoPesquisa.atualizarPesquisando('CC_CODIGO', 'Código:', sValor, cdsDados);
        Self.FoPesquisa.Show;
      end;
    end;
  end;
end;

procedure TfrmCadProfissao.plsEdNomeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sValor: string;
begin
  inherited;
  if (Self.FbPodePesquisar) then
  begin
    if(Key=27)then //esc
    begin
      if(Assigned(Self.FoPesquisa))then
        Self.FoPesquisa.Hide;
    end
    else
    begin
      sValor := plsEdNome.Text;
      sValor := UpperCase(sValor);
      Self.FoPesquisa.atualizarPesquisando('NOME', 'Nome:', sValor, cdsDados);
      Self.FoPesquisa.Show;
    end;
  end;
end;


end.
